#include "uart.h"
#include "spi.h"
#include "sd.h"
#include "gpt.h"
#include "gpio.h"


int main()
{
    volatile int i;
   
    volatile uint64_t a=0xAA;
    
    volatile uint64_t cycles0,cycles1,dif_cycles;
    
    volatile uint64_t value1,value2;
    volatile uint8_t sum=0;
    
 
    volatile uint8_t max,pos,ok;
    
   
    
    
    init_uart(50000000, 115200);
    print_uart("Hello World!\r\n");
    

    
    init_gpio();
    
    while (1)
    {
	    	
		//count_ones
		value1=0x7777777777777777;
		sum=0;
		__asm__ volatile("csrrc x20,0xB00,x0;");	
		while(value1>0)
	    	{
			sum=sum+(value1 & 0x1);
	       		value1=value1>>1;
	    	}
	    	__asm__ volatile("csrrc x21,0xB00,x0;"
	    			  "sub x20,x21,x20;"
	    			  "sd x20,%[ptr];": [ptr] "=m" (cycles0));
	    			  
	      
				
		__asm__ volatile (
	  			  "li x9,0x7777777777777777;"
	  			  "csrrc x22,0xB00,x0;"
	  			  ".insn r 0x5B, 0, 0, x19, x9, x18;"
	  			  "csrrc x23,0xB00,x0;"
	  			  "sub x22,x23,x22;"
	  			  "divu x24,x20,x22;"
	  			  "sd x22,%[ptr0];"
	  			  "sd x24,%[ptr1];"
	  			  "sd x19,%[ptr2];" : [ptr0] "=m" (cycles1) , [ptr1] "=m" (dif_cycles) , [ptr2] "=m" (a) );
	  	
	       print_uart("\r\nINSTRUCTIUNE: count_ones \r\n");
	       print_uart("Raspuns cod C: ");
	       print_uart_byte(sum);
	       print_uart("\r\nNr. cicli cod C: ");
	       print_uart_addr(cycles0);
	       print_uart("\r\nRaspuns instructiune: ");
	       print_uart_byte(a);
	       print_uart("\r\nNr. cicli instructiune: ");
	       print_uart_addr(cycles1);
	       print_uart("\r\nRaport cicli: ");
	       print_uart_addr(dif_cycles);
	       
	       
	       
	       //max
	       
	       value1=0xFFFEFDFCFBFAF9F8;
	       __asm__ volatile("csrrc x20,0xB00,x0;");
	       max=(value1 & 0xFF);
	       value1>>=8;
	       while(value1>0)
	       {
	           if((value1 & 0xFF) > max)
	           {
	           	max=value1 & 0xFF;
	           }
	           value1>>=8;
	       }
	       __asm__ volatile("csrrc x21,0xB00,x0;"
	    			  "sub x20,x21,x20;"
	    			  "sd x20,%[ptr];": [ptr] "=m" (cycles0));
	    			  
	       __asm__ volatile (
	  			  "li x9,0xFFFEFDFCFBFAF9F8;"
	  			  "li x18,0x00;"
	  			  "csrrc x22,0xB00,x0;"
	  			  ".insn r 0x0B, 0, 0, x19, x9, x18;"
	  			  "csrrc x23,0xB00,x0;"
	  			  "sub x22,x23,x22;"
	  			  "divu x24,x20,x22;"
	  			  "sd x22,%[ptr0];"
	  			  "sd x24,%[ptr1];"
	  			  "sd x19,%[ptr2];" : [ptr0] "=m" (cycles1) , [ptr1] "=m" (dif_cycles) , [ptr2] "=m" (a));
	  			 
	       print_uart("\r\nINSTRUCTIUNE: max8b \r\n");
	       print_uart("Raspuns cod C: ");
	       print_uart_byte(max);
	       print_uart("\r\nRaspuns instructiune: ");
	       print_uart_byte(a);
	       print_uart("\r\nNr. cicli cod C: ");
	       print_uart_addr(cycles0);
	       print_uart("\r\nNr. cicli instructiune: ");
	       print_uart_addr(cycles1);
	       print_uart("\r\nRaport cicli: ");
	       print_uart_addr(dif_cycles);
	       print_uart("\r\n");
	      
	       	
	       	
	       	//prima aparitie
	       
	       pos=63;
	       ok=0;
	       value1=0x0000000000000001;
	       
	       value2=0x8000000000000000;
	       
	       __asm__ volatile("csrrc x20,0xB00,x0;");
	       while(ok==0 && value2>0)
	       {
	       	   if((value2 & value1) == 1)
	       	   {
	       	   	ok=1;
	       	   }
	       	   else
	       	   {
	       	       value2>>=1;
	       	       pos--;
	       	   }
	       }
	       
	       
	       
	       __asm__ volatile("csrrc x21,0xB00,x0;"
	    			  "sub x20,x21,x20;"
	    			  "sd x20,%[ptr];": [ptr] "=m" (cycles0));
	    			  
		print_uart("\r\n Cod C OK \r\n");
		
	       __asm__ volatile (
	  			  "li x9,1;"
	  			  "csrrc x22,0xB00,x0;"
	  			  ".insn r 0x2B, 0, 0, x19, x9, x18;"
	  			  "csrrc x23,0xB00,x0;"
	  			  "sub x22,x23,x22;"
	  			  "divu x24,x20,x22;"
	  			  "sd x22,%[ptr0];"
	  			  "sd x24,%[ptr1];"
	  			  "sd x19,%[ptr2];" : [ptr0] "=m" (cycles1) , [ptr1] "=m" (dif_cycles) , [ptr2] "=m" (a));
	       print_uart("INSTRUCTIUNE: prima aparitie \r\n");
	       print_uart("Raspuns cod C: ");
	       print_uart_byte(pos);
	       print_uart("\r\nRaspuns instructiune: ");
	       print_uart_byte(a);
	       print_uart("\r\nNr. cicli cod C: ");
	       print_uart_addr(cycles0);
	       print_uart("\r\nNr. cicli instructiune: ");
	       print_uart_addr(cycles1);
	       print_uart("\r\nRaport cicli: ");
	       print_uart_addr(dif_cycles);
	       	
	       	
	       	
	       	write_gpio(GPIO_BASE,a & 0xFF);
	    	for(i=5000000;i>0;i--);
	    	write_gpio(GPIO_BASE,0xFF);
	    	for(i=5000000;i>0;i--);
	       	
	}
  			  
         		
}

void handle_trap(void)
{
    // print_uart("trap\r\n");
}

#include "uart.h"
#include "spi.h"
#include "sd.h"
#include "gpt.h"
#include "gpio.h"


int main()
{
    volatile int i;
   
    uint8_t a=0xAA;
    
    uint64_t cycles0,cycles1,dif_cycles;
    
    uint64_t value1,value2;
    uint8_t sum=0;
    
 
    uint8_t max;
    uint8_t pos,ok=0;
    //uint8_t round=0;
    
    init_uart(50000000, 115200);
    print_uart("Hello World!\r\n");
    

    
    init_gpio();
    //value2=0xFFFFFFFFFFFFFFFF;


   /* __asm__ volatile ("li x9,1;"
  		     "li x18,7;");*/
    while (1)
    {
    		
    	//while(value2 > 0)
    	//{
    		
    		
	    	write_gpio(GPIO_BASE,a & 0xFF);
	    	for(i=5000000;i>0;i--);
	    	write_gpio(GPIO_BASE,0xFF);
	    	for(i=5000000;i>0;i--);
	    	
	    	
		// do nothing
		 
	  	/*__asm__ volatile ("li s1,1;"
	  			  "li s2,2;"
	  			  ".insn r 0x2B, 0, 0, s3, s1, s2;"
	  			  "la s1,%[c];"
	  			  "sw s3,0(s1);": [reg] "r" s1 : [c] "m" (*ptr)); */
		 /*__asm__ volatile (
				    ".insn r 0x2B, 0, 0, %[c], %[a], %[b];"
				    : [c] "=r" (c)
				    : [a] "r" (a), [b] "r" (b)
				);*/
				
				//"li x9,1;"
	  			  //"li x18,0;"
	  			  //"csrrc rd,offset,rs1"

		//count_ones
		value1=0xFFFFFFFFFFFFFFFF;
		sum=0;
		__asm__ volatile("csrrc x20,0xB00,x0;");	
		while(value1>0)
	    	{
			sum+=value1 & 0x01;
	       		value1 >>=1;
	    	}
	    	__asm__ volatile("csrrc x21,0xB00,x0;"
	    			  "sub x20,x21,x20;"
	    			  "sw x20,%[ptr];": [ptr] "=m" (cycles0));
				
		__asm__ volatile (
	  			  "li x9,0xFFFFFFFFFFFFFFFF;"
	  			  "csrrc x22,0xB00,x0;"
	  			  ".insn r 0x5B, 0, 0, x19, x9, x18;"
	  			  "csrrc x23,0xB00,x0;"
	  			  "sub x22,x23,x22;"
	  			  "divu x24,x20,x22;"
	  			  "sw x22,%[ptr0];"
	  			  "sw x24,%[ptr1];"
	  			  "sw x19,%[ptr2];" : [ptr0] "=m" (cycles1) , [ptr2] "=m" (a) , [ptr1] "=m" (dif_cycles) /*: [val] "i" (0xFFFFFFFFFFFFFFFF)*/);
	       print_uart("INSTRUCTIUNE: count_ones \r\n");
	       print_uart("Raspuns cod C: ");
	       print_uart_byte(sum);
	       print_uart("\r\nRaspuns instructiune: ");
	       print_uart_byte(a);
	       print_uart("Nr. cicli cod C: ");
	       print_uart_addr(cycles0);
	       print_uart("Nr. cicli instructiune: ");
	       print_uart_addr(cycles1);
	       print_uart("\r\nRaport cicli: ");
	       print_uart_addr(dif_cycles);
	       
	       
	       //max
	       
	       value1=0xAAFBC107E57F01FA;
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
	    			  "sw x20,%[ptr];": [ptr] "=m" (cycles0));
	    			  
	       __asm__ volatile (
	  			  "li x9,0xAAFBC107E57F01FA;"
	  			  "li x18,0x00;"
	  			  "csrrc x22,0xB00,x0;"
	  			  ".insn r 0x0B, 0, 0, x19, x9, x18;"
	  			  "csrrc x23,0xB00,x0;"
	  			  "sub x22,x23,x22;"
	  			  "divu x24,x20,x22;"
	  			  "sw x22,%[ptr0];"
	  			  "sw x24,%[ptr1];"
	  			  "sw x19,%[ptr2];" : [ptr0] "=m" (cycles1) , [ptr2] "=m" (a) , [ptr1] "=m" (dif_cycles) /*: [val] "i" (0xFFFFFFFFFFFFFFFF)*/);
	       print_uart("INSTRUCTIUNE: max8b \r\n");
	       print_uart("Raspuns cod C: ");
	       print_uart_byte(sum);
	       print_uart("\r\nRaspuns instructiune: ");
	       print_uart_byte(a);
	       print_uart("Nr. cicli cod C: ");
	       print_uart_addr(cycles0);
	       print_uart("Nr. cicli instructiune: ");
	       print_uart_addr(cycles1);
	       print_uart("\r\nRaport cicli: ");
	       print_uart_addr(dif_cycles);
	       
	       //prima aparitie
	       
	       pos=63;
	       value1=0x0000000000000002;
	       
	       value2=0x8000000000000000;
	       
	       __asm__ volatile("csrrc x20,0xB00,x0;");
	       while(!ok)
	       {
	       	   if(value2 & value1)
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
	    			  "sw x20,%[ptr];": [ptr] "=m" (cycles0));
	    			  
	       __asm__ volatile (
	  			  "li x9,0x000000000000001;"
	  			  "csrrc x22,0xB00,x0;"
	  			  ".insn r 0x7B, 0, 0, x19, x9, x18;"
	  			  "csrrc x23,0xB00,x0;"
	  			  "sub x22,x23,x22;"
	  			  "divu x24,x20,x22;"
	  			  "sw x22,%[ptr0];"
	  			  "sw x24,%[ptr1];"
	  			  "sw x19,%[ptr2];" : [ptr0] "=m" (cycles1) , [ptr2] "=m" (a) , [ptr1] "=m" (dif_cycles) /*: [val] "i" (0xFFFFFFFFFFFFFFFF)*/);
	       print_uart("INSTRUCTIUNE: prima aparitie \r\n");
	       print_uart("Raspuns cod C: ");
	       print_uart_byte(pos);
	       print_uart("\r\nRaspuns instructiune: ");
	       print_uart_byte(a);
	       print_uart("Nr. cicli cod C: ");
	       print_uart_addr(cycles0);
	       print_uart("Nr. cicli instructiune: ");
	       print_uart_addr(cycles1);
	       print_uart("\r\nRaport cicli: ");
	       print_uart_addr(dif_cycles);
	       
	       
	       
	       
	       
	       //value2>>=1;
	      // round++;
	  //}
	}
  			  
         		
}

void handle_trap(void)
{
    // print_uart("trap\r\n");
}

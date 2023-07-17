#include "uart.h"
#include "spi.h"
#include "sd.h"
#include "gpt.h"
#include "gpio.h"


int main()
{
    volatile int i;
   
    volatile uint64_t a=0xAA;
    
    volatile uint64_t cycles0,cycles1;
     volatile uint8_t *ptr=(uint8_t *)0x80000000; //(DRAM BASE 0x80000000)
   
    
    init_uart(50000000, 115200);
    print_uart("Hello World!\r\n");
    

    
    init_gpio();
    
    while (1)
    {
	    	
		 
 		//nr de  cicli pentru 100 write;
	        ptr=(uint8_t*)0x80000000;
	        i=100;
	       	__asm__ volatile("xor x9,x9,x9");
	       	__asm__ volatile("xor x27,x27,x27");
	       	while(i>0)
	       	{
	       		__asm__ volatile("li x25,0xAAAAAAAAAAAAAAAA;"
	       				"csrrc x20,0xB00,x0;"
	       				"sd x25,%[mem];"
	       		
	       				"csrrc x21,0xB00,x0;"
	       				 "sub x20,x21,x20;"
	       				 "add x9,x9,x20;"
	       				 
	       				"csrrc x20,0xB00,x0;"
	       				"ld x26,%[mem];"
	       		
	       				"csrrc x21,0xB00,x0;"
	       				 "sub x20,x21,x20;"
	       				 "add x27,x27,x20;": [mem] "=m" (*ptr) );
	       		
	       		ptr=ptr+256;
	       		i--;
	       	}
	       	__asm__ volatile("sd x9,%[ptr0];"
	       			 "sd x27,%[ptr1];": [ptr0] "=m" (cycles0) , [ptr1] "=m" (cycles1));
	       	print_uart("\r\nNr. cicli pt 100 scrieri in RAM:");
	       	print_uart_addr(cycles0);
	       	print_uart("\r\nNr. cicli pt 100 citiri din RAM:");
	       	print_uart_addr(cycles1);
	       	
	       	
	       	
	       	ptr=(uint8_t*)(0x80006400);
	       	__asm__ volatile("xor x9,x9,x9");
	       	__asm__ volatile("xor x27,x27,x27");
	        i=10000;
	       	while(i>0)
	       	{
	       		__asm__ volatile("li x25,0xBBBBBBBBBBBBBBBB;"
	       				"csrrc x20,0xB00,x0;"
	       				"sd x25,%[mem];"
	       		
	       				"csrrc x21,0xB00,x0;"
	       				 "sub x20,x21,x20;"
	       				 "add x9,x9,x20;"
	       				 
	       				"csrrc x20,0xB00,x0;"
	       				"ld x26,%[mem];"
	       		
	       				"csrrc x21,0xB00,x0;"
	       				 "sub x20,x21,x20;"
	       				 "add x27,x27,x20;": [mem] "=m" (*ptr) );
	       		
	       		ptr=ptr+256;
	       		i--;
	       	}
	       	__asm__ volatile("sd x9,%[ptr0];"
	       			 "sd x27,%[ptr1];": [ptr0] "=m" (cycles0) , [ptr1] "=m" (cycles1));
	       	print_uart("\r\nNr. cicli pt 10000 scrieri in RAM:");
	       	print_uart_addr(cycles0);
	       	print_uart("\r\nNr. cicli pt 10000 citiri din RAM:");
	       	print_uart_addr(cycles1);
	       	
	       	//ptr=0x80000000+round;
	       	ptr=(uint8_t*)(0x90000000);
	       	__asm__ volatile("xor x9,x9,x9");
	       	__asm__ volatile("xor x27,x27,x27");
	       	i=100000;
	       	while(i>0)
	       	{
	       		__asm__ volatile("li x25,0xCCCCCCCCCCCCCCCC;"
	       				"csrrc x20,0xB00,x0;"
	       				"sd x25,%[mem];"
	       		
	       				"csrrc x21,0xB00,x0;"
	       				 "sub x20,x21,x20;"
	       				 "add x9,x9,x20;"
	       				 
	       				"csrrc x20,0xB00,x0;"
	       				"ld x26,%[mem];"
	       		
	       				"csrrc x21,0xB00,x0;"
	       				 "sub x20,x21,x20;"
	       				 "add x27,x27,x20;": [mem] "=m" (*ptr) );
	       		
	       		ptr=ptr+256;
	       		i--;
	       	}
	       	__asm__ volatile("sd x9,%[ptr0];"
	       			 "sd x27,%[ptr1];": [ptr0] "=m" (cycles0) , [ptr1] "=m" (cycles1));
	       	print_uart("\r\nNr. cicli pt 100000 scrieri in RAM:");
	       	print_uart_addr(cycles0);
	       	print_uart("\r\nNr. cicli pt 100000 citiri din RAM:");
	       	print_uart_addr(cycles1);
	       	
	       	
	       	
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

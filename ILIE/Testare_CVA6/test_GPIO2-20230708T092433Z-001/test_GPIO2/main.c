#include "uart.h"
#include "spi.h"
#include "sd.h"
#include "gpt.h"
#include "gpio.h"


int main()
{
  
    volatile int i;
    volatile uint8_t led=0xFF;
   
    
    init_uart(50000000, 115200);
    print_uart("Proiect DIPLOMA\r\n");
    print_uart("Tema proiect: Proiectarea unui SoC utilizand setul de instructiuni RISC-V\r\n");
    print_uart("Student: ILIE Florentin\r\n");
    print_uart("Indrumator: Prof. Dr. Ing. STAN Andrei\r\n");
    print_uart("IASI,2023\r\n");
    
    
    init_gpio();
    
    while (1)
    {
    
	    write_gpio(GPIO_BASE,led & 0xFF);
	    for(i=2500000;i>0;i--);
	    led>>=1;
	    if(led == 0)
	    {
	    	led=0xFF;
	    }
	       	
	       	
    }
		  
         		
}

//void handle_trap(void)
//{
    // print_uart("trap\r\n");
//}

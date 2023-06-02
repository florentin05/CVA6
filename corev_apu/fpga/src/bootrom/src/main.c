#include "uart.h"
#include "spi.h"
#include "sd.h"
#include "gpt.h"
#include "gpio.h"

volatile int i;
int main()
{
    init_uart(50000000, 115200);
    print_uart("Hello World!\r\n");

    /*int res = gpt_find_boot_partition((uint8_t *)0x80000000UL, 2 * 16384);

    if (res == 0)
    {
        // jump to the address
        __asm__ volatile(
            "li s0, 0x80000000;"
            "la a1, _dtb;"
            "jr s0");
    }*/
    
    init_gpio();


    while (1)
    {
    	write_gpio(GPIO_BASE,0xAA);
    	for(i=50000000;i>0;i--);
    	write_gpio(GPIO_BASE,0x00);
    	for(i=50000000;i>0;i--);
        // do nothing
    }
}

void handle_trap(void)
{
    // print_uart("trap\r\n");
}

//Harshit Verma
//I have tried to explain the code on each step
/* a header with definitions of symbols for ADuC834 */
#include <aduc834.h>
#include <stdio.h>
/* optional: declaration of unsigned types of one and two bytes */
typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
 
 
void delay (int t) //delay introdued by a simple timer code
{
	int i;
	for (i=0; i<t; i++){}
}
void uart_transmit(char c) //character trnasmitted to the output on termite
{
	SBUF = c; //buffer the character
	while(TI == 0);
	TI = 0;
}
 
void uart_string(char *str)
{
while (*str != 0)
{
uart_transmit(*str); //intrducing string trnasmitted to the output
str++;
 
}
}
 
int main(void)
{
	char state = 's'; //introduce a character to mention below in the code
	int i = 0; //start from i = 0
	P0 = (1<<3)|(1<<2)|(1<<1)|(1<<0);
	//P0 = 0x0F;
	SM0 = 0;
	SM1 = 1;
	REN = 1;
	T3CON = 0x80;
	T3FD = 0x12;
 
 
 
 
	while (1)
	{
		uart_transmit(state); //transmit the string for state
		if (!(P3&(1<<5))) //if this key pressed, applied to the similar codes below
		{
			state = 's'; //show and acknowledge sgtate on the output, applied to the similar codes below
			uart_string("top\n"); //further continue the seentence and next line, applied to the similar codes below
		}
		if (!(P2&(1<<0)))
		{
			state = 'r';
			uart_string("ight\n");
		}
		if (!(P1&(1<<1)))
		{
			state = 'l';
			uart_string("eft\n");
		}
		if (state == 's')
		{
				P0 |= ~(1<<0); //pressing_turns on and off
 
			  P0 |= (1<<0); //pressing_turns on and off
 
			  P0 |= ~(1<<1);
			  P0 |= (1<<1);
 
			  P0 |= ~(1<<2);
			  P0 |= (1<<2);
 
			  P0 |= ~(1<<3);
			  P0 |= (1<<3);
		}
		else if (state == 'r')
		{
				P0 &= ~(1<<0); //pressing_turns on and off
 
					delay(1000);
			  P0 |= (1<<0); //pressing_turns on and off
 
			  P0 &= ~(1<<1);
					delay(1000);
			  P0 |= (1<<1);
 
			  P0 &= ~(1<<2);
					delay(1000);
			  P0 |= (1<<2);
 
			  P0 &= ~(1<<3);
					delay(1000);
			  P0 |= (1<<3);
		}
		else if (state == 'l')
		{
				P0 &= ~(1<<3); //pressing_turns on and off
 
					delay(1000);
			  P0 |= (1<<3); //pressing_turns on and off
 
			  P0 &= ~(1<<2);
					delay(1000);
			  P0 |= (1<<2);
 
			  P0 &= ~(1<<1);
					delay(1000);
			  P0 |= (1<<1);
 
			  P0 &= ~(1<<0);
					delay(1000);
			  P0 |= (1<<0);
   	}
	}
 
 
		
 
 
	return 0;
}
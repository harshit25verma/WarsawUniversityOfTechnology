/* a header with definitions of symbols for ADuC834 */
#include <aduc834.h>
#include <stdio.h>
/* optional: declaration of unsigned types of one and two bytes */
typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
 
void delay (int t)
{
	int i;
	for (i=0; i<t; i++){}
}

 
 
int main(void)
{
	char state = 's';
	int i = 0;
	P0 = (1<<3)|(1<<2)|(1<<1)|(1<<0);
	//P0 = 0x0F;
 
	
	while (1)
	{
		if (!(P3&(1<<5)))
		{
			state = 's';
		}
		if (!(P2&(1<<0)))
		{
			state = 'r';
		}
		if (!(P1&(1<<1)))
		{
			state = 'l';
		}
				if (!(P3&(1<<3)))
		{
			state = 'c';
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
//			if (state == 's')
//			{
//				and if 
//			}
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

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
	
//	while (1) { 
//		
//		
//		if(!(P2&(1<<0))){ 
//			
//				P0 &= ~(1<<0); //pressing_turns on and off
 
//					delay(1000);
//			  P0 |= (1<<0); //pressing_turns on and off
 
//			  P0 &= ~(1<<1);
//			
//					delay(1000);
//			  P0 |= (1<<1);
 
//			  P0 &= ~(1<<2);
//		
//					delay(1000);
//			  P0 |= (1<<2);
 
//			  P0 &= ~(1<<3);
//	      
//					delay(1000);
//			  P0 |= (1<<3);
//			
//		}
//		
//		
//		if(!(P3&(1<<3))){ 
//			
//				P0 &= ~(1<<3); //pressing_turns on and off
 
//					delay(1000);
//			  P0 |= (1<<3); //pressing_turns on and off
 
//			  P0 &= ~(1<<2);
//			
//					delay(1000);
//			  P0 |= (1<<2);
 
//			  P0 &= ~(1<<1);
//		
//					delay(1000);
//			  P0 |= (1<<1);
 
//			  P0 &= ~(1<<0);
//	      
//					delay(1000);
//			  P0 |= (1<<0);
//			 
//		}
//		
//		if(!(P3&(1<<2))){ 
//			
//				P0 |= ~(1<<0); //pressing_turns on and off
 
//			  P0 |= (1<<0); //pressing_turns on and off
 
//			  P0 |= ~(1<<1);
//			
//			  P0 |= (1<<1);
 
//			  P0 |= ~(1<<2);
//		
//			  P0 |= (1<<2);
 
//			  P0 |= ~(1<<3);
//			
//			  P0 |= (1<<3);
//			 
//		}
//	}
//	//	if (!(P3&(1<<5))){
//	//		P0 &= ~(1<<6); //turn_off and stay off
//	//	}
//	//	if (!(P3&(1<<2))){
//	//		P0 |= (1<<6);  //turn_on and stay on
//	//	}
// Harshit Verma
// 302601

#include <aduc834.h>
#include <lcd_comm.h>
#include <intx_t.h>
#include <lab2_board.h>
#include <stdio.h>
 

volatile long int system_timer;

// Timer2 interrupt service routine
void IsrTimer2 (void) interrupt 5
{
	system_timer++; // Increment the system timer
	TF2 = 0; // Clear the interrupt flag
}

// Function to get the current value of the system timer
long int SysTimerGet(void)
{
	long int current_timer;
	EA = 0; // Disable all interrupts
	current_timer = system_timer; // Read the system timer
	EA = 1; // Re-enable all interrupts
	return current_timer;
}

int y; // Variable to store the remaining time

char buf[15]; // Buffer for LCD display

// Function to create a delay using the system timer
void LCD_DelayMs(uint16_t ms_cnt)
{
	long int t_ref = SysTimerGet(); // Reference time
	while (SysTimerGet() - t_ref < ms_cnt); // Wait until the specified time has passed
}

// Function to initialize Timer2
void Timer2Init(void)
{
	RCAP2H = 0xff; // Set the high byte of the reload value
	RCAP2L = 0x7c; // Set the low byte of the reload value
	TH2 = 0xff; // Set the high byte of the timer
	TL2 = 0x7c; // Set the low byte of the timer
	TR2 = 1; // Start Timer2
}

// Function to initialize interrupts
void InterruptsInit(void)
{
	ET2 = 1; // Enable Timer2 interrupt
	EA = 1; // Enable global interrupts
}

// Function prototypes for different states
void StateInitialize(void);
void StateIdle(void);
void StateSetTimeout(void);
void StateCountdown(void);

// Array of function pointers for state functions
void (*state_array[])() = {StateInitialize, StateIdle, StateSetTimeout, StateCountdown};

// Enumeration for state names
typedef enum {ST_INITIALIZE, ST_IDLE, ST_SET_TIMEOUT, ST_COUNTDOWN} state_name_t;

state_name_t current_state; // Current state variable

static long int timeout_set = 1000; // Default timeout value

// Function to initialize the system
void StateInitialize(void)
{
	PORT_LCD_LED &= ~((1 << LCD_RED) | (1 << LCD_BLUE)); // Turn off red and blue LEDs
	Timer2Init(); // Initialize Timer2
	InterruptsInit(); // Initialize interrupts
	LCD_Init(); // Initialize the LCD

	LCD_Byte(0, LCD_CLEAR); // Clear the LCD
	LCD_SendString("Init..."); // Display initialization message

	ADCMODE = (1 << 5) | (1 << 4) | (1 << 1) | (1 << 0); // Set ADC mode
	ADC0CON = (1 << 2) | (1 << 1) | (1 << 0) | (1 << 3) | (1 << 6); // Set ADC configuration

	StateIdle(); // Transition to Idle state
}

// Function to handle the Idle state
void StateIdle(void)
{
	if (current_state != ST_IDLE)
	{
		current_state = ST_IDLE; // Set the current state to Idle

		PORT_LCD_LED |= ((1 << LCD_RED) | (1 << LCD_BLUE)); // Turn on red and blue LEDs
		PORT_LCD_LED &= ~((1 << LCD_GREEN)); // Turn off green LED
		LCD_Byte(0, LCD_CLEAR); // Clear the LCD
		LCD_SendString("Menu"); // Display menu message
		LCD_Byte(0, LCD_LINE_THREE); // Move to line 3
		LCD_SendString("Btn 1:Setup"); // Display setup option
		LCD_Byte(0, LCD_LINE_FOUR); // Move to line 4
		LCD_SendString("Btn 2:Count"); // Display count option
		return;
	}
	if (BUTTON1_CHK) // Check if button 1 is pressed
	{
		StateSetTimeout(); // Transition to Set Timeout state
	} 
	else if (BUTTON3_CHK) // Check if button 3 is pressed
	{
		StateCountdown(); // Transition to Countdown state
	}
}

// Function to handle the Countdown state
void StateCountdown(void)
{
	static long int time_start, time_1s_ref;

	if (current_state != ST_COUNTDOWN)
	{
		current_state = ST_COUNTDOWN; // Set the current state to Countdown

		time_start = SysTimerGet(); // Record the start time
		time_1s_ref = time_start; // Set the reference time for 1-second intervals

		LCD_Byte(0, LCD_CLEAR); // Clear the LCD
		LCD_SendString("counting..."); // Display counting message
		y = (timeout_set) / 1000; // Calculate the initial remaining time

		return;
	}

	if (BUTTON1_CHK) // Check if button 1 is pressed
	{
		PORT_LCD_LED &= ~((1 << LCD_GREEN) | (1 << LCD_BLUE)); // Turn off green and blue LEDs
		PORT_LCD_LED |= ((1 << LCD_RED)); // Turn on red LED
		StateSetTimeout(); // Transition to Set Timeout state
	}

	if (SysTimerGet() - time_1s_ref > 1000) // Check if 1 second has passed
	{
		LCD_Byte(0, LCD_LINE_THREE); // Move to line 3
		sprintf(buf, "%2d seconds", y); // Format the remaining time
		LCD_SendString(buf); // Display the remaining time

		y = (y - 1); // Decrement the remaining time
		time_1s_ref += 1000; // Update the reference time
	}

	if (SysTimerGet() - time_start > timeout_set) // Check if the countdown is complete
	{
		StateIdle(); // Transition to Idle state
		y = timeout_set; // Reset the remaining time
	}
}

// Function to handle the Set Timeout state
void StateSetTimeout(void)
{
	if (current_state != ST_SET_TIMEOUT)
	{
		current_state = ST_SET_TIMEOUT; // Set the current state to Set Timeout
		LCD_Byte(0, LCD_CLEAR); // Clear the LCD
		PORT_LCD_LED &= ~((1 << LCD_GREEN) | (1 << LCD_BLUE)); // Turn off green and blue LEDs
		LCD_Byte(0, LCD_CLEAR); // Clear the LCD again
		LCD_Byte(0, LCD_LINE_FOUR); // Move to line 4
		LCD_SendString("Btn 5: Back"); // Display back option
		return;
	}
	while (RDY0 != 1); // Wait for ADC conversion to complete
	timeout_set = 74 * ADC0H + 1000; // Calculate the new timeout value
	LCD_Byte(0, LCD_LINE_THREE); // Move to line 3
	sprintf(buf, "%5ld ms", timeout_set); // Format the timeout value
	LCD_SendString(buf); // Display the timeout value
	RDY0 = 0; // Reset the ADC ready flag

	if (BUTTON5_CHK) // Check if button 5 is pressed
	{
		StateIdle(); // Transition to Idle state
	}
}

// Main function
int main(void)
{
	current_state = ST_INITIALIZE; // Set the initial state
	while (1)
	{
		state_array[current_state](); // Execute the function for the current state
	}
}
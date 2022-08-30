#include <pic14/pic12f675.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>  /* for time() */

//To compile:
// run make and use .hex as firmware in the circuit

/* Defining configuration*/

#pragma config FOSC = INTRCIO   // Oscillator Selection bits (INTOSC oscillator: I/O function on GP4/OSC2/CLKOUT pin, I/O function on GP5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-Up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // MCLR
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config CP = OFF         // Code Protection bit (Program Memory code protection is disabled)
#pragma config CPD = OFF // Data Code Protection bit (Data memory code protection is disabled)

 /*Define clock freq*/
#define FREQ 4000000  // 4MHZ 

/*Define the GPOs name*/
#define DATA_GP0 GP0 // data for led 1
#define RCLK GP1  // storage register clock input or latch
#define SCLK GP2 //shift register clock 
#define DATA_GP4 GP4 // data for led 2
#define BOTON GP3 // data input for the button

//Prove symbols for the 7 segment
#define sym_b 0x3F     // b fgedc 1111100 
#define sym_t 0x06     // t fged 1111000 
#define sym_H  0x5B    // H fegbc 1110110
#define sym_E  0x79     // E bc(off) 1111001 
#define sym_C  0x39     // C 
#define sym_DASH  0x5B    // -

// Symbols for numbers 0-9 in the 7 segment LED
char data[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; 

/* Defining functions to use*/

void delay (unsigned inttiempo);
void setup_mic(void);
void main_clock(void);
void latch_clock(void);
void DisplayData(unsigned int data, unsigned int data2);
unsigned int random();

/*MAIN*/

void main(void)
{

    setup_mic();
 
    unsigned int time1 = 100;
 
    while(1){
        unsigned int contador = 0;
        while (contador <= 3){
            if(BOTON == 1)  {
                //int data1 = random();
                //int data2 = random();
                //DisplayData(data1, data2);
                contador= contador + 1;  // Display b to LED seven segment (i.e. begin loop )
            }
            BOTON = 0;

        }

        DisplayData(data[9], data[9]);
        DisplayData(0x00, 0x00);
        delay(10);
        DisplayData(data[9], data[9]);
        DisplayData(0x00, 0x00);
        delay(10);
        DisplayData(data[9], data[9]);
        DisplayData(0x00, 0x00);
        delay(10);
        GPIO=0x00; 
   
    return;
    }
 
}

void delay(unsigned int tiempo)
{
	unsigned int i;
	unsigned int j;

	for(i=0;i<tiempo;i++)
	  for(j=0;j<1275;j++);
}

void setup_mic (void)
{
    //ADCON0 = 0x00;        // Turn off the A/D Converter ADFM and ADON 
    //CMCON = 0x07;		 // Shut off the Comparator
    //VRCON = 0x00;        // Shut off the Voltage Reference
    TRISIO = 0b00001000;       // GP3 input, rest all output
    GPIO=0x00;           // set all pins low
    ANSEL = 0; // Pins to digital  
}


void main_clock(void){
    SCLK = 1;
    delay(10);
    SCLK = 0;
    delay(10);
}

void latch_clock(void){
    RCLK = 1;
    delay(10);
    RCLK = 0;
    }

void DisplayData(unsigned int data1,  unsigned int data2){
    for (int i=0 ; i<8 ; i++){
		DATA_GP0 = (data1 >> i) & 0x01; // bit shift and bit mask data.
		DATA_GP4 = (data2 >> i) & 0x01; // bit shift and bit mask data.
		
        main_clock(); //enable data storage clock
    }
    latch_clock(); // Data latch
}




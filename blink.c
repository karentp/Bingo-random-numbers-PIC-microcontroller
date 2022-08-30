#include <pic14/pic12f675.h>
#include <stdlib.h>
#include <stdio.h>


//To compile:
//sdcc -mpic14 -p16f675 blink.c
 
//To program the chip using picp:
//Assuming /dev/ttyUSB0 is the serial port.
 
//Erase the chip:
//picp /dev/ttyUSB0 16f887 -ef
 
//Write the program:
//picp /dev/ttyUSB0 16f887 -wp blink.hex
 
//Write the configuration words (optional):
//picp /dev/ttyUSB0 16f887 -wc 0x2ff4 0x3fff
 
//Doing it all at once: erasing, programming, and reading back config words:
//picp /dev/ttyUSB0 16f887 -ef -wp blink.hex -rc
 
//To program the chip using pk2cmd:
//pk2cmd -M -PPIC16f887 -Fblink.hex
#pragma config FOSC = INTRCIO   // Oscillator Selection bits (INTOSC oscillator: I/O function on GP4/OSC2/CLKOUT pin, I/O function on GP5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-Up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // MCLR
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config CP = OFF         // Code Protection bit (Program Memory code protection is disabled)
#pragma config CPD = OFF // Data Code Protection bit (Data memory code protection is disabled)

 /*define clock freq*/
#define _XTAL_FREQ 4000000  // 4MHZ internal crystal
// Interfacing 74HC595 Serial Shift Register
#define SER_595 GP0 //serial data in pin 14 
#define RCLK_595 GP1  // storage register clock input pin 12 "latch" or Rclk
#define SCLK_595 GP2 //shift register clock input pin 11 "storage" or sclk
#define SER2_595 GP4 //serial data in pin 14 
#define BOTON GP3
//seven segment symbols
#define sym_b 0x3F     // b fgedc 1111100 
#define sym_t 0x06     // t fged 1111000 
#define sym_H  0x5B    // H fegbc 1110110
#define sym_E  0x79     // E bc(off) 1111001 
#define sym_C  0x39     // C 
#define sym_DASH  0x5B    // -


char data[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; 
unsigned short  Check;


void delay (unsigned inttiempo);
void setup(void);
void sclock(void);
void rclock(void);
void DataDisplay(unsigned int data, unsigned int data2);

void main(void)
{

    setup();
 
    unsigned int time1 = 100;
 
    while(1){
        unsigned int contador = 0;
        while (contador <= 3){
            if(BOTON == 1)  {
                DataDisplay(sym_t, sym_H);
                contador= contador + 1;  // Display b to LED seven segment (i.e. begin loop )
            }
            BOTON = 0;

        }

        DataDisplay(data[9], data[9]);
        DataDisplay(0x00, 0x00);
        delay(10);
        DataDisplay(data[9], data[9]);
        DataDisplay(0x00, 0x00);
        delay(10);
        DataDisplay(data[9], data[9]);
        DataDisplay(0x00, 0x00);
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

void setup (void)
{
    //ADCON0 = 0x00;        // Turn off the A/D Converter ADFM and ADON 
    //CMCON = 0x07;		 // Shut off the Comparator
    //VRCON = 0x00;        // Shut off the Voltage Reference
    TRISIO = 0b00001000;       // GP4 and GP3 input, rest all output 011000
    GPIO=0x00;           // set all pins low
    ANSEL = 0; // Pines digital   
}


void sclock(void){
    SCLK_595 = 1;
    delay(10);
    SCLK_595 = 0;
    delay(10);
}

void rclock(void){
    RCLK_595 = 1;
    delay(10);
    RCLK_595 = 0;
    }

void DataDisplay(unsigned int data1,  unsigned int data2){
    for (int i=0 ; i<8 ; i++){
		SER_595 = (data1 >> i) & 0x01; // bit shift and bit mask data.
		SER2_595 = (data2 >> i) & 0x01; // bit shift and bit mask data.
		
        sclock(); //enable data storage clock
    }
    rclock(); // Data latch
}




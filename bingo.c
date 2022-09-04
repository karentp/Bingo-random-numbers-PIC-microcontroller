#include <pic14/pic12f675.h>

//To compile:
// run make and use .hex as firmware in the circuit in Simulid

/* Defining configuration*/

#pragma config MCLRE = OFF      // MCLR GP03

/*Define clock freq*/
#define FREQ 4000000  // 4MHZ 

/*Define the GPOs name*/
#define DATA_GP0 GP0 // data for led 1
#define RCLK GP1  // storage register clock input or latch
#define SCLK GP2 //shift register clock 
#define DATA_GP4 GP4 // data for led 2
#define BOTON GP3 // data input for the button


// Symbols for numbers 0-9 in the 7 segment LED
char data[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; 

/* Defining functions to use*/

void delay (unsigned inttiempo);
void setup_mic(void);
void main_clock(void);
void latch_clock(void);
void DisplayData(unsigned int data, unsigned int data2);
void blink();

/*MAIN*/

void main(void)
{

    setup_mic();

    unsigned int random_1 = 0;
    unsigned int random_2 = 7;
    unsigned int contador = 0;
    while(1){
        while (contador < 16){
            if (random_1<9) {random_1 = random_1 + 1;}
            else random_1 = 0;
            if (random_2<9) {random_2 = random_2 + 1;}
            else random_2 = 0;
            if(BOTON == 1)  {
                DisplayData(random_1, random_2);
                contador= contador + 1;  
            }
            BOTON = 0;
        }
        delay(50);
        GPIO=0x00;
        //Show 99 when finishing the program
        DisplayData(0xD,0xD);
        DisplayData(9,9);
        DisplayData(0xD,0xD);
        DisplayData(9,9);
        DisplayData(0xD,0xD);
        DisplayData(9,9);
        DisplayData(0xD,0xD);
         
        contador=0;
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
    if (data1 == 0xD) {data1= 0x00; data2=0x00;}
    else{
        data1 = data[data1];
        data2 = data[data2];
    }
    for (int i=0 ; i<8 ; i++){
		DATA_GP0 = (data1 >> i) & 0x01; // bit shift and bit mask data.
		DATA_GP4 = (data2 >> i) & 0x01; // bit shift and bit mask data.
        main_clock(); //enable data storage clock
    }
    latch_clock(); // Data latch
}

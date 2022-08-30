;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"blink.c"
	list	p=12f675
	radix dec
	include "p12f675.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_ANSEL
	extern	_TRISIO
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_data
	global	_delay
	global	_setup_mic
	global	_main_clock
	global	_latch_clock
	global	_DisplayData

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0020
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_blink_0	udata
r0x101B	res	1
r0x101C	res	1
r0x101D	res	1
r0x100B	res	1
r0x100A	res	1
r0x100C	res	1
r0x100D	res	1
r0x100E	res	1
r0x100F	res	1
r0x1010	res	1
r0x1011	res	1
r0x1013	res	1
r0x1012	res	1
r0x1015	res	1
r0x1014	res	1
r0x1016	res	1
r0x1017	res	1
r0x1019	res	1
r0x1018	res	1
r0x101A	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

IDD_blink_0	idata
_data
	db	0x3f	; 63
	db	0x06	; 6
	db	0x5b	; 91
	db	0x4f	; 79	'O'
	db	0x66	; 102	'f'
	db	0x6d	; 109	'm'
	db	0x7d	; 125
	db	0x07	; 7
	db	0x7f	; 127
	db	0x67	; 103	'g'

;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_blink	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _setup_mic
;   _DisplayData
;   _DisplayData
;   _delay
;   _DisplayData
;   _DisplayData
;   _delay
;   _DisplayData
;   _DisplayData
;   _delay
;   _setup_mic
;   _DisplayData
;   _DisplayData
;   _delay
;   _DisplayData
;   _DisplayData
;   _delay
;   _DisplayData
;   _DisplayData
;   _delay
;6 compiler assigned registers:
;   r0x101B
;   r0x101C
;   r0x101D
;   STK02
;   STK01
;   STK00
;; Starting pCode block
S_blink__main	code
_main:
; 2 exit points
;	.line	54; "blink.c"	setup_mic();
	PAGESEL	_setup_mic
	CALL	_setup_mic
	PAGESEL	$
;	.line	60; "blink.c"	while (contador <= 3){
	CLRF	r0x101B
	CLRF	r0x101C
;;swapping arguments (AOP_TYPEs 1/2)
;;unsigned compare: left >= lit(0x4=4), size=2
_00107_DS_:
	MOVLW	0x00
	SUBWF	r0x101C,W
	BTFSS	STATUS,2
	GOTO	_00128_DS_
	MOVLW	0x04
	SUBWF	r0x101B,W
_00128_DS_:
	BTFSC	STATUS,0
	GOTO	_00109_DS_
;;genSkipc:3307: created from rifx:0x7ffeabd0c3b0
;	.line	61; "blink.c"	if(BOTON == 1)  {
	CLRF	r0x101D
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,3
	INCF	r0x101D,F
	MOVF	r0x101D,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00106_DS_
;	.line	65; "blink.c"	contador= contador + 1;  // Display b to LED seven segment (i.e. begin loop )
	INCF	r0x101B,F
	BTFSC	STATUS,2
	INCF	r0x101C,F
_00106_DS_:
;	.line	67; "blink.c"	BOTON = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,3
	GOTO	_00107_DS_
_00109_DS_:
;	.line	71; "blink.c"	DisplayData(data[9], data[9]);
	MOVF	(_data + 9),W
	MOVWF	r0x101B
	MOVWF	r0x101C
	CLRF	r0x101D
	MOVF	r0x101C,W
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x101C,W
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	72; "blink.c"	DisplayData(0x00, 0x00);
	MOVLW	0x00
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x00
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	73; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	74; "blink.c"	DisplayData(data[9], data[9]);
	MOVF	(_data + 9),W
	MOVWF	r0x101B
	MOVWF	r0x101C
	CLRF	r0x101D
	MOVF	r0x101C,W
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x101C,W
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	75; "blink.c"	DisplayData(0x00, 0x00);
	MOVLW	0x00
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x00
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	76; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	77; "blink.c"	DisplayData(data[9], data[9]);
	MOVF	(_data + 9),W
	MOVWF	r0x101B
	MOVWF	r0x101C
	CLRF	r0x101D
	MOVF	r0x101C,W
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x101C,W
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	78; "blink.c"	DisplayData(0x00, 0x00);
	MOVLW	0x00
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x00
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	79; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	80; "blink.c"	GPIO=0x00; 
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	85; "blink.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _main_clock
;   _latch_clock
;   _main_clock
;   _latch_clock
;12 compiler assigned registers:
;   r0x1012
;   STK00
;   r0x1013
;   STK01
;   r0x1014
;   STK02
;   r0x1015
;   r0x1016
;   r0x1017
;   r0x1018
;   r0x1019
;   r0x101A
;; Starting pCode block
S_blink__DisplayData	code
_DisplayData:
; 2 exit points
;	.line	120; "blink.c"	void DisplayData(unsigned int data1,  unsigned int data2){
	MOVWF	r0x1012
	MOVF	STK00,W
	MOVWF	r0x1013
	MOVF	STK01,W
	MOVWF	r0x1014
	MOVF	STK02,W
	MOVWF	r0x1015
;	.line	121; "blink.c"	for (int i=0 ; i<8 ; i++){
	CLRF	r0x1016
	CLRF	r0x1017
;;signed compare: left < lit(0x8=8), size=2, mask=ffff
_00179_DS_:
	MOVF	r0x1017,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00192_DS_
	MOVLW	0x08
	SUBWF	r0x1016,W
_00192_DS_:
	BTFSC	STATUS,0
	GOTO	_00177_DS_
;;genSkipc:3307: created from rifx:0x7ffeabd0c3b0
;	.line	122; "blink.c"	DATA_GP0 = (data1 >> i) & 0x01; // bit shift and bit mask data.
	MOVF	r0x1012,W
	MOVWF	r0x1018
	MOVF	r0x1013,W
	MOVWF	r0x1019
	MOVF	r0x1016,W
	BTFSC	r0x1016,7
	GOTO	_00195_DS_
	SUBLW	0x00
	BTFSC	STATUS,2
	GOTO	_00194_DS_
_00193_DS_:
	RRF	r0x1018,F
	RRF	r0x1019,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00193_DS_
	GOTO	_00194_DS_
_00195_DS_:
	BCF	STATUS,0
_00196_DS_:
	RLF	r0x1019,F
	RLF	r0x1018,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00196_DS_
_00194_DS_:
	MOVF	r0x1019,W
	MOVWF	r0x101A
	RRF	r0x101A,W
	BTFSC	STATUS,0
	GOTO	_00001_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
_00001_DS_:
	BTFSS	STATUS,0
	GOTO	_00002_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
_00002_DS_:
;	.line	123; "blink.c"	DATA_GP4 = (data2 >> i) & 0x01; // bit shift and bit mask data.
	MOVF	r0x1014,W
	MOVWF	r0x1018
	MOVF	r0x1015,W
	MOVWF	r0x1019
	MOVF	r0x1016,W
	BTFSC	r0x1016,7
	GOTO	_00199_DS_
	SUBLW	0x00
	BTFSC	STATUS,2
	GOTO	_00198_DS_
_00197_DS_:
	RRF	r0x1018,F
	RRF	r0x1019,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00197_DS_
	GOTO	_00198_DS_
_00199_DS_:
	BCF	STATUS,0
_00200_DS_:
	RLF	r0x1019,F
	RLF	r0x1018,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00200_DS_
_00198_DS_:
	MOVF	r0x1019,W
	MOVWF	r0x101A
	RRF	r0x101A,W
	BTFSC	STATUS,0
	GOTO	_00003_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,4
_00003_DS_:
	BTFSS	STATUS,0
	GOTO	_00004_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,4
_00004_DS_:
;	.line	125; "blink.c"	main_clock(); //enable data storage clock
	PAGESEL	_main_clock
	CALL	_main_clock
	PAGESEL	$
;	.line	121; "blink.c"	for (int i=0 ; i<8 ; i++){
	INCF	r0x1016,F
	BTFSC	STATUS,2
	INCF	r0x1017,F
	GOTO	_00179_DS_
_00177_DS_:
;	.line	127; "blink.c"	latch_clock(); // Data latch
	PAGESEL	_latch_clock
	CALL	_latch_clock
	PAGESEL	$
;	.line	128; "blink.c"	}
	RETURN	
; exit point of _DisplayData

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _delay
;   _delay
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_blink__latch_clock	code
_latch_clock:
; 2 exit points
;	.line	115; "blink.c"	RCLK = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
;	.line	116; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	117; "blink.c"	RCLK = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
;	.line	118; "blink.c"	}
	RETURN	
; exit point of _latch_clock

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _delay
;   _delay
;   _delay
;   _delay
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_blink__main_clock	code
_main_clock:
; 2 exit points
;	.line	108; "blink.c"	SCLK = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
;	.line	109; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	110; "blink.c"	SCLK = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	111; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	112; "blink.c"	}
	RETURN	
; exit point of _main_clock

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_blink__setup_mic	code
_setup_mic:
; 2 exit points
;	.line	101; "blink.c"	TRISIO = 0b00001000;       // GP3 input, rest all output
	MOVLW	0x08
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	102; "blink.c"	GPIO=0x00;           // set all pins low
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	103; "blink.c"	ANSEL = 0; // Pins to digital  
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	104; "blink.c"	}
	RETURN	
; exit point of _setup_mic

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x100A
;   STK00
;   r0x100B
;   r0x100C
;   r0x100D
;   r0x100E
;   r0x100F
;   r0x1010
;   r0x1011
;; Starting pCode block
S_blink__delay	code
_delay:
; 2 exit points
;	.line	87; "blink.c"	void delay(unsigned int tiempo)
	MOVWF	r0x100A
	MOVF	STK00,W
	MOVWF	r0x100B
;	.line	92; "blink.c"	for(i=0;i<tiempo;i++)
	CLRF	r0x100C
	CLRF	r0x100D
_00139_DS_:
	MOVF	r0x100A,W
	SUBWF	r0x100D,W
	BTFSS	STATUS,2
	GOTO	_00160_DS_
	MOVF	r0x100B,W
	SUBWF	r0x100C,W
_00160_DS_:
	BTFSC	STATUS,0
	GOTO	_00141_DS_
;;genSkipc:3307: created from rifx:0x7ffeabd0c3b0
;	.line	93; "blink.c"	for(j=0;j<1275;j++);
	MOVLW	0xfb
	MOVWF	r0x100E
	MOVLW	0x04
	MOVWF	r0x100F
_00137_DS_:
	MOVLW	0xff
	ADDWF	r0x100E,W
	MOVWF	r0x1010
	MOVLW	0xff
	MOVWF	r0x1011
	MOVF	r0x100F,W
	BTFSC	STATUS,0
	INCFSZ	r0x100F,W
	ADDWF	r0x1011,F
	MOVF	r0x1010,W
	MOVWF	r0x100E
	MOVF	r0x1011,W
	MOVWF	r0x100F
	MOVF	r0x1011,W
	IORWF	r0x1010,W
	BTFSS	STATUS,2
	GOTO	_00137_DS_
;	.line	92; "blink.c"	for(i=0;i<tiempo;i++)
	INCF	r0x100C,F
	BTFSC	STATUS,2
	INCF	r0x100D,F
	GOTO	_00139_DS_
_00141_DS_:
;	.line	94; "blink.c"	}
	RETURN	
; exit point of _delay


;	code size estimation:
;	  246+   44 =   290 instructions (  668 byte)

	end

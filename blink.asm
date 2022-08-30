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
r0x101E	res	1
r0x101F	res	1
r0x1020	res	1
r0x1021	res	1
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
r0x1018	res	1
r0x1019	res	1
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
;   _delay
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _setup_mic
;   _DisplayData
;   _delay
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _DisplayData
;   _DisplayData
;10 compiler assigned registers:
;   r0x101B
;   r0x101C
;   r0x101D
;   r0x101E
;   r0x101F
;   r0x1020
;   r0x1021
;   STK02
;   STK01
;   STK00
;; Starting pCode block
S_blink__main	code
_main:
; 2 exit points
;	.line	38; "blink.c"	setup_mic();
	PAGESEL	_setup_mic
	CALL	_setup_mic
	PAGESEL	$
;	.line	40; "blink.c"	unsigned int random_1 = 0;
	CLRF	r0x101B
	CLRF	r0x101C
;	.line	41; "blink.c"	unsigned int random_2 = 7;
	MOVLW	0x07
	MOVWF	r0x101D
	CLRF	r0x101E
;	.line	42; "blink.c"	unsigned int contador = 0;
	CLRF	r0x101F
	CLRF	r0x1020
;;unsigned compare: left < lit(0x5=5), size=2
_00113_DS_:
;	.line	44; "blink.c"	while (contador < 5){
	MOVLW	0x00
	SUBWF	r0x1020,W
	BTFSS	STATUS,2
	GOTO	_00141_DS_
	MOVLW	0x05
	SUBWF	r0x101F,W
_00141_DS_:
	BTFSC	STATUS,0
	GOTO	_00115_DS_
;;genSkipc:3307: created from rifx:0x7ffce71a0f00
;;unsigned compare: left < lit(0x9=9), size=2
;	.line	45; "blink.c"	if (random_1<9) {random_1 = random_1 + 1;}
	MOVLW	0x00
	SUBWF	r0x101C,W
	BTFSS	STATUS,2
	GOTO	_00142_DS_
	MOVLW	0x09
	SUBWF	r0x101B,W
_00142_DS_:
	BTFSC	STATUS,0
	GOTO	_00106_DS_
;;genSkipc:3307: created from rifx:0x7ffce71a0f00
	INCF	r0x101B,F
	BTFSC	STATUS,2
	INCF	r0x101C,F
	GOTO	_00107_DS_
_00106_DS_:
;	.line	46; "blink.c"	else random_1 = 0;
	CLRF	r0x101B
	CLRF	r0x101C
;;unsigned compare: left < lit(0x9=9), size=2
_00107_DS_:
;	.line	47; "blink.c"	if (random_2<9) {random_2 = random_2 + 1;}
	MOVLW	0x00
	SUBWF	r0x101E,W
	BTFSS	STATUS,2
	GOTO	_00143_DS_
	MOVLW	0x09
	SUBWF	r0x101D,W
_00143_DS_:
	BTFSC	STATUS,0
	GOTO	_00109_DS_
;;genSkipc:3307: created from rifx:0x7ffce71a0f00
	INCF	r0x101D,F
	BTFSC	STATUS,2
	INCF	r0x101E,F
	GOTO	_00110_DS_
_00109_DS_:
;	.line	48; "blink.c"	else random_2 = 0;
	CLRF	r0x101D
	CLRF	r0x101E
_00110_DS_:
;	.line	49; "blink.c"	if(BOTON == 1)  {
	CLRF	r0x1021
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,3
	INCF	r0x1021,F
	MOVF	r0x1021,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00112_DS_
;	.line	50; "blink.c"	DisplayData(random_1, random_2);
	MOVF	r0x101D,W
	MOVWF	STK02
	MOVF	r0x101E,W
	MOVWF	STK01
	MOVF	r0x101B,W
	MOVWF	STK00
	MOVF	r0x101C,W
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	51; "blink.c"	contador= contador + 1;  
	INCF	r0x101F,F
	BTFSC	STATUS,2
	INCF	r0x1020,F
_00112_DS_:
;	.line	53; "blink.c"	BOTON = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,3
	GOTO	_00113_DS_
_00115_DS_:
;	.line	55; "blink.c"	delay(50);
	MOVLW	0x32
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	56; "blink.c"	GPIO=0x00;
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	57; "blink.c"	DisplayData(0xD,0xD);
	MOVLW	0x0d
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x0d
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	58; "blink.c"	DisplayData(9,9);
	MOVLW	0x09
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x09
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	59; "blink.c"	DisplayData(0xD,0xD);
	MOVLW	0x0d
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x0d
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	60; "blink.c"	DisplayData(9,9);
	MOVLW	0x09
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x09
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	61; "blink.c"	DisplayData(0xD,0xD);
	MOVLW	0x0d
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x0d
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	62; "blink.c"	DisplayData(9,9);
	MOVLW	0x09
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x09
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	63; "blink.c"	DisplayData(0xD,0xD);
	MOVLW	0x0d
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x0d
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DisplayData
	CALL	_DisplayData
	PAGESEL	$
;	.line	65; "blink.c"	contador=0;
	CLRF	r0x101F
	CLRF	r0x1020
	GOTO	_00113_DS_
;	.line	68; "blink.c"	}
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
;	.line	100; "blink.c"	void DisplayData(unsigned int data1,  unsigned int data2){
	MOVWF	r0x1012
	MOVF	STK00,W
	MOVWF	r0x1013
	MOVF	STK01,W
	MOVWF	r0x1014
	MOVF	STK02,W
	MOVWF	r0x1015
;	.line	101; "blink.c"	if (data1 == 0xD) {data1= 0x00; data2=0x00;}
	MOVF	r0x1013,W
	XORLW	0x0d
	BTFSS	STATUS,2
	GOTO	_00193_DS_
	MOVF	r0x1012,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00193_DS_
	CLRF	r0x1013
	CLRF	r0x1012
	CLRF	r0x1016
	CLRF	r0x1017
	GOTO	_00203_DS_
_00193_DS_:
;	.line	103; "blink.c"	data1 = data[data1];
	MOVF	r0x1013,W
	ADDLW	(_data + 0)
	MOVWF	r0x1018
	MOVLW	high (_data + 0)
	MOVWF	r0x1019
	MOVF	r0x1012,W
	BTFSC	STATUS,0
	INCFSZ	r0x1012,W
	ADDWF	r0x1019,F
	MOVF	r0x1018,W
	MOVWF	FSR
	BCF	STATUS,7
	BTFSC	r0x1019,0
	BSF	STATUS,7
	MOVF	INDF,W
	MOVWF	r0x101A
	MOVWF	r0x1013
	CLRF	r0x1012
;	.line	104; "blink.c"	data2 = data[data2];
	MOVF	r0x1015,W
	ADDLW	(_data + 0)
	MOVWF	r0x101A
	MOVLW	high (_data + 0)
	MOVWF	r0x1018
	MOVF	r0x1014,W
	BTFSC	STATUS,0
	INCFSZ	r0x1014,W
	ADDWF	r0x1018,F
	MOVF	r0x101A,W
	MOVWF	FSR
	BCF	STATUS,7
	BTFSC	r0x1018,0
	BSF	STATUS,7
	MOVF	INDF,W
	MOVWF	r0x1015
	MOVWF	r0x1016
	CLRF	r0x1017
_00203_DS_:
;	.line	106; "blink.c"	for (int i=0 ; i<8 ; i++){
	CLRF	r0x1015
	CLRF	r0x1014
;;signed compare: left < lit(0x8=8), size=2, mask=ffff
_00197_DS_:
	MOVF	r0x1014,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00217_DS_
	MOVLW	0x08
	SUBWF	r0x1015,W
_00217_DS_:
	BTFSC	STATUS,0
	GOTO	_00195_DS_
;;genSkipc:3307: created from rifx:0x7ffce71a0f00
;	.line	107; "blink.c"	DATA_GP0 = (data1 >> i) & 0x01; // bit shift and bit mask data.
	MOVF	r0x1012,W
	MOVWF	r0x1019
	MOVF	r0x1013,W
	MOVWF	r0x1018
	MOVF	r0x1015,W
	BTFSC	r0x1015,7
	GOTO	_00220_DS_
	SUBLW	0x00
	BTFSC	STATUS,2
	GOTO	_00219_DS_
_00218_DS_:
	RRF	r0x1019,F
	RRF	r0x1018,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00218_DS_
	GOTO	_00219_DS_
_00220_DS_:
	BCF	STATUS,0
_00221_DS_:
	RLF	r0x1018,F
	RLF	r0x1019,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00221_DS_
_00219_DS_:
	MOVF	r0x1018,W
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
;	.line	108; "blink.c"	DATA_GP4 = (data2 >> i) & 0x01; // bit shift and bit mask data.
	MOVF	r0x1017,W
	MOVWF	r0x1019
	MOVF	r0x1016,W
	MOVWF	r0x1018
	MOVF	r0x1015,W
	BTFSC	r0x1015,7
	GOTO	_00224_DS_
	SUBLW	0x00
	BTFSC	STATUS,2
	GOTO	_00223_DS_
_00222_DS_:
	RRF	r0x1019,F
	RRF	r0x1018,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00222_DS_
	GOTO	_00223_DS_
_00224_DS_:
	BCF	STATUS,0
_00225_DS_:
	RLF	r0x1018,F
	RLF	r0x1019,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00225_DS_
_00223_DS_:
	MOVF	r0x1018,W
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
;	.line	109; "blink.c"	main_clock(); //enable data storage clock
	PAGESEL	_main_clock
	CALL	_main_clock
	PAGESEL	$
;	.line	106; "blink.c"	for (int i=0 ; i<8 ; i++){
	INCF	r0x1015,F
	BTFSC	STATUS,2
	INCF	r0x1014,F
	GOTO	_00197_DS_
_00195_DS_:
;	.line	111; "blink.c"	latch_clock(); // Data latch
	PAGESEL	_latch_clock
	CALL	_latch_clock
	PAGESEL	$
;	.line	112; "blink.c"	}
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
;	.line	95; "blink.c"	RCLK = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
;	.line	96; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	97; "blink.c"	RCLK = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
;	.line	98; "blink.c"	}
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
;	.line	88; "blink.c"	SCLK = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
;	.line	89; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	90; "blink.c"	SCLK = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	91; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	92; "blink.c"	}
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
;	.line	81; "blink.c"	TRISIO = 0b00001000;       // GP3 input, rest all output
	MOVLW	0x08
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	82; "blink.c"	GPIO=0x00;           // set all pins low
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	83; "blink.c"	ANSEL = 0; // Pins to digital  
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	84; "blink.c"	}
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
;	.line	70; "blink.c"	void delay(unsigned int tiempo)
	MOVWF	r0x100A
	MOVF	STK00,W
	MOVWF	r0x100B
;	.line	75; "blink.c"	for(i=0;i<tiempo;i++)
	CLRF	r0x100C
	CLRF	r0x100D
_00154_DS_:
	MOVF	r0x100A,W
	SUBWF	r0x100D,W
	BTFSS	STATUS,2
	GOTO	_00175_DS_
	MOVF	r0x100B,W
	SUBWF	r0x100C,W
_00175_DS_:
	BTFSC	STATUS,0
	GOTO	_00156_DS_
;;genSkipc:3307: created from rifx:0x7ffce71a0f00
;	.line	76; "blink.c"	for(j=0;j<1275;j++);
	MOVLW	0xfb
	MOVWF	r0x100E
	MOVLW	0x04
	MOVWF	r0x100F
_00152_DS_:
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
	GOTO	_00152_DS_
;	.line	75; "blink.c"	for(i=0;i<tiempo;i++)
	INCF	r0x100C,F
	BTFSC	STATUS,2
	INCF	r0x100D,F
	GOTO	_00154_DS_
_00156_DS_:
;	.line	77; "blink.c"	}
	RETURN	
; exit point of _delay


;	code size estimation:
;	  327+   44 =   371 instructions (  830 byte)

	end

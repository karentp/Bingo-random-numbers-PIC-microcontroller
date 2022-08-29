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
	extern	_VRCON
	extern	_TRISIO
	extern	_ADCON0
	extern	_CMCON
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_Check
	global	_data
	global	_delay
	global	_setup
	global	_sclock
	global	_rclock
	global	_DataDisplay
	global	_CheckResponse

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
UD_blink_0	udata
_Check	res	2

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_blink_0	udata
r0x1013	res	1
r0x1014	res	1
r0x1003	res	1
r0x1002	res	1
r0x1004	res	1
r0x1005	res	1
r0x1006	res	1
r0x1007	res	1
r0x1008	res	1
r0x1009	res	1
r0x100B	res	1
r0x100A	res	1
r0x100D	res	1
r0x100C	res	1
r0x100E	res	1
r0x100F	res	1
r0x1011	res	1
r0x1010	res	1
r0x1012	res	1
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
;   _setup
;   _CheckResponse
;   _DataDisplay
;   _setup
;   _CheckResponse
;   _DataDisplay
;5 compiler assigned registers:
;   r0x1013
;   r0x1014
;   STK02
;   STK01
;   STK00
;; Starting pCode block
S_blink__main	code
_main:
; 2 exit points
;	.line	65; "blink.c"	setup();
	PAGESEL	_setup
	CALL	_setup
	PAGESEL	$
;	.line	70; "blink.c"	ANSEL &= ~0x0F;
	MOVLW	0xf0
	BANKSEL	_ANSEL
	ANDWF	_ANSEL,F
;	.line	71; "blink.c"	CMCON = 0x07;
	MOVLW	0x07
	BANKSEL	_CMCON
	MOVWF	_CMCON
;	.line	72; "blink.c"	CheckResponse(); //get response from DHT11 sensor
	PAGESEL	_CheckResponse
	CALL	_CheckResponse
	PAGESEL	$
;	.line	74; "blink.c"	if(Check == 1)  // Did DHT11 respond ? 
	MOVF	_Check,W
	MOVWF	r0x1013
	MOVF	(_Check + 1),W
	MOVWF	r0x1014
	MOVF	r0x1013,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00110_DS_
	MOVF	r0x1014,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00110_DS_
;	.line	75; "blink.c"	DataDisplay(sym_t, sym_H);  // Display b to LED seven segment (i.e. begin loop )
	MOVLW	0x5b
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVLW	0x06
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_DataDisplay
	CALL	_DataDisplay
	PAGESEL	$
_00110_DS_:
;	.line	84; "blink.c"	}
	RETURN	
; exit point of _main

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
S_blink__CheckResponse	code
_CheckResponse:
; 2 exit points
;	.line	133; "blink.c"	Check = 0;
	CLRF	_Check
	CLRF	(_Check + 1)
;	.line	134; "blink.c"	delay(5);
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	135; "blink.c"	if (BOTON ==0)
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,3
	GOTO	_00184_DS_
;	.line	136; "blink.c"	Check = 1; 
	MOVLW	0x01
	MOVWF	_Check
	CLRF	(_Check + 1)
_00184_DS_:
;	.line	137; "blink.c"	delay(5);
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	138; "blink.c"	}
	RETURN	
; exit point of _CheckResponse

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _sclock
;   _rclock
;   _sclock
;   _rclock
;12 compiler assigned registers:
;   r0x100A
;   STK00
;   r0x100B
;   STK01
;   r0x100C
;   STK02
;   r0x100D
;   r0x100E
;   r0x100F
;   r0x1010
;   r0x1011
;   r0x1012
;; Starting pCode block
S_blink__DataDisplay	code
_DataDisplay:
; 2 exit points
;	.line	119; "blink.c"	void DataDisplay(unsigned int data1,  unsigned int data2){
	MOVWF	r0x100A
	MOVF	STK00,W
	MOVWF	r0x100B
	MOVF	STK01,W
	MOVWF	r0x100C
	MOVF	STK02,W
	MOVWF	r0x100D
;	.line	120; "blink.c"	for (int i=0 ; i<8 ; i++){
	CLRF	r0x100E
	CLRF	r0x100F
;;signed compare: left < lit(0x8=8), size=2, mask=ffff
_00157_DS_:
	MOVF	r0x100F,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00170_DS_
	MOVLW	0x08
	SUBWF	r0x100E,W
_00170_DS_:
	BTFSC	STATUS,0
	GOTO	_00155_DS_
;;genSkipc:3307: created from rifx:0x7ffced461a80
;	.line	121; "blink.c"	SER_595 = (data1 >> i) & 0x01; // bit shift and bit mask data.
	MOVF	r0x100A,W
	MOVWF	r0x1010
	MOVF	r0x100B,W
	MOVWF	r0x1011
	MOVF	r0x100E,W
	BTFSC	r0x100E,7
	GOTO	_00173_DS_
	SUBLW	0x00
	BTFSC	STATUS,2
	GOTO	_00172_DS_
_00171_DS_:
	RRF	r0x1010,F
	RRF	r0x1011,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00171_DS_
	GOTO	_00172_DS_
_00173_DS_:
	BCF	STATUS,0
_00174_DS_:
	RLF	r0x1011,F
	RLF	r0x1010,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00174_DS_
_00172_DS_:
	MOVF	r0x1011,W
	MOVWF	r0x1012
	RRF	r0x1012,W
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
;	.line	122; "blink.c"	SER2_595 = (data2 >> i) & 0x01; // bit shift and bit mask data.
	MOVF	r0x100C,W
	MOVWF	r0x1010
	MOVF	r0x100D,W
	MOVWF	r0x1011
	MOVF	r0x100E,W
	BTFSC	r0x100E,7
	GOTO	_00177_DS_
	SUBLW	0x00
	BTFSC	STATUS,2
	GOTO	_00176_DS_
_00175_DS_:
	RRF	r0x1010,F
	RRF	r0x1011,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00175_DS_
	GOTO	_00176_DS_
_00177_DS_:
	BCF	STATUS,0
_00178_DS_:
	RLF	r0x1011,F
	RLF	r0x1010,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00178_DS_
_00176_DS_:
	MOVF	r0x1011,W
	MOVWF	r0x1012
	RRF	r0x1012,W
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
;	.line	124; "blink.c"	sclock(); //enable data storage clock
	PAGESEL	_sclock
	CALL	_sclock
	PAGESEL	$
;	.line	120; "blink.c"	for (int i=0 ; i<8 ; i++){
	INCF	r0x100E,F
	BTFSC	STATUS,2
	INCF	r0x100F,F
	GOTO	_00157_DS_
_00155_DS_:
;	.line	126; "blink.c"	rclock(); // Data latch
	PAGESEL	_rclock
	CALL	_rclock
	PAGESEL	$
;	.line	127; "blink.c"	}
	RETURN	
; exit point of _DataDisplay

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
S_blink__rclock	code
_rclock:
; 2 exit points
;	.line	114; "blink.c"	RCLK_595 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
;	.line	115; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	116; "blink.c"	RCLK_595 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
;	.line	117; "blink.c"	}
	RETURN	
; exit point of _rclock

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
S_blink__sclock	code
_sclock:
; 2 exit points
;	.line	107; "blink.c"	SCLK_595 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
;	.line	108; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	109; "blink.c"	SCLK_595 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	110; "blink.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	111; "blink.c"	}
	RETURN	
; exit point of _sclock

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_blink__setup	code
_setup:
; 2 exit points
;	.line	97; "blink.c"	ADCON0 = 0x00;        // Turn off the A/D Converter ADFM and ADON
	BANKSEL	_ADCON0
	CLRF	_ADCON0
;	.line	98; "blink.c"	ANSEL = 0x00;      
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	99; "blink.c"	CMCON = 0x07;		 // Shut off the Comparator
	MOVLW	0x07
	BANKSEL	_CMCON
	MOVWF	_CMCON
;	.line	100; "blink.c"	VRCON = 0x00;        // Shut off the Voltage Reference
	BANKSEL	_VRCON
	CLRF	_VRCON
;	.line	101; "blink.c"	TRISIO = 0b001000;       // GP4 and GP3 input, rest all output 011000
	MOVLW	0x08
	MOVWF	_TRISIO
;	.line	102; "blink.c"	GPIO=0x00;           // set all pins low
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	103; "blink.c"	}
	RETURN	
; exit point of _setup

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x1002
;   STK00
;   r0x1003
;   r0x1004
;   r0x1005
;   r0x1006
;   r0x1007
;   r0x1008
;   r0x1009
;; Starting pCode block
S_blink__delay	code
_delay:
; 2 exit points
;	.line	86; "blink.c"	void delay(unsigned int tiempo)
	MOVWF	r0x1002
	MOVF	STK00,W
	MOVWF	r0x1003
;	.line	91; "blink.c"	for(i=0;i<tiempo;i++)
	CLRF	r0x1004
	CLRF	r0x1005
_00117_DS_:
	MOVF	r0x1002,W
	SUBWF	r0x1005,W
	BTFSS	STATUS,2
	GOTO	_00138_DS_
	MOVF	r0x1003,W
	SUBWF	r0x1004,W
_00138_DS_:
	BTFSC	STATUS,0
	GOTO	_00119_DS_
;;genSkipc:3307: created from rifx:0x7ffced461a80
;	.line	92; "blink.c"	for(j=0;j<1275;j++);
	MOVLW	0xfb
	MOVWF	r0x1006
	MOVLW	0x04
	MOVWF	r0x1007
_00115_DS_:
	MOVLW	0xff
	ADDWF	r0x1006,W
	MOVWF	r0x1008
	MOVLW	0xff
	MOVWF	r0x1009
	MOVF	r0x1007,W
	BTFSC	STATUS,0
	INCFSZ	r0x1007,W
	ADDWF	r0x1009,F
	MOVF	r0x1008,W
	MOVWF	r0x1006
	MOVF	r0x1009,W
	MOVWF	r0x1007
	MOVF	r0x1009,W
	IORWF	r0x1008,W
	BTFSS	STATUS,2
	GOTO	_00115_DS_
;	.line	91; "blink.c"	for(i=0;i<tiempo;i++)
	INCF	r0x1004,F
	BTFSC	STATUS,2
	INCF	r0x1005,F
	GOTO	_00117_DS_
_00119_DS_:
;	.line	93; "blink.c"	}
	RETURN	
; exit point of _delay


;	code size estimation:
;	  196+   36 =   232 instructions (  536 byte)

	end

#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program


i EQU 0x22
j EQU 0x23
bin EQU 0x24
r1 EQU 0x25
r2 EQU 0x26
r3 EQU 0x27
r4 EQU 0x28
r5 EQU 0x29
r6 EQU 0x30
r7 EQU 0x31
r8 EQU 0x32
m1 EQU 0x33
m2 EQU 0x34
m3 EQU 0x35
m4 EQU 0x36
m5 EQU 0x37
m6 EQU 0x38
m7 EQU 0x39
m8 EQU 0x40
aux EQU 0x41
ban EQU 0x42
carr EQU 0x43
 
START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    CLRF TRISA
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE
    MOVLW b'00000000' 
    MOVWF TRISC
    MOVLW b'11111111' 
    MOVWF TRISD
    BCF STATUS,RP1
    BCF STATUS,RP0
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    
    CLRF ban
    CLRF carr
      
    
INITLCD
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    CALL CONTRA
    CALL CONFIR
    
INICIO
    CALL LCDPOS
    MOVLW b'00000000'
    MOVWF bin
    CALL REGISTRO
    CALL LCDPOS2
    CALL REGISTRO2 
    CALL COMPARACION
    GOTO INICIO
    
CONTRA:
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'T'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    RETURN
    
    
CONFIR:
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x90	       ;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'F'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    RETURN 
    
REGISTRO:
    
    CALL SCAN
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF r1
    
    CALL SCAN
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF r2

    CALL SCAN
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF r3
    
    CALL SCAN
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF r4
    
    CALL SCAN
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF r5
    
    CALL SCAN
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF r6
    
    CALL SCAN
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF r7
    
    CALL SCAN
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF r8

    RETURN
    
REGISTRO2:
    
    CALL SCAN2
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF m1
    
    CALL SCAN2
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF m2
   
    CALL SCAN2
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF m3 
    
    CALL SCAN2
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF m4
    
    CALL SCAN2
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF m5
    
    CALL SCAN2
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF m6
    
    CALL SCAN2
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF m7
    
    CALL SCAN2
    BTFSS ban, 0
    GOTO $-2
    MOVFW aux
    MOVWF m8
    
    RETURN
  
SCAN:    
    BCF ban, 0
    
    BSF PORTC, 0     
    BTFSC PORTD, 0
    CALL UNO ;Se oprimió 1
    
    BCF PORTC, 0
    
    BSF PORTC, 1     
    BTFSC PORTD, 0
    CALL DOS ;Se oprimió 2
    
    BCF PORTC, 1
    
    BSF PORTC, 2     
    BTFSC PORTD, 0
    CALL TRES ;Se oprimió 3
    
    BCF PORTC, 2
    
    BSF PORTC, 0    
    BTFSC PORTD, 1
    CALL CUATRO ;Se oprimió 4
    
    BCF PORTC, 0
    
    BSF PORTC, 1    
    BTFSC PORTD, 1
    CALL CINCO ;Se oprimió 5
    
    BCF PORTC, 1
    
    BSF PORTC, 2    
    BTFSC PORTD, 1
    CALL SEIS ;Se oprimió 6
    
    BCF PORTC, 2
    
    BSF PORTC, 0    
    BTFSC PORTD, 2
    CALL SIETE ;Se oprimió 7
    
    BCF PORTC, 0
    
    BSF PORTC, 1    
    BTFSC PORTD, 2
    CALL OCHO ;Se oprimió 8
    
    BCF PORTC, 1
    
    BSF PORTC, 2    
    BTFSC PORTD, 2
    CALL NUEVE ;Se oprimió 9
    
    BCF PORTC, 2
    
    BSF PORTC, 1   
    BTFSC PORTD, 3
    CALL CERO ;Se oprimió cero
    
    BCF PORTC, 1
    
    
    RETURN

SCAN2:    
    BCF ban, 0
    
    BSF PORTC, 0     
    BTFSC PORTD, 0
    CALL UNO2 ;Se oprimió 1
    
    BCF PORTC, 0
    
    BSF PORTC, 1     
    BTFSC PORTD, 0
    CALL DOS2 ;Se oprimió 2
    
    BCF PORTC, 1
    
    BSF PORTC, 2     
    BTFSC PORTD, 0
    CALL TRES2 ;Se oprimió 3
    
    BCF PORTC, 2
    
    BSF PORTC, 0    
    BTFSC PORTD, 1
    CALL CUATRO2 ;Se oprimió 4
    
    BCF PORTC, 0
    
    BSF PORTC, 1    
    BTFSC PORTD, 1
    CALL CINCO2 ;Se oprimió 5
    
    BCF PORTC, 1
    
    BSF PORTC, 2    
    BTFSC PORTD, 1
    CALL SEIS2 ;Se oprimió 6
    
    BCF PORTC, 2
    
    BSF PORTC, 0    
    BTFSC PORTD, 2
    CALL SIETE2 ;Se oprimió 7
    
    BCF PORTC, 0
    
    BSF PORTC, 1    
    BTFSC PORTD, 2
    CALL OCHO2 ;Se oprimió 8
    
    BCF PORTC, 1
    
    BSF PORTC, 2    
    BTFSC PORTD, 2
    CALL NUEVE2 ;Se oprimió 9
    
    BCF PORTC, 2
    
    BSF PORTC, 1   
    BTFSC PORTD, 3
    CALL CERO2 ;Se oprimió cero
    
    BCF PORTC, 1
    
    
    RETURN
    
UNO:     
    MOVLW b'00000001'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 0
    GOTO $-1
    RETURN  

DOS:     
    MOVLW b'00000010'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 0
    GOTO $-1
    RETURN 

TRES: 
    MOVLW b'00000011'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 0
    GOTO $-1
    RETURN
    
CUATRO:     
    MOVLW b'00000100'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN     
 
CINCO: 
    MOVLW b'00000101'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN
   
SEIS: 
    MOVLW b'00000110'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN

SIETE: 
    MOVLW b'00000111'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN
    
OCHO: 
    MOVLW b'00001000'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN

NUEVE: 
    MOVLW b'00001001'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN
    
CERO: 
    MOVLW b'00000000'
    MOVWF aux
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 3
    GOTO $-1
    RETURN
 
UNO2:     
    MOVLW b'00000001'
    MOVWF aux
    
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 0
    GOTO $-1
    RETURN  

DOS2:     
    MOVLW b'00000010'
    MOVWF aux
    
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 0
    GOTO $-1
    RETURN 

TRES2: 
    MOVLW b'00000011'
    MOVWF aux
    
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 0
    GOTO $-1
    RETURN
    
CUATRO2:     
    MOVLW b'00000100'
    MOVWF aux
    
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN     
 
CINCO2: 
    MOVLW b'00000101'
    MOVWF aux
    
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN
   
SEIS2: 
    MOVLW b'00000110'
    MOVWF aux
    
    MOVLW '6'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN

SIETE2: 
    MOVLW b'00000111'
    MOVWF aux
    
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN
    
OCHO2: 
    MOVLW b'00001000'
    MOVWF aux
    
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN

NUEVE2: 
    MOVLW b'00001001'
    MOVWF aux
    
    MOVLW '9'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN
    
CERO2: 
    MOVLW b'00000000'
    MOVWF aux
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    
    BSF ban, 0
    
    BTFSC PORTD, 3
    GOTO $-1
    RETURN
    

COMPARACION:
    
    MOVFW m1
    MOVWF aux
    XORWF r1,W
    BTFSS STATUS,Z 
    CALL DIF   ; DIF

    MOVFW m2
    MOVWF aux
    XORWF r2,W
    BTFSS STATUS,Z 
    CALL DIF
    
    MOVFW m3
    MOVWF aux
    XORWF r3,W
    BTFSS STATUS,Z
    CALL DIF
    
    MOVFW m4
    MOVWF aux
    XORWF r4,W
    BTFSS STATUS,Z 
    CALL DIF
    
    MOVFW m5
    MOVWF aux
    XORWF r5,W
    BTFSS STATUS,Z 
    CALL DIF
    
    MOVFW m6
    MOVWF aux
    XORWF r6,W
    BTFSS STATUS,Z 
    CALL DIF
    
    MOVFW m7
    MOVWF aux
    XORWF r7,W
    BTFSS STATUS,Z 
    CALL DIF
    
    MOVFW m8
    MOVWF aux
    XORWF r8,W
    BTFSS STATUS,Z 
    CALL DIF
    CALL IG        ;DIF
    
    RETURN
  
DIF:
    CALL CLEAR
    STAY:
    
	BCF PORTA,0		;command mode
	CALL time

	MOVLW 0xC2		;LCD position
	MOVWF PORTB
	CALL exec

	BSF PORTA,0		;data mode
	CALL time

	MOVLW '*'
	MOVWF PORTB
	CALL exec

	MOVLW '*'
	MOVWF PORTB
	CALL exec

	MOVLW 'L'
	MOVWF PORTB
	CALL exec

	MOVLW 'O'
	MOVWF PORTB
	CALL exec

	MOVLW ' '
	MOVWF PORTB
	CALL exec

	MOVLW 'S'
	MOVWF PORTB
	CALL exec

	MOVLW 'I'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'N'
	MOVWF PORTB
	CALL exec

	MOVLW 'T'
	MOVWF PORTB
	CALL exec

	MOVLW 'O'
	MOVWF PORTB
	CALL exec

	MOVLW '*'
	MOVWF PORTB
	CALL exec

	MOVLW '*'
	MOVWF PORTB
	CALL exec

	MOVLW 0xD0		;LCD position
	MOVWF PORTB
	CALL exec

	BSF PORTA,0		;data mode
	CALL time

	MOVLW 'A'
	MOVWF PORTB
	CALL exec

	MOVLW 'C'
	MOVWF PORTB
	CALL exec

	MOVLW 'C'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'S'
	MOVWF PORTB
	CALL exec

	MOVLW 'O'
	MOVWF PORTB
	CALL exec

	MOVLW ' '
	MOVWF PORTB
	CALL exec

	MOVLW ' '
	MOVWF PORTB
	CALL exec

	MOVLW 'D'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'N'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'G'
	MOVWF PORTB
	CALL exec

	MOVLW 'A'
	MOVWF PORTB
	CALL exec

	MOVLW 'D'
	MOVWF PORTB
	CALL exec

	MOVLW 'O'
	MOVWF PORTB
	CALL exec  
    
	GOTO STAY
    
    
IG:
    CALL CLEAR
    STAY2:

	BCF PORTA,0		;command mode
	CALL time

	MOVLW 0xC2		;LCD position
	MOVWF PORTB
	CALL exec

	BSF PORTA,0		;data mode
	CALL time

	MOVLW '*'
	MOVWF PORTB
	CALL exec

	MOVLW '*'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'X'
	MOVWF PORTB
	CALL exec

	MOVLW 'C'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'L'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'N'
	MOVWF PORTB
	CALL exec

	MOVLW 'T'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW '*'
	MOVWF PORTB
	CALL exec

	MOVLW '*'
	MOVWF PORTB
	CALL exec

	BCF PORTA,0		;command mode
	CALL time

	MOVLW 0x90		;LCD position
	MOVWF PORTB
	CALL exec

	BSF PORTA,0		;data mode
	CALL time

	MOVLW 'A'
	MOVWF PORTB
	CALL exec

	MOVLW 'C'
	MOVWF PORTB
	CALL exec

	MOVLW 'C'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'S'
	MOVWF PORTB
	CALL exec

	MOVLW 'O'
	MOVWF PORTB
	CALL exec

	MOVLW ' '
	MOVWF PORTB
	CALL exec


	MOVLW 'P'
	MOVWF PORTB
	CALL exec

	MOVLW 'E'
	MOVWF PORTB
	CALL exec

	MOVLW 'R'
	MOVWF PORTB
	CALL exec

	MOVLW 'M'
	MOVWF PORTB
	CALL exec

	MOVLW 'I'
	MOVWF PORTB
	CALL exec

	MOVLW 'T'
	MOVWF PORTB
	CALL exec

	MOVLW 'I'
	MOVWF PORTB
	CALL exec

	MOVLW 'D'
	MOVWF PORTB
	CALL exec

	MOVLW 'O'
	MOVWF PORTB
	CALL exec
    
	GOTO STAY2
  
    
   
    
LCDPOS:
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC2		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    RETURN
    
 LCDPOS2:
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xD2		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    RETURN
    
    
CLEAR:
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x01		;reset
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    RETURN
   
exec
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN
    
   
    END
;
; actividad1thephany.asm
;
; Created: 10/02/2024 21:37:06
; Author : esthe
;


; Replace with your application code
.cseg
.org 0

ldi r20, 0b00000000      //resetear timer

ldi r16, 0b00100000
out DDRB, r16

seleccionarF:
	in r18, pinb
	cpi r18, 0b00000000
	breq 1hz
	cpi r18, 0b00000001
	breq 2p5hz
	cpi r18, 0b00000010
	breq 50hz
	cpi r18, 0b00000011
	breq 10khz
	rjmp seleccionarF

cambiarled:
	in r17, portb
	eor r17, r16
	out portb, r17
	ret 

1hz:
	ldi r19, 00000100
	out tcc1rb, r19
	out high(tcnt1), r20
	out low(tcnt1), r20
	ldi r21, 0x7a			//alta
	ldi r22, 0x12			//baja

ciclo1hz:
	in r23, high(tcnt1)
	in r24, low(tcnt1)		//Comparar parte alta con parte baja del registro del timer con el registro 
	cp r21, r23
	brne ciclo1hz
	cp r22, r24
	brne ciclo1hz
	
ciclo2p5:
	
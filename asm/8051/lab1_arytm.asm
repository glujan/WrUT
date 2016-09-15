LJMP START
ORG 100H ; od tego start

START:
	;ustawienie adresu pameci i wartosci w A
	MOV DPTR, #0x8010
	MOV A, #01H

	; przeniesienie wartosci A do pamieci
	MOVX @DPTR, A

	MOV R0, #010H ; test dodawania
	MOV A, #04H
	ADD A, R0	

	MOV R0, #03H ; test odejmowania
	MOV A, #050H
	SUBB A, R0

	MOV B, #04H ; test mnozenia
	MOV A, #010H
	MUL AB

	MOV B, #03H ; test dzielenia
	MOV A, #015H
	DIV AB
	
	NOP ; zakonczenie programu
	NOP
	NOP
	JMP $
END START

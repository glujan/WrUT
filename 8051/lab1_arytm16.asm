LJMP START
ORG 200H ; od tego start

START:
	; R0 R1 - pierwsza liczba 16bit, R0 to 8 starszych bitow
	MOV R0, #02H
	MOV R1, #0FFH

	; R2 R3 - druga liczba 16bit, R2 to 8 starszych bitow
	MOV R2, #010H
	MOV R3, #03H

	; Operacja dodawania
	MOV A, R3
	ADD A, R1
	MOV R1, A

	MOV A, R2
	ADDC A, R0
	MOV R0, A
	
	
	NOP ; zakonczenie programu
	NOP
	NOP
	JMP $
END START

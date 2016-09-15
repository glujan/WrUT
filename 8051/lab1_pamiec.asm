LJMP START
ORG 100H ; od tego start

START:
	MOV DPTR, #08010H
	MOV A, #01H

	; przeniesienie wartosci A do pamieci
	MOVX @DPTR, A
	
	NOP ; zakonczenie programu
	NOP
	NOP
	JMP $
END START

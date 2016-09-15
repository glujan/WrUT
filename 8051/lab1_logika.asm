LJMP START
ORG 300H ; od tego start

START:
	; test AND
	MOV R0, #06H
	MOV A, #02H
	ANL A,R0

	; test OR
	MOV R0, #01H
	MOV A, #05H
	ORL A,R0

	; test XOR
	MOV R0, #01H
	MOV A, #05H
	XRL A,R0

	; test NOT
	MOV A, #055H
	CPL A
	
	NOP ; zakonczenie programu
	NOP
	NOP
	JMP $
END START

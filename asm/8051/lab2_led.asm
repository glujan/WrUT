LJMP START
ORG 100H

START:
	MOV R2, #0x3

CYKL:
	MOV A, #0x00 ; gaszenie diod
	MOV P1, A	

	MOV R0, #0x0F
WEW1:
	MOV R1, #0x10
WEW2:
	DJNZ R1, WEW2
	DJNZ R0, WEW1

  	MOV A, #0xFF ; zapalanie diod
	MOV P1, A

	MOV R0, #0x0F
WEW3:
	MOV R1, #0x10
WEW4:
	DJNZ R1, WEW4
	DJNZ R0, WEW3

	DJNZ R2, CYKL

	NOP
	NOP
	NOP
	JMP $
END START
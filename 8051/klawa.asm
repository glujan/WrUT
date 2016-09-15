$NOMOD51

;--------------------------------------------------------------------------------------------------------------
; przyniesc klawe nastepnym razem
; LCD - pod pewnym adresem podajemy kod ASCII znaku do wyswietlenia, jesli caly tekst to znak po znaku pokazujemy
; drugi adres - kody sterujace (wyczyscic, kursor przesunac)
; trzeci adres - gotowosc wyswietlacza, bardzo wazne!
; dopiero jak wyswietlacz zglosi gotowosc mozna wyswietlic / dac instrukcje
; w instrukcji jest fragment kodu, ale jest duzo zbednych rzeczy w nim! nie jest tez gotowy do wykonania
; zadanie 1 - cos pokazac na wyswietlaczu
; zadanie 2 - instrukcje sterujace
; zadanie 3 - zrobic urzadzenie np wyswietlajace wartosc klawisza na ekran
;--------------------------------------------------------------------------------------------------------------

$INCLUDE(REG517.INC)
CSEG AT 0000h

LJMP START

; ---------------------------------------------
; Wartosc zapisuje w R2 (niszczy stara wartosc)|
; Procedura wyliczajaca wartosc klawisza z A   |
; ---------------------------------------------
WARTOSC:
	CPL A
; Pierwszy wiersz (od dolu)
WART1:
	CJNE A, #10001000B, WART2
	MOV R2, #01H
	RET	
WART2:
	CJNE A, #10000100B, WART3
	MOV R2, #02H
	RET
WART3:
	CJNE A, #10000010B, WARTA
	MOV R2, #03H
	RET
WARTA:
	CJNE A, #10000001B, WART4
	MOV R2, #0AH
	RET
; Drugi wiersz
WART4:
	CJNE A, #01001000B, WART5
	MOV R2, #04H
	RET
WART5:
	CJNE A, #01000100B, WART6
	MOV R2, #05H
	RET
WART6:
	CJNE A, #01000010B, WARTB
	MOV R2, #06H
	RET
WARTB:
	CJNE A, #01000001B, WART7
	MOV R2, #0BH
	RET
; Trzeci wiersz
WART7:
	CJNE A, #00101000B, WART8
	MOV R2, #07H
	RET
WART8:
	CJNE A, #00100100B, WART9
	MOV R2, #08H
	RET
WART9:
	CJNE A, #00100010B, WARTC
	MOV R2, #09H
	RET
WARTC:
	CJNE A, #00100001B, WARTF
	MOV R2, #0CH
	RET
; Czwarty wiersz
WARTF:
	CJNE A, #00011000B, WART0
	MOV R2, #0FH
	RET
WART0:
	CJNE A, #00010100B, WARTE
	MOV R2, #00H
	RET
WARTE:
	CJNE A, #00010010B, WARTD
	MOV R2, #0EH
	RET
WARTD:
	CJNE A, #00010001B, WARTOSC_KONIEC
	MOV R2, #0DH
	RET
WARTOSC_KONIEC:
	RET

;ORG 100H
START:

SKANUJ:
	MOV R3,#4 ; tyle jest wierszy
	MOV R1,#07Fh ; bedziemy ustawiac na low P5.7
	JZ PETLA1
PETLA1:
	MOV P5,R1 ; wyzeruj zadany bit
	MOV A,P7 ; odczytaj stan kolumn
	XRL A,#0FFh ; naloz maske by zostal tylko bit wcisnietej kolumny
	JZ PETLA2 ; jesli nie wcisniete, idz do petli
	MOV A,P7
	ANL A,R1 ; teraz w A jest kod skaningowy
	LCALL WARTOSC ; procedura wyliczajaca wartosc
	MOV A, R2
	CPL A
	MOV P1, A ; zapala diody
PETLA2:
	; ponizsze 3 linijki przesuwaja LOW na kolejny bit
	MOV A,R1
	RR A
	MOV R1,A
	DJNZ R3,PETLA1 ; skanuj kolejny wiersz

;pusta petla do zapobiegania repetycji klawisza
	MOV R0, #0F0H
OPOZNIENIE1:
	NOP;
	NOP;
	DJNZ R0, OPOZNIENIE1
	MOV P1, #0FFH; gasimy diody

	MOV R0, #0F0H
OPOZNIENIE2:
	NOP;
	NOP;
	DJNZ R0, OPOZNIENIE2 

	SJMP SKANUJ ; skanuj ponownie klawiature

	NOP
	NOP
	NOP
	JMP $
END START
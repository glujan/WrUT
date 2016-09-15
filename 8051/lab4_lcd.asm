$NOMOD51
$INCLUDE(REG517.INC)
CSEG AT 0000h

LCD_CMD EQU 0FF2CH ; linia sterowania
LCD_WRITE EQU 0FF2DH ; linia zapisu danych
LCD_STATUS EQU 0FF2EH ; linia odczytu statusu
LCD_READ EQU 0FF2FH ; linia odczytu danych
LCD_INIT EQU 038H ; kod inicjalizacji wyswietlacza
LCD_CLEAR EQU 001H ; kod czyszczenia wyswietlacza
LCD_ON EQU 00EH ; kod wylaczenia kursora
LCD_LINE2 EQU 0c0H ; kod przejscia do drugiej linii

LJMP START

; ---------------------------------------------
; Glowna procedura programu
; ---------------------------------------------
START:
	CALL INIT
	CALL CZEKAJ

	CALL WYCZYSC
	CALL CZEKAJ
POBIERZ:
	CALL SKANUJ
	MOV A, R6
	SUBB A, #010H
	JZ DRUGI_WIERSZ	
	MOV A, R6
	JZ WYCZYSC     
	JMP POBIERZ

; Zakonczenie programu
	NOP
	NOP
	NOP
	JMP $

; ---------------------------------------------
; Procedura czekajaca na gotowosc wyswietlacza |
; ---------------------------------------------
CZEKAJ:
	MOV DPTR, #LCD_STATUS
CZEKAJ_JESZCZE:
	MOVX A, @DPTR
	JB ACC.7, CZEKAJ_JESZCZE
	RET

; ---------------------------------------------
; Procedura inicjalizujaca                     |
; ---------------------------------------------
INIT:
	MOV DPTR, #LCD_CMD
	MOV A, #LCD_INIT
	MOVX @DPTR, A
	RET	

; ---------------------------------------------
; Procedura czysczaca napis		       |
; ---------------------------------------------	
WYCZYSC:
	MOV R6, #020H ; licznik wolnych znakow
	MOV DPTR, #LCD_CMD
	MOV A, #LCD_CLEAR
	MOVX @DPTR, A
	RET	
POKAZ:
	MOV DPTR, #LCD_WRITE
	MOVX @DPTR, A
	RET

; ---------------------------------------------
; Procedura przechodzaca do nowego wiersza     |
; ---------------------------------------------	
DRUGI_WIERSZ:
	MOV DPTR, #LCD_CMD
	MOV A, #LCD_LINE2
	MOVX @DPTR, A
	CALL CZEKAJ
	RET

; ---------------------------------------------
; Procedura czytajaca kod klawisza             |
; ---------------------------------------------
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
	CPL A

	ADD A, #041H ; obliczanie litery
	CALL POKAZ ; wyswietlanie litery
	DEC R6 ; zmiejsz licznik wolnych pol
	CALL CZEKAJ
PETLA2:
	; ponizsze 3 linijki przesuwaja LOW na kolejny bit
	MOV A,R1
	RR A
	MOV R1,A
	DJNZ R3,PETLA1 ; skanuj kolejny wiersz

;pusta petla do zapobiegania repetycji klawisza
	MOV R0, #0FFH
OPOZNIENIE1:
	NOP;
	NOP;
	DJNZ R0, OPOZNIENIE1
	MOV P1, #0FFH; gasimy diody

	MOV R0, #0FFH
	MOV R1, #0FFH
OPOZNIENIE2:
OPOZNIENIE3:
	DJNZ R1, OPOZNIENIE3
	DJNZ R0, OPOZNIENIE2 

	RET

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

END START
# przed wywolaniem funkcji pushujemy argumenty na stos
# potem CALL
# w funkcji pushlujemy ebp
# w ebp zapisujemy esp
# subl $8, %esp - mamy miejsce na 2 integery
# 4(%ebp), druga zmienna to 8(%ebp)
# -8(%ebp) - argument2, -12(%ebp) - argument1

SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDIN = 0
STDOUT = 0
EXT_SUCCESS = 0
SYSCALL = 0x80
buff_len = 10

.align 32
.comm buff, buff_len
.data
liczba1: .long 32
liczba2: .long 32
.text
	indec: .ascii "Wprowadz liczbe dziesietna:\n"
	indec_len = . - indec

.global main

to_value:
	#push %ebp
	#movl %esp, %ebp #po co?

	movl $0, %ebx
	movl 8(%esp), %ecx # tu jest adres bufora
	movl $0, %eax
to_value_loop:
	imull $10, %eax
	movl $0, %edx
	movb (%ecx,%ebx,1), %dl
	subl $48, %edx
	addl %edx, %eax
	incl %ebx
	cmpl 4(%esp), %ebx # 4(%esp) to dlugosc bufora
	jb to_value_loop
	ret

to_text:
	
	
to_text_loop:
	ret

sum:
# mamy dwie liczby rownej dlugosci
# pierwsza komorka to dlugosc liczby, kolejne to wartosc liczby
# wprowadzamy liczbe 16tkowo, ma byc "nieskonczenie dluga"
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%esp), %eax #liczba1
	movl 4(%esp), %ebx #liczba2
	movl $0, %ebx
	movl (%ebx, %eax,1), %edx #interator
	ret

main:
	#prosba o wpisanie liczby
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $indec, %ecx
	mov $indec_len, %edx
	int $SYSCALL

	#wprowadzenie liczby
	mov $SYSREAD, %eax
	mov $STDIN, %ebx
	mov $buff, %ecx
	mov $buff_len, %edx
	int $SYSCALL

	pushl $buff
	pushl $buff_len
	call to_value
	nop # w eax jest wartosc wpisanego stringa
	
	pushl $buff
	pushl $buff_len
	call to_text

	pushl $liczba1
	pushl $liczba2
	call sum
	nop # teraz w liczba1 jest suma

	#zakonczenie programu
	mov $SYSEXIT, %eax
	mov $EXT_SUCCESS, %ebx
	int $SYSCALL


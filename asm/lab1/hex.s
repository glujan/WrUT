SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDIN = 0
STDOUT = 0
EXT_SUCCESS = 0
SYSCALL = 0x80
buff_len = 9
buff_num = 8
result_len = 10
.align 32
.comm buff, buff_len
.comm result, result_len
.data
	x1: .long 0
	x2: .long 0
.text
	inhex: .ascii "Wprowadz liczbe hex (duze litery):\n"
	inhex_len = . - inhex
#data
#x: .long 0 

.global main

main:
#prosba o wpisanie liczby1
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $inhex, %ecx
	mov $inhex_len, %edx
	int $SYSCALL

	#wprowadzenie liczby1
	mov $SYSREAD, %eax
	mov $STDIN, %ebx
	mov $buff, %ecx
	mov $buff_len, %edx
	int $SYSCALL

	#przygotowanie rejestrow dla liczby1
	movl $0, %eax
	movl $0, %ecx
	movl $0, %edx
	#petla obliczajaca wartosc liczby1
start1:
	movl $0, %ecx
	movb buff(%edx), %cl
	subl $'0', %ecx
	sal $4, %eax #eax*16
	cmpl $10, %ecx
	jb koniec1
	subl $7, %ecx #litera 'A' jest 7 miejsca za '9'
koniec1:
	addl %ecx, %eax
	incl %edx
	cmpl $buff_num, %edx
	jne start1

	#przerzucic liczbe1 do pamieci
	movl %eax, x1

#prosba o wpisanie liczby2
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $inhex, %ecx
	mov $inhex_len, %edx
	int $SYSCALL

	#wprowadzenie liczby2
	mov $SYSREAD, %eax
	mov $STDIN, %ebx
	mov $buff, %ecx
	mov $buff_len, %edx
	int $SYSCALL

	#przygotowanie rejestrow dla liczby2
	movl $0, %eax
	movl $0, %ecx
	movl $0, %edx

	#petla obliczajaca wartosc liczby2
start2:
	movl $0, %ecx
	movb buff(%edx), %cl
	subl $'0', %ecx
	sal $4, %eax #eax*16
	#jesli ecx>=10: ecx -= 7
	cmpl $10, %ecx
	jb koniec2
	subl $7, %ecx
koniec2:
	addl %ecx, %eax
	incl %edx
	cmpl $buff_num, %edx
	jne start2

	#przerzucic liczbe2 do pamieci
	movl %eax, x2

#dodawanie
	movl $result_len, %edx
	decl %edx
	movb $'\n', result(%edx)
	decl %edx
	addl x1, %eax
	movb $' ', result(%edx)
	jnc show00
	movb $'!', result(%edx)
show00:
	decl %edx
show10:
	movl $0, %ecx
	movb %al, %cl
	and $0xF, %ecx #obcina najstarsze (zbedne) 4 bity
	addl $'0', %ecx
	cmp $':', %ecx #':' jest nastepny po '9'
	jb show20
	addl $7, %ecx
show20:
	movb %cl, result(%edx)
	sar $4, %eax #eax/16
	decl %edx
	jge show10

	#faktyczne wyswietlanie sumy
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

#mnozenie bez znaku
	#przygotowanie rejestrow i buffa dla edx
	movl $result_len, %ebx
	decl %ebx
	movb $0, result(%ebx)
	decl %ebx
	movb $0, result(%ebx)
	decl %ebx
	movl x2, %eax
	mull x1
	#obliczanie drugiej czesci, czyli edx
show31:
	movl $0, %ecx
	movb %dl, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show41
	addl $7, %ecx
show41:
	movb %cl, result(%ebx)
	sar $4, %edx
	decl %ebx
	cmp $0, %ebx
	jge show31

	#faktycznie wypisanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

	#przygotowanie rejestrow i buffa dla eax
	movl $result_len, %ebx
	decl %ebx
	movb $'\n', result(%ebx)
	decl %ebx
	movb $' ', result(%ebx)
	movl x2, %eax
	mull x1
	jno show01
	movb $'!', result(%ebx)
show01:
	decl %ebx
	#obliczanie pierwszej czesci, czyli eax
show11:
	movl $0, %ecx
	movb %al, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show21
	addl $7, %ecx
show21:
	movb %cl, result(%ebx)
	sar $4, %eax
	decl %ebx
	cmp $0, %ebx
	jge show11

	#faktyczne wyswietlanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

#mnozenie ze znakiem
	#przygotowanie rejestrow i buffa dla edx
	movl $result_len, %ebx
	decl %ebx
	movb $0, result(%ebx)
	decl %ebx
	movb $0, result(%ebx)
	decl %ebx
	movl x2, %eax
	imull x1
	#obliczanie drugiej czesci, czyli edx
show32:
	movl $0, %ecx
	movb %dl, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show42
	addl $7, %ecx
show42:
	movb %cl, result(%ebx)
	sar $4, %edx
	decl %ebx
	cmp $0, %ebx
	jge show32

	#faktycznie wypisanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

	#przygotowanie rejestrow i buffa dla eax
	movl $result_len, %ebx
	decl %ebx
	movb $'\n', result(%ebx)
	decl %ebx
	movb $' ', result(%ebx)
	movl x2, %eax
	imull x1
	jno show02
	movb $'!', result(%ebx)
show02:
	decl %ebx
	#obliczanie pierwszej czesci, czyli eax
show12:
	movl $0, %ecx
	movb %al, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show22
	addl $7, %ecx
show22:
	movb %cl, result(%ebx)
	sar $4, %eax
	decl %ebx
	cmp $0, %ebx
	jge show12

	#faktyczne wyswietlanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

#dzielenie bez znaku
	#przygotowanie rejestrow i buffa dla eax
	movl $result_len, %ebx
	decl %ebx
	movb $':', result(%ebx)
	decl %ebx
	movb $'r', result(%ebx)
	decl %ebx
	movl x1, %eax
	movl $0, %edx
	divl x2
	#obliczanie wyniku, czyli eax
show13:
	movl $0, %ecx
	movb %al, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show23
	addl $7, %ecx
show23:
	movb %cl, result(%ebx)
	sar $4, %eax
	decl %ebx
	cmp $0, %ebx
	jge show13

	#faktycznie wypisanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

	#przygotowanie rejestrow i buffa dla edx
	movl $result_len, %ebx
	decl %ebx
	movb $'\n', result(%ebx)
	decl %ebx
	movb $0, result(%ebx)
	decl %ebx
	movl x1, %eax
	movl $0, %edx
	divl x2
	#wyliczanie stringa z reszty, czyli edx
show33:
	movl $0, %ecx
	movb %dl, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show43
	addl $7, %ecx
show43:
	movb %cl, result(%ebx)
	sar $4, %edx
	decl %ebx
	cmp $0, %ebx
	jge show33

	#faktycznie wypisanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

#dzielenie ze znakiem
	#przygotowanie rejestrow i buffa dla eax
	movl $result_len, %ebx
	decl %ebx
	movb $':', result(%ebx)
	decl %ebx
	movb $'r', result(%ebx)
	decl %ebx
	movl x1, %eax
	movl $0, %edx
	idivl x2
	#wyciaganie stringa z wyniku, czyli eax
show14:
	movl $0, %ecx
	movb %al, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show24
	addl $7, %ecx
show24:
	movb %cl, result(%ebx)
	sar $4, %eax
	decl %ebx
	cmp $0, %ebx
	jge show14

	#faktycznie wypisanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

	#przygotowanie rejestrow i buffa dla edx
	movl $result_len, %ebx
	decl %ebx
	movb $'\n', result(%ebx)
	decl %ebx
	movb $0, result(%ebx)
	decl %ebx
	movl x1, %eax
	movl $0, %edx
	idivl x2
	#wyciaganie stinga z reszty, czyli edx
show34:
	movl $0, %ecx
	movb %dl, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show44
	addl $7, %ecx
show44:
	movb %cl, result(%ebx)
	sar $4, %edx
	decl %ebx
	cmp $0, %ebx
	jge show34

	#faktycznie wypisanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

#potegowanie
	#przygotowanie rejestrow
	movl x2, %ecx
	decl %ecx
	movl x1, %eax
	movl %eax, %ebx
	movl $0, %edx
	#obliczanie potegi
start05:
	mull %ebx
	loop start05

	#przygotowanie rejestrow i buffa dla edx
	movl $result_len, %ebx
	decl %ebx
	movb $0, result(%ebx)
	decl %ebx
	movb $0, result(%ebx)
	decl %ebx
	movl %eax, x1
	#obliczanie drugiej czesci, czyli edx
show35:
	movl $0, %ecx
	movb %dl, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show45
	addl $7, %ecx
show45:
	movb %cl, result(%ebx)
	sar $4, %edx
	decl %ebx
	cmp $0, %ebx
	jge show35

	#faktycznie wypisanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

	#przygotowanie rejestrow i buffa dla eax
	movl $result_len, %ebx
	decl %ebx
	movb $'\n', result(%ebx)
	decl %ebx
	movb $' ', result(%ebx)
	decl %ebx
	movl x1, %eax
	#obliczanie pierwszej czesci, czyli eax
show15:
	movl $0, %ecx
	movb %al, %cl
	and $0xF, %ecx
	addl $'0', %ecx
	cmp $':', %ecx
	jb show25
	addl $7, %ecx
show25:
	movb %cl, result(%ebx)
	sar $4, %eax
	decl %ebx
	cmp $0, %ebx
	jge show15

	#faktyczne wyswietlanie
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $result_len, %edx
	int $SYSCALL

	#zakonczenie programu
	mov $SYSEXIT, %eax
	mov $EXT_SUCCESS, %ebx
	int $SYSCALL

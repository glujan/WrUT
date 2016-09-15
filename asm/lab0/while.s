SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDIN = 0
STDOUT = 0
EXT_SUCCESS = 0
SYSCALL = 0x80
buff_len = 2

.align 32
.lcomm buff, buff_len
.text
	msg: .ascii "Zakonczyc (t/n)?\n"
	msg_len = . - msg
	
.global  main
main:
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $msg, %ecx
	mov $msg_len, %edx
	int $SYSCALL

	mov $SYSREAD, %eax
	mov $STDIN, %ebx
	mov $buff, %ecx
	mov $buff_len, %edx
	int $SYSCALL

#cmpb $116, %ecx
	movb buff, %cl
	cmpb $116, %cl
	jne main

	mov $SYSEXIT, %eax
	mov $EXT_SUCCESS, %ebx
	int $SYSCALL

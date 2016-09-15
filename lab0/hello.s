SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 0
EXT_SUCCESS = 0
INTERRUPT = 0x80

.align 32
.text
	txt: .ascii "Hello, World!\n"
	txt_len = . - txt

.global  main
main:
	mov $SYSWRITE, %eax
	mov $STDOUT, %ebx
	mov $txt, %ecx
	mov $txt_len, %edx
	int $INTERRUPT

	mov $SYSEXIT, %eax
	mov $EXT_SUCCESS, %ebx
	int $INTERRUPT

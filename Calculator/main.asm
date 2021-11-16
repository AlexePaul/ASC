.data
	x: .space 4
	y: .space 4
	sum: .space 4
	dif: .space 4
	prod: .space 4
	cat: .space 4
	rest: .space 4
	formatScanfPrint: .asciz "x, y\n"
	formatScanf: .asciz "%d%d"
	formatPrintf: .asciz "x+y = %d\nx-y = %d\nx*y = %d\nx/y = %d, x%y = %d\n" 
.text

.global main

main:

#format input
	pushl $formatScanfPrint
	call printf
	popl %ebx

#input x&y
	pushl $y
	pushl $x
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popl %ebx

#x+y
	mov x,%eax
	add y,%eax
	mov %eax,sum

#x-y
	mov x,%eax
	sub y,%eax
	mov %eax, dif
#x*y
	mov x,%eax
	mov y,%ebx
	imul %ebx
	mov %eax, prod
#x/y
	mov x,%eax
	mov y,%ebx
	idiv %ebx
	mov %eax, cat
	mov %edx, rest
#output
	pushl rest
	pushl cat
	pushl prod
	pushl dif
	pushl sum
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	popl %ebx
	popl %ebx
	popl %ebx
	popl %ebx
	
	mov $1, %eax
	xorl $0, %ebx
	int $0x80

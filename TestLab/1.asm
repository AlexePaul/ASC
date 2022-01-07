.data
nrapel: .long 0
formatPrintf: .asciz "%d\n"
formatScanf: .asciz "%d"
x: .long 0
n: .long 0
.text

f:
pushl %ebp
movl %esp, %ebp
pushl %ebx
movl 8(%ebp), %eax
movl %eax, x
cmp $1, %eax
je fin

xorl %edx, %edx
movl $2, %ecx
idiv %ecx
cmp $0, %edx
je par
cmp $1, %edx
je impar

par:
pushl %eax
call f
popl %ebx
incl nrapel
jmp fin

impar:
movl x, %eax
xorl %edx, %edx
movl $3, %ecx
mul %ecx
incl %eax
pushl %eax
call f
popl %ebx
incl nrapel
jmp fin

fin:
popl %ebx
popl %ebp
ret

.global main

main:

pushl $n
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl n
call f
popl %ebx

pushl nrapel
pushl $formatPrintf
call printf
popl %ebx
popl %ebx

movl $1, %eax
xorl %ebx, %ebx
int $0x80

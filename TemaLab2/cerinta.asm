.data
formatprintf: .asciz "%d\n"
n: .space 4
aux: .space 4
auxr: .space 4
rez: .space 4

.text

factorial:
popl auxr
popl n
cmp $0, n
je case0
decl n
pushl auxr
pushl n
call factorial
popl aux
popl auxr
incl n
movl aux, %eax
mull n
pushl %eax
jmp fin
case0:
pushl $1 
jmp fin
fin:
pushl auxr
ret

.global main

main:
pushl $4
call factorial
popl rez
pushl rez
pushl $formatprintf
call printf
popl %ebx
popl %ebx
movl $1, %eax
xorl %ebx, %ebx
int $0x80

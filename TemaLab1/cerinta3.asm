.data

formatPrintf: .asciz "%d\n"
formatDelimStrtok: .asciz " "
string: .space 100
values: .space 120
res: .space 4
val: .space 4
length: .space 4
x: .space 4
y: .space 4
primcif: .space 4

.text

.global main

main:
pushl $101
pushl $string
call gets
popl %ebx
popl %ebx

pushl $formatDelimStrtok
pushl $string
call strtok
popl %ebx
popl %ebx
movl %eax, res

movl $values, %edi

pushl res
call atoi
popl %ebx
movl %eax, val
cmp $0, val
je varn
cmp $0, val
jg nr

loopEt:

pushl $formatDelimStrtok
pushl $0
call strtok
popl %ebx
popl %ebx
movl %eax, res

cmp $0, res
je exit

pushl res
call atoi
popl %ebx
movl %eax, val
etdb1:
cmp $0, val
je zero
cmp $0, val
jg notZero

ret:
jmp loopEt

exit: 
pushl $formatPrintf
call printf
popl %ebx
popl %ebx
mov $1, %eax
xorl %ebx, %ebx
int $0x80

nr:
pushl val
jmp ret

varn:
movl res, %esi
xorl %ecx, %ecx
movb (%esi, %ecx, 1), %al
sub $97, %al
pushl %eax
jmp ret

zero:
pushl res
call strlen
popl %ebx
etdb:
movl %eax, length
cmp $1, length
je var
cmp $3, length
je operatii

notZero:
pushl val
jmp ret

var:
movl res, %esi
xorl %ecx, %ecx
movb (%esi, %ecx, 1), %al
sub $97, %al
mov %al, %cl
cmp $0, (%edi, %ecx, 4)
je varn
cmp $0, (%edi, %ecx, 4)
jg vars

vars:
movl (%edi, %ecx, 4), %ebx
pushl %ebx
jmp ret

operatii:
movl res, %esi
xorl %ecx, %ecx
xorl %eax, %eax
movb (%esi, %ecx, 1), %al
movb %al, primcif
cmp $97, primcif
je oadd
cmp $115, primcif
je osub
cmp $109, primcif
je omul
cmp $100, primcif
je odiv
cmp $108, primcif
je olet
jmp ret

oadd: 
xorl %eax, %eax
popl x
popl y
movl x, %eax
add y, %eax
pushl %eax
jmp ret

osub: 
xorl %eax, %eax
popl x
popl y
movl y, %eax
sub x, %eax
pushl %eax
jmp ret

omul: 
xorl %eax, %eax
popl %eax
popl %ebx
mul %ebx
pushl %eax
jmp ret

odiv:
xorl %eax, %eax
xorl %edx, %edx
popl %ebx
popl %eax
div %ebx
pushl %eax
jmp ret

olet: 
xorl %ebx, %ebx
xorl %ecx, %ecx
popl %ebx
popl %ecx
movl %ebx, (%edi, %ecx, 4)
jmp ret

.data

formatDelimStrtok: .asciz " "
formatPrintf: .asciz "%d\n"
string: .space 100
res: .space 4
firstNumber: .space 4
atoiRes: .space 4
primcif: .space 4
x: .space 4
y: .space 4

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

pushl res
call atoi
popl %ebx
mov %eax, firstNumber
pushl firstNumber

whileEt:

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
mov %eax, atoiRes
cmp $0, atoiRes
je operatii
cmp $0, atoiRes
jg nr

ret:
jmp whileEt

exit: 
pushl $formatPrintf
call printf
popl %ebx
popl %ebx
mov $1, %eax
xorl %ebx, %ebx
int $0x80

nr:
pushl atoiRes
jmp ret

operatii:
movl res, %edi
xorl %ecx, %ecx
xorl %eax, %eax
movb (%edi, %ecx, 1), %al
movb %al, primcif
cmp $97, primcif
je oadd
cmp $115, primcif
je osub
cmp $109, primcif
je omul
cmp $100, primcif
je odiv
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

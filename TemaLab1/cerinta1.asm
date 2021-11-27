.data

length: .space 4
string: .space 100
formatScanf: .asciz "%s"
formatPrintf: .asciz "sanki:%d\n"

.text

.global main

main:

pushl $string
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $string
call strlen
popl %ebx
movl %eax, length

movl $string, %edi
xorl %ecx, %ecx

forEt:
xorl %ebx, %ebx

cmp $64, (%edi, %ecx, 1)
jl if1
if1r:
incl %ecx
pushl %ecx

pushl %ebx
pushl $formatPrintf
call printf
popl %ebx
popl %ebx
popl %ecx

cmp %ecx, length
jg forEt

exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80

if1:
movl $256, %eax
mulb (%edi, %ecx, 1)
movl %eax,%ebx
jmp if1r

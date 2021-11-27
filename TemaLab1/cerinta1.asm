.data

length: .space 4
string: .space 100
formatScanf: .asciz "%s"
formatPrintf: .asciz "sanki:%d\n"
suma: .long 0
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
movl $0,suma

movb (%edi, %ecx, 1), %al
cmp $64, %al
jl if1
if1r:
incl %ecx
pushl %ecx

pushl suma
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
xorl %ebx,%ebx
movl $256, %eax
movb (%edi, %ecx, 1), %bl
subl $48, %ebx
mull %ebx
movl %eax,suma
jmp if1r

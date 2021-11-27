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
cmp $64, %al
jg if2
if2r:
incl %ecx

movb (%edi, %ecx, 1), %al
cmp $64, %al
jl if3
if3r:
cmp $64, %al
jg if4
if4r:
incl %ecx

movb (%edi, %ecx, 1), %al
cmp $64, %al
jl if5
if5r:
cmp $64, %al
jg if6
if6r:
incl %ecx

pushl %ecx
pushl suma
pushl $formatPrintf
call printf
popl %ebx
popl %ebx
popl %ecx

cmp %ecx, length
jle exit
jmp forEt

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

if2:
xorl %ebx,%ebx
movl $256, %eax
movb (%edi, %ecx, 1), %bl
subl $55, %ebx
mull %ebx
movl %eax,suma
jmp if2r

if3:
xorl %ebx,%ebx
movl $16, %eax
movb (%edi, %ecx, 1), %bl
subl $48, %ebx
mull %ebx
addl suma, %eax
movl %eax, suma
jmp if3r

if4:
xorl %ebx,%ebx
movl $16, %eax
movb (%edi, %ecx, 1), %bl
subl $55, %ebx
mull %ebx
addl suma, %eax
movl %eax, suma
jmp if4r

if5:
xorl %ebx,%ebx
movl $1, %eax
movb (%edi, %ecx, 1), %bl
subl $48, %ebx
mull %ebx
addl suma, %eax
movl %eax, suma
xorl %eax, %eax
jmp if5r

if6:
xorl %ebx,%ebx
movl $1, %eax
movb (%edi, %ecx, 1), %bl
subl $55, %ebx
mull %ebx
addl suma, %eax
movl %eax, suma
xorl %eax, %eax
jmp if6r

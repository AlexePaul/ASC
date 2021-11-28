.data

nr: .space 4
length: .space 4
string: .space 100
formatScanf: .asciz "%s"
formatPrintfNr: .asciz "%d "
formatPrintfNrNeg: .asciz "-%d "
formatPrintfVariabila: .asciz "%c "
formatPrintfNewLine: .asciz "\n"
suma: .long 0
olet: .asciz "let "
oadd: .asciz "add "
osub: .asciz "sub "
omul: .asciz "mul "
odiv: .asciz "div "

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
movl $0,%eax
movl $0,%ebx

#Cifra1
movb (%edi, %ecx, 1), %dl
cmp $64, %dl
jl if1
if1r:
cmp $64, %dl
jg if2
if2r:
incl %ecx

#Cifra2
movb (%edi, %ecx, 1), %dl
cmp $64, %dl
jl if3
if3r:
cmp $64, %dl
jg if4
if4r:
incl %ecx

#Cifra3
xorl %eax, %eax
movb (%edi, %ecx, 1), %dl
cmp $64, %dl
jl if5
if5r:
cmp $64, %dl
jg if6
if6r:
incl %ecx

pushl %ecx
mov suma, %eax
cmp $8, %ah
je numar
cmp $9, %ah
je numarneg

cmp $10, %ah
je var

cmp $12, %ah
je operatie

ret:
pushl $0
call fflush
popl %ebx
popl %ecx
cmp %ecx, length
jle exit
jmp forEt

exit:
pushl $formatPrintfNewLine
call printf
popl %ebx
movl $1, %eax
xorl %ebx, %ebx
int $0x80

if1:
xorl %eax, %eax
xorl %ebx,%ebx
movl $256, %eax
movb (%edi, %ecx, 1), %bl
subl $48, %ebx
mull %ebx
movl %eax,suma
jmp if1r

if2:
xorl %eax, %eax
xorl %ebx,%ebx
movl $256, %eax
movb (%edi, %ecx, 1), %bl
subl $55, %ebx
mull %ebx
movl %eax,suma
jmp if2r

if3:
xorl %eax, %eax
xorl %ebx,%ebx
movl $16, %eax
movb (%edi, %ecx, 1), %bl
subl $48, %ebx
mull %ebx
addl suma, %eax
movl %eax, suma
jmp if3r

if4:
xorl %eax, %eax
xorl %ebx,%ebx
movl $16, %eax
movb (%edi, %ecx, 1), %bl
subl $55, %ebx
mull %ebx
addl suma, %eax
movl %eax, suma
jmp if4r

if5:
xorl %eax, %eax
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
xorl %eax, %eax
xorl %ebx,%ebx
movl $1, %eax
movb (%edi, %ecx, 1), %bl
subl $55, %ebx
mull %ebx
addl suma, %eax
movl %eax, suma
xorl %eax, %eax
jmp if6r

numar:
mov %al, nr
pushl nr
pushl $formatPrintfNr
call printf
popl %ebx
popl %ebx
jmp ret

numarneg:
mov %al, nr
pushl nr
pushl $formatPrintfNrNeg
call printf
popl %ebx
popl %ebx
jmp ret

var:
mov %al, nr
pushl nr
pushl $formatPrintfVariabila
call printf
popl %ebx
popl %ebx
jmp ret

operatie:
cmp $0, %al
je let
cmp $1, %al
je add
cmp $2, %al
je sub
cmp $3, %al
je mul
cmp $4, %al
je div

let:
pushl $olet
call printf
popl %ebx
jmp ret

add:
pushl $oadd
call printf
popl %ebx
jmp ret

sub:
pushl $osub
call printf
popl %ebx
jmp ret

mul:
pushl $omul
call printf
popl %ebx
jmp ret

div:
pushl $odiv
call printf
popl %ebx
jmp ret

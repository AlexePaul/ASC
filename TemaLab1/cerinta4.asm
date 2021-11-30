.data

nrelem: .space 4
x: .space 4
i: .space 4
j: .space 4
m: .space 4
n: .space 4
mat: .space 1601
fscanf: .asciz "%d"
strtokdelim: .asciz " "
fscanf2: .asciz "%c"
fscanf3: .asciz "%s"
fprintf: .asciz "%d "
fendl: .asciz "\n"
string: .space 10
primcif: .space 4
res: .space 4
atres: .space 4

.text

.global main

main:
pushl $x
pushl $fscanf2
call scanf
popl %ebx
popl %ebx
pushl $n
pushl $fscanf
call scanf
popl %ebx
popl %ebx
pushl $m
pushl $fscanf
call scanf
popl %ebx
popl %ebx
lea mat, %esi

movl n, %eax
mull m
movl %eax, nrelem
movl $0, %ecx

xorl %ecx, %ecx
forcit:

pushl %ecx
pushl $x
pushl $fscanf
call scanf

popl %ebx
popl %ebx
movl x, %ebx
popl %ecx
movl %ebx, (%esi, %ecx, 4)
incl %ecx

cmp %ecx, nrelem
jg forcit


pushl $101
pushl $string
call gets
popl %ebx
popl %ebx

pushl $strtokdelim
pushl $string
call strtok
popl %ebx
popl %ebx
movl %eax, res
pushl res
call atoi
popl %ebx
movl %eax, atres

cmp $0, atres
je verif
cmp $0, atres
jne rloc

whileEt:
pushl $strtokdelim
pushl $0
call strtok
dontok:
popl %ebx
popl %ebx

movl %eax, res
cmp $0, res
je exit

pushl res
call atoi
popl %ebx
movl %eax, atres

cmp $0, atres
je operatii
cmp $0, atres
jne rloc
ret:
jmp whileEt

rloc:
pushl atres
jmp ret

verif:
pushl res
call strlen
popl %ebx
cmp $1, %eax
je ret
cmp $3, %eax
je operatii

operatii:
movl res, %edi
xorl %ecx, %ecx
xorl %eax, %eax
movb (%edi, %ecx, 1), %al
movb %al, primcif
cmp $97, %al
je oadd
cmp $115, %al
#je osub
cmp $109, %al
#je omul
cmp $100, %al
#je odiv
jmp ret

oadd:
popl x
xorl %ecx, %ecx
foradd:
movl (%esi, %ecx, 4), %eax
add x, %eax
movl %eax, (%esi, %ecx, 4)
incl %ecx
cmp %ecx, nrelem
jg foradd
jmp exit

exit:
pushl n
pushl $fprintf
call printf
popl %ebx
popl %ebx
pushl m
pushl $fprintf
call printf
popl %ebx
popl %ebx
xorl %ecx, %ecx

foraf:
pushl %ecx
xorl %eax, %eax
movl (%esi, %ecx, 4), %eax
pushl %eax
pushl $fprintf
call printf
popl %ebx
popl %ebx
popl %ecx
incl %ecx

cmp %ecx, nrelem
jg foraf

pushl $fendl
call printf
popl %ebx

movl $1, %eax
xorl %ebx, %ebx
int $0x80

#x 2 2 -1 2 -3 4 let x -10 add
#x 2 2 -1 2 -3 4 let -10 add

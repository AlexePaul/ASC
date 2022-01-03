.data
n: .space 4
m: .space 4
initial: .space 364
solution: .space 364
frecv: .space 124
afisat: .long 0
pos: .space 4
valInitial: .space 4
formatScanf: .asciz "%d%d"
formatScanf2: .asciz "%d"
formatPrintf: .asciz "%d "
formatprintf2: .asciz "\n"
formatprintf3: .asciz "-1"
maxval: .space 4
aux: .space 4
x: .space 4

.text

bkt:
pushl %ebp
movl %esp, %ebp
pushl %ebx
pushl %esi
pushl %edi
movl 8(%ebp), %ebx
movl %ebx, pos

cmp $0, afisat
jne fin

cmp maxval, %ebx
jg afisare
lea initial, %edi
movl pos, %ebx
movl (%edi, %ebx, 4), %ebx
cmp $0, %ebx
je case0
cmp $0, %ebx
jne casen0

afisare:
incl afisat
xorl %ecx, %ecx
incl %ecx
printFor:
lea solution, %esi
movl (%esi, %ecx, 4), %eax
pushl %ecx
pushl %eax
pushl $formatPrintf
call printf
popl %ebx
popl %ebx
popl %ecx
incl %ecx
cmp maxval, %ecx
jle printFor
cmp maxval, %ecx
jg fin

case0:
xorl %ecx, %ecx
incl %ecx
bktfor:
lea frecv, %edi
movl (%edi, %ecx, 4), %eax
cmp $3, %eax
jge finalfor

lea solution, %esi
movl %ecx, %edx
movl pos, %ebx
subl m,%ebx
movl %ebx, %eax

cmp $1, %eax
jge forcet1

movl $1, %eax

forcet1:
movl pos, %ebx
cmp (%esi, %eax, 4), %edx
je finalfor
incl %eax
cmp %ebx, %eax
jl forcet1

lea solution, %edi
movl pos, %ebx
movl %ecx, (%edi, %ebx, 4)
lea frecv, %esi
movl (%esi, %ecx, 4), %eax
incl %eax
movl %eax, (%esi, %ecx, 4)

pushl %ecx
incl pos
pushl pos
call bkt
popl pos
decl pos
popl %ecx

lea frecv, %esi
movl (%esi, %ecx, 4), %eax
decl %eax
movl %eax, (%esi, %ecx, 4)

finalfor:
incl %ecx
cmp n, %ecx
jle bktfor
jmp fin

casen0:
lea initial, %edi
lea solution, %esi
movl pos, %ebx
subl m,%ebx
movl %ebx, %ecx
forcet2:
movl pos, %ebx
movl (%edi, %ebx, 4), %eax
cmp (%esi, %ecx, 4), %eax
je fin
incl %ecx
cmp %ebx, %ecx
jl forcet2

movl pos, %ebx
movl (%edi,%ebx, 4), %eax
lea solution, %edi
movl %eax, (%edi, %ebx, 4)
incl pos
pushl pos
call bkt
popl pos
decl pos

fin:
popl %edi
popl %esi
popl %ebx
popl %ebp
ret

.global main

main:

#reading n
pushl $m
pushl $n
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popl %ebx

movl n, %eax
movl $3, %ebx
mull %ebx
movl %eax, maxval
lea initial, %edi
lea frecv, %esi

xorl %ecx, %ecx
incl %ecx

readfor:
pushl %ecx
pushl $aux
pushl $formatScanf2
call scanf
pustscanf:
popl %ebx
popl %ebx
popl %ecx
lea initial, %edi
lea frecv, %esi
movl aux, %ebx
movl %ebx, (%edi, %ecx, 4)
movl aux, %ebx
movl (%esi,%ebx, 4), %eax
incl %eax
movl %eax, (%esi,%ebx, 4)
incl %ecx 
cmp maxval, %ecx
jle readfor

pushl $1
call bkt
popl %ebx

cmp $0, afisat
jne exitfin
pushl $formatprintf3
call printf
popl %ebx

exitfin:
pushl $formatprintf2
call printf
popl %ebx
movl $1, %eax
xorl %ebx, %ebx
int $0x80

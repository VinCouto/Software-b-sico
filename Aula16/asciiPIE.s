#constantes
    .equ STDIN, 0
    .equ STDOUT, 1
#posições na STACK
    .equ aLetter, -16
    .equ localSize, -16
.section .rodata
printFormat:
    .string "%c\n"
    .section .bss
    .lcomm VETOR 127
    .text
    .globl main
    .type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp
    leaq VETOR(%rip), %rcx
    movl $127, %eax
loop_ascii:
    movl $127, %edx
    subl %eax, %edx
    movb %dl, (%rcx)
    incq %rcx
    subl $1, %eax #Instr. dec não atualiza zero flag
    jnz loop_ascii
    leaq VETOR(%rip), %r12
    leaq VETOR(%rip), %r13
addq $127, %r13 #Fim do vetor
loop_impressao:
    leaq printFormat(%rip), %rdi #endereço da string em rdi
    movq $0, %rax #sem ponto flutuante
    movsbl (%r12), %esi
    call printf
    incq %r12
    cmpq %r13, %r12
    jne loop_impressao
    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

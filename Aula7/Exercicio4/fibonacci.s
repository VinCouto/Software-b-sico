# valor na stack
    .equ umInt, -8
    .equ localSize, -16

    .section .rodata
scanFormat: 
    .string "%li"

printFormat:
    .string "Valor atual da sequencia : %i\n"

    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp


    leaq umInt(%rbp), %rsi
    movq $scanFormat, %rdi
    movq $0, %rax
    call scanf

    movq $1, %rbx # usaremos rbx como nosso anterior
    movq $1, %r12 # usaremos r12 como nosso atual


loop_inicio:

    cmpq umInt(%rbp), %r12 # compara int lido com o atual
    jae loop_fim

    movq %r12, %rsi
    movq $printFormat, %rdi
    movq $0, %rax
    call printf

    movq %r12, %rcx # temp = atual 
    addq %rbx, %r12 # atual = atual + anterior
    movq %rcx, %rbx # anterior = temp

    jmp loop_inicio

loop_fim:


    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

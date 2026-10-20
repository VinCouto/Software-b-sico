# posicoes na stack
    .equ var_a, -8
    .equ var_r, -16
    .equ var_n, -24
    .equ localSize, -32


    .section .rodata
scanFormat:
    .string "%li %li %li"

printFormat:
    .string "%li "
newLine:
    .string "\n"

    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp

    pushq %rbx   # usaremos como nosso contador
    pushq %r12  # usaremos como nosso termo atual

    leaq var_a(%rbp), %rsi
    leaq var_r(%rbp), %rdx
    leaq var_n(%rbp), %rcx
    movq $scanFormat, %rdi
    movq $0, %rax
    call scanf


    movq var_a(%rbp), %r12
    movq $0, %rbx

loop_inicio:

    cmpq var_n(%rbp), %rbx # comparacao para fim do loop
    jge loop_fim

    movq %r12, %rsi
    movq $printFormat, %rdi
    movq $0, %rax
    call printf


    addq var_r(%rbp), %r12  # incrimenta na pa
    incq %rbx   # incrimenta o contador

    jmp loop_inicio

loop_fim:
    movq $newLine, %rdi
    movq $0, %rax
    call printf

    popq %r12
    popq %rbx


    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

#posições na stack
    .equ ptrStr, -15
    .equ localSize, -16

scanFormat:
    .string "Uma string %i\n"


    .text
    .globl main
    .type main, @function
main:
    
    pushq %rbp
    movq %rsp, %rbp
    addq $localsize, %rsp


    leaq prtStr(%rbp), %rsi #end. da string para rsi
    movq $scanFormat, %rdi #end. do formato para rdi
    movq $0, %rax #sem ponto flutuante
    call scanf





    movl $0,%eax
    movq %rbp, %rsp
    popq %rbp
    ret

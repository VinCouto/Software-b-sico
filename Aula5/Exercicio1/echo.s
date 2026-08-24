#constantes
    .equ STDIN, 0
    .equ STDOUT, 1

#posições na STACK
    .equ aLetter, -16
    .equ localSize, -16

    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp
    movl $2, %edx
    leaq aLetter(%rbp), %rsi
    movl $STDIN, %edi
    call read
    movl $2, %edx
    leaq aLetter(%rbp), %rsi
    movl $STDOUT, %edi
    call write
    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret


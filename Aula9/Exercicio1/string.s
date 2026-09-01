#constantes
    .equ STDOUT, 1

    .section .rodata
printFormat:
    .string "String a ser impressa 1.\n"

    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp

    movq $printFormat, %rdi
    movq $0, %rax
    call printf

    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

#constantes
    .equ STDOUT, 1
    .section .rodata
printFormat:
    .string "RIP = %p\n"
    .text
    .globl main
    .type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp
    leaq 0(%rip), %rsi
    leaq printFormat(%rip), %rdi
    movl $0, %eax
    call printf
    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

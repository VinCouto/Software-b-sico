    .section .rodata
printFormat:
    .string "String a ser\n"

    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp

    movq $printFormat, %rbx
    movb $8, (%rbx)

    movq $printFormat, %rdi
    movq $0, %rax
    call printf

    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

#constantes
    .equ STDIN, 0
    .equ STDOUT, 1

#posições na STACK
    .equ char1, -1
    .equ char2, -2
    .equ resultChar, -3
    .equ chardscrt, -4
    .equ localSize, -16 

    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp

    movl $1, %edx
    leaq char1(%rbp), %rsi
    movl $STDIN, %edi
    call read

    movl $1, %edx
    leaq chardscrt(%rbp), %rsi
    movl $STDIN, %edi
    call read

    movl $1, %edx
    leaq char2(%rbp), %rsi
    movl $STDIN, %edi
    call read

    movl $1, %edx
    leaq chardscrt(%rbp), %rsi
    movl $STDIN, %edi
    call read

    movzbq char1(%rbp), %rax
    subq $'0', %rax

    movzbq char2(%rbp), %rcx
    subq $'0', %rcx

    addq %rcx, %rax

    addq $'0', %rax
    movb %al, resultChar(%rbp)
  

    movl $1, %edx
    leaq resultChar(%rbp), %rsi
    movl $STDOUT, %edi
    call write

    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

# constante 
    .equ STDIN, 0
    .equ STDOUT, 1
    .equ READ, 0
    .equ WRITE, 1
    .equ EXIT, 60
# posições na stack
    .equ ptrStr, -16
    .equ localSize, -16

    .section .rodata
scanFormat:
    .string "%15[^\n]"

printFormat:
    .string "%s\n"
    .equ printFormatSz, .-printFormat-1

    .text
    .globl __start
__start:
    pushq %rbp
    movq %rsp,%rbp
    addq $localSize, %rsp


    movq $16, %rdx
    leaq ptrStr(%rbp), %rsi 
    movq $STDIN, %rdi 
    movl $READ, %eax
    syscall # scanf


    pushq %rbx
    leaq ptrStr(%rbp), %rbx 
loop_inicio:
    movb (%rbx), %al
    cmpb $0, %al 
    je loop_fim

    cmpb $'a', %al
    jb proximo_char 

    cmpb $'z', %al
    ja proximo_char 

    subb $32, %al
    movb %al, (%rbx)

proximo_char:
    incq %rbx 
    jmp loop_inicio 

loop_fim:
    popq %rbx   

    movq $16, %rdx
    leaq ptrStr(%rbp), %rsi 
    movq $STDOUT, %rdi  
    movl $WRITE, %eax 
    syscall # printf

    movq %rbp, %rsp
    popq %rbp
    movq $0, %rdi    
    movl $EXIT,%eax
    syscall

.equ STDIN, 0
    .equ STDOUT, 1
    .equ READ, 0
    .equ WRITE, 1
    .equ EXIT, 60

    .section .bss
    .lcomm VETOR, 64

    .text
    .globl __start
__start:
    pushq %rbp
    movq %rsp, %rbp

    pushq %r12
    pushq %r13

    movq $123456, %rax
    leaq VETOR(%rip), %r13
    movq $0, %rbx

loop_vetor:
    cmpq $0, %rax
    je loop_fim

    xorq %rdx, %rdx
    movq $10, %rcx
    divq %rcx

    addb $48, %dl
    movb %dl, (%r13)

    incq %r13
    incq %rbx
    jmp loop_vetor

loop_fim:
    movq %rbx, %rdx
    leaq VETOR(%rip), %rsi
    movq $STDOUT, %rdi
    movq $WRITE, %rax
    syscall

epilogo:
    popq %r13
    popq %r12

    movq %rbp, %rsp
    popq %rbp
    
    movq $EXIT, %rax
    xorq %rdi, %rdi
    syscall

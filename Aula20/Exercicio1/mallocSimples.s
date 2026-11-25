    .equ STDIN, 0
    .equ STDOUT, 1
    .equ READ, 0
    .equ WRITE, 1
    .equ BRK, 12
    .equ EXIT, 60

    .equ ALINHAMENTO, 16

    .section .bss
    .lcomm pausa_buf, 2

    .text
    .globl _start
    .type _start, @function
_start:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp             

    call valorBRK

    movq $1, %rdi
    call alocarMemoria
    movq %rax, -8(%rbp)

    call L_pausa
    movq -8(%rbp), %rax
    movb $'a', (%rax)          

    movq $16, %rdi
    call alocarMemoria
    movq %rax, -16(%rbp)

    call L_pausa
    movq -16(%rbp), %rax
    movb $'b', (%rax)

    movq $4096, %rdi
    call alocarMemoria
    movq %rax, -24(%rbp)

    call L_pausa
    movq -24(%rbp), %rax
    movb $'c', 4095(%rax)

    movq $4096, %rdi
    call alocarMemoria
    movq %rax, -32(%rbp)

    call L_pausa
    movq -32(%rbp), %rax
    movb $'d', 4095(%rax)

    call valorBRK

    movq $EXIT, %rax
    xorq %rdi, %rdi
    syscall

L_pausa:
    movq $READ, %rax
    movq $STDIN, %rdi
    leaq pausa_buf(%rip), %rsi
    movq $2, %rdx
    syscall
    ret


    .globl valorBRK
    .type valorBRK, @function
valorBRK:
    movq $BRK, %rax
    xorq %rdi, %rdi            
    syscall
    ret


    .globl alocarMemoria
    .type alocarMemoria, @function
alocarMemoria:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12

    cmpq $0, %rdi
    jle L_alloc_zero


    movq %rdi, %rax
    xorq %rdx, %rdx
    movq $ALINHAMENTO, %rcx
    divq %rcx                   
    testq %rdx, %rdx
    jz L_alinhado

    movq $ALINHAMENTO, %rax
    subq %rdx, %rax            
    addq %rax, %rdi            

L_alinhado:
    movq %rdi, %rbx             

   
    call valorBRK
    movq %rax, %r12             
   
    movq %r12, %rdi
    addq %rbx, %rdi
    cmpq %r12, %rdi
    jb L_alloc_erro

    movq $BRK, %rax
    syscall

    cmpq %rdi, %rax
    jb L_alloc_erro

    movq %r12, %rax            
    jmp L_alloc_fim

L_alloc_zero:
    call valorBRK
    jmp L_alloc_fim

L_alloc_erro:
    xorq %rax, %rax

L_alloc_fim:
    popq %r12
    popq %rbx
    popq %rbp
    ret

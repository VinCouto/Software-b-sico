# constante
    .equ TAMANHO, 64
    .equ TAMANHO_VET3, 128
    .equ STDOUT, 1
  
    .section .rodata
printFormat:
    .string "vet3[%3i]: %li\n"

    .section .bss
    .lcomm VET1 512
    .lcomm VET2 512
    .lcomm VET3 1024

    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp

    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14


    movq $VET1, %r12
    movq $VET2, %r13
    movq $0, %rbx

loop_preenchimento:
    cmpq $TAMANHO, %rbx
    jge inicializa_intercalado

    # VET1[i] = i + 10
    movq %rbx, %rax
    addq $10, %rax
    movq %rax, (%r12)

    # VET2[i] = i * 2
    movq %rbx, %rax
    addq %rax, %rax
    movq %rax, (%r13)


    addq $8, %r12
    addq $8, %r13
    incq %rbx
    jmp loop_preenchimento

inicializa_intercalado:
    movq $VET1, %r12
    movq $VET2, %r13
    movq $VET3, %r14
    movq $0, %rbx

loop_intercalado:
    cmpq $TAMANHO, %rbx
    jge inicializa_impressão

    movq (%r12), %rax
    movq %rax, (%r14)
    addq $8, %r14
    movq (%r13), %rax
    movq %rax, (%r14)

    addq $8, %r12
    addq $8, %r13
    addq $8, %r14
    incq %rbx
    jmp loop_intercalado

inicializa_impressão:
    movq $VET3, %r14
    movq $0, %rbx

loop_impressão:
    cmpq $TAMANHO_VET3, %rbx
    jge loop_fim

    movq $printFormat, %rdi
    movq %rbx, %rsi
    movq (%r14), %rdx
    movq $0, %rax
    call printf

    addq $8, %r14
    incq %rbx
    jmp loop_impressão

loop_fim:
    popq %r14
    popq %r13
    popq %r12
    popq %rbx

    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

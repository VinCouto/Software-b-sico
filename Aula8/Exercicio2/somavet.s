#constantes
  .equ STDOUT, 1
  .equ TAMANHO, 64
  .equ localSize, -512

    .section .rodata
printFormat:
    .string "vet3[%2i] = %li\n "

    .section .bss
    .lcomm VET1 512
    .lcomm VET2 512

    .text
    .globl main
    .type main, @function

main:
    push %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp

    pushq %rbx
    pushq %r12
    pushq %r13
    movq $0, %rbx

loop_preenchimento:
    cmpq $TAMANHO, %rbx
    jge inicializa_soma

    # VET1[i] = i + 10
    movq %rbx, %rax
    addq $10, %rax
    movq %rax, VET1(,%rbx,8)

    # VET2[i] = i * 2
    movq %rbx, %rax
    addq %rax, %rax
    movq %rax, VET2(,%rbx,8)

    incq %rbx
    jmp loop_preenchimento

inicializa_soma:
    movq $VET1, %r12
    movq $VET2, %r13
    leaq -512(%rbp), %rcx # ponteiro inicio vet3

    movq $0, %rbx # reseta o indice i = 0    

loop_soma:
    cmpq $TAMANHO, %rbx
    jge inicializa_impressão

    # le VET1 e VET2
    movq (%r12), %rax
    movq (%r13), %rdx

    # soma
    addq %rdx, %rax

    movq %rax, (%rcx)

    addq $8, %r12
    addq $8, %r13
    addq $8, %rcx

    incq %rbx
    jmp loop_soma

inicializa_impressão:
    leaq -512(%rbp), %r12
    movq $0, %r13 # mais uma vez resetando o i 

loop_impressão:
    cmpq $TAMANHO, %r13
    jge loop_fim

    movq $printFormat, %rdi
    movq %r13, %rsi
    movq (%r12), %rdx
    movq $0, %rax
    call printf

    addq $8, %r12
    incq %r13
    jmp loop_impressão

loop_fim:

    popq %r13
    popq %r12
    popq %rbx

    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

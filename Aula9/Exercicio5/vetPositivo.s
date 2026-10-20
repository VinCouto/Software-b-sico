# constantes
    .equ STACK_FRAME, 16
    .equ TAMANHO, 64
    .equ umInt, -4
    .equ localSize, -16

    .section .rodata

scanFormat:
    .string "%i\n"

printFormat:
    .string "%i "
printQntd:
    .string "Quantidade de elementos: %i\n"
printNewLine:
    .string "\n"

    .section .bss

    .lcomm VETOR1 256
    .lcomm VETOR2 256

    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp

    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14

    movq $0, %rbx
    movq $VETOR1, %r12

loopScan:
    cmpq $TAMANHO, %rbx
    jge preenchimento_vet

    movq $scanFormat, %rdi
    leaq umInt(%rbp), %rsi
    movq $0, %rax
    call scanf

    movl umInt(%rbp), %eax
    movl %eax, (%r12)
    
    addq $4, %r12
    incq %rbx
    jmp loopScan

preenchimento_vet:

    movq $0, %rbx
    movq $VETOR1, %r12
    movq $VETOR2, %r13

loop_vet:
    cmpq $TAMANHO, %rbx
    jge print

    cmpl $0, (%r12)
    jl prox_int

    movl (%r12), %r14d
    movl %r14d, (%r13)
    addq $4, %r13

prox_int:
    incq %rbx
    addq $4, %r12
    jmp loop_vet

print:
    movq $0, %rbx # contador quantos positivos
    movq $VETOR2, %r12

loop_print:
    cmpl $0, (%r12)
    je loop_fim

    movq $printFormat, %rdi
    movl (%r12), %esi
    movq $0, %rax
    call printf

    addq $4, %r12
    incq %rbx
    jmp loop_print

loop_fim:

    movq $printQntd, %rdi
    movq %rbx, %rsi
    movq $0, %rax
    call printf

    popq %r14
    popq %r13
    popq %r12
    popq %rbx

    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret


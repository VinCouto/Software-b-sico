# constantes
    .equ TAM_VET, 25


    .section .rodata
printFormat:
    .string "String a ser impressa 1.\n"

printResult:
    .string "%c"

    .section .bss
    .lcomm VETOR TAM_VET

    .text
    .globl main
    .type main, @function
 
main:
    pushq %rbp
    movq %rsp, %rbp

    pushq %r12

    movq $0, %rbx
    movq $printFormat, %r12
    movq $VETOR, %r13

loop_preenchimento:
    cmpq $TAM_VET, %rbx
    jge print

    cmpb $'a', (%r12)
    jl preenchimento_Vet

    cmpb $'z', (%r12)
    jg preenchimento_Vet


    movb (%r12), %r14b
    subb $32 ,%r14b
    movb %r14b, (%r13)
    jmp proximo_char

preenchimento_Vet:
    movb (%r12), %r14b
    movb %r14b, (%r13)


proximo_char:
    incq %r13
    incq %rbx
    incq %r12
    jmp loop_preenchimento

print:
    movq $0, %rbx
    movq $VETOR, %r13

loop_print:
    cmpq $TAM_VET, %rbx
    jge loop_fim

    movsbl (%r13), %esi
    movq $printResult, %rdi
    movq $0, %rax
    call printf

    incq %rbx
    incq %r13
    jmp loop_print

loop_fim:

    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

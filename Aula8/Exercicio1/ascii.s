#constantes
    .equ STDOUT, 1
    .equ umInt, -8
    .equ localSize, -16
    .section .rodata
scanFormat:
    .string "%li"
printFormat:
    .string "%li %c\n"
errorMessage:    
    .string "Caracter inválido\n"

    .section .bss
    .lcomm VETOR 127
    
    .text
    .globl main
    .type main, @function

main:
    pushq %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp


loop_scan:
    leaq umInt(%rbp), %rsi
    movq $0, %rax
    movq $scanFormat, %rdi
    call scanf

    cmpl umInt(%rbp), %eax
    jge loop_erro

    jmp loop_preenchimento

loop_erro:
    movq $errorMessage, %rdi
    movq $0, %rax
    call printf
    jmp loop_scan

loop_preenchimento:

    movq $VETOR, %rcx
    movq umInt(%rbp), %rbx

loop_ascii:
    movb %bl, (%rcx)

    incq %rcx
    decq %rbx
    jge loop_ascii

    # Aqui não vai ter jeito, vou precisar comparar
    movq $VETOR, %r12
    movq $printFormat, %rdi # endereço da string em rdi
    movq umInt(%rbp), %rsi
    
    movsbl (%r12), %edx
    movq $0, %rax # sem ponto flutuante
    call printf

    popq %r12
    popq %rbx
    
    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

# posições na stack
    .equ ptrStr, -16
    .equ localSize, -16

    .section .rodata
scanFormat:
    .string "%15[^\n]"

printFormat:
    .string "%s\n"

    .text
    .globl main
    .type main, @function
main:
    
    pushq %rbp
    movq %rsp,%rbp
    addq $localSize, %rsp


    leaq ptrStr(%rbp), %rsi # end. da string para rsi
    movq $scanFormat, %rdi # end. do formato para rdi
    movq $0, %rax # sem ponto flutuante
    call scanf


    # movl $56, ptrStr(%rbp)

    pushq %rbx # salva rbx na pilha
    leaq ptrStr(%rbp), %rbx # rbx aponta para o inicio da pilha
loop_inicio:
    movb (%rbx), %al # le um byte
    cmpb $0, %al # verifica se esta no final da pilha
    je loop_fim

    cmpb $'a', %al # compara com o primeiro caracter 'a'
    jb proximo_char # se for menor ja pula para o prox char

    cmpb $'z', %al # compara com o ultimo caracter 'z'
    ja proximo_char # se for maior pula para o proxima char

    subb $32, %al
    movb %al, (%rbx)

proximo_char:
    incq %rbx # incrementa o ponteiro em um byte
    jmp loop_inicio # volta para o inicio do loop_

loop_fim:
    popq %rbx # retorna valor original de rbx

    leaq ptrStr(%rbp), %rsi # copia pilha esi
    movq $printFormat, %rdi   # endereço string em edi
    movq $0, %rax # sem ponto flutuante
    call printf # jump e link para printf

    movl $0,%eax
    movq %rbp, %rsp
    popq %rbp
    ret

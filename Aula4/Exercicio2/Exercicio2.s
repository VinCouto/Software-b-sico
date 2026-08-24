    .text
    .globl main
    .type main, @function

main:
    pushq %rbp # salvar o frame pointer na pilha
    movq %rsp, %rbp # copiar o stack pointer para o frame pointer
    subq $16, %rsp # Abre 16 bytes de espaço na pilha

    movl $1, 12(%rsp)   # Equivalente ao antigo -4(%rbp)
    movl $0, 8(%rsp)    # Equivalente ao antigo -8(%rbp)
   
    movl $9 , %eax
    movq %rbp, %rsp # voltar a pilha para a posição original
    popq %rbp # carregar o valor salvo do frame pointer da pilha
    ret # retornar ao chamador


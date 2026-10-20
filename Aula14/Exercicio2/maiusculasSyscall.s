    .equ STDIN, 0
    .equ STDOUT, 1
    .equ READ, 0
    .equ WRITE, 1
    .equ EXIT, 60

.data
prompt: 
    .ascii "Digite um texto: "
    .equ len_prompt, . - prompt

    .text
    .globl convertemaiusculas
    .type convertemaiusculas, @function
convertemaiusculas:
    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %rax
    movabsq $0xDFDFDFDFDFDFDFDF, %rcx

L_loop:
    movq (%rdi), %rdx
    cmpq $0, %rdx
    je L_fim

    andq %rcx, %rdx
    movq %rdx, (%rdi)
    addq $8, %rdi
    jmp L_loop

L_fim:
    popq %rbp
    ret


    .globl main
    .type main, @function
__start:
    pushq %rbp
    movq %rsp, %rbp


    movl $WRITE, %eax           
    movq $STDOUT, %rdi        
    movabsq $prompt, %rsi   # Ponteiro para a mensagem
    movq $len_prompt, %rdx  # Tamanho da mensagem
    syscall


    # Vamos alocar espaço na pilha para o buffer (ex: 32 bytes alinhados a 8)
    subq $32, %rsp
    
    movl $READ, %eax         
    movq $STDIN, %rdi         
    movq %rsp, %rsi         # Ponteiro para o buffer na pilha (%rsp)
    movq $31, %rdx          # Número máximo de bytes para ler
    syscall                 # Retorna em %rax a quantidade de bytes lidos

    movq %rsi, %rdi         # Move o ponteiro do buffer para %rdi

    call convertemaiusculas

    movq %rax, %rdx         # Quantidade de bytes lidos anteriormente (retornada pelo read)
    movl $WRITE, %eax          
    movq $STDOUT, %rdi          
    # %rsi já aponta para o buffer com o texto convertido
    syscall

    # 5. Finalizar o programa (sys_exit)
    # exit(0)
    movq $60, %rax          # Número da syscall sys_exit = 60
    xorq %rdi, %rdi         # Código de saída 0
    syscall

.section .note.GNU-stack,"",@progbits
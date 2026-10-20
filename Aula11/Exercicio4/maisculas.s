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

    .text
    .globl somaDigInt
    .type somaDigInt, @function
somaDigInt:
    pushq %rbp
    movq %rsp, %rbp

    cmpq $0, %rdi
    je caso_base

    jmp continua_Rec
    
caso_base:
    movl $0, %eax
    jmp epilogo

continua_Rec:
    movq %rdi, %rax
    xorq %rdx, %rdx
    movq $10, %rbx
    divq %rbx

    pushq %r12
    movq %rdx, %r12
    
    movq %rax, %rdi
    call somaDigInt
    
    addl %r12d, %eax
    popq %r12

epilogo:
    movq %rbp, %rsp
    popq %rbp
    ret

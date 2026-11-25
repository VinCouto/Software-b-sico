    .text
    .globl intDecToBin
    .type intDecToBin, @function
intDecToBin:
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
    movq $2, %rbx
    divq %rbx

    pushq %r12
    movq %rdx, %r12
    movq %rax, %rdi
    call intDecToBin
    
    movl %r12d, %edx
    movl $10, %ecx
    imull %ecx, %eax
    addl %edx, %eax
    
    popq %r12 

epilogo:
    movq %rbp, %rsp
    popq %rbp
    ret

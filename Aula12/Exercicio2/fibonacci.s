    .equ POS_N, -8
    .equ POS_FIB1, -16    
    
    .text
    .globl fibRec
    .type fibRec, @function
fibRec:
    pushq %rbp
    movq %rsp, %rbp
    sub $16, %rsp

    cmpl $0, %edi
    je caso_0

    cmpl $1, %edi
    je caso_1

    jmp continua_fib

caso_0:
    movl $0, %eax
    jmp epilogo

caso_1:
    movl $1, %eax
    jmp epilogo

continua_fib:
    movl %edi, POS_N(%rbp)
    decl %edi
    call fibRec
    movl %eax, POS_FIB1(%rbp)


    movl POS_N(%rbp), %edi 
    subl $2, %edi
    call fibRec

    addl POS_FIB1(%rbp), %eax

epilogo:
    movq %rbp, %rsp
    popq %rbp
    ret


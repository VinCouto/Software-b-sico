
    .text
    .globl kCharRec
    .type kCharRec, @function
kCharRec:
    pushq %rbp
    movq %rsp, %rbp

    pushq %rbx
    movzbl %sil, %ebx
    
    movb (%rdi), %al
    cmpb $0, %al
    je caso_base

    jmp continua_rec

caso_base:
    movl $0, %eax
    jmp epilogo


continua_rec:
    pushq %rdi
    incq %rdi
    call kCharRec
    popq %rdi

    movb (%rdi), %dl
    cmpb %bl, %dl
    jne epilogo
    addl $1, %eax

epilogo:
    movq %rbp, %rsp
    popq %rbp
    ret




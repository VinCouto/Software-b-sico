
    .text
    .globl fibonacci
    .type fibonacci, @function
fibonacci:
    pushq %rbp
    movq %rsp, %rbp

    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
  
    movl %edi, %r14d
    movq $0, %r12
    movq $1, %r13
    movl $0, %ebx

loop_fibonacci:
    cmpl %r14d, %ebx
    jge loop_fim

    movq %r13, %rax
    addq %r12, %r13
    movq %rax, %r12

    incq %rbx
    jmp loop_fibonacci

loop_fim:

    movl %r13d, %eax
    popq %r14
    popq %r13
    popq %r12
    popq %rbx

    movq %rbp, %rsp
    popq %rbp
    ret


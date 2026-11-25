    .section .rodata
printFormat:
    .string "A chamada atual é a: %d\n"
msg:
    .string "GNU significa GNU's not linux \nGNU por sua vez significa\n"
printEnd:
    .string "O endereço sp atual é: %d\n"

    .text
    .globl gnuRec
    .type gnuRec, @function
gnuRec:
    pushq %rbp
    movq %rsp, %rbp

    pushq %r12
    movq %rdi, %r12

    movq $printFormat, %rdi
    movq %r12, %rdx
    movq $0, %rax
    call printf

    movq $msg, %rdi
    movq $0, %rax
    call printf

    movq $printEnd, %rdi
    movq %rsp, %rsi
    movq $0, %rax
    call printf


    movq %r12, %rdi
    incq %rdi
    call gnuRec
    
    popq %r12

    movl $0, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

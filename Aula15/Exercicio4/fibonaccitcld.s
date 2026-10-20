.equ STDIN, 0
    .equ STDOUT, 1
    .equ READ, 0
    .equ WRITE, 1
    .equ EXIT, 60

    .section .bss
    .lcomm buffer, 32        

    .text
    .globl __start
__start:
    pushq %rbp
    movq %rsp, %rbp

    movq $READ, %rax
    movq $STDIN, %rdi
    leaq buffer(%rip), %rsi
    movq $31, %rdx
    syscall


    leaq buffer(%rip), %rdi
    call strToInt               
    movq %rax, %r14            
    movq $1, %rbx               
    movq $1, %r12               

loop_inicio:
    cmpq %r14, %r12             
    jae loop_fim

    movq %r12, %rax
    leaq buffer(%rip), %rdi
    call intToAscii            


    movq $WRITE, %rax
    movq $STDOUT, %rdi
    syscall

    movq %r12, %rcx             
    addq %rbx, %r12            
    movq %rcx, %rbx             

    jmp loop_inicio

loop_fim:
    movq $EXIT, %rax
    xorq %rdi, %rdi
    syscall



    .globl strToInt
    .type strToInt, @function
strToInt:
    pushq %rbp
    movq %rsp, %rbp
    movl $0, %eax               

.L_str_loop:
    movzbl (%rdi), %ecx        
    cmpb $0, %cl               
    je .L_str_fim
    cmpb $10, %cl               
    je .L_str_fim

    subb $48, %cl              
    imull $10, %eax            
    addl %ecx, %eax            

    incq %rdi                  
    jmp .L_str_loop

.L_str_fim:
    popq %rbp
    ret




    .globl intToAscii
    .type intToAscii, @function
intToAscii:
    pushq %rbp
    movq %rsp, %rbp

    addq $31, %rdi
    movb $10, (%rdi)           
    movl $1, %ecx               

    cmpq $0, %rax
    jne L_asc_loop
    decq %rdi
    movb $48, (%rdi)            
    incl %ecx
    jmp L_asc_fim

L_asc_loop:
    cmpq $0, %rax
    je L_asc_fim

    xorq %rdx, %rdx
    movq $10, %r8
    divq %r8                    

    addb $48, %dl               
    decq %rdi
    movb %dl, (%rdi)
    incl %ecx

    jmp L_asc_loop

L_asc_fim:
    movq %rdi, %rsi            
    movl %ecx, %edx             
    popq %rbp
    ret

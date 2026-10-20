    .equ STDIN, 0
    .equ STDOUT, 1
    .equ READ, 0
    .equ WRITE, 1
    .equ EXIT, 60
#stack
    .equ aInt, -8
    .equ localSize, -16

    .section .data
prompt:
    .ascii "Digite um numero: "
    .equ promptSz, .-prompt
msg:
    .string "Voce digitou: "
    .equ msgSz, .-msg 

    .section .bss
    .lcomm buffer, 32           

    .text
    .globl __start
__start:
    pushq %rbp
    movq %rsp,%rbp
    addq $localSize,%rsp
    
    movq $WRITE, %rax
    movq $STDOUT, %rdi
    leaq prompt(%rip), %rsi
    movq $promptSz, %rdx
    syscall


    movq $READ, %rax           
    movq $STDIN, %rdi           
    leaq buffer(%rip), %rsi     
    movq $31, %rdx              
    syscall                    

  
    leaq buffer(%rip), %rdi     
    call strToInt               

    movl %eax, aInt(%rbp)

    movq $WRITE, %rax
    movq $STDOUT, %rdi
    leaq msg(%rip), %rsi
    movq $msgSz, %rdx
    syscall

    movq $32, %rdx
    movq aInt(%rbp), %rsi
    movq $STDOUT, %rdi
    movq $WRITE, %rax
    syscall

    movq aInt(%rbp), %rdi  
    movq %rbp, %rsp
    popq %rbp           
    movq $EXIT, %rax            
    syscall


    .globl strToInt
    .type strToInt, @function
strToInt:
    pushq %rbp
    movq %rsp, %rbp

    movl $0, %eax               

L_loop:
    movzbl (%rdi), %ecx        
    cmpb $0, %cl               
    je L_fim
    cmpb $10, %cl               
    je L_fim

    subb $48, %cl              

    imull $10, %eax            
    addl %ecx, %eax            

    incq %rdi                  
    jmp L_loop

L_fim:
    popq %rbp
    ret

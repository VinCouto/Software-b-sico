# constante
    .equ STDIN, 0
    .equ STDOUT, 1
    .equ READ, 0
    .equ WRITE, 1
    .equ EXIT, 60
# posicoes na stack
    .equ var_a, -8
    .equ var_r, -16
    .equ var_n, -24
    .equ localSize, -32


    .section .rodata
space_str:
    .string " "
    .equ space_Sz, .-space_str-1

printFormat:
    .string "%li "
newLine:
    .string "\n"
    .equ newLineSz, .-newLine-1


    .section .bss
    .lcomm buffer, 32


    .text
    .globl __start
__start:
    pushq %rbp
    movq %rsp, %rbp
    addq $localSize, %rsp

    pushq %rbx   # usaremos como nosso contador
    pushq %r12  # usaremos como nosso termo atual

    movq $9, %rdx
    leaq var_a(%rbp), %rsi
    movq $STDIN, %rdi
    movl $READ, %eax
    syscall
    leaq buffer(%rip), %rdi
    call strToInt               # Retorna o inteiro em %eax
    movslq %eax, %rax
    movq %rax, var_a(%rbp)
    
    movq $9, %rdx
    leaq var_r(%rbp), %rdx
    movq $STDIN, %rdi
    movl $READ, %eax
    syscall
    leaq buffer(%rip), %rdi
    call strToInt
    movslq %eax, %rax
    movq %rax, var_r(%rbp)

    movq $9, %rdx
    leaq var_n(%rbp), %rcx
    movq $STDIN, %rdi
    movl $READ, %eax
    syscall
    leaq buffer(%rip), %rdi
    call strToInt
    movslq %eax, %rax
    movq %rax, var_n(%rbp)


    movq var_a(%rbp), %r12
    movq $0, %rbx

loop_inicio:
    
    movq var_n(%rbp), %rax
    cmpq %rax, %rbx             # Compara contador com n (rbx >= n?)
    jge loop_fim

    movq %r12, %rax
    leaq buffer(%rip), %rdi
    call intToAscii

    movq $WRITE, %rax
    movq $STDOUT, %rdi
    syscall

    movq $WRITE, %rax
    movq $STDOUT, %rdi
    leaq space_str(%rip), %rsi
    movq $space_Sz, %rdx
    syscall


    movq var_r(%rbp), %rax
    addq %rax, %r12             
    incq %rbx

    jmp loop_inicio

loop_fim:
    movq $newLineSz, %rdx
    movq newLine(%rip), %rsi
    movq $STDOUT, %rdi
    movl $WRITE, %eax
    syscall

    popq %r12
    popq %rbx


    movq $0, %rdi
    movq %rbp, %rsp
    popq %rbp
    movl $EXIT, %eax
    syscall



    .globl strToInt
    .type strToInt, @function
strToInt:
    pushq %rbp
    movq %rsp, %rbp
    movl $0, %eax               

L_str_loop:
    movzbl (%rdi), %ecx        
    cmpb $0, %cl               
    je L_str_fim
    cmpb $10, %cl               # Tecla Enter ('\n')
    je L_str_fim

    subb $48, %cl              
    imull $10, %eax            
    addl %ecx, %eax            

    incq %rdi                  
    jmp L_str_loop

L_str_fim:
    popq %rbp
    ret


    .globl intToAscii
    .type intToAscii, @function
intToAscii:
    pushq %rbp
    movq %rsp, %rbp

    addq $31, %rdi
    movb $0, (%rdi)           
    movl $0, %ecx               

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

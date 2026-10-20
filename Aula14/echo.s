#constantes
  .equ STDIN,0
  .equ STDOUT,1
  .equ READ,0
  .equ WRITE,1
  .equ EXIT,60
#posições na stack
  .equ aLetter,-16
  .equ localSize,-16
  .section .rodata
prompt:
  .string "Digite um caractere: "
  .equ promptSz,.-prompt-1
msg:
  .string "Voce digitou: "
  .equ msgSz,.-msg-1
  .text
  .globl __start
__start:
  pushq %rbp
  movq %rsp,%rbp
  addq $localSize,%rsp#constantes

  movq $promptSz,%rdx #tamanho da string em rdx
  movq $prompt,%rsi #endereço da string em rsi
  movq $STDOUT,%rdi #id arquivo saída em rdi
  movl $WRITE, %eax #código syscall em rax
  syscall #chama o S.O.
  
  movq $2,%rdx
  leaq aLetter(%rbp),%rsi
  movq $STDIN, %rdi
  movl $READ, %eax
  syscall
  
  movq $msgSz,%rdx
  movq $msg,%rsi
  movq $STDOUT,%rdi
  movl $WRITE,%eax
  syscall
  
  movq $2, %rdx
  leaq aLetter(%rbp),%rsi
  movq $STDOUT,%rdi
  movl $WRITE,%eax
  syscall

  movq %rbp,%rsp
  popq %rbp
  movq $0, %rdi #valor que será retornado ao S.O.
  movl $EXIT,%eax #código da syscall exit em rax
  syscall #syscall para terminar o programa

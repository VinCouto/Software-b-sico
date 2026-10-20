    .text
    .globl sumInts
    .type sumInts, @function
sumInts:
    pushq %rbp
    movq %rsp, %rbp
    addl %edi, %esi #esi = esi+edi. Soma considerando 4 bytes
    movl %esi, %eax #retorno em a
    movq %rbp, %rsp
    popq %rbp
  ret

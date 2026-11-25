#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define ALINHAMENTO 16

void * alocarMemoria(intptr_t bytes){
  intptr_t resto = bytes % ALINHAMENTO;
  if (resto != 0)
    bytes = bytes + ALINHAMENTO - resto;
  void* retorno = sbrk(bytes);
  if (retorno ==  (void*) -1){
    int erro = errno;
    printf("SBRK falhou: errno = %d (%s)\n", errno, strerror(erro));
    exit (1);
  }
  return retorno;
}

void* valorBRK(){
  return sbrk(0);  
}

int main() {

char c[2];
printf("Mantenha esse printf aqui...\n");
printf("BRK Atual: %p\n", valorBRK());

void* ptr1 = alocarMemoria(1);
printf("PTR1: %p\n", ptr1);
read(STDIN_FILENO, c, 2); // char + \n
((char*)ptr1)[0] = 'a';
read(STDIN_FILENO, c, 2); // char + \n

void* ptr2 = alocarMemoria(16);
printf("PTR2: %p\n", ptr2);
((char*)ptr2)[0] = 'b';
read(STDIN_FILENO, c, 2);

void* ptr3 = alocarMemoria(4096);
printf("PTR3: %p\n", ptr3);
((char*)ptr3)[4095] = 'c';
read(STDIN_FILENO, c, 2);

void* ptr4 = alocarMemoria(4096);
printf("PTR4: %p\n", ptr4);
((char*)ptr4)[4095] = 'd';
read(STDIN_FILENO, c, 2);
printf("BRK Atual: %p\n", valorBRK());
return 0;
}
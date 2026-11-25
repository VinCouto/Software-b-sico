#include <stdio.h>
#include <stdlib.h>
#include "somaDigInt.h"

int main (){
  int digito, res;
  
  printf("Digite um inteiro qualquer: ");
  scanf("%d", &digito);
  
  res = somaDigInt(digito);
  printf("A soma dos digitos do inteiro que voce digitou é: %d \n", res);

  return 0;
}
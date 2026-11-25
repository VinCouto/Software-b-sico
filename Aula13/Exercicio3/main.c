#include <stdio.h>
#include <stdlib.h>
#include "intDecToBin.h"

int main (){

  int decimal, binario;
  
  printf("Digite um decimal: ");
  scanf("%d", &decimal);
  
  binario = intDecToBin(decimal);
  printf("O decimal %d em binario é: %d\n", decimal, binario);

  return 0;
}
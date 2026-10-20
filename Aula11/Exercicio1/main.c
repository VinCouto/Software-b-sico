#include <stdio.h>
#include "sumInts.h"

int main() {
  int valor1, valor2, resultado;
  printf("Digite os valores: ");
  scanf("%d %d", &valor1, &valor2);
  resultado = sumInts(valor1, valor2);
  printf("O resultado eh %d\n", resultado);
return 0;
}
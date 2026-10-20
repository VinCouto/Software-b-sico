#include <stdio.h>
#include <stdlib.h>
#include "maisculas.h"

int main(){
  char texto[16] = "desafio";
  printf ("Texto original: %s\n", texto);

  convertemaiusculas(texto);
  printf("Texto em caixa alta: %s\n", texto);

  return 0;
}
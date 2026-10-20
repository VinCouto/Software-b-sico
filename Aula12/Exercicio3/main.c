#include <stdlib.h>
#include <stdio.h>
#include "kCaracter.h"

int main(){
  char texto[50];
  char caractere;

  printf("digite uma string: ");
  scanf("%s", texto);
  
  printf("Digite o caracter que deseja procurar: ");
  scanf(" %c", &caractere);
  
  int res = kCharRec(texto, caractere);
  printf("O caracter %c aparece %d vezes em %s\n", caractere, res, texto);

  return 0;
}

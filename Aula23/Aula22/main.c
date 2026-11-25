#include <stdio.h>
#include "mensagem.h"

int main(void) {
  int valor;
  scanf("%d", &valor);
  imprimir_mensagem(valor);
  scanf("%d", &valor);
  imprimir_mensagem(valor);
  return 0;
}
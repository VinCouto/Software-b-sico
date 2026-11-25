#include <stdio.h>
#include "console.h"
#include "mat.h"

int main() {
  int val1, val2, res;
  val1 = 10;
  val2 = 20;
  res = soma(val1, val2);
  imprimirResultado(res);
  return 0;
}
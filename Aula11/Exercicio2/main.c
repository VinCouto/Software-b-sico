#include <stdio.h>
#include <stdlib.h>
#include "fibonacci.h"

void main(){
  int x, res;
  scanf("%d", &x);
  res = fibonacci(x);
  printf("resultado = %d\n", res);
  return;
}
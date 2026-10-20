#include <stdlib.h>
#include <stdio.h>
#include "fibonacci.h"

int main(){
    int n;
    printf("Digite o numero da sequencia de fibonacci:");
    scanf("%d", &n);
    int res = fibRec(n);
    printf("O %dº termo da fibonacci é:%d\n", n, res);
    return 0;
}
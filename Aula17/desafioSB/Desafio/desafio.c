#include <stdio.h>
#include <string.h>

char senha[9] = "85649721";

int valida_senha (){
	char minha_senha[9];
	scanf ("%s", minha_senha);

	int valido = strcmp (senha, minha_senha);
	
	if (valido == 0) return 1;
	else return 0;
}

int main (){
	int valido = valida_senha();
	
	if (valido) printf ("Logado\n");
	else printf ("Falha de login\n");

	return 0;
}

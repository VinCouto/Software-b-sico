#include <dlfcn.h>
#include <stdio.h>

int main(void) {
    dlerror();

    void *handle = dlopen("./libcalc_extra.so", RTLD_LAZY);
    if (!handle) {
        fprintf(stderr, "Erro ao carregar biblioteca: %s\n", dlerror());
        return 1;
    }

    union {
        void *obj;
        int (*fn)(int);
    } sym;

    dlerror();
    sym.obj = dlsym(handle, "dobrar");
    const char *erro_sym = dlerror();
    if (erro_sym != NULL) {
        fprintf(stderr, "Erro ao buscar simbolo: %s\n", erro_sym);
        dlclose(handle);
        return 1;
    }

    int resultado = sym.fn(21);
    printf("Resultado de dobrar(21): %d\n", resultado);

    if (dlclose(handle) != 0) {
        fprintf(stderr, "Erro ao fechar biblioteca: %s\n", dlerror());
        return 1;
    }

    return 0;
}
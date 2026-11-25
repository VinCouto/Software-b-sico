#include <stdint.h>
#include <stdio.h>

extern uintptr_t _GLOBAL_OFFSET_TABLE_[];
constexpr size_t N = 8;

static void copiaGot(uintptr_t destino[N]) {
const volatile uintptr_t* got = _GLOBAL_OFFSET_TABLE_;
for (size_t i = 0; i < N; ++i) destino[i] = got[i];
}

int main() {
  uintptr_t antes[N], depois[N];
  copiaGot(antes);
  puts("Ola mundo");
  copiaGot(depois);
  printf("i endereco\tantes\tdepois\n");
  for (size_t i = 0; i < N; ++i) {
  printf("%zu %p 0x%016lx 0x%016lx",
  i, (void*)&_GLOBAL_OFFSET_TABLE_[i],antes[i], depois[i]);
  if (antes[i] != depois[i])
  printf(" <- Mudou!\n");
  else
  printf("\n");
  }
  return 0;
}
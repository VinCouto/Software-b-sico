#include <smmintrin.h> // SSE4.1 (inclui SSE2 e SSSE3)
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

constexpr int NUM_EXEC = 10;
constexpr size_t ALINHAMENTO = sizeof(__m128i); // 16 bytes
constexpr size_t TAM_VETOR = 268435456;
constexpr size_t LARGURA = sizeof(__m128i) / sizeof(uint32_t); // 4 inteiros

uint32_t produtoEscalar(const uint32_t* vet1, const uint32_t* vet2, size_t tam) {
  uint32_t res = 0;
  for (size_t i = 0; i < tam; ++i) {
    res += vet1[i] * vet2[i];
  }
  return res;
}

uint32_t produtoEscalarSSE(const uint32_t* vet1, const uint32_t* vet2, size_t tam) {
  size_t numBlocos = tam / LARGURA;
  __m128i soma = _mm_setzero_si128();
  for (size_t i = 0; i < numBlocos; ++i) {
    __m128i a = _mm_load_si128((const __m128i*)(vet1 + i * LARGURA));
    __m128i b = _mm_load_si128((const __m128i*)(vet2 + i * LARGURA));
    soma = _mm_add_epi32(soma, _mm_mullo_epi32(a, b));
  }
  alignas(ALINHAMENTO) uint32_t parcial[LARGURA];
  _mm_store_si128((__m128i*)parcial, soma);
return parcial[0] + parcial[1] + parcial[2] + parcial[3];
}


int main() {
  uint32_t* vet1 = aligned_alloc(ALINHAMENTO, TAM_VETOR * sizeof(uint32_t));
  uint32_t* vet2 = aligned_alloc(ALINHAMENTO, TAM_VETOR * sizeof(uint32_t));
  
  if (vet1 == nullptr || vet2 == nullptr) {
    perror("Falha de alocacao");
    exit(1);
  }
  
  for (size_t i = 0; i < TAM_VETOR; ++i) {
    vet1[i] = i % 10;
    vet2[i] = i % 5;
  }
  
  uint32_t resEsc;
  clock_t t0 = clock();
  for (int i = 0; i < NUM_EXEC; ++i)
    resEsc = produtoEscalar(vet1, vet2, TAM_VETOR);
  double tempoSimples = (double)(clock() - t0) / CLOCKS_PER_SEC;
  
  uint32_t resSSE;
  t0 = clock();
  for (int i = 0; i < NUM_EXEC; ++i)
    resSSE = produtoEscalarSSE(vet1, vet2, TAM_VETOR);
  double tempoSSE = (double)(clock() - t0) / CLOCKS_PER_SEC;
  
  printf("Escalar: %u em %lf s\n", resEsc, tempoSimples);
  printf("SSE: %u em %lf s\n", resSSE, tempoSSE);
  printf("Speedup: %.2fx\n", tempoSimples / tempoSSE);
  
  free(vet1);
  free(vet2);
  return 0;
}
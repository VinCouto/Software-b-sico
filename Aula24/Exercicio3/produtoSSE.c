#include <immintrin.h> // AVX / AVX2
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

constexpr int NUM_EXEC = 10;
constexpr size_t ALINHAMENTO = sizeof(__m256i); // 32 bytes (256 bits)
constexpr size_t TAM_VETOR = 268435456;
constexpr size_t LARGURA = sizeof(__m256i) / sizeof(uint32_t); // 8 inteiros de 32 bits

static_assert(TAM_VETOR % LARGURA == 0, "TAM_VETOR deve ser multiplo de 8");

uint32_t produtoEscalar(const uint32_t* vet1, const uint32_t* vet2, size_t tam) {
    uint32_t res = 0;
    for (size_t i = 0; i < tam; ++i) {
        res += vet1[i] * vet2[i];
    }
    return res;
}

uint32_t produtoEscalarAVX(const uint32_t* vet1, const uint32_t* vet2, size_t tam) {
    size_t numBlocos = tam / LARGURA;
    __m256i soma = _mm256_setzero_si256();

    for (size_t i = 0; i < numBlocos; ++i) {
        __m256i a = _mm256_load_si256((const __m256i*)(vet1 + i * LARGURA));
        __m256i b = _mm256_load_si256((const __m256i*)(vet2 + i * LARGURA));
        soma = _mm256_add_epi32(soma, _mm256_mullo_epi32(a, b));
    }

    alignas(ALINHAMENTO) uint32_t parcial[LARGURA];
    _mm256_store_si256((__m256i*)parcial, soma);

    uint32_t total = 0;
    for (size_t i = 0; i < LARGURA; ++i) {
        total += parcial[i];
    }
    return total;
}

int main(void) {
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

    uint32_t resEsc = 0;
    clock_t t0 = clock();
    for (int i = 0; i < NUM_EXEC; ++i) {
        resEsc = produtoEscalar(vet1, vet2, TAM_VETOR);
    }
    double tempoSimples = (double)(clock() - t0) / CLOCKS_PER_SEC;

    uint32_t resAVX = 0;
    t0 = clock();
    for (int i = 0; i < NUM_EXEC; ++i) {
        resAVX = produtoEscalarAVX(vet1, vet2, TAM_VETOR);
    }
    double tempoAVX = (double)(clock() - t0) / CLOCKS_PER_SEC;

    printf("Escalar: %u em %lf s\n", resEsc, tempoSimples);
    printf("AVX2:    %u em %lf s\n", resAVX, tempoAVX);
    printf("Speedup: %.2fx\n", tempoSimples / tempoAVX);

    free(vet1);
    free(vet2);
    return 0;
}
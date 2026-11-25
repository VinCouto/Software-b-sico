#include <smmintrin.h> // SSE4.1 (inclui SSE2 e SSSE3)
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

constexpr int NUM_EXEC = 5;
constexpr size_t ALINHAMENTO = sizeof(__m128i); // 16 bytes
constexpr size_t N = 512; // Matrizes N x N (múltiplo de 4 para simplicidade)
constexpr size_t LARGURA = sizeof(__m128i) / sizeof(uint32_t); // 4 inteiros de 32 bits[cite: 60, 65]

static_assert(N % LARGURA == 0, "N deve ser multiplo de 4");

void multMatrizesNormal(const uint32_t* A, const uint32_t* B, uint32_t* C, size_t n) {
    for (size_t i = 0; i < n; ++i) {
        for (size_t j = 0; j < n; ++j) {
            uint32_t acc = 0;
            for (size_t k = 0; k < n; ++k) {
                acc += A[i * n + k] * B[k * n + j];
            }
            C[i * n + j] = acc;
        }
    }
}

void multMatrizesSSE(const uint32_t* A, const uint32_t* B, uint32_t* C, size_t n) {
    for (size_t i = 0; i < n; ++i) {
        for (size_t k = 0; k < n; ++k) {
            // Replica A[i][k] nas 4 posições de 32 bits de um registrador __m128i
            __m128i a_broadcast = _mm_set1_epi32((int)A[i * n + k]);

            for (size_t j = 0; j < n; j += LARGURA) {
                __m128i b_vec = _mm_load_si128((const __m128i*)&B[k * n + j]);
                __m128i c_vec = _mm_load_si128((const __m128i*)&C[i * n + j]);
                __m128i prod = _mm_mullo_epi32(a_broadcast, b_vec);
                c_vec = _mm_add_epi32(c_vec, prod);
                _mm_store_si128((__m128i*)&C[i * n + j], c_vec);
            }
        }
    }
}

static void zerarMatriz(uint32_t* M, size_t n) {
    for (size_t i = 0; i < n * n; ++i) {
        M[i] = 0;
    }
}

static int matrizesIguais(const uint32_t* X, const uint32_t* Y, size_t n) {
    for (size_t i = 0; i < n * n; ++i) {
        if (X[i] != Y[i]) return 0;
    }
    return 1;
}

int main(void) {
    size_t totalElem = N * N;
    size_t bytesMatriz = totalElem * sizeof(uint32_t);

    uint32_t* A = aligned_alloc(ALINHAMENTO, bytesMatriz);
    uint32_t* B = aligned_alloc(ALINHAMENTO, bytesMatriz);
    uint32_t* C_norm = aligned_alloc(ALINHAMENTO, bytesMatriz);
    uint32_t* C_sse = aligned_alloc(ALINHAMENTO, bytesMatriz);

    if (!A || !B || !C_norm || !C_sse) {
        perror("Falha de alocacao");
        free(A);
        free(B);
        free(C_norm);
        free(C_sse);
        return 1;
    }

    for (size_t i = 0; i < totalElem; ++i) {
        A[i] = (uint32_t)((i * 3 + 1) % 17);
        B[i] = (uint32_t)((i * 7 + 5) % 13);
    }

    double tempoNormal = 0.0;
    for (int exec = 0; exec < NUM_EXEC; ++exec) {
        zerarMatriz(C_norm, N);
        clock_t t0 = clock();
        multMatrizesNormal(A, B, C_norm, N);
        tempoNormal += (double)(clock() - t0) / CLOCKS_PER_SEC;
    }

    double tempoSSE = 0.0;
    for (int exec = 0; exec < NUM_EXEC; ++exec) {
        zerarMatriz(C_sse, N);
        clock_t t0 = clock();
        multMatrizesSSE(A, B, C_sse, N);
        tempoSSE += (double)(clock() - t0) / CLOCKS_PER_SEC;
    }

    if (!matrizesIguais(C_norm, C_sse, N)) {
        fprintf(stderr, "Erro: resultados divergentes entre Normal e SSE!\n");
    }

    printf("Matriz %zux%zu (%d execucoes):\n", N, N, NUM_EXEC);
    printf("Normal: %lf s\n", tempoNormal);
    printf("SSE:    %lf s\n", tempoSSE);
    if (tempoSSE > 0.0) {
        printf("Speedup: %.2fx\n", tempoNormal / tempoSSE);
    }

    free(A);
    free(B);
    free(C_norm);
    free(C_sse);
    return 0;
}
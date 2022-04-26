#include <new>
#include <stdio.h>
#include "mm.cuh"

#define N 10

int main() {
    double a[N * N], b[N * N], c[N * N];
    double *dev_a, *dev_b, *dev_c;

    for (int i = 0; i < N * N; ++i) {
        a[i] = 0;
        b[i] = 0;
        c[i] = 0;
    }

    for (int i = 0; i < N; ++i) {
        a[N * i + i] = (i + 1);
        b[N * i + i] = 1 / (double)(i + 1);
    }

    cudaMalloc((void **)&dev_a, N * N * sizeof(double));
    cudaMalloc((void **)&dev_b, N * N * sizeof(double));
    cudaMalloc((void **)&dev_c, N * N * sizeof(double));

    cudaMemcpy(dev_a, a, N * N * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, N * N * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_c, c, N * N * sizeof(double), cudaMemcpyHostToDevice);

    dim3 grid(N, N);
    dim3 block(1);
    mm<<<grid, block>>>(dev_a, dev_b, dev_c, N, N, N);

    cudaMemcpy(c, dev_c, N * N * sizeof(double), cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();

    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_c);

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            printf("%f ", a[N * i + j]);
        }
        printf("\n");
    }
    printf("\n");

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            printf("%f ", b[N * i + j]);
        }
        printf("\n");
    }
    printf("\n");

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            printf("%f ", c[N * i + j]);
        }
        printf("\n");
    }

    return 0;
}

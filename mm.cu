#include <new>
#include <stdio.h>

#define N 3

__global__ void mm(double* a, double* b, double* c, int dim_l, int dim_m, int dim_n) {
    int size = dim_l * dim_n;

    for (int i = 0; i < dim_l; i++) {
        for (int j = 0; j < dim_m; j++) {
            for (int k = 0; k < dim_n; k++) {
                c[dim_m * i + j] +=
                    a[dim_m * i + k] * b[dim_n * k + j];
            }
        }
    }
}

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

    cudaMalloc((void **)& dev_a, N * N * sizeof(double));
    cudaMalloc((void **)& dev_b, N * N * sizeof(double));
    cudaMalloc((void **)& dev_c, N * N * sizeof(double));

    cudaMemcpy(dev_a, a, N * N * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, N * N * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_c, c, N * N * sizeof(double), cudaMemcpyHostToDevice);

    dim3 grid(1);
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

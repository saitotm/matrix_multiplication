#include <new>
#include <stdio.h>

#define N 3

int calc_index(int n, int m, int col_x, int col_y) { return m * col_x + col_y; }

void mm(double* a, double* b, double* c, int l, int m, int n) {
    int size = l * n;

    for (int i = 0; i < l; i++) {
        for (int j = 0; j < m; j++) {
            for (int k = 0; k < n; k++) {
                c[calc_index(l, m, i, j)] +=
                    a[calc_index(l, m, i, k)] * b[calc_index(m, n, k, j)];
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

    mm(a, b, c, N, N, N);

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

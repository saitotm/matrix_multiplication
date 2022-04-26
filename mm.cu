__global__ void mm(double *a, double *b, double *c, int dim_l, int dim_m, int dim_n) {
    int size = dim_l * dim_n;
    int x = blockIdx.x;
    int y = blockIdx.y;

    for (int k = 0; k < dim_n; k++) {
        c[dim_m * x + y] += a[dim_m * x + k] * b[dim_n * k + y];
    }
}

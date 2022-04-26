#include <benchmark/benchmark.h>
#include <vector>

int calc_index(int n, int m, int col_x, int col_y) { return m * col_x + col_y; }

std::vector<double> matrix_product(int l, int m, int n, std::vector<double> a,
                                   std::vector<double> b) {
    int size = l * n;
    std::vector<double> product(size, 0);

    for (int i = 0; i < l; i++) {
        for (int j = 0; j < m; j++) {
            for (int k = 0; k < n; k++) {
                product[calc_index(l, m, i, j)] +=
                    a[calc_index(l, m, i, k)] * b[calc_index(m, n, k, l)];
            }
        }
    }

    return product;
}

std::vector<double> omp_matrix_product(int l, int m, int n, std::vector<double> a,
                                       std::vector<double> b) {
    int size = l * n;
    std::vector<double> product(size, 0);

#pragma omp parallel for
    for (int i = 0; i < l; i++) {
        for (int j = 0; j < m; j++) {
            for (int k = 0; k < n; k++) {
                product[calc_index(l, m, i, j)] +=
                    a[calc_index(l, m, i, k)] * b[calc_index(m, n, k, l)];
            }
        }
    }

    return product;
}

static void bm_base_product_x(int size, benchmark::State &state) {
    int l = size;
    int m = size;
    int n = size;

    std::vector<double> a(l * m);
    std::vector<double> b(m * n);
    for (auto _ : state) {
        matrix_product(l, m, n, a, b);
    }
}

static void bm_base_omp_product_x(int size, benchmark::State &state) {
    int l = size;
    int m = size;
    int n = size;

    std::vector<double> a(l * m);
    std::vector<double> b(m * n);
    for (auto _ : state) {
        omp_matrix_product(l, m, n, a, b);
    }
}

static void BM_product_10(benchmark::State &state) { bm_base_product_x(10, state); }
static void BM_product_100(benchmark::State &state) { bm_base_product_x(100, state); }
// static void BM_product_10000(benchmark::State &state) { bm_base_product_x(10000, state); }

static void BM_omp_product_10(benchmark::State &state) { bm_base_omp_product_x(10, state); }
static void BM_omp_product_100(benchmark::State &state) { bm_base_omp_product_x(100, state); }
// static void BM_omp_product_10000(benchmark::State &state) { bm_base_omp_product_x(10000, state);
// }

BENCHMARK(BM_product_10);
BENCHMARK(BM_product_100);
// BENCHMARK(BM_product_10000);
// BENCHMARK(BM_omp_product_10000);
BENCHMARK(BM_omp_product_10);
BENCHMARK(BM_omp_product_100);
// BENCHMARK(BM_omp_product_10000);

BENCHMARK_MAIN();
 

#include <iostream>

void qsort(void *base, size_t num, size_t size, int(*compar)(void const *,void const*));

int doublecmp(void const * a, void const * b) {
    double da = *static_cast<double const *>(a);
    double db = *static_cast<double const *>(b);
    if (da <db) return -1;
    if(da > db) return 1;
    return 0;
}

typedef int (*x)(double);
typedef int* (*y)(char const*);
typedef y (*ComplexFunction)(int, x);

void sort(double *p, double *q) {
    std::qsort(p, p-q, sizeof(double), &doublecmp);
}

int main() {
    return 0;
}
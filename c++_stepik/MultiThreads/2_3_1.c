#include <stdlib.h>
#include <dmalloc.h>

void leak(unsigned int n) {
    malloc(n);
}

int main(int argc, char **argv) {
    leak(1);
    leak(2);
    leak(3);

    void *m = malloc(1024);
    free(m);

    return 0;
}

/*dmalloc -d o -l 2_3_1.log -p log-non-free*/

/*cc -DDMALLOC -DDMALLOC_FUNC_CHECK 2_3_1.cpp*/
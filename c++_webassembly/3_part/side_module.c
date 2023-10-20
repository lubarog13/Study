#include <stdlib.h>
#include <stdio.h>
#include <emscripten.h>

int Increment(int value) {
    return value + 1;
}
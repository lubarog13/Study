#include <cstddef>
#include <iostream>
//C
int a = 2;
int b = 3;
//int -> double
double size = ((double)a) / b * 100;
//double->int
void * data = malloc(sizeof(double) * int(size));

//void * -> double *
double * array = (double *)data;

//double * -> char *
char * bytes = (char *)array;

//C++
double d = static_cast<double>(2) / 3 * 100;
int s = static_cast<int>(d);


//Person p = static_cast<Person>("Ivan"); - неявный вызов конструктора
void send(char const * data, size_t length);
char * receive (size_t * length);
int main() {
    double * m = static_cast<double*>(malloc(sizeof(double) * 100));
    char * mc = reinterpret_cast<char *>(m);
    send(mc, sizeof(double) * 100);

    size_t length = 0;
    m = reinterpret_cast<double*> (receive(&length));
    length = length / sizeof(double);
    return 0;
}
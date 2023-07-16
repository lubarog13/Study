#include <cerrno>
#include <cstddef>
#include <fstream>
#include <iostream>
//#define NDEBUG
#include <string>
#include <type_traits>
#include <cassert>
#include <cstring>


template<class T>
void countdown(T start) {
    static_assert(std::is_integral<T>::value && std::is_signed<T>::value, "Requires signed integral type");

    assert(start>=0);
    while (start >= 0) {
        std::cout<< start-- << std::endl;
    }
}

std::size_t write(std::string file,  std::string data);

int main() {
    std::size_t bytes = write("test.txt", "Hello World");
    if (errno) {
        std::cerr<<std::strerror(errno)<<std::endl;
        errno = 0;
    }
    std::fstream file;
    file.exceptions(std::fstream::failbit | std::fstream::badbit);

    try {
        file.open("test.txt");
        std::cout << file.get() << std::endl;
        file.close();
    }
    catch (std::fstream::failure &e) {
        std::cerr << e.what() << std::endl;
    }
}
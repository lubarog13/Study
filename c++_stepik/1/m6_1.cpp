#include <iostream>

//double (Elf::*)(unsigned) const;
//const Unit* Archer::*;

template<typename T, typename U>
bool compare(const T& a, const T& b, U (T::*mptr) () const )
{
    return (a.*mptr)() < (b.*mptr)();
}

int main() {
    std::string s1("Elf");
    std::string s2("Archer");

// сравнение строк по длине
    bool r1 = compare(s1, s2, &std::string::size); // true
    bool r2 = compare(s1, s1, &std::string::size); // false
    return 0;
}
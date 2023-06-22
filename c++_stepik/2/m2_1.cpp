#include <iostream>

typedef int * (Class::*Foo)(int, double) const;
using Foo = int * (Class::*)(int, double) const;

struct SomeType {
    //SomeType() = default;
    SomeType(int newNumber) : number(newNumber) {}
    SomeType(): SomeType(42) {}
    SomeType(OtherType value);
    private:
        int number;
};

struct NonCopyable {
    NonCopyable() = default;
    NonCopyable(const NonCopyable&) = delete;
    NonCopyable & operator=(const NonCopyable&) = delete;
};
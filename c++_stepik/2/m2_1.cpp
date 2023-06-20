#include <iostream>

typedef int * (Class::*Foo)(int, double) const;
using Foo = int * (Class::*)(int, double) const;
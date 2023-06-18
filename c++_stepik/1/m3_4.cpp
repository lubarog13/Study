#include <iostream>
#include <typeinfo>
using namespace std;


struct Unit {
    virtual ~Unit() {}
};

struct Expression {

};

struct Elf : Unit {};

bool check_equals(Unit const *left, Unit const *right)
{
    return (typeid(*left) == typeid(*right));  
}

template<class T>
bool isSameObject(T const * p, T const * q)
{
    return dynamic_cast<const void *>(p) == dynamic_cast<const void *>(q);
}

int main() {
    Elf e;
    Unit &ur = e;
    Unit const * up = &e;
    Elf d;
    Elf const * k = &d;
    cout << typeid(ur).name() << endl;
    cout << typeid(*up) .name() << endl;
    cout << typeid(up).name() << endl;
    cout <<typeid(Elf).name()<<endl;
    cout << (typeid(ur) == typeid(Elf))<<endl;
    cout << check_equals(k, up)<<endl;
    cout << isSameObject<Unit>(up, k) <<endl;
    return 0;
}
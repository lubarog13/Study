#include <iostream>

template <class Type>
class SmartPointer {
    private:
        Type* pointer;
    public:
    SmartPointer(Type* p): pointer(p) {};
    operator Type*() { return pointer; };
    Type *operator->() {
        if(!pointer) {
            pointer = new Type();
            std::cerr << "Bad pointer!"<<std::endl;
        }
        return pointer;
    };
    std::ptrdiff_t operator-(SmartPointer<Type> p) {
        return pointer - p;
    };
    std::ptrdiff_t operator-(void *p) {
        return pointer-p;
    }
};

class Foo {
    private:
        int a,b;
    public:
        Foo(): a(0), b(0) {};
        Foo(int a, int b): a(a), b(b) {};
        int Sum() {return a+b; }
};

class StringPointer {
private:
    std::string *pointer;
    bool from_empty=false;
public:
    std::string *operator->() {
        if(!pointer) {
            from_empty = true;
            pointer = new std::string();
        }
        return pointer;
    }
    operator std::string*() {
        if(!pointer) {
            from_empty=true;
            pointer = new std::string();
        }
        return pointer;
    }
    StringPointer(std::string *Pointer): pointer(Pointer) {}; 
    ~StringPointer() {
        if(from_empty) {
            delete(pointer);
        }
    }
};

int main(int argc, char** argv) {
    std::string s1 = "Hello, world!";

    StringPointer sp1(&s1);
    StringPointer sp2(NULL);

    std::cout << sp1->length() << std::endl;
    std::cout << *sp1 << std::endl;
    std::cout << sp2->length() << std::endl;
    std::cout << *sp2 << std::endl;
}
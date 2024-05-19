#include <iostream>
#include <memory>

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
    std::unique_ptr<Foo> sp11(new Foo());
    std::unique_ptr<Foo> sp21;
    //sp2 = sp1; error
    sp21 = std::move(sp11);
    sp21.reset();
    std::shared_ptr<Foo> PFoo(new Foo());
    std::shared_ptr<Foo> PFoo2;
    PFoo2 = PFoo;
    PFoo2.reset();
    PFoo.reset();
    std::shared_ptr<int> p1(new int(5));
    std::weak_ptr<int> wp1 = p1;
    {
        std::shared_ptr<int> p2 = wp1.lock();
        if(p2) {
            //..
        }
    }
    p1.reset();
    std::shared_ptr<int> p3 = wp1.lock();
    if(p3) {
        //...
    }
}
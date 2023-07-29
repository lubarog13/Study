#include <cstddef>
#include <iostream>
#include <string>
#include <type_traits>

template <typename ...Types>
struct TypeList;

//специализация по умолчанию
template <typename H, typename ... T>
struct TypeList<H, T...>
{
    using  Head = H;
    using Tail = TypeList<T...>;
    static const int Length = 1 + sizeof...(T);
};

//специализация для пустого списка
template <>
struct TypeList<> {
    static int const Length = 0;
};

typedef char YES;

struct NO {YES m[2];};

struct A {
    void foo() {std::cout << "struct A\n";}
};


struct B {
    void foo() {std::cout << "struct B\n";}
};


struct C {
    void foo() {std::cout << "struct C\n";}
};

using Bases = TypeList<A, B, C>;

template <typename TL>
struct inherit;

template <typename ... Types>
struct inherit<TypeList<Types...>> : Types ... {};

struct D : inherit<Bases> { 
    void foo() { foo_impl<Bases>();}
    template <typename L> void foo_impl();

    template<class Base>
    void call_foo(YES)
    {
        static_cast<Base *>(this)->foo();
    }

    template<class Base>
    void call_foo(NO) { }
};

template <typename L>
inline void D::foo_impl() {
    static_cast<typename L::Head *>(this)->foo();
    foo_impl<typename L::Tail>();
};

template <>
inline void D::foo_impl<TypeList<>>() {};

template<class B, class D>
struct is_base_of
{
    static YES test(B * );
    static NO test(...);

    static bool const value = sizeof(test((D *)0)) == sizeof(YES);
};

template <class D>
struct is_base_of<D, D>
{
    static bool const value = false;
};

template <class T>
void foo(typename T::value_type * v);

template <class T>
void foo(T * v);

template <class T>
struct is_foo_defined
{
    template <class Z, void (Z::*)() = &Z::foo>
    struct wrapper {};

    template <class C>
    static YES check(wrapper<C> * p);

    template <class C>
    static NO check(...);

    static bool const value = sizeof(check((T *)0)) == sizeof(YES);
};

template <bool b>
struct Bool2Type {using type = YES;};

template<>
struct Bool2Type<false> {using type = NO;};

template<class L>
void foo_impl() {
    using Head = typename L::Head;
    constexpr bool has_foo = is_foo_defined<Head>::value;
    using CALL = typename Bool2Type<has_foo>::type;
    //call_foo<Head>(CALL());
    foo_impl<typename L::Tail>();
}

template<class T>
typename std::enable_if<std::is_integral<T>::value, T>::type div(T t) {return t >> 1;}

template <class T>
typename std::enable_if<std::is_floating_point<T>::value, T>::type div(T t) {return t / 2.0;}

template <class T>
T div2(T t, typename std::enable_if<std::is_integral<T>::value, T>::type * = 0) {
    return t >> 1;
}

template <class T, class E = typename std::enable_if<std::is_floating_point<T>::value, T>::type>
T div2(T t)
{return t / 2.0;}

template <class T, class E = void>
class K;

template <class T>
class K<T, typename std::enable_if<std::is_integral<T>::value>::type> {};

template <class T, size_t (T::*)() const = &T::size>
std::size_t get_size(T const& t) {
    return t.size();
}

template <class T, size_t (T::*) = &T::size>
std::size_t get_size(T const& t) {
    return t.size;
}

int main() {
    std::string s{"Hello"};
    size_t s_size = get_size(s); 
    std::cout << s_size << "\n";
}
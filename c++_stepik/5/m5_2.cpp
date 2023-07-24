#include <iostream>
#include <ostream>
#include <tuple>

template<typename T>
struct AddPointer
{
    using type = T *;
};

template<int N>
struct Square {
    static int const value = N * N;
};

template <int N>
struct Fact
{
    static int const value = N * Fact<N - 1>::value;
};

template <>
struct Fact<0>
{
    static int const value = 1;
};

template <int N>
struct Fib
{
    static int const value = Fib<N - 1>::value + Fib<N - 2>::value;
};

template <>
struct Fib<1>
{
    static int const value = 1;
};

template <>
struct Fib<0>
{
    static int const value = 0;
};

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

template<int ... T> struct IntList;

template <int H, int ... T>
struct IntList<H, T ...>
{
    static int const Head = H;
    using Tail = IntList<T...>;
};

template <>
struct IntList<> {};

template <typename TL>
struct Length
{
    static int const value = 1 + Length<typename TL::Tail>::value;
};

template <>
struct Length<TypeList<>>
{
    static int const value = 0;
};

template <>
struct Length<IntList<>>
{
    static int const value = 0;
};

// класс Derived будет унаследован от своих шаблонных параметров

template <typename... BaseClasses> 

struct Derived : BaseClasses... 
{
   // конструктор класса Derived будет 
   // принимать значения типа своих базовых классов
   Derived (BaseClasses const&... base_classes) 
       // и создавать их при помощи конструктора копирования
       : BaseClasses(base_classes)... 
   {}
};

template<typename ...Args> 

struct SomeStruct 

{

   // это не размер Args, а количество аргументов в Args
   static const int count = sizeof...(Args); 
};

template <typename H, typename TL>
struct Cons;

template <typename H, typename ... Types>
struct Cons<H, TypeList<Types ...>>
{
    using type = TypeList<H, Types ...>;
};

template <typename TL1, typename TL2>
struct Concat;

template <typename ... Ts1, typename ... Ts2>
struct Concat<TypeList<Ts1 ...>, TypeList<Ts2 ...>>
{
    using type = TypeList<Ts1..., Ts2...>;
};


template <int H, typename ... T>
struct IntCons;

template <int H, int ...T>
struct IntCons<H, IntList<T ...>>
{
    using type = IntList<H, T ...>;
};

template <int H, int K>
struct Generate;

template <int H, int K = 0>
struct Generate
{
    using type = typename IntCons<K, typename Generate<H-1, K+1>::type>::type;
};

template <int K>
struct Generate<0, K>
{
    using type = IntList<>;
};
template<typename F, typename T, int ...Ints>
auto apply(F& f, T tpl, IntList<Ints...>)
    -> decltype(f(std::get<Ints>(tpl)...))
{
    return f(std::get<Ints>(tpl)...);
};

template <typename Functor, typename ...A>
auto apply(Functor &f, std::tuple<A ...> t) -> decltype(apply(f, t, typename Generate<sizeof... (A)>::type())){
    return apply(f, t, typename Generate<sizeof... (A)>::type());
}

int main() {
    std::cout << Fact<10>::value << std::endl;
    using primes = IntList<2,3,5,7,11,13>;

    constexpr int head = primes::Head;

    using odd_primes = primes::Tail;

    std::cout<<head<<odd_primes::Head<< std::endl;
    using L1 = IntList<2,3,4>; 


    using L2 = IntCons<1, L1>::type;

    std::cout<<L2::Tail::Head<<std::endl;

    using L3 = Generate<5>::type; 
    std::cout << L3::Head<<" " <<L3::Tail::Head<<std::endl;

    auto f = [](int x, double y, double z) { return x + y + z; };
    auto t = std::make_tuple(30, 5.0, 1.6);  // std::tuple<int, double, double>
    auto res = apply(f, t);                // res = 36.6
    std::cout << res << std::endl;
};
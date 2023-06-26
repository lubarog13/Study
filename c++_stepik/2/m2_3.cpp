#include <tuple>
#include <initializer_list>
#include<functional> 
#include <algorithm>


// принимает std::tuple произвольного размера

template<int I,int J,typename T>
auto to_pair(T t)->decltype(std::make_pair(std::get<I>(t), std::get<J>(t)))
{
    return std::make_pair(std::get<I>(t), std::get<J>(t));
}

int sum(std::initializer_list<int> list) {
    int result = 0;
    for (int x : list) {
        result +=x;
    }
    return result;
}

std::function<int(int&)> square_fun =[](int& x){return x*=x;};

int main() {
    int total = 0;
    auto addToTotal = [&total](int i) { total+=i; };
    auto subTotal = [total] (int & x) { x-=total; };
  //  auto callUpdate = [this]...
    return 0;
}
auto gen_finder = [](int *p,int *q){
    auto other = [p,q](int x)->bool{
        int *s = p;
        bool k = true;
        for (s; s<q; s++){
            if(*s==x) { k = false;
                return true;}
        }
        if(k)
        return false;
    };
    return other;
}; 


enum class DAYS : unsigned int 
{
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY,
    FRIDAY, SATURDAY, SUNDAY
};
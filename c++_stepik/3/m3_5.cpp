#include <algorithm>
#include <functional>
#include <iostream>
#include <string>
#include <vector>
#include <numeric>
#include <map>
using namespace std;

// алгоритм должен работать с forward итераторами
// и возвращать итератор, который потом будет передан
// в метод erase соответствующего контейнера
template<class FwdIt>
FwdIt remove_nth(FwdIt p, FwdIt q, size_t n)
{
    if(p==q) return p;
    int count = 0;
    FwdIt temp;
    for (auto it = p; it != q; ++it) {
        if (count>=n && next(it) != q){
            iter_swap(it, next(it));
            temp = next(it);
        } else if (count>=n) {
            temp = it;
        }
        count++;
    }
    if(count>n) return temp;
    return q;

    //return remove_if(p, q, [p, n] (auto& x){return (&x - &*p) == n;}); C++ 14
}

template <typename Iterator>
std::size_t count_permutations(Iterator p, Iterator q)
{
    using ItType = typename std::iterator_traits<Iterator>::value_type;

    if (p == q) {
        return 1;
    }

    std::vector<ItType> v(p, q);
    std::sort(v.begin(), v.end());
    std::size_t perm_count = (std::adjacent_find(v.cbegin(), v.cend()) == v.cend());

    while (std::next_permutation(v.begin(), v.end())) {
        if (std::adjacent_find(v.cbegin(), v.cend()) == v.cend()) {
            ++perm_count;
        }
    }

    return perm_count;
}

int main() {
    vector<int> v = {0,1,2,3,4,5,6,7,8,9,10};
    v.erase(remove_nth(v.begin(), v.end(), 10), v.end());
    for_each(v.begin(), v.end(), [](int & s) { cout << s << endl; });
    /*
    vector<int> v = {2, 3, 5, 13, 17, 19};
    size_t k = count_if(v.begin(), v.end(), [](int x) { return x % 2 == 0; });
    auto it = lower_bound(v.begin(), v.end(), 11);
    bool has7 = binary_search(v.begin(), v.end(), 7);
    vector<string> & db = getNames();
    for_each(db.begin(), db.begin() + db.size() / 2, [](string & s) { cout << s << endl; });
    auto w = find(db.begin(), db.end(), "Waldo");
    string agents[3] = { "Alice", "Bob", "Eve"};
    auto it2 = find_first_of(db.begin(), db.end(), agents, agents + 3);
    */

    //случайные
    vector<int> a(100);
    generate(a.begin(), a.end(), []() { return rand() % 100; });

    //0,1,2,3/...
    vector<int> b(100);
    iota(b.begin(), b.end(), 0);

    //c[i] = a[i] + b[i]
    vector<int> c (b.size());
    transform(a.begin(), a.end(), b.begin(), c.begin(), multiplies<int>());

    //c[i] *= 2
    transform(c.begin(), c.end(), c.begin(), [](int x) { return x * 2; });

    // сумма c[i]
    int sum = accumulate(c.begin(), c.end(), 0);

    map<string, int> m;
    for (auto it = m.begin(); it != m.end(); ++it)
        if (it->second == 0)
            m.erase(it);
        else
            ++it;

    vector<int> v2 = {0,1,2,3,4,5,6,7,8,9,10};
    auto med = v2.begin() + v2.size() / 2;
    nth_element(v2.begin(), med, v2.end());
    cout<<"Median: "<<*med<<endl;
    auto k = partition(v2.begin(), v2.end(), [](int x) { return x %2 == 0; });
    sort(v2.begin(), k);
    v2.erase(k, v2.end());
}
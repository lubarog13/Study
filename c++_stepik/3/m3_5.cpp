#include <algorithm>
#include <functional>
#include <iostream>
#include <string>
#include <vector>
#include <numeric>
using namespace std;

int main() {
    vector<int> v = {2, 3, 5, 13, 17, 19};
    size_t k = count_if(v.begin(), v.end(), [](int x) { return x % 2 == 0; });
    auto it = lower_bound(v.begin(), v.end(), 11);
    bool has7 = binary_search(v.begin(), v.end(), 7);

    vector<string> & db = getNames();
    for_each(db.begin(), db.begin() + db.size() / 2, [](string & s) { cout << s << endl; });
    auto w = find(db.begin(), db.end(), "Waldo");
    string agents[3] = { "Alice", "Bob", "Eve"};
    auto it2 = find_first_of(db.begin(), db.end(), agents, agents + 3);

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
}
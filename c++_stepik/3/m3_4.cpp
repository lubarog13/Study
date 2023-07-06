#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <list>
#include <vector>
#include <fstream>
using namespace std;
/*
template <class Iterator>
struct iterator_traits {
    typedef difference_type  Iterator::difference_type;
    typedef value_type Iterator::value_type;
    typedef pointer Iterator::pointer;
    typedef reference Iterator::reference;
    typedef iterator_category Iterator::iterator_category;
};

template <class T>
struct iterator_traits<T*> {
    typedef difference_type ptrdiff_t;
    typedef value_type T;
    typedef pointer T*;
    typedef reference T&;
    typedef iterator_category random_access_iterator_tag;
};
*/

template<class I>
void advance_impl(I & i, size_t n, std::random_access_iterator_tag) 
{ 
    i += n; 
}

template<class I>
void advance_impl(I & i, size_t n, ... ) 
{ 
   for (size_t k = 0; k != n; ++k, ++i );
}

template<class I>
void advance(I & i, size_t n) 
{
   advance_impl(i, n, typename std::iterator_traits<I>::iterator_category());
}

template<class OutIt>
void findByName(string name, OutIt out);
struct Person {};
struct PersonIterator : std::iterator<forward_iterator_tag, Person> {
    //operator++, operator*
};

int main() {
    list<int> l = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    for (auto i = l.rbegin(); i != l.rend(); ++i)
        cout << *i << endl;
    list<int>::iterator i = l.begin();
    advance(i, 5);
    list<int>::reverse_iterator ri(i);
    i = ri.base();
    list<int> l1 = {1,2,3};
    l1.insert(l1.begin(), 4);
    l1.insert(l1.end(), 5);
    auto it = l1.begin();
    ++it;
    ++it;

    l1.insert(it, 6);

    auto rit1 = l1.rbegin();
    ++rit1;
    ++rit1;
    l1.insert(rit1.base(), 7);

    auto rit2 = l1.rbegin();
    ++rit2;
    ++rit2;
    l1.insert(rit2.base(), 8);
    for (auto i = l1.begin(); i != l1.end(); ++i)
        cout << *i << " ";
    /*
    vector<Person> res;
    Database::findByName("Rick", back_inserter(res));
    */
    ifstream file ("input.txt");
    vector<double> v((istream_iterator<double>(file)), istream_iterator<double>());
    copy(v.begin(), v.end(), ostream_iterator<double>(cout, "\n"));
}
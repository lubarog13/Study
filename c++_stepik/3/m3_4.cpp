#include <iostream>

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
#include <cstddef>
#include <type_traits>
struct String {
    /* String (String && s)
        : data_(s.data_)
        , size_(s.size_) {
            s.data_ = nullptr;
            s.size_ = 0;
        }
    String & operator = (String && s) {
        delete [] data_;
        data_ = s.data_;
        size_ = s.size_;
        s.data_ = nullptr;
        s.size_ = 0;
        return *this;
    } */

    void swap(String &s) {
        std::swap(data_, s.data_);
        std::swap(size_, s.size_);
    }
    String (String && s) {
        swap(s);
    }

    String & operator = (String && s) {
        swap(s);
        return *this;
    }
    private:
        char * data_ = nullptr;
        std::size_t size_ = 0;
};


template<class T>
struct Array
{
    // все объявленные ниже методы уже реализованы
    explicit Array(size_t size = 0);
    Array(Array const& a);
    Array & operator=(Array const& a);
    ~Array();

    size_t size() const;
    T &         operator[](size_t i);
    T const&    operator[](size_t i) const;

    void swap(Array &ar) {
        std::swap(size_, ar.size_);
        std::swap(data_, ar.data_);
    }

    Array (Array && ar):
       size_(0),
       data_(nullptr)
    {
        swap(ar);
    }
    
    Array & operator = (Array && ar) {
        swap(ar);
        return *this;
    }

private:    
    size_t  size_;
    T *     data_;    
};
#include <iterator>
#include <list>
#include <numeric>
#include <vector>
#include <cassert>
#include <iostream>

template<class T>
class VectorList {
private:
  using VectT = std::vector<T>;
  using ListT = std::list<VectT>;

  using VectIterT = typename std::vector<T>::const_iterator;
  using ListIterT = typename std::list<VectT>::const_iterator;

public:
  using value_type = T;

  VectorList() = default;
  VectorList(VectorList const&) = default;
  VectorList(VectorList&&) = default;
  
  VectorList& operator=(VectorList&&) = default;
  VectorList& operator=(VectorList const&) = default;
  
  // метод, который будет использоваться для заполнения VectorList
  // гарантирует, что в списке не будет пустых массивов
  template<class It>
  void append(It p, It q); // определена снаружи
  
  bool empty() const { return size() == 0; }
  
  // определите метод size
  size_t size() const {
    size_t result = 0;
    for (const VectT& vect : data_) {
      result += vect.size();
    }
    return result;
  }

  // определите const_iterator
  struct const_iterator : public std::iterator<std::bidirectional_iterator_tag, T, int, const T*, const T&> {
  public:
    // default
    const_iterator() = default;

    // copy
    const_iterator(const const_iterator&) = default;

    // custom
    const_iterator(const ListT* data, ListIterT list_iter) : m_data(data), m_list_iter(list_iter), m_vect_iter() {
      if (m_list_iter == m_data->end()) {
        return;
      }

      if (m_list_iter == m_data->begin()) {
        m_vect_iter = m_list_iter->begin();
      }
      else {
        assert(false);
      }
    }

    const_iterator& operator++ () {
      ++m_vect_iter;
      
      if (m_vect_iter == m_list_iter->end()) {
        ++m_list_iter;
        
        if (m_list_iter == m_data->end()) {
          m_vect_iter = VectIterT{};
        }
        else {
          m_vect_iter = m_list_iter->begin();
        }
      }

      return *this;
    }

    const_iterator operator++ (int) {
      const_iterator result = *this;
      ++(*this);
      return result;
    }

    const_iterator& operator--() {
      if (m_list_iter == m_data->end()) {
        m_list_iter = std::prev(m_data->end());
        m_vect_iter = std::prev(m_list_iter->end());
      }
      else {
        if (m_vect_iter == m_list_iter->begin()) {
          --m_list_iter;
          m_vect_iter = std::prev(m_list_iter->end());
        }
        else {
          --m_vect_iter;
        }
      }
      
      return *this;
    }

    const_iterator operator-- (int) {
      const_iterator result = *this;
      --(*this);
      return result;
    }
    
    bool operator== (const const_iterator& it) const {
      return m_list_iter == it.m_list_iter && m_vect_iter == it.m_vect_iter;
    }

    bool operator!= (const const_iterator& it) const {
      return !(*this == it);
    }

    const T& operator*() const {
      return *m_vect_iter;
    }

    const T* operator->() const {
      return &(*m_vect_iter);
    }

  private:
    const ListT* m_data = nullptr;
    ListIterT m_list_iter;
    VectIterT m_vect_iter;
  };
  
  // определите методы begin / end
  const_iterator begin() const {
    return const_iterator(&data_, data_.begin());
  }
  
  const_iterator end() const {
    return const_iterator(&data_, data_.end());
  }

  // определите const_reverse_iterator
  using const_reverse_iterator = std::reverse_iterator<const_iterator>;
  
  // определите методы rbegin / rend
  const_reverse_iterator rbegin() const { 
    return const_reverse_iterator(this->end());
  }
  
  const_reverse_iterator rend() const {
    return const_reverse_iterator(this->begin());
  }

private:
  ListT data_;
};

template <typename T>
template <typename It>
void VectorList<T>::append(It p, It q) {
  if (p != q) {
    data_.push_back(VectT(p, q));
  }
}
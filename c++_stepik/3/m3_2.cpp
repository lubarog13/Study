#include <string>
#include <vector>
#include <iostream>
#include <deque>
#include <list>
#include <forward_list>


template<class It>
size_t max_increasing_len(It p, It q) {
    int count=1, maxcount = 1;
    It prev = p;
    ++p;
    for (; p!=q; p++) {
        if(*p > *prev) {
            count++;
        } 
        if (count>maxcount) {
                maxcount = count!=1? count : 1;
        }
        if(*p <= *prev) {
            count = 1;
        }
        prev = p;
    }
    return maxcount;
}

int main() {
    std::vector<std::string> v = {"One", "Two"};
    v.reserve(100);
    v.push_back("Three");
    v.emplace_back("Four");
    v.data();
    v.size();
    std::deque<std::string> d = {"One", "Two"};
    d.emplace_back("Three");
    d.emplace_front("Zero");
    std::list<std::string> l = {"One", "Two"};
    l.emplace_back("Three");
    l.emplace_front("Zero");
    std::cout<<l.front()<< std::endl;
    for (std::string &s : l) {
        std::cout<<s<<std::endl;
    }
    std::list<std::string>::iterator i = l.begin();
    for(;i!=l.end(); ++i) {
        if(*i=="Two") {
            break;
        }
    }
    l.erase(i);
    std::list<int> const l1 = {7,8,9,4,5,6,1,2,3,4};
    size_t len1 = max_increasing_len(l1.begin(), l1.end());
    std::cout<<len1<<std::endl;
    std::forward_list<std::string> fl = {"One", "Two"};
    fl.emplace_front("Zero");
    fl.push_front("Minus One");
    std::cout << fl.front() << std::endl;
}
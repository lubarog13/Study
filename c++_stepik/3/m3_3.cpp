#include <iostream>
#include <map>
#include <set>
#include <unordered_set>
#include <string>
#include <unordered_map>


struct Person {std::string name; std::string surname;};

bool operator<(Person const &a, Person const &b) {
    return a.name < b.name || (a.name == b.name && a.surname < b.surname);
}

bool operator==(Person const& a, Person const& b) {
    return a.name == b.name
    && a.surname == b.surname;
}

namespace std {
    template<> struct hash<Person> {
        size_t operator() (Person const& p) const {
            hash<string> h;
            return h(p.name) ^ h(p.surname);
        }
    };
}

struct PersonComp {
    bool operator() (Person const& a, Person const& b) const {
        return a.surname < b.name;
    }
};

int main() {
    std::map<std::string, int> phonebook;
    phonebook.emplace("Marge", 2128506);
    phonebook.emplace("Liza", 2128507);
    auto it = phonebook.find("Maggie");
    if (it!=phonebook.end()) {
        std::cout<<"Maggie: "<<it->second<<"\n";
    }   
    it = phonebook.find("Marge");
    if (it!=phonebook.end()) {
        it->second = 5550123;
    } else {
        phonebook.emplace("Marge", 5550123);
    }
    //или
    phonebook["Marge"] = 5550123;

    //Уникальны по имя + фамилия
    std::set<Person> s1;

    //Уникальны по фамилии
    std::set<Person, PersonComp> s2;

    std::unordered_set<int> primes = {2, 3, 5, 7, 11};
    if (primes.find(173)!=primes.end()) 
        std::cout<<173<<" is prime\n";

    auto res = primes.insert(3);

    std::unordered_multiset<int> fib = {0, 1, 1, 2, 3, 5, 8};
    auto res1 = fib.insert(13);

    std::unordered_set<Person> s;
    return 0;
}
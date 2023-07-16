#include <string>
#include <sstream>
#include <exception>
#include <vector>
#include <iostream>

#define _CATCH() catch (std::exception const& e) {std::cout<<"catch std::exception: "<< e.what();} catch (...) {std::cout<<"catch unknown";}

// описание класса исключения bad_from_string
class bad_from_string : public std::exception {
    private:
        std::string message;
    public:
        bad_from_string(std::string s) : message(s) {}
        const char* what() const noexcept override {
            return message.c_str();
        }
};

// функция from_string
template<class T>
T from_string(std::string const& s)
{
    std::istringstream is(s);
    T t;
    is >> std::noskipws >> t;
    if (is.fail() || is.peek() != EOF) {
        throw bad_from_string(s);
    }
    return t;
}

int main() {
    std::vector<std::string> strings{ "123", "12.3", "", " ", "abc", " 123", "123 ", "12 3", "-1", "a", "A"};

    for (auto& str : strings) {

        std::cout << std::endl << "from_string(\'" << str << "\'):";

        try {std::cout<< std::endl  << "<string>: "; std::cout << from_string<std::string>(str);} _CATCH()

        try {std::cout<< std::endl  << "<double>: "; std::cout << from_string<double>(str);} _CATCH()

        try {std::cout<< std::endl  << "<int>   : "; std::cout << from_string<int>(str);} _CATCH()

        try {std::cout<< std::endl  << "<char>  : "; std::cout << from_string<char>(str);} _CATCH()

        std::cout << std::endl;

    }
}
#include <atomic>
#include <mutex>
#include <thread>
#include <future>
#include <iostream>

int doAsyncWork();
double someFunction(int i);

double shared = 0;
std::mutex mtx;

void compute(int begin, int end) {
    for (int i = begin; i != end; ++i) {
        double current = someFunction(i);
        //критическая секция
        std::lock_guard<std::mutex> lock(mtx);
        shared += current;
    }
}

template <class T>
struct shared_ptr_data
{
    void addref()
    {
        ++counter;
    }
    T *ptr;
    std::atomic<size_t> counter;
};

int main() {
    // Использование thread
    std::thread t(doAsyncWork);
    //Использование async
    std::future<int> f = std::async(doAsyncWork);
    int res = f.get();
    //гарантирует асинхронное выполнение
    std::future<int> f2 = std::async(std::launch::async, doAsyncWork);
    res = f.get();
    res = 0;
    std::thread g([&res](){res = doAsyncWork();});
    g.join();
    std::thread t1 (compute, 0, 10);
    std::thread t2 (compute, 100, 200);
    t1.join();
    t2.join();
    std::cout << shared << std::endl;
}
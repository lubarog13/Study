#include <thread>
#include <future>


int doAsyncWork();

int main() {
    // Использование thread
    std::thread t(doAsyncWork);
    //Использование async
    std::future<int> f = std::async(doAsyncWork);
    int res = f.get();
    //гарантирует асинхронное выполнение
    std::future<int> f2 = std::async(std::launch::async, doAsyncWork);
    res = f.get();
}
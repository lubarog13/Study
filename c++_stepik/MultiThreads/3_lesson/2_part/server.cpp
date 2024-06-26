#include <algorithm>
#include <cstddef>
#include <iostream>
#include <set>
#include <sys/select.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <fcntl.h>


int set_nonblock(int fd) {
    int flags;
#if defined(O_NONBLOCK)
    if(-1 == (flags = fcntl(fd, F_GETFL, 0)))
        flags = 0;
    return fcntl(fd, F_SETFL, flags | O_NONBLOCK);
#else
    flags = 1;
    return ioctl(fd, FIOBIO, &flags);
#endif
}

int main(int argc, char** argv) {
    int MasterSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    std::set<int> SlaveSockets;
    struct sockaddr_in Sockaddr;
    Sockaddr.sin_family = AF_INET;
    Sockaddr.sin_port = htons(12345);
    Sockaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    int error = bind(MasterSocket, (struct sockaddr *)(&Sockaddr), sizeof(Sockaddr));
    if(error == 0) {
        set_nonblock(MasterSocket);
        listen(MasterSocket, SOMAXCONN);
        while (true) {
            fd_set Set;
            FD_ZERO(&Set);
            FD_SET(MasterSocket, &Set);
            for(auto iter = SlaveSockets.begin(); iter != SlaveSockets.end(); iter++) {
                FD_SET(*iter, &Set);
            }
            int Max = std::max(MasterSocket, *std::max_element(SlaveSockets.begin(), SlaveSockets.end()));
            select(Max + 1, &Set, NULL, NULL, NULL);
            for (auto  it = SlaveSockets.begin(); it!=SlaveSockets.end(); it++) {
                if (FD_ISSET(*it, &Set)) {
                    static char Buffer[1024];
                    int RecvSize = recv(*it, Buffer, 1024, MSG_NOSIGNAL);
                    if ((RecvSize == 0) && (errno!=EAGAIN)) {
                        shutdown(*it, SHUT_RDWR);
                        close(*it);
                        SlaveSockets.erase(it);
                    } else if (RecvSize!=0) {
                        send(*it, Buffer, RecvSize, MSG_NOSIGNAL);
                    }
                }
            }
            if(FD_ISSET(MasterSocket, &Set)) {
                int SlaveSocket = accept(MasterSocket, 0, 0);
                set_nonblock(SlaveSocket);
                SlaveSockets.insert(SlaveSocket);
            }
        }
    } else {
        std::cout<<"Error connection"<<std::endl;
    }

    return 0;
}
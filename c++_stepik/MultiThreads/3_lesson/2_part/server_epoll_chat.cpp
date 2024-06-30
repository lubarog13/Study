#include <iostream>
#include <set>
#include <sys/poll.h>
#include <sys/select.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/epoll.h>

#define MAX_EVENTS 32


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
        
        int EPoll = epoll_create1(0);

        struct epoll_event Event;

        Event.data.fd = MasterSocket;
        Event.events = EPOLLIN;
        epoll_ctl(EPoll, EPOLL_CTL_ADD, MasterSocket, &Event);
        
        while (true) {
            struct epoll_event Events[MAX_EVENTS];
            int N = epoll_wait(EPoll, Events, MAX_EVENTS, -1);
            std::cout <<N<<std::endl;
            for (unsigned int i=0; i< N; i++) {
                if(Events[i].data.fd == MasterSocket) {
                    int SlaveSocket = accept(MasterSocket, 0, 0);
                        set_nonblock(SlaveSocket);
                        struct epoll_event Event;
                        Event.data.fd = SlaveSocket;
                        Event.events = EPOLLIN;
                        epoll_ctl(EPoll, EPOLL_CTL_ADD, SlaveSocket, &Event);
                        for (unsigned int j=0; j<N; j++) {
                                send(Events[j].data.fd, "Added new Client\n", 1024, MSG_NOSIGNAL);
                            }
                } else {
                        static char Buffer[1024];
                        int RecvSize = recv(Events[i].data.fd, Buffer, 1024, MSG_NOSIGNAL);
                        if ((RecvSize == 0) && (errno!=EAGAIN)) {
                            /*shutdown(Events[i].data.fd, SHUT_RDWR);
                            close(Events[i].data.fd);
                            SlaveSockets.erase(Events[i].data.fd);*/
                        } else if (RecvSize!=0) {
                            for (unsigned int j=0; j<N; j++) {
                                std::cout<<j<<" " <<Buffer<<std::endl; 
                                send(Events[j].data.fd, Buffer, RecvSize, MSG_NOSIGNAL);
                            }
                        }
                }
            }
        }
    } else {
        std::cout<<"Error connection"<<std::endl;
    }

    return 0;
}
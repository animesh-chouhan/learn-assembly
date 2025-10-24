BITS 64

extern puts

global main


section .text
main:
    lea rdi, [message]
    ; call puts wrt ..plt

    mov rax, 60
    mov rdi, 0
    syscall
    ret

section .data
    message: db "Hola, mundo", 0


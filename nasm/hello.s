; nasm -f elf64 hello.s && ld -o hello hello.o && ./hello

global _start

section .text
_start:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, text
    mov rdx, 14 ; length of "Hello World!\n"
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

section .data
    text db "Hello World!", 0xA ; db: define bytes

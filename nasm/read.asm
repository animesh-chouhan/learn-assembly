; nasm -f elf64 read.s && ld -o read read.o && ./read
BITS 64

section .data
    text1 db "Please enter your name: "
    len1 equ $ - text1
    text2 db "Hello, "
    len2 equ $ - text2

section .bss
    name resb 16

section .text
    global _start

_start:
    call _print_text1
    call _get_name
    call _print_text2
    call _print_name
    
    mov rax, 60
    mov rdi, 0
    syscall

_print_text1:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, text1
    mov rdx, len1
    syscall
    ret

_get_name:
    mov rax, 0x0
    mov rdi, 0x0
    mov rsi, name
    mov rdx, 16
    syscall
    ret

_print_text2:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, text2
    mov rdx, len2
    syscall
    ret

_print_name:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, name
    mov rdx, 16
    syscall
    ret

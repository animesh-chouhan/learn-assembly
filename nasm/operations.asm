BITS 64

global _start
extern printf

section .text
_start:
    mov rax, 123    ; rax = 123
    mov rcx, rax    ; rcx = rax
    add rax, rcx    ; rax += rcx
    sub rax, 100    ; rax -= 100

    mov rcx, 10
    mul rax         ; rax *= rcx mul applies to eax
    div rax         ; rax /= rcx div applies to eax           

    mov rax, 60
    mov rdi, 0
    syscall
    ret

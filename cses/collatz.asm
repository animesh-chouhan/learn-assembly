; collatz.asm
; Build: nasm -f elf64 collatz.asm -o collatz.o && gcc collatz.o -no-pie -o collatz

extern scanf
extern printf
global main

section .data
fmt_in      db "%lld", 0
fmt_numsp   db "%lld ", 0
fmt_last    db "%lld", 10, 0

section .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 16                 ; stack alignment

    lea rsi, [rbp-8]            ; &n
    lea rdi, [rel fmt_in]       ; use [rel] for PIC
    xor eax, eax
    call scanf

.loop:
    mov rax, [rbp-8]
    cmp rax, 1
    je .last
    lea rdi, [rel fmt_numsp]
    mov rsi, rax
    xor eax, eax
    call printf

    mov rax, [rbp-8]
    test rax, 1
    jnz .odd
    shr rax, 1
    jmp .store
.odd:
    lea rax, [rax*2 + rax]
    add rax, 1
.store:
    mov [rbp-8], rax
    jmp .loop

.last:
    mov rax, [rbp-8]
    lea rdi, [rel fmt_last]
    mov rsi, rax
    xor eax, eax
    call printf

    mov eax, 0
    leave
    ret

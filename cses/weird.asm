; nasm -f elf64 read.s && ld -o read read.o && ./read
BITS 64

section .bss
    inbuf resb 20
    outbuf resb 20
    n resd 1
    res resd 1

section .text
    global _start

_start:
    call _get_input
    lea rsi, [inbuf]
    call _stoi

    call _solve

    mov rax, 60
    mov rdi, 0
    syscall

_solve:
    mov rax, [n]
    .solve_loop:
        mov [res], rax
        call _print_res
        cmp rax, 1
        je .solve_done
        test rax, 1         ; bitwise AND with 1
        jnz .solve_odd      ; jump if zero → even
    .solve_even:
        shr rax, 1
        jmp .solve_loop
    .solve_odd:
        imul rax, rax, 3
        add rax, 1
        jmp .solve_loop
    .solve_done:
        ret



_get_input:
    mov rax, 0x0
    mov rdi, 0x0
    lea rsi, [inbuf]
    mov rdx, 20
    syscall
    ret

_print_output:
    mov rax, 0x1
    mov rdi, 0x1
    ; rsi and rdx must be set by caller
    syscall
    ret

_print_res:
    push rax               ; save current rax
    call _itoa
    mov rsi, rax           ; rsi = pointer to string
    xor rcx, rcx
    .len_loop:
        cmp byte [rsi+rcx], 0
        je .len_done
        inc rcx
        jmp .len_loop
    .len_done:
        mov rdx, rcx        ; string length
    call _print_output
    pop rax                 ; restore original rax
    ret


_stoi:
    xor rax, rax         ; result = 0
    xor rbx, rbx         ; clear rbx
    .next:
        mov bl, [rsi]        ; load one byte
        cmp bl, 10           ; newline?
        je .done
        cmp bl, 0            ; \0 null char?
        je .done
        sub bl, '0'          ; ASCII to number
        imul rax, rax, 10    ; result *= 10
        add rax, rbx         ; result += digit
        inc rsi
        jmp .next
    .done:
        mov [n], rax
        ret

_itoa:
    mov rax, [res]
    lea rdi, [outbuf+19]    ; start from end of buffer
    mov byte [rdi], 0       ; null terminator
    dec rdi                 ; move back to fill digits
    ; mov byte [rdi], 10      ; new line
    mov byte [rdi], 32      ; space
    dec rdi                 ; move back to fill digits

    cmp rax, 0
    jne .convert
    mov byte [rdi], '0'
    lea rax, [rdi]
    ret

    .convert:
        xor rcx, rcx           ; remainder

    .next_digit:
        mov rdx, 0
        mov rbx, 10
        div rbx                ; rax / 10 → quotient in rax, remainder in rdx
        add dl, '0'            ; convert remainder to ASCII
        mov [rdi], dl          ; store digit
        dec rdi
        test rax, rax
        jnz .next_digit

    lea rax, [rdi+1]       ; return pointer to start of string
    ret
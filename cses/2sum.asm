; nasm -f elf64 2sum.asm && ld -o 2sum 2sum.o && ./2sum
BITS 64

section .bss
    inbuf  resb 20
    outbuf resb 20
    n      resq 1
    target resq 1
    res    resq 1

section .text
    global _start

_start:
    call _get_integer
    mov [n], rax
    call _get_integer
    mov [target], rax

    call _find_2sum

    mov rax, 60
    mov rdi, 0
    syscall


_find_2sum:
    mov rax, [n]
    lea rax, [rax*8 + 15]
    and rax, -16
    sub rsp, rax
    mov r12, rax

    xor rbx, rbx
    .input_loop:
        call _get_integer
        mov [rsp + rbx*8], rax

        inc rbx
        cmp rbx, [n]
        jl .input_loop

    xor rbx, rbx
    .outer_loop:
        lea rdx, [rbx+1]
        .inner_loop:
            mov r8, [rsp + rbx*8]
            add r8, [rsp + rdx*8]
            cmp r8, [target]
            je .solve_done
            inc rdx
            cmp rdx, [n]
            jl .inner_loop

        inc rbx
        cmp rbx, [n]
        jl .outer_loop
        jmp .cleanup

    .solve_done:       
        mov [res], rbx
        call _print_integer
        mov [res], rdx
        call _print_integer

    .cleanup:
        ; restore stack
        add rsp, r12
        ret

_read_line:
    mov rax, 0x0
    mov rdi, 0x0
    lea rsi, [inbuf]
    mov rdx, 20
    syscall
    ret

_get_integer:
    call _read_line
    call _stoi
    ret

_print_output:
    mov rax, 0x1
    mov rdi, 0x1
    ; rsi and rdx must be set by caller
    syscall
    ret

_stoi:
    push rbx
    xor rax, rax         ; result = 0
    xor rbx, rbx         ; clear rbx
    .stoi_next:
        mov bl, [rsi]        ; load one byte
        cmp bl, 10           ; newline?
        je .stoi_done
        cmp bl, 0            ; \0 null char?
        je .stoi_done
        sub bl, '0'          ; ASCII to number
        imul rax, rax, 10    ; result *= 10
        add rax, rbx         ; result += digit
        inc rsi
        jmp .stoi_next
    .stoi_done:
        pop rbx
        ret

_print_integer:
    push rax               ; save current rax
    push rbx
    push rdx
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
    pop rdx
    pop rbx
    pop rax                 ; restore original rax
    ret

_itoa:
    mov rax, [res]
    lea rdi, [outbuf+19]    ; start from end of buffer
    mov byte [rdi], 0       ; null terminator
    dec rdi                 ; move back to fill digits
    mov byte [rdi], 10      ; new line
    ; mov byte [rdi], 32      ; space
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
; nasm -f elf64 lock.asm -o lock.o
BITS 64

section .data
    global lockvar, counter
    lockvar: dd 0
    counter: dd 0

section .text
    global spinlock_acquire, spinlock_release, increment_with_lock

    ; spinlock_acquire:
    spinlock_acquire:
        mov eax, 1
    .spin:
        xchg eax, [rel lockvar]
        test eax, eax
        jnz .spin
        ret

    ; spinlock_release:
    spinlock_release:
        mov dword [rel lockvar], 0
        ret

    ; increment_with_lock:
    increment_with_lock:
        call spinlock_acquire
        mov eax, [rel counter]
        inc eax
        mov [rel counter], eax
        call spinlock_release
        ret

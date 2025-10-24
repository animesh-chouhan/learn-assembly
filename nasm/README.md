# nasm

```sh
nasm -f elf64 hello.s && ld -o hello hello.o && ./hello
```

Debug your program with strace ./my_program to trace the system calls it makes:

```sh
nasm -f elf64 hello.asm && ld -o hello hello.o
strace ./hello
```

The syscall codes can be found in `unistd_64.h`

1. https://cs.lmu.edu/~ray/notes/nasmtutorial/

2. https://www.youtube.com/watch?v=BWRR3Hecjao&list=PLetF-YjXm-sCH6FrTz4AQhfH6INDQvQSn&index=2&ab_channel=kupala

3. https://www.youtube.com/playlist?list=PLmxT2pVYo5LB5EzTPZGfFN0c2GDiSXgQe

4. https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html

VS Code Extension: NASM Language Support v1.2.0 by doinkythederp

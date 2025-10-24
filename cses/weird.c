#include <stdio.h>

int main() {
    long n;
    scanf("%ld", &n);

    while (n != 1) {
        printf("%ld ", n);
        if (n % 2 == 0) {
            n /= 2;
        } else {
            n = n * 3 + 1;
        }
    }
    printf("%ld\n", n);

    return 0;
}
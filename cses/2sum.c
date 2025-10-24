#include <stdio.h>

int* twoSum(int* nums, int numsSize, int target, int* returnSize) {
    int* ret = malloc(2 * sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        for (int j = i + 1; j < numsSize; ++j) {
            if (nums[i] + nums[j] == target) {
                ret[0] = nums[i];
                ret[1] = nums[j];
            }
        }
    }
    return ret;
}

int main() {
    int n;
    scanf("%d", &n);

    for (int i = 0; i < n; ++i) {
        }

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
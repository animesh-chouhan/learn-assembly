#include <stdio.h>
#include <pthread.h>

extern void increment_with_lock(void);
extern int counter;

void *worker(void *arg)
{
    for (int i = 0; i < 100000; i++)
    {
        increment_with_lock();
    }
    return NULL;
}

int main()
{
    pthread_t t1, t2;

    pthread_create(&t1, NULL, worker, NULL);
    pthread_create(&t2, NULL, worker, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    printf("Final counter = %d\n", counter);
    return 0;
}

#include <stdio.h>

int fib(int n)
{
    if (n<2)
        return 1;
    else
        return fib(n-1)+fib(n-2);
}

int main()
{
    int i,j;
    for ( i = 0; i < 1000; i++ )
        for ( j = 0; j < 20; j++ )
            fib(j);
    return 0;
};

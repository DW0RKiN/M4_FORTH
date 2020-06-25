#include <stdio.h>

int fib2(int n)
{
    int i,a,b,c;
    a = 0;
    b = 1;
    for ( i = 0; i < n; i++ )
    {
        c = b;
        b = a;
        a += c;
    }
    return a;
}

int main()
{
    int i,j;
    for ( i = 0; i < 1000; i++ )
        for ( j = 0; j < 20; j++ )
            fib2(j);
    return 0;
};

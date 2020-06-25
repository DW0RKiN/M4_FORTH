#include <stdio.h>


int gcd1(int a, int  b) 
{
    int c;

    if ((a | b) == 0) return 1;
    if ( a == 0) return b;
    if ( b == 0) return a;
    
    while (a != b )
    {
        if (a > b) { a -=b; }
        else { b -= a; }
    }
    return a;
}

int main()
{
    int i,j;
    for (i = 0; i < 100; i++ )
        for (j = 0; j < 100; j++ )
            gcd1(i, j);
}

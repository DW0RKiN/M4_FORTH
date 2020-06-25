#include <stdio.h>


int gcd1(int a, int  b) 
{
    int c;
    
    if (a) {
        while (b)
        {
            if (a > b) {
                c = a;
                a = b;
                b = c;
            }
            b-=a;             
        }
        return (a);
    } 
    else
    {
        if (b) return b;
        return 1;
    }
}

int main()
{
    int i,j;
    for (i = 0; i < 100; i++ )
        for (j = 0; j < 100; j++ )
            gcd1(i, j);
}

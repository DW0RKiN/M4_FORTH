#include <stdio.h>
  
int decompose(unsigned int n)
{
    unsigned int p = 2;
        
    while (n > p * p) {
        if ( n % p ) {
            p++;
            p|=1;
        } else
        {
            n /= p;
//             printf(" %d",p);
        }
    }
//     printf(" %d",n);
}
 
int main()
{    
    int i;
    for (i = 10000; i >= 0; i--) 
        decompose(i);
    return 0;
}

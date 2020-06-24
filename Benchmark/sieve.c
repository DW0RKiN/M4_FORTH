/* zcc +zx -lm -lndos -create-app sieve.c */

#include <stdio.h>

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

/*******************************/
/* Number of        Array Size */
/* Primes Found      (Bytes)   */
/*     1899;             8191  */
/*     2261;            10000  */
/*     4202;            20000  */
/*     7836;            40000  */
/*    14683;            80000  */
/*    27607;           160000  */
/*    52073;           320000  */
/*    98609;           640000  */
/*   187133;          1280000  */
/*   356243;          2560000  */
/*   679460;          5120000  */
/*  1299068;         10240000  */
/*  2488465;         20480000  */
/*        0;         40960000  */
/*        0;         81920000  */
/*        0;        163840000  */

    #define MAX_MEM 10240
    char file[MAX_MEM];

/**************************************/
/*  Sieve of Erathosthenes Program    */
/**************************************/

SIEVE(size)
unsigned int size;
{
    char *flags;
    register unsigned int i,prime,k;
    register unsigned int count;

    flags   = &(file[0]);

    count = 0;
    char * ptr;
    ptr = flags;
   
    for(i=0 ; i<=size ; i++)
    {
        *ptr = TRUE;
        ptr++;
    }
                                                     
    ptr = flags;
   
    for(i=0 ; i<=size ; i++)
    {
        if(*ptr)
        {
            count++;
            prime = i + i + 3;
       
            char * ptr2;
            for(k = i + prime ; k<=size ; k+=prime)
            {
                ptr2 = flags + k; 
                *ptr2=FALSE;
            }
        }
        ptr++;
    }
    
    printf(" %d PRIMES\n", count);
    return;
}


main()
{
    SIEVE(8191);
}

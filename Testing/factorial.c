#include <stdio.h>

int main(){

    __uint16_t w = 1;
    __int16_t *s = &w;
  
    
#if 1
    printf("1 ");
    __uint16_t i;
    for (i=3;i<=2048;i+=2) {
        w *= i;
        printf(" %d *", i);
        if ( i % 11 == 0) printf("\n");
    }
    printf(" . PRINT(\"= %d\", 0xD)\n", *s);
    
#else
    printf("1 ");
    int i;
    for (i=2;i<100;i++) {
        printf(" %d ", i);
        w *= i;
        if ( i % 10 == 0) {
            printf(". PRINT(\"= %d = %d\")\n", w, *s);
            printf("1 ");
            w = 1;
        } else
            printf(" * ");
    }
    w *= i;
    printf("%i . PRINT(\"= %d = %d\")\n", i, w, *s);
#endif
  
}

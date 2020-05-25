#include <stdio.h>

int main(){

    __uint16_t w = 1;
    
    __int16_t *s;
    
    s = &w;
    
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
    
  
}

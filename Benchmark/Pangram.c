#include <stdio.h>

int pangram(const char * str)
{
   str--;
   unsigned char c;
   unsigned long int alphabet = 0;
   
   while (c = *++str) {
      c |= 32; // uppercase
      c -= 'a';
      if ( c<26 ) alphabet |= (long unsigned int) 1 << c;      
   } 
   
   return alphabet==0x3FFFFFF;
}

void PRINT_INT(int num) __naked
{
__asm
    pop  af             ; 1:10      ret
    pop  hl             ; 1:10      num
    push hl             ; 1:11      num
    push af             ; 1:10      ret
;==============================================================================
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
    ld    a, h          ; 1:4       prt_s16
    add   a, a          ; 1:4       prt_s16
    jr   nc, 00001$     ; 2:7/12    prt_s16
    ld    a, #0x2D      ; 2:7       prt_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_s16   putchar('-') with ZX 48K ROM
    xor   a, a          ; 1:4       prt_s16   neg
    sub   a, l          ; 1:4       prt_s16   neg
    ld    l, a          ; 1:4       prt_s16   neg
    sbc   a, h          ; 1:4       prt_s16   neg
    sub   a, l          ; 1:4       prt_s16   neg
    ld    h, a          ; 1:4       prt_s16   neg
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
00001$:
    xor   a, a          ; 1:4       prt_u16   HL=103 & A=0 => 103, HL = 103 & A='0' => 00103
    ld   bc, #0xD8F0    ; 3:10      prt_u16   -10000
    call 00002$         ; 3:17      prt_u16
    ld   bc, #0xFC18    ; 3:10      prt_u16   -1000
    call 00002$         ; 3:17      prt_u16
    ld   bc, #0xFF9C    ; 3:10      prt_u16   -100
    call 00002$         ; 3:17      prt_u16
    ld    c, #0xF6      ; 2:7       prt_u16   -10
    call 00002$         ; 3:17      prt_u16
    ld    c, b          ; 1:4       prt_u16
;------------------------------------------------------------------------------
; Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
00002$:
    inc   a             ; 1:4       bin16_dec
    add  hl, bc         ; 1:11      bin16_dec
    jr    c, 00002$     ; 2:7/12    bin16_dec
    sbc  hl, bc         ; 2:15      bin16_dec
    dec   a             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
00003$:
    or    a, #0x30      ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    ld    a, #0x30      ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec          
__endasm;
}
   
int main()
{    
   char *str = "The five boxing wizards jump quickly.";
   unsigned int i;
   for (i = 10000; i > 0; i--) 
      pangram(str);

   PRINT_INT(pangram(str));
   return 0;
}

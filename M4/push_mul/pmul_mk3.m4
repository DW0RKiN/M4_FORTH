dnl ## constant multiplication, variant 2
define({___},{})dnl
dnl
dnl
dnl
define({TOKENS_HL_ADD_BC_MUL},{dnl
___{}define({_TOKEN_PUSH},{dnl
___{}___{}define({_COST},{0})dnl
___{}___{}define({XMUL_BIT},{1})dnl
___{}___{}define({XMUL_SUM},{0})dnl
___{}___{}define({XMUL_256X_SUM},{0})dnl
___{}___{}define({XMUL_RESULT},{0})})dnl
dnl
___{}define({_TOKEN_POP},{})dnl
dnl
___{}define({_TOKEN_CHECK},{dnl
___{}___{}ifelse(eval(XMUL_RESULT!=$1),{1},{
___{}___{}___{}.error Error in constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
___{}___{}})})dnl
dnl
___{}define({_TOKEN_2X},{dnl
___{}___{}define({XMUL_BIT},eval(2*XMUL_BIT))dnl
___{}___{}_ADD_COST(1+256*11)
___{}___{}    add  HL{,} HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl
dnl
___{}define({_TOKEN_SAVE},{dnl
___{}___{}ifelse(eval(XMUL_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(2+256*8)
___{}___{}___{}    ld    B{,} H          ; 1:4       $1 *
___{}___{}___{}    ld    C{,} L          ; 1:4       $1 *   [XMUL_SUM{}x]{}dnl
___{}___{}},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(10000+256*150)
___{}___{}___{}.error mk3 push_mul() _token_save})})dnl
dnl
___{}define({_TOKEN_256X_SAVE},{dnl
___{}___{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(256*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x{}dnl
___{}___{}},eval(XMUL_256X_SUM>0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x})}){}dnl
dnl
___{}define({_TOKEN_LAST_SAVE},{dnl
___{}___{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
___{}___{}},eval(XMUL_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_BIT},eval(XMUL_BIT+XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(2+256*8)
___{}___{}___{}    add   A{,} H          ; 1:4       $1 *
___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *   XMUL_BIT{}x{}dnl
___{}___{}},eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(2+256*8)
___{}___{}___{}    add   A{,} B          ; 1:4       $1 *
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]})}){}dnl
dnl
___{}define({_TOKEN_LAST_256X_SAVE},{dnl
___{}___{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(3+256*11)
___{}___{}___{}    ld    H{,} L          ; 1:4       $1 *
___{}___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
___{}___{}},eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
___{}___{}___{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(5+256*19)
___{}___{}___{}    add   A{,} B          ; 1:4       $1 *
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]
___{}___{}___{}    ld    H{,} L          ; 1:4       $1 *
___{}___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
___{}___{}},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
___{}___{}___{}define({XMUL_BIT},eval(XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(4+256*15)
___{}___{}___{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x
___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *
___{}___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}})}){}dnl
dnl
___{}define({_TOKEN_LAST_ALL_SAVE},{dnl
___{}___{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
___{}___{}___{}define({XMUL_BIT},eval(257*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(3+256*12)
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x
___{}___{}___{}    add   A{,} H          ; 1:4       $1 *
___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *   XMUL_BIT{}x{}dnl
___{}___{}},eval(XMUL_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
___{}___{}___{}define({XMUL_BIT},eval(XMUL_BIT+XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(3+256*12)
___{}___{}___{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x
___{}___{}___{}    add   A{,} H          ; 1:4       $1 *
___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *   XMUL_BIT{}x{}dnl
___{}___{}},eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+256*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(3+256*12)
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *
___{}___{}___{}    add   A{,} B          ; 1:4       $1 *
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]{}dnl
___{}___{}},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(3+256*12)
___{}___{}___{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x
___{}___{}___{}    add   A{,} B          ; 1:4       $1 *
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]})}){}dnl
dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT+XMUL_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}_ADD_COST(1+256*11)
___{}___{}___{}    add  HL{,} BC         ; 1:11      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x + XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({TOKENS_HL_SUB_BC_MUL},{dnl
___{}TOKENS_HL_ADD_BC_MUL($1)dnl
___{}define({_TOKEN_256X_SAVE},{dnl
___{}___{}ifelse(eval(XMUL_TOPBIT>256*XMUL_BIT),{1},{dnl
___{}___{}___{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}___{}___{}define({XMUL_256X_SUM},eval(256*XMUL_BIT))dnl
___{}___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x{}dnl
___{}___{}___{}},eval(XMUL_256X_SUM>0),{1},{dnl
___{}___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
___{}___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}___{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x{}dnl
___{}___{}___{}},{
___{}___{}___{}.error Unexpected error in constant multiplication function. HL * $1
___{}___{}___{}})dnl
___{}___{}},eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(-256*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   save -{}XMUL_256X_SUM{}x--{}dnl
___{}___{}},eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM)){}dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(-256*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(3+256*12)
___{}___{}___{}    add   A{,} B          ; 1:4       $1 *
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   save -{}XMUL_256X_SUM{}x--{}dnl
___{}___{}},{dnl
___{}___{}___{}define({XMUL_SUM},XMUL_256X_SUM){}dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(-256*XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(4+256*15)
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *
___{}___{}___{}    ld    C{,} 0x00       ; 2:7       $1 *   [XMUL_SUM{}x]
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   save -{}XMUL_256X_SUM{}x--})}){}dnl
dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_SUM>0),{1},{dnl
___{}___{}_ADD_COST(3+256*19)
___{}___{}    or    A             ; 1:4       $1 *
___{}___{}    sbc  HL{,} BC         ; 2:15      $1 *   [eval(XMUL_BIT-XMUL_SUM)x] = XMUL_BIT{}x - XMUL_SUM{}x})})dnl
dnl
___{}define({_TOKEN_LAST_256X_SAVE},{dnl
___{}___{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
___{}___{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}___{}_ADD_COST(3+256*11)
___{}___{}___{}    ld    H{,} L          ; 1:4       $1 *
___{}___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
___{}___{}},eval(XMUL_256X_SUM<0),{1},{dnl
___{}___{}___{}.error  Error in constant multiplication function.
___{}___{}},eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(5+256*19)
___{}___{}___{}    add   A{,} B          ; 1:4       $1 *
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]
___{}___{}___{}    ld    H{,} L          ; 1:4       $1 *
___{}___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
___{}___{}},{dnl
___{}___{}___{}define({XMUL_BIT},eval(XMUL_BIT-XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(6+256*23)
___{}___{}___{}    sub   L             ; 1:4       $1 *
___{}___{}___{}    neg                 ; 2:8       $1 *
___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *
___{}___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x})}){}dnl
dnl
___{}define({_TOKEN_LAST_SAVE},{dnl
___{}___{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
___{}___{}},eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}},eval(XMUL_256X_SUM<0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(-1*XMUL_256X_SUM))dnl
___{}___{}___{}ifelse(eval(XMUL_SUM==0),{1},{dnl A0 - HL
___{}___{}___{}___{}define({XMUL_RESULT},eval(XMUL_256X_SUM-XMUL_BIT))dnl
___{}___{}___{}___{}_ADD_COST(7+256*28)
___{}___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   A0 - HL
___{}___{}___{}___{}    xor   A             ; 1:4       $1 *
___{}___{}___{}___{}    sub   L             ; 1:4       $1 *
___{}___{}___{}___{}    ld    L{,} A          ; 1:4       $1 *
___{}___{}___{}___{}    ld    A{,} B          ; 1:4       $1 *
___{}___{}___{}___{}    sbc   A{,} H          ; 1:4       $1 *
___{}___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *   [XMUL_RESULT{}x] = XMUL_256X_SUM{}x - XMUL_BIT{}x{}dnl
___{}___{}___{}___{}define({XMUL_BIT},XMUL_RESULT)dnl
___{}___{}___{}},{dnl 
___{}___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
___{}___{}___{}___{}define({XMUL_BIT},XMUL_256X_SUM)dnl
___{}___{}___{}___{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM))dnl
___{}___{}___{}___{}_ADD_COST(8+256*39)
___{}___{}___{}___{}    add  HL{,} BC         ; 1:11      $1 *   [XMUL_SUM{}x]
___{}___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   A0 - HL
___{}___{}___{}___{}    xor   A             ; 1:4       $1 *
___{}___{}___{}___{}    sub   L             ; 1:4       $1 *
___{}___{}___{}___{}    ld    L{,} A          ; 1:4       $1 *
___{}___{}___{}___{}    ld    A{,} B          ; 1:4       $1 *
___{}___{}___{}___{}    sbc   A{,} H          ; 1:4       $1 *
___{}___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *   [XMUL_RESULT{}x] = XMUL_256X_SUM{}x - XMUL_BIT{}x{}dnl
___{}___{}___{}___{}define({XMUL_SUM},{0})dnl
___{}___{}___{}___{}define({XMUL_BIT},XMUL_RESULT)})dnl
___{}___{}},eval(XMUL_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(3+256*11)
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 * ???
___{}___{}___{}    ld    C{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
___{}___{}},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(2+256*8)
___{}___{}___{}    add   A{,} B          ; 1:4       $1 *
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]})}){}dnl
dnl
___{}define({_TOKEN_LAST_ALL_SAVE},{dnl
___{}___{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
___{}___{}___{}_ADD_COST(7+256*35)
___{}___{}___{}    ld    B{,} H          ; 1:4       $1 *
___{}___{}___{}    ld    C{,} L          ; 1:4       $1 *   L0 - HL --> L0 - BC
___{}___{}___{}    ld    H{,} L          ; 1:4       $1 *
___{}___{}___{}    xor   A             ; 1:4       $1 *
___{}___{}___{}    ld    L{,} A          ; 1:4       $1 *   eval(256*XMUL_BIT){}x
___{}___{}___{}    sbc  HL{,} BC         ; 2:15      $1 *   [eval(255*XMUL_BIT)x] = eval(256*XMUL_BIT){}x - XMUL_BIT{}x{}dnl
___{}___{}___{}define({XMUL_BIT},eval(255*XMUL_BIT))dnl
___{}___{}},eval(XMUL_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+XMUL_BIT-256*XMUL_BIT))dnl
___{}___{}___{}define({XMUL_BIT},eval(-1*XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(8+256*34)
___{}___{}___{}    sub   L             ; 1:4       $1 *   L0 - (HL + A0) = 0 - ((A0 - L0) + HL)
___{}___{}___{}    add   A{,} H          ; 1:4       $1 *   [XMUL_256X_SUM{}x]
___{}___{}___{}    cpl                 ; 1:4       $1 *
___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *
___{}___{}___{}    cpl                 ; 1:4       $1 *
___{}___{}___{}    ld    L{,} A          ; 1:4       $1 *
___{}___{}___{}    inc  HL             ; 1:6       $1 *   [XMUL_BIT{}x] = 0{}XMUL_256X_SUM{}x{}dnl
___{}___{}},eval(XMUL_256X_SUM==0),{1},{dnl  L0 - ( HL + BC )
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
___{}___{}___{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
___{}___{}___{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM))dnl
___{}___{}___{}_ADD_COST(9+256*43)
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   L0 - (HL + BC) --> B0 - HL
___{}___{}___{}    add  HL{,} BC         ; 1:11      $1 *   [XMUL_SUM{}x]
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *
___{}___{}___{}    xor   A             ; 1:4       $1 *
___{}___{}___{}    sub   L             ; 1:4       $1 *
___{}___{}___{}    ld    L{,} A          ; 1:4       $1 *
___{}___{}___{}    ld    A{,} B          ; 1:4       $1 *
___{}___{}___{}    sbc   A{,} H          ; 1:4       $1 *
___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x{}dnl
___{}___{}___{}define({XMUL_BIT},XMUL_RESULT)dnl
___{}___{}___{}define({XMUL_SUM},{0})dnl
___{}___{}},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+XMUL_SUM+XMUL_BIT-256*XMUL_BIT))dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
___{}___{}___{}define({XMUL_RESULT},eval(-1*XMUL_256X_SUM))dnl
___{}___{}___{}_ADD_COST(9+256*45)
___{}___{}___{}    sub   L             ; 1:4       $1 *   L0 - (HL + BC + A0) = 0 - ((HL + BC) + (A0 - L0))
___{}___{}___{}    add  HL{,} BC         ; 1:11      $1 *   [XMUL_SUM{}x]
___{}___{}___{}    add   A{,} H          ; 1:4       $1 *   [XMUL_256X_SUM{}x]
___{}___{}___{}    cpl                 ; 1:4       $1 *
___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *
___{}___{}___{}    cpl                 ; 1:4       $1 *
___{}___{}___{}    ld    L{,} A          ; 1:4       $1 *
___{}___{}___{}    inc  HL             ; 1:6       $1 *   [XMUL_RESULT{}x] = 0{}XMUL_256X_SUM{}x{}dnl
___{}___{}___{}define({XMUL_BIT},XMUL_RESULT)dnl
___{}___{}___{}define({XMUL_SUM},{0})dnl
___{}___{}}){}dnl
___{}}){}dnl
})dnl
dnl
dnl
dnl
dnl Max 8x add HL,HL
dnl if (bit >= max_bit_H && bit >= max_bit_L) break;
dnl
define({PUSH_MUL_MK3_LOOP},{dnl
___{}ifelse(eval((2*XMUL_BIT <= (XMUL_PAR & 0xff)) || (2*XMUL_BIT <= (XMUL_PAR/256))),{1},{dnl
___{}___{}ifelse(eval((XMUL_PAR & (256*XMUL_BIT))>0),{1},{_ADD_OUTPUT({ _TOKEN_256X_SAVE()})}){}dnl
___{}___{}ifelse(eval((XMUL_PAR & (  1*XMUL_BIT))>0),{1},{_ADD_OUTPUT({ _TOKEN_SAVE()})}){}dnl
___{}___{}_ADD_OUTPUT({ _TOKEN_2X()}){}dnl
___{}___{}define({XMUL_BIT},eval(2*XMUL_BIT)){}dnl
___{}___{}PUSH_MUL_MK3_LOOP($1){}dnl
___{}},{dnl
___{}___{}ifelse(eval(XMUL_PAR & (257*XMUL_BIT)),eval(257*XMUL_BIT),{dnl
___{}___{}___{}_ADD_OUTPUT({ _TOKEN_LAST_ALL_SAVE()}){}dnl
___{}___{}},eval((XMUL_PAR & (256*XMUL_BIT))>0),{1},{dnl
___{}___{}___{}_ADD_OUTPUT({ _TOKEN_LAST_256X_SAVE()}){}dnl
___{}___{}},eval((XMUL_PAR & (  1*XMUL_BIT))>0),{1},{dnl
___{}___{}___{}_ADD_OUTPUT({ _TOKEN_LAST_SAVE()}){}dnl
___{}___{}}){}dnl
___{}})dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK3_CREATE_TOKENS},{dnl
___{}define({XMUL_TOPBIT},HI_BIT($1))dnl
___{}define({XMUL_BIT},{1})dnl
___{}define({XMUL_PAR},eval($1))dnl
___{}define({_COST},{0})dnl
___{}define({XMUL_SUM},{0})dnl
___{}undefine({_TOKEN_2X})dnl
___{}undefine({_TOKEN_SAVE})dnl
___{}undefine({_TOKEN_256X_SAVE})dnl
___{}undefine({_TOKEN_LAST_SAVE})dnl
___{}undefine({_TOKEN_LAST_256X_SAVE})dnl
___{}undefine({_TOKEN_LAST_ALL_SAVE})dnl
___{}undefine({_TOKEN_PUSH})dnl
___{}undefine({_TOKEN_END})dnl
___{}undefine({_TOKEN_CHECK})dnl
___{}undefine({_TOKEN_POP})dnl
___{}define({_OUTPUT},{ _TOKEN_PUSH()})dnl
___{}PUSH_MUL_MK3_LOOP($1)dnl
___{}_ADD_OUTPUT({ _TOKEN_END() _TOKEN_CHECK() _TOKEN_POP()}){}dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK3},{dnl
___{}PUSH_MUL_MK3_CREATE_TOKENS($1)dnl
___{}TOKENS_HL_ADD_BC_MUL($1){}dnl
___{}define({PUSH_MUL_MK3_OUT},_OUTPUT)dnl
___{}define({PUSH_MUL_MK3_COST},_COST)dnl
___{}define({PUSH_MUL_MK3_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk3: HL * (256*a^2 + b^2 + ...)}))dnl
dnl
___{}PUSH_MUL_MK3_CREATE_TOKENS(eval(4*HI_BIT($1)-$1))dnl
___{}TOKENS_HL_SUB_BC_MUL($1){}dnl
___{}define({PUSH_MUL_MK3_TEMP},_OUTPUT)dnl
dnl
___{}ifelse(eval((_COST & 0xff)<(PUSH_MUL_MK3_COST & 0xff)),{1},{dnl
___{}___{}define({PUSH_MUL_MK3_OUT},{PUSH_MUL_MK3_TEMP})dnl
___{}___{}define({PUSH_MUL_MK3_COST},_COST)dnl
___{}___{}define({PUSH_MUL_MK3_INFO},PUSH_MUL_INFO_MINUS(_COST,$1,{Variant mk3: HL * (256*a^2 - b^2 - ...)},eval(2*HI_BIT($1)),eval(2*HI_BIT($1)-$1)))dnl
___{}})dnl
})dnl
dnl
dnl
dnl

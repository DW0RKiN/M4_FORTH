dnl ## constant multiplication, variant 2
define({__},{})dnl
dnl
dnl
dnl
define({TOKENS_HL_ADD_DE_MUL},{dnl
__{}define({_TOKEN_PUSH},{dnl
__{}__{}define({_COST},{0})dnl
__{}__{}define({XMUL_BIT},{1})dnl
__{}__{}define({XMUL_SUM},{0})dnl
__{}__{}define({XMUL_256X_SUM},{0})dnl
__{}__{}define({XMUL_RESULT},{0})dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    ld    B{,} D          ; 1:4       $1 *
__{}__{}    ld    C{,} E          ; 1:4       $1 *})dnl
dnl
__{}define({_TOKEN_POP},{dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    ld    D{,} B          ; 1:4       $1 *
__{}__{}    ld    E{,} C          ; 1:4       $1 *})dnl
dnl
__{}define({_TOKEN_CHECK},{dnl
__{}__{}ifelse(eval(XMUL_RESULT!=$1),{1},{
__{}__{}__{}.error Error in mk2 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
__{}__{}})})dnl
dnl
__{}define({_TOKEN_2X},{dnl
__{}__{}define({XMUL_BIT},eval(2*XMUL_BIT))dnl
__{}__{}_ADD_COST(1+256*11)
__{}__{}    add  HL{,} HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl
dnl
__{}define({_TOKEN_SAVE},{dnl
__{}__{}ifelse(eval(XMUL_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(2+256*8)
__{}__{}__{}    ld    D{,} H          ; 1:4       $1 *
__{}__{}__{}    ld    E{,} L          ; 1:4       $1 *   [XMUL_SUM{}x]{}dnl
__{}__{}},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(3+256*19)
__{}__{}__{}    ex   DE{,} HL         ; 1:4       $1 *
__{}__{}__{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_SUM{}x]
__{}__{}__{}    ex   DE{,} HL         ; 1:4       $1 *})})dnl
dnl
__{}define({_TOKEN_256X_SAVE},{dnl
__{}__{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(256*XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x{}dnl
__{}__{}},eval(XMUL_256X_SUM>0),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x})}){}dnl
dnl
__{}define({_TOKEN_LAST_SAVE},{dnl
__{}__{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
__{}__{}},eval(XMUL_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_BIT},eval(XMUL_BIT+XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(2+256*8)
__{}__{}__{}    add   A{,} H          ; 1:4       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *   XMUL_BIT{}x{}dnl
__{}__{}},eval(XMUL_256X_SUM==0),{1},{dnl
__{}__{}},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(2+256*8)
__{}__{}__{}    add   A{,} D          ; 1:4       $1 *
__{}__{}__{}    ld    D{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]})}){}dnl
dnl
__{}define({_TOKEN_LAST_256X_SAVE},{dnl
__{}__{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
__{}__{}__{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(3+256*11)
__{}__{}__{}    ld    H{,} L          ; 1:4       $1 *
__{}__{}__{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
__{}__{}},eval(XMUL_256X_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},XMUL_BIT)dnl
__{}__{}__{}define({XMUL_BIT},eval(256*XMUL_BIT+XMUL_SUM))dnl
__{}__{}__{}_ADD_COST(4+256*16)
__{}__{}__{}    ld    A{,} D          ; 1:4       $1 *
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    L{,} E          ; 1:4       $1 *   [XMUL_BIT{}x] = XMUL_256X_SUM{}x + XMUL_SUM{}x{}dnl
__{}__{}__{}define({XMUL_SUM},{0})dnl
__{}__{}},eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+XMUL_SUM))dnl
__{}__{}__{}define({XMUL_SUM},eval(256*XMUL_BIT))dnl
__{}__{}__{}define({XMUL_BIT},eval(XMUL_256X_SUM+XMUL_SUM))dnl
__{}__{}__{}_ADD_COST(4+256*16)
__{}__{}__{}    add   A{,} D          ; 1:4       $1 *   [XMUL_256X_SUM{}x]
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    L{,} E          ; 1:4       $1 *   [XMUL_BIT{}x] = XMUL_SUM{}x + XMUL_256X_SUM{}x{}dnl
__{}__{}__{}define({XMUL_SUM},{0})dnl
__{}__{}},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
__{}__{}__{}define({XMUL_BIT},eval(XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(4+256*15)
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}})}){}dnl
dnl
__{}define({_TOKEN_LAST_ALL_SAVE},{dnl
__{}__{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
__{}__{}__{}define({XMUL_BIT},eval(257*XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(3+256*12)
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x
__{}__{}__{}    add   A{,} H          ; 1:4       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *   XMUL_BIT{}x{}dnl
__{}__{}},eval(XMUL_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
__{}__{}__{}define({XMUL_BIT},eval(XMUL_BIT+XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(3+256*12)
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x
__{}__{}__{}    add   A{,} H          ; 1:4       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *   XMUL_BIT{}x{}dnl
__{}__{}},eval(XMUL_256X_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+256*XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(3+256*12)
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *
__{}__{}__{}    add   A{,} D          ; 1:4       $1 *
__{}__{}__{}    ld    D{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]{}dnl
__{}__{}},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(3+256*12)
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x
__{}__{}__{}    add   A{,} D          ; 1:4       $1 *
__{}__{}__{}    ld    D{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]})}){}dnl
dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT+XMUL_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}_ADD_COST(1+256*11)
__{}__{}__{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x + XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({TOKENS_HL_SUB_DE_MUL},{dnl
__{}TOKENS_HL_ADD_DE_MUL($1)dnl
__{}define({_TOKEN_256X_SAVE},{dnl
__{}__{}ifelse(eval(XMUL_TOPBIT>256*XMUL_BIT),{1},{dnl
__{}__{}__{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
__{}__{}__{}__{}define({XMUL_256X_SUM},eval(256*XMUL_BIT))dnl
__{}__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x{}dnl
__{}__{}__{}},eval(XMUL_256X_SUM>0),{1},{dnl
__{}__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_BIT))dnl
__{}__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}__{}    add   A{,} L          ; 1:4       $1 *   XMUL_256X_SUM{}x{}dnl
__{}__{}__{}},{
__{}__{}__{}.error Unexpected error in constant multiplication function. HL * $1
__{}__{}__{}})dnl
__{}__{}},eval(XMUL_256X_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(-256*XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *   save -{}XMUL_256X_SUM{}x--{}dnl
__{}__{}},eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM)){}dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(-256*XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(3+256*12)
__{}__{}__{}    add   A{,} D          ; 1:4       $1 *
__{}__{}__{}    ld    D{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *   save -{}XMUL_256X_SUM{}x--{}dnl
__{}__{}},{dnl
__{}__{}__{}define({XMUL_SUM},XMUL_256X_SUM){}dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(-256*XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(4+256*15)
__{}__{}__{}    ld    D{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    E{,} 0x00       ; 2:7       $1 *   [XMUL_SUM{}x]
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *   save -{}XMUL_256X_SUM{}x--})}){}dnl
dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_SUM>0),{1},{dnl
__{}__{}_ADD_COST(3+256*19)
__{}__{}    or    A             ; 1:4       $1 *
__{}__{}    sbc  HL{,} DE         ; 2:15      $1 *   [eval(XMUL_BIT-XMUL_SUM)x] = XMUL_BIT{}x - XMUL_SUM{}x})})dnl
dnl
__{}define({_TOKEN_LAST_256X_SAVE},{dnl
__{}__{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
__{}__{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
__{}__{}__{}_ADD_COST(3+256*11)
__{}__{}__{}    ld    H{,} L          ; 1:4       $1 *
__{}__{}__{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
__{}__{}},eval(XMUL_256X_SUM<0),{1},{dnl
__{}__{}__{}.error  Error in constant multiplication function.
__{}__{}},eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(5+256*19)
__{}__{}__{}    add   A{,} D          ; 1:4       $1 *
__{}__{}__{}    ld    D{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]
__{}__{}__{}    ld    H{,} L          ; 1:4       $1 *
__{}__{}__{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
__{}__{}},{dnl
__{}__{}__{}define({XMUL_BIT},eval(XMUL_BIT-XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(6+256*23)
__{}__{}__{}    sub   L             ; 1:4       $1 *
__{}__{}__{}    neg                 ; 2:8       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x})}){}dnl
dnl
__{}define({_TOKEN_LAST_SAVE},{dnl
__{}__{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
__{}__{}},eval(XMUL_256X_SUM==0),{1},{dnl
__{}__{}},eval(XMUL_256X_SUM<0),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(-1*XMUL_256X_SUM))dnl
__{}__{}__{}ifelse(eval(XMUL_SUM==0),{1},{dnl A0 - HL
__{}__{}__{}__{}define({XMUL_RESULT},eval(XMUL_256X_SUM-XMUL_BIT))dnl
__{}__{}__{}__{}_ADD_COST(6+256*38)
__{}__{}__{}__{}    ex   DE{,} HL         ; 1:4       $1 *   A0 - DE
__{}__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *
__{}__{}__{}__{}    xor   A             ; 1:4       $1 *
__{}__{}__{}__{}    ld    L{,} A          ; 1:4       $1 *   XMUL_256X_SUM{}x
__{}__{}__{}__{}    sbc  HL{,} DE         ; 2:15      $1 *   [XMUL_RESULT{}x] = XMUL_256X_SUM{}x - XMUL_BIT{}x{}dnl
__{}__{}__{}__{}define({XMUL_BIT},XMUL_RESULT)dnl
__{}__{}__{}},{dnl
__{}__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
__{}__{}__{}__{}define({XMUL_BIT},XMUL_256X_SUM)dnl
__{}__{}__{}__{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM))dnl
__{}__{}__{}__{}_ADD_COST(7+256*42)
__{}__{}__{}__{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_SUM{}x]
__{}__{}__{}__{}    ex   DE{,} HL         ; 1:4       $1 *   A0 - DE
__{}__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *
__{}__{}__{}__{}    xor   A             ; 1:4       $1 *
__{}__{}__{}__{}    ld    L{,} A          ; 1:4       $1 *   XMUL_BIT{}x
__{}__{}__{}__{}    sbc  HL{,} DE         ; 2:15      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x{}dnl
__{}__{}__{}__{}define({XMUL_SUM},{0})dnl
__{}__{}__{}__{}define({XMUL_BIT},XMUL_RESULT)})dnl
__{}__{}},eval(XMUL_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(3+256*11)
__{}__{}__{}    ld    D{,} A          ; 1:4       $1 * ???
__{}__{}__{}    ld    E{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x{}dnl
__{}__{}},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(2+256*8)
__{}__{}__{}    add   A{,} D          ; 1:4       $1 *
__{}__{}__{}    ld    D{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]})}){}dnl
dnl
__{}define({_TOKEN_LAST_ALL_SAVE},{dnl
__{}__{}ifelse(eval((XMUL_256X_SUM==0) && (XMUL_SUM==0)),{1},{dnl
__{}__{}__{}_ADD_COST(6+256*31)
__{}__{}__{}    ex   DE{,} HL         ; 1:4       $1 *   L0 - HL --> E0 - DE
__{}__{}__{}    ld    H{,} E          ; 1:4       $1 *
__{}__{}__{}    xor   A             ; 1:4       $1 *
__{}__{}__{}    ld    L{,} A          ; 1:4       $1 *   eval(256*XMUL_BIT){}x
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      $1 *   [eval(255*XMUL_BIT)x] = eval(256*XMUL_BIT){}x - XMUL_BIT{}x{}dnl
__{}__{}__{}define({XMUL_BIT},eval(255*XMUL_BIT))dnl
__{}__{}},eval(XMUL_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+XMUL_BIT-256*XMUL_BIT))dnl
__{}__{}__{}define({XMUL_BIT},eval(-1*XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(8+256*34)
__{}__{}__{}    sub   L             ; 1:4       $1 *   L0 - (HL + A0) = 0 - ((A0 - L0) + HL)
__{}__{}__{}    add   A{,} H          ; 1:4       $1 *   [XMUL_256X_SUM{}x]
__{}__{}__{}    cpl                 ; 1:4       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *
__{}__{}__{}    cpl                 ; 1:4       $1 *
__{}__{}__{}    ld    L{,} A          ; 1:4       $1 *
__{}__{}__{}    inc  HL             ; 1:6       $1 *   [XMUL_BIT{}x] = 0{}XMUL_256X_SUM{}x{}dnl
__{}__{}},eval(XMUL_256X_SUM==0),{1},{dnl  L0 - ( DE + HL )
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
__{}__{}__{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
__{}__{}__{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM))dnl
__{}__{}__{}_ADD_COST(8+256*39)
__{}__{}__{}    ex   DE{,} HL         ; 1:4       $1 *   L0 - (DE + HL) --> E0 - (HL + DE)
__{}__{}__{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_SUM{}x]
__{}__{}__{}    xor   A             ; 1:4       $1 *
__{}__{}__{}    sub   L             ; 1:4       $1 *
__{}__{}__{}    ld    L{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    A{,} E          ; 1:4       $1 *
__{}__{}__{}    sbc   A{,} H          ; 1:4       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x{}dnl
__{}__{}__{}define({XMUL_BIT},XMUL_RESULT)dnl
__{}__{}__{}define({XMUL_SUM},{0})dnl
__{}__{}},{dnl
__{}__{}__{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+XMUL_SUM+XMUL_BIT-256*XMUL_BIT))dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
__{}__{}__{}define({XMUL_RESULT},eval(-1*XMUL_256X_SUM))dnl
__{}__{}__{}_ADD_COST(9+256*45)
__{}__{}__{}    sub   L             ; 1:4       $1 *   L0 - (HL + DE + A0) = 0 - ((HL + DE) + (A0 - L0))
__{}__{}__{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_SUM{}x]
__{}__{}__{}    add   A{,} H          ; 1:4       $1 *   [XMUL_256X_SUM{}x]
__{}__{}__{}    cpl                 ; 1:4       $1 *
__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *
__{}__{}__{}    cpl                 ; 1:4       $1 *
__{}__{}__{}    ld    L{,} A          ; 1:4       $1 *
__{}__{}__{}    inc  HL             ; 1:6       $1 *   [XMUL_RESULT{}x] = 0{}XMUL_256X_SUM{}x{}dnl
__{}__{}__{}define({XMUL_BIT},XMUL_RESULT)dnl
__{}__{}__{}define({XMUL_SUM},{0})dnl
__{}__{}}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
dnl Max 8x add HL,HL
dnl if (bit >= max_bit_H && bit >= max_bit_L) break;
dnl
define({PUSH_MUL_MK2_LOOP},{dnl
__{}ifelse(eval((2*XMUL_BIT <= (XMUL_PAR & 0xff)) || (2*XMUL_BIT <= (XMUL_PAR/256))),{1},{dnl
__{}__{}ifelse(eval((XMUL_PAR & (256*XMUL_BIT))>0),{1},{_ADD_OUTPUT({ _TOKEN_256X_SAVE()})}){}dnl
__{}__{}ifelse(eval((XMUL_PAR & (  1*XMUL_BIT))>0),{1},{_ADD_OUTPUT({ _TOKEN_SAVE()})}){}dnl
__{}__{}_ADD_OUTPUT({ _TOKEN_2X()}){}dnl
__{}__{}define({XMUL_BIT},eval(2*XMUL_BIT)){}dnl
__{}__{}PUSH_MUL_MK2_LOOP($1){}dnl
__{}},{dnl
__{}__{}ifelse(eval(XMUL_PAR & (257*XMUL_BIT)),eval(257*XMUL_BIT),{dnl
__{}__{}__{}_ADD_OUTPUT({ _TOKEN_LAST_ALL_SAVE()}){}dnl
__{}__{}},eval((XMUL_PAR & (256*XMUL_BIT))>0),{1},{dnl
__{}__{}__{}_ADD_OUTPUT({ _TOKEN_LAST_256X_SAVE()}){}dnl
__{}__{}},eval((XMUL_PAR & (  1*XMUL_BIT))>0),{1},{dnl
__{}__{}__{}_ADD_OUTPUT({ _TOKEN_LAST_SAVE()}){}dnl
__{}__{}}){}dnl
__{}})dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK2_CREATE_TOKENS},{dnl
__{}define({XMUL_TOPBIT},HI_BIT($1))dnl
__{}define({XMUL_BIT},{1})dnl
__{}define({XMUL_PAR},eval($1))dnl
__{}define({_COST},{0})dnl
__{}define({XMUL_SUM},{0})dnl
__{}undefine({_TOKEN_2X})dnl
__{}undefine({_TOKEN_SAVE})dnl
__{}undefine({_TOKEN_256X_SAVE})dnl
__{}undefine({_TOKEN_LAST_SAVE})dnl
__{}undefine({_TOKEN_LAST_256X_SAVE})dnl
__{}undefine({_TOKEN_LAST_ALL_SAVE})dnl
__{}undefine({_TOKEN_PUSH})dnl
__{}undefine({_TOKEN_END})dnl
__{}undefine({_TOKEN_CHECK})dnl
__{}undefine({_TOKEN_POP})dnl
__{}define({_OUTPUT},{ _TOKEN_PUSH()})dnl
__{}PUSH_MUL_MK2_LOOP($1)dnl
__{}_ADD_OUTPUT({ _TOKEN_END() _TOKEN_CHECK() _TOKEN_POP()}){}dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK2},{dnl
__{}PUSH_MUL_MK2_CREATE_TOKENS($1)dnl
__{}TOKENS_HL_ADD_DE_MUL($1){}dnl
__{}define({PUSH_MUL_MK2_OUT},_OUTPUT)dnl
__{}define({PUSH_MUL_MK2_COST},_COST)dnl
__{}define({PUSH_MUL_MK2_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk2: HL * (256*a^2 + b^2 + ...)}))dnl
dnl
__{}PUSH_MUL_MK2_CREATE_TOKENS(eval(4*HI_BIT($1)-$1))dnl
__{}TOKENS_HL_SUB_DE_MUL($1){}dnl
__{}define({PUSH_MUL_MK2_TEMP},_OUTPUT)dnl
dnl
__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK2_COST),{1},{dnl
__{}__{}define({PUSH_MUL_MK2_OUT},{PUSH_MUL_MK2_TEMP})dnl
__{}__{}define({PUSH_MUL_MK2_COST},_COST)dnl
__{}__{}define({PUSH_MUL_MK2_INFO},PUSH_MUL_INFO_MINUS(_COST,$1,{Variant mk2: HL * (256*a^2 - b^2 - ...)},eval(2*HI_BIT($1)),eval(2*HI_BIT($1)-$1)))dnl
__{}})dnl
})dnl
dnl
dnl
dnl

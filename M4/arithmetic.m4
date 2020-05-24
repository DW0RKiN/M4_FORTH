dnl ## Arithmetic
dnl
dnl ( x2 x1 -- x )
dnl x = x2 + x1
define(ADD,{
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +})dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 - x1
define({SUB},{
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -})dnl
dnl
dnl
dnl ( x -- -x )
dnl x = -x
define({NEGATE},{
    xor   A             ; 1:4       negate
    sub   L             ; 1:4       negate
    ld    L, A          ; 1:4       negate
    sbc   A, H          ; 1:4       negate
    sub   L             ; 1:4       negate
    ld    H, A          ; 1:4       negate})dnl
dnl
dnl
dnl ( x -- u )
dnl absolute value of x
define(ABS,{
    ld    A, H          ; 1:4       abs
    add   A, A          ; 1:4       abs
    jr   nc, $+8        ; 2:7/12    abs
    NEGATE})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 * x1
define(UMUL,{
ifdef({USE_UMUL},,define({USE_UMUL},{}))dnl
    call UMULTIPLY      ; 3:17      u*
    pop  DE             ; 1:10      u*})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 / x1
define(UDIV,{
ifdef({USE_UDIV},,define({USE_UDIV},{}))dnl
    call UDIVIDE        ; 3:17      u/
    pop  DE             ; 1:10      u/})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 % x1
define(UMOD,{
ifdef({USE_UDIV},,define({USE_UDIV},{}))dnl
    call UDIVIDE        ; 3:17      umod
    ex   DE, HL         ; 1:4       umod
    pop  DE             ; 1:10      umod})dnl
dnl
dnl
dnl ( x2 x1 -- r q )
dnl x = x2 % x1
define(UDIVMOD,{
ifdef({USE_UDIV},,define({USE_UDIV},{}))dnl
    call UDIVIDE        ; 3:17      u/mod})dnl
dnl
dnl
dnl "1+"
dnl ( x1 -- x )
dnl x = x1 + 1
define(ONE_ADD,{
    inc  HL             ; 1:6       1+})dnl
dnl
dnl
dnl "1-"
dnl ( x1 -- x )
dnl x = x1 - 1
define(ONE_SUB,{
    dec  HL             ; 1:6       1-})dnl
dnl
dnl
dnl "2+"
dnl ( x1 -- x )
dnl x = x1 + 2
define(TWO_ADD,{
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+})dnl
dnl
dnl
dnl "2-"
dnl ( x1 -- x )
dnl x = x1 - 2
define(TWO_SUB,{
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-})dnl
dnl
dnl
dnl "2*"
dnl ( x1 -- x )
dnl x = x1 * 2
define(TWO_MUL,{
    add  HL, HL         ; 1:11      2*})dnl
dnl
dnl
define({SUM_BITS},{define({TEMP},eval(($1 & 0x5555) + ($1 & 0xAAAA)/2)){}dnl
define({TEMP},eval((TEMP & 0x3333) + (TEMP & 0xCCCC)/4)){}dnl
define({TEMP},eval((TEMP & 0x0F0F) + (TEMP & 0xF0F0)/16)){}dnl
eval((TEMP & 0x00FF) + (TEMP & 0xFF00)/256)})dnl
dnl
dnl
dnl
define({SUM_NO_BITS},{define({TEMP},eval($1 | ($1 >> 1)))dnl
define({TEMP},eval(TEMP | (TEMP >> 2)))dnl
define({TEMP},eval(TEMP | (TEMP >> 4)))dnl
define({TEMP},eval(TEMP | (TEMP >> 8)))dnl 
define({TEMP},eval(TEMP | (TEMP >> 16)))dnl
eval(SUM_BITS(TEMP-$1))})dnl
dnl
dnl
dnl "const *"
dnl ( x1 -- const*x1 )
define({XMUL},{define({XMUL_BITS},SUM_BITS($1)){}define({XMUL_NOBITS},SUM_NO_BITS($1))dnl
dnl
define({XMUL_LOOP_START},{define({XMUL_PAR},$1){}define({XMUL_SUM},{1}){}XMUL_LOOP($1)})dnl
dnl
define({XMUL_LOOP},{ifelse(eval(XMUL_PAR>1),{1},{ifelse(eval(XMUL_PAR & 1),{1},{XMUL_SAVE}){}dnl
dnl
define({XMUL_PAR},eval(XMUL_PAR/2)){}ifelse(eval(XMUL_PAR & 127),{0},{define({XMUL_PAR},eval(XMUL_PAR/128)){}define({XMUL_SUM},eval(XMUL_SUM*256))
    ld    H, L          ; 1:4       $1*
    ld    L, 0x00       ; 2:7       $1* XMUL_SUM{}x},{define({XMUL_SUM},eval(2*XMUL_SUM)){}XMUL_2X}){}XMUL_LOOP($1)})})dnl
dnl
define({XMUL_NEGLOOP_START},{define({XMUL_PAR},$1){}define({XMUL_SUM},{1}){}XMUL_NEGLOOP($1)})dnl
dnl
define({XMUL_NEGLOOP},{ifelse(eval(XMUL_PAR>=1),{1},{ifelse(eval(XMUL_PAR & 1),{0},{XMUL_SAVE}){}dnl
dnl
define({XMUL_PAR},eval(XMUL_PAR/2)){}ifelse(eval(XMUL_PAR & 127),{127},{define({XMUL_PAR},eval(XMUL_PAR/128)){}define({XMUL_SUM},eval(XMUL_SUM*256))
    ld    H, L          ; 1:4       $1*
    ld    L, 0x00       ; 2:7       $1* XMUL_SUM{}x},{define({XMUL_SUM},eval(2*XMUL_SUM)){}XMUL_2X}){}XMUL_NEGLOOP($1)})})dnl
dnl
ifelse(eval($1==0),{1},{
    ld   HL, 0x0000     ; 3:10      0*},
eval($1==1),{1},{},
XMUL_BITS,{1},{dnl
dnl
dnl Pro nasobky dvou jako 1,2,4,8,16,32,...
dnl
define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1* XMUL_SUM{}x})dnl
XMUL_LOOP_START(XMUL_1)},
XMUL_BITS,{2},{dnl
dnl
dnl Pro soucty nasobku dvou jako 3,5,6,9,10,12,17,18,20,24,...
dnl Not all variants are optimal. For example, 258.
dnl
define({XMUL_SAVE},{
    ld    B, H          ; 1:4       $1*
    ld    C, L          ; 1:4       $1* save XMUL_SUM{}x}){}dnl
define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1* XMUL_SUM{}x}){}dnl
XMUL_LOOP_START(XMUL_1)
    add  HL, BC         ; 1:11      $1* HL + save},
XMUL_NOBITS,{0},{dnl
dnl
dnl Pro (2^x)-1 jako 2-1,4-1,8-1,16-1,32-1,64-1,128-1,...

    ld    B, H          ; 1:4       $1*
    ld    C, L          ; 1:4       $1* save 1x{}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1* XMUL_SUM{}x}){}dnl
XMUL_NEGLOOP_START(XMUL_1)
    sbc  HL, BC         ; 2:15      $1* HL - save},
XMUL_BITS,{3},{dnl
dnl
dnl Soucty 3 bitu jako 11=8+2+1,69=64+4+1
dnl
define({XMUL_SAVE},{
    ld    B, H          ; 1:4       $1*
    ld    A, L          ; 1:4       $1* save XMUL_SUM{}x{}define({XMUL_SAVE},{
    add   A, L          ; 1:4       $1*
    ld    C, A          ; 1:4       $1*
    ld    A, B          ; 1:4       $1*
    add   A, H          ; 1:4       $1*
    ld    B, A          ; 1:4       $1* +save XMUL_SUM{}x})}){}dnl
define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1* XMUL_SUM{}x}){}XMUL_LOOP_START(XMUL_1)
    add  HL, BC         ; 1:11      $1* HL + save},
XMUL_NOBITS,{1},{dnl
dnl
dnl Pro (2^x)-(2^(x-y))-1 jako 27=(32-4)-1
dnl
ifelse(eval($1 & 1),{1},{define({XMUL_SAVE},{
    add   A, L          ; 1:4       $1*
    ld    C, A          ; 1:4       $1*
    ld    A, B          ; 1:4       $1*
    add   A, H          ; 1:4       $1*
    ld    B, A          ; 1:4       $1* +save XMUL_SUM{}x})define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1* XMUL_SUM{}x})
    ld    B, H          ; 1:4       $1*
    ld    A, L          ; 1:4       $1* save 1x},{define({XMUL_2X},{define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1* XMUL_SUM{}x})})define({XMUL_SAVE},{
    add  HL, HL         ; 1:11      $1* 2x
    ld    C, L          ; 1:4       $1*
    ld    B, H          ; 1:4       $1* +save 2x})}){}XMUL_NEGLOOP_START(XMUL_1)
    sbc  HL, BC         ; 2:15      $1* HL - save},
eval(XMUL_NOBITS+2>XMUL_BITS),{1},{dnl
dnl
dnl Ostatni...
dnl
define({XMUL_SAVE},{
    ld    D, H          ; 1:4       $1*
    ld    E, L          ; 1:4       $1* save XMUL_SUM{}x{}define({XMUL_SAVE},{
    ex   DE, HL         ; 1:4       $1*
    add  HL, DE         ; 1:11      $1* +save XMUL_SUM{}x
    ex   DE, HL         ; 1:4       $1*})}){}dnl
define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1* XMUL_SUM{}x})
    ld    B, D          ; 1:4       $1*
    ld    C, E          ; 1:4       $1*{}XMUL_LOOP_START(XMUL_1)
    add  HL, DE         ; 1:11      $1* HL + save
    ld    D, B          ; 1:4       $1*
    ld    E, C          ; 1:4       $1*},{dnl
dnl
dnl Ostatni minus...
dnl
define({XMUL_SAVE},{
    ex   DE, HL         ; 1:4       $1*
    add  HL, DE         ; 1:11      $1* +save XMUL_SUM{}x
    ex   DE, HL         ; 1:4       $1*}){}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1* XMUL_SUM{}x})
    ld    B, D          ; 1:4       $1*
    ld    C, E          ; 1:4       $1*
    ld    D, H          ; 1:4       $1*
    ld    E, L          ; 1:4       $1* save 1x{}XMUL_NEGLOOP_START(XMUL_1)
    sbc  HL, DE         ; 2:15      $1* HL - save
    ld    D, B          ; 1:4       $1*
    ld    E, C          ; 1:4       $1*})})dnl
dnl
dnl
dnl
dnl
dnl "2/"
dnl ( x1 -- x )
dnl x = x1 / 2
define(TWO_DIV,{
    sra   H             ; 2:8       2/   with sign
    rr    L             ; 2:8       2/})dnl
dnl
dnl

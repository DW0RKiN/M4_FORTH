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
dnl
dnl "const *"
dnl ( x1 -- const*x1 )
define({XMUL},{define({XMUL_BITS},eval(($1 & 0x5555) + ($1 & 0xAAAA)/2)){}dnl
define({XMUL_BITS},eval((XMUL_BITS & 0x3333) + (XMUL_BITS & 0xCCCC)/4)){}dnl
define({XMUL_BITS},eval((XMUL_BITS & 0x0F0F) + (XMUL_BITS & 0xF0F0)/16)){}dnl
define({XMUL_BITS},eval((XMUL_BITS & 0x00FF) + (XMUL_BITS & 0xFF00)/256)){}dnl
ifelse(eval($1==0),{1},{
    ld   HL, 0x0000     ; 3:10      0*},
eval($1==1),{1},{},
XMUL_BITS,{1},{dnl
dnl
dnl Pro nasobky dvou jako 1,2,4,8,16,32,...
dnl
ifelse(eval($1 & 255),{0},{define({XMUL_1},eval($1/256))
    ld    H, L          ; 1:4       $1* 256x
    ld    L, 0x00       ; 2:7       $1* 256x},define({XMUL_1},$1)){}define({XMUL_2X},{{
    add  HL, HL         ; 1:11      $1*}})dnl
ifelse(eval(XMUL_1 > 0x001),{1},{XMUL_2X 2x}){}dnl
ifelse(eval(XMUL_1 > 0x002),{1},{XMUL_2X 4x}){}dnl
ifelse(eval(XMUL_1 > 0x004),{1},{XMUL_2X 8x}){}dnl
ifelse(eval(XMUL_1 > 0x008),{1},{XMUL_2X 16x}){}dnl
ifelse(eval(XMUL_1 > 0x010),{1},{XMUL_2X 32x}){}dnl
ifelse(eval(XMUL_1 > 0x020),{1},{XMUL_2X 64x}){}dnl
ifelse(eval(XMUL_1 > 0x040),{1},{XMUL_2X 128x})},
XMUL_BITS,{2},{dnl
dnl
dnl Pro soucty nasobku dvou jako 3,5,6,9,10,12,17,18,20,24,...
dnl
ifelse(eval($1 & 255),{0},{define({XMUL_1},eval($1/256))
    ld    H, L          ; 1:4       $1* 256x
    ld    L, 0x00       ; 2:7       $1* 256x},define({XMUL_1},$1)){}define({XMUL_2X},{{
    add  HL, HL         ; 1:11      $1*}}){}dnl
define({XMUL_SAVE},{{
    ld    B, H          ; 1:4       $1* save HL
    ld    C, L          ; 1:4       $1* save HL}}){}dnl
ifelse(eval(XMUL_1 > 0x0002),{1},{ifelse(eval(XMUL_1 & 0x0001),{0},,{XMUL_SAVE}){}XMUL_2X     2x}){}dnl
ifelse(eval(XMUL_1 > 0x0004),{1},{ifelse(eval(XMUL_1 & 0x0002),{0},,{XMUL_SAVE}){}XMUL_2X     4x}){}dnl
ifelse(eval(XMUL_1 > 0x0008),{1},{ifelse(eval(XMUL_1 & 0x0004),{0},,{XMUL_SAVE}){}XMUL_2X     8x}){}dnl
ifelse(eval(XMUL_1 > 0x0010),{1},{ifelse(eval(XMUL_1 & 0x0008),{0},,{XMUL_SAVE}){}XMUL_2X    16x}){}dnl
ifelse(eval(XMUL_1 > 0x0020),{1},{ifelse(eval(XMUL_1 & 0x0010),{0},,{XMUL_SAVE}){}XMUL_2X    32x}){}dnl
ifelse(eval(XMUL_1 > 0x0040),{1},{ifelse(eval(XMUL_1 & 0x0020),{0},,{XMUL_SAVE}){}XMUL_2X    64x}){}dnl
ifelse(eval(XMUL_1 > 0x0080),{1},{ifelse(eval(XMUL_1 & 0x0040),{0},,{XMUL_SAVE}){}XMUL_2X   128x}){}dnl
ifelse(eval(XMUL_1 > 0x0100),{1},{ifelse(eval(XMUL_1 & 0x0080),{0},,{XMUL_SAVE}){}XMUL_2X   256x}){}dnl
ifelse(eval(XMUL_1 > 0x0200),{1},{ifelse(eval(XMUL_1 & 0x0100),{0},,{XMUL_SAVE}){}XMUL_2X   512x}){}dnl
ifelse(eval(XMUL_1 > 0x0400),{1},{ifelse(eval(XMUL_1 & 0x0200),{0},,{XMUL_SAVE}){}XMUL_2X  1024x}){}dnl
ifelse(eval(XMUL_1 > 0x0800),{1},{ifelse(eval(XMUL_1 & 0x0400),{0},,{XMUL_SAVE}){}XMUL_2X  2048x}){}dnl
ifelse(eval(XMUL_1 > 0x1000),{1},{ifelse(eval(XMUL_1 & 0x0800),{0},,{XMUL_SAVE}){}XMUL_2X  4096x}){}dnl
ifelse(eval(XMUL_1 > 0x2000),{1},{ifelse(eval(XMUL_1 & 0x1000),{0},,{XMUL_SAVE}){}XMUL_2X  8192x}){}dnl
ifelse(eval(XMUL_1 > 0x4000),{1},{ifelse(eval(XMUL_1 & 0x2000),{0},,{XMUL_SAVE}){}XMUL_2X 16384x}){}dnl
ifelse(eval(XMUL_1 > 0x8000),{1},{ifelse(eval(XMUL_1 & 0x4000),{0},,{XMUL_SAVE}){}XMUL_2X 32768x})                                                                
    add  HL, BC         ; 1:11      $1* HL+save},
eval($1==7),{1},{
    ld    C, L          ; 1:4       7*
    ld    B, H          ; 1:4       7*
    add  HL, HL         ; 1:11      7* 2x
    add  HL, HL         ; 1:11      7* 4x
    add  HL, HL         ; 1:11      7* 8x
    sbc  HL, BC         ; 2:15      7* -1x},
eval($1==15),{1},{
    ld    C, L          ; 1:4       7*
    ld    B, H          ; 1:4       7*
    add  HL, HL         ; 1:11      7* 2x
    add  HL, HL         ; 1:11      7* 4x
    add  HL, HL         ; 1:11      7* 8x
    add  HL, HL         ; 1:11      7* 16x
    sbc  HL, BC         ; 2:15      7* -1x},{dnl
dnl Ostatni
dnl
ifelse(eval($1 & 255),{0},{define({XMUL_1},eval($1/256))
    ld    H, L          ; 1:4       $1* 256x
    ld    L, 0x00       ; 2:7       $1* 256x},define({XMUL_1},$1)){}define({XMUL_2X},{{
    add  HL, HL         ; 1:11      $1*}}){}dnl
define({XMUL_SAVE},{
    ld    B, H          ; 1:4       $1* save HL
    ld    C, L          ; 1:4       $1* save HL{}define({XMUL_SAVE},{
    ex   DE, HL         ; 1:4       $1* + save HL
    add  HL, DE         ; 1:11      $1* + save HL
    ex   DE, HL         ; 1:4       $1* + save HL})}){}dnl
ifelse(eval(XMUL_1 > 0x0002),{1},{ifelse(eval(XMUL_1 & 0x0001),{0},,{XMUL_SAVE}){}XMUL_2X     2x}){}dnl
ifelse(eval(XMUL_1 > 0x0004),{1},{ifelse(eval(XMUL_1 & 0x0002),{0},,{XMUL_SAVE}){}XMUL_2X     4x}){}dnl
ifelse(eval(XMUL_1 > 0x0008),{1},{ifelse(eval(XMUL_1 & 0x0004),{0},,{XMUL_SAVE}){}XMUL_2X     8x}){}dnl
ifelse(eval(XMUL_1 > 0x0010),{1},{ifelse(eval(XMUL_1 & 0x0008),{0},,{XMUL_SAVE}){}XMUL_2X    16x}){}dnl
ifelse(eval(XMUL_1 > 0x0020),{1},{ifelse(eval(XMUL_1 & 0x0010),{0},,{XMUL_SAVE}){}XMUL_2X    32x}){}dnl
ifelse(eval(XMUL_1 > 0x0040),{1},{ifelse(eval(XMUL_1 & 0x0020),{0},,{XMUL_SAVE}){}XMUL_2X    64x}){}dnl
ifelse(eval(XMUL_1 > 0x0080),{1},{ifelse(eval(XMUL_1 & 0x0040),{0},,{XMUL_SAVE}){}XMUL_2X   128x}){}dnl
ifelse(eval(XMUL_1 > 0x0100),{1},{ifelse(eval(XMUL_1 & 0x0080),{0},,{XMUL_SAVE}){}XMUL_2X   256x}){}dnl
ifelse(eval(XMUL_1 > 0x0200),{1},{ifelse(eval(XMUL_1 & 0x0100),{0},,{XMUL_SAVE}){}XMUL_2X   512x}){}dnl
ifelse(eval(XMUL_1 > 0x0400),{1},{ifelse(eval(XMUL_1 & 0x0200),{0},,{XMUL_SAVE}){}XMUL_2X  1024x}){}dnl
ifelse(eval(XMUL_1 > 0x0800),{1},{ifelse(eval(XMUL_1 & 0x0400),{0},,{XMUL_SAVE}){}XMUL_2X  2048x}){}dnl
ifelse(eval(XMUL_1 > 0x1000),{1},{ifelse(eval(XMUL_1 & 0x0800),{0},,{XMUL_SAVE}){}XMUL_2X  4096x}){}dnl
ifelse(eval(XMUL_1 > 0x2000),{1},{ifelse(eval(XMUL_1 & 0x1000),{0},,{XMUL_SAVE}){}XMUL_2X  8192x}){}dnl
ifelse(eval(XMUL_1 > 0x4000),{1},{ifelse(eval(XMUL_1 & 0x2000),{0},,{XMUL_SAVE}){}XMUL_2X 16384x}){}dnl
ifelse(eval(XMUL_1 > 0x8000),{1},{ifelse(eval(XMUL_1 & 0x4000),{0},,{XMUL_SAVE}){}XMUL_2X 32768x})                                                                
    add  HL, DE         ; 1:11      $1* HL+save})}){}dnl
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

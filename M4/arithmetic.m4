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
dnl ( x -- x )
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
dnl "2/"
dnl ( x1 -- x )
dnl x = x1 / 2
define(TWO_DIV,{
    sra   H             ; 2:8       2/   with sign
    rr    L             ; 2:8       2/})dnl
dnl
dnl

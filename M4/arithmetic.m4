dnl ## Arithmetic
define({__},{})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 + x1
define({ADD},{
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +})dnl
dnl
dnl
dnl ( x -- x+n )
dnl x = x + n
define({PUSH_ADD},{ifelse(eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 +
__{}    add  HL, BC         ; 1:11      $1 +},{ifelse(
__{}eval((($1)+3*256) & 0xffff),{0},{
__{}    dec  H              ; 1:4       $1 +   ( x -- x+__HEX_HL($1) )
__{}    dec  H              ; 1:4       $1 +
__{}    dec  H              ; 1:4       $1 +},
__{}eval((($1)+2*256) & 0xffff),{0},{
__{}    dec  H              ; 1:4       $1 +   ( x -- x+__HEX_HL($1) )
__{}    dec  H              ; 1:4       $1 +},
__{}eval((($1)+1*256) & 0xffff),{0},{
__{}    dec  H              ; 1:4       $1 +   ( x -- x+__HEX_HL($1) )},
__{}eval((($1)+    3) & 0xffff),{0},{
__{}    dec  HL             ; 1:6       $1 +   ( x -- x+__HEX_HL($1) )
__{}    dec  HL             ; 1:6       $1 +
__{}    dec  HL             ; 1:6       $1 +},
__{}eval((($1)+    2) & 0xffff),{0},{
__{}    dec  HL             ; 1:6       $1 +   ( x -- x+__HEX_HL($1) )
__{}    dec  HL             ; 1:6       $1 +},
__{}eval((($1)+    1) & 0xffff),{0},{
__{}    dec  HL             ; 1:6       $1 +   ( x -- x+__HEX_HL($1) )},
__{}eval(($1) & 0xFFFF),{0},{
__{}                        ;           $1 +   ( x -- x+__HEX_HL($1) )},
__{}eval(($1)-1),{0},{
__{}    inc  HL             ; 1:6       $1 +   ( x -- x+__HEX_HL($1) )},
__{}eval(($1)-2),{0},{
__{}    inc  HL             ; 1:6       $1 +   ( x -- x+__HEX_HL($1) )
__{}    inc  HL             ; 1:6       $1 +},
__{}eval(($1)-3),{0},{
__{}    inc  HL             ; 1:6       $1 +   ( x -- x+__HEX_HL($1) )
__{}    inc  HL             ; 1:6       $1 +
__{}    inc  HL             ; 1:6       $1 +},
__{}eval(($1)-1*256),{0},{
__{}    inc  H              ; 1:4       $1 +   ( x -- x+__HEX_HL($1) )},
__{}eval(($1)-2*256),{0},{
__{}    inc  H              ; 1:4       $1 +   ( x -- x+__HEX_HL($1) )
__{}    inc  H              ; 1:4       $1 +},
__{}eval(($1)-3*256),{0},{
__{}    inc  H              ; 1:4       $1 +   ( x -- x+__HEX_HL($1) )
__{}    inc  H              ; 1:4       $1 +
__{}    inc  H              ; 1:4       $1 +},
__{}eval((($1)) & 0xFF),{0},{
__{}    ld    A, __HEX_H($1)       ; 2:7       $1 +   ( x -- x+__HEX_HL($1) )
__{}    add   A, H          ; 1:4       $1 +
__{}    ld    H, A          ; 1:4       $1 +},
__{}{
__{}    ld   BC, __HEX_HL($1)     ; 3:10      $1 +   ( x -- x+__HEX_HL($1) )
__{}    add  HL, BC         ; 1:11      $1 +})})})dnl
dnl
dnl
dnl
dnl dup 5 +
dnl ( x -- x x+n )
define({DUP_PUSH_ADD},{ifelse(eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    push DE             ; 1:11      dup $1 +   ( x -- x x+$1 )
__{}    ex   DE, HL         ; 1:4       dup $1 +
__{}    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      dup $1 +
__{}    add  HL, DE         ; 1:11      dup $1 +},
{
__{}    push DE             ; 1:11      dup $1 +   ( x -- x x+{}__HEX_HL($1) ){}ifelse(dnl
__{}eval((($1)+3*256) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    dec   H             ; 1:4       dup $1 +
__{}__{}    dec   H             ; 1:4       dup $1 +
__{}__{}    dec   H             ; 1:4       dup $1 +},
__{}eval((($1)+2*256) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    dec   H             ; 1:4       dup $1 +
__{}__{}    dec   H             ; 1:4       dup $1 +},
__{}eval((($1)+1*256) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    dec   H             ; 1:4       dup $1 +},
__{}eval((($1)+    2) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    dec  HL             ; 1:6       dup $1 +
__{}__{}    dec  HL             ; 1:6       dup $1 +},
__{}eval((($1)+    1) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    dec  HL             ; 1:6       dup $1 +},
__{}eval(($1) & 0xFFFF),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +},
__{}eval(($1)-1),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    inc  HL             ; 1:6       dup $1 +},
__{}eval(($1)-2),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    inc  HL             ; 1:6       dup $1 +
__{}__{}    inc  HL             ; 1:6       dup $1 +},
__{}eval(($1)-1*256),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    inc   H             ; 1:4       dup $1 +},
__{}eval(($1)-2*256),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    inc   H             ; 1:4       dup $1 +
__{}__{}    inc   H             ; 1:4       dup $1 +},
__{}eval(($1)-3*256),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    inc   H             ; 1:4       dup $1 +
__{}__{}    inc   H             ; 1:4       dup $1 +
__{}__{}    inc   H             ; 1:4       dup $1 +},
__{}eval((($1)) & 0xFF),{0},{
__{}__{}    ld    D, H          ; 1:4       dup $1 +
__{}__{}    ld    E, L          ; 1:4       dup $1 +
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       dup $1 +
__{}__{}    add   A, H          ; 1:4       dup $1 +
__{}__{}    ld    H, A          ; 1:4       dup $1 +},
__{}{
__{}__{}    ex   DE, HL         ; 1:4       dup $1 +
__{}__{}    ld   HL, __HEX_HL($1)     ; 3:10      dup $1 +
__{}__{}    add  HL, DE         ; 1:11      dup $1 +}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl "dup +"
dnl ( x1 -- x2 )
dnl x2 = x1 + x1
define({DUP_ADD},{
    add  HL, HL         ; 1:11      dup +})dnl
dnl
dnl
dnl over +
dnl ( x2 x1 -- x2 x1+x2 )
define({OVER_ADD},{
    add  HL, DE         ; 1:11      over +})dnl
dnl
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
dnl swap -
dnl ( x2 x1 -- x )
dnl x = x1 - x2
define({SWAP_SUB},{
    or    A             ; 1:4       swap -
    sbc  HL, DE         ; 2:15      swap -
    pop  DE             ; 1:10      swap -})dnl
dnl
dnl
dnl over -
dnl ( x2 x1 -- x2 x1-x2 )
define({OVER_SUB},{
    or    A             ; 1:4       over -
    sbc  HL, DE         ; 2:15      over -})dnl
dnl
dnl
dnl ( x -- x-n )
dnl x = x - n
define({PUSH_SUB},{ifelse(eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 -
__{}    or    A             ; 1:4       $1 -
__{}    sbc  HL, BC         ; 2:15      $1 -},{ifelse(
__{}eval((($1)+3*256) & 0xffff),{0},{
__{}    inc  H              ; 1:4       $1 -   ( x -- x-__HEX_HL($1) )
__{}    inc  H              ; 1:4       $1 -
__{}    inc  H              ; 1:4       $1 -},
__{}eval((($1)+2*256) & 0xffff),{0},{
__{}    inc  H              ; 1:4       $1 -   ( x -- x-__HEX_HL($1) )
__{}    inc  H              ; 1:4       $1 -},
__{}eval((($1)+1*256) & 0xffff),{0},{
__{}    inc  H              ; 1:4       $1 -   ( x -- x-__HEX_HL($1) )},
__{}eval((($1)+    3) & 0xffff),{0},{
__{}    inc  HL             ; 1:6       $1 -   ( x -- x-__HEX_HL($1) )
__{}    inc  HL             ; 1:6       $1 -
__{}    inc  HL             ; 1:6       $1 -},
__{}eval((($1)+    2) & 0xffff),{0},{
__{}    inc  HL             ; 1:6       $1 -   ( x -- x-__HEX_HL($1) )
__{}    inc  HL             ; 1:6       $1 -},
__{}eval((($1)+    1) & 0xffff),{0},{
__{}    inc  HL             ; 1:6       $1 -   ( x -- x-__HEX_HL($1) )},
__{}eval((-($1)) & 0xFFFF),{0},{
__{}                        ;           $1 -   ( x -- x-__HEX_HL($1) )},
__{}eval(($1)-1),{0},{
__{}    dec  HL             ; 1:6       $1 -   ( x -- x-__HEX_HL($1) )},
__{}eval(($1)-2),{0},{
__{}    dec  HL             ; 1:6       $1 -   ( x -- x-__HEX_HL($1) )
__{}    dec  HL             ; 1:6       $1 -},
__{}eval(($1)-3),{0},{
__{}    dec  HL             ; 1:6       $1 -   ( x -- x-__HEX_HL($1) )
__{}    dec  HL             ; 1:6       $1 -
__{}    dec  HL             ; 1:6       $1 -},
__{}eval(($1)-1*256),{0},{
__{}    dec  H              ; 1:4       $1 -   ( x -- x-__HEX_HL($1) )},
__{}eval(($1)-2*256),{0},{
__{}    dec  H              ; 1:4       $1 -   ( x -- x-__HEX_HL($1) )
__{}    dec  H              ; 1:4       $1 -},
__{}eval(($1)-3*256),{0},{
__{}    dec  H              ; 1:4       $1 -   ( x -- x-__HEX_HL($1) )
__{}    dec  H              ; 1:4       $1 -
__{}    dec  H              ; 1:4       $1 -},
__{}eval((-($1)) & 0xFF),{0},{
__{}    ld    A, __HEX_H(-($1))       ; 2:7       $1 -   ( x -- x-__HEX_HL($1) )
__{}    add   A, H          ; 1:4       $1 -
__{}    ld    H, A          ; 1:4       $1 -},
__{}{
__{}    ld   BC, __HEX_HL(-($1))     ; 3:10      $1 -   ( x -- x-__HEX_HL($1) )
__{}    add  HL, BC         ; 1:11      $1 -})})})dnl
dnl
dnl
dnl ( x -- u )
dnl absolute value of x
define({ABS},{
    ld    A, H          ; 1:4       abs
    add   A, A          ; 1:4       abs
    jr   nc, $+8        ; 2:7/12    abs
    NEGATE})dnl
dnl
dnl
dnl ( 5 3 -- 5 )
dnl ( -5 -3 -- -3 )
define({MAX},{
    ld    A, E          ; 1:4       max    DE<HL --> DE-HL<0 --> carry if HL is max
    sub   L             ; 1:4       max    DE<HL --> DE-HL<0 --> carry if HL is max
    ld    A, D          ; 1:4       max    DE<HL --> DE-HL<0 --> carry if HL is max
    sbc   A, H          ; 1:4       max    DE<HL --> DE-HL<0 --> carry if HL is max
    rra                 ; 1:4       max
    xor   H             ; 1:4       max
    xor   D             ; 1:4       max
    jp    m, $+4        ; 3:10      max
    ex   DE, HL         ; 1:4       max
    pop  DE             ; 1:10      max})dnl
dnl
dnl
dnl ( 5 3 -- 5 )
dnl ( -5 -3 -- -3 )
define({PUSH_MAX},{ifelse(__IS_MEM_REF($1),{1},{
    ld   BC, format({%-11s},$1); 4:20      $1 max
    ld    A, L          ; 1:4       $1 max    HL<$1 --> HL-$1<0 --> carry if $1 is max
    sub   C             ; 1:4       $1 max    HL<$1 --> HL-$1<0 --> carry if $1 is max
    ld    A, H          ; 1:4       $1 max    HL<$1 --> HL-$1<0 --> carry if $1 is max
    sbc   A, B          ; 1:4       $1 max    HL<$1 --> HL-$1<0 --> carry if $1 is max
    rra                 ; 1:4       $1 max
    xor   H             ; 1:4       $1 max
    xor   B             ; 1:4       $1 max
    jp    p, $+5        ; 3:10      $1 max
    ld    H, B          ; 1:4       $1 max
    ld    L, C          ; 1:4       $1 max    16:62 (58+66)/2},{
    ld    A, low format({%-7s},$1); 2:7       $1 max    $1>HL --> $1-HL>0 --> not carry if $1 is max or equal
    sub   L             ; 1:4       $1 max    $1>HL --> $1-HL>0 --> not carry if $1 is max or equal
    ld    A, high format({%-6s},$1); 2:7       $1 max    $1>HL --> $1-HL>0 --> not carry if $1 is max or equal
    sbc   A, H          ; 1:4       $1 max    $1>HL --> $1-HL>0 --> not carry if $1 is max or equal
    rra                 ; 1:4       $1 max
    xor   H             ; 1:4       $1 max
ifelse(eval($1),{},{dnl
__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}    jp    m, $+6        ; 3:10      $1 max    positive constant $1
__{}  else
__{}    jp    p, $+6        ; 3:10      $1 max    negative constant $1
__{}  endif},
{dnl
__{}ifelse(eval(($1) & 0x8000),0,{dnl
__{}    jp    m, $+6        ; 3:10      $1 max    positive constant $1},
__{}{dnl
__{}    jp    p, $+6        ; 3:10      $1 max    negative constant $1})})
    ld   HL, format({%-11s},$1); 3:10      $1 max    14:45 (40+50)/2})})dnl
dnl
dnl
dnl ( 5 3 -- 3 )
dnl ( -5 -3 -- -5 )
define({MIN},{
    ld    A, E          ; 1:4       min    DE>=HL --> DE-HL>=0 --> not carry if HL is min
    sub   L             ; 1:4       min    DE>=HL --> DE-HL>=0 --> not carry if HL is min
    ld    A, D          ; 1:4       min    DE>=HL --> DE-HL>=0 --> not carry if HL is min
    sbc   A, H          ; 1:4       min    DE>=HL --> DE-HL>=0 --> not carry if HL is min
    rra                 ; 1:4       min
    xor   H             ; 1:4       min
    xor   D             ; 1:4       min
    jp    p, $+4        ; 3:10      min
    ex   DE, HL         ; 1:4       min
    pop  DE             ; 1:10      min})dnl
dnl
dnl
dnl ( 5 3 -- 3 )
dnl ( -5 -3 -- -5 )
define({PUSH_MIN},{ifelse(__IS_MEM_REF($1),{1},{
                        ;[16:~62]   $1 min
    ld   BC, format({%-11s},$1); 4:20      $1 min
    ld    A, C          ; 1:4       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    sub   L             ; 1:4       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    ld    A, B          ; 1:4       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    sbc   A, H          ; 1:4       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    rra                 ; 1:4       $1 min
    xor   H             ; 1:4       $1 min
    xor   B             ; 1:4       $1 min
    jp    p, $+5        ; 3:10      $1 min
    ld    H, B          ; 1:4       $1 min
    ld    L, C          ; 1:4       $1 min}
,{
                        ;[14:~45]   $1 min
    ld    A, low format({%-7s},$1); 2:7       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    sub   L             ; 1:4       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    ld    A, high format({%-6s},$1); 2:7       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    sbc   A, H          ; 1:4       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    rra                 ; 1:4       $1 min
    xor   H             ; 1:4       $1 min{}dnl
__{}ifelse(eval($1),{},{
__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}    jp    p, $+6        ; 3:10      $1 min    positive constant $1
__{}__{}  else
__{}__{}    jp    m, $+6        ; 3:10      $1 min    negative constant $1
__{}__{}  endif}
__{},eval(($1) & 0x8000),0,{
__{}__{}    jp    p, $+6        ; 3:10      $1 min    positive constant $1}dnl
__{},{
__{}__{}    jp    m, $+6        ; 3:10      $1 min    negative constant $1})
    ld   HL, format({%-11s},$1); 3:10      $1 min}){}dnl
})dnl
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
dnl ( x2 x1 -- x )
dnl x = x2 * x1
define({MUL},{
ifdef({USE_MUL},,define({USE_MUL},{}))dnl
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 / x1
define({DIV},{
ifdef({USE_DIV},,define({USE_DIV},{}))dnl
    call DIVIDE         ; 3:17      /
    pop  DE             ; 1:10      /})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 % x1
define({MOD},{
ifdef({USE_DIV},,define({USE_DIV},{}))dnl
    call DIVIDE         ; 3:17      mod
    ex   DE, HL         ; 1:4       mod
    pop  DE             ; 1:10      mod})dnl
dnl
dnl
dnl ( x2 x1 -- r q )
dnl x = x2 u% x1
define({DIVMOD},{
ifdef({USE_DIV},,define({USE_DIV},{}))dnl
    call DIVIDE         ; 3:17      /mod})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 u/ x1
define({UDIV},{
ifdef({USE_UDIV},,define({USE_UDIV},{}))dnl
    call UDIVIDE        ; 3:17      u/
    pop  DE             ; 1:10      u/})dnl
dnl
dnl
include(M4PATH{}divmul/pdiv_mk1.m4){}dnl
dnl
dnl ( x2 x1 -- x )
dnl x = x2 u% x1
define({UMOD},{
ifdef({USE_UDIV},,define({USE_UDIV},{}))dnl
    call UDIVIDE        ; 3:17      umod
    ex   DE, HL         ; 1:4       umod
    pop  DE             ; 1:10      umod})dnl
dnl
dnl
dnl ( x2 x1 -- r q )
dnl x = x2 u% x1
define({UDIVMOD},{
ifdef({USE_UDIV},,define({USE_UDIV},{}))dnl
    call UDIVIDE        ; 3:17      u/mod})dnl
dnl
dnl
dnl "1+"
dnl ( x1 -- x )
dnl x = x1 + 1
define({_1ADD},{
    inc  HL             ; 1:6       1+})dnl
dnl
dnl
dnl "1-"
dnl ( x1 -- x )
dnl x = x1 - 1
define({_1SUB},{
    dec  HL             ; 1:6       1-})dnl
dnl
dnl
dnl "2+"
dnl ( x1 -- x )
dnl x = x1 + 2
define({_2ADD},{
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+})dnl
dnl
dnl
dnl "2-"
dnl ( x1 -- x )
dnl x = x1 - 2
define({_2SUB},{
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-})dnl
dnl
dnl
dnl "swap 1+ swap"
dnl ( x2 x1 -- x2+1 x1 )
define({SWAP_1ADD_SWAP},{
    inc  DE             ; 1:6       swap 1+ swap})dnl
dnl
dnl
dnl "swap 1- swap"
dnl ( x2 x1 -- x2-1 x1 )
define({SWAP_1SUB_SWAP},{
    dec  DE             ; 1:6       swap 1- swap})dnl
dnl
dnl
dnl "swap 2+ swap"
dnl ( x2 x1 -- x2+2 x1 )
define({SWAP_2ADD_SWAP},{
    inc  DE             ; 1:6       swap 2+ swap
    inc  DE             ; 1:6       swap 2+ swap})dnl
dnl
dnl
dnl "swap 2- swap"
dnl ( x2 x1 -- x2-2 x1 )
define({SWAP_2SUB_SWAP},{
    dec  DE             ; 1:6       swap 2- swap
    dec  DE             ; 1:6       swap 2- swap})dnl
dnl
dnl
dnl "2*"
dnl ( x1 -- x )
dnl x = x1 * 2
define({_2MUL},{
    add  HL, HL         ; 1:11      2*})dnl
dnl
dnl
dnl "2/"
dnl ( x1 -- x )
dnl x = x1 / 2
define({_2DIV},{
    sra   H             ; 2:8       2/   with sign
    rr    L             ; 2:8       2/})dnl
dnl
dnl
dnl "256 *"
dnl ( x1 -- x )
dnl x = x1 * 256
define({_256MUL},{
    ld    H, L          ; 1:4       256*
    ld    L, 0x00       ; 2:7       256*})dnl
dnl
dnl
dnl "256 /"
dnl ( x1 -- x )
dnl x = x1 / 256
define({_256DIV},{
    ld    L, H          ; 1:4       256/   with sign
    rl    H             ; 2:8       256/
    sbc   A, A          ; 1:4       256/
    ld    H, A          ; 1:4       256/})dnl
dnl
dnl
dnl
define({PRINT_NIBBLE},{ifelse(eval(TEMP_BIN),{0},{define({TEMP_BIN_OUT},{_0000}TEMP_BIN_OUT)},{dnl
__{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
__{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
__{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
__{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
__{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
__{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
__{}define({TEMP_BIN_OUT},{_}eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
__{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
__{}ifelse(eval(TEMP_BIN),{0},,{PRINT_NIBBLE}){}dnl
})})dnl
dnl
dnl
dnl
define({PRINT_BINARY},{dnl
__{}define({TEMP_BIN},eval(($1) & 0xffff)){}dnl
__{}define({TEMP_BIN_OUT},{}){}dnl
__{}PRINT_NIBBLE{}dnl
__{}b{}TEMP_BIN_OUT{}dnl
})dnl
dnl
dnl
dnl
define({SUM_1BITS},{define({TEMP},eval((($1) & 0x5555) + (($1) & 0xAAAA)/2)){}dnl
__{}define({TEMP},eval((TEMP & 0x3333) + (TEMP & 0xCCCC)/4)){}dnl
__{}define({TEMP},eval((TEMP & 0x0F0F) + (TEMP & 0xF0F0)/16)){}dnl
__{}eval((TEMP & 0x00FF) + (TEMP & 0xFF00)/256)})dnl
dnl
dnl
dnl
define({SUM_0BITS},{define({INV_BITS},eval(($1) | (($1) >> 1)))dnl
__{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 2)))dnl
__{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 4)))dnl
__{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 8)))dnl
__{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 16)))dnl
__{}define({INV_BITS},eval(INV_BITS-($1)))dnl
__{}SUM_1BITS(eval(INV_BITS))})dnl
dnl
dnl
dnl
define({_ADD_OUTPUT},{dnl
__{}ifdef({_OUTPUT},{define({_OUTPUT},_OUTPUT{}$1)},{define({_OUTPUT},$1)}){}dnl
})dnl
dnl
dnl
dnl
define({_PUSH_OUTPUT},{dnl
__{}ifdef({_OUTPUT},{define({_OUTPUT},$1{}_OUTPUT)},{define({_OUTPUT},$1)}){}dnl
})dnl
dnl
dnl
dnl
define({HI_BIT_LOOP},{ifelse(eval(($1)>0),{1},{dnl
__{}define({HI_BIT_TEMP},eval(HI_BIT_TEMP|($1)))dnl
__{}HI_BIT_LOOP(eval(($1)/2))dnl
})})dnl
dnl
dnl
dnl
define({HI_BIT},{dnl
__{}define({HI_BIT_TEMP},{0})dnl
__{}HI_BIT_LOOP(eval($1))dnl
__{}eval((HI_BIT_TEMP+1)/2)dnl
})dnl
dnl
dnl
dnl
define({_ADD_COST},{dnl
__{}ifdef({_COST},{define({_COST},eval(_COST+($1)))},{define({_COST},eval($1))}){}dnl
dnl (eval(_COST&255):eval(_COST/256))dnl
})dnl
dnl
dnl
define({PUSH_MUL_INFO_MINUS},{dnl
__{}define({XMUL_INFO_TEMP},{[eval($1 & 0xff):eval($1/256)]})dnl
                        ;format({%-9s},XMUL_INFO_TEMP)  $2 *   $3 = HL * (PRINT_BINARY($4) - PRINT_BINARY($5)){}dnl
})dnl
dnl
dnl
define({PUSH_MUL_INFO_PLUS},{dnl
__{}define({XMUL_INFO_TEMP},{[eval($1 & 0xff):eval($1/256)]})dnl
                        ;format({%-9s},XMUL_INFO_TEMP)  $2 *   $3 = HL * (PRINT_BINARY($2)){}dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_CHECK_FIRST_IS_BETTER},{dnl
__{}eval((($1 & 0xff) < ($2 & 0xff)) || ((($1 & 0xff) == ($2 & 0xff)) && ($1 < $2))){}dnl
__{}})dnl
dnl
dnl
dnl
include(M4PATH{}divmul/pmul_mk1.m4){}dnl
include(M4PATH{}divmul/pmul_mk2.m4){}dnl
include(M4PATH{}divmul/pmul_mk3.m4){}dnl
include(M4PATH{}divmul/pmul_mk4.m4){}dnl
dnl
dnl
dnl
define({PUSH_MUL},{dnl
__{}PUSH_MUL_MK1($1){}dnl
__{}define({_BEST_OUT},{PUSH_MUL_MK1_OUT}){}dnl
__{}define({_BEST_COST},PUSH_MUL_MK1_COST){}dnl
__{}define({_BEST_INFO},{PUSH_MUL_MK1_INFO}){}dnl
__{}PUSH_MUL_MK2($1){}dnl
__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK2_COST,_BEST_COST),{1},{dnl
__{}__{}define({_BEST_OUT},{PUSH_MUL_MK2_OUT}){}dnl
__{}__{}define({_BEST_COST},PUSH_MUL_MK2_COST){}dnl
__{}__{}define({_BEST_INFO},PUSH_MUL_MK2_INFO){}dnl
__{}})dnl
__{}PUSH_MUL_MK3($1){}dnl
__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK3_COST,_BEST_COST),{1},{dnl
__{}__{}define({_BEST_OUT},{PUSH_MUL_MK3_OUT}){}dnl
__{}__{}define({_BEST_COST},PUSH_MUL_MK3_COST){}dnl
__{}__{}define({_BEST_INFO},PUSH_MUL_MK3_INFO){}dnl
__{}})dnl
__{}PUSH_MUL_MK4($1){}dnl
__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK4_COST,_BEST_COST),{1},{dnl
__{}__{}define({_BEST_OUT},{PUSH_MUL_MK4_OUT}){}dnl
__{}__{}define({_BEST_COST},PUSH_MUL_MK4_COST){}dnl
__{}__{}define({_BEST_INFO},PUSH_MUL_MK4_INFO){}dnl
__{}})dnl
__{}_BEST_INFO{}dnl
__{}_BEST_OUT{}dnl
})dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 8bit Arithmetic
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl ( c2 c1 -- c2+c1 )
dnl c = c2 + c1
define({CADD},{
    ld    A, E          ; 1:4       C+   ( c2 c1 -- c2+c1 )
    add   A, L          ; 1:4       C+   ( c2 c1 -- c2+c1 )
    ld    L, A          ; 1:4       C+   ( c2 c1 -- c2+c1 )
    pop  DE             ; 1:10      C+})dnl
dnl
dnl
dnl
dnl 0x8000 C@ C+
dnl ( c1 -- c1+(adr) )
dnl c = c2 + c1
define({PUSH_CFETCH_CADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},{
    ld    A, format({%-11s},{($1)}); 3:13      $1 C@ C+   ( c -- c+($1) )
    add   A, L          ; 1:4       $1 C@ C+
    ld    L, A          ; 1:4       $1 C@ C+},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})})dnl
dnl
dnl
dnl
dnl C@ 0x8000 C@ C+
dnl ( c -- (c)+(adr) )
dnl c = c2 + c1
define({CFETCH_PUSH_CFETCH_CADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},{
    ld    A,format({%-12s},{($1)}); 3:13      C@ $1 C@ C+   ( c -- (c)+($1) )
    add   A,(HL)        ; 1:7       C@ $1 C@ C+
    ld    L, A          ; 1:4       C@ $1 C@ C+},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})})dnl
dnl
dnl
dnl
dnl 0x8000 C@ C+ 0x4000 C!
dnl ( c -- )
define({PUSH_CFETCH_CADD_PUSH_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
__{}$#,{2},{
                        ;[9:47]     $1 C@ C+ $2 C!   ( c --  )
    ld    A,format({%-12s},{($1)}); 3:13      $1 C@ C+ $2 C!
    add   A, L          ; 1:4       $1 C@ C+ $2 C!
    ld  format({%-16s},{($2), A}); 3:13      $1 C@ C+ $2 C!   [$2] = [$1] + low TOS
    ex   DE, HL         ; 1:4       $1 C@ C+ $2 C!
    pop  DE             ; 1:10      $1 C@ C+ $2 C!},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})})dnl
dnl
dnl
dnl
dnl C@ 0x8000 C@ C+ 0x4000 C!
dnl ( c -- )
define({CFETCH_PUSH_CFETCH_CADD_PUSH_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
__{}$#,{2},{
                        ;[9:47]     C@ $1 C@ C+ $2 C!   ( c --  )
    ld    A,format({%-12s},{($1)}); 3:13      C@ $1 C@ C+ $2 C!
    add   A,(HL)        ; 1:7       C@ $1 C@ C+ $2 C!
    ld  format({%-16s},{($2), A}); 3:13      C@ $1 C@ C+ $2 C!   [$2] = [$1] + [TOS]
    ex   DE, HL         ; 1:4       C@ $1 C@ C+ $2 C!
    pop  DE             ; 1:10      C@ $1 C@ C+ $2 C!},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})})dnl
dnl
dnl
dnl ( c -- c+n )
dnl c = c + n
define({PUSH_CADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ; warning {$0}($@): The condition $1 cannot be evaluated
__{}    ld    A, format({%-11s},$1); 3:13     $1 C+
__{}    add   A, L          ; 1:4      $1 C+
__{}    ld    L, A          ; 1:4      $1 C+},
eval($1),{},{dnl
__{}    ; warning {$0}($@): The condition $1 cannot be evaluated
__{}    ld    A, format({%-11s},$1); 2:7      $1 C+
__{}    add   A, L          ; 1:4      $1 C+
__{}    ld    L, A          ; 1:4      $1 C+},
{dnl
__{}ifelse(eval(($1)+3),{0},{dnl
__{}__{}    dec   L             ; 1:4       $1 C+   ( c -- c-2 )
__{}__{}    dec   L             ; 1:4       $1 C+
__{}__{}    dec   L             ; 1:4       $1 C+},
__{}eval(($1)+2),{0},{dnl
__{}__{}    dec   L             ; 1:4       $1 C+   ( c -- c-2 )
__{}__{}    dec   L             ; 1:4       $1 C+},
__{}__{}eval(($1)+1),{0},{dnl
__{}__{}    dec   L             ; 1:4       $1 C+   ( c -- c-1 )},
__{}__{}eval($1),{0},{snl
__{}__{}                        ;           $1 C+   ( c -- c+0 )},
__{}__{}eval(($1)-1),{0},{dnl
__{}__{}    inc   L             ; 1:4       $1 C+   ( c -- c+1 )},
__{}__{}eval(($1)-2),{0},{dnl
__{}__{}    inc   L             ; 1:4       $1 C+   ( c -- c+1 )
__{}__{}    inc   L             ; 1:4       $1 C+},
__{}__{}eval(($1)-3),{0},{dnl
__{}__{}    inc   L             ; 1:4       $1 C+   ( c -- c+1 )
__{}__{}    inc   L             ; 1:4       $1 C+
__{}__{}    inc   L             ; 1:4       $1 C+},
__{}__{}{ifelse(eval((((($1) | 255) + 1) > 256) || (($1 + 256) < 128)),{1},{dnl
__{}__{}__{}    ; warning {$0}($@): Parameter $1 exceeds one byte limit!
__{}__{}__{}})dnl
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 C+   ( d -- d+$1 )
__{}__{}    add   A, L          ; 1:4       $1 C+
__{}__{}    ld    L, A          ; 1:4       $1 C+}){}dnl
})})dnl
dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 16bit & 32bit mix Arithmetic
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl
dnl S>D
dnl ( x1 -- sign(x1) x1 )
define({S_TO_D},{
    push DE             ; 1:11      S>D   ( x -- d ) == ( x -- sign(x) x )
    ld    A, H          ; 1:4       S>D
    add   A, A          ; 1:4       S>D
    sbc   A, A          ; 1:4       S>D
    ld    D, A          ; 1:4       S>D
    ld    E, A          ; 1:4       S>D}){}dnl
dnl
dnl
dnl
dnl D>S
dnl ( 0 x1 -- x1 )
define({D_TO_S},{
    pop  DE             ; 1:10      D>S   ( d -- x ) == ( 0 lo -- lo )}){}dnl
dnl
dnl
dnl
dnl ( hi2 lo2 n1 -- d2+n1 )
define({MADD},{
                        ;[11:57]    M+   ( hi2 lo2 n1 -- d2+n1 )
    ld    A, H          ; 1:4       M+
    add   A, A          ; 1:4       M+
    sbc   A, A          ; 1:4       M+
    add  HL, DE         ; 1:11      M+   lo2+n1
    pop  DE             ; 1:10      M+
    ld    B, A          ; 1:4       M+
    adc   A, E          ; 1:4       M+
    ld    E, A          ; 1:4       M+
    ld    A, B          ; 1:4       M+
    adc   A, D          ; 1:4       M+
    ld    D, A          ; 1:4       M+   h2+n1})dnl
dnl
dnl
dnl
dnl ( d n -- floored_remainder floored_quotient )
define({FMDIVMOD},{define({USE_F32DIV16},{})
    pop  BC             ; 1:10      {FM/MOD}   ( d n -- floored_remainder floored_quotient )
    call F32DIV16       ; 3:17      {FM/MOD}}){}dnl
dnl
dnl
dnl
dnl ( d n -- symmetric_remander symmetric_quotient )
define({SMDIVREM},{define({USE_S32DIV16},{})
    pop  BC             ; 1:10      {SM/REM}   ( d n -- symmetric_remander symmetric_quotient )
    call S32DIV16       ; 3:17      {SM/REM}}){}dnl
dnl
dnl
dnl
dnl ( ud u -- remainder quotient )
define({UMDIVMOD},{define({USE_U32DIV16},{})
    pop  BC             ; 1:10      {UM/MOD}   ( ud u -- remainder quotient )
    call U32DIV16       ; 3:17      {UM/MOD}}){}dnl
dnl
dnl
dnl
dnl ( x1 x2 -- d )
define({MMUL},{define({USE_S16MUL},{})
    call S16MUL         ; 3:17      M*   ( x1 x2 -- d )}){}dnl
dnl
dnl
dnl
dnl ( u1 u2 -- ud )
define({UMMUL},{define({USE_U16MUL},{})
    call U16MUL         ; 3:17      UM*   ( u1 u2 -- ud )}){}dnl
dnl
dnl
dnl
dnl ( n1 n2 n3 -- n1*n2%n3 n1*n2/n3 )
define({MULDIVMOD},{define({USE_U16MUL},{})
    ex  (SP),HL         ; 1:19      {*/MOD}   ( n1 n2 n3 -- n1*n2%n3 n1*n2/n3 )
    call S16MUL         ; 3:17      {*/MOD}
    ex   DE, HL         ; 1:4       {*/MOD}
    ex  (SP),HL         ; 1:19      {*/MOD}
    call S32DIV16       ; 3:17      {*/MOD}}){}dnl
dnl
dnl
dnl
dnl ( n1 n2 n3 -- n1*n2/n3 )
define({MULDIV},{define({USE_U16MUL},{})
    ex  (SP),HL         ; 1:19      {*/}   ( n1 n2 n3 -- n1*n2/n3 )
    call S16MUL         ; 3:17      {*/}
    ex   DE, HL         ; 1:4       {*/}
    ex  (SP),HL         ; 1:19      {*/}
    call S32DIV16       ; 3:17      {*/}
    pop  DE             ; 1:10      {*/}}){}dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 32bit Arithmetic ( DE = hi, HL = lo )
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl
dnl ( hi2 lo2 hi1 lo1 -- d2+d1 )
dnl d = d2 + d1
define({DADD},{
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+})dnl
dnl
dnl
dnl ( d -- d+n )
dnl d = d + n
define({PUSHDOT_DADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ; warning {$0}($@): The condition $1 cannot be evaluated
__{}    ld   BC, format({%-11s},$1); 4:20      $1 D+
__{}    add  HL, BC         ; 1:11      $1 D+
__{}    ex   DE, HL         ; 1:4       $1 D+
__{}    ld   BC,format({%-12s},($1+2)); 4:20      $1 D+
__{}    adc  HL, BC         ; 2:15      $1 D+
__{}    ex   DE, HL         ; 1:4       $1 D+},
eval($1),{},{dnl
__{}    .error {$0}($@): The condition $1 cannot be evaluated},
{ifelse(dnl
__{}__{}eval(($1)+3*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       $1 D+   ( d -- d-3*2^24 )
__{}__{}    dec   D             ; 1:4       $1 D+
__{}__{}    dec   D             ; 1:4       $1 D+},
__{}__{}eval(($1)+2*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       $1 D+   ( d -- d-2^25 )
__{}__{}    dec   D             ; 1:4       $1 D+},
__{}__{}eval(($1)+1*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       $1 D+   ( d -- d-2^24 )},
__{}__{}eval(($1)+5*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D+   ( d -- d-5*2^16 )
__{}__{}    dec  DE             ; 1:6       $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+},
__{}__{}eval(($1)+4*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D+   ( d -- d-2^18 )
__{}__{}    dec  DE             ; 1:6       $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+},
__{}__{}eval(($1)+3*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D+   ( d -- d-3*2^16 )
__{}__{}    dec  DE             ; 1:6       $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+},
__{}__{}eval(($1)+2*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D+   ( d -- d-2^17 )
__{}__{}    dec  DE             ; 1:6       $1 D+},
__{}__{}eval(($1)+1*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D+   ( d -- d-2^16 )},
__{}__{}eval(($1)+2*256),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       $1 D+   ( d -- d-2^9 )
__{}__{}    dec   H             ; 1:4       $1 D+
__{}__{}    dec   H             ; 1:4       $1 D+
__{}__{}    sub   H             ; 1:4       $1 D+
__{}__{}    jr   nc, $+3        ; 2:7/12    $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+   hi--},
__{}__{}eval(($1)+1*256),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       $1 D+   ( d -- d-2^8 )
__{}__{}    dec   H             ; 1:4       $1 D+
__{}__{}    sub   H             ; 1:4       $1 D+
__{}__{}    jr   nc, $+3        ; 2:7/12    $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+   hi--},
__{}__{}eval(((($1) & 0xFFFF0000) == 0xFFFF0000) && ((($1) & 0xFF) == 0)),{1},{dnl
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       $1 D+   ( d -- d+$1 )
__{}__{}    add   A, H          ; 1:4       $1 D+
__{}__{}    ld    H, A          ; 1:4       $1 D+
__{}__{}    jr    c, $+3        ; 2:7/12    $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+   hi--},
__{}__{}eval(($1)+2),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       $1 D+   ( d -- d-2 )
__{}__{}    dec  HL             ; 1:6       $1 D+   lo--
__{}__{}    dec  HL             ; 1:6       $1 D+   lo--
__{}__{}    sub   H             ; 1:4       $1 D+   lo(d)-lo(d-2)
__{}__{}    jr   nc, $+3        ; 2:7/12    $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+   hi--},
__{}__{}eval(($1)+1),{0},{dnl
__{}__{}    ld    A, L          ; 1:4       $1 D+   ( d -- d-1 )
__{}__{}    or    H             ; 1:4       $1 D+
__{}__{}    dec  HL             ; 1:6       $1 D+   lo--
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+   hi--},
__{}__{}eval($1),{0},{snl
__{}__{}                        ;           $1 D+   ( d -- d+0 )},
__{}__{}eval(($1)-1),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 D+   lo++
__{}__{}    ld    A, L          ; 1:4       $1 D+
__{}__{}    or    H             ; 1:4       $1 D+
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+   hi++},
__{}__{}eval(($1)-256),{0},{dnl
__{}__{}    inc   H             ; 1:4       $1 D+   ( d -- d+256 )
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+   hi++},
__{}__{}eval(($1) & 0xFFFF00FF),{0},{dnl
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       $1 D+   ( d -- d+$1 )
__{}__{}    add   A, H          ; 1:4       $1 D+
__{}__{}    ld    H, A          ; 1:4       $1 D+
__{}__{}    jr   nc, $+3        ; 2:7/12    $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+   hi++},
__{}__{}eval(($1)-1*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D+   ( d -- d+2^16 )},
__{}__{}eval(($1)-2*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D+   ( d -- d+2^17 )
__{}__{}    inc  DE             ; 1:6       $1 D+},
__{}__{}eval(($1)-3*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D+   ( d -- d+3*2^16 )
__{}__{}    inc  DE             ; 1:6       $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+},
__{}__{}eval(($1)-4*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D+   ( d -- d+2^18 )
__{}__{}    inc  DE             ; 1:6       $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+},
__{}__{}eval(($1)-5*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D+   ( d -- d+5*2^16 )
__{}__{}    inc  DE             ; 1:6       $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+},
__{}__{}eval(($1)-1*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       $1 D+   ( d -- d+2^24 )},
__{}__{}eval(($1)-2*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       $1 D+   ( d -- d+2^25 )
__{}__{}    inc   D             ; 1:4       $1 D+},
__{}__{}eval(($1)-3*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       $1 D+   ( d -- d+3*2^24 )
__{}__{}    inc   D             ; 1:4       $1 D+
__{}__{}    inc   D             ; 1:4       $1 D+},
__{}__{}eval(($1) & 0xFFFFFF),{0},{dnl
__{}__{}    ld    A, __HEX_D($1)       ; 2:7       $1 D+   ( d -- d+$1 )
__{}__{}    add   A, D          ; 1:4       $1 D+
__{}__{}    ld    D, A          ; 1:4       $1 D+},
__{}__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}    ld   BC, __HEX_DE($1)     ; 3:10      $1 D+
__{}__{}    ex   DE, HL         ; 1:4       $1 D+
__{}__{}    add  HL, BC         ; 1:11      $1 D+
__{}__{}    ex   DE, HL         ; 1:4       $1 D+},
__{}__{}eval(($1) & 0xFFFF0000),{0},{dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      $1 D+   ( d -- d+$1 )
__{}__{}    add  HL, BC         ; 1:11      $1 D+
__{}__{}    jr   nc, $+3        ; 2:7/12    $1 D+
__{}__{}    inc  DE             ; 1:6       $1 D+   hi++},
__{}__{}eval((($1) & 0xFFFF0000) - 0xFFFF0000),{0},{dnl
__{}__{}    ld   BC, format({%-11s},eval(($1) & 0xFFFF)); 3:10      $1 D+   ( d -- d{}$1 )
__{}__{}    add  HL, BC         ; 1:11      $1 D+
__{}__{}    jr    c, $+3        ; 2:7/12    $1 D+
__{}__{}    dec  DE             ; 1:6       $1 D+   hi--},
__{}__{}{dnl
__{}__{}    ld   BC, format({%-11s},eval(($1) & 0xFFFF)); 3:10      $1 D+
__{}__{}    add  HL, BC         ; 1:11      $1 D+
__{}__{}    ex   DE, HL         ; 1:4       $1 D+
__{}__{}    ld   BC, format({%-11s},eval((($1) & 0xFFFF0000)/65536)); 3:10      $1 D+
__{}__{}    adc  HL, BC         ; 2:15      $1 D+
__{}__{}    ex   DE, HL         ; 1:4       $1 D+}){}dnl
})})dnl
dnl
dnl
dnl "2dup D+"
dnl ( hi1 lo1 -- d1 d1+d1 )
dnl d0 = d1 + d1
define({_2DUP_DADD},{
    push  DE            ; 1:11      2dup D+   ( hi1 lo1 -- hi1 lo1 hi1+hi1+carry lo1+lo1 )
    push  HL            ; 1:11      2dup D+
    add  HL, HL         ; 1:11      2dup D+
    ex   DE, HL         ; 1:4       2dup D+
    adc  HL, HL         ; 2:15      2dup D+
    ex   DE, HL         ; 1:4       2dup D+})dnl
dnl
dnl
dnl 2swap D+
dnl ( d2 d1 -- d1+d2 )
dnl ( hi2 lo2 hi1 lo1 -- hi1+hi2+carry lo1+lo2 )
define({_2SWAP_DADD},{
                        ;[7:54]     2swap D+   ( hi2 lo2 hi1 lo1 -- hi1+hi2+carry lo1+lo2 )
    pop  BC             ; 1:10      2swap D+   lo2
    add  HL, BC         ; 1:11      2swap D+
    ex   DE, HL         ; 1:4       2swap D+
    pop  BC             ; 1:10      2swap D+   hi2
    adc  HL, BC         ; 2:15      2swap D+
    ex   DE, HL         ; 1:4       2swap D+})dnl
dnl
dnl
dnl 2over D+
dnl ( d2 d1 -- d2 d1+d2 )
dnl ( hi2 lo2 hi1 lo1 -- hi2 lo2 hi1+hi2+carry lo1+lo2 )
define({_2OVER_DADD},{
                        ;[9:93]     2over D+   ( hi2 lo2 hi1 lo1 -- hi2 lo2 hi1+hi2+carry lo1+lo2 )
    pop  BC             ; 1:10      2over D+   lo2
    add  HL, BC         ; 1:11      2over D+
    ex  (SP),HL         ; 1:19      2over D+   hi2
    ex   DE, HL         ; 1:4       2over D+
    adc  HL, DE         ; 2:15      2over D+
    ex   DE, HL         ; 1:4       2over D+
    ex  (SP),HL         ; 1:19      2over D+
    push BC             ; 1:11      2over D+})dnl
dnl
dnl
dnl ( d2 d1 -- d )
dnl d = d2 - d1
define({DSUB},{ifelse(TYP_DSUB,{small},{
                       ;[12:74]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    ld    B, D          ; 1:4       D-
    ld    C, E          ; 1:4       D-
    ex   DE, HL         ; 1:4       D-   DE = lo1
    pop  HL             ; 1:10      D-   HL = lo2
    or    A             ; 1:4       D-
    sbc  HL, DE         ; 2:15      D-   lo2-lo1
    ex   DE, HL         ; 1:4       D-
    pop  HL             ; 1:10      D-   HL = hi2
    sbc  HL, BC         ; 2:15      D-   hi2-hi1
    ex   DE, HL         ; 1:4       D-}
,{
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D-})})dnl
dnl
dnl
dnl 2swap D-
dnl ( d2 d1 -- d1-d2 )
define({_2SWAP_DSUB},{
                        ;[9:62]     2swap D-   ( hi2 lo2 hi1 lo1 -- hi1-hi2-carry lo1-lo2 )
    or    A             ; 1:4       2swap D-
    pop  BC             ; 1:10      2swap D-   lo2
    sbc  HL, BC         ; 2:15      2swap D-
    ex   DE, HL         ; 1:4       2swap D-
    pop  BC             ; 1:10      2swap D-   hi2
    sbc  HL, BC         ; 2:15      2swap D-
    ex   DE, HL         ; 1:4       2swap D-})dnl
dnl
dnl
dnl 2over D-
dnl ( d2 d1 -- d2 d1-d2 )
define({_2OVER_DSUB},{
                        ;[11:101]   2over D-   ( hi2 lo2 hi1 lo1 -- hi2 lo2 hi1-hi2-carry lo2-lo1 )
    pop  BC             ; 1:10      2over D-   lo2
    or    A             ; 1:4       2over D-
    sbc  HL, BC         ; 2:15      2over D-
    ex  (SP),HL         ; 1:19      2over D-   hi2
    ex   DE, HL         ; 1:4       2over D-
    sbc  HL, DE         ; 2:15      2over D-
    ex   DE, HL         ; 1:4       2over D-
    ex  (SP),HL         ; 1:19      2over D-
    push BC             ; 1:11      2over D-})dnl
dnl
dnl
dnl ( d -- d-n )
dnl d = d - n
define({PUSHDOT_DSUB},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ; warning {$0}($@): The condition $1 cannot be evaluated
__{}    ld   BC, format({%-11s},$1); 4:20      $1 D-
__{}    or    A, A          ; 1:4       $1 D-
__{}    sbc  HL, BC         ; 2:15      $1 D-
__{}    ex   DE, HL         ; 1:4       $1 D-
__{}    ld   BC,format({%-12s},($1+2)); 4:20      $1 D-
__{}    sbc  HL, BC         ; 2:15      $1 D-
__{}    ex   DE, HL         ; 1:4       $1 D-},
eval($1),{},{dnl
__{}    .error {$0}($@): The condition $1 cannot be evaluated},
{ifelse(dnl
__{}__{}eval(($1)+3*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       $1 D-   ( d -- d+3*2^24 )
__{}__{}    inc   D             ; 1:4       $1 D-
__{}__{}    inc   D             ; 1:4       $1 D-},
__{}__{}eval(($1)+2*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       $1 D-   ( d -- d+2^25 )
__{}__{}    inc   D             ; 1:4       $1 D-},
__{}__{}eval(($1)+1*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       $1 D-   ( d -- d+2^24 )},
__{}__{}eval(($1)+5*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D-   ( d -- d+5*2^16 )
__{}__{}    inc  DE             ; 1:6       $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-},
__{}__{}eval(($1)+4*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D-   ( d -- d+2^18 )
__{}__{}    inc  DE             ; 1:6       $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-},
__{}__{}eval(($1)+3*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D-   ( d -- d+3*2^16 )
__{}__{}    inc  DE             ; 1:6       $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-},
__{}__{}eval(($1)+2*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D-   ( d -- d+2^17 )
__{}__{}    inc  DE             ; 1:6       $1 D-},
__{}__{}eval(($1)+1*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       $1 D-   ( d -- d+2^16 )},
__{}__{}eval(($1)+256),{0},{dnl
__{}__{}    inc   H             ; 1:4       $1 D-   ( d -- d+2^8 )
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-   hi++},
__{}__{}eval(($1)+1),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 D-   ( d -- d+1 )
__{}__{}    ld    A, L          ; 1:4       $1 D-
__{}__{}    or    H             ; 1:4       $1 D-
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-   hi++},
__{}__{}eval($1),{0},{snl
__{}__{}                        ;           $1 D-   ( d -- d+0 )},
__{}__{}eval(($1)-1),{0},{dnl
__{}__{}    ld    A, L          ; 1:4       $1 D-   ( d -- d-1 )
__{}__{}    or    H             ; 1:4       $1 D-
__{}__{}    dec  HL             ; 1:6       $1 D-   lo--
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-   hi--},
__{}__{}eval(($1)-2),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       $1 D-   ( d -- d-2 )
__{}__{}    dec  HL             ; 1:6       $1 D-   lo--
__{}__{}    dec  HL             ; 1:6       $1 D-   lo--
__{}__{}    sub   H             ; 1:4       $1 D-   lo(d)-lo(d-2)
__{}__{}    jr   nc, $+3        ; 2:7/12    $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-   hi--},
__{}__{}eval(($1)-256),{0},{dnl
__{}__{}    inc   H             ; 1:4       $1 D-   ( d -- d-2^8 )
__{}__{}    dec   H             ; 1:4       $1 D-
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-   hi--
__{}__{}    dec   H             ; 1:4       $1 D-},
__{}__{}eval(($1) & 0xFFFF00FF),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       $1 D-   ( d -- d-$1 )
__{}__{}    sub  __HEX_H($1)           ; 2:7       $1 D-
__{}__{}    ld    H, A          ; 1:4       $1 D-
__{}__{}    jr   nc, $+3        ; 2:7/12    $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-   hi--},
__{}__{}eval(($1)-1*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D-   ( d -- d-2^16 )},
__{}__{}eval(($1)-2*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D-   ( d -- d-2^17 )
__{}__{}    dec  DE             ; 1:6       $1 D-},
__{}__{}eval(($1)-3*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D-   ( d -- d-3*2^16 )
__{}__{}    dec  DE             ; 1:6       $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-},
__{}__{}eval(($1)-4*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D-   ( d -- d-2^18 )
__{}__{}    dec  DE             ; 1:6       $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-},
__{}__{}eval(($1)-5*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       $1 D-   ( d -- d-5*2^16 )
__{}__{}    dec  DE             ; 1:6       $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-},
__{}__{}eval(($1)-1*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       $1 D-   ( d -- d-2^24 )},
__{}__{}eval(($1)-2*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       $1 D-   ( d -- d-2^25 )
__{}__{}    dec   D             ; 1:4       $1 D-},
__{}__{}eval(($1)-3*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       $1 D-   ( d -- d-3*2^24 )
__{}__{}    dec   D             ; 1:4       $1 D-
__{}__{}    dec   D             ; 1:4       $1 D-},
__{}__{}eval(($1) & 0xFFFFFF),{0},{dnl
__{}__{}    ld    A, D          ; 1:4       $1 D-   ( d -- d-($1) )
__{}__{}    sub  __HEX_D($1)           ; 2:7       $1 D-   ( d -- d-($1) )
__{}__{}    ld    D, A          ; 1:4       $1 D-},
__{}__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}    ld   BC, format({0x%04X},eval(0x10000-(($1)>>16) & 0xFFFF))     ; 3:10      $1 D-   ( d -- d-($1) )
__{}__{}    ex   DE, HL         ; 1:4       $1 D-
__{}__{}    add  HL, BC         ; 1:11      $1 D-
__{}__{}    ex   DE, HL         ; 1:4       $1 D-},
__{}__{}eval(-($1) & 0xFFFF0000),{0},{dnl
__{}__{}    ld   BC, format({%-11s},eval(-($1) & 0xFFFF)); 3:10      $1 D-   ( d -- d-($1) )
__{}__{}    add  HL, BC         ; 1:11      $1 D-
__{}__{}    jr   nc, $+3        ; 2:7/12    $1 D-
__{}__{}    inc  DE             ; 1:6       $1 D-   hi++},
__{}__{}eval((-($1) & 0xFFFF0000) - 0xFFFF0000),{0},{dnl
__{}__{}    ld   BC, format({%-11s},eval(-($1) & 0xFFFF)); 3:10      $1 D-   ( d -- d-($1) )
__{}__{}    add  HL, BC         ; 1:11      $1 D-
__{}__{}    jr    c, $+3        ; 2:7/12    $1 D-
__{}__{}    dec  DE             ; 1:6       $1 D-   hi--},
__{}__{}{dnl
__{}__{}    ld   BC, format({%-11s},eval(-($1) & 0xFFFF)); 3:10      $1 D-
__{}__{}    add  HL, BC         ; 1:11      $1 D-
__{}__{}    ex   DE, HL         ; 1:4       $1 D-
__{}__{}    ld   BC, format({%-11s},eval(((-($1) & 0xFFFF0000)/65536) & 0xFFFF)); 3:10      $1 D-
__{}__{}    adc  HL, BC         ; 2:15      $1 D-
__{}__{}    ex   DE, HL         ; 1:4       $1 D-}){}dnl
})})dnl
dnl
dnl
dnl
dnl ( d -- ud )
dnl ( hi lo -- uhi ulo )
dnl ud is absolute value of d
define({DABS},{define({USE_DNEGATE},{})
    ld    A, D          ; 1:4       dabs
    add   A, A          ; 1:4       dabs
    call  c, NEGATE_32  ; 3:17      dabs})dnl
dnl
dnl
dnl ( 5 3 -- 5 )
dnl ( -5 -3 -- -3 )
dnl ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
define({DMAX},{define({USE_DMAX},{})
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax})dnl
dnl
dnl
dnl
dnl ( 5 3 -- 5 )
dnl ( -5 -3 -- -3 )
define({PUSHDOT_DMAX},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}                        ;[27:94/118]$1 dmax
__{}    ld   BC, format({%-11s},$1); 4:20      $1 dmax
__{}    ld    A, L          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sub   C             ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, H          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, B          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld   BC, format({%-11s},($1+2)); 4:20      $1 dmax
__{}    ld    A, E          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, C          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, D          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, B          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    rra                 ; 1:4       $1 dmax   carry --> sign
__{}    xor   D             ; 1:4       $1 dmax
__{}    xor   B             ; 1:4       $1 dmax
__{}    jp    p, $+8        ; 3:10      $1 dmax
__{}    ld    D, B          ; 1:4       $1 dmax
__{}    ld    E, C          ; 1:4       $1 dmax
__{}    ld   HL, format({%-11s},$1); 3:16      $1 dmax},
eval($1),{},{dnl
    .error {$0}($@): M4 does not know $1 parameter value!},
{
__{}                        ;[23:62/82] $1 dmax
__{}    ld    A, L          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sub   __HEX_L($1)          ; 2:7       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, H          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, __HEX_H($1)       ; 2:7       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, E          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, __HEX_E($1)       ; 2:7       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, D          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, __HEX_D($1)       ; 2:7       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    rra                 ; 1:4       $1 dmax   carry --> sign
__{}    xor   D             ; 1:4       $1 dmax
__{}ifelse(eval(($1)<0),{1},{dnl
__{}__{}    jp    m, $+9        ; 3:10      $1 dmax   negative constant __HEX_DEHL($1)},
__{}{dnl
__{}__{}    jp    p, $+9        ; 3:10      $1 dmax   positive constant __HEX_DEHL($1)})
__{}    ld   HL, __HEX_HL($1)     ; 3:10      $1 dmax
__{}    ld   DE, __HEX_DE($1)     ; 3:10      $1 dmax}){}dnl
})dnl
dnl
dnl
dnl ( 5 3 -- 3 )
dnl ( -5 -3 -- -5 )
dnl ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
define({DMIN},{define({USE_DMIN},{})
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin})dnl
dnl
dnl
dnl ( 5 3 -- 3 )
dnl ( -5 -3 -- -5 )
define({PUSHDOT_DMIN},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}                        ;[27:94/118]$1 dmin
__{}    ld   BC, format({%-11s},$1); 4:20      $1 dmin
__{}    ld    A, C          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sub   L             ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, B          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, H          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld   BC, format({%-11s},($1+2)); 4:20      $1 dmin
__{}    ld    A, C          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, E          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, B          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, D          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    rra                 ; 1:4       $1 dmin
__{}    xor   D             ; 1:4       $1 dmin
__{}    xor   B             ; 1:4       $1 dmin
__{}    jp    p, $+8        ; 3:10      $1 dmin
__{}    ld    D, B          ; 1:4       $1 dmin
__{}    ld    E, C          ; 1:4       $1 dmin
__{}    ld   HL, format({%-11s},$1); 3:16      $1 dmin},
eval($1),{},{dnl
    .error {$0}($@): M4 does not know $1 parameter value!},
{dnl
__{}                        ;[23:62/82] $1 dmin
__{}    ld    A, __HEX_L($1)       ; 2:7       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sub   L             ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, __HEX_H($1)       ; 2:7       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, H          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, __HEX_E($1)       ; 2:7       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, E          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, __HEX_D($1)       ; 2:7       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, D          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    rra                 ; 1:4       $1 dmin
__{}    xor   D             ; 1:4       $1 dmin
__{}ifelse(eval(($1)<0),{1},{dnl
__{}__{}    jp    m, $+9        ; 3:10      $1 dmin   negative constant __HEX_DEHL($1)},
__{}{dnl
__{}__{}    jp    p, $+9        ; 3:10      $1 dmin   positive constant __HEX_DEHL($1)})
__{}    ld   HL, __HEX_HL($1)     ; 3:10      $1 dmin
__{}    ld   DE, __HEX_DE($1)     ; 3:10      $1 dmin}){}dnl
})dnl
dnl
dnl
dnl ( d -- -d )
define({DNEGATE},{define({USE_DNEGATE},{})
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate})dnl
dnl
dnl
dnl "D1+"
dnl ( d -- d+1 )
define({D1ADD},{
    inc  HL             ; 1:6       D1+   lo word
    ld    A, L          ; 1:4       D1+
    or    H             ; 1:4       D1+
    jr   nz, $+3        ; 2:7/12    D1+
    inc  DE             ; 1:6       D1+   hi word})dnl
dnl
dnl
dnl "D1-"
dnl ( d -- d-1 )
define({D1SUB},{
    ld    A, L          ; 1:4       D1-   ( d -- d-1 )
    or    H             ; 1:4       D1-
    dec  HL             ; 1:6       D1-   lo word
    jr   nz, $+3        ; 2:7/12    D1-
    dec  DE             ; 1:6       D1-   hi word})dnl
dnl
dnl
dnl "D2+"
dnl ( d -- d+2 )
define({D2ADD},{
    ld   BC, 0x0002     ; 3:10      D2+   ( d -- d+2 )
    add  HL, BC         ; 1:11      D2+   lo word
    jr   nc, $+3        ; 2:7/12    D2+
    inc  DE             ; 1:6       D2+   hi word})dnl
dnl
dnl
dnl "D2-"
dnl ( d -- d-2 )
define({D2SUB},{
    ld    A, H          ; 1:4       D2-   ( d -- d-2 )
    dec  HL             ; 1:6       D2-   lo word
    dec  HL             ; 1:6       D2-   lo word
    sub   H             ; 1:4       D2-
    jr   nc, $+3        ; 2:7/12    D2-
    dec  DE             ; 1:6       D2-   hi word})dnl
dnl
dnl
dnl "D2*"
dnl ( d -- d*2 )
define({D2MUL},{
    add  HL, HL         ; 1:11      D2*   lo word
    rl    E             ; 2:8       D2*
    rl    D             ; 2:8       D2*   hi word})dnl
dnl
dnl
dnl "D2/"
dnl ( d -- d/2 )
define({D2DIV},{
    sra   D             ; 2:8       D2/   with sign
    rr    E             ; 2:8       D2/
    rr    H             ; 2:8       D2/
    rr    L             ; 2:8       D2/})dnl
dnl
dnl
dnl "D256*"
dnl ( d -- d*256 )
define({D256MUL},{
    ld    D, E          ; 1:4       D256*
    ld    E, H          ; 1:4       D256*
    ld    H, L          ; 1:4       D256*
    ld    L, 0x00       ; 2:7       D256*})dnl
dnl
dnl
dnl "D256/"
dnl ( d -- d/256 )
define({D256DIV},{
    ld    L, H          ; 1:4       D256/
    ld    H, E          ; 1:4       D256/
    ld    E, D          ; 1:4       D256/
    rl    D             ; 2:8       D256/   with sign
    sbc   A, A          ; 1:4       D256/
    ld    D, A          ; 1:4       D256/})dnl
dnl
dnl
dnl

dnl ## Arithmetic
define({___},{})dnl
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
__{}    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      $1 +
__{}    add  HL, BC         ; 1:11      $1 +},{ifelse(
__{}eval(($1)+3),{0},{
__{}    dec  HL             ; 1:6       $1 +
__{}    dec  HL             ; 1:6       $1 +
__{}    dec  HL             ; 1:6       $1 +},
__{}eval(($1)+2),{0},{
__{}    dec  HL             ; 1:6       $1 +
__{}    dec  HL             ; 1:6       $1 +},
__{}eval(($1)+1),{0},{
__{}    dec  HL             ; 1:6       $1 +},
__{}eval($1),{0},{
__{}                        ;           $1 +},
__{}eval(($1)-1),{0},{
__{}    inc  HL             ; 1:6       $1 +},
__{}eval(($1)-2),{0},{
__{}    inc  HL             ; 1:6       $1 +
__{}    inc  HL             ; 1:6       $1 +},
__{}eval(($1)-3),{0},{
__{}    inc  HL             ; 1:6       $1 +
__{}    inc  HL             ; 1:6       $1 +
__{}    inc  HL             ; 1:6       $1 +},
__{}{
__{}    ld   BC, format({%-11s},$1); 3:10      $1 +
__{}    add  HL, BC         ; 1:11      $1 +})})})dnl
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
__{}    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      $1 -
__{}    or    A             ; 1:4       $1 -
__{}    sbc  HL, BC         ; 2:15      $1 -},{ifelse(
__{}eval($1),{0},{
__{}                        ;           $1 -},
__{}eval(($1)-1),{0},{
__{}    dec  HL             ; 1:6       $1 -},
__{}eval(($1)-1),{0},{
__{}    dec  HL             ; 1:6       $1 -
__{}    dec  HL             ; 1:6       $1 -},
__{}eval(($1)-1),{0},{
__{}    dec  HL             ; 1:6       $1 -
__{}    dec  HL             ; 1:6       $1 -
__{}    dec  HL             ; 1:6       $1 -},
__{}{
__{}    ld   BC, format({%-11s},eval(-($1))); 3:10      $1 -
__{}    add  HL, BC         ; 1:11      $1 -})})})dnl
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
define({PUSH_MAX},{ifelse(index({$1},{(}),{0},{
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
    xor   H             ; 1:4       $1 max{}ifelse(eval($1),{},{
__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}    jp    m, $+6        ; 3:10      $1 max    positive constant $1
__{}  else
__{}    jp    p, $+6        ; 3:10      $1 max    negative constant $1
__{}  endif},{ifelse(eval(($1)<0),0,{
    jp    m, $+6        ; 3:10      $1 max    positive constant $1},{
    jp    p, $+6        ; 3:10      $1 max    negative constant $1})})
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
define({PUSH_MIN},{ifelse(index({$1},{(}),{0},{
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
__{},eval(($1)<0),0,{
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
dnl ( x -- u )
dnl absolute value of x
define({ABS},{
    ld    A, H          ; 1:4       abs
    add   A, A          ; 1:4       abs
    jr   nc, $+8        ; 2:7/12    abs
    NEGATE})dnl
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
define({PRINT_NIBBLE},{ifelse(eval(TEMP_BIN),{0},,{dnl
___{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
___{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
___{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
___{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
___{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
___{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
___{}define({TEMP_BIN_OUT},{_}eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
___{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
___{}ifelse(eval(TEMP_BIN),{0},,{PRINT_NIBBLE}){}dnl
})})dnl
dnl
dnl
dnl
define({PRINT_BINARY},{dnl
___{}define({TEMP_BIN},eval(($1) & 0xffff)){}dnl
___{}define({TEMP_BIN_OUT},{}){}dnl
___{}PRINT_NIBBLE{}dnl
___{}b{}TEMP_BIN_OUT{}dnl
})dnl
dnl
dnl
dnl
define({SUM_1BITS},{define({TEMP},eval((($1) & 0x5555) + (($1) & 0xAAAA)/2)){}dnl
___{}define({TEMP},eval((TEMP & 0x3333) + (TEMP & 0xCCCC)/4)){}dnl
___{}define({TEMP},eval((TEMP & 0x0F0F) + (TEMP & 0xF0F0)/16)){}dnl
___{}eval((TEMP & 0x00FF) + (TEMP & 0xFF00)/256)})dnl
dnl
dnl
dnl
define({SUM_0BITS},{define({INV_BITS},eval(($1) | (($1) >> 1)))dnl
___{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 2)))dnl
___{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 4)))dnl
___{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 8)))dnl
___{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 16)))dnl
___{}define({INV_BITS},eval(INV_BITS-($1)))dnl
___{}SUM_1BITS(eval(INV_BITS))})dnl
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
___{}define({HI_BIT_TEMP},eval(HI_BIT_TEMP|($1)))dnl
___{}HI_BIT_LOOP(eval(($1)/2))dnl
})})dnl
dnl
dnl
dnl
define({HI_BIT},{dnl
___{}define({HI_BIT_TEMP},{0})dnl
___{}HI_BIT_LOOP(eval($1))dnl
___{}eval((HI_BIT_TEMP+1)/2)dnl
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
___{}define({XMUL_INFO_TEMP},{[eval($1 & 0xff):eval($1/256)]})dnl
                        ;format({%-9s},XMUL_INFO_TEMP)  $2 *   $3 = HL * (PRINT_BINARY($4) - PRINT_BINARY($5)){}dnl
})dnl
dnl
dnl
define({PUSH_MUL_INFO_PLUS},{dnl
___{}define({XMUL_INFO_TEMP},{[eval($1 & 0xff):eval($1/256)]})dnl
                        ;format({%-9s},XMUL_INFO_TEMP)  $2 *   $3 = HL * (PRINT_BINARY($2)){}dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_CHECK_FIRST_IS_BETTER},{dnl
___{}eval((($1 & 0xff) < ($2 & 0xff)) || ((($1 & 0xff) == ($2 & 0xff)) && ($1 < $2))){}dnl
___{}})dnl
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
___{}PUSH_MUL_MK1($1){}dnl
___{}define({_BEST_OUT},{PUSH_MUL_MK1_OUT}){}dnl
___{}define({_BEST_COST},PUSH_MUL_MK1_COST){}dnl
___{}define({_BEST_INFO},{PUSH_MUL_MK1_INFO}){}dnl
___{}PUSH_MUL_MK2($1){}dnl
___{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK2_COST,_BEST_COST),{1},{dnl
___{}___{}define({_BEST_OUT},{PUSH_MUL_MK2_OUT}){}dnl
___{}___{}define({_BEST_COST},PUSH_MUL_MK2_COST){}dnl
___{}___{}define({_BEST_INFO},PUSH_MUL_MK2_INFO){}dnl
___{}})dnl
___{}PUSH_MUL_MK3($1){}dnl
___{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK3_COST,_BEST_COST),{1},{dnl
___{}___{}define({_BEST_OUT},{PUSH_MUL_MK3_OUT}){}dnl
___{}___{}define({_BEST_COST},PUSH_MUL_MK3_COST){}dnl
___{}___{}define({_BEST_INFO},PUSH_MUL_MK3_INFO){}dnl
___{}})dnl
___{}PUSH_MUL_MK4($1){}dnl
___{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK4_COST,_BEST_COST),{1},{dnl
___{}___{}define({_BEST_OUT},{PUSH_MUL_MK4_OUT}){}dnl
___{}___{}define({_BEST_COST},PUSH_MUL_MK4_COST){}dnl
___{}___{}define({_BEST_INFO},PUSH_MUL_MK4_INFO){}dnl
___{}})dnl
___{}_BEST_INFO{}dnl
___{}_BEST_OUT{}dnl
})dnl
dnl
dnl
dnl

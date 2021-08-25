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
    ld    L, C          ; 1:4       $1 min    16:62 (58+66)/2},{
    ld    A, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:13},{2:7 })      $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    sub   L             ; 1:4       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    ld    A, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:13},{2:7 })      $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    sbc   A, H          ; 1:4       $1 min    $1<HL --> $1-HL<0 --> carry if $1 is min
    rra                 ; 1:4       $1 min
    xor   H             ; 1:4       $1 min{}{}ifelse(eval($1),{},{
__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}    jp    p, $+6        ; 3:10      $1 min    positive constant $1
__{}  else
__{}    jp    m, $+6        ; 3:10      $1 min    negative constant $1
__{}  endif},{ifelse(eval(($1)<0),0,{
    jp    p, $+6        ; 3:10      $1 min    positive constant $1},{
    jp    m, $+6        ; 3:10      $1 min    negative constant $1})})
    ld   HL, format({%-11s},$1); 3:10      $1 min    14:45 (40+50)/2})})dnl
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
dnl
define({XMUL_LOOP},{define({XMUL_PAR},eval($1)){}define({XMUL_BIT},{1}){}define({XMUL_SUM_BIT},{0}){}_XMUL_LOOP($1)})dnl
dnl
define({_XMUL_LOOP},{ifelse(eval(XMUL_PAR>1),{1},{dnl
___{}ifelse(eval(XMUL_PAR & 1),{1},{XMUL_SAVE}){}dnl
___{}define({XMUL_PAR},eval(XMUL_PAR/2)){}dnl
___{}ifelse(dnl
___{}___{}eval(XMUL_PAR & 127),{0},{dnl
___{}___{}___{}define({XMUL_PAR},eval(XMUL_PAR/128)){}dnl
___{}___{}___{}define({XMUL_BIT},eval(XMUL_BIT*256))
    ld    H, L          ; 1:4       $1 *
    ld    L, 0x00       ; 2:7       $1 *   define({XMUL_SUM_BIT},eval(XMUL_SUM_BIT+XMUL_BIT)){}XMUL_SUM_BIT{}x{}dnl
___{}___{}},
___{}___{}eval(((XMUL_PAR & 63)==0) && (XMUL_BIT > 1)),{1},{dnl
___{}___{}___{}define({XMUL_PAR},eval(XMUL_PAR/64)){}dnl
___{}___{}___{}define({XMUL_BIT},eval(XMUL_BIT*128))
    rr    H             ; 2:8       $1 *
    rr    L             ; 2:8       $1 *
    ld    H, L          ; 1:4       $1 *
    ld    L, 0x00       ; 2:7       $1 *   define({XMUL_SUM_BIT},eval(XMUL_SUM_BIT+XMUL_BIT)){}XMUL_SUM_BIT{}x{}dnl
___{}___{}},
___{}___{}{define({XMUL_BIT},eval(2*XMUL_BIT)){}XMUL_2X}{}dnl
___{}){}dnl
___{}_XMUL_LOOP($1){}dnl
})})dnl
dnl
dnl
dnl
dnl
define({XMUL_NEGLOOP},{define({XMUL_PAR},eval($1-1)){}define({XMUL_BIT},{1}){}define({XMUL_SUM_BIT},{0}){}_XMUL_NEGLOOP($1)})dnl
dnl
define({_XMUL_NEGLOOP},{ifelse(eval(XMUL_PAR>=1),{1},{dnl
___{}ifelse(eval(XMUL_PAR & 1),{0},{XMUL_SAVE}){}dnl
___{}define({XMUL_PAR},eval(XMUL_PAR/2)){}dnl
___{}ifelse(dnl
___{}___{}eval(XMUL_PAR & 127),{127},{dnl
___{}___{}___{}define({XMUL_PAR},eval(XMUL_PAR/128)){}dnl
___{}___{}___{}define({XMUL_BIT},eval(XMUL_BIT*256))
    ld    H, L          ; 1:4       $1 *
    ld    L, 0x00       ; 2:7       $1 *   define({XMUL_SUM_BIT},eval(XMUL_SUM_BIT+XMUL_BIT)){}XMUL_SUM_BIT{}x{}dnl
___{}___{}},
___{}___{}eval(((XMUL_PAR & 63)==63) && (XMUL_BIT > 1)),{1},{dnl
___{}___{}___{}define({XMUL_PAR},eval(XMUL_PAR/64)){}dnl
___{}___{}___{}define({XMUL_BIT},eval(XMUL_BIT*128))
    rr    H             ; 2:8       $1 *
    rr    L             ; 2:8       $1 *
    ld    H, L          ; 1:4       $1 *
    ld    L, 0x00       ; 2:7       $1 *   define({XMUL_SUM_BIT},eval(XMUL_SUM_BIT+XMUL_BIT)){}XMUL_SUM_BIT{}x{}dnl
___{}___{}},
___{}___{}{define({XMUL_BIT},eval(2*XMUL_BIT)){}XMUL_2X}{}dnl
___{}){}dnl
___{}_XMUL_NEGLOOP($1){}dnl
})})dnl
dnl
dnl
dnl 
dnl "const *"
dnl ( x1 -- const*x1 )
define({PUSH_MUL},{define({XMUL_1BITS},SUM_1BITS($1)){}define({XMUL_0BITS},SUM_0BITS($1-1))dnl
dnl
dnl
ifelse(eval($1==0),{1},{
dnl n = 0
dnl
                        ;           $1 *   Variant: HL * 0{}dnl
    ld   HL, 0x0000     ; 3:10      0*{}dnl
},XMUL_1BITS,{1},{
dnl n = 2^a
dnl 1,2,4,8,16,32,...
                        ;           $1 *   Variant: HL * 2^a = HL * PRINT_BINARY($1){}dnl
___{}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1 *   XMUL_BIT{}x})dnl
___{}XMUL_LOOP($1){}dnl
},XMUL_1BITS,{2},{
dnl n = 2^a + 2^b
dnl 3,5,6,9,10,12,17,18,20,24,...
dnl Not all variants are optimal. For example, 258.
                        ;           $1 *   Variant: HL * (2^a + 2^b) = HL * PRINT_BINARY($1){}dnl
___{}define({XMUL_SAVE},{
    ld    B, H          ; 1:4       $1 *
    ld    C, L          ; 1:4       $1 *   define({XMUL_SUM_BIT},XMUL_BIT){}XMUL_SUM_BIT{}x}){}dnl
___{}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl
___{}XMUL_LOOP($1)
    add  HL, BC         ; 1:11      $1 *   XMUL_BIT{}x + XMUL_SUM_BIT{}x = eval(XMUL_BIT+XMUL_SUM_BIT){}x{}dnl
},XMUL_0BITS,{1},{
dnl n = 2^a - 2^b, a > b
dnl 60=64-4
                        ;           $1 *   Variant: HL * (2^a - 2^b) = HL * PRINT_BINARY($1){}dnl
___{}define({XMUL_SAVE},{
    ld    B, H          ; 1:4       $1 *
    ld    C, L          ; 1:4       $1 *   define({XMUL_SUM_BIT},XMUL_BIT){}XMUL_SUM_BIT{}x}){}dnl
___{}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1 *   XMUL_BIT{}x})dnl
___{}XMUL_NEGLOOP($1)
    or    A             ; 1:4       $1 *
    sbc  HL, BC         ; 2:15      $1 *   XMUL_BIT{}x - XMUL_SUM_BIT{}x = eval(XMUL_BIT-XMUL_SUM_BIT){}x{}dnl
},XMUL_1BITS,{3},{
dnl
dnl n = 2^a + 2^b + 2^c
dnl 11=8+2+1,69=64+4+1
                        ;           $1 *   Variant: HL * (2^a + 2^b + 2^c) = HL * PRINT_BINARY($1){}dnl
___{}define({XMUL_SAVE},{
    ld    B, H          ; 1:4       $1 *
    ld    A, L          ; 1:4       $1 *   define({XMUL_SUM_BIT},XMUL_BIT){}XMUL_SUM_BIT{}x{}define({XMUL_SAVE},{
    add   A, L          ; 1:4       $1 *   
    ld    C, A          ; 1:4       $1 *   
    ld    A, B          ; 1:4       $1 *   
    adc   A, H          ; 1:4       $1 *   
    ld    B, A          ; 1:4       $1 *   define({XMUL_SUM_BIT},eval(XMUL_SUM_BIT+XMUL_BIT)){}XMUL_SUM_BIT{}x})}){}dnl
___{}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl
___{}XMUL_LOOP($1)
    add  HL, BC         ; 1:11      $1 *   XMUL_BIT{}x + XMUL_SUM_BIT{}x = eval(XMUL_BIT+XMUL_SUM_BIT){}x{}dnl
},XMUL_0BITS,{2},{
dnl
dnl n = 2^a - 2^b - 2^c, a > b > c
dnl 27=32-4-1,54=64-8-2
                        ;           $1 *   Variant: HL * (2^a - 2^b - 2^c) = HL * PRINT_BINARY($1){}dnl
___{}define({XMUL_SAVE},{
    ld    B, H          ; 1:4       $1 *
    ld    A, L          ; 1:4       $1 *   define({XMUL_SUM_BIT},XMUL_BIT){}XMUL_SUM_BIT{}x{}dnl
___{}___{}define({XMUL_SAVE},{
    add   A, L          ; 1:4       $1 *
    ld    C, A          ; 1:4       $1 *
    ld    A, B          ; 1:4       $1 *
    adc   A, H          ; 1:4       $1 *
    ld    B, A          ; 1:4       $1 *   define({XMUL_SUM_BIT},eval(XMUL_SUM_BIT+XMUL_BIT)){}XMUL_SUM_BIT{}x{}dnl
___{}___{}}){}dnl
___{}}){}dnl
___{}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl
___{}XMUL_NEGLOOP($1)
    or    A             ; 1:4       $1 *
    sbc  HL, BC         ; 2:15      $1 *   XMUL_BIT{}x - XMUL_SUM_BIT{}x = eval(XMUL_BIT-XMUL_SUM_BIT){}x{}dnl
},eval(XMUL_1BITS <= XMUL_0BITS + 2),{1},{
dnl n = 2^a + 2^b + 2^c + ...
                        ;           $1 *   Variant: HL * (2^a + 2^b + 2^c + ...) = HL * PRINT_BINARY($1){}dnl
___{}define({XMUL_SAVE},{
    ld    D, H          ; 1:4       $1 *
    ld    E, L          ; 1:4       $1 *   define({XMUL_SUM_BIT},XMUL_BIT){}XMUL_SUM_BIT{}x{}dnl
___{}___{}define({XMUL_SAVE},{
    ex   DE, HL         ; 1:4       $1 *
    add  HL, DE         ; 1:11      $1 *   define({XMUL_SUM_BIT},eval(XMUL_SUM_BIT+XMUL_BIT)){}XMUL_SUM_BIT{}x
    ex   DE, HL         ; 1:4       $1 *{}dnl
___{}___{}}){}dnl
___{}}){}dnl
___{}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl
    
    ld    B, D          ; 1:4       $1 *
    ld    C, E          ; 1:4       $1 *{}dnl
___{}XMUL_LOOP($1)
    add  HL, DE         ; 1:11      $1 *   XMUL_BIT{}x + XMUL_SUM_BIT{}x = eval(XMUL_BIT+XMUL_SUM_BIT){}x
    ld    D, B          ; 1:4       $1 *
    ld    E, C          ; 1:4       $1 *{}dnl
},{
dnl 187=128+32+16+8+2+1=256-64-4-1
                        ;           $1 *   Variant: HL * (2^a - 2^b - 2^c - ...) = HL * PRINT_BINARY($1){}dnl
___{}define({XMUL_SAVE},{
    ld    D, H          ; 1:4       $1 *
    ld    E, L          ; 1:4       $1 *   define({XMUL_SUM_BIT},XMUL_BIT){}XMUL_SUM_BIT{}x{}dnl
___{}___{}define({XMUL_SAVE},{
    ex   DE, HL         ; 1:4       $1 *
    add  HL, DE         ; 1:11      $1 *   define({XMUL_SUM_BIT},eval(XMUL_SUM_BIT+XMUL_BIT)){}XMUL_SUM_BIT{}x
    ex   DE, HL         ; 1:4       $1 *{}dnl
___{}___{}}){}dnl
___{}}){}dnl
___{}define({XMUL_2X},{
    add  HL, HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl

    ld    B, D          ; 1:4       $1 *
    ld    C, E          ; 1:4       $1 *{}dnl
___{}XMUL_NEGLOOP($1)
    or    A             ; 1:4       $1 *
    sbc  HL, DE         ; 2:15      $1 *   XMUL_BIT{}x - XMUL_SUM_BIT{}x = eval(XMUL_BIT-XMUL_SUM_BIT){}x
    ld    D, B          ; 1:4       $1 *
    ld    E, C          ; 1:4       $1 *})})dnl
dnl
dnl
dnl

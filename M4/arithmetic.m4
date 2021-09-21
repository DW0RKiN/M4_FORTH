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
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 3
define({_3_UDIV},{
                        ;[35:213]   3 /   Variant HL/3 = (HL*257*85) >> 16 = (HL*257*b_0101_0101) >> 16
    ld    B, H          ; 1:4       3 /
    ld    C, L          ; 1:4       3 /   1     1x = base
    xor   A             ; 1:4       3 /
    add  HL, HL         ; 1:11      3 /   0
    adc   A, A          ; 1:4       3 /      *2 AHL = 2x
    add  HL, HL         ; 1:11      3 /   1
    adc   A, A          ; 1:4       3 /      *2 AHL = 4x
    add  HL, BC         ; 1:11      3 /
    adc   A, 0x00       ; 2:7       3 /      +1 AHL = 5x
    add  HL, HL         ; 1:11      3 /   0
    adc   A, A          ; 1:4       3 /      *2 AHL = 10x
    add  HL, HL         ; 1:11      3 /   1
    adc   A, A          ; 1:4       3 /      *2 AHL = 20x
    add  HL, BC         ; 1:11      3 /
    adc   A, 0x00       ; 2:7       3 /      +1 AHL = 21x
    add  HL, HL         ; 1:11      3 /   0
    adc   A, A          ; 1:4       3 /      *2 AHL = 42x
    add  HL, HL         ; 1:11      3 /   1
    adc   A, A          ; 1:4       3 /      *2 AHL = 84x
    add  HL, BC         ; 1:11      3 /
    ld   BC, 0x0055     ; 3:10      3 /         rounding down constant
    adc   A, B          ; 1:4       3 /      +1 AHL = 85x
    add  HL, BC         ; 1:11      3 /
    adc   A, B          ; 1:4       3 /      +0 AHL = 85x with rounding down constant
    ld    C, A          ; 1:4       3 /         BC = "0A"
    ld    A, L          ; 1:4       3 /         (AHL * 257) >> 16 = (0AHL + AHL0) >> 16 --> 0A.HL + AH.L0
    add   A, H          ; 1:4       3 /         00.H + 00.L --> carry?
    ld    L, H          ; 1:4       3 /
    ld    H, C          ; 1:4       3 /         HL = "AH"
    adc  HL, BC         ; 2:15      3 /         HL = HL/3 = HL*(65536/65536)/3 = HL*21845/65536 = (HL*(1+256)*85) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 5
define({_5_UDIV},{
                        ;[33:198]   5 /   Variant HL/5 = (HL*257*51) >> 16 = (HL*257*b_0011_0011) >> 16
    ld    B, H          ; 1:4       5 /
    ld    C, L          ; 1:4       5 /   1     1x = base
    xor   A             ; 1:4       5 /
    add  HL, HL         ; 1:11      5 /   1
    adc   A, A          ; 1:4       5 /      *2 AHL = 2x
    add  HL, BC         ; 1:11      5 /
    adc   A, 0x00       ; 2:7       5 /      +1 AHL = 3x
    add  HL, HL         ; 1:11      5 /   0
    adc   A, A          ; 1:4       5 /      *2 AHL = 6x
    add  HL, HL         ; 1:11      5 /   0
    adc   A, A          ; 1:4       5 /      *2 AHL = 12x
    add  HL, HL         ; 1:11      5 /   1
    adc   A, A          ; 1:4       5 /      *2 AHL = 24x
    add  HL, BC         ; 1:11      5 /
    adc   A, 0x00       ; 2:7       5 /      +1 AHL = 25x
    add  HL, HL         ; 1:11      5 /   1
    adc   A, A          ; 1:4       5 /      *2 AHL = 50x
    add  HL, BC         ; 1:11      5 /
    ld   BC, 0x0033     ; 3:10      5 /         rounding down constant
    adc   A, B          ; 1:4       5 /      +1 AHL = 51x
    add  HL, BC         ; 1:11      5 /
    adc   A, B          ; 1:4       5 /      +0 AHL = 51x with rounding down constant
    ld    C, A          ; 1:4       5 /         BC = "0A"
    ld    A, L          ; 1:4       5 /         (AHL * 257) >> 16 = (0AHL + AHL0) >> 16 --> 0A.HL + AH.L0
    add   A, H          ; 1:4       5 /         00.H + 00.L --> carry?
    ld    L, H          ; 1:4       5 /
    ld    H, C          ; 1:4       5 /         HL = "AH"
    adc  HL, BC         ; 2:15      5 /         HL = HL/5 = HL*(65536/65536)/5 = HL*13107/65536 = (HL*(1+256)*51) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 15
define({_15_UDIV},{
                        ;[25:147]   15 /   Variant HL/15 = (HL*257*17) >> 16 = (HL*257*b_0001_0001) >> 16
    ld    B, H          ; 1:4       15 /
    ld    C, L          ; 1:4       15 /   1     1x = base
    xor   A             ; 1:4       15 /
    add  HL, HL         ; 1:11      15 /   0
    adc   A, A          ; 1:4       15 /      *2 AHL = 2x
    add  HL, HL         ; 1:11      15 /   0
    adc   A, A          ; 1:4       15 /      *2 AHL = 4x
    add  HL, HL         ; 1:11      15 /   0
    adc   A, A          ; 1:4       15 /      *2 AHL = 8x
    add  HL, HL         ; 1:11      15 /   1
    adc   A, A          ; 1:4       15 /      *2 AHL = 16x
    add  HL, BC         ; 1:11      15 /
    ld   BC, 0x0011     ; 3:10      15 /         rounding down constant
    adc   A, B          ; 1:4       15 /      +1 AHL = 17x
    add  HL, BC         ; 1:11      15 /
    adc   A, B          ; 1:4       15 /      +0 AHL = 17x with rounding down constant
    ld    C, A          ; 1:4       15 /         BC = "0A"
    ld    A, L          ; 1:4       15 /         (AHL * 257) >> 16 = (0AHL + AHL0) >> 16 --> 0A.HL + AH.L0
    add   A, H          ; 1:4       15 /         00.H + 00.L --> carry?
    ld    L, H          ; 1:4       15 /
    ld    H, C          ; 1:4       15 /         HL = "AH"
    adc  HL, BC         ; 2:15      15 /         HL = HL/15 = HL*(65536/65536)/15 = HL*4369/65536 = (HL*(1+256)*17) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 17
define({_17_UDIV},{
                        ;[26:151]   17 /   Variant HL/17 = (HL*257*15) >> 16 = (HL*257*b_0000_1111) >> 16
    ld    B, H          ; 1:4       17 /
    ld    C, L          ; 1:4       17 /   1     1x = base
    xor   A             ; 1:4       17 /
    add  HL, HL         ; 1:11      17 /   0
    adc   A, A          ; 1:4       17 /      *2 AHL = 2x
    add  HL, HL         ; 1:11      17 /   0
    adc   A, A          ; 1:4       17 /      *2 AHL = 4x
    add  HL, HL         ; 1:11      17 /   0
    adc   A, A          ; 1:4       17 /      *2 AHL = 8x
    add  HL, HL         ; 1:11      17 /  -1
    adc   A, A          ; 1:4       17 /      *2 AHL = 16x
    sbc  HL, BC         ; 2:15      17 /
    ld   BC, 0x000f     ; 3:10      17 /         rounding down constant
    sbc   A, B          ; 1:4       17 /      -1 AHL = 15x
    add  HL, BC         ; 1:11      17 /
    adc   A, B          ; 1:4       17 /      +0 AHL = 15x with rounding down constant
    ld    C, A          ; 1:4       17 /         BC = "0A"
    ld    A, L          ; 1:4       17 /         (AHL * 257) >> 16 = (0AHL + AHL0) >> 16 --> 0A.HL + AH.L0
    add   A, H          ; 1:4       17 /         00.H + 00.L --> carry?
    ld    L, H          ; 1:4       17 /
    ld    H, C          ; 1:4       17 /         HL = "AH"
    adc  HL, BC         ; 2:15      17 /         HL = HL/17 = HL*(65536/65536)/17 = HL*3855/65536 = (HL*(1+256)*15) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 51
define({_51_UDIV},{
                        ;[21:117]   51 /   Variant HL/51 = (HL*257*5) >> 16 = (HL*257*b_0000_0101) >> 16
    ld    B, H          ; 1:4       51 /
    ld    C, L          ; 1:4       51 /   1     1x = base
    xor   A             ; 1:4       51 /
    add  HL, HL         ; 1:11      51 /   0
    adc   A, A          ; 1:4       51 /      *2 AHL = 2x
    add  HL, HL         ; 1:11      51 /   1
    adc   A, A          ; 1:4       51 /      *2 AHL = 4x
    add  HL, BC         ; 1:11      51 /
    ld   BC, 0x0005     ; 3:10      51 /         rounding down constant
    adc   A, B          ; 1:4       51 /      +1 AHL = 5x
    add  HL, BC         ; 1:11      51 /
    adc   A, B          ; 1:4       51 /      +0 AHL = 5x with rounding down constant
    ld    C, A          ; 1:4       51 /         BC = "0A"
    ld    A, L          ; 1:4       51 /         (AHL * 257) >> 16 = (0AHL + AHL0) >> 16 --> 0A.HL + AH.L0
    add   A, H          ; 1:4       51 /         00.H + 00.L --> carry?
    ld    L, H          ; 1:4       51 /
    ld    H, C          ; 1:4       51 /         HL = "AH"
    adc  HL, BC         ; 2:15      51 /         HL = HL/51 = HL*(65536/65536)/51 = HL*1285/65536 = (HL*(1+256)*5) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 85
define({_85_UDIV},{
                        ;[19:102]   85 /   Variant HL/85 = (HL*257*3) >> 16 = (HL*257*b_0000_0011) >> 16
    ld    B, H          ; 1:4       85 /
    ld    C, L          ; 1:4       85 /   1     1x = base
    xor   A             ; 1:4       85 /
    add  HL, HL         ; 1:11      85 /   1
    adc   A, A          ; 1:4       85 /      *2 AHL = 2x
    add  HL, BC         ; 1:11      85 /
    ld   BC, 0x0003     ; 3:10      85 /         rounding down constant
    adc   A, B          ; 1:4       85 /      +1 AHL = 3x
    add  HL, BC         ; 1:11      85 /
    adc   A, B          ; 1:4       85 /      +0 AHL = 3x with rounding down constant
    ld    C, A          ; 1:4       85 /         BC = "0A"
    ld    A, L          ; 1:4       85 /         (AHL * 257) >> 16 = (0AHL + AHL0) >> 16 --> 0A.HL + AH.L0
    add   A, H          ; 1:4       85 /         00.H + 00.L --> carry?
    ld    L, H          ; 1:4       85 /
    ld    H, C          ; 1:4       85 /         HL = "AH"
    adc  HL, BC         ; 2:15      85 /         HL = HL/85 = HL*(65536/65536)/85 = HL*771/65536 = (HL*(1+256)*3) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 255
define({_255_UDIV},{
                        ;[13:64]    255 /   Variant HL/255 = (HL*257*1) >> 16 = (HL*257*b_0000_0001) >> 16
    xor   A             ; 1:4       255 /
    ld   BC, 0x0001     ; 3:10      255 /         rounding down constant
    add  HL, BC         ; 1:11      255 /
    adc   A, A          ; 1:4       255 /      +0 AHL = 1x with rounding down constant
    ld    C, A          ; 1:4       255 /         BC = "0A"
    ld    A, L          ; 1:4       255 /         (AHL * 257) >> 16 = (0AHL + AHL0) >> 16 --> 0A.HL + AH.L0
    add   A, H          ; 1:4       255 /         00.H + 00.L --> carry?
    ld    L, H          ; 1:4       255 /
    ld    H, C          ; 1:4       255 /         HL = "AH"
    adc  HL, BC         ; 2:15      255 /         HL = HL/255 = HL*(65536/65536)/255 = HL*257/65536 = (HL*(1+256)) >> 16{}dnl
})dnl
dnl
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
include(M4PATH{}push_mul/pmul_mk1.m4){}dnl
include(M4PATH{}push_mul/pmul_mk2.m4){}dnl
include(M4PATH{}push_mul/pmul_mk3.m4){}dnl
include(M4PATH{}push_mul/pmul_mk4.m4){}dnl
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

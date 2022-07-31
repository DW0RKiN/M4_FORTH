dnl ## Logic
define({__},{})dnl
dnl
dnl # ( x1 x2 -- x )
dnl # x = x1 & x2
define({AND},{
    ld    A, E          ; 1:4       and   ( x2 x1 -- x )  x = x2 & x1
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and})dnl
dnl
dnl
dnl # ( x -- x&n )
dnl # x = x & n
define({PUSH_AND},{ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}                        ;[10:42]    $1 and   ( x1 -- x )  x = x1 & $1
__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1 and
__{}    and   H             ; 1:4       $1 and
__{}    ld    H, A          ; 1:4       $1 and
__{}    ld    A, format({%-11s},$1); 3:13      $1 and
__{}    and   L             ; 1:4       $1 and
__{}    ld    L, A          ; 1:4       $1 and},
__IS_NUM($1),{0},{
__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}                        ;[8:30]     $1 and   ( x1 -- x )  x = x1 & $1
__{}    ld    A, high format({%-6s},$1); 2:7       $1 and
__{}    and   H             ; 1:4       $1 and
__{}    ld    H, A          ; 1:4       $1 and
__{}    ld    A, low format({%-7s},$1); 2:7       $1 and
__{}    and   L             ; 1:4       $1 and
__{}    ld    L, A          ; 1:4       $1 and},
{dnl
__{}define({_TMP_INFO},{$1 and}){}dnl
__{}__AND_REG16_16BIT({HL},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( x1 x2 -- x )
dnl # x = x1 | x2
define({OR},{
    ld    A, E          ; 1:4       or   ( x2 x1 -- x )  x = x2 | x1
    or    L             ; 1:4       or
    ld    L, A          ; 1:4       or
    ld    A, D          ; 1:4       or
    or    H             ; 1:4       or
    ld    H, A          ; 1:4       or
    pop  DE             ; 1:10      or})dnl
dnl
dnl
dnl # ( x -- x|n )
dnl # x = x | n
define({PUSH_OR},{ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}                        ;[10:42]    $1 or   ( x1 -- x )  x = x1 | $1
__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1 or
__{}    or    H             ; 1:4       $1 or
__{}    ld    H, A          ; 1:4       $1 or
__{}    ld    A, format({%-11s},$1); 3:13      $1 or
__{}    or    L             ; 1:4       $1 or
__{}    ld    L, A          ; 1:4       $1 or},
__IS_NUM($1),{0},{
__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}                        ;[8:30]     $1 or   ( x1 -- x )  x = x1 | $1
__{}    ld    A, high format({%-6s},$1); 2:7       $1 or
__{}    or    H             ; 1:4       $1 or
__{}    ld    H, A          ; 1:4       $1 or
__{}    ld    A, low format({%-7s},$1); 2:7       $1 or
__{}    or    L             ; 1:4       $1 or
__{}    ld    L, A          ; 1:4       $1 or},
{dnl
__{}define({_TMP_INFO},{$1 or}){}dnl
__{}__OR_REG16_16BIT({HL},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( x1 x2 -- x )
dnl # x = x1 ^ x2
define({XOR},{
    ld    A, E          ; 1:4       xor   ( x2 x1 -- x )  x = x2 ^ x1
    xor   L             ; 1:4       xor
    ld    L, A          ; 1:4       xor
    ld    A, D          ; 1:4       xor
    xor   H             ; 1:4       xor
    ld    H, A          ; 1:4       xor
    pop  DE             ; 1:10      xor})dnl
dnl
dnl
dnl # ( x -- x^n )
dnl # x = x ^ n
define({PUSH_XOR},{ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}                        ;[10:42]    $1 xor   ( x1 -- x )  x = x1 ^ $1
__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1 xor
__{}    xor   H             ; 1:4       $1 xor
__{}    ld    H, A          ; 1:4       $1 xor
__{}    ld    A, format({%-11s},$1); 3:13      $1 xor
__{}    xor   L             ; 1:4       $1 xor
__{}    ld    L, A          ; 1:4       $1 xor},
__IS_NUM($1),{0},{
__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}                        ;[8:30]     $1 xor   ( x1 -- x )  x = x1 ^ $1
__{}    ld    A, high format({%-6s},$1); 2:7       $1 xor
__{}    xor   H             ; 1:4       $1 xor
__{}    ld    H, A          ; 1:4       $1 xor
__{}    ld    A, low format({%-7s},$1); 2:7       $1 xor
__{}    xor   L             ; 1:4       $1 xor
__{}    ld    L, A          ; 1:4       $1 xor},
{dnl
__{}define({_TMP_INFO},{$1 xor}){}dnl
__{}__XOR_REG16_16BIT({HL},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( x1 -- x )
dnl # x = ~x1
dnl # -1   -> false
dnl # false-> true
define({INVERT},{
    ld    A, L          ; 1:4       invert
    cpl                 ; 1:4       invert
    ld    L, A          ; 1:4       invert
    ld    A, H          ; 1:4       invert
    cpl                 ; 1:4       invert
    ld    H, A          ; 1:4       invert})dnl
dnl
dnl
dnl # ( a b c -- ((a-b) (c-b) U<) )
dnl # b <= a < c
define({WITHIN},{ifelse(TYP_WITHIN,{fast},{
                        ;[18:91]    within ( a b c -- flag=(b<=a<c) )   # fast version can be changed with "define({TYP_WITHIN},{name})", name=fast
    ld    A, L          ; 1:4       within
    sub   E             ; 1:4       within
    ld    C, A          ; 1:4       within
    ld    A, H          ; 1:4       within
    sbc   A, D          ; 1:4       within
    ld    B, A          ; 1:4       within BC = c-b
    pop  HL             ; 1:10      within
    or    A             ; 1:4       within
    sbc  HL, DE         ; 2:15      within HL = a-b
    ld    A, L          ; 1:4       within
    sub   C             ; 1:4       within
    ld    A, H          ; 1:4       within
    sbc   A, B          ; 1:4       within (a-b) - (c-b) < 0
    sbc   A, A          ; 1:4       within
    ld    L, A          ; 1:4       within
    ld    H, A          ; 1:4       within
    pop  DE             ; 1:10      within ( a b c -- ((a-b) (c-b) U<) )}dnl
,{
                        ;[16:97]    within ( a b c -- flag=(b<=a<c) )   # default version can be changed with "define({TYP_WITHIN},{name})", name=fast
    ld    A, L          ; 1:4       within
    sub   E             ; 1:4       within
    ld    C, A          ; 1:4       within
    ld    A, H          ; 1:4       within
    sbc   A, D          ; 1:4       within
    ld    B, A          ; 1:4       within BC = c-b
    pop  HL             ; 1:10      within
    or    A             ; 1:4       within
    sbc  HL, DE         ; 2:15      within HL = a-b
    or    A             ; 1:4       within
    sbc  HL, BC         ; 2:15      within (a-b) - (c-b) < 0
    sbc  HL, HL         ; 2:15      within
    pop  DE             ; 1:10      within ( a b c -- ((a-b) (c-b) U<) )})})dnl
dnl
dnl
dnl # ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl # $1 <= a < $2
define({PUSH2_WITHIN},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}eval($#>2),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
{define({_TMP_INFO},{$1 $2 within}){}define({PUSH2_WITHIN_CODE},__WITHIN($1,$2))
__{}                        ;format({%-11s},[eval(2+__WITHIN_B):eval(15+__WITHIN_C)])_TMP_INFO   ( {TOS} -- flag )  flag=($1<={TOS}<$2){}dnl
__{}PUSH2_WITHIN_CODE
__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   HL = 0x0000 or 0xffff}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( c3 c2 c1 -- ((c3-c2) (c1-c2) U<) )
dnl # c2 <= c3 < c1
define({LO_WITHIN},{
                        ;[10:59]    lo_within   ( c3 c2 c1 -- flag=(c2<=c3<c1) )
    ld    A, L          ; 1:4       lo_within
    sub   E             ; 1:4       lo_within
    ld    C, A          ; 1:4       lo_within   C = c1-c2
    pop  HL             ; 1:10      lo_within   L = c3
    ld    A, L          ; 1:4       lo_within
    sub   E             ; 1:4       lo_within   c3-c2
    sub   C             ; 1:4       lo_within   (c3-c2)-(c1-c2)
    sbc  HL, HL         ; 2:15      lo_within   HL = 0x0000 or 0xffff
    pop  DE             ; 1:10      lo_within   ( c3 c2 c1 -- ((c3-c2) (c1-c2) U<) ){}dnl
})dnl
dnl
dnl
dnl # ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl # $1 <= a < $2
define({PUSH2_LO_WITHIN},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}                        ;[ifelse(__IS_MEM_REF($2),{1},{14:65},{13:59})]    push2_lo_within($1,$2)   ( a $1 $2 -- flag=($1<=a<$2) )
__{}    ld    A, format({%-11s},$1); 3:13      push2_lo_within($1,$2)
__{}    ld    C, A          ; 1:4       push2_lo_within($1,$2)   C = $1
__{}    ld    A, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{3:13},{2:7 })      push2_lo_within($1,$2)
__{}    sub   C             ; 1:4       push2_lo_within($1,$2)
__{}    ld    B, A          ; 1:4       push2_lo_within($1,$2)   B = ($2)-[$1]
__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}    sub   C             ; 1:4       push2_lo_within($1,$2)   A = a -($1)
__{}    sub   B             ; 1:4       push2_lo_within($1,$2)   A = (a -($1)) - ([$2]-($1))
__{}    sbc  HL, HL         ; 2:15      push2_lo_within($1,$2)   HL = 0x0000 or 0xffff}dnl
__{},__IS_MEM_REF($2),{1},{dnl
__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}__{}                        ;[8:40]     push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, format({%-11s},$2); 3:13      push2_lo_within($1,$2)
__{}__{}__{}    ld    B, A          ; 1:4       push2_lo_within($1,$2)   B = $2 - {{$1}}
__{}__{}__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)},
__{}__{}__{}eval($1),{1},{dnl
__{}__{}__{}                        ;[10:48]    push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, format({%-11s},$2); 3:13      push2_lo_within($1,$2)
__{}__{}__{}    dec   A             ; 1:4       push2_lo_within($1,$2)
__{}__{}__{}    ld    B, A          ; 1:4       push2_lo_within($1,$2)   B = $2 - {{$1}}
__{}__{}__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}__{}__{}    dec   A             ; 1:4       push2_lo_within($1,$2)   A = a - {{$1}}},
__{}__{}__{}eval($1),{-1},{dnl
__{}__{}__{}                        ;[10:48]    push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, format({%-11s},$2); 3:13      push2_lo_within($1,$2)
__{}__{}__{}    inc   A             ; 1:4       push2_lo_within($1,$2)
__{}__{}__{}    ld    B, A          ; 1:4       push2_lo_within($1,$2)   B = $2 - {{$1}}
__{}__{}__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}__{}__{}    inc   A             ; 1:4       push2_lo_within($1,$2)   A = a - {{$1}}},
__{}__{}__{}{dnl
__{}__{}__{}                        ;[12:54]    push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, format({%-11s},$2); 3:13      push2_lo_within($1,$2)
__{}__{}__{}    sub   format({%-14s},$1); 2:7       push2_lo_within($1,$2)
__{}__{}__{}    ld    B, A          ; 1:4       push2_lo_within($1,$2)   B = $2 - {{$1}}
__{}__{}__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}__{}__{}    sub   format({%-14s},$1); 2:7       push2_lo_within($1,$2)   A = a - {{$1}}})
__{}    sub   B             ; 1:4       push2_lo_within($1,$2)   A = (a - {{$1}}) - ($2 - {{$1}})
__{}    sbc  HL, HL         ; 2:15      push2_lo_within($1,$2)   HL = 0x0000 or 0xffff}dnl
__{},{dnl
__{}__{}ifelse(__IS_NUM($1),{0},{dnl
__{}                        ;[7:33]     push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}    sub   format({%-14s},$1); 2:7       push2_lo_within($1,$2)   A = a-($1)},
__{}__{}{dnl
__{}__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}__{}__{}                        ;[5:26]     push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)},
__{}__{}__{}eval($1),{1},{dnl
__{}__{}__{}__{}                        ;[6:30]     push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}__{}__{}__{}    dec   A             ; 1:4       push2_lo_within($1,$2)   A = a-($1)},
__{}__{}__{}eval($1),{-1},{dnl
__{}__{}__{}__{}                        ;[6:30]     push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}__{}__{}__{}    inc   A             ; 1:4       push2_lo_within($1,$2)   A = a-($1)},
__{}__{}__{}{dnl
__{}__{}__{}__{}                        ;[7:33]     push2_lo_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}__{}__{}__{}    sub   format({%-14s},$1); 2:7       push2_lo_within($1,$2)   A = a-($1)})})
__{}    sub  low format({%-11s},($2)-($1)); 2:7       push2_lo_within($1,$2)   carry: a-($1) - (($2)-($1))
__{}    sbc  HL, HL         ; 2:15      push2_lo_within($1,$2)   HL = 0x0000 or 0xffff})})dnl
dnl
dnl
dnl # -------------------------------------
dnl
dnl # ( -- x )
dnl # x = 0xFFFF
define({TRUE},{
    push DE             ; 1:11      true
    ex   DE, HL         ; 1:4       true
    ld   HL, 0xffff     ; 3:10      true})dnl
dnl
dnl # ( -- x )
dnl # x = 0
define({FALSE},{
    push DE             ; 1:11      false
    ex   DE, HL         ; 1:4       false
    ld   HL, 0x0000     ; 3:10      false})dnl
dnl
dnl # -------------------------------------
dnl
dnl # 0=
dnl # ( x1 -- flag )
dnl # if ( x1 ) flag = 0; else flag = 0xFFFF;
dnl # 0 if 16-bit number not equal to zero, -1 if equal
define({_0EQ},{
                        ;[5:29]     0=
    ld    A, H          ; 1:4       0=
    dec  HL             ; 1:6       0=
    sub   H             ; 1:4       0=
    sbc  HL, HL         ; 2:15      0=})dnl
dnl
dnl
dnl
dnl # ------------ signed -----------------
dnl
dnl
dnl # =
dnl # ( x1 x2 -- flag )
dnl # equal ( x1 == x2 )
define({EQ},{
                        ;[9:48/49]  =
    xor   A             ; 1:4       =   A = 0x00
    sbc  HL, DE         ; 2:15      =
    jr   nz, $+3        ; 2:7/12    =
    dec   A             ; 1:4       =   A = 0xFF
    ld    L, A          ; 1:4       =
    ld    H, A          ; 1:4       =   HL= flag
    pop  DE             ; 1:10      =})dnl
dnl
dnl
dnl # ( x -- x|n )
dnl # x = x | n
define({PUSH_EQ},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[12:58/59] $1 =
__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 =
__{}__{}    xor   A             ; 1:4       $1 =   A = 0x00
__{}__{}    sbc  HL, BC         ; 2:15      $1 =
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 =
__{}__{}    dec   A             ; 1:4       $1 =   A = 0xFF
__{}__{}    ld    L, A          ; 1:4       $1 =
__{}__{}    ld    H, A          ; 1:4       $1 =   HL= flag},
__{}__IS_NUM($1),{0},{dnl
__{}__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}__{}                        ;[11:48/49] $1 =
__{}__{}    ld   BC, format({%-11s},$1); 3:10      $1 =
__{}__{}    xor   A             ; 1:4       $1 =   A = 0x00
__{}__{}    sbc  HL, BC         ; 2:15      $1 =
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 =
__{}__{}    dec   A             ; 1:4       $1 =   A = 0xFF
__{}__{}    ld    L, A          ; 1:4       $1 =
__{}__{}    ld    H, A          ; 1:4       $1 =   HL= flag},
__{}{dnl
__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}                        ;[6:30]     $1 =
__{}__{}    ld    A, L          ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval($1),{1},{dnl
__{}__{}                        ;[7:34]     $1 =
__{}__{}    ld    A, L          ; 1:4       $1 =
__{}__{}    dec   A             ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval((($1) & 0xffff) - 0xffff),{0},{dnl
__{}__{}                        ;[7:36]     $1 =
__{}__{}    inc   HL            ; 1:6       $1 =
__{}__{}    ld    A, L          ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval($1),{255},{dnl
__{}__{}                        ;[7:34]     $1 =
__{}__{}    ld    A, L          ; 1:4       $1 =
__{}__{}    inc   A             ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval($1),{256},{dnl
__{}__{}                        ;[7:34]     $1 =
__{}__{}    ld    A, H          ; 1:4       $1 =
__{}__{}    dec   A             ; 1:4       $1 =
__{}__{}    or    L             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval(($1) - 0xff00),{0},{dnl
__{}__{}                        ;[7:34]     $1 =
__{}__{}    ld    A, H          ; 1:4       $1 =
__{}__{}    inc   A             ; 1:4       $1 =
__{}__{}    or    L             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval(($1) & 0xff00),{0},{dnl
__{}__{}                        ;[8:37]     $1 =
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 =   lo($1)
__{}__{}    xor   L             ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval(($1) & 0xff),{0},{dnl
__{}__{}                        ;[8:37]     $1 =
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       $1 =   hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    or    L             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval((($1)>>8) & 0xff),{1},{dnl
__{}__{}                        ;[9:41]     $1 =
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 =   lo($1)
__{}__{}    xor   L             ; 1:4       $1 =
__{}__{}    dec   H             ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval((($1)>>8) & 0xff),{255},{dnl
__{}__{}                        ;[9:41]     $1 =
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 =   lo($1)
__{}__{}    xor   L             ; 1:4       $1 =
__{}__{}    inc   H             ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval(($1) & 0xff),{1},{dnl
__{}__{}                        ;[9:41]     $1 =
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       $1 =   hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    dec   L             ; 1:4       $1 =
__{}__{}    or    L             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval(($1) & 0xff),{255},{dnl
__{}__{}                        ;[9:41]     $1 =
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       $1 =   hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    inc   L             ; 1:4       $1 =
__{}__{}    or    L             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval((($1) & 0xff)-((($1)>>8) & 0xff)),{0},{dnl
__{}__{}                        ;[11:48/35] $1 =
__{}__{}    ld    A, L          ; 1:4       $1 =
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 =
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 =   lo($1) = hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}{dnl
__{}__{}                        ;[12:51/38] $1 =
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 =   lo($1)
__{}__{}    xor   L             ; 1:4       $1 =
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 =
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       $1 =   hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
define({DUP_PUSH_EQ},{dnl
__{}define({_TMP_INFO},{dup $1 =})dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( x -- x f )   __HEX_HL($1) == HL})dnl
__{}ifelse($1,{},{dnl
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                        ;[13:69/70] _TMP_INFO   ( x -- x f )   (addr) = (__HEX_HL($1)) = HL
__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld   HL, format({%-11s},$1); 3:16      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO
__{}__{}__{}    jr   nz, $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld    L, A          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    H, A          ; 1:4       _TMP_INFO   set flag x==$1},
__{}__{}{dnl
__{}__{}__{}__EQ_MAKE_BEST_CODE($1,6,37,0,0)dnl
__{}__{}__{}ifelse(eval(_TMP_BEST_P<=1848),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    sub 0x01            ; 2:7       _TMP_INFO
__{}__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag x==$1},
__{}__{}__{}{
__{}__{}__{}__{}                        ;[13:63/64]{}_TMP_STACK_INFO
__{}__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}__{}    ld   HL, format({%-11s},$1); 3:10      _TMP_INFO
__{}__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO
__{}__{}__{}__{}    jr   nz, $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}__{}__{}    ld    L, A          ; 1:4       _TMP_INFO
__{}__{}__{}__{}    ld    H, A          ; 1:4       _TMP_INFO   set flag x==$1})})},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # C=
dnl # ( c1 c2 -- flag )
dnl # equal ( lo c1 == lo c2 )
define({CEQ},{
                        ;[7:40]     C=   ( c1 c2 -- flag )
    ld    A, L          ; 1:4       C=
    xor   E             ; 1:4       C=   ignores higher bytes
    sub  0x01           ; 2:7       C=
    sbc  HL, HL         ; 2:15      C=
    pop  DE             ; 1:10      C=})dnl
dnl
dnl
dnl
dnl # 0 C=
dnl # ( c1 -- flag )  flag = lo c1 == 0
define({_0CEQ},{
                        ;[5:26]     0 C=   ( c1 -- flag )  flag = lo(c1) == 0
    ld    A, L          ; 1:4       0 C=   ignores higher bytes
    sub  0x01           ; 2:7       0 C=
    sbc  HL, HL         ; 2:15      0 C=})dnl
dnl
dnl
dnl # C@ 0 C=
dnl # ( addr -- flag )  flag = byte from (addr) == 0
define({CFETCH_0CEQ},{
                        ;[5:29]     C@ 0 C=   ( addr -- flag )  flag = byte from (addr) == 0
    ld    A,(HL)        ; 1:7       C@ 0 C=
    sub  0x01           ; 2:7       C@ 0 C=
    sbc  HL, HL         ; 2:15      C@ 0 C=})dnl
dnl
dnl
dnl # 0 C<>
dnl # ( c1 -- flag )  flag = lo c1 <> 0
define({_0CNE},{
                        ;[5:26]     0 C<>   ( c1 -- flag )  flag = lo(c1) <> 0
    ld    A, L          ; 1:4       0 C<>   ignores higher bytes
    add   A, 0xFF       ; 2:7       0 C<>
    sbc  HL, HL         ; 2:15      0 C<>})dnl
dnl
dnl
dnl # C@ 0 C<>
dnl # ( addr -- flag )  flag = byte from (addr) <> 0
define({CFETCH_0CNE},{
                        ;[5:29]     C@ 0 C<>   ( addr -- flag )  flag = byte from (addr) <> 0
    ld    A,(HL)        ; 1:7       C@ 0 C<>
    add   A, 0xFF       ; 2:7       C@ 0 C<>
    sbc  HL, HL         ; 2:15      C@ 0 C<>})dnl
dnl
dnl
dnl # over C@ over C@ C=
dnl # ( addr2 addr1 -- addr2 addr1 flag )
dnl # flag = char2 == char1
dnl # 8-bit compares the contents of two addresses.
define({OVER_CFETCH_OVER_CFETCH_CEQ},{
                        ;[8:51]     over @C over @C C= over_cfetch_over_cfetch_ceq ( addr2 addr1 -- addr2 addr1 flag(char2==char1) )
    push DE             ; 1:11      over @C over @C C= over_cfetch_over_cfetch_ceq
    ex   DE, HL         ; 1:4       over @C over @C C= over_cfetch_over_cfetch_ceq
    ld    A, (DE)       ; 1:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    xor (HL)            ; 1:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    sub  0x01           ; 2:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    sbc  HL, HL         ; 2:15      over @C over @C C= over_cfetch_over_cfetch_ceq})dnl
dnl
dnl
dnl
dnl # <>
dnl # ( x1 x2 -- flag )
dnl # not equal ( x1 <> x2 )
define({NE},{
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <>})dnl
dnl
dnl
dnl
define({DUP_PUSH_NE},{dnl
__{}define({_TMP_INFO},{dup $1 <>})dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( x -- x f )   __HEX_HL($1) <> HL})dnl
__{}ifelse($1,{},{dnl
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                        ;[13:67/62] _TMP_INFO   ( x -- x f )   (addr) <> HL
__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld   HL, format({%-11s},$1); 3:16      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO
__{}__{}__{}    jr    z, $+5        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL, 0xFFFF     ; 3:10      _TMP_INFO   set flag x<>$1},
__{}__{}{dnl
__{}__{}__{}__EQ_MAKE_BEST_CODE($1,6,37,0,0)dnl
__{}__{}__{}ifelse(eval(_TMP_BEST_P<=1768),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    add   A, 0xFF       ; 2:7       _TMP_INFO
__{}__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag x<>$1},
__{}__{}__{}{
__{}__{}__{}__{}                        ;[13:61/56]{}_TMP_STACK_INFO
__{}__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}__{}    ld   HL, format({%-11s},$1); 3:10      _TMP_INFO
__{}__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO
__{}__{}__{}__{}    jr    z, $+5        ; 2:7/12    _TMP_INFO
__{}__{}__{}__{}    ld   HL, 0xFFFF     ; 3:10      _TMP_INFO   set flag x<>$1})})},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # <
dnl # ( x2 x1 -- flag )
dnl # signed ( x2 < x1 ) --> ( x2 - x1 < 0 ) --> carry is true
define({LT},{
                       ;[12:54]     <   ( x2 x1 -- flag x2<x1 )
    ld    A, E          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       <   carry --> sign
    xor   H             ; 1:4       <
    xor   D             ; 1:4       <
    add   A, A          ; 1:4       <   sign --> carry
    sbc   A, A          ; 1:4       <   0x00 or 0xff
    ld    H, A          ; 1:4       <
    ld    L, A          ; 1:4       <
    pop  DE             ; 1:10      <})dnl
dnl
dnl
dnl # 0<
dnl # ( x1 -- flag )
define({_0LT},{ifelse(TYP_0LT,{small},{
                        ;[4:23]     0<  ( x -- flag x<0 )
    rl    H             ; 2:8       0<
    sbc  HL, HL         ; 2:15      0<}
,{
                        ;[5:20]     0<  ( x -- flag x<0 )
    rl    H             ; 2:8       0<
    sbc   A, A          ; 1:4       0<
    ld    L, A          ; 1:4       0<
    ld    H, A          ; 1:4       0<})})dnl
dnl
dnl
dnl # <=
dnl # ( x2 x1 -- flag )
dnl # signed ( x2 <= x1 ) --> ( x2 - 1 < x1 ) --> ( x2 - x1 - 1 < 0 ) --> carry is true
dnl # signed ( x2 <= x1 ) --> ( 0 <= x1 - x2 ) --> no carry is true
define({LE},{ifelse(TYP_LE,{old},{
                       ;[15:63,62]  <=
    ld    A, H          ; 1:4       <=
    xor   D             ; 1:4       <=
    jp    p, $+7        ; 3:10      <=
    rl    D             ; 2:8       <=  sign x2 = flag
    jr   $+5            ; 2:12      <=
    sbc  HL, DE         ; 2:15      <=  x2<=x1 --> 0<=x2-x1 --> no carry is true
    ccf                 ; 1:4       <=
    sbc  HL, HL         ; 2:15      <=
    pop  DE             ; 1:10      <=},
{
                       ;[13:57]     <=   ( x2 x1 -- flag x2<=x1 )
    ld    A, L          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sub   E             ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    ld    A, H          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sbc   A, D          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    rra                 ; 1:4       <=   carry --> sign
    xor   H             ; 1:4       <=
    xor   D             ; 1:4       <=
    sub  0x80           ; 2:7       <=   sign --> invert carry
    sbc   A, A          ; 1:4       <=   0x00 or 0xff
    ld    H, A          ; 1:4       <=
    ld    L, A          ; 1:4       <=
    pop  DE             ; 1:10      <=})})dnl
dnl
dnl
dnl # >
dnl # ( x2 x1 -- flag )
dnl # signed ( x2 > x1 ) --> ( 0 > x1 - x2 ) --> carry is true
define({GT},{
                       ;[12:54]     >   ( x2 x1 -- flag x2>x1 )
    ld    A, L          ; 1:4       >   DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       >   DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       >   DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       >   DE>HL --> 0>HL-DE --> carry if true
    rra                 ; 1:4       >   carry --> sign
    xor   H             ; 1:4       >
    xor   D             ; 1:4       >
    add   A, A          ; 1:4       >   sign --> carry
    sbc   A, A          ; 1:4       >   0x00 or 0xff
    ld    H, A          ; 1:4       >
    ld    L, A          ; 1:4       >
    pop  DE             ; 1:10      >})dnl
dnl
dnl
dnl # >=
dnl # ( x2 x1 -- flag )
dnl # signed ( x2 >= x1 ) --> ( x2 + 1 > x1 ) --> ( 0 > x1 - x2 - 1 ) --> carry is true
dnl # signed ( x2 >= x1 ) --> ( x2 - x1 >= 0 ) --> no carry is true
define({GE},{ifelse(TYP_GE,{old},{
                       ;[15:63,62]  >=
    ld    A, H          ; 1:4       >=
    xor   D             ; 1:4       >=
    jp    p, $+7        ; 3:10      >=
    rl    H             ; 2:8       >= sign x1 = flag
    jr   $+5            ; 2:12      >=
    scf                 ; 1:4       >=
    sbc  HL, DE         ; 2:15      >=
    sbc  HL, HL         ; 2:15      >=
    pop  DE             ; 1:10      >=},
{
                       ;[13:57]     >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       >=   carry --> sign
    xor   H             ; 1:4       >=
    xor   D             ; 1:4       >=
    sub  0x80           ; 2:7       >=   sign --> invert carry
    sbc   A, A          ; 1:4       >=   0x00 or 0xff
    ld    H, A          ; 1:4       >=
    ld    L, A          ; 1:4       >=
    pop  DE             ; 1:10      >=})})dnl
dnl
dnl
dnl # 0>=
dnl # ( x1 -- flag )
define({_0GE},{
    ld    A, H          ; 1:4       0>=
    sub   0x80          ; 2:7       0>=
    sbc  HL, HL         ; 2:15      0>=
    pop  DE             ; 1:10      0>=})dnl
dnl
dnl # ------------ unsigned ---------------
dnl
dnl # ( x1 x2 -- x )
dnl # equal ( x1 == x2 )
define({UEQ},{EQ})dnl
dnl
dnl # ( x1 x2 -- x )
dnl # not equal ( x1 <> x2 )
define({UNE},{NE})dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # unsigned ( x2 < x1 ) --> ( x2 - x1 < 0 ) --> carry is true
define({ULT},{
                        ;[7:41]     u<
    ld    A, E          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sbc  HL, HL         ; 2:15      u<
    pop  DE             ; 1:10      u<})dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # unsigned ( x2 <= x1 ) --> ( x2 < x1 + 1 ) --> ( x2 - x1 - 1 < 0) --> carry is true
dnl # unsigned ( x2 <= x1 ) --> ( 0 <= x1 - x2 ) --> no carry is true
define({ULE},{
    scf                 ; 1:4       u<=
    ex   DE, HL         ; 1:4       u<=
    sbc  HL, DE         ; 2:15      u<=
    sbc  HL, HL         ; 2:15      u<=
    pop  DE             ; 1:10      u<=})dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # unsigned ( x2 > x1 ) --> ( 0 > x1 - x2 ) --> carry is true
define({UGT},{
    or    A             ; 1:4       u>
    sbc  HL, DE         ; 2:15      u>
    sbc  HL, HL         ; 2:15      u>
    pop  DE             ; 1:10      u>})dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # unsigned ( x2 >= x1 ) --> ( x2 + 1 > x1 ) --> ( 0 > x1 - x2 - 1 ) --> carry is true
define({UGE},{
    scf                 ; 1:4       u>=
    sbc  HL, DE         ; 2:15      u>=
    sbc  HL, HL         ; 2:15      u>=
    pop  DE             ; 1:10      u>=})dnl
dnl
dnl # ------------- single shifts ----------------
dnl
dnl # ( x u -- x)
dnl # shifts x left u places
define({LSHIFT},{ifdef({USE_LSHIFT},,define({USE_LSHIFT},{}))
    call DE_LSHIFT      ; 3:17      <<   ( x1 u -- x1<<u )
    pop  DE             ; 1:10      <<})dnl
dnl
dnl
dnl # ( x u -- x)
dnl # shifts x right u places
define({RSHIFT},{ifdef({USE_RSHIFT},,define({USE_RSHIFT},{}))
    call DE_RSHIFT      ; 3:17      >>   ( x1 u -- x1>>u )
    pop  DE             ; 1:10      >>})dnl
dnl
dnl
dnl # 1 <<
dnl # x 1 lshift
dnl # ( x -- x)
dnl # shifts x left 1 place
define({_1LSHIFT},{
    add  HL, HL         ; 1:11      1 lshift   ( u -- u<<1 )})dnl
dnl
dnl
dnl # 2 <<
dnl # x 2 lshift
dnl # ( x -- x)
dnl # shifts x left 2 places
define({_2LSHIFT},{
    add  HL, HL         ; 1:11      2 lshift   ( u -- u<<2 )
    add  HL, HL         ; 1:11      2 lshift})dnl
dnl
dnl
dnl # 3 <<
dnl # x 3 lshift
dnl # ( x -- x)
dnl # shifts x left 3 places
define({_3LSHIFT},{
    add  HL, HL         ; 1:11      3 lshift   ( u -- u<<3 )
    add  HL, HL         ; 1:11      3 lshift
    add  HL, HL         ; 1:11      3 lshift})dnl
dnl
dnl
dnl # 4 <<
dnl # x 4 lshift
dnl # ( x -- x)
dnl # shifts x left 4 places
define({_4LSHIFT},{
    add  HL, HL         ; 1:11      4 lshift   ( u -- u<<4 )
    add  HL, HL         ; 1:11      4 lshift
    add  HL, HL         ; 1:11      4 lshift
    add  HL, HL         ; 1:11      4 lshift})dnl
dnl
dnl
dnl # 5 <<
dnl # x 5 lshift
dnl # ( x -- x)
dnl # shifts x left 5 places
define({_5LSHIFT},{
    add  HL, HL         ; 1:11      5 lshift   ( u -- u<<5 )
    add  HL, HL         ; 1:11      5 lshift
    add  HL, HL         ; 1:11      5 lshift
    add  HL, HL         ; 1:11      5 lshift
    add  HL, HL         ; 1:11      5 lshift})dnl
dnl
dnl
dnl # 6 <<
dnl # x 6 lshift
dnl # ( x -- x)
dnl # shifts x left 6 places
define({_6LSHIFT},{
                       ;[12:47]     6 lshift   ( u -- u<<6 )
    ld    A, H          ; 1:4       6 lshift
    and   0x03          ; 2:7       6 lshift   .... ..98   7654 3210
    rra                 ; 1:4       6 lshift   .... ...9 8 7654 3210
    rr    L             ; 2:8       6 lshift   .... ...9   8765 4321 0
    rra                 ; 1:4       6 lshift   0... .... 9 8765 4321
    rr    L             ; 2:8       6 lshift   0... ....   9876 5432 1
    rra                 ; 1:4       6 lshift   10.. .... . 9876 5432
    ld    H, L          ; 1:4       6 lshift
    ld    L, A          ; 1:4       6 lshift})dnl
dnl
dnl
dnl # 7 <<
dnl # x 7 lshift
dnl # ( x -- x)
dnl # shifts x left 7 places
define({_7LSHIFT},{
    xor   A             ; 1:4       7 lshift   ( u -- u<<7 )
    srl   H             ; 2:8       7 lshift
    rr    L             ; 2:8       7 lshift
    ld    H, L          ; 1:4       7 lshift
    rra                 ; 1:4       7 lshift
    ld    L, A          ; 1:4       7 lshift})dnl
dnl
dnl
dnl # 8 <<
dnl # x 8 lshift
dnl # ( x -- x)
dnl # shifts x left 8 places
define({_8LSHIFT},{
    ld    H, L          ; 1:4       8 lshift   ( u -- u<<8 )
    ld    L, 0x00       ; 2:7       8 lshift})dnl
dnl
dnl
dnl # 9 <<
dnl # x 9 lshift
dnl # ( x -- x)
dnl # shifts x left 9 places
define({_9LSHIFT},{
    sla   L             ; 2:8       9 lshift   ( u -- u<<9 )
    ld    H, L          ; 1:4       9 lshift
    ld    L, 0x00       ; 2:7       9 lshift})dnl
dnl
dnl
dnl # 10 <<
dnl # x 10 lshift
dnl # ( x -- x)
dnl # shifts x left 10 places
define({_10LSHIFT},{
    ld    A, L          ; 1:4       10 lshift   ( u -- u<<10 )
    add   A, A          ; 1:4       10 lshift
    add   A, A          ; 1:4       10 lshift
    ld    H, A          ; 1:4       10 lshift
    ld    L, 0x00       ; 2:7       10 lshift})dnl
dnl
dnl
dnl # 11 <<
dnl # x 11 lshift
dnl # ( x -- x)
dnl # shifts x left 11 places
define({_11LSHIFT},{
    ld    A, L          ; 1:4       11 lshift   ( u -- u<<11 )
    add   A, A          ; 1:4       11 lshift
    add   A, A          ; 1:4       11 lshift
    add   A, A          ; 1:4       11 lshift
    ld    H, A          ; 1:4       11 lshift
    ld    L, 0x00       ; 2:7       11 lshift})dnl
dnl
dnl
dnl # 12 <<
dnl # x 12 lshift
dnl # ( x -- x)
dnl # shifts x left 12 places
define({_12LSHIFT},{
    ld    A, L          ; 1:4       12 lshift   ( u -- u<<12 )
    add   A, A          ; 1:4       12 lshift
    add   A, A          ; 1:4       12 lshift
    add   A, A          ; 1:4       12 lshift
    add   A, A          ; 1:4       12 lshift
    ld    H, A          ; 1:4       12 lshift
    ld    L, 0x00       ; 2:7       12 lshift})dnl
dnl
dnl
dnl # 13 <<
dnl # x 13 lshift
dnl # ( x -- x)
dnl # shifts x left 13 places
define({_13LSHIFT},{
    ld    A, L          ; 1:4       13 lshift   ( u -- u<<13 )
    rrca                ; 1:4       13 lshift
    rrca                ; 1:4       13 lshift
    rrca                ; 1:4       13 lshift
    and  0xE0           ; 2:7       13 lshift
    ld    H, A          ; 1:4       13 lshift
    ld    L, 0x00       ; 2:7       13 lshift})dnl
dnl
dnl
dnl # 14 <<
dnl # x 14 lshift
dnl # ( x -- x)
dnl # shifts x left 14 places
define({_14LSHIFT},{
    ld    A, L          ; 1:4       14 lshift   ( u -- u<<14 )
    rrca                ; 1:4       14 lshift
    rrca                ; 1:4       14 lshift
    and  0xC0           ; 2:7       14 lshift
    ld    H, A          ; 1:4       14 lshift
    ld    L, 0x00       ; 2:7       14 lshift})dnl
dnl
dnl
dnl # 15 <<
dnl # x 15 lshift
dnl # ( x -- x)
dnl # shifts x left 15 places
define({_15LSHIFT},{
    xor   A             ; 1:4       15 lshift   ( u -- u<<15 )
    rr    L             ; 2:8       15 lshift
    ld    L, A          ; 1:4       15 lshift
    rra                 ; 1:4       15 lshift
    ld    H, A          ; 1:4       15 lshift})dnl
dnl
dnl
dnl # 16 <<
dnl # x 16 lshift
dnl # ( x -- x)
dnl # shifts x left 16 places
define({_16LSHIFT},{
    ld   HL, 0x0000     ; 3:10      16 lshift   ( u -- u<<16 )})dnl
dnl
dnl
dnl
dnl # 1 >>
dnl # x 1 rshift
dnl # ( u -- u )
dnl # shifts u right 1 place
define({_1RSHIFT},{
    srl   H             ; 2:8       1 rshift   ( u -- u>>1 )
    rr    L             ; 2:8       1 rshift})dnl
dnl
dnl
dnl # 2 >>
dnl # x 2 rshift
dnl # ( u -- u )
dnl # shifts u right 2 places
define({_2RSHIFT},{
    srl   H             ; 2:8       2 rshift   ( u -- u>>2 )
    rr    L             ; 2:8       2 rshift
    srl   H             ; 2:8       2 rshift
    rr    L             ; 2:8       2 rshift})dnl
dnl
dnl
dnl # 3 >>
dnl # x 3 rshift
dnl # ( u -- u )
dnl # shifts u right 3 places
define({_3RSHIFT},{
    ld    A, L          ; 1:4       3 rshift   ( u -- u>>3 )
    srl   H             ; 2:8       3 rshift
    rra                 ; 1:4       3 rshift
    srl   H             ; 2:8       3 rshift
    rra                 ; 1:4       3 rshift
    srl   H             ; 2:8       3 rshift
    rra                 ; 1:4       3 rshift
    ld    L, A          ; 1:4       3 rshift})dnl
dnl
dnl
dnl # 4 >>
dnl # x 4 rshift
dnl # ( u -- u )
dnl # shifts u right 4 places
define({_4RSHIFT},{
    ld    A, L          ; 1:4       4 rshift   ( u -- u>>4 )
    srl   H             ; 2:8       4 rshift
    rra                 ; 1:4       4 rshift
    srl   H             ; 2:8       4 rshift
    rra                 ; 1:4       4 rshift
    srl   H             ; 2:8       4 rshift
    rra                 ; 1:4       4 rshift
    srl   H             ; 2:8       4 rshift
    rra                 ; 1:4       4 rshift
    ld    L, A          ; 1:4       4 rshift})dnl
dnl
dnl
dnl
dnl # 5 >>
dnl # u 5 rshift
dnl # ( u -- u )
dnl # shifts u right 5 places
define({_5RSHIFT},{
    xor   A             ; 1:4       5 rshift   ( u -- u>>5 )
    add  HL, HL         ; 1:11      5 rshift
    adc   A, A          ; 1:4       5 rshift
    add  HL, HL         ; 1:11      5 rshift
    adc   A, A          ; 1:4       5 rshift
    add  HL, HL         ; 1:11      5 rshift
    adc   A, A          ; 1:4       5 rshift
    ld    L, H          ; 1:4       5 rshift
    ld    H, A          ; 1:4       5 rshift})dnl
dnl
dnl
dnl
dnl # 6 >>
dnl # u 6 rshift
dnl # ( u -- u )
dnl # shifts u right 6 places
define({_6RSHIFT},{
    xor   A             ; 1:4       6 rshift   ( u -- u>>6 )
    add  HL, HL         ; 1:11      6 rshift
    adc   A, A          ; 1:4       6 rshift
    add  HL, HL         ; 1:11      6 rshift
    adc   A, A          ; 1:4       6 rshift
    ld    L, H          ; 1:4       6 rshift
    ld    H, A          ; 1:4       6 rshift})dnl
dnl
dnl
dnl
dnl # 7 >>
dnl # u 7 rshift
dnl # ( u -- u )
dnl # shifts u right 7 places
define({_7RSHIFT},{
    xor   A             ; 1:4       7 rshift   ( u -- u>>7 )
    add  HL, HL         ; 1:11      7 rshift
    adc   A, A          ; 1:4       7 rshift
    ld    L, H          ; 1:4       7 rshift
    ld    H, A          ; 1:4       7 rshift})dnl
dnl
dnl
dnl # 8 >>
dnl # u 8 rshift
dnl # ( u -- u )
dnl # shifts u right 8 places
define({_8RSHIFT},{
    ld    L, H          ; 1:4       8 rshift   ( u -- u>>8 )
    ld    H, 0x00       ; 2:7       8 rshift})dnl
dnl
dnl
dnl # 9 >>
dnl # u 9 rshift
dnl # ( u -- u )
dnl # shifts u right 9 places
define({_9RSHIFT},{
    srl   H             ; 2:8       9 rshift   ( u -- u>>9 )
    ld    L, H          ; 1:4       9 rshift
    ld    H, 0x00       ; 2:7       9 rshift})dnl
dnl
dnl
dnl # 10 >>
dnl # u 10 rshift
dnl # ( u -- u )
dnl # shifts u right 10 places
define({_10RSHIFT},{
    srl   H             ; 2:8       10 rshift   ( u -- u>>10 )
    srl   H             ; 2:8       10 rshift
    ld    L, H          ; 1:4       10 rshift
    ld    H, 0x00       ; 2:7       10 rshift})dnl
dnl
dnl
dnl # 11 >>
dnl # u 11 rshift
dnl # ( u -- u )
dnl # shifts u right 11 places
define({_11RSHIFT},{
    ld    A, H          ; 1:4       11 rshift   ( u -- u>>11 )
    and  0xF8           ; 2:7       11 rshift
    rrca                ; 1:4       11 rshift
    rrca                ; 1:4       11 rshift
    rrca                ; 1:4       11 rshift
    ld    L, A          ; 1:4       11 rshift
    ld    H, 0x00       ; 2:7       11 rshift})dnl
dnl
dnl
dnl # 12 >>
dnl # u 12 rshift
dnl # ( u -- u )
dnl # shifts u right 12 places
define({_12RSHIFT},{
    ld    A, H          ; 1:4       12 rshift   ( u -- u>>12 )
    and  0xF0           ; 2:7       12 rshift
    rrca                ; 1:4       12 rshift
    rrca                ; 1:4       12 rshift
    rrca                ; 1:4       12 rshift
    rrca                ; 1:4       12 rshift
    ld    L, A          ; 1:4       12 rshift
    ld    H, 0x00       ; 2:7       12 rshift})dnl
dnl
dnl
dnl # 13 >>
dnl # u 13 rshift
dnl # ( u -- u )
dnl # shifts u right 13 places
define({_13RSHIFT},{
    ld    A, H          ; 1:4       13 rshift   ( u -- u>>13 )
    and  0xE0           ; 2:7       13 rshift
    rlca                ; 1:4       13 rshift
    rlca                ; 1:4       13 rshift
    rlca                ; 1:4       13 rshift
    ld    L, A          ; 1:4       13 rshift
    ld    H, 0x00       ; 2:7       13 rshift})dnl
dnl
dnl
dnl # 14 >>
dnl # u 14 rshift
dnl # ( u -- u )
dnl # shifts u right 14 places
define({_14RSHIFT},{
    ld    A, H          ; 1:4       14 rshift   ( u -- u>>14 )
    and  0xC0           ; 2:7       14 rshift
    rlca                ; 1:4       14 rshift
    rlca                ; 1:4       14 rshift
    ld    L, A          ; 1:4       14 rshift
    ld    H, 0x00       ; 2:7       14 rshift})dnl
dnl
dnl
dnl # 15 >>
dnl # u 15 rshift
dnl # ( u -- u )
dnl # shifts u right 15 places
define({_15RSHIFT},{
    xor   A             ; 1:4       15 rshift   ( u -- u>>15 )
    rl    H             ; 2:8       15 rshift
    ld    H, A          ; 1:4       15 rshift
    adc   A, A          ; 1:4       15 rshift
    ld    L, A          ; 1:4       15 rshift})dnl
dnl
dnl
dnl # 16 >>
dnl # u 16 rshift
dnl # ( u -- u )
dnl # shifts u right 16 places
define({_16RSHIFT},{
    ld   HL, 0x0000     ; 3:10      16 rshift   ( u -- u>>16 )})dnl
dnl
dnl
dnl
dnl # ( u -- u )
dnl # shifs u right $1 places
define({PUSH_RSHIFT},{ifelse($1,{},{
__{}__{}    .error {$0}(): Missing address parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}    .error {$0}($@): Pointer as parameter is not supported!},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}    .error {$0}($@): M4 does not know the "{$1}" value and therefore cannot create the code!},
__{}__{}{dnl
__{}__{}__{}ifelse(eval($1),{0},{
__{}__{}__{}                        ;           $1 rshift},
__{}__{}__{}eval($1),{1},{_1RSHIFT},
__{}__{}__{}eval($1),{2},{_2RSHIFT},
__{}__{}__{}eval($1),{3},{_3RSHIFT},
__{}__{}__{}eval($1),{4},{_4RSHIFT},
__{}__{}__{}eval($1),{5},{_5RSHIFT},
__{}__{}__{}eval($1),{6},{_6RSHIFT},
__{}__{}__{}eval($1),{7},{_7RSHIFT},
__{}__{}__{}eval($1),{8},{_8RSHIFT},
__{}__{}__{}eval($1),{9},{_9RSHIFT},
__{}__{}__{}eval($1),{10},{_10RSHIFT},
__{}__{}__{}eval($1),{11},{_11RSHIFT},
__{}__{}__{}eval($1),{12},{_12RSHIFT},
__{}__{}__{}eval($1),{13},{_13RSHIFT},
__{}__{}__{}eval($1),{14},{_14RSHIFT},
__{}__{}__{}eval($1),{15},{_15RSHIFT},
__{}__{}__{}eval($1),{16},{_16RSHIFT},
__{}__{}__{}eval(($1)>15),{1},{
__{}__{}__{}                        ;           $1 rshift --> 16 rshift{}_16RSHIFT},
__{}__{}__{}{
__{}__{}__{}    .error {$0}($@): negative parameters found in macro! Use {PUSH_LSHIFT}(eval(-($1))).})})},
__{}__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!}){}dnl
}){}dnl
dnl
dnl
dnl # ( u -- u )
dnl # shifs u left $1 places
define({PUSH_LSHIFT},{ifelse($1,{},{
__{}__{}    .error {$0}(): Missing address parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}    .error {$0}($@): Pointer as parameter is not supported!},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}    .error {$0}($@): M4 does not know the "{$1}" value and therefore cannot create the code!},
__{}__{}{dnl
__{}__{}__{}ifelse(eval($1),{0},{
__{}__{}__{}                        ;           $1 lshift},
__{}__{}__{}eval($1),{1},{_1LSHIFT},
__{}__{}__{}eval($1),{2},{_2LSHIFT},
__{}__{}__{}eval($1),{3},{_3LSHIFT},
__{}__{}__{}eval($1),{4},{_4LSHIFT},
__{}__{}__{}eval($1),{5},{_5LSHIFT},
__{}__{}__{}eval($1),{6},{_6LSHIFT},
__{}__{}__{}eval($1),{7},{_7LSHIFT},
__{}__{}__{}eval($1),{8},{_8LSHIFT},
__{}__{}__{}eval($1),{9},{_9LSHIFT},
__{}__{}__{}eval($1),{10},{_10LSHIFT},
__{}__{}__{}eval($1),{11},{_11LSHIFT},
__{}__{}__{}eval($1),{12},{_12LSHIFT},
__{}__{}__{}eval($1),{13},{_13LSHIFT},
__{}__{}__{}eval($1),{14},{_14LSHIFT},
__{}__{}__{}eval($1),{15},{_15LSHIFT},
__{}__{}__{}eval($1),{16},{_16LSHIFT},
__{}__{}__{}eval(($1)>16),{1},{
__{}__{}__{}                        ;           $1 lshift --> 16 lshift{}_16LSHIFT},
__{}__{}__{}{
__{}__{}__{}    .error {$0}($@): negative parameters found in macro! Use {PUSH_RSHIFT}(eval(-($1))).})})},
__{}__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # -------------------------- 32 bits --------------------------
dnl
dnl # ------------- double shifts ----------------
dnl
dnl
dnl # ( d1 u -- d )  d = d1 << u
dnl # shifts d1 left u places
define({DLSHIFT},{__def({USE_DLSHIFT})
    call LSHIFT32       ; 3:17      D<<   ( d1 u -- d )  d = d1 << u})dnl
dnl
dnl
dnl
dnl # ( d1 u -- d )  d = d1 << u
dnl # shifts d1 left u places
define({ROT_DLSHIFT},{__def({USE_ROT_DLSHIFT})
    pop  BC             ; 1:10      rot D<<   ( d1 -- d )  d = d1 << BC
    call BC_LSHIFT32    ; 3:17      rot D<<})dnl
dnl
dnl
dnl
dnl # ( d1 u -- d )  d = d1 >> u
dnl # shifts d1 right u places
define({DRSHIFT},{__def({USE_DRSHIFT})
    call RSHIFT32       ; 3:17      D>>   ( d1 u -- d )  d = d1 >> u})dnl
dnl
dnl
dnl
dnl # ( d1 u -- d )  d = d1 >> u
dnl # shifts d1 right u places
define({ROT_DRSHIFT},{__def({USE_ROT_DRSHIFT})
    pop  BC             ; 1:10      rot D>>   ( d1 -- d )  d = d1 >> BC
    call BC_RSHIFT32    ; 3:17      rot D>>})dnl
dnl
dnl
dnl
dnl # ( d1 d2 -- d )
dnl # d = d1 & d2
define({DAND},{
    pop  BC             ; 1:10      dand   ( d2 d1 -- d )  d = d2 & d1
    ld    A, C          ; 1:4       dand
    and   L             ; 1:4       dand
    ld    L, A          ; 1:4       dand
    ld    A, B          ; 1:4       dand
    and   H             ; 1:4       dand
    ld    H, A          ; 1:4       dand
    pop  BC             ; 1:10      dand
    ld    A, C          ; 1:4       dand
    and   E             ; 1:4       dand
    ld    E, A          ; 1:4       dand
    ld    A, B          ; 1:4       dand
    and   D             ; 1:4       dand
    ld    D, A          ; 1:4       dand})dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 & n
define({PUSHDOT_DAND},{ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[20:84]    $1. dand
__{}__{}    ld    A,format({%-12s},(3+$1)); 3:13      $1. dand
__{}__{}    and   D             ; 1:4       $1. dand
__{}__{}    ld    D, A          ; 1:4       $1. dand
__{}__{}    ld    A,format({%-12s},(2+$1)); 3:13      $1. dand
__{}__{}    and   E             ; 1:4       $1. dand
__{}__{}    ld    E, A          ; 1:4       $1. dand
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1. dand
__{}__{}    and   H             ; 1:4       $1. dand
__{}__{}    ld    H, A          ; 1:4       $1. dand
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1. dand
__{}__{}    and   L             ; 1:4       $1. dand
__{}__{}    ld    L, A          ; 1:4       $1. dand},
__IS_NUM($1),{0},{dnl
__{}__{}  .error {$0}($@): M4 does not know the 32-bit value "{$1}"!},
{dnl
__{}__{}define({_TMP_INFO},{$1. dand}){}dnl
__{}__{}__AND_REG16_16BIT({HL},$1){}dnl
__{}__{}__AND_REG16_16BIT({DE},__HEX_DE($1)){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl # ( d1 d2 -- d )
dnl # d = d1 | d2
define({DOR},{
    pop  BC             ; 1:10      dor   ( d2 d1 -- d )  d = d2 | d1
    ld    A, C          ; 1:4       dor
    or    L             ; 1:4       dor
    ld    L, A          ; 1:4       dor
    ld    A, B          ; 1:4       dor
    or    H             ; 1:4       dor
    ld    H, A          ; 1:4       dor
    pop  BC             ; 1:10      dor
    ld    A, C          ; 1:4       dor
    or    E             ; 1:4       dor
    ld    E, A          ; 1:4       dor
    ld    A, B          ; 1:4       dor
    or    D             ; 1:4       dor
    ld    D, A          ; 1:4       dor})dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 | n
define({PUSHDOT_DOR},{ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[20:84]    $1. dor
__{}__{}    ld    A,format({%-12s},(3+$1)); 3:13      $1. dor
__{}__{}    or    D             ; 1:4       $1. dor
__{}__{}    ld    D, A          ; 1:4       $1. dor
__{}__{}    ld    A,format({%-12s},(2+$1)); 3:13      $1. dor
__{}__{}    or    E             ; 1:4       $1. dor
__{}__{}    ld    E, A          ; 1:4       $1. dor
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1. dor
__{}__{}    or    H             ; 1:4       $1. dor
__{}__{}    ld    H, A          ; 1:4       $1. dor
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1. dor
__{}__{}    or    L             ; 1:4       $1. dor
__{}__{}    ld    L, A          ; 1:4       $1. dor},
__IS_NUM($1),{0},{dnl
__{}__{}  .error {$0}($@): M4 does not know the 32-bit value "{$1}"!},
{dnl
__{}__{}define({_TMP_INFO},{$1. dor}){}dnl
__{}__{}__OR_REG16_16BIT({HL},$1){}dnl
__{}__{}__OR_REG16_16BIT({DE},__HEX_DE($1)){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl # ( d1 d2 -- d )
dnl # d = d1 ^ d2
define({DXOR},{
    pop  BC             ; 1:10      dxor   ( d2 d1 -- d )  d = d2 ^ d1
    ld    A, C          ; 1:4       dxor
    xor    L            ; 1:4       dxor
    ld    L, A          ; 1:4       dxor
    ld    A, B          ; 1:4       dxor
    xor    H            ; 1:4       dxor
    ld    H, A          ; 1:4       dxor
    pop  BC             ; 1:10      dxor
    ld    A, C          ; 1:4       dxor
    xor    E            ; 1:4       dxor
    ld    E, A          ; 1:4       dxor
    ld    A, B          ; 1:4       dxor
    xor    D            ; 1:4       dxor
    ld    D, A          ; 1:4       dxor})dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 ^ n
define({PUSHDOT_DXOR},{ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[20:84]    $1. dxor
__{}__{}    ld    A,format({%-12s},(3+$1)); 3:13      $1. dxor
__{}__{}    xor   D             ; 1:4       $1. dxor
__{}__{}    ld    D, A          ; 1:4       $1. dxor
__{}__{}    ld    A,format({%-12s},(2+$1)); 3:13      $1. dxor
__{}__{}    xor   E             ; 1:4       $1. dxor
__{}__{}    ld    E, A          ; 1:4       $1. dxor
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1. dxor
__{}__{}    xor   H             ; 1:4       $1. dxor
__{}__{}    ld    H, A          ; 1:4       $1. dxor
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1. dxor
__{}__{}    xor   L             ; 1:4       $1. dxor
__{}__{}    ld    L, A          ; 1:4       $1. dxor},
__IS_NUM($1),{0},{dnl
__{}__{}  .error {$0}($@): M4 does not know the 32-bit value "{$1}"!},
{dnl
__{}__{}define({_TMP_INFO},{$1. dxor}){}dnl
__{}__{}__XOR_REG16_16BIT({HL},$1){}dnl
__{}__{}__XOR_REG16_16BIT({DE},__HEX_DE($1)){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = ~d1
define({DINVERT},{
    ld    A, L          ; 1:4       dinvert   ( d1 -- d )  d = ~d1
    cpl                 ; 1:4       dinvert
    ld    L, A          ; 1:4       dinvert
    ld    A, H          ; 1:4       dinvert
    cpl                 ; 1:4       dinvert
    ld    H, A          ; 1:4       dinvert
    ld    A, E          ; 1:4       dinvert
    cpl                 ; 1:4       dinvert
    ld    E, A          ; 1:4       dinvert
    ld    A, D          ; 1:4       dinvert
    cpl                 ; 1:4       dinvert
    ld    D, A          ; 1:4       dinvert})dnl
dnl
dnl
dnl # D0=
dnl # ( d -- f )
dnl # if ( x1x2 ) flag = 0; else flag = 0xFFFF;
dnl # 0 if 32-bit number not equal to zero, -1 if equal
define({D0EQ},{ifelse(TYP_D0EQ,{small},{
                        ;[8:54]     D0=   ( hi lo -- flag )   # small version can be changed with "define({TYP_D0EQ},{default})"
    add  HL, DE         ; 1:11      D0=   carry: 0    1
    sbc   A, A          ; 1:4       D0=          0x00 0xff
    or    H             ; 1:4       D0=          H    0xff
    dec  HL             ; 1:6       D0=
    sub   H             ; 1:4       D0=   carry: 1|0  0
    sbc  HL, HL         ; 2:15      D0=   set flag D == 0
    pop   DE            ; 1:10      D0=},
{
                        ;[9:48]     D0=   ( hi lo -- flag )   # fast version can be changed with "define({TYP_D0EQ},{small})"
    ld    A, D          ; 1:4       D0=
    or    E             ; 1:4       D0=
    or    H             ; 1:4       D0=
    or    L             ; 1:4       D0=
    sub   0x01          ; 2:7       D0=
    sbc  HL, HL         ; 2:15      D0=   set flag D == 0
    pop   DE            ; 1:10      D0=})})dnl
dnl
dnl
dnl # D0<
dnl # ( d -- flag )
define({D0LT},{ifelse(TYP_D0LT,{small},{
                        ;[5:34]     D0<   ( hi lo -- flag D<0 )
    rl    D             ; 2:8       D0<
    pop  DE             ; 1:11      D0<
    sbc  HL, HL         ; 2:15      D0<}
,{
                        ;[6:31]     D0<   ( hi lo -- flag D<0 )
    rl    D             ; 2:8       D0<
    pop  DE             ; 1:11      D0<
    sbc   A, A          ; 1:4       D0<
    ld    L, A          ; 1:4       D0<
    ld    H, A          ; 1:4       D0<   set flag D < 0})})dnl
dnl
dnl
dnl # D=
dnl # ( d2 d1 -- flag )
dnl # equal ( d1 == d2 )
define({DEQ},{
                       ;[15:90/69,91]D=  ( d2 d1 -- flag )
    pop  BC             ; 1:10      D=   BC = lo_2
    xor   A             ; 1:4       D=    A = 0x00
    sbc  HL, BC         ; 2:15      D=   HL = lo_1 - lo_2
    pop  HL             ; 1:10      D=   HL = hi_2
    jr   nz, $+7        ; 2:7/12    D=
    sbc  HL, DE         ; 2:15      D=   HL = hi_2 - hi_1
    jr   nz, $+3        ; 2:7/12    D=
    dec   A             ; 1:4       D=    A = 0xFF
    ld    L, A          ; 1:4       D=
    ld    H, A          ; 1:4       D=   HL = flag d2==d1
    pop  DE             ; 1:10      D=})dnl
dnl
dnl
dnl
dnl # $1 D=
dnl # ( d1 -- flag )
dnl # equal ( d1 == $1 )
define({PUSHDOT_DEQ},{ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}                        ;[20:106]   $1. D=   ( d1 -- flag )  flag: d1 == $1
__{}    ld   BC,format({%-12s},$1); 4:20      $1. D=
__{}    xor   A             ; 1:4       $1. D=
__{}    sbc  HL, BC         ; 2:15      $1. D=
__{}    jr   nz, $+10       ; 2:7/12    $1. D=
__{}    ld   HL,format({%-12s},($1+2)); 3:16      $1. D=
__{}    sbc  HL, DE         ; 2:15      $1. D=
__{}    jr   nz, $+3        ; 2:7/12    $1. D=
__{}    dec   A             ; 1:4       $1. D=   A = 0xFF
__{}    ld    L, A          ; 1:4       $1. D=
__{}    ld    H, A          ; 1:4       $1. D=   HL = flag
__{}    pop  DE             ; 1:10      $1. D=},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
{ifelse(eval($1),0,{D0EQ},
__{}__{}{define({_TMP_INFO},{$1. D=}){}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- flag )  flag: d1 == $1}){}__LD_REG16({HL},__HEX_DE($1),{HL},0,{BC},__HEX_HL($1)){}
__{}__{}__DEQ_MAKE_BEST_CODE($1,6,29,0,0){}dnl
__{}__{}define({_TMP_P},eval(59+80+__CLOCKS_16BIT+8*(16+__BYTES_16BIT))){}dnl #     price = 16*(clocks + 4*bytes)
__{}__{}ifelse(eval(8*_TMP_P<_TMP_BEST_P),{1},{
__{}__{}                        ;[eval(16+__BYTES_16BIT):59/eval(80+__CLOCKS_16BIT)] $1. D=   ( d1 -- flag )  flag: d1 == $1
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      $1. D=
__{}__{}    xor   A             ; 1:4       $1. D=
__{}__{}    sbc  HL, BC         ; 2:15      $1. D=
__{}__{}    jr   nz, $+format({%-9s},eval(7+__BYTES_16BIT)); 2:7/12    $1. D={}dnl
__{}__{}__CODE_16BIT
__{}__{}    sbc  HL, DE         ; 2:15      $1. D=
__{}__{}    jr   nz, $+3        ; 2:7/12    $1. D=
__{}__{}    dec   A             ; 1:4       $1. D=   A = 0xFF
__{}__{}    ld    L, A          ; 1:4       $1. D=
__{}__{}    ld    H, A          ; 1:4       $1. D=   HL = flag
__{}__{}    pop  DE             ; 1:10      $1. D=},{
__{}__{}_TMP_BEST_CODE
__{}__{}    sub  0x01           ; 2:7       $1. D=
__{}__{}    sbc   A, A          ; 1:4       $1. D=
__{}__{}    ld    L, A          ; 1:4       $1. D=
__{}__{}    ld    H, A          ; 1:4       $1. D=   HL = flag
__{}__{}    pop  DE             ; 1:10      $1. D=})})})}){}dnl
dnl
dnl
dnl
dnl # Du=
dnl # ( ud2 ud1 -- flag )
dnl # equal ( ud1 == ud2 )
define({DUEQ},{DEQ})dnl
dnl
dnl
dnl # D<>
dnl # ( d2 d1 -- flag )
dnl # not equal ( d1 != d2 )
define({DNE},{
                       ;[15:71,88/83]D<>  ( d2 d1 -- flag )
    pop  BC             ; 1:10      D<>   n h2    . h1 l1  BC= lo(d2) = l2
    xor   A             ; 1:4       D<>   n h2    . h1 l1  A = 0x00
    sbc  HL, BC         ; 2:15      D<>   n h2    . h1 --  HL= l1 - l2
    pop  HL             ; 1:10      D<>   n       . h1 h2  HL= hi(d2) = h2
    jr   nz, $+6        ; 2:7/12    D<>   n       . h1 h2
    sbc  HL, DE         ; 2:15      D<>   n       . h1 h2  HL = h2 - h1
    jr    z, $+5        ; 2:7/12    D<>   n       . h1 h2
    ld   HL, 0xFFFF     ; 3:10      D<>   n       . h1 ff  HL = true
    pop  DE             ; 1:10      D<>           . n  ff})dnl
dnl
dnl
dnl # Du<>
dnl # ( ud2 ud1 -- flag )
dnl # not equal ( ud1 != ud2 )
define({DUNE},{DNE})dnl
dnl
dnl
dnl # D<
dnl # ( d2 d1 -- flag )
dnl # signed ( d2 < d1 ) --> ( d2 - d1 < 0 ) --> carry is true
define({DLT},{ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                        ;[8:62]     D<   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<   l2
    pop  AF             ; 1:10      D<   h2
    call FCE_DLT        ; 3:17      D<   carry if true
    pop  DE             ; 1:10      D<
    sbc  HL, HL         ; 2:15      D<   set flag d2<d1},
{
                       ;[17:93]     D<   ( d2 d1 -- flag )   # fast version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<   lo_2
    ld    A, C          ; 1:4       D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      D<   hi_2
    ld    A, L          ; 1:4       D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    rra                 ; 1:4       D<                                   -->  sign if true
    xor   H             ; 1:4       D<
    xor   D             ; 1:4       D<
    add   A, A          ; 1:4       D<                                   --> carry if true
    sbc  HL, HL         ; 2:15      D<   set flag d2<d1
    pop  DE             ; 1:10      D<})})dnl
dnl
dnl
dnl # Du<
dnl # 2swap Du>
dnl # ( ud2 ud1 -- flag d2<d1 )
dnl # unsigned ( d2 < d1 ) --> ( d2 - d1 < 0 ) --> carry is true
define({DULT},{
                        ;[11:76]    Du<   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du<   lo(ud2)
    ld    A, C          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      Du<   hi(ud2)
    sbc  HL, DE         ; 2:15      Du<   HL<DE --> HL-DE<0 --> carry if true
    sbc  HL, HL         ; 2:15      Du<   set flag ud2<ud1
    pop  DE             ; 1:10      Du<})dnl
dnl
dnl
dnl # D>=
dnl # 2swap D<=
dnl # ( d2 d1 -- flag )
dnl # (d2 >= d1)  -->  (d2 + 1 > d1) -->  (0 > d1 - d2 - 1) -->  carry if true
define({DGE},{ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                        ;[9:66]     D>=   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D>=   l2
    pop  AF             ; 1:10      D>=   h2
    call FCE_DLT        ; 3:17      D>=   D< carry if true --> D>= carry if false
    ccf                 ; 1:4       D>=   invert carry
    pop  DE             ; 1:10      D>=
    sbc  HL, HL         ; 2:15      D>=   set flag d2>=d1},
{
                        ;[16:96]    D>=   ( d2 d1 -- flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      D>=   lo(ud2)
    scf                 ; 1:4       D>=
    sbc  HL, BC         ; 2:15      D>=   BC>=HL --> BC+1>HL --> 0>HL-BC-1 --> carry if true
    pop  HL             ; 1:10      D>=   hi(ud2)
    ld    A, E          ; 1:4       D>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc   A, L          ; 1:4       D>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    ld    A, D          ; 1:4       D>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc   A, H          ; 1:4       D>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    rra                 ; 1:4       D>=                                    -->  sign if true
    xor   H             ; 1:4       D>=
    xor   D             ; 1:4       D>=
    add   A, A          ; 1:4       D>=                                    --> carry if true
    sbc  HL, HL         ; 2:15      D>=   set flag d2>=d1
    pop  DE             ; 1:10      D>=})})dnl
dnl
dnl
dnl # Du>=
dnl # 2swap Du<=
dnl # ( ud2 ud1 -- flag )
dnl # (ud2 >= ud1)  -->  (ud2 + 1 > ud1) -->  (0 > ud1 - ud2 - 1) -->  carry if true
define({DUGE},{
                        ;[12:80]    Du>=   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du>=   lo(ud2)
    scf                 ; 1:4       Du>=
    sbc  HL, BC         ; 2:15      Du>=   BC>=HL --> BC+1>HL --> 0>HL-BC-1 --> carry if true
    pop  HL             ; 1:10      Du>=   hi(ud2)
    ld    A, E          ; 1:4       Du>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc   A, L          ; 1:4       Du>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    ld    A, D          ; 1:4       Du>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc   A, H          ; 1:4       Du>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc  HL, HL         ; 2:15      Du>=   set flag ud2>=ud1
    pop  DE             ; 1:10      Du>=})dnl
dnl
dnl
dnl # D<=
dnl # 2swap D>=
dnl # ( d2 d1 -- f )
define({DLE},{ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                        ;[9:66]     D<=   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<=   l2
    pop  AF             ; 1:10      D<=   h2
    call FCE_DGT        ; 3:17      D<=   D> carry if true --> D<= carry if false
    ccf                 ; 1:4       D<=   invert carry
    pop  DE             ; 1:10      D<=
    sbc  HL, HL         ; 2:15      D<=   set flag d2<=d1},
{
                       ;[18:97]     D<=   ( d2 d1 -- flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      D<=   lo_2
    ld    A, L          ; 1:4       D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sub   C             ; 1:4       D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ld    A, H          ; 1:4       D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sbc   A, B          ; 1:4       D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  HL             ; 1:10      D<=   hi_2
    ld    A, E          ; 1:4       D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    sbc   A, L          ; 1:4       D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    ld    A, D          ; 1:4       D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    sbc   A, H          ; 1:4       D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    rra                 ; 1:4       D<=                                      --> no sign  if true
    xor   B             ; 1:4       D<=
    xor   D             ; 1:4       D<=
    add   A, A          ; 1:4       D<=                                      --> no carry if true
    ccf                 ; 1:4       D<=                                      --> carry    if true
    sbc  HL, HL         ; 2:15      D<=   set flag d2<d1
    pop  DE             ; 1:10      D<=})})dnl
dnl
dnl
dnl # Du<=
dnl # 2swap Du>=
dnl # ( ud2 ud1 -- flag )
dnl # (ud2 <= ud1)  -->  (ud2 < ud1 + 1) -->  (ud2 - ud1 - 1 < 0) -->  carry if true
define({DULE},{
                        ;[12:80]    Du<=   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du<=   lo(ud2)
    scf                 ; 1:4       Du<=
    ld    A, C          ; 1:4       Du<=   BC<=HL --> BC<HL+1 --> BC-HL-1<0 --> carry if true
    sbc   A, L          ; 1:4       Du<=   BC<=HL --> BC<HL+1 --> BC-HL-1<0 --> carry if true
    ld    A, B          ; 1:4       Du<=   BC<=HL --> BC<HL+1 --> BC-HL-1<0 --> carry if true
    sbc   A, H          ; 1:4       Du<=   BC<=HL --> BC<HL+1 --> BC-HL-1<0 --> carry if true
    pop  HL             ; 1:10      Du<=   hi(ud2)
    sbc  HL, DE         ; 2:15      Du<=   HL<=DE --> HL<DE+1 --> HL-DE-1<0 --> carry if true
    sbc  HL, HL         ; 2:15      Du<=   set flag ud2<=ud1
    pop  DE             ; 1:10      Du<=})dnl
dnl
dnl
dnl # D>
dnl # 2swap D<
dnl # ( d2 d1 -- flag )
define({DGT},{ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                        ;[8:62]     D>   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D>   l2
    pop  AF             ; 1:10      D>   h2
    call FCE_DGT        ; 3:17      D>   carry if true
    pop  DE             ; 1:10      D>
    sbc  HL, HL         ; 2:15      D>   set flag d2>d1},
{
                        ;[17:93]    D>   ( d2 d1 -- flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D>   lo(ud2)
    ld    A, L          ; 1:4       D>   BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       D>   BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       D>   BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       D>   BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      D>   hi(ud2)
    ld    A, E          ; 1:4       D>   BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       D>   BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       D>   BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       D>   BC>DE --> 0>DE-BC --> carry if true
    rra                 ; 1:4       D>                     --> sign  if true
    xor   B             ; 1:4       D>
    xor   D             ; 1:4       D>
    add   A, A          ; 1:4       D>                     --> carry if true
    sbc  HL, HL         ; 2:15      D>   set flag d2>d1
    pop  DE             ; 1:10      D>})})dnl
dnl
dnl
dnl # Du>
dnl # 2swap Du<
dnl # ( ud2 ud1 -- flag )
define({DUGT},{
                        ;[13:77]    Du>   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du>   lo(ud2)
    ld    A, L          ; 1:4       Du>   BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       Du>   BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       Du>   BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       Du>   BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      Du>   hi(ud2)
    ld    A, E          ; 1:4       Du>   BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       Du>   BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       Du>   BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       Du>   BC>DE --> 0>DE-BC --> carry if true
    sbc  HL, HL         ; 2:15      Du>   set flag ud2>ud1
    pop  DE             ; 1:10      Du>})dnl
dnl
dnl
dnl
dnl # 4dup D=
dnl # ( d d -- d d f )
define({_4DUP_DEQ},{
                       ;[20:138/-21,+1] 4dup D=   ( d2 d1 -- d2 d1 flag )
    pop  AF             ; 1:10      4dup D=   h2          . h1 l1  AF= lo(d2) = l2
    pop  BC             ; 1:10      4dup D=               . h1 l1  BC= hi(d2) = h2
    push BC             ; 1:11      4dup D=   h2          . h1 l1
    push AF             ; 1:11      4dup D=   h2 l2       . h1 l1
    push DE             ; 1:11      4dup D=   h2 l2 h1    . h1 l1
    push AF             ; 1:11      4dup D=   h2 l2 h1 l2 . h1 l1
    ex   DE, HL         ; 1:4       4dup D=   h2 l2 h1 l2 . l1 h1
    xor   A             ; 1:4       4dup D=   h2 l2 h1 l2 . l1 h1  A = 0x00
    sbc  HL, BC         ; 2:15      4dup D=   h2 l2 h1 l2 . l1 --  hi(d1)-hi(d2)
    pop  HL             ; 1:10      4dup D=   h2 l2 h1    . l1 l2
    jr   nz, $+7        ; 2:7/12    4dup D=   h2 l2 h1    . l1 l2
    sbc  HL, DE         ; 2:15      4dup D=   h2 l2 h1    . l1 --  lo(d2)-lo(d1)
    jr   nz, $+3        ; 2:7/12    4dup D=   h2 l2 h1    . l1 --
    dec   A             ; 1:4       4dup D=   h2 l2 h1    . l1 --  A = 0xFF
    ld    L, A          ; 1:4       4dup D=   h2 l2 h1    . l1 -f
    ld    H, A          ; 1:4       4dup D=   h2 l2 h1    . l1 ff  HL= flag d2==d1})dnl
dnl
dnl
dnl
dnl # 4dup Du=
dnl # ( ud2 ud1 -- ud2 ud1 flag )
dnl # equal ( ud1 == ud2 )
define({_4DUP_DUEQ},{_4DUP_DEQ})dnl
dnl
dnl
dnl
dnl # 4dup D<>
dnl # ( d d -- d d f )
define({_4DUP_DNE},{ifelse(_TYP_DOUBLE,{fast},{
            ;[26:71,86,143,149/147] 4dup D<>   ( d2 d1 -- d2 d1 flag )   # fast version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup D<>   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<>   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<>   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+16       ; 2:7/12    4dup D<>   h2       . h1 l1  --> A = 0xFF
    ld    A, B          ; 1:4       4dup D<>   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<>   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+12       ; 2:7/12    4dup D<>   h2       . h1 l1  --> A = 0xFF
    ex (SP), HL         ; 1:19      4dup D<>   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<>   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<>   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<>   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<>   h2       . h1 l1
    jr   nz, $+5        ; 2:7/12    4dup D<>   h2       . h1 l1  --> A = 0xFF
    sub   D             ; 1:4       4dup D<>   h2       . h1 l1  hi(h2) - hi(h1)
    jr    z, $+4        ; 2:7/12    4dup D<>   h2       . h1 l1  --> A = 0
    ld    A, 0xFF       ; 2:7       4dup D<>   h2       . h1 l1
    push BC             ; 1:11      4dup D<>   h2 l2    . h1 l1
    push DE             ; 1:11      4dup D<>   h2 l2 h1 . h1 l1
    ex   DE, HL         ; 1:4       4dup D<>   h2 l2 h1 . l1 h1
    ld    H, A          ; 1:4       4dup D<>   h2 l2 h1 . l1 f-
    ld    L, A          ; 1:4       4dup D<>   h2 l2 h1 . l1 ff HL= flag d2<>d1},
{
                  ;[20:119,136/131] 4dup D<>   ( d2 d1 -- d2 d1 flag )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  AF             ; 1:10      4dup D<>   h2          . h1 l1  AF = lo(d2) = l2
    pop  BC             ; 1:10      4dup D<>               . h1 l1  BC = hi(d2) = h2
    push BC             ; 1:11      4dup D<>   h2          . h1 l1
    push AF             ; 1:11      4dup D<>   h2 l2       . h1 l1
    push DE             ; 1:11      4dup D<>   h2 l2 h1    . h1 l1
    push AF             ; 1:11      4dup D<>   h2 l2 h1 l2 . h1 l1
    ex   DE, HL         ; 1:4       4dup D<>   h2 l2 h1 l2 . l1 h1
    xor   A             ; 1:4       4dup D<>   h2 l2 h1 l2 . l1 h1
    sbc  HL, BC         ; 2:15      4dup D<>   h2 l2 h1 l2 . l1 --  hi(d1)-hi(d2)
    pop  HL             ; 1:10      4dup D<>   h2 l2 h1    . l1 l2
    jr   nz, $+6        ; 2:7/12    4dup D<>   h2 l2 h1    . l1 l2
    sbc  HL, DE         ; 2:15      4dup D<>   h2 l2 h1    . l1 --  lo(d2)-lo(d1)
    jr    z, $+5        ; 2:7/12    4dup D<>   h2 l2 h1    . l1 --
    ld   HL, 0xFFFF     ; 3:10      4dup D<>   h2 l2 h1    . l1 ff  HL= flag d2<>d1})})dnl
dnl
dnl
dnl
dnl # 4dup Du<>
dnl # ( ud2 ud1 -- ud2 ud1 flag )
dnl # not equal ( ud1 <> ud2 )
define({_4DUP_DUNE},{_4DUP_DNE})dnl
dnl
dnl
dnl
dnl # 4dup D<
dnl # ( d d -- d d f )
define({_4DUP_DLT},{ifelse(_TYP_DOUBLE,{function},{define({USE_FCE_4DUP_DLT},{yes})
                        ;[7:201]    4dup D<   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    call FCE_4DUP_DLT   ; 3:17      4dup D<   carry if true
    push DE             ; 1:11      4dup D<
    ex   DE, HL         ; 1:4       4dup D<
    sbc  HL, HL         ; 2:15      4dup D<   set flag d2<d1},
{
                       ;[20:137]    4dup D<   ( d2 d1 -- d2 d1 flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup D<   lo_2
    ld    A, C          ; 1:4       4dup D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       4dup D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       4dup D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       4dup D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ex (SP), HL         ; 1:19      4dup D<   hi_2
    ld    A, L          ; 1:4       4dup D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       4dup D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       4dup D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       4dup D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    rra                 ; 1:4       4dup D<                                   -->  sign if true
    xor   H             ; 1:4       4dup D<
    xor   D             ; 1:4       4dup D<
    add   A, A          ; 1:4       4dup D<                                   --> carry if true
    ex (SP), HL         ; 1:19      4dup D<   lo_1
    push BC             ; 1:11      4dup D<
    push DE             ; 1:11      4dup D<
    ex   DE, HL         ; 1:4       4dup D<
    sbc  HL, HL         ; 2:15      4dup D<   set flag d2<d1})})dnl
dnl
dnl
dnl
dnl # 4dup Du<
dnl # ( ud ud -- ud ud f )
define({_4DUP_DULT},{
                       ;[16:121]    4dup Du<   ( ud2 ud1 -- ud2 ud1 flag )
    pop  BC             ; 1:10      4dup Du<   lo_2
    ld    A, C          ; 1:4       4dup Du<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       4dup Du<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       4dup Du<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       4dup Du<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ex (SP), HL         ; 1:19      4dup Du<   hi_2
    ld    A, L          ; 1:4       4dup Du<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       4dup Du<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       4dup Du<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       4dup Du<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ex (SP), HL         ; 1:19      4dup Du<   lo_1
    push BC             ; 1:11      4dup Du<
    push DE             ; 1:11      4dup Du<
    ex   DE, HL         ; 1:4       4dup Du<
    sbc  HL, HL         ; 2:15      4dup Du<   set flag ud2<ud1})dnl
dnl
dnl
dnl
dnl # 4dup D>=
dnl # ( d d -- d d f )
define({_4DUP_DGE},{ifelse(_TYP_DOUBLE,{function},{define({USE_FCE_4DUP_DLT},{yes})
                        ;[8:51]     4dup D>=   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    call FCE_4DUP_DLT   ; 3:17      4dup D>=   D< carry if true --> D>= carry if false
    ccf                 ; 1:4       4dup D>=   invert carry
    push DE             ; 1:11      4dup D>=
    ex   DE, HL         ; 1:4       4dup D>=
    sbc  HL, HL         ; 2:15      4dup D>=   set flag d2<=d1},
{
                       ;[21:141]    4dup D>=   ( d2 d1 -- d2 d1 flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup D>=   lo_2
    ld    A, C          ; 1:4       4dup D>=   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sub   L             ; 1:4       4dup D>=   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ld    A, B          ; 1:4       4dup D>=   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       4dup D>=   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ex (SP), HL         ; 1:19      4dup D>=   hi_2
    ld    A, L          ; 1:4       4dup D>=   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, E          ; 1:4       4dup D>=   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    ld    A, H          ; 1:4       4dup D>=   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, D          ; 1:4       4dup D>=   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    rra                 ; 1:4       4dup D>=                                      --> no sign  if true
    xor   H             ; 1:4       4dup D>=
    xor   D             ; 1:4       4dup D>=
    add   A, A          ; 1:4       4dup D>=                                      --> no carry if true
    ccf                 ; 1:4       4dup D>=                                      --> carry    if true
    ex (SP), HL         ; 1:19      4dup D>=   lo_1
    push BC             ; 1:11      4dup D>=
    push DE             ; 1:11      4dup D>=
    ex   DE, HL         ; 1:4       4dup D>=
    sbc  HL, HL         ; 2:15      4dup D>=   set flag d2>=d1})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du>=
dnl # ( ud ud -- ud ud f )
define({_4DUP_DUGE},{
                       ;[17:125]    4dup Du>=   ( ud2 ud1 -- ud2 ud1 flag )
    pop  BC             ; 1:10      4dup Du>=   lo_2
    ld    A, C          ; 1:4       4dup Du>=   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sub   L             ; 1:4       4dup Du>=   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ld    A, B          ; 1:4       4dup Du>=   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       4dup Du>=   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ex (SP), HL         ; 1:19      4dup Du>=   hi_2
    ld    A, L          ; 1:4       4dup Du>=   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, E          ; 1:4       4dup Du>=   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    ld    A, H          ; 1:4       4dup Du>=   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, D          ; 1:4       4dup Du>=   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    ccf                 ; 1:4       4dup Du>=                                      --> carry    if true
    ex (SP), HL         ; 1:19      4dup Du>=   lo_1
    push BC             ; 1:11      4dup Du>=
    push DE             ; 1:11      4dup Du>=
    ex   DE, HL         ; 1:4       4dup Du>=
    sbc  HL, HL         ; 2:15      4dup Du>=   set flag ud2>=ud1})dnl
dnl
dnl
dnl
dnl # 4dup D<=
dnl # ( d d -- d d f )
define({_4DUP_DLE},{ifelse(_TYP_DOUBLE,{function},{define({USE_FCE_4DUP_DGT},{yes})
                        ;[8:51]     4dup D<=   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    call FCE_4DUP_DGT   ; 3:17      4dup D<=   D> carry if true --> D<= carry if false
    ccf                 ; 1:4       4dup D<=   invert carry
    push DE             ; 1:11      4dup D<=
    ex   DE, HL         ; 1:4       4dup D<=
    sbc  HL, HL         ; 2:15      4dup D<=   set flag d2<=d1},
{
                       ;[21:141]    4dup D<=   ( d2 d1 -- d2 d1 flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup D<=   lo_2
    ld    A, L          ; 1:4       4dup D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sub   C             ; 1:4       4dup D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ld    A, H          ; 1:4       4dup D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sbc   A, B          ; 1:4       4dup D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ex (SP), HL         ; 1:19      4dup D<=   hi_2
    ld    A, E          ; 1:4       4dup D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    sbc   A, L          ; 1:4       4dup D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    ld    A, D          ; 1:4       4dup D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    sbc   A, H          ; 1:4       4dup D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    rra                 ; 1:4       4dup D<=                                      --> no sign  if true
    xor   B             ; 1:4       4dup D<=
    xor   D             ; 1:4       4dup D<=
    add   A, A          ; 1:4       4dup D<=                                      --> no carry if true
    ccf                 ; 1:4       4dup D<=                                      --> carry    if true
    ex (SP), HL         ; 1:19      4dup D<=   lo_1
    push BC             ; 1:11      4dup D<=
    push DE             ; 1:11      4dup D<=
    ex   DE, HL         ; 1:4       4dup D<=
    sbc  HL, HL         ; 2:15      4dup D<=   set flag d2<=d1})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du<=
dnl # ( ud ud -- ud ud f )
define({_4DUP_DULE},{
                       ;[17:125]    4dup Du<=   ( ud2 ud1 -- ud2 ud1 flag )
    pop  BC             ; 1:10      4dup Du<=   lo_2
    ld    A, L          ; 1:4       4dup Du<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sub   C             ; 1:4       4dup Du<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ld    A, H          ; 1:4       4dup Du<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sbc   A, B          ; 1:4       4dup Du<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ex (SP), HL         ; 1:19      4dup Du<=   hi_2
    ld    A, E          ; 1:4       4dup Du<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    sbc   A, L          ; 1:4       4dup Du<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    ld    A, D          ; 1:4       4dup Du<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    sbc   A, H          ; 1:4       4dup Du<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    ccf                 ; 1:4       4dup Du<=                                      --> carry    if true
    ex (SP), HL         ; 1:19      4dup Du<=   lo_1
    push BC             ; 1:11      4dup Du<=
    push DE             ; 1:11      4dup Du<=
    ex   DE, HL         ; 1:4       4dup Du<=
    sbc  HL, HL         ; 2:15      4dup Du<=   set flag ud2<=ud1}){}dnl
dnl
dnl
dnl
dnl # 4dup D>
dnl # ( d d -- d d f )
define({_4DUP_DGT},{ifelse(_TYP_DOUBLE,{function},{define({USE_FCE_4DUP_DGT},{yes})
                        ;[7:201]    4dup D>   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    call FCE_4DUP_DGT   ; 3:17      4dup D>   carry if true
    push DE             ; 1:11      4dup D>
    ex   DE, HL         ; 1:4       4dup D>
    sbc  HL, HL         ; 2:15      4dup D>   set flag d2>d1},
{
                       ;[20:137]    4dup D>   ( d2 d1 -- d2 d1 flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup D>   lo_2
    ld    A, L          ; 1:4       4dup D>   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       4dup D>   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       4dup D>   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       4dup D>   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    ex (SP), HL         ; 1:19      4dup D>   hi_2
    ld    A, E          ; 1:4       4dup D>   hi_2>hi_1 --> HL>DE --> 0>DE-HL --> carry if true
    sbc   A, L          ; 1:4       4dup D>   hi_2>hi_1 --> HL>DE --> 0>DE-HL --> carry if true
    ld    A, D          ; 1:4       4dup D>   hi_2>hi_1 --> HL>DE --> 0>DE-HL --> carry if true
    sbc   A, H          ; 1:4       4dup D>   hi_2>hi_1 --> HL>DE --> 0>DE-HL --> carry if true
    rra                 ; 1:4       4dup D>                                   --> sign  if true
    xor   B             ; 1:4       4dup D>
    xor   D             ; 1:4       4dup D>
    add   A, A          ; 1:4       4dup D>                                   --> carry if true
    ex (SP), HL         ; 1:19      4dup D>   lo_1
    push BC             ; 1:11      4dup D>
    push DE             ; 1:11      4dup D>
    ex   DE, HL         ; 1:4       4dup D>
    sbc  HL, HL         ; 2:15      4dup D>   set flag d2>d1})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du>
dnl # ( ud ud -- ud ud f )
define({_4DUP_DUGT},{
                       ;[16:121]    4dup Du>   ( ud2 ud1 -- ud2 ud1 flag )
    pop  BC             ; 1:10      4dup Du>   lo_2
    ld    A, L          ; 1:4       4dup Du>   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       4dup Du>   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       4dup Du>   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       4dup Du>   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    ex (SP), HL         ; 1:19      4dup Du>   hi_2
    ld    A, E          ; 1:4       4dup Du>   hi_2>hi_1 --> HL>DE --> 0>DE-HL --> carry if true
    sbc   A, L          ; 1:4       4dup Du>   hi_2>hi_1 --> HL>DE --> 0>DE-HL --> carry if true
    ld    A, D          ; 1:4       4dup Du>   hi_2>hi_1 --> HL>DE --> 0>DE-HL --> carry if true
    sbc   A, H          ; 1:4       4dup Du>   hi_2>hi_1 --> HL>DE --> 0>DE-HL --> carry if true
    ex (SP), HL         ; 1:19      4dup Du>   lo_1
    push BC             ; 1:11      4dup Du>
    push DE             ; 1:11      4dup Du>
    ex   DE, HL         ; 1:4       4dup Du>
    sbc  HL, HL         ; 2:15      4dup Du>   set flag ud2>ud1}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D=
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DEQ},{dnl
__{}define({_TMP_INFO},{2dup $1 D=})dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 flag )   __HEX_DEHL($1) == DEHL})dnl
__{}ifelse($1,{},{
__{}__{}    .error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                        ;[21:111]   _TMP_INFO    ( d1 -- d1 flag )
__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld   BC,format({%-12s},($1+2)); 4:20      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO   hi16(d1)-BC
__{}__{}__{}    jr   nz, $+10       ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL, format({%-11s},$1); 3:16      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    jr   nz, $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   A = 0xFF = true
__{}__{}__{}    ld    L, A          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    H, A          ; 1:4       _TMP_INFO   set flag d1==$1},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__{}__DEQ_MAKE_BEST_CODE($1,6,37,0,0){}dnl
__{}__{}__{}__DEQ_MAKE_HLDE_CODE($1,10){}dnl
__{}__{}__{}define({_TMP_B},eval(_TMP_B+5)){}dnl
__{}__{}__{}ifelse(_TMP_ZERO,{1},{dnl
__{}__{}__{}__{}define({_TMP_J},eval(_TMP_J+8)){}dnl #    false
__{}__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+20)){}dnl # false2
__{}__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+19)){}dnl # true
__{}__{}__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}__{}__{}                     ;[_TMP_B:_TMP_NJ/_TMP_J/_TMP_J2] _TMP_INFO   ( d1 -- d1 flag )
__{}__{}__{}__{}__{}}_TMP_HLDE_CODE{
__{}__{}__{}__{}__{}    jr   nz, $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   A = 0xFF = true
__{}__{}__{}__{}__{}    ld    L, A          ; 1:4       _TMP_INFO
__{}__{}__{}__{}__{}    ld    H, A          ; 1:4       _TMP_INFO   set flag d1==$1})},
__{}__{}__{}{dnl
__{}__{}__{}__{}define({_TMP_J},eval(_TMP_J+15)){}dnl #   false
__{}__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+27)){}dnl # false2
__{}__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+26)){}dnl # true
__{}__{}__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}__{}__{}                     ;[_TMP_B:_TMP_NJ/_TMP_J,_TMP_J2] _TMP_INFO   ( d1 -- d1 flag )
__{}__{}__{}__{}__{}}_TMP_HLDE_CODE{
__{}__{}__{}__{}__{}    jr   nz, $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}__{}__{}    scf                 ; 1:4       _TMP_INFO
__{}__{}__{}__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag d1==$1})}){}dnl
__{}__{}__{}define({_TMP_P},eval(8*_TMP_NJ+4*_TMP_J+4*_TMP_J2+64*_TMP_B)){}dnl #     price = 16*(clocks + 4*bytes)
__{}__{}__{}define({_TMP},eval(_TMP_BEST_P<=_TMP_P)){}dnl
__{}__{}__{}ifelse(_TMP,{0},{
__{}__{}__{}__{}if 0
__{}__{}__{}__{}; price: _TMP_BEST_P})
__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}    sub 0x01            ; 2:7       _TMP_INFO
__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag d1==$1{}dnl
__{}__{}__{}ifelse(_TMP,{0},{
__{}__{}__{}__{}else
__{}__{}__{}__{}; price: _TMP_P
__{}__{}__{}__{}_TMP_HLDE_CODE
__{}__{}__{}__{}endif})})},
__{}{
__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D<>
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DNE},{dnl
__{}define({_TMP_INFO},{2dup $1 D<>})dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 flag )   __HEX_DEHL($1) <> DEHL})dnl
__{}ifelse($1,{},{
__{}__{}    .error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                        ;[21:109]   _TMP_INFO    ( d1 -- d1 flag )
__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld   BC,format({%-12s},($1+2)); 4:20      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO   hi16(d1)-BC
__{}__{}__{}    jr   nz, $+9        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL, format({%-11s},$1); 3:16      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    jr    z, $+5        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL, 0xFFFF     ; 3:10      _TMP_INFO   set flag d1<>$1},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__{}__DEQ_MAKE_BEST_CODE($1,6,37,0,0){}dnl
__{}__{}__{}__DEQ_MAKE_HLDE_CODE($1,9){}dnl
__{}__{}__{}define({_TMP_B},eval(_TMP_B+5)){}dnl
__{}__{}__{}define({_TMP_J},eval(_TMP_J+10)){}dnl
__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+12)){}dnl
__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+17)){}dnl
__{}__{}__{}define({_TMP_P},eval(8*_TMP_J2+4*_TMP_NJ+4*_TMP_J+64*_TMP_B)){}dnl #     price = 16*(clocks + 4*bytes)
__{}__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}__{}                     ;[_TMP_B:_TMP_J,_TMP_NJ/_TMP_J2] _TMP_INFO   ( d1 -- d1 flag )
__{}__{}__{}__{}}_TMP_HLDE_CODE{
__{}__{}__{}__{}    jr    z, $+5        ; 2:7/12    _TMP_INFO
__{}__{}__{}__{}    ld   HL, 0xFFFF     ; 3:10      _TMP_INFO   set flag d1<>$1}){}dnl
__{}__{}__{}define({_TMP},eval(_TMP_BEST_P<=_TMP_P)){}dnl
__{}__{}__{}ifelse(_TMP,{0},{
__{}__{}__{}__{}if 0
__{}__{}__{}__{}; price: _TMP_BEST_P})
__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    add   A, 0xFF       ; 2:7       _TMP_INFO
__{}__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag d1==$1{}dnl
__{}__{}__{}ifelse(_TMP,{0},{
__{}__{}__{}__{}else
__{}__{}__{}__{}; price: _TMP_P
__{}__{}__{}__{}_TMP_HLDE_CODE
__{}__{}__{}__{}endif})})},
__{}{
__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D>
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DGT},{ifelse($1,{},{
    .error {$0}(): Missing parameter!},
$#,{1},{ifelse(__IS_MEM_REF($1),{1},{
__{}                        ;[24:116]   2dup $1 D>    ( d1 -- d1 flag )
__{}    ld    A, format({%-11s},$1); 3:13      2dup $1 D>    DEHL>$1     $1 = ...A
__{}    sub   L             ; 1:4       2dup $1 D>    DEHL>$1 --> 0>A-DEHL --> carry if true
__{}    ld    A,format({%-12s},($1+1)); 3:13      2dup $1 D>    DEHL>$1     $1 = ..A.
__{}    sbc   A, H          ; 1:4       2dup $1 D>    DEHL>$1 --> 0>A-DEHL --> carry if true
__{}    ld   BC,format({%-12s},($1+2)); 4:20      2dup $1 D>    DEHL>$1     $1 = BC..
__{}    ld    A, C          ; 1:4       2dup $1 D>    DEHL>$1     $1 = .A..
__{}    sbc   A, E          ; 1:4       2dup $1 D>    DEHL>$1 --> 0>A-DEHL --> carry if true
__{}    ld    A, B          ; 1:4       2dup $1 D>    DEHL>$1     $1 = A...
__{}    sbc   A, D          ; 1:4       2dup $1 D>    DEHL>$1 --> 0>A-DEHL --> carry if true
__{}    rra                 ; 1:4       2dup $1 D>    DEHL>$1              --> sign  if true
__{}    xor   D             ; 1:4       2dup $1 D>
__{}    xor   B             ; 1:4       2dup $1 D>
__{}    add   A, A          ; 1:4       2dup $1 D>    DEHL>$1              --> carry if true
__{}    push DE             ; 1:11      2dup $1 D>
__{}    ex   DE, HL         ; 1:4       2dup $1 D>
__{}    sbc  HL, HL         ; 2:15      2dup $1 D>    set flag d1>$1},
__{}__IS_NUM($1),{0},{
__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}{
__{}                       ;[21:92]     2dup $1 D>   ( d1 -- d1 flag )   # default version
__{}    ld    A, D          ; 1:4       2dup $1 D>
__{}    sub  0x80           ; 2:7       2dup $1 D>{}ifelse(eval((($1) & 0x80000000) - 0x80000000),0,{
__{}__{}    jr    c, $+14       ; 2:7/12    2dup $1 D>   positive d1 > negative constant --> true},
__{}__{}{
__{}__{}    jr   nc, $+14       ; 2:7/12    2dup $1 D>   negative d1 > positive constant --> false})
__{}    ld    A, __HEX_L($1)       ; 2:7       2dup $1 D>   DEHL>$1     $1 = ...A
__{}    sub   L             ; 1:4       2dup $1 D>   DEHL>$1 --> 0>A-DEHL --> carry if true
__{}    ld    A, __HEX_H($1)       ; 2:7       2dup $1 D>   DEHL>$1     $1 = ..A.
__{}    sbc   A, H          ; 1:4       2dup $1 D>   DEHL>$1 --> 0>A-DEHL --> carry if true
__{}    ld    A, __HEX_E($1)       ; 2:7       2dup $1 D>   DEHL>$1     $1 = .A..
__{}    sbc   A, E          ; 1:4       2dup $1 D>   DEHL>$1 --> 0>A-DEHL --> carry if true
__{}    ld    A, __HEX_D($1)       ; 2:7       2dup $1 D>   DEHL>$1     $1 = A...
__{}    sbc   A, D          ; 1:4       2dup $1 D>   DEHL>$1 --> 0>A-DEHL --> carry if true
__{}    push DE             ; 1:11      2dup $1 D>
__{}    ex   DE, HL         ; 1:4       2dup $1 D>
__{}    sbc  HL, HL         ; 2:15      2dup $1 D>   set flag d1>$1})},
{
    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D<=
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DLE},{ifelse($1,{},{
    .error {$0}(): Missing parameter!},
$#,{1},{ifelse(__IS_MEM_REF($1),{1},{
__{}                        ;[25:119]   2dup $1 D<=    ( d1 -- d1 flag )
__{}    ld    A, format({%-11s},$1); 3:13      2dup $1 D<=    DEHL<=$1     $1 = ...A
__{}    sub   L             ; 1:4       2dup $1 D<=    DEHL<=$1 --> 0<=A-DEHL --> no carry if true
__{}    ld    A,format({%-12s},($1+1)); 3:13      2dup $1 D<=    DEHL<=$1     $1 = ..A.
__{}    sbc   A, H          ; 1:4       2dup $1 D<=    DEHL<=$1 --> 0<=A-DEHL --> no carry if true
__{}    ld   BC,format({%-12s},($1+2)); 4:20      2dup $1 D<=    DEHL<=$1     $1 = BC..
__{}    ld    A, C          ; 1:4       2dup $1 D<=    DEHL<=$1     $1 = .A..
__{}    sbc   A, E          ; 1:4       2dup $1 D<=    DEHL<=$1 --> 0<=A-DEHL --> no carry if true
__{}    ld    A, B          ; 1:4       2dup $1 D<=    DEHL<=$1     $1 = A...
__{}    sbc   A, D          ; 1:4       2dup $1 D<=    DEHL<=$1 --> 0<=A-DEHL --> no carry if true
__{}    rra                 ; 1:4       2dup $1 D<=    DEHL<=$1               --> no sign  if true
__{}    xor   D             ; 1:4       2dup $1 D<=
__{}    xor   B             ; 1:4       2dup $1 D<=
__{}    sub  0x80           ; 2:7       2dup $1 D<=    DEHL<=$1               --> carry if true
__{}    push DE             ; 1:11      2dup $1 D<=
__{}    ex   DE, HL         ; 1:4       2dup $1 D<=
__{}    sbc  HL, HL         ; 2:15      2dup $1 D<=    set flag d1<=$1},
__{}__IS_NUM($1),{0},{
__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}{
__{}                       ;[21:93]     2dup $1 D<=   ( d1 -- d1 flag )   # default version
__{}    ld    A, D          ; 1:4       2dup $1 D<=
__{}    add   A, A          ; 1:4       2dup $1 D<={}ifelse(eval((($1) & 0x80000000) - 0x80000000),0,{
__{}__{}    jr   nc, $+15       ; 2:7/12    2dup $1 D<=   positive d1 <= negative constant --> false},
__{}__{}{
__{}__{}    jr    c, $+15       ; 2:7/12    2dup $1 D<=   negative d1 <= positive constant --> true})
__{}    ld    A, __HEX_L($1)       ; 2:7       2dup $1 D<=   DEHL<=$1     $1 = ...A
__{}    sub   L             ; 1:4       2dup $1 D<=   DEHL<=$1 --> 0<=A-DEHL --> no carry if true
__{}    ld    A, __HEX_H($1)       ; 2:7       2dup $1 D<=   DEHL<=$1     $1 = ..A.
__{}    sbc   A, H          ; 1:4       2dup $1 D<=   DEHL<=$1 --> 0<=A-DEHL --> no carry if true
__{}    ld    A, __HEX_E($1)       ; 2:7       2dup $1 D<=   DEHL<=$1     $1 = .A..
__{}    sbc   A, E          ; 1:4       2dup $1 D<=   DEHL<=$1 --> 0<=A-DEHL --> no carry if true
__{}    ld    A, __HEX_D($1)       ; 2:7       2dup $1 D<=   DEHL<=$1     $1 = A...
__{}    sbc   A, D          ; 1:4       2dup $1 D<=   DEHL<=$1 --> 0<=A-DEHL --> no carry if true
__{}    ccf                 ; 1:4       2dup $1 D<=   DEHL<=$1               -->    carry if true
__{}    push DE             ; 1:11      2dup $1 D<=
__{}    ex   DE, HL         ; 1:4       2dup $1 D<=
__{}    sbc  HL, HL         ; 2:15      2dup $1 D<=   set flag d1<=$1})},
{
    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D<
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DLT},{ifelse($1,{},{
    .error {$0}(): Missing parameter!},
$#,{1},{ifelse(__IS_MEM_REF($1),{1},{
__{}                        ;[24:118]   2dup $1 D<    ( d1 -- d1 flag )
__{}    ld   BC, format({%-11s},$1); 4:20      2dup $1 D<    DEHL<$1     $1 = ..BC
__{}    ld    A, L          ; 1:4       2dup $1 D<    DEHL<$1
__{}    sub   C             ; 1:4       2dup $1 D<    DEHL<$1 --> DEHL-..BC<0 --> carry if true
__{}    ld    A, H          ; 1:4       2dup $1 D<    DEHL<$1
__{}    sbc   A, B          ; 1:4       2dup $1 D<    DEHL<$1 --> DEHL-..BC<0 --> carry if true
__{}    ld   BC,format({%-12s},($1+2)); 4:20      2dup $1 D<    DEHL<$1     $1 = BC..
__{}    ld    A, E          ; 1:4       2dup $1 D<    DEHL<$1
__{}    sbc   A, C          ; 1:4       2dup $1 D<    DEHL<$1 --> DEHL-BC..<0 --> carry if true
__{}    ld    A, D          ; 1:4       2dup $1 D<    DEHL<$1
__{}    sbc   A, B          ; 1:4       2dup $1 D<    DEHL<$1 --> DEHL-BC..<0 --> carry if true
__{}    rra                 ; 1:4       2dup $1 D<    DEHL<$1                 --> sign  if true
__{}    xor   D             ; 1:4       2dup $1 D<
__{}    xor   B             ; 1:4       2dup $1 D<
__{}    add   A, A          ; 1:4       2dup $1 D<    DEHL<$1                 --> carry if true
__{}    push DE             ; 1:11      2dup $1 D<
__{}    ex   DE, HL         ; 1:4       2dup $1 D<
__{}    sbc  HL, HL         ; 2:15      2dup $1 D<    set flag d1<$1},
__{}__IS_NUM($1),{0},{
__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}{
__{}                       ;[20:89]     2dup $1 D<   ( d1 -- d1 flag )   # default version
__{}    ld    A, D          ; 1:4       2dup $1 D<
__{}    add   A, A          ; 1:4       2dup $1 D<{}ifelse(eval((($1) & 0x80000000) - 0x80000000),0,{
__{}__{}    jr   nc, $+14       ; 2:7/12    2dup $1 D<   positive d1 < negative constant --> false},
__{}__{}{
__{}__{}    jr    c, $+14       ; 2:7/12    2dup $1 D<   negative d1 < positive constant --> true})
__{}    ld    A, L          ; 1:4       2dup $1 D<   DEHL<$1 --> DEHL-__HEX_DEHL($1)<0 --> carry if true
__{}    sub   A, __HEX_L($1)       ; 2:7       2dup $1 D<   DEHL<$1 --> ...A-0x......format({%02X},eval((($1)>>0) & 0xFF))<0 --> carry if true
__{}    ld    A, H          ; 1:4       2dup $1 D<   DEHL<$1 --> DEHL-__HEX_DEHL($1)<0 --> carry if true
__{}    sbc   A, __HEX_H($1)       ; 2:7       2dup $1 D<   DEHL<$1 --> ..A.-0x....format({%02X},eval((($1)>>8) & 0xFF))..<0 --> carry if true
__{}    ld    A, E          ; 1:4       2dup $1 D<   DEHL<$1 --> DEHL-__HEX_DEHL($1)<0 --> carry if true
__{}    sbc   A, __HEX_E($1)       ; 2:7       2dup $1 D<   DEHL<$1 --> .A..-0x..format({%02X},eval((($1)>>16) & 0xFF))....<0 --> carry if true
__{}    ld    A, D          ; 1:4       2dup $1 D<   DEHL<$1 --> DEHL-__HEX_DEHL($1)<0 --> carry if true
__{}    sbc   A, __HEX_D($1)       ; 2:7       2dup $1 D<   DEHL<$1 --> A...-0x{}format({%02X},eval((($1)>>24) & 0xFF))......<0 --> carry if true
__{}    push DE             ; 1:11      2dup $1 D<
__{}    ex   DE, HL         ; 1:4       2dup $1 D<
__{}    sbc  HL, HL         ; 2:15      2dup $1 D<   set flag d1<$1})},
{
    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D>=
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DGE},{ifelse($1,{},{
    .error {$0}(): Missing parameter!},
$#,{1},{ifelse(__IS_MEM_REF($1),{1},{
__{}                        ;[25:121]   2dup $1 D>=    ( d1 -- d1 flag )
__{}    ld   BC, format({%-11s},$1); 4:20      2dup $1 D>=    DEHL>=$1     $1 = ..BC
__{}    ld    A, L          ; 1:4       2dup $1 D>=    DEHL>=$1
__{}    sub   C             ; 1:4       2dup $1 D>=    DEHL>=$1 --> DEHL-..BC>=0 --> no carry if true
__{}    ld    A, H          ; 1:4       2dup $1 D>=    DEHL>=$1
__{}    sbc   A, B          ; 1:4       2dup $1 D>=    DEHL>=$1 --> DEHL-..BC>=0 --> no carry if true
__{}    ld   BC,format({%-12s},($1+2)); 4:20      2dup $1 D>=    DEHL>=$1     $1 = BC..
__{}    ld    A, E          ; 1:4       2dup $1 D>=    DEHL>=$1
__{}    sbc   A, C          ; 1:4       2dup $1 D>=    DEHL>=$1 --> DEHL-BC..>=0 --> no carry if true
__{}    ld    A, D          ; 1:4       2dup $1 D>=    DEHL>=$1
__{}    sbc   A, B          ; 1:4       2dup $1 D>=    DEHL>=$1 --> DEHL-BC..>=0 --> no carry if true
__{}    rra                 ; 1:4       2dup $1 D>=    DEHL>=$1                  --> no sign  if true
__{}    xor   D             ; 1:4       2dup $1 D>=
__{}    xor   B             ; 1:4       2dup $1 D>=
__{}    sub  0x80           ; 2:7       2dup $1 D>=    DEHL>=$1                  --> carry if true
__{}    push DE             ; 1:11      2dup $1 D>=
__{}    ex   DE, HL         ; 1:4       2dup $1 D>=
__{}    sbc  HL, HL         ; 2:15      2dup $1 D>=    set flag d1<$1},
__{}__IS_NUM($1),{0},{
__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}{
__{}                       ;[22:96]     2dup $1 D>=   ( d1 -- d1 flag )   # default version
__{}    ld    A, D          ; 1:4       2dup $1 D>=
__{}    sub  0x80           ; 2:7       2dup $1 D>={}ifelse(eval((($1) & 0x80000000) - 0x80000000),0,{
__{}__{}    jr    c, $+15       ; 2:7/12    2dup $1 D>=   positive d1 >= negative constant --> true},
__{}__{}{
__{}__{}    jr   nc, $+15       ; 2:7/12    2dup $1 D>=   negative d1 >= positive constant --> false})
__{}    ld    A, L          ; 1:4       2dup $1 D>=   DEHL>=$1 --> DEHL-__HEX_DEHL($1)>=0 --> no carry if true
__{}    sub   A, __HEX_L($1)       ; 2:7       2dup $1 D>=   DEHL>=$1 --> ...A-0x......format({%02X},eval((($1)>>0) & 0xFF))>=0 --> no carry if true
__{}    ld    A, H          ; 1:4       2dup $1 D>=   DEHL>=$1 --> DEHL-__HEX_DEHL($1)>=0 --> no carry if true
__{}    sbc   A, __HEX_H($1)       ; 2:7       2dup $1 D>=   DEHL>=$1 --> ..A.-0x....format({%02X},eval((($1)>>8) & 0xFF))..>=0 --> no carry if true
__{}    ld    A, E          ; 1:4       2dup $1 D>=   DEHL>=$1 --> DEHL-__HEX_DEHL($1)>=0 --> no carry if true
__{}    sbc   A, __HEX_E($1)       ; 2:7       2dup $1 D>=   DEHL>=$1 --> .A..-0x..format({%02X},eval((($1)>>16) & 0xFF))....>=0 --> no carry if true
__{}    ld    A, D          ; 1:4       2dup $1 D>=   DEHL>=$1 --> DEHL-__HEX_DEHL($1)>=0 --> no carry if true
__{}    sbc   A, __HEX_D($1)       ; 2:7       2dup $1 D>=   DEHL>=$1 --> A...-0x{}format({%02X},eval((($1)>>24) & 0xFF))......>=0 --> no carry if true
__{}    ccf                 ; 1:4       2dup $1 D>=   DEHL<=$1                        -->    carry if true
__{}    push DE             ; 1:11      2dup $1 D>=
__{}    ex   DE, HL         ; 1:4       2dup $1 D>=
__{}    sbc  HL, HL         ; 2:15      2dup $1 D>=   set flag d1<$1})},
{
    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl

dnl ## Logic
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x1 & x2
define({AND},{dnl
__{}__ADD_TOKEN({__TOKEN_AND},{and},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_AND},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x )  x = x2 & x1
    and   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    and   H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x )
dnl # x = x1 & x2
define({OVER_SWAP_AND},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_AND},{over swap and},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_AND},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x2 x )  x = x2 & x1
    and   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    and   H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( x -- x&n )
dnl # x = x & n
define({PUSH_AND},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_AND},{$1 and},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_AND},{dnl
__{}define({__INFO},{push_and}){}dnl
ifelse($1,{},{
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
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__AND_REG16_16BIT({HL},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( b a -- b&$1 a )
define({SWAP_PUSH_AND_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_PUSH_AND_SWAP},{swap $1 and swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_PUSH_AND_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__AND_REG16_16BIT({DE},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x1 | x2
define({OR},{dnl
__{}__ADD_TOKEN({__TOKEN_OR},{or},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x )  x = x2 | x1
    or    L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x )
dnl # x = x1 | x2
define({OVER_SWAP_OR},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_OR},{over swap or},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_OR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x2 x )  x = x2 | x1
    or    L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( x -- x|n )
dnl # x = x | n
define({PUSH_OR},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OR},{$1 or},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OR},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__OR_REG16_16BIT({HL},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( b a -- b|$1 a )
define({SWAP_PUSH_OR_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_PUSH_OR_SWAP},{swap $1 or swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_PUSH_OR_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__OR_REG16_16BIT({DE},$1){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( x1 u -- x )  x = x1 | 2**u
define({BITSET},{dnl
__{}__ADD_TOKEN({__TOKEN_BITSET},{bitset},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_BITSET},{dnl
__{}define({__INFO},{bitset}){}dnl
ifelse(eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{ifelse(_TYP_SINGLE,{fast},{
__{}                       ;[22:91/41]  bitset   ( x1 u -- x )  x = x1 | 2**u   fast version
__{}    ld    A, 0xF0       ; 2:7       bitset
__{}    and   L             ; 1:4       bitset
__{}    or    H             ; 1:4       bitset
__{}    ex   DE, HL         ; 1:4       bitset
__{}    jr   nz, $+16       ; 2:7/12    bitset   out of range 0..15
__{}    ld    A, E          ; 1:4       bitset   A = 0000 rnnn
__{}    rlca                ; 1:4       bitset   A = 000r nnn0
__{}    rlca                ; 1:4       bitset   A = 00rn nn00
__{}    add   A, 0xE0       ; 2:7       bitset   A = ???n nn00 carry = r
__{}    ccf                 ; 1:4       bitset   A = ???n nn00 carry = i = 1-r
__{}    adc   A, A          ; 1:4       bitset   A = ??nn n00i
__{}    or   0xC4           ; 2:7       bitset   A = 11nn n101 = set n,L   or   A = 11nn n100 = set n,H
__{}    ld  ($+4), A        ; 3:13      bitset
__{}    set   0, L          ; 2:8       bitset
__{}    pop  DE             ; 1:10      bitset},
{__def({USE_BITSET16})
__{}    call BITSET16       ; 3:17      bitset   ( x1 u -- x )  x = x1 | 2**u   default version
__{}    pop  DE             ; 1:10      bitset})})}){}dnl
dnl
dnl
dnl
dnl # ( x -- x|2**n )
dnl # x = x | 2**n
define({PUSH_BITSET},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_BITSET},{$1 bitset},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_BITSET},{dnl
__{}define({__INFO},{push_bitset}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{__def({USE_LSHIFT})
__{}                        ;[19:109]   push_bitset($1)   ( x1 -- x )  x = x1 | 2**$1
__{}    push DE             ; 1:11      push_bitset($1)
__{}    push HL             ; 1:11      push_bitset($1)
__{}    ld   HL, 0x0001     ; 3:10      push_bitset($1)
__{}    ld   HL, format({%-11s},$1); 3:16      push_bitset($1)
__{}    call DE_LSHIFT      ; 3:17      push_bitset($1)   ( x1 u -- ? x2 )  x2 = x1<<u
__{}    pop  DE             ; 1:10      push_bitset($1)
__{}    ld    A, E          ; 1:4       push_bitset($1)   ( x2 x1 -- x )  x = x2 | x1
__{}    or    L             ; 1:4       push_bitset($1)
__{}    ld    L, A          ; 1:4       push_bitset($1)
__{}    ld    A, D          ; 1:4       push_bitset($1)
__{}    or    H             ; 1:4       push_bitset($1)
__{}    ld    H, A          ; 1:4       push_bitset($1)
__{}    pop  DE             ; 1:10      push_bitset($1)},
__IS_NUM($1),{0},{define({_TMP_INFO},{push_bitset($1)})
__{}  .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}if (($1)>=0)
__{} if (($1)<8){}dnl
__{}__OR_REG8_8BIT({L},{1<<($1)})
__{} else
__{}  if (($1)<16){}dnl
__{}__OR_REG8_8BIT({H},{1<<($1-8)})
__{}  endif
__{} endif
__{}endif},
{dnl
__{}ifelse(eval(($1)<0),{1},{
__{}__{}  .error {$0}($@): negative parameters found in macro!},
__{}eval(($1)>15),{1},{
__{}__{}  .warning {$0}($@): Out of range zero to 15th bit.},
__{}{define({_TMP_INFO},{push_bitset($1)})
__{}__{}ifelse(dnl
__{}__{}eval(($1)< 8),{1},{__OR_REG8_8BIT({L},eval(1<<($1)))},
__{}__{}eval(($1)<16),{1},{__OR_REG8_8BIT({H},eval(1<<($1-8)))})}){}dnl
})}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x1 ^ x2
define({XOR},{dnl
__{}__ADD_TOKEN({__TOKEN_XOR},{xor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x )  x = x2 ^ x1
    xor   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x1 ^ x2
define({OVER_SWAP_XOR},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_XOR},{over swap xor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_XOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x2 x )  x = x2 ^ x1
    xor   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( x -- x^n )
dnl # x = x ^ n
define({PUSH_XOR},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_XOR},{$1 xor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_XOR},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__XOR_REG16_16BIT({HL},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( b a -- b^$1 a )
define({SWAP_PUSH_XOR_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_PUSH_XOR_SWAP},{swap $1 xor swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_PUSH_XOR_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__XOR_REG16_16BIT({DE},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( x1 -- x )
dnl # x = ~x1
dnl # -1   -> false
dnl # false-> true
define({INVERT},{dnl
__{}__ADD_TOKEN({__TOKEN_INVERT},{invert},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_INVERT},{dnl
__{}define({__INFO},{invert}){}dnl

    ld    A, L          ; 1:4       invert
    cpl                 ; 1:4       invert
    ld    L, A          ; 1:4       invert
    ld    A, H          ; 1:4       invert
    cpl                 ; 1:4       invert
    ld    H, A          ; 1:4       invert}){}dnl
dnl
dnl
dnl # ( a b c -- ((a-b) (c-b) U<) )
dnl # b <= a < c
define({WITHIN},{dnl
__{}__ADD_TOKEN({__TOKEN_WITHIN},{within},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_WITHIN},{dnl
__{}define({__INFO},{within}){}dnl
ifelse(TYP_WITHIN,{fast},{
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
    pop  DE             ; 1:10      within ( a b c -- ((a-b) (c-b) U<) )})}){}dnl
dnl
dnl
dnl # ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl # $1 <= a < $2
define({PUSH2_WITHIN},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_WITHIN},{$1 $2 within},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_WITHIN},{dnl
__{}define({__INFO},{push2_within}){}dnl
ifelse($1,{},{
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
define({LO_WITHIN},{dnl
__{}__ADD_TOKEN({__TOKEN_LO_WITHIN},{lo_within},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LO_WITHIN},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[10:59]    __INFO   ( c3 c2 c1 -- flag=(c2<=c3<c1) )
    ld    A, L          ; 1:4       __INFO
    sub   E             ; 1:4       __INFO
    ld    C, A          ; 1:4       __INFO   C = c1-c2
    pop  HL             ; 1:10      __INFO   L = c3
    ld    A, L          ; 1:4       __INFO
    sub   E             ; 1:4       __INFO   c3-c2
    sub   C             ; 1:4       __INFO   (c3-c2)-(c1-c2)
    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff
    pop  DE             ; 1:10      __INFO   ( c3 c2 c1 -- ((c3-c2) (c1-c2) U<) ){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( x3 x2 -- ((x3-x2) (x1-x2) U<) )
dnl # x2 <= x3 < $1
define({PUSH_WITHIN},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_WITHIN},{$1 within},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_WITHIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
                        ;[18:110]   __INFO   ( x3 x2 $1 -- flag=(x2<=x3<$1) )
    ld    C, L          ; 1:4       __INFO
    ld    B, H          ; 1:4       __INFO   BC = x2
    ld   HL, format({%-11s},$1); 3:16      __INFO   lo
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO   $1-x2
    ex   DE, HL         ; 1:4       __INFO
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO   x3-x2
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   (x3-x2)-($1-x2)
    pop  DE             ; 1:10      __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff},
__IS_MEM_REF($1),1,{
                        ;[18:110]   __INFO   ( x3 x2 $1 -- flag=(x2<=x3<$1) )
    xor   A             ; 1:4       __INFO
    sub   L             ; 1:4       __INFO
    ld    C, A          ; 1:4       __INFO
    sbc   A, H          ; 1:4       __INFO
    sub   L             ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO   BC =-x2
    ld   HL, format({%-11s},$1); 3:16      __INFO   lo
    add  HL, BC         ; 1:11      __INFO   $1-x2
    ex   DE, HL         ; 1:4       __INFO
    add  HL, BC         ; 1:11      __INFO   x3-x2
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   (x3-x2)-($1-x2)
    pop  DE             ; 1:10      __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff},
__IS_MEM_REF($1),1,{
                        ;[20:109]   __INFO   ( x3 x2 $1 -- flag=(x2<=x3<$1) )
    ex   DE, HL         ; 1:4       __INFO
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   x3-x2
    ld    A, format({%-11s},$1); 3:13      __INFO   lo
    sub   E             ; 1:4       __INFO
    ld    E, A          ; 1:4       __INFO
    ld    A, format({%-11s},(1+$1)); 3:13      __INFO   hi
    sbc   A, D          ; 1:4       __INFO
    ld    D, A          ; 1:4       __INFO   $1-x2
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   (x3-x2)-($1-x2)
    pop  DE             ; 1:10      __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff},
{
                        ;[18:97]    __INFO   ( x3 x2 $1 -- flag=(x2<=x3<$1) )
    ex   DE, HL         ; 1:4       __INFO
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   x3-x2
    ld    A, low __FORM({%-7s},$1); 2:7       __INFO
    sub   E             ; 1:4       __INFO
    ld    E, A          ; 1:4       __INFO
    ld    A, high __FORM({%-6s},$1); 2:7       __INFO
    sbc   A, D          ; 1:4       __INFO
    ld    D, A          ; 1:4       __INFO   $1-x2
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   (x3-x2)-($1-x2)
    pop  DE             ; 1:10      __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( c3 c2 -- ((c3-c2) ($1-c2) U<) )
dnl # c2 <= c3 < $1
define({PUSH_LO_WITHIN},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_LO_WITHIN},{$1 lo_within},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_LO_WITHIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
                        ;[11:58]    __INFO   ( c3 c2 $1 -- flag=(c2<=c3<$1) )
    ld    A,format({%-12s},$1); 3:13      __INFO
    sub   L             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO   $1-c2
    ld    A, E          ; 1:4       __INFO
    sub   L             ; 1:4       __INFO   c3-c2
    sub   H             ; 1:4       __INFO   (c3-c2)-($1-c2)
    pop  DE             ; 1:10      __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff},
{
                        ;[10:52]    __INFO   ( c3 c2 $1 -- flag=(c2<=c3<$1) )
    ld    A, low __FORM({%-7s},$1); 2:7       __INFO
    sub   L             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO   $1-c2
    ld    A, E          ; 1:4       __INFO
    sub   L             ; 1:4       __INFO   c3-c2
    sub   H             ; 1:4       __INFO   (c3-c2)-($1-c2)
    pop  DE             ; 1:10      __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff}){}dnl
}){}dnl
dnl
dnl
dnl # ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl # $1 <= a < $2
define({PUSH2_LO_WITHIN},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_LO_WITHIN},{$1 $2 lo_within},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_LO_WITHIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}  .error {$0}($@): The second parameter is missing!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}                        ;[ifelse(__IS_MEM_REF($2),{1},{14:65},{13:59})]    __INFO   ( a $1 $2 -- flag=($1<=a<$2) )
__{}__{}    ld    A, format({%-11s},$1); 3:13      __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO   C = $1
__{}__{}    ld    A, ifelse(__IS_MEM_REF($2),{1},{format({%-11s},$2); 3:13},{__FORM({%-11s},$2); 2:7 })      __INFO
__{}__{}    sub   C             ; 1:4       __INFO
__{}__{}    ld    B, A          ; 1:4       __INFO   B = ($2)-[$1]
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    sub   C             ; 1:4       __INFO   A = a -($1)
__{}__{}    sub   B             ; 1:4       __INFO   A = (a -($1)) - ([$2]-($1))
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff},
__{}__IS_MEM_REF($2),{1},{dnl
__{}__{}ifelse(eval($1),{0},{
__{}__{}__{}                        ;[8:40]     __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO   B = $2 - {{$1}}
__{}__{}__{}    ld    A, L          ; 1:4       __INFO},
__{}__{}eval($1),{1},{
__{}__{}__{}                        ;[10:48]    __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO   B = $2 - {{$1}}
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    dec   A             ; 1:4       __INFO   A = a - {{$1}}},
__{}__{}__HEX_HL($1),{0xFFFF},{
__{}__{}__{}                        ;[10:48]    __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO   B = $2 - {{$1}}
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO   A = a - {{$1}}},
__{}__{}{
__{}__{}__{}                        ;[12:54]    __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}__{}    sub   __FORM({%-14s},$1); 2:7       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO   B = $2 - {{$1}}
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    sub   __FORM({%-14s},$1); 2:7       __INFO   A = a - {{$1}}})
__{}__{}    sub   B             ; 1:4       __INFO   A = (a - {{$1}}) - ($2 - {{$1}})
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff},
__{}{dnl
__{}__{}ifelse(__IS_NUM($1),{0},{
__{}__{}__{}                        ;[7:33]     __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    sub   __FORM({%-14s},$1); 2:7       __INFO   A = a-($1)},
__{}__{}{dnl
__{}__{}__{}ifelse(eval($1),{0},{
__{}__{}__{}__{}                        ;[5:26]     __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld    A, L          ; 1:4       __INFO},
__{}__{}__{}eval($1),{1},{
__{}__{}__{}__{}                        ;[6:30]     __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}__{}    dec   A             ; 1:4       __INFO   A = a-($1)},
__{}__{}__{}__HEX_HL($1),{0xFFFF},{
__{}__{}__{}__{}                        ;[6:30]     __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}__{}    inc   A             ; 1:4       __INFO   A = a-($1)},
__{}__{}__{}{
__{}__{}__{}__{}                        ;[7:33]     __INFO   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}__{}    sub   __HEX_L($1)          ; 2:7       __INFO   A = a-($1)}){}dnl
__{}__{}}){}dnl
__{}__{}__{}ifelse(__IS_NUM($1):__IS_NUM($2),{1:1},{
__{}__{}__{}    sub  __HEX_L($2-($1))           ; 2:7       __INFO   carry: a-($1) - (($2)-($1))},
__{}__{}{
__{}__{}__{}    sub  low __FORM({%-11s},$2-($1)); 2:7       __INFO   carry: a-($1) - (($2)-($1))})
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   HL = 0x0000 or 0xffff}){}dnl
}){}dnl
dnl
dnl
dnl # -------------------------------------
dnl
dnl # ( -- x )
dnl # x = 0xFFFF
define({TRUE},{dnl
__{}__ADD_TOKEN({__TOKEN_TRUE},{true},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TRUE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, 0xffff     ; 3:10      __INFO}){}dnl
dnl
dnl # ( -- x )
dnl # x = 0
define({FALSE},{dnl
__{}__ADD_TOKEN({__TOKEN_FALSE},{false},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FALSE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, 0x0000     ; 3:10      __INFO}){}dnl
dnl
dnl # -------------------------------------
dnl
dnl # 0=
dnl # ( x1 -- flag )
dnl # if ( x1 ) flag = 0; else flag = 0xFFFF;
dnl # 0 if 16-bit number not equal to zero, -1 if equal
define({_0EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_0EQ},{0=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0EQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:29]     __INFO   ( x -- flag )  flag: x == 0
    ld    A, H          ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    sub   H             ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = flag}){}dnl
dnl
dnl # 0<>
dnl # ( x1 -- flag )
dnl # if ( x1<>0 ) flag = 0; else flag = 0xFFFF;
dnl # 0 if 16-bit zero, -1 if not equal zero
define({_0NE},{dnl
__{}__ADD_TOKEN({__TOKEN_0NE},{0<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0NE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(_TYP_SINGLE,small,{
__{}                        ;[6:30]     __INFO   ( x -- flag )  flag: x <> 0  # small version can be changed with "define({TYP_D0EQ},{default})"
__{}    ld    A, L          ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},
__{}{
__{}                        ;[7:25/20]  __INFO   ( x -- flag )  flag: x <> 0  # default version can be changed with "define({TYP_D0EQ},{small})"
__{}    ld    A, L          ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}    ld   HL, 0xFFFF     ; 3:10      __INFO   HL = flag}){}dnl
 }){}dnl
dnl
dnl
dnl # 0<
dnl # ( x1 -- flag )
define({_0LT},{dnl
__{}__ADD_TOKEN({__TOKEN_0LT},{0<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0LT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(TYP_0LT,{small},{
__{}                        ;[4:23]     __INFO   ( x -- flag )  flag: x < 0  # small version can be changed with "define({TYP_D0EQ},{default})"
__{}    rl    H             ; 2:8       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}{
__{}                        ;[5:20]     __INFO   ( x -- flag )  flag: x < 0  # default version can be changed with "define({TYP_D0EQ},{small})"
__{}    rl    H             ; 2:8       __INFO
__{}    sbc   A, A          ; 1:4       __INFO
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # 0>
dnl # ( x1 -- flag )
define({_0GT},{dnl
__{}__ADD_TOKEN({__TOKEN_0GT},{0>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0GT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(1,0,{
__{}                        ;[9:41/20]  __INFO   ( x -- flag )  flag: x > 0
__{}    ld    A, L          ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jr    z, $+7        ; 2:7/12    __INFO   zero is false and result
__{}    ld    A, H          ; 1:4       __INFO
__{}    sub   0x80          ; 2:7       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}{
__{}                        ;[7:36]     __INFO   ( x -- flag )  flag: x > 0
__{}    ld    A, H          ; 1:4       __INFO   save sign
__{}    dec  HL             ; 1:6       __INFO   zero to negative
__{}    or    H             ; 1:4       __INFO
__{}    sub   0x80          ; 2:7       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 0<=
dnl # ( x1 -- flag )
define({_0LE},{dnl
__{}__ADD_TOKEN({__TOKEN_0LE},{0<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0LE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:33]     __INFO   ( x -- flag )  flag: x <= 0
    ld    A, H          ; 1:4       __INFO   save sign
    dec  HL             ; 1:6       __INFO   zero to negative
    or    H             ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   carry if zero or negative HL
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # 0>=
dnl # ( x1 -- flag )
define({_0GE},{dnl
__{}__ADD_TOKEN({__TOKEN_0GE},{0>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0GE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:26]     __INFO   ( x -- flag )  flag: x >= 0
    ld    A, H          ; 1:4       __INFO
    sub   0x80          ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # ------------ signed -----------------
dnl
dnl
dnl # =
dnl # ( x1 x2 -- flag )
dnl # equal ( x1 == x2 )
define({EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_EQ},{=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_EQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:48/49]  __INFO
    xor   A             ; 1:4       __INFO   A = 0x00
    sbc  HL, DE         ; 2:15      __INFO
    jr   nz, $+3        ; 2:7/12    __INFO
    dec   A             ; 1:4       __INFO   A = 0xFF
    ld    L, A          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO   HL= flag
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x -- x|n )
dnl # x = x | n
define({PUSH_EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_EQ},{$1 =},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_EQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[12:58/59] __INFO
__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO
__{}__{}    xor   A             ; 1:4       __INFO   A = 0x00
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO   HL= flag},
__{}__IS_NUM($1),{0},{dnl
__{}__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}__{}                        ;[11:48/49] __INFO
__{}__{}    ld   BC, __FORM({%-11s},$1); 3:10      __INFO
__{}__{}    xor   A             ; 1:4       __INFO   A = 0x00
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO   HL= flag},
__{}{dnl
__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}                        ;[6:30]     __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval($1),{1},{dnl
__{}__{}                        ;[7:34]     __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval((($1) & 0xffff) - 0xffff),{0},{dnl
__{}__{}                        ;[7:36]     __INFO
__{}__{}    inc   HL            ; 1:6       __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval($1),{255},{dnl
__{}__{}                        ;[7:34]     __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval($1),{256},{dnl
__{}__{}                        ;[7:34]     __INFO
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) - 0xff00),{0},{dnl
__{}__{}                        ;[7:34]     __INFO
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) & 0xff00),{0},{dnl
__{}__{}                        ;[8:37]     __INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   lo($1)
__{}__{}    xor   L             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) & 0xff),{0},{dnl
__{}__{}                        ;[8:37]     __INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   hi($1)
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval((($1)>>8) & 0xff),{1},{dnl
__{}__{}                        ;[9:41]     __INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   lo($1)
__{}__{}    xor   L             ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval((($1)>>8) & 0xff),{255},{dnl
__{}__{}                        ;[9:41]     __INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   lo($1)
__{}__{}    xor   L             ; 1:4       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) & 0xff),{1},{dnl
__{}__{}                        ;[9:41]     __INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   hi($1)
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) & 0xff),{255},{dnl
__{}__{}                        ;[9:41]     __INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   hi($1)
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval((($1) & 0xff)-((($1)>>8) & 0xff)),{0},{dnl
__{}__{}                        ;[11:48/35] __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   lo($1) = hi($1)
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}{dnl
__{}__{}                        ;[12:51/38] __INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   lo($1)
__{}__{}    xor   L             ; 1:4       __INFO
__{}__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   hi($1)
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({DUP_PUSH_EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_EQ},{dup_push_eq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_EQ},{dnl
__{}define({__INFO},{dup_push_eq}){}dnl
dnl
__{}define({_TMP_INFO},{dup $1 =}){}dnl
__{}define({_TMP_STACK_INFO},{_TMP_INFO   ( x -- x f )   __HEX_HL($1) == HL}){}dnl
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
__{}__{}__{}__EQ_MAKE_BEST_CODE($1,6,37,0,37)dnl
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
__{}__{}__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      _TMP_INFO
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
dnl # <>
dnl # ( x1 x2 -- flag )
dnl # not equal ( x1 <> x2 )
define({NE},{dnl
__{}__ADD_TOKEN({__TOKEN_NE},{<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    jr    z, $+5        ; 2:7/12    __INFO
    ld   HL, 0xFFFF     ; 3:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x -- f )
dnl # f = x <> $1
define({PUSH_NE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_NE},{$1 <>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_NE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[12:56/51] __INFO
__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO
__{}__{}    xor   A             ; 1:4       __INFO   A = 0x00
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}__{}    ld   HL, 0xFFFF     ; 3:10      __INFO   HL= flag},
__{}__IS_NUM($1),{0},{dnl
__{}__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}__{}                        ;[11:46/41] __INFO
__{}__{}    ld   BC, __FORM({%-11s},$1); 3:10      __INFO
__{}__{}    xor   A             ; 1:4       __INFO   A = 0x00
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}__{}    ld   HL, 0xFFFF     ; 3:10      __INFO   HL= flag},
__{}{dnl
__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}                        ;[7:25/20]  __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}__{}    ld   HL, 0xFFFF     ; 3:10      __INFO   HL= flag},
__{}__{}eval($1),{0},{dnl
__{}__{}                        ;[6:30]     __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval($1),{1},{dnl
__{}__{}                        ;[7:34]     __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval((($1) & 0xffff) - 0xffff),{0},{dnl
__{}__{}                        ;[7:36]     __INFO
__{}__{}    inc   HL            ; 1:6       __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval($1),{255},{dnl
__{}__{}                        ;[7:34]     __INFO
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval($1),{256},{dnl
__{}__{}                        ;[7:34]     __INFO
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) - 0xff00),{0},{dnl
__{}__{}                        ;[7:34]     __INFO
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) & 0xff00),{0},{dnl
__{}__{}                        ;[8:37]     __INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   lo($1)
__{}__{}    xor   L             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) & 0xff),{0},{dnl
__{}__{}                        ;[8:37]     __INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   hi($1)
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval((($1)>>8) & 0xff),{1},{dnl
__{}__{}                        ;[9:41]     __INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   lo($1)
__{}__{}    xor   L             ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval((($1)>>8) & 0xff),{255},{dnl
__{}__{}                        ;[9:41]     __INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   lo($1)
__{}__{}    xor   L             ; 1:4       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) & 0xff),{1},{dnl
__{}__{}                        ;[9:41]     __INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   hi($1)
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}eval(($1) & 0xff),{255},{dnl
__{}__{}                        ;[9:41]     __INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   hi($1)
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    add   A, 0xFF       ; 2:7       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}__{}{dnl
__{}__{}                        ;[11:46/41] __INFO
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   BC = $1
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    jr   nz, $+5        ; 2:7/12    __INFO
__{}__{}    ld   HL, 0xFFFF     ; 3:10      __INFO   HL = true}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({DUP_PUSH_NE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_NE},{dup_push_ne},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_NE},{dnl
__{}define({__INFO},{dup_push_ne}){}dnl
dnl
__{}define({_TMP_INFO},{dup $1 <>}){}dnl
__{}define({_TMP_STACK_INFO},{_TMP_INFO   ( x -- x f )   __HEX_HL($1) <> HL}){}dnl
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
__{}__{}__{}__EQ_MAKE_BEST_CODE($1,6,37,0,37)dnl
__{}__{}__{}ifelse(eval(_TMP_BEST_P<=1768),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    add   A, 0xFF       ; 2:7       _TMP_INFO
__{}__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag x<>$1},
__{}__{}__{}{
__{}__{}__{}__{}                       ;[13:61/56]  _TMP_STACK_INFO
__{}__{}__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      _TMP_INFO
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
define({LT},{dnl
__{}__ADD_TOKEN({__TOKEN_LT},{<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[12:54]     __INFO   ( x2 x1 -- flag x2<x1 )
    ld    A, E          ; 1:4       __INFO   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       __INFO   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       __INFO   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       __INFO   DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       __INFO   carry --> sign
    xor   H             ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   sign --> carry
    sbc   A, A          ; 1:4       __INFO   0x00 or 0xff
    ld    H, A          ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # <=
dnl # ( x2 x1 -- flag )
dnl # signed ( x2 <= x1 ) --> ( x2 - 1 < x1 ) --> ( x2 - x1 - 1 < 0 ) --> carry is true
dnl # signed ( x2 <= x1 ) --> ( 0 <= x1 - x2 ) --> no carry is true
define({LE},{dnl
__{}__ADD_TOKEN({__TOKEN_LE},{<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(TYP_LE,{old},{
                       ;[15:63,62]  __INFO
    ld    A, H          ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    jp    p, $+7        ; 3:10      __INFO
    rl    D             ; 2:8       __INFO  sign x2 = flag
    jr   $+5            ; 2:12      __INFO
    sbc  HL, DE         ; 2:15      __INFO  x2<=x1 --> 0<=x2-x1 --> no carry is true
    ccf                 ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO},
{
                       ;[13:57]     __INFO   ( x2 x1 -- flag x2<=x1 )
    ld    A, L          ; 1:4       __INFO   DE<=HL --> 0<=HL-DE --> no carry if true
    sub   E             ; 1:4       __INFO   DE<=HL --> 0<=HL-DE --> no carry if true
    ld    A, H          ; 1:4       __INFO   DE<=HL --> 0<=HL-DE --> no carry if true
    sbc   A, D          ; 1:4       __INFO   DE<=HL --> 0<=HL-DE --> no carry if true
    rra                 ; 1:4       __INFO   carry --> sign
    xor   H             ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    sub  0x80           ; 2:7       __INFO   sign --> invert carry
    sbc   A, A          ; 1:4       __INFO   0x00 or 0xff
    ld    H, A          ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO})}){}dnl
dnl
dnl
dnl # >
dnl # ( x2 x1 -- flag )
dnl # signed ( x2 > x1 ) --> ( 0 > x1 - x2 ) --> carry is true
define({GT},{dnl
__{}__ADD_TOKEN({__TOKEN_GT},{>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[12:54]     __INFO   ( x2 x1 -- flag x2>x1 )
    ld    A, L          ; 1:4       __INFO   DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       __INFO   DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       __INFO   DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       __INFO   DE>HL --> 0>HL-DE --> carry if true
    rra                 ; 1:4       __INFO   carry --> sign
    xor   H             ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   sign --> carry
    sbc   A, A          ; 1:4       __INFO   0x00 or 0xff
    ld    H, A          ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # >=
dnl # ( x2 x1 -- flag )
dnl # signed ( x2 >= x1 ) --> ( x2 + 1 > x1 ) --> ( 0 > x1 - x2 - 1 ) --> carry is true
dnl # signed ( x2 >= x1 ) --> ( x2 - x1 >= 0 ) --> no carry is true
define({GE},{dnl
__{}__ADD_TOKEN({__TOKEN_GE},{>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(TYP_GE,{old},{
                       ;[15:63,62]  __INFO
    ld    A, H          ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    jp    p, $+7        ; 3:10      __INFO
    rl    H             ; 2:8       __INFO sign x1 = flag
    jr   $+5            ; 2:12      __INFO
    scf                 ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO},
{
                       ;[13:57]     __INFO   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       __INFO   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       __INFO   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       __INFO   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       __INFO   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       __INFO   carry --> sign
    xor   H             ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    sub  0x80           ; 2:7       __INFO   sign --> invert carry
    sbc   A, A          ; 1:4       __INFO   0x00 or 0xff
    ld    H, A          ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO})}){}dnl
dnl
dnl # ------------ unsigned ---------------
dnl
dnl # ( x1 x2 -- x )
dnl # equal ( x1 == x2 )
define({UEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_UEQ},{ueq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UEQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_EQ}){}dnl
dnl
dnl # ( x1 x2 -- x )
dnl # not equal ( x1 <> x2 )
define({UNE},{dnl
__{}__ADD_TOKEN({__TOKEN_UNE},{une},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UNE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_NE}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # unsigned ( x2 < x1 ) --> ( x2 - x1 < 0 ) --> carry is true
define({ULT},{dnl
__{}__ADD_TOKEN({__TOKEN_ULT},{ult},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULT},{dnl
__{}define({__INFO},{ult}){}dnl

                        ;[7:41]     u<
    ld    A, E          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sbc  HL, HL         ; 2:15      u<
    pop  DE             ; 1:10      u<}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # unsigned ( x2 <= x1 ) --> ( x2 < x1 + 1 ) --> ( x2 - x1 - 1 < 0) --> carry is true
dnl # unsigned ( x2 <= x1 ) --> ( 0 <= x1 - x2 ) --> no carry is true
define({ULE},{dnl
__{}__ADD_TOKEN({__TOKEN_ULE},{ule},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULE},{dnl
__{}define({__INFO},{ule}){}dnl

    scf                 ; 1:4       u<=
    ex   DE, HL         ; 1:4       u<=
    sbc  HL, DE         ; 2:15      u<=
    sbc  HL, HL         ; 2:15      u<=
    pop  DE             ; 1:10      u<=}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # unsigned ( x2 > x1 ) --> ( 0 > x1 - x2 ) --> carry is true
define({UGT},{dnl
__{}__ADD_TOKEN({__TOKEN_UGT},{ugt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGT},{dnl
__{}define({__INFO},{ugt}){}dnl

    or    A             ; 1:4       u>
    sbc  HL, DE         ; 2:15      u>
    sbc  HL, HL         ; 2:15      u>
    pop  DE             ; 1:10      u>}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # unsigned ( x2 >= x1 ) --> ( x2 + 1 > x1 ) --> ( 0 > x1 - x2 - 1 ) --> carry is true
define({UGE},{dnl
__{}__ADD_TOKEN({__TOKEN_UGE},{uge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGE},{dnl
__{}define({__INFO},{uge}){}dnl

    scf                 ; 1:4       u>=
    sbc  HL, DE         ; 2:15      u>=
    sbc  HL, HL         ; 2:15      u>=
    pop  DE             ; 1:10      u>=}){}dnl
dnl
dnl
dnl # ------------ 2dup condition -----------------
dnl
dnl
dnl
dnl # 2dup =
dnl # ( x1 x2 -- x1 x2 flag )
define({_2DUP_EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_EQ},{2dup =},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_EQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_2DUP{}dnl
__{}__ASM_TOKEN_EQ}){}dnl
dnl
dnl
dnl
dnl # 2dup <>
dnl # ( x1 x2 -- x1 x2 flag )
define({_2DUP_NE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_EQ},{2dup <>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_NE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_2DUP{}dnl
__{}__ASM_TOKEN_NE}){}dnl
dnl
dnl
dnl
dnl # 2dup <
dnl # ( x1 x2 -- x1 x2 flag )
define({_2DUP_LT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_LT},{2dup <},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_LT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_2DUP{}dnl
__{}__ASM_TOKEN_LT}){}dnl
dnl
dnl
dnl
dnl # 2dup >
dnl # ( x1 x2 -- x1 x2 flag )
define({_2DUP_GT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_GT},{2dup >},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_GT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_2DUP{}dnl
__{}__ASM_TOKEN_GT}){}dnl
dnl
dnl
dnl
dnl # 2dup <=
dnl # ( x1 x2 -- x1 x2 flag )
define({_2DUP_LE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_LE},{2dup <=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_LE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_2DUP{}dnl
__{}__ASM_TOKEN_LE}){}dnl
dnl
dnl
dnl
dnl # 2dup >=
dnl # ( x1 x2 -- x1 x2 flag )
define({_2DUP_GE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_GE},{2dup >=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_GE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_2DUP{}dnl
__{}__ASM_TOKEN_GE}){}dnl
dnl
dnl
dnl
dnl # ------------- single shifts ----------------
dnl
dnl # ( x u -- x)
dnl # shifts x left u places
define({LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_LSHIFT},{lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LSHIFT},{dnl
__{}define({__INFO},{lshift}){}dnl
ifdef({USE_LSHIFT},,define({USE_LSHIFT},{}))
    call DE_LSHIFT      ; 3:17      <<   ( x1 u -- x1<<u )
    pop  DE             ; 1:10      <<}){}dnl
dnl
dnl
dnl # ( x u -- x)
dnl # shifts x right u places
define({RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_RSHIFT},{rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RSHIFT},{dnl
__{}define({__INFO},{rshift}){}dnl
ifdef({USE_RSHIFT},,define({USE_RSHIFT},{}))
    call DE_RSHIFT      ; 3:17      >>   ( x1 u -- x1>>u )
    pop  DE             ; 1:10      >>}){}dnl
dnl
dnl
dnl # 1 <<
dnl # x 1 lshift
dnl # ( x -- x)
dnl # shifts x left 1 place
define({_1LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_1LSHIFT},{1 lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1LSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    add  HL, HL         ; 1:11      __INFO   ( u -- u<<1 )}){}dnl
dnl
dnl
dnl # 2 <<
dnl # x 2 lshift
dnl # ( x -- x)
dnl # shifts x left 2 places
define({_2LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_2LSHIFT},{2 lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2LSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    add  HL, HL         ; 1:11      __INFO   ( u -- u<<2 )
    add  HL, HL         ; 1:11      __INFO}){}dnl
dnl
dnl
dnl # 3 <<
dnl # x 3 lshift
dnl # ( x -- x)
dnl # shifts x left 3 places
define({_3LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_3LSHIFT},{3 lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3LSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    add  HL, HL         ; 1:11      __INFO   ( u -- u<<3 )
    add  HL, HL         ; 1:11      __INFO
    add  HL, HL         ; 1:11      __INFO}){}dnl
dnl
dnl
dnl # 4 <<
dnl # x 4 lshift
dnl # ( x -- x)
dnl # shifts x left 4 places
define({_4LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_4LSHIFT},{4lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4LSHIFT},{dnl
__{}define({__INFO},{4lshift}){}dnl

    add  HL, HL         ; 1:11      4 lshift   ( u -- u<<4 )
    add  HL, HL         ; 1:11      4 lshift
    add  HL, HL         ; 1:11      4 lshift
    add  HL, HL         ; 1:11      4 lshift}){}dnl
dnl
dnl
dnl # 5 <<
dnl # x 5 lshift
dnl # ( x -- x)
dnl # shifts x left 5 places
define({_5LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_5LSHIFT},{5lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_5LSHIFT},{dnl
__{}define({__INFO},{5lshift}){}dnl

    add  HL, HL         ; 1:11      5 lshift   ( u -- u<<5 )
    add  HL, HL         ; 1:11      5 lshift
    add  HL, HL         ; 1:11      5 lshift
    add  HL, HL         ; 1:11      5 lshift
    add  HL, HL         ; 1:11      5 lshift}){}dnl
dnl
dnl
dnl # 6 <<
dnl # x 6 lshift
dnl # ( x -- x)
dnl # shifts x left 6 places
define({_6LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_6LSHIFT},{6lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_6LSHIFT},{dnl
__{}define({__INFO},{6lshift}){}dnl

                       ;[12:47]     6 lshift   ( u -- u<<6 )
    ld    A, H          ; 1:4       6 lshift
    and   0x03          ; 2:7       6 lshift   .... ..98   7654 3210
    rra                 ; 1:4       6 lshift   .... ...9 8 7654 3210
    rr    L             ; 2:8       6 lshift   .... ...9   8765 4321 0
    rra                 ; 1:4       6 lshift   0... .... 9 8765 4321
    rr    L             ; 2:8       6 lshift   0... ....   9876 5432 1
    rra                 ; 1:4       6 lshift   10.. .... . 9876 5432
    ld    H, L          ; 1:4       6 lshift
    ld    L, A          ; 1:4       6 lshift}){}dnl
dnl
dnl
dnl # 7 <<
dnl # x 7 lshift
dnl # ( x -- x)
dnl # shifts x left 7 places
define({_7LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_7LSHIFT},{7lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_7LSHIFT},{dnl
__{}define({__INFO},{7lshift}){}dnl

                        ;[8:32]     7 lshift   ( u -- u<<7 )
    xor   A             ; 1:4       7 lshift
    srl   H             ; 2:8       7 lshift
    rr    L             ; 2:8       7 lshift
    ld    H, L          ; 1:4       7 lshift
    rra                 ; 1:4       7 lshift
    ld    L, A          ; 1:4       7 lshift}){}dnl
dnl
dnl
dnl # 8 <<
dnl # x 8 lshift
dnl # ( x -- x)
dnl # shifts x left 8 places
define({_8LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_8LSHIFT},{8lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_8LSHIFT},{dnl
__{}define({__INFO},{8lshift}){}dnl

    ld    H, L          ; 1:4       8 lshift   ( u -- u<<8 )
    ld    L, 0x00       ; 2:7       8 lshift}){}dnl
dnl
dnl
dnl # 9 <<
dnl # x 9 lshift
dnl # ( x -- x)
dnl # shifts x left 9 places
define({_9LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_9LSHIFT},{9lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_9LSHIFT},{dnl
__{}define({__INFO},{9lshift}){}dnl

    sla   L             ; 2:8       9 lshift   ( u -- u<<9 )
    ld    H, L          ; 1:4       9 lshift
    ld    L, 0x00       ; 2:7       9 lshift}){}dnl
dnl
dnl
dnl # 10 <<
dnl # x 10 lshift
dnl # ( x -- x)
dnl # shifts x left 10 places
define({_10LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_10LSHIFT},{10lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_10LSHIFT},{dnl
__{}define({__INFO},{10lshift}){}dnl

    ld    A, L          ; 1:4       10 lshift   ( u -- u<<10 )
    add   A, A          ; 1:4       10 lshift
    add   A, A          ; 1:4       10 lshift
    ld    H, A          ; 1:4       10 lshift
    ld    L, 0x00       ; 2:7       10 lshift}){}dnl
dnl
dnl
dnl # 11 <<
dnl # x 11 lshift
dnl # ( x -- x)
dnl # shifts x left 11 places
define({_11LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_11LSHIFT},{11lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_11LSHIFT},{dnl
__{}define({__INFO},{11lshift}){}dnl

    ld    A, L          ; 1:4       11 lshift   ( u -- u<<11 )
    add   A, A          ; 1:4       11 lshift
    add   A, A          ; 1:4       11 lshift
    add   A, A          ; 1:4       11 lshift
    ld    H, A          ; 1:4       11 lshift
    ld    L, 0x00       ; 2:7       11 lshift}){}dnl
dnl
dnl
dnl # 12 <<
dnl # x 12 lshift
dnl # ( x -- x)
dnl # shifts x left 12 places
define({_12LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_12LSHIFT},{12lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_12LSHIFT},{dnl
__{}define({__INFO},{12lshift}){}dnl

    ld    A, L          ; 1:4       12 lshift   ( u -- u<<12 )
    add   A, A          ; 1:4       12 lshift
    add   A, A          ; 1:4       12 lshift
    add   A, A          ; 1:4       12 lshift
    add   A, A          ; 1:4       12 lshift
    ld    H, A          ; 1:4       12 lshift
    ld    L, 0x00       ; 2:7       12 lshift}){}dnl
dnl
dnl
dnl # 13 <<
dnl # x 13 lshift
dnl # ( x -- x)
dnl # shifts x left 13 places
define({_13LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_13LSHIFT},{13lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_13LSHIFT},{dnl
__{}define({__INFO},{13lshift}){}dnl

    ld    A, L          ; 1:4       13 lshift   ( u -- u<<13 )
    rrca                ; 1:4       13 lshift
    rrca                ; 1:4       13 lshift
    rrca                ; 1:4       13 lshift
    and  0xE0           ; 2:7       13 lshift
    ld    H, A          ; 1:4       13 lshift
    ld    L, 0x00       ; 2:7       13 lshift}){}dnl
dnl
dnl
dnl # 14 <<
dnl # x 14 lshift
dnl # ( x -- x)
dnl # shifts x left 14 places
define({_14LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_14LSHIFT},{14lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_14LSHIFT},{dnl
__{}define({__INFO},{14lshift}){}dnl

    ld    A, L          ; 1:4       14 lshift   ( u -- u<<14 )
    rrca                ; 1:4       14 lshift
    rrca                ; 1:4       14 lshift
    and  0xC0           ; 2:7       14 lshift
    ld    H, A          ; 1:4       14 lshift
    ld    L, 0x00       ; 2:7       14 lshift}){}dnl
dnl
dnl
dnl # 15 <<
dnl # x 15 lshift
dnl # ( x -- x)
dnl # shifts x left 15 places
define({_15LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_15LSHIFT},{15lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_15LSHIFT},{dnl
__{}define({__INFO},{15lshift}){}dnl

    xor   A             ; 1:4       15 lshift   ( u -- u<<15 )
    rr    L             ; 2:8       15 lshift
    ld    L, A          ; 1:4       15 lshift
    rra                 ; 1:4       15 lshift
    ld    H, A          ; 1:4       15 lshift}){}dnl
dnl
dnl
dnl # 16 <<
dnl # x 16 lshift
dnl # ( x -- x)
dnl # shifts x left 16 places
define({_16LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_16LSHIFT},{16lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_16LSHIFT},{dnl
__{}define({__INFO},{16lshift}){}dnl

    ld   HL, 0x0000     ; 3:10      16 lshift   ( u -- u<<16 )}){}dnl
dnl
dnl
dnl
dnl # 1 >>
dnl # x 1 rshift
dnl # ( u -- u )
dnl # shifts u right 1 place
define({_1RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_1RSHIFT},{1rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1RSHIFT},{dnl
__{}define({__INFO},{1rshift}){}dnl

    srl   H             ; 2:8       1 rshift   ( u -- u>>1 )
    rr    L             ; 2:8       1 rshift}){}dnl
dnl
dnl
dnl # 2 >>
dnl # x 2 rshift
dnl # ( u -- u )
dnl # shifts u right 2 places
define({_2RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_2RSHIFT},{2rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2RSHIFT},{dnl
__{}define({__INFO},{2rshift}){}dnl

    srl   H             ; 2:8       2 rshift   ( u -- u>>2 )
    rr    L             ; 2:8       2 rshift
    srl   H             ; 2:8       2 rshift
    rr    L             ; 2:8       2 rshift}){}dnl
dnl
dnl
dnl # 3 >>
dnl # x 3 rshift
dnl # ( u -- u )
dnl # shifts u right 3 places
define({_3RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_3RSHIFT},{3rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3RSHIFT},{dnl
__{}define({__INFO},{3rshift}){}dnl

    ld    A, L          ; 1:4       3 rshift   ( u -- u>>3 )
    srl   H             ; 2:8       3 rshift
    rra                 ; 1:4       3 rshift
    srl   H             ; 2:8       3 rshift
    rra                 ; 1:4       3 rshift
    srl   H             ; 2:8       3 rshift
    rra                 ; 1:4       3 rshift
    ld    L, A          ; 1:4       3 rshift}){}dnl
dnl
dnl
dnl # 4 >>
dnl # x 4 rshift
dnl # ( u -- u )
dnl # shifts u right 4 places
define({_4RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_4RSHIFT},{4rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4RSHIFT},{dnl
__{}define({__INFO},{4rshift}){}dnl

    ld    A, L          ; 1:4       4 rshift   ( u -- u>>4 )
    srl   H             ; 2:8       4 rshift
    rra                 ; 1:4       4 rshift
    srl   H             ; 2:8       4 rshift
    rra                 ; 1:4       4 rshift
    srl   H             ; 2:8       4 rshift
    rra                 ; 1:4       4 rshift
    srl   H             ; 2:8       4 rshift
    rra                 ; 1:4       4 rshift
    ld    L, A          ; 1:4       4 rshift}){}dnl
dnl
dnl
dnl
dnl # 5 >>
dnl # u 5 rshift
dnl # ( u -- u )
dnl # shifts u right 5 places
define({_5RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_5RSHIFT},{5rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_5RSHIFT},{dnl
__{}define({__INFO},{5rshift}){}dnl

    xor   A             ; 1:4       5 rshift   ( u -- u>>5 )
    add  HL, HL         ; 1:11      5 rshift
    adc   A, A          ; 1:4       5 rshift
    add  HL, HL         ; 1:11      5 rshift
    adc   A, A          ; 1:4       5 rshift
    add  HL, HL         ; 1:11      5 rshift
    adc   A, A          ; 1:4       5 rshift
    ld    L, H          ; 1:4       5 rshift
    ld    H, A          ; 1:4       5 rshift}){}dnl
dnl
dnl
dnl
dnl # 6 >>
dnl # u 6 rshift
dnl # ( u -- u )
dnl # shifts u right 6 places
define({_6RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_6RSHIFT},{6rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_6RSHIFT},{dnl
__{}define({__INFO},{6rshift}){}dnl

    xor   A             ; 1:4       6 rshift   ( u -- u>>6 )
    add  HL, HL         ; 1:11      6 rshift
    adc   A, A          ; 1:4       6 rshift
    add  HL, HL         ; 1:11      6 rshift
    adc   A, A          ; 1:4       6 rshift
    ld    L, H          ; 1:4       6 rshift
    ld    H, A          ; 1:4       6 rshift}){}dnl
dnl
dnl
dnl
dnl # 7 >>
dnl # u 7 rshift
dnl # ( u -- u )
dnl # shifts u right 7 places
define({_7RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_7RSHIFT},{7rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_7RSHIFT},{dnl
__{}define({__INFO},{7rshift}){}dnl

    xor   A             ; 1:4       7 rshift   ( u -- u>>7 )
    add  HL, HL         ; 1:11      7 rshift
    adc   A, A          ; 1:4       7 rshift
    ld    L, H          ; 1:4       7 rshift
    ld    H, A          ; 1:4       7 rshift}){}dnl
dnl
dnl
dnl # 8 >>
dnl # u 8 rshift
dnl # ( u -- u )
dnl # shifts u right 8 places
define({_8RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_8RSHIFT},{8rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_8RSHIFT},{dnl
__{}define({__INFO},{8rshift}){}dnl

    ld    L, H          ; 1:4       8 rshift   ( u -- u>>8 )
    ld    H, 0x00       ; 2:7       8 rshift}){}dnl
dnl
dnl
dnl # 9 >>
dnl # u 9 rshift
dnl # ( u -- u )
dnl # shifts u right 9 places
define({_9RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_9RSHIFT},{9rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_9RSHIFT},{dnl
__{}define({__INFO},{9rshift}){}dnl

    srl   H             ; 2:8       9 rshift   ( u -- u>>9 )
    ld    L, H          ; 1:4       9 rshift
    ld    H, 0x00       ; 2:7       9 rshift}){}dnl
dnl
dnl
dnl # 10 >>
dnl # u 10 rshift
dnl # ( u -- u )
dnl # shifts u right 10 places
define({_10RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_10RSHIFT},{10rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_10RSHIFT},{dnl
__{}define({__INFO},{10rshift}){}dnl

    srl   H             ; 2:8       10 rshift   ( u -- u>>10 )
    srl   H             ; 2:8       10 rshift
    ld    L, H          ; 1:4       10 rshift
    ld    H, 0x00       ; 2:7       10 rshift}){}dnl
dnl
dnl
dnl # 11 >>
dnl # u 11 rshift
dnl # ( u -- u )
dnl # shifts u right 11 places
define({_11RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_11RSHIFT},{11rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_11RSHIFT},{dnl
__{}define({__INFO},{11rshift}){}dnl

    ld    A, H          ; 1:4       11 rshift   ( u -- u>>11 )
    and  0xF8           ; 2:7       11 rshift
    rrca                ; 1:4       11 rshift
    rrca                ; 1:4       11 rshift
    rrca                ; 1:4       11 rshift
    ld    L, A          ; 1:4       11 rshift
    ld    H, 0x00       ; 2:7       11 rshift}){}dnl
dnl
dnl
dnl # 12 >>
dnl # u 12 rshift
dnl # ( u -- u )
dnl # shifts u right 12 places
define({_12RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_12RSHIFT},{12rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_12RSHIFT},{dnl
__{}define({__INFO},{12rshift}){}dnl

    ld    A, H          ; 1:4       12 rshift   ( u -- u>>12 )
    and  0xF0           ; 2:7       12 rshift
    rrca                ; 1:4       12 rshift
    rrca                ; 1:4       12 rshift
    rrca                ; 1:4       12 rshift
    rrca                ; 1:4       12 rshift
    ld    L, A          ; 1:4       12 rshift
    ld    H, 0x00       ; 2:7       12 rshift}){}dnl
dnl
dnl
dnl # 13 >>
dnl # u 13 rshift
dnl # ( u -- u )
dnl # shifts u right 13 places
define({_13RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_13RSHIFT},{13rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_13RSHIFT},{dnl
__{}define({__INFO},{13rshift}){}dnl

    ld    A, H          ; 1:4       13 rshift   ( u -- u>>13 )
    and  0xE0           ; 2:7       13 rshift
    rlca                ; 1:4       13 rshift
    rlca                ; 1:4       13 rshift
    rlca                ; 1:4       13 rshift
    ld    L, A          ; 1:4       13 rshift
    ld    H, 0x00       ; 2:7       13 rshift}){}dnl
dnl
dnl
dnl # 14 >>
dnl # u 14 rshift
dnl # ( u -- u )
dnl # shifts u right 14 places
define({_14RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_14RSHIFT},{14rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_14RSHIFT},{dnl
__{}define({__INFO},{14rshift}){}dnl

    ld    A, H          ; 1:4       14 rshift   ( u -- u>>14 )
    and  0xC0           ; 2:7       14 rshift
    rlca                ; 1:4       14 rshift
    rlca                ; 1:4       14 rshift
    ld    L, A          ; 1:4       14 rshift
    ld    H, 0x00       ; 2:7       14 rshift}){}dnl
dnl
dnl
dnl # 15 >>
dnl # u 15 rshift
dnl # ( u -- u )
dnl # shifts u right 15 places
define({_15RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_15RSHIFT},{15rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_15RSHIFT},{dnl
__{}define({__INFO},{15rshift}){}dnl

    xor   A             ; 1:4       15 rshift   ( u -- u>>15 )
    rl    H             ; 2:8       15 rshift
    ld    H, A          ; 1:4       15 rshift
    adc   A, A          ; 1:4       15 rshift
    ld    L, A          ; 1:4       15 rshift}){}dnl
dnl
dnl
dnl # 16 >>
dnl # u 16 rshift
dnl # ( u -- u )
dnl # shifts u right 16 places
define({_16RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_16RSHIFT},{16rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_16RSHIFT},{dnl
__{}define({__INFO},{16rshift}){}dnl

    ld   HL, 0x0000     ; 3:10      16 rshift   ( u -- u>>16 )}){}dnl
dnl
dnl
dnl
dnl # ( u -- u )
dnl # shifs u right $1 places
define({PUSH_RSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_RSHIFT},{push_rshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_RSHIFT},{dnl
__{}define({__INFO},{push_rshift}){}dnl
ifelse($1,{},{
__{}__{}    .error {$0}(): Missing address parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}    .error {$0}($@): Pointer as parameter is not supported!},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}    .error {$0}($@): M4 does not know the "{$1}" value and therefore cannot create the code!},
__{}__{}{dnl
__{}__{}__{}ifelse(eval($1),{0},{
__{}__{}__{}                        ;           $1 rshift},
__{}__{}__{}eval($1),{1},{__ASM_TOKEN_1RSHIFT},
__{}__{}__{}eval($1),{2},{__ASM_TOKEN_2RSHIFT},
__{}__{}__{}eval($1),{3},{__ASM_TOKEN_3RSHIFT},
__{}__{}__{}eval($1),{4},{__ASM_TOKEN_4RSHIFT},
__{}__{}__{}eval($1),{5},{__ASM_TOKEN_5RSHIFT},
__{}__{}__{}eval($1),{6},{__ASM_TOKEN_6RSHIFT},
__{}__{}__{}eval($1),{7},{__ASM_TOKEN_7RSHIFT},
__{}__{}__{}eval($1),{8},{__ASM_TOKEN_8RSHIFT},
__{}__{}__{}eval($1),{9},{__ASM_TOKEN_9RSHIFT},
__{}__{}__{}eval($1),{10},{__ASM_TOKEN_10RSHIFT},
__{}__{}__{}eval($1),{11},{__ASM_TOKEN_11RSHIFT},
__{}__{}__{}eval($1),{12},{__ASM_TOKEN_12RSHIFT},
__{}__{}__{}eval($1),{13},{__ASM_TOKEN_13RSHIFT},
__{}__{}__{}eval($1),{14},{__ASM_TOKEN_14RSHIFT},
__{}__{}__{}eval($1),{15},{__ASM_TOKEN_15RSHIFT},
__{}__{}__{}eval($1),{16},{__ASM_TOKEN_16RSHIFT},
__{}__{}__{}eval(($1)>16),{1},{
__{}__{}__{}                        ;           $1 rshift --> 16 rshift{}__ASM_TOKEN_16RSHIFT},
__{}__{}__{}{
__{}__{}__{}    .error {$0}($@): negative parameters found in macro! Use {PUSH_LSHIFT}(eval(-($1))).})})},
__{}__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!}){}dnl
}){}dnl
dnl
dnl
dnl # ( u -- u )
dnl # shifs u left $1 places
define({PUSH_LSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_LSHIFT},{push_lshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_LSHIFT},{dnl
__{}define({__INFO},{push_lshift}){}dnl
ifelse($1,{},{
__{}__{}    .error {$0}(): Missing address parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}    .error {$0}($@): Pointer as parameter is not supported!},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}    .error {$0}($@): M4 does not know the "{$1}" value and therefore cannot create the code!},
__{}__{}{dnl
__{}__{}__{}ifelse(eval($1),{0},{
__{}__{}__{}                        ;           $1 lshift},
__{}__{}__{}eval($1),{1},{__ASM_TOKEN_1LSHIFT},
__{}__{}__{}eval($1),{2},{__ASM_TOKEN_2LSHIFT},
__{}__{}__{}eval($1),{3},{__ASM_TOKEN_3LSHIFT},
__{}__{}__{}eval($1),{4},{__ASM_TOKEN_4LSHIFT},
__{}__{}__{}eval($1),{5},{__ASM_TOKEN_5LSHIFT},
__{}__{}__{}eval($1),{6},{__ASM_TOKEN_6LSHIFT},
__{}__{}__{}eval($1),{7},{__ASM_TOKEN_7LSHIFT},
__{}__{}__{}eval($1),{8},{__ASM_TOKEN_8LSHIFT},
__{}__{}__{}eval($1),{9},{__ASM_TOKEN_9LSHIFT},
__{}__{}__{}eval($1),{10},{__ASM_TOKEN_10LSHIFT},
__{}__{}__{}eval($1),{11},{__ASM_TOKEN_11LSHIFT},
__{}__{}__{}eval($1),{12},{__ASM_TOKEN_12LSHIFT},
__{}__{}__{}eval($1),{13},{__ASM_TOKEN_13LSHIFT},
__{}__{}__{}eval($1),{14},{__ASM_TOKEN_14LSHIFT},
__{}__{}__{}eval($1),{15},{__ASM_TOKEN_15LSHIFT},
__{}__{}__{}eval($1),{16},{__ASM_TOKEN_16LSHIFT},
__{}__{}__{}eval(($1)>16),{1},{
__{}__{}__{}                        ;           $1 lshift --> 16 lshift{}__ASM_TOKEN_16LSHIFT},
__{}__{}__{}{
__{}__{}__{}    .error {$0}($@): negative parameters found in macro! Use {PUSH_RSHIFT}(eval(-($1))).})})},
__{}__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # -------------------------- 8 bits --------------------------
dnl
dnl
dnl
dnl # ( -- )
define({AND_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_AND_REG8_REG8},{and($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_AND_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   ( -- )   $1 = $1 and $2
    and   format({%-14s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO
    ld    format({%-14s},{$1, A}); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- )
define({OR_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_OR_REG8_REG8},{or($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_OR_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   ( -- )   $1 = $1 or $2
    or    format({%-14s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO
    ld    format({%-14s},{$1, A}); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- )
define({XOR_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_XOR_REG8_REG8},{xor($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_XOR_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   ( -- )   $1 = $1 xor $2
    xor   format({%-14s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO
    ld    format({%-14s},{$1, A}); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x3 )  x3 = hi(x1) + lo(x2 & x1)
define({CAND},{dnl
__{}__ADD_TOKEN({__TOKEN_CAND},{cand},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CAND},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x3 )   x3 = hi(x1) + lo(x2 & x1)
    and   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x3 )  x3 = hi(x2 & x1) + lo(x1)
define({HAND},{dnl
__{}__ADD_TOKEN({__TOKEN_HAND},{hand},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HAND},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, D          ; 1:4       __INFO   ( x2 x1 -- x3 )   x3 = hi(x2 & x1) + lo(x1)
    and   H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x3 )  x3 = hi(x1) + lo(x2 | x1)
define({COR},{dnl
__{}__ADD_TOKEN({__TOKEN_COR},{cor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_COR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x3 )   x3 = hi(x1) + lo(x2 | x1)
    or    L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x3 )  x3 = hi(x2 | x1) + lo(x1)
define({HOR},{dnl
__{}__ADD_TOKEN({__TOKEN_HOR},{hor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, D          ; 1:4       __INFO   ( x2 x1 -- x3 )   x3 = hi(x2 | x1) + lo(x1)
    or    H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x3 )  x3 = hi(x1) + lo(x2 ^ x1)
define({CXOR},{dnl
__{}__ADD_TOKEN({__TOKEN_CXOR},{cxor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CXOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x3 )   x3 = hi(x1) + lo(x2 ^ x1)
    xor   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x3 )  x3 = hi(x2 ^ x1) + lo(x1)
define({HXOR},{dnl
__{}__ADD_TOKEN({__TOKEN_HXOR},{hxor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HXOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, D          ; 1:4       __INFO   ( x2 x1 -- x3 )   x3 = hi(x2 ^ x1) + lo(x1)
    xor   H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x3 )  x3 = hi(x1) + lo(x2 & x1)
define({OVER_SWAP_CAND},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_CAND},{over swap cand},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_CAND},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x2 x3 )   x3 = hi(x1) + lo(x2 & x1)
    and   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x3 )  x3 = hi(x2 & x1) + lo(x1)
define({OVER_SWAP_HAND},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_HAND},{over swap hand},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_HAND},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, D          ; 1:4       __INFO   ( x2 x1 -- x2 x3 )   x3 = hi(x2 & x1) + lo(x1)
    and   H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x3 )  x3 = hi(x1) + lo(x2 | x1)
define({OVER_SWAP_COR},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_COR},{over swap cor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_COR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x2 x3 )   x3 = hi(x1) + lo(x2 | x1)
    or    L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x3 )  x3 = hi(x2 | x1) + lo(x1)
define({OVER_SWAP_HOR},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_HOR},{over swap hor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_HOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, D          ; 1:4       __INFO   ( x2 x1 -- x2 x3 )   x3 = hi(x2 | x1) + lo(x1)
    or    H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x3 )  x3 = hi(x1) + lo(x2 ^ x1)
define({OVER_SWAP_CXOR},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_CXOR},{over swap cxor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_CXOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO   ( x2 x1 -- x2 x3 )   x3 = hi(x1) + lo(x2 ^ x1)
    xor   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x3 )  x3 = hi(x2 ^ x1) + lo(x1)
define({OVER_SWAP_HXOR},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_HXOR},{over swap hxor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_HXOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, D          ; 1:4       __INFO   ( x2 x1 -- x2 x3 )   x3 = hi(x2 ^ x1) + lo(x1)
    xor   H             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- f )
define({EQ_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_EQ_REG8_REG8},{eq($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_EQ_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   ( -- f )   f = ($1 == $2)
    xor   format({%-14s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO
    sub  0x01           ; 2:7       __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- f )
define({NE_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_NE_REG8_REG8},{ne($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_NE_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   ( -- f )   f = ($1 <> $2)
    xor   format({%-14s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO
    add   A, 0xFF       ; 2:7       __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- f )
define({ULT_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_ULT_REG8_REG8},{ult($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_ULT_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   ( -- f )   f = ($1 < $2)
    sub   format({%-14s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO   $1<$2 --> $1-$2<0 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- f )
define({ULE_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_ULE_REG8_REG8},{ule($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_ULE_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   ( -- f )   f = ($1 <= $2) = ($1 < $2 + 1)
    scf                 ; 1:4       __INFO
    sbc   A, format({%-11s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO   $1<$2+1 --> $1-$2-1<0 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- f )
define({UGT_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_UGT_REG8_REG8},{ugt($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_UGT_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO   ( -- f )   f = ($1 > $2)
    sub   format({%-14s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   $1>$2 --> 0>$2-$1 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- f )
define({UGE_REG8_REG8},{dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{dnl
__{}__ADD_TOKEN({__TOKEN_UGE_REG8_REG8},{uge($1,$2)},$@){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_UGE_REG8_REG8},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(
eval($#<2),1,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_REG($1),0,{
__{}  .error {$0}($@): $1 is not register name!},
__IS_REG($2),0,{
__{}  .error {$0}($@): $2 is not register name!},
{
    ld    A, format({%-11s},$2); ifelse(len($2),1,{1:4},len($2),3,{2:8},{?:?})       __INFO   ( -- f )   f = ($1 >= $2) = ($1 + 1 > $2)
    scf                 ; 1:4       __INFO
    sbc   A, format({%-11s},$1); ifelse(len($1),1,{1:4},len($1),3,{2:8},{?:?})       __INFO   $1+1>$2 --> 0>$2-$1-1 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO
}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # C=
dnl # ( x1 x2 -- flag )
dnl # equal ( lo(x1) == lo(x2) )
define({CEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_CEQ},{c=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:40]     __INFO   ( x1 x2 -- flag )  flag: lo(x1) == lo(x2)
    ld    A, L          ; 1:4       __INFO
    xor   E             ; 1:4       __INFO   ignores higher bytes
    sub  0x01           ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # 8 rshift swap 8 rshift C=
dnl # ( x1 x2 -- flag )
dnl # equal ( hi(x1) == hi(x2) )
define({HEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_HEQ},{h=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:40]     __INFO   ( x1 x2 -- flag )  flag: hi(x1) == hi(x2)
    ld    A, H          ; 1:4       __INFO
    xor   D             ; 1:4       __INFO   ignores lower bytes
    sub  0x01           ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # C<>
dnl # ( x1 x2 -- flag )
dnl # not equal ( lo(x1) <> lo(x2) )
define({CNE},{dnl
__{}__ADD_TOKEN({__TOKEN_CNE},{c<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:40]     __INFO   ( x1 x2 -- flag )  flag: lo(x1) <> lo(x2)
    ld    A, L          ; 1:4       __INFO
    xor   E             ; 1:4       __INFO   ignores higher bytes
    add   A, 0xFF       ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # 8 rshift swap 8 rshift  C<>
dnl # ( c1 c2 -- flag )
dnl # not equal ( hi(x1) <> hi(x2) )
define({HNE},{dnl
__{}__ADD_TOKEN({__TOKEN_HNE},{h<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:40]     __INFO   ( x1 x2 -- flag )  flag: hi(x1) <> hi(x2)
    ld    A, H          ; 1:4       __INFO
    xor   D             ; 1:4       __INFO   ignores lower bytes
    add   A, 0xFF       ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- flag )
dnl # unsigned ( lo(u2) < lo(u1) )
define({CULT},{dnl
__{}__ADD_TOKEN({__TOKEN_CULT},{cu<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CULT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:33]     __INFO   ( u2 u1 -- f )  f = lo(u2) < lo(u1)
    ld    A, E          ; 1:4       __INFO
    sub   L             ; 1:4       __INFO   E<L --> E-L<0 --> carry if true
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- flag )
dnl # unsigned ( hi(u2) < hi(u1) )
define({HULT},{dnl
__{}__ADD_TOKEN({__TOKEN_HULT},{hu<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HULT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:33]     __INFO   ( u2 u1 -- f )  f = hi(u2) < hi(u1)
    ld    A, D          ; 1:4       __INFO
    sub   H             ; 1:4       __INFO   D<H --> D-H<0 --> carry if true
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- flag )
dnl # unsigned ( lo(u2) > lo(u1) )
define({CUGT},{dnl
__{}__ADD_TOKEN({__TOKEN_CUGT},{cu>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CUGT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:33]     __INFO   ( u2 u1 -- f )  f = lo(u2) > lo(u1)
    ld    A, L          ; 1:4       __INFO
    sub   E             ; 1:4       __INFO   E>L --> 0>L-E --> carry if true
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- flag )
dnl # unsigned ( hi(u2) > hi(u1) )
define({HUGT},{dnl
__{}__ADD_TOKEN({__TOKEN_HUGT},{hu>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HUGT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:33]     __INFO   ( u2 u1 -- f )  f = hi(u2) > hi(u1)
    ld    A, H          ; 1:4       __INFO
    sub   D             ; 1:4       __INFO   D>H --> 0>H-D --> carry if true
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- flag )
dnl # unsigned ( lo(u2) >= lo(u1) )
define({CUGE},{dnl
__{}__ADD_TOKEN({__TOKEN_CUGE},{cu>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CUGE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:37]     __INFO   ( u2 u1 -- f )  f = lo(u2) >= lo(u1)
    ld    A, L          ; 1:4       __INFO
    scf                 ; 1:4       __INFO
    sbc   A, E          ; 1:4       __INFO   E>=L --> E+1>L --> 0>L-E-1 --> carry if true
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- flag )
dnl # unsigned ( hi(u2) >= hi(u1) )
define({HUGE},{dnl
__{}__ADD_TOKEN({__TOKEN_HUGE},{hu>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HUGE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:37]     __INFO   ( u2 u1 -- f )  f = hi(u2) >= hi(u1)
    ld    A, H          ; 1:4       __INFO
    scf                 ; 1:4       __INFO
    sbc   A, D          ; 1:4       __INFO   D>=H --> D+1>H --> 0>H-D-1 --> carry if true
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- flag )
dnl # unsigned ( lo(u2) <= lo(u1) )
define({CULE},{dnl
__{}__ADD_TOKEN({__TOKEN_CULE},{cu<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CULE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:37]     __INFO   ( u2 u1 -- f )  f = lo(u2) <= lo(u1)
    ld    A, E          ; 1:4       __INFO
    scf                 ; 1:4       __INFO
    sbc   A, L          ; 1:4       __INFO   E<=L --> E<L+1 --> E-L-1<0 --> carry if true
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- flag )
dnl # unsigned ( hi(u2) <= hi(u1) )
define({HULE},{dnl
__{}__ADD_TOKEN({__TOKEN_HULE},{hu<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HULE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:37]     __INFO   ( u2 u1 -- f )  f = hi(u2) <= hi(u1)
    ld    A, D          ; 1:4       __INFO
    scf                 ; 1:4       __INFO
    sbc   A, H          ; 1:4       __INFO   D<=H --> D<H+1 --> D-H-1<0 --> carry if true
    sbc  HL, HL         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # C=
dnl # ( x2 x1 -- x2 x1 flag )
dnl # equal ( lo x1 == lo x2 )
define({_2DUP_CEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CEQ},{2dup c=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:45]     __INFO   ( x2 x1 -- x2 x1 flag )  flag: lo(x1) == lo(x2)
    ld    A, L          ; 1:4       __INFO
    xor   E             ; 1:4       __INFO   ignores higher bytes
    sub  0x01           ; 2:7       __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO
}){}dnl
dnl
dnl
dnl
dnl # 8 rshift swap 8 rshift C=
dnl # ( x2 x1 -- x2 x1 flag )
dnl # equal ( hi x1 == hi x2 )
define({_2DUP_HEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HEQ},{2dup h=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:45]     __INFO   ( x2 x1 -- x2 x1 flag )  flag: hi(x1) == hi(x2)
    ld    A, H          ; 1:4       __INFO
    xor   D             ; 1:4       __INFO   ignores lower bytes
    sub  0x01           ; 2:7       __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # C<>
dnl # ( u2 u1 -- u2 u1 flag )
dnl # not equal ( lo u2 <> lo u1 )
define({_2DUP_CNE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CNE},{2dup c<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:45]     __INFO   ( u2 u1 -- u2 u1 flag )  flag: lo(u2) <> lo(u1)
    ld    A, L          ; 1:4       __INFO
    xor   E             ; 1:4       __INFO   ignores higher bytes
    add   A, 0xFF       ; 2:7       __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # 8 rshift swap 8 rshift  C<>
dnl # ( u2 u1 -- u2 u1 flag )
dnl # not equal ( hi u2 <> hi u1 )
define({_2DUP_HNE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HNE},{2dup h<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:45]     __INFO   ( u2 u1 -- u2 u1 flag )  flag: hi(u2) <> hi(u1)
    ld    A, H          ; 1:4       __INFO
    xor   D             ; 1:4       __INFO   ignores lower bytes
    add   A, 0xFF       ; 2:7       __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- u2 u1 flag )
dnl # unsigned ( lo(x2) < lo(x1) )
define({_2DUP_CULT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CULT},{2dup cu<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CULT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:38]     __INFO
    ld    A, E          ; 1:4       __INFO
    sub   L             ; 1:4       __INFO   E<L --> E-L<0 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- u2 u1 flag )
dnl # unsigned ( hi(x2) < hi(x1) )
define({_2DUP_HULT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HULT},{2dup hu<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HULT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:38]     __INFO
    ld    A, D          ; 1:4       __INFO
    sub   H             ; 1:4       __INFO   D<H --> D-H<0 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- u2 u1 flag )
dnl # unsigned ( lo(x2) > lo(x1) )
define({_2DUP_CUGT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CUGT},{2dup cu>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CUGT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:38]     __INFO
    ld    A, L          ; 1:4       __INFO
    sub   E             ; 1:4       __INFO   E>L --> 0>L-E --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- u2 u1 flag )
dnl # unsigned ( hi(x2) > hi(x1) )
define({_2DUP_HUGT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HUGT},{2dup hu>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HUGT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:38]     __INFO
    ld    A, H          ; 1:4       __INFO
    sub   D             ; 1:4       __INFO   D>H --> 0>H-D --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- u2 u1 flag )
dnl # unsigned ( lo(x2) >= lo(x1) )
define({_2DUP_CUGE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CUGE},{2dup cu>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CUGE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:42]     __INFO
    ld    A, L          ; 1:4       __INFO
    scf                 ; 1:4       __INFO
    sbc   A, E          ; 1:4       __INFO   E>=L --> E+1>L --> 0>L-E-1 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- u2 u1 flag )
dnl # unsigned ( hi(x2) >= hi(x1) )
define({_2DUP_HUGE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HUGE},{2dup hu>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HUGE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:42]     __INFO
    ld    A, H          ; 1:4       __INFO
    scf                 ; 1:4       __INFO
    sbc   A, D          ; 1:4       __INFO   D>=H --> D+1>H --> 0>H-D-1 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- u2 u1 flag )
dnl # unsigned ( lo(x2) <= lo(x1) )
define({_2DUP_CULE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CULE},{2dup cu<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CULE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:42]     __INFO
    ld    A, E          ; 1:4       __INFO
    scf                 ; 1:4       __INFO
    sbc   A, L          ; 1:4       __INFO   E<=L --> E<L+1 --> E-L-1<0 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( u2 u1 -- u2 u1 flag )
dnl # unsigned ( hi(x2) <= hi(x1) )
define({_2DUP_HULE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HULE},{2dup hu<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HULE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:42]     __INFO
    ld    A, D          ; 1:4       __INFO
    scf                 ; 1:4       __INFO
    sbc   A, H          ; 1:4       __INFO   D<=H --> D<H+1 --> D-H-1<0 --> carry if true
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
define({DUP_PUSH_CEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CEQ},{dup $1 c=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CEQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( x -- x f )   __HEX_HL($1) == HL}){}dnl
__{}ifelse($1,{},{dnl
__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}                       ;[10:54]     _TMP_INFO   ( char -- char f )   L == (addr)
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A,format({%-12s},$1); 3:13      _TMP_INFO
__{}__{}    sub   L             ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__IS_NUM($1),{0},{
__{}__{}                        ;[9:48]     _TMP_INFO   ( char -- char f )   L = $1
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, __FORM({%-11s},$1); 2:7       _TMP_INFO
__{}__{}    sub   L             ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__SAVE_EVAL($1),{0},{
__{}__{}                        ;[7:41]     _TMP_INFO   ( char -- char f )   L == 0
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, L          ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__SAVE_EVAL($1),{255},{
__{}__{}                        ;[7:41]     _TMP_INFO   ( char -- char f )   L == 255
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, L          ; 1:4       _TMP_INFO
__{}__{}    add   A, 0x01       ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__SAVE_EVAL($1),{1},{
__{}__{}                        ;[8:45]     _TMP_INFO   ( char -- char f )   L == 1
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, L          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__SAVE_EVAL($1),{254},{
__{}__{}                        ;[8:45]     _TMP_INFO   ( char -- char f )   L == 254
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, L          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}    add   A, 0x01       ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}{
__{}__{}                        ;[9:48]     _TMP_INFO   ( char -- char f )   L == $1
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, __FORM({%-11s},$1); 2:7       _TMP_INFO
__{}__{}    sub   L             ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1}){}dnl
}){}dnl
dnl
dnl
dnl
define({DUP_PUSH_HEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_HEQ},{dup $1 h=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_HEQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( x -- x f )   __HEX_HL($1) == HL}){}dnl
__{}ifelse($1,{},{dnl
__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}                       ;[10:54]     _TMP_INFO   ( char -- char f )   H == (addr+1)
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A,format({%-12s},($1+1)); 3:13      _TMP_INFO
__{}__{}    sub   H             ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__IS_NUM($1),{0},{
__{}__{}                        ;[9:48]     _TMP_INFO   ( char -- char f )   H = high $1
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A,__FORM({%-12s},high $1); 2:7       _TMP_INFO
__{}__{}    sub   H             ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__HEX_H($1),{0x00},{
__{}__{}                        ;[7:41]     _TMP_INFO   ( char -- char f )   H == 0
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, H          ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__HEX_H($1),{0xFF},{
__{}__{}                        ;[7:41]     _TMP_INFO   ( char -- char f )   H == 255
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, H          ; 1:4       _TMP_INFO
__{}__{}    add   A, 0x01       ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__HEX_H($1),{0x01},{
__{}__{}                        ;[8:45]     _TMP_INFO   ( char -- char f )   H == 1
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, L          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}__HEX_H($1),{0xFE},{
__{}__{}                        ;[8:45]     _TMP_INFO   ( char -- char f )   H == 254
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, L          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}    add   A, 0x01       ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1},
__{}{
__{}__{}                        ;[9:48]     _TMP_INFO   ( char -- char f )   H == __HEX_H($1)
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       _TMP_INFO
__{}__{}    sub   H             ; 1:4       _TMP_INFO
__{}__{}    sub  0x01           ; 2:7       _TMP_INFO
__{}__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag char==$1}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 0 C=
dnl # ( c1 -- flag )  flag = lo c1 == 0
define({_0CEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_0CEQ},{0 c=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0CEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:26]     __INFO   ( c1 -- flag )  flag = lo(c1) == 0
    ld    A, L          ; 1:4       __INFO   ignores higher bytes
    sub  0x01           ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # 8 rshift 0 C=
dnl # ( c1 -- flag )  flag = hi c1 == 0
define({_0HEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_0HEQ},{0 h=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0HEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:26]     __INFO   ( c1 -- flag )  flag = hi(c1) == 0
    ld    A, H          ; 1:4       __INFO   ignores lower bytes
    sub  0x01           ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # C@ 0 C=
dnl # ( addr -- flag )  flag = byte from (addr) == 0
define({CFETCH_0CEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_CFETCH_0CEQ},{c@ 0 c=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CFETCH_0CEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:29]     __INFO   ( addr -- flag )  flag = byte from (addr) == 0
    ld    A,(HL)        ; 1:7       __INFO
    sub  0x01           ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # 0 C<>
dnl # ( c1 -- flag )  flag = lo c1 <> 0
define({_0CNE},{dnl
__{}__ADD_TOKEN({__TOKEN_0CNE},{0 c<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0CNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:26]     __INFO   ( c1 -- flag )  flag = lo(c1) <> 0
    ld    A, L          ; 1:4       __INFO   ignores higher bytes
    add   A, 0xFF       ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # 8 rshift 0 C<>
dnl # ( c1 -- flag )  flag = hi c1 <> 0
define({_0HNE},{dnl
__{}__ADD_TOKEN({__TOKEN_0HNE},{0 h<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0HNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:26]     __INFO   ( c1 -- flag )  flag = hi(c1) <> 0
    ld    A, H          ; 1:4       __INFO   ignores lower bytes
    add   A, 0xFF       ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # C@ 0 C<>
dnl # ( addr -- flag )  flag = byte from (addr) <> 0
define({CFETCH_0CNE},{dnl
__{}__ADD_TOKEN({__TOKEN_CFETCH_0CNE},{c@ 0 c<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CFETCH_0CNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:29]     __INFO   ( addr -- flag )  flag = byte from (addr) <> 0
    ld    A,(HL)        ; 1:7       __INFO
    add   A, 0xFF       ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # over C@ over C@ C=
dnl # ( addr2 addr1 -- addr2 addr1 flag )
dnl # flag = char2 == char1
dnl # 8-bit compares the contents of two addresses.
define({OVER_CFETCH_OVER_CFETCH_CEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_CFETCH_OVER_CFETCH_CEQ},{over_cfetch_over_cfetch_ceq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_CFETCH_OVER_CFETCH_CEQ},{dnl
__{}define({__INFO},{over_cfetch_over_cfetch_ceq}){}dnl

                        ;[8:51]     over @C over @C C= over_cfetch_over_cfetch_ceq ( addr2 addr1 -- addr2 addr1 flag(char2==char1) )
    push DE             ; 1:11      over @C over @C C= over_cfetch_over_cfetch_ceq
    ex   DE, HL         ; 1:4       over @C over @C C= over_cfetch_over_cfetch_ceq
    ld    A, (DE)       ; 1:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    xor (HL)            ; 1:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    sub  0x01           ; 2:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    sbc  HL, HL         ; 2:15      over @C over @C C= over_cfetch_over_cfetch_ceq}){}dnl
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
define({DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_DLSHIFT},{dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DLSHIFT},{dnl
__{}define({__INFO},{dlshift}){}dnl
__def({USE_DLSHIFT})
    call LSHIFT32       ; 3:17      D<<   ( d1 u -- d )  d = d1 << u}){}dnl
dnl
dnl
dnl
dnl # ( d1 1 -- d )  d = d1 << 1
dnl # shifts d1 left 1 bits
define({_1_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_1_DLSHIFT},{1 dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1_DLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    add  HL, HL         ; 1:11      __INFO  ( d1 1 -- d )  d = d1 << 1
    rl    E             ; 2:8       __INFO
    rl    D             ; 2:8       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 1 -- pd )  [pd] <<= 1
dnl # shifts [pd] left 1 bits
define({_1_PDLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_1_PDLSHIFT},{1 pdlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1_PDLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    C, L          ; 1:4       __INFO  ( pd 1 -- pd )  [pd] <<= 1  with align 4
    sla (HL)            ; 2:15      __INFO  Thnx Busy!
    inc   L             ; 1:4       __INFO
    rl  (HL)            ; 2:15      __INFO
    inc   L             ; 1:4       __INFO
    rl  (HL)            ; 2:15      __INFO
    inc   L             ; 1:4       __INFO
    rl  (HL)            ; 2:15      __INFO
    ld    L, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( p1 -- p1 )
dnl # [p1] <<= 1
define({_1_PLSHIFT},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_1_PLSHIFT},{1 plshift{}eval(($1)*8)},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1_PLSHIFT},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    sla (HL)            ; 2:15      __INFO   ( p{}eval(8*($1)) -- p{}eval(8*($1)) )  [p{}eval(8*($1))] <<= 1  with align $1},
__{}eval($1),2,{
__{}    sla (HL)            ; 2:15      __INFO   ( p{}eval(8*($1)) -- p{}eval(8*($1)) )  [p{}eval(8*($1))] <<= 1  with align $1
__{}    inc   L             ; 1:4       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    dec   L             ; 1:4       __INFO},
__{}eval($1),3,{
__{}    sla (HL)            ; 2:15      __INFO   ( p{}eval(8*($1)) -- p{}eval(8*($1)) )  [p{}eval(8*($1))] <<= 1  with align $1
__{}    inc   L             ; 1:4       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO},
__{}eval($1),4,{
__{}    sla (HL)            ; 2:15      __INFO   ( p{}eval(8*($1)) -- p{}eval(8*($1)) )  [p{}eval(8*($1))] <<= 1  with align $1
__{}    ld    C, L          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    ld    L, C          ; 1:4       __INFO},
__{}eval($1),256,{
__{}    or    A             ; 1:4       __INFO   ( p{}eval(8*($1)) -- p{}eval(8*($1)) )  [p{}eval(8*($1))] <<= 1  with align $1
__{}    rl  (HL)            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    jr   nz, $-3        ; 2:7/12    __INFO
__{}    ld    L, 0x00       ; 2:7       __INFO},
__{}{
__{}    sla (HL)            ; 2:15      __INFO   ( p{}eval(8*($1)) -- p{}eval(8*($1)) )  [p{}eval(8*($1))] <<= 1  with align $1
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1-1)       ; 2:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    djnz $-3            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( d1 4 -- d )  d = d1 << 4
dnl # shifts d1 left 4 bits
define({_4_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_4_DLSHIFT},{4 dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4_DLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO  ( d1 4 -- d )  d = d1 << 4
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO
    rl    D             ; 2:8       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO
    rl    D             ; 2:8       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO
    rl    D             ; 2:8       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO
    rl    D             ; 2:8       __INFO
    ld    E, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 4 -- pd )  [pd] <<= 4
dnl # shifts [pd] left 4 bits
define({_4_PDLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_4_PDLSHIFT},{4 pdlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4_PDLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    xor   A             ; 1:4       __INFO  ( pd 4 -- pd )  [pd] <<= 4  with align 4
    rld                 ; 2:18      __INFO  A(HL)=0xA021-->0xA210
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA243-->0xA432
    inc   L             ; 1:4       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA465-->0xA654
    inc   L             ; 1:4       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA687-->0xA876
    ld    L, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 8 -- d )  d = d1 << 8
dnl # shifts d1 left 8 bits
define({_8_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_8_DLSHIFT},{8 dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_8_DLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    D, E          ; 1:4       __INFO  ( d1 8 -- d )  d = d1 << 8
    ld    E, H          ; 1:4       __INFO
    ld    H, L          ; 1:4       __INFO
    ld    L, 0x00       ; 2:7       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 8 -- pd )  [pd] <<= 8
dnl # shifts [pd] left 8 bits
define({_8_PDLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_8_PDLSHIFT},{8 pdlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_8_PDLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    C, L          ; 1:4       __INFO  ( pd 8 -- pd )  [pd] <<= 8  with align 4
    ld    A,(HL)        ; 1:7       __INFO
    ld  (HL),0x00       ; 2:10      __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    ld  (HL),B          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 12 -- d )  d = d1 << 12
dnl # shifts d1 left 12 bits
define({_12_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_12_DLSHIFT},{12 dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_12_DLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO  ( d1 12 -- d )  d = d1 << 12
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO
    ld    D, A          ; 1:4       __INFO
    ld    E, H          ; 1:4       __INFO
    ld    H, L          ; 1:4       __INFO
    ld    L, 0x00       ; 2:7       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 12 -- pd )  [pd] <<= 12
dnl # shifts [pd] left 12 bits
define({_12_PDLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_12_PDLSHIFT},{12 pdlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_12_PDLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    xor   A             ; 1:4       __INFO  ( pd 12 -- pd )  [pd] <<= 12  with align 4
    ld    C,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO  0x00
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),C          ; 1:7       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA021-->0xA210
    inc   L             ; 1:4       __INFO
    ld    C,(HL)        ; 1:7       __INFO
    ld  (HL),B          ; 1:7       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA243-->0xA432
    inc   L             ; 1:4       __INFO
    ld  (HL),C          ; 1:7       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA465-->0xA654
    dec   L             ; 1:4       __INFO
    dec   L             ; 1:4       __INFO
    dec   L             ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 16 -- d )  d = d1 << 16
dnl # shifts d1 left 16 bits
define({_16_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_16_DLSHIFT},{16 dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_16_DLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex   DE, HL         ; 1:4       __INFO  ( d1 16 -- d )  d = d1 << 16
    ld   HL, 0x0000     ; 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 16 -- pd )  [pd] <<= 16
dnl # shifts [pd] left 16 bits
define({_16_PDLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_16_PDLSHIFT},{16 pdlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_16_PDLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    C, L          ; 1:4       __INFO  ( pd 16 -- pd )  [pd] <<= 16  with align 4
    ld    A,(HL)        ; 1:7       __INFO
    ld  (HL),0x00       ; 2:10      __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),0x00       ; 2:10      __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 20 -- d )  d = d1 << 20
dnl # shifts d1 left 20 bits
define({_20_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_20_DLSHIFT},{20 dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_20_DLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    add  HL, HL         ; 1:11      __INFO  ( d1 20 -- d )  d = d1 << 20
    add  HL, HL         ; 1:11      __INFO
    add  HL, HL         ; 1:11      __INFO
    add  HL, HL         ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, 0x0000     ; 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 20 -- pd )  [pd] <<= 20
dnl # shifts [pd] left 20 bits
define({_20_PDLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_20_PDLSHIFT},{20 pdlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_20_PDLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    xor   A             ; 1:4       __INFO  ( pd 20 -- pd )  [pd] <<= 20  with align 4
    ld    C,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),C          ; 1:7       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA021-->0xA210
    inc   L             ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA243-->0xA432
    dec   L             ; 1:4       __INFO
    dec   L             ; 1:4       __INFO
    dec   L             ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 24 -- d )  d = d1 << 24
dnl # shifts d1 left 24 bits
define({_24_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_24_DLSHIFT},{24 dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_24_DLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    D, L          ; 1:4       __INFO  ( d1 24 -- d )  d = d1 << 24
    ld   HL, 0x0000     ; 3:10      __INFO
    ld    E, L          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 24 -- pd )  [pd] <<= 24
dnl # shifts [pd] left 24 bits
define({_24_PDLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_24_PDLSHIFT},{24 pdlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_24_PDLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    C, L          ; 1:4       __INFO  ( pd 24 -- pd )  [pd] <<= 24  with align 4
    xor   A             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 28 -- d )  d = d1 << 28
dnl # shifts d1 left 28 bits
define({_28_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_28_DLSHIFT},{28 dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_28_DLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, L          ; 1:4       __INFO  ( d1 28 -- d )  d = d1 << 28
    add   A, A          ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO
    ld    D, A          ; 1:4       __INFO
    ld   HL, 0x0000     ; 3:10      __INFO
    ld    E, L          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 28 -- pd )  [pd] <<= 28
dnl # shifts [pd] left 28 bits
define({_28_PDLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_28_PDLSHIFT},{28 pdlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_28_PDLSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    C, L          ; 1:4       __INFO  ( pd 28 -- pd )  [pd] <<= 28  with align 4
    xor   A             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO
    rld                 ; 2:18      __INFO  A(HL)=0xA021-->0xA210
    ld    L, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 u -- d )  d = d1 << u
dnl # shifts d1 left u places
define({ROT_DLSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_DLSHIFT},{rot_dlshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_DLSHIFT},{dnl
__{}define({__INFO},{rot_dlshift}){}dnl
__def({USE_ROT_DLSHIFT})
    pop  BC             ; 1:10      rot D<<   ( d1 -- d )  d = d1 << BC
    call BC_LSHIFT32    ; 3:17      rot D<<}){}dnl
dnl
dnl
dnl
dnl # ( d1 u -- d )  d = d1 >> u
dnl # shifts d1 right u places
define({DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_DRSHIFT},{drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DRSHIFT},{dnl
__{}define({__INFO},{drshift}){}dnl
__def({USE_DRSHIFT})
    call RSHIFT32       ; 3:17      D>>   ( d1 u -- d )  d = d1 >> u}){}dnl
dnl
dnl
dnl
dnl # ( d1 1 -- d )  d = d1 >> 1
dnl # shifts d1 right 1 bits
define({_1_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_1_DRSHIFT},{1 drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1_DRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    srl   D             ; 2:8       __INFO  ( d1 1 -- d )  d = d1 >> 1
    rr    E             ; 2:8       __INFO
    rr    H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 1 -- pd )  [pd] >>= 1
dnl # shifts [pd] right 1 bits
define({_1_PDRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_1_PDRSHIFT},{1 pdrshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1_PDRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc   L             ; 1:4       __INFO  ( pd 1 -- pd )  [pd] >>= 1  with align 4
    inc   L             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    srl (HL)            ; 2:15      __INFO  Thnx Busy!
    dec   L             ; 1:4       __INFO
    rr  (HL)            ; 2:15      __INFO
    dec   L             ; 1:4       __INFO
    rr  (HL)            ; 2:15      __INFO
    dec   L             ; 1:4       __INFO
    rr  (HL)            ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 4 -- d )  d = d1 << 4
dnl # shifts d1 right 4 bits
define({_4_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_4_DRSHIFT},{4 drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4_DRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(1,1,{
                       ;[25:128]    __INFO  ( d1 4 -- d )  d = d1 >> 4
    ld    A, E          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  654321->5432.10
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  654321->5432.10
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  654321->5432.10
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  654321->5432.10
    adc   A, A          ; 1:4       __INFO
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    ld    A, E          ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  8765->0876
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  8765->0876
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  8765->0876
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  8765->0876
    rra                 ; 1:4       __INFO
    ld    E, A          ; 1:4       __INFO},
1,1,{
                       ;[30:120]    __INFO  ( d1 4 -- d )  d = d1 >> 4
    ld    A, E          ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  87654321->08765432
    rra                 ; 1:4       __INFO
    rr    H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO
    srl   D             ; 2:8       __INFO  87654321->08765432
    rra                 ; 1:4       __INFO
    rr    H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO
    srl   D             ; 2:8       __INFO  87654321->08765432
    rra                 ; 1:4       __INFO
    rr    H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO
    srl   D             ; 2:8       __INFO  87654321->08765432
    rra                 ; 1:4       __INFO
    rr    H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO
    ld    E, A          ; 1:4       __INFO},
{
                       ;[24:152]    __INFO  ( d1 4 -- d )  d = d1 >> 4
    ld    A, E          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  654321->5432.10
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  654321->5432.10
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  654321->5432.10
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  654321->5432.10
    adc   A, A          ; 1:4       __INFO
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    xor   A             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  008765->0876.50
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  008765->0876.50
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  008765->0876.50
    adc   A, A          ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO  008765->0876.50
    adc   A, A          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    E, D          ; 1:4       __INFO
    ld    D, A          ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( pd 4 -- pd )  [pd] >>= 4
dnl # shifts [pd] right 4 bits
define({_4_PDRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_4_PDRSHIFT},{4 pdrshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4_PDRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc   L             ; 1:4       __INFO  ( pd 4 -- pd )  [pd] >>= 4  with align 4
    inc   L             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    xor   A             ; 1:4       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA087-->0xA708
    dec   L             ; 1:4       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA765-->0xA576
    dec   L             ; 1:4       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA543-->0xA354
    dec   L             ; 1:4       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA321-->0xA132}){}dnl
dnl
dnl
dnl
dnl # ( d1 8 -- d )  d = d1 >> 8
dnl # shifts d1 right 8 bits
define({_8_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_8_DRSHIFT},{8 drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_8_DRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    L, H          ; 1:4       __INFO  ( d1 8 -- d )  d = d1 >> 8
    ld    H, E          ; 1:4       __INFO
    ld    E, D          ; 1:4       __INFO
    ld    D, 0x00       ; 2:7       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 8 -- pd )  [pd] >>= 8
dnl # shifts [pd] right 8 bits
define({_8_PDRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_8_PDRSHIFT},{8 pdrshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_8_PDRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc   L             ; 1:4       __INFO  ( pd 8 -- pd )  [pd] >>= 8  with align 4
    inc   L             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    ld  (HL),0x00       ; 2:10      __INFO
    dec   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    ld  (HL),B          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 12 -- d )  d = d1 >> 12
dnl # shifts d1 right 12 bits
define({_12_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_12_DRSHIFT},{12 drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_12_DRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO  ( d1 12 -- d )  d = d1 >> 12
    srl   D             ; 2:8       __INFO  876543..->087654..
    rr    E             ; 2:8       __INFO
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  876543..->087654..
    rr    E             ; 2:8       __INFO
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  876543..->087654..
    rr    E             ; 2:8       __INFO
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  876543..->087654..
    rr    E             ; 2:8       __INFO
    rra                 ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    H, E          ; 1:4       __INFO
    ld    E, D          ; 1:4       __INFO
    ld    D, 0x00       ; 2:7       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 12 -- pd )  [pd] >>= 12
dnl # shifts [pd] right 12 bits
define({_12_PDRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_12_PDRSHIFT},{12 pdrshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_12_PDRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    xor   A             ; 1:4       __INFO  ( pd 12 -- pd )  [pd] >>= 12  with align 4
    inc   L             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO  0x00
    dec   L             ; 1:4       __INFO
    ld    C,(HL)        ; 1:7       __INFO
    ld  (HL),B          ; 1:7       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA087-->0xA708
    dec   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),C          ; 1:7       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA765-->0xA576
    dec   L             ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA543-->0xA354
}){}dnl
dnl
dnl
dnl
dnl # ( d1 16 -- d )  d = d1 >> 16
dnl # shifts d1 right 16 bits
define({_16_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_16_DRSHIFT},{16 drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_16_DRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex   DE, HL         ; 1:4       __INFO  ( d1 16 -- d )  d = d1 >> 16
    ld   DE, 0x0000     ; 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 16 -- pd )  [pd] >>= 16
dnl # shifts [pd] right 16 bits
define({_16_PDRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_16_PDRSHIFT},{16 pdrshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_16_PDRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc   L             ; 1:4       __INFO  ( pd 16 -- pd )  [pd] >>= 16  with align 4
    inc   L             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    xor   A             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld    C,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),C          ; 1:7       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 20 -- d )  d = d1 >> 20
dnl # shifts d1 right 20 bits
define({_20_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_20_DRSHIFT},{20 drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_20_DRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO  ( d1 20 -- d )  d = d1 >> 20
    srl   D             ; 2:8       __INFO  8765....->0876....
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  8765....->0876....
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  8765....->0876....
    rra                 ; 1:4       __INFO
    srl   D             ; 2:8       __INFO  8765....->0876....
    rra                 ; 1:4       __INFO
    ld    E, A          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   DE, 0x0000     ; 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 20 -- pd )  [pd] >>= 20
dnl # shifts [pd] right 20 bits
define({_20_PDRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_20_PDRSHIFT},{20 pdrshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_20_PDRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc   L             ; 1:4       __INFO  ( pd 20 -- pd )  [pd] >>= 20  with align 4
    inc   L             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    xor   A             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld    C,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA087-->0xA708
    dec   L             ; 1:4       __INFO
    ld  (HL),C          ; 1:7       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA765-->0xA576}){}dnl
dnl
dnl
dnl
dnl # ( d1 24 -- d )  d = d1 >> 24
dnl # shifts d1 right 24 bits
define({_24_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_24_DRSHIFT},{24 drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_24_DRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    L, D          ; 1:4       __INFO  ( d1 24 -- d )  d = d1 >> 24
    ld   DE, 0x0000     ; 3:10      __INFO
    ld    H, D          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 24 -- pd )  [pd] >>= 24
dnl # shifts [pd] right 24 bits
define({_24_PDRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_24_PDRSHIFT},{24 pdrshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_24_PDRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    C, L          ; 1:4       __INFO  ( pd 24 -- pd )  [pd] >>= 24  with align 4
    xor   A             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( d1 28 -- d )  d = d1 >> 28
dnl # shifts d1 right 28 bits
define({_28_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_28_DRSHIFT},{28 drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_28_DRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, D          ; 1:4       __INFO  ( d1 28 -- d )  d = d1 >> 28
    rra                 ; 1:4       __INFO
    rra                 ; 1:4       __INFO
    rra                 ; 1:4       __INFO
    rra                 ; 1:4       __INFO
    and  0x0F           ; 2:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld   DE, 0x0000     ; 3:10      __INFO
    ld    H, D          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( pd 28 -- pd )  [pd] >>= 28
dnl # shifts [pd] right 28 bits
define({_28_PDRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_28_PDRSHIFT},{28 pdrshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_28_PDRSHIFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    C, L          ; 1:4       __INFO  ( pd 28 -- pd )  [pd] >>= 28  with align 4
    xor   A             ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ld  (HL),B          ; 1:7       __INFO
    rrd                 ; 2:18      __INFO  A(HL)=0xA087-->0xA708}){}dnl
dnl
dnl
dnl
dnl # ( d1 u -- d )  d = d1 >> u
dnl # shifts d1 right u places
define({ROT_DRSHIFT},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_DRSHIFT},{rot_drshift},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_DRSHIFT},{dnl
__{}define({__INFO},{rot_drshift}){}dnl
__def({USE_ROT_DRSHIFT})
    pop  BC             ; 1:10      rot D>>   ( d1 -- d )  d = d1 >> BC
    call BC_RSHIFT32    ; 3:17      rot D>>}){}dnl
dnl
dnl
dnl
dnl # ( d1 d2 -- d )
dnl # d = d1 & d2
define({DAND},{dnl
__{}__ADD_TOKEN({__TOKEN_DAND},{dand},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DAND},{dnl
__{}define({__INFO},{dand}){}dnl

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
    ld    D, A          ; 1:4       dand}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 )
dnl # [pd1] &= [pd2]
define({PDAND},{dnl
__{}__ADD_TOKEN({__TOKEN_PDAND},{pdand},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDAND},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  [pd1] &= [pd2] with align 4
    and (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    ld    B, E          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    and (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    and (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    and (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    E, B          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( p2 p1 -- p2 p1 )
dnl # [p1] &= [p2]
define({PAND},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PAND},{p{}eval(($1)*8)and},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PAND},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] &= [p{}eval(8*($1))_2] with align $1
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO},
__{}eval($1),2,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] &= [p{}eval(8*($1))_2] with align $1
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO},
__{}eval($1),3,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] &= [p{}eval(8*($1))_2] with align $1
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO},
__{}eval($1),4,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] &= [p{}eval(8*($1))_2] with align $1
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, E          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    E, B          ; 1:4       __INFO},
__{}eval($1),256,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] &= [p{}eval(8*($1))_2] with align $1
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-5        ; 2:7/12    __INFO},
__{}{
__{}    ld    C, L          ; 1:4       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] &= [p{}eval(8*($1))_2] with align $1
__{}    push DE             ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    and (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-5            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 & n
define({PUSHDOT_DAND},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DAND},{pushdot_dand},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DAND},{dnl
__{}define({__INFO},{pushdot_dand}){}dnl
ifelse($1,{},{
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
}){}dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 & n
define({PUSH2_DAND},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DAND},{$1 $2 d&},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DAND},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),1,{
__{}  .error {$0}($@): Missing address parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__AND_REG16_16BIT({HL},$2){}dnl
__{}ifelse(dnl
__{}__HEX_L($2),0x00,{__AND_REG16_16BIT({DE},$1,{L},0x00)},
__{}__HEX_H($2),0x00,{__AND_REG16_16BIT({DE},$1,{H},0x00)},
__{}{__AND_REG16_16BIT({DE},$1)}){}dnl
})}){}dnl
dnl
dnl
dnl # ( d1 d2 -- d )
dnl # d = d1 | d2
define({DOR},{dnl
__{}__ADD_TOKEN({__TOKEN_DOR},{dor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DOR},{dnl
__{}define({__INFO},{dor}){}dnl

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
    ld    D, A          ; 1:4       dor}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 )
dnl # [pd1] |= [pd2]
define({PDOR},{dnl
__{}__ADD_TOKEN({__TOKEN_PDOR},{pdor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  [pd1] |= [pd2] with align 4
    or  (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    ld    B, E          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    or  (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    or  (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    or  (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    E, B          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( p2 p1 -- p2 p1 )
dnl # [p1] |= [p2]
define({POR},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_POR},{p{}eval(($1)*8)or},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_POR},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] |= [p{}eval(8*($1))_2] with align $1
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO},
__{}eval($1),2,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] |= [p{}eval(8*($1))_2] with align $1
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO},
__{}eval($1),3,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] |= [p{}eval(8*($1))_2] with align $1
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO},
__{}eval($1),4,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] |= [p{}eval(8*($1))_2] with align $1
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, E          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    E, B          ; 1:4       __INFO},
__{}eval($1),256,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] |= [p{}eval(8*($1))_2] with align $1
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-5        ; 2:7/12    __INFO},
__{}{
__{}    ld    C, L          ; 1:4       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] |= [p{}eval(8*($1))_2] with align $1
__{}    push DE             ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-5            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( p2 p1 -- p2 p1 )
dnl # [p1] ^= [p2]
define({PXOR},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PXOR},{p{}eval(($1)*8)xor},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PXOR},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] ^= [p{}eval(8*($1))_2] with align $1
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO},
__{}eval($1),2,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] ^= [p{}eval(8*($1))_2] with align $1
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO},
__{}eval($1),3,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] ^= [p{}eval(8*($1))_2] with align $1
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO},
__{}eval($1),4,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] ^= [p{}eval(8*($1))_2] with align $1
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, E          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    E, B          ; 1:4       __INFO},
__{}eval($1),256,{
__{}    ld    A,(DE)        ; 1:7       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] ^= [p{}eval(8*($1))_2] with align $1
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-5        ; 2:7/12    __INFO},
__{}{
__{}    ld    C, L          ; 1:4       __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 )  [p{}eval(8*($1))_1] ^= [p{}eval(8*($1))_2] with align $1
__{}    push DE             ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-5            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 | n
define({PUSHDOT_DOR},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DOR},{pushdot_dor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DOR},{dnl
__{}define({__INFO},{pushdot_dor}){}dnl
ifelse($1,{},{
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
}){}dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 | n
define({PUSH2_DOR},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DOR},{$1 $2 d|},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DOR},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),1,{
__{}  .error {$0}($@): Missing address parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__{}__OR_REG16_16BIT({HL},$2){}dnl
__{}__{}__OR_REG16_16BIT({DE},$1){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( d1 u -- d )  d == d1 | 2**u
define({DBITSET},{dnl
__{}__ADD_TOKEN({__TOKEN_DBITSET},{dbitset},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DBITSET},{dnl
__{}define({__INFO},{dbitset}){}dnl
ifelse(eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{ifelse(_TYP_DOUBLE,{fast},{
__{}                       ;[26:108/45] dbitset   ( d1 u -- d )  d = d1 | 2**u   fast version
__{}    ld    A, 0xE0       ; 2:7       dbitset
__{}    and   L             ; 1:4       dbitset
__{}    or    H             ; 1:4       dbitset
__{}    ld    A, L          ; 1:4       dbitset   A = 000r rnnn
__{}    pop  HL             ; 1:10      dbitset
__{}    ex   DE, HL         ; 1:4       dbitset
__{}    jr   nz, $+19       ; 2:7/12    dbitset   out of range 0..31
__{}    rlca                ; 1:4       dbitset   2x
__{}    rlca                ; 1:4       dbitset   4x
__{}    rlca                ; 1:4       dbitset   8x
__{}    ld    C, A          ; 1:4       dbitset   C = rrnn n000, nnn = 0..7, rr=(L:0,H:1,E:2,D:3) --> 5-rr=(L:5,H:4,E:3,D:2)
__{}    rlca                ; 1:4       dbitset
__{}    rlca                ; 1:4       dbitset
__{}    and  0x03           ; 1:4       dbitset
__{}    ld    B, A          ; 1:4       dbitset   B = 0000 00rr
__{}    ld    A, C          ; 1:4       dbitset   A = rrnn n000
__{}    or   0xC5           ; 2:7       dbitset   A = 11nn n101     = set n, L
__{}    sub   B             ; 1:4       dbitset   A = 11nn n101 - B = set n, DEHL
__{}    ld  ($+4), A        ; 3:13      dbitset
__{}    set   0, L          ; 2:8       dbitset},
{__def({USE_BITSET32})
__{}    call BITSET32       ; 3:17      dbitset   ( d1 u -- d )  d = d1 | 2**u   default version})})}){}dnl
dnl
dnl
dnl
dnl # ( d -- d|2**n )
dnl # d = d | 2**n
define({PUSH_DBITSET},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_DBITSET},{push_dbitset},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_DBITSET},{dnl
__{}define({__INFO},{push_dbitset}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{__def({USE_ROT_DLSHIFT})
__{}                        ;[28:145]   push_dbitset($1)   ( d1 -- d )  d = d1 | 2**$1
__{}    push DE             ; 1:11      push_dbitset($1)
__{}    push HL             ; 1:11      push_dbitset($1)
__{}    ld   HL, 0x0001     ; 3:10      push_dbitset($1)
__{}    ld    E, H          ; 1:4       push_dbitset($1)
__{}    ld    D, H          ; 1:4       push_dbitset($1)   DEHL = 0x00000001
__{}    ld   BC, format({%-11s},$1); 4:20      push_dbitset($1)
__{}    call BC_LSHIFT32    ; 3:17      push_dbitset($1)   ( d1 -- d )  d = d1<<BC
__{}    pop  BC             ; 1:10      push_dbitset($1)
__{}    ld    A, C          ; 1:4       push_dbitset($1)
__{}    or    L             ; 1:4       push_dbitset($1)
__{}    ld    L, A          ; 1:4       push_dbitset($1)
__{}    ld    A, B          ; 1:4       push_dbitset($1)
__{}    or    H             ; 1:4       push_dbitset($1)
__{}    ld    H, A          ; 1:4       push_dbitset($1)
__{}    pop  BC             ; 1:10      push_dbitset($1)
__{}    ld    A, C          ; 1:4       push_dbitset($1)
__{}    or    E             ; 1:4       push_dbitset($1)
__{}    ld    E, A          ; 1:4       push_dbitset($1)
__{}    ld    A, B          ; 1:4       push_dbitset($1)
__{}    or    D             ; 1:4       push_dbitset($1)
__{}    ld    D, A          ; 1:4       push_dbitset($1)},
__IS_NUM($1),{0},{define({_TMP_INFO},{push_dbitset($1)})
__{}  .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{} if (($1)>=0)
__{} if (($1)<8){}dnl
__{}__OR_REG8_8BIT({L},{(1<<($1))})
__{} else
__{} if (($1)<16){}dnl
__{}__OR_REG8_8BIT({H},{(1<<($1-8))})
__{} else
__{} if (($1)<24){}dnl
__{}__OR_REG8_8BIT({E},{(1<<($1-16))})
__{} else
__{} if (($1)<32){}dnl
__{}__OR_REG8_8BIT({D},{(1<<($1-24))})
__{} endif
__{} endif
__{} endif
__{} endif
__{} endif},
{dnl
__{}ifelse(eval(($1)<0),{1},{
__{}__{}  .error {$0}($@): negative parameters found in macro!},
__{}eval(($1)>31),{1},{
__{}__{}  .warning {$0}($@): Out of range zero to 31th bit.},
__{}{define({_TMP_INFO},{push_dbitset($1)})
__{}__{}ifelse(dnl
__{}__{}eval(($1)< 8),{1},{__OR_REG8_8BIT({L},eval(1<<($1)))},
__{}__{}eval(($1)<16),{1},{__OR_REG8_8BIT({H},eval(1<<($1-8)))},
__{}__{}eval(($1)<24),{1},{__OR_REG8_8BIT({E},eval(1<<($1-16)))},
__{}__{}eval(($1)<32),{1},{__OR_REG8_8BIT({D},eval(1<<($1-24)))})}){}dnl
})}){}dnl
dnl
dnl
dnl # ( d1 d2 -- d )
dnl # d = d1 ^ d2
define({DXOR},{dnl
__{}__ADD_TOKEN({__TOKEN_DXOR},{dxor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DXOR},{dnl
__{}define({__INFO},{dxor}){}dnl

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
    ld    D, A          ; 1:4       dxor}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 )
dnl # [pd1] ^= [pd2]
define({PDXOR},{dnl
__{}__ADD_TOKEN({__TOKEN_PDXOR},{pdxor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDXOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  [pd1] ^= [pd2] with align 4
    xor (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    ld    B, E          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    E, B          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 ^ n
define({PUSHDOT_DXOR},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DXOR},{pushdot_dxor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DXOR},{dnl
__{}define({__INFO},{pushdot_dxor}){}dnl
ifelse($1,{},{
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
}){}dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = d1 ^ n
define({PUSH2_DXOR},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DXOR},{$1 $2 d^},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DXOR},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),1,{
__{}  .error {$0}($@): Missing address parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__{}__XOR_REG16_16BIT({HL},$2){}dnl
__{}__{}__XOR_REG16_16BIT({DE},$1){}dnl
})}){}dnl
dnl
dnl
dnl # ( d1 -- d )
dnl # d = ~d1
define({DINVERT},{dnl
__{}__ADD_TOKEN({__TOKEN_DINVERT},{dinvert},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DINVERT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, L          ; 1:4       __INFO   ( d1 -- d )  d = ~d1
    cpl                 ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    A, H          ; 1:4       __INFO
    cpl                 ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    ld    A, E          ; 1:4       __INFO
    cpl                 ; 1:4       __INFO
    ld    E, A          ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    cpl                 ; 1:4       __INFO
    ld    D, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( pd -- pd )
dnl # [pd] = ~[pd]
define({PDINVERT},{dnl
__{}__ADD_TOKEN({__TOKEN_PDINVERT},{pdinvert},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDINVERT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A,(HL)        ; 1:7       __INFO   ( pd -- pd )  [pd] = ~[pd]  with align 4
    cpl                 ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    cpl                 ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    cpl                 ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    cpl                 ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # D0=
dnl # ( d -- f )
dnl # if ( x1x2 ) flag = 0; else flag = 0xFFFF;
dnl # 0 if 32-bit number not equal to zero, -1 if equal
define({D0EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_D0EQ},{d0=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D0EQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(TYP_D0EQ,{small},{
                        ;[8:54]     __INFO   ( hi lo -- flag )   # small version can be changed with "define({TYP_D0EQ},{default})"
    add  HL, DE         ; 1:11      __INFO   carry: 0    1
    sbc   A, A          ; 1:4       __INFO          0x00 0xff
    or    H             ; 1:4       __INFO          H    0xff
    dec  HL             ; 1:6       __INFO
    sub   H             ; 1:4       __INFO   carry: 1|0  0
    sbc  HL, HL         ; 2:15      __INFO   set flag D == 0
    pop   DE            ; 1:10      __INFO},
{
                        ;[9:48]     __INFO   ( hi lo -- flag )   # fast version can be changed with "define({TYP_D0EQ},{small})"
    ld    A, D          ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    sub   0x01          ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag D == 0
    pop   DE            ; 1:10      __INFO})}){}dnl
dnl
dnl
dnl # 2dup d0=
dnl # ( d -- d f )
define({_2DUP_D0EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0EQ},{2dup d0=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0EQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(TYP_D0EQ,{small},{
                        ;[9:59]     __INFO   ( d -- d flag )   # small version can be changed with "define({TYP_D0EQ},{default})"
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    add  HL, DE         ; 1:11      __INFO   carry: 0    1
    sbc   A, A          ; 1:4       __INFO          0x00 0xff
    or    H             ; 1:4       __INFO          H    0xff
    dec  HL             ; 1:6       __INFO
    sub   H             ; 1:4       __INFO   carry: 1|0  0
    sbc  HL, HL         ; 2:15      __INFO   set flag D == 0},
{
                       ;[10:53]     __INFO   ( d -- d flag )   # fast version can be changed with "define({TYP_D0EQ},{small})"
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    sub   0x01          ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag D == 0}){}dnl
}){}dnl
dnl
dnl
dnl # ( pd1 -- pd1 flag )
dnl # equal ( [pd1] == 0 )
define({PD0EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_PD0EQ},{pd0=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PD0EQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd1 -- pd1 flag )  flag == [pd1] == 0  with align 4
    ld    A,(HL)        ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    sub 0x01            ; 2:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 flag )
dnl # equal ( [pd2] == 0 )
define({OVER_PD0EQ_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PD0EQ_NIP},{over pd0= nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PD0EQ_NIP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd2 pd1 -- pd2 pd1 flag )  flag == [pd2] == 0  with align 4
    ex   DE, HL         ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    sub 0x01            ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # D0<>
dnl # ( d -- f )
dnl # if ( x1x2 ) flag = 0; else flag = 0xFFFF;
dnl # 0 if 32-bit number equal to zero, -1 if not equal
define({D0NE},{dnl
__{}__ADD_TOKEN({__TOKEN_D0NE},{d0<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D0NE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:48]     __INFO   ( hi lo -- flag )
    ld    A, D          ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    add   A, 0xFF       ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag D <> 0
    pop   DE            ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup d0<>
dnl # ( d -- d f )
define({_2DUP_D0NE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0NE},{2dup d0<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0NE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[10:53]     __INFO   ( d -- d flag )
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    A, D          ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    add   A, 0xFF       ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag D <> 0}){}dnl
dnl
dnl
dnl # ( pd1 -- pd1 flag )
dnl # not equal ( [pd1] <> 0 )
define({PD0NE},{dnl
__{}__ADD_TOKEN({__TOKEN_PD0NE},{pd0<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PD0NE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd1 -- pd1 flag )  flag == [pd1] <> 0  with align 4
    ld    A,(HL)        ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    add   A, 0xFF       ; 2:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( p1 -- p1 flag )
dnl # flag = [p1] <> 0
define({P0NE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_P0NE},{p{}eval(8*($1)) 0<>},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_P0NE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] <> 0  with align $1
__{}    ld    A,(HL)        ; 1:7       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),2,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] <> 0  with align $1
__{}    ld    A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),3,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] <> 0  with align $1
__{}    ld    A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),4,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] <> 0  with align $1
__{}    ld    A,(HL)        ; 1:7       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),256,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] <> 0  with align $1
__{}    ld   DE, 0xFFFF     ; 3:10      __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    jr   nz, $-4        ; 2:7/12    __INFO
__{}    inc  DE             ; 1:6       __INFO
__{}    ld    L, 0x00       ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO},
__{}{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] <> 0  with align $1
__{}    ld   DE, 0xFFFF     ; 3:10      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    jr   nz, $+5        ; 2:7/12    __INFO
__{}    djnz $-3            ; 2:8/13    __INFO
__{}    inc  DE             ; 1:6       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 flag )
dnl # not equal ( [pd2] <> 0 )
define({OVER_PD0NE_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PD0NE_NIP},{over pd0<> nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PD0NE_NIP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd2 pd1 -- pd2 pd1 flag )  flag == [pd2] <> 0  with align 4
    ex   DE, HL         ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    add   A, 0xFF       ; 2:7       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # D0<
dnl # ( d -- flag )
define({D0LT},{dnl
__{}__ADD_TOKEN({__TOKEN_D0LT},{d0<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D0LT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(TYP_D0LT,{small},{
                        ;[5:34]     __INFO   ( hi lo -- flag D<0 )
    rl    D             ; 2:8       __INFO
    pop  DE             ; 1:11      __INFO
    sbc  HL, HL         ; 2:15      __INFO}
,{
                        ;[6:31]     __INFO   ( hi lo -- flag D<0 )
    rl    D             ; 2:8       __INFO
    pop  DE             ; 1:11      __INFO
    sbc   A, A          ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO   set flag D < 0})}){}dnl
dnl
dnl
dnl # D=
dnl # ( d2 d1 -- flag )
dnl # equal ( d1 == d2 )
define({DEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_DEQ},{d=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                     ;[15:90/69,91] __INFO  ( d2 d1 -- flag )
    pop  BC             ; 1:10      __INFO   BC = lo_2
    xor   A             ; 1:4       __INFO    A = 0x00
    sbc  HL, BC         ; 2:15      __INFO   HL = lo_1 - lo_2
    pop  HL             ; 1:10      __INFO   HL = hi_2
    jr   nz, $+7        ; 2:7/12    __INFO
    sbc  HL, DE         ; 2:15      __INFO   HL = hi_2 - hi_1
    jr   nz, $+3        ; 2:7/12    __INFO
    dec   A             ; 1:4       __INFO    A = 0xFF
    ld    L, A          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO   HL = flag d2==d1
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 flag )
dnl # equal ( [pd1] == [pd2] )
define({PDEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_PDEQ},{pd=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDEQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd2 pd1 -- pd2 pd1 flag )  flag = [pd1] == [pd2] with align 4
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+22       ; 2:7/12    __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+14       ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+8        ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    sub 0x01            ; 2:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl
dnl # $1. D=
dnl # ( d1 -- flag )
dnl # equal ( d1 == $1 )
define({PUSHDOT_DEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DEQ},{$1. d=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DEQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
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
{ifelse(eval($1),0,{__ASM_TOKEN_D0EQ},
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
dnl # hi lo D=
dnl # ( d -- flag )
dnl # equal ( d == (hi<<16)+lo )
define({PUSH2_DEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DEQ},{$1 $2 d=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DEQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
eval((__IS_NUM($1)+__IS_NUM($2))<2),{1},{
__{}__SET_BYTES_CLOCKS_PRICES(13,70){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$1,{HL},0x0000,{BC},$2){}dnl
__{}__LD_REG16({BC},$2){}dnl
__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS/eval(49+__CLOCKS_16BIT)])__INFO   ( d1 -- flag )  flag: d1 == $1*65536+$2{}__CODE_16BIT
__{}    xor   A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO{}__LD_REG16({HL},$1,{HL},0x0000,{BC},$2)
__{}    jr   nz, $+format({%-9s},eval(7+__BYTES_16BIT)); 2:7/12    __INFO{}dnl
__{}__CODE_16BIT
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO},
__HEX_HL($1):__HEX_HL($2),0x0000:0x0000,{dnl
__{}__ASM_TOKEN_D0EQ},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- flag )  flag: d1 == eval((__HEX_HL($1)<<16)+__HEX_HL($2))}){}__LD_REG16({HL},__HEX_HL($1),{HL},0,{BC},__HEX_HL($2)){}dnl
__{}__DEQ_MAKE_BEST_CODE(eval((__HEX_HL($1)<<16)+__HEX_HL($2)),6,29,0,0){}dnl
__{}define({_TMP_P},eval(59+80+__CLOCKS_16BIT+8*(16+__BYTES_16BIT))){}dnl #     price = 16*(clocks + 4*bytes)
__{}ifelse(eval(8*_TMP_P<_TMP_BEST_P),{1},{
__{}format({%28s},;[eval(16+__BYTES_16BIT):)format({%-8s},eval(80+__CLOCKS_16BIT)/59])__INFO   ( d1 -- flag )  flag: d1 == __HEX_DEHL((__HEX_HL($1)<<16)+__HEX_HL($2))
__{}    ld   BC, __HEX_HL($2)     ; 3:10      __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jr   nz, $+format({%-9s},eval(7+__BYTES_16BIT)); 2:7/12    __INFO{}dnl
__{}__CODE_16BIT
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO},{
__{}_TMP_BEST_CODE
__{}    sub  0x01           ; 2:7       __INFO
__{}    sbc   A, A          ; 1:4       __INFO
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # hi lo D=
dnl # ( d -- flag )
dnl # equal ( d == (hi<<16)+lo )
define({_2DUP_PUSH2_DEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DEQ},{2dup $1 $2 d=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DEQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
eval((__IS_NUM($1)+__IS_NUM($2))<2),{1},{
__{}__SET_BYTES_CLOCKS_PRICES(14,75){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$2,{HL},0x0000,{BC},$1){}dnl
__{}__LD_REG16({BC},$1,{A},0x00){}dnl
__{}                        ;format({%-11s},[__SUM_BYTES:eval(54+__CLOCKS_16BIT)/__SUM_CLOCKS])__INFO   ( d -- d flag )  flag: d1 == $1*65536+$2
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    xor   A             ; 1:4       __INFO{}__CODE_16BIT
__{}    sbc  HL, BC         ; 2:15      __INFO{}__LD_REG16({HL},$2,{HL},0x0000,{BC},$1)
__{}    jr   nz, $+format({%-9s},eval(7+__BYTES_16BIT)); 2:7/12    __INFO{}dnl
__{}__CODE_16BIT
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = flag},
__HEX_HL($1):__HEX_HL($2),0x0000:0x0000,{
__{}                        ;format({%-11s},[10:53])__INFO   ( d -- d flag )  flag: d == 0
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    or    E             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    or    L             ; 1:4       __INFO
__{}    sub   0x01          ; 2:7       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
{dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({_TMP_STACK_INFO},{ }__INFO{   ( d -- d flag )  flag: d==$1*65536+$2}){}dnl
__{}__DEQ_MAKE_BEST_CODE(__HEX_DE_HL($1,$2),6,37,0,0){}dnl
__{}__DEQ_MAKE_HLDE_CODE(__HEX_DE_HL($1,$2),9+{_TMP_ZERO}){}dnl
__{}ifelse(_TMP_ZERO,{1},{dnl
__{}__{}define({_TMP_B},eval(_TMP_B+5)){}dnl
__{}__{}define({_TMP_T}, eval(_TMP_NJ+19)){}dnl  # true
__{}__{}define({_TMP_F}, eval(_TMP_J+8)){}dnl    # false
__{}__{}define({_TMP_F2},eval(_TMP_NJ+20)){}dnl # false2
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}                     ;[_TMP_B:_TMP_T/_TMP_F,_TMP_F2] _TMP_INFO   ( d -- d flag )
__{}__{}__{}}_TMP_HLDE_CODE{
__{}__{}__{}    jr   nz, $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   A = 0xFF = true
__{}__{}__{}    ld    L, A          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    H, A          ; 1:4       _TMP_INFO   set flag d==__HEX_DE_HL($1,$2)})},
__{}{dnl
__{}__{}define({_TMP_B},eval(_TMP_B+6)){}dnl
__{}__{}define({_TMP_T}, eval(_TMP_NJ+20)){}dnl  # true
__{}__{}define({_TMP_F}, eval(_TMP_J+15)){}dnl   # false
__{}__{}define({_TMP_F2},eval(_TMP_NJ+22)){}dnl # false2
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}                     ;[_TMP_B:_TMP_T/_TMP_F,_TMP_F2] _TMP_INFO   ( d -- d flag )
__{}__{}__{}}_TMP_HLDE_CODE{
__{}__{}__{}    jr    z, $+4        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld    L, 0x01       ; 2:7       _TMP_INFO
__{}__{}__{}    dec   L             ; 1:4       _TMP_INFO
__{}__{}__{}    ld    H, L          ; 1:4       _TMP_INFO   set flag d==__HEX_DE_HL($1,$2)})}){}dnl
__{}define({_TMP_P},eval(8*_TMP_T+4*_TMP_F+4*_TMP_F2+64*_TMP_B)){}dnl #     price = 16*(clocks + 4*bytes)
__{}define({_TMP},eval(_TMP_BEST_P<=_TMP_P)){}dnl
__{}ifelse(_TMP,{0},{
__{}__{}if 0
__{}__{}; price: _TMP_BEST_P})
__{}_TMP_BEST_CODE
__{}    sub 0x01            ; 2:7       _TMP_INFO
__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}    push HL             ; 1:11      _TMP_INFO
__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag d==__HEX_DE_HL($1,$2){}dnl
__{}ifelse(_TMP,{0},{
__{}__{}else
__{}__{}; price: _TMP_P
__{}__{}_TMP_HLDE_CODE
__{}__{}endif})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # hi lo D<>
dnl # ( d -- flag )
dnl # not equal ( d1 <> (hi<<16)+lo )
define({PUSH2_DNE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DNE},{$1 $2 d<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DNE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
eval((__IS_NUM($1)+__IS_NUM($2))<2),{1},{
__{}__SET_BYTES_CLOCKS_PRICES(13,68){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$1,{HL},0x0000,{BC},$2){}dnl
__{}__LD_REG16({BC},$2){}dnl
__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS/eval(51+__CLOCKS_16BIT)])__INFO   ( d1 -- flag )  flag: d1 == $1*65536+$2{}__CODE_16BIT
__{}    xor   A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO{}__LD_REG16({HL},$1,{HL},0x0000,{BC},$2)
__{}    jr   nz, $+format({%-9s},eval(6+__BYTES_16BIT)); 2:7/12    __INFO{}dnl
__{}__CODE_16BIT
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}    ld   HL, 0xFFFF     ; 3:10      __INFO   HL = true
__{}    pop  DE             ; 1:10      __INFO},
__HEX_HL($1):__HEX_HL($2),0x0000:0x0000,{dnl
__{}__ASM_TOKEN_D0NE},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- flag )  flag: d1 == $1}){}__LD_REG16({HL},__HEX_HL($1),{HL},0,{BC},__HEX_HL($2)){}dnl
__{}__DEQ_MAKE_BEST_CODE(__HEX_DE_HL($1,$2),6,29,0,0){}dnl
__{}define({_TMP_P},eval(61+78+__CLOCKS_16BIT+8*(16+__BYTES_16BIT))){}dnl #     price = 16*(clocks + 4*bytes)
__{}ifelse(eval(8*_TMP_P<_TMP_BEST_P),{1},{
__{}format({%28s},;[eval(16+__BYTES_16BIT):)format({%-8s},eval(78+__CLOCKS_16BIT)/61])__INFO   ( d1 -- flag )  flag: d1 == __HEX_DEHL((__HEX_HL($1)<<16)+__HEX_HL($2))
__{}    ld   BC, __HEX_HL($2)     ; 3:10      __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jr   nz, $+format({%-9s},eval(6+__BYTES_16BIT)); 2:7/12    __INFO{}dnl
__{}__CODE_16BIT
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}    ld   HL, 0xFFFF     ; 3:10      __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO},{
__{}_TMP_BEST_CODE
__{}    add  0xFF           ; 2:7       __INFO
__{}    sbc   A, A          ; 1:4       __INFO
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # hi lo D=
dnl # ( d -- flag )
dnl # equal ( d == (hi<<16)+lo )
define({_2DUP_PUSH2_DNE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DNE},{2dup $1 $2 d<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DNE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
eval((__IS_NUM($1)+__IS_NUM($2))<2),{1},{
__{}__SET_BYTES_CLOCKS_PRICES(14,73){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$2,{HL},0x0000,{BC},$1){}dnl
__{}__LD_REG16({BC},$1,{A},0x00){}dnl
__{}format({%36s},;[__SUM_BYTES:eval(56+__CLOCKS_16BIT){,}__SUM_CLOCKS/eval(__SUM_CLOCKS-5)] )__INFO   ( d -- d flag )  flag: d1 == $1*65536+$2
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    xor   A             ; 1:4       __INFO{}__CODE_16BIT
__{}    sbc  HL, BC         ; 2:15      __INFO{}__LD_REG16({HL},$2,{HL},0x0000,{BC},$1)
__{}    jr   nz, $+format({%-9s},eval(6+__BYTES_16BIT)); 2:7/12    __INFO{}dnl
__{}__CODE_16BIT
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}    ld   HL, 0xFFFF     ; 3:10      __INFO   HL = true},
__HEX_HL($1):__HEX_HL($2),0x0000:0x0000,{
__{}                        ;format({%-11s},[10:53])__INFO   ( d -- d flag )  flag: d == 0
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    or    E             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    or    L             ; 1:4       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
{dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({_TMP_STACK_INFO},{ }__INFO{   ( d -- d flag )  flag: d<>$1*65536+$2}){}dnl
__{}__DEQ_MAKE_BEST_CODE(__HEX_DE_HL($1,$2),6,37,0,0){}dnl
__{}__DEQ_MAKE_HLDE_CODE(__HEX_DE_HL($1,$2),9){}dnl
__{}define({_TMP_B},eval(_TMP_B+5)){}dnl
__{}define({_TMP_T}, eval(_TMP_J+10)){}dnl   # true
__{}define({_TMP_T2},eval(_TMP_NJ+17)){}dnl  # true2
__{}define({_TMP_F}, eval(_TMP_NJ+12)){}dnl  # false
__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}                     ;[_TMP_B:_TMP_T,_TMP_T2/_TMP_F] _TMP_INFO   ( d -- d flag )
__{}__{}}_TMP_HLDE_CODE{
__{}__{}    jr    z, $+5        ; 2:7/12    _TMP_INFO
__{}__{}    ld   HL, 0xFFFF     ; 3:10      _TMP_INFO   set flag d<>__HEX_DE_HL($1,$2)}){}dnl
__{}define({_TMP_P},eval(4*_TMP_T+4*_TMP_T2+8*_TMP_F+64*_TMP_B)){}dnl #     price = 16*(clocks + 4*bytes)
__{}define({_TMP},eval(_TMP_BEST_P<=_TMP_P)){}dnl
__{}ifelse(_TMP,{0},{
__{}__{}if 0
__{}__{}; price: _TMP_BEST_P})
__{}_TMP_BEST_CODE
__{}    add   A, 0xFF       ; 2:7       _TMP_INFO
__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}    push HL             ; 1:11      _TMP_INFO
__{}    sbc  HL, HL         ; 2:15      _TMP_INFO   set flag d<>__HEX_DE_HL($1,$2){}dnl
__{}ifelse(_TMP,{0},{
__{}__{}else
__{}__{}; price: _TMP_P
__{}__{}_TMP_HLDE_CODE
__{}__{}endif})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Du=
dnl # ( ud2 ud1 -- flag )
dnl # equal ( ud1 == ud2 )
define({DUEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_DUEQ},{dueq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUEQ},{dnl
__{}define({__INFO},{dueq}){}dnl
DEQ}){}dnl
dnl
dnl
dnl # D<>
dnl # ( d2 d1 -- flag )
dnl # not equal ( d1 != d2 )
define({DNE},{dnl
__{}__ADD_TOKEN({__TOKEN_DNE},{d<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[15:71,88/83]__INFO  ( d2 d1 -- flag )
    pop  BC             ; 1:10      __INFO   n h2    . h1 l1  BC= lo(d2) = l2
    xor   A             ; 1:4       __INFO   n h2    . h1 l1  A = 0x00
    sbc  HL, BC         ; 2:15      __INFO   n h2    . h1 --  HL= l1 - l2
    pop  HL             ; 1:10      __INFO   n       . h1 h2  HL= hi(d2) = h2
    jr   nz, $+6        ; 2:7/12    __INFO   n       . h1 h2
    sbc  HL, DE         ; 2:15      __INFO   n       . h1 h2  HL = h2 - h1
    jr    z, $+5        ; 2:7/12    __INFO   n       . h1 h2
    ld   HL, 0xFFFF     ; 3:10      __INFO   n       . h1 ff  HL = true
    pop  DE             ; 1:10      __INFO           . n  ff}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 flag )
dnl # not equal ( [pd1] != [pd2] )
define({PDNE},{dnl
__{}__ADD_TOKEN({__TOKEN_PDNE},{pd<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDNE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd2 pd1 -- pd2 pd1 flag )  flag = [pd1] != [pd2] with align 4
    ld    C, L          ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+18       ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+12       ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+6        ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    add   A, 0xFF       ; 2:7       __INFO   carry if not zero
    ld     L, C         ; 1:4       __INFO
    ex    DE, HL        ; 1:4       __INFO
    sbc   HL, HL        ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # Du<>
dnl # ( ud2 ud1 -- flag )
dnl # not equal ( ud1 != ud2 )
define({DUNE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUNE},{dune},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUNE},{dnl
__{}define({__INFO},{dune}){}dnl
DNE}){}dnl
dnl
dnl
dnl # D<
dnl # ( d2 d1 -- flag )
dnl # signed ( d2 < d1 ) --> ( d2 - d1 < 0 ) --> carry is true
define({DLT},{dnl
__{}__ADD_TOKEN({__TOKEN_DLT},{d<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DLT},{dnl
__{}define({__INFO},{dlt}){}dnl
ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                        ;[8:62]     D<   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<   l2
    pop  AF             ; 1:10      D<   h2
    call FCE_DLT        ; 3:17      D<   carry if true
    pop  DE             ; 1:10      D<
    sbc  HL, HL         ; 2:15      D<   set flag d2<d1},
{
                       ;[17:93]     D<   ( d2 d1 -- flag )   # fast version can be changed with "define({_TYP_DOUBLE},{function})"
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
    pop  DE             ; 1:10      D<})}){}dnl
dnl
dnl
dnl # $1 $2 d<
dnl # $1. d<
dnl # ( d -- flag )
dnl # signed ( d < $1. ) --> ( d - $1. < 0 ) --> carry is true
define({PUSH2_DLT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DLT},{$1 $2 d<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DLT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}eval($#<2),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}_TYP_DOUBLE,{function},{
__{}__{}__def({USE_FCE_DLT}){}dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES(10,70){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}                        ;[__SUM_BYTES:__SUM_CLOCKS]    __INFO   ( d -- flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
__{}    push HL             ; 1:10      __INFO   hi16(d)
__{}    ld   C, E           ; 1:4       __INFO
__{}    ld   B, D           ; 1:4       __INFO   lo16(d){}__CODE_16BIT{}__LD_REG16({DE},$1,{HL},$2){}__CODE_16BIT
__{}    pop  AF             ; 1:10      __INFO   hi16(d)
__{}    call FCE_DLT        ; 3:17      __INFO   carry if true
__{}    pop  DE             ; 1:10      __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d < $1*65536+$2},
__{}{dnl
__{}__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"},3,25)
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d < $1*65536+$2}){}dnl
}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 flag )
dnl # signed ( [pd2] < [pd1] ) --> ( [pd2] - [pd1] < 0 ) --> carry is true
define({PDLT},{dnl
__{}__ADD_TOKEN({__TOKEN_PDLT},{pdlt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDLT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd2 pd1 -- pd2 pd1 flag )  flag == [pd2] < [pd1]  with align 4
    ld    A,(DE)        ; 1:7       __INFO
    sub (HL)            ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    rra                 ; 1:4       __INFO   sign if true
    xor (HL)            ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    xor (HL)            ; 1:7       __INFO
    add   A, A          ; 1:4       __INFO   carry if true
    sbc  HL, HL         ; 2:15      __INFO   set flag [pd2]<[pd1]}){}dnl
dnl
dnl
dnl # Du<
dnl # 2swap Du>
dnl # ( ud2 ud1 -- flag d2<d1 )
dnl # unsigned ( d2 < d1 ) --> ( d2 - d1 < 0 ) --> carry is true
define({DULT},{dnl
__{}__ADD_TOKEN({__TOKEN_DULT},{dult},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DULT},{dnl
__{}define({__INFO},{dult}){}dnl

                        ;[11:76]    Du<   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du<   lo(ud2)
    ld    A, C          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      Du<   hi(ud2)
    sbc  HL, DE         ; 2:15      Du<   HL<DE --> HL-DE<0 --> carry if true
    sbc  HL, HL         ; 2:15      Du<   set flag ud2<ud1
    pop  DE             ; 1:10      Du<}){}dnl
dnl
dnl
dnl # ( pud2 pud1 -- pud2 pud1 flag )
dnl # unsigned ( [pud2] u< [pud1] ) --> ( [pud2] - [pud1] u< 0 ) --> carry is true
define({PDULT},{dnl
__{}__ADD_TOKEN({__TOKEN_PDULT},{pdult},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDULT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pud2 pud1 -- pud2 pud1 flag )  flag == [pud2] u< [pud1]  with align 4
    ld    A,(DE)        ; 1:7       __INFO
    sub (HL)            ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag [pud2]u<[pud1]}){}dnl
dnl
dnl
dnl # D>=
dnl # 2swap D<=
dnl # ( d2 d1 -- flag )
dnl # (d2 >= d1)  -->  (d2 + 1 > d1) -->  (0 > d1 - d2 - 1) -->  carry if true
define({DGE},{dnl
__{}__ADD_TOKEN({__TOKEN_DGE},{d>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DGE},{dnl
__{}define({__INFO},{dge}){}dnl
ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
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
    pop  DE             ; 1:10      D>=})}){}dnl
dnl
dnl
dnl # $1 $2 d>=
dnl # $1. d>=
dnl # ( d -- flag )
dnl # signed ( d >= $1. ) --> ( d - $1. < 0 ) --> not carry is true
define({PUSH2_DGE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DGE},{$1 $2 d>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DGE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}eval($#<2),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}_TYP_DOUBLE,{function},{
__{}__{}__def({USE_FCE_DLT}){}dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES(11,74){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}                        ;[__SUM_BYTES:__SUM_CLOCKS]    __INFO   ( d -- flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
__{}    push HL             ; 1:10      __INFO   hi16(d)
__{}    ld   C, E           ; 1:4       __INFO
__{}    ld   B, D           ; 1:4       __INFO   lo16(d){}__CODE_16BIT{}__LD_REG16({DE},$1,{HL},$2){}__CODE_16BIT
__{}    pop  AF             ; 1:10      __INFO   hi16(d)
__{}    call FCE_DLT        ; 3:17      __INFO   carry if true
__{}    pop  DE             ; 1:10      __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d >= $1*65536+$2},
__{}{dnl
__{}__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"},4,29)
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    ccf                 ; 1:4       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d >= $1*65536+$2}){}dnl
}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 flag )
dnl # signed ( [pd2] >= [pd1] ) --> ( [pd2] - [pd1] >= 0 ) --> not carry is true
define({PDGE},{dnl
__{}__ADD_TOKEN({__TOKEN_PDGE},{pdge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDGE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd2 pd1 -- pd2 pd1 flag )  flag == [pd2] >= [pd1]  with align 4
    ld    A,(DE)        ; 1:7       __INFO
    sub (HL)            ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    rra                 ; 1:4       __INFO   not sign if true
    xor (HL)            ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    xor (HL)            ; 1:7       __INFO
    add   A, A          ; 1:4       __INFO   not carry if true
    ccf                 ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag [pd2]>=[pd1]}){}dnl
dnl
dnl
dnl # Du>=
dnl # 2swap Du<=
dnl # ( ud2 ud1 -- flag )
dnl # (ud2 >= ud1)  -->  (ud2 + 1 > ud1) -->  (0 > ud1 - ud2 - 1) -->  carry if true
define({DUGE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUGE},{duge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUGE},{dnl
__{}define({__INFO},{duge}){}dnl

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
    pop  DE             ; 1:10      Du>=}){}dnl
dnl
dnl
dnl # ( pud2 pud1 -- pud2 pud1 flag )
dnl # unsigned ( [pud2] u>= [pud1] ) --> ( [pud2] - [pud1] u>= 0 ) --> not carry is true
define({PDUGE},{dnl
__{}__ADD_TOKEN({__TOKEN_PDUGE},{pduge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDUGE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pud2 pud1 -- pud2 pud1 flag )  flag == [pud2] >= [pud1]  with align 4
    ld    A,(DE)        ; 1:7       __INFO
    sub (HL)            ; 1:7       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ccf                 ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag [pud2]u>=[pud1]}){}dnl
dnl
dnl
dnl # D<=
dnl # 2swap D>=
dnl # ( d2 d1 -- f )
define({DLE},{dnl
__{}__ADD_TOKEN({__TOKEN_DLE},{d<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DLE},{dnl
__{}define({__INFO},{dle}){}dnl
ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
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
    pop  DE             ; 1:10      D<=})}){}dnl
dnl
dnl
dnl # $1 $2 d<=
dnl # $1. d<=
dnl # ( d -- flag )
dnl # signed ( d <= $1. ) --> ( 0 > $1. - d ) --> not carry is true
define({PUSH2_DLE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DLE},{$1 $2 d<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}eval($#<2),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}_TYP_DOUBLE,{function},{
__{}__{}__def({USE_FCE_DGT}){}dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES(11,74){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}                        ;[__SUM_BYTES:__SUM_CLOCKS]    __INFO   ( d -- flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
__{}    push HL             ; 1:10      __INFO   hi16(d)
__{}    ld   C, E           ; 1:4       __INFO
__{}    ld   B, D           ; 1:4       __INFO   lo16(d){}__CODE_16BIT{}__LD_REG16({DE},$1,{HL},$2){}__CODE_16BIT
__{}    pop  AF             ; 1:10      __INFO   hi16(d)
__{}    call FCE_DGT        ; 3:17      __INFO   carry if true
__{}    pop  DE             ; 1:10      __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d <= $1*65536+$2},
__{}{dnl
__{}__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"},4,29)
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    ccf                 ; 1:4       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d <= $1*65536+$2}){}dnl
}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 flag )
dnl # signed ( [pd2] <= [pd1] ) --> ( 0 <= [pd1] - [pd2] ) --> not carry is true
define({PDLE},{dnl
__{}__ADD_TOKEN({__TOKEN_PDLE},{pdle},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDLE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd2 pd1 -- pd2 pd1 flag )  flag == [pd2] <= [pd1]  with align 4
    ex   DE, HL         ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sub (HL)            ; 1:7       __INFO
    ld    C, E          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    ld    B, A          ; 1:4       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    rra                 ; 1:4       __INFO   not sign if true
    xor (HL)            ; 1:7       __INFO
    ld    E, C          ; 1:4       __INFO
    xor   B             ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   not carry if true
    ccf                 ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag [pd2]<=[pd1]}){}dnl
dnl
dnl
dnl # Du<=
dnl # 2swap Du>=
dnl # ( ud2 ud1 -- flag )
dnl # (ud2 <= ud1)  -->  (ud2 < ud1 + 1) -->  (ud2 - ud1 - 1 < 0) -->  carry if true
define({DULE},{dnl
__{}__ADD_TOKEN({__TOKEN_DULE},{dule},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DULE},{dnl
__{}define({__INFO},{dule}){}dnl

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
    pop  DE             ; 1:10      Du<=}){}dnl
dnl
dnl
dnl # ( pud2 pud1 -- pud2 pud1 flag )
dnl # unsigned ( [pud2] u<= [pud1] ) --> ( 0 <= [pud1] - [pud2] ) --> not carry is true
define({PDULE},{dnl
__{}__ADD_TOKEN({__TOKEN_PDULE},{pdule},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDULE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pud2 pud1 -- pud2 pud1 flag )  flag == [pud2] u<= [pud1]  with align 4
    ex   DE, HL         ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sub (HL)            ; 1:7       __INFO
    ld    C, E          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld    E, C          ; 1:4       __INFO
    ccf                 ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag [pud2]u<=[pud1]}){}dnl
dnl
dnl
dnl # D>
dnl # 2swap D<
dnl # ( d2 d1 -- flag )
define({DGT},{dnl
__{}__ADD_TOKEN({__TOKEN_DGT},{d>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DGT},{dnl
__{}define({__INFO},{dgt}){}dnl
ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                        ;[8:62]     D>   ( d2 d1 -- d2 d1 flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D>   l2
    pop  AF             ; 1:10      D>   h2
    call FCE_DGT        ; 3:17      D>   carry if true
    pop  DE             ; 1:10      D>
    sbc  HL, HL         ; 2:15      D>   set flag d2>d1},
{
                        ;[17:93]    D>   ( d2 d1 -- flag )   # function version can be changed with "define({_TYP_DOUBLE},{function})"
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
    pop  DE             ; 1:10      D>})}){}dnl
dnl
dnl
dnl # $1 $2 d>
dnl # $1. d>
dnl # ( d -- flag )
dnl # signed ( d > $1. ) --> ( 0 > $1. - d ) --> carry is true
define({PUSH2_DGT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_DGT},{$1 $2 d>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_DGT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}eval($#<2),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}_TYP_DOUBLE,{function},{
__{}__{}__def({USE_FCE_DGT}){}dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES(10,70){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}                        ;[__SUM_BYTES:__SUM_CLOCKS]    __INFO   ( d -- flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
__{}    push HL             ; 1:10      __INFO   hi16(d)
__{}    ld   C, E           ; 1:4       __INFO
__{}    ld   B, D           ; 1:4       __INFO   lo16(d){}__CODE_16BIT{}__LD_REG16({DE},$1,{HL},$2){}__CODE_16BIT
__{}    pop  AF             ; 1:10      __INFO   hi16(d)
__{}    call FCE_DGT        ; 3:17      __INFO   carry if true
__{}    pop  DE             ; 1:10      __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d > $1*65536+$2},
__{}{dnl
__{}__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"},3,25)
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d > $1*65536+$2}){}dnl
}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 flag )
dnl # signed ( [pd2] > [pd1] ) --> ( 0 > [pd1] - [pd2] ) --> carry is true
define({PDGT},{dnl
__{}__ADD_TOKEN({__TOKEN_PDGT},{pdgt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDGT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pd2 pd1 -- pd2 pd1 flag )  flag == [pd2] > [pd1]  with align 4
    ex   DE, HL         ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sub (HL)            ; 1:7       __INFO
    ld    C, E          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    ld    B, A          ; 1:4       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    rra                 ; 1:4       __INFO   sign if true
    xor (HL)            ; 1:7       __INFO
    ld    E, C          ; 1:4       __INFO
    xor   B             ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   carry if true
    sbc  HL, HL         ; 2:15      __INFO   set flag [pd2]>[pd1]}){}dnl
dnl
dnl
dnl # Du>
dnl # 2swap Du<
dnl # ( ud2 ud1 -- flag )
define({DUGT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUGT},{dugt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUGT},{dnl
__{}define({__INFO},{dugt}){}dnl

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
    pop  DE             ; 1:10      Du>}){}dnl
dnl
dnl
dnl # ( pud2 pud1 -- pud2 pud1 flag )
dnl # unsigned ( [pud2] u> [pud1] ) --> ( 0 > [pud1] - [pud2] ) --> carry is true
define({PDUGT},{dnl
__{}__ADD_TOKEN({__TOKEN_PDUGT},{pdugt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDUGT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( pud2 pud1 -- pud2 pud1 flag )  flag == [pud2] u> [pud1]  with align 4
    ex   DE, HL         ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sub (HL)            ; 1:7       __INFO
    ld    C, E          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld    E, C          ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   set flag [pud2]u>[pud1]}){}dnl
dnl
dnl
dnl
dnl # 4dup D=
dnl # ( d d -- d d f )
define({_4DUP_DEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DEQ},{4dup_deq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DEQ},{dnl
__{}define({__INFO},{4dup_deq}){}dnl

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
    ld    H, A          ; 1:4       4dup D=   h2 l2 h1    . l1 ff  HL= flag d2==d1}){}dnl
dnl
dnl
dnl
dnl # 4dup Du=
dnl # ( ud2 ud1 -- ud2 ud1 flag )
dnl # equal ( ud1 == ud2 )
define({_4DUP_DUEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUEQ},{4dup_dueq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUEQ},{dnl
__{}define({__INFO},{4dup_dueq}){}dnl
_4DUP_DEQ}){}dnl
dnl
dnl
dnl
dnl # 4dup D<>
dnl # ( d d -- d d f )
define({_4DUP_DNE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DNE},{4dup_dne},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DNE},{dnl
__{}define({__INFO},{4dup_dne}){}dnl
ifelse(_TYP_DOUBLE,{fast},{
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
    ld   HL, 0xFFFF     ; 3:10      4dup D<>   h2 l2 h1    . l1 ff  HL= flag d2<>d1})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du<>
dnl # ( ud2 ud1 -- ud2 ud1 flag )
dnl # not equal ( ud1 <> ud2 )
define({_4DUP_DUNE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUNE},{4dup_dune},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUNE},{dnl
__{}define({__INFO},{4dup_dune}){}dnl
_4DUP_DNE}){}dnl
dnl
dnl
dnl
dnl # 4dup D<
dnl # ( d d -- d d f )
define({_4DUP_DLT},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DLT},{4dup_dlt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DLT},{dnl
__{}define({__INFO},{4dup_dlt}){}dnl
ifelse(_TYP_DOUBLE,{function},{define({USE_FCE_4DUP_DLT},{yes})
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
    sbc  HL, HL         ; 2:15      4dup D<   set flag d2<d1})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du<
dnl # ( ud ud -- ud ud f )
define({_4DUP_DULT},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DULT},{4dup_dult},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DULT},{dnl
__{}define({__INFO},{4dup_dult}){}dnl

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
    sbc  HL, HL         ; 2:15      4dup Du<   set flag ud2<ud1}){}dnl
dnl
dnl
dnl
dnl # 4dup D>=
dnl # ( d d -- d d f )
define({_4DUP_DGE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DGE},{4dup_dge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DGE},{dnl
__{}define({__INFO},{4dup_dge}){}dnl
ifelse(_TYP_DOUBLE,{function},{define({USE_FCE_4DUP_DLT},{yes})
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
define({_4DUP_DUGE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUGE},{4dup_duge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUGE},{dnl
__{}define({__INFO},{4dup_duge}){}dnl

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
    sbc  HL, HL         ; 2:15      4dup Du>=   set flag ud2>=ud1}){}dnl
dnl
dnl
dnl
dnl # 4dup D<=
dnl # ( d d -- d d f )
define({_4DUP_DLE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DLE},{4dup_dle},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DLE},{dnl
__{}define({__INFO},{4dup_dle}){}dnl
ifelse(_TYP_DOUBLE,{function},{define({USE_FCE_4DUP_DGT},{yes})
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
define({_4DUP_DULE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DULE},{4dup_dule},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DULE},{dnl
__{}define({__INFO},{4dup_dule}){}dnl

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
define({_4DUP_DGT},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DGT},{4dup_dgt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DGT},{dnl
__{}define({__INFO},{4dup_dgt}){}dnl
ifelse(_TYP_DOUBLE,{function},{define({USE_FCE_4DUP_DGT},{yes})
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
define({_4DUP_DUGT},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUGT},{4dup_dugt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUGT},{dnl
__{}define({__INFO},{4dup_dugt}){}dnl

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
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DEQ},{2dup_pushdot_deq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DEQ},{dnl
__{}define({__INFO},{2dup_pushdot_deq}){}dnl
dnl
__{}define({_TMP_INFO},{2dup $1 D=}){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 flag )   __HEX_DEHL($1) == DEHL}){}dnl
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
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DNE},{2dup_pushdot_dne},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DNE},{dnl
__{}define({__INFO},{2dup_pushdot_dne}){}dnl
dnl
__{}define({_TMP_INFO},{2dup $1 D<>}){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 flag )   __HEX_DEHL($1) <> DEHL}){}dnl
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
define({_2DUP_PUSHDOT_DGT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DGT},{2dup_pushdot_dgt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DGT},{dnl
__{}define({__INFO},{2dup_pushdot_dgt}){}dnl
ifelse($1,{},{
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
dnl # 2dup d. d>
dnl # ( d -- d f )
define({_2DUP_PUSH2_DGT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DGT},{2dup $1 $2 d>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DGT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- d flag )},4,30)
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d > $1*65536+$2}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D<=
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DLE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DLE},{2dup_pushdot_dle},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DLE},{dnl
__{}define({__INFO},{2dup_pushdot_dle}){}dnl
ifelse($1,{},{
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
dnl # 2dup d. d<=
dnl # ( d -- d f )
define({_2DUP_PUSH2_DLE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DLE},{2dup $1 $2 d<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- d flag )},5,34)
__{}__{}    ccf                 ; 1:4       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d <= $1*65536+$2}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. D<
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DLT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DLT},{2dup $1. d<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DLT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
    .error {$0}(): Missing parameter!},
$#,{1},{ifelse(__IS_MEM_REF($1),{1},{
__{}                        ;[24:118]   __INFO    ( d1 -- d1 flag )
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO    DEHL<$1     $1 = ..BC
__{}    ld    A, L          ; 1:4       __INFO    DEHL<$1
__{}    sub   C             ; 1:4       __INFO    DEHL<$1 --> DEHL-..BC<0 --> carry if true
__{}    ld    A, H          ; 1:4       __INFO    DEHL<$1
__{}    sbc   A, B          ; 1:4       __INFO    DEHL<$1 --> DEHL-..BC<0 --> carry if true
__{}    ld   BC,format({%-12s},($1+2)); 4:20      __INFO    DEHL<$1     $1 = BC..
__{}    ld    A, E          ; 1:4       __INFO    DEHL<$1
__{}    sbc   A, C          ; 1:4       __INFO    DEHL<$1 --> DEHL-BC..<0 --> carry if true
__{}    ld    A, D          ; 1:4       __INFO    DEHL<$1
__{}    sbc   A, B          ; 1:4       __INFO    DEHL<$1 --> DEHL-BC..<0 --> carry if true
__{}    rra                 ; 1:4       __INFO    DEHL<$1                 --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    xor   B             ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO    DEHL<$1                 --> carry if true
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO    set flag d1<$1},
__{}__IS_NUM($1),{0},{
__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}{
__{}                       ;[20:89]     __INFO   ( d1 -- d1 flag )   # default version
__{}    ld    A, D          ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO{}ifelse(eval((($1) & 0x80000000) - 0x80000000),0,{
__{}__{}    jr   nc, $+14       ; 2:7/12    __INFO   positive d1 < negative constant --> false},
__{}__{}{
__{}__{}    jr    c, $+14       ; 2:7/12    __INFO   negative d1 < positive constant --> true})
__{}    ld    A, L          ; 1:4       __INFO   DEHL<$1 --> DEHL-__HEX_DEHL($1)<0 --> carry if true
__{}    sub   A, __HEX_L($1)       ; 2:7       __INFO   DEHL<$1 --> ...A-0x......format({%02X},eval((($1)>>0) & 0xFF))<0 --> carry if true
__{}    ld    A, H          ; 1:4       __INFO   DEHL<$1 --> DEHL-__HEX_DEHL($1)<0 --> carry if true
__{}    sbc   A, __HEX_H($1)       ; 2:7       __INFO   DEHL<$1 --> ..A.-0x....format({%02X},eval((($1)>>8) & 0xFF))..<0 --> carry if true
__{}    ld    A, E          ; 1:4       __INFO   DEHL<$1 --> DEHL-__HEX_DEHL($1)<0 --> carry if true
__{}    sbc   A, __HEX_E($1)       ; 2:7       __INFO   DEHL<$1 --> .A..-0x..format({%02X},eval((($1)>>16) & 0xFF))....<0 --> carry if true
__{}    ld    A, D          ; 1:4       __INFO   DEHL<$1 --> DEHL-__HEX_DEHL($1)<0 --> carry if true
__{}    sbc   A, __HEX_D($1)       ; 2:7       __INFO   DEHL<$1 --> A...-0x{}format({%02X},eval((($1)>>24) & 0xFF))......<0 --> carry if true
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d1<$1})},
{
    .error {$0}($@): $# parameters found in macro!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup d. d<
dnl # ( d -- d f )
define({_2DUP_PUSH2_DLT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DLT},{2dup $1 $2 d<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DLT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- d flag )},4,30)
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d < $1*65536+$2}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D>=
dnl # ( d -- d f )
define({_2DUP_PUSHDOT_DGE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DGE},{2dup_pushdot_dge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DGE},{dnl
__{}define({__INFO},{2dup_pushdot_dge}){}dnl
ifelse($1,{},{
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
dnl # 2dup d. d>=
dnl # ( d -- d f )
define({_2DUP_PUSH2_DGE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DGE},{2dup $1 $2 d>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DGE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- d flag )},5,34)
__{}__{}    ccf                 ; 1:4       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    sbc  HL, HL         ; 2:15      __INFO   set flag d >= $1*65536+$2}){}dnl
}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## X bit Logic ( DE = [p2], HL = [p1] )
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl
dnl
dnl
dnl
dnl # ( p2 p1 -- p2 p1 flag )
dnl # equal ( [p1] == [p2] )
define({PEQ},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PEQ},{p{}eval(8*($1))=},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PEQ},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    sub 0x01            ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),2,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+9        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    sub 0x01            ; 2:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),3,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+16       ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+9        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    sub 0x01            ; 2:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),4,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+22       ; 2:7/12    __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+14       ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+8        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    sub 0x01            ; 2:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),256,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-6        ; 2:7/12    __INFO
__{}    scf                 ; 1:4       __INFO
__{}    ld    L, 0x00       ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == [p{}eval(8*($1))_2]  with align $1
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-6            ; 2:8/13    __INFO
__{}    scf                 ; 1:4       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( p1 -- p1 flag )
dnl # flag = [p1] == 0
define({P0EQ},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_P0EQ},{p{}eval(8*($1)) 0=},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_P0EQ},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == 0  with align $1
__{}    ld    A,(HL)        ; 1:7       __INFO
__{}    sub 0x01            ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),2,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == 0  with align $1
__{}    ld    A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    sub 0x01            ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),3,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == 0  with align $1
__{}    ld    A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    sub 0x01            ; 2:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),4,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == 0  with align $1
__{}    ld    A,(HL)        ; 1:7       __INFO
__{}    or    A             ; 1:4       __INFO
__{}    jr   nz, $+16       ; 2:7/12    __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    jr   nz, $+10       ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    sub 0x01            ; 2:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),256,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == 0  with align $1
__{}    xor   A             ; 1:4       __INFO
__{}    ld    D, A          ; 1:4       __INFO
__{}    ld    E, A          ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    jr   nz, $-4        ; 2:7/12    __INFO
__{}    dec  DE             ; 1:6       __INFO
__{}    ld    L, 0x00       ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO},
__{}{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_1 -- p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] == 0  with align $1
__{}    xor   A             ; 1:4       __INFO
__{}    ld    D, A          ; 1:4       __INFO
__{}    ld    E, A          ; 1:4       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    jr   nz, $+5        ; 2:7/12    __INFO
__{}    djnz $-3            ; 2:8/13    __INFO
__{}    dec  DE             ; 1:6       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl
dnl # ( p2 p1 -- p2 p1 flag )
dnl # not equal ( [p1] != [p2] )
define({PNE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PNE},{p{}eval(8*($1))<>},$@)}){}dnl
}){}dnl
dnl
dnl
dnl
define({__ASM_TOKEN_PNE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] != [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO   carry if not zero
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),2,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] != [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO   carry if not zero
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),3,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] != [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+14       ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO   carry if not zero
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}eval($1),4,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] != [p{}eval(8*($1))_2]  with align $1
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+18       ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+12       ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO   carry if not zero
__{}    ld     L, C         ; 1:4       __INFO
__{}    ex    DE, HL        ; 1:4       __INFO
__{}    sbc   HL, HL        ; 2:15      __INFO},
__{}eval($1),256,{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] != [p{}eval(8*($1))_2]  with align $1
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-6        ; 2:7/12    __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO   carry if not zero
__{}    ld    L, 0x00       ; 2:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO},
__{}{
__{}    push DE             ; 1:11      __INFO   ( p{}eval(8*($1))_2 p{}eval(8*($1))_1 -- p{}eval(8*($1))_2 p{}eval(8*($1))_1 flag )  flag = [p{}eval(8*($1))_1] != [p{}eval(8*($1))_2]  with align $1
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    xor (HL)            ; 1:7       __INFO
__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-6            ; 2:8/13    __INFO
__{}    add   A, 0xFF       ; 2:7       __INFO   carry if not zero
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( pu2 pu1 -- pu2 pu1 flag )
dnl # unsigned ( [pu2] u< [pu1] ) --> ( [pu2] - [pu1] u< 0 ) --> carry is true
define({PULT},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PULT},{p{}eval(8*($1))ult},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PULT},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u< [pu{}eval(8*($1))_1]  with align 4
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<[pu{}eval(8*($1))_1]},
__{}eval($1),2,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u< [pu{}eval(8*($1))_1]  with align 4
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<[pu{}eval(8*($1))_1]},
__{}eval($1),3,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u< [pu{}eval(8*($1))_1]  with align 4
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<[pu{}eval(8*($1))_1]},
__{}eval($1),4,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u< [pu{}eval(8*($1))_1]  with align 4
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<[pu{}eval(8*($1))_1]},
__{}eval($1),256,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u< [pu{}eval(8*($1))_1]  with align 4
__{}ifelse(TYP_P,{small},{dnl
__{}__{}    or    A             ; 1:4       __INFO},
__{}{dnl
__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    inc   E             ; 1:4       __INFO})
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-4        ; 2:7/12    __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<[pu{}eval(8*($1))_1]},
__{}{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u< [pu{}eval(8*($1))_1]  with align 4
__{}    ld    C, L          ; 1:4       __INFO
__{}ifelse(TYP_P,{small},{dnl
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO},
__{}{dnl
__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    inc   E             ; 1:4       __INFO
__{}__{}    ld    B, __HEX_L($1-1)       ; 2:7       __INFO})
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-4            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<[pu{}eval(8*($1))_1]})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( pu2 pu1 -- pu2 pu1 flag )
dnl # unsigned ( [pu2] u>= [pu1] ) --> ( [pu2] - [pu1] u>= 0 ) --> not carry is true
define({PUGE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUGE},{p{}eval(8*($1))uge},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUGE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u>= [pu{}eval(8*($1))_1]  with align 4
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>=[pu{}eval(8*($1))_1]},
__{}eval($1),2,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u>= [pu{}eval(8*($1))_1]  with align 4
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>=[pu{}eval(8*($1))_1]},
__{}eval($1),3,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u>= [pu{}eval(8*($1))_1]  with align 4
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>=[pu{}eval(8*($1))_1]},
__{}eval($1),4,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u>= [pu{}eval(8*($1))_1]  with align 4
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>=[pu{}eval(8*($1))_1]},
__{}eval($1),256,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u>= [pu{}eval(8*($1))_1]  with align 4
__{}ifelse(TYP_P,{small},{dnl
__{}__{}    or    A             ; 1:4       __INFO},
__{}{dnl
__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    inc   E             ; 1:4       __INFO})
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-4        ; 2:7/12    __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>=[pu{}eval(8*($1))_1]},
__{}{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u>= [pu{}eval(8*($1))_1]  with align 4
__{}    ld    C, L          ; 1:4       __INFO
__{}ifelse(TYP_P,{small},{dnl
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO},
__{}{dnl
__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    inc   E             ; 1:4       __INFO
__{}__{}    ld    B, __HEX_L($1-1)       ; 2:7       __INFO})
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-4            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>=[pu{}eval(8*($1))_1]})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( pu2 pu1 -- pu2 pu1 flag )
dnl # unsigned ( [pu2] u> [pu1] ) --> ( 0 u> [pu1] - [pu2] ) --> carry is true
define({PUGT},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUGT},{p{}eval(8*($1))ugt},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUGT},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u> [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>[pu{}eval(8*($1))_1]},
__{}eval($1),2,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u> [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>[pu{}eval(8*($1))_1]},
__{}eval($1),3,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u> [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>[pu{}eval(8*($1))_1]},
__{}eval($1),4,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u> [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>[pu{}eval(8*($1))_1]},
__{}eval($1),256,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u> [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}ifelse(TYP_P,{small},{dnl
__{}__{}    or    A             ; 1:4       __INFO},
__{}{dnl
__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    inc   E             ; 1:4       __INFO})
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-4        ; 2:7/12    __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>[pu{}eval(8*($1))_1]},
__{}{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u> [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}ifelse(TYP_P,{small},{dnl
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO},
__{}{dnl
__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    inc   E             ; 1:4       __INFO
__{}__{}    ld    B, __HEX_L($1-1)       ; 2:7       __INFO})
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-4            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u>[pu{}eval(8*($1))_1]})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( pu2 pu1 -- pu2 pu1 flag )
dnl # unsigned ( [pu2] u<= [pu1] ) --> ( 0 u<= [pu1] - [pu2] ) --> not carry is true
define({PULE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PULE},{p{}eval(8*($1))ule},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PULE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1),{0},{
__{}  .error {$0}($@): The parameter is 0!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($1),1,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u<= [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<=[pu{}eval(8*($1))_1]},
__{}eval($1),2,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u<= [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<=[pu{}eval(8*($1))_1]},
__{}eval($1),3,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u<= [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<=[pu{}eval(8*($1))_1]},
__{}eval($1),4,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u<= [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sub (HL)            ; 1:7       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<=[pu{}eval(8*($1))_1]},
__{}eval($1),256,{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u<= [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}ifelse(TYP_P,{small},{dnl
__{}__{}    or    A             ; 1:4       __INFO},
__{}{dnl
__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    inc   E             ; 1:4       __INFO})
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-4        ; 2:7/12    __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<=[pu{}eval(8*($1))_1]},
__{}{
__{}    push DE             ; 1:11      __INFO   ( pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 -- pu{}eval(8*($1))_2 pu{}eval(8*($1))_1 flag )  flag == [pu{}eval(8*($1))_2] u<= [pu{}eval(8*($1))_1]  with align 4
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}ifelse(TYP_P,{small},{dnl
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO},
__{}{dnl
__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    inc   E             ; 1:4       __INFO
__{}__{}    ld    B, __HEX_L($1-1)       ; 2:7       __INFO})
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-4            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   set flag [pu{}eval(8*($1))_2]u<=[pu{}eval(8*($1))_1]})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl

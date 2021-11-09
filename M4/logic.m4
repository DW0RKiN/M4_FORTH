dnl ## Logic
define({__},{})dnl
dnl
dnl ( x1 x2 -- x )
dnl x = x1 & x2
define(AND,{
    ld    A, E          ; 1:4       and
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and})dnl
dnl
dnl
dnl ( x -- x&n )
dnl x = x & n
define(PUSH_AND,{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[10:42]    $1 and
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1 and
__{}__{}    and   H             ; 1:4       $1 and
__{}__{}    ld    H, A          ; 1:4       $1 and
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 and
__{}__{}    and   L             ; 1:4       $1 and
__{}__{}    ld    L, A          ; 1:4       $1 and},
__{}eval($1),{},{dnl
__{}__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}__{}                        ;[8:30]     $1 and
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 and
__{}__{}    and   H             ; 1:4       $1 and
__{}__{}    ld    H, A          ; 1:4       $1 and
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 and
__{}__{}    and   L             ; 1:4       $1 and
__{}__{}    ld    L, A          ; 1:4       $1 and},
__{}{dnl
__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}    ld   HL, 0x0000     ; 3:10      $1 and},
__{}__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}__{}    ld    H, 0x00       ; 2:7       $1 and},
__{}__{}eval(0xFF00 - 0x00 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}                        ;           $1 and   (H and 0xFF) = H},
__{}__{}eval(0xFF00 - 0x0100 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    res   0, H          ; 2:8       $1 and},
__{}__{}eval(0xFF00 - 0x0200 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    res   1, H          ; 2:8       $1 and},
__{}__{}eval(0xFF00 - 0x0400 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    res   2, H          ; 2:8       $1 and},
__{}__{}eval(0xFF00 - 0x0800 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    res   3, H          ; 2:8       $1 and},
__{}__{}eval(0xFF00 - 0x1000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    res   4, H          ; 2:8       $1 and},
__{}__{}eval(0xFF00 - 0x2000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    res   5, H          ; 2:8       $1 and},
__{}__{}eval(0xFF00 - 0x4000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    res   6, H          ; 2:8       $1 and},
__{}__{}eval(0xFF00 - 0x8000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    res   7, H          ; 2:8       $1 and},
__{}__{}{dnl
__{}__{}__{}    ld    A, format({%-11s},eval(($1)>>8)); 2:7       $1 and
__{}__{}__{}    and   H             ; 1:4       $1 and
__{}__{}__{}    ld    H, A          ; 1:4       $1 and})
__{}__{}ifelse(eval($1),{0},,
__{}__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}__{}    ld    L, 0x00       ; 2:7       $1 and},
__{}__{}eval(0xFF - 0x00 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}                        ;           $1 and   (L and 0xFF) = L},
__{}__{}eval(0xFF - 0x01 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    res   0, L          ; 2:8       $1 and},
__{}__{}eval(0xFF - 0x02 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    res   1, L          ; 2:8       $1 and},
__{}__{}eval(0xFF - 0x04 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    res   2, L          ; 2:8       $1 and},
__{}__{}eval(0xFF - 0x08 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    res   3, L          ; 2:8       $1 and},
__{}__{}eval(0xFF - 0x10 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    res   4, L          ; 2:8       $1 and},
__{}__{}eval(0xFF - 0x20 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    res   5, L          ; 2:8       $1 and},
__{}__{}eval(0xFF - 0x40 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    res   6, L          ; 2:8       $1 and},
__{}__{}eval(0xFF - 0x80 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    res   7, L          ; 2:8       $1 and},
__{}__{}{dnl
__{}__{}    ld    A, format({%-11s},eval(($1) & 0xFF)); 2:7       $1 and
__{}__{}    and   L             ; 1:4       $1 and
__{}__{}    ld    L, A          ; 1:4       $1 and}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl ( x1 x2 -- x )
dnl x = x1 | x2
define(OR,{
    ld    A, E          ; 1:4       or
    or    L             ; 1:4       or
    ld    L, A          ; 1:4       or
    ld    A, D          ; 1:4       or
    or    H             ; 1:4       or
    ld    H, A          ; 1:4       or
    pop  DE             ; 1:10      or})dnl
dnl
dnl
dnl ( x -- x|n )
dnl x = x | n
define(PUSH_OR,{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[10:42]    $1 or
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1 or
__{}__{}    or    H             ; 1:4       $1 or
__{}__{}    ld    H, A          ; 1:4       $1 or
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 or
__{}__{}    or    L             ; 1:4       $1 or
__{}__{}    ld    L, A          ; 1:4       $1 or},
__{}eval($1),{},{dnl
__{}__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}__{}                        ;[8:30]     $1 or
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 or
__{}__{}    or    H             ; 1:4       $1 or
__{}__{}    ld    H, A          ; 1:4       $1 or
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 or
__{}__{}    or    L             ; 1:4       $1 or
__{}__{}    ld    L, A          ; 1:4       $1 or},
__{}{dnl
__{}__{}ifelse(eval(0xFFFF-($1)),{0},{dnl
__{}__{}    ld   HL, 0xFFFF     ; 3:10      $1 or},
__{}__{}eval(0xFF00 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    ld    H, 0xFF       ; 2:7       $1 or},
__{}__{}eval(0x0000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}                        ;           $1 or   (H or 0x00) = H},
__{}__{}eval(0x0100 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    set   0, H          ; 2:8       $1 or},
__{}__{}eval(0x0200 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    set   1, H          ; 2:8       $1 or},
__{}__{}eval(0x0400 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    set   2, H          ; 2:8       $1 or},
__{}__{}eval(0x0800 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    set   3, H          ; 2:8       $1 or},
__{}__{}eval(0x1000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    set   4, H          ; 2:8       $1 or},
__{}__{}eval(0x2000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    set   5, H          ; 2:8       $1 or},
__{}__{}eval(0x4000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    set   6, H          ; 2:8       $1 or},
__{}__{}eval(0x8000 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    set   7, H          ; 2:8       $1 or},
__{}__{}{dnl
__{}__{}__{}    ld    A, format({%-11s},eval(($1)>>8)); 2:7       $1 or
__{}__{}__{}    or    H             ; 1:4       $1 or
__{}__{}__{}    ld    H, A          ; 1:4       $1 or})
__{}__{}ifelse(eval(0xFFFF-($1)),{0},,
__{}__{}eval(0xFF - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    ld    L, 0xFF       ; 2:7       $1 or},
__{}__{}eval(0x00 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}                        ;           $1 or   (L or 0x00) = L},
__{}__{}eval(0x01 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    set   0, L          ; 2:8       $1 or},
__{}__{}eval(0x02 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    set   1, L          ; 2:8       $1 or},
__{}__{}eval(0x04 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    set   2, L          ; 2:8       $1 or},
__{}__{}eval(0x08 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    set   3, L          ; 2:8       $1 or},
__{}__{}eval(0x10 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    set   4, L          ; 2:8       $1 or},
__{}__{}eval(0x20 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    set   5, L          ; 2:8       $1 or},
__{}__{}eval(0x40 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    set   6, L          ; 2:8       $1 or},
__{}__{}eval(0x80 - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    set   7, L          ; 2:8       $1 or},
__{}__{}{dnl
__{}__{}    ld    A, format({%-11s},eval(($1) & 0xFF)); 2:7       $1 or
__{}__{}    or    L             ; 1:4       $1 or
__{}__{}    ld    L, A          ; 1:4       $1 or}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl ( x1 x2 -- x )
dnl x = x1 ^ x2
define(XOR,{
    ld    A, E          ; 1:4       xor
    xor   L             ; 1:4       xor
    ld    L, A          ; 1:4       xor
    ld    A, D          ; 1:4       xor
    xor   H             ; 1:4       xor
    ld    H, A          ; 1:4       xor
    pop  DE             ; 1:10      xor})dnl
dnl
dnl
dnl ( x -- x^n )
dnl x = x ^ n
define(PUSH_XOR,{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[10:42]    $1 xor
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      $1 xor
__{}__{}    xor   H             ; 1:4       $1 xor
__{}__{}    ld    H, A          ; 1:4       $1 xor
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 xor
__{}__{}    xor   L             ; 1:4       $1 xor
__{}__{}    ld    L, A          ; 1:4       $1 xor},
__{}eval($1),{},{dnl
__{}__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}__{}                        ;[8:30]     $1 xor
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 xor
__{}__{}    xor   H             ; 1:4       $1 xor
__{}__{}    ld    H, A          ; 1:4       $1 xor
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 xor
__{}__{}    xor   L             ; 1:4       $1 xor
__{}__{}    ld    L, A          ; 1:4       $1 xor},
__{}{dnl
__{}__{}ifelse(eval(0xFF00 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}    ld    A, H          ; 1:4       $1 xor
__{}__{}__{}    cpl                 ; 1:4       $1 xor
__{}__{}__{}    ld    H, A          ; 1:4       $1 xor   (H xor 0xFF) = invert H},
__{}__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}__{}                        ;           $1 xor   (H xor 0x00) = H},
__{}__{}{dnl
__{}__{}__{}    ld    A, format({%-11s},eval(($1)>>8)); 2:7       $1 xor
__{}__{}__{}    xor   H             ; 1:4       $1 xor
__{}__{}__{}    ld    H, A          ; 1:4       $1 xor})
__{}__{}ifelse(eval(0xFF - (($1) & 0xFF)),{0},{dnl
__{}__{}__{}    ld    A, L          ; 1:4       $1 xor
__{}__{}__{}    cpl                 ; 1:4       $1 xor
__{}__{}__{}    ld    L, A          ; 1:4       $1 xor   (L xor 0xFF) = invert L},
__{}__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}__{}                        ;           $1 xor   (L xor 0x00) = L},
__{}__{}{dnl
__{}__{}__{}    ld    A, format({%-11s},eval(($1) & 0xFF)); 2:7       $1 xor
__{}__{}__{}    xor   L             ; 1:4       $1 xor
__{}__{}__{}    ld    L, A          ; 1:4       $1 xor}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl ( x1 -- x )
dnl x = ~x1
dnl -1   -> false
dnl false-> true
define(INVERT,{
    ld    A, L          ; 1:4       invert
    cpl                 ; 1:4       invert
    ld    L, A          ; 1:4       invert
    ld    A, H          ; 1:4       invert
    cpl                 ; 1:4       invert
    ld    H, A          ; 1:4       invert})dnl
dnl
dnl
dnl ( a b c -- ((a-b) (c-b) U<) )
dnl b <= a < c
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
dnl ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl $1 <= a < $2
define({PUSH2_WITHIN},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[22:ifelse(index({$2},{(}),{0},{137},{131})]   push2_within($1,$2)   ( a $1 $2 -- flag=($1<=a<$2) )
__{}__{}    ld   BC, format({%-11s},$1); 4:20      push2_within($1,$2)   BC = $1
__{}__{}    or    A             ; 1:4       push2_within($1,$2)
__{}__{}    sbc  HL, BC         ; 2:15      push2_within($1,$2)   HL = a-$1
__{}__{}    push HL             ; 1:11      push2_within($1,$2)
__{}__{}    ld   HL, format({%-11s},$2); ifelse(index({$2},{(}),{0},{3:16},{3:10})      push2_within($1,$2)
__{}__{}    or    A             ; 1:4       push2_within($1,$2)
__{}__{}    sbc  HL, BC         ; 2:15      push2_within($1,$2)   HL = $2-$1
__{}__{}    ld    C, L          ; 1:4       push2_within($1,$2)
__{}__{}    ld    B, H          ; 1:4       push2_within($1,$2)   BC = $2-$1
__{}__{}    pop  HL             ; 1:10      push2_within($1,$2)
__{}__{}    or    A             ; 1:4       push2_within($1,$2)
__{}__{}    sbc  HL, BC         ; 2:15      push2_within($1,$2)   HL = (a-$1) - ($2-$1)
__{}__{}    sbc  HL, HL         ; 2:15      push2_within($1,$2)   HL = 0x0000 or 0xffff},
__{}index({$2},{(}),{0},{dnl
__{}__{}ifelse(eval(-($1)),{},{dnl
__{}__{}__{}                        ;[17:111]   push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    ld   BC, format({%-11s},-($1)); 3:10      push2_within($1,$2)   BC = -($1)
__{}__{}__{}    add  HL, BC         ; 1:11      push2_within($1,$2)   HL = a-($1) = 0x10000-($1)+a
__{}__{}__{}    push HL             ; 1:11      push2_within($1,$2)
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      push2_within($1,$2)
__{}__{}__{}    add  HL, BC         ; 1:11      push2_within($1,$2)   HL = $2-($1)},
__{}__{}{dnl
__{}__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}__{}__{}                        ;[17:111]   push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    push HL             ; 1:11      push2_within($1,$2)
__{}__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      push2_within($1,$2)},
__{}__{}__{}eval($1),{1},{dnl
__{}__{}__{}__{}                        ;[11:66]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)   HL = a-($1)
__{}__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      push2_within($1,$2)
__{}__{}__{}__{}    dec  BC             ; 1:6       push2_within($1,$2)   BC = ($2)-($1)},
__{}__{}__{}eval($1),{-1},{dnl
__{}__{}__{}__{}                        ;[11:66]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)   HL = a-($1)
__{}__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      push2_within($1,$2)
__{}__{}__{}__{}    inc  BC             ; 1:6       push2_within($1,$2)   BC = $2-($1)},
__{}__{}__{}eval($1),{2},{dnl
__{}__{}__{}__{}                        ;[13:78]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)   HL = a-($1)
__{}__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      push2_within($1,$2)
__{}__{}__{}__{}    dec  BC             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    dec  BC             ; 1:6       push2_within($1,$2)   BC = ($2)-($1)},
__{}__{}__{}eval($1),{-2},{dnl
__{}__{}__{}__{}                        ;[13:78]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)   HL = a-($1)
__{}__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      push2_within($1,$2)
__{}__{}__{}__{}    inc  BC             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    inc  BC             ; 1:6       push2_within($1,$2)   BC = $2-($1)},
__{}__{}__{}eval($1),{3},{dnl
__{}__{}__{}__{}                        ;[15:90]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)   HL = a-($1)
__{}__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      push2_within($1,$2)
__{}__{}__{}__{}    dec  BC             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    dec  BC             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    dec  BC             ; 1:6       push2_within($1,$2)   BC = ($2)-($1)},
__{}__{}__{}eval($1),{-3},{dnl
__{}__{}__{}__{}                        ;[15:90]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)   HL = a-($1)
__{}__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      push2_within($1,$2)
__{}__{}__{}__{}    inc  BC             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    inc  BC             ; 1:6       push2_within($1,$2)
__{}__{}__{}__{}    inc  BC             ; 1:6       push2_within($1,$2)   BC = $2-($1)},
__{}__{}__{}{
__{}__{}__{}__{}                        ;[17:111]   push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}__{}    ld   BC, format({%-11s},eval((65536-($1)) & 0xFFFF)); 3:10      push2_within($1,$2)   BC = -($1)
__{}__{}__{}__{}    add  HL, BC         ; 1:11      push2_within($1,$2)   HL = a-($1) = 0x10000-($1)+a
__{}__{}__{}__{}    push HL             ; 1:11      push2_within($1,$2)
__{}__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      push2_within($1,$2)
__{}__{}__{}__{}    add  HL, BC         ; 1:11      push2_within($1,$2)   HL = ($2)-($1)
__{}__{}__{}__{}    ld    C, L          ; 1:4       push2_within($1,$2)
__{}__{}__{}__{}    ld    B, H          ; 1:4       push2_within($1,$2)   BC = ($2)-($1)
__{}__{}__{}__{}    pop  HL             ; 1:10      push2_within($1,$2)})})
__{}__{}    or    A             ; 1:4       push2_within($1,$2)
__{}__{}    sbc  HL, BC         ; 2:15      push2_within($1,$2)   HL = (a-($1))-($2-($1))
__{}__{}    sbc  HL, HL         ; 2:15      push2_within($1,$2)   HL = 0x0000 or 0xffff},
__{}{dnl
__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}__{}                        ;[8:37]     push2_within($1,$2)   ( a -- flag=($1<=a<$2) )},
__{}__{}eval($1),{1},{dnl
__{}__{}__{}                        ;[9:43]     push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)   HL = (a-($1))},
__{}__{}eval($1),{-1},{dnl
__{}__{}__{}                        ;[9:43]     push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)   HL = (a-($1))},
__{}__{}eval($1),{2},{dnl
__{}__{}__{}                        ;[10:49]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)   HL = (a-($1))},
__{}__{}eval($1),{-2},{dnl
__{}__{}__{}                        ;[10:49]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)   HL = (a-($1))},
__{}__{}eval($1),{3},{dnl
__{}__{}__{}                        ;[11:55]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}    dec  HL             ; 1:6       push2_within($1,$2)   HL = (a-($1))},
__{}__{}eval($1),{-3},{dnl
__{}__{}__{}                        ;[11:55]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       push2_within($1,$2)   HL = (a-($1))},
__{}__{}{
__{}__{}__{}                        ;[12:58]    push2_within($1,$2)   ( a -- flag=($1<=a<$2) )
__{}__{}__{}ifelse(eval(-($1)),{},{dnl
__{}__{}__{}__{}    ld   BC, format({%-11s},-($1)); 3:10      push2_within($1,$2)   BC = -($1)},
__{}__{}__{}{dnl
__{}__{}__{}__{}    ld   BC, format({%-11s},eval((65536-($1)) & 0xFFFF)); 3:10      push2_within($1,$2)   BC = -($1)})
__{}__{}__{}    add  HL, BC         ; 1:11      push2_within($1,$2)   HL = a-($1) = 0x10000-($1)+a})
__{}__{}    ld    A, L          ; 1:4       push2_within($1,$2){}dnl
__{}__{}__{}ifelse(eval((($2)-($1)) & 0xff),{},{
__{}__{}__{}    sub  low format({%-11s},($2)-($1)); 2:7       push2_within($1,$2)
__{}__{}__{}    ld    A, H          ; 1:4       push2_within($1,$2)
__{}__{}__{}    sbc   A, high format({%-6s},($2)-($1)); 2:7       push2_within($1,$2)   carry:(a-($1))-(($2)-($1)){}dnl
__{}__{}__{}},{
__{}__{}__{}    sub  format({%-15s},eval((($2)-($1)) & 0xff)); 2:7       push2_within($1,$2)
__{}__{}__{}    ld    A, H          ; 1:4       push2_within($1,$2)
__{}__{}__{}    sbc   A, format({%-11s},eval(((($2)-($1)) & 0xff00)>>8)); 2:7       push2_within($1,$2)   carry:(a-($1))-(($2)-($1))})
__{}__{}    sbc  HL, HL         ; 2:15      push2_within($1,$2)   HL = 0x0000 or 0xffff}){}dnl
})dnl
dnl
dnl
dnl ( c3 c2 c1 -- ((c3-c2) (c1-c2) U<) )
dnl c2 <= c3 < c1
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
dnl ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl $1 <= a < $2
define({PUSH2_LO_WITHIN},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}                        ;[ifelse(index({$2},{(}),{0},{14:65},{13:59})]    push2_lo_within($1,$2)   ( a $1 $2 -- flag=($1<=a<$2) )
__{}    ld    A, format({%-11s},$1); 3:13      push2_lo_within($1,$2)
__{}    ld    C, A          ; 1:4       push2_lo_within($1,$2)   C = $1
__{}    ld    A, format({%-11s},$2); ifelse(index({$2},{(}),{0},{3:13},{2:7 })      push2_lo_within($1,$2)
__{}    sub   C             ; 1:4       push2_lo_within($1,$2)
__{}    ld    B, A          ; 1:4       push2_lo_within($1,$2)   B = ($2)-[$1]
__{}    ld    A, L          ; 1:4       push2_lo_within($1,$2)
__{}    sub   C             ; 1:4       push2_lo_within($1,$2)   A = a -($1)
__{}    sub   B             ; 1:4       push2_lo_within($1,$2)   A = (a -($1)) - ([$2]-($1))
__{}    sbc  HL, HL         ; 2:15      push2_lo_within($1,$2)   HL = 0x0000 or 0xffff}dnl
__{},index({$2},{(}),{0},{dnl
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
__{}__{}ifelse(eval($1),{},{dnl
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
dnl -------------------------------------
dnl
dnl ( -- x )
dnl x = 0xFFFF
define(TRUE,{
    push DE             ; 1:11      true
    ex   DE, HL         ; 1:4       true
    ld   HL, 0xffff     ; 3:10      true})dnl
dnl
dnl ( -- x )
dnl x = 0
define(FALSE,{
    push DE             ; 1:11      false
    ex   DE, HL         ; 1:4       false
    ld   HL, 0x0000     ; 3:10      false})dnl
dnl
dnl -------------------------------------
dnl
dnl D0=
dnl ( x2 x1 -- flag )
dnl if ( x1x2 ) flag = 0; else flag = 0xFFFF;
dnl 0 if 32-bit number not equal to zero, -1 if equal
define(D0EQ,{
                        ;[9:48]     D0=
    ld    A, D          ; 1:4       D0=
    or    E             ; 1:4       D0=
    or    H             ; 1:4       D0=
    or    L             ; 1:4       D0=
    sub   0x01          ; 2:7       D0=
    sbc  HL, HL         ; 2:15      D0=
    pop   DE            ; 1:10      D0=})dnl
dnl
dnl
dnl 0=
dnl ( x1 -- flag )
dnl if ( x1 ) flag = 0; else flag = 0xFFFF;
dnl 0 if 16-bit number not equal to zero, -1 if equal
define(_0EQ,{
                        ;[5:29]     0=
    ld    A, H          ; 1:4       0=
    dec  HL             ; 1:6       0=
    sub   H             ; 1:4       0=
    sbc  HL, HL         ; 2:15      0=})dnl
dnl
dnl
dnl
dnl ------------ signed -----------------
dnl
dnl
dnl =
dnl ( x1 x2 -- flag )
dnl equal ( x1 == x2 )
define({EQ},{
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      =})dnl
dnl
dnl
dnl ( x -- x|n )
dnl x = x | n
define(PUSH_EQ,{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[13:62/61] $1 =
__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 =
__{}__{}    or    A             ; 1:4       $1 =
__{}__{}    sbc  HL, BC         ; 2:15      $1 =
__{}__{}    ld   HL, 0x0000     ; 3:10      $1 =
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 =
__{}__{}    dec  HL             ; 1:6       $1 =},
__{}eval($1),{},{dnl
__{}__{}    .warning {$0}($@): M4 does not know the "{$1}" value and therefore cannot optimize the code.
__{}__{}                        ;[12:52/51] $1 =
__{}__{}    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      $1 =
__{}__{}    or    A             ; 1:4       $1 =
__{}__{}    sbc  HL, BC         ; 2:15      $1 =
__{}__{}    ld   HL, 0x0000     ; 3:10      $1 =
__{}__{}    jr   nz, $+3        ; 2:7/12    $1 =
__{}__{}    dec  HL             ; 1:6       $1 =},
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
__{}__{}    ld    A, format({0x%02X},eval(($1)&0xff))       ; 2:7       $1 =   lo($1)
__{}__{}    xor   L             ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval(($1) & 0xff),{0},{dnl
__{}__{}                        ;[8:37]     $1 =
__{}__{}    ld    A, format({0x%02X},eval((($1)>>8)&0xff))       ; 2:7       $1 =   hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    or    L             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval((($1)>>8) & 0xff),{1},{dnl
__{}__{}                        ;[9:41]     $1 =
__{}__{}    ld    A, format({0x%02X},eval(($1)&0xff))       ; 2:7       $1 =   lo($1)
__{}__{}    xor   L             ; 1:4       $1 =
__{}__{}    dec   H             ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval((($1)>>8) & 0xff),{255},{dnl
__{}__{}                        ;[9:41]     $1 =
__{}__{}    ld    A, format({0x%02X},eval(($1)&0xff))       ; 2:7       $1 =   lo($1)
__{}__{}    xor   L             ; 1:4       $1 =
__{}__{}    inc   H             ; 1:4       $1 =
__{}__{}    or    H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval(($1) & 0xff),{1},{dnl
__{}__{}                        ;[9:41]     $1 =
__{}__{}    ld    A, format({0x%02X},eval((($1)>>8)&0xff))       ; 2:7       $1 =   hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    dec   L             ; 1:4       $1 =
__{}__{}    or    L             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}eval(($1) & 0xff),{255},{dnl
__{}__{}                        ;[9:41]     $1 =
__{}__{}    ld    A, format({0x%02X},eval((($1)>>8)&0xff))       ; 2:7       $1 =   hi($1)
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
__{}__{}    ld    A, format({0x%02X},eval(($1) & 0xff))       ; 2:7       $1 =   lo($1) = hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =},
__{}__{}{dnl
__{}__{}                        ;[12:51/38] $1 =
__{}__{}    ld    A, format({0x%02X},eval(($1) & 0xff))       ; 2:7       $1 =   lo($1)
__{}__{}    xor   L             ; 1:4       $1 =
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 =
__{}__{}    ld    A, format({0x%02X},eval((($1)>>8) & 0xff))       ; 2:7       $1 =   hi($1)
__{}__{}    xor   H             ; 1:4       $1 =
__{}__{}    sub  0x01           ; 2:7       $1 =
__{}__{}    sbc  HL, HL         ; 2:15      $1 =}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl D=
dnl ( d1 d2 -- flag )
dnl equal ( d1 == d2 )
define({DEQ},{
                       ;[17:83/97/98]D=
    pop  BC             ; 1:10      D=   lo word2
    or    A             ; 1:4       D=
    sbc  HL, BC         ; 2:15      D=   lo_1 - lo_2
    pop  BC             ; 1:10      D=   hi word2
    jr   nz, $+5        ; 2:7/12    D=
    ex   DE, HL         ; 1:4       D=
    sbc  HL, BC         ; 2:15      D=
    pop  DE             ; 1:10      D=
    ld   HL, 0x0000     ; 3:10      D=
    jr   nz, $+3        ; 2:7/12    D=
    dec  HL             ; 1:6       D=
})dnl
dnl
dnl
dnl <>
dnl ( x1 x2 -- flag )
dnl not equal ( x1 <> x2 )
define({NE},{
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <>})dnl
dnl
dnl
dnl <
dnl ( x2 x1 -- flag )
dnl signed ( x2 < x1 ) --> ( x2 - x1 < 0 ) --> carry is true
define(LT,{
                        ;[12:54]    <
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
dnl D<
dnl ( d2 d1 -- flag )
dnl signed ( d2 < d1 ) --> ( d2 - d1 < 0 ) --> carry is true
define(DLT,{define({USE_DLT},{})
                        ;[4:137]    D<   ( hi_2 lo_2 hi_1 lo_1 -- flag )
    pop  BC             ; 1:10      D<   BC = lo_2
    call LT_32          ; 3:17      D<})dnl
dnl
dnl
dnl 0<
dnl ( x1 -- flag )
define(_0LT,{
    rl    H             ; 2:8       0<
    sbc  HL, HL         ; 2:15      0<})dnl
dnl
dnl
dnl
dnl D0<
dnl ( d -- flag )
define(D0LT,{
    rl    D             ; 2:8       D0<
    pop  DE             ; 1:11      D0<
    sbc  HL, HL         ; 2:15      D0<})dnl
dnl
dnl
dnl <=
dnl ( x2 x1 -- flag )
dnl signed ( x2 <= x1 ) --> ( x2 - 1 < x1 ) --> ( x2 - x1 - 1 < 0 ) --> carry is true
define(LE,{
    ld    A, H          ; 1:4       <=
    xor   D             ; 1:4       <=
    jp    p, $+7        ; 3:10      <=
    rl    D             ; 2:8       <= sign x2
    jr   $+6            ; 2:12      <=
    scf                 ; 1:4       <=
    ex   DE, HL         ; 1:4       <=
    sbc  HL, DE         ; 2:15      <=
    sbc  HL, HL         ; 2:15      <=
    pop  DE             ; 1:10      <=})dnl
dnl
dnl
dnl >
dnl ( x2 x1 -- flag )
dnl signed ( x2 > x1 ) --> ( 0 > x1 - x2 ) --> carry is true
define(GT,{
    ld    A, H          ; 1:4       >
    xor   D             ; 1:4       >
    jp    p, $+7        ; 3:10      >
    rl    H             ; 2:8       > sign x1
    jr   $+4            ; 2:12      >
    sbc  HL, DE         ; 2:15      >
    sbc  HL, HL         ; 2:15      >
    pop  DE             ; 1:10      >})dnl
dnl
dnl
dnl >=
dnl ( x2 x1 -- flag )
dnl signed ( x2 >= x1 ) --> ( x2 + 1 > x1 ) --> ( 0 > x1 - x2 - 1 ) --> carry is true
define({GE},{
    ld    A, H          ; 1:4       >=
    xor   D             ; 1:4       >=
    jp    p, $+7        ; 3:10      >=
    rl    H             ; 2:8       >= sign x1
    jr   $+5            ; 2:12      >=
    scf                 ; 1:4       >=
    sbc  HL, DE         ; 2:15      >=
    sbc  HL, HL         ; 2:15      >=
    pop  DE             ; 1:10      >=})dnl
dnl
dnl
dnl 0>=
dnl ( x1 -- flag )
define(_0GE,{
    ld    A, H          ; 1:4       0>=
    sub   0x80          ; 2:7       0>=
    sbc  HL, HL         ; 2:15      0>=
    pop  DE             ; 1:10      0>=})dnl
dnl
dnl ------------ unsigned ---------------
dnl
dnl ( x1 x2 -- x )
dnl equal ( x1 == x2 )
define({UEQ},{EQ})dnl
dnl
dnl ( x1 x2 -- x )
dnl not equal ( x1 <> x2 )
define({UNE},{NE})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl unsigned ( x2 < x1 ) --> ( x2 - x1 < 0 ) --> carry is true
define(ULT,{
                        ;[7:41]     {U<}
    ld    A, E          ; 1:4       {U<}   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       {U<}   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       {U<}   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       {U<}   DE<HL --> DE-HL<0 --> carry if true
    sbc  HL, HL         ; 2:15      {U<}
    pop  DE             ; 1:10      {U<}})dnl
dnl
dnl
dnl DU<
dnl ( d2 d1 -- flag )
dnl unsigned ( d2 < d1 ) --> ( d2 - d1 < 0 ) --> carry is true
define(DULT,{
                        ;[11:76]    {DU<}   ( d2 d1 -- flag )
    pop  BC             ; 1:10      {DU<}   lo_2 word
    ld    A, C          ; 1:4       {DU<}   BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       {DU<}   BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       {DU<}   BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       {DU<}   BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      {DU<}   hi_2 word
    sbc  HL, DE         ; 2:15      {DU<}   HL<DE --> HL-DE<0 --> carry if true
    sbc  HL, HL         ; 2:15      {DU<}   set flag
    pop  DE             ; 1:10      {DU<}})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl unsigned ( x2 <= x1 ) --> ( x2 - 1 < x1 ) --> ( x2 - x1 - 1 < 0) --> carry is true
define(ULE,{
    scf                 ; 1:4       (u) <=
    ex   DE, HL         ; 1:4       (u) <=
    sbc  HL, DE         ; 2:15      (u) <=
    sbc  HL, HL         ; 2:15      (u) <=
    pop  DE             ; 1:10      (u) <=})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl unsigned ( x2 > x1 ) --> ( 0 > x1 - x2 ) --> carry is true
define(UGT,{
    or    A             ; 1:4       (u) >
    sbc  HL, DE         ; 2:15      (u) >
    sbc  HL, HL         ; 2:15      (u) >
    pop  DE             ; 1:10      (u) >})dnl
dnl
dnl
dnl ( x2 x1 -- x )
dnl unsigned ( x2 >= x1 ) --> ( x2 + 1 > x1 ) --> ( 0 > x1 - x2 - 1 ) --> carry is true
define(UGE,{
    scf                 ; 1:4       (u) >=
    sbc  HL, DE         ; 2:15      (u) >=
    sbc  HL, HL         ; 2:15      (u) >=
    pop  DE             ; 1:10      (u) >=})dnl
dnl
dnl ------------- shifts ----------------
dnl
dnl ( x u -- x)
dnl shifts x left u places
define(LSHIFT,{ifdef({USE_LSHIFT},,define({USE_LSHIFT},{}))
    call  DE_LSHIFT     ; 3:17      <<   ( x1 u -- x1<<u )
    pop   DE            ; 1:10      <<})dnl
dnl
dnl
dnl ( x u -- x)
dnl shifts x right u places
define(RSHIFT,{ifdef({USE_RSHIFT},,define({USE_RSHIFT},{}))
    call  DE_RSHIFT     ; 3:17      >>   ( x1 u -- x1>>u )
    pop   DE            ; 1:10      >>})dnl
dnl
dnl
dnl <<
dnl ( x u -- x)
dnl shifts x left u places
define(XLSHIFT1,{
    add  HL, HL         ; 1:11      xlshift1})dnl
dnl
dnl
dnl >>
dnl ( x u -- x)
dnl shifts x right u places
define(XRSHIFT1,{
    sra   H             ; 2:8       xrshift1 signed
    rr    L             ; 2:8       xrshift1})dnl
dnl
dnl
dnl
dnl u<<
dnl ( x u -- x)
dnl shifts x left u places
define(XULSHIFT1,{
    add  HL, HL         ; 1:11      xulshift1})dnl
dnl
dnl
dnl u>>
dnl ( x u -- x)
dnl shifts x right u places
define(XURSHIFT1,{
    srl   H             ; 2:8       xurshift1 unsigned
    rr    L             ; 2:8       xurshift1})dnl
dnl
dnl
dnl

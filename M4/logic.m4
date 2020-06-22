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
define(PUSH_AND,{ifelse(eval($1),{0},{
__{}    ld   HL, 0x0000     ; 3:10      $1 and},
__{}eval(($1) & 0xFF00),{0},{
__{}    ld    H, 0x00       ; 2:7       $1 and},
__{}eval(0xFF00 - (($1) & 0xFF00)),{0},,{
__{}    ld    A, high format({%-6s},$1); 2:7       $1 and
__{}    and   H             ; 1:4       $1 and
__{}    ld    H, A          ; 1:4       $1 and}){}dnl
__{}ifelse(eval($1),{0},,
__{}eval(($1) & 0x00FF),{0},{
__{}    ld    L, 0x00       ; 2:7       $1 and},
__{}eval(0xFF-(($1) & 0xFF)),{0},,{
__{}    ld    A, low format({%-7s},$1); 2:7       $1 and
__{}    and   L             ; 1:4       $1 and
__{}    ld    L, A          ; 1:4       $1 and})})dnl    
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
dnl ( x  -- x|n )
dnl x = x | n
define(PUSH_OR,{ifelse(eval(($1) & 0xFF00),{0},,
__{}eval(($1) - 0x0100),{0},{
__{}    set   0, H          ; 2:8       $1 or},
__{}eval(($1) - 0x0200),{0},{
__{}    set   1, H          ; 2:8       $1 or},
__{}eval(($1) - 0x0400),{0},{
__{}    set   2, H          ; 2:8       $1 or},
__{}eval(($1) - 0x0800),{0},{
__{}    set   3, H          ; 2:8       $1 or},
__{}eval(($1) - 0x1000),{0},{
__{}    set   4, H          ; 2:8       $1 or},
__{}eval(($1) - 0x2000),{0},{
__{}    set   5, H          ; 2:8       $1 or},
__{}eval(($1) - 0x4000),{0},{
__{}    set   6, H          ; 2:8       $1 or},
__{}eval(($1) - 0x8000),{0},{
__{}    set   7, H          ; 2:8       $1 or},
__{}{
__{}    ld    A, high format({%-6s},$1); 2:7       $1 or
__{}    or    H             ; 1:4       $1 or
__{}    ld    H, A          ; 1:4       $1 or}){}dnl
__{}ifelse(eval(($1) & 0x00FF),{0},,
__{}eval(($1) & 0xFF),{1},{
__{}    set   0, L          ; 2:8       $1 or},
__{}eval(($1) & 0xFF),{2},{
__{}    set   1, L          ; 2:8       $1 or},
__{}eval(($1) & 0xFF),{4},{
__{}    set   2, L          ; 2:8       $1 or},
__{}eval(($1) & 0xFF),{8},{
__{}    set   3, L          ; 2:8       $1 or},
__{}eval(($1) & 0xFF),{16},{
__{}    set   4, L          ; 2:8       $1 or},
__{}eval(($1) & 0xFF),{32},{
__{}    set   5, L          ; 2:8       $1 or},
__{}eval(($1) & 0xFF),{64},{
__{}    set   6, L          ; 2:8       $1 or},
__{}eval(($1) & 0xFF),{128},{
__{}    set   7, L          ; 2:8       $1 or},
__{}{
__{}    ld    A, low format({%-7s},$1); 2:7       $1 or
__{}    or    L             ; 1:4       $1 or
__{}    ld    L, A          ; 1:4       $1 or})})dnl
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
dnl ( x  -- x^n )
dnl x = x ^ n
define(PUSH_XOR,{ifelse(eval(($1) & 0xFF00),{0},,{
__{}    ld    A, high format({%-6s},$1); 2:7       $1 xor
__{}    xor   H             ; 1:4       $1 xor
__{}    ld    H, A          ; 1:4       $1 xor}){}dnl
__{}ifelse(eval(($1) & 0x00FF),{0},,{
__{}    ld    A, low format({%-7s},$1); 2:7       $1 xor
__{}    xor   L             ; 1:4       $1 xor
__{}    ld    L, A          ; 1:4       $1 xor})})dnl
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
define(WITHIN,{
    ld    A, L          ; 1:4       within
    sub   E             ; 1:4       within
    ld    C, A          ; 1:4       within
    ld    A, H          ; 1:4       within
    sbc   A, D          ; 1:4       within
    ld    B, A          ; 1:4       within c-b
    pop  HL             ; 1:10      within
    or    A             ; 1:4       within
    sbc  HL, DE         ; 2:15      within a-b
    or    A             ; 1:4       within
    sbc  HL, BC         ; 2:15      within (a-b) - (c-B) < 0
    sbc  HL, HL         ; 2:15      within
    pop  DE             ; 1:10      within ( a b c -- ((a-b) (c-b) U<) )})dnl
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
    ld    A, D          ; 1:4       D0=
    or    E             ; 1:4       D0=
    pop   DE            ; 1:10      D0=
    or    H             ; 1:4       D0=
    or    L             ; 1:4       D0=
    ld   HL, 0x0000     ; 3:10      D0=
    jr   nz, $+3        ; 2:7/12    D0=
    dec  HL             ; 1:6       D0=})dnl
dnl
dnl
dnl 0=
dnl ( x1 -- flag )
dnl if ( x1 ) flag = 0; else flag = 0xFFFF;
dnl 0 if 16-bit number not equal to zero, -1 if equal
define(_0EQ,{
    ld    A, H          ; 1:4       0=
    or    L             ; 1:4       0=
    ld   HL, 0x0000     ; 3:10      0=
    jr   nz, $+3        ; 2:7/12    0=
    dec  HL             ; 1:6       0=})dnl
dnl
dnl
dnl
dnl ------------ signed -----------------
dnl
dnl
dnl =
dnl ( x1 x2 -- x )
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
dnl <>
dnl ( x1 x2 -- x )
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
dnl ( x2 x1 -- x )
dnl signed ( x2 < x1 ) --> ( x2 - x1 < 0 ) --> carry is true
define(LT,{
    ld    A, H          ; 1:4       <
    xor   D             ; 1:4       <
    jp    p, $+7        ; 3:10      <
    rl    D             ; 2:8       < sign x2
    jr   $+5            ; 2:12      <
    ex   DE, HL         ; 1:4       <
    sbc  HL, DE         ; 2:15      <
    sbc  HL, HL         ; 2:15      <
    pop  DE             ; 1:10      <})dnl
dnl
dnl
dnl 0<
dnl ( x1 -- flag )
define(_0LT,{
    rl    H             ; 2:8       0<
    sbc  HL, HL         ; 2:15      0<})dnl
dnl
dnl
dnl <=
dnl ( x2 x1 -- x )
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
dnl ( x2 x1 -- x )
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
dnl ( x2 x1 -- x )
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
    or    A             ; 1:4       (u) <
    ex   DE, HL         ; 1:4       (u) <
    sbc  HL, DE         ; 2:15      (u) <
    sbc  HL, HL         ; 2:15      (u) <
    pop  DE             ; 1:10      (u) <})dnl
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
    call  DE_LSHIFT     ; 3:17      <<
    pop   DE            ; 1:10      <<})dnl
dnl
dnl
dnl ( x u -- x)
dnl shifts x right u places
define(RSHIFT,{ifdef({USE_RSHIFT},,define({USE_RSHIFT},{}))
    call  DE_RSHIFT     ; 3:17      >>
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

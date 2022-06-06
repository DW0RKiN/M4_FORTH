define(IF_COUNT,100)dnl
define({__},{})dnl
dnl
dnl
define({IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else{}IF_COUNT    ; 3:10      if})dnl
dnl
dnl
dnl
define({ELSE},{ifelse(ELSE_STACK,{ELSE_STACK},{
    .error {ELSE without IF!
    M4 FORTH does not support the BEGIN WHILE WHILE UNTIL ELSE THEN construction. But it supports the identical design BEGIN IF WHILE UNTIL ELSE THEN.}})
    jp   endif{}THEN_STACK       ; 3:10      else
else{}ELSE_STACK:popdef({ELSE_STACK}){}dnl
})dnl
dnl
dnl
define(THEN,{
ifelse(ELSE_STACK, THEN_STACK,{else{}ELSE_STACK  EQU $          ;           = endif
popdef({ELSE_STACK})})endif{}THEN_STACK:dnl
popdef({THEN_STACK})})dnl
dnl
dnl
dnl 0= if
dnl ( x1 -- )
define({_0EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else{}IF_COUNT    ; 3:10      0= if})dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0= if
define({DUP_0EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else{}IF_COUNT    ; 3:10      dup 0= if})dnl
dnl
dnl
dnl 0< if
dnl ( x1 -- )
define({_0LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       0< if
    ex   DE, HL         ; 1:4       0< if
    pop  DE             ; 1:10      0< if
    jp    z, else{}IF_COUNT    ; 3:10      0< if})dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0< if
define({DUP_0LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       dup 0< if
    jp    z, else{}IF_COUNT    ; 3:10      dup 0< if})dnl
dnl
dnl
dnl 0>= if
dnl ( x1 -- )
define({_0GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       0>= if
    ex   DE, HL         ; 1:4       0>= if
    pop  DE             ; 1:10      0>= if
    jp   nz, else{}IF_COUNT    ; 3:10      0>= if})dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0>= if
define({DUP_0GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       dup 0>= if
    jp   nz, else{}IF_COUNT    ; 3:10      dup 0>= if})dnl
dnl
dnl
dnl ( x1 x2 -- x1 x2 )
dnl 2dup D0= if
define({_2DUP_D0EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup D0= if
    or    L             ; 1:4       2dup D0= if
    or    D             ; 1:4       2dup D0= if
    or    E             ; 1:4       2dup D0= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup D0= if})dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup if
define({DUP_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup if
    or    L             ; 1:4       dup if
    jp    z, else{}IF_COUNT    ; 3:10      dup if})dnl
dnl
dnl
dnl over if
define({OVER_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, D          ; 1:4       over if
    or    E             ; 1:4       over if
    jp    z, else{}IF_COUNT    ; 3:10      over if})dnl
dnl
dnl -------- signed ---------
dnl
dnl
dnl dup num = if
define({DUP_PUSH_EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[14:27/54] dup $1 = if
__{}__{}    ld    A, format({%-11s},$1); 3:13      dup $1 = if
__{}__{}    xor   L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      dup $1 = if
__{}__{}    xor   H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}                        ;[5:18]     dup $1 = if   variant: zero
__{}__{}    ld    A, L          ; 1:4       dup $1 = if
__{}__{}    or    H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 = if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 = if
__{}__{}    inc   A             ; 1:4       dup $1 = if
__{}__{}    or    H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 = if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    inc   A             ; 1:4       dup $1 = if
__{}__{}    or    L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 = if   variant: -1
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    and   L             ; 1:4       dup $1 = if
__{}__{}    inc   A             ; 1:4       dup $1 = if   A = 0xFF --> 0x00 ?
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[11:18/39] dup $1 = if   variant: lo($1) = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 = if
__{}__{}    inc   A             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 = if
__{}__{}    xor   H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[11:18/39] dup $1 = if   variant: hi($1) = 255
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    inc   A             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 = if
__{}__{}    xor   L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 = if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    or    L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 = if   variant: lo($1) = zero
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 = if
__{}__{}    xor   H             ; 1:4       dup $1 = if
__{}__{}    or    L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 = if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    or    H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 = if   variant: hi($1) = zero
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 = if
__{}__{}    xor   L             ; 1:4       dup $1 = if
__{}__{}    or    H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                        ;[9:18/32]  dup $1 = if   variant: 0x0101 = 257
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    cp    L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) ^ 0x0201),{0},{dnl
__{}__{}                       ;[10:22/36]  dup $1 = if   variant: 0x0201 = 513
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    cp    L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) ^ 0x0102),{0},{dnl
__{}__{}                       ;[10:22/36]  dup $1 = if   variant: 0x0102 = 258
__{}__{}    ld    A, L          ; 1:4       dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    cp    H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                       ;[10:18/35]  dup $1 = if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    cp    L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[11:18/39]  dup $1 = if   variant: hi($1) = 1
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    ld    A, L          ; 1:4       dup $1 = if
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[11:18/39]  dup $1 = if   variant: lo($1) = 1
__{}__{}    ld    A, L          ; 1:4       dup $1 = if
__{}__{}    dec   A             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    ld    A, H          ; 1:4       dup $1 = if
__{}__{}    xor  high format({%-10s},$1); 2:7       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}{dnl
__{}__{}                       ;[12:21/42]  dup $1 = if   variant: default
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 = if
__{}__{}    xor   L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 = if
__{}__{}    xor   H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if})})dnl
dnl
dnl
dnl
dnl dup num <> if
define({DUP_PUSH_NE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[13:29/51] dup $1 <> if
__{}__{}    ld    A, format({%-11s},$1); 3:13      dup $1 <> if
__{}__{}    xor   L             ; 1:4       dup $1 <> if
__{}__{}    jr   nz, $+9        ; 2:7/12    dup $1 <> if
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      dup $1 <> if
__{}__{}    xor   H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval($1),{0},{dnl
__{}__{}                        ;[5:18]     dup $1 <> if   variant: zero
__{}__{}    ld    A, L          ; 1:4       dup $1 <> if
__{}__{}    or    H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 <> if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 <> if
__{}__{}    inc   A             ; 1:4       dup $1 <> if
__{}__{}    or    H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 <> if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       dup $1 <> if
__{}__{}    inc   A             ; 1:4       dup $1 <> if
__{}__{}    or    L             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 <> if   variant: -1
__{}__{}    ld    A, H          ; 1:4       dup $1 <> if
__{}__{}    and   L             ; 1:4       dup $1 <> if
__{}__{}    inc   A             ; 1:4       dup $1 <> if   A = 0xFF --> 0x00 ?
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[10:20/36] dup $1 <> if   variant: lo($1) = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 <> if
__{}__{}    inc   A             ; 1:4       dup $1 <> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 <> if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <> if
__{}__{}    xor   H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[10:20/36] dup $1 <> if   variant: hi($1) = 255
__{}__{}    ld    A, H          ; 1:4       dup $1 <> if
__{}__{}    inc   A             ; 1:4       dup $1 <> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 <> if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <> if
__{}__{}    xor   L             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 <> if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       dup $1 <> if
__{}__{}    dec   A             ; 1:4       dup $1 <> if
__{}__{}    or    L             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 <> if   variant: lo($1) = zero
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <> if
__{}__{}    xor   H             ; 1:4       dup $1 <> if
__{}__{}    or    L             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 <> if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       dup $1 <> if
__{}__{}    dec   A             ; 1:4       dup $1 <> if
__{}__{}    or    H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 <> if   variant: hi($1) = zero
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <> if
__{}__{}    xor   L             ; 1:4       dup $1 <> if
__{}__{}    or    H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                        ;[8:20/29]  dup $1 <> if   variant: 0x0101 = 257
__{}__{}    ld    A, H          ; 1:4       dup $1 <> if
__{}__{}    cp    L             ; 1:4       dup $1 <> if
__{}__{}    jr   nz, $+6        ; 2:7/12    dup $1 <> if
__{}__{}    dec   A             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                        ;[9:20/32]  dup $1 <> if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       dup $1 <> if
__{}__{}    cp    L             ; 1:4       dup $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    dup $1 <> if
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[10:20/36]  dup $1 <> if   variant: hi($1) = 1
__{}__{}    ld    A, H          ; 1:4       dup $1 <> if
__{}__{}    dec   A             ; 1:4       dup $1 <> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 <> if
__{}__{}    ld    A, L          ; 1:4       dup $1 <> if
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[10:20/36]  dup $1 <> if   variant: lo($1) = 1
__{}__{}    ld    A, L          ; 1:4       dup $1 <> if
__{}__{}    dec   A             ; 1:4       dup $1 <> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 <> if
__{}__{}    ld    A, H          ; 1:4       dup $1 <> if
__{}__{}    xor  high format({%-10s},$1); 2:7       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}{dnl
__{}__{}                        ;[11:23/39] dup $1 <> if   variant: default
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <> if
__{}__{}    xor   L             ; 1:4       dup $1 <> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 <> if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <> if
__{}__{}    xor   H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if})})dnl
dnl
dnl
dnl dup num < if
define({DUP_PUSH_LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[14:58]    dup $1 < if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 < if
__{}__{}    ld    A, L          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    sub   C             ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    ld    A, H          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    sbc   A, B          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    rra                 ; 1:4       dup $1 < if
__{}__{}    xor   H             ; 1:4       dup $1 < if
__{}__{}    xor   B             ; 1:4       dup $1 < if
__{}__{}    jp    p, else{}IF_COUNT    ; 3:10      dup $1 < if},
__{}{dnl
__{}__{}    ld    A, H          ; 1:4       dup $1 < if
__{}__{}    add   A, A          ; 1:4       dup $1 < if
__{}__{}__{}ifelse(eval($1),{},{dnl
__{}__{}__{}  .warning {$0}($@): The condition "$1" cannot be evaluated
__{}__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}__{}    jr c, $+11
__{}__{}__{}  else
__{}__{}__{}    jp   nc, else{}IF_COUNT
__{}__{}__{}  endif},
__{}__{}__{}eval(($1)>=0x8000 || ($1)<0),{0},{dnl
__{}__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 < if    negative HL < positive constant ---> true},
__{}__{}__{}{dnl
__{}__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 < if    positive HL < negative constant ---> false})
__{}__{}    ld    A, L          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    sub   low format({%-10s},$1); 2:7       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    ld    A, H          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 < if})})dnl
dnl
dnl
dnl dup num >= if
define({DUP_PUSH_GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[14:58]    dup $1 >= if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 >= if
__{}__{}    ld    A, L          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    sub   C             ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    ld    A, H          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    sbc   A, B          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    rra                 ; 1:4       dup $1 >= if
__{}__{}    xor   H             ; 1:4       dup $1 >= if
__{}__{}    xor   B             ; 1:4       dup $1 >= if
__{}__{}    jp    m, else{}IF_COUNT    ; 3:10      dup $1 >= if},
__{}{dnl
__{}__{}    ld    A, H          ; 1:4       dup $1 >= if
__{}__{}    add   A, A          ; 1:4       dup $1 >= if
__{}__{}__{}ifelse(eval($1),{},{dnl
__{}__{}__{}  .warning {$0}($@): The condition "$1" cannot be evaluated
__{}__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}__{}    jp c, else{}IF_COUNT
__{}__{}__{}  else
__{}__{}__{}    jr   nc, $+11
__{}__{}__{}  endif},
__{}__{}__{}eval(($1)>=0x8000 || ($1)<0),{0},{dnl
__{}__{}__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if    negative HL >= positive constant ---> false},
__{}__{}__{}{dnl
__{}__{}__{}    jr   nc, $+11       ; 2:7/12    dup $1 >= if    positive HL >= negative constant ---> true})
__{}__{}    ld    A, L          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    sub   low format({%-10s},$1); 2:7       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    ld    A, H          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if})})dnl
dnl
dnl
dnl dup num <= if
define({DUP_PUSH_LE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[14:58]    dup $1 <= if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 <= if
__{}__{}    ld    A, C          ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    sub   L             ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    ld    A, B          ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    sbc   A, H          ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    rra                 ; 1:4       dup $1 <= if
__{}__{}    xor   H             ; 1:4       dup $1 <= if
__{}__{}    xor   B             ; 1:4       dup $1 <= if
__{}__{}    jp    m, else{}IF_COUNT    ; 3:10      dup $1 <= if},
__{}{dnl
__{}__{}    ld    A, H          ; 1:4       dup $1 <= if
__{}__{}    add   A, A          ; 1:4       dup $1 <= if
__{}__{}__{}ifelse(eval($1),{},{dnl
__{}__{}__{}  .warning {$0}($@): The condition "$1" cannot be evaluated
__{}__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}__{}    jr c, $+11
__{}__{}__{}  else
__{}__{}__{}    jp   nc, else{}IF_COUNT
__{}__{}__{}  endif},
__{}__{}__{}eval(($1)>=0x8000 || ($1)<0),{0},{dnl
__{}__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 <= if    negative HL <= positive constant ---> true},
__{}__{}__{}{dnl
__{}__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 <= if    positive HL <= negative constant ---> false})
__{}__{}    ld    A, ifelse(index({$1},{(}),{0},{format({%-11s},$1); 3:13},{low format({%-7s},$1); 2:7 })      dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    sub   L             ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    ld    A, ifelse(index({$1},{(}),{0},{(format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13},{high format({%-6s},$1); 2:7 })      dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    sbc   A, H          ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 <= if})})dnl
dnl
dnl
dnl dup num > if
define({DUP_PUSH_GT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[14:58]    dup $1 > if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 > if
__{}__{}    ld    A, C          ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    sub   L             ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    ld    A, B          ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    sbc   A, H          ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    rra                 ; 1:4       dup $1 > if
__{}__{}    xor   H             ; 1:4       dup $1 > if
__{}__{}    xor   B             ; 1:4       dup $1 > if
__{}__{}    jp    p, else{}IF_COUNT    ; 3:10      dup $1 > if},
__{}{dnl
__{}__{}    ld    A, H          ; 1:4       dup $1 > if
__{}__{}    add   A, A          ; 1:4       dup $1 > if
__{}__{}__{}ifelse(eval($1),{},{dnl
__{}__{}__{}  .warning {$0}($@): The condition "$1" cannot be evaluated
__{}__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}__{}    jp c, else{}IF_COUNT
__{}__{}__{}  else
__{}__{}__{}    jr   nc, $+11
__{}__{}__{}  endif},
__{}__{}__{}eval(($1)>=0x8000 || ($1)<0),{0},{dnl
__{}__{}__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 > if    negative HL > positive constant ---> false},
__{}__{}__{}{dnl
__{}__{}__{}    jr   nc, $+11       ; 2:7/12    dup $1 > if    positive HL > negative constant ---> true})
__{}__{}    ld    A, ifelse(index({$1},{(}),{0},{format({%-11s},$1); 3:13},{low format({%-7s},$1); 2:7 })      dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    sub   L             ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    ld    A, ifelse(index({$1},{(}),{0},{(format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13},{high format({%-6s},$1); 2:7 })      dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    sbc   A, H          ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 > if})})dnl
dnl
dnl -------- unsigned ---------
dnl
dnl dup unum u= if
define({DUP_PUSH_UEQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[14:27/54] dup $1 u= if
__{}__{}    ld    A, format({%-11s},$1); 3:13      dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}                        ;[5:18]     dup $1 u= if   variant: zero
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if
__{}__{}    or    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: -1
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    and   L             ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if   A = 0xFF --> 0x00 ?
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[11:18/39] dup $1 u= if   variant: lo($1) = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[11:18/39] dup $1 u= if   variant: hi($1) = 255
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    or    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u= if   variant: lo($1) = zero
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    or    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u= if   variant: hi($1) = zero
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                        ;[9:18/32]  dup $1 u= if   variant: 0x0101 = 257
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    cp    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 0x0201),{0},{dnl
__{}__{}                       ;[10:22/36]  dup $1 u= if   variant: 0x0201 = 513
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    cp    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 0x0102),{0},{dnl
__{}__{}                       ;[10:22/36]  dup $1 u= if   variant: 0x0102 = 258
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    cp    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                       ;[10:18/35]  dup $1 u= if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    cp    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[11:18/39]  dup $1 u= if   variant: hi($1) = 1
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[11:18/39]  dup $1 u= if   variant: lo($1) = 1
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    xor  high format({%-10s},$1); 2:7       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}{dnl
__{}__{}                       ;[12:21/42]  dup $1 u= if   variant: default
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if})})dnl
dnl
dnl
dnl dup unum u<> if
define({DUP_PUSH_UNE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[13:29/51] dup $1 u<> if
__{}__{}    ld    A, format({%-11s},$1); 3:13      dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+9        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval($1),{0},{dnl
__{}__{}                        ;[5:18]     dup $1 u<> if   variant: zero
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if
__{}__{}    or    L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: -1
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    and   L             ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if   A = 0xFF --> 0x00 ?
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[10:20/36] dup $1 u<> if   variant: lo($1) = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[10:20/36] dup $1 u<> if   variant: hi($1) = 255
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    or    L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u<> if   variant: lo($1) = zero
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    or    L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u<> if   variant: hi($1) = zero
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                        ;[8:20/29]  dup $1 u<> if   variant: 0x0101 = 257
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    cp    L             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+6        ; 2:7/12    dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                        ;[9:20/32]  dup $1 u<> if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    cp    L             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+7        ; 2:7/12    dup $1 u<> if
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[10:20/36]  dup $1 u<> if   variant: hi($1) = 1
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[10:20/36]  dup $1 u<> if   variant: lo($1) = 1
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    xor  high format({%-10s},$1); 2:7       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}{dnl
__{}__{}                        ;[11:23/39] dup $1 u<> if   variant: default
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if})})dnl
dnl
dnl
dnl dup 123 u< if
define({DUP_PUSH_ULT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, L          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   C             ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, B          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 u< if},
__{}{dnl
__{}    ld    A, L          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 u< if})})dnl
dnl
dnl
dnl dup 123 u>= if
define({DUP_PUSH_UGE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, L          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   C             ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, B          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 u>= if},
__{}{dnl
__{}    ld    A, L          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 u>= if})})dnl
dnl
dnl
dnl dup 123 u<= if
define({DUP_PUSH_ULE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}    ld    A, ifelse(index({$1},{(}),{0},{format({%-11s},$1); 3:13},{low format({%-7s},$1); 2:7 })      dup $1 u<= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sub   L             ; 1:4       dup $1 u<= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    ld    A, ifelse(index({$1},{(}),{0},{(format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13},{high format({%-6s},$1); 2:7 })      dup $1 u<= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 u<= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 u<= if})dnl
dnl
dnl
dnl dup 123 u> if
define({DUP_PUSH_UGT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}    ld    A, ifelse(index({$1},{(}),{0},{format({%-11s},$1); 3:13},{low format({%-7s},$1); 2:7 })      dup $1 u> if    HL>$1 --> 0>$1-HL --> carry if true
__{}    sub   L             ; 1:4       dup $1 u> if    HL>$1 --> 0>$1-HL --> carry if true
__{}    ld    A, ifelse(index({$1},{(}),{0},{(format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13},{high format({%-6s},$1); 2:7 })      dup $1 u> if    HL>$1 --> 0>$1-HL --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 u> if    HL>$1 --> 0>$1-HL --> carry if true
__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 u> if})dnl
dnl
dnl
dnl
dnl ------ 2dup ucond if ---------
dnl
define({_2DUP_UEQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u= if
    sub   L             ; 1:4       2dup u= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup u= if
    ld    A, D          ; 1:4       2dup u= if
    sub   H             ; 1:4       2dup u= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup u= if})dnl
dnl
dnl
define({_2DUP_UNE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u<> if
    sub   L             ; 1:4       2dup u<> if
    jr   nz, $+7        ; 2:7/12    2dup u<> if
    ld    A, D          ; 1:4       2dup u<> if
    sbc   A, H          ; 1:4       2dup u<> if
    jp    z, else{}IF_COUNT    ; 3:10      2dup u<> if})dnl
dnl
dnl
define({_2DUP_ULT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      2dup u< if})dnl
dnl
dnl
define({_2DUP_UGE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      2dup u>= if})dnl
dnl
dnl
define({_2DUP_ULE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      2dup u<= if})dnl
dnl
dnl
define({_2DUP_UGT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      2dup u> if})dnl
dnl
dnl
dnl ------ 2dup scond if ---------
dnl
dnl 2dup = if
define({_2DUP_EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup = if})dnl
dnl
dnl
dnl 2dup <> if
define({_2DUP_NE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup <> if
    sub   L             ; 1:4       2dup <> if
    jr   nz, $+7        ; 2:7/12    2dup <> if
    ld    A, D          ; 1:4       2dup <> if
    sub   H             ; 1:4       2dup <> if
    jp    z, else{}IF_COUNT    ; 3:10      2dup <> if})dnl
dnl
dnl
dnl 2dup < if
define({_2DUP_LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    xor   H             ; 1:4       2dup < if
    jp    p, else{}IF_COUNT    ; 3:10      2dup < if})dnl
dnl
dnl
dnl 2dup >= if
define({_2DUP_GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= if
    xor   D             ; 1:4       2dup >= if
    xor   H             ; 1:4       2dup >= if
    jp    m, else{}IF_COUNT    ; 3:10      2dup >= if})dnl
dnl
dnl
dnl 2dup <= if
define({_2DUP_LE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= if
    xor   D             ; 1:4       2dup <= if
    xor   H             ; 1:4       2dup <= if
    jp    m, else{}IF_COUNT    ; 3:10      2dup <= if})dnl
dnl
dnl
dnl 2dup > if
define({_2DUP_GT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > if
    xor   D             ; 1:4       2dup > if
    xor   H             ; 1:4       2dup > if
    jp    p, else{}IF_COUNT    ; 3:10      2dup > if})dnl
dnl
dnl
dnl ------ ucond if ---------
dnl
define({UEQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    or    A             ; 1:4       u= if
    sbc  HL, DE         ; 2:15      u= if
    pop  HL             ; 1:10      u= if
    pop  DE             ; 1:10      u= if
    jp   nz, else{}IF_COUNT    ; 3:10      u= if})dnl
dnl
dnl
define({UNE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    or    A             ; 1:4       u<> if
    sbc  HL, DE         ; 2:15      u<> if
    pop  HL             ; 1:10      u<> if
    pop  DE             ; 1:10      u<> if
    jp    z, else{}IF_COUNT    ; 3:10      u<> if})dnl
dnl
dnl
define({ULT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< if
    pop  DE             ; 1:10      u< if
    jp   nc, else{}IF_COUNT    ; 3:10      u< if})dnl
dnl
dnl
define({UGE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= if
    pop  DE             ; 1:10      u>= if
    jp    c, else{}IF_COUNT    ; 3:10      u>= if})dnl
dnl
dnl
define({ULE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= if
    pop  DE             ; 1:10      u<= if
    jp    c, else{}IF_COUNT    ; 3:10      u<= if})dnl
dnl
dnl
define({UGT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> if
    pop  DE             ; 1:10      u> if
    jp   nc, else{}IF_COUNT    ; 3:10      u> if})dnl
dnl
dnl
dnl ------ scond if ---------
dnl
dnl = if
define({EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    or    A             ; 1:4       = if
    sbc  HL, DE         ; 2:15      = if
    pop  HL             ; 1:10      = if
    pop  DE             ; 1:10      = if
    jp   nz, else{}IF_COUNT    ; 3:10      = if})dnl
dnl
dnl
dnl <> if
define({NE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    or    A             ; 1:4       <> if
    sbc  HL, DE         ; 2:15      <> if
    pop  HL             ; 1:10      <> if
    pop  DE             ; 1:10      <> if
    jp    z, else{}IF_COUNT    ; 3:10      <> if})dnl
dnl
dnl
dnl < if
define({LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       < if
    xor   H             ; 1:4       < if
    xor   D             ; 1:4       < if
    pop  HL             ; 1:10      < if
    pop  DE             ; 1:10      < if
    jp    p, else{}IF_COUNT    ; 3:10      < if})dnl
dnl
dnl
dnl >= if
define({GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       >= if
    xor   H             ; 1:4       >= if
    xor   D             ; 1:4       >= if
    pop  HL             ; 1:10      >= if
    pop  DE             ; 1:10      >= if
    jp    m, else{}IF_COUNT    ; 3:10      >= if})dnl
dnl
dnl
dnl <= if
define({LE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    rra                 ; 1:4       <= if
    xor   H             ; 1:4       <= if
    xor   D             ; 1:4       <= if
    pop  HL             ; 1:10      <= if
    pop  DE             ; 1:10      <= if
    jp    m, else{}IF_COUNT    ; 3:10      <= if})dnl
dnl
dnl
dnl > if
define({GT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    rra                 ; 1:4       > if
    xor   H             ; 1:4       > if
    xor   D             ; 1:4       > if
    pop  HL             ; 1:10      > if
    pop  DE             ; 1:10      > if
    jp    p, else{}IF_COUNT    ; 3:10      > if})dnl
dnl
dnl
dnl ------ push scond if ---------
dnl
dnl num = if
define({PUSH_EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[12:63]    $1 = if
__{}    ld   BC, format({%-11s},$1); 4:20      $1 = if
__{}    or    A             ; 1:4       $1 = if
__{}    sbc  HL, BC         ; 2:15      $1 = if
__{}    ex   DE, HL         ; 1:4       $1 = if
__{}    pop  DE             ; 1:10      $1 = if
__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}                        ;[7:32]     $1 = if   variant: zero
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    inc   A             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    inc   A             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: -1
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    and   L             ; 1:4       $1 = if
__{}__{}    inc   A             ; 1:4       $1 = if   A = 0xFF --> 0x00 ?
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[10:43] $1 = if   variant: lo($1) = 255
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 = if
__{}__{}    xor   H             ; 1:4       $1 = if
__{}__{}    inc   L             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[10:43] $1 = if   variant: hi($1) = 255
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 = if
__{}__{}    xor   L             ; 1:4       $1 = if
__{}__{}    inc   H             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    dec   A             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[9:39]     $1 = if   variant: lo($1) = zero
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 = if
__{}__{}    xor   H             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    dec   A             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[9:39]     $1 = if   variant: hi($1) = zero
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 = if
__{}__{}    xor   L             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                        ;[9:40]     $1 = if   variant: 0x0101 = 257
__{}__{}    dec   H             ; 1:4       $1 = if
__{}__{}    dec   L             ; 1:4       $1 = if
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                       ;[12:32/49]  $1 = if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    cp    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if
__{}__{}    xor  low format({%-11s},$1); 2:7       $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[10:43]     $1 = if   variant: hi($1) = 1
__{}__{}    dec   H             ; 1:4       $1 = if
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    xor  low format({%-11s},$1); 2:7       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[10:43]     $1 = if   variant: lo($1) = 1
__{}__{}    dec   L             ; 1:4       $1 = if
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    xor  high format({%-10s},$1); 2:7       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}{dnl
__{}__{}                        ;[11:53]    $1 = if   variant: default
__{}__{}    ld   BC, format({%-11s},$1); 3:10      $1 = if
__{}__{}    or    A             ; 1:4       $1 = if
__{}__{}    sbc  HL, BC         ; 2:15      $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if})})dnl
dnl
dnl
dnl num <> if
define({PUSH_NE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}__{}                        ;[12:63] $1 <> if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 <> if
__{}__{}    or    A             ; 1:4       $1 <> if
__{}__{}    sbc  HL, DE         ; 2:15      $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval($1),{0},{dnl
__{}__{}                        ;[7:32]     $1 <> if   variant: zero
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    inc   A             ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    inc   A             ; 1:4       $1 <> if
__{}__{}    or    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: -1
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    and   L             ; 1:4       $1 <> if
__{}__{}    inc   A             ; 1:4       $1 <> if   A = 0xFF --> 0x00 ?
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[11:34/46] $1 <> if   variant: lo($1) = 255
__{}__{}    inc   L             ; 1:4       $1 <> if
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor  high format({%-10s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[11:34/46] $1 <> if   variant: hi($1) = 255
__{}__{}    inc   H             ; 1:4       $1 <> if
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor  low format({%-10s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    dec   A             ; 1:4       $1 <> if
__{}__{}    or    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[9:39]     $1 <> if   variant: lo($1) = zero
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 <> if
__{}__{}    xor   H             ; 1:4       $1 <> if
__{}__{}    or    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    dec   A             ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[9:39]     $1 <> if   variant: hi($1) = zero
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 <> if
__{}__{}    xor   L             ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                       ;[10:34/43]  $1 <> if   variant: 0x0101 = 257
__{}__{}    dec   L             ; 1:4       $1 <> if
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+6        ; 2:7/12    $1 <> if
__{}__{}    dec   A             ; 1:4       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                       ;[11:34/46]  $1 <> if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    cp    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor   low format({%-10s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[11:34/46]  $1 <> if   variant: hi($1) = 1
__{}__{}    dec   H             ; 1:4       $1 <> if
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor  low format({%-11s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[11:34/46]  $1 <> if   variant: lo($1) = 1
__{}__{}    dec   L             ; 1:4       $1 <> if
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor  high format({%-10s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}{dnl
__{}__{}                        ;[13:41/53] $1 <> if   variant: default
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 <> if
__{}__{}    xor   L             ; 1:4       $1 <> if
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor  high format({%-10s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if})})dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 8bit
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl dup char = if
define({DUP_PUSH_CEQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}    ld    A, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:13},{2:7 })      dup $1 = if
__{}    xor   L             ; 1:4       dup $1 = if
__{}    or    H             ; 1:4       dup $1 = if
__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if})dnl
dnl
dnl
dnl
dnl dup char <> if
define({DUP_PUSH_CNE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}    ld    A, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:13},{2:7 })      dup $1 <> if
__{}    xor   L             ; 1:4       dup $1 <> if
__{}    or    H             ; 1:4       dup $1 <> if
__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if})dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 32bit
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl 0. D= if
dnl D0= if
dnl ( x1 x2 -- )
define({D0EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       D0= if
    or    L             ; 1:4       D0= if
    or    D             ; 1:4       D0= if
    or    E             ; 1:4       D0= if
    pop  HL             ; 1:10      D0= if
    pop  DE             ; 1:10      D0= if
    jp   nz, else{}IF_COUNT    ; 3:10      D0= if})dnl
dnl
dnl
dnl
dnl 2dup 0. D= if
dnl 2dup D0= if
dnl ( x1 x2 -- )
define({_2DUP_D0EQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup D0= if
    or    L             ; 1:4       2dup D0= if
    or    D             ; 1:4       2dup D0= if
    or    E             ; 1:4       2dup D0= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup D0= if})dnl
dnl
dnl
dnl
dnl
dnl 0. D<  if
dnl D0< if
dnl ( x1 -- )
define({D0LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, D          ; 2:8       D0< if
    pop  HL             ; 1:10      D0< if
    pop  DE             ; 1:10      D0< if
    jp    z, else{}IF_COUNT    ; 3:10      D0< if})dnl
dnl
dnl
dnl
dnl
dnl 2dup 0. D<  if
dnl 2dup D0< if
dnl ( x1 -- )
define({_2DUP_D0LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, D          ; 2:8       2dup D0< if
    jp    z, else{}IF_COUNT    ; 3:10      2dup D0< if})dnl
dnl
dnl
dnl
dnl
dnl D= if
define({DEQ_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse(TYP_DOUBLE,{fast},{
                       ;[15:88]     D= if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # fast version can be changed with "define({TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D= if   lo_2
    ld    A, C          ; 1:4       D= if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    sub   L             ; 1:4       D= if
    ld    A, B          ; 1:4       D= if
    sbc   A, H          ; 1:4       D= if
    pop  HL             ; 1:10      D= if   hi_2
    jr   nz, $+4        ; 2:7/12    D= if
    sbc  HL, DE         ; 2:15      D= if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= if
    pop  DE             ; 1:10      D= if
    jp   nz, else{}IF_COUNT    ; 3:10      D= if},
{
                       ;[14:91]     D= if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # default version can be changed with "define({TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D= if   lo_2
    or    A             ; 1:4       D= if
    sbc  HL, BC         ; 2:15      D= if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      D= if   hi_2
    jr   nz, $+4        ; 2:7/12    D= if
    sbc  HL, DE         ; 2:15      D= if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= if
    pop  DE             ; 1:10      D= if
    jp   nz, else{}IF_COUNT    ; 3:10      D= if})})dnl
dnl
dnl
dnl
dnl D<> if
define({DNE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse(TYP_DOUBLE,{fast},{
                       ;[15:88]     D<> if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # fast version can be changed with "define({TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<> if   lo_2
    ld    A, C          ; 1:4       D<> if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    sub   L             ; 1:4       D<> if
    ld    A, B          ; 1:4       D<> if
    sbc   A, H          ; 1:4       D<> if
    pop  HL             ; 1:10      D<> if   hi_2
    jr   nz, $+4        ; 2:7/12    D<> if
    sbc  HL, DE         ; 2:15      D<> if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> if
    pop  DE             ; 1:10      D<> if
    jp    z, else{}IF_COUNT    ; 3:10      D<> if},
{
                       ;[14:91]     D<> if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # default version can be changed with "define({TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D<> if   lo_2
    or    A             ; 1:4       D<> if
    sbc  HL, BC         ; 2:15      D<> if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      D<> if   hi_2
    jr   nz, $+4        ; 2:7/12    D<> if
    sbc  HL, DE         ; 2:15      D<> if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> if
    pop  DE             ; 1:10      D<> if
    jp    z, else{}IF_COUNT    ; 3:10      D<> if})})dnl
dnl
dnl
dnl
dnl D< if
define({DLT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
                       ;[18:94]     D< if   ( hi_2 lo_2 . hi_1 lo_1 -- )
    pop  BC             ; 1:10      D< if   lo_2
    ld    A, C          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      D< if   hi_2
    ld    A, L          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    rra                 ; 1:4       D< if   carry --> sign
    xor   H             ; 1:4       D< if
    xor   D             ; 1:4       D< if
    pop  HL             ; 1:10      D< if
    pop  DE             ; 1:10      D< if
    jp   nc, else{}IF_COUNT    ; 3:10      D< if})dnl
dnl
dnl
dnl
dnl uD< if
define({UDLT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
                       ;[13:81]     uD< if   ( hi_2 lo_2 . hi_1 lo_1 -- )
    pop  BC             ; 1:10      uD< if   lo_2
    ld    A, C          ; 1:4       uD< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       uD< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       uD< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       uD< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      uD< if   hi_2
    sbc  HL, DE         ; 2:15      uD< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    pop  HL             ; 1:10      uD< if
    pop  DE             ; 1:10      uD< if
    jp   nc, else{}IF_COUNT    ; 3:10      UD< if})dnl
dnl
dnl
dnl
dnl D>= if
define({DGE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
                       ;[18:94]     D>= if   ( hi_2 lo_2 . hi_1 lo_1 -- )
    pop  BC             ; 1:10      D>= if   lo_2
    ld    A, C          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sub   L             ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ld    A, B          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    pop  HL             ; 1:10      D>= if   hi_2
    ld    A, L          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, E          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    ld    A, H          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, D          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    rra                 ; 1:4       D>= if   carry --> sign
    xor   H             ; 1:4       D>= if
    xor   D             ; 1:4       D>= if
    pop  HL             ; 1:10      D>= if
    pop  DE             ; 1:10      D>= if
    jp    c, else{}IF_COUNT    ; 3:10      D>= if})dnl
dnl
dnl
dnl
dnl uD>= if
define({UDGE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
                       ;[13:81]     uD>= if   ( hi_2 lo_2 . hi_1 lo_1 -- )
    pop  BC             ; 1:10      uD>= if   lo_2
    ld    A, C          ; 1:4       uD>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sub   L             ; 1:4       uD>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ld    A, B          ; 1:4       uD>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       uD>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    pop  HL             ; 1:10      uD>= if   hi_2
    sbc  HL, DE         ; 2:15      uD>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    pop  HL             ; 1:10      uD>= if
    pop  DE             ; 1:10      uD>= if
    jp    c, else{}IF_COUNT    ; 3:10      uD>= if})dnl
dnl
dnl
dnl
dnl D<= if
define({DLE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse(TYP_DOUBLE,{fast},{
                       ;[18:94]     D<= if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # fast version can be changed with "define({TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<= if   lo_2
    ld    A, L          ; 1:4       D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sub   C             ; 1:4       D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ld    A, H          ; 1:4       D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sbc   A, B          ; 1:4       D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      D<= if   hi_2
    ld    A, E          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, C          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    ld    A, D          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, B          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    rra                 ; 1:4       D<= if   carry --> sign
    xor   B             ; 1:4       D<= if
    xor   D             ; 1:4       D<= if
    pop  HL             ; 1:10      D<= if
    pop  DE             ; 1:10      D<= if
    jp    c, else{}IF_COUNT    ; 3:10      D<= if},
{
                       ;[18:94]     D<= if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # default version can be changed with "define({TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D<= if   lo_2
    or    A             ; 1:4       D<= if
    sbc  HL, BC         ; 2:15      D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      D<= if   hi_2
    ld    A, E          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, C          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    ld    A, D          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, B          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    rra                 ; 1:4       D<= if   carry --> sign
    xor   B             ; 1:4       D<= if
    xor   D             ; 1:4       D<= if
    pop  HL             ; 1:10      D<= if
    pop  DE             ; 1:10      D<= if
    jp    c, else{}IF_COUNT    ; 3:10      D<= if})})dnl
dnl
dnl
dnl
dnl uD<= if
define({UDLE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse(TYP_DOUBLE,{fast},{
                       ;[15:82]     uD<= if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # fast version can be changed with "define({TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      uD<= if   lo_2
    ld    A, L          ; 1:4       uD<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sub   C             ; 1:4       uD<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ld    A, H          ; 1:4       uD<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sbc   A, B          ; 1:4       uD<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      uD<= if   hi_2
    ld    A, E          ; 1:4       uD<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, C          ; 1:4       uD<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    ld    A, D          ; 1:4       uD<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, B          ; 1:4       uD<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    pop  HL             ; 1:10      uD<= if
    pop  DE             ; 1:10      uD<= if
    jp    c, else{}IF_COUNT    ; 3:10      uD<= if},
{
                       ;[13:88]     uD<= if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # default version can be changed with "define({TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      uD<= if   lo_2
    or    A             ; 1:4       uD<= if
    sbc  HL, BC         ; 2:15      uD<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      uD<= if   hi_2
    ex   DE, HL         ; 1:4       uD<= if
    sbc  HL, BC         ; 2:15      uD<= if   hi_2<=hi_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  HL             ; 1:10      uD<= if
    pop  DE             ; 1:10      uD<= if
    jp    c, else{}IF_COUNT    ; 3:10      uD<= if})})dnl
dnl
dnl
dnl
dnl D> if
define({DGT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse(TYP_DOUBLE,{fast},{
                       ;[18:94]     D> if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # fast version can be changed with "define({TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D> if   lo_2
    ld    A, L          ; 1:4       D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      D> if   hi_2
    ld    A, E          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    rra                 ; 1:4       D> if   carry --> sign
    xor   B             ; 1:4       D> if
    xor   D             ; 1:4       D> if
    pop  HL             ; 1:10      D> if
    pop  DE             ; 1:10      D> if
    jp   nc, else{}IF_COUNT    ; 3:10      D> if},
{
                       ;[17:97]     D> if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # default version can be changed with "define({TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D> if   lo_2
    or    A             ; 1:4       D> if
    sbc  HL, BC         ; 2:15      D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      D> if   hi_2
    ld    A, E          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    rra                 ; 1:4       D> if   carry --> sign
    xor   B             ; 1:4       D> if
    xor   D             ; 1:4       D> if
    pop  HL             ; 1:10      D> if
    pop  DE             ; 1:10      D> if
    jp   nc, else{}IF_COUNT    ; 3:10      D> if})})dnl
dnl
dnl
dnl
dnl UD> if
define({UDGT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT){}ifelse(TYP_DOUBLE,{fast},{
                       ;[15:82]     uD> if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # fast version can be changed with "define({TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      uD> if   lo_2
    ld    A, L          ; 1:4       uD> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       uD> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       uD> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       uD> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      uD> if   hi_2
    ld    A, E          ; 1:4       uD> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       uD> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       uD> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       uD> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    pop  HL             ; 1:10      uD> if
    pop  DE             ; 1:10      uD> if
    jp   nc, else{}IF_COUNT    ; 3:10      UD> if},
{
                       ;[13:88]     uD> if   ( hi_2 lo_2 . hi_1 lo_1 -- )   # default version can be changed with "define({TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      uD> if   lo_2
    or    A             ; 1:4       uD> if
    sbc  HL, BC         ; 2:15      uD> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      uD> if   hi_2
    ex   DE, HL         ; 1:4       uD> if
    sbc  HL, BC         ; 2:15      uD> if   hi_2>hi_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  HL             ; 1:10      uD> if
    pop  DE             ; 1:10      uD> if
    jp   nc, else{}IF_COUNT    ; 3:10      UD> if})})dnl
dnl
dnl

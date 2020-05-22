define(IF_COUNT,100)dnl
dnl
dnl
define(IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else{}IF_COUNT}    ; 3:10      if)dnl
dnl
dnl
dnl if not zero
define(IFNZ,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    jp    z, else{}IF_COUNT    ; 3:10      ifnz})dnl
dnl
dnl
dnl if zero
define(IFZ,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    jp   nz, else{}IF_COUNT    ; 3:10      ifz})dnl
dnl
dnl
define({ELSE},{
    jp   endif{}THEN_STACK       ; 3:10      else
else{}ELSE_STACK:popdef({ELSE_STACK})})dnl
dnl
dnl
define(THEN,{
ifelse(ELSE_STACK, THEN_STACK,{else{}ELSE_STACK  EQU $          ;           = endif
popdef({ELSE_STACK})})endif{}THEN_STACK:dnl
popdef({THEN_STACK})})dnl
dnl
dnl -------- signed ---------
dnl
define({DUP_PUSH_LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 < if
    add   A, A          ; 1:4       dup $1 < if{}ifelse(eval($1>=0x8000 || $1<0),{0},{
    jr    c, $+11       ; 2:7/12    dup $1 < if    positive constant},{
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 < if    negative constant})

    ld    A, L          ; 1:4       dup $1 < if    (HL<$1) --> (HL-$1<0) --> carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 < if    (HL<$1) --> (HL-$1<0) --> carry if true
    ld    A, H          ; 1:4       dup $1 < if    (HL<$1) --> (HL-$1<0) --> carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 < if    (HL<$1) --> (HL-$1<0) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 < if})dnl
dnl    
dnl
define({DUP_PUSH_LE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 <= if
    add   A, A          ; 1:4       dup $1 <= if{}ifelse(eval($1>=0x8000 || $1<0),{0},{
    jr    c, $+12       ; 2:7/12    dup $1 <= if    positive constant
    scf                 ; 1:4       dup $1 <= if},{
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 <= if    negative constant})

    ld    A, L          ; 1:4       dup $1 <= if    (HL<=$1) --> (HL-$1-1<0) --> carry if true
    sbc   A, low format({%-7s},$1); 2:7       dup $1 <= if    (HL<=$1) --> (HL-$1-1<0) --> carry if true
    ld    A, H          ; 1:4       dup $1 <= if    (HL<=$1) --> (HL-$1-1<0) --> carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 <= if    (HL<=$1) --> (HL-$1-1<0) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 <= if})dnl
dnl    
dnl
define({DUP_PUSH_GT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 > if
    add   A, A          ; 1:4       dup $1 > if{}ifelse(eval($1>=0x8000 || $1<0),{0},{
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 > if    positive constant},{
    jr   nc, $+11       ; 2:7/12    dup $1 > if    negative constant})

    ld    A, low format({%-7s},$1); 2:7       dup $1 > if    (HL>$1) --> (0>$1-HL) --> carry if true
    sub   L             ; 1:4       dup $1 > if    (HL>$1) --> (0>$1-HL) --> carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 > if    (HL>$1) --> (0>$1-HL) --> carry if true
    sbc   A, H          ; 1:4       dup $1 > if    (HL>$1) --> (0>$1-HL) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 > if})dnl
dnl    
dnl
define({DUP_PUSH_GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 >= if
    add   A, A          ; 1:4       dup $1 >= if{}ifelse(eval($1>=0x8000 || $1<0),{0},{
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if    positive constant
    scf                 ; 1:4       dup $1 >= if},{
    jr   nc, $+11       ; 2:7/12    dup $1 >= if    negative constant})

    ld    A, low format({%-7s},$1); 2:7       dup $1 >= if    (HL>=$1) --> (0>$1-HL-1) --> carry if true
    sbc   L             ; 1:4       dup $1 >= if    (HL>=$1) --> (0>$1-HL-1) --> carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 >= if    (HL>=$1) --> (0>$1-HL-1) --> carry if true
    sbc   A, H          ; 1:4       dup $1 >= if    (HL>=$1) --> (0>$1-HL-1) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 >= if})dnl
dnl    
dnl -------- unsigned ---------
dnl
define({DUP_PUSH_ULT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       dup $1 (u)< if    (HL<$1) --> (HL-$1<0) --> carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 (u)< if    (HL<$1) --> (HL-$1<0) --> carry if true
    ld    A, H          ; 1:4       dup $1 (u)< if    (HL<$1) --> (HL-$1<0) --> carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 (u)< if    (HL<$1) --> (HL-$1<0) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 (u)< if})dnl
dnl    
dnl
define({DUP_PUSH_ULE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    scf                 ; 1:4       dup $1 (u)<= if
    ld    A, L          ; 1:4       dup $1 (u)<= if    (HL<=$1) --> (HL-$1-1<0) --> carry if true
    sbc   low format({%-10s},$1); 2:7       dup $1 (u)<= if    (HL<=$1) --> (HL-$1-1<0) --> carry if true
    ld    A, H          ; 1:4       dup $1 (u)<= if    (HL<=$1) --> (HL-$1-1<0) --> carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 (u)<= if    (HL<=$1) --> (HL-$1-1<0) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 (u)<= if})dnl
dnl    
dnl
define({DUP_PUSH_UGT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, low format({%-7s},$1); 2:7       dup $1 (u)> if    (HL>$1) --> (0>$1-HL) --> carry if true
    sub   L             ; 1:4       dup $1 (u)> if    (HL>$1) --> (0>$1-HL) --> carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 (u)> if    (HL>$1) --> (0>$1-HL) --> carry if true
    sbc   A, H          ; 1:4       dup $1 (u)> if    (HL>$1) --> (0>$1-HL) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 (u)> if})dnl
dnl    
dnl
define({DUP_PUSH_UGE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    scf                 ; 1:4       dup $1 (u)>= if
    ld    A, low format({%-7s},$1); 2:7       dup $1 (u)>= if    (HL>=$1) --> (0>$1-HL-1) --> carry if true
    sbc   L             ; 1:4       dup $1 (u)>= if    (HL>=$1) --> (0>$1-HL-1) --> carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 (u)>= if    (HL>=$1) --> (0>$1-HL-1) --> carry if true
    sbc   A, H          ; 1:4       dup $1 (u)>= if    (HL>=$1) --> (0>$1-HL-1) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 (u)>= if})dnl
dnl    
dnl

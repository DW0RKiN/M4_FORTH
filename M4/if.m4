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
dnl
define(DUP_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup if
    or    L             ; 1:4       dup if
    jp    z, else{}IF_COUNT}    ; 3:10      if)dnl
dnl
dnl
define(OVER_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, D          ; 1:4       over if
    or    E             ; 1:4       over if
    jp    z, else{}IF_COUNT}    ; 3:10      if)dnl
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
define({DUP_PUSH_GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 >= if
    add   A, A          ; 1:4       dup $1 >= if{}ifelse(eval($1>=0x8000 || $1<0),{0},{
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if    positive constant},{
    jr   nc, $+11       ; 2:7/12    dup $1 >= if    negative constant})

    ld    A, L          ; 1:4       dup $1 >= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 >= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    ld    A, H          ; 1:4       dup $1 >= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if})dnl
dnl
dnl
define({DUP_PUSH_LE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 <= if
    add   A, A          ; 1:4       dup $1 <= if{}ifelse(eval($1>=0x8000 || $1<0),{0},{
    jr    c, $+11       ; 2:7/12    dup $1 <= if    positive constant},{
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 <= if    negative constant})

    ld    A, low format({%-7s},$1); 2:7       dup $1 <= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    sub   L             ; 1:4       dup $1 <= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 <= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    sbc   A, H          ; 1:4       dup $1 <= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 <= if})dnl
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
define({DUP_PUSH_UGE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       dup $1 (u)>= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 (u)>= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    ld    A, H          ; 1:4       dup $1 (u)>= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 (u)>= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 (u)>= if})dnl
dnl    
dnl
define({DUP_PUSH_ULE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, low format({%-7s},$1); 2:7       dup $1 (u)<= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    sub   L             ; 1:4       dup $1 (u)<= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 (u)<= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    sbc   A, H          ; 1:4       dup $1 (u)<= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 (u)<= if})dnl
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
dnl    
dnl ------ 2dup ucond if ---------
dnl
define({_2DUP_ULT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      2dup u< if})dnl
dnl    
dnl
define({_2DUP_UGE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       2dup u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       2dup u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      2dup u>= if})dnl
dnl    
dnl
define({_2DUP_ULE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sub   E             ; 1:4       2dup u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    ld    A, H          ; 1:4       2dup u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      2dup u<= if})dnl
dnl    
dnl
define({_2DUP_UGT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    sub   E             ; 1:4       2dup u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    ld    A, H          ; 1:4       2dup u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      2dup u> if})dnl
dnl    
dnl

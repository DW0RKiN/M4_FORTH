define(IF_COUNT,100)dnl
define({__},{})dnl
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
dnl 0= if
dnl ( x1 -- )
define(_0EQ_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if      
    pop  DE             ; 1:10      0= if
    jp   nz, else{}IF_COUNT}    ; 3:10      0= if)dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0= if
define(DUP_0EQ_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else{}IF_COUNT}    ; 3:10      dup 0= if)dnl
dnl
dnl
dnl 0< if
dnl ( x1 -- )
define(_0LT_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       0< if
    ex   DE, HL         ; 1:4       0< if      
    pop  DE             ; 1:10      0< if
    jp    z, else{}IF_COUNT}    ; 3:10      0< if)dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0< if
define(DUP_0LT_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       dup 0< if
    jp    z, else{}IF_COUNT}    ; 3:10      dup 0< if)dnl
dnl
dnl
dnl 0>= if
dnl ( x1 -- )
define(_0GE_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       0>= if
    ex   DE, HL         ; 1:4       0>= if      
    pop  DE             ; 1:10      0>= if
    jp   nz, else{}IF_COUNT}    ; 3:10      0>= if)dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0>= if
define(DUP_0GE_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       dup 0>= if
    jp   nz, else{}IF_COUNT}    ; 3:10      dup 0>= if)dnl
dnl
dnl
dnl D0= if
dnl ( x1 x2 -- )
define(D0EQ_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       D0= if
    or    L             ; 1:4       D0= if
    pop  HL             ; 1:10      D0= if
    or    D             ; 1:4       D0= if
    or    E             ; 1:4       D0= if
    pop  DE             ; 1:10      D0= if
    jp   nz, else{}IF_COUNT}    ; 3:10      D0= if)dnl
dnl
dnl
dnl ( x1 x2 -- x1 x2 )
dnl 2dup D0= if
define(_2DUP_D0EQ_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup D0= if
    or    L             ; 1:4       2dup D0= if
    or    D             ; 1:4       2dup D0= if
    or    E             ; 1:4       2dup D0= if
    jp   nz, else{}IF_COUNT}    ; 3:10      2dup D0= if)dnl
dnl
dnl
dnl ( x1 -- x1 ) 
dnl dup if
define(DUP_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup if
    or    L             ; 1:4       dup if
    jp    z, else{}IF_COUNT}    ; 3:10      dup if)dnl
dnl
dnl
dnl over if
define(OVER_IF,{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, D          ; 1:4       over if
    or    E             ; 1:4       over if
    jp    z, else{}IF_COUNT}    ; 3:10      over if)dnl
dnl
dnl -------- signed ---------
dnl
dnl dup num < if
define({DUP_PUSH_LT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 < if
    add   A, A          ; 1:4       dup $1 < if{}dnl
__{}ifelse(eval($1>=0x8000 || $1<0),{0},{
__{}    jr    c, $+11       ; 2:7/12    dup $1 < if    positive constant{}dnl
__{}},{
__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 < if    negative constant})
    ld    A, L          ; 1:4       dup $1 < if    (HL<$1) --> (HL-$1<0) --> carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 < if    (HL<$1) --> (HL-$1<0) --> carry if true
    ld    A, H          ; 1:4       dup $1 < if    (HL<$1) --> (HL-$1<0) --> carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 < if    (HL<$1) --> (HL-$1<0) --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 < if})dnl
dnl
dnl
dnl dup num >= if
define({DUP_PUSH_GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 >= if
    add   A, A          ; 1:4       dup $1 >= if{}dnl
__{}ifelse(eval($1>=0x8000 || $1<0),{0},{
__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if    positive constant{}dnl
__{}},{
__{}    jr   nc, $+11       ; 2:7/12    dup $1 >= if    negative constant})
    ld    A, L          ; 1:4       dup $1 >= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 >= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    ld    A, H          ; 1:4       dup $1 >= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= if    (HL>=$1) --> (HL-$1>=0) --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if})dnl
dnl
dnl
dnl dup num <= if
define({DUP_PUSH_LE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 <= if
    add   A, A          ; 1:4       dup $1 <= if{}dnl
__{}ifelse(eval($1>=0x8000 || $1<0),{0},{
__{}    jr    c, $+11       ; 2:7/12    dup $1 <= if    positive constant{}dnl
__{}},{
__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 <= if    negative constant})
    ld    A, low format({%-7s},$1); 2:7       dup $1 <= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    sub   L             ; 1:4       dup $1 <= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 <= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    sbc   A, H          ; 1:4       dup $1 <= if    (HL<=$1) --> (0<=$1-HL) --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      dup $1 <= if})dnl
dnl    
dnl
dnl dup num > if
define({DUP_PUSH_GT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup $1 > if
    add   A, A          ; 1:4       dup $1 > if{}dnl
__{}ifelse(eval($1>=0x8000 || $1<0),{0},{
__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 > if    positive constant{}dnl
__{}},{
__{}    jr   nc, $+11       ; 2:7/12    dup $1 > if    negative constant})
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
    ld    A, H          ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    ld    C, A          ; 1:4       2dup < if
    ld    A, E          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    rra                 ; 1:4       2dup < if
    xor   C             ; 1:4       2dup < if
    jp    p, else{}IF_COUNT    ; 3:10      2dup < if})dnl
dnl
dnl
dnl 2dup >= if
define({_2DUP_GE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup >= if
    xor   D             ; 1:4       2dup >= if
    ld    C, A          ; 1:4       2dup >= if
    ld    A, E          ; 1:4       2dup >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       2dup >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       2dup >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       2dup >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    rra                 ; 1:4       2dup >= if
    xor   C             ; 1:4       2dup >= if
    jp    m, else{}IF_COUNT    ; 3:10      2dup >= if})dnl
dnl
dnl
dnl 2dup <= if
define({_2DUP_LE_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup <= if
    xor   D             ; 1:4       2dup <= if
    ld    C, A          ; 1:4       2dup <= if
    ld    A, L          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sub   E             ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    ld    A, H          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sbc   A, D          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    rra                 ; 1:4       2dup <= if
    xor   C             ; 1:4       2dup <= if
    jp    m, else{}IF_COUNT    ; 3:10      2dup <= if})dnl
dnl    
dnl
dnl 2dup > if
define({_2DUP_GT_IF},{define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup > if
    xor   D             ; 1:4       2dup > if
    ld    C, A          ; 1:4       2dup > if
    ld    A, L          ; 1:4       2dup > if    (DE>HL) --> (HL-DE<0) --> carry if true
    sub   E             ; 1:4       2dup > if    (DE>HL) --> (HL-DE<0) --> carry if true
    ld    A, H          ; 1:4       2dup > if    (DE>HL) --> (HL-DE<0) --> carry if true
    sbc   A, D          ; 1:4       2dup > if    (DE>HL) --> (HL-DE<0) --> carry if true
    rra                 ; 1:4       2dup > if
    xor   C             ; 1:4       2dup > if
    jp    p, else{}IF_COUNT    ; 3:10      2dup > if})dnl
dnl
dnl

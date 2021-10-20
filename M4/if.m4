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
__{}eval($1),{0},{dnl
__{}__{}                        ;[5:18]     dup $1 = if
__{}__{}    ld    A, L          ; 1:4       dup $1 = if
__{}__{}    or    H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 = if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 = if
__{}__{}    xor   H             ; 1:4       dup $1 = if
__{}__{}    or    L             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}eval(($1)/256),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 = if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 = if
__{}__{}    xor   L             ; 1:4       dup $1 = if
__{}__{}    or    H             ; 1:4       dup $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 = if},
__{}{dnl
__{}__{}                        ;[12:21/42] dup $1 = if
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
__{}__{}                        ;[5:18]     dup $1 <> if
__{}__{}    ld    A, L          ; 1:4       dup $1 <> if
__{}__{}    or    H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 <> if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <> if
__{}__{}    xor   H             ; 1:4       dup $1 <> if
__{}__{}    or    L             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}eval(($1)/256),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 <> if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <> if
__{}__{}    xor   L             ; 1:4       dup $1 <> if
__{}__{}    or    H             ; 1:4       dup $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 <> if},
__{}{dnl
__{}__{}                        ;[11:23/39] dup $1 <> if
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
__{}eval($1),{0},{dnl
__{}__{}                        ;[5:18]     dup $1 u= if
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u= if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    or    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1)/256),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u= if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}{dnl
__{}__{}                        ;[12:21/42] dup $1 u= if
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
__{}__{}                        ;[5:18]     dup $1 u<> if
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u<> if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    or    L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1)/256),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u<> if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}{dnl
__{}__{}                        ;[11:23/39] dup $1 u<> if
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
__{}eval($1),{0},{dnl
__{}__{}                        ;[7:32]     $1 = if
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[9:39]     $1 = if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 = if
__{}__{}    xor   H             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1)/256),{0},{dnl
__{}__{}                        ;[9:39]     $1 = if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 = if
__{}__{}    xor   L             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}{dnl
dnl{}__{}__{}                        ;[14:39/56] $1 = if
dnl{}__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 = if
dnl{}__{}__{}    xor   L             ; 1:4       $1 = if
dnl{}__{}__{}    ld    A, H          ; 1:4       $1 = if
dnl{}__{}__{}    ex   DE, HL         ; 1:4       $1 = if
dnl{}__{}__{}    pop  DE             ; 1:10      $1 = if
dnl{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if
dnl{}__{}__{}    xor   high format({%-9s},$1); 2:7       $1 = if
dnl{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if
__{}__{}                        ;[11:53]    $1 = if
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
__{}__{}                        ;[7:32]     $1 <> if
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[9:39]     $1 <> if
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 <> if
__{}__{}    xor   H             ; 1:4       $1 <> if
__{}__{}    or    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1)/256),{0},{dnl
__{}__{}                        ;[9:39]     $1 <> if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 <> if
__{}__{}    xor   L             ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}{dnl
__{}__{}                        ;[13:41/53] $1 <> if
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 <> if
__{}__{}    xor   L             ; 1:4       $1 <> if
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor   high format({%-9s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if})})dnl
dnl
dnl
dnl

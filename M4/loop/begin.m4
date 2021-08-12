dnl ## Begin
define({__},{})dnl
dnl
dnl
dnl
dnl --------- begin while repeat ------------
dnl
dnl
define(BEGIN_COUNT,100)dnl
dnl
dnl ( -- )
define({BEGIN},{define({BEGIN_COUNT}, incr(BEGIN_COUNT))pushdef({BEGIN_STACK}, BEGIN_COUNT)
dnl # begin ... flag until
dnl # begin ... flag while ... repeat
dnl # begin ... again
dnl # begin     while           repeat
dnl # do  { ... if (!) break; } while (1)
begin{}BEGIN_STACK:})dnl
dnl
dnl
dnl ( flag -- )
define({WHILE},{
    ld    A, H          ; 1:4       while BEGIN_STACK
    or    L             ; 1:4       while BEGIN_STACK
    ex   DE, HL         ; 1:4       while BEGIN_STACK
    pop  DE             ; 1:10      while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      while BEGIN_STACK})dnl
dnl
dnl
dnl ( flag -- flag )
define({DUP_WHILE},{
    ld    A, H          ; 1:4       dup_while BEGIN_STACK
    or    L             ; 1:4       dup_while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      dup_while BEGIN_STACK})dnl
dnl
dnl
dnl ( -- )
define({BREAK},{
    jp   break{}BEGIN_STACK       ; 3:10      break BEGIN_STACK})dnl
dnl
dnl
dnl ( -- )
define({REPEAT},{
    jp   begin{}BEGIN_STACK       ; 3:10      repeat BEGIN_STACK
break{}BEGIN_STACK:               ;           repeat BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( -- )
define({AGAIN},{
    jp   begin{}BEGIN_STACK       ; 3:10      again BEGIN_STACK
break{}BEGIN_STACK:               ;           again BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( flag -- )
define({UNTIL},{
    ld    A, H          ; 1:4       until BEGIN_STACK
    or    L             ; 1:4       until BEGIN_STACK
    ex   DE, HL         ; 1:4       until BEGIN_STACK
    pop  DE             ; 1:10      until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      until BEGIN_STACK
break{}BEGIN_STACK:               ;           until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( flag -- flag )
define({DUP_UNTIL},{
    ld    A, H          ; 1:4       dup until BEGIN_STACK
    or    L             ; 1:4       dup until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      dup until BEGIN_STACK
break{}BEGIN_STACK:               ;           dup until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl
dnl
dnl    
dnl ------ 2dup ucond while ( b a -- b a ) ---------
dnl
define({_2DUP_UEQ_WHILE},{
    ld    A, E          ; 1:4       2dup u= while BEGIN_STACK
    sub   L             ; 1:4       2dup u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup u= while BEGIN_STACK
    ld    A, D          ; 1:4       2dup u= while BEGIN_STACK
    sub   H             ; 1:4       2dup u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup u= while BEGIN_STACK})dnl
dnl
dnl
define({_2DUP_UNE_WHILE},{
    ld    A, E          ; 1:4       2dup u<> while BEGIN_STACK
    sub   L             ; 1:4       2dup u<> while BEGIN_STACK
    jr   nz, $+7        ; 2:7/12    2dup u<> while BEGIN_STACK
    ld    A, D          ; 1:4       2dup u<> while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup u<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup u<> while BEGIN_STACK})dnl
dnl
dnl
define({_2DUP_ULT_WHILE},{
    ld    A, E          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup u< while BEGIN_STACK})dnl
dnl    
dnl
define({_2DUP_UGE_WHILE},{
    ld    A, E          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      2dup u>= while BEGIN_STACK})dnl
dnl    
dnl
define({_2DUP_ULE_WHILE},{
    ld    A, L          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      2dup u<= while BEGIN_STACK})dnl
dnl    
dnl
define({_2DUP_UGT_WHILE},{
    ld    A, L          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup u> while BEGIN_STACK})dnl
dnl
dnl    
dnl ------ 2dup scond while ( b a -- b a ) ---------
dnl
dnl 2dup = while
define({_2DUP_EQ_WHILE},{
    ld    A, E          ; 1:4       2dup = while BEGIN_STACK
    sub   L             ; 1:4       2dup = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup = while BEGIN_STACK
    ld    A, D          ; 1:4       2dup = while BEGIN_STACK
    sub   H             ; 1:4       2dup = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup = while BEGIN_STACK})dnl
dnl
dnl
dnl 2dup <> while
define({_2DUP_NE_WHILE},{
    ld    A, E          ; 1:4       2dup <> while BEGIN_STACK
    sub   L             ; 1:4       2dup <> while BEGIN_STACK
    jr   nz, $+7        ; 2:7/12    2dup <> while BEGIN_STACK
    ld    A, D          ; 1:4       2dup <> while BEGIN_STACK
    sub   H             ; 1:4       2dup <> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup <> while BEGIN_STACK})dnl
dnl
dnl
dnl 2dup < while
define({_2DUP_LT_WHILE},{
    ld    A, H          ; 1:4       2dup < while BEGIN_STACK
    xor   D             ; 1:4       2dup < while BEGIN_STACK
    ld    C, A          ; 1:4       2dup < while BEGIN_STACK
    ld    A, E          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < while BEGIN_STACK
    xor   C             ; 1:4       2dup < while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup < while BEGIN_STACK})dnl
dnl
dnl
dnl 2dup >= while
define({_2DUP_GE_WHILE},{
    ld    A, H          ; 1:4       2dup >= while BEGIN_STACK
    xor   D             ; 1:4       2dup >= while BEGIN_STACK
    ld    C, A          ; 1:4       2dup >= while BEGIN_STACK
    ld    A, E          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= while BEGIN_STACK
    xor   C             ; 1:4       2dup >= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      2dup >= while BEGIN_STACK})dnl
dnl
dnl
dnl 2dup <= while
define({_2DUP_LE_WHILE},{
    ld    A, H          ; 1:4       2dup <= while BEGIN_STACK
    xor   D             ; 1:4       2dup <= while BEGIN_STACK
    ld    C, A          ; 1:4       2dup <= while BEGIN_STACK
    ld    A, L          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= while BEGIN_STACK
    xor   C             ; 1:4       2dup <= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      2dup <= while BEGIN_STACK})dnl
dnl    
dnl
dnl 2dup > while
define({_2DUP_GT_WHILE},{
    ld    A, H          ; 1:4       2dup > while BEGIN_STACK
    xor   D             ; 1:4       2dup > while BEGIN_STACK
    ld    C, A          ; 1:4       2dup > while BEGIN_STACK
    ld    A, L          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > while BEGIN_STACK
    xor   C             ; 1:4       2dup > while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup > while BEGIN_STACK})dnl
dnl
dnl
dnl
dnl    
dnl ------ ucond while ( b a -- b a ) ---------
dnl
define({UEQ_WHILE},{
    or    A             ; 1:4       u= while BEGIN_STACK
    sbc  HL, DE         ; 2:15      u= while BEGIN_STACK
    pop  HL             ; 1:10      u= while BEGIN_STACK
    pop  DE             ; 1:10      u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      u= while BEGIN_STACK})dnl
dnl
dnl
define({UNE_WHILE},{
    or    A             ; 1:4       u<> while BEGIN_STACK
    sbc  HL, DE         ; 2:15      u<> while BEGIN_STACK
    pop  HL             ; 1:10      u<> while BEGIN_STACK
    pop  DE             ; 1:10      u<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      u<> while BEGIN_STACK})dnl
dnl
dnl
define({ULT_WHILE},{
    ld    A, E          ; 1:4       u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< while BEGIN_STACK
    pop  DE             ; 1:10      u< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      u< while BEGIN_STACK})dnl
dnl    
dnl
define({UGE_WHILE},{
    ld    A, E          ; 1:4       u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= while BEGIN_STACK
    pop  DE             ; 1:10      u>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      u>= while BEGIN_STACK})dnl
dnl    
dnl
define({ULE_WHILE},{
    ld    A, L          ; 1:4       u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= while BEGIN_STACK
    pop  DE             ; 1:10      u<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      u<= while BEGIN_STACK})dnl
dnl    
dnl
define({UGT_WHILE},{
    ld    A, L          ; 1:4       u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> while BEGIN_STACK
    pop  DE             ; 1:10      u> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      u> while BEGIN_STACK})dnl
dnl
dnl    
dnl ------ scond while ( b a -- b a ) ---------
dnl
dnl = while
define({EQ_WHILE},{
    or    A             ; 1:4       = while BEGIN_STACK
    sbc  HL, DE         ; 2:15      = while BEGIN_STACK
    pop  HL             ; 1:10      = while BEGIN_STACK
    pop  DE             ; 1:10      = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      = while BEGIN_STACK})dnl
dnl
dnl
dnl <> while
define({NE_WHILE},{
    or    A             ; 1:4       <> while BEGIN_STACK
    sbc  HL, DE         ; 2:15      <> while BEGIN_STACK
    pop  HL             ; 1:10      <> while BEGIN_STACK
    pop  DE             ; 1:10      <> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      <> while BEGIN_STACK})dnl
dnl
dnl
dnl < while
define({LT_WHILE},{
    ld    A, H          ; 1:4       < while BEGIN_STACK
    xor   D             ; 1:4       < while BEGIN_STACK
    ld    C, A          ; 1:4       < while BEGIN_STACK
    ld    A, E          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       < while BEGIN_STACK
    xor   C             ; 1:4       < while BEGIN_STACK
    pop  HL             ; 1:10      < while BEGIN_STACK
    pop  DE             ; 1:10      < while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      < while BEGIN_STACK})dnl
dnl
dnl
dnl >= while
define({GE_WHILE},{
    ld    A, H          ; 1:4       >= while BEGIN_STACK
    xor   D             ; 1:4       >= while BEGIN_STACK
    ld    C, A          ; 1:4       >= while BEGIN_STACK
    ld    A, E          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       >= while BEGIN_STACK
    xor   C             ; 1:4       >= while BEGIN_STACK
    pop  HL             ; 1:10      >= while BEGIN_STACK
    pop  DE             ; 1:10      >= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      >= while BEGIN_STACK})dnl
dnl
dnl
dnl <= while
define({LE_WHILE},{
    ld    A, H          ; 1:4       <= while BEGIN_STACK
    xor   D             ; 1:4       <= while BEGIN_STACK
    ld    C, A          ; 1:4       <= while BEGIN_STACK
    ld    A, L          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       <= while BEGIN_STACK
    xor   C             ; 1:4       <= while BEGIN_STACK
    pop  HL             ; 1:10      <= while BEGIN_STACK
    pop  DE             ; 1:10      <= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      <= while BEGIN_STACK})dnl
dnl    
dnl
dnl > while
define({GT_WHILE},{
    ld    A, H          ; 1:4       > while BEGIN_STACK
    xor   D             ; 1:4       > while BEGIN_STACK
    ld    C, A          ; 1:4       > while BEGIN_STACK
    ld    A, L          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       > while BEGIN_STACK
    xor   C             ; 1:4       > while BEGIN_STACK
    pop  HL             ; 1:10      > while BEGIN_STACK
    pop  DE             ; 1:10      > while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      > while BEGIN_STACK})dnl
dnl
dnl
dnl
dnl ------ dup const ucond while ( b a -- b a ) ---------
dnl
define({DUP_PUSH_UEQ_WHILE},{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u= while BEGIN_STACK
    xor   L             ; 1:4       dup $1 u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 u= while BEGIN_STACK
    ld    A, high format({%-6s},$1); 2:7       dup $1 u= while BEGIN_STACK
    xor   H             ; 1:4       dup $1 u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 u= while BEGIN_STACK})dnl
dnl
dnl
define({DUP_PUSH_UNE_WHILE},{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u<> while BEGIN_STACK
    xor   L             ; 1:4       dup $1 u<> while BEGIN_STACK
    jr   nz, $+8        ; 2:7/12    dup $1 u<> while BEGIN_STACK
    ld    A, high format({%-6s},$1); 2:7       dup $1 u<> while BEGIN_STACK
    xor   H             ; 1:4       dup $1 u<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      dup $1 u<> while BEGIN_STACK})dnl
dnl
dnl
define({DUP_PUSH_ULT_WHILE},{
    ld    A, L          ; 1:4       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
    ld    A, H          ; 1:4       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 u< while BEGIN_STACK})dnl
dnl    
dnl
define({DUP_PUSH_UGE_WHILE},{
    ld    A, L          ; 1:4       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
    ld    A, H          ; 1:4       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 u>= while BEGIN_STACK})dnl
dnl    
dnl
define({DUP_PUSH_ULE_WHILE},{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
    sub   L             ; 1:4       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
    sbc   A, H          ; 1:4       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 u<= while BEGIN_STACK})dnl
dnl    
dnl
define({DUP_PUSH_UGT_WHILE},{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
    sub   L             ; 1:4       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
    sbc   A, H          ; 1:4       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 u> while BEGIN_STACK})dnl
dnl
dnl    
dnl ------ dup const scond while ( b a -- b a ) ---------
dnl
dnl dup const = while
define({DUP_PUSH_EQ_WHILE},{
    ld    A, low format({%-7s},$1); 2:7       dup $1 = while BEGIN_STACK
    xor   L             ; 1:4       dup $1 = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 = while BEGIN_STACK
    ld    A, high format({%-6s},$1); 2:7       dup $1 = while BEGIN_STACK
    xor   H             ; 1:4       dup $1 = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 = while BEGIN_STACK})dnl
dnl
dnl
define({DUP_PUSH_NE_WHILE},{
    ld    A, low format({%-7s},$1); 2:7       dup $1 <> while BEGIN_STACK
    xor   L             ; 1:4       dup $1 <> while BEGIN_STACK
    jr   nz, $+8        ; 2:7/12    dup $1 <> while BEGIN_STACK
    ld    A, high format({%-6s},$1); 2:7       dup $1 <> while BEGIN_STACK
    xor   H             ; 1:4       dup $1 <> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      dup $1 <> while BEGIN_STACK})dnl
dnl
dnl
dnl dup const < while
define({DUP_PUSH_LT_WHILE},{ifelse(eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 < while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 < while BEGIN_STACK
__{}    ld    C, A          ; 1:4       dup $1 < while BEGIN_STACK
__{}    ld    A, L          ; 1:4       dup $1 < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
__{}    rra                 ; 1:4       dup $1 < while BEGIN_STACK
__{}    xor   C             ; 1:4       dup $1 < while BEGIN_STACK
__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK},
__{}{
__{}    ld    A, H          ; 1:4       dup $1 < while
__{}    add   A, A          ; 1:4       dup $1 < while{}dnl
__{}__{}ifelse(eval(($1)>=0x8000 || ($1)<0),{0},{
__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 < while    positive constant{}dnl
__{}__{}},{
__{}__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while    negative constant})
__{}    ld    A, L          ; 1:4       dup $1 < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK})})dnl
dnl
dnl
dnl dup const >= while
define({DUP_PUSH_GE_WHILE},{ifelse(eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 >= while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 >= while BEGIN_STACK
__{}    ld    C, A          ; 1:4       dup $1 >= while BEGIN_STACK
__{}    ld    A, L          ; 1:4       dup $1 >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
__{}    rra                 ; 1:4       dup $1 >= while BEGIN_STACK
__{}    xor   C             ; 1:4       dup $1 >= while BEGIN_STACK
__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK},
__{}{
__{}    ld    A, H          ; 1:4       dup $1 >= while
__{}    add   A, A          ; 1:4       dup $1 >= while{}dnl
__{}__{}ifelse(eval(($1)>=0x8000 || ($1)<0),{0},{
__{}__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 >= while    positive constant{}dnl
__{}__{}},{
__{}__{}    jr   nc, $+11       ; 2:7/11    dup $1 >= while    negative constant})
__{}    ld    A, L          ; 1:4       dup $1 >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK})})dnl
dnl
dnl
dnl dup const <= while
define({DUP_PUSH_LE_WHILE},{ifelse(eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <= while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 <= while BEGIN_STACK
__{}    ld    C, A          ; 1:4       dup $1 <= while BEGIN_STACK
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
__{}    sub   L             ; 1:4       dup $1 <= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 <= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
__{}    rra                 ; 1:4       dup $1 <= while BEGIN_STACK
__{}    xor   C             ; 1:4       dup $1 <= while BEGIN_STACK
__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK},
__{}{
__{}    ld    A, H          ; 1:4       dup $1 <= while
__{}    add   A, A          ; 1:4       dup $1 <= while{}dnl
__{}__{}ifelse(eval(($1)>=0x8000 || ($1)<0),{0},{
__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 <= while    positive constant{}dnl
__{}__{}},{
__{}__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 <= while   negative constant})
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
__{}    sub   L             ; 1:4       dup $1 <= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 <= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK})})dnl
dnl    
dnl
dnl dup const > while
define({DUP_PUSH_GT_WHILE},{ifelse(eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 > while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 > while BEGIN_STACK
__{}    ld    C, A          ; 1:4       dup $1 > while BEGIN_STACK
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 > while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
__{}    sub   L             ; 1:4       dup $1 > while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 > while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 > while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
__{}    rra                 ; 1:4       dup $1 > while BEGIN_STACK
__{}    xor   C             ; 1:4       dup $1 > while BEGIN_STACK
__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 > while BEGIN_STACK},
__{}{
__{}    ld    A, H          ; 1:4       dup $1 > while
__{}    add   A, A          ; 1:4       dup $1 > while{}dnl
__{}__{}ifelse(eval(($1)>=0x8000 || ($1)<0),{0},{
__{}__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 > while    positive constant{}dnl
__{}__{}},{
__{}__{}    jr   nc, $+11       ; 2:7/12    dup $1 > while    negative constant})
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 > while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
__{}    sub   L             ; 1:4       dup $1 > while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 > while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 > while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK})})dnl
dnl
dnl
dnl

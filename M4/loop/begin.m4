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
begin{}BEGIN_STACK:               ;           begin BEGIN_STACK})dnl
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
    ld    A, H          ; 1:4       until BEGIN_STACK   ( flag -- )
    or    L             ; 1:4       until BEGIN_STACK
    ex   DE, HL         ; 1:4       until BEGIN_STACK
    pop  DE             ; 1:10      until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      until BEGIN_STACK
break{}BEGIN_STACK:               ;           until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( flag -- )
define({_0EQ_UNTIL},{
    ld    A, H          ; 1:4       0= until BEGIN_STACK   ( flag -- )
    or    L             ; 1:4       0= until BEGIN_STACK
    ex   DE, HL         ; 1:4       0= until BEGIN_STACK
    pop  DE             ; 1:10      0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      0= until BEGIN_STACK
break{}BEGIN_STACK:               ;           0= until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( flag -- flag )
define({DUP_UNTIL},{
    ld    A, H          ; 1:4       dup until BEGIN_STACK   ( flag -- flag )
    or    L             ; 1:4       dup until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      dup until BEGIN_STACK
break{}BEGIN_STACK:               ;           dup until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( flag -- flag )
define({DUP_0EQ_UNTIL},{
    ld    A, H          ; 1:4       dup 0= until BEGIN_STACK   ( flag -- flag )
    or    L             ; 1:4       dup 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup 0= until BEGIN_STACK
break{}BEGIN_STACK:               ;           dup 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( addr -- addr )
define({DUP_CFETCH_UNTIL},{
    ld    A,(HL)        ; 1:7       dup C@ until BEGIN_STACK   ( addr -- addr )
    or    A             ; 1:4       dup C@ until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      dup C@ until BEGIN_STACK
break{}BEGIN_STACK:               ;           dup C@ until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( addr -- addr )
define({DUP_CFETCH_0EQ_UNTIL},{
    ld    A,(HL)        ; 1:7       dup C@ 0= until BEGIN_STACK   ( addr -- addr )
    or    A             ; 1:4       dup C@ 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup C@ 0= until BEGIN_STACK
break{}BEGIN_STACK:               ;           dup C@ 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( flag x -- flag x )
define({OVER_UNTIL},{
    ld    A, D          ; 1:4       over until BEGIN_STACK   ( flag x -- flag x )
    or    E             ; 1:4       over until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      over until BEGIN_STACK
break{}BEGIN_STACK:               ;           over until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( x1 x2 -- x1 x2 )
define({OVER_0EQ_UNTIL},{
    ld    A, D          ; 1:4       over 0= until BEGIN_STACK   ( x1 x2 -- x1 x2 )
    or    E             ; 1:4       over 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      over 0= until BEGIN_STACK
break{}BEGIN_STACK:               ;           over 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( b a -- b a )
define({_2DUP_EQ_UNTIL},{
__{}                        ;[10:18/36] 2dup eq until BEGIN_STACK
__{}    ld    A, L          ; 1:4       2dup eq until BEGIN_STACK
__{}    xor   E             ; 1:4       2dup eq until BEGIN_STACK   lo({TOS}) ^ lo({NOS})
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      2dup eq until BEGIN_STACK
__{}    ld    A, H          ; 1:4       2dup eq until BEGIN_STACK
__{}    xor   D             ; 1:4       2dup eq until BEGIN_STACK   hi({TOS}) ^ hi({NOS})
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      2dup eq until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           2dup eq until BEGIN_STACK{}popdef({BEGIN_STACK})}){}dnl
dnl
dnl
dnl ( n -- n )
define({DUP_PUSH_EQ_UNTIL},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(eval($1),{},{dnl
__{}__{}                        ;[12:21/42] dup $1 eq until BEGIN_STACK
__{}__{}    ld    A, L          ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 eq until BEGIN_STACK   lo(TOS) ^ lo(stop)
__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK
__{}__{}    ld    A, H          ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}    xor  high format({%-10s},$1); 2:7       dup $1 eq until BEGIN_STACK   hi(TOS) ^ hi(stop)
__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK},
__{}{dnl
__{}__{}ifelse(eval(($1) & 0xFFFF),{0},{dnl
__{}__{}__{}                        ;[5:18]     dup $1 eq until BEGIN_STACK   variant: zero
__{}__{}__{}    ld    A, L          ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    or    H             ; 1:4       dup $1 eq until BEGIN_STACK   TOS ^ stop
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK},
__{}__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}__{}                        ;[6:22]     dup $1 eq until BEGIN_STACK   variant: -1
__{}__{}__{}    ld    A, H          ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    and   L             ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    inc   A             ; 1:4       dup $1 eq until BEGIN_STACK   A = 0xFF --> 0x00 ?
__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK},
__{}__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}__{}                        ;[11:18/39] dup $1 eq until BEGIN_STACK   variant: lo($1) = 255
__{}__{}__{}    ld    A, L          ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    inc   A             ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK
__{}__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 eq until BEGIN_STACK
__{}__{}__{}    xor   H             ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK},
__{}__{}eval(($1) & 0x00FF),{0},{dnl
__{}__{}__{}                        ;[11:18/39] dup $1 eq until BEGIN_STACK   variant: lo($1) = 0
__{}__{}__{}    ld    A, L          ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    or    A             ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK
__{}__{}__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 eq until BEGIN_STACK
__{}__{}__{}    xor   H             ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK},
__{}__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}__{}                        ;[11:21/39] dup $1 eq until BEGIN_STACK   variant: hi($1) = 255
__{}__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 eq until BEGIN_STACK
__{}__{}__{}    xor   L             ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK
__{}__{}__{}    dec   A             ; 1:4       dup $1 eq until BEGIN_STACK   A = 0xFF
__{}__{}__{}    xor   H             ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK},
__{}__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}__{}                        ;[10:21/35] dup $1 eq until BEGIN_STACK   variant: hi($1) = 0
__{}__{}__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 eq until BEGIN_STACK
__{}__{}__{}    xor   L             ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK
__{}__{}__{}    or   H              ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK},
__{}__{}{dnl
__{}__{}__{}                        ;[11:21/42] dup $1 eq until BEGIN_STACK
__{}__{}__{}    ld    A, L          ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    xor  low format({%-11s},$1); 2:7       dup $1 eq until BEGIN_STACK   lo(TOS) ^ lo(stop)
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK
__{}__{}__{}    ld    A, H          ; 1:4       dup $1 eq until BEGIN_STACK
__{}__{}__{}    xor  high format({%-10s},$1); 2:7       dup $1 eq until BEGIN_STACK   hi(TOS) ^ hi(stop)
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 eq until BEGIN_STACK}){}dnl
__{}})
__{}break{}BEGIN_STACK:               ;           dup $1 eq until BEGIN_STACK{}popdef({BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl ( n -- n )
define({DUP_PUSH_HI_EQ_UNTIL},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(eval($1),{},{dnl
__{}__{}                        ;[6:21]     dup $1 hi_eq until BEGIN_STACK
__{}__{}    ld    A, H          ; 1:4       dup $1 hi_eq until BEGIN_STACK
__{}__{}    xor  high format({%-10s},$1); 2:7       dup $1 hi_eq until BEGIN_STACK   hi(TOS) ^ hi(stop)
__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 hi_eq until BEGIN_STACK},
__{}{dnl
__{}__{}ifelse(eval(($1) & 0xFF00),{0},{dnl
__{}__{}__{}                        ;[5:18]     dup $1 hi_eq until BEGIN_STACK   variant: zero
__{}__{}__{}    ld    A, H          ; 1:4       dup $1 hi_eq until BEGIN_STACK
__{}__{}__{}    or    A             ; 1:4       dup $1 hi_eq until BEGIN_STACK   hi(TOS) ^ hi(stop)
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 hi_eq until BEGIN_STACK},
__{}__{}eval(0xFF00 - (($1) & 0xFF00)),{0},{dnl
__{}__{}__{}                        ;[5:18]     dup $1 hi_eq until BEGIN_STACK   variant: hi(stop) == 255
__{}__{}__{}    ld    A, H          ; 1:4       dup $1 hi_eq until BEGIN_STACK
__{}__{}__{}    inc   A             ; 1:4       dup $1 hi_eq until BEGIN_STACK   A = 0xFF --> 0x00 ?
__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 hi_eq until BEGIN_STACK},
__{}__{}{dnl
__{}__{}__{}                        ;[6:21]     dup $1 hi_eq until BEGIN_STACK
__{}__{}__{}    ld    A, H          ; 1:4       dup $1 hi_eq until BEGIN_STACK
__{}__{}__{}    xor  high format({%-10s},$1); 2:7       dup $1 hi_eq until BEGIN_STACK   hi(TOS) ^ hi(stop)
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup $1 hi_eq until BEGIN_STACK}){}dnl
__{}})
__{}break{}BEGIN_STACK:               ;           dup $1 hi_eq until BEGIN_STACK{}popdef({BEGIN_STACK})}){}dnl
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
    ld    A, E          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < while BEGIN_STACK
    xor   D             ; 1:4       2dup < while BEGIN_STACK
    xor   H             ; 1:4       2dup < while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup < while BEGIN_STACK})dnl
dnl
dnl
dnl 2dup >= while
define({_2DUP_GE_WHILE},{
    ld    A, E          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= while BEGIN_STACK
    xor   D             ; 1:4       2dup >= while BEGIN_STACK
    xor   H             ; 1:4       2dup >= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      2dup >= while BEGIN_STACK})dnl
dnl
dnl
dnl 2dup <= while
define({_2DUP_LE_WHILE},{
    ld    A, L          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= while BEGIN_STACK
    xor   D             ; 1:4       2dup <= while BEGIN_STACK
    xor   H             ; 1:4       2dup <= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      2dup <= while BEGIN_STACK})dnl
dnl
dnl
dnl 2dup > while
define({_2DUP_GT_WHILE},{
    ld    A, L          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > while BEGIN_STACK
    xor   D             ; 1:4       2dup > while BEGIN_STACK
    xor   H             ; 1:4       2dup > while BEGIN_STACK
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
    ld    A, E          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       < while BEGIN_STACK
    xor   D             ; 1:4       < while BEGIN_STACK
    xor   H             ; 1:4       < while BEGIN_STACK
    pop  HL             ; 1:10      < while BEGIN_STACK
    pop  DE             ; 1:10      < while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      < while BEGIN_STACK})dnl
dnl
dnl
dnl >= while
define({GE_WHILE},{
    ld    A, E          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       >= while BEGIN_STACK
    xor   D             ; 1:4       >= while BEGIN_STACK
    xor   H             ; 1:4       >= while BEGIN_STACK
    pop  HL             ; 1:10      >= while BEGIN_STACK
    pop  DE             ; 1:10      >= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      >= while BEGIN_STACK})dnl
dnl
dnl
dnl <= while
define({LE_WHILE},{
    ld    A, L          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       <= while BEGIN_STACK
    xor   D             ; 1:4       <= while BEGIN_STACK
    xor   H             ; 1:4       <= while BEGIN_STACK
    pop  HL             ; 1:10      <= while BEGIN_STACK
    pop  DE             ; 1:10      <= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      <= while BEGIN_STACK})dnl
dnl
dnl
dnl > while
define({GT_WHILE},{
    ld    A, L          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       > while BEGIN_STACK
    xor   D             ; 1:4       > while BEGIN_STACK
    xor   H             ; 1:4       > while BEGIN_STACK
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
define({DUP_PUSH_LT_WHILE},{ifelse(index({$1},{(}),{0},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 < while BEGIN_STACK
__{}    ld    A, L          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   C             ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, B          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    rra                 ; 1:4       dup $1 < while BEGIN_STACK
__{}    xor   B             ; 1:4       dup $1 < while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 < while BEGIN_STACK
__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK},
__{}eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld    A, L          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    rra                 ; 1:4       dup $1 < while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 < while BEGIN_STACK
__{}    xor   high format({%-9s},$1); 2:7       dup $1 < while BEGIN_STACK
__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK},
__{}{
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK
__{}    add   A, A          ; 1:4       dup $1 < while BEGIN_STACK{}dnl
__{}__{}ifelse(eval(($1)>=0x8000 || ($1)<0),{0},{
__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 < while BEGIN_STACK    negative HL < positive constant ---> true{}dnl
__{}__{}},{
__{}__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK    positive HL < negative constant ---> false})
__{}    ld    A, L          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK})})dnl
dnl
dnl
dnl dup const >= while
define({DUP_PUSH_GE_WHILE},{ifelse(index({$1},{(}),{0},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 >= while BEGIN_STACK
__{}    ld    A, L          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   C             ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, B          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    rra                 ; 1:4       dup $1 >= while BEGIN_STACK
__{}    xor   B             ; 1:4       dup $1 >= while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 >= while BEGIN_STACK
__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK},
__{}eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld    A, L          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    rra                 ; 1:4       dup $1 >= while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 >= while BEGIN_STACK
__{}    xor   high format({%-9s},$1); 2:7       dup $1 >= while BEGIN_STACK
__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK},
__{}{
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK
__{}    add   A, A          ; 1:4       dup $1 >= while BEGIN_STACK{}dnl
__{}__{}ifelse(eval(($1)>=0x8000 || ($1)<0),{0},{
__{}__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK    negative HL >= positive constant ---> false{}dnl
__{}__{}},{
__{}__{}    jr   nc, $+11       ; 2:7/11    dup $1 >= while BEGIN_STACK    positive HL >= negative constant ---> true})
__{}    ld    A, L          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK})})dnl
dnl
dnl
dnl dup const <= while
define({DUP_PUSH_LE_WHILE},{ifelse(index({$1},{(}),{0},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 <= while BEGIN_STACK
__{}    ld    A, C          ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sub   L             ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    ld    A, B          ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    rra                 ; 1:4       dup $1 <= while BEGIN_STACK
__{}    xor   B             ; 1:4       dup $1 <= while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 <= while BEGIN_STACK
__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK},
__{}eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sub   L             ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    rra                 ; 1:4       dup $1 <= while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 <= while BEGIN_STACK
__{}    xor   high format({%-9s},$1); 2:7       dup $1 <= while BEGIN_STACK
__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK},
__{}{
__{}    ld    A, H          ; 1:4       dup $1 <= while BEGIN_STACK
__{}    add   A, A          ; 1:4       dup $1 <= while BEGIN_STACK{}dnl
__{}__{}ifelse(eval(($1)>=0x8000 || ($1)<0),{0},{
__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 <= while BEGIN_STACK    negative HL <= positive constant ---> true{}dnl
__{}__{}},{
__{}__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK    positive HL <= negative constant ---> false})
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sub   L             ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK})})dnl
dnl
dnl
dnl dup const > while
define({DUP_PUSH_GT_WHILE},{ifelse(index({$1},{(}),{0},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 > while BEGIN_STACK
__{}    ld    A, C          ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sub   L             ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    ld    A, B          ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    rra                 ; 1:4       dup $1 > while BEGIN_STACK
__{}    xor   B             ; 1:4       dup $1 > while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 > while BEGIN_STACK
__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 > while BEGIN_STACK},
__{}eval($1),{},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sub   L             ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    rra                 ; 1:4       dup $1 > while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 > while BEGIN_STACK
__{}    xor   high format({%-9s},$1); 2:7       dup $1 > while BEGIN_STACK
__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 > while BEGIN_STACK},
__{}{
__{}    ld    A, H          ; 1:4       dup $1 > while BEGIN_STACK
__{}    add   A, A          ; 1:4       dup $1 > while BEGIN_STACK{}dnl
__{}__{}ifelse(eval(($1)>=0x8000 || ($1)<0),{0},{
__{}__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 > while BEGIN_STACK    negative HL > positive constant ---> false{}dnl
__{}__{}},{
__{}__{}    jr   nc, $+11       ; 2:7/12    dup $1 > while BEGIN_STACK    positive HL > negative constant ---> true})
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sub   L             ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK})})dnl
dnl
dnl
dnl
dnl ----------------------- 32 bit -----------------------
dnl ------ signed_32_bit_cond while ( d2 d1 -- ) ---------
dnl
dnl D= while
define({DEQ_WHILE},{
                       ;[14:91]     D= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D= while BEGIN_STACK   lo_2
    or    A             ; 1:4       D= while BEGIN_STACK
    sbc  HL, BC         ; 2:15      D= while BEGIN_STACK   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      D= while BEGIN_STACK   hi_2
    jr   nz, $+4        ; 2:7/12    D= while BEGIN_STACK
    sbc  HL, DE         ; 2:15      D= while BEGIN_STACK   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= while BEGIN_STACK
    pop  DE             ; 1:10      D= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      D= while BEGIN_STACK})dnl
dnl
dnl
dnl D<> while
define({DNE_WHILE},{
                       ;[14:91]     D<> while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> while BEGIN_STACK   lo_2
    or    A             ; 1:4       D<> while BEGIN_STACK
    sbc  HL, BC         ; 2:15      D<> while BEGIN_STACK   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      D<> while BEGIN_STACK   hi_2
    jr   nz, $+4        ; 2:7/12    D<> while BEGIN_STACK
    sbc  HL, DE         ; 2:15      D<> while BEGIN_STACK   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> while BEGIN_STACK
    pop  DE             ; 1:10      D<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      D<> while BEGIN_STACK})dnl
dnl
dnl
dnl D< while
define({DLT_WHILE},{define({USE_FCE_DLT},{yes})
                       ;[10:146]    D< while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D< while BEGIN_STACK   l2
    pop  AF             ; 1:10      D< while BEGIN_STACK   h2
    call FCE_DLT        ; 3:17      D< while BEGIN_STACK   carry if true
    pop  HL             ; 1:10      D< while BEGIN_STACK
    pop  DE             ; 1:10      D< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      D< while BEGIN_STACK})dnl
dnl
dnl
dnl D>= while
define({DGE_WHILE},{define({USE_FCE_DGE},{yes})
                       ;[10:150]    D>= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D>= while BEGIN_STACK   l2
    pop  AF             ; 1:10      D>= while BEGIN_STACK   h2
    call FCE_DGE        ; 3:17      D>= while BEGIN_STACK   carry if true
    pop  HL             ; 1:10      D>= while BEGIN_STACK
    pop  DE             ; 1:10      D>= while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      D>= while BEGIN_STACK})dnl
dnl
dnl
dnl D<= while
define({DLE_WHILE},{define({USE_FCE_DLE},{yes})
                       ;[10:150]    D<= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D<= while BEGIN_STACK   l2
    pop  AF             ; 1:10      D<= while BEGIN_STACK   h2
    call FCE_DLE        ; 3:17      D<= while BEGIN_STACK   carry if true
    pop  HL             ; 1:10      D<= while BEGIN_STACK
    pop  DE             ; 1:10      D<= while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      D<= while BEGIN_STACK})dnl
dnl
dnl
dnl D> while
define({DGT_WHILE},{define({USE_FCE_DGT},{yes})
                       ;[10:146]    D> while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D> while BEGIN_STACK   l2
    pop  AF             ; 1:10      D> while BEGIN_STACK   h2
    call FCE_DGT        ; 3:17      D> while BEGIN_STACK   carry if true
    pop  HL             ; 1:10      D> while BEGIN_STACK
    pop  DE             ; 1:10      D> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      D> while BEGIN_STACK})dnl
dnl
dnl
dnl
dnl ----- 4dup signed_32_bit_cond while ( d2 d1 -- d2 d1 ) -----
dnl
dnl 4dup D= while
define({_4DUP_DEQ_WHILE},{
                       ;[18:135/125]4dup D= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D= while BEGIN_STACK   h2          . h1 l1  BC= lo(d2) = l2
    pop  AF             ; 1:10      4dup D= while BEGIN_STACK               . h1 l1  AF= hi(d2) = h2
    push AF             ; 1:11      4dup D= while BEGIN_STACK   h2          . h1 l1
    push BC             ; 1:11      4dup D= while BEGIN_STACK   h2 l2       . h1 l1
    push HL             ; 1:11      4dup D= while BEGIN_STACK   h2 l2 l1    . h1 l1
    push AF             ; 1:11      4dup D= while BEGIN_STACK   h2 l2 l1 h2 . h1 l1
    xor   A             ; 1:4       4dup D= while BEGIN_STACK   h2 l2 l1 h2 . h1 l1
    sbc  HL, BC         ; 2:15      4dup D= while BEGIN_STACK   h2 l2 l1 h2 . h1 --  lo(d1)-lo(d2)
    pop  HL             ; 1:10      4dup D= while BEGIN_STACK   h2 l2 l1    . h1 h2
    jr   nz, $+4        ; 2:7/12    4dup D= while BEGIN_STACK   h2 l2 l1    . h1 h2
    sbc  HL, DE         ; 2:15      4dup D= while BEGIN_STACK   h2 l2 l1    . h1 --  hi(d2)-hi(d1)
    pop  HL             ; 1:10      4dup D= while BEGIN_STACK   h2 l2       . h1 l1
    jp   nz, break{}BEGIN_STACK   ; 3:10      4dup D= while BEGIN_STACK   h2 l2       . h1 l1})dnl
dnl
dnl
dnl 4dup D<> while
define({_4DUP_DNE_WHILE},{ifelse(TYP_DOUBLE,{small},{
                  ;[18:125,135/135] 4dup D<> while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # small version can be changed with "define({TYP_DOUBLE},{name})"  name=fast,default
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK   h2          . h1 l1  BC = lo(d2) = l2
    pop  AF             ; 1:10      4dup D<> while BEGIN_STACK               . h1 l1  AF = hi(d2) = h2
    push AF             ; 1:11      4dup D<> while BEGIN_STACK   h2          . h1 l1
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2       . h1 l1
    push HL             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2 l1    . h1 l1
    push AF             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2 l1 h2 . h1 l1
    xor   A             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 l1 h2 . h1 l1
    sbc  HL, BC         ; 2:15      4dup D<> while BEGIN_STACK   h2 l2 l1 h2 . h1 --  lo(d1)-lo(d2)
    pop  HL             ; 1:10      4dup D<> while BEGIN_STACK   h2 l2 l1    . h1 h2
    jr   nz, $+4        ; 2:7/12    4dup D<> while BEGIN_STACK   h2 l2 l1    . h1 h2
    sbc  HL, DE         ; 2:15      4dup D<> while BEGIN_STACK   h2 l2 l1    . h1 --  hi(d2)-hi(d1)
    pop  HL             ; 1:10      4dup D<> while BEGIN_STACK   h2 l2       . h1 l1
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK},
TYP_DOUBLE,{fast},{
            ;[23:41,56,113,126/126] 4dup D<> while BEGIN_STACK  ( d2 d1 -- d2 d1 )   # fast version can be changed with "define({TYP_DOUBLE},{name})  name=small,default"
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK   h2    . h1 l1  BC= lo(d2) = l2
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+19       ; 2:7/12    4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  --> exit
    ld    A, B          ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+15       ; 2:7/12    4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  --> exit
    pop  AF             ; 1:10      4dup D<> while BEGIN_STACK   h2    . h1 l1  AF= lo(d2) = l2
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK         . h1 l1  BC= lo(d2) = h2
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2    . h1 l1  BC= lo(d2) = h2
    push AF             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  AF= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  lo(h2) - lo(l1)
    jr   nz, $+7        ; 2:7/12    4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  --> exit
    ld    A, B          ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  A = hi(h2)
    sub   D             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  hi(h2) - hi(h1)
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK},
{
            ;[21:51,66,123,122/122] 4dup D<> while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({TYP_DOUBLE},{name})  name=small,fast"
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> while BEGIN_STACK   h2       . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> while BEGIN_STACK   h2       . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> while BEGIN_STACK   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> while BEGIN_STACK   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while BEGIN_STACK   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> while BEGIN_STACK   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> while BEGIN_STACK   h2       . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> while BEGIN_STACK   h2       . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2    . h1 l1
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup D< while
define({_4DUP_DLT_WHILE},{ifelse(TYP_DOUBLE,{fast},{define({USE_FCE_DLT},{yes})
                       ;[10:148]    4dup D< while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D< while BEGIN_STACK
    pop  AF             ; 1:10      4dup D< while BEGIN_STACK
    push AF             ; 1:11      4dup D< while BEGIN_STACK
    push BC             ; 1:11      4dup D< while BEGIN_STACK
    call FCE_DLT        ; 3:17      4dup D< while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D< while BEGIN_STACK},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:181]    4dup D< while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup D>= while
define({_4DUP_DGE_WHILE},{ifelse(TYP_DOUBLE,{fast},{define({USE_FCE_DGE},{yes})
                       ;[10:152]    4dup D>= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D>= while BEGIN_STACK
    pop  AF             ; 1:10      4dup D>= while BEGIN_STACK
    push AF             ; 1:11      4dup D>= while BEGIN_STACK
    push BC             ; 1:11      4dup D>= while BEGIN_STACK
    call FCE_DGE        ; 3:17      4dup D>= while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D>= while BEGIN_STACK},
{define({USE_FCE_4DUP_DGE},{yes})
                        ;[6:185]    4dup D>= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGE   ; 3:17      4dup D>= while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup D<= while
define({_4DUP_DLE_WHILE},{ifelse(TYP_DOUBLE,{fast},{define({USE_FCE_DLE},{yes})
                       ;[10:152]    4dup D<= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D<= while BEGIN_STACK
    pop  AF             ; 1:10      4dup D<= while BEGIN_STACK
    push AF             ; 1:11      4dup D<= while BEGIN_STACK
    push BC             ; 1:11      4dup D<= while BEGIN_STACK
    call FCE_DLE        ; 3:17      4dup D<= while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D<= while BEGIN_STACK},
{define({USE_FCE_4DUP_DLE},{yes})
                        ;[6:185]    4dup D<= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLE   ; 3:17      4dup D<= while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D<= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup D> while
define({_4DUP_DGT_WHILE},{ifelse(TYP_DOUBLE,{fast},{define({USE_FCE_DGT},{yes})
                       ;[10:148]    4dup D> while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D> while BEGIN_STACK
    pop  AF             ; 1:10      4dup D> while BEGIN_STACK
    push AF             ; 1:11      4dup D> while BEGIN_STACK
    push BC             ; 1:11      4dup D> while BEGIN_STACK
    call FCE_DGT        ; 3:17      4dup D> while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D> while BEGIN_STACK},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:181]    4dup D> while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl 2dup D. D= while
dnl ( d -- d )
define({_2DUP_PUSHDOT_DEQ_WHILE},{dnl
__{}define({_TMP_INFO},{2dup $1 D= while BEGIN_STACK})dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 )   format({0x%08X},eval($1)) == DEHL})dnl
__{}ifelse($1,{},{
__{}__{}    .error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(index({$1},{(}),{0},{
__{}__{}__{}                        ;[19:108]   _TMP_INFO    ( d1 -- d1 )   (addr) == DEHL
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO   lo16(d1)-BC
__{}__{}__{}    jp   nz, $+7        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL,format({%-12s},($1+2)); 3:16      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO   HL-hi16(d1)
__{}__{}__{}    pop  HL             ; 1:10      _TMP_INFO
__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
__{}__{}eval($1),{},{
__{}__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__{}____DEQ_MAKE_BEST_CODE($1,3,10,0,0){}dnl
__{}__{}__{}____DEQ_MAKE_HL_CODE($1,0,0){}dnl
__{}__{}__{}define({_TMP_B},eval(_TMP_B+3)){}dnl
__{}__{}__{}define({_TMP_J},eval(_TMP_J+10)){}dnl
__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_P},eval(8*_TMP_NJ+4*_TMP_J+4*_TMP_J2+64*_TMP_B)){}dnl     price = 16*(clocks + 4*bytes)
__{}__{}__{}ifelse(ifelse(_TYP_DOUBLE,{small},{eval((_TMP_BEST_B<_TMP_B) || ((_TMP_BEST_B==_TMP_B) && (_TMP_BEST_P<_TMP_P)))},{eval(_TMP_BEST_P<=_TMP_P)}),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO   price: _TMP_BEST_P},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[_TMP_B:_TMP_NJ/_TMP_J,_TMP_J2] _TMP_INFO   ( d1 -- d1 )_TMP_HL_CODE
__{}__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO   price: _TMP_P})})},
__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl 2dup D. D<> while
dnl ( d -- d )
define({_2DUP_PUSHDOT_DNE_WHILE},{dnl
__{}define({_TMP_INFO},{2dup $1 D<> while BEGIN_STACK})dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 )   format({0x%08X},eval($1)) <> DEHL})dnl
__{}ifelse($1,{},{
__{}__{}    .error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(index({$1},{(}),{0},{
__{}__{}__{}                        ;[19:108]   _TMP_INFO    ( d1 -- d1 )   (addr) == DEHL
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO   lo16(d1)-BC
__{}__{}__{}    jp   nz, $+7        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL,format({%-12s},($1+2)); 3:16      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO   HL-hi16(d1)
__{}__{}__{}    pop  HL             ; 1:10      _TMP_INFO
__{}__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
__{}__{}eval($1),{},{
__{}__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__{}____DEQ_MAKE_BEST_CODE($1,3,10,3,-10){}dnl
__{}__{}__{}____DEQ_MAKE_HL_CODE($1,3,-10){}dnl
__{}__{}__{}define({_TMP_B},eval(_TMP_B+3)){}dnl
__{}__{}__{}define({_TMP_J},eval(_TMP_J+10)){}dnl
__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_P},eval(8*_TMP_J2+4*_TMP_NJ+4*_TMP_J+64*_TMP_B)){}dnl     price = 16*(clocks + 4*bytes)
__{}__{}__{}ifelse(ifelse(_TYP_DOUBLE,{small},{eval((_TMP_BEST_B<_TMP_B) || ((_TMP_BEST_B==_TMP_B) && (_TMP_BEST_P<_TMP_P)))},{eval(_TMP_BEST_P<=_TMP_P)}),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO   price: _TMP_BEST_P},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[_TMP_B:_TMP_J,_TMP_NJ/_TMP_J2] _TMP_INFO   ( d1 -- d1 )_TMP_HL_CODE
__{}__{}__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO   price: _TMP_P})})},
__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl

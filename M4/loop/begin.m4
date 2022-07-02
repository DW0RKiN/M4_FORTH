dnl ## Begin
define({__},{})dnl
dnl
dnl
dnl
dnl --------- begin while repeat ------------
dnl
dnl
define({BEGIN_COUNT},100)dnl
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
define({WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       while BEGIN_STACK
    or    L             ; 1:4       while BEGIN_STACK
    ex   DE, HL         ; 1:4       while BEGIN_STACK
    pop  DE             ; 1:10      while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      while BEGIN_STACK})})dnl
dnl
dnl
dnl ( flag -- flag )
define({DUP_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       dup_while BEGIN_STACK
    or    L             ; 1:4       dup_while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      dup_while BEGIN_STACK})})dnl
dnl
dnl
dnl ( -- )
define({BREAK},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    jp   break{}BEGIN_STACK       ; 3:10      break BEGIN_STACK})})dnl
dnl
dnl
dnl ( -- )
define({REPEAT},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    jp   begin{}BEGIN_STACK       ; 3:10      repeat BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           repeat BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl ( -- )
define({AGAIN},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    jp   begin{}BEGIN_STACK       ; 3:10      again BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           again BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl ( flag -- )
define({UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       until BEGIN_STACK   ( flag -- )
    or    L             ; 1:4       until BEGIN_STACK
    ex   DE, HL         ; 1:4       until BEGIN_STACK
    pop  DE             ; 1:10      until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           until BEGIN_STACK{}popdef({BEGIN_STACK})})})dnl
dnl
dnl
dnl ( flag -- )
define({_0EQ_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       0= until BEGIN_STACK   ( flag -- )
    or    L             ; 1:4       0= until BEGIN_STACK
    ex   DE, HL         ; 1:4       0= until BEGIN_STACK
    pop  DE             ; 1:10      0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           0= until BEGIN_STACK{}popdef({BEGIN_STACK})})})dnl
dnl
dnl
dnl ( flag -- flag )
define({DUP_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       dup until BEGIN_STACK   ( flag -- flag )
    or    L             ; 1:4       dup until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      dup until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           dup until BEGIN_STACK{}popdef({BEGIN_STACK})})})dnl
dnl
dnl
dnl ( flag -- flag )
define({DUP_0EQ_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       dup 0= until BEGIN_STACK   ( flag -- flag )
    or    L             ; 1:4       dup 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup 0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           dup 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})})dnl
dnl
dnl
dnl ( addr -- addr )
define({DUP_CFETCH_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A,(HL)        ; 1:7       dup C@ until BEGIN_STACK   ( addr -- addr )
    or    A             ; 1:4       dup C@ until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      dup C@ until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           dup C@ until BEGIN_STACK{}popdef({BEGIN_STACK})})})dnl
dnl
dnl
dnl ( addr -- addr )
define({DUP_CFETCH_0EQ_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A,(HL)        ; 1:7       dup C@ 0= until BEGIN_STACK   ( addr -- addr )
    or    A             ; 1:4       dup C@ 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup C@ 0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           dup C@ 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})})dnl
dnl
dnl
dnl ( flag x -- flag x )
define({OVER_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, D          ; 1:4       over until BEGIN_STACK   ( flag x -- flag x )
    or    E             ; 1:4       over until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      over until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           over until BEGIN_STACK{}popdef({BEGIN_STACK})})})dnl
dnl
dnl
dnl ( x1 x2 -- x1 x2 )
define({OVER_0EQ_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, D          ; 1:4       over 0= until BEGIN_STACK   ( x1 x2 -- x1 x2 )
    or    E             ; 1:4       over 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      over 0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           over 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})})dnl
dnl
dnl
dnl ( b a -- b a )
define({_2DUP_EQ_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
__{}                        ;[10:18/36] 2dup eq until BEGIN_STACK
__{}    ld    A, L          ; 1:4       2dup eq until BEGIN_STACK
__{}    xor   E             ; 1:4       2dup eq until BEGIN_STACK   lo({TOS}) ^ lo({NOS})
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      2dup eq until BEGIN_STACK
__{}    ld    A, H          ; 1:4       2dup eq until BEGIN_STACK
__{}    xor   D             ; 1:4       2dup eq until BEGIN_STACK   hi({TOS}) ^ hi({NOS})
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      2dup eq until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           2dup eq until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl ( n -- n )
define({DUP_PUSH_EQ_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
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
define({DUP_PUSH_HI_EQ_UNTIL},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
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
define({_2DUP_UEQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup u= while BEGIN_STACK
    sub   L             ; 1:4       2dup u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup u= while BEGIN_STACK
    ld    A, D          ; 1:4       2dup u= while BEGIN_STACK
    sub   H             ; 1:4       2dup u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup u= while BEGIN_STACK})})dnl
dnl
dnl
define({_2DUP_UNE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup u<> while BEGIN_STACK
    sub   L             ; 1:4       2dup u<> while BEGIN_STACK
    jr   nz, $+7        ; 2:7/12    2dup u<> while BEGIN_STACK
    ld    A, D          ; 1:4       2dup u<> while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup u<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup u<> while BEGIN_STACK})})dnl
dnl
dnl
define({_2DUP_ULT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup u< while BEGIN_STACK})})dnl
dnl
dnl
define({_2DUP_UGE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      2dup u>= while BEGIN_STACK})})dnl
dnl
dnl
define({_2DUP_ULE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      2dup u<= while BEGIN_STACK})})dnl
dnl
dnl
define({_2DUP_UGT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup u> while BEGIN_STACK})})dnl
dnl
dnl
dnl ------ 2dup scond while ( b a -- b a ) ---------
dnl
dnl 2dup = while
define({_2DUP_EQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup = while BEGIN_STACK
    sub   L             ; 1:4       2dup = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup = while BEGIN_STACK
    ld    A, D          ; 1:4       2dup = while BEGIN_STACK
    sub   H             ; 1:4       2dup = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup = while BEGIN_STACK})})dnl
dnl
dnl
dnl 2dup <> while
define({_2DUP_NE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup <> while BEGIN_STACK
    sub   L             ; 1:4       2dup <> while BEGIN_STACK
    jr   nz, $+7        ; 2:7/12    2dup <> while BEGIN_STACK
    ld    A, D          ; 1:4       2dup <> while BEGIN_STACK
    sub   H             ; 1:4       2dup <> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup <> while BEGIN_STACK})})dnl
dnl
dnl
dnl 2dup < while
define({_2DUP_LT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < while BEGIN_STACK
    xor   D             ; 1:4       2dup < while BEGIN_STACK
    xor   H             ; 1:4       2dup < while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup < while BEGIN_STACK})})dnl
dnl
dnl
dnl 2dup >= while
define({_2DUP_GE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= while BEGIN_STACK
    xor   D             ; 1:4       2dup >= while BEGIN_STACK
    xor   H             ; 1:4       2dup >= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      2dup >= while BEGIN_STACK})})dnl
dnl
dnl
dnl 2dup <= while
define({_2DUP_LE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= while BEGIN_STACK
    xor   D             ; 1:4       2dup <= while BEGIN_STACK
    xor   H             ; 1:4       2dup <= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      2dup <= while BEGIN_STACK})})dnl
dnl
dnl
dnl 2dup > while
define({_2DUP_GT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > while BEGIN_STACK
    xor   D             ; 1:4       2dup > while BEGIN_STACK
    xor   H             ; 1:4       2dup > while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup > while BEGIN_STACK})})dnl
dnl
dnl
dnl
dnl
dnl ------ ucond while ( b a -- b a ) ---------
dnl
define({UEQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    or    A             ; 1:4       u= while BEGIN_STACK
    sbc  HL, DE         ; 2:15      u= while BEGIN_STACK
    pop  HL             ; 1:10      u= while BEGIN_STACK
    pop  DE             ; 1:10      u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      u= while BEGIN_STACK})})dnl
dnl
dnl
define({UNE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    or    A             ; 1:4       u<> while BEGIN_STACK
    sbc  HL, DE         ; 2:15      u<> while BEGIN_STACK
    pop  HL             ; 1:10      u<> while BEGIN_STACK
    pop  DE             ; 1:10      u<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      u<> while BEGIN_STACK})})dnl
dnl
dnl
define({ULT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< while BEGIN_STACK
    pop  DE             ; 1:10      u< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      u< while BEGIN_STACK})})dnl
dnl
dnl
define({UGE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= while BEGIN_STACK
    pop  DE             ; 1:10      u>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      u>= while BEGIN_STACK})})dnl
dnl
dnl
define({ULE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= while BEGIN_STACK
    pop  DE             ; 1:10      u<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      u<= while BEGIN_STACK})})dnl
dnl
dnl
define({UGT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> while BEGIN_STACK
    pop  DE             ; 1:10      u> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      u> while BEGIN_STACK})})dnl
dnl
dnl
dnl ------ scond while ( b a -- b a ) ---------
dnl
dnl = while
define({EQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    or    A             ; 1:4       = while BEGIN_STACK
    sbc  HL, DE         ; 2:15      = while BEGIN_STACK
    pop  HL             ; 1:10      = while BEGIN_STACK
    pop  DE             ; 1:10      = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      = while BEGIN_STACK})})dnl
dnl
dnl
dnl <> while
define({NE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    or    A             ; 1:4       <> while BEGIN_STACK
    sbc  HL, DE         ; 2:15      <> while BEGIN_STACK
    pop  HL             ; 1:10      <> while BEGIN_STACK
    pop  DE             ; 1:10      <> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      <> while BEGIN_STACK})})dnl
dnl
dnl
dnl < while
define({LT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       < while BEGIN_STACK    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       < while BEGIN_STACK
    xor   D             ; 1:4       < while BEGIN_STACK
    xor   H             ; 1:4       < while BEGIN_STACK
    pop  HL             ; 1:10      < while BEGIN_STACK
    pop  DE             ; 1:10      < while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      < while BEGIN_STACK})})dnl
dnl
dnl
dnl >= while
define({GE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       >= while BEGIN_STACK
    xor   D             ; 1:4       >= while BEGIN_STACK
    xor   H             ; 1:4       >= while BEGIN_STACK
    pop  HL             ; 1:10      >= while BEGIN_STACK
    pop  DE             ; 1:10      >= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      >= while BEGIN_STACK})})dnl
dnl
dnl
dnl <= while
define({LE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       <= while BEGIN_STACK
    xor   D             ; 1:4       <= while BEGIN_STACK
    xor   H             ; 1:4       <= while BEGIN_STACK
    pop  HL             ; 1:10      <= while BEGIN_STACK
    pop  DE             ; 1:10      <= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      <= while BEGIN_STACK})})dnl
dnl
dnl
dnl > while
define({GT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       > while BEGIN_STACK    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       > while BEGIN_STACK
    xor   D             ; 1:4       > while BEGIN_STACK
    xor   H             ; 1:4       > while BEGIN_STACK
    pop  HL             ; 1:10      > while BEGIN_STACK
    pop  DE             ; 1:10      > while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      > while BEGIN_STACK})})dnl
dnl
dnl
dnl
dnl ------ dup const ucond while ( b a -- b a ) ---------
dnl
define({DUP_PUSH_UEQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u= while BEGIN_STACK
    xor   L             ; 1:4       dup $1 u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 u= while BEGIN_STACK
    ld    A, high format({%-6s},$1); 2:7       dup $1 u= while BEGIN_STACK
    xor   H             ; 1:4       dup $1 u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 u= while BEGIN_STACK})})dnl
dnl
dnl
define({DUP_PUSH_UNE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u<> while BEGIN_STACK
    xor   L             ; 1:4       dup $1 u<> while BEGIN_STACK
    jr   nz, $+8        ; 2:7/12    dup $1 u<> while BEGIN_STACK
    ld    A, high format({%-6s},$1); 2:7       dup $1 u<> while BEGIN_STACK
    xor   H             ; 1:4       dup $1 u<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      dup $1 u<> while BEGIN_STACK})})dnl
dnl
dnl
define({DUP_PUSH_ULT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, L          ; 1:4       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
    ld    A, H          ; 1:4       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 u< while BEGIN_STACK})})dnl
dnl
dnl
define({DUP_PUSH_UGE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, L          ; 1:4       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
    sub   low format({%-10s},$1); 2:7       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
    ld    A, H          ; 1:4       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
    sbc   A, high format({%-6s},$1); 2:7       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 u>= while BEGIN_STACK})})dnl
dnl
dnl
define({DUP_PUSH_ULE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
    sub   L             ; 1:4       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
    sbc   A, H          ; 1:4       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 u<= while BEGIN_STACK})})dnl
dnl
dnl
define({DUP_PUSH_UGT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
    sub   L             ; 1:4       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
    ld    A, high format({%-6s},$1); 2:7       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
    sbc   A, H          ; 1:4       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 u> while BEGIN_STACK})})dnl
dnl
dnl
dnl ------ dup const scond while ( b a -- b a ) ---------
dnl
dnl dup const = while
define({DUP_PUSH_EQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, low format({%-7s},$1); 2:7       dup $1 = while BEGIN_STACK
    xor   L             ; 1:4       dup $1 = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 = while BEGIN_STACK
    ld    A, high format({%-6s},$1); 2:7       dup $1 = while BEGIN_STACK
    xor   H             ; 1:4       dup $1 = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup $1 = while BEGIN_STACK})})dnl
dnl
dnl
define({DUP_PUSH_NE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, low format({%-7s},$1); 2:7       dup $1 <> while BEGIN_STACK
    xor   L             ; 1:4       dup $1 <> while BEGIN_STACK
    jr   nz, $+8        ; 2:7/12    dup $1 <> while BEGIN_STACK
    ld    A, high format({%-6s},$1); 2:7       dup $1 <> while BEGIN_STACK
    xor   H             ; 1:4       dup $1 <> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      dup $1 <> while BEGIN_STACK})})dnl
dnl
dnl
dnl dup const < while
define({DUP_PUSH_LT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}index({$1},{(}),{0},{
__{}                       ;[14:58]     dup $1 < while BEGIN_STACK
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
__{}                       ;[11:40]     dup $1 < while BEGIN_STACK    ( x -- x )
__{}    ld    A, L          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    rra                 ; 1:4       dup $1 < while BEGIN_STACK    sign if true
__{}    xor   H             ; 1:4       dup $1 < while BEGIN_STACK
__{}  if (($1) & 0x8000)
__{}    jp    m, break101   ; 3:10      dup $1 < while 101    negative constant --> sign if false 
__{}  else
__{}    jp    p, break101   ; 3:10      dup $1 < while 101    positive constant --> no sign if false 
__{}  endif},
__{}_TYP_SINGLE,{sign_first},{ifelse(eval(($1) & 0x8000),{0},{
__{}__{}                     ;[13:20,47/47] dup $1 < while BEGIN_STACK    ( x -- x )   # sign_first version, changes using "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK
__{}__{}    add   A, A          ; 1:4       dup $1 < while BEGIN_STACK
__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 < while BEGIN_STACK    negative HL < positive constant ---> true},
__{}__{}{
__{}__{}                     ;[14:50/18,50] dup $1 < while BEGIN_STACK    ( x -- x )   # sign_first version, changes using "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK
__{}__{}    add   A, A          ; 1:4       dup $1 < while BEGIN_STACK
__{}__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK    positive HL < negative constant ---> false})
__{}    ld    A, L          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK},
__{}{
__{}                       ;[11:40]     dup $1 < while BEGIN_STACK    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
__{}    ld    A, L          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 < while BEGIN_STACK    HL<$1 --> HL-$1<0 --> carry if true
__{}    rra                 ; 1:4       dup $1 < while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 < while BEGIN_STACK    invert sign if x is negative
__{}__{}ifelse(eval(($1) & 0x8000),{0},{dnl
__{}__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK    positive constant --> no sign if false},
__{}__{}{dnl
__{}__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK    negative constant --> sign if false})})})dnl
dnl
dnl
dnl dup const >= while
define({DUP_PUSH_GE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}index({$1},{(}),{0},{
__{}                       ;[14:58]     dup $1 >= while BEGIN_STACK
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
__{}                       ;[11:40]     dup $1 >= while BEGIN_STACK    ( x -- x )
__{}    ld    A, L          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    rra                 ; 1:4       dup $1 >= while BEGIN_STACK    no sign if true
__{}    xor   H             ; 1:4       dup $1 >= while BEGIN_STACK
__{}  if (($1) & 0x8000)
__{}    jp    p, break101   ; 3:10      dup $1 >= while 101    negative constant --> no sign if false 
__{}  else
__{}    jp    m, break101   ; 3:10      dup $1 >= while 101    positive constant --> sign if false 
__{}  endif},
__{}_TYP_SINGLE,{sign_first},{ifelse(eval(($1) & 0x8000),{0},{
__{}__{}                     ;[14:50/18,50] dup $1 >= while BEGIN_STACK    ( x -- x )   # sign_first version, changes using "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK
__{}__{}    add   A, A          ; 1:4       dup $1 >= while BEGIN_STACK
__{}__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK    negative HL >= positive constant ---> false},
__{}__{}{
__{}__{}                     ;[13:20,47/47] dup $1 >= while BEGIN_STACK    ( x -- x )   # sign_first version, changes using "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK
__{}__{}    add   A, A          ; 1:4       dup $1 >= while BEGIN_STACK
__{}__{}    jr   nc, $+11       ; 2:7/11    dup $1 >= while BEGIN_STACK    positive HL >= negative constant ---> true})
__{}    ld    A, L          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK},
__{}{
__{}                       ;[11:40]     dup $1 >= while BEGIN_STACK    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
__{}    ld    A, L          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> no carry if true
__{}    sub   low format({%-10s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> no carry if true
__{}    ld    A, H          ; 1:4       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> no carry if true
__{}    sbc   A, high format({%-6s},$1); 2:7       dup $1 >= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> no carry if true
__{}    rra                 ; 1:4       dup $1 >= while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 >= while BEGIN_STACK    invert sign if x is negative
__{}__{}ifelse(eval(($1) & 0x8000),{0},{dnl
__{}__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK    positive constant --> sign if false},
__{}__{}{dnl
__{}__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 >= while BEGIN_STACK    negative constant --> no sign if false})})})dnl
dnl
dnl
dnl dup const <= while
define({DUP_PUSH_LE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}index({$1},{(}),{0},{
__{}                       ;[14:58]     dup $1 <= while BEGIN_STACK
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
__{}                       ;[11:40]     dup $1 <= while BEGIN_STACK    ( x -- x )
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sub   L             ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    rra                 ; 1:4       dup $1 <= while BEGIN_STACK    no sign if true
__{}    xor   H             ; 1:4       dup $1 <= while BEGIN_STACK
__{}  if (($1) & 0x8000)
__{}    jp    p, break101   ; 3:10      dup $1 <= while 101    negative constant --> no sign if false 
__{}  else
__{}    jp    m, break101   ; 3:10      dup $1 <= while 101    positive constant --> sign if false 
__{}  endif},
__{}_TYP_SINGLE,{sign_first},{ifelse(eval(($1) & 0x8000),{0},{
__{}__{}                     ;[13:20,47/47] dup $1 <= while BEGIN_STACK    ( x -- x )   # sign_first version, changes using "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, H          ; 1:4       dup $1 <= while BEGIN_STACK
__{}__{}    add   A, A          ; 1:4       dup $1 <= while BEGIN_STACK
__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 <= while BEGIN_STACK    negative HL <= positive constant ---> true},
__{}__{}{
__{}__{}                     ;[14:50/18,50] dup $1 <= while BEGIN_STACK    ( x -- x )   # sign_first version, changes using "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, H          ; 1:4       dup $1 <= while BEGIN_STACK
__{}__{}    add   A, A          ; 1:4       dup $1 <= while BEGIN_STACK
__{}__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK    positive HL <= negative constant ---> false})
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sub   L             ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK},
__{}{
__{}                       ;[11:40]     dup $1 <= while BEGIN_STACK    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sub   L             ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 <= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    rra                 ; 1:4       dup $1 <= while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 <= while BEGIN_STACK    invert sign if x is negative
__{}__{}ifelse(eval(($1) & 0x8000),{0},{dnl
__{}__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK    positive constant --> sign if false},
__{}__{}{dnl
__{}__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 <= while BEGIN_STACK    negative constant --> no sign if false})})})dnl
dnl
dnl
dnl dup const > while
define({DUP_PUSH_GT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}.error {$0} for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}index({$1},{(}),{0},{
__{}                       ;[14:58]     dup $1 > while BEGIN_STACK
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
__{}                       ;[11:40]     dup $1 > while BEGIN_STACK    ( x -- x )
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sub   L             ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    rra                 ; 1:4       dup $1 > while BEGIN_STACK    sign if true
__{}    xor   H             ; 1:4       dup $1 > while BEGIN_STACK
__{}  if (($1) & 0x8000)
__{}    jp    m, break101   ; 3:10      dup $1 > while 101    negative constant --> sign if false 
__{}  else
__{}    jp    p, break101   ; 3:10      dup $1 > while 101    positive constant --> no sign if false 
__{}  endif},
__{}_TYP_SINGLE,{sign_first},{ifelse(eval(($1) & 0x8000),{0},{
__{}__{}                     ;[14:50/18,50] dup $1 > while BEGIN_STACK    ( x -- x )   # sign_first version, changes using "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, H          ; 1:4       dup $1 > while BEGIN_STACK
__{}__{}    add   A, A          ; 1:4       dup $1 > while BEGIN_STACK
__{}__{}    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 > while BEGIN_STACK    negative HL > positive constant ---> false},
__{}__{}{
__{}__{}                     ;[13:20,47/47] dup $1 > while BEGIN_STACK    ( x -- x )   # sign_first version, changes using "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, H          ; 1:4       dup $1 > while BEGIN_STACK
__{}__{}    add   A, A          ; 1:4       dup $1 > while BEGIN_STACK
__{}__{}    jr   nc, $+11       ; 2:7/12    dup $1 > while BEGIN_STACK    positive HL > negative constant ---> true})
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sub   L             ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 < while BEGIN_STACK},
__{}{
__{}                       ;[11:40]     dup $1 > while BEGIN_STACK    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
__{}    ld    A, low format({%-7s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sub   L             ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    ld    A, high format({%-6s},$1); 2:7       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 > while BEGIN_STACK    HL>$1 --> 0>$1-HL --> carry if true
__{}    rra                 ; 1:4       dup $1 > while BEGIN_STACK
__{}    xor   H             ; 1:4       dup $1 > while BEGIN_STACK    invert sign if x is negative
__{}__{}ifelse(eval(($1) & 0x8000),{0},{dnl
__{}__{}    jp    p, break{}BEGIN_STACK   ; 3:10      dup $1 > while BEGIN_STACK    positive constant --> no sign if false},
__{}__{}{dnl
__{}__{}    jp    m, break{}BEGIN_STACK   ; 3:10      dup $1 > while BEGIN_STACK    negative constant --> sign if false})})})dnl
dnl
dnl
dnl
dnl ----------------------- 32 bit -----------------------
dnl ------ signed_32_bit_cond while ( d2 d1 -- ) ---------
dnl
dnl D= while
define({DEQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
                       ;[14:91]     D= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D= while BEGIN_STACK   lo_2
    or    A             ; 1:4       D= while BEGIN_STACK
    sbc  HL, BC         ; 2:15      D= while BEGIN_STACK   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      D= while BEGIN_STACK   hi_2
    jr   nz, $+4        ; 2:7/12    D= while BEGIN_STACK
    sbc  HL, DE         ; 2:15      D= while BEGIN_STACK   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= while BEGIN_STACK
    pop  DE             ; 1:10      D= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      D= while BEGIN_STACK})})dnl
dnl
dnl
dnl D<> while
define({DNE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
                       ;[14:91]     D<> while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> while BEGIN_STACK   lo_2
    or    A             ; 1:4       D<> while BEGIN_STACK
    sbc  HL, BC         ; 2:15      D<> while BEGIN_STACK   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      D<> while BEGIN_STACK   hi_2
    jr   nz, $+4        ; 2:7/12    D<> while BEGIN_STACK
    sbc  HL, DE         ; 2:15      D<> while BEGIN_STACK   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> while BEGIN_STACK
    pop  DE             ; 1:10      D<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      D<> while BEGIN_STACK})})dnl
dnl
dnl
dnl D< while
define({DLT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
__{}ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes})){}dnl
                       ;[10:67]     D< while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D< while BEGIN_STACK   l2
    pop  AF             ; 1:10      D< while BEGIN_STACK   h2
    call FCE_DLT        ; 3:17      D< while BEGIN_STACK   carry if true
    pop  HL             ; 1:10      D< while BEGIN_STACK
    pop  DE             ; 1:10      D< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      D< while BEGIN_STACK})})dnl
dnl
dnl
dnl D>= while
define({DGE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
__{}ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes})){}dnl
                       ;[10:67]     D>= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D>= while BEGIN_STACK   l2
    pop  AF             ; 1:10      D>= while BEGIN_STACK   h2
    call FCE_DLT        ; 3:17      D>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    pop  HL             ; 1:10      D>= while BEGIN_STACK
    pop  DE             ; 1:10      D>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      D>= while BEGIN_STACK})})dnl
dnl
dnl
dnl D<= while
define({DLE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
__{}ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes})){}dnl
                       ;[10:67]     D<= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D<= while BEGIN_STACK   l2
    pop  AF             ; 1:10      D<= while BEGIN_STACK   h2
    call FCE_DGT        ; 3:17      D<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    pop  HL             ; 1:10      D<= while BEGIN_STACK
    pop  DE             ; 1:10      D<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      D<= while BEGIN_STACK})})dnl
dnl
dnl
dnl D> while
define({DGT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
__{}ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes})){}dnl
                       ;[10:67]     D> while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D> while BEGIN_STACK   l2
    pop  AF             ; 1:10      D> while BEGIN_STACK   h2
    call FCE_DGT        ; 3:17      D> while BEGIN_STACK   carry if true
    pop  HL             ; 1:10      D> while BEGIN_STACK
    pop  DE             ; 1:10      D> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      D> while BEGIN_STACK})})dnl
dnl
dnl
dnl
dnl ----------------------- 32 bit -----------------------
dnl ------ unsigned_32_bit_cond while ( ud2 ud1 -- ) ---------
dnl
dnl Du= while
define({DUEQ_WHILE},{DEQ_WHILE}){}dnl
dnl
dnl
dnl Du<> while
define({DUNE_WHILE},{DNE_WHILE}){}dnl
dnl
dnl
dnl Du< while
define({DULT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:67]     Du< while BEGIN_STACK   ( ud2 ud1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du< while BEGIN_STACK   l2
    pop  AF             ; 1:10      Du< while BEGIN_STACK   h2
    call FCE_DULT       ; 3:17      Du< while BEGIN_STACK   carry if true
    pop  HL             ; 1:10      Du< while BEGIN_STACK
    pop  DE             ; 1:10      Du< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      Du< while BEGIN_STACK},
{
                       ;[13:81]     Du< while BEGIN_STACK   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du< while BEGIN_STACK   lo_2
    ld    A, C          ; 1:4       Du< while BEGIN_STACK   d2<d1 --> d2-d1<0 --> (SP)BC-DEHL<0 --> carry if true
    sub   L             ; 1:4       Du< while BEGIN_STACK   C-L<0 --> carry if true
    ld    A, B          ; 1:4       Du< while BEGIN_STACK
    sbc   A, H          ; 1:4       Du< while BEGIN_STACK   B-H<0 --> carry if true
    pop  HL             ; 1:10      Du< while BEGIN_STACK   hi_2
    sbc  HL, DE         ; 2:15      Du< while BEGIN_STACK   HL-DE<0 --> carry if true
    pop  HL             ; 1:10      Du< while BEGIN_STACK
    pop  DE             ; 1:10      Du< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      Du< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl Du>= while
define({DUGE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:67]     Du>= while BEGIN_STACK   ( ud2 ud1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du>= while BEGIN_STACK   l2
    pop  AF             ; 1:10      Du>= while BEGIN_STACK   h2
    call FCE_DULT       ; 3:17      Du>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    pop  HL             ; 1:10      Du>= while BEGIN_STACK
    pop  DE             ; 1:10      Du>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      Du>= while BEGIN_STACK},
{
                       ;[13:81]     Du>= while BEGIN_STACK   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du>= while BEGIN_STACK   lo_2
    ld    A, C          ; 1:4       Du>= while BEGIN_STACK   d2>=d1 --> d2-d1>=0 --> (SP)BC-DEHL>=0 --> no carry if true
    sub   L             ; 1:4       Du>= while BEGIN_STACK   C-L>=0 --> no carry if true
    ld    A, B          ; 1:4       Du>= while BEGIN_STACK
    sbc   A, H          ; 1:4       Du>= while BEGIN_STACK   B-H>=0 --> no carry if true
    pop  HL             ; 1:10      Du>= while BEGIN_STACK   hi_2
    sbc  HL, DE         ; 2:15      Du>= while BEGIN_STACK   HL-DE>=0 --> no carry if true
    pop  HL             ; 1:10      Du>= while BEGIN_STACK
    pop  DE             ; 1:10      Du>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      Du>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl Du<= while
define({DULE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:67]     Du<= while BEGIN_STACK   ( ud2 ud1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du<= while BEGIN_STACK   l2
    pop  AF             ; 1:10      Du<= while BEGIN_STACK   h2
    call FCE_DUGT       ; 3:17      Du<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    pop  HL             ; 1:10      Du<= while BEGIN_STACK
    pop  DE             ; 1:10      Du<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      Du<= while BEGIN_STACK},
{
                       ;[13:88]     Du<= while BEGIN_STACK   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du<= while BEGIN_STACK   lo_2
    or    A             ; 1:4       Du<= while BEGIN_STACK
    sbc  HL, BC         ; 2:15      Du<= while BEGIN_STACK   ud2<=ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> no carry if true
    pop  BC             ; 1:10      Du<= while BEGIN_STACK   hi_2
    ex   DE, HL         ; 1:4       Du<= while BEGIN_STACK
    sbc  HL, BC         ; 2:15      Du<= while BEGIN_STACK   hi_2<=hi_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  HL             ; 1:10      Du<= while BEGIN_STACK
    pop  DE             ; 1:10      Du<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      Du<= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl Du> while
define({DUGT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:67]     Du> while BEGIN_STACK   ( ud2 ud1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du> while BEGIN_STACK   l2
    pop  AF             ; 1:10      Du> while BEGIN_STACK   h2
    call FCE_DUGT       ; 3:17      Du> while BEGIN_STACK   carry if true
    pop  HL             ; 1:10      Du> while BEGIN_STACK
    pop  DE             ; 1:10      Du> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      Du> while BEGIN_STACK},
{
                       ;[13:88]     Du> while BEGIN_STACK   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du> while BEGIN_STACK   lo_2
    or    A             ; 1:4       Du> while BEGIN_STACK
    sbc  HL, BC         ; 2:15      Du> while BEGIN_STACK   ud2>ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> carry if true
    pop  BC             ; 1:10      Du> while BEGIN_STACK   hi_2
    ex   DE, HL         ; 1:4       Du> while BEGIN_STACK
    sbc  HL, BC         ; 2:15      Du> while BEGIN_STACK   hi_2>hi_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  HL             ; 1:10      Du> while BEGIN_STACK
    pop  DE             ; 1:10      Du> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      Du> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl ----- 4dup signed_32_bit_cond while ( d2 d1 -- d2 d1 ) -----
dnl
dnl
dnl 4dup D= while
define({_4DUP_DEQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DEQ},,define({USE_FCE_DEQ},{yes}))
                       ;[10:69]     4dup D= while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup D= while BEGIN_STACK
    pop  AF             ; 1:10      4dup D= while BEGIN_STACK
    push AF             ; 1:11      4dup D= while BEGIN_STACK
    push BC             ; 1:11      4dup D= while BEGIN_STACK
    call FCE_DEQ        ; 3:17      4dup D= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      4dup D= while BEGIN_STACK},
{
                   ;[16:132/73,132] 4dup D= while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= while BEGIN_STACK   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= while BEGIN_STACK   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= while BEGIN_STACK   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= while BEGIN_STACK   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= while BEGIN_STACK   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= while BEGIN_STACK   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= while BEGIN_STACK   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= while BEGIN_STACK   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= while BEGIN_STACK   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= while BEGIN_STACK   h2 l2 . h1 l1
    jp   nz, break{}BEGIN_STACK   ; 3:10      4dup D= while BEGIN_STACK   h2 l2 . h1 l1})})dnl
dnl
dnl
dnl
dnl 4dup D<> while
define({_4DUP_DNE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DEQ},,define({USE_FCE_DEQ},{yes}))
                       ;[10:69]     4dup D<> while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{function})" version can be changed with small,fast,default
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK
    pop  AF             ; 1:10      4dup D<> while BEGIN_STACK
    push AF             ; 1:11      4dup D<> while BEGIN_STACK
    push BC             ; 1:11      4dup D<> while BEGIN_STACK
    call FCE_DEQ        ; 3:17      4dup D<> while BEGIN_STACK   D= zero if true --> D<> zero if false
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK},
_TYP_DOUBLE,{small},{
                   ;[16:73,132/132] 4dup D<> while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{small})" version can be changed with function,fast,default
    or   A              ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D<> while BEGIN_STACK   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D<> while BEGIN_STACK   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D<> while BEGIN_STACK   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D<> while BEGIN_STACK   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D<> while BEGIN_STACK   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D<> while BEGIN_STACK   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D<> while BEGIN_STACK   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2 . h1 l1
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK   h2 l2 . h1 l1},
_TYP_DOUBLE,{fast},{
            ;[23:41,56,113,126/126] 4dup D<> while BEGIN_STACK  ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{fast})" version can be changed with function,small,default
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
            ;[21:51,66,123,122/122] 4dup D<> while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast
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
define({_4DUP_DLT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                       ;[10:69]     4dup D< while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D< while BEGIN_STACK
    pop  AF             ; 1:10      4dup D< while BEGIN_STACK
    push AF             ; 1:11      4dup D< while BEGIN_STACK
    push BC             ; 1:11      4dup D< while BEGIN_STACK
    call FCE_DLT        ; 3:17      4dup D< while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D< while BEGIN_STACK},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:27]     4dup D< while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup D>= while
define({_4DUP_DGE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                       ;[10:69]     4dup D>= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D>= while BEGIN_STACK
    pop  AF             ; 1:10      4dup D>= while BEGIN_STACK
    push AF             ; 1:11      4dup D>= while BEGIN_STACK
    push BC             ; 1:11      4dup D>= while BEGIN_STACK
    call FCE_DLT        ; 3:17      4dup D>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup D>= while BEGIN_STACK},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:27]     4dup D>= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup D>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup D<= while
define({_4DUP_DLE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:69]     4dup D<= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D<= while BEGIN_STACK
    pop  AF             ; 1:10      4dup D<= while BEGIN_STACK
    push AF             ; 1:11      4dup D<= while BEGIN_STACK
    push BC             ; 1:11      4dup D<= while BEGIN_STACK
    call FCE_DGT        ; 3:17      4dup D<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup D<= while BEGIN_STACK},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:27]     4dup D<= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup D<= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup D> while
define({_4DUP_DGT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:69]     4dup D> while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D> while BEGIN_STACK
    pop  AF             ; 1:10      4dup D> while BEGIN_STACK
    push AF             ; 1:11      4dup D> while BEGIN_STACK
    push BC             ; 1:11      4dup D> while BEGIN_STACK
    call FCE_DGT        ; 3:17      4dup D> while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D> while BEGIN_STACK},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:27]     4dup D> while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl ----- 4dup unsigned_32_bit_cond while ( ud2 ud1 -- ud2 ud1 ) -----
dnl
dnl
dnl 4dup Du= while
define({_4DUP_DUEQ_WHILE},{_4DUP_DEQ_WHILE}){}dnl
dnl
dnl
dnl
dnl 4dup Du<> while
define({_4DUP_DUNE_WHILE},{_4DUP_DNE_WHILE}){}dnl
dnl
dnl
dnl
dnl 4dup Du< while
define({_4DUP_DULT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:69]     4dup Du< while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du< while BEGIN_STACK
    pop  AF             ; 1:10      4dup Du< while BEGIN_STACK
    push AF             ; 1:11      4dup Du< while BEGIN_STACK
    push BC             ; 1:11      4dup Du< while BEGIN_STACK
    call FCE_DULT       ; 3:17      4dup Du< while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup Du< while BEGIN_STACK},
{
                       ;[15:101]    4dup Du< while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du< while BEGIN_STACK   ud2 < ud1 --> ud2-ud1<0 --> (SP)BC-DEHL<0 --> carry if true
    ld    A, C          ; 1:4       4dup Du< while BEGIN_STACK
    sub   L             ; 1:4       4dup Du< while BEGIN_STACK   C-L<0 --> carry if true
    ld    A, B          ; 1:4       4dup Du< while BEGIN_STACK
    sbc   A, H          ; 1:4       4dup Du< while BEGIN_STACK   B-H<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< while BEGIN_STACK   HL = hi2
    ld    A, L          ; 1:4       4dup Du< while BEGIN_STACK   HLBC-DE(SP)<0 -- carry if true
    sbc   A, E          ; 1:4       4dup Du< while BEGIN_STACK   L-E<0 --> carry if true
    ld    A, H          ; 1:4       4dup Du< while BEGIN_STACK
    sbc   A, D          ; 1:4       4dup Du< while BEGIN_STACK   H-D<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< while BEGIN_STACK
    push BC             ; 1:11      4dup Du< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup Du< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup Du>= while
define({_4DUP_DUGE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:69]     4dup Du>= while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du>= while BEGIN_STACK
    pop  AF             ; 1:10      4dup Du>= while BEGIN_STACK
    push AF             ; 1:11      4dup Du>= while BEGIN_STACK
    push BC             ; 1:11      4dup Du>= while BEGIN_STACK
    call FCE_DULT       ; 3:17      4dup Du>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup Du>= while BEGIN_STACK},
{
                       ;[15:101]    4dup Du>= while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du>= while BEGIN_STACK   ud2 >= ud1 --> ud2-ud1>=0 --> (SP)BC-DEHL>=0 --> no carry if true
    ld    A, C          ; 1:4       4dup Du>= while BEGIN_STACK
    sub   L             ; 1:4       4dup Du>= while BEGIN_STACK   C-L>=0 --> no carry if true
    ld    A, B          ; 1:4       4dup Du>= while BEGIN_STACK
    sbc   A, H          ; 1:4       4dup Du>= while BEGIN_STACK   B-H>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= while BEGIN_STACK   HL = hi2
    ld    A, L          ; 1:4       4dup Du>= while BEGIN_STACK   HLBC-DE(SP)>=0 -- no carry if true
    sbc   A, E          ; 1:4       4dup Du>= while BEGIN_STACK   L-E>=0 --> no carry if true
    ld    A, H          ; 1:4       4dup Du>= while BEGIN_STACK
    sbc   A, D          ; 1:4       4dup Du>= while BEGIN_STACK   H-D>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= while BEGIN_STACK
    push BC             ; 1:11      4dup Du>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup Du>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup Du<= while
define({_4DUP_DULE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:69]     4dup Du<= while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du<= while BEGIN_STACK
    pop  AF             ; 1:10      4dup Du<= while BEGIN_STACK
    push AF             ; 1:11      4dup Du<= while BEGIN_STACK
    push BC             ; 1:11      4dup Du<= while BEGIN_STACK
    call FCE_DUGT       ; 3:17      4dup Du<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup Du<= while BEGIN_STACK},
{
                       ;[15:101]    4dup Du<= while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du<= while BEGIN_STACK   ud2 <= ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> no carry if true
    ld    A, L          ; 1:4       4dup Du<= while BEGIN_STACK
    sub   C             ; 1:4       4dup Du<= while BEGIN_STACK   0<=L-C --> no carry if true
    ld    A, H          ; 1:4       4dup Du<= while BEGIN_STACK
    sbc   A, B          ; 1:4       4dup Du<= while BEGIN_STACK   0<=H-B --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= while BEGIN_STACK   HL = hi2
    ld    A, E          ; 1:4       4dup Du<= while BEGIN_STACK   0<=DE(SP)-HLBC -- no carry if true
    sbc   A, L          ; 1:4       4dup Du<= while BEGIN_STACK   0<=E-L --> no carry if true
    ld    A, D          ; 1:4       4dup Du<= while BEGIN_STACK
    sbc   A, H          ; 1:4       4dup Du<= while BEGIN_STACK   0<=D-H --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= while BEGIN_STACK
    push BC             ; 1:11      4dup Du<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup Du<= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 4dup Du> while
define({_4DUP_DUGT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:69]     4dup Du> while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du> while BEGIN_STACK
    pop  AF             ; 1:10      4dup Du> while BEGIN_STACK
    push AF             ; 1:11      4dup Du> while BEGIN_STACK
    push BC             ; 1:11      4dup Du> while BEGIN_STACK
    call FCE_DUGT       ; 3:17      4dup Du> while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup Du> while BEGIN_STACK},
{
                       ;[15:101]    4dup Du> while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du> while BEGIN_STACK   ud2 > ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> carry if true
    ld    A, L          ; 1:4       4dup Du> while BEGIN_STACK
    sub   C             ; 1:4       4dup Du> while BEGIN_STACK   0>L-C --> carry if true
    ld    A, H          ; 1:4       4dup Du> while BEGIN_STACK
    sbc   A, B          ; 1:4       4dup Du> while BEGIN_STACK   0>H-B --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> while BEGIN_STACK   HL = hi2
    ld    A, E          ; 1:4       4dup Du> while BEGIN_STACK   0>DE(SP)-HLBC -- carry if true
    sbc   A, L          ; 1:4       4dup Du> while BEGIN_STACK   0>E-L --> carry if true
    ld    A, D          ; 1:4       4dup Du> while BEGIN_STACK
    sbc   A, H          ; 1:4       4dup Du> while BEGIN_STACK   0>D-H --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> while BEGIN_STACK
    push BC             ; 1:11      4dup Du> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup Du> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl
dnl +============================ 32 bit ===============================+
dnl |        2dup pushdot signed_32_bit_cond while ( ud1 -- ud1 )       |
dnl +===================================================================+
dnl
dnl
dnl
dnl 2dup 0 0 D= while
dnl 2dup 0. D= while
dnl 2dup D0= while
dnl ( d -- d )
define({_2DUP_D0EQ_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       2dup D0= while BEGIN_STACK  ( d -- d )
    or    L             ; 1:4       2dup D0= while BEGIN_STACK
    or    D             ; 1:4       2dup D0= while BEGIN_STACK
    or    E             ; 1:4       2dup D0= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup D0= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 2dup 0 0 D<> while
dnl 2dup 0. D<> while
dnl 2dup D0<> while
dnl ( d -- d )
define({_2DUP_D0NE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       2dup D0<> while BEGIN_STACK  ( d -- d )
    or    L             ; 1:4       2dup D0<> while BEGIN_STACK
    or    D             ; 1:4       2dup D0<> while BEGIN_STACK
    or    E             ; 1:4       2dup D0<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup D0<> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl 2dup 0 0 D< while
dnl 2dup 0. D< while
dnl 2dup D0< while
dnl ( d -- d )
define({_2DUP_D0LT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    bit   7, D          ; 2:8       2dup D0< while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup D0< while BEGIN_STACK})})dnl
dnl
dnl
dnl
dnl 2dup 0 0 D>= while
dnl 2dup 0. D>= while
dnl 2dup D0>= while
dnl ( d -- d )
define({_2DUP_D0GE_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0} for non-existent {BEGIN}},
{
    bit   7, D          ; 2:8       2dup D0>= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup D0>= while BEGIN_STACK})})dnl
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
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}    .error {$0} for non-existent {BEGIN}},
__{}$1,{},{
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
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}    .error {$0} for non-existent {BEGIN}},
__{}$1,{},{
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
dnl 2dup D. D< while
define({_2DUP_PUSHDOT_DLT_WHILE},{ifelse(BEGIN_STACK,{BEGIN_STACK},{
    .error {$0} for non-existent {BEGIN}},
index({$1},{(}),{0},{
                        ;[22:92]    2dup $1 > while BEGIN_STACK    ( d1 -- d1 )   # version with constant address
    ld    A,format({%-12s}, $1); 3:13      2dup $1 > while BEGIN_STACK
    sub   L             ; 1:4       2dup $1 > while BEGIN_STACK    L>(addr+0) --> 0>A-L --> carry if true
    ld    A,format({%-12s},(1+$1)); 3:13      2dup $1 > while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup $1 > while BEGIN_STACK    H>(addr+1) --> 0>A-H --> carry if true
    ld   BC,format({%-12s},(2+$1)); 4:20      2dup $1 > while BEGIN_STACK
    ld    A, C          ; 1:4       2dup $1 > while BEGIN_STACK
    sbc   A, E          ; 1:4       2dup $1 > while BEGIN_STACK    E>(addr+2) --> 0>A-E --> carry if true
    ld    A, B          ; 1:4       2dup $1 > while BEGIN_STACK
    sbc   A, D          ; 1:4       2dup $1 > while BEGIN_STACK    D>(addr+3) --> 0>A-D --> carry if true
    rra                 ; 1:4       2dup $1 > while BEGIN_STACK    carry --> sign if true
    xor   D             ; 1:4       2dup $1 > while BEGIN_STACK    invert signs if negative d1
    xor   B             ; 1:4       2dup $1 > while BEGIN_STACK    invert signs if negative constant
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK    no sign --> false},

_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:69]     2dup D> while BEGIN_STACK   ( d1 -- d1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})" or small
    pop  BC             ; 1:10      2dup D> while BEGIN_STACK
    pop  AF             ; 1:10      2dup D> while BEGIN_STACK
    push AF             ; 1:11      2dup D> while BEGIN_STACK
    push BC             ; 1:11      2dup D> while BEGIN_STACK
    call FCE_DGT        ; 3:17      2dup D> while BEGIN_STACK   carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup Du< while BEGIN_STACK},
_TYP_DOUBLE,{small},{
                        ;[17:62]    2dup $1 > while BEGIN_STACK    ( d1 -- d1 )   # small version can be changed with "define({_TYP_DOUBLE},{function})" or default
    ld    A, format({0x%02x},eval(($1) & 0xFF))       ; 2:7       2dup $1 > while BEGIN_STACK    DEHL>format({0x%08x},eval($1))
    sub   L             ; 1:4       2dup $1 > while BEGIN_STACK    L>A --> A-L<0 --> carry if true
    ld    A, format({0x%02x},eval((($1)>>8) & 0xFF))       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup $1 > while BEGIN_STACK    H>A --> A-H<0 --> carry if true
    ld    A, format({0x%02x},eval((($1)>>16) & 0xFF))       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, E          ; 1:4       2dup $1 > while BEGIN_STACK    E>A --> A-E<0 --> carry if true
    ld    A, format({0x%02x},eval((($1)>>24) & 0xFF))       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, D          ; 1:4       2dup $1 > while BEGIN_STACK    D>A --> A-D<0 --> carry if true
    rra                 ; 1:4       2dup $1 > while BEGIN_STACK    carry --> sign if true
    xor   D             ; 1:4       2dup $1 > while BEGIN_STACK    invert signs if negative d1
__{}ifelse(eval(($1)&0x80000000),0,{dnl
__{}    jp    p, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK    positive constant --> no sign if false},
__{}{dnl
__{}    jp    m, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK    negative constant --> sign if false})},
{
__{}ifelse(eval(($1)&0x80000000),0,{dnl
__{}                     ;[20:72/18,72] 2dup $1 > while BEGIN_STACK    ( d1 -- d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})" or small
__{}    ld    A, D          ; 1:4       2dup $1 > while BEGIN_STACK    DEHL>format({0x%08x},eval($1))
__{}    add   A, A          ; 1:4       2dup $1 > while BEGIN_STACK    check d1 signs
__{}    jp    c, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK    different signs --> negative d1 --> false},
__{}{dnl
__{}                     ;[19:20,69/69] 2dup $1 > while BEGIN_STACK    ( d1 -- d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})" or small
__{}    ld    A, D          ; 1:4       2dup $1 > while BEGIN_STACK    DEHL>format({0x%08x},eval($1))
__{}    add   A, A          ; 1:4       2dup $1 > while BEGIN_STACK    check d1 signs
__{}    jr   nc, $+17       ; 2:7/12    2dup $1 > while BEGIN_STACK    different signs --> positive d1 --> true})
    ld    A, format({0x%02x},eval(($1) & 0xFF))       ; 2:7       2dup $1 > while BEGIN_STACK
    sub   L             ; 1:4       2dup $1 > while BEGIN_STACK    L>A --> A-L<0 --> carry if true
    ld    A, format({0x%02x},eval((($1)>>8) & 0xFF))       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup $1 > while BEGIN_STACK    H>A --> A-H<0 --> carry if true
    ld    A, format({0x%02x},eval((($1)>>16) & 0xFF))       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, E          ; 1:4       2dup $1 > while BEGIN_STACK    E>A --> A-E<0 --> carry if true
    ld    A, format({0x%02x},eval((($1)>>24) & 0xFF))       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, D          ; 1:4       2dup $1 > while BEGIN_STACK    D>A --> A-D<0 --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl

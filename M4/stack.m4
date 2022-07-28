dnl ## Stack manipulation
dnl
dnl # ( b a -- a b )
dnl # prohodi vrchol zasobniku s druhou polozkou
define({SWAP},{
    ex   DE, HL         ; 1:4       swap ( b a -- a b )})dnl
dnl
dnl
dnl # ( b a -- a b a )
define({SWAP_OVER},{
    push HL             ; 1:11      swap_over ( b a -- a b a )})dnl
dnl
dnl
dnl # swap 3
dnl # ( b a -- a b 3 )
define({SWAP_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push HL             ; 1:11      swap $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      swap $1 ( b a -- a b $1 )})dnl
dnl
dnl
dnl # 3 swap
dnl # ( a -- 3 a )
define({PUSH_SWAP},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 swap
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 swap ( a -- $1 a )})dnl
dnl
dnl
dnl # swap drop 3 swap
dnl # ( b a -- 3 a )
define({SWAP_DROP_PUSH_SWAP},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      swap drop $1 swap ( b a -- $1 a )})dnl
dnl
dnl
dnl # nip 3 swap
dnl # ( b a -- 3 a )
define({NIP_PUSH_SWAP},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      nip $1 swap ( b a -- $1 a )})dnl
dnl
dnl
dnl # ( d c b a -- b a d c )
dnl # Exchange the top two cell pairs.
define({_2SWAP},{ifelse(TYP_2SWAP,{fast},{
                        ;[7:56]     2swap ( d c b a -- b a d c ) # fast version can be changed with "define({TYP_2SWAP},{name})", name=default
    ex   DE, HL         ; 1:4       2swap d c . a b
    pop  BC             ; 1:10      2swap d   . a b     BC = c
    ex  (SP), HL        ; 1:19      2swap b   . a d
    ex   DE, HL         ; 1:4       2swap b   . d a
    push HL             ; 1:11      2swap b a . d a
    ld    L, C          ; 1:4       2swap
    ld    H, B          ; 1:4       2swap b a . d c},
{
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c})}){}dnl
dnl
dnl
dnl # ( a -- a a )
dnl # vytvori kopii vrcholu zasobniku
define({DUP},{
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )})dnl
dnl
dnl
dnl # ( a -- a a a )
dnl # vytvori 2x kopii vrcholu zasobniku
define({DUP_DUP},{
    push DE             ; 1:11      dup dup ( a -- a a a )
    push HL             ; 1:11      dup dup
    ld    D, H          ; 1:4       dup dup
    ld    E, L          ; 1:4       dup dup})dnl
dnl
dnl
dnl # ?dup
dnl # ( a -- a a ) or ( 0 -- 0 )
dnl # vytvori kopii vrcholu zasobniku pokud je nenulovy
define({QUESTIONDUP},{
    ld    A, H          ; 1:4       ?dup
    or    L             ; 1:4       ?dup
    jr    z, $+5        ; 2:7/12    ?dup
    push DE             ; 1:11      ?dup
    ld    D, H          ; 1:4       ?dup
    ld    E, L          ; 1:4       ?dup ( a -- 0 | a a )})dnl
dnl
dnl
dnl # 2dup
dnl # ( b a -- b a b a )
dnl # over over
define({_2DUP},{
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a )})dnl
dnl
dnl
dnl # 3dup
dnl # ( c b a -- c b a c b a )
dnl # 2 pick 2 pick 2 pick
define({_3DUP},{
                        ;[5:54]     3dup   ( c b a -- c b a c b a )
    pop  AF             ; 1:10      3dup   . . . . b a
    push AF             ; 1:11      3dup   c . . . b a
    push DE             ; 1:11      3dup   c b . . b a
    push HL             ; 1:11      3dup   c b a . b a
    push AF             ; 1:11      3dup   c b a c b a})dnl
dnl
dnl
dnl # 4dup
dnl # 3 pick 3 pick 3 pick 3 pick
dnl # 2over 2over
dnl # ( d c b a  --  d c b a d c b a )
dnl # ( d2 d1 -- d2 d1 d2 d1 )
define({_4DUP},{
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup})dnl
dnl
dnl
dnl # 4dup drop
dnl # 3 pick 3 pick 3 pick
dnl # 2over 2over drop
dnl # ( d c b a  --  d c b a d c b )
define({_4DUP_DROP},{ifelse(_TYP_SINGLE,{small},{
                        ;[9:98]     4dup drop   ( d c b a -- d c b a d c b )
    ex  (SP),HL         ; 1:19      4dup drop   HL = c
    pop  AF             ; 1:10      4dup drop   AF = a
    pop  BC             ; 1:10      4dup drop   BC = d
    push BC             ; 1:11      4dup drop
    push HL             ; 1:11      4dup drop
    push DE             ; 1:11      4dup drop
    push AF             ; 1:11      4dup drop
    push BC             ; 1:11      4dup drop
    ex   DE, HL         ; 1:4       4dup drop},
{
                       ;[10:87]     4dup drop   ( d c b a -- d c b a d c b )
    ex   DE, HL         ; 1:4       4dup drop
    pop  BC             ; 1:10      4dup drop   BC = c
    pop  AF             ; 1:10      4dup drop   AF = d
    push AF             ; 1:11      4dup drop
    push BC             ; 1:11      4dup drop
    push HL             ; 1:11      4dup drop
    push DE             ; 1:11      4dup drop
    push AF             ; 1:11      4dup drop
    ld    L, C          ; 1:4       4dup drop
    ld    H, B          ; 1:4       4dup drop})})dnl
dnl
dnl
dnl # 5dup
dnl # 4 pick 4 pick 4 pick 4 pick 4 pick
dnl # ( e d c b a  --  e d c b a e d c b a )
dnl # ( x d2 d1 -- x d2 d1 x d2 d1 )
define({_5DUP},{
                       ;[15:134]    5dup   ( e d c b a -- e d c b a e d c b a )
    pop  BC             ; 1:10      5dup   e d . . . . . . b a
    pop  AF             ; 1:10      5dup   e . . . . . . . b a
    ex   AF, AF'        ; 1:4       5dup
    pop  AF             ; 1:10      5dup   . . . . . . . . b a
    push AF             ; 1:11      5dup   e . . . . . . . b a
    ex   AF, AF'        ; 1:4       5dup
    push AF             ; 1:11      5dup   e d . . . . . . b a
    push BC             ; 1:11      5dup   e d c . . . . . b a
    push DE             ; 1:11      5dup   e d c b . . . . b a
    push HL             ; 1:11      5dup   e d c b a . . . b a
    ex   AF, AF'        ; 1:4       5dup
    push AF             ; 1:11      5dup   e d c b a e . . b a
    ex   AF, AF'        ; 1:4       5dup
    push AF             ; 1:11      5dup   e d c b a e d . b a
    push BC             ; 1:11      5dup   e d c b a e d c b a})dnl
dnl
dnl
dnl # 6dup
dnl # 5 pick 5 pick 5 pick 5 pick 5 pick 5 pick
dnl # ( f e d c b a  --  f e d c b a f e d c b a )
dnl # ( d3 d2 d1 -- d3 d2 d1 d3 d2 d1 )
define({_6DUP},{ifelse(_TYP_SINGLE,{small},{
                       ;[14:440]    6dup   ( d3 d2 d1 -- d3 d2 d1 d3 d2 d1 )   # small version can be changed with "define({_TYP_SINGLE},{default})"
    ld    B, 0x06       ; 2:7       6dup   6x "5 pick"
    push DE             ; 1:11      6dup
    ex   DE, HL         ; 1:4       6dup
    ld   HL, 0x0008     ; 3:10      6dup
    add  HL, SP         ; 1:11      6dup
    ld    A,(HL)        ; 1:7       6dup
    inc  HL             ; 1:6       6dup
    ld    H,(HL)        ; 1:7       6dup
    ld    L, A          ; 1:4       6dup
    djnz $-10           ; 2:8/13    6dup},
{
                       ;[18:166]    6dup   ( e d c b a -- e d c b a e d c b a )
    pop  BC             ; 1:10      6dup   f e d . . . . . . . b a
    exx                 ; 1:4       6dup
    pop  AF             ; 1:10      6dup   f e . . . . . . . . - -
    pop  BC             ; 1:10      6dup   f . . . . . . . . . - -
    pop  DE             ; 1:10      6dup   . . . . . . . . . . - -
    push DE             ; 1:11      6dup   f . . . . . . . . . - -
    push BC             ; 1:11      6dup   f e . . . . . . . . - -
    push AF             ; 1:11      6dup   f e d . . . . . . . - -
    exx                 ; 1:4       6dup
    push BC             ; 1:11      6dup   f e d c . . . . . . b a
    push DE             ; 1:11      6dup   f e d c b . . . . . b a
    push HL             ; 1:11      6dup   f e d c b a . . . . b a
    exx                 ; 1:4       6dup
    push DE             ; 1:11      6dup   f e d c b a f . . . - -
    push BC             ; 1:11      6dup   f e d c b a f e . . - -
    push AF             ; 1:11      6dup   f e d c b a f e d . - -
    exx                 ; 1:4       6dup
    push BC             ; 1:11      6dup   f e d c b a f e d c b a})})dnl
dnl
dnl
dnl # ( a -- )
dnl # odstrani vrchol zasobniku
define({DROP},{
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )})dnl
dnl
dnl
dnl # ( b a -- b b )
define({DROP_DUP},{
    ld   H, D           ; 1:4       drop_dup   ( b a -- b b )
    ld   L, E           ; 1:4       drop_dup})dnl
dnl
dnl
dnl # 2drop
dnl # ( b a -- )
dnl # odstrani 2x vrchol zasobniku
define({_2DROP},{
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )})dnl
dnl
dnl
dnl # drop 2drop
dnl # ( c b a -- )
dnl # odstrani 3x vrchol zasobniku
define({DROP_2DROP},{
    pop  HL             ; 1:10      drop 2drop ( c b a -- )
    pop  HL             ; 1:10      drop 2drop
    pop  DE             ; 1:10      drop 2drop})dnl
dnl
dnl
dnl # ( b a -- a )
dnl # : nip swap drop ;
dnl # drop_second
define({NIP},{
    pop  DE             ; 1:10      nip ( b a -- a )})dnl
dnl
dnl
dnl # ( d c b a – b a )
dnl # : 2nip 2swap 2drop ;
dnl # drop_second
define({_2NIP},{
    pop  AF             ; 1:10      2nip
    pop  AF             ; 1:10      2nip ( d c b a – b a )})dnl
dnl
dnl
dnl # ( b a -- a b a )
dnl # : tuck swap over ;
define({TUCK},{
    push HL             ; 1:11      tuck ( b a -- a b a )})dnl
dnl
dnl
dnl # ( d c b a -- b a d c b a )
dnl # : 2tuck 2swap 2over ;
define({_2TUCK},{
                        ;[6:64]     2tuck ( d c b a -- b a d c b a )
    pop  AF             ; 1:10      2tuck     d   . b a     AF = c
    pop  BC             ; 1:10      2tuck         . b a     BC = d
    push DE             ; 1:11      2tuck b       . b a
    push HL             ; 1:11      2tuck b a     . b a
    push BC             ; 1:11      2tuck b a d   . b a
    push AF             ; 1:11      2tuck b a d c . b a})dnl
dnl
dnl
dnl # ( b a -- b a b )
dnl # vytvori kopii druhe polozky na zasobniku
define({OVER},{
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )})dnl
dnl
dnl
dnl # ( b a -- b b a )
define({OVER_SWAP},{
    push DE             ; 1:11      over_swap ( b a -- b b a )})dnl
dnl
dnl
dnl # 3 over
dnl # ( a -- a 3 a )
define({PUSH_OVER},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 over
    push HL             ; 1:11      $1 over
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 over ( a -- a $1 a )})dnl
dnl
dnl
define({DUP_PUSH_SWAP},{PUSH_OVER($1)}){}dnl
dnl
dnl
dnl # over 3
dnl # ( b a -- b a b 3 )
define({OVER_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      over $1
    push HL             ; 1:11      over $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      over $1 ( b a -- b a b $1 )})dnl
dnl
dnl
dnl # ( d c b a -- d c b a d c )
dnl # Copy cell pair "d c" to the top of the stack.
define({_2OVER},{
                        ;[9:91]     2over ( d c b a -- d c b a d c )
    pop  AF             ; 1:10      2over d       . b a     AF = c
    pop  BC             ; 1:10      2over         . b a     BC = d
    push BC             ; 1:11      2over d       . b a
    push AF             ; 1:11      2over d c     . b a
    push DE             ; 1:11      2over d c b   . b a
    push AF             ; 1:11      2over d c b c . b a
    ex  (SP),HL         ; 1:19      2over d c b a . b c
    ld    D, B          ; 1:4       2over
    ld    E, C          ; 1:4       2over d c b a . d c})dnl
dnl
dnl
dnl # ( f e d c b a -- f e d c b a f e d )
dnl # Copy cell pair "f e d" to the top of the stack.
define({_3OVER},{
                       ;[19:130]    3over   ( f e d c b a -- f e d c b a f e d )
    push DE             ; 1:11      3over   f e d c b . . b a
    push HL             ; 1:11      3over   f e d c b a . b a
    ld   HL, 0x000B     ; 3:10      3over   f e d c b a . b 11
    add  HL, SP         ; 1:11      3over   f e d c b a . b -
    ld    D,(HL)        ; 1:7       3over   f e d c b a . - -
    dec  HL             ; 1:6       3over   f e d c b a . - -
    ld    E,(HL)        ; 1:7       3over   f e d c b a . f -
    dec  HL             ; 1:6       3over   f e d c b a . f -
    push DE             ; 1:11      3over   f e d c b a f f -
    ld    D,(HL)        ; 1:7       3over   f e d c b a f - -
    dec  HL             ; 1:6       3over   f e d c b a f - -
    ld    E,(HL)        ; 1:7       3over   f e d c b a f e -
    dec  HL             ; 1:6       3over   f e d c b a f e -
    ld    A,(HL)        ; 1:7       3over   f e d c b a f e -
    dec  HL             ; 1:6       3over   f e d c b a f e -
    ld    L,(HL)        ; 1:7       3over   f e d c b a f e -
    ld    H, A          ; 1:4       3over   f e d c b a f e d}){}dnl
dnl
dnl
dnl # ( h g f e d c b a -- h g f e d c b a h g f e )
dnl # ( d4 d3 d2 d1 -- d4 d3 d2 d1 d4 d3 )
dnl # Copy cell pair "d4 d3" to the top of the stack.
define({_4OVER},{ifelse(_TYP_SINGLE,{small},{
                       ;[19:212]    4over   ( d4 d3 d2 d1 -- d4 d3 d2 d1 d4 d3 )   # small version can be changed with "define({_TYP_SINGLE},{default})"
    ex   DE, HL         ; 1:4       4over   h g f e d c . . . . a b
    push HL             ; 1:11      4over   h g f e d c b . . . a b
    ld   HL, 0x000D     ; 3:10      4over   h g f e d c b . . . a 13
    add  HL, SP         ; 1:11      4over   h g f e d c b . . . a -
    ld    B, 0x03       ; 2:7       4over   h g f e d c b . . . a -
    push DE             ; 1:11      4over   h g f e d c b(a-h-g)f -
    ld    D,(HL)        ; 1:7       4over   h g f e d c b(a-h-g)f -
    dec  HL             ; 1:6       4over   h g f e d c b(a-h-g)f -
    ld    E,(HL)        ; 1:7       4over   h g f e d c b(a-h-g)f -
    dec  HL             ; 1:6       4over   h g f e d c b(a-h-g)f -
    djnz $-5            ; 2:8/13    4over   h g f e d c b(a-h-g)f -
    ld    A,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    dec  HL             ; 1:6       4over   h g f e d c b a h g f -
    ld    L,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    ld    H, A          ; 1:4       4over   h g f e d c b a h g f e},
{
                       ;[24:167]    4over   ( d4 d3 d2 d1 -- d4 d3 d2 d1 d4 d3 )   # default version can be changed with "define({_TYP_SINGLE},{small})"
    push DE             ; 1:11      4over   h g f e d c b . . . b a
    push HL             ; 1:11      4over   h g f e d c b a . . b a
    ld   HL, 0x000F     ; 3:10      4over   h g f e d c b a . . b 15
    add  HL, SP         ; 1:11      4over   h g f e d c b a . . b -
    ld    D,(HL)        ; 1:7       4over   h g f e d c b a . . - -
    dec  HL             ; 1:6       4over   h g f e d c b a . . - -
    ld    E,(HL)        ; 1:7       4over   h g f e d c b a . . h -
    dec  HL             ; 1:6       4over   h g f e d c b a . . h -
    push DE             ; 1:11      4over   h g f e d c b a h . h -
    ld    D,(HL)        ; 1:7       4over   h g f e d c b a h . - -
    dec  HL             ; 1:6       4over   h g f e d c b a h . - -
    ld    E,(HL)        ; 1:7       4over   h g f e d c b a h . g -
    dec  HL             ; 1:6       4over   h g f e d c b a h . g -
    push DE             ; 1:11      4over   h g f e d c b a h g g -
    ld    D,(HL)        ; 1:7       4over   h g f e d c b a h g - -
    dec  HL             ; 1:6       4over   h g f e d c b a h g - -
    ld    E,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    dec  HL             ; 1:6       4over   h g f e d c b a h g f -
    ld    A,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    dec  HL             ; 1:6       4over   h g f e d c b a h g f -
    ld    L,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    ld    H, A          ; 1:4       4over   h g f e d c b a h g f e})}){}dnl
dnl
dnl
dnl # ( c b a -- b a c )
dnl # vyjme treti polozku a ulozi ji na vrchol, rotace doleva
define({ROT},{
    ex   DE, HL         ; 1:4       rot
    ex  (SP),HL         ; 1:19      rot ( c b a -- b a c )})dnl
dnl
dnl
dnl # rot drop
dnl # ( c b a -- b a )
dnl # Remove third item from stack
define({ROT_DROP},{
    pop  AF             ; 1:10      rot drop ( c b a -- b a )})dnl
dnl
dnl
dnl # ( f e d c b a -- d c b a f e )
dnl # vyjme treti 32-bit polozku a ulozi ji na vrchol
define({_2ROT},{ifelse(TYP_2ROT,{fast},{
                       ;[17:120]    2rot ( f e d c b a -- d c b a f e ) # fast version can be changed with "define({TYP_2ROT},{default})"
    pop  BC             ; 1:10      2rot f e d   . b a  BC = c
    exx                 ; 1:4       2rot f e d   . - R
    pop  BC             ; 1:10      2rot f e     . - R  BC'= d
    ld    A, H          ; 1:4       2rot
    ex   AF, AF'        ; 1:4       2rot
    ld    A, L          ; 1:4       2rot
    pop  HL             ; 1:10      2rot f       . - e
    pop  DE             ; 1:10      2rot         . f e
    push BC             ; 1:11      2rot d       . f e
    exx                 ; 1:4       2rot d       . b a
    push BC             ; 1:11      2rot d c     . b a
    push DE             ; 1:11      2rot d c b   . b a
    push HL             ; 1:11      2rot d c b a . b a
    ld    L, A          ; 1:4       2rot
    ex   AF, AF'        ; 1:4       2rot
    ld    H, A          ; 1:4       2rot d c b a . b R
    exx                 ; 1:4       2rot d c b a . f e},
{
                       ;[15:127]    2rot ( f e d c b a -- d c b a f e ) # default version can be changed with "define({TYP_2ROT},{fast})"
    exx                 ; 1:4       2rot f e d c .
    pop  DE             ; 1:10      2rot f e d   .      DE' = c
    pop  BC             ; 1:10      2rot f e     .      BC' = d
    exx                 ; 1:4       2rot f e     . b a
    ex  (SP),HL         ; 1:19      2rot f a     . b e
    pop  AF             ; 1:10      2rot f       . b e  AF = a
    pop  BC             ; 1:10      2rot         . b e  BC = f
    exx                 ; 1:4       2rot
    push BC             ; 1:11      2rot d       .
    push DE             ; 1:11      2rot d c     .
    exx                 ; 1:4       2rot d c     . b e
    push DE             ; 1:11      2rot d c b   . b e
    ld    D, B          ; 1:4       2rot
    ld    E, C          ; 1:4       2rot d c b   . f e
    push AF             ; 1:11      2rot d c b a . f e})}){}dnl
dnl
dnl
dnl # -rot
dnl # ( c b a -- a c b )
dnl # vyjme vrchol zasobniku a ulozi ho jako treti polozku, rotace doprava
define({NROT},{
                        ;[2:23]     nrot ( c b a -- a c b )
    ex  (SP),HL         ; 1:19      nrot a . b c
    ex   DE, HL         ; 1:4       nrot a . c b})dnl
dnl
dnl
dnl # -rot swap
dnl # ( c b a -- a b c )
dnl # prohodi hodnotu na vrcholu zasobniku s treti polozkou
define({NROT_SWAP},{
    ex  (SP),HL         ; 1:19      nrot_swap ( c b a -- a b c )})dnl
dnl
dnl
dnl # -rot nip
dnl # ( c b a -- a b )
dnl # Remove third item from stack and swap
define({NROT_NIP},{
    pop  AF             ; 1:10      nrot nip
    ex   DE, HL         ; 1:4       nrot nip ( c b a -- a b )})dnl
dnl
dnl
dnl # -rot 2swap
dnl # ( d c b a -- c b d a )
dnl # 4th --> 2th
define({NROT_2SWAP},{
                        ;[6:50]     nrot_2swap   ( d c b a -- c b d a )
    pop  AF             ; 1:10      nrot_2swap   d   . b a    AF = c
    ld    B, D          ; 1:4       nrot_2swap
    ld    C, E          ; 1:4       nrot_2swap                BC = b
    pop  DE             ; 1:10      nrot_2swap       . d a
    push AF             ; 1:11      nrot_2swap   c   . d a
    push BC             ; 1:11      nrot_2swap   c b . d a})dnl
dnl
dnl
dnl # nrot swap 2swap swap
dnl # ( d c b a -- b c a d )
define({STACK_BCAD},{
                        ;[4:44]     stack_bcad   ( d c b a -- b c a d )
    ex   DE, HL         ; 1:4       stack_bcad   d c a b
    pop  AF             ; 1:10      stack_bcad   AF = c
    ex  (SP), HL        ; 1:19      stack_bcad   b a d
    push AF             ; 1:11      stack_bcad   b c a d })dnl
dnl
dnl
dnl # 2 pick 2 pick swap
dnl # over 3 pick
dnl # 2over nip 2over nip swap
dnl # over 2over drop
dnl #      ( c b a -- c b a b c )
dnl # -- c b a b c )
define({STACK_CBABC},{
                        ;[6:51]     stack_cbabc   ( c b a -- c b a b c )
    pop  BC             ; 1:10      stack_cbabc   BC = c
    push BC             ; 1:11      stack_cbabc
    push DE             ; 1:11      stack_cbabc   c b b a
    push HL             ; 1:11      stack_cbabc   c b a b a
    ld    H, B          ; 1:4       stack_cbabc
    ld    L, C          ; 1:4       stack_cbabc   c b a b c})dnl
dnl
dnl
dnl # 3dup rot
dnl #        ( c b a -- c b a b a c )
dnl # -- c b a b a c )
define({STACK_CBABAC},{
                        ;[8:66]     stack_cbabc   ( c b a -- c b a b a c )
    pop  BC             ; 1:10      stack_cbabc   BC = c
    push BC             ; 1:11      stack_cbabc   c . . . b a
    push DE             ; 1:11      stack_cbabc   c b . . b a
    push HL             ; 1:11      stack_cbabc   c b a . b a
    push DE             ; 1:11      stack_cbabc   c b a b b a
    ex   DE, HL         ; 1:4       stack_cbabc   c b a b a b
    ld    H, B          ; 1:4       stack_cbabc   c b a b a -
    ld    L, C          ; 1:4       stack_cbabc   c b a b a c})dnl
dnl
dnl
define({_3DUP_ROT},{STACK_CBABAC}){}dnl
dnl
dnl
dnl # 3dup -rot
dnl #        ( c b a -- c b a a c b )
dnl # -- c b a a c b )
define({STACK_CBAACB},{
                        ;[8:66]     stack_cbabc   ( c b a -- c b a a c b )
    pop  BC             ; 1:10      stack_cbabc   BC = c
    push BC             ; 1:11      stack_cbabc   c . . . b a
    push DE             ; 1:11      stack_cbabc   c b . . b a
    push HL             ; 1:11      stack_cbabc   c b a . b a
    push HL             ; 1:11      stack_cbabc   c b a a b a
    ex   DE, HL         ; 1:4       stack_cbabc   c b a a a b
    ld    D, B          ; 1:4       stack_cbabc   c b a a - b
    ld    E, C          ; 1:4       stack_cbabc   c b a a c b})dnl
dnl
dnl
define({_3DUP_NROT},{STACK_CBAACB}){}dnl
dnl
dnl
dnl # ( f e d c b a -- b a f e d c )
define({N2ROT},{
                        ;[14:123]   n2rot   ( f e d c b a -- b a f e d c )
    pop  BC             ; 1:10      n2rot   f e d     . b a   BC = c
    pop  AF             ; 1:10      n2rot   f e       . b a   AF = d
    ex   AF, AF'        ; 1:4       n2rot   f e       . b a
    pop  AF             ; 1:10      n2rot   f         . b a   AF'= e
    ex   DE, HL         ; 1:4       n2rot   f         . a b
    ex  (SP),HL         ; 1:19      n2rot   b         . a f
    push DE             ; 1:11      n2rot   b a       . a f
    push HL             ; 1:11      n2rot   b a f     . a f
    push AF             ; 1:11      n2rot   b a f e   . a f
    ex   AF, AF'        ; 1:4       n2rot   b a f e   . a f
    push AF             ; 1:11      n2rot   b a f e d . a f
    pop  DE             ; 1:10      n2rot   b a f e   . d f
    ld    H, B          ; 1:4       n2rot   b a f e   . d -
    ld    L, C          ; 1:4       n2rot   b a f e   . d c})dnl
dnl
dnl
dnl # ( -- a )
dnl # push(a) ulozi na zasobnik nasledujici polozku
define({PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro! Maybe you want to use {PUSH2}($1,$2)?})
    push DE             ; 1:11      push($1)
    ex   DE, HL         ; 1:4       push($1)
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      push($1)})dnl
dnl
dnl
dnl # ( -- b a)
dnl # push2(b,a) ulozi na zasobnik nasledujici polozky
define({PUSH2},{ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=2),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}    push DE             ; 1:11      push2($1,$2)
__{}    push HL             ; 1:11      push2($1,$2){}dnl
__{}define({_TMP_INFO},{push2($1,$2)}){}dnl # HL first check
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}define({PUSH2_HL},__CLOCKS_16BIT){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}define({PUSH2_HL},eval(PUSH2_HL+__CLOCKS_16BIT)){}dnl
__{}dnl
__{}__LD_REG16({HL},$2,{DE},$1){}dnl # DE first check
__{}define({PUSH2_DE},__CLOCKS_16BIT){}dnl
__{}__LD_REG16({DE},$1){}dnl
__{}define({PUSH2_DE},eval(PUSH2_DE+__CLOCKS_16BIT)){}dnl
__{}dnl
__{}ifelse(eval(PUSH2_DE<=PUSH2_HL),{1},{dnl # DE first
__{}__{}__CODE_16BIT{}__LD_REG16({HL},$2,{DE},$1){}__CODE_16BIT},
__{}{dnl # HL first
__{}__{}__LD_REG16({HL},$2){}__CODE_16BIT{}__LD_REG16({DE},$1,{HL},$2){}__CODE_16BIT}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( -- c b a)
dnl # push3(c,b,a) ulozi na zasobnik nasledujici polozky
define({PUSH3},{ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=3),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}    push DE             ; 1:11      $1 $2 $3  push3($1,$2,$3)
__{}    push HL             ; 1:11      $1 $2 $3  push3($1,$2,$3){}dnl
__{}define({_TMP_INFO},$1{ }$2{ }$3{  push3(}$1{,}$2{,}$3{)}){}dnl
__{}__LD_REG16_BEFORE_AFTER({DE},$2,{HL},$1,{HL},$3){}dnl
__{}define({PUSH3_P1},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},$3,{HL},$1){}dnl
__{}define({PUSH3_P1},eval(PUSH3_P1+__PRICE_16BIT)){}dnl
__{}define({PUSH3_P},PUSH3_P1){}dnl
__{}define({PUSH3_X},1){}dnl
__{}dnl
__{}__LD_REG16_BEFORE_AFTER({HL},$3,{DE},$1,{DE},$2){}dnl
__{}define({PUSH3_P2},__PRICE_16BIT){}dnl
__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}define({PUSH3_P2},eval(PUSH3_P2+__PRICE_16BIT)){}dnl
__{}ifelse(eval(PUSH3_P>PUSH3_P2),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P2){}dnl
__{}__{}define({PUSH3_X},2)}){}dnl
__{}dnl
__{}__LD_REG16({DE},$2,{DE},$1,{HL},$3){}dnl
__{}__{}define({PUSH3_P3},eval(22+__PRICE_16BIT)){}dnl
__{}ifelse(eval(PUSH3_P>22+__PRICE_16BIT),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P3){}dnl
__{}__{}define({PUSH3_X},3)}){}dnl
__{}dnl
__{}__LD_REG16({HL},$3,{HL},$1,{DE},$2){}dnl
__{}__{}define({PUSH3_P4},eval(22+__PRICE_16BIT)){}dnl
__{}ifelse(eval(PUSH3_P>PUSH3_P4),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P4){}dnl
__{}__{}define({PUSH3_X},4)}){}dnl
__{}dnl # PUSH3_P1 PUSH3_P2 PUSH3_P3 PUSH3_P4 --> PUSH3_X
__{}dnl ---- case PUSH3_X ----
__{}ifelse(dnl
__{}PUSH3_X,1,{__LD_REG16_BEFORE_AFTER({DE},$2,{HL},$1,{HL},$3){}__LD_REG16({HL},$3,{HL},$1)
__{}__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3  push3($1,$2,$3)
__{}__{}    push HL             ; 1:11      $1 $2 $3  push3($1,$2,$3){}__CODE_BEFORE_16BIT{}__CODE_16BIT{}__CODE_AFTER_16BIT},
__{}PUSH3_X,2,{__LD_REG16_BEFORE_AFTER({HL},$3,{DE},$1,{DE},$2){}__LD_REG16({DE},$2,{DE},$1)
__{}__{}    ld   DE, format({%-11s},$1); 3:10      $1 $2 $3  push3($1,$2,$3)
__{}__{}    push DE             ; 1:11      $1 $2 $3  push3($1,$2,$3){}__CODE_BEFORE_16BIT{}__CODE_16BIT{}__CODE_AFTER_16BIT},
__{}PUSH3_X,3,{__LD_REG16({DE},$2,{DE},$1,{HL},$3)
__{}__{}    ld   DE, format({%-11s},$1); 3:10      $1 $2 $3  push3($1,$2,$3)
__{}__{}    push DE             ; 1:11      $1 $2 $3  push3($1,$2,$3)
__{}__{}    ld   HL, format({%-11s},$3); 3:10      $1 $2 $3  push3($1,$2,$3){}__CODE_16BIT},
__{}{__LD_REG16({HL},$3,{HL},$1,{DE},$2)
__{}__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3  push3($1,$2,$3)
__{}__{}    push HL             ; 1:11      $1 $2 $3  push3($1,$2,$3)
__{}__{}    ld   DE, format({%-11s},$2); 3:10      $1 $2 $3  push3($1,$2,$3){}__CODE_16BIT}){}dnl
})})dnl
dnl
dnl
dnl
dnl # drop 50
dnl # ( a -- 50 )
dnl # zmeni hodnotu top
define({DROP_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      drop $1})dnl
dnl
dnl
dnl # 2drop 50
dnl # ( a -- 50 )
dnl # zmeni hodnotu top
define({_2DROP_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    pop  DE             ; 1:10      2drop $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      2drop $1})dnl
dnl
dnl
dnl # dup 50
dnl # ( a -- a a 50 )
dnl # zmeni hodnotu top
define({DUP_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      dup $1
    push HL             ; 1:11      dup $1
    ex   DE, HL         ; 1:4       dup $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      dup $1})dnl
dnl
dnl
dnl
dnl # # ( -- d )
dnl # # PUSHDOT(number32bit) ulozi na zasobnik 32 bitove cislo
dnl # # 255. --> ( -- 0x0000 0x00FF )
define({PUSHDOT},{ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      pushdot($1)   ( -- hi lo )
__{}    push HL             ; 1:11      pushdot($1)
__{}    ld   DE,format({%-12s},($1+2)); 4:20      pushdot($1)   hi word
__{}    ld   HL, format({%-11s},$1); 3:16      pushdot($1)   lo word},
{
__{}define({__DE},__HEX_DE($1)){}dnl
__{}define({__HL},__HEX_HL($1)){}dnl
__{}    push DE             ; 1:11      pushdot($1)   ( -- hi lo )
__{}    push HL             ; 1:11      pushdot($1){}dnl
__{}define({_TMP_INFO},{pushdot($1)}){}dnl # HL first check
__{}__LD_REG16({DE},__DE,{HL},__HL){}dnl
__{}define({PUSH2_HL},__CLOCKS_16BIT){}dnl
__{}__LD_REG16({HL},__HL){}dnl
__{}define({PUSH2_HL},eval(PUSH2_HL+__CLOCKS_16BIT)){}dnl
__{}dnl
__{}__LD_REG16({HL},__HL,{DE},__DE){}dnl # DE first check
__{}define({PUSH2_DE},__CLOCKS_16BIT){}dnl
__{}__LD_REG16({DE},__DE){}dnl
__{}define({PUSH2_DE},eval(PUSH2_DE+__CLOCKS_16BIT)){}dnl
__{}dnl
__{}ifelse(eval(PUSH2_DE<=PUSH2_HL),{1},{dnl # DE first
__{}__{}__CODE_16BIT{}__LD_REG16({HL},__HL,{DE},__DE){}__CODE_16BIT},
__{}{dnl # HL first
__{}__{}__LD_REG16({HL},__HL){}__CODE_16BIT{}__LD_REG16({DE},__DE,{HL},__HL){}__CODE_16BIT}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # # ( d_old -- d_new d_old )
dnl # # PUSHDOT_2SWAP(number32bit) ulozi za nejvyssi 32 bitove cislo na zasobnik 32 bitove cislo
dnl # # 255. --> ( 0x1122 0x3344 -- 0x0000 0x00FF 0x1122 0x3344 )
define({PUSHDOT_2SWAP},{ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__IS_MEM_REF($1),{1},{
__{}    ld   BC,format({%-12s},($1+2)); 4:20      pushdot_2swap($1)   hi word
__{}    push BC             ; 1:11      pushdot_2swap($1){}dnl
__{}    ld   BC, format({%-11s},$1); 4:20      pushdot_2swap($1)   lo word
__{}    push BC             ; 1:11      pushdot_2swap($1)},
{
__{}define({__DE},__HEX_DE($1)){}dnl
__{}define({__HL},__HEX_HL($1)){}dnl
__{}define({_TMP_INFO},{pushdot_2swap($1)   hi word}){}dnl
__{}__LD_REG16({BC},__DE){}dnl
__{}__CODE_16BIT
__{}    push BC             ; 1:11      pushdot_2swap($1){}dnl
__{}define({_TMP_INFO},{pushdot_2swap($1)   lo word}){}dnl
__{}__LD_REG16({BC},__HL,{BC},__DE){}dnl
__{}__CODE_16BIT
__{}    push BC             ; 1:11      pushdot_2swap($1){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( ...n3 n2 n1 n0 x -- ...n3 n2 n1 n0 nx )
dnl # Remove x. Copy the nx to the top of the stack.
define({PICK},{ifelse($#,{0},,{
.error pick: Unexpected parameter $@, pick uses a parameter from the stack!})
    push DE             ; 1:11      pick
    add  HL, HL         ; 1:11      pick
    add  HL, SP         ; 1:11      pick
    ld    E,(HL)        ; 1:7       pick
    inc  HL             ; 1:6       pick
    ld    D,(HL)        ; 1:7       pick
    ex   DE, HL         ; 1:4       pick
    pop  DE             ; 1:10      pick})dnl
dnl
dnl
dnl # # 0 pick ( a 0 -- a a )
dnl # # 1 pick ( b a 1 -- b a b )
dnl # # 2 pick ( c b a 2 -- c b a c )
dnl # # 3 pick ( d c b a 3 -- d c b a d )
dnl # # 4 pick ( e d c b a 4 -- e d c b a e )
dnl # # u pick ( ...x3 x2 x1 x0 u -- ...x3 x2 x1 x0 xu )
dnl # # Remove u. Copy the xu to the top of the stack.
define({PUSH_PICK},{ifelse($#,{0},{
__{}  .error _push_pick(): Parameter is missing!},
__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      $1 pick
__{}    push HL             ; 1:11      $1 pick
__{}    ld   HL, format({%-11s},$1); 3:16      $1 pick
__{}    add  HL, HL         ; 1:11      $1 pick
__{}    add  HL, SP         ; 1:11      $1 pick
__{}    ld    E,(HL)        ; 1:7       $1 pick
__{}    inc  HL             ; 1:6       $1 pick
__{}    ld    D,(HL)        ; 1:7       $1 pick
__{}    ex   DE, HL         ; 1:4       $1 pick
__{}    pop  DE             ; 1:10      $1 pick},
__IS_NUM($1),{0},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}    push DE             ; 1:11      $1 pick
__{}    push HL             ; 1:11      $1 pick
__{}    ld   HL, format({%-11s},$1); 3:10      $1 pick
__{}    add  HL, HL         ; 1:11      $1 pick
__{}    add  HL, SP         ; 1:11      $1 pick
__{}    ld    E,(HL)        ; 1:7       $1 pick
__{}    inc  HL             ; 1:6       $1 pick
__{}    ld    D,(HL)        ; 1:7       $1 pick
__{}    ex   DE, HL         ; 1:4       $1 pick
__{}    pop  DE             ; 1:10      $1 pick},
{dnl
__{}ifelse(dnl
__{}eval($1),{0},{DUP},
__{}eval($1),{1},{OVER},
__{}eval($1),{2},{
__{}__{}                       ;[ 6:44]     2 pick
__{}__{}    pop  BC             ; 1:10      2 pick
__{}__{}    push BC             ; 1:11      2 pick
__{}__{}    push DE             ; 1:11      2 pick
__{}__{}    ex   DE, HL         ; 1:4       2 pick
__{}__{}    ld    H, B          ; 1:4       2 pick
__{}__{}    ld    L, C          ; 1:4       2 pick ( c b a -- c b a c )},
__{}eval($1),{3},{
__{}__{}                       ;[ 8:65]     3 pick
__{}__{}    pop  AF             ; 1:10      3 pick
__{}__{}    pop  BC             ; 1:10      3 pick
__{}__{}    push BC             ; 1:11      3 pick
__{}__{}    push AF             ; 1:11      3 pick
__{}__{}    push DE             ; 1:11      3 pick
__{}__{}    ex   DE, HL         ; 1:4       3 pick
__{}__{}    ld    H, B          ; 1:4       3 pick
__{}__{}    ld    L, C          ; 1:4       3 pick ( d c b a -- d c b a d )},
__{}{
__{}__{}                       ;[10:60]     $1 pick
__{}__{}    push DE             ; 1:11      $1 pick
__{}__{}    ex   DE, HL         ; 1:4       $1 pick
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      $1 pick
__{}__{}    add  HL, SP         ; 1:11      $1 pick
__{}__{}    ld    A,(HL)        ; 1:7       $1 pick
__{}__{}    inc  HL             ; 1:6       $1 pick
__{}__{}    ld    H,(HL)        ; 1:7       $1 pick
__{}__{}    ld    L, A          ; 1:4       $1 pick ( ...x2 x1 x0 -- ...x2 x1 x0 x$1 )})})})dnl
dnl
dnl
dnl # depth
dnl # ( -- 0 )
dnl # ( x -- x 1 )
dnl # ( x x -- x x 2 )
dnl # ( -- +n )
dnl # +n is the number of single-cell values contained in the data stack before +n was placed on the stack
define({DEPTH},{
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    srl   H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth})dnl
dnl
dnl
dnl
dnl # ------------- return address stack ------------------
dnl
dnl # >r
dnl # ( x -- ) ( R: -- x )
dnl # Move x to the return stack.
define({TO_R},{
                        ;[9:65]     to_r   ( c b a -- c b ) ( R: -- a )
    ex  (SP), HL        ; 1:19      to_r   a . b c
    ex   DE, HL         ; 1:4       to_r   a . c b
    exx                 ; 1:4       to_r
    pop  DE             ; 1:10      to_r
    dec  HL             ; 1:6       to_r
    ld  (HL),D          ; 1:7       to_r
    dec   L             ; 1:4       to_r
    ld  (HL),E          ; 1:7       to_r
    exx                 ; 1:4       to_r})dnl
dnl
dnl
dnl # dup >r
dnl # ( x -- x ) ( R: -- x )
dnl # Copy x to the return stack.
define({DUP_TO_R},{
                        ;[8:53]     dup_to_r   ( a -- a ) ( R: -- a )
    push HL             ; 1:11      dup_to_r
    exx                 ; 1:4       dup_to_r
    pop  DE             ; 1:10      dup_to_r
    dec  HL             ; 1:6       dup_to_r
    ld  (HL),D          ; 1:7       dup_to_r
    dec   L             ; 1:4       dup_to_r
    ld  (HL),E          ; 1:7       dup_to_r
    exx                 ; 1:4       dup_to_r})dnl
dnl
dnl
dnl # r>
dnl # ( -- x ) ( R: x -- )
dnl # Move x from the return stack to the data stack.
define({R_FROM},{
                        ;[9:66]     r_from ( b a -- b a i ) ( R: i -- )
    exx                 ; 1:4       r_from
    ld    E,(HL)        ; 1:7       r_from
    inc   L             ; 1:4       r_from
    ld    D,(HL)        ; 1:7       r_from
    inc  HL             ; 1:6       r_from
    push DE             ; 1:11      r_from
    exx                 ; 1:4       r_from i . b a
    ex   DE, HL         ; 1:4       r_from i . a b
    ex  (SP), HL        ; 1:19      r_from b . a i})dnl
dnl
dnl
dnl # r@
dnl # ( -- x ) ( R: x -- x )
dnl # Copy x from the return stack to the data stack.
define({R_FETCH},{
dnl #                        ;[9:64]     r_fetch ( b a -- b a i ) ( R: i -- i )
dnl #    exx                 ; 1:4       r_fetch   .
dnl #    push HL             ; 1:11      r_fetch r .
dnl #    exx                 ; 1:4       r_fetch r . b a
dnl #    ex   DE, HL         ; 1:4       r_fetch r . a b
dnl #    ex  (SP), HL        ; 1:19      r_fetch b . a r     HL = r.a.s.
dnl #    ld    A,(HL)        ; 1:7       r_fetch
dnl #    inc   L             ; 1:4       r_fetch
dnl #    ld    H,(HL)        ; 1:7       r_fetch
dnl #    ld    L, A          ; 1:4       r_fetch b . a i
                        ;[9:64]     r_fetch ( b a -- b a i ) ( R: i -- i )
    exx                 ; 1:4       r_fetch
    ld    E,(HL)        ; 1:7       r_fetch
    inc   L             ; 1:4       r_fetch
    ld    D,(HL)        ; 1:7       r_fetch
    dec   L             ; 1:4       r_fetch
    push DE             ; 1:11      r_fetch
    exx                 ; 1:4       r_fetch
    ex   DE, HL         ; 1:4       r_fetch
    ex  (SP), HL        ; 1:19      r_fetch})dnl
dnl
dnl
dnl # rdrop
dnl # r:( a -- )
dnl # odstrani vrchol zasobniku navratovych adres
define({RDROP},{
                        ;[4:18]     rdrop
    exx                 ; 1:4       rdrop
    inc   L             ; 1:4       rdrop
    inc   HL            ; 1:6       rdrop
    exx                 ; 1:4       rdrop r:( a -- )})dnl
dnl
dnl
dnl # r> r> swap >r >r
dnl # 2r> >r >r
dnl # r> r> 2>r
dnl # 2r> swap 2>r
dnl # ( R: x1 x2 -- x2 x1 )
dnl # Swap cell x1 x2 in the return stack.
define({RSWAP},{
                        ;[14:86]    rswap ( R: j i -- i j )
    exx                 ; 1:4       rswap
    ld  ($+10), SP      ; 4:20      rswap
    ld   SP, HL         ; 1:6       rswap
    pop  DE             ; 1:10      rswap
    pop  AF             ; 1:10      rswap
    push DE             ; 1:11      rswap
    push AF             ; 1:11      rswap
    ld   SP, 0x0000     ; 3:10      rswap
    exx                 ; 1:4       rswap})dnl
dnl
dnl
dnl # ------------------- 32 bits ---------------------
dnl
dnl
dnl # 2>r
dnl # swap >r >r
dnl # ( x1 x2 -- ) ( R: -- x1 x2 )
dnl # Transfer cell pair x1 x2 to the return stack.
define({_2TO_R},{
                        ;[15:116]   _2to_r ( d c b a -- d c ) ( R: -- b a )
    ex  (SP), HL        ; 1:19      _2to_r d a   . b c
    push DE             ; 1:11      _2to_r d a b . b c
    exx                 ; 1:4       _2to_r d a b .
    pop  DE             ; 1:10      _2to_r d a   . b
    dec  HL             ; 1:6       _2to_r
    ld  (HL),D          ; 1:7       _2to_r
    dec   L             ; 1:4       _2to_r
    ld  (HL),E          ; 1:7       _2to_r              ( R: b )
    pop  DE             ; 1:10      _2to_r d     . a
    dec  HL             ; 1:6       _2to_r
    ld  (HL),D          ; 1:7       _2to_r
    dec   L             ; 1:4       _2to_r
    ld  (HL),E          ; 1:7       _2to_r              ( R: b a )
    exx                 ; 1:4       _2to_r d     . b c
    pop  DE             ; 1:10      _2to_r       . d c})dnl
dnl
dnl
dnl # 2r>
dnl # r> r> swap
dnl # ( -- x1 x2 ) ( R: x1 x2 -- )
dnl # Transfer cell pair x1 x2 from the return stack.
define({_2R_FROM},{
                        ;[15:118]   _2r_from ( b a -- b a j i ) ( R: j i -- )
    push DE             ; 1:11      _2r_from b     . b a
    exx                 ; 1:4       _2r_from b     .
    ld    E,(HL)        ; 1:7       _2r_from
    inc   L             ; 1:4       _2r_from
    ld    D,(HL)        ; 1:7       _2r_from
    inc  HL             ; 1:6       _2r_from            ( R: j )
    push DE             ; 1:11      _2r_from b i   .
    ld    E,(HL)        ; 1:7       _2r_from
    inc   L             ; 1:4       _2r_from
    ld    D,(HL)        ; 1:7       _2r_from
    inc  HL             ; 1:6       _2r_from            ( R : )
    push DE             ; 1:11      _2r_from b i j .
    exx                 ; 1:4       _2r_from b i j . b a
    pop  DE             ; 1:10      _2r_from b i   . j a
    ex  (SP), HL        ; 1:19      _2r_from b a   . j i})dnl
dnl
dnl
dnl # 2r@
dnl # r> r> 2dup >r >r swap
dnl # ( -- x1 x2 ) ( R: x1 x2 -- x1 x2 )
dnl # Copy cell pair x1 x2 from the return stack.
define({_2R_FETCH},{
                        ;[14:99]    _2r_fetch ( b a -- b a j i ) ( R: j i -- j i )
    push DE             ; 1:11      _2r_fetch b   . b a
    exx                 ; 1:4       _2r_fetch b   .
    push HL             ; 1:11      _2r_fetch b r .
    exx                 ; 1:4       _2r_fetch b r . b a
    ex  (SP), HL        ; 1:19      _2r_fetch b a . b r     HL = r.a.s.
    ld    E,(HL)        ; 1:7       _2r_fetch
    inc   L             ; 1:4       _2r_fetch
    ld    D,(HL)        ; 1:7       _2r_fetch
    inc  HL             ; 1:6       _2r_fetch b a . i r
    ld    A,(HL)        ; 1:7       _2r_fetch
    inc   L             ; 1:4       _2r_fetch
    ld    H,(HL)        ; 1:7       _2r_fetch
    ld    L, A          ; 1:4       _2r_fetch b a . i j
    ex   DE, HL         ; 1:4       _2r_fetch b a . j i})dnl
dnl
dnl
dnl # 2rdrop
dnl # r:( j i -- )
dnl # odstrani dve polozky ze zasobniku navratovych adres
define({_2RDROP},{
                        ;[6:28]     _2rdrop
    exx                 ; 1:4       _2rdrop
    inc   L             ; 1:4       _2rdrop
    inc   HL            ; 1:6       _2rdrop
    inc   L             ; 1:4       _2rdrop
    inc   HL            ; 1:6       _2rdrop
    exx                 ; 1:4       _2rdrop r:( x1 x2 -- )})dnl
dnl
dnl
dnl # r> r> r> r> _2swap >r >r >r >r
dnl # 2r> 2r> _2swap 2>r 2>r
dnl # ( R: x4 x3 x2 x1 -- x2 x1 )
dnl # Swap cell pair x4 x3 and x2 x1 in the return stack.
define({_2RSWAP},{
                        ;[19:134]   rswap ( R: l k j i -- j i l k )
    exx                 ; 1:4       rswap
    ld  ($+14), SP      ; 4:20      rswap
    ld   SP, HL         ; 1:6       rswap
    ex   DE, HL         ; 1:4       rswap l  k  j  i
    pop  BC             ; 1:10      rswap l  k  j  BC
    pop  HL             ; 1:10      rswap l  k  HL
    pop  AF             ; 1:10      rswap l  AF
    ex  (SP),HL         ; 1:19      rswap j     HL=l
    push BC             ; 1:11      rswap j  i
    push HL             ; 1:11      rswap j  i  l
    push AF             ; 1:11      rswap j  i  l  k
    ld   SP, 0x0000     ; 3:10      rswap
    ex   DE, HL         ; 1:4       rswap
    exx                 ; 1:4       rswap})dnl
dnl
dnl
dnl

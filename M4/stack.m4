dnl ## Stack manipulation
dnl
dnl ( b a -- a b )
dnl prohodi vrchol zasobniku s druhou polozkou
define({SWAP},{
    ex   DE, HL         ; 1:4       swap ( b a -- a b )})dnl
dnl
dnl
dnl ( b a -- a b a )
define({SWAP_OVER},{
    push HL             ; 1:11      swap_over ( b a -- a b a )})dnl
dnl
dnl
dnl swap 3
dnl ( b a -- a b 3 )
define({SWAP_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push HL             ; 1:11      swap $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      swap $1 ( b a -- a b $1 )})dnl
dnl
dnl
dnl 3 swap
dnl ( a -- 3 a )
define({PUSH_SWAP},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 swap
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 swap ( a -- $1 a )})dnl
dnl
dnl
dnl dup 3 swap
dnl ( a -- a 3 a )
define({DUP_PUSH_SWAP},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      dup $1 swap
    push HL             ; 1:11      dup $1 swap
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      dup $1 swap ( a -- a $1 a )})dnl
dnl
dnl
dnl swap drop 3 swap
dnl ( b a -- 3 a )
define({SWAP_DROP_PUSH_SWAP},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      swap drop $1 swap ( b a -- $1 a )})dnl
dnl
dnl
dnl nip 3 swap
dnl ( b a -- 3 a )
define({NIP_PUSH_SWAP},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      nip $1 swap ( b a -- $1 a )})dnl
dnl
dnl
dnl ( d c b a -- b a d c )
dnl Exchange the top two cell pairs.
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
dnl ( a -- a a )
dnl vytvori kopii vrcholu zasobniku
define({DUP},{
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )})dnl
dnl
dnl
dnl ( a -- a a a )
dnl vytvori 2x kopii vrcholu zasobniku
define({DUP_DUP},{
    push DE             ; 1:11      dup dup ( a -- a a a )
    push HL             ; 1:11      dup dup
    ld    D, H          ; 1:4       dup dup
    ld    E, L          ; 1:4       dup dup})dnl
dnl
dnl
dnl ?dup
dnl ( a -- a a ) or ( 0 -- 0 )
dnl vytvori kopii vrcholu zasobniku pokud je nenulovy
define({QUESTIONDUP},{
    ld    A, H          ; 1:4       ?dup
    or    L             ; 1:4       ?dup
    jr    z, $+5        ; 2:7/12    ?dup
    push DE             ; 1:11      ?dup
    ld    D, H          ; 1:4       ?dup
    ld    E, L          ; 1:4       ?dup ( a -- 0 | a a )})dnl
dnl
dnl
dnl 2dup
dnl ( b a -- b a b a )
dnl over over
define({_2DUP},{
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a )})dnl
dnl
dnl
dnl 3dup
dnl ( c b a -- c b a c b a )
dnl 2 pick 2 pick 2 pick
define({_3DUP},{
    pop  AF             ; 1:10      3dup
    push AF             ; 1:11      3dup
    push DE             ; 1:11      3dup
    push HL             ; 1:11      3dup   ( c b a -- c b a c b a )})dnl
dnl
dnl
dnl 4dup
dnl 4 pick 4 pick 4 pick 4 pick
dnl ( d c b a  --  d c b a d c b a )
dnl ( d2 d1 -- d2 d1 d2 d1 )
dnl over over
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
dnl ( a -- )
dnl odstrani vrchol zasobniku
define({DROP},{
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )})dnl
dnl
dnl
dnl 2drop
dnl ( b a -- )
dnl odstrani 2x vrchol zasobniku
define({_2DROP},{
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )})dnl
dnl
dnl
dnl drop 2drop
dnl ( c b a -- )
dnl odstrani 3x vrchol zasobniku
define({DROP_2DROP},{
    pop  HL             ; 1:10      drop 2drop ( c b a -- )
    pop  HL             ; 1:10      drop 2drop
    pop  DE             ; 1:10      drop 2drop})dnl
dnl
dnl
dnl ( b a -- a )
dnl : nip swap drop ;
dnl drop_second
define({NIP},{
    pop  DE             ; 1:10      nip ( b a -- a )})dnl
dnl
dnl
dnl ( d c b a – b a )
dnl : 2nip 2swap 2drop ;
dnl drop_second
define({_2NIP},{
    pop  AF             ; 1:10      2nip
    pop  AF             ; 1:10      2nip ( d c b a – b a )})dnl
dnl
dnl
dnl ( b a -- a b a )
dnl : tuck swap over ;
define({TUCK},{
    push HL             ; 1:11      tuck ( b a -- a b a )})dnl
dnl
dnl
dnl ( d c b a -- b a d c b a )
dnl : 2tuck 2swap 2over ;
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
dnl ( b a -- b a b )
dnl vytvori kopii druhe polozky na zasobniku
define({OVER},{
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )})dnl
dnl
dnl
dnl ( b a -- b b a )
define({OVER_SWAP},{
    push DE             ; 1:11      over_swap ( b a -- b b a )})dnl
dnl
dnl
dnl 3 over
dnl ( a -- a 3 a )
define({PUSH_OVER},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 over
    push HL             ; 1:11      $1 over
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 over ( a -- a $1 a )})dnl
dnl
dnl
dnl over 3
dnl ( b a -- b a b 3 )
define({OVER_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      over $1
    push HL             ; 1:11      over $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      over $1 ( b a -- b a b $1 )})dnl
dnl
dnl
dnl ( d c b a -- d c b a d c )
dnl Copy cell pair "d c" to the top of the stack.
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
dnl ( c b a -- b a c )
dnl vyjme treti polozku a ulozi ji na vrchol, rotace doleva
define({ROT},{
    ex   DE, HL         ; 1:4       rot
    ex  (SP),HL         ; 1:19      rot ( c b a -- b a c )})dnl
dnl
dnl
dnl rot drop
dnl ( c b a -- b a )
dnl Remove third item from stack
define({ROT_DROP},{
    pop  AF             ; 1:10      rot drop ( c b a -- b a )})dnl
dnl
dnl
dnl ( f e d c b a -- d c b a f e )
dnl vyjme treti 32-bit polozku a ulozi ji na vrchol
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
dnl -rot
dnl ( c b a -- a c b )
dnl vyjme vrchol zasobniku a ulozi ho jako treti polozku, rotace doprava
define({NROT},{
                        ;[2:23]     nrot ( c b a -- a c b )
    ex  (SP),HL         ; 1:19      nrot a . b c
    ex   DE, HL         ; 1:4       nrot a . c b})dnl
dnl
dnl
dnl -rot swap
dnl ( c b a -- a b c )
dnl prohodi hodnotu na vrcholu zasobniku s treti polozkou
define({NROT_SWAP},{
    ex  (SP),HL         ; 1:19      nrot_swap ( c b a -- a b c )})dnl
dnl
dnl
dnl -rot nip
dnl ( c b a -- a b )
dnl Remove third item from stack and swap
define({NROT_NIP},{
    pop  AF             ; 1:10      nrot nip
    ex   DE, HL         ; 1:4       nrot nip ( c b a -- a b )})dnl
dnl
dnl
dnl -rot 2swap
dnl ( d c b a -- c b d a )
dnl 4th --> 2th
define({NROT_2SWAP},{
                        ;[6:50]     nrot_2swap ( d c b a -- c b d a )
    pop  AF             ; 1:10      nrot_2swap d   . b a    AF = c
    ld    B, D          ; 1:4       nrot_2swap
    ld    C, E          ; 1:4       nrot_2swap              BC = b
    pop  DE             ; 1:10      nrot_2swap     . d a
    push AF             ; 1:11      nrot_2swap c   . d a
    push BC             ; 1:11      nrot_2swap c b . d a})dnl
dnl
dnl
dnl nrot swap 2swap swap
dnl ( d c b a -- b c a d )
define({STACK_BCAD},{
                        ;[4:44]     stack_bcad ( d c b a -- b c a d )
    ex   DE, HL         ; 1:4       stack_bcad d c a b
    pop  AF             ; 1:10      stack_bcad AF = c
    ex  (SP), HL        ; 1:19      stack_bcad b a d
    push AF             ; 1:11      stack_bcad b c a d })dnl
dnl
dnl
dnl 2 pick 2 pick swap
dnl over 3 pick
dnl 2over nip 2over nip swap
dnl over 2over drop
dnl      ( c b a -- c b a b c )
dnl -- c b a b c )
define({STACK_CBABC},{
                        ;[6:51]     stack_cbabc ( c b a -- c b a b c )
    pop  BC             ; 1:10      stack_cbabc BC = c
    push BC             ; 1:11      stack_cbabc
    push DE             ; 1:11      stack_cbabc c b b a
    push HL             ; 1:11      stack_cbabc c b a b a
    ld    H, B          ; 1:4       stack_cbabc
    ld    L, C          ; 1:4       stack_cbabc c b a b c})dnl
dnl
dnl
dnl ( f e d c b a -- b a f e d c )
define({N2ROT},{
                        ;[14:123]   n2rot ( f e d c b a -- b a f e d c )
    pop  BC             ; 1:10      n2rot f e d     . b a   BC = c
    pop  AF             ; 1:10      n2rot f e       . b a   AF = d
    ex   AF, AF'        ; 1:4       n2rot f e       . b a
    pop  AF             ; 1:10      n2rot f         . b a   AF'= e
    ex   DE, HL         ; 1:4       n2rot f         . a b
    ex  (SP),HL         ; 1:19      n2rot b         . a f
    push DE             ; 1:11      n2rot b a       . a f
    push HL             ; 1:11      n2rot b a f     . a f
    push AF             ; 1:11      n2rot b a f e   . a f
    ex   AF, AF'        ; 1:4       n2rot b a f e   . a f
    push AF             ; 1:11      n2rot b a f e d . a f
    pop  DE             ; 1:10      n2rot b a f e   . d f
    ld    H, B          ; 1:4       n2rot b a f e   . d -
    ld    L, C          ; 1:4       n2rot b a f e   . d c})dnl
dnl
dnl
dnl ( -- a )
dnl push(a) ulozi na zasobnik nasledujici polozku
define({PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro! Maybe you want to use {PUSH2}($1,$2)?})
    push DE             ; 1:11      push($1)
    ex   DE, HL         ; 1:4       push($1)
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      push($1)})dnl
dnl
dnl
dnl ( -- b a)
dnl push2(b,a) ulozi na zasobnik nasledujici polozky
define({PUSH2},{ifelse($#,{2},,{
__{}.error {$0}($@): The wrong number of parameters in macro!}){}ifelse(dnl
__IS_MEM_REF($1),{1},{
    push DE             ; 1:11      push2($1,$2)
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      push2($1,$2)
    push HL             ; 1:11      push2($1,$2)
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{3:16},{3:10})      push2($1,$2)},
__IS_MEM_REF($2),{1},{
    push DE             ; 1:11      push2($1,$2)
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      push2($1,$2)
    push HL             ; 1:11      push2($1,$2)
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{3:16},{3:10})      push2($1,$2)},
eval($1==$2),{},{
    push DE             ; 1:11      push2($1,$2)
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      push2($1,$2)
    push HL             ; 1:11      push2($1,$2)
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{3:16},{3:10})      push2($1,$2)},
{ifelse(dnl
__{}eval($1==$2),{1},{
__{}    push DE             ; 1:11      push2($1,$2)
__{}    push HL             ; 1:11      push2($1,$2)
__{}    ld   HL, format({%-11s},$1); 3:10      push2($1,$2)
__{}    ld    D, H          ; 1:4       push2($1,$2)
__{}    ld    E, L          ; 1:4       push2($1,$2)},
__{}eval((__HEX_H($1) == __HEX_L($2)) && (__HEX_L($1) == __HEX_H($2))),{1},{
__{}    push DE             ; 1:11      push2($1,$2)
__{}    push HL             ; 1:11      push2($1,$2)
__{}    ld   HL, format({%-11s},$2); 3:10      push2($1,$2)
__{}    ld    D, L          ; 1:4       push2($1,$2)
__{}    ld    E, H          ; 1:4       push2($1,$2)},
__{}eval((__HEX_H($1) == __HEX_H($2)) && (__HEX_H($1) == __HEX_L($2))),{1},{
__{}    push DE             ; 1:11      push2($1,$2)
__{}    push HL             ; 1:11      push2($1,$2)
__{}    ld   DE, format({%-11s},$1); 3:10      push2($1,$2)
__{}    ld    H, D          ; 1:4       push2($1,$2)
__{}    ld    L, D          ; 1:4       push2($1,$2)},
__{}eval((__HEX_L($1) == __HEX_H($2)) && (__HEX_L($1) == __HEX_L($2))),{1},{
__{}    push DE             ; 1:11      push2($1,$2)
__{}    push HL             ; 1:11      push2($1,$2)
__{}    ld   DE, format({%-11s},$1); 3:10      push2($1,$2)
__{}    ld    H, E          ; 1:4       push2($1,$2)
__{}    ld    L, E          ; 1:4       push2($1,$2)},
__{}eval((__HEX_H($2) == __HEX_H($1)) && (__HEX_H($2) == __HEX_L($1))),{1},{
__{}    push DE             ; 1:11      push2($1,$2)
__{}    push HL             ; 1:11      push2($1,$2)
__{}    ld   HL, format({%-11s},$2); 3:10      push2($1,$2)
__{}    ld    D, H          ; 1:4       push2($1,$2)
__{}    ld    E, H          ; 1:4       push2($1,$2)},
__{}eval((__HEX_L($2) == __HEX_H($1)) && (__HEX_L($2) == __HEX_L($1))),{1},{
__{}    push DE             ; 1:11      push2($1,$2)
__{}    push HL             ; 1:11      push2($1,$2)
__{}    ld   HL, format({%-11s},$2); 3:10      push2($1,$2)
__{}    ld    D, L          ; 1:4       push2($1,$2)
__{}    ld    E, L          ; 1:4       push2($1,$2)},
__{}{
__{}    push DE             ; 1:11      push2($1,$2)
__{}    ld   DE, format({%-11s},$1); 3:10      push2($1,$2)
__{}    push HL             ; 1:11      push2($1,$2)
__{}    ld   HL, format({%-11s},$2); 3:10      push2($1,$2)})})})dnl
dnl
dnl
dnl drop 50
dnl ( a -- 50 )
dnl zmeni hodnotu top
define({DROP_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      drop $1})dnl
dnl
dnl
dnl 2drop 50
dnl ( a -- 50 )
dnl zmeni hodnotu top
define({_2DROP_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    pop  DE             ; 1:10      2drop $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      2drop $1})dnl
dnl
dnl
dnl dup 50
dnl ( a -- a a 50 )
dnl zmeni hodnotu top
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
dnl # ( -- d )
dnl # PUSHDOT(number32bit) ulozi na zasobnik 32 bitove cislo
dnl # 255. --> ( -- 0x0000 0x00FF )
define({PUSHDOT},{ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
eval($1),{},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      pushdot($1)   ( -- hi lo )
__{}    push HL             ; 1:11      pushdot($1)
__{}    ld   DE,format({%-12s},($1+2)); 4:20      pushdot($1)   hi word
__{}    ld   HL, format({%-11s},$1); 3:16      pushdot($1)   lo word},
{
__{}define({__D},eval((($1)>>24) & 0xff)){}dnl
__{}define({__E},eval((($1)>>16) & 0xff)){}dnl
__{}define({__H},eval((($1)>> 8) & 0xff)){}dnl
__{}define({__L},eval( ($1)      & 0xff)){}dnl
__{}    push DE             ; 1:11      pushdot($1)   ( -- hi lo )
__{}    push HL             ; 1:11      pushdot($1)
__{}ifelse(eval((__E == __L) && (__D == __L)),{1},{dnl
__{}    ld   HL, format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      pushdot($1)   lo_word
__{}    ld    E, L          ; 1:4       pushdot($1)
__{}    ld    D, L          ; 1:4       pushdot($1)   hi word},
__{}eval((__E == __H) && (__D == __H)),{1},{dnl
__{}    ld   HL, format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      pushdot($1)   lo_word
__{}    ld    E, H          ; 1:4       pushdot($1)
__{}    ld    D, H          ; 1:4       pushdot($1)   hi word},
__{}eval((__E == __L) && (__D == __H)),{1},{dnl
__{}    ld   HL, format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      pushdot($1)   lo_word
__{}    ld    E, L          ; 1:4       pushdot($1)
__{}    ld    D, H          ; 1:4       pushdot($1)   hi word},
__{}eval((__E == __H) && (__D == __L)),{1},{dnl
__{}    ld   HL, format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      pushdot($1)   lo_word
__{}    ld    E, H          ; 1:4       pushdot($1)
__{}    ld    D, L          ; 1:4       pushdot($1)   hi word},
__{}eval((__L == __D) && (__H == __D)),{1},{dnl
__{}    ld   DE, format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      pushdot($1)   hi_word
__{}    ld    L, D          ; 1:4       pushdot($1)
__{}    ld    H, D          ; 1:4       pushdot($1)   hi word},
__{}eval((__L == __E) && (__H == __E)),{1},{dnl
__{}    ld   DE, format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      pushdot($1)   hi_word
__{}    ld    L, E          ; 1:4       pushdot($1)
__{}    ld    H, E          ; 1:4       pushdot($1)   hi word},
__{}{dnl
__{}    ld   DE, format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      pushdot($1)   hi_word
__{}    ld   HL, format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      pushdot($1)   lo_word})})}){}dnl
dnl
dnl
dnl
dnl ( ...n3 n2 n1 n0 x -- ...n3 n2 n1 n0 nx )
dnl Remove x. Copy the nx to the top of the stack.
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
dnl 0 pick ( a 0 -- a a )
dnl 1 pick ( b a 1 -- b a b )
dnl 2 pick ( c b a 2 -- c b a c )
dnl 3 pick ( d c b a 3 -- d c b a d )
dnl 4 pick ( e d c b a 4 -- e d c b a e )
dnl u pick ( ...x3 x2 x1 x0 u -- ...x3 x2 x1 x0 xu )
dnl Remove u. Copy the xu to the top of the stack.
define({PUSH_PICK},{ifelse($#,{0},{.error _push_pick(): Parameter is missing!},
__{}eval($1),{},{
    ; warning The condition >>>$1<<< cannot be evaluated
    push DE             ; 1:11      $1 pick
    push HL             ; 1:11      $1 pick
    ld   HL, ifelse(__IS_MEM_REF($1),{1},{format({%-11s},$1); 3:16},{format({%-11s},$1); 3:10})      $1 pick
    add  HL, HL         ; 1:11      $1 pick
    add  HL, SP         ; 1:11      $1 pick
    ld    E,(HL)        ; 1:7       $1 pick
    inc  HL             ; 1:6       $1 pick
    ld    D,(HL)        ; 1:7       $1 pick
    ex   DE, HL         ; 1:4       $1 pick
    pop  DE             ; 1:10      $1 pick},
__{}{ifelse(eval($1),{0},{DUP},
__{}__{}eval($1),{1},{OVER},
__{}__{}eval($1),{2},{
__{}    pop  BC             ; 1:10      2 pick
__{}    push BC             ; 1:11      2 pick
__{}    push DE             ; 1:11      2 pick
__{}    ex   DE, HL         ; 1:4       2 pick
__{}    ld    H, B          ; 1:4       2 pick
__{}    ld    L, C          ; 1:4       2 pick ( c b a -- c b a c )},
__{}__{}eval($1),{3},{
__{}    pop  AF             ; 1:10      3 pick
__{}    pop  BC             ; 1:10      3 pick
__{}    push BC             ; 1:11      3 pick
__{}    push AF             ; 1:11      3 pick
__{}    push DE             ; 1:11      3 pick
__{}    ex   DE, HL         ; 1:4       3 pick
__{}    ld    H, B          ; 1:4       3 pick
__{}    ld    L, C          ; 1:4       3 pick ( d c b a -- d c b a d )},
__{}__{}{
__{}    push DE             ; 1:11      $1 pick
__{}    ex   DE, HL         ; 1:4       $1 pick
__{}    ld   HL, 0x{}format({%04x},eval(2*($1)-2))     ; 3:10      $1 pick
__{}    add  HL, SP         ; 1:11      $1 pick
__{}    ld    A,(HL)        ; 1:7       $1 pick
__{}    inc  HL             ; 1:6       $1 pick
__{}    ld    H,(HL)        ; 1:7       $1 pick
__{}    ld    L, A          ; 1:4       $1 pick ( ...x2 x1 x0 -- ...x2 x1 x0 x$1 )})})})dnl
dnl
dnl
dnl depth
dnl ( -- 0 )
dnl ( x -- x 1 )
dnl ( x x -- x x 2 )
dnl ( -- +n )
dnl +n is the number of single-cell values contained in the data stack before +n was placed on the stack
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
dnl ------------- return address stack ------------------
dnl
dnl >r
dnl ( x -- ) ( R: -- x )
dnl Move x to the return stack.
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
dnl dup >r
dnl ( x -- x ) ( R: -- x )
dnl Copy x to the return stack.
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
dnl r>
dnl ( -- x ) ( R: x -- )
dnl Move x from the return stack to the data stack.
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
dnl r@
dnl ( -- x ) ( R: x -- x )
dnl Copy x from the return stack to the data stack.
define({R_FETCH},{
dnl                        ;[9:64]     r_fetch ( b a -- b a i ) ( R: i -- i )
dnl    exx                 ; 1:4       r_fetch   .
dnl    push HL             ; 1:11      r_fetch r .
dnl    exx                 ; 1:4       r_fetch r . b a
dnl    ex   DE, HL         ; 1:4       r_fetch r . a b
dnl    ex  (SP), HL        ; 1:19      r_fetch b . a r     HL = r.a.s.
dnl    ld    A,(HL)        ; 1:7       r_fetch
dnl    inc   L             ; 1:4       r_fetch
dnl    ld    H,(HL)        ; 1:7       r_fetch
dnl    ld    L, A          ; 1:4       r_fetch b . a i
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
dnl rdrop
dnl r:( a -- )
dnl odstrani vrchol zasobniku navratovych adres
define({RDROP},{
                        ;[4:18]     rdrop
    exx                 ; 1:4       rdrop
    inc   L             ; 1:4       rdrop
    inc   HL            ; 1:6       rdrop
    exx                 ; 1:4       rdrop r:( a -- )})dnl
dnl
dnl
dnl r> r> swap >r >r
dnl 2r> >r >r
dnl r> r> 2>r
dnl 2r> swap 2>r
dnl ( R: x1 x2 -- x2 x1 )
dnl Swap cell x1 x2 in the return stack.
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
dnl ------------------- 32 bits ---------------------
dnl
dnl
dnl 2>r
dnl swap >r >r
dnl ( x1 x2 -- ) ( R: -- x1 x2 )
dnl Transfer cell pair x1 x2 to the return stack.
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
dnl 2r>
dnl r> r> swap
dnl ( -- x1 x2 ) ( R: x1 x2 -- )
dnl Transfer cell pair x1 x2 from the return stack.
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
dnl 2r@
dnl r> r> 2dup >r >r swap
dnl ( -- x1 x2 ) ( R: x1 x2 -- x1 x2 )
dnl Copy cell pair x1 x2 from the return stack.
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
dnl 2rdrop
dnl r:( j i -- )
dnl odstrani dve polozky ze zasobniku navratovych adres
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
dnl r> r> r> r> _2swap >r >r >r >r
dnl 2r> 2r> _2swap 2>r 2>r
dnl ( R: x4 x3 x2 x1 -- x2 x1 )
dnl Swap cell pair x4 x3 and x2 x1 in the return stack.
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

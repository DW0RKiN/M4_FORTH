dnl ## Stack manipulation
define({--},{})dnl
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
define({SWAP_PUSH},{
    push HL             ; 1:11      swap $1
    ld   HL, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:16},{3:10})      swap $1 ( b a -- a b $1 )})dnl
dnl
dnl
dnl 3 swap
dnl ( a -- 3 a )
define({PUSH_SWAP},{
    push DE             ; 1:11      $1 swap
    ld   DE, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      $1 swap ( a -- $1 a )})dnl
dnl
dnl
dnl dup 3 swap
dnl ( a -- a 3 a )
define({DUP_PUSH_SWAP},{
    push DE             ; 1:11      dup $1 swap
    push HL             ; 1:11      dup $1 swap
    ld   DE, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      dup $1 swap ( a -- a $1 a )})dnl
dnl
dnl
dnl ( d c b a -- b a d c )
dnl Exchange the top two cell pairs.
define({_2SWAP},{
                        ;[7:56]     2swap ( d c b a -- b a d c )
    ex   DE, HL         ; 1:4       2swap d c . a b
    pop  BC             ; 1:10      2swap d   . a b     BC = c
    ex  (SP),HL         ; 1:19      2swap b   . a d
    push DE             ; 1:11      2swap b a . a d
    ld    D, B          ; 1:4       2swap
    ld    E, C          ; 1:4       2swap b a . c d
    ex   DE, HL         ; 1:4       2swap b a . d c})dnl
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
dnl ( a b -- a b a b )
dnl over over
define({_2DUP},{
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )})dnl
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
define({PUSH_OVER},{
    push DE             ; 1:11      $1 over
    push HL             ; 1:11      $1 over
    ld   DE, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      $1 over ( a -- a $1 a )})dnl
dnl
dnl
dnl ( a1 a2 b1 b2 -- a1 a2 b1 b2 a1 a2 )
dnl Copy cell pair a1 a2 to the top of the stack.
define({_2OVER},{
                        ;[9:91]     2over ( a1 a2 b1 b2 -- a1 a2 b1 b2 a1 a2 )
    pop  AF             ; 1:10      2over AF = a2
    pop  BC             ; 1:10      2over BC = a1
    push BC             ; 1:11      2over
    push AF             ; 1:11      2over a1 a2       . b1 b2
    push DE             ; 1:11      2over a1 a2 b1    . b1 b2
    push AF             ; 1:11      2over a1 a2 b1 a2 . b1 b2
    ex  (SP),HL         ; 1:19      2over a1 a2 b1 b2 . b1 a2
    ld    D, B          ; 1:4       2over
    ld    E, C          ; 1:4       2over a1 a2 b1 b2 . a1 a2})dnl
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
define({_2ROT},{
                        ;[15:127]   2rot ( f e d c b a -- d c b a f e )
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
    push AF             ; 1:11      2rot d c b a . f e})dnl
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
                        ;[15:140]   n2rot ( f e d c b a -- b a f e d c )
    ex  (SP),HL         ; 1:19      n2rot f e d a   . b c
    push DE             ; 1:11      n2rot f e d a b . b c
    exx                 ; 1:4       n2rot f e d a b .
    pop  DE             ; 1:10      n2rot f e d a   .       DE'= b
    pop  BC             ; 1:10      n2rot f e d     .       BC'= a
    exx                 ; 1:4       n2rot f e d     . b c
    pop  DE             ; 1:10      n2rot f e       . d c
    pop  AF             ; 1:10      n2rot f         . d c   AF = e
    pop  BC             ; 1:10      n2rot           . d c   BC = f
    exx                 ; 1:4       n2rot
    push DE             ; 1:11      n2rot b         .
    push BC             ; 1:11      n2rot b a       .
    exx                 ; 1:4       n2rot b a       . d c
    push BC             ; 1:11      n2rot b a f     . d c
    push AF             ; 1:11      n2rot b a f e   . d c})dnl
dnl
dnl
dnl ( -- a )
dnl push(a) ulozi na zasobnik nasledujici polozku
define({PUSH},{ifelse($#,{1},,{
.error More parameters found in macro! push($@) --> push2($@) ?})
    push DE             ; 1:11      push($1)
    ex   DE, HL         ; 1:4       push($1)
    ld   HL, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:16},{3:10})      push($1)})dnl
dnl
dnl
dnl ( -- b a)
dnl push2(b,a) ulozi na zasobnik nasledujici polozky
define({PUSH2},{ifelse($#,{2},,{
.error The wrong number of parameters in the push2 macro! push2($@)})
    push DE             ; 1:11      push2($1,$2)
    ld   DE, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      push2($1,$2)
    push HL             ; 1:11      push2($1,$2)
    ld   HL, format({%-11s},$2); ifelse(index({$2},{(}),{0},{3:16},{3:10})      push2($1,$2)})dnl
dnl
dnl
dnl drop 50
dnl ( a -- 50 )
dnl zmeni hodnotu top
define({DROP_PUSH},{
    ld   HL, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:16},{3:10})      drop $1})dnl
dnl
dnl
dnl 2drop 50
dnl ( a -- 50 )
dnl zmeni hodnotu top
define({_2DROP_PUSH},{
    pop  DE             ; 1:10      2drop $1
    ld   HL, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:16},{3:10})      2drop $1})dnl
dnl
dnl
dnl dup 50
dnl ( a -- a a 50 )
dnl zmeni hodnotu top
define({DUP_PUSH},{
    push DE             ; 1:11      dup $1
    push HL             ; 1:11      dup $1
    ex   DE, HL         ; 1:4       dup $1
    ld   HL, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:16},{3:10})      dup $1})dnl
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
    ld   HL, ifelse(index({$1},{(}),{0},{format({%-11s},$1); 3:16},{format({%-11s},$1); 3:10})      $1 pick
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
dnl ------------- return address stack ------------------
dnl
dnl >r
dnl ( x -- ) ( R: -- x )
dnl Move x to the return stack.
define({TO_R},{
                        ;[9:72]     to_r
    ex  (SP), HL        ; 1:19      to_r
    ex   DE, HL         ; 1:4       to_r
    exx                 ; 1:4       to_r
    pop  DE             ; 1:10      to_r
    dec  HL             ; 1:6       to_r
    ld  (HL),D          ; 1:7       to_r
    dec   L             ; 1:4       to_r
    ld  (HL),E          ; 1:7       to_r
    exx                 ; 1:4       to_r})dnl
dnl
dnl
dnl r>
dnl ( -- x ) ( R: x -- )
dnl Move x from the return stack to the data stack.
define(R_FROM,{
                        ;[9:66]     r_from
    exx                 ; 1:4       r_from
    ld    E,(HL)        ; 1:7       r_from
    inc   L             ; 1:4       r_from
    ld    D,(HL)        ; 1:7       r_from
    inc  HL             ; 1:6       r_from
    push DE             ; 1:11      r_from
    exx                 ; 1:4       r_from
    ex   DE, HL         ; 1:4       r_from
    ex  (SP), HL        ; 1:19      r_from})dnl
dnl
dnl
dnl r@
dnl ( -- x ) ( R: x -- x )
dnl Copy x from the return stack to the data stack.
define(R_FETCH,{
                        ;[9:64]     r_fetch
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
dnl

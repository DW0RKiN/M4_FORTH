dnl ## Stack manipulation
define({--},{})dnl
dnl
dnl ( x2 x1 -- x1 x2 )
dnl prohodi vrchol zasobniku s druhou polozkou
define({SWAP},{
    ex   DE, HL         ; 1:4       swap})dnl
dnl
dnl ( d c b a -- b a d c )
dnl Exchange the top two cell pairs.
define({_2SWAP},{
    ex  (SP),HL         ; 1:19      2swap d a b c
    pop  AF             ; 1:10      2swap d b c
    pop  BC             ; 1:10      2swap b c
    push DE             ; 1:11      2swap b b c 
    push AF             ; 1:11      2swap b a b c
    ld    D, B          ; 1:4       2swap
    ld    E, C          ; 1:4       2swap})dnl
dnl
dnl
dnl ( x1 -- x1 x1 )
dnl vytvori kopii vrcholu zasobniku
define({DUP},{
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup})dnl
dnl
dnl
dnl 2dup
dnl ( a b -- a b a b )
dnl over over
define({_2DUP},{
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup})dnl
dnl
dnl
dnl ( x1 -- )
dnl odstrani vrchol zasobniku
define({DROP},{
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop})dnl
dnl
dnl
dnl 2drop
dnl ( b a -- ) 
dnl odstrani 2x vrchol zasobniku
define({_2DROP},{
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop})dnl
dnl
dnl
dnl ( b a -- a )
dnl : nip swap drop ;
dnl drop_second
define({NIP},{
    pop  DE             ; 1:10      nip})dnl
dnl
dnl
dnl ( b a -- a b a )
dnl : tuck swap over ;
define({TUCK},{
    push HL             ; 1:11      tuck})dnl
dnl
dnl
dnl ( b a -- b a b )
dnl vytvori kopii druhe polozky na zasobniku
define({OVER},{
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over})dnl
dnl
dnl
dnl ( a1 a2 b1 b2 -- a1 a2 b1 b2 a1 a2 )
dnl Copy cell pair a1 a2 to the top of the stack.
define({_2OVER},{
    pop  AF             ; 1:10      2over AF = a2
    pop  BC             ; 1:10      2over BC = a1      
    push BC             ; 1:11      2over
    push AF             ; 1:11      2over a1 a2 b1 b2
    push DE             ; 1:11      2over a1 a2 b1 b1 b2
    push AF             ; 1:11      2over a1 a2 b1 a2 b1 b2      
    ex  (SP),HL         ; 1:19      2over a1 a2 b1 b2 b1 a2
    pop  HL             ; 1:10      2over       
    ld    D, B          ; 1:4       2over
    ld    E, C          ; 1:4       2over})dnl
dnl
dnl
dnl ( x3 x2 x1 -- x2 x1 x3 )
dnl vyjme treti polozku a ulozi ji na vrchol
define({ROT},{
    ex   DE, HL         ; 1:4       rot ( x3 x1 x2 )
    ex  (SP), HL        ; 1:19      rot ( x2 x1 x3 )})dnl
dnl
dnl
dnl -rot
dnl ( x3 x2 x1 -- x1 x3 x2 )
dnl vyjme vrchol zasobniku a ulozi ho jako treti polozku
define({RROT},{
    ex  (SP), HL        ; 1:19      rrot ( x1 x2 x3 )
    ex   DE, HL         ; 1:4       rrot ( x1 x3 x2 )})dnl
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
dnl ( ...x3 x2 x1 x0 u -- ...x3 x2 x1 x0 xu ) 
dnl Remove u. Copy the xu to the top of the stack.
define({PICK},{
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
__{}eval($1),{0},{DUP},
__{}eval($1),{1},{OVER},
__{}eval($1),{2},{ 
    pop  BC             ; 1:10      2 pick
    push BC             ; 1:11      2 pick BC = c
    push DE             ; 1:11      2 pick c b b a
    ex   DE, HL         ; 1:4       2 pick c b a b
    ld    H, B          ; 1:4       2 pick
    ld    L, C          ; 1:4       2 pick c b a c},
__{}eval($1),{3},{ 
    pop  AF             ; 1:10      3 pick
    pop  BC             ; 1:10      3 pick
    push BC             ; 1:11      3 pick BC = d
    push AF             ; 1:11      3 pick
    push DE             ; 1:11      3 pick d c b b a
    ex   DE, HL         ; 1:4       3 pick d c b a b
    ld    H, B          ; 1:4       3 pick
    ld    L, C          ; 1:4       3 pick d c b a c},
__{}{
    push DE             ; 1:11      $1 pick
    ex   DE, HL         ; 1:4       $1 pick
    ld   HL, 0x{}format({%04x},eval(2*(($1)-1)))     ; 3:10      $1 pick
    add  HL, SP         ; 1:11      $1 pick
    ld    A,(HL)        ; 1:7       $1 pick
    inc  HL             ; 1:6       $1 pick
    ld    H,(HL)        ; 1:7       $1 pick
    ld    L, A          ; 1:4       $1 pick})})dnl
dnl
dnl
dnl >r
dnl ( x -- ) ( R: -- x )
dnl Move x to the return stack.
define({TO_R},{
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
    exx                 ; 1:4       r_fetch
    ld    E,(HL)        ; 1:7       r_fetch
    inc   L             ; 1:4       r_fetch
    ld    D,(HL)        ; 1:7       r_fetch
    dec   L             ; 1:6       r_fetch
    push DE             ; 1:11      r_fetch
    exx                 ; 1:4       r_fetch
    ex   DE, HL         ; 1:4       r_fetch
    ex  (SP), HL        ; 1:19      r_fetch})dnl
dnl
dnl

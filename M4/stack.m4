dnl ## Stack manipulation
dnl
dnl ( x2 x1 -- x1 x2 )
dnl prohodi vrchol zasobniku s druhou polozkou
define({SWAP},{
    ex   DE, HL         ; 1:4       swap})dnl
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
define({DUP2},{
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
dnl ( a b -- ) 
dnl odstrani 2x vrchol zasobniku
define({DROP2},{
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop})dnl
dnl
dnl
dnl ( a b -- b )
dnl : nip swap drop ;
dnl drop_second
define({NIP},{
    pop  DE             ; 1:10      nip})dnl
dnl
dnl
dnl ( a b -- b a b )
dnl : tuck swap over ;
define({TUCK},{
    push HL             ; 1:11      tuck})dnl
dnl
dnl
dnl ( x2 x1 -- x2 x1 x2 )
dnl vytvori kopii druhe polozky na zasobniku
define({OVER},{
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over})dnl
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
define({PUSH},{
    push DE             ; 1:11      push($1)
    ex   DE, HL         ; 1:4       push($1)
    ld   HL, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:16},{3:10})      push($1)})dnl
dnl
dnl
dnl ( -- b a) 
dnl push2(b,a) ulozi na zasobnik nasledujici polozky
define({PUSH2},{
    push DE             ; 1:11      push2($1,$2)
    ld   DE, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      push2($1,$2)
    push HL             ; 1:11      push2($1,$2)
    ld   HL, format({%-11s},$2); ifelse(index({$2},{(}),{0},{3:16},{3:10})      push2($1,$2)})dnl
dnl
dnl
dnl DROP_PUSH(50)
dnl ( a -- 50 ) 
dnl zmeni hodnotu top
define({DROP_PUSH},{
    ld   HL, format({%-11s},$1); 3:10      drop_push})dnl
dnl
dnl
dnl 0 pick ( a 0 -- a a )
dnl ( a -- a a ) 
dnl zmeni hodnotu top
define({XPICK0},{
    DUP})dnl
dnl
dnl
dnl 1 pick ( b a 1 -- b a b )
dnl ( b a -- b a b ) 
dnl zmeni hodnotu top
define({XPICK1},{
    OVER})dnl
dnl
dnl
dnl 2 pick ( c b a 2 -- c b a c )
dnl ( c b a -- c b a c )
dnl zmeni hodnotu top
define({XPICK2},{
    pop  BC             ; 1:10      xpick2
    push BC             ; 1:11      xpick2
    ex   DE, HL         ; 1:4       xpick2
    ex   (SP),HL        ; 1:19      xpick2})dnl
dnl
dnl
dnl 3 pick ( d c b a 3 -- d c b a d )
dnl ( d c b a -- d c b a d ) 
dnl zmeni hodnotu top
define({XPICK3},{
    pop  AF             ; 1:10      xpick3
    pop  BC             ; 1:10      xpick3
    push BC             ; 1:11      xpick3
    push AF             ; 1:11      xpick3
    ex   DE, HL         ; 1:4       xpick3
    ex   (SP),HL        ; 1:19      xpick3})dnl
dnl
dnl
dnl >r
dnl ( x -- ) ( R: -- x )
dnl Move x to the return stack.
define({RAS_PUSH},{
    ex  (SP), HL        ; 1:19      rpush
    ex   DE, HL         ; 1:4       rpush
    exx                 ; 1:4       rpush
    pop  DE             ; 1:10      rpush
    dec  HL             ; 1:6       rpush
    ld  (HL),D          ; 1:7       rpush
    dec   L             ; 1:4       rpush
    ld  (HL),E          ; 1:7       rpush
    exx                 ; 1:4       rpush})dnl
dnl
dnl
dnl r>
dnl ( -- x ) ( R: x -- )
dnl Move x from the return stack to the data stack.
define(RAS_POP,{    
    exx                 ; 1:4       rpop
    ld    E,(HL)        ; 1:7       rpop
    inc   L             ; 1:4       rpop
    ld    D,(HL)        ; 1:7       rpop
    inc  HL             ; 1:6       rpop
    push DE             ; 1:11      rpop
    exx                 ; 1:4       rpop
    ex   DE, HL         ; 1:4       rpop
    ex  (SP), HL        ; 1:19      rpop})dnl
dnl
dnl

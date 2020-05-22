define(LOOP_COUNT,100)dnl
dnl
dnl
dnl ( stop index -- )
define(DO,{define({LOOP_COUNT}, incr(LOOP_COUNT))pushdef({LOOP_STACK}, LOOP_COUNT)
    push HL             ; 1:11      do LOOP_STACK index
    push DE             ; 1:11      do LOOP_STACK stop
    exx                 ; 1:4       do LOOP_STACK
    pop  DE             ; 1:10      do LOOP_STACK stop
    dec  HL             ; 1:6       do LOOP_STACK
    ld  (HL),D          ; 1:7       do LOOP_STACK
    dec  L              ; 1:4       do LOOP_STACK
    ld  (HL),E          ; 1:7       do LOOP_STACK stop
    pop  DE             ; 1:10      do LOOP_STACK index
    dec  HL             ; 1:6       do LOOP_STACK
    ld  (HL),D          ; 1:7       do LOOP_STACK
    dec  L              ; 1:4       do LOOP_STACK
    ld  (HL),E          ; 1:7       do LOOP_STACK index
    exx                 ; 1:4       do LOOP_STACK
    pop  HL             ; 1:10      do LOOP_STACK
    pop  DE             ; 1:10      do LOOP_STACK
do{}LOOP_STACK:})dnl
dnl
define(UNLOOP,{
    exx                 ; 1:4       unloop LOOP_STACK
    inc  L              ; 1:4       unloop LOOP_STACK
    inc  HL             ; 1:6       unloop LOOP_STACK
    inc  L              ; 1:4       unloop LOOP_STACK
    inc  HL             ; 1:6       unloop LOOP_STACK
    exx                 ; 1:4       unloop LOOP_STACK})dnl
dnl
dnl
dnl ( -- i )
dnl hodnota indexu vnitrni smycky
define({I},{
    exx                 ; 1:4       index LOOP_STACK i    
    ld   E,(HL)         ; 1:7       index LOOP_STACK i
    inc  L              ; 1:4       index LOOP_STACK i
    ld   D,(HL)         ; 1:7       index LOOP_STACK i
    push DE             ; 1:11      index LOOP_STACK i
    dec  L              ; 1:4       index LOOP_STACK i
    exx                 ; 1:4       index LOOP_STACK i
    ex   DE, HL         ; 1:4       index LOOP_STACK i
    ex  (SP), HL        ; 1:19      index LOOP_STACK i})dnl
dnl
dnl
dnl ( -- j )
dnl hodnota indexu druhe vnitrni smycky
define({J},{
    exx                 ; 1:4       index LOOP_STACK j
    ld   DE, 0x0004     ; 3:10      index LOOP_STACK j
    ex   DE, HL         ; 1:4       index LOOP_STACK j
    add  HL, DE         ; 1:11      index LOOP_STACK j
    ld   C,(HL)         ; 1:7       index LOOP_STACK j lo    
    inc  L              ; 1:4       index LOOP_STACK j
    ld   B,(HL)         ; 1:7       index LOOP_STACK j hi
    ex   DE, HL         ; 1:4       index LOOP_STACK j
    push BC             ; 1:11      index LOOP_STACK j
    exx                 ; 1:4       index LOOP_STACK j
    ex   DE, HL         ; 1:4       index LOOP_STACK j
    ex  (SP), HL        ; 1:19      index LOOP_STACK j})dnl
dnl
dnl
dnl ( -- )
define(LOOP,{
    exx                 ; 1:4       loop LOOP_STACK
    ld   E,(HL)         ; 1:7       loop LOOP_STACK
    inc  L              ; 1:4       loop LOOP_STACK
    ld   D,(HL)         ; 1:7       loop LOOP_STACK DE = index   
    inc  HL             ; 1:6       loop LOOP_STACK
    inc  DE             ; 1:6       loop LOOP_STACK index + 1
    ld    A, E          ; 1:4       loop LOOP_STACK
    sub (HL)            ; 1:7       loop LOOP_STACK lo index - stop
    ld    A, D          ; 1:4       loop LOOP_STACK
    inc   L             ; 1:4       loop LOOP_STACK
    sbc  A,(HL)         ; 1:7       loop LOOP_STACK hi index - stop
    jr  nc, $+11        ; 2:7/12    loop LOOP_STACK exit
    dec  L              ; 1:4       loop LOOP_STACK
    dec  HL             ; 1:6       loop LOOP_STACK
    ld  (HL), D         ; 1:7       loop LOOP_STACK
    dec  L              ; 1:4       loop LOOP_STACK
    ld  (HL), E         ; 1:7       loop LOOP_STACK
    exx                 ; 1:4       loop LOOP_STACK
    jp   do{}LOOP_STACK          ; 3:10      loop LOOP_STACK
    inc  HL             ; 1:6       loop LOOP_STACK
    exx                 ; 1:4       loop LOOP_STACK{}popdef({LOOP_STACK})})dnl
dnl
dnl
dnl ---------- S L O O P ------------
dnl Stack Loop
dnl 5 0 sdo . sloop --> 0 1 2 3 4 
dnl Use data stack
dnl
dnl ( stop index -- stop index )
define({SDO}, {define({LOOP_COUNT}, incr(LOOP_COUNT))pushdef({LOOP_STACK}, LOOP_COUNT)
sdo{}LOOP_STACK:                 ;           sdo LOOP_STACK stack: ( stop index )})dnl
dnl
dnl
dnl
dnl Discard the loop-control parameters for the current nesting level.
define({UNSLOOP},{
    pop  HL             ; 1:10      unsloop LOOP_STACK index out
    pop  DE             ; 1:10      unsloop LOOP_STACK stop  out})dnl
dnl
dnl
dnl ( i -- i i )
dnl To same co DUP
dnl dalsi indexy nejsou definovany, protoze neni jiste jak to na zasobniku vypada. Pokud je tam hned dalsi smycka tak J lezi na (SP), K lezi na (SP+4)
define({SI}, {
    DUP})dnl
dnl
dnl
dnl
dnl ( stop index -- stop index++ )
define({SLOOP},{
    inc  HL             ; 1:6       sloop LOOP_STACK index++
    ld   A, L           ; 1:4       sloop LOOP_STACK
    sub  E              ; 1:4       sloop LOOP_STACK lo index - stop
    ld   A, H           ; 1:4       sloop LOOP_STACK
    sbc  A, D           ; 1:4       sloop LOOP_STACK hi index - stop
    jp   c, sdo{}LOOP_STACK      ; 3:10      sloop LOOP_STACK{}popdef({LOOP_STACK}){}UNSLOOP})dnl
dnl
dnl
dnl
dnl ---------- S Z L O O P ------------
dnl Stack Zero Loop
dnl 5 szdo . szloop --> 5 4 3 2 1 
dnl Use data stack
dnl
dnl ( index -- index )
dnl stop = 0
define({SZDO}, {define({LOOP_COUNT}, incr(LOOP_COUNT))pushdef({LOOP_STACK}, LOOP_COUNT)
szdo{}LOOP_STACK:                ;           szdo LOOP_STACK stack: ( index )})dnl
dnl
dnl
dnl
dnl Discard the loop-control parameters for the current nesting level.
define({UNSZLOOP},{
    ex   DE, HL         ; 1:4       unszloop LOOP_STACK
    pop  DE             ; 1:10      unszloop LOOP_STACK})dnl
dnl
dnl
dnl ( i -- i i )
dnl To same co DUP
dnl dalsi indexy nejsou definovany, protoze neni jiste jak to na zasobniku vypada. Pokud je tam hned dalsi smycka tak J lezi v DE, K lezi na (SP)
define({SZI}, {
    DUP})dnl
dnl
dnl
dnl
dnl ( index -- index-1 )
define({SZLOOP},{
    dec  HL             ; 1:6       szloop LOOP_STACK index--
    ld   A, H           ; 1:4       szloop LOOP_STACK
    or   L              ; 1:4       szloop LOOP_STACK
    jp  nz, szdo{}LOOP_STACK     ; 3:10      szloop LOOP_STACK{}popdef({LOOP_STACK}){}UNSZLOOP})dnl
dnl
dnl
dnl
dnl ---------- X L O O P ------------
dnl Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl
dnl
dnl ( -- ) 
dnl xdo(stop,index) ... xloop
dnl xdo(stop,index) ... plusxloop(step)
define({XDO},{define({LOOP_COUNT}, incr(LOOP_COUNT))pushdef({LOOP_STACK}, LOOP_COUNT)pushdef({STOP_STACK}, $1)pushdef({INDEX_STACK}, $2)
    exx                 ; 1:4       xdo LOOP_STACK
    dec  HL             ; 1:6       xdo LOOP_STACK
    ld  (HL),high format({%-6s},$2); 2:10      xdo LOOP_STACK
    dec   L             ; 1:4       xdo LOOP_STACK
    ld  (HL),low format({%-7s},$2); 2:10      xdo LOOP_STACK
    exx                 ; 1:4       xdo LOOP_STACK
xdo{}LOOP_STACK:                 ;           xdo LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- )
dnl Discard the loop-control parameters for the current nesting level.
define({UNXLOOP},{
    exx                 ; 1:4       unxloop LOOP_STACK
    inc   L             ; 1:4       unxloop LOOP_STACK
    inc  HL             ; 1:6       unxloop LOOP_STACK
    exx                 ; 1:4       unxloop LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- )
define({XLOOP},{
    exx                 ; 1:4       xloop LOOP_STACK
ifelse({1},eval((STOP_STACK<256)&&(INDEX_STACK<STOP_STACK)),{    inc (HL)            ; 1:7       xloop LOOP_STACK index_lo++
    ld    A, format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK
    scf                 ; 1:4       xloop LOOP_STACK
    sbc   A, (HL)       ; 1:7       xloop LOOP_STACK stop_lo - index_lo - 1
    exx                 ; 1:4       xloop LOOP_STACK
    jp   nc,xdo{}LOOP_STACK      ; 3:10      xloop LOOP_STACK again
    exx                 ; 1:4       xloop LOOP_STACK
    inc   L             ; 1:4       xloop LOOP_STACK},{    ld    E,(HL)        ; 1:7       xloop LOOP_STACK
    inc   L             ; 1:4       xloop LOOP_STACK
    ld    D,(HL)        ; 1:7       xloop LOOP_STACK
    inc  DE             ; 1:6       xloop LOOP_STACK index++
    ld    A, low format({%-7s},STOP_STACK); 2:7       xloop LOOP_STACK
    scf                 ; 1:4       xloop LOOP_STACK
    sbc   A, E          ; 1:4       xloop LOOP_STACK stop_lo - index_lo - 1
    ld    A, high format({%-6s},STOP_STACK); 2:7       xloop LOOP_STACK
    sbc   A, D          ; 1:4       xloop LOOP_STACK stop_hi - index_hi - 1
    jr    c, $+9        ; 2:7/12    xloop LOOP_STACK exit
    ld  (HL), D         ; 1:7       xloop LOOP_STACK
    dec   L             ; 1:4       xloop LOOP_STACK
    ld  (HL), E         ; 1:6       xloop LOOP_STACK
    exx                 ; 1:4       xloop LOOP_STACK
    jp   xdo{}LOOP_STACK         ; 3:10      xloop LOOP_STACK})
    inc  HL             ; 1:6       xloop LOOP_STACK
    exx                 ; 1:4       xloop LOOP_STACK{}popdef({LOOP_STACK})popdef({STOP_STACK})popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl ( -- )
dnl xdo(stop,index) ... plusxloop(step)
define({PLUSXLOOP},{
    exx                 ; 1:4       plusxloop LOOP_STACK
    ld    A, low format({%-7s},$1); 2:7       plusxloop LOOP_STACK
    add   A, (HL)       ; 1:7       plusxloop LOOP_STACK
    ld    E, A          ; 1:4       plusxloop LOOP_STACK lo index
    inc   L             ; 1:4       plusxloop LOOP_STACK
    ld    A, high format({%-6s},$1); 2:7       plusxloop LOOP_STACK
    adc   A, (HL)       ; 1:7       plusxloop LOOP_STACK
    ld  (HL), A         ; 1:7       plusxloop LOOP_STACK hi index
ifelse({1},eval((STOP_STACK-INDEX_STACK-1)/$1 != (65535-INDEX_STACK)/$1 ),{    ld    A, E          ; 1:4       plusxloop LOOP_STACK
    sub   low format({%-10s},STOP_STACK); 2:7       plusxloop LOOP_STACK
    ld    A, (HL)       ; 1:7       plusxloop LOOP_STACK
    sbc   A, high format({%-6s},STOP_STACK); 2:7       plusxloop LOOP_STACK index - stop
    jr   nc, $+8        ; 2:7/12    plusxloop LOOP_STACK
    dec   L             ; 1:4       plusxloop LOOP_STACK
    ld  (HL), E         ; 1:7       plusxloop LOOP_STACK
    exx                 ; 1:4       plusxloop LOOP_STACK
    jp   xdo{}LOOP_STACK         ; 3:10      plusxloop LOOP_STACK},{    dec   L             ; 1:4       plusxloop LOOP_STACK
    ld  (HL), E         ; 1:7       plusxloop LOOP_STACK
    exx                 ; 1:4       plusxloop LOOP_STACK
    jp   nc, xdo{}LOOP_STACK     ; 3:10      plusxloop LOOP_STACK})
    inc  HL             ; 1:6       plusxloop LOOP_STACK
    exx                 ; 1:4       plusxloop LOOP_STACK{}popdef({LOOP_STACK})popdef({STOP_STACK})popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl ( -- i )
dnl hodnota indexu vnitrni smycky
define({XI},{
    exx                 ; 1:4       index xi LOOP_STACK    
    ld    A,(HL)        ; 1:7       index xi LOOP_STACK lo
    inc   L             ; 1:4       index xi LOOP_STACK
    ex   AF, AF'        ; 1:4       index xi LOOP_STACK
    ld    A,(HL)        ; 1:7       index xi LOOP_STACK hi
    dec   L             ; 1:4       index xi LOOP_STACK
    exx                 ; 1:4       index xi LOOP_STACK
    push DE             ; 1:11      index xi LOOP_STACK
    ex   DE, HL         ; 1:4       index xi LOOP_STACK
    ld    H, A          ; 1:4       index xi LOOP_STACK
    ex   AF, AF'        ; 1:4       index xi LOOP_STACK
    ld    L, A          ; 1:4       index xi LOOP_STACK
;   exx                 ; 1:4       index xi LOOP_STACK
;   ld    E,(HL)        ; 1:7       index xi LOOP_STACK
;   inc   L             ; 1:4       index xi LOOP_STACK
;   ld    D,(HL)        ; 1:7       index xi LOOP_STACK
;   push DE             ; 1:11      index xi LOOP_STACK
;   dec   L             ; 1:4       index xi LOOP_STACK
;   exx                 ; 1:4       index xi LOOP_STACK
;   ex   DE, HL         ; 1:4       index xi LOOP_STACK ( i x2 x1 -- i  x1 x2 )
;   ex  (SP),HL         ; 1:19      index xi LOOP_STACK ( i x1 x2 -- x2 x1 i )})dnl
dnl
dnl
dnl
dnl ( -- j )
dnl hodnota indexu druhe vnitrni smycky
define({XJ},{
    exx                 ; 1:4       index xj LOOP_STACK    
    ld    E, L          ; 1:4       index xj LOOP_STACK
    ld    D, H          ; 1:4       index xj LOOP_STACK
    inc   L             ; 1:4       index xj LOOP_STACK
    inc  HL             ; 1:6       index xj LOOP_STACK
    ld    C,(HL)        ; 1:7       index xj LOOP_STACK lo    
    inc   L             ; 1:4       index xj LOOP_STACK
    ld    B,(HL)        ; 1:7       index xj LOOP_STACK hi
    push BC             ; 1:11      index xj LOOP_STACK
    ex   DE, HL         ; 1:4       index xj LOOP_STACK
    exx                 ; 1:4       index xj LOOP_STACK
    ex   DE, HL         ; 1:4       index xj LOOP_STACK ( j x2 x1 -- j  x1 x2 )
    ex  (SP),HL         ; 1:19      index xj LOOP_STACK ( j x1 x2 -- x2 x1 j )})dnl
dnl
dnl
dnl
dnl ( -- k )
dnl hodnota indexu treti vnitrni smycky
define({XK},{
    exx                 ; 1:4       index xk LOOP_STACK    
    ld   DE, 0x0004     ; 3:10      index xk LOOP_STACK
    ex   DE, HL         ; 1:4       index xk LOOP_STACK
    add  HL, DE         ; 1:11      index xk LOOP_STACK
    ld    C,(HL)        ; 1:7       index xk LOOP_STACK lo    
    inc   L             ; 1:4       index xk LOOP_STACK
    ld    B,(HL)        ; 1:7       index xk LOOP_STACK hi
    ex   DE, HL         ; 1:4       index xk LOOP_STACK
    push BC             ; 1:11      index xk LOOP_STACK
    exx                 ; 1:4       index xk LOOP_STACK
    ex   DE, HL         ; 1:4       index xk LOOP_STACK ( k x2 x1 -- k  x1 x2 )
    ex  (SP),HL         ; 1:19      index xk LOOP_STACK ( k x1 x2 -- x2 x1 k )

;   exx                 ; 1:4    
;   ld    A, 0x04       ; 2:7
;   add   A, L          ; 1:4
;   ld    E, A          ; 1:4
;   adc   A, H          ; 1:4
;   sub   E             ; 1:4
;   ld    D, A          ; 1:4
;   ld    A,(DE)        ; 1:7       lo    
;   inc   E             ; 1:4
;   ex   AF, AF'        ; 1:4
;   ld    A,(DE)        ; 1:7       hi
;   exx                 ; 1:4    
;   push DE             ; 1:11
;   ex   DE, HL         ; 1:4    
;   ld    H, A          ; 1:4
;   ex   AF, AF'        ; 1:4    
;   ld    L, A          ; 1:4})dnl
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
    jp    z, repeat{}BEGIN_STACK  ; 3:10      while BEGIN_STACK})dnl
dnl
dnl
dnl ( -- )
define({REPEAT},{
    jp   begin{}BEGIN_STACK       ; 3:10      repeat BEGIN_STACK
repeat{}BEGIN_STACK:{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( -- )
define({AGAIN},{
    jp   begin{}BEGIN_STACK       ; 3:10      again BEGIN_STACK{}popdef({BEGIN_STACK})})dnl
dnl
dnl
dnl ( flag -- )
define({UNTIL},{
    ld    A, H          ; 1:4       until BEGIN_STACK
    or    L             ; 1:4       until BEGIN_STACK
    ex   DE, HL         ; 1:4       until BEGIN_STACK
    pop  DE             ; 1:10      until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      until BEGIN_STACK})dnl
dnl
dnl

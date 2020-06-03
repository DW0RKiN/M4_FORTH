dnl ## Loop
define({__},{})dnl
define(LOOP_COUNT,100)dnl
dnl
dnl Discard the loop-control parameters for the current nesting level.
define({UNLOOP},{UNLOOP_STACK}){}dnl
dnl
dnl Leaves the loop.
define({LEAVE},{LEAVE_STACK}){}dnl
dnl
dnl
dnl ---------  do ... loop  -----------
dnl 5 0 do i . loop --> 0 1 2 3 4 
dnl ( stop index -- ) r:( -- stop index )
define(DO,{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       leave LOOP_STACK
__{}    inc  L              ; 1:4       leave LOOP_STACK
__{}    inc  HL             ; 1:6       leave LOOP_STACK
__{}    inc  L              ; 1:4       leave LOOP_STACK
__{}    jp   leave{}LOOP_STACK       ;           leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       unloop LOOP_STACK
__{}    inc  L              ; 1:4       unloop LOOP_STACK
__{}    inc  HL             ; 1:6       unloop LOOP_STACK
__{}    inc  L              ; 1:4       unloop LOOP_STACK
__{}    inc  HL             ; 1:6       unloop LOOP_STACK
__{}    exx                 ; 1:4       unloop LOOP_STACK})
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
    pop  DE             ; 1:10      do LOOP_STACK ( stop index -- ) r: ( -- stop index )
do{}LOOP_STACK:})dnl
dnl
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
    jr  nc, leave{}LOOP_STACK    ; 2:7/12    loop LOOP_STACK exit
    dec  L              ; 1:4       loop LOOP_STACK
    dec  HL             ; 1:6       loop LOOP_STACK
    ld  (HL), D         ; 1:7       loop LOOP_STACK
    dec  L              ; 1:4       loop LOOP_STACK
    ld  (HL), E         ; 1:7       loop LOOP_STACK
    exx                 ; 1:4       loop LOOP_STACK
    jp   do{}LOOP_STACK          ; 3:10      loop LOOP_STACK
leave{}LOOP_STACK:
    inc  HL             ; 1:6       loop LOOP_STACK
    exx                 ; 1:4       loop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl ( -- )
define(_2ADDLOOP,{
    exx                 ; 1:4       loop LOOP_STACK
    ld   E,(HL)         ; 1:7       loop LOOP_STACK
    inc  L              ; 1:4       loop LOOP_STACK
    ld   D,(HL)         ; 1:7       loop LOOP_STACK DE = index   
    inc  HL             ; 1:6       loop LOOP_STACK
    inc  DE             ; 1:6       loop LOOP_STACK
    inc  DE             ; 1:6       loop LOOP_STACK index + 2
    ld    A, E          ; 1:4       loop LOOP_STACK
    sub (HL)            ; 1:7       loop LOOP_STACK lo index - stop
    ld    A, D          ; 1:4       loop LOOP_STACK
    inc   L             ; 1:4       loop LOOP_STACK
    sbc  A,(HL)         ; 1:7       loop LOOP_STACK hi index - stop
    jr  nc, leave{}LOOP_STACK    ; 2:7/12    loop LOOP_STACK exit
    dec  L              ; 1:4       loop LOOP_STACK
    dec  HL             ; 1:6       loop LOOP_STACK
    ld  (HL), D         ; 1:7       loop LOOP_STACK
    dec  L              ; 1:4       loop LOOP_STACK
    ld  (HL), E         ; 1:7       loop LOOP_STACK
    exx                 ; 1:4       loop LOOP_STACK
    jp   do{}LOOP_STACK          ; 3:10      loop LOOP_STACK
leave{}LOOP_STACK:
    inc  HL             ; 1:6       loop LOOP_STACK
    exx                 ; 1:4       loop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl ---------  sdo ... sloop  -----------
dnl 5 0 sdo . sloop --> 0 1 2 3 4 
dnl ( stop index -- stop index )
define({SDO}, {ifelse($#,{0},,{
.error Unexpected parameter: sdo($@) --> push($@) sdo ?})
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   sleave{}LOOP_STACK      ; 3:10      sleave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    pop  HL             ; 1:10      unsloop LOOP_STACK index out
__{}    pop  DE             ; 1:10      unsloop LOOP_STACK stop  out})
sdo{}LOOP_STACK:                 ;           sdo LOOP_STACK ( stop index -- stop index )})dnl
dnl
dnl
dnl ( i -- i i )
dnl To same co DUP
dnl dalsi indexy nejsou definovany, protoze neni jiste jak to na zasobniku vypada. Pokud je tam hned dalsi smycka tak J lezi na (SP), K lezi na (SP+4)
define({SI}, {
    DUP})dnl
dnl
dnl
dnl ( j s i -- j s i j )
dnl 2 pick 
dnl dalsi indexy nejsou definovany, protoze neni jiste jak to na zasobniku vypada. Pokud je tam hned dalsi smycka tak J lezi na (SP), K lezi na (SP+4)
define({SJ}, {
    PUSH_PICK(2)})dnl
dnl
dnl
dnl
dnl ( stop index -- stop index++ )
define({SLOOP},{
    inc  HL             ; 1:6       sloop LOOP_STACK index++
    ld   A, L           ; 1:4       sloop LOOP_STACK
    sub  E              ; 1:4       sloop LOOP_STACK lo index - stop
    ld   A, H           ; 1:4       sloop LOOP_STACK
    sbc  A, D           ; 1:4       sloop LOOP_STACK hi index - stop - carry
    jp   c, sdo{}LOOP_STACK      ; 3:10      sloop LOOP_STACK
sleave{}LOOP_STACK:              ;           sloop LOOP_STACK{}dnl
__{}UNLOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl ---------  for ... next  -----------
dnl 5 for dup . next --> 5 4 3 2 1 0
dnl ( index -- ) r: ( -- index )
dnl stop = 0
define({FOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       for leave LOOP_STACK
__{}    inc  L              ; 1:4       for leave LOOP_STACK
__{}    jp   next{}LOOP_STACK       ;           for leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       for unloop LOOP_STACK
__{}    inc  L              ; 1:4       for unloop LOOP_STACK
__{}    inc  HL             ; 1:6       for unloop LOOP_STACK
__{}    exx                 ; 1:4       for unloop LOOP_STACK})
    push HL             ; 1:11      for LOOP_STACK index
    exx                 ; 1:4       for LOOP_STACK
    pop  DE             ; 1:10      for LOOP_STACK stop
    dec  HL             ; 1:6       for LOOP_STACK
    ld  (HL),D          ; 1:7       for LOOP_STACK
    dec  L              ; 1:4       for LOOP_STACK
    ld  (HL),E          ; 1:7       for LOOP_STACK stop
    exx                 ; 1:4       for LOOP_STACK
    ex   DE, HL         ; 1:4       for LOOP_STACK
    pop  DE             ; 1:10      for LOOP_STACK ( index -- ) r: ( -- index )
for{}LOOP_STACK:                 ;           for LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( index -- index-1 )
define({NEXT},{
    exx                 ; 1:4       next LOOP_STACK
    ld    E,(HL)        ; 1:7       next LOOP_STACK
    inc   L             ; 1:4       next LOOP_STACK
    ld    D,(HL)        ; 1:7       next LOOP_STACK DE = index   
    ld    A, E          ; 1:4       next LOOP_STACK
    or    D             ; 1:4       next LOOP_STACK
    jr    z, next{}LOOP_STACK    ; 2:7/12    next LOOP_STACK exit
    dec  DE             ; 1:6       next LOOP_STACK index--
    ld  (HL),D          ; 1:7       next LOOP_STACK
    dec   L             ; 1:4       next LOOP_STACK
    ld  (HL),E          ; 1:7       next LOOP_STACK
    exx                 ; 1:4       next LOOP_STACK
    jp   for{}LOOP_STACK         ; 3:10      next LOOP_STACK
next{}LOOP_STACK:                ;           next LOOP_STACK
    inc  HL             ; 1:6       next LOOP_STACK
    exx                 ; 1:4       next LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl ---------  sfor ... snext -----------
dnl 5 sfor dup . snext --> 5 4 3 2 1 0
dnl ( index -- index )
dnl stop = 0
define({SFOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   snext{}LOOP_STACK       ; 3:10      sfor leave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    ex   DE, HL         ; 1:4       sfor unloop LOOP_STACK
__{}    pop  DE             ; 1:10      sfor unloop LOOP_STACK})
sfor{}LOOP_STACK:                ;           sfor LOOP_STACK ( index -- index )})dnl
dnl
dnl
dnl
dnl ( index -- index-1 )
define({SNEXT},{
    ld   A, H           ; 1:4       snext LOOP_STACK
    or   L              ; 1:4       snext LOOP_STACK
    dec  HL             ; 1:6       snext LOOP_STACK index--
    jp  nz, sfor{}LOOP_STACK     ; 3:10      snext LOOP_STACK
snext{}LOOP_STACK:               ;           snext LOOP_STACK{}dnl
__{}UNLOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl ---------- xdo(stop,index) ... xloop ------------
dnl Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl ( -- ) 
dnl xdo(stop,index) ... xloop
dnl xdo(stop,index) ... xaddloop(step)
define({XDO},{
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       xleave LOOP_STACK
__{}    inc  L              ; 1:4       xleave LOOP_STACK
__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       xunloop LOOP_STACK
__{}    inc   L             ; 1:4       xunloop LOOP_STACK
__{}    inc  HL             ; 1:6       xunloop LOOP_STACK
__{}    exx                 ; 1:4       xunloop LOOP_STACK ( index -- )}){}dnl
__{}pushdef({STOP_STACK}, $1)pushdef({INDEX_STACK}, $2)
    exx                 ; 1:4       xdo($1,$2) LOOP_STACK
    dec  HL             ; 1:6       xdo($1,$2) LOOP_STACK
    ld  (HL),high format({%-6s},$2); 2:10      xdo($1,$2) LOOP_STACK
    dec   L             ; 1:4       xdo($1,$2) LOOP_STACK
    ld  (HL),low format({%-7s},$2); 2:10      xdo($1,$2) LOOP_STACK
    exx                 ; 1:4       xdo($1,$2) LOOP_STACK
xdo{}LOOP_STACK:                 ;           xdo($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- )
define({XLOOP},{
    exx                 ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}ifelse({1},eval((STOP_STACK<256)&&(INDEX_STACK<255)),{dnl
__{}    inc (HL)            ; 1:7       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK index_lo++
__{}    ld    A, (HL)       ; 1:7       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK index_lo
__{}    sub  format({%-15s},STOP_STACK); 2:7       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK index_lo - stop_lo
__{}    exx                 ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      xloop(STOP_STACK,INDEX_STACK) LOOP_STACK again
__{}    exx                 ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    inc   L             ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK{}dnl
__{}},{
__{}    ld    E,(HL)        ; 1:7       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    inc   L             ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    ld    D,(HL)        ; 1:7       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    inc  DE             ; 1:6       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK index++
__{}    ld    A, low format({%-7s},STOP_STACK); 2:7       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    scf                 ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    sbc   A, E          ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK stop_lo - index_lo - 1
__{}    ld    A, high format({%-6s},STOP_STACK); 2:7       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    sbc   A, D          ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK stop_hi - index_hi - 1
__{}    jr    c, xleave{}LOOP_STACK  ; 2:7/12    xloop(STOP_STACK,INDEX_STACK) LOOP_STACK exit
__{}    ld  (HL), D         ; 1:7       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    dec   L             ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    ld  (HL), E         ; 1:6       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    exx                 ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
__{}    jp   xdo{}LOOP_STACK         ; 3:10      xloop LOOP_STACK})
xleave{}LOOP_STACK:              ;           xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
    inc  HL             ; 1:6       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK
    exx                 ; 1:4       xloop(STOP_STACK,INDEX_STACK) LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl stop index do ... step +loop
dnl ( -- )
dnl xdo(stop,index) ... xaddloop(step)
define({XADDLOOP},{ifelse({$#},{1},,{
.error xaddloop(?): parameter is missing or remaining!})
    exx                 ; 1:4       xaddloop LOOP_STACK
    ld    A, low format({%-7s},$1); 2:7       xaddloop LOOP_STACK
    add   A, (HL)       ; 1:7       xaddloop LOOP_STACK
    ld    E, A          ; 1:4       xaddloop LOOP_STACK lo index
    inc   L             ; 1:4       xaddloop LOOP_STACK
    ld    A, high format({%-6s},$1); 2:7       xaddloop LOOP_STACK
    adc   A, (HL)       ; 1:7       xaddloop LOOP_STACK
    ld  (HL), A         ; 1:7       xaddloop LOOP_STACK hi index
__{}ifelse({1},eval((STOP_STACK-INDEX_STACK-1)/$1 != (65535-INDEX_STACK)/$1 ),{dnl
__{}    ld    A, E          ; 1:4       xaddloop LOOP_STACK
__{}    sub   low format({%-10s},STOP_STACK); 2:7       xaddloop LOOP_STACK
__{}    ld    A, (HL)       ; 1:7       xaddloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       xaddloop LOOP_STACK index - stop
__{}    jr   nc, xleave{}LOOP_STACK  ; 2:7/12    xaddloop LOOP_STACK
__{}    dec   L             ; 1:4       xaddloop LOOP_STACK
__{}    ld  (HL), E         ; 1:7       xaddloop LOOP_STACK
__{}    exx                 ; 1:4       xaddloop LOOP_STACK
__{}    jp   xdo{}LOOP_STACK         ; 3:10      xaddloop LOOP_STACK{}dnl
__{}},{
__{}    dec   L             ; 1:4       xaddloop LOOP_STACK
__{}    ld  (HL), E         ; 1:7       xaddloop LOOP_STACK
__{}    exx                 ; 1:4       xaddloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK     ; 3:10      xaddloop LOOP_STACK
__{}    exx                 ; 1:4       xaddloop LOOP_STACK
__{}    inc   L             ; 1:4       xaddloop LOOP_STACK})
__{}xleave{}LOOP_STACK:
    inc  HL             ; 1:6       xaddloop LOOP_STACK
    exx                 ; 1:4       xaddloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
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
    ld    L, A          ; 1:4       index xi LOOP_STACK}){}dnl
dnl;   exx                 ; 1:4       index xi LOOP_STACK
dnl;   ld    E,(HL)        ; 1:7       index xi LOOP_STACK
dnl;   inc   L             ; 1:4       index xi LOOP_STACK
dnl;   ld    D,(HL)        ; 1:7       index xi LOOP_STACK
dnl;   push DE             ; 1:11      index xi LOOP_STACK
dnl;   dec   L             ; 1:4       index xi LOOP_STACK
dnl;   exx                 ; 1:4       index xi LOOP_STACK
dnl;   ex   DE, HL         ; 1:4       index xi LOOP_STACK ( i x2 x1 -- i  x1 x2 )
dnl;   ex  (SP),HL         ; 1:19      index xi LOOP_STACK ( i x1 x2 -- x2 x1 i )
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
dnl;   exx                 ; 1:4    
dnl;   ld    A, 0x04       ; 2:7
dnl;   add   A, L          ; 1:4
dnl;   ld    E, A          ; 1:4
dnl;   adc   A, H          ; 1:4
dnl;   sub   E             ; 1:4
dnl;   ld    D, A          ; 1:4
dnl;   ld    A,(DE)        ; 1:7       lo    
dnl;   inc   E             ; 1:4
dnl;   ex   AF, AF'        ; 1:4
dnl;   ld    A,(DE)        ; 1:7       hi
dnl;   exx                 ; 1:4    
dnl;   push DE             ; 1:11
dnl;   ex   DE, HL         ; 1:4    
dnl;   ld    H, A          ; 1:4
dnl;   ex   AF, AF'        ; 1:4    
dnl;   ld    L, A          ; 1:4})dnl
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
    ld    A, E          ; 1:4       2dup u< while BEGIN_STACK    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup u< while BEGIN_STACK    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup u< while BEGIN_STACK    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup u< while BEGIN_STACK    (DE<HL) --> (DE-HL<0) --> carry if true
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup u< while BEGIN_STACK})dnl
dnl    
dnl
define({_2DUP_UGE_WHILE},{
    ld    A, E          ; 1:4       2dup u>= while BEGIN_STACK    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       2dup u>= while BEGIN_STACK    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       2dup u>= while BEGIN_STACK    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= while BEGIN_STACK    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      2dup u>= while BEGIN_STACK})dnl
dnl    
dnl
define({_2DUP_ULE_WHILE},{
    ld    A, L          ; 1:4       2dup u<= while BEGIN_STACK    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sub   E             ; 1:4       2dup u<= while BEGIN_STACK    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    ld    A, H          ; 1:4       2dup u<= while BEGIN_STACK    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= while BEGIN_STACK    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    jp    c, break{}BEGIN_STACK   ; 3:10      2dup u<= while BEGIN_STACK})dnl
dnl    
dnl
define({_2DUP_UGT_WHILE},{
    ld    A, L          ; 1:4       2dup u> while BEGIN_STACK    (DE>HL) --> (0>HL-DE) --> carry if true
    sub   E             ; 1:4       2dup u> while BEGIN_STACK    (DE>HL) --> (0>HL-DE) --> carry if true
    ld    A, H          ; 1:4       2dup u> while BEGIN_STACK    (DE>HL) --> (0>HL-DE) --> carry if true
    sbc   A, D          ; 1:4       2dup u> while BEGIN_STACK    (DE>HL) --> (0>HL-DE) --> carry if true
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
    ld    A, E          ; 1:4       2dup < while BEGIN_STACK    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup < while BEGIN_STACK    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup < while BEGIN_STACK    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup < while BEGIN_STACK    (DE<HL) --> (DE-HL<0) --> carry if true
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
    ld    A, E          ; 1:4       2dup >= while BEGIN_STACK    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       2dup >= while BEGIN_STACK    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       2dup >= while BEGIN_STACK    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       2dup >= while BEGIN_STACK    (DE>=HL) --> (DE-HL>=0) --> not carry if true
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
    ld    A, L          ; 1:4       2dup <= while BEGIN_STACK    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sub   E             ; 1:4       2dup <= while BEGIN_STACK    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    ld    A, H          ; 1:4       2dup <= while BEGIN_STACK    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sbc   A, D          ; 1:4       2dup <= while BEGIN_STACK    (DE<=HL) --> (HL-DE>=0) --> not carry if true
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
    ld    A, L          ; 1:4       2dup > while BEGIN_STACK    (DE>HL) --> (HL-DE<0) --> carry if true
    sub   E             ; 1:4       2dup > while BEGIN_STACK    (DE>HL) --> (HL-DE<0) --> carry if true
    ld    A, H          ; 1:4       2dup > while BEGIN_STACK    (DE>HL) --> (HL-DE<0) --> carry if true
    sbc   A, D          ; 1:4       2dup > while BEGIN_STACK    (DE>HL) --> (HL-DE<0) --> carry if true
    rra                 ; 1:4       2dup > while BEGIN_STACK
    xor   C             ; 1:4       2dup > while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup > while BEGIN_STACK})dnl
dnl
dnl

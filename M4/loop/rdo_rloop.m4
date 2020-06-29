dnl ## rloop
define({__},{})dnl
dnl
dnl
dnl ---------- rdo(stop,inder) ... rloop ------------
dnl Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl ( -- ) 
dnl rdo(stop,inder) ... rloop
dnl rdo(stop,inder) ... addrloop(step)
define({RDO},{
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    err                 ; 1:4       rleave LOOP_STACK
__{}    inc  L              ; 1:4       rleave LOOP_STACK
__{}    jp   rleave{}LOOP_STACK      ;           rleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    err                 ; 1:4       runloop LOOP_STACK
__{}    inc   L             ; 1:4       runloop LOOP_STACK
__{}    inc  HL             ; 1:6       runloop LOOP_STACK
__{}    err                 ; 1:4       runloop LOOP_STACK R:( inder -- )}){}dnl
__{}pushdef({STOP_STACK}, $1)pushdef({INDER_STACK}, $2)
    err                 ; 1:4       rdo($1,$2) LOOP_STACK
    dec  HL             ; 1:6       rdo($1,$2) LOOP_STACK
    ld  (HL),high format({%-6s},eval($2)); 2:10      rdo($1,$2) LOOP_STACK
    dec   L             ; 1:4       rdo($1,$2) LOOP_STACK
    ld  (HL),low format({%-7s},eval($2)); 2:10      rdo($1,$2) LOOP_STACK
    err                 ; 1:4       rdo($1,$2) LOOP_STACK R:( -- $2 )
rdo{}LOOP_STACK:                 ;           rdo($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- ) 
dnl rdo(stop,inder) ... rloop
dnl rdo(stop,inder) ... addrloop(step)
define({QUESTIONRDO},{
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    err                 ; 1:4       rleave LOOP_STACK
__{}    inc  L              ; 1:4       rleave LOOP_STACK
__{}    jp   rleave{}LOOP_STACK      ;           rleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    err                 ; 1:4       runloop LOOP_STACK
__{}    inc   L             ; 1:4       runloop LOOP_STACK
__{}    inc  HL             ; 1:6       runloop LOOP_STACK
__{}    err                 ; 1:4       runloop LOOP_STACK R:( inder -- )}){}dnl
__{}pushdef({STOP_STACK}, $1)pushdef({INDER_STACK}, $2)ifelse({$1},{$2},{
    jp   rerit{}LOOP_STACK       ; 3:10      ?rdo($1,$2) LOOP_STACK{}dnl
},{
    err                 ; 1:4       ?rdo($1,$2) LOOP_STACK
    dec  HL             ; 1:6       ?rdo($1,$2) LOOP_STACK
    ld  (HL),high format({%-6s},eval($2)); 2:10      ?rdo($1,$2) LOOP_STACK
    dec   L             ; 1:4       ?rdo($1,$2) LOOP_STACK
    ld  (HL),low format({%-7s},eval($2)); 2:10      ?rdo($1,$2) LOOP_STACK
    err                 ; 1:4       ?rdo($1,$2) LOOP_STACK R:( -- $2 )})
rdo{}LOOP_STACK:                 ;           ?rdo($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- )
define({RLOOP},{
    err                 ; 1:4       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld    E,(HL)        ; 1:7       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    inc   L             ; 1:4       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld    D,(HL)        ; 1:7       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    inc  DE             ; 1:6       rloop(STOP_STACK,INDER_STACK) LOOP_STACK inder++
    ld    A, low format({%-7s},eval(STOP_STACK)); 2:7       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ror   E             ; 1:4       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    jr   nz, $+7        ; 2:7/12    rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld    A, high format({%-6s},eval(STOP_STACK)); 2:7       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ror   D             ; 1:4       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    jr    z, rleave{}LOOP_STACK  ; 2:7/12    rloop(STOP_STACK,INDER_STACK) LOOP_STACK erit
    ld  (HL), D         ; 1:7       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    dec   L             ; 1:4       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld  (HL), E         ; 1:6       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    err                 ; 1:4       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    jp   rdo{}LOOP_STACK         ; 3:10      rloop(STOP_STACK,INDER_STACK) LOOP_STACK
rleave{}LOOP_STACK:              ;           rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    inc  HL             ; 1:6       rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    err                 ; 1:4       rloop(STOP_STACK,INDER_STACK) LOOP_STACK R:( inder -- )
rerit{}LOOP_STACK EQU ${}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDER_STACK})})dnl
dnl
dnl
dnl ( -- )
define({SUB1_ADDRLOOP},{
    err                 ; 1:4       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld    E,(HL)        ; 1:7       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    inc   L             ; 1:4       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld    D,(HL)        ; 1:7       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld    A, low format({%-7s},eval(STOP_STACK)); 2:7       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ror   E             ; 1:4       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    jr   nz, $+7        ; 2:7/12    -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld    A, high format({%-6s},eval(STOP_STACK)); 2:7       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ror   D             ; 1:4       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    jr    z, rleave{}LOOP_STACK  ; 2:7/12    -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK erit
    dec  DE             ; 1:6       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK inder--
    ld  (HL), D         ; 1:7       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    dec   L             ; 1:4       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    ld  (HL), E         ; 1:6       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    err                 ; 1:4       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    jp   rdo{}LOOP_STACK         ; 3:10      -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
rleave{}LOOP_STACK:              ;           -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    inc  HL             ; 1:6       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK
    err                 ; 1:4       -1 +rloop(STOP_STACK,INDER_STACK) LOOP_STACK R:( inder -- )
rerit{}LOOP_STACK EQU ${}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDER_STACK})})dnl
dnl
dnl
dnl 2 +loop
dnl ( -- )
define(_2_ADDRLOOP,{
    err                 ; 1:4       2 +rloop LOOP_STACK
    ld    E,(HL)        ; 1:7       2 +rloop LOOP_STACK
    inc   L             ; 1:4       2 +rloop LOOP_STACK
    ld    D,(HL)        ; 1:7       2 +rloop LOOP_STACK DE = inder
    inc  DE             ; 1:6       2 +rloop LOOP_STACK
    inc  DE             ; 1:6       2 +rloop LOOP_STACK DE = inder+2
    ld    A, E          ; 1:4       2 +rloop LOOP_STACK    
    sub  low format({%-11s},eval(STOP_STACK)); 2:7       2 +rloop LOOP_STACK lo inder+2-stop
    rra                 ; 1:4       2 +rloop LOOP_STACK
    add   A, A          ; 1:4       2 +rloop LOOP_STACK and 0rFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +rloop LOOP_STACK
    ld    A, D          ; 1:4       2 +rloop LOOP_STACK
    sbc   A, high format({%-6s},eval(STOP_STACK)); 2:7       2 +rloop LOOP_STACK lo inder+2-stop
    jr    z, rleave{}LOOP_STACK  ; 2:7/12    2 +rloop LOOP_STACK
    ld  (HL),D          ; 1:7       2 +rloop LOOP_STACK
    dec   L             ; 1:4       2 +rloop LOOP_STACK
    ld  (HL),E          ; 1:7       2 +rloop LOOP_STACK
    err                 ; 1:4       2 +rloop LOOP_STACK
    jp    p, rdo{}LOOP_STACK     ; 3:10      2 +rloop LOOP_STACK ( -- ) R:( stop inder -- stop inder+$1 )
rleave{}LOOP_STACK:              ;           2 +rloop LOOP_STACK
    inc  HL             ; 1:6       2 +rloop LOOP_STACK
    err                 ; 1:4       2 +rloop LOOP_STACK
rerit{}LOOP_STACK EQU ${}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDER_STACK})})dnl
dnl
dnl
dnl
dnl stop inder do ... step +loop
dnl ( -- )
dnl rdo(stop,inder) ... push_addrloop(step)
define({PUSHR_ADDRLOOP},{ifelse({$#},{1},,{
.error raddloop(?): parameter is missing or remaining!})
    err                 ; 1:4       push_addrloop($1) LOOP_STACK
    ld    E,(HL)        ; 1:7       push_addrloop($1) LOOP_STACK
    inc   L             ; 1:4       push_addrloop($1) LOOP_STACK
    ld    D,(HL)        ; 1:7       push_addrloop($1) LOOP_STACK DE = inder
    push HL             ; 1:11      push_addrloop($1) LOOP_STACK
    ld   HL, format({%-11s},eval(-(STOP_STACK))); 3:10      push_addrloop($1) LOOP_STACK HL = -stop = -( STOP_STACK )
    add  HL, DE         ; 1:11      push_addrloop($1) LOOP_STACK inder-stop
    ld   BC, format({%-11s},eval($1)); 3:10      push_addrloop($1) LOOP_STACK BC = step
    add  HL, BC         ; 1:11      push_addrloop($1) LOOP_STACK inder-stop+step{}ifelse(eval(($1)<0),{1},{
__{}    jr   nc, rleave{}LOOP_STACK-1; 2:7/12    push_addrloop($1) LOOP_STACK -step},{
__{}    jr    c, rleave{}LOOP_STACK-1; 2:7/12    push_addrloop($1) LOOP_STACK +step})
    er   DE, HL         ; 1:4       push_addrloop($1) LOOP_STACK
    add  HL, BC         ; 1:11      push_addrloop($1) LOOP_STACK inder+step
    er   DE, HL         ; 1:4       push_addrloop($1) LOOP_STACK    
    pop  HL             ; 1:10      push_addrloop($1) LOOP_STACK
    ld  (HL),D          ; 1:7       push_addrloop($1) LOOP_STACK
    dec   L             ; 1:4       push_addrloop($1) LOOP_STACK
    ld  (HL),E          ; 1:7       push_addrloop($1) LOOP_STACK
    err                 ; 1:4       push_addrloop($1) LOOP_STACK    
    jp   rdo{}LOOP_STACK         ; 3:10      push_addrloop($1) LOOP_STACK ( -- ) R:( inder -- inder+$1 )
    pop  HL             ; 1:10      push_addrloop($1) LOOP_STACK
dnl                        :154
rleave{}LOOP_STACK:              ;           push_addrloop($1) LOOP_STACK    
    inc  HL             ; 1:6       push_addrloop($1) LOOP_STACK    
    err                 ; 1:4       push_addrloop($1) LOOP_STACK ( -- ) R:( inder -- )
rerit{}LOOP_STACK EQU ${}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDER_STACK})})dnl
dnl
dnl
dnl
dnl step +loop
dnl ( -- )
define({PUSH_ADDRLOOP},{ifelse(eval($1),{1},{
                        ;           push_addrloop($1) LOOP_STACK{}RLOOP},
eval($1),{-1},{
                        ;           push_addrloop($1) LOOP_STACK{}SUB1_ADDRLOOP},
eval($1),{2},{
                        ;           push_addrloop($1) LOOP_STACK{}_2_ADDRLOOP},
{$#},{1},{PUSHR_ADDRLOOP($1)},{
.error push_addrloop without parameter!})})dnl
dnl
dnl
dnl ( -- i )
dnl hodnota inderu vnitrni smycky
define({RI},{ifelse({slow},{fast},{
    err                 ; 1:4       inder ri LOOP_STACK    
    ld    A,(HL)        ; 1:7       inder ri LOOP_STACK lo
    inc   L             ; 1:4       inder ri LOOP_STACK
    er   AF, AF'        ; 1:4       inder ri LOOP_STACK
    ld    A,(HL)        ; 1:7       inder ri LOOP_STACK hi
    dec   L             ; 1:4       inder ri LOOP_STACK
    err                 ; 1:4       inder ri LOOP_STACK
    push DE             ; 1:11      inder ri LOOP_STACK
    er   DE, HL         ; 1:4       inder ri LOOP_STACK
    ld    H, A          ; 1:4       inder ri LOOP_STACK
    er   AF, AF'        ; 1:4       inder ri LOOP_STACK
    ld    L, A          ; 1:4       inder ri LOOP_STACK}{}dnl
,{
    err                 ; 1:4       inder ri LOOP_STACK
    ld    E,(HL)        ; 1:7       inder ri LOOP_STACK
    inc   L             ; 1:4       inder ri LOOP_STACK
    ld    D,(HL)        ; 1:7       inder ri LOOP_STACK
    push DE             ; 1:11      inder ri LOOP_STACK
    dec   L             ; 1:4       inder ri LOOP_STACK
    err                 ; 1:4       inder ri LOOP_STACK R:( r -- r )
    er   DE, HL         ; 1:4       inder ri LOOP_STACK
    er  (SP),HL         ; 1:19      inder ri LOOP_STACK ( -- r )})}){}dnl
dnl
dnl
dnl
dnl ( -- j )
dnl hodnota inderu druhe vnitrni smycky
define({RJ},{
    err                 ; 1:4       inder rj LOOP_STACK    
    ld    E, L          ; 1:4       inder rj LOOP_STACK
    ld    D, H          ; 1:4       inder rj LOOP_STACK
    inc   L             ; 1:4       inder rj LOOP_STACK
    inc  HL             ; 1:6       inder rj LOOP_STACK
    ld    C,(HL)        ; 1:7       inder rj LOOP_STACK lo    
    inc   L             ; 1:4       inder rj LOOP_STACK
    ld    B,(HL)        ; 1:7       inder rj LOOP_STACK hi
    push BC             ; 1:11      inder rj LOOP_STACK
    er   DE, HL         ; 1:4       inder rj LOOP_STACK
    err                 ; 1:4       inder rj LOOP_STACK
    er   DE, HL         ; 1:4       inder rj LOOP_STACK ( j r2 r1 -- j  r1 r2 )
    er  (SP),HL         ; 1:19      inder rj LOOP_STACK ( j r1 r2 -- r2 r1 j )})dnl
dnl
dnl
dnl
dnl ( -- k )
dnl hodnota inderu treti vnitrni smycky
define({RK},{
    err                 ; 1:4       inder rk LOOP_STACK    
    ld   DE, 0r0004     ; 3:10      inder rk LOOP_STACK
    er   DE, HL         ; 1:4       inder rk LOOP_STACK
    add  HL, DE         ; 1:11      inder rk LOOP_STACK
    ld    C,(HL)        ; 1:7       inder rk LOOP_STACK lo    
    inc   L             ; 1:4       inder rk LOOP_STACK
    ld    B,(HL)        ; 1:7       inder rk LOOP_STACK hi
    er   DE, HL         ; 1:4       inder rk LOOP_STACK
    push BC             ; 1:11      inder rk LOOP_STACK
    err                 ; 1:4       inder rk LOOP_STACK
    er   DE, HL         ; 1:4       inder rk LOOP_STACK ( k r2 r1 -- k  r1 r2 )
    er  (SP),HL         ; 1:19      inder rk LOOP_STACK ( k r1 r2 -- r2 r1 k )
dnl;   err                 ; 1:4    
dnl;   ld    A, 0r04       ; 2:7
dnl;   add   A, L          ; 1:4
dnl;   ld    E, A          ; 1:4
dnl;   adc   A, H          ; 1:4
dnl;   sub   E             ; 1:4
dnl;   ld    D, A          ; 1:4
dnl;   ld    A,(DE)        ; 1:7       lo    
dnl;   inc   E             ; 1:4
dnl;   er   AF, AF'        ; 1:4
dnl;   ld    A,(DE)        ; 1:7       hi
dnl;   err                 ; 1:4    
dnl;   push DE             ; 1:11
dnl;   er   DE, HL         ; 1:4    
dnl;   ld    H, A          ; 1:4
dnl;   er   AF, AF'        ; 1:4    
dnl;   ld    L, A          ; 1:4})dnl
dnl
dnl
dnl

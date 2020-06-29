dnl ## rloop
define({__},{})dnl
dnl
dnl
dnl ---------  rdo ... rloop  -----------
dnl 5 0 rdo ri . rloop --> 0 1 2 3 4 
dnl ( stop index -- ) r:( -- stop index )
define(RDO,{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       rleave LOOP_STACK
__{}    inc  L              ; 1:4       rleave LOOP_STACK
__{}    inc  HL             ; 1:6       rleave LOOP_STACK
__{}    inc  L              ; 1:4       rleave LOOP_STACK
__{}    jp   leave{}LOOP_STACK       ;           rleave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       unrloop LOOP_STACK
__{}    inc  L              ; 1:4       unrloop LOOP_STACK
__{}    inc  HL             ; 1:6       unrloop LOOP_STACK
__{}    inc  L              ; 1:4       unrloop LOOP_STACK
__{}    inc  HL             ; 1:6       unrloop LOOP_STACK
__{}    exx                 ; 1:4       unrloop LOOP_STACK})
    push HL             ; 1:11      rdo LOOP_STACK index
    push DE             ; 1:11      rdo LOOP_STACK stop
    exx                 ; 1:4       rdo LOOP_STACK
    pop  DE             ; 1:10      rdo LOOP_STACK stop
    dec  HL             ; 1:6       rdo LOOP_STACK
    ld  (HL),D          ; 1:7       rdo LOOP_STACK
    dec  L              ; 1:4       rdo LOOP_STACK
    ld  (HL),E          ; 1:7       rdo LOOP_STACK stop
    pop  DE             ; 1:10      rdo LOOP_STACK index
    dec  HL             ; 1:6       rdo LOOP_STACK
    ld  (HL),D          ; 1:7       rdo LOOP_STACK
    dec  L              ; 1:4       rdo LOOP_STACK
    ld  (HL),E          ; 1:7       rdo LOOP_STACK index
    exx                 ; 1:4       rdo LOOP_STACK
    pop  HL             ; 1:10      rdo LOOP_STACK
    pop  DE             ; 1:10      rdo LOOP_STACK ( stop index -- ) R: ( -- stop index )
do{}LOOP_STACK:                  ;           rdo LOOP_STACK})dnl
dnl
dnl
dnl ---------  ?rdo ... rloop  -----------
dnl 5 0 ?do i . loop --> 0 1 2 3 4 
dnl 5 5 ?do i . loop -->  
dnl ( stop index -- ) r:( -- stop index )
define(QUESTIONRDO,{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       rleave LOOP_STACK
__{}    inc  L              ; 1:4       rleave LOOP_STACK
__{}    inc  HL             ; 1:6       rleave LOOP_STACK
__{}    inc  L              ; 1:4       rleave LOOP_STACK
__{}    jp   leave{}LOOP_STACK       ;           rleave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       unrloop LOOP_STACK
__{}    inc  L              ; 1:4       unrloop LOOP_STACK
__{}    inc  HL             ; 1:6       unrloop LOOP_STACK
__{}    inc  L              ; 1:4       unrloop LOOP_STACK
__{}    inc  HL             ; 1:6       unrloop LOOP_STACK
__{}    exx                 ; 1:4       unrloop LOOP_STACK})
    push HL             ; 1:11      ?rdo LOOP_STACK index
    or    A             ; 1:4       ?rdo LOOP_STACK
    sbc  HL, DE         ; 2:15      ?rdo LOOP_STACK
    jr   nz, $+8        ; 2:7/12    ?rdo LOOP_STACK
    pop  HL             ; 1:10      ?rdo LOOP_STACK
    pop  HL             ; 1:10      ?rdo LOOP_STACK
    pop  DE             ; 1:10      ?rdo LOOP_STACK
    jp   exit{}LOOP_STACK        ; 3:10      ?rdo LOOP_STACK   
    push DE             ; 1:11      ?rdo LOOP_STACK stop
    exx                 ; 1:4       ?rdo LOOP_STACK
    pop  DE             ; 1:10      ?rdo LOOP_STACK stop
    dec  HL             ; 1:6       ?rdo LOOP_STACK
    ld  (HL),D          ; 1:7       ?rdo LOOP_STACK
    dec  L              ; 1:4       ?rdo LOOP_STACK
    ld  (HL),E          ; 1:7       ?rdo LOOP_STACK stop
    pop  DE             ; 1:10      ?rdo LOOP_STACK index
    dec  HL             ; 1:6       ?rdo LOOP_STACK
    ld  (HL),D          ; 1:7       ?rdo LOOP_STACK
    dec  L              ; 1:4       ?rdo LOOP_STACK
    ld  (HL),E          ; 1:7       ?rdo LOOP_STACK index
    exx                 ; 1:4       ?rdo LOOP_STACK
    pop  HL             ; 1:10      ?rdo LOOP_STACK
    pop  DE             ; 1:10      ?rdo LOOP_STACK ( stop index -- ) R: ( -- stop index )
do{}LOOP_STACK:                  ;           ?rdo LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- i )
dnl hodnota indexu vnitrni smycky
define({RI},{
    exx                 ; 1:4       index ri LOOP_STACK    
    ld    E,(HL)        ; 1:7       index ri LOOP_STACK
    inc   L             ; 1:4       index ri LOOP_STACK
    ld    D,(HL)        ; 1:7       index ri LOOP_STACK
    push DE             ; 1:11      index ri LOOP_STACK
    dec   L             ; 1:4       index ri LOOP_STACK
    exx                 ; 1:4       index ri LOOP_STACK
    ex   DE, HL         ; 1:4       index ri LOOP_STACK
    ex  (SP),HL         ; 1:19      index ri LOOP_STACK})dnl
dnl
dnl
dnl ( -- j )
dnl hodnota indexu druhe vnitrni smycky
define({RJ},{
    exx                 ; 1:4       index rj LOOP_STACK
    ld   DE, 0x0004     ; 3:10      index rj LOOP_STACK
    ex   DE, HL         ; 1:4       index rj LOOP_STACK
    add  HL, DE         ; 1:11      index rj LOOP_STACK
    ld    C,(HL)        ; 1:7       index rj LOOP_STACK lo    
    inc   L             ; 1:4       index rj LOOP_STACK
    ld    B,(HL)        ; 1:7       index rj LOOP_STACK hi
    ex   DE, HL         ; 1:4       index rj LOOP_STACK
    push BC             ; 1:11      index rj LOOP_STACK
    exx                 ; 1:4       index rj LOOP_STACK
    ex   DE, HL         ; 1:4       index rj LOOP_STACK
    ex  (SP),HL         ; 1:19      index rj LOOP_STACK})dnl
dnl
dnl
dnl ( -- )
define(RLOOP,{
    exx                 ; 1:4       rloop LOOP_STACK
    ld    E,(HL)        ; 1:7       rloop LOOP_STACK
    inc   L             ; 1:4       rloop LOOP_STACK
    ld    D,(HL)        ; 1:7       rloop LOOP_STACK DE = index   
    inc  HL             ; 1:6       rloop LOOP_STACK
    inc  DE             ; 1:6       rloop LOOP_STACK index++
    ld    A,(HL)        ; 1:4       rloop LOOP_STACK
    xor   E             ; 1:4       rloop LOOP_STACK lo index - stop
    jr   nz, $+8        ; 2:7/12    rloop LOOP_STACK
    ld    A, D          ; 1:4       rloop LOOP_STACK
    inc   L             ; 1:4       rloop LOOP_STACK
    xor (HL)            ; 1:7       rloop LOOP_STACK hi index - stop
    jr    z, leave{}LOOP_STACK   ; 2:7/12    rloop LOOP_STACK exit    
    dec   L             ; 1:4       rloop LOOP_STACK
    dec  HL             ; 1:6       rloop LOOP_STACK
    ld  (HL), D         ; 1:7       rloop LOOP_STACK
    dec   L             ; 1:4       rloop LOOP_STACK
    ld  (HL), E         ; 1:7       rloop LOOP_STACK
    exx                 ; 1:4       rloop LOOP_STACK
    jp   do{}LOOP_STACK          ; 3:10      rloop LOOP_STACK
leave{}LOOP_STACK:               ;           rloop LOOP_STACK
    inc  HL             ; 1:6       rloop LOOP_STACK
    exx                 ; 1:4       rloop LOOP_STACK
dnl                     ;26:92/113/86
exit{}LOOP_STACK:                ;           rloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK})})dnl
dnl
dnl
dnl
dnl ( -- )
define(SUB1_ADDRLOOP,{
    exx                 ; 1:4       -1 +rloop LOOP_STACK
    ld    E,(HL)        ; 1:7       -1 +rloop LOOP_STACK
    inc   L             ; 1:4       -1 +rloop LOOP_STACK
    ld    D,(HL)        ; 1:7       -1 +rloop LOOP_STACK DE = index   
    inc  HL             ; 1:6       -1 +rloop LOOP_STACK
    ld    A,(HL)        ; 1:7       -1 +rloop LOOP_STACK
    xor   E             ; 1:4       -1 +rloop LOOP_STACK lo index - stop
    jr   nz, $+8        ; 2:7/12    -1 +rloop LOOP_STACK
    inc   L             ; 1:4       -1 +rloop LOOP_STACK
    ld    A,(HL)        ; 1:7       -1 +rloop LOOP_STACK
    xor   D             ; 1:4       -1 +rloop LOOP_STACK hi index - stop
    jr    z, leave{}LOOP_STACK   ; 2:7/12    -1 +rloop LOOP_STACK exit    
    dec   L             ; 1:4       -1 +rloop LOOP_STACK
    dec  HL             ; 1:6       -1 +rloop LOOP_STACK
    dec  DE             ; 1:6       -1 +rloop LOOP_STACK index--
    ld  (HL), D         ; 1:7       -1 +rloop LOOP_STACK
    dec   L             ; 1:4       -1 +rloop LOOP_STACK
    ld  (HL), E         ; 1:7       -1 +rloop LOOP_STACK
    exx                 ; 1:4       -1 +rloop LOOP_STACK
    jp   do{}LOOP_STACK          ; 3:10      -1 +rloop LOOP_STACK
leave{}LOOP_STACK:               ;           -1 +rloop LOOP_STACK
    inc  HL             ; 1:6       -1 +rloop LOOP_STACK
    exx                 ; 1:4       -1 +rloop LOOP_STACK
exit{}LOOP_STACK EQU ${}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK})})dnl
dnl
dnl
dnl +loop
dnl ( step -- )
define({ADDRLOOP},{
    ex  (SP),HL         ; 1:19      +rloop LOOP_STACK
    ex   DE, HL         ; 1:4       +rloop LOOP_STACK
    exx                 ; 1:4       +rloop LOOP_STACK{}ifelse({fast},{slow},{
__{}    pop  BC             ; 1:10      +rloop LOOP_STACK BC = step
__{}    ld    E,(HL)        ; 1:7       +rloop LOOP_STACK
__{}    ld    A, E          ; 1:4       +rloop LOOP_STACK
__{}    add   A, C          ; 1:4       +rloop LOOP_STACK
__{}    ld  (HL),A          ; 1:7       +rloop LOOP_STACK
__{}    inc   L             ; 1:4       +rloop LOOP_STACK
__{}    ld    D,(HL)        ; 1:7       +rloop LOOP_STACK DE = index
__{}    ld    A, D          ; 1:4       +rloop LOOP_STACK
__{}    adc   A, B          ; 1:4       +rloop LOOP_STACK
__{}    ld  (HL),A          ; 1:7       +rloop LOOP_STACK
__{}    inc  HL             ; 1:6       +rloop LOOP_STACK
__{}    ld    A, E          ; 1:4       +rloop LOOP_STACK    
__{}    sub (HL)            ; 1:7       +rloop LOOP_STACK
__{}    ld    E, A          ; 1:4       +rloop LOOP_STACK    
__{}    inc   L             ; 1:4       +rloop LOOP_STACK
__{}    ld    A, D          ; 1:4       +rloop LOOP_STACK    
__{}    sbc   A,(HL)        ; 1:7       +rloop LOOP_STACK
__{}    ld    D, A          ; 1:4       +rloop LOOP_STACK DE = index-stop
__{}    ld    A, E          ; 1:4       +rloop LOOP_STACK    
__{}    add   A, C          ; 1:4       +rloop LOOP_STACK
__{}    ld    A, D          ; 1:4       +rloop LOOP_STACK    
__{}    adc   A, B          ; 1:4       +rloop LOOP_STACK
__{}    xor   D             ; 1:4       +rloop LOOP_STACK
__{}    jp    m, leave{}LOOP_STACK   ; 3:10      +rloop LOOP_STACK
__{}    dec   L             ; 1:4       +rloop LOOP_STACK    
__{}    dec  HL             ; 1:6       +rloop LOOP_STACK
__{}    dec   L             ; 1:4       +rloop LOOP_STACK},{
dnl                          29:142
__{}    ld    E,(HL)        ; 1:7       +rloop LOOP_STACK
__{}    inc   L             ; 1:4       +rloop LOOP_STACK
__{}    ld    D,(HL)        ; 1:7       +rloop LOOP_STACK DE = index
__{}    inc  HL             ; 1:6       +rloop LOOP_STACK
__{}    ld    C,(HL)        ; 1:7       +rloop LOOP_STACK
__{}    inc   L             ; 1:4       +rloop LOOP_STACK
__{}    ld    B,(HL)        ; 1:7       +rloop LOOP_STACK BC = stop
__{}    ex  (SP),HL         ; 1:19      +rloop LOOP_STACK HL = step
__{}    ex   DE, HL         ; 1:4       +rloop LOOP_STACK
__{}    xor   A             ; 1:4       +rloop LOOP_STACK
__{}    sbc  HL, BC         ; 2:15      +rloop LOOP_STACK HL = index-stop
__{}    ld    A, H          ; 1:4       +rloop LOOP_STACK
__{}    add  HL, DE         ; 1:11      +rloop LOOP_STACK HL = index-stop+step
__{}    xor   H             ; 1:4       +rloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +rloop LOOP_STACK HL = index+step
__{}    ex   DE, HL         ; 1:4       +rloop LOOP_STACK
__{}    pop  HL             ; 1:10      +rloop LOOP_STACK
__{}    jp    m, leave{}LOOP_STACK   ; 3:10      +rloop LOOP_STACK
__{}    dec   L             ; 1:4       +rloop LOOP_STACK    
__{}    dec  HL             ; 1:6       +rloop LOOP_STACK
__{}    ld  (HL),D          ; 1:7       +rloop LOOP_STACK    
__{}    dec   L             ; 1:4       +rloop LOOP_STACK
__{}    ld  (HL),E          ; 1:7       +rloop LOOP_STACK{}dnl
dnl                          26:166
})
    exx                 ; 1:4       +rloop LOOP_STACK
    jp    p, do{}LOOP_STACK      ; 3:10      +rloop LOOP_STACK ( step -- ) R:( stop index -- stop index+step )
leave{}LOOP_STACK:               ;           +rloop LOOP_STACK
    inc  HL             ; 1:6       +rloop LOOP_STACK
    exx                 ; 1:4       +rloop LOOP_STACK ( step -- ) R:( stop index -- )
exit{}LOOP_STACK:                ;           +rloop LOOP_STACK
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl 2 +loop
dnl ( -- )
define(_2_ADDRLOOP,{
    exx                 ; 1:4       2 +rloop LOOP_STACK
    ld    E,(HL)        ; 1:7       2 +rloop LOOP_STACK
    inc   L             ; 1:4       2 +rloop LOOP_STACK
    ld    D,(HL)        ; 1:7       2 +rloop LOOP_STACK DE = index
    inc  DE             ; 1:6       2 +rloop LOOP_STACK
    inc  DE             ; 1:6       2 +rloop LOOP_STACK DE = index+2
    inc  HL             ; 1:6       2 +rloop LOOP_STACK
    ld    A, E          ; 1:4       2 +rloop LOOP_STACK    
    sub (HL)            ; 1:7       2 +rloop LOOP_STACK lo index+2-stop
    rra                 ; 1:4       2 +rloop LOOP_STACK
    add   A, A          ; 1:4       2 +rloop LOOP_STACK and 0xFE with save carry
    jr   nz, $+8        ; 2:7/12    2 +rloop LOOP_STACK
    ld    A, D          ; 1:4       2 +rloop LOOP_STACK
    inc   L             ; 1:4       2 +rloop LOOP_STACK
    sbc   A,(HL)        ; 1:7       2 +rloop LOOP_STACK hi index+2-stop
    jr    z, leave{}LOOP_STACK   ; 2:7/12    2 +rloop LOOP_STACK
    dec   L             ; 1:4       2 +rloop LOOP_STACK   
    dec  HL             ; 1:6       2 +rloop LOOP_STACK
    ld  (HL),D          ; 1:7       2 +rloop LOOP_STACK
    dec   L             ; 1:4       2 +rloop LOOP_STACK
    ld  (HL),E          ; 1:7       2 +rloop LOOP_STACK
    exx                 ; 1:4       2 +rloop LOOP_STACK
    jp    p, do{}LOOP_STACK      ; 3:10      2 +rloop LOOP_STACK ( -- ) R:( stop index -- stop index+$1 )
leave{}LOOP_STACK:               ;           2 +rloop LOOP_STACK
    inc  HL             ; 1:6       2 +rloop LOOP_STACK
    exx                 ; 1:4       2 +rloop LOOP_STACK
exit{}LOOP_STACK:                ;           2 +rloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl step +loop
dnl ( -- )
define({X_ADDRLOOP},{
    exx                 ; 1:4       $1 +rloop LOOP_STACK
    ld   BC, format({%-11s},$1); 3:10      $1 +rloop LOOP_STACK BC = step
    ld    E,(HL)        ; 1:7       $1 +rloop LOOP_STACK
    ld    A, E          ; 1:4       $1 +rloop LOOP_STACK
    add   A, C          ; 1:4       $1 +rloop LOOP_STACK
    ld  (HL),A          ; 1:7       $1 +rloop LOOP_STACK
    inc   L             ; 1:4       $1 +rloop LOOP_STACK
    ld    D,(HL)        ; 1:7       $1 +rloop LOOP_STACK DE = index
    ld    A, D          ; 1:4       $1 +rloop LOOP_STACK
    adc   A, B          ; 1:4       $1 +rloop LOOP_STACK
    ld  (HL),A          ; 1:7       $1 +rloop LOOP_STACK
    inc  HL             ; 1:6       $1 +rloop LOOP_STACK
    ld    A, E          ; 1:4       $1 +rloop LOOP_STACK    
    sub (HL)            ; 1:7       $1 +rloop LOOP_STACK
    ld    E, A          ; 1:4       $1 +rloop LOOP_STACK    
    inc   L             ; 1:4       $1 +rloop LOOP_STACK
    ld    A, D          ; 1:4       $1 +rloop LOOP_STACK    
    sbc   A,(HL)        ; 1:7       $1 +rloop LOOP_STACK
    ld    D, A          ; 1:4       $1 +rloop LOOP_STACK DE = index-stop
    ld    A, E          ; 1:4       $1 +rloop LOOP_STACK    
    add   A, C          ; 1:4       $1 +rloop LOOP_STACK
    ld    A, D          ; 1:4       $1 +rloop LOOP_STACK    
    adc   A, B          ; 1:4       $1 +rloop LOOP_STACK
    xor   D             ; 1:4       $1 +rloop LOOP_STACK
    jp    m, $+10       ; 3:10      $1 +rloop LOOP_STACK
    dec   L             ; 1:4       $1 +rloop LOOP_STACK    
    dec  HL             ; 1:6       $1 +rloop LOOP_STACK
    dec   L             ; 1:4       $1 +rloop LOOP_STACK
    exx                 ; 1:4       $1 +rloop LOOP_STACK
    jp    p, do{}LOOP_STACK      ; 3:10      $1 +rloop LOOP_STACK ( -- ) R:( stop index -- stop index+$1 )
dnl                        :160
leave{}LOOP_STACK:               ;           $1 +rloop LOOP_STACK
    inc  HL             ; 1:6       $1 +rloop LOOP_STACK
    exx                 ; 1:4       $1 +rloop LOOP_STACK ( -- ) R:( stop index -- )
exit{}LOOP_STACK:                ;           $1 +rloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl step +loop
dnl ( -- )
define({PUSH_ADDRLOOP},{ifelse(eval($1),{1},{
                        ;           $1 +rloop LOOP_STACK{}RLOOP},
eval($1),{-1},{
                        ;           $1 +rloop LOOP_STACK{}SUB1_ADDRLOOP},
eval($1),{2},{
                        ;           $1 +rloop LOOP_STACK{}_2_ADDRLOOP},
{$#},{1},{X_ADDRLOOP($1)},{
.error push_addrloop without parameter!})})dnl
dnl
dnl
dnl
dnl

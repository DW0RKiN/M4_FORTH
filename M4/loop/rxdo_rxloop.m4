dnl ## recursive xdo(stop,index) xi rxloop
dnl
dnl
dnl # ---------- rxdo(stop,index) ... rxloop ------------
dnl # Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl # ( -- )
dnl # rxdo(stop,index) ... rxloop
dnl # rxdo(stop,index) ... addrxloop(step)
define({RXDO},{dnl
__{}__ADD_TOKEN({__TOKEN_RXDO},{rxdo},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RXDO},{dnl
__{}define({__INFO},{rxdo}){}dnl
ifelse({$#},{2},,{
.error rxdo(?): parameter is missing or remaining!})
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       rxleave LOOP_STACK
__{}    inc  L              ; 1:4       rxleave LOOP_STACK
__{}    jp  leave{}LOOP_STACK        ;           rxleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       unrxloop LOOP_STACK
__{}    inc   L             ; 1:4       unrxloop LOOP_STACK
__{}    inc  HL             ; 1:6       unrxloop LOOP_STACK
__{}    exx                 ; 1:4       unrxloop LOOP_STACK R:( index -- )}){}dnl
__{}pushdef({STOP_STACK}, $1)pushdef({INDER_STACK}, $2)
    exx                 ; 1:4       $1 $2 rxdo LOOP_STACK
    dec  HL             ; 1:6       $1 $2 rxdo LOOP_STACK
    ld  (HL),high format({%-6s},eval($2)); 2:10      $1 $2 rxdo LOOP_STACK
    dec   L             ; 1:4       $1 $2 rxdo LOOP_STACK
    ld  (HL),low format({%-7s},eval($2)); 2:10      $1 $2 rxdo LOOP_STACK
    exx                 ; 1:4       $1 $2 rxdo LOOP_STACK R:( -- $2 )
do{}LOOP_STACK:                  ;           $1 $2 rxdo LOOP_STACK}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # rxdo(stop,index) ... rxloop
dnl # rxdo(stop,index) ... addrxloop(step)
define({QUESTIONRXDO},{dnl
__{}__ADD_TOKEN({__TOKEN_QUESTIONRXDO},{questionrxdo},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_QUESTIONRXDO},{dnl
__{}define({__INFO},{questionrxdo}){}dnl

dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       rxleave LOOP_STACK
__{}    inc  L              ; 1:4       rxleave LOOP_STACK
__{}    jp   leave{}LOOP_STACK       ;           rxleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       unrxloop LOOP_STACK
__{}    inc   L             ; 1:4       unrxloop LOOP_STACK
__{}    inc  HL             ; 1:6       unrxloop LOOP_STACK
__{}    exx                 ; 1:4       unrxloop LOOP_STACK R:( index -- )}){}dnl
__{}pushdef({STOP_STACK}, $1)pushdef({INDER_STACK}, $2)ifelse({$1},{$2},{
    jp   exit{}LOOP_STACK       ; 3:10      $1 $2 ?rxdo LOOP_STACK{}dnl
},{
    exx                 ; 1:4       $1 $2 ?rxdo LOOP_STACK
    dec  HL             ; 1:6       $1 $2 ?rxdo LOOP_STACK
    ld  (HL),high format({%-6s},eval($2)); 2:10      $1 $2 ?rxdo LOOP_STACK
    dec   L             ; 1:4       $1 $2 ?rxdo LOOP_STACK
    ld  (HL),low format({%-7s},eval($2)); 2:10      $1 $2 ?rxdo LOOP_STACK
    exx                 ; 1:4       $1 $2 ?rxdo LOOP_STACK R:( -- $2 )})
do{}LOOP_STACK:                  ;           $1 $2 ?rxdo LOOP_STACK}){}dnl
dnl
dnl
dnl
dnl # ( -- )
define({RXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_RXLOOP},{rxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RXLOOP},{dnl
__{}define({__INFO},{rxloop}){}dnl

    exx                 ; 1:4       rxloop LOOP_STACK
    ld    E,(HL)        ; 1:7       rxloop LOOP_STACK
    inc   L             ; 1:4       rxloop LOOP_STACK
    ld    D,(HL)        ; 1:7       rxloop LOOP_STACK
    inc  DE             ; 1:6       rxloop LOOP_STACK index++
    ld    A, low format({%-7s},eval(STOP_STACK)); 2:7       rxloop LOOP_STACK
    xor   E             ; 1:4       rxloop LOOP_STACK
    jr   nz, $+7        ; 2:7/12    rxloop LOOP_STACK
    ld    A, high format({%-6s},eval(STOP_STACK)); 2:7       rxloop LOOP_STACK
    xor   D             ; 1:4       rxloop LOOP_STACK
    jr    z, leave{}LOOP_STACK   ; 2:7/12    rxloop LOOP_STACK exit
    ld  (HL), D         ; 1:7       rxloop LOOP_STACK
    dec   L             ; 1:4       rxloop LOOP_STACK
    ld  (HL), E         ; 1:6       rxloop LOOP_STACK
    exx                 ; 1:4       rxloop LOOP_STACK
    jp   do{}LOOP_STACK          ; 3:10      rxloop LOOP_STACK
leave{}LOOP_STACK:               ;           rxloop LOOP_STACK
    inc  HL             ; 1:6       rxloop LOOP_STACK
    exx                 ; 1:4       rxloop LOOP_STACK R:( index -- )
exit{}LOOP_STACK:                ; 1:4       rxloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDER_STACK})}){}dnl
dnl
dnl
dnl # ( -- )
define({SUB1_ADDRXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_SUB1_ADDRXLOOP},{sub1_addrxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SUB1_ADDRXLOOP},{dnl
__{}define({__INFO},{sub1_addrxloop}){}dnl

    exx                 ; 1:4       -1 +rxloop LOOP_STACK
    ld    E,(HL)        ; 1:7       -1 +rxloop LOOP_STACK
    inc   L             ; 1:4       -1 +rxloop LOOP_STACK
    ld    D,(HL)        ; 1:7       -1 +rxloop LOOP_STACK
    ld    A, low format({%-7s},eval(STOP_STACK)); 2:7       -1 +rxloop LOOP_STACK
    xor   E             ; 1:4       -1 +rxloop LOOP_STACK
    jr   nz, $+7        ; 2:7/12    -1 +rxloop LOOP_STACK
    ld    A, high format({%-6s},eval(STOP_STACK)); 2:7       -1 +rxloop LOOP_STACK
    xor   D             ; 1:4       -1 +rxloop LOOP_STACK
    jr    z, leave{}LOOP_STACK   ; 2:7/12    -1 +rxloop LOOP_STACK exit
    dec  DE             ; 1:6       -1 +rxloop LOOP_STACK index--
    ld  (HL), D         ; 1:7       -1 +rxloop LOOP_STACK
    dec   L             ; 1:4       -1 +rxloop LOOP_STACK
    ld  (HL), E         ; 1:6       -1 +rxloop LOOP_STACK
    exx                 ; 1:4       -1 +rxloop LOOP_STACK
    jp   do{}LOOP_STACK          ; 3:10      -1 +rxloop LOOP_STACK
leave{}LOOP_STACK:               ;           -1 +rxloop LOOP_STACK
    inc  HL             ; 1:6       -1 +rxloop LOOP_STACK
    exx                 ; 1:4       -1 +rxloop LOOP_STACK R:( index -- )
exit{}LOOP_STACK:                ;           -1 +rxloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDER_STACK})}){}dnl
dnl
dnl
dnl # 2 +loop
dnl # ( -- )
define({_2_ADDRXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_2_ADDRXLOOP},{2_addrxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2_ADDRXLOOP},{dnl
__{}define({__INFO},{2_addrxloop}){}dnl

    exx                 ; 1:4       2 +rxloop LOOP_STACK
    ld    E,(HL)        ; 1:7       2 +rxloop LOOP_STACK
    inc   L             ; 1:4       2 +rxloop LOOP_STACK
    ld    D,(HL)        ; 1:7       2 +rxloop LOOP_STACK DE = index
    inc  DE             ; 1:6       2 +rxloop LOOP_STACK
    inc  DE             ; 1:6       2 +rxloop LOOP_STACK DE = index+2
    ld    A, E          ; 1:4       2 +rxloop LOOP_STACK
    sub  low format({%-11s},eval(STOP_STACK)); 2:7       2 +rxloop LOOP_STACK lo index+2-stop
    rra                 ; 1:4       2 +rxloop LOOP_STACK
    add   A, A          ; 1:4       2 +rxloop LOOP_STACK and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +rxloop LOOP_STACK
    ld    A, D          ; 1:4       2 +rxloop LOOP_STACK
    sbc   A, high format({%-6s},eval(STOP_STACK)); 2:7       2 +rxloop LOOP_STACK lo index+2-stop
    jr    z, leave{}LOOP_STACK   ; 2:7/12    2 +rxloop LOOP_STACK
    ld  (HL),D          ; 1:7       2 +rxloop LOOP_STACK
    dec   L             ; 1:4       2 +rxloop LOOP_STACK
    ld  (HL),E          ; 1:7       2 +rxloop LOOP_STACK
    exx                 ; 1:4       2 +rxloop LOOP_STACK
    jp    p, do{}LOOP_STACK      ; 3:10      2 +rxloop LOOP_STACK ( -- ) R:( stop index -- stop index+$1 )
leave{}LOOP_STACK:               ;           2 +rxloop LOOP_STACK
    inc  HL             ; 1:6       2 +rxloop LOOP_STACK
    exx                 ; 1:4       2 +rxloop LOOP_STACK
exit{}LOOP_STACK:                ;           2 +rxloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDER_STACK})}){}dnl
dnl
dnl
dnl
dnl # stop index rdo ... step +rloop
dnl # ( -- )
dnl # rxdo(stop,index) ... push_addrxloop(step)
define({X_ADDRXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_X_ADDRXLOOP},{x_addrxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_X_ADDRXLOOP},{dnl
__{}define({__INFO},{x_addrxloop}){}dnl
ifelse({$#},{1},,{
.error x_addrxloop(?): parameter is missing or remaining!})
    exx                 ; 1:4       $1 +rxloop LOOP_STACK
    ld    E,(HL)        ; 1:7       $1 +rxloop LOOP_STACK
    inc   L             ; 1:4       $1 +rxloop LOOP_STACK
    ld    D,(HL)        ; 1:7       $1 +rxloop LOOP_STACK DE = index
    push HL             ; 1:11      $1 +rxloop LOOP_STACK
    ld   HL, format({%-11s},eval(-(STOP_STACK))); 3:10      $1 +rxloop LOOP_STACK HL = -stop = -( STOP_STACK )
    add  HL, DE         ; 1:11      $1 +rxloop LOOP_STACK index-stop
    ld   BC, format({%-11s},eval($1)); 3:10      $1 +rxloop LOOP_STACK BC = step
    add  HL, BC         ; 1:11      $1 +rxloop LOOP_STACK index-stop+step{}ifelse(eval(($1)<0),{1},{
__{}    jr   nc, leave{}LOOP_STACK-1 ; 2:7/12    $1 +rxloop LOOP_STACK -step},{
__{}    jr    c, leave{}LOOP_STACK-1 ; 2:7/12    $1 +rxloop LOOP_STACK +step})
    ex   DE, HL         ; 1:4       $1 +rxloop LOOP_STACK
    add  HL, BC         ; 1:11      $1 +rxloop LOOP_STACK index+step
    ex   DE, HL         ; 1:4       $1 +rxloop LOOP_STACK
    pop  HL             ; 1:10      $1 +rxloop LOOP_STACK
    ld  (HL),D          ; 1:7       $1 +rxloop LOOP_STACK
    dec   L             ; 1:4       $1 +rxloop LOOP_STACK
    ld  (HL),E          ; 1:7       $1 +rxloop LOOP_STACK
    exx                 ; 1:4       $1 +rxloop LOOP_STACK
    jp   do{}LOOP_STACK          ; 3:10      $1 +rxloop LOOP_STACK ( -- ) R:( index -- index+$1 )
    pop  HL             ; 1:10      $1 +rxloop LOOP_STACK
dnl #                        :154
leave{}LOOP_STACK:               ;           $1 +rxloop LOOP_STACK
    inc  HL             ; 1:6       $1 +rxloop LOOP_STACK
    exx                 ; 1:4       $1 +rxloop LOOP_STACK ( -- ) R:( index -- )
exit{}LOOP_STACK:                ;           $1 +rxloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDER_STACK})}){}dnl
dnl
dnl
dnl
dnl # step +rloop
dnl # ( -- )
define({PUSH_ADDRXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ADDRXLOOP},{push_addrxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ADDRXLOOP},{dnl
__{}define({__INFO},{push_addrxloop}){}dnl
ifelse(eval($1),{1},{
                        ;           $1 +rxloop LOOP_STACK{}RXLOOP},
eval($1),{-1},{
                        ;           $1 +rxloop LOOP_STACK{}SUB1_ADDRXLOOP},
eval($1),{2},{
                        ;           $1 +rxloop LOOP_STACK{}_2_ADDRXLOOP},
{$#},{1},{X_ADDRXLOOP($1)},{
.error push_addrxloop without parameter!})}){}dnl
dnl
dnl
dnl # ( -- i )
dnl # hodnota indexu vnitrni smycky
define({RXI},{dnl
__{}__ADD_TOKEN({__TOKEN_RXI},{rxi},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RXI},{dnl
__{}define({__INFO},{rxi}){}dnl
ifelse({slow},{fast},{
    exx                 ; 1:4       index rxi LOOP_STACK
    ld    A,(HL)        ; 1:7       index rxi LOOP_STACK lo
    inc   L             ; 1:4       index rxi LOOP_STACK
    ex   AF, AF'        ; 1:4       index rxi LOOP_STACK
    ld    A,(HL)        ; 1:7       index rxi LOOP_STACK hi
    dec   L             ; 1:4       index rxi LOOP_STACK
    exx                 ; 1:4       index rxi LOOP_STACK
    push DE             ; 1:11      index rxi LOOP_STACK
    ex   DE, HL         ; 1:4       index rxi LOOP_STACK
    ld    H, A          ; 1:4       index rxi LOOP_STACK
    ex   AF, AF'        ; 1:4       index rxi LOOP_STACK
    ld    L, A          ; 1:4       index rxi LOOP_STACK}{}dnl
,{
    exx                 ; 1:4       index rxi LOOP_STACK
    ld    E,(HL)        ; 1:7       index rxi LOOP_STACK
    inc   L             ; 1:4       index rxi LOOP_STACK
    ld    D,(HL)        ; 1:7       index rxi LOOP_STACK
    push DE             ; 1:11      index rxi LOOP_STACK
    dec   L             ; 1:4       index rxi LOOP_STACK
    exx                 ; 1:4       index rxi LOOP_STACK R:( x -- x )
    ex   DE, HL         ; 1:4       index rxi LOOP_STACK
    ex  (SP),HL         ; 1:19      index rxi LOOP_STACK ( -- x )})}){}dnl
dnl
dnl
dnl
dnl # ( -- j )
dnl # hodnota indexu druhe vnitrni smycky
define({RXJ},{dnl
__{}__ADD_TOKEN({__TOKEN_RXJ},{rxj},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RXJ},{dnl
__{}define({__INFO},{rxj}){}dnl

    exx                 ; 1:4       index rxj LOOP_STACK
    ld    E, L          ; 1:4       index rxj LOOP_STACK
    ld    D, H          ; 1:4       index rxj LOOP_STACK
    inc   L             ; 1:4       index rxj LOOP_STACK
    inc  HL             ; 1:6       index rxj LOOP_STACK
    ld    C,(HL)        ; 1:7       index rxj LOOP_STACK lo
    inc   L             ; 1:4       index rxj LOOP_STACK
    ld    B,(HL)        ; 1:7       index rxj LOOP_STACK hi
    push BC             ; 1:11      index rxj LOOP_STACK
    ex   DE, HL         ; 1:4       index rxj LOOP_STACK
    exx                 ; 1:4       index rxj LOOP_STACK
    ex   DE, HL         ; 1:4       index rxj LOOP_STACK ( j x2 x1 -- j  x1 x2 )
    ex  (SP),HL         ; 1:19      index rxj LOOP_STACK ( j x1 x2 -- x2 x1 j )}){}dnl
dnl
dnl
dnl
dnl # ( -- k )
dnl # hodnota indexu treti vnitrni smycky
define({RXK},{dnl
__{}__ADD_TOKEN({__TOKEN_RXK},{rxk},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RXK},{dnl
__{}define({__INFO},{rxk}){}dnl

    exx                 ; 1:4       index rxk LOOP_STACK
    ld   DE, 0x0004     ; 3:10      index rxk LOOP_STACK
    ex   DE, HL         ; 1:4       index rxk LOOP_STACK
    add  HL, DE         ; 1:11      index rxk LOOP_STACK
    ld    C,(HL)        ; 1:7       index rxk LOOP_STACK lo
    inc   L             ; 1:4       index rxk LOOP_STACK
    ld    B,(HL)        ; 1:7       index rxk LOOP_STACK hi
    ex   DE, HL         ; 1:4       index rxk LOOP_STACK
    push BC             ; 1:11      index rxk LOOP_STACK
    exx                 ; 1:4       index rxk LOOP_STACK
    ex   DE, HL         ; 1:4       index rxk LOOP_STACK ( k x2 x1 -- k  x1 x2 )
    ex  (SP),HL         ; 1:19      index rxk LOOP_STACK ( k x1 x2 -- x2 x1 k )
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
dnl;   ld    L, A          ; 1:4}){}dnl
dnl
dnl
dnl

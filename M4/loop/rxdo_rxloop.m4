dnl ## recursive xdo(stop,index) xi rxloop
dnl
dnl
dnl # ---------- do(R,stop,index) ... loop ------------
dnl # Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl # ( -- )
dnl # rxdo(R,stop,index) ... loop
dnl # rxdo(R,stop,index) ... addloop
dnl # rxdo(R,stop,index) ... push_addloop(step)
dnl
dnl
define({__ASM_TOKEN_XRDO},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr))
    exx                 ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),high format({%-6s},__GET_LOOP_BEGIN($1)); 2:10      __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),low format({%-7s},__GET_LOOP_BEGIN($1)); 2:10      __INFO
    exx                 ; 1:4       __INFO R:( -- __GET_LOOP_BEGIN($1) )
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # questiondo(R,stop,index) ... loop
dnl # questiondo(R,stop,index) ... addloop
dnl # questiondo(R,stop,index) ... push_addloop(step)
define({__ASM_TOKEN_XRQDO},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr))
__{}ifelse(__GET_LOOP_END($1),__GET_LOOP_BEGIN($1),{dnl
__{}__{}    jp   exit{}$1        ; 3:10      __INFO
__{}__{}do{}$1:                  ;           __INFO},
__{}{dnl
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),high format({%-6s},__GET_LOOP_BEGIN($1)); 2:10      __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  (HL),low format({%-7s},__GET_LOOP_BEGIN($1)); 2:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO   R:( -- __GET_LOOP_BEGIN($1) )
__{}__{}do{}$1:                  ;           __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_XRLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr))
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  DE             ; 1:6       __INFO   index++
    ld    A, low format({%-7s},__GET_LOOP_END($1)); 2:7       __INFO   lo stop
    xor   E             ; 1:4       __INFO
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)<256),{1},{dnl
__{}__{}    or    D             ; 1:4       __INFO},
__{}{dnl
__{}__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}__{}    ld    A, high format({%-6s},__GET_LOOP_END($1)); 2:7       __INFO   hi stop
__{}__{}    xor   D             ; 1:4       __INFO})
    jr    z, leave{}$1   ; 2:7/12    __INFO   exit
    ld  (HL), D         ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL), E         ; 1:6       __INFO
    exx                 ; 1:4       __INFO
    jp   do{}$1          ; 3:10      __INFO
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO   R:( index -- )
exit{}$1:                ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_SUB1_XRADDLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr))
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    ld    A, low format({%-7s},__GET_LOOP_END($1)); 2:7       __INFO   lo stop
    xor   E             ; 1:4       __INFO
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)<256),{1},{dnl
__{}__{}    or    D             ; 1:4       __INFO},
__{}{dnl
__{}__{}    jr   nz, $+7        ; 2:7/12    __INFO
__{}__{}    ld    A, high format({%-6s},__GET_LOOP_END($1)); 2:7       __INFO   hi stop
__{}__{}    xor   D             ; 1:4       __INFO})
    jr    z, leave{}$1   ; 2:7/12    __INFO   exit
    dec  DE             ; 1:6       __INFO   index--
    ld  (HL), D         ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL), E         ; 1:6       __INFO
    exx                 ; 1:4       __INFO
    jp   do{}$1          ; 3:10      __INFO
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO   R:( index -- )
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # 2 +loop
dnl # ( -- )
define({__ASM_TOKEN_2_XRADDLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr)){}dnl

    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO DE = index
    inc  DE             ; 1:6       __INFO
    inc  DE             ; 1:6       __INFO DE = index+2
    ld    A, E          ; 1:4       __INFO
    sub  low format({%-11s},__GET_LOOP_END($1)); 2:7       __INFO lo (index+2)-stop
    rra                 ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    __INFO
    ld    A, D          ; 1:4       __INFO
    sbc   A, high format({%-6s},__GET_LOOP_END($1)); 2:7       __INFO hi (index+2)-stop
    jr    z, leave{}$1   ; 2:7/12    __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp    p, do{}$1      ; 3:10      __INFO ( -- ) R:( stop index -- stop index+$1 )
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # stop index rdo ... step +rloop
dnl # ( -- )
dnl # rxdo(stop,index) ... push_addrxloop(step)
define({__ASM_TOKEN_PUSH_XRADDLOOP},{dnl
ifelse($#,{0},{
__{}  .error {$0}($@): Missing parameter!},
$#,{1},{dnl
__{}ifelse(__SAVE_EVAL(__GET_LOOP_STEP($1)),{1},{__ASM_TOKEN__XRLOOP($1)},
__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{-1},{__ASM_TOKEN_SUB1_XRADDLOOP($1)},
__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{2},{__ASM_TOKEN_2_XRADDLOOP($1)},
__{}{define({__INFO},__COMPILE_INFO{}(xr))
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    push HL             ; 1:11      __INFO
    ld   HL, format({%-11s},eval(-(__GET_LOOP_END($1)))); 3:10      __INFO   HL = -stop = -( __GET_LOOP_END($1) )
    add  HL, DE         ; 1:11      __INFO   index-stop
    ld   BC, format({%-11s},eval(__GET_LOOP_STEP($1))); 3:10      __INFO   BC = step
    add  HL, BC         ; 1:11      __INFO   index-stop+step{}ifelse(eval((__GET_LOOP_STEP($1))<0),{1},{
__{}    jr   nc, leave{}$1-1 ; 2:7/12    __INFO   -step},{
__{}    jr    c, leave{}$1-1 ; 2:7/12    __INFO   +step})
    ex   DE, HL         ; 1:4       __INFO
    add  HL, BC         ; 1:11      __INFO   index+step
    ex   DE, HL         ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp   do{}$1          ; 3:10      __INFO   ( -- ) R:( index -- index+__GET_LOOP_STEP($1) )
    pop  HL             ; 1:10      __INFO
dnl #                        :154
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO   ( -- ) R:( index -- )
exit{}$1:                ;           __INFO})})}){}dnl
dnl
dnl
dnl
dnl # ( -- i )
dnl # hodnota indexu vnitrni smycky
define({RXI},{dnl
__{}__ADD_TOKEN({__TOKEN_RXI},{(xr)i_}LOOP_STACK,LOOP_STACK){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RXI},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr)){}dnl
ifelse(_TYP_SINGLE,{fast},{
    exx                 ; 1:4       __INFO   ( -- i ) R:( i -- i )
    ld    A,(HL)        ; 1:7       __INFO   lo
    inc   L             ; 1:4       __INFO
    ex   AF, AF'        ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO   hi
    dec   L             ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO
    ex   AF, AF'        ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO}{}dnl
,{
    exx                 ; 1:4       __INFO   ( -- i ) R:( i -- i )
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    push DE             ; 1:11      __INFO
    dec   L             ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO})}){}dnl
dnl
dnl
dnl
dnl
dnl # ( -- j )
dnl # hodnota indexu prvni vnejsi smycky
define({RXJ},{dnl
ifelse($#,{0},{dnl
__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_XRJ},{(xr)j_}LOOP_STACK,LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}popdef({__TEMP})},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
dnl
define({__ASM_TOKEN_XRJ},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr))
    exx                 ; 1:4       __INFO   ( -- j ) R:( j i -- j i )
    ld    E, L          ; 1:4       __INFO
    ld    D, H          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    C,(HL)        ; 1:7       __INFO   lo
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO   hi
    push BC             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl
dnl
dnl # ( -- k )
dnl # hodnota indexu druhe vnejsi smycky
define({RK},{dnl
ifelse($#,{0},{dnl
__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_XRK},{(xr)k_}LOOP_STACK,LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}__{}popdef({__TEMP}){}dnl
__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}popdef({__TEMP})},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_RXK},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr))

    exx                 ; 1:4       __INFO   ( -- k ) R:( k j i -- k j i )
    ld   DE, 0x0004     ; 3:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    add  HL, DE         ; 1:11      __INFO
    ld    C,(HL)        ; 1:7       __INFO   lo
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO   hi
    ex   DE, HL         ; 1:4       __INFO
    push BC             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO
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

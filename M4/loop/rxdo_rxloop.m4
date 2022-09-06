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
__{}define({__INFO},__COMPILE_INFO{(xr)})
    exx                 ; 1:4       __INFO   ( __GET_LOOP_END($1) __GET_LOOP_BEGIN($1) -- ) ( R: -- __GET_LOOP_BEGIN($1) )
    dec  HL             ; 1:6       __INFO
ifelse(__SAVE_EVAL(__GET_LOOP_BEGIN($1)),0,{dnl
    xor   A             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO},
{dnl
    ld  (HL),high format({%-6s},__GET_LOOP_BEGIN($1)); 2:10      __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),low format({%-7s},__GET_LOOP_BEGIN($1)); 2:10      __INFO})
    exx                 ; 1:4       __INFO
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
__{}define({__INFO},__COMPILE_INFO{}(xr)){}dnl
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,13,2,-7){}dnl  # before index++ (except stop)
__{}define({__P1},_TMP_BEST_P){}dnl
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1),3,13,2,-7){}dnl    # after index++  (except stop)
__{}define({__P2},_TMP_BEST_P){}dnl
__{}ifelse(eval(__P1>__P2),1,{
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}_TMP_BEST_CODE
__{}    jr    z, leave{}$1   ; 2:7/12    __INFO   exit},
__{}{__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,13,2,-7)
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}__{}_TMP_BEST_CODE
__{}    jr    z, leave{}$1   ; 2:7/12    __INFO   exit
__{}    inc  DE             ; 1:6       __INFO   index++})
    ld  (HL), D         ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL), E         ; 1:7       __INFO
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
__{}define({__INFO},__COMPILE_INFO{}(xr)){}dnl
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1),3,13,2,-7){}dnl    # before index-- (including stop)
__{}define({__P1},_TMP_BEST_P){}dnl
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,13,2,-7){}dnl  # after index--  (including stop)
__{}define({__P2},_TMP_BEST_P){}dnl
__{}ifelse(eval(__P1>__P2),1,{
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    dec  DE             ; 1:6       __INFO   index--
__{}__{}_TMP_BEST_CODE
__{}    jr    z, leave{}$1   ; 2:7/12    __INFO   exit},
__{}{__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1),3,13,2,-7)
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}__{}_TMP_BEST_CODE
__{}    jr    z, leave{}$1   ; 2:7/12    __INFO   exit
__{}    dec  DE             ; 1:6       __INFO   index--})
    ld  (HL), D         ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL), E         ; 1:7       __INFO
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
__{}ifelse(__SAVE_EVAL(__GET_LOOP_STEP($1)),{1},{__ASM_TOKEN_XRLOOP($1)},
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
dnl
dnl

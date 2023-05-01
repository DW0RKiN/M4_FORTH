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
    dec  HL             ; 1:6       __INFO{}dnl
ifelse(dnl
__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,{
__{}    ld   DE, format({%-11s},__GET_LOOP_BEGIN($1)); 4:20      __INFO},
__{}{
__{}    ld   DE, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
do{}$1{}save:              ;           __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
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
__{}ifelse(__IS_MEM_REF(__GET_LOOP_END($1)),1,{
__{}                    ;[21:104/77/92] __INFO   variant +1.pointer
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    inc  DE             ; 1:6       __INFO   index++
__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.{}dnl
__{}ifelse(__IS_NUM(+__GET_LOOP_END($1)),1,{
__{}__{}    ld    A,(__HEX_HL(+__GET_LOOP_END($1)))    ; 3:13      __INFO   lo(real_stop)},
__{}{
__{}__{}    ld    A,format({%-12s},__GET_LOOP_END($1)); 3:13      __INFO   lo(real_stop)})
__{}    xor   E             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO{}dnl
__{}ifelse(__IS_NUM(+__GET_LOOP_END($1)),1,{
__{}__{}    ld    A,(__HEX_HL(1+__GET_LOOP_END($1)))    ; 3:13      __INFO   hi(real_stop)},
__{}__IS_MEM_REF(__GET_LOOP_END($1)),1,{
__{}__{}    ld    A,format({%-12s},{(}substr(__GET_LOOP_END($1),1,eval(len(__GET_LOOP_END($1))-2)){+1)}); 3:13      __INFO   hi(real_stop)})
__{}    xor   D             ; 1:4       __INFO},

1,0,{dnl # Vadne!!! Pouziva HL misto DE
__{}undefine({_TMP_STACK_INFO}){}dnl
__{}define({_TMP_INFO},{__INFO}){}dnl
__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1)-1,8,38,0,38){}dnl # before index++  (except stop)
__{}define({__BEFORE_PRICE},_TMP_BEST_P){}dnl
__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,38,do{}$1{}save,28){}dnl   # after  index++  (except stop)
__{}define({__AFTER_PRICE},_TMP_BEST_P){}dnl
__{}ifelse(eval(__BEFORE_PRICE>=__AFTER_PRICE),1,{dnl
__{}__{}define({_TMP_STACK_INFO},{__INFO
__{}__{}__{}    exx                 ; 1:4       __INFO
__{}__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}__{}    ld    D,(HL)        ; 1:7       __INFO
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index++})
__{}__{}_TMP_BEST_CODE},
__{}{dnl
__{}__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1)-1,8,38,0,38){}dnl # before index++  (except stop)
__{}__{}define({_TMP_STACK_INFO},{__INFO
__{}__{}__{}    exx                 ; 1:4       __INFO
__{}__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}__{}    ld    D,(HL)        ; 1:7       __INFO})
__{}__{}_TMP_BEST_CODE
__{}__{}    inc  DE             ; 1:6       __INFO   index++})},

{
dnl # predelat __MAKE_BEST_CODE_R16_CP! Haze chyby pokud je parametr promenna.
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,13,2,-7){}dnl  # before index++ (except stop)
__{}define({__P1},_TMP_BEST_P){}dnl
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1),  3,13,2,-7){}dnl  # after index++  (except stop)
__{}define({__P2},_TMP_BEST_P)
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO{}dnl
__{}ifelse(dnl
__{}eval(__P1>__P2),1,{
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}_TMP_BEST_CODE},
__{}{dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,13,2,-7)
__{}__{}_TMP_BEST_CODE
__{}__{}    inc  DE             ; 1:6       __INFO   index++})})
    jp   nz, do{}$1{}save  ; 3:10      __INFO
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO   R:( index -- )
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_SUB1_XRADDLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr)){}dnl
__{}ifelse(__IS_MEM_REF(__GET_LOOP_END($1)),1,{
__{}                    ;[20:101/89/89] __INFO   variant +1.pointer
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.{}dnl
__{}ifelse(__IS_NUM(+__GET_LOOP_END($1)),1,{
__{}__{}    ld    A,(__HEX_HL(+__GET_LOOP_END($1)))    ; 3:13      __INFO   lo(real_stop)},
__{}{
__{}__{}    ld    A,format({%-12s},__GET_LOOP_END($1)); 3:13      __INFO   lo(real_stop)})
__{}    xor   E             ; 1:4       __INFO
__{}    jr   nz, $+6        ; 2:7/12    __INFO{}dnl
__{}ifelse(__IS_NUM(+__GET_LOOP_END($1)),1,{
__{}__{}    ld    A,(__HEX_HL(1+__GET_LOOP_END($1)))    ; 3:13      __INFO   hi(real_stop)},
__{}__IS_MEM_REF(__GET_LOOP_END($1)),1,{
__{}__{}    ld    A,format({%-12s},{(}substr(__GET_LOOP_END($1),1,eval(len(__GET_LOOP_END($1))-2)){+1)}); 3:13      __INFO   hi(real_stop)})
__{}    xor   D             ; 1:4       __INFO
__{}    dec  DE             ; 1:6       __INFO   index--},

1,0,{dnl # Vadne!!! Pouziva HL misto DE
__{}undefine({_TMP_STACK_INFO}){}dnl
__{}define({_TMP_INFO},{__INFO}){}dnl
__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,38,0,38){}dnl # before index--  (including stop)
__{}define({__BEFORE_PRICE},_TMP_BEST_P){}dnl
__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1)-1,8,38,do{}$1{}save,28){}dnl   # after  index--  (including stop)
__{}define({__AFTER_PRICE},_TMP_BEST_P){}dnl
__{}ifelse(eval(__BEFORE_PRICE>=__AFTER_PRICE),1,{dnl
__{}__{}define({_TMP_STACK_INFO},{__INFO
__{}__{}__{}    exx                 ; 1:4       __INFO
__{}__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}__{}    ld    D,(HL)        ; 1:7       __INFO
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index++})
__{}__{}_TMP_BEST_CODE},
__{}{dnl
__{}__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,38,0,38){}dnl # before index--  (including stop)
__{}__{}define({_TMP_STACK_INFO},{__INFO
__{}__{}__{}    exx                 ; 1:4       __INFO
__{}__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}__{}    ld    D,(HL)        ; 1:7       __INFO})
__{}__{}_TMP_BEST_CODE
__{}__{}    dec  DE             ; 1:6       __INFO   index++})},


{
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,13,0,0){}dnl  # after index--  (including stop)
__{}define({__P1},_TMP_BEST_P){}dnl
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1),3,13,0,0){}dnl    # before index-- (including stop)
__{}define({__P2},_TMP_BEST_P)
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO{}dnl
__{}ifelse(dnl
__{}eval(__P1>__P2),1,{
__{}__{}_TMP_BEST_CODE
__{}__{}    dec  DE             ; 1:6       __INFO   index--},
__{}{dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,13,0,0)
__{}__{}    dec  DE             ; 1:6       __INFO   index--
__{}__{}_TMP_BEST_CODE})})
    jp   nz, do{}$1{}save  ; 3:10      __INFO
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
__{}ifelse(__IS_NUM(__GET_LOOP_END($1)):__IS_NUM(__GET_LOOP_BEGIN($1)):__IS_NUM(__GET_LOOP_STEP($1)),{1:1:1},{
__{}__{}__LOOP_ANALYSIS(__GET_LOOP_STEP($1),__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}dnl
                        ;           __INFO   real_stop:_TEMP_REAL_STOP, run _TEMP_X{x}
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
__{}ifelse(eval((__GET_LOOP_BEGIN($1)) & 1),1,{dnl
    inc  DE             ; 1:6       __INFO
    inc   E             ; 1:4       __INFO   DE = index+2},
{dnl
    inc   E             ; 1:4       __INFO
    inc  DE             ; 1:6       __INFO   DE = index+2}){}dnl
__{}ifelse(_TEMP_HI_FALSE_POSITIVE,0,{dnl
__{}__{}__LD_R_NUM(__INFO,A,__HEX_H(_TEMP_REAL_STOP))
    cp    D             ; 1:4       __INFO   hi(real_stop) exclusivity},
__{}_TEMP_LO_FALSE_POSITIVE,0,{dnl
__{}__{}__LD_R_NUM(__INFO,A,__HEX_L(_TEMP_REAL_STOP))
    cp    E             ; 1:4       __INFO   lo(real_stop) exclusivity},
__{}{
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,_TEMP_REAL_STOP,2,7,2,-7){}dnl
__{}_TMP_BEST_CODE})},

__IS_MEM_REF(__GET_LOOP_END($1)),1,{
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO   DE = index{}dnl
__{}ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = index+2},
__{}{
__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc   E             ; 1:4       __INFO   DE = index+2
__{}__{}  else
__{}__{}    inc   E             ; 1:4       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = index+2
__{}__{}  endif})
__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.
__{}    ld   BC,format({%-12s},__GET_LOOP_END($1)); 4:20      __INFO
__{}    ld    A, E          ; 1:4       __INFO
__{}    sub   C             ; 1:4       __INFO   lo (index+2)-stop
__{}    rra                 ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    sbc   A, B          ; 1:4       __INFO   hi (index+2)-stop},

{
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO   DE = index{}dnl
__{}ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = index+2},
__{}{
__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc   E             ; 1:4       __INFO   DE = index+2
__{}__{}  else
__{}__{}    inc   E             ; 1:4       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = index+2
__{}__{}  endif})
__{}    ld    A, E          ; 1:4       __INFO
__{}    sub  low format({%-11s},__GET_LOOP_END($1)); 2:7       __INFO   lo (index+2)-stop
__{}    rra                 ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    sbc   A, high format({%-6s},__GET_LOOP_END($1)); 2:7       __INFO   hi (index+2)-stop})
    jp   nz, do{}$1{}save  ; 3:10      __INFO
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
__{}__IS_NUM(__GET_LOOP_END($1)):__IS_NUM(__GET_LOOP_BEGIN($1)):__IS_NUM(__GET_LOOP_STEP($1)),{1:1:1},{
__{}__{}__LOOP_ANALYSIS(__GET_LOOP_STEP($1),__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}dnl
__{}__{}define({__INFO},__COMPILE_INFO{}(xr))
                        ;           __INFO   real_stop:_TEMP_REAL_STOP, run _TEMP_X{x}
    exx                 ; 1:4       __INFO{}dnl
__{}ifelse(_TEMP_X,1,{
    inc   L             ; 1:4       __INFO},{
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    ex   DE, HL         ; 1:4       __INFO{}dnl
__{}__ADD_HL_CONST(__GET_LOOP_STEP($1),{BC =  step = __GET_LOOP_STEP($1)},{HL+=  step}){}dnl
__{}__CODE
    ex   DE, HL         ; 1:4       __INFO{}dnl
__{}ifelse(_TEMP_HI_FALSE_POSITIVE,0,{dnl
__{}__{}__LD_R_NUM(__INFO,A,__HEX_H(_TEMP_REAL_STOP))
    cp    D             ; 1:4       __INFO   hi(real_stop) exclusivity},
__{}_TEMP_LO_FALSE_POSITIVE,0,{dnl
__{}__{}__LD_R_NUM(__INFO,A,__HEX_L(_TEMP_REAL_STOP))
    cp    E             ; 1:4       __INFO   lo(real_stop) exclusivity},
__{}{
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,_TEMP_REAL_STOP,2,7,2,-7){}dnl
__{}_TMP_BEST_CODE})
    jr    z, leave{}$1   ; 2:7/12    __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp   do{}$1          ; 3:10      __INFO   ( -- ) R:( index -- index+__GET_LOOP_STEP($1) )})
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO   ( -- ) R:( index -- )
exit{}$1:                ;           __INFO},
__{}{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr))
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    push HL             ; 1:11      __INFO{}dnl
__{}ifelse(__IS_MEM_REF(__GET_LOOP_END($1)),1,{
__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.
__{}    ld   HL, format({%-11s},__GET_LOOP_END($1)); 3:16      __INFO   HL = stop
__{}    ld    A, E          ; 1:4       __INFO
__{}    sub   L             ; 1:4       __INFO
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    sbc   A, H          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = index-stop},
__IS_MEM_REF(__GET_LOOP_END($1)),1,{
__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.
__{}    ld    L, E          ; 1:4       __INFO
__{}    ld    H, D          ; 1:4       __INFO
__{}    ld   BC, format({%-11s},__GET_LOOP_END($1)); 4:20      __INFO
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop},
__{}__IS_NUM(__GET_LOOP_END($1)),1,{
__{}    ld   HL, format({%-11s},eval(-(__GET_LOOP_END($1)))); 3:10      __INFO   HL =      -stop = -( __GET_LOOP_END($1) )
__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop},
__{}{
__{}    ld   HL, __FORM({%-11s},-(__GET_LOOP_END($1))); 3:10      __INFO   HL =      -stop = -( __GET_LOOP_END($1) )
__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop})
    ld   BC, format({%-11s},eval(__GET_LOOP_STEP($1))); 3:10      __INFO   BC =            step
    add  HL, BC         ; 1:11      __INFO   HL = index-stop+step{}ifelse(eval((__GET_LOOP_STEP($1))<0),{1},{
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
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO   ( -- ) R:( index -- )
exit{}$1:                ;           __INFO})})}){}dnl
dnl
dnl
dnl
dnl
dnl

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
__{}    exx                 ; 1:4       __INFO   ( __GET_LOOP_END($1) __GET_LOOP_BEGIN($1) -- ) ( R: -- __GET_LOOP_BEGIN($1) )
__{}    dec  HL             ; 1:6       __INFO{}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO},
__{}{
__{}__{}    ld   DE, __FORM({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
__{}do{}$1{}save:              ;           __INFO
__{}    ld  [HL],D          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ld  [HL],E          ; 1:7       __INFO
__{}    exx                 ; 1:4       __INFO   R:( -- index )
__{}do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # questiondo(R,stop,index) ... loop
dnl # questiondo(R,stop,index) ... addloop
dnl # questiondo(R,stop,index) ... push_addloop(step)
define({__ASM_TOKEN_QXRDO},{dnl
__{}define({__INFO},__COMPILE_INFO{(xr)}){}dnl
__{}ifelse(__GET_LOOP_END($1),__GET_LOOP_BEGIN($1),{
__{}__{}    jp   exit{}$1        ; 3:10      __INFO
__{}__{}do{}$1{}save:              ;           __INFO
__{}__{}do{}$1:                  ;           __INFO},
__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}    exx                 ; 1:4       __INFO   ( __GET_LOOP_END($1) __GET_LOOP_BEGIN($1) -- ) ( R: -- __GET_LOOP_BEGIN($1) )
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{dnl
__{}__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    ld   DE, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},__GET_LOOP_END($1)); 3:16      __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    jp    z, exit{}$1-1  ; 3:10      __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1{}save:              ;           __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   R:( -- index )
__{}__{}do{}$1:                  ;           __INFO{}dnl
__{}},
__{}__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    exx                 ; 1:4       __INFO   ( __GET_LOOP_END($1) __GET_LOOP_BEGIN($1) -- ) ( R: -- __GET_LOOP_BEGIN($1) )
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO{}dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1),3,10,0,0){}dnl
__{}__{}_TMP_BEST_CODE
__{}__{}    jp    z, exit{}$1-1  ; 3:10      __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1{}save:              ;           __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   R:( -- index )
__{}__{}do{}$1:                  ;           __INFO{}dnl
__{}},

__{}ifelse(__IS_NUM(__GET_LOOP_BEGIN($1)),0,1,__IS_NUM(__GET_LOOP_END($1)),0,1,0),1,{
__{}__{}  if ((__GET_LOOP_BEGIN($1))=(__GET_LOOP_END($1)))
__{}__{}    jp   exit{}$1        ; 3:10      __INFO
__{}__{}do{}$1{}save:              ;           __INFO
__{}__{}do{}$1:                  ;           __INFO
__{}__{}  else
__{}__{}    exx                 ; 1:4       __INFO   ( __GET_LOOP_END($1) __GET_LOOP_BEGIN($1) -- ) ( R: -- __GET_LOOP_BEGIN($1) )
__{}__{}    ld   DE, __FORM({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1{}save:              ;           __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   R:( -- index )
__{}__{}do{}$1:                  ;           __INFO
__{}__{}  endif{}dnl
__{}},

__{}__HEX_HL(__GET_LOOP_END($1)),__HEX_HL(__GET_LOOP_BEGIN($1)),{
__{}__{}    jp   exit{}$1        ; 3:10      __INFO
__{}__{}do{}$1{}save:              ;           __INFO
__{}__{}do{}$1:                  ;           __INFO},

__{}{
__{}__{}    exx                 ; 1:4       __INFO   ( __GET_LOOP_END($1) __GET_LOOP_BEGIN($1) -- ) ( R: -- __GET_LOOP_BEGIN($1) )
__{}__{}    ld   DE, __FORM({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1{}save:              ;           __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   R:( -- index )
__{}__{}do{}$1:                  ;           __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_XRLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr)){}dnl
__{}ifelse(dnl
__{}__HEX_HL(__GET_LOOP_BEGIN($1)+1):__IS_NUM(__GET_LOOP_BEGIN($1)),__HEX_HL(__GET_LOOP_END($1)):1,{
__{}__{}    exx                 ; 1:4       __INFO   variant: +1.no_loop
__{}__{}    inc   L             ; 1:4       __INFO},

__{}__HEX_L(__GET_LOOP_END($1)):__HEX_L(__HEX_HL(__GET_LOOP_END($1)-(__GET_LOOP_BEGIN($1)))<=256),0x00:0x01,{
__{}__{}    exx                 ; 1:4       __INFO   variant: +1; lo(stop)=0 && repeat <= 256
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO
__{}__{}    inc   E             ; 1:4       __INFO   index++
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__{}__HEX_H(__GET_LOOP_BEGIN($1)):__HEX_L(__HEX_HL(__HEX_HL(__GET_LOOP_END($1))-(__GET_LOOP_BEGIN($1)))<=256),__HEX_H(__GET_LOOP_END($1)):0x01,{
__{}__{}    exx                 ; 1:4       __INFO   variant: +1; hi(from)=hi(stop) && repeat <= 256
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO
__{}__{}    inc   E             ; 1:4       __INFO   index++{}dnl
__{}__{}ifelse(__HEX_L(__GET_LOOP_END($1)),0xFF,{
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO   x[1] = 0xFF},
__{}__{}{
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO
__{}__{}__{}    xor   E             ; 1:4       __INFO   x[1] = __HEX_L(__GET_LOOP_END($1))})
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__{}__HEX_L(__HEX_HL(__GET_LOOP_END($1)-(__GET_LOOP_BEGIN($1)))<=256),0x01,{
__{}__{}    exx                 ; 1:4       __INFO   variant: +1; repeat <= 256
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO{}dnl
__{}__{}ifelse(__HEX_L(__GET_LOOP_END($1)),0xFF,{
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO   x[1] = 0xFF},
__{}__{}__HEX_L(__GET_LOOP_END($1)),0x00,{
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    or    A             ; 1:4       __INFO   x[1] = 0x00},
__{}__{}__HEX_L(__GET_LOOP_END($1)),0x01,{
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    dec   A             ; 1:4       __INFO   x[1] = 0x01},
__{}__{}__HEX_L(__GET_LOOP_END($1)):__HEX_L(__GET_LOOP_END($1)-(__GET_LOOP_BEGIN($1))<256),0x02:0x01,{
__{}__{}__{}    ld    A, E          ; 1:4       __INFO   repeat < 256
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}__{}    dec   A             ; 1:4       __INFO   x[1] = 0x02},
__{}__{}{
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO
__{}__{}__{}    xor   E             ; 1:4       __INFO   x[1] = __HEX_L(__GET_LOOP_END($1))})
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__{}{
__{}__{}    exx                 ; 1:4       __INFO   variant: +1.default
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO{}dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_END($1)),1,{define({__P1},0xFFFF)},
__{}__{}{dnl
__{}__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,10,0,0){}dnl  # before index++ (except stop)
__{}__{}__{}define({__P1},_TMP_BEST_P){}dnl
__{}__{}__{}define({__C1},__EQ_CODE){}dnl
__{}__{}}){}dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1),  3,10,do{}$1{}save,0){}dnl  # after index++  (except stop)
__{}__{}define({__P2},_TMP_BEST_P){}dnl
__{}__{}define({__C2},__EQ_CODE){}dnl
__{}__{}ifelse(eval(__P1>=__P2),1,{
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index++{}dnl
__{}__{}__{}__C2},
__{}__{}{dnl
__{}__{}__{}__C1
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index++})
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO{}dnl
__{}})
__{}leave{}$1:               ;           __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    exx                 ; 1:4       __INFO   R:( index -- )
__{}exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_SUB1_XRADDLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr)){}dnl
__{}ifelse(dnl
__{}__GET_LOOP_BEGIN($1),__GET_LOOP_END($1),{
__{}__{}    exx                 ; 1:4       __INFO   variant: -1.no_loop
__{}__{}    inc   L             ; 1:4       __INFO},
__{}__HEX_HL(__GET_LOOP_BEGIN($1)-(__GET_LOOP_END($1))),0x0000,{
__{}__{}    exx                 ; 1:4       __INFO   variant: -1.no_loop
__{}__{}    inc   L             ; 1:4       __INFO},

__{}__HEX_H(__GET_LOOP_BEGIN($1)):__HEX_L(__HEX_HL(__GET_LOOP_BEGIN($1)-(__GET_LOOP_END($1)))<256),__HEX_H(__GET_LOOP_END($1)):0x01,{
__{}__{}    exx                 ; 1:4       __INFO   variant: -1; hi(from)=hi(stop) && repeat < 256
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO
__{}__{}    dec   E             ; 1:4       __INFO   index--{}dnl
__{}__{}ifelse(
__{}__{}__HEX_L(__GET_LOOP_END($1)),0x02,{
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    dec   A             ; 1:4       __INFO   x[1] = 0x02},
__{}__{}__HEX_L(__GET_LOOP_END($1)),0x01,{},
__{}__{}__HEX_L(__GET_LOOP_END($1)),0x00,{
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO   x[1] = 0x00},
__{}__{}{
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO
__{}__{}__{}    xor   E             ; 1:4       __INFO   x[1] = __HEX_L(__GET_LOOP_END($1))})
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__{}__HEX_L(__HEX_HL(__GET_LOOP_BEGIN($1)-(__GET_LOOP_END($1)))<256),0x01,{
__{}__{}    exx                 ; 1:4       __INFO   variant: -1; repeat < 256
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_L(__GET_LOOP_END($1)),0x02,{
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index--
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    dec   A             ; 1:4       __INFO   x[1] = 0x02},
__{}__{}__HEX_L(__GET_LOOP_END($1)),0x01,{
__{}__{}__{}    dec  DE             ; 1:4       __INFO   index--
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    or    A             ; 1:4       __INFO   x[1] = 0x01},
__{}__{}__HEX_L(__GET_LOOP_END($1)),0x00,{
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index--
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO   x[1] = 0x00},
__{}__{}__HEX_L(__GET_LOOP_END($1)),0xFF,{
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO   x[1] = 0xFF
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index--},
__{}__{}{
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO
__{}__{}__{}    xor   E             ; 1:4       __INFO   x[1] = __HEX_L(__GET_LOOP_END($1))
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index--})
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__{}{
__{}__{}    exx                 ; 1:4       __INFO   variant: -1.default
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO{}dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_END($1)),1,{define({__P1},0xFFFF)},
__{}__{}{dnl
__{}__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1)-1,3,10,do{}$1{}save,0){}dnl  # after index--  (including stop)
__{}__{}__{}define({__P1},_TMP_BEST_P){}dnl
__{}__{}__{}define({__C1},__EQ_CODE){}dnl
__{}__{}}){}dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,__GET_LOOP_END($1),3,10,0,0){}dnl    # before index-- (including stop)
__{}__{}define({__P2},_TMP_BEST_P){}dnl
__{}__{}define({__C2},__EQ_CODE){}dnl
__{}__{}ifelse(eval(__P1>__P2),1,{dnl
__{}__{}__{}__C2
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index--},
__{}__{}{
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index--{}dnl
__{}__{}__{}__C1})
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO})
__{}leave{}$1:               ;           __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    exx                 ; 1:4       __INFO   R:( index -- )
__{}exit{}$1:                ;           __INFO}){}dnl
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
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index{}dnl
__{}ifelse(dnl
__{}__HEX_L(__GET_LOOP_END($1)):_TEMP_LO_FALSE_POSITIVE,0x00:0,{
__{}    inc   E             ; 1:4       __INFO   index++
__{}    inc   E             ; 1:4       __INFO   index++},
__{}__HEX_L(__GET_LOOP_END($1)):_TEMP_LO_FALSE_POSITIVE,0x01:0,{
__{}    inc   E             ; 1:4       __INFO   index++
__{}    inc   E             ; 1:4       __INFO   index++},
__{}__HEX_H(__GET_LOOP_BEGIN($1)):_TEMP_LO_FALSE_POSITIVE,__HEX_H(__GET_LOOP_END($1)):0,{
__{}    inc   E             ; 1:4       __INFO   index++
__{}    inc   E             ; 1:4       __INFO   index++},
__{}__HEX_L(1&(__GET_LOOP_BEGIN($1))),0x01,{
__{}    inc  DE             ; 1:6       __INFO   index++
__{}    inc   E             ; 1:4       __INFO   index++},
__{}{
__{}    inc   E             ; 1:4       __INFO   index++
__{}    inc  DE             ; 1:6       __INFO   index++}){}dnl
__{}ifelse(dnl
__{}_TEMP_LO_FALSE_POSITIVE:__HEX_L(_TEMP_REAL_STOP),0:0x00,{},
__{}_TEMP_LO_FALSE_POSITIVE:__HEX_L(_TEMP_REAL_STOP),0:0x01,{
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO   lo(real_stop) exclusivity},
__{}_TEMP_LO_FALSE_POSITIVE:__HEX_L(_TEMP_REAL_STOP),0:0xFF,{
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO   lo(real_stop) exclusivity},
__{}_TEMP_LO_FALSE_POSITIVE,0,{dnl
__{}__{}__LD_R_NUM(__INFO,A,__HEX_L(_TEMP_REAL_STOP))
__{}    cp    E             ; 1:4       __INFO   lo(real_stop) exclusivity},
__{}_TEMP_LO_FALSE_POSITIVE:__HEX_L(_TEMP_REAL_STOP),0:0x01,{
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO   hi(real_stop) exclusivity},
__{}_TEMP_LO_FALSE_POSITIVE:__HEX_L(_TEMP_REAL_STOP),0:0xFF,{
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO   hi(real_stop) exclusivity},
__{}_TEMP_HI_FALSE_POSITIVE,0,{dnl
__{}__{}__LD_R_NUM(__INFO,A,__HEX_H(_TEMP_REAL_STOP))
__{}    cp    D             ; 1:4       __INFO   hi(real_stop) exclusivity},
__{}{dnl
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,DE,_TEMP_REAL_STOP,2,7,2,-7){}dnl
__{}_TMP_BEST_CODE})},

__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,[HL]        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index{}dnl
__{}ifelse(__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0001,{
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    inc   E             ; 1:4       __INFO   index++},
__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0000,{
__{}__{}    inc   E             ; 1:4       __INFO   index++
__{}__{}    inc  DE             ; 1:6       __INFO   index++},
__{}__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    inc  DE             ; 1:6       __INFO   index++},
__{}{
__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    inc   E             ; 1:4       __INFO   index++
__{}__{}  else
__{}__{}    inc   E             ; 1:4       __INFO   index++
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}  endif})
__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.
__{}    ld   BC,format({%-12s},__GET_LOOP_END($1)); 4:20      __INFO
__{}    ld    A, E          ; 1:4       __INFO
__{}    sub   C             ; 1:4       __INFO   lo(index+2-stop)
__{}    rra                 ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    sbc   A, B          ; 1:4       __INFO   hi(index+2-stop)},

__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,[HL]        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}    inc  DE             ; 1:6       __INFO   index++
__{}    inc  DE             ; 1:6       __INFO   index++
__{}    ld    A, E          ; 1:4       __INFO
__{}    sub  low format({%-11s},__GET_LOOP_END($1)); 2:7       __INFO   lo (index+2)-stop
__{}    rra                 ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    sbc   A, high format({%-6s},__GET_LOOP_END($1)); 2:7       __INFO   hi (index+2)-stop},

{
__{}    exx                 ; 1:4       __INFO
__{}    ld    E,[HL]        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index{}dnl
__{}ifelse(__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0001,{
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    inc   E             ; 1:4       __INFO   index++},
__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0000,{
__{}__{}    inc   E             ; 1:4       __INFO   index++
__{}__{}    inc  DE             ; 1:6       __INFO   index++},
__{}{
__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    inc   E             ; 1:4       __INFO   index++
__{}__{}  else
__{}__{}    inc   E             ; 1:4       __INFO   index++
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}  endif})
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    xor  low  __FORM({%-11s},__GET_LOOP_END($1)+(1&((__GET_LOOP_BEGIN($1))xor(__GET_LOOP_END($1))))); 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    xor  high __FORM({%-10s},__GET_LOOP_END($1)+(1&((__GET_LOOP_BEGIN($1))xor(__GET_LOOP_END($1))))); 2:7       __INFO   hi(real_stop)})
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
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
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
    ld  [HL],D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  [HL],E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp   do{}$1          ; 3:10      __INFO   ( -- ) R:( index -- index+__GET_LOOP_STEP($1) )})
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO   ( -- ) R:( index -- )
exit{}$1:                ;           __INFO},
__{}{dnl
__{}define({__INFO},__COMPILE_INFO{}(xr))
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    push HL             ; 1:11      __INFO{}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.
__{}    ld   HL, format({%-11s},__GET_LOOP_END($1)); 3:16      __INFO   HL = stop
__{}    ld    A, E          ; 1:4       __INFO
__{}    sub   L             ; 1:4       __INFO
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    sbc   A, H          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = index-stop},
__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.
__{}    ld    L, E          ; 1:4       __INFO
__{}    ld    H, D          ; 1:4       __INFO
__{}    ld   BC,format({%-12s},__GET_LOOP_END($1)); 4:20      __INFO
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
    ld  [HL],D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  [HL],E          ; 1:7       __INFO
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

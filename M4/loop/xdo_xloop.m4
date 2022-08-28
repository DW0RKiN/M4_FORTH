dnl ## non-recursive xdo(stop,index) xi i xloop
dnl
dnl
dnl
define({__LOOP_ANALYSIS_RECURSE}, {dnl
__{}ifelse(eval((($1)!=($2))),{1},{dnl
__{}__{}define({_TEMP_X},eval(1+_TEMP_X)){}dnl
__{}__{}ifelse(eval((($1)^($2)) & 0x00FF), {0}, {define({_TEMP_LO_FALSE_POSITIVE},eval(1+_TEMP_LO_FALSE_POSITIVE))}){}dnl
__{}__{}ifelse(eval((($1)^($2)) & 0xFF00), {0}, {define({_TEMP_HI_FALSE_POSITIVE},eval(1+_TEMP_HI_FALSE_POSITIVE))}){}dnl
__{}__{}__LOOP_ANALYSIS_RECURSE(eval((0x10000+$1+($3)) & 0xFFFF),$2,$3){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
dnl # Input:
dnl #  $1 step
dnl #  $2 start index
dnl #  $3 stop index
dnl # Ouptut:
dnl #          _TEMP_REAL_STOP  .. index value for exit loop
dnl #                  _TEMP_X  .. loop counter
dnl #  _TEMP_HI_FALSE_POSITIVE  .. sum(high(index)==high(_TEMP_REAL_STOP))
dnl #  _TEMP_LO_FALSE_POSITIVE  .. sum( low(index)== low(_TEMP_REAL_STOP))
define({__LOOP_ANALYSIS}, {dnl
__{}ifelse(eval(($1)<0),{1},{dnl
__{}__{}define({_TEMP_REAL_STOP},{eval(($2+($1)*(1+((0x10000+$2-($3)) & 0xffff)/(-($1)))) & 0xffff)})},
__{}{dnl
__{}__{}define({_TEMP_REAL_STOP},{eval(($2+($1)*(1+((0x10000+$3-($2)-1) & 0xffff)/($1))) & 0xffff)})}){}dnl
__{}define({_TEMP_X},{1}){}dnl
__{}define({_TEMP_HI_FALSE_POSITIVE},{0}){}dnl
__{}define({_TEMP_LO_FALSE_POSITIVE},{0}){}dnl
__{}__LOOP_ANALYSIS_RECURSE(eval((0x10000+($2)+($1)) & 0xFFFF),_TEMP_REAL_STOP,$1){}dnl
})dnl
dnl
dnl
dnl # ---------- xdo(stop,index) ... xloop ------------
dnl # Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl # ( -- )
dnl # xdo(stop,index) ... xloop
dnl # xdo(stop,index) ... addxloop(step)
dnl
define({__ASM_TOKEN_XDO},{dnl
dnl #__SHOW_LOOP($1){}dnl
__{}define({__INFO},__COMPILE_INFO{(xm)})
__{}    ld   BC, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO
__{}do{}$1{}save:              ;           __INFO
__{}    ld  format({%-16s},(idx{}$1){,}BC); 4:20      __INFO
__{}do{}$1:                  ;           __INFO})dnl
dnl
dnl
dnl # do i
define({XDO_XI},{dnl
__{}__ADD_TOKEN({__TOKEN_XDO_XI},{xdo_xi},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XDO_XI},{dnl
__{}define({__INFO},{xdo_xi}){}dnl

__{}pushdef({STOP_STACK}, $1){}dnl
__{}pushdef({INDEX_STACK}, $2){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}__{}    jp   leave{}$1       ;           leave_{}$1}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           unloop_{}$1}){}dnl
__{}    ld   BC, format({%-11s},$2); 3:10      xdo_xi($1,$2) LOOP_STACK
__{}do{}$1{}save:              ;           xdo_xi($1,$2) LOOP_STACK
__{}    ld  format({%-16s},(idx{}$1){,}BC); 4:20      xdo_xi($1,$2) LOOP_STACK
__{}do{}$1:                  ;           xdo_xi($1,$2) LOOP_STACK
__{}    push DE             ; 1:11      xdo_xi($1,$2) LOOP_STACK
__{}    ex   DE, HL         ; 1:4       xdo_xi($1,$2) LOOP_STACK
__{}    ld    H, B          ; 1:4       xdo_xi($1,$2) LOOP_STACK
__{}    ld    L, C          ; 1:4       xdo_xi($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl # do drop i
define({XDO_DROP_XI},{dnl
__{}__ADD_TOKEN({__TOKEN_XDO_DROP_XI},{xdo_drop_xi},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XDO_DROP_XI},{dnl
__{}define({__INFO},{xdo_drop_xi}){}dnl

__{}pushdef({STOP_STACK}, $1){}dnl
__{}pushdef({INDEX_STACK}, $2){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}__{}    jp   leave{}$1       ;           leave_{}$1}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           unloop_{}$1}){}dnl
__{}    ld   BC, format({%-11s},$2); 3:10      xdo_drop_xi($1,$2) LOOP_STACK
__{}do{}$1{}save:              ;           xdo_drop_xi($1,$2) LOOP_STACK
__{}    ld  format({%-16s},(idx{}$1){,}BC); 4:20      xdo_drop_xi($1,$2) LOOP_STACK
__{}do{}$1:                  ;           xdo_drop_xi($1,$2) LOOP_STACK
__{}    ld    H, B          ; 1:4       xdo_drop_xi($1,$2) LOOP_STACK
__{}    ld    L, C          ; 1:4       xdo_drop_xi($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl # do n i
define({XDO_PUSH_XI},{dnl
__{}__ADD_TOKEN({__TOKEN_XDO_PUSH_XI},{xdo_push_xi},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XDO_PUSH_XI},{dnl
__{}define({__INFO},{xdo_push_xi}){}dnl

__{}pushdef({STOP_STACK}, $1){}dnl
__{}pushdef({INDEX_STACK}, $2){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}__{}    jp   leave{}$1       ;           leave_{}$1}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           unloop_{}$1}){}dnl
__{}    ld   BC, format({%-11s},$2); 3:10      xdo_push_xi($1,$2,$3) LOOP_STACK
__{}do{}$1{}save:              ;           xdo_push_xi($1,$2,$3) LOOP_STACK
__{}    ld  format({%-16s},(idx{}$1){,}BC); 4:20      xdo_push_xi($1,$2,$3) LOOP_STACK
__{}do{}$1:                  ;           xdo_push_xi($1,$2,$3) LOOP_STACK
__{}    push DE             ; 1:11      xdo_push_xi($1,$2,$3) LOOP_STACK
__{}    push HL             ; 1:11      xdo_push_xi($1,$2,$3) LOOP_STACK
__{}    ld   DE, format({%-11s},$3); 3:10      xdo_push_xi($1,$2,$3) LOOP_STACK
__{}    ld    H, B          ; 1:4       xdo_push_xi($1,$2,$3) LOOP_STACK
__{}    ld    L, C          ; 1:4       xdo_push_xi($1,$2,$3) LOOP_STACK})dnl
dnl
dnl
dnl # ( -- )
dnl # xdo(stop,index) ... xloop
dnl # xdo(stop,index) ... addxloop(step)
define({__ASM_TOKEN_QXDO},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xm))
__{}ifelse(__GET_LOOP_BEGIN($1),__GET_LOOP_END($1),{
__{}__{}    jp   exit{}$1        ; 3:10      __INFO
__{}do{}$1{}save:              ;           __INFO},
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO
__{}do{}$1{}save:              ;           __INFO
__{}__{}    ld  format({%-16s},(idx{}$1){,}BC); 4:20      __INFO})
__{}do{}$1:                  ;           __INFO})dnl
dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_XLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__LOOP_ANALYSIS(1,__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}ifelse(_TEMP_X,{1},{
__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant +1.null: positive step and no repeat},
eval((0<=(__GET_LOOP_BEGIN($1))) && ((__GET_LOOP_BEGIN($1))<(__GET_LOOP_END($1))) && ((__GET_LOOP_END($1))==256)),{1},{
__{}                        ;[10:38]    __INFO   variant +1.A: 0 <= index < stop == 256, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld    A, 0          ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    nop                 ; 1:4       __INFO   hi(index) = 0 = nop -> idx always points to a 16-bit index.
__{}    inc   A             ; 1:4       __INFO   index++
__{}    ld  (idx{}$1),A      ; 3:13      __INFO
__{}    jp   nz, do{}$1      ; 3:10      __INFO   index-stop},
eval((0<=(__GET_LOOP_BEGIN($1))) && ((__GET_LOOP_BEGIN($1))<(__GET_LOOP_END($1))) && ((__GET_LOOP_END($1))<=256)),{1},{
__{}                        ;[12:45]    __INFO   variant +1.B: 0 <= index < stop <= 256, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld    A, 0          ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    nop                 ; 1:4       __INFO   hi(index) = 0 = nop -> idx always points to a 16-bit index.
__{}    inc   A             ; 1:4       __INFO   index++
__{}    ld  (idx{}$1),A      ; 3:13      __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1      ; 3:10      __INFO   index-stop},
eval((0x3C00<=(__GET_LOOP_BEGIN($1))) && ((__GET_LOOP_BEGIN($1))<(__GET_LOOP_END($1))) && ((__GET_LOOP_END($1))==0x3D00)),{1},{
__{}                        ;[9:34]     __INFO   variant +1.C: 0x3C00 <=index < stop == 0x3D00, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld    A, 0          ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc   A             ; 1:4       __INFO   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
__{}    ld  (idx{}$1),A      ; 3:13      __INFO   save index
__{}    jp   nz, do{}$1      ; 3:10      __INFO},
eval((0x3C00<=(__GET_LOOP_BEGIN($1))) && ((__GET_LOOP_BEGIN($1))<(__GET_LOOP_END($1))) && ((__GET_LOOP_END($1))<=0x3D00)),{1},{
__{}                        ;[11:41]    __INFO   variant +1.D: 0x3C00 <=index < stop <= 0x3D00, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld    A, 0          ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc   A             ; 1:4       __INFO   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
__{}    ld  (idx{}$1),A      ; 3:13      __INFO   save index
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1      ; 3:10      __INFO},
eval(256*(1+__HEX_H(__GET_LOOP_BEGIN($1)))==__GET_LOOP_END($1)),{1},{
__{}                        ;[11:41]    __INFO   variant +1.E: 256*(1+hi(index)) == stop, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    inc   A             ; 1:4       __INFO   index++
__{}    ld  (idx{}$1),A      ; 3:13      __INFO   save index
__{}    jp   nz, do{}$1      ; 3:10      __INFO},
eval((__HEX_H(__GET_LOOP_BEGIN($1))==__HEX_H(__GET_LOOP_END($1)-1)) && (__HEX_HL(__GET_LOOP_BEGIN($1))<__HEX_HL(__GET_LOOP_END($1)))),{1},{
__{}                        ;[13:48]    __INFO   variant +1.F: hi(index) == hi(stop-1) && index < stop, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    inc   A             ; 1:4       __INFO   index++
__{}    ld  (idx{}$1),A      ; 3:13      __INFO   save index
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1      ; 3:10      __INFO},
eval(__GET_LOOP_END($1)),{0},{
__{}                        ;[9:54/34]  __INFO   variant +1.G: stop == 0, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       __INFO   index++
__{}    ld    A, B          ; 1:4       __INFO
__{}    or    C             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
_TEMP_LO_FALSE_POSITIVE,{0},{
__{}                        ;[10:57/37] __INFO   variant +1.H: step one with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       __INFO   index++
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[10:57/37] __INFO   variant +1.{I}: step one with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       __INFO   index++
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
{
__{}                        ;[16:57/58] __INFO   variant +1.default: step one, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       __INFO   index++
__{}ifelse(eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{dnl
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
__{}{dnl
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})})
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_SUB1_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xm)){}dnl
__LOOP_ANALYSIS(-1,__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}ifelse(_TEMP_X,{1},{
__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant -1.null: positive step and no repeat},
eval(__GET_LOOP_END($1)),{0},{
__{}                        ;[9:54/34]  __INFO   variant -1.A: step -1 and stop 0, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    or    B             ; 1:4       __INFO
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(__GET_LOOP_END($1)),{1},{
__{}                        ;[9:54/34]  __INFO   variant -1.B: step -1 and stop 1, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    ld    A, C          ; 1:4       __INFO
__{}    or    B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
_TEMP_LO_FALSE_POSITIVE,{0},{
__{}                        ;[10:57/37] __INFO   variant -1.C: step -1 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[10:57/37] __INFO   variant -1.D: step -1 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval((__GET_LOOP_END($1)+1) & 0xFFFF),{0},{
__{}                       ;[10:58/38]  __INFO   variant -1.E: step -1 and stop -1, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    and   B             ; 1:4       __INFO   0xFF & 0xFF = 0xFF
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    inc   A             ; 1:4       __INFO   0xFF + 1 = zero
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(__GET_LOOP_END($1)),{2},{
__{}                        ;[10:58/38] __INFO   variant -1.F: step -1 and stop 2, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    ld    A, C          ; 1:4       __INFO
__{}    dec   A             ; 1:4       __INFO
__{}    or    B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(__HEX_H(_TEMP_REAL_STOP)==0),{1},{
__{}                        ;[11:61/41] __INFO   variant -1.G: step -1 and hi(real_stop) = 0, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    or    B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
{
__{}ifelse(eval(_TEMP_LO_FALSE_POSITIVE<=_TEMP_HI_FALSE_POSITIVE),{1},{dnl
__{}__{}                        ;[16:57/58] __INFO   variant -1.defaultA: step -1, LO first, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first},
__{}{dnl
__{}__{}                        ;[16:57/58] __INFO   variant -1.defaultB: step -1, HI first, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first})})
leave{}$1:               ;           __INFO
exit{}$1:                ;           xloop LOOP_STACK{}dnl
})dnl
dnl
dnl
dnl # 2 +loop
dnl # ( -- )
define({__ASM_TOKEN_ADD2_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xm)){}dnl
__LOOP_ANALYSIS(2,__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}ifelse(_TEMP_X,{1},{
__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant +2.null: positive step and no repeat},
eval(_TEMP_REAL_STOP),{0},{
__{}                        ;[10:58/38] __INFO   variant +2.A: step 2 and real_stop is zero, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc   C             ; 1:4       __INFO   index++
__{}    inc  BC             ; 1:6       __INFO   index++
__{}    ld    A, C          ; 1:4       __INFO
__{}    or    B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(_TEMP_REAL_STOP),{1},{
__{}                        ;[10:58/38] __INFO   variant +2.B: step 2 and real_stop is one, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       __INFO   index++
__{}    ld    A, C          ; 1:4       __INFO
__{}    inc   C             ; 1:4       __INFO   index++
__{}    or    B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
_TEMP_LO_FALSE_POSITIVE,{0},{
__{}                        ;[11:61/41] __INFO   variant +2.C: step 2 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{0},{dnl
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}{dnl
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    inc   C             ; 1:4       __INFO   index++})
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[11:61/41] __INFO   variant +2.D: step 2 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{0},{dnl
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}{dnl
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    inc   C             ; 1:4       __INFO   index++})
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{
__{}                        ;[17:61/62] __INFO   variant +2.defaultA: positive step 2, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{0},{dnl
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}{dnl
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    inc   C             ; 1:4       __INFO   index++})
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
{
__{}                        ;[17:61/62] __INFO   variant +2.defaultB: positive step 2, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{0},{dnl
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}{dnl
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    inc   C             ; 1:4       __INFO   index++})
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl # -2 +loop
dnl # ( -- )
define({__ASM_TOKEN_SUB2_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xm)){}dnl
__LOOP_ANALYSIS(-2,__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}ifelse(_TEMP_X,{1},{
__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant -2.null: positive step and no repeat},
eval((_TEMP_REAL_STOP+2) & 0xFFFF),{0},{
__{}                        ;[10:58/38] __INFO   variant -2.A: step -2 and real_stop is -2, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, B          ; 1:4       __INFO
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    dec   C             ; 1:4       __INFO   index--
__{}    sub   B             ; 1:4       __INFO
__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO},
eval((_TEMP_REAL_STOP+1) & 0xFFFF),{0},{
__{}                        ;[10:58/38] __INFO   variant -2.B: step -2 and real_stop is -1, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec   C             ; 1:4       __INFO   index--
__{}    ld    A, C          ; 1:4       __INFO
__{}    or    B             ; 1:4       __INFO
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(_TEMP_REAL_STOP),{0},{
__{}                        ;[10:58/38] __INFO   variant -2.C: step -2 and real_stop is zero, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    dec   C             ; 1:4       __INFO   index--
__{}    ld    A, C          ; 1:4       __INFO
__{}    or    B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[11:61/41] __INFO   variant -2.D: step -2 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}{dnl
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
_TEMP_LO_FALSE_POSITIVE,{0},{
__{}                        ;[11:61/41] __INFO   variant -2.E: step -2 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}{dnl
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(_TEMP_REAL_STOP),{1},{
__{}                        ;[11:62/42] __INFO   variant -2.F: step -2 and real_stop is one, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec   C             ; 1:4       __INFO   index--
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    ld    A, C          ; 1:4       __INFO
__{}    dec   A             ; 1:4       __INFO
__{}    or    B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(_TEMP_REAL_STOP & 0xFF00),{0},{
__{}                        ;[12:65/45] __INFO   variant -2.G: step -2 and real_stop 2..255, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}{dnl
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    or    B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{
__{}                        ;[17:61/62] __INFO   variant -2.defaultA: positive step -2, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}{dnl
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
{
__{}                        ;[17:61/62] __INFO   variant -2.defaultB: positive step -2, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}{dnl
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl # stop index do ... +step +loop
dnl # ( -- )
dnl # xdo(stop,index) ... push_addxloop(+step)
define({__ASM_TOKEN_POSITIVE_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(xm)}){}dnl
__LOOP_ANALYSIS(__GET_LOOP_STEP($1),__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}dnl
ifelse(_TEMP_X,{1},{
__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant +X.null: positive step and no repeat},
eval((0 <= __GET_LOOP_BEGIN($1)) && (__GET_LOOP_BEGIN($1) < __GET_LOOP_END($1)) && (__GET_LOOP_END($1) < 256)),{1},{
__{}                        ;[13:48]    __INFO   variant +X.A: positive step and 0 <= index < stop < 256, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld    A, 0x00       ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    nop                 ; 1:4       __INFO   Contains a zero value because idx always points to a 16-bit index.
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO   A = index+step
__{}    ld  (idx{}$1), A     ; 3:13      __INFO   save new index
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1      ; 3:10      __INFO},
eval((0xC600 <= (__GET_LOOP_BEGIN($1) & 0xFFFF)) && ((__GET_LOOP_BEGIN($1) & 0xFFFF) < (__GET_LOOP_END($1) & 0xFFFF)) && ((__GET_LOOP_END($1) & 0xFFFF) < 0xC700)),{1},{
__{}                        ;[12:44]    __INFO   variant +X.B: positive step and 0xC600 <= index < stop < 0xC700, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld    A, 0x00       ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO   First byte contains a 0xC6 value because idx always points to a 16-bit index.
__{}    ld  (idx{}$1), A     ; 3:13      __INFO   save new index
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1      ; 3:10      __INFO},
eval(__GET_LOOP_STEP($1) & 0xFF),{0},{
__{}                        ;[14:51]    __INFO   variant +X.C: positive step = n*256, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, B          ; 1:4       __INFO
__{}    add   A, __HEX_H(__GET_LOOP_STEP($1))       ; 2:7       __INFO   hi(step)
__{}    ld  (idx{}$1+1),A    ; 3:13      __INFO   save index
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1      ; 3:10      __INFO},
eval((__GET_LOOP_END($1)==0) && ((__GET_LOOP_STEP($1) & 0xFF00)==0)),{1},{
__{}                        ;[14:55/49] __INFO   variant +X.D: positive step 3..255 and stop 0, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}    inc   B             ; 1:4       __INFO
__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO},
eval((_TEMP_HI_FALSE_POSITIVE==0) && ((__GET_LOOP_STEP($1) & 0xFF00)==0) && (__HEX_H(_TEMP_REAL_STOP)==0)),{1},{
__{}                        ;[14:55/49] __INFO   variant +X.E: positive step 3..255 and hi(real_stop) = exclusivity zero, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}    inc   B             ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval((_TEMP_HI_FALSE_POSITIVE==0) && ((__GET_LOOP_STEP($1) & 0xFF00)==0)),{1},{
__{}                        ;[17:55/60] __INFO   variant +X.F: positive step 3..255 and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}    inc   B             ; 1:4       __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval((0==(_TEMP_REAL_STOP & 0xFF00)) && ((__GET_LOOP_STEP($1) & 0xFF00) == 0)),{1},{
__{}                        ;[19:67/68] __INFO   variant +X.G: positive step 3..255 and real_stop 0..255, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    adc   A, B          ; 1:4       __INFO
__{}    sub   C             ; 1:4       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval((_TEMP_HI_FALSE_POSITIVE==0) && (__HEX_H(_TEMP_REAL_STOP)==0x00)),{1},{
__{}                        ;[14:70/50] __INFO   variant +X.H: positive step 256+ and hi(real_stop) exclusivity zero, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    adc   A, high format({%-6s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval((__HEX_H($1)==0) && (21*_TEMP_HI_FALSE_POSITIVE<=4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)),{1},{
__{}                        ;[21:74/75] __INFO   variant +X.{I}: positive step 3..255, hi(real_stop) has fewer duplicate,run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    adc   A, B          ; 1:4       __INFO
__{}    sub   C             ; 1:4       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop) first (21*_TEMP_HI_FALSE_POSITIVE<=4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[16:77/57] __INFO   variant +X.{J}: positive step 256+ and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    adc   A, high format({%-6s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval((_TEMP_LO_FALSE_POSITIVE==0) && ((__GET_LOOP_STEP($1) & 0xFF00) == 0)),{1},{
__{}                        ;[16:78/58] __INFO   variant +X.{K} : positive step 3..255 and lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    adc   A, B          ; 1:4       __INFO
__{}    sub   C             ; 1:4       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval((__HEX_H($1)==0) && (21*_TEMP_HI_FALSE_POSITIVE>4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)),{1},{
__{}                        ;[22:78/79] __INFO   variant +X.L: positive step 3..255, lo(real_stop) has fewer duplicate, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    adc   A, B          ; 1:4       __INFO
__{}    sub   C             ; 1:4       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop) first (21*_TEMP_HI_FALSE_POSITIVE>4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first},
{
   .error +xloop: This variant should never happen... index: __GET_LOOP_BEGIN($1), stop:__GET_LOOP_END($1), step: $1})
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl
dnl # stop index do ... -step +loop
dnl # ( -- )
dnl # xdo(stop,index) ... push_addxloop(-step)
define({__ASM_TOKEN_NEGATIVE_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(xm)}){}dnl
__LOOP_ANALYSIS(__GET_LOOP_STEP($1),__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}dnl
ifelse(_TEMP_X,{1},{
__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant -X.null: positive step and no repeat},
eval(($1==-3) && (__GET_LOOP_END($1)==0)),{1},{
__{}                        ;[11:66/46] __INFO   variant -X.A: step -3 and stop 0, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, B          ; 1:4       __INFO   hi old index
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    sub   B             ; 1:4       __INFO   old-new = carry if index: positive -> negative
__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO   carry if postivie index -> negative index},
eval(__GET_LOOP_END($1)==0),{1},{
__{}                        ;[14:70/50] __INFO   variant -X.B: negative step and stop 0, run _TEMP_X{}x
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       __INFO
__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    sbc   A, high format({%-6s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO   carry if postivie index -> negative index},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}ifelse(eval((-1*(__GET_LOOP_STEP($1))) & 0xFF00),{0},{
__{}__{}                        ;[17:55/60] __INFO   variant +X.C: negative step 3..255 and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}__{}    dec   B             ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO},
__{}{
__{}__{}                        ;[16:77/57] __INFO   variant +X.D: negative step 256+ and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    sbc   A, high format({%-6s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}    ld    B, A          ; 1:4       __INFO})
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
eval(_TEMP_REAL_STOP & 0xFF00),{0},{
__{}__{}                        ;[20:70/71] __INFO   variant -X.E: negative step and real_stop 0..255, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    sbc   A, high format({%-6s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}    ld    A, C          ; 1:4       __INFO   A = last_index
__{}__{}    xor  format({%-15s},low _TEMP_REAL_STOP); 2:7       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
{
__{}__{}                        ;[23:81/82] __INFO   variant -X.default: negative step, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    sbc   A, high format({%-6s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x})
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl # stop index do ... step +loop
dnl # ( -- )
dnl # xdo(stop,index) ... push_addxloop(step)
define({__ASM_TOKEN_NO_NUM_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}                        ;[24:119]   __INFO   variant: __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1)
__{}    push HL             ; 1:11      __INFO
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   HL, 0x0000     ; 3:10      __INFO
__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}    ld  (idx{}$1), HL    ; 3:16      __INFO   save new index
__{}ifelse(__IS_NUM(__GET_LOOP_END($1)),{0},{dnl
__{}__{}    ld    A, low format({%-7s},__GET_LOOP_END($1)-1); 2:7       __INFO
__{}__{}    sub   L             ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    A, high format({%-6s},(__GET_LOOP_END($1)-1)); 2:7       __INFO},
__{}{dnl
__{}__{}    ld    A, low format({%-7s},eval(__GET_LOOP_END($1)-1)); 2:7       __INFO
__{}__{}    sub   L             ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    A, high format({%-6s},eval(__GET_LOOP_END($1)-1)); 2:7       __INFO})
__{}    sbc   A, H          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = (stop-1)-(index+step)
__{}    add  HL, BC         ; 1:11      __INFO   HL = (stop-1)-index
__{}    pop  HL             ; 1:10      __INFO
__{}  if ((__GET_LOOP_STEP($1))>=0x8000 || (__GET_LOOP_STEP($1))<0)=0
__{}    jp   nc, do{}$1      ; 3:10      __INFO   positive step
__{}  else
__{}    jp    c, do{}$1      ; 3:10      __INFO   negative step
__{}  endif
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl # step +loop
dnl # ( -- )
define({__ASM_TOKEN_PUSH_ADDXLOOP},{dnl
__{}define({__INFO},{push_addxloop}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!
__{}},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!
__{}})dnl
__{}ifelse(__IS_NUM(__GET_LOOP_STEP($1)),{0},{dnl
__{}__{}__ASM_TOKEN_NO_NUM_ADDXLOOP($1)},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL(__GET_LOOP_STEP($1)),0x0001,{__ASM_TOKEN_XLOOP($1)},
__{}__{}__HEX_HL(__GET_LOOP_STEP($1)),0xFFFF,{__ASM_TOKEN_SUB1_ADDXLOOP($1)},
__{}__{}__HEX_HL(__GET_LOOP_STEP($1)),0x0002,{__ASM_TOKEN_ADD2_ADDXLOOP($1)},
__{}__{}__HEX_HL(__GET_LOOP_STEP($1)),0xFFFE,{__ASM_TOKEN_SUB2_ADDXLOOP($1)},
__{}__{}eval(__GET_LOOP_STEP($1)>0),{1},{dnl
__{}__{}__{}__ASM_TOKEN_POSITIVE_ADDXLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_NEGATIVE_ADDXLOOP($1)}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__ASM_TOKEN_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xm))
ifelse({fast},{slow},{
__{}    ld    B, H          ; 1:4       __INFO
__{}    ld    C, L          ; 1:4       __INFO   BC = step
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   HL, 0x0000     ; 3:10      __INFO
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}    ld  (idx{}$1), HL    ; 3:16      __INFO   save index
__{}ifelse(__IS_NUM(__GET_LOOP_END($1)),{0},{dnl
__{}__{}    ld    A, format({%-11s},__GET_LOOP_END($1)-1); 2:7       __INFO
__{}__{}    sub   L             ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    A,high format({%-7s},__GET_LOOP_END($1)-1); 2:7       __INFO},
__{}{dnl
__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO
__{}__{}    sub   L             ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    A, __HEX_H(__GET_LOOP_END($1)-1)       ; 2:7       __INFO})
__{}    sbc   A, H          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = stop-(index+step)
__{}    add  HL, BC         ; 1:11      __INFO   HL = stop-index
__{}    xor   H             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    jp    p, do{}$1      ; 3:10      __INFO
                       ;[24:114]},
__{}{fast},{small},{
__{}    push DE             ; 1:11      __INFO
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   DE, 0x0000     ; 3:10      __INFO   DE = index
__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step
__{}    ld  (idx{}$1), HL    ; 3:16      __INFO   save index
__{}    ld   BC, format({%-11s},-1*(__GET_LOOP_END($1))); 3:10      __INFO
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step-stop
__{}    ld    A, H          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop
__{}    xor   H             ; 1:4       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    jp    p, do{}$1      ; 3:10      __INFO
                       ;[21:122]},
__{}{
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   BC, 0x0000     ; 3:10      __INFO   BC = index
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}    ld  (idx{}$1), HL    ; 3:16      __INFO   save index
__{}    ld    A, L          ; 1:4       __INFO
__{}    sub   low format({%-10s},__GET_LOOP_END($1)); 2:7       __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    sbc   A, high format({%-6s},__GET_LOOP_END($1)); 2:7       __INFO
__{}    ld    H, A          ; 1:4       __INFO   H = hi index+step-stop
__{}    ld    A, C          ; 1:4       __INFO
__{}    sub   low format({%-10s},__GET_LOOP_END($1)); 2:7       __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    sbc   A, high format({%-6s},__GET_LOOP_END($1)); 2:7       __INFO   A = hi index-stop
__{}    xor   H             ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    jp    p, do{}$1      ; 3:10      __INFO
                       ;[26:113]})
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl

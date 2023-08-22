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
__{}define({__INFO},__COMPILE_INFO{(xm)}){}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    ld   BC,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO},
__{}__IS_NUM(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    ld   BC, __HEX_HL(__GET_LOOP_BEGIN($1))     ; 3:10      __INFO},
__{}{
__{}__{}    ld   BC, __FORM({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
__{}do{}$1{}save:              ;           __INFO
__{}    ld  format({%-16s},[idx{}$1]{,}BC); 4:20      __INFO
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
__{}    ld  format({%-16s},[idx{}$1]{,}BC); 4:20      xdo_xi($1,$2) LOOP_STACK
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
__{}    ld  format({%-16s},[idx{}$1]{,}BC); 4:20      xdo_drop_xi($1,$2) LOOP_STACK
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
__{}    ld  format({%-16s},[idx{}$1]{,}BC); 4:20      xdo_push_xi($1,$2,$3) LOOP_STACK
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
__{}__{}    ld  format({%-16s},[idx{}$1]{,}BC); 4:20      __INFO})
__{}do{}$1:                  ;           __INFO})dnl
dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_XLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(__IS_NUM(__GET_LOOP_BEGIN($1)):__IS_NUM(__GET_LOOP_END($1)),1:1,{dnl
__{}__LOOP_ANALYSIS(1,__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}dnl
__{}ifelse(_TEMP_X,{1},{
__{}__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant +1.null: positive step and no repeat},
__{}eval((0<=(__GET_LOOP_BEGIN($1))) && ((__GET_LOOP_BEGIN($1))<(__GET_LOOP_END($1))) && ((__GET_LOOP_END($1))==256)),{1},{
__{}__{}                        ;[10:38]    __INFO   variant +1.A: 0 <= index < stop == 256, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld    A, 0          ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    nop                 ; 1:4       __INFO   hi(index) = 0 = nop -> idx always points to a 16-bit index.
__{}__{}    inc   A             ; 1:4       __INFO   index++
__{}__{}    ld  [idx{}$1],A      ; 3:13      __INFO
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   index-stop},
__{}eval((0<=(__GET_LOOP_BEGIN($1))) && ((__GET_LOOP_BEGIN($1))<(__GET_LOOP_END($1))) && ((__GET_LOOP_END($1))<=256)),{1},{
__{}__{}                        ;[12:45]    __INFO   variant +1.B: 0 <= index < stop <= 256, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld    A, 0          ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    nop                 ; 1:4       __INFO   hi(index) = 0 = nop -> idx always points to a 16-bit index.
__{}__{}    inc   A             ; 1:4       __INFO   index++
__{}__{}    ld  [idx{}$1],A      ; 3:13      __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   index-stop},
__{}eval((0x3C00<=(__GET_LOOP_BEGIN($1))) && ((__GET_LOOP_BEGIN($1))<(__GET_LOOP_END($1))) && ((__GET_LOOP_END($1))==0x3D00)),{1},{
__{}__{}                        ;[9:34]     __INFO   variant +1.C: 0x3C00 <=index < stop == 0x3D00, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld    A, 0          ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc   A             ; 1:4       __INFO   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
__{}__{}    ld  [idx{}$1],A      ; 3:13      __INFO   save index
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}eval((0x3C00<=(__GET_LOOP_BEGIN($1))) && ((__GET_LOOP_BEGIN($1))<(__GET_LOOP_END($1))) && ((__GET_LOOP_END($1))<=0x3D00)),{1},{
__{}__{}                        ;[11:41]    __INFO   variant +1.D: 0x3C00 <=index < stop <= 0x3D00, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld    A, 0          ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc   A             ; 1:4       __INFO   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
__{}__{}    ld  [idx{}$1],A      ; 3:13      __INFO   save index
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}eval(256*(1+__HEX_H(__GET_LOOP_BEGIN($1)))==__GET_LOOP_END($1)),{1},{
__{}__{}                        ;[11:41]    __INFO   variant +1.E: 256*(1+hi(index)) == stop, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO   index++
__{}__{}    ld  [idx{}$1],A      ; 3:13      __INFO   save index
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}eval((__HEX_H(__GET_LOOP_BEGIN($1))==__HEX_H(__GET_LOOP_END($1)-1)) && (__HEX_HL(__GET_LOOP_BEGIN($1))<__HEX_HL(__GET_LOOP_END($1)))),{1},{
__{}__{}                        ;[13:48]    __INFO   variant +1.F: hi(index) == hi(stop-1) && index < stop, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO   index++
__{}__{}    ld  [idx{}$1],A      ; 3:13      __INFO   save index
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__HEX_L(__GET_LOOP_END($1)):__HEX_L(_TEMP_X<257),{0x00:0x01},{
__{}__{}                        ;[9:46/26]  __INFO   variant +1.Ga: stop == 0 && run <= 256, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc   C             ; 1:6       __INFO   index++
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(__GET_LOOP_END($1)),{0},{
__{}__{}                        ;[9:54/34]  __INFO   variant +1.Gb: stop == 0 && run > 256, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    or    C             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}_TEMP_LO_FALSE_POSITIVE,{0},{
__{}__{}                        ;[10:57/37] __INFO   variant +1.H: step one with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}_TEMP_HI_FALSE_POSITIVE,{0},{
__{}__{}                        ;[10:57/37] __INFO   variant +1.{I}: step one with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}{
__{}__{}                        ;[16:57/58] __INFO   variant +1.default: step one, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +1 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}ifelse(eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{dnl
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
__{}__{}{dnl
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})})},

__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}                     ;[18:90/63/70] __INFO   variant +1.pointer
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1)
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.{}dnl
__{}__{}ifelse(__IS_NUM(+__GET_LOOP_END($1)),1,{
__{}__{}__{}    ld    A,(__HEX_HL(+__GET_LOOP_END($1)))    ; 3:13      __INFO   lo(real_stop)},
__{}__{}{
__{}__{}__{}    ld    A,format({%-12s},__GET_LOOP_END($1)); 3:13      __INFO   lo(real_stop)})
__{}__{}    xor   C             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO{}dnl
__{}__{}ifelse(__IS_NUM(+__GET_LOOP_END($1)),1,{
__{}__{}__{}    ld    A,(__HEX_HL(1+__GET_LOOP_END($1)))    ; 3:13      __INFO   hi(real_stop)},
__{}__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}__{}    ld    A,format({%-12s},{(}substr(__GET_LOOP_END($1),1,eval(len(__GET_LOOP_END($1))-2)){+1)}); 3:13      __INFO   hi(real_stop)})
__{}__{}    xor   B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__{}{dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_END($1)),0:0,{
__{}__{}  if (__GET_LOOP_BEGIN($1)+1 = __GET_LOOP_END($1))
__{}__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant +1.variable.null: positive step and no repeat
__{}__{}  else})
__{}__{}                     ;[16:78/57/58] __INFO   variant +1.variable
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1)
__{}__{}    inc  BC             ; 1:6       __INFO   index--{}dnl
__{}__{}ifelse(__IS_NUM(__GET_LOOP_END($1)),1,{
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo(real_stop)},
__{}__{}{
__{}__{}__{}    ld    A, low __FORM({%-7s},__GET_LOOP_END($1)); 2:7       __INFO   lo(real_stop)})
__{}__{}    xor   C             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO{}dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_END($1)),0:0,{
__{}__{}__{}   if ((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))>256 || (__GET_LOOP_BEGIN($1)>=__GET_LOOP_END($1)))}){}dnl
__{}__{}ifelse(__IS_NUM(__GET_LOOP_END($1)),1,{
__{}__{}__{}    ld    A, __HEX_H(__GET_LOOP_END($1))       ; 2:7       __INFO   hi(real_stop)},
__{}__{}{
__{}__{}__{}    ld    A, high __FORM({%-6s},__GET_LOOP_END($1)); 2:7       __INFO   hi(real_stop)})
__{}__{}    xor   B             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO{}dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_END($1)),0:0,{
__{}__{}__{}   endif
__{}__{}__{}  endif}){}dnl
__{}})
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
define({__ASM_TOKEN_SUB1_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xm)){}dnl
ifelse(__IS_NUM(__GET_LOOP_BEGIN($1)):__IS_NUM(__GET_LOOP_END($1)),1:1,{dnl
__{}__LOOP_ANALYSIS(-1,__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}dnl
__{}ifelse(_TEMP_X,{1},{
__{}__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant -1.null: negative step and no repeat},
__{}__HEX_L(_TEMP_X<=129):__HEX_L(__GET_LOOP_END($1)),0x01:0x00,{
__{}__{}                        ;[7:44/24]  __INFO   variant -1.A.0a: step -1 and run<=129 and lo(stop)==0, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    jp    p, do{}$1{}save  ; 3:10      __INFO},
__{}__HEX_L(_TEMP_X<=256):__HEX_L(__GET_LOOP_END($1)),0x01:0x00,{
__{}__{}                        ;[9:54/34] __INFO   variant -1.A.0b: step -1 and run<=256 and lo(stop)==0, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    inc   C             ; 1:4       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}__HEX_L(_TEMP_X<256):__HEX_L(__GET_LOOP_END($1)),0x01:0x01,{
__{}__{}                        ;[7:44/24]  __INFO   variant -1.A.1: step -1 and run<256 and lo(stop)==1, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(__GET_LOOP_END($1)),{0},{
__{}__{}                        ;[9:54/34]  __INFO   variant -1.B: step -1 and stop 0, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(__GET_LOOP_END($1)),{1},{
__{}__{}                        ;[9:54/34]  __INFO   variant -1.C: step -1 and stop 1, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}_TEMP_LO_FALSE_POSITIVE,{0},{
__{}__{}                       ;[10:57/37]  __INFO   variant -1.D: step -1 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}_TEMP_HI_FALSE_POSITIVE,{0},{
__{}__{}                        ;[10:57/37] __INFO   variant -1.E: step -1 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval((__GET_LOOP_END($1)+1) & 0xFFFF),{0},{
__{}__{}                       ;[10:58/38]  __INFO   variant -1.F: step -1 and stop -1, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    and   B             ; 1:4       __INFO   0xFF & 0xFF = 0xFF
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    inc   A             ; 1:4       __INFO   0xFF + 1 = zero
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(__GET_LOOP_END($1)),{2},{
__{}__{}                        ;[10:58/38] __INFO   variant -1.G: step -1 and stop 2, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(__HEX_H(_TEMP_REAL_STOP)==0),{1},{
__{}__{}                        ;[11:61/41] __INFO   variant -1.H: step -1 and hi(real_stop) = 0, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}{
__{}__{}ifelse(eval(_TEMP_LO_FALSE_POSITIVE<=_TEMP_HI_FALSE_POSITIVE),{1},{dnl
__{}__{}__{}                        ;[16:57/58] __INFO   variant -1.defaultA: step -1, LO first, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first},
__{}__{}{dnl
__{}__{}__{}                        ;[16:57/58] __INFO   variant -1.defaultB: step -1, HI first, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first})})},

__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}                     ;[17:87/75/67] __INFO   variant -1.pointer
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1){}dnl
__{}__{}ifelse(__IS_NUM(+__GET_LOOP_END($1)),1,{
__{}__{}__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.
__{}__{}__{}    ld    A,(__HEX_HL(+__GET_LOOP_END($1)))    ; 3:13      __INFO   lo(real_stop)
__{}__{}__{}    xor   C             ; 1:4       __INFO
__{}__{}__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}__{}__{}    ld    A,(__HEX_HL(1+__GET_LOOP_END($1)))    ; 3:13      __INFO   hi(real_stop)},
__{}__{}{
__{}__{}__{}  .warning: Used for Stop pointer, unlike the specification, the pointer will be updated before each check.
__{}__{}__{}    ld    A,format({%-12s},__GET_LOOP_END($1)); 3:13      __INFO   lo(real_stop)
__{}__{}__{}    xor   C             ; 1:4       __INFO
__{}__{}__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}__{}__{}    ld    A,format({%-12s},{(}substr(__GET_LOOP_END($1),1,eval(len(__GET_LOOP_END($1))-2)){+1)}); 3:13      __INFO   hi(real_stop)})
__{}__{}    xor   B             ; 1:4       __INFO
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__{}{dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_END($1)),0:0,{
__{}__{}  if (__GET_LOOP_BEGIN($1) = __GET_LOOP_END($1))
__{}__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant -1.variable.null: negative step and no repeat
__{}__{}  else})
__{}__{}                     ;[16:78/57/58] __INFO   variant -1.variable
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -1 ..__GET_LOOP_END($1)
__{}__{}    dec  BC             ; 1:6       __INFO   index--{}dnl
__{}__{}ifelse(__IS_NUM(__GET_LOOP_END($1)),1,{
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo(real_stop)},
__{}__{}{
__{}__{}__{}    ld    A, low __FORM({%-7s},__GET_LOOP_END($1)-1); 2:7       __INFO   lo(real_stop)})
__{}__{}    xor   C             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO{}dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_END($1)),0:0,{
__{}__{}__{}   if ((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1))>255 || (__GET_LOOP_BEGIN($1)<__GET_LOOP_END($1)))}){}dnl
__{}__{}ifelse(__IS_NUM(__GET_LOOP_END($1)),1,{
__{}__{}__{}    ld    A, __HEX_H(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   hi(real_stop)},
__{}__{}{
__{}__{}__{}    ld    A, high __FORM({%-6s},__GET_LOOP_END($1)-1); 2:7       __INFO   hi(real_stop)})
__{}__{}__{}    xor   B             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO{}dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_END($1)),0:0,{
__{}__{}__{}   endif
__{}__{}__{}  endif}){}dnl
__{}})
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
})dnl
dnl
dnl
dnl # 2 +loop
dnl # ( -- )
define({__ASM_TOKEN_ADD2_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(xm)){}dnl
ifelse(__IS_NUM(__GET_LOOP_BEGIN($1)):__IS_NUM(__GET_LOOP_END($1)),1:1,{dnl
__{}__LOOP_ANALYSIS(2,__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}ifelse(_TEMP_X,{1},{
__{}__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant +2.null: positive step and no repeat},
__{}eval(_TEMP_REAL_STOP),{0},{
__{}__{}                        ;[10:58/38] __INFO   variant +2.A: step 2 and real_stop is zero, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(_TEMP_REAL_STOP),{1},{
__{}__{}                        ;[10:58/38] __INFO   variant +2.B: step 2 and real_stop is one, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}_TEMP_LO_FALSE_POSITIVE,{0},{
__{}__{}                        ;[11:61/41] __INFO   variant +2.C: step 2 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{0},{dnl
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}__{}{dnl
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++})
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}_TEMP_HI_FALSE_POSITIVE,{0},{
__{}__{}                        ;[11:61/41] __INFO   variant +2.D: step 2 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{0},{dnl
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}__{}{dnl
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++})
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{
__{}__{}                        ;[17:61/62] __INFO   variant +2.defaultA: positive step 2, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{0},{dnl
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}__{}{dnl
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++})
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
__{}{
__{}__{}                        ;[17:61/62] __INFO   variant +2.defaultB: positive step 2, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{0},{dnl
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}__{}{dnl
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++})
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})},



__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}                    ;[20:89/101/81] __INFO   variant +2.pointer end
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)){}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A, format({%-11s},__GET_LOOP_END($1)); 3:13      __INFO
__{}__{}    sub   C             ; 1:4       __INFO   lo(stop-(index+1))
__{}__{}    rra                 ; 1:4       __INFO
__{}__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}__{}    ld    A,format({%-12s},{(}substr(__GET_LOOP_END($1),1,eval(len(__GET_LOOP_END($1))-2)){+1)}); 3:13      __INFO
__{}__{}    sbc   A, B          ; 1:4       __INFO   hi(stop-(index+1))
__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}{dnl
__{}__{}ifelse(__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0001,{
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0000,{
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++},
__{}__{}{
__{}__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}__{}  else
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}__{}  endif})
__{}__{}    ld    A, format({%-11s},__GET_LOOP_END($1)); 3:13      __INFO
__{}__{}    sub   C             ; 1:4       __INFO   lo(stop-(index+1))
__{}__{}    rra                 ; 1:4       __INFO
__{}__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}__{}    ld    A,format({%-12s},{(}substr(__GET_LOOP_END($1),1,eval(len(__GET_LOOP_END($1))-2)){+1)}); 3:13      __INFO
__{}__{}    sbc   A, B          ; 1:4       __INFO   hi(stop-(index+1)){}dnl
__{}__{}ifelse(__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0001,{
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0000,{
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}__{}{
__{}__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}__{}  else
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}__{}  endif})})
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}                     ;[19:71/92/72] __INFO   variant +2.pointer_from
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1))
__{}    inc  BC             ; 1:6       __INFO   index++
__{}    inc  BC             ; 1:6       __INFO   index++
__{}    ld    A, C          ; 1:4       __INFO
__{}    sub  low __FORM({%-11s},__GET_LOOP_END($1)); 2:7       __INFO   lo(index+2-stop)
__{}    rra                 ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    sbc   A, high __FORM({%-6s},__GET_LOOP_END($1)); 2:7       __INFO   hi(index+2-stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

{
__{}                     ;[17:61/82/62] __INFO   variant +2.variable
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +2 ..(__GET_LOOP_END($1)){}dnl
__{}ifelse(__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0001,{
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    inc   C             ; 1:4       __INFO   index++},
__{}__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0000,{
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}    inc  BC             ; 1:6       __INFO   index++},
__{}{
__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}  else
__{}__{}    inc   C             ; 1:4       __INFO   index++
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}  endif})
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  low  __FORM({%-11s},__GET_LOOP_END($1)+(1&((__GET_LOOP_BEGIN($1))xor(__GET_LOOP_END($1))))); 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  high __FORM({%-10s},__GET_LOOP_END($1)+(1&((__GET_LOOP_BEGIN($1))xor(__GET_LOOP_END($1))))); 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO})
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
ifelse(__IS_NUM(__GET_LOOP_BEGIN($1)):__IS_NUM(__GET_LOOP_END($1)),1:1,{dnl
__{}__LOOP_ANALYSIS(-2,__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}ifelse(_TEMP_X,{1},{
__{}__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant -2.null: positive step and no repeat},
__{}eval((_TEMP_REAL_STOP+2) & 0xFFFF),{0},{
__{}__{}                        ;[10:58/38] __INFO   variant -2.A: step -2 and real_stop is -2, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    sub   B             ; 1:4       __INFO
__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO},
__{}eval((_TEMP_REAL_STOP+1) & 0xFFFF),{0},{
__{}__{}                        ;[10:58/38] __INFO   variant -2.B: step -2 and real_stop is -1, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(_TEMP_REAL_STOP),{0},{
__{}__{}                        ;[10:58/38] __INFO   variant -2.C: step -2 and real_stop is zero, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}_TEMP_HI_FALSE_POSITIVE,{0},{
__{}__{}                        ;[11:61/41] __INFO   variant -2.D: step -2 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}__{}{dnl
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}_TEMP_LO_FALSE_POSITIVE,{0},{
__{}__{}                        ;[11:61/41] __INFO   variant -2.E: step -2 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}{dnl
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(_TEMP_REAL_STOP),{1},{
__{}__{}                        ;[11:62/42] __INFO   variant -2.F: step -2 and real_stop is one, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(_TEMP_REAL_STOP & 0xFF00),{0},{
__{}__{}                        ;[12:65/45] __INFO   variant -2.G: step -2 and real_stop 2..255, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}__{}{dnl
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},
__{}eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{
__{}__{}                        ;[17:61/62] __INFO   variant -2.defaultA: positive step -2, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}__{}{dnl
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
__{}{
__{}__{}                        ;[17:61/62] __INFO   variant -2.defaultB: positive step -2, run _TEMP_X{}x
__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}ifelse(eval(__GET_LOOP_BEGIN($1) & 1),{1},{dnl
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}__{}{dnl
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--})
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})},

__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}                    ;[20:89/101/81] __INFO   variant -2.pointer end
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1){}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld    A, format({%-11s},__GET_LOOP_END($1)); 3:13      __INFO
__{}__{}    sub   C             ; 1:4       __INFO   lo(stop-(index-1))
__{}__{}    rra                 ; 1:4       __INFO
__{}__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}__{}    ld    A,format({%-12s},{(}substr(__GET_LOOP_END($1),1,eval(len(__GET_LOOP_END($1))-2)){+1)}); 3:13      __INFO
__{}__{}    sbc   A, B          ; 1:4       __INFO   hi(stop-(index-1))
__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}{dnl
__{}__{}ifelse(__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0001,{
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0000,{
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}{
__{}__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}__{}  else
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}  endif})
__{}__{}    ld    A, format({%-11s},__GET_LOOP_END($1)); 3:13      __INFO
__{}__{}    sub   C             ; 1:4       __INFO   lo(stop-(index-1))
__{}__{}    rra                 ; 1:4       __INFO
__{}__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}__{}    ld    A,format({%-12s},{(}substr(__GET_LOOP_END($1),1,eval(len(__GET_LOOP_END($1))-2)){+1)}); 3:13      __INFO
__{}__{}    sbc   A, B          ; 1:4       __INFO   hi(stop-(index-1)){}dnl
__{}__{}ifelse(__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0001,{
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0000,{
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--},
__{}__{}{
__{}__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}  else
__{}__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}__{}  endif})})
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

__{}__HAS_PTR(__GET_LOOP_END($1)):__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_STEP($1)),{0:0:0},{
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}$0_ADD_STEP{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x0000,{
dnl ;# end+(step-((end-begin) mod step))mod step
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )},
__{}__{}__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x8000,{
dnl ;# end+step+((begin-end) mod -step)
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)-__16BIT_TO_ABS(__GET_LOOP_STEP($1))+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod __16BIT_TO_ABS(__GET_LOOP_STEP($1))))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)-__16BIT_TO_ABS(__GET_LOOP_STEP($1))+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod __16BIT_TO_ABS(__GET_LOOP_STEP($1))))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )},
__{}__{}{
__{}__{}__{}  if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )
__{}__{}__{}  else
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+__GET_LOOP_STEP($1)+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod -__GET_LOOP_STEP($1)))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+__GET_LOOP_STEP($1)+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod -__GET_LOOP_STEP($1)))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )
__{}__{}__{}  endif})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO},

__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}                     ;[18:83/89/69] __INFO   variant -2.pointer
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1)
__{}    ld    A, C          ; 1:4       __INFO
__{}    sub  low __FORM({%-11s},__GET_LOOP_END($1)); 2:7       __INFO   lo(index-stop)
__{}    rra                 ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}    jr   nz, $+5        ; 2:7/12    __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    sbc   A, high __FORM({%-6s},__GET_LOOP_END($1)); 2:7       __INFO   hi(index-stop)
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    dec  BC             ; 1:6       __INFO   index--
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO},

{
__{}                     ;[17:61/82/62] __INFO   variant -2.variable
__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. -2 ..__GET_LOOP_END($1){}dnl
__{}ifelse(__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0001,{
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    dec  BC             ; 1:6       __INFO   index--},
__{}__HEX_HL(__GET_LOOP_BEGIN($1) & 1),0x0000,{
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--},
__{}{
__{}__{}  if ((__GET_LOOP_BEGIN($1)) & 1)
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}  else
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    dec   C             ; 1:4       __INFO   index--
__{}__{}  endif})
__{}    ld    A, C          ; 1:4       __INFO
__{}    xor  low  __FORM({%-11s},__GET_LOOP_END($1)-2+(1&((__GET_LOOP_BEGIN($1))xor(__GET_LOOP_END($1))))); 2:7       __INFO   lo(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    xor  high __FORM({%-10s},__GET_LOOP_END($1)-2+(1&((__GET_LOOP_BEGIN($1))xor(__GET_LOOP_END($1))))); 2:7       __INFO   hi(real_stop)
__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO})
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
__{}ifelse(__IS_NUM(__GET_LOOP_BEGIN($1)):__IS_NUM(__GET_LOOP_END($1)),1:1,{dnl
__{}__{}__LOOP_ANALYSIS(__GET_LOOP_STEP($1),__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}dnl
__{}__{}ifelse(_TEMP_X,{1},{
__{}__{}__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant +X.null: positive step and no repeat},

__{}__{}eval((0 <= __GET_LOOP_BEGIN($1)) && (__GET_LOOP_BEGIN($1) < __GET_LOOP_END($1)) && (__GET_LOOP_END($1) < 256)),{1},{
__{}__{}__{}                        ;[13:48]    __INFO   variant +X.A: positive step and 0 <= index < stop < 256, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld    A, 0x00       ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    nop                 ; 1:4       __INFO   Contains a zero value because idx always points to a 16-bit index.
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO   A = index+step
__{}__{}__{}    ld  [idx{}$1], A     ; 3:13      __INFO   save new index
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((0xC600 <= (__GET_LOOP_BEGIN($1) & 0xFFFF)) && ((__GET_LOOP_BEGIN($1) & 0xFFFF) < (__GET_LOOP_END($1) & 0xFFFF)) && ((__GET_LOOP_END($1) & 0xFFFF) < 0xC700)),{1},{
__{}__{}__{}                        ;[12:44]    __INFO   variant +X.B: positive step and 0xC600 <= index < stop < 0xC700, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld    A, 0x00       ; 2:7       __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO   First byte contains a 0xC6 value because idx always points to a 16-bit index.
__{}__{}__{}    ld  [idx{}$1], A     ; 3:13      __INFO   save new index
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval(__GET_LOOP_STEP($1) & 0xFF),{0},{
__{}__{}__{}                        ;[14:51]    __INFO   variant +X.C: positive step = n*256, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    add   A, __HEX_H(__GET_LOOP_STEP($1))       ; 2:7       __INFO   hi(step)
__{}__{}__{}    ld  (idx{}$1+1),A    ; 3:13      __INFO   save index
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((__GET_LOOP_END($1)==0) && ((__GET_LOOP_STEP($1) & 0xFF00)==0)),{1},{
__{}__{}__{}                        ;[14:55/49] __INFO   variant +X.D: positive step 3..255 and stop 0, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((_TEMP_HI_FALSE_POSITIVE==0) && ((__GET_LOOP_STEP($1) & 0xFF00)==0) && (__HEX_H(_TEMP_REAL_STOP)==0)),{1},{
__{}__{}__{}                        ;[14:55/49] __INFO   variant +X.E: positive step 3..255 and hi(real_stop) = exclusivity zero, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((_TEMP_HI_FALSE_POSITIVE==0) && ((__GET_LOOP_STEP($1) & 0xFF00)==0)),{1},{
__{}__{}__{}                        ;[17:55/60] __INFO   variant +X.F: positive step 3..255 and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((0==(_TEMP_REAL_STOP & 0xFF00)) && ((__GET_LOOP_STEP($1) & 0xFF00) == 0)),{1},{
__{}__{}__{}                        ;[19:67/68] __INFO   variant +X.G: positive step 3..255 and real_stop 0..255, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}__{}    sub   C             ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((_TEMP_HI_FALSE_POSITIVE==0) && (__HEX_H(_TEMP_REAL_STOP)==0x00)),{1},{
__{}__{}__{}                        ;[14:70/50] __INFO   variant +X.H: positive step 256+ and hi(real_stop) exclusivity zero, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    adc   A, high format({%-6s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((__HEX_H(__GET_LOOP_STEP($1))==0) && (21*_TEMP_HI_FALSE_POSITIVE<=4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)),{1},{
__{}__{}__{}                        ;[21:74/75] __INFO   variant +X.{I}: positive step 3..255, hi(real_stop) has fewer duplicate,run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}__{}    sub   C             ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop) first (21*_TEMP_HI_FALSE_POSITIVE<=4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}_TEMP_HI_FALSE_POSITIVE,{0},{
__{}__{}__{}                        ;[16:77/57] __INFO   variant +X.{J}: positive step 256+ and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    adc   A, high format({%-6s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((_TEMP_LO_FALSE_POSITIVE==0) && ((__GET_LOOP_STEP($1) & 0xFF00) == 0)),{1},{
__{}__{}__{}                        ;[16:78/58] __INFO   variant +X.{K} : positive step 3..255 and lo(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}__{}    sub   C             ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval((__HEX_H(__GET_LOOP_STEP($1))==0) && (21*_TEMP_HI_FALSE_POSITIVE>4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)),{1},{
__{}__{}__{}                        ;[22:78/79] __INFO   variant +X.L: positive step 3..255, lo(real_stop) has fewer duplicate, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. +__GET_LOOP_STEP($1) ..(__GET_LOOP_END($1)), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    add   A, low format({%-7s},__GET_LOOP_STEP($1)); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}__{}    sub   C             ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop) first (21*_TEMP_HI_FALSE_POSITIVE>4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}{
__{}__{}__{}   .error +xloop: This variant should never happen... index: __GET_LOOP_BEGIN($1), stop:__GET_LOOP_END($1), step: __GET_LOOP_STEP($1){}dnl
__{}__{}}){}dnl
__{}},

__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}define({$0_MIN_STEP},       __LD_R16({BC},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_STEP($1))))){}dnl
__{}__{}define({$0_STOP},           __LD_R16({BC},__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)))){}dnl
__{}__{}                       ;[eval(15+__SUM_BYTES):eval(87+__SUM_CLOCKS)]    __INFO   version default
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}$0_ADD_STEP
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index{}dnl
__{}__{}$0_STOP   BC = stop
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index+step-stop{}dnl
__{}__{}$0_MIN_STEP   BC = -step
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop
__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}{
__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}  else
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}  endif})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO},

__{}__HAS_PTR(__GET_LOOP_END($1)):__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_STEP($1)),{0:0:0},{
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}$0_ADD_STEP{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x0000,{
dnl ;# end+(step-((end-begin) mod step))mod step
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )},
__{}__{}__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x8000,{
dnl ;# end+step+((begin-end) mod -step)
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)-__16BIT_TO_ABS(__GET_LOOP_STEP($1))+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod __16BIT_TO_ABS(__GET_LOOP_STEP($1))))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)-__16BIT_TO_ABS(__GET_LOOP_STEP($1))+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod __16BIT_TO_ABS(__GET_LOOP_STEP($1))))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )},
__{}__{}{
__{}__{}__{}  if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )
__{}__{}__{}  else
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+__GET_LOOP_STEP($1)+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod -__GET_LOOP_STEP($1)))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+__GET_LOOP_STEP($1)+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod -__GET_LOOP_STEP($1)))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )
__{}__{}__{}  endif})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO},

__{}{dnl
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}define({$0_MIN_STEP},__LD_R16({BC},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_STEP($1))))){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_END($1))),{BC = -stop},{HL = index+step-stop}){}dnl
__{}__{}define({$0_MIN_STOP},__CODE){}dnl
__{}__{}ifelse(ifelse(__POLLUTES,{c},1,eval(__SUM_PRICE<2*__PRICE+11+3*__BYTE_PRICE),1,1,0),1,{
__{}__{}__{}                       ;format({%-11s},[eval(12+__SUM_BYTES):eval(68+__SUM_CLOCKS)]) __INFO   version default
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}__{}$0_ADD_STEP
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index{}dnl
__{}__{}__{}$0_MIN_STOP{}dnl
__{}__{}__{}$0_MIN_STEP   BC = -step
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop
__{}__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}__{}{
__{}__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}__{}  else
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}__{}  endif})},
__{}__{}{
__{}__{}__{}__RESET_SUMS(){}dnl
__{}__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_END($1))),{__CR  .error Used BC!},{HL = index-stop}){}dnl
__{}__{}__{}define({$0_SUB_STOP},__CODE){}dnl
__{}__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)),{__CR  .error Used BC!},{HL = index+step}){}dnl
__{}__{}__{}define({$0_ADD_STOP},__CODE){}dnl
__{}__{}__{}define({$0_BC_STEP},__LD_R16({BC},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)))){}dnl
__{}__{}__{}                       ;format({%-11s},[eval(12+__SUM_BYTES):eval(68+__SUM_CLOCKS)]) __INFO   version default
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}__{}$0_SUB_STOP{}dnl
__{}__{}__{}$0_BC_STEP
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop+step{}dnl
__{}__{}__{}$0_ADD_STOP
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}__{}{
__{}__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}__{}  else
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}__{}  endif})})
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # stop index do ... -step +loop
dnl # ( -- )
dnl # xdo(stop,index) ... push_addxloop(-step)
define({__ASM_TOKEN_NEGATIVE_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(xm)}){}dnl
__{}ifelse(__IS_NUM(__GET_LOOP_BEGIN($1)):__IS_NUM(__GET_LOOP_END($1)),1:1,{dnl
__{}__{}__LOOP_ANALYSIS(__GET_LOOP_STEP($1),__GET_LOOP_BEGIN($1),__GET_LOOP_END($1)){}dnl
__{}__{}ifelse(_TEMP_X,{1},{
__{}__{}__{}idx{}$1 EQU do{}$1{}save-2  ;           __INFO   variant -X.null: positive step and no repeat},

__{}__{}eval((__GET_LOOP_STEP($1)==-3) && (__GET_LOOP_END($1)==0)),{1},{
__{}__{}__{}                        ;[11:66/46] __INFO   variant -X.A: step -3 and stop 0, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, B          ; 1:4       __INFO   hi old index
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}__{}    sub   B             ; 1:4       __INFO   old-new = carry if index: positive -> negative
__{}__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO   carry if postivie index -> negative index
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval(__GET_LOOP_END($1)==0),{1},{
__{}__{}__{}                        ;[14:70/50] __INFO   variant -X.B: negative step and stop 0, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    sbc   A, high format({%-6s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO   carry if postivie index -> negative index
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},


__{}__{}_TEMP_HI_FALSE_POSITIVE,{0},{
__{}__{}__{}ifelse(eval((-1*(__GET_LOOP_STEP($1))) & 0xFF00),{0},{
__{}__{}__{}__{}                        ;[17:55/60] __INFO   variant +X.C: negative step 3..255 and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}__{}    jp   nc, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}__{}    dec   B             ; 1:4       __INFO
__{}__{}__{}__{}    ld    A, B          ; 1:4       __INFO},
__{}__{}__{}{
__{}__{}__{}__{}                        ;[16:77/57] __INFO   variant +X.D: negative step 256+ and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}__{}    sbc   A, high format({%-6s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}__{}    ld    B, A          ; 1:4       __INFO})
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}eval(_TEMP_REAL_STOP & 0xFF00),{0},{
__{}__{}__{}__{}                        ;[20:70/71] __INFO   variant -X.E: negative step and real_stop 0..255, run _TEMP_X{}x
__{}__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}__{}    sbc   A, high format({%-6s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}__{}    ld    A, C          ; 1:4       __INFO   A = last_index
__{}__{}__{}__{}    xor  format({%-15s},low _TEMP_REAL_STOP); 2:7       __INFO
__{}__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO},

__{}__{}{
__{}__{}__{}                        ;[23:81/82] __INFO   variant -X.default: negative step, run _TEMP_X{}x
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO   idx always points to a 16-bit index
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   __GET_LOOP_BEGIN($1).. __GET_LOOP_STEP($1) ..__GET_LOOP_END($1), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    sub  low format({%-11s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    sbc   A, high format({%-6s},eval(-(__GET_LOOP_STEP($1)))); 2:7       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       __INFO   lo(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_LO_FALSE_POSITIVE{}x
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       __INFO   hi(real_stop)
__{}__{}__{}    jp   nz, do{}$1{}save  ; 3:10      __INFO   _TEMP_HI_FALSE_POSITIVE{}x
__{}__{}__{}leave{}$1:               ;           __INFO
__{}__{}__{}exit{}$1:                ;           __INFO{}dnl
__{}__{}}){}dnl
__{}},

__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}define({$0_MIN_STEP},       __LD_R16({BC},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_STEP($1))))){}dnl
__{}__{}define({$0_STOP},           __LD_R16({BC},__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)))){}dnl
__{}__{}                       ;[eval(15+__SUM_BYTES):eval(87+__SUM_CLOCKS)]    __INFO   version default
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}$0_ADD_STEP
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index{}dnl
__{}__{}$0_STOP   BC = stop
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index+step-stop{}dnl
__{}__{}$0_MIN_STEP   BC = -step
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop
__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}{
__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}  else
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}  endif})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO},

__{}__HAS_PTR(__GET_LOOP_END($1)):__HAS_PTR(__GET_LOOP_BEGIN($1)):__HAS_PTR(__GET_LOOP_STEP($1)),{0:0:0},{
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}$0_ADD_STEP{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x0000,{
dnl ;# end+(step-((end-begin) mod step))mod step
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )},
__{}__{}__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x8000,{
dnl ;# end+step+((begin-end) mod -step)
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)-__16BIT_TO_ABS(__GET_LOOP_STEP($1))+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod __16BIT_TO_ABS(__GET_LOOP_STEP($1))))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)-__16BIT_TO_ABS(__GET_LOOP_STEP($1))+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod __16BIT_TO_ABS(__GET_LOOP_STEP($1))))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )},
__{}__{}{
__{}__{}__{}  if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+(__GET_LOOP_STEP($1)-((__GET_LOOP_END($1)-__GET_LOOP_BEGIN($1))mod __GET_LOOP_STEP($1)))mod __GET_LOOP_STEP($1))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )
__{}__{}__{}  else
__{}__{}__{}    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+__GET_LOOP_STEP($1)+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod -__GET_LOOP_STEP($1)))); 2:7       __INFO   lo(real_stop)
__{}__{}__{}    cp    E             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)+__GET_LOOP_STEP($1)+((__GET_LOOP_BEGIN($1)-__GET_LOOP_END($1)) mod -__GET_LOOP_STEP($1)))); 2:7       __INFO   hi(real_stop)
__{}__{}__{}    cp    D             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO   ( -- ) ( R: index -- index+__GET_LOOP_STEP($1) )
__{}__{}__{}  endif})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO},


__{}{dnl
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}define({$0_MIN_STEP},__LD_R16({BC},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_STEP($1))))){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_END($1))),{BC = -stop},{HL = index+step-stop}){}dnl
__{}__{}define({$0_MIN_STOP},__CODE){}dnl
__{}__{}ifelse(ifelse(__POLLUTES,{c},1,eval(__SUM_PRICE<2*__PRICE+11+3*__BYTE_PRICE),1,1,0),1,{
__{}__{}__{}                       ;format({%-11s},[eval(12+__SUM_BYTES):eval(68+__SUM_CLOCKS)]) __INFO   version default
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}__{}$0_ADD_STEP
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index{}dnl
__{}__{}__{}$0_MIN_STOP{}dnl
__{}__{}__{}$0_MIN_STEP   BC = -step
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop
__{}__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}__{}{
__{}__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}__{}  else
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}__{}  endif})},
__{}__{}{
__{}__{}__{}__RESET_SUMS(){}dnl
__{}__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_END($1))),{__CR  .error Used BC!},{HL = index-stop}){}dnl
__{}__{}__{}define({$0_SUB_STOP},__CODE){}dnl
__{}__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)),{__CR  .error Used BC!},{HL = index+step}){}dnl
__{}__{}__{}define({$0_ADD_STOP},__CODE){}dnl
__{}__{}__{}define({$0_BC_STEP},__LD_R16({BC},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)))){}dnl
__{}__{}__{}                       ;format({%-11s},[eval(12+__SUM_BYTES):eval(68+__SUM_CLOCKS)]) __INFO   version default
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}__{}$0_SUB_STOP{}dnl
__{}__{}__{}$0_BC_STEP
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop+step{}dnl
__{}__{}__{}$0_ADD_STOP
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}__{}{
__{}__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}__{}  else
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}__{}  endif})})
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # stop index do ... step +loop
dnl # ( -- )
dnl # xdo(stop,index) ... push_addxloop(step)
define({__ASM_TOKEN_NO_NUM_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}define({$0_MIN_STEP},       __LD_R16({BC},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_STEP($1))))){}dnl
__{}__{}define({$0_STOP},           __LD_R16({BC},__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)))){}dnl
__{}__{}                       ;[eval(15+__SUM_BYTES):eval(87+__SUM_CLOCKS)]    __INFO   version default
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}$0_ADD_STEP
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index{}dnl
__{}__{}$0_STOP   BC = stop
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index+step-stop{}dnl
__{}__{}$0_MIN_STEP   BC = -step
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop
__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}{
__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}  else
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}  endif})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO{}dnl
__{}},

__{}{dnl
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}define({$0_MIN_STEP},__LD_R16({BC},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_STEP($1))))){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_END($1))),{BC = -stop},{HL = index+step-stop}){}dnl
__{}__{}define({$0_MIN_STOP},__CODE){}dnl
__{}__{}ifelse(ifelse(__POLLUTES,{c},1,eval(__SUM_PRICE<2*__PRICE+11+3*__BYTE_PRICE),1,1,0),1,{
__{}__{}__{}                       ;format({%-11s},[eval(12+__SUM_BYTES):eval(68+__SUM_CLOCKS)]) __INFO   version default
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}__{}$0_ADD_STEP
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index{}dnl
__{}__{}__{}$0_MIN_STOP{}dnl
__{}__{}__{}$0_MIN_STEP   BC = -step
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop
__{}__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}__{}{
__{}__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}__{}  else
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}__{}  endif})},
__{}__{}{
__{}__{}__{}__RESET_SUMS(){}dnl
__{}__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_END($1))),{__CR  .error Used BC!},{HL = index-stop}){}dnl
__{}__{}__{}define({$0_SUB_STOP},__CODE){}dnl
__{}__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)),{__CR  .error Used BC!},{HL = index+step}){}dnl
__{}__{}__{}define({$0_ADD_STOP},__CODE){}dnl
__{}__{}__{}define({$0_BC_STEP},__LD_R16({BC},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)))){}dnl
__{}__{}__{}                       ;format({%-11s},[eval(12+__SUM_BYTES):eval(68+__SUM_CLOCKS)]) __INFO   version default
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}__{}__{}$0_SUB_STOP{}dnl
__{}__{}__{}$0_BC_STEP
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop+step{}dnl
__{}__{}__{}$0_ADD_STOP
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   positive step},
__{}__{}__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   negative step},
__{}__{}__{}{
__{}__{}__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   positive step
__{}__{}__{}__{}  else
__{}__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   negative step
__{}__{}__{}__{}  endif})})
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # step +loop
dnl # ( -- )
define({__ASM_TOKEN_PUSH_ADDXLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(xm)}){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},

__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},

__{}__HAS_PTR(__GET_LOOP_STEP($1)),1,{
__{}__{}__RESET_SUMS{}dnl
__{}__{}define({$0_STOP},__LD_R16({BC},__GET_LOOP_END($1))){}dnl
__{}__{}define({$0_STEP},__LD_R16({DE},__GET_LOOP_STEP($1))){}dnl
__{}                       ;[eval(20+__SUM_BYTES):eval(127+__SUM_CLOCKS)]    __INFO   version step is pointer
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}$0_STOP   BC = stop{}dnl
__{}$0_STEP   DE = step
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}    sbc   A, A          ; 1:4       __INFO
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}    xor   D             ; 1:4       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    jp    p, do{}$1      ; 3:10      __INFO
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO{}dnl
__{}},

__{}__HEX_HL(__GET_LOOP_STEP($1)),0x0001,{__ASM_TOKEN_XLOOP($1)},
__{}__HEX_HL(__GET_LOOP_STEP($1)),0xFFFF,{__ASM_TOKEN_SUB1_ADDXLOOP($1)},
__{}__HEX_HL(__GET_LOOP_STEP($1)),0x0002,{__ASM_TOKEN_ADD2_ADDXLOOP($1)},
__{}__HEX_HL(__GET_LOOP_STEP($1)),0xFFFE,{__ASM_TOKEN_SUB2_ADDXLOOP($1)},
__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),{0x0000},{__ASM_TOKEN_POSITIVE_ADDXLOOP($1)},
__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),{0x8000},{__ASM_TOKEN_NEGATIVE_ADDXLOOP($1)},
__{}{__ASM_TOKEN_NO_NUM_ADDXLOOP($1)}){}dnl
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
__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
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
__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
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

__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}define({$0_STOP},__LD_R16({BC},__GET_LOOP_END($1))){}dnl
__{}                       ;[eval(20+__BYTES):eval(120+__CLOCKS)]    __INFO   version step from stack and stop is pointer
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO   DE = step
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}$0_STOP   BC = stop
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}    sbc   A, A          ; 1:4       __INFO
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}    xor   D             ; 1:4       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    jp    p, do{}$1      ; 3:10      __INFO},

__{}1,1,{
__{}__{}define({$0_STOP},__LD_R16({BC},__GET_LOOP_END($1))){}dnl
__{}                       ;[eval(20+__BYTES):eval(120+__CLOCKS)]    __INFO   version step from stack
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO   DE = step
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}$0_STOP   BC = stop
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}    sbc   A, A          ; 1:4       __INFO
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}    xor   D             ; 1:4       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    jp    p, do{}$1      ; 3:10      __INFO},

__{}{fail with "54321 4321 do 1000 asm() +loop"
__{}                       ;[26:113]    __INFO   version step from stack
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   BC, 0x0000     ; 3:10      __INFO   BC = index
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
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
__{}    jp    p, do{}$1      ; 3:10      __INFO})
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl

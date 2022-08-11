dnl ## non-recursive xdo(stop,index) xi i xloop
dnl
dnl
dnl
define({_LOOP_ANALYSIS_RECURSE}, {dnl
__{}ifelse(eval((($1)!=($2))),{1},{dnl
__{}__{}define({_TEMP_X},eval(1+_TEMP_X)){}dnl
__{}__{}ifelse(eval((($1)^($2)) & 0x00FF), {0}, {define({_TEMP_LO_FALSE_POSITIVE},eval(1+_TEMP_LO_FALSE_POSITIVE))}){}dnl
__{}__{}ifelse(eval((($1)^($2)) & 0xFF00), {0}, {define({_TEMP_HI_FALSE_POSITIVE},eval(1+_TEMP_HI_FALSE_POSITIVE))}){}dnl
__{}__{}_LOOP_ANALYSIS_RECURSE(eval((0x10000+$1+($3)) & 0xFFFF),$2,$3){}dnl
__{}}){}dnl
})dnl
dnl
dnl
define({_LOOP_ANALYSIS}, {dnl
__{}ifelse(eval(($1)<0),{1},{dnl
__{}__{}define({_TEMP_REAL_STOP},{eval((INDEX_STACK+($1)*(1+((0x10000+INDEX_STACK-(STOP_STACK)) & 0xffff)/(-($1)))) & 0xffff)})},
__{}{dnl
__{}__{}define({_TEMP_REAL_STOP},{eval((INDEX_STACK+($1)*(1+((0x10000+STOP_STACK-(INDEX_STACK)-1) & 0xffff)/($1))) & 0xffff)})}){}dnl
__{}define({_TEMP_X},{1}){}dnl
__{}define({_TEMP_HI_FALSE_POSITIVE},{0}){}dnl
__{}define({_TEMP_LO_FALSE_POSITIVE},{0}){}dnl
__{}_LOOP_ANALYSIS_RECURSE(eval((0x10000+(INDEX_STACK)+($1)) & 0xFFFF),_TEMP_REAL_STOP,$1){}dnl
})dnl
dnl
dnl
dnl # ---------- xdo(stop,index) ... xloop ------------
dnl # Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl # ( -- )
dnl # xdo(stop,index) ... xloop
dnl # xdo(stop,index) ... addxloop(step)
define({XDO},{dnl
__{}__ADD_TOKEN({__TOKEN_XDO},{xdo},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XDO},{dnl
__{}define({__INFO},{xdo}){}dnl

__{}pushdef({STOP_STACK}, $1){}dnl
__{}pushdef({INDEX_STACK}, $2){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}    ld   BC, format({%-11s},$2); 3:10      xdo($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK{}save:             ;           xdo($1,$2) LOOP_STACK
__{}    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      xdo($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK:                 ;           xdo($1,$2) LOOP_STACK})dnl
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
__{}__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}    ld   BC, format({%-11s},$2); 3:10      xdo_xi($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK{}save:             ;           xdo_xi($1,$2) LOOP_STACK
__{}    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      xdo_xi($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK:                 ;           xdo_xi($1,$2) LOOP_STACK
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
__{}__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}    ld   BC, format({%-11s},$2); 3:10      xdo_drop_xi($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK{}save:             ;           xdo_drop_xi($1,$2) LOOP_STACK
__{}    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      xdo_drop_xi($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK:                 ;           xdo_drop_xi($1,$2) LOOP_STACK
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
__{}__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}    ld   BC, format({%-11s},$2); 3:10      xdo_push_xi($1,$2,$3) LOOP_STACK
__{}xdo{}LOOP_STACK{}save:             ;           xdo_push_xi($1,$2,$3) LOOP_STACK
__{}    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      xdo_push_xi($1,$2,$3) LOOP_STACK
__{}xdo{}LOOP_STACK:                 ;           xdo_push_xi($1,$2,$3) LOOP_STACK
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
define({QUESTIONXDO},{dnl
__{}__ADD_TOKEN({__TOKEN_QUESTIONXDO},{questionxdo},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_QUESTIONXDO},{dnl
__{}define({__INFO},{questionxdo}){}dnl

__{}pushdef({STOP_STACK}, $1){}dnl
__{}pushdef({INDEX_STACK}, $2){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}ifelse({$1},{$2},{
__{}__{}    jp   xexit{}LOOP_STACK       ; 3:10      ?xdo($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK{}save:             ;           ?xdo($1,$2) LOOP_STACK},
__{}{
__{}__{}    ld   BC, format({%-11s},$2); 3:10      ?xdo($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK{}save:             ;           ?xdo($1,$2) LOOP_STACK
__{}__{}    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      ?xdo($1,$2) LOOP_STACK})
__{}xdo{}LOOP_STACK:                 ;           ?xdo($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl
dnl # ( -- )
define({XLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_XLOOP},{xloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XLOOP},{dnl
__{}define({__INFO},{xloop}){}dnl
_LOOP_ANALYSIS(1){}ifelse(_TEMP_X,{1},{
__{}idx{}LOOP_STACK EQU xdo{}LOOP_STACK{}save-2 ;           xloop LOOP_STACK   variant +1.null: positive step and no repeat},
eval((0<=(INDEX_STACK)) && ((INDEX_STACK)<(STOP_STACK)) && ((STOP_STACK)==256)),{1},{
__{}                        ;[10:38]    xloop LOOP_STACK   variant +1.A: 0 <= index < stop == 256, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, 0          ; 2:7       xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    nop                 ; 1:4       xloop LOOP_STACK   hi(index) = 0 = nop -> idx always points to a 16-bit index.
__{}    inc   A             ; 1:4       xloop LOOP_STACK   index++
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK   index-stop},
eval((0<=(INDEX_STACK)) && ((INDEX_STACK)<(STOP_STACK)) && ((STOP_STACK)<=256)),{1},{
__{}                        ;[12:45]    xloop LOOP_STACK   variant +1.B: 0 <= index < stop <= 256, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, 0          ; 2:7       xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    nop                 ; 1:4       xloop LOOP_STACK   hi(index) = 0 = nop -> idx always points to a 16-bit index.
__{}    inc   A             ; 1:4       xloop LOOP_STACK   index++
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK   index-stop},
eval((0x3C00<=(INDEX_STACK)) && ((INDEX_STACK)<(STOP_STACK)) && ((STOP_STACK)==0x3D00)),{1},{
__{}                        ;[9:34]     xloop LOOP_STACK   variant +1.C: 0x3C00 <=index < stop == 0x3D00, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, 0          ; 2:7       xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc   A             ; 1:4       xloop LOOP_STACK   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK   save index
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK},
eval((0x3C00<=(INDEX_STACK)) && ((INDEX_STACK)<(STOP_STACK)) && ((STOP_STACK)<=0x3D00)),{1},{
__{}                        ;[11:41]    xloop LOOP_STACK   variant +1.D: 0x3C00 <=index < stop <= 0x3D00, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, 0          ; 2:7       xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc   A             ; 1:4       xloop LOOP_STACK   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK   save index
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK},
eval(256*(1+__HEX_H(INDEX_STACK))==STOP_STACK),{1},{
__{}                        ;[11:41]    xloop LOOP_STACK   variant +1.E: 256*(1+hi(index)) == stop, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    inc   A             ; 1:4       xloop LOOP_STACK   index++
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK   save index
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK},
eval((__HEX_H(INDEX_STACK)==__HEX_H(STOP_STACK-1)) && (__HEX_HL(INDEX_STACK)<__HEX_HL(STOP_STACK))),{1},{
__{}                        ;[13:48]    xloop LOOP_STACK   variant +1.F: hi(index) == hi(stop-1) && index < stop, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    inc   A             ; 1:4       xloop LOOP_STACK   index++
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK   save index
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK},
eval(STOP_STACK),{0},{
__{}                        ;[9:54/34]  xloop LOOP_STACK   variant +1.G: stop == 0, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       xloop LOOP_STACK   index++
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    or    C             ; 1:4       xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK},
_TEMP_LO_FALSE_POSITIVE,{0},{
__{}                        ;[10:57/37] xloop LOOP_STACK   variant +1.H: step one with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       xloop LOOP_STACK   index++
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[10:57/37] xloop LOOP_STACK   variant +1.{I}: step one with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       xloop LOOP_STACK   index++
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK},
{
__{}                        ;[16:57/58] xloop LOOP_STACK   variant +1.default: step one, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   INDEX_STACK.. +1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       xloop LOOP_STACK   index++
__{}ifelse(eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{dnl
__{}__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   lo(real_stop)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
__{}{dnl
__{}__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       xloop LOOP_STACK   hi(real_stop)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})})
xleave{}LOOP_STACK:              ;           xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl # ( -- )
define({SUB1_ADDXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_SUB1_ADDXLOOP},{sub1_addxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SUB1_ADDXLOOP},{dnl
__{}define({__INFO},{sub1_addxloop}){}dnl
_LOOP_ANALYSIS(-1){}ifelse(_TEMP_X,{1},{
__{}idx{}LOOP_STACK EQU xdo{}LOOP_STACK{}save-2 ;           -1 +xloop LOOP_STACK   variant -1.null: positive step and no repeat},
eval(STOP_STACK),{0},{
__{}                        ;[9:54/34]  -1 +xloop LOOP_STACK   variant -1.A: step -1 and stop 0, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -1 +xloop LOOP_STACK
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK},
eval(STOP_STACK),{1},{
__{}                        ;[9:54/34]  -1 +xloop LOOP_STACK   variant -1.B: step -1 and stop 1, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK},
_TEMP_LO_FALSE_POSITIVE,{0},{
__{}                        ;[10:57/37] -1 +xloop LOOP_STACK   variant -1.C: step -1 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       -1 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[10:57/37] -1 +xloop LOOP_STACK   variant -1.D: step -1 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    ld    A, B          ; 1:4       -1 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       -1 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK},
eval((STOP_STACK+1) & 0xFFFF),{0},{
__{}                       ;[10:58/38]  -1 +xloop LOOP_STACK   variant -1.E: step -1 and stop -1, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    and   B             ; 1:4       -1 +xloop LOOP_STACK   0xFF & 0xFF = 0xFF
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    inc   A             ; 1:4       -1 +xloop LOOP_STACK   0xFF + 1 = zero
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK},
eval(STOP_STACK),{2},{
__{}                        ;[10:58/38] -1 +xloop LOOP_STACK   variant -1.F: step -1 and stop 2, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    dec   A             ; 1:4       -1 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK},
eval(__HEX_H(_TEMP_REAL_STOP)==0),{1},{
__{}                        ;[11:61/41] -1 +xloop LOOP_STACK   variant -1.G: step -1 and hi(real_stop) = 0, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       -1 +xloop LOOP_STACK   lo(real_stop)
__{}    or    B             ; 1:4       -1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK},
{
__{}ifelse(eval(_TEMP_LO_FALSE_POSITIVE<=_TEMP_HI_FALSE_POSITIVE),{1},{dnl
__{}__{}                        ;[16:57/58] -1 +xloop LOOP_STACK   variant -1.defaultA: step -1, LO first, run _TEMP_X{}x
__{}__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       -1 +xloop LOOP_STACK   lo(real_stop)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, B          ; 1:4       -1 +xloop LOOP_STACK
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       -1 +xloop LOOP_STACK   hi(real_stop)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first},
__{}{dnl
__{}__{}                        ;[16:57/58] -1 +xloop LOOP_STACK   variant -1.defaultB: step -1, HI first, run _TEMP_X{}x
__{}__{}idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   INDEX_STACK.. -1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}__{}    ld    A, B          ; 1:4       -1 +xloop LOOP_STACK
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       -1 +xloop LOOP_STACK   hi(real_stop)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       -1 +xloop LOOP_STACK   lo(real_stop)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first})})
xleave{}LOOP_STACK:              ;           -1 +xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl # 2 +loop
dnl # ( -- )
define({_ADD2_ADDXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_ADD2_ADDXLOOP},{add2_addxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ADD2_ADDXLOOP},{dnl
__{}define({__INFO},{add2_addxloop}){}dnl
_LOOP_ANALYSIS(2){}ifelse(_TEMP_X,{1},{
__{}idx{}LOOP_STACK EQU xdo{}LOOP_STACK{}save-2 ;           2 +xloop LOOP_STACK   variant +2.null: positive step and no repeat},
eval(_TEMP_REAL_STOP),{0},{
__{}                        ;[10:58/38] 2 +xloop LOOP_STACK   variant +2.A: step 2 and real_stop is zero, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   INDEX_STACK.. +2 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++
__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
__{}    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
__{}    or    B             ; 1:4       2 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK},
eval(_TEMP_REAL_STOP),{1},{
__{}                        ;[10:58/38] 2 +xloop LOOP_STACK   variant +2.B: step 2 and real_stop is one, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   INDEX_STACK.. +2 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
__{}    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++
__{}    or    B             ; 1:4       2 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK},
_TEMP_LO_FALSE_POSITIVE,{0},{
__{}                        ;[11:61/41] 2 +xloop LOOP_STACK   variant +2.C: step 2 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   INDEX_STACK.. +2 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(INDEX_STACK & 1),{0},{dnl
__{}__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++
__{}__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++},
__{}{dnl
__{}__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
__{}__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++})
__{}    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       2 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[11:61/41] 2 +xloop LOOP_STACK   variant +2.D: step 2 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   INDEX_STACK.. +2 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(INDEX_STACK & 1),{0},{dnl
__{}__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++
__{}__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++},
__{}{dnl
__{}__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
__{}__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++})
__{}    ld    A, B          ; 1:4       2 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       2 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK},
eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{
__{}                        ;[17:61/62] 2 +xloop LOOP_STACK   variant +2.defaultA: positive step 2, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   INDEX_STACK.. +2 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(INDEX_STACK & 1),{0},{dnl
__{}__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++
__{}__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++},
__{}{dnl
__{}__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
__{}__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++})
__{}    ld    A, B          ; 1:4       2 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       2 +xloop LOOP_STACK   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       2 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
{
__{}                        ;[17:61/62] 2 +xloop LOOP_STACK   variant +2.defaultB: positive step 2, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   INDEX_STACK.. +2 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(INDEX_STACK & 1),{0},{dnl
__{}__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++
__{}__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++},
__{}{dnl
__{}__{}    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
__{}__{}    inc   C             ; 1:4       2 +xloop LOOP_STACK   index++})
__{}    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       2 +xloop LOOP_STACK   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}    ld    A, B          ; 1:4       2 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       2 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})
xleave{}LOOP_STACK:              ;           2 +xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           2 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl # -2 +loop
dnl # ( -- )
define({_SUB2_ADDXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_SUB2_ADDXLOOP},{sub2_addxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SUB2_ADDXLOOP},{dnl
__{}define({__INFO},{sub2_addxloop}){}dnl
_LOOP_ANALYSIS(-2){}ifelse(_TEMP_X,{1},{
__{}idx{}LOOP_STACK EQU xdo{}LOOP_STACK{}save-2 ;           -2 +xloop LOOP_STACK   variant -2.null: positive step and no repeat},
eval((_TEMP_REAL_STOP+2) & 0xFFFF),{0},{
__{}                        ;[10:58/38] -2 +xloop LOOP_STACK   variant -2.A: step -2 and real_stop is -2, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, B          ; 1:4       -2 +xloop LOOP_STACK
__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}    sub   B             ; 1:4       -2 +xloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK},
eval((_TEMP_REAL_STOP+1) & 0xFFFF),{0},{
__{}                        ;[10:58/38] -2 +xloop LOOP_STACK   variant -2.B: step -2 and real_stop is -1, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -2 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -2 +xloop LOOP_STACK
__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK},
eval(_TEMP_REAL_STOP),{0},{
__{}                        ;[10:58/38] -2 +xloop LOOP_STACK   variant -2.C: step -2 and real_stop is zero, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -2 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -2 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[11:61/41] -2 +xloop LOOP_STACK   variant -2.D: step -2 with hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(INDEX_STACK & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--},
__{}__{}{dnl
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--})
__{}    ld    A, B          ; 1:4       -2 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       -2 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK},
_TEMP_LO_FALSE_POSITIVE,{0},{
__{}                        ;[11:61/41] -2 +xloop LOOP_STACK   variant -2.E: step -2 with lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}ifelse(eval(INDEX_STACK & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--},
__{}{dnl
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--})
__{}    ld    A, C          ; 1:4       -2 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       -2 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK},
eval(_TEMP_REAL_STOP),{1},{
__{}                        ;[11:62/42] -2 +xloop LOOP_STACK   variant -2.F: step -2 and real_stop is one, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -2 +xloop LOOP_STACK
__{}    dec   A             ; 1:4       -2 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -2 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK},
eval(_TEMP_REAL_STOP & 0xFF00),{0},{
__{}                        ;[12:65/45] -2 +xloop LOOP_STACK   variant -2.G: step -2 and real_stop 2..255, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(INDEX_STACK & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--},
__{}__{}{dnl
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--})
__{}    ld    A, C          ; 1:4       -2 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       -2 +xloop LOOP_STACK   lo(real_stop)
__{}    or    B             ; 1:4       -2 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK},
eval(_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE),{1},{
__{}                        ;[17:61/62] -2 +xloop LOOP_STACK   variant -2.defaultA: positive step -2, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(INDEX_STACK & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--},
__{}__{}{dnl
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--})
__{}    ld    A, B          ; 1:4       -2 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       -2 +xloop LOOP_STACK   hi(real_stop) first (_TEMP_HI_FALSE_POSITIVE<=_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}    ld    A, C          ; 1:4       -2 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       -2 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
{
__{}                        ;[17:61/62] -2 +xloop LOOP_STACK   variant -2.defaultB: positive step -2, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           -2 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      -2 +xloop LOOP_STACK   INDEX_STACK.. -2 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}ifelse(eval(INDEX_STACK & 1),{1},{dnl
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--},
__{}__{}{dnl
__{}__{}    dec  BC             ; 1:6       -2 +xloop LOOP_STACK   index--
__{}__{}    dec   C             ; 1:4       -2 +xloop LOOP_STACK   index--})
__{}    ld    A, C          ; 1:4       -2 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       -2 +xloop LOOP_STACK   lo(real_stop) first (_TEMP_HI_FALSE_POSITIVE>_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}    ld    A, B          ; 1:4       -2 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       -2 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -2 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first})
xleave{}LOOP_STACK:              ;           -2 +xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           -2 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl # stop index do ... +step +loop
dnl # ( -- )
dnl # xdo(stop,index) ... push_addxloop(+step)
define({POSITIVE_ADDXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_POSITIVE_ADDXLOOP},{positive_addxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_POSITIVE_ADDXLOOP},{dnl
__{}define({__INFO},{positive_addxloop}){}dnl
_LOOP_ANALYSIS($1){}ifelse(_TEMP_X,{1},{
__{}idx{}LOOP_STACK EQU xdo{}LOOP_STACK{}save-2 ;           $1 +xloop LOOP_STACK   variant +X.null: positive step and no repeat},
eval((0 <= INDEX_STACK) && (INDEX_STACK < STOP_STACK) && (STOP_STACK < 256)),{1},{
__{}                        ;[13:48]    $1 +xloop LOOP_STACK   variant +X.A: positive step and 0 <= index < stop < 256, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, 0x00       ; 2:7       $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    nop                 ; 1:4       $1 +xloop LOOP_STACK   Contains a zero value because idx always points to a 16-bit index.
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK   A = index+step
__{}    ld  (idx{}LOOP_STACK), A     ; 3:13      $1 +xloop LOOP_STACK   save new index
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK},
eval((0xC600 <= (INDEX_STACK & 0xFFFF)) && ((INDEX_STACK & 0xFFFF) < (STOP_STACK & 0xFFFF)) && ((STOP_STACK & 0xFFFF) < 0xC700)),{1},{
__{}                        ;[12:44]    $1 +xloop LOOP_STACK   variant +X.B: positive step and 0xC600 <= index < stop < 0xC700, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, 0x00       ; 2:7       $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK   First byte contains a 0xC6 value because idx always points to a 16-bit index.
__{}    ld  (idx{}LOOP_STACK), A     ; 3:13      $1 +xloop LOOP_STACK   save new index
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK},
eval($1 & 0xFF),{0},{
__{}                        ;[14:51]    $1 +xloop LOOP_STACK   variant +X.C: positive step = n*256, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, __HEX_H($1)       ; 2:7       $1 +xloop LOOP_STACK   hi(step)
__{}    ld  (idx{}LOOP_STACK+1),A    ; 3:13      $1 +xloop LOOP_STACK   save index
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK},
eval((STOP_STACK==0) && (($1 & 0xFF00)==0)),{1},{
__{}                        ;[14:55/49] $1 +xloop LOOP_STACK   variant +X.D: positive step 3..255 and stop 0, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK
__{}    inc   B             ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval((_TEMP_HI_FALSE_POSITIVE==0) && (($1 & 0xFF00)==0) && (__HEX_H(_TEMP_REAL_STOP)==0)),{1},{
__{}                        ;[14:55/49] $1 +xloop LOOP_STACK   variant +X.E: positive step 3..255 and hi(real_stop) = exclusivity zero, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK
__{}    inc   B             ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval((_TEMP_HI_FALSE_POSITIVE==0) && (($1 & 0xFF00)==0)),{1},{
__{}                        ;[17:55/60] $1 +xloop LOOP_STACK   variant +X.F: positive step 3..255 and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK
__{}    inc   B             ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval((0==(_TEMP_REAL_STOP & 0xFF00)) && (($1 & 0xFF00) == 0)),{1},{
__{}                        ;[19:67/68] $1 +xloop LOOP_STACK   variant +X.G: positive step 3..255 and real_stop 0..255, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    adc   A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    sub   C             ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval((_TEMP_HI_FALSE_POSITIVE==0) && (__HEX_H(_TEMP_REAL_STOP)==0x00)),{1},{
__{}                        ;[14:70/50] $1 +xloop LOOP_STACK   variant +X.H: positive step 256+ and hi(real_stop) exclusivity zero, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    adc   A, high format({%-6s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval((__HEX_H($1)==0) && (21*_TEMP_HI_FALSE_POSITIVE<=4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)),{1},{
__{}                        ;[21:74/75] $1 +xloop LOOP_STACK   variant +X.{I}: positive step 3..255, hi(real_stop) has fewer duplicate,run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    adc   A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    sub   C             ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   hi(real_stop) first (21*_TEMP_HI_FALSE_POSITIVE<=4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive if he was first},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}                        ;[16:77/57] $1 +xloop LOOP_STACK   variant +X.{J}: positive step 256+ and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    adc   A, high format({%-6s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval((_TEMP_LO_FALSE_POSITIVE==0) && (($1 & 0xFF00) == 0)),{1},{
__{}                        ;[16:78/58] $1 +xloop LOOP_STACK   variant +X.{K} : positive step 3..255 and lo(real_stop) exclusivity, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    adc   A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    sub   C             ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   lo(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval((__HEX_H($1)==0) && (21*_TEMP_HI_FALSE_POSITIVE>4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)),{1},{
__{}                        ;[22:78/79] $1 +xloop LOOP_STACK   variant +X.L: positive step 3..255, lo(real_stop) has fewer duplicate, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. +$1 ..(STOP_STACK), real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    adc   A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    sub   C             ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   lo(real_stop) first (21*_TEMP_HI_FALSE_POSITIVE>4*_TEMP_X+21*_TEMP_LO_FALSE_POSITIVE)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x false positive
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x false positive if he was first},
{
   .error +xloop: This variant should never happen... index: INDEX_STACK, stop:STOP_STACK, step: $1})
__{}xleave{}LOOP_STACK:              ;           $1 +xloop LOOP_STACK
__{}xexit{}LOOP_STACK:               ;           $1 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})}){}dnl
dnl
dnl
dnl
dnl # stop index do ... -step +loop
dnl # ( -- )
dnl # xdo(stop,index) ... push_addxloop(-step)
define({NEGATIVE_ADDXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_NEGATIVE_ADDXLOOP},{negative_addxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NEGATIVE_ADDXLOOP},{dnl
__{}define({__INFO},{negative_addxloop}){}dnl
_LOOP_ANALYSIS($1){}ifelse(_TEMP_X,{1},{
__{}idx{}LOOP_STACK EQU xdo{}LOOP_STACK{}save-2 ;           $1 +xloop LOOP_STACK   variant -X.null: positive step and no repeat},
eval(($1==-3) && (STOP_STACK==0)),{1},{
__{}                        ;[11:66/46] $1 +xloop LOOP_STACK   variant -X.A: step -3 and stop 0, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. $1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK   hi old index
__{}    dec  BC             ; 1:6       $1 +xloop LOOP_STACK   index--
__{}    dec  BC             ; 1:6       $1 +xloop LOOP_STACK   index--
__{}    dec  BC             ; 1:6       $1 +xloop LOOP_STACK   index--
__{}    sub   B             ; 1:4       $1 +xloop LOOP_STACK   old-new = carry if index: positive -> negative
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   carry if postivie index -> negative index},
eval(STOP_STACK==0),{1},{
__{}                        ;[14:70/50] $1 +xloop LOOP_STACK   variant -X.B: negative step and stop 0, run _TEMP_X{}x
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. $1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    sub  low format({%-11s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   carry if postivie index -> negative index},
_TEMP_HI_FALSE_POSITIVE,{0},{
__{}ifelse(eval((-1*($1)) & 0xFF00),{0},{
__{}__{}                        ;[17:55/60] $1 +xloop LOOP_STACK   variant +X.C: negative step 3..255 and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. $1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sub  low format({%-11s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK
__{}__{}    dec   B             ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK},
__{}{
__{}__{}                        ;[16:77/57] $1 +xloop LOOP_STACK   variant +X.D: negative step 256+ and hi(real_stop) exclusivity, run _TEMP_X{}x
__{}__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. $1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sub  low format({%-11s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sbc   A, high format({%-6s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK})
__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   hi(real_stop)
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval(_TEMP_REAL_STOP & 0xFF00),{0},{
__{}__{}                        ;[20:70/71] $1 +xloop LOOP_STACK   variant -X.E: negative step and real_stop 0..255, run _TEMP_X{}x
__{}__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. $1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sub  low format({%-11s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sbc   A, high format({%-6s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK   A = last_index
__{}__{}    xor  format({%-15s},low _TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
{
__{}__{}                        ;[23:81/82] $1 +xloop LOOP_STACK   variant -X.default: negative step, run _TEMP_X{}x
__{}__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   INDEX_STACK.. $1 ..STOP_STACK, real_stop:__HEX_HL(_TEMP_REAL_STOP)
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sub  low format({%-11s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sbc   A, high format({%-6s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    xor  __HEX_L(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   lo(real_stop)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   _TEMP_LO_FALSE_POSITIVE{}x
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    xor  __HEX_H(_TEMP_REAL_STOP)           ; 2:7       $1 +xloop LOOP_STACK   hi(real_stop)
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   _TEMP_HI_FALSE_POSITIVE{}x})
__{}xleave{}LOOP_STACK:              ;           $1 +xloop LOOP_STACK
__{}xexit{}LOOP_STACK:               ;           $1 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl # stop index do ... step +loop
dnl # ( -- )
dnl # xdo(stop,index) ... push_addxloop(step)
define({X_ADDXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_X_ADDXLOOP},{x_addxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_X_ADDXLOOP},{dnl
__{}define({__INFO},{x_addxloop}){}dnl
dnl
__{}                        ;[24:119]   $1 +xloop LOOP_STACK   variant: INDEX_STACK.. $1 ..STOP_STACK
__{}    push HL             ; 1:11      $1 +xloop LOOP_STACK
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}    ld   HL, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}    ld   BC, format({%-11s},$1); 3:10      $1 +xloop LOOP_STACK   BC = step
__{}    add  HL, BC         ; 1:11      $1 +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      $1 +xloop LOOP_STACK   save new index
__{}ifelse(__IS_NUM(STOP_STACK),{0},{dnl
__{}__{}    ld    A, low format({%-7s},STOP_STACK-1); 2:7       $1 +xloop LOOP_STACK
__{}__{}    sub   L             ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    L, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, high format({%-6s},(STOP_STACK-1)); 2:7       $1 +xloop LOOP_STACK},
__{}{dnl
__{}__{}    ld    A, low format({%-7s},eval(STOP_STACK-1)); 2:7       $1 +xloop LOOP_STACK
__{}__{}    sub   L             ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    L, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, high format({%-6s},eval(STOP_STACK-1)); 2:7       $1 +xloop LOOP_STACK})
__{}    sbc   A, H          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    H, A          ; 1:4       $1 +xloop LOOP_STACK   HL = (stop-1)-(index+step)
__{}    add  HL, BC         ; 1:11      $1 +xloop LOOP_STACK   HL = (stop-1)-index
__{}    pop  HL             ; 1:10      $1 +xloop LOOP_STACK
__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}    jp   nc, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK   positive step
__{}  else
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK   negative step
__{}  endif
__{}xleave{}LOOP_STACK:              ;           $1 +xloop LOOP_STACK
__{}xexit{}LOOP_STACK:               ;           $1 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl # step +loop
dnl # ( -- )
define({PUSH_ADDXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ADDXLOOP},{push_addxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ADDXLOOP},{dnl
__{}define({__INFO},{push_addxloop}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!
__{}},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!
__{}})dnl
__{}ifelse(__IS_NUM($1),{0},{__ASM_TOKEN_X_ADDXLOOP($1)},{dnl
__{}__{}ifelse(eval($1),{1},{
__{}__{}__{}                        ;           push_addxloop($1) --> xloop LOOP_STACK{}dnl
__{}__{}__{}__ASM_TOKEN_XLOOP{}},
__{}__{}eval($1),{-1},{dnl
__{}__{}__{}__ASM_TOKEN_SUB1_ADDXLOOP{}},
__{}__{}eval($1),{2},{dnl
__{}__{}__{}__ASM_TOKEN_ADD2_ADDXLOOP{}},
__{}__{}eval(((($1) & 0xFFFF)+2) & 0xFFFF),{0},{dnl
__{}__{}__{}__ASM_TOKEN_SUB2_ADDXLOOP{}},
__{}__{}eval($1>0),{1},{dnl
__{}__{}__{}__ASM_TOKEN_POSITIVE_ADDXLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_NEGATIVE_ADDXLOOP($1)}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({ADDXLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_ADDXLOOP},{addxloop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ADDXLOOP},{dnl
__{}define({__INFO},{addxloop}){}dnl
ifelse({fast},{slow},{
__{}    ld    B, H          ; 1:4       +xloop LOOP_STACK
__{}    ld    C, L          ; 1:4       +xloop LOOP_STACK   BC = step
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   HL, 0x0000     ; 3:10      +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK   save index
__{}ifelse(__IS_NUM(STOP_STACK),{0},{dnl
__{}__{}    ld    A, format({%-11s},STOP_STACK-1); 2:7       +xloop LOOP_STACK
__{}__{}    sub   L             ; 1:4       +xloop LOOP_STACK
__{}__{}    ld    L, A          ; 1:4       +xloop LOOP_STACK
__{}__{}    ld    A,high format({%-7s},STOP_STACK-1); 2:7       +xloop LOOP_STACK},
__{}{dnl
__{}__{}    ld    A, __HEX_L(STOP_STACK-1)       ; 2:7       +xloop LOOP_STACK
__{}__{}    sub   L             ; 1:4       +xloop LOOP_STACK
__{}__{}    ld    L, A          ; 1:4       +xloop LOOP_STACK
__{}__{}    ld    A, __HEX_H(STOP_STACK-1)       ; 2:7       +xloop LOOP_STACK})
__{}    sbc   A, H          ; 1:4       +xloop LOOP_STACK
__{}    ld    H, A          ; 1:4       +xloop LOOP_STACK   HL = stop-(index+step)
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = stop-index
__{}    xor   H             ; 1:4       +xloop LOOP_STACK
__{}    ex   DE, HL         ; 1:4       +xloop LOOP_STACK
__{}    pop  DE             ; 1:10      +xloop LOOP_STACK
__{}    jp    p, xdo{}LOOP_STACK     ; 3:10      +xloop LOOP_STACK
                        ;24:114},
__{}{fast},{small},{
__{}    push DE             ; 1:11      +xloop LOOP_STACK
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   DE, 0x0000     ; 3:10      +xloop LOOP_STACK   DE = index
__{}    add  HL, DE         ; 1:11      +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK   save index
__{}    ld   BC, format({%-11s},-1*(STOP_STACK)); 3:10      +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = index+step-stop
__{}    ld    A, H          ; 1:4       +xloop LOOP_STACK
__{}    ex   DE, HL         ; 1:4       +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = index-stop
__{}    xor   H             ; 1:4       +xloop LOOP_STACK
__{}    pop  HL             ; 1:10      +xloop LOOP_STACK
__{}    pop  DE             ; 1:10      +xloop LOOP_STACK
__{}    jp    p, xdo{}LOOP_STACK     ; 3:10      +xloop LOOP_STACK
                        ;21:122},
__{}{
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      +xloop LOOP_STACK   BC = index
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK   save index
__{}    ld    A, L          ; 1:4       +xloop LOOP_STACK
__{}    sub   low format({%-10s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    A, H          ; 1:4       +xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    H, A          ; 1:4       +xloop LOOP_STACK   H = hi index+step-stop
__{}    ld    A, C          ; 1:4       +xloop LOOP_STACK
__{}    sub   low format({%-10s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       +xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       +xloop LOOP_STACK   A = hi index-stop
__{}    xor   H             ; 1:4       +xloop LOOP_STACK
__{}    ex   DE, HL         ; 1:4       +xloop LOOP_STACK
__{}    pop  DE             ; 1:10      +xloop LOOP_STACK
__{}    jp    p, xdo{}LOOP_STACK     ; 3:10      +xloop LOOP_STACK
                        ;26:113})
xleave{}LOOP_STACK:              ;           +xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl # ( -- i )
dnl # hodnota indexu vnitrni smycky
define({XI},{dnl
__{}__ADD_TOKEN({__TOKEN_XI},{xi},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XI},{dnl
__{}define({__INFO},{xi}){}dnl

    push DE             ; 1:11      {index}(LOOP_STACK) xi
    ex   DE, HL         ; 1:4       {index}(LOOP_STACK) xi
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      {index}(LOOP_STACK) xi   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # drop i
dnl # ( n -- i )
dnl # Overwrites TOS with loop index "i".
define({DROP_XI},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_XI},{drop_xi},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_XI},{dnl
__{}define({__INFO},{drop_xi}){}dnl

    ld   HL, (idx{}LOOP_STACK)   ; 3:16      drop {index}(LOOP_STACK) drop_xi   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # ( -- n i )
dnl # vlozeni hodnoty a indexu vnitrni smycky
define({PUSH_XI},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_XI},{push_xi},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_XI},{dnl
__{}define({__INFO},{push_xi}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 {index}(LOOP_STACK) push_xi($1)
    push HL             ; 1:11      $1 {index}(LOOP_STACK) push_xi($1)
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 {index}(LOOP_STACK) push_xi($1)
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      $1 {index}(LOOP_STACK) push_xi($1)   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # n i !
dnl # ( -- )
dnl # vlozeni hodnoty a indexu vnitrni smycky a zavolani store
define({PUSH_XI_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_XI_STORE},{push_xi_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_XI_STORE},{dnl
__{}define({__INFO},{push_xi_store}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[13:66]    $1 {index}(LOOP_STACK) ! push_xi_store($1)
__{}__{}    ld   BC, (idx{}LOOP_STACK)   ; 4:20      $1 {index}(LOOP_STACK) ! push_xi_store($1)   idx always points to a 16-bit index
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 {index}(LOOP_STACK) ! push_xi_store($1)
__{}__{}    ld  (BC),A          ; 1:7       $1 {index}(LOOP_STACK) ! push_xi_store($1)
__{}__{}    inc  BC             ; 1:6       $1 {index}(LOOP_STACK) ! push_xi_store($1)
__{}__{}    ld    A, format({%-11s},($1+1)); 3:13      $1 {index}(LOOP_STACK) ! push_xi_store($1)},
__{}__{dnl
__{}__{}                        ;[11:54]    $1 {index}(LOOP_STACK) ! push_xi_store($1)
__{}__{}    ld   BC, (idx{}LOOP_STACK)   ; 4:20      $1 {index}(LOOP_STACK) ! push_xi_store($1)   idx always points to a 16-bit index
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 {index}(LOOP_STACK) ! push_xi_store($1)
__{}__{}    ld  (BC),A          ; 1:7       $1 {index}(LOOP_STACK) ! push_xi_store($1)
__{}__{}    inc  BC             ; 1:6       $1 {index}(LOOP_STACK) ! push_xi_store($1)
__{}__{}    ld    A, high format({%-6s},$1); 2:7       $1 {index}(LOOP_STACK) ! push_xi_store($1)})
__{}    ld  (BC),A          ; 1:7       $1 {index}(LOOP_STACK) ! push_xi_store($1){}dnl
}){}dnl
dnl
dnl
dnl # char i !
dnl # ( -- )
dnl # store 8-bit char at addr i
define({PUSH_XI_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_XI_CSTORE},{push_xi_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_XI_CSTORE},{dnl
__{}define({__INFO},{push_xi_cstore}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[8:40]     $1 {index}(LOOP_STACK) C! push_xi_cstore($1)
__{}__{}    ld   BC, (idx{}LOOP_STACK)   ; 4:20      $1 {index}(LOOP_STACK) C! push_xi_cstore($1)   idx always points to a 16-bit index
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 {index}(LOOP_STACK) C! push_xi_cstore($1)},
__{}__{dnl
__{}__{}                        ;[7:34]     $1 {index}(LOOP_STACK) C! push_xi_cstore($1)
__{}__{}    ld   BC, (idx{}LOOP_STACK)   ; 4:20      $1 {index}(LOOP_STACK) C! push_xi_cstore($1)   idx always points to a 16-bit index
__{}__{}    ld    A, low format({%-7s},$1); 2:7       $1 {index}(LOOP_STACK) C! push_xi_cstore($1)})
__{}    ld  (BC),A          ; 1:7       $1 {index}(LOOP_STACK) C! push_xi_cstore($1){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- j )
dnl # hodnota indexu druhe vnitrni smycky
define({XJ},{dnl
__{}__ADD_TOKEN({__TOKEN_XJ},{xj},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XJ},{dnl
__{}define({__INFO},{xj}){}dnl
pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK})
    push DE             ; 1:11      {index}(LOOP_STACK) xj
    ex   DE, HL         ; 1:4       {index}(LOOP_STACK) xj
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      {index}(LOOP_STACK) xj   idx always points to a 16-bit index{}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK})}){}dnl
dnl
dnl
dnl # drop j
dnl # ( n -- j )
dnl # Overwrites TOS with loop index "j".
define({DROP_XJ},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_XJ},{drop_xj},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_XJ},{dnl
__{}define({__INFO},{drop_xj}){}dnl
pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK})
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      drop {index}(LOOP_STACK) drop_xj   idx always points to a 16-bit index{}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK})}){}dnl
dnl
dnl
dnl
dnl # ( -- k )
dnl # hodnota indexu treti vnitrni smycky
define({XK},{dnl
__{}__ADD_TOKEN({__TOKEN_XK},{xk},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_XK},{dnl
__{}define({__INFO},{xk}){}dnl
pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK}){}pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK})
    push DE             ; 1:11      {index}(LOOP_STACK) xk
    ex   DE, HL         ; 1:4       {index}(LOOP_STACK) xk
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      {index}(LOOP_STACK) xk   idx always points to a 16-bit index{}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK}){}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK})}){}dnl
dnl
dnl
dnl # drop i
dnl # ( n -- i )
dnl # Overwrites TOS with loop index "k".
define({DROP_XK},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_XK},{drop_xk},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_XK},{dnl
__{}define({__INFO},{drop_xk}){}dnl
pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK}){}pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK})
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      drop {index}(LOOP_STACK) drop_xk   idx always points to a 16-bit index{}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK}){}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK})}){}dnl
dnl
dnl
dnl

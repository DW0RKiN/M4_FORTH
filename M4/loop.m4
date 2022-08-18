dnl ## Loop
define({__},{})dnl
define({LOOP_COUNT},100)dnl
dnl
dnl
include(M4PATH{}loop/begin.m4)dnl
include(M4PATH{}loop/do_loop.m4)dnl
include(M4PATH{}loop/for_next.m4)dnl
include(M4PATH{}loop/rdo_rloop.m4)dnl
include(M4PATH{}loop/rfor_rnext.m4)dnl
include(M4PATH{}loop/rxdo_rxloop.m4)dnl
include(M4PATH{}loop/sdo_sloop.m4)dnl
include(M4PATH{}loop/sfor_snext.m4)dnl
include(M4PATH{}loop/xdo_xloop.m4)dnl
dnl
dnl
dnl
dnl # Leaves the loop.
define({LEAVE},{dnl
__{}__ADD_TOKEN({__TOKEN_LEAVE},{leave_}LOOP_STACK,LOOP_STACK,LEAVE_STACK)}){}dnl
dnl
define({__ASM_TOKEN_LEAVE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{
__{}__{}    jp   leave{}$1       ; 3:10      leave_{}$1},
__{}__GET_LOOP_TYPE($1),{S},{
__{}__{}    jp   leave{}$1       ; 3:10      leave_{}$1},
__{}__GET_LOOP_TYPE($1)-__GET_LOOP_END($1),{R-},{
__{}__{}    exx                 ; 1:4       leave_{}$1
__{}__{}    inc  L              ; 1:4       leave_{}$1
__{}__{}    inc  HL             ; 1:6       leave_{}$1
__{}__{}    inc  L              ; 1:4       leave_{}$1
__{}__{}    jp   leave{}$1       ; 3:10      leave_{}$1},
__{}__GET_LOOP_TYPE($1),{R},{
__{}__{}    exx                 ; 1:4       leave_{}$1
__{}__{}    inc  L              ; 1:4       leave_{}$1
__{}__{}    jp   leave{}$1       ; 3:10      leave_{}$1},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl # Discard the loop-control parameters for the current nesting level.
define({UNLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_UNLOOP},{unloop_}LOOP_STACK,LOOP_STACK)}){}dnl
dnl
define({__ASM_TOKEN_UNLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{
__{}__{}                        ;           unloop_{}$1},
__{}__GET_LOOP_TYPE($1)-__GET_LOOP_END($1),{S-},{
__{}__{}    pop  HL             ; 1:10      unloop_{}$1   ( stop_i i -- )
__{}__{}    pop  DE             ; 1:10      unloop_{}$1},
__{}__GET_LOOP_TYPE($1),{S},{
__{}__{}    ex   DE, HL         ; 1:4       unloop_{}$1   ( i -- )
__{}__{}    pop  DE             ; 1:10      unloop_{}$1},
__{}__GET_LOOP_TYPE($1)-__GET_LOOP_END($1),{R-},{
__{}__{}    exx                 ; 1:4       unloop_{}$1   R:( stop_i i -- )
__{}__{}    inc   L             ; 1:4       unloop_{}$1
__{}__{}    inc  HL             ; 1:6       unloop_{}$1
__{}__{}    inc   L             ; 1:4       unloop_{}$1
__{}__{}    inc  HL             ; 1:6       unloop_{}$1
__{}__{}    exx                 ; 1:4       unloop_{}$1},
__{}__GET_LOOP_TYPE($1),{R},{
__{}__{}    exx                 ; 1:4       unloop_{}$1   R:( i -- )
__{}__{}    inc   L             ; 1:4       unloop_{}$1
__{}__{}    inc  HL             ; 1:6       unloop_{}$1
__{}__{}    exx                 ; 1:4       unloop_{}$1},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl
dnl
dnl # ---------  do ... loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- )
define({DO},{dnl
ifelse(eval($#<5),{1},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}__SET_LOOP(LOOP_COUNT,ifelse($1,,{M},$1),$2,$3,$4){}dnl
__{}__ADD_TOKEN({__TOKEN_DO},{do_}LOOP_STACK,LOOP_STACK)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_DO},{dnl
__SHOW_LOOP($1){}dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{dnl
__{}__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_MDO_I8($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_MDO_D8($1)},
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_FOR($1)},
dnl # __{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
dnl # __{}__{}__{}__ASM_TOKEN_PUSH_FOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_XDO($1)})},
__{}__GET_LOOP_TYPE($1),{R},{dnl
__{}__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_RDO($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
__{}__{}__{}__ASM_TOKEN_RFOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_XRDO($1)})},
__{}__GET_LOOP_TYPE($1),{S},{
__{}__{}  .error dodelat!},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl
dnl # ---------  ?do ... loop  -----------
dnl # 5 0 ?do i . loop --> 0 1 2 3 4
dnl # 5 5 ?do i . loop -->
dnl # ( stop index -- ) r:( -- )
define({QUESTIONDO},{dnl
ifelse(eval($#<5),{1},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}__SET_LOOP(LOOP_COUNT,ifelse($1,,{M},$1),$2,$3,$4){}dnl
__{}__ADD_TOKEN({__TOKEN_QDO},{?do_}LOOP_STACK,LOOP_STACK)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_QDO},{dnl
__SHOW_LOOP($1){}dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{dnl
__{}__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_QMDO_I8($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_QMDO_D8($1)},
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_QFOR($1)},
dnl # __{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
dnl # __{}__{}__{}__ASM_TOKEN_PUSH_QFOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_QXDO($1)})},
__{}__GET_LOOP_TYPE($1),{R},{dnl
__{}__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_QRDO($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
__{}__{}__{}__ASM_TOKEN_QRFOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_XRQDO($1)})},
__{}__GET_LOOP_TYPE($1),{S},{
__{}__{}  .error dodelat!},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # 5 2 do i .     loop --> 2 3 4
dnl # 5 2 do i . +1 +loop --> 2 3 4
define({LOOP},{dnl
__{}__SET_LOOP_STEP(LOOP_COUNT,1){}dnl
__{}__ADD_TOKEN({__TOKEN_LOOP},{loop_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LOOP},{dnl
__{}ifelse(__GET_LOOP_TYPE($1):__GET_LOOP_END($1):__GET_LOOP_STEP($1),{M:0:-1},{dnl
__{}__{}__ASM_TOKEN_NEXT($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_END($1):__GET_LOOP_STEP($1),{M::1},{dnl
__{}__{}__ASM_TOKEN_LOOP_I8($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_END($1):__GET_LOOP_STEP($1),{M::},{dnl
__{}__{}__ASM_TOKEN_ADDLOOP($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_END($1),{M:},{dnl
__{}__{}__ASM_TOKEN_PUSH_ADDLOOP($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_STEP($1),{M:1},{dnl
__{}__{}__ASM_TOKEN_XLOOP($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_STEP($1),{M:},{dnl
__{}__{}__ASM_TOKEN_ADDXLOOP($1)},
__{}__GET_LOOP_TYPE($1),{M},{dnl
__{}__{}__ASM_TOKEN_PUSH_ADDXLOOP($1)},

__GET_LOOP_TYPE($1):__GET_LOOP_END($1):__GET_LOOP_STEP($1),{R:0:-1},{dnl
__{}__{}__ASM_TOKEN_RNEXT($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_END($1):__GET_LOOP_STEP($1),{R::},{dnl
__{}__{}__ASM_TOKEN_ADDRLOOP($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_END($1):__GET_LOOP_STEP($1),{R::1},{dnl
__{}__{}__ASM_TOKEN_RLOOP($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_END($1),{R:},{dnl
__{}__{}__ASM_TOKEN_PUSH_ADDRLOOP($1)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl # step +loop
dnl # ( -- )
define({PUSH_ADDLOOP},{dnl
__{}ifelse(eval($#),0,{
__{}__{}  .error {$0}($@) without parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@) To much parameters!},
{dnl
__{}__SET_LOOP_STEP(LOOP_STACK,$1){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ADDLOOP},{$1 +loop_}LOOP_STACK,LOOP_STACK,$1){}dnl
__{}popdef({LOOP_STACK}){}dnl
})}){}dnl
dnl
dnl
define({__ASM_TOKEN_PUSH_ADDLOOP},{dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{dnl
__{}__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_MLOOP_I8($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:2},{dnl
__{}__{}__{}__ASM_TOKEN_2_ADDMLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:-1},{dnl
__{}__{}__{}__ASM_TOKEN_SUB1_ADDMLOOP($1)},
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_NEXT($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:},{dnl
__{}__{}__{}__ASM_TOKEN_ADDMLOOP($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDMLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{1},{dnl
__{}__{}__{}__ASM_TOKEN_XLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{2},{dnl
__{}__{}__{}__ASM_TOKEN_ADD2_ADDXLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{-1},{dnl
__{}__{}__{}__ASM_TOKEN_SUB1_ADDXLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{-2},{dnl
__{}__{}__{}__ASM_TOKEN_SUB2_ADDXLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_ADDXLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDXLOOP($1)})},
__{}__GET_LOOP_TYPE($1),{R},{dnl
__{}__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_RLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:2},{dnl
__{}__{}__{}__ASM_TOKEN_2_ADDRLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:-1},{dnl
__{}__{}__{}__ASM_TOKEN_SUB1_ADDRLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
__{}__{}__{}__ASM_TOKEN_RFOR($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:},{dnl
__{}__{}__{}__ASM_TOKEN_ADDRLOOP($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDRLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{1},{dnl
__{}__{}__{}__ASM_TOKEN_XRLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{2},{dnl
__{}__{}__{}__ASM_TOKEN_2_XRADDLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{-1},{dnl
__{}__{}__{}__ASM_TOKEN_SUB1_XRADDLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_ADDRLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_XRADDLOOP($1)})},
__{}__GET_LOOP_TYPE($1),{S},{
__{}__{}  .error dodelat!},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl
dnl
dnl # +loop
dnl # ( step -- )
define({ADDLOOP},{dnl
ifelse($#,{0},{
__{}__ADD_TOKEN({__TOKEN_ADDLOOP},{+loop_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LOOP_STACK})},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
dnl
dnl
define({__ASM_TOKEN_ADDLOOP},{dnl
__{}ifelse(__GET_LOOP_TYPE($1):__GET_LOOP_END($1),{M:},{dnl
__{}__{}__ASM_TOKEN_ADDMLOOP($1)},
__{}__GET_LOOP_TYPE($1),{M},{dnl
__{}__{}__ASM_TOKEN_ADDXLOOP($1)},
__GET_LOOP_TYPE($1):__GET_LOOP_END($1),{R:},{dnl
__{}__{}__ASM_TOKEN_ADDRLOOP($1)},
__{}__GET_LOOP_TYPE($1),{R},{dnl
__{}__{}__ASM_TOKEN_ADDRLOOP($1)},
__GET_LOOP_TYPE($1):__GET_LOOP_END($1),{S:},{dnl
__{}__{}__ASM_TOKEN_ADDSLOOP($1)},
__{}__GET_LOOP_TYPE($1),{S},{dnl
__{}__{}__ASM_TOKEN_ADDSLOOP($1)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl

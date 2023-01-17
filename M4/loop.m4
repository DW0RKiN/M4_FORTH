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
__{}__{}    jp   leave{}$1       ; 3:10      leave_{}$1(m)},
__{}__GET_LOOP_TYPE($1),{S},{
__{}__{}    jp   leave{}$1       ; 3:10      leave_{}$1(s)},
__{}__GET_LOOP_TYPE($1)-__GET_LOOP_END($1),{R-},{
__{}__{}    exx                 ; 1:4       leave_{}$1(r)
__{}__{}    inc  L              ; 1:4       leave_{}$1(r)
__{}__{}    inc  HL             ; 1:6       leave_{}$1(r)
__{}__{}    inc  L              ; 1:4       leave_{}$1(r)
__{}__{}    jp   leave{}$1       ; 3:10      leave_{}$1(r)},
__{}__GET_LOOP_TYPE($1),{R},{
__{}__{}    exx                 ; 1:4       leave_{}$1(r)
__{}__{}    inc  L              ; 1:4       leave_{}$1(r)
__{}__{}    jp   leave{}$1       ; 3:10      leave_{}$1(r)},
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
__{}__{}                        ;           unloop_{}$1(m)},
__{}__GET_LOOP_TYPE($1)-__SAVE_EVAL(__GET_LOOP_END($1)),{S-0},{
__{}__{}    ex   DE, HL         ; 1:4       unloop_{}$1(s)   ( i -- )
__{}__{}    pop  DE             ; 1:10      unloop_{}$1(s)},
__{}__GET_LOOP_TYPE($1)-__SAVE_EVAL(__GET_LOOP_END($1)),{S-1},{
__{}__{}    ex   DE, HL         ; 1:4       unloop_{}$1(s)   ( i -- )
__{}__{}    pop  DE             ; 1:10      unloop_{}$1(s)},
__{}__GET_LOOP_TYPE($1),{S},{
__{}__{}    pop  HL             ; 1:10      unloop_{}$1(s)   ( stop_i i -- )
__{}__{}    pop  DE             ; 1:10      unloop_{}$1(s)},
__{}__GET_LOOP_TYPE($1)-__GET_LOOP_END($1),{R-},{
__{}__{}    exx                 ; 1:4       unloop_{}$1(r)   R:( stop_i i -- )
__{}__{}    inc   L             ; 1:4       unloop_{}$1(r)
__{}__{}    inc  HL             ; 1:6       unloop_{}$1(r)
__{}__{}    inc   L             ; 1:4       unloop_{}$1(r)
__{}__{}    inc  HL             ; 1:6       unloop_{}$1(r)
__{}__{}    exx                 ; 1:4       unloop_{}$1(r)},
__{}__GET_LOOP_TYPE($1),{R},{
__{}__{}    exx                 ; 1:4       unloop_{}$1(r)   R:( i -- )
__{}__{}    inc   L             ; 1:4       unloop_{}$1(r)
__{}__{}    inc  HL             ; 1:6       unloop_{}$1(r)
__{}__{}    exx                 ; 1:4       unloop_{}$1(r)},
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
dnl #__SHOW_LOOP($1){}dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{dnl # ------- memory (no recursive) allocation -------
__{}__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_MDO_I8($1)},
__{}__{}__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_MDO_I8($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_MDO_D8($1)},
__{}__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_MDO_D8($1)},
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_FOR($1)},
dnl # __{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
dnl # __{}__{}__{}__ASM_TOKEN_PUSH_FOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_XDO($1)})},

__{}__GET_LOOP_TYPE($1),{R},{dnl # ------- return address stack allocation -------
__{}__{}ifelse(__GET_LOOP_STEP($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_RDO($1)},
__{}__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_RDO($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_RDO($1)},
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_RFOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_XRDO($1)})},

__{}__GET_LOOP_TYPE($1),{S},{dnl # ------- data stack allocation -------
dnl #__{}__{}ifelse(dnl
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_SFOR($1)},
dnl #__{}__{}{dnl
dnl #__{}__{}__{}__ASM_TOKEN_SDO($1)}){}dnl
__{}__{}__ASM_TOKEN_SDO($1){}dnl
__{}},
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
dnl #__SHOW_LOOP($1){}dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{dnl # ------- memory (no recursive) allocation -------
__{}__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_QMDO_I8($1)},
__{}__{}__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_QMDO_I8($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_QMDO_D8($1)},
__{}__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_QMDO_D8($1)},
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_QFOR($1)},
dnl # __{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
dnl # __{}__{}__{}__ASM_TOKEN_PUSH_QFOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_QXDO($1)})},
__{}__GET_LOOP_TYPE($1),{R},{dnl # ------- return address stack allocation -------
__{}__{}ifelse(__GET_LOOP_STEP($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_QRDO($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_QRDO($1)},
__{}__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_QRDO($1)},
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_QRFOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_XRQDO($1)})},
__{}__GET_LOOP_TYPE($1),{S},{dnl # ------- data stack allocation -------
__{}__{}ifelse(dnl
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_QUESTIONSFOR($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_QSDO($1)})},
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
__{}ifelse(__GET_LOOP_TYPE($1),{M},{dnl # ------- memory (no recursive) allocation -------
__{}__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
__{}__{}__{}__ASM_TOKEN_NEXT($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_MLOOP_I8($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:},{dnl
__{}__{}__{}__ASM_TOKEN_ADDLOOP($1)},
__{}__{}__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{:},{dnl
__{}__{}__{}__ASM_TOKEN_ADDLOOP($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDMLOOP($1)},
__{}__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDMLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{1},{dnl
__{}__{}__{}__ASM_TOKEN_XLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_ADDXLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDXLOOP($1)})},
__{}__GET_LOOP_TYPE($1),{R},{dnl # ------- return address stack allocation -------
__{}__{}ifelse(dnl
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_RNEXT($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:},{dnl
__{}__{}__{}__ASM_TOKEN_ADDRLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_RLOOP($1)},
__{}__{}__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_RLOOP($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDRLOOP($1)},
__{}__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDRLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_XRADDLOOP($1)})},

__{}__GET_LOOP_TYPE($1),{S},{dnl # ------- data stack allocation -------
__{}__{}ifelse(dnl
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_SNEXT($1)},
__{}__{}__GET_LOOP_STEP($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_ADDSLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDSLOOP($1)})},
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
__{}__{}__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_MLOOP_I8($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:2},{dnl
__{}__{}__{}__ASM_TOKEN_2_ADDMLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:-1},{dnl
__{}__{}__{}__ASM_TOKEN_SUB1_ADDMLOOP($1)},
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{0:-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_NEXT($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:},{dnl
__{}__{}__{}__ASM_TOKEN_ADDMLOOP($1)},
__{}__{}__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{:},{dnl
__{}__{}__{}__ASM_TOKEN_ADDMLOOP($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDMLOOP($1)},
__{}__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDMLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_ADDXLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDXLOOP($1)})},
__{}__GET_LOOP_TYPE($1),{R},{dnl
__{}__{}ifelse(dnl
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_RNEXT($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_RLOOP($1)},
__{}__{}__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{:1},{dnl
__{}__{}__{}__ASM_TOKEN_RLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:2},{dnl
__{}__{}__{}__ASM_TOKEN_2_ADDRLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:-1},{dnl
__{}__{}__{}__ASM_TOKEN_SUB1_ADDRLOOP($1)},
__{}__{}__GET_LOOP_END($1):__GET_LOOP_STEP($1),{:},{dnl
__{}__{}__{}__ASM_TOKEN_ADDRLOOP($1)},
__{}__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDRLOOP($1)},
__{}__{}__GET_LOOP_BEGIN($1),{},{dnl
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
__{}__GET_LOOP_TYPE($1),{S},{dnl
__{}__{}ifelse(dnl
dnl #__{}__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1):__GET_LOOP_STEP($1),{0::-1},{dnl
dnl #__{}__{}__{}__ASM_TOKEN_SNEXT($1)},
__{}__{}__GET_LOOP_STEP($1),{},{dnl
__{}__{}__{}__ASM_TOKEN_ADDSLOOP($1)},
__{}__{}__GET_LOOP_STEP($1),{1},{dnl
__{}__{}__{}__ASM_TOKEN_SLOOP($1)},
__{}__{}{dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ADDSLOOP($1)})},
__{}{
__{}  .error {$0}($@): Unexpected type parameter! __SHOW_LOOP($1)})}){}dnl
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
ifelse(__GET_LOOP_STEP($1),{},{dnl
__{}ifelse(__GET_LOOP_TYPE($1):__GET_LOOP_END($1),{M:},{dnl
__{}__{}__ASM_TOKEN_ADDMLOOP($1)},
__{}__GET_LOOP_TYPE($1):__GET_LOOP_BEGIN($1),{M:},{dnl
__{}__{}__ASM_TOKEN_ADDMLOOP($1)},
__{}__GET_LOOP_TYPE($1),{M},{dnl
__{}__{}__ASM_TOKEN_ADDXLOOP($1)},
__{}__GET_LOOP_TYPE($1),{R},{dnl
__{}__{}__ASM_TOKEN_ADDRLOOP($1)},
__{}__GET_LOOP_TYPE($1),{S},{dnl
__{}__{}__ASM_TOKEN_ADDSLOOP($1)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})},
{__ASM_TOKEN_PUSH_ADDLOOP($1)}){}dnl
}){}dnl
dnl
dnl
dnl # --------------------------------------------------------------------------
dnl
dnl
dnl # ( -- i )
dnl # hodnota indexu aktualni smycky
define({I},{dnl
__{}__ADD_TOKEN({__TOKEN_I},{i_}LOOP_STACK,LOOP_STACK){}dnl
}){}dnl
dnl
dnl # Input:
dnl #    $1 = id i loop:
define({__ASM_TOKEN_I},{dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{__ASM_INDEX2M($1,{i})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_INDEX2R($1,{i},0)},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_INDEX2S($1,{i},0)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
define({__ASM_INDEX2M},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    push DE             ; 1:11      __INFO   ( -- $2 )
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, (idx{}$1)   ; 3:16      __INFO   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_INDEX2R},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(r)})
                        ;           __COMPILE_INFO   ( -- $2 ){}dnl
__{}__ASM_TOKEN_PUSH_RPICK($3)}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_INDEX2S},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)})
                        ;           __COMPILE_INFO   ( -- $2 ){}dnl
__{}__ASM_TOKEN_PUSH_PICK($3)}){}dnl
dnl
dnl
dnl
dnl # drop i
dnl # ( x -- i )
dnl # Overwrites TOS with loop index "i".
define({DROP_I},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_I},{drop i_}LOOP_STACK,LOOP_STACK){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_I},{dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{__ASM_DROP_INDEX2M($1,{i})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_DROP_INDEX2R($1,{i},0)},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_DROP_INDEX2S($1,{i},0)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
define({__ASM_DROP_INDEX2M},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)})
    ld   HL, (idx{}$1)   ; 3:16      __INFO   ( x -- $2 )  idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_DROP_INDEX2R},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(r)}){}dnl
__{}__ASM_TOKEN_DROP_PUSH_RPICK($3)}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_DROP_INDEX2S},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)}){}dnl
__{}__ASM_TOKEN_DROP_PUSH_PICK($3)}){}dnl
dnl
dnl
dnl
dnl # dup i
dnl # ( x -- x x i )
define({DUP_I},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_I},{dup i_}LOOP_STACK,LOOP_STACK){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_I},{dnl
__{}ifelse(__GET_LOOP_TYPE($1),{M},{__ASM_DUP_INDEX2M($1,{i})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_DUP_INDEX2R($1,{i},0)},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_DUP_INDEX2S($1,{i},0)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
define({__ASM_DUP_INDEX2M},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)})
    push DE             ; 1:11      __INFO   ( x -- x x $2 )
    push HL             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, (idx{}$1)   ; 3:16      __INFO   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_DUP_INDEX2R},{dnl
__{}define({__INFO},__COMPILE_INFO{(r)})
__{}__ASM_TOKEN_PUSH_RPICK($3){}dnl
__{}__ASM_TOKEN_OVER_SWAP{}dnl
}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id x loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_DUP_INDEX2S},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)}){}dnl
__{}ifelse(dnl
__{}eval($3),0,{
                                    __COMPILE_INFO   ( $2 -- $2 $2 $2 ){}__ASM_TOKEN_DUP_DUP},
__{}eval($3),1,{
                                    __COMPILE_INFO   ( $2 i -- $2 i i $2 ){}__ASM_TOKEN_2DUP{}__ASM_TOKEN_SWAP},
__{}{__ASM_TOKEN_PUSH_PICK($3){}__ASM_TOKEN_OVER_SWAP}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- i x )
dnl # vlozeni indexu vnitrni smycky a hodnoty
define({I_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_I_PUSH},{i_}LOOP_STACK{ $1},LOOP_STACK,$1){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_I_PUSH},{dnl
__{}ifelse(dnl
__{}__GET_LOOP_TYPE($1),{M},{__ASM_INDEX2M_PUSH($1,{i},  $2)},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_INDEX2R_PUSH($1,{i},0,$2)},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_INDEX2S_PUSH($1,{i},0,$2)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 number
define({__ASM_INDEX2M_PUSH},{dnl
__{}ifelse(eval($#<3),{1},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{define({__INFO},__COMPILE_INFO{(m)})
    push DE             ; 1:11      __INFO   ( -- $2 $3 )
    push HL             ; 1:11      __INFO
    ld   DE, (idx{}$1)   ; 4:20      __INFO   idx always points to a 16-bit index
    ld   HL, format({%-11s},$3); ifelse(__IS_MEM_REF($3),{1},{3:16},{3:10})      __INFO})}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
dnl #   $4 push number
define({__ASM_INDEX2R_PUSH},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(r)})
                        ;           __COMPILE_INFO   ( -- $2 $4 ){}dnl
__{}__ASM_TOKEN_PUSH_RPICK_PUSH($3,$4)}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
dnl #   $4 push number
define({__ASM_INDEX2S_PUSH},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)})
                        ;           __COMPILE_INFO   ( -- $2 $4 ){}dnl
__{}ifelse(dnl
__{}__{}eval($3),0,{__ASM_TOKEN_DUP_PUSH($4)},
__{}__{}eval($3),1,{__ASM_TOKEN_OVER_PUSH($4)},
__{}__{}eval($3),2,{__ASM_TOKEN_2_PICK_PUSH($4)},
__{}__{}eval($3),3,{__ASM_TOKEN_3_PICK_PUSH($4)},
__{}__{}{__ASM_TOKEN_PUSH_PICK_PUSH($3,$4)}){}dnl
}){}dnl
dnl
dnl
dnl # ( -- x i )
dnl # vlozeni hodnoty a indexu vnitrni smycky
define({PUSH_I},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_I},{$1 i_}LOOP_STACK,$1,LOOP_STACK){}dnl
}){}dnl
define({__ASM_TOKEN_PUSH_I},{dnl
__{}ifelse(__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M($1,$2,{i})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R($1,$2,{i},0)},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S($1,$2,{i},0)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 push(x)
dnl #   $2 id loop
dnl #   $3 i,j,k
define({__ASM_PUSH_INDEX2M},{dnl
__{}ifelse(eval($#<3),{1},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( -- $1 $3 )
    push HL             ; 1:11      __INFO
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      __INFO
    ld   HL, (idx{}$2)   ; 3:16      __INFO   idx always points to a 16-bit index})}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 number
dnl #   $2 id loop
dnl #   $3 i,j,k
dnl #   $4 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_PUSH_INDEX2R},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(r)}){}dnl
__{}__ASM_TOKEN_PUSH2_RPICK($1,$4)}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 number
dnl #   $2 id loop
dnl #   $3 i,j,k
dnl #   $4 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_PUSH_INDEX2S},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)}){}dnl
__{}__ASM_TOKEN_PUSH_PICK_PUSH_SWAP($4,$1)}){}dnl
dnl
dnl
dnl # x i !
dnl # ( -- )
dnl # vlozeni hodnoty a indexu vnitrni smycky a zavolani store
define({PUSH_I_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_I_STORE},{$1 i_}LOOP_STACK{ !},$1,LOOP_STACK){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_I_STORE},{dnl
__{}ifelse(__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M_STORE($1,$2,{i})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R_STORE($1,$2,{i},0)},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S_STORE($1,$2,{i},0)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 push(x)
dnl #   $2 id loop
dnl #   $3 i,j,k
define({__ASM_PUSH_INDEX2M_STORE},{dnl
__{}ifelse(eval($#<3),{1},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),{1},{define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[13:66]    __INFO   ( -- $1 $3 == $1 addr -- )
__{}__{}    ld    A, format({%-11s},$1); 3:13      __INFO
__{}__{}    ld   BC, (idx{}$2)   ; 4:20      __INFO   idx always points to a 16-bit index
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    ld    A, format({%-11s},($1+1)); 3:13      __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}__IS_NUM($1),{0},{define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[11:54]    __INFO   ( -- $1 $3 == $1 addr -- )
__{}__{}    ld    A, low format({%-7s},$1); 2:7       __INFO
__{}__{}    ld   BC, (idx{}$2)   ; 4:20      __INFO   idx always points to a 16-bit index
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    ld    A, high format({%-6s},$1); 2:7       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{define({__INFO},__COMPILE_INFO)
__{}__{}define({__CODE1},__LD_R_NUM(__INFO{   lo($1) = __HEX_L($1)},{A},__HEX_L($1))){}dnl
__{}__{}define({__TMP_C},eval(40+__CLOCKS)){}dnl
__{}__{}define({__TMP_B},eval(7+__BYTES)){}dnl
__{}__{}define({__CODE2},__LD_R_NUM(__INFO{   hi($1) = __HEX_H($1)},{A},__HEX_H($1),{A},__HEX_L($1))){}dnl
__{}__{}define({__TMP_C},eval(__TMP_C+__CLOCKS)){}dnl
__{}__{}define({__TMP_B},eval(__TMP_B+__BYTES)){}dnl
__{}__{}                        ;format({%-10s},[__TMP_B:__TMP_C]) __INFO   ( -- )  val=$1, addr=$3{}dnl
__{}__{}__CODE1
__{}__{}    ld   BC, (idx{}$2)   ; 4:20      __INFO   idx always points to a 16-bit index
__{}__{}    ld  (BC),A          ; 1:7       __INFO{}dnl
__{}__{}__CODE2
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 number
dnl #   $2 id loop
dnl #   $3 i,j,k
dnl #   $4 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_PUSH_INDEX2R_STORE},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(r)}){}dnl
__{}__ASM_TOKEN_PUSH2_RPICK_STORE($1,$4)}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 number
dnl #   $2 id loop
dnl #   $3 i,j,k
dnl #   $4 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_PUSH_INDEX2S_STORE},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)}){}dnl
__{}__ASM_TOKEN_PUSH_PICK_PUSH_SWAP_STORE($4,$1)}){}dnl
dnl
dnl
dnl
dnl # char i c!
dnl # ( -- )
dnl # store 8-bit char at addr i
define({PUSH_I_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_I_CSTORE},{$1 i_}LOOP_STACK{ c!},$1,LOOP_STACK){}dnl
}){}dnl
define({__ASM_TOKEN_PUSH_I_CSTORE},{dnl
__{}ifelse(__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M_CSTORE($1,$2,{i})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R_CSTORE($1,$2,{i},0)},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S_CSTORE($1,$2,{i},0)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 push(char)
dnl #   $2 id loop
dnl #   $3 i,j,k
define({__ASM_PUSH_INDEX2M_CSTORE},{dnl
__{}ifelse(eval($#<3),{1},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),{1},{define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[8:40]     __INFO   ( -- $1 $3 == $1 addr -- )
__{}__{}    ld   BC, (idx{}$2)   ; 4:20      __INFO   idx always points to a 16-bit index
__{}__{}    ld    A, format({%-11s},$1); 3:13      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}__IS_NUM($1),{1},{define({__INFO},__COMPILE_INFO)
__{}__{}define({__CODE1},__LD_R_NUM(__INFO{   lo($1) = __HEX_L($1)},{A},__HEX_L($1))){}dnl
__{}__{}                        ;format({%-10s},[eval(5+__BYTES):eval(27+__CLOCKS)]) __INFO   ( -- )  val=$1, addr=$3{}dnl
__{}__{}__CODE1
__{}__{}    ld   BC, (idx{}$2)   ; 4:20      __INFO   idx always points to a 16-bit index
__{}__{}    ld  (BC),A          ; 1:7       __INFO},

__{}__{define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[7:34]     __INFO   ( -- $1 $3 == $1 addr -- )
__{}__{}    ld   BC, (idx{}$2)   ; 4:20      __INFO   idx always points to a 16-bit index
__{}__{}    ld    A, low format({%-7s},$1); 2:7       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 number
dnl #   $2 id loop
dnl #   $3 i,j,k
dnl #   $4 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_PUSH_INDEX2R_CSTORE},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(r)}){}dnl
__{}__ASM_TOKEN_PUSH2_RPICK_CSTORE($1,$4)}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 number
dnl #   $2 id loop
dnl #   $3 i,j,k
dnl #   $4 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
define({__ASM_PUSH_INDEX2S_CSTORE},{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)}){}dnl
__{}__ASM_TOKEN_PUSH_PICK_PUSH_SWAP_CSTORE($4,$1)}){}dnl
dnl
dnl
dnl # -----------------------------------------------------------------------
dnl
dnl
dnl
define({__COUNT_DEEP_R_INDEX},{dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}($@)!},
__{}eval($#>3),1,{
__{}  .error {$0}($@)!},
__{}{dnl
__{}__{}define({__TMP},0){}dnl
__{}__{}define({__TMP},eval(__TMP+ifelse(__GET_LOOP_TYPE($1),{R},ifelse(__GET_LOOP_END($1),{},2,1),0))){}dnl
__{}__{}define({__TMP},eval(__TMP+ifelse(__GET_LOOP_TYPE($2),{R},ifelse(__GET_LOOP_END($2),{},2,1),0))){}dnl
__{}__{}define({__TMP},eval(__TMP+ifelse(__GET_LOOP_TYPE($3),{R},ifelse(__GET_LOOP_END($3),{},2,1),0))){}dnl
__{}__{}__TMP}){}dnl
}){}dnl
dnl
dnl
define({__COUNT_DEEP_S_INDEX},{dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}($@)!},
__{}eval($#>3),1,{
__{}  .error {$0}($@)!},
__{}{dnl
__{}__{}define({__TMP},0){}dnl
__{}__{}define({__TMP},eval(__TMP+ifelse(__GET_LOOP_TYPE($1),{S},ifelse(__HEX_HL(__GET_LOOP_END($1)),0x0000,1,__HEX_HL(__GET_LOOP_END($1)),0x0001,1,2),0))){}dnl
__{}__{}define({__TMP},eval(__TMP+ifelse(__GET_LOOP_TYPE($2),{S},ifelse(__HEX_HL(__GET_LOOP_END($2)),0x0000,1,__HEX_HL(__GET_LOOP_END($2)),0x0001,1,2),0))){}dnl
__{}__{}define({__TMP},eval(__TMP+ifelse(__GET_LOOP_TYPE($3),{S},ifelse(__HEX_HL(__GET_LOOP_END($3)),0x0000,1,__HEX_HL(__GET_LOOP_END($3)),0x0001,1,2),0))){}dnl
__{}__{}__TMP}){}dnl
}){}dnl
dnl
dnl
define({__SHOW_INDEX},{__ASM({
r: __TMP_R
s: __TMP_S})}){}dnl
dnl
dnl
dnl # ---------------------------------- vvvv j vvvv -------------------------------------
dnl
dnl
dnl # ( -- j )
dnl # hodnota indexu vnejsi smycky
define({J},{dnl
__{}ifelse($#,{0},{dnl
__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_J},{j_}__ID_0,__ID_0,__ID_1)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
dnl # Input:
dnl #    $1 = id j loop:
dnl #    $2 = id i loop:
define({__ASM_TOKEN_J},{dnl
__{}ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($1),{M},{__ASM_INDEX2M($1,{j})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_INDEX2R($1,{j},__COUNT_DEEP_R_INDEX($2))},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_INDEX2S($1,{j},__COUNT_DEEP_S_INDEX($2))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( x -- j )
dnl # Overwrites TOS with loop index "j".
define({DROP_J},{dnl
__{}ifelse($#,{0},{dnl
__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_DROP_J},{drop j_}__ID_0,__ID_0,__ID_1)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_DROP_J},{dnl
__{}ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($1),{M},{__ASM_DROP_INDEX2M($1,{j})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_DROP_INDEX2R($1,{j},__COUNT_DEEP_R_INDEX($2))},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_DROP_INDEX2S($1,{j},__COUNT_DEEP_S_INDEX($2))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup j
dnl # ( x -- x x j )
define({DUP_J},{dnl
__{}ifelse($#,{0},{dnl
__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_DUP_J},{drop j_}__ID_0,__ID_0,__ID_1)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_DUP_J},{dnl
__{}ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($1),{M},{__ASM_DUP_INDEX2M($1,{j})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_DUP_INDEX2R($1,{j},__COUNT_DEEP_R_INDEX($2))},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_DUP_INDEX2S($1,{j},__COUNT_DEEP_S_INDEX($2))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- j x )
dnl # vlozeni indexu vnejsi smycky a hodnoty
define({J_PUSH},{dnl
__{}ifelse(eval($#<1),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_J_PUSH},{j_}__ID_0{ $3},__ID_0,__ID_1,$1)}){}dnl
}){}dnl
dnl
dnl # Input:
dnl #   $1 - id j loop
dnl #   $2 - id i loop
dnl #   $3 - push number
define({__ASM_TOKEN_J_PUSH},{dnl
dnl # __ASM_INDEX2R_PUSH
dnl # __ASM_INDEX2S_PUSH
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
dnl #   $4 push number
__{}ifelse(eval($#<3),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($1),{M},{__ASM_INDEX2M_PUSH($1,{j},$3)},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_INDEX2R_PUSH($1,{j},__COUNT_DEEP_R_INDEX($2),$3)},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_INDEX2S_PUSH($1,{j},__COUNT_DEEP_S_INDEX($2),$3)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- x j )
dnl # vlozeni hodnoty a indexu vnejsi smycky
define({PUSH_J},{dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_PUSH_J},{$1 j_}__ID_0,$1,__ID_0,__ID_1)}){}dnl
}){}dnl
dnl
dnl # Input:
dnl #   $1 - push number
dnl #   $2 - id j loop
dnl #   $3 - id i loop
define({__ASM_TOKEN_PUSH_J},{dnl
dnl # __ASM_PUSH_INDEX2R
dnl # __ASM_PUSH_INDEX2S
dnl # Input:
dnl #   $1 number
dnl #   $2 id loop
dnl #   $3 i,j,k
dnl #   $4 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
__{}ifelse(eval($#<3),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M($1,$2,{j})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R($1,$2,{j},__COUNT_DEEP_R_INDEX($3))},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S($1,$2,{j},__COUNT_DEEP_S_INDEX($3))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # x j !
dnl # ( -- )
dnl # vlozeni hodnoty a indexu vnitrni smycky a zavolani store
define({PUSH_J_STORE},{dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_PUSH_J_STORE},{$1 j_}__ID_0{ !},$1,__ID_0,__ID_1)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_J_STORE},{dnl
__{}ifelse(eval($#<3),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M_STORE($1,$2,{j})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R_STORE($1,$2,{j},__COUNT_DEEP_R_INDEX($3))},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S_STORE($1,$2,{j},__COUNT_DEEP_S_INDEX($3))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl
dnl # char j !
dnl # ( -- )
dnl # store 8-bit char at addr i
define({PUSH_J_CSTORE},{dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_PUSH_J_CSTORE},{$1 j_}__ID_0{ !},$1,__ID_0,__ID_1)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_J_CSTORE},{dnl
__{}ifelse(eval($#<3),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M_CSTORE($1,$2,{j})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R_CSTORE($1,$2,{j},__COUNT_DEEP_R_INDEX($3))},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S_CSTORE($1,$2,{j},__COUNT_DEEP_S_INDEX($3))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # -----------------------------------------------------------------------
dnl
dnl
dnl # ( -- k )
dnl # hodnota indexu druhe vnejsi smycky
define({K},{dnl
__{}__{}define({__ID_2},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_2){}dnl
__{}__ADD_TOKEN({__TOKEN_K},{k_}__ID_0,__ID_0,__ID_1,__ID_2){}dnl
}){}dnl
dnl
dnl # Input:
dnl #    $1 = id k loop:
dnl #    $2 = id j loop:
dnl #    $3 = id i loop:
define({__ASM_TOKEN_K},{dnl
__{}ifelse(eval($#<3),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($1),{M},{__ASM_INDEX2M($1,{k})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_INDEX2R($1,{k},__COUNT_DEEP_R_INDEX($2,$3))},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_INDEX2S($1,{k},__COUNT_DEEP_S_INDEX($2,$3))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl # ( x -- k )
dnl # hodnota indexu druhe vnejsi smycky
define({DROP_K},{dnl
__{}__{}define({__ID_2},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_2){}dnl
__{}__ADD_TOKEN({__TOKEN_DROP_K},{drop k_}__ID_0,__ID_0,__ID_1,__ID_2){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_K},{dnl
__{}ifelse(eval($#<3),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($1),{M},{__ASM_DROP_INDEX2M($1,{k})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_DROP_INDEX2R($1,{k},__COUNT_DEEP_R_INDEX($2,$3))},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_DROP_INDEX2S($1,{k},__COUNT_DEEP_S_INDEX($2,$3))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup k
dnl # ( x -- x x k )
define({DUP_K},{dnl
__{}ifelse($#,{0},{dnl
__{}__{}define({__ID_2},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_2){}dnl
__{}__ADD_TOKEN({__TOKEN_DUP_K},{dup k_}__ID_0,__ID_0,__ID_1,__ID_2)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_K},{dnl
__{}ifelse(eval($#<3),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($1),{M},{__ASM_DUP_INDEX2M($1,{k})},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_DUP_INDEX2R($1,{k},__COUNT_DEEP_R_INDEX($2,$3))},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_DUP_INDEX2S($1,{k},__COUNT_DEEP_S_INDEX($2,$3))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- k x )
dnl # vlozeni indexu druhe vnejsi smycky a hodnoty
define({K_PUSH},{dnl
__{}__{}define({__ID_2},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_2){}dnl
__{}__ADD_TOKEN({__TOKEN_K_PUSH},{k_}__ID_0{ $1},__ID_0,__ID_1,__ID_2,$1){}dnl
}){}dnl
dnl
dnl # Input:
dnl #   $1 - id k loop
dnl #   $2 - id j loop
dnl #   $3 - id i loop
dnl #   $4 - push number
define({__ASM_TOKEN_K_PUSH},{dnl
dnl # __ASM_INDEX2R_PUSH
dnl # __ASM_INDEX2S_PUSH
dnl # Input:
dnl #   $1 id $2 loop
dnl #   $2 i,j,k
dnl #   $3 0 = i
dnl #      1,2 = j
dnl #      2,3,4 = k
dnl #   $4 push number
__{}ifelse(eval($#<4),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>4),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($1),{M},{__ASM_INDEX2M_PUSH($1,{k},$4)},
__{}__GET_LOOP_TYPE($1),{R},{__ASM_INDEX2R_PUSH($1,{k},__COUNT_DEEP_R_INDEX($2,$3),$4)},
__{}__GET_LOOP_TYPE($1),{S},{__ASM_INDEX2S_PUSH($1,{k},__COUNT_DEEP_S_INDEX($2,$3),$4)},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl # ( -- x k )
dnl # vlozeni hodnoty a indexu druhe vnejsi smycky
define({PUSH_K},{dnl
__{}__{}define({__ID_2},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_2){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_K},{$1 k_}__ID_0,$1,__ID_0,__ID_1,__ID_2){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_K},{dnl
__{}ifelse(eval($#<4),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>4),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M($1,$2,{k})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R($1,$2,{k},__COUNT_DEEP_R_INDEX($3,$4))},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S($1,$2,{k},__COUNT_DEEP_S_INDEX($3,$4))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # x j !
dnl # ( -- )
dnl # vlozeni hodnoty a indexu vnitrni smycky a zavolani store
define({PUSH_K_STORE},{dnl
__{}__{}define({__ID_2},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_2){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_K_STORE},{$1 k_}__ID_0{ !},$1,__ID_0,__ID_1,__ID_2){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_K_STORE},{dnl
__{}ifelse(eval($#<4),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>4),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M_STORE($1,$2,{k})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R_STORE($1,$2,{k},__COUNT_DEEP_R_INDEX($3,$4))},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S_STORE($1,$2,{k},__COUNT_DEEP_S_INDEX($3,$4))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl
dnl
dnl # char j !
dnl # ( -- )
dnl # store 8-bit char at addr i
define({PUSH_K_CSTORE},{dnl
__{}__{}define({__ID_2},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}define({__ID_1},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__{}define({__ID_0},LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__ID_1){}dnl
__{}__{}pushdef({LOOP_STACK},__ID_2){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_K_STORE},{$1 k_}__ID_0{ c!},$1,__ID_0,__ID_1,__ID_2){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_K_CSTORE},{dnl
__{}ifelse(eval($#<4),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>4),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__GET_LOOP_TYPE($2),{M},{__ASM_PUSH_INDEX2M_CSTORE($1,$2,{k})},
__{}__GET_LOOP_TYPE($2),{R},{__ASM_PUSH_INDEX2R_CSTORE($1,$2,{k},__COUNT_DEEP_R_INDEX($3,$4))},
__{}__GET_LOOP_TYPE($2),{S},{__ASM_PUSH_INDEX2S_CSTORE($1,$2,{k},__COUNT_DEEP_S_INDEX($3,$4))},
__{}{
__{}  .error {$0}($@): Unexpected type parameter!})}){}dnl
dnl
dnl
dnl

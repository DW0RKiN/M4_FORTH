dnl ## non-recursive do loop
dnl
dnl
dnl # ============================================
dnl
dnl
dnl # ---------  do ... 1 +loop  ----------- step only +1
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) ( R: -- )
define({__ASM_TOKEN_MDO_I8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}define({$0_TMP},ifelse(__HEX_HL(__GET_LOOP_STEP($1)),{0x0001},{1},__HEX_HL(__GET_LOOP_STEP($1)),{0xFFFF},{1},__HEX_HL(__GET_LOOP_STEP($1)),{0x0002},{1},{0})){}dnl
__{}ifelse(dnl
__{}__GET_LOOP_STEP($1):__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{1::},{
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   index  ( stop index -- ){}dnl
__{}__{}ifelse($0_TMP,{1},{
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop},
__{}__{}{
__{}__{}__{}    ld  [stp{}$1], DE    ; 4:20      __INFO   stop})
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},

__{}__GET_LOOP_STEP($1):__GET_LOOP_BEGIN($1),{1:},{
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   ( __GET_LOOP_END($1) index -- )
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},

__{}__GET_LOOP_STEP($1):__GET_LOOP_END($1),{1:},{dnl
__{}__{}define({$0_BEGIN},__LD_R16({HL},__GET_LOOP_BEGIN($1))){}dnl
__{}__{}ifelse($0_TMP,{1},{
__{}__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop},
__{}__{}{
__{}__{}__{}    ld  [stp{}$1], HL    ; 3:16      __INFO   ( stop __GET_LOOP_BEGIN($1) -- )}){}dnl
__{}__{}$0_BEGIN   HL = index
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},

__{}{
__{}__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
__{}do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_QMDO_I8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(dnl
__{}__GET_LOOP_STEP($1):__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{1::},{
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   index  ( stop index -- ){}dnl
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}    jp    z, exit{}$1    ; 3:10      __INFO},

__{}__GET_LOOP_STEP($1):__HAS_PTR(__GET_LOOP_END($1)):__GET_LOOP_BEGIN($1),{1:1:},{
__{}__{}define({$0_BC_END},__LD_R16({BC},__GET_LOOP_END($1))){}dnl
__{}__{}                       ;[15:79]      __INFO
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   index ( __GET_LOOP_END($1) index -- ){}dnl
__{}__{}$0_BC_END
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO},

__{}__GET_LOOP_STEP($1):__GET_LOOP_BEGIN($1),{1:},{dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_END($1)),{0},{
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    ld    B, H          ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp   qdo{}$1         ; 3:10      __INFO},
__{}__{}__HAS_PTR(__GET_LOOP_END($1)),{0},{
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__{}__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,40){}dnl
__{}__{}_TMP_BEST_CODE
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO})},

__{}__GET_LOOP_STEP($1):__GET_LOOP_END($1),{1:},{dnl
__{}ifelse(dnl
__{}__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}    ld    A, H          ; 1:4       __INFO
__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop
__{}    ld   BC,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO
__{}    ld  [idx{}$1], BC    ; 4:20      __INFO
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jp    z, exit{}$1    ; 3:10      __INFO},
__{}__IS_NUM(__GET_LOOP_BEGIN($1)),0,{
__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}    ld    A, H          ; 1:4       __INFO
__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop{}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    ld   BC,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO},
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
__{}    ld  [idx{}$1], BC    ; 4:20      __INFO
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jp    z, exit{}$1    ; 3:10      __INFO},
__{}{ifelse(__HEX_HL(__GET_LOOP_BEGIN($1)),0x0000,{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop
__{}__{}    or    L             ; 1:4       __INFO{}dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}__{}    ld   HL,format({%-12s},__GET_LOOP_BEGIN($1)); 3:16      __INFO},
__{}__{}{
__{}__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1)),0xFFFF,{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop
__{}__{}    and   L             ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1)),0x0101,{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_H(__GET_LOOP_BEGIN($1)),0x00,{
__{}__{}    ld    A, H          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}__{}ifelse(__HEX_L(__GET_LOOP_BEGIN($1)),0x01,{dnl
__{}__{}__{}    dec   A             ; 1:4       __INFO},
__{}__{}__{}__HEX_L(__GET_LOOP_BEGIN($1)),0xFF,{dnl
__{}__{}__{}    inc   A             ; 1:4       __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    xor  format({%-15s},low __GET_LOOP_BEGIN($1)); 2:7       __INFO})
__{}__{}    or    H             ; 1:4       __INFO{}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    ld   HL,format({%-12s},__GET_LOOP_BEGIN($1)); 3:16      __INFO},
__{}{
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_L(__GET_LOOP_BEGIN($1)),0x00,{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop
__{}__{}__{}ifelse(__HEX_H(__GET_LOOP_BEGIN($1)),0x01,{dnl
__{}__{}__{}    dec   A             ; 1:4       __INFO},
__{}__{}__{}__HEX_H(__GET_LOOP_BEGIN($1)),0xFF,{dnl
__{}__{}__{}    inc   A             ; 1:4       __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    xor  format({%-15s},high __GET_LOOP_BEGIN($1)); 2:7       __INFO})
__{}__{}    or    L             ; 1:4       __INFO{}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    ld   HL,format({%-12s},__GET_LOOP_BEGIN($1)); 3:16      __INFO},
__{}{
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop{}dnl
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}    ld   BC,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO},
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO})
__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO})})
__{}    pop  HL             ; 1:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    jp    z, exit{}$1    ; 3:10      __INFO},

__{}{
__{}__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
__{}do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  do ... step +loop  ----------- step != 1
dnl # 0 5 do i . -1 +loop --> 5 4 3 2 1 0
dnl # 0 0 do i . -1 +loop --> 0
dnl # ( stop index -- ) ( R: -- )
define({__ASM_TOKEN_MDO_D8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}define({$0_TMP},ifelse(__HEX_HL(__GET_LOOP_STEP($1)),{0x0001},{1},__HEX_HL(__GET_LOOP_STEP($1)),{0xFFFF},{1},__HEX_HL(__GET_LOOP_STEP($1)),{0x0002},{1},{0})){}dnl
__{}ifelse(dnl
__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:},{
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   index  ( stop index -- ){}dnl
__{}__{}ifelse($0_TMP,{1},{
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index--
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1},
__{}__{}{
__{}__{}__{}    ld  [stp{}$1], DE    ; 4:20      __INFO   stop})
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},

__{}__GET_LOOP_BEGIN($1),{},{
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   ( __GET_LOOP_END($1) index -- )
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},

__{}__GET_LOOP_END($1),{},{dnl
__{}__{}define({$0_BEGIN},__LD_R16({HL},__GET_LOOP_BEGIN($1))){}dnl
__{}__{}ifelse($0_TMP,{1},{
__{}__{}__{}    dec  HL             ; 1:6       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1},
__{}__{}{
__{}__{}__{}    ld  [stp{}$1], HL    ; 3:16      __INFO   ( stop __GET_LOOP_BEGIN($1) -- )}){}dnl
__{}__{}$0_BEGIN   HL = index
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},

__{}{
__{}__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
__{}do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... 1 +loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 0 0 do i . loop -->
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_QMDO_D8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}define({$0_TMP},ifelse(__HEX_HL(__GET_LOOP_STEP($1)),{0x0001},{1},__HEX_HL(__GET_LOOP_STEP($1)),{0xFFFF},{1},__HEX_HL(__GET_LOOP_STEP($1)),{0x0002},{1},{0})){}dnl
__{}ifelse(dnl
__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:},{
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   index  ( stop index -- )
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO{}dnl
__{}__{}ifelse($0_TMP,{1},{
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index--
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1},
__{}__{}{
__{}__{}__{}    ld  [stp{}$1], DE    ; 4:20      __INFO   stop})
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO},

__{}__HAS_PTR(__GET_LOOP_END($1)):__GET_LOOP_BEGIN($1),{1:},{
__{}__{}define({$0_BC_END},__LD_R16({BC},__GET_LOOP_END($1))){}dnl
__{}__{}                       ;[15:79]     __INFO   ( __GET_LOOP_END($1) index -- )
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO{}dnl
__{}__{}$0_BC_END
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO},

__{}__GET_LOOP_BEGIN($1),{},{
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__{}__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,40){}dnl
__{}__{}_TMP_BEST_CODE
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO},

__{}$0_TMP:__GET_LOOP_END($1),{1:},{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__{}__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_BEGIN($1),0,0){}dnl
__{}__{}define({$0_HL_BEGIN},__LD_R16({HL},__GET_LOOP_BEGIN($1))){}dnl
__{}__{}define({_TMP_BEST_B},eval(_TMP_BEST_B+__BYTES+17)){}dnl
__{}__{}define({_TMP_BEST_C},eval(_TMP_BEST_C+__CLOCKS+80)){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_C+__BYTE_PRICE*_TMP_BEST_B)){}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1)-1),{0x0000},{
__{}__{}__{}                       ;[21:94]     __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    or    H             ; 1:4       __INFO
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1{}dnl
__{}__{}__{}$0_HL_BEGIN
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1)-1),{0x0001},{
__{}__{}__{}                       ;[22:98]     __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}__{}    or    H             ; 1:4       __INFO
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1{}dnl
__{}__{}__{}$0_HL_BEGIN
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_H(__GET_LOOP_BEGIN($1)-1),{0x00},{
__{}__{}__{}                       ;[23:101]    __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    xor  __HEX_L(__GET_LOOP_BEGIN($1)-1)           ; 2:7       __INFO
__{}__{}__{}    or    H             ; 1:4       __INFO
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1{}dnl
__{}__{}__{}$0_HL_BEGIN
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_L(__GET_LOOP_BEGIN($1)-1),{0x00},{
__{}__{}__{}                       ;[23:101]    __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1
__{}__{}__{}    xor  __HEX_H(__GET_LOOP_BEGIN($1)-1)           ; 2:7       __INFO
__{}__{}__{}    or    L             ; 1:4       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1{}dnl
__{}__{}__{}$0_HL_BEGIN
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1)),{0x0000},{
__{}__{}__{}                       ;[22:98]     __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    or    H             ; 1:4       __INFO
__{}__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1{}dnl
__{}__{}__{}$0_HL_BEGIN
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}__HEX_H(__GET_LOOP_BEGIN($1)-1),{0xFF},{
__{}__{}__{}                       ;[24:105]    __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    xor  __HEX_L((__GET_LOOP_BEGIN($1)-1) ^ 0xFFFF)           ; 2:7       __INFO
__{}__{}__{}    and   H             ; 1:4       __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1{}dnl
__{}__{}__{}$0_HL_BEGIN
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}eval(_TMP_BEST_P<=107+__CLOCKS+__BYTE_PRICE*(__BYTES+22)),1,{
__{}__{}__{}                       ;format({%-11s},[_TMP_BEST_B:_TMP_BEST_C]) __INFO   ( stop __GET_LOOP_BEGIN($1) -- ){}dnl
__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1{}dnl
__{}__{}__{}$0_HL_BEGIN
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}{
__{}__{}__{}                       ;format({%-11s},[eval(22+__BYTES):eval(107+__CLOCKS)]) __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}__{}    ld    B, H          ; 1:4       __INFO{}dnl
__{}__{}__{}$0_HL_BEGIN
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO
__{}__{}__{}    or    A             ; 1:4       __INFO
__{}__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}__{}    dec  BC             ; 1:6       __INFO
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_lo{}$1], A  ; 3:13      __INFO   lo stop-1
__{}__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}__{}    ld  [stp_hi{}$1], A  ; 3:13      __INFO   hi stop-1})
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO},

__{}__GET_LOOP_END($1),{},{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__{}__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_BEGIN($1),0,0){}dnl
__{}__{}define({$0_HL_BEGIN},__LD_R16({HL},__GET_LOOP_BEGIN($1))){}dnl
__{}__{}define({_TMP_BEST_B},eval(_TMP_BEST_B+__BYTES)){}dnl
__{}__{}define({_TMP_BEST_C},eval(_TMP_BEST_C+__CLOCKS)){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_C+56+__BYTE_PRICE*(_TMP_BEST_B+11))){}dnl
__{}__{}define({$0_BC_BEGIN},__LD_R16({BC},__GET_LOOP_BEGIN($1))){}dnl
__{}__{}ifelse(eval(_TMP_BEST_P<=79+__CLOCKS+__BYTE_PRICE*(__BYTES+15)),1,{
__{}__{}__{}                       ;[eval(11+_TMP_BEST_B):eval(56+_TMP_BEST_C)]     __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    ld  [stp{}$1], HL    ; 3:16      __INFO   save stop{}dnl
__{}__{}__{}_TMP_BEST_CODE{}dnl
__{}__{}__{}$0_HL_BEGIN   HL = index
__{}__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO},
__{}__{}{
__{}__{}__{}                       ;[eval(15+__BYTES):eval(79+__CLOCKS)]     __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}__{}    ld  [stp{}$1], HL    ; 3:16      __INFO   save stop{}dnl
__{}__{}__{}$0_BC_BEGIN   BC = index
__{}__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO
__{}__{}__{}    or    A             ; 1:4       __INFO
__{}__{}__{}    sbc  HL, BC         ; 2:15      __INFO})
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO},

__{}__{}{
__{}__{}__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
__{}do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_MDO_I16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
    ld  [idx{}$1], HL    ; 3:16      __INFO   ( stop index -- )
    ld  [stp{}$1], DE    ; 4:20      __INFO
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1),{},{
    ld  [idx{}$1], HL    ; 3:16      __INFO   ( __GET_LOOP_END($1) index -- )
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO},
__GET_LOOP_END($1),{},{
    ld  (stp{}$1), HL    ; 3:16      __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  [idx{}$1], HL    ; 3:16      __INFO   ( stop index -- )
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
{
__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_QMDO_I16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)})
__{}ifelse(__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{dnl
    ld  [stp{}$1], DE    ; 4:20      __INFO   ( stop index -- )
    dec  HL             ; 1:6       __INFO
    ld  [idx{}$1], HL    ; 3:16      __INFO   index
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp  loop{}$1         ; 3:10      __INFO},
__GET_LOOP_BEGIN($1),{},{
define({_TMP_INFO},__INFO){}dnl
define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,40){}dnl
__{}_TMP_BEST_CODE
    ld  [idx{}$1], HL    ; 3:16      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    jp    z,loop{}$1     ; 3:10      __INFO},
__GET_LOOP_END($1),{},{dnl
    ld  (stp{}$1), HL    ; 3:16      __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{dnl
__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); 3:16      __INFO
__{}    dec  HL             ; 1:6       __INFO},
__{}{dnl
__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)-1); 3:10      __INFO})
    ld  [idx{}$1], HL    ; 3:16      __INFO   index-1
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    jp  loop{}$1         ; 3:10      __INFO},
{
__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  do ... -1 +loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 5 5 do i . loop --> 5 4 3 2 1 0 -1 ... -32768 32767 32766 ... 7 6 5
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_MDO_D16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
    ld  [idx{}$1], HL    ; 3:16      __INFO   index  ( stop index -- )
    dec  DE             ; 1:6       __INFO
    ld  [stp{}$1], DE    ; 4:20      __INFO   stop-1
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1),{},{
    ld  [idx{}$1], HL    ; 3:16      __INFO   ( __GET_LOOP_END($1) index -- )
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
__GET_LOOP_END($1),{},{
    dec  HL             ; 1:6       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
    ld  [stp{}$1], HL    ; 3:16      __INFO   stop-1
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  [idx{}$1], HL    ; 3:16      __INFO   index
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
{
__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... -1 +loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 5 5 do i . loop -->
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_QMDO_D16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
    ld  [idx{}$1], HL    ; 3:16      __INFO   ( stop index -- )
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    dec  DE             ; 1:6       __INFO   stop-1
    ld  [stp{}$1], DE    ; 4:20      __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1),{},{dnl
define({_TMP_INFO},__INFO){}dnl
define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,40){}dnl
__{}_TMP_BEST_CODE
    ld  [idx{}$1], HL    ; 3:16      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
__GET_LOOP_END($1),{},{
    ld    C, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
    ld    B, H          ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    ld  [idx{}$1], HL    ; 3:16      __INFO   stop-1
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  [idx{}$1], HL    ; 3:16      __INFO   index
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
{
__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
    jp    z, exit{}$1    ; 3:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
define({TEST_IDEA_DO_I_LOOP},{
                        ;[12:60]    do_101 i_101
    ld    A, E          ; 1:4       do_101 i_101
    ld  [stp_lo101], A  ; 3:13      do_101 i_101   lo stop
    ld    A, D          ; 1:4       do_101 i_101
    ld  [stp_hi101], A  ; 3:13      do_101 i_101   hi stop
    pop  DE             ; 1:10      do_101 i_101
do101:                  ;           do_101 i_101
    ld  [idx101], HL    ; 3:16      do_101 i_101   save index

                     ;[20:52/73/87] loop_101
    push DE             ; 1:11      loop_101   ( -- i )
    ex   DE, HL         ; 1:4       loop_101
idx101 EQU $+1          ;           loop_101
    ld   HL, 0x0000     ; 3:10      loop_101   idx always points to a 16-bit index
    inc  HL             ; 1:6       loop_101   index++
    ld    A, L          ; 1:4       loop_101   lo new index
stp_lo101 EQU $+1       ;           loop_101
    xor  0x00           ; 2:7       loop_101   lo stop
    jp   nz, do101      ; 3:10      loop_101
    ld    A, H          ; 1:4       loop_101   hi new index
stp_hi101 EQU $+1       ;           loop_101
    xor  0x00           ; 2:7       loop_101   hi stop
    jp   nz, do101      ; 3:10      loop_101
    ex   DE, HL         ; 1:4       loop_101
    pop  DE             ; 1:10      loop_101
leave101:               ;           loop_101
exit101:                ;           loop_101
                       ;[32:147]}){}dnl
dnl
dnl
define({TEST_IDEA_SMALL_DO_I_LOOP},{
                        ;[8:46]     do_101 i_101
    ld  [stp101], DE    ; 4:20      do_101 i_101   stop
    pop  DE             ; 1:10      do_101 i_101
do101:                  ;           do_101 i_101
    ld  [idx101], HL    ; 3:16      do_101 i_101   save index

                        ;[18:81/95] loop_101
    push DE             ; 1:11      loop_101   ( -- i )
    ex   DE, HL         ; 1:4       loop_101
idx101 EQU $+1          ;           loop_101
    ld   HL, 0x0000     ; 3:10      loop_101   idx always points to a 16-bit index
    inc  HL             ; 1:6       loop_101   index++
stp101 EQU $+1          ;           loop_101
    ld   BC, 0x0000     ; 3:10      loop_101   stop
    or    A             ; 1:4       loop_101   lo stop
    sbc  HL, BC         ; 2:15      loop_101
    add  HL, BC         ; 1:11      loop_101
    jp   nz, do101      ; 3:10      loop_101
    ex   DE, HL         ; 1:4       loop_101
    pop  DE             ; 1:10      loop_101
leave101:               ;           loop_101
exit101:                ;           loop_101
                       ;[26:141]}){}dnl
dnl
dnl # --------------------------------------------------------------------
dnl
dnl
dnl # ( -- )
dnl # 5 0 do i .     loop --> 0 1 2 3 4
dnl # 5 0 do i . +1 +loop --> 0 1 2 3 4
define({__ASM_TOKEN_MLOOP_I8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
__{}__{}idx{}$1 EQU $+1          ;[20:78/57] __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO   save index
__{}__{}    ld    A, C          ; 1:4       __INFO   lo new index
__{}__{}stp_lo{}$1 EQU $+1       ;           __INFO
__{}__{}    xor  0x00           ; 2:7       __INFO   lo stop
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO   hi new index
__{}__{}stp_hi{}$1 EQU $+1       ;           __INFO
__{}__{}    xor  0x00           ; 2:7       __INFO   hi stop},

__{}__HAS_PTR(__GET_LOOP_END($1)),{1},{
__{}__{}idx{}$1 EQU $+1          ;[22:90/63] __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO   save index
__{}__{}    ld    A,format({%-12s},__PTR_ADD(__GET_LOOP_END($1),0)); 3:13      __INFO   lo stop
__{}__{}    xor   C             ; 1:4       __INFO   lo(index_new xor stop)
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}    ld    A,format({%-12s},__PTR_ADD(__GET_LOOP_END($1),1)); 3:13      __INFO   hi stop
__{}__{}    xor   B             ; 1:4       __INFO   hi(index_new xor stop)},

__{}{dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1),3,10,do{}$1,0){}dnl
__{}__{}define({__TEMP},_TMP_J1+4*_TMP_BEST_B+46){}dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1)-1,8,36,0,0){}dnl
__{}__{}ifelse(eval(__TEMP<=_TMP_J1+4*_TMP_BEST_B),{1},{
__{}__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1),3,10,do{}$1,0){}dnl
__{}__{}__{}idx{}$1 EQU $+1         ;[eval(8+_TMP_BEST_B):eval(36+_TMP_BEST_C)]     __INFO   ( __GET_LOOP_END($1) index -- )
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}__{}qdo{}$1:                 ;           __INFO
__{}__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO   save index
__{}__{}__{}_TMP_BEST_CODE},
__{}__{}{
__{}__{}__{}idx{}$1 EQU $+1         ;[eval(3+_TMP_BEST_B):eval(10+_TMP_BEST_C)]     __INFO   ( __GET_LOOP_END($1) index -- )
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO   save index})})
__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
dnl # 0 5 do i . -1 +loop --> 5 4 3 2 1 0
define({__ASM_TOKEN_SUB1_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
__{}__{}idx{}$1 EQU $+1          ;[20:78/57] __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    dec  BC             ; 1:6       __INFO   index--
__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO   save index
__{}__{}    ld    A, C          ; 1:4       __INFO   lo new index
__{}__{}stp_lo{}$1 EQU $+1       ;           __INFO
__{}__{}    xor  0xFF           ; 2:7       __INFO   lo stop-1
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO   hi new index
__{}__{}stp_hi{}$1 EQU $+1       ;           __INFO
__{}__{}    xor  0xFF           ; 2:7       __INFO   hi stop-1},

__{}__HAS_PTR(__GET_LOOP_END($1)),{1},{
__{}__{}idx{}$1 EQU $+1         ;[21:87/75]  __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO   save index
__{}__{}    ld    A,format({%-12s},__PTR_ADD(__GET_LOOP_END($1),0)); 3:13      __INFO   lo stop
__{}__{}    xor   C             ; 1:4       __INFO   lo(index_new xor stop)
__{}__{}    jr   nz, $+6        ; 2:7/12    __INFO
__{}__{}    ld    A,format({%-12s},__PTR_ADD(__GET_LOOP_END($1),1)); 3:13      __INFO   hi stop
__{}__{}    xor   B             ; 1:4       __INFO   hi(index_new xor stop)
__{}__{}    dec  BC             ; 1:6       __INFO   index--},

__{}{dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1)-1,3,10,do{}$1,0){}dnl
__{}__{}define({$0_B},eval(_TMP_BEST_B+8)){}dnl
__{}__{}define({$0_C},eval(_TMP_BEST_C+36)){}dnl
__{}__{}define({$0_P},eval($0_C+__BYTE_PRICE*$0_B)){}dnl
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1),8,36,0,36){}dnl
__{}__{}define({$0_B2},eval(_TMP_BEST_B+3)){}dnl
__{}__{}define({$0_C2},eval(_TMP_BEST_C+10)){}dnl
__{}__{}define({$0_P2},eval($0_C2+__BYTE_PRICE*$0_B2)){}dnl
__{}__{}ifelse(eval($0_P<=$0_P2),{1},{
__{}__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1)-1,3,10,do{}$1,0){}dnl
__{}__{}__{}idx{}$1 EQU $+1         ;[$0_B:$0_C]     __INFO   ( __GET_LOOP_END($1) index -- )
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index++
__{}__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO   save index{}dnl
__{}__{}__{}_TMP_BEST_CODE},
__{}__{}{
__{}__{}__{}idx{}$1 EQU $+1         ;[$0_B2:$0_C2]     __INFO   ( __GET_LOOP_END($1) index -- )
__{}__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index{}dnl
__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}    dec  BC             ; 1:6       __INFO   index++
__{}__{}__{}    ld  [idx{}$1], BC    ; 4:20      __INFO   save index{}dnl
__{}__{}}){}dnl
__{}})
__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
dnl # 5 0 do i .     loop --> 0 1 2 3 4
dnl # 5 0 do i . +1 +loop --> 0 1 2 3 4
define({__ASM_TOKEN_MLOOP16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
__{}__{}loop{}$1:                ;[18:92]    __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    inc  HL             ; 1:6       __INFO   index++
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}stp{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   stop},
__{}{
__{}__{}define({$0_BC_END},__LD_R16({HL},__GET_LOOP_END($1))){}dnl
__{}__{}loop{}$1:                ;[eval(15+__BYTES):eval(82+__CLOCKS)]    __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    inc  HL             ; 1:6       __INFO   index++
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index{}dnl
__{}__{}$0_BC_END})
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   index - stop
__{}    pop  HL             ; 1:10      __INFO
__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # 0 5 do i . -1 +loop --> 5 4 3 2 1 0
define({__ASM_TOKEN_SUB1_MLOOP16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
__{}__{}loop{}$1:               ;[18:92]     __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    dec  HL             ; 1:6       __INFO   index--
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}stp{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   BC, 0xFFFF     ; 3:10      __INFO   stop-1},
__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}loop{}$1:               ;[20:108]   __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    dec  HL             ; 1:6       __INFO   index--
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}    ld   BC,format({%-12s},+(__GET_LOOP_END($1))-1); 4:20      __INFO   stop
__{}__{}    dec  BC             ; 1:6       __INFO   stop-1},
__{}{
__{}__{}loop{}$1:               ;[18:92]     __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    dec  HL             ; 1:6       __INFO   index--
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}    ld   BC, format({%-11s},+(__GET_LOOP_END($1))-1); 3:10      __INFO   stop-1})
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   index - stop
__{}    pop  HL             ; 1:10      __INFO
__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # 2 +loop
dnl # ( -- )
dnl # 6 0 do i . 2 +loop --> 0 2 4
dnl # 5 0 do i . 2 +loop --> 0 2 4
dnl # 6 4 do i . 2 +loop --> 4
dnl # 6 5 do i . 2 +loop --> 5
dnl # 6 6 do i . 2 +loop --> 6 8 10 12 ...
define({__ASM_TOKEN_2_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}stp_lo{}$1 EQU $+1       ;           __INFO
__{}__{}    sub  0xFF           ; 2:7       __INFO   lo index - stop-1
__{}__{}    rra                 ; 1:4       __INFO
__{}__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld  [idx{}$1],BC     ; 4:20      __INFO   save index
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}stp_hi{}$1 EQU $+1       ;           __INFO
__{}__{}    sbc   A, 0xFF       ; 2:7       __INFO   hi index - stop-1},

__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A,format({%-12s},__PTR_ADD(__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)),0)); 3:13      __INFO   lo(stop)
__{}__{}    sub   C             ; 1:4       __INFO   0 or 1?
__{}__{}    rra                 ; 2:7       __INFO
__{}__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld  [idx{}$1],BC     ; 4:20      __INFO   save index
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}    dec  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A,format({%-12s},__PTR_ADD(__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)),1)); 3:13      __INFO   hi(stop)
__{}__{}    sbc   A, B          ; 1:4       __INFO   0?},

__{}{
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    sub  format({%-15s},low +(__GET_LOOP_END($1))-1); 2:7       __INFO   lo index - stop-1
__{}__{}    rra                 ; 1:4       __INFO
__{}__{}    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO   index++
__{}__{}    ld  [idx{}$1],BC     ; 4:20      __INFO   save index
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}    sbc   A, format({%-11s},high +(__GET_LOOP_END($1))-1); 2:7       __INFO   hi index - stop-1})
__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl
dnl # step +loop
define({__ASM_TOKEN_PUSH_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(dnl
__{}__HEX_HL(__GET_LOOP_STEP($1)),{0x0001},{{}__ASM_TOKEN_MLOOP_I8($1)},
__{}__HEX_HL(__GET_LOOP_STEP($1)),{0xFFFF},{__ASM_TOKEN_SUB1_ADDMLOOP($1)},
__{}__HEX_HL(__GET_LOOP_STEP($1)),{0x0002},{__ASM_TOKEN_2_ADDMLOOP($1)},

__{}__HAS_PTR(__GET_LOOP_STEP($1)):__GET_LOOP_END($1),{1:},{
__{}                       ;[27:157]    __INFO   variant step is pointer and stop from stack
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index
__{}stp{}$1 EQU $+1          ;           __INFO
__{}    ld   BC, 0x0000     ; 3:10      __INFO   BC = stop
__{}    ld   DE,format({%-12s},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1))); 4:20      __INFO   DE = step
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}    sbc   A, A          ; 1:4       __INFO
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}    pop  HL             ; 1:10      __INFO
__{}    xor   D             ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    jp    p, do{}$1      ; 3:10      __INFO
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO},

__{}__GET_LOOP_END($1),,{
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}define({$0_MIN_STEP},__LD_R16({BC},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_STEP($1))))){}dnl
__{}                       ;[eval(18+__SUM_BYTES):eval(97+__SUM_CLOCKS)]    __INFO   version stop from stack
__{}    push HL             ; 1:11      __INFO
__{}idx{}$1 EQU $+1          ;           __INFO
__{}    ld   HL, 0x0000     ; 3:10      __INFO   HL = index{}dnl
__{}$0_ADD_STEP
__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}stp{}$1 EQU $+1          ;           __INFO
__{}    ld   BC, 0x0000     ; 3:10      __INFO   BC = stop
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index+step-stop{}dnl
__{}$0_MIN_STEP
__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop
__{}    pop  HL             ; 1:10      __INFO{}dnl
__{}ifelse(dnl
__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x0000,{
__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step},
__{}__HEX_HL(0x8000 & (__GET_LOOP_STEP($1))),0x8000,{
__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step},
__{}{
__{}__{}  if ((0x8000 & (__GET_LOOP_STEP($1))) = 0)
__{}__{}    jp    c, do{}$1      ; 3:10      __INFO   positive step
__{}__{}  else
__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO   negative step
__{}__{}  endif})
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO},

__{}__HAS_PTR(__GET_LOOP_STEP($1)),1,{
__{}__{}__RESET_SUMS{}dnl
__{}__{}define({$0_STEP},__LD_R16({DE},__GET_LOOP_STEP($1))){}dnl
__{}__{}define({$0_STOP},__LD_R16({BC},__GET_LOOP_END($1))){}dnl
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
__{}    pop  HL             ; 1:10      __INFO
__{}    xor   D             ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    jp    p, do{}$1      ; 3:10      __INFO
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO},

__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}__RESET_SUMS(){}dnl
__{}__{}__ADD_R16_CONST({HL},__SIMPLIFY_EXPRESSION(__GET_LOOP_STEP($1)),{BC = step},{HL = index+step}){}dnl
__{}__{}define({$0_ADD_STEP},__CODE){}dnl
__{}__{}define({$0_MIN_STEP},       __LD_R16({BC},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_STEP($1))))){}dnl
__{}__{}define({$0_STOP},           __LD_R16({BC},__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)))){}dnl
__{}__{}                       ;[eval(15+__SUM_BYTES):eval(87+__SUM_CLOCKS)]    __INFO   version stop is pointer
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
__{}leave{}$1:               ;           __INFO
__{}exit{}$1:                ;           __INFO},

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
define({__ASM_TOKEN_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(fail,111,{fail
__{}__{}    ld    B, H          ; 1:4       __INFO   variant step from stack and stop is pointer
__{}__{}    ld    C, L          ; 1:4       __INFO   BC = step
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   HL, 0x0000     ; 3:10      __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}stp_lo{}$1 EQU $+1       ;           __INFO
__{}__{}__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}__{}__{}    ld    A, 0xFF       ; 2:7       __INFO   lo stop-1},
__{}__{}__{}{dnl
__{}__{}__{}    ld    A, format({%-11s},low +(__GET_LOOP_END($1))-1); 2:7       __INFO   lo stop-1})
__{}__{}    sub   L             ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}stp_hi{}$1 EQU $+1       ;           __INFO
__{}__{}__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}__{}__{}    ld    A, 0xFF       ; 2:7       __INFO   hi stop-1},
__{}__{}__{}{dnl
__{}__{}__{}    ld    A, format({%-11s},high +(__GET_LOOP_END($1))-1); 2:7       __INFO   hi stop-1})
__{}__{}    sbc   A, H          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO   HL = stop-(index+step)
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = stop-index
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO},

__{}__GET_LOOP_END($1),{},{
__{}__{}                       ;[25:138]    __INFO   variant step and stop from stack
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   DE, 0x0000     ; 3:10      __INFO   DE = index
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}stp{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   BC, 0x0000     ; 3:10      __INFO   BC = stop
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index+step-stop
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
__{}__{}    sbc   A, A          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO},

__{}__HAS_PTR(__GET_LOOP_END($1)),1,{
__{}__{}                       ;[26:148]    __INFO   variant step from stack and stop is pointer
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   DE, 0x0000     ; 3:10      __INFO   DE = index
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}    ld   BC, format({%-11s},__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1))); 4:20      __INFO   BC = stop
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index+step-stop
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
__{}__{}    sbc   A, A          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO},

__{}{
__{}__{}                       ;[23:130]    __INFO   variant step from stack
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}idx{}$1 EQU $+1          ;           __INFO
__{}__{}    ld   DE, 0x0000     ; 3:10      __INFO   DE = index
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step
__{}__{}    ld  [idx{}$1], HL    ; 3:16      __INFO   save index
__{}__{}    ld   BC, format({%-11s},__SIMPLIFY_EXPRESSION(-(__GET_LOOP_END($1)))); 3:10      __INFO   BC = -stop
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step-stop
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
__{}__{}    sbc   A, A          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO
__{}__{}leave{}$1:               ;           __INFO
__{}__{}exit{}$1:                ;           __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl

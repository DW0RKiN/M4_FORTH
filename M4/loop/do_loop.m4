dnl ## non-recursive do loop
dnl
dnl
dnl # ============================================
dnl
dnl
dnl # ---------  do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_MDO_I8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:},{
    ld  (idx{}$1), HL    ; 3:16      __INFO   index  ( stop index -- )
    ld    A, E          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
    ld    A, D          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1):__IS_MEM_REF(__GET_LOOP_END($1)),{:0},{
    ld  (idx{}$1), HL    ; 3:16      __INFO   index  ( __GET_LOOP_END($1) index -- )
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO},
__GET_LOOP_END($1),{},{
    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
    ld    A, H          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); 3:ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,16,10)      __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO   index
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO},
{
__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_QMDO_I8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:},{
    ld  (idx{}$1), HL    ; 3:16      __INFO   index  ( stop index -- )
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    ld    A, E          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
    ld    A, D          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, exit{}$1    ; 3:10      __INFO},
__GET_LOOP_BEGIN($1):__IS_MEM_REF(__GET_LOOP_END($1)):__SAVE_EVAL(__GET_LOOP_STEP($1)),{:0:1},{
    ld    C, L          ; 1:4       __INFO
    ld    B, H          ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    jp   qdo{}$1         ; 3:10      __INFO},
__GET_LOOP_BEGIN($1):__IS_MEM_REF(__GET_LOOP_END($1)),{:0},{
define({_TMP_INFO},__INFO){}dnl
define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,40){}dnl
__{}_TMP_BEST_CODE
    ld  (idx{}$1), HL    ; 3:16      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    jp    z, exit{}$1    ; 3:10      __INFO},
__GET_LOOP_END($1),{},{dnl
__{}ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,{
__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
__{}    ld    A, H          ; 1:4       __INFO
__{}    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
__{}    ld   BC, format({%-11s},__GET_LOOP_BEGIN($1)); 4:20      __INFO
__{}    ld  (idx{}$1), BC    ; 4:20      __INFO
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jp    z, exit{}$1    ; 3:10      __INFO},
__{}__IS_NUM(__GET_LOOP_BEGIN($1)),0,{
__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
__{}    ld    A, H          ; 1:4       __INFO
__{}    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
__{}    ld   BC, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,4:20,3:10)      __INFO
__{}    ld  (idx{}$1), BC    ; 4:20      __INFO
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jp    z, exit{}$1    ; 3:10      __INFO},
__{}{ifelse(__HEX_HL(__GET_LOOP_BEGIN($1)),0x0000,{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
__{}__{}    ld  (idx{}$1), HL    ; 3:16      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1)),0xFFFF,{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
__{}__{}    and   L             ; 1:4       __INFO
__{}__{}    inc   A             ; 1:4       __INFO
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
__{}__{}    ld  (idx{}$1), HL    ; 3:16      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_BEGIN($1)),0x0101,{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    dec   A             ; 1:4       __INFO
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
__{}__{}    ld  (idx{}$1), HL    ; 3:16      __INFO},
__{}__{}__HEX_H(__GET_LOOP_BEGIN($1)),0x00,{
__{}__{}    ld    A, H          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
__{}__{}__{}ifelse(__HEX_L(__GET_LOOP_BEGIN($1)),0x01,{dnl
__{}__{}__{}    dec   A             ; 1:4       __INFO},
__{}__{}__{}__HEX_L(__GET_LOOP_BEGIN($1)),0xFF,{dnl
__{}__{}__{}    inc   A             ; 1:4       __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    xor  format({%-15s},low __GET_LOOP_BEGIN($1)); 2:7       __INFO})
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
__{}__{}    ld  (idx{}$1), HL    ; 3:16      __INFO},
__{}__{}__HEX_L(__GET_LOOP_BEGIN($1)),0x00,{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
__{}__{}__{}ifelse(__HEX_H(__GET_LOOP_BEGIN($1)),0x01,{dnl
__{}__{}__{}    dec   A             ; 1:4       __INFO},
__{}__{}__{}__HEX_H(__GET_LOOP_BEGIN($1)),0xFF,{dnl
__{}__{}__{}    inc   A             ; 1:4       __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    xor  format({%-15s},high __GET_LOOP_BEGIN($1)); 2:7       __INFO})
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
__{}__{}    ld  (idx{}$1), HL    ; 3:16      __INFO},
__{}__{}{
__{}__{}    ld    A, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}__{}    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,4:20,3:10)      __INFO
__{}__{}    ld  (idx{}$1), BC    ; 4:20      __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO})})
__{}    pop  HL             ; 1:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    jp    z, exit{}$1    ; 3:10      __INFO},
{
__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  do ... -loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 0 0 do i . loop --> 0
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_MDO_D8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)})
__{}ifelse(__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{dnl
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    dec  DE             ; 1:6       __INFO
    ld    A, E          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop-1
    ld    A, D          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop-1
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1),{},{dnl
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( __GET_LOOP_END($1) index -- )
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
__GET_LOOP_END($1),{},{dnl
    dec  HL             ; 1:6       __INFO
    ld    A, L          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop-1
    ld    A, H          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop-1
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
{
__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... 1 +loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 0 0 do i . loop -->
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_QMDO_D8},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
ifelse(__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    dec  DE             ; 1:6       __INFO
    ld    A, E          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop-1
    ld    A, D          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop-1
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1),{},{
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,40){}dnl
__{}_TMP_BEST_CODE
    ld  (idx{}$1), HL    ; 3:16      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
__GET_LOOP_END($1),{},{dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_BEGIN($1),20,90){}dnl
__{}ifelse(eval(_TMP_BEST_P<16*(117+4*25)),1,{
__{}_TMP_BEST_CODE
    dec  HL             ; 1:6       __INFO
    ld    A, L          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop-1
    ld    A, H          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop-1
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
{
    ld    C, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
    ld    B, H          ; 1:4       __INFO
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO
    dec  BC             ; 1:6       __INFO
    ld    A, C          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop-1
    ld    A, B          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop-1
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO})},
{
__{}  .error {$0}($@): Unexpected combination of loop parameters. __SHOW_LOOP($1)})
    jp    z, exit{}$1    ; 3:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_MDO_I16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
__{}ifelse(__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    ld  (stp{}$1), DE    ; 4:20      __INFO
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1),{},{
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( __GET_LOOP_END($1) index -- )
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO},
__GET_LOOP_END($1),{},{
    ld  (stp{}$1), HL    ; 3:16      __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
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
    ld  (stp{}$1), DE    ; 4:20      __INFO   ( stop index -- )
    dec  HL             ; 1:6       __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO   index
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp  loop{}$1         ; 3:10      __INFO},
__GET_LOOP_BEGIN($1),{},{
define({_TMP_INFO},__INFO){}dnl
define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,40){}dnl
__{}_TMP_BEST_CODE
    ld  (idx{}$1), HL    ; 3:16      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    jp    z,loop{}$1     ; 3:10      __INFO},
__GET_LOOP_END($1),{},{dnl
    ld  (stp{}$1), HL    ; 3:16      __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
__{}ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,{dnl
__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); 3:16      __INFO
__{}    dec  HL             ; 1:6       __INFO},
__{}{dnl
__{}    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)-1); 3:10      __INFO})
    ld  (idx{}$1), HL    ; 3:16      __INFO   index-1
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
    ld  (idx{}$1), HL    ; 3:16      __INFO   index  ( stop index -- )
    dec  DE             ; 1:6       __INFO
    ld  (stp{}$1), DE    ; 4:20      __INFO   stop-1
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1),{},{
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( __GET_LOOP_END($1) index -- )
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
__GET_LOOP_END($1),{},{
    dec  HL             ; 1:6       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
    ld  (stp{}$1), HL    ; 3:16      __INFO   stop-1
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO   index
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
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    dec  DE             ; 1:6       __INFO   stop-1
    ld  (stp{}$1), DE    ; 4:20      __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__GET_LOOP_BEGIN($1),{},{dnl
define({_TMP_INFO},__INFO){}dnl
define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- )){}dnl
__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),8,40){}dnl
__{}_TMP_BEST_CODE
    ld  (idx{}$1), HL    ; 3:16      __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO},
__GET_LOOP_END($1),{},{
    ld    C, L          ; 1:4       __INFO   ( stop __GET_LOOP_BEGIN($1) -- )
    ld    B, H          ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO   stop-1
    ld   HL, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,3:16,3:10)      __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO   index
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
    ld  (stp_lo101), A  ; 3:13      do_101 i_101   lo stop
    ld    A, D          ; 1:4       do_101 i_101
    ld  (stp_hi101), A  ; 3:13      do_101 i_101   hi stop
    pop  DE             ; 1:10      do_101 i_101
do101:                  ;           do_101 i_101
    ld  (idx101), HL    ; 3:16      do_101 i_101   save index

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
    ld  (stp101), DE    ; 4:20      do_101 i_101   stop
    pop  DE             ; 1:10      do_101 i_101
do101:                  ;           do_101 i_101
    ld  (idx101), HL    ; 3:16      do_101 i_101   save index

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
ifelse(__GET_LOOP_END($1),{},{
idx{}$1 EQU $+1          ;[20:78/57] __INFO
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    inc  BC             ; 1:6       __INFO   index++
    ld  (idx{}$1), BC    ; 4:20      __INFO   save index
    ld    A, C          ; 1:4       __INFO   lo new index
stp_lo{}$1 EQU $+1       ;           __INFO
    xor  0x00           ; 2:7       __INFO   lo stop
    jp   nz, do{}$1      ; 3:10      __INFO
    ld    A, B          ; 1:4       __INFO   hi new index
stp_hi{}$1 EQU $+1       ;           __INFO
    xor  0x00           ; 2:7       __INFO   hi stop},
{dnl
__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1),3,10,do{}$1,0){}dnl
define({__TEMP},_TMP_J1+4*_TMP_BEST_B+46){}dnl
__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1)-1,8,36,0,0){}dnl
ifelse(eval(__TEMP<=_TMP_J1+4*_TMP_BEST_B),{1},{
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1),3,10,do{}$1,0){}dnl
idx{}$1 EQU $+1         ;[eval(8+_TMP_BEST_B):eval(36+_TMP_BEST_C)]     __INFO   ( __GET_LOOP_END($1) index -- )
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    inc  BC             ; 1:6       __INFO   index++
qdo{}$1:                 ;           __INFO
    ld  (idx{}$1), BC    ; 4:20      __INFO   save index
__{}_TMP_BEST_CODE},
{
idx{}$1 EQU $+1         ;[eval(3+_TMP_BEST_B):eval(10+_TMP_BEST_C)]     __INFO   ( __GET_LOOP_END($1) index -- )
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}_TMP_BEST_CODE
    inc  BC             ; 1:6       __INFO   index++
    ld  (idx{}$1), BC    ; 4:20      __INFO   save index})})
    jp   nz, do{}$1      ; 3:10      __INFO
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
dnl # 0 5 do i . -1 +loop --> 5 4 3 2 1 0
define({__ASM_TOKEN_SUB1_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl
ifelse(__GET_LOOP_END($1),{},{
idx{}$1 EQU $+1          ;[20:78/57] __INFO
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    dec  BC             ; 1:6       __INFO   index--
    ld  (idx{}$1), BC    ; 4:20      __INFO   save index
    ld    A, C          ; 1:4       __INFO   lo new index
stp_lo{}$1 EQU $+1       ;           __INFO
    xor  0xFF           ; 2:7       __INFO   lo stop-1
    jp   nz, do{}$1      ; 3:10      __INFO
    ld    A, B          ; 1:4       __INFO   hi new index
stp_hi{}$1 EQU $+1       ;           __INFO
    xor  0xFF           ; 2:7       __INFO   hi stop-1},
{dnl
__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1)-1,3,10,do{}$1,0){}dnl
define({__TEMP},_TMP_J1+4*_TMP_BEST_B+46){}dnl
__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1),8,36,0,0){}dnl
ifelse(eval(__TEMP<=_TMP_J1+4*_TMP_BEST_B),{1},{
__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO,BC,__GET_LOOP_END($1)-1,3,10,do{}$1,0){}dnl
idx{}$1 EQU $+1         ;[eval(8+_TMP_BEST_B):eval(36+_TMP_BEST_C)]     __INFO   ( __GET_LOOP_END($1) index -- )
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    dec  BC             ; 1:6       __INFO   index++
    ld  (idx{}$1), BC    ; 4:20      __INFO   save index
__{}_TMP_BEST_CODE},
{
idx{}$1 EQU $+1         ;[eval(3+_TMP_BEST_B):eval(10+_TMP_BEST_C)]     __INFO   ( __GET_LOOP_END($1) index -- )
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
__{}_TMP_BEST_CODE
    dec  BC             ; 1:6       __INFO   index++
    ld  (idx{}$1), BC    ; 4:20      __INFO   save index})})
    jp   nz, do{}$1      ; 3:10      __INFO
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
dnl # 5 0 do i .     loop --> 0 1 2 3 4
dnl # 5 0 do i . +1 +loop --> 0 1 2 3 4
define({__ASM_TOKEN_MLOOP16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl

loop{}$1:                ;[18:92]    __INFO
    push HL             ; 1:11      __INFO
idx{}$1 EQU $+1          ;           __INFO
    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    inc  HL             ; 1:6       __INFO   index++
    ld  (idx{}$1), HL    ; 3:16      __INFO   save index
stp{}$1 EQU $+1          ;           __INFO
__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}    ld   BC, 0x0000     ; 3:10      __INFO   stop},
{dnl
__{}    ld   BC, format({%-11s},__GET_LOOP_END($1)); 3:10      __INFO   stop})
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO   index - stop
    pop  HL             ; 1:10      __INFO
    jp   nz, do{}$1      ; 3:10      __INFO
dnl #                     ;18:92
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # 0 5 do i . -1 +loop --> 5 4 3 2 1 0
define({__ASM_TOKEN_SUB1_MLOOP16},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)})
loop{}$1:                ;[18:92]    __INFO
    push HL             ; 1:11      __INFO
idx{}$1 EQU $+1          ;           __INFO
    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    dec  HL             ; 1:6       __INFO   index--
    ld  (idx{}$1), HL    ; 3:16      __INFO   save index
stp{}$1 EQU $+1          ;           __INFO
__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}    ld   BC, 0xFFFF     ; 3:10      __INFO   stop-1},
{dnl
__{}    ld   BC, format({%-11s},__GET_LOOP_END($1)-1); 3:10      __INFO   stop-1})
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO   index - stop
    pop  HL             ; 1:10      __INFO
    jp   nz, do{}$1      ; 3:10      __INFO
dnl #                     ;18:92
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO{(m)})
idx{}$1 EQU $+1          ;           __INFO
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    inc  BC             ; 1:6       __INFO   index++
    ld    A, C          ; 1:4       __INFO
stp_lo{}$1 EQU $+1       ;           __INFO
__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}    sub  0xFF           ; 2:7       __INFO   lo index - stop-1},
__{}{dnl
__{}    sub  format({%-15s},low __GET_LOOP_END($1)-1); 2:7       __INFO   lo index - stop-1})
    rra                 ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
    ld    A, B          ; 1:4       __INFO
    inc  BC             ; 1:6       __INFO   index++
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index
    jp   nz, do{}$1      ; 3:10      __INFO
stp_hi{}$1 EQU $+1       ;           __INFO
__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}    sbc   A, 0xFF       ; 2:7       __INFO   hi index - stop-1},
__{}{dnl
__{}    sbc   A, format({%-11s},high __GET_LOOP_END($1)-1); 2:7       __INFO   hi index - stop-1})
    jp   nz, do{}$1      ; 3:10      __INFO
dnl #                         ;23:71/92/92
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl
dnl # step +loop
define({__ASM_TOKEN_PUSH_ADDMLOOP},{dnl
__{}ifelse(__SAVE_EVAL(__GET_LOOP_STEP($1)),{1},{{}__ASM_TOKEN_MLOOP_I8($1)},
__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{-1},{__ASM_TOKEN_SUB1_ADDMLOOP($1)},
__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{2},{__ASM_TOKEN_2_ADDMLOOP($1)},
__{}{define({__INFO},__COMPILE_INFO{(m)})
    push HL             ; 1:11      __INFO
idx{}$1 EQU $+1          ;           __INFO
    ld   HL, 0x0000     ; 3:10      __INFO
    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO BC = step
    add  HL, BC         ; 1:11      __INFO HL = index+step
    ld  (idx{}$1), HL    ; 3:16      __INFO save index
stp_lo{}$1 EQU $+1       ;           __INFO
__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}    ld    A, 0xFF       ; 2:7       __INFO   lo stop-1},
__{}{dnl
__{}    ld    A, format({%-11s},low 0xFFFF+(__GET_LOOP_END($1))); 2:7       __INFO   lo stop-1})
    sub   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
stp_hi{}$1 EQU $+1       ;           __INFO
__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}    ld    A, 0xFF       ; 2:7       __INFO   hi stop-1},
__{}{dnl
__{}    ld    A, format({%-11s},high 0xFFFF+(__GET_LOOP_END($1))); 2:7       __INFO   hi stop-1})
    sbc   A, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO HL = stop-(index+step)
    add  HL, BC         ; 1:11      __INFO HL = stop-index
    xor   H             ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    jp    p, do{}$1      ; 3:10      __INFO
dnl #                     ;??:???
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
})}){}dnl
dnl
dnl
dnl
define({__ASM_TOKEN_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(m)}){}dnl

    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO BC = step
idx{}$1 EQU $+1          ;           __INFO
    ld   HL, 0x0000     ; 3:10      __INFO
    add  HL, BC         ; 1:11      __INFO HL = index+step
    ld  (idx{}$1), HL    ; 3:16      __INFO save index
stp_lo{}$1 EQU $+1       ;           __INFO
__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}    ld    A, 0xFF       ; 2:7       __INFO   lo stop-1},
__{}{dnl
__{}    ld    A, format({%-11s},low __GET_LOOP_END($1)-1); 2:7       __INFO   lo stop-1})
    sub   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
stp_hi{}$1 EQU $+1       ;           __INFO
__{}ifelse(__GET_LOOP_END($1),{},{dnl
__{}    ld    A, 0xFF       ; 2:7       __INFO   hi stop-1},
__{}{dnl
__{}    ld    A, format({%-11s},high __GET_LOOP_END($1)-1); 2:7       __INFO   hi stop-1})
    sbc   A, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO HL = stop-(index+step)
    add  HL, BC         ; 1:11      __INFO HL = stop-index
    xor   H             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    p, do{}$1      ; 3:10      __INFO
dnl #                     ;24:114
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl
dnl

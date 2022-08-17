dnl ## non-recursive for i next
dnl
dnl # ---------  for ... next  -----------
dnl # 5 for i . next --> 5 4 3 2 1 0
dnl # ( index -- ) r: ( -- )
dnl # stop = 0
define({FOR},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   next{}LOOP_STACK        ;           for-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           for-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_FOR},{for_}LOOP_STACK,LOOP_STACK)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_FOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    B, H          ; 1:4       __INFO   ( i -- )
    ld    C, L          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   index
for{}$1:                 ;           __INFO
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index}){}dnl
dnl
dnl
dnl
dnl # ---------  for ... next  -----------
dnl # 5 for i . next --> 5 4 3 2 1 0
dnl # ( index -- ) r: ( -- )
dnl # stop = 0
define({FOR_I},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   next{}LOOP_STACK        ;           for-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           for-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_FOR_I},{for_}LOOP_STACK{ i_}LOOP_STACK,LOOP_STACK)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_FOR_I},{dnl
__{}define({__INFO},__COMPILE_INFO)
    jr   $+6            ; 2:12      __INFO
for{}$1:                 ;           __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO   copy index
    ld  (idx{}$1),HL     ; 3:16      __INFO   save index}){}dnl
dnl
dnl
dnl
dnl # ( -- ) r: ( -- )
dnl # stop = 0
define({PUSH_FOR},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameter!},
$#,{1},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   next{}LOOP_STACK        ;           for-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           for-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FOR},{$1 for_}LOOP_STACK,LOOP_STACK,$1)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld   BC, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{4:20},{3:10})      __INFO   ( -- )
for{}$1:                 ;           __INFO
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index}){}dnl
dnl
dnl
dnl
dnl # ( -- ) r: ( -- )
dnl # stop = 0
define({PUSH_FOR_I},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameter!},
$#,{1},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   next{}LOOP_STACK        ;           for-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           for-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FOR_I},{$1 for_}LOOP_STACK{ i_}LOOP_STACK,LOOP_STACK,$1)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FOR_I},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld   BC, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{4:20},{3:10})      __INFO   ( -- i )
for{}$1:                 ;           __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO   copy index
    ld  (idx{}$1),HL     ; 3:16      __INFO   save index
}){}dnl
dnl
dnl
dnl
define({TEST_IDEA_PUSH_FOR_I_NEXT},{
    push DE             ; 1:11      $1 for_101 i_101
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 for_101 i_101
for101:                 ;           $1 for_101 i_101
    ex   DE, HL         ; 1:4       $1 for_101 i_101
    ld  (idx101),HL     ; 3:16      $1 for_101 i_101   save index
    push DE             ; 1:11      next_101
idx101 EQU $+1          ;           next_101
    ld   DE, 0x0000     ; 3:10      next_101   idx always points to a 16-bit index
    ld    A, D          ; 1:4       next_101
    or    E             ; 1:4       next_101
    dec  DE             ; 1:6       next_101   index--, zero flag unaffected
    jp   nz, for101     ; 3:10      next_101
    pop  DE             ; 1:10      next_101
next101:                ;           next_101
                       ;ifelse(__IS_MEM_REF($1),{1},{[20:106]},{[19:96]}) only 65 loop}){}dnl
dnl
dnl
define({TEST_IDEA_FOR_I_NEXT},{
for101:                 ;           for_101 i_101
    ld  (idx101),HL     ; 3:16      for_101 i_101   save index
    push DE             ; 1:11      next_101
    ex   DE, HL         ; 1:4       next_101
idx101 EQU $+1          ;           next_101
    ld   HL, 0x0000     ; 3:10      next_101   idx always points to a 16-bit index
    ld    A, H          ; 1:4       next_101
    or    L             ; 1:4       next_101
    dec  HL             ; 1:6       next_101   index--, zero flag unaffected
    jp   nz, for101     ; 3:10      next_101
    ex   DE, HL         ; 1:4       next_101
    pop  DE             ; 1:10      next_101
next101:                ;           next_101
                       ;[16:79] only 65 loop}){}dnl
dnl
dnl
dnl #  5 ?for i . next --> 5 4 3 2 1 0
dnl #  0 ?for i . next --> 0
dnl # -1 ?for i . next -->
dnl # -2 ?for i . next --> -2 -3 -4 ... 2 1 0
dnl # ( index -- ) r: ( -- )
dnl # stop = 0
define({QUESTIONFOR},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   next{}LOOP_STACK        ;           ?for-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           ?for-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_QFOR},{?for_}LOOP_STACK,LOOP_STACK)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_QFOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   index
    ld    A, B          ; 1:4       __INFO
    and   C             ; 1:4       __INFO
    inc   A             ; 1:4       __INFO
    jp    z, next{}$1    ; 3:10      __INFO   ( index -- )
for{}$1:                 ;           __INFO
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index}){}dnl
dnl
dnl
dnl
dnl # ( -- ) r: ( -- )
dnl # stop = 0
define({PUSH_QUESTIONFOR},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameter!},
$#,{1},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   next{}LOOP_STACK        ;           for-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           for-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_QFOR},{$1 ?for_}LOOP_STACK,LOOP_STACK,$1)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_PUSH_QFOR},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__SAVE_EVAL(($2+1) & 0xFFFF),0,{
    jp    next{}$1       ; 3:10      __INFO   ( -- )
for{}$1:                 ;           __INFO},
__{}__IS_MEM_REF($2),{1},{
    ld   BC, format({%-11s},$2); 4:20      __INFO   ( -- )
    ld    A, B          ; 1:4       __INFO
    and   C             ; 1:4       __INFO
    inc   A             ; 1:4       __INFO
    jp    z, next{}$1    ; 3:10      __INFO
for{}$1:                 ;           __INFO
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index},
{
    ld   BC, format({%-11s},$2); 3:10      __INFO   ( -- )
for{}$1:                 ;           __INFO
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index})}){}dnl
dnl
dnl
dnl
dnl # ( -- ) r: ( -- )
dnl # stop = 0
define({PUSH_QUESTIONFOR_I},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameter!},
$#,{1},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   next{}LOOP_STACK        ;           for-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           for-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_QFOR_I},{$1 ?for_}LOOP_STACK{ i_}LOOP_STACK,LOOP_STACK,$1)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_PUSH_QFOR_I},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}ifelse(__SAVE_EVAL(($2+1) & 0xFFFF),0,{
    jp    next{}$1       ; 3:10      __INFO   ( -- )
for{}$1:                 ;           __INFO},
__{}__IS_MEM_REF($2),{1},{
    ld   BC, format({%-11s},$2); 4:20      __INFO   ( -- )
    ld    A, B          ; 1:4       __INFO
    and   C             ; 1:4       __INFO
    inc   A             ; 1:4       __INFO
    jp    z, next{}$1    ; 3:10      __INFO
for{}$1:                 ;           __INFO
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO   copy index},
{
    ld   BC, format({%-11s},$2); 3:10      __INFO   ( -- )
for{}$1:                 ;           __INFO
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO   copy index})}){}dnl
dnl
dnl
dnl
dnl # ( index -- index-1 )
define({NEXT},{dnl
ifelse($#,{0},{dnl
__{}__ADD_TOKEN({__TOKEN_NEXT},{next_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK})},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_NEXT},{dnl
__{}define({__INFO},__COMPILE_INFO)
idx{}$1 EQU $+1          ;           __INFO
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    ld    A, B          ; 1:4       __INFO
    or    C             ; 1:4       __INFO
    dec  BC             ; 1:6       __INFO   index--, zero flag unaffected
    jp   nz, for{}$1     ; 3:10      __INFO
next{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl

define({IF_COUNT},100)dnl
dnl
dnl
dnl
dnl # if
define({IF},{dnl
__{}__ADD_TOKEN({__TOKEN_IF},{if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # else
define({ELSE},{dnl
__{}__ADD_TOKEN({__TOKEN_ELSE},{else},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ELSE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(ELSE_STACK,{ELSE_STACK},{
__{}__{}  .error {ELSE without IF!
         ; M4 FORTH does not support the BEGIN WHILE WHILE UNTIL ELSE THEN construction.
         ; But it supports the identical design BEGIN IF WHILE UNTIL ELSE THEN.}},
__{}{
__{}__{}    jp   format({%-15s},endif{}THEN_STACK); 3:10      __INFO
__{}__{}format({%-24s},else{}ELSE_STACK:);           __INFO{}dnl
__{}__{}popdef({ELSE_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # then
define({THEN},{dnl
__{}__ADD_TOKEN({__TOKEN_THEN},{then},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_THEN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}ifelse(ELSE_STACK, THEN_STACK,{
__{}__{}else{}ELSE_STACK  EQU $          ;           __INFO  = endif{}dnl
__{}__{}popdef({ELSE_STACK})}){}dnl
__{}ifelse(THEN_STACK,{THEN_STACK},{
__{}__{}  .error {THEN for non-existent IF}},
__{}{
__{}__{}format({%-24s},endif{}THEN_STACK:);           __INFO{}dnl
__{}__{}popdef({THEN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( x1 -- x1 )
dnl # dup if
define({DUP_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_IF},{dup if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # over if
define({OVER_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_IF},{over if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, D          ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # swap if
define({SWAP_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_IF},{swap if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, D          ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # num if
define({PUSH_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_IF},{$1 if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
    ld   BC,format({%-12s},$1); 4:20      __INFO
    ld    A, B          ; 1:4       __INFO
    or    C             ; 1:4       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__IS_NUM($1),0,{
__{}__{}  .warning: : The condition is always True or False!
__{}__{}  if (($1)=0)
__{}__{}    jp   format({%-15s},else{}IF_COUNT); 3:10      __INFO
__{}__{}  endif},
__{}__HEX_HL($1),0x0000,{
__{}__{}                        ;[3:10]     __INFO
__{}__{}  .warning: : The condition is always False!
__{}__{}    jp   format({%-15s},else{}IF_COUNT); 3:10      __INFO},
__{}{
__{}__{}                        ;[0:0]      __INFO
__{}__{}  .warning: : The condition is always True!}){}dnl
}){}dnl
dnl
dnl
dnl # ( x -- )
dnl # $1 $2 within if
define({PUSH2_WITHIN_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_WITHIN_IF},{$1 $2 within if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_WITHIN_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}$#,{1},{
__{}__{}  .error {$0}($@): The second parameter is missing!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__{}__{}define({PUSH2_WITHIN_IF_CODE},__WITHIN($1,$2))
__{}__{}                        ;format({%-11s},[eval(5+__WITHIN_B):eval(24+__WITHIN_C)])__INFO   ( {TOS} -- )  true=($1<={TOS}<$2){}dnl
__{}__{}PUSH2_WITHIN_IF_CODE
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO})}){}dnl
dnl
dnl
dnl # dup $1 $2 within if
define({DUP_PUSH2_WITHIN_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH2_WITHIN_IF},{dup $1 $2 within if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH2_WITHIN_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}$#,{1},{
__{}__{}  .error {$0}($@): The second parameter is missing!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__{}__{}define({DUP_PUSH2_WITHIN_IF_CODE},__SAVE_HL_WITHIN($1,$2))
__{}__{}                        ;format({%-11s},[eval(3+__SAVE_HL_WITHIN_B):eval(10+__SAVE_HL_WITHIN_C)])__INFO   ( x -- x )  true=($1<=x<$2){}dnl
__{}__{}DUP_PUSH2_WITHIN_IF_CODE
__{}__{}    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO})}){}dnl
dnl
dnl
dnl
dnl # 2over nip c@ 0 c= if
define({_2OVER_NIP_CFETCH_0CEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_CFETCH_0CEQ_IF},{2over nip c@ 0 c= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_CFETCH_0CEQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse(eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{define({_TMP_INFO},__INFO)
__{}__{}                        ;[7:42]     __INFO   ( addr1 d1 -- addr1 d1 )
__{}__{}    pop  BC             ; 1:10      __INFO   BC = addr1
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO})}){}dnl
dnl
dnl
dnl
dnl # 2over nip c@ 0 c<> if
define({_2OVER_NIP_CFETCH_0CNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_CFETCH_0CNE_IF},{2over nip c@ 0 c<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_CFETCH_0CNE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse(eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{define({_TMP_INFO},__INFO)
__{}__{}                        ;[7:42]     __INFO   ( addr1 d1 -- addr1 d1 )
__{}__{}    pop  BC             ; 1:10      __INFO   BC = addr1
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO})}){}dnl
dnl
dnl
dnl
dnl # 0= if
dnl # ( x1 -- )
define({_0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0EQ_IF},{0= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0EQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[7:32]     __INFO   ( x -- )  flag: x == 0
    ld    A, H          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ( x1 -- x1 )
dnl # dup 0= if
define({DUP_0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0EQ_IF},{dup 0= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0EQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[5:18]     __INFO   ( x -- x )  flag: x == 0
    ld    A, H          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # 0<> if
dnl # ( x1 -- )
define({_0NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0NE_IF},{0<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0NE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[7:32]     __INFO   ( x -- )  flag: x <> 0
    ld    A, H          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ( x1 -- x1 )
dnl # dup 0<> if
define({DUP_0NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0NE_IF},{dup 0<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0NE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[5:18]     __INFO   ( x -- x )  flag: x <> 0
    ld    A, H          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 0< if
dnl # ( x1 -- )
define({_0LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0LT_IF},{0< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0LT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[7:32]     __INFO   ( x -- )  flag: x < 0
    bit   7, H          ; 2:8       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ( x1 -- x1 )
dnl # dup 0< if
define({DUP_0LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0LT_IF},{dup 0< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0LT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[5:18]     __INFO   ( x -- x )  flag: x < 0
    bit   7, H          ; 2:8       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 0> if
dnl # ( x1 -- )
define({_0GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0GT_IF},{0> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0GT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[8:38]     __INFO   ( x -- )  flag: x > 0
    ld    A, H          ; 1:4       __INFO   save sign
    dec  HL             ; 1:6       __INFO   zero to negative
    or    H             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    m, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ( x1 -- x1 )
dnl # dup 0> if
define({DUP_0GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0GT_IF},{dup 0> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0GT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[7:30]     __INFO   ( x -- x )  flag: x > 0
    ld    A, H          ; 1:4       __INFO   save sign
    dec  HL             ; 1:6       __INFO   zero to negative
    or    H             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    jp    m, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 0<= if
dnl # ( x1 -- )
define({_0LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0LE_IF},{0<= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0LE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[8:38]     __INFO   ( x -- )  flag: x <= 0
    ld    A, H          ; 1:4       __INFO   save sign
    dec  HL             ; 1:6       __INFO   zero to negative
    or    H             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    p, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ( x1 -- x1 )
dnl # dup 0<= if
define({DUP_0LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0LE_IF},{dup 0<= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0LE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(1,0,{
__{}                        ;[9:33/20]  __INFO   ( x -- x )  flag: x <= 0
__{}    ld    A, L          ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jr    z, $+7        ; 2:7/12    __INFO
__{}    bit   7, H          ; 2:8       __INFO
__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}{
__{}                        ;[7:30]     __INFO   ( x -- )  flag: x <= 0
__{}    ld    A, H          ; 1:4       __INFO   save sign
__{}    dec  HL             ; 1:6       __INFO   zero to negative
__{}    or    H             ; 1:4       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    jp    p, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # 0>= if
dnl # ( x1 -- )
define({_0GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0GE_IF},{0>= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0GE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[7:32]     __INFO   ( x -- )  flag: x >= 0
    bit   7, H          ; 2:8       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ( x1 -- x1 )
dnl # dup 0>= if
define({DUP_0GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0GE_IF},{dup 0>= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0GE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                        ;[5:18]     __INFO   ( x -- x )  flag: x >= 0
    bit   7, H          ; 2:8       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # -------- signed ---------
dnl # -------- dup num signed cond if ---------
dnl
dnl
dnl # dup const = if
define({DUP_PUSH_EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_EQ_IF},{dup $1 = if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_EQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},{__INFO   ( x1 -- x1 )   $1 == HL}){}dnl
__{}__{}__EQ_MAKE_BEST_CODE($1,3,10,else{}IF_COUNT,0)
__{}__{}_TMP_BEST_CODE
__{}__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl # dup const <> if
define({DUP_PUSH_NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_NE_IF},{dup $1 <> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_NE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},{__INFO   ( x1 -- x1 )   $1 <> HL}){}dnl
__{}__{}__EQ_MAKE_BEST_CODE($1,3,10,3,0)
__{}__{}_TMP_BEST_CODE
__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl # dup const < if
define({DUP_PUSH_LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_LT_IF},{dup $1 < if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_LT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x -- x )  flag: x < $1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing address parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_LT_JP_FALSE($1,else{}IF_COUNT){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const >= if
define({DUP_PUSH_GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_GE_IF},{dup $1 >= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_GE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x -- x )  flag: x >= $1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing address parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_GE_JP_FALSE($1,else{}IF_COUNT){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # dup const <= if
define({DUP_PUSH_LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_LE_IF},{dup $1 <= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_LE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x -- x )  flag: x <= $1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing address parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_LE_JP_FALSE($1,else{}IF_COUNT){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # dup const > if
define({DUP_PUSH_GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_GT_IF},{dup $1 > if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_GT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x -- x )  flag: x > $1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing address parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_GT_JP_FALSE($1,else{}IF_COUNT){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # -------- unsigned ---------
dnl
dnl # dup unum u= if
define({DUP_PUSH_UEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_EQ_IF},{dup $1 u= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UEQ_IF},{dnl
__{}__ASM_TOKEN_DUP_PUSH_EQ_IF($@){}dnl
}){}dnl
dnl
dnl
dnl # dup unum u<> if
define({DUP_PUSH_UNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_NE_IF},{dup $1 u<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UNE_IF},{dnl
__{}__ASM_TOKEN_DUP_PUSH_NE_IF($@){}dnl
}){}dnl
dnl
dnl
dnl # dup 123 u< if
define({DUP_PUSH_ULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ULT_IF},{dup $1 u< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ULT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},{( x -- x ) flag: u<$1}){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_ULT_JP_FALSE($1,else{}IF_COUNT){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # dup 123 u>= if
define({DUP_PUSH_UGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UGE_IF},{dup $1 u>= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UGE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},{( x -- x ) flag: u>=$1}){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_UGE_JP_FALSE($1,else{}IF_COUNT){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # dup 123 u<= if
define({DUP_PUSH_ULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ULE_IF},{dup $1 u<= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ULE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},{( x -- x ) flag: u<=$1}){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_ULE_JP_FALSE($1,else{}IF_COUNT){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # dup 123 u> if
define({DUP_PUSH_UGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UGT_IF},{dup $1 u> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UGT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},{( x -- x ) flag: u>$1}){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_UGT_JP_FALSE($1,else{}IF_COUNT){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ------ 2dup ucond if ---------
dnl
dnl # 2dup u= if
define({_2DUP_UEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_EQ_IF},{2dup u= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UEQ_IF},{dnl
__{}__ASM_TOKEN_2DUP_EQ_IF{}dnl
}){}dnl
dnl
dnl
dnl # 2dup u<> if
define({_2DUP_UNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_NE_IF},{2dup u<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UNE_IF},{dnl
__{}__ASM_TOKEN_2DUP_NE_IF{}dnl
}){}dnl
dnl
dnl
dnl # 2dup u< if
define({_2DUP_ULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_ULT_IF},{2dup u< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_ULT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup u>= if
define({_2DUP_UGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UGE_IF},{2dup u>= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UGE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup u<= if
define({_2DUP_ULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_ULE_IF},{2dup u<= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_ULE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       __INFO    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       __INFO    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       __INFO    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       __INFO    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
define({_2DUP_UGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UGT_IF},{2dup u> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UGT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       __INFO    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       __INFO    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       __INFO    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       __INFO    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ------ 2dup scond if ---------
dnl
dnl # 2dup = if
define({_2DUP_EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_EQ_IF},{2dup = if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_EQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       __INFO
    sub   L             ; 1:4       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO
    ld    A, D          ; 1:4       __INFO
    sub   H             ; 1:4       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup <> if
define({_2DUP_NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_NE_IF},{2dup <> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_NE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       __INFO
    sub   L             ; 1:4       __INFO
    jr   nz, $+7        ; 2:7/12    __INFO
    ld    A, D          ; 1:4       __INFO
    sub   H             ; 1:4       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup < if
define({_2DUP_LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_LT_IF},{2dup < if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_LT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    jp    p, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup >= if
define({_2DUP_GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_GE_IF},{2dup >= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_GE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    jp    m, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup <= if
define({_2DUP_LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_LE_IF},{2dup <= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_LE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       __INFO    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       __INFO    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       __INFO    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       __INFO    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    jp    m, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup > if
define({_2DUP_GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_GT_IF},{2dup > if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_GT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       __INFO    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       __INFO    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       __INFO    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       __INFO    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    jp    p, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ------ ucond if ---------
dnl
dnl # u= if
define({UEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_EQ_IF},{u= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UEQ_IF},{dnl
__{}__ASM_TOKEN_EQ_IF{}dnl
}){}dnl
dnl
dnl
dnl # u<> if
define({UNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_NE_IF},{u<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UNE_IF},{dnl
__{}__ASM_TOKEN_NE_IF{}dnl
}){}dnl
dnl
dnl
dnl # u< if
define({ULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_ULT_IF},{u< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # u>= if
define({UGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_UGE_IF},{u>= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # u<= if
define({ULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_ULE_IF},{u<= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       __INFO    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       __INFO    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       __INFO    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       __INFO    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # u> if
define({UGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_UGT_IF},{u> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       __INFO    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       __INFO    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       __INFO    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       __INFO    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl # ------ scond if ---------
dnl
dnl # = if
define({EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_EQ_IF},{= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_EQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 == x1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}__MAKE_CODE_EQ_DROP_JP_FALSE(else{}IF_COUNT){}dnl
}){}dnl
dnl
dnl
dnl # <> if
define({NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_NE_IF},{<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 <> x1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}__MAKE_CODE_NE_DROP_JP_FALSE(else{}IF_COUNT){}dnl
}){}dnl
dnl
dnl
dnl # < if
define({LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_LT_IF},{< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 < x1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}__MAKE_CODE_LT_DROP_JP_FALSE(else{}IF_COUNT){}dnl
}){}dnl
dnl
dnl
dnl # >= if
define({GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_GE_IF},{>= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 >= x1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}__MAKE_CODE_GE_DROP_JP_FALSE(else{}IF_COUNT){}dnl
}){}dnl
dnl
dnl
dnl # <= if
define({LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_LE_IF},{<= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 <= x1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}__MAKE_CODE_LE_DROP_JP_FALSE(else{}IF_COUNT){}dnl
}){}dnl
dnl
dnl
dnl # > if
define({GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_GT_IF},{> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 > x1){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}__MAKE_CODE_GT_DROP_JP_FALSE(else{}IF_COUNT){}dnl
}){}dnl
dnl
dnl
dnl # ------ push scond if ---------
dnl
dnl # num = if
define({PUSH_EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_EQ_IF},{$1 = if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_EQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_EQ_DROP($1,3,10)
__{}__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # num <> if
define({PUSH_NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_NE_IF},{$1 <> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_NE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_EQ_DROP($1,3,10,3)
__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # num > if
define({PUSH_GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_GT_IF},{$1 > if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_GT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_GT_DROP_JP_FALSE($1,else{}IF_COUNT)}){}dnl
}){}dnl}){}dnl
dnl
dnl
dnl
dnl # num <= if
define({PUSH_LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_LE_IF},{$1 <= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_LE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_LE_DROP_JP_FALSE($1,else{}IF_COUNT)}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # num < if
define({PUSH_LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_LT_IF},{$1 < if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_LT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_LT_DROP_JP_FALSE($1,else{}IF_COUNT)}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # num >= if
define({PUSH_GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_GE_IF},{$1 >= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_GE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_GE_DROP_JP_FALSE($1,else{}IF_COUNT)}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ---------------------------------------------------------------------------
dnl # 8bit
dnl # ---------------------------------------------------------------------------
dnl
dnl
dnl # dup char = if
define({DUP_PUSH_CEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CEQ_IF},{dup $1 c= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CEQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}    ld    A, format({%-11s},$1); 3:13      __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__IS_NUM($1),0,{
__{}    ld    A, __FORM({%-11s},$1); 2:7       __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__SAVE_EVAL($1),0,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__SAVE_EVAL($1),1,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    dec   A             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__SAVE_EVAL($1),255,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    inc   A             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}{
__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup char <> if
define({DUP_PUSH_CNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CNE_IF},{dup $1 c<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CNE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}    ld    A, format({%-11s},$1); 3:13      __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__IS_NUM($1),0,{
__{}    ld    A, __FORM({%-11s},$1); 2:7       __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__SAVE_EVAL($1),0,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__SAVE_EVAL($1),1,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    dec   A             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__SAVE_EVAL($1),255,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    inc   A             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}{
__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # ---------------------------------------------------------------------------
dnl # 32bit
dnl # ---------------------------------------------------------------------------
dnl
dnl
dnl # 0. D= if
dnl # D0= if
dnl # ( d -- )
define({D0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_D0EQ_IF},{d0= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D0EQ_IF},{
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
    ld    A, H          ; 1:4       __INFO   ( d -- )
    or    L             ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # 0. D<> if
dnl # D0<> if
dnl # ( d -- )
define({D0NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_D0NE_IF},{d0<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D0NE_IF},{
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
    ld    A, H          ; 1:4       __INFO   ( d -- )
    or    L             ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl
dnl # 0. D<  if
dnl # D0< if
dnl # ( d -- )
define({D0LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_D0LT_IF},{d0lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D0LT_IF},{dnl
__{}define({__INFO},{d0lt_if}){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    bit   7, D          ; 2:8       D0< if   ( d -- )
    pop  HL             ; 1:10      D0< if
    pop  DE             ; 1:10      D0< if
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      D0< if}){}dnl
dnl
dnl
dnl
dnl
dnl # ----------------------- 32 bit -----------------------
dnl # ------ signed_32_bit_cond if ( d2 d1 -- ) ---------
dnl
dnl
dnl # d= if
dnl # ( d2 d1 -- )
define({DEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DEQ_IF},{d= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DEQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                       ;[14:91]     __INFO   ( d2 d1 -- )  flag: d2 == d1
    pop  BC             ; 1:10      __INFO   lo_2
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      __INFO   hi_2
    jr   nz, $+4        ; 2:7/12    __INFO
    sbc  HL, DE         ; 2:15      __INFO   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # hi lo D=
dnl # ( d -- d )
dnl # equal ( d == (hi<<16)+lo )
define({_2DUP_PUSH2_DEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DEQ_IF},{2dup $1 $2 d= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DEQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
eval((__IS_NUM($1)+__IS_NUM($2))<2),{1},{
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}ifelse(_TYP_DOUBLE:__IS_MEM_REF($2),small:1,{dnl
                        ;[11:60]    __INFO   ( d -- d )   HL == $2
__{}    ld   BC, format({%-11s},$2); 4:20      __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    add  HL, BC         ; 1:11      __INFO   cp HL, BC 
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__IS_MEM_REF($2),1,{dnl
                     ;[14:54/27,54] __INFO   ( d -- d )   HL == $2
__{}    ld    A,format({%-12s},$2); 3:13      __INFO
__{}    cp    L             ; 1:4       __INFO{}ifelse(__IS_NUM($2),1,{   x[1] = __HEX_L($2)})
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO
__{}    ld    A,format({%-12s},($2+1)); 3:13      __INFO
__{}    cp    H             ; 1:4       __INFO{}ifelse(__IS_NUM($2),1,{   x[2] = __HEX_H($2)})
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__IS_NUM($2),0,{dnl
                     ;[12:42/21,42] __INFO   ( d -- d )   HL == $2
__{}    ld    A, format({%-11s},low $2); 2:7       __INFO
__{}    cp    L             ; 1:4       __INFO   x[1] = lo($2)
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO
__{}    ld    A, format({%-11s},high $2); 2:7       __INFO
__{}    cp    H             ; 1:4       __INFO   x[2] = hi($2)
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}{dnl
__{}define({_TMP_STACK_INFO},{__INFO   ( d -- d )   HL == $2}){}dnl
__{}__EQ_MAKE_BEST_CODE($2,3,10,else{}IF_COUNT,0)
__{}_TMP_BEST_CODE
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO})
__{}ifelse(__IS_MEM_REF($1),1,{dnl
                     ;[14:54/27,54] __INFO   ( d -- d )   DE == $1
__{}    ld    A,format({%-12s},$1); 3:13      __INFO
__{}    cp    E             ; 1:4       __INFO{}ifelse(__IS_NUM($1),1,{   x[3] = __HEX_L($1)})
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO
__{}    ld    A,format({%-12s},($1+1)); 3:13      __INFO
__{}    cp    D             ; 1:4       __INFO{}ifelse(__IS_NUM($1),1,{   x[4] = __HEX_H($1)})
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__IS_NUM($1),0,{dnl
                     ;[12:42/21,42] __INFO   ( d -- d )   DE == $1
__{}    ld    A, format({%-11s},low $1); 2:7       __INFO
__{}    cp    E             ; 1:4       __INFO   x[3] = lo($1)
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO
__{}    ld    A, format({%-11s},high $1); 2:7       __INFO
__{}    cp    D             ; 1:4       __INFO   x[4] = hi($1)
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}{dnl
__{}define({_TMP_STACK_INFO},{__INFO   ( d -- d )   DE == $1}){}dnl
__{}__EQ_MAKE_BEST_CODE($1,3,10,else{}IF_COUNT,0){}dnl
__{}define({H},{D}){}define({L},{E}){}_TMP_BEST_CODE{}undefine({H}){}undefine({L})
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO})},
__HEX_HL($1):__HEX_HL($2),0x0000:0x0000,{
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}                        ;format({%-11s},[7:26])__INFO   ( d -- d )  flag: d == 0
__{}    ld    A, D          ; 1:4       __INFO
__{}    or    E             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    or    L             ; 1:4       __INFO
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
{
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({_TMP_STACK_INFO},{ }__INFO{   ( d -- d )  flag: d==$1*65536+$2}){}dnl
__{}__DEQ_MAKE_BEST_CODE(__HEX_DE_HL($1,$2),3,10,0,0){}dnl
__{}_TMP_BEST_CODE
__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # d<> if
dnl # ( d2 d1 -- )
define({DNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DNE_IF},{d<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DNE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                       ;[14:91]     __INFO   ( d2 d1 -- )  flag: d2 <> d1
    pop  BC             ; 1:10      __INFO   lo_2
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      __INFO   hi_2
    jr   nz, $+4        ; 2:7/12    __INFO
    sbc  HL, DE         ; 2:15      __INFO   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # hi lo D<>
dnl # ( d -- d )
dnl # not equal ( d <> (hi<<16)+lo )
define({_2DUP_PUSH2_DNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DNE_IF},{2dup $1 $2 d<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DNE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(eval($#<2),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}eval((__IS_NUM($1)+__IS_NUM($2))<2),{1},{dnl
__{}__{}dnl # -------------------
__{}__{}ifelse(dnl
__{}__{}__IS_MEM_REF($1),1,{define({_TMP_BEST_B},13)},
__{}__{}__IS_NUM($1),0,{define({_TMP_BEST_B},11)},
__{}__{}{dnl
__{}__{}__{}__EQ_MAKE_CODE({DE},$1,3,10,3,0){}dnl
__{}__{}__{}define({_TMP_BEST_B},__EQ_BYTES)}){}dnl
__{}__{}ifelse(dnl
__{}__{}_TYP_DOUBLE:__IS_MEM_REF($2),small:1,{
__{}__{}__{}                        ;[11:60]    __INFO   ( d -- d )   HL <> $2
__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      __INFO
__{}__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   cp HL, BC 
__{}__{}__{}    jr   nz, format({%-11s},$+eval(2+_TMP_BEST_B)); 2:7/12    __INFO},
__{}__{}__IS_MEM_REF($2),1,{
__{}__{}__{}                     ;[12:48/29,53] __INFO   ( d -- d )   HL <> $2
__{}__{}__{}    ld    A,format({%-12s},$2); 3:13      __INFO
__{}__{}__{}    cp    L             ; 1:4       __INFO{}ifelse(__IS_NUM($2),1,{   x[1] = __HEX_L($2)})
__{}__{}__{}    jr   nz, format({%-11s},$+eval(8+_TMP_BEST_B)); 2:7/12    __INFO
__{}__{}__{}    ld    A,format({%-12s},($2+1)); 3:13      __INFO
__{}__{}__{}    cp    H             ; 1:4       __INFO{}ifelse(__IS_NUM($2),1,{   x[2] = __HEX_H($2)})
__{}__{}__{}    jr   nz, format({%-11s},$+eval(2+_TMP_BEST_B)); 2:7/12    __INFO},
__{}__{}__IS_NUM($2),0,{
__{}__{}__{}                     ;[10:36/23,41] __INFO   ( d -- d )   HL <> $2
__{}__{}__{}    ld    A, format({%-11s},low $2); 2:7       __INFO
__{}__{}__{}    cp    L             ; 1:4       __INFO   x[1] = lo($2)
__{}__{}__{}    jr   nz, format({%-11s},$+eval(7+_TMP_BEST_B)); 2:7/12    __INFO
__{}__{}__{}    ld    A, format({%-11s},high $2); 2:7       __INFO
__{}__{}__{}    cp    H             ; 1:4       __INFO   x[2] = hi($2)
__{}__{}__{}    jr   nz, format({%-11s},$+eval(2+_TMP_BEST_B)); 2:7/12    __INFO},
__{}__{}{dnl
__{}__{}__{}define({_TMP_STACK_INFO},{__INFO   ( d -- d )   HL <> $2}){}dnl
__{}__{}__{}define({_TMP_SECOND_B},$+eval(2+_TMP_BEST_B)){}dnl
__{}__{}__{}__EQ_MAKE_BEST_CODE($2,2,7,2+_TMP_BEST_B,0)
__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}    jr   nz, format({%-11s},_TMP_SECOND_B); 2:7/12    __INFO})
__{}__{}ifelse(__IS_MEM_REF($1),1,{dnl
__{}__{} __{}                    ;[13:51/29,51] __INFO   ( d -- d )   DE <> $1
__{}__{} __{}   ld    A,format({%-12s},$1); 3:13      __INFO
__{}__{} __{}   cp    E             ; 1:4       __INFO{}ifelse(__IS_NUM($1),1,{   x[3] = __HEX_L($1)})
__{}__{} __{}   jr   nz, $+9        ; 2:7/12    __INFO
__{}__{} __{}   ld    A,format({%-12s},($1+1)); 3:13      __INFO
__{}__{} __{}   cp    D             ; 1:4       __INFO{}ifelse(__IS_NUM($1),1,{   x[4] = __HEX_H($1)})
__{}__{} __{}   jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__{}__IS_NUM($1),0,{dnl
__{}__{}__{}                     ;[11:39/23,39] __INFO   ( d -- d )   DE <> $1
__{}__{}__{}    ld    A, format({%-11s},low $1); 2:7       __INFO
__{}__{}__{}    cp    E             ; 1:4       __INFO   x[3] = lo($1)
__{}__{}__{}    jr   nz, $+8        ; 2:7/12    __INFO
__{}__{}__{}    ld    A, format({%-11s},high $1); 2:7       __INFO
__{}__{}__{}    cp    D             ; 1:4       __INFO   x[4] = hi($1)
__{}__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__{}{dnl
__{}__{}__{}define({_TMP_STACK_INFO},{__INFO   ( d -- d )   DE <> $1}){}dnl
__{}__{}__{}__EQ_MAKE_CODE({DE},$1,3,10,3,0){}dnl
__{}__{}__{}__EQ_CODE
__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO})},
__{}{dnl
__{}__{}dnl # -------------------
__{}__{}define({_TMP_STACK_INFO},{ }__INFO{   ( d -- d )  flag: d<>__HEX_DE_HL($1,$2)}){}dnl
__{}__{}__DEQ_MAKE_BEST_CODE(__HEX_DE_HL($1,$2),3,10,0,0)
__{}__{}_TMP_BEST_CODE
__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # d< if
dnl # ( d2 d1 -- )
define({DLT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DLT_IF},{d< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DLT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{__def({USE_FCE_DLT})
                       ;[10:67]     __INFO   ( d2 d1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      __INFO   l2
    pop  AF             ; 1:10      __INFO   h2
    call FCE_DLT        ; 3:17      __INFO   carry if true
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
{
                       ;[18:94]     __INFO   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      __INFO   lo_2
    ld    A, C          ; 1:4       __INFO   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       __INFO   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       __INFO   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       __INFO   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      __INFO   hi_2
    ld    A, L          ; 1:4       __INFO   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       __INFO   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       __INFO   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       __INFO   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    rra                 ; 1:4       __INFO                                   --> sign  if true
    xor   H             ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    p, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d< if
dnl # ( d -- d )
define({_2DUP_PUSH2_DLT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DLT_IF},{2dup $1 $2 d< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DLT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- d )  flag: d < $1<<16+$2},3,10,3,0,else{}IF_COUNT,0)
__{}    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # D>= if
dnl # ( d d -- )
define({DGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DGE_IF},{dge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DGE_IF},{dnl
__{}define({__INFO},{dge_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                       ;[10:67]     D>= if   ( d2 d1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D>= if   l2
    pop  AF             ; 1:10      D>= if   h2
    call FCE_DLT        ; 3:17      D>= if   D< carry if true --> D>= carry if false
    pop  HL             ; 1:10      D>= if
    pop  DE             ; 1:10      D>= if
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      D<= if},
{
                       ;[18:94]     D>= if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D>= if   lo_2
    ld    A, C          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sub   L             ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ld    A, B          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    pop  HL             ; 1:10      D>= if   hi_2
    ld    A, L          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, E          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    ld    A, H          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, D          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    rra                 ; 1:4       D>= if                                      --> no sign  if true
    xor   H             ; 1:4       D>= if
    xor   D             ; 1:4       D>= if
    pop  HL             ; 1:10      D>= if
    pop  DE             ; 1:10      D>= if
    jp    m, format({%-11s},else{}IF_COUNT); 3:10      D>= if})}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d>= if
dnl # ( d -- d )
define({_2DUP_PUSH2_DGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DGE_IF},{2dup $1 $2 d>= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DGE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- d )  flag: d >= $1<<16+$2},3,10,else{}IF_COUNT,0,3,0)
__{}    jp    c, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # D<= if
dnl # ( d d -- )
define({DLE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DLE_IF},{dle_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DLE_IF},{dnl
__{}define({__INFO},{dle_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{fast},{
                       ;[18:94]     D<= if   ( d2 d1 -- )   # fast version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<= if   lo_2
    ld    A, L          ; 1:4       D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sub   C             ; 1:4       D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ld    A, H          ; 1:4       D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sbc   A, B          ; 1:4       D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      D<= if   hi_2
    ld    A, E          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, C          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    ld    A, D          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, B          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    rra                 ; 1:4       D<= if                                      --> no sign  if true
    xor   B             ; 1:4       D<= if
    xor   D             ; 1:4       D<= if
    pop  HL             ; 1:10      D<= if
    pop  DE             ; 1:10      D<= if
    jp    m, format({%-11s},else{}IF_COUNT); 3:10      D<= if},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:67]     D<= if   ( d2 d1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<= if   l2
    pop  AF             ; 1:10      D<= if   h2
    call FCE_DGT        ; 3:17      D<= if   D> carry if true --> D<= carry if false
    pop  HL             ; 1:10      D<= if
    pop  DE             ; 1:10      D<= if
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      D<= if},
{
                       ;[18:94]     D<= if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D<= if   lo_2
    or    A             ; 1:4       D<= if
    sbc  HL, BC         ; 2:15      D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      D<= if   hi_2
    ld    A, E          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, C          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    ld    A, D          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, B          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    rra                 ; 1:4       D<= if                                      --> no sign  if true
    xor   B             ; 1:4       D<= if
    xor   D             ; 1:4       D<= if
    pop  HL             ; 1:10      D<= if
    pop  DE             ; 1:10      D<= if
    jp    m, format({%-11s},else{}IF_COUNT); 3:10      D<= if})}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d<= if
dnl # ( d -- d )
define({_2DUP_PUSH2_DLE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DLE_IF},{2dup $1 $2 d<= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DLE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- d )  flag: d <= $1<<16+$2},3,10,else{}IF_COUNT,0,3,0)
__{}    jp    c, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # D> if
dnl # ( d d -- )
define({DGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DGT_IF},{dgt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DGT_IF},{dnl
__{}define({__INFO},{dgt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{fast},{
                       ;[18:94]     D> if   ( d2 d1 -- )   # fast version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D> if   lo_2
    ld    A, L          ; 1:4       D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      D> if   hi_2
    ld    A, E          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    rra                 ; 1:4       D> if                                   --> sign  if true
    xor   B             ; 1:4       D> if
    xor   D             ; 1:4       D> if
    pop  HL             ; 1:10      D> if
    pop  DE             ; 1:10      D> if
    jp    p, format({%-11s},else{}IF_COUNT); 3:10      D> if},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:146]    D> if   ( d2 d1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D> if   l2
    pop  AF             ; 1:10      D> if   h2
    call FCE_DGT        ; 3:17      D> if   carry if true
    pop  HL             ; 1:10      D> if
    pop  DE             ; 1:10      D> if
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      D> if},
{
                       ;[17:97]     D> if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D> if   lo_2
    or    A             ; 1:4       D> if
    sbc  HL, BC         ; 2:15      D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      D> if   hi_2
    ld    A, E          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    rra                 ; 1:4       D> if                                   --> sign  if true
    xor   B             ; 1:4       D> if
    xor   D             ; 1:4       D> if
    pop  HL             ; 1:10      D> if
    pop  DE             ; 1:10      D> if
    jp    p, format({%-11s},else{}IF_COUNT); 3:10      D> if})}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d> if
dnl # ( d -- d )
define({_2DUP_PUSH2_DGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DGT_IF},{2dup $1 $2 d> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DGT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- d )  flag: d > $1<<16+$2},3,10,3,0,else{}IF_COUNT,0)
__{}    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ----------------------- 32 bit -----------------------
dnl # ------ unsigned_32_bit_cond if ( d2 d1 -- ) ---------
dnl
dnl
dnl # Du= if
dnl # ( ud ud -- )
define({DUEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DEQ_IF},{du= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUEQ_IF},{dnl
__{}__ASM_TOKEN_DEQ_IF{}dnl
}){}dnl
dnl
dnl
dnl
dnl # Du<> if
dnl # ( ud ud -- )
define({DUNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DNE_IF},{du<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUNE_IF},{dnl
__{}__ASM_TOKEN_DNE_IF{}dnl
}){}dnl
dnl
dnl
dnl
dnl # Du< if
dnl # ( ud ud -- )
define({DULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DULT_IF},{dult_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DULT_IF},{dnl
__{}define({__INFO},{dult_if}){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                       ;[13:81]     Du< if   ( ud2 ud1 -- )
    pop  BC             ; 1:10      Du< if   lo_2
    ld    A, C          ; 1:4       Du< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       Du< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       Du< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       Du< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      Du< if   hi_2
    sbc  HL, DE         ; 2:15      Du< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    pop  HL             ; 1:10      Du< if
    pop  DE             ; 1:10      Du< if
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      Du< if}){}dnl
dnl
dnl
dnl
dnl # Du>= if
dnl # ( ud ud -- )
define({DUGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUGE_IF},{duge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUGE_IF},{dnl
__{}define({__INFO},{duge_if}){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
                       ;[13:81]     Du>= if   ( ud2 ud1 -- )
    pop  BC             ; 1:10      Du>= if   lo_2
    ld    A, C          ; 1:4       Du>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sub   L             ; 1:4       Du>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ld    A, B          ; 1:4       Du>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       Du>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    pop  HL             ; 1:10      Du>= if   hi_2
    sbc  HL, DE         ; 2:15      Du>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    pop  HL             ; 1:10      Du>= if
    pop  DE             ; 1:10      Du>= if
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      Du>= if}){}dnl
dnl
dnl
dnl
dnl # Du<= if
dnl # ( ud ud -- )
define({DULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DULE_IF},{dule_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DULE_IF},{dnl
__{}define({__INFO},{dule_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{fast},{
                       ;[15:82]     Du<= if   ( ud2 ud1 -- )   # fast version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du<= if   lo_2
    ld    A, L          ; 1:4       Du<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sub   C             ; 1:4       Du<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ld    A, H          ; 1:4       Du<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sbc   A, B          ; 1:4       Du<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      Du<= if   hi_2
    ld    A, E          ; 1:4       Du<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, C          ; 1:4       Du<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    ld    A, D          ; 1:4       Du<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, B          ; 1:4       Du<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    pop  HL             ; 1:10      Du<= if
    pop  DE             ; 1:10      Du<= if
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      Du<= if},
{
                       ;[13:88]     Du<= if   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      Du<= if   lo_2
    or    A             ; 1:4       Du<= if
    sbc  HL, BC         ; 2:15      Du<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      Du<= if   hi_2
    ex   DE, HL         ; 1:4       Du<= if
    sbc  HL, BC         ; 2:15      Du<= if   hi_2<=hi_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  HL             ; 1:10      Du<= if
    pop  DE             ; 1:10      Du<= if
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      Du<= if})}){}dnl
dnl
dnl
dnl
dnl # Du> if
dnl # ( ud ud -- )
define({DUGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUGT_IF},{dugt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUGT_IF},{dnl
__{}define({__INFO},{dugt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{fast},{
                       ;[15:82]     Du> if   ( ud2 ud1 -- )   # fast version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du> if   lo_2
    ld    A, L          ; 1:4       Du> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       Du> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       Du> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       Du> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      Du> if   hi_2
    ld    A, E          ; 1:4       Du> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       Du> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       Du> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       Du> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    pop  HL             ; 1:10      Du> if
    pop  DE             ; 1:10      Du> if
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      Du> if},
{
                       ;[13:88]     Du> if   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      Du> if   lo_2
    or    A             ; 1:4       Du> if
    sbc  HL, BC         ; 2:15      Du> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      Du> if   hi_2
    ex   DE, HL         ; 1:4       Du> if
    sbc  HL, BC         ; 2:15      Du> if   hi_2>hi_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  HL             ; 1:10      Du> if
    pop  DE             ; 1:10      Du> if
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      Du> if})}){}dnl
dnl
dnl
dnl
dnl # ----- 4dup signed_32_bit_cond if ( d2 d1 -- d2 d1 ) -----
dnl
dnl
dnl # 4dup D= if
define({_4DUP_DEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DEQ_IF},{4dup_deq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DEQ_IF},{dnl
__{}define({__INFO},{4dup_deq_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DEQ},,define({USE_FCE_DEQ},{yes}))
                       ;[10:69]     4dup D= if   ( d2 d1 -- d2 d1 )   # function version can be changed with define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup D= if
    pop  AF             ; 1:10      4dup D= if
    push AF             ; 1:11      4dup D= if
    push BC             ; 1:11      4dup D= if
    call FCE_DEQ        ; 3:17      4dup D= if
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      4dup D= if},
{
                   ;[16:132/73,132] 4dup D= if   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= if   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= if   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= if   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= if   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= if   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= if   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= if   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= if   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= if   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= if   h2 l2 . h1 l1
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      4dup D= if   h2 l2 . h1 l1})}){}dnl
dnl
dnl
dnl # 4dup D<> if
define({_4DUP_DNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DNE_IF},{4dup_dne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DNE_IF},{dnl
__{}define({__INFO},{4dup_dne_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DEQ},,define({USE_FCE_DEQ},{yes}))
                       ;[10:69]     4dup D<> if   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{function})" version can be changed with small,fast,default
    pop  BC             ; 1:10      4dup D<> if
    pop  AF             ; 1:10      4dup D<> if
    push AF             ; 1:11      4dup D<> if
    push BC             ; 1:11      4dup D<> if
    call FCE_DEQ        ; 3:17      4dup D<> if   D= zero if true --> D<> zero if false
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      4dup D<> if},
_TYP_DOUBLE,{small},{
                   ;[16:73,132/132] 4dup D<> if   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{small})" version can be changed with function,fast,default
    or   A              ; 1:4       4dup D<> if   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D<> if   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D<> if   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D<> if   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D<> if   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D<> if   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D<> if   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D<> if   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D<> if   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D<> if   h2 l2 . h1 l1
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      4dup D<> if   h2 l2 . h1 l1},
_TYP_DOUBLE,{fast},{
            ;[23:41,56,113,126/126] 4dup D<> if  ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{fast})" version can be changed with function,small,default
    pop  BC             ; 1:10      4dup D<> if   h2    . h1 l1  BC= lo(d2) = l2
    push BC             ; 1:11      4dup D<> if   h2 l2 . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> if   h2 l2 . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> if   h2 l2 . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+19       ; 2:7/12    4dup D<> if   h2 l2 . h1 l1  --> exit
    ld    A, B          ; 1:4       4dup D<> if   h2 l2 . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> if   h2 l2 . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+15       ; 2:7/12    4dup D<> if   h2 l2 . h1 l1  --> exit
    pop  AF             ; 1:10      4dup D<> if   h2    . h1 l1  AF= lo(d2) = l2
    pop  BC             ; 1:10      4dup D<> if         . h1 l1  BC= lo(d2) = h2
    push BC             ; 1:11      4dup D<> if   h2    . h1 l1  BC= lo(d2) = h2
    push AF             ; 1:11      4dup D<> if   h2 l2 . h1 l1  AF= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> if   h2 l2 . h1 l1  A = lo(h2)
    sub   E             ; 1:4       4dup D<> if   h2 l2 . h1 l1  lo(h2) - lo(l1)
    jr   nz, $+7        ; 2:7/12    4dup D<> if   h2 l2 . h1 l1  --> exit
    ld    A, B          ; 1:4       4dup D<> if   h2 l2 . h1 l1  A = hi(h2)
    sub   D             ; 1:4       4dup D<> if   h2 l2 . h1 l1  hi(h2) - hi(h1)
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      4dup D<> if},
{
            ;[21:51,66,123,122/122] 4dup D<> if  ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast,default
    pop  BC             ; 1:10      4dup D<> if   h2    . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> if   h2    . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> if   h2    . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> if   h2    . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> if   h2    . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> if   l1    . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> if   l1    . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> if   l1    . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> if   l1    . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> if   h2    . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> if   h2    . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> if   h2 l2 . h1 l1
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      4dup D<> if})}){}dnl
dnl
dnl
dnl
dnl # 4dup D< if
define({_4DUP_DLT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DLT_IF},{4dup_dlt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DLT_IF},{dnl
__{}define({__INFO},{4dup_dlt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                       ;[10:69]     4dup D< if   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D< if
    pop  AF             ; 1:10      4dup D< if
    push AF             ; 1:11      4dup D< if
    push BC             ; 1:11      4dup D< if
    call FCE_DLT        ; 3:17      4dup D< if   carry if true
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      4dup D< if},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:27]     4dup D< if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< if   carry if true
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      4dup D< if})}){}dnl
dnl
dnl
dnl
dnl # 4dup D>= if
define({_4DUP_DGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DGE_IF},{4dup_dge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DGE_IF},{dnl
__{}define({__INFO},{4dup_dge_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                       ;[10:69]     4dup D>= if   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D>= if
    pop  AF             ; 1:10      4dup D>= if
    push AF             ; 1:11      4dup D>= if
    push BC             ; 1:11      4dup D>= if
    call FCE_DLT        ; 3:17      4dup D>= if   D< carry if true --> D>= carry if false
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      4dup D>= if},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:27]     4dup D>= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= if   D< carry if true --> D>= carry if false
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      4dup D>= if})}){}dnl
dnl
dnl
dnl
dnl # 4dup D<= if
define({_4DUP_DLE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DLE_IF},{4dup_dle_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DLE_IF},{dnl
__{}define({__INFO},{4dup_dle_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:69]     4dup D<= if   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D<= if
    pop  AF             ; 1:10      4dup D<= if
    push AF             ; 1:11      4dup D<= if
    push BC             ; 1:11      4dup D<= if
    call FCE_DGT        ; 3:17      4dup D<= if   D> carry if true --> D<= carry if false
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      4dup D<= if},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:27]     4dup D<= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= if   D> carry if true --> D<= carry if false
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      4dup D<= if})}){}dnl
dnl
dnl
dnl
dnl # 4dup D> if
define({_4DUP_DGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DGT_IF},{4dup_dgt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DGT_IF},{dnl
__{}define({__INFO},{4dup_dgt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:69]     4dup D> if   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D> if
    pop  AF             ; 1:10      4dup D> if
    push AF             ; 1:11      4dup D> if
    push BC             ; 1:11      4dup D> if
    call FCE_DGT        ; 3:17      4dup D> if   carry if true
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      4dup D> if},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:27]     4dup D> if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> if   carry if true
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      4dup D> if})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl # ----- 4dup unsigned_32_bit_cond if ( ud2 ud1 -- ud2 ud1 ) -----
dnl
dnl
dnl # 4dup Du= if
define({_4DUP_DUEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DEQ_IF},{4dup du= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUEQ_IF},{dnl
__{}__ASM_TOKEN_4DUP_DEQ_IF{}dnl
}){}dnl
dnl
dnl
dnl # 4dup Du<> if
define({_4DUP_DUNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DNE_IF},{4dup du<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUNE_IF},{dnl
__{}__ASM_TOKEN_4DUP_DNE_IF{}dnl
}){}dnl
dnl
dnl
dnl
dnl # 4dup Du< if
define({_4DUP_DULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DULT_IF},{4dup_dult_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DULT_IF},{dnl
__{}define({__INFO},{4dup_dult_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:69]     4dup Du< if   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du< if
    pop  AF             ; 1:10      4dup Du< if
    push AF             ; 1:11      4dup Du< if
    push BC             ; 1:11      4dup Du< if
    call FCE_DULT       ; 3:17      4dup Du< if   carry if true
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      4dup Du< if},
{
                       ;[15:101]    4dup Du< if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du< if   ud2 < ud1 --> ud2-ud1<0 --> (SP)BC-DEHL<0 --> carry if true
    ld    A, C          ; 1:4       4dup Du< if
    sub   L             ; 1:4       4dup Du< if   C-L<0 --> carry if true
    ld    A, B          ; 1:4       4dup Du< if
    sbc   A, H          ; 1:4       4dup Du< if   B-H<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< if   HL = hi2
    ld    A, L          ; 1:4       4dup Du< if   HLBC-DE(SP)<0 -- carry if true
    sbc   A, E          ; 1:4       4dup Du< if   L-E<0 --> carry if true
    ld    A, H          ; 1:4       4dup Du< if
    sbc   A, D          ; 1:4       4dup Du< if   H-D<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< if
    push BC             ; 1:11      4dup Du< if
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      4dup Du< if})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du>= if
define({_4DUP_DUGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUGE_IF},{4dup_duge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUGE_IF},{dnl
__{}define({__INFO},{4dup_duge_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:69]     4dup Du>= if   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du>= if
    pop  AF             ; 1:10      4dup Du>= if
    push AF             ; 1:11      4dup Du>= if
    push BC             ; 1:11      4dup Du>= if
    call FCE_DULT       ; 3:17      4dup Du>= if   D< carry if true --> D>= carry if false
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      4dup Du>= if},
{
                       ;[15:101]    4dup Du>= if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du>= if   ud2 >= ud1 --> ud2-ud1>=0 --> (SP)BC-DEHL>=0 --> no carry if true
    ld    A, C          ; 1:4       4dup Du>= if
    sub   L             ; 1:4       4dup Du>= if   C-L>=0 --> no carry if true
    ld    A, B          ; 1:4       4dup Du>= if
    sbc   A, H          ; 1:4       4dup Du>= if   B-H>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= if   HL = hi2
    ld    A, L          ; 1:4       4dup Du>= if   HLBC-DE(SP)>=0 -- no carry if true
    sbc   A, E          ; 1:4       4dup Du>= if   L-E>=0 --> no carry if true
    ld    A, H          ; 1:4       4dup Du>= if
    sbc   A, D          ; 1:4       4dup Du>= if   H-D>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= if
    push BC             ; 1:11      4dup Du>= if
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      4dup Du>= if})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du<= if
define({_4DUP_DULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DULE_IF},{4dup_dule_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DULE_IF},{dnl
__{}define({__INFO},{4dup_dule_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:69]     4dup Du<= if   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du<= if
    pop  AF             ; 1:10      4dup Du<= if
    push AF             ; 1:11      4dup Du<= if
    push BC             ; 1:11      4dup Du<= if
    call FCE_DUGT       ; 3:17      4dup Du<= if   D> carry if true --> D<= carry if false
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      4dup Du<= if},
{
                       ;[15:101]    4dup Du<= if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du<= if   ud2 <= ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> no carry if true
    ld    A, L          ; 1:4       4dup Du<= if
    sub   C             ; 1:4       4dup Du<= if   0<=L-C --> no carry if true
    ld    A, H          ; 1:4       4dup Du<= if
    sbc   A, B          ; 1:4       4dup Du<= if   0<=H-B --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= if   HL = hi2
    ld    A, E          ; 1:4       4dup Du<= if   0<=DE(SP)-HLBC -- no carry if true
    sbc   A, L          ; 1:4       4dup Du<= if   0<=E-L --> no carry if true
    ld    A, D          ; 1:4       4dup Du<= if
    sbc   A, H          ; 1:4       4dup Du<= if   0<=D-H --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= if
    push BC             ; 1:11      4dup Du<= if
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      4dup Du<= if})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du> if
define({_4DUP_DUGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUGT_IF},{4dup_dugt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUGT_IF},{dnl
__{}define({__INFO},{4dup_dugt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:69]     4dup Du> if   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du> if
    pop  AF             ; 1:10      4dup Du> if
    push AF             ; 1:11      4dup Du> if
    push BC             ; 1:11      4dup Du> if
    call FCE_DUGT       ; 3:17      4dup Du> if   carry if true
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      4dup Du> if},
{
                       ;[15:101]    4dup Du> if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du> if   ud2 > ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> carry if true
    ld    A, L          ; 1:4       4dup Du> if
    sub   C             ; 1:4       4dup Du> if   0>L-C --> carry if true
    ld    A, H          ; 1:4       4dup Du> if
    sbc   A, B          ; 1:4       4dup Du> if   0>H-B --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> if   HL = hi2
    ld    A, E          ; 1:4       4dup Du> if   0>DE(SP)-HLBC -- carry if true
    sbc   A, L          ; 1:4       4dup Du> if   0>E-L --> carry if true
    ld    A, D          ; 1:4       4dup Du> if
    sbc   A, H          ; 1:4       4dup Du> if   0>D-H --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> if
    push BC             ; 1:11      4dup Du> if
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      4dup Du> if})}){}dnl
dnl
dnl
dnl
dnl # +============================ 32 bit ===============================+
dnl # |         2dup pushdot signed_32_bit_cond if ( ud1 -- ud1 )         |
dnl # +===================================================================+
dnl
dnl
dnl
dnl # 2dup 0 0 D= if
dnl # 2dup 0. D= if
dnl # 2dup D0= if
dnl # ( d -- d )
define({_2DUP_D0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0EQ_IF},{2dup d0= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0EQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       __INFO  ( d -- d )
    or    L             ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # 2dup 0 0 d<> if
dnl # 2dup 0. d<> if
dnl # 2dup d0<> if
dnl # ( d -- d )
define({_2DUP_D0NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0NE_IF},{2dup d0<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0NE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       __INFO  ( d -- d )
    or    L             ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    or    E             ; 1:4       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # 2dup 0 0 D< if
dnl # 2dup 0. D< if
dnl # 2dup D0< if
dnl # ( d -- d )
define({_2DUP_D0LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0LT_IF},{2dup_d0lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0LT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    bit   7, D          ; 2:8       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # 2dup 0 0 D>= if
dnl # 2dup 0. D>= if
dnl # 2dup D0>= if
dnl # ( d -- d )
define({_2DUP_D0GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0GE_IF},{2dup_d0ge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0GE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    bit   7, D          ; 2:8       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl
dnl # 2dup D. D= if
dnl # ( d -- d )
define({_2DUP_PUSHDOT_DEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DEQ_IF},{2dup_pushdot_deq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DEQ_IF},{dnl
__{}define({__INFO},{2dup_pushdot_deq_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}define({_TMP_INFO},{2dup $1 D= if}){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 )   __HEX_DEHL($1) == DEHL}){}dnl
__{}ifelse($1,{},{
__{}__{}    .error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                        ;[19:108]   _TMP_INFO    ( d1 -- d1 )   (addr) == DEHL
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO   lo16(d1)-BC
__{}__{}__{}    jp   nz, $+7        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL,format({%-12s},($1+2)); 3:16      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL, DE         ; 2:15      _TMP_INFO   HL-hi16(d1)
__{}__{}__{}    pop  HL             ; 1:10      _TMP_INFO
__{}__{}__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      _TMP_INFO},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__{}__DEQ_MAKE_BEST_CODE($1,3,10,0,0){}dnl
__{}__{}__{}__DEQ_MAKE_HL_CODE($1,0,0){}dnl
__{}__{}__{}define({_TMP_B},eval(_TMP_B+3)){}dnl
__{}__{}__{}define({_TMP_J},eval(_TMP_J+10)){}dnl
__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_P},eval(8*_TMP_NJ+4*_TMP_J+4*_TMP_J2+64*_TMP_B)){}dnl #     price = 16*(clocks + 4*bytes)
__{}__{}__{}ifelse(ifelse(_TYP_DOUBLE,{small},{eval((_TMP_BEST_B<_TMP_B) || ((_TMP_BEST_B==_TMP_B) && (_TMP_BEST_P<_TMP_P)))},{eval(_TMP_BEST_P<=_TMP_P)}),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      _TMP_INFO   price: _TMP_BEST_P},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[_TMP_B:_TMP_NJ/_TMP_J,_TMP_J2] _TMP_INFO   ( d1 -- d1 )_TMP_HL_CODE
__{}__{}__{}__{}    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      _TMP_INFO   price: _TMP_P})})},
__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # obsolete, use 2dup push2 dne if
dnl # 2dup D. D<> if
dnl # ( d -- d )
define({_2DUP_PUSHDOT_DNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DNE_IF},{2dup $1 D<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DNE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({_TMP_STACK_INFO},{__INFO   ( d1 -- d1 )   __HEX_DEHL($1) <> DEHL}){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}__{}                        ;[19:108]   __INFO    ( d1 -- d1 )   (addr) == DEHL
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   lo16($1)
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   lo16(d1)-BC
__{}__{}    jp   nz, $+7        ; 2:7/12    __INFO
__{}__{}    ld   HL,format({%-12s},($1+2)); 3:16      __INFO   hi16($1)
__{}__{}    sbc  HL, DE         ; 2:15      __INFO   HL-hi16(d1)
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO},
__{}__IS_NUM($1),0,{
__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__DEQ_MAKE_BEST_CODE($1,3,10,3,-10){}dnl
__{}__{}__DEQ_MAKE_HL_CODE($1,3,-10){}dnl
__{}__{}define({_TMP_B},eval(_TMP_B+3)){}dnl
__{}__{}define({_TMP_J},eval(_TMP_J+10)){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_NJ+10)){}dnl
__{}__{}define({_TMP_NJ},eval(_TMP_NJ+10)){}dnl
__{}__{}define({_TMP_P},eval(8*_TMP_J2+4*_TMP_NJ+4*_TMP_J+64*_TMP_B)){}dnl #     price = 16*(clocks + 4*bytes)
__{}__{}ifelse(ifelse(_TYP_DOUBLE,{small},{eval((_TMP_BEST_B<_TMP_B) || ((_TMP_BEST_B==_TMP_B) && (_TMP_BEST_P<_TMP_P)))},{eval(_TMP_BEST_P<=_TMP_P)}),1,{
__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO   price: _TMP_BEST_P},
__{}__{}{
__{}__{}__{}                     ;[_TMP_B:_TMP_J,_TMP_NJ/_TMP_J2] __INFO   ( d1 -- d1 )_TMP_HL_CODE
__{}__{}__{}    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO   price: _TMP_P})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl
dnl # ----------------------- pointer to 32 bit -----------------------
dnl
dnl
dnl
dnl # flag: [pd] == 0
dnl # ( pd -- pd )
define({PD0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PD0EQ_IF},{pd0= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PD0EQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A,(HL)        ; 1:7       __INFO   ( pd1 -- pd1 )  with align 4
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # flag: [pd] <> 0
dnl # ( pd -- pd )
define({PD0NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PD0NE_IF},{pd0<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PD0NE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A,(HL)        ; 1:7       __INFO   ( pd1 -- pd1 )  with align 4
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    or  (HL)            ; 1:7       __INFO
    ld    L, C          ; 1:4       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # flag: [pd2] == [pd1]
dnl # ( pd2 pd1 -- pd2 pd1 )
define({PDEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PDEQ_IF},{pd= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDEQ_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  with align 4
    xor (HL)            ; 1:7       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO
    ld    B, E          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+12       ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+6        ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    ld    E, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    jp   nz, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # flag: [pd2] <> [pd1]
dnl # ( pd2 pd1 -- pd2 pd1 )
define({PDNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PDNE_IF},{pd<> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDNE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  with align 4
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+25       ; 2:7/12    __INFO
    ld    B, E          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+12       ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    jr   nz, $+6        ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    xor (HL)            ; 1:7       __INFO
    ld    E, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    jp    z, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # flag: [pd2] < [pd1]
dnl # flag: [pd2] - [pd1] < 0  --> not carry if false
dnl # ( pd2 pd1 -- pd2 pd1 )
define({PDULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PDULT_IF},{pdu< if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDULT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  with align 4
    sub (HL)            ; 1:7       __INFO
    ld    B, E          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO   not carry if false
    ld    E, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # flag: [pd2] >= [pd1]
dnl # flag: [pd2] - [pd1] >= 0 --> carry if false
dnl # ( pd2 pd1 -- pd2 pd1 )
dnl # ( pd2 pd1 -- pd2 pd1 )
define({PDUGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PDUGE_IF},{pdu>= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDUGE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  with align 4
    sub (HL)            ; 1:7       __INFO
    ld    B, E          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO   carry if false
    ld    E, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # flag: [pd2] > [pd1]
dnl # flag: [pd2] - [pd1] > 0
dnl # flag: [pd2] - [pd1] - 1 >= 0
dnl # ( pd2 pd1 -- pd2 pd1 )
define({PDUGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PDUGT_IF},{pdu> if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDUGT_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    scf                 ; 1:4       __INFO   ( pd2 pd1 -- pd2 pd1 )  with align 4
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld    B, E          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO   carry if false
    ld    E, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    jp    c, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # flag: [pd2] <= [pd1]
dnl # flag: [pd2] - [pd1] <= 0
dnl # flag: [pd2] - [pd1] - 1 < 0
dnl # ( pd2 pd1 -- pd2 pd1 )
define({PDULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PDULE_IF},{pdu<= if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDULE_IF},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    scf                 ; 1:4       __INFO   ( pd2 pd1 -- pd2 pd1 )  with align 4
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld    B, E          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc   E             ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO   not carry if false
    ld    E, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    jp   nc, format({%-11s},else{}IF_COUNT); 3:10      __INFO}){}dnl
dnl
dnl
dnl

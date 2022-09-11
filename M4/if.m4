define({IF_COUNT},100)dnl
dnl
dnl
dnl
define({IF},{dnl
__{}__ADD_TOKEN({__TOKEN_IF},{if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_IF},{dnl
__{}define({__INFO},{if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else{}IF_COUNT    ; 3:10      if}){}dnl
dnl
dnl
dnl
define({ELSE},{dnl
__{}__ADD_TOKEN({__TOKEN_ELSE},{else},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ELSE},{dnl
__{}define({__INFO},{else}){}dnl
ifelse(ELSE_STACK,{ELSE_STACK},{
    .error {ELSE without IF!
    M4 FORTH does not support the BEGIN WHILE WHILE UNTIL ELSE THEN construction. But it supports the identical design BEGIN IF WHILE UNTIL ELSE THEN.}})
    jp   endif{}THEN_STACK       ; 3:10      else
else{}ELSE_STACK:popdef({ELSE_STACK}){}dnl
}){}dnl
dnl
dnl
define({THEN},{dnl
__{}__ADD_TOKEN({__TOKEN_THEN},{then},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_THEN},{dnl
__{}define({__INFO},{then}){}dnl
dnl
__{}ifelse(ELSE_STACK, THEN_STACK,{
__{}__{}else{}ELSE_STACK  EQU $          ;           = endif{}popdef({ELSE_STACK})}){}dnl
__{}ifelse(THEN_STACK,{THEN_STACK},{
__{}__{}.error {THEN for non-existent IF}},
__{}{
__{}__{}endif{}THEN_STACK:{}popdef({THEN_STACK})})}){}dnl
dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup if
define({DUP_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_IF},{dup_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_IF},{dnl
__{}define({__INFO},{dup_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup if
    or    L             ; 1:4       dup if
    jp    z, else{}IF_COUNT    ; 3:10      dup if}){}dnl
dnl
dnl
dnl over if
define({OVER_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_IF},{over_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_IF},{dnl
__{}define({__INFO},{over_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, D          ; 1:4       over if
    or    E             ; 1:4       over if
    jp    z, else{}IF_COUNT    ; 3:10      over if}){}dnl
dnl
dnl
define({SWAP_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_IF},{swap_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_IF},{dnl
__{}define({__INFO},{swap_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, D          ; 1:4       swap if
    or    E             ; 1:4       swap if
    pop  DE             ; 1:10      swap if
    jp    z, else{}IF_COUNT    ; 3:10      swap if}){}dnl
dnl
dnl
dnl # ( x -- )
dnl # $1 $2 within if
define({PUSH2_WITHIN_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_WITHIN_IF},{push2_within_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_WITHIN_IF},{dnl
__{}define({__INFO},{push2_within_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}eval($#>2),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}__{}define({_TMP_INFO},{$1 $2 within if}){}dnl
__{}__{}__{}define({PUSH2_WITHIN_IF_CODE},__WITHIN($1,$2))
__{}__{}                        ;format({%-11s},[eval(5+__WITHIN_B):eval(24+__WITHIN_C)])_TMP_INFO   ( {TOS} -- )  true=($1<={TOS}<$2){}dnl
__{}__{}PUSH2_WITHIN_IF_CODE
__{}__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}__{}    pop  DE             ; 1:10      _TMP_INFO
__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl # dup $1 $2 within if
define({DUP_PUSH2_WITHIN_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH2_WITHIN_IF},{dup_push2_within_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH2_WITHIN_IF},{dnl
__{}define({__INFO},{dup_push2_within_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}eval($#>2),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}__{}define({_TMP_INFO},{dup $1 $2 within if}){}dnl
__{}__{}__{}define({DUP_PUSH2_WITHIN_IF_CODE},__SAVE_HL_WITHIN($1,$2))
__{}__{}                        ;format({%-11s},[eval(3+__SAVE_HL_WITHIN_B):eval(10+__SAVE_HL_WITHIN_C)])_TMP_INFO   ( x -- x )  true=($1<=x<$2){}dnl
__{}__{}DUP_PUSH2_WITHIN_IF_CODE
__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl # 2over nip c@ 0 c= if
define({_2OVER_NIP_CFETCH_0CEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_CFETCH_0CEQ_IF},{2over_nip_cfetch_0ceq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_CFETCH_0CEQ_IF},{dnl
__{}define({__INFO},{2over_nip_cfetch_0ceq_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse(eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{define({_TMP_INFO},{2over nip c@ 0 c= if})
__{}__{}                        ;[7:42]     _TMP_INFO   ( addr1 d1 -- addr1 d1 )
__{}__{}    pop  BC             ; 1:10      _TMP_INFO   BC = addr1
__{}__{}    push BC             ; 1:11      _TMP_INFO
__{}__{}    ld    A,(BC)        ; 1:7       _TMP_INFO
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl # 2over nip c@ 0 c<> if
define({_2OVER_NIP_CFETCH_0CNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_CFETCH_0CNE_IF},{2over_nip_cfetch_0cne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_CFETCH_0CNE_IF},{dnl
__{}define({__INFO},{2over_nip_cfetch_0cne_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse(eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{define({_TMP_INFO},{2over nip c@ 0 c<> if})
__{}__{}                        ;[7:42]     _TMP_INFO   ( addr1 d1 -- addr1 d1 )
__{}__{}    pop  BC             ; 1:10      _TMP_INFO   BC = addr1
__{}__{}    push BC             ; 1:11      _TMP_INFO
__{}__{}    ld    A,(BC)        ; 1:7       _TMP_INFO
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl 0= if
dnl ( x1 -- )
define({_0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0EQ_IF},{0eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0EQ_IF},{dnl
__{}define({__INFO},{0eq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else{}IF_COUNT    ; 3:10      0= if}){}dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0= if
define({DUP_0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0EQ_IF},{dup_0eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0EQ_IF},{dnl
__{}define({__INFO},{dup_0eq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else{}IF_COUNT    ; 3:10      dup 0= if}){}dnl
dnl
dnl
dnl 0< if
dnl ( x1 -- )
define({_0LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0LT_IF},{0lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0LT_IF},{dnl
__{}define({__INFO},{0lt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       0< if
    ex   DE, HL         ; 1:4       0< if
    pop  DE             ; 1:10      0< if
    jp    z, else{}IF_COUNT    ; 3:10      0< if}){}dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0< if
define({DUP_0LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0LT_IF},{dup_0lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0LT_IF},{dnl
__{}define({__INFO},{dup_0lt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       dup 0< if
    jp    z, else{}IF_COUNT    ; 3:10      dup 0< if}){}dnl
dnl
dnl
dnl 0>= if
dnl ( x1 -- )
define({_0GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_0GE_IF},{0ge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0GE_IF},{dnl
__{}define({__INFO},{0ge_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       0>= if
    ex   DE, HL         ; 1:4       0>= if
    pop  DE             ; 1:10      0>= if
    jp   nz, else{}IF_COUNT    ; 3:10      0>= if}){}dnl
dnl
dnl
dnl ( x1 -- x1 )
dnl dup 0>= if
define({DUP_0GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0GE_IF},{dup_0ge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0GE_IF},{dnl
__{}define({__INFO},{dup_0ge_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, H          ; 2:8       dup 0>= if
    jp   nz, else{}IF_COUNT    ; 3:10      dup 0>= if}){}dnl
dnl
dnl
dnl ( x1 x2 -- x1 x2 )
dnl 2dup D0= if
define({_2DUP_D0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0EQ_IF},{2dup_d0eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0EQ_IF},{dnl
__{}define({__INFO},{2dup_d0eq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup D0= if
    or    L             ; 1:4       2dup D0= if
    or    D             ; 1:4       2dup D0= if
    or    E             ; 1:4       2dup D0= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup D0= if}){}dnl
dnl
dnl
dnl -------- signed ---------
dnl
dnl
dnl
dnl # dup const = if
define({DUP_PUSH_EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_EQ_IF},{dup_push_eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_EQ_IF},{dnl
__{}define({__INFO},{dup_push_eq_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}define({_TMP_INFO},{dup $1 = if}){}dnl
__{}__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( x1 -- x1 )   $1 == HL}){}dnl
__{}__{}__EQ_MAKE_BEST_CODE($1,3,10,else{}IF_COUNT,0)
__{}__{}_TMP_BEST_CODE
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl # dup const <> if
define({DUP_PUSH_NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_NE_IF},{dup_push_ne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_NE_IF},{dnl
__{}define({__INFO},{dup_push_ne_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}{dnl
__{}__{}define({_TMP_INFO},{dup $1 <> if}){}dnl
__{}__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( x1 -- x1 )   $1 <> HL}){}dnl
__{}__{}__EQ_MAKE_BEST_CODE($1,3,10,3,-10)
__{}__{}_TMP_BEST_CODE
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl dup const < if
define({DUP_PUSH_LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_LT_IF},{dup_push_lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_LT_IF},{dnl
__{}define({__INFO},{dup_push_lt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[14:58]    dup $1 < if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 < if
__{}__{}    ld    A, L          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    sub   C             ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    ld    A, H          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    sbc   A, B          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    rra                 ; 1:4       dup $1 < if
__{}__{}    xor   H             ; 1:4       dup $1 < if
__{}__{}    xor   B             ; 1:4       dup $1 < if
__{}__{}    jp    p, else{}IF_COUNT    ; 3:10      dup $1 < if},
__{}{dnl
__{}__{}    ld    A, H          ; 1:4       dup $1 < if
__{}__{}    add   A, A          ; 1:4       dup $1 < if
__{}__{}__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}__{}  .warning {$0}($@): The condition "$1" cannot be evaluated
__{}__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}__{}    jr c, $+11
__{}__{}__{}  else
__{}__{}__{}    jp   nc, else{}IF_COUNT
__{}__{}__{}  endif},
__{}__{}__{}eval(($1)>=0x8000 || ($1)<0),{0},{dnl
__{}__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 < if    negative HL < positive constant ---> true},
__{}__{}__{}{dnl
__{}__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 < if    positive HL < negative constant ---> false})
__{}__{}    ld    A, L          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    sub   low __FORM({%-10s},$1); 2:7       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    ld    A, H          ; 1:4       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    sbc   A, high __FORM({%-6s},$1); 2:7       dup $1 < if    HL<$1 --> HL-$1<0 --> carry if true
__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 < if})}){}dnl
dnl
dnl
dnl
dnl dup const >= if
define({DUP_PUSH_GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_GE_IF},{dup_push_ge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_GE_IF},{dnl
__{}define({__INFO},{dup_push_ge_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[14:58]    dup $1 >= if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 >= if
__{}__{}    ld    A, L          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    sub   C             ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    ld    A, H          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    sbc   A, B          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    rra                 ; 1:4       dup $1 >= if
__{}__{}    xor   H             ; 1:4       dup $1 >= if
__{}__{}    xor   B             ; 1:4       dup $1 >= if
__{}__{}    jp    m, else{}IF_COUNT    ; 3:10      dup $1 >= if},
__{}{dnl
__{}__{}    ld    A, H          ; 1:4       dup $1 >= if
__{}__{}    add   A, A          ; 1:4       dup $1 >= if
__{}__{}__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}__{}  .warning {$0}($@): The condition "$1" cannot be evaluated
__{}__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}__{}    jp c, else{}IF_COUNT
__{}__{}__{}  else
__{}__{}__{}    jr   nc, $+11
__{}__{}__{}  endif},
__{}__{}__{}eval(($1)>=0x8000 || ($1)<0),{0},{dnl
__{}__{}__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if    negative HL >= positive constant ---> false},
__{}__{}__{}{dnl
__{}__{}__{}    jr   nc, $+11       ; 2:7/12    dup $1 >= if    positive HL >= negative constant ---> true})
__{}__{}    ld    A, L          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    sub   low __FORM({%-10s},$1); 2:7       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    ld    A, H          ; 1:4       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    sbc   A, high __FORM({%-6s},$1); 2:7       dup $1 >= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 >= if})}){}dnl
dnl
dnl
dnl dup const <= if
define({DUP_PUSH_LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_LE_IF},{dup_push_le_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_LE_IF},{dnl
__{}define({__INFO},{dup_push_le_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[14:58]    dup $1 <= if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 <= if
__{}__{}    ld    A, C          ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    sub   L             ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    ld    A, B          ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    sbc   A, H          ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    rra                 ; 1:4       dup $1 <= if
__{}__{}    xor   H             ; 1:4       dup $1 <= if
__{}__{}    xor   B             ; 1:4       dup $1 <= if
__{}__{}    jp    m, else{}IF_COUNT    ; 3:10      dup $1 <= if},
__{}{dnl
__{}__{}    ld    A, H          ; 1:4       dup $1 <= if
__{}__{}    add   A, A          ; 1:4       dup $1 <= if
__{}__{}__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}__{}  .warning {$0}($@): The condition "$1" cannot be evaluated
__{}__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}__{}    jr c, $+11
__{}__{}__{}  else
__{}__{}__{}    jp   nc, else{}IF_COUNT
__{}__{}__{}  endif},
__{}__{}__{}eval(($1)>=0x8000 || ($1)<0),{0},{dnl
__{}__{}__{}    jr    c, $+11       ; 2:7/12    dup $1 <= if    negative HL <= positive constant ---> true},
__{}__{}__{}{dnl
__{}__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 <= if    positive HL <= negative constant ---> false})
__{}__{}    ld    A, ifelse(__IS_MEM_REF($1),{1},{format({%-11s},$1); 3:13},{low __FORM({%-7s},$1); 2:7 })      dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    sub   L             ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    ld    A, ifelse(__IS_MEM_REF($1),{1},{(format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13},{high __FORM({%-6s},$1); 2:7 })      dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    sbc   A, H          ; 1:4       dup $1 <= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 <= if})}){}dnl
dnl
dnl
dnl dup const > if
define({DUP_PUSH_GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_GT_IF},{dup_push_gt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_GT_IF},{dnl
__{}define({__INFO},{dup_push_gt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[14:58]    dup $1 > if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 > if
__{}__{}    ld    A, C          ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    sub   L             ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    ld    A, B          ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    sbc   A, H          ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    rra                 ; 1:4       dup $1 > if
__{}__{}    xor   H             ; 1:4       dup $1 > if
__{}__{}    xor   B             ; 1:4       dup $1 > if
__{}__{}    jp    p, else{}IF_COUNT    ; 3:10      dup $1 > if},
__{}{dnl
__{}__{}    ld    A, H          ; 1:4       dup $1 > if
__{}__{}    add   A, A          ; 1:4       dup $1 > if
__{}__{}__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}__{}  .warning {$0}($@): The condition "$1" cannot be evaluated
__{}__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}__{}    jp c, else{}IF_COUNT
__{}__{}__{}  else
__{}__{}__{}    jr   nc, $+11
__{}__{}__{}  endif},
__{}__{}__{}eval(($1)>=0x8000 || ($1)<0),{0},{dnl
__{}__{}__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 > if    negative HL > positive constant ---> false},
__{}__{}__{}{dnl
__{}__{}__{}    jr   nc, $+11       ; 2:7/12    dup $1 > if    positive HL > negative constant ---> true})
__{}__{}    ld    A, ifelse(__IS_MEM_REF($1),{1},{format({%-11s},$1); 3:13},{low __FORM({%-7s},$1); 2:7 })      dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    sub   L             ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    ld    A, ifelse(__IS_MEM_REF($1),{1},{(format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13},{high __FORM({%-6s},$1); 2:7 })      dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    sbc   A, H          ; 1:4       dup $1 > if    HL>$1 --> 0>$1-HL --> carry if true
__{}__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 > if})}){}dnl
dnl
dnl -------- unsigned ---------
dnl
dnl dup unum u= if
define({DUP_PUSH_UEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UEQ_IF},{dup_push_ueq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UEQ_IF},{dnl
__{}define({__INFO},{dup_push_ueq_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[14:27/54] dup $1 u= if
__{}__{}    ld    A, format({%-11s},$1); 3:13      dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}                        ;[5:18]     dup $1 u= if   variant: zero
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if
__{}__{}    or    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: -1
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    and   L             ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if   A = 0xFF --> 0x00 ?
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[11:18/39] dup $1 u= if   variant: lo($1) = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[11:18/39] dup $1 u= if   variant: hi($1) = 255
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    inc   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    or    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u= if   variant: lo($1) = zero
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    or    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u= if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u= if   variant: hi($1) = zero
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    or    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                        ;[9:18/32]  dup $1 u= if   variant: 0x0101 = 257
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    cp    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 0x0201),{0},{dnl
__{}__{}                       ;[10:22/36]  dup $1 u= if   variant: 0x0201 = 513
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    cp    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(($1) ^ 0x0102),{0},{dnl
__{}__{}                       ;[10:22/36]  dup $1 u= if   variant: 0x0102 = 258
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    cp    H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                       ;[10:18/35]  dup $1 u= if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    cp    L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    xor  low __FORM({%-11s},$1); 2:7       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[11:18/39]  dup $1 u= if   variant: hi($1) = 1
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    xor  low __FORM({%-11s},$1); 2:7       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[11:18/39]  dup $1 u= if   variant: lo($1) = 1
__{}__{}    ld    A, L          ; 1:4       dup $1 u= if
__{}__{}    dec   A             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, H          ; 1:4       dup $1 u= if
__{}__{}    xor  high __FORM({%-10s},$1); 2:7       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if},
__{}{dnl
__{}__{}                       ;[12:21/42]  dup $1 u= if   variant: default
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       dup $1 u= if
__{}__{}    xor   L             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       dup $1 u= if
__{}__{}    xor   H             ; 1:4       dup $1 u= if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      dup $1 u= if})}){}dnl
dnl
dnl
dnl dup unum u<> if
define({DUP_PUSH_UNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UNE_IF},{dup_push_une_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UNE_IF},{dnl
__{}define({__INFO},{dup_push_une_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[13:29/51] dup $1 u<> if
__{}__{}    ld    A, format({%-11s},$1); 3:13      dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+9        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A,format({%-12s},(1+$1)); 3:13      dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval($1),{0},{dnl
__{}__{}                        ;[5:18]     dup $1 u<> if   variant: zero
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if
__{}__{}    or    L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: -1
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    and   L             ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if   A = 0xFF --> 0x00 ?
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[10:20/36] dup $1 u<> if   variant: lo($1) = 255
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[10:20/36] dup $1 u<> if   variant: hi($1) = 255
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    inc   A             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    or    L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u<> if   variant: lo($1) = zero
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    or    L             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[6:22]     dup $1 u<> if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[7:25]     dup $1 u<> if   variant: hi($1) = zero
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    or    H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                        ;[8:20/29]  dup $1 u<> if   variant: 0x0101 = 257
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    cp    L             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+6        ; 2:7/12    dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                        ;[9:20/32]  dup $1 u<> if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    cp    L             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+7        ; 2:7/12    dup $1 u<> if
__{}__{}    xor  low __FORM({%-11s},$1); 2:7       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[10:20/36]  dup $1 u<> if   variant: hi($1) = 1
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    xor  low __FORM({%-11s},$1); 2:7       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[10:20/36]  dup $1 u<> if   variant: lo($1) = 1
__{}__{}    ld    A, L          ; 1:4       dup $1 u<> if
__{}__{}    dec   A             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, H          ; 1:4       dup $1 u<> if
__{}__{}    xor  high __FORM({%-10s},$1); 2:7       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if},
__{}{dnl
__{}__{}                        ;[11:23/39] dup $1 u<> if   variant: default
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   L             ; 1:4       dup $1 u<> if
__{}__{}    jr   nz, $+8        ; 2:7/12    dup $1 u<> if
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       dup $1 u<> if
__{}__{}    xor   H             ; 1:4       dup $1 u<> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      dup $1 u<> if})}){}dnl
dnl
dnl
dnl dup 123 u< if
define({DUP_PUSH_ULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ULT_IF},{dup_push_ult_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ULT_IF},{dnl
__{}define({__INFO},{dup_push_ult_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, L          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   C             ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, B          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 u< if},
__{}{dnl
__{}    ld    A, L          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    sub   low __FORM({%-10s},$1); 2:7       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    ld    A, H          ; 1:4       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    sbc   A, high __FORM({%-6s},$1); 2:7       dup $1 u< if    HL<$1 --> HL-$1<0 --> carry if true
__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 u< if})}){}dnl
dnl
dnl
dnl dup 123 u>= if
define({DUP_PUSH_UGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UGE_IF},{dup_push_uge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UGE_IF},{dnl
__{}define({__INFO},{dup_push_uge_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ld   BC, format({%-11s},$1); 4:20      dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, L          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   C             ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, B          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 u>= if},
__{}{dnl
__{}    ld    A, L          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sub   low __FORM({%-10s},$1); 2:7       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    ld    A, H          ; 1:4       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    sbc   A, high __FORM({%-6s},$1); 2:7       dup $1 u>= if    HL>=$1 --> HL-$1>=0 --> not carry if true
__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 u>= if})}){}dnl
dnl
dnl
dnl dup 123 u<= if
define({DUP_PUSH_ULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ULE_IF},{dup_push_ule_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ULE_IF},{dnl
__{}define({__INFO},{dup_push_ule_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}    ld    A, ifelse(__IS_MEM_REF($1),{1},{format({%-11s},$1); 3:13},{low __FORM({%-7s},$1); 2:7 })      dup $1 u<= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sub   L             ; 1:4       dup $1 u<= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    ld    A, ifelse(__IS_MEM_REF($1),{1},{(format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13},{high __FORM({%-6s},$1); 2:7 })      dup $1 u<= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    sbc   A, H          ; 1:4       dup $1 u<= if    HL<=$1 --> 0<=$1-HL --> not carry if true
__{}    jp    c, else{}IF_COUNT    ; 3:10      dup $1 u<= if}){}dnl
dnl
dnl
dnl dup 123 u> if
define({DUP_PUSH_UGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UGT_IF},{dup_push_ugt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UGT_IF},{dnl
__{}define({__INFO},{dup_push_ugt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}    ld    A, ifelse(__IS_MEM_REF($1),{1},{format({%-11s},$1); 3:13},{low __FORM({%-7s},$1); 2:7 })      dup $1 u> if    HL>$1 --> 0>$1-HL --> carry if true
__{}    sub   L             ; 1:4       dup $1 u> if    HL>$1 --> 0>$1-HL --> carry if true
__{}    ld    A, ifelse(__IS_MEM_REF($1),{1},{(format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13},{high __FORM({%-6s},$1); 2:7 })      dup $1 u> if    HL>$1 --> 0>$1-HL --> carry if true
__{}    sbc   A, H          ; 1:4       dup $1 u> if    HL>$1 --> 0>$1-HL --> carry if true
__{}    jp   nc, else{}IF_COUNT    ; 3:10      dup $1 u> if}){}dnl
dnl
dnl
dnl
dnl ------ 2dup ucond if ---------
dnl
define({_2DUP_UEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UEQ_IF},{2dup_ueq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UEQ_IF},{dnl
__{}define({__INFO},{2dup_ueq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u= if
    sub   L             ; 1:4       2dup u= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup u= if
    ld    A, D          ; 1:4       2dup u= if
    sub   H             ; 1:4       2dup u= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup u= if}){}dnl
dnl
dnl
define({_2DUP_UNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UNE_IF},{2dup_une_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UNE_IF},{dnl
__{}define({__INFO},{2dup_une_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u<> if
    sub   L             ; 1:4       2dup u<> if
    jr   nz, $+7        ; 2:7/12    2dup u<> if
    ld    A, D          ; 1:4       2dup u<> if
    sbc   A, H          ; 1:4       2dup u<> if
    jp    z, else{}IF_COUNT    ; 3:10      2dup u<> if}){}dnl
dnl
dnl
define({_2DUP_ULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_ULT_IF},{2dup_ult_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_ULT_IF},{dnl
__{}define({__INFO},{2dup_ult_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      2dup u< if}){}dnl
dnl
dnl
define({_2DUP_UGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UGE_IF},{2dup_uge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UGE_IF},{dnl
__{}define({__INFO},{2dup_uge_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      2dup u>= if}){}dnl
dnl
dnl
define({_2DUP_ULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_ULE_IF},{2dup_ule_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_ULE_IF},{dnl
__{}define({__INFO},{2dup_ule_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, else{}IF_COUNT    ; 3:10      2dup u<= if}){}dnl
dnl
dnl
define({_2DUP_UGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UGT_IF},{2dup_ugt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UGT_IF},{dnl
__{}define({__INFO},{2dup_ugt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      2dup u> if}){}dnl
dnl
dnl
dnl ------ 2dup scond if ---------
dnl
dnl 2dup = if
define({_2DUP_EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_EQ_IF},{2dup_eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_EQ_IF},{dnl
__{}define({__INFO},{2dup_eq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup = if}){}dnl
dnl
dnl
dnl 2dup <> if
define({_2DUP_NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_NE_IF},{2dup_ne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_NE_IF},{dnl
__{}define({__INFO},{2dup_ne_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup <> if
    sub   L             ; 1:4       2dup <> if
    jr   nz, $+7        ; 2:7/12    2dup <> if
    ld    A, D          ; 1:4       2dup <> if
    sub   H             ; 1:4       2dup <> if
    jp    z, else{}IF_COUNT    ; 3:10      2dup <> if}){}dnl
dnl
dnl
dnl 2dup < if
define({_2DUP_LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_LT_IF},{2dup_lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_LT_IF},{dnl
__{}define({__INFO},{2dup_lt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    xor   H             ; 1:4       2dup < if
    jp    p, else{}IF_COUNT    ; 3:10      2dup < if}){}dnl
dnl
dnl
dnl 2dup >= if
define({_2DUP_GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_GE_IF},{2dup_ge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_GE_IF},{dnl
__{}define({__INFO},{2dup_ge_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= if
    xor   D             ; 1:4       2dup >= if
    xor   H             ; 1:4       2dup >= if
    jp    m, else{}IF_COUNT    ; 3:10      2dup >= if}){}dnl
dnl
dnl
dnl 2dup <= if
define({_2DUP_LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_LE_IF},{2dup_le_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_LE_IF},{dnl
__{}define({__INFO},{2dup_le_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= if
    xor   D             ; 1:4       2dup <= if
    xor   H             ; 1:4       2dup <= if
    jp    m, else{}IF_COUNT    ; 3:10      2dup <= if}){}dnl
dnl
dnl
dnl 2dup > if
define({_2DUP_GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_GT_IF},{2dup_gt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_GT_IF},{dnl
__{}define({__INFO},{2dup_gt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > if
    xor   D             ; 1:4       2dup > if
    xor   H             ; 1:4       2dup > if
    jp    p, else{}IF_COUNT    ; 3:10      2dup > if}){}dnl
dnl
dnl
dnl ------ ucond if ---------
dnl
define({UEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_UEQ_IF},{ueq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UEQ_IF},{dnl
__{}define({__INFO},{ueq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    or    A             ; 1:4       u= if
    sbc  HL, DE         ; 2:15      u= if
    pop  HL             ; 1:10      u= if
    pop  DE             ; 1:10      u= if
    jp   nz, else{}IF_COUNT    ; 3:10      u= if}){}dnl
dnl
dnl
define({UNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_UNE_IF},{une_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UNE_IF},{dnl
__{}define({__INFO},{une_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    or    A             ; 1:4       u<> if
    sbc  HL, DE         ; 2:15      u<> if
    pop  HL             ; 1:10      u<> if
    pop  DE             ; 1:10      u<> if
    jp    z, else{}IF_COUNT    ; 3:10      u<> if}){}dnl
dnl
dnl
define({ULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_ULT_IF},{ult_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULT_IF},{dnl
__{}define({__INFO},{ult_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< if
    pop  DE             ; 1:10      u< if
    jp   nc, else{}IF_COUNT    ; 3:10      u< if}){}dnl
dnl
dnl
define({UGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_UGE_IF},{uge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGE_IF},{dnl
__{}define({__INFO},{uge_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= if
    pop  DE             ; 1:10      u>= if
    jp    c, else{}IF_COUNT    ; 3:10      u>= if}){}dnl
dnl
dnl
define({ULE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_ULE_IF},{ule_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULE_IF},{dnl
__{}define({__INFO},{ule_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= if
    pop  DE             ; 1:10      u<= if
    jp    c, else{}IF_COUNT    ; 3:10      u<= if}){}dnl
dnl
dnl
define({UGT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_UGT_IF},{ugt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGT_IF},{dnl
__{}define({__INFO},{ugt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> if
    pop  DE             ; 1:10      u> if
    jp   nc, else{}IF_COUNT    ; 3:10      u> if}){}dnl
dnl
dnl
dnl ------ scond if ---------
dnl
dnl = if
define({EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_EQ_IF},{eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_EQ_IF},{dnl
__{}define({__INFO},{eq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    or    A             ; 1:4       = if
    sbc  HL, DE         ; 2:15      = if
    pop  HL             ; 1:10      = if
    pop  DE             ; 1:10      = if
    jp   nz, else{}IF_COUNT    ; 3:10      = if}){}dnl
dnl
dnl
dnl <> if
define({NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_NE_IF},{ne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NE_IF},{dnl
__{}define({__INFO},{ne_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    or    A             ; 1:4       <> if
    sbc  HL, DE         ; 2:15      <> if
    pop  HL             ; 1:10      <> if
    pop  DE             ; 1:10      <> if
    jp    z, else{}IF_COUNT    ; 3:10      <> if}){}dnl
dnl
dnl
dnl < if
define({LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_LT_IF},{lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LT_IF},{dnl
__{}define({__INFO},{lt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       < if
    xor   H             ; 1:4       < if
    xor   D             ; 1:4       < if
    pop  HL             ; 1:10      < if
    pop  DE             ; 1:10      < if
    jp    p, else{}IF_COUNT    ; 3:10      < if}){}dnl
dnl
dnl
dnl >= if
define({GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_GE_IF},{ge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GE_IF},{dnl
__{}define({__INFO},{ge_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, E          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       >= if
    xor   H             ; 1:4       >= if
    xor   D             ; 1:4       >= if
    pop  HL             ; 1:10      >= if
    pop  DE             ; 1:10      >= if
    jp    m, else{}IF_COUNT    ; 3:10      >= if}){}dnl
dnl
dnl
dnl <= if
define({LE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_LE_IF},{le_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LE_IF},{dnl
__{}define({__INFO},{le_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    rra                 ; 1:4       <= if
    xor   H             ; 1:4       <= if
    xor   D             ; 1:4       <= if
    pop  HL             ; 1:10      <= if
    pop  DE             ; 1:10      <= if
    jp    m, else{}IF_COUNT    ; 3:10      <= if}){}dnl
dnl
dnl
dnl > if
define({GT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_GT_IF},{gt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GT_IF},{dnl
__{}define({__INFO},{gt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, L          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    rra                 ; 1:4       > if
    xor   H             ; 1:4       > if
    xor   D             ; 1:4       > if
    pop  HL             ; 1:10      > if
    pop  DE             ; 1:10      > if
    jp    p, else{}IF_COUNT    ; 3:10      > if}){}dnl
dnl
dnl
dnl ------ push scond if ---------
dnl
dnl num = if
define({PUSH_EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_EQ_IF},{push_eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_EQ_IF},{dnl
__{}define({__INFO},{push_eq_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[12:63]    $1 = if
__{}    ld   BC, format({%-11s},$1); 4:20      $1 = if
__{}    or    A             ; 1:4       $1 = if
__{}    sbc  HL, BC         ; 2:15      $1 = if
__{}    ex   DE, HL         ; 1:4       $1 = if
__{}    pop  DE             ; 1:10      $1 = if
__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}                        ;[7:32]     $1 = if   variant: zero
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    inc   A             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    inc   A             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: -1
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    and   L             ; 1:4       $1 = if
__{}__{}    inc   A             ; 1:4       $1 = if   A = 0xFF --> 0x00 ?
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}                        ;[10:43] $1 = if   variant: lo($1) = 255
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       $1 = if
__{}__{}    xor   H             ; 1:4       $1 = if
__{}__{}    inc   L             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}                        ;[10:43] $1 = if   variant: hi($1) = 255
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       $1 = if
__{}__{}    xor   L             ; 1:4       $1 = if
__{}__{}    inc   H             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    dec   A             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[9:39]     $1 = if   variant: lo($1) = zero
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       $1 = if
__{}__{}    xor   H             ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[8:36]     $1 = if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    dec   A             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[9:39]     $1 = if   variant: hi($1) = zero
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       $1 = if
__{}__{}    xor   L             ; 1:4       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                        ;[9:40]     $1 = if   variant: 0x0101 = 257
__{}__{}    dec   H             ; 1:4       $1 = if
__{}__{}    dec   L             ; 1:4       $1 = if
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    or    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                       ;[12:32/49]  $1 = if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    cp    L             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if
__{}__{}    xor  low __FORM({%-11s},$1); 2:7       $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[10:43]     $1 = if   variant: hi($1) = 1
__{}__{}    dec   H             ; 1:4       $1 = if
__{}__{}    ld    A, L          ; 1:4       $1 = if
__{}__{}    xor  low __FORM({%-11s},$1); 2:7       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[10:43]     $1 = if   variant: lo($1) = 1
__{}__{}    dec   L             ; 1:4       $1 = if
__{}__{}    ld    A, H          ; 1:4       $1 = if
__{}__{}    xor  high __FORM({%-10s},$1); 2:7       $1 = if
__{}__{}    or    H             ; 1:4       $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if},
__{}{dnl
__{}__{}                        ;[11:53]    $1 = if   variant: default
__{}__{}    ld   BC, __FORM({%-11s},$1); 3:10      $1 = if
__{}__{}    or    A             ; 1:4       $1 = if
__{}__{}    sbc  HL, BC         ; 2:15      $1 = if
__{}__{}    ex   DE, HL         ; 1:4       $1 = if
__{}__{}    pop  DE             ; 1:10      $1 = if
__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      $1 = if})}){}dnl
dnl
dnl
dnl num <> if
define({PUSH_NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_NE_IF},{push_ne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_NE_IF},{dnl
__{}define({__INFO},{push_ne_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                        ;[12:63] $1 <> if
__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 <> if
__{}__{}    or    A             ; 1:4       $1 <> if
__{}__{}    sbc  HL, DE         ; 2:15      $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval($1),{0},{dnl
__{}__{}                        ;[7:32]     $1 <> if   variant: zero
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFFFF) - 0x00FF),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: 0x00FF = 255
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    inc   A             ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFFFF) - 0xFF00),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: 0xFF00 = 65280
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    inc   A             ; 1:4       $1 <> if
__{}__{}    or    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFFFF) - 0xFFFF),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: -1
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    and   L             ; 1:4       $1 <> if
__{}__{}    inc   A             ; 1:4       $1 <> if   A = 0xFF --> 0x00 ?
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0x00FF) - 0x00FF),{0},{dnl
__{}__{}ifelse(_TYP_SINGLE,{small},{dnl
__{}__{}__{}                        ;[10:43]    $1 <> if   variant: lo($1) = 255
__{}__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}__{}    xor  __HEX_H(0xFFFF^($1))           ; 2:7       $1 <> if
__{}__{}__{}    and   L             ; 1:4       $1 <> if
__{}__{}__{}    inc   A             ; 1:4       $1 <> if
__{}__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}__{}{dnl
__{}__{}__{}                        ;[11:34/46] $1 <> if   variant: lo($1) = 255
__{}__{}__{}    inc   L             ; 1:4       $1 <> if
__{}__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}__{}    xor  high __FORM({%-10s},$1); 2:7       $1 <> if
__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if})},
__{}eval((($1) & 0xFF00) - 0xFF00),{0},{dnl
__{}__{}ifelse(_TYP_SINGLE,{small},{dnl
__{}__{}__{}                        ;[10:43]    $1 <> if   variant: hi($1) = 255
__{}__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}__{}    xor  __HEX_L(0xFF^($1))           ; 2:7       $1 <> if
__{}__{}__{}    and   H             ; 1:4       $1 <> if
__{}__{}__{}    inc   A             ; 1:4       $1 <> if
__{}__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}__{}{dnl
__{}__{}__{}                        ;[11:34/46] $1 <> if   variant: hi($1) = 255
__{}__{}__{}    inc   H             ; 1:4       $1 <> if
__{}__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}__{}    xor  low __FORM({%-10s},$1); 2:7       $1 <> if
__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if})},
__{}eval(($1) ^ 256),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: 0x0100 = 256
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    dec   A             ; 1:4       $1 <> if
__{}__{}    or    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}                        ;[9:39]     $1 <> if   variant: lo($1) = zero
__{}__{}    ld    A, high __FORM({%-6s},$1); 2:7       $1 <> if
__{}__{}    xor   H             ; 1:4       $1 <> if
__{}__{}    or    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) ^ 0x0001),{0},{dnl
__{}__{}                        ;[8:36]     $1 <> if   variant: 0x0001
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    dec   A             ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}                        ;[9:39]     $1 <> if   variant: hi($1) = zero
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       $1 <> if
__{}__{}    xor   L             ; 1:4       $1 <> if
__{}__{}    or    H             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(($1) ^ 0x0101),{0},{dnl
__{}__{}                       ;[10:34/43]  $1 <> if   variant: 0x0101 = 257
__{}__{}    dec   L             ; 1:4       $1 <> if
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+6        ; 2:7/12    $1 <> if
__{}__{}    dec   A             ; 1:4       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(((($1) & 0xFF00)>>8)-(($1) & 0xFF)),{0},{dnl
__{}__{}                       ;[11:34/46]  $1 <> if   variant: hi($1) = lo($1) = eval(($1) & 0xFF)
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    cp    L             ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor   low __FORM({%-10s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval(((($1) & 0xFF00)>>8)-1),{0},{dnl
__{}__{}                       ;[11:34/46]  $1 <> if   variant: hi($1) = 1
__{}__{}    dec   H             ; 1:4       $1 <> if
__{}__{}    ld    A, L          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor  low __FORM({%-11s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}eval((($1) & 0xFF)-1),{0},{dnl
__{}__{}                       ;[11:34/46]  $1 <> if   variant: lo($1) = 1
__{}__{}    dec   L             ; 1:4       $1 <> if
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor  high __FORM({%-10s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if},
__{}{dnl
__{}__{}                        ;[13:41/53] $1 <> if   variant: default
__{}__{}    ld    A, low __FORM({%-7s},$1); 2:7       $1 <> if
__{}__{}    xor   L             ; 1:4       $1 <> if
__{}__{}    ld    A, H          ; 1:4       $1 <> if
__{}__{}    ex   DE, HL         ; 1:4       $1 <> if
__{}__{}    pop  DE             ; 1:10      $1 <> if
__{}__{}    jr   nz, $+7        ; 2:7/12    $1 <> if
__{}__{}    xor  high __FORM({%-10s},$1); 2:7       $1 <> if
__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      $1 <> if})}){}dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 8bit
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl dup char = if
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
__{}    jp   nz, else{}IF_COUNT    ; 3:10      __INFO},
__{}__IS_NUM($1),0,{
__{}    ld    A, __FORM({%-11s},$1); 2:7       __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, else{}IF_COUNT    ; 3:10      __INFO},
__{}__SAVE_EVAL($1),0,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, else{}IF_COUNT    ; 3:10      __INFO},
__{}__SAVE_EVAL($1),1,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    dec   A             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, else{}IF_COUNT    ; 3:10      __INFO},
__{}__SAVE_EVAL($1),255,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    inc   A             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, else{}IF_COUNT    ; 3:10      __INFO},
__{}{
__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp   nz, else{}IF_COUNT    ; 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl dup char <> if
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
__{}    jp    z, else{}IF_COUNT    ; 3:10      __INFO},
__{}__IS_NUM($1),0,{
__{}    ld    A, __FORM({%-11s},$1); 2:7       __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, else{}IF_COUNT    ; 3:10      __INFO},
__{}__SAVE_EVAL($1),0,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, else{}IF_COUNT    ; 3:10      __INFO},
__{}__SAVE_EVAL($1),1,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    dec   A             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, else{}IF_COUNT    ; 3:10      __INFO},
__{}__SAVE_EVAL($1),255,{
__{}    ld    A, L          ; 1:4       __INFO   ( char -- char )
__{}    inc   A             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, else{}IF_COUNT    ; 3:10      __INFO},
__{}{
__{}    ld    A, __HEX_L($1)       ; 2:7       __INFO   ( char -- char )
__{}    xor   L             ; 1:4       __INFO
__{}    or    H             ; 1:4       __INFO
__{}    jp    z, else{}IF_COUNT    ; 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 32bit
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl 0. D= if
dnl D0= if
dnl ( d -- )
define({D0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_D0EQ_IF},{d0eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D0EQ_IF},{dnl
__{}define({__INFO},{d0eq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       D0= if   ( d -- )
    or    L             ; 1:4       D0= if
    or    D             ; 1:4       D0= if
    or    E             ; 1:4       D0= if
    pop  HL             ; 1:10      D0= if
    pop  DE             ; 1:10      D0= if
    jp   nz, else{}IF_COUNT    ; 3:10      D0= if}){}dnl
dnl
dnl
dnl
dnl
dnl 0. D<  if
dnl D0< if
dnl ( d -- )
define({D0LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_D0LT_IF},{d0lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D0LT_IF},{dnl
__{}define({__INFO},{d0lt_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
    bit   7, D          ; 2:8       D0< if   ( d -- )
    pop  HL             ; 1:10      D0< if
    pop  DE             ; 1:10      D0< if
    jp    z, else{}IF_COUNT    ; 3:10      D0< if}){}dnl
dnl
dnl
dnl
dnl
dnl ----------------------- 32 bit -----------------------
dnl ------ signed_32_bit_cond if ( d2 d1 -- ) ---------
dnl
dnl
dnl D= if
dnl ( d d -- )
define({DEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DEQ_IF},{deq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DEQ_IF},{dnl
__{}define({__INFO},{deq_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
                       ;[14:91]     D= if   ( d2 d1 -- )
    pop  BC             ; 1:10      D= if   lo_2
    or    A             ; 1:4       D= if
    sbc  HL, BC         ; 2:15      D= if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      D= if   hi_2
    jr   nz, $+4        ; 2:7/12    D= if
    sbc  HL, DE         ; 2:15      D= if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= if
    pop  DE             ; 1:10      D= if
    jp   nz, else{}IF_COUNT    ; 3:10      D= if}){}dnl
dnl
dnl
dnl
dnl D<> if
dnl ( d d -- )
define({DNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DNE_IF},{dne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DNE_IF},{dnl
__{}define({__INFO},{dne_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
                       ;[14:91]     D<> if   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> if   lo_2
    or    A             ; 1:4       D<> if
    sbc  HL, BC         ; 2:15      D<> if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      D<> if   hi_2
    jr   nz, $+4        ; 2:7/12    D<> if
    sbc  HL, DE         ; 2:15      D<> if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> if
    pop  DE             ; 1:10      D<> if
    jp    z, else{}IF_COUNT    ; 3:10      D<> if}){}dnl
dnl
dnl
dnl
dnl D< if
dnl ( d d -- )
define({DLT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DLT_IF},{dlt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DLT_IF},{dnl
__{}define({__INFO},{dlt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT){}dnl
__{}ifelse(_TYP_DOUBLE,{function},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                       ;[10:67]     D< if   ( d2 d1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D< if   l2
    pop  AF             ; 1:10      D< if   h2
    call FCE_DLT        ; 3:17      D< if   carry if true
    pop  HL             ; 1:10      D< if
    pop  DE             ; 1:10      D< if
    jp   nc, else{}IF_COUNT    ; 3:10      D< if},
{
                       ;[18:94]     D< if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D< if   lo_2
    ld    A, C          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      D< if   hi_2
    ld    A, L          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    rra                 ; 1:4       D< if                                   --> sign  if true
    xor   H             ; 1:4       D< if
    xor   D             ; 1:4       D< if
    pop  HL             ; 1:10      D< if
    pop  DE             ; 1:10      D< if
    jp    p, else{}IF_COUNT    ; 3:10      D< if})}){}dnl
dnl
dnl
dnl
dnl D>= if
dnl ( d d -- )
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
    jp    c, else{}IF_COUNT    ; 3:10      D<= if},
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
    jp    m, else{}IF_COUNT    ; 3:10      D>= if})}){}dnl
dnl
dnl
dnl
dnl D<= if
dnl ( d d -- )
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
    jp    m, else{}IF_COUNT    ; 3:10      D<= if},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:67]     D<= if   ( d2 d1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<= if   l2
    pop  AF             ; 1:10      D<= if   h2
    call FCE_DGT        ; 3:17      D<= if   D> carry if true --> D<= carry if false
    pop  HL             ; 1:10      D<= if
    pop  DE             ; 1:10      D<= if
    jp    c, else{}IF_COUNT    ; 3:10      D<= if},
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
    jp    m, else{}IF_COUNT    ; 3:10      D<= if})}){}dnl
dnl
dnl
dnl
dnl D> if
dnl ( d d -- )
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
    jp    p, else{}IF_COUNT    ; 3:10      D> if},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:146]    D> if   ( d2 d1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D> if   l2
    pop  AF             ; 1:10      D> if   h2
    call FCE_DGT        ; 3:17      D> if   carry if true
    pop  HL             ; 1:10      D> if
    pop  DE             ; 1:10      D> if
    jp   nc, else{}IF_COUNT    ; 3:10      D> if},
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
    jp    p, else{}IF_COUNT    ; 3:10      D> if})}){}dnl
dnl
dnl
dnl
dnl ----------------------- 32 bit -----------------------
dnl ------ unsigned_32_bit_cond if ( d2 d1 -- ) ---------
dnl
dnl
dnl Du= if
dnl ( ud ud -- )
define({DUEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUEQ_IF},{dueq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUEQ_IF},{dnl
__{}define({__INFO},{dueq_if}){}dnl
DEQ_IF}){}dnl
dnl
dnl
dnl
dnl Du<> if
dnl ( ud ud -- )
define({DUNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUNE_IF},{dune_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUNE_IF},{dnl
__{}define({__INFO},{dune_if}){}dnl
DNE_IF}){}dnl
dnl
dnl
dnl
dnl Du< if
dnl ( ud ud -- )
define({DULT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DULT_IF},{dult_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DULT_IF},{dnl
__{}define({__INFO},{dult_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
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
    jp   nc, else{}IF_COUNT    ; 3:10      Du< if}){}dnl
dnl
dnl
dnl
dnl Du>= if
dnl ( ud ud -- )
define({DUGE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_DUGE_IF},{duge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUGE_IF},{dnl
__{}define({__INFO},{duge_if}){}dnl
define({IF_COUNT}, incr(IF_COUNT))pushdef({ELSE_STACK}, IF_COUNT)pushdef({THEN_STACK}, IF_COUNT)
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
    jp    c, else{}IF_COUNT    ; 3:10      Du>= if}){}dnl
dnl
dnl
dnl
dnl Du<= if
dnl ( ud ud -- )
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
    jp    c, else{}IF_COUNT    ; 3:10      Du<= if},
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
    jp    c, else{}IF_COUNT    ; 3:10      Du<= if})}){}dnl
dnl
dnl
dnl
dnl Du> if
dnl ( ud ud -- )
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
    jp   nc, else{}IF_COUNT    ; 3:10      Du> if},
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
    jp   nc, else{}IF_COUNT    ; 3:10      Du> if})}){}dnl
dnl
dnl
dnl
dnl ----- 4dup signed_32_bit_cond if ( d2 d1 -- d2 d1 ) -----
dnl
dnl
dnl 4dup D= if
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
    jp   nz, else{}IF_COUNT    ; 3:10      4dup D= if},
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
    jp   nz, else{}IF_COUNT    ; 3:10      4dup D= if   h2 l2 . h1 l1})}){}dnl
dnl
dnl
dnl 4dup D<> if
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
    jp    z, else{}IF_COUNT    ; 3:10      4dup D<> if},
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
    jp    z, else{}IF_COUNT    ; 3:10      4dup D<> if   h2 l2 . h1 l1},
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
    jp    z, else{}IF_COUNT    ; 3:10      4dup D<> if},
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
    jp    z, else{}IF_COUNT    ; 3:10      4dup D<> if})}){}dnl
dnl
dnl
dnl
dnl 4dup D< if
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
    jp   nc, else{}IF_COUNT    ; 3:10      4dup D< if},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:27]     4dup D< if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< if   carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      4dup D< if})}){}dnl
dnl
dnl
dnl
dnl 4dup D>= if
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
    jp    c, else{}IF_COUNT    ; 3:10      4dup D>= if},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:27]     4dup D>= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= if   D< carry if true --> D>= carry if false
    jp    c, else{}IF_COUNT    ; 3:10      4dup D>= if})}){}dnl
dnl
dnl
dnl
dnl 4dup D<= if
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
    jp    c, else{}IF_COUNT    ; 3:10      4dup D<= if},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:27]     4dup D<= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= if   D> carry if true --> D<= carry if false
    jp    c, else{}IF_COUNT    ; 3:10      4dup D<= if})}){}dnl
dnl
dnl
dnl
dnl 4dup D> if
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
    jp   nc, else{}IF_COUNT    ; 3:10      4dup D> if},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:27]     4dup D> if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> if   carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      4dup D> if})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl ----- 4dup unsigned_32_bit_cond if ( ud2 ud1 -- ud2 ud1 ) -----
dnl
dnl
dnl 4dup Du= if
define({_4DUP_DUEQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUEQ_IF},{4dup_dueq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUEQ_IF},{dnl
__{}define({__INFO},{4dup_dueq_if}){}dnl
_4DUP_DEQ_IF}){}dnl
dnl
dnl
dnl 4dup Du<> if
define({_4DUP_DUNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUNE_IF},{4dup_dune_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUNE_IF},{dnl
__{}define({__INFO},{4dup_dune_if}){}dnl
_4DUP_DNE_IF}){}dnl
dnl
dnl
dnl
dnl 4dup Du< if
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
                       ;[10:69]     4dup D< if   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup D< if
    pop  AF             ; 1:10      4dup D< if
    push AF             ; 1:11      4dup D< if
    push BC             ; 1:11      4dup D< if
    call FCE_DULT       ; 3:17      4dup D< if   carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      4dup D< if},
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
    jp   nc, else{}IF_COUNT    ; 3:10      4dup D< if})}){}dnl
dnl
dnl
dnl
dnl 4dup Du>= if
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
                       ;[10:69]     4dup D>= if   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup D>= if
    pop  AF             ; 1:10      4dup D>= if
    push AF             ; 1:11      4dup D>= if
    push BC             ; 1:11      4dup D>= if
    call FCE_DULT       ; 3:17      4dup D>= if   D< carry if true --> D>= carry if false
    jp    c, else{}IF_COUNT    ; 3:10      4dup D>= if},
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
    jp    c, else{}IF_COUNT    ; 3:10      4dup D>= if})}){}dnl
dnl
dnl
dnl
dnl 4dup Du<= if
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
                       ;[10:69]     4dup D<= if   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup D<= if
    pop  AF             ; 1:10      4dup D<= if
    push AF             ; 1:11      4dup D<= if
    push BC             ; 1:11      4dup D<= if
    call FCE_DUGT       ; 3:17      4dup D<= if   D> carry if true --> D<= carry if false
    jp    c, else{}IF_COUNT    ; 3:10      4dup D<= if},
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
    jp    c, else{}IF_COUNT    ; 3:10      4dup D<= if})}){}dnl
dnl
dnl
dnl
dnl 4dup Du> if
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
                       ;[10:69]     4dup D> if   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup D> if
    pop  AF             ; 1:10      4dup D> if
    push AF             ; 1:11      4dup D> if
    push BC             ; 1:11      4dup D> if
    call FCE_DUGT       ; 3:17      4dup D> if   carry if true
    jp   nc, else{}IF_COUNT    ; 3:10      4dup D> if},
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
    jp   nc, else{}IF_COUNT    ; 3:10      4dup D> if})}){}dnl
dnl
dnl
dnl
dnl +============================ 32 bit ===============================+
dnl |         2dup pushdot signed_32_bit_cond if ( ud1 -- ud1 )         |
dnl +===================================================================+
dnl
dnl
dnl
dnl 2dup 0 0 D= if
dnl 2dup 0. D= if
dnl 2dup D0= if
dnl ( d -- d )
define({_2DUP_D0EQ_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0EQ_IF},{2dup_d0eq_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0EQ_IF},{dnl
__{}define({__INFO},{2dup_d0eq_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup D0= if  ( d -- d )
    or    L             ; 1:4       2dup D0= if
    or    D             ; 1:4       2dup D0= if
    or    E             ; 1:4       2dup D0= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup D0= if}){}dnl
dnl
dnl
dnl
dnl 2dup 0 0 D<> if
dnl 2dup 0. D<> if
dnl 2dup D0<> if
dnl ( d -- d )
define({_2DUP_D0NE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0NE_IF},{2dup_d0ne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0NE_IF},{dnl
__{}define({__INFO},{2dup_d0ne_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    ld    A, H          ; 1:4       2dup D0<> if  ( d -- d )
    or    L             ; 1:4       2dup D0<> if
    or    D             ; 1:4       2dup D0<> if
    or    E             ; 1:4       2dup D0<> if
    jp    z, else{}IF_COUNT    ; 3:10      2dup D0<> if}){}dnl
dnl
dnl
dnl
dnl 2dup 0 0 D< if
dnl 2dup 0. D< if
dnl 2dup D0< if
dnl ( d -- d )
define({_2DUP_D0LT_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0LT_IF},{2dup_d0lt_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0LT_IF},{dnl
__{}define({__INFO},{2dup_d0lt_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    bit   7, D          ; 2:8       2dup D0< if
    jp    z, else{}IF_COUNT    ; 3:10      2dup D0< if}){}dnl
dnl
dnl
dnl
dnl 2dup 0 0 D>= if
dnl 2dup 0. D>= if
dnl 2dup D0>= if
dnl ( d -- d )
define({_2DUP_D0GE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0GE_IF},{2dup_d0ge_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0GE_IF},{dnl
__{}define({__INFO},{2dup_d0ge_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT)){}dnl
__{}pushdef({ELSE_STACK}, IF_COUNT){}dnl
__{}pushdef({THEN_STACK}, IF_COUNT)
    bit   7, D          ; 2:8       2dup D0>= if
    jp   nz, else{}IF_COUNT    ; 3:10      2dup D0>= if}){}dnl
dnl
dnl
dnl
dnl
dnl 2dup D. D= if
dnl ( d -- d )
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
__{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__{}__DEQ_MAKE_BEST_CODE($1,3,10,0,0){}dnl
__{}__{}__{}__DEQ_MAKE_HL_CODE($1,0,0){}dnl
__{}__{}__{}define({_TMP_B},eval(_TMP_B+3)){}dnl
__{}__{}__{}define({_TMP_J},eval(_TMP_J+10)){}dnl
__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_P},eval(8*_TMP_NJ+4*_TMP_J+4*_TMP_J2+64*_TMP_B)){}dnl     price = 16*(clocks + 4*bytes)
__{}__{}__{}ifelse(ifelse(_TYP_DOUBLE,{small},{eval((_TMP_BEST_B<_TMP_B) || ((_TMP_BEST_B==_TMP_B) && (_TMP_BEST_P<_TMP_P)))},{eval(_TMP_BEST_P<=_TMP_P)}),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO   price: _TMP_BEST_P},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[_TMP_B:_TMP_NJ/_TMP_J,_TMP_J2] _TMP_INFO   ( d1 -- d1 )_TMP_HL_CODE
__{}__{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO   price: _TMP_P})})},
__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl 2dup D. D<> if
dnl ( d -- d )
define({_2DUP_PUSHDOT_DNE_IF},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DNE_IF},{2dup_pushdot_dne_if},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DNE_IF},{dnl
__{}define({__INFO},{2dup_pushdot_dne_if}){}dnl
dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}define({_TMP_INFO},{2dup $1 D<> if}){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 )   __HEX_DEHL($1) <> DEHL}){}dnl
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
__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__{}__DEQ_MAKE_BEST_CODE($1,3,10,3,-10){}dnl
__{}__{}__{}__DEQ_MAKE_HL_CODE($1,3,-10){}dnl
__{}__{}__{}define({_TMP_B},eval(_TMP_B+3)){}dnl
__{}__{}__{}define({_TMP_J},eval(_TMP_J+10)){}dnl
__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_P},eval(8*_TMP_J2+4*_TMP_NJ+4*_TMP_J+64*_TMP_B)){}dnl     price = 16*(clocks + 4*bytes)
__{}__{}__{}ifelse(ifelse(_TYP_DOUBLE,{small},{eval((_TMP_BEST_B<_TMP_B) || ((_TMP_BEST_B==_TMP_B) && (_TMP_BEST_P<_TMP_P)))},{eval(_TMP_BEST_P<=_TMP_P)}),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO   price: _TMP_BEST_P},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[_TMP_B:_TMP_J,_TMP_NJ/_TMP_J2] _TMP_INFO   ( d1 -- d1 )_TMP_HL_CODE
__{}__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO   price: _TMP_P})})},
__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl

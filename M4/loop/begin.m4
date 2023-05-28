dnl ## Begin
dnl
dnl
define({BEGIN_COUNT},100)dnl
dnl
dnl # --------- begin while repeat ------------
dnl
dnl
dnl
dnl # ( -- )
define({BEGIN},{dnl
__{}__ADD_TOKEN({__TOKEN_BEGIN},{begin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_BEGIN},{dnl
dnl # begin ... again
dnl # begin ... flag until
dnl # begin ... flag while    ...   repeat
dnl # do  { ... if (!) break; ... } while (1)
__{}define({__INFO},{begin}){}dnl
__{}define({BEGIN_COUNT}, incr(BEGIN_COUNT)){}dnl
__{}pushdef({BEGIN_STACK}, BEGIN_COUNT)
begin{}BEGIN_STACK:               ;           begin BEGIN_STACK}){}dnl
dnl
dnl
dnl # ( -- )
define({BREAK},{dnl
__{}__ADD_TOKEN({__TOKEN_BREAK},{break},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_BREAK},{dnl
__{}define({__INFO},{break}){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{
__{}    jp   break{}BEGIN_STACK       ; 3:10      break BEGIN_STACK}){}dnl
}){}dnl
dnl
dnl
dnl # ( -- )
define({AGAIN},{dnl
__{}__ADD_TOKEN({__TOKEN_AGAIN},{again},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_AGAIN},{dnl
__{}define({__INFO},{again}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    jp   begin{}BEGIN_STACK       ; 3:10      again BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           again BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl
dnl # --------- begin until ------------
dnl
dnl
dnl # ( flag -- )
define({UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_UNTIL},{until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{
__{}__{}    ld    A, H          ; 1:4       __INFO   ( flag -- )
__{}__{}    or    L             ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    z, begin{}BEGIN_STACK   ; 3:10      __INFO
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # ( -- )
define({ZF_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZF_UNTIL},{zf until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZF_UNTIL},{dnl
__{}define({__INFO},{zf until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    jp   nz, begin{}BEGIN_STACK   ; 3:10      zf until BEGIN_STACK   ( -- )   zero flag
__{}break{}BEGIN_STACK:               ;           zf until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( flag -- )
define({_0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_0EQ_UNTIL},{0= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_0EQ_UNTIL},{dnl
__{}define({__INFO},{0eq until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       0= until BEGIN_STACK   ( flag -- )
    or    L             ; 1:4       0= until BEGIN_STACK
    ex   DE, HL         ; 1:4       0= until BEGIN_STACK
    pop  DE             ; 1:10      0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           0= until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( n -- )
dnl # $1 $2 within until
define({PUSH2_WITHIN_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_WITHIN_UNTIL},{$1 $2 within until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_WITHIN_UNTIL},{dnl
__{}define({__INFO},{$1 $2 within until}){}dnl
ifelse(dnl
BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
$1,{},{
__{}  .error {$0}(): Missing parameter!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},{$1 $2 within until BEGIN_STACK}){}dnl
__{}__{}define({PUSH2_WITHIN_UNTIL_CODE},__WITHIN($1,$2))
__{}                        ;format({%-11s},[eval(5+__WITHIN_B):eval(24+__WITHIN_C)])_TMP_INFO   ( {TOS} -- )  true=($1<={TOS}<$2){}dnl
__{}PUSH2_WITHIN_UNTIL_CODE
__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}    pop  DE             ; 1:10      _TMP_INFO
__{}    jp   nc, begin{}BEGIN_STACK   ; 3:10      _TMP_INFO
__{}break{}BEGIN_STACK:               ;           _TMP_INFO{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl
dnl # ------ scond until ( b a -- ) ---------
dnl
dnl
dnl # = until
define({EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_EQ_UNTIL},{= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_EQ_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 == x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_EQ_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # <> until
define({NE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_NE_UNTIL},{<> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 <> x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_NE_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # < until
define({LT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_LT_UNTIL},{< until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 < x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_LT_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # >= until
define({GE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_GE_UNTIL},{>= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 >= x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_GE_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # <= until
define({LE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_LE_UNTIL},{<= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 <= x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_LE_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # > until
define({GT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_GT_UNTIL},{> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 > x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_GT_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ------ num scond until ( a -- ) ---------
dnl
dnl
dnl # ( n -- )
dnl # const = until
define({PUSH_EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_EQ_UNTIL},{$1 = until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_EQ_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_EQ_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # ( n -- )
dnl # const <> until
define({PUSH_NE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_NE_UNTIL},{$1 <> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_NE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_NE_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const < until
define({PUSH_LT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_LT_UNTIL},{$1 < until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_LT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_LT_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const <= until
define({PUSH_LE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_LE_UNTIL},{$1 <= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_LE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_LE_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const >= until
define({PUSH_GE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_GE_UNTIL},{$1 >= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_GE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_GE_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const > until
define({PUSH_GT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_GT_UNTIL},{$1 > until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_GT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_GT_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # ------ ucond until ---------
dnl
dnl # u= until
define({UEQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_EQ_UNTIL},{u= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UEQ_UNTIL},{dnl
__{}__ASM_TOKEN_EQ_UNTIL($@){}dnl
}){}dnl
dnl
dnl
dnl # u<> until
define({UNE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_NE_UNTIL},{u<> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UNE_UNTIL},{dnl
__{}__ASM_TOKEN_NE_UNTIL($@){}dnl
}){}dnl
dnl
dnl
dnl # u> until
define({UGT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_UGT_UNTIL},{u> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>0),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( u2 u1 -- )}){}dnl
__{}__{}__MAKE_CODE_UGT_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # u<= until
define({ULE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_ULE_UNTIL},{u<= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>0),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( u2 u1 -- )}){}dnl
__{}__{}__MAKE_CODE_ULE_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # u< until
define({ULT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_ULT_UNTIL},{u< until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>0),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( u2 u1 -- )}){}dnl
__{}__{}__MAKE_CODE_ULT_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # u>= until
define({UGE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_UGE_UNTIL},{u>= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>0),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( u2 u1 -- )}){}dnl
__{}__{}__MAKE_CODE_UGE_DROP_JP_FALSE(begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ------ push ucond until ---------
dnl
dnl # num u= until
define({PUSH_UEQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_EQ_UNTIL},{$1 u= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UEQ_UNTIL},{dnl
__{}__ASM_TOKEN_PUSH_EQ_UNTIL($@){}dnl
}){}dnl
dnl
dnl
dnl # num u<> until
define({PUSH_UNE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_NE_UNTIL},{$1 u<> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UNE_UNTIL},{dnl
__{}__ASM_TOKEN_PUSH_NE_UNTIL($@){}dnl
}){}dnl
dnl
dnl
dnl # num u> until
define({PUSH_UGT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_UGT_UNTIL},{$1 u> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UGT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( u -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_UGT_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # num u<= until
define({PUSH_ULE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ULE_UNTIL},{$1 u<= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ULE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( u -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_ULE_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # num u< until
define({PUSH_ULT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ULT_UNTIL},{$1 u< until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ULT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( u -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_ULT_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # num u>= until
define({PUSH_UGE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_UGE_UNTIL},{$1 u>= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UGE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( u -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_UGE_DROP_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # -------- dup num scond until ( s -- s ) ---------
dnl
dnl
dnl # dup const = until
define({DUP_PUSH_EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_EQ_UNTIL},{dup $1 = until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_EQ_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_EQ_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const <> until
define({DUP_PUSH_NE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_NE_UNTIL},{dup $1 <> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_NE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_NE_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const < until
define({DUP_PUSH_LT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_LT_UNTIL},{dup $1 < until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_LT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x -- x )  flag: x < $1){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_LT_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const >= until
define({DUP_PUSH_GE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_GE_UNTIL},{dup $1 >= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_GE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x -- x )  flag: x >= $1){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_GE_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # dup const <= until
define({DUP_PUSH_LE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_LE_UNTIL},{dup $1 <= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_LE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x -- x )  flag: x <= $1){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_LE_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # dup const > until
define({DUP_PUSH_GT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_GT_UNTIL},{dup $1 > until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_GT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x -- x )  flag: x > $1){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_GT_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # -------- dup num ucond until ( s -- s ) ---------
dnl
dnl
dnl # dup const u= until
define({DUP_PUSH_UEQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_EQ_UNTIL},{dup $1 u= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UEQ_UNTIL},{dnl
__{}__ASM_TOKEN_DUP_PUSH_EQ_UNTIL($@){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const u<> until
define({DUP_PUSH_UNE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_NE_UNTIL},{dup $1 u<> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UNE_UNTIL},{dnl
__{}__ASM_TOKEN_DUP_PUSH_NE_UNTIL($@){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const u< until
define({DUP_PUSH_ULT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ULT_UNTIL},{dup $1 u< until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ULT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( u -- u )  flag: u < $1){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_ULT_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const u>= until
define({DUP_PUSH_UGE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UGE_UNTIL},{dup $1 u>= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UGE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( u -- u )  flag: u >= $1){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_UGE_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # dup const u<= until
define({DUP_PUSH_ULE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ULE_UNTIL},{dup $1 u<= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ULE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( u -- u )  flag: u <= $1){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_ULE_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # dup const u> until
define({DUP_PUSH_UGT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UGT_UNTIL},{dup $1 u> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UGT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( u -- u )  flag: u > $1){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_UGT_JP_FALSE($1,begin{}BEGIN_STACK)
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # ----------------------------------
dnl
dnl
dnl # ( flag -- flag )
define({DUP_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_UNTIL},{dup until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_UNTIL},{dnl
__{}define({__INFO},{dup until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       dup until BEGIN_STACK   ( flag -- flag )
    or    L             ; 1:4       dup until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      dup until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           dup until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( b a -- b a )
define({_2DUP_EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_EQ_UNTIL},{2dup_eq until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_EQ_UNTIL},{dnl
__{}define({__INFO},{2dup_eq until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
__{}                        ;[10:18/36] 2dup eq until BEGIN_STACK
__{}    ld    A, L          ; 1:4       2dup eq until BEGIN_STACK
__{}    xor   E             ; 1:4       2dup eq until BEGIN_STACK   lo({TOS}) ^ lo({NOS})
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      2dup eq until BEGIN_STACK
__{}    ld    A, H          ; 1:4       2dup eq until BEGIN_STACK
__{}    xor   D             ; 1:4       2dup eq until BEGIN_STACK   hi({TOS}) ^ hi({NOS})
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      2dup eq until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           2dup eq until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( x -- x )
define({DUP_0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_0EQ_UNTIL},{dup 0= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_0EQ_UNTIL},{dnl
__{}define({__INFO},{dup_0eq until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       dup 0= until BEGIN_STACK   ( x -- x )
    or    L             ; 1:4       dup 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup 0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           dup 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl
dnl # ( n -- n )
define({DUP_PUSH_HEQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_HEQ_UNTIL},{dup $1 h= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_HEQ_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}                        ;[7:27]     __INFO BEGIN_STACK
__{}    ld    A,format({%-12s},($1+1)); 3:13      __INFO BEGIN_STACK
__{}    xor   H             ; 1:4       __INFO BEGIN_STACK   hi(TOS) ^ hi(stop)
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
__IS_NUM($1),{0},{
__{}                        ;[6:21]     __INFO BEGIN_STACK
__{}    ld    A, H          ; 1:4       __INFO BEGIN_STACK
__{}    xor  format({%-15s},high $1); 2:7       __INFO BEGIN_STACK   hi(TOS) ^ hi($1)
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
__HEX_H($1),{0x00},{
__{}                        ;[5:18]     __INFO BEGIN_STACK   variant: hi($1) == zero
__{}    inc   H             ; 1:4       __INFO BEGIN_STACK
__{}    dec   H             ; 1:4       __INFO BEGIN_STACK   hi(TOS) ^ hi(stop)
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
__HEX_H($1),{0x01},{
__{}                        ;[5:18]     __INFO BEGIN_STACK   variant: hi($1) == 255
__{}    ld    A, H          ; 1:4       __INFO BEGIN_STACK
__{}    dec   A             ; 1:4       __INFO BEGIN_STACK   A = 0x01 --> 0x00 ?
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
__HEX_H($1),{0xFF},{
__{}                        ;[5:18]     __INFO BEGIN_STACK   variant: hi($1) == 255
__{}    ld    A, H          ; 1:4       __INFO BEGIN_STACK
__{}    inc   A             ; 1:4       __INFO BEGIN_STACK   A = 0xFF --> 0x00 ?
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
{
__{}                        ;[6:21]     __INFO BEGIN_STACK
__{}    ld    A, H          ; 1:4       __INFO BEGIN_STACK
__{}    xor  __HEX_H($1)           ; 2:7       __INFO BEGIN_STACK   hi(TOS) ^ hi(__HEX_HL($1))
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # ( n -- n )
define({DUP_PUSH_CEQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CEQ_UNTIL},{dup $1 c= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CEQ_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}                        ;[7:27]     __INFO BEGIN_STACK
__{}    ld    A,format({%-12s},$1); 3:13      __INFO BEGIN_STACK
__{}    xor   L             ; 1:4       __INFO BEGIN_STACK   lo(TOS) ^ lo(stop)
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
__IS_NUM($1),{0},{
__{}                        ;[6:21]     __INFO BEGIN_STACK
__{}    ld    A, L          ; 1:4       __INFO BEGIN_STACK
__{}    xor  format({%-15s},low $1); 2:7       __INFO BEGIN_STACK   lo(TOS) ^ lo($1)
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
__HEX_L($1),{0x00},{
__{}                        ;[5:18]     __INFO BEGIN_STACK   variant: hi($1) == zero
__{}    inc   L             ; 1:4       __INFO BEGIN_STACK
__{}    dec   L             ; 1:4       __INFO BEGIN_STACK   lo(TOS) ^ lo(stop)
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
__HEX_L($1),{0x01},{
__{}                        ;[5:18]     __INFO BEGIN_STACK   variant: lo($1) == 1
__{}    ld    A, L          ; 1:4       __INFO BEGIN_STACK
__{}    dec   A             ; 1:4       __INFO BEGIN_STACK   A = 0x01 --> 0x00 ?
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
__HEX_L($1),{0xFF},{
__{}                        ;[5:18]     __INFO BEGIN_STACK   variant: lo($1) == 255
__{}    ld    A, L          ; 1:4       __INFO BEGIN_STACK
__{}    inc   A             ; 1:4       __INFO BEGIN_STACK   A = 0xFF --> 0x00 ?
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})},
{
__{}                        ;[6:21]     __INFO BEGIN_STACK
__{}    ld    A, L          ; 1:4       __INFO BEGIN_STACK
__{}    xor  __HEX_L($1)           ; 2:7       __INFO BEGIN_STACK   lo(TOS) ^ lo(__HEX_HL($1))
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           __INFO BEGIN_STACK{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl # ( x -- x )
dnl # dup $1 $2 within until
define({DUP_PUSH2_WITHIN_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH2_WITHIN_UNTIL},{dup $1 $2 within until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH2_WITHIN_UNTIL},{dnl
__{}define({__INFO},{dup $1 $2 within until}){}dnl
ifelse(dnl
BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
$1,{},{
__{}  .error {$0}(): Missing parameter!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},{dup $1 $2 within until BEGIN_STACK}){}dnl
__{}__{}define({DUP_PUSH2_WITHIN_UNTIL_CODE},__SAVE_HL_WITHIN($1,$2))
__{}                        ;format({%-11s},[eval(3+__SAVE_HL_WITHIN_B):eval(10+__SAVE_HL_WITHIN_C)])_TMP_INFO   ( x -- x )  true=($1<=x<$2){}dnl
__{}DUP_PUSH2_WITHIN_UNTIL_CODE
__{}    jp   nc, begin{}BEGIN_STACK   ; 3:10      _TMP_INFO
__{}break{}BEGIN_STACK:               ;           _TMP_INFO{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( addr -- addr )
define({DUP_CFETCH_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_CFETCH_UNTIL},{dup_cfetch until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_CFETCH_UNTIL},{dnl
__{}define({__INFO},{dup_cfetch until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A,(HL)        ; 1:7       dup C@ until BEGIN_STACK   ( addr -- addr )
    or    A             ; 1:4       dup C@ until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      dup C@ until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           dup C@ until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( addr -- addr )
define({DUP_CFETCH_0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_CFETCH_0EQ_UNTIL},{dup_cfetch 0= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_CFETCH_0EQ_UNTIL},{dnl
__{}define({__INFO},{dup_cfetch 0= until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A,(HL)        ; 1:7       dup C@ 0= until BEGIN_STACK   ( addr -- addr )
    or    A             ; 1:4       dup C@ 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      dup C@ 0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           dup C@ 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( flag x -- flag x )
define({OVER_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_UNTIL},{over until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_UNTIL},{dnl
__{}define({__INFO},{over until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, D          ; 1:4       over until BEGIN_STACK   ( flag x -- flag x )
    or    E             ; 1:4       over until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      over until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           over until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x2 x1 )
define({OVER_0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_0EQ_UNTIL},{over 0= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_0EQ_UNTIL},{dnl
__{}define({__INFO},{over 0= until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, D          ; 1:4       over 0= until BEGIN_STACK   ( x2 x1 -- x2 x1 )
    or    E             ; 1:4       over 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      over 0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           over 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( addr x -- addr x )
define({OVER_CFETCH_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_CFETCH_UNTIL},{over cfetch until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_CFETCH_UNTIL},{dnl
__{}define({__INFO},{over cfetch until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A,(DE)        ; 1:7       over C@ until BEGIN_STACK   ( addr x -- addr x )
    or    A             ; 1:4       over C@ until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      over C@ until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           over C@ until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( addr x -- addr x )
define({OVER_CFETCH_0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_CFETCH_0EQ_UNTIL},{over cfetch 0= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_CFETCH_0EQ_UNTIL},{dnl
__{}define({__INFO},{over cfetch 0= until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A,(DE)        ; 1:7       over C@ 0= until BEGIN_STACK   ( addr x -- addr x )
    or    A             ; 1:4       over C@ 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      over C@ 0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           over C@ 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( flag d -- flag d )
define({_2OVER_NIP_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_UNTIL},{2over nip until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_UNTIL},{dnl
__{}define({__INFO},{2over nip until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    pop  BC             ; 1:10      2over nip until BEGIN_STACK   ( flag x -- flag x )
    push BC             ; 1:11      2over nip until BEGIN_STACK
    ld    A, B          ; 1:4       2over nip until BEGIN_STACK   BC = flag
    or    C             ; 1:4       2over nip until BEGIN_STACK
    jp    z, begin{}BEGIN_STACK   ; 3:10      2over nip until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           2over nip until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( x d -- x d )
define({_2OVER_NIP_0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_0EQ_UNTIL},{2over nip 0= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_0EQ_UNTIL},{dnl
__{}define({__INFO},{2over nip 0= until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    pop  BC             ; 1:10      2over nip 0= until BEGIN_STACK   ( x d -- x d )
    push BC             ; 1:11      2over nip 0= until BEGIN_STACK
    ld    A, B          ; 1:4       2over nip 0= until BEGIN_STACK   BC = x
    or    C             ; 1:4       2over nip 0= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      2over nip 0= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           2over nip 0= until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # 2over nip c@ 0 c= until
dnl # ( addr d -- addr d )
define({_2OVER_NIP_CFETCH_0CEQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_CFETCH_0CEQ_UNTIL},{2over nip cfetch_0ceq until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_CFETCH_0CEQ_UNTIL},{dnl
__{}define({__INFO},{2over nip cfetch_0ceq until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{define({_TMP_INFO},{2over nip c@ 0 c= until BEGIN_STACK})
__{}                        ;[7:42]     _TMP_INFO   ( addr1 d1 -- addr1 d1 )
__{}    pop  BC             ; 1:10      _TMP_INFO   BC = addr1
__{}    push BC             ; 1:11      _TMP_INFO
__{}    ld    A,(BC)        ; 1:7       _TMP_INFO
__{}    or    A             ; 1:4       _TMP_INFO
__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      _TMP_INFO
__{}break{}BEGIN_STACK:               ;           _TMP_INFO{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl # ( flag -- )
define({UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_UNTIL},{until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d< until
dnl # ( d -- d )
define({_2DUP_PUSH2_DLT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DLT_UNTIL},{2dup $1 $2 d< until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DLT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- d )  flag: d < $1<<16+$2},3,10,3,0,begin{}BEGIN_STACK,0)
__{}__{}    jp   nc, format({%-11s},begin{}BEGIN_STACK); 3:10      __INFO
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d>= until
dnl # ( d -- d )
define({_2DUP_PUSH2_DGE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DGE_UNTIL},{2dup $1 $2 d>= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DGE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- d )  flag: d >= $1<<16+$2},3,10,begin{}BEGIN_STACK,0,3,0)
__{}__{}    jp    c, format({%-11s},begin{}BEGIN_STACK); 3:10      __INFO
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d<= until
dnl # ( d -- d )
define({_2DUP_PUSH2_DLE_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DLE_UNTIL},{2dup $1 $2 d<= until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DLE_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- d )  flag: d <= $1<<16+$2},3,10,begin{}BEGIN_STACK,0,3,0)
__{}__{}    jp    c, format({%-11s},begin{}BEGIN_STACK); 3:10      __INFO
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d> until
dnl # ( d -- d )
define({_2DUP_PUSH2_DGT_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DGT_UNTIL},{2dup $1 $2 d> until BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DGT_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- d )  flag: d > $1<<16+$2},3,10,3,0,begin{}BEGIN_STACK,0)
__{}__{}    jp   nc, format({%-11s},begin{}BEGIN_STACK); 3:10      __INFO
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ------ begin while repeat ---------
dnl
dnl # begin ... flag while    ...   repeat
dnl # do  { ... if (!) break; ... } while (1)
dnl
dnl # ( -- )
define({REPEAT},{dnl
__{}__ADD_TOKEN({__TOKEN_REPEAT},{repeat},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_REPEAT},{dnl
__{}define({__INFO},{repeat}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    jp   begin{}BEGIN_STACK       ; 3:10      repeat BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           repeat BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl # ( flag -- )
define({WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_WHILE},{while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, break{}BEGIN_STACK   ; 3:10      __INFO})}){}dnl
dnl
dnl
dnl # ( flag -- flag )
define({DUP_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_WHILE},{dup_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_WHILE},{dnl
__{}define({__INFO},{dup_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       dup_while BEGIN_STACK
    or    L             ; 1:4       dup_while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      dup_while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # ( addr -- addr )
define({DUP_CFETCH_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_CFETCH_WHILE},{dup_cfetch_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_CFETCH_WHILE},{dnl
__{}define({__INFO},{dup_cfetch_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A,(HL)        ; 1:7       dup C@ while BEGIN_STACK   ( addr -- addr )
    or    A             ; 1:4       dup C@ while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      dup C@ while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # ( addr -- addr )
define({DUP_CFETCH_0EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_CFETCH_0EQ_WHILE},{dup_cfetch 0=_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_CFETCH_0EQ_WHILE},{dnl
__{}define({__INFO},{dup_cfetch 0=_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A,(HL)        ; 1:7       dup C@ 0= while BEGIN_STACK   ( addr -- addr )
    or    A             ; 1:4       dup C@ 0= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      dup C@ 0= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # ( addr x -- addr x )
define({OVER_CFETCH_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_CFETCH_WHILE},{over cfetch_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_CFETCH_WHILE},{dnl
__{}define({__INFO},{over cfetch_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A,(DE)        ; 1:7       over C@ while BEGIN_STACK   ( addr x -- addr x )
    or    A             ; 1:4       over C@ while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      over C@ while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # ( addr x -- addr x )
define({OVER_CFETCH_0EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_CFETCH_0EQ_WHILE},{over cfetch 0=_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_CFETCH_0EQ_WHILE},{dnl
__{}define({__INFO},{over cfetch 0=_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A,(DE)        ; 1:7       over C@ 0= while BEGIN_STACK   ( addr x -- addr x )
    or    A             ; 1:4       over C@ 0= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      over C@ 0= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # 2over nip c@ 0 c= while
dnl # ( addr d -- addr d )
define({_2OVER_NIP_CFETCH_0CEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_CFETCH_0CEQ_WHILE},{2over nip cfetch 0c= while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_CFETCH_0CEQ_WHILE},{dnl
__{}define({__INFO},{2over nip cfetch 0c= while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{define({_TMP_INFO},{2over nip c@ 0 c= while BEGIN_STACK})
__{}                        ;[7:42]     _TMP_INFO   ( addr d -- addr d )
__{}    pop  BC             ; 1:10      _TMP_INFO   BC = addr
__{}    push BC             ; 1:11      _TMP_INFO
__{}    ld    A,(BC)        ; 1:7       _TMP_INFO
__{}    or    A             ; 1:4       _TMP_INFO
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl # rot 1+ -rot 2over nip c@ 0 c<> while
dnl # ( addr d -- addr++ d )
define({ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE},{rot_1add_nrot_2over nip cfetch 0c<>while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE},{dnl
__{}define({__INFO},{rot_1add_nrot_2over nip cfetch 0c<>while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{define({_TMP_INFO},{rot 1+ -rot 2over nip c@ 0 c<> while BEGIN_STACK})
__{}                        ;[8:48]     _TMP_INFO   ( addr d -- addr++ d )
__{}    pop  BC             ; 1:10      _TMP_INFO
__{}    inc  BC             ; 1:6       _TMP_INFO   BC = addr++
__{}    push BC             ; 1:11      _TMP_INFO
__{}    ld    A,(BC)        ; 1:7       _TMP_INFO
__{}    or    A             ; 1:4       _TMP_INFO
__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl # rot 1+ -rot 2over nip c@ 0 c<> while 2over nip c@
dnl # ( addr d -- addr++ d )
define({ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE_2OVER_NIP_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE_2OVER_NIP_CFETCH},{rot_1add_nrot_2over nip cfetch 0c<>while_2over nip cfetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE_2OVER_NIP_CFETCH},{dnl
__{}define({__INFO},{rot_1add_nrot_2over nip cfetch 0c<>while_2over nip cfetch}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{define({_TMP_INFO},{rot 1+ -rot 2over nip c@ 0 c<> while BEGIN_STACK 2over nip c@})
__{}                       ;[13:74]     _TMP_INFO   ( addr d -- addr++ d )
__{}    pop  BC             ; 1:10      _TMP_INFO
__{}    inc  BC             ; 1:6       _TMP_INFO   BC = addr++
__{}    push BC             ; 1:11      _TMP_INFO
__{}    ld    A,(BC)        ; 1:7       _TMP_INFO
__{}    or    A             ; 1:4       _TMP_INFO
__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO
__{}    push DE             ; 1:11      _TMP_INFO
__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}    ld    L, A          ; 1:4       _TMP_INFO
__{}    ld    H, 0x00       ; 2:7       _TMP_INFO})}){}dnl
dnl
dnl
dnl # ------ $1 $2 within while ( a -- ) ---------
dnl
dnl # ( n -- )
dnl # $1 $2 within while
define({PUSH2_WITHIN_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_WITHIN_WHILE},{$1 $2 within_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_WITHIN_WHILE},{dnl
__{}define({__INFO},{$1 $2 within_while}){}dnl
ifelse(dnl
BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
$1,{},{
__{}  .error {$0}(): Missing parameter!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},{$1 $2 within while BEGIN_STACK}){}dnl
__{}__{}define({PUSH2_WITHIN_WHILE_CODE},__WITHIN($1,$2))
__{}                        ;format({%-11s},[eval(5+__WITHIN_B):eval(24+__WITHIN_C)])_TMP_INFO   ( {TOS} -- )  true=($1<={TOS}<$2){}dnl
__{}PUSH2_WITHIN_WHILE_CODE
__{}    ex   DE, HL         ; 1:4       _TMP_INFO
__{}    pop  DE             ; 1:10      _TMP_INFO
__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl # ( n -- n )
dnl # $1 $2 within while
define({DUP_PUSH2_WITHIN_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH2_WITHIN_WHILE},{dup $1 $2 within_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH2_WITHIN_WHILE},{dnl
__{}define({__INFO},{dup $1 $2 within_while}){}dnl
ifelse(dnl
BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
$1,{},{
__{}  .error {$0}(): Missing parameter!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},{dup $1 $2 within while BEGIN_STACK}){}dnl
__{}__{}define({DUP_PUSH2_WITHIN_WHILE_CODE},__SAVE_HL_WITHIN($1,$2))
__{}                        ;format({%-11s},[eval(3+__SAVE_HL_WITHIN_B):eval(10+__SAVE_HL_WITHIN_C)])_TMP_INFO   ( x -- x )  true=($1<=x<$2){}dnl
__{}DUP_PUSH2_WITHIN_WHILE_CODE
__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      _TMP_INFO})}){}dnl
dnl
dnl
dnl
dnl # ------ 2dup ucond while ( b a -- b a ) ---------
dnl
define({_2DUP_UEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UEQ_WHILE},{2dup_ueq_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UEQ_WHILE},{dnl
__{}define({__INFO},{2dup_ueq_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup u= while BEGIN_STACK
    sub   L             ; 1:4       2dup u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup u= while BEGIN_STACK
    ld    A, D          ; 1:4       2dup u= while BEGIN_STACK
    sub   H             ; 1:4       2dup u= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup u= while BEGIN_STACK})}){}dnl
dnl
dnl
define({_2DUP_UNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UNE_WHILE},{2dup_une_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UNE_WHILE},{dnl
__{}define({__INFO},{2dup_une_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup u<> while BEGIN_STACK
    sub   L             ; 1:4       2dup u<> while BEGIN_STACK
    jr   nz, $+7        ; 2:7/12    2dup u<> while BEGIN_STACK
    ld    A, D          ; 1:4       2dup u<> while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup u<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup u<> while BEGIN_STACK})}){}dnl
dnl
dnl
define({_2DUP_ULT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_ULT_WHILE},{2dup_ult_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_ULT_WHILE},{dnl
__{}define({__INFO},{2dup_ult_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       2dup u< while BEGIN_STACK    DE<HL --> DE-HL<0 --> no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup u< while BEGIN_STACK})}){}dnl
dnl
dnl
define({_2DUP_UGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UGE_WHILE},{2dup_uge_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UGE_WHILE},{dnl
__{}define({__INFO},{2dup_uge_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> carry if false
    sub   L             ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> carry if false
    ld    A, D          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> carry if false
    sbc   A, H          ; 1:4       2dup u>= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      2dup u>= while BEGIN_STACK})}){}dnl
dnl
dnl
define({_2DUP_ULE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_ULE_WHILE},{2dup_ule_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_ULE_WHILE},{dnl
__{}define({__INFO},{2dup_ule_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> carry if false
    sub   E             ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> carry if false
    ld    A, H          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> carry if false
    sbc   A, D          ; 1:4       2dup u<= while BEGIN_STACK    DE<=HL --> 0<=HL-DE --> carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      2dup u<= while BEGIN_STACK})}){}dnl
dnl
dnl
define({_2DUP_UGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_UGT_WHILE},{2dup_ugt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_UGT_WHILE},{dnl
__{}define({__INFO},{2dup_ugt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> no carry if false
    sub   E             ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> no carry if false
    ld    A, H          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> no carry if false
    sbc   A, D          ; 1:4       2dup u> while BEGIN_STACK    DE>HL --> 0>HL-DE --> no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup u> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # ------ 2dup scond while ( b a -- b a ) ---------
dnl
dnl # 2dup = while
define({_2DUP_EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_EQ_WHILE},{2dup_eq_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_EQ_WHILE},{dnl
__{}define({__INFO},{2dup_eq_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup = while BEGIN_STACK
    sub   L             ; 1:4       2dup = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup = while BEGIN_STACK
    ld    A, D          ; 1:4       2dup = while BEGIN_STACK
    sub   H             ; 1:4       2dup = while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup = while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # 2dup <> while
define({_2DUP_NE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_NE_WHILE},{2dup_ne_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_NE_WHILE},{dnl
__{}define({__INFO},{2dup_ne_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup <> while BEGIN_STACK
    sub   L             ; 1:4       2dup <> while BEGIN_STACK
    jr   nz, $+7        ; 2:7/12    2dup <> while BEGIN_STACK
    ld    A, D          ; 1:4       2dup <> while BEGIN_STACK
    sub   H             ; 1:4       2dup <> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup <> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # 2dup < while
define({_2DUP_LT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_LT_WHILE},{2dup_lt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_LT_WHILE},{dnl
__{}define({__INFO},{2dup_lt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       2dup < while BEGIN_STACK    DE<HL --> DE-HL<0 --> no carry if false
    rra                 ; 1:4       2dup < while BEGIN_STACK
    xor   D             ; 1:4       2dup < while BEGIN_STACK
    xor   H             ; 1:4       2dup < while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup < while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # 2dup >= while
define({_2DUP_GE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_GE_WHILE},{2dup_ge_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_GE_WHILE},{dnl
__{}define({__INFO},{2dup_ge_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, E          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> carry if false
    sub   L             ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> carry if false
    ld    A, D          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> carry if false
    sbc   A, H          ; 1:4       2dup >= while BEGIN_STACK    DE>=HL --> DE-HL>=0 --> carry if false
    rra                 ; 1:4       2dup >= while BEGIN_STACK
    xor   D             ; 1:4       2dup >= while BEGIN_STACK
    xor   H             ; 1:4       2dup >= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      2dup >= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # 2dup <= while
define({_2DUP_LE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_LE_WHILE},{2dup_le_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_LE_WHILE},{dnl
__{}define({__INFO},{2dup_le_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> carry if false
    sub   E             ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> carry if false
    ld    A, H          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> carry if false
    sbc   A, D          ; 1:4       2dup <= while BEGIN_STACK    DE<=HL --> HL-DE>=0 --> carry if false
    rra                 ; 1:4       2dup <= while BEGIN_STACK
    xor   D             ; 1:4       2dup <= while BEGIN_STACK
    xor   H             ; 1:4       2dup <= while BEGIN_STACK
    jp    m, break{}BEGIN_STACK   ; 3:10      2dup <= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # 2dup > while
define({_2DUP_GT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_GT_WHILE},{2dup_gt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_GT_WHILE},{dnl
__{}define({__INFO},{2dup_gt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, L          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> no carry if false
    sub   E             ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> no carry if false
    ld    A, H          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> no carry if false
    sbc   A, D          ; 1:4       2dup > while BEGIN_STACK    DE>HL --> HL-DE<0 --> no carry if false
    rra                 ; 1:4       2dup > while BEGIN_STACK
    xor   D             ; 1:4       2dup > while BEGIN_STACK
    xor   H             ; 1:4       2dup > while BEGIN_STACK
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup > while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl
dnl # ------ ucond while ( b a -- b a ) ---------
dnl
define({UEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_EQ_WHILE},{u= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UEQ_WHILE},{dnl
__{}__ASM_TOKEN_EQ_WHILE($@){}dnl
}){}dnl
dnl
dnl
dnl
define({UNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_NE_WHILE},{u<> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UNE_WHILE},{dnl
__{}__ASM_TOKEN_NE_WHILE($@){}dnl
}){}dnl
dnl
dnl
dnl
define({ULT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_ULT_WHILE},{u< while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>0),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x2 x1 -- )}){}dnl
__{}__{}__MAKE_CODE_ULT_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({UGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_UGE_WHILE},{u>= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>0),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x2 x1 -- )}){}dnl
__{}__{}__MAKE_CODE_UGE_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({ULE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_ULE_WHILE},{u<= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ULE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>0),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x2 x1 -- )}){}dnl
__{}__{}__MAKE_CODE_ULE_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({UGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_UGT_WHILE},{u> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UGT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>0),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x2 x1 -- )}){}dnl
__{}__{}__MAKE_CODE_UGT_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # ------ scond while ( b a -- ) ---------
dnl
dnl # = while
define({EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_EQ_WHILE},{= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_EQ_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 == x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_EQ_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # <> while
define({NE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_NE_WHILE},{<> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 <> x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_NE_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # < while
define({LT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_LT_WHILE},{< while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 < x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_LT_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # >= while
define({GE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_GE_WHILE},{>= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 >= x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_GE_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # <= while
define({LE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_LE_WHILE},{<= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 <= x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_LE_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # > while
define({GT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_GT_WHILE},{> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_GT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_STACK_INFO},( x2 x1 -- )  flag: x2 > x1){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{dnl
__{}__{}__MAKE_CODE_GT_DROP_JP_FALSE(break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ----------------------- 8 bit -----------------------
dnl # ------- dup const scond while ( b a -- b a ) ---------
dnl
dnl
dnl # dup const = while
define({DUP_PUSH_CEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CEQ_WHILE},{dup_push_ceq_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CEQ_WHILE},{dnl
__{}define({__INFO},{dup_push_ceq_while}){}dnl
ifelse(dnl
BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
$1,{},{
__{}.error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}.error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},{dup $1 c= while BEGIN_STACK}){}dnl
__{}define({_TMP_STACK_INFO},{_TMP_INFO   ( x1 -- x1 )   $1 == HL}){}dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
__{}    ld    A,format({%-12s},$1); 3:13      _TMP_STACK_INFO
__{}    cp    L             ; 1:4       _TMP_INFO
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
__{}__IS_NUM($1),{0},{
__{}    ld    A, format({%-11s},$1); 2:7       _TMP_STACK_INFO
__{}    cp    L             ; 1:4       _TMP_INFO
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
{ifelse(eval($1),{0},{
__{}__{}    ld    A, L          ; 1:4       _TMP_STACK_INFO
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
__{}{
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       _TMP_STACK_INFO
__{}__{}    cp    L             ; 1:4       _TMP_INFO
__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO})})})}){}dnl
dnl
dnl
dnl
dnl # dup const <> while
define({DUP_PUSH_CNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CNE_WHILE},{dup_push_cne_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CNE_WHILE},{dnl
__{}define({__INFO},{dup_push_cne_while}){}dnl
ifelse(dnl
BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
$1,{},{
__{}.error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}.error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},{dup $1 c<> while BEGIN_STACK}){}dnl
__{}define({_TMP_STACK_INFO},{_TMP_INFO   ( x1 -- x1 )   $1 == HL}){}dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
__{}    ld    A,format({%-12s},$1); 3:13      _TMP_STACK_INFO
__{}    cp    L             ; 1:4       _TMP_INFO
__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
__{}__IS_NUM($1),{0},{
__{}    ld    A, format({%-11s},$1); 2:7       _TMP_STACK_INFO
__{}    cp    L             ; 1:4       _TMP_INFO
__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
{ifelse(eval($1),{0},{
__{}__{}    ld    A, L          ; 1:4       _TMP_STACK_INFO
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
__{}{
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       _TMP_STACK_INFO
__{}__{}    cp    L             ; 1:4       _TMP_INFO
__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO})})})}){}dnl
dnl
dnl
dnl
dnl
dnl # -------------------- 16 bit ----------------------
dnl # ------- const scond while ( b a -- b ) -----------
dnl
dnl
dnl # const = while
define({PUSH_EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_EQ_WHILE},{$1 = while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_EQ_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )   $1 == HL}){}dnl
__{}__{}__MAKE_CODE_PUSH_EQ_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const <> while
define({PUSH_NE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_NE_WHILE},{$1 <> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_NE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )   $1 <> HL}){}dnl
__{}__{}__MAKE_CODE_PUSH_NE_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const < while
define({PUSH_LT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_LT_WHILE},{$1 < while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_LT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_LT_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const <= while
define({PUSH_LE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_LE_WHILE},{$1 <= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_LE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_LE_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const >= while
define({PUSH_GE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_GE_WHILE},{$1 >= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_GE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_GE_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const > while
define({PUSH_GT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_GT_WHILE},{$1 > while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_GT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_GT_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ------- const ucond while ( a -- ) -----------
dnl
dnl
dnl # const = while
define({PUSH_UEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_EQ_WHILE},{$1 u= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UEQ_WHILE},{dnl
__{}__ASM_TOKEN_PUSH_EQ_WHILE($@){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const u<> while
define({PUSH_UNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_NE_WHILE},{$1 u<> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UNE_WHILE},{dnl
__{}__ASM_TOKEN_PUSH_NE_WHILE($@){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const u< while
define({PUSH_ULT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ULT_WHILE},{$1 u< while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ULT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_ULT_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const <= while
define({PUSH_ULE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ULE_WHILE},{$1 u<= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ULE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_ULE_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const u>= while
define({PUSH_UGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_UGE_WHILE},{$1 u>= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UGE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_UGE_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # const u> while
define({PUSH_UGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_UGT_WHILE},{$1 u> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UGT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- )}){}dnl
__{}__{}__MAKE_CODE_PUSH_UGT_DROP_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ----------------------- 16 bit -----------------------
dnl # ------- dup const scond while ( a -- a ) ---------
dnl
dnl
dnl # dup const = while
define({DUP_PUSH_EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_EQ_WHILE},{dup $1 = while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_EQ_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_EQ_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const <> while
define({DUP_PUSH_NE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_NE_WHILE},{dup $1 <> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_NE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__MAKE_CODE_DUP_PUSH_NE_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const < while
define({DUP_PUSH_LT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_LT_WHILE},{dup $1 < while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_LT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- x )}){}dnl
__{}__{}__MAKE_CODE_DUP_PUSH_LT_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const >= while
define({DUP_PUSH_GE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_GE_WHILE},{dup $1 >= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_GE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- x )}){}dnl
__{}__{}__MAKE_CODE_DUP_PUSH_GE_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const <= while
define({DUP_PUSH_LE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_LE_WHILE},{dup $1 <= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_LE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- x )}){}dnl
__{}__{}__MAKE_CODE_DUP_PUSH_LE_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup const > while
define({DUP_PUSH_GT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_GT_WHILE},{dup $1 > while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_GT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_STACK_INFO},{( x -- x )}){}dnl
__{}__{}__MAKE_CODE_DUP_PUSH_GT_JP_FALSE($1,break{}BEGIN_STACK){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ------ dup const ucond while ( b a -- b a ) ---------
dnl
dnl
dnl
define({DUP_PUSH_UEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_EQ_WHILE},{dup $1 u= while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UEQ_WHILE},{dnl
__{}define({__INFO},{dup_push_ueq_while}){}dnl
__{}__ASM_TOKEN_DUP_PUSH_EQ_WHILE($1)}){}dnl
dnl
dnl
define({DUP_PUSH_UNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_NE_WHILE},{dup $1 u<> while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UNE_WHILE},{dnl
__{}define({__INFO},{dup_push_une_while}){}dnl
__{}__ASM_TOKEN_DUP_PUSH_NE_WHILE($1)}){}dnl
dnl
dnl
define({DUP_PUSH_ULT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ULT_WHILE},{dup_push_ult_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ULT_WHILE},{dnl
__{}define({__INFO},{dup_push_ult_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, L          ; 1:4       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> no carry if false
    sub   low format({%-10s},$1); 2:7       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> no carry if false
    ld    A, H          ; 1:4       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> no carry if false
    sbc   A, high format({%-6s},$1); 2:7       dup $1 u< while BEGIN_STACK    HL<$1 --> HL-$1<0 --> no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 u< while BEGIN_STACK})}){}dnl
dnl
dnl
define({DUP_PUSH_UGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UGE_WHILE},{dup_push_uge_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UGE_WHILE},{dnl
__{}define({__INFO},{dup_push_uge_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, L          ; 1:4       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> carry if false
    sub   low format({%-10s},$1); 2:7       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> carry if false
    ld    A, H          ; 1:4       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> carry if false
    sbc   A, high format({%-6s},$1); 2:7       dup $1 u>= while BEGIN_STACK    HL>=$1 --> HL-$1>=0 --> carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 u>= while BEGIN_STACK})}){}dnl
dnl
dnl
define({DUP_PUSH_ULE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ULE_WHILE},{dup_push_ule_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ULE_WHILE},{dnl
__{}define({__INFO},{dup_push_ule_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> carry if false
    sub   L             ; 1:4       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> carry if false
    ld    A, high format({%-6s},$1); 2:7       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> carry if false
    sbc   A, H          ; 1:4       dup $1 u<= while BEGIN_STACK    HL<=$1 --> 0<=$1-HL --> carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      dup $1 u<= while BEGIN_STACK})}){}dnl
dnl
dnl
define({DUP_PUSH_UGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_UGT_WHILE},{dup_push_ugt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_UGT_WHILE},{dnl
__{}define({__INFO},{dup_push_ugt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}.error {$0}(): Missing parameter!},
{
    ld    A, low format({%-7s},$1); 2:7       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> no carry if false
    sub   L             ; 1:4       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> no carry if false
    ld    A, high format({%-6s},$1); 2:7       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> no carry if false
    sbc   A, H          ; 1:4       dup $1 u> while BEGIN_STACK    HL>$1 --> 0>$1-HL --> no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      dup $1 u> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl # ---------------------------------------------------------------------------
dnl # Device
dnl # ---------------------------------------------------------------------------
dnl
dnl
dnl
dnl # ( mask -- ) 
dnl # Check test key
define({TESTKEY_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_TESTKEY_UNTIL},{testkey until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TESTKEY_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}__{}    ld    A, H          ; 1:4       __INFO   ( mask -- )
__{}__{}    in    A,(0xFE)      ; 2:11      __INFO
__{}__{}    and   L             ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( mask -- ) 
dnl # Check test key
define({TESTKEY_0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_TESTKEY_0EQ_UNTIL},{testkey 0= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TESTKEY_0EQ_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}__{}    ld    A, H          ; 1:4       __INFO   ( mask -- )
__{}__{}    in    A,(0xFE)      ; 2:11      __INFO
__{}__{}    and   L             ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    z, begin{}BEGIN_STACK   ; 3:10      __INFO
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- ) 
dnl # Check test key
define({PUSH_TESTKEY_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_TESTKEY_UNTIL},{$1 testkey until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_TESTKEY_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__IS_NUM($1),1,{
__{}__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO},
__{}__{}{
__{}__{}__{}    ld    A,high __FORM({%-7s},$1); 2:7       __INFO}){}dnl
__{}__{}   ( -- )  if press {}dnl
__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL($1),__TESTKEY_B,           {{"B"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_H,           {{"H"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Y,           {{"Y"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_6,           {{"6"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_5,           {{"5"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_T,           {{"T"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_G,           {{"G"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_V,           {{"V"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_N,           {{"N"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_J,           {{"J"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_U,           {{"U"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_7,           {{"7"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_4,           {{"4"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_R,           {{"R"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_F,           {{"F"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_C,           {{"C"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_M,           {{"M"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_K,           {{"K"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_I,           {{"I"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_8,           {{"8"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_3,           {{"3"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_E,           {{"E"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_D,           {{"D"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_X,           {{"X"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_SYMBOL_SHIFT,{{"SYMBOL SHIFT"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_L,           {{"L"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_O,           {{"O"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_9,           {{"9"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_2,           {{"2"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_W,           {{"W"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_S,           {{"S"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Z,           {{"Z"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_SPACE,       {{"SPACE"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_ENTER,       {{"ENTER"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_P,           {{"P"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_0,           {{"0"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_1,           {{"1"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Q,           {{"Q"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_A,           {{"A"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_CAPS_SHIFT,  {{"CAPS SHIFT"}},
__{}__{}__{}{"???"})
__{}__{}    in    A,(0xFE)      ; 2:11      __INFO{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_L($1),0x01,{
__{}__{}__{}    rrca                ; 1:4       __INFO
__{}__{}__{}    jp    c, begin{}BEGIN_STACK   ; 3:10      __INFO},
__{}__{}__IS_NUM($1),1,{
__{}__{}__{}    and  __HEX_L($1)           ; 2:7       __INFO
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}    and  low __FORM({%-11s},$1); 2:7       __INFO
__{}__{}__{}    jp   nz, begin{}BEGIN_STACK   ; 3:10      __INFO{}dnl
__{}__{}})
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- ) 
dnl # Check test key
define({PUSH_TESTKEY_0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_TESTKEY_0EQ_UNTIL},{$1 testkey 0= until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_TESTKEY_0EQ_UNTIL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__IS_NUM($1),1,{
__{}__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO},
__{}__{}{
__{}__{}__{}    ld    A,high __FORM({%-7s},$1); 2:7       __INFO}){}dnl
__{}__{}   ( -- )  if press {}dnl
__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL($1),__TESTKEY_B,           {{"B"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_H,           {{"H"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Y,           {{"Y"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_6,           {{"6"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_5,           {{"5"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_T,           {{"T"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_G,           {{"G"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_V,           {{"V"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_N,           {{"N"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_J,           {{"J"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_U,           {{"U"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_7,           {{"7"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_4,           {{"4"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_R,           {{"R"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_F,           {{"F"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_C,           {{"C"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_M,           {{"M"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_K,           {{"K"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_I,           {{"I"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_8,           {{"8"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_3,           {{"3"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_E,           {{"E"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_D,           {{"D"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_X,           {{"X"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_SYMBOL_SHIFT,{{"SYMBOL SHIFT"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_L,           {{"L"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_O,           {{"O"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_9,           {{"9"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_2,           {{"2"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_W,           {{"W"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_S,           {{"S"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Z,           {{"Z"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_SPACE,       {{"SPACE"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_ENTER,       {{"ENTER"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_P,           {{"P"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_0,           {{"0"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_1,           {{"1"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Q,           {{"Q"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_A,           {{"A"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_CAPS_SHIFT,  {{"CAPS SHIFT"}},
__{}__{}__{}{"???"})
__{}__{}    in    A,(0xFE)      ; 2:11      __INFO{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_L($1),0x01,{
__{}__{}__{}    rrca                ; 1:4       __INFO
__{}__{}__{}    jp   nc, begin{}BEGIN_STACK   ; 3:10      __INFO},
__{}__{}__IS_NUM($1),1,{
__{}__{}__{}    and  __HEX_L($1)           ; 2:7       __INFO
__{}__{}__{}    jp    z, begin{}BEGIN_STACK   ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}    and  low __FORM({%-11s},$1); 2:7       __INFO
__{}__{}__{}    jp    z, begin{}BEGIN_STACK   ; 3:10      __INFO{}dnl
__{}__{}})
__{}__{}break{}BEGIN_STACK:               ;           __INFO{}dnl
__{}__{}popdef({BEGIN_STACK}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( mask -- ) 
dnl # Check test key
define({TESTKEY_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_TESTKEY_WHILE},{testkey while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TESTKEY_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}__{}    ld    A, H          ; 1:4       __INFO   ( mask -- )
__{}__{}    in    A,(0xFE)      ; 2:11      __INFO
__{}__{}    and   L             ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( mask -- ) 
dnl # Check test key
define({TESTKEY_0EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_TESTKEY_0EQ_WHILE},{testkey 0= while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TESTKEY_0EQ_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}__{}    ld    A, H          ; 1:4       __INFO   ( mask -- )
__{}__{}    in    A,(0xFE)      ; 2:11      __INFO
__{}__{}    and   L             ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- ) 
dnl # Check test key
define({PUSH_TESTKEY_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_TESTKEY_WHILE},{$1 testkey while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_TESTKEY_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__IS_NUM($1),1,{
__{}__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO},
__{}__{}{
__{}__{}__{}    ld    A,high __FORM({%-7s},$1); 2:7       __INFO}){}dnl
__{}__{}   ( -- )  if press {}dnl
__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL($1),__TESTKEY_B,           {{"B"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_H,           {{"H"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Y,           {{"Y"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_6,           {{"6"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_5,           {{"5"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_T,           {{"T"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_G,           {{"G"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_V,           {{"V"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_N,           {{"N"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_J,           {{"J"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_U,           {{"U"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_7,           {{"7"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_4,           {{"4"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_R,           {{"R"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_F,           {{"F"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_C,           {{"C"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_M,           {{"M"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_K,           {{"K"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_I,           {{"I"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_8,           {{"8"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_3,           {{"3"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_E,           {{"E"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_D,           {{"D"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_X,           {{"X"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_SYMBOL_SHIFT,{{"SYMBOL SHIFT"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_L,           {{"L"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_O,           {{"O"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_9,           {{"9"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_2,           {{"2"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_W,           {{"W"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_S,           {{"S"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Z,           {{"Z"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_SPACE,       {{"SPACE"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_ENTER,       {{"ENTER"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_P,           {{"P"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_0,           {{"0"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_1,           {{"1"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Q,           {{"Q"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_A,           {{"A"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_CAPS_SHIFT,  {{"CAPS SHIFT"}},
__{}__{}__{}{"???"})
__{}__{}    in    A,(0xFE)      ; 2:11      __INFO{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_L($1),0x01,{
__{}__{}__{}    rrca                ; 1:4       __INFO
__{}__{}__{}    jp    c, break{}BEGIN_STACK   ; 3:10      __INFO},
__{}__{}__IS_NUM($1),1,{
__{}__{}__{}    and  __HEX_L($1)           ; 2:7       __INFO
__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}    and  low __FORM({%-11s},$1); 2:7       __INFO
__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO{}dnl
__{}__{}}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- ) 
dnl # Check test key
define({PUSH_TESTKEY_0EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_TESTKEY_0EQ_WHILE},{$1 testkey 0= while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_TESTKEY_0EQ_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__IS_NUM($1),1,{
__{}__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO},
__{}__{}{
__{}__{}__{}    ld    A,high __FORM({%-7s},$1); 2:7       __INFO}){}dnl
__{}__{}   ( -- )  if press {}dnl
__{}__{}ifelse(dnl
__{}__{}__{}__HEX_HL($1),__TESTKEY_B,           {{"B"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_H,           {{"H"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Y,           {{"Y"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_6,           {{"6"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_5,           {{"5"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_T,           {{"T"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_G,           {{"G"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_V,           {{"V"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_N,           {{"N"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_J,           {{"J"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_U,           {{"U"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_7,           {{"7"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_4,           {{"4"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_R,           {{"R"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_F,           {{"F"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_C,           {{"C"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_M,           {{"M"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_K,           {{"K"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_I,           {{"I"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_8,           {{"8"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_3,           {{"3"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_E,           {{"E"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_D,           {{"D"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_X,           {{"X"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_SYMBOL_SHIFT,{{"SYMBOL SHIFT"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_L,           {{"L"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_O,           {{"O"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_9,           {{"9"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_2,           {{"2"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_W,           {{"W"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_S,           {{"S"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Z,           {{"Z"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_SPACE,       {{"SPACE"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_ENTER,       {{"ENTER"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_P,           {{"P"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_0,           {{"0"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_1,           {{"1"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_Q,           {{"Q"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_A,           {{"A"}},
__{}__{}__{}__HEX_HL($1),__TESTKEY_CAPS_SHIFT,  {{"CAPS SHIFT"}},
__{}__{}__{}{"???"})
__{}__{}    in    A,(0xFE)      ; 2:11      __INFO{}dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_L($1),0x01,{
__{}__{}__{}    rrca                ; 1:4       __INFO
__{}__{}__{}    jp   nc, break{}BEGIN_STACK   ; 3:10      __INFO},
__{}__{}__IS_NUM($1),1,{
__{}__{}__{}    and  __HEX_L($1)           ; 2:7       __INFO
__{}__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}    and  low __FORM({%-11s},$1); 2:7       __INFO
__{}__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      __INFO{}dnl
__{}__{}}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ----------------------- 32 bit -----------------------
dnl # ------ signed_32_bit_cond while ( d2 d1 -- ) ---------
dnl
dnl # D= while
define({DEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DEQ_WHILE},{deq_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DEQ_WHILE},{dnl
__{}define({__INFO},{deq_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
                       ;[14:91]     D= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D= while BEGIN_STACK   lo_2
    or    A             ; 1:4       D= while BEGIN_STACK
    sbc  HL, BC         ; 2:15      D= while BEGIN_STACK   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> no zero if false
    pop  HL             ; 1:10      D= while BEGIN_STACK   hi_2
    jr   nz, $+4        ; 2:7/12    D= while BEGIN_STACK
    sbc  HL, DE         ; 2:15      D= while BEGIN_STACK   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> no zero if false
    pop  HL             ; 1:10      D= while BEGIN_STACK
    pop  DE             ; 1:10      D= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      D= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # D<> while
define({DNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DNE_WHILE},{dne_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DNE_WHILE},{dnl
__{}define({__INFO},{dne_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
                       ;[14:91]     D<> while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> while BEGIN_STACK   lo_2
    or    A             ; 1:4       D<> while BEGIN_STACK
    sbc  HL, BC         ; 2:15      D<> while BEGIN_STACK   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> zero if false
    pop  HL             ; 1:10      D<> while BEGIN_STACK   hi_2
    jr   nz, $+4        ; 2:7/12    D<> while BEGIN_STACK
    sbc  HL, DE         ; 2:15      D<> while BEGIN_STACK   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> zero if false
    pop  HL             ; 1:10      D<> while BEGIN_STACK
    pop  DE             ; 1:10      D<> while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      D<> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # D< while
define({DLT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DLT_WHILE},{dlt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DLT_WHILE},{dnl
__{}define({__INFO},{dlt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
__{}ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes})){}dnl
                       ;[10:67]     D< while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D< while BEGIN_STACK   l2
    pop  AF             ; 1:10      D< while BEGIN_STACK   h2
    call FCE_DLT        ; 3:17      D< while BEGIN_STACK   no carry if false
    pop  HL             ; 1:10      D< while BEGIN_STACK
    pop  DE             ; 1:10      D< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      D< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # D>= while
define({DGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DGE_WHILE},{dge_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DGE_WHILE},{dnl
__{}define({__INFO},{dge_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
__{}ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes})){}dnl
                       ;[10:67]     D>= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D>= while BEGIN_STACK   l2
    pop  AF             ; 1:10      D>= while BEGIN_STACK   h2
    call FCE_DLT        ; 3:17      D>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    pop  HL             ; 1:10      D>= while BEGIN_STACK
    pop  DE             ; 1:10      D>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      D>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # D<= while
define({DLE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DLE_WHILE},{dle_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DLE_WHILE},{dnl
__{}define({__INFO},{dle_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
__{}ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes})){}dnl
                       ;[10:67]     D<= while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D<= while BEGIN_STACK   l2
    pop  AF             ; 1:10      D<= while BEGIN_STACK   h2
    call FCE_DGT        ; 3:17      D<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    pop  HL             ; 1:10      D<= while BEGIN_STACK
    pop  DE             ; 1:10      D<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      D<= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # D> while
define({DGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DGT_WHILE},{dgt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DGT_WHILE},{dnl
__{}define({__INFO},{dgt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
__{}ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes})){}dnl
                       ;[10:67]     D> while BEGIN_STACK   ( d2 d1 -- )
    pop  BC             ; 1:10      D> while BEGIN_STACK   l2
    pop  AF             ; 1:10      D> while BEGIN_STACK   h2
    call FCE_DGT        ; 3:17      D> while BEGIN_STACK   no carry if false
    pop  HL             ; 1:10      D> while BEGIN_STACK
    pop  DE             ; 1:10      D> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      D> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # ----------------------- 32 bit -----------------------
dnl # ------ unsigned_32_bit_cond while ( ud2 ud1 -- ) ---------
dnl
dnl # Du= while
define({DUEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DEQ_WHILE},{du= while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUEQ_WHILE},{dnl
__{}define({__INFO},{dueq_while}){}dnl
__{}__ASM_TOKEN_DEQ_WHILE}){}dnl
dnl
dnl
dnl # Du<> while
define({DUNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DNE_WHILE},{du<> while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUNE_WHILE},{dnl
__{}define({__INFO},{dune_while}){}dnl
__{}__ASM_TOKEN_DNE_WHILE}){}dnl
dnl
dnl
dnl # Du< while
define({DULT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DULT_WHILE},{dult_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DULT_WHILE},{dnl
__{}define({__INFO},{dult_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:67]     Du< while BEGIN_STACK   ( ud2 ud1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du< while BEGIN_STACK   l2
    pop  AF             ; 1:10      Du< while BEGIN_STACK   h2
    call FCE_DULT       ; 3:17      Du< while BEGIN_STACK   no carry if false
    pop  HL             ; 1:10      Du< while BEGIN_STACK
    pop  DE             ; 1:10      Du< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      Du< while BEGIN_STACK},
{
                       ;[13:81]     Du< while BEGIN_STACK   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du< while BEGIN_STACK   lo_2
    ld    A, C          ; 1:4       Du< while BEGIN_STACK   d2<d1 --> d2-d1<0 --> (SP)BC-DEHL<0 --> no carry if false
    sub   L             ; 1:4       Du< while BEGIN_STACK   C-L<0 --> no carry if false
    ld    A, B          ; 1:4       Du< while BEGIN_STACK
    sbc   A, H          ; 1:4       Du< while BEGIN_STACK   B-H<0 --> no carry if false
    pop  HL             ; 1:10      Du< while BEGIN_STACK   hi_2
    sbc  HL, DE         ; 2:15      Du< while BEGIN_STACK   HL-DE<0 --> no carry if false
    pop  HL             ; 1:10      Du< while BEGIN_STACK
    pop  DE             ; 1:10      Du< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      Du< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # Du>= while
define({DUGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUGE_WHILE},{duge_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUGE_WHILE},{dnl
__{}define({__INFO},{duge_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:67]     Du>= while BEGIN_STACK   ( ud2 ud1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du>= while BEGIN_STACK   l2
    pop  AF             ; 1:10      Du>= while BEGIN_STACK   h2
    call FCE_DULT       ; 3:17      Du>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    pop  HL             ; 1:10      Du>= while BEGIN_STACK
    pop  DE             ; 1:10      Du>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      Du>= while BEGIN_STACK},
{
                       ;[13:81]     Du>= while BEGIN_STACK   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du>= while BEGIN_STACK   lo_2
    ld    A, C          ; 1:4       Du>= while BEGIN_STACK   d2>=d1 --> d2-d1>=0 --> (SP)BC-DEHL>=0 --> carry if false
    sub   L             ; 1:4       Du>= while BEGIN_STACK   C-L>=0 --> carry if false
    ld    A, B          ; 1:4       Du>= while BEGIN_STACK
    sbc   A, H          ; 1:4       Du>= while BEGIN_STACK   B-H>=0 --> carry if false
    pop  HL             ; 1:10      Du>= while BEGIN_STACK   hi_2
    sbc  HL, DE         ; 2:15      Du>= while BEGIN_STACK   HL-DE>=0 --> carry if false
    pop  HL             ; 1:10      Du>= while BEGIN_STACK
    pop  DE             ; 1:10      Du>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      Du>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # Du<= while
define({DULE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DULE_WHILE},{dule_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DULE_WHILE},{dnl
__{}define({__INFO},{dule_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:67]     Du<= while BEGIN_STACK   ( ud2 ud1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du<= while BEGIN_STACK   l2
    pop  AF             ; 1:10      Du<= while BEGIN_STACK   h2
    call FCE_DUGT       ; 3:17      Du<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    pop  HL             ; 1:10      Du<= while BEGIN_STACK
    pop  DE             ; 1:10      Du<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      Du<= while BEGIN_STACK},
{
                       ;[13:88]     Du<= while BEGIN_STACK   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du<= while BEGIN_STACK   lo_2
    or    A             ; 1:4       Du<= while BEGIN_STACK
    sbc  HL, BC         ; 2:15      Du<= while BEGIN_STACK   ud2<=ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> carry if false
    pop  BC             ; 1:10      Du<= while BEGIN_STACK   hi_2
    ex   DE, HL         ; 1:4       Du<= while BEGIN_STACK
    sbc  HL, BC         ; 2:15      Du<= while BEGIN_STACK   hi_2<=hi_1 --> BC<=HL --> 0<=HL-BC --> carry if false
    pop  HL             ; 1:10      Du<= while BEGIN_STACK
    pop  DE             ; 1:10      Du<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      Du<= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl # Du> while
define({DUGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUGT_WHILE},{dugt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUGT_WHILE},{dnl
__{}define({__INFO},{dugt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:67]     Du> while BEGIN_STACK   ( ud2 ud1 -- )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      Du> while BEGIN_STACK   l2
    pop  AF             ; 1:10      Du> while BEGIN_STACK   h2
    call FCE_DUGT       ; 3:17      Du> while BEGIN_STACK   no carry if false
    pop  HL             ; 1:10      Du> while BEGIN_STACK
    pop  DE             ; 1:10      Du> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      Du> while BEGIN_STACK},
{
                       ;[13:88]     Du> while BEGIN_STACK   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du> while BEGIN_STACK   lo_2
    or    A             ; 1:4       Du> while BEGIN_STACK
    sbc  HL, BC         ; 2:15      Du> while BEGIN_STACK   ud2>ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> no carry if false
    pop  BC             ; 1:10      Du> while BEGIN_STACK   hi_2
    ex   DE, HL         ; 1:4       Du> while BEGIN_STACK
    sbc  HL, BC         ; 2:15      Du> while BEGIN_STACK   hi_2>hi_1 --> BC>HL --> 0>HL-BC --> no carry if false
    pop  HL             ; 1:10      Du> while BEGIN_STACK
    pop  DE             ; 1:10      Du> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      Du> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # ----- 4dup signed_32_bit_cond while ( d2 d1 -- d2 d1 ) -----
dnl
dnl
dnl # 4dup D= while
define({_4DUP_DEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DEQ_WHILE},{4dup_deq_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DEQ_WHILE},{dnl
__{}define({__INFO},{4dup_deq_while}){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}_TYP_DOUBLE,{function},{__def({USE_FCE_DEQ},{yes})
__{}                       ;[10:69]     4dup D= while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
__{}    pop  BC             ; 1:10      4dup D= while BEGIN_STACK
__{}    pop  AF             ; 1:10      4dup D= while BEGIN_STACK
__{}    push AF             ; 1:11      4dup D= while BEGIN_STACK
__{}    push BC             ; 1:11      4dup D= while BEGIN_STACK
__{}    call FCE_DEQ        ; 3:17      4dup D= while BEGIN_STACK
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      4dup D= while BEGIN_STACK},
__{}{
__{}                   ;[16:132/73,132] 4dup D= while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
__{}    or   A              ; 1:4       4dup D= while BEGIN_STACK   h2 l2 . h1 l1
__{}    pop  BC             ; 1:10      4dup D= while BEGIN_STACK   h2    . h1 l1  BC = l2 = lo16(d2)
__{}    sbc  HL, BC         ; 2:15      4dup D= while BEGIN_STACK   h2    . h1 --  cp l1-l2
__{}    add  HL, BC         ; 1:11      4dup D= while BEGIN_STACK   h2    . h1 l1  cp l1-l2
__{}    jr   nz, $+7        ; 2:7/12    4dup D= while BEGIN_STACK   h2    . h1 h2
__{}    ex  (SP),HL         ; 1:19      4dup D= while BEGIN_STACK   l1    . h1 h2  HL = h2 = hi16(d2)
__{}    sbc  HL, DE         ; 2:15      4dup D= while BEGIN_STACK   l1    . h1 --  cp h2-h1
__{}    add  HL, DE         ; 1:11      4dup D= while BEGIN_STACK   l1    . h1 h2  cp h2-h1
__{}    ex  (SP),HL         ; 1:19      4dup D= while BEGIN_STACK   h2    . h1 l1  HL = l1
__{}    push BC             ; 1:11      4dup D= while BEGIN_STACK   h2 l2 . h1 l1
__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      4dup D= while BEGIN_STACK   h2 l2 . h1 l1}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 4dup D<> while
define({_4DUP_DNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DNE_WHILE},{4dup_dne_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DNE_WHILE},{dnl
__{}define({__INFO},{4dup_dne_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DEQ},,define({USE_FCE_DEQ},{yes}))
                       ;[10:69]     4dup D<> while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{function})" version can be changed with small,fast,default
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK
    pop  AF             ; 1:10      4dup D<> while BEGIN_STACK
    push AF             ; 1:11      4dup D<> while BEGIN_STACK
    push BC             ; 1:11      4dup D<> while BEGIN_STACK
    call FCE_DEQ        ; 3:17      4dup D<> while BEGIN_STACK   D= zero if true --> D<> zero if false
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK},
_TYP_DOUBLE,{small},{
                   ;[16:73,132/132] 4dup D<> while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{small})" version can be changed with function,fast,default
    or   A              ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D<> while BEGIN_STACK   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D<> while BEGIN_STACK   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D<> while BEGIN_STACK   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D<> while BEGIN_STACK   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D<> while BEGIN_STACK   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D<> while BEGIN_STACK   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D<> while BEGIN_STACK   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2 . h1 l1
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK   h2 l2 . h1 l1},
_TYP_DOUBLE,{fast},{
            ;[23:41,56,113,126/126] 4dup D<> while BEGIN_STACK  ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{fast})" version can be changed with function,small,default
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK   h2    . h1 l1  BC= lo(d2) = l2
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+19       ; 2:7/12    4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  --> exit
    ld    A, B          ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+15       ; 2:7/12    4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  --> exit
    pop  AF             ; 1:10      4dup D<> while BEGIN_STACK   h2    . h1 l1  AF= lo(d2) = l2
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK         . h1 l1  BC= lo(d2) = h2
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2    . h1 l1  BC= lo(d2) = h2
    push AF             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  AF= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  lo(h2) - lo(l1)
    jr   nz, $+7        ; 2:7/12    4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  --> exit
    ld    A, B          ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  A = hi(h2)
    sub   D             ; 1:4       4dup D<> while BEGIN_STACK   h2 l2 . h1 l1  hi(h2) - hi(h1)
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK},
{
            ;[21:51,66,123,122/122] 4dup D<> while BEGIN_STACK   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast
    pop  BC             ; 1:10      4dup D<> while BEGIN_STACK   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> while BEGIN_STACK   h2       . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> while BEGIN_STACK   h2       . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> while BEGIN_STACK   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> while BEGIN_STACK   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while BEGIN_STACK   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> while BEGIN_STACK   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> while BEGIN_STACK   h2       . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> while BEGIN_STACK   h2       . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> while BEGIN_STACK   h2       . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> while BEGIN_STACK   h2 l2    . h1 l1
    jp    z, break{}BEGIN_STACK   ; 3:10      4dup D<> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 4dup D< while
define({_4DUP_DLT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DLT_WHILE},{4dup_dlt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DLT_WHILE},{dnl
__{}define({__INFO},{4dup_dlt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                       ;[10:69]     4dup D< while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D< while BEGIN_STACK
    pop  AF             ; 1:10      4dup D< while BEGIN_STACK
    push AF             ; 1:11      4dup D< while BEGIN_STACK
    push BC             ; 1:11      4dup D< while BEGIN_STACK
    call FCE_DLT        ; 3:17      4dup D< while BEGIN_STACK   no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D< while BEGIN_STACK},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:27]     4dup D< while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< while BEGIN_STACK   no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 4dup D>= while
define({_4DUP_DGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DGE_WHILE},{4dup_dge_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DGE_WHILE},{dnl
__{}define({__INFO},{4dup_dge_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
                       ;[10:69]     4dup D>= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D>= while BEGIN_STACK
    pop  AF             ; 1:10      4dup D>= while BEGIN_STACK
    push AF             ; 1:11      4dup D>= while BEGIN_STACK
    push BC             ; 1:11      4dup D>= while BEGIN_STACK
    call FCE_DLT        ; 3:17      4dup D>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup D>= while BEGIN_STACK},
{define({USE_FCE_4DUP_DLT},{yes})
                        ;[6:27]     4dup D>= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup D>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 4dup D<= while
define({_4DUP_DLE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DLE_WHILE},{4dup_dle_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DLE_WHILE},{dnl
__{}define({__INFO},{4dup_dle_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:69]     4dup D<= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D<= while BEGIN_STACK
    pop  AF             ; 1:10      4dup D<= while BEGIN_STACK
    push AF             ; 1:11      4dup D<= while BEGIN_STACK
    push BC             ; 1:11      4dup D<= while BEGIN_STACK
    call FCE_DGT        ; 3:17      4dup D<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup D<= while BEGIN_STACK},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:27]     4dup D<= while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup D<= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 4dup D> while
define({_4DUP_DGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DGT_WHILE},{4dup_dgt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DGT_WHILE},{dnl
__{}define({__INFO},{4dup_dgt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{fast},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:69]     4dup D> while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    pop  BC             ; 1:10      4dup D> while BEGIN_STACK
    pop  AF             ; 1:10      4dup D> while BEGIN_STACK
    push AF             ; 1:11      4dup D> while BEGIN_STACK
    push BC             ; 1:11      4dup D> while BEGIN_STACK
    call FCE_DGT        ; 3:17      4dup D> while BEGIN_STACK   no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D> while BEGIN_STACK},
{define({USE_FCE_4DUP_DGT},{yes})
                        ;[6:27]     4dup D> while BEGIN_STACK   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> while BEGIN_STACK   no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup D> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl # ----- 4dup unsigned_32_bit_cond while ( ud2 ud1 -- ud2 ud1 ) -----
dnl
dnl
dnl # 4dup Du= while
define({_4DUP_DUEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DEQ_WHILE},{4dup du= while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUEQ_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_4DUP_DEQ_WHILE}){}dnl
dnl
dnl
dnl
dnl # 4dup Du<> while
define({_4DUP_DUNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DNE_WHILE},{4dup du<> while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUNE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_4DUP_DNE_WHILE}){}dnl
dnl
dnl
dnl
dnl # 4dup Du< while
define({_4DUP_DULT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DULT_WHILE},{4dup_dult_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DULT_WHILE},{dnl
__{}define({__INFO},{4dup_dult_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:69]     4dup Du< while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du< while BEGIN_STACK
    pop  AF             ; 1:10      4dup Du< while BEGIN_STACK
    push AF             ; 1:11      4dup Du< while BEGIN_STACK
    push BC             ; 1:11      4dup Du< while BEGIN_STACK
    call FCE_DULT       ; 3:17      4dup Du< while BEGIN_STACK   no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup Du< while BEGIN_STACK},
{
                       ;[15:101]    4dup Du< while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du< while BEGIN_STACK   ud2 < ud1 --> ud2-ud1<0 --> (SP)BC-DEHL<0 --> no carry if false
    ld    A, C          ; 1:4       4dup Du< while BEGIN_STACK
    sub   L             ; 1:4       4dup Du< while BEGIN_STACK   C-L<0 --> no carry if false
    ld    A, B          ; 1:4       4dup Du< while BEGIN_STACK
    sbc   A, H          ; 1:4       4dup Du< while BEGIN_STACK   B-H<0 --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du< while BEGIN_STACK   HL = hi2
    ld    A, L          ; 1:4       4dup Du< while BEGIN_STACK   HLBC-DE(SP)<0 -- no carry if false
    sbc   A, E          ; 1:4       4dup Du< while BEGIN_STACK   L-E<0 --> no carry if false
    ld    A, H          ; 1:4       4dup Du< while BEGIN_STACK
    sbc   A, D          ; 1:4       4dup Du< while BEGIN_STACK   H-D<0 --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du< while BEGIN_STACK
    push BC             ; 1:11      4dup Du< while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup Du< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du>= while
define({_4DUP_DUGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUGE_WHILE},{4dup_duge_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUGE_WHILE},{dnl
__{}define({__INFO},{4dup_duge_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DULT},,define({USE_FCE_DULT},{yes}))
                       ;[10:69]     4dup Du>= while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du>= while BEGIN_STACK
    pop  AF             ; 1:10      4dup Du>= while BEGIN_STACK
    push AF             ; 1:11      4dup Du>= while BEGIN_STACK
    push BC             ; 1:11      4dup Du>= while BEGIN_STACK
    call FCE_DULT       ; 3:17      4dup Du>= while BEGIN_STACK   D< carry if true --> D>= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup Du>= while BEGIN_STACK},
{
                       ;[15:101]    4dup Du>= while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du>= while BEGIN_STACK   ud2 >= ud1 --> ud2-ud1>=0 --> (SP)BC-DEHL>=0 --> carry if false
    ld    A, C          ; 1:4       4dup Du>= while BEGIN_STACK
    sub   L             ; 1:4       4dup Du>= while BEGIN_STACK   C-L>=0 --> carry if false
    ld    A, B          ; 1:4       4dup Du>= while BEGIN_STACK
    sbc   A, H          ; 1:4       4dup Du>= while BEGIN_STACK   B-H>=0 --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du>= while BEGIN_STACK   HL = hi2
    ld    A, L          ; 1:4       4dup Du>= while BEGIN_STACK   HLBC-DE(SP)>=0 -- carry if false
    sbc   A, E          ; 1:4       4dup Du>= while BEGIN_STACK   L-E>=0 --> carry if false
    ld    A, H          ; 1:4       4dup Du>= while BEGIN_STACK
    sbc   A, D          ; 1:4       4dup Du>= while BEGIN_STACK   H-D>=0 --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du>= while BEGIN_STACK
    push BC             ; 1:11      4dup Du>= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup Du>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du<= while
define({_4DUP_DULE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DULE_WHILE},{4dup_dule_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DULE_WHILE},{dnl
__{}define({__INFO},{4dup_dule_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:69]     4dup Du<= while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du<= while BEGIN_STACK
    pop  AF             ; 1:10      4dup Du<= while BEGIN_STACK
    push AF             ; 1:11      4dup Du<= while BEGIN_STACK
    push BC             ; 1:11      4dup Du<= while BEGIN_STACK
    call FCE_DUGT       ; 3:17      4dup Du<= while BEGIN_STACK   D> carry if true --> D<= carry if false
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup Du<= while BEGIN_STACK},
{
                       ;[15:101]    4dup Du<= while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du<= while BEGIN_STACK   ud2 <= ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> carry if false
    ld    A, L          ; 1:4       4dup Du<= while BEGIN_STACK
    sub   C             ; 1:4       4dup Du<= while BEGIN_STACK   0<=L-C --> carry if false
    ld    A, H          ; 1:4       4dup Du<= while BEGIN_STACK
    sbc   A, B          ; 1:4       4dup Du<= while BEGIN_STACK   0<=H-B --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du<= while BEGIN_STACK   HL = hi2
    ld    A, E          ; 1:4       4dup Du<= while BEGIN_STACK   0<=DE(SP)-HLBC -- carry if false
    sbc   A, L          ; 1:4       4dup Du<= while BEGIN_STACK   0<=E-L --> carry if false
    ld    A, D          ; 1:4       4dup Du<= while BEGIN_STACK
    sbc   A, H          ; 1:4       4dup Du<= while BEGIN_STACK   0<=D-H --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du<= while BEGIN_STACK
    push BC             ; 1:11      4dup Du<= while BEGIN_STACK
    jp    c, break{}BEGIN_STACK   ; 3:10      4dup Du<= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 4dup Du> while
define({_4DUP_DUGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DUGT_WHILE},{4dup_dugt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DUGT_WHILE},{dnl
__{}define({__INFO},{4dup_dugt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
_TYP_DOUBLE,{function},{ifdef({USE_FCE_DUGT},,define({USE_FCE_DUGT},{yes}))
                       ;[10:69]     4dup Du> while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      4dup Du> while BEGIN_STACK
    pop  AF             ; 1:10      4dup Du> while BEGIN_STACK
    push AF             ; 1:11      4dup Du> while BEGIN_STACK
    push BC             ; 1:11      4dup Du> while BEGIN_STACK
    call FCE_DUGT       ; 3:17      4dup Du> while BEGIN_STACK   no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup Du> while BEGIN_STACK},
{
                       ;[15:101]    4dup Du> while BEGIN_STACK   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du> while BEGIN_STACK   ud2 > ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> no carry if false
    ld    A, L          ; 1:4       4dup Du> while BEGIN_STACK
    sub   C             ; 1:4       4dup Du> while BEGIN_STACK   0>L-C --> no carry if false
    ld    A, H          ; 1:4       4dup Du> while BEGIN_STACK
    sbc   A, B          ; 1:4       4dup Du> while BEGIN_STACK   0>H-B --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du> while BEGIN_STACK   HL = hi2
    ld    A, E          ; 1:4       4dup Du> while BEGIN_STACK   0>DE(SP)-HLBC -- no carry if false
    sbc   A, L          ; 1:4       4dup Du> while BEGIN_STACK   0>E-L --> no carry if false
    ld    A, D          ; 1:4       4dup Du> while BEGIN_STACK
    sbc   A, H          ; 1:4       4dup Du> while BEGIN_STACK   0>D-H --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du> while BEGIN_STACK
    push BC             ; 1:11      4dup Du> while BEGIN_STACK
    jp   nc, break{}BEGIN_STACK   ; 3:10      4dup Du> while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl
dnl # +============================ 32 bit ===============================+
dnl # |        2dup pushdot signed_32_bit_cond while ( ud1 -- ud1 )       |
dnl # +===================================================================+
dnl
dnl
dnl
dnl # 2dup 0 0 D= while
dnl # 2dup 0. D= while
dnl # 2dup D0= while
dnl # ( d -- d )
define({_2DUP_D0EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0EQ_WHILE},{2dup d0= while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0EQ_WHILE},{dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{__{}define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO BEGIN_STACK  ( d -- d )
    or    L             ; 1:4       __INFO BEGIN_STACK
    or    D             ; 1:4       __INFO BEGIN_STACK
    or    E             ; 1:4       __INFO BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # ( pd -- pd )
define({PD0EQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PD0EQ_WHILE},{pd0eq while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PD0EQ_WHILE},{dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{define({__INFO},__COMPILE_INFO)
    ld    A,(HL)        ; 1:7       __INFO BEGIN_STACK  ( pd -- pd )
    ld    C, L          ; 1:4       __INFO BEGIN_STACK
    inc   L             ; 1:4       __INFO BEGIN_STACK
    or  (HL)            ; 1:7       __INFO BEGIN_STACK
    inc   L             ; 1:4       __INFO BEGIN_STACK
    or  (HL)            ; 1:7       __INFO BEGIN_STACK
    inc   L             ; 1:4       __INFO BEGIN_STACK
    or  (HL)            ; 1:7       __INFO BEGIN_STACK
    ld    L, C          ; 1:4       __INFO BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 2dup 0 0 D<> while
dnl # 2dup 0. D<> while
dnl # 2dup D0<> while
dnl # ( d -- d )
define({_2DUP_D0NE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0NE_WHILE},{2dup d0<> while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0NE_WHILE},{dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO BEGIN_STACK  ( d -- d )
    or    L             ; 1:4       __INFO BEGIN_STACK
    or    D             ; 1:4       __INFO BEGIN_STACK
    or    E             ; 1:4       __INFO BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # ( pd -- pd )
define({PD0NE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_PD0NE_WHILE},{pd0ne while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PD0NE_WHILE},{dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}{define({__INFO},__COMPILE_INFO)
    ld    A,(HL)        ; 1:7       __INFO BEGIN_STACK  ( pd -- pd )
    ld    C, L          ; 1:4       __INFO BEGIN_STACK
    inc   L             ; 1:4       __INFO BEGIN_STACK
    or  (HL)            ; 1:7       __INFO BEGIN_STACK
    inc   L             ; 1:4       __INFO BEGIN_STACK
    or  (HL)            ; 1:7       __INFO BEGIN_STACK
    inc   L             ; 1:4       __INFO BEGIN_STACK
    or  (HL)            ; 1:7       __INFO BEGIN_STACK
    ld    L, C          ; 1:4       __INFO BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      __INFO BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 2dup 0 0 D< while
dnl # 2dup 0. D< while
dnl # 2dup D0< while
dnl # ( d -- d )
define({_2DUP_D0LT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0LT_WHILE},{2dup_d0lt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0LT_WHILE},{dnl
__{}define({__INFO},{2dup_d0lt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    bit   7, D          ; 2:8       2dup D0< while BEGIN_STACK
    jp    z, break{}BEGIN_STACK   ; 3:10      2dup D0< while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 2dup 0 0 D>= while
dnl # 2dup 0. D>= while
dnl # 2dup D0>= while
dnl # ( d -- d )
define({_2DUP_D0GE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0GE_WHILE},{2dup_d0ge_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0GE_WHILE},{dnl
__{}define({__INFO},{2dup_d0ge_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    bit   7, D          ; 2:8       2dup D0>= while BEGIN_STACK
    jp   nz, break{}BEGIN_STACK   ; 3:10      2dup D0>= while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # ( d -- d )
define({_2DUP_D0EQ_UNTIL},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_D0EQ_UNTIL},{2dup_d0eq until},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_D0EQ_UNTIL},{dnl
__{}define({__INFO},{2dup_d0eq until}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}.error {$0}($@) for non-existent {BEGIN}},
{
    ld    A, H          ; 1:4       2dup 0.= until BEGIN_STACK   ( d -- d )
    or    L             ; 1:4       2dup 0.= until BEGIN_STACK
    or    D             ; 1:4       2dup 0.= until BEGIN_STACK
    or    E             ; 1:4       2dup 0.= until BEGIN_STACK
    jp   nz, begin{}BEGIN_STACK   ; 3:10      2dup 0.= until BEGIN_STACK
__{}break{}BEGIN_STACK:               ;           2dup 0.= until BEGIN_STACK{}popdef({BEGIN_STACK})})}){}dnl
dnl
dnl
dnl
dnl
dnl # 2dup D. D= while
dnl # ( d -- d )
define({_2DUP_PUSHDOT_DEQ_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DEQ_WHILE},{2dup_pushdot_deq_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DEQ_WHILE},{dnl
__{}define({__INFO},{2dup_pushdot_deq_while}){}dnl
dnl
__{}define({_TMP_INFO},{2dup $1 D= while BEGIN_STACK}){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 )   __HEX_DEHL($1) == DEHL}){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}    .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
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
__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
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
__{}__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO   price: _TMP_BEST_P},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[_TMP_B:_TMP_NJ/_TMP_J,_TMP_J2] _TMP_INFO   ( d1 -- d1 )_TMP_HL_CODE
__{}__{}__{}__{}    jp   nz, break{}BEGIN_STACK   ; 3:10      _TMP_INFO   price: _TMP_P})})},
__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D<> while
dnl # ( d -- d )
define({_2DUP_PUSHDOT_DNE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DNE_WHILE},{2dup_pushdot_dne_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DNE_WHILE},{dnl
__{}define({__INFO},{2dup_pushdot_dne_while}){}dnl
dnl
__{}define({_TMP_INFO},{2dup $1 D<> while BEGIN_STACK}){}dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- d1 )   __HEX_DEHL($1) <> DEHL}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}    .error {$0}($@) for non-existent {BEGIN}},
__{}$1,{},{
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
__{}__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO},
__{}__{}__IS_NUM($1),{0},{
__{}__{}__{}   .error {$0}($@): M4 does not know $1 parameter value!},
__{}__{}{dnl
__{}__{}__{}__DEQ_MAKE_BEST_CODE($1,3,10,3,-10){}dnl
__{}__{}__{}__DEQ_MAKE_HL_CODE($1,3,-10){}dnl
__{}__{}__{}define({_TMP_B},eval(_TMP_B+3)){}dnl
__{}__{}__{}define({_TMP_J},eval(_TMP_J+10)){}dnl
__{}__{}__{}define({_TMP_J2},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_NJ},eval(_TMP_NJ+10)){}dnl
__{}__{}__{}define({_TMP_P},eval(8*_TMP_J2+4*_TMP_NJ+4*_TMP_J+64*_TMP_B)){}dnl #     price = 16*(clocks + 4*bytes)
__{}__{}__{}ifelse(ifelse(_TYP_DOUBLE,{small},{eval((_TMP_BEST_B<_TMP_B) || ((_TMP_BEST_B==_TMP_B) && (_TMP_BEST_P<_TMP_P)))},{eval(_TMP_BEST_P<=_TMP_P)}),{1},{
__{}__{}__{}__{}_TMP_BEST_CODE
__{}__{}__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO   price: _TMP_BEST_P},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[_TMP_B:_TMP_J,_TMP_NJ/_TMP_J2] _TMP_INFO   ( d1 -- d1 )_TMP_HL_CODE
__{}__{}__{}__{}    jp    z, break{}BEGIN_STACK   ; 3:10      _TMP_INFO   price: _TMP_P})})},
__{}{
__{}__{}    .error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # 2dup D. D< while
define({_2DUP_PUSHDOT_DLT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSHDOT_DLT_WHILE},{2dup_pushdot_dlt_while},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSHDOT_DLT_WHILE},{dnl
__{}define({__INFO},{2dup_pushdot_dlt_while}){}dnl
ifelse(BEGIN_STACK,{BEGIN_STACK},{
    .error {$0}($@) for non-existent {BEGIN}},
__IS_MEM_REF($1),{1},{
                        ;[22:92]    2dup $1 > while BEGIN_STACK    ( d1 -- d1 )   # version with constant address
    ld    A,format({%-12s}, $1); 3:13      2dup $1 > while BEGIN_STACK
    sub   L             ; 1:4       2dup $1 > while BEGIN_STACK    L>(addr+0) --> 0>A-L --> no carry if false
    ld    A,format({%-12s},(1+$1)); 3:13      2dup $1 > while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup $1 > while BEGIN_STACK    H>(addr+1) --> 0>A-H --> no carry if false
    ld   BC,format({%-12s},(2+$1)); 4:20      2dup $1 > while BEGIN_STACK
    ld    A, C          ; 1:4       2dup $1 > while BEGIN_STACK
    sbc   A, E          ; 1:4       2dup $1 > while BEGIN_STACK    E>(addr+2) --> 0>A-E --> no carry if false
    ld    A, B          ; 1:4       2dup $1 > while BEGIN_STACK
    sbc   A, D          ; 1:4       2dup $1 > while BEGIN_STACK    D>(addr+3) --> 0>A-D --> no carry if false
    rra                 ; 1:4       2dup $1 > while BEGIN_STACK    carry --> sign
    xor   D             ; 1:4       2dup $1 > while BEGIN_STACK    invert signs if negative d1
    xor   B             ; 1:4       2dup $1 > while BEGIN_STACK    invert signs if negative constant
    jp    p, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK    no sign --> false},

_TYP_DOUBLE,{function},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
                       ;[10:69]     2dup D> while BEGIN_STACK   ( d1 -- d1 )   # function version can be changed with "define({_TYP_DOUBLE},{default})" or small
    pop  BC             ; 1:10      2dup D> while BEGIN_STACK
    pop  AF             ; 1:10      2dup D> while BEGIN_STACK
    push AF             ; 1:11      2dup D> while BEGIN_STACK
    push BC             ; 1:11      2dup D> while BEGIN_STACK
    call FCE_DGT        ; 3:17      2dup D> while BEGIN_STACK   no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup Du< while BEGIN_STACK},
_TYP_DOUBLE,{small},{
                        ;[17:62]    2dup $1 > while BEGIN_STACK    ( d1 -- d1 )   # small version can be changed with "define({_TYP_DOUBLE},{function})" or default
    ld    A, __HEX_L($1)       ; 2:7       2dup $1 > while BEGIN_STACK    DEHL>__HEX_DEHL($1)
    sub   L             ; 1:4       2dup $1 > while BEGIN_STACK    L>A --> A-L<0 --> no carry if false
    ld    A, __HEX_H($1)       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup $1 > while BEGIN_STACK    H>A --> A-H<0 --> no carry if false
    ld    A, __HEX_E($1)       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, E          ; 1:4       2dup $1 > while BEGIN_STACK    E>A --> A-E<0 --> no carry if false
    ld    A, __HEX_D($1)       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, D          ; 1:4       2dup $1 > while BEGIN_STACK    D>A --> A-D<0 --> no carry if false
    rra                 ; 1:4       2dup $1 > while BEGIN_STACK    carry --> sign
    xor   D             ; 1:4       2dup $1 > while BEGIN_STACK    invert signs if negative d1
__{}ifelse(eval(($1)&0x80000000),0,{dnl
__{}    jp    p, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK    positive constant --> no sign if false},
__{}{dnl
__{}    jp    m, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK    negative constant --> sign if false})},
{
__{}ifelse(eval(($1)&0x80000000),0,{dnl
__{}                     ;[20:72/18,72] 2dup $1 > while BEGIN_STACK    ( d1 -- d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})" or small
__{}    ld    A, D          ; 1:4       2dup $1 > while BEGIN_STACK    DEHL>__HEX_DEHL($1)
__{}    add   A, A          ; 1:4       2dup $1 > while BEGIN_STACK    check d1 signs
__{}    jp    c, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK    different signs --> negative d1 --> false},
__{}{dnl
__{}                     ;[19:20,69/69] 2dup $1 > while BEGIN_STACK    ( d1 -- d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})" or small
__{}    ld    A, D          ; 1:4       2dup $1 > while BEGIN_STACK    DEHL>__HEX_DEHL($1)
__{}    add   A, A          ; 1:4       2dup $1 > while BEGIN_STACK    check d1 signs
__{}    jr   nc, $+17       ; 2:7/12    2dup $1 > while BEGIN_STACK    different signs --> positive d1 --> true})
    ld    A, __HEX_L($1)       ; 2:7       2dup $1 > while BEGIN_STACK
    sub   L             ; 1:4       2dup $1 > while BEGIN_STACK    L>A --> A-L<0 --> no carry if false
    ld    A, __HEX_H($1)       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, H          ; 1:4       2dup $1 > while BEGIN_STACK    H>A --> A-H<0 --> no carry if false
    ld    A, __HEX_E($1)       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, E          ; 1:4       2dup $1 > while BEGIN_STACK    E>A --> A-E<0 --> no carry if false
    ld    A, __HEX_D($1)       ; 2:7       2dup $1 > while BEGIN_STACK
    sbc   A, D          ; 1:4       2dup $1 > while BEGIN_STACK    D>A --> A-D<0 --> no carry if false
    jp   nc, break{}BEGIN_STACK   ; 3:10      2dup $1 > while BEGIN_STACK})}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d< while
dnl # ( d -- d )
define({_2DUP_PUSH2_DLT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DLT_WHILE},{2dup $1 $2 d< while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DLT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- d )  flag: d < $1<<16+$2},3,10,3,0,break{}BEGIN_STACK,0)
__{}    jp   nc, format({%-11s},break{}BEGIN_STACK); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d>= while
dnl # ( d -- d )
define({_2DUP_PUSH2_DGE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DGE_WHILE},{2dup $1 $2 d>= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DGE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DLT_SET_CARRY($@,{( d -- d )  flag: d >= $1<<16+$2},3,10,break{}BEGIN_STACK,0,3,0)
__{}    jp    c, format({%-11s},break{}BEGIN_STACK); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d<= while
dnl # ( d -- d )
define({_2DUP_PUSH2_DLE_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DLE_WHILE},{2dup $1 $2 d<= while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DLE_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- d )  flag: d <= $1<<16+$2},3,10,break{}BEGIN_STACK,0,3,0)
__{}    jp    c, format({%-11s},break{}BEGIN_STACK); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup $1. d> while
dnl # ( d -- d )
define({_2DUP_PUSH2_DGT_WHILE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_PUSH2_DGT_WHILE},{2dup $1 $2 d> while BEGIN_STACK},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_PUSH2_DGT_WHILE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(BEGIN_STACK,{BEGIN_STACK},{
__{}__{}  .error {$0}($@) for non-existent {BEGIN}},
__{}eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__MAKE_CODE_DGT_SET_CARRY($@,{( d -- d )  flag: d > $1<<16+$2},3,10,3,0,break{}BEGIN_STACK,0)
__{}    jp   nc, format({%-11s},break{}BEGIN_STACK); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl

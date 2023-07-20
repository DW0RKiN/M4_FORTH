dnl ## Stack manipulation
dnl
dnl
dnl
dnl # ( -- a )
dnl # push(a) ulozi na zasobnik nasledujici polozku
define({PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHS},__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH},{dnl
ifelse($1,{},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter! Maybe you want to use {PUSHS}($@)?},
{define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{dnl
__{}    ld   HL, __FORM({%-11s},{$1}); 3:10      __INFO}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # Input
dnl # $1 ...price
dnl # $2 ...path (like "1121231")
dnl # $3 ...first value
define({__BRUTEFORCE_PUSH_CHECK_REC},{dnl
__{}ifelse(dnl
__{}eval($1>=__CHECK_PUSH_BEST),1,{},
dnl __{}$#,3,{dnl
dnl __{}__{}__LD_REG16({HL},$3,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
dnl __{}__{}ifelse(eval(__CHECK_PUSH_BEST>($1+__PRICE_16BIT)),1,{dnl
dnl __{}__{}__{}define({__CHECK_PUSH_BEST},eval($1+__PRICE_16BIT)){}dnl
dnl __{}__{}__{}define({__CHECK_PUSH_BEST_PATH},$2){}dnl
dnl errprint({
dnl },__CHECK_PUSH_BEST:__CHECK_PUSH_BEST_PATH{}){}dnl
dnl __{}__{}}){}dnl
dnl __{}},
__{}$#,4,{dnl
__{}__{}__RESET_ADD_LD_REG16{}dnl
__{}__{}__ADD_LD_REG16({DE},$3,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__ADD_LD_REG16({HL},$4,{HL},__REG_HL,{DE},      $3,{BC},__REG_BC){}dnl
__{}__{}ifelse(eval(__CHECK_PUSH_BEST>($1+__SUM_PRICE_16BIT)),1,{dnl
__{}__{}__{}define({__CHECK_PUSH_BEST},eval($1+__SUM_PRICE_16BIT)){}dnl
__{}__{}__{}define({__CHECK_PUSH_BEST_PATH},$2){}dnl
__{}__{}}){}dnl
__{}},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__REG_HL,$3,{$0($1,$2{}1,shift(shift(shift($@))))},
__{}__{}__REG_DE,$3,{$0($1,$2{}2,shift(shift(shift($@))))},
__{}__{}__REG_BC,$3,{$0($1,$2{}3,shift(shift(shift($@))))},
__{}__{}{dnl
__{}__{}__{}__LD_REG16({HL},$3,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__{}pushdef({__REG_HL}){}dnl
__{}__{}__{}define({__REG_HL},$3){}dnl
__{}__{}__{}$0(eval($1+__PRICE_16BIT),$2{}1,shift(shift(shift($@)))){}dnl
__{}__{}__{}popdef({__REG_HL}){}dnl
__{}__{}__{}dnl
__{}__{}__{}__LD_REG16({DE},$3,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__{}pushdef({__REG_DE}){}dnl
__{}__{}__{}define({__REG_DE},$3){}dnl
__{}__{}__{}$0(eval($1+__PRICE_16BIT),$2{}2,shift(shift(shift($@)))){}dnl
__{}__{}__{}popdef({__REG_DE}){}dnl
__{}__{}__{}dnl
__{}__{}__{}__LD_REG16({BC},$3,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__{}pushdef({__REG_BC}){}dnl
__{}__{}__{}define({__REG_BC},$3){}dnl
__{}__{}__{}$0(eval($1+__PRICE_16BIT),$2{}3,shift(shift(shift($@)))){}dnl
__{}__{}__{}popdef({__REG_BC}){}dnl
__{}__{}}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__PRINT_PUSH_PATH_REC},{dnl
__{}ifelse(dnl
__{}$1,{},{dnl
__{}__{}__LD_REG16({DE},$2,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}define({__REG_DE},$2){}dnl
__{}__{}__LD_REG16({HL},$3,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}define({__REG_HL},$3){}dnl
__{}},
__{}substr($1,0,1),{-},{},
__{}substr($1,0,1),1,{dnl
__{}__{}__LD_REG16({HL},$2,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}define({__REG_HL},$2)
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}$0(substr($1,1),shift(shift($@))){}dnl
__{}},
__{}substr($1,0,1),2,{dnl
__{}__{}__LD_REG16({DE},$2,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}define({__REG_DE},$2)
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}$0(substr($1,1),shift(shift($@))){}dnl
__{}},
__{}substr($1,0,1),3,{dnl
__{}__{}__LD_REG16({BC},$2,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}define({__REG_BC},$2)
__{}__{}    push BC             ; 1:11      __INFO{}dnl
__{}__{}$0(substr($1,1),shift(shift($@))){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input
dnl # $1 ...price
dnl # $2 ...path (like "1121231")
dnl # $3 ...__REG_HL
dnl # $4 ...__REG_DE
dnl # $5 ...__REG_BC
dnl # $6 ...first value
define({__PATH_COUNT},{dnl
__{}ifelse(dnl
__{}$2,{},{dnl
__{}__{}ifelse(__REG_DE,{},define({__FIRST_REG_DE},$6)){}dnl
__{}__{}__LD_REG16({DE},$6,{HL},$3,{DE},$4,{BC},$5){}dnl
__{}__{}define({__PATH_COUNT_PRICE},eval($1+__PRICE_16BIT)){}dnl
__{}__{}ifelse(__REG_HL,{},define({__FIRST_REG_HL},$7)){}dnl
__{}__{}__LD_REG16({HL},$7,{HL},$3,{DE},$6,{BC},$5){}dnl
__{}__{}define({__PATH_COUNT_PRICE},eval(__PATH_COUNT_PRICE+__PRICE_16BIT)){}dnl
__{}},
__{}substr($2,0,1),1,{dnl
__{}__{}ifelse(__REG_HL,{},define({__FIRST_REG_HL},$6)){}dnl
__{}__{}__LD_REG16({HL},$6,{HL},$3,{DE},$4,{BC},$5){}dnl
__{}__{}$0(eval($1+__PRICE_16BIT),substr($2,1),$6,$4,$5,shift(shift(shift(shift(shift(shift($@))))))){}dnl
__{}},
__{}substr($2,0,1),2,{dnl
__{}__{}ifelse(__REG_DE,{},define({__FIRST_REG_DE},$6)){}dnl
__{}__{}__LD_REG16({DE},$6,{HL},$3,{DE},$4,{BC},$5){}dnl
__{}__{}$0(eval($1+__PRICE_16BIT),substr($2,1),$3,$6,$5,shift(shift(shift(shift(shift(shift($@))))))){}dnl
__{}},
__{}substr($2,0,1),3,{dnl
__{}__{}ifelse(__REG_BC,{},define({__FIRST_REG_BC},$6)){}dnl
__{}__{}__LD_REG16({BC},$6,{HL},$3,{DE},$4,{BC},$5){}dnl
__{}__{}$0(eval($1+__PRICE_16BIT),substr($2,1),$3,$4,$6,shift(shift(shift(shift(shift(shift($@))))))){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__BRUTEFORCE_PUSHS_REC},{dnl
__{}define({__CHECK_PUSH_BEST},0x7FFFFFFF){}dnl
__{}ifelse($#,0,{},
__{}$#,1,{
__{}__{}  .error {$0}($@)},
__{}eval($#<7),1,{dnl
__{}__{}__BRUTEFORCE_PUSH_CHECK_REC(0,,$@){}dnl
__{}__{}define({__ORIG_PATH},__ORIG_PATH{}__CHECK_PUSH_BEST_PATH){}dnl
__{}},
__{}{dnl
__{}__{}__BRUTEFORCE_PUSH_CHECK_REC(0,,$1,$2,$3,$4,__LAST_REG_DE,__LAST_REG_HL){}dnl
__{}__{}ifelse(substr(__CHECK_PUSH_BEST_PATH,0,1),1,{dnl
__{}__{}__{}define({__REG_HL},$1){}dnl
__{}__{}},
__{}__{}substr(__CHECK_PUSH_BEST_PATH,0,1),2,{dnl
__{}__{}__{}define({__REG_DE},$1){}dnl
__{}__{}},
__{}__{}{dnl
__{}__{}__{}define({__REG_BC},$1){}dnl
__{}__{}}){}dnl
__{}__{}define({__ORIG_PATH},__ORIG_PATH{}substr(__CHECK_PUSH_BEST_PATH,0,1)){}dnl
__{}__{}$0(shift($@)){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( b a -- $1 $2 $3 ... )
define({_2DROP_PUSHS},{dnl
__{}__ADD_TOKEN({__TOKEN_2DROP_PUSHS},{2drop }__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DROP_PUSHS},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameters!},
$#,1,{dnl
__{}__ASM_TOKEN_2DROP_PUSH($@)},
$#,2,{dnl
__{}__ASM_TOKEN_2DROP_PUSH2($@)},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({__LAST_REG_HL},__REVERSE_1_PAR($@)){}dnl
__{}define({__LAST_REG_DE},__REVERSE_2_PAR($@)){}dnl
__{}define({__REG_BC},{}){}dnl
__{}define({__REG_DE},{}){}dnl
__{}define({__REG_HL},{}){}dnl
__{}pushdef({__REG_HL}){}dnl
__{}pushdef({__REG_DE}){}dnl
__{}pushdef({__REG_BC}){}dnl
__{}define({__ORIG_PATH},{}){}dnl
__{}__BRUTEFORCE_PUSHS_REC($@){}dnl
__{}popdef({__REG_HL}){}dnl
__{}popdef({__REG_DE}){}dnl
__{}popdef({__REG_BC}){}dnl
__{}define({__FIRST_REG_HL},__REG_HL){}dnl
__{}define({__FIRST_REG_DE},__REG_DE){}dnl
__{}define({__FIRST_REG_BC},__REG_BC){}dnl
__{}__PATH_COUNT(0,__ORIG_PATH,__REG_HL,__REG_DE,__REG_BC,$@){}dnl
__{}define({__TEMP_PRICE},__PATH_COUNT_PRICE){}dnl
__{}dnl # HL first
__{}__PATH_COUNT(0,{1}__ORIG_PATH,__REG_HL,__REG_DE,__REG_BC,__FIRST_REG_HL,$@){}dnl
__{}ifelse(eval(__PATH_COUNT_PRICE<__TEMP_PRICE),1,{dnl
__{}__{}__LD_REG16({HL},__FIRST_REG_HL,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}define({__REG_HL},__FIRST_REG_HL){}dnl
__{}__{}__PATH_COUNT(0,__ORIG_PATH,__REG_HL,__REG_DE,__REG_BC,$@){}dnl
__{}__{}define({__TEMP_PRICE},__PATH_COUNT_PRICE){}dnl
__{}}){}dnl
__{}dnl # DE first
__{}__PATH_COUNT(0,{2}__ORIG_PATH,__REG_HL,__REG_DE,__REG_BC,__FIRST_REG_DE,$@){}dnl
__{}ifelse(eval(__PATH_COUNT_PRICE<__TEMP_PRICE),1,{dnl
__{}__{}__LD_REG16({DE},__FIRST_REG_DE,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}define({__REG_DE},__FIRST_REG_DE){}dnl
__{}__{}__PATH_COUNT(0,__ORIG_PATH,__REG_HL,__REG_DE,__REG_BC,$@){}dnl
__{}__{}define({__TEMP_PRICE},__PATH_COUNT_PRICE){}dnl
__{}}){}dnl
__{}dnl # BC first
__{}__PATH_COUNT(0,{3}__ORIG_PATH,__REG_HL,__REG_DE,__REG_BC,__FIRST_REG_BC,$@){}dnl
__{}ifelse(eval(__PATH_COUNT_PRICE<__TEMP_PRICE),1,{dnl
__{}__{}__LD_REG16({BC},__FIRST_REG_BC,{HL},__REG_HL,{DE},__REG_DE,{BC},__REG_BC){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}define({__REG_BC},__FIRST_REG_BC){}dnl
__{}}){}dnl
__{}__PRINT_PUSH_PATH_REC(__ORIG_PATH,$@){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( a -- $1 $2 $3 ... )
define({DROP_PUSHS},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_PUSHS},{drop }__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_PUSHS},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameters!},
$#,1,{dnl
__{}__ASM_TOKEN_DROP_PUSH($@)},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    push DE             ; 1:11      __INFO{}dnl
__{}__ASM_TOKEN_2DROP_PUSHS($@){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( b a -- a $1 $2 $3 ... )
define({NIP_PUSHS},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSHS},{nip }__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSHS},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameters!},
$#,1,{dnl
__{}__ASM_TOKEN_NIP_PUSH($@)},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    push HL             ; 1:11      __INFO{}dnl
__{}__ASM_TOKEN_2DROP_PUSHS($@){}dnl
})}){}dnl
dnl
dnl
dnl # nip num over
dnl # ( b a -- a num a )
define({NIP_PUSH_OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_OVER},{nip $1 over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_OVER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}    push HL             ; 1:11      __INFO   ( b a -- a $1 a )
__{}    ld   DE, format({%-11s},$1); 4:20      __INFO},
__{}{
__{}    push HL             ; 1:11      __INFO   ( b a -- a $1 a )
__{}    ld   DE, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- $1 $2 $3 ... )
define({PUSHS},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHS},__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHS},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameters!},
$#,1,{dnl
__{}__ASM_TOKEN_PUSH($@)},
$#,2,{dnl
__{}__ASM_TOKEN_PUSH2($@)},
$#,3,{dnl
__{}__ASM_TOKEN_PUSH3($@)},
$#,xxx4,{dnl
__{}__ASM_TOKEN_PUSH4($@)},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}dnl
__{}__ASM_TOKEN_2DROP_PUSHS($@){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( b a -- a b $1 $2 $3 ... )
define({SWAP_PUSHS},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_PUSHS},{swap }__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_PUSHS},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameters!},
$#,1,{dnl
__{}__ASM_TOKEN_SWAP_PUSH($@)},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    push HL             ; 1:11      __INFO
__{}    push DE             ; 1:11      __INFO{}dnl
__{}__ASM_TOKEN_2DROP_PUSHS($@){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( a -- a a $1 $2 $3 ... )
define({DUP_PUSHS},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSHS},{dup }__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSHS},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameters!},
$#,1,{dnl
__{}__ASM_TOKEN_DUP_PUSH($@)},
$#,2,{dnl
__{}__ASM_TOKEN_DUP_PUSH2($@)},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}dnl
__{}__ASM_TOKEN_2DROP_PUSHS($@){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( addr -- x $1 $2 $3 ... )
define({FETCH_PUSHS},{dnl
__{}__ADD_TOKEN({__TOKEN_FETCH_PUSHS},{@ }__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FETCH_PUSHS},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameters!},
$#,1,{dnl
__{}__ASM_TOKEN_FETCH_PUSH($@)},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    push DE             ; 1:11      __INFO
__{}    ld    E, (HL)       ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D, (HL)       ; 1:7       __INFO
__{}    push DE             ; 1:11      __INFO{}dnl
__{}__ASM_TOKEN_2DROP_PUSHS($@){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( b a -- b a b $1 $2 $3 ... )
define({OVER_PUSHS},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PUSHS},{over }__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PUSHS},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameters!},
$#,1,{dnl
__{}__ASM_TOKEN_OVER_PUSH($@)},
$#,2,{dnl
__{}__ASM_TOKEN_OVER_PUSH2($@)},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    push DE             ; 1:11      __INFO{}dnl
__{}__ASM_TOKEN_2DROP_PUSHS($@){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( x x -- b a)
dnl # push2(b,a) premaze zasobnik nasledujicima polozkama
define({_2DROP_PUSH2},{dnl
ifelse($1,{},{
__{}  .error {$0}($@): Missing parameters!},
$2,{},{
__{}  .error {$0}($@): Missing second parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_2DROP_PUSH2},{$1 $2},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DROP_PUSH2},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=2),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_INFO},__INFO){}dnl # HL first check
__{}define({__TMP_HL_CLOCKS},0){}dnl
__{}define({__TMP_HL_BYTES},0){}dnl
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}__add({__TMP_HL_CLOCKS},__CLOCKS_16BIT){}dnl
__{}__add({__TMP_HL_BYTES}, __BYTES_16BIT){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}__add({__TMP_HL_CLOCKS},__CLOCKS_16BIT){}dnl
__{}__add({__TMP_HL_BYTES}, __BYTES_16BIT){}dnl
__{}dnl
__{}define({__TMP_DE_CLOCKS},0){}dnl
__{}define({__TMP_DE_BYTES},0){}dnl
__{}__LD_REG16({HL},$2,{DE},$1){}dnl # DE first check
__{}__add({__TMP_DE_CLOCKS},__CLOCKS_16BIT){}dnl
__{}__add({__TMP_DE_BYTES}, __BYTES_16BIT){}dnl
__{}__LD_REG16({DE},$1){}dnl
__{}__add({__TMP_DE_CLOCKS},__CLOCKS_16BIT){}dnl
__{}__add({__TMP_DE_BYTES}, __BYTES_16BIT){}dnl
__{}dnl
__{}ifelse(eval(__TMP_DE_CLOCKS<=__TMP_HL_CLOCKS),{1},{dnl # DE first
__{}                        ;[__TMP_DE_BYTES:__TMP_DE_CLOCKS]     __INFO   ( -- $1 $2 ){}dnl
__{}__{}__CODE_16BIT{}__LD_REG16({HL},$2,{DE},$1){}__CODE_16BIT},
__{}{dnl # HL first
__{}                        ;[__TMP_HL_BYTES:__TMP_HL_CLOCKS]     __INFO   ( -- $1 $2 ){}dnl
__{}__{}__LD_REG16({HL},$2){}__CODE_16BIT{}__LD_REG16({DE},$1,{HL},$2){}__CODE_16BIT}){}dnl
})}){}dnl
dnl
dnl
dnl # ( -- b a)
dnl # push2(b,a) ulozi na zasobnik nasledujici polozky
define({PUSH2},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHS},__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=2),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}dnl # HL first
__{}pushdef({__SUM_CLOCKS},22){}dnl
__{}pushdef({__SUM_BYTES},2){}dnl
__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}define({$0_HL_CODE},{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(      HL,$2){}dnl
__{}__{}__LD_R16(DE,$1,HL,$2)){}dnl
__{}define({$0_HL_C},__SUM_CLOCKS){}dnl
__{}define({$0_HL_B},__SUM_BYTES){}dnl
__{}define({$0_HL_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}dnl # DE first
__{}define({__SUM_CLOCKS},22){}dnl
__{}define({__SUM_BYTES},2){}dnl
__{}define({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}define({$0_DE_CODE},{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(      DE,$1){}dnl
__{}__{}__LD_R16(HL,$2,DE,$1)){}dnl
__{}define({$0_DE_C},__SUM_CLOCKS){}dnl
__{}define({$0_DE_B},__SUM_BYTES){}dnl
__{}define({$0_DE_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}dnl # check
__{}ifelse(eval($0_HL_P>=$0_DE_P),{1},{dnl
__{}__{}dnl # DE first
__{}__{}define({__SUM_CLOCKS},$0_DE_C){}dnl
__{}__{}define({__SUM_BYTES}, $0_DE_B){}dnl
__{}__{}define({__SUM_PRICE}, $0_DE_P){}dnl
__{}__{}                        ;[$0_DE_B:$0_DE_C]     __INFO   ( -- $1 $2 ){}dnl
__{}__{}$0_DE_CODE},
__{}{dnl
__{}__{}dnl # HL first
__{}__{}define({__SUM_CLOCKS},$0_HL_C){}dnl
__{}__{}define({__SUM_BYTES}, $0_HL_B){}dnl
__{}__{}define({__SUM_PRICE}, $0_HL_P){}dnl
__{}__{}                        ;[$0_HL_B:$0_HL_C]     __INFO   ( -- $1 $2 ){}dnl
__{}__{}$0_HL_CODE}){}dnl
__{}popdef({__SUM_CLOCKS}){}dnl
__{}popdef({__SUM_BYTES}){}dnl
__{}popdef({__SUM_PRICE}){}dnl
__{}__add({__SUM_CLOCKS},__CLOCKS){}dnl
__{}__add({__SUM_BYTES}, __BYTES){}dnl
__{}__add({__SUM_PRICE}, __PRICE){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # ( b a -- b a $1 $2 b a)
define({PUSH2_2OVER},{dnl
ifelse($1,{},{
__{}  .error {$0}($@): Missing parameters!},
$2,{},{
__{}  .error {$0}($@): Missing second parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_2OVER},{$1 $2},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_2OVER},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=2),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}    push DE             ; 1:11      __INFO   ( b a -- b a $1 $2 b a )
__{}    push HL             ; 1:11      __INFO{}dnl
__{}__LD_REG16({BC},$1){}__CODE_16BIT
__{}    push BC             ; 1:11      __INFO{}dnl
__{}__LD_REG16({BC},$2,{BC},$1){}__CODE_16BIT
__{}    push BC             ; 1:11      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # ( a -- a $1 $2 a)
define({PUSH2_2OVER_NIP},{dnl
ifelse($1,{},{
__{}  .error {$0}($@): Missing parameters!},
$2,{},{
__{}  .error {$0}($@): Missing second parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_2OVER_NIP},{$1 $2},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_2OVER_NIP},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=2),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}    push DE             ; 1:11      __INFO   ( a -- a $1 $2 a )
__{}    push HL             ; 1:11      __INFO{}dnl
__{}__LD_REG16({DE},$1){}__CODE_16BIT
__{}    push DE             ; 1:11      __INFO{}dnl
__{}__LD_REG16({DE},$2,{DE},$1){}__CODE_16BIT{}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( -- c b a)
dnl # push3(c,b,a) ulozi na zasobnik nasledujici polozky
define({PUSH3},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHS},__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH3},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<3),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}define({PUSH3_P1},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},$3){}dnl
__{}__add({PUSH3_P1},__PRICE_16BIT){}dnl
__{}__LD_REG16_BEFORE_AFTER({DE},$2,{HL},$1,{HL},$3){}dnl
__{}__add({PUSH3_P1},__PRICE_16BIT){}dnl
__{}define({PUSH3_P},PUSH3_P1){}dnl
__{}define({PUSH3_X},1){}dnl
__{}dnl
__{}__LD_REG16({DE},$1){}dnl
__{}define({PUSH3_P2},__PRICE_16BIT){}dnl
__{}__LD_REG16({DE},$2){}dnl
__{}__add({PUSH3_P2},__PRICE_16BIT){}dnl
__{}__LD_REG16_BEFORE_AFTER({HL},$3,{DE},$1,{DE},$2){}dnl
__{}__add({PUSH3_P2},__PRICE_16BIT){}dnl
__{}ifelse(eval(PUSH3_P>PUSH3_P2),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P2){}dnl
__{}__{}define({PUSH3_X},2)}){}dnl
__{}dnl
__{}__LD_REG16({DE},$1){}dnl
__{}define({PUSH3_P3},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},$3,{DE},$1){}dnl
__{}__add({PUSH3_P3},__PRICE_16BIT){}dnl
__{}__LD_REG16({DE},$2,{DE},$1,{HL},$3){}dnl
__{}__add({PUSH3_P3},__PRICE_16BIT){}dnl
__{}ifelse(eval(PUSH3_P>PUSH3_P3),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P3){}dnl
__{}__{}define({PUSH3_X},3)}){}dnl
__{}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}define({PUSH3_P4},__PRICE_16BIT){}dnl
__{}__LD_REG16({DE},$2,{HL},$1){}dnl
__{}__add({PUSH3_P4},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},$3,{HL},$1,{DE},$2){}dnl
__{}__add({PUSH3_P4},__PRICE_16BIT){}dnl
__{}ifelse(eval(PUSH3_P>PUSH3_P4),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P4){}dnl
__{}__{}define({PUSH3_X},4)}){}dnl
__{}dnl # PUSH3_P1 PUSH3_P2 PUSH3_P3 PUSH3_P4 --> PUSH3_X
__{}dnl # ---- case PUSH3_X ----
__{}ifelse(dnl
__{}PUSH3_X,1,{
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 ) push3.m1
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({HL},$1){}__CODE_16BIT
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16_BEFORE_AFTER({DE},$2,{HL},$1,{HL},$3){}dnl
__{}__{}__CODE_BEFORE_16BIT{}dnl
__{}__{}__LD_REG16({HL},$3,{HL},$1){}__CODE_16BIT{}dnl
__{}__{}__CODE_AFTER_16BIT},
__{}PUSH3_X,2,{
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 ) push3.m2
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$1){}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16_BEFORE_AFTER({HL},$3,{DE},$1,{DE},$2){}dnl
__{}__{}__CODE_BEFORE_16BIT{}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}__CODE_16BIT{}dnl
__{}__{}__CODE_AFTER_16BIT},
__{}PUSH3_X,3,{
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 ) push3.m3
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$1){}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({HL},$3,{DE},$1){}__CODE_16BIT{}dnl
__{}__{}__LD_REG16({DE},$2,{HL},$3,{DE},$1){}__CODE_16BIT},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 ) push3.m4
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({HL},$1){}__CODE_16BIT
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__LD_REG16({DE},$2,{HL},$1){}__CODE_16BIT{}dnl
__{}__LD_REG16({HL},$3,{DE},$2,{HL},$1){}__CODE_16BIT}){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_PUSH3},{dnl
ifelse(eval($#<3),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}dnl # DE_DE_HL
__{}pushdef({__SUM_CLOCKS},33){}dnl
__{}pushdef({__SUM_BYTES},3){}dnl
__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}define({$0_CODE_1},{
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 )  # DE DE HL
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(            DE,$1){}dnl
__{}__{}{
__{}__{}    push DE             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(      DE,$2,DE,$1){}dnl
__{}__{}__LD_R16(HL,$3,      DE,$2)){}dnl
__{}define({$0_BEST_C},__SUM_CLOCKS){}dnl
__{}define({$0_BEST_B},__SUM_BYTES){}dnl
__{}define({$0_BEST_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}dnl # DE_HL_DE
__{}pushdef({__SUM_CLOCKS},33){}dnl
__{}pushdef({__SUM_BYTES},3){}dnl
__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}define({$0_CODE_2},{
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 )  # DE HL DE
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(            DE,$1){}dnl
__{}__{}{
__{}__{}    push DE             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(HL,$3,      DE,$1){}dnl
__{}__{}__LD_R16(DE,$2,HL,$3,DE,$1)){}dnl
__{}define({$0_TMP_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}ifelse(eval($0_TMP_P<$0_BEST_P),1,{dnl
__{}__{}define({$0_CODE_1},{}){}dnl
__{}__{}define({$0_BEST_C},__SUM_CLOCKS){}dnl
__{}__{}define({$0_BEST_B},__SUM_BYTES){}dnl
__{}__{}define({$0_BEST_P},$0_TMP_P)},
__{}{dnl
__{}__{}define({$0_CODE_2},{}){}dnl
__{}}){}dnl
__{}dnl # HL_DE_DE
__{}pushdef({__SUM_CLOCKS},33){}dnl
__{}pushdef({__SUM_BYTES},3){}dnl
__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}define({$0_CODE_3},{
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 )  # HL DE DE
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(            HL,$1){}dnl
__{}__{}{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(      DE,$2,HL,$1){}dnl
__{}__{}__LD_R16(HL,$3,DE,$2,HL,$1)){}dnl
__{}define({$0_TMP_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}ifelse(eval($0_TMP_P<$0_BEST_P),1,{dnl
__{}__{}define({$0_CODE_1},{}){}dnl
__{}__{}define({$0_CODE_2},{}){}dnl
__{}__{}define({$0_BEST_C},__SUM_CLOCKS){}dnl
__{}__{}define({$0_BEST_B},__SUM_BYTES){}dnl
__{}__{}define({$0_BEST_P},$0_TMP_P)},
__{}{dnl
__{}__{}define({$0_CODE_3},{}){}dnl
__{}}){}dnl
__{}dnl # HL_HL_DE
__{}pushdef({__SUM_CLOCKS},33){}dnl
__{}pushdef({__SUM_BYTES},3){}dnl
__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}define({$0_CODE_4},{
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 )  # HL HL DE
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(            HL,$1){}dnl
__{}__{}{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(HL,$3,      HL,$1){}dnl
__{}__{}__LD_R16(DE,$2,      HL,$3)){}dnl
__{}define({$0_TMP_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}ifelse(eval($0_TMP_P<$0_BEST_P),1,{dnl
__{}__{}define({$0_CODE_1},{}){}dnl
__{}__{}define({$0_CODE_2},{}){}dnl
__{}__{}define({$0_CODE_3},{}){}dnl
__{}__{}define({$0_BEST_C},__SUM_CLOCKS){}dnl
__{}__{}define({$0_BEST_B},__SUM_BYTES){}dnl
__{}__{}define({$0_BEST_P},$0_TMP_P)},
__{}{dnl
__{}__{}define({$0_CODE_4},{}){}dnl
__{}}){}dnl
__{}ifelse(__IS_MEM_REF($3),0,{dnl
__{}__{}dnl # DE_H_DE_L
__{}__{}pushdef({__SUM_CLOCKS},33){}dnl
__{}__{}pushdef({__SUM_BYTES},3){}dnl
__{}__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}__{}define({$0_CODE_5},{
__{}__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 )  # DE H DE L
__{}__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__{}__LD_R16(                                       DE,$1){}dnl
__{}__{}__{}{
__{}__{}__{}    push DE             ; 1:11      __INFO}dnl
__{}__{}__{}__LD_R_NUM(__INFO{   hi before},    H,+($3)/256,DE,$1){}dnl
__{}__{}__{}__LD_R16(DE,$2,                     H,+($3)/256,DE,$1){}dnl
__{}__{}__{}__LD_R_NUM(__INFO{   lo after },L,$3,H,+($3)/256,DE,$2)){}dnl
__{}__{}define({$0_TMP_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}__{}ifelse(eval($0_TMP_P<$0_BEST_P),1,{dnl
__{}__{}__{}define({$0_CODE_1},{}){}dnl
__{}__{}__{}define({$0_CODE_2},{}){}dnl
__{}__{}__{}define({$0_CODE_3},{}){}dnl
__{}__{}__{}define({$0_CODE_4},{}){}dnl
__{}__{}__{}define({$0_BEST_C},__SUM_CLOCKS){}dnl
__{}__{}__{}define({$0_BEST_B},__SUM_BYTES){}dnl
__{}__{}__{}define({$0_BEST_P},$0_TMP_P)},
__{}__{}{dnl
__{}__{}__{}define({$0_CODE_5},{}){}dnl
__{}__{}}){}dnl
__{}__{}dnl # DE_L_DE_H
__{}__{}pushdef({__SUM_CLOCKS},33){}dnl
__{}__{}pushdef({__SUM_BYTES},3){}dnl
__{}__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}__{}define({$0_CODE_6},{
__{}__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 )  # DE L DE H
__{}__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__{}__LD_R16(                                       DE,$1){}dnl
__{}__{}__{}{
__{}__{}__{}    push DE             ; 1:11      __INFO}dnl
__{}__{}__{}__LD_R_NUM(__INFO{   lo before},           L,$3,DE,$1){}dnl
__{}__{}__{}__LD_R16(DE,$2,                            L,$3,DE,$1){}dnl
__{}__{}__{}__LD_R_NUM(__INFO{   hi after },H,+($3)/256,L,$3,DE,$2)){}dnl
__{}__{}define({$0_TMP_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}__{}ifelse(eval($0_TMP_P<$0_BEST_P),1,{dnl
__{}__{}__{}define({$0_CODE_1},{}){}dnl
__{}__{}__{}define({$0_CODE_2},{}){}dnl
__{}__{}__{}define({$0_CODE_3},{}){}dnl
__{}__{}__{}define({$0_CODE_4},{}){}dnl
__{}__{}__{}define({$0_CODE_5},{}){}dnl
__{}__{}__{}define({$0_BEST_C},__SUM_CLOCKS){}dnl
__{}__{}__{}define({$0_BEST_B},__SUM_BYTES){}dnl
__{}__{}__{}define({$0_BEST_P},$0_TMP_P)},
__{}__{}{dnl
__{}__{}__{}define({$0_CODE_6},{}){}dnl
__{}__{}}){}dnl
__{}}){}dnl
__{}ifelse(__IS_MEM_REF($3),0,{dnl
__{}__{}dnl # HL_D_HL_E
__{}__{}pushdef({__SUM_CLOCKS},33){}dnl
__{}__{}pushdef({__SUM_BYTES},3){}dnl
__{}__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}__{}define({$0_CODE_7},{
__{}__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 )  # HL D HL E
__{}__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__{}__LD_R16(                                        HL,$1){}dnl
__{}__{}__{}{
__{}__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__{}__LD_R_NUM(__INFO{   hi before},     D,+($2)/256,HL,$1){}dnl
__{}__{}__{}__LD_R16(HL,$3,                      D,+($2)/256,HL,$1){}dnl
__{}__{}__{}__LD_R_NUM(__INFO{   lo after },E,$2,D,+($2)/256,HL,$3)){}dnl
__{}__{}define({$0_TMP_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}__{}ifelse(eval($0_TMP_P<$0_BEST_P),1,{dnl
__{}__{}__{}define({$0_CODE_1},{}){}dnl
__{}__{}__{}define({$0_CODE_2},{}){}dnl
__{}__{}__{}define({$0_CODE_3},{}){}dnl
__{}__{}__{}define({$0_CODE_4},{}){}dnl
__{}__{}__{}define({$0_CODE_5},{}){}dnl
__{}__{}__{}define({$0_CODE_6},{}){}dnl
__{}__{}__{}define({$0_BEST_C},__SUM_CLOCKS){}dnl
__{}__{}__{}define({$0_BEST_B},__SUM_BYTES){}dnl
__{}__{}__{}define({$0_BEST_P},$0_TMP_P)},
__{}__{}{dnl
__{}__{}__{}define({$0_CODE_7},{}){}dnl
__{}__{}}){}dnl
__{}__{}dnl # HL_E_HL_D
__{}__{}pushdef({__SUM_CLOCKS},33){}dnl
__{}__{}pushdef({__SUM_BYTES},3){}dnl
__{}__{}pushdef({__SUM_PRICE},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}__{}define({$0_CODE_8},{
__{}__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 )  # HL E HL D
__{}__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__{}__LD_R16(                                        HL,$1){}dnl
__{}__{}__{}{
__{}__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__{}__LD_R_NUM(__INFO{   lo before},            E,$2,HL,$1){}dnl
__{}__{}__{}__LD_R16(HL,$3,                             E,$2,HL,$1){}dnl
__{}__{}__{}__LD_R_NUM(__INFO{   hi after },D,+($2)/256,E,$2,HL,$3)){}dnl
__{}__{}define({$0_TMP_P},eval(__SUM_CLOCKS+__BYTE_PRICE*__SUM_BYTES)){}dnl
__{}__{}ifelse(eval($0_TMP_P<$0_BEST_P),1,{dnl
__{}__{}__{}define({$0_CODE_1},{}){}dnl
__{}__{}__{}define({$0_CODE_2},{}){}dnl
__{}__{}__{}define({$0_CODE_3},{}){}dnl
__{}__{}__{}define({$0_CODE_4},{}){}dnl
__{}__{}__{}define({$0_CODE_5},{}){}dnl
__{}__{}__{}define({$0_CODE_6},{}){}dnl
__{}__{}__{}define({$0_CODE_7},{}){}dnl
__{}__{}__{}define({$0_BEST_C},__SUM_CLOCKS){}dnl
__{}__{}__{}define({$0_BEST_B},__SUM_BYTES){}dnl
__{}__{}__{}define({$0_BEST_P},$0_TMP_P)},
__{}__{}{dnl
__{}__{}__{}define({$0_CODE_8},{}){}dnl
__{}__{}}){}dnl
__{}}){}dnl
__{}dnl
__{}define({__CLOCKS},$0_BEST_C){}dnl
__{}define({__BYTES}, $0_BEST_B){}dnl
__{}define({__PRICE}, $0_BEST_P){}dnl
__{}__{}$0_CODE_1{}dnl
__{}__{}$0_CODE_2{}dnl
__{}__{}$0_CODE_3{}dnl
__{}__{}$0_CODE_4{}dnl
__{}__{}$0_CODE_5{}dnl
__{}__{}$0_CODE_6{}dnl
__{}__{}$0_CODE_7{}dnl
__{}__{}$0_CODE_8{}dnl
__{}popdef({__SUM_CLOCKS}){}dnl
__{}popdef({__SUM_BYTES}){}dnl
__{}popdef({__SUM_PRICE}){}dnl
__{}__add({__SUM_CLOCKS},__CLOCKS){}dnl
__{}__add({__SUM_BYTES}, __BYTES){}dnl
__{}__add({__SUM_PRICE}, __PRICE){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( -- d c b a)
dnl # push4(d,c,b,a) ulozi na zasobnik nasledujici polozky
define({PUSH4},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHS},__REMOVE_COMMA($@),$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH4},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<4),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>4),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
dnl #
dnl #       de hl       de hl       de hl       de hl
dnl # $1 $2 $3 $4 $1 $2 $3 $4 $1 $2 $3 $4 $1 $2 $3 $4
dnl # hl hl hl hl                                        0 fail
dnl #
dnl # hl hl    hl       de                               1 befaft 3x!
dnl #    hl       hl       hl       de                   1 befaft 3x!
dnl #
dnl # hl hl de hl                                        2 befaft
dnl #    hl       hl    de hl                            2 befaft
dnl #
dnl # hl       hl    de             de                   3 befaft
dnl #    hl    hl de                de                   3 befaft
dnl #
dnl # hl    de       hl    hl                            4
dnl #    hl de    hl       hl                            4
dnl #
dnl # hl de    hl       de                               5
dnl #    hl       de       hl       de                   5
dnl #
dnl # hl de de hl                                        6 befaft
dnl #    hl       de    de hl                            6 befaft
dnl #
dnl #          hl de de de                               7
dnl #          hl    de       de    de                   7
dnl #
dnl #       de    hl hl    hl                            8
dnl #       de       hl       hl       hl                8
dnl #
dnl # de hl    hl       de                               9 befaft
dnl #    de       hl       hl       de                   9 befaft
dnl #
dnl # de hl de hl                                        A
dnl #    de       hl    de hl                            A
dnl #
dnl # de       hl    de de                               B
dnl #    de    hl de    de                               B
dnl #
dnl # de    de       hl    hl                            C befaft
dnl #    de de    hl       hl                            C befaft
dnl #
dnl # de de    hl       de                               D befaft
dnl #    de       de       hl       de                   D befaft
dnl #
dnl # de de de hl                                        E befaft 3x!
dnl #    de       de    de hl                            E befaft 3x!
dnl #
dnl # de de de de                                        F fail
dnl # $1 $2 $3 $4 $1 $2 $3 $4 $1 $2 $3 $4 $1 $2 $3 $4
dnl #       de hl       de hl       de hl       de hl
dnl #
__{}__PUSH2_P($1,$2){}dnl
__{}define({__P1},eval(__TMP_CLOCKS+4*__TMP_BYTES)){}dnl
__{}define({__P2},__P1){}dnl
dnl
__{}__LD_REG16({DE},$3,{DE},$1,{HL},$2){}dnl
__{}__add({__P1},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},$4,{DE},$3,{HL},$2){}dnl
__{}__add({__P1},__PRICE_16BIT){}dnl
__{}define({__TYPE},1){}define({__P},__P1){}dnl
dnl
__{}__LD_REG16({HL},$4,{DE},$1,{HL},$2){}dnl
__{}__add({__P2},__PRICE_16BIT){}dnl
__{}__LD_REG16({DE},$3,{DE},$1,{HL},$4){}dnl
__{}__add({__P2},__PRICE_16BIT){}dnl
__{}ifelse(eval(__P2<__P),1,{define({__TYPE},2){}define({__P},__P2)}){}dnl
dnl
__{}__PUSH2_P($2,$1){}dnl
__{}define({__P3},eval(__TMP_CLOCKS+4*__TMP_BYTES)){}dnl
__{}define({__P4},__P3){}dnl
dnl
__{}__LD_REG16({DE},$3,{DE},$2,{HL},$1){}dnl
__{}__add({__P3},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},$4,{DE},$3,{HL},$1){}dnl
__{}__add({__P3},__PRICE_16BIT){}dnl
__{}ifelse(eval(__P3<__P),1,{define({__TYPE},3){}define({__P},__P3)}){}dnl
dnl
__{}__LD_REG16({HL},$4,{DE},$2,{HL},$1){}dnl
__{}__add({__P4},__PRICE_16BIT){}dnl
__{}__LD_REG16({DE},$3,{DE},$2,{HL},$4){}dnl
__{}__add({__P4},__PRICE_16BIT){}dnl
__{}ifelse(eval(__P4<__P),1,{define({__TYPE},4){}define({__P},__P4)}){}dnl
dnl
__{}ifelse(__TYPE,1,{
    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 $4 )
    push HL             ; 1:11      __INFO{}dnl
__{}__PUSH2_P($1,$2){}__TMP_CODE
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO{}dnl
__{}__LD_REG16({DE},$3,{DE},$1,{HL},$2){}dnl
__{}__CODE_16BIT{}dnl
__{}__LD_REG16({HL},$4,{DE},$3,{HL},$2){}dnl
__{}__CODE_16BIT{}dnl
__{}},
__{}__TYPE,2,{
    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 $4 )
    push HL             ; 1:11      __INFO{}dnl
__{}__PUSH2_P($1,$2){}__TMP_CODE
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO{}dnl
__{}__LD_REG16({HL},$4,{DE},$1,{HL},$2){}dnl
__{}__CODE_16BIT{}dnl
__{}__LD_REG16({DE},$3,{DE},$1,{HL},$4){}dnl
__{}__CODE_16BIT{}dnl
__{}},
__{}__TYPE,3,{
    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 $4 )
    push HL             ; 1:11      __INFO{}dnl
__{}__PUSH2_P($2,$1){}__TMP_CODE
    push HL             ; 1:11      __INFO
    push DE             ; 1:11      __INFO{}dnl
__{}__LD_REG16({DE},$3,{DE},$2,{HL},$1){}dnl
__{}__CODE_16BIT{}dnl
__{}__LD_REG16({HL},$4,{DE},$3,{HL},$1){}dnl
__{}__CODE_16BIT{}dnl
__{}},
__{}__TYPE,4,{
    push DE             ; 1:11      __INFO   ( -- $1 $2 $3 $4 )
    push HL             ; 1:11      __INFO{}dnl
__{}__PUSH2_P($2,$1){}__TMP_CODE
    push HL             ; 1:11      __INFO
    push DE             ; 1:11      __INFO{}dnl
__{}__LD_REG16({HL},$4,{DE},$2,{HL},$1){}dnl
__{}__CODE_16BIT{}dnl
__{}__LD_REG16({DE},$3,{DE},$2,{HL},$4){}dnl
__{}__CODE_16BIT{}dnl
__{}}){}dnl
})}){}dnl
dnl
dnl
define({__PUSH2_P},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=2),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{dnl
__{}define({_TMP_INFO},__INFO){}dnl # HL first check
__{}define({__TMP_HL_CLOCKS},22){}dnl
__{}define({__TMP_HL_BYTES},2){}dnl
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}__add({__TMP_HL_CLOCKS},__CLOCKS_16BIT){}dnl
__{}__add({__TMP_HL_BYTES}, __BYTES_16BIT){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}__add({__TMP_HL_CLOCKS},__CLOCKS_16BIT){}dnl
__{}__add({__TMP_HL_BYTES}, __BYTES_16BIT){}dnl
__{}dnl
__{}define({__TMP_DE_CLOCKS},22){}dnl
__{}define({__TMP_DE_BYTES},2){}dnl
__{}__LD_REG16({HL},$2,{DE},$1){}dnl # DE first check
__{}__add({__TMP_DE_CLOCKS},__CLOCKS_16BIT){}dnl
__{}__add({__TMP_DE_BYTES}, __BYTES_16BIT){}dnl
__{}__LD_REG16({DE},$1){}dnl
__{}__add({__TMP_DE_CLOCKS},__CLOCKS_16BIT){}dnl
__{}__add({__TMP_DE_BYTES}, __BYTES_16BIT){}dnl
__{}dnl
__{}ifelse(eval(__TMP_DE_CLOCKS<=__TMP_HL_CLOCKS),{1},{dnl # DE first
__{}__{}define({__TMP_CLOCKS},__TMP_DE_CLOCKS){}dnl
__{}__{}define({__TMP_BYTES},__TMP_DE_BYTES){}dnl
__{}__{}define({__TMP_CODE},{__LD_REG16({DE},}$1{){}__CODE_16BIT{}__LD_REG16({HL},}$2{,{DE},}$1{){}__CODE_16BIT}){}dnl
__{}},
__{}{dnl # HL first
__{}__{}define({__TMP_CLOCKS},__TMP_HL_CLOCKS){}dnl
__{}__{}define({__TMP_BYTES},__TMP_HL_BYTES){}dnl
__{}__{}define({__TMP_CODE},{__LD_REG16({HL},}$2{){}__CODE_16BIT{}__LD_REG16({DE},}$1{,{HL},}$2{){}__CODE_16BIT}){}dnl
__{}}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( b a -- a b )
dnl # prohodi vrchol zasobniku s druhou polozkou
define({SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP},{swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex   DE, HL         ; 1:4       __INFO   ( b a -- a b )}){}dnl
dnl
dnl
dnl
dnl # ( 0xaabb -- 0xbbaa )
define({CSWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_CSWAP},{cswap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CSWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, L          ; 1:4       __INFO   ( 0xbbaa -- 0xaabb )
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( b a -- a b a )
define({SWAP_OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_OVER},{swap over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_OVER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl

    push HL             ; 1:11      __INFO   ( b a -- a b a )}){}dnl
dnl
dnl
dnl
dnl # $1 -rot
dnl # ( b a -- $1 b a )
define({PUSH_NROT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_NROT},{$1 -rot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_NROT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected type parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO   ( x1 x0 -- $1 x1 x0 )
__{}__{}    push BC             ; 1:11      __INFO},
__{}{
__{}__{}    ld   BC, __FORM({%-11s},$1); 3:10      __INFO   ( x1 x0 -- $1 x1 x0 )
__{}__{}    push BC             ; 1:11      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # swap 3
dnl # ( b a -- a b 3 )
define({SWAP_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_PUSH},{swap $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO   ( b a -- a b $1 )},
__{}{
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO   ( b a -- a b $1 )}){}dnl
}){}dnl
dnl
dnl
dnl # nip $1 swap
dnl # ( b a -- $1 a )
define({NIP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP},{nip $1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected type parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}    ld   DE, format({%-11s},$1); 4:20      __INFO   ( x1 x0 -- $1 x0 )},
__{}{
__{}__{}    ld   DE, __FORM({%-11s},$1); 3:10      __INFO   ( x1 x0 -- $1 x0 )}){}dnl
}){}dnl
dnl
dnl
dnl # $1 swap
dnl # ( a -- $1 a )
define({PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SWAP},{$1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected type parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}    push DE             ; 1:11      __INFO   ( x -- $1 x )
__{}__{}    ld   DE, format({%-11s},$1); 4:20      __INFO},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( x -- $1 x )
__{}__{}    ld   DE, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # nip $1 swap $2 swap
dnl # ( x1 x0 -- $1 $2 x0 )
define({NIP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP},{nip $1 swap $2 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<2),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO   ( x1 x0 -- $1 $2 x0 )){}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # $1 swap $2 swap
dnl # ( x -- $1 $2 x )
define({PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP},{$1 swap $2 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<2),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( x -- $1 $2 x ){}dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}    ld   DE, format({%-11s},$1); 4:20      __INFO},
__{}__{}{
__{}__{}__{}    ld   DE, __FORM({%-11s},$1); 3:10      __INFO})
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # nip $1 swap $2 swap $3 swap
dnl # ( x1 x0 -- $1 $2 $3 x0 )
define({NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{nip $1 swap $2 swap $3 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<3),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO   ( x1 x0 -- $1 $2 $3 x0 )){}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$3,{DE},$2){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # $1 swap $2 swap $3 swap
dnl # ( x -- $1 $2 $3 x )
define({PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{$1 swap $2 swap $3 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<3),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( x -- $1 $2 $3 x ){}dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}    ld   DE, format({%-11s},$1); 4:20      __INFO},
__{}__{}{
__{}__{}__{}    ld   DE, __FORM({%-11s},$1); 3:10      __INFO})
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$3,{DE},$2){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # nip $1 swap $2 swap $3 swap $4 swap
dnl # ( x1 x0 -- $1 $2 $3 $4 x0 )
define({NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{nip $1 swap $2 swap $3 swap $4 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<4),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>4),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO   ( x1 x0 -- $1 $2 $3 $4 x0 )){}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$3,{DE},$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$4,{DE},$3){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # $1 swap $2 swap $3 swap $4 swap
dnl # ( x -- $1 $2 $3 $4 x )
define({PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{$1 swap $2 swap $3 swap $4 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<4),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>4),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( x -- $1 $2 $3 $4 x ){}dnl
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}    ld   DE, format({%-11s},$1); 4:20      __INFO},
__{}__{}{
__{}__{}__{}    ld   DE, __FORM({%-11s},$1); 3:10      __INFO})
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$3,{DE},$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$4,{DE},$3){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # nip $1 swap $2 swap $3 swap $4 swap $5 swap
dnl # ( x1 x0 -- $1 $2 $3 $4 $5 x0 )
define({NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{nip $1 swap $2 swap $3 swap $4 swap $5 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<5),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>5),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO   ( x1 x0 -- $1 $2 $3 $4 $5 x0 )){}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$3,{DE},$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$4,{DE},$3){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$5,{DE},$4){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # $1 swap $2 swap $3 swap $4 swap $5 swap
dnl # ( x0 -- $1 $2 $3 $4 $5 x0 )
define({PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{$1 swap $2 swap $3 swap $4 swap $5 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<5),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>5),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO   ( x0 -- $1 $2 $3 $4 $5 x0 ))
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$3,{DE},$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$4,{DE},$3){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$5,{DE},$4){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # nip $1 swap $2 swap $3 swap $4 swap $5 swap $6 swap
dnl # ( x1 x0 -- $1 $2 $3 $4 $5 $6 x0 )
define({NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{nip $1 swap $2 swap $3 swap $4 swap $5 swap $6 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<6),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>6),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO   ( x1 x0 -- $1 $2 $3 $4 $5 $6 x0 )){}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$3,{DE},$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$4,{DE},$3){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$5,{DE},$4){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$6,{DE},$5){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # $1 swap $2 swap $3 swap $4 swap $5 swap $6 swap
dnl # ( x0 -- $1 $2 $3 $4 $5 $6 x0 )
define({PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{$1 swap $2 swap $3 swap $4 swap $5 swap $6 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<6),{1},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>6),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO   ( x0 -- $1 $2 $3 $4 $5 $6 x0 ))
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$3,{DE},$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$4,{DE},$3){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$5,{DE},$4){}dnl
__{}__{}__CODE_16BIT
__{}__{}    push DE             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({DE},$6,{DE},$5){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # swap drop 3 swap
dnl # ( b a -- 3 a )
define({SWAP_DROP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP},{swap drop $1 swap},$@){}dnl
}){}dnl
dnl
dnl # nip 3 swap
dnl # ( b a -- 3 a )
define({NIP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP},{nip $1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected type parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}    ld   DE, format({%-11s},$1); 4:20      __INFO   ( b a -- $1 a )},
__{}{
__{}__{}    ld   DE, __FORM({%-11s},$1); 3:10      __INFO   ( b a -- $1 a )}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # never print first "$1"
define({__REC_PUSHS_SWAP},{ifelse(eval($#>1),1,{
__{}    push DE             ; 1:11      __INFO{}dnl
__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}__CODE_16BIT{}dnl
__{}$0(shift($@))}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # >R $1 ... $n R>
dnl # ( a -- $1 .. $n a )
define({TO_R_PUSHS_R_FROM},{dnl
__{}__ADD_TOKEN({__TOKEN_TO_R_PUSHS_R_FROM},{>r __REMOVE_COMMA($@) r>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TO_R_PUSHS_R_FROM},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#),{1},{__ASM_TOKEN_PUSH_SWAP($@)},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( x -- __REMOVE_COMMA($@) x ){}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}__REC_PUSHS_SWAP($@)}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( d c b a -- b a d c )
dnl # Exchange the top two cell pairs.
define({_2SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_2SWAP},{2swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2SWAP},{dnl
__{}define({__INFO},{2swap}){}dnl
ifelse(TYP_2SWAP,{fast},{
                        ;[7:56]     __INFO   ( d c b a -- b a d c ) # fast version can be changed with "define({TYP_2SWAP},{name})", name=default
    ex   DE, HL         ; 1:4       __INFO   d c . a b
    pop  BC             ; 1:10      __INFO   d   . a b     BC = c
    ex  (SP), HL        ; 1:19      __INFO   b   . a d
    ex   DE, HL         ; 1:4       __INFO   b   . d a
    push HL             ; 1:11      __INFO   b a . d a
    ld    L, C          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO   b a . d c},
{
                        ;[6:67]     __INFO   ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      __INFO   d a . b c
    ex   DE, HL         ; 1:4       __INFO   d a . c b
    pop  AF             ; 1:10      __INFO   d   . c b     AF = a
    ex  (SP),HL         ; 1:19      __INFO   b   . c d
    ex   DE, HL         ; 1:4       __INFO   b   . d c
    push AF             ; 1:11      __INFO   b a . d c})}){}dnl
dnl
dnl
dnl # ( a -- a a )
dnl # vytvori kopii vrcholu zasobniku
define({DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP},{dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( a -- a a )
    ld    D, H          ; 1:4       __INFO
    ld    E, L          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( a -- a a a )
dnl # vytvori 2x kopii vrcholu zasobniku
define({DUP_DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_DUP},{dup_dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_DUP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( a -- a a a )
    push HL             ; 1:11      __INFO
    ld    D, H          ; 1:4       __INFO
    ld    E, L          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ?dup
dnl # ( a -- a a ) or ( 0 -- 0 )
dnl # vytvori kopii vrcholu zasobniku pokud je nenulovy
define({QUESTIONDUP},{dnl
__{}__ADD_TOKEN({__TOKEN_QDUP},{?dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_QDUP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO   ( a -- 0 | a a )
    or    L             ; 1:4       __INFO
    jr    z, $+5        ; 2:7/12    __INFO   ( 0 -- 0 )
    push DE             ; 1:11      __INFO   ( a -- a a )
    ld    D, H          ; 1:4       __INFO
    ld    E, L          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # 2dup
dnl # ( b a -- b a b a )
dnl # over over
define({_2DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP},{2dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO   ( b a -- b a b a )}){}dnl
dnl
dnl
dnl # 3dup
dnl # ( c b a -- c b a c b a )
dnl # 2 pick 2 pick 2 pick
define({_3DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_3DUP},{3dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3DUP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:54]     __INFO   ( c b a -- c b a c b a )
    pop  AF             ; 1:10      __INFO   . . . . b a
    push AF             ; 1:11      __INFO   c . . . b a
    push DE             ; 1:11      __INFO   c b . . b a
    push HL             ; 1:11      __INFO   c b a . b a
    push AF             ; 1:11      __INFO   c b a c b a}){}dnl
dnl
dnl
dnl # 4dup
dnl # 3 pick 3 pick 3 pick 3 pick
dnl # 2over 2over
dnl # ( d c b a  --  d c b a d c b a )
dnl # ( d2 d1 -- d2 d1 d2 d1 )
define({_4DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP},{4dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:86]     __INFO   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      __INFO
    pop  AF             ; 1:10      __INFO
    push AF             ; 1:11      __INFO
    push BC             ; 1:11      __INFO
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    push AF             ; 1:11      __INFO
    push BC             ; 1:11      __INFO}){}dnl
dnl
dnl
dnl # 4dup drop
dnl # 3 pick 3 pick 3 pick
dnl # 2over 2over drop
dnl # ( d c b a  --  d c b a d c b )
define({_4DUP_DROP},{dnl
__{}__ADD_TOKEN({__TOKEN_4DUP_DROP},{4dup drop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4DUP_DROP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(_TYP_SINGLE,{small},{
                        ;[9:98]     __INFO   ( d c b a -- d c b a d c b )
    ex  (SP),HL         ; 1:19      __INFO   HL = c
    pop  AF             ; 1:10      __INFO   AF = a
    pop  BC             ; 1:10      __INFO   BC = d
    push BC             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    push DE             ; 1:11      __INFO
    push AF             ; 1:11      __INFO
    push BC             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO},
{
                       ;[10:87]     __INFO   ( d c b a -- d c b a d c b )
    ex   DE, HL         ; 1:4       __INFO
    pop  BC             ; 1:10      __INFO   BC = c
    pop  AF             ; 1:10      __INFO   AF = d
    push AF             ; 1:11      __INFO
    push BC             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    push DE             ; 1:11      __INFO
    push AF             ; 1:11      __INFO
    ld    L, C          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO})}){}dnl
dnl
dnl
dnl # 5dup
dnl # 4 pick 4 pick 4 pick 4 pick 4 pick
dnl # ( e d c b a  --  e d c b a e d c b a )
dnl # ( x d2 d1 -- x d2 d1 x d2 d1 )
define({_5DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_5DUP},{5dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_5DUP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[15:134]    __INFO   ( e d c b a -- e d c b a e d c b a )
    pop  BC             ; 1:10      __INFO   e d . . . . . . b a
    pop  AF             ; 1:10      __INFO   e . . . . . . . b a
    ex   AF, AF'        ; 1:4       __INFO
    pop  AF             ; 1:10      __INFO   . . . . . . . . b a
    push AF             ; 1:11      __INFO   e . . . . . . . b a
    ex   AF, AF'        ; 1:4       __INFO
    push AF             ; 1:11      __INFO   e d . . . . . . b a
    push BC             ; 1:11      __INFO   e d c . . . . . b a
    push DE             ; 1:11      __INFO   e d c b . . . . b a
    push HL             ; 1:11      __INFO   e d c b a . . . b a
    ex   AF, AF'        ; 1:4       __INFO
    push AF             ; 1:11      __INFO   e d c b a e . . b a
    ex   AF, AF'        ; 1:4       __INFO
    push AF             ; 1:11      __INFO   e d c b a e d . b a
    push BC             ; 1:11      __INFO   e d c b a e d c b a}){}dnl
dnl
dnl
dnl # 6dup
dnl # 5 pick 5 pick 5 pick 5 pick 5 pick 5 pick
dnl # ( f e d c b a  --  f e d c b a f e d c b a )
dnl # ( d3 d2 d1 -- d3 d2 d1 d3 d2 d1 )
define({_6DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_6DUP},{6dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_6DUP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(_TYP_SINGLE,{small},{
                       ;[14:440]    __INFO   ( d3 d2 d1 -- d3 d2 d1 d3 d2 d1 )   # small version can be changed with "define({_TYP_SINGLE},{default})"
    ld    B, 0x06       ; 2:7       __INFO   6x "5 pick"
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, 0x0008     ; 3:10      __INFO
    add  HL, SP         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    djnz $-10           ; 2:8/13    __INFO},
{
                       ;[18:166]    __INFO   ( e d c b a -- e d c b a e d c b a )
    pop  BC             ; 1:10      __INFO   f e d . . . . . . . b a
    exx                 ; 1:4       __INFO
    pop  AF             ; 1:10      __INFO   f e . . . . . . . . - -
    pop  BC             ; 1:10      __INFO   f . . . . . . . . . - -
    pop  DE             ; 1:10      __INFO   . . . . . . . . . . - -
    push DE             ; 1:11      __INFO   f . . . . . . . . . - -
    push BC             ; 1:11      __INFO   f e . . . . . . . . - -
    push AF             ; 1:11      __INFO   f e d . . . . . . . - -
    exx                 ; 1:4       __INFO
    push BC             ; 1:11      __INFO   f e d c . . . . . . b a
    push DE             ; 1:11      __INFO   f e d c b . . . . . b a
    push HL             ; 1:11      __INFO   f e d c b a . . . . b a
    exx                 ; 1:4       __INFO
    push DE             ; 1:11      __INFO   f e d c b a f . . . - -
    push BC             ; 1:11      __INFO   f e d c b a f e . . - -
    push AF             ; 1:11      __INFO   f e d c b a f e d . - -
    exx                 ; 1:4       __INFO
    push BC             ; 1:11      __INFO   f e d c b a f e d c b a})}){}dnl
dnl
dnl
dnl # ( a -- )
dnl # odstrani vrchol zasobniku
define({DROP},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP},{drop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   ( a -- )}){}dnl
dnl
dnl
dnl # ( b a -- b b )
define({DROP_DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_DUP},{drop dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_DUP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld   H, D           ; 1:4       __INFO   ( b a -- b b )
    ld   L, E           ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( c b a -- b c )
define({DROP_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_SWAP},{drop swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop HL              ; 1:11      __INFO   ( c b a -- b c )}){}dnl
dnl
dnl
dnl
dnl # drop 50
dnl # ( a -- 50 )
dnl # zmeni hodnotu top
define({DROP_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_PUSH},{drop $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected type parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( c b a -- c b c )
define({DROP_OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_OVER},{drop over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_OVER},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  HL             ; 1:10      __INFO   ( c b a -- c b c )
    push HL             ; 1:11      __INFO}){}dnl
dnl
dnl
dnl
dnl # drop dup 50
dnl # ( x2 x1 -- x2 x2 50 )
define({DROP_DUP_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_DUP_PUSH},{drop dup $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_DUP_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected type parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      __INFO   ( x2 x1 -- x2 x2 $1 )
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{
__{}    push DE             ; 1:11      __INFO   ( x2 x1 -- x2 x2 $1 )
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # drop 50 over
dnl # ( a -- 50 )
dnl # zmeni hodnotu top
define({DROP_PUSH_OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_PUSH_OVER},{drop $1 over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_PUSH_OVER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected type parameter!},
__{}__{}__IS_MEM_REF($1),{1},{
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO},
__{}{
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2drop 50
dnl # ( a -- 50 )
dnl # zmeni hodnotu top
define({_2DROP_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_2DROP_PUSH},{2drop $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DROP_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected type parameter!},
__{}__IS_MEM_REF($1),{1},{
__{}    pop  DE             ; 1:10      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{
__{}    pop  DE             ; 1:10      __INFO
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2drop
dnl # ( b a -- )
dnl # odstrani 2x vrchol zasobniku
define({_2DROP},{dnl
__{}__ADD_TOKEN({__TOKEN_2DROP},{2drop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DROP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  HL             ; 1:10      __INFO   ( b a -- )
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # drop drop drop
dnl # 2drop drop
dnl # ( c b a -- )
dnl # odstrani 3x vrchol zasobniku
define({_3DROP},{dnl
__{}__ADD_TOKEN({__TOKEN_3DROP},{2drop drop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3DROP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  HL             ; 1:10      __INFO   ( c b a -- )
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # drop drop drop
dnl # 2drop drop
dnl # ( c b a -- )
dnl # odstrani 3x vrchol zasobniku
define({DROPS},{dnl
__{}__ADD_TOKEN({__TOKEN_DROPS},{drops($1)},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROPS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,,{
__{}__{}  .error {$0}($@): Missing parameter!},

__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},

__{}__IS_MEM_REF($1),1,{
__{}__{}  .error {$0}($@): Parameter is pointer!},

__{}__IS_NUM($1),0,{
__{}__{}  .error {$0}($@): Parameter is not number!},

__{}{dnl
__{}__{}ifelse(__HEX_HL($1),0x0000,{
__{}__{}__{}                        ;           __INFO   ( -- )},

__{}__{}eval(($1<0) || ($1 & 0x8000)),1,{
__{}__{}__{}  .error {$0}($@): Parameter is negative!},

__{}__{}__HEX_HL($1),0x0001,{__ASM_TOKEN_DROP},

__{}__{}__HEX_HL($1),0x0002,{__ASM_TOKEN_2DROP},

__{}__{}__HEX_HL($1),0x0003,{__ASM_TOKEN_3DROP},

__{}__{}__HEX_HL($1),0x0004,{__ASM_TOKEN_2DROP{}__ASM_TOKEN_2DROP},

__{}__{}__HEX_HL($1),0x0005,{__ASM_TOKEN_3DROP{}__ASM_TOKEN_2DROP},

__{}__{}__HEX_HL($1):__TYP_SINGLE,0x0006:{small},{__ASM_TOKEN_2DROP{}__ASM_TOKEN_2DROP{}__ASM_TOKEN_2DROP},

__{}__{}{
__{}__{}__{}                        ;[7:47]     __INFO   ( $1*x -- )
__{}__{}__{}    ld   HL, format({%-11s},__HEX_HL(2*($1-2))); 3:10      __INFO
__{}__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}__{}    ld   SP, HL         ; 1:6       __INFO
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # ( b a -- a )
dnl # : nip swap drop ;
dnl # drop_second
define({NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP},{nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  DE             ; 1:10      __INFO   ( b a -- a )}){}dnl
dnl
dnl
dnl
dnl # ( b a -- a a )
define({NIP_DUP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_DUP},{nip dup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_DUP},{dnl
ifelse(eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameters!},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    ld    E, L          ; 1:4       __INFO   ( b a -- a a )
__{}    ld    D, H          ; 1:4       __INFO{}dnl
})}){}dnl
dnl
dnl
dnl # nip 3
dnl # ( b a -- a 3 )
define({NIP_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH},{nip $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH},{dnl
define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected type parameter!},
__IS_MEM_REF($1),{1},{
__{}    ex   DE, HL         ; 1:4       __INFO   ( b a -- a $1 )
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
{
__{}    ex   DE, HL         ; 1:4       __INFO   ( b a -- a $1 )
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ( d c b a – b a )
dnl # : 2nip 2swap 2drop ;
dnl # drop_second
define({_2NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_2NIP},{2nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2NIP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  AF             ; 1:10      __INFO   ( d c b a -- b a )
    pop  AF             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( b a -- a b a )
dnl # : tuck swap over ;
define({TUCK},{dnl
__{}__ADD_TOKEN({__TOKEN_TUCK},{tuck},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push HL             ; 1:11      __INFO   ( b a -- a b a )}){}dnl
dnl
dnl
dnl # ( d c b a -- b a d c b a )
dnl # : 2tuck 2swap 2over ;
define({_2TUCK},{dnl
__{}__ADD_TOKEN({__TOKEN_2TUCK},{2tuck},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2TUCK},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:64]     __INFO   ( d c b a -- b a d c b a )
    pop  AF             ; 1:10      __INFO       d   . b a     AF = c
    pop  BC             ; 1:10      __INFO           . b a     BC = d
    push DE             ; 1:11      __INFO   b       . b a
    push HL             ; 1:11      __INFO   b a     . b a
    push BC             ; 1:11      __INFO   b a d   . b a
    push AF             ; 1:11      __INFO   b a d c . b a}){}dnl
dnl
dnl
dnl # ( b a -- b a b )
dnl # vytvori kopii druhe polozky na zasobniku
define({OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER},{over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( b a -- b a b )
    ex   DE, HL         ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( b a -- b b a )
define({OVER_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP},{over swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( b a -- b b a )}){}dnl
dnl
dnl
dnl # 3 over
dnl # ( a -- a 3 a )
define({PUSH_OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER},{$1 over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      __INFO   ( a -- a $1 a )
__{}    push HL             ; 1:11      __INFO
__{}    ld   DE, format({%-11s},$1); 4:20      __INFO},
__{}{
__{}    push DE             ; 1:11      __INFO   ( a -- a $1 a )
__{}    push HL             ; 1:11      __INFO
__{}    ld   DE, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # 3 2over
dnl # ( c b a -- c b a 3 c b )
define({PUSH_2OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_2OVER},{$1 2over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_2OVER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}    pop  BC             ; 1:10      __INFO   ( c b a -- c b a $1 c b )
__{}    push BC             ; 1:11      __INFO
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},$1); 3:16      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    E, C          ; 1:4       __INFO
__{}    ld    D, B          ; 1:4       __INFO},
__{}{
__{}    pop  BC             ; 1:10      __INFO   ( c b a -- c b a $1 c b )
__{}    push BC             ; 1:11      __INFO
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    E, C          ; 1:4       __INFO
__{}    ld    D, B          ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # 3 2over nip
dnl # ( b a -- b a 3 b )
define({PUSH_2OVER_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_2OVER_NIP},{$1 2over nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_2OVER_NIP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_OVER_PUSH_SWAP($@){}dnl
}){}dnl
dnl
dnl
define({DUP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_SWAP},{dup $1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_SWAP},{dnl
__{}define({__INFO},{dup $1 swap}){}dnl
__ASM_TOKEN_PUSH_OVER($1)}){}dnl
dnl
dnl
dnl # over 3
dnl # ( b a -- b a b 3 )
define({OVER_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PUSH},{over $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      __INFO   ( b a -- b a b $1 )
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{
__{}    push DE             ; 1:11      __INFO   ( b a -- b a b $1 )
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # over 3 swap
dnl # ( b a -- b a 3 b )
define({OVER_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PUSH_SWAP},{over $1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}                        ;[6:42]     __INFO   ( x1 x0 -- x1 x0 $1 x1 )
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO},
__{}{
__{}                        ;[6:36]     __INFO   ( x1 x0 -- x1 x0 $1 x1 )
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # ( d c b a -- d c b a d c )
dnl # Copy cell pair "d c" to the top of the stack.
define({_2OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER},{2over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:91]     __INFO   ( d c b a -- d c b a d c )
    pop  AF             ; 1:10      __INFO   d       . b a     AF = c
    pop  BC             ; 1:10      __INFO           . b a     BC = d
    push BC             ; 1:11      __INFO   d       . b a
    push AF             ; 1:11      __INFO   d c     . b a
    push DE             ; 1:11      __INFO   d c b   . b a
    push AF             ; 1:11      __INFO   d c b c . b a
    ex  (SP),HL         ; 1:19      __INFO   d c b a . b c
    ld    D, B          ; 1:4       __INFO
    ld    E, C          ; 1:4       __INFO   d c b a . d c}){}dnl
dnl
dnl
dnl # ( d c b a -- d c b a c )
dnl #   ( c b a -- c b a c )
dnl # 2over nip == 2 pick
define({_2OVER_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP},{2over nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(_TYP_SINGLE,{small},{
                        ;[5:55]     __INFO   ( c b a -- c b a c )
    pop  BC             ; 1:10      __INFO       . b a     BC = c
    push BC             ; 1:11      __INFO   c   . b a
    push BC             ; 1:11      __INFO   c c . b a
    ex   DE, HL         ; 1:4       __INFO   c c . a b
    ex  (SP),HL         ; 1:19      __INFO   c b . a c},
{
                        ;[6:44]     __INFO   ( c b a -- c b a c )
    pop  BC             ; 1:10      __INFO       . b a   BC = c
    push BC             ; 1:11      __INFO   c   . b a
    push DE             ; 1:11      __INFO   c b . b a
    ex   DE, HL         ; 1:4       __INFO   c b . a b
    ld    L, C          ; 1:4       __INFO   c b . a -
    ld    H, B          ; 1:4       __INFO   c b . a c}){}dnl
}){}dnl
dnl
dnl
dnl # ( d c b a -- d c b c a )
dnl #   ( c b a -- c b c a )
dnl # 2over nip swap == 2 pick swap
define({_2OVER_NIP_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_SWAP},{2over nip swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:40]     __INFO   ( c b a -- c b c a )
    pop  BC             ; 1:10      __INFO       . b a   BC = c
    push BC             ; 1:11      __INFO   c   . b a
    push DE             ; 1:11      __INFO   c b . b a
    ld    E, C          ; 1:4       __INFO   c b . - a
    ld    D, B          ; 1:4       __INFO   c b . c a{}dnl
}){}dnl
dnl
dnl
dnl # ( f e d c b a -- f e d c b a f e d )
dnl # Copy cell pair "f e d" to the top of the stack.
define({_3OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_3OVER},{3over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3OVER},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[19:130]    __INFO   ( f e d c b a -- f e d c b a f e d )
    push DE             ; 1:11      __INFO   f e d c b . . b a
    push HL             ; 1:11      __INFO   f e d c b a . b a
    ld   HL, 0x000B     ; 3:10      __INFO   f e d c b a . b 11
    add  HL, SP         ; 1:11      __INFO   f e d c b a . b -
    ld    D,(HL)        ; 1:7       __INFO   f e d c b a . - -
    dec  HL             ; 1:6       __INFO   f e d c b a . - -
    ld    E,(HL)        ; 1:7       __INFO   f e d c b a . f -
    dec  HL             ; 1:6       __INFO   f e d c b a . f -
    push DE             ; 1:11      __INFO   f e d c b a f f -
    ld    D,(HL)        ; 1:7       __INFO   f e d c b a f - -
    dec  HL             ; 1:6       __INFO   f e d c b a f - -
    ld    E,(HL)        ; 1:7       __INFO   f e d c b a f e -
    dec  HL             ; 1:6       __INFO   f e d c b a f e -
    ld    A,(HL)        ; 1:7       __INFO   f e d c b a f e -
    dec  HL             ; 1:6       __INFO   f e d c b a f e -
    ld    L,(HL)        ; 1:7       __INFO   f e d c b a f e -
    ld    H, A          ; 1:4       __INFO   f e d c b a f e d}){}dnl
dnl
dnl
dnl # ( h g f e d c b a -- h g f e d c b a h g f e )
dnl # ( d4 d3 d2 d1 -- d4 d3 d2 d1 d4 d3 )
dnl # Copy cell pair "d4 d3" to the top of the stack.
define({_4OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_4OVER},{4over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4OVER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(_TYP_SINGLE,{small},{
                       ;[19:212]    __INFO   ( d4 d3 d2 d1 -- d4 d3 d2 d1 d4 d3 )   # small version can be changed with "define({_TYP_SINGLE},{default})"
    ex   DE, HL         ; 1:4       __INFO   h g f e d c . . . . a b
    push HL             ; 1:11      __INFO   h g f e d c b . . . a b
    ld   HL, 0x000D     ; 3:10      __INFO   h g f e d c b . . . a 13
    add  HL, SP         ; 1:11      __INFO   h g f e d c b . . . a -
    ld    B, 0x03       ; 2:7       __INFO   h g f e d c b . . . a -
    push DE             ; 1:11      __INFO   h g f e d c b(a-h-g)f -
    ld    D,(HL)        ; 1:7       __INFO   h g f e d c b(a-h-g)f -
    dec  HL             ; 1:6       __INFO   h g f e d c b(a-h-g)f -
    ld    E,(HL)        ; 1:7       __INFO   h g f e d c b(a-h-g)f -
    dec  HL             ; 1:6       __INFO   h g f e d c b(a-h-g)f -
    djnz $-5            ; 2:8/13    __INFO   h g f e d c b(a-h-g)f -
    ld    A,(HL)        ; 1:7       __INFO   h g f e d c b a h g f -
    dec  HL             ; 1:6       __INFO   h g f e d c b a h g f -
    ld    L,(HL)        ; 1:7       __INFO   h g f e d c b a h g f -
    ld    H, A          ; 1:4       __INFO   h g f e d c b a h g f e},
{
                       ;[24:167]    __INFO   ( d4 d3 d2 d1 -- d4 d3 d2 d1 d4 d3 )   # default version can be changed with "define({_TYP_SINGLE},{small})"
    push DE             ; 1:11      __INFO   h g f e d c b . . . b a
    push HL             ; 1:11      __INFO   h g f e d c b a . . b a
    ld   HL, 0x000F     ; 3:10      __INFO   h g f e d c b a . . b 15
    add  HL, SP         ; 1:11      __INFO   h g f e d c b a . . b -
    ld    D,(HL)        ; 1:7       __INFO   h g f e d c b a . . - -
    dec  HL             ; 1:6       __INFO   h g f e d c b a . . - -
    ld    E,(HL)        ; 1:7       __INFO   h g f e d c b a . . h -
    dec  HL             ; 1:6       __INFO   h g f e d c b a . . h -
    push DE             ; 1:11      __INFO   h g f e d c b a h . h -
    ld    D,(HL)        ; 1:7       __INFO   h g f e d c b a h . - -
    dec  HL             ; 1:6       __INFO   h g f e d c b a h . - -
    ld    E,(HL)        ; 1:7       __INFO   h g f e d c b a h . g -
    dec  HL             ; 1:6       __INFO   h g f e d c b a h . g -
    push DE             ; 1:11      __INFO   h g f e d c b a h g g -
    ld    D,(HL)        ; 1:7       __INFO   h g f e d c b a h g - -
    dec  HL             ; 1:6       __INFO   h g f e d c b a h g - -
    ld    E,(HL)        ; 1:7       __INFO   h g f e d c b a h g f -
    dec  HL             ; 1:6       __INFO   h g f e d c b a h g f -
    ld    A,(HL)        ; 1:7       __INFO   h g f e d c b a h g f -
    dec  HL             ; 1:6       __INFO   h g f e d c b a h g f -
    ld    L,(HL)        ; 1:7       __INFO   h g f e d c b a h g f -
    ld    H, A          ; 1:4       __INFO   h g f e d c b a h g f e})}){}dnl
dnl
dnl
dnl # ( c b a -- b a c )
dnl # vyjme treti polozku a ulozi ji na vrchol, rotace doleva
define({ROT},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT},{rot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex   DE, HL         ; 1:4       __INFO   ( c b a -- b a c )
    ex  (SP),HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl # rot drop
dnl # ( c b a -- b a )
dnl # Remove third item from stack
define({ROT_DROP},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_DROP},{rot drop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_DROP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  AF             ; 1:10      __INFO   ( c b a -- b a )}){}dnl
dnl
dnl
dnl # ( f e d c b a -- d c b a f e )
dnl # vyjme treti 32-bit polozku a ulozi ji na vrchol
define({_2ROT},{dnl
__{}__ADD_TOKEN({__TOKEN_2ROT},{2rot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2ROT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(TYP_2ROT,{fast},{
                       ;[17:120]    __INFO   ( f e d c b a -- d c b a f e ) # fast version can be changed with "define({TYP_2ROT},{default})"
    pop  BC             ; 1:10      __INFO   f e d   . b a  BC = c
    exx                 ; 1:4       __INFO   f e d   . - R
    pop  BC             ; 1:10      __INFO   f e     . - R  BC'= d
    ld    A, H          ; 1:4       __INFO
    ex   AF, AF'        ; 1:4       __INFO
    ld    A, L          ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO   f       . - e
    pop  DE             ; 1:10      __INFO           . f e
    push BC             ; 1:11      __INFO   d       . f e
    exx                 ; 1:4       __INFO   d       . b a
    push BC             ; 1:11      __INFO   d c     . b a
    push DE             ; 1:11      __INFO   d c b   . b a
    push HL             ; 1:11      __INFO   d c b a . b a
    ld    L, A          ; 1:4       __INFO
    ex   AF, AF'        ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO   d c b a . b R
    exx                 ; 1:4       __INFO   d c b a . f e},
{
                       ;[15:127]    __INFO   ( f e d c b a -- d c b a f e ) # default version can be changed with "define({TYP_2ROT},{fast})"
    exx                 ; 1:4       __INFO   f e d c .
    pop  DE             ; 1:10      __INFO   f e d   .      DE' = c
    pop  BC             ; 1:10      __INFO   f e     .      BC' = d
    exx                 ; 1:4       __INFO   f e     . b a
    ex  (SP),HL         ; 1:19      __INFO   f a     . b e
    pop  AF             ; 1:10      __INFO   f       . b e  AF = a
    pop  BC             ; 1:10      __INFO           . b e  BC = f
    exx                 ; 1:4       __INFO
    push BC             ; 1:11      __INFO   d       .
    push DE             ; 1:11      __INFO   d c     .
    exx                 ; 1:4       __INFO   d c     . b e
    push DE             ; 1:11      __INFO   d c b   . b e
    ld    D, B          ; 1:4       __INFO
    ld    E, C          ; 1:4       __INFO   d c b   . f e
    push AF             ; 1:11      __INFO   d c b a . f e})}){}dnl
dnl
dnl
dnl # -rot
dnl # ( c b a -- a c b )
dnl # vyjme vrchol zasobniku a ulozi ho jako treti polozku, rotace doprava
define({NROT},{dnl
__{}__ADD_TOKEN({__TOKEN_NROT},{nrot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NROT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[2:23]     __INFO   ( c b a -- a c b )
    ex  (SP),HL         ; 1:19      __INFO   a . b c
    ex   DE, HL         ; 1:4       __INFO   a . c b}){}dnl
dnl
dnl
dnl # -rot swap
dnl # ( c b a -- a b c )
dnl # prohodi hodnotu na vrcholu zasobniku s treti polozkou
define({NROT_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NROT_SWAP},{nrot swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NROT_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex  (SP),HL         ; 1:19      __INFO   ( c b a -- a b c )}){}dnl
dnl
dnl
dnl # -rot nip
dnl # ( c b a -- a b )
dnl # Remove third item from stack and swap
define({NROT_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_NROT_NIP},{nrot nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NROT_NIP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  AF             ; 1:10      __INFO   ( c b a -- a b )
    ex   DE, HL         ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # -rot 2swap
dnl # ( d c b a -- c b d a )
dnl # 4th --> 2th
define({NROT_2SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NROT_2SWAP},{nrot 2swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NROT_2SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:50]     __INFO   ( d c b a -- c b d a )
    pop  AF             ; 1:10      __INFO   d   . b a    AF = c
    ld    B, D          ; 1:4       __INFO
    ld    C, E          ; 1:4       __INFO                BC = b
    pop  DE             ; 1:10      __INFO       . d a
    push AF             ; 1:11      __INFO   c   . d a
    push BC             ; 1:11      __INFO   c b . d a}){}dnl
dnl
dnl
dnl # nrot swap 2swap swap
dnl # ( d c b a -- b c a d )
define({STACK_BCAD},{dnl
__{}__ADD_TOKEN({__TOKEN_STACK_BCAD},{stack_bcad},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STACK_BCAD},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[4:44]     __INFO   ( d c b a -- b c a d )
    ex   DE, HL         ; 1:4       __INFO   d c a b
    pop  AF             ; 1:10      __INFO   AF = c
    ex  (SP), HL        ; 1:19      __INFO   b a d
    push AF             ; 1:11      __INFO   b c a d }){}dnl
dnl
dnl
dnl # 2 pick 2 pick swap
dnl # over 3 pick
dnl # 2over nip 2over nip swap
dnl # over 2over drop
dnl #      ( c b a -- c b a b c )
dnl # -- c b a b c )
define({STACK_CBABC},{dnl
__{}__ADD_TOKEN({__TOKEN_STACK_CBABC},{stack_cbabc},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STACK_CBABC},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:51]     __INFO   ( c b a -- c b a b c )
    pop  BC             ; 1:10      __INFO   BC = c
    push BC             ; 1:11      __INFO
    push DE             ; 1:11      __INFO   c b b a
    push HL             ; 1:11      __INFO   c b a b a
    ld    H, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO   c b a b c}){}dnl
dnl
dnl
dnl # 3dup rot
dnl #        ( c b a -- c b a b a c )
dnl # -- c b a b a c )
define({STACK_CBABAC},{dnl
__{}__ADD_TOKEN({__TOKEN_STACK_CBABAC},{stack_cbabac},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STACK_CBABAC},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:66]     __INFO   ( c b a -- c b a b a c )
    pop  BC             ; 1:10      __INFO   BC = c
    push BC             ; 1:11      __INFO   c . . . b a
    push DE             ; 1:11      __INFO   c b . . b a
    push HL             ; 1:11      __INFO   c b a . b a
    push DE             ; 1:11      __INFO   c b a b b a
    ex   DE, HL         ; 1:4       __INFO   c b a b a b
    ld    H, B          ; 1:4       __INFO   c b a b a -
    ld    L, C          ; 1:4       __INFO   c b a b a c}){}dnl
dnl
dnl
define({_3DUP_ROT},{dnl
__{}__ADD_TOKEN({__TOKEN_3DUP_ROT},{3dup_rot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3DUP_ROT},{dnl
__{}define({__INFO},{3dup_rot}){}dnl
STACK_CBABAC}){}dnl
dnl
dnl
dnl # 3dup -rot
dnl #        ( c b a -- c b a a c b )
dnl # -- c b a a c b )
define({STACK_CBAACB},{dnl
__{}__ADD_TOKEN({__TOKEN_STACK_CBAACB},{stack_cbaacb},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STACK_CBAACB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
                        ;[8:66]     __INFO   ( c b a -- c b a a c b )
    pop  BC             ; 1:10      __INFO   BC = c
    push BC             ; 1:11      __INFO   c . . . b a
    push DE             ; 1:11      __INFO   c b . . b a
    push HL             ; 1:11      __INFO   c b a . b a
    push HL             ; 1:11      __INFO   c b a a b a
    ex   DE, HL         ; 1:4       __INFO   c b a a a b
    ld    D, B          ; 1:4       __INFO   c b a a - b
    ld    E, C          ; 1:4       __INFO   c b a a c b}){}dnl
dnl
dnl
define({_3DUP_NROT},{dnl
__{}__ADD_TOKEN({__TOKEN_3DUP_NROT},{3dup_nrot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3DUP_NROT},{dnl
__{}define({__INFO},{3dup_nrot}){}dnl
STACK_CBAACB}){}dnl
dnl
dnl
dnl # ( f e d c b a -- b a f e d c )
define({N2ROT},{dnl
__{}__ADD_TOKEN({__TOKEN_N2ROT},{n2rot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_N2ROT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[14:123]   __INFO   ( f e d c b a -- b a f e d c )
    pop  BC             ; 1:10      __INFO   f e d     . b a   BC = c
    pop  AF             ; 1:10      __INFO   f e       . b a   AF = d
    ex   AF, AF'        ; 1:4       __INFO   f e       . b a
    pop  AF             ; 1:10      __INFO   f         . b a   AF'= e
    ex   DE, HL         ; 1:4       __INFO   f         . a b
    ex  (SP),HL         ; 1:19      __INFO   b         . a f
    push DE             ; 1:11      __INFO   b a       . a f
    push HL             ; 1:11      __INFO   b a f     . a f
    push AF             ; 1:11      __INFO   b a f e   . a f
    ex   AF, AF'        ; 1:4       __INFO   b a f e   . a f
    push AF             ; 1:11      __INFO   b a f e d . a f
    pop  DE             ; 1:10      __INFO   b a f e   . d f
    ld    H, B          ; 1:4       __INFO   b a f e   . d -
    ld    L, C          ; 1:4       __INFO   b a f e   . d c}){}dnl
dnl
dnl
dnl
dnl # dup 50
dnl # ( a -- a a 50 )
dnl # zmeni hodnotu top
define({DUP_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH},{dup $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH},{dnl
define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, format({%-11s},$1); 3:16      __INFO},
{
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup 50 100
dnl # ( a -- a a 50 100 )
define({DUP_PUSH2},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH2},{dup $1 $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH2},{dnl
__{}define({__INFO},{dup $1 $2}){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=2),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}    push DE             ; 1:11      __INFO   ( x -- x x $1 $2 )
__{}    push HL             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}dnl
__{}define({_TMP_INFO},{__INFO}){}dnl # HL first check
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}define({PUSH2_HL},__CLOCKS_16BIT){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}define({PUSH2_HL},eval(PUSH2_HL+__CLOCKS_16BIT)){}dnl
__{}dnl
__{}__LD_REG16({HL},$2,{DE},$1){}dnl # DE first check
__{}define({PUSH2_DE},__CLOCKS_16BIT){}dnl
__{}__LD_REG16({DE},$1){}dnl
__{}define({PUSH2_DE},eval(PUSH2_DE+__CLOCKS_16BIT)){}dnl
__{}dnl
__{}ifelse(eval(PUSH2_DE<=PUSH2_HL),{1},{dnl # DE first
__{}__{}__CODE_16BIT{}__LD_REG16({HL},$2,{DE},$1){}__CODE_16BIT},
__{}{dnl # HL first
__{}__{}__LD_REG16({HL},$2){}__CODE_16BIT{}__LD_REG16({DE},$1,{HL},$2){}__CODE_16BIT}){}dnl
})}){}dnl
dnl
dnl
dnl # ( -- d )
dnl # PUSHDOT(number32bit) ulozi na zasobnik 32 bitove cislo
dnl # 255. --> ( -- 0x0000 0x00FF )
define({PUSHDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT},{$1.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      __INFO   ( -- hi lo )
__{}    push HL             ; 1:11      __INFO
__{}    ld   DE,format({%-12s},($1+2)); 4:20      __INFO   hi word
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO   lo word},
__IS_NUM($1):__LINKER,{0:sjasmplus},{
__{}    push DE             ; 1:11      __INFO   ( -- hi lo )
__{}    push HL             ; 1:11      __INFO
__{}    ld   DE,format({%-12s},{($1)>>16}); 3:10      __INFO   hi word
__{}    ld   HL,format({%-12s},{($1)&65535}); 3:10      __INFO   lo word},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
{
__{}define({__DE},__HEX_DE($1)){}dnl
__{}define({__HL},__HEX_HL($1)){}dnl
__{}    push DE             ; 1:11      __INFO   ( -- hi lo )
__{}    push HL             ; 1:11      __INFO{}dnl
__{}define({_TMP_INFO},__INFO){}dnl # HL first check
__{}__LD_REG16({DE},__DE,{HL},__HL){}dnl
__{}define({PUSH2_HL},__CLOCKS_16BIT){}dnl
__{}__LD_REG16({HL},__HL){}dnl
__{}define({PUSH2_HL},eval(PUSH2_HL+__CLOCKS_16BIT)){}dnl
__{}dnl
__{}__LD_REG16({HL},__HL,{DE},__DE){}dnl # DE first check
__{}define({PUSH2_DE},__CLOCKS_16BIT){}dnl
__{}__LD_REG16({DE},__DE){}dnl
__{}define({PUSH2_DE},eval(PUSH2_DE+__CLOCKS_16BIT)){}dnl
__{}dnl
__{}ifelse(eval(PUSH2_DE<=PUSH2_HL),{1},{dnl # DE first
__{}__{}__CODE_16BIT{}__LD_REG16({HL},__HL,{DE},__DE){}__CODE_16BIT},
__{}{dnl # HL first
__{}__{}__LD_REG16({HL},__HL){}__CODE_16BIT{}__LD_REG16({DE},__DE,{HL},__HL){}__CODE_16BIT}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( d_old -- d_new d_old )
dnl # PUSHDOT_2SWAP(number32bit) ulozi za nejvyssi 32 bitove cislo na zasobnik 32 bitove cislo
dnl # 255. --> ( 0x1122 0x3344 -- 0x0000 0x00FF 0x1122 0x3344 )
define({PUSHDOT_2SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_2SWAP},{$1. 2swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_2SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__IS_MEM_REF($1),{1},{
__{}    ld   BC,format({%-12s},($1+2)); 4:20      __INFO   hi word
__{}    push BC             ; 1:11      __INFO{}dnl
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   lo word
__{}    push BC             ; 1:11      __INFO},
{dnl
__{}define({__DE},__HEX_DE($1)){}dnl
__{}define({__HL},__HEX_HL($1)){}dnl
__{}define({_TMP_INFO},{__INFO   hi word}){}dnl
__{}__LD_REG16({BC},__DE){}dnl
__{}__CODE_16BIT
__{}    push BC             ; 1:11      __INFO{}dnl
__{}define({_TMP_INFO},{__INFO   lo word}){}dnl
__{}__LD_REG16({BC},__HL,{BC},__DE){}dnl
__{}__CODE_16BIT
__{}    push BC             ; 1:11      __INFO{}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( d_old -- d_new d_old )
dnl # PUSH2_2SWAP(number32bit) ulozi za nejvyssi 32 bitove cislo na zasobnik 32 bitove cislo
dnl # 255. --> ( 0x1122 0x3344 -- 0x0000 0x00FF 0x1122 0x3344 )
define({PUSH2_2SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_2SWAP},{$1 $2 2swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_2SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(dnl
eval($#<2),1,{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({__DE},{ifelse(__IS_NUM($1),1,{__HEX_HL($1)},{$1})}){}dnl
__{}define({__HL},{ifelse(__IS_NUM($2),1,{__HEX_HL($2)},{$2})}){}dnl
__{}define({_TMP_INFO},{__INFO   hi word}){}dnl
__{}__LD_REG16({BC},__DE){}dnl
__{}__CODE_16BIT
__{}    push BC             ; 1:11      __INFO{}dnl
__{}define({_TMP_INFO},{__INFO   lo word}){}dnl
__{}__LD_REG16({BC},__HL,{BC},__DE){}dnl
__{}__CODE_16BIT
__{}    push BC             ; 1:11      __INFO{}dnl
})}){}dnl
dnl
dnl
dnl # 2 pick ( c b a -- c b a c )
define({_2_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_2_PICK},{2 pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                       ;[ 6:44]     __INFO   ( c b a -- c b a c )
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld    H, B          ; 1:4       __INFO
__{}__{}    ld    L, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # 2 pick num ( c b a -- c b a c num )
define({_2_PICK_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_2_PICK_PUSH},{2 pick $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2_PICK_PUSH},{dnl
ifelse(dnl
eval($#<1),1,{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}    pop  BC             ; 1:10      __INFO   ( c b a -- c b a c $1 )
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    D, B          ; 1:4       __INFO
__{}__{}    ld    E, C          ; 1:4       __INFO{}__ASM_TOKEN_DROP_PUSH($1)}){}dnl
}){}dnl
dnl
dnl
dnl # over 3 pick ( c b a -- c b a b c )
define({OVER_3_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_3_PICK},{over 3 pick},$@){}dnl
}){}dnl
define({__ASM_TOKEN_OVER_3_PICK},{dnl
ifelse(dnl
eval($#>0),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}    pop  BC             ; 1:10      __INFO   ( c b a -- c b a b c )
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    H, B          ; 1:4       __INFO
__{}__{}    ld    L, C          ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # over 4 pick ( d c b a -- d c b a b d )
define({OVER_4_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_4_PICK},{over 4 pick},$@){}dnl
}){}dnl
define({__ASM_TOKEN_OVER_4_PICK},{dnl
ifelse(dnl
eval($#>0),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}    pop  AF             ; 1:10      __INFO   ( d c b a -- d c b a b d )
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push AF             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    H, B          ; 1:4       __INFO
__{}__{}    ld    L, C          ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # 2 pick num swap ( c b a -- c b a num c )
dnl # num 3 pick ( c b a -- c b a num c )
define({_2_PICK_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_3_PICK},{2 pick $1 swap},$@){}dnl
}){}dnl
dnl
define({PUSH_3_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_3_PICK},{$1 3 pick},$@){}dnl
}){}dnl
define({__ASM_TOKEN_PUSH_3_PICK},{dnl
ifelse(dnl
eval($#<1),1,{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}    pop  BC             ; 1:10      __INFO   ( c b a -- c b a $1 c )
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO{}__LD_REG16({DE},$1){}__CODE_16BIT
__{}__{}    ld    H, B          ; 1:4       __INFO
__{}__{}    ld    L, C          ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # 2 pick ( c b a -- c b a c b )
define({_2_PICK_2_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_2_PICK_2_PICK},{2 pick 2 pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2_PICK_2_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                       ;[ 7:55]     __INFO   ( c b a -- c b a c b )
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO   BC = c
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld    D, B          ; 1:4       __INFO
__{}__{}    ld    E, C          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # 3 pick ( d c b a -- d c b a d )
define({_3_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_3_PICK},{3 pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(1,1,{
__{}__{}                        ;[8:65]     __INFO   ( d c b a -- d c b a d )
__{}__{}    pop  AF             ; 1:10      __INFO
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push AF             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld    H, B          ; 1:4       __INFO
__{}__{}    ld    L, C          ; 1:4       __INFO},
__{}{
__{}__{}                        ;[8:65]     __INFO   ( d c b a -- d c b a d )
__{}__{}    ex   DE, HL         ; 1:4       __INFO   d c a b
__{}__{}    ld    B, H          ; 1:4       __INFO
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    pop  AF             ; 1:10      __INFO   = c
__{}__{}    pop  HL             ; 1:10      __INFO   = d
__{}__{}    push HL             ; 1:11      __INFO   
__{}__{}    push AF             ; 1:11      __INFO
__{}__{}    push BC             ; 1:11      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # 3 pick num ( d c b a -- d c b a d num )
define({_3_PICK_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_3_PICK_PUSH},{3 pick $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3_PICK_PUSH},{dnl
ifelse(dnl
eval($#<1),1,{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                       ;[ 8:65]     __INFO   ( d c b a -- d c b a d $1 )
__{}__{}    pop  AF             ; 1:10      __INFO
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push AF             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    D, B          ; 1:4       __INFO
__{}__{}    ld    E, C          ; 1:4       __INFO{}__ASM_TOKEN_DROP_PUSH($1)}){}dnl
}){}dnl
dnl
dnl
dnl # 2over 3 pick ( d c b a -- d c b a d c b )
define({_2OVER_3_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_3_PICK},{2over 3 pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_3_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}                       ;[ 8:65]     __INFO   ( d c b a -- d c b a d c b )
__{}    pop  AF             ; 1:10      __INFO   d         . b a     AF = c
__{}    pop  BC             ; 1:10      __INFO             . b a     BC = d
__{}    push BC             ; 1:11      __INFO   d         . b a
__{}    push AF             ; 1:11      __INFO   d c       . b a
__{}    push DE             ; 1:11      __INFO   d c b     . b a
__{}    push AF             ; 1:11      __INFO   d c b c   . b a
__{}    ex  (SP),HL         ; 1:19      __INFO   d c b a   . b c
__{}    push BC             ; 1:11      __INFO   d c b a d . b c
__{}    ex   DE, HL         ; 1:4       __INFO   d c b a d . c b}){}dnl
dnl
dnl
dnl # ( ...n3 n2 n1 n0 x -- ...n3 n2 n1 n0 nx )
dnl # Remove x. Copy the nx to the top of the stack.
define({PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_PICK},{pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#>0),1,{
__{}  .error {$0}($@): Unexpected parameter!},
{
__{}                       ;[ 8:67]     __INFO   ( ...n1 n0 u -- ...n1 n0 nu )
__{}    push DE             ; 1:11      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # 0 pick ( a 0 -- a a )
dnl # 1 pick ( b a 1 -- b a b )
dnl # 2 pick ( c b a 2 -- c b a c )
dnl # 3 pick ( d c b a 3 -- d c b a d )
dnl # 4 pick ( e d c b a 4 -- e d c b a e )
dnl # u pick ( ...x3 x2 x1 x0 u -- ...x3 x2 x1 x0 xu )
dnl # Remove u. Copy the xu to the top of the stack.
define({PUSH_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_PICK},{$1 pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($#,{0},{
__{}  .error push_pick(): Parameter is missing!},
__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_NUM($1),{0},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO},
{dnl
__{}ifelse(dnl
__{}eval($1),{0},{__ASM_TOKEN_DUP},
__{}eval($1),{1},{__ASM_TOKEN_OVER},
__{}eval($1),{2},{__ASM_TOKEN_2_PICK},
__{}eval($1),{3},{__ASM_TOKEN_3_PICK},
__{}{
__{}__{}                       ;[10:60]     __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    A,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    H,(HL)        ; 1:7       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO ( ...x2 x1 x0 -- ...x2 x1 x0 x$1 )})})}){}dnl
dnl
dnl
dnl
dnl # drop 2 pick ( d c b a -- d c b d )
define({DROP_2_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_2_PICK},{drop 2 pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_2_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[4:42]     __INFO
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    push BC             ; 1:11      __INFO   ( d c b a -- d c b d )}){}dnl
dnl
dnl
dnl
dnl # drop 3 pick ( e d c b a -- e d c b e )
define({DROP_3_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_3_PICK},{drop 3 pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_3_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(_TYP_SINGLE,{small},{
__{}__{}                        ;[6:63]     __INFO   small version
__{}__{}    pop  AF             ; 1:10      __INFO
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push AF             ; 1:11      __INFO   ( e d c b a -- e d c b e )},
__{}{
__{}__{}                        ;[8:45]     __INFO   default version
__{}__{}    ld   HL, __HEX_HL(2*3-2)     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    A,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    H,(HL)        ; 1:7       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO  ( e d c b a -- e d c b e )})}){}dnl
dnl
dnl
dnl
dnl # drop 0 pick ( b a 0 -- b b )
dnl # drop 1 pick ( c b a 1 -- c b c )
dnl # drop 2 pick ( d c b a 2 -- d c b d )
dnl # drop 3 pick ( e d c b a 3 -- e d c b e )
dnl # drop 4 pick ( f e d c b a 4 -- f e d c b f )
dnl # drop u pick ( ...x2 x1 x0 x u -- ...x2 x1 x0 xu )
dnl # Remove tos, copy the xu to the top of the stack.
define({DROP_PUSH_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_PUSH_PICK},{drop $1 pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_PUSH_PICK},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($#,{0},{
__{}  .error push_pick(): Parameter is missing!},
__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_NUM($1),{0},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}    push DE             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO},
{dnl
__{}ifelse(dnl
__{}eval($1),{0},{__ASM_TOKEN_DROP_DUP},
__{}eval($1),{1},{__ASM_TOKEN_DROP_OVER},
__{}eval($1),{2},{__ASM_TOKEN_DROP_2_PICK},
__{}eval($1),{3},{__ASM_TOKEN_DROP_3_PICK},
__{}{
__{}__{}                        ;[8:45]     __INFO
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    A,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    H,(HL)        ; 1:7       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO ( ...x2 x1 x0 x -- ...x2 x1 x0 x$1 )})})}){}dnl
dnl
dnl
dnl
dnl # 0 pick number           ( a --           a a  number )
dnl # 1 pick number         ( b a --         b a b  number )
dnl # 2 pick number       ( c b a --       c b a c  number )
dnl # 3 pick number     ( d c b a --     d c b a d  number )
dnl # 4 pick number   ( e d c b a --   e d c b a e  number )
dnl # u pick number ( xu .. x1 x0 -- xu .. x1 x0 xu number )
define({PUSH_PICK_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_PICK_PUSH},{$1 pick $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_PICK_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}                       ;ifelse(__IS_MEM_REF($2),1,[13:96],[13:90])     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 x$1 $2 )
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})},
__IS_NUM($1),{0},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}                       ;ifelse(__IS_MEM_REF($2),1,[12:79],[12:73])     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 x$1 $2 )
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})},
{dnl
__{}ifelse(dnl
__{}eval($1),{0},{__ASM_TOKEN_DUP_PUSH($2)},
__{}eval($1),{1},{__ASM_TOKEN_OVER_PUSH($2)},
__{}eval($1),{2},{
__{}__{}                        ;ifelse(__IS_MEM_REF($2),1,[9:67],[9:61])     __INFO   ( x2 x1 x0 -- x2 x1 x0 x2 $2 )
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    E, C          ; 1:4       __INFO
__{}__{}    ld    D, B          ; 1:4       __INFO
__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}__{}{dnl
__{}__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})},
__{}eval($1):__TYP_SINGLE,{3:small},{
__{}__{}                       ;ifelse(__IS_MEM_REF($2),1,[11:88],[11:82])     __INFO   ( x3 x2 x1 x0 -- x3 x2 x1 x0 x3 $2 )
__{}__{}    pop  AF             ; 1:10      __INFO
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push AF             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    E, C          ; 1:4       __INFO
__{}__{}    ld    D, B          ; 1:4       __INFO
__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}__{}{dnl
__{}__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})},
__{}{
__{}__{}                       ;ifelse(__IS_MEM_REF($2),1,[12:79],[12:73])     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 x$1 $2 )
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL, __HEX_HL(2*($1))     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    D,(HL)        ; 1:7       __INFO
__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}__{}{dnl
__{}__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 0 pick number swap           ( a --           a number a )
dnl # 1 pick number swap         ( b a --         b a number b )
dnl # 2 pick number swap       ( c b a --       c b a number c )
dnl # 3 pick number swap     ( d c b a --     d c b a number d )
dnl # 4 pick number swap   ( e d c b a --   e d c b a number e )
dnl # u pick number swap ( xu .. x1 x0 -- xu .. x1 x0 number xu )
define({PUSH_PICK_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_PICK_PUSH_SWAP},{$1 pick $2 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_PICK_PUSH_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($#,{0},{
__{}  .error push_pick(): Parameter is missing!},
__IS_MEM_REF($1),{1},{
__{}                       ;ifelse(__IS_MEM_REF($2),1,[14:100],[14:94] )    __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 $2 x$1 )
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})
__{}    ex   DE, HL         ; 1:4       __INFO},
__IS_NUM($1),{0},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}                       ;ifelse(__IS_MEM_REF($2),1,[13:83],[13:77])     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 $2 x$1 )
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})
__{}    ex   DE, HL         ; 1:4       __INFO},
{dnl
__{}ifelse(dnl
__{}eval($1),{0},{__ASM_TOKEN_PUSH_OVER($2)},
__{}eval($1),{1},{__ASM_TOKEN_OVER_PUSH_SWAP($2)},
__{}eval($1),{2},{
__{}__{}                       ;ifelse(__IS_MEM_REF($2),1,[10:71],[ 9:61])     __INFO   ( x2 x1 x0 -- x2 x1 x0 $2 x2 )
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    L, C          ; 1:4       __INFO
__{}__{}    ld    H, B          ; 1:4       __INFO
__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}    ld   DE, format({%-11s},$2); 4:20      __INFO},
__{}__{}{dnl
__{}__{}__{}    ld   DE, __FORM({%-11s},$2); 3:10      __INFO})},
__{}eval($1),{3},{
__{}__{}                       ;ifelse(__IS_MEM_REF($2),1,[12:92],[11:82])     __INFO   ( x3 x2 x1 x0 -- x3 x2 x1 x0 $2 x3 )
__{}__{}    pop  AF             ; 1:10      __INFO
__{}__{}    pop  BC             ; 1:10      __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push AF             ; 1:11      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    L, C          ; 1:4       __INFO
__{}__{}    ld    H, B          ; 1:4       __INFO
__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}    ld   DE, format({%-11s},$2); 4:20      __INFO},
__{}__{}{dnl
__{}__{}__{}    ld   DE, __FORM({%-11s},$2); 3:10      __INFO})},
__{}{
__{}__{}                       ;ifelse(__IS_MEM_REF($2),1,[13:83],[13:77])     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 $2 x$1 )
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL, __HEX_HL(2*($1))     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    D,(HL)        ; 1:7       __INFO
__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}__{}{dnl
__{}__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})
__{}__{}    ex   DE, HL         ; 1:4       __INFO})})}){}dnl
dnl
dnl
dnl
dnl # u pick x swap !
dnl # ( -- ) (R: xu .. x1 x0 -- xu .. x1 x0 )
dnl # Store x to address xu
define({PUSH_PICK_PUSH_SWAP_STORE},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_PICK_PUSH_SWAP_STORE},{$1 pick $2 swap !},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_PICK_PUSH_SWAP_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($#,{0},{
__{}  .error push_pick(): Parameter is missing!},
__IS_MEM_REF($1):__IS_MEM_REF($2),{1:1},{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ld   HL, format({%-11s},$2); 3:16      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld  (HL),E          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),D          ; 1:7       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld  (HL),low __FORM({%-7s},$2); 2:10      __INFO   lo
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),high __FORM({%-6s},$2); 2:10      __INFO   hi
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_NUM($1):__IS_MEM_REF($2),{0:1},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ld   HL, format({%-11s},$2); 3:16      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld  (HL),E          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),D          ; 1:7       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_NUM($1),{0},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld  (HL),low __FORM({%-7s},$2); 2:10      __INFO   lo
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),high __FORM({%-6s},$2); 2:10      __INFO   hi
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
{dnl
__{}ifelse(dnl
__{}eval($1),{0},{__ASM_TOKEN_PUSH_OVER_STORE($2)},
__{}eval($1),{1},{__ASM_TOKEN_OVER_PUSH_SWAP_STORE($2)},
__{}eval($1),{2},{__ASM_TOKEN_PUSH_3_PICK_STORE($2)},
__{}eval($1),{3},{__ASM_TOKEN_PUSH_4_PICK_STORE($2)},
__{}{
__{}__{}                       ;[15:92]     __INFO   ( -- ) ( R: x$1 .. x1 x0 -- x$1 .. x1 x0 )
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    A,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    H,(HL)        ; 1:7       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld  (HL),low __FORM({%-7s},$2); 2:10      __INFO   lo
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),high __FORM({%-6s},$2); 2:10      __INFO   hi
__{}__{}    pop  HL             ; 1:10      __INFO})})}){}dnl
dnl
dnl
dnl
dnl # u pick char swap !
dnl # ( -- ) (R: xu .. x1 x0 -- xu .. x1 x0 )
dnl # Store x to address xu
define({PUSH_PICK_PUSH_SWAP_CSTORE},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_PICK_PUSH_SWAP_CSTORE},{$1 pick $2 swap c!},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_PICK_PUSH_SWAP_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($#,{0},{
__{}  .error push_pick(): Parameter is missing!},
__IS_MEM_REF($1):__IS_MEM_REF($2),{1:1},{
__{}                        ;[16:120]   __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 )  $2-->(x$1)
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}    ld  (DE),A          ; 1:7       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_MEM_REF($1):__IS_NUM($2),{1:0},{
__{}                        ;[15:114]   __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 )  $2-->(x$1)
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ld    A, __FORM({%-11s},$2); 2:7       __INFO
__{}    ld  (DE),A          ; 1:7       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_MEM_REF($1),{1},{define({__CODE},__LD_R_NUM(__INFO{   lo},{A},__HEX_L($2))){}dnl
__{}define({__B},eval(13+__BYTES)){}dnl
__{}define({__C},eval(107+__CLOCKS))
                        ;[__B:__C]   __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 )  $2-->(x$1)
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO{}dnl
__{}__CODE
__{}    ld  (DE),A          ; 1:7       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_NUM($1):__IS_MEM_REF($2),{0:1},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}                       ;[15:103]    __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 )  $2-->(x$1)
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}    ld  (DE),A          ; 1:7       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
__IS_NUM($1),{0},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}                       ;[14:97]     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 )  $2-->(x$1)
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
__{}    add  HL, SP         ; 1:11      __INFO
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld  (HL),low __FORM({%-7s},$2); 2:10      __INFO   lo
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
{dnl
__{}ifelse(dnl
__{}eval($1),{0},{__ASM_TOKEN_PUSH_OVER_CSTORE($2)},
__{}eval($1),{1},{__ASM_TOKEN_OVER_PUSH_SWAP_CSTORE($2)},
__{}eval($1),{2},{__ASM_TOKEN_PUSH_3_PICK_CSTORE($2)},
__{}eval($1),{3},{__ASM_TOKEN_PUSH_4_PICK_CSTORE($2)},
__{}__IS_MEM_REF($2),1,{
__{}__{}                       ;[13:82]     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 )  $2-->(x$1)
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    C,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    B,(HL)        ; 1:7       __INFO
__{}__{}    ld    A,format({%-12s},$2); 3:13      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}__IS_NUM($2),0,{
__{}__{}                       ;[12:76]     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 )  $2-->(x$1)
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    A,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    H,(HL)        ; 1:7       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld  (HL),low __FORM({%-7s},$2); 2:10      __INFO   lo
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}{
__{}__{}define({__CODE},__LD_R_NUM(__INFO,{A},__HEX_L($2),{H},__HEX_H(2*($1)-2),{L},__HEX_L(2*($1)-2))){}dnl
__{}__{}                       ;[eval(10+__BYTES):eval(69+__CLOCKS)]     __INFO   ( x$1 .. x1 x0 -- x$1 .. x1 x0 )  $2-->(x$1)
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      __INFO{}dnl
__{}__{}__CODE
__{}__{}    add  HL, SP         ; 1:11      __INFO
__{}__{}    ld    C,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    B,(HL)        ; 1:7       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO})})}){}dnl
dnl
dnl
dnl # 0 roll ( a -- a )
define({_0_ROLL},{dnl
}){}dnl
dnl
dnl
dnl # 1 roll ( b a -- b a )
define({_1_ROLL},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP},{1 roll},$@){}dnl
}){}dnl
dnl
dnl
dnl # 2 roll ( c b a -- b a c )
define({_2_ROLL},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT},{2 roll},$@){}dnl
}){}dnl
dnl
dnl
dnl # 3 roll ( d c b a -- c b a d )
define({_3_ROLL},{dnl
__{}__ADD_TOKEN({__TOKEN_3_ROLL},{3 roll},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3_ROLL},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[6:52]     __INFO   ( d c b a -- c b a d )
__{}__{}    ex   DE, HL         ; 1:4       __INFO   d c a b
__{}__{}    ld    B, H          ; 1:4       __INFO
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO   . d a c
__{}__{}    ex   (SP),HL        ; 1:19      __INFO   . c a d
__{}__{}    push BC             ; 1:11      __INFO   c b a d}){}dnl
dnl
dnl
dnl # 3 roll ( d c b a -- c b a a d )
define({_3_ROLL_OVER_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_3_ROLL_OVER_SWAP},{3 roll over swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3_ROLL_OVER_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[7:63]     __INFO   ( d c b a -- c b a a d )
__{}__{}    ex   DE, HL         ; 1:4       __INFO   d c a b
__{}__{}    ld    B, H          ; 1:4       __INFO
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO   . d a c
__{}__{}    ex   (SP),HL        ; 1:19      __INFO   . c a d
__{}__{}    push BC             ; 1:11      __INFO   c b a d
__{}__{}    push DE             ; 1:11      __INFO   c b a a d}){}dnl
dnl
dnl
dnl # 3 roll ( d c b a -- c b a b d )
define({_3_ROLL_2OVER_NIP_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_3_ROLL_2OVER_NIP_SWAP},{3 roll 2over nip swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3_ROLL_2OVER_NIP_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[7:61]     __INFO   ( d c b a -- c b a b d )
__{}__{}    pop  AF             ; 1:10      __INFO   = c
__{}__{}    pop  BC             ; 1:10      __INFO   = d
__{}__{}    push AF             ; 1:11      __INFO   . . c b a
__{}__{}    push DE             ; 1:11      __INFO   . c b b a
__{}__{}    push HL             ; 1:11      __INFO   c b a b a
__{}__{}    ld    H, B          ; 1:4       __INFO
__{}__{}    ld    L, C          ; 1:4       __INFO   c b a b d}){}dnl
dnl
dnl
dnl # 4 roll ( e d c b a -- d c b a e )
define({_4_ROLL},{dnl
__{}__ADD_TOKEN({__TOKEN_4_ROLL},{4 roll},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4_ROLL},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                        ;[8:73]     __INFO   ( e d c b a -- d c b a e )
__{}__{}    ex   DE, HL         ; 1:4       __INFO   e d c a b
__{}__{}    ld    B, H          ; 1:4       __INFO
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    pop  AF             ; 1:10      __INFO   . e d a b
__{}__{}    pop  HL             ; 1:10      __INFO   . . e a d
__{}__{}    ex   (SP),HL        ; 1:19      __INFO   . . d a e
__{}__{}    push AF             ; 1:11      __INFO   . d c a e
__{}__{}    push BC             ; 1:11      __INFO   d c b a e}){}dnl
dnl
dnl
dnl # 5 roll ( f e d c b a -- e d c b a f )
define({_5_ROLL},{dnl
__{}__ADD_TOKEN({__TOKEN_5_ROLL},{5 roll},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_5_ROLL},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                       ;[12:102]    __INFO   ( f e d c b a -- e d c b a f )
__{}__{}    ex   DE, HL         ; 1:4       __INFO   f e d c a b
__{}__{}    ld    B, H          ; 1:4       __INFO
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    pop  AF             ; 1:10      __INFO   . f e d a b  AF = c
__{}__{}    ex   AF, AF'        ; 1:4       __INFO
__{}__{}    pop  AF             ; 1:10      __INFO   . . f e a b  AF'= d
__{}__{}    pop  HL             ; 1:10      __INFO   . . . f a e
__{}__{}    ex   (SP),HL        ; 1:19      __INFO   . . . e a f
__{}__{}    push AF             ; 1:11      __INFO   . . e d a f
__{}__{}    ex   AF, AF'        ; 1:4       __INFO
__{}__{}    push AF             ; 1:11      __INFO   . e d c a f
__{}__{}    push BC             ; 1:11      __INFO   e d c b a f}){}dnl
dnl
dnl
dnl # 6 roll ( g f e d c b a -- f e d c b a g )
define({_6_ROLL},{dnl
__{}__ADD_TOKEN({__TOKEN_6_ROLL},{6 roll},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_6_ROLL},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__{}                       ;[16:131]    __INFO   ( g f e d c b a -- f e d c b a g )
__{}__{}    ex   DE, HL         ; 1:4       __INFO   g f e d c a b
__{}__{}    ld    B, H          ; 1:4       __INFO
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  AF             ; 1:10      __INFO   . g f e d  AF = c
__{}__{}    pop  BC             ; 1:10      __INFO   . . g f e  BC'= d
__{}__{}    pop  DE             ; 1:10      __INFO   . . . g f  DE'= e
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO   . . . . g a f
__{}__{}    ex   (SP),HL        ; 1:19      __INFO   . . . . f a g
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    push DE             ; 1:11      __INFO   . . . f e
__{}__{}    push BC             ; 1:11      __INFO   . . f e d
__{}__{}    push AF             ; 1:11      __INFO   . f e d c
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    push BC             ; 1:11      __INFO   f e d c b a g}){}dnl
dnl
dnl
dnl # $1 roll ( x$1 .. x0 -- x$-1 .. x0 x$1 )
define({PUSH_ROLL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ROLL},{$1 roll},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ROLL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,,{
__{}__{}  .error {$0}($@): Missing parameter!},

__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},

__{}__IS_MEM_REF($1),1,{__ASM_TOKEN_PUSH($1){}__ASM_TOKEN_ROLL},

__{}__IS_NUM($1),0,{__ASM_TOKEN_PUSH($1){}__ASM_TOKEN_ROLL},

__{}__HEX_HL($1),0x0000,{
__{}                        ;           __INFO   ( -- )},

__{}__HEX_HL($1),0x0001,{__ASM_TOKEN_SWAP},

__{}__HEX_HL($1),0x0002,{__ASM_TOKEN_ROT},

__{}__HEX_HL($1),0x0003,{__ASM_TOKEN_3_ROLL},

__{}__HEX_HL($1),0x0004,{__ASM_TOKEN_4_ROLL},

__{}__HEX_HL($1),0x0005,{__ASM_TOKEN_5_ROLL},

__{}__HEX_HL($1),0x0006,{__ASM_TOKEN_6_ROLL},

__{}{
__{}__{}                       ;[22:format({%-7s},eval(127+($1)*42)]) __INFO   ( x$1 x{}eval($1-1) .. x0 -- x{}eval($1-1) .. x0 x$1 )
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL, __HEX_HL($1+$1)     ; 3:10      __INFO
__{}__{}    add  HL, SP         ; 1:11      __INFO   HL = x$1 addr
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    ld    D, H          ; 1:4       __INFO   DE = x$1 addr
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    ld    C,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    B,(HL)        ; 1:7       __INFO
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    ld   BC, __HEX_HL($1+$1)     ; 3:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    lddr                ; 2:format({%-8s},eval(($1)*42-5)){}__INFO   (DE--) = (HL--)
__{}__{}    pop  HL             ; 1:10      __INFO 
__{}__{}    pop  DE             ; 1:10      __INFO 
__{}__{}    pop  AF             ; 1:10      __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # roll ( xu xu-1 .. x1 x0 -- xu-1 .. x1 x0 xu )
define({ROLL},{dnl
__{}__ADD_TOKEN({__TOKEN_ROLL},{roll},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROLL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ROLL})
__{}__{}    call _ROLL          ; 3:17      __INFO   ( xu xu-1 .. x1 x0 u -- xu-1 .. x1 x0 xu )
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # depth
dnl # ( -- 0 )
dnl # ( x -- x 1 )
dnl # ( x x -- x x 2 )
dnl # ( -- +n )
dnl # +n is the number of single-cell values contained in the data stack before +n was placed on the stack
define({DEPTH},{dnl
__{}__ADD_TOKEN({__TOKEN_DEPTH},{depth},$@){}dnl
}){}dnl
dnl
dnl # HL=0004 && c=0 --> DEPTH=+1
dnl # HL=0002 && c=0 --> DEPTH=+0
dnl # HL=0000 && c=0 --> DEPTH=-1
dnl # HL=FFFE && c=1 --> DEPTH=-2
dnl # HL=FFFC && c=1 --> DEPTH=-3
define({__ASM_TOKEN_DEPTH},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[13:72]    __INFO   ( -- +n )
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,(Stop+1)    ; 3:16      __INFO
    or    A             ; 1:4       __INFO
    sbc  HL, SP         ; 2:15      __INFO
    rr    H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO
    dec  HL             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl
dnl # ------------- return address stack ------------------
dnl
dnl # >r
dnl # ( x -- ) ( R: -- x )
dnl # Move x to the return stack.
define({TO_R},{dnl
__{}__ADD_TOKEN({__TOKEN_TO_R},{>r},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TO_R},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:65]     __INFO   ( c b a -- c b ) ( R: -- a )
    ex  (SP), HL        ; 1:19      __INFO   a . b c
    ex   DE, HL         ; 1:4       __INFO   a . c b
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # dup >r
dnl # ( x -- x ) ( R: -- x )
dnl # Copy x to the return stack.
define({DUP_TO_R},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_TO_R},{dup >r},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_TO_R},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:53]     __INFO   ( a -- a ) ( R: -- a )
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # n>r
dnl # ( xu .. x2 x1 u -- ) ( R: -- x1 x2 .. xu )
dnl # Move u cells from the data stack to the return stack.
define({N_TO_R},{dnl
__{}__ADD_TOKEN({__TOKEN_N_TO_R},{n>r}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_N_TO_R},{dnl
__{}define({__INFO},__COMPILE_INFO)
                      ;[21:82+u*47] __INFO   ( xu .. x2 x1 u -- ) ( R: -- x1 x2 .. xu u )
    push DE             ; 1:11      __INFO
    ld    A, L          ; 1:4       __INFO   u = 0..255
    exx                 ; 1:4       __INFO
    or    A             ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO
    jr    z, $+9        ; 2:12      __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    djnz $-5            ; 2:8/13    __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO   = 0
    dec   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO   = lo(u)
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # n>r rdrop
dnl # ( xu .. x2 x1 u -- ) ( R: -- x1 x2 .. xu )
dnl # Move u cells from the data stack to the return stack.
define({N_TO_R_RDROP},{dnl
__{}__ADD_TOKEN({__TOKEN_N_TO_R},{n>r rdrop}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_N_TO_R_RDROP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                      ;[17:53+u*47] __INFO   ( xu .. x2 x1 u -- ) ( R: -- x1 x2 .. xu )
    ld    A, L          ; 1:4       __INFO   u = 0..255
    push DE             ; 1:11      __INFO
    or    A             ; 1:4       __INFO
    jr    z, $+12       ; 2:7/12    __INFO
    exx                 ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    djnz $-5            ; 2:8/13    __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # n>r
dnl # ( xu .. x2 x1 u -- ) ( R: -- x1 x2 .. xu )
dnl # Move u cells from the data stack to the return stack.
define({PUSH_N_TO_R},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_N_TO_R},{$1 n>r},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_N_TO_R},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
                      ;[24:97+u*47] __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu $1 )  u = $1
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO   0..255
    exx                 ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO
    or    A             ; 1:4       __INFO
    jr    z, $+9        ; 2:7/12    __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    djnz $-5            ; 2:8/13    __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO   hi(u) = 0
    dec   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO   lo(u)
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__IS_NUM($1),{0},{
                      ;[23:91+u*47] __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu $1 )  u = $1
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld    A, low __FORM({%-7s},$1); 2:7       __INFO   0..255
    exx                 ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO
    or    A             ; 1:4       __INFO
    jr    z, $+9        ; 2:7/12    __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    djnz $-5            ; 2:8/13    __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO   hi(u) = 0
    dec   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO   lo(u)
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
{dnl
__{}ifelse(eval($1),0,{
                       ;[7:36]      __INFO   ( -- ) ( R: -- 0 )
    exx                 ; 1:4       __INFO
    xor   A             ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),A          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO
    exx                 ; 1:4       __INFO},
__{}eval($1),1,{
                       ;[15:95]     __INFO   ( x -- ) ( R: -- x 1 )
    ex  (SP), HL        ; 1:19      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),0x00       ; 2:10      __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),0x01       ; 2:10      __INFO
    exx                 ; 1:4       __INFO},
__{}eval($1),2,{
                      ;[21:146]     __INFO   ( x2 x1 -- ) ( R: -- x1 x2 2 )
    ex   (SP),HL        ; 1:19      __INFO
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   DE = x2 = origin nos
    pop  BC             ; 1:10      __INFO   DE = x1 = origin tos
    dec  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),C          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),0x00       ; 2:10      __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),0x02       ; 2:10      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO},
__{}eval($1),3,{
                      ;[27:182]     __INFO   ( x3 x2 x1 -- ) ( R: -- x1 x2 x3 3 )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   origin tos
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO   origin nos
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO   origin nnos
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),0x00       ; 2:10      __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),0x03       ; 2:10      __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__{}{
                       ;format({%-11s},[eval(25+2*(($1) & 1)+(__HEX_H($1) & 1)):eval(79+81*(($1+1)/2)-22*(($1) & 1)+3*(__HEX_H($1) & 1))]) __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu $1 )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ld    B, format({%-11s},eval(($1+1)/2)); 2:7       __INFO   B = ($1+1)/2{}dnl
__{}ifelse(__HEX_H(+($1+1)/2),{0x00},,{
__{}__{}  .error {$0}($@): eval(($1+1)/2) is greater 255!}){}dnl
__{}ifelse(eval(($1)&1),1,{
__{}__{}    jr   $+7            ; 2:12      __INFO}){}dnl

    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    djnz $-10           ; 2:8/13    __INFO
    dec  HL             ; 1:6       __INFO
__{}ifelse(__HEX_H($1),{0x00},{dnl
    ld  (HL), B         ; 1:7       __INFO   hi($1)},
__{}{dnl
    ld  (HL),__HEX_H($1)       ; 2:10      __INFO   hi($1)})
    dec   L             ; 1:4       __INFO
    ld  (HL),__HEX_L($1)       ; 2:10      __INFO   lo($1)
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # n>r rdrop
dnl # ( xu .. x2 x1 u -- ) ( R: -- x1 x2 .. xu )
dnl # Move u cells from the data stack to the return stack.
define({PUSH_N_TO_R_RDROP},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_N_TO_R_RDROP},{$1 n>r rdrop},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_N_TO_R_RDROP},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
                      ;[20:73+u*47] __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu )   u=$1
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO   0..255
    or    A             ; 1:4       __INFO
    jr    z, $+12       ; 2:7/12    __INFO
    exx                 ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    djnz $-5            ; 2:8/13    __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__IS_NUM($1),{0},{
                      ;[19:67+u*47] __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld    A, __FORM({%-11s},$1); 2:7       __INFO   0..255
    or    A             ; 1:4       __INFO
    jr    z, $+12       ; 2:7/12    __INFO
    exx                 ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    djnz $-5            ; 2:8/13    __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
{dnl
__{}ifelse(eval($1),0,{},
__{}eval($1),1,{__ASM_TOKEN_TO_R},
__{}eval($1),2,{
                      ;[15:116]     __INFO   ( x2 x1 -- ) ( R: -- x1 x2 )
    ex   (SP),HL        ; 1:19      __INFO
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   DE = x2 = origin nos
    pop  BC             ; 1:10      __INFO   DE = x1 = origin tos
    dec  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),C          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO},
__{}eval($1),3,{
                      ;[21:152]     __INFO   ( x3 x2 x1 -- ) ( R: -- x1 x2 x3 )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   origin tos
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO   origin nos
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO   origin nnos
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__{}{
                       ;format({%-11s},[eval(20+2*(($1) & 1)):eval(52+81*(($1+1)/2)-22*(($1) & 1))]) __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ld    B, format({%-11s},eval(($1+1)/2)); 2:7       __INFO   B = ($1+1)/2{}dnl
__{}ifelse(eval(($1)&1),1,{
__{}    jr   $+7            ; 2:12      __INFO})
    pop  DE             ; 1:10      __INFO   DE
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO   DE
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    djnz $-10           ; 2:8/13    __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # r>
dnl # ( -- x ) ( R: x -- )
dnl # Move x from the return stack to the data stack.
define({R_FROM},{dnl
__{}__ADD_TOKEN({__TOKEN_R_FROM},{r>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_R_FROM},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:66]     __INFO   ( b a -- b a i ) ( R: i -- )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO   i . b a
    ex   DE, HL         ; 1:4       __INFO   i . a b
    ex  (SP), HL        ; 1:19      __INFO   b . a i}){}dnl
dnl
dnl
dnl
dnl # nr>
dnl # ( -- xu .. x2 x1 u ) ( R: x1 x2 .. xu u -- )
dnl # Move u cells from the data stack to the return stack.
define({NR_FROM},{dnl
__{}__ADD_TOKEN({__TOKEN_NR_FROM},{nr>}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NR_FROM},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
                      ;[22:74+u*48] __INFO   ( -- xu .. x2 x1 u ) ( R: x1 x2 .. xu u -- )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    or    A             ; 1:4       __INFO   u = 0..255
    jr    z, $+10       ; 2:7/12    __INFO
    ld    B, A          ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO
    djnz $-5            ; 2:8/13    __INFO
    exx                 ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    H, 0x00       ; 2:7       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # rdrop u >r nr> drop
dnl # ( xu .. x2 x1 u -- ) ( R: -- x1 x2 .. xu )
dnl # Move u cells from the data stack to the return stack.
define({PUSH_UR_FROM},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_UR_FROM},{rdrop $1 >r nr> drop},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_UR_FROM},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
                      ;[20:73+u*48] __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu )   u=$1
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO   0..255
    or    A             ; 1:4       __INFO
    jr   $+12           ; 2:7/12    __INFO
    exx                 ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO   DE
    djnz $-5            ; 2:8/13    __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__IS_NUM($1),{0},{
                      ;[19:67+u*48] __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld    A, __FORM({%-11s},$1); 2:7       __INFO   0..255
    or    A             ; 1:4       __INFO
    jr   $+12           ; 2:7/12    __INFO
    exx                 ; 1:4       __INFO
    ld    B, A          ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO   DE
    djnz $-5            ; 2:8/13    __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
{dnl
__{}ifelse(eval($1),0,{},
__{}eval($1),1,{__ASM_TOKEN_R_FROM},
__{}eval($1),2,{
                      ;[15:118]     __INFO   ( -- x2 x1 ) ( R: x1 x2 -- )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    C,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push BC             ; 1:11      __INFO   BC = x1
    push DE             ; 1:11      __INFO   DE = x2
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    ex  (SP),HL         ; 1:19      __INFO},
__{}eval($1),3,{
                      ;[21:155]     __INFO   ( x3 x2 x1 -- ) ( R: -- x1 x2 x3 )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO   new nnos
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO   new nos
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO   new tos
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO},
__{}{
                       ;format({%-11s},[eval(20+2*(($1) & 1)):eval(52+83*(($1+1)/2)-22*(($1) & 1))]) __INFO   ( xu .. x2 x1 -- ) ( R: -- x1 x2 .. xu )  u = $1
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ld    B, format({%-11s},eval(($1+1)/2)); 2:7       __INFO   B = ($1+1)/2{}dnl
__{}ifelse(eval(($1)&1),1,{
__{}    jr   $+7            ; 2:12      __INFO})
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO   DE
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    push DE             ; 1:11      __INFO   DE
    djnz $-10           ; 2:8/13    __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl # rpick
dnl # ( u -- xu ) ( R: -- xu .. x2 x0 )
dnl # copy u-cell from the return stack to the data stack
define({RPICK},{dnl
ifelse(eval($#>0),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_RPICK},{rpick})}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RPICK},{dnl
ifelse(eval($#>0),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[10:73]     __INFO   ( u -- xu ) ( R: xu .. x1 x0 -- xu .. x1 x0 )
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    pop  BC             ; 1:10      __INFO   ras
    add  HL, HL         ; 1:11      __INFO
    add  HL, BC         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # u rpick
dnl # ( -- xu ) ( R: -- xu .. x2 x0 )
dnl # copy u-cell from the return stack to the data stack
define({PUSH_RPICK},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_RPICK},{$1 rpick},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_RPICK},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
                       ;[15:106]    __INFO   ( -- x_{}$1 ) ( R: x_{}$1 .. x1 x0 -- x_{}$1 .. x1 x0 )
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, format({%-11s},$1); 3:16      __INFO
    add  HL, HL         ; 1:11      __INFO
    add  HL, DE         ; 1:11      __INFO
    ld    C,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    ex   DE, HL         ; 1:4       __INFO
    push BC             ; 1:11      __INFO   BC = x_{}$1
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO},
__IS_NUM($1),{0},{
                       ;[13:85]     __INFO   ( -- x_{}$1 ) ( R: x_{}$1 .. x1 x0 -- x_{}$1 .. x1 x0 )
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    ld   BC, __FORM({%-11s},2*($1)); 3:10      __INFO   2*($1)
    add  HL, BC         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO   HL = x_{}$1},
{dnl
__{}ifelse(eval($1),0,{__ASM_TOKEN_R_FETCH},
__{}eval($1),1,{
                       ;[11:74]     __INFO   ( -- x1 ) ( R: x1 x0 -- x1 x0 )
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO},
__{}eval($1),2,{
                       ;[13:84]     __INFO   ( -- x2 ) ( R: x2 x1 x0 -- x2 x1 x0 )
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO},
__{}{
                       ;[13:85]     __INFO   ( -- x{}$1 ) ( R: x{}$1 .. x1 x0 -- x{}$1 .. x1 x0 )
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO
    ld   BC, __HEX_HL(2*($1))     ; 3:10      __INFO   2*($1)
    add  HL, BC         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # drop u rpick
dnl # ( x -- xu ) ( R: -- xu .. x2 x0 )
dnl # replace tos u-cell from the return stack
define({DROP_PUSH_RPICK},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_PUSH_RPICK},{drop $1 rpick},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_PUSH_RPICK},{dnl
ifelse(eval($#<1),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
                       ;[13:89]     __INFO   ( x -- x_{}$1 ) ( R: x_{}$1 .. x1 x0 -- x_{}$1 .. x1 x0 )
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    pop  BC             ; 1:10      __INFO   ras
    ld   HL, format({%-11s},$1); 3:16      __INFO
    add  HL, HL         ; 1:11      __INFO
    add  HL, BC         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO   HL = x_{}$1},
__IS_NUM($1),{0},{
                       ;[12:72]     __INFO   ( x -- x_{}$1 ) ( R: x_{}$1 .. x1 x0 -- x_{}$1 .. x1 x0 )
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    pop  BC             ; 1:10      __INFO   ras
    ld   HL, __FORM({%-11s},2*($1)); 3:10      __INFO
    add  HL, BC         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO   HL = x_{}$1},
{dnl
__{}ifelse(eval($1),0,{__ASM_TOKEN_DROP_R_FETCH},
__{}eval($1),1,{
                       ;[10:61]     __INFO   ( x -- x1 ) ( R: x1 x0 -- x1 x0 )
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO   ras
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO},
__{}eval($1),2,{
                       ;[12:71]     __INFO   ( x -- x2 ) ( R: x2 x1 x0 -- x2 x1 x0 )
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO   ras
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO},
__{}{
                       ;[12:72]     __INFO   ( x -- x{}$1 ) ( R: x{}$1 .. x1 x0 -- x{}$1 .. x1 x0 )
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    pop  BC             ; 1:10      __INFO   ras
    ld   HL, __HEX_HL(2*($1))     ; 3:10      __INFO   2*($1)
    add  HL, BC         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # x u rpick
dnl # ( -- x xu ) ( R: xu .. x2 x0 -- xu .. x2 x0 )
dnl # put x and u-cell from the return stack
define({PUSH2_RPICK},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_RPICK},{$1 $2 rpick},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_RPICK},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($2),{1},{
                       ;[18:ifelse(__IS_MEM_REF($1),1,127,121)]    __INFO   ( -- $1 x_{}$2 ) ( R: x_{}$2 .. x1 x0 -- x_{}$2 .. x1 x0 )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   ras
    ld   HL, format({%-11s},$2); 3:16      __INFO
    add  HL, HL         ; 1:11      __INFO
    add  HL, DE         ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = x_{}$2
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO})
    ex   DE, HL         ; 1:4       __INFO},
__IS_NUM($2),{0},{
                       ;[16:ifelse(__IS_MEM_REF($1),1,108,102)]    __INFO   ( -- $1 x_{}$2 ) ( R: x_{}$2 .. x1 x0 -- x_{}$2 .. x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    ld   BC, __FORM({%-11s},2*($2)); 3:10      __INFO   $2+$2
    add  HL, BC         ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = x_{}$2
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO})
    ex   DE, HL         ; 1:4       __INFO},
{dnl
__{}ifelse(eval($2),0,{__ASM_TOKEN_PUSH_R_FETCH($1)},
__{}eval($2),1,{
                       ;[14:ifelse(__IS_MEM_REF($1),1,97,91)]     __INFO   ( -- $1 x1 ) ( R: x1 x0 -- x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO})
    ex   DE, HL         ; 1:4       __INFO},
__{}eval($2),2,{
                       ;[16:ifelse(__IS_MEM_REF($1),1,107,101)]    __INFO   ( -- $1 x2 ) ( R: x2 x1 x0 -- x2 x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO})
    ex   DE, HL         ; 1:4       __INFO},
__{}{define({_TMP_INFO},__COMPILE_INFO)__LD_REG16({HL},$1,{BC},$2+$2)
                       ;format({%-11s},[eval(13+__BYTES_16BIT):eval(92+__CLOCKS_16BIT)]) __INFO   ( -- $1 x{}$2 ) ( R: x{}$2 .. x1 x0 -- x{}$2 .. x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    ld   BC, __HEX_HL(2*($2))     ; 3:10      __INFO   $2+$2
    add  HL, BC         ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO{}__CODE_16BIT
    ex   DE, HL         ; 1:4       __INFO})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # x u rpick !
dnl # ( -- ) ( R: xu .. x2 x0 -- xu .. x2 x0 )
dnl # store x to address xu
define({PUSH2_RPICK_STORE},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_RPICK_STORE},{$1 $2 rpick !},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_RPICK_STORE},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{2},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($2),{1},{
                       ;[18:102]    __INFO   ( -- ) ( R: x_{}$2 .. x1 x0 -- x_{}$2 .. x1 x0 )
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, format({%-11s},$2); 3:16      __INFO
    add  HL, HL         ; 1:11      __INFO   $2+$2
    add  HL, DE         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld  (HL),low __FORM({%-7s},$1); 2:10      __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),high __FORM({%-6s},$1); 2:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
__IS_NUM($2),{0},{
                       ;[17:85]     __INFO   ( -- ) ( R: x_{}$2 .. x1 x0 -- x_{}$2 .. x1 x0 )
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, __FORM({%-11s},2*($2)); 3:10      __INFO   $2+$2
    add  HL, DE         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld  (HL),low __FORM({%-7s},$1); 2:10      __INFO   lo
    inc  HL             ; 1:6       __INFO
    ld  (HL),high __FORM({%-6s},$1); 2:10      __INFO   hi
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
{dnl
__{}ifelse(eval($2),0,{__ASM_TOKEN_PUSH_R_FETCH_STORE($1)},
__{}eval($2),1,{
                       ;[16:78]     __INFO   ( -- ) ( R: x1 x0 -- x1 x0 )
    exx                 ; 1:4       __INFO
    ld    E, L          ; 1:4       __INFO
    ld    D, H          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld  (HL),low __FORM({%-7s},$1); 2:10      __INFO   lo
    inc  HL             ; 1:6       __INFO
    ld  (HL),high __FORM({%-6s},$1); 2:10      __INFO   hi
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
__{}{
                       ;[17:85]     __INFO   ( -- ) ( R: x{}$2 .. x1 x0 -- x{}$2 .. x1 x0 )
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, __HEX_HL(2*($2))     ; 3:10      __INFO   $2+$2
    add  HL, DE         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld  (HL),low __FORM({%-7s},$1); 2:10      __INFO   lo
    inc  HL             ; 1:6       __INFO
    ld  (HL),high __FORM({%-6s},$1); 2:10      __INFO   hi
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # char u rpick c!
dnl # ( -- ) ( R: xu .. x2 x0 -- xu .. x2 x0 )
dnl # store char to address xu
define({PUSH2_RPICK_CSTORE},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_RPICK_CSTORE},{$1 $2 rpick c!},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_RPICK_CSTORE},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{2},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE},__LD_R_NUM(__INFO{   lo},{A},$1)){}dnl
__{}ifelse(__IS_MEM_REF($2),{1},{
                       ;[eval(13+__BYTES):eval(79+__CLOCKS)]     __INFO   ( -- ) ( R: x_{}$2 .. x1 x0 -- x_{}$2 .. x1 x0 )
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},$2); 3:16      __INFO
    add  HL, HL         ; 1:11      __INFO   $2+$2
    add  HL, DE         ; 1:11      __INFO
    ld    C,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO{}dnl
__{}__CODE
    ld  (BC),A          ; 1:7       __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
__IS_NUM($2),{0},{
                       ;[14:69]     __INFO   ( -- ) ( R: x_{}$2 .. x1 x0 -- x_{}$2 .. x1 x0 )
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, __FORM({%-11s},2*($2)); 3:10      __INFO   $2+$2
    add  HL, DE         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld  (HL),low __FORM({%-7s},$1); 2:10      __INFO   lo
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
{dnl
__{}ifelse(eval($2),0,{__ASM_TOKEN_PUSH_R_FETCH_CSTORE($1)},
__{}eval($2),1,{
                       ;[eval(11+__BYTES):eval(55+__CLOCKS)]     __INFO   ( -- ) ( R: x1 x0 -- x1 x0 )
    exx                 ; 1:4       __INFO
    ld    E, L          ; 1:4       __INFO
    ld    D, H          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    C,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO{}dnl
__{}__CODE
    ld  (BC),A          ; 1:7       __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
__{}{
                       ;[eval(12+__BYTES):eval(62+__CLOCKS)]     __INFO   ( -- ) ( R: x{}$2 .. x1 x0 -- x{}$2 .. x1 x0 )
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, __HEX_HL(2*($2))     ; 3:10      __INFO   $2+$2
    add  HL, DE         ; 1:11      __INFO
    ld    C,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO{}dnl
__{}__CODE
    ld  (BC),A          ; 1:7       __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # u rpick x
dnl # ( -- xu x ) ( R: -- xu .. x2 x0 )
dnl # put u-cell from the return stack and x
define({PUSH_RPICK_PUSH},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_RPICK_PUSH},{$1 rpick $2},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_RPICK_PUSH},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
                       ;[17:ifelse(__IS_MEM_REF($2),1,123,117)]    __INFO   ( -- x_{}$1 $2 ) ( R: x_{}$1 .. x1 x0 -- x_{}$1 .. x1 x0 )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   ras
    ld   HL, format({%-11s},$1); 3:16      __INFO
    add  HL, HL         ; 1:11      __INFO
    add  HL, DE         ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = x_{}$1
__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})},
__IS_NUM($1),{0},{
                       ;ifelse(__IS_MEM_REF($2),1,[15:104],[15:98] )    __INFO   ( -- x_{}$1 $2 ) ( R: x_{}$1 .. x1 x0 -- x_{}$1 .. x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    ld   BC, __FORM({%-11s},2*($1)); 3:10      __INFO   $1+$1
    add  HL, BC         ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = x_{}$1
__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})},
{dnl
__{}ifelse(eval($1),0,{__ASM_TOKEN_R_FETCH_PUSH($2)},
__{}eval($1),1,{
                       ;[13:ifelse(__IS_MEM_REF($2),1,93,87)]     __INFO   ( -- x1 $2 ) ( R: x1 x0 -- x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})},
__{}eval($1),2,{
                       ;ifelse(__IS_MEM_REF($2),1,[15:103],[15:97] )    __INFO   ( -- x2 $2 ) ( R: x2 x1 x0 -- x2 x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    inc   L             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$2); 3:10      __INFO})},
__{}{define({_TMP_INFO},__COMPILE_INFO)__LD_REG16({HL},$2,{BC},$1+$1)
                       ;format({%-11s},[eval(12+__BYTES_16BIT):eval(88+__CLOCKS_16BIT)]) __INFO   ( -- x{}$1 $2 ) ( R: x{}$1 .. x1 x0 -- x{}$1 .. x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    ld   BC, __HEX_HL(2*($1))     ; 3:10      __INFO   $1+$1
    add  HL, BC         ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO{}__CODE_16BIT})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # r@
dnl # ( -- x ) ( R: x -- x )
dnl # Copy x from the return stack to the data stack.
define({R_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_R_FETCH},{r@}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_R_FETCH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl

dnl #                        ;[9:64]     r_fetch ( b a -- b a i ) ( R: i -- i )
dnl #    exx                 ; 1:4       r_fetch   .
dnl #    push HL             ; 1:11      r_fetch r .
dnl #    exx                 ; 1:4       r_fetch r . b a
dnl #    ex   DE, HL         ; 1:4       r_fetch r . a b
dnl #    ex  (SP), HL        ; 1:19      r_fetch b . a r     HL = r.a.s.
dnl #    ld    A,(HL)        ; 1:7       r_fetch
dnl #    inc   L             ; 1:4       r_fetch
dnl #    ld    H,(HL)        ; 1:7       r_fetch
dnl #    ld    L, A          ; 1:4       r_fetch b . a i
                        ;[9:64]     __INFO   ( -- i ) ( R: i -- i )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ex  (SP), HL        ; 1:19      __INFO}){}dnl
dnl
dnl
dnl # r@ x
dnl # ( -- x1 x ) ( R: x1 -- x1 )
dnl # put top from the return stack and x
define({R_FETCH_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_R_FETCH_PUSH},{r@ $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_R_FETCH_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[11:ifelse(__IS_MEM_REF($1),1,83,77)]    __INFO   ( -- x1 $1 ) ( R: x1 -- x1 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   HL = r.a.s.
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO})}){}dnl
dnl
dnl
dnl
dnl # drop r@
dnl # ( x2 -- x1 ) ( R: x1 -- x1 )
dnl # romove top from the return stack
define({DROP_R_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_R_FETCH},{drop r@}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_R_FETCH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl

dnl #                        ;[8:64]     r_fetch ( b a -- b i ) ( R: i -- i )
dnl #    exx                 ; 1:4       r_fetch   .
dnl #    push HL             ; 1:11      r_fetch r .
dnl #    exx                 ; 1:4       r_fetch r . b a
dnl #    pop  HL             ; 1:10      r_fetch   . b r     HL = r.a.s.
dnl #    ld    A,(HL)        ; 1:7       r_fetch
dnl #    inc   L             ; 1:4       r_fetch
dnl #    ld    H,(HL)        ; 1:7       r_fetch
dnl #    ld    L, A          ; 1:4       r_fetch   . b i
                        ;[8:51]     __INFO   ( x2 -- x1 ) ( R: x1 -- x1 )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # x r@
dnl # ( -- x x1 ) ( R: x1 -- x1 )
dnl # put x and top from the return stack
define({PUSH_R_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_R_FETCH},{$1 r@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_R_FETCH},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[12:ifelse(__IS_MEM_REF($1),1,{87},{81})]    __INFO   ( -- $1 x1 ) ( R: x1 -- x1 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   HL = r.a.s.
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld   HL, format({%-11s},$1); 3:16      __INFO},
__{}{dnl
__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO})
    ex   DE, HL         ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # x r@ !
dnl # ( -- ) ( R: x1 -- x1 )
define({PUSH_R_FETCH_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_R_FETCH_STORE},{$1 r@ !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_R_FETCH_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
                        ;[15:76]    __INFO   ( -- ) ( R: x1 -- x1 )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO
    ld  (DE),A          ; 1:7       __INFO   lo
    inc  DE             ; 1:6       __INFO
    ld    A, format({%-11s},(1+$1)); 3:13      __INFO
    ld  (DE),A          ; 1:7       __INFO   hi
    exx                 ; 1:4       __INFO},
__IS_NUM($1),1,{
                        ;[13:64]    __INFO   ( -- ) ( R: x1 -- x1 )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld  (HL),__HEX_L($1)       ; 2:10      __INFO   lo
    inc  HL             ; 1:6       __INFO
    ld  (HL),__HEX_H($1)       ; 2:10      __INFO   hi
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
{
                        ;[13:64]    __INFO   ( -- ) ( R: x1 -- x1 )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld  (HL),low __FORM({%-7s},$1); 2:10      __INFO   lo
    inc  HL             ; 1:6       __INFO
    ld  (HL),high __FORM({%-6s},$1); 2:10      __INFO   hi
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO})}){}dnl
dnl
dnl
dnl
dnl # char r@ c!
dnl # ( -- ) ( R: x1 -- x1 )
define({PUSH_R_FETCH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_R_FETCH_CSTORE},{$1 r@ c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_R_FETCH_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
                        ;[10:50]    __INFO   ( -- ) ( R: x1 -- x1 )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO
    ld  (DE),A          ; 1:7       __INFO   lo
    exx                 ; 1:4       __INFO},
__IS_NUM($1),1,{define({__CODE},__LD_R_NUM(__INFO{   lo},{A},$1))
                        ;[eval(7+__BYTES):eval(37+__CLOCKS)]     __INFO   ( -- ) ( R: x1 -- x1 )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    dec   L             ; 1:4       __INFO{}dnl
__{}__CODE
    ld  (DE),A          ; 1:7       __INFO
    exx                 ; 1:4       __INFO},
{
                        ;[9:44]     __INFO   ( -- ) ( R: x1 -- x1 )
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld    A,__FORM({%-12s},low $1); 2:7       __INFO   lo
    ld  (DE),A          ; 1:7       __INFO
    exx                 ; 1:4       __INFO})}){}dnl
dnl
dnl
dnl # rdrop
dnl # r:( a -- )
dnl # odstrani vrchol zasobniku navratovych adres
define({RDROP},{dnl
__{}__ADD_TOKEN({__TOKEN_RDROP},{rdrop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RDROP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[4:18]     __INFO   ( r: a -- )
    exx                 ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   HL            ; 1:6       __INFO
    exx                 ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # r> r> swap >r >r
dnl # 2r> >r >r
dnl # r> r> 2>r
dnl # 2r> swap 2>r
dnl # ( R: x1 x2 -- x2 x1 )
dnl # Swap cell x1 x2 in the return stack.
define({RSWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_RSWAP},{rswap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RSWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[14:86]    __INFO   ( R: j i -- i j )
    exx                 ; 1:4       __INFO
    ld  ($+10), SP      ; 4:20      __INFO
    ld   SP, HL         ; 1:6       __INFO
    pop  DE             ; 1:10      __INFO
    pop  AF             ; 1:10      __INFO
    push DE             ; 1:11      __INFO
    push AF             ; 1:11      __INFO
    ld   SP, 0x0000     ; 3:10      __INFO
    exx                 ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ------------------- 32 bits ---------------------
dnl
dnl
dnl # 2>r
dnl # swap >r >r
dnl # ( x1 x2 -- ) ( R: -- x1 x2 )
dnl # Transfer cell pair x1 x2 to the return stack.
define({_2TO_R},{dnl
__{}__ADD_TOKEN({__TOKEN_2TO_R},{2>r},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2TO_R},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[15:116]   __INFO   ( d c b a -- d c ) ( R: -- b a )
    ex  (SP), HL        ; 1:19      __INFO   d a   . b c
    push DE             ; 1:11      __INFO   d a b . b c
    exx                 ; 1:4       __INFO   d a b .
    pop  DE             ; 1:10      __INFO   d a   . b
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO                ( R: b )
    pop  DE             ; 1:10      __INFO   d     . a
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO                ( R: b a )
    exx                 ; 1:4       __INFO   d     . b c
    pop  DE             ; 1:10      __INFO         . d c}){}dnl
dnl
dnl
dnl # 2r>
dnl # r> r> swap
dnl # ( -- x1 x2 ) ( R: x1 x2 -- )
dnl # Transfer cell pair x1 x2 from the return stack.
define({_2R_FROM},{dnl
__{}__ADD_TOKEN({__TOKEN_2R_FROM},{2r>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2R_FROM},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[15:118]   __INFO   ( b a -- b a j i ) ( R: j i -- )
    push DE             ; 1:11      __INFO   b     . b a
    exx                 ; 1:4       __INFO   b     .
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO              ( R: j )
    push DE             ; 1:11      __INFO   b i   .
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO              ( R : )
    push DE             ; 1:11      __INFO   b i j .
    exx                 ; 1:4       __INFO   b i j . b a
    pop  DE             ; 1:10      __INFO   b i   . j a
    ex  (SP), HL        ; 1:19      __INFO   b a   . j i}){}dnl
dnl
dnl
dnl # 2r@
dnl # r> r> 2dup >r >r swap
dnl # ( -- x1 x2 ) ( R: x1 x2 -- x1 x2 )
dnl # Copy cell pair x1 x2 from the return stack.
define({_2R_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_2R_FETCH},{2r@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2R_FETCH},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[14:99]    __INFO   ( b a -- b a j i ) ( r: j i -- j i )
    push DE             ; 1:11      __INFO   b   . b a
    exx                 ; 1:4       __INFO   b   .
    push HL             ; 1:11      __INFO   b r .
    exx                 ; 1:4       __INFO   b r . b a
    ex  (SP), HL        ; 1:19      __INFO   b a . b r     HL = r.a.s.
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO   b a . i r
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO   b a . i j
    ex   DE, HL         ; 1:4       __INFO   b a . j i}){}dnl
dnl
dnl
dnl # 2rdrop
dnl # r:( j i -- )
dnl # odstrani dve polozky ze zasobniku navratovych adres
define({_2RDROP},{dnl
__{}__ADD_TOKEN({__TOKEN_2RDROP},{2rdrop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2RDROP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:28]     __INFO   ( r: x1 x2 -- )
    exx                 ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    inc   HL            ; 1:6       __INFO
    inc   L             ; 1:4       __INFO
    inc   HL            ; 1:6       __INFO
    exx                 ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # r> r> r> r> _2swap >r >r >r >r
dnl # 2r> 2r> _2swap 2>r 2>r
dnl # ( R: x4 x3 x2 x1 -- x2 x1 )
dnl # Swap cell pair x4 x3 and x2 x1 in the return stack.
define({_2RSWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_2RSWAP},{2rswap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2RSWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[19:134]   __INFO   ( r: l k j i -- j i l k )
    exx                 ; 1:4       __INFO
    ld  ($+14), SP      ; 4:20      __INFO
    ld   SP, HL         ; 1:6       __INFO
    ex   DE, HL         ; 1:4       __INFO   l  k  j  i
    pop  BC             ; 1:10      __INFO   l  k  j  BC
    pop  HL             ; 1:10      __INFO   l  k  HL
    pop  AF             ; 1:10      __INFO   l  AF
    ex  (SP),HL         ; 1:19      __INFO   j     HL=l
    push BC             ; 1:11      __INFO   j  i
    push HL             ; 1:11      __INFO   j  i  l
    push AF             ; 1:11      __INFO   j  i  l  k
    ld   SP, 0x0000     ; 3:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- r.a.s. )
define({RAS},{dnl
__{}__ADD_TOKEN({__TOKEN_RAS},{ras},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RAS},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex   DE, HL         ; 1:4       __INFO   ( -- return_address_stack )
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x -- r.a.s. )
define({DROP_RAS},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_RAS},{drop ras},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_RAS},{dnl
__{}define({__INFO},__COMPILE_INFO)
    exx                 ; 1:4       __INFO   ( x -- return_address_stack )
    push HL             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl

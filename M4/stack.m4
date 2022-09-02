dnl ## Stack manipulation
dnl
dnl
dnl
dnl # ( -- a )
dnl # push(a) ulozi na zasobnik nasledujici polozku
define({PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro! Maybe you want to use {PUSH2}($1,$2)?})
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      __INFO}){}dnl
dnl
dnl
dnl # ( -- b a)
dnl # push2(b,a) ulozi na zasobnik nasledujici polozky
define({PUSH2},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2},{$1 $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2},{dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=2),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_INFO},__INFO){}dnl # HL first check
__{}define({__TMP_HL_CLOCKS},22){}dnl
__{}define({__TMP_HL_BYTES},2){}dnl
__{}__LD_REG16({DE},$1,{HL},$2){}dnl
__{}define({__TMP_HL_CLOCKS},eval(__TMP_HL_CLOCKS+__CLOCKS_16BIT)){}dnl
__{}define({__TMP_HL_BYTES}, eval(__TMP_HL_BYTES +__BYTES_16BIT)){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}define({__TMP_HL_CLOCKS},eval(__TMP_HL_CLOCKS+__CLOCKS_16BIT)){}dnl
__{}define({__TMP_HL_BYTES}, eval(__TMP_HL_BYTES +__BYTES_16BIT)){}dnl
__{}dnl
__{}define({__TMP_DE_CLOCKS},22){}dnl
__{}define({__TMP_DE_BYTES},2){}dnl
__{}__LD_REG16({HL},$2,{DE},$1){}dnl # DE first check
__{}define({__TMP_DE_CLOCKS},eval(__TMP_DE_CLOCKS+__CLOCKS_16BIT)){}dnl
__{}define({__TMP_DE_BYTES}, eval(__TMP_DE_BYTES +__BYTES_16BIT)){}dnl
__{}__LD_REG16({DE},$1){}dnl
__{}define({__TMP_DE_CLOCKS},eval(__TMP_DE_CLOCKS+__CLOCKS_16BIT)){}dnl
__{}define({__TMP_DE_BYTES}, eval(__TMP_DE_BYTES +__BYTES_16BIT)){}dnl
__{}dnl
__{}ifelse(eval(__TMP_DE_CLOCKS<=__TMP_HL_CLOCKS),{1},{dnl # DE first
__{}                        ;[__TMP_DE_BYTES:__TMP_DE_CLOCKS]     __COMPILE_INFO
__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 )
__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__CODE_16BIT{}__LD_REG16({HL},$2,{DE},$1){}__CODE_16BIT},
__{}{dnl # HL first
__{}                        ;[__TMP_HL_BYTES:__TMP_HL_CLOCKS]     __COMPILE_INFO
__{}    push DE             ; 1:11      __INFO   ( -- $1 $2 )
__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({HL},$2){}__CODE_16BIT{}__LD_REG16({DE},$1,{HL},$2){}__CODE_16BIT}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( -- c b a)
dnl # push3(c,b,a) ulozi na zasobnik nasledujici polozky
define({PUSH3},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH3},{$1 $2 $3},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH3},{dnl
__{}define({__INFO},{$1 $2 $3}){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#!=3),{1},{
__{}  .error {$0}($@): The wrong number of parameters in macro!},
{
__{}    push DE             ; 1:11      __COMPILE_INFO   ( -- $1 $2 $3 )
__{}    push HL             ; 1:11      __COMPILE_INFO{}dnl
__{}define({_TMP_INFO},__COMPILE_INFO){}dnl
__{}__LD_REG16_BEFORE_AFTER({DE},$2,{HL},$1,{HL},$3){}dnl
__{}define({PUSH3_P1},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},$3,{HL},$1){}dnl
__{}define({PUSH3_P1},eval(PUSH3_P1+__PRICE_16BIT)){}dnl
__{}define({PUSH3_P},PUSH3_P1){}dnl
__{}define({PUSH3_X},1){}dnl
__{}dnl
__{}__LD_REG16_BEFORE_AFTER({HL},$3,{DE},$1,{DE},$2){}dnl
__{}define({PUSH3_P2},__PRICE_16BIT){}dnl
__{}__LD_REG16({DE},$2,{DE},$1){}dnl
__{}define({PUSH3_P2},eval(PUSH3_P2+__PRICE_16BIT)){}dnl
__{}ifelse(eval(PUSH3_P>PUSH3_P2),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P2){}dnl
__{}__{}define({PUSH3_X},2)}){}dnl
__{}dnl
__{}__LD_REG16({DE},$2,{DE},$1,{HL},$3){}dnl
__{}__{}define({PUSH3_P3},eval(22+__PRICE_16BIT)){}dnl
__{}ifelse(eval(PUSH3_P>22+__PRICE_16BIT),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P3){}dnl
__{}__{}define({PUSH3_X},3)}){}dnl
__{}dnl
__{}__LD_REG16({HL},$3,{HL},$1,{DE},$2){}dnl
__{}__{}define({PUSH3_P4},eval(22+__PRICE_16BIT)){}dnl
__{}ifelse(eval(PUSH3_P>PUSH3_P4),{1},{dnl
__{}__{}define({PUSH3_P},PUSH3_P4){}dnl
__{}__{}define({PUSH3_X},4)}){}dnl
__{}dnl # PUSH3_P1 PUSH3_P2 PUSH3_P3 PUSH3_P4 --> PUSH3_X
__{}dnl ---- case PUSH3_X ----
__{}ifelse(dnl
__{}PUSH3_X,1,{__LD_REG16_BEFORE_AFTER({DE},$2,{HL},$1,{HL},$3){}__LD_REG16({HL},$3,{HL},$1)
__{}__{}    ld   HL, format({%-11s},$1); 3:10      __COMPILE_INFO
__{}__{}    push HL             ; 1:11      __COMPILE_INFO{}__CODE_BEFORE_16BIT{}__CODE_16BIT{}__CODE_AFTER_16BIT},
__{}PUSH3_X,2,{__LD_REG16_BEFORE_AFTER({HL},$3,{DE},$1,{DE},$2){}__LD_REG16({DE},$2,{DE},$1)
__{}__{}    ld   DE, format({%-11s},$1); 3:10      __COMPILE_INFO
__{}__{}    push DE             ; 1:11      __COMPILE_INFO{}__CODE_BEFORE_16BIT{}__CODE_16BIT{}__CODE_AFTER_16BIT},
__{}PUSH3_X,3,{__LD_REG16({DE},$2,{DE},$1,{HL},$3)
__{}__{}    ld   DE, format({%-11s},$1); 3:10      __COMPILE_INFO
__{}__{}    push DE             ; 1:11      __COMPILE_INFO
__{}__{}    ld   HL, format({%-11s},$3); 3:10      __COMPILE_INFO{}__CODE_16BIT},
__{}{__LD_REG16({HL},$3,{HL},$1,{DE},$2)
__{}__{}    ld   HL, format({%-11s},$1); 3:10      __COMPILE_INFO
__{}__{}    push HL             ; 1:11      __COMPILE_INFO
__{}__{}    ld   DE, format({%-11s},$2); 3:10      __COMPILE_INFO{}__CODE_16BIT}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl

    ex   DE, HL         ; 1:4       __INFO   ( b a -- a b )}){}dnl
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
dnl # swap 3
dnl # ( b a -- a b 3 )
define({SWAP_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_PUSH},{swap $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_PUSH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push HL             ; 1:11      __INFO
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      __INFO   ( b a -- a b $1 )}){}dnl
dnl
dnl
dnl # 3 swap
dnl # ( a -- 3 a )
define({PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SWAP},{$1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SWAP},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected type parameter!},
{define({__INFO},__COMPILE_INFO)
__{}    push DE             ; 1:11      __INFO
__{}    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      __INFO ( a -- $1 a )}){}dnl
}){}dnl
dnl
dnl
dnl # swap drop 3 swap
dnl # ( b a -- 3 a )
define({SWAP_DROP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_DROP_PUSH_SWAP},{swap drop $1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_DROP_PUSH_SWAP},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected type parameter!},
{define({__INFO},__COMPILE_INFO)
__{}    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      __INFO   ( b a -- $1 a )}){}dnl
}){}dnl
dnl
dnl
dnl # nip 3 swap
dnl # ( b a -- 3 a )
define({NIP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NIP_PUSH_SWAP},{nip $1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NIP_PUSH_SWAP},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected type parameter!},
{define({__INFO},__COMPILE_INFO)
__{}    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      __INFO   ( b a -- $1 a )}){}dnl
}){}dnl
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
    push DE             ; 1:11      __INFO
    ld    D, H          ; 1:4       __INFO
    ld    E, L          ; 1:4       __INFO   ( a -- a a )}){}dnl
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
dnl
dnl # drop 50
dnl # ( a -- 50 )
dnl # zmeni hodnotu top
define({DROP_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_PUSH},{drop $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_PUSH},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected type parameter!},
{define({__INFO},__COMPILE_INFO)
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      __INFO}){}dnl
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
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected type parameter!},
{define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( x2 x1 -- x2 x2 $1 )
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      __INFO}){}dnl
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
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected type parameter!},
{define({__INFO},__COMPILE_INFO)
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO}){}dnl
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
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected type parameter!},
{define({__INFO},__COMPILE_INFO)
    pop  DE             ; 1:10      __INFO
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      __INFO}){}dnl
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
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO   ( b a -- )}){}dnl
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
dnl # ( d c b a – b a )
dnl # : 2nip 2swap 2drop ;
dnl # drop_second
define({_2NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_2NIP},{2nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2NIP},{dnl
__{}define({__INFO},{2nip}){}dnl

    pop  AF             ; 1:10      2nip
    pop  AF             ; 1:10      2nip ( d c b a – b a )}){}dnl
dnl
dnl
dnl # ( b a -- a b a )
dnl # : tuck swap over ;
define({TUCK},{dnl
__{}__ADD_TOKEN({__TOKEN_TUCK},{tuck},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK},{dnl
__{}define({__INFO},{tuck}){}dnl

    push HL             ; 1:11      tuck ( b a -- a b a )}){}dnl
dnl
dnl
dnl # ( d c b a -- b a d c b a )
dnl # : 2tuck 2swap 2over ;
define({_2TUCK},{dnl
__{}__ADD_TOKEN({__TOKEN_2TUCK},{2tuck},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2TUCK},{dnl
__{}define({__INFO},{2tuck}){}dnl

                        ;[6:64]     2tuck ( d c b a -- b a d c b a )
    pop  AF             ; 1:10      2tuck     d   . b a     AF = c
    pop  BC             ; 1:10      2tuck         . b a     BC = d
    push DE             ; 1:11      2tuck b       . b a
    push HL             ; 1:11      2tuck b a     . b a
    push BC             ; 1:11      2tuck b a d   . b a
    push AF             ; 1:11      2tuck b a d c . b a}){}dnl
dnl
dnl
dnl # ( b a -- b a b )
dnl # vytvori kopii druhe polozky na zasobniku
define({OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER},{over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER},{dnl
__{}define({__INFO},{over}){}dnl

    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )}){}dnl
dnl
dnl
dnl # ( b a -- b b a )
define({OVER_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP},{over_swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP},{dnl
__{}define({__INFO},{over_swap}){}dnl

    push DE             ; 1:11      over_swap ( b a -- b b a )}){}dnl
dnl
dnl
dnl # 3 over
dnl # ( a -- a 3 a )
define({PUSH_OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER},{$1 over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER},{dnl
__{}define({__INFO},{$1 over}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 over
    push HL             ; 1:11      $1 over
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 over ( a -- a $1 a )}){}dnl
dnl
dnl
define({DUP_PUSH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_SWAP},{dup $1 swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_SWAP},{dnl
__{}define({__INFO},{dup $1 swap}){}dnl
PUSH_OVER($1)}){}dnl
dnl
dnl
dnl # over 3
dnl # ( b a -- b a b 3 )
define({OVER_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PUSH},{over $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PUSH},{dnl
__{}define({__INFO},{over $1}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      over $1
    push HL             ; 1:11      over $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      over $1 ( b a -- b a b $1 )}){}dnl
dnl
dnl
dnl # ( d c b a -- d c b a d c )
dnl # Copy cell pair "d c" to the top of the stack.
define({_2OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER},{2over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER},{dnl
__{}define({__INFO},{2over}){}dnl

                        ;[9:91]     2over ( d c b a -- d c b a d c )
    pop  AF             ; 1:10      2over d       . b a     AF = c
    pop  BC             ; 1:10      2over         . b a     BC = d
    push BC             ; 1:11      2over d       . b a
    push AF             ; 1:11      2over d c     . b a
    push DE             ; 1:11      2over d c b   . b a
    push AF             ; 1:11      2over d c b c . b a
    ex  (SP),HL         ; 1:19      2over d c b a . b c
    ld    D, B          ; 1:4       2over
    ld    E, C          ; 1:4       2over d c b a . d c}){}dnl
dnl
dnl
dnl # ( d c b a -- d c b a c )
dnl #   ( c b a -- c b a c )
define({_2OVER_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP},{2over_nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP},{dnl
__{}define({__INFO},{2over_nip}){}dnl
ifelse(_TYP_SINGLE,{small},{
                        ;[5:55]     2over nip  ( c b a -- c b a c )
    pop  BC             ; 1:10      2over nip      . b a     BC = c
    push BC             ; 1:11      2over nip  c   . b a
    push BC             ; 1:11      2over nip  c c . b a
    ex   DE, HL         ; 1:4       2over nip  c c . a b
    ex  (SP),HL         ; 1:19      2over nip  c b . a c},
{
                        ;[6:44]     2over nip  ( c b a -- c b a c )
    pop  BC             ; 1:10      2over nip      . b a   BC = c
    push BC             ; 1:11      2over nip  c   . b a
    push DE             ; 1:11      2over nip  c b . b a
    ex   DE, HL         ; 1:4       2over nip  c b . a b
    ld    L, C          ; 1:4       2over nip  c b . a -
    ld    H, B          ; 1:4       2over nip  c b . a c})}){}dnl
dnl
dnl
dnl # ( f e d c b a -- f e d c b a f e d )
dnl # Copy cell pair "f e d" to the top of the stack.
define({_3OVER},{dnl
__{}__ADD_TOKEN({__TOKEN_3OVER},{3over},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3OVER},{dnl
__{}define({__INFO},{3over}){}dnl

                       ;[19:130]    3over   ( f e d c b a -- f e d c b a f e d )
    push DE             ; 1:11      3over   f e d c b . . b a
    push HL             ; 1:11      3over   f e d c b a . b a
    ld   HL, 0x000B     ; 3:10      3over   f e d c b a . b 11
    add  HL, SP         ; 1:11      3over   f e d c b a . b -
    ld    D,(HL)        ; 1:7       3over   f e d c b a . - -
    dec  HL             ; 1:6       3over   f e d c b a . - -
    ld    E,(HL)        ; 1:7       3over   f e d c b a . f -
    dec  HL             ; 1:6       3over   f e d c b a . f -
    push DE             ; 1:11      3over   f e d c b a f f -
    ld    D,(HL)        ; 1:7       3over   f e d c b a f - -
    dec  HL             ; 1:6       3over   f e d c b a f - -
    ld    E,(HL)        ; 1:7       3over   f e d c b a f e -
    dec  HL             ; 1:6       3over   f e d c b a f e -
    ld    A,(HL)        ; 1:7       3over   f e d c b a f e -
    dec  HL             ; 1:6       3over   f e d c b a f e -
    ld    L,(HL)        ; 1:7       3over   f e d c b a f e -
    ld    H, A          ; 1:4       3over   f e d c b a f e d}){}dnl
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
__{}define({__INFO},{4over}){}dnl
ifelse(_TYP_SINGLE,{small},{
                       ;[19:212]    4over   ( d4 d3 d2 d1 -- d4 d3 d2 d1 d4 d3 )   # small version can be changed with "define({_TYP_SINGLE},{default})"
    ex   DE, HL         ; 1:4       4over   h g f e d c . . . . a b
    push HL             ; 1:11      4over   h g f e d c b . . . a b
    ld   HL, 0x000D     ; 3:10      4over   h g f e d c b . . . a 13
    add  HL, SP         ; 1:11      4over   h g f e d c b . . . a -
    ld    B, 0x03       ; 2:7       4over   h g f e d c b . . . a -
    push DE             ; 1:11      4over   h g f e d c b(a-h-g)f -
    ld    D,(HL)        ; 1:7       4over   h g f e d c b(a-h-g)f -
    dec  HL             ; 1:6       4over   h g f e d c b(a-h-g)f -
    ld    E,(HL)        ; 1:7       4over   h g f e d c b(a-h-g)f -
    dec  HL             ; 1:6       4over   h g f e d c b(a-h-g)f -
    djnz $-5            ; 2:8/13    4over   h g f e d c b(a-h-g)f -
    ld    A,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    dec  HL             ; 1:6       4over   h g f e d c b a h g f -
    ld    L,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    ld    H, A          ; 1:4       4over   h g f e d c b a h g f e},
{
                       ;[24:167]    4over   ( d4 d3 d2 d1 -- d4 d3 d2 d1 d4 d3 )   # default version can be changed with "define({_TYP_SINGLE},{small})"
    push DE             ; 1:11      4over   h g f e d c b . . . b a
    push HL             ; 1:11      4over   h g f e d c b a . . b a
    ld   HL, 0x000F     ; 3:10      4over   h g f e d c b a . . b 15
    add  HL, SP         ; 1:11      4over   h g f e d c b a . . b -
    ld    D,(HL)        ; 1:7       4over   h g f e d c b a . . - -
    dec  HL             ; 1:6       4over   h g f e d c b a . . - -
    ld    E,(HL)        ; 1:7       4over   h g f e d c b a . . h -
    dec  HL             ; 1:6       4over   h g f e d c b a . . h -
    push DE             ; 1:11      4over   h g f e d c b a h . h -
    ld    D,(HL)        ; 1:7       4over   h g f e d c b a h . - -
    dec  HL             ; 1:6       4over   h g f e d c b a h . - -
    ld    E,(HL)        ; 1:7       4over   h g f e d c b a h . g -
    dec  HL             ; 1:6       4over   h g f e d c b a h . g -
    push DE             ; 1:11      4over   h g f e d c b a h g g -
    ld    D,(HL)        ; 1:7       4over   h g f e d c b a h g - -
    dec  HL             ; 1:6       4over   h g f e d c b a h g - -
    ld    E,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    dec  HL             ; 1:6       4over   h g f e d c b a h g f -
    ld    A,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    dec  HL             ; 1:6       4over   h g f e d c b a h g f -
    ld    L,(HL)        ; 1:7       4over   h g f e d c b a h g f -
    ld    H, A          ; 1:4       4over   h g f e d c b a h g f e})}){}dnl
dnl
dnl
dnl # ( c b a -- b a c )
dnl # vyjme treti polozku a ulozi ji na vrchol, rotace doleva
define({ROT},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT},{rot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT},{dnl
__{}define({__INFO},{rot}){}dnl

    ex   DE, HL         ; 1:4       rot
    ex  (SP),HL         ; 1:19      rot ( c b a -- b a c )}){}dnl
dnl
dnl
dnl # rot drop
dnl # ( c b a -- b a )
dnl # Remove third item from stack
define({ROT_DROP},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_DROP},{rot_drop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_DROP},{dnl
__{}define({__INFO},{rot_drop}){}dnl

    pop  AF             ; 1:10      rot drop ( c b a -- b a )}){}dnl
dnl
dnl
dnl # ( f e d c b a -- d c b a f e )
dnl # vyjme treti 32-bit polozku a ulozi ji na vrchol
define({_2ROT},{dnl
__{}__ADD_TOKEN({__TOKEN_2ROT},{2rot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2ROT},{dnl
__{}define({__INFO},{2rot}){}dnl
ifelse(TYP_2ROT,{fast},{
                       ;[17:120]    2rot ( f e d c b a -- d c b a f e ) # fast version can be changed with "define({TYP_2ROT},{default})"
    pop  BC             ; 1:10      2rot f e d   . b a  BC = c
    exx                 ; 1:4       2rot f e d   . - R
    pop  BC             ; 1:10      2rot f e     . - R  BC'= d
    ld    A, H          ; 1:4       2rot
    ex   AF, AF'        ; 1:4       2rot
    ld    A, L          ; 1:4       2rot
    pop  HL             ; 1:10      2rot f       . - e
    pop  DE             ; 1:10      2rot         . f e
    push BC             ; 1:11      2rot d       . f e
    exx                 ; 1:4       2rot d       . b a
    push BC             ; 1:11      2rot d c     . b a
    push DE             ; 1:11      2rot d c b   . b a
    push HL             ; 1:11      2rot d c b a . b a
    ld    L, A          ; 1:4       2rot
    ex   AF, AF'        ; 1:4       2rot
    ld    H, A          ; 1:4       2rot d c b a . b R
    exx                 ; 1:4       2rot d c b a . f e},
{
                       ;[15:127]    2rot ( f e d c b a -- d c b a f e ) # default version can be changed with "define({TYP_2ROT},{fast})"
    exx                 ; 1:4       2rot f e d c .
    pop  DE             ; 1:10      2rot f e d   .      DE' = c
    pop  BC             ; 1:10      2rot f e     .      BC' = d
    exx                 ; 1:4       2rot f e     . b a
    ex  (SP),HL         ; 1:19      2rot f a     . b e
    pop  AF             ; 1:10      2rot f       . b e  AF = a
    pop  BC             ; 1:10      2rot         . b e  BC = f
    exx                 ; 1:4       2rot
    push BC             ; 1:11      2rot d       .
    push DE             ; 1:11      2rot d c     .
    exx                 ; 1:4       2rot d c     . b e
    push DE             ; 1:11      2rot d c b   . b e
    ld    D, B          ; 1:4       2rot
    ld    E, C          ; 1:4       2rot d c b   . f e
    push AF             ; 1:11      2rot d c b a . f e})}){}dnl
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
__{}define({__INFO},{nrot}){}dnl

                        ;[2:23]     nrot ( c b a -- a c b )
    ex  (SP),HL         ; 1:19      nrot a . b c
    ex   DE, HL         ; 1:4       nrot a . c b}){}dnl
dnl
dnl
dnl # -rot swap
dnl # ( c b a -- a b c )
dnl # prohodi hodnotu na vrcholu zasobniku s treti polozkou
define({NROT_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NROT_SWAP},{nrot_swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NROT_SWAP},{dnl
__{}define({__INFO},{nrot_swap}){}dnl

    ex  (SP),HL         ; 1:19      nrot_swap ( c b a -- a b c )}){}dnl
dnl
dnl
dnl # -rot nip
dnl # ( c b a -- a b )
dnl # Remove third item from stack and swap
define({NROT_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_NROT_NIP},{nrot_nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NROT_NIP},{dnl
__{}define({__INFO},{nrot_nip}){}dnl

    pop  AF             ; 1:10      nrot nip
    ex   DE, HL         ; 1:4       nrot nip ( c b a -- a b )}){}dnl
dnl
dnl
dnl # -rot 2swap
dnl # ( d c b a -- c b d a )
dnl # 4th --> 2th
define({NROT_2SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_NROT_2SWAP},{nrot_2swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NROT_2SWAP},{dnl
__{}define({__INFO},{nrot_2swap}){}dnl

                        ;[6:50]     nrot_2swap   ( d c b a -- c b d a )
    pop  AF             ; 1:10      nrot_2swap   d   . b a    AF = c
    ld    B, D          ; 1:4       nrot_2swap
    ld    C, E          ; 1:4       nrot_2swap                BC = b
    pop  DE             ; 1:10      nrot_2swap       . d a
    push AF             ; 1:11      nrot_2swap   c   . d a
    push BC             ; 1:11      nrot_2swap   c b . d a}){}dnl
dnl
dnl
dnl # nrot swap 2swap swap
dnl # ( d c b a -- b c a d )
define({STACK_BCAD},{dnl
__{}__ADD_TOKEN({__TOKEN_STACK_BCAD},{stack_bcad},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STACK_BCAD},{dnl
__{}define({__INFO},{stack_bcad}){}dnl

                        ;[4:44]     stack_bcad   ( d c b a -- b c a d )
    ex   DE, HL         ; 1:4       stack_bcad   d c a b
    pop  AF             ; 1:10      stack_bcad   AF = c
    ex  (SP), HL        ; 1:19      stack_bcad   b a d
    push AF             ; 1:11      stack_bcad   b c a d }){}dnl
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
__{}define({__INFO},{stack_cbabc}){}dnl

                        ;[6:51]     stack_cbabc   ( c b a -- c b a b c )
    pop  BC             ; 1:10      stack_cbabc   BC = c
    push BC             ; 1:11      stack_cbabc
    push DE             ; 1:11      stack_cbabc   c b b a
    push HL             ; 1:11      stack_cbabc   c b a b a
    ld    H, B          ; 1:4       stack_cbabc
    ld    L, C          ; 1:4       stack_cbabc   c b a b c}){}dnl
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
__{}define({__INFO},{stack_cbabac}){}dnl

                        ;[8:66]     stack_cbabc   ( c b a -- c b a b a c )
    pop  BC             ; 1:10      stack_cbabc   BC = c
    push BC             ; 1:11      stack_cbabc   c . . . b a
    push DE             ; 1:11      stack_cbabc   c b . . b a
    push HL             ; 1:11      stack_cbabc   c b a . b a
    push DE             ; 1:11      stack_cbabc   c b a b b a
    ex   DE, HL         ; 1:4       stack_cbabc   c b a b a b
    ld    H, B          ; 1:4       stack_cbabc   c b a b a -
    ld    L, C          ; 1:4       stack_cbabc   c b a b a c}){}dnl
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
__{}define({__INFO},{stack_cbaacb}){}dnl

                        ;[8:66]     stack_cbabc   ( c b a -- c b a a c b )
    pop  BC             ; 1:10      stack_cbabc   BC = c
    push BC             ; 1:11      stack_cbabc   c . . . b a
    push DE             ; 1:11      stack_cbabc   c b . . b a
    push HL             ; 1:11      stack_cbabc   c b a . b a
    push HL             ; 1:11      stack_cbabc   c b a a b a
    ex   DE, HL         ; 1:4       stack_cbabc   c b a a a b
    ld    D, B          ; 1:4       stack_cbabc   c b a a - b
    ld    E, C          ; 1:4       stack_cbabc   c b a a c b}){}dnl
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
__{}define({__INFO},{n2rot}){}dnl

                        ;[14:123]   n2rot   ( f e d c b a -- b a f e d c )
    pop  BC             ; 1:10      n2rot   f e d     . b a   BC = c
    pop  AF             ; 1:10      n2rot   f e       . b a   AF = d
    ex   AF, AF'        ; 1:4       n2rot   f e       . b a
    pop  AF             ; 1:10      n2rot   f         . b a   AF'= e
    ex   DE, HL         ; 1:4       n2rot   f         . a b
    ex  (SP),HL         ; 1:19      n2rot   b         . a f
    push DE             ; 1:11      n2rot   b a       . a f
    push HL             ; 1:11      n2rot   b a f     . a f
    push AF             ; 1:11      n2rot   b a f e   . a f
    ex   AF, AF'        ; 1:4       n2rot   b a f e   . a f
    push AF             ; 1:11      n2rot   b a f e d . a f
    pop  DE             ; 1:10      n2rot   b a f e   . d f
    ld    H, B          ; 1:4       n2rot   b a f e   . d -
    ld    L, C          ; 1:4       n2rot   b a f e   . d c}){}dnl
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
__{}define({__INFO},{dup $1}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      dup $1
    push HL             ; 1:11      dup $1
    ex   DE, HL         ; 1:4       dup $1
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      dup $1}){}dnl
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
__{}__ADD_TOKEN({__TOKEN_PUSHDOT},{pushdot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT},{dnl
__{}define({__INFO},{pushdot}){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      pushdot($1)   ( -- hi lo )
__{}    push HL             ; 1:11      pushdot($1)
__{}    ld   DE,format({%-12s},($1+2)); 4:20      pushdot($1)   hi word
__{}    ld   HL, format({%-11s},$1); 3:16      pushdot($1)   lo word},
{
__{}define({__DE},__HEX_DE($1)){}dnl
__{}define({__HL},__HEX_HL($1)){}dnl
__{}    push DE             ; 1:11      pushdot($1)   ( -- hi lo )
__{}    push HL             ; 1:11      pushdot($1){}dnl
__{}define({_TMP_INFO},{pushdot($1)}){}dnl # HL first check
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
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_2SWAP},{pushdot_2swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_2SWAP},{dnl
__{}define({__INFO},{pushdot_2swap}){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__IS_MEM_REF($1),{1},{
__{}    ld   BC,format({%-12s},($1+2)); 4:20      pushdot_2swap($1)   hi word
__{}    push BC             ; 1:11      pushdot_2swap($1){}dnl
__{}    ld   BC, format({%-11s},$1); 4:20      pushdot_2swap($1)   lo word
__{}    push BC             ; 1:11      pushdot_2swap($1)},
{
__{}define({__DE},__HEX_DE($1)){}dnl
__{}define({__HL},__HEX_HL($1)){}dnl
__{}define({_TMP_INFO},{pushdot_2swap($1)   hi word}){}dnl
__{}__LD_REG16({BC},__DE){}dnl
__{}__CODE_16BIT
__{}    push BC             ; 1:11      pushdot_2swap($1){}dnl
__{}define({_TMP_INFO},{pushdot_2swap($1)   lo word}){}dnl
__{}__LD_REG16({BC},__HL,{BC},__DE){}dnl
__{}__CODE_16BIT
__{}    push BC             ; 1:11      pushdot_2swap($1){}dnl
})}){}dnl
dnl
dnl
dnl # 2 pick ( c b a -- c b a c )
define({_2_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_2_PICK},{2_pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2_PICK},{dnl
__{}define({__INFO},{2_pick}){}dnl

__{}__{}                       ;[ 6:44]     2 pick
__{}__{}    pop  BC             ; 1:10      2 pick
__{}__{}    push BC             ; 1:11      2 pick
__{}__{}    push DE             ; 1:11      2 pick
__{}__{}    ex   DE, HL         ; 1:4       2 pick
__{}__{}    ld    H, B          ; 1:4       2 pick
__{}__{}    ld    L, C          ; 1:4       2 pick ( c b a -- c b a c )}){}dnl
dnl
dnl
dnl # 2 pick ( c b a -- c b a c b )
define({_2_PICK_2_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_2_PICK_2_PICK},{2_pick_2_pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2_PICK_2_PICK},{dnl
__{}define({__INFO},{2_pick_2_pick}){}dnl

__{}__{}                       ;[ 7:55]     2 pick 2 pick
__{}__{}    pop  BC             ; 1:10      2 pick 2 pick
__{}__{}    push BC             ; 1:11      2 pick 2 pick   BC = c
__{}__{}    push DE             ; 1:11      2 pick 2 pick
__{}__{}    push HL             ; 1:11      2 pick 2 pick
__{}__{}    ex   DE, HL         ; 1:4       2 pick 2 pick
__{}__{}    ld    D, B          ; 1:4       2 pick 2 pick
__{}__{}    ld    E, C          ; 1:4       2 pick 2 pick ( c b a -- c b a c b )}){}dnl
dnl
dnl
dnl # 3 pick ( d c b a -- d c b a d )
define({_3_PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_3_PICK},{3_pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3_PICK},{dnl
__{}define({__INFO},{3_pick}){}dnl

__{}__{}                       ;[ 8:65]     3 pick
__{}__{}    pop  AF             ; 1:10      3 pick
__{}__{}    pop  BC             ; 1:10      3 pick
__{}__{}    push BC             ; 1:11      3 pick
__{}__{}    push AF             ; 1:11      3 pick
__{}__{}    push DE             ; 1:11      3 pick
__{}__{}    ex   DE, HL         ; 1:4       3 pick
__{}__{}    ld    H, B          ; 1:4       3 pick
__{}__{}    ld    L, C          ; 1:4       3 pick ( d c b a -- d c b a d )}){}dnl
dnl
dnl
dnl # ( ...n3 n2 n1 n0 x -- ...n3 n2 n1 n0 nx )
dnl # Remove x. Copy the nx to the top of the stack.
define({PICK},{dnl
__{}__ADD_TOKEN({__TOKEN_PICK},{pick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PICK},{dnl
__{}define({__INFO},{pick}){}dnl
ifelse($#,{0},,{
.error pick: Unexpected parameter $@, pick uses a parameter from the stack!})
    push DE             ; 1:11      pick
    add  HL, HL         ; 1:11      pick
    add  HL, SP         ; 1:11      pick
    ld    E,(HL)        ; 1:7       pick
    inc  HL             ; 1:6       pick
    ld    D,(HL)        ; 1:7       pick
    ex   DE, HL         ; 1:4       pick
    pop  DE             ; 1:10      pick}){}dnl
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
__{}    push DE             ; 1:11      $1 pick
__{}    push HL             ; 1:11      $1 pick
__{}    ld   HL, format({%-11s},$1); 3:16      $1 pick
__{}    add  HL, HL         ; 1:11      $1 pick
__{}    add  HL, SP         ; 1:11      $1 pick
__{}    ld    E,(HL)        ; 1:7       $1 pick
__{}    inc  HL             ; 1:6       $1 pick
__{}    ld    D,(HL)        ; 1:7       $1 pick
__{}    ex   DE, HL         ; 1:4       $1 pick
__{}    pop  DE             ; 1:10      $1 pick},
__IS_NUM($1),{0},{
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}    push DE             ; 1:11      $1 pick
__{}    push HL             ; 1:11      $1 pick
__{}    ld   HL, format({%-11s},$1); 3:10      $1 pick
__{}    add  HL, HL         ; 1:11      $1 pick
__{}    add  HL, SP         ; 1:11      $1 pick
__{}    ld    E,(HL)        ; 1:7       $1 pick
__{}    inc  HL             ; 1:6       $1 pick
__{}    ld    D,(HL)        ; 1:7       $1 pick
__{}    ex   DE, HL         ; 1:4       $1 pick
__{}    pop  DE             ; 1:10      $1 pick},
{dnl
__{}ifelse(dnl
__{}eval($1),{0},{__ASM_TOKEN_DUP},
__{}eval($1),{1},{__ASM_TOKEN_OVER},
__{}eval($1),{2},{__ASM_TOKEN_2_PICK},
__{}eval($1),{3},{__ASM_TOKEN_3_PICK},
__{}{
__{}__{}                       ;[10:60]     $1 pick
__{}__{}    push DE             ; 1:11      $1 pick
__{}__{}    ex   DE, HL         ; 1:4       $1 pick
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      $1 pick
__{}__{}    add  HL, SP         ; 1:11      $1 pick
__{}__{}    ld    A,(HL)        ; 1:7       $1 pick
__{}__{}    inc  HL             ; 1:6       $1 pick
__{}__{}    ld    H,(HL)        ; 1:7       $1 pick
__{}__{}    ld    L, A          ; 1:4       $1 pick ( ...x2 x1 x0 -- ...x2 x1 x0 x$1 )})})}){}dnl
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
__{}__{}    ld   HL, __HEX_HL(2*($1)-2)     ; 3:10      __INFO
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
__{}    ld   HL, format({%-11s},$1); 3:10      __INFO
__{}    add  HL, HL         ; 1:11      __INFO
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
define({__ASM_TOKEN_DEPTH},{dnl
__{}define({__INFO},{depth}){}dnl

                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    srl   H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth}){}dnl
dnl
dnl
dnl
dnl # ------------- return address stack ------------------
dnl
dnl # >r
dnl # ( x -- ) ( R: -- x )
dnl # Move x to the return stack.
define({TO_R},{dnl
__{}__ADD_TOKEN({__TOKEN_TO_R},{to_r},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TO_R},{dnl
__{}define({__INFO},{to_r}){}dnl

                        ;[9:65]     to_r   ( c b a -- c b ) ( R: -- a )
    ex  (SP), HL        ; 1:19      to_r   a . b c
    ex   DE, HL         ; 1:4       to_r   a . c b
    exx                 ; 1:4       to_r
    pop  DE             ; 1:10      to_r
    dec  HL             ; 1:6       to_r
    ld  (HL),D          ; 1:7       to_r
    dec   L             ; 1:4       to_r
    ld  (HL),E          ; 1:7       to_r
    exx                 ; 1:4       to_r}){}dnl
dnl
dnl
dnl # dup >r
dnl # ( x -- x ) ( R: -- x )
dnl # Copy x to the return stack.
define({DUP_TO_R},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_TO_R},{dup_to_r},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_TO_R},{dnl
__{}define({__INFO},{dup_to_r}){}dnl

                        ;[8:53]     dup_to_r   ( a -- a ) ( R: -- a )
    push HL             ; 1:11      dup_to_r
    exx                 ; 1:4       dup_to_r
    pop  DE             ; 1:10      dup_to_r
    dec  HL             ; 1:6       dup_to_r
    ld  (HL),D          ; 1:7       dup_to_r
    dec   L             ; 1:4       dup_to_r
    ld  (HL),E          ; 1:7       dup_to_r
    exx                 ; 1:4       dup_to_r}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl

                      ;[21:82+u*47] n>r   ( xu .. x2 x1 u -- ) ( R: -- x1 x2 .. xu u )
    push DE             ; 1:11      n>r
    ld    A, L          ; 1:4       n>r   u = 0..255
    exx                 ; 1:4       n>r
    or    A             ; 1:4       n>r
    ld    B, A          ; 1:4       n>r
    jr    z, $+9        ; 2:12      n>r
    pop  DE             ; 1:10      n>r
    dec  HL             ; 1:6       n>r
    ld  (HL),D          ; 1:7       n>r
    dec   L             ; 1:4       n>r
    ld  (HL),E          ; 1:7       n>r
    djnz $-5            ; 2:8/13    n>r
    dec  HL             ; 1:6       n>r
    ld  (HL),B          ; 1:7       n>r   = 0
    dec   L             ; 1:4       n>r
    ld  (HL),A          ; 1:7       n>r   = lo(u)
    exx                 ; 1:4       n>r
    pop  HL             ; 1:10      n>r
    pop  DE             ; 1:10      n>r}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl

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
    ld    A, low format({%-7s},$1); 2:7       __INFO   0..255
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
__{}ifelse(__HEX_H(($1+1)/2),{0x00},,{
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
    ld    A, format({%-11s},$1); 2:7       __INFO   0..255
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
__{}__ADD_TOKEN({__TOKEN_R_FROM},{r_from},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_R_FROM},{dnl
__{}define({__INFO},{r_from}){}dnl

                        ;[9:66]     r_from ( b a -- b a i ) ( R: i -- )
    exx                 ; 1:4       r_from
    ld    E,(HL)        ; 1:7       r_from
    inc   L             ; 1:4       r_from
    ld    D,(HL)        ; 1:7       r_from
    inc  HL             ; 1:6       r_from
    push DE             ; 1:11      r_from
    exx                 ; 1:4       r_from i . b a
    ex   DE, HL         ; 1:4       r_from i . a b
    ex  (SP), HL        ; 1:19      r_from b . a i}){}dnl
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

                      ;[22:74+u*48] nr>   ( -- xu .. x2 x1 u ) ( R: x1 x2 .. xu u -- )
    push DE             ; 1:11      nr>
    push HL             ; 1:11      nr>
    exx                 ; 1:4       nr>
    ld    A,(HL)        ; 1:7       nr>
    inc   L             ; 1:4       nr>
    inc  HL             ; 1:6       nr>
    or    A             ; 1:4       nr>   u = 0..255
    jr    z, $+10       ; 2:7/12    nr>
    ld    B, A          ; 1:4       nr>
    ld    E,(HL)        ; 1:7       nr>
    inc   L             ; 1:4       nr>
    ld    D,(HL)        ; 1:7       nr>
    inc  HL             ; 1:6       nr>
    push DE             ; 1:11      nr>
    djnz $-5            ; 2:8/13    nr>
    exx                 ; 1:4       nr>
    ld    L, A          ; 1:4       nr>
    ld    H, 0x00       ; 2:7       nr>
    pop  DE             ; 1:10      nr>}){}dnl
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
    ld    A, format({%-11s},$1); 2:7       __INFO   0..255
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
    ld   BC, format({%-11s},2*($1)); 3:10      __INFO   2*($1)
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
    ld   HL, format({%-11s},2*($1)); 3:10      __INFO
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
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),1,{3:16},{3:10})      __INFO
    ex   DE, HL         ; 1:4       __INFO},
__IS_NUM($2),{0},{
                       ;[16:ifelse(__IS_MEM_REF($1),1,108,102)]    __INFO   ( -- $1 x_{}$2 ) ( R: x_{}$2 .. x1 x0 -- x_{}$2 .. x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    ld   BC, format({%-11s},2*($2)); 3:10      __INFO   $2+$2
    add  HL, BC         ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = x_{}$2
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),1,{3:16},{3:10})      __INFO
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
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),1,{3:16},{3:10})      __INFO
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
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),1,{3:16},{3:10})      __INFO
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
    ld  (HL),format({%-11s},low $1); 2:10      __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),format({%-11s},high $1); 2:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
__IS_NUM($2),{0},{
                       ;[17:85]     __INFO   ( -- ) ( R: x_{}$2 .. x1 x0 -- x_{}$2 .. x1 x0 )
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, format({%-11s},2*($2)); 3:10      __INFO   $2+$2
    add  HL, DE         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld  (HL),format({%-11s},low $1); 2:10      __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),format({%-11s},high $1); 2:10      __INFO
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
    ld  (HL),format({%-11s},low $1); 2:10      __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),format({%-11s},high $1); 2:10      __INFO
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
    ld  (HL),format({%-11s},low $1); 2:10      __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),format({%-11s},high $1); 2:10      __INFO
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
    ld   HL, format({%-11s},2*($2)); 3:10      __INFO   $2+$2
    add  HL, DE         ; 1:11      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld  (HL),format({%-11s},low $1); 2:10      __INFO
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
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),1,{3:16},{3:10})      __INFO},
__IS_NUM($1),{0},{
                       ;ifelse(__IS_MEM_REF($2),1,[15:104],[15:98] )    __INFO   ( -- x_{}$1 $2 ) ( R: x_{}$1 .. x1 x0 -- x_{}$1 .. x1 x0 )
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    push HL             ; 1:11      __INFO   ras
    exx                 ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO   ras
    ld   BC, format({%-11s},2*($1)); 3:10      __INFO   $1+$1
    add  HL, BC         ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = x_{}$1
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),1,{3:16},{3:10})      __INFO},
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
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),1,{3:16},{3:10})      __INFO},
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
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),1,{3:16},{3:10})      __INFO},
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
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),1,{3:16},{3:10})      __INFO}){}dnl
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
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),1,{3:16},{3:10})      __INFO
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
    ld  (HL),format({%-11s},low $1); 2:10      __INFO   lo
    inc  HL             ; 1:6       __INFO
    ld  (HL),format({%-11s},high $1); 2:10      __INFO   hi
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
    ld    A,format({%-12s},low $1); 2:7       __INFO   lo
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
__{}define({__INFO},{rdrop}){}dnl

                        ;[4:18]     rdrop
    exx                 ; 1:4       rdrop
    inc   L             ; 1:4       rdrop
    inc   HL            ; 1:6       rdrop
    exx                 ; 1:4       rdrop r:( a -- )}){}dnl
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
__{}define({__INFO},{rswap}){}dnl

                        ;[14:86]    rswap ( R: j i -- i j )
    exx                 ; 1:4       rswap
    ld  ($+10), SP      ; 4:20      rswap
    ld   SP, HL         ; 1:6       rswap
    pop  DE             ; 1:10      rswap
    pop  AF             ; 1:10      rswap
    push DE             ; 1:11      rswap
    push AF             ; 1:11      rswap
    ld   SP, 0x0000     ; 3:10      rswap
    exx                 ; 1:4       rswap}){}dnl
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
__{}__ADD_TOKEN({__TOKEN_2TO_R},{2to_r},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2TO_R},{dnl
__{}define({__INFO},{2to_r}){}dnl

                        ;[15:116]   _2to_r ( d c b a -- d c ) ( R: -- b a )
    ex  (SP), HL        ; 1:19      _2to_r d a   . b c
    push DE             ; 1:11      _2to_r d a b . b c
    exx                 ; 1:4       _2to_r d a b .
    pop  DE             ; 1:10      _2to_r d a   . b
    dec  HL             ; 1:6       _2to_r
    ld  (HL),D          ; 1:7       _2to_r
    dec   L             ; 1:4       _2to_r
    ld  (HL),E          ; 1:7       _2to_r              ( R: b )
    pop  DE             ; 1:10      _2to_r d     . a
    dec  HL             ; 1:6       _2to_r
    ld  (HL),D          ; 1:7       _2to_r
    dec   L             ; 1:4       _2to_r
    ld  (HL),E          ; 1:7       _2to_r              ( R: b a )
    exx                 ; 1:4       _2to_r d     . b c
    pop  DE             ; 1:10      _2to_r       . d c}){}dnl
dnl
dnl
dnl # 2r>
dnl # r> r> swap
dnl # ( -- x1 x2 ) ( R: x1 x2 -- )
dnl # Transfer cell pair x1 x2 from the return stack.
define({_2R_FROM},{dnl
__{}__ADD_TOKEN({__TOKEN_2R_FROM},{2r_from},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2R_FROM},{dnl
__{}define({__INFO},{2r_from}){}dnl

                        ;[15:118]   _2r_from ( b a -- b a j i ) ( R: j i -- )
    push DE             ; 1:11      _2r_from b     . b a
    exx                 ; 1:4       _2r_from b     .
    ld    E,(HL)        ; 1:7       _2r_from
    inc   L             ; 1:4       _2r_from
    ld    D,(HL)        ; 1:7       _2r_from
    inc  HL             ; 1:6       _2r_from            ( R: j )
    push DE             ; 1:11      _2r_from b i   .
    ld    E,(HL)        ; 1:7       _2r_from
    inc   L             ; 1:4       _2r_from
    ld    D,(HL)        ; 1:7       _2r_from
    inc  HL             ; 1:6       _2r_from            ( R : )
    push DE             ; 1:11      _2r_from b i j .
    exx                 ; 1:4       _2r_from b i j . b a
    pop  DE             ; 1:10      _2r_from b i   . j a
    ex  (SP), HL        ; 1:19      _2r_from b a   . j i}){}dnl
dnl
dnl
dnl # 2r@
dnl # r> r> 2dup >r >r swap
dnl # ( -- x1 x2 ) ( R: x1 x2 -- x1 x2 )
dnl # Copy cell pair x1 x2 from the return stack.
define({_2R_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_2R_FETCH},{2r_fetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2R_FETCH},{dnl
__{}define({__INFO},{2r_fetch}){}dnl

                        ;[14:99]    _2r_fetch ( b a -- b a j i ) ( R: j i -- j i )
    push DE             ; 1:11      _2r_fetch b   . b a
    exx                 ; 1:4       _2r_fetch b   .
    push HL             ; 1:11      _2r_fetch b r .
    exx                 ; 1:4       _2r_fetch b r . b a
    ex  (SP), HL        ; 1:19      _2r_fetch b a . b r     HL = r.a.s.
    ld    E,(HL)        ; 1:7       _2r_fetch
    inc   L             ; 1:4       _2r_fetch
    ld    D,(HL)        ; 1:7       _2r_fetch
    inc  HL             ; 1:6       _2r_fetch b a . i r
    ld    A,(HL)        ; 1:7       _2r_fetch
    inc   L             ; 1:4       _2r_fetch
    ld    H,(HL)        ; 1:7       _2r_fetch
    ld    L, A          ; 1:4       _2r_fetch b a . i j
    ex   DE, HL         ; 1:4       _2r_fetch b a . j i}){}dnl
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
__{}define({__INFO},{2rdrop}){}dnl

                        ;[6:28]     _2rdrop
    exx                 ; 1:4       _2rdrop
    inc   L             ; 1:4       _2rdrop
    inc   HL            ; 1:6       _2rdrop
    inc   L             ; 1:4       _2rdrop
    inc   HL            ; 1:6       _2rdrop
    exx                 ; 1:4       _2rdrop r:( x1 x2 -- )}){}dnl
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
__{}define({__INFO},{2rswap}){}dnl

                        ;[19:134]   rswap ( R: l k j i -- j i l k )
    exx                 ; 1:4       rswap
    ld  ($+14), SP      ; 4:20      rswap
    ld   SP, HL         ; 1:6       rswap
    ex   DE, HL         ; 1:4       rswap l  k  j  i
    pop  BC             ; 1:10      rswap l  k  j  BC
    pop  HL             ; 1:10      rswap l  k  HL
    pop  AF             ; 1:10      rswap l  AF
    ex  (SP),HL         ; 1:19      rswap j     HL=l
    push BC             ; 1:11      rswap j  i
    push HL             ; 1:11      rswap j  i  l
    push AF             ; 1:11      rswap j  i  l  k
    ld   SP, 0x0000     ; 3:10      rswap
    ex   DE, HL         ; 1:4       rswap
    exx                 ; 1:4       rswap}){}dnl
dnl
dnl
dnl

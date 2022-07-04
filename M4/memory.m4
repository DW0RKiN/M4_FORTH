define({__},{})dnl
dnl
dnl
define({ALL_VARIABLE},{})dnl
dnl
dnl
define({CONSTANT},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}format({%-20s},$1) EQU $2{}dnl
__{}define({$1},{$2})})dnl
dnl
dnl
define({CVARIABLE},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}ifelse($1,{},{.error cvariable: Missing parameter with variable name!}dnl
__{},$#,{1},{$1: db 0x00{}}dnl
__{},{$1: db $2{}})dnl
})})dnl
dnl
dnl
dnl # DVARIABLE(name)        --> (name) = 0
dnl # DVARIABLE(name,100)    --> (name) = 100
dnl # DVARIABLE(name,0x88442211)    --> (name) = 0x88442211
define({DVARIABLE},{ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval(($#==2) && ifelse(eval($2),{},{1},{0})),{1},{
__{}  .error {$0}($@): M4 does not know $2 parameter value!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
{define({ALL_VARIABLE},ALL_VARIABLE{
__{}ifelse($#,{1},{$1:
__{}  dw 0x0000
__{}  dw 0x0000},
__{}{format({%-24s},$1:); = $2{}dnl
__{} = ifelse(substr($2,0,2),{0x},eval($2),__HEX_DEHL($2)){}dnl
__{} = db __HEX_L($2) __HEX_H($2) __HEX_E($2) __HEX_D($2)
__{}  dw __HEX_HL($2)             ; = eval(($2) & 0xffff)
__{}  dw __HEX_DE($2)             ; = eval((($2) >> 16) & 0xffff)})dnl
})})})dnl
dnl
dnl
dnl
dnl # VARIABLE(name)        --> (name) = 0
dnl # VARIABLE(name,100)    --> (name) = 100
dnl # VARIABLE(name,0x2211) --> (name) = 0x2211
define({VARIABLE},{ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
$#,{1},{dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}$1: dw 0x0000})},
{dnl
__{}ifelse(eval($2),{},{
__{}  .warning {$0}($@): M4 does not know $2 parameter value!}){}dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$1: dw $2})})}){}dnl
dnl
dnl
dnl -------------------------------------------------------------------------------------
dnl ## Memory access 8bit
dnl -------------------------------------------------------------------------------------
dnl
dnl C@
dnl ( addr -- char )
dnl fetch 8-bit char from addr
define({CFETCH},{
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch})dnl
dnl
dnl
dnl dup C@
dnl ( addr -- addr char )
dnl save addr and fetch 8-bit number from addr
define({DUP_CFETCH},{
                        ;[5:29]     dup C@ dup_cfetch ( addr -- addr char )
    push DE             ; 1:11      dup C@ dup_cfetch
    ld    E,(HL)        ; 1:7       dup C@ dup_cfetch
    ld    D, 0x00       ; 2:7       dup C@ dup_cfetch
    ex   DE, HL         ; 1:4       dup C@ dup_cfetch})dnl
dnl
dnl
dnl dup C@ swap
dnl ( addr -- char addr )
dnl save addr and fetch 8-bit number from addr and swap
define({DUP_CFETCH_SWAP},{
                        ;[4:25]     dup C@ swap dup_cfetch_swap ( addr -- char addr )
    push DE             ; 1:11      dup C@ swap dup_cfetch_swap
    ld    E,(HL)        ; 1:7       dup C@ swap dup_cfetch_swap
    ld    D, 0x00       ; 2:7       dup C@ swap dup_cfetch_swap})dnl
dnl
dnl
dnl C@ swap C@
dnl ( addr2 addr1 -- char1 char2 )
dnl double fetch 8-bit number and swap
define({CFETCH_SWAP_CFETCH},{
                        ;[6:29]     @C swap @C cfetch_swap_cfetch ( addr2 addr1 -- char1 char2 )
    ld    L,(HL)        ; 1:7       @C swap @C cfetch_swap_cfetch
    ld    H, 0x00       ; 2:7       @C swap @C cfetch_swap_cfetch
    ex   DE, HL         ; 1:4       @C swap @C cfetch_swap_cfetch
    ld    L,(HL)        ; 1:7       @C swap @C cfetch_swap_cfetch
    ld    H, D          ; 1:4       @C swap @C cfetch_swap_cfetch})dnl
dnl
dnl
dnl C@ swap C@ swap
dnl ( addr2 addr1 -- char1 char2 )
dnl double fetch 8-bit number
define({CFETCH_SWAP_CFETCH_SWAP},{
                        ;[6:29]     @C swap @C swap cfetch_swap_cfetch_swap ( addr2 addr1 -- char2 char1 )
    ld    L, (HL)       ; 1:7       @C swap @C swap cfetch_swap_cfetch_swap
    ld    H, 0x00       ; 2:7       @C swap @C swap cfetch_swap_cfetch_swap
    ld    A, (DE)       ; 1:7       @C swap @C swap cfetch_swap_cfetch_swap
    ld    E, A          ; 1:4       @C swap @C swap cfetch_swap_cfetch_swap
    ld    D, H          ; 1:4       @C swap @C swap cfetch_swap_cfetch_swap})dnl
dnl
dnl
dnl over C@ over C@
dnl ( addr2 addr1 -- addr2 addr1 char2 char1 )
dnl double fetch 8-bit number with save address
define({OVER_CFETCH_OVER_CFETCH},{
                        ;[8:51]     over @C over @C over_cfetch_over_cfetch ( addr2 addr1 -- addr2 addr1 char2 char1 )
    push DE             ; 1:11      over @C over @C over_cfetch_over_cfetch
    push HL             ; 1:11      over @C over @C over_cfetch_over_cfetch
    ld    L, (HL)       ; 1:7       over @C over @C over_cfetch_over_cfetch
    ld    H, 0x00       ; 2:7       over @C over @C over_cfetch_over_cfetch
    ld    A, (DE)       ; 1:7       over @C over @C over_cfetch_over_cfetch
    ld    E, A          ; 1:4       over @C over @C over_cfetch_over_cfetch
    ld    D, H          ; 1:4       over @C over @C over_cfetch_over_cfetch})dnl
dnl
dnl
dnl
dnl addr C@
dnl ( -- x )
dnl push_cfetch(addr), load 8-bit char from addr
define({PUSH_CFETCH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 @  push_cfetch($1)
    ex   DE, HL         ; 1:4       $1 @  push_cfetch($1)
    ld   HL,format({%-12s},($1)); 3:16      $1 @  push_cfetch($1)
    ld    H, 0x00       ; 2:7       $1 @  push_cfetch($1)})dnl
dnl
dnl
dnl
dnl addr C@ x
dnl ( -- (addr) x )
dnl push_cfetch_push(addr,x), load 8-bit char from addr and push x
define({PUSH_CFETCH_PUSH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address and second parameter!},
__{}$#,{1},{
__{}__{}.error {$0}():  The second parameter is missing!},
__{}$#,{2},{
    push DE             ; 1:11      $1 @ $2  push_cfetch_push($1,$2)
    push HL             ; 1:11      $1 @ $2  push_cfetch_push($1,$2)
    ld    A,format({%-12s},($1)); 3:13      $1 @ $2  push_cfetch_push($1,$2)
    ld    D, 0x00       ; 2:7       $1 @ $2  push_cfetch_push($1,$2)
    ld    E, A          ; 1:4       $1 @ $2  push_cfetch_push($1,$2)
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{3:16},{3:10})      $1 @ $2  push_cfetch_push($1,$2)},
__{}__{}.error {$0}($@): $# parameters found in macro!)}){}dnl
dnl
dnl
dnl
dnl addr C@ x
dnl ( -- (addr) x )
dnl push2_cfetch(x,addr), push x and load 8-bit char from addr
define({PUSH2_CFETCH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address and second parameter!},
__{}$#,{1},{
__{}__{}.error {$0}():  The second parameter is missing!},
__{}$#,{2},{
    push DE             ; 1:11      $1 $2 @  push2_cfetch($1,$2)
    push HL             ; 1:11      $1 $2 @  push2_cfetch($1,$2)
    ld   DE, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 $2 @  push2_cfetch($1,$2)
    ld   HL,format({%-12s},($2)); 3:16      $1 $2 @  push2_cfetch($1,$2)
    ld    H, 0x00       ; 2:7       $1 $2 @  push2_cfetch($1,$2)},
__{}__{}.error {$0}($@): $# parameters found in macro!)}){}dnl
dnl
dnl
dnl
dnl addr C@ +
dnl ( x -- x+(addr) )
dnl push_cfetch(addr), add 8-bit char from addr
define({PUSH_CFETCH_ADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld    A,format({%-12s},($1)); 3:13      $1 @ +  push_cfetch_add($1)   ( x -- x+($1) )
    add   A, L          ; 1:4       $1 @ +  push_cfetch_add($1)
    ld    L, A          ; 1:4       $1 @ +  push_cfetch_add($1)
    adc   A, H          ; 1:4       $1 @ +  push_cfetch_add($1)
    sub   L             ; 1:4       $1 @ +  push_cfetch_add($1)
    ld    H, A          ; 1:4       $1 @ +  push_cfetch_add($1)})dnl
dnl
dnl
dnl
dnl addr C@ -
dnl ( x -- x-(addr) )
dnl push_cfetch(addr), sub 8-bit char from addr
define({PUSH_CFETCH_SUB},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld    A,format({%-12s},($1)); 3:13      $1 @ -  push_cfetch_sub($1)   ( x -- x-($1) )
    ld    B, A          ; 1:4       $1 @ -  push_cfetch_sub($1)
    ld    A, L          ; 1:4       $1 @ -  push_cfetch_sub($1)
    sub   B             ; 1:4       $1 @ -  push_cfetch_sub($1)
    ld    L, A          ; 1:4       $1 @ -  push_cfetch_sub($1)
    sbc   A, A          ; 1:4       $1 @ -  push_cfetch_sub($1)
    adc   A, H          ; 1:4       $1 @ -  push_cfetch_sub($1)
    ld    H, A          ; 1:4       $1 @ -  push_cfetch_sub($1)})dnl
dnl
dnl
dnl
dnl C!
dnl ( char addr -- )
dnl store 8-bit char at addr
define({CSTORE},{
    ld  (HL),E          ; 1:7       C! cstore   ( char addr -- )
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore})dnl
dnl
dnl
dnl addr C!
dnl ( char -- )
dnl store(addr) store 8-bit char at addr
define({PUSH_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld    A, L          ; 1:4       $1 C! push($1) cstore
    ld   format({%-15s},($1){,} A); 3:13      $1 C! push($1) cstore
    ex   DE, HL         ; 1:4       $1 C! push($1) cstore
    pop  DE             ; 1:10      $1 C! push($1) cstore})dnl
dnl
dnl
dnl addr swap n C!
dnl ( addr -- )
dnl store(addr) store 8-bit char at addr
define({PUSH_SWAP_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 swap C! push_swap_cstore($1)   ( addr -- )
    ld  (HL),A          ; 1:7       $1 swap C! push_swap_cstore($1)
    ex   DE, HL         ; 1:4       $1 swap C! push_swap_cstore($1)
    pop  DE             ; 1:10      $1 swap C! push_swap_cstore($1)})dnl
dnl
dnl
dnl n --> n char addr+n -- n )
dnl ( n -- )
dnl store(addr) store 8-bit char at addr
define({PUSH_OVER_PUSH_ADD_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
__{}$#,{2},{ifelse(__IS_MEM_REF($2),{1},{
    ld    B, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- )
    ld    C, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld   HL, format({%-11s},$2); 3:16      $1 over $2 add C! push_over_push_add_cstore($1,$2)
    add  HL, BC         ; 1:11      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ld    A, format({%-11s},$1); 3:13      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld  (HL),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}dnl
__{},{dnl
__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over $2 add C! push_over_push_add_cstore($1,$2)})
    ld    H, B          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld    L, C          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)}
,eval($2),,{
    .warning {$0}($1,$2): M4 does not know $2 parameter value!
    ld    A, low format({%-7s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- )
    add   A, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld    C, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld    A, high format({%-6s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    adc   A, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld    B, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld  (BC),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}
,{dnl
__{}ifelse(eval($2),0,{
__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}__{}    ld  (HL),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}dnl
__{}__{},{dnl
__{}__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over $2 add C! push_over_push_add_cstore($1,$2)})},
__{}eval($2),1,{
__{}    inc  HL             ; 1:6       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}__{}    ld  (HL),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}dnl
__{}__{},{dnl
__{}__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over $2 add C! push_over_push_add_cstore($1,$2)})
__{}    dec  HL             ; 1:6       $1 over $2 add C! push_over_push_add_cstore($1,$2)},
__{}eval($2),-1,{
__{}    dec  HL             ; 1:6       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}__{}    ld  (HL),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}dnl
__{}__{},{dnl
__{}__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over $2 add C! push_over_push_add_cstore($1,$2)})
__{}    inc  HL             ; 1:6       $1 over $2 add C! push_over_push_add_cstore($1,$2)},
__{}eval(($2) & 0xFF00),0,{
__{}    ld    A, low format({%-7s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- )
__{}    add   A, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    C, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    adc   A, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    sub   C             ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    B, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld  (BC),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)},
__{}eval(($2) & 0xFF),0,{
__{}    ld    C, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- )
__{}    ld    A, high format({%-6s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    add   A, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    B, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld  (BC),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)},
__{}{
__{}    ld    A, low format({%-7s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- )
__{}    add   A, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    C, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    A, high format({%-6s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    adc   A, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    B, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld  (BC),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)})})},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})})dnl
dnl
dnl
dnl addr C!
dnl ( char -- char )
dnl store(addr) store 8-bit char at addr
define({DUP_PUSH_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld    A, L          ; 1:4       dup $1 C! dup push($1) cstore
    ld   format({%-15s},($1){,} A); 3:13      dup $1 C! dup push($1) cstore})dnl
dnl
dnl
dnl addr C!
dnl ( char -- char )
dnl store(addr) store 8-bit char at addr
define({DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
__{}$#,{2},{
    ld    A, L          ; 1:4       dup $1 C! dup $2 C! dup push($1) cstore dup push($2) cstore
    ld   format({%-15s},($1){,} A); 3:13      dup $1 C! dup $2 C! dup push($1) cstore dup push($2) cstore
    ld   format({%-15s},($2){,} A); 3:13      dup $1 C! dup $2 C! dup push($1) cstore dup push($2) cstore},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})})dnl
dnl
dnl
dnl addr C!
dnl ( char -- char )
dnl store(addr) store 8-bit char at addr
define({DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
$3,{},{
__{}__{}.error {$0}(): Missing third address parameter!},
__{}$#,{3},{
    ld    A, L          ; 1:4       dup $1 C! dup $2 C! dup $3 C!   dup push($1) cstore dup push($2) cstore dup push($3) cstore
    ld   format({%-15s},($1){,} A); 3:13      dup $1 C! dup $2 C! dup $3 C!   dup push($1) cstore dup push($2) cstore dup push($3) cstore
    ld   format({%-15s},($2){,} A); 3:13      dup $1 C! dup $2 C! dup $3 C!   dup push($1) cstore dup push($2) cstore dup push($3) cstore
    ld   format({%-15s},($3){,} A); 3:13      dup $1 C! dup $2 C! dup $3 C!   dup push($1) cstore dup push($2) cstore dup push($3) cstore},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})})dnl
dnl
dnl
dnl
dnl char addr C!
dnl ( -- )
dnl store(addr) store 8-bit number at addr
define({PUSH2_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld    A, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:13},{2:7 })      push2_cstore($1,$2)
    ld   format({%-15s},($2){,} A); 3:13      push2_cstore($1,$2)})dnl
dnl
dnl
dnl
dnl
dnl tuck C!
dnl ( char addr -- addr )
dnl store 8-bit number at addr with save addr
define({TUCK_CSTORE},{
                        ;[2:17]     tuck c!  tuck_cstore   ( char addr -- addr )
    ld  (HL),E          ; 1:7       tuck c!  tuck_cstore
    pop  DE             ; 1:10      tuck c!  tuck_cstore})dnl
dnl
dnl
dnl tuck c! 1+
dnl ( char addr -- addr+1 )
dnl store 8-bit number at addr and increment
define({TUCK_CSTORE_1ADD},{
                        ;[3:23]     tuck c! +1  tuck_cstore_1add   ( x addr -- addr+2 )
    ld  (HL),E          ; 1:7       tuck c! +1  tuck_cstore_1add
    inc  HL             ; 1:6       tuck c! +1  tuck_cstore_1add
    pop  DE             ; 1:10      tuck c! +1  tuck_cstore_1add})dnl
dnl
dnl
dnl over swap c!
dnl ( char addr -- char )
dnl store 8-bit number at addr with save char
define({OVER_SWAP_CSTORE},{
                        ;[3:21]     over swap c!  over_swap_cstore   ( char addr -- char )
    ld  (HL),E          ; 1:7       over swap c!  over_swap_cstore
    ex   DE, HL         ; 1:4       over swap c!  over_swap_cstore
    pop  DE             ; 1:10      over swap c!  over_swap_cstore})dnl
dnl
dnl
dnl 2dup c!
dnl ( char addr -- char addr )
dnl store 8-bit number at addr with save all
define({_2DUP_CSTORE},{
                        ;[1:7]      2dup c!  _2dup_cstore   ( char addr -- char addr )
    ld  (HL),E          ; 1:7       2dup c!  _2dup_cstore})dnl
dnl
dnl
dnl 2dup c! 1+
dnl ( char addr -- char addr+1 )
dnl store 8-bit number at addr with save all and increment
define({_2DUP_CSTORE_1ADD},{
                        ;[2:13]     2dup c! 1+  _2dup_cstore_1add   ( char addr -- char addr+1 )
    ld  (HL),E          ; 1:7       2dup c! 1+  _2dup_cstore_1add
    inc  HL             ; 1:6       2dup c! 1+  _2dup_cstore_1add})dnl
dnl
dnl
dnl number over c!
dnl ( addr -- addr )
dnl store 8-bit number at addr with save addr
define({PUSH_OVER_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[2:10]     $1 over c!  push_over_cstore($1)   ( addr -- addr )
    ld  (HL),low format({%-7s},$1); 2:10      $1 over c!  push_over_cstore($1)})dnl
dnl
dnl
dnl over number swap c!
dnl ( addr x -- addr x )
dnl store 8-bit number at addr with save addr
define({OVER_PUSH_SWAP_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(eval($1),0,{dnl
__{}                        ;[2:11]     over $1 swap c!  over_push_swap_cstore($1)   ( addr x -- addr x )
__{}    xor   A             ; 1:4       over $1 swap c!  over_push_swap_cstore($1)},
__{}{dnl
__{}                        ;[3:14]     over $1 swap c!  over_push_swap_cstore($1)   ( addr x -- addr x )
__{}    ld    A,low format({%-8s},$1); 2:7       over $1 swap c!  over_push_swap_cstore($1)})
    ld  (DE),A          ; 1:7       over $1 swap c!  over_push_swap_cstore($1)})dnl
dnl
dnl
dnl dup number swap c! 1+
dnl push over c! 1+
dnl ( addr -- addr+1 )
dnl store 8-bit number at addr with save addr and increment
define({DUP_PUSH_SWAP_CSTORE_1ADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[3:16]     dup $1 swap c! 1+  dup_push_swap_cstore_1add($1)   ( addr -- addr+1 )
    ld  (HL),low format({%-7s},$1); 2:10      dup $1 swap c! 1+  dup_push_swap_cstore_1add($1)
    inc  HL             ; 1:6       dup $1 swap c! 1+  dup_push_swap_cstore_1add($1)})dnl
dnl
dnl
dnl dup number swap c! 1+
dnl push over c! 1+
dnl ( addr -- addr+1 )
dnl store 8-bit number at addr with save addr and increment
define({PUSH_OVER_CSTORE_1ADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[3:16]     $1 over c! 1+  push_over_cstore_1add($1)   ( addr -- addr+1 )
    ld  (HL),low format({%-7s},$1); 2:10      $1 over c! 1+  push_over_cstore_1add($1)
    inc  HL             ; 1:6       $1 over c! 1+  push_over_cstore_1add($1)})dnl
dnl
dnl
dnl
dnl cmove
dnl ( from_addr to_addr u -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVE},{
    ld    A, H          ; 1:4       cmove   ( from_addr to_addr u -- )
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from_addr
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove})dnl
dnl
dnl
dnl u cmove
dnl ( from_addr to_addr -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({PUSH_CMOVE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                       ;[13:54+21*u]$1 cmove   ( from_addr to_addr -- )
__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 cmove   BC = u
__{}__{}    ld    A, B          ; 1:4       $1 cmove
__{}__{}    or    C             ; 1:4       $1 cmove
__{}__{}    jr    z, $+5        ; 2:7/12    $1 cmove
__{}__{}    ex   DE, HL         ; 1:4       $1 cmove   HL = from_addr, DE = to_addr
__{}__{}    ldir                ; 2:u*21/16 $1 cmove   addr++
__{}__{}    pop  HL             ; 1:10      $1 cmove
__{}__{}    pop  DE             ; 1:10      $1 cmove},
__{}eval($1),{},{dnl
__{}    .error  {$0}(): Bad parameter!},
__{}{dnl
__{}__{}ifelse(eval($1>0),{1},{dnl
__{}__{}__{}                        ;format({%-11s},[8:eval(29+21*($1))])$1 cmove   ( from_addr to_addr -- )
__{}__{}__{}ifelse(eval(($1)>65535),{1},{dnl
__{}__{}__{}    .warning  {$0}($@): Trying to copy data bigger 64k!
__{}__{}__{}}){}dnl
__{}__{}__{}    ld   BC, format({%-11s},$1); 3:10      $1 cmove   BC = eval(($1) & 0xFFFF)
__{}__{}__{}    ex   DE, HL         ; 1:4       $1 cmove   HL = from_addr, DE = to_addr
__{}__{}__{}    ldir                ; 2:u*21/16 $1 cmove
__{}__{}__{}    pop  HL             ; 1:10      $1 cmove
__{}__{}__{}    pop  DE             ; 1:10      $1 cmove},
__{}__{}{dnl
__{}__{}__{}                        ;[2:20]     $1 cmove   ( from_addr to_addr -- )
__{}__{}__{}    pop  HL             ; 1:10      $1 cmove
__{}__{}__{}    pop  DE             ; 1:10      $1 cmove})})})dnl
dnl
dnl
dnl cmove>
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVEGT},{
    ld    A, H          ; 1:4       cmove>
    or    L             ; 1:4       cmove>
    ld    B, H          ; 1:4       cmove>
    ld    C, L          ; 1:4       cmove>   BC = u
    pop  HL             ; 1:10      cmove>   HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove>
    lddr                ; 2:u*21/16 cmove>   addr--
    pop  HL             ; 1:10      cmove>
    pop  DE             ; 1:10      cmove>})dnl
dnl
dnl
dnl
dnl addr u char fill
dnl ( addr u char -- )
dnl If u is greater than zero, fill the contents of u consecutive characters at addr.
define({FILL},{ifelse({fast},{fast},{
__{}    ld    A, D          ; 1:4       fill
__{}    or    E             ; 1:4       fill
__{}    ld    A, L          ; 1:4       fill
__{}    pop  HL             ; 1:10      fill HL = from
__{}    jr    z, $+15       ; 2:7/12    fill
__{}    ld  (HL),A          ; 1:7       fill
__{}    dec  DE             ; 1:6       fill
__{}    ld    A, D          ; 1:4       fill
__{}    or    E             ; 1:4       fill
__{}    jr    z, $+9        ; 2:7/12    fill
__{}    ld    C, E          ; 1:4       fill
__{}    ld    B, D          ; 1:4       fill
__{}    ld    E, L          ; 1:4       fill
__{}    ld    D, H          ; 1:4       fill
__{}    inc  DE             ; 1:6       fill DE = to
__{}    ldir                ; 2:u*21/16 fill
__{}    pop  HL             ; 1:10      fill
__{}    pop  DE             ; 1:10      fill},
__{}{
__{}    ld    A, L          ; 1:4       fill A  = char
__{}    pop  HL             ; 1:10      fill HL = addr
__{}    ld    B, E          ; 1:4       fill
__{}    inc   D             ; 1:4       fill
__{}    inc   E             ; 1:4       fill
__{}    dec   E             ; 1:4       fill
__{}    jr    z, $+6        ; 2:7/12    fill
__{}    ld  (HL),A          ; 1:7       fill
__{}    inc  HL             ; 1:6       fill
__{}    djnz $-2            ; 2:13/8    fill
__{}    dec   D             ; 1:4       fill
__{}    jr   nz, $-5        ; 2:7/12    fill
__{}    pop  HL             ; 1:10      fill
__{}    pop  DE             ; 1:10      fill})})dnl
dnl
dnl
dnl
dnl addr u char fill
dnl ( addr u -- )
dnl If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH_FILL},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse({fast},{fast},{dnl
__{}    ld    A, H          ; 1:4       $1 fill
__{}    or    L             ; 1:4       $1 fill
__{}    jr    z, $+16       ; 2:7/12    $1 fill
__{}    ld    C, L          ; 1:4       $1 fill
__{}    ld    B, H          ; 1:4       $1 fill
__{}    ld    L, E          ; 1:4       $1 fill
__{}    ld    H, D          ; 1:4       $1 fill HL = from
__{}    ld  (HL),format({%-11s},$1); 2:10      $1 fill
__{}    dec  BC             ; 1:6       $1 fill
__{}    ld    A, B          ; 1:4       $1 fill
__{}    or    C             ; 1:4       $1 fill
__{}    jr    z, $+5        ; 2:7/12    $1 fill
__{}    inc  DE             ; 1:6       $1 fill DE = to
__{}    ldir                ; 2:u*21/16 $1 fill
__{}    pop  HL             ; 1:10      $1 fill
__{}    pop  DE             ; 1:10      $1 fill},
__{}{dnl
__{}    ld    A, format({%-11s},$1); 2:7       $1 fill
__{}    ld    B, L          ; 1:4       $1 fill
__{}    inc   H             ; 1:4       $1 fill
__{}    inc   L             ; 1:4       $1 fill
__{}    dec   L             ; 1:4       $1 fill
__{}    jr    z, $+6        ; 2:7/12    $1 fill
__{}    ld  (DE),A          ; 1:7       $1 fill
__{}    inc  DE             ; 1:6       $1 fill
__{}    djnz $-2            ; 2:13/8    $1 fill
__{}    dec   H             ; 1:4       $1 fill
__{}    jr   nz, $-5        ; 2:7/12    $1 fill
__{}    pop  HL             ; 1:10      $1 fill
__{}    pop  DE             ; 1:10      $1 fill})})dnl
dnl
dnl
dnl
dnl addr u char fill
dnl ( addr -- )
dnl If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH2_FILL},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(eval($1),{0},{dnl
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}eval($1),{1},{dnl
__{}                        ;[4:24]     1 $2 fill
__{}    ld  (HL),format({%-11s},$2); 2:10      1 $2 fill
__{}    ex   DE, HL         ; 1:4       1 $2 fill
__{}    pop  DE             ; 1:10      1 $2 fill},
__{}eval($1),{2},{dnl
__{}                        ;[7:40]     2 $2 fill
__{}    ld  (HL),format({%-11s},$2); 2:10      2 $2 fill
__{}    inc  HL             ; 1:6       2 $2 fill
__{}    ld  (HL),format({%-11s},$2); 2:10      2 $2 fill
__{}    ex   DE, HL         ; 1:4       2 $2 fill
__{}    pop  DE             ; 1:10      2 $2 fill},
__{}eval($1),{3},{dnl
__{}                        ;[9:54]     3 $2 fill
__{}    ld    A, format({%-11s},$2); 2:7       3 $2 fill
__{}    ld  (HL),A          ; 1:7       3 $2 fill
__{}    inc  HL             ; 1:6       3 $2 fill
__{}    ld  (HL),A          ; 1:7       3 $2 fill
__{}    inc  HL             ; 1:6       3 $2 fill
__{}    ld  (HL),A          ; 1:7       3 $2 fill
__{}    ex   DE, HL         ; 1:4       3 $2 fill
__{}    pop  DE             ; 1:10      3 $2 fill},
__{}eval($1),{4},{dnl
__{}                        ;[11:67]    4 $2 fill
__{}    ld    A, format({%-11s},$2); 2:7       4 $2 fill
__{}    ld  (HL),A          ; 1:7       4 $2 fill
__{}    inc  HL             ; 1:6       4 $2 fill
__{}    ld  (HL),A          ; 1:7       4 $2 fill
__{}    inc  HL             ; 1:6       4 $2 fill
__{}    ld  (HL),A          ; 1:7       4 $2 fill
__{}    inc  HL             ; 1:6       4 $2 fill
__{}    ld  (HL),A          ; 1:7       4 $2 fill
__{}    ex   DE, HL         ; 1:4       4 $2 fill
__{}    pop  DE             ; 1:10      4 $2 fill},
__{}eval($1),{5},{dnl
__{}                        ;[13:80]    5 $2 fill
__{}    ld    A, format({%-11s},$2); 2:7       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    inc  HL             ; 1:6       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    inc  HL             ; 1:6       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    inc  HL             ; 1:6       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    inc  HL             ; 1:6       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    ex   DE, HL         ; 1:4       5 $2 fill
__{}    pop  DE             ; 1:10      5 $2 fill},
__{}eval((($1)<=3*256) && ((($1) % 3)==0)),{1},{dnl
__{}                        ;[13:eval(19+(52*$1)/3)]   $1 $2 fill
__{}    ld   BC, format({%-11s},eval(($1)/3){*256+$2}); 3:10      $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    djnz $-4            ; 2:13/8    $1 $2 fill
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}eval((($1)<=2*256) && ((($1) & 1)==0)),{1},{dnl
__{}                        ;[11:eval(19+39*(($1)/2))]   $1 $2 fill
__{}    ld   BC, format({%-11s},eval(($1)/2){*256+$2}); 3:10      $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    djnz $-4            ; 2:13/8    $1 $2 fill
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}eval((($1)<=2*256) && ((($1) & 1)==1)),{1},{dnl
__{}                        ;[12:eval(26+39*(($1)/2))]   $1 $2 fill
__{}    ld   BC, format({%-11s},eval(($1)/2){*256+$2}); 3:10      $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    djnz $-4            ; 2:13/8    $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}{dnl
__{}                        ;[13:eval(39+($1)*21)]   $1 $2 fill
__{}    ld  (HL),format({%-11s},$2); 2:10      $1 $2 fill
__{}    ld   BC, format({%-11s},eval($1)-1); 3:10      $1 $2 fill
__{}    push DE             ; 1:11      $1 $2 fill
__{}    ld    D, H          ; 1:4       $1 $2 fill
__{}    ld    E, L          ; 1:4       $1 $2 fill
__{}    inc  DE             ; 1:6       $1 $2 fill DE = to
__{}    ldir                ; 2:u*21/16 $1 $2 fill
__{}    pop  HL             ; 1:10      $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill})})dnl
dnl
dnl
dnl
dnl addr u char fill
dnl ( -- )
dnl If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH3_FILL},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},{
__{}__{}.error {$0}($@): The third parameter is missing!},
__{}$#,{3},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(eval($2),{0},{dnl
__{}                        ;           $1 $2 $3 fill {$0}(addr,u,char)   variant null: 0 byte},
eval($2),{1},{dnl
__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[6:26]     $1 $2 $3 fill {$0}(addr,u,char)   variant A.1: 1 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[5:20]     $1 $2 $3 fill {$0}(addr,u,char)   variant A.2: 1 byte
__{}__{}    ld    A, format({%-11s},$3); 2:7       $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill},
eval($2),{2},{dnl
__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[9:39]     $1 $2 $3 fill {$0}(addr,u,char)   variant B.1: 2 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill},
__{}__{}{
__{}__{}                        ;[7:30]     $1 $2 $3 fill {$0}(addr,u,char)   variant B.2: 2 byte
__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      $1 $2 $3 fill
__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill})},
eval($2),{3},{dnl
__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[12:52]    $1 $2 $3 fill {$0}(addr,u,char)   variant C.1: 3 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[11:46]    $1 $2 $3 fill {$0}(addr,u,char)   variant C.2: 3 byte
__{}__{}    ld    A, format({%-11s},$3); 2:7       $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill
__{}    ld   format({%-15s},(1+$1){,} A); 3:13      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} A); 3:13      $1 $2 $3 fill},
eval($2),{4},{dnl
__{}__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[13:61]    $1 $2 $3 fill {$0}(addr,u,char)   variant D.1: 4 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld    C, A          ; 1:4       $1 $2 $3 fill
__{}__{}    ld    B, A          ; 1:4       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[11:50]    $1 $2 $3 fill {$0}(addr,u,char)   variant D.2: 4 byte
__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      $1 $2 $3 fill},
eval($2),{5},{dnl
__{}__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[16:74]    $1 $2 $3 fill {$0}(addr,u,char)   variant E.1: 5 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld    C, A          ; 1:4       $1 $2 $3 fill
__{}__{}    ld    B, A          ; 1:4       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[15:67]    $1 $2 $3 fill {$0}(addr,u,char)   variant E.2: 5 byte
__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      $1 $2 $3 fill
__{}__{}    ld    A, B          ; 1:4       $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(4+$1){,} A); 3:13      $1 $2 $3 fill},
eval($2),{6},{dnl
__{}__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[17:81]    $1 $2 $3 fill {$0}(addr,u,char)   variant F.1: 6 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld    C, A          ; 1:4       $1 $2 $3 fill
__{}__{}    ld    B, A          ; 1:4       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[15:70]    $1 $2 $3 fill {$0}(addr,u,char)   variant F.2: 6 byte
__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(4+$1){,} BC); 4:20      $1 $2 $3 fill},
eval(((($1) & 0xFF00) == (($1 + $2) & 0xFF00)) && (($2) % 3 == 0)),{1},{dnl
__{}define({_TEMP_B},eval(((($2) & 0xFFFF)/3) & 0x1FF))dnl
__{}                        ;[16:format({%-7s},eval(36+46*_TEMP_B)])$1 $2 $3 fill {$0}(addr,u,char)   variant G: u == 3*n bytes (3..+3..255) and hi(addr) == hi(addr_end)
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill   HL = addr
__{}    ld   BC, format({%-11s},eval((256*_TEMP_B) & 0xFFFF)+$3); 3:10      $1 $2 $3 fill   B = _TEMP_B{}x, C = $3
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}    djnz $-4            ; 2:13/8    $1 $2 $3 fill
__{}    pop  HL             ; 1:10      $1 $2 $3 fill},
eval(($2) <= 2*256+1),{1},{dnl
__{}define({_TEMP_B},eval(((($2) & 0xFFFF)/2) & 0x1FF))dnl
__{}                        ;[eval(14+(($2) & 0x01)):format({%-7s},eval(36+37*_TEMP_B+7*(($2) & 0x01))])$1 $2 $3 fill {$0}(addr,u,char)   variant H: 2..513 byte
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill   HL = addr
__{}    ld   BC, format({%-11s},eval((256*_TEMP_B) & 0xFFFF)+$3); 3:10      $1 $2 $3 fill   B = _TEMP_B{}x, C = $3
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+1) & 0x01),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+2) & 0x01),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    djnz $-4            ; 2:13/8    $1 $2 $3 fill
__{}ifelse(eval(($2) & 0x01),{1},{dnl
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}})dnl
__{}    pop  HL             ; 1:10      $1 $2 $3 fill},
eval(($2) <= 4*256+3),{1},{dnl
__{}define({_TEMP_B},eval(((($2) & 0xFFFF)/4) & 0x1FF))dnl
__{}ifelse(eval(($2) % 4),{0},{dnl
__{}__{}define({_TEMP_SIZE},{18})dnl
__{}__{}define({_TEMP_CLOCK},{0})dnl
__{}__{}define({_TEMP_PLUS},{})},
__{}eval(($2) % 4),{1},{dnl
__{}__{}define({_TEMP_SIZE},{19})dnl
__{}__{}define({_TEMP_CLOCK},{7})dnl
__{}__{}define({_TEMP_PLUS},{
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill})},
__{}eval(($2) % 4),{2},{dnl
__{}__{}define({_TEMP_SIZE},{21})dnl
__{}__{}ifelse(eval(($1+4*_TEMP_B+1) & 0xFF),{0},{dnl
__{}__{}__{}define({_TEMP_CLOCK},{20})dnl
__{}__{}__{}define({_TEMP_PLUS},{
__{}__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill
__{}__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill})},
__{}__{}{dnl
__{}__{}__{}define({_TEMP_CLOCK},{18})dnl
__{}__{}__{}define({_TEMP_PLUS},{
__{}__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill})})},
__{}{dnl
__{}__{}define({_TEMP_SIZE},{23})dnl
__{}__{}define({_TEMP_CLOCK},{29})dnl
__{}__{}ifelse(eval(($1+4*_TEMP_B+1) & 0xFF),{0},{define({_TEMP_CLOCK},eval(_TEMP_CLOCK+2))})dnl
__{}__{}ifelse(eval(($1+4*_TEMP_B+2) & 0xFF),{0},{define({_TEMP_CLOCK},eval(_TEMP_CLOCK+2))})dnl
__{}__{}define({_TEMP_PLUS},{
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}__{}ifelse(eval(($1+4*_TEMP_B+1) & 0xFF),{0},{dnl
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}__{}ifelse(eval(($1+4*_TEMP_B+2) & 0xFF),{0},{dnl
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill})}){}dnl
__{}                        ;[_TEMP_SIZE:format({%-7s},eval(36+59*_TEMP_B+_TEMP_CLOCK)])$1 $2 $3 fill {$0}(addr,u,char)   variant {I}: 4..1027 byte
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill   HL = addr
__{}    ld   BC, format({%-11s},eval((256*_TEMP_B) & 0xFFFF)+$3); 3:10      $1 $2 $3 fill   B = _TEMP_B{}x, C = $3
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+1) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+2) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+3) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+0) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    djnz $-8            ; 2:13/8    $1 $2 $3 fill{}_TEMP_PLUS
__{}    pop  HL             ; 1:10      $1 $2 $3 fill},
eval((($2) % 4) == 0),{1},{dnl
__{}define({_TEMP_B},eval((($2)/4) & 0xFF))dnl
__{}define({_TEMP_C},eval(((($2)/4) & 0xFF00)/256))dnl
__{}ifelse(eval(_TEMP_B>0),{1},{define({_TEMP_C},eval(_TEMP_C+1))})dnl
__{}                       ;[24:format({%-8s},eval(48+46*($2)/4+13*(_TEMP_B+(_TEMP_C-1)*256)+9*_TEMP_C)])$1 $2 $3 fill {$0}(addr,u,char)   variant {J}: u = 4*n bytes
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill   HL = addr
__{}    ld   BC, format({%-11s},256*_TEMP_B+_TEMP_C); 3:10      $1 $2 $3 fill   $2{}x = (C-1)*4*256 + 4*B
__{}    ld    A, format({%-11s},$3); ifelse(__IS_MEM_REF($3),{1},{3:13},{2:7 })      $1 $2 $3 fill   A = char
__{}    ld  (HL),A          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+1) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),A          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+2) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),A          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+3) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),A          ; 1:7       $1 $2 $3 fill
__{}ifelse(eval(($1+0) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    djnz $-8            ; 2:13/8    $1 $2 $3 fill
__{}    dec  C              ; 1:4       $1 $2 $3 fill
__{}    jp   nz, $-11       ; 3:10      $1 $2 $3 fill
__{}    pop  HL             ; 1:10      $1 $2 $3 fill},
__{}{dnl
__{}                       ;[17:format({%-8s},eval(77+$2*21)])$1 $2 $3 fill {$0}(addr,u,char)   variant {K}.default
__{}    push DE             ; 1:11      $1 $2 $3 fill
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill HL = addr from
__{}    ld   DE, format({%-11s},$1+1); 3:10      $1 $2 $3 fill DE = to
__{}    ld   BC, format({%-11s},$2-1); 3:10      $1 $2 $3 fill
__{}    ld  (HL),format({%-11s},$3); 2:10      $1 $2 $3 fill
__{}    ldir                ; 2:u*21/16 $1 $2 $3 fill
__{}    pop  HL             ; 1:10      $1 $2 $3 fill
__{}    pop  DE             ; 1:10      $1 $2 $3 fill})})dnl
dnl
dnl
dnl -------------------------------------------------------------------------------------
dnl ## Memory access 16bit
dnl -------------------------------------------------------------------------------------
dnl
dnl
dnl @
dnl ( addr -- x )
dnl fetch 16-bit number from addr
define({FETCH},{
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch})dnl
dnl
dnl
dnl dup @
dnl ( addr -- addr x )
dnl save addr and fetch 16-bit number from addr
define({DUP_FETCH},{
                        ;[6:41]     dup @ dup_fetch ( addr -- addr x )
    push DE             ; 1:11      dup @ dup_fetch
    ld    E, (HL)       ; 1:7       dup @ dup_fetch
    inc  HL             ; 1:6       dup @ dup_fetch
    ld    D, (HL)       ; 1:7       dup @ dup_fetch
    dec  HL             ; 1:6       dup @ dup_fetch
    ex   DE, HL         ; 1:4       dup @ dup_fetch})dnl
dnl
dnl
dnl dup @ swap
dnl ( addr -- x addr )
dnl save addr and fetch 16-bit number from addr and swap
define({DUP_FETCH_SWAP},{
                        ;[5:37]     dup @ swap dup_fetch_swap ( addr -- x addr )
    push DE             ; 1:11      dup @ swap dup_fetch_swap
    ld    E, (HL)       ; 1:7       dup @ swap dup_fetch_swap
    inc  HL             ; 1:6       dup @ swap dup_fetch_swap
    ld    D, (HL)       ; 1:7       dup @ swap dup_fetch_swap
    dec  HL             ; 1:6       dup @ swap dup_fetch_swap})dnl
dnl
dnl
dnl addr @
dnl ( -- x )
dnl push_fetch(addr), load 16-bit number from addr
define({PUSH_FETCH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 @ push($1) fetch
    ex   DE, HL         ; 1:4       $1 @ push($1) fetch
    ld   HL,format({%-12s},($1)); 3:16      $1 @ push($1) fetch})dnl
dnl
dnl
dnl
dnl !
dnl ( x addr -- )
dnl store 16-bit number at addr
define({STORE},{
                        ;[5:40]     ! store   ( x addr -- )
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store})dnl
dnl
dnl
dnl
dnl addr !
dnl ( x -- )
dnl store(addr) store 16-bit number at addr
define({PUSH_STORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   format({%-15s},($1){,} HL); 3:16      $1 ! push($1) store
    ex   DE, HL         ; 1:4       $1 ! push($1) store
    pop  DE             ; 1:10      $1 ! push($1) store})dnl
dnl
dnl
dnl
dnl x addr !
dnl ( -- )
dnl store(addr) store 16-bit number at addr
define({PUSH2_STORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      push2_store($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_store($1,$2)})dnl
dnl
dnl
dnl
dnl tuck !
dnl ( x addr -- addr )
dnl store 16-bit number at addr
define({TUCK_STORE},{
                        ;[5:36]     tuck ! tuck_store   ( x addr -- addr )
    ld  (HL),E          ; 1:7       tuck ! tuck_store
    inc  HL             ; 1:6       tuck ! tuck_store
    ld  (HL),D          ; 1:7       tuck ! tuck_store
    dec  HL             ; 1:6       tuck ! tuck_store
    pop  DE             ; 1:10      tuck ! tuck_store})dnl
dnl
dnl
dnl tuck ! 2+
dnl ( x addr -- addr+2 )
dnl store 16-bit number at addr
define({TUCK_STORE_2ADD},{
                        ;[5:36]     tuck ! +2 tuck_store_2add   ( x addr -- addr+2 )
    ld  (HL),E          ; 1:7       tuck ! +2 tuck_store_2add
    inc  HL             ; 1:6       tuck ! +2 tuck_store_2add
    ld  (HL),D          ; 1:7       tuck ! +2 tuck_store_2add
    inc  HL             ; 1:6       tuck ! +2 tuck_store_2add
    pop  DE             ; 1:10      tuck ! +2 tuck_store_2add})dnl
dnl
dnl
dnl over swap !
dnl ( x addr -- x )
dnl store 16-bit number at addr
define({OVER_SWAP_STORE},{
                        ;[5:34]     over swap ! over_swap_store   ( x addr -- x )
    ld  (HL),E          ; 1:7       over swap ! over_swap_store
    inc  HL             ; 1:6       over swap ! over_swap_store
    ld  (HL),D          ; 1:7       over swap ! over_swap_store
    ex   DE, HL         ; 1:4       over swap ! over_swap_store
    pop  DE             ; 1:10      over swap ! over_swap_store})dnl
dnl
dnl
dnl 2dup !
dnl ( x addr -- x addr )
dnl store 16-bit number at addr
define({_2DUP_STORE},{
                        ;[4:26]     2dup ! _2dup_store   ( x addr -- x addr )
    ld  (HL),E          ; 1:7       2dup ! _2dup_store
    inc  HL             ; 1:6       2dup ! _2dup_store
    ld  (HL),D          ; 1:7       2dup ! _2dup_store
    dec  HL             ; 1:6       2dup ! _2dup_store})dnl
dnl
dnl
dnl 2dup ! 2+
dnl ( x addr -- x addr+2 )
dnl store 16-bit number at addr
define({_2DUP_STORE_2ADD},{
                        ;[4:26]     2dup ! 2+ _2dup_store_2add   ( x addr -- x addr+2 )
    ld  (HL),E          ; 1:7       2dup ! 2+ _2dup_store_2add
    inc  HL             ; 1:6       2dup ! 2+ _2dup_store_2add
    ld  (HL),D          ; 1:7       2dup ! 2+ _2dup_store_2add
    inc  HL             ; 1:6       2dup ! 2+ _2dup_store_2add})dnl
dnl
dnl
dnl number over !
dnl dup number swap !
dnl ( addr -- addr )
dnl store 16-bit number at addr
define({DUP_PUSH_SWAP_STORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[6:32]     dup $1 swap ! dup_push_swap_store($1)   ( addr -- addr )
    ld  (HL),low format({%-7s},$1); 2:10      dup $1 swap ! dup_push_swap_store($1)
    inc  HL             ; 1:6       dup $1 swap ! dup_push_swap_store($1)
    ld  (HL),high format({%-6s},$1); 2:10      dup $1 swap ! dup_push_swap_store($1)
    dec  HL             ; 1:6       dup $1 swap ! dup_push_swap_store($1)})dnl
dnl
dnl
dnl number over !
dnl dup number swap !
dnl ( addr -- addr )
dnl store 16-bit number at addr
define({PUSH_OVER_STORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[6:32]     $1 over ! push_over_store($1)   ( addr -- addr )
    ld  (HL),low format({%-7s},$1); 2:10      $1 over ! push_over_store($1)
    inc  HL             ; 1:6       $1 over ! push_over_store($1)
    ld  (HL),high format({%-6s},$1); 2:10      $1 over ! push_over_store($1)
    dec  HL             ; 1:6       $1 over ! push_over_store($1)})dnl
dnl
dnl
dnl number over ! 2+
dnl dup number swap ! 2+
dnl ( addr -- addr+2 )
dnl store 16-bit number at addr
define({DUP_PUSH_SWAP_STORE_2ADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[6:32]     dup $1 swap ! 2+ dup_push_swap_store_2add($1)   ( addr -- addr+2 )
    ld  (HL),low format({%-7s},$1); 2:10      dup $1 swap ! 2+ dup_push_swap_store_2add($1)
    inc  HL             ; 1:6       dup $1 swap ! 2+ dup_push_swap_store_2add($1)
    ld  (HL),high format({%-6s},$1); 2:10      dup $1 swap ! 2+ dup_push_swap_store_2add($1)
    inc  HL             ; 1:6       dup $1 swap ! 2+ dup_push_swap_store_2add($1)})dnl
dnl
dnl
dnl number over ! 2+
dnl dup number swap ! 2+
dnl ( addr -- addr+2 )
dnl store 16-bit number at addr
define({PUSH_OVER_STORE_2ADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[6:32]     $1 over ! 2+ push_over_store_2add($1)   ( addr -- addr+2 )
    ld  (HL),low format({%-7s},$1); 2:10      $1 over ! 2+ push_over_store_2add($1)
    inc  HL             ; 1:6       $1 over ! 2+ push_over_store_2add($1)
    ld  (HL),high format({%-6s},$1); 2:10      $1 over ! 2+ push_over_store_2add($1)
    inc  HL             ; 1:6       $1 over ! 2+ push_over_store_2add($1)})dnl
dnl
dnl
dnl move
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVE},{
    or    A             ; 1:4       move
    adc  HL, HL         ; 1:11      move
    ld    B, H          ; 1:4       move
    ld    C, L          ; 1:4       move   BC = 2*u
    pop  HL             ; 1:10      move   HL = from = addr1
    jr    z, $+4        ; 2:7/12    move
    ldir                ; 2:u*42/32 move   addr++
    pop  HL             ; 1:10      move
    pop  DE             ; 1:10      move})dnl
dnl
dnl
dnl u move
dnl ( from_addr to_addr -- )
dnl If u is greater than zero, copy the contents of u consecutive words at from_addr to the u consecutive words at to_addr.
define({PUSH_MOVE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}                       ;[17:70+42*u]$1 move   ( from_addr to_addr -- )
__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 move   BC = u
__{}__{}    ld    A, H          ; 1:4       $1 move
__{}__{}    or    L             ; 1:4       $1 move
__{}__{}    jr    z, $+9        ; 2:7/12    $1 move
__{}__{}    ex   DE, HL         ; 1:4       $1 move   HL = from_addr, DE = to_addr
__{}__{}    push BC             ; 1:11      $1 move
__{}__{}    ldir                ; 2:u*21/16 $1 move   addr++
__{}__{}    pop  BC             ; 1:10      $1 move
__{}__{}    ldir                ; 2:u*21/16 $1 move
__{}__{}    pop  HL             ; 1:10      $1 move
__{}__{}    pop  DE             ; 1:10      $1 move},
__{}eval($1),{},{dnl
__{}    .error  {$0}(): Bad parameter!},
__{}{dnl
__{}__{}ifelse(eval($1>0),{1},{dnl
__{}__{}__{}                        ;format({%-11s},[8:eval(29+42*($1))])$1 move   ( from_addr to_addr -- )
__{}__{}__{}ifelse(eval(2*($1)>65535),{1},{dnl
__{}__{}__{}    .warning  {$0}($@): Trying to copy data bigger 64k!
__{}__{}__{}}){}dnl
__{}__{}__{}    ld   BC, format({%-11s},eval(2*($1))); 3:10      $1 move   BC = eval((2*($1)) & 0xFFFF)
__{}__{}__{}    ex   DE, HL         ; 1:4       $1 move   HL = from_addr, DE = to_addr
__{}__{}__{}    ldir                ; 2:u*21/16 $1 move   addr++
__{}__{}__{}    pop  HL             ; 1:10      $1 move
__{}__{}__{}    pop  DE             ; 1:10      $1 move},
__{}__{}{dnl
__{}__{}__{}                        ;[2:20]     $1 move   ( from_addr to_addr -- )
__{}__{}__{}    pop  HL             ; 1:10      $1 move
__{}__{}__{}    pop  DE             ; 1:10      $1 move})})})dnl
dnl
dnl
dnl move>
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVEGT},{
    or    A             ; 1:4       move>
    adc  HL, HL         ; 1:11      move>
    ld    B, H          ; 1:4       move>
    ld    C, L          ; 1:4       move>   BC = 2*u
    pop  HL             ; 1:10      move>   HL = from = addr1
    jr    z, $+4        ; 2:7/12    move>
    lddr                ; 2:u*42/32 move>   addr--
    pop  HL             ; 1:10      move>
    pop  DE             ; 1:10      move>})dnl
dnl
dnl
dnl
dnl +!
dnl ( num addr -- )
dnl Adds num to the 16-bit number stored at addr.
define({ADDSTORE},{
    ld    A, E          ; 1:4       +! addstore
    add   A,(HL)        ; 1:7       +! addstore
    ld  (HL),A          ; 1:7       +! addstore
    inc  HL             ; 1:6       +! addstore
    ld    A, D          ; 1:4       +! addstore
    adc   A,(HL)        ; 1:7       +! addstore
    ld  (HL),A          ; 1:7       +! addstore
    pop  HL             ; 1:10      +! addstore
    pop  DE             ; 1:10      +! addstore})dnl
dnl
dnl
dnl num addr +!
dnl ( -- )
dnl Adds num to the 16-bit number stored at addr.
define({PUSH2_ADDSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(eval($1),{},{dnl
    push HL             ; 1:11      push2_addstore($1,$2)
    .warning {$0}($1): M4 does not know $1 parameter value!
    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      push2_addstore($1,$2)
    ld   HL, format({%-11s},{($2)}); 3:16      push2_addstore($1,$2)
    add  HL, BC         ; 1:11      push2_addstore($1,$2)
    ld   format({%-15s},($2){,} HL); 3:16      push2_addstore($1,$2)
    pop  HL             ; 1:10      push2_addstore($1,$2)},
__IS_MEM_REF($1),{1},{dnl
    push HL             ; 1:11      push2_addstore($1,$2)
    ld   BC, format({%-11s},$1); 4:20      push2_addstore($1,$2)
    ld   HL, format({%-11s},{($2)}); 3:16      push2_addstore($1,$2)
    add  HL, BC         ; 1:11      push2_addstore($1,$2)
    ld   format({%-15s},($2){,} HL); 3:16      push2_addstore($1,$2)
    pop  HL             ; 1:10      push2_addstore($1,$2)},
eval($1),0,{dnl
                        ;           push2_addstore($1,$2)},
eval($1),1,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval($1),2,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval($1),3,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval((($1) & 0xffff) == 0xffff),1,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval((($1) & 0xffff) == 0xfffe),1,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval((($1) & 0xffff) == 0xfffd),1,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
{dnl
    ld   BC, format({%-11s},$2); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      push2_addstore($1,$2)
    ld    A,(BC)        ; 1:7       push2_addstore($1,$2)
    add   A, __HEX_L($1)       ; 2:7       push2_addstore($1,$2)   lo($1)
    ld  (BC),A          ; 1:7       push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    ld    A,(BC)        ; 1:7       push2_addstore($1,$2)
    adc   A, __HEX_H($1)       ; 2:7       push2_addstore($1,$2)   hi($1)
    ld  (BC),A          ; 1:7       push2_addstore($1,$2)})})dnl
dnl
dnl
dnl -------------------------------------------------------------------------------------
dnl ## Memory access 32bit
dnl -------------------------------------------------------------------------------------
dnl
dnl
dnl 2@
dnl ( addr -- hi lo )
dnl fetch 32-bit number from addr
define({_2FETCH},{
                        ;[10:65]    2@ _2fetch
    push DE             ; 1:11      2@ _2fetch
    ld    E, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    D, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    A, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    H, (HL)       ; 1:7       2@ _2fetch
    ld    L, A          ; 1:4       2@ _2fetch
    ex   DE, HL         ; 1:4       2@ _2fetch ( adr -- lo hi )})dnl
dnl
dnl
dnl
dnl
dnl addr 2@
dnl ( -- hi lo )
dnl push_2fetch(addr), load 32-bit number from addr
define({PUSH_2FETCH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 2@ push_2fetch($1)
    push HL             ; 1:11      $1 2@ push_2fetch($1)
__{}ifelse(eval(2+$1),{},{dnl
__{}    ld   DE,format({%-12s},{(2+$1)}); 4:20      $1 2@ push_2fetch($1) hi}dnl
__{},{dnl
__{}    ld   DE,format({%-12s},(eval(2+$1))); 4:20      $1 2@ push_2fetch($1) hi})
    ld   HL,format({%-12s},($1)); 3:16      $1 2@ push_2fetch($1) lo})dnl
dnl
dnl
dnl
dnl 2!
dnl ( hi lo addr -- )
dnl store 32-bit number at addr
define({_2STORE},{
    ld  (HL),E          ; 1:7       2! _2store   ( hi lo addr -- )
    inc  HL             ; 1:6       2! _2store
    ld  (HL),D          ; 1:7       2! _2store
    inc  HL             ; 1:6       2! _2store
    pop  DE             ; 1:10      2! _2store
    ld  (HL),E          ; 1:7       2! _2store
    inc  HL             ; 1:6       2! _2store
    ld  (HL),D          ; 1:7       2! _2store
    pop  HL             ; 1:10      2! _2store
    pop  DE             ; 1:10      2! _2store})dnl
dnl
dnl
dnl
dnl addr 2!
dnl ( hi lo -- )
dnl store(addr) store 32-bit number at addr
define({PUSH_2STORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld   format({%-15s},($1){,} HL); 3:16      $1 2! push_2store($1) lo
__{}ifelse(eval(($1)),{},{dnl
    ld   format({%-15s},{(2+$1), DE}); 4:20      $1 2! push_2store($1) hi},{dnl
    ld   (format({%-14s},eval(($1)+2){),} DE); 4:20      $1 2! push_2store($1) hi})
    pop  HL             ; 1:10      $1 2! push_2store($1)
    pop  DE             ; 1:10      $1 2! push_2store($1)})dnl
dnl
dnl
dnl lo addr 2!
dnl ( hi -- )
dnl store(addr) store 32-bit number at addr
define({PUSH2_2STORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(eval(2+$2),{},{dnl
__{}    ld   format({%-15s},{(2+$2), HL}); 3:16      $1 $2 2! push2_2store($1,$2) hi}dnl
__{},{dnl
__{}    ld   (format({%-14s},eval(($2)+2){),} HL); 3:16      $1 $2 2! push2_2store($1,$2) hi})
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      $1 $2 2! push2_2store($1,$2)
    ld   (format({%-14s},{$2), HL}); 3:16      $1 $2 2! push2_2store($1,$2) lo
    pop  HL             ; 1:10      $1 $2 2! push2_2store($1,$2)})dnl
dnl
dnl
dnl

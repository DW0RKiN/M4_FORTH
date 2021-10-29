define({__},{})dnl
dnl
dnl
define({ALL_VARIABLE},{})dnl
dnl
dnl
dnl ###constant
define({CONSTANT},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}format({%-20s},$1) EQU $2
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
define({DVARIABLE},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}ifelse($1,{},{.error dvariable: Missing parameter with variable name!}dnl
__{},$#,{1},{$1:
__{}  dw 0x0000
__{}  dw 0x0000{}}dnl
__{},{$1:
__{}  dw eval(($2) & 0x0ffff)
__{}  dw eval(($2) / 0x10000)})dnl
})})dnl
dnl
dnl
define({VARIABLE},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}ifelse($1,{},{.error variable: Missing parameter with variable name!}dnl
__{},$#,{1},{$1: dw 0x0000{}}dnl
__{},{$1: dw $2{}})dnl
})})dnl
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
    ld    L, (HL)       ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch})dnl
dnl
dnl
dnl dup C@
dnl ( addr -- addr char )
dnl save addr and fetch 8-bit number from addr
define({DUP_CFETCH},{
                        ;[5:29]     dup C@ dup_cfetch ( addr -- addr char )
    push DE             ; 1:11      dup C@ dup_cfetch
    ld    E, (HL)       ; 1:7       dup C@ dup_cfetch
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
    ld    E, (HL)       ; 1:7       dup C@ swap dup_cfetch_swap
    ld    D, 0x00       ; 2:7       dup C@ swap dup_cfetch_swap})dnl
dnl
dnl
dnl addr C@
dnl ( -- x )
dnl push_cfetch(addr), load 8-bit char from addr
define({PUSH_CFETCH},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 @ push($1) cfetch
    ex   DE, HL         ; 1:4       $1 @ push($1) cfetch
    ld   HL,format({%-12s},($1)); 3:16      $1 @ push($1) cfetch
    ld    H, 0x00       ; 2:7       $1 @ push($1) cfetch})dnl
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
    ld    A, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:13},{2:7 })      push2_cstore($1,$2)
    ld   format({%-15s},($2){,} A); 3:13      push2_cstore($1,$2)})dnl
dnl
dnl
dnl
dnl
dnl tuck C!
dnl ( char addr -- addr )
dnl store 8-bit number at addr with save addr
define({TUCK_CSTORE},{
                        ;[2:17]     tuck c! tuck_cstore   ( char addr -- addr )
    ld  (HL),E          ; 1:7       tuck c! tuck_cstore
    pop  DE             ; 1:10      tuck c! tuck_cstore})dnl
dnl
dnl
dnl tuck c! 1+
dnl ( char addr -- addr+1 )
dnl store 8-bit number at addr and increment
define({TUCK_CSTORE_1ADD},{
                        ;[3:23]     tuck c! +1 tuck_cstore_1add   ( x addr -- addr+2 )
    ld  (HL),E          ; 1:7       tuck c! +1 tuck_cstore_1add
    inc  HL             ; 1:6       tuck c! +1 tuck_cstore_1add
    pop  DE             ; 1:10      tuck c! +1 tuck_cstore_1add})dnl
dnl
dnl
dnl over swap c!
dnl ( char addr -- char )
dnl store 8-bit number at addr with save char
define({OVER_SWAP_CSTORE},{
                        ;[3:21]     over swap c! over_swap_cstore   ( char addr -- char )
    ld  (HL),E          ; 1:7       over swap c! over_swap_cstore
    ex   DE, HL         ; 1:4       over swap c! over_swap_cstore
    pop  DE             ; 1:10      over swap c! over_swap_cstore})dnl
dnl
dnl
dnl 2dup c!
dnl ( char addr -- char addr )
dnl store 8-bit number at addr with save all
define({_2DUP_CSTORE},{
                        ;[1:7]      2dup c! _2dup_cstore   ( char addr -- char addr )
    ld  (HL),E          ; 1:7       2dup c! _2dup_cstore})dnl
dnl
dnl
dnl 2dup c! 1+
dnl ( char addr -- char addr+1 )
dnl store 8-bit number at addr with save all and increment
define({_2DUP_CSTORE_1ADD},{
                        ;[2:13]     2dup c! 1+ _2dup_cstore_1add   ( char addr -- char addr+1 )
    ld  (HL),E          ; 1:7       2dup c! 1+ _2dup_cstore_1add
    inc  HL             ; 1:6       2dup c! 1+ _2dup_cstore_1add})dnl
dnl
dnl
dnl dup number swap c!
dnl ( addr -- addr )
dnl store 8-bit number at addr with save addr
define({DUP_PUSH_SWAP_CSTORE},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[2:10]     dup $1 swap c! dup_push_swap_cstore($1)   ( addr -- addr )
    ld  (HL),low format({%-7s},$1); 2:10      dup $1 swap c! dup_push_swap_cstore($1)})dnl
dnl
dnl
dnl dup number swap c! 1+
dnl ( addr -- addr+1 )
dnl store 8-bit number at addr with save addr and increment
define({DUP_PUSH_SWAP_CSTORE_1ADD},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[3:16]     dup $1 swap c! 1+ dup_push_swap_cstore_1add($1)   ( addr -- addr+1 )
    ld  (HL),low format({%-7s},$1); 2:10      dup $1 swap c! 1+ dup_push_swap_cstore_1add($1)
    inc  HL             ; 1:6       dup $1 swap c! 1+ dup_push_swap_cstore_1add($1)})dnl
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
__{}ifelse(index({$1},{(}),{0},{dnl
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
__{}ifelse(eval($2),{0},{dnl
__{}                                  ;           $1 $2 $3 fill},
__{}eval($2),{1},{dnl
__{}    ld    A, format({%-11s},$3); ifelse(index({$3},{(}),{0},{3:13},{2:7 })      $1 $2 $3 fill
__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill},
__{}eval($2),{2},{dnl
__{}__{}ifelse(index({$3},{(}),{0},{dnl
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill
__{}    ld   format({%-15s},(1+$1){,} A); 3:13      $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}    ld   BC, format({%-11s},256*$3+$3); 3:10      $1 $2 $3 fill
__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill})},
__{}eval($2),{3},{dnl
__{}    ld    A, format({%-11s},$3); ifelse(index({$3},{(}),{0},{3:13},{2:7 })      $1 $2 $3 fill
__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill
__{}    ld   format({%-15s},(1+$1){,} A); 3:13      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} A); 3:13      $1 $2 $3 fill},
__{}eval($2),{4},{dnl
__{}__{}ifelse(index({$3},{(}),{0},{dnl
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld    C, A          ; 1:4       $1 $2 $3 fill
__{}__{}    ld    B, A          ; 1:4       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}    ld   BC, format({%-11s},256*$3+$3); 3:10      $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      $1 $2 $3 fill},
__{}eval($2),{6},{dnl
__{}__{}ifelse(index({$3},{(}),{0},{dnl
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld    C, A          ; 1:4       $1 $2 $3 fill
__{}__{}    ld    B, A          ; 1:4       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}    ld   BC, format({%-11s},256*$3+$3); 3:10      $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(4+$1){,} BC); 4:20      $1 $2 $3 fill},
__{}{dnl
__{}    push DE             ; 1:11      $1 $2 $3 fill
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill HL = from
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
    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      push2_store($1,$2)
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
__{}ifelse(index({$1},{(}),{0},{dnl
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
    push HL             ; 1:11      push2_addstore($1,$2)
    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      push2_addstore($1,$2)
    ld   HL, format({%-11s},{($2)}); 3:16      push2_addstore($1,$2)
    add  HL, BC         ; 1:11      push2_addstore($1,$2)
    ld   format({%-15s},($2){,} HL); 3:16      push2_addstore($1,$2)
    pop  HL             ; 1:10      push2_addstore($1,$2)})dnl
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
    ld   HL, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:16},{3:10})      $1 $2 2! push2_2store($1,$2)
    ld   (format({%-14s},{$2), HL}); 3:16      $1 $2 2! push2_2store($1,$2) lo
    pop  HL             ; 1:10      $1 $2 2! push2_2store($1,$2)})dnl
dnl
dnl
dnl

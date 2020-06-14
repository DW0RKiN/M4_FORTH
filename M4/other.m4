dnl ( -- )
dnl Save shadow reg.
define(INIT,{
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, ifelse($1,{},{60000
    .warning "Missing value for return address stack. The init() macro has no parameter!"},{$1})
    exx})dnl
dnl
dnl ( -- )
dnl Save shadow reg.
define(STOP,{
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====})dnl
dnl
dnl
dnl
define({CONSTANT},{ifelse($#,{2},{
format({%-20s},$1) EQU $2
define({$1},{$2})},{
.error constant: No parameter or redundant parameter!})})dnl
dnl
dnl
define({ALL_VARIABLE},{
VARIABLE_SECTION:
})dnl
dnl
define({CVARIABLE},{define({ALL_VARIABLE},{
}ALL_VARIABLE{
$1: db ifelse($#,{0},{
.error variable without parameter!},$#,{1},{0x00},{$2})})})dnl
dnl
dnl
define({DVARIABLE},{define({ALL_VARIABLE},{
}ALL_VARIABLE{
$1: dw ifelse($#,{0},{
.error variable without parameter!},$#,{1},{0x0000
dw 0x0000},{$2
dw 0x0000})})})dnl
dnl
dnl
define({VARIABLE},{define({ALL_VARIABLE},{
}ALL_VARIABLE{
$1: dw ifelse($#,{0},{
.error variable without parameter!},$#,{1},{0x0000},$2)})})dnl
dnl
dnl
dnl ## Memory access
dnl
dnl @
dnl ( addr -- x )
dnl fetch 16-bit number from addr
define({FETCH},{
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch})dnl
dnl
dnl
dnl C@
dnl ( addr -- char )
dnl fetch 8-bit char from addr
define({CFETCH},{
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch})dnl
dnl
dnl
dnl addr @
dnl ( -- x )
dnl push_fetch(addr), load 16-bit number from addr
define({PUSH_FETCH},{
    push DE             ; 1:11      $1 @ push($1) fetch 
    ex   DE, HL         ; 1:4       $1 @ push($1) fetch
    ld   HL,format({%-12s},($1)); 3:16      $1 @ push($1) fetch})dnl
dnl
dnl
dnl addr C@
dnl ( -- x )
dnl push_cfetch(addr), load 8-bit char from addr
define({PUSH_CFETCH},{
    push DE             ; 1:11      $1 @ push($1) cfetch 
    ex   DE, HL         ; 1:4       $1 @ push($1) cfetch
    ld   HL,format({%-12s},($1)); 3:16      $1 @ push($1) cfetch
    ld    H, 0x00       ; 2:7       $1 @ push($1) cfetch})dnl
dnl
dnl
dnl !
dnl ( x addr -- )
dnl store 16-bit number at addr
define({STORE},{
    ld  (HL), E         ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL), D         ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store})dnl
dnl
dnl
dnl C!
dnl ( char addr -- )
dnl store 8-bit char at addr
define({CSTORE},{
    ld  (HL), E         ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore})dnl
dnl
dnl
dnl addr !
dnl ( x -- )
dnl store(addr) store 16-bit number at addr
define({PUSH_STORE},{
    ld   format({%-15s},($1){,} HL); 3:16      $1 ! push($1) store
    ex   DE, HL         ; 1:4       $1 ! push($1) store
    pop  DE             ; 1:10      $1 ! push($1) store})dnl
dnl
dnl
dnl addr C!
dnl ( char -- )
dnl store(addr) store 8-bit char at addr
define({PUSH_CSTORE},{
    ld    A, L          ; 1:4       $1 C! push($1) cstore
    ld    format({%-15s},($1){,} A); 3:13      $1 C! push($1) cstore
    ex   DE, HL         ; 1:4       $1 C! push($1) cstore
    pop  DE             ; 1:10      $1 C! push($1) cstore})dnl
dnl
dnl
dnl x addr !
dnl ( -- )
dnl store(addr) store 16-bit number at addr
define({PUSH2_STORE},{
    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      push2_store($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_store($1,$2)})dnl
dnl
dnl
dnl char addr C!
dnl ( -- )
dnl store(addr) store 8-bit number at addr
define({PUSH2_CSTORE},{
    ld    A, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:13},{2:7 })      push2_cstore($1,$2)
    ld   format({%-15s},($2){,} A); 3:13      push2_cstore($1,$2)})dnl
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
define({PUSH2_ADDSTORE},{
    push HL             ; 1:11      push2_addstore($1,$2)
    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      push2_addstore($1,$2)
    ld   HL, format({%-11s},{($2)}); 3:16      push2_addstore($1,$2)
    add  HL, BC         ; 1:11      push2_addstore($1,$2)
    ld   format({%-15s},($2){,} HL); 3:16      push2_addstore($1,$2)
    pop  HL             ; 1:10      push2_addstore($1,$2)})dnl
dnl
dnl
dnl cmove
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVE},{
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove})dnl
dnl
dnl
dnl cmove>
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVEGT},{
    ld    A, H          ; 1:4       cmove>
    or    L             ; 1:4       cmove>
    ld    B, H          ; 1:4       cmove>
    ld    C, L          ; 1:4       cmove> BC = u
    pop  HL             ; 1:10      cmove> HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove>
    lddr                ; 2:u*21/16 cmove>
    pop  HL             ; 1:10      cmove>
    pop  DE             ; 1:10      cmove>})dnl
dnl
dnl
dnl move
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVE},{
    or    A             ; 1:4       move
    adc  HL, HL         ; 1:11      move
    ld    B, H          ; 1:4       move
    ld    C, L          ; 1:4       move BC = 2*u
    pop  HL             ; 1:10      move HL = from = addr1
    jr    z, $+4        ; 2:7/12    move
    ldir                ; 2:u*42/32 move
    pop  HL             ; 1:10      move
    pop  DE             ; 1:10      move})dnl
dnl
dnl
dnl move>
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVEGT},{
    or    A             ; 1:4       move>
    adc  HL, HL         ; 1:11      move>
    ld    B, H          ; 1:4       move>
    ld    C, L          ; 1:4       move> BC = 2*u
    pop  HL             ; 1:10      move> HL = from = addr1
    jr    z, $+4        ; 2:7/12    move>
    lddr                ; 2:u*42/32 move>
    pop  HL             ; 1:10      move>
    pop  DE             ; 1:10      move>})dnl
dnl
dnl
dnl
dnl ( -- random )
define({RND},{ifdef({USE_Rnd},,define({USE_Rnd},{}))
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd})dnl
dnl
dnl
dnl ( max -- random )
define({RANDOM},{ifdef({USE_Random},,define({USE_Random},{}))
    call Random         ; 3:17      random})dnl
dnl
dnl
dnl
dnl ( yx -- addr )
define({PUTPIXEL},{ifdef({USE_PIXEL},,define({USE_PIXEL},{}))
    call PIXEL          ; 3:17      pixel})dnl
dnl
dnl
dnl

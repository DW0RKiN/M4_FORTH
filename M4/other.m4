dnl ( -- )
dnl Save shadow reg.
define(INIT,{
;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, ifelse($1,{},{60000
    .warning "Missing value for return address stack. The init() macro has no parameter!"},{$1})
    exx})dnl
dnl
dnl ( -- )
dnl Save shadow reg.
define(STOP,{
    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====})dnl
dnl
dnl
dnl
define({CONSTANT},{EQU})dnl
dnl
dnl
define({ALL_VARIABLE},{
VARIABLE_SECTION:
})dnl
dnl
define({VARIABLE},{define({ALL_VARIABLE},{
}ALL_VARIABLE{
$1: dw 0x0000})})dnl
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
dnl
dnl ( -- x )
dnl xfetch(addr) load 16-bit number from addr
define({XFETCH},{
    push DE             ; 1:11      @ xfetch 
    ex   DE, HL         ; 1:4       @ xfetch
    ld   HL,format({%-12s},($1)); 3:16      @ xfetch})dnl
dnl
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
dnl ( x -- )
dnl store(addr) store 16-bit number at addr
define({XSTORE},{
    ld   format({%-15s},($1){,} HL); 3:16      ! xstore
    ex   DE, HL         ; 1:10      ! xstore
    pop  DE             ; 1:10      ! xstore})dnl
dnl
dnl
dnl
dnl +!
dnl ( nun addr -- )
dnl Adds num to the 16-bit number stored at addr.
define({PLUS_STORE},{
    ld    A, E          ; 1:4       +! plus_store
    add   A,(HL)        ; 1:7       +! plus_store
    ld  (HL),A          ; 1:7       +! plus_store
    inc  HL             ; 1:6       +! plus_store
    ld    A, D          ; 1:4       +! plus_store
    add   A,(HL)        ; 1:7       +! plus_store
    ld  (HL),A          ; 1:7       +! plus_store
    pop  HL             ; 1:10      +! plus_store
    pop  DE             ; 1:10      +! plus_store})dnl
dnl
dnl
dnl cmove
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVE},{
    ld    A, H          ; 1:4       move
    or    L             ; 1:4       move
    ld    B, H          ; 1:4       move
    ld    C, L          ; 1:4       move BC = u
    pop   HL            ; 1:10      move from = addr1
    jr    z, $+4        ; 2:7/12    move
    ldir                ; 2:x*21/16 move
    pop   HL            ; 1:10      move
    pop   DE            ; 1:10      move})dnl
dnl
dnl

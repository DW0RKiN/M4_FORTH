dnl ( -- )
dnl Save shadow reg.
define(INIT,{
;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld   HL, $1
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
    ld    L, (HL)       ; 1:7       @ fetch
    ld    H, A          ; 1:4       @ fetch})dnl
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
    ld  (HL), D         ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL), E         ; 1:7       ! store
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

dnl ## Definice funkce
dnl
dnl ( -- )
dnl call function
define(CALL,{
    call format({%-15s},$1); 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )}){}dnl
dnl
dnl
dnl ( -- )
dnl save return to (HL')
define(COLON,{
pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  b e g i n  ---
format({%-24s;           $2},FCE_STACK:)
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )}){}dnl
dnl
dnl
dnl ( -- )
dnl return
define(EXIT,{
    jp   format({%-15s},FCE_STACK{}_end); 3:10      exit})dnl
dnl
dnl
dnl ( -- )
dnl return from function
define(SEMICOLON,{
FCE_STACK{}_end:popdef({FCE_STACK})
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----})dnl
dnl
dnl
dnl ( -- ret )
dnl call function
define(SCALL,{
    call format({%-15s},$1); 3:17      scall})dnl
dnl
dnl
dnl ( ret -- ret )
define(SCOLON,{
pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  b e g i n  ---
format({%-24s;           $2},FCE_STACK:)})dnl
dnl
dnl
dnl ( ret -- )
dnl return
define(SEXIT,{
    ret                 ; 1:10      sexit})dnl
dnl
dnl
dnl ( ret -- )
dnl return from function
define(SSEMICOLON,{
FCE_STACK{}_end:popdef({FCE_STACK})
    ret                 ; 1:10      s;
;   -----  e n d  -----})dnl
dnl
dnl
dnl

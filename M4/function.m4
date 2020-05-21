dnl ## Definice funkce
dnl
dnl ( --  )
dnl call function
define(CALL,{
    call format({%-15s},$1); 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call})dnl
dnl
dnl ( -- )
dnl save return to (HL})
define(COLON,{
pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  b e g i n  ---
format({%-24s;           $2},format({%s:},FCE_STACK))
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :})dnl
dnl
dnl
dnl ( -- )
dnl return
define(EXIT,{
    jp   format({%-15s},FCE_STACK{}_end); 3:10})dnl
dnl
dnl
dnl ( -- )
dnl return from functionx = x1 & x2
define(SEMICOLON,{
FCE_STACK{}_end:popdef({FCE_STACK})
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----})dnl
dnl
dnl

dnl ## Definice funkce
dnl
dnl ( -- )
dnl recursion call function
define(RCALL,{
    call format({%-15s},$1); 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall R:( ret -- )}){}dnl
dnl
dnl
dnl ( -- )
dnl save return to (HL')
define(RCOLON,{
pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  the beginning of a recursive function  ---
format({%-24s;           $2},FCE_STACK:)
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  (HL),D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  (HL),E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon R:( -- ret )}){}dnl
dnl
dnl
dnl ( -- )
dnl return
define(REXIT,{
    jp   format({%-15s},FCE_STACK{}_end); 3:10      rexit})dnl
dnl
dnl
dnl ( -- )
dnl recursion return from function
define(RSEMICOLON,{
FCE_STACK{}_end:popdef({FCE_STACK})
    exx                 ; 1:4       ; rsemicilon
    ld    E,(HL)        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,(HL)        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  (HL)            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------})dnl
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
;   ---  the beginning of a data stack function  ---
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
;   ---------  end of data stack function  ---------})dnl
dnl
dnl
dnl ( -- )
dnl no recursion call function
define(CALL,{
    call format({%-15s},$1); 3:17      call ( -- ret ) R:( -- )}){}dnl
dnl
dnl
dnl ( -- )
dnl save return to (HL')
define(COLON,{
pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  the beginning of a non-recursive function  ---
format({%-24s;           $2},FCE_STACK:)
    pop  BC             ; 1:10      : ret
    ld  format({%-16s},(FCE_STACK{}_end+1){,}BC); 4:20      : ( ret -- ) R:( -- )}){}dnl
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
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------})dnl
dnl
dnl
dnl

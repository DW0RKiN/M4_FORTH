dnl ## Definice funkce
dnl
dnl ( -- )
dnl recursion call function
define({RCALL},{
    call format({%-15s},$1); 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall R:( ret -- )}){}dnl
dnl
dnl
dnl ( addr -- )
dnl recursion call function
define({REXECUTE},{
                       ;[10:55]     rexecute  ( addr -- ) R:( -- ret )
    ld format({%-17s},{($+6),HL}); 3:16      rexecute
    ex   DE, HL         ; 1:4       rexecute
    pop  DE             ; 1:10      rexecute
    call 0x0000         ; 3:17      rexecute
    ex   DE, HL         ; 1:4       rexecute
    exx                 ; 1:4       rexecute  R:( ret -- )}){}dnl
dnl
dnl
dnl ( addr -- addr )
dnl recursion call function
define({DUP_REXECUTE},{
                        ;[5:25]     dup_rexecute  ( addr -- ) R:( -- )
    ld   BC, $+5        ; 3:10      dup_rexecute
    push BC             ; 1:11      dup_rexecute
    jp  (HL)            ; 1:4       dup_rexecute
    ex   DE, HL         ; 1:4       dup_rexecute
    exx                 ; 1:4       dup_rexecute  R:( ret -- )}){}dnl
dnl
dnl
dnl ( -- )
dnl save return to (HL')
define({RCOLON},{
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
define({REXIT},{
    jp   format({%-15s},FCE_STACK{}_end); 3:10      rexit})dnl
dnl
dnl
dnl ( -- )
dnl recursion return from function
define({RSEMICOLON},{
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
dnl ( b a -- ret b a )
dnl call function
define({SCALL},{
    call format({%-15s},$1); 3:17      scall})dnl
dnl
dnl
dnl ( ret b a -- ret b a )
define({SCOLON},{
pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  the beginning of a data stack function  ---
format({%-24s;           $2},FCE_STACK:)})dnl
dnl
dnl
dnl ( ret b a -- b a )
dnl return
define({SEXIT},{
    ret                 ; 1:10      sexit})dnl
dnl
dnl
dnl ( ret -- )
dnl return from function
define({SSEMICOLON},{
FCE_STACK{}_end:popdef({FCE_STACK})
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------})dnl
dnl
dnl
dnl ( -- )
dnl no recursion call function
define({CALL},{
    call format({%-15s},$1); 3:17      call ( -- )}){}dnl
dnl
dnl
dnl ( addr -- )
dnl no recursion call function
define({EXECUTE},{
                        ;[8:47]     execute  ( addr -- )
    ld format({%-17s},{($+6),HL}); 3:16      execute
    ex   DE, HL         ; 1:4       execute
    pop  DE             ; 1:10      execute
    call 0x0000         ; 3:17      execute}){}dnl
dnl
dnl
dnl ( addr -- addr )
dnl no recursion call function
define({DUP_EXECUTE},{
                        ;[5:25]     dup_execute  ( addr -- addr )
    ld   BC, $+5        ; 3:10      dup_execute
    push BC             ; 1:11      dup_execute
    jp  (HL)            ; 1:4       dup_execute}){}dnl
dnl
dnl
dnl ( -- )
dnl save return to (HL')
define({COLON},{
pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  the beginning of a non-recursive function  ---
format({%-24s;           $2},FCE_STACK:)
    pop  BC             ; 1:10      : ret
    ld  format({%-16s},(FCE_STACK{}_end+1){,}BC); 4:20      : ( ret -- )}){}dnl
dnl
dnl
dnl ( -- )
dnl return
define({EXIT},{
    jp   format({%-15s},FCE_STACK{}_end); 3:10      exit})dnl
dnl
dnl
dnl ( -- )
dnl return from function
define({SEMICOLON},{
FCE_STACK{}_end:popdef({FCE_STACK})
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------})dnl
dnl
dnl
dnl

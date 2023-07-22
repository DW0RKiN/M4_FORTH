dnl ## Definice funkce
dnl
dnl # ( -- )
dnl # recursion call function
define({RCALL},{dnl
__{}__ADD_TOKEN({__TOKEN_RCALL},{rcall},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RCALL},{dnl
__{}define({__INFO},{rcall}){}dnl

    call format({%-15s},$1); 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall R:( ret -- )}){}dnl
dnl
dnl
dnl # ( addr -- )
dnl # recursion call function
define({REXECUTE},{dnl
__{}__ADD_TOKEN({__TOKEN_REXECUTE},{rexecute},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_REXECUTE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[10:55]     __INFO  ( addr -- ) R:( -- ret )
    ld  ($+6),HL        ; 3:16      __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    call 0x0000         ; 3:17      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO  R:( ret -- )}){}dnl
dnl
dnl
dnl # ( addr -- addr )
dnl # recursion call function
define({DUP_REXECUTE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_REXECUTE},{dup rexecute},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_REXECUTE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:25]     __INFO  ( addr -- ) R:( -- )
    ld   BC, $+5        ; 3:10      __INFO
    push BC             ; 1:11      __INFO
    jp  (HL)            ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO  R:( ret -- )}){}dnl
dnl
dnl
dnl # ( addr x -- addr x )
dnl # recursion call function
define({OVER_REXECUTE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_REXECUTE},{over rexecute},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_REXECUTE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:45]     __INFO  ( addr -- ) R:( -- )
    ld  ($+5),DE        ; 4:20      __INFO
    call 0x0000         ; 3:17      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO  R:( ret -- )}){}dnl
dnl
dnl
dnl # ( -- )
dnl # save return to (HL')
define({RCOLON},{dnl
__{}__ADD_TOKEN({__TOKEN_RCOLON},{rcolon},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RCOLON},{dnl
__{}define({__INFO},{rcolon}){}dnl

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
dnl # ( -- )
dnl # return
define({REXIT},{dnl
__{}__ADD_TOKEN({__TOKEN_REXIT},{rexit},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_REXIT},{dnl
__{}define({__INFO},{rexit}){}dnl

    jp   format({%-15s},FCE_STACK{}_end); 3:10      rexit})dnl
dnl
dnl
dnl # ( -- )
dnl # recursion return from function
define({RSEMICOLON},{dnl
__{}__ADD_TOKEN({__TOKEN_RSEMICOLON},{rsemicolon},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RSEMICOLON},{dnl
__{}define({__INFO},{rsemicolon}){}dnl

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
dnl # ( b a -- ret b a )
dnl # call function
define({SCALL},{dnl
__{}__ADD_TOKEN({__TOKEN_SCALL},{scall},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SCALL},{dnl
__{}define({__INFO},{scall}){}dnl

    call format({%-15s},$1); 3:17      scall})dnl
dnl
dnl
dnl # ( ret b a -- ret b a )
define({SCOLON},{dnl
__{}__ADD_TOKEN({__TOKEN_SCOLON},{scolon},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SCOLON},{dnl
__{}define({__INFO},{scolon}){}dnl

pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  the beginning of a data stack function  ---
format({%-24s;           $2},FCE_STACK:)})dnl
dnl
dnl
dnl # ( ret b a -- b a )
dnl # return
define({SEXIT},{dnl
__{}__ADD_TOKEN({__TOKEN_SEXIT},{sexit},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SEXIT},{dnl
__{}define({__INFO},{sexit}){}dnl

    ret                 ; 1:10      sexit})dnl
dnl
dnl
dnl # ( ret -- )
dnl # return from function
define({SSEMICOLON},{dnl
__{}__ADD_TOKEN({__TOKEN_SSEMICOLON},{ssemicolon},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SSEMICOLON},{dnl
__{}define({__INFO},{ssemicolon}){}dnl

FCE_STACK{}_end:popdef({FCE_STACK})
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------})dnl
dnl
dnl
dnl # ( -- )
dnl # no recursion call function
define({CALL},{dnl
__{}__ADD_TOKEN({__TOKEN_CALL},{call},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CALL},{dnl
__{}define({__INFO},__COMPILE_INFO)
    call format({%-15s},$1); 3:17      call ifelse($2,,( -- ),$2)}){}dnl
dnl
dnl
dnl # ( addr -- )
dnl # no recursion call function
define({EXECUTE},{dnl
__{}__ADD_TOKEN({__TOKEN_EXECUTE},{execute},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_EXECUTE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:47]     __INFO  ( addr -- )
    ld  ($+6),HL        ; 3:16      __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    call 0x0000         ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( addr -- addr )
dnl # no recursion call function
define({DUP_EXECUTE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_EXECUTE},{dup execute},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_EXECUTE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:25]     __INFO  ( addr -- addr )
    ld   BC, $+5        ; 3:10      __INFO
    push BC             ; 1:11      __INFO
    jp  (HL)            ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( addr x -- addr x )
dnl # no recursion call function
define({OVER_EXECUTE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_EXECUTE},{over execute},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_EXECUTE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:37]     __INFO  ( addr x -- addr x )
    ld  ($+5),DE        ; 4:20      __INFO
    call 0x0000         ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( -- )
dnl # save return to (HL')
define({COLON},{dnl
__{}__ADD_TOKEN({__TOKEN_COLON},{colon},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_COLON},{dnl
__{}define({__INFO},{colon}){}dnl

pushdef({FCE_STACK},{patsubst({$1}, { *$}, {})})dnl
;   ---  the beginning of a non-recursive function  ---
format({%-24s;           $2},FCE_STACK:)
    pop  BC             ; 1:10      : ret
    ld  format({%-16s},(FCE_STACK{}_end+1){,}BC); 4:20      : ( ret -- )}){}dnl
dnl
dnl
dnl # ( -- )
dnl # return
define({EXIT},{dnl
__{}__ADD_TOKEN({__TOKEN_EXIT},{exit},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_EXIT},{dnl
__{}define({__INFO},{exit}){}dnl

    jp   format({%-15s},FCE_STACK{}_end); 3:10      exit})dnl
dnl
dnl
dnl # ( -- )
dnl # return from function
define({SEMICOLON},{dnl
__{}__ADD_TOKEN({__TOKEN_SEMICOLON},{semicolon},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SEMICOLON},{dnl
__{}define({__INFO},{semicolon}){}dnl

FCE_STACK{}_end:popdef({FCE_STACK})
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------})dnl
dnl
dnl
dnl

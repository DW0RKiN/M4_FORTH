dnl ## recursive rdo rloop
dnl
dnl # DO(R)         LOOP
dnl # DO(R)         ADDLOOP
dnl # DO(R)         PUSH_ADDLOOP(step)
dnl # QUESTIONDO(R) LOOP
dnl # QUESTIONDO(R) ADDLOOP
dnl # QUESTIONDO(R) PUSH_ADDLOOP(step)
dnl
dnl
dnl # do(r)
define({__ASM_TOKEN_RDO},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{0xFFFF::},{
__{}__{}                       ;[20:138]    __INFO   ( stop index -- ) ( R: -- stop-1 index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  DE             ; 1:6       __INFO   DE = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( R: stop-1 index -- stop-1 index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},

__{}__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
__{}__{}                       ;[19:132]    __INFO   ( stop index -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( R: stop index -- stop index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},

__{}__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_END($1):__HAS_PTR(__GET_LOOP_BEGIN($1)),{0xFFFF::1},{
__{}__{}                       ;[20:123]    __INFO   ( stop -- ) ( R: -- stop-1 index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  DE             ; 1:6       __INFO   DE = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO  DE = index = __GET_LOOP_BEGIN($1)
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( R: stop-1 index -- stop-1 index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},

__{}__GET_LOOP_END($1):__HAS_PTR(__GET_LOOP_BEGIN($1)),{:1},{
__{}__{}                       ;[19:117]    __INFO   ( stop -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO  DE = index = __GET_LOOP_BEGIN($1)
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( R: stop index -- stop index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},

__{}__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_END($1),{0xFFFF:},{
__{}__{}                       ;[19:113]    __INFO   ( stop -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  DE             ; 1:6       __INFO   DE = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( R: stop index -- stop index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},

__{}__GET_LOOP_END($1),{},{
__{}__{}                       ;[18:107]    __INFO   ( stop -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( R: stop index -- stop index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},

__{}__GET_LOOP_BEGIN($1),{},{
__{}__{}                        ;[9:65]     __INFO   ( index -- ) ( R: -- index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1{}save:              ;           __INFO   ( R: index -- index )
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},

__{}{
__{}__{}                        ;[9:42]     __INFO   ( __GET_LOOP_BEGIN($1) __GET_LOOP_END($1) -- ) ( R: -- index )
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1{}save:              ;           __INFO   ( R: index -- index )
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # do(r) i
define({__ASM_TOKEN_RDO_I},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{0xFFFF::},{
__{}__{}                       ;[23:172]    __INFO   ( stop index -- ) ( R: -- stop-1 index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  DE             ; 1:6       __INFO   DE = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( -- index ) ( R: stop-1 index -- stop-1 index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ex  [SP], HL        ; 1:19      __INFO},

__{}__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
__{}__{}                       ;[22:166]    __INFO   ( stop index -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( -- index ) ( R: stop index -- stop index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ex  [SP], HL        ; 1:19      __INFO},

__{}__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_END($1):__HAS_PTR(__GET_LOOP_BEGIN($1)),{0xFFFF::1},{
__{}__{}                       ;[23:157]    __INFO   ( stop -- ) ( R: -- stop-1 index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  DE             ; 1:6       __INFO   DE = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO  DE = index = __GET_LOOP_BEGIN($1)
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( -- index ) ( R: stop-1 index -- stop-1 index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ex  [SP], HL        ; 1:19      __INFO},

__{}__GET_LOOP_END($1):__HAS_PTR(__GET_LOOP_BEGIN($1)),{:1},{
__{}__{}                       ;[22:151]    __INFO   ( stop -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO  DE = index = __GET_LOOP_BEGIN($1)
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( -- index ) ( R: stop index -- stop index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ex  [SP], HL        ; 1:19      __INFO},

__{}__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_END($1),{0xFFFF:},{
__{}__{}                       ;[22:147]    __INFO   ( stop -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  DE             ; 1:6       __INFO   DE = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( -- index ) ( R: stop index -- stop index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ex  [SP], HL        ; 1:19      __INFO},

__{}__GET_LOOP_END($1),{},{
__{}__{}                       ;[21:141]    __INFO   ( stop -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}do{}$1{}save1:             ;           __INFO   ( -- index ) ( R: stop index -- stop index )
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ex  [SP], HL        ; 1:19      __INFO},

__{}__GET_LOOP_BEGIN($1),{},{
__{}__{}                       ;[12:99]     __INFO   ( index -- ) ( R: -- index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1{}save:              ;           __INFO   ( -- index ) ( R: index -- index )
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ex  [SP], HL        ; 1:19      __INFO},

__{}{
__{}__{}                       ;[12:76]     __INFO   ( __GET_LOOP_BEGIN($1) __GET_LOOP_END($1) -- ) ( R: -- index )
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1{}save:              ;           __INFO   ( -- index ) ( R: index -- index )
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ex  [SP], HL        ; 1:19      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ?do(r)
define({__ASM_TOKEN_QRDO},{dnl
__{}define({__INFO},__COMPILE_INFO{(r)}){}dnl
__{}ifelse(dnl
__{}ifelse(__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{0xFFFF::},{
__{}__{}                       ;[29:171]    __INFO   ( stop index -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}__{}    dec  BC             ; 1:6       __INFO   BC = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],B          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],C          ; 1:7       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor   E             ; 1:4       __INFO
__{}__{}    jr   nz, do{}$1{}save2 ; 2:7/12    __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}__{}do{}$1{}save1:             ;           __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( R: stop-1 index -- stop-1 index )},

__{}__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
__{}__{}                       ;[28:165]    __INFO   ( stop index -- ) ( R: -- stop index )
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],B          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],C          ; 1:7       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor   E             ; 1:4       __INFO
__{}__{}    jr   nz, do{}$1{}save2 ; 2:7/12    __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}__{}do{}$1{}save1:             ;           __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( R: stop index -- stop index )},

__{}__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_END($1):__HAS_PTR(__GET_LOOP_BEGIN($1)),{0xFFFF::1},{
__{}__{}                       ;[29:156]    __INFO
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}__{}    dec  BC             ; 1:6       __INFO   BC = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],B          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],C          ; 1:7       __INFO
__{}__{}    ld   DE, format({%-11s},__SIMPLIFY_EXPRESSION(__GET_LOOP_BEGIN($1))); 4:20      __INFO   DE = __GET_LOOP_BEGIN($1) = index
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor   E             ; 1:4       __INFO
__{}__{}    jr   nz, do{}$1{}save2 ; 2:7/12    __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}__{}do{}$1{}save1:             ;           __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( R: -- stop-1 index )},

__{}__GET_LOOP_END($1):__HAS_PTR(__GET_LOOP_BEGIN($1)),{:1},{
__{}__{}                       ;[28:150]    __INFO
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],B          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],C          ; 1:7       __INFO
__{}__{}    ld   DE, format({%-11s},__SIMPLIFY_EXPRESSION(__GET_LOOP_BEGIN($1))); 4:20      __INFO   DE = __GET_LOOP_BEGIN($1) = index
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor   E             ; 1:4       __INFO
__{}__{}    jr   nz, do{}$1{}save2 ; 2:7/12    __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}__{}do{}$1{}save1:             ;           __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( R: -- stop index )},

__{}__HEX_HL(__GET_LOOP_STEP($1)):__GET_LOOP_END($1),{0xFFFF:},{
__{}__{}                       ;[28:146]    __INFO
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}__{}    dec  BC             ; 1:6       __INFO   BC = stop-1
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],B          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],C          ; 1:7       __INFO
__{}__{}    ld   DE, format({%-11s},__SIMPLIFY_EXPRESSION(__GET_LOOP_BEGIN($1))); 3:10      __INFO   DE = index
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor   E             ; 1:4       __INFO
__{}__{}    jr   nz, do{}$1{}save2 ; 2:7/12    __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}__{}do{}$1{}save1:             ;           __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( R: -- stop-1 index )},

__{}__GET_LOOP_END($1),{},{
__{}__{}                       ;[27:140]    __INFO
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],B          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],C          ; 1:7       __INFO
__{}__{}    ld   DE, format({%-11s},__SIMPLIFY_EXPRESSION(__GET_LOOP_BEGIN($1))); 3:10      __INFO   DE = index
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    xor   E             ; 1:4       __INFO
__{}__{}    jr   nz, do{}$1{}save2 ; 2:7/12    __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}__{}do{}$1{}save1:             ;           __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}do{}$1{}save2:             ;           __INFO    
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( R: -- stop index )},

__{}__GET_LOOP_BEGIN($1),{},{
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- ) ( R: -- index )){}dnl
__{}__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),14,83,0,0){}dnl
__{}__{}_TMP_BEST_CODE
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    jp   nz, exit{}$1    ; 3:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1save:              ;           __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},

__{}__{}__SIMPLIFY_EXPRESSION(__GET_LOOP_BEGIN($1)),__SIMPLIFY_EXPRESSION(__GET_LOOP_END($1)),{
__{}__{}                        ;[5:18]     __INFO   ( -- ) ( R: -- )  __GET_LOOP_BEGIN($1) == __GET_LOOP_END($1) 
__{}__{}    jp   exit{}$1        ; 3:10      __INFO
__{}__{}do{}$1save:               ;           __INFO},

__{}{
__{}__{}                       ;ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,[10:52],[ 9:42])     __INFO   ( __GET_LOOP_BEGIN($1) __GET_LOOP_END($1) -- ) ( R: -- index )
__{}__{}    exx                 ; 1:4       __INFO{}dnl
__{}__{}ifelse(__HAS_PTR(__GET_LOOP_BEGIN($1)),1,{
__{}__{}__{}    ld   DE,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO   DE = index},
__{}__{}{
__{}__{}__{}    ld   DE, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index})
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1save:              ;           __INFO
__{}__{}    ld  [HL],D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  [HL],E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # ------------------------------------- loop ---------------------------------------------
dnl
dnl
dnl # loop(r)
define({__ASM_TOKEN_RLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
__{}__{}                       ;[19:90]     __INFO   ( R: stop index -- stop index )
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    ld    A,[HL]        ; 1:7       __INFO
__{}__{}    xor   E             ; 1:4       __INFO   lo(index ^ stop)
__{}__{}    jp   nz, do{}$1save2 ; 3:10      __INFO
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    xor [HL]            ; 1:7       __INFO   hi(index ^ stop)
__{}__{}    jp   nz, do{}$1save1 ; 3:10      __INFO},

__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,{
__{}__{}                       ;[12:56]     __INFO   variant: stop = 0
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    or    D             ; 1:4       __INFO
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO},

__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,{
__{}__{}                       ;[12:56]     __INFO   variant: stop = 1
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    or    D             ; 1:4       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO},

__{}__HEX_H(__GET_LOOP_END($1)),0x00,{
__{}__{}                       ;[14:63]     __INFO   variant: hi8(stop) = 0
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    ld    A, format({%-11s},low __GET_LOOP_END($1)); 2:7       __INFO   lo stop
__{}__{}    xor   E             ; 1:4       __INFO   lo(index ^ stop)
__{}__{}    or    D             ; 1:4       __INFO   hi(stop) = 0
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO},

__{}__HEX_L(__GET_LOOP_END($1)),0x00,{
__{}__{}                       ;[14:63]     __INFO   variant: lo8(stop) = 0
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    ld    A, format({%-11s},high __GET_LOOP_END($1)); 2:7       __INFO   hi stop
__{}__{}    xor   D             ; 1:4       __INFO   hi(index ^ stop)
__{}__{}    or    E             ; 1:4       __INFO   lo(stop) = 0
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO},

__{}__HAS_PTR(__GET_LOOP_END($1)-1),1,{
__{}__{}                       ;[21:92]     __INFO   variant: stop is pointer
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    ld    A, format({%-11s},__PTR_ADD(__GET_LOOP_END($1),0)); 3:13      __INFO   lo(stop)
__{}__{}    xor   E             ; 1:4       __INFO   lo(index++ ^ stop)
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO
__{}__{}    ld    A, format({%-11s},__PTR_ADD(__GET_LOOP_END($1),1)); 3:13      __INFO   hi(stop)
__{}__{}    xor   D             ; 1:4       __INFO   hi(index++ ^ stop)
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO},

__{}__IS_NUM(__GET_LOOP_END($1)),0,{
__{}__{}                       ;[19:80]     __INFO   variant: stop is unknown
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  DE             ; 1:6       __INFO   index++
__{}__{}    ld    A, format({%-11s},low __GET_LOOP_END($1)); 2:7       __INFO   lo stop
__{}__{}    xor   E             ; 1:4       __INFO   lo(index ^ stop
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO
__{}__{}    ld    A, format({%-11s},high __GET_LOOP_END($1)); 2:7       __INFO   hi stop
__{}__{}    xor   D             ; 1:4       __INFO   hi(index ^ stop
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO},

__{}{
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  DE             ; 1:6       __INFO   index++{}dnl
__{}__{}ifelse(__HEX_L(__GET_LOOP_END($1)),0x01,{
__{}__{}__{}define({__TMP_A},0x00){}dnl
__{}__{}__{}    ld    A, E          ; 1:4       __INFO   lo index
__{}__{}__{}    dec   A             ; 1:4       __INFO   lo(index ^ stop)},
__{}__{}__HEX_L(__GET_LOOP_END($1)),0xFF,{
__{}__{}__{}define({__TMP_A},0x00){}dnl
__{}__{}__{}    ld    A, E          ; 1:4       __INFO   lo index
__{}__{}__{}    inc   A             ; 1:4       __INFO   lo(index ^ stop)},
__{}__{}_HEX_H(__GET_LOOP_END($1)),__HEX_L(__GET_LOOP_END($1)),{
__{}__{}__{}define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
__{}__{}__{}    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),__HEX_L(1+__GET_LOOP_END($1)),{
__{}__{}__{}define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
__{}__{}__{}    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),__HEX_L(__GET_LOOP_END($1)-1),{
__{}__{}__{}define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
__{}__{}__{}    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),__HEX_L(2*__GET_LOOP_END($1)),{
__{}__{}__{}define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
__{}__{}__{}    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),__HEX_L(__HEX_L(__GET_LOOP_END($1))/2),{
__{}__{}__{}define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
__{}__{}__{}    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__{}__{}{
__{}__{}__{}define({__TMP_A},0){}dnl
__{}__{}__{}    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
__{}__{}__{}    xor   E             ; 1:4       __INFO   lo(index ^ stop)})
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO{}dnl
__{}__{}ifelse(__HEX_H(__GET_LOOP_END($1)),__TMP_A,{
__{}__{}__{}    xor   D             ; 1:4       __INFO   hi(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),0x01,{
__{}__{}__{}    ld    A, D          ; 1:4       __INFO   hi index
__{}__{}__{}    dec   A             ; 1:4       __INFO   hi(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),0xFF,{
__{}__{}__{}    ld    A, D          ; 1:4       __INFO   hi index
__{}__{}__{}    inc   A             ; 1:4       __INFO   hi(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),__HEX_L(1+__TMP_A),{
__{}__{}__{}    inc   A             ; 1:4       __INFO   hi(stop) = __HEX_H(__GET_LOOP_END($1))
__{}__{}__{}    cp    D             ; 1:4       __INFO   hi(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),__HEX_L(__TMP_A-1),{
__{}__{}__{}    dec   A             ; 1:4       __INFO   hi(stop) = __HEX_H(__GET_LOOP_END($1))
__{}__{}__{}    cp    D             ; 1:4       __INFO   hi(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),__HEX_L(2*__TMP_A),{
__{}__{}__{}    add   A, A          ; 1:4       __INFO   hi(stop) = __HEX_H(__GET_LOOP_END($1))
__{}__{}__{}    cp    D             ; 1:4       __INFO   hi(index ^ stop)},
__{}__{}__HEX_H(__GET_LOOP_END($1)),__HEX_L(__TMP_A/2),{
__{}__{}__{}    rra                 ; 1:4       __INFO   hi(stop) = __HEX_H(__GET_LOOP_END($1))
__{}__{}__{}    cp    D             ; 1:4       __INFO   hi(index ^ stop)},
__{}__{}{
__{}__{}__{}    ld    A, __HEX_H(__GET_LOOP_END($1))       ; 2:7       __INFO   hi stop
__{}__{}__{}    xor   D             ; 1:4       __INFO   hi(index ^ stop)})
__{}__{}    jp   nz, do{}$1save  ; 3:10      __INFO{}dnl
__{}})
__{}leave{}$1:               ;           __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    exx                 ; 1:4       __INFO
__{}exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # -1 +loop(r)
define({__ASM_TOKEN_SUB1_ADDRLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(r)}){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
                       ;[19:90]     __INFO   ( R: stop-1 index -- stop-1 index )
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    inc  HL             ; 1:6       __INFO
    dec  DE             ; 1:6       __INFO   index--
    ld    A,[HL]        ; 1:7       __INFO
    xor   E             ; 1:4       __INFO   lo8(--index ^ --stop)
    jp   nz, do{}$1save2 ; 3:10      __INFO
    inc   L             ; 1:4       __INFO
    ld    A,[HL]        ; 1:7       __INFO
    xor   D             ; 1:4       __INFO   hi8(--index ^ --stop)
    jp   nz, do{}$1save1 ; 3:10      __INFO},
    
__HEX_HL(__GET_LOOP_END($1)-1),0xFFFF,{
                       ;[12:56]     __INFO   variant: stop-1 = -1
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    ld    A, E          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    dec  DE             ; 1:6       __INFO   index--
    jp   nz, do{}$1save  ; 3:10      __INFO},
    
__HEX_HL(__GET_LOOP_END($1)-1),0x0000,{
                       ;[12:56]     __INFO   variant: stop-1 = 0
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
    ld    A, E          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    jp   nz, do{}$1save  ; 3:10      __INFO},
    
__HEX_H(__GET_LOOP_END($1)-1),0x00,{
                       ;[14:63]     __INFO   variant: hi8(stop-1) = 0
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
    ld    A, format({%-11s},low __GET_LOOP_END($1)-1); 2:7       __INFO   lo stop-1
    xor   E             ; 1:4       __INFO   lo(index ^ stop-1)
    or    D             ; 1:4       __INFO   hi(stop-1) = 0
    jp   nz, do{}$1save  ; 3:10      __INFO},
    
__HEX_L(__GET_LOOP_END($1)-1),0x00,{
                       ;[14:63]     __INFO   variant: lo8(stop-1) = 0
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
    ld    A, format({%-11s},high __GET_LOOP_END($1)-1); 2:7       __INFO   hi stop-1
    xor   D             ; 1:4       __INFO   hi(index ^ stop-1)
    or    E             ; 1:4       __INFO   lo(stop-1) = 0
    jp   nz, do{}$1save  ; 3:10      __INFO},
   
__HAS_PTR(__GET_LOOP_END($1)-1),1,{
                       ;[21:94]     __INFO   variant: stop is pointer
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    ld   BC, format({%-11s},__GET_LOOP_END($1)); 4:20      __INFO   stop    
    ld    A, E          ; 1:4       __INFO   lo index
    xor   C             ; 1:4       __INFO   lo(index ^ stop)
    ld    A, D          ; 1:4       __INFO   hi index    
    dec  DE             ; 1:6       __INFO   index--
    jp   nz, do{}$1save  ; 3:10      __INFO
    xor   B             ; 1:4       __INFO   hi(index ^ stop)
    jp   nz, do{}$1save  ; 3:10      __INFO},
   
__IS_NUM(__GET_LOOP_END($1)-1),0,{
                       ;[19:80]     __INFO   variant: stop is unknown
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
    ld    A, format({%-11s},low __SIMPLIFY_EXPRESSION(-1+__GET_LOOP_END($1))); 2:7       __INFO   lo stop-1
    xor   E             ; 1:4       __INFO   lo(index ^ stop-1
    jp   nz, do{}$1save  ; 3:10      __INFO
    ld    A, format({%-11s},high __SIMPLIFY_EXPRESSION(-1+__GET_LOOP_END($1))); 2:7       __INFO   hi stop-1
    xor   D             ; 1:4       __INFO   hi(index ^ stop-1
    jp   nz, do{}$1save  ; 3:10      __INFO},

{
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
ifelse(__HEX_L(__GET_LOOP_END($1)-1),0x01,{define({__TMP_A},0x00){}dnl
    ld    A, E          ; 1:4       __INFO   lo index
    dec   A             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_L(__GET_LOOP_END($1)-1),0xFF,{define({__TMP_A},0x00){}dnl
    ld    A, E          ; 1:4       __INFO   lo index
    inc   A             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__GET_LOOP_END($1)-1),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(1+__GET_LOOP_END($1)-1),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__GET_LOOP_END($1)-1-1),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(2*(__GET_LOOP_END($1)-1)),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__HEX_L(__GET_LOOP_END($1)-1)/2),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
{define({__TMP_A},0){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    xor   E             ; 1:4       __INFO   lo(index ^ stop-1)})
    jp   nz, do{}$1save  ; 3:10      __INFO
ifelse(__HEX_H(__GET_LOOP_END($1)-1),__TMP_A,{dnl
    xor   D             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),0x01,{dnl
    ld    A, D          ; 1:4       __INFO   hi index
    dec   A             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),0xFF,{dnl
    ld    A, D          ; 1:4       __INFO   hi index
    inc   A             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(1+__TMP_A),{dnl
    inc   A             ; 1:4       __INFO   hi(stop-1) = __HEX_H(__GET_LOOP_END($1)-1)
    cp    D             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__TMP_A-1),{dnl
    dec   A             ; 1:4       __INFO   hi(stop-1) = __HEX_H(__GET_LOOP_END($1)-1)
    cp    D             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(2*__TMP_A),{dnl
    add   A, A          ; 1:4       __INFO   hi(stop-1) = __HEX_H(__GET_LOOP_END($1)-1)
    cp    D             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__TMP_A/2),{dnl
    rra                 ; 1:4       __INFO   hi(stop-1) = __HEX_H(__GET_LOOP_END($1)-1)
    cp    D             ; 1:4       __INFO   hi(index ^ stop-1)},
{dnl
    ld    A, __HEX_H(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   hi stop-1
    xor   D             ; 1:4       __INFO   hi(index ^ stop-1)})
    jp   nz, do{}$1save  ; 3:10      __INFO})
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # 2 +loop(r)
define({__ASM_TOKEN_2_ADDRLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
                       ;[22:103]    __INFO
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO
    inc  DE             ; 1:6       __INFO   DE = index+2
    inc  HL             ; 1:6       __INFO
    ld    A, E          ; 1:4       __INFO
    sub [HL]            ; 1:7       __INFO   lo index+2-stop
    and  0xFE           ; 2:7       __INFO
    jp   nz, do{}$1save2 ; 3:10      __INFO
    ld    A, D          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    sub [HL]            ; 1:7       __INFO   hi index+2-stop
    jp   nz, do{}$1save1 ; 3:10      __INFO   ( -- ) ( R: stop index -- stop index+2 )
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO},
{
    exx                 ; 1:4       __INFO
    ld    E,[HL]        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,[HL]        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO
    inc  DE             ; 1:6       __INFO   DE = index+2
    ld    A, E          ; 1:4       __INFO
    sub  format({%-15s},low __GET_LOOP_END($1)); 2:7       __INFO   lo index+2-stop
    rra                 ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
    jp   nz, do{}$1save  ; 3:10      __INFO
    ld    A, D          ; 1:4       __INFO
    sbc   A, format({%-11s},high __GET_LOOP_END($1)); 2:7       __INFO   hi index+2-stop
    jp   nz, do{}$1save  ; 3:10      __INFO
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO})
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # +loop(r)
dnl # ( step -- )
define({__ASM_TOKEN_ADDRLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(r)}){}dnl
__{}ifelse(__SAVE_EVAL(__GET_LOOP_STEP($1)),{1},{__ASM_TOKEN_RLOOP($1)},

__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{-1},{__ASM_TOKEN_SUB1_ADDRLOOP($1)},

__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{2},{__ASM_TOKEN_2_ADDRLOOP($1)},

__{}__GET_LOOP_END($1):_TYP_SINGLE,{:fast},{
__{}__{}                       ;[31:165]    __INFO   fast version
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  BC             ; 1:10      __INFO   BC = step
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    add   A, C          ; 1:4       __INFO
__{}__{}    ld  [HL],A          ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}    ld  [HL],A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    sub [HL]            ; 1:7       __INFO
__{}__{}    ld    E, A          ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    sbc   A,[HL]        ; 1:7       __INFO
__{}__{}    ld    D, A          ; 1:4       __INFO   DE = index-stop
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    add   A, C          ; 1:4       __INFO
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    p, do{}$1save1 ; 3:10      __INFO   ( step -- ) ( R: stop index -- stop index+step )
__{}__{}leave{}$1:               ;           __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    exx                 ; 1:4       __INFO 
__{}__{}exit{}$1:                ;           __INFO},

__{}__GET_LOOP_END($1),{},{
__{}__{}                       ;[26:175]    __INFO   default version
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    C,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    B,[HL]        ; 1:7       __INFO   BC = stop
__{}__{}    ex  [SP],HL         ; 1:19      __INFO   HL = step
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    jp    p, do{}$1save1 ; 3:10      __INFO   ( step -- ) ( R: stop index -- stop index+step )
__{}__{}leave{}$1:               ;           __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    exx                 ; 1:4       __INFO 
__{}__{}exit{}$1:                ;           __INFO},

__{}{
__{}dnl #                      ;[25:121+22=143]
__{}__{}__ADD_R16_CONST(HL,-(__GET_LOOP_END($1)),{BC = -stop = -(__GET_LOOP_END($1))},{HL+= -stop = index-stop}){}dnl
__{}__{}                       ;[eval(17+2*__BYTES):eval(102+2*__CLOCKS)]    __INFO
__{}__{}    ex  [SP],HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = index, DE = R.A.S.{}dnl
__{}__{}__CODE
__{}__{}    pop  BC             ; 1:10      __INFO   BC =  step{}dnl
__{}__{}__ADD_R16_CONST(HL,__GET_LOOP_END($1),{BC =  stop = __GET_LOOP_END($1)},{HL+=  stop = index+step}){}dnl
__{}__{}ifelse(dnl
__{}__{}__POLLUTES:eval(__PRICE<=17+__BYTE_PRICE*3),{sz:1},{
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step
__{}__{}__{}    xor   H             ; 1:4       __INFO   reverse sign --> exit
__{}__{}__{}    add   A, A          ; 1:4       __INFO   recursive sign to carry
__{}__{}__{}__CODE
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}__{}    jp   nc, do{}$1save  ; 3:10      __INFO},

__{}__{}__POLLUTES,{sz},{
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step
__{}__{}__{}    xor   H             ; 1:4       __INFO   reverse sign --> exit
__{}__{}__{}    ld   BC, __HEX_HL(__GET_LOOP_END($1))     ; 3:10      __INFO   __GET_LOOP_END($1)
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   $4
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}__{}    jp    p, do{}$1save  ; 3:10      __INFO},

__{}__{}__{}{
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step
__{}__{}__{}    xor   H             ; 1:4       __INFO   reverse sign --> exit
__{}__{}__{}__CODE
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}__{}    jp    p, do{}$1save  ; 3:10      __INFO})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    exx                 ; 1:4       __INFO 
__{}__{}exit{}$1:                ;           __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # step +loop(r)
define({__ASM_TOKEN_PUSH_ADDRLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(r)}){}dnl
__{}ifelse(dnl
__{}__HEX_HL(__GET_LOOP_STEP($1)),{0x0001},{__ASM_TOKEN_RLOOP($1)},

__{}__HEX_HL(__GET_LOOP_STEP($1)),{0xFFFF},{__ASM_TOKEN_SUB1_ADDRLOOP($1)},

__{}__HEX_HL(__GET_LOOP_STEP($1)),{0x0002},{__ASM_TOKEN_2_ADDRLOOP($1)},

__{}__HAS_PTR(__GET_LOOP_STEP($1)):__GET_LOOP_END($1),{1:},{
__{}__{}                       ;[32:150]    __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    C,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    B,[HL]        ; 1:7       __INFO   BC = stop
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}__{}    ld    A, format({%-11s},__PTR_ADD(__GET_LOOP_STEP($1),0)); 3:13      __INFO   lo8(step)
__{}__{}    add   A, L          ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    A, format({%-11s},__PTR_ADD(__GET_LOOP_STEP($1),1)); 3:13      __INFO   hi8(step)
__{}__{}    adc   A, H          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO   HL = index-stop+step
__{}__{}    sbc   A, A          ; 1:4       __INFO   save carry to sign
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}__{}    ex   DE, HL         ; 1:4       __INFO{}dnl
__{}__{}ifelse(__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x0000,{
__{}__{}__{}    jp    p, do{}$1save1 ; 3:10      __INFO},
__{}__{}__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x8000,{
__{}__{}    jp    m, do{}$1save1 ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}__{}    jp    p, do{}$1save1 ; 3:10      __INFO
__{}__{}__{}else
__{}__{}__{}    jp    m, do{}$1save1 ; 3:10      __INFO
__{}__{}__{}endif})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( -- ) ( R: stop index -- )
__{}__{}exit{}$1:                ;           __INFO},

__{}__GET_LOOP_END($1),{},{
__{}__{}                       ;[28:138]    __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    C,[HL]        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    B,[HL]        ; 1:7       __INFO   BC = stop
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}__{}    ld    A, format({%-11s},low __GET_LOOP_STEP($1)); 2:7       __INFO   lo8(step)
__{}__{}    add   A, L          ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    A, format({%-11s},high __GET_LOOP_STEP($1)); 2:7       __INFO   hi8(step)
__{}__{}    adc   A, H          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO   HL = index-stop+step
__{}__{}    sbc   A, A          ; 1:4       __INFO   save carry to sign
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}__{}    ex   DE, HL         ; 1:4       __INFO{}dnl
__{}__{}ifelse(__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x0000,{
__{}__{}__{}    jp    p, do{}$1save1 ; 3:10      __INFO},
__{}__{}__HEX_HL((__GET_LOOP_STEP($1)) & 0x8000),0x8000,{
__{}__{}__{}    jp    m, do{}$1save1 ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}  if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}__{}    jp    p, do{}$1save1 ; 3:10      __INFO
__{}__{}__{}  else
__{}__{}__{}    jp    m, do{}$1save1 ; 3:10      __INFO
__{}__{}__{}  endif})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( -- ) ( R: stop index -- )
__{}__{}exit{}$1:                ;           __INFO},

__{}__HAS_PTR(__GET_LOOP_STEP($1)),1,{
__{}__{}  .error Dodelat!!!},

__{}{dnl
__{}__{}__ADD_R16_CONST(HL,-(__GET_LOOP_END($1)),{BC = -stop = -(__GET_LOOP_END($1))},{HL+= -stop = index-stop}){}dnl
__{}__{}define({$0_CODE},__CODE){}dnl
__{}__{}define({__SUM_CLOCKS},__CLOCKS){}dnl
__{}__{}define({__SUM_BYTES}, __BYTES){}dnl
__{}__{}define({__SUM_PRICE}, __PRICE){}dnl
__{}__{}define({$0_BC},__LD_R16({BC},__GET_LOOP_STEP($1))){}dnl
__{}__{}__ADD_R16_CONST(HL,__GET_LOOP_END($1),{BC =  stop = __GET_LOOP_END($1)},{HL+=  stop = index+step}){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS){}dnl
__{}__{}__add({__SUM_BYTES}, __BYTES){}dnl
__{}__{}__add({__SUM_PRICE}, __PRICE){}dnl
__{}__{}ifelse(__POLLUTES,{sz},{
__{}__{}__{}                       ;[eval(12+__SUM_BYTES):eval(61+__SUM_CLOCKS)]     __INFO
__{}__{}__{}    exx                 ; 1:4       __INFO
__{}__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = index, DE = R.A.S.{}dnl
__{}__{}__{}$0_CODE{}dnl
__{}__{}__{}$0_BC   BC =  step = __GET_LOOP_STEP($1)
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step{}dnl
__{}__{}__{}__CODE
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO{}dnl
__{}__{}__{}ifelse(__IS_NUM(__GET_LOOP_STEP($1)),1,{dnl
__{}__{}__{}__{}ifelse(eval((__GET_LOOP_STEP($1)) & 0x8000),0,{
__{}__{}__{}__{}    jp   nc, do{}$1save  ; 3:10      __INFO   positive step},
__{}__{}__{}__{}{
__{}__{}__{}__{}    jp    c, do{}$1save  ; 3:10      __INFO   negative step})},
__{}__{}__{}{
__{}__{}__{}__{}  if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}__{}__{}    jp   nc, do{}$1save  ; 3:10      __INFO   positive step
__{}__{}__{}__{}  else
__{}__{}__{}__{}    jp    c, do{}$1save  ; 3:10      __INFO   negative step
__{}__{}__{}__{}  endif})},

__{}__{}{
__{}__{}__{}                       ;[eval(13+__SUM_BYTES):eval(65+__SUM_CLOCKS)]    __INFO
__{}__{}__{}    exx                 ; 1:4       __INFO
__{}__{}__{}    ld    E,[HL]        ; 1:7       __INFO
__{}__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}__{}    ld    D,[HL]        ; 1:7       __INFO   DE = index
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = index, DE = R.A.S.{}dnl
__{}__{}__{}$0_CODE{}dnl
__{}__{}__{}$0_BC   BC =  step = __GET_LOOP_STEP($1)
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step
__{}__{}__{}    sbc   A, A          ; 1:4       __INFO   save carry to sign{}dnl
__{}__{}__{}__CODE
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO{}dnl
__{}__{}__{}ifelse(__IS_NUM(__GET_LOOP_STEP($1)),1,{dnl
__{}__{}__{}__{}ifelse(eval((__GET_LOOP_STEP($1)) & 0x8000),0,{
__{}__{}__{}__{}    jp    p, do{}$1save  ; 3:10      __INFO   positive step},
__{}__{}__{}__{}{
__{}__{}__{}__{}    jp    m, do{}$1save  ; 3:10      __INFO   negative step})},
__{}__{}__{}{
__{}__{}__{}__{}  if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}__{}__{}    jp    p, do{}$1save  ; 3:10      __INFO   positive step
__{}__{}__{}__{}  else
__{}__{}__{}__{}    jp    m, do{}$1save  ; 3:10      __INFO   negative step
__{}__{}__{}__{}  endif{}dnl
__{}__{}__{}}){}dnl
__{}__{}})
__{}__{}leave{}$1:               ;           __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    exx                 ; 1:4       __INFO   ( -- ) ( R: stop index -- )
__{}__{}exit{}$1:                ;           __INFO{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl

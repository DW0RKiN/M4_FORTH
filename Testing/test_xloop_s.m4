include(`../M4/FIRST.M4')dnl
ORG 0x8000
INIT(60000)
VARIABLE(_counter)
VARIABLE(_index)
dnl
define({SET_BORDER},{dnl
__{}__ADD_TOKEN({__TOKEN_SET_BORDER},{border($1)},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SET_BORDER},{
__{}define({__INFO},__COMPILE_INFO)
    ld    A, L          ; 1:4       __INFO
    out (254),A         ; 2:11      __INFO  0=blk,1=blu,2=red,3=mag,4=grn,5=cyn,6=yel,7=wht
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO}){}dnl
dnl
define({CLS},{dnl
__{}__ADD_TOKEN({__TOKEN_CLS},{cls},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CLS},{
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    call 0x0DAF         ; 3:17      __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
;       12345678901234567890123456789012
;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(256)    PUSH(251)    DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(246)    PUSH(241)    DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) PUSH(0x3CFB) DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) PUSH(0x3C05) DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x6600) PUSH(0x65FB) DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4055) PUSH(0x4050) DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(0)      PUSH(-5)     DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(2)      PUSH(-3)     DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6700) PUSH(0x6318) DO(S) CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(300)    PUSH(-700)   DO(S) CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 PUSH(0)      PUSH(4)      DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(1)      PUSH(5)      DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(254)    PUSH(258)    DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH( 256)   PUSH(1255)   DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(-1)     PUSH(998)    DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(2)      PUSH(1001)   DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(200)    PUSH(1199)   DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(-624)   PUSH(375)    DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(-513)   PUSH(486)    DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(256)    PUSH(251)    __ASM DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(246)    PUSH(241)    __ASM DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) PUSH(0x3CFB) __ASM DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) PUSH(0x3C05) __ASM DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x6600) PUSH(0x65FB) __ASM DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4055) PUSH(0x4050) __ASM DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(0)      PUSH(-5)     __ASM DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(2)      PUSH(-3)     __ASM DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6700) PUSH(0x6318) __ASM DO(S) CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(300)    PUSH(-700)   __ASM DO(S) CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 PUSH(0)      PUSH(4)      __ASM DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(1)      PUSH(5)      __ASM DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(254)    PUSH(258)    __ASM DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH( 256)   PUSH(1255)   __ASM DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(-1)     PUSH(998)    __ASM DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(2)      PUSH(1001)   __ASM DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(200)    PUSH(1199)   __ASM DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(-624)   PUSH(375)    __ASM DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(-513)   PUSH(486)    __ASM DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(256)    __ASM PUSH(251)    DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(246)    __ASM PUSH(241)    DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) __ASM PUSH(0x3CFB) DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) __ASM PUSH(0x3C05) DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x6600) __ASM PUSH(0x65FB) DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4055) __ASM PUSH(0x4050) DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(0)      __ASM PUSH(-5)     DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(2)      __ASM PUSH(-3)     DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6700) __ASM PUSH(0x6318) DO(S) CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(300)    __ASM PUSH(-700)   DO(S) CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 PUSH(0)      __ASM PUSH(4)      DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(1)      __ASM PUSH(5)      DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(254)    __ASM PUSH(258)    DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH( 256)   __ASM PUSH(1255)   DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(-1)     __ASM PUSH(998)    DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(2)      __ASM PUSH(1001)   DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(200)    __ASM PUSH(1199)   DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(-624)   __ASM PUSH(375)    DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(-513)   __ASM PUSH(486)    DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(2) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(251)    PUSH(256)    SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(241)    PUSH(246)    SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3CFB) PUSH(0x3D00) SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C05) PUSH(0x3C0A) SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x65FB) PUSH(0x6600) SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4050) PUSH(0x4055) SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(-5)     PUSH(0)      SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(-3)     PUSH(2)      SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6318) PUSH(0x6700) SWAP DO(S) CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(-700)   PUSH(300)    SWAP DO(S) CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 PUSH(4)      PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(5)      PUSH(1)      SWAP DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(258)    PUSH(254)    SWAP DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH(1255)   PUSH( 256)   SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(998)    PUSH(-1)     SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(1001)   PUSH(2)      SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(1199)   PUSH(200)    SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(375)    PUSH(-624)   SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(486)    PUSH(-513)   SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(3) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(251)    __ASM PUSH(256)    SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(241)    __ASM PUSH(246)    SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3CFB) __ASM PUSH(0x3D00) SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C05) __ASM PUSH(0x3C0A) SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x65FB) __ASM PUSH(0x6600) SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4050) __ASM PUSH(0x4055) SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(-5)     __ASM PUSH(0)      SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(-3)     __ASM PUSH(2)      SWAP DO(S) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6318) __ASM PUSH(0x6700) SWAP DO(S) CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(-700)   __ASM PUSH(300)    SWAP DO(S) CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 PUSH(4)      __ASM PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(5)      __ASM PUSH(1)      SWAP DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(258)    __ASM PUSH(254)    SWAP DO(S) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH(1255)   __ASM PUSH( 256)   SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(998)    __ASM PUSH(-1)     SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(1001)   __ASM PUSH(2)      SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(1199)   __ASM PUSH(200)    SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(375)    __ASM PUSH(-624)   SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(486)    __ASM PUSH(-513)   SWAP DO(S) CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(4) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(256)    DO(S,,251)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(246)    DO(S,,241)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) DO(S,,0x3CFB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) DO(S,,0x3C05)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x6600) DO(S,,0x65FB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4055) DO(S,,0x4050)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(0)      DO(S,,-5)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(2)      DO(S,,-3)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6700) DO(S,,0x6318)  CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(300)    DO(S,,-700)    CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 PUSH(0)      DO(S,,4)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(1)      DO(S,,5)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(254)    DO(S,,258)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH( 256)   DO(S,,1255)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(-1)     DO(S,,998)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(2)      DO(S,,1001)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(200)    DO(S,,1199)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(-624)   DO(S,,375)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(-513)   DO(S,,486)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(5) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(256)    __ASM DO(S,,251)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(246)    __ASM DO(S,,241)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) __ASM DO(S,,0x3CFB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) __ASM DO(S,,0x3C05)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x6600) __ASM DO(S,,0x65FB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4055) __ASM DO(S,,0x4050)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(0)      __ASM DO(S,,-5)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(2)      __ASM DO(S,,-3)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6700) __ASM DO(S,,0x6318)  CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(300)    __ASM DO(S,,-700)    CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                                     __ASM 
PRINT_I({"-1.A      4..0         "})                 PUSH(0)      __ASM DO(S,,4)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(1)      __ASM DO(S,,5)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(254)    __ASM DO(S,,258)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH( 256)   __ASM DO(S,,1255)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(-1)     __ASM DO(S,,998)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(2)      __ASM DO(S,,1001)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(200)    __ASM DO(S,,1199)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(-624)   __ASM DO(S,,375)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(-513)   __ASM DO(S,,486)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(6) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(251)    DO(S,256)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(241)    DO(S,246)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3CFB) DO(S,0x3D00)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C05) DO(S,0x3C0A)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x65FB) DO(S,0x6600)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4050) DO(S,0x4055)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(-5)     DO(S,0)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(-3)     DO(S,2)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6318) DO(S,0x6700)  CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(-700)   DO(S,300)     CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 PUSH(4)      DO(S,0)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(5)      DO(S,1)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(258)    DO(S,254)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH(1255)   DO(S, 256)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(998)    DO(S,-1)      CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(1001)   DO(S,2)       CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(1199)   DO(S,200)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(375)    DO(S,-624)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(486)    DO(S,-513)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(7) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 PUSH(251)    __ASM DO(S,256)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 PUSH(241)    __ASM DO(S,246)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 PUSH(0x3CFB) __ASM DO(S,0x3D00)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 PUSH(0x3C05) __ASM DO(S,0x3C0A)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 PUSH(0x65FB) __ASM DO(S,0x6600)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 PUSH(0x4050) __ASM DO(S,0x4055)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 PUSH(-5)     __ASM DO(S,0)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 PUSH(-3)     __ASM DO(S,2)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) PUSH(0x6318) __ASM DO(S,0x6700)  CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) PUSH(-700)   __ASM DO(S,300)     CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 PUSH(4)      __ASM DO(S,0)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 PUSH(5)      __ASM DO(S,1)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 PUSH(258)    __ASM DO(S,254)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) PUSH(1255)   __ASM DO(S, 256)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) PUSH(998)    __ASM DO(S,-1)      CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) PUSH(1001)   __ASM DO(S,2)       CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) PUSH(1199)   __ASM DO(S,200)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) PUSH(375)    __ASM DO(S,-624)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) PUSH(486)    __ASM DO(S,-513)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.A    251..(256)     "})                 DO(S,256,    251)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})                 DO(S,246,    241)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})                 DO(S,0x3D00, 0x3CFB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})                 DO(S,0x3C0A, 0x3C05)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})                 DO(S,0x6600, 0x65FB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})                 DO(S,0x4055, 0x4050)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})                 DO(S,0,      -5)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})                 DO(S,2,      -3)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH(0) PUSH(0) DO(S,0x6700, 0x6318)  CALL(_test)                LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})   PUSH(0) PUSH(0) DO(S,300,    -700)    CALL(_test)                LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.A      4..0         "})                 DO(S,0,      4)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})                 DO(S,1,      5)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})                 DO(S,254,    258)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH(0) PUSH(0) DO(S,256,    1255)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.E    998..-1       "})  PUSH(0) PUSH(0) DO(S,-1,     998)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.F   1001..2         "}) PUSH(0) PUSH(0) DO(S,2,      1001)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.G   1199..200     "})   PUSH(0) PUSH(0) DO(S,200,    1199)    CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})    PUSH(0) PUSH(0) DO(S,-624,   375)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})    PUSH(0) PUSH(0) DO(S,-513,   486)     CALL(_test)   PUSH(-1)  ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# =========================================
;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                 PUSH(0)     PUSH(-10)  DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                 PUSH(1)     PUSH(-9)   DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                 PUSH(5)     PUSH(-5)   DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0) PUSH(2304)  PUSH(304)  DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0) PUSH(2050)  PUSH(50)   DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0) PUSH(1990)  PUSH(-10)  DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                      
PRINT_I({"-2.A       8..0        "})                 PUSH(0)     PUSH(8)    DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                 PUSH(1)     PUSH(9)    DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                 PUSH(2)     PUSH(10)   DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                 PUSH(256)   PUSH(264)  DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                 PUSH(300)   PUSH(308)  DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0) PUSH(3)     PUSH(2001) DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0) PUSH(234)   PUSH(2232) DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0) PUSH(-1802) PUSH(196)  DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0) PUSH(-1748) PUSH(250)  DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                 PUSH(0)     PUSH(-10)  __ASM DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                 PUSH(1)     PUSH(-9)   __ASM DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                 PUSH(5)     PUSH(-5)   __ASM DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0) PUSH(2304)  PUSH(304)  __ASM DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0) PUSH(2050)  PUSH(50)   __ASM DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0) PUSH(1990)  PUSH(-10)  __ASM DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                               
PRINT_I({"-2.A       8..0        "})                 PUSH(0)     PUSH(8)    __ASM DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                 PUSH(1)     PUSH(9)    __ASM DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                 PUSH(2)     PUSH(10)   __ASM DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                 PUSH(256)   PUSH(264)  __ASM DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                 PUSH(300)   PUSH(308)  __ASM DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0) PUSH(3)     PUSH(2001) __ASM DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0) PUSH(234)   PUSH(2232) __ASM DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0) PUSH(-1802) PUSH(196)  __ASM DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0) PUSH(-1748) PUSH(250)  __ASM DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                 PUSH(0)     __ASM PUSH(-10)  DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                 PUSH(1)     __ASM PUSH(-9)   DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                 PUSH(5)     __ASM PUSH(-5)   DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0) PUSH(2304)  __ASM PUSH(304)  DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0) PUSH(2050)  __ASM PUSH(50)   DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0) PUSH(1990)  __ASM PUSH(-10)  DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                          
PRINT_I({"-2.A       8..0        "})                 PUSH(0)     __ASM PUSH(8)    DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                 PUSH(1)     __ASM PUSH(9)    DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                 PUSH(2)     __ASM PUSH(10)   DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                 PUSH(256)   __ASM PUSH(264)  DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                 PUSH(300)   __ASM PUSH(308)  DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0) PUSH(3)     __ASM PUSH(2001) DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0) PUSH(234)   __ASM PUSH(2232) DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0) PUSH(-1802) __ASM PUSH(196)  DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0) PUSH(-1748) __ASM PUSH(250)  DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(2) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                 PUSH(-10)    PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                 PUSH(-9)     PUSH(1)      SWAP DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                 PUSH(-5)     PUSH(5)      SWAP DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0) PUSH(304)    PUSH(2304)   SWAP DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0) PUSH(50)     PUSH(2050)   SWAP DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0) PUSH(-10)    PUSH(1990)   SWAP DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                     
PRINT_I({"-2.A       8..0        "})                 PUSH(8)      PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                 PUSH(9)      PUSH(1)      SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                 PUSH(10)     PUSH(2)      SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                 PUSH(264)    PUSH(256)    SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                 PUSH(308)    PUSH(300)    SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0) PUSH(2001)   PUSH(3)      SWAP DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0) PUSH(2232)   PUSH(234)    SWAP DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0) PUSH(196)    PUSH(-1802)  SWAP DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0) PUSH(250)    PUSH(-1748)  SWAP DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(3) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                 PUSH(-10)    __ASM PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                 PUSH(-9)     __ASM PUSH(1)      SWAP DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                 PUSH(-5)     __ASM PUSH(5)      SWAP DO(S) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0) PUSH(304)    __ASM PUSH(2304)   SWAP DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0) PUSH(50)     __ASM PUSH(2050)   SWAP DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0) PUSH(-10)    __ASM PUSH(1990)   SWAP DO(S) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                     
PRINT_I({"-2.A       8..0        "})                 PUSH(8)      __ASM PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                 PUSH(9)      __ASM PUSH(1)      SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                 PUSH(10)     __ASM PUSH(2)      SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                 PUSH(264)    __ASM PUSH(256)    SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                 PUSH(308)    __ASM PUSH(300)    SWAP DO(S) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0) PUSH(2001)   __ASM PUSH(3)      SWAP DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0) PUSH(2232)   __ASM PUSH(234)    SWAP DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0) PUSH(196)    __ASM PUSH(-1802)  SWAP DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0) PUSH(250)    __ASM PUSH(-1748)  SWAP DO(S) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(4) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                 PUSH(0)           DO(S,,-10)  PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                 PUSH(1)           DO(S,,-9)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                 PUSH(5)           DO(S,,-5)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0) PUSH(2304)        DO(S,,304)  CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0) PUSH(2050)        DO(S,,50)   CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0) PUSH(1990)        DO(S,,-10)  CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                                
PRINT_I({"-2.A       8..0        "})                 PUSH(0)           DO(S,,8)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                 PUSH(1)           DO(S,,9)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                 PUSH(2)           DO(S,,10)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                 PUSH(256)         DO(S,,264)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                 PUSH(300)         DO(S,,308)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0) PUSH(3)           DO(S,,2001) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0) PUSH(234)         DO(S,,2232) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0) PUSH(-1802)       DO(S,,196)  CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0) PUSH(-1748)       DO(S,,250)  CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(5) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                 PUSH(0)     __ASM DO(S,,-10)  PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                 PUSH(1)     __ASM DO(S,,-9)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                 PUSH(5)     __ASM DO(S,,-5)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0) PUSH(2304)  __ASM DO(S,,304)  CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0) PUSH(2050)  __ASM DO(S,,50)   CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0) PUSH(1990)  __ASM DO(S,,-10)  CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                                
PRINT_I({"-2.A       8..0        "})                 PUSH(0)     __ASM DO(S,,8)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                 PUSH(1)     __ASM DO(S,,9)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                 PUSH(2)     __ASM DO(S,,10)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                 PUSH(256)   __ASM DO(S,,264)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                 PUSH(300)   __ASM DO(S,,308)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0) PUSH(3)     __ASM DO(S,,2001) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0) PUSH(234)   __ASM DO(S,,2232) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0) PUSH(-1802) __ASM DO(S,,196)  CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0) PUSH(-1748) __ASM DO(S,,250)  CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(6) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                    PUSH(-10)   DO(S,0)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                    PUSH(-9)    DO(S,1)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                    PUSH(-5)    DO(S,5)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0)    PUSH(304)   DO(S,2304) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0)    PUSH(50)    DO(S,2050) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0)    PUSH(-10)   DO(S,1990) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                       
PRINT_I({"-2.A       8..0        "})                    PUSH(8)     DO(S,0)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                    PUSH(9)     DO(S,1)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                    PUSH(10)    DO(S,2)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                    PUSH(264)   DO(S,256)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                    PUSH(308)   DO(S,300)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0)    PUSH(2001)  DO(S,3)    CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0)    PUSH(2232)  DO(S,234)  CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0)    PUSH(196)   DO(S,-1802) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0)    PUSH(250)   DO(S,-1748) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(7) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                    PUSH(-10)    __ASM DO(S,0)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                    PUSH(-9)     __ASM DO(S,1)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                    PUSH(-5)     __ASM DO(S,5)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0)    PUSH(304)    __ASM DO(S,2304) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0)    PUSH(50)     __ASM DO(S,2050) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0)    PUSH(-10)    __ASM DO(S,1990) CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                             
PRINT_I({"-2.A       8..0        "})                    PUSH(8)      __ASM DO(S,0)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                    PUSH(9)      __ASM DO(S,1)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                    PUSH(10)     __ASM DO(S,2)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                    PUSH(264)    __ASM DO(S,256)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                    PUSH(308)    __ASM DO(S,300)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0)    PUSH(2001)   __ASM DO(S,3)    CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0)    PUSH(2232)   __ASM DO(S,234)  CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0)    PUSH(196)    __ASM DO(S,-1802) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0)    PUSH(250)    __ASM DO(S,-1748) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.A    -10..(0)       "})                  DO(S,0,     -10)  PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})                  DO(S,1,     -9)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})                  DO(S,5,     -5)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH(0) PUSH(0)  DO(S,2304,  304)  CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})    PUSH(0) PUSH(0)  DO(S,2050,  50)   CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})    PUSH(0) PUSH(0)  DO(S,1990,  -10)  CALL(_test)   PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                     
PRINT_I({"-2.A       8..0        "})                  DO(S,0,     8)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})                  DO(S,1,     9)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})                  DO(S,2,     10)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})                  DO(S,256,   264)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})                  DO(S,300,   308)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH(0) PUSH(0)  DO(S,3,     2001) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.G    2232..234    "})   PUSH(0) PUSH(0)  DO(S,234,   2232) CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})    PUSH(0) PUSH(0)  DO(S,-1802, 196)  CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})    PUSH(0) PUSH(0)  DO(S,-1748, 250)  CALL(_test)   PUSH(-2)  ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)


;# =========================================
;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                 PUSH(0)      PUSH(13)     DO(S) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                 PUSH(0)      PUSH(43)     DO(S) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                 PUSH(510)    PUSH(671)    DO(S) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                 PUSH(-1160)  PUSH(50)     DO(S) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0) PUSH(30)     PUSH(7027)   DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0) PUSH(-70)    PUSH(6927)   DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.A 3   10..(25)      "})                 PUSH(25)     PUSH(10)     DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                 PUSH(0xC610) PUSH(0xC601) DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                 PUSH(2500)   PUSH(25)     DO(S) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                 PUSH(0)      PUSH(-15)    DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                 PUSH(5)      PUSH(-29)    DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                 PUSH(260)    PUSH(227)    DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                 PUSH(10)     PUSH(-23)    DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                 PUSH(230)    PUSH(-1485)  DO(S) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0) PUSH(4516)   PUSH(516)    DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                 PUSH(1234)   PUSH(33)     DO(S) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                 PUSH(1034)   PUSH(1019)   DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0) PUSH(500)    PUSH(100)    DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                 PUSH(0)      PUSH(13)     __ASM DO(S) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                 PUSH(0)      PUSH(43)     __ASM DO(S) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                 PUSH(510)    PUSH(671)    __ASM DO(S) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                 PUSH(-1160)  PUSH(50)     __ASM DO(S) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0) PUSH(30)     PUSH(7027)   __ASM DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0) PUSH(-70)    PUSH(6927)   __ASM DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.A 3   10..(25)      "})                 PUSH(25)     PUSH(10)     __ASM DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                 PUSH(0xC610) PUSH(0xC601) __ASM DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                 PUSH(2500)   PUSH(25)     __ASM DO(S) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                 PUSH(0)      PUSH(-15)    __ASM DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                 PUSH(5)      PUSH(-29)    __ASM DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                 PUSH(260)    PUSH(227)    __ASM DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                 PUSH(10)     PUSH(-23)    __ASM DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                 PUSH(230)    PUSH(-1485)  __ASM DO(S) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0) PUSH(4516)   PUSH(516)    __ASM DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                 PUSH(1234)   PUSH(33)     __ASM DO(S) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                 PUSH(1034)   PUSH(1019)   __ASM DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0) PUSH(500)    PUSH(100)    __ASM DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                 __ASM PUSH(0)      __ASM PUSH(13)     DO(S) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                 __ASM PUSH(0)      __ASM PUSH(43)     DO(S) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                 __ASM PUSH(510)    __ASM PUSH(671)    DO(S) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                 __ASM PUSH(-1160)  __ASM PUSH(50)     DO(S) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0) __ASM PUSH(30)     __ASM PUSH(7027)   DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0) __ASM PUSH(-70)    __ASM PUSH(6927)   DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.A 3   10..(25)      "})                 __ASM PUSH(25)     __ASM PUSH(10)     DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                 __ASM PUSH(0xC610) __ASM PUSH(0xC601) DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                 __ASM PUSH(2500)   __ASM PUSH(25)     DO(S) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                 __ASM PUSH(0)      __ASM PUSH(-15)    DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                 __ASM PUSH(5)      __ASM PUSH(-29)    DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                 __ASM PUSH(260)    __ASM PUSH(227)    DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                 __ASM PUSH(10)     __ASM PUSH(-23)    DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                 __ASM PUSH(230)    __ASM PUSH(-1485)  DO(S) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0) __ASM PUSH(4516)   __ASM PUSH(516)    DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                 __ASM PUSH(1234)   __ASM PUSH(33)     DO(S) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                 __ASM PUSH(1034)   __ASM PUSH(1019)   DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0) __ASM PUSH(500)    __ASM PUSH(100)    DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(2) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                 PUSH(13)     PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                 PUSH(43)     PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                 PUSH(671)    PUSH(510)    SWAP DO(S) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                 PUSH(50)     PUSH(-1160)  SWAP DO(S) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0) PUSH(7027)   PUSH(30)     SWAP DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0) PUSH(6927)   PUSH(-70)    SWAP DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.A 3   10..(25)      "})                 PUSH(10)     PUSH(25)     SWAP DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                 PUSH(0xC601) PUSH(0xC610) SWAP DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                 PUSH(25)     PUSH(2500)   SWAP DO(S) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                 PUSH(-15)    PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                 PUSH(-29)    PUSH(5)      SWAP DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                 PUSH(227)    PUSH(260)    SWAP DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                 PUSH(-23)    PUSH(10)     SWAP DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                 PUSH(-1485)  PUSH(230)    SWAP DO(S) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0) PUSH(516)    PUSH(4516)   SWAP DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                 PUSH(33)     PUSH(1234)   SWAP DO(S) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                 PUSH(1019)   PUSH(1034)   SWAP DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0) PUSH(100)    PUSH(500)    SWAP DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(3) CALL(_pause)


;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                 PUSH(13)     __ASM PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                 PUSH(43)     __ASM PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                 PUSH(671)    __ASM PUSH(510)    SWAP DO(S) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                 PUSH(50)     __ASM PUSH(-1160)  SWAP DO(S) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0) PUSH(7027)   __ASM PUSH(30)     SWAP DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0) PUSH(6927)   __ASM PUSH(-70)    SWAP DO(S) CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.A 3   10..(25)      "})                 PUSH(10)     __ASM PUSH(25)     SWAP DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                 PUSH(0xC601) __ASM PUSH(0xC610) SWAP DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                 PUSH(25)     __ASM PUSH(2500)   SWAP DO(S) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                 PUSH(-15)    __ASM PUSH(0)      SWAP DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                 PUSH(-29)    __ASM PUSH(5)      SWAP DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                 PUSH(227)    __ASM PUSH(260)    SWAP DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                 PUSH(-23)    __ASM PUSH(10)     SWAP DO(S) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                 PUSH(-1485)  __ASM PUSH(230)    SWAP DO(S) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0) PUSH(516)    __ASM PUSH(4516)   SWAP DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                 PUSH(33)     __ASM PUSH(1234)   SWAP DO(S) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                 PUSH(1019)   __ASM PUSH(1034)   SWAP DO(S) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0) PUSH(100)    __ASM PUSH(500)    SWAP DO(S) CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(4) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                 PUSH(0)       DO(S,,13)     PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                 PUSH(0)       DO(S,,43)     PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                 PUSH(510)     DO(S,,671)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                 PUSH(-1160)   DO(S,,50)     PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0) PUSH(30)      DO(S,,7027)   CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0) PUSH(-70)     DO(S,,6927)   CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                                          
PRINT_I({"+X.A 3   10..(25)      "})                 PUSH(25)      DO(S,,10)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                 PUSH(0xC610)  DO(S,,0xC601) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                 PUSH(2500)    DO(S,,25)     PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                 PUSH(0)       DO(S,,-15)    PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                 PUSH(5)       DO(S,,-29)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                 PUSH(260)     DO(S,,227)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                 PUSH(10)      DO(S,,-23)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                 PUSH(230)     DO(S,,-1485)  PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0) PUSH(4516)    DO(S,,516)    CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                 PUSH(1234)    DO(S,,33)     PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                 PUSH(1034)    DO(S,,1019)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0) PUSH(500)     DO(S,,100)    CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(5) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                 PUSH(0)      __ASM DO(S,,13)     PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                 PUSH(0)      __ASM DO(S,,43)     PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                 PUSH(510)    __ASM DO(S,,671)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                 PUSH(-1160)  __ASM DO(S,,50)     PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0) PUSH(30)     __ASM DO(S,,7027)   CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0) PUSH(-70)    __ASM DO(S,,6927)   CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                                               
PRINT_I({"+X.A 3   10..(25)      "})                 PUSH(25)     __ASM DO(S,,10)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                 PUSH(0xC610) __ASM DO(S,,0xC601) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                 PUSH(2500)   __ASM DO(S,,25)     PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                 PUSH(0)      __ASM DO(S,,-15)    PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                 PUSH(5)      __ASM DO(S,,-29)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                 PUSH(260)    __ASM DO(S,,227)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                 PUSH(10)     __ASM DO(S,,-23)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                 PUSH(230)    __ASM DO(S,,-1485)  PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0) PUSH(4516)   __ASM DO(S,,516)    CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                 PUSH(1234)   __ASM DO(S,,33)     PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                 PUSH(1034)   __ASM DO(S,,1019)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0) PUSH(500)    __ASM DO(S,,100)    CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(6) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                  PUSH(13)     DO(S,0)      PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                  PUSH(43)     DO(S,0)      PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                  PUSH(671)    DO(S,510)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                  PUSH(50)     DO(S,-1160)  PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0)  PUSH(7027)   DO(S,30)     CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0)  PUSH(6927)   DO(S,-70)    CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                                          
PRINT_I({"+X.A 3   10..(25)      "})                  PUSH(10)     DO(S,25)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                  PUSH(0xC601) DO(S,0xC610) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                  PUSH(25)     DO(S,2500)   PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                  PUSH(-15)    DO(S,0)      PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                  PUSH(-29)    DO(S,5)      PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                  PUSH(227)    DO(S,260)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                  PUSH(-23)    DO(S,10)     PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                  PUSH(-1485)  DO(S,230)    PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0)  PUSH(516)    DO(S,4516)   CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                  PUSH(33)     DO(S,1234)   PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                  PUSH(1019)   DO(S,1034)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0)  PUSH(100)    DO(S,500)    CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(7) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                  PUSH(13)    __ASM  DO(S,0)      PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                  PUSH(43)    __ASM  DO(S,0)      PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                  PUSH(671)   __ASM  DO(S,510)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                  PUSH(50)    __ASM  DO(S,-1160)  PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0)  PUSH(7027)  __ASM  DO(S,30)     CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0)  PUSH(6927)  __ASM  DO(S,-70)    CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                                                
PRINT_I({"+X.A 3   10..(25)      "})                  PUSH(10)    __ASM  DO(S,25)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                  PUSH(0xC601)__ASM  DO(S,0xC610) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                  PUSH(25)    __ASM  DO(S,2500)   PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                  PUSH(-15)   __ASM  DO(S,0)      PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                  PUSH(-29)   __ASM  DO(S,5)      PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                  PUSH(227)   __ASM  DO(S,260)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                  PUSH(-23)   __ASM  DO(S,10)     PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                  PUSH(-1485) __ASM  DO(S,230)    PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0)  PUSH(516)   __ASM  DO(S,4516)   CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                  PUSH(33)    __ASM  DO(S,1234)   PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                  PUSH(1019)  __ASM  DO(S,1034)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0)  PUSH(100)   __ASM  DO(S,500)    CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.A -3   13..0        "})                 DO(S,0,     13)     PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})                 DO(S,0,     43)     PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})                 DO(S,510,   671)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})                 DO(S,-1160, 50)     PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH(0) PUSH(0) DO(S,30,    7027)   CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})   PUSH(0) PUSH(0) DO(S,-70,   6927)   CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                        
PRINT_I({"+X.A 3   10..(25)      "})                 DO(S,25,    10)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})                 DO(S,0xC610,0xC601) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})                 DO(S,2500,  25)     PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})                 DO(S,0,     -15)    PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})                 DO(S,5,     -29)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})                 DO(S,260,   227)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})                 DO(S,10,    -23)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})                 DO(S,230,   -1485)  PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH(0) PUSH(0) DO(S,4516,  516)    CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.J 300 33..1234      "})                 DO(S,1234,  33)     PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})                 DO(S,1034,  1019)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH(0) PUSH(0) DO(S,500,   100)    CALL(_test)   PUSH(4)   ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# ---xxx---
STOP
COLON(_test)
    PUSH(_counter) FETCH _1ADD PUSH(_counter) STORE
    DUP PUSH(_index) STORE
SEMICOLON

COLON(_show)
    PUSH(_index)   FETCH        DOT
    PUSH(_counter) FETCH SPACE UDOT
    PUSH(0) PUSH(_index)   STORE
    PUSH(0) PUSH(_counter) STORE
    CR
SEMICOLON

COLON(_pause)
    SET_BORDER
    CLEARKEY BEGIN KEYQUESTION UNTIL
    CLS
SEMICOLON


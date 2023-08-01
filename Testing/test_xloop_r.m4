include(`../M4/FIRST.M4')dnl
ORG 0x8000
INIT(0x8000)
VARIABLE(_counter)
VARIABLE(_index)
;       12345678901234567890123456789012
;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(256)    PUSH(251)    DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(246)    PUSH(241)    DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) PUSH(0x3CFB) DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) PUSH(0x3C05) DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x6600) PUSH(0x65FB) DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4055) PUSH(0x4050) DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(0)      PUSH(-5)     DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(2)      PUSH(-3)     DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6700) PUSH(0x6318) DO(R) I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(300)    PUSH(-700)   DO(R) I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 PUSH(0)      PUSH(4)      DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(1)      PUSH(5)      DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(254)    PUSH(258)    DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH( 256)   PUSH(1255)   DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(-1)     PUSH(998)    DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(2)      PUSH(1001)   DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(200)    PUSH(1199)   DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(-624)   PUSH(375)    DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(-513)   PUSH(486)    DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(256)    PUSH(251)    __ASM DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(246)    PUSH(241)    __ASM DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) PUSH(0x3CFB) __ASM DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) PUSH(0x3C05) __ASM DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x6600) PUSH(0x65FB) __ASM DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4055) PUSH(0x4050) __ASM DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(0)      PUSH(-5)     __ASM DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(2)      PUSH(-3)     __ASM DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6700) PUSH(0x6318) __ASM DO(R) I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(300)    PUSH(-700)   __ASM DO(R) I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 PUSH(0)      PUSH(4)      __ASM DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(1)      PUSH(5)      __ASM DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(254)    PUSH(258)    __ASM DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH( 256)   PUSH(1255)   __ASM DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(-1)     PUSH(998)    __ASM DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(2)      PUSH(1001)   __ASM DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(200)    PUSH(1199)   __ASM DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(-624)   PUSH(375)    __ASM DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(-513)   PUSH(486)    __ASM DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(256)    __ASM PUSH(251)    DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(246)    __ASM PUSH(241)    DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) __ASM PUSH(0x3CFB) DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) __ASM PUSH(0x3C05) DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x6600) __ASM PUSH(0x65FB) DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4055) __ASM PUSH(0x4050) DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(0)      __ASM PUSH(-5)     DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(2)      __ASM PUSH(-3)     DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6700) __ASM PUSH(0x6318) DO(R) I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(300)    __ASM PUSH(-700)   DO(R) I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 PUSH(0)      __ASM PUSH(4)      DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(1)      __ASM PUSH(5)      DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(254)    __ASM PUSH(258)    DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH( 256)   __ASM PUSH(1255)   DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(-1)     __ASM PUSH(998)    DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(2)      __ASM PUSH(1001)   DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(200)    __ASM PUSH(1199)   DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(-624)   __ASM PUSH(375)    DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(-513)   __ASM PUSH(486)    DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(2) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(251)    PUSH(256)    SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(241)    PUSH(246)    SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3CFB) PUSH(0x3D00) SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C05) PUSH(0x3C0A) SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x65FB) PUSH(0x6600) SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4050) PUSH(0x4055) SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(-5)     PUSH(0)      SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(-3)     PUSH(2)      SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6318) PUSH(0x6700) SWAP DO(R) I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(-700)   PUSH(300)    SWAP DO(R) I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 PUSH(4)      PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(5)      PUSH(1)      SWAP DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(258)    PUSH(254)    SWAP DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH(1255)   PUSH( 256)   SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(998)    PUSH(-1)     SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(1001)   PUSH(2)      SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(1199)   PUSH(200)    SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(375)    PUSH(-624)   SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(486)    PUSH(-513)   SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(3) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(251)    __ASM PUSH(256)    SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(241)    __ASM PUSH(246)    SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3CFB) __ASM PUSH(0x3D00) SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C05) __ASM PUSH(0x3C0A) SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x65FB) __ASM PUSH(0x6600) SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4050) __ASM PUSH(0x4055) SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(-5)     __ASM PUSH(0)      SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(-3)     __ASM PUSH(2)      SWAP DO(R) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6318) __ASM PUSH(0x6700) SWAP DO(R) I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(-700)   __ASM PUSH(300)    SWAP DO(R) I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 PUSH(4)      __ASM PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(5)      __ASM PUSH(1)      SWAP DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(258)    __ASM PUSH(254)    SWAP DO(R) PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH(1255)   __ASM PUSH( 256)   SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(998)    __ASM PUSH(-1)     SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(1001)   __ASM PUSH(2)      SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(1199)   __ASM PUSH(200)    SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(375)    __ASM PUSH(-624)   SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(486)    __ASM PUSH(-513)   SWAP DO(R) I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(4) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(256)    DO(R,,251)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(246)    DO(R,,241)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) DO(R,,0x3CFB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) DO(R,,0x3C05)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x6600) DO(R,,0x65FB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4055) DO(R,,0x4050)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(0)      DO(R,,-5)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(2)      DO(R,,-3)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6700) DO(R,,0x6318)  I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(300)    DO(R,,-700)    I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 PUSH(0)      DO(R,,4)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(1)      DO(R,,5)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(254)    DO(R,,258)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH( 256)   DO(R,,1255)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(-1)     DO(R,,998)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(2)      DO(R,,1001)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(200)    DO(R,,1199)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(-624)   DO(R,,375)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(-513)   DO(R,,486)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(5) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(256)    __ASM DO(R,,251)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(246)    __ASM DO(R,,241)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3D00) __ASM DO(R,,0x3CFB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C0A) __ASM DO(R,,0x3C05)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x6600) __ASM DO(R,,0x65FB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4055) __ASM DO(R,,0x4050)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(0)      __ASM DO(R,,-5)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(2)      __ASM DO(R,,-3)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6700) __ASM DO(R,,0x6318)  I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(300)    __ASM DO(R,,-700)    I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                                     __ASM 
PRINT_I({"-1.a      4..0         "})                 PUSH(0)      __ASM DO(R,,4)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(1)      __ASM DO(R,,5)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(254)    __ASM DO(R,,258)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH( 256)   __ASM DO(R,,1255)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(-1)     __ASM DO(R,,998)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(2)      __ASM DO(R,,1001)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(200)    __ASM DO(R,,1199)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(-624)   __ASM DO(R,,375)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(-513)   __ASM DO(R,,486)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(6) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(251)    DO(R,256)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(241)    DO(R,246)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3CFB) DO(R,0x3D00)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C05) DO(R,0x3C0A)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x65FB) DO(R,0x6600)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4050) DO(R,0x4055)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(-5)     DO(R,0)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(-3)     DO(R,2)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6318) DO(R,0x6700)  I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(-700)   DO(R,300)     I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 PUSH(4)      DO(R,0)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(5)      DO(R,1)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(258)    DO(R,254)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH(1255)   DO(R, 256)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(998)    DO(R,-1)      I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(1001)   DO(R,2)       I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(1199)   DO(R,200)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(375)    DO(R,-624)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(486)    DO(R,-513)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(7) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 PUSH(251)    __ASM DO(R,256)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 PUSH(241)    __ASM DO(R,246)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 PUSH(0x3CFB) __ASM DO(R,0x3D00)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 PUSH(0x3C05) __ASM DO(R,0x3C0A)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 PUSH(0x65FB) __ASM DO(R,0x6600)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 PUSH(0x4050) __ASM DO(R,0x4055)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 PUSH(-5)     __ASM DO(R,0)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 PUSH(-3)     __ASM DO(R,2)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     PUSH(0x6318) __ASM DO(R,0x6700)  I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   PUSH(-700)   __ASM DO(R,300)     I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 PUSH(4)      __ASM DO(R,0)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 PUSH(5)      __ASM DO(R,1)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 PUSH(258)    __ASM DO(R,254)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   PUSH(1255)   __ASM DO(R, 256)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  PUSH(998)    __ASM DO(R,-1)      I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 PUSH(1001)   __ASM DO(R,2)       I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   PUSH(1199)   __ASM DO(R,200)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    PUSH(375)    __ASM DO(R,-624)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    PUSH(486)    __ASM DO(R,-513)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- +1 ---
PRINT_I({"+1.a    251..(256)     "})                 DO(R,256,    251)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.b    241..(246)     "})                 DO(R,246,    241)     PUTCHAR('.')               LOOP CR
PRINT_I({"+1.c 0x3CFB..(0x3D00)  "})                 DO(R,0x3D00, 0x3CFB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.d 0x3C05..(0x3C0A)  "})                 DO(R,0x3C0A, 0x3C05)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.e 0x65FB..(0x6600)  "})                 DO(R,0x6600, 0x65FB)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.f 0x4050..(0x4055)  "})                 DO(R,0x4055, 0x4050)  PUTCHAR('.')               LOOP CR
PRINT_I({"+1.g     -5..(0)       "})                 DO(R,0,      -5)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.h     -3..(2)       "})                 DO(R,2,      -3)      PUTCHAR('.')               LOOP CR
PRINT_I({"+1.i 6318h..(26368)"})                     DO(R,0x6700, 0x6318)  I CALL(_test)              LOOP CALL(_show)
PRINT_I({"+1.def -700..(300)   "})                   DO(R,300,    -700)    I CALL(_test)              LOOP CALL(_show)
;# --- -1 ---                                        
PRINT_I({"-1.a      4..0         "})                 DO(R,0,      4)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.b      5..1         "})                 DO(R,1,      5)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.c    258..254       "})                 DO(R,254,    258)     PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.d   1255..256     "})                   DO(R,256,    1255)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.e    998..-1       "})                  DO(R,-1,     998)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.f   1001..2         "})                 DO(R,2,      1001)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.g   1199..200     "})                   DO(R,200,    1199)    I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defA 375..-624   "})                    DO(R,-624,   375)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)
PRINT_I({"-1.defB 486..-513   "})                    DO(R,-513,   486)     I CALL(_test) PUSH(-1)  ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# =========================================
;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                 PUSH(0)     PUSH(-10)  DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                 PUSH(1)     PUSH(-9)   DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                 PUSH(5)     PUSH(-5)   DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                    PUSH(2304)  PUSH(304)  DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                    PUSH(2050)  PUSH(50)   DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                    PUSH(1990)  PUSH(-10)  DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                      
PRINT_I({"-2.a       8..0        "})                 PUSH(0)     PUSH(8)    DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                 PUSH(1)     PUSH(9)    DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                 PUSH(2)     PUSH(10)   DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                 PUSH(256)   PUSH(264)  DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                 PUSH(300)   PUSH(308)  DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                 PUSH(3)     PUSH(2001) DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                   PUSH(234)   PUSH(2232) DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                    PUSH(-1802) PUSH(196)  DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                    PUSH(-1748) PUSH(250)  DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                 PUSH(0)     PUSH(-10)  __ASM DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                 PUSH(1)     PUSH(-9)   __ASM DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                 PUSH(5)     PUSH(-5)   __ASM DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                    PUSH(2304)  PUSH(304)  __ASM DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                    PUSH(2050)  PUSH(50)   __ASM DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                    PUSH(1990)  PUSH(-10)  __ASM DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                               
PRINT_I({"-2.a       8..0        "})                 PUSH(0)     PUSH(8)    __ASM DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                 PUSH(1)     PUSH(9)    __ASM DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                 PUSH(2)     PUSH(10)   __ASM DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                 PUSH(256)   PUSH(264)  __ASM DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                 PUSH(300)   PUSH(308)  __ASM DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                 PUSH(3)     PUSH(2001) __ASM DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                   PUSH(234)   PUSH(2232) __ASM DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                    PUSH(-1802) PUSH(196)  __ASM DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                    PUSH(-1748) PUSH(250)  __ASM DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                 PUSH(0)     __ASM PUSH(-10)  DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                 PUSH(1)     __ASM PUSH(-9)   DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                 PUSH(5)     __ASM PUSH(-5)   DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                    PUSH(2304)  __ASM PUSH(304)  DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                    PUSH(2050)  __ASM PUSH(50)   DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                    PUSH(1990)  __ASM PUSH(-10)  DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                          
PRINT_I({"-2.a       8..0        "})                 PUSH(0)     __ASM PUSH(8)    DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                 PUSH(1)     __ASM PUSH(9)    DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                 PUSH(2)     __ASM PUSH(10)   DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                 PUSH(256)   __ASM PUSH(264)  DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                 PUSH(300)   __ASM PUSH(308)  DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                 PUSH(3)     __ASM PUSH(2001) DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                   PUSH(234)   __ASM PUSH(2232) DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                    PUSH(-1802) __ASM PUSH(196)  DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                    PUSH(-1748) __ASM PUSH(250)  DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(2) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                 PUSH(-10)    PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                 PUSH(-9)     PUSH(1)      SWAP DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                 PUSH(-5)     PUSH(5)      SWAP DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                    PUSH(304)    PUSH(2304)   SWAP DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                    PUSH(50)     PUSH(2050)   SWAP DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                    PUSH(-10)    PUSH(1990)   SWAP DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                     
PRINT_I({"-2.a       8..0        "})                 PUSH(8)      PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                 PUSH(9)      PUSH(1)      SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                 PUSH(10)     PUSH(2)      SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                 PUSH(264)    PUSH(256)    SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                 PUSH(308)    PUSH(300)    SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                 PUSH(2001)   PUSH(3)      SWAP DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                   PUSH(2232)   PUSH(234)    SWAP DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                    PUSH(196)    PUSH(-1802)  SWAP DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                    PUSH(250)    PUSH(-1748)  SWAP DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(3) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                 PUSH(-10)    __ASM PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                 PUSH(-9)     __ASM PUSH(1)      SWAP DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                 PUSH(-5)     __ASM PUSH(5)      SWAP DO(R) PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                    PUSH(304)    __ASM PUSH(2304)   SWAP DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                    PUSH(50)     __ASM PUSH(2050)   SWAP DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                    PUSH(-10)    __ASM PUSH(1990)   SWAP DO(R) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                     
PRINT_I({"-2.a       8..0        "})                 PUSH(8)      __ASM PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                 PUSH(9)      __ASM PUSH(1)      SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                 PUSH(10)     __ASM PUSH(2)      SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                 PUSH(264)    __ASM PUSH(256)    SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                 PUSH(308)    __ASM PUSH(300)    SWAP DO(R) PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                 PUSH(2001)   __ASM PUSH(3)      SWAP DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                   PUSH(2232)   __ASM PUSH(234)    SWAP DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                    PUSH(196)    __ASM PUSH(-1802)  SWAP DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                    PUSH(250)    __ASM PUSH(-1748)  SWAP DO(R) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(4) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                 PUSH(0)           DO(R,,-10)  PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                 PUSH(1)           DO(R,,-9)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                 PUSH(5)           DO(R,,-5)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                    PUSH(2304)        DO(R,,304)  I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                    PUSH(2050)        DO(R,,50)   I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                    PUSH(1990)        DO(R,,-10)  I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                                
PRINT_I({"-2.a       8..0        "})                 PUSH(0)           DO(R,,8)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                 PUSH(1)           DO(R,,9)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                 PUSH(2)           DO(R,,10)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                 PUSH(256)         DO(R,,264)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                 PUSH(300)         DO(R,,308)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                 PUSH(3)           DO(R,,2001) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                   PUSH(234)         DO(R,,2232) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                    PUSH(-1802)       DO(R,,196)  I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                    PUSH(-1748)       DO(R,,250)  I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(5) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                 PUSH(0)     __ASM DO(R,,-10)  PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                 PUSH(1)     __ASM DO(R,,-9)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                 PUSH(5)     __ASM DO(R,,-5)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                    PUSH(2304)  __ASM DO(R,,304)  I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                    PUSH(2050)  __ASM DO(R,,50)   I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                    PUSH(1990)  __ASM DO(R,,-10)  I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                                
PRINT_I({"-2.a       8..0        "})                 PUSH(0)     __ASM DO(R,,8)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                 PUSH(1)     __ASM DO(R,,9)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                 PUSH(2)     __ASM DO(R,,10)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                 PUSH(256)   __ASM DO(R,,264)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                 PUSH(300)   __ASM DO(R,,308)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                 PUSH(3)     __ASM DO(R,,2001) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                   PUSH(234)   __ASM DO(R,,2232) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                    PUSH(-1802) __ASM DO(R,,196)  I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                    PUSH(-1748) __ASM DO(R,,250)  I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(6) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                    PUSH(-10)   DO(R,0)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                    PUSH(-9)    DO(R,1)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                    PUSH(-5)    DO(R,5)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                       PUSH(304)   DO(R,2304) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                       PUSH(50)    DO(R,2050) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                       PUSH(-10)   DO(R,1990) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                       
PRINT_I({"-2.a       8..0        "})                    PUSH(8)     DO(R,0)     PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                    PUSH(9)     DO(R,1)     PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                    PUSH(10)    DO(R,2)     PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                    PUSH(264)   DO(R,256)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                    PUSH(308)   DO(R,300)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                    PUSH(2001)  DO(R,3)     I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                      PUSH(2232)  DO(R,234)   I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                       PUSH(196)   DO(R,-1802) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                       PUSH(250)   DO(R,-1748) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(7) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                    PUSH(-10)    __ASM DO(R,0)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                    PUSH(-9)     __ASM DO(R,1)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                    PUSH(-5)     __ASM DO(R,5)    PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                       PUSH(304)    __ASM DO(R,2304) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                       PUSH(50)     __ASM DO(R,2050) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                       PUSH(-10)    __ASM DO(R,1990) I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                             
PRINT_I({"-2.a       8..0        "})                    PUSH(8)      __ASM DO(R,0)     PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                    PUSH(9)      __ASM DO(R,1)     PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                    PUSH(10)     __ASM DO(R,2)     PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                    PUSH(264)    __ASM DO(R,256)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                    PUSH(308)    __ASM DO(R,300)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                    PUSH(2001)   __ASM DO(R,3)     I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                      PUSH(2232)   __ASM DO(R,234)   I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                       PUSH(196)    __ASM DO(R,-1802) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                       PUSH(250)    __ASM DO(R,-1748) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- 2 ---                                      
PRINT_I({"+2.a    -10..(0)       "})                  DO(R,0,     -10)  PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.b     -9..(1)       "})                  DO(R,1,     -9)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.c     -5..(5)       "})                  DO(R,5,     -5)   PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.d    304..(2304) "})                     DO(R,2304,  304)  I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defA  50..(2050) "})                     DO(R,2050,  50)   I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
PRINT_I({"+2.defB -10..(1990) "})                     DO(R,1990,  -10)  I CALL(_test) PUSH(2)   ADDLOOP CALL(_show)
;# --- -2 ---                                                     
PRINT_I({"-2.a       8..0        "})                  DO(R,0,     8)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.b       9..1        "})                  DO(R,1,     9)    PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.c      10..2        "})                  DO(R,2,     10)   PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.d     264..256      "})                  DO(R,256,   264)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.e     308..300      "})                  DO(R,300,   308)  PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.f    2001..3        "})                  DO(R,3,     2001) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.g    2232..234    "})                    DO(R,234,   2232) I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defA  196..-1802 "})                     DO(R,-1802, 196)  I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)
PRINT_I({"-2.defB  250..-1748 "})                     DO(R,-1748, 250)  I CALL(_test) PUSH(-2)  ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)


;# =========================================
;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                 PUSH(0)      PUSH(13)     DO(R) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                 PUSH(0)      PUSH(43)     DO(R) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                 PUSH(510)    PUSH(671)    DO(R) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                 PUSH(-1160)  PUSH(50)     DO(R) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                  PUSH(30)     PUSH(7027)   DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                   PUSH(-70)    PUSH(6927)   DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.a 3   10..(25)      "})                 PUSH(25)     PUSH(10)     DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                 PUSH(0xC610) PUSH(0xC601) DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                 PUSH(2500)   PUSH(25)     DO(R) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                 PUSH(0)      PUSH(-15)    DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                 PUSH(5)      PUSH(-29)    DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                 PUSH(260)    PUSH(227)    DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                 PUSH(10)     PUSH(-23)    DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                 PUSH(230)    PUSH(-1485)  DO(R) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                    PUSH(4516)   PUSH(516)    DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                 PUSH(1234)   PUSH(33)     DO(R) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                 PUSH(1034)   PUSH(1019)   DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                   PUSH(500)    PUSH(100)    DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                 PUSH(0)      PUSH(13)     __ASM DO(R) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                 PUSH(0)      PUSH(43)     __ASM DO(R) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                 PUSH(510)    PUSH(671)    __ASM DO(R) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                 PUSH(-1160)  PUSH(50)     __ASM DO(R) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                  PUSH(30)     PUSH(7027)   __ASM DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                   PUSH(-70)    PUSH(6927)   __ASM DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.a 3   10..(25)      "})                 PUSH(25)     PUSH(10)     __ASM DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                 PUSH(0xC610) PUSH(0xC601) __ASM DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                 PUSH(2500)   PUSH(25)     __ASM DO(R) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                 PUSH(0)      PUSH(-15)    __ASM DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                 PUSH(5)      PUSH(-29)    __ASM DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                 PUSH(260)    PUSH(227)    __ASM DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                 PUSH(10)     PUSH(-23)    __ASM DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                 PUSH(230)    PUSH(-1485)  __ASM DO(R) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                    PUSH(4516)   PUSH(516)    __ASM DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                 PUSH(1234)   PUSH(33)     __ASM DO(R) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                 PUSH(1034)   PUSH(1019)   __ASM DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                   PUSH(500)    PUSH(100)    __ASM DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                 __ASM PUSH(0)      __ASM PUSH(13)     DO(R) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                 __ASM PUSH(0)      __ASM PUSH(43)     DO(R) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                 __ASM PUSH(510)    __ASM PUSH(671)    DO(R) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                 __ASM PUSH(-1160)  __ASM PUSH(50)     DO(R) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                  __ASM PUSH(30)     __ASM PUSH(7027)   DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                   __ASM PUSH(-70)    __ASM PUSH(6927)   DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.a 3   10..(25)      "})                 __ASM PUSH(25)     __ASM PUSH(10)     DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                 __ASM PUSH(0xC610) __ASM PUSH(0xC601) DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                 __ASM PUSH(2500)   __ASM PUSH(25)     DO(R) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                 __ASM PUSH(0)      __ASM PUSH(-15)    DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                 __ASM PUSH(5)      __ASM PUSH(-29)    DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                 __ASM PUSH(260)    __ASM PUSH(227)    DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                 __ASM PUSH(10)     __ASM PUSH(-23)    DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                 __ASM PUSH(230)    __ASM PUSH(-1485)  DO(R) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                    __ASM PUSH(4516)   __ASM PUSH(516)    DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                 __ASM PUSH(1234)   __ASM PUSH(33)     DO(R) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                 __ASM PUSH(1034)   __ASM PUSH(1019)   DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                   __ASM PUSH(500)    __ASM PUSH(100)    DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(2) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                 PUSH(13)     PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                 PUSH(43)     PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                 PUSH(671)    PUSH(510)    SWAP DO(R) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                 PUSH(50)     PUSH(-1160)  SWAP DO(R) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                  PUSH(7027)   PUSH(30)     SWAP DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                   PUSH(6927)   PUSH(-70)    SWAP DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.a 3   10..(25)      "})                 PUSH(10)     PUSH(25)     SWAP DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                 PUSH(0xC601) PUSH(0xC610) SWAP DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                 PUSH(25)     PUSH(2500)   SWAP DO(R) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                 PUSH(-15)    PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                 PUSH(-29)    PUSH(5)      SWAP DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                 PUSH(227)    PUSH(260)    SWAP DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                 PUSH(-23)    PUSH(10)     SWAP DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                 PUSH(-1485)  PUSH(230)    SWAP DO(R) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                    PUSH(516)    PUSH(4516)   SWAP DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                 PUSH(33)     PUSH(1234)   SWAP DO(R) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                 PUSH(1019)   PUSH(1034)   SWAP DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                   PUSH(100)    PUSH(500)    SWAP DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(3) CALL(_pause)


;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                 PUSH(13)     __ASM PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                 PUSH(43)     __ASM PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                 PUSH(671)    __ASM PUSH(510)    SWAP DO(R) PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                 PUSH(50)     __ASM PUSH(-1160)  SWAP DO(R) PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                  PUSH(7027)   __ASM PUSH(30)     SWAP DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                   PUSH(6927)   __ASM PUSH(-70)    SWAP DO(R) I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                      
PRINT_I({"+X.a 3   10..(25)      "})                 PUSH(10)     __ASM PUSH(25)     SWAP DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                 PUSH(0xC601) __ASM PUSH(0xC610) SWAP DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                 PUSH(25)     __ASM PUSH(2500)   SWAP DO(R) PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                 PUSH(-15)    __ASM PUSH(0)      SWAP DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                 PUSH(-29)    __ASM PUSH(5)      SWAP DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                 PUSH(227)    __ASM PUSH(260)    SWAP DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                 PUSH(-23)    __ASM PUSH(10)     SWAP DO(R) PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                 PUSH(-1485)  __ASM PUSH(230)    SWAP DO(R) PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                    PUSH(516)    __ASM PUSH(4516)   SWAP DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                 PUSH(33)     __ASM PUSH(1234)   SWAP DO(R) PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                 PUSH(1019)   __ASM PUSH(1034)   SWAP DO(R) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                   PUSH(100)    __ASM PUSH(500)    SWAP DO(R) I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(4) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                 PUSH(0)       DO(R,,13)     PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                 PUSH(0)       DO(R,,43)     PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                 PUSH(510)     DO(R,,671)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                 PUSH(-1160)   DO(R,,50)     PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                  PUSH(30)      DO(R,,7027)   I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                   PUSH(-70)     DO(R,,6927)   I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                                          
PRINT_I({"+X.a 3   10..(25)      "})                 PUSH(25)      DO(R,,10)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                 PUSH(0xC610)  DO(R,,0xC601) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                 PUSH(2500)    DO(R,,25)     PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                 PUSH(0)       DO(R,,-15)    PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                 PUSH(5)       DO(R,,-29)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                 PUSH(260)     DO(R,,227)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                 PUSH(10)      DO(R,,-23)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                 PUSH(230)     DO(R,,-1485)  PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                    PUSH(4516)    DO(R,,516)    I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                 PUSH(1234)    DO(R,,33)     PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                 PUSH(1034)    DO(R,,1019)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                   PUSH(500)     DO(R,,100)    I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(5) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                 PUSH(0)      __ASM DO(R,,13)     PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                 PUSH(0)      __ASM DO(R,,43)     PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                 PUSH(510)    __ASM DO(R,,671)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                 PUSH(-1160)  __ASM DO(R,,50)     PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                  PUSH(30)     __ASM DO(R,,7027)   I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                   PUSH(-70)    __ASM DO(R,,6927)   I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                                               
PRINT_I({"+X.a 3   10..(25)      "})                 PUSH(25)     __ASM DO(R,,10)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                 PUSH(0xC610) __ASM DO(R,,0xC601) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                 PUSH(2500)   __ASM DO(R,,25)     PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                 PUSH(0)      __ASM DO(R,,-15)    PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                 PUSH(5)      __ASM DO(R,,-29)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                 PUSH(260)    __ASM DO(R,,227)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                 PUSH(10)     __ASM DO(R,,-23)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                 PUSH(230)    __ASM DO(R,,-1485)  PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                    PUSH(4516)   __ASM DO(R,,516)    I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                 PUSH(1234)   __ASM DO(R,,33)     PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                 PUSH(1034)   __ASM DO(R,,1019)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                   PUSH(500)    __ASM DO(R,,100)    I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(6) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                  PUSH(13)     DO(R,0)      PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                  PUSH(43)     DO(R,0)      PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                  PUSH(671)    DO(R,510)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                  PUSH(50)     DO(R,-1160)  PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                   PUSH(7027)   DO(R,30)     I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                    PUSH(6927)   DO(R,-70)    I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                                          
PRINT_I({"+X.a 3   10..(25)      "})                  PUSH(10)     DO(R,25)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                  PUSH(0xC601) DO(R,0xC610) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                  PUSH(25)     DO(R,2500)   PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                  PUSH(-15)    DO(R,0)      PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                  PUSH(-29)    DO(R,5)      PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                  PUSH(227)    DO(R,260)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                  PUSH(-23)    DO(R,10)     PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                  PUSH(-1485)  DO(R,230)    PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                     PUSH(516)    DO(R,4516)   I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                  PUSH(33)     DO(R,1234)   PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                  PUSH(1019)   DO(R,1034)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                    PUSH(100)    DO(R,500)    I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(7) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                  PUSH(13)    __ASM  DO(R,0)      PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                  PUSH(43)    __ASM  DO(R,0)      PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                  PUSH(671)   __ASM  DO(R,510)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                  PUSH(50)    __ASM  DO(R,-1160)  PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                   PUSH(7027)  __ASM  DO(R,30)     I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                    PUSH(6927)  __ASM  DO(R,-70)    I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                                                
PRINT_I({"+X.a 3   10..(25)      "})                  PUSH(10)    __ASM  DO(R,25)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                  PUSH(0xC601)__ASM  DO(R,0xC610) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                  PUSH(25)    __ASM  DO(R,2500)   PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                  PUSH(-15)   __ASM  DO(R,0)      PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                  PUSH(-29)   __ASM  DO(R,5)      PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                  PUSH(227)   __ASM  DO(R,260)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                  PUSH(-23)   __ASM  DO(R,10)     PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                  PUSH(-1485) __ASM  DO(R,230)    PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                     PUSH(516)   __ASM  DO(R,4516)   I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                  PUSH(33)    __ASM  DO(R,1234)   PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                  PUSH(1019)  __ASM  DO(R,1034)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                    PUSH(100)   __ASM  DO(R,500)    I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(0) CALL(_pause)

;# --- -x ---                                      
PRINT_I({"-X.a -3   13..0        "})                 DO(R,0,     13)     PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.b -10  43..0        "})                 DO(R,0,     43)     PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.c -33 671..510      "})                 DO(R,510,   671)    PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.d -300 50..-1160    "})                 DO(R,-1160, 50)     PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.e -7   7027..30    "})                  DO(R,30,    7027)   I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
PRINT_I({"-X.def -7 6927..-70  "})                   DO(R,-70,   6927)   I CALL(_test)   PUSH(-7)  ADDLOOP CALL(_show)
;# --- +x ---                                        
PRINT_I({"+X.a 3   10..(25)      "})                 DO(R,25,    10)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.b 3 0xC601..(0xC610)"})                 DO(R,0xC610,0xC601) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.c 512 25..(2500)    "})                 DO(R,2500,  25)     PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.d 3  -15..(0)       "})                 DO(R,0,     -15)    PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.e 7  -29..(5)       "})                 DO(R,5,     -29)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.f 7  227..(260)     "})                 DO(R,260,   227)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.g 7  -23..(10)      "})                 DO(R,10,    -23)    PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.h 345 -1485..(230)  "})                 DO(R,230,   -1485)  PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.i 4  516..(4516) "})                    DO(R,4516,  516)    I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)
PRINT_I({"+X.j 300 33..1234      "})                 DO(R,1234,  33)     PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.k 3 1019..(1034)    "})                 DO(R,1034,  1019)   PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.l 4  100..(500)   "})                   DO(R,500,   100)    I CALL(_test) PUSH(4)   ADDLOOP CALL(_show)

PUSH(1) CALL(_pause)

;# ---xxx---
STOP
COLON(_test)
    PUSH(_counter) FETCH _1ADD PUSH(_counter) STORE
    PUSH(_index) STORE
SEMICOLON

COLON(_show)
    PUSH(_index)   FETCH        DOT
    PUSH(_counter) FETCH SPACE UDOT
    PUSH(0) PUSH(_index)   STORE
    PUSH(0) PUSH(_counter) STORE
    CR
SEMICOLON

COLON(_pause,( color -- ))
    ZX_BORDER
    CLEARKEY BEGIN KEYQUESTION UNTIL
    ZX_CLS
SEMICOLON


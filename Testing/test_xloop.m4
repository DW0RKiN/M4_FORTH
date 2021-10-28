include(`../M4/FIRST.M4')dnl
ORG 0x8000
INIT(60000)
;--- +1 ---
;       12345678901234567890123456789012
PRINT({"+1.A    251..(256)     "}) XDO(256,251)                PUTCHAR('.')          XLOOP CR
PRINT({"+1.B    241..(246)     "}) XDO(246,241)                PUTCHAR('.')          XLOOP CR
PRINT({"+1.C 0x3CFB..(0x3D00)  "}) XDO(0x3D00,0x3CFB)          PUTCHAR('.')          XLOOP CR
PRINT({"+1.D 0x3C05..(0x3C0A)  "}) XDO(0x3C0A,0x3C05)          PUTCHAR('.')          XLOOP CR
PRINT({"+1.E 0x65FB..(0x6600)  "}) XDO(0x6600,0x65FB)          PUTCHAR('.')          XLOOP CR
PRINT({"+1.F 0x4050..(0x4055)  "}) XDO(0x4055,0x4050)          PUTCHAR('.')          XLOOP CR
PRINT({"+1.G     -5..(0)       "}) XDO(0,-5)                   PUTCHAR('.')          XLOOP CR
PRINT({"+1.H     -3..(2)       "}) XDO(2,-3)                   PUTCHAR('.')          XLOOP CR
PRINT({"+1.I 6318h..(26368)"}) PUSH2(0,0) XDO(0x6700,0x6318)   DROP _1ADD XI         XLOOP UDOT UDOT CR
PRINT({"+1.def -700..(300)   "}) PUSH2(0,0) XDO(300,-700)      DROP _1ADD XI         XLOOP UDOT UDOT CR
;--- -1 ---
PRINT({"-1.A      4..0         "}) XDO(0,4)                    PUTCHAR('.')  PUSH_ADDXLOOP(-1) CR
PRINT({"-1.B      5..1         "}) XDO(1,5)                    PUTCHAR('.')  PUSH_ADDXLOOP(-1) CR
PRINT({"-1.C    258..254       "}) XDO(254,258)                PUTCHAR('.')  PUSH_ADDXLOOP(-1) CR
PRINT({"-1.D   1255..256     "})   PUSH2(0,0) XDO( 256,1255)   DROP _1ADD XI PUSH_ADDXLOOP(-1) DOT UDOT CR
PRINT({"-1.E    998..-1       "})  PUSH2(0,0) XDO(-1,998)      DROP _1ADD XI PUSH_ADDXLOOP(-1) DOT UDOT CR
PRINT({"-1.F   1001..2         "}) PUSH2(0,0) XDO(2,1001)      DROP _1ADD XI PUSH_ADDXLOOP(-1) DOT UDOT CR
PRINT({"-1.G   1199..200     "})   PUSH2(0,0) XDO(200,1199)    DROP _1ADD XI PUSH_ADDXLOOP(-1) DOT UDOT CR
PRINT({"-1.defA 375..-624   "})    PUSH2(0,0) XDO(-624,375)    DROP _1ADD XI PUSH_ADDXLOOP(-1) DOT UDOT CR
PRINT({"-1.defB 486..-513   "})    PUSH2(0,0) XDO(-513,486)    DROP _1ADD XI PUSH_ADDXLOOP(-1) DOT UDOT CR
;--- 2 ---
PRINT({"+2.A    -10..(0)       "}) XDO(0,-10)                  PUTCHAR('.')  PUSH_ADDXLOOP(2) CR
PRINT({"+2.B     -9..(1)       "}) XDO(1,-9)                   PUTCHAR('.')  PUSH_ADDXLOOP(2) CR
PRINT({"+2.C     -5..(5)       "}) XDO(5,-5)                   PUTCHAR('.')  PUSH_ADDXLOOP(2) CR
PRINT({"+2.D    304..(2304) "})    PUSH2(0,0) XDO(2304,304)    DROP _1ADD XI PUSH_ADDXLOOP(2) DOT UDOT CR
PRINT({"+2.defA  50..(2050) "})    PUSH2(0,0) XDO(2050,50)     DROP _1ADD XI PUSH_ADDXLOOP(2) DOT UDOT CR
PRINT({"+2.defB -10..(1990) "})    PUSH2(0,0) XDO(1990,-10)    DROP _1ADD XI PUSH_ADDXLOOP(2) DOT UDOT CR
;--- -2 ---
PRINT({"-2.A       8..0        "}) XDO(0,8)                    PUTCHAR('.')  PUSH_ADDXLOOP(-2) CR
PRINT({"-2.B       9..1        "}) XDO(1,9)                    PUTCHAR('.')  PUSH_ADDXLOOP(-2) CR
PRINT({"-2.C      10..2        "}) XDO(2,10)                   PUTCHAR('.')  PUSH_ADDXLOOP(-2) CR
PRINT({"-2.D     264..256      "}) XDO(256,264)                PUTCHAR('.')  PUSH_ADDXLOOP(-2) CR
PRINT({"-2.E     308..300      "}) XDO(300,308)                PUTCHAR('.')  PUSH_ADDXLOOP(-2) CR
PRINT({"-2.F    2001..3        "}) PUSH2(0,0) XDO(3,2001)      DROP _1ADD XI PUSH_ADDXLOOP(-2) DOT UDOT CR
PRINT({"-2.G    2232..234    "})   PUSH2(0,0) XDO(234,2232)    DROP _1ADD XI PUSH_ADDXLOOP(-2) DOT UDOT CR
PRINT({"-2.defA  196..-1802"})     PUSH2(0,0) XDO(-1802,196)   DROP _1ADD XI PUSH_ADDXLOOP(-2) DOT UDOT CR
PRINT({"-2.defB  250..-1748"})     PUSH2(0,0) XDO(-1748,250)   DROP _1ADD XI PUSH_ADDXLOOP(-2) DOT UDOT CR
;--- -x ---
PRINT({"-X.A -3   13..0        "}) XDO(0,13)                   PUTCHAR('.')  PUSH_ADDXLOOP(-3) CR
PRINT({"-X.B -10  43..0        "}) XDO(0,43)                   PUTCHAR('.')  PUSH_ADDXLOOP(-10) CR
PRINT({"-X.C -33 671..510      "}) XDO(510,671)                PUTCHAR('.')  PUSH_ADDXLOOP(-33) CR
PRINT({"-X.D -300 50..-1160    "}) XDO(-1160,50)               PUTCHAR('.')  PUSH_ADDXLOOP(-300) CR
PRINT({"-X.E -7   7027..30    "})  PUSH2(0,0) XDO(30,7027)     DROP _1ADD XI PUSH_ADDXLOOP(-7) DOT UDOT CR
PRINT({"-X.def -7 6927..-70  "})   PUSH2(0,0) XDO(-70,6927)    DROP _1ADD XI PUSH_ADDXLOOP(-7) DOT UDOT CR
;--- +x ---
PRINT({"+X.A 3   10..(25)      "}) XDO(25,10)                  PUTCHAR('.')  PUSH_ADDXLOOP(3) CR
PRINT({"+X.B 3 0xC601..(0xC610)"}) XDO(0xC610,0xC601)          PUTCHAR('.')  PUSH_ADDXLOOP(3) CR
PRINT({"+X.C 512 25..(2500)    "}) XDO(2500,25)                PUTCHAR('.')  PUSH_ADDXLOOP(512) CR
PRINT({"+X.D 3  -15..(0)       "}) XDO(0,-15)                  PUTCHAR('.')  PUSH_ADDXLOOP(3) CR
PRINT({"+X.E 7  -29..(5)       "}) XDO(5,-29)                  PUTCHAR('.')  PUSH_ADDXLOOP(7) CR
PRINT({"+X.F 7  227..(260)     "}) XDO(260,227)                PUTCHAR('.')  PUSH_ADDXLOOP(7) CR
PRINT({"+X.G 7  -23..(10)      "}) XDO(10,-23)                 PUTCHAR('.')  PUSH_ADDXLOOP(7) CR
PRINT({"+X.H 345 -1485..(230)  "}) XDO(230,-1485)              PUTCHAR('.')  PUSH_ADDXLOOP(345) CR
PRINT({"+X.I 4  516..(4516) "})    PUSH2(0,0) XDO(4516,516)    DROP _1ADD XI PUSH_ADDXLOOP(4) DOT UDOT CR
PRINT({"+X.J 300 33..1234      "}) XDO(1234,33)                PUTCHAR('.')  PUSH_ADDXLOOP(300) CR
PRINT({"+X.K 3 1019..(1034)    "}) XDO(1034,1019)              PUTCHAR('.')  PUSH_ADDXLOOP(3) CR
PRINT({"+X.L 4  100..(500)   "})   PUSH2(0,0) XDO(500,100)     DROP _1ADD XI PUSH_ADDXLOOP(4) DOT UDOT CR
;---xxx---
STOP

include(`../M4/FIRST.M4')dnl
ORG 0x8000
INIT(60000)
;--- +1 ---
;       12345678901234567890123456789012
PRINT_I({"+1.A    251..(256)     "})            DO(,256,251)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.B    241..(246)     "})            DO(,246,241)       PUTCHAR('.')               LOOP CR
PRINT_I({"+1.C 0x3CFB..(0x3D00)  "})            DO(,0x3D00,0x3CFB) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.D 0x3C05..(0x3C0A)  "})            DO(,0x3C0A,0x3C05) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.E 0x65FB..(0x6600)  "})            DO(,0x6600,0x65FB) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.F 0x4050..(0x4055)  "})            DO(,0x4055,0x4050) PUTCHAR('.')               LOOP CR
PRINT_I({"+1.G     -5..(0)       "})            DO(,0,-5)          PUTCHAR('.')               LOOP CR
PRINT_I({"+1.H     -3..(2)       "})            DO(,2,-3)          PUTCHAR('.')               LOOP CR
PRINT_I({"+1.I 6318h..(26368)"})     PUSH2(0,0) DO(,0x6700,0x6318) DROP _1ADD I               LOOP UDOT SPACE UDOT CR
PRINT_I({"+1.def -700..(300)   "})   PUSH2(0,0) DO(,300,-700)      DROP _1ADD I               LOOP UDOT SPACE UDOT CR
;--- -1 ---
PRINT_I({"-1.A      4..0         "})            DO(,0,4)           PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.B      5..1         "})            DO(,1,5)           PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.C    258..254       "})            DO(,254,258)       PUTCHAR('.')  PUSH(-1)  ADDLOOP CR
PRINT_I({"-1.D   1255..256     "})   PUSH2(0,0) DO(, 256,1255)     DROP _1ADD I  PUSH(-1)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-1.E    998..-1       "})  PUSH2(0,0) DO(,-1,998)        DROP _1ADD I  PUSH(-1)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-1.F   1001..2         "}) PUSH2(0,0) DO(,2,1001)        DROP _1ADD I  PUSH(-1)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-1.G   1199..200     "})   PUSH2(0,0) DO(,200,1199)      DROP _1ADD I  PUSH(-1)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-1.defA 375..-624   "})    PUSH2(0,0) DO(,-624,375)      DROP _1ADD I  PUSH(-1)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-1.defB 486..-513   "})    PUSH2(0,0) DO(,-513,486)      DROP _1ADD I  PUSH(-1)  ADDLOOP DOT SPACE UDOT CR
;--- 2 ---
PRINT_I({"+2.A    -10..(0)       "})            DO(,0,-10)         PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.B     -9..(1)       "})            DO(,1,-9)          PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.C     -5..(5)       "})            DO(,5,-5)          PUTCHAR('.')  PUSH(2)   ADDLOOP CR
PRINT_I({"+2.D    304..(2304) "})    PUSH2(0,0) DO(,2304,304)      DROP _1ADD I  PUSH(2)   ADDLOOP DOT SPACE UDOT CR
PRINT_I({"+2.defA  50..(2050) "})    PUSH2(0,0) DO(,2050,50)       DROP _1ADD I  PUSH(2)   ADDLOOP DOT SPACE UDOT CR
PRINT_I({"+2.defB -10..(1990) "})    PUSH2(0,0) DO(,1990,-10)      DROP _1ADD I  PUSH(2)   ADDLOOP DOT SPACE UDOT CR
;--- -2 ---
PRINT_I({"-2.A       8..0        "})            DO(,0,8)           PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.B       9..1        "})            DO(,1,9)           PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.C      10..2        "})            DO(,2,10)          PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.D     264..256      "})            DO(,256,264)       PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.E     308..300      "})            DO(,300,308)       PUTCHAR('.')  PUSH(-2)  ADDLOOP CR
PRINT_I({"-2.F    2001..3        "}) PUSH2(0,0) DO(,3,2001)        DROP _1ADD I  PUSH(-2)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-2.G    2232..234    "})   PUSH2(0,0) DO(,234,2232)      DROP _1ADD I  PUSH(-2)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-2.defA  196..-1802 "})    PUSH2(0,0) DO(,-1802,196)     DROP _1ADD I  PUSH(-2)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-2.defB  250..-1748 "})    PUSH2(0,0) DO(,-1748,250)     DROP _1ADD I  PUSH(-2)  ADDLOOP DOT SPACE UDOT CR
;--- -x ---
PRINT_I({"-X.A -3   13..0        "})            DO(,0,13)          PUTCHAR('.')  PUSH(-3)  ADDLOOP CR
PRINT_I({"-X.B -10  43..0        "})            DO(,0,43)          PUTCHAR('.')  PUSH(-10) ADDLOOP CR
PRINT_I({"-X.C -33 671..510      "})            DO(,510,671)       PUTCHAR('.')  PUSH(-33) ADDLOOP CR
PRINT_I({"-X.D -300 50..-1160    "})            DO(,-1160,50)      PUTCHAR('.')  PUSH(-300)ADDLOOP CR
PRINT_I({"-X.E -7   7027..30    "})  PUSH2(0,0) DO(,30,7027)       DROP _1ADD I  PUSH(-7)  ADDLOOP DOT SPACE UDOT CR
PRINT_I({"-X.def -7 6927..-70  "})   PUSH2(0,0) DO(,-70,6927)      DROP _1ADD I  PUSH(-7)  ADDLOOP DOT SPACE UDOT CR
;--- +x ---
PRINT_I({"+X.A 3   10..(25)      "})            DO(,25,10)         PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.B 3 0xC601..(0xC610)"})            DO(,0xC610,0xC601) PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.C 512 25..(2500)    "})            DO(,2500,25)       PUTCHAR('.')  PUSH(512) ADDLOOP CR
PRINT_I({"+X.D 3  -15..(0)       "})            DO(,0,-15)         PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.E 7  -29..(5)       "})            DO(,5,-29)         PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.F 7  227..(260)     "})            DO(,260,227)       PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.G 7  -23..(10)      "})            DO(,10,-23)        PUTCHAR('.')  PUSH(7)   ADDLOOP CR
PRINT_I({"+X.H 345 -1485..(230)  "})            DO(,230,-1485)     PUTCHAR('.')  PUSH(345) ADDLOOP CR
PRINT_I({"+X.I 4  516..(4516) "})    PUSH2(0,0) DO(,4516,516)      DROP _1ADD I  PUSH(4)   ADDLOOP DOT SPACE UDOT CR
PRINT_I({"+X.J 300 33..1234      "})            DO(,1234,33)       PUTCHAR('.')  PUSH(300) ADDLOOP CR
PRINT_I({"+X.K 3 1019..(1034)    "})            DO(,1034,1019)     PUTCHAR('.')  PUSH(3)   ADDLOOP CR
PRINT_I({"+X.L 4  100..(500)   "})   PUSH2(0,0) DO(,500,100)       DROP _1ADD I  PUSH(4)   ADDLOOP DOT SPACE UDOT CR
;---xxx---
STOP

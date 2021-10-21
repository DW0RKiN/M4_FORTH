ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init

    push DE             ; 1:11      print     "XDO(10,5)          XLOOP "
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      xdo(10,5) 101
xdo101save:             ;           xdo(10,5) 101
    ld  (idx101),BC     ; 4:20      xdo(10,5) 101
xdo101:                 ;           xdo(10,5) 101 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx101 EQU $+1          ;[12:45]    xloop 101   variant: 0 <= index < stop < 256, 5.. +1 ..(10)
    ld    A, 0          ; 2:7       xloop 101
    nop                 ; 1:4       xloop 101   Contains a zero value because idx always points to a 16-bit index.
    inc   A             ; 1:4       xloop 101   index++
    ld  (idx101),A      ; 3:13      xloop 101
    sub  low 10         ; 2:7       xloop 101
    jp    c, xdo101     ; 3:10      xloop 101   index-stop
xleave101:              ;           xloop 101
xexit101:               ;           xloop 101 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(0x3c0A,0x3c05) XLOOP "
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 0x3c05     ; 3:10      xdo(0x3c0A,0x3c05) 102
xdo102save:             ;           xdo(0x3c0A,0x3c05) 102
    ld  (idx102),BC     ; 4:20      xdo(0x3c0A,0x3c05) 102
xdo102:                 ;           xdo(0x3c0A,0x3c05) 102 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx102 EQU $+1          ;[11:41]    xloop 102   variant: hi index == hi stop == 0x3c && index < stop, 0x3c05.. +1 ..(0x3c0A)
    ld    A, 0          ; 2:7       xloop 102
    inc   A             ; 1:4       xloop 102   = hi index = 0x3c -> idx always points to a 16-bit index
    ld  (idx102),A      ; 3:13      xloop 102   save index
    sub  low 0x3c0A     ; 2:7       xloop 102   index - stop
    jp    c, xdo102     ; 3:10      xloop 102
xleave102:              ;           xloop 102
xexit102:               ;           xloop 102 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(0x4055,0x4050) XLOOP "
    ld   BC, size103    ; 3:10      print     Length of string103
    ld   DE, string103  ; 3:10      print     Address of string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 0x4050     ; 3:10      xdo(0x4055,0x4050) 103
xdo103save:             ;           xdo(0x4055,0x4050) 103
    ld  (idx103),BC     ; 4:20      xdo(0x4055,0x4050) 103
xdo103:                 ;           xdo(0x4055,0x4050) 103 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx103 EQU $+1          ;[13:48]    xloop 103   variant: hi index == hi stop && index < stop, 0x4050.. +1 ..(0x4055)
    ld   BC, 0x0000     ; 3:10      xloop 103   idx always points to a 16-bit index
    ld    A, C          ; 1:4       xloop 103
    inc   A             ; 1:4       xloop 103   index++
    ld  (idx103),A      ; 3:13      xloop 103   save index
    sub  low 0x4055     ; 2:7       xloop 103   index - stop
    jp    c, xdo103     ; 3:10      xloop 103
xleave103:              ;           xloop 103
xexit103:               ;           xloop 103 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(0,-5)          XLOOP "
    ld   BC, size104    ; 3:10      print     Length of string104
    ld   DE, string104  ; 3:10      print     Address of string104
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -5         ; 3:10      xdo(0,-5) 104
xdo104save:             ;           xdo(0,-5) 104
    ld  (idx104),BC     ; 4:20      xdo(0,-5) 104
xdo104:                 ;           xdo(0,-5) 104 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx104 EQU $+1          ;[9:54/34]  xloop 104   variant: stop == 0, -5.. +1 ..(0)
    ld   BC, 0x0000     ; 3:10      xloop 104   idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 104   index++
    ld    A, B          ; 1:4       xloop 104
    or    C             ; 1:4       xloop 104   index - stop
    jp   nz, xdo104save ; 3:10      xloop 104
xleave104:              ;           xloop 104
xexit104:               ;           xloop 104 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(0x6600,0x65FC) XLOOP "
    ld   BC, size105    ; 3:10      print     Length of string105
    ld   DE, string105  ; 3:10      print     Address of string105
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 0x65FC     ; 3:10      xdo(0x6600,0x65FC) 105
xdo105save:             ;           xdo(0x6600,0x65FC) 105
    ld  (idx105),BC     ; 4:20      xdo(0x6600,0x65FC) 105
xdo105:                 ;           xdo(0x6600,0x65FC) 105 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx105 EQU $+1          ;[10:57/37] xloop 105   variant: lo stop == 0  && hi index != hi stop, 0x65FC.. +1 ..(0x6600)
    ld   BC, 0x0000     ; 3:10      xloop 105   idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 105   index++
    ld    A, B          ; 1:4       xloop 105
    sub  high 0x6600    ; 2:7       xloop 105   index - stop
    jp   nz, xdo105save ; 3:10      xloop 105
xleave105:              ;           xloop 105
xexit105:               ;           xloop 105 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(513,507)       XLOOP "
    ld   BC, size106    ; 3:10      print     Length of string106
    ld   DE, string106  ; 3:10      print     Address of string106
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 507        ; 3:10      xdo(513,507) 106
xdo106save:             ;           xdo(513,507) 106
    ld  (idx106),BC     ; 4:20      xdo(513,507) 106
xdo106:                 ;           xdo(513,507) 106 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx106 EQU $+1          ;[13:68/48] xloop 106   variant: index < stop && same sign, 507.. +1 ..(513)
    ld   BC, 0x0000     ; 3:10      xloop 106   idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 106   index++
    ld    A, C          ; 1:4       xloop 106
    sub  low 513        ; 2:7       xloop 106   index - stop
    ld    A, B          ; 1:4       xloop 106
    sbc   A, high 513   ; 2:7       xloop 106   index - stop
    jp    c, xdo106save ; 3:10      xloop 106
xleave106:              ;           xloop 106
xexit106:               ;           xloop 106 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(-253,-258)     XLOOP "
    ld   BC, size107    ; 3:10      print     Length of string107
    ld   DE, string107  ; 3:10      print     Address of string107
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -258       ; 3:10      xdo(-253,-258) 107
xdo107save:             ;           xdo(-253,-258) 107
    ld  (idx107),BC     ; 4:20      xdo(-253,-258) 107
xdo107:                 ;           xdo(-253,-258) 107 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx107 EQU $+1          ;[13:68/48] xloop 107   variant: index < stop && same sign, -258.. +1 ..(-253)
    ld   BC, 0x0000     ; 3:10      xloop 107   idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 107   index++
    ld    A, C          ; 1:4       xloop 107
    sub  low -253       ; 2:7       xloop 107   index - stop
    ld    A, B          ; 1:4       xloop 107
    sbc   A, high -253  ; 2:7       xloop 107   index - stop
    jp    c, xdo107save ; 3:10      xloop 107
xleave107:              ;           xloop 107
xexit107:               ;           xloop 107 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- default 1 ---

    push DE             ; 1:11      print     "XDO(257,-1) XLOOP "
    ld   BC, size108    ; 3:10      print     Length of string108
    ld   DE, string108  ; 3:10      print     Address of string108
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -1         ; 3:10      xdo(257,-1) 108
xdo108save:             ;           xdo(257,-1) 108
    ld  (idx108),BC     ; 4:20      xdo(257,-1) 108
xdo108:                 ;           xdo(257,-1) 108 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx108 EQU $+1          ;[16:~57]   xloop 108   variant: -1.. +1 ..(257)
    ld   BC, 0x0000     ; 3:10      xloop 108   idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 108   index++
    ld    A, C          ; 1:4       xloop 108
    xor  low 257        ; 2:7       xloop 108
    jp   nz, xdo108save ; 3:10      xloop 108
    ld    A, B          ; 1:4       xloop 108
    xor  high 257       ; 2:7       xloop 108
    jp   nz, xdo108save ; 3:10      xloop 108
xleave108:              ;           xloop 108
xexit108:               ;           xloop 108 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- -1 ---

    push DE             ; 1:11      print     "XDO(-1,4)   +XLOOP(-1) "
    ld   BC, size109    ; 3:10      print     Length of string109
    ld   DE, string109  ; 3:10      print     Address of string109
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 4          ; 3:10      xdo(-1,4) 109
xdo109save:             ;           xdo(-1,4) 109
    ld  (idx109),BC     ; 4:20      xdo(-1,4) 109
xdo109:                 ;           xdo(-1,4) 109 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx109 EQU $+1          ;[10:58/38] -1 +xloop 109   variant: 4.. -1 ..-1 = -1
    ld   BC, 0x0000     ; 3:10      -1 +xloop 109   idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop 109
    and   B             ; 1:4       -1 +xloop 109   0xff & 0xff = 0xff
    dec  BC             ; 1:6       -1 +xloop 109   index--
    inc   A             ; 1:4       -1 +xloop 109   0xff -> 0
    jp   nz, xdo109save ; 3:10      -1 +xloop 109
xleave109:              ;           -1 +xloop 109
xexit109:               ;           xloop 109 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(0,5)    +XLOOP(-1) "
    ld   BC, size110    ; 3:10      print     Length of string110
    ld   DE, string110  ; 3:10      print     Address of string110
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      xdo(0,5) 110
xdo110save:             ;           xdo(0,5) 110
    ld  (idx110),BC     ; 4:20      xdo(0,5) 110
xdo110:                 ;           xdo(0,5) 110 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx110 EQU $+1          ;[9:54/34]  -1 +xloop 110   variant: 5.. -1 ..0 = 0
    ld   BC, 0x0000     ; 3:10      -1 +xloop 110   idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop 110
    or    B             ; 1:4       -1 +xloop 110
    dec  BC             ; 1:6       -1 +xloop 110   index--
    jp   nz, xdo110save ; 3:10      -1 +xloop 110
xleave110:              ;           -1 +xloop 110
xexit110:               ;           xloop 110 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(1,6)    +XLOOP(-1) "
    ld   BC, size111    ; 3:10      print     Length of string111
    ld   DE, string111  ; 3:10      print     Address of string111
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 6          ; 3:10      xdo(1,6) 111
xdo111save:             ;           xdo(1,6) 111
    ld  (idx111),BC     ; 4:20      xdo(1,6) 111
xdo111:                 ;           xdo(1,6) 111 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx111 EQU $+1          ;[9:54/34]  -1 +xloop 111   variant: 6.. -1 ..1 = 1
    ld   BC, 0x0000     ; 3:10      -1 +xloop 111   idx always points to a 16-bit index
    dec  BC             ; 1:6       -1 +xloop 111   index--
    ld    A, C          ; 1:4       -1 +xloop 111
    or    B             ; 1:4       -1 +xloop 111
    jp   nz, xdo111save ; 3:10      -1 +xloop 111
xleave111:              ;           -1 +xloop 111
xexit111:               ;           xloop 111 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(2,7)    +XLOOP(-1) "
    ld   BC, size112    ; 3:10      print     Length of string112
    ld   DE, string112  ; 3:10      print     Address of string112
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 7          ; 3:10      xdo(2,7) 112
xdo112save:             ;           xdo(2,7) 112
    ld  (idx112),BC     ; 4:20      xdo(2,7) 112
xdo112:                 ;           xdo(2,7) 112 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx112 EQU $+1          ;[10:58/38] -1 +xloop 112   variant: 7.. -1 ..2 = 2
    ld   BC, 0x0000     ; 3:10      -1 +xloop 112   idx always points to a 16-bit index
    dec  BC             ; 1:6       -1 +xloop 112   index--
    ld    A, C          ; 1:4       -1 +xloop 112
    dec   A             ; 1:4       -1 +xloop 112
    or    B             ; 1:4       -1 +xloop 112
    jp   nz, xdo112save ; 3:10      -1 +xloop 112
xleave112:              ;           -1 +xloop 112
xexit112:               ;           xloop 112 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- default -1 0<=stop<256 ---

    push DE             ; 1:11      print     "XDO(50,55)  +XLOOP(-1) "
    ld   BC, size113    ; 3:10      print     Length of string113
    ld   DE, string113  ; 3:10      print     Address of string113
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 55         ; 3:10      xdo(50,55) 113
xdo113save:             ;           xdo(50,55) 113
    ld  (idx113),BC     ; 4:20      xdo(50,55) 113
xdo113:                 ;           xdo(50,55) 113 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx113 EQU $+1          ;[11:61/41] -1 +xloop 113   variant: 55.. -1 ..50 -> hi stop = 0
    ld   BC, 0x0000     ; 3:10      -1 +xloop 113   idx always points to a 16-bit index
    dec  BC             ; 1:6       -1 +xloop 113   index--
    ld    A, C          ; 1:4       -1 +xloop 113
    sub   low 50        ; 2:7       -1 +xloop 113
    or    B             ; 1:4       -1 +xloop 113
    jp   nz, xdo113save ; 3:10      -1 +xloop 113
xleave113:              ;           -1 +xloop 113
xexit113:               ;           xloop 113 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- default -1 ---

    push DE             ; 1:11      print     "XDO(-7,-2)  +XLOOP(-1) "
    ld   BC, size114    ; 3:10      print     Length of string114
    ld   DE, string114  ; 3:10      print     Address of string114
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -2         ; 3:10      xdo(-7,-2) 114
xdo114save:             ;           xdo(-7,-2) 114
    ld  (idx114),BC     ; 4:20      xdo(-7,-2) 114
xdo114:                 ;           xdo(-7,-2) 114 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx114 EQU $+1          ;[20:~61]   -1 +xloop 114   variant: -2.. -1 ..-7
    ld   BC, 0x0000     ; 3:10      -1 +xloop 114   idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop 114
    xor  low -7         ; 2:7       -1 +xloop 114
    ld    A, B          ; 1:4       -1 +xloop 114
    dec  BC             ; 1:6       -1 +xloop 114   index--
    jp   nz, xdo114save ; 3:10      -1 +xloop 114
    xor  high -7        ; 2:7       -1 +xloop 114
    jp   nz, xdo114save ; 3:10      -1 +xloop 114
xleave114:              ;           -1 +xloop 114
xexit114:               ;           xloop 114 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- 2 ---

    push DE             ; 1:11      print     "XDO(0,-10)  +XLOOP(2) "
    ld   BC, size115    ; 3:10      print     Length of string115
    ld   DE, string115  ; 3:10      print     Address of string115
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -10        ; 3:10      xdo(0,-10) 115
xdo115save:             ;           xdo(0,-10) 115
    ld  (idx115),BC     ; 4:20      xdo(0,-10) 115
xdo115:                 ;           xdo(0,-10) 115 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx115 EQU $+1          ;[12:67/47] 2 +xloop 115   variant: step 2 and stop 0, -10.. +2 ..(0)
    ld   BC, 0x0000     ; 3:10      2 +xloop 115   idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 115   index++
    inc  BC             ; 1:6       2 +xloop 115   index++
    ld    A, C          ; 1:4       2 +xloop 115
    and  0xFE           ; 2:7       2 +xloop 115   0 or 1 -> 0
    or    B             ; 1:4       2 +xloop 115
    jp   nz, xdo115save ; 3:10      2 +xloop 115
xleave115:              ;           2 +xloop 115
xexit115:               ;           2 +xloop 115 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(1,-10)  +XLOOP(2) "
    ld   BC, size116    ; 3:10      print     Length of string116
    ld   DE, string116  ; 3:10      print     Address of string116
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -10        ; 3:10      xdo(1,-10) 116
xdo116save:             ;           xdo(1,-10) 116
    ld  (idx116),BC     ; 4:20      xdo(1,-10) 116
xdo116:                 ;           xdo(1,-10) 116 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx116 EQU $+1          ;[12:67/47] 2 +xloop 116   variant: step 2 and stop 1, -10.. +2 ..(1)
    ld   BC, 0x0000     ; 3:10      2 +xloop 116   idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 116   index++
    ld    A, C          ; 1:4       2 +xloop 116
    and  0xFE           ; 2:7       2 +xloop 116   0 or 1 -> 0
    or    B             ; 1:4       2 +xloop 116
    inc  BC             ; 1:6       2 +xloop 116   index++
    jp   nz, xdo116save ; 3:10      2 +xloop 116
xleave116:              ;           2 +xloop 116
xexit116:               ;           2 +xloop 116 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- default 2 ---

    push DE             ; 1:11      print     "XDO(50,40)  +XLOOP(2) "
    ld   BC, size117    ; 3:10      print     Length of string117
    ld   DE, string117  ; 3:10      print     Address of string117
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 40         ; 3:10      xdo(50,40) 117
xdo117save:             ;           xdo(50,40) 117
    ld  (idx117),BC     ; 4:20      xdo(50,40) 117
xdo117:                 ;           xdo(50,40) 117 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx117 EQU $+1          ;[19:71/72] 2 +xloop 117   variant: step 2, 40.. +2 ..(50)
    ld   BC, 0x0000     ; 3:10      2 +xloop 117   idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 117   index++
    inc  BC             ; 1:6       2 +xloop 117   index++
    ld    A, C          ; 1:4       2 +xloop 117
    sub  low 50         ; 2:7       2 +xloop 117
    rra                 ; 1:4       2 +xloop 117
    add   A, A          ; 1:4       2 +xloop 117   and 0xFE with save carry
    jp   nz, xdo117save ; 3:10      2 +xloop 117
    ld    A, B          ; 1:4       2 +xloop 117
    sbc   A, high 50    ; 2:7       2 +xloop 117
    jp   nz, xdo117save ; 3:10      2 +xloop 117
xleave117:              ;           2 +xloop 117
xexit117:               ;           2 +xloop 117 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- +x ---

    push DE             ; 1:11      print     "XDO(123,25) +XLOOP(21) "
    ld   BC, size118    ; 3:10      print     Length of string118
    ld   DE, string118  ; 3:10      print     Address of string118
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 25         ; 3:10      xdo(123,25) 118
xdo118save:             ;           xdo(123,25) 118
    ld  (idx118),BC     ; 4:20      xdo(123,25) 118
xdo118:                 ;           xdo(123,25) 118 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[13:48]    21 +xloop 118   variant: positive step and 0 <= index:25 < stop:123 < 256, real stop:130, run 5x, 25.. +21 ..(123)
idx118 EQU $+1          ;           21 +xloop 118
    ld    A, 0x00       ; 2:7       21 +xloop 118   A = index
    nop                 ; 1:4       21 +xloop 118   Contains a zero value because idx always points to a 16-bit index.
    add   A, low 21     ; 2:7       21 +xloop 118   A = index+step
    ld  (idx118), A     ; 3:13      21 +xloop 118   save new index
    xor  low 130        ; 2:7       21 +xloop 118   Contains the values of 46..130
    jp   nz, xdo118     ; 3:10      21 +xloop 118
xleave118:              ;           21 +xloop 118
xexit118:               ;           21 +xloop 118 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(-14712,-14848) +XLOOP(29) "
    ld   BC, size119    ; 3:10      print     Length of string119
    ld   DE, string119  ; 3:10      print     Address of string119
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -14848     ; 3:10      xdo(-14712,-14848) 119
xdo119save:             ;           xdo(-14712,-14848) 119
    ld  (idx119),BC     ; 4:20      xdo(-14712,-14848) 119
xdo119:                 ;           xdo(-14712,-14848) 119 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[12:44]    29 +xloop 119   variant: positive step and 0xC600 <= index:-14848 < stop:-14712 < 0xC700, real stop:50833, run 5x, -14848.. +29 ..(-14712)
idx119 EQU $+1          ;           29 +xloop 119
    ld    A, 0x00       ; 2:7       29 +xloop 119   A = index
    add   A, low 29     ; 2:7       29 +xloop 119   First byte contains a 0xC6 value because idx always points to a 16-bit index.
    ld  (idx119), A     ; 3:13      29 +xloop 119   save new index
    xor  low 50833      ; 2:7       29 +xloop 119   Contains the values of 29..145
    jp   nz, xdo119     ; 3:10      29 +xloop 119
xleave119:              ;           29 +xloop 119
xexit119:               ;           29 +xloop 119 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(2500,25)+XLOOP(512) "
    ld   BC, size120    ; 3:10      print     Length of string120
    ld   DE, string120  ; 3:10      print     Address of string120
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 25         ; 3:10      xdo(2500,25) 120
xdo120save:             ;           xdo(2500,25) 120
    ld  (idx120),BC     ; 4:20      xdo(2500,25) 120
xdo120:                 ;           xdo(2500,25) 120 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[12:62/42] 512 +xloop 120   variant: positive lo step 0 and real stop 2585, run 5x, 25.. +512 ..(2500)
idx120 EQU $+1          ;           512 +xloop 120
    ld   BC, 0x0000     ; 3:10      512 +xloop 120
    ld    A, B          ; 1:4       512 +xloop 120
    add   A, high 512   ; 2:7       512 +xloop 120
    ld    B, A          ; 1:4       512 +xloop 120
    xor  high 2585      ; 2:7       512 +xloop 120
    jp   nz, xdo120save ; 3:10      512 +xloop 120
xleave120:              ;           512 +xloop 120
xexit120:               ;           512 +xloop 120 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(100,-444) +XLOOP(111) "
    ld   BC, size121    ; 3:10      print     Length of string121
    ld   DE, string121  ; 3:10      print     Address of string121
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -444       ; 3:10      xdo(100,-444) 121
xdo121save:             ;           xdo(100,-444) 121
    ld  (idx121),BC     ; 4:20      xdo(100,-444) 121
xdo121:                 ;           xdo(100,-444) 121 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[19:93]    111 +xloop 121   variant: positive step and 0 <= real stop:111 < 256, run 5x, -444.. +111 ..(100)
    push HL             ; 1:11      111 +xloop 121
idx121 EQU $+1          ;           111 +xloop 121
    ld   HL, 0x0000     ; 3:10      111 +xloop 121
    ld   BC, 111        ; 3:10      111 +xloop 121   BC = step
    add  HL, BC         ; 1:11      111 +xloop 121   HL = index+step
    ld  (idx121), HL    ; 3:16      111 +xloop 121   save new index
    ld    A, low 111    ; 2:7       111 +xloop 121   A = last_index
    xor   L             ; 1:4       111 +xloop 121
    or    H             ; 1:4       111 +xloop 121
    pop  HL             ; 1:10      111 +xloop 121
    jp   nz, xdo121     ; 3:10      111 +xloop 121
xleave121:              ;           111 +xloop 121
xexit121:               ;           111 +xloop 121 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(0,-66)  +XLOOP(13) "
    ld   BC, size122    ; 3:10      print     Length of string122
    ld   DE, string122  ; 3:10      print     Address of string122
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, -66        ; 3:10      xdo(0,-66) 122
xdo122save:             ;           xdo(0,-66) 122
    ld  (idx122),BC     ; 4:20      xdo(0,-66) 122
xdo122:                 ;           xdo(0,-66) 122 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[17:90]    13 +xloop 122   variant: positive step and stop 0, -66.. +13 ..0
    push HL             ; 1:11      13 +xloop 122
idx122 EQU $+1          ;           13 +xloop 122
    ld   HL, 0x0000     ; 3:10      13 +xloop 122
    ld   BC, 13         ; 3:10      13 +xloop 122   BC = step
    dec  HL             ; 1:6       13 +xloop 122
    add  HL, BC         ; 1:11      13 +xloop 122   HL = index+step-1
    inc  HL             ; 1:6       13 +xloop 122
    ld  (idx122), HL    ; 3:16      13 +xloop 122   save new index
    pop  HL             ; 1:10      13 +xloop 122
    jp   nc, xdo122     ; 3:10      13 +xloop 122   positive step
xleave122:              ;           13 +xloop 122
xexit122:               ;           13 +xloop 122 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- default +x < 256  ---

    push DE             ; 1:11      print     "XDO(1234,50)+XLOOP(250) "
    ld   BC, size123    ; 3:10      print     Length of string123
    ld   DE, string123  ; 3:10      print     Address of string123
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 50         ; 3:10      xdo(1234,50) 123
xdo123save:             ;           xdo(1234,50) 123
    ld  (idx123),BC     ; 4:20      xdo(1234,50) 123
xdo123:                 ;           xdo(1234,50) 123 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[22:78/79] 250 +xloop 123   variant: positive hi step 0 and real stop 1300, run 5x, 50.. +250 ..(1234)
idx123 EQU $+1          ;           250 +xloop 123
    ld   BC, 0x0000     ; 3:10      250 +xloop 123
    ld    A, C          ; 1:4       250 +xloop 123
    add   A, low 250    ; 2:7       250 +xloop 123
    ld    C, A          ; 1:4       250 +xloop 123
    adc   A, B          ; 1:4       250 +xloop 123
    sub   C             ; 1:4       250 +xloop 123
    ld    B, A          ; 1:4       250 +xloop 123
    ld    A, C          ; 1:4       250 +xloop 123
    xor  low 1300       ; 2:7       250 +xloop 123
    jp   nz, xdo123save ; 3:10      250 +xloop 123
    ld    A, B          ; 1:4       250 +xloop 123
    xor  high 1300      ; 2:7       250 +xloop 123
    jp   nz, xdo123save ; 3:10      250 +xloop 123
xleave123:              ;           250 +xloop 123
xexit123:               ;           250 +xloop 123 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- default +x >= 256  ---

    push DE             ; 1:11      print     "XDO(1234,50)+XLOOP(260) "
    ld   BC, size124    ; 3:10      print     Length of string124
    ld   DE, string124  ; 3:10      print     Address of string124
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 50         ; 3:10      xdo(1234,50) 124
xdo124save:             ;           xdo(1234,50) 124
    ld  (idx124),BC     ; 4:20      xdo(1234,50) 124
xdo124:                 ;           xdo(1234,50) 124 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[23:81/82] 260 +xloop 124   variant: positive step and real stop 1350, run 5x, 50.. +260 ..(1234)
idx124 EQU $+1          ;           260 +xloop 124
    ld   BC, 0x0000     ; 3:10      260 +xloop 124
    ld    A, C          ; 1:4       260 +xloop 124
    add   A, low 260    ; 2:7       260 +xloop 124
    ld    C, A          ; 1:4       260 +xloop 124
    ld    A, B          ; 1:4       260 +xloop 124
    adc   A, high 260   ; 2:7       260 +xloop 124
    ld    B, A          ; 1:4       260 +xloop 124
    ld    A, C          ; 1:4       260 +xloop 124
    xor  low 1350       ; 2:7       260 +xloop 124
    jp   nz, xdo124save ; 3:10      260 +xloop 124
    ld    A, B          ; 1:4       260 +xloop 124
    xor  high 1350      ; 2:7       260 +xloop 124
    jp   nz, xdo124save ; 3:10      260 +xloop 124
xleave124:              ;           260 +xloop 124
xexit124:               ;           260 +xloop 124 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- -x ---

    push DE             ; 1:11      print     "XDO(0,8)   +XLOOP(-2) "
    ld   BC, size125    ; 3:10      print     Length of string125
    ld   DE, string125  ; 3:10      print     Address of string125
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 8          ; 3:10      xdo(0,8) 125
xdo125save:             ;           xdo(0,8) 125
    ld  (idx125),BC     ; 4:20      xdo(0,8) 125
xdo125:                 ;           xdo(0,8) 125 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx125 EQU $+1          ;[10:60/40] -2 +xloop 125   variant: step -2 and stop 0, 8.. -2 ..0
    ld   BC, 0x0000     ; 3:10      -2 +xloop 125   idx always points to a 16-bit index
    ld    A, B          ; 1:4       -2 +xloop 125   hi old index
    dec  BC             ; 1:6       -2 +xloop 125   index--
    dec  BC             ; 1:6       -2 +xloop 125   index--
    sub   B             ; 1:4       -2 +xloop 125   old-new = carry if index: positive -> negative
    jp   nc, xdo125save ; 3:10      -2 +xloop 125   carry if postivie index -> negative index
xleave125:              ;           -2 +xloop 125
xexit125:               ;           -2 +xloop 125 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(0,12)   +XLOOP(-3) "
    ld   BC, size126    ; 3:10      print     Length of string126
    ld   DE, string126  ; 3:10      print     Address of string126
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 12         ; 3:10      xdo(0,12) 126
xdo126save:             ;           xdo(0,12) 126
    ld  (idx126),BC     ; 4:20      xdo(0,12) 126
xdo126:                 ;           xdo(0,12) 126 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx126 EQU $+1          ;[11:66/46] -3 +xloop 126   variant: step -3 and stop 0, 12.. -3 ..0
    ld   BC, 0x0000     ; 3:10      -3 +xloop 126   idx always points to a 16-bit index
    ld    A, B          ; 1:4       -3 +xloop 126   hi old index
    dec  BC             ; 1:6       -3 +xloop 126   index--
    dec  BC             ; 1:6       -3 +xloop 126   index--
    dec  BC             ; 1:6       -3 +xloop 126   index--
    sub   B             ; 1:4       -3 +xloop 126   old-new = carry if index: positive -> negative
    jp   nc, xdo126save ; 3:10      -3 +xloop 126   carry if postivie index -> negative index
xleave126:              ;           -3 +xloop 126
xexit126:               ;           -3 +xloop 126 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(0,350)  +XLOOP(-77) "
    ld   BC, size127    ; 3:10      print     Length of string127
    ld   DE, string127  ; 3:10      print     Address of string127
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 350        ; 3:10      xdo(0,350) 127
xdo127save:             ;           xdo(0,350) 127
    ld  (idx127),BC     ; 4:20      xdo(0,350) 127
xdo127:                 ;           xdo(0,350) 127 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[14:70/50] -77 +xloop 127   variant: negative step and stop 0, 350.. -77 ..0
idx127 EQU $+1          ;           -77 +xloop 127
    ld   BC, 0x0000     ; 3:10      -77 +xloop 127
    ld    A, C          ; 1:4       -77 +xloop 127
    sub  low 77         ; 2:7       -77 +xloop 127
    ld    C, A          ; 1:4       -77 +xloop 127
    ld    A, B          ; 1:4       -77 +xloop 127
    sbc   A, high 77    ; 2:7       -77 +xloop 127
    ld    B, A          ; 1:4       -77 +xloop 127
    jp   nc, xdo127save ; 3:10      -77 +xloop 127   carry if postivie index -> negative index
xleave127:              ;           -77 +xloop 127
xexit127:               ;           -77 +xloop 127 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print     "XDO(150,440)+XLOOP(-68) "
    ld   BC, size128    ; 3:10      print     Length of string128
    ld   DE, string128  ; 3:10      print     Address of string128
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 440        ; 3:10      xdo(150,440) 128
xdo128save:             ;           xdo(150,440) 128
    ld  (idx128),BC     ; 4:20      xdo(150,440) 128
xdo128:                 ;           xdo(150,440) 128 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[18:85/65] -68 +xloop 128   variant: negative step and real stop 0 <= 100 < 256, run 5x, 440.. -68 ..150
idx128 EQU $+1          ;           -68 +xloop 128
    ld   BC, 0x0000     ; 3:10      -68 +xloop 128
    ld    A, C          ; 1:4       -68 +xloop 128
    sub  low 68         ; 2:7       -68 +xloop 128
    ld    C, A          ; 1:4       -68 +xloop 128
    ld    A, B          ; 1:4       -68 +xloop 128
    sbc   A, high 68    ; 2:7       -68 +xloop 128
    ld    B, A          ; 1:4       -68 +xloop 128
    ld    A, C          ; 1:4       -68 +xloop 128   A = last_index
    xor  low 100        ; 2:7       -68 +xloop 128
    or    B             ; 1:4       -68 +xloop 128
    jp   nz, xdo128save ; 3:10      -68 +xloop 128
xleave128:              ;           -68 +xloop 128
xexit128:               ;           -68 +xloop 128 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- default -x

    push DE             ; 1:11      print     "XDO(-100,50)+XLOOP(-33) "
    ld   BC, size129    ; 3:10      print     Length of string129
    ld   DE, string129  ; 3:10      print     Address of string129
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 50         ; 3:10      xdo(-100,50) 129
xdo129save:             ;           xdo(-100,50) 129
    ld  (idx129),BC     ; 4:20      xdo(-100,50) 129
xdo129:                 ;           xdo(-100,50) 129 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
                        ;[23:81/82] -33 +xloop 129   variant: negative step and real stop 65421, run 5x, 50.. -33 ..-100
idx129 EQU $+1          ;           -33 +xloop 129
    ld   BC, 0x0000     ; 3:10      -33 +xloop 129
    ld    A, C          ; 1:4       -33 +xloop 129
    sub  low 33         ; 2:7       -33 +xloop 129
    ld    C, A          ; 1:4       -33 +xloop 129
    ld    A, B          ; 1:4       -33 +xloop 129
    sbc   A, high 33    ; 2:7       -33 +xloop 129
    ld    B, A          ; 1:4       -33 +xloop 129
    ld    A, C          ; 1:4       -33 +xloop 129
    xor  low 65421      ; 2:7       -33 +xloop 129
    jp   nz, xdo129save ; 3:10      -33 +xloop 129
    ld    A, B          ; 1:4       -33 +xloop 129
    xor  high 65421     ; 2:7       -33 +xloop 129
    jp   nz, xdo129save ; 3:10      -33 +xloop 129
xleave129:              ;           -33 +xloop 129
xexit129:               ;           -33 +xloop 129 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;---xxx---

Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====

STRING_SECTION:
string129:
db "XDO(-100,50)+XLOOP(-33) "
size129 EQU $ - string129
string128:
db "XDO(150,440)+XLOOP(-68) "
size128 EQU $ - string128
string127:
db "XDO(0,350)  +XLOOP(-77) "
size127 EQU $ - string127
string126:
db "XDO(0,12)   +XLOOP(-3) "
size126 EQU $ - string126
string125:
db "XDO(0,8)   +XLOOP(-2) "
size125 EQU $ - string125
string124:
db "XDO(1234,50)+XLOOP(260) "
size124 EQU $ - string124
string123:
db "XDO(1234,50)+XLOOP(250) "
size123 EQU $ - string123
string122:
db "XDO(0,-66)  +XLOOP(13) "
size122 EQU $ - string122
string121:
db "XDO(100,-444) +XLOOP(111) "
size121 EQU $ - string121
string120:
db "XDO(2500,25)+XLOOP(512) "
size120 EQU $ - string120
string119:
db "XDO(-14712,-14848) +XLOOP(29) "
size119 EQU $ - string119
string118:
db "XDO(123,25) +XLOOP(21) "
size118 EQU $ - string118
string117:
db "XDO(50,40)  +XLOOP(2) "
size117 EQU $ - string117
string116:
db "XDO(1,-10)  +XLOOP(2) "
size116 EQU $ - string116
string115:
db "XDO(0,-10)  +XLOOP(2) "
size115 EQU $ - string115
string114:
db "XDO(-7,-2)  +XLOOP(-1) "
size114 EQU $ - string114
string113:
db "XDO(50,55)  +XLOOP(-1) "
size113 EQU $ - string113
string112:
db "XDO(2,7)    +XLOOP(-1) "
size112 EQU $ - string112
string111:
db "XDO(1,6)    +XLOOP(-1) "
size111 EQU $ - string111
string110:
db "XDO(0,5)    +XLOOP(-1) "
size110 EQU $ - string110
string109:
db "XDO(-1,4)   +XLOOP(-1) "
size109 EQU $ - string109
string108:
db "XDO(257,-1) XLOOP "
size108 EQU $ - string108
string107:
db "XDO(-253,-258)     XLOOP "
size107 EQU $ - string107
string106:
db "XDO(513,507)       XLOOP "
size106 EQU $ - string106
string105:
db "XDO(0x6600,0x65FC) XLOOP "
size105 EQU $ - string105
string104:
db "XDO(0,-5)          XLOOP "
size104 EQU $ - string104
string103:
db "XDO(0x4055,0x4050) XLOOP "
size103 EQU $ - string103
string102:
db "XDO(0x3c0A,0x3c05) XLOOP "
size102 EQU $ - string102
string101:
db "XDO(10,5)          XLOOP "
size101 EQU $ - string101

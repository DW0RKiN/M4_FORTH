ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
;--- +1 ---
;       12345678901234567890123456789012

    ld   BC, string101  ; 3:10      print_i   Address of string101 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 251        ; 3:10      xdo(256,251) 101
xdo101save:             ;           xdo(256,251) 101
    ld  (idx101),BC     ; 4:20      xdo(256,251) 101
xdo101:                 ;           xdo(256,251) 101                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
                        ;[10:38]    xloop 101   variant +1.A: 0 <= index < stop == 256, run 5x
idx101 EQU $+1          ;           xloop 101   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 101   251.. +1 ..(256), real_stop:0x0100
    nop                 ; 1:4       xloop 101   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       xloop 101   index++
    ld  (idx101),A      ; 3:13      xloop 101
    jp   nz, xdo101     ; 3:10      xloop 101   index-stop
xleave101:              ;           xloop 101
xexit101:               ;           xloop 101 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string102  ; 3:10      print_i   Address of string102 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 241        ; 3:10      xdo(246,241) 102
xdo102save:             ;           xdo(246,241) 102
    ld  (idx102),BC     ; 4:20      xdo(246,241) 102
xdo102:                 ;           xdo(246,241) 102                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
                        ;[12:45]    xloop 102   variant +1.B: 0 <= index < stop <= 256, run 5x
idx102 EQU $+1          ;           xloop 102   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 102   241.. +1 ..(246), real_stop:0x00F6
    nop                 ; 1:4       xloop 102   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       xloop 102   index++
    ld  (idx102),A      ; 3:13      xloop 102
    xor  0xF6           ; 2:7       xloop 102   lo(real_stop)
    jp   nz, xdo102     ; 3:10      xloop 102   index-stop
xleave102:              ;           xloop 102
xexit102:               ;           xloop 102 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string103  ; 3:10      print_i   Address of string103 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 0x3CFB     ; 3:10      xdo(0x3D00,0x3CFB) 103
xdo103save:             ;           xdo(0x3D00,0x3CFB) 103
    ld  (idx103),BC     ; 4:20      xdo(0x3D00,0x3CFB) 103
xdo103:                 ;           xdo(0x3D00,0x3CFB) 103          
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
                        ;[9:34]     xloop 103   variant +1.C: 0x3C00 <=index < stop == 0x3D00, run 5x
idx103 EQU $+1          ;           xloop 103   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 103   0x3CFB.. +1 ..(0x3D00), real_stop:0x3D00
    inc   A             ; 1:4       xloop 103   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
    ld  (idx103),A      ; 3:13      xloop 103   save index
    jp   nz, xdo103     ; 3:10      xloop 103
xleave103:              ;           xloop 103
xexit103:               ;           xloop 103 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 0x3C05     ; 3:10      xdo(0x3C0A,0x3C05) 104
xdo104save:             ;           xdo(0x3C0A,0x3C05) 104
    ld  (idx104),BC     ; 4:20      xdo(0x3C0A,0x3C05) 104
xdo104:                 ;           xdo(0x3C0A,0x3C05) 104          
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
                        ;[11:41]    xloop 104   variant +1.D: 0x3C00 <=index < stop <= 0x3D00, run 5x
idx104 EQU $+1          ;           xloop 104   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 104   0x3C05.. +1 ..(0x3C0A), real_stop:0x3C0A
    inc   A             ; 1:4       xloop 104   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
    ld  (idx104),A      ; 3:13      xloop 104   save index
    xor  0x0A           ; 2:7       xloop 104   lo(real_stop)
    jp   nz, xdo104     ; 3:10      xloop 104
xleave104:              ;           xloop 104
xexit104:               ;           xloop 104 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string105  ; 3:10      print_i   Address of string105 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 0x65FB     ; 3:10      xdo(0x6600,0x65FB) 105
xdo105save:             ;           xdo(0x6600,0x65FB) 105
    ld  (idx105),BC     ; 4:20      xdo(0x6600,0x65FB) 105
xdo105:                 ;           xdo(0x6600,0x65FB) 105          
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
                        ;[11:41]    xloop 105   variant +1.E: 256*(1+hi(index)) == stop, run 5x
idx105 EQU $+1          ;           xloop 105   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 105   0x65FB.. +1 ..(0x6600), real_stop:0x6600
    ld    A, C          ; 1:4       xloop 105
    inc   A             ; 1:4       xloop 105   index++
    ld  (idx105),A      ; 3:13      xloop 105   save index
    jp   nz, xdo105     ; 3:10      xloop 105
xleave105:              ;           xloop 105
xexit105:               ;           xloop 105 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 0x4050     ; 3:10      xdo(0x4055,0x4050) 106
xdo106save:             ;           xdo(0x4055,0x4050) 106
    ld  (idx106),BC     ; 4:20      xdo(0x4055,0x4050) 106
xdo106:                 ;           xdo(0x4055,0x4050) 106          
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
                        ;[13:48]    xloop 106   variant +1.F: hi(index) == hi(stop-1) && index < stop, run 5x
idx106 EQU $+1          ;           xloop 106   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 106   0x4050.. +1 ..(0x4055), real_stop:0x4055
    ld    A, C          ; 1:4       xloop 106
    inc   A             ; 1:4       xloop 106   index++
    ld  (idx106),A      ; 3:13      xloop 106   save index
    xor  0x55           ; 2:7       xloop 106   lo(real_stop)
    jp   nz, xdo106     ; 3:10      xloop 106
xleave106:              ;           xloop 106
xexit106:               ;           xloop 106 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -5         ; 3:10      xdo(0,-5) 107
xdo107save:             ;           xdo(0,-5) 107
    ld  (idx107),BC     ; 4:20      xdo(0,-5) 107
xdo107:                 ;           xdo(0,-5) 107                   
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
                        ;[9:54/34]  xloop 107   variant +1.G: stop == 0, run 5x
idx107 EQU $+1          ;           xloop 107   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 107   -5.. +1 ..(0), real_stop:0x0000
    inc  BC             ; 1:6       xloop 107   index++
    ld    A, B          ; 1:4       xloop 107
    or    C             ; 1:4       xloop 107
    jp   nz, xdo107save ; 3:10      xloop 107
xleave107:              ;           xloop 107
xexit107:               ;           xloop 107 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string108  ; 3:10      print_i   Address of string108 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -3         ; 3:10      xdo(2,-3) 108
xdo108save:             ;           xdo(2,-3) 108
    ld  (idx108),BC     ; 4:20      xdo(2,-3) 108
xdo108:                 ;           xdo(2,-3) 108                   
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
                        ;[10:57/37] xloop 108   variant +1.H: step one with lo(real_stop) exclusivity, run 5x
idx108 EQU $+1          ;           xloop 108   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 108   -3.. +1 ..(2), real_stop:0x0002
    inc  BC             ; 1:6       xloop 108   index++
    ld    A, C          ; 1:4       xloop 108
    xor  0x02           ; 2:7       xloop 108   lo(real_stop)
    jp   nz, xdo108save ; 3:10      xloop 108
xleave108:              ;           xloop 108
xexit108:               ;           xloop 108 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 0x6318     ; 3:10      xdo(0x6700,0x6318) 109
xdo109save:             ;           xdo(0x6700,0x6318) 109
    ld  (idx109),BC     ; 4:20      xdo(0x6700,0x6318) 109
xdo109:                 ;           xdo(0x6700,0x6318) 109   
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(109) xi
    ex   DE, HL         ; 1:4       index(109) xi
    ld   HL, (idx109)   ; 3:16      index(109) xi   idx always points to a 16-bit index         
                        ;[10:57/37] xloop 109   variant +1.I: step one with hi(real_stop) exclusivity, run 1000x
idx109 EQU $+1          ;           xloop 109   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 109   0x6318.. +1 ..(0x6700), real_stop:0x6700
    inc  BC             ; 1:6       xloop 109   index++
    ld    A, B          ; 1:4       xloop 109
    xor  0x67           ; 2:7       xloop 109   hi(real_stop)
    jp   nz, xdo109save ; 3:10      xloop 109
xleave109:              ;           xloop 109
xexit109:               ;           xloop 109 
    call PRT_U16        ; 3:17      u.   ( u -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, -700       ; 3:10      xdo(300,-700) 110
xdo110save:             ;           xdo(300,-700) 110
    ld  (idx110),BC     ; 4:20      xdo(300,-700) 110
xdo110:                 ;           xdo(300,-700) 110      
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(110) xi
    ex   DE, HL         ; 1:4       index(110) xi
    ld   HL, (idx110)   ; 3:16      index(110) xi   idx always points to a 16-bit index         
                        ;[16:57/58] xloop 110   variant +1.default: step one, run 1000x
idx110 EQU $+1          ;           xloop 110   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 110   -700.. +1 ..(300), real_stop:0x012C
    inc  BC             ; 1:6       xloop 110   index++
    ld    A, C          ; 1:4       xloop 110
    xor  0x2C           ; 2:7       xloop 110   lo(real_stop) first (44>3)
    jp   nz, xdo110save ; 3:10      xloop 110   3x false positive
    ld    A, B          ; 1:4       xloop 110
    xor  0x01           ; 2:7       xloop 110   hi(real_stop)
    jp   nz, xdo110save ; 3:10      xloop 110   44x false positive if he was first
xleave110:              ;           xloop 110
xexit110:               ;           xloop 110 
    call PRT_U16        ; 3:17      u.   ( u -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- -1 ---

    ld   BC, string111  ; 3:10      print_i   Address of string111 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 4          ; 3:10      xdo(0,4) 111
xdo111save:             ;           xdo(0,4) 111
    ld  (idx111),BC     ; 4:20      xdo(0,4) 111
xdo111:                 ;           xdo(0,4) 111                    
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[9:54/34]  -1 +xloop 111   variant -1.A: step -1 and stop 0, run 5x
idx111 EQU $+1          ;           -1 +xloop 111   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 111   4.. -1 ..0, real_stop:0xFFFF
    ld    A, C          ; 1:4       -1 +xloop 111
    or    B             ; 1:4       -1 +xloop 111
    dec  BC             ; 1:6       -1 +xloop 111   index--
    jp   nz, xdo111save ; 3:10      -1 +xloop 111
xleave111:              ;           -1 +xloop 111
xexit111:               ;           xloop 111 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 5          ; 3:10      xdo(1,5) 112
xdo112save:             ;           xdo(1,5) 112
    ld  (idx112),BC     ; 4:20      xdo(1,5) 112
xdo112:                 ;           xdo(1,5) 112                    
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[9:54/34]  -1 +xloop 112   variant -1.B: step -1 and stop 1, run 5x
idx112 EQU $+1          ;           -1 +xloop 112   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 112   5.. -1 ..1, real_stop:0x0000
    dec  BC             ; 1:6       -1 +xloop 112   index--
    ld    A, C          ; 1:4       -1 +xloop 112
    or    B             ; 1:4       -1 +xloop 112
    jp   nz, xdo112save ; 3:10      -1 +xloop 112
xleave112:              ;           -1 +xloop 112
xexit112:               ;           xloop 112 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 258        ; 3:10      xdo(254,258) 113
xdo113save:             ;           xdo(254,258) 113
    ld  (idx113),BC     ; 4:20      xdo(254,258) 113
xdo113:                 ;           xdo(254,258) 113                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[10:57/37] -1 +xloop 113   variant -1.C: step -1 with lo(real_stop) exclusivity, run 5x
idx113 EQU $+1          ;           -1 +xloop 113   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 113   258.. -1 ..254, real_stop:0x00FD
    dec  BC             ; 1:6       -1 +xloop 113   index--
    ld    A, C          ; 1:4       -1 +xloop 113
    xor  0xFD           ; 2:7       -1 +xloop 113   lo(real_stop)
    jp   nz, xdo113save ; 3:10      -1 +xloop 113
xleave113:              ;           -1 +xloop 113
xexit113:               ;           xloop 113 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string114  ; 3:10      print_i   Address of string114 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i   
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 1255       ; 3:10      xdo(256,1255) 114
xdo114save:             ;           xdo(256,1255) 114
    ld  (idx114),BC     ; 4:20      xdo(256,1255) 114
xdo114:                 ;           xdo(256,1255) 114   
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(114) xi
    ex   DE, HL         ; 1:4       index(114) xi
    ld   HL, (idx114)   ; 3:16      index(114) xi   idx always points to a 16-bit index 
                        ;[10:57/37] -1 +xloop 114   variant -1.D: step -1 with hi(real_stop) exclusivity, run 1000x
idx114 EQU $+1          ;           -1 +xloop 114   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 114   1255.. -1 ..256, real_stop:0x00FF
    dec  BC             ; 1:6       -1 +xloop 114   index--
    ld    A, B          ; 1:4       -1 +xloop 114
    xor  0x00           ; 2:7       -1 +xloop 114   hi(real_stop)
    jp   nz, xdo114save ; 3:10      -1 +xloop 114
xleave114:              ;           -1 +xloop 114
xexit114:               ;           xloop 114 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i  
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 998        ; 3:10      xdo(-1,998) 115
xdo115save:             ;           xdo(-1,998) 115
    ld  (idx115),BC     ; 4:20      xdo(-1,998) 115
xdo115:                 ;           xdo(-1,998) 115      
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(115) xi
    ex   DE, HL         ; 1:4       index(115) xi
    ld   HL, (idx115)   ; 3:16      index(115) xi   idx always points to a 16-bit index 
                       ;[10:58/38]  -1 +xloop 115   variant -1.E: step -1 and stop -1, run 1000x
idx115 EQU $+1          ;           -1 +xloop 115   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 115   998.. -1 ..-1, real_stop:0xFFFE
    ld    A, C          ; 1:4       -1 +xloop 115
    and   B             ; 1:4       -1 +xloop 115   0xFF & 0xFF = 0xFF
    dec  BC             ; 1:6       -1 +xloop 115   index--
    inc   A             ; 1:4       -1 +xloop 115   0xFF + 1 = zero
    jp   nz, xdo115save ; 3:10      -1 +xloop 115
xleave115:              ;           -1 +xloop 115
xexit115:               ;           xloop 115 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 1001       ; 3:10      xdo(2,1001) 116
xdo116save:             ;           xdo(2,1001) 116
    ld  (idx116),BC     ; 4:20      xdo(2,1001) 116
xdo116:                 ;           xdo(2,1001) 116      
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(116) xi
    ex   DE, HL         ; 1:4       index(116) xi
    ld   HL, (idx116)   ; 3:16      index(116) xi   idx always points to a 16-bit index 
                        ;[10:58/38] -1 +xloop 116   variant -1.F: step -1 and stop 2, run 1000x
idx116 EQU $+1          ;           -1 +xloop 116   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 116   1001.. -1 ..2, real_stop:0x0001
    dec  BC             ; 1:6       -1 +xloop 116   index--
    ld    A, C          ; 1:4       -1 +xloop 116
    dec   A             ; 1:4       -1 +xloop 116
    or    B             ; 1:4       -1 +xloop 116
    jp   nz, xdo116save ; 3:10      -1 +xloop 116
xleave116:              ;           -1 +xloop 116
xexit116:               ;           xloop 116 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string117  ; 3:10      print_i   Address of string117 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i   
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 1199       ; 3:10      xdo(200,1199) 117
xdo117save:             ;           xdo(200,1199) 117
    ld  (idx117),BC     ; 4:20      xdo(200,1199) 117
xdo117:                 ;           xdo(200,1199) 117    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(117) xi
    ex   DE, HL         ; 1:4       index(117) xi
    ld   HL, (idx117)   ; 3:16      index(117) xi   idx always points to a 16-bit index 
                        ;[11:61/41] -1 +xloop 117   variant -1.G: step -1 and hi(real_stop) = 0, run 1000x
idx117 EQU $+1          ;           -1 +xloop 117   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 117   1199.. -1 ..200, real_stop:0x00C7
    dec  BC             ; 1:6       -1 +xloop 117   index--
    ld    A, C          ; 1:4       -1 +xloop 117
    xor  0xC7           ; 2:7       -1 +xloop 117   lo(real_stop)
    or    B             ; 1:4       -1 +xloop 117
    jp   nz, xdo117save ; 3:10      -1 +xloop 117
xleave117:              ;           -1 +xloop 117
xexit117:               ;           xloop 117 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i    
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 375        ; 3:10      xdo(-624,375) 118
xdo118save:             ;           xdo(-624,375) 118
    ld  (idx118),BC     ; 4:20      xdo(-624,375) 118
xdo118:                 ;           xdo(-624,375) 118    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(118) xi
    ex   DE, HL         ; 1:4       index(118) xi
    ld   HL, (idx118)   ; 3:16      index(118) xi   idx always points to a 16-bit index 
                        ;[16:57/58] -1 +xloop 118   variant -1.defaultA: step -1, LO first, run 1000x
idx118 EQU $+1          ;           -1 +xloop 118   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 118   375.. -1 ..-624, real_stop:0xFD8F
    dec  BC             ; 1:6       -1 +xloop 118   index--
    ld    A, C          ; 1:4       -1 +xloop 118
    xor  0x8F           ; 2:7       -1 +xloop 118   lo(real_stop)
    jp   nz, xdo118save ; 3:10      -1 +xloop 118   3x false positive
    ld    A, B          ; 1:4       -1 +xloop 118
    xor  0xFD           ; 2:7       -1 +xloop 118   hi(real_stop)
    jp   nz, xdo118save ; 3:10      -1 +xloop 118   112x false positive if he was first
xleave118:              ;           -1 +xloop 118
xexit118:               ;           xloop 118 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i    
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 486        ; 3:10      xdo(-513,486) 119
xdo119save:             ;           xdo(-513,486) 119
    ld  (idx119),BC     ; 4:20      xdo(-513,486) 119
xdo119:                 ;           xdo(-513,486) 119    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(119) xi
    ex   DE, HL         ; 1:4       index(119) xi
    ld   HL, (idx119)   ; 3:16      index(119) xi   idx always points to a 16-bit index 
                        ;[16:57/58] -1 +xloop 119   variant -1.defaultB: step -1, HI first, run 1000x
idx119 EQU $+1          ;           -1 +xloop 119   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +xloop 119   486.. -1 ..-513, real_stop:0xFDFE
    dec  BC             ; 1:6       -1 +xloop 119   index--
    ld    A, B          ; 1:4       -1 +xloop 119
    xor  0xFD           ; 2:7       -1 +xloop 119   hi(real_stop)
    jp   nz, xdo119save ; 3:10      -1 +xloop 119   1x false positive
    ld    A, C          ; 1:4       -1 +xloop 119
    xor  0xFE           ; 2:7       -1 +xloop 119   lo(real_stop)
    jp   nz, xdo119save ; 3:10      -1 +xloop 119   3x false positive if he was first
xleave119:              ;           -1 +xloop 119
xexit119:               ;           xloop 119 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- 2 ---

    ld   BC, string120  ; 3:10      print_i   Address of string120 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -10        ; 3:10      xdo(0,-10) 120
xdo120save:             ;           xdo(0,-10) 120
    ld  (idx120),BC     ; 4:20      xdo(0,-10) 120
xdo120:                 ;           xdo(0,-10) 120                  
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[10:58/38] 2 +xloop 120   variant +2.A: step 2 and real_stop is zero, run 5x
idx120 EQU $+1          ;           2 +xloop 120   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 120   -10.. +2 ..(0), real_stop:0x0000
    inc   C             ; 1:4       2 +xloop 120   index++
    inc  BC             ; 1:6       2 +xloop 120   index++
    ld    A, C          ; 1:4       2 +xloop 120
    or    B             ; 1:4       2 +xloop 120
    jp   nz, xdo120save ; 3:10      2 +xloop 120
xleave120:              ;           2 +xloop 120
xexit120:               ;           2 +xloop 120 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -9         ; 3:10      xdo(1,-9) 121
xdo121save:             ;           xdo(1,-9) 121
    ld  (idx121),BC     ; 4:20      xdo(1,-9) 121
xdo121:                 ;           xdo(1,-9) 121                   
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[10:58/38] 2 +xloop 121   variant +2.B: step 2 and real_stop is one, run 5x
idx121 EQU $+1          ;           2 +xloop 121   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 121   -9.. +2 ..(1), real_stop:0x0001
    inc  BC             ; 1:6       2 +xloop 121   index++
    ld    A, C          ; 1:4       2 +xloop 121
    inc   C             ; 1:4       2 +xloop 121   index++
    or    B             ; 1:4       2 +xloop 121
    jp   nz, xdo121save ; 3:10      2 +xloop 121
xleave121:              ;           2 +xloop 121
xexit121:               ;           2 +xloop 121 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string122  ; 3:10      print_i   Address of string122 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -5         ; 3:10      xdo(5,-5) 122
xdo122save:             ;           xdo(5,-5) 122
    ld  (idx122),BC     ; 4:20      xdo(5,-5) 122
xdo122:                 ;           xdo(5,-5) 122                   
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[11:61/41] 2 +xloop 122   variant +2.C: step 2 with lo(real_stop) exclusivity, run 5x
idx122 EQU $+1          ;           2 +xloop 122   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 122   -5.. +2 ..(5), real_stop:0x0005
    inc  BC             ; 1:6       2 +xloop 122   index++
    inc   C             ; 1:4       2 +xloop 122   index++
    ld    A, C          ; 1:4       2 +xloop 122
    xor  0x05           ; 2:7       2 +xloop 122   lo(real_stop)
    jp   nz, xdo122save ; 3:10      2 +xloop 122
xleave122:              ;           2 +xloop 122
xexit122:               ;           2 +xloop 122 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string123  ; 3:10      print_i   Address of string123 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i    
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 304        ; 3:10      xdo(2304,304) 123
xdo123save:             ;           xdo(2304,304) 123
    ld  (idx123),BC     ; 4:20      xdo(2304,304) 123
xdo123:                 ;           xdo(2304,304) 123    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(123) xi
    ex   DE, HL         ; 1:4       index(123) xi
    ld   HL, (idx123)   ; 3:16      index(123) xi   idx always points to a 16-bit index 
                        ;[11:61/41] 2 +xloop 123   variant +2.D: step 2 with hi(real_stop) exclusivity, run 1000x
idx123 EQU $+1          ;           2 +xloop 123   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 123   304.. +2 ..(2304), real_stop:0x0900
    inc   C             ; 1:4       2 +xloop 123   index++
    inc  BC             ; 1:6       2 +xloop 123   index++
    ld    A, B          ; 1:4       2 +xloop 123
    xor  0x09           ; 2:7       2 +xloop 123   hi(real_stop)
    jp   nz, xdo123save ; 3:10      2 +xloop 123
xleave123:              ;           2 +xloop 123
xexit123:               ;           2 +xloop 123 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string124  ; 3:10      print_i   Address of string124 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i    
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 50         ; 3:10      xdo(2050,50) 124
xdo124save:             ;           xdo(2050,50) 124
    ld  (idx124),BC     ; 4:20      xdo(2050,50) 124
xdo124:                 ;           xdo(2050,50) 124     
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(124) xi
    ex   DE, HL         ; 1:4       index(124) xi
    ld   HL, (idx124)   ; 3:16      index(124) xi   idx always points to a 16-bit index 
                        ;[17:61/62] 2 +xloop 124   variant +2.defaultA: positive step 2, run 1000x
idx124 EQU $+1          ;           2 +xloop 124   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 124   50.. +2 ..(2050), real_stop:0x0802
    inc   C             ; 1:4       2 +xloop 124   index++
    inc  BC             ; 1:6       2 +xloop 124   index++
    ld    A, B          ; 1:4       2 +xloop 124
    xor  0x08           ; 2:7       2 +xloop 124   hi(real_stop) first (1<=7)
    jp   nz, xdo124save ; 3:10      2 +xloop 124   1x false positive
    ld    A, C          ; 1:4       2 +xloop 124
    xor  0x02           ; 2:7       2 +xloop 124   lo(real_stop)
    jp   nz, xdo124save ; 3:10      2 +xloop 124   7x false positive if he was first
xleave124:              ;           2 +xloop 124
xexit124:               ;           2 +xloop 124 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string125  ; 3:10      print_i   Address of string125 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i    
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, -10        ; 3:10      xdo(1990,-10) 125
xdo125save:             ;           xdo(1990,-10) 125
    ld  (idx125),BC     ; 4:20      xdo(1990,-10) 125
xdo125:                 ;           xdo(1990,-10) 125    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(125) xi
    ex   DE, HL         ; 1:4       index(125) xi
    ld   HL, (idx125)   ; 3:16      index(125) xi   idx always points to a 16-bit index 
                        ;[17:61/62] 2 +xloop 125   variant +2.defaultB: positive step 2, run 1000x
idx125 EQU $+1          ;           2 +xloop 125   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 125   -10.. +2 ..(1990), real_stop:0x07C6
    inc   C             ; 1:4       2 +xloop 125   index++
    inc  BC             ; 1:6       2 +xloop 125   index++
    ld    A, C          ; 1:4       2 +xloop 125
    xor  0xC6           ; 2:7       2 +xloop 125   lo(real_stop) first (99>7)
    jp   nz, xdo125save ; 3:10      2 +xloop 125   7x false positive
    ld    A, B          ; 1:4       2 +xloop 125
    xor  0x07           ; 2:7       2 +xloop 125   hi(real_stop)
    jp   nz, xdo125save ; 3:10      2 +xloop 125   99x false positive if he was first
xleave125:              ;           2 +xloop 125
xexit125:               ;           2 +xloop 125 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- -2 ---

    ld   BC, string126  ; 3:10      print_i   Address of string126 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 8          ; 3:10      xdo(0,8) 126
xdo126save:             ;           xdo(0,8) 126
    ld  (idx126),BC     ; 4:20      xdo(0,8) 126
xdo126:                 ;           xdo(0,8) 126                    
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[10:58/38] -2 +xloop 126   variant -2.A: step -2 and real_stop is -2, run 5x
idx126 EQU $+1          ;           -2 +xloop 126   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 126   8.. -2 ..0, real_stop:0xFFFE
    ld    A, B          ; 1:4       -2 +xloop 126
    dec  BC             ; 1:6       -2 +xloop 126   index--
    dec   C             ; 1:4       -2 +xloop 126   index--
    sub   B             ; 1:4       -2 +xloop 126
    jp   nc, xdo126save ; 3:10      -2 +xloop 126
xleave126:              ;           -2 +xloop 126
xexit126:               ;           -2 +xloop 126 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string127  ; 3:10      print_i   Address of string127 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 9          ; 3:10      xdo(1,9) 127
xdo127save:             ;           xdo(1,9) 127
    ld  (idx127),BC     ; 4:20      xdo(1,9) 127
xdo127:                 ;           xdo(1,9) 127                    
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[10:58/38] -2 +xloop 127   variant -2.B: step -2 and real_stop is -1, run 5x
idx127 EQU $+1          ;           -2 +xloop 127   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 127   9.. -2 ..1, real_stop:0xFFFF
    dec   C             ; 1:4       -2 +xloop 127   index--
    ld    A, C          ; 1:4       -2 +xloop 127
    or    B             ; 1:4       -2 +xloop 127
    dec  BC             ; 1:6       -2 +xloop 127   index--
    jp   nz, xdo127save ; 3:10      -2 +xloop 127
xleave127:              ;           -2 +xloop 127
xexit127:               ;           -2 +xloop 127 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string128  ; 3:10      print_i   Address of string128 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 10         ; 3:10      xdo(2,10) 128
xdo128save:             ;           xdo(2,10) 128
    ld  (idx128),BC     ; 4:20      xdo(2,10) 128
xdo128:                 ;           xdo(2,10) 128                   
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[10:58/38] -2 +xloop 128   variant -2.C: step -2 and real_stop is zero, run 5x
idx128 EQU $+1          ;           -2 +xloop 128   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 128   10.. -2 ..2, real_stop:0x0000
    dec  BC             ; 1:6       -2 +xloop 128   index--
    dec   C             ; 1:4       -2 +xloop 128   index--
    ld    A, C          ; 1:4       -2 +xloop 128
    or    B             ; 1:4       -2 +xloop 128
    jp   nz, xdo128save ; 3:10      -2 +xloop 128
xleave128:              ;           -2 +xloop 128
xexit128:               ;           -2 +xloop 128 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string129  ; 3:10      print_i   Address of string129 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 264        ; 3:10      xdo(256,264) 129
xdo129save:             ;           xdo(256,264) 129
    ld  (idx129),BC     ; 4:20      xdo(256,264) 129
xdo129:                 ;           xdo(256,264) 129                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[11:61/41] -2 +xloop 129   variant -2.D: step -2 with hi(real_stop) exclusivity, run 5x
idx129 EQU $+1          ;           -2 +xloop 129   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 129   264.. -2 ..256, real_stop:0x00FE
    dec  BC             ; 1:6       -2 +xloop 129   index--
    dec   C             ; 1:4       -2 +xloop 129   index--
    ld    A, B          ; 1:4       -2 +xloop 129
    xor  0x00           ; 2:7       -2 +xloop 129   hi(real_stop)
    jp   nz, xdo129save ; 3:10      -2 +xloop 129
xleave129:              ;           -2 +xloop 129
xexit129:               ;           -2 +xloop 129 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string130  ; 3:10      print_i   Address of string130 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 308        ; 3:10      xdo(300,308) 130
xdo130save:             ;           xdo(300,308) 130
    ld  (idx130),BC     ; 4:20      xdo(300,308) 130
xdo130:                 ;           xdo(300,308) 130                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[11:61/41] -2 +xloop 130   variant -2.E: step -2 with lo(real_stop) exclusivity, run 5x
idx130 EQU $+1          ;           -2 +xloop 130   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 130   308.. -2 ..300, real_stop:0x012A
    dec  BC             ; 1:6       -2 +xloop 130   index--
    dec   C             ; 1:4       -2 +xloop 130   index--
    ld    A, C          ; 1:4       -2 +xloop 130
    xor  0x2A           ; 2:7       -2 +xloop 130   lo(real_stop)
    jp   nz, xdo130save ; 3:10      -2 +xloop 130
xleave130:              ;           -2 +xloop 130
xexit130:               ;           -2 +xloop 130 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string131  ; 3:10      print_i   Address of string131 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 2001       ; 3:10      xdo(3,2001) 131
xdo131save:             ;           xdo(3,2001) 131
    ld  (idx131),BC     ; 4:20      xdo(3,2001) 131
xdo131:                 ;           xdo(3,2001) 131      
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(131) xi
    ex   DE, HL         ; 1:4       index(131) xi
    ld   HL, (idx131)   ; 3:16      index(131) xi   idx always points to a 16-bit index 
                        ;[11:62/42] -2 +xloop 131   variant -2.F: step -2 and real_stop is one, run 1000x
idx131 EQU $+1          ;           -2 +xloop 131   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 131   2001.. -2 ..3, real_stop:0x0001
    dec   C             ; 1:4       -2 +xloop 131   index--
    dec  BC             ; 1:6       -2 +xloop 131   index--
    ld    A, C          ; 1:4       -2 +xloop 131
    dec   A             ; 1:4       -2 +xloop 131
    or    B             ; 1:4       -2 +xloop 131
    jp   nz, xdo131save ; 3:10      -2 +xloop 131
xleave131:              ;           -2 +xloop 131
xexit131:               ;           -2 +xloop 131 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string132  ; 3:10      print_i   Address of string132 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i   
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 2232       ; 3:10      xdo(234,2232) 132
xdo132save:             ;           xdo(234,2232) 132
    ld  (idx132),BC     ; 4:20      xdo(234,2232) 132
xdo132:                 ;           xdo(234,2232) 132    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(132) xi
    ex   DE, HL         ; 1:4       index(132) xi
    ld   HL, (idx132)   ; 3:16      index(132) xi   idx always points to a 16-bit index 
                        ;[12:65/45] -2 +xloop 132   variant -2.G: step -2 and real_stop 2..255, run 1000x
idx132 EQU $+1          ;           -2 +xloop 132   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 132   2232.. -2 ..234, real_stop:0x00E8
    dec  BC             ; 1:6       -2 +xloop 132   index--
    dec   C             ; 1:4       -2 +xloop 132   index--
    ld    A, C          ; 1:4       -2 +xloop 132
    xor  0xE8           ; 2:7       -2 +xloop 132   lo(real_stop)
    or    B             ; 1:4       -2 +xloop 132
    jp   nz, xdo132save ; 3:10      -2 +xloop 132
xleave132:              ;           -2 +xloop 132
xexit132:               ;           -2 +xloop 132 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string133  ; 3:10      print_i   Address of string133 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i     
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 196        ; 3:10      xdo(-1802,196) 133
xdo133save:             ;           xdo(-1802,196) 133
    ld  (idx133),BC     ; 4:20      xdo(-1802,196) 133
xdo133:                 ;           xdo(-1802,196) 133   
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(133) xi
    ex   DE, HL         ; 1:4       index(133) xi
    ld   HL, (idx133)   ; 3:16      index(133) xi   idx always points to a 16-bit index 
                        ;[17:61/62] -2 +xloop 133   variant -2.defaultA: positive step -2, run 1000x
idx133 EQU $+1          ;           -2 +xloop 133   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 133   196.. -2 ..-1802, real_stop:0xF8F4
    dec  BC             ; 1:6       -2 +xloop 133   index--
    dec   C             ; 1:4       -2 +xloop 133   index--
    ld    A, B          ; 1:4       -2 +xloop 133
    xor  0xF8           ; 2:7       -2 +xloop 133   hi(real_stop) first (5<=7)
    jp   nz, xdo133save ; 3:10      -2 +xloop 133   5x false positive
    ld    A, C          ; 1:4       -2 +xloop 133
    xor  0xF4           ; 2:7       -2 +xloop 133   lo(real_stop)
    jp   nz, xdo133save ; 3:10      -2 +xloop 133   7x false positive if he was first
xleave133:              ;           -2 +xloop 133
xexit133:               ;           -2 +xloop 133 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string134  ; 3:10      print_i   Address of string134 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i     
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 250        ; 3:10      xdo(-1748,250) 134
xdo134save:             ;           xdo(-1748,250) 134
    ld  (idx134),BC     ; 4:20      xdo(-1748,250) 134
xdo134:                 ;           xdo(-1748,250) 134   
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(134) xi
    ex   DE, HL         ; 1:4       index(134) xi
    ld   HL, (idx134)   ; 3:16      index(134) xi   idx always points to a 16-bit index 
                        ;[17:61/62] -2 +xloop 134   variant -2.defaultB: positive step -2, run 1000x
idx134 EQU $+1          ;           -2 +xloop 134   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +xloop 134   250.. -2 ..-1748, real_stop:0xF92A
    dec  BC             ; 1:6       -2 +xloop 134   index--
    dec   C             ; 1:4       -2 +xloop 134   index--
    ld    A, C          ; 1:4       -2 +xloop 134
    xor  0x2A           ; 2:7       -2 +xloop 134   lo(real_stop) first (106>7)
    jp   nz, xdo134save ; 3:10      -2 +xloop 134   7x false positive
    ld    A, B          ; 1:4       -2 +xloop 134
    xor  0xF9           ; 2:7       -2 +xloop 134   hi(real_stop)
    jp   nz, xdo134save ; 3:10      -2 +xloop 134   106x false positive if he was first
xleave134:              ;           -2 +xloop 134
xexit134:               ;           -2 +xloop 134 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- -x ---

    ld   BC, string135  ; 3:10      print_i   Address of string135 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 13         ; 3:10      xdo(0,13) 135
xdo135save:             ;           xdo(0,13) 135
    ld  (idx135),BC     ; 4:20      xdo(0,13) 135
xdo135:                 ;           xdo(0,13) 135                   
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[11:66/46] -3 +xloop 135   variant -X.A: step -3 and stop 0, run 5x
idx135 EQU $+1          ;           -3 +xloop 135   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -3 +xloop 135   13.. -3 ..0, real_stop:0xFFFE
    ld    A, B          ; 1:4       -3 +xloop 135   hi old index
    dec  BC             ; 1:6       -3 +xloop 135   index--
    dec  BC             ; 1:6       -3 +xloop 135   index--
    dec  BC             ; 1:6       -3 +xloop 135   index--
    sub   B             ; 1:4       -3 +xloop 135   old-new = carry if index: positive -> negative
    jp   nc, xdo135save ; 3:10      -3 +xloop 135   carry if postivie index -> negative index
xleave135:              ;           -3 +xloop 135
xexit135:               ;           -3 +xloop 135 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string136  ; 3:10      print_i   Address of string136 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 43         ; 3:10      xdo(0,43) 136
xdo136save:             ;           xdo(0,43) 136
    ld  (idx136),BC     ; 4:20      xdo(0,43) 136
xdo136:                 ;           xdo(0,43) 136                   
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[14:70/50] -10 +xloop 136   variant -X.B: negative step and stop 0, run 5x
idx136 EQU $+1          ;           -10 +xloop 136   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -10 +xloop 136   43.. -10 ..0, real_stop:0xFFF9
    ld    A, C          ; 1:4       -10 +xloop 136
    sub  low 10         ; 2:7       -10 +xloop 136
    ld    C, A          ; 1:4       -10 +xloop 136
    ld    A, B          ; 1:4       -10 +xloop 136
    sbc   A, high 10    ; 2:7       -10 +xloop 136
    ld    B, A          ; 1:4       -10 +xloop 136
    jp   nc, xdo136save ; 3:10      -10 +xloop 136   carry if postivie index -> negative index
xleave136:              ;           -10 +xloop 136
xexit136:               ;           -10 +xloop 136 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string137  ; 3:10      print_i   Address of string137 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 671        ; 3:10      xdo(510,671) 137
xdo137save:             ;           xdo(510,671) 137
    ld  (idx137),BC     ; 4:20      xdo(510,671) 137
xdo137:                 ;           xdo(510,671) 137                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  

                        ;[17:55/60] -33 +xloop 137   variant +X.C: negative step 3..255 and hi(real_stop) exclusivity, run 5x
idx137 EQU $+1          ;           -33 +xloop 137   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -33 +xloop 137   671.. -33 ..510, real_stop:0x01FA
    ld    A, C          ; 1:4       -33 +xloop 137
    sub  low 33         ; 2:7       -33 +xloop 137
    ld    C, A          ; 1:4       -33 +xloop 137
    jp   nc, xdo137save ; 3:10      -33 +xloop 137
    dec   B             ; 1:4       -33 +xloop 137
    ld    A, B          ; 1:4       -33 +xloop 137
    xor  0x01           ; 2:7       -33 +xloop 137   hi(real_stop)
    jp   nz, xdo137save ; 3:10      -33 +xloop 137
xleave137:              ;           -33 +xloop 137
xexit137:               ;           -33 +xloop 137 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string138  ; 3:10      print_i   Address of string138 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 50         ; 3:10      xdo(-1160,50) 138
xdo138save:             ;           xdo(-1160,50) 138
    ld  (idx138),BC     ; 4:20      xdo(-1160,50) 138
xdo138:                 ;           xdo(-1160,50) 138               
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  

                        ;[16:77/57] -300 +xloop 138   variant +X.D: negative step 256+ and hi(real_stop) exclusivity, run 5x
idx138 EQU $+1          ;           -300 +xloop 138   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -300 +xloop 138   50.. -300 ..-1160, real_stop:0xFA56
    ld    A, C          ; 1:4       -300 +xloop 138
    sub  low 300        ; 2:7       -300 +xloop 138
    ld    C, A          ; 1:4       -300 +xloop 138
    ld    A, B          ; 1:4       -300 +xloop 138
    sbc   A, high 300   ; 2:7       -300 +xloop 138
    ld    B, A          ; 1:4       -300 +xloop 138
    xor  0xFA           ; 2:7       -300 +xloop 138   hi(real_stop)
    jp   nz, xdo138save ; 3:10      -300 +xloop 138
xleave138:              ;           -300 +xloop 138
xexit138:               ;           -300 +xloop 138 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string139  ; 3:10      print_i   Address of string139 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i  
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 7027       ; 3:10      xdo(30,7027) 139
xdo139save:             ;           xdo(30,7027) 139
    ld  (idx139),BC     ; 4:20      xdo(30,7027) 139
xdo139:                 ;           xdo(30,7027) 139     
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(139) xi
    ex   DE, HL         ; 1:4       index(139) xi
    ld   HL, (idx139)   ; 3:16      index(139) xi   idx always points to a 16-bit index 
                        ;[20:70/71] -7 +xloop 139   variant -X.E: negative step and real_stop 0..255, run 1000x
idx139 EQU $+1          ;           -7 +xloop 139   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -7 +xloop 139   7027.. -7 ..30, real_stop:0x001B
    ld    A, C          ; 1:4       -7 +xloop 139
    sub  low 7          ; 2:7       -7 +xloop 139
    ld    C, A          ; 1:4       -7 +xloop 139
    ld    A, B          ; 1:4       -7 +xloop 139
    sbc   A, high 7     ; 2:7       -7 +xloop 139
    ld    B, A          ; 1:4       -7 +xloop 139
    jp   nz, xdo139save ; 3:10      -7 +xloop 139
    ld    A, C          ; 1:4       -7 +xloop 139   A = last_index
    xor  low 27         ; 2:7       -7 +xloop 139
    jp   nz, xdo139save ; 3:10      -7 +xloop 139
xleave139:              ;           -7 +xloop 139
xexit139:               ;           -7 +xloop 139 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string140  ; 3:10      print_i   Address of string140 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i   
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 6927       ; 3:10      xdo(-70,6927) 140
xdo140save:             ;           xdo(-70,6927) 140
    ld  (idx140),BC     ; 4:20      xdo(-70,6927) 140
xdo140:                 ;           xdo(-70,6927) 140    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(140) xi
    ex   DE, HL         ; 1:4       index(140) xi
    ld   HL, (idx140)   ; 3:16      index(140) xi   idx always points to a 16-bit index 
                        ;[23:81/82] -7 +xloop 140   variant -X.default: negative step, run 1000x
idx140 EQU $+1          ;           -7 +xloop 140   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -7 +xloop 140   6927.. -7 ..-70, real_stop:0xFFB7
    ld    A, C          ; 1:4       -7 +xloop 140
    sub  low 7          ; 2:7       -7 +xloop 140
    ld    C, A          ; 1:4       -7 +xloop 140
    ld    A, B          ; 1:4       -7 +xloop 140
    sbc   A, high 7     ; 2:7       -7 +xloop 140
    ld    B, A          ; 1:4       -7 +xloop 140
    ld    A, C          ; 1:4       -7 +xloop 140
    xor  0xB7           ; 2:7       -7 +xloop 140   lo(real_stop)
    jp   nz, xdo140save ; 3:10      -7 +xloop 140   3x
    ld    A, B          ; 1:4       -7 +xloop 140
    xor  0xFF           ; 2:7       -7 +xloop 140   hi(real_stop)
    jp   nz, xdo140save ; 3:10      -7 +xloop 140   10x
xleave140:              ;           -7 +xloop 140
xexit140:               ;           -7 +xloop 140 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;--- +x ---

    ld   BC, string141  ; 3:10      print_i   Address of string141 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 10         ; 3:10      xdo(25,10) 141
xdo141save:             ;           xdo(25,10) 141
    ld  (idx141),BC     ; 4:20      xdo(25,10) 141
xdo141:                 ;           xdo(25,10) 141                  
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[13:48]    3 +xloop 141   variant +X.A: positive step and 0 <= index < stop < 256, run 5x
idx141 EQU $+1          ;           3 +xloop 141   idx always points to a 16-bit index
    ld    A, 0x00       ; 2:7       3 +xloop 141   10.. +3 ..(25), real_stop:0x0019
    nop                 ; 1:4       3 +xloop 141   Contains a zero value because idx always points to a 16-bit index.
    add   A, low 3      ; 2:7       3 +xloop 141   A = index+step
    ld  (idx141), A     ; 3:13      3 +xloop 141   save new index
    xor  0x19           ; 2:7       3 +xloop 141   lo(real_stop)
    jp   nz, xdo141     ; 3:10      3 +xloop 141
xleave141:              ;           3 +xloop 141
xexit141:               ;           3 +xloop 141 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string142  ; 3:10      print_i   Address of string142 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 0xC601     ; 3:10      xdo(0xC610,0xC601) 142
xdo142save:             ;           xdo(0xC610,0xC601) 142
    ld  (idx142),BC     ; 4:20      xdo(0xC610,0xC601) 142
xdo142:                 ;           xdo(0xC610,0xC601) 142          
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[12:44]    3 +xloop 142   variant +X.B: positive step and 0xC600 <= index < stop < 0xC700, run 5x
idx142 EQU $+1          ;           3 +xloop 142   idx always points to a 16-bit index
    ld    A, 0x00       ; 2:7       3 +xloop 142   0xC601.. +3 ..(0xC610), real_stop:0xC610
    add   A, low 3      ; 2:7       3 +xloop 142   First byte contains a 0xC6 value because idx always points to a 16-bit index.
    ld  (idx142), A     ; 3:13      3 +xloop 142   save new index
    xor  0x10           ; 2:7       3 +xloop 142   lo(real_stop)
    jp   nz, xdo142     ; 3:10      3 +xloop 142
xleave142:              ;           3 +xloop 142
xexit142:               ;           3 +xloop 142 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string143  ; 3:10      print_i   Address of string143 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 25         ; 3:10      xdo(2500,25) 143
xdo143save:             ;           xdo(2500,25) 143
    ld  (idx143),BC     ; 4:20      xdo(2500,25) 143
xdo143:                 ;           xdo(2500,25) 143                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[14:51]    512 +xloop 143   variant +X.C: positive step = n*256, run 5x
idx143 EQU $+1          ;           512 +xloop 143   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      512 +xloop 143   25.. +512 ..(2500), real_stop:0x0A19
    ld    A, B          ; 1:4       512 +xloop 143
    add   A, 0x02       ; 2:7       512 +xloop 143   hi(step)
    ld  (idx143+1),A    ; 3:13      512 +xloop 143   save index
    xor  0x0A           ; 2:7       512 +xloop 143   hi(real_stop)
    jp   nz, xdo143     ; 3:10      512 +xloop 143
xleave143:              ;           512 +xloop 143
xexit143:               ;           512 +xloop 143 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string144  ; 3:10      print_i   Address of string144 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -15        ; 3:10      xdo(0,-15) 144
xdo144save:             ;           xdo(0,-15) 144
    ld  (idx144),BC     ; 4:20      xdo(0,-15) 144
xdo144:                 ;           xdo(0,-15) 144                  
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[14:55/49] 3 +xloop 144   variant +X.D: positive step 3..255 and stop 0, run 5x
idx144 EQU $+1          ;           3 +xloop 144   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      3 +xloop 144   -15.. +3 ..(0), real_stop:0x0000
    ld    A, C          ; 1:4       3 +xloop 144
    add   A, low 3      ; 2:7       3 +xloop 144
    ld    C, A          ; 1:4       3 +xloop 144
    jp   nc, xdo144save ; 3:10      3 +xloop 144
    inc   B             ; 1:4       3 +xloop 144
    jp   nc, xdo144save ; 3:10      3 +xloop 144
xleave144:              ;           3 +xloop 144
xexit144:               ;           3 +xloop 144 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string145  ; 3:10      print_i   Address of string145 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -29        ; 3:10      xdo(5,-29) 145
xdo145save:             ;           xdo(5,-29) 145
    ld  (idx145),BC     ; 4:20      xdo(5,-29) 145
xdo145:                 ;           xdo(5,-29) 145                  
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[14:55/49] 7 +xloop 145   variant +X.E: positive step 3..255 and hi(real_stop) = exclusivity zero, run 5x
idx145 EQU $+1          ;           7 +xloop 145   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      7 +xloop 145   -29.. +7 ..(5), real_stop:0x0006
    ld    A, C          ; 1:4       7 +xloop 145
    add   A, low 7      ; 2:7       7 +xloop 145
    ld    C, A          ; 1:4       7 +xloop 145
    jp   nc, xdo145save ; 3:10      7 +xloop 145
    inc   B             ; 1:4       7 +xloop 145
    jp   nz, xdo145save ; 3:10      7 +xloop 145
xleave145:              ;           7 +xloop 145
xexit145:               ;           7 +xloop 145 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string146  ; 3:10      print_i   Address of string146 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 227        ; 3:10      xdo(260,227) 146
xdo146save:             ;           xdo(260,227) 146
    ld  (idx146),BC     ; 4:20      xdo(260,227) 146
xdo146:                 ;           xdo(260,227) 146                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[17:55/60] 7 +xloop 146   variant +X.F: positive step 3..255 and hi(real_stop) exclusivity, run 5x
idx146 EQU $+1          ;           7 +xloop 146   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      7 +xloop 146   227.. +7 ..(260), real_stop:0x0106
    ld    A, C          ; 1:4       7 +xloop 146
    add   A, low 7      ; 2:7       7 +xloop 146
    ld    C, A          ; 1:4       7 +xloop 146
    jp   nc, xdo146save ; 3:10      7 +xloop 146
    inc   B             ; 1:4       7 +xloop 146
    ld    A, B          ; 1:4       7 +xloop 146
    xor  0x01           ; 2:7       7 +xloop 146   hi(real_stop)
    jp   nz, xdo146save ; 3:10      7 +xloop 146
xleave146:              ;           7 +xloop 146
xexit146:               ;           7 +xloop 146 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string147  ; 3:10      print_i   Address of string147 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -23        ; 3:10      xdo(10,-23) 147
xdo147save:             ;           xdo(10,-23) 147
    ld  (idx147),BC     ; 4:20      xdo(10,-23) 147
xdo147:                 ;           xdo(10,-23) 147                 
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[19:67/68] 7 +xloop 147   variant +X.G: positive step 3..255 and real_stop 0..255, run 5x
idx147 EQU $+1          ;           7 +xloop 147   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      7 +xloop 147   -23.. +7 ..(10), real_stop:0x000C
    ld    A, C          ; 1:4       7 +xloop 147
    add   A, low 7      ; 2:7       7 +xloop 147
    ld    C, A          ; 1:4       7 +xloop 147
    adc   A, B          ; 1:4       7 +xloop 147
    sub   C             ; 1:4       7 +xloop 147
    ld    B, A          ; 1:4       7 +xloop 147
    jp   nz, xdo147save ; 3:10      7 +xloop 147
    ld    A, C          ; 1:4       7 +xloop 147
    xor  0x0C           ; 2:7       7 +xloop 147   lo(real_stop)
    jp   nz, xdo147save ; 3:10      7 +xloop 147
xleave147:              ;           7 +xloop 147
xexit147:               ;           7 +xloop 147 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string148  ; 3:10      print_i   Address of string148 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, -1485      ; 3:10      xdo(230,-1485) 148
xdo148save:             ;           xdo(230,-1485) 148
    ld  (idx148),BC     ; 4:20      xdo(230,-1485) 148
xdo148:                 ;           xdo(230,-1485) 148              
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[14:70/50] 345 +xloop 148   variant +X.H: positive step 256+ and hi(real_stop) exclusivity zero, run 5x
idx148 EQU $+1          ;           345 +xloop 148   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      345 +xloop 148   -1485.. +345 ..(230), real_stop:0x00F0
    ld    A, C          ; 1:4       345 +xloop 148
    add   A, low 345    ; 2:7       345 +xloop 148
    ld    C, A          ; 1:4       345 +xloop 148
    ld    A, B          ; 1:4       345 +xloop 148
    adc   A, high 345   ; 2:7       345 +xloop 148
    ld    B, A          ; 1:4       345 +xloop 148
    jp   nz, xdo148save ; 3:10      345 +xloop 148
xleave148:              ;           345 +xloop 148
xexit148:               ;           345 +xloop 148 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string149  ; 3:10      print_i   Address of string149 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i    
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 516        ; 3:10      xdo(4516,516) 149
xdo149save:             ;           xdo(4516,516) 149
    ld  (idx149),BC     ; 4:20      xdo(4516,516) 149
xdo149:                 ;           xdo(4516,516) 149    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(149) xi
    ex   DE, HL         ; 1:4       index(149) xi
    ld   HL, (idx149)   ; 3:16      index(149) xi   idx always points to a 16-bit index 
                        ;[21:74/75] 4 +xloop 149   variant +X.I: positive step 3..255, hi(real_stop) has fewer duplicate,run 1000x
idx149 EQU $+1          ;           4 +xloop 149   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      4 +xloop 149   516.. +4 ..(4516), real_stop:0x11A4
    ld    A, C          ; 1:4       4 +xloop 149
    add   A, low 4      ; 2:7       4 +xloop 149
    ld    C, A          ; 1:4       4 +xloop 149
    adc   A, B          ; 1:4       4 +xloop 149
    sub   C             ; 1:4       4 +xloop 149
    ld    B, A          ; 1:4       4 +xloop 149
    xor  0x11           ; 2:7       4 +xloop 149   hi(real_stop) first (21*41<=4*1000+21*15)
    jp   nz, xdo149save ; 3:10      4 +xloop 149   41x false positive
    ld    A, C          ; 1:4       4 +xloop 149
    xor  0xA4           ; 2:7       4 +xloop 149   lo(real_stop)
    jp   nz, xdo149save ; 3:10      4 +xloop 149   15x false positive if he was first
xleave149:              ;           4 +xloop 149
xexit149:               ;           4 +xloop 149 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string150  ; 3:10      print_i   Address of string150 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 33         ; 3:10      xdo(1234,33) 150
xdo150save:             ;           xdo(1234,33) 150
    ld  (idx150),BC     ; 4:20      xdo(1234,33) 150
xdo150:                 ;           xdo(1234,33) 150                
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[16:77/57] 300 +xloop 150   variant +X.J: positive step 256+ and hi(real_stop) exclusivity, run 5x
idx150 EQU $+1          ;           300 +xloop 150   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      300 +xloop 150   33.. +300 ..(1234), real_stop:0x05FD
    ld    A, C          ; 1:4       300 +xloop 150
    add   A, low 300    ; 2:7       300 +xloop 150
    ld    C, A          ; 1:4       300 +xloop 150
    ld    A, B          ; 1:4       300 +xloop 150
    adc   A, high 300   ; 2:7       300 +xloop 150
    ld    B, A          ; 1:4       300 +xloop 150
    xor  0x05           ; 2:7       300 +xloop 150   hi(real_stop)
    jp   nz, xdo150save ; 3:10      300 +xloop 150
xleave150:              ;           300 +xloop 150
xexit150:               ;           300 +xloop 150 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string151  ; 3:10      print_i   Address of string151 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    ld   BC, 1019       ; 3:10      xdo(1034,1019) 151
xdo151save:             ;           xdo(1034,1019) 151
    ld  (idx151),BC     ; 4:20      xdo(1034,1019) 151
xdo151:                 ;           xdo(1034,1019) 151              
    ld    A, '.'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
                        ;[16:78/58] 3 +xloop 151   variant +X.K : positive step 3..255 and lo(real_stop) exclusivity, run 5x
idx151 EQU $+1          ;           3 +xloop 151   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      3 +xloop 151   1019.. +3 ..(1034), real_stop:0x040A
    ld    A, C          ; 1:4       3 +xloop 151
    add   A, low 3      ; 2:7       3 +xloop 151
    ld    C, A          ; 1:4       3 +xloop 151
    adc   A, B          ; 1:4       3 +xloop 151
    sub   C             ; 1:4       3 +xloop 151
    ld    B, A          ; 1:4       3 +xloop 151
    ld    A, C          ; 1:4       3 +xloop 151
    xor  0x0A           ; 2:7       3 +xloop 151   lo(real_stop)
    jp   nz, xdo151save ; 3:10      3 +xloop 151
xleave151:              ;           3 +xloop 151
xexit151:               ;           3 +xloop 151 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string152  ; 3:10      print_i   Address of string152 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i   
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0) 
    ld   BC, 100        ; 3:10      xdo(500,100) 152
xdo152save:             ;           xdo(500,100) 152
    ld  (idx152),BC     ; 4:20      xdo(500,100) 152
xdo152:                 ;           xdo(500,100) 152     
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      index(152) xi
    ex   DE, HL         ; 1:4       index(152) xi
    ld   HL, (idx152)   ; 3:16      index(152) xi   idx always points to a 16-bit index 
                        ;[22:78/79] 4 +xloop 152   variant +X.L: positive step 3..255, lo(real_stop) has fewer duplicate, run 100x
idx152 EQU $+1          ;           4 +xloop 152   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      4 +xloop 152   100.. +4 ..(500), real_stop:0x01F4
    ld    A, C          ; 1:4       4 +xloop 152
    add   A, low 4      ; 2:7       4 +xloop 152
    ld    C, A          ; 1:4       4 +xloop 152
    adc   A, B          ; 1:4       4 +xloop 152
    sub   C             ; 1:4       4 +xloop 152
    ld    B, A          ; 1:4       4 +xloop 152
    ld    A, C          ; 1:4       4 +xloop 152
    xor  0xF4           ; 2:7       4 +xloop 152   lo(real_stop) first (21*61>4*100+21*1)
    jp   nz, xdo152save ; 3:10      4 +xloop 152   1x false positive
    ld    A, B          ; 1:4       4 +xloop 152
    xor  0x01           ; 2:7       4 +xloop 152   hi(real_stop)
    jp   nz, xdo152save ; 3:10      4 +xloop 152   61x false positive if he was first
xleave152:              ;           4 +xloop 152
xexit152:               ;           4 +xloop 152 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
;---xxx---

Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====

;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_S16:                ;           prt_s16
    ld    A, H          ; 1:4       prt_s16
    add   A, A          ; 1:4       prt_s16
    jr   nc, PRT_U16    ; 2:7/12    prt_s16
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_s16   putchar(reg A) with ZX 48K ROM
    xor   A             ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    L, A          ; 1:4       prt_s16   neg
    sbc   A, H          ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    H, A          ; 1:4       prt_s16   neg
    jr   PRT_U16        ; 2:12      prt_s16
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_U16:             ;           prt_sp_u16
    ld    A, ' '        ; 2:7       prt_sp_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_sp_u16   putchar with ZX 48K ROM in, this will print char in A
    ; fall to prt_u16
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_U16:                ;           prt_u16
    xor   A             ; 1:4       prt_u16   HL=103 & A=0 => 103, HL = 103 & A='0' => 00103
    ld   BC, -10000     ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld   BC, -1000      ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld   BC, -100       ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld    C, -10        ; 2:7       prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld    A, L          ; 1:4       prt_u16
    pop  HL             ; 1:10      prt_u16   load ret
    ex  (SP),HL         ; 1:19      prt_u16
    ex   DE, HL         ; 1:4       prt_u16
    jr   BIN16_DEC_CHAR ; 2:12      prt_u16
;------------------------------------------------------------------------------
; Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
    inc   A             ; 1:4       bin16_dec
BIN16_DEC:              ;           bin16_dec
    add  HL, BC         ; 1:11      bin16_dec
    jr    c, $-2        ; 2:7/12    bin16_dec
    sbc  HL, BC         ; 2:15      bin16_dec
    or    A             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
BIN16_DEC_CHAR:         ;           bin16_dec
    or   '0'            ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
;==============================================================================
; Print string ending with inverted most significant bit
; In: BC = addr string_imsb
; Out: BC = addr last_char + 1
PRINT_STRING_I:         ;           print_string_i
    ld    A,(BC)        ; 1:7       print_string_i
    and  0x7f           ; 2:7       print_string_i
    rst  0x10           ; 1:11      print_string_i putchar with ZX 48K ROM in, this will print char in A
    ld    A,(BC)        ; 1:7       print_string_i
    add   A, A          ; 1:4       print_string_i
    inc  BC             ; 1:6       print_string_i
    jp   nc, $-7        ; 3:10      print_string_i
    ret                 ; 1:10      print_string_i

STRING_SECTION:
string152:
db "+X.L 4  100..(500)  "," "+0x80
size152 EQU $ - string152
string151:
db "+X.K 3 1019..(1034)   "," "+0x80
size151 EQU $ - string151
string150:
db "+X.J 300 33..1234     "," "+0x80
size150 EQU $ - string150
string149:
db "+X.I 4  516..(4516)"," "+0x80
size149 EQU $ - string149
string148:
db "+X.H 345 -1485..(230) "," "+0x80
size148 EQU $ - string148
string147:
db "+X.G 7  -23..(10)     "," "+0x80
size147 EQU $ - string147
string146:
db "+X.F 7  227..(260)    "," "+0x80
size146 EQU $ - string146
string145:
db "+X.E 7  -29..(5)      "," "+0x80
size145 EQU $ - string145
string144:
db "+X.D 3  -15..(0)      "," "+0x80
size144 EQU $ - string144
string143:
db "+X.C 512 25..(2500)   "," "+0x80
size143 EQU $ - string143
string142:
db "+X.B 3 0xC601..(0xC610",")"+0x80
size142 EQU $ - string142
string141:
db "+X.A 3   10..(25)     "," "+0x80
size141 EQU $ - string141
string140:
db "-X.def -7 6927..-70 "," "+0x80
size140 EQU $ - string140
string139:
db "-X.E -7   7027..30   "," "+0x80
size139 EQU $ - string139
string138:
db "-X.D -300 50..-1160   "," "+0x80
size138 EQU $ - string138
string137:
db "-X.C -33 671..510     "," "+0x80
size137 EQU $ - string137
string136:
db "-X.B -10  43..0       "," "+0x80
size136 EQU $ - string136
string135:
db "-X.A -3   13..0       "," "+0x80
size135 EQU $ - string135
string134:
db "-2.defB  250..-1748"," "+0x80
size134 EQU $ - string134
string133:
db "-2.defA  196..-1802"," "+0x80
size133 EQU $ - string133
string132:
db "-2.G    2232..234   "," "+0x80
size132 EQU $ - string132
string131:
db "-2.F    2001..3       "," "+0x80
size131 EQU $ - string131
string130:
db "-2.E     308..300     "," "+0x80
size130 EQU $ - string130
string129:
db "-2.D     264..256     "," "+0x80
size129 EQU $ - string129
string128:
db "-2.C      10..2       "," "+0x80
size128 EQU $ - string128
string127:
db "-2.B       9..1       "," "+0x80
size127 EQU $ - string127
string126:
db "-2.A       8..0       "," "+0x80
size126 EQU $ - string126
string125:
db "+2.defB -10..(1990)"," "+0x80
size125 EQU $ - string125
string124:
db "+2.defA  50..(2050)"," "+0x80
size124 EQU $ - string124
string123:
db "+2.D    304..(2304)"," "+0x80
size123 EQU $ - string123
string122:
db "+2.C     -5..(5)      "," "+0x80
size122 EQU $ - string122
string121:
db "+2.B     -9..(1)      "," "+0x80
size121 EQU $ - string121
string120:
db "+2.A    -10..(0)      "," "+0x80
size120 EQU $ - string120
string119:
db "-1.defB 486..-513  "," "+0x80
size119 EQU $ - string119
string118:
db "-1.defA 375..-624  "," "+0x80
size118 EQU $ - string118
string117:
db "-1.G   1199..200    "," "+0x80
size117 EQU $ - string117
string116:
db "-1.F   1001..2        "," "+0x80
size116 EQU $ - string116
string115:
db "-1.E    998..-1      "," "+0x80
size115 EQU $ - string115
string114:
db "-1.D   1255..256    "," "+0x80
size114 EQU $ - string114
string113:
db "-1.C    258..254      "," "+0x80
size113 EQU $ - string113
string112:
db "-1.B      5..1        "," "+0x80
size112 EQU $ - string112
string111:
db "-1.A      4..0        "," "+0x80
size111 EQU $ - string111
string110:
db "+1.def -700..(300)  "," "+0x80
size110 EQU $ - string110
string109:
db "+1.I 6318h..(26368",")"+0x80
size109 EQU $ - string109
string108:
db "+1.H     -3..(2)      "," "+0x80
size108 EQU $ - string108
string107:
db "+1.G     -5..(0)      "," "+0x80
size107 EQU $ - string107
string106:
db "+1.F 0x4050..(0x4055) "," "+0x80
size106 EQU $ - string106
string105:
db "+1.E 0x65FB..(0x6600) "," "+0x80
size105 EQU $ - string105
string104:
db "+1.D 0x3C05..(0x3C0A) "," "+0x80
size104 EQU $ - string104
string103:
db "+1.C 0x3CFB..(0x3D00) "," "+0x80
size103 EQU $ - string103
string102:
db "+1.B    241..(246)    "," "+0x80
size102 EQU $ - string102
string101:
db "+1.A    251..(256)    "," "+0x80
size101 EQU $ - string101

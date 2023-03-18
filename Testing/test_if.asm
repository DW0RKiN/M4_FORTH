; vvvvv
; ^^^^^
    
    ORG 0x8000
    

    
     
     
     
     
    
      
      
      
      
    
     
     
     
     

      
       
    
    

    ; signed
         
       
        
         
       
        
         
       
        
         
       
        
         
       
        
         
       
        
          
    ; unsigned
        
      
       
        
      
       
        
      
       
        
      
       
        
      
       
        
      
       
       



    ;# signed
         
       
        
         
       
        
         
       
        
         
       
        
         
       
        
         
       
        
        
    ;# unsigned
        
      
       
        
      
       
        
      
       
        
      
       
        
      
       
        
      
       
       




      
      
      
      
      
      
         
      
      
      
      
      
      
       




      
      
      
      
      
      
         
      
      
      
      
      
      
       


;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
  if 0
    ld   HL, 0x0000     ; 3:10      init
    ld (self_cursor),HL ; 3:16      init
  else
    ld   HL, 0x1821     ; 3:10      init
    ld   DE,(0x5C88)    ; 4:20      init
    or    A             ; 1:4       init
    sbc  HL, DE         ; 2:15      init
    ld    A, L          ; 1:4       init   x
    add   A, A          ; 1:4       init   2*x
    inc   A             ; 1:4       init   2*2+1
    add   A, A          ; 1:4       init   4*x+2
    add   A, A          ; 1:4       init   8*x+4
     ld   L, 0xFF       ; 2:7       init
    inc   L             ; 1:4       init
    sub 0x05            ; 2:7       init
    jr   nc, $-3        ; 2:7/12    init
    ld (self_cursor),HL ; 3:16      init
  endif
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    ld   BC, string101  ; 3:10      print_i   Address of string101 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[8:42]     5 -5   ( -- 5 -5 )
    push DE             ; 1:11      5 -5
    push HL             ; 1:11      5 -5
    ld   DE, 0x0005     ; 3:10      5 -5
    ld   HL, 0xFFFB     ; 3:10      5 -5
    call x_x_test       ; 3:17      call ( -- )
                        ;[7:40]     5 5   ( -- 5 5 )
    push DE             ; 1:11      5 5
    push HL             ; 1:11      5 5
    ld   DE, 0x0005     ; 3:10      5 5
    ld    H, D          ; 1:4       5 5   H = D = 0x00
    ld    L, E          ; 1:4       5 5   L = E = 0x05
    call x_x_test       ; 3:17      call ( -- )
                        ;[7:40]     -5 -5   ( -- -5 -5 )
    push DE             ; 1:11      -5 -5
    push HL             ; 1:11      -5 -5
    ld   DE, 0xFFFB     ; 3:10      -5 -5
    ld    H, D          ; 1:4       -5 -5   H = D = 0xFF
    ld    L, E          ; 1:4       -5 -5   L = E = 0xFB
    call x_x_test       ; 3:17      call ( -- )
                        ;[8:42]     -5 5   ( -- -5 5 )
    push DE             ; 1:11      -5 5
    push HL             ; 1:11      -5 5
    ld   DE, 0xFFFB     ; 3:10      -5 5
    ld   HL, 0x0005     ; 3:10      -5 5
    call x_x_test       ; 3:17      call ( -- )
    ld   BC, string102  ; 3:10      print_i   Address of string102 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    push DE             ; 1:11      5. -5.
    push HL             ; 1:11      5. -5.
    ld   DE, 0x0000     ; 3:10      5. -5.
    push DE             ; 1:11      5. -5.
    ld    E, 0x05       ; 2:7       5. -5.
    push DE             ; 1:11      5. -5.
    dec   D             ; 1:4       5. -5.
    ld    E, D          ; 1:4       5. -5.   E = D = 0xFF
    ld   HL, 0xFFFB     ; 3:10      5. -5.
    call d_d_test       ; 3:17      call ( -- )
    push DE             ; 1:11      5. 5.
    push HL             ; 1:11      5. 5.
    ld   HL, 0x0005     ; 3:10      5. 5.
    ld    E, H          ; 1:4       5. 5.   E = H = 0x00
    ld    D, E          ; 1:4       5. 5.   D = E = 0x00
    push DE             ; 1:11      5. 5.
    push HL             ; 1:11      5. 5.
    call d_d_test       ; 3:17      call ( -- )
    push DE             ; 1:11      -5. -5.
    push HL             ; 1:11      -5. -5.
    ld   HL, 0xFFFB     ; 3:10      -5. -5.
    ld    E, H          ; 1:4       -5. -5.   E = H = 0xFF
    ld    D, E          ; 1:4       -5. -5.   D = E = 0xFF
    push DE             ; 1:11      -5. -5.
    push HL             ; 1:11      -5. -5.
    call d_d_test       ; 3:17      call ( -- )
    push DE             ; 1:11      -5. 5.
    push HL             ; 1:11      -5. 5.
    ld   DE, 0xFFFF     ; 3:10      -5. 5.
    push DE             ; 1:11      -5. 5.
    ld    E, 0xFB       ; 2:7       -5. 5.
    push DE             ; 1:11      -5. 5.
    inc   D             ; 1:4       -5. 5.
    ld    E, D          ; 1:4       -5. 5.   E = D = 0x00
    ld   HL, 0x0005     ; 3:10      -5. 5.
    call d_d_test       ; 3:17      call ( -- )
    push DE             ; 1:11      3
    ex   DE, HL         ; 1:4       3
    ld   HL, 3          ; 3:10      3
    call x_p3_test      ; 3:17      call ( -- )
    push DE             ; 1:11      -3
    ex   DE, HL         ; 1:4       -3
    ld   HL, 0-3        ; 3:10      -3
    call x_p3_test      ; 3:17      call ( -- )
    push DE             ; 1:11      3
    ex   DE, HL         ; 1:4       3
    ld   HL, 3          ; 3:10      3
    call x_m3_test      ; 3:17      call ( -- )
    push DE             ; 1:11      -3
    ex   DE, HL         ; 1:4       -3
    ld   HL, 0-3        ; 3:10      -3
    call x_m3_test      ; 3:17      call ( -- )
    ld   BC, string103  ; 3:10      print_i   Address of string103 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    srl   H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth
    call PRT_S16        ; 3:17      .   ( s -- )
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ex   DE, HL         ; 1:4       ras   ( -- return_address_stack )
    exx                 ; 1:4       ras
    push HL             ; 1:11      ras
    exx                 ; 1:4       ras
    ex  (SP),HL         ; 1:19      ras
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
  if 0
    ld    A, 0x16       ; 2:7       stop   at y x
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
    ld A,(self_cursor+1); 3:13      stop
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
    xor   A             ; 1:4       stop
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
  else
    ld   HL,(self_cursor); 3:16
    ld    A, 0x16       ; 2:7       stop   at y x
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
    ld    A, H          ; 1:4       stop
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
    ld    A, L          ; 1:4       stop
    add   A, A          ; 1:4       stop   2x
    add   A, A          ; 1:4       stop   4x
    add   A, L          ; 1:4       stop   5x
    add   A, 0x07       ; 1:4       stop
    rrca                ; 1:4       stop
    rrca                ; 1:4       stop
    rrca                ; 1:4       stop
    and   0x1F          ; 2:7       stop
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
  endif
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
x_x_test:               ;           
    pop  BC             ; 1:10      : ret
    ld  (x_x_test_end+1),BC; 4:20      : ( ret -- )
    push DE             ; 1:11      2dup =
    push HL             ; 1:11      2dup =   ( b a -- b a b a )
                        ;[9:48/49]  2dup =
    xor   A             ; 1:4       2dup =   A = 0x00
    sbc  HL, DE         ; 2:15      2dup =
    jr   nz, $+3        ; 2:7/12    2dup =
    dec   A             ; 1:4       2dup =   A = 0xFF
    ld    L, A          ; 1:4       2dup =
    ld    H, A          ; 1:4       2dup =   HL= flag
    pop  DE             ; 1:10      2dup =
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if
    ld   BC, string105  ; 3:10      print_i   Address of string105 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else101  EQU $          ;           then  = endif
endif101:               ;           then
    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if
    ld   BC, string105  ; 3:10      print_i   Address of string106 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i
else102  EQU $          ;           then  = endif
endif102:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       = if
    sbc  HL, DE         ; 2:15      = if
    pop  HL             ; 1:10      = if
    pop  DE             ; 1:10      = if
    jp   nz, else103    ; 3:10      = if
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else103  EQU $          ;           then  = endif
endif103:               ;           then
    push DE             ; 1:11      2dup <>
    push HL             ; 1:11      2dup <>   ( b a -- b a b a )
    or    A             ; 1:4       2dup <>
    sbc  HL, DE         ; 2:15      2dup <>
    jr    z, $+5        ; 2:7/12    2dup <>
    ld   HL, 0xFFFF     ; 3:10      2dup <>
    pop  DE             ; 1:10      2dup <>
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else104    ; 3:10      if
    ld   BC, string108  ; 3:10      print_i   Address of string108 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else104  EQU $          ;           then  = endif
endif104:               ;           then
    ld    A, E          ; 1:4       2dup <> if
    sub   L             ; 1:4       2dup <> if
    jr   nz, $+7        ; 2:7/12    2dup <> if
    ld    A, D          ; 1:4       2dup <> if
    sub   H             ; 1:4       2dup <> if
    jp    z, else105    ; 3:10      2dup <> if
    ld   BC, string108  ; 3:10      print_i   Address of string109 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
else105  EQU $          ;           then  = endif
endif105:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       <> if
    sbc  HL, DE         ; 2:15      <> if
    pop  HL             ; 1:10      <> if
    pop  DE             ; 1:10      <> if
    jp    z, else106    ; 3:10      <> if
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else106  EQU $          ;           then  = endif
endif106:               ;           then
    push DE             ; 1:11      2dup <
    push HL             ; 1:11      2dup <   ( b a -- b a b a )
                       ;[12:54]     2dup <   ( x2 x1 -- flag x2<x1 )
    ld    A, E          ; 1:4       2dup <   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup <   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup <   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup <   DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup <   carry --> sign
    xor   H             ; 1:4       2dup <
    xor   D             ; 1:4       2dup <
    add   A, A          ; 1:4       2dup <   sign --> carry
    sbc   A, A          ; 1:4       2dup <   0x00 or 0xff
    ld    H, A          ; 1:4       2dup <
    ld    L, A          ; 1:4       2dup <
    pop  DE             ; 1:10      2dup <
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else107    ; 3:10      if
    ld   BC, string111  ; 3:10      print_i   Address of string111 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else107  EQU $          ;           then  = endif
endif107:               ;           then
    ld    A, E          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    xor   H             ; 1:4       2dup < if
    jp    p, else108    ; 3:10      2dup < if
    ld   BC, string111  ; 3:10      print_i   Address of string112 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
else108  EQU $          ;           then  = endif
endif108:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       < if
    xor   H             ; 1:4       < if
    xor   D             ; 1:4       < if
    pop  HL             ; 1:10      < if
    pop  DE             ; 1:10      < if
    jp    p, else109    ; 3:10      < if
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else109  EQU $          ;           then  = endif
endif109:               ;           then
    push DE             ; 1:11      2dup <=
    push HL             ; 1:11      2dup <=   ( b a -- b a b a )
                       ;[13:57]     2dup <=   ( x2 x1 -- flag x2<=x1 )
    ld    A, L          ; 1:4       2dup <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sub   E             ; 1:4       2dup <=   DE<=HL --> 0<=HL-DE --> no carry if true
    ld    A, H          ; 1:4       2dup <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sbc   A, D          ; 1:4       2dup <=   DE<=HL --> 0<=HL-DE --> no carry if true
    rra                 ; 1:4       2dup <=   carry --> sign
    xor   H             ; 1:4       2dup <=
    xor   D             ; 1:4       2dup <=
    sub  0x80           ; 2:7       2dup <=   sign --> invert carry
    sbc   A, A          ; 1:4       2dup <=   0x00 or 0xff
    ld    H, A          ; 1:4       2dup <=
    ld    L, A          ; 1:4       2dup <=
    pop  DE             ; 1:10      2dup <=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else110    ; 3:10      if
    ld   BC, string114  ; 3:10      print_i   Address of string114 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else110  EQU $          ;           then  = endif
endif110:               ;           then
    ld    A, L          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= if
    xor   D             ; 1:4       2dup <= if
    xor   H             ; 1:4       2dup <= if
    jp    m, else111    ; 3:10      2dup <= if
    ld   BC, string114  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
else111  EQU $          ;           then  = endif
endif111:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       <= if    DE<=HL --> 0<=HL-DE --> not carry if true
    rra                 ; 1:4       <= if
    xor   H             ; 1:4       <= if
    xor   D             ; 1:4       <= if
    pop  HL             ; 1:10      <= if
    pop  DE             ; 1:10      <= if
    jp    m, else112    ; 3:10      <= if
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else112  EQU $          ;           then  = endif
endif112:               ;           then
    push DE             ; 1:11      2dup >
    push HL             ; 1:11      2dup >   ( b a -- b a b a )
                       ;[12:54]     2dup >   ( x2 x1 -- flag x2>x1 )
    ld    A, L          ; 1:4       2dup >   DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup >   DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup >   DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup >   DE>HL --> 0>HL-DE --> carry if true
    rra                 ; 1:4       2dup >   carry --> sign
    xor   H             ; 1:4       2dup >
    xor   D             ; 1:4       2dup >
    add   A, A          ; 1:4       2dup >   sign --> carry
    sbc   A, A          ; 1:4       2dup >   0x00 or 0xff
    ld    H, A          ; 1:4       2dup >
    ld    L, A          ; 1:4       2dup >
    pop  DE             ; 1:10      2dup >
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else113    ; 3:10      if
    ld   BC, string117  ; 3:10      print_i   Address of string117 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else113  EQU $          ;           then  = endif
endif113:               ;           then
    ld    A, L          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > if
    xor   D             ; 1:4       2dup > if
    xor   H             ; 1:4       2dup > if
    jp    p, else114    ; 3:10      2dup > if
    ld   BC, string117  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
else114  EQU $          ;           then  = endif
endif114:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       > if    DE>HL --> 0>HL-DE --> carry if true
    rra                 ; 1:4       > if
    xor   H             ; 1:4       > if
    xor   D             ; 1:4       > if
    pop  HL             ; 1:10      > if
    pop  DE             ; 1:10      > if
    jp    p, else115    ; 3:10      > if
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else115  EQU $          ;           then  = endif
endif115:               ;           then
    push DE             ; 1:11      2dup >=
    push HL             ; 1:11      2dup >=   ( b a -- b a b a )
                       ;[13:57]     2dup >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       2dup >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       2dup >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       2dup >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       2dup >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       2dup >=   carry --> sign
    xor   H             ; 1:4       2dup >=
    xor   D             ; 1:4       2dup >=
    sub  0x80           ; 2:7       2dup >=   sign --> invert carry
    sbc   A, A          ; 1:4       2dup >=   0x00 or 0xff
    ld    H, A          ; 1:4       2dup >=
    ld    L, A          ; 1:4       2dup >=
    pop  DE             ; 1:10      2dup >=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else116    ; 3:10      if
    ld   BC, string120  ; 3:10      print_i   Address of string120 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else116  EQU $          ;           then  = endif
endif116:               ;           then
    ld    A, E          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= if
    xor   D             ; 1:4       2dup >= if
    xor   H             ; 1:4       2dup >= if
    jp    m, else117    ; 3:10      2dup >= if
    ld   BC, string120  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
else117  EQU $          ;           then  = endif
endif117:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       >= if
    xor   H             ; 1:4       >= if
    xor   D             ; 1:4       >= if
    pop  HL             ; 1:10      >= if
    pop  DE             ; 1:10      >= if
    jp    m, else118    ; 3:10      >= if
    ld   BC, string122  ; 3:10      print_i   Address of string122 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
else118  EQU $          ;           then  = endif
endif118:               ;           then
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    call PRT_S16        ; 3:17      .   ( s -- )
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       u= if
    sbc  HL, DE         ; 2:15      u= if
    pop  HL             ; 1:10      u= if
    pop  DE             ; 1:10      u= if
    jp   nz, else119    ; 3:10      u= if
    ld   BC, string105  ; 3:10      print_i   Address of string123 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i
else119  EQU $          ;           then  = endif
endif119:               ;           then
    ld    A, E          ; 1:4       2dup u= if
    sub   L             ; 1:4       2dup u= if
    jp   nz, else120    ; 3:10      2dup u= if
    ld    A, D          ; 1:4       2dup u= if
    sub   H             ; 1:4       2dup u= if
    jp   nz, else120    ; 3:10      2dup u= if
    ld   BC, string105  ; 3:10      print_i   Address of string124 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i
else120  EQU $          ;           then  = endif
endif120:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       u= if
    sbc  HL, DE         ; 2:15      u= if
    pop  HL             ; 1:10      u= if
    pop  DE             ; 1:10      u= if
    jp   nz, else121    ; 3:10      u= if
    ld   BC, string107  ; 3:10      print_i   Address of string125 ending with inverted most significant bit == string107
    call PRINT_STRING_I ; 3:17      print_i
else121  EQU $          ;           then  = endif
endif121:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       u<> if
    sbc  HL, DE         ; 2:15      u<> if
    pop  HL             ; 1:10      u<> if
    pop  DE             ; 1:10      u<> if
    jp    z, else122    ; 3:10      u<> if
    ld   BC, string108  ; 3:10      print_i   Address of string126 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
else122  EQU $          ;           then  = endif
endif122:               ;           then
    ld    A, E          ; 1:4       2dup u<> if
    sub   L             ; 1:4       2dup u<> if
    jr   nz, $+7        ; 2:7/12    2dup u<> if
    ld    A, D          ; 1:4       2dup u<> if
    sbc   A, H          ; 1:4       2dup u<> if
    jp    z, else123    ; 3:10      2dup u<> if
    ld   BC, string108  ; 3:10      print_i   Address of string127 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
else123  EQU $          ;           then  = endif
endif123:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       u<> if
    sbc  HL, DE         ; 2:15      u<> if
    pop  HL             ; 1:10      u<> if
    pop  DE             ; 1:10      u<> if
    jp    z, else124    ; 3:10      u<> if
    ld   BC, string110  ; 3:10      print_i   Address of string128 ending with inverted most significant bit == string110
    call PRINT_STRING_I ; 3:17      print_i
else124  EQU $          ;           then  = endif
endif124:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< if
    pop  DE             ; 1:10      u< if
    jp   nc, else125    ; 3:10      u< if
    ld   BC, string111  ; 3:10      print_i   Address of string129 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
else125  EQU $          ;           then  = endif
endif125:               ;           then
    ld    A, E          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, else126    ; 3:10      2dup u< if
    ld   BC, string111  ; 3:10      print_i   Address of string130 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
else126  EQU $          ;           then  = endif
endif126:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< if
    pop  DE             ; 1:10      u< if
    jp   nc, else127    ; 3:10      u< if
    ld   BC, string113  ; 3:10      print_i   Address of string131 ending with inverted most significant bit == string113
    call PRINT_STRING_I ; 3:17      print_i
else127  EQU $          ;           then  = endif
endif127:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= if
    pop  DE             ; 1:10      u<= if
    jp    c, else128    ; 3:10      u<= if
    ld   BC, string114  ; 3:10      print_i   Address of string132 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
else128  EQU $          ;           then  = endif
endif128:               ;           then
    ld    A, L          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, else129    ; 3:10      2dup u<= if
    ld   BC, string114  ; 3:10      print_i   Address of string133 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
else129  EQU $          ;           then  = endif
endif129:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= if
    pop  DE             ; 1:10      u<= if
    jp    c, else130    ; 3:10      u<= if
    ld   BC, string116  ; 3:10      print_i   Address of string134 ending with inverted most significant bit == string116
    call PRINT_STRING_I ; 3:17      print_i
else130  EQU $          ;           then  = endif
endif130:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> if
    pop  DE             ; 1:10      u> if
    jp   nc, else131    ; 3:10      u> if
    ld   BC, string117  ; 3:10      print_i   Address of string135 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
else131  EQU $          ;           then  = endif
endif131:               ;           then
    ld    A, L          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, else132    ; 3:10      2dup u> if
    ld   BC, string117  ; 3:10      print_i   Address of string136 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
else132  EQU $          ;           then  = endif
endif132:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> if
    pop  DE             ; 1:10      u> if
    jp   nc, else133    ; 3:10      u> if
    ld   BC, string119  ; 3:10      print_i   Address of string137 ending with inverted most significant bit == string119
    call PRINT_STRING_I ; 3:17      print_i
else133  EQU $          ;           then  = endif
endif133:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= if
    pop  DE             ; 1:10      u>= if
    jp    c, else134    ; 3:10      u>= if
    ld   BC, string120  ; 3:10      print_i   Address of string138 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
else134  EQU $          ;           then  = endif
endif134:               ;           then
    ld    A, E          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, else135    ; 3:10      2dup u>= if
    ld   BC, string120  ; 3:10      print_i   Address of string139 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
else135  EQU $          ;           then  = endif
endif135:               ;           then
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= if
    pop  DE             ; 1:10      u>= if
    jp    c, else136    ; 3:10      u>= if
    ld   BC, string122  ; 3:10      print_i   Address of string140 ending with inverted most significant bit == string122
    call PRINT_STRING_I ; 3:17      print_i
else136  EQU $          ;           then  = endif
endif136:               ;           then
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    call PRT_U16        ; 3:17      u.   ( u -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
x_x_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
d_d_test:               ;           
    pop  BC             ; 1:10      : ret
    ld  (d_d_test_end+1),BC; 4:20      : ( ret -- )
                   ;[16:132/73,132] 4dup D= if   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= if   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= if   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= if   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= if   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= if   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= if   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= if   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= if   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= if   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= if   h2 l2 . h1 l1
    jp   nz, else137    ; 3:10      4dup D= if   h2 l2 . h1 l1
    ld   BC, string105  ; 3:10      print_i   Address of string141 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i
else137  EQU $          ;           then  = endif
endif137:               ;           then
                   ;[16:132/73,132] 4dup D= if   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= if   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= if   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= if   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= if   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= if   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= if   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= if   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= if   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= if   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= if   h2 l2 . h1 l1
    jp   nz, else138    ; 3:10      4dup D= if   h2 l2 . h1 l1
    ld   BC, string105  ; 3:10      print_i   Address of string142 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i
else138  EQU $          ;           then  = endif
endif138:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[14:91]     d= if   ( d2 d1 -- )  flag: d2 == d1
    pop  BC             ; 1:10      d= if   lo_2
    or    A             ; 1:4       d= if
    sbc  HL, BC         ; 2:15      d= if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      d= if   hi_2
    jr   nz, $+4        ; 2:7/12    d= if
    sbc  HL, DE         ; 2:15      d= if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      d= if
    pop  DE             ; 1:10      d= if
    jp   nz, else139    ; 3:10      d= if
    ld   BC, string107  ; 3:10      print_i   Address of string143 ending with inverted most significant bit == string107
    call PRINT_STRING_I ; 3:17      print_i
else139  EQU $          ;           then  = endif
endif139:               ;           then
            ;[21:51,66,123,122/122] 4dup D<> if  ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast,default
    pop  BC             ; 1:10      4dup D<> if   h2    . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> if   h2    . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> if   h2    . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> if   h2    . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> if   h2    . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> if   l1    . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> if   l1    . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> if   l1    . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> if   l1    . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> if   h2    . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> if   h2    . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> if   h2 l2 . h1 l1
    jp    z, else140    ; 3:10      4dup D<> if
    ld   BC, string108  ; 3:10      print_i   Address of string144 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
else140  EQU $          ;           then  = endif
endif140:               ;           then
            ;[21:51,66,123,122/122] 4dup D<> if  ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast,default
    pop  BC             ; 1:10      4dup D<> if   h2    . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> if   h2    . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> if   h2    . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> if   h2    . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> if   h2    . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> if   l1    . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> if   l1    . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> if   l1    . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> if   l1    . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> if   h2    . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> if   h2    . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> if   h2 l2 . h1 l1
    jp    z, else141    ; 3:10      4dup D<> if
    ld   BC, string108  ; 3:10      print_i   Address of string145 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
else141  EQU $          ;           then  = endif
endif141:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[14:91]     d<> if   ( d2 d1 -- )  flag: d2 <> d1
    pop  BC             ; 1:10      d<> if   lo_2
    or    A             ; 1:4       d<> if
    sbc  HL, BC         ; 2:15      d<> if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      d<> if   hi_2
    jr   nz, $+4        ; 2:7/12    d<> if
    sbc  HL, DE         ; 2:15      d<> if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      d<> if
    pop  DE             ; 1:10      d<> if
    jp    z, else142    ; 3:10      d<> if
    ld   BC, string110  ; 3:10      print_i   Address of string146 ending with inverted most significant bit == string110
    call PRINT_STRING_I ; 3:17      print_i
else142  EQU $          ;           then  = endif
endif142:               ;           then
                        ;[6:27]     4dup D< if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< if   carry if true
    jp   nc, else143    ; 3:10      4dup D< if
    ld   BC, string111  ; 3:10      print_i   Address of string147 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
else143  EQU $          ;           then  = endif
endif143:               ;           then
                        ;[6:27]     4dup D< if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< if   carry if true
    jp   nc, else144    ; 3:10      4dup D< if
    ld   BC, string111  ; 3:10      print_i   Address of string148 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
else144  EQU $          ;           then  = endif
endif144:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[18:94]     d< if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      d< if   lo_2
    ld    A, C          ; 1:4       d< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       d< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       d< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       d< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      d< if   hi_2
    ld    A, L          ; 1:4       d< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       d< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       d< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       d< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    rra                 ; 1:4       d< if                                   --> sign  if true
    xor   H             ; 1:4       d< if
    xor   D             ; 1:4       d< if
    pop  HL             ; 1:10      d< if
    pop  DE             ; 1:10      d< if
    jp    p, else145    ; 3:10      d< if
    ld   BC, string113  ; 3:10      print_i   Address of string149 ending with inverted most significant bit == string113
    call PRINT_STRING_I ; 3:17      print_i
else145  EQU $          ;           then  = endif
endif145:               ;           then
                        ;[6:27]     4dup D<= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= if   D> carry if true --> D<= carry if false
    jp    c, else146    ; 3:10      4dup D<= if
    ld   BC, string114  ; 3:10      print_i   Address of string150 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
else146  EQU $          ;           then  = endif
endif146:               ;           then
                        ;[6:27]     4dup D<= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= if   D> carry if true --> D<= carry if false
    jp    c, else147    ; 3:10      4dup D<= if
    ld   BC, string114  ; 3:10      print_i   Address of string151 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
else147  EQU $          ;           then  = endif
endif147:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[18:94]     D<= if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D<= if   lo_2
    or    A             ; 1:4       D<= if
    sbc  HL, BC         ; 2:15      D<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      D<= if   hi_2
    ld    A, E          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, C          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    ld    A, D          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    sbc   A, B          ; 1:4       D<= if   hi_2<=hi_1 --> BC<=DE --> 0<=DE-BC --> no carry if true
    rra                 ; 1:4       D<= if                                      --> no sign  if true
    xor   B             ; 1:4       D<= if
    xor   D             ; 1:4       D<= if
    pop  HL             ; 1:10      D<= if
    pop  DE             ; 1:10      D<= if
    jp    m, else148    ; 3:10      D<= if
    ld   BC, string116  ; 3:10      print_i   Address of string152 ending with inverted most significant bit == string116
    call PRINT_STRING_I ; 3:17      print_i
else148  EQU $          ;           then  = endif
endif148:               ;           then
                        ;[6:27]     4dup D> if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> if   carry if true
    jp   nc, else149    ; 3:10      4dup D> if
    ld   BC, string117  ; 3:10      print_i   Address of string153 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
else149  EQU $          ;           then  = endif
endif149:               ;           then
                        ;[6:27]     4dup D> if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> if   carry if true
    jp   nc, else150    ; 3:10      4dup D> if
    ld   BC, string117  ; 3:10      print_i   Address of string154 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
else150  EQU $          ;           then  = endif
endif150:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[17:97]     D> if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D> if   lo_2
    or    A             ; 1:4       D> if
    sbc  HL, BC         ; 2:15      D> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      D> if   hi_2
    ld    A, E          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       D> if   hi_2>hi_1 --> BC>DE --> 0>DE-BC --> carry if true
    rra                 ; 1:4       D> if                                   --> sign  if true
    xor   B             ; 1:4       D> if
    xor   D             ; 1:4       D> if
    pop  HL             ; 1:10      D> if
    pop  DE             ; 1:10      D> if
    jp    p, else151    ; 3:10      D> if
    ld   BC, string119  ; 3:10      print_i   Address of string155 ending with inverted most significant bit == string119
    call PRINT_STRING_I ; 3:17      print_i
else151  EQU $          ;           then  = endif
endif151:               ;           then
                        ;[6:27]     4dup D>= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= if   D< carry if true --> D>= carry if false
    jp    c, else152    ; 3:10      4dup D>= if
    ld   BC, string120  ; 3:10      print_i   Address of string156 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
else152  EQU $          ;           then  = endif
endif152:               ;           then
                        ;[6:27]     4dup D>= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= if   D< carry if true --> D>= carry if false
    jp    c, else153    ; 3:10      4dup D>= if
    ld   BC, string120  ; 3:10      print_i   Address of string157 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
else153  EQU $          ;           then  = endif
endif153:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[18:94]     D>= if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D>= if   lo_2
    ld    A, C          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sub   L             ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ld    A, B          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       D>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    pop  HL             ; 1:10      D>= if   hi_2
    ld    A, L          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, E          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    ld    A, H          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    sbc   A, D          ; 1:4       D>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    rra                 ; 1:4       D>= if                                      --> no sign  if true
    xor   H             ; 1:4       D>= if
    xor   D             ; 1:4       D>= if
    pop  HL             ; 1:10      D>= if
    pop  DE             ; 1:10      D>= if
    jp    m, else154    ; 3:10      D>= if
    ld   BC, string122  ; 3:10      print_i   Address of string158 ending with inverted most significant bit == string122
    call PRINT_STRING_I ; 3:17      print_i
else154  EQU $          ;           then  = endif
endif154:               ;           then
                        ;[9:91]     2over   ( d c b a -- d c b a d c )
    pop  AF             ; 1:10      2over   d       . b a     AF = c
    pop  BC             ; 1:10      2over           . b a     BC = d
    push BC             ; 1:11      2over   d       . b a
    push AF             ; 1:11      2over   d c     . b a
    push DE             ; 1:11      2over   d c b   . b a
    push AF             ; 1:11      2over   d c b c . b a
    ex  (SP),HL         ; 1:19      2over   d c b a . b c
    ld    D, B          ; 1:4       2over
    ld    E, C          ; 1:4       2over   d c b a . d c
    call PRT_S32        ; 3:17      d.   ( d -- )
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    call PRT_SP_S32     ; 3:17      space d.   ( d -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
                   ;[16:132/73,132] 4dup D= if   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= if   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= if   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= if   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= if   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= if   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= if   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= if   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= if   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= if   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= if   h2 l2 . h1 l1
    jp   nz, else155    ; 3:10      4dup D= if   h2 l2 . h1 l1
    ld   BC, string105  ; 3:10      print_i   Address of string159 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i
else155  EQU $          ;           then  = endif
endif155:               ;           then
                   ;[16:132/73,132] 4dup D= if   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= if   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= if   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= if   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= if   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= if   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= if   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= if   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= if   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= if   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= if   h2 l2 . h1 l1
    jp   nz, else156    ; 3:10      4dup D= if   h2 l2 . h1 l1
    ld   BC, string105  ; 3:10      print_i   Address of string160 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i
else156  EQU $          ;           then  = endif
endif156:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[14:91]     du= if   ( d2 d1 -- )  flag: d2 == d1
    pop  BC             ; 1:10      du= if   lo_2
    or    A             ; 1:4       du= if
    sbc  HL, BC         ; 2:15      du= if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      du= if   hi_2
    jr   nz, $+4        ; 2:7/12    du= if
    sbc  HL, DE         ; 2:15      du= if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      du= if
    pop  DE             ; 1:10      du= if
    jp   nz, else157    ; 3:10      du= if
    ld   BC, string107  ; 3:10      print_i   Address of string161 ending with inverted most significant bit == string107
    call PRINT_STRING_I ; 3:17      print_i
else157  EQU $          ;           then  = endif
endif157:               ;           then
            ;[21:51,66,123,122/122] 4dup D<> if  ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast,default
    pop  BC             ; 1:10      4dup D<> if   h2    . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> if   h2    . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> if   h2    . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> if   h2    . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> if   h2    . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> if   l1    . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> if   l1    . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> if   l1    . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> if   l1    . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> if   h2    . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> if   h2    . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> if   h2 l2 . h1 l1
    jp    z, else158    ; 3:10      4dup D<> if
    ld   BC, string108  ; 3:10      print_i   Address of string162 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
else158  EQU $          ;           then  = endif
endif158:               ;           then
            ;[21:51,66,123,122/122] 4dup D<> if  ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast,default
    pop  BC             ; 1:10      4dup D<> if   h2    . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> if   h2    . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> if   h2    . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> if   h2    . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> if   h2    . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> if   l1    . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> if   l1    . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> if   l1    . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> if   l1    . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> if   h2    . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> if   h2    . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> if   h2    . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> if   h2 l2 . h1 l1
    jp    z, else159    ; 3:10      4dup D<> if
    ld   BC, string108  ; 3:10      print_i   Address of string163 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
else159  EQU $          ;           then  = endif
endif159:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[14:91]     du<> if   ( d2 d1 -- )  flag: d2 <> d1
    pop  BC             ; 1:10      du<> if   lo_2
    or    A             ; 1:4       du<> if
    sbc  HL, BC         ; 2:15      du<> if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      du<> if   hi_2
    jr   nz, $+4        ; 2:7/12    du<> if
    sbc  HL, DE         ; 2:15      du<> if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      du<> if
    pop  DE             ; 1:10      du<> if
    jp    z, else160    ; 3:10      du<> if
    ld   BC, string110  ; 3:10      print_i   Address of string164 ending with inverted most significant bit == string110
    call PRINT_STRING_I ; 3:17      print_i
else160  EQU $          ;           then  = endif
endif160:               ;           then
                       ;[15:101]    4dup Du< if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du< if   ud2 < ud1 --> ud2-ud1<0 --> (SP)BC-DEHL<0 --> carry if true
    ld    A, C          ; 1:4       4dup Du< if
    sub   L             ; 1:4       4dup Du< if   C-L<0 --> carry if true
    ld    A, B          ; 1:4       4dup Du< if
    sbc   A, H          ; 1:4       4dup Du< if   B-H<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< if   HL = hi2
    ld    A, L          ; 1:4       4dup Du< if   HLBC-DE(SP)<0 -- carry if true
    sbc   A, E          ; 1:4       4dup Du< if   L-E<0 --> carry if true
    ld    A, H          ; 1:4       4dup Du< if
    sbc   A, D          ; 1:4       4dup Du< if   H-D<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< if
    push BC             ; 1:11      4dup Du< if
    jp   nc, else161    ; 3:10      4dup Du< if
    ld   BC, string111  ; 3:10      print_i   Address of string165 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
else161  EQU $          ;           then  = endif
endif161:               ;           then
                       ;[15:101]    4dup Du< if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du< if   ud2 < ud1 --> ud2-ud1<0 --> (SP)BC-DEHL<0 --> carry if true
    ld    A, C          ; 1:4       4dup Du< if
    sub   L             ; 1:4       4dup Du< if   C-L<0 --> carry if true
    ld    A, B          ; 1:4       4dup Du< if
    sbc   A, H          ; 1:4       4dup Du< if   B-H<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< if   HL = hi2
    ld    A, L          ; 1:4       4dup Du< if   HLBC-DE(SP)<0 -- carry if true
    sbc   A, E          ; 1:4       4dup Du< if   L-E<0 --> carry if true
    ld    A, H          ; 1:4       4dup Du< if
    sbc   A, D          ; 1:4       4dup Du< if   H-D<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< if
    push BC             ; 1:11      4dup Du< if
    jp   nc, else162    ; 3:10      4dup Du< if
    ld   BC, string111  ; 3:10      print_i   Address of string166 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
else162  EQU $          ;           then  = endif
endif162:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[13:81]     Du< if   ( ud2 ud1 -- )
    pop  BC             ; 1:10      Du< if   lo_2
    ld    A, C          ; 1:4       Du< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       Du< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       Du< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       Du< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      Du< if   hi_2
    sbc  HL, DE         ; 2:15      Du< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    pop  HL             ; 1:10      Du< if
    pop  DE             ; 1:10      Du< if
    jp   nc, else163    ; 3:10      Du< if
    ld   BC, string113  ; 3:10      print_i   Address of string167 ending with inverted most significant bit == string113
    call PRINT_STRING_I ; 3:17      print_i
else163  EQU $          ;           then  = endif
endif163:               ;           then
                       ;[15:101]    4dup Du<= if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du<= if   ud2 <= ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> no carry if true
    ld    A, L          ; 1:4       4dup Du<= if
    sub   C             ; 1:4       4dup Du<= if   0<=L-C --> no carry if true
    ld    A, H          ; 1:4       4dup Du<= if
    sbc   A, B          ; 1:4       4dup Du<= if   0<=H-B --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= if   HL = hi2
    ld    A, E          ; 1:4       4dup Du<= if   0<=DE(SP)-HLBC -- no carry if true
    sbc   A, L          ; 1:4       4dup Du<= if   0<=E-L --> no carry if true
    ld    A, D          ; 1:4       4dup Du<= if
    sbc   A, H          ; 1:4       4dup Du<= if   0<=D-H --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= if
    push BC             ; 1:11      4dup Du<= if
    jp    c, else164    ; 3:10      4dup Du<= if
    ld   BC, string114  ; 3:10      print_i   Address of string168 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
else164  EQU $          ;           then  = endif
endif164:               ;           then
                       ;[15:101]    4dup Du<= if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du<= if   ud2 <= ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> no carry if true
    ld    A, L          ; 1:4       4dup Du<= if
    sub   C             ; 1:4       4dup Du<= if   0<=L-C --> no carry if true
    ld    A, H          ; 1:4       4dup Du<= if
    sbc   A, B          ; 1:4       4dup Du<= if   0<=H-B --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= if   HL = hi2
    ld    A, E          ; 1:4       4dup Du<= if   0<=DE(SP)-HLBC -- no carry if true
    sbc   A, L          ; 1:4       4dup Du<= if   0<=E-L --> no carry if true
    ld    A, D          ; 1:4       4dup Du<= if
    sbc   A, H          ; 1:4       4dup Du<= if   0<=D-H --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= if
    push BC             ; 1:11      4dup Du<= if
    jp    c, else165    ; 3:10      4dup Du<= if
    ld   BC, string114  ; 3:10      print_i   Address of string169 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
else165  EQU $          ;           then  = endif
endif165:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[13:88]     Du<= if   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      Du<= if   lo_2
    or    A             ; 1:4       Du<= if
    sbc  HL, BC         ; 2:15      Du<= if   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  BC             ; 1:10      Du<= if   hi_2
    ex   DE, HL         ; 1:4       Du<= if
    sbc  HL, BC         ; 2:15      Du<= if   hi_2<=hi_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  HL             ; 1:10      Du<= if
    pop  DE             ; 1:10      Du<= if
    jp    c, else166    ; 3:10      Du<= if
    ld   BC, string116  ; 3:10      print_i   Address of string170 ending with inverted most significant bit == string116
    call PRINT_STRING_I ; 3:17      print_i
else166  EQU $          ;           then  = endif
endif166:               ;           then
                       ;[15:101]    4dup Du> if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du> if   ud2 > ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> carry if true
    ld    A, L          ; 1:4       4dup Du> if
    sub   C             ; 1:4       4dup Du> if   0>L-C --> carry if true
    ld    A, H          ; 1:4       4dup Du> if
    sbc   A, B          ; 1:4       4dup Du> if   0>H-B --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> if   HL = hi2
    ld    A, E          ; 1:4       4dup Du> if   0>DE(SP)-HLBC -- carry if true
    sbc   A, L          ; 1:4       4dup Du> if   0>E-L --> carry if true
    ld    A, D          ; 1:4       4dup Du> if
    sbc   A, H          ; 1:4       4dup Du> if   0>D-H --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> if
    push BC             ; 1:11      4dup Du> if
    jp   nc, else167    ; 3:10      4dup Du> if
    ld   BC, string117  ; 3:10      print_i   Address of string171 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
else167  EQU $          ;           then  = endif
endif167:               ;           then
                       ;[15:101]    4dup Du> if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du> if   ud2 > ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> carry if true
    ld    A, L          ; 1:4       4dup Du> if
    sub   C             ; 1:4       4dup Du> if   0>L-C --> carry if true
    ld    A, H          ; 1:4       4dup Du> if
    sbc   A, B          ; 1:4       4dup Du> if   0>H-B --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> if   HL = hi2
    ld    A, E          ; 1:4       4dup Du> if   0>DE(SP)-HLBC -- carry if true
    sbc   A, L          ; 1:4       4dup Du> if   0>E-L --> carry if true
    ld    A, D          ; 1:4       4dup Du> if
    sbc   A, H          ; 1:4       4dup Du> if   0>D-H --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> if
    push BC             ; 1:11      4dup Du> if
    jp   nc, else168    ; 3:10      4dup Du> if
    ld   BC, string117  ; 3:10      print_i   Address of string172 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
else168  EQU $          ;           then  = endif
endif168:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[13:88]     Du> if   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      Du> if   lo_2
    or    A             ; 1:4       Du> if
    sbc  HL, BC         ; 2:15      Du> if   lo_2>lo_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      Du> if   hi_2
    ex   DE, HL         ; 1:4       Du> if
    sbc  HL, BC         ; 2:15      Du> if   hi_2>hi_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  HL             ; 1:10      Du> if
    pop  DE             ; 1:10      Du> if
    jp   nc, else169    ; 3:10      Du> if
    ld   BC, string119  ; 3:10      print_i   Address of string173 ending with inverted most significant bit == string119
    call PRINT_STRING_I ; 3:17      print_i
else169  EQU $          ;           then  = endif
endif169:               ;           then
                       ;[15:101]    4dup Du>= if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du>= if   ud2 >= ud1 --> ud2-ud1>=0 --> (SP)BC-DEHL>=0 --> no carry if true
    ld    A, C          ; 1:4       4dup Du>= if
    sub   L             ; 1:4       4dup Du>= if   C-L>=0 --> no carry if true
    ld    A, B          ; 1:4       4dup Du>= if
    sbc   A, H          ; 1:4       4dup Du>= if   B-H>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= if   HL = hi2
    ld    A, L          ; 1:4       4dup Du>= if   HLBC-DE(SP)>=0 -- no carry if true
    sbc   A, E          ; 1:4       4dup Du>= if   L-E>=0 --> no carry if true
    ld    A, H          ; 1:4       4dup Du>= if
    sbc   A, D          ; 1:4       4dup Du>= if   H-D>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= if
    push BC             ; 1:11      4dup Du>= if
    jp    c, else170    ; 3:10      4dup Du>= if
    ld   BC, string120  ; 3:10      print_i   Address of string174 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
else170  EQU $          ;           then  = endif
endif170:               ;           then
                       ;[15:101]    4dup Du>= if   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du>= if   ud2 >= ud1 --> ud2-ud1>=0 --> (SP)BC-DEHL>=0 --> no carry if true
    ld    A, C          ; 1:4       4dup Du>= if
    sub   L             ; 1:4       4dup Du>= if   C-L>=0 --> no carry if true
    ld    A, B          ; 1:4       4dup Du>= if
    sbc   A, H          ; 1:4       4dup Du>= if   B-H>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= if   HL = hi2
    ld    A, L          ; 1:4       4dup Du>= if   HLBC-DE(SP)>=0 -- no carry if true
    sbc   A, E          ; 1:4       4dup Du>= if   L-E>=0 --> no carry if true
    ld    A, H          ; 1:4       4dup Du>= if
    sbc   A, D          ; 1:4       4dup Du>= if   H-D>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= if
    push BC             ; 1:11      4dup Du>= if
    jp    c, else171    ; 3:10      4dup Du>= if
    ld   BC, string120  ; 3:10      print_i   Address of string175 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
else171  EQU $          ;           then  = endif
endif171:               ;           then
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[13:81]     Du>= if   ( ud2 ud1 -- )
    pop  BC             ; 1:10      Du>= if   lo_2
    ld    A, C          ; 1:4       Du>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sub   L             ; 1:4       Du>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    ld    A, B          ; 1:4       Du>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       Du>= if   lo_2>=lo_1 --> BC>=HL --> BC-HL>=0 --> no carry if true
    pop  HL             ; 1:10      Du>= if   hi_2
    sbc  HL, DE         ; 2:15      Du>= if   hi_2>=hi_1 --> HL>=DE --> HL-DE>=0 --> no carry if true
    pop  HL             ; 1:10      Du>= if
    pop  DE             ; 1:10      Du>= if
    jp    c, else172    ; 3:10      Du>= if
    ld   BC, string122  ; 3:10      print_i   Address of string176 ending with inverted most significant bit == string122
    call PRINT_STRING_I ; 3:17      print_i
else172  EQU $          ;           then  = endif
endif172:               ;           then
                        ;[6:67]     2swap   ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap   d a . b c
    ex   DE, HL         ; 1:4       2swap   d a . c b
    pop  AF             ; 1:10      2swap   d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap   b   . c d
    ex   DE, HL         ; 1:4       2swap   b   . d c
    push AF             ; 1:11      2swap   b a . d c
    call PRT_U32        ; 3:17      ud.   ( ud -- )
    call PRT_SP_U32     ; 3:17      space ud.   ( ud -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
d_d_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
x_p3_test:              ;           
    pop  BC             ; 1:10      : ret
    ld  (x_p3_test_end+1),BC; 4:20      : ( ret -- )
                        ;[7:25]     dup 3 = if   ( x1 -- x1 )   3 == HL
    ld    A, 0x03       ; 2:7       dup 3 = if
    xor   L             ; 1:4       dup 3 = if   x[1] = 0x03
    or    H             ; 1:4       dup 3 = if   x[2] = 0
    jp   nz, else173    ; 3:10      dup 3 = if
    ld   BC, string107  ; 3:10      print_i   Address of string177 ending with inverted most significant bit == string107
    call PRINT_STRING_I ; 3:17      print_i
else173  EQU $          ;           then  = endif
endif173:               ;           then
                        ;[7:25]     dup 3 <> if   ( x1 -- x1 )   3 <> HL
    ld    A, 0x03       ; 2:7       dup 3 <> if
    xor   L             ; 1:4       dup 3 <> if   x[1] = 0x03
    or    H             ; 1:4       dup 3 <> if   x[2] = 0
    jp    z, else174    ; 3:10      dup 3 <> if
    ld   BC, string110  ; 3:10      print_i   Address of string178 ending with inverted most significant bit == string110
    call PRINT_STRING_I ; 3:17      print_i
else174  EQU $          ;           then  = endif
endif174:               ;           then
                       ;[13:47/20]  dup 3 < if   ( x -- x )  flag: x < 3
    ld    A, H          ; 1:4       dup 3 < if
    add   A, A          ; 1:4       dup 3 < if
    jr    c, $+11       ; 2:7/12    dup 3 < if    negative HL < positive constant ---> true
    ld    A, L          ; 1:4       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    jp   nc, else175    ; 3:10      dup 3 < if
    ld   BC, string113  ; 3:10      print_i   Address of string179 ending with inverted most significant bit == string113
    call PRINT_STRING_I ; 3:17      print_i
else175  EQU $          ;           then  = endif
endif175:               ;           then
                       ;[13:47/20]  dup 3 <= if   ( x -- x )  flag: x <= 3
    ld    A, H          ; 1:4       dup 3 <= if
    add   A, A          ; 1:4       dup 3 <= if
    jr    c, $+11       ; 2:7/12    dup 3 <= if    negative HL <= positive constant ---> true
    ld    A, low 3      ; 2:7       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, else176    ; 3:10      dup 3 <= if
    ld   BC, string116  ; 3:10      print_i   Address of string180 ending with inverted most significant bit == string116
    call PRINT_STRING_I ; 3:17      print_i
else176  EQU $          ;           then  = endif
endif176:               ;           then
                        ;[14:50/18] dup 3 > if   ( x -- x )  flag: x > 3
    ld    A, H          ; 1:4       dup 3 > if
    add   A, A          ; 1:4       dup 3 > if
    jp    c, else177    ; 3:10      dup 3 > if    negative HL > positive constant ---> false
    ld    A, low 3      ; 2:7       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    jp   nc, else177    ; 3:10      dup 3 > if
    ld   BC, string119  ; 3:10      print_i   Address of string181 ending with inverted most significant bit == string119
    call PRINT_STRING_I ; 3:17      print_i
else177  EQU $          ;           then  = endif
endif177:               ;           then
                       ;[14:50/18]  dup 3 >= if   ( x -- x )  flag: x >= 3
    ld    A, H          ; 1:4       dup 3 >= if
    add   A, A          ; 1:4       dup 3 >= if
    jp    c, else178    ; 3:10      dup 3 >= if    negative HL >= positive constant ---> false
    ld    A, L          ; 1:4       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, else178    ; 3:10      dup 3 >= if
    ld   BC, string122  ; 3:10      print_i   Address of string182 ending with inverted most significant bit == string122
    call PRINT_STRING_I ; 3:17      print_i
else178  EQU $          ;           then  = endif
endif178:               ;           then
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    push DE             ; 1:11      3
    ex   DE, HL         ; 1:4       3
    ld   HL, 3          ; 3:10      3
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
                        ;[7:25]     dup 3 u= if   variant: hi(3) = zero
    ld    A, low 3      ; 2:7       dup 3 u= if
    xor   L             ; 1:4       dup 3 u= if
    or    H             ; 1:4       dup 3 u= if
    jp   nz, else179    ; 3:10      dup 3 u= if
    ld   BC, string107  ; 3:10      print_i   Address of string183 ending with inverted most significant bit == string107
    call PRINT_STRING_I ; 3:17      print_i
else179  EQU $          ;           then  = endif
endif179:               ;           then
                        ;[7:25]     dup 3 u<> if   variant: hi(3) = zero
    ld    A, low 3      ; 2:7       dup 3 u<> if
    xor   L             ; 1:4       dup 3 u<> if
    or    H             ; 1:4       dup 3 u<> if
    jp    z, else180    ; 3:10      dup 3 u<> if
    ld   BC, string110  ; 3:10      print_i   Address of string184 ending with inverted most significant bit == string110
    call PRINT_STRING_I ; 3:17      print_i
else180  EQU $          ;           then  = endif
endif180:               ;           then
    ld    A, L          ; 1:4       dup 3 u< if    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 u< if    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 u< if    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 u< if    HL<3 --> HL-3<0 --> carry if true
    jp   nc, else181    ; 3:10      dup 3 u< if
    ld   BC, string113  ; 3:10      print_i   Address of string185 ending with inverted most significant bit == string113
    call PRINT_STRING_I ; 3:17      print_i
else181  EQU $          ;           then  = endif
endif181:               ;           then
    ld    A, low 3      ; 2:7       dup 3 u<= if    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 u<= if    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 u<= if    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 u<= if    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, else182    ; 3:10      dup 3 u<= if
    ld   BC, string116  ; 3:10      print_i   Address of string186 ending with inverted most significant bit == string116
    call PRINT_STRING_I ; 3:17      print_i
else182  EQU $          ;           then  = endif
endif182:               ;           then
    ld    A, low 3      ; 2:7       dup 3 u> if    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 u> if    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 u> if    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 u> if    HL>3 --> 0>3-HL --> carry if true
    jp   nc, else183    ; 3:10      dup 3 u> if
    ld   BC, string119  ; 3:10      print_i   Address of string187 ending with inverted most significant bit == string119
    call PRINT_STRING_I ; 3:17      print_i
else183  EQU $          ;           then  = endif
endif183:               ;           then
    ld    A, L          ; 1:4       dup 3 u>= if    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 u>= if    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 u>= if    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 u>= if    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, else184    ; 3:10      dup 3 u>= if
    ld   BC, string122  ; 3:10      print_i   Address of string188 ending with inverted most significant bit == string122
    call PRINT_STRING_I ; 3:17      print_i
else184  EQU $          ;           then  = endif
endif184:               ;           then
    call PRT_U16        ; 3:17      u.   ( u -- )
    push DE             ; 1:11      3
    ex   DE, HL         ; 1:4       3
    ld   HL, 3          ; 3:10      3
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
x_p3_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
x_m3_test:              ;           
    pop  BC             ; 1:10      : ret
    ld  (x_m3_test_end+1),BC; 4:20      : ( ret -- )
                        ;[8:29]     dup -3 = if   ( x1 -- x1 )   -3 == HL
    ld    A, L          ; 1:4       dup -3 = if
    xor   0x02          ; 2:7       dup -3 = if   x[1] = 0xFF ^ 0x02
    and   H             ; 1:4       dup -3 = if
    inc   A             ; 1:4       dup -3 = if   x[2] = 0xFF
    jp   nz, else185    ; 3:10      dup -3 = if
    ld   BC, string107  ; 3:10      print_i   Address of string189 ending with inverted most significant bit == string107
    call PRINT_STRING_I ; 3:17      print_i
else185  EQU $          ;           then  = endif
endif185:               ;           then
                        ;[8:29]     dup -3 <> if   ( x1 -- x1 )   -3 <> HL
    ld    A, L          ; 1:4       dup -3 <> if
    xor   0x02          ; 2:7       dup -3 <> if   x[1] = 0xFF ^ 0x02
    and   H             ; 1:4       dup -3 <> if
    inc   A             ; 1:4       dup -3 <> if   x[2] = 0xFF
    jp    z, else186    ; 3:10      dup -3 <> if
    ld   BC, string110  ; 3:10      print_i   Address of string190 ending with inverted most significant bit == string110
    call PRINT_STRING_I ; 3:17      print_i
else186  EQU $          ;           then  = endif
endif186:               ;           then
                       ;[13:47/20]  dup -3 < if   ( x -- x )  flag: x < -3
    ld    A, H          ; 1:4       dup -3 < if
    add   A, A          ; 1:4       dup -3 < if
    jp   nc, else187    ; 3:10      dup -3 < if    positive HL < negative constant ---> false
    ld    A, L          ; 1:4       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    sub   low 0-3       ; 2:7       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high 0-3   ; 2:7       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, else187    ; 3:10      dup -3 < if
    ld   BC, string113  ; 3:10      print_i   Address of string191 ending with inverted most significant bit == string113
    call PRINT_STRING_I ; 3:17      print_i
else187  EQU $          ;           then  = endif
endif187:               ;           then
                       ;[13:47/20]  dup -3 <= if   ( x -- x )  flag: x <= -3
    ld    A, H          ; 1:4       dup -3 <= if
    add   A, A          ; 1:4       dup -3 <= if
    jp   nc, else188    ; 3:10      dup -3 <= if    positive HL <= negative constant ---> false
    ld    A, low 0-3    ; 2:7       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high 0-3   ; 2:7       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, else188    ; 3:10      dup -3 <= if
    ld   BC, string116  ; 3:10      print_i   Address of string192 ending with inverted most significant bit == string116
    call PRINT_STRING_I ; 3:17      print_i
else188  EQU $          ;           then  = endif
endif188:               ;           then
                        ;[14:50/18] dup -3 > if   ( x -- x )  flag: x > -3
    ld    A, H          ; 1:4       dup -3 > if
    add   A, A          ; 1:4       dup -3 > if
    jr   nc, $+11       ; 2:7/12    dup -3 > if    positive HL > negative constant ---> true
    ld    A, low 0-3    ; 2:7       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high 0-3   ; 2:7       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, else189    ; 3:10      dup -3 > if
    ld   BC, string119  ; 3:10      print_i   Address of string193 ending with inverted most significant bit == string119
    call PRINT_STRING_I ; 3:17      print_i
else189  EQU $          ;           then  = endif
endif189:               ;           then
                       ;[14:50/18]  dup -3 >= if   ( x -- x )  flag: x >= -3
    ld    A, H          ; 1:4       dup -3 >= if
    add   A, A          ; 1:4       dup -3 >= if
    jr   nc, $+11       ; 2:7/12    dup -3 >= if    positive HL >= negative constant ---> true
    ld    A, L          ; 1:4       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low 0-3       ; 2:7       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high 0-3   ; 2:7       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, else190    ; 3:10      dup -3 >= if
    ld   BC, string122  ; 3:10      print_i   Address of string194 ending with inverted most significant bit == string122
    call PRINT_STRING_I ; 3:17      print_i
else190  EQU $          ;           then  = endif
endif190:               ;           then
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    push DE             ; 1:11      -3
    ex   DE, HL         ; 1:4       -3
    ld   HL, 0-3        ; 3:10      -3
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
                        ;[11:18/39] dup -3 u= if   variant: hi(-3) = 255
    ld    A, H          ; 1:4       dup -3 u= if
    inc   A             ; 1:4       dup -3 u= if
    jp   nz, else191    ; 3:10      dup -3 u= if
    ld    A, low 0-3    ; 2:7       dup -3 u= if
    xor   L             ; 1:4       dup -3 u= if
    jp   nz, else191    ; 3:10      dup -3 u= if
    ld   BC, string107  ; 3:10      print_i   Address of string195 ending with inverted most significant bit == string107
    call PRINT_STRING_I ; 3:17      print_i
else191  EQU $          ;           then  = endif
endif191:               ;           then
                        ;[10:20/36] dup -3 u<> if   variant: hi(-3) = 255
    ld    A, H          ; 1:4       dup -3 u<> if
    inc   A             ; 1:4       dup -3 u<> if
    jr   nz, $+8        ; 2:7/12    dup -3 u<> if
    ld    A, low 0-3    ; 2:7       dup -3 u<> if
    xor   L             ; 1:4       dup -3 u<> if
    jp    z, else192    ; 3:10      dup -3 u<> if
    ld   BC, string110  ; 3:10      print_i   Address of string196 ending with inverted most significant bit == string110
    call PRINT_STRING_I ; 3:17      print_i
else192  EQU $          ;           then  = endif
endif192:               ;           then
    ld    A, L          ; 1:4       dup -3 u< if    HL<-3 --> HL--3<0 --> carry if true
    sub   low 0-3       ; 2:7       dup -3 u< if    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 u< if    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high 0-3   ; 2:7       dup -3 u< if    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, else193    ; 3:10      dup -3 u< if
    ld   BC, string113  ; 3:10      print_i   Address of string197 ending with inverted most significant bit == string113
    call PRINT_STRING_I ; 3:17      print_i
else193  EQU $          ;           then  = endif
endif193:               ;           then
    ld    A, low 0-3    ; 2:7       dup -3 u<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 u<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high 0-3   ; 2:7       dup -3 u<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 u<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, else194    ; 3:10      dup -3 u<= if
    ld   BC, string116  ; 3:10      print_i   Address of string198 ending with inverted most significant bit == string116
    call PRINT_STRING_I ; 3:17      print_i
else194  EQU $          ;           then  = endif
endif194:               ;           then
    ld    A, low 0-3    ; 2:7       dup -3 u> if    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 u> if    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high 0-3   ; 2:7       dup -3 u> if    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 u> if    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, else195    ; 3:10      dup -3 u> if
    ld   BC, string119  ; 3:10      print_i   Address of string199 ending with inverted most significant bit == string119
    call PRINT_STRING_I ; 3:17      print_i
else195  EQU $          ;           then  = endif
endif195:               ;           then
    ld    A, L          ; 1:4       dup -3 u>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low 0-3       ; 2:7       dup -3 u>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 u>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high 0-3   ; 2:7       dup -3 u>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, else196    ; 3:10      dup -3 u>= if
    ld   BC, string122  ; 3:10      print_i   Address of string200 ending with inverted most significant bit == string122
    call PRINT_STRING_I ; 3:17      print_i
else196  EQU $          ;           then  = endif
endif196:               ;           then
    call PRT_U16        ; 3:17      u.   ( u -- )
    push DE             ; 1:11      -3
    ex   DE, HL         ; 1:4       -3
    ld   HL, 0-3        ; 3:10      -3
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
x_m3_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;==============================================================================
; ( hi lo -- )
; Input: DEHL
; Output: Print space and signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_SP_S32:             ;           prt_sp_s32
    ld    A, ' '        ; 2:7       prt_sp_s32   putchar Pollutes: AF, AF', DE', BC'
    
    call  draw_char     ; 3:17      prt_sp_s32
    ; fall to prt_s32
;------------------------------------------------------------------------------
; ( hi lo -- )
; Input: DEHL
; Output: Print signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_S32:                ;           prt_s32
    ld    A, D          ; 1:4       prt_s32
    add   A, A          ; 1:4       prt_s32
    jr   nc, PRT_U32    ; 2:7/12    prt_s32
    ld    A, '-'        ; 2:7       prt_s32   putchar Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      prt_s32
    call NEGATE_32      ; 3:17      prt_s32
    jr   PRT_U32        ; 2:12      prt_s32
;==============================================================================
; Input: DEHL
; Output: Print space and unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_SP_U32:             ;           prt_sp_u32
    ld    A, ' '        ; 2:7       prt_sp_u32   putchar Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      prt_sp_u32
    ; fall to prt_u32
;------------------------------------------------------------------------------
; Input: DEHL
; Output: Print unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_U32:                ;           prt_u32
    xor   A             ; 1:4       prt_u32   HL = 103 & A=0 => 103, HL = 103 & A='0' => 00103
    push IX             ; 2:15      prt_u32
    ex   DE, HL         ; 1:4       prt_u32   HL = hi word
    ld  IXl, E          ; 2:8       prt_u32
    ld  IXh, D          ; 2:8       prt_u32   IX = lo word
    ld   DE, 0x3600     ; 3:10      prt_u32   C4 65 36 00 = -1000000000
    ld   BC, 0xC465     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld    D, 0x1F       ; 2:7       prt_u32   FA 0A 1F 00 = -100000000
    ld   BC, 0xFA0A     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0x6980     ; 3:10      prt_u32   FF 67 69 80 = -10000000
    ld   BC, 0xFF67     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xBDC0     ; 3:10      prt_u32   FF F0 BD C0 = -1000000
    ld    C, 0xF0       ; 2:7       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0x7960     ; 3:10      prt_u32   FF FE 79 60 = -100000
    ld    C, 0xFE       ; 2:7       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xD8F0     ; 3:10      prt_u32   FF FF D8 F0 = -10000
    ld    C, B          ; 1:4       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xFC18     ; 3:10      prt_u32   FF FF FC 18 = -1000
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xFF9C     ; 3:10      prt_u32   FF FF FF 9C = -100
    call BIN32_DEC      ; 3:17      prt_u32
    ld    E, 0xF6       ; 2:7       prt_u32   FF FF FF F6 = -10
    call BIN32_DEC      ; 3:17      prt_u32
    ld    A, IXl        ; 2:8       prt_u32
    pop  IX             ; 2:14      prt_u32
    pop  BC             ; 1:10      prt_u32   load ret
    pop  HL             ; 1:10      prt_u32
    pop  DE             ; 1:10      prt_u32
    push BC             ; 1:11      prt_u32   save ret
    jr   BIN32_DEC_CHAR ; 2:12      prt_u32
;------------------------------------------------------------------------------
; Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
; Output: if ((HLIX/(-BCDE) > 0) || (A >= '0')) print number HLIX/(-BCDE)
; Pollutes: AF, AF', IX, HL
BIN32_DEC:              ;           bin32_dec
    add  IX, DE         ; 2:15      bin32_dec   lo word
    adc  HL, BC         ; 2:15      bin32_dec   hi word
    inc   A             ; 1:4       bin32_dec
    jr    c, $-5        ; 2:7/12    bin32_dec
    ex   AF, AF'        ; 1:4       bin32_dec
    ld    A, IXl        ; 2:8       bin32_dec
    sub   E             ; 1:4       bin32_dec
    ld  IXl, A          ; 2:8       bin32_dec
    ld    A, IXh        ; 2:8       bin32_dec
    sbc   A, D          ; 1:4       bin32_dec
    ld  IXh, A          ; 2:8       bin32_dec
    sbc  HL, BC         ; 2:15      bin32_dec   hi word
    ex   AF, AF'        ; 1:4       bin32_dec
    dec   A             ; 1:4       bin32_dec
    ret   z             ; 1:5/11    bin32_dec   does not print leading zeros
BIN32_DEC_CHAR:         ;           bin32_dec
    or   '0'            ; 2:7       bin32_dec   1..9 --> '1'..'9', unchanged '0'..'9'
        call  draw_char     ; 3:17      bin32_dec
    ld    A, '0'        ; 2:7       bin32_dec   reset A to '0'
    ret                 ; 1:10      bin32_dec
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_S16:             ;           prt_sp_s16
    ld    A, ' '        ; 2:7       prt_sp_s16   putchar Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      prt_sp_s16
    ; fall to prt_s16
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_S16:                ;           prt_s16
    ld    A, H          ; 1:4       prt_s16
    add   A, A          ; 1:4       prt_s16
    jr   nc, PRT_U16    ; 2:7/12    prt_s16
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      prt_s16
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
    ld    A, ' '        ; 2:7       prt_sp_u16   putchar Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      prt_sp_u16  
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
    call  draw_char     ; 3:17      bin16_dec  
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
;==============================================================================
; ( d -- -d )
NEGATE_32:              ;[14:62]    negate_32   ( hi lo -- 0-hi-carry 0-lo )
    xor   A             ; 1:4       negate_32
    ld    C, A          ; 1:4       negate_32
    sub   L             ; 1:4       negate_32
    ld    L, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, H          ; 1:4       negate_32
    ld    H, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, E          ; 1:4       negate_32
    ld    E, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, D          ; 1:4       negate_32
    ld    D, A          ; 1:4       negate_32
    ret                 ; 1:10      negate_32
;==============================================================================
; ( d2 ret d1 -- d2 d1 )
;  In: (SP+4) = h2, (SP+2) = l2, (SP) = ret
; Out: (SP+2) = h2, (SP)   = l2, (SP) = ret, AF = h2, BC = l2
FCE_4DUP_DLT:           ;[9:75]     fce_4dup_dlt   ( d2 ret d1 -- d2 d1 )
    pop  AF             ; 1:10      fce_4dup_dlt   h2 l2 .. ..  AF = ret
    pop  BC             ; 1:10      fce_4dup_dlt   h2 .. .. ..  BC = l2
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 .. .. ..
    pop  AF             ; 1:10      fce_4dup_dlt   .. .. .. ..  AF'= h2
    push AF             ; 1:11      fce_4dup_dlt   h2 .. .. ..
    push BC             ; 1:11      fce_4dup_dlt   h2 l2 .. ..
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 l2 .. ..
    push AF             ; 1:11      fce_4dup_dlt   h2 l2 rt ..
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 l2 rt ..  AF = h2
    ; fall to fce_dlt
;==============================================================================
; ( d2 ret d1 -- d1 )
; set carry if d2<d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set carry if true
FCE_DLT:               ;[18:58,71]  fce_dlt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DLT},{small})"
    push AF             ; 1:11      fce_dlt   h2 l2 rt h2 h1 l1  d2<d1 --> d2-d1<0 --> AFBC-DEHL<0 --> carry if true
    sub   D             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  A-D<0 --> carry if true
    jr    z, $+8        ; 2:7/12    fce_dlt   h2 l2 rt h2 h1 l1
    rra                 ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1        --> sign  if true
    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1
    xor   B             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
    xor   D             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
    add   A, A          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1        --> carry if true
    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1
    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
    sub   L             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  C-L<0 --> carry if true
    ld    A, B          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
    sbc   A, H          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  B-H<0 --> carry if true
    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1  BC = hi16(d2)
    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
    sbc   A, E          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1  C-E<0 --> carry if true
    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1
;==============================================================================
; ( d2 ret d1 -- d2 d1 )
;  In: (SP+4) = h2, (SP+2) = l2, (SP) = ret
; Out: (SP+2) = h2, (SP)   = l2, (SP) = ret, AF = h2, BC = l2
FCE_4DUP_DGT:           ;[9:75]     fce_4dup_dgt   ( d2 ret d1 -- d2 d1 )
    pop  AF             ; 1:10      fce_4dup_dgt   h2 l2 .. ..  AF = ret
    pop  BC             ; 1:10      fce_4dup_dgt   h2 .. .. ..  BC = l2
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 .. .. ..
    pop  AF             ; 1:10      fce_4dup_dgt   .. .. .. ..  AF'= h2
    push AF             ; 1:11      fce_4dup_dgt   h2 .. .. ..
    push BC             ; 1:11      fce_4dup_dgt   h2 l2 .. ..
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 l2 .. ..
    push AF             ; 1:11      fce_4dup_dgt   h2 l2 rt ..
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 l2 rt ..  AF = h2
    ; fall to fce_dgt
;==============================================================================
; ( d2 ret d1 -- d1 )
; carry if d2>d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set carry if true
FCE_DGT:               ;[22:60,71]  fce_dgt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DGT},{small})"
    push AF             ; 1:11      fce_dgt   h2 l2 rt h2 h1 l1  d2>d1 --> 0>d1-d2 --> 0>DEHL-AFBC --> carry if true
    xor   D             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  A==D?
    jr    z, $+12       ; 2:7/12    fce_dgt   h2 l2 rt h2 h1 l1
    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
    jp    p, $+6        ; 3:10      fce_dgt   h2 l2 rt .. h1 l1
    ld    A, B          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  opposite signs
    sub   D             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>B-D --> carry if true
    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
    ld    A, D          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  identical signs
    sub   B             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>D-B --> carry if true
    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
    ld    A, L          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
    sub   C             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>L-C --> carry if true
    ld    A, H          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
    sbc   A, B          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>H-B --> carry if true
    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
    ld    A, E          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1
    sbc   A, C          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>E-C --> carry if true
    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
;------------------------------------------------------------------------------
; Print string ending with inverted most significant bit
; In: BC = addr string_imsb
; Out: BC = addr last_char + 1
    call  draw_char     ; 3:17      print_string_i
PRINT_STRING_I:         ;           print_string_i
    ld    A,(BC)        ; 1:7       print_string_i
    inc  BC             ; 1:6       print_string_i
    or    A             ; 1:4       print_string_i
    jp    p, $-6        ; 3:10      print_string_i
    and  0x7f           ; 2:7       print_string_i
    call  draw_char     ; 3:17      print_string_i
    ret                 ; 1:10      print_string_i
;==============================================================================
; Print text with 5x8 font
; entry point is draw_char

MAX_X           equ 51       ; x = 0..50
MAX_Y           equ 24       ; y = 0..23

set_ink:
    exx                     ; 1:4
    ld   BC,(self_attr)     ; 4:20    load origin attr

    xor   C                 ; 1:4
    and 0x07                ; 2:7  
    xor   C                 ; 1:4

    jr   clean_spec_exx     ; 2:12
    
set_paper:
    exx                     ; 1:4
    ld   BC,(self_attr)     ; 4:20    load origin attr

    add   A, A              ; 1:4     2x
    add   A, A              ; 1:4     4x
    add   A, A              ; 1:4     8x
    xor   C                 ; 1:4
    and 0x38                ; 2:7
    xor   C                 ; 1:4

    jr   clean_spec_exx     ; 2:12
    
set_flash:

    rra                     ; 1:4     carry = flash
    ld    A,(self_attr)     ; 3:13    load origin attr
    adc   A, A              ; 1:4
    rrca                    ; 1:4

    jr   clean_spec_save_A  ; 2:12
    
set_bright:

    exx                     ; 1:4
    ld   BC,(self_attr)     ; 4:20    load origin attr
    
    rrca                    ; 1:4
    rrca                    ; 1:4
    xor   C                 ; 1:4
    and 0x40                ; 2:7
    xor   C                 ; 1:4    
    
    jr   clean_spec_exx     ; 2:12
    
set_inverse:
    
    exx                     ; 1:4
    ld   BC,(self_attr)     ; 4:20

    ld    A, C              ; 1:4     inverse
    and  0x38               ; 2:7     A = 00pp p000
    add   A, A              ; 1:4
    add   A, A              ; 1:4     A = ppp0 0000
    xor   C                 ; 1:4
    and  0xF8               ; 2:7
    xor   C                 ; 1:4     A = ppp0 0iii
    rlca                    ; 1:4
    rlca                    ; 1:4
    rlca                    ; 1:4     A = 00ii ippp
    xor   C                 ; 1:4
    and  0x3F               ; 2:7
    xor   C                 ; 1:4     A = fbii ippp

clean_spec_exx:
    exx                     ; 1:4
clean_spec_save_A:
    ld  (self_attr),A       ; 3:13    save new attr
clean_spec:
    xor   A                 ; 1:4
clean_set_A:
    ld  (jump_from-1),A     ; 3:13

    ret                     ; 1:10
    

set_over:    
    
    jr   clean_spec         ; 2:12

set_at:

    ld  (self_cursor+1), A  ; 3:13    save new Y
    ld    A, $+4-jump_from  ; 2:7
    jr   clean_set_A        ; 2:12


; set_at_y:    
    
    ld  (self_cursor), A    ; 3:13    save new X
    jr   clean_spec         ; 2:12


    jr   set_ink            ; 2:12
    jr   set_paper          ; 2:12
    jr   set_flash          ; 2:12
    jr   set_bright         ; 2:12
    jr   set_inverse        ; 2:12
    jr   set_over           ; 2:12
    jr   set_at             ; 2:12
;    jr   set_tab            ; 2:12

set_tab:

    exx                     ; 1:4
    ld   BC,(self_cursor)   ; 4:20    load origin cursor

    sub  MAX_X              ; 2:7
    jr   nc,$-2             ; 2:7/12
    add   A, MAX_X          ; 2:7     (new x) mod MAX_X
    cp    C                 ; 1:4
    ld    C, A              ; 1:4
    jr   nc, $+3            ; 2:7/12  new x >= (old x+1)
    inc   B                 ; 1:4
    
    ld  (self_cursor),BC    ; 4:20    save new cursor
    exx                     ; 1:4

    jr   clean_spec         ; 2:12


;------------------------------------------------------------------------------
;  Input: A = char
; Output: DE = next char
; Poluttes: AF, AF', DE', BC'
draw_char:
    jr   jump_from          ; 2:7/12    self-modifying
jump_from:

    cp  0x20                ; 2:7
    jr   nc, print_char     ; 2:7/12

    sub  0x08               ; 2:7       left
    ret   c                 ; 1:10
    jr   nz, check_eol      ; 2:7/12

    push HL                 ; 1:11
    ld   HL,(self_cursor)   ; 3:16
    ld    A, L              ; 1:4
    dec  HL                 ; 1:6
    or    A                 ; 1:4
    jp   nz, next_exit      ; 3:10
    ld    L, MAX_X-1        ; 2:7
    jp   next_exit          ; 3:10

check_eol:
    sub  0x05               ; 2:7       eol
    ret   c                 ; 1:10
    jr   nz, draw_spec      ; 2:7/12

    push HL                 ; 1:11
    ld   HL,(self_cursor)   ; 3:16
    jp   next_line          ; 3:10

draw_spec:

    sub  0x03               ; 2:7       ZX_INK-ZX_EOL
    ret   c                 ; 1:5/11    0x00..0x0F
    add   A, 0xF9           ; 2:7       ZX_INK-ZX_TAB
    ret   c                 ; 1:5/11    0x18..0x1F
    
    add   A,A               ; 1:4       2x
    sub   jump_from-set_tab ; 2:7
    ld  (jump_from-1),A     ; 3:13
    ret                     ; 1:10
    
print_char:
    push HL                 ; 1:11    uschovat HL na zásobník
    push DE                 ; 1:11    uschovat DE na zásobník
    push BC                 ; 1:11    uschovat BC na zásobník    
    
    exx                     ; 1:4
    push HL                 ; 1:11    uschovat HL na zásobník

    ld    BC, FONT_ADR      ; 3:10    adresa, od níž začínají masky znaků

    add   A, A              ; 1:4
    ld    L, A              ; 1:4     2x
    ld    H, 0x00           ; 1:4     C je nenulové
    add  HL, HL             ; 1:11    4x
    add  HL, BC             ; 1:11    přičíst bázovou adresu masek znaků    
    exx                     ; 1:4

;# YX -> ATTR

self_cursor     equ     $+1
    ld   DE, 0x0000         ; 3:10
    ld    A, E              ; 1:4     X
    add   A, A              ; 1:4     2*X
    add   A, A              ; 1:4     4*X
    add   A, E              ; 1:4     5*X
    ld    B, A              ; 1:4     save 5*X
    
    xor   D                 ; 1:4
    and 0xF8                ; 2:7
    xor   D                 ; 1:4
    rrca                    ; 1:4
    rrca                    ; 1:4
    rrca                    ; 1:4
    ld    L, A              ; 1:4

    ld    A, D              ; 1:4   
    or  0xC7                ; 2:7     110y y111, reset carry
    rra                     ; 1:4     0110 yy11, set carry
    rrca                    ; 1:4     1011 0yy1, set carry
    ccf                     ; 1:4     reset carry
    rra                     ; 1:4     0101 10yy
    ld    H, A              ; 1:4

self_attr       equ $+1
    ld  (HL),0x38           ; 2:10    uložení atributu znaku

    ld    A, D              ; 1:4
    and 0x18                ; 2:7
    or  0x40                ; 2:7
    ld    H, A              ; 1:4
    
    ld    A, B              ; 1:4     load 5*X
    and 0x07                ; 2:7
    cpl                     ; 1:4
    add   A, 0x09           ; 2:7         
    ld    B, A              ; 2:7     pocitadlo pro pocatecni posun vlevo masky znaku
    exx                     ; 1:4
    ld    C, A              ; 1:4
    exx                     ; 1:4
    ex   DE, HL             ; 1:4
    ld   HL, 0x00F0         ; 3:10
    add  HL, HL             ; 1:11    pocatecni posun masky
    djnz  $-1               ; 2:8/13        
    ex   DE, HL             ; 1:4

    ld    C, 4              ; 2:7        
loop_c:
    exx                     ; 1:4
    ld    A,(HL)            ; 1:7
    inc  HL                 ; 1:6
    ld    B, C              ; 1:4
    rlca                    ; 1:4
    djnz  $-1               ; 2:8/13
    ld    B, A              ; 1:4
    exx                     ; 1:4
    ld    B, 2              ; 2:7        
loop_b:
    xor (HL)                ; 1:7
    and   D                 ; 1:4
    xor (HL)                ; 1:7
    ld  (HL),A              ; 1:4     ulozeni jednoho bajtu z masky

    exx                     ; 1:4
    ld    A, B              ; 1:4     načtení druhe poloviny "bajtu" z masky
    exx                     ; 1:4

    inc   L                 ; 1:4
    xor (HL)                ; 1:7
    and   E                 ; 1:4
    xor (HL)                ; 1:7
    ld  (HL),A              ; 1:4     ulozeni jednoho bajtu z masky
    dec   L                 ; 1:4
    inc   H                 ; 1:4

    exx                     ; 1:4
    ld    A, B              ; 1:4     načtení jednoho bajtu z masky
    rlca                    ; 1:4
    rlca                    ; 1:4
    rlca                    ; 1:4
    rlca                    ; 1:4
    ld    B, A              ; 1:4
    exx                     ; 1:4

;     halt
    
    djnz loop_b             ; 2:8/13
    
    dec   C                 ; 2:7        
    jr   nz, loop_c         ; 2/7/12
    
    exx                     ; 1:4
    pop  HL                 ; 1:10    obnovit obsah HL ze zásobníku
    exx                     ; 1:4

    pop  BC                 ; 1:10    obnovit obsah BC ze zásobníku
    pop  DE                 ; 1:10    obnovit obsah DE ze zásobníku    
;   fall to next cursor    


    ld   HL,(self_cursor)   ; 3:16
; Input: HL = YX
; Output: HL = cursor = next cursor
next_cursor:
    inc   L                 ; 1:4     0..50 +1 = 00..51
    ld    A, -MAX_X         ; 2:7
    add   A, L              ; 1:4
    jr   nz, next_exit      ; 2:7/12
; Input: HL = YX
; Output: H = Y+1, X=0
next_line:
    ld   HL, 0x5C88         ; 3:10
    ld  (HL), 0x01          ; 2:10          
    ld    A, ' '            ; 2:7     space and check bios scroll
    rst  0x10               ; 1:11
    ld    A, 0x18           ; 2:7
    inc   L                 ; 1:4
    sub (HL)                ; 1:7
    ld    H, A              ; 1:7
    ld    L, 0x00           ; 2:7
next_exit:
    ld  (self_cursor),HL    ; 3:16
    pop  HL                 ; 1:10    obnovit obsah HL ze zásobníku
    ret                     ; 1:10

FONT_ADR    equ     FONT_5x8-32*4
FONT_5x8:
    db %00000000,%00000000,%00000000,%00000000 ; 0x20 space
    db %00000010,%00100010,%00100000,%00100000 ; 0x21 !
    db %00000101,%01010000,%00000000,%00000000 ; 0x22 "
    db %00000000,%01011111,%01011111,%01010000 ; 0x23 #
    db %00000010,%01110110,%00110111,%00100000 ; 0x24 $
    db %00001100,%11010010,%01001011,%00110000 ; 0x25 %
    db %00000000,%11101010,%01011010,%11010000 ; 0x26 &
    db %00000011,%00010010,%00000000,%00000000 ; 0x27 '    
    db %00000010,%01000100,%01000100,%00100000 ; 0x28 (
    db %00000100,%00100010,%00100010,%01000000 ; 0x29 )
    
    db %00000000,%00001010,%01001010,%00000000 ; 0x2A *
    db %00000000,%00000100,%11100100,%00000000 ; 0x2B +
    db %00000000,%00000000,%00000010,%00100100 ; 0x2C ,
    db %00000000,%00000000,%11100000,%00000000 ; 0x2D -
    db %00000000,%00000000,%00000000,%01000000 ; 0x2E .
    db %00000000,%00010010,%01001000,%00000000 ; 0x2F /
    
    db %00000110,%10011011,%11011001,%01100000 ; 0x30 0
    db %00000010,%01100010,%00100010,%01110000 ; 0x31 1
    db %00000110,%10010001,%01101000,%11110000 ; 0x32 2
    db %00000110,%10010010,%00011001,%01100000 ; 0x33 3
    db %00000010,%01101010,%11110010,%00100000 ; 0x34 4
    db %00001111,%10001110,%00011001,%01100000 ; 0x35 5
    db %00000110,%10001110,%10011001,%01100000 ; 0x36 6
    db %00001111,%00010010,%01000100,%01000000 ; 0x37 7
    db %00000110,%10010110,%10011001,%01100000 ; 0x38 8
    db %00000110,%10011001,%01110001,%01100000 ; 0x39 9
    db %00000000,%00000010,%00000010,%00000000 ; 0x3A :
    db %00000000,%00000010,%00000010,%01000000 ; 0x3B ;
    db %00000000,%00010010,%01000010,%00010000 ; 0x3C <
    db %00000000,%00000111,%00000111,%00000000 ; 0x3D =
    db %00000000,%01000010,%00010010,%01000000 ; 0x3E >
    db %00001110,%00010010,%01000000,%01000000 ; 0x3F ?
    
    db %00000000,%01101111,%10111000,%01100000 ; 0x40 @
    db %00000110,%10011001,%11111001,%10010000 ; 0x41 A
    db %00001110,%10011110,%10011001,%11100000 ; 0x42 B
    db %00000110,%10011000,%10001001,%01100000 ; 0x43 C
    db %00001110,%10011001,%10011001,%11100000 ; 0x44 D
    db %00001111,%10001110,%10001000,%11110000 ; 0x45 E
    db %00001111,%10001110,%10001000,%10000000 ; 0x46 F
    db %00000110,%10011000,%10111001,%01110000 ; 0x47 G
    db %00001001,%10011111,%10011001,%10010000 ; 0x48 H
    db %00000111,%00100010,%00100010,%01110000 ; 0x49 I
    db %00000111,%00010001,%00011001,%01100000 ; 0x4A J
    db %00001001,%10101100,%10101001,%10010000 ; 0x4B K
    db %00001000,%10001000,%10001000,%11110000 ; 0x4C L
    db %00001001,%11111001,%10011001,%10010000 ; 0x4D M
    db %00001001,%11011011,%10011001,%10010000 ; 0x4E N
    db %00000110,%10011001,%10011001,%01100000 ; 0x4F O
    
    db %00001110,%10011001,%11101000,%10000000 ; 0x50 P
    db %00000110,%10011001,%10011010,%01010000 ; 0x51 Q
    db %00001110,%10011001,%11101001,%10010000 ; 0x52 R
    db %00000111,%10000110,%00010001,%11100000 ; 0x53 S
    db %00001111,%00100010,%00100010,%00100000 ; 0x54 T
    db %00001001,%10011001,%10011001,%01100000 ; 0x55 U
    db %00001001,%10011001,%10010101,%00100000 ; 0x56 V
    db %00001001,%10011001,%10011111,%10010000 ; 0x57 W
    db %00001001,%10010110,%10011001,%10010000 ; 0x58 X
    db %00001001,%10010101,%00100010,%00100000 ; 0x59 Y
    db %00001111,%00010010,%01001000,%11110000 ; 0x5A Z
    db %00000111,%01000100,%01000100,%01110000 ; 0x5B [
    db %00000000,%10000100,%00100001,%00000000 ; 0x5C \
    db %00001110,%00100010,%00100010,%11100000 ; 0x5D ]
    db %00000010,%01010000,%00000000,%00000000 ; 0x5E ^
    db %00000000,%00000000,%00000000,%11110000 ; 0x5F _
    
    db %00000011,%01001110,%01000100,%11110000 ; 0x60 ` GBP
    db %00000000,%01100001,%01111001,%01110000 ; 0x61 a
    db %00001000,%11101001,%10011001,%11100000 ; 0x62 b
    db %00000000,%01101001,%10001001,%01100000 ; 0x63 c
    db %00000001,%01111001,%10011001,%01110000 ; 0x64 d
    db %00000000,%01101001,%11111000,%01110000 ; 0x65 e
    db %00110100,%11100100,%01000100,%01000000 ; 0x66 f
    db %00000000,%01111001,%10010111,%00010110 ; 0x67 g
    db %00001000,%11101001,%10011001,%10010000 ; 0x68 h
    db %00100000,%01100010,%00100010,%01110000 ; 0x69 i
    db %00010000,%00110001,%00010001,%10010110 ; 0x6A j
    db %00001000,%10011010,%11001010,%10010000 ; 0x6B k
    db %00001100,%01000100,%01000100,%11100000 ; 0x6C l
    db %00000000,%11001011,%10111011,%10010000 ; 0x6D m
    db %00000000,%10101101,%10011001,%10010000 ; 0x6E n
    db %00000000,%01101001,%10011001,%01100000 ; 0x6F o
   
    db %00000000,%11101001,%10011001,%11101000 ; 0x70 p
    db %00000000,%01111001,%10011001,%01110001 ; 0x71 q
    db %00000000,%10101101,%10001000,%10000000 ; 0x72 r
    db %00000000,%01111000,%01100001,%11100000 ; 0x73 s
    db %00000100,%11100100,%01000100,%00110000 ; 0x74 t
    db %00000000,%10011001,%10011001,%01100000 ; 0x75 u
    db %00000000,%10011001,%10010101,%00100000 ; 0x76 v
    db %00000000,%10011001,%10011111,%10010000 ; 0x77 w
    db %00000000,%10011001,%01101001,%10010000 ; 0x78 x
    db %00000000,%10011001,%10010111,%00010110 ; 0x79 y
    db %00000000,%11110010,%01001000,%11110000 ; 0x7A z
    db %00010010,%00100100,%00100010,%00010000 ; 0x7B 
    db %01000100,%01000100,%01000100,%01000000 ; 0x7C |
    db %10000100,%01000010,%01000100,%10000000 ; 0x7D 
    db %00000101,%10100000,%00000000,%00000000 ; 0x7E ~
    db %00000110,%10011011,%10111001,%01100000 ; 0x7F (c)

STRING_SECTION:
string200   EQU  string122
  size200   EQU    size122
string199   EQU  string119
  size199   EQU    size119
string198   EQU  string116
  size198   EQU    size116
string197   EQU  string113
  size197   EQU    size113
string196   EQU  string110
  size196   EQU    size110
string195   EQU  string107
  size195   EQU    size107
string194   EQU  string122
  size194   EQU    size122
string193   EQU  string119
  size193   EQU    size119
string192   EQU  string116
  size192   EQU    size116
string191   EQU  string113
  size191   EQU    size113
string190   EQU  string110
  size190   EQU    size110
string189   EQU  string107
  size189   EQU    size107
string188   EQU  string122
  size188   EQU    size122
string187   EQU  string119
  size187   EQU    size119
string186   EQU  string116
  size186   EQU    size116
string185   EQU  string113
  size185   EQU    size113
string184   EQU  string110
  size184   EQU    size110
string183   EQU  string107
  size183   EQU    size107
string182   EQU  string122
  size182   EQU    size122
string181   EQU  string119
  size181   EQU    size119
string180   EQU  string116
  size180   EQU    size116
string179   EQU  string113
  size179   EQU    size113
string178   EQU  string110
  size178   EQU    size110
string177   EQU  string107
  size177   EQU    size107
string176   EQU  string122
  size176   EQU    size122
string175   EQU  string120
  size175   EQU    size120
string174   EQU  string120
  size174   EQU    size120
string173   EQU  string119
  size173   EQU    size119
string172   EQU  string117
  size172   EQU    size117
string171   EQU  string117
  size171   EQU    size117
string170   EQU  string116
  size170   EQU    size116
string169   EQU  string114
  size169   EQU    size114
string168   EQU  string114
  size168   EQU    size114
string167   EQU  string113
  size167   EQU    size113
string166   EQU  string111
  size166   EQU    size111
string165   EQU  string111
  size165   EQU    size111
string164   EQU  string110
  size164   EQU    size110
string163   EQU  string108
  size163   EQU    size108
string162   EQU  string108
  size162   EQU    size108
string161   EQU  string107
  size161   EQU    size107
string160   EQU  string105
  size160   EQU    size105
string159   EQU  string105
  size159   EQU    size105
string158   EQU  string122
  size158   EQU    size122
string157   EQU  string120
  size157   EQU    size120
string156   EQU  string120
  size156   EQU    size120
string155   EQU  string119
  size155   EQU    size119
string154   EQU  string117
  size154   EQU    size117
string153   EQU  string117
  size153   EQU    size117
string152   EQU  string116
  size152   EQU    size116
string151   EQU  string114
  size151   EQU    size114
string150   EQU  string114
  size150   EQU    size114
string149   EQU  string113
  size149   EQU    size113
string148   EQU  string111
  size148   EQU    size111
string147   EQU  string111
  size147   EQU    size111
string146   EQU  string110
  size146   EQU    size110
string145   EQU  string108
  size145   EQU    size108
string144   EQU  string108
  size144   EQU    size108
string143   EQU  string107
  size143   EQU    size107
string142   EQU  string105
  size142   EQU    size105
string141   EQU  string105
  size141   EQU    size105
string140   EQU  string122
  size140   EQU    size122
string139   EQU  string120
  size139   EQU    size120
string138   EQU  string120
  size138   EQU    size120
string137   EQU  string119
  size137   EQU    size119
string136   EQU  string117
  size136   EQU    size117
string135   EQU  string117
  size135   EQU    size117
string134   EQU  string116
  size134   EQU    size116
string133   EQU  string114
  size133   EQU    size114
string132   EQU  string114
  size132   EQU    size114
string131   EQU  string113
  size131   EQU    size113
string130   EQU  string111
  size130   EQU    size111
string129   EQU  string111
  size129   EQU    size111
string128   EQU  string110
  size128   EQU    size110
string127   EQU  string108
  size127   EQU    size108
string126   EQU  string108
  size126   EQU    size108
string125   EQU  string107
  size125   EQU    size107
string124   EQU  string105
  size124   EQU    size105
string123   EQU  string105
  size123   EQU    size105
string122:
    db ">=","," + 0x80
size122              EQU $ - string122
string121   EQU  string120
  size121   EQU    size120
string120:
    db ">","=" + 0x80
size120              EQU $ - string120
string119:
    db ">","," + 0x80
size119              EQU $ - string119
string118   EQU  string117
  size118   EQU    size117
string117:
    db ">" + 0x80
size117              EQU $ - string117
string116:
    db "<=","," + 0x80
size116              EQU $ - string116
string115   EQU  string114
  size115   EQU    size114
string114:
    db "<","=" + 0x80
size114              EQU $ - string114
string113:
    db "<","," + 0x80
size113              EQU $ - string113
string112   EQU  string111
  size112   EQU    size111
string111:
    db "<" + 0x80
size111              EQU $ - string111
string110:
    db "<>","," + 0x80
size110              EQU $ - string110
string109   EQU  string108
  size109   EQU    size108
string108:
    db "<",">" + 0x80
size108              EQU $ - string108
string107:
    db "=","," + 0x80
size107              EQU $ - string107
string106   EQU  string105
  size106   EQU    size105
string105:
    db "=" + 0x80
size105              EQU $ - string105
string104:
    db 0x0D, "R.A.S",":" + 0x80
size104              EQU $ - string104
string103:
    db 0x0D, "Data stack",":" + 0x80
size103              EQU $ - string103
string102:
    db "( d2 d1 -- ) and ( ud2 ud1 -- ):",0x0D + 0x80
size102              EQU $ - string102
string101:
    db "( x2 x1 -- ) and ( u2 u1 -- ):",0x0D + 0x80
size101              EQU $ - string101

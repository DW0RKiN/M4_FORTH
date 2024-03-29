    ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
        
    

    
    push DE             ; 1:11      print     "  unsigned 4287312975 = signed   -7654321", 0x0D
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    
    push DE             ; 1:11      pushdot(-7654321)   ( -- hi lo )
    push HL             ; 1:11      pushdot(-7654321)
    ld   DE, 0xFF8B     ; 3:10      pushdot(-7654321)   hi_word
    ld   HL, 0x344F     ; 3:10      pushdot(-7654321)   lo_word 
       
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
       
    push DE             ; 1:11      print     "test ABS: "
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, D          ; 1:4       dabs
    add   A, A          ; 1:4       dabs
    call  c, NEGATE_32  ; 3:17      dabs 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
       
    push DE             ; 1:11      print     "test ABS: "
    ld   BC, size102    ; 3:10      print     Length of string102 == string103
    ld   DE, string102  ; 3:10      print     Address of string102 == string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, D          ; 1:4       dabs
    add   A, A          ; 1:4       dabs
    call  c, NEGATE_32  ; 3:17      dabs 
    
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    
    call Check_stack    ; 3:17      scall
    
    push DE             ; 1:11      print     "  number: "
    ld   BC, size104    ; 3:10      print     Length of string104
    ld   DE, string104  ; 3:10      print     Address of string104
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    
    push DE             ; 1:11      pushdot(0x0000FFFE)   ( -- hi lo )
    push HL             ; 1:11      pushdot(0x0000FFFE)
    ld   DE, 0x0000     ; 3:10      pushdot(0x0000FFFE)   hi_word
    ld   HL, 0xFFFE     ; 3:10      pushdot(0x0000FFFE)   lo_word
      
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1+: "
    ld   BC, size105    ; 3:10      print     Length of string105
    ld   DE, string105  ; 3:10      print     Address of string105
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    inc  HL             ; 1:6       D1+   lo word
    ld    A, L          ; 1:4       D1+
    or    H             ; 1:4       D1+
    jr   nz, $+3        ; 2:7/12    D1+
    inc  DE             ; 1:6       D1+   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1+: "
    ld   BC, size105    ; 3:10      print     Length of string105 == string106
    ld   DE, string105  ; 3:10      print     Address of string105 == string106
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    inc  HL             ; 1:6       D1+   lo word
    ld    A, L          ; 1:4       D1+
    or    H             ; 1:4       D1+
    jr   nz, $+3        ; 2:7/12    D1+
    inc  DE             ; 1:6       D1+   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1+: "
    ld   BC, size105    ; 3:10      print     Length of string105 == string107
    ld   DE, string105  ; 3:10      print     Address of string105 == string107
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    inc  HL             ; 1:6       D1+   lo word
    ld    A, L          ; 1:4       D1+
    or    H             ; 1:4       D1+
    jr   nz, $+3        ; 2:7/12    D1+
    inc  DE             ; 1:6       D1+   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1-: "
    ld   BC, size108    ; 3:10      print     Length of string108
    ld   DE, string108  ; 3:10      print     Address of string108
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, L          ; 1:4       D1-   ( d -- d-1 )
    or    H             ; 1:4       D1-
    dec  HL             ; 1:6       D1-   lo word
    jr   nz, $+3        ; 2:7/12    D1-
    dec  DE             ; 1:6       D1-   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1-: "
    ld   BC, size108    ; 3:10      print     Length of string108 == string109
    ld   DE, string108  ; 3:10      print     Address of string108 == string109
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, L          ; 1:4       D1-   ( d -- d-1 )
    or    H             ; 1:4       D1-
    dec  HL             ; 1:6       D1-   lo word
    jr   nz, $+3        ; 2:7/12    D1-
    dec  DE             ; 1:6       D1-   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1-: "
    ld   BC, size108    ; 3:10      print     Length of string108 == string110
    ld   DE, string108  ; 3:10      print     Address of string108 == string110
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, L          ; 1:4       D1-   ( d -- d-1 )
    or    H             ; 1:4       D1-
    dec  HL             ; 1:6       D1-   lo word
    jr   nz, $+3        ; 2:7/12    D1-
    dec  DE             ; 1:6       D1-   hi word 
    
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A    

    
    call Check_stack    ; 3:17      scall
    
    push DE             ; 1:11      print     "  number: "
    ld   BC, size104    ; 3:10      print     Length of string104 == string111
    ld   DE, string104  ; 3:10      print     Address of string104 == string111
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    
    push DE             ; 1:11      pushdot(0xFFFFFFFE)   ( -- hi lo )
    push HL             ; 1:11      pushdot(0xFFFFFFFE)
    ld   HL, 0xFFFE     ; 3:10      pushdot(0xFFFFFFFE)   lo_word
    ld    E, H          ; 1:4       pushdot(0xFFFFFFFE)
    ld    D, H          ; 1:4       pushdot(0xFFFFFFFE)   hi word
      
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1+: "
    ld   BC, size105    ; 3:10      print     Length of string105 == string112
    ld   DE, string105  ; 3:10      print     Address of string105 == string112
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    inc  HL             ; 1:6       D1+   lo word
    ld    A, L          ; 1:4       D1+
    or    H             ; 1:4       D1+
    jr   nz, $+3        ; 2:7/12    D1+
    inc  DE             ; 1:6       D1+   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1+: "
    ld   BC, size105    ; 3:10      print     Length of string105 == string113
    ld   DE, string105  ; 3:10      print     Address of string105 == string113
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    inc  HL             ; 1:6       D1+   lo word
    ld    A, L          ; 1:4       D1+
    or    H             ; 1:4       D1+
    jr   nz, $+3        ; 2:7/12    D1+
    inc  DE             ; 1:6       D1+   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1+: "
    ld   BC, size105    ; 3:10      print     Length of string105 == string114
    ld   DE, string105  ; 3:10      print     Address of string105 == string114
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    inc  HL             ; 1:6       D1+   lo word
    ld    A, L          ; 1:4       D1+
    or    H             ; 1:4       D1+
    jr   nz, $+3        ; 2:7/12    D1+
    inc  DE             ; 1:6       D1+   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1-: "
    ld   BC, size108    ; 3:10      print     Length of string108 == string115
    ld   DE, string108  ; 3:10      print     Address of string108 == string115
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, L          ; 1:4       D1-   ( d -- d-1 )
    or    H             ; 1:4       D1-
    dec  HL             ; 1:6       D1-   lo word
    jr   nz, $+3        ; 2:7/12    D1-
    dec  DE             ; 1:6       D1-   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1-: "
    ld   BC, size108    ; 3:10      print     Length of string108 == string116
    ld   DE, string108  ; 3:10      print     Address of string108 == string116
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, L          ; 1:4       D1-   ( d -- d-1 )
    or    H             ; 1:4       D1-
    dec  HL             ; 1:6       D1-   lo word
    jr   nz, $+3        ; 2:7/12    D1-
    dec  DE             ; 1:6       D1-   hi word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D1-: "
    ld   BC, size108    ; 3:10      print     Length of string108 == string117
    ld   DE, string108  ; 3:10      print     Address of string108 == string117
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, L          ; 1:4       D1-   ( d -- d-1 )
    or    H             ; 1:4       D1-
    dec  HL             ; 1:6       D1-   lo word
    jr   nz, $+3        ; 2:7/12    D1-
    dec  DE             ; 1:6       D1-   hi word 
    
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A    
    
    
    call Check_stack    ; 3:17      scall
    
    push DE             ; 1:11      print     "test D+:"
    ld   BC, size118    ; 3:10      print     Length of string118
    ld   DE, string118  ; 3:10      print     Address of string118
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      pushdot(0)   ( -- hi lo )
    push HL             ; 1:11      pushdot(0)
    ld   HL, 0x0000     ; 3:10      pushdot(0)   lo_word
    ld    E, L          ; 1:4       pushdot(0)
    ld    D, L          ; 1:4       pushdot(0)   hi word 
           
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '+'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+ 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
    push DE             ; 1:11      print     "test D-:"
    ld   BC, size119    ; 3:10      print     Length of string119
    ld   DE, string119  ; 3:10      print     Address of string119
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
           
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    push DE             ; 1:11      pushdot(111111111)   ( -- hi lo )
    push HL             ; 1:11      pushdot(111111111)
    ld   DE, 0x069F     ; 3:10      pushdot(111111111)   hi_word
    ld   HL, 0x6BC7     ; 3:10      pushdot(111111111)   lo_word 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRT_U32        ; 3:17      ud.   ( ud -- )  
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D- 
    
    call PRT_U32        ; 3:17      ud.   ( ud -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    call Check_stack    ; 3:17      scall
    
    
    push DE             ; 1:11      print     "test dmin, dmax, dnegate", 0x0D
    ld   BC, size120    ; 3:10      print     Length of string120
    ld   DE, string120  ; 3:10      print     Address of string120
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      pushdot(0x00010002)   ( -- hi lo )
    push HL             ; 1:11      pushdot(0x00010002)
    ld   DE, 0x0001     ; 3:10      pushdot(0x00010002)   hi_word
    ld   HL, 0x0002     ; 3:10      pushdot(0x00010002)   lo_word
    
    push DE             ; 1:11      pushdot(0x00010001)   ( -- hi lo )
    push HL             ; 1:11      pushdot(0x00010001)
    ld   HL, 0x0001     ; 3:10      pushdot(0x00010001)   lo_word
    ld    E, L          ; 1:4       pushdot(0x00010001)
    ld    D, H          ; 1:4       pushdot(0x00010001)   hi word
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string122
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string123
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string124
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax 
    ld   BC, string125  ; 3:10      print_z   Address of null-terminated string125
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax 
    ld   BC, string125  ; 3:10      print_z   Address of null-terminated string125 == string126
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax 
    ld   BC, string125  ; 3:10      print_z   Address of null-terminated string125 == string127
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax 
    ld   BC, string125  ; 3:10      print_z   Address of null-terminated string125 == string128
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )
    
    call Check_stack    ; 3:17      scall

    
    push DE             ; 1:11      print     "test dmin, dmax, dnegate", 0x0D
    ld   BC, size120    ; 3:10      print     Length of string120 == string129
    ld   DE, string120  ; 3:10      print     Address of string120 == string129
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      pushdot(500000)   ( -- hi lo )
    push HL             ; 1:11      pushdot(500000)
    ld   DE, 0x0007     ; 3:10      pushdot(500000)   hi_word
    ld   HL, 0xA120     ; 3:10      pushdot(500000)   lo_word
    
    push DE             ; 1:11      pushdot(100000)   ( -- hi lo )
    push HL             ; 1:11      pushdot(100000)
    ld   DE, 0x0001     ; 3:10      pushdot(100000)   hi_word
    ld   HL, 0x86A0     ; 3:10      pushdot(100000)   lo_word
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string130
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string131
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string132
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string133
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax 
    ld   BC, string125  ; 3:10      print_z   Address of null-terminated string125 == string134
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax 
    ld   BC, string125  ; 3:10      print_z   Address of null-terminated string125 == string135
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax 
    ld   BC, string125  ; 3:10      print_z   Address of null-terminated string125 == string136
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate 
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    call PRT_SP_S32     ; 3:17      space d.   ( d -- ) 
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax 
    ld   BC, string125  ; 3:10      print_z   Address of null-terminated string125 == string137
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S32        ; 3:17      d.   ( d -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )
    
    call Check_stack    ; 3:17      scall

    
    ex   DE, HL         ; 1:4       __ras   ( -- return_address_stack )
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    pop  HL             ; 1:10      __ras
    
    ld   BC, string138  ; 3:10      print_z   Address of null-terminated string138
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_U16        ; 3:17      u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    call Check_stack    ; 3:17      scall
    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
    

;   ---  the beginning of a non-recursive function  ---
Check_stack:            ;           
    pop  BC             ; 1:10      : ret
    ld  (Check_stack_end+1),BC; 4:20      : ( ret -- )
    
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
    
    ld   BC, string139  ; 3:10      print_z   Address of null-terminated string139
    call PRINT_STRING_Z ; 3:17      print_z

Check_stack_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;==============================================================================
; ( hi lo -- )
; Input: DEHL
; Output: Print space and signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_SP_S32:             ;           prt_sp_s32
    ld    A, ' '        ; 2:7       prt_sp_s32   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_sp_s32   putchar(reg A) with ZX 48K ROM
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
    ld    A, '-'        ; 2:7       prt_s32   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_s32   putchar(reg A) with ZX 48K ROM
    call NEGATE_32      ; 3:17      prt_s32
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
    rst  0x10           ; 1:11      bin32_dec   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '0'        ; 2:7       bin32_dec   reset A to '0'
    ret                 ; 1:10      bin32_dec
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
; ( 5 3 -- 5 )
; ( -5 -3 -- -3 )
; ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_max HL:lo_max )
MAX_32:                ;[21:104/129]max_32   ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_max HL:lo_max )
    push AF             ; 1:11      max_32   BC = lo_2
    ld    A, L          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    sub   C             ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    ld    A, H          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    sbc   A, B          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    ex  (SP),HL         ; 1:19      max_32   HL = hi_2
    ld    A, E          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    sbc   A, L          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    ld    A, D          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    sbc   A, H          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    rra                 ; 1:4       max_32   carry --> sign
    xor   H             ; 1:4       max_32
    xor   D             ; 1:4       max_32
    jp    p, $+6        ; 3:10      max_32
    ex   DE, HL         ; 1:4       max_32   DE = hi_2
    pop  HL             ; 1:10      max_32   removing lo_1 from the stack
    push BC             ; 1:11      max_32
    pop  HL             ; 1:10      max_32
    ret                 ; 1:10      max_32
;==============================================================================
; ( 5 3 -- 3 )
; ( -5 -3 -- -5 )
; ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_min HL:lo_min )
MIN_32:                ;[21:104/129]min_32   ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_min HL:lo_min )
    push AF             ; 1:11      min_32   BC = lo_2
    ld    A, C          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    sub   L             ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    ld    A, B          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    sbc   A, H          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    ex  (SP),HL         ; 1:19      min_32   HL = hi_2
    ld    A, L          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    sbc   A, E          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    ld    A, H          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    sbc   A, D          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    rra                 ; 1:4       min_32   carry --> sign
    xor   H             ; 1:4       min_32
    xor   D             ; 1:4       min_32
    jp    p, $+6        ; 3:10      min_32
    ex   DE, HL         ; 1:4       min_32   DE = hi_2
    pop  HL             ; 1:10      min_32   removing lo_1 from the stack
    push BC             ; 1:11      min_32
    pop  HL             ; 1:10      min_32
    ret                 ; 1:10      min_32
;==============================================================================
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst  0x10           ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z

STRING_SECTION:
string139:
db " values in data stack", 0x0D, 0x00
size139 EQU $ - string139
string138:
db "RAS: ", 0x00
size138 EQU $ - string138
string125:
db " max", 0x00
size125 EQU $ - string125
string121:
db " min", 0x00
size121 EQU $ - string121
string120:
db "test dmin, dmax, dnegate", 0x0D
size120 EQU $ - string120
string119:
db "test D-:"
size119 EQU $ - string119
string118:
db "test D+:"
size118 EQU $ - string118
string108:
db "test D1-: "
size108 EQU $ - string108
string105:
db "test D1+: "
size105 EQU $ - string105
string104:
db "  number: "
size104 EQU $ - string104
string102:
db "test ABS: "
size102 EQU $ - string102
string101:
db "  unsigned 4287312975 = signed   -7654321", 0x0D
size101 EQU $ - string101

VARIABLE_SECTION:

A_32:                   ; = 0x87432110 = -2025643760 = db 0x10 0x21 0x43 0x87
  dw 0x2110             ; = 8464
  dw 0x8743             ; = 34627

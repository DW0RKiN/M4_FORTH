; vvvvv
; ^^^^^
;# log10(2^n) = y
;# 10^y = 2^n
;# log10(2^n)=n*log10(2)
;# 10^(n*log10(2)) = 2^n
;# m*2^n = m*10^(n*log10(2)) = m*10^(int+mod) = m * 10^int * 10^mod = m * 10^mod * Eint = 1 .. 1.9 10^mod * Eint = 1.0 .. 19.99 Eint

ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    ld  hl, stack_test
    push hl

    
    push DE             ; 1:11      push2(0x4000,49)
    ld   DE, 0x4000     ; 3:10      push2(0x4000,49)
    push HL             ; 1:11      push2(0x4000,49)
    ld   HL, 49         ; 3:10      push2(0x4000,49)
    
sfor101:                ;           sfor 101 ( index -- index )
        
    ex   DE, HL         ; 1:4       swap ( b a -- a b )
        
    push DE             ; 1:11      push(0x4100)
    ex   DE, HL         ; 1:4       push(0x4100)
    ld   HL, 0x4100     ; 3:10      push(0x4100)
        
    ld    B, D          ; 1:4       f/
    ld    C, E          ; 1:4       f/
    call fDiv           ; 3:17      f/ HL = BC/HL
    pop  DE             ; 1:10      f/
        
    ex   DE, HL         ; 1:4       swap ( b a -- a b )
    
    ld   A, H           ; 1:4       snext 101
    or   L              ; 1:4       snext 101
    dec  HL             ; 1:6       snext 101 index--
    jp  nz, sfor101     ; 3:10      snext 101
snext101:               ;           snext 101
    ex   DE, HL         ; 1:4       sfor unloop 101
    pop  DE             ; 1:10      sfor unloop 101
    
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(0x4000,0x4100)
    ld   DE, 0x4000     ; 3:10      push2(0x4000,0x4100)
    push HL             ; 1:11      push2(0x4000,0x4100)
    ld   HL, 0x4100     ; 3:10      push2(0x4000,0x4100)
    
    call fAdd           ; 3:17      f+
    pop  DE             ; 1:10      f+ 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(0x4000,0x4100)
    ld   DE, 0x4000     ; 3:10      push2(0x4000,0x4100)
    push HL             ; 1:11      push2(0x4000,0x4100)
    ld   HL, 0x4100     ; 3:10      push2(0x4000,0x4100)
    
    call fSub           ; 3:17      f-
    pop  DE             ; 1:10      f- 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    
    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call fIld           ; 3:17      s>f 
    call fDot           ; 3:17      f. 
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fIld           ; 3:17      s>f 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(-3,3)
    ld   DE, -3         ; 3:10      push2(-3,3)
    push HL             ; 1:11      push2(-3,3)
    ld   HL, 3          ; 3:10      push2(-3,3) 
    call fIld           ; 3:17      s>f 
    call fDot           ; 3:17      f. 
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fIld           ; 3:17      s>f 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(-503,503)
    ld   DE, -503       ; 3:10      push2(-503,503)
    push HL             ; 1:11      push2(-503,503)
    ld   HL, 503        ; 3:10      push2(-503,503) 
    call fIld           ; 3:17      s>f 
    call fDot           ; 3:17      f. 
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fIld           ; 3:17      s>f 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(-512,512)
    ld   DE, -512       ; 3:10      push2(-512,512)
    push HL             ; 1:11      push2(-512,512)
    ld   HL, 512        ; 3:10      push2(-512,512) 
    call fIld           ; 3:17      s>f 
    call fDot           ; 3:17      f. 
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fIld           ; 3:17      s>f 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    push DE             ; 1:11      push(0x7FFF )
    ex   DE, HL         ; 1:4       push(0x7FFF )
    ld   HL, 0x7FFF     ; 3:10      push(0x7FFF ) 
sfor102:                ;           sfor 102 ( index -- index ) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fIld           ; 3:17      s>f 
    push DE             ; 1:11      push(20224)
    ex   DE, HL         ; 1:4       push(20224)
    ld   HL, 20224      ; 3:10      push(20224) 
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <> 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    jp   snext102       ; 3:10      sfor leave 102 
else101  EQU $          ;           = endif
endif101: 
    ld   A, H           ; 1:4       snext 102
    or   L              ; 1:4       snext 102
    dec  HL             ; 1:6       snext 102 index--
    jp  nz, sfor102     ; 3:10      snext 102
snext102:               ;           snext 102
    ex   DE, HL         ; 1:4       sfor unloop 102
    pop  DE             ; 1:10      sfor unloop 102
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    push DE             ; 1:11      push(0x0000 )
    ex   DE, HL         ; 1:4       push(0x0000 )
    ld   HL, 0x0000     ; 3:10      push(0x0000 ) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x3c9a)
    ex   DE, HL         ; 1:4       push(0x3c9a)
    ld   HL, 0x3c9a     ; 3:10      push(0x3c9a) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x3f00)
    ex   DE, HL         ; 1:4       push(0x3f00)
    ld   HL, 0x3f00     ; 3:10      push(0x3f00) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x3f9a)
    ex   DE, HL         ; 1:4       push(0x3f9a)
    ld   HL, 0x3f9a     ; 3:10      push(0x3f9a) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x4000)
    ex   DE, HL         ; 1:4       push(0x4000)
    ld   HL, 0x4000     ; 3:10      push(0x4000) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x4080)
    ex   DE, HL         ; 1:4       push(0x4080)
    ld   HL, 0x4080     ; 3:10      push(0x4080) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0xbc9a)
    ex   DE, HL         ; 1:4       push(0xbc9a)
    ld   HL, 0xbc9a     ; 3:10      push(0xbc9a) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0xbf00)
    ex   DE, HL         ; 1:4       push(0xbf00)
    ld   HL, 0xbf00     ; 3:10      push(0xbf00) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0xbf9a)
    ex   DE, HL         ; 1:4       push(0xbf9a)
    ld   HL, 0xbf9a     ; 3:10      push(0xbf9a) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0xc000)
    ex   DE, HL         ; 1:4       push(0xc000)
    ld   HL, 0xc000     ; 3:10      push(0xc000) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size110    ; 3:10      print Length of string to print
    ld   DE, string110  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0xc080)
    ex   DE, HL         ; 1:4       push(0xc080)
    ld   HL, 0xc080     ; 3:10      push(0xc080) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size111    ; 3:10      print Length of string to print
    ld   DE, string111  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    
    push DE             ; 1:11      push(5)
    ex   DE, HL         ; 1:4       push(5)
    ld   HL, 5          ; 3:10      push(5)   
    call fIld           ; 3:17      s>f 
    call fSqrt          ; 3:17      fsqrt 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size112    ; 3:10      print Length of string to print
    ld   DE, string112  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fexp
    call fExp           ; 3:17      fexp HL = e^HL
    pop  DE             ; 1:10      fexp 
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(5)
    ex   DE, HL         ; 1:4       push(5)
    ld   HL, 5          ; 3:10      push(5)   
    call fIld           ; 3:17      s>f 
    call fSqrt          ; 3:17      fsqrt 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size113    ; 3:10      print Length of string to print
    ld   DE, string113  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push DE             ; 1:11      fln
    call fLn            ; 3:17      fln HL = ln(HL)
    pop  DE             ; 1:10      fln  
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(5,3)
    ld   DE, 5          ; 3:10      push2(5,3)
    push HL             ; 1:11      push2(5,3)
    ld   HL, 3          ; 3:10      push2(5,3) 
    call fIld           ; 3:17      s>f 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size114    ; 3:10      print Length of string to print
    ld   DE, string114  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    call fIld           ; 3:17      s>f 
    call fSqrt          ; 3:17      fsqrt 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      print
    ld   BC, size115    ; 3:10      print Length of string to print
    ld   DE, string115  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    B, D          ; 1:4       fmod
    ld    C, E          ; 1:4       fmod
    call fMod           ; 3:17      fmod HL = BC % HL
    pop  DE             ; 1:10      fmod  
    call fDot           ; 3:17      f. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call test           ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    push DE             ; 1:11      push(5)
    ex   DE, HL         ; 1:4       push(5)
    ld   HL, 5          ; 3:10      push(5) 
    call test           ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
    call test           ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    push DE             ; 1:11      push(8)
    ex   DE, HL         ; 1:4       push(8)
    ld   HL, 8          ; 3:10      push(8) 
    call test           ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    push DE             ; 1:11      push(15)
    ex   DE, HL         ; 1:4       push(15)
    ld   HL, 15         ; 3:10      push(15) 
    call test           ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    

    ld   BC, 0          ; 3:10      xdo(65535,0 ) 103
    ld  (idx103),BC     ; 4:20      xdo(65535,0 ) 103
xdo103:                 ;           xdo(65535,0 ) 103 
    push DE             ; 1:11      index xi 103
    ex   DE, HL         ; 1:4       index xi 103
    ld   HL, (idx103)   ; 3:16      index xi 103 idx always points to a 16-bit index 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, H          ; 1:4       fnegate
    xor  0x80           ; 2:7       fnegate
    ld    H, A          ; 1:4       fnegate 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    call fSqrt          ; 3:17      fsqrt 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    push HL             ; 1:11      777 +xloop 103
idx103 EQU $+1          ;           777 +xloop 103
    ld   HL, 0x0000     ; 3:10      777 +xloop 103
    ld   BC, 777        ; 3:10      777 +xloop 103 BC = step
    add  HL, BC         ; 1:11      777 +xloop 103 HL = index+step
    ld  (idx103), HL    ; 3:16      777 +xloop 103 save index
    ld    A, low 65534  ; 2:7       777 +xloop 103
    sub   L             ; 1:4       777 +xloop 103
    ld    L, A          ; 1:4       777 +xloop 103
    ld    A, high 65534 ; 2:7       777 +xloop 103
    sbc   A, H          ; 1:4       777 +xloop 103
    ld    H, A          ; 1:4       777 +xloop 103 HL = stop-(index+step)
    add  HL, BC         ; 1:11      777 +xloop 103 HL = stop-index
    pop  HL             ; 1:10      777 +xloop 103
    jp   nc, xdo103     ; 3:10      777 +xloop 103 positive step
xleave103:              ;           777 +xloop 103
xexit103:               ;           777 +xloop 103
    
    
    push DE             ; 1:11      push(32736 )
    ex   DE, HL         ; 1:4       push(32736 )
    ld   HL, 32736      ; 3:10      push(32736 ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f         
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(32737 )
    ex   DE, HL         ; 1:4       push(32737 )
    ld   HL, 32737      ; 3:10      push(32737 ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f         
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x7FFF)
    ex   DE, HL         ; 1:4       push(0x7FFF)
    ld   HL, 0x7FFF     ; 3:10      push(0x7FFF) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f         
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x8000)
    ex   DE, HL         ; 1:4       push(0x8000)
    ld   HL, 0x8000     ; 3:10      push(0x8000) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f         
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    
    push DE             ; 1:11      push(32736 )
    ex   DE, HL         ; 1:4       push(32736 )
    ld   HL, 32736      ; 3:10      push(32736 ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f 
    ld    A, H          ; 1:4       fnegate
    xor  0x80           ; 2:7       fnegate
    ld    H, A          ; 1:4       fnegate 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(32737 )
    ex   DE, HL         ; 1:4       push(32737 )
    ld   HL, 32737      ; 3:10      push(32737 ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f 
    ld    A, H          ; 1:4       fnegate
    xor  0x80           ; 2:7       fnegate
    ld    H, A          ; 1:4       fnegate 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x7FFF)
    ex   DE, HL         ; 1:4       push(0x7FFF)
    ld   HL, 0x7FFF     ; 3:10      push(0x7FFF) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f 
    ld    A, H          ; 1:4       fnegate
    xor  0x80           ; 2:7       fnegate
    ld    H, A          ; 1:4       fnegate 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(0x8000)
    ex   DE, HL         ; 1:4       push(0x8000)
    ld   HL, 0x8000     ; 3:10      push(0x8000) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call fWld           ; 3:17      u>f 
    ld    A, H          ; 1:4       fnegate
    xor  0x80           ; 2:7       fnegate
    ld    H, A          ; 1:4       fnegate 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    call fIst           ; 3:17      f>s 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    push DE             ; 1:11      push(0x8000)
    ex   DE, HL         ; 1:4       push(0x8000)
    ld   HL, 0x8000     ; 3:10      push(0x8000) 
    call fIld           ; 3:17      s>f 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    call fWst           ; 3:17      f>u 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    

    
    
    push DE             ; 1:11      print
    ld   BC, size116    ; 3:10      print Length of string to print
    ld   DE, string116  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    exx
    push HL
    exx
    pop  HL
    
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1    
    ret
    

;   ---  the beginning of a data stack function  ---
test:                   ;           
    
    call fIld           ; 3:17      s>f 
    call fSqrt          ; 3:17      fsqrt 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    call fFrac          ; 3:17      ffrac 
    ld    A, ':'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fDot           ; 3:17      f. 
    call fIst           ; 3:17      f>s 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

test_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------

    

;   ---  the beginning of a data stack function  ---
stack_test:             ;           
    
    push DE             ; 1:11      print
    ld   BC, size117    ; 3:10      print Length of string to print
    ld   DE, string117  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====

stack_test_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------

; Remainder after division
;  In: BC dividend, HL modulus
; Out: HL = BC % HL = BC - int(BC/HL) * HL = frac(BC/HL) * HL  => does not return correct results with larger exponent difference
; Pollutes: AF, BC, DE
; *****************************************
                    fMod                ; *
; *****************************************

    res   7, H          ; 2:8       HL = abs(HL), exp HL will be used for the result
    ld    A, B          ; 1:4 
    and  0x80           ; 2:7       sign mask
    ld    D, A          ; 1:4       Result sign only
    xor   B             ; 1:4 
    sub   H             ; 1:4 
    jr    c, fMod_HL_GR ; 2:12/7 
    ld    E, A          ; 1:4       diff exp        
    ld    A, C          ; 1:4  
    jr   nz, fMod_Sub   ; 2:12/7 
        
    cp    L             ; 1:4 
    jr    z, fMod_FPmin ; 2:12/7 
    jr    c, fMod_HL_GR ; 2:12/7 

fMod_Sub:               ;           BC_mantis - HL_mantis
    sub   L             ; 1:4 
    jr    z, fMod_FPmin ; 2:7/11    fpmin
    jr   nc, fMod_NORM  ; 2:7/11 
        
; fMod_Add_HALF:           
    dec   E             ; 1:4        
    jp    m, fMod_STOP  ; 3:10 
        
    add   A, A          ; 1:4 
    jr   nc, fMod_X     ; 2:7/11 
    add   A, L          ; 1:4 
    jr    c, fMod_Sub   ; 2:7/11 
    db   0x06           ;           ld B, $85
fMod_X:
    add   A, L          ; 1:4 
        
fMod_NORM:
    add   A, A          ; 1:4 
    dec   E             ; 1:4        
    jr   nc, fMod_NORM  ; 2:7/11 
        
    jp    p, fMod_Sub   ; 3:10      E >= 0

    ld    L, A          ; 1:4 
    ld    A, H          ; 1:4 
    add   A, E          ; 1:4 
    xor   D             ; 1:4 
    ld    H, A          ; 1:4 
    xor   D             ; 1:4 
    ret   p             ; 1:5/11 
;       fall

; Input: D = sign only        
fMod_UNDERFLOW:
    ld    H, D          ; 1:4 
    ld    L, 0x00       ; 2:7 
    scf                 ; 1:4       carry = error
    ret                 ; 1:10 
        
fMod_STOP:
    add   A, L          ; 1:4 
    ld    L, A          ; 1:4 
    ld    A, H          ; 1:4 
    xor   D             ; 1:4 
    ld    H, A          ; 1:4 
    ret                 ; 1:10 
        
fMod_HL_GR:
    or    A             ; 1:4
    ld    H, B          ; 1:4 
    ld    L, C          ; 1:4 
    ret                 ; 1:10 

fMod_FPmin:             ;           RET with reset carry
    ld    L, 0x00       ; 2:7 
    ld    H, D          ; 1:4 
    ret                 ; 1:10
; Fractional part, remainder after division by 1
;  In: HL any floating-point number
; Out: HL fractional part, with sign intact
; Pollutes: AF, B
; *****************************************
                    fFrac                ; *
; *****************************************
    ld    A, H          ; 1:4 
    and  0x7F           ; 2:7       delete sign
    cp   0x48           ; 2:7       bias + mant bits
    jr   nc, fFrac_ZERO ; 2:7/12    Already integer
    sub  0x40           ; 2:7       bias 
    ret   c             ; 1:5/11    Pure fraction

    inc   A             ; 1:4       2^0*1.xxx > 1
    ld    B, A          ; 1:4 
    ld    A, L          ; 2:7 
fFrac_Loop:             ;           odmazani mantisy pred plovouci radovou carkou
    dec   H             ; 1:4 
    add   A, A          ; 1:4 
    djnz fFrac_Loop     ; 2:13/8 

    ld    L, A          ; 1:4 
    ret   c             ; 1:11/5 
 
    jr    z, fFrac_ZERO ; 2:7/12

fFrac_Norm:             ;           normalizace cisla
    dec   H             ; 1:4 
    add   A, A          ; 1:4 
    jr   nc, fFrac_Norm ; 2:12/7 

    ld    L, A          ; 1:4 
    ret                 ; 1:10 

fFrac_ZERO:
    ld    HL, 0x0000    ; 3:10      fpmin
    ret                 ; 1:10
; ( f1 -- f2 )
; (2^+3 * mantisa)^0.5 = 2^+1 * 2^+0.5 * mantisa^0.5 = 2^+1 * 2^+0.5 ...
; *****************************************
                    fSqrt                 ; *
; *****************************************
    ld    A, H          ; 1:4 
    and  0x7F           ; 2:7       abs(HL)
    add   A, 0x40       ; 2:7 
    rra                 ; 1:4       A = (exp-bias)/2 + bias = (exp+bias)/2
                        ;           carry => out = out * 2^0.5
    ld    H, SQR_TAB/256; 2:7 
    jr   nc, fSqrt1     ; 2:12/7 
    inc   H             ; 1:4
    or    A             ; 1:4       RET with reset carry
fSqrt1:
    ld    L, (HL)       ; 1:7 
    ld    H, A          ; 1:4 
    ret                 ; 1:10 

; Load Integer. Convert signed 16-bit integer into floating-point number
;  In: HL = Integer to convert
; Out: HL = floating point representation
; Pollutes: AF
; *****************************************
                    fIld                ; *
; *****************************************
    bit   7, H          ; 2:8
    jr    z, fWld       ; 2:7/12
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4
    ld    A, 0xD0       ; 2:7       sign+bias+16
    jr   nz, fWld_NORM  ; 2:7/12

    ld    H, 0xC8       ; 2:7       sign+bias+8
    ld    A, L          ; 1:4
    jp    fWld_B_NORM   ; 3:10
; Load Word. Convert unsigned 16-bit integer into floating-point number
;  In: HL = Word to convert
; Out: HL = floating point representation
; Pollutes: AF
; *****************************************
                    fWld                ; *
; *****************************************
    ld    A, H          ; 1:4       HL = xxxx xxxx xxxx xxxx 
    or    A             ; 1:4 
    jr    z, fWld_B     ; 2:12/7 
    ld    A, 0x50       ; 2:7       bias+16
fWld_NORM:
    add  HL, HL         ; 1:11 
    dec   A             ; 1:4 
    jp   nc, fWld_NORM  ; 3:10        
        
    sla   L             ; 2:8       rounding
    ld    L, H          ; 1:4 
    ld    H, A          ; 1:4 
    ret   nc            ; 1:11/5 
    ccf                 ; 1:4 
    ret   z             ; 1:11/5 
    inc   L             ; 1:4       rounding up
    ret   nz            ; 1:11/5 
    inc   H             ; 1:4       exp++
    ret                 ; 1:10 
        
fWld_B:                 ;           HL = 0000 0000 xxxx xxxx
    or    L             ; 1:4 
    ret   z             ; 1:5/11 
                
    ld    H, 0x48       ; 2:7       bias+8
fWld_B_NORM:
    dec   H             ; 1:4 
    add   A, A          ; 1:4 
    jr   nc, fWld_B_NORM; 2:12/7 

    ld    L, A          ; 1:4 
    ret                 ; 1:10
; Store Integer. Convert value of a floating-point number into signed 16-bit integer.
;  In: HL = floating point to convert
; Out: HL = Int representation, ??? carry if overflow
; Pollutes: AF, B
; *****************************************
                    fIst                ; *
; *****************************************
    ld    A, H          ; 1:4
    cp   0x4F           ; 2:7
    jr    c, fWst       ; 2:7/12
    
    add   A, A          ; 1:4
    jr   nc, fIst_OVER_P; 2:7/11
    
    rrca                ; 1:4
    add  A, 0xB1        ; 2:7
    jr    c, fIst_OVER_N; 2:7/12
    
    call fWst           ; 3:17
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10
    
    
fIst_OVER_N:
    ld   HL, 0x8000     ; 3:10
    ret                 ; 1:10
    
fIst_OVER_P:
    ld   HL, 0x7FFF     ; 3:10
    scf                 ; 1:4
    ret                 ; 1:10

; Store Word. Convert absolute value of a floating-point number into unsigned 16-bit integer.
;  In: HL = floating point to convert
; Out: HL = Word representation, set carry if overflow
; Pollutes: AF, B
; *****************************************
                    fWst                ; *
; *****************************************
    ld    A, H          ; 1:4 
    and  0x7F           ; 2:7       exp mask 
        
    cp   0x50           ; 2:7       bias + 0x10
    jr   nc, fWst_OVER  ; 2:7/12 

    sub  0x3F           ; 2:7       bias - 1
    jr    c, fWst_ZERO  ; 2:7/12 
                        ;           A = 0..16
    if 0

    ld    B, A          ; 1:4 
    ld    A, L          ; 1:4 
    ld    HL, 0x0000    ; 3:10 
    jr    z, fWst_Round ; 2:7/12 
    scf                 ; 1:4 
        
    adc  HL, HL         ; 2:15 
    add   A, A          ; 1:4 
    djnz $-3            ; 2:13/8 

    ret   nc            ; 1:11/5 
fWst_Round:        
    or    A             ; 1:4 
    ret   z             ; 1:11/5 
    inc   HL            ; 1:6 
    ret                 ; 1:10 
        
    else
    
    ld    H, 0x01       ; 2:7 
    sub  0x09           ; 2:7 
    jr   nc, fWst256Plus; 2:7 
        
    dec   HL            ; 1:6       rounding ( 0.5000 down => 0.4999 down )
    srl   H             ; 2:8 
    rr    L             ; 2:8 
    inc   A             ; 1:4 
    jr    z, $+7        ; 2:12/7 
    srl   L             ; 2:8 
    inc   A             ; 1:4 
    jr   nz, $-3        ; 2:12/7 
    ret   nc            ; 1:11/5 
    inc   L             ; 1:4
    or    A             ; 1:4
    ret                 ; 1:10 

fWst256Plus:
    ret   z             ; 1:5/11 
    ld    B, A          ; 1:4 
    add  HL, HL         ; 1:11 
    djnz $-1            ; 2:13/8 
    ret                 ; 1:10 
    
    endif
    
fWst_OVER:
    ld    HL, 0xFFFF    ; 3:10
    scf                 ; 1:4
    ret                 ; 1:10      RET with carry

fWst_ZERO:
    xor   A             ; 1:4 
    ld    H, A          ; 1:4 
    ld    L, A          ; 1:4
    ret                 ; 1:10      RET with carry
        ; continue from @
    ld    B, D          ; 1:4       fmod
    ld    C, E          ; 1:4       fmod
    call fMod           ; 3:17      fmod HL = BC % HL
    pop  DE             ; 1:10      fmod (if it was included)
; Subtract two floating-point numbers
;  In: HL, DE numbers to subtract, no restrictions
; Out: HL = DE - HL
; Pollutes: AF, B, DE
; *****************************************
                    fSub                ; *
; *****************************************
    ld    A, H          ; 1:4
    xor  0x80           ; 2:7       sign mask       
    ld    H, A          ; 1:4       HL = -HL
    ; continue

; Add two floating-point numbers
;  In: HL, DE numbers to add, no restrictions
; Out: HL = DE + HL
; Pollutes: AF, B, DE
; *****************************************
                    fAdd                ; *
; *****************************************
    ld    A, H          ; 1:4
    xor   D             ; 1:4
    jp    m, fAdd_OP_SGN; 3:10
    ; continue
     
; Add two floating point numbers with the same sign
;  In: HL, DE numbers to add, no restrictions
; Out: HL = DE + HL,  if ( 1 && overflow ) set carry
; Pollutes: AF, B, DE
; -------------- HL + DE ---------------
; HL = (+DE) + (+HL)
; HL = (-DE) + (-HL)
; *****************************************
                   fAddP                ; *
; *****************************************
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jr   nc, fAdd_HL_GR ; 2:7/12   
    ex   DE, HL         ; 1:4      
    neg                 ; 2:8
fAdd_HL_GR:
    and  0x7F           ; 2:7       exp mask
    jr    z, fAdd_Eq_Exp; 2:12/7    neresime zaokrouhlovani
    cp   0x0A           ; 2:7       pri posunu o NEUKLADANY_BIT+BITS_MANTIS uz mantisy nemaji prekryt, ale jeste se muze zaokrouhlovat 
    ret  nc             ; 1:11/5    HL + DE = HL, ret with reset carry

                        ;           Out: A = --( E | 1 0000 0000 ) >> A        
    ld    B, A          ; 1:4
    ld    A, E          ; 1:4
    dec   A             ; 1:4
    cp   0xFF           ; 2:7
    db   0x1E           ; 2:7       ld E, $B7
fAdd_Loop:
    or    A             ; 1:4
    rra                 ; 1:4
    djnz  fAdd_Loop     ; 2:13/8
        
    jr    c, fAdd1      ; 2:12/7

    add   A, L          ; 1:4       soucet mantis
    jr   nc, fAdd0_OkExp; 2:12/7
fAdd_Exp_PLUS:          ;           A = 10 mmmm mmmr, r = rounding bit                                    
    adc   A, B          ; 1:4       rounding
    rra                 ; 1:4       A = 01 cmmm mmmm
    ld    L, A          ; 1:4
    ld    A, H          ; 1:4        
    inc   H             ; 1:4
    xor   H             ; 1:4       ret with reset carry
    ret   p             ; 1:11/5        
    jr    fAdd_OVERFLOW ; 2:12

fAdd0_OkExp:            ;           A = 01 mmmm mmmm 0
    ld    L, A          ; 1:4
    ret                 ; 1:10   
        
fAdd1:
    add   A, L          ; 1:4       soucet mantis
    jr    c, fAdd_Exp_PLUS; 2:12/7
        
fAdd1_OkExp:            ;           A = 01 mmmm mmmm 1, reset carry

    ld    L, A          ; 1:4
    ld    A, H          ; 1:4        
    inc  HL             ; 1:6
    xor   H             ; 1:4       ret with reset carry
    ret   p             ; 1:11/5
    jr   fAdd_OVERFLOW  ; 2:12

fAdd_Eq_Exp:            ;           HL exp = DE exp
    ld    A, L          ; 1:4       1 mmmm mmmm
    add   A, E          ; 1:4      +1 mmmm mmmm
                        ;           1m mmmm mmmm
    rra                 ; 1:4       sign in && shift       
    ld    L, A          ; 1:4
        
    ld    A, H          ; 1:4        
    inc   H             ; 1:4
    xor   H             ; 1:4       ret with reset carry
    ret   p             ; 1:11/5
    ; fall

; In: H = s111 1111 + 1
; Out: HL = +- MAX
fAdd_OVERFLOW:
    dec   H             ; 1:4      
    ld    L, $FF        ; 2:7
    scf                 ; 1:4       carry = error
    ret                 ; 1:10
    
    
; Subtraction two floating-point numbers with the same signs
;  In: HL,DE numbers to add, no restrictions
; Out: HL = DE + HL, if ( 1 && underflow ) set carry
; Pollutes: AF, BC, DE
; -------------- HL - DE ---------------
; HL = (+DE) - (+HL) = (+DE) + (-HL)
; HL = (-DE) - (-HL) = (-DE) + (+HL)
; *****************************************
                   fSubP                ; *
; *****************************************
    ld    A, D          ; 1:4 
    xor  0x80           ; 2:7       sign mask 
    ld    D, A          ; 1:4 

; Add two floating-point numbers with the opposite signs
;  In: HL, DE numbers to add, no restrictions
; Out: HL = HL + DE
; Pollutes: AF, B, DE
; -------------- HL + DE ---------------
; HL = (+DE) + (-HL)
; HL = (-DE) + (+HL)
fAdd_OP_SGN:
    ld    A, H          ; 1:4 
    sub   D             ; 1:4 
    jp    m, fSub_HL_GR ; 3:10 
    ex   DE, HL         ; 1:4 
    ld    A, H          ; 1:4 
    sub   D             ; 1:4 
fSub_HL_GR:
    and  0x7F           ; 2:7       exp mask 
    jr    z, fSub_Eq_Exp; 2:12/7 

    cp   0x0A           ; 2:7       pri posunu vetsim nez o MANT_BITS + NEUKLADANY_BIT + ZAOKROUHLOVACI_BIT uz mantisy nemaji prekryt
    jr   nc, fSub_TOOBIG; 2:12/7    HL - DE = HL
        
                        ;           Out: E = ( E | 1 0000 0000 ) >> A        
    ld    B, A          ; 1:4 
    ld    A, E          ; 1:4 
    rra                 ; 1:4       1mmm mmmm m
    dec   B             ; 1:4 
    jr    z, fSub_NOLoop; 2:12/7 
    dec   B             ; 1:4 
    jr    z, fSub_LAST  ; 2:12/7 
fSub_Loop:
    or    A             ; 1:4 
    rra                 ; 1:4 
    djnz fSub_Loop      ; 2:13/8 
fSub_LAST:
    rl    B             ; 2:8       B = rounding 0.25
    rra                 ; 1:4         
fSub_NOLoop:            ;           carry = rounding 0.5
    ld    E, A          ; 1:4 
    ld    A, L          ; 1:4               
        
    jr    c, fSub1      ; 2:12/7 
        
    sub   E             ; 1:4 
    jr   nc, fSub0_OkExp; 2:12/7 
        
fSub_Norm_RESET:
    or    A             ; 1:4 
fSub_Norm:              ;           normalizace cisla
    dec   H             ; 1:4       exp--
    adc   A, A          ; 1:4 
    jr   nc, fSub_Norm  ; 2:7/12 
        
    sub   B             ; 1:4 
        
    ld    L, A          ; 1:4         
    ld    A, D          ; 1:4 
    xor   H             ; 1:4 
    ret   m             ; 1:11/5    RET with reset carry
    jr   fSub_UNDER     ; 2:12 

fSub0_OkExp:            ;           reset carry
    ld    L, A          ; 1:4       
    ret   nz            ; 1:11/5 

    sub   B             ; 1:4       exp--? => rounding 0.25 => 0.5 
    ret   z             ; 1:11/5 

    dec   HL            ; 1:6 
    ld    A, D          ; 1:4 
    xor   H             ; 1:4 
    ret   m             ; 1:11/5    RET with reset carry
    jr   fSub_UNDER     ; 2:12 

fSub1:
    sbc   A, E          ; 1:4       rounding half down
    jr    c, fSub_Norm  ; 2:12/7    carry => need half up
    ld    L, A          ; 1:4  
    ret                 ; 1:10 
   
fSub_Eq_Exp:
    ld    A, L          ; 1:4 
    sub   E             ; 1:4 
    jr    z, fSub_UNDER ; 2:12/7    (HL_exp = DE_exp && HL_mant = DE_mant) => HL = -DE
    jr   nc, fSub_EqNorm; 2:12/7 
    ex   DE, HL         ; 1:4 
    neg                 ; 2:8 

fSub_EqNorm:            ;           normalizace cisla
    dec   H             ; 1:4       exp--
    add   A, A          ; 1:4       musime posouvat minimalne jednou, protoze NEUKLADANY_BIT byl vynulovan
    jr   nc, fSub_EqNorm; 2:7/12 
        
    ld    L, A          ; 1:4         
    ld    A, D          ; 1:4 
    xor   H             ; 1:4  
    ret   m             ; 1:11/5 

fSub_UNDER:
    ld    L, 0x00       ; 2:7       
    ld    A, D          ; 1:4 
    cpl                 ; 1:4 
    and  0x80           ; 2:7       sign mask 
    ld    H, A          ; 1:4
    scf                 ; 1:4       carry = error
    ret                 ; 1:10 

fSub_TOOBIG:
    ret   nz            ; 1:11/5    HL_exp - DE_exp > 7+1+1 => HL - DE = HL

    ld    A, L          ; 1:4 
    or    A             ; 1:4 
    ret   nz            ; 1:11/5    HL_mant > 1.0           => HL - DE = HL

    dec   L             ; 1:4 
    dec   H             ; 1:4       HL_exp = 8 + 1 + DE_exp  => HL_exp >= 9 => not underflow
    ret                 ; 1:10 

; logaritmus naturalis
; Input: HL 
; Output: HL = ln(abs(HL)) +- lowest bit (with exponent -1($7E) the error is bigger...)
; ln(2^e*m) = ln(2^e) + ln(m) = e*ln(2) + ln(m) = ln2_exp[e] + ln_m[m]
; Pollutes: AF, B, DE
; *****************************************
                     fLn                ; *
; *****************************************
                        ;           fixes input errors with exponent equal to -1 
    ld    A, H          ; 1:4        
    add   A, A          ; 1:4 
    xor  2*0x3F         ; 2:7 
    jr    z, fLn_FIX    ; 2:12/7  

    ld    A, H          ; 1:4       save

    ld    H, high Ln_M  ; 2:7       Ln_M[]        
    ld    E, (HL)       ; 1:7 
    inc   H             ; 1:4       hi Ln_M[]
    ld    D, (HL)       ; 1:7 

    add   A, A          ; 1:4       sign out, HL = abs(HL)
    ld    L, A          ; 1:4 
    cp   0x80           ; 2:7       2*bias 
    jr    z, fLn_NO_Add ; 2:7/11 

    inc   H             ; 1:4       Ln2_Exp[]

    ld    A, (HL)       ; 1:7 
    inc   L             ; 1:4 
    ld    H, (HL)       ; 1:7 
    ld    L, A          ; 1:4 
        
    ld    A, D          ; 1:4 
    or    E             ; 1:4 
    jp   nz, fAdd       ; 3:10      HL = HL + DE = +-Ln2_Exp[] + Ln_M[]
    ret                 ; 1:10 
        
fLn_FIX:
    ld    H, high Ln_FIX; 2:7 
    ld    E, (HL)       ; 1:7 
    inc   H             ; 1:4 
    ld    D, (HL)       ; 1:7 

fLn_NO_Add:
    ex   DE, HL         ; 1:4 
    ret                 ; 1:10
    
; Natural exponential function
; Input: HL 
; Output: HL = exp(HL)) +- lowest 2 bit
; e^((2^e)*m) = 
; e^((2^e)*(m1+m0.5+m0.25+m0.125+m0.0.0625)) 
; m1 => b1 = 1, m0.5 => b0.5 = 0 or 1, m0.25 => b0.25 = 0 or 1, ...
; e^( b1*  (2^e) + b0.5*  (2^e-1) + b0.25*  (2^e-2) + b0.125*  (2^e-3) + b0.0625*  (2^e-4) + ... ) = 
;     b1*e^(2^e) * b0.5*e^(2^e-1) * b0.25*e^(2^e-2) * b0.125*e^(2^e-3) * b0.0625*e^(2^e-4) * ... 
; Pollutes: AF, BC, DE
; *****************************************
                    fExp                ; *
; *****************************************
    ld    D, EXP_TAB/256; 2:7 
    ld    A, H          ; 1:4 
    add   A, A          ; 1:4 
    ld    E, A          ; 1:4 
    jr   nc, $+3        ; 2:7/11 
    inc   D             ; 1:4 

    cp   2*0x37         ; 2:7 
    jr    c, fExp_ONE   ; 2:7/11 
    cp   2*0x46         ; 2:7 
    jr   nc, fExp_FLOW  ; 2:7/11 

    ld    A, L          ; 1:4       fraction

    ex   DE, HL         ; 1:4 
    inc   L             ; 1:4 
    ld    D, (HL)       ; 1:7 
    dec   L             ; 1:4 
    ld    E, (HL)       ; 1:7 

fExp_0_BIT:
    jr    z, fExp_EXIT  ; 2:7/11 
fExp_Loop:
    dec   L             ; 1:4       exp--
    ld    B, (HL)       ; 1:7 
    dec   L             ; 1:4 
    add   A, A          ; 1:4 
    jr   nc, fExp_0_BIT ; 2:7/11 
    ld    C, (HL)       ; 1:7 
        
    push HL             ; 1:11
    push AF             ; 1:11
    call fMul           ; 3:17      HL = BC * DE
    pop  AF             ; 1:10
    ex   DE, HL         ; 1:4 
    pop  HL             ; 1:10
        
    jp  fExp_Loop       ; 3:10 
        
fExp_ONE:
    ld    DE, 0x4000    ; 3:10      bias*256
fExp_EXIT:
    ex   DE, HL         ; 1:4 
    ret                 ; 1:10 
        
fExp_FLOW:
    ld    A, H          ; 1:4 
    add   A, A          ; 1:4       sign out
    jr    c, fExp_UNDER ; 2:7/11 
fExp_OVER:              ;
    scf                 ; 1:4
    ld    HL, 0x7FFF    ; 3:10      fpmax 
    ret                 ; 1:10 

fExp_UNDER:
    ld    HL, 0x0000    ; 3:10      fpmin 
    ret                 ; 1:10
;  Input:  BC, HL with a mantissa equal to 1.0 (eeee eeee s000 0000)
; Output: HL = BC / HL = BC / (1.0 * 2^HL_exp) = BC * 1.0 * 2^-HL_exp, if ( overflow or underflow ) set carry
; Pollutes: AF, BC, DE

;# if ( 1.m = 1.0 ) => 1/(2^x * 1.0) = 1/2^x * 1/1.0 = 2^-x * 1.0    
;# New_sign = BC_sign ^ HL_sign
;# New_exp  = (BC_exp - bias) + ( bias - HL_exp ) + bias = bias + BC_exp - HL_exp
;# New_mant = BC_mant * 1.0 = BC_mant
; *****************************************
                 fDiv_POW2              ; *
; *****************************************
    ld    A, B          ; 1:4       BC_exp
    sub   H             ; 1:4      -HL_exp
    add   A, 0x40       ; 2:7       bias
    ld    L, A          ; 1:4 
    xor   H             ; 1:4       xor sign
    xor   B             ; 1:4       xor sign
    jp    m, fDiv_FLOW  ; 3:10 
    ld    H, L          ; 1:4 
    ld    L, C          ; 1:4 
    ret                 ; 1:10 
fDiv_FLOW:        
    bit   6, L          ; 2:8       sign+(0x00..0x3F)=overflow, sign+(0x41..0x7F)=underflow
    jr    z, fDiv_OVER  ; 2:12/7 
        
fDiv_UNDER:      
    ld    A, L          ; 1:4 
    cpl                 ; 1:4 
    and  0x80           ; 2:7       sign mask
    ld    H, A          ; 1:4 
    ld    L, 0x00       ; 2:7
    scf                 ; 1:4       carry = error
    ret                 ; 1:10 

fDiv_OVER:
    ld    A, L          ; 1:4 
    cpl                 ; 1:4 
    or   0x7F           ; 2:7       exp mask
    ld    H, A          ; 1:4 
    ld    L, 0xFF       ; 2:7
    scf                 ; 1:4       carry = error
    ret                 ; 1:10 
     
; ---------------------------------------------
;  Input:  BC , HL
; Output: HL = BC / HL   =>   DE = 1 / HL   =>   HL = BC * DE
; if ( 1.m = 1.0 ) => 1/(2^x * 1.0) = 1/2^x * 1/1.0 = 2^-x * 1.0    
; if ( 1.m > 1.0 ) => 1/(2^x * 1.m) = 1/2^x * 1/1.m = 2^-x * 0.9999 .. 0.5001   =>   2^(-x-1) * 1.0002 .. 1.9998    
; Pollutes: AF, BC, DE
; *****************************************
                    fDiv                ; *
; *****************************************
    ld    A, L          ; 1:4 
    or    A             ; 1:4 
    jr    z, fDiv_POW2  ; 2:12/7 
    ld    A, H          ; 1:4       NegE - 1 = (0 - (E - bias)) + bias - 1 = 2*bias - E - 1 = 128 - E - 1 = 127 - E
    xor  0x7F           ; 2:7       NegE = 127 - E = 0x7F - E = 0x7F 
    ld    A, E          ; 1:4       xor
    xor   L             ; 1:4       xor
    ld    L, A          ; 1:4       xor
    ld    A, D          ; 1:4       xor
    xor   H             ; 1:4       xor
    ld    H, A          ; 1:4       xor
    pop  DE             ; 1:10      xor E     
    ld    D, A          ; 1:4 

    ld    H, DIVTAB/256 ; 2:7 
    ld    E, (HL)       ; 1:7 
    ; continues with fMul (HL = BC * DE), DE = 1 / HL
; Floating-point multiplication
;  In: DE, BC multiplicands
; Out: HL = BC * DE, if ( 1 && (overflow || underflow )) set carry;
; Pollutes: AF, BC, DE

; SEEE EEEE MMMM MMMM
; Sign       0 .. 1           = 0??? ???? ???? ???? .. 1??? ???? ???? ???? 
; Exp      -64 .. 63          = ?000 0000 ???? ???? .. ?111 1111 ???? ????;   (Bias 64 = 0x40)
; Mantis   1.0 .. 1.99609375  = ???? ???? 0000 0000 .. ???? ???  1111 1111 = 1.0000 0000 .. 1.1111 1111
; use POW2TAB
; *****************************************
                   fMul                 ; *
; *****************************************
    ld    A, B          ; 1:4 
    add   A, D          ; 1:4 
    sub  0x40           ; 2:7       HL_exp = (BC_exp-bias + DE_exp-bias) + bias = BC_exp + DE_exp - bias
    ld    H, A          ; 1:4       seee eeee
        
    xor   B             ; 1:4 
    xor   D             ; 1:4 
    jp    m, fMul_FLOW  ; 3:10 
    ld    B, H          ; 1:4       seee eeee
fMul_HOPE:

    ld    A, C          ; 1:4 
    sub   E             ; 1:4 
    jr   nc, fMul_DIFF  ; 2:12/7 
    ld    A, E          ; 1:4 
    sub   C             ; 1:4 
fMul_DIFF:
    ld    L, A          ; 1:4       L = a - b
    ld    A, E          ; 1:4 
    ld    H, Tab_AmB/256; 2:7           
    ld    E, (HL)       ; 1:7 
    inc   H             ; 1:4         
    ld    D, (HL)       ; 1:7 
    add   A, C          ; 1:4 
    ld    L, A          ; 1:4       L = a + b
        
    sbc   A, A          ; 1:4 
    add   A, A          ; 1:4 
    add   A, Tab_ApB/256; 2:7 
    ld    H, A          ; 1:4 
        
    ld    A, (HL)       ; 1:4 
    add   A, E          ; 1:4 
    ld    E, A          ; 1:4       for rounding
    inc   H             ; 1:4 
    ld    A, (HL)       ; 1:4 
    adc   A, D          ; 1:4   
    ld    H, A          ; 1:4 
    ld    L, E          ; 1:4 
           
    jp    p, fMul_NOADD ; 3:10      (ApB)+(AmB) >= 0x4000 => pricti: 0x00
                        ;           (ApB)+(AmB) >= 0x8000 => pricti: 0x20
    ld   DE, 0x0020     ; 3:10
    add  HL, DE         ; 1:11 
    add  HL, HL         ; 1:11 

    ld    L, H          ; 1:4 
    ld    H, B          ; 1:4         

    inc   H             ; 1:4 
    ld    A, B          ; 1:4 
    xor   H             ; 1:4 
    ret   p             ; 1:11/5 
        
; In: B sign
fMul_OVER:
    ld    A, B          ; 1:4 
fMul_OVER_A:
    or   0x7F           ; 2:7       exp_mask
    ld    H, A          ; 1:4 
    ld    L, 0xFF       ; 2:7
    scf                 ; 1:4       carry = error
    ret                 ; 1:10 

fMul_NOADD:
    add  HL, HL         ; 1:11 
    add  HL, HL         ; 1:11 

    ld    L, H          ; 1:4 
    ld    H, B          ; 1:4
    or    A             ; 1:4
    ret                 ; 1:10 
        
fMul_FLOW:
    ld    A, H          ; 1:4 
    cpl                 ; 1:4       real sign
    bit   6, H          ; 2:8       sign+(0x00..0x3E)=overflow, sign+(0x40..0x7F)=underflow
    jr    z, fMul_OVER_A; 2:12/7 

    add   A, A          ; 1:4       sign out
    jr   nz, fMul_UNDER ; 2:12/7 
        
    rra                 ; 1:4 
    ld    B, A          ; 1:4       s000 0000 
    call fMul_HOPE      ; 3:17      exp+1
    ld    A, H          ; 1:4 
    dec   H             ; 1:4       exp-1
    xor   H             ; 1:4 
    ret   p             ; 1:11/5   
        
    xor   H             ; 1:4       sign
    add   A, A          ; 1:4       sign out
                
fMul_UNDER:
    ld   HL, 0x0100     ; 3:10
    rr    H             ; 2:8       sign in, set carry
    ret                 ; 1:10
; Trigonometric function sine
; Input: HL -π/2..π/2
; Output: HL = sin(HL)
; Pollutes: AF, DE
; *****************************************
                    fSin                ; *
; *****************************************

    ld    A, H          ; 1:4 
    and  0x7F           ; 2:7       abs(HL)
    sub  0x3F           ; 2:7 
    jr   nc, fSin_3F40  ; 2:12/7 
    add   A, 0x02       ; 2:7 
    jr    c, fSin_3D3E  ; 2:12/7 
    inc   A             ; 1:4 
    ret   nz            ; 1:5/11 
    ld    A, 0x71       ; 2:7 
    sub   L             ; 1:4 
    ret   nc            ; 1:5/11
    or    A             ; 1:4       reset carry
    dec   L             ; 1:4 
    ret                 ; 1:10 
fSin_3D3E:
    ld    D, SinTab_3D3E/256; 2:7 
    rra                 ; 1:4 
    ld    A, L          ; 1:4 
    rra                 ; 1:4 
    ld    E, A          ; 1:4 
    ld    A, (DE)       ; 1:7 
    jr    c, $+6        ; 2:12/7         
    rra                 ; 1:4 
    rra                 ; 1:4 
    rra                 ; 1:4 
    rra                 ; 1:4 
    or   0xF0           ; 2:7 
    rl    E             ; 2:8 
        
    jr   nc, fSin_OK    ; 2:12/7 
    jp    p, fSin_OK    ; 3:10 
    sub  0x08           ; 2:7 
fSin_OK:
    ld    E, A          ; 1:4 
    ld    D, 0xFF       ; 2:7 
    add  HL, DE         ; 1:11
    or    A             ; 1:4       reset carry
    ret                 ; 1:10 
fSin_3F40:
    add   A, high SinTab_3F ; 2:7 
    ex   DE, HL         ; 1:4 
    ld    H, A          ; 1:4 
    ld    L, E          ; 1:4 
    ld    L, (HL)       ; 1:7 
    ld    H, 0xFF       ; 2:7 
    add  HL, DE         ; 1:11
    or    A             ; 1:4       reset carry
    ret                 ; 1:10
fDot:
    push DE             ; 1:11

    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    ld    E, L          ; 1:4       mantisa
    rr    E             ; 2:8       bit 7 = sign
    ld   BC, 0x0000     ; 3:10
    ld    D, B          ; 1:4
    rr    D             ; 2:8       bit 7 = bit 0 L mantissa
    rrca                ; 1:4
    add   A, 0x41       ; 2:7       new exponent
    call 0x2AB6         ; 3:17      Ulozenie floating point cisla (A E D C B) v na vrchol zasobnika kalkulacky
    call 0x2DE3         ; 3:17      Vypis vrcholu zasobnika kalkukacky

    pop  DE             ; 1:10
    pop  HL             ; 1:10      ret
    ex  (SP),HL         ; 1:19
    ex   DE, HL         ; 1:4
    ret                 ; 1:10
; Align to 256-byte page boundary
DEFS    (($ + 0xFF) / 0x100) * 0x100 - $

; y = (x-0x3D00)/2
; z = SinTab[y]    // 512*nibble
; if ( x & 1 == 0 ) z >>= 4
; z |= 0xf0
; if ( y >= 0xc0 ) z -= 8
; Sin[x] = res = x + 0xff00 + z
; hi = 0xff
SinTab_3D3E:
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff   ; 0_  0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff 0_
db 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff   ; 1_  0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff 1_
db 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee   ; 2_  0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ff,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee 2_
db 0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xee   ; 3_  0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0ee 3_
db 0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd   ; 4_  0ee,0ee,0ee,0ee,0ee,0ee,0ee,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd 4_
db 0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xcc   ; 5_  0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0cc 5_
db 0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc   ; 6_  0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc 6_
db 0xcc,0xcc,0xcb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb   ; 7_  0cc,0cc,0cb,0bb,0bb,0bb,0bb,0bb,0bb,0bb,0bb,0bb,0bb,0bb,0bb,0bb 7_
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0xbc,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdd,0xdc,0xcc,0xcc,0xcc   ; 0_  0bc,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dd,0dc,0cc,0cc,0cc 0_
db 0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb   ; 1_  0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0cc,0bb,0bb,0bb,0bb,0bb,0bb,0bb 1_
db 0xbb,0xbb,0xbb,0xba,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0x99,0x99,0x99   ; 2_  0bb,0bb,0bb,0ba,0aa,0aa,0aa,0aa,0aa,0aa,0aa,0aa,0aa,099,099,099 2_
db 0x99,0x99,0x99,0x99,0x99,0x98,0x88,0x88,0x88,0x88,0x88,0x88,0x88,0x77,0x77,0x77   ; 3_  099,099,099,099,099,098,088,088,088,088,088,088,088,077,077,0ff 3_
db 0xff,0xff,0xff,0xff,0xee,0xee,0xee,0xee,0xee,0xee,0xee,0xdd,0xdd,0xdd,0xdd,0xdd   ; 4_  0ff,0ff,0ff,0ff,0ee,0ee,0ee,0ee,0ee,0ee,0ee,0dd,0dd,0dd,0dd,0dd 4_
db 0xdd,0xcc,0xcc,0xcc,0xcc,0xcc,0xcc,0xbb,0xbb,0xbb,0xbb,0xbb,0xba,0xaa,0xaa,0xaa   ; 5_  0dd,0cc,0cc,0cc,0cc,0cc,0cc,0bb,0bb,0bb,0bb,0bb,0ba,0aa,0aa,0aa 5_
db 0xaa,0xaa,0x99,0x99,0x99,0x99,0x99,0x88,0x88,0x88,0x88,0x88,0x77,0x77,0x77,0x77   ; 6_  0aa,0aa,099,099,099,099,099,088,088,088,088,088,077,077,077,077 6_
db 0x77,0x66,0x66,0x66,0x66,0x65,0x55,0x55,0x55,0x54,0x44,0x44,0x44,0x44,0x33,0x33   ; 7_  077,066,066,066,066,065,055,055,055,054,044,044,044,044,033,033 7_

; hi = 0xff
SinTab_3F:
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0xeb,0xec,0xec,0xed,0xee,0xef,0xef,0xf0,0xf1,0xf2,0xf2,0xf3,0xf4,0xf4,0xf4,0xf4  ; 0_  ffeb,ffec,ffec,ffed,ffee,ffef,ffef,fff0,fff1,fff2,fff2,fff3,fff4,fff4,fff4,fff4 0_
db 0xf3,0xf3,0xf3,0xf3,0xf3,0xf3,0xf3,0xf2,0xf2,0xf2,0xf2,0xf2,0xf2,0xf2,0xf1,0xf1  ; 1_  fff3,fff3,fff3,fff3,fff3,fff3,fff3,fff2,fff2,fff2,fff2,fff2,fff2,fff2,fff1,fff1 1_
db 0xf1,0xf1,0xf1,0xf1,0xf0,0xf0,0xf0,0xf0,0xf0,0xf0,0xef,0xef,0xef,0xef,0xef,0xef  ; 2_  fff1,fff1,fff1,fff1,fff0,fff0,fff0,fff0,fff0,fff0,ffef,ffef,ffef,ffef,ffef,ffef 2_
db 0xee,0xee,0xee,0xee,0xee,0xee,0xed,0xed,0xed,0xed,0xed,0xed,0xec,0xec,0xec,0xec  ; 3_  ffee,ffee,ffee,ffee,ffee,ffee,ffed,ffed,ffed,ffed,ffed,ffed,ffec,ffec,ffec,ffec 3_
db 0xec,0xeb,0xeb,0xeb,0xeb,0xeb,0xea,0xea,0xea,0xea,0xea,0xe9,0xe9,0xe9,0xe9,0xe9  ; 4_  ffec,ffeb,ffeb,ffeb,ffeb,ffeb,ffea,ffea,ffea,ffea,ffea,ffe9,ffe9,ffe9,ffe9,ffe9 4_
db 0xe8,0xe8,0xe8,0xe8,0xe8,0xe7,0xe7,0xe7,0xe7,0xe6,0xe6,0xe6,0xe6,0xe6,0xe5,0xe5  ; 5_  ffe8,ffe8,ffe8,ffe8,ffe8,ffe7,ffe7,ffe7,ffe7,ffe6,ffe6,ffe6,ffe6,ffe6,ffe5,ffe5 5_
db 0xe5,0xe5,0xe4,0xe4,0xe4,0xe4,0xe4,0xe3,0xe3,0xe3,0xe3,0xe2,0xe2,0xe2,0xe2,0xe1  ; 6_  ffe5,ffe5,ffe4,ffe4,ffe4,ffe4,ffe4,ffe3,ffe3,ffe3,ffe3,ffe2,ffe2,ffe2,ffe2,ffe1 6_
db 0xe1,0xe1,0xe1,0xe0,0xe0,0xe0,0xe0,0xdf,0xdf,0xdf,0xdf,0xde,0xde,0xde,0xde,0xdd  ; 7_  ffe1,ffe1,ffe1,ffe0,ffe0,ffe0,ffe0,ffdf,ffdf,ffdf,ffdf,ffde,ffde,ffde,ffde,ffdd 7_
db 0xdd,0xdd,0xdc,0xdc,0xdc,0xdc,0xdb,0xdb,0xdb,0xdb,0xda,0xda,0xda,0xd9,0xd9,0xd9  ; 8_  ffdd,ffdd,ffdc,ffdc,ffdc,ffdc,ffdb,ffdb,ffdb,ffdb,ffda,ffda,ffda,ffd9,ffd9,ffd9 8_
db 0xd9,0xd8,0xd8,0xd8,0xd7,0xd7,0xd7,0xd6,0xd6,0xd6,0xd6,0xd5,0xd5,0xd5,0xd4,0xd4  ; 9_  ffd9,ffd8,ffd8,ffd8,ffd7,ffd7,ffd7,ffd6,ffd6,ffd6,ffd6,ffd5,ffd5,ffd5,ffd4,ffd4 9_
db 0xd4,0xd3,0xd3,0xd3,0xd2,0xd2,0xd2,0xd1,0xd1,0xd1,0xd1,0xd0,0xd0,0xd0,0xcf,0xcf  ; A_  ffd4,ffd3,ffd3,ffd3,ffd2,ffd2,ffd2,ffd1,ffd1,ffd1,ffd1,ffd0,ffd0,ffd0,ffcf,ffcf A_
db 0xcf,0xce,0xce,0xce,0xcd,0xcd,0xcc,0xcc,0xcc,0xcb,0xcb,0xcb,0xca,0xca,0xca,0xc9  ; B_  ffcf,ffce,ffce,ffce,ffcd,ffcd,ffcc,ffcc,ffcc,ffcb,ffcb,ffcb,ffca,ffca,ffca,ffc9 B_
db 0xc9,0xc9,0xc8,0xc8,0xc8,0xc7,0xc7,0xc6,0xc6,0xc6,0xc5,0xc5,0xc5,0xc4,0xc4,0xc3  ; C_  ffc9,ffc9,ffc8,ffc8,ffc8,ffc7,ffc7,ffc6,ffc6,ffc6,ffc5,ffc5,ffc5,ffc4,ffc4,ffc3 C_
db 0xc3,0xc3,0xc2,0xc2,0xc1,0xc1,0xc1,0xc0,0xc0,0xc0,0xbf,0xbf,0xbe,0xbe,0xbe,0xbd  ; D_  ffc3,ffc3,ffc2,ffc2,ffc1,ffc1,ffc1,ffc0,ffc0,ffc0,ffbf,ffbf,ffbe,ffbe,ffbe,ffbd D_
db 0xbd,0xbc,0xbc,0xbb,0xbb,0xbb,0xba,0xba,0xb9,0xb9,0xb9,0xb8,0xb8,0xb7,0xb7,0xb6  ; E_  ffbd,ffbc,ffbc,ffbb,ffbb,ffbb,ffba,ffba,ffb9,ffb9,ffb9,ffb8,ffb8,ffb7,ffb7,ffb6 E_
db 0xb6,0xb6,0xb5,0xb5,0xb4,0xb4,0xb3,0xb3,0xb2,0xb2,0xb2,0xb1,0xb1,0xb0,0xb0,0xaf  ; F_  ffb6,ffb6,ffb5,ffb5,ffb4,ffb4,ffb3,ffb3,ffb2,ffb2,ffb2,ffb1,ffb1,ffb0,ffb0,ffaf F_
; hi = 0xff
SinTab_40:
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf  ; 0_  ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf 0_
db 0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xaf,0xae,0xae,0xae,0xae  ; 1_  ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffaf,ffae,ffae,ffae,ffae 1_
db 0xae,0xae,0xae,0xae,0xad,0xad,0xad,0xad,0xad,0xac,0xac,0xac,0xac,0xac,0xab,0xab  ; 2_  ffae,ffae,ffae,ffae,ffad,ffad,ffad,ffad,ffad,ffac,ffac,ffac,ffac,ffac,ffab,ffab 2_
db 0xab,0xab,0xaa,0xaa,0xaa,0xa9,0xa9,0xa9,0xa9,0xa8,0xa8,0xa8,0xa7,0xa7,0xa7,0xa6  ; 3_  ffab,ffab,ffaa,ffaa,ffaa,ffa9,ffa9,ffa9,ffa9,ffa8,ffa8,ffa8,ffa7,ffa7,ffa7,ffa6 3_
db 0xa6,0xa6,0xa5,0xa5,0xa4,0xa4,0xa4,0xa3,0xa3,0xa2,0xa2,0xa1,0xa1,0xa0,0xa0,0xa0  ; 4_  ffa6,ffa6,ffa5,ffa5,ffa4,ffa4,ffa4,ffa3,ffa3,ffa2,ffa2,ffa1,ffa1,ffa0,ffa0,ffa0 4_
db 0x9f,0x9f,0x9e,0x9e,0x9d,0x9c,0x9c,0x9b,0x9b,0x9a,0x9a,0x99,0x99,0x98,0x97,0x97  ; 5_  ff9f,ff9f,ff9e,ff9e,ff9d,ff9c,ff9c,ff9b,ff9b,ff9a,ff9a,ff99,ff99,ff98,ff97,ff97 5_
db 0x96,0x96,0x95,0x94,0x94,0x93,0x92,0x92,0x91,0x90,0x90,0x8f,0x8e,0x8e,0x8d,0x8c  ; 6_  ff96,ff96,ff95,ff94,ff94,ff93,ff92,ff92,ff91,ff90,ff90,ff8f,ff8e,ff8e,ff8d,ff8c 6_
db 0x8b,0x8b,0x8a,0x89,0x88,0x88,0x87,0x86,0x85,0x85,0x84,0x83,0x82,0x81,0x80,0x80  ; 7_  ff8b,ff8b,ff8a,ff89,ff88,ff88,ff87,ff86,ff85,ff85,ff84,ff83,ff82,ff81,ff80,ff80 7_
db 0x7f,0x7e,0x7d,0x7c,0x7b,0x7a,0x79,0x79,0x78,0x77,0x76,0x75,0x74,0x73,0x72,0x71  ; 8_  ff7f,ff7e,ff7d,ff7c,ff7b,ff7a,ff79,ff79,ff78,ff77,ff76,ff75,ff74,ff73,ff72,ff71 8_
db 0x70,0x6f,0x6e,0x6d,0x6c,0x6b,0x6a,0x69,0x68,0x67,0x66,0x65,0x64,0x63,0x61,0x60  ; 9_  ff70,ff6f,ff6e,ff6d,ff6c,ff6b,ff6a,ff69,ff68,ff67,ff66,ff65,ff64,ff63,ff61,ff60 9_
db 0x5f,0x5e,0x5d,0x5c,0x5b,0x5a,0x58,0x57,0x56,0x55,0x54,0x53,0x51,0x50,0x4f,0x4e  ; A_  ff5f,ff5e,ff5d,ff5c,ff5b,ff5a,ff58,ff57,ff56,ff55,ff54,ff53,ff51,ff50,ff4f,ff4e A_
db 0x4d,0x4b,0x4a,0x49,0x48,0x46,0x45,0x44,0x42,0x41,0x40,0x3e,0x3d,0x3c,0x3a,0x39  ; B_  ff4d,ff4b,ff4a,ff49,ff48,ff46,ff45,ff44,ff42,ff41,ff40,ff3e,ff3d,ff3c,ff3a,ff39 B_
db 0x38,0x36,0x35,0x34,0x32,0x31,0x30,0x2e,0x2d,0x2b,0x2a,0x28,0x27,0x26,0x24,0x23  ; C_  ff38,ff36,ff35,ff34,ff32,ff31,ff30,ff2e,ff2d,ff2b,ff2a,ff28,ff27,ff26,ff24,ff23 C_
db 0x21,0x20,0x1e,0x1d,0x1b,0x1a,0x18,0x17,0x15,0x14,0x12,0x10,0x0f,0x0d,0x0c,0x0a  ; D_  ff21,ff20,ff1e,ff1d,ff1b,ff1a,ff18,ff17,ff15,ff14,ff12,ff10,ff0f,ff0d,ff0c,ff0a D_
db 0x08,0x07,0x05,0x04,0x02,0x00,0xff,0xfd,0xfb,0xfa,0xf8,0xf6,0xf5,0xf3,0xf1,0xf0  ; E_  ff08,ff07,ff05,ff04,ff02,ff00,feff,fefd,fefb,fefa,fef8,fef6,fef5,fef3,fef1,fef0 E_
db 0xee,0xec,0xeb,0xe9,0xe7,0xe5,0xe4,0xe2,0xe0,0xde,0xdc,0xdb,0xd9,0xd7,0xd5,0xd3  ; F_  feee,feec,feeb,fee9,fee7,fee5,fee4,fee2,fee0,fede,fedc,fedb,fed9,fed7,fed5,fed3 F_

; Align to 256-byte page boundary
DEFS    (($ + 0xFF) / 0x100) * 0x100 - $

; e^((2^e)*m) = 
; e^((2^e)*(m1+m0.5+m0.25+m0.125+m0.0.0625)) 
; m1 => b1 = 1, m0.5 => b0.5 = 0 or 1, m0.25 => b0.25 = 0 or 1, ...
; e^( b1*  (2^e) + b0.5*  (2^e-1) + b0.25*  (2^e-2) + b0.125*  (2^e-3) + b0.0625*  (2^e-4) + ... ) = 
;     b1*e^(2^e) * b0.5*e^(2^e-1) * b0.25*e^(2^e-2) * b0.125*e^(2^e-3) * b0.0625*e^(2^e-4) * ... 

EXP_TAB:
; plus
;   _0    _1    _2    _3    _4    _5    _6    _7    _8    _9    _A    _B    _C    _D    _E    _F
dw 0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000   ; 0_  
dw 0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000   ; 1_  
dw 0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000   ; 2_  
dw 0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4001,0x4001,0x4002,0x4004,0x4008,0x4011,0x4022,0x4049,0x40a6   ; 3_  
dw 0x415c,0x42d9,0x45b5,0x4b75,0x570f,0x6e1f,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff   ; 4_  
dw 0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff   ; 5_  
dw 0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff   ; 6_  
dw 0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff,0x7fff   ; 7_  
; minus
;   _0    _1    _2    _3    _4    _5    _6    _7    _8    _9    _A    _B    _C    _D    _E    _F
dw 0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000   ; 0_  
dw 0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000   ; 1_  
dw 0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000   ; 2_  
dw 0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x3fff,0x3ffe,0x3ffc,0x3ff8,0x3ff0,0x3fe1,0x3fc4,0x3f8f,0x3f37   ; 3_  
dw 0x3e79,0x3d15,0x3a2c,0x3460,0x28e3,0x11c8,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000   ; 4_  
dw 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000   ; 5_  
dw 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000   ; 6_  
dw 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000   ; 7_ 

; rozdíl: má být mínus jest, nemohu se splést...
; nepřesnost: 2963 (4.521179 %)
;       chyb: 399 (0.608826 %)

; Align to 256-byte page boundary
DEFS    (($ + 0xFF) / 0x100) * 0x100 - $

; #define MAX _NUMBER 255
; #define TOP _BIT 0x8000
; #define PRICTI 0x3F
; #define POSUN _VPRAVO 7
; #define POCET _BITU 8

; # 1000 0000  0... ....  
; #              11 1111  
; #  765 4321  0... ....   

; #       neni presne: 31568 (48.168945%), preteceni: 31568, podteceni: 0
; # neni zaokrouhleno: 0 (0.000000%), preteceni: 0, podteceni: 0
; # sum(tab _dif[]): -130, sum(abs(tab _dif[])): 192
; # (( 256 + a ) * ( 256 + b )) >> 6 = (tab _plus[a+b] - tab _minus[a-b]) >> 6 = (1m mmmm mmm.) or (01 mmmm mmmm)
; # 0 <= a <= 255, 0 <= b <= 255

; tab _minus je zvyseno o 0xFE0, a tab _plus zase snizeno o 0xFE0
; (ApB)+(AmB) >= 0x8000 => pricti: 0x20
; (ApB)+(AmB) >= 0x4000 => pricti: 0x0

;Tab_AmB_lo:	; 0xFE0 - tab _minus[i]
Tab_AmB:
;    _0   _1   _2   _3   _4   _5   _6   _7   _8   _9   _A   _B   _C   _D   _E   _F
db 0xe0,0xe0,0xdf,0xe0,0xde,0xdf,0xdd,0xdd,0xdc,0xdb,0xda,0xd8,0xd7,0xd5,0xd4,0xd1  ; 0_  fe0,fe0,fdf,fe0,fde,fdf,fdd,fdd,fdc,fdb,fda,fd8,fd7,fd5,fd4,fd1 0_
db 0xd1,0xce,0xcc,0xcb,0xc7,0xc4,0xc2,0xc0,0xbc,0xb9,0xb6,0xb4,0xaf,0xab,0xa8,0xa4  ; 1_  fd1,fce,fcc,fcb,fc7,fc4,fc2,fc0,fbc,fb9,fb6,fb4,faf,fab,fa8,fa4 1_
db 0xa0,0x9c,0x98,0x92,0x8f,0x8c,0x86,0x82,0x7c,0x77,0x72,0x6c,0x67,0x61,0x5b,0x55  ; 2_  fa0,f9c,f98,f92,f8f,f8c,f86,f82,f7c,f77,f72,f6c,f67,f61,f5b,f55 2_
db 0x51,0x4b,0x44,0x3e,0x37,0x31,0x2a,0x23,0x1c,0x14,0x0e,0x06,0xff,0xf7,0xf0,0xe8  ; 3_  f51,f4b,f44,f3e,f37,f31,f2a,f23,f1c,f14,f0e,f06,eff,ef7,ef0,ee8 3_
db 0xe0,0xd7,0xd0,0xc8,0xbf,0xb6,0xae,0xa5,0x9c,0x91,0x8a,0x81,0x77,0x6d,0x64,0x59  ; 4_  ee0,ed7,ed0,ec8,ebf,eb6,eae,ea5,e9c,e91,e8a,e81,e77,e6d,e64,e59 4_
db 0x51,0x45,0x3b,0x33,0x27,0x1c,0x12,0x07,0xfc,0xf2,0xe6,0xda,0xcf,0xc3,0xb8,0xab  ; 5_  e51,e45,e3b,e33,e27,e1c,e12,e07,dfc,df2,de6,dda,dcf,dc3,db8,dab 5_
db 0xa0,0x92,0x88,0x7c,0x6f,0x62,0x56,0x4a,0x3c,0x2f,0x22,0x13,0x07,0xfa,0xec,0xde  ; 6_  da0,d92,d88,d7c,d6f,d62,d56,d4a,d3c,d2f,d22,d13,d07,cfa,cec,cde 6_
db 0xd1,0xc2,0xb4,0xa6,0x97,0x89,0x7a,0x6a,0x5c,0x4d,0x3e,0x2e,0x1e,0x0f,0x00,0xf0  ; 7_  cd1,cc2,cb4,ca6,c97,c89,c7a,c6a,c5c,c4d,c3e,c2e,c1e,c0f,c00,bf0 7_
db 0xe0,0xd0,0xc0,0xb1,0x9e,0x8e,0x7e,0x6d,0x5c,0x4c,0x3a,0x29,0x17,0x05,0xf4,0xe2  ; 8_  be0,bd0,bc0,bb1,b9e,b8e,b7e,b6d,b5c,b4c,b3a,b29,b17,b05,af4,ae2 8_
db 0xd1,0xbf,0xac,0x99,0x87,0x75,0x62,0x4f,0x3c,0x29,0x16,0x03,0xef,0xdc,0xc8,0xb5  ; 9_  ad1,abf,aac,a99,a87,a75,a62,a4f,a3c,a29,a16,a03,9ef,9dc,9c8,9b5 9_
db 0xa0,0x8d,0x78,0x64,0x4f,0x3b,0x26,0x11,0xfc,0xe7,0xd2,0xbd,0xa7,0x91,0x7b,0x66  ; A_  9a0,98d,978,964,94f,93b,926,911,8fc,8e7,8d2,8bd,8a7,891,87b,866 A_
db 0x51,0x3a,0x24,0x0e,0xf7,0xe1,0xca,0xb4,0x9c,0x85,0x6e,0x56,0x3f,0x28,0x10,0xf8  ; B_  851,83a,824,80e,7f7,7e1,7ca,7b4,79c,785,76e,756,73f,728,710,6f8 B_
db 0xe0,0xc8,0xb0,0x98,0x7f,0x67,0x4e,0x35,0x1c,0x03,0xea,0xd1,0xb7,0x9e,0x84,0x69  ; C_  6e0,6c8,6b0,698,67f,667,64e,635,61c,603,5ea,5d1,5b7,59e,584,569 C_
db 0x50,0x36,0x1c,0x02,0xe7,0xcd,0xb2,0x97,0x7c,0x61,0x46,0x2b,0x0f,0xf4,0xd8,0xbc  ; D_  550,536,51c,502,4e7,4cd,4b2,497,47c,461,446,42b,40f,3f4,3d8,3bc D_
db 0xa0,0x84,0x68,0x4c,0x2f,0x14,0xf6,0xd9,0xbc,0x9f,0x82,0x65,0x47,0x2a,0x0c,0xee  ; E_  3a0,384,368,34c,32f,314,2f6,2d9,2bc,29f,282,265,247,22a,20c,1ee E_
db 0xd0,0xb2,0x94,0x76,0x57,0x39,0x1a,0xfb,0xdc,0xbd,0x9e,0x7f,0x5f,0x40,0x20,0x00  ; F_  1d0,1b2,194,176,157,139,11a, fb, dc, bd, 9e, 7f, 5f, 40, 20, 00 F_
;Tab_AmB_hi:	; 0xFE0 - tab _minus[i]
;    _0   _1   _2   _3   _4   _5   _6   _7   _8   _9   _A   _B   _C   _D   _E   _F
db 0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f  ; 0_  
db 0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f  ; 1_  
db 0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f  ; 2_  
db 0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0f,0x0e,0x0e,0x0e,0x0e  ; 3_  
db 0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e  ; 4_  
db 0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d  ; 5_  
db 0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0d,0x0c,0x0c,0x0c  ; 6_  
db 0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0c,0x0b  ; 7_  
db 0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0b,0x0a,0x0a  ; 8_  
db 0x0a,0x0a,0x0a,0x0a,0x0a,0x0a,0x0a,0x0a,0x0a,0x0a,0x0a,0x0a,0x09,0x09,0x09,0x09  ; 9_  
db 0x09,0x09,0x09,0x09,0x09,0x09,0x09,0x09,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08  ; A_  
db 0x08,0x08,0x08,0x08,0x07,0x07,0x07,0x07,0x07,0x07,0x07,0x07,0x07,0x07,0x07,0x06  ; B_  
db 0x06,0x06,0x06,0x06,0x06,0x06,0x06,0x06,0x06,0x06,0x05,0x05,0x05,0x05,0x05,0x05  ; C_  
db 0x05,0x05,0x05,0x05,0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x03,0x03,0x03  ; D_  
db 0x03,0x03,0x03,0x03,0x03,0x03,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x01  ; E_  
db 0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00  ; F_  

Tab_ApB_lo_1:	; tab _plus[i] - 0xFE0
;    _0   _1   _2   _3   _4   _5   _6   _7   _8   _9   _A   _B   _C   _D   _E   _F
db 0x3f,0x9f,0x00,0x5f,0xc0,0x20,0x82,0xe2,0x43,0xa4,0x05,0x66,0xc8,0x2a,0x8b,0xec  ; 0_  803f,809f,8100,815f,81c0,8220,8282,82e2,8343,83a4,8405,8466,84c8,852a,858b,85ec 0_
db 0x4f,0xb2,0x13,0x77,0xd8,0x3b,0x9d,0x00,0x63,0xc7,0x29,0x8c,0xf0,0x53,0xb7,0x1c  ; 1_  864f,86b2,8713,8777,87d8,883b,889d,8900,8963,89c7,8a29,8a8c,8af0,8b53,8bb7,8c1c 1_
db 0x7f,0xe3,0x47,0xab,0x10,0x76,0xd9,0x3e,0xa3,0x09,0x6d,0xd2,0x38,0x9e,0x04,0x69  ; 2_  8c7f,8ce3,8d47,8dab,8e10,8e76,8ed9,8f3e,8fa3,9009,906d,90d2,9138,919e,9204,9269 2_
db 0xcf,0x35,0x9b,0x02,0x68,0xcf,0x35,0x9d,0x03,0x6a,0xd1,0x38,0xa0,0x09,0x6f,0xd7  ; 3_  92cf,9335,939b,9402,9468,94cf,9535,959d,9603,966a,96d1,9738,97a0,9809,986f,98d7 3_
db 0x3f,0xa7,0x0f,0x78,0xe0,0x48,0xb1,0x1b,0x83,0xec,0x55,0xbe,0x28,0x92,0xfb,0x65  ; 4_  993f,99a7,9a0f,9a78,9ae0,9b48,9bb1,9c1b,9c83,9cec,9d55,9dbe,9e28,9e92,9efb,9f65 4_
db 0xcf,0x39,0xa4,0x0f,0x78,0xe2,0x4d,0xb8,0x23,0x8f,0xf9,0x64,0xd0,0x3c,0xa7,0x13  ; 5_  9fcf,a039,a0a4,a10f,a178,a1e2,a24d,a2b8,a323,a38f,a3f9,a464,a4d0,a53c,a5a7,a613 5_
db 0x7f,0xeb,0x57,0xc4,0x30,0x9d,0x09,0x76,0xe3,0x51,0xbd,0x2a,0x98,0x07,0x73,0xe1  ; 6_  a67f,a6eb,a757,a7c4,a830,a89d,a909,a976,a9e3,aa51,aabd,ab2a,ab98,ac07,ac73,ace1 6_
db 0x4f,0xbd,0x2b,0x9b,0x08,0x76,0xe5,0x53,0xc3,0x32,0xa1,0x10,0x81,0xf0,0x5f,0xcf  ; 7_  ad4f,adbd,ae2b,ae9b,af08,af76,afe5,b053,b0c3,b132,b1a1,b210,b281,b2f0,b35f,b3cf 7_
db 0x3f,0xaf,0x1f,0x8f,0x01,0x70,0xe1,0x52,0xc3,0x35,0xa5,0x16,0x88,0xf9,0x6b,0xdd  ; 8_  b43f,b4af,b51f,b58f,b601,b670,b6e1,b752,b7c3,b835,b8a5,b916,b988,b9f9,ba6b,badd 8_
db 0x4f,0xc1,0x33,0xa5,0x18,0x8b,0xfd,0x70,0xe3,0x56,0xc9,0x3d,0xb0,0x23,0x97,0x0b  ; 9_  bb4f,bbc1,bc33,bca5,bd18,bd8b,bdfd,be70,bee3,bf56,bfc9,c03d,c0b0,c123,c197,c20b 9_
db 0x7f,0xf4,0x67,0xdb,0x50,0xc4,0x39,0xae,0x23,0x98,0x0d,0x83,0xf8,0x6d,0xe4,0x5a  ; A_  c27f,c2f4,c367,c3db,c450,c4c4,c539,c5ae,c623,c698,c70d,c783,c7f8,c86d,c8e4,c95a A_
db 0xcf,0x45,0xbb,0x31,0xa8,0x1e,0x95,0x0c,0x83,0xfa,0x71,0xe9,0x60,0xd7,0x4f,0xc7  ; B_  c9cf,ca45,cabb,cb31,cba8,cc1e,cc95,cd0c,cd83,cdfa,ce71,cee9,cf60,cfd7,d04f,d0c7 B_
db 0x3f,0xb7,0x2f,0xa7,0x20,0x98,0x11,0x8b,0x03,0x7c,0xf5,0x6e,0xe8,0x61,0xdb,0x55  ; C_  d13f,d1b7,d22f,d2a7,d320,d398,d411,d48b,d503,d57c,d5f5,d66e,d6e8,d761,d7db,d855 C_
db 0xcf,0x49,0xc3,0x3d,0xb8,0x32,0xad,0x28,0xa3,0x1e,0x99,0x14,0x90,0x0b,0x87,0x03  ; D_  d8cf,d949,d9c3,da3d,dab8,db32,dbad,dc28,dca3,dd1e,dd99,de14,de90,df0b,df87,e003 D_
db 0x7f,0xfb,0x77,0xf3,0x70,0xec,0x69,0xe6,0x63,0xe0,0x5d,0xda,0x58,0xd5,0x53,0xd1  ; E_  e07f,e0fb,e177,e1f3,e270,e2ec,e369,e3e6,e463,e4e0,e55d,e5da,e658,e6d5,e753,e7d1 E_
db 0x4f,0xcd,0x4b,0xc9,0x48,0xc6,0x45,0xc4,0x43,0xc2,0x41,0xc0,0x40,0xbf,0x3f,0x00  ; F_  e84f,e8cd,e94b,e9c9,ea48,eac6,eb45,ebc4,ec43,ecc2,ed41,edc0,ee40,eebf,ef3f,  00 F_
;Tab_ApB_hi_1:	; tab _plus[i] - 0xFE0
;    _0   _1   _2   _3   _4   _5   _6   _7   _8   _9   _A   _B   _C   _D   _E   _F
db 0x80,0x80,0x81,0x81,0x81,0x82,0x82,0x82,0x83,0x83,0x84,0x84,0x84,0x85,0x85,0x85  ; 0_  
db 0x86,0x86,0x87,0x87,0x87,0x88,0x88,0x89,0x89,0x89,0x8a,0x8a,0x8a,0x8b,0x8b,0x8c  ; 1_  
db 0x8c,0x8c,0x8d,0x8d,0x8e,0x8e,0x8e,0x8f,0x8f,0x90,0x90,0x90,0x91,0x91,0x92,0x92  ; 2_  
db 0x92,0x93,0x93,0x94,0x94,0x94,0x95,0x95,0x96,0x96,0x96,0x97,0x97,0x98,0x98,0x98  ; 3_  
db 0x99,0x99,0x9a,0x9a,0x9a,0x9b,0x9b,0x9c,0x9c,0x9c,0x9d,0x9d,0x9e,0x9e,0x9e,0x9f  ; 4_  
db 0x9f,0xa0,0xa0,0xa1,0xa1,0xa1,0xa2,0xa2,0xa3,0xa3,0xa3,0xa4,0xa4,0xa5,0xa5,0xa6  ; 5_  
db 0xa6,0xa6,0xa7,0xa7,0xa8,0xa8,0xa9,0xa9,0xa9,0xaa,0xaa,0xab,0xab,0xac,0xac,0xac  ; 6_  
db 0xad,0xad,0xae,0xae,0xaf,0xaf,0xaf,0xb0,0xb0,0xb1,0xb1,0xb2,0xb2,0xb2,0xb3,0xb3  ; 7_  
db 0xb4,0xb4,0xb5,0xb5,0xb6,0xb6,0xb6,0xb7,0xb7,0xb8,0xb8,0xb9,0xb9,0xb9,0xba,0xba  ; 8_  
db 0xbb,0xbb,0xbc,0xbc,0xbd,0xbd,0xbd,0xbe,0xbe,0xbf,0xbf,0xc0,0xc0,0xc1,0xc1,0xc2  ; 9_  
db 0xc2,0xc2,0xc3,0xc3,0xc4,0xc4,0xc5,0xc5,0xc6,0xc6,0xc7,0xc7,0xc7,0xc8,0xc8,0xc9  ; A_  
db 0xc9,0xca,0xca,0xcb,0xcb,0xcc,0xcc,0xcd,0xcd,0xcd,0xce,0xce,0xcf,0xcf,0xd0,0xd0  ; B_  
db 0xd1,0xd1,0xd2,0xd2,0xd3,0xd3,0xd4,0xd4,0xd5,0xd5,0xd5,0xd6,0xd6,0xd7,0xd7,0xd8  ; C_  
db 0xd8,0xd9,0xd9,0xda,0xda,0xdb,0xdb,0xdc,0xdc,0xdd,0xdd,0xde,0xde,0xdf,0xdf,0xe0  ; D_  
db 0xe0,0xe0,0xe1,0xe1,0xe2,0xe2,0xe3,0xe3,0xe4,0xe4,0xe5,0xe5,0xe6,0xe6,0xe7,0xe7  ; E_  
db 0xe8,0xe8,0xe9,0xe9,0xea,0xea,0xeb,0xeb,0xec,0xec,0xed,0xed,0xee,0xee,0xef,0x00  ; F_ 

;Tab_ApB_lo_0:	; tab _plus[i] - 0xFE0
Tab_ApB:
;    _0   _1   _2   _3   _4   _5   _6   _7   _8   _9   _A   _B   _C   _D   _E   _F
db 0x3f,0x7f,0xbf,0xff,0x40,0x80,0xc1,0x02,0x43,0x84,0xc5,0x06,0x48,0x89,0xcb,0x0d  ; 0_  303f,307f,30bf,30ff,3140,3180,31c1,3202,3243,3284,32c5,3306,3348,3389,33cb,340d 0_
db 0x4f,0x91,0xd3,0x15,0x58,0x9a,0xdd,0x20,0x63,0xa6,0xe9,0x2c,0x70,0xb3,0xf7,0x3c  ; 1_  344f,3491,34d3,3515,3558,359a,35dd,3620,3663,36a6,36e9,372c,3770,37b3,37f7,383c 1_
db 0x7f,0xc3,0x07,0x4b,0x90,0xd5,0x19,0x5e,0xa3,0xe8,0x2d,0x72,0xb8,0xfd,0x44,0x89  ; 2_  387f,38c3,3907,394b,3990,39d5,3a19,3a5e,3aa3,3ae8,3b2d,3b72,3bb8,3bfd,3c44,3c89 2_
db 0xcf,0x15,0x5b,0xa1,0xe8,0x2f,0x75,0xbc,0x03,0x4a,0x91,0xd8,0x21,0x68,0xb0,0xf7  ; 3_  3ccf,3d15,3d5b,3da1,3de8,3e2f,3e75,3ebc,3f03,3f4a,3f91,3fd8,4021,4068,40b0,40f7 3_
db 0x3f,0x87,0xcf,0x18,0x61,0xa9,0xf1,0x3a,0x83,0xcb,0x15,0x5f,0xa8,0xf2,0x3b,0x85  ; 4_  413f,4187,41cf,4218,4261,42a9,42f1,433a,4383,43cb,4415,445f,44a8,44f2,453b,4585 4_
db 0xcf,0x19,0x64,0xaf,0xf8,0x42,0x8d,0xd8,0x23,0x6f,0xb9,0x04,0x50,0x9c,0xe7,0x33  ; 5_  45cf,4619,4664,46af,46f8,4742,478d,47d8,4823,486f,48b9,4904,4950,499c,49e7,4a33 5_
db 0x7f,0xcb,0x17,0x64,0xb0,0xfd,0x49,0x96,0xe3,0x30,0x7d,0xca,0x18,0x67,0xb3,0x01  ; 6_  4a7f,4acb,4b17,4b64,4bb0,4bfd,4c49,4c96,4ce3,4d30,4d7d,4dca,4e18,4e67,4eb3,4f01 6_
db 0x4f,0x9e,0xeb,0x3b,0x88,0xd6,0x25,0x73,0xc3,0x13,0x62,0xb0,0x00,0x4f,0xa0,0xef  ; 7_  4f4f,4f9e,4feb,503b,5088,50d6,5125,5173,51c3,5213,5262,52b0,5300,534f,53a0,53ef 7_
db 0x3f,0x8f,0xe0,0x30,0x80,0xd1,0x22,0x72,0xc3,0x15,0x65,0xb6,0x08,0x59,0xab,0xfd  ; 8_  543f,548f,54e0,5530,5580,55d1,5622,5672,56c3,5715,5765,57b6,5808,5859,58ab,58fd 8_
db 0x4f,0xa1,0xf3,0x45,0x98,0xec,0x3d,0x90,0xe3,0x35,0x89,0xdd,0x30,0x83,0xd7,0x2d  ; 9_  594f,59a1,59f3,5a45,5a98,5aec,5b3d,5b90,5be3,5c35,5c89,5cdd,5d30,5d83,5dd7,5e2d 9_
db 0x7f,0xd4,0x27,0x7c,0xd0,0x25,0x79,0xcd,0x23,0x78,0xcd,0x23,0x78,0xcc,0x24,0x7a  ; A_  5e7f,5ed4,5f27,5f7c,5fd0,6025,6079,60cd,6123,6178,61cd,6223,6278,62cc,6324,637a A_
db 0xcf,0x26,0x7b,0xd2,0x28,0x7e,0xd5,0x2e,0x83,0xda,0x31,0x89,0xe1,0x37,0x8f,0xe8  ; B_  63cf,6426,647b,64d2,6528,657e,65d5,662e,6683,66da,6731,6789,67e1,6837,688f,68e8 B_
db 0x3f,0x97,0xef,0x48,0xa1,0xf9,0x51,0xab,0x03,0x5c,0xb5,0x0e,0x68,0xc1,0x1b,0x74  ; C_  693f,6997,69ef,6a48,6aa1,6af9,6b51,6bab,6c03,6c5c,6cb5,6d0e,6d68,6dc1,6e1b,6e74 C_
db 0xcf,0x2a,0x84,0xde,0x38,0x93,0xed,0x48,0xa3,0xff,0x59,0xb5,0x10,0x6b,0xc7,0x23  ; D_  6ecf,6f2a,6f84,6fde,7038,7093,70ed,7148,71a3,71ff,7259,72b5,7310,736b,73c7,7423 D_
db 0x7f,0xdb,0x37,0x93,0xf0,0x4f,0xa9,0x07,0x63,0xc0,0x1d,0x7b,0xd8,0x35,0x93,0xf1  ; E_  747f,74db,7537,7593,75f0,764f,76a9,7707,7763,77c0,781d,787b,78d8,7935,7993,79f1 E_
db 0x4f,0xac,0x0b,0x69,0xc8,0x27,0x85,0xe4,0x43,0xa2,0x02,0x60,0xc0,0x1f,0x80,0xe0  ; F_  7a4f,7aac,7b0b,7b69,7bc8,7c27,7c85,7ce4,7d43,7da2,7e02,7e60,7ec0,7f1f,7f80,7fe0 F_
;Tab_ApB_hi_0:	; tab _plus[i] - 0xFE0
;    _0   _1   _2   _3   _4   _5   _6   _7   _8   _9   _A   _B   _C   _D   _E   _F
db 0x30,0x30,0x30,0x30,0x31,0x31,0x31,0x32,0x32,0x32,0x32,0x33,0x33,0x33,0x33,0x34  ; 0_  
db 0x34,0x34,0x34,0x35,0x35,0x35,0x35,0x36,0x36,0x36,0x36,0x37,0x37,0x37,0x37,0x38  ; 1_  
db 0x38,0x38,0x39,0x39,0x39,0x39,0x3a,0x3a,0x3a,0x3a,0x3b,0x3b,0x3b,0x3b,0x3c,0x3c  ; 2_  
db 0x3c,0x3d,0x3d,0x3d,0x3d,0x3e,0x3e,0x3e,0x3f,0x3f,0x3f,0x3f,0x40,0x40,0x40,0x40  ; 3_  
db 0x41,0x41,0x41,0x42,0x42,0x42,0x42,0x43,0x43,0x43,0x44,0x44,0x44,0x44,0x45,0x45  ; 4_  
db 0x45,0x46,0x46,0x46,0x46,0x47,0x47,0x47,0x48,0x48,0x48,0x49,0x49,0x49,0x49,0x4a  ; 5_  
db 0x4a,0x4a,0x4b,0x4b,0x4b,0x4b,0x4c,0x4c,0x4c,0x4d,0x4d,0x4d,0x4e,0x4e,0x4e,0x4f  ; 6_  
db 0x4f,0x4f,0x4f,0x50,0x50,0x50,0x51,0x51,0x51,0x52,0x52,0x52,0x53,0x53,0x53,0x53  ; 7_  
db 0x54,0x54,0x54,0x55,0x55,0x55,0x56,0x56,0x56,0x57,0x57,0x57,0x58,0x58,0x58,0x58  ; 8_  
db 0x59,0x59,0x59,0x5a,0x5a,0x5a,0x5b,0x5b,0x5b,0x5c,0x5c,0x5c,0x5d,0x5d,0x5d,0x5e  ; 9_  
db 0x5e,0x5e,0x5f,0x5f,0x5f,0x60,0x60,0x60,0x61,0x61,0x61,0x62,0x62,0x62,0x63,0x63  ; A_  
db 0x63,0x64,0x64,0x64,0x65,0x65,0x65,0x66,0x66,0x66,0x67,0x67,0x67,0x68,0x68,0x68  ; B_  
db 0x69,0x69,0x69,0x6a,0x6a,0x6a,0x6b,0x6b,0x6c,0x6c,0x6c,0x6d,0x6d,0x6d,0x6e,0x6e  ; C_  
db 0x6e,0x6f,0x6f,0x6f,0x70,0x70,0x70,0x71,0x71,0x71,0x72,0x72,0x73,0x73,0x73,0x74  ; D_  
db 0x74,0x74,0x75,0x75,0x75,0x76,0x76,0x77,0x77,0x77,0x78,0x78,0x78,0x79,0x79,0x79  ; E_  
db 0x7a,0x7a,0x7b,0x7b,0x7b,0x7c,0x7c,0x7c,0x7d,0x7d,0x7e,0x7e,0x7e,0x7f,0x7f,0x7f  ; F_  

; nic nemusi: 25482(38.882446%), musi pricitat 0x20: 40054(61.117554%), pretece pricteni: 0
; neni presne: 0 (0.000000%), chyb: 0, sum: 65536
    
; Align to 256-byte page boundary
DEFS    (($ + 0xFF) / 0x100) * 0x100 - $

; mantisa = 1
; 1 / ( 2**exp * mantisa ) = 2**(-exp) * 1
; // mantisa = 1.01 .. 1.99
; 1 / ( 2**exp * mantisa ) = 2**(-exp-1) * 2*1/mantisa
DIVTAB:
; lo
;    _0   _1   _2   _3   _4   _5   _6   _7   _8   _9   _A   _B   _C   _D   _E   _F
db 0x00,0xfe,0xfc,0xfa,0xf8,0xf6,0xf4,0xf2,0xf0,0xef,0xed,0xeb,0xe9,0xe7,0xe5,0xe4   ; 0_  00,fe,fc,fa,f8,f6,f4,f2,f0,ef,ed,eb,e9,e7,e5,e4 0_
db 0xe2,0xe0,0xde,0xdd,0xdb,0xd9,0xd7,0xd6,0xd4,0xd2,0xd1,0xcf,0xce,0xcc,0xca,0xc9   ; 1_  e2,e0,de,dd,db,d9,d7,d6,d4,d2,d1,cf,ce,cc,ca,c9 1_
db 0xc7,0xc6,0xc4,0xc2,0xc1,0xbf,0xbe,0xbc,0xbb,0xb9,0xb8,0xb6,0xb5,0xb3,0xb2,0xb1   ; 2_  c7,c6,c4,c2,c1,bf,be,bc,bb,b9,b8,b6,b5,b3,b2,b1 2_
db 0xaf,0xae,0xac,0xab,0xaa,0xa8,0xa7,0xa5,0xa4,0xa3,0xa1,0xa0,0x9f,0x9d,0x9c,0x9b   ; 3_  af,ae,ac,ab,aa,a8,a7,a5,a4,a3,a1,a0,9f,9d,9c,9b 3_
db 0x9a,0x98,0x97,0x96,0x95,0x93,0x92,0x91,0x90,0x8e,0x8d,0x8c,0x8b,0x8a,0x88,0x87   ; 4_  9a,98,97,96,95,93,92,91,90,8e,8d,8c,8b,8a,88,87 4_
db 0x86,0x85,0x84,0x83,0x82,0x80,0x7f,0x7e,0x7d,0x7c,0x7b,0x7a,0x79,0x78,0x76,0x75   ; 5_  86,85,84,83,82,80,7f,7e,7d,7c,7b,7a,79,78,76,75 5_
db 0x74,0x73,0x72,0x71,0x70,0x6f,0x6e,0x6d,0x6c,0x6b,0x6a,0x69,0x68,0x67,0x66,0x65   ; 6_  74,73,72,71,70,6f,6e,6d,6c,6b,6a,69,68,67,66,65 6_
db 0x64,0x63,0x62,0x61,0x60,0x5f,0x5e,0x5e,0x5d,0x5c,0x5b,0x5a,0x59,0x58,0x57,0x56   ; 7_  64,63,62,61,60,5f,5e,5e,5d,5c,5b,5a,59,58,57,56 7_
db 0x55,0x54,0x54,0x53,0x52,0x51,0x50,0x4f,0x4e,0x4e,0x4d,0x4c,0x4b,0x4a,0x49,0x49   ; 8_  55,54,54,53,52,51,50,4f,4e,4e,4d,4c,4b,4a,49,49 8_
db 0x48,0x47,0x46,0x45,0x44,0x44,0x43,0x42,0x41,0x40,0x40,0x3f,0x3e,0x3d,0x3d,0x3c   ; 9_  48,47,46,45,44,44,43,42,41,40,40,3f,3e,3d,3d,3c 9_
db 0x3b,0x3a,0x3a,0x39,0x38,0x37,0x37,0x36,0x35,0x34,0x34,0x33,0x32,0x32,0x31,0x30   ; A_  3b,3a,3a,39,38,37,37,36,35,34,34,33,32,32,31,30 A_
db 0x2f,0x2f,0x2e,0x2d,0x2d,0x2c,0x2b,0x2b,0x2a,0x29,0x29,0x28,0x27,0x27,0x26,0x25   ; B_  2f,2f,2e,2d,2d,2c,2b,2b,2a,29,29,28,27,27,26,25 B_
db 0x25,0x24,0x23,0x23,0x22,0x21,0x21,0x20,0x1f,0x1f,0x1e,0x1e,0x1d,0x1c,0x1c,0x1b   ; C_  25,24,23,23,22,21,21,20,1f,1f,1e,1e,1d,1c,1c,1b C_
db 0x1a,0x1a,0x19,0x19,0x18,0x17,0x17,0x16,0x16,0x15,0x15,0x14,0x13,0x13,0x12,0x12   ; D_  1a,1a,19,19,18,17,17,16,16,15,15,14,13,13,12,12 D_
db 0x11,0x10,0x10,0x0f,0x0f,0x0e,0x0e,0x0d,0x0d,0x0c,0x0b,0x0b,0x0a,0x0a,0x09,0x09   ; E_  11,10,10,0f,0f,0e,0e,0d,0d,0c,0b,0b,0a,0a,09,09 E_
db 0x08,0x08,0x07,0x07,0x06,0x06,0x05,0x05,0x04,0x04,0x03,0x03,0x02,0x02,0x01,0x01   ; F_  08,08,07,07,06,06,05,05,04,04,03,03,02,02,01,01 F_

; sum: 4294967296, rozdíl: má být mínus jest, nemohu se splést...
; nepřesnost o 1: 863749376 (20.111%)
; nepřesnost o 2: 0 (0.000%)
; nepřesnost o 3: 0 (0.000%)
;       chyb: 0 (0.000%)

; Align to 256-byte page boundary
DEFS    (($ + 0xFF) / 0x100) * 0x100 - $

; Mantissas of square roots
; (2**-3 * mantisa)**0.5 = 2**-1 * mantisa**0.5 * 2**-0.5 = 2**-2 * 2**0.5
; (2**-2 * mantisa)**0.5 = 2**-1 * mantisa**0.5
; (2**-1 * mantisa)**0.5 = 2**+0 * mantisa**0.5 * 2**-0.5 = 2**-1 * 2**0.5
; (2**+0 * mantisa)**0.5 = 2**+0 * mantisa**0.5
; (2**+1 * mantisa)**0.5 = 2**+0 * mantisa**0.5 * 2**0.5
; (2**+2 * mantisa)**0.5 = 2**+1 * mantisa**0.5
; (2**+3 * mantisa)**0.5 = 2**+1 * mantisa**0.5 * 2**0.5

; exp = 2*e
; (2**exp * mantisa)**0.5 = 2**e * mantisa**0.5
; exp = 2*e+1
; (2**exp * mantisa)**0.5 = 2**e * mantisa**0.5 * 2**0.5

SQR_TAB:
; lo exp=2*x
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0x00,0x00,0x01,0x01,0x02,0x02,0x03,0x03,0x04,0x04,0x05,0x05,0x06,0x06,0x07,0x07   ; 0_     00,00,01,01,02,02,03,03,04,04,05,05,06,06,07,07 0_
db 0x08,0x08,0x09,0x09,0x0a,0x0a,0x0b,0x0b,0x0c,0x0c,0x0d,0x0d,0x0e,0x0e,0x0f,0x0f   ; 1_     08,08,09,09,0a,0a,0b,0b,0c,0c,0d,0d,0e,0e,0f,0f 1_
db 0x10,0x10,0x10,0x11,0x11,0x12,0x12,0x13,0x13,0x14,0x14,0x15,0x15,0x16,0x16,0x17   ; 2_     10,10,10,11,11,12,12,13,13,14,14,15,15,16,16,17 2_
db 0x17,0x17,0x18,0x18,0x19,0x19,0x1a,0x1a,0x1b,0x1b,0x1c,0x1c,0x1c,0x1d,0x1d,0x1e   ; 3_     17,17,18,18,19,19,1a,1a,1b,1b,1c,1c,1c,1d,1d,1e 3_
db 0x1e,0x1f,0x1f,0x20,0x20,0x20,0x21,0x21,0x22,0x22,0x23,0x23,0x24,0x24,0x24,0x25   ; 4_     1e,1f,1f,20,20,20,21,21,22,22,23,23,24,24,24,25 4_
db 0x25,0x26,0x26,0x27,0x27,0x27,0x28,0x28,0x29,0x29,0x2a,0x2a,0x2a,0x2b,0x2b,0x2c   ; 5_     25,26,26,27,27,27,28,28,29,29,2a,2a,2a,2b,2b,2c 5_
db 0x2c,0x2d,0x2d,0x2d,0x2e,0x2e,0x2f,0x2f,0x30,0x30,0x30,0x31,0x31,0x32,0x32,0x33   ; 6_     2c,2d,2d,2d,2e,2e,2f,2f,30,30,30,31,31,32,32,33 6_
db 0x33,0x33,0x34,0x34,0x35,0x35,0x35,0x36,0x36,0x37,0x37,0x37,0x38,0x38,0x39,0x39   ; 7_     33,33,34,34,35,35,35,36,36,37,37,37,38,38,39,39 7_
db 0x3a,0x3a,0x3a,0x3b,0x3b,0x3c,0x3c,0x3c,0x3d,0x3d,0x3e,0x3e,0x3e,0x3f,0x3f,0x40   ; 8_     3a,3a,3a,3b,3b,3c,3c,3c,3d,3d,3e,3e,3e,3f,3f,40 8_
db 0x40,0x40,0x41,0x41,0x42,0x42,0x42,0x43,0x43,0x44,0x44,0x44,0x45,0x45,0x46,0x46   ; 9_     40,40,41,41,42,42,42,43,43,44,44,44,45,45,46,46 9_
db 0x46,0x47,0x47,0x48,0x48,0x48,0x49,0x49,0x49,0x4a,0x4a,0x4b,0x4b,0x4b,0x4c,0x4c   ; A_     46,47,47,48,48,48,49,49,49,4a,4a,4b,4b,4b,4c,4c A_
db 0x4d,0x4d,0x4d,0x4e,0x4e,0x4e,0x4f,0x4f,0x50,0x50,0x50,0x51,0x51,0x52,0x52,0x52   ; B_     4d,4d,4d,4e,4e,4e,4f,4f,50,50,50,51,51,52,52,52 B_
db 0x53,0x53,0x53,0x54,0x54,0x55,0x55,0x55,0x56,0x56,0x56,0x57,0x57,0x58,0x58,0x58   ; C_     53,53,53,54,54,55,55,55,56,56,56,57,57,58,58,58 C_
db 0x59,0x59,0x59,0x5a,0x5a,0x5b,0x5b,0x5b,0x5c,0x5c,0x5c,0x5d,0x5d,0x5d,0x5e,0x5e   ; D_     59,59,59,5a,5a,5b,5b,5b,5c,5c,5c,5d,5d,5d,5e,5e D_
db 0x5f,0x5f,0x5f,0x60,0x60,0x60,0x61,0x61,0x61,0x62,0x62,0x63,0x63,0x63,0x64,0x64   ; E_     5f,5f,5f,60,60,60,61,61,61,62,62,63,63,63,64,64 E_
db 0x64,0x65,0x65,0x65,0x66,0x66,0x66,0x67,0x67,0x68,0x68,0x68,0x69,0x69,0x69,0x6a   ; F_     64,65,65,65,66,66,66,67,67,68,68,68,69,69,69,6a F_
; lo exp=2*x+1
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0x6a,0x6b,0x6b,0x6c,0x6d,0x6e,0x6e,0x6f,0x70,0x70,0x71,0x72,0x72,0x73,0x74,0x74   ; 0_     6a,6b,6b,6c,6d,6e,6e,6f,70,70,71,72,72,73,74,74 0_
db 0x75,0x76,0x77,0x77,0x78,0x79,0x79,0x7a,0x7b,0x7b,0x7c,0x7d,0x7d,0x7e,0x7f,0x7f   ; 1_     75,76,77,77,78,79,79,7a,7b,7b,7c,7d,7d,7e,7f,7f 1_
db 0x80,0x81,0x81,0x82,0x83,0x83,0x84,0x85,0x85,0x86,0x87,0x87,0x88,0x89,0x89,0x8a   ; 2_     80,81,81,82,83,83,84,85,85,86,87,87,88,89,89,8a 2_
db 0x8b,0x8b,0x8c,0x8c,0x8d,0x8e,0x8e,0x8f,0x90,0x90,0x91,0x92,0x92,0x93,0x94,0x94   ; 3_     8b,8b,8c,8c,8d,8e,8e,8f,90,90,91,92,92,93,94,94 3_
db 0x95,0x95,0x96,0x97,0x97,0x98,0x99,0x99,0x9a,0x9a,0x9b,0x9c,0x9c,0x9d,0x9e,0x9e   ; 4_     95,95,96,97,97,98,99,99,9a,9a,9b,9c,9c,9d,9e,9e 4_
db 0x9f,0x9f,0xa0,0xa1,0xa1,0xa2,0xa2,0xa3,0xa4,0xa4,0xa5,0xa6,0xa6,0xa7,0xa7,0xa8   ; 5_     9f,9f,a0,a1,a1,a2,a2,a3,a4,a4,a5,a6,a6,a7,a7,a8 5_
db 0xa9,0xa9,0xaa,0xaa,0xab,0xac,0xac,0xad,0xad,0xae,0xaf,0xaf,0xb0,0xb0,0xb1,0xb1   ; 6_     a9,a9,aa,aa,ab,ac,ac,ad,ad,ae,af,af,b0,b0,b1,b1 6_
db 0xb2,0xb3,0xb3,0xb4,0xb4,0xb5,0xb6,0xb6,0xb7,0xb7,0xb8,0xb9,0xb9,0xba,0xba,0xbb   ; 7_     b2,b3,b3,b4,b4,b5,b6,b6,b7,b7,b8,b9,b9,ba,ba,bb 7_
db 0xbb,0xbc,0xbd,0xbd,0xbe,0xbe,0xbf,0xbf,0xc0,0xc1,0xc1,0xc2,0xc2,0xc3,0xc3,0xc4   ; 8_     bb,bc,bd,bd,be,be,bf,bf,c0,c1,c1,c2,c2,c3,c3,c4 8_
db 0xc5,0xc5,0xc6,0xc6,0xc7,0xc7,0xc8,0xc8,0xc9,0xca,0xca,0xcb,0xcb,0xcc,0xcc,0xcd   ; 9_     c5,c5,c6,c6,c7,c7,c8,c8,c9,ca,ca,cb,cb,cc,cc,cd 9_
db 0xce,0xce,0xcf,0xcf,0xd0,0xd0,0xd1,0xd1,0xd2,0xd2,0xd3,0xd4,0xd4,0xd5,0xd5,0xd6   ; A_     ce,ce,cf,cf,d0,d0,d1,d1,d2,d2,d3,d4,d4,d5,d5,d6 A_
db 0xd6,0xd7,0xd7,0xd8,0xd8,0xd9,0xda,0xda,0xdb,0xdb,0xdc,0xdc,0xdd,0xdd,0xde,0xde   ; B_     d6,d7,d7,d8,d8,d9,da,da,db,db,dc,dc,dd,dd,de,de B_
db 0xdf,0xdf,0xe0,0xe1,0xe1,0xe2,0xe2,0xe3,0xe3,0xe4,0xe4,0xe5,0xe5,0xe6,0xe6,0xe7   ; C_     df,df,e0,e1,e1,e2,e2,e3,e3,e4,e4,e5,e5,e6,e6,e7 C_
db 0xe7,0xe8,0xe8,0xe9,0xea,0xea,0xeb,0xeb,0xec,0xec,0xed,0xed,0xee,0xee,0xef,0xef   ; D_     e7,e8,e8,e9,ea,ea,eb,eb,ec,ec,ed,ed,ee,ee,ef,ef D_
db 0xf0,0xf0,0xf1,0xf1,0xf2,0xf2,0xf3,0xf3,0xf4,0xf4,0xf5,0xf5,0xf6,0xf6,0xf7,0xf7   ; E_     f0,f0,f1,f1,f2,f2,f3,f3,f4,f4,f5,f5,f6,f6,f7,f7 E_
db 0xf8,0xf8,0xf9,0xf9,0xfa,0xfa,0xfb,0xfb,0xfc,0xfc,0xfd,0xfd,0xfe,0xfe,0xff,0xff   ; F_     f8,f8,f9,f9,fa,fa,fb,fb,fc,fc,fd,fd,fe,fe,ff,ff F_

; Align to 256-byte page boundary
DEFS    (($ + 0xFF) / 0x100) * 0x100 - $

; ln(2^exp*man) = ln(2^exp) + ln(man) = ln(2)*exp + ln(man) = ln2_exp[e] + ln_m[m]
Ln_M:
; lo
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0x00,0xff,0xfe,0x7e,0xfc,0x3d,0x7c,0xba,0xf8,0x1b,0x3a,0x59,0x77,0x96,0xb4,0xd2   ; 0_     0000,37ff,38fe,397e,39fc,3a3d,3a7c,3aba,3af8,3b1b,3b3a,3b59,3b77,3b96,3bb4,3bd2 0_
db 0xf1,0x07,0x16,0x25,0x34,0x43,0x52,0x60,0x6f,0x7e,0x8c,0x9b,0xa9,0xb8,0xc6,0xd4   ; 1_     3bf1,3c07,3c16,3c25,3c34,3c43,3c52,3c60,3c6f,3c7e,3c8c,3c9b,3ca9,3cb8,3cc6,3cd4 1_
db 0xe2,0xf1,0xff,0x06,0x0d,0x14,0x1b,0x22,0x29,0x30,0x37,0x3e,0x45,0x4c,0x52,0x59   ; 2_     3ce2,3cf1,3cff,3d06,3d0d,3d14,3d1b,3d22,3d29,3d30,3d37,3d3e,3d45,3d4c,3d52,3d59 2_
db 0x60,0x67,0x6d,0x74,0x7b,0x81,0x88,0x8f,0x95,0x9c,0xa2,0xa9,0xaf,0xb6,0xbc,0xc3   ; 3_     3d60,3d67,3d6d,3d74,3d7b,3d81,3d88,3d8f,3d95,3d9c,3da2,3da9,3daf,3db6,3dbc,3dc3 3_
db 0xc9,0xcf,0xd6,0xdc,0xe2,0xe9,0xef,0xf5,0xfc,0x01,0x04,0x07,0x0a,0x0d,0x10,0x13   ; 4_     3dc9,3dcf,3dd6,3ddc,3de2,3de9,3def,3df5,3dfc,3e01,3e04,3e07,3e0a,3e0d,3e10,3e13 4_
db 0x16,0x1a,0x1d,0x20,0x23,0x26,0x29,0x2c,0x2f,0x32,0x34,0x37,0x3a,0x3d,0x40,0x43   ; 5_     3e16,3e1a,3e1d,3e20,3e23,3e26,3e29,3e2c,3e2f,3e32,3e34,3e37,3e3a,3e3d,3e40,3e43 5_
db 0x46,0x49,0x4c,0x4f,0x52,0x55,0x57,0x5a,0x5d,0x60,0x63,0x66,0x68,0x6b,0x6e,0x71   ; 6_     3e46,3e49,3e4c,3e4f,3e52,3e55,3e57,3e5a,3e5d,3e60,3e63,3e66,3e68,3e6b,3e6e,3e71 6_
db 0x74,0x76,0x79,0x7c,0x7f,0x81,0x84,0x87,0x8a,0x8c,0x8f,0x92,0x94,0x97,0x9a,0x9d   ; 7_     3e74,3e76,3e79,3e7c,3e7f,3e81,3e84,3e87,3e8a,3e8c,3e8f,3e92,3e94,3e97,3e9a,3e9d 7_
db 0x9f,0xa2,0xa5,0xa7,0xaa,0xac,0xaf,0xb2,0xb4,0xb7,0xba,0xbc,0xbf,0xc1,0xc4,0xc6   ; 8_     3e9f,3ea2,3ea5,3ea7,3eaa,3eac,3eaf,3eb2,3eb4,3eb7,3eba,3ebc,3ebf,3ec1,3ec4,3ec6 8_
db 0xc9,0xcc,0xce,0xd1,0xd3,0xd6,0xd8,0xdb,0xdd,0xe0,0xe2,0xe5,0xe7,0xea,0xec,0xef   ; 9_     3ec9,3ecc,3ece,3ed1,3ed3,3ed6,3ed8,3edb,3edd,3ee0,3ee2,3ee5,3ee7,3eea,3eec,3eef 9_
db 0xf1,0xf4,0xf6,0xf9,0xfb,0xfd,0x00,0x01,0x02,0x04,0x05,0x06,0x07,0x08,0x0a,0x0b   ; A_     3ef1,3ef4,3ef6,3ef9,3efb,3efd,3f00,3f01,3f02,3f04,3f05,3f06,3f07,3f08,3f0a,3f0b A_
db 0x0c,0x0d,0x0e,0x0f,0x11,0x12,0x13,0x14,0x15,0x16,0x18,0x19,0x1a,0x1b,0x1c,0x1d   ; B_     3f0c,3f0d,3f0e,3f0f,3f11,3f12,3f13,3f14,3f15,3f16,3f18,3f19,3f1a,3f1b,3f1c,3f1d B_
db 0x1f,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x28,0x29,0x2a,0x2b,0x2c,0x2d,0x2e,0x2f   ; C_     3f1f,3f20,3f21,3f22,3f23,3f24,3f25,3f26,3f28,3f29,3f2a,3f2b,3f2c,3f2d,3f2e,3f2f C_
db 0x30,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3a,0x3b,0x3c,0x3e,0x3f,0x40,0x41   ; D_     3f30,3f32,3f33,3f34,3f35,3f36,3f37,3f38,3f39,3f3a,3f3b,3f3c,3f3e,3f3f,3f40,3f41 D_
db 0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x50,0x51,0x52   ; E_     3f42,3f43,3f44,3f45,3f46,3f47,3f48,3f49,3f4a,3f4b,3f4c,3f4d,3f4e,3f50,3f51,3f52 E_
db 0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5a,0x5b,0x5c,0x5d,0x5e,0x5f,0x60,0x61,0x62   ; F_     3f53,3f54,3f55,3f56,3f57,3f58,3f59,3f5a,3f5b,3f5c,3f5d,3f5e,3f5f,3f60,3f61,3f62 F_
; hi
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0x00,0x37,0x38,0x39,0x39,0x3a,0x3a,0x3a,0x3a,0x3b,0x3b,0x3b,0x3b,0x3b,0x3b,0x3b   ; 0_  
db 0x3b,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c,0x3c   ; 1_  
db 0x3c,0x3c,0x3c,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d   ; 2_  
db 0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d   ; 3_  
db 0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3d,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e   ; 4_  
db 0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e   ; 5_  
db 0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e   ; 6_  
db 0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e   ; 7_  
db 0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e   ; 8_  
db 0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3e   ; 9_  
db 0x3e,0x3e,0x3e,0x3e,0x3e,0x3e,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f   ; A_  
db 0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f   ; B_  
db 0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f   ; C_  
db 0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f   ; D_  
db 0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f   ; E_  
db 0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f,0x3f   ; F_  

; Numbers with exponent -1 ($3f) have lower result accuracy
Ln2_Exp:
dw 0xc563	; -64*ln(2) = -44.3614
dw 0xc55d	; -63*ln(2) = -43.6683
dw 0xc558	; -62*ln(2) = -42.9751
dw 0xc552	; -61*ln(2) = -42.2820
dw 0xc54d	; -60*ln(2) = -41.5888
dw 0xc547	; -59*ln(2) = -40.8957
dw 0xc542	; -58*ln(2) = -40.2025
dw 0xc53c	; -57*ln(2) = -39.5094
dw 0xc537	; -56*ln(2) = -38.8162
dw 0xc531	; -55*ln(2) = -38.1231
dw 0xc52b	; -54*ln(2) = -37.4299
dw 0xc526	; -53*ln(2) = -36.7368
dw 0xc520	; -52*ln(2) = -36.0437
dw 0xc51b	; -51*ln(2) = -35.3505
dw 0xc515	; -50*ln(2) = -34.6574
dw 0xc510	; -49*ln(2) = -33.9642
dw 0xc50a	; -48*ln(2) = -33.2711
dw 0xc505	; -47*ln(2) = -32.5779
dw 0xc4fe	; -46*ln(2) = -31.8848
dw 0xc4f3	; -45*ln(2) = -31.1916
dw 0xc4e8	; -44*ln(2) = -30.4985
dw 0xc4dd	; -43*ln(2) = -29.8053
dw 0xc4d2	; -42*ln(2) = -29.1122
dw 0xc4c7	; -41*ln(2) = -28.4190
dw 0xc4bc	; -40*ln(2) = -27.7259
dw 0xc4b1	; -39*ln(2) = -27.0327
dw 0xc4a5	; -38*ln(2) = -26.3396
dw 0xc49a	; -37*ln(2) = -25.6464
dw 0xc48f	; -36*ln(2) = -24.9533
dw 0xc484	; -35*ln(2) = -24.2602
dw 0xc479	; -34*ln(2) = -23.5670
dw 0xc46e	; -33*ln(2) = -22.8739
dw 0xc463	; -32*ln(2) = -22.1807
dw 0xc458	; -31*ln(2) = -21.4876
dw 0xc44d	; -30*ln(2) = -20.7944
dw 0xc442	; -29*ln(2) = -20.1013
dw 0xc437	; -28*ln(2) = -19.4081
dw 0xc42b	; -27*ln(2) = -18.7150
dw 0xc420	; -26*ln(2) = -18.0218
dw 0xc415	; -25*ln(2) = -17.3287
dw 0xc40a	; -24*ln(2) = -16.6355
dw 0xc3fe	; -23*ln(2) = -15.9424
dw 0xc3e8	; -22*ln(2) = -15.2492
dw 0xc3d2	; -21*ln(2) = -14.5561
dw 0xc3bc	; -20*ln(2) = -13.8629
dw 0xc3a5	; -19*ln(2) = -13.1698
dw 0xc38f	; -18*ln(2) = -12.4766
dw 0xc379	; -17*ln(2) = -11.7835
dw 0xc363	; -16*ln(2) = -11.0904
dw 0xc34d	; -15*ln(2) = -10.3972
dw 0xc337	; -14*ln(2) = -9.7041
dw 0xc320	; -13*ln(2) = -9.0109
dw 0xc30a	; -12*ln(2) = -8.3178
dw 0xc2e8	; -11*ln(2) = -7.6246
dw 0xc2bc	; -10*ln(2) = -6.9315
dw 0xc28f	; -9*ln(2) = -6.2383
dw 0xc263	; -8*ln(2) = -5.5452
dw 0xc237	; -7*ln(2) = -4.8520
dw 0xc20a	; -6*ln(2) = -4.1589
dw 0xc1bc	; -5*ln(2) = -3.4657
dw 0xc163	; -4*ln(2) = -2.7726
dw 0xc10a	; -3*ln(2) = -2.0794
dw 0xc063	; -2*ln(2) = -1.3863
dw 0xbf63	; -1*ln(2) = -0.6931
dw 0x0000	; 0*ln(2) = 0.0000
dw 0x3f63	; 1*ln(2) = 0.6931
dw 0x4063	; 2*ln(2) = 1.3863
dw 0x410a	; 3*ln(2) = 2.0794
dw 0x4163	; 4*ln(2) = 2.7726
dw 0x41bc	; 5*ln(2) = 3.4657
dw 0x420a	; 6*ln(2) = 4.1589
dw 0x4237	; 7*ln(2) = 4.8520
dw 0x4263	; 8*ln(2) = 5.5452
dw 0x428f	; 9*ln(2) = 6.2383
dw 0x42bc	; 10*ln(2) = 6.9315
dw 0x42e8	; 11*ln(2) = 7.6246
dw 0x430a	; 12*ln(2) = 8.3178
dw 0x4320	; 13*ln(2) = 9.0109
dw 0x4337	; 14*ln(2) = 9.7041
dw 0x434d	; 15*ln(2) = 10.3972
dw 0x4363	; 16*ln(2) = 11.0904
dw 0x4379	; 17*ln(2) = 11.7835
dw 0x438f	; 18*ln(2) = 12.4766
dw 0x43a5	; 19*ln(2) = 13.1698
dw 0x43bc	; 20*ln(2) = 13.8629
dw 0x43d2	; 21*ln(2) = 14.5561
dw 0x43e8	; 22*ln(2) = 15.2492
dw 0x43fe	; 23*ln(2) = 15.9424
dw 0x440a	; 24*ln(2) = 16.6355
dw 0x4415	; 25*ln(2) = 17.3287
dw 0x4420	; 26*ln(2) = 18.0218
dw 0x442b	; 27*ln(2) = 18.7150
dw 0x4437	; 28*ln(2) = 19.4081
dw 0x4442	; 29*ln(2) = 20.1013
dw 0x444d	; 30*ln(2) = 20.7944
dw 0x4458	; 31*ln(2) = 21.4876
dw 0x4463	; 32*ln(2) = 22.1807
dw 0x446e	; 33*ln(2) = 22.8739
dw 0x4479	; 34*ln(2) = 23.5670
dw 0x4484	; 35*ln(2) = 24.2602
dw 0x448f	; 36*ln(2) = 24.9533
dw 0x449a	; 37*ln(2) = 25.6464
dw 0x44a5	; 38*ln(2) = 26.3396
dw 0x44b1	; 39*ln(2) = 27.0327
dw 0x44bc	; 40*ln(2) = 27.7259
dw 0x44c7	; 41*ln(2) = 28.4190
dw 0x44d2	; 42*ln(2) = 29.1122
dw 0x44dd	; 43*ln(2) = 29.8053
dw 0x44e8	; 44*ln(2) = 30.4985
dw 0x44f3	; 45*ln(2) = 31.1916
dw 0x44fe	; 46*ln(2) = 31.8848
dw 0x4505	; 47*ln(2) = 32.5779
dw 0x450a	; 48*ln(2) = 33.2711
dw 0x4510	; 49*ln(2) = 33.9642
dw 0x4515	; 50*ln(2) = 34.6574
dw 0x451b	; 51*ln(2) = 35.3505
dw 0x4520	; 52*ln(2) = 36.0437
dw 0x4526	; 53*ln(2) = 36.7368
dw 0x452b	; 54*ln(2) = 37.4299
dw 0x4531	; 55*ln(2) = 38.1231
dw 0x4537	; 56*ln(2) = 38.8162
dw 0x453c	; 57*ln(2) = 39.5094
dw 0x4542	; 58*ln(2) = 40.2025
dw 0x4547	; 59*ln(2) = 40.8957
dw 0x454d	; 60*ln(2) = 41.5888
dw 0x4552	; 61*ln(2) = 42.2820
dw 0x4558	; 62*ln(2) = 42.9751
dw 0x455d	; 63*ln(2) = 43.6683


; rozdíl: má být mínus jest, nemohu se splést...
; nepřesnost: 7888 (24.0723 %)
;       chyb: 49 (0.1495 %)

Ln_FIX:
; lo
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0x63,0x61,0x5f,0x5d,0x5b,0x59,0x57,0x55,0x53,0x51,0x4f,0x4d,0x4b,0x4a,0x48,0x46   ; 0_     bf63,bf61,bf5f,bf5d,bf5b,bf59,bf57,bf55,bf53,bf51,bf4f,bf4d,bf4b,bf4a,bf48,bf46 0_
db 0x44,0x42,0x40,0x3e,0x3c,0x3b,0x39,0x37,0x35,0x33,0x31,0x30,0x2e,0x2c,0x2a,0x28   ; 1_     bf44,bf42,bf40,bf3e,bf3c,bf3b,bf39,bf37,bf35,bf33,bf31,bf30,bf2e,bf2c,bf2a,bf28 1_
db 0x27,0x25,0x23,0x21,0x20,0x1e,0x1c,0x1a,0x19,0x17,0x15,0x13,0x12,0x10,0x0e,0x0d   ; 2_     bf27,bf25,bf23,bf21,bf20,bf1e,bf1c,bf1a,bf19,bf17,bf15,bf13,bf12,bf10,bf0e,bf0d 2_
db 0x0b,0x09,0x08,0x06,0x04,0x03,0x01,0xfe,0xfb,0xf8,0xf5,0xf1,0xee,0xeb,0xe8,0xe4   ; 3_     bf0b,bf09,bf08,bf06,bf04,bf03,bf01,befe,befb,bef8,bef5,bef1,beee,beeb,bee8,bee4 3_
db 0xe1,0xde,0xdb,0xd8,0xd5,0xd1,0xce,0xcb,0xc8,0xc5,0xc2,0xbf,0xbc,0xb9,0xb5,0xb2   ; 4_     bee1,bede,bedb,bed8,bed5,bed1,bece,becb,bec8,bec5,bec2,bebf,bebc,beb9,beb5,beb2 4_
db 0xaf,0xac,0xa9,0xa6,0xa3,0xa0,0x9d,0x9a,0x97,0x94,0x91,0x8e,0x8b,0x88,0x86,0x83   ; 5_     beaf,beac,bea9,bea6,bea3,bea0,be9d,be9a,be97,be94,be91,be8e,be8b,be88,be86,be83 5_
db 0x80,0x7d,0x7a,0x77,0x74,0x71,0x6e,0x6c,0x69,0x66,0x63,0x60,0x5d,0x5b,0x58,0x55   ; 6_     be80,be7d,be7a,be77,be74,be71,be6e,be6c,be69,be66,be63,be60,be5d,be5b,be58,be55 6_
db 0x52,0x4f,0x4d,0x4a,0x47,0x44,0x42,0x3f,0x3c,0x39,0x37,0x34,0x31,0x2f,0x2c,0x29   ; 7_     be52,be4f,be4d,be4a,be47,be44,be42,be3f,be3c,be39,be37,be34,be31,be2f,be2c,be29 7_
db 0x27,0x24,0x21,0x1f,0x1c,0x19,0x17,0x14,0x11,0x0f,0x0c,0x0a,0x07,0x04,0x02,0xff   ; 8_     be27,be24,be21,be1f,be1c,be19,be17,be14,be11,be0f,be0c,be0a,be07,be04,be02,bdff 8_
db 0xfa,0xf4,0xef,0xea,0xe5,0xe0,0xdb,0xd6,0xd1,0xcc,0xc7,0xc2,0xbd,0xb8,0xb3,0xae   ; 9_     bdfa,bdf4,bdef,bdea,bde5,bde0,bddb,bdd6,bdd1,bdcc,bdc7,bdc2,bdbd,bdb8,bdb3,bdae 9_
db 0xa9,0xa4,0x9f,0x9b,0x96,0x91,0x8c,0x87,0x82,0x7d,0x79,0x74,0x6f,0x6a,0x65,0x61   ; A_     bda9,bda4,bd9f,bd9b,bd96,bd91,bd8c,bd87,bd82,bd7d,bd79,bd74,bd6f,bd6a,bd65,bd61 A_
db 0x5c,0x57,0x52,0x4e,0x49,0x44,0x40,0x3b,0x36,0x32,0x2d,0x28,0x24,0x1f,0x1b,0x16   ; B_     bd5c,bd57,bd52,bd4e,bd49,bd44,bd40,bd3b,bd36,bd32,bd2d,bd28,bd24,bd1f,bd1b,bd16 B_
db 0x11,0x0d,0x08,0x04,0xff,0xf5,0xec,0xe3,0xda,0xd1,0xc9,0xc0,0xb7,0xae,0xa5,0x9c   ; C_     bd11,bd0d,bd08,bd04,bcff,bcf5,bcec,bce3,bcda,bcd1,bcc9,bcc0,bcb7,bcae,bca5,bc9c C_
db 0x93,0x8a,0x82,0x79,0x70,0x67,0x5f,0x56,0x4d,0x45,0x3c,0x33,0x2b,0x22,0x19,0x11   ; D_     bc93,bc8a,bc82,bc79,bc70,bc67,bc5f,bc56,bc4d,bc45,bc3c,bc33,bc2b,bc22,bc19,bc11 D_
db 0x08,0x00,0xef,0xde,0xcd,0xbc,0xab,0x9a,0x89,0x79,0x68,0x57,0x46,0x36,0x25,0x15   ; E_     bc08,bc00,bbef,bbde,bbcd,bbbc,bbab,bb9a,bb89,bb79,bb68,bb57,bb46,bb36,bb25,bb15 E_
db 0x04,0xe7,0xc6,0xa5,0x85,0x64,0x43,0x23,0x02,0xc3,0x82,0x42,0x01,0x81,0x01,0x00   ; F_     bb04,bae7,bac6,baa5,ba85,ba64,ba43,ba23,ba02,b9c3,b982,b942,b901,b881,b801,b700 F_
; hi
;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
db 0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf   ; 0_  
db 0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf   ; 1_  
db 0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf   ; 2_  
db 0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe   ; 3_  
db 0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe   ; 4_  
db 0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe   ; 5_  
db 0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe   ; 6_  
db 0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe   ; 7_  
db 0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbe,0xbd   ; 8_  
db 0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd   ; 9_  
db 0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd   ; A_  
db 0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd,0xbd   ; B_  
db 0xbd,0xbd,0xbd,0xbd,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc   ; C_  
db 0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc,0xbc   ; D_  
db 0xbc,0xbc,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb,0xbb   ; E_  
db 0xbb,0xba,0xba,0xba,0xba,0xba,0xba,0xba,0xba,0xb9,0xb9,0xb9,0xb9,0xb8,0xb8,0xb7   ; F_

; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_S16:
    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, PRINT_U16  ; 2:7/12
    
    xor   A             ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    L, A          ; 1:4       neg
    sbc   A, H          ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    H, A          ; 1:4       neg
    
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      ld   BC, ** 
    
    ; fall to print_u16
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, AF', BC, DE, HL = DE, DE = (SP)
PRINT_U16:
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A

; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_U16_ONLY:
    call BIN2DEC        ; 3:17
    pop  BC             ; 1:10      ret
    ex   DE, HL         ; 1:4
    pop  DE             ; 1:10
    push BC             ; 1:10      ret
    ret                 ; 1:10

; Input: HL = number
; Output: print number
; Pollutes: AF, HL, BC
BIN2DEC:
    xor   A             ; 1:4       A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10
    call BIN2DEC_CHAR+2 ; 3:17    
    ld   BC, -1000      ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld   BC, -100       ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld    C, -10        ; 2:7
    call BIN2DEC_CHAR   ; 3:17
    ld    A, L          ; 1:4
    add   A,'0'         ; 2:7
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10
    
BIN2DEC_CHAR:
    and  0xF0           ; 2:7       '0'..'9' => '0', unchanged 0
    
    add  HL, BC         ; 1:11
    inc   A             ; 1:4
    jr    c, $-2        ; 2:7/12
    sbc  HL, BC         ; 2:15
    dec   A             ; 1:4
    ret   z             ; 1:5/11
    
    or   '0'            ; 2:7       0 => '0', unchanged '0'..'9'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10
VARIABLE_SECTION:

STRING_SECTION:
string117:
db 0xD, "Data stack OK!", 0xD
size117 EQU $ - string117
string116:
db "RAS:"
size116 EQU $ - string116
string115:
db ":  a%b -> "
size115 EQU $ - string115
string114:
db " % "
size114 EQU $ - string114
string113:
db ":  ln -> "
size113 EQU $ - string113
string112:
db ": exp -> "
size112 EQU $ - string112
string111:
db ": sin -> "
size111 EQU $ - string111
string110:
db ": sin -> "
size110 EQU $ - string110
string109:
db ": sin -> "
size109 EQU $ - string109
string108:
db ": sin -> "
size108 EQU $ - string108
string107:
db ": sin -> "
size107 EQU $ - string107
string106:
db ": sin -> "
size106 EQU $ - string106
string105:
db ": sin -> "
size105 EQU $ - string105
string104:
db ": sin -> "
size104 EQU $ - string104
string103:
db ": sin -> "
size103 EQU $ - string103
string102:
db ": sin -> "
size102 EQU $ - string102
string101:
db ": sin -> "
size101 EQU $ - string101



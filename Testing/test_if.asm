; vvvvv
; ^^^^^
ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    ld  hl, stack_test
    push hl

    
    push DE             ; 1:11      push2(5,-5)
    ld   DE, 5          ; 3:10      push2(5,-5)
    push HL             ; 1:11      push2(5,-5)
    ld   HL, -5         ; 3:10      push2(5,-5) 
    call dtest          ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push2(5,5)
    ld   DE, 5          ; 3:10      push2(5,5)
    push HL             ; 1:11      push2(5,5)
    ld   HL, 5          ; 3:10      push2(5,5) 
    call dtest          ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push2(-5,-5)
    ld   DE, -5         ; 3:10      push2(-5,-5)
    push HL             ; 1:11      push2(-5,-5)
    ld   HL, -5         ; 3:10      push2(-5,-5) 
    call dtest          ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push2(-5,5)
    ld   DE, -5         ; 3:10      push2(-5,5)
    push HL             ; 1:11      push2(-5,5)
    ld   HL, 5          ; 3:10      push2(-5,5) 
    call dtest          ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call ptestp3        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call ptestp3        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call ptestm3        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call ptestm3        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    exx
    push HL
    exx
    pop HL
    
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    ret
    

;   ---  b e g i n  ---
dtest:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else101  EQU $          ;           = endif
endif101:
     
    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if 
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else102  EQU $          ;           = endif
endif102:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       = if
    sbc  HL, DE         ; 2:15      = if
    pop  HL             ; 1:10      = if
    pop  DE             ; 1:10      = if
    jp   nz, else103    ; 3:10      = if 
    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else103  EQU $          ;           = endif
endif103:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <> 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else104    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else104  EQU $          ;           = endif
endif104:
     
    ld    A, E          ; 1:4       2dup <> if
    sub   L             ; 1:4       2dup <> if
    jr   nz, $+7        ; 2:7/12    2dup <> if
    ld    A, D          ; 1:4       2dup <> if
    sub   H             ; 1:4       2dup <> if
    jp    z, else105    ; 3:10      2dup <> if 
    push DE             ; 1:11      print
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else105  EQU $          ;           = endif
endif105:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       <> if
    sbc  HL, DE         ; 2:15      <> if
    pop  HL             ; 1:10      <> if
    pop  DE             ; 1:10      <> if
    jp    z, else106    ; 3:10      <> if 
    push DE             ; 1:11      print
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else106  EQU $          ;           = endif
endif106:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, H          ; 1:4       <
    xor   D             ; 1:4       <
    jp    p, $+7        ; 3:10      <
    rl    D             ; 2:8       < sign x2
    jr   $+5            ; 2:12      <
    ex   DE, HL         ; 1:4       <
    sbc  HL, DE         ; 2:15      <
    sbc  HL, HL         ; 2:15      <
    pop  DE             ; 1:10      < 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else107    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else107  EQU $          ;           = endif
endif107:
     
    ld    A, H          ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    ld    C, A          ; 1:4       2dup < if
    ld    A, E          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    rra                 ; 1:4       2dup < if
    xor   C             ; 1:4       2dup < if
    jp    p, else108    ; 3:10      2dup < if 
    push DE             ; 1:11      print
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else108  EQU $          ;           = endif
endif108:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, H          ; 1:4       < if
    xor   D             ; 1:4       < if
    ld    C, A          ; 1:4       < if
    ld    A, E          ; 1:4       < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       < if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       < if    (DE<HL) --> (DE-HL<0) --> carry if true
    rra                 ; 1:4       < if
    xor   C             ; 1:4       < if
    pop  HL             ; 1:10      < if
    pop  DE             ; 1:10      < if
    jp    p, else109    ; 3:10      < if 
    push DE             ; 1:11      print
    ld   BC, size110    ; 3:10      print Length of string to print
    ld   DE, string110  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else109  EQU $          ;           = endif
endif109:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, H          ; 1:4       <=
    xor   D             ; 1:4       <=
    jp    p, $+7        ; 3:10      <=
    rl    D             ; 2:8       <= sign x2
    jr   $+6            ; 2:12      <=
    scf                 ; 1:4       <=
    ex   DE, HL         ; 1:4       <=
    sbc  HL, DE         ; 2:15      <=
    sbc  HL, HL         ; 2:15      <=
    pop  DE             ; 1:10      <= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else110    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size111    ; 3:10      print Length of string to print
    ld   DE, string111  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else110  EQU $          ;           = endif
endif110:
     
    ld    A, H          ; 1:4       2dup <= if
    xor   D             ; 1:4       2dup <= if
    ld    C, A          ; 1:4       2dup <= if
    ld    A, L          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sub   E             ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    ld    A, H          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sbc   A, D          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    rra                 ; 1:4       2dup <= if
    xor   C             ; 1:4       2dup <= if
    jp    m, else111    ; 3:10      2dup <= if 
    push DE             ; 1:11      print
    ld   BC, size112    ; 3:10      print Length of string to print
    ld   DE, string112  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else111  EQU $          ;           = endif
endif111:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, H          ; 1:4       <= if
    xor   D             ; 1:4       <= if
    sbc  HL, DE         ; 2:15      <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    rra                 ; 1:4       <= if
    add   A, 0x40       ; 2:7       <= if
    pop  HL             ; 1:10      <= if
    pop  DE             ; 1:10      <= if
    jp    m, else112    ; 3:10      <= if 
    push DE             ; 1:11      print
    ld   BC, size113    ; 3:10      print Length of string to print
    ld   DE, string113  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else112  EQU $          ;           = endif
endif112:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, H          ; 1:4       >
    xor   D             ; 1:4       >
    jp    p, $+7        ; 3:10      >
    rl    H             ; 2:8       > sign x1
    jr   $+4            ; 2:12      >
    sbc  HL, DE         ; 2:15      >
    sbc  HL, HL         ; 2:15      >
    pop  DE             ; 1:10      > 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else113    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size114    ; 3:10      print Length of string to print
    ld   DE, string114  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else113  EQU $          ;           = endif
endif113:
     
    ld    A, H          ; 1:4       2dup > if
    xor   D             ; 1:4       2dup > if
    ld    C, A          ; 1:4       2dup > if
    ld    A, L          ; 1:4       2dup > if    (DE>HL) --> (HL-DE<0) --> carry if true
    sub   E             ; 1:4       2dup > if    (DE>HL) --> (HL-DE<0) --> carry if true
    ld    A, H          ; 1:4       2dup > if    (DE>HL) --> (HL-DE<0) --> carry if true
    sbc   A, D          ; 1:4       2dup > if    (DE>HL) --> (HL-DE<0) --> carry if true
    rra                 ; 1:4       2dup > if
    xor   C             ; 1:4       2dup > if
    jp    p, else114    ; 3:10      2dup > if 
    push DE             ; 1:11      print
    ld   BC, size115    ; 3:10      print Length of string to print
    ld   DE, string115  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else114  EQU $          ;           = endif
endif114:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, H          ; 1:4       > if
    xor   D             ; 1:4       > if
    sbc  HL, DE         ; 2:15      > if    (DE>HL) --> (HL-DE<0) --> carry if true
    rra                 ; 1:4       > if
    add   A, 0x40       ; 2:7       > if
    pop  HL             ; 1:10      > if
    pop  DE             ; 1:10      > if
    jp    p, else115    ; 3:10      > if 
    push DE             ; 1:11      print
    ld   BC, size116    ; 3:10      print Length of string to print
    ld   DE, string116  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else115  EQU $          ;           = endif
endif115:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, H          ; 1:4       >=
    xor   D             ; 1:4       >=
    jp    p, $+7        ; 3:10      >=
    rl    H             ; 2:8       >= sign x1
    jr   $+5            ; 2:12      >=
    scf                 ; 1:4       >=
    sbc  HL, DE         ; 2:15      >=
    sbc  HL, HL         ; 2:15      >=
    pop  DE             ; 1:10      >= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else116    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size117    ; 3:10      print Length of string to print
    ld   DE, string117  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else116  EQU $          ;           = endif
endif116:
     
    ld    A, H          ; 1:4       2dup >= if
    xor   D             ; 1:4       2dup >= if
    ld    C, A          ; 1:4       2dup >= if
    ld    A, E          ; 1:4       2dup >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       2dup >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       2dup >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       2dup >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    rra                 ; 1:4       2dup >= if
    xor   C             ; 1:4       2dup >= if
    jp    m, else117    ; 3:10      2dup >= if 
    push DE             ; 1:11      print
    ld   BC, size118    ; 3:10      print Length of string to print
    ld   DE, string118  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else117  EQU $          ;           = endif
endif117:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, H          ; 1:4       >= if
    xor   D             ; 1:4       >= if
    ld    C, A          ; 1:4       >= if
    ld    A, E          ; 1:4       >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       >= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    rra                 ; 1:4       >= if
    xor   C             ; 1:4       >= if
    pop  HL             ; 1:10      >= if
    pop  DE             ; 1:10      >= if
    jp    m, else118    ; 3:10      >= if 
    push DE             ; 1:11      print
    ld   BC, size119    ; 3:10      print Length of string to print
    ld   DE, string119  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else118  EQU $          ;           = endif
endif118:
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A  
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else119    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size120    ; 3:10      print Length of string to print
    ld   DE, string120  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else119  EQU $          ;           = endif
endif119:
    
    ld    A, E          ; 1:4       2dup u= if
    sub   L             ; 1:4       2dup u= if
    jp   nz, else120    ; 3:10      2dup u= if
    ld    A, D          ; 1:4       2dup u= if
    sub   H             ; 1:4       2dup u= if
    jp   nz, else120    ; 3:10      2dup u= if 
    push DE             ; 1:11      print
    ld   BC, size121    ; 3:10      print Length of string to print
    ld   DE, string121  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else120  EQU $          ;           = endif
endif120:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       u= if
    sbc  HL, DE         ; 2:15      u= if
    pop  HL             ; 1:10      u= if
    pop  DE             ; 1:10      u= if
    jp   nz, else121    ; 3:10      u= if 
    push DE             ; 1:11      print
    ld   BC, size122    ; 3:10      print Length of string to print
    ld   DE, string122  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else121  EQU $          ;           = endif
endif121:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <> 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else122    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size123    ; 3:10      print Length of string to print
    ld   DE, string123  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else122  EQU $          ;           = endif
endif122:
    
    ld    A, E          ; 1:4       2dup u<> if
    sub   L             ; 1:4       2dup u<> if
    jr   nz, $+7        ; 2:7/12    2dup u<> if
    ld    A, D          ; 1:4       2dup u<> if
    sbc   A, H          ; 1:4       2dup u<> if
    jp    z, else123    ; 3:10      2dup u<> if 
    push DE             ; 1:11      print
    ld   BC, size124    ; 3:10      print Length of string to print
    ld   DE, string124  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else123  EQU $          ;           = endif
endif123:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       u<> if
    sbc  HL, DE         ; 2:15      u<> if
    pop  HL             ; 1:10      u<> if
    pop  DE             ; 1:10      u<> if
    jp    z, else124    ; 3:10      u<> if 
    push DE             ; 1:11      print
    ld   BC, size125    ; 3:10      print Length of string to print
    ld   DE, string125  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else124  EQU $          ;           = endif
endif124:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       (u) <
    ex   DE, HL         ; 1:4       (u) <
    sbc  HL, DE         ; 2:15      (u) <
    sbc  HL, HL         ; 2:15      (u) <
    pop  DE             ; 1:10      (u) < 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else125    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size126    ; 3:10      print Length of string to print
    ld   DE, string126  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else125  EQU $          ;           = endif
endif125:
    
    ld    A, E          ; 1:4       2dup u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    jp   nc, else126    ; 3:10      2dup u< if 
    push DE             ; 1:11      print
    ld   BC, size127    ; 3:10      print Length of string to print
    ld   DE, string127  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else126  EQU $          ;           = endif
endif126:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, E          ; 1:4       u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       u< if    (DE<HL) --> (DE-HL<0) --> carry if true
    pop  HL             ; 1:10      u< if
    pop  DE             ; 1:10      u< if
    jp   nc, else127    ; 3:10      u< if 
    push DE             ; 1:11      print
    ld   BC, size128    ; 3:10      print Length of string to print
    ld   DE, string128  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else127  EQU $          ;           = endif
endif127:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    scf                 ; 1:4       (u) <=
    ex   DE, HL         ; 1:4       (u) <=
    sbc  HL, DE         ; 2:15      (u) <=
    sbc  HL, HL         ; 2:15      (u) <=
    pop  DE             ; 1:10      (u) <= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else128    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size129    ; 3:10      print Length of string to print
    ld   DE, string129  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else128  EQU $          ;           = endif
endif128:
    
    ld    A, L          ; 1:4       2dup u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sub   E             ; 1:4       2dup u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    ld    A, H          ; 1:4       2dup u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    jp    c, else129    ; 3:10      2dup u<= if 
    push DE             ; 1:11      print
    ld   BC, size130    ; 3:10      print Length of string to print
    ld   DE, string130  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else129  EQU $          ;           = endif
endif129:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, L          ; 1:4       u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sub   E             ; 1:4       u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    ld    A, H          ; 1:4       u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sbc   A, D          ; 1:4       u<= if    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    pop  HL             ; 1:10      u<= if
    pop  DE             ; 1:10      u<= if
    jp    c, else130    ; 3:10      u<= if 
    push DE             ; 1:11      print
    ld   BC, size131    ; 3:10      print Length of string to print
    ld   DE, string131  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else130  EQU $          ;           = endif
endif130:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       (u) >
    sbc  HL, DE         ; 2:15      (u) >
    sbc  HL, HL         ; 2:15      (u) >
    pop  DE             ; 1:10      (u) > 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else131    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size132    ; 3:10      print Length of string to print
    ld   DE, string132  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else131  EQU $          ;           = endif
endif131:
    
    ld    A, L          ; 1:4       2dup u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    sub   E             ; 1:4       2dup u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    ld    A, H          ; 1:4       2dup u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    jp   nc, else132    ; 3:10      2dup u> if 
    push DE             ; 1:11      print
    ld   BC, size133    ; 3:10      print Length of string to print
    ld   DE, string133  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else132  EQU $          ;           = endif
endif132:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, L          ; 1:4       u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    sub   E             ; 1:4       u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    ld    A, H          ; 1:4       u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    sbc   A, D          ; 1:4       u> if    (DE>HL) --> (0>HL-DE) --> carry if true
    pop  HL             ; 1:10      u> if
    pop  DE             ; 1:10      u> if
    jp   nc, else133    ; 3:10      u> if 
    push DE             ; 1:11      print
    ld   BC, size134    ; 3:10      print Length of string to print
    ld   DE, string134  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else133  EQU $          ;           = endif
endif133:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    scf                 ; 1:4       (u) >=
    sbc  HL, DE         ; 2:15      (u) >=
    sbc  HL, HL         ; 2:15      (u) >=
    pop  DE             ; 1:10      (u) >= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else134    ; 3:10      if 
    push DE             ; 1:11      print
    ld   BC, size135    ; 3:10      print Length of string to print
    ld   DE, string135  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else134  EQU $          ;           = endif
endif134:
    
    ld    A, E          ; 1:4       2dup u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       2dup u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       2dup u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    jp    c, else135    ; 3:10      2dup u>= if 
    push DE             ; 1:11      print
    ld   BC, size136    ; 3:10      print Length of string to print
    ld   DE, string136  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else135  EQU $          ;           = endif
endif135:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, E          ; 1:4       u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       u>= if    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    pop  HL             ; 1:10      u>= if
    pop  DE             ; 1:10      u>= if
    jp    c, else136    ; 3:10      u>= if 
    push DE             ; 1:11      print
    ld   BC, size137    ; 3:10      print Length of string to print
    ld   DE, string137  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else136  EQU $          ;           = endif
endif136:
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    call PRINT_U16      ; 3:17      . 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

dtest_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


;   ---  b e g i n  ---
ptestp3:                ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
    ld    A, high 3     ; 2:7       dup 3 = if
    xor   H             ; 1:4       dup 3 = if
    ld    B, A          ; 1:4       dup 3 = if
    ld    A, low 3      ; 2:7       dup 3 = if
    xor   L             ; 1:4       dup 3 = if
    or    B             ; 1:4       dup 3 = if
    jp   nz, else137    ; 3:10      dup 3 = if 
    push DE             ; 1:11      print
    ld   BC, size138    ; 3:10      print Length of string to print
    ld   DE, string138  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else137  EQU $          ;           = endif
endif137:
    
    ld    A, low 3      ; 2:7       dup 3 <> if
    xor   L             ; 1:4       dup 3 <> if
    jr   nz, $+8        ; 2:7/12    dup 3 <> if
    ld    A, high 3     ; 2:7       dup 3 <> if
    xor   H             ; 1:4       dup 3 <> if
    jp    z, else138    ; 3:10      dup 3 <> if 
    push DE             ; 1:11      print
    ld   BC, size139    ; 3:10      print Length of string to print
    ld   DE, string139  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else138  EQU $          ;           = endif
endif138:
    
    ld    A, H          ; 1:4       dup 3 < if
    add   A, A          ; 1:4       dup 3 < if
    jr    c, $+11       ; 2:7/12    dup 3 < if    positive constant
    ld    A, L          ; 1:4       dup 3 < if    (HL<3) --> (HL-3<0) --> carry if true
    sub   low 3         ; 2:7       dup 3 < if    (HL<3) --> (HL-3<0) --> carry if true
    ld    A, H          ; 1:4       dup 3 < if    (HL<3) --> (HL-3<0) --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 < if    (HL<3) --> (HL-3<0) --> carry if true
    jp   nc, else139    ; 3:10      dup 3 < if 
    push DE             ; 1:11      print
    ld   BC, size140    ; 3:10      print Length of string to print
    ld   DE, string140  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else139  EQU $          ;           = endif
endif139:
    
    ld    A, H          ; 1:4       dup 3 <= if
    add   A, A          ; 1:4       dup 3 <= if
    jr    c, $+11       ; 2:7/12    dup 3 <= if    positive constant
    ld    A, low 3      ; 2:7       dup 3 <= if    (HL<=3) --> (0<=3-HL) --> not carry if true
    sub   L             ; 1:4       dup 3 <= if    (HL<=3) --> (0<=3-HL) --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 <= if    (HL<=3) --> (0<=3-HL) --> not carry if true
    sbc   A, H          ; 1:4       dup 3 <= if    (HL<=3) --> (0<=3-HL) --> not carry if true
    jp    c, else140    ; 3:10      dup 3 <= if 
    push DE             ; 1:11      print
    ld   BC, size141    ; 3:10      print Length of string to print
    ld   DE, string141  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else140  EQU $          ;           = endif
endif140:
    
    ld    A, H          ; 1:4       dup 3 > if
    add   A, A          ; 1:4       dup 3 > if
    jp    c, else141    ; 3:10      dup 3 > if    positive constant
    ld    A, low 3      ; 2:7       dup 3 > if    (HL>3) --> (0>3-HL) --> carry if true
    sub   L             ; 1:4       dup 3 > if    (HL>3) --> (0>3-HL) --> carry if true
    ld    A, high 3     ; 2:7       dup 3 > if    (HL>3) --> (0>3-HL) --> carry if true
    sbc   A, H          ; 1:4       dup 3 > if    (HL>3) --> (0>3-HL) --> carry if true
    jp   nc, else141    ; 3:10      dup 3 > if 
    push DE             ; 1:11      print
    ld   BC, size142    ; 3:10      print Length of string to print
    ld   DE, string142  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else141  EQU $          ;           = endif
endif141:
    
    ld    A, H          ; 1:4       dup 3 >= if
    add   A, A          ; 1:4       dup 3 >= if
    jp    c, else142    ; 3:10      dup 3 >= if    positive constant
    ld    A, L          ; 1:4       dup 3 >= if    (HL>=3) --> (HL-3>=0) --> not carry if true
    sub   low 3         ; 2:7       dup 3 >= if    (HL>=3) --> (HL-3>=0) --> not carry if true
    ld    A, H          ; 1:4       dup 3 >= if    (HL>=3) --> (HL-3>=0) --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 >= if    (HL>=3) --> (HL-3>=0) --> not carry if true
    jp    c, else142    ; 3:10      dup 3 >= if 
    push DE             ; 1:11      print
    ld   BC, size143    ; 3:10      print Length of string to print
    ld   DE, string143  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else142  EQU $          ;           = endif
endif142:
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    ld    A, low 3      ; 2:7       dup 3 u= if
    xor   L             ; 1:4       dup 3 u= if
    jp   nz, else143    ; 3:10      dup 3 u= if
    ld    A, high 3     ; 2:7       dup 3 u= if
    xor   H             ; 1:4       dup 3 u= if
    jp   nz, else143    ; 3:10      dup 3 u= if 
    push DE             ; 1:11      print
    ld   BC, size144    ; 3:10      print Length of string to print
    ld   DE, string144  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else143  EQU $          ;           = endif
endif143:
    
    ld    A, low 3      ; 2:7       dup 3 u<> if
    xor   L             ; 1:4       dup 3 u<> if
    jr   nz, $+8        ; 2:7/12    dup 3 u<> if
    ld    A, high 3     ; 2:7       dup 3 u<> if
    xor   H             ; 1:4       dup 3 u<> if
    jp    z, else144    ; 3:10      dup 3 u<> if 
    push DE             ; 1:11      print
    ld   BC, size145    ; 3:10      print Length of string to print
    ld   DE, string145  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else144  EQU $          ;           = endif
endif144:
    
    ld    A, L          ; 1:4       dup 3 (u)< if    (HL<3) --> (HL-3<0) --> carry if true
    sub   low 3         ; 2:7       dup 3 (u)< if    (HL<3) --> (HL-3<0) --> carry if true
    ld    A, H          ; 1:4       dup 3 (u)< if    (HL<3) --> (HL-3<0) --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 (u)< if    (HL<3) --> (HL-3<0) --> carry if true
    jp   nc, else145    ; 3:10      dup 3 (u)< if 
    push DE             ; 1:11      print
    ld   BC, size146    ; 3:10      print Length of string to print
    ld   DE, string146  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else145  EQU $          ;           = endif
endif145:
    
    ld    A, low 3      ; 2:7       dup 3 (u)<= if    (HL<=3) --> (0<=3-HL) --> not carry if true
    sub   L             ; 1:4       dup 3 (u)<= if    (HL<=3) --> (0<=3-HL) --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 (u)<= if    (HL<=3) --> (0<=3-HL) --> not carry if true
    sbc   A, H          ; 1:4       dup 3 (u)<= if    (HL<=3) --> (0<=3-HL) --> not carry if true
    jp    c, else146    ; 3:10      dup 3 (u)<= if 
    push DE             ; 1:11      print
    ld   BC, size147    ; 3:10      print Length of string to print
    ld   DE, string147  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else146  EQU $          ;           = endif
endif146:
    
    ld    A, low 3      ; 2:7       dup 3 (u)> if    (HL>3) --> (0>3-HL) --> carry if true
    sub   L             ; 1:4       dup 3 (u)> if    (HL>3) --> (0>3-HL) --> carry if true
    ld    A, high 3     ; 2:7       dup 3 (u)> if    (HL>3) --> (0>3-HL) --> carry if true
    sbc   A, H          ; 1:4       dup 3 (u)> if    (HL>3) --> (0>3-HL) --> carry if true
    jp   nc, else147    ; 3:10      dup 3 (u)> if 
    push DE             ; 1:11      print
    ld   BC, size148    ; 3:10      print Length of string to print
    ld   DE, string148  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else147  EQU $          ;           = endif
endif147:
    
    ld    A, L          ; 1:4       dup 3 (u)>= if    (HL>=3) --> (HL-3>=0) --> not carry if true
    sub   low 3         ; 2:7       dup 3 (u)>= if    (HL>=3) --> (HL-3>=0) --> not carry if true
    ld    A, H          ; 1:4       dup 3 (u)>= if    (HL>=3) --> (HL-3>=0) --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 (u)>= if    (HL>=3) --> (HL-3>=0) --> not carry if true
    jp    c, else148    ; 3:10      dup 3 (u)>= if 
    push DE             ; 1:11      print
    ld   BC, size149    ; 3:10      print Length of string to print
    ld   DE, string149  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else148  EQU $          ;           = endif
endif148:
    
    call PRINT_U16      ; 3:17      . 
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

ptestp3_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----



;   ---  b e g i n  ---
ptestm3:                ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
    ld    A, high -3    ; 2:7       dup -3 = if
    xor   H             ; 1:4       dup -3 = if
    ld    B, A          ; 1:4       dup -3 = if
    ld    A, low -3     ; 2:7       dup -3 = if
    xor   L             ; 1:4       dup -3 = if
    or    B             ; 1:4       dup -3 = if
    jp   nz, else149    ; 3:10      dup -3 = if 
    push DE             ; 1:11      print
    ld   BC, size150    ; 3:10      print Length of string to print
    ld   DE, string150  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else149  EQU $          ;           = endif
endif149:
    
    ld    A, low -3     ; 2:7       dup -3 <> if
    xor   L             ; 1:4       dup -3 <> if
    jr   nz, $+8        ; 2:7/12    dup -3 <> if
    ld    A, high -3    ; 2:7       dup -3 <> if
    xor   H             ; 1:4       dup -3 <> if
    jp    z, else150    ; 3:10      dup -3 <> if 
    push DE             ; 1:11      print
    ld   BC, size151    ; 3:10      print Length of string to print
    ld   DE, string151  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else150  EQU $          ;           = endif
endif150:
    
    ld    A, H          ; 1:4       dup -3 < if
    add   A, A          ; 1:4       dup -3 < if
    jp   nc, else151    ; 3:10      dup -3 < if    negative constant
    ld    A, L          ; 1:4       dup -3 < if    (HL<-3) --> (HL--3<0) --> carry if true
    sub   low -3        ; 2:7       dup -3 < if    (HL<-3) --> (HL--3<0) --> carry if true
    ld    A, H          ; 1:4       dup -3 < if    (HL<-3) --> (HL--3<0) --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 < if    (HL<-3) --> (HL--3<0) --> carry if true
    jp   nc, else151    ; 3:10      dup -3 < if 
    push DE             ; 1:11      print
    ld   BC, size152    ; 3:10      print Length of string to print
    ld   DE, string152  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else151  EQU $          ;           = endif
endif151:
    
    ld    A, H          ; 1:4       dup -3 <= if
    add   A, A          ; 1:4       dup -3 <= if
    jp   nc, else152    ; 3:10      dup -3 <= if    negative constant
    ld    A, low -3     ; 2:7       dup -3 <= if    (HL<=-3) --> (0<=-3-HL) --> not carry if true
    sub   L             ; 1:4       dup -3 <= if    (HL<=-3) --> (0<=-3-HL) --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 <= if    (HL<=-3) --> (0<=-3-HL) --> not carry if true
    sbc   A, H          ; 1:4       dup -3 <= if    (HL<=-3) --> (0<=-3-HL) --> not carry if true
    jp    c, else152    ; 3:10      dup -3 <= if 
    push DE             ; 1:11      print
    ld   BC, size153    ; 3:10      print Length of string to print
    ld   DE, string153  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else152  EQU $          ;           = endif
endif152:
    
    ld    A, H          ; 1:4       dup -3 > if
    add   A, A          ; 1:4       dup -3 > if
    jr   nc, $+11       ; 2:7/12    dup -3 > if    negative constant
    ld    A, low -3     ; 2:7       dup -3 > if    (HL>-3) --> (0>-3-HL) --> carry if true
    sub   L             ; 1:4       dup -3 > if    (HL>-3) --> (0>-3-HL) --> carry if true
    ld    A, high -3    ; 2:7       dup -3 > if    (HL>-3) --> (0>-3-HL) --> carry if true
    sbc   A, H          ; 1:4       dup -3 > if    (HL>-3) --> (0>-3-HL) --> carry if true
    jp   nc, else153    ; 3:10      dup -3 > if 
    push DE             ; 1:11      print
    ld   BC, size154    ; 3:10      print Length of string to print
    ld   DE, string154  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else153  EQU $          ;           = endif
endif153:
    
    ld    A, H          ; 1:4       dup -3 >= if
    add   A, A          ; 1:4       dup -3 >= if
    jr   nc, $+11       ; 2:7/12    dup -3 >= if    negative constant
    ld    A, L          ; 1:4       dup -3 >= if    (HL>=-3) --> (HL--3>=0) --> not carry if true
    sub   low -3        ; 2:7       dup -3 >= if    (HL>=-3) --> (HL--3>=0) --> not carry if true
    ld    A, H          ; 1:4       dup -3 >= if    (HL>=-3) --> (HL--3>=0) --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 >= if    (HL>=-3) --> (HL--3>=0) --> not carry if true
    jp    c, else154    ; 3:10      dup -3 >= if 
    push DE             ; 1:11      print
    ld   BC, size155    ; 3:10      print Length of string to print
    ld   DE, string155  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else154  EQU $          ;           = endif
endif154:
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    ld    A, low -3     ; 2:7       dup -3 u= if
    xor   L             ; 1:4       dup -3 u= if
    jp   nz, else155    ; 3:10      dup -3 u= if
    ld    A, high -3    ; 2:7       dup -3 u= if
    xor   H             ; 1:4       dup -3 u= if
    jp   nz, else155    ; 3:10      dup -3 u= if 
    push DE             ; 1:11      print
    ld   BC, size156    ; 3:10      print Length of string to print
    ld   DE, string156  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else155  EQU $          ;           = endif
endif155:
    
    ld    A, low -3     ; 2:7       dup -3 u<> if
    xor   L             ; 1:4       dup -3 u<> if
    jr   nz, $+8        ; 2:7/12    dup -3 u<> if
    ld    A, high -3    ; 2:7       dup -3 u<> if
    xor   H             ; 1:4       dup -3 u<> if
    jp    z, else156    ; 3:10      dup -3 u<> if 
    push DE             ; 1:11      print
    ld   BC, size157    ; 3:10      print Length of string to print
    ld   DE, string157  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else156  EQU $          ;           = endif
endif156:
    
    ld    A, L          ; 1:4       dup -3 (u)< if    (HL<-3) --> (HL--3<0) --> carry if true
    sub   low -3        ; 2:7       dup -3 (u)< if    (HL<-3) --> (HL--3<0) --> carry if true
    ld    A, H          ; 1:4       dup -3 (u)< if    (HL<-3) --> (HL--3<0) --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 (u)< if    (HL<-3) --> (HL--3<0) --> carry if true
    jp   nc, else157    ; 3:10      dup -3 (u)< if 
    push DE             ; 1:11      print
    ld   BC, size158    ; 3:10      print Length of string to print
    ld   DE, string158  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else157  EQU $          ;           = endif
endif157:
    
    ld    A, low -3     ; 2:7       dup -3 (u)<= if    (HL<=-3) --> (0<=-3-HL) --> not carry if true
    sub   L             ; 1:4       dup -3 (u)<= if    (HL<=-3) --> (0<=-3-HL) --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 (u)<= if    (HL<=-3) --> (0<=-3-HL) --> not carry if true
    sbc   A, H          ; 1:4       dup -3 (u)<= if    (HL<=-3) --> (0<=-3-HL) --> not carry if true
    jp    c, else158    ; 3:10      dup -3 (u)<= if 
    push DE             ; 1:11      print
    ld   BC, size159    ; 3:10      print Length of string to print
    ld   DE, string159  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else158  EQU $          ;           = endif
endif158:
    
    ld    A, low -3     ; 2:7       dup -3 (u)> if    (HL>-3) --> (0>-3-HL) --> carry if true
    sub   L             ; 1:4       dup -3 (u)> if    (HL>-3) --> (0>-3-HL) --> carry if true
    ld    A, high -3    ; 2:7       dup -3 (u)> if    (HL>-3) --> (0>-3-HL) --> carry if true
    sbc   A, H          ; 1:4       dup -3 (u)> if    (HL>-3) --> (0>-3-HL) --> carry if true
    jp   nc, else159    ; 3:10      dup -3 (u)> if 
    push DE             ; 1:11      print
    ld   BC, size160    ; 3:10      print Length of string to print
    ld   DE, string160  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else159  EQU $          ;           = endif
endif159:
    
    ld    A, L          ; 1:4       dup -3 (u)>= if    (HL>=-3) --> (HL--3>=0) --> not carry if true
    sub   low -3        ; 2:7       dup -3 (u)>= if    (HL>=-3) --> (HL--3>=0) --> not carry if true
    ld    A, H          ; 1:4       dup -3 (u)>= if    (HL>=-3) --> (HL--3>=0) --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 (u)>= if    (HL>=-3) --> (HL--3>=0) --> not carry if true
    jp    c, else160    ; 3:10      dup -3 (u)>= if 
    push DE             ; 1:11      print
    ld   BC, size161    ; 3:10      print Length of string to print
    ld   DE, string161  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
else160  EQU $          ;           = endif
endif160:
    
    call PRINT_U16      ; 3:17      . 
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

ptestm3_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----



;   ---  b e g i n  ---
stack_test:             ;           
    
    push DE             ; 1:11      print
    ld   BC, size162    ; 3:10      print Length of string to print
    ld   DE, string162  ; 3:10      print Address of string
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
;   -----  e n d  -----



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
    
    ; fall to PRINT_U16
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
string162:
db 0xD, "Data stack OK!", 0xD
size162 EQU $ - string162
string161:
db ">=,"
size161 EQU $ - string161
string160:
db ">,"
size160 EQU $ - string160
string159:
db "<=,"
size159 EQU $ - string159
string158:
db "<,"
size158 EQU $ - string158
string157:
db "<>,"
size157 EQU $ - string157
string156:
db "=,"
size156 EQU $ - string156
string155:
db ">=,"
size155 EQU $ - string155
string154:
db ">,"
size154 EQU $ - string154
string153:
db "<=,"
size153 EQU $ - string153
string152:
db "<,"
size152 EQU $ - string152
string151:
db "<>,"
size151 EQU $ - string151
string150:
db "=,"
size150 EQU $ - string150
string149:
db ">=,"
size149 EQU $ - string149
string148:
db ">,"
size148 EQU $ - string148
string147:
db "<=,"
size147 EQU $ - string147
string146:
db "<,"
size146 EQU $ - string146
string145:
db "<>,"
size145 EQU $ - string145
string144:
db "=,"
size144 EQU $ - string144
string143:
db ">=,"
size143 EQU $ - string143
string142:
db ">,"
size142 EQU $ - string142
string141:
db "<=,"
size141 EQU $ - string141
string140:
db "<,"
size140 EQU $ - string140
string139:
db "<>,"
size139 EQU $ - string139
string138:
db "=,"
size138 EQU $ - string138
string137:
db ">=,"
size137 EQU $ - string137
string136:
db ">=" 
size136 EQU $ - string136
string135:
db ">=" 
size135 EQU $ - string135
string134:
db ">,"
size134 EQU $ - string134
string133:
db ">" 
size133 EQU $ - string133
string132:
db ">" 
size132 EQU $ - string132
string131:
db "<=,"
size131 EQU $ - string131
string130:
db "<=" 
size130 EQU $ - string130
string129:
db "<=" 
size129 EQU $ - string129
string128:
db "<,"
size128 EQU $ - string128
string127:
db "<" 
size127 EQU $ - string127
string126:
db "<" 
size126 EQU $ - string126
string125:
db "<>,"
size125 EQU $ - string125
string124:
db "<>" 
size124 EQU $ - string124
string123:
db "<>" 
size123 EQU $ - string123
string122:
db "=,"
size122 EQU $ - string122
string121:
db "=" 
size121 EQU $ - string121
string120:
db "=" 
size120 EQU $ - string120
string119:
db ">=,"
size119 EQU $ - string119
string118:
db ">=" 
size118 EQU $ - string118
string117:
db ">=" 
size117 EQU $ - string117
string116:
db ">,"
size116 EQU $ - string116
string115:
db ">" 
size115 EQU $ - string115
string114:
db ">" 
size114 EQU $ - string114
string113:
db "<=,"
size113 EQU $ - string113
string112:
db "<=" 
size112 EQU $ - string112
string111:
db "<=" 
size111 EQU $ - string111
string110:
db "<,"
size110 EQU $ - string110
string109:
db "<" 
size109 EQU $ - string109
string108:
db "<" 
size108 EQU $ - string108
string107:
db "<>,"
size107 EQU $ - string107
string106:
db "<>" 
size106 EQU $ - string106
string105:
db "<>" 
size105 EQU $ - string105
string104:
db "=,"
size104 EQU $ - string104
string103:
db "=" 
size103 EQU $ - string103
string102:
db "=" 
size102 EQU $ - string102
string101:
db "RAS:"
size101 EQU $ - string101



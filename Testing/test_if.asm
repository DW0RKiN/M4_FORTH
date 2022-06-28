; vvvvv
; ^^^^^
ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    ld  hl, stack_test
    push hl

    
    ld   BC, string101  ; 3:10      print_i   Address of string101 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    
    push DE             ; 1:11      push2(5,-5)
    ld   DE, 5          ; 3:10      push2(5,-5)
    push HL             ; 1:11      push2(5,-5)
    ld   HL, -5         ; 3:10      push2(5,-5) 
    call x_x_test       ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push2(5,5)
    push HL             ; 1:11      push2(5,5)
    ld   HL, 5          ; 3:10      push2(5,5)
    ld    D, H          ; 1:4       push2(5,5)
    ld    E, L          ; 1:4       push2(5,5) 
    call x_x_test       ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push2(-5,-5)
    push HL             ; 1:11      push2(-5,-5)
    ld   HL, -5         ; 3:10      push2(-5,-5)
    ld    D, H          ; 1:4       push2(-5,-5)
    ld    E, L          ; 1:4       push2(-5,-5) 
    call x_x_test       ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push2(-5,5)
    ld   DE, -5         ; 3:10      push2(-5,5)
    push HL             ; 1:11      push2(-5,5)
    ld   HL, 5          ; 3:10      push2(-5,5) 
    call x_x_test       ; 3:17      call ( -- ret ) R:( -- )
    
    ld   BC, string102  ; 3:10      print_i   Address of string102 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    
    push DE             ; 1:11      pushdot(5)   ( -- hi lo )
    push HL             ; 1:11      pushdot(5)
    ld   HL, 0x0005     ; 3:10      pushdot(5)   lo_word
    ld    E, H          ; 1:4       pushdot(5)
    ld    D, H          ; 1:4       pushdot(5)   hi word 
    push DE             ; 1:11      pushdot(-5)   ( -- hi lo )
    push HL             ; 1:11      pushdot(-5)
    ld   HL, 0xFFFB     ; 3:10      pushdot(-5)   lo_word
    ld    E, H          ; 1:4       pushdot(-5)
    ld    D, H          ; 1:4       pushdot(-5)   hi word 
    call d_d_test       ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      pushdot(5)   ( -- hi lo )
    push HL             ; 1:11      pushdot(5)
    ld   HL, 0x0005     ; 3:10      pushdot(5)   lo_word
    ld    E, H          ; 1:4       pushdot(5)
    ld    D, H          ; 1:4       pushdot(5)   hi word 
    push DE             ; 1:11      pushdot(5)   ( -- hi lo )
    push HL             ; 1:11      pushdot(5)
    ld   HL, 0x0005     ; 3:10      pushdot(5)   lo_word
    ld    E, H          ; 1:4       pushdot(5)
    ld    D, H          ; 1:4       pushdot(5)   hi word 
    call d_d_test       ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      pushdot(-5)   ( -- hi lo )
    push HL             ; 1:11      pushdot(-5)
    ld   HL, 0xFFFB     ; 3:10      pushdot(-5)   lo_word
    ld    E, H          ; 1:4       pushdot(-5)
    ld    D, H          ; 1:4       pushdot(-5)   hi word 
    push DE             ; 1:11      pushdot(-5)   ( -- hi lo )
    push HL             ; 1:11      pushdot(-5)
    ld   HL, 0xFFFB     ; 3:10      pushdot(-5)   lo_word
    ld    E, H          ; 1:4       pushdot(-5)
    ld    D, H          ; 1:4       pushdot(-5)   hi word 
    call d_d_test       ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      pushdot(-5)   ( -- hi lo )
    push HL             ; 1:11      pushdot(-5)
    ld   HL, 0xFFFB     ; 3:10      pushdot(-5)   lo_word
    ld    E, H          ; 1:4       pushdot(-5)
    ld    D, H          ; 1:4       pushdot(-5)   hi word 
    push DE             ; 1:11      pushdot(5)   ( -- hi lo )
    push HL             ; 1:11      pushdot(5)
    ld   HL, 0x0005     ; 3:10      pushdot(5)   lo_word
    ld    E, H          ; 1:4       pushdot(5)
    ld    D, H          ; 1:4       pushdot(5)   hi word 
    call d_d_test       ; 3:17      call ( -- ret ) R:( -- )
    
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call x_p3_test      ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call x_p3_test      ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call x_m3_test      ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call x_m3_test      ; 3:17      call ( -- ret ) R:( -- )

    
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string103
    call PRINT_STRING_Z ; 3:17      print_z
    exx
    push HL
    exx
    pop HL
    
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      u.   ( u -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    ret
    

;   ---  the beginning of a non-recursive function  ---
x_x_test:               ;           
    pop  BC             ; 1:10      : ret
    ld  (x_x_test_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    ; signed
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                        ;[9:48/49]  =
    xor   A             ; 1:4       =   A = 0x00
    sbc  HL, DE         ; 2:15      =
    jr   nz, $+3        ; 2:7/12    =
    dec   A             ; 1:4       =   A = 0xFF
    ld    L, A          ; 1:4       =
    ld    H, A          ; 1:4       =   HL= flag
    pop  DE             ; 1:10      = 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104
    call PRINT_STRING_Z ; 3:17      print_z 
else101  EQU $          ;           = endif
endif101:
     
    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string105
    call PRINT_STRING_Z ; 3:17      print_z 
else102  EQU $          ;           = endif
endif102:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       = if
    sbc  HL, DE         ; 2:15      = if
    pop  HL             ; 1:10      = if
    pop  DE             ; 1:10      = if
    jp   nz, else103    ; 3:10      = if 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106
    call PRINT_STRING_Z ; 3:17      print_z 
else103  EQU $          ;           = endif
endif103:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
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
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107
    call PRINT_STRING_Z ; 3:17      print_z 
else104  EQU $          ;           = endif
endif104:
     
    ld    A, E          ; 1:4       2dup <> if
    sub   L             ; 1:4       2dup <> if
    jr   nz, $+7        ; 2:7/12    2dup <> if
    ld    A, D          ; 1:4       2dup <> if
    sub   H             ; 1:4       2dup <> if
    jp    z, else105    ; 3:10      2dup <> if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string108
    call PRINT_STRING_Z ; 3:17      print_z 
else105  EQU $          ;           = endif
endif105:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       <> if
    sbc  HL, DE         ; 2:15      <> if
    pop  HL             ; 1:10      <> if
    pop  DE             ; 1:10      <> if
    jp    z, else106    ; 3:10      <> if 
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109
    call PRINT_STRING_Z ; 3:17      print_z 
else106  EQU $          ;           = endif
endif106:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                       ;[12:54]     <   ( x2 x1 -- flag x2<x1 )
    ld    A, E          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       <   carry --> sign
    xor   H             ; 1:4       <
    xor   D             ; 1:4       <
    add   A, A          ; 1:4       <   sign --> carry
    sbc   A, A          ; 1:4       <   0x00 or 0xff
    ld    H, A          ; 1:4       <
    ld    L, A          ; 1:4       <
    pop  DE             ; 1:10      < 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else107    ; 3:10      if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110
    call PRINT_STRING_Z ; 3:17      print_z 
else107  EQU $          ;           = endif
endif107:
     
    ld    A, E          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    xor   H             ; 1:4       2dup < if
    jp    p, else108    ; 3:10      2dup < if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string111
    call PRINT_STRING_Z ; 3:17      print_z 
else108  EQU $          ;           = endif
endif108:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
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
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112
    call PRINT_STRING_Z ; 3:17      print_z 
else109  EQU $          ;           = endif
endif109:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                       ;[13:57]     <=   ( x2 x1 -- flag x2<=x1 )
    ld    A, L          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sub   E             ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    ld    A, H          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sbc   A, D          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    rra                 ; 1:4       <=   carry --> sign
    xor   H             ; 1:4       <=
    xor   D             ; 1:4       <=
    sub  0x80           ; 2:7       <=   sign --> invert carry
    sbc   A, A          ; 1:4       <=   0x00 or 0xff
    ld    H, A          ; 1:4       <=
    ld    L, A          ; 1:4       <=
    pop  DE             ; 1:10      <= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else110    ; 3:10      if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113
    call PRINT_STRING_Z ; 3:17      print_z 
else110  EQU $          ;           = endif
endif110:
     
    ld    A, L          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= if
    xor   D             ; 1:4       2dup <= if
    xor   H             ; 1:4       2dup <= if
    jp    m, else111    ; 3:10      2dup <= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string114
    call PRINT_STRING_Z ; 3:17      print_z 
else111  EQU $          ;           = endif
endif111:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
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
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115
    call PRINT_STRING_Z ; 3:17      print_z 
else112  EQU $          ;           = endif
endif112:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                       ;[12:54]     >   ( x2 x1 -- flag x2>x1 )
    ld    A, L          ; 1:4       >   DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       >   DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       >   DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       >   DE>HL --> 0>HL-DE --> carry if true
    rra                 ; 1:4       >   carry --> sign
    xor   H             ; 1:4       >
    xor   D             ; 1:4       >
    add   A, A          ; 1:4       >   sign --> carry
    sbc   A, A          ; 1:4       >   0x00 or 0xff
    ld    H, A          ; 1:4       >
    ld    L, A          ; 1:4       >
    pop  DE             ; 1:10      > 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else113    ; 3:10      if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116
    call PRINT_STRING_Z ; 3:17      print_z 
else113  EQU $          ;           = endif
endif113:
     
    ld    A, L          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > if    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > if
    xor   D             ; 1:4       2dup > if
    xor   H             ; 1:4       2dup > if
    jp    p, else114    ; 3:10      2dup > if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string117
    call PRINT_STRING_Z ; 3:17      print_z 
else114  EQU $          ;           = endif
endif114:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
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
    ld   BC, string118  ; 3:10      print_z   Address of null-terminated string118
    call PRINT_STRING_Z ; 3:17      print_z 
else115  EQU $          ;           = endif
endif115:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                       ;[13:57]     >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       >=   carry --> sign
    xor   H             ; 1:4       >=
    xor   D             ; 1:4       >=
    sub  0x80           ; 2:7       >=   sign --> invert carry
    sbc   A, A          ; 1:4       >=   0x00 or 0xff
    ld    H, A          ; 1:4       >=
    ld    L, A          ; 1:4       >=
    pop  DE             ; 1:10      >= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else116    ; 3:10      if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119
    call PRINT_STRING_Z ; 3:17      print_z 
else116  EQU $          ;           = endif
endif116:
     
    ld    A, E          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= if    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= if
    xor   D             ; 1:4       2dup >= if
    xor   H             ; 1:4       2dup >= if
    jp    m, else117    ; 3:10      2dup >= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string120
    call PRINT_STRING_Z ; 3:17      print_z 
else117  EQU $          ;           = endif
endif117:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
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
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ; unsigned
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                        ;[9:48/49]  =
    xor   A             ; 1:4       =   A = 0x00
    sbc  HL, DE         ; 2:15      =
    jr   nz, $+3        ; 2:7/12    =
    dec   A             ; 1:4       =   A = 0xFF
    ld    L, A          ; 1:4       =
    ld    H, A          ; 1:4       =   HL= flag
    pop  DE             ; 1:10      = 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else119    ; 3:10      if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string122
    call PRINT_STRING_Z ; 3:17      print_z 
else119  EQU $          ;           = endif
endif119:
    
    ld    A, E          ; 1:4       2dup u= if
    sub   L             ; 1:4       2dup u= if
    jp   nz, else120    ; 3:10      2dup u= if
    ld    A, D          ; 1:4       2dup u= if
    sub   H             ; 1:4       2dup u= if
    jp   nz, else120    ; 3:10      2dup u= if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string123
    call PRINT_STRING_Z ; 3:17      print_z 
else120  EQU $          ;           = endif
endif120:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       u= if
    sbc  HL, DE         ; 2:15      u= if
    pop  HL             ; 1:10      u= if
    pop  DE             ; 1:10      u= if
    jp   nz, else121    ; 3:10      u= if 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106 == string124
    call PRINT_STRING_Z ; 3:17      print_z 
else121  EQU $          ;           = endif
endif121:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
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
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string125
    call PRINT_STRING_Z ; 3:17      print_z 
else122  EQU $          ;           = endif
endif122:
    
    ld    A, E          ; 1:4       2dup u<> if
    sub   L             ; 1:4       2dup u<> if
    jr   nz, $+7        ; 2:7/12    2dup u<> if
    ld    A, D          ; 1:4       2dup u<> if
    sbc   A, H          ; 1:4       2dup u<> if
    jp    z, else123    ; 3:10      2dup u<> if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string126
    call PRINT_STRING_Z ; 3:17      print_z 
else123  EQU $          ;           = endif
endif123:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       u<> if
    sbc  HL, DE         ; 2:15      u<> if
    pop  HL             ; 1:10      u<> if
    pop  DE             ; 1:10      u<> if
    jp    z, else124    ; 3:10      u<> if 
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109 == string127
    call PRINT_STRING_Z ; 3:17      print_z 
else124  EQU $          ;           = endif
endif124:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                        ;[7:41]     u<
    ld    A, E          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sbc  HL, HL         ; 2:15      u<
    pop  DE             ; 1:10      u< 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else125    ; 3:10      if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string128
    call PRINT_STRING_Z ; 3:17      print_z 
else125  EQU $          ;           = endif
endif125:
    
    ld    A, E          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, else126    ; 3:10      2dup u< if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string129
    call PRINT_STRING_Z ; 3:17      print_z 
else126  EQU $          ;           = endif
endif126:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, E          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< if
    pop  DE             ; 1:10      u< if
    jp   nc, else127    ; 3:10      u< if 
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112 == string130
    call PRINT_STRING_Z ; 3:17      print_z 
else127  EQU $          ;           = endif
endif127:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    scf                 ; 1:4       u<=
    ex   DE, HL         ; 1:4       u<=
    sbc  HL, DE         ; 2:15      u<=
    sbc  HL, HL         ; 2:15      u<=
    pop  DE             ; 1:10      u<= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else128    ; 3:10      if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string131
    call PRINT_STRING_Z ; 3:17      print_z 
else128  EQU $          ;           = endif
endif128:
    
    ld    A, L          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, else129    ; 3:10      2dup u<= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string132
    call PRINT_STRING_Z ; 3:17      print_z 
else129  EQU $          ;           = endif
endif129:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, L          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= if
    pop  DE             ; 1:10      u<= if
    jp    c, else130    ; 3:10      u<= if 
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string133
    call PRINT_STRING_Z ; 3:17      print_z 
else130  EQU $          ;           = endif
endif130:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       u>
    sbc  HL, DE         ; 2:15      u>
    sbc  HL, HL         ; 2:15      u>
    pop  DE             ; 1:10      u> 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else131    ; 3:10      if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string134
    call PRINT_STRING_Z ; 3:17      print_z 
else131  EQU $          ;           = endif
endif131:
    
    ld    A, L          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, else132    ; 3:10      2dup u> if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string135
    call PRINT_STRING_Z ; 3:17      print_z 
else132  EQU $          ;           = endif
endif132:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, L          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> if
    pop  DE             ; 1:10      u> if
    jp   nc, else133    ; 3:10      u> if 
    ld   BC, string118  ; 3:10      print_z   Address of null-terminated string118 == string136
    call PRINT_STRING_Z ; 3:17      print_z 
else133  EQU $          ;           = endif
endif133:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    scf                 ; 1:4       u>=
    sbc  HL, DE         ; 2:15      u>=
    sbc  HL, HL         ; 2:15      u>=
    pop  DE             ; 1:10      u>= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else134    ; 3:10      if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string137
    call PRINT_STRING_Z ; 3:17      print_z 
else134  EQU $          ;           = endif
endif134:
    
    ld    A, E          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, else135    ; 3:10      2dup u>= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string138
    call PRINT_STRING_Z ; 3:17      print_z 
else135  EQU $          ;           = endif
endif135:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, E          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= if
    pop  DE             ; 1:10      u>= if
    jp    c, else136    ; 3:10      u>= if 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string139
    call PRINT_STRING_Z ; 3:17      print_z 
else136  EQU $          ;           = endif
endif136:
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    call PRINT_U16      ; 3:17      u.   ( u -- ) 
    call PRINT_U16      ; 3:17      u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

x_x_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
d_d_test:               ;           
    pop  BC             ; 1:10      : ret
    ld  (d_d_test_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    ; signed
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[15:90/69,91]D=  ( d2 d1 -- flag )
    pop  BC             ; 1:10      D=   BC = lo_2
    xor   A             ; 1:4       D=    A = 0x00
    sbc  HL, BC         ; 2:15      D=   HL = lo_1 - lo_2
    pop  HL             ; 1:10      D=   HL = hi_2
    jr   nz, $+7        ; 2:7/12    D=
    sbc  HL, DE         ; 2:15      D=   HL = hi_2 - hi_1
    jr   nz, $+3        ; 2:7/12    D=
    dec   A             ; 1:4       D=    A = 0xFF
    ld    L, A          ; 1:4       D=
    ld    H, A          ; 1:4       D=   HL = flag d2==d1
    pop  DE             ; 1:10      D= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else137    ; 3:10      if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string140
    call PRINT_STRING_Z ; 3:17      print_z 
else137  EQU $          ;           = endif
endif137:
     
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
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string141
    call PRINT_STRING_Z ; 3:17      print_z 
else138  EQU $          ;           = endif
endif138:
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[14:91]     D= if   ( d2 d1 -- )
    pop  BC             ; 1:10      D= if   lo_2
    or    A             ; 1:4       D= if
    sbc  HL, BC         ; 2:15      D= if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      D= if   hi_2
    jr   nz, $+4        ; 2:7/12    D= if
    sbc  HL, DE         ; 2:15      D= if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= if
    pop  DE             ; 1:10      D= if
    jp   nz, else139    ; 3:10      D= if 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106 == string142
    call PRINT_STRING_Z ; 3:17      print_z 
else139  EQU $          ;           = endif
endif139:
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[15:71,88/83]D<>  ( d2 d1 -- flag )
    pop  BC             ; 1:10      D<>   n h2    . h1 l1  BC= lo(d2) = l2
    xor   A             ; 1:4       D<>   n h2    . h1 l1  A = 0x00
    sbc  HL, BC         ; 2:15      D<>   n h2    . h1 --  HL= l1 - l2
    pop  HL             ; 1:10      D<>   n       . h1 h2  HL= hi(d2) = h2
    jr   nz, $+6        ; 2:7/12    D<>   n       . h1 h2
    sbc  HL, DE         ; 2:15      D<>   n       . h1 h2  HL = h2 - h1
    jr    z, $+5        ; 2:7/12    D<>   n       . h1 h2
    ld   HL, 0xFFFF     ; 3:10      D<>   n       . h1 ff  HL = true
    pop  DE             ; 1:10      D<>           . n  ff 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else140    ; 3:10      if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string143
    call PRINT_STRING_Z ; 3:17      print_z 
else140  EQU $          ;           = endif
endif140:
     
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
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string144
    call PRINT_STRING_Z ; 3:17      print_z 
else141  EQU $          ;           = endif
endif141:
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[14:91]     D<> if   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> if   lo_2
    or    A             ; 1:4       D<> if
    sbc  HL, BC         ; 2:15      D<> if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      D<> if   hi_2
    jr   nz, $+4        ; 2:7/12    D<> if
    sbc  HL, DE         ; 2:15      D<> if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> if
    pop  DE             ; 1:10      D<> if
    jp    z, else142    ; 3:10      D<> if 
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109 == string145
    call PRINT_STRING_Z ; 3:17      print_z 
else142  EQU $          ;           = endif
endif142:
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[17:93]     D<   ( d2 d1 -- flag )   # fast version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D<   lo_2
    ld    A, C          ; 1:4       D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       D<   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      D<   hi_2
    ld    A, L          ; 1:4       D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       D<   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    rra                 ; 1:4       D<                                   -->  sign if true
    xor   H             ; 1:4       D<
    xor   D             ; 1:4       D<
    add   A, A          ; 1:4       D<                                   --> carry if true
    sbc  HL, HL         ; 2:15      D<   set flag d2<d1
    pop  DE             ; 1:10      D< 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else143    ; 3:10      if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string146
    call PRINT_STRING_Z ; 3:17      print_z 
else143  EQU $          ;           = endif
endif143:
     
                        ;[6:27]     4dup D< if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< if   carry if true
    jp   nc, else144    ; 3:10      4dup D< if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string147
    call PRINT_STRING_Z ; 3:17      print_z 
else144  EQU $          ;           = endif
endif144:
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[18:94]     D< if   ( d2 d1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{fast})"
    pop  BC             ; 1:10      D< if   lo_2
    ld    A, C          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       D< if   lo_2<lo_1 --> BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      D< if   hi_2
    ld    A, L          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, E          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       D< if   hi_2<hi_1 --> HL<DE --> HL-DE<0 --> carry if true
    rra                 ; 1:4       D< if                                   --> sign  if true
    xor   H             ; 1:4       D< if
    xor   D             ; 1:4       D< if
    pop  HL             ; 1:10      D< if
    pop  DE             ; 1:10      D< if
    jp    p, else145    ; 3:10      D< if 
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112 == string148
    call PRINT_STRING_Z ; 3:17      print_z 
else145  EQU $          ;           = endif
endif145:
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[18:97]     D<=   ( d2 d1 -- flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      D<=   lo_2
    ld    A, L          ; 1:4       D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sub   C             ; 1:4       D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    ld    A, H          ; 1:4       D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    sbc   A, B          ; 1:4       D<=   lo_2<=lo_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  HL             ; 1:10      D<=   hi_2
    ld    A, E          ; 1:4       D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    sbc   A, L          ; 1:4       D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    ld    A, D          ; 1:4       D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    sbc   A, H          ; 1:4       D<=   hi_2<=hi_1 --> HL<=DE --> 0<=DE-HL --> no carry if true
    rra                 ; 1:4       D<=                                      --> no sign  if true
    xor   B             ; 1:4       D<=
    xor   D             ; 1:4       D<=
    add   A, A          ; 1:4       D<=                                      --> no carry if true
    ccf                 ; 1:4       D<=                                      --> carry    if true
    sbc  HL, HL         ; 2:15      D<=   set flag d2<d1
    pop  DE             ; 1:10      D<= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else146    ; 3:10      if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string149
    call PRINT_STRING_Z ; 3:17      print_z 
else146  EQU $          ;           = endif
endif146:
     
                        ;[6:27]     4dup D<= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= if   D> carry if true --> D<= carry if false
    jp    c, else147    ; 3:10      4dup D<= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string150
    call PRINT_STRING_Z ; 3:17      print_z 
else147  EQU $          ;           = endif
endif147:
     
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
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string151
    call PRINT_STRING_Z ; 3:17      print_z 
else148  EQU $          ;           = endif
endif148:
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[17:93]    D>   ( d2 d1 -- flag )   # function version can be changed with "define({_TYP_DOUBLE},{default})"
    pop  BC             ; 1:10      D>   lo(ud2)
    ld    A, L          ; 1:4       D>   BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       D>   BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       D>   BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       D>   BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      D>   hi(ud2)
    ld    A, E          ; 1:4       D>   BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       D>   BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       D>   BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       D>   BC>DE --> 0>DE-BC --> carry if true
    rra                 ; 1:4       D>                     --> sign  if true
    xor   B             ; 1:4       D>
    xor   D             ; 1:4       D>
    add   A, A          ; 1:4       D>                     --> carry if true
    sbc  HL, HL         ; 2:15      D>   set flag d2>d1
    pop  DE             ; 1:10      D> 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else149    ; 3:10      if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string152
    call PRINT_STRING_Z ; 3:17      print_z 
else149  EQU $          ;           = endif
endif149:
     
                        ;[6:27]     4dup D> if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> if   carry if true
    jp   nc, else150    ; 3:10      4dup D> if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string153
    call PRINT_STRING_Z ; 3:17      print_z 
else150  EQU $          ;           = endif
endif150:
     
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
    ld   BC, string118  ; 3:10      print_z   Address of null-terminated string118 == string154
    call PRINT_STRING_Z ; 3:17      print_z 
else151  EQU $          ;           = endif
endif151:
     
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[16:96]    D>=   ( d2 d1 -- flag )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      D>=   lo(ud2)
    scf                 ; 1:4       D>=
    sbc  HL, BC         ; 2:15      D>=   BC>=HL --> BC+1>HL --> 0>HL-BC-1 --> carry if true
    pop  HL             ; 1:10      D>=   hi(ud2)
    ld    A, E          ; 1:4       D>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc   A, L          ; 1:4       D>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    ld    A, D          ; 1:4       D>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc   A, H          ; 1:4       D>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    rra                 ; 1:4       D>=                                    -->  sign if true
    xor   H             ; 1:4       D>=
    xor   D             ; 1:4       D>=
    add   A, A          ; 1:4       D>=                                    --> carry if true
    sbc  HL, HL         ; 2:15      D>=   set flag d2>=d1
    pop  DE             ; 1:10      D>= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else152    ; 3:10      if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string155
    call PRINT_STRING_Z ; 3:17      print_z 
else152  EQU $          ;           = endif
endif152:
     
                        ;[6:27]     4dup D>= if   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= if   D< carry if true --> D>= carry if false
    jp    c, else153    ; 3:10      4dup D>= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string156
    call PRINT_STRING_Z ; 3:17      print_z 
else153  EQU $          ;           = endif
endif153:
     
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
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string157
    call PRINT_STRING_Z ; 3:17      print_z 
else154  EQU $          ;           = endif
endif154:
    
                        ;[9:91]     2over ( d c b a -- d c b a d c )
    pop  AF             ; 1:10      2over d       . b a     AF = c
    pop  BC             ; 1:10      2over         . b a     BC = d
    push BC             ; 1:11      2over d       . b a
    push AF             ; 1:11      2over d c     . b a
    push DE             ; 1:11      2over d c b   . b a
    push AF             ; 1:11      2over d c b c . b a
    ex  (SP),HL         ; 1:19      2over d c b a . b c
    ld    D, B          ; 1:4       2over
    ld    E, C          ; 1:4       2over d c b a . d c 
    call PRINT_S32      ; 3:17      d. 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    call PRINT_S32      ; 3:17      d. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ; unsigned
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[15:90/69,91]D=  ( d2 d1 -- flag )
    pop  BC             ; 1:10      D=   BC = lo_2
    xor   A             ; 1:4       D=    A = 0x00
    sbc  HL, BC         ; 2:15      D=   HL = lo_1 - lo_2
    pop  HL             ; 1:10      D=   HL = hi_2
    jr   nz, $+7        ; 2:7/12    D=
    sbc  HL, DE         ; 2:15      D=   HL = hi_2 - hi_1
    jr   nz, $+3        ; 2:7/12    D=
    dec   A             ; 1:4       D=    A = 0xFF
    ld    L, A          ; 1:4       D=
    ld    H, A          ; 1:4       D=   HL = flag d2==d1
    pop  DE             ; 1:10      D= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else155    ; 3:10      if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string158
    call PRINT_STRING_Z ; 3:17      print_z 
else155  EQU $          ;           = endif
endif155:
    
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
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string159
    call PRINT_STRING_Z ; 3:17      print_z 
else156  EQU $          ;           = endif
endif156:
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[14:91]     D= if   ( d2 d1 -- )
    pop  BC             ; 1:10      D= if   lo_2
    or    A             ; 1:4       D= if
    sbc  HL, BC         ; 2:15      D= if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      D= if   hi_2
    jr   nz, $+4        ; 2:7/12    D= if
    sbc  HL, DE         ; 2:15      D= if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= if
    pop  DE             ; 1:10      D= if
    jp   nz, else157    ; 3:10      D= if 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106 == string160
    call PRINT_STRING_Z ; 3:17      print_z 
else157  EQU $          ;           = endif
endif157:
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[15:71,88/83]D<>  ( d2 d1 -- flag )
    pop  BC             ; 1:10      D<>   n h2    . h1 l1  BC= lo(d2) = l2
    xor   A             ; 1:4       D<>   n h2    . h1 l1  A = 0x00
    sbc  HL, BC         ; 2:15      D<>   n h2    . h1 --  HL= l1 - l2
    pop  HL             ; 1:10      D<>   n       . h1 h2  HL= hi(d2) = h2
    jr   nz, $+6        ; 2:7/12    D<>   n       . h1 h2
    sbc  HL, DE         ; 2:15      D<>   n       . h1 h2  HL = h2 - h1
    jr    z, $+5        ; 2:7/12    D<>   n       . h1 h2
    ld   HL, 0xFFFF     ; 3:10      D<>   n       . h1 ff  HL = true
    pop  DE             ; 1:10      D<>           . n  ff 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else158    ; 3:10      if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string161
    call PRINT_STRING_Z ; 3:17      print_z 
else158  EQU $          ;           = endif
endif158:
    
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
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string162
    call PRINT_STRING_Z ; 3:17      print_z 
else159  EQU $          ;           = endif
endif159:
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[14:91]     D<> if   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> if   lo_2
    or    A             ; 1:4       D<> if
    sbc  HL, BC         ; 2:15      D<> if   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      D<> if   hi_2
    jr   nz, $+4        ; 2:7/12    D<> if
    sbc  HL, DE         ; 2:15      D<> if   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> if
    pop  DE             ; 1:10      D<> if
    jp    z, else160    ; 3:10      D<> if 
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109 == string163
    call PRINT_STRING_Z ; 3:17      print_z 
else160  EQU $          ;           = endif
endif160:
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[11:76]    Du<   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du<   lo(ud2)
    ld    A, C          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    sub   L             ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    ld    A, B          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    sbc   A, H          ; 1:4       Du<   BC<HL --> BC-HL<0 --> carry if true
    pop  HL             ; 1:10      Du<   hi(ud2)
    sbc  HL, DE         ; 2:15      Du<   HL<DE --> HL-DE<0 --> carry if true
    sbc  HL, HL         ; 2:15      Du<   set flag ud2<ud1
    pop  DE             ; 1:10      Du< 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else161    ; 3:10      if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string164
    call PRINT_STRING_Z ; 3:17      print_z 
else161  EQU $          ;           = endif
endif161:
    
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
    jp   nc, else162    ; 3:10      4dup D< if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string165
    call PRINT_STRING_Z ; 3:17      print_z 
else162  EQU $          ;           = endif
endif162:
    
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
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112 == string166
    call PRINT_STRING_Z ; 3:17      print_z 
else163  EQU $          ;           = endif
endif163:
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[12:80]    Du<=   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du<=   lo(ud2)
    scf                 ; 1:4       Du<=
    ld    A, C          ; 1:4       Du<=   BC<=HL --> BC<HL+1 --> BC-HL-1<0 --> carry if true
    sbc   A, L          ; 1:4       Du<=   BC<=HL --> BC<HL+1 --> BC-HL-1<0 --> carry if true
    ld    A, B          ; 1:4       Du<=   BC<=HL --> BC<HL+1 --> BC-HL-1<0 --> carry if true
    sbc   A, H          ; 1:4       Du<=   BC<=HL --> BC<HL+1 --> BC-HL-1<0 --> carry if true
    pop  HL             ; 1:10      Du<=   hi(ud2)
    sbc  HL, DE         ; 2:15      Du<=   HL<=DE --> HL<DE+1 --> HL-DE-1<0 --> carry if true
    sbc  HL, HL         ; 2:15      Du<=   set flag ud2<=ud1
    pop  DE             ; 1:10      Du<= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else164    ; 3:10      if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string167
    call PRINT_STRING_Z ; 3:17      print_z 
else164  EQU $          ;           = endif
endif164:
    
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
    jp    c, else165    ; 3:10      4dup D<= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string168
    call PRINT_STRING_Z ; 3:17      print_z 
else165  EQU $          ;           = endif
endif165:
    
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
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string169
    call PRINT_STRING_Z ; 3:17      print_z 
else166  EQU $          ;           = endif
endif166:
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[13:77]    Du>   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du>   lo(ud2)
    ld    A, L          ; 1:4       Du>   BC>HL --> 0>HL-BC --> carry if true
    sub   C             ; 1:4       Du>   BC>HL --> 0>HL-BC --> carry if true
    ld    A, H          ; 1:4       Du>   BC>HL --> 0>HL-BC --> carry if true
    sbc   A, B          ; 1:4       Du>   BC>HL --> 0>HL-BC --> carry if true
    pop  BC             ; 1:10      Du>   hi(ud2)
    ld    A, E          ; 1:4       Du>   BC>DE --> 0>DE-BC --> carry if true
    sbc   A, C          ; 1:4       Du>   BC>DE --> 0>DE-BC --> carry if true
    ld    A, D          ; 1:4       Du>   BC>DE --> 0>DE-BC --> carry if true
    sbc   A, B          ; 1:4       Du>   BC>DE --> 0>DE-BC --> carry if true
    sbc  HL, HL         ; 2:15      Du>   set flag ud2>ud1
    pop  DE             ; 1:10      Du> 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else167    ; 3:10      if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string170
    call PRINT_STRING_Z ; 3:17      print_z 
else167  EQU $          ;           = endif
endif167:
    
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
    jp   nc, else168    ; 3:10      4dup D> if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string171
    call PRINT_STRING_Z ; 3:17      print_z 
else168  EQU $          ;           = endif
endif168:
    
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
    ld   BC, string118  ; 3:10      print_z   Address of null-terminated string118 == string172
    call PRINT_STRING_Z ; 3:17      print_z 
else169  EQU $          ;           = endif
endif169:
    
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                        ;[12:80]    Du>=   ( ud2 ud1 -- flag )
    pop  BC             ; 1:10      Du>=   lo(ud2)
    scf                 ; 1:4       Du>=
    sbc  HL, BC         ; 2:15      Du>=   BC>=HL --> BC+1>HL --> 0>HL-BC-1 --> carry if true
    pop  HL             ; 1:10      Du>=   hi(ud2)
    ld    A, E          ; 1:4       Du>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc   A, L          ; 1:4       Du>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    ld    A, D          ; 1:4       Du>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc   A, H          ; 1:4       Du>=   HL>=DE --> HL+1>DE --> 0>DE-HL-1 --> carry if true
    sbc  HL, HL         ; 2:15      Du>=   set flag ud2>=ud1
    pop  DE             ; 1:10      Du>= 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else170    ; 3:10      if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string173
    call PRINT_STRING_Z ; 3:17      print_z 
else170  EQU $          ;           = endif
endif170:
    
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
    jp    c, else171    ; 3:10      4dup D>= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string174
    call PRINT_STRING_Z ; 3:17      print_z 
else171  EQU $          ;           = endif
endif171:
    
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
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string175
    call PRINT_STRING_Z ; 3:17      print_z 
else172  EQU $          ;           = endif
endif172:
    
                        ;[6:67]     2swap ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap d a . b c
    ex   DE, HL         ; 1:4       2swap d a . c b
    pop  AF             ; 1:10      2swap d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap b   . c d
    ex   DE, HL         ; 1:4       2swap b   . d c
    push AF             ; 1:11      2swap b a . d c 
    call PRINT_U32      ; 3:17      ud. 
    call PRINT_U32      ; 3:17      ud. 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

d_d_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



;   ---  the beginning of a non-recursive function  ---
x_p3_test:              ;           
    pop  BC             ; 1:10      : ret
    ld  (x_p3_test_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
                        ;[7:25]     dup 3 = if   variant: hi(3) = zero
    ld    A, low 3      ; 2:7       dup 3 = if
    xor   L             ; 1:4       dup 3 = if
    or    H             ; 1:4       dup 3 = if
    jp   nz, else173    ; 3:10      dup 3 = if 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106 == string176
    call PRINT_STRING_Z ; 3:17      print_z 
else173  EQU $          ;           = endif
endif173:
    
                        ;[7:25]     dup 3 <> if   variant: hi(3) = zero
    ld    A, low 3      ; 2:7       dup 3 <> if
    xor   L             ; 1:4       dup 3 <> if
    or    H             ; 1:4       dup 3 <> if
    jp    z, else174    ; 3:10      dup 3 <> if 
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109 == string177
    call PRINT_STRING_Z ; 3:17      print_z 
else174  EQU $          ;           = endif
endif174:
    
    ld    A, H          ; 1:4       dup 3 < if
    add   A, A          ; 1:4       dup 3 < if
    jr    c, $+11       ; 2:7/12    dup 3 < if    negative HL < positive constant ---> true
    ld    A, L          ; 1:4       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    jp   nc, else175    ; 3:10      dup 3 < if 
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112 == string178
    call PRINT_STRING_Z ; 3:17      print_z 
else175  EQU $          ;           = endif
endif175:
    
    ld    A, H          ; 1:4       dup 3 <= if
    add   A, A          ; 1:4       dup 3 <= if
    jr    c, $+11       ; 2:7/12    dup 3 <= if    negative HL <= positive constant ---> true
    ld    A, low 3      ; 2:7       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, else176    ; 3:10      dup 3 <= if 
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string179
    call PRINT_STRING_Z ; 3:17      print_z 
else176  EQU $          ;           = endif
endif176:
    
    ld    A, H          ; 1:4       dup 3 > if
    add   A, A          ; 1:4       dup 3 > if
    jp    c, else177    ; 3:10      dup 3 > if    negative HL > positive constant ---> false
    ld    A, low 3      ; 2:7       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    jp   nc, else177    ; 3:10      dup 3 > if 
    ld   BC, string118  ; 3:10      print_z   Address of null-terminated string118 == string180
    call PRINT_STRING_Z ; 3:17      print_z 
else177  EQU $          ;           = endif
endif177:
    
    ld    A, H          ; 1:4       dup 3 >= if
    add   A, A          ; 1:4       dup 3 >= if
    jp    c, else178    ; 3:10      dup 3 >= if    negative HL >= positive constant ---> false
    ld    A, L          ; 1:4       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, else178    ; 3:10      dup 3 >= if 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string181
    call PRINT_STRING_Z ; 3:17      print_z 
else178  EQU $          ;           = endif
endif178:
    
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
    
                        ;[7:25]     dup 3 u= if   variant: hi(3) = zero
    ld    A, low 3      ; 2:7       dup 3 u= if
    xor   L             ; 1:4       dup 3 u= if
    or    H             ; 1:4       dup 3 u= if
    jp   nz, else179    ; 3:10      dup 3 u= if 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106 == string182
    call PRINT_STRING_Z ; 3:17      print_z 
else179  EQU $          ;           = endif
endif179:
    
                        ;[7:25]     dup 3 u<> if   variant: hi(3) = zero
    ld    A, low 3      ; 2:7       dup 3 u<> if
    xor   L             ; 1:4       dup 3 u<> if
    or    H             ; 1:4       dup 3 u<> if
    jp    z, else180    ; 3:10      dup 3 u<> if 
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109 == string183
    call PRINT_STRING_Z ; 3:17      print_z 
else180  EQU $          ;           = endif
endif180:
    
    ld    A, L          ; 1:4       dup 3 u< if    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 u< if    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 u< if    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 u< if    HL<3 --> HL-3<0 --> carry if true
    jp   nc, else181    ; 3:10      dup 3 u< if 
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112 == string184
    call PRINT_STRING_Z ; 3:17      print_z 
else181  EQU $          ;           = endif
endif181:
    
    ld    A, low 3      ; 2:7       dup 3 u<= if    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 u<= if    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 u<= if    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 u<= if    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, else182    ; 3:10      dup 3 u<= if 
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string185
    call PRINT_STRING_Z ; 3:17      print_z 
else182  EQU $          ;           = endif
endif182:
    
    ld    A, low 3      ; 2:7       dup 3 u> if    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 u> if    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 u> if    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 u> if    HL>3 --> 0>3-HL --> carry if true
    jp   nc, else183    ; 3:10      dup 3 u> if 
    ld   BC, string118  ; 3:10      print_z   Address of null-terminated string118 == string186
    call PRINT_STRING_Z ; 3:17      print_z 
else183  EQU $          ;           = endif
endif183:
    
    ld    A, L          ; 1:4       dup 3 u>= if    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 u>= if    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 u>= if    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 u>= if    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, else184    ; 3:10      dup 3 u>= if 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string187
    call PRINT_STRING_Z ; 3:17      print_z 
else184  EQU $          ;           = endif
endif184:
    
    call PRINT_U16      ; 3:17      u.   ( u -- ) 
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call PRINT_U16      ; 3:17      u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

x_p3_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



;   ---  the beginning of a non-recursive function  ---
x_m3_test:              ;           
    pop  BC             ; 1:10      : ret
    ld  (x_m3_test_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
                        ;[11:18/39] dup -3 = if   variant: hi(-3) = 255
    ld    A, H          ; 1:4       dup -3 = if
    inc   A             ; 1:4       dup -3 = if
    jp   nz, else185    ; 3:10      dup -3 = if
    ld    A, low -3     ; 2:7       dup -3 = if
    xor   L             ; 1:4       dup -3 = if
    jp   nz, else185    ; 3:10      dup -3 = if 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106 == string188
    call PRINT_STRING_Z ; 3:17      print_z 
else185  EQU $          ;           = endif
endif185:
    
                        ;[10:20/36] dup -3 <> if   variant: hi(-3) = 255
    ld    A, H          ; 1:4       dup -3 <> if
    inc   A             ; 1:4       dup -3 <> if
    jr   nz, $+8        ; 2:7/12    dup -3 <> if
    ld    A, low -3     ; 2:7       dup -3 <> if
    xor   L             ; 1:4       dup -3 <> if
    jp    z, else186    ; 3:10      dup -3 <> if 
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109 == string189
    call PRINT_STRING_Z ; 3:17      print_z 
else186  EQU $          ;           = endif
endif186:
    
    ld    A, H          ; 1:4       dup -3 < if
    add   A, A          ; 1:4       dup -3 < if
    jp   nc, else187    ; 3:10      dup -3 < if    positive HL < negative constant ---> false
    ld    A, L          ; 1:4       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, else187    ; 3:10      dup -3 < if 
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112 == string190
    call PRINT_STRING_Z ; 3:17      print_z 
else187  EQU $          ;           = endif
endif187:
    
    ld    A, H          ; 1:4       dup -3 <= if
    add   A, A          ; 1:4       dup -3 <= if
    jp   nc, else188    ; 3:10      dup -3 <= if    positive HL <= negative constant ---> false
    ld    A, low -3     ; 2:7       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, else188    ; 3:10      dup -3 <= if 
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string191
    call PRINT_STRING_Z ; 3:17      print_z 
else188  EQU $          ;           = endif
endif188:
    
    ld    A, H          ; 1:4       dup -3 > if
    add   A, A          ; 1:4       dup -3 > if
    jr   nc, $+11       ; 2:7/12    dup -3 > if    positive HL > negative constant ---> true
    ld    A, low -3     ; 2:7       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, else189    ; 3:10      dup -3 > if 
    ld   BC, string118  ; 3:10      print_z   Address of null-terminated string118 == string192
    call PRINT_STRING_Z ; 3:17      print_z 
else189  EQU $          ;           = endif
endif189:
    
    ld    A, H          ; 1:4       dup -3 >= if
    add   A, A          ; 1:4       dup -3 >= if
    jr   nc, $+11       ; 2:7/12    dup -3 >= if    positive HL >= negative constant ---> true
    ld    A, L          ; 1:4       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, else190    ; 3:10      dup -3 >= if 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string193
    call PRINT_STRING_Z ; 3:17      print_z 
else190  EQU $          ;           = endif
endif190:
    
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
    
                        ;[11:18/39] dup -3 u= if   variant: hi(-3) = 255
    ld    A, H          ; 1:4       dup -3 u= if
    inc   A             ; 1:4       dup -3 u= if
    jp   nz, else191    ; 3:10      dup -3 u= if
    ld    A, low -3     ; 2:7       dup -3 u= if
    xor   L             ; 1:4       dup -3 u= if
    jp   nz, else191    ; 3:10      dup -3 u= if 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106 == string194
    call PRINT_STRING_Z ; 3:17      print_z 
else191  EQU $          ;           = endif
endif191:
    
                        ;[10:20/36] dup -3 u<> if   variant: hi(-3) = 255
    ld    A, H          ; 1:4       dup -3 u<> if
    inc   A             ; 1:4       dup -3 u<> if
    jr   nz, $+8        ; 2:7/12    dup -3 u<> if
    ld    A, low -3     ; 2:7       dup -3 u<> if
    xor   L             ; 1:4       dup -3 u<> if
    jp    z, else192    ; 3:10      dup -3 u<> if 
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109 == string195
    call PRINT_STRING_Z ; 3:17      print_z 
else192  EQU $          ;           = endif
endif192:
    
    ld    A, L          ; 1:4       dup -3 u< if    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 u< if    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 u< if    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 u< if    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, else193    ; 3:10      dup -3 u< if 
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112 == string196
    call PRINT_STRING_Z ; 3:17      print_z 
else193  EQU $          ;           = endif
endif193:
    
    ld    A, low -3     ; 2:7       dup -3 u<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 u<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 u<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 u<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, else194    ; 3:10      dup -3 u<= if 
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string197
    call PRINT_STRING_Z ; 3:17      print_z 
else194  EQU $          ;           = endif
endif194:
    
    ld    A, low -3     ; 2:7       dup -3 u> if    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 u> if    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 u> if    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 u> if    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, else195    ; 3:10      dup -3 u> if 
    ld   BC, string118  ; 3:10      print_z   Address of null-terminated string118 == string198
    call PRINT_STRING_Z ; 3:17      print_z 
else195  EQU $          ;           = endif
endif195:
    
    ld    A, L          ; 1:4       dup -3 u>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 u>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 u>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 u>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, else196    ; 3:10      dup -3 u>= if 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121 == string199
    call PRINT_STRING_Z ; 3:17      print_z 
else196  EQU $          ;           = endif
endif196:
    
    call PRINT_U16      ; 3:17      u.   ( u -- ) 
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call PRINT_U16      ; 3:17      u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

x_m3_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



;   ---  the beginning of a data stack function  ---
stack_test:             ;           
    
    ld   BC, string200  ; 3:10      print_z   Address of null-terminated string200
    call PRINT_STRING_Z ; 3:17      print_z
    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====

stack_test_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------

;==============================================================================
; ( hi lo -- )
; Input: HL
; Output: Print space and signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_S32:              ;           print_s32
    ld    A, D          ; 1:4       print_s32
    add   A, A          ; 1:4       print_s32
    jr   nc, PRINT_U32  ; 2:7/12    print_s32
    call NEGATE_32      ; 3:17      print_s32
    ld    A, ' '        ; 2:7       print_s32   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_s32   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '-'        ; 2:7       print_s32   putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      print_s32   ld   BC, **
    ; fall to print_u32dnl

;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_U32:              ;           print_u32
    ld    A, ' '        ; 2:7       print_u32   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_u32   putchar with ZX 48K ROM in, this will print char in A
    ; fall to print_u32_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_U32_ONLY:         ;           print_u32_only
    xor   A             ; 1:4       print_u32_only   A=0 => 103, A='0' => 00103
    push IX             ; 2:15      print_u32_only
    ex   DE, HL         ; 1:4       print_u32_only   HL = hi word
    ld  IXl, E          ; 2:8       print_u32_only
    ld  IXh, D          ; 2:8       print_u32_only   IX = lo word
    ld   DE, 0x3600     ; 3:10      print_u32_only   C4 65 36 00 = -1000000000
    ld   BC, 0xC465     ; 3:10      print_u32_only
    call BIN32_DEC+2    ; 3:17      print_u32_only
    ld    D, 0x1F       ; 2:7       print_u32_only   FA 0A 1F 00 = -100000000
    ld   BC, 0xFA0A     ; 3:10      print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0x6980     ; 3:10      print_u32_only   FF 67 69 80 = -10000000
    ld   BC, 0xFF67     ; 3:10      print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xBDC0     ; 3:10      print_u32_only   FF F0 BD C0 = -1000000
    ld    C, 0xF0       ; 2:7       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0x7960     ; 3:10      print_u32_only   FF FE 79 60 = -100000
    ld    C, 0xFE       ; 2:7       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xD8F0     ; 3:10      print_u32_only   FF FF D8 F0 = -10000
    ld    C, B          ; 1:4       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xFC18     ; 3:10      print_u32_only   FF FF FC 18 = -1000
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xFF9C     ; 3:10      print_u32_only   FF FF FF 9C = -100
    call BIN32_DEC      ; 3:17      print_u32_only
    ld    E, 0xF6       ; 2:7       print_u32_only   FF FF FF F6 = -10
    call BIN32_DEC      ; 3:17      print_u32_only
    ld    A, IXl        ; 2:8       print_u32_only
    pop  IX             ; 2:14      print_u32_only
    pop  BC             ; 1:10      print_u32_only   load ret
    pop  HL             ; 1:10      print_u32_only
    pop  DE             ; 1:10      print_u32_only
    push BC             ; 1:10      print_u32_only   save ret
    jr   BIN32_DEC_CHAR ; 2:12      print_u32_only
;------------------------------------------------------------------------------
; Input: A = 0..9 or '0'..'9' = 0x30..0x39 = 48..57, HL, IX, BC, DE
; Output: if ((HLIX/(-BCDE) > 0) || (A >= '0')) print number HLIX/(-BCDE)
; Pollutes: AF, AF', IX, HL
BIN32_DEC:              ;           bin32_dec
    and  0xF0           ; 2:7       bin32_dec   reset A to 0 or '0'
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
    ret                 ; 1:10      bin32_dec
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_S16:              ;           print_s16
    ld    A, H          ; 1:4       print_s16
    add   A, A          ; 1:4       print_s16
    jr   nc, PRINT_U16  ; 2:7/12    print_s16
    xor   A             ; 1:4       print_s16   neg
    sub   L             ; 1:4       print_s16   neg
    ld    L, A          ; 1:4       print_s16   neg
    sbc   A, H          ; 1:4       print_s16   neg
    sub   L             ; 1:4       print_s16   neg
    ld    H, A          ; 1:4       print_s16   neg
    ld    A, ' '        ; 2:7       print_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_s16   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '-'        ; 2:7       print_s16   putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      print_s16   ld   BC, **
    ; fall to print_u16
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_U16:              ;           print_u16
    ld    A, ' '        ; 2:7       print_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_u16   putchar with ZX 48K ROM in, this will print char in A
    ; fall to print_u16_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_U16_ONLY:         ;           print_u16_only
    xor   A             ; 1:4       print_u16_only   A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10      print_u16_only
    call BIN16_DEC+2    ; 3:17      print_u16_only
    ld   BC, -1000      ; 3:10      print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld   BC, -100       ; 3:10      print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld    C, -10        ; 2:7       print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld    A, L          ; 1:4       print_u16_only
    pop  BC             ; 1:10      print_u16_only   load ret
    ex   DE, HL         ; 1:4       print_u16_only
    pop  DE             ; 1:10      print_u16_only
    push BC             ; 1:10      print_u16_only   save ret
    jr   BIN16_DEC_CHAR ; 2:12      print_u16_only
;------------------------------------------------------------------------------
; Input: A = 0..9 or '0'..'9' = 0x30..0x39 = 48..57, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
BIN16_DEC:              ;           bin16_dec
    and  0xF0           ; 2:7       bin16_dec   reset A to 0 or '0'
    add  HL, BC         ; 1:11      bin16_dec
    inc   A             ; 1:4       bin16_dec
    jr    c, $-2        ; 2:7/12    bin16_dec
    sbc  HL, BC         ; 2:15      bin16_dec
    dec   A             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
BIN16_DEC_CHAR:         ;           bin16_dec
    or   '0'            ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
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
string200:
db 0xD, "Data stack OK!", 0xD, 0x00
size200 EQU $ - string200
string121:
db ">=,", 0x00
size121 EQU $ - string121
string119:
db ">=" , 0x00
size119 EQU $ - string119
string118:
db ">,", 0x00
size118 EQU $ - string118
string116:
db ">" , 0x00
size116 EQU $ - string116
string115:
db "<=,", 0x00
size115 EQU $ - string115
string113:
db "<=" , 0x00
size113 EQU $ - string113
string112:
db "<,", 0x00
size112 EQU $ - string112
string110:
db "<" , 0x00
size110 EQU $ - string110
string109:
db "<>,", 0x00
size109 EQU $ - string109
string107:
db "<>" , 0x00
size107 EQU $ - string107
string106:
db "=,", 0x00
size106 EQU $ - string106
string104:
db "=" , 0x00
size104 EQU $ - string104
string103:
db "RAS:", 0x00
size103 EQU $ - string103
string102:
db "( d2 d1 -- ) and ( ud2 ud1 -- ):",0x0D + 0x80
size102 EQU $ - string102
string101:
db "( x2 x1 -- ) and ( u2 u1 -- ):",0x0D + 0x80
size101 EQU $ - string101

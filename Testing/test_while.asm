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



    
    ld   BC, string103  ; 3:10      print_i   Address of string103 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
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
     
begin101:               ;           begin 101 
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
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101 
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break101       ; 3:10      break 101 
    jp   begin101       ; 3:10      again 101
break101:               ;           again 101
     
begin102:               ;           begin 102 
    ld    A, E          ; 1:4       2dup = while 102
    sub   L             ; 1:4       2dup = while 102
    jp   nz, break102   ; 3:10      2dup = while 102
    ld    A, D          ; 1:4       2dup = while 102
    sub   H             ; 1:4       2dup = while 102
    jp   nz, break102   ; 3:10      2dup = while 102 
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break102       ; 3:10      break 102 
    jp   begin102       ; 3:10      again 102
break102:               ;           again 102
     
begin103:               ;           begin 103 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       = while 103
    sbc  HL, DE         ; 2:15      = while 103
    pop  HL             ; 1:10      = while 103
    pop  DE             ; 1:10      = while 103
    jp   nz, break103   ; 3:10      = while 103 
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break103       ; 3:10      break 103 
    jp   begin103       ; 3:10      again 103
break103:               ;           again 103
     
begin104:               ;           begin 104 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <> 
    ld    A, H          ; 1:4       while 104
    or    L             ; 1:4       while 104
    ex   DE, HL         ; 1:4       while 104
    pop  DE             ; 1:10      while 104
    jp    z, break104   ; 3:10      while 104 
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break104       ; 3:10      break 104 
    jp   begin104       ; 3:10      again 104
break104:               ;           again 104
     
begin105:               ;           begin 105 
    ld    A, E          ; 1:4       2dup <> while 105
    sub   L             ; 1:4       2dup <> while 105
    jr   nz, $+7        ; 2:7/12    2dup <> while 105
    ld    A, D          ; 1:4       2dup <> while 105
    sub   H             ; 1:4       2dup <> while 105
    jp    z, break105   ; 3:10      2dup <> while 105 
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break105       ; 3:10      break 105 
    jp   begin105       ; 3:10      again 105
break105:               ;           again 105
     
begin106:               ;           begin 106 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       <> while 106
    sbc  HL, DE         ; 2:15      <> while 106
    pop  HL             ; 1:10      <> while 106
    pop  DE             ; 1:10      <> while 106
    jp    z, break106   ; 3:10      <> while 106 
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break106       ; 3:10      break 106 
    jp   begin106       ; 3:10      again 106
break106:               ;           again 106
     
begin107:               ;           begin 107 
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
    ld    A, H          ; 1:4       while 107
    or    L             ; 1:4       while 107
    ex   DE, HL         ; 1:4       while 107
    pop  DE             ; 1:10      while 107
    jp    z, break107   ; 3:10      while 107 
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break107       ; 3:10      break 107 
    jp   begin107       ; 3:10      again 107
break107:               ;           again 107
     
begin108:               ;           begin 108 
    ld    A, E          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < while 108
    xor   D             ; 1:4       2dup < while 108
    xor   H             ; 1:4       2dup < while 108
    jp    p, break108   ; 3:10      2dup < while 108 
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break108       ; 3:10      break 108 
    jp   begin108       ; 3:10      again 108
break108:               ;           again 108
     
begin109:               ;           begin 109 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, E          ; 1:4       < while 109    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       < while 109    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       < while 109    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       < while 109    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       < while 109
    xor   D             ; 1:4       < while 109
    xor   H             ; 1:4       < while 109
    pop  HL             ; 1:10      < while 109
    pop  DE             ; 1:10      < while 109
    jp    p, break109   ; 3:10      < while 109 
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break109       ; 3:10      break 109 
    jp   begin109       ; 3:10      again 109
break109:               ;           again 109
     
begin110:               ;           begin 110 
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
    ld    A, H          ; 1:4       while 110
    or    L             ; 1:4       while 110
    ex   DE, HL         ; 1:4       while 110
    pop  DE             ; 1:10      while 110
    jp    z, break110   ; 3:10      while 110 
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break110       ; 3:10      break 110 
    jp   begin110       ; 3:10      again 110
break110:               ;           again 110
     
begin111:               ;           begin 111 
    ld    A, L          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= while 111
    xor   D             ; 1:4       2dup <= while 111
    xor   H             ; 1:4       2dup <= while 111
    jp    m, break111   ; 3:10      2dup <= while 111 
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break111       ; 3:10      break 111 
    jp   begin111       ; 3:10      again 111
break111:               ;           again 111
     
begin112:               ;           begin 112 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, L          ; 1:4       <= while 112    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       <= while 112    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       <= while 112    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       <= while 112    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       <= while 112
    xor   D             ; 1:4       <= while 112
    xor   H             ; 1:4       <= while 112
    pop  HL             ; 1:10      <= while 112
    pop  DE             ; 1:10      <= while 112
    jp    m, break112   ; 3:10      <= while 112 
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break112       ; 3:10      break 112 
    jp   begin112       ; 3:10      again 112
break112:               ;           again 112
     
begin113:               ;           begin 113 
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
    ld    A, H          ; 1:4       while 113
    or    L             ; 1:4       while 113
    ex   DE, HL         ; 1:4       while 113
    pop  DE             ; 1:10      while 113
    jp    z, break113   ; 3:10      while 113 
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break113       ; 3:10      break 113 
    jp   begin113       ; 3:10      again 113
break113:               ;           again 113
     
begin114:               ;           begin 114 
    ld    A, L          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > while 114
    xor   D             ; 1:4       2dup > while 114
    xor   H             ; 1:4       2dup > while 114
    jp    p, break114   ; 3:10      2dup > while 114 
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break114       ; 3:10      break 114 
    jp   begin114       ; 3:10      again 114
break114:               ;           again 114
     
begin115:               ;           begin 115 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, L          ; 1:4       > while 115    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       > while 115    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       > while 115    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       > while 115    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       > while 115
    xor   D             ; 1:4       > while 115
    xor   H             ; 1:4       > while 115
    pop  HL             ; 1:10      > while 115
    pop  DE             ; 1:10      > while 115
    jp    p, break115   ; 3:10      > while 115 
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break115       ; 3:10      break 115 
    jp   begin115       ; 3:10      again 115
break115:               ;           again 115
     
begin116:               ;           begin 116 
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
    ld    A, H          ; 1:4       while 116
    or    L             ; 1:4       while 116
    ex   DE, HL         ; 1:4       while 116
    pop  DE             ; 1:10      while 116
    jp    z, break116   ; 3:10      while 116 
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break116       ; 3:10      break 116 
    jp   begin116       ; 3:10      again 116
break116:               ;           again 116
     
begin117:               ;           begin 117 
    ld    A, E          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= while 117
    xor   D             ; 1:4       2dup >= while 117
    xor   H             ; 1:4       2dup >= while 117
    jp    m, break117   ; 3:10      2dup >= while 117 
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break117       ; 3:10      break 117 
    jp   begin117       ; 3:10      again 117
break117:               ;           again 117
     
begin118:               ;           begin 118 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, E          ; 1:4       >= while 118    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       >= while 118    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       >= while 118    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       >= while 118    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       >= while 118
    xor   D             ; 1:4       >= while 118
    xor   H             ; 1:4       >= while 118
    pop  HL             ; 1:10      >= while 118
    pop  DE             ; 1:10      >= while 118
    jp    m, break118   ; 3:10      >= while 118 
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break118       ; 3:10      break 118 
    jp   begin118       ; 3:10      again 118
break118:               ;           again 118
    
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
    
begin119:               ;           begin 119 
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
    ld    A, H          ; 1:4       while 119
    or    L             ; 1:4       while 119
    ex   DE, HL         ; 1:4       while 119
    pop  DE             ; 1:10      while 119
    jp    z, break119   ; 3:10      while 119 
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit == string122
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break119       ; 3:10      break 119 
    jp   begin119       ; 3:10      again 119
break119:               ;           again 119
    
begin120:               ;           begin 120 
    ld    A, E          ; 1:4       2dup u= while 120
    sub   L             ; 1:4       2dup u= while 120
    jp   nz, break120   ; 3:10      2dup u= while 120
    ld    A, D          ; 1:4       2dup u= while 120
    sub   H             ; 1:4       2dup u= while 120
    jp   nz, break120   ; 3:10      2dup u= while 120 
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit == string123
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break120       ; 3:10      break 120 
    jp   begin120       ; 3:10      again 120
break120:               ;           again 120
    
begin121:               ;           begin 121 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       u= while 121
    sbc  HL, DE         ; 2:15      u= while 121
    pop  HL             ; 1:10      u= while 121
    pop  DE             ; 1:10      u= while 121
    jp   nz, break121   ; 3:10      u= while 121 
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit == string124
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break121       ; 3:10      break 121 
    jp   begin121       ; 3:10      again 121
break121:               ;           again 121
    
begin122:               ;           begin 122 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <> 
    ld    A, H          ; 1:4       while 122
    or    L             ; 1:4       while 122
    ex   DE, HL         ; 1:4       while 122
    pop  DE             ; 1:10      while 122
    jp    z, break122   ; 3:10      while 122 
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit == string125
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break122       ; 3:10      break 122 
    jp   begin122       ; 3:10      again 122
break122:               ;           again 122
    
begin123:               ;           begin 123 
    ld    A, E          ; 1:4       2dup u<> while 123
    sub   L             ; 1:4       2dup u<> while 123
    jr   nz, $+7        ; 2:7/12    2dup u<> while 123
    ld    A, D          ; 1:4       2dup u<> while 123
    sbc   A, H          ; 1:4       2dup u<> while 123
    jp    z, break123   ; 3:10      2dup u<> while 123 
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit == string126
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break123       ; 3:10      break 123 
    jp   begin123       ; 3:10      again 123
break123:               ;           again 123
    
begin124:               ;           begin 124 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       u<> while 124
    sbc  HL, DE         ; 2:15      u<> while 124
    pop  HL             ; 1:10      u<> while 124
    pop  DE             ; 1:10      u<> while 124
    jp    z, break124   ; 3:10      u<> while 124 
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit == string127
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break124       ; 3:10      break 124 
    jp   begin124       ; 3:10      again 124
break124:               ;           again 124
    
begin125:               ;           begin 125 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                        ;[7:41]     u<
    ld    A, E          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u<   DE<HL --> DE-HL<0 --> carry if true
    sbc  HL, HL         ; 2:15      u<
    pop  DE             ; 1:10      u< 
    ld    A, H          ; 1:4       while 125
    or    L             ; 1:4       while 125
    ex   DE, HL         ; 1:4       while 125
    pop  DE             ; 1:10      while 125
    jp    z, break125   ; 3:10      while 125 
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit == string128
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break125       ; 3:10      break 125 
    jp   begin125       ; 3:10      again 125
break125:               ;           again 125
    
begin126:               ;           begin 126 
    ld    A, E          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, break126   ; 3:10      2dup u< while 126 
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit == string129
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break126       ; 3:10      break 126 
    jp   begin126       ; 3:10      again 126
break126:               ;           again 126
    
begin127:               ;           begin 127 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, E          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< while 127
    pop  DE             ; 1:10      u< while 127
    jp   nc, break127   ; 3:10      u< while 127 
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit == string130
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break127       ; 3:10      break 127 
    jp   begin127       ; 3:10      again 127
break127:               ;           again 127
    
begin128:               ;           begin 128 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    scf                 ; 1:4       u<=
    ex   DE, HL         ; 1:4       u<=
    sbc  HL, DE         ; 2:15      u<=
    sbc  HL, HL         ; 2:15      u<=
    pop  DE             ; 1:10      u<= 
    ld    A, H          ; 1:4       while 128
    or    L             ; 1:4       while 128
    ex   DE, HL         ; 1:4       while 128
    pop  DE             ; 1:10      while 128
    jp    z, break128   ; 3:10      while 128 
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string131
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break128       ; 3:10      break 128 
    jp   begin128       ; 3:10      again 128
break128:               ;           again 128
    
begin129:               ;           begin 129 
    ld    A, L          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, break129   ; 3:10      2dup u<= while 129 
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string132
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break129       ; 3:10      break 129 
    jp   begin129       ; 3:10      again 129
break129:               ;           again 129
    
begin130:               ;           begin 130 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, L          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= while 130
    pop  DE             ; 1:10      u<= while 130
    jp    c, break130   ; 3:10      u<= while 130 
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string133
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break130       ; 3:10      break 130 
    jp   begin130       ; 3:10      again 130
break130:               ;           again 130
    
begin131:               ;           begin 131 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    or    A             ; 1:4       u>
    sbc  HL, DE         ; 2:15      u>
    sbc  HL, HL         ; 2:15      u>
    pop  DE             ; 1:10      u> 
    ld    A, H          ; 1:4       while 131
    or    L             ; 1:4       while 131
    ex   DE, HL         ; 1:4       while 131
    pop  DE             ; 1:10      while 131
    jp    z, break131   ; 3:10      while 131 
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string134
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break131       ; 3:10      break 131 
    jp   begin131       ; 3:10      again 131
break131:               ;           again 131
    
begin132:               ;           begin 132 
    ld    A, L          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, break132   ; 3:10      2dup u> while 132 
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string135
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break132       ; 3:10      break 132 
    jp   begin132       ; 3:10      again 132
break132:               ;           again 132
    
begin133:               ;           begin 133 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, L          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> while 133
    pop  DE             ; 1:10      u> while 133
    jp   nc, break133   ; 3:10      u> while 133 
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string136
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break133       ; 3:10      break 133 
    jp   begin133       ; 3:10      again 133
break133:               ;           again 133
    
begin134:               ;           begin 134 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    scf                 ; 1:4       u>=
    sbc  HL, DE         ; 2:15      u>=
    sbc  HL, HL         ; 2:15      u>=
    pop  DE             ; 1:10      u>= 
    ld    A, H          ; 1:4       while 134
    or    L             ; 1:4       while 134
    ex   DE, HL         ; 1:4       while 134
    pop  DE             ; 1:10      while 134
    jp    z, break134   ; 3:10      while 134 
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string137
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break134       ; 3:10      break 134 
    jp   begin134       ; 3:10      again 134
break134:               ;           again 134
    
begin135:               ;           begin 135 
    ld    A, E          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, break135   ; 3:10      2dup u>= while 135 
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string138
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break135       ; 3:10      break 135 
    jp   begin135       ; 3:10      again 135
break135:               ;           again 135
    
begin136:               ;           begin 136 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
    ld    A, E          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= while 136
    pop  DE             ; 1:10      u>= while 136
    jp    c, break136   ; 3:10      u>= while 136 
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string139
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break136       ; 3:10      break 136 
    jp   begin136       ; 3:10      again 136
break136:               ;           again 136
    
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
     
begin137:               ;           begin 137 
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
    ld    A, H          ; 1:4       while 137
    or    L             ; 1:4       while 137
    ex   DE, HL         ; 1:4       while 137
    pop  DE             ; 1:10      while 137
    jp    z, break137   ; 3:10      while 137 
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit == string140
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break137       ; 3:10      break 137 
    jp   begin137       ; 3:10      again 137
break137:               ;           again 137
     
begin138:               ;           begin 138 
                   ;[16:132/73,132] 4dup D= while 138   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= while 138   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= while 138   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= while 138   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= while 138   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= while 138   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= while 138   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= while 138   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= while 138   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= while 138   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= while 138   h2 l2 . h1 l1
    jp   nz, break138   ; 3:10      4dup D= while 138   h2 l2 . h1 l1 
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit == string141
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break138       ; 3:10      break 138 
    jp   begin138       ; 3:10      again 138
break138:               ;           again 138
     
begin139:               ;           begin 139 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[14:91]     D= while 139   ( d2 d1 -- )
    pop  BC             ; 1:10      D= while 139   lo_2
    or    A             ; 1:4       D= while 139
    sbc  HL, BC         ; 2:15      D= while 139   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      D= while 139   hi_2
    jr   nz, $+4        ; 2:7/12    D= while 139
    sbc  HL, DE         ; 2:15      D= while 139   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= while 139
    pop  DE             ; 1:10      D= while 139
    jp   nz, break139   ; 3:10      D= while 139 
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit == string142
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break139       ; 3:10      break 139 
    jp   begin139       ; 3:10      again 139
break139:               ;           again 139
     
begin140:               ;           begin 140 
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
    ld    A, H          ; 1:4       while 140
    or    L             ; 1:4       while 140
    ex   DE, HL         ; 1:4       while 140
    pop  DE             ; 1:10      while 140
    jp    z, break140   ; 3:10      while 140 
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit == string143
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break140       ; 3:10      break 140 
    jp   begin140       ; 3:10      again 140
break140:               ;           again 140
     
begin141:               ;           begin 141 
            ;[21:51,66,123,122/122] 4dup D<> while 141   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast
    pop  BC             ; 1:10      4dup D<> while 141   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while 141   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while 141   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> while 141   h2       . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> while 141   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while 141   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> while 141   h2       . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> while 141   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> while 141   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while 141   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> while 141   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> while 141   h2       . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> while 141   h2       . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> while 141   h2       . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> while 141   h2 l2    . h1 l1
    jp    z, break141   ; 3:10      4dup D<> while 141 
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit == string144
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break141       ; 3:10      break 141 
    jp   begin141       ; 3:10      again 141
break141:               ;           again 141
     
begin142:               ;           begin 142 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[14:91]     D<> while 142   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> while 142   lo_2
    or    A             ; 1:4       D<> while 142
    sbc  HL, BC         ; 2:15      D<> while 142   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      D<> while 142   hi_2
    jr   nz, $+4        ; 2:7/12    D<> while 142
    sbc  HL, DE         ; 2:15      D<> while 142   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> while 142
    pop  DE             ; 1:10      D<> while 142
    jp    z, break142   ; 3:10      D<> while 142 
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit == string145
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break142       ; 3:10      break 142 
    jp   begin142       ; 3:10      again 142
break142:               ;           again 142
     
begin143:               ;           begin 143 
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
    ld    A, H          ; 1:4       while 143
    or    L             ; 1:4       while 143
    ex   DE, HL         ; 1:4       while 143
    pop  DE             ; 1:10      while 143
    jp    z, break143   ; 3:10      while 143 
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit == string146
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break143       ; 3:10      break 143 
    jp   begin143       ; 3:10      again 143
break143:               ;           again 143
     
begin144:               ;           begin 144 
                        ;[6:27]     4dup D< while 144   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< while 144   carry if true
    jp   nc, break144   ; 3:10      4dup D< while 144 
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit == string147
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break144       ; 3:10      break 144 
    jp   begin144       ; 3:10      again 144
break144:               ;           again 144
     
begin145:               ;           begin 145 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[10:67]     D< while 145   ( d2 d1 -- )
    pop  BC             ; 1:10      D< while 145   l2
    pop  AF             ; 1:10      D< while 145   h2
    call FCE_DLT        ; 3:17      D< while 145   carry if true
    pop  HL             ; 1:10      D< while 145
    pop  DE             ; 1:10      D< while 145
    jp   nc, break145   ; 3:10      D< while 145 
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit == string148
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break145       ; 3:10      break 145 
    jp   begin145       ; 3:10      again 145
break145:               ;           again 145
     
begin146:               ;           begin 146 
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
    ld    A, H          ; 1:4       while 146
    or    L             ; 1:4       while 146
    ex   DE, HL         ; 1:4       while 146
    pop  DE             ; 1:10      while 146
    jp    z, break146   ; 3:10      while 146 
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string149
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break146       ; 3:10      break 146 
    jp   begin146       ; 3:10      again 146
break146:               ;           again 146
     
begin147:               ;           begin 147 
                        ;[6:27]     4dup D<= while 147   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= while 147   D> carry if true --> D<= carry if false
    jp    c, break147   ; 3:10      4dup D<= while 147 
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string150
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break147       ; 3:10      break 147 
    jp   begin147       ; 3:10      again 147
break147:               ;           again 147
     
begin148:               ;           begin 148 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[10:67]     D<= while 148   ( d2 d1 -- )
    pop  BC             ; 1:10      D<= while 148   l2
    pop  AF             ; 1:10      D<= while 148   h2
    call FCE_DGT        ; 3:17      D<= while 148   D> carry if true --> D<= carry if false
    pop  HL             ; 1:10      D<= while 148
    pop  DE             ; 1:10      D<= while 148
    jp    c, break148   ; 3:10      D<= while 148 
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string151
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break148       ; 3:10      break 148 
    jp   begin148       ; 3:10      again 148
break148:               ;           again 148
     
begin149:               ;           begin 149 
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
    ld    A, H          ; 1:4       while 149
    or    L             ; 1:4       while 149
    ex   DE, HL         ; 1:4       while 149
    pop  DE             ; 1:10      while 149
    jp    z, break149   ; 3:10      while 149 
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string152
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break149       ; 3:10      break 149 
    jp   begin149       ; 3:10      again 149
break149:               ;           again 149
     
begin150:               ;           begin 150 
                        ;[6:27]     4dup D> while 150   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> while 150   carry if true
    jp   nc, break150   ; 3:10      4dup D> while 150 
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string153
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break150       ; 3:10      break 150 
    jp   begin150       ; 3:10      again 150
break150:               ;           again 150
     
begin151:               ;           begin 151 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[10:67]     D> while 151   ( d2 d1 -- )
    pop  BC             ; 1:10      D> while 151   l2
    pop  AF             ; 1:10      D> while 151   h2
    call FCE_DGT        ; 3:17      D> while 151   carry if true
    pop  HL             ; 1:10      D> while 151
    pop  DE             ; 1:10      D> while 151
    jp   nc, break151   ; 3:10      D> while 151 
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string154
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break151       ; 3:10      break 151 
    jp   begin151       ; 3:10      again 151
break151:               ;           again 151
     
begin152:               ;           begin 152 
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
    ld    A, H          ; 1:4       while 152
    or    L             ; 1:4       while 152
    ex   DE, HL         ; 1:4       while 152
    pop  DE             ; 1:10      while 152
    jp    z, break152   ; 3:10      while 152 
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string155
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break152       ; 3:10      break 152 
    jp   begin152       ; 3:10      again 152
break152:               ;           again 152
     
begin153:               ;           begin 153 
                        ;[6:27]     4dup D>= while 153   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= while 153   D< carry if true --> D>= carry if false
    jp    c, break153   ; 3:10      4dup D>= while 153 
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string156
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break153       ; 3:10      break 153 
    jp   begin153       ; 3:10      again 153
break153:               ;           again 153
     
begin154:               ;           begin 154 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[10:67]     D>= while 154   ( d2 d1 -- )
    pop  BC             ; 1:10      D>= while 154   l2
    pop  AF             ; 1:10      D>= while 154   h2
    call FCE_DLT        ; 3:17      D>= while 154   D< carry if true --> D>= carry if false
    pop  HL             ; 1:10      D>= while 154
    pop  DE             ; 1:10      D>= while 154
    jp    c, break154   ; 3:10      D>= while 154 
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string157
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break154       ; 3:10      break 154 
    jp   begin154       ; 3:10      again 154
break154:               ;           again 154
    
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
    
begin155:               ;           begin 155 
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
    ld    A, H          ; 1:4       while 155
    or    L             ; 1:4       while 155
    ex   DE, HL         ; 1:4       while 155
    pop  DE             ; 1:10      while 155
    jp    z, break155   ; 3:10      while 155 
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit == string158
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break155       ; 3:10      break 155 
    jp   begin155       ; 3:10      again 155
break155:               ;           again 155
    
begin156:               ;           begin 156 
                   ;[16:132/73,132] 4dup D= while 156   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= while 156   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= while 156   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= while 156   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= while 156   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= while 156   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= while 156   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= while 156   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= while 156   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= while 156   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= while 156   h2 l2 . h1 l1
    jp   nz, break156   ; 3:10      4dup D= while 156   h2 l2 . h1 l1 
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit == string159
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break156       ; 3:10      break 156 
    jp   begin156       ; 3:10      again 156
break156:               ;           again 156
    
begin157:               ;           begin 157 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[14:91]     D= while 157   ( d2 d1 -- )
    pop  BC             ; 1:10      D= while 157   lo_2
    or    A             ; 1:4       D= while 157
    sbc  HL, BC         ; 2:15      D= while 157   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if false
    pop  HL             ; 1:10      D= while 157   hi_2
    jr   nz, $+4        ; 2:7/12    D= while 157
    sbc  HL, DE         ; 2:15      D= while 157   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if false
    pop  HL             ; 1:10      D= while 157
    pop  DE             ; 1:10      D= while 157
    jp   nz, break157   ; 3:10      D= while 157 
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit == string160
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break157       ; 3:10      break 157 
    jp   begin157       ; 3:10      again 157
break157:               ;           again 157
    
begin158:               ;           begin 158 
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
    ld    A, H          ; 1:4       while 158
    or    L             ; 1:4       while 158
    ex   DE, HL         ; 1:4       while 158
    pop  DE             ; 1:10      while 158
    jp    z, break158   ; 3:10      while 158 
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit == string161
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break158       ; 3:10      break 158 
    jp   begin158       ; 3:10      again 158
break158:               ;           again 158
    
begin159:               ;           begin 159 
            ;[21:51,66,123,122/122] 4dup D<> while 159   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast
    pop  BC             ; 1:10      4dup D<> while 159   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while 159   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while 159   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> while 159   h2       . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> while 159   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while 159   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> while 159   h2       . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> while 159   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> while 159   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while 159   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> while 159   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> while 159   h2       . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> while 159   h2       . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> while 159   h2       . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> while 159   h2 l2    . h1 l1
    jp    z, break159   ; 3:10      4dup D<> while 159 
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit == string162
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break159       ; 3:10      break 159 
    jp   begin159       ; 3:10      again 159
break159:               ;           again 159
    
begin160:               ;           begin 160 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[14:91]     D<> while 160   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> while 160   lo_2
    or    A             ; 1:4       D<> while 160
    sbc  HL, BC         ; 2:15      D<> while 160   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> nz if true
    pop  HL             ; 1:10      D<> while 160   hi_2
    jr   nz, $+4        ; 2:7/12    D<> while 160
    sbc  HL, DE         ; 2:15      D<> while 160   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> nz if true
    pop  HL             ; 1:10      D<> while 160
    pop  DE             ; 1:10      D<> while 160
    jp    z, break160   ; 3:10      D<> while 160 
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit == string163
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break160       ; 3:10      break 160 
    jp   begin160       ; 3:10      again 160
break160:               ;           again 160
    
begin161:               ;           begin 161 
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
    ld    A, H          ; 1:4       while 161
    or    L             ; 1:4       while 161
    ex   DE, HL         ; 1:4       while 161
    pop  DE             ; 1:10      while 161
    jp    z, break161   ; 3:10      while 161 
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit == string164
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break161       ; 3:10      break 161 
    jp   begin161       ; 3:10      again 161
break161:               ;           again 161
    
begin162:               ;           begin 162 
                       ;[15:101]    4dup Du< while 162   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du< while 162   ud2 < ud1 --> ud2-ud1<0 --> (SP)BC-DEHL<0 --> carry if true
    ld    A, C          ; 1:4       4dup Du< while 162
    sub   L             ; 1:4       4dup Du< while 162   C-L<0 --> carry if true
    ld    A, B          ; 1:4       4dup Du< while 162
    sbc   A, H          ; 1:4       4dup Du< while 162   B-H<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< while 162   HL = hi2
    ld    A, L          ; 1:4       4dup Du< while 162   HLBC-DE(SP)<0 -- carry if true
    sbc   A, E          ; 1:4       4dup Du< while 162   L-E<0 --> carry if true
    ld    A, H          ; 1:4       4dup Du< while 162
    sbc   A, D          ; 1:4       4dup Du< while 162   H-D<0 --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du< while 162
    push BC             ; 1:11      4dup Du< while 162
    jp   nc, break162   ; 3:10      4dup Du< while 162 
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit == string165
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break162       ; 3:10      break 162 
    jp   begin162       ; 3:10      again 162
break162:               ;           again 162
    
begin163:               ;           begin 163 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[13:81]     Du< while 163   ( ud2 ud1 -- )
    pop  BC             ; 1:10      Du< while 163   lo_2
    ld    A, C          ; 1:4       Du< while 163   d2<d1 --> d2-d1<0 --> (SP)BC-DEHL<0 --> carry if true
    sub   L             ; 1:4       Du< while 163   C-L<0 --> carry if true
    ld    A, B          ; 1:4       Du< while 163
    sbc   A, H          ; 1:4       Du< while 163   B-H<0 --> carry if true
    pop  HL             ; 1:10      Du< while 163   hi_2
    sbc  HL, DE         ; 2:15      Du< while 163   HL-DE<0 --> carry if true
    pop  HL             ; 1:10      Du< while 163
    pop  DE             ; 1:10      Du< while 163
    jp   nc, break163   ; 3:10      Du< while 163 
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit == string166
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break163       ; 3:10      break 163 
    jp   begin163       ; 3:10      again 163
break163:               ;           again 163
    
begin164:               ;           begin 164 
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
    ld    A, H          ; 1:4       while 164
    or    L             ; 1:4       while 164
    ex   DE, HL         ; 1:4       while 164
    pop  DE             ; 1:10      while 164
    jp    z, break164   ; 3:10      while 164 
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string167
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break164       ; 3:10      break 164 
    jp   begin164       ; 3:10      again 164
break164:               ;           again 164
    
begin165:               ;           begin 165 
                       ;[15:101]    4dup Du<= while 165   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du<= while 165   ud2 <= ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> no carry if true
    ld    A, L          ; 1:4       4dup Du<= while 165
    sub   C             ; 1:4       4dup Du<= while 165   0<=L-C --> no carry if true
    ld    A, H          ; 1:4       4dup Du<= while 165
    sbc   A, B          ; 1:4       4dup Du<= while 165   0<=H-B --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= while 165   HL = hi2
    ld    A, E          ; 1:4       4dup Du<= while 165   0<=DE(SP)-HLBC -- no carry if true
    sbc   A, L          ; 1:4       4dup Du<= while 165   0<=E-L --> no carry if true
    ld    A, D          ; 1:4       4dup Du<= while 165
    sbc   A, H          ; 1:4       4dup Du<= while 165   0<=D-H --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du<= while 165
    push BC             ; 1:11      4dup Du<= while 165
    jp    c, break165   ; 3:10      4dup Du<= while 165 
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string168
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break165       ; 3:10      break 165 
    jp   begin165       ; 3:10      again 165
break165:               ;           again 165
    
begin166:               ;           begin 166 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[13:88]     Du<= while 166   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du<= while 166   lo_2
    or    A             ; 1:4       Du<= while 166
    sbc  HL, BC         ; 2:15      Du<= while 166   ud2<=ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> no carry if true
    pop  BC             ; 1:10      Du<= while 166   hi_2
    ex   DE, HL         ; 1:4       Du<= while 166
    sbc  HL, BC         ; 2:15      Du<= while 166   hi_2<=hi_1 --> BC<=HL --> 0<=HL-BC --> no carry if true
    pop  HL             ; 1:10      Du<= while 166
    pop  DE             ; 1:10      Du<= while 166
    jp    c, break166   ; 3:10      Du<= while 166 
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string169
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break166       ; 3:10      break 166 
    jp   begin166       ; 3:10      again 166
break166:               ;           again 166
    
begin167:               ;           begin 167 
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
    ld    A, H          ; 1:4       while 167
    or    L             ; 1:4       while 167
    ex   DE, HL         ; 1:4       while 167
    pop  DE             ; 1:10      while 167
    jp    z, break167   ; 3:10      while 167 
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string170
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break167       ; 3:10      break 167 
    jp   begin167       ; 3:10      again 167
break167:               ;           again 167
    
begin168:               ;           begin 168 
                       ;[15:101]    4dup Du> while 168   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du> while 168   ud2 > ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> carry if true
    ld    A, L          ; 1:4       4dup Du> while 168
    sub   C             ; 1:4       4dup Du> while 168   0>L-C --> carry if true
    ld    A, H          ; 1:4       4dup Du> while 168
    sbc   A, B          ; 1:4       4dup Du> while 168   0>H-B --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> while 168   HL = hi2
    ld    A, E          ; 1:4       4dup Du> while 168   0>DE(SP)-HLBC -- carry if true
    sbc   A, L          ; 1:4       4dup Du> while 168   0>E-L --> carry if true
    ld    A, D          ; 1:4       4dup Du> while 168
    sbc   A, H          ; 1:4       4dup Du> while 168   0>D-H --> carry if true
    ex  (SP),HL         ; 1:19      4dup Du> while 168
    push BC             ; 1:11      4dup Du> while 168
    jp   nc, break168   ; 3:10      4dup Du> while 168 
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string171
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break168       ; 3:10      break 168 
    jp   begin168       ; 3:10      again 168
break168:               ;           again 168
    
begin169:               ;           begin 169 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[13:88]     Du> while 169   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du> while 169   lo_2
    or    A             ; 1:4       Du> while 169
    sbc  HL, BC         ; 2:15      Du> while 169   ud2>ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> carry if true
    pop  BC             ; 1:10      Du> while 169   hi_2
    ex   DE, HL         ; 1:4       Du> while 169
    sbc  HL, BC         ; 2:15      Du> while 169   hi_2>hi_1 --> BC>HL --> 0>HL-BC --> carry if true
    pop  HL             ; 1:10      Du> while 169
    pop  DE             ; 1:10      Du> while 169
    jp   nc, break169   ; 3:10      Du> while 169 
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string172
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break169       ; 3:10      break 169 
    jp   begin169       ; 3:10      again 169
break169:               ;           again 169
    
begin170:               ;           begin 170 
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
    ld    A, H          ; 1:4       while 170
    or    L             ; 1:4       while 170
    ex   DE, HL         ; 1:4       while 170
    pop  DE             ; 1:10      while 170
    jp    z, break170   ; 3:10      while 170 
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string173
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break170       ; 3:10      break 170 
    jp   begin170       ; 3:10      again 170
break170:               ;           again 170
    
begin171:               ;           begin 171 
                       ;[15:101]    4dup Du>= while 171   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du>= while 171   ud2 >= ud1 --> ud2-ud1>=0 --> (SP)BC-DEHL>=0 --> no carry if true
    ld    A, C          ; 1:4       4dup Du>= while 171
    sub   L             ; 1:4       4dup Du>= while 171   C-L>=0 --> no carry if true
    ld    A, B          ; 1:4       4dup Du>= while 171
    sbc   A, H          ; 1:4       4dup Du>= while 171   B-H>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= while 171   HL = hi2
    ld    A, L          ; 1:4       4dup Du>= while 171   HLBC-DE(SP)>=0 -- no carry if true
    sbc   A, E          ; 1:4       4dup Du>= while 171   L-E>=0 --> no carry if true
    ld    A, H          ; 1:4       4dup Du>= while 171
    sbc   A, D          ; 1:4       4dup Du>= while 171   H-D>=0 --> no carry if true
    ex  (SP),HL         ; 1:19      4dup Du>= while 171
    push BC             ; 1:11      4dup Du>= while 171
    jp    c, break171   ; 3:10      4dup Du>= while 171 
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string174
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break171       ; 3:10      break 171 
    jp   begin171       ; 3:10      again 171
break171:               ;           again 171
    
begin172:               ;           begin 172 
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup 
                       ;[13:81]     Du>= while 172   ( ud2 ud1 -- )
    pop  BC             ; 1:10      Du>= while 172   lo_2
    ld    A, C          ; 1:4       Du>= while 172   d2>=d1 --> d2-d1>=0 --> (SP)BC-DEHL>=0 --> no carry if true
    sub   L             ; 1:4       Du>= while 172   C-L>=0 --> no carry if true
    ld    A, B          ; 1:4       Du>= while 172
    sbc   A, H          ; 1:4       Du>= while 172   B-H>=0 --> no carry if true
    pop  HL             ; 1:10      Du>= while 172   hi_2
    sbc  HL, DE         ; 2:15      Du>= while 172   HL-DE>=0 --> no carry if true
    pop  HL             ; 1:10      Du>= while 172
    pop  DE             ; 1:10      Du>= while 172
    jp    c, break172   ; 3:10      Du>= while 172 
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string175
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break172       ; 3:10      break 172 
    jp   begin172       ; 3:10      again 172
break172:               ;           again 172
    
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
    ; signed
    
begin173:               ;           begin 173 
    ld    A, low 3      ; 2:7       dup 3 = while 173
    xor   L             ; 1:4       dup 3 = while 173
    jp   nz, break173   ; 3:10      dup 3 = while 173
    ld    A, high 3     ; 2:7       dup 3 = while 173
    xor   H             ; 1:4       dup 3 = while 173
    jp   nz, break173   ; 3:10      dup 3 = while 173 
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit == string176
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break173       ; 3:10      break 173 
    jp   begin173       ; 3:10      again 173
break173:               ;           again 173
    
begin174:               ;           begin 174 
    ld    A, low 3      ; 2:7       dup 3 <> while 174
    xor   L             ; 1:4       dup 3 <> while 174
    jr   nz, $+8        ; 2:7/12    dup 3 <> while 174
    ld    A, high 3     ; 2:7       dup 3 <> while 174
    xor   H             ; 1:4       dup 3 <> while 174
    jp    z, break174   ; 3:10      dup 3 <> while 174 
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit == string177
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break174       ; 3:10      break 174 
    jp   begin174       ; 3:10      again 174
break174:               ;           again 174
    
begin175:               ;           begin 175 
    ld    A, H          ; 1:4       dup 3 < while 175
    add   A, A          ; 1:4       dup 3 < while 175
    jr    c, $+11       ; 2:7/12    dup 3 < while 175    negative HL < positive constant ---> true
    ld    A, L          ; 1:4       dup 3 < while 175    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 < while 175    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 < while 175    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 < while 175    HL<3 --> HL-3<0 --> carry if true
    jp   nc, break175   ; 3:10      dup 3 < while 175 
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit == string178
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break175       ; 3:10      break 175 
    jp   begin175       ; 3:10      again 175
break175:               ;           again 175
    
begin176:               ;           begin 176 
    ld    A, H          ; 1:4       dup 3 <= while 176
    add   A, A          ; 1:4       dup 3 <= while 176
    jr    c, $+11       ; 2:7/12    dup 3 <= while 176    negative HL <= positive constant ---> true
    ld    A, low 3      ; 2:7       dup 3 <= while 176    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 <= while 176    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 <= while 176    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 <= while 176    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, break176   ; 3:10      dup 3 <= while 176 
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string179
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break176       ; 3:10      break 176 
    jp   begin176       ; 3:10      again 176
break176:               ;           again 176
    
begin177:               ;           begin 177 
    ld    A, H          ; 1:4       dup 3 > while 177
    add   A, A          ; 1:4       dup 3 > while 177
    jp    c, break177   ; 3:10      dup 3 > while 177    negative HL > positive constant ---> false
    ld    A, low 3      ; 2:7       dup 3 > while 177    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 > while 177    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 > while 177    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 > while 177    HL>3 --> 0>3-HL --> carry if true
    jp   nc, break177   ; 3:10      dup 3 < while 177 
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string180
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break177       ; 3:10      break 177 
    jp   begin177       ; 3:10      again 177
break177:               ;           again 177
    
begin178:               ;           begin 178 
    ld    A, H          ; 1:4       dup 3 >= while 178
    add   A, A          ; 1:4       dup 3 >= while 178
    jp    c, break178   ; 3:10      dup 3 >= while 178    negative HL >= positive constant ---> false
    ld    A, L          ; 1:4       dup 3 >= while 178    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 >= while 178    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 >= while 178    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 >= while 178    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, break178   ; 3:10      dup 3 >= while 178 
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string181
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break178       ; 3:10      break 178 
    jp   begin178       ; 3:10      again 178
break178:               ;           again 178
    
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
    ; unsigned
    
begin179:               ;           begin 179 
    ld    A, low 3      ; 2:7       dup 3 u= while 179
    xor   L             ; 1:4       dup 3 u= while 179
    jp   nz, break179   ; 3:10      dup 3 u= while 179
    ld    A, high 3     ; 2:7       dup 3 u= while 179
    xor   H             ; 1:4       dup 3 u= while 179
    jp   nz, break179   ; 3:10      dup 3 u= while 179 
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit == string182
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break179       ; 3:10      break 179 
    jp   begin179       ; 3:10      again 179
break179:               ;           again 179
    
begin180:               ;           begin 180 
    ld    A, low 3      ; 2:7       dup 3 u<> while 180
    xor   L             ; 1:4       dup 3 u<> while 180
    jr   nz, $+8        ; 2:7/12    dup 3 u<> while 180
    ld    A, high 3     ; 2:7       dup 3 u<> while 180
    xor   H             ; 1:4       dup 3 u<> while 180
    jp    z, break180   ; 3:10      dup 3 u<> while 180 
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit == string183
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break180       ; 3:10      break 180 
    jp   begin180       ; 3:10      again 180
break180:               ;           again 180
    
begin181:               ;           begin 181 
    ld    A, L          ; 1:4       dup 3 u< while 181    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 u< while 181    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 u< while 181    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 u< while 181    HL<3 --> HL-3<0 --> carry if true
    jp   nc, break181   ; 3:10      dup 3 u< while 181 
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit == string184
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break181       ; 3:10      break 181 
    jp   begin181       ; 3:10      again 181
break181:               ;           again 181
    
begin182:               ;           begin 182 
    ld    A, low 3      ; 2:7       dup 3 u<= while 182    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 u<= while 182    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 u<= while 182    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 u<= while 182    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, break182   ; 3:10      dup 3 u<= while 182 
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string185
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break182       ; 3:10      break 182 
    jp   begin182       ; 3:10      again 182
break182:               ;           again 182
    
begin183:               ;           begin 183 
    ld    A, low 3      ; 2:7       dup 3 u> while 183    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 u> while 183    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 u> while 183    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 u> while 183    HL>3 --> 0>3-HL --> carry if true
    jp   nc, break183   ; 3:10      dup 3 u> while 183 
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string186
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break183       ; 3:10      break 183 
    jp   begin183       ; 3:10      again 183
break183:               ;           again 183
    
begin184:               ;           begin 184 
    ld    A, L          ; 1:4       dup 3 u>= while 184    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 u>= while 184    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 u>= while 184    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 u>= while 184    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, break184   ; 3:10      dup 3 u>= while 184 
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string187
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break184       ; 3:10      break 184 
    jp   begin184       ; 3:10      again 184
break184:               ;           again 184
    
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
    ; signed
    
begin185:               ;           begin 185 
    ld    A, low -3     ; 2:7       dup -3 = while 185
    xor   L             ; 1:4       dup -3 = while 185
    jp   nz, break185   ; 3:10      dup -3 = while 185
    ld    A, high -3    ; 2:7       dup -3 = while 185
    xor   H             ; 1:4       dup -3 = while 185
    jp   nz, break185   ; 3:10      dup -3 = while 185 
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit == string188
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break185       ; 3:10      break 185 
    jp   begin185       ; 3:10      again 185
break185:               ;           again 185
    
begin186:               ;           begin 186 
    ld    A, low -3     ; 2:7       dup -3 <> while 186
    xor   L             ; 1:4       dup -3 <> while 186
    jr   nz, $+8        ; 2:7/12    dup -3 <> while 186
    ld    A, high -3    ; 2:7       dup -3 <> while 186
    xor   H             ; 1:4       dup -3 <> while 186
    jp    z, break186   ; 3:10      dup -3 <> while 186 
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit == string189
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break186       ; 3:10      break 186 
    jp   begin186       ; 3:10      again 186
break186:               ;           again 186
    
begin187:               ;           begin 187 
    ld    A, H          ; 1:4       dup -3 < while 187
    add   A, A          ; 1:4       dup -3 < while 187
    jp   nc, break187   ; 3:10      dup -3 < while 187    positive HL < negative constant ---> false
    ld    A, L          ; 1:4       dup -3 < while 187    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 < while 187    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 < while 187    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 < while 187    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, break187   ; 3:10      dup -3 < while 187 
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit == string190
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break187       ; 3:10      break 187 
    jp   begin187       ; 3:10      again 187
break187:               ;           again 187
    
begin188:               ;           begin 188 
    ld    A, H          ; 1:4       dup -3 <= while 188
    add   A, A          ; 1:4       dup -3 <= while 188
    jp   nc, break188   ; 3:10      dup -3 <= while 188    positive HL <= negative constant ---> false
    ld    A, low -3     ; 2:7       dup -3 <= while 188    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 <= while 188    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 <= while 188    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 <= while 188    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, break188   ; 3:10      dup -3 <= while 188 
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string191
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break188       ; 3:10      break 188 
    jp   begin188       ; 3:10      again 188
break188:               ;           again 188
    
begin189:               ;           begin 189 
    ld    A, H          ; 1:4       dup -3 > while 189
    add   A, A          ; 1:4       dup -3 > while 189
    jr   nc, $+11       ; 2:7/12    dup -3 > while 189    positive HL > negative constant ---> true
    ld    A, low -3     ; 2:7       dup -3 > while 189    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 > while 189    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 > while 189    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 > while 189    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, break189   ; 3:10      dup -3 < while 189 
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string192
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break189       ; 3:10      break 189 
    jp   begin189       ; 3:10      again 189
break189:               ;           again 189
    
begin190:               ;           begin 190 
    ld    A, H          ; 1:4       dup -3 >= while 190
    add   A, A          ; 1:4       dup -3 >= while 190
    jr   nc, $+11       ; 2:7/11    dup -3 >= while 190    positive HL >= negative constant ---> true
    ld    A, L          ; 1:4       dup -3 >= while 190    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 >= while 190    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 >= while 190    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 >= while 190    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, break190   ; 3:10      dup -3 >= while 190 
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string193
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break190       ; 3:10      break 190 
    jp   begin190       ; 3:10      again 190
break190:               ;           again 190
    
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
    ; unsigned
    
begin191:               ;           begin 191 
    ld    A, low -3     ; 2:7       dup -3 u= while 191
    xor   L             ; 1:4       dup -3 u= while 191
    jp   nz, break191   ; 3:10      dup -3 u= while 191
    ld    A, high -3    ; 2:7       dup -3 u= while 191
    xor   H             ; 1:4       dup -3 u= while 191
    jp   nz, break191   ; 3:10      dup -3 u= while 191 
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit == string194
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break191       ; 3:10      break 191 
    jp   begin191       ; 3:10      again 191
break191:               ;           again 191
    
begin192:               ;           begin 192 
    ld    A, low -3     ; 2:7       dup -3 u<> while 192
    xor   L             ; 1:4       dup -3 u<> while 192
    jr   nz, $+8        ; 2:7/12    dup -3 u<> while 192
    ld    A, high -3    ; 2:7       dup -3 u<> while 192
    xor   H             ; 1:4       dup -3 u<> while 192
    jp    z, break192   ; 3:10      dup -3 u<> while 192 
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit == string195
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break192       ; 3:10      break 192 
    jp   begin192       ; 3:10      again 192
break192:               ;           again 192
    
begin193:               ;           begin 193 
    ld    A, L          ; 1:4       dup -3 u< while 193    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 u< while 193    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 u< while 193    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 u< while 193    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, break193   ; 3:10      dup -3 u< while 193 
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit == string196
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break193       ; 3:10      break 193 
    jp   begin193       ; 3:10      again 193
break193:               ;           again 193
    
begin194:               ;           begin 194 
    ld    A, low -3     ; 2:7       dup -3 u<= while 194    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 u<= while 194    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 u<= while 194    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 u<= while 194    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, break194   ; 3:10      dup -3 u<= while 194 
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string197
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break194       ; 3:10      break 194 
    jp   begin194       ; 3:10      again 194
break194:               ;           again 194
    
begin195:               ;           begin 195 
    ld    A, low -3     ; 2:7       dup -3 u> while 195    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 u> while 195    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 u> while 195    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 u> while 195    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, break195   ; 3:10      dup -3 u> while 195 
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string198
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break195       ; 3:10      break 195 
    jp   begin195       ; 3:10      again 195
break195:               ;           again 195
    
begin196:               ;           begin 196 
    ld    A, L          ; 1:4       dup -3 u>= while 196    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 u>= while 196    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 u>= while 196    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 u>= while 196    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, break196   ; 3:10      dup -3 u>= while 196 
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string199
    call PRINT_STRING_I ; 3:17      print_i 
    jp   break196       ; 3:10      break 196 
    jp   begin196       ; 3:10      again 196
break196:               ;           again 196
    
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
    
    ld   BC, string200  ; 3:10      print_i   Address of string200 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    
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
db 0xD, "Data stack OK!", 0xD + 0x80
size200 EQU $ - string200
string121:
db ">=",","+0x80
size121 EQU $ - string121
string119:
db ">","="+0x80
size119 EQU $ - string119
string118:
db ">",","+0x80
size118 EQU $ - string118
string116:
db ">" + 0x80
size116 EQU $ - string116
string115:
db "<=",","+0x80
size115 EQU $ - string115
string113:
db "<","="+0x80
size113 EQU $ - string113
string112:
db "<",","+0x80
size112 EQU $ - string112
string110:
db "<" + 0x80
size110 EQU $ - string110
string109:
db "<>",","+0x80
size109 EQU $ - string109
string107:
db "<",">"+0x80
size107 EQU $ - string107
string106:
db "=",","+0x80
size106 EQU $ - string106
string104:
db "=" + 0x80
size104 EQU $ - string104
string103:
db "RAS",":"+0x80
size103 EQU $ - string103
string102:
db "( d2 d1 -- ) and ( ud2 ud1 -- ):",0x0D + 0x80
size102 EQU $ - string102
string101:
db "( x2 x1 -- ) and ( u2 u1 -- ):",0x0D + 0x80
size101 EQU $ - string101

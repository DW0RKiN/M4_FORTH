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
    call test           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push2(5,5)
    ld   DE, 5          ; 3:10      push2(5,5)
    push HL             ; 1:11      push2(5,5)
    ld   HL, 5          ; 3:10      push2(5,5) 
    call test           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push2(-5,-5)
    ld   DE, -5         ; 3:10      push2(-5,-5)
    push HL             ; 1:11      push2(-5,-5)
    ld   HL, -5         ; 3:10      push2(-5,-5) 
    call test           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    push DE             ; 1:11      push2(-5,5)
    ld   DE, -5         ; 3:10      push2(-5,5)
    push HL             ; 1:11      push2(-5,5)
    ld   HL, 5          ; 3:10      push2(-5,5) 
    call test           ; 3:17      call
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
test:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
begin101:  
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101 
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break101       ; 3:10      break 101 
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
    
begin102:  
    ld    A, E          ; 1:4       2dup = while 102
    sub   L             ; 1:4       2dup = while 102
    jp   nz, break102   ; 3:10      2dup = while 102
    ld    A, D          ; 1:4       2dup = while 102
    sub   H             ; 1:4       2dup = while 102
    jp   nz, break102   ; 3:10      2dup = while 102 
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break102       ; 3:10      break 102 
    jp   begin102       ; 3:10      repeat 102
break102:               ;           repeat 102
    
begin103:  
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <> 
    ld    A, H          ; 1:4       while 103
    or    L             ; 1:4       while 103
    ex   DE, HL         ; 1:4       while 103
    pop  DE             ; 1:10      while 103
    jp    z, break103   ; 3:10      while 103 
    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break103       ; 3:10      break 103 
    jp   begin103       ; 3:10      repeat 103
break103:               ;           repeat 103
    
begin104:  
    ld    A, E          ; 1:4       2dup <> while 104
    sub   L             ; 1:4       2dup <> while 104
    jr   nz, $+7        ; 2:7/12    2dup <> while 104
    ld    A, D          ; 1:4       2dup <> while 104
    sub   H             ; 1:4       2dup <> while 104
    jp    z, break104   ; 3:10      2dup <> while 104 
    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break104       ; 3:10      break 104 
    jp   begin104       ; 3:10      repeat 104
break104:               ;           repeat 104
    
begin105:  
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
    ld    A, H          ; 1:4       while 105
    or    L             ; 1:4       while 105
    ex   DE, HL         ; 1:4       while 105
    pop  DE             ; 1:10      while 105
    jp    z, break105   ; 3:10      while 105 
    push DE             ; 1:11      print
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break105       ; 3:10      break 105 
    jp   begin105       ; 3:10      repeat 105
break105:               ;           repeat 105
    
begin106:  
    ld    A, H          ; 1:4       2dup < while 106
    xor   D             ; 1:4       2dup < while 106
    ld    C, A          ; 1:4       2dup < while 106
    ld    A, E          ; 1:4       2dup < while 106    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup < while 106    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup < while 106    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup < while 106    (DE<HL) --> (DE-HL<0) --> carry if true
    rra                 ; 1:4       2dup < while 106
    xor   C             ; 1:4       2dup < while 106
    jp    p, break106   ; 3:10      2dup < while 106 
    push DE             ; 1:11      print
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break106       ; 3:10      break 106 
    jp   begin106       ; 3:10      repeat 106
break106:               ;           repeat 106
    
begin107:  
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
    ld    A, H          ; 1:4       while 107
    or    L             ; 1:4       while 107
    ex   DE, HL         ; 1:4       while 107
    pop  DE             ; 1:10      while 107
    jp    z, break107   ; 3:10      while 107 
    push DE             ; 1:11      print
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break107       ; 3:10      break 107 
    jp   begin107       ; 3:10      repeat 107
break107:               ;           repeat 107
    
begin108:  
    ld    A, H          ; 1:4       2dup <= while 108
    xor   D             ; 1:4       2dup <= while 108
    ld    C, A          ; 1:4       2dup <= while 108
    ld    A, L          ; 1:4       2dup <= while 108    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sub   E             ; 1:4       2dup <= while 108    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    ld    A, H          ; 1:4       2dup <= while 108    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sbc   A, D          ; 1:4       2dup <= while 108    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    rra                 ; 1:4       2dup <= while 108
    xor   C             ; 1:4       2dup <= while 108
    jp    m, break108   ; 3:10      2dup <= while 108 
    push DE             ; 1:11      print
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break108       ; 3:10      break 108 
    jp   begin108       ; 3:10      repeat 108
break108:               ;           repeat 108
    
begin109:  
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
    ld    A, H          ; 1:4       while 109
    or    L             ; 1:4       while 109
    ex   DE, HL         ; 1:4       while 109
    pop  DE             ; 1:10      while 109
    jp    z, break109   ; 3:10      while 109 
    push DE             ; 1:11      print
    ld   BC, size110    ; 3:10      print Length of string to print
    ld   DE, string110  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break109       ; 3:10      break 109 
    jp   begin109       ; 3:10      repeat 109
break109:               ;           repeat 109
    
begin110:  
    ld    A, H          ; 1:4       2dup > while 110
    xor   D             ; 1:4       2dup > while 110
    ld    C, A          ; 1:4       2dup > while 110
    ld    A, L          ; 1:4       2dup > while 110    (DE>HL) --> (HL-DE<0) --> carry if true
    sub   E             ; 1:4       2dup > while 110    (DE>HL) --> (HL-DE<0) --> carry if true
    ld    A, H          ; 1:4       2dup > while 110    (DE>HL) --> (HL-DE<0) --> carry if true
    sbc   A, D          ; 1:4       2dup > while 110    (DE>HL) --> (HL-DE<0) --> carry if true
    rra                 ; 1:4       2dup > while 110
    xor   C             ; 1:4       2dup > while 110
    jp    p, break110   ; 3:10      2dup > while 110 
    push DE             ; 1:11      print
    ld   BC, size111    ; 3:10      print Length of string to print
    ld   DE, string111  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break110       ; 3:10      break 110 
    jp   begin110       ; 3:10      repeat 110
break110:               ;           repeat 110
    
begin111:  
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
    ld    A, H          ; 1:4       while 111
    or    L             ; 1:4       while 111
    ex   DE, HL         ; 1:4       while 111
    pop  DE             ; 1:10      while 111
    jp    z, break111   ; 3:10      while 111 
    push DE             ; 1:11      print
    ld   BC, size112    ; 3:10      print Length of string to print
    ld   DE, string112  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break111       ; 3:10      break 111 
    jp   begin111       ; 3:10      repeat 111
break111:               ;           repeat 111
    
begin112:  
    ld    A, H          ; 1:4       2dup >= while 112
    xor   D             ; 1:4       2dup >= while 112
    ld    C, A          ; 1:4       2dup >= while 112
    ld    A, E          ; 1:4       2dup >= while 112    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       2dup >= while 112    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       2dup >= while 112    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       2dup >= while 112    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    rra                 ; 1:4       2dup >= while 112
    xor   C             ; 1:4       2dup >= while 112
    jp    m, break112   ; 3:10      2dup >= while 112 
    push DE             ; 1:11      print
    ld   BC, size113    ; 3:10      print Length of string to print
    ld   DE, string113  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break112       ; 3:10      break 112 
    jp   begin112       ; 3:10      repeat 112
break112:               ;           repeat 112    
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_U16      ; 3:17      . 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
begin113: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ld    A, H          ; 1:4       while 113
    or    L             ; 1:4       while 113
    ex   DE, HL         ; 1:4       while 113
    pop  DE             ; 1:10      while 113
    jp    z, break113   ; 3:10      while 113 
    push DE             ; 1:11      print
    ld   BC, size114    ; 3:10      print Length of string to print
    ld   DE, string114  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break113       ; 3:10      break 113 
    jp   begin113       ; 3:10      repeat 113
break113:               ;           repeat 113
    
begin114: 
    ld    A, E          ; 1:4       2dup u= while 114
    sub   L             ; 1:4       2dup u= while 114
    jp   nz, break114   ; 3:10      2dup u= while 114
    ld    A, D          ; 1:4       2dup u= while 114
    sub   H             ; 1:4       2dup u= while 114
    jp   nz, break114   ; 3:10      2dup u= while 114 
    push DE             ; 1:11      print
    ld   BC, size115    ; 3:10      print Length of string to print
    ld   DE, string115  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break114       ; 3:10      break 114 
    jp   begin114       ; 3:10      repeat 114
break114:               ;           repeat 114
    
begin115: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       <>
    sbc  HL, DE         ; 2:15      <>
    jr    z, $+5        ; 2:7/12    <>
    ld   HL, 0xFFFF     ; 3:10      <>
    pop  DE             ; 1:10      <> 
    ld    A, H          ; 1:4       while 115
    or    L             ; 1:4       while 115
    ex   DE, HL         ; 1:4       while 115
    pop  DE             ; 1:10      while 115
    jp    z, break115   ; 3:10      while 115 
    push DE             ; 1:11      print
    ld   BC, size116    ; 3:10      print Length of string to print
    ld   DE, string116  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break115       ; 3:10      break 115 
    jp   begin115       ; 3:10      repeat 115
break115:               ;           repeat 115
    
begin116: 
    ld    A, E          ; 1:4       2dup u<> while 116
    sub   L             ; 1:4       2dup u<> while 116
    jr   nz, $+7        ; 2:7/12    2dup u<> while 116
    ld    A, D          ; 1:4       2dup u<> while 116
    sbc   A, H          ; 1:4       2dup u<> while 116
    jp    z, break116   ; 3:10      2dup u<> while 116 
    push DE             ; 1:11      print
    ld   BC, size117    ; 3:10      print Length of string to print
    ld   DE, string117  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break116       ; 3:10      break 116 
    jp   begin116       ; 3:10      repeat 116
break116:               ;           repeat 116
    
begin117: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       (u) <
    ex   DE, HL         ; 1:4       (u) <
    sbc  HL, DE         ; 2:15      (u) <
    sbc  HL, HL         ; 2:15      (u) <
    pop  DE             ; 1:10      (u) < 
    ld    A, H          ; 1:4       while 117
    or    L             ; 1:4       while 117
    ex   DE, HL         ; 1:4       while 117
    pop  DE             ; 1:10      while 117
    jp    z, break117   ; 3:10      while 117 
    push DE             ; 1:11      print
    ld   BC, size118    ; 3:10      print Length of string to print
    ld   DE, string118  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break117       ; 3:10      break 117 
    jp   begin117       ; 3:10      repeat 117
break117:               ;           repeat 117
    
begin118: 
    ld    A, E          ; 1:4       2dup u< while 118    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup u< while 118    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup u< while 118    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup u< while 118    (DE<HL) --> (DE-HL<0) --> carry if true
    jp   nc, break118   ; 3:10      2dup u< while 118 
    push DE             ; 1:11      print
    ld   BC, size119    ; 3:10      print Length of string to print
    ld   DE, string119  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break118       ; 3:10      break 118 
    jp   begin118       ; 3:10      repeat 118
break118:               ;           repeat 118
    
begin119: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    scf                 ; 1:4       (u) <=
    ex   DE, HL         ; 1:4       (u) <=
    sbc  HL, DE         ; 2:15      (u) <=
    sbc  HL, HL         ; 2:15      (u) <=
    pop  DE             ; 1:10      (u) <= 
    ld    A, H          ; 1:4       while 119
    or    L             ; 1:4       while 119
    ex   DE, HL         ; 1:4       while 119
    pop  DE             ; 1:10      while 119
    jp    z, break119   ; 3:10      while 119 
    push DE             ; 1:11      print
    ld   BC, size120    ; 3:10      print Length of string to print
    ld   DE, string120  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break119       ; 3:10      break 119 
    jp   begin119       ; 3:10      repeat 119
break119:               ;           repeat 119
    
begin120: 
    ld    A, L          ; 1:4       2dup u<= while 120    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sub   E             ; 1:4       2dup u<= while 120    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    ld    A, H          ; 1:4       2dup u<= while 120    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= while 120    (DE<=HL) --> (0<=HL-DE) --> not carry if true
    jp    c, break120   ; 3:10      2dup u<= while 120 
    push DE             ; 1:11      print
    ld   BC, size121    ; 3:10      print Length of string to print
    ld   DE, string121  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break120       ; 3:10      break 120 
    jp   begin120       ; 3:10      repeat 120
break120:               ;           repeat 120
    
begin121: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       (u) >
    sbc  HL, DE         ; 2:15      (u) >
    sbc  HL, HL         ; 2:15      (u) >
    pop  DE             ; 1:10      (u) > 
    ld    A, H          ; 1:4       while 121
    or    L             ; 1:4       while 121
    ex   DE, HL         ; 1:4       while 121
    pop  DE             ; 1:10      while 121
    jp    z, break121   ; 3:10      while 121 
    push DE             ; 1:11      print
    ld   BC, size122    ; 3:10      print Length of string to print
    ld   DE, string122  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break121       ; 3:10      break 121 
    jp   begin121       ; 3:10      repeat 121
break121:               ;           repeat 121
    
begin122: 
    ld    A, L          ; 1:4       2dup u> while 122    (DE>HL) --> (0>HL-DE) --> carry if true
    sub   E             ; 1:4       2dup u> while 122    (DE>HL) --> (0>HL-DE) --> carry if true
    ld    A, H          ; 1:4       2dup u> while 122    (DE>HL) --> (0>HL-DE) --> carry if true
    sbc   A, D          ; 1:4       2dup u> while 122    (DE>HL) --> (0>HL-DE) --> carry if true
    jp   nc, break122   ; 3:10      2dup u> while 122 
    push DE             ; 1:11      print
    ld   BC, size123    ; 3:10      print Length of string to print
    ld   DE, string123  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break122       ; 3:10      break 122 
    jp   begin122       ; 3:10      repeat 122
break122:               ;           repeat 122
    
begin123: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    scf                 ; 1:4       (u) >=
    sbc  HL, DE         ; 2:15      (u) >=
    sbc  HL, HL         ; 2:15      (u) >=
    pop  DE             ; 1:10      (u) >= 
    ld    A, H          ; 1:4       while 123
    or    L             ; 1:4       while 123
    ex   DE, HL         ; 1:4       while 123
    pop  DE             ; 1:10      while 123
    jp    z, break123   ; 3:10      while 123 
    push DE             ; 1:11      print
    ld   BC, size124    ; 3:10      print Length of string to print
    ld   DE, string124  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break123       ; 3:10      break 123 
    jp   begin123       ; 3:10      repeat 123
break123:               ;           repeat 123
    
begin124: 
    ld    A, E          ; 1:4       2dup u>= while 124    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sub   L             ; 1:4       2dup u>= while 124    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    ld    A, D          ; 1:4       2dup u>= while 124    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= while 124    (DE>=HL) --> (DE-HL>=0) --> not carry if true
    jp    c, break124   ; 3:10      2dup u>= while 124 
    push DE             ; 1:11      print
    ld   BC, size125    ; 3:10      print Length of string to print
    ld   DE, string125  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    jp   break124       ; 3:10      break 124 
    jp   begin124       ; 3:10      repeat 124
break124:               ;           repeat 124    
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )

test_end:
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
    ld   BC, size126    ; 3:10      print Length of string to print
    ld   DE, string126  ; 3:10      print Address of string
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
string126:
db 0xD, "Data stack OK!", 0xD
size126 EQU $ - string126
string125:
db ">=,"
size125 EQU $ - string125
string124:
db ">=,"
size124 EQU $ - string124
string123:
db ">,"
size123 EQU $ - string123
string122:
db ">,"
size122 EQU $ - string122
string121:
db "<=,"
size121 EQU $ - string121
string120:
db "<=,"
size120 EQU $ - string120
string119:
db "<,"
size119 EQU $ - string119
string118:
db "<,"
size118 EQU $ - string118
string117:
db "<>,"
size117 EQU $ - string117
string116:
db "<>,"
size116 EQU $ - string116
string115:
db "=,"
size115 EQU $ - string115
string114:
db "=,"
size114 EQU $ - string114
string113:
db ">=,"
size113 EQU $ - string113
string112:
db ">=,"
size112 EQU $ - string112
string111:
db ">,"
size111 EQU $ - string111
string110:
db ">,"
size110 EQU $ - string110
string109:
db "<=,"
size109 EQU $ - string109
string108:
db "<=,"
size108 EQU $ - string108
string107:
db "<,"
size107 EQU $ - string107
string106:
db "<,"
size106 EQU $ - string106
string105:
db "<>,"
size105 EQU $ - string105
string104:
db "<>,"
size104 EQU $ - string104
string103:
db "=,"
size103 EQU $ - string103
string102:
db "=,"
size102 EQU $ - string102
string101:
db "RAS:"
size101 EQU $ - string101



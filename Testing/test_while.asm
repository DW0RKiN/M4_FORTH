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

    
    push DE             ; 1:11      push2(5,-5)
    ld   DE, 5          ; 3:10      push2(5,-5)
    push HL             ; 1:11      push2(5,-5)
    ld   HL, -5         ; 3:10      push2(5,-5) 
    call dtest          ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push2(5,5)
    ld   DE, 5          ; 3:10      push2(5,5)
    push HL             ; 1:11      push2(5,5)
    ld   HL, 5          ; 3:10      push2(5,5) 
    call dtest          ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push2(-5,-5)
    ld   DE, -5         ; 3:10      push2(-5,-5)
    push HL             ; 1:11      push2(-5,-5)
    ld   HL, -5         ; 3:10      push2(-5,-5) 
    call dtest          ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push2(-5,5)
    ld   DE, -5         ; 3:10      push2(-5,5)
    push HL             ; 1:11      push2(-5,5)
    ld   HL, 5          ; 3:10      push2(-5,5) 
    call dtest          ; 3:17      call ( -- ret ) R:( -- )

    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call ptestp3        ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call ptestp3        ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call ptestm3        ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call ptestm3        ; 3:17      call ( -- ret ) R:( -- )

    
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z
    exx
    push HL
    exx
    pop HL
    
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    ret
    

;   ---  the beginning of a non-recursive function  ---
dtest:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (dtest_end+1),BC; 4:20      : ( ret -- ) R:( -- )
     
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
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break101       ; 3:10      break 101 
    jp   begin101       ; 3:10      again 101
break101:               ;           again 101
     
begin102: 
    ld    A, E          ; 1:4       2dup = while 102
    sub   L             ; 1:4       2dup = while 102
    jp   nz, break102   ; 3:10      2dup = while 102
    ld    A, D          ; 1:4       2dup = while 102
    sub   H             ; 1:4       2dup = while 102
    jp   nz, break102   ; 3:10      2dup = while 102 
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102 == string103
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break102       ; 3:10      break 102 
    jp   begin102       ; 3:10      again 102
break102:               ;           again 102
     
begin103: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       = while 103
    sbc  HL, DE         ; 2:15      = while 103
    pop  HL             ; 1:10      = while 103
    pop  DE             ; 1:10      = while 103
    jp   nz, break103   ; 3:10      = while 103 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break103       ; 3:10      break 103 
    jp   begin103       ; 3:10      again 103
break103:               ;           again 103
     
begin104: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break104       ; 3:10      break 104 
    jp   begin104       ; 3:10      again 104
break104:               ;           again 104
     
begin105: 
    ld    A, E          ; 1:4       2dup <> while 105
    sub   L             ; 1:4       2dup <> while 105
    jr   nz, $+7        ; 2:7/12    2dup <> while 105
    ld    A, D          ; 1:4       2dup <> while 105
    sub   H             ; 1:4       2dup <> while 105
    jp    z, break105   ; 3:10      2dup <> while 105 
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105 == string106
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break105       ; 3:10      break 105 
    jp   begin105       ; 3:10      again 105
break105:               ;           again 105
     
begin106: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       <> while 106
    sbc  HL, DE         ; 2:15      <> while 106
    pop  HL             ; 1:10      <> while 106
    pop  DE             ; 1:10      <> while 106
    jp    z, break106   ; 3:10      <> while 106 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break106       ; 3:10      break 106 
    jp   begin106       ; 3:10      again 106
break106:               ;           again 106
     
begin107: 
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
    ld    A, H          ; 1:4       while 107
    or    L             ; 1:4       while 107
    ex   DE, HL         ; 1:4       while 107
    pop  DE             ; 1:10      while 107
    jp    z, break107   ; 3:10      while 107 
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break107       ; 3:10      break 107 
    jp   begin107       ; 3:10      again 107
break107:               ;           again 107
     
begin108: 
    ld    A, E          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < while 108
    xor   D             ; 1:4       2dup < while 108
    xor   H             ; 1:4       2dup < while 108
    jp    p, break108   ; 3:10      2dup < while 108 
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108 == string109
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break108       ; 3:10      break 108 
    jp   begin108       ; 3:10      again 108
break108:               ;           again 108
     
begin109: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break109       ; 3:10      break 109 
    jp   begin109       ; 3:10      again 109
break109:               ;           again 109
     
begin110: 
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
    ld    A, H          ; 1:4       while 110
    or    L             ; 1:4       while 110
    ex   DE, HL         ; 1:4       while 110
    pop  DE             ; 1:10      while 110
    jp    z, break110   ; 3:10      while 110 
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break110       ; 3:10      break 110 
    jp   begin110       ; 3:10      again 110
break110:               ;           again 110
     
begin111: 
    ld    A, L          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= while 111
    xor   D             ; 1:4       2dup <= while 111
    xor   H             ; 1:4       2dup <= while 111
    jp    m, break111   ; 3:10      2dup <= while 111 
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111 == string112
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break111       ; 3:10      break 111 
    jp   begin111       ; 3:10      again 111
break111:               ;           again 111
     
begin112: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break112       ; 3:10      break 112 
    jp   begin112       ; 3:10      again 112
break112:               ;           again 112
     
begin113: 
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
    ld    A, H          ; 1:4       while 113
    or    L             ; 1:4       while 113
    ex   DE, HL         ; 1:4       while 113
    pop  DE             ; 1:10      while 113
    jp    z, break113   ; 3:10      while 113 
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break113       ; 3:10      break 113 
    jp   begin113       ; 3:10      again 113
break113:               ;           again 113
     
begin114: 
    ld    A, L          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> carry if true
    sub   E             ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> carry if true
    ld    A, H          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> carry if true
    sbc   A, D          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> carry if true
    rra                 ; 1:4       2dup > while 114
    xor   D             ; 1:4       2dup > while 114
    xor   H             ; 1:4       2dup > while 114
    jp    p, break114   ; 3:10      2dup > while 114 
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114 == string115
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break114       ; 3:10      break 114 
    jp   begin114       ; 3:10      again 114
break114:               ;           again 114
     
begin115: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break115       ; 3:10      break 115 
    jp   begin115       ; 3:10      again 115
break115:               ;           again 115
     
begin116: 
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
    ld    A, H          ; 1:4       while 116
    or    L             ; 1:4       while 116
    ex   DE, HL         ; 1:4       while 116
    pop  DE             ; 1:10      while 116
    jp    z, break116   ; 3:10      while 116 
    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break116       ; 3:10      break 116 
    jp   begin116       ; 3:10      again 116
break116:               ;           again 116
     
begin117: 
    ld    A, E          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> not carry if true
    rra                 ; 1:4       2dup >= while 117
    xor   D             ; 1:4       2dup >= while 117
    xor   H             ; 1:4       2dup >= while 117
    jp    m, break117   ; 3:10      2dup >= while 117 
    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117 == string118
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break117       ; 3:10      break 117 
    jp   begin117       ; 3:10      again 117
break117:               ;           again 117
     
begin118: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119
    call PRINT_STRING_Z ; 3:17      print_z 
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
    
begin119: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ld    A, H          ; 1:4       while 119
    or    L             ; 1:4       while 119
    ex   DE, HL         ; 1:4       while 119
    pop  DE             ; 1:10      while 119
    jp    z, break119   ; 3:10      while 119 
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102 == string120
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break119       ; 3:10      break 119 
    jp   begin119       ; 3:10      again 119
break119:               ;           again 119
    
begin120: 
    ld    A, E          ; 1:4       2dup u= while 120
    sub   L             ; 1:4       2dup u= while 120
    jp   nz, break120   ; 3:10      2dup u= while 120
    ld    A, D          ; 1:4       2dup u= while 120
    sub   H             ; 1:4       2dup u= while 120
    jp   nz, break120   ; 3:10      2dup u= while 120 
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102 == string121
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break120       ; 3:10      break 120 
    jp   begin120       ; 3:10      again 120
break120:               ;           again 120
    
begin121: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       u= while 121
    sbc  HL, DE         ; 2:15      u= while 121
    pop  HL             ; 1:10      u= while 121
    pop  DE             ; 1:10      u= while 121
    jp   nz, break121   ; 3:10      u= while 121 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string122
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break121       ; 3:10      break 121 
    jp   begin121       ; 3:10      again 121
break121:               ;           again 121
    
begin122: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105 == string123
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break122       ; 3:10      break 122 
    jp   begin122       ; 3:10      again 122
break122:               ;           again 122
    
begin123: 
    ld    A, E          ; 1:4       2dup u<> while 123
    sub   L             ; 1:4       2dup u<> while 123
    jr   nz, $+7        ; 2:7/12    2dup u<> while 123
    ld    A, D          ; 1:4       2dup u<> while 123
    sbc   A, H          ; 1:4       2dup u<> while 123
    jp    z, break123   ; 3:10      2dup u<> while 123 
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105 == string124
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break123       ; 3:10      break 123 
    jp   begin123       ; 3:10      again 123
break123:               ;           again 123
    
begin124: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       u<> while 124
    sbc  HL, DE         ; 2:15      u<> while 124
    pop  HL             ; 1:10      u<> while 124
    pop  DE             ; 1:10      u<> while 124
    jp    z, break124   ; 3:10      u<> while 124 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string125
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break124       ; 3:10      break 124 
    jp   begin124       ; 3:10      again 124
break124:               ;           again 124
    
begin125: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       (u) <
    ex   DE, HL         ; 1:4       (u) <
    sbc  HL, DE         ; 2:15      (u) <
    sbc  HL, HL         ; 2:15      (u) <
    pop  DE             ; 1:10      (u) < 
    ld    A, H          ; 1:4       while 125
    or    L             ; 1:4       while 125
    ex   DE, HL         ; 1:4       while 125
    pop  DE             ; 1:10      while 125
    jp    z, break125   ; 3:10      while 125 
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108 == string126
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break125       ; 3:10      break 125 
    jp   begin125       ; 3:10      again 125
break125:               ;           again 125
    
begin126: 
    ld    A, E          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, break126   ; 3:10      2dup u< while 126 
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108 == string127
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break126       ; 3:10      break 126 
    jp   begin126       ; 3:10      again 126
break126:               ;           again 126
    
begin127: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, E          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< while 127
    pop  DE             ; 1:10      u< while 127
    jp   nc, break127   ; 3:10      u< while 127 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string128
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break127       ; 3:10      break 127 
    jp   begin127       ; 3:10      again 127
break127:               ;           again 127
    
begin128: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    scf                 ; 1:4       (u) <=
    ex   DE, HL         ; 1:4       (u) <=
    sbc  HL, DE         ; 2:15      (u) <=
    sbc  HL, HL         ; 2:15      (u) <=
    pop  DE             ; 1:10      (u) <= 
    ld    A, H          ; 1:4       while 128
    or    L             ; 1:4       while 128
    ex   DE, HL         ; 1:4       while 128
    pop  DE             ; 1:10      while 128
    jp    z, break128   ; 3:10      while 128 
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111 == string129
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break128       ; 3:10      break 128 
    jp   begin128       ; 3:10      again 128
break128:               ;           again 128
    
begin129: 
    ld    A, L          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, break129   ; 3:10      2dup u<= while 129 
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111 == string130
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break129       ; 3:10      break 129 
    jp   begin129       ; 3:10      again 129
break129:               ;           again 129
    
begin130: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, L          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= while 130
    pop  DE             ; 1:10      u<= while 130
    jp    c, break130   ; 3:10      u<= while 130 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string131
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break130       ; 3:10      break 130 
    jp   begin130       ; 3:10      again 130
break130:               ;           again 130
    
begin131: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       (u) >
    sbc  HL, DE         ; 2:15      (u) >
    sbc  HL, HL         ; 2:15      (u) >
    pop  DE             ; 1:10      (u) > 
    ld    A, H          ; 1:4       while 131
    or    L             ; 1:4       while 131
    ex   DE, HL         ; 1:4       while 131
    pop  DE             ; 1:10      while 131
    jp    z, break131   ; 3:10      while 131 
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114 == string132
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break131       ; 3:10      break 131 
    jp   begin131       ; 3:10      again 131
break131:               ;           again 131
    
begin132: 
    ld    A, L          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, break132   ; 3:10      2dup u> while 132 
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114 == string133
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break132       ; 3:10      break 132 
    jp   begin132       ; 3:10      again 132
break132:               ;           again 132
    
begin133: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, L          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> while 133
    pop  DE             ; 1:10      u> while 133
    jp   nc, break133   ; 3:10      u> while 133 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string134
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break133       ; 3:10      break 133 
    jp   begin133       ; 3:10      again 133
break133:               ;           again 133
    
begin134: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    scf                 ; 1:4       (u) >=
    sbc  HL, DE         ; 2:15      (u) >=
    sbc  HL, HL         ; 2:15      (u) >=
    pop  DE             ; 1:10      (u) >= 
    ld    A, H          ; 1:4       while 134
    or    L             ; 1:4       while 134
    ex   DE, HL         ; 1:4       while 134
    pop  DE             ; 1:10      while 134
    jp    z, break134   ; 3:10      while 134 
    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117 == string135
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break134       ; 3:10      break 134 
    jp   begin134       ; 3:10      again 134
break134:               ;           again 134
    
begin135: 
    ld    A, E          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, break135   ; 3:10      2dup u>= while 135 
    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117 == string136
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break135       ; 3:10      break 135 
    jp   begin135       ; 3:10      again 135
break135:               ;           again 135
    
begin136: 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, E          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= while 136
    pop  DE             ; 1:10      u>= while 136
    jp    c, break136   ; 3:10      u>= while 136 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string137
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break136       ; 3:10      break 136 
    jp   begin136       ; 3:10      again 136
break136:               ;           again 136
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    call PRINT_U16      ; 3:17      . 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

dtest_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
ptestp3:                ;           
    pop  BC             ; 1:10      : ret
    ld  (ptestp3_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
begin137: 
    ld    A, low 3      ; 2:7       dup 3 = while 137
    xor   L             ; 1:4       dup 3 = while 137
    jp   nz, break137   ; 3:10      dup 3 = while 137
    ld    A, high 3     ; 2:7       dup 3 = while 137
    xor   H             ; 1:4       dup 3 = while 137
    jp   nz, break137   ; 3:10      dup 3 = while 137 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string138
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break137       ; 3:10      break 137 
    jp   begin137       ; 3:10      again 137
break137:               ;           again 137
    
begin138: 
    ld    A, low 3      ; 2:7       dup 3 <> while 138
    xor   L             ; 1:4       dup 3 <> while 138
    jr   nz, $+8        ; 2:7/12    dup 3 <> while 138
    ld    A, high 3     ; 2:7       dup 3 <> while 138
    xor   H             ; 1:4       dup 3 <> while 138
    jp    z, break138   ; 3:10      dup 3 <> while 138 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string139
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break138       ; 3:10      break 138 
    jp   begin138       ; 3:10      again 138
break138:               ;           again 138
    
begin139: 
    ld    A, H          ; 1:4       dup 3 < while 139
    add   A, A          ; 1:4       dup 3 < while 139
    jr    c, $+11       ; 2:7/12    dup 3 < while 139    negative HL < positive constant ---> true
    ld    A, L          ; 1:4       dup 3 < while 139    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 < while 139    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 < while 139    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 < while 139    HL<3 --> HL-3<0 --> carry if true
    jp   nc, break139   ; 3:10      dup 3 < while 139 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string140
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break139       ; 3:10      break 139 
    jp   begin139       ; 3:10      again 139
break139:               ;           again 139
    
begin140: 
    ld    A, H          ; 1:4       dup 3 <= while 140
    add   A, A          ; 1:4       dup 3 <= while 140
    jr    c, $+11       ; 2:7/12    dup 3 <= while 140    negative HL <= positive constant ---> true
    ld    A, low 3      ; 2:7       dup 3 <= while 140    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 <= while 140    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 <= while 140    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 <= while 140    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, break140   ; 3:10      dup 3 <= while 140 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string141
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break140       ; 3:10      break 140 
    jp   begin140       ; 3:10      again 140
break140:               ;           again 140
    
begin141: 
    ld    A, H          ; 1:4       dup 3 > while 141
    add   A, A          ; 1:4       dup 3 > while 141
    jp    c, break141   ; 3:10      dup 3 > while 141    negative HL > positive constant ---> false
    ld    A, low 3      ; 2:7       dup 3 > while 141    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 > while 141    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 > while 141    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 > while 141    HL>3 --> 0>3-HL --> carry if true
    jp   nc, break141   ; 3:10      dup 3 < while 141 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string142
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break141       ; 3:10      break 141 
    jp   begin141       ; 3:10      again 141
break141:               ;           again 141
    
begin142: 
    ld    A, H          ; 1:4       dup 3 >= while 142
    add   A, A          ; 1:4       dup 3 >= while 142
    jp    c, break142   ; 3:10      dup 3 >= while 142    negative HL >= positive constant ---> false
    ld    A, L          ; 1:4       dup 3 >= while 142    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 >= while 142    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 >= while 142    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 >= while 142    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, break142   ; 3:10      dup 3 >= while 142 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string143
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break142       ; 3:10      break 142 
    jp   begin142       ; 3:10      again 142
break142:               ;           again 142
    
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
    
begin143: 
    ld    A, low 3      ; 2:7       dup 3 u= while 143
    xor   L             ; 1:4       dup 3 u= while 143
    jp   nz, break143   ; 3:10      dup 3 u= while 143
    ld    A, high 3     ; 2:7       dup 3 u= while 143
    xor   H             ; 1:4       dup 3 u= while 143
    jp   nz, break143   ; 3:10      dup 3 u= while 143 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string144
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break143       ; 3:10      break 143 
    jp   begin143       ; 3:10      again 143
break143:               ;           again 143
    
begin144: 
    ld    A, low 3      ; 2:7       dup 3 u<> while 144
    xor   L             ; 1:4       dup 3 u<> while 144
    jr   nz, $+8        ; 2:7/12    dup 3 u<> while 144
    ld    A, high 3     ; 2:7       dup 3 u<> while 144
    xor   H             ; 1:4       dup 3 u<> while 144
    jp    z, break144   ; 3:10      dup 3 u<> while 144 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string145
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break144       ; 3:10      break 144 
    jp   begin144       ; 3:10      again 144
break144:               ;           again 144
    
begin145: 
    ld    A, L          ; 1:4       dup 3 u< while 145    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 u< while 145    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 u< while 145    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 u< while 145    HL<3 --> HL-3<0 --> carry if true
    jp   nc, break145   ; 3:10      dup 3 u< while 145 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string146
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break145       ; 3:10      break 145 
    jp   begin145       ; 3:10      again 145
break145:               ;           again 145
    
begin146: 
    ld    A, low 3      ; 2:7       dup 3 u<= while 146    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 u<= while 146    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 u<= while 146    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 u<= while 146    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, break146   ; 3:10      dup 3 u<= while 146 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string147
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break146       ; 3:10      break 146 
    jp   begin146       ; 3:10      again 146
break146:               ;           again 146
    
begin147: 
    ld    A, low 3      ; 2:7       dup 3 u> while 147    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 u> while 147    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 u> while 147    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 u> while 147    HL>3 --> 0>3-HL --> carry if true
    jp   nc, break147   ; 3:10      dup 3 u> while 147 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string148
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break147       ; 3:10      break 147 
    jp   begin147       ; 3:10      again 147
break147:               ;           again 147
    
begin148: 
    ld    A, L          ; 1:4       dup 3 u>= while 148    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 u>= while 148    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 u>= while 148    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 u>= while 148    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, break148   ; 3:10      dup 3 u>= while 148 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string149
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break148       ; 3:10      break 148 
    jp   begin148       ; 3:10      again 148
break148:               ;           again 148
    
    call PRINT_U16      ; 3:17      . 
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

ptestp3_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



;   ---  the beginning of a non-recursive function  ---
ptestm3:                ;           
    pop  BC             ; 1:10      : ret
    ld  (ptestm3_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
begin149: 
    ld    A, low -3     ; 2:7       dup -3 = while 149
    xor   L             ; 1:4       dup -3 = while 149
    jp   nz, break149   ; 3:10      dup -3 = while 149
    ld    A, high -3    ; 2:7       dup -3 = while 149
    xor   H             ; 1:4       dup -3 = while 149
    jp   nz, break149   ; 3:10      dup -3 = while 149 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string150
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break149       ; 3:10      break 149 
    jp   begin149       ; 3:10      again 149
break149:               ;           again 149
    
begin150: 
    ld    A, low -3     ; 2:7       dup -3 <> while 150
    xor   L             ; 1:4       dup -3 <> while 150
    jr   nz, $+8        ; 2:7/12    dup -3 <> while 150
    ld    A, high -3    ; 2:7       dup -3 <> while 150
    xor   H             ; 1:4       dup -3 <> while 150
    jp    z, break150   ; 3:10      dup -3 <> while 150 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string151
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break150       ; 3:10      break 150 
    jp   begin150       ; 3:10      again 150
break150:               ;           again 150
    
begin151: 
    ld    A, H          ; 1:4       dup -3 < while 151
    add   A, A          ; 1:4       dup -3 < while 151
    jp   nc, break151   ; 3:10      dup -3 < while 151    positive HL < negative constant ---> false
    ld    A, L          ; 1:4       dup -3 < while 151    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 < while 151    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 < while 151    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 < while 151    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, break151   ; 3:10      dup -3 < while 151 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string152
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break151       ; 3:10      break 151 
    jp   begin151       ; 3:10      again 151
break151:               ;           again 151
    
begin152: 
    ld    A, H          ; 1:4       dup -3 <= while 152
    add   A, A          ; 1:4       dup -3 <= while 152
    jp   nc, break152   ; 3:10      dup -3 <= while 152    positive HL <= negative constant ---> false
    ld    A, low -3     ; 2:7       dup -3 <= while 152    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 <= while 152    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 <= while 152    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 <= while 152    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, break152   ; 3:10      dup -3 <= while 152 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string153
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break152       ; 3:10      break 152 
    jp   begin152       ; 3:10      again 152
break152:               ;           again 152
    
begin153: 
    ld    A, H          ; 1:4       dup -3 > while 153
    add   A, A          ; 1:4       dup -3 > while 153
    jr   nc, $+11       ; 2:7/12    dup -3 > while 153    positive HL > negative constant ---> true
    ld    A, low -3     ; 2:7       dup -3 > while 153    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 > while 153    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 > while 153    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 > while 153    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, break153   ; 3:10      dup -3 < while 153 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string154
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break153       ; 3:10      break 153 
    jp   begin153       ; 3:10      again 153
break153:               ;           again 153
    
begin154: 
    ld    A, H          ; 1:4       dup -3 >= while 154
    add   A, A          ; 1:4       dup -3 >= while 154
    jr   nc, $+11       ; 2:7/11    dup -3 >= while 154    positive HL >= negative constant ---> true
    ld    A, L          ; 1:4       dup -3 >= while 154    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 >= while 154    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 >= while 154    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 >= while 154    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, break154   ; 3:10      dup -3 >= while 154 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string155
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break154       ; 3:10      break 154 
    jp   begin154       ; 3:10      again 154
break154:               ;           again 154
    
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
    
begin155: 
    ld    A, low -3     ; 2:7       dup -3 u= while 155
    xor   L             ; 1:4       dup -3 u= while 155
    jp   nz, break155   ; 3:10      dup -3 u= while 155
    ld    A, high -3    ; 2:7       dup -3 u= while 155
    xor   H             ; 1:4       dup -3 u= while 155
    jp   nz, break155   ; 3:10      dup -3 u= while 155 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string156
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break155       ; 3:10      break 155 
    jp   begin155       ; 3:10      again 155
break155:               ;           again 155
    
begin156: 
    ld    A, low -3     ; 2:7       dup -3 u<> while 156
    xor   L             ; 1:4       dup -3 u<> while 156
    jr   nz, $+8        ; 2:7/12    dup -3 u<> while 156
    ld    A, high -3    ; 2:7       dup -3 u<> while 156
    xor   H             ; 1:4       dup -3 u<> while 156
    jp    z, break156   ; 3:10      dup -3 u<> while 156 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string157
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break156       ; 3:10      break 156 
    jp   begin156       ; 3:10      again 156
break156:               ;           again 156
    
begin157: 
    ld    A, L          ; 1:4       dup -3 u< while 157    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 u< while 157    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 u< while 157    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 u< while 157    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, break157   ; 3:10      dup -3 u< while 157 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string158
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break157       ; 3:10      break 157 
    jp   begin157       ; 3:10      again 157
break157:               ;           again 157
    
begin158: 
    ld    A, low -3     ; 2:7       dup -3 u<= while 158    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 u<= while 158    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 u<= while 158    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 u<= while 158    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, break158   ; 3:10      dup -3 u<= while 158 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string159
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break158       ; 3:10      break 158 
    jp   begin158       ; 3:10      again 158
break158:               ;           again 158
    
begin159: 
    ld    A, low -3     ; 2:7       dup -3 u> while 159    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 u> while 159    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 u> while 159    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 u> while 159    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, break159   ; 3:10      dup -3 u> while 159 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string160
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break159       ; 3:10      break 159 
    jp   begin159       ; 3:10      again 159
break159:               ;           again 159
    
begin160: 
    ld    A, L          ; 1:4       dup -3 u>= while 160    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 u>= while 160    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 u>= while 160    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 u>= while 160    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, break160   ; 3:10      dup -3 u>= while 160 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string161
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   break160       ; 3:10      break 160 
    jp   begin160       ; 3:10      again 160
break160:               ;           again 160
    
    call PRINT_U16      ; 3:17      . 
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

ptestm3_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



;   ---  the beginning of a data stack function  ---
stack_test:             ;           
    
    ld   BC, string162  ; 3:10      print_z   Address of null-terminated string162
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
    ret                 ; 1:10; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst   0x10          ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z

STRING_SECTION:
string162:
db 0xD, "Data stack OK!", 0xD, 0x00
size162 EQU $ - string162
string119:
db ">=,", 0x00
size119 EQU $ - string119
string117:
db ">=" , 0x00
size117 EQU $ - string117
string116:
db ">,", 0x00
size116 EQU $ - string116
string114:
db ">" , 0x00
size114 EQU $ - string114
string113:
db "<=,", 0x00
size113 EQU $ - string113
string111:
db "<=" , 0x00
size111 EQU $ - string111
string110:
db "<,", 0x00
size110 EQU $ - string110
string108:
db "<" , 0x00
size108 EQU $ - string108
string107:
db "<>,", 0x00
size107 EQU $ - string107
string105:
db "<>" , 0x00
size105 EQU $ - string105
string104:
db "=,", 0x00
size104 EQU $ - string104
string102:
db "=" , 0x00
size102 EQU $ - string102
string101:
db "RAS:", 0x00
size101 EQU $ - string101

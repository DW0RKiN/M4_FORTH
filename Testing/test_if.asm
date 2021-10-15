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
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
    call PRINT_STRING_Z ; 3:17      print_z 
else101  EQU $          ;           = endif
endif101:
     
    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if 
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102 == string103
    call PRINT_STRING_Z ; 3:17      print_z 
else102  EQU $          ;           = endif
endif102:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       = if
    sbc  HL, DE         ; 2:15      = if
    pop  HL             ; 1:10      = if
    pop  DE             ; 1:10      = if
    jp   nz, else103    ; 3:10      = if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105
    call PRINT_STRING_Z ; 3:17      print_z 
else104  EQU $          ;           = endif
endif104:
     
    ld    A, E          ; 1:4       2dup <> if
    sub   L             ; 1:4       2dup <> if
    jr   nz, $+7        ; 2:7/12    2dup <> if
    ld    A, D          ; 1:4       2dup <> if
    sub   H             ; 1:4       2dup <> if
    jp    z, else105    ; 3:10      2dup <> if 
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105 == string106
    call PRINT_STRING_Z ; 3:17      print_z 
else105  EQU $          ;           = endif
endif105:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       <> if
    sbc  HL, DE         ; 2:15      <> if
    pop  HL             ; 1:10      <> if
    pop  DE             ; 1:10      <> if
    jp    z, else106    ; 3:10      <> if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108
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
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108 == string109
    call PRINT_STRING_Z ; 3:17      print_z 
else108  EQU $          ;           = endif
endif108:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111
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
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111 == string112
    call PRINT_STRING_Z ; 3:17      print_z 
else111  EQU $          ;           = endif
endif111:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114
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
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114 == string115
    call PRINT_STRING_Z ; 3:17      print_z 
else114  EQU $          ;           = endif
endif114:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117
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
    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117 == string118
    call PRINT_STRING_Z ; 3:17      print_z 
else117  EQU $          ;           = endif
endif117:
     
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
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
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119
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
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102 == string120
    call PRINT_STRING_Z ; 3:17      print_z 
else119  EQU $          ;           = endif
endif119:
    
    ld    A, E          ; 1:4       2dup u= if
    sub   L             ; 1:4       2dup u= if
    jp   nz, else120    ; 3:10      2dup u= if
    ld    A, D          ; 1:4       2dup u= if
    sub   H             ; 1:4       2dup u= if
    jp   nz, else120    ; 3:10      2dup u= if 
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102 == string121
    call PRINT_STRING_Z ; 3:17      print_z 
else120  EQU $          ;           = endif
endif120:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       u= if
    sbc  HL, DE         ; 2:15      u= if
    pop  HL             ; 1:10      u= if
    pop  DE             ; 1:10      u= if
    jp   nz, else121    ; 3:10      u= if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string122
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105 == string123
    call PRINT_STRING_Z ; 3:17      print_z 
else122  EQU $          ;           = endif
endif122:
    
    ld    A, E          ; 1:4       2dup u<> if
    sub   L             ; 1:4       2dup u<> if
    jr   nz, $+7        ; 2:7/12    2dup u<> if
    ld    A, D          ; 1:4       2dup u<> if
    sbc   A, H          ; 1:4       2dup u<> if
    jp    z, else123    ; 3:10      2dup u<> if 
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105 == string124
    call PRINT_STRING_Z ; 3:17      print_z 
else123  EQU $          ;           = endif
endif123:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    or    A             ; 1:4       u<> if
    sbc  HL, DE         ; 2:15      u<> if
    pop  HL             ; 1:10      u<> if
    pop  DE             ; 1:10      u<> if
    jp    z, else124    ; 3:10      u<> if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string125
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108 == string126
    call PRINT_STRING_Z ; 3:17      print_z 
else125  EQU $          ;           = endif
endif125:
    
    ld    A, E          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, else126    ; 3:10      2dup u< if 
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108 == string127
    call PRINT_STRING_Z ; 3:17      print_z 
else126  EQU $          ;           = endif
endif126:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, E          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       u< if    DE<HL --> DE-HL<0 --> carry if true
    pop  HL             ; 1:10      u< if
    pop  DE             ; 1:10      u< if
    jp   nc, else127    ; 3:10      u< if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string128
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111 == string129
    call PRINT_STRING_Z ; 3:17      print_z 
else128  EQU $          ;           = endif
endif128:
    
    ld    A, L          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, else129    ; 3:10      2dup u<= if 
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111 == string130
    call PRINT_STRING_Z ; 3:17      print_z 
else129  EQU $          ;           = endif
endif129:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, L          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       u<= if    DE<=HL --> 0<=HL-DE --> not carry if true
    pop  HL             ; 1:10      u<= if
    pop  DE             ; 1:10      u<= if
    jp    c, else130    ; 3:10      u<= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string131
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114 == string132
    call PRINT_STRING_Z ; 3:17      print_z 
else131  EQU $          ;           = endif
endif131:
    
    ld    A, L          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, else132    ; 3:10      2dup u> if 
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114 == string133
    call PRINT_STRING_Z ; 3:17      print_z 
else132  EQU $          ;           = endif
endif132:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, L          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       u> if    DE>HL --> 0>HL-DE --> carry if true
    pop  HL             ; 1:10      u> if
    pop  DE             ; 1:10      u> if
    jp   nc, else133    ; 3:10      u> if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string134
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117 == string135
    call PRINT_STRING_Z ; 3:17      print_z 
else134  EQU $          ;           = endif
endif134:
    
    ld    A, E          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, else135    ; 3:10      2dup u>= if 
    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117 == string136
    call PRINT_STRING_Z ; 3:17      print_z 
else135  EQU $          ;           = endif
endif135:
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ld    A, E          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= if    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= if
    pop  DE             ; 1:10      u>= if
    jp    c, else136    ; 3:10      u>= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string137
    call PRINT_STRING_Z ; 3:17      print_z 
else136  EQU $          ;           = endif
endif136:
    
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
    
    ld    A, high 3     ; 2:7       dup 3 = if
    xor   H             ; 1:4       dup 3 = if
    ld    B, A          ; 1:4       dup 3 = if
    ld    A, low 3      ; 2:7       dup 3 = if
    xor   L             ; 1:4       dup 3 = if
    or    B             ; 1:4       dup 3 = if
    jp   nz, else137    ; 3:10      dup 3 = if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string138
    call PRINT_STRING_Z ; 3:17      print_z 
else137  EQU $          ;           = endif
endif137:
    
    ld    A, low 3      ; 2:7       dup 3 <> if
    xor   L             ; 1:4       dup 3 <> if
    jr   nz, $+8        ; 2:7/12    dup 3 <> if
    ld    A, high 3     ; 2:7       dup 3 <> if
    xor   H             ; 1:4       dup 3 <> if
    jp    z, else138    ; 3:10      dup 3 <> if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string139
    call PRINT_STRING_Z ; 3:17      print_z 
else138  EQU $          ;           = endif
endif138:
    
    ld    A, H          ; 1:4       dup 3 < if
    add   A, A          ; 1:4       dup 3 < if
    jr    c, $+11       ; 2:7/12    dup 3 < if    negative HL < positive constant ---> true
    ld    A, L          ; 1:4       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 < if    HL<3 --> HL-3<0 --> carry if true
    jp   nc, else139    ; 3:10      dup 3 < if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string140
    call PRINT_STRING_Z ; 3:17      print_z 
else139  EQU $          ;           = endif
endif139:
    
    ld    A, H          ; 1:4       dup 3 <= if
    add   A, A          ; 1:4       dup 3 <= if
    jr    c, $+11       ; 2:7/12    dup 3 <= if    negative HL <= positive constant ---> true
    ld    A, low 3      ; 2:7       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 <= if    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, else140    ; 3:10      dup 3 <= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string141
    call PRINT_STRING_Z ; 3:17      print_z 
else140  EQU $          ;           = endif
endif140:
    
    ld    A, H          ; 1:4       dup 3 > if
    add   A, A          ; 1:4       dup 3 > if
    jp    c, else141    ; 3:10      dup 3 > if    negative HL > positive constant ---> false
    ld    A, low 3      ; 2:7       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 > if    HL>3 --> 0>3-HL --> carry if true
    jp   nc, else141    ; 3:10      dup 3 > if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string142
    call PRINT_STRING_Z ; 3:17      print_z 
else141  EQU $          ;           = endif
endif141:
    
    ld    A, H          ; 1:4       dup 3 >= if
    add   A, A          ; 1:4       dup 3 >= if
    jp    c, else142    ; 3:10      dup 3 >= if    negative HL >= positive constant ---> false
    ld    A, L          ; 1:4       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 >= if    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, else142    ; 3:10      dup 3 >= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string143
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string144
    call PRINT_STRING_Z ; 3:17      print_z 
else143  EQU $          ;           = endif
endif143:
    
    ld    A, low 3      ; 2:7       dup 3 u<> if
    xor   L             ; 1:4       dup 3 u<> if
    jr   nz, $+8        ; 2:7/12    dup 3 u<> if
    ld    A, high 3     ; 2:7       dup 3 u<> if
    xor   H             ; 1:4       dup 3 u<> if
    jp    z, else144    ; 3:10      dup 3 u<> if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string145
    call PRINT_STRING_Z ; 3:17      print_z 
else144  EQU $          ;           = endif
endif144:
    
    ld    A, L          ; 1:4       dup 3 (u)< if    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 (u)< if    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 (u)< if    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 (u)< if    HL<3 --> HL-3<0 --> carry if true
    jp   nc, else145    ; 3:10      dup 3 (u)< if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string146
    call PRINT_STRING_Z ; 3:17      print_z 
else145  EQU $          ;           = endif
endif145:
    
    ld    A, low 3      ; 2:7       dup 3 (u)<= if    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 (u)<= if    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 (u)<= if    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 (u)<= if    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, else146    ; 3:10      dup 3 (u)<= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string147
    call PRINT_STRING_Z ; 3:17      print_z 
else146  EQU $          ;           = endif
endif146:
    
    ld    A, low 3      ; 2:7       dup 3 (u)> if    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 (u)> if    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 (u)> if    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 (u)> if    HL>3 --> 0>3-HL --> carry if true
    jp   nc, else147    ; 3:10      dup 3 (u)> if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string148
    call PRINT_STRING_Z ; 3:17      print_z 
else147  EQU $          ;           = endif
endif147:
    
    ld    A, L          ; 1:4       dup 3 (u)>= if    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 (u)>= if    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 (u)>= if    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 (u)>= if    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, else148    ; 3:10      dup 3 (u)>= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string149
    call PRINT_STRING_Z ; 3:17      print_z 
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
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



;   ---  the beginning of a non-recursive function  ---
ptestm3:                ;           
    pop  BC             ; 1:10      : ret
    ld  (ptestm3_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    ld    A, high -3    ; 2:7       dup -3 = if
    xor   H             ; 1:4       dup -3 = if
    ld    B, A          ; 1:4       dup -3 = if
    ld    A, low -3     ; 2:7       dup -3 = if
    xor   L             ; 1:4       dup -3 = if
    or    B             ; 1:4       dup -3 = if
    jp   nz, else149    ; 3:10      dup -3 = if 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string150
    call PRINT_STRING_Z ; 3:17      print_z 
else149  EQU $          ;           = endif
endif149:
    
    ld    A, low -3     ; 2:7       dup -3 <> if
    xor   L             ; 1:4       dup -3 <> if
    jr   nz, $+8        ; 2:7/12    dup -3 <> if
    ld    A, high -3    ; 2:7       dup -3 <> if
    xor   H             ; 1:4       dup -3 <> if
    jp    z, else150    ; 3:10      dup -3 <> if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string151
    call PRINT_STRING_Z ; 3:17      print_z 
else150  EQU $          ;           = endif
endif150:
    
    ld    A, H          ; 1:4       dup -3 < if
    add   A, A          ; 1:4       dup -3 < if
    jp   nc, else151    ; 3:10      dup -3 < if    positive HL < negative constant ---> false
    ld    A, L          ; 1:4       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 < if    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, else151    ; 3:10      dup -3 < if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string152
    call PRINT_STRING_Z ; 3:17      print_z 
else151  EQU $          ;           = endif
endif151:
    
    ld    A, H          ; 1:4       dup -3 <= if
    add   A, A          ; 1:4       dup -3 <= if
    jp   nc, else152    ; 3:10      dup -3 <= if    positive HL <= negative constant ---> false
    ld    A, low -3     ; 2:7       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 <= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, else152    ; 3:10      dup -3 <= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string153
    call PRINT_STRING_Z ; 3:17      print_z 
else152  EQU $          ;           = endif
endif152:
    
    ld    A, H          ; 1:4       dup -3 > if
    add   A, A          ; 1:4       dup -3 > if
    jr   nc, $+11       ; 2:7/12    dup -3 > if    positive HL > negative constant ---> true
    ld    A, low -3     ; 2:7       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 > if    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, else153    ; 3:10      dup -3 > if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string154
    call PRINT_STRING_Z ; 3:17      print_z 
else153  EQU $          ;           = endif
endif153:
    
    ld    A, H          ; 1:4       dup -3 >= if
    add   A, A          ; 1:4       dup -3 >= if
    jr   nc, $+11       ; 2:7/12    dup -3 >= if    positive HL >= negative constant ---> true
    ld    A, L          ; 1:4       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 >= if    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, else154    ; 3:10      dup -3 >= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string155
    call PRINT_STRING_Z ; 3:17      print_z 
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
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string156
    call PRINT_STRING_Z ; 3:17      print_z 
else155  EQU $          ;           = endif
endif155:
    
    ld    A, low -3     ; 2:7       dup -3 u<> if
    xor   L             ; 1:4       dup -3 u<> if
    jr   nz, $+8        ; 2:7/12    dup -3 u<> if
    ld    A, high -3    ; 2:7       dup -3 u<> if
    xor   H             ; 1:4       dup -3 u<> if
    jp    z, else156    ; 3:10      dup -3 u<> if 
    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string157
    call PRINT_STRING_Z ; 3:17      print_z 
else156  EQU $          ;           = endif
endif156:
    
    ld    A, L          ; 1:4       dup -3 (u)< if    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 (u)< if    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 (u)< if    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 (u)< if    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, else157    ; 3:10      dup -3 (u)< if 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string158
    call PRINT_STRING_Z ; 3:17      print_z 
else157  EQU $          ;           = endif
endif157:
    
    ld    A, low -3     ; 2:7       dup -3 (u)<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 (u)<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 (u)<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 (u)<= if    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, else158    ; 3:10      dup -3 (u)<= if 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string159
    call PRINT_STRING_Z ; 3:17      print_z 
else158  EQU $          ;           = endif
endif158:
    
    ld    A, low -3     ; 2:7       dup -3 (u)> if    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 (u)> if    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 (u)> if    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 (u)> if    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, else159    ; 3:10      dup -3 (u)> if 
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116 == string160
    call PRINT_STRING_Z ; 3:17      print_z 
else159  EQU $          ;           = endif
endif159:
    
    ld    A, L          ; 1:4       dup -3 (u)>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 (u)>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 (u)>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 (u)>= if    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, else160    ; 3:10      dup -3 (u)>= if 
    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string161
    call PRINT_STRING_Z ; 3:17      print_z 
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

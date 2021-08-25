; vvvvv
; ^^^^^
ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10      Init Return address stack
    exx                 ; 1:4
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
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size110    ; 3:10      print Length of string to print
    ld   DE, string110  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size111    ; 3:10      print Length of string to print
    ld   DE, string111  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size112    ; 3:10      print Length of string to print
    ld   DE, string112  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size113    ; 3:10      print Length of string to print
    ld   DE, string113  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size114    ; 3:10      print Length of string to print
    ld   DE, string114  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size115    ; 3:10      print Length of string to print
    ld   DE, string115  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size116    ; 3:10      print Length of string to print
    ld   DE, string116  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size117    ; 3:10      print Length of string to print
    ld   DE, string117  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size118    ; 3:10      print Length of string to print
    ld   DE, string118  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size119    ; 3:10      print Length of string to print
    ld   DE, string119  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size120    ; 3:10      print Length of string to print
    ld   DE, string120  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size121    ; 3:10      print Length of string to print
    ld   DE, string121  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size122    ; 3:10      print Length of string to print
    ld   DE, string122  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size123    ; 3:10      print Length of string to print
    ld   DE, string123  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size124    ; 3:10      print Length of string to print
    ld   DE, string124  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size125    ; 3:10      print Length of string to print
    ld   DE, string125  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size126    ; 3:10      print Length of string to print
    ld   DE, string126  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break125       ; 3:10      break 125 
    jp   begin125       ; 3:10      again 125
break125:               ;           again 125
    
begin126: 
    ld    A, E          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, break126   ; 3:10      2dup u< while 126 
    push DE             ; 1:11      print
    ld   BC, size127    ; 3:10      print Length of string to print
    ld   DE, string127  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size128    ; 3:10      print Length of string to print
    ld   DE, string128  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size129    ; 3:10      print Length of string to print
    ld   DE, string129  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break128       ; 3:10      break 128 
    jp   begin128       ; 3:10      again 128
break128:               ;           again 128
    
begin129: 
    ld    A, L          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    sub   E             ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    ld    A, H          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    sbc   A, D          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> not carry if true
    jp    c, break129   ; 3:10      2dup u<= while 129 
    push DE             ; 1:11      print
    ld   BC, size130    ; 3:10      print Length of string to print
    ld   DE, string130  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size131    ; 3:10      print Length of string to print
    ld   DE, string131  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size132    ; 3:10      print Length of string to print
    ld   DE, string132  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break131       ; 3:10      break 131 
    jp   begin131       ; 3:10      again 131
break131:               ;           again 131
    
begin132: 
    ld    A, L          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, break132   ; 3:10      2dup u> while 132 
    push DE             ; 1:11      print
    ld   BC, size133    ; 3:10      print Length of string to print
    ld   DE, string133  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size134    ; 3:10      print Length of string to print
    ld   DE, string134  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size135    ; 3:10      print Length of string to print
    ld   DE, string135  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break134       ; 3:10      break 134 
    jp   begin134       ; 3:10      again 134
break134:               ;           again 134
    
begin135: 
    ld    A, E          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> not carry if true
    jp    c, break135   ; 3:10      2dup u>= while 135 
    push DE             ; 1:11      print
    ld   BC, size136    ; 3:10      print Length of string to print
    ld   DE, string136  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size137    ; 3:10      print Length of string to print
    ld   DE, string137  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size138    ; 3:10      print Length of string to print
    ld   DE, string138  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size139    ; 3:10      print Length of string to print
    ld   DE, string139  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size140    ; 3:10      print Length of string to print
    ld   DE, string140  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size141    ; 3:10      print Length of string to print
    ld   DE, string141  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size142    ; 3:10      print Length of string to print
    ld   DE, string142  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size143    ; 3:10      print Length of string to print
    ld   DE, string143  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size144    ; 3:10      print Length of string to print
    ld   DE, string144  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size145    ; 3:10      print Length of string to print
    ld   DE, string145  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break144       ; 3:10      break 144 
    jp   begin144       ; 3:10      again 144
break144:               ;           again 144
    
begin145: 
    ld    A, L          ; 1:4       dup 3 u< while 145    HL<3 --> HL-3<0 --> carry if true
    sub   low 3         ; 2:7       dup 3 u< while 145    HL<3 --> HL-3<0 --> carry if true
    ld    A, H          ; 1:4       dup 3 u< while 145    HL<3 --> HL-3<0 --> carry if true
    sbc   A, high 3     ; 2:7       dup 3 u< while 145    HL<3 --> HL-3<0 --> carry if true
    jp   nc, break145   ; 3:10      dup 3 u< while 145 
    push DE             ; 1:11      print
    ld   BC, size146    ; 3:10      print Length of string to print
    ld   DE, string146  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break145       ; 3:10      break 145 
    jp   begin145       ; 3:10      again 145
break145:               ;           again 145
    
begin146: 
    ld    A, low 3      ; 2:7       dup 3 u<= while 146    HL<=3 --> 0<=3-HL --> not carry if true
    sub   L             ; 1:4       dup 3 u<= while 146    HL<=3 --> 0<=3-HL --> not carry if true
    ld    A, high 3     ; 2:7       dup 3 u<= while 146    HL<=3 --> 0<=3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup 3 u<= while 146    HL<=3 --> 0<=3-HL --> not carry if true
    jp    c, break146   ; 3:10      dup 3 u<= while 146 
    push DE             ; 1:11      print
    ld   BC, size147    ; 3:10      print Length of string to print
    ld   DE, string147  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break146       ; 3:10      break 146 
    jp   begin146       ; 3:10      again 146
break146:               ;           again 146
    
begin147: 
    ld    A, low 3      ; 2:7       dup 3 u> while 147    HL>3 --> 0>3-HL --> carry if true
    sub   L             ; 1:4       dup 3 u> while 147    HL>3 --> 0>3-HL --> carry if true
    ld    A, high 3     ; 2:7       dup 3 u> while 147    HL>3 --> 0>3-HL --> carry if true
    sbc   A, H          ; 1:4       dup 3 u> while 147    HL>3 --> 0>3-HL --> carry if true
    jp   nc, break147   ; 3:10      dup 3 u> while 147 
    push DE             ; 1:11      print
    ld   BC, size148    ; 3:10      print Length of string to print
    ld   DE, string148  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break147       ; 3:10      break 147 
    jp   begin147       ; 3:10      again 147
break147:               ;           again 147
    
begin148: 
    ld    A, L          ; 1:4       dup 3 u>= while 148    HL>=3 --> HL-3>=0 --> not carry if true
    sub   low 3         ; 2:7       dup 3 u>= while 148    HL>=3 --> HL-3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 3 u>= while 148    HL>=3 --> HL-3>=0 --> not carry if true
    sbc   A, high 3     ; 2:7       dup 3 u>= while 148    HL>=3 --> HL-3>=0 --> not carry if true
    jp    c, break148   ; 3:10      dup 3 u>= while 148 
    push DE             ; 1:11      print
    ld   BC, size149    ; 3:10      print Length of string to print
    ld   DE, string149  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size150    ; 3:10      print Length of string to print
    ld   DE, string150  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size151    ; 3:10      print Length of string to print
    ld   DE, string151  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size152    ; 3:10      print Length of string to print
    ld   DE, string152  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size153    ; 3:10      print Length of string to print
    ld   DE, string153  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size154    ; 3:10      print Length of string to print
    ld   DE, string154  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size155    ; 3:10      print Length of string to print
    ld   DE, string155  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size156    ; 3:10      print Length of string to print
    ld   DE, string156  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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
    push DE             ; 1:11      print
    ld   BC, size157    ; 3:10      print Length of string to print
    ld   DE, string157  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break156       ; 3:10      break 156 
    jp   begin156       ; 3:10      again 156
break156:               ;           again 156
    
begin157: 
    ld    A, L          ; 1:4       dup -3 u< while 157    HL<-3 --> HL--3<0 --> carry if true
    sub   low -3        ; 2:7       dup -3 u< while 157    HL<-3 --> HL--3<0 --> carry if true
    ld    A, H          ; 1:4       dup -3 u< while 157    HL<-3 --> HL--3<0 --> carry if true
    sbc   A, high -3    ; 2:7       dup -3 u< while 157    HL<-3 --> HL--3<0 --> carry if true
    jp   nc, break157   ; 3:10      dup -3 u< while 157 
    push DE             ; 1:11      print
    ld   BC, size158    ; 3:10      print Length of string to print
    ld   DE, string158  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break157       ; 3:10      break 157 
    jp   begin157       ; 3:10      again 157
break157:               ;           again 157
    
begin158: 
    ld    A, low -3     ; 2:7       dup -3 u<= while 158    HL<=-3 --> 0<=-3-HL --> not carry if true
    sub   L             ; 1:4       dup -3 u<= while 158    HL<=-3 --> 0<=-3-HL --> not carry if true
    ld    A, high -3    ; 2:7       dup -3 u<= while 158    HL<=-3 --> 0<=-3-HL --> not carry if true
    sbc   A, H          ; 1:4       dup -3 u<= while 158    HL<=-3 --> 0<=-3-HL --> not carry if true
    jp    c, break158   ; 3:10      dup -3 u<= while 158 
    push DE             ; 1:11      print
    ld   BC, size159    ; 3:10      print Length of string to print
    ld   DE, string159  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break158       ; 3:10      break 158 
    jp   begin158       ; 3:10      again 158
break158:               ;           again 158
    
begin159: 
    ld    A, low -3     ; 2:7       dup -3 u> while 159    HL>-3 --> 0>-3-HL --> carry if true
    sub   L             ; 1:4       dup -3 u> while 159    HL>-3 --> 0>-3-HL --> carry if true
    ld    A, high -3    ; 2:7       dup -3 u> while 159    HL>-3 --> 0>-3-HL --> carry if true
    sbc   A, H          ; 1:4       dup -3 u> while 159    HL>-3 --> 0>-3-HL --> carry if true
    jp   nc, break159   ; 3:10      dup -3 u> while 159 
    push DE             ; 1:11      print
    ld   BC, size160    ; 3:10      print Length of string to print
    ld   DE, string160  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   break159       ; 3:10      break 159 
    jp   begin159       ; 3:10      again 159
break159:               ;           again 159
    
begin160: 
    ld    A, L          ; 1:4       dup -3 u>= while 160    HL>=-3 --> HL--3>=0 --> not carry if true
    sub   low -3        ; 2:7       dup -3 u>= while 160    HL>=-3 --> HL--3>=0 --> not carry if true
    ld    A, H          ; 1:4       dup -3 u>= while 160    HL>=-3 --> HL--3>=0 --> not carry if true
    sbc   A, high -3    ; 2:7       dup -3 u>= while 160    HL>=-3 --> HL--3>=0 --> not carry if true
    jp    c, break160   ; 3:10      dup -3 u>= while 160 
    push DE             ; 1:11      print
    ld   BC, size161    ; 3:10      print Length of string to print
    ld   DE, string161  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
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


; vvvv
; ^^^^
    ORG 32768
    
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    ld  hl, stack_test
    push hl

    
    push DE             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   HL, 0          ; 3:10      push2(4,0)  
    push HL             ; 1:11      do 101 index
    push DE             ; 1:11      do 101 stop
    exx                 ; 1:4       do 101
    pop  DE             ; 1:10      do 101 stop
    dec  HL             ; 1:6       do 101
    ld  (HL),D          ; 1:7       do 101
    dec  L              ; 1:4       do 101
    ld  (HL),E          ; 1:7       do 101 stop
    pop  DE             ; 1:10      do 101 index
    dec  HL             ; 1:6       do 101
    ld  (HL),D          ; 1:7       do 101
    dec  L              ; 1:4       do 101
    ld  (HL),E          ; 1:7       do 101 index
    exx                 ; 1:4       do 101
    pop  HL             ; 1:10      do 101
    pop  DE             ; 1:10      do 101 ( stop index -- ) R: ( -- stop index )
do101:  
    exx                 ; 1:4       index 101 i    
    ld    E,(HL)        ; 1:7       index 101 i
    inc   L             ; 1:4       index 101 i
    ld    D,(HL)        ; 1:7       index 101 i
    push DE             ; 1:11      index 101 i
    dec   L             ; 1:4       index 101 i
    exx                 ; 1:4       index 101 i
    ex   DE, HL         ; 1:4       index 101 i
    ex  (SP),HL         ; 1:19      index 101 i 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0)  
    push HL             ; 1:11      ?do 102 index
    or    A             ; 1:4       ?do 102
    sbc  HL, DE         ; 2:15      ?do 102
    jr   nz, $+8        ; 2:7/12    ?do 102
    pop  HL             ; 1:10      ?do 102
    pop  HL             ; 1:10      ?do 102
    pop  DE             ; 1:10      ?do 102
    jp   exit102        ; 3:10      ?do 102   
    push DE             ; 1:11      ?do 102 stop
    exx                 ; 1:4       ?do 102
    pop  DE             ; 1:10      ?do 102 stop
    dec  HL             ; 1:6       ?do 102
    ld  (HL),D          ; 1:7       ?do 102
    dec  L              ; 1:4       ?do 102
    ld  (HL),E          ; 1:7       ?do 102 stop
    pop  DE             ; 1:10      ?do 102 index
    dec  HL             ; 1:6       ?do 102
    ld  (HL),D          ; 1:7       ?do 102
    dec  L              ; 1:4       ?do 102
    ld  (HL),E          ; 1:7       ?do 102 index
    exx                 ; 1:4       ?do 102
    pop  HL             ; 1:10      ?do 102
    pop  DE             ; 1:10      ?do 102 ( stop index -- ) R: ( -- stop index )
do102:  
    exx                 ; 1:4       index 102 j
    ld   DE, 0x0004     ; 3:10      index 102 j
    ex   DE, HL         ; 1:4       index 102 j
    add  HL, DE         ; 1:11      index 102 j
    ld    C,(HL)        ; 1:7       index 102 j lo    
    inc   L             ; 1:4       index 102 j
    ld    B,(HL)        ; 1:7       index 102 j hi
    ex   DE, HL         ; 1:4       index 102 j
    push BC             ; 1:11      index 102 j
    exx                 ; 1:4       index 102 j
    ex   DE, HL         ; 1:4       index 102 j
    ex  (SP),HL         ; 1:19      index 102 j 
    call PRINT_S16      ; 3:17      .  
    exx                 ; 1:4       index 102 i    
    ld    E,(HL)        ; 1:7       index 102 i
    inc   L             ; 1:4       index 102 i
    ld    D,(HL)        ; 1:7       index 102 i
    push DE             ; 1:11      index 102 i
    dec   L             ; 1:4       index 102 i
    exx                 ; 1:4       index 102 i
    ex   DE, HL         ; 1:4       index 102 i
    ex  (SP),HL         ; 1:19      index 102 i 
    call PRINT_S16      ; 3:17      .  
    exx                 ; 1:4       loop 102
    ld    E,(HL)        ; 1:7       loop 102
    inc   L             ; 1:4       loop 102
    ld    D,(HL)        ; 1:7       loop 102 DE = index   
    inc  HL             ; 1:6       loop 102
    inc  DE             ; 1:6       loop 102 index++
    ld    A,(HL)        ; 1:4       loop 102
    xor   E             ; 1:4       loop 102 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 102
    ld    A, D          ; 1:4       loop 102
    inc   L             ; 1:4       loop 102
    xor (HL)            ; 1:7       loop 102 hi index - stop
    jr    z, leave102   ; 2:7/12    loop 102 exit    
    dec   L             ; 1:4       loop 102
    dec  HL             ; 1:6       loop 102
    ld  (HL), D         ; 1:7       loop 102
    dec   L             ; 1:4       loop 102
    ld  (HL), E         ; 1:7       loop 102
    exx                 ; 1:4       loop 102
    jp   do102          ; 3:10      loop 102
leave102:
    inc  HL             ; 1:6       loop 102
    exx                 ; 1:4       loop 102
exit102 EQU $ 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A  
    exx                 ; 1:4       loop 101
    ld    E,(HL)        ; 1:7       loop 101
    inc   L             ; 1:4       loop 101
    ld    D,(HL)        ; 1:7       loop 101 DE = index   
    inc  HL             ; 1:6       loop 101
    inc  DE             ; 1:6       loop 101 index++
    ld    A,(HL)        ; 1:4       loop 101
    xor   E             ; 1:4       loop 101 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 101
    ld    A, D          ; 1:4       loop 101
    inc   L             ; 1:4       loop 101
    xor (HL)            ; 1:7       loop 101 hi index - stop
    jr    z, leave101   ; 2:7/12    loop 101 exit    
    dec   L             ; 1:4       loop 101
    dec  HL             ; 1:6       loop 101
    ld  (HL), D         ; 1:7       loop 101
    dec   L             ; 1:4       loop 101
    ld  (HL), E         ; 1:7       loop 101
    exx                 ; 1:4       loop 101
    jp   do101          ; 3:10      loop 101
leave101:
    inc  HL             ; 1:6       loop 101
    exx                 ; 1:4       loop 101
exit101 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   HL, 0          ; 3:10      push2(4,0) 

sdo103:                 ;           sdo 103 ( stop index -- stop index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 

    push HL             ; 1:10      ?sdo 104
    or    A             ; 1:4       ?sdo 104
    sbc  HL, DE         ; 2:15      ?sdo 104
    pop  HL             ; 1:10      ?sdo 104
    jp    z, sleave104  ; 3:10      ?sdo 104   
sdo104:                 ;           sdo 104 ( stop index -- stop index ) 
     
    pop  BC             ; 1:10      2 pick
    push BC             ; 1:11      2 pick
    push DE             ; 1:11      2 pick
    ex   DE, HL         ; 1:4       2 pick
    ld    H, B          ; 1:4       2 pick
    ld    L, C          ; 1:4       2 pick ( c b a -- c b a c ) 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
    inc  HL             ; 1:6       sloop 104 index++
    ld    A, E          ; 1:4       sloop 104
    xor   L             ; 1:4       sloop 104 lo index - stop
    jp   nz, sdo104     ; 3:10      sloop 104
    ld    A, D          ; 1:4       sloop 104
    xor   H             ; 1:4       sloop 104 hi index - stop
    jp   nz, sdo104     ; 3:10      sloop 104
sleave104:              ;           sloop 104
    pop  HL             ; 1:10      unsloop 104 index out
    pop  DE             ; 1:10      unsloop 104 stop  out
 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    inc  HL             ; 1:6       sloop 103 index++
    ld    A, E          ; 1:4       sloop 103
    xor   L             ; 1:4       sloop 103 lo index - stop
    jp   nz, sdo103     ; 3:10      sloop 103
    ld    A, D          ; 1:4       sloop 103
    xor   H             ; 1:4       sloop 103 hi index - stop
    jp   nz, sdo103     ; 3:10      sloop 103
sleave103:              ;           sloop 103
    pop  HL             ; 1:10      unsloop 103 index out
    pop  DE             ; 1:10      unsloop 103 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
      

    exx                 ; 1:4       xdo(4,0) 105
    dec  HL             ; 1:6       xdo(4,0) 105
    ld  (HL),high 0     ; 2:10      xdo(4,0) 105
    dec   L             ; 1:4       xdo(4,0) 105
    ld  (HL),low 0      ; 2:10      xdo(4,0) 105
    exx                 ; 1:4       xdo(4,0) 105 R:( -- 0 )
xdo105:                 ;           xdo(4,0) 105     
    exx                 ; 1:4       index xi 105
    ld    E,(HL)        ; 1:7       index xi 105
    inc   L             ; 1:4       index xi 105
    ld    D,(HL)        ; 1:7       index xi 105
    push DE             ; 1:11      index xi 105
    dec   L             ; 1:4       index xi 105
    exx                 ; 1:4       index xi 105 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 105
    ex  (SP),HL         ; 1:19      index xi 105 ( -- x ) 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 

    push HL             ; 1:10      ?sdo 106
    or    A             ; 1:4       ?sdo 106
    sbc  HL, DE         ; 2:15      ?sdo 106
    pop  HL             ; 1:10      ?sdo 106
    jp    z, sleave106  ; 3:10      ?sdo 106   
sdo106:                 ;           sdo 106 ( stop index -- stop index ) 
    exx                 ; 1:4       index xi 106
    ld    E,(HL)        ; 1:7       index xi 106
    inc   L             ; 1:4       index xi 106
    ld    D,(HL)        ; 1:7       index xi 106
    push DE             ; 1:11      index xi 106
    dec   L             ; 1:4       index xi 106
    exx                 ; 1:4       index xi 106 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 106
    ex  (SP),HL         ; 1:19      index xi 106 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
    inc  HL             ; 1:6       sloop 106 index++
    ld    A, E          ; 1:4       sloop 106
    xor   L             ; 1:4       sloop 106 lo index - stop
    jp   nz, sdo106     ; 3:10      sloop 106
    ld    A, D          ; 1:4       sloop 106
    xor   H             ; 1:4       sloop 106 hi index - stop
    jp   nz, sdo106     ; 3:10      sloop 106
sleave106:              ;           sloop 106
    pop  HL             ; 1:10      unsloop 106 index out
    pop  DE             ; 1:10      unsloop 106 stop  out
 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xloop(4,0) 105
    ld    E,(HL)        ; 1:7       xloop(4,0) 105
    inc   L             ; 1:4       xloop(4,0) 105
    ld    D,(HL)        ; 1:7       xloop(4,0) 105
    inc  DE             ; 1:6       xloop(4,0) 105 index++
    ld    A, low 4      ; 2:7       xloop(4,0) 105
    xor   E             ; 1:4       xloop(4,0) 105
    jr   nz, $+7        ; 2:7/12    xloop(4,0) 105
    ld    A, high 4     ; 2:7       xloop(4,0) 105
    xor   D             ; 1:4       xloop(4,0) 105
    jr    z, xleave105  ; 2:7/12    xloop(4,0) 105 exit
    ld  (HL), D         ; 1:7       xloop(4,0) 105
    dec   L             ; 1:4       xloop(4,0) 105
    ld  (HL), E         ; 1:6       xloop(4,0) 105
    exx                 ; 1:4       xloop(4,0) 105
    jp   xdo105         ; 3:10      xloop(4,0) 105
xleave105:              ;           xloop(4,0) 105
    inc  HL             ; 1:6       xloop(4,0) 105
    exx                 ; 1:4       xloop(4,0) 105 R:( index -- )
xexit105 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(3,0)
    ld   DE, 3          ; 3:10      push2(3,0)
    push HL             ; 1:11      push2(3,0)
    ld   HL, 0          ; 3:10      push2(3,0) 

sdo107:                 ;           sdo 107 ( stop index -- stop index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )                 
    push HL             ; 1:11      for 108 index
    exx                 ; 1:4       for 108
    pop  DE             ; 1:10      for 108 stop
    dec  HL             ; 1:6       for 108
    ld  (HL),D          ; 1:7       for 108
    dec  L              ; 1:4       for 108
    ld  (HL),E          ; 1:7       for 108 stop
    exx                 ; 1:4       for 108
    ex   DE, HL         ; 1:4       for 108
    pop  DE             ; 1:10      for 108 ( index -- ) R: ( -- index )
for108:                 ;           for 108 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .  
    exx                 ; 1:4       index 108 i    
    ld    E,(HL)        ; 1:7       index 108 i
    inc   L             ; 1:4       index 108 i
    ld    D,(HL)        ; 1:7       index 108 i
    push DE             ; 1:11      index 108 i
    dec   L             ; 1:4       index 108 i
    exx                 ; 1:4       index 108 i
    ex   DE, HL         ; 1:4       index 108 i
    ex  (SP),HL         ; 1:19      index 108 i 
    call PRINT_S16      ; 3:17      .  
    exx                 ; 1:4       next 108
    ld    E,(HL)        ; 1:7       next 108
    inc   L             ; 1:4       next 108
    ld    D,(HL)        ; 1:7       next 108 DE = index   
    ld    A, E          ; 1:4       next 108
    or    D             ; 1:4       next 108
    jr    z, next108    ; 2:7/12    next 108 exit
    dec  DE             ; 1:6       next 108 index--
    ld  (HL),D          ; 1:7       next 108
    dec   L             ; 1:4       next 108
    ld  (HL),E          ; 1:7       next 108
    exx                 ; 1:4       next 108
    jp   for108         ; 3:10      next 108
next108:                ;           next 108
    inc  HL             ; 1:6       next 108
    exx                 ; 1:4       next 108 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    inc  HL             ; 1:6       sloop 107 index++
    ld    A, E          ; 1:4       sloop 107
    xor   L             ; 1:4       sloop 107 lo index - stop
    jp   nz, sdo107     ; 3:10      sloop 107
    ld    A, D          ; 1:4       sloop 107
    xor   H             ; 1:4       sloop 107 hi index - stop
    jp   nz, sdo107     ; 3:10      sloop 107
sleave107:              ;           sloop 107
    pop  HL             ; 1:10      unsloop 107 index out
    pop  DE             ; 1:10      unsloop 107 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(3,0)
    ld   DE, 3          ; 3:10      push2(3,0)
    push HL             ; 1:11      push2(3,0)
    ld   HL, 0          ; 3:10      push2(3,0)  
    push HL             ; 1:11      do 109 index
    push DE             ; 1:11      do 109 stop
    exx                 ; 1:4       do 109
    pop  DE             ; 1:10      do 109 stop
    dec  HL             ; 1:6       do 109
    ld  (HL),D          ; 1:7       do 109
    dec  L              ; 1:4       do 109
    ld  (HL),E          ; 1:7       do 109 stop
    pop  DE             ; 1:10      do 109 index
    dec  HL             ; 1:6       do 109
    ld  (HL),D          ; 1:7       do 109
    dec  L              ; 1:4       do 109
    ld  (HL),E          ; 1:7       do 109 index
    exx                 ; 1:4       do 109
    pop  HL             ; 1:10      do 109
    pop  DE             ; 1:10      do 109 ( stop index -- ) R: ( -- stop index )
do109:  
    exx                 ; 1:4       index 109 i    
    ld    E,(HL)        ; 1:7       index 109 i
    inc   L             ; 1:4       index 109 i
    ld    D,(HL)        ; 1:7       index 109 i
    push DE             ; 1:11      index 109 i
    dec   L             ; 1:4       index 109 i
    exx                 ; 1:4       index 109 i
    ex   DE, HL         ; 1:4       index 109 i
    ex  (SP),HL         ; 1:19      index 109 i                
sfor110:                ;           sfor 110 ( index -- index )  
    exx                 ; 1:4       index 110 i    
    ld    E,(HL)        ; 1:7       index 110 i
    inc   L             ; 1:4       index 110 i
    ld    D,(HL)        ; 1:7       index 110 i
    push DE             ; 1:11      index 110 i
    dec   L             ; 1:4       index 110 i
    exx                 ; 1:4       index 110 i
    ex   DE, HL         ; 1:4       index 110 i
    ex  (SP),HL         ; 1:19      index 110 i 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
    ld   A, H           ; 1:4       snext 110
    or   L              ; 1:4       snext 110
    dec  HL             ; 1:6       snext 110 index--
    jp  nz, sfor110     ; 3:10      snext 110
snext110:               ;           snext 110
    ex   DE, HL         ; 1:4       sfor unloop 110
    pop  DE             ; 1:10      sfor unloop 110 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A  
    exx                 ; 1:4       loop 109
    ld    E,(HL)        ; 1:7       loop 109
    inc   L             ; 1:4       loop 109
    ld    D,(HL)        ; 1:7       loop 109 DE = index   
    inc  HL             ; 1:6       loop 109
    inc  DE             ; 1:6       loop 109 index++
    ld    A,(HL)        ; 1:4       loop 109
    xor   E             ; 1:4       loop 109 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 109
    ld    A, D          ; 1:4       loop 109
    inc   L             ; 1:4       loop 109
    xor (HL)            ; 1:7       loop 109 hi index - stop
    jr    z, leave109   ; 2:7/12    loop 109 exit    
    dec   L             ; 1:4       loop 109
    dec  HL             ; 1:6       loop 109
    ld  (HL), D         ; 1:7       loop 109
    dec   L             ; 1:4       loop 109
    ld  (HL), E         ; 1:7       loop 109
    exx                 ; 1:4       loop 109
    jp   do109          ; 3:10      loop 109
leave109:
    inc  HL             ; 1:6       loop 109
    exx                 ; 1:4       loop 109
exit109 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    push DE             ; 1:11      push(5)
    ex   DE, HL         ; 1:4       push(5)
    ld   HL, 5          ; 3:10      push(5)          
sfor111:                ;           sfor 111 ( index -- index )    
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .       
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A          
    ld   A, H           ; 1:4       snext 111
    or   L              ; 1:4       snext 111
    dec  HL             ; 1:6       snext 111 index--
    jp  nz, sfor111     ; 3:10      snext 111
snext111:               ;           snext 111
    ex   DE, HL         ; 1:4       sfor unloop 111
    pop  DE             ; 1:10      sfor unloop 111 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(5)
    ex   DE, HL         ; 1:4       push(5)
    ld   HL, 5          ; 3:10      push(5)           
    push HL             ; 1:11      for 112 index
    exx                 ; 1:4       for 112
    pop  DE             ; 1:10      for 112 stop
    dec  HL             ; 1:6       for 112
    ld  (HL),D          ; 1:7       for 112
    dec  L              ; 1:4       for 112
    ld  (HL),E          ; 1:7       for 112 stop
    exx                 ; 1:4       for 112
    ex   DE, HL         ; 1:4       for 112
    pop  DE             ; 1:10      for 112 ( index -- ) R: ( -- index )
for112:                 ;           for 112     
    exx                 ; 1:4       index 112 i    
    ld    E,(HL)        ; 1:7       index 112 i
    inc   L             ; 1:4       index 112 i
    ld    D,(HL)        ; 1:7       index 112 i
    push DE             ; 1:11      index 112 i
    dec   L             ; 1:4       index 112 i
    exx                 ; 1:4       index 112 i
    ex   DE, HL         ; 1:4       index 112 i
    ex  (SP),HL         ; 1:19      index 112 i 
    call PRINT_S16      ; 3:17      .       
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A           
    exx                 ; 1:4       next 112
    ld    E,(HL)        ; 1:7       next 112
    inc   L             ; 1:4       next 112
    ld    D,(HL)        ; 1:7       next 112 DE = index   
    ld    A, E          ; 1:4       next 112
    or    D             ; 1:4       next 112
    jr    z, next112    ; 2:7/12    next 112 exit
    dec  DE             ; 1:6       next 112 index--
    ld  (HL),D          ; 1:7       next 112
    dec   L             ; 1:4       next 112
    ld  (HL),E          ; 1:7       next 112
    exx                 ; 1:4       next 112
    jp   for112         ; 3:10      next 112
next112:                ;           next 112
    inc  HL             ; 1:6       next 112
    exx                 ; 1:4       next 112 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(5)
    ex   DE, HL         ; 1:4       push(5)
    ld   HL, 5          ; 3:10      push(5) 
begin101: 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, H          ; 1:4       dup_while 101
    or    L             ; 1:4       dup_while 101
    jp    z, break101   ; 3:10      dup_while 101 
    dec  HL             ; 1:6       1- 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A ;--> " 5, 4, 3, 2, 1, 0"
    
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
begin102: 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      dup 4
    push HL             ; 1:11      dup 4
    ex   DE, HL         ; 1:4       dup 4
    ld   HL, 4          ; 3:10      dup 4 
    ld    A, H          ; 1:4       <
    xor   D             ; 1:4       <
    jp    p, $+7        ; 3:10      <
    rl    D             ; 2:8       < sign x2
    jr   $+5            ; 2:12      <
    ex   DE, HL         ; 1:4       <
    sbc  HL, DE         ; 2:15      <
    sbc  HL, HL         ; 2:15      <
    pop  DE             ; 1:10      < 
    ld    A, H          ; 1:4       while 102
    or    L             ; 1:4       while 102
    ex   DE, HL         ; 1:4       while 102
    pop  DE             ; 1:10      while 102
    jp    z, break102   ; 3:10      while 102 
    inc  HL             ; 1:6       1+ 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   begin102       ; 3:10      repeat 102
break102:               ;           repeat 102 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A ;--> " 0, 1, 2, 3, 4"
    
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
begin103: 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      dup 4
    push HL             ; 1:11      dup 4
    ex   DE, HL         ; 1:4       dup 4
    ld   HL, 4          ; 3:10      dup 4 
    ld    A, H          ; 1:4       <
    xor   D             ; 1:4       <
    jp    p, $+7        ; 3:10      <
    rl    D             ; 2:8       < sign x2
    jr   $+5            ; 2:12      <
    ex   DE, HL         ; 1:4       <
    sbc  HL, DE         ; 2:15      <
    sbc  HL, HL         ; 2:15      <
    pop  DE             ; 1:10      < 
    ld    A, H          ; 1:4       while 103
    or    L             ; 1:4       while 103
    ex   DE, HL         ; 1:4       while 103
    pop  DE             ; 1:10      while 103
    jp    z, break103   ; 3:10      while 103 
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+ 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   begin103       ; 3:10      repeat 103
break103:               ;           repeat 103 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A ;--> " 0, 2, 4"

    
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)      
    push HL             ; 1:11      do 113 index
    push DE             ; 1:11      do 113 stop
    exx                 ; 1:4       do 113
    pop  DE             ; 1:10      do 113 stop
    dec  HL             ; 1:6       do 113
    ld  (HL),D          ; 1:7       do 113
    dec  L              ; 1:4       do 113
    ld  (HL),E          ; 1:7       do 113 stop
    pop  DE             ; 1:10      do 113 index
    dec  HL             ; 1:6       do 113
    ld  (HL),D          ; 1:7       do 113
    dec  L              ; 1:4       do 113
    ld  (HL),E          ; 1:7       do 113 index
    exx                 ; 1:4       do 113
    pop  HL             ; 1:10      do 113
    pop  DE             ; 1:10      do 113 ( stop index -- ) R: ( -- stop index )
do113:              
    ld    A, 'a'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       leave 113
    inc  L              ; 1:4       leave 113
    inc  HL             ; 1:6       leave 113
    inc  L              ; 1:4       leave 113
    jp   leave113       ;           leave 113          
    exx                 ; 1:4       loop 113
    ld    E,(HL)        ; 1:7       loop 113
    inc   L             ; 1:4       loop 113
    ld    D,(HL)        ; 1:7       loop 113 DE = index   
    inc  HL             ; 1:6       loop 113
    inc  DE             ; 1:6       loop 113 index++
    ld    A,(HL)        ; 1:4       loop 113
    xor   E             ; 1:4       loop 113 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 113
    ld    A, D          ; 1:4       loop 113
    inc   L             ; 1:4       loop 113
    xor (HL)            ; 1:7       loop 113 hi index - stop
    jr    z, leave113   ; 2:7/12    loop 113 exit    
    dec   L             ; 1:4       loop 113
    dec  HL             ; 1:6       loop 113
    ld  (HL), D         ; 1:7       loop 113
    dec   L             ; 1:4       loop 113
    ld  (HL), E         ; 1:7       loop 113
    exx                 ; 1:4       loop 113
    jp   do113          ; 3:10      loop 113
leave113:
    inc  HL             ; 1:6       loop 113
    exx                 ; 1:4       loop 113
exit113 EQU $ 
    
    push DE             ; 1:11      push2(0,1)
    ld   DE, 0          ; 3:10      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1)      
    push HL             ; 1:11      do 114 index
    push DE             ; 1:11      do 114 stop
    exx                 ; 1:4       do 114
    pop  DE             ; 1:10      do 114 stop
    dec  HL             ; 1:6       do 114
    ld  (HL),D          ; 1:7       do 114
    dec  L              ; 1:4       do 114
    ld  (HL),E          ; 1:7       do 114 stop
    pop  DE             ; 1:10      do 114 index
    dec  HL             ; 1:6       do 114
    ld  (HL),D          ; 1:7       do 114
    dec  L              ; 1:4       do 114
    ld  (HL),E          ; 1:7       do 114 index
    exx                 ; 1:4       do 114
    pop  HL             ; 1:10      do 114
    pop  DE             ; 1:10      do 114 ( stop index -- ) R: ( -- stop index )
do114:              
    ld    A, 'b'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       leave 114
    inc  L              ; 1:4       leave 114
    inc  HL             ; 1:6       leave 114
    inc  L              ; 1:4       leave 114
    jp   leave114       ;           leave 114          
    exx                 ; 1:4       loop 114
    ld    E,(HL)        ; 1:7       loop 114
    inc   L             ; 1:4       loop 114
    ld    D,(HL)        ; 1:7       loop 114 DE = index   
    inc  HL             ; 1:6       loop 114
    inc  DE             ; 1:6       loop 114 index++
    ld    A,(HL)        ; 1:4       loop 114
    xor   E             ; 1:4       loop 114 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 114
    ld    A, D          ; 1:4       loop 114
    inc   L             ; 1:4       loop 114
    xor (HL)            ; 1:7       loop 114 hi index - stop
    jr    z, leave114   ; 2:7/12    loop 114 exit    
    dec   L             ; 1:4       loop 114
    dec  HL             ; 1:6       loop 114
    ld  (HL), D         ; 1:7       loop 114
    dec   L             ; 1:4       loop 114
    ld  (HL), E         ; 1:7       loop 114
    exx                 ; 1:4       loop 114
    jp   do114          ; 3:10      loop 114
leave114:
    inc  HL             ; 1:6       loop 114
    exx                 ; 1:4       loop 114
exit114 EQU $ 
                   

    exx                 ; 1:4       xdo(0,0) 115
    dec  HL             ; 1:6       xdo(0,0) 115
    ld  (HL),high 0     ; 2:10      xdo(0,0) 115
    dec   L             ; 1:4       xdo(0,0) 115
    ld  (HL),low 0      ; 2:10      xdo(0,0) 115
    exx                 ; 1:4       xdo(0,0) 115 R:( -- 0 )
xdo115:                 ;           xdo(0,0) 115         
    ld    A, 'c'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xleave 115
    inc  L              ; 1:4       xleave 115
    jp   xleave115      ;           xleave 115         
    exx                 ; 1:4       xloop(0,0) 115
    ld    E,(HL)        ; 1:7       xloop(0,0) 115
    inc   L             ; 1:4       xloop(0,0) 115
    ld    D,(HL)        ; 1:7       xloop(0,0) 115
    inc  DE             ; 1:6       xloop(0,0) 115 index++
    ld    A, low 0      ; 2:7       xloop(0,0) 115
    xor   E             ; 1:4       xloop(0,0) 115
    jr   nz, $+7        ; 2:7/12    xloop(0,0) 115
    ld    A, high 0     ; 2:7       xloop(0,0) 115
    xor   D             ; 1:4       xloop(0,0) 115
    jr    z, xleave115  ; 2:7/12    xloop(0,0) 115 exit
    ld  (HL), D         ; 1:7       xloop(0,0) 115
    dec   L             ; 1:4       xloop(0,0) 115
    ld  (HL), E         ; 1:6       xloop(0,0) 115
    exx                 ; 1:4       xloop(0,0) 115
    jp   xdo115         ; 3:10      xloop(0,0) 115
xleave115:              ;           xloop(0,0) 115
    inc  HL             ; 1:6       xloop(0,0) 115
    exx                 ; 1:4       xloop(0,0) 115 R:( index -- )
xexit115 EQU $ 
                   

    exx                 ; 1:4       xdo(254,254) 116
    dec  HL             ; 1:6       xdo(254,254) 116
    ld  (HL),high 254   ; 2:10      xdo(254,254) 116
    dec   L             ; 1:4       xdo(254,254) 116
    ld  (HL),low 254    ; 2:10      xdo(254,254) 116
    exx                 ; 1:4       xdo(254,254) 116 R:( -- 254 )
xdo116:                 ;           xdo(254,254) 116     
    ld    A, 'd'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xleave 116
    inc  L              ; 1:4       xleave 116
    jp   xleave116      ;           xleave 116         
    exx                 ; 1:4       xloop(254,254) 116
    ld    E,(HL)        ; 1:7       xloop(254,254) 116
    inc   L             ; 1:4       xloop(254,254) 116
    ld    D,(HL)        ; 1:7       xloop(254,254) 116
    inc  DE             ; 1:6       xloop(254,254) 116 index++
    ld    A, low 254    ; 2:7       xloop(254,254) 116
    xor   E             ; 1:4       xloop(254,254) 116
    jr   nz, $+7        ; 2:7/12    xloop(254,254) 116
    ld    A, high 254   ; 2:7       xloop(254,254) 116
    xor   D             ; 1:4       xloop(254,254) 116
    jr    z, xleave116  ; 2:7/12    xloop(254,254) 116 exit
    ld  (HL), D         ; 1:7       xloop(254,254) 116
    dec   L             ; 1:4       xloop(254,254) 116
    ld  (HL), E         ; 1:6       xloop(254,254) 116
    exx                 ; 1:4       xloop(254,254) 116
    jp   xdo116         ; 3:10      xloop(254,254) 116
xleave116:              ;           xloop(254,254) 116
    inc  HL             ; 1:6       xloop(254,254) 116
    exx                 ; 1:4       xloop(254,254) 116 R:( index -- )
xexit116 EQU $ 
                   

    exx                 ; 1:4       xdo(255,255) 117
    dec  HL             ; 1:6       xdo(255,255) 117
    ld  (HL),high 255   ; 2:10      xdo(255,255) 117
    dec   L             ; 1:4       xdo(255,255) 117
    ld  (HL),low 255    ; 2:10      xdo(255,255) 117
    exx                 ; 1:4       xdo(255,255) 117 R:( -- 255 )
xdo117:                 ;           xdo(255,255) 117     
    ld    A, 'e'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xleave 117
    inc  L              ; 1:4       xleave 117
    jp   xleave117      ;           xleave 117         
    exx                 ; 1:4       xloop(255,255) 117
    ld    E,(HL)        ; 1:7       xloop(255,255) 117
    inc   L             ; 1:4       xloop(255,255) 117
    ld    D,(HL)        ; 1:7       xloop(255,255) 117
    inc  DE             ; 1:6       xloop(255,255) 117 index++
    ld    A, low 255    ; 2:7       xloop(255,255) 117
    xor   E             ; 1:4       xloop(255,255) 117
    jr   nz, $+7        ; 2:7/12    xloop(255,255) 117
    ld    A, high 255   ; 2:7       xloop(255,255) 117
    xor   D             ; 1:4       xloop(255,255) 117
    jr    z, xleave117  ; 2:7/12    xloop(255,255) 117 exit
    ld  (HL), D         ; 1:7       xloop(255,255) 117
    dec   L             ; 1:4       xloop(255,255) 117
    ld  (HL), E         ; 1:6       xloop(255,255) 117
    exx                 ; 1:4       xloop(255,255) 117
    jp   xdo117         ; 3:10      xloop(255,255) 117
xleave117:              ;           xloop(255,255) 117
    inc  HL             ; 1:6       xloop(255,255) 117
    exx                 ; 1:4       xloop(255,255) 117 R:( index -- )
xexit117 EQU $ 
                   

    exx                 ; 1:4       xdo(256,256) 118
    dec  HL             ; 1:6       xdo(256,256) 118
    ld  (HL),high 256   ; 2:10      xdo(256,256) 118
    dec   L             ; 1:4       xdo(256,256) 118
    ld  (HL),low 256    ; 2:10      xdo(256,256) 118
    exx                 ; 1:4       xdo(256,256) 118 R:( -- 256 )
xdo118:                 ;           xdo(256,256) 118     
    ld    A, 'f'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xleave 118
    inc  L              ; 1:4       xleave 118
    jp   xleave118      ;           xleave 118         
    exx                 ; 1:4       xloop(256,256) 118
    ld    E,(HL)        ; 1:7       xloop(256,256) 118
    inc   L             ; 1:4       xloop(256,256) 118
    ld    D,(HL)        ; 1:7       xloop(256,256) 118
    inc  DE             ; 1:6       xloop(256,256) 118 index++
    ld    A, low 256    ; 2:7       xloop(256,256) 118
    xor   E             ; 1:4       xloop(256,256) 118
    jr   nz, $+7        ; 2:7/12    xloop(256,256) 118
    ld    A, high 256   ; 2:7       xloop(256,256) 118
    xor   D             ; 1:4       xloop(256,256) 118
    jr    z, xleave118  ; 2:7/12    xloop(256,256) 118 exit
    ld  (HL), D         ; 1:7       xloop(256,256) 118
    dec   L             ; 1:4       xloop(256,256) 118
    ld  (HL), E         ; 1:6       xloop(256,256) 118
    exx                 ; 1:4       xloop(256,256) 118
    jp   xdo118         ; 3:10      xloop(256,256) 118
xleave118:              ;           xloop(256,256) 118
    inc  HL             ; 1:6       xloop(256,256) 118
    exx                 ; 1:4       xloop(256,256) 118 R:( index -- )
xexit118 EQU $
    
    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)     

sdo119:                 ;           sdo 119 ( stop index -- stop index )              
    ld    A, 'g'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   sleave119      ; 3:10      sleave 119         
    inc  HL             ; 1:6       sloop 119 index++
    ld    A, E          ; 1:4       sloop 119
    xor   L             ; 1:4       sloop 119 lo index - stop
    jp   nz, sdo119     ; 3:10      sloop 119
    ld    A, D          ; 1:4       sloop 119
    xor   H             ; 1:4       sloop 119 hi index - stop
    jp   nz, sdo119     ; 3:10      sloop 119
sleave119:              ;           sloop 119
    pop  HL             ; 1:10      unsloop 119 index out
    pop  DE             ; 1:10      unsloop 119 stop  out
 
    
    push DE             ; 1:11      push2(254,254)
    ld   DE, 254        ; 3:10      push2(254,254)
    push HL             ; 1:11      push2(254,254)
    ld   HL, 254        ; 3:10      push2(254,254) 

sdo120:                 ;           sdo 120 ( stop index -- stop index )              
    ld    A, 'h'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   sleave120      ; 3:10      sleave 120         
    inc  HL             ; 1:6       sloop 120 index++
    ld    A, E          ; 1:4       sloop 120
    xor   L             ; 1:4       sloop 120 lo index - stop
    jp   nz, sdo120     ; 3:10      sloop 120
    ld    A, D          ; 1:4       sloop 120
    xor   H             ; 1:4       sloop 120 hi index - stop
    jp   nz, sdo120     ; 3:10      sloop 120
sleave120:              ;           sloop 120
    pop  HL             ; 1:10      unsloop 120 index out
    pop  DE             ; 1:10      unsloop 120 stop  out
 
    
    push DE             ; 1:11      push2(255,255)
    ld   DE, 255        ; 3:10      push2(255,255)
    push HL             ; 1:11      push2(255,255)
    ld   HL, 255        ; 3:10      push2(255,255) 

sdo121:                 ;           sdo 121 ( stop index -- stop index )              
    ld    A, 'i'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   sleave121      ; 3:10      sleave 121         
    inc  HL             ; 1:6       sloop 121 index++
    ld    A, E          ; 1:4       sloop 121
    xor   L             ; 1:4       sloop 121 lo index - stop
    jp   nz, sdo121     ; 3:10      sloop 121
    ld    A, D          ; 1:4       sloop 121
    xor   H             ; 1:4       sloop 121 hi index - stop
    jp   nz, sdo121     ; 3:10      sloop 121
sleave121:              ;           sloop 121
    pop  HL             ; 1:10      unsloop 121 index out
    pop  DE             ; 1:10      unsloop 121 stop  out
 
    
    push DE             ; 1:11      push2(256,256)
    ld   DE, 256        ; 3:10      push2(256,256)
    push HL             ; 1:11      push2(256,256)
    ld   HL, 256        ; 3:10      push2(256,256) 

sdo122:                 ;           sdo 122 ( stop index -- stop index )              
    ld    A, 'j'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   sleave122      ; 3:10      sleave 122         
    inc  HL             ; 1:6       sloop 122 index++
    ld    A, E          ; 1:4       sloop 122
    xor   L             ; 1:4       sloop 122 lo index - stop
    jp   nz, sdo122     ; 3:10      sloop 122
    ld    A, D          ; 1:4       sloop 122
    xor   H             ; 1:4       sloop 122 hi index - stop
    jp   nz, sdo122     ; 3:10      sloop 122
sleave122:              ;           sloop 122
    pop  HL             ; 1:10      unsloop 122 index out
    pop  DE             ; 1:10      unsloop 122 stop  out

                   

    exx                 ; 1:4       xdo(60000,60000) 123
    dec  HL             ; 1:6       xdo(60000,60000) 123
    ld  (HL),high 60000 ; 2:10      xdo(60000,60000) 123
    dec   L             ; 1:4       xdo(60000,60000) 123
    ld  (HL),low 60000  ; 2:10      xdo(60000,60000) 123
    exx                 ; 1:4       xdo(60000,60000) 123 R:( -- 60000 )
xdo123:                 ;           xdo(60000,60000) 123 
    ld    A, 'k'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xleave 123
    inc  L              ; 1:4       xleave 123
    jp   xleave123      ;           xleave 123 
    exx                 ; 1:4       push_addxloop(5000) 123
    ld    E,(HL)        ; 1:7       push_addxloop(5000) 123
    inc   L             ; 1:4       push_addxloop(5000) 123
    ld    D,(HL)        ; 1:7       push_addxloop(5000) 123 DE = index
    push HL             ; 1:11      push_addxloop(5000) 123
    ld   HL, -60000     ; 3:10      push_addxloop(5000) 123 HL = -stop = -(60000)
    add  HL, DE         ; 1:11      push_addxloop(5000) 123 index-stop
    ld   BC, 5000       ; 3:10      push_addxloop(5000) 123 BC = step
    add  HL, BC         ; 1:11      push_addxloop(5000) 123 index-stop+step
    jr    c, xleave123-1; 2:7/12    push_addxloop(5000) 123 +step
    ex   DE, HL         ; 1:4       push_addxloop(5000) 123
    add  HL, BC         ; 1:11      push_addxloop(5000) 123 index+step
    ex   DE, HL         ; 1:4       push_addxloop(5000) 123    
    pop  HL             ; 1:10      push_addxloop(5000) 123
    ld  (HL),D          ; 1:7       push_addxloop(5000) 123
    dec   L             ; 1:4       push_addxloop(5000) 123
    ld  (HL),E          ; 1:7       push_addxloop(5000) 123
    exx                 ; 1:4       push_addxloop(5000) 123    
    jp   xdo123         ; 3:10      push_addxloop(5000) 123 ( -- ) R:( index -- index+5000 )
    pop  HL             ; 1:10      push_addxloop(5000) 123
xleave123:              ;           push_addxloop(5000) 123    
    inc  HL             ; 1:6       push_addxloop(5000) 123    
    exx                 ; 1:4       push_addxloop(5000) 123 ( -- ) R:( index -- )
xexit123 EQU $
                   

    exx                 ; 1:4       xdo(60000,60000) 124
    dec  HL             ; 1:6       xdo(60000,60000) 124
    ld  (HL),high 60000 ; 2:10      xdo(60000,60000) 124
    dec   L             ; 1:4       xdo(60000,60000) 124
    ld  (HL),low 60000  ; 2:10      xdo(60000,60000) 124
    exx                 ; 1:4       xdo(60000,60000) 124 R:( -- 60000 )
xdo124:                 ;           xdo(60000,60000) 124 
    ld    A, 'l'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xleave 124
    inc  L              ; 1:4       xleave 124
    jp   xleave124      ;           xleave 124 
    exx                 ; 1:4       push_addxloop(3100) 124
    ld    E,(HL)        ; 1:7       push_addxloop(3100) 124
    inc   L             ; 1:4       push_addxloop(3100) 124
    ld    D,(HL)        ; 1:7       push_addxloop(3100) 124 DE = index
    push HL             ; 1:11      push_addxloop(3100) 124
    ld   HL, -60000     ; 3:10      push_addxloop(3100) 124 HL = -stop = -(60000)
    add  HL, DE         ; 1:11      push_addxloop(3100) 124 index-stop
    ld   BC, 3100       ; 3:10      push_addxloop(3100) 124 BC = step
    add  HL, BC         ; 1:11      push_addxloop(3100) 124 index-stop+step
    jr    c, xleave124-1; 2:7/12    push_addxloop(3100) 124 +step
    ex   DE, HL         ; 1:4       push_addxloop(3100) 124
    add  HL, BC         ; 1:11      push_addxloop(3100) 124 index+step
    ex   DE, HL         ; 1:4       push_addxloop(3100) 124    
    pop  HL             ; 1:10      push_addxloop(3100) 124
    ld  (HL),D          ; 1:7       push_addxloop(3100) 124
    dec   L             ; 1:4       push_addxloop(3100) 124
    ld  (HL),E          ; 1:7       push_addxloop(3100) 124
    exx                 ; 1:4       push_addxloop(3100) 124    
    jp   xdo124         ; 3:10      push_addxloop(3100) 124 ( -- ) R:( index -- index+3100 )
    pop  HL             ; 1:10      push_addxloop(3100) 124
xleave124:              ;           push_addxloop(3100) 124    
    inc  HL             ; 1:6       push_addxloop(3100) 124    
    exx                 ; 1:4       push_addxloop(3100) 124 ( -- ) R:( index -- )
xexit124 EQU $

    
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(12,3)
    ld   DE, 12         ; 3:10      push2(12,3)
    push HL             ; 1:11      push2(12,3)
    ld   HL, 3          ; 3:10      push2(12,3)  
    push HL             ; 1:11      do 125 index
    push DE             ; 1:11      do 125 stop
    exx                 ; 1:4       do 125
    pop  DE             ; 1:10      do 125 stop
    dec  HL             ; 1:6       do 125
    ld  (HL),D          ; 1:7       do 125
    dec  L              ; 1:4       do 125
    ld  (HL),E          ; 1:7       do 125 stop
    pop  DE             ; 1:10      do 125 index
    dec  HL             ; 1:6       do 125
    ld  (HL),D          ; 1:7       do 125
    dec  L              ; 1:4       do 125
    ld  (HL),E          ; 1:7       do 125 index
    exx                 ; 1:4       do 125
    pop  HL             ; 1:10      do 125
    pop  DE             ; 1:10      do 125 ( stop index -- ) R: ( -- stop index )
do125:         
    exx                 ; 1:4       index 125 i    
    ld    E,(HL)        ; 1:7       index 125 i
    inc   L             ; 1:4       index 125 i
    ld    D,(HL)        ; 1:7       index 125 i
    push DE             ; 1:11      index 125 i
    dec   L             ; 1:4       index 125 i
    exx                 ; 1:4       index 125 i
    ex   DE, HL         ; 1:4       index 125 i
    ex  (SP),HL         ; 1:19      index 125 i 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else101    ; 3:10      if 
    exx                 ; 1:4       leave 125
    inc  L              ; 1:4       leave 125
    inc  HL             ; 1:6       leave 125
    inc  L              ; 1:4       leave 125
    jp   leave125       ;           leave 125 
else101  EQU $          ;           = endif
endif101:          
    exx                 ; 1:4       loop 125
    ld    E,(HL)        ; 1:7       loop 125
    inc   L             ; 1:4       loop 125
    ld    D,(HL)        ; 1:7       loop 125 DE = index   
    inc  HL             ; 1:6       loop 125
    inc  DE             ; 1:6       loop 125 index++
    ld    A,(HL)        ; 1:4       loop 125
    xor   E             ; 1:4       loop 125 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 125
    ld    A, D          ; 1:4       loop 125
    inc   L             ; 1:4       loop 125
    xor (HL)            ; 1:7       loop 125 hi index - stop
    jr    z, leave125   ; 2:7/12    loop 125 exit    
    dec   L             ; 1:4       loop 125
    dec  HL             ; 1:6       loop 125
    ld  (HL), D         ; 1:7       loop 125
    dec   L             ; 1:4       loop 125
    ld  (HL), E         ; 1:7       loop 125
    exx                 ; 1:4       loop 125
    jp   do125          ; 3:10      loop 125
leave125:
    inc  HL             ; 1:6       loop 125
    exx                 ; 1:4       loop 125
exit125 EQU $    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(12,3)
    ld   DE, 12         ; 3:10      push2(12,3)
    push HL             ; 1:11      push2(12,3)
    ld   HL, 3          ; 3:10      push2(12,3) 

sdo126:                 ;           sdo 126 ( stop index -- stop index )        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else102    ; 3:10      if 
    jp   sleave126      ; 3:10      sleave 126 
else102  EQU $          ;           = endif
endif102:         
    inc  HL             ; 1:6       sloop 126 index++
    ld    A, E          ; 1:4       sloop 126
    xor   L             ; 1:4       sloop 126 lo index - stop
    jp   nz, sdo126     ; 3:10      sloop 126
    ld    A, D          ; 1:4       sloop 126
    xor   H             ; 1:4       sloop 126 hi index - stop
    jp   nz, sdo126     ; 3:10      sloop 126
sleave126:              ;           sloop 126
    pop  HL             ; 1:10      unsloop 126 index out
    pop  DE             ; 1:10      unsloop 126 stop  out
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                

    exx                 ; 1:4       xdo(12,3) 127
    dec  HL             ; 1:6       xdo(12,3) 127
    ld  (HL),high 3     ; 2:10      xdo(12,3) 127
    dec   L             ; 1:4       xdo(12,3) 127
    ld  (HL),low 3      ; 2:10      xdo(12,3) 127
    exx                 ; 1:4       xdo(12,3) 127 R:( -- 3 )
xdo127:                 ;           xdo(12,3) 127  
    exx                 ; 1:4       index xi 127
    ld    E,(HL)        ; 1:7       index xi 127
    inc   L             ; 1:4       index xi 127
    ld    D,(HL)        ; 1:7       index xi 127
    push DE             ; 1:11      index xi 127
    dec   L             ; 1:4       index xi 127
    exx                 ; 1:4       index xi 127 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 127
    ex  (SP),HL         ; 1:19      index xi 127 ( -- x ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else103    ; 3:10      if 
    exx                 ; 1:4       xleave 127
    inc  L              ; 1:4       xleave 127
    jp   xleave127      ;           xleave 127 
else103  EQU $          ;           = endif
endif103:         
    exx                 ; 1:4       xloop(12,3) 127
    ld    E,(HL)        ; 1:7       xloop(12,3) 127
    inc   L             ; 1:4       xloop(12,3) 127
    ld    D,(HL)        ; 1:7       xloop(12,3) 127
    inc  DE             ; 1:6       xloop(12,3) 127 index++
    ld    A, low 12     ; 2:7       xloop(12,3) 127
    xor   E             ; 1:4       xloop(12,3) 127
    jr   nz, $+7        ; 2:7/12    xloop(12,3) 127
    ld    A, high 12    ; 2:7       xloop(12,3) 127
    xor   D             ; 1:4       xloop(12,3) 127
    jr    z, xleave127  ; 2:7/12    xloop(12,3) 127 exit
    ld  (HL), D         ; 1:7       xloop(12,3) 127
    dec   L             ; 1:4       xloop(12,3) 127
    ld  (HL), E         ; 1:6       xloop(12,3) 127
    exx                 ; 1:4       xloop(12,3) 127
    jp   xdo127         ; 3:10      xloop(12,3) 127
xleave127:              ;           xloop(12,3) 127
    inc  HL             ; 1:6       xloop(12,3) 127
    exx                 ; 1:4       xloop(12,3) 127 R:( index -- )
xexit127 EQU $    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                

    exx                 ; 1:4       xdo(550,3) 128
    dec  HL             ; 1:6       xdo(550,3) 128
    ld  (HL),high 3     ; 2:10      xdo(550,3) 128
    dec   L             ; 1:4       xdo(550,3) 128
    ld  (HL),low 3      ; 2:10      xdo(550,3) 128
    exx                 ; 1:4       xdo(550,3) 128 R:( -- 3 )
xdo128:                 ;           xdo(550,3) 128 
    exx                 ; 1:4       index xi 128
    ld    E,(HL)        ; 1:7       index xi 128
    inc   L             ; 1:4       index xi 128
    ld    D,(HL)        ; 1:7       index xi 128
    push DE             ; 1:11      index xi 128
    dec   L             ; 1:4       index xi 128
    exx                 ; 1:4       index xi 128 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 128
    ex  (SP),HL         ; 1:19      index xi 128 ( -- x ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else104    ; 3:10      if 
    exx                 ; 1:4       xleave 128
    inc  L              ; 1:4       xleave 128
    jp   xleave128      ;           xleave 128 
else104  EQU $          ;           = endif
endif104:         
    exx                 ; 1:4       xloop(550,3) 128
    ld    E,(HL)        ; 1:7       xloop(550,3) 128
    inc   L             ; 1:4       xloop(550,3) 128
    ld    D,(HL)        ; 1:7       xloop(550,3) 128
    inc  DE             ; 1:6       xloop(550,3) 128 index++
    ld    A, low 550    ; 2:7       xloop(550,3) 128
    xor   E             ; 1:4       xloop(550,3) 128
    jr   nz, $+7        ; 2:7/12    xloop(550,3) 128
    ld    A, high 550   ; 2:7       xloop(550,3) 128
    xor   D             ; 1:4       xloop(550,3) 128
    jr    z, xleave128  ; 2:7/12    xloop(550,3) 128 exit
    ld  (HL), D         ; 1:7       xloop(550,3) 128
    dec   L             ; 1:4       xloop(550,3) 128
    ld  (HL), E         ; 1:6       xloop(550,3) 128
    exx                 ; 1:4       xloop(550,3) 128
    jp   xdo128         ; 3:10      xloop(550,3) 128
xleave128:              ;           xloop(550,3) 128
    inc  HL             ; 1:6       xloop(550,3) 128
    exx                 ; 1:4       xloop(550,3) 128 R:( index -- )
xexit128 EQU $    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                

    exx                 ; 1:4       xdo(12,3) 129
    dec  HL             ; 1:6       xdo(12,3) 129
    ld  (HL),high 3     ; 2:10      xdo(12,3) 129
    dec   L             ; 1:4       xdo(12,3) 129
    ld  (HL),low 3      ; 2:10      xdo(12,3) 129
    exx                 ; 1:4       xdo(12,3) 129 R:( -- 3 )
xdo129:                 ;           xdo(12,3) 129  
    exx                 ; 1:4       index xi 129
    ld    E,(HL)        ; 1:7       index xi 129
    inc   L             ; 1:4       index xi 129
    ld    D,(HL)        ; 1:7       index xi 129
    push DE             ; 1:11      index xi 129
    dec   L             ; 1:4       index xi 129
    exx                 ; 1:4       index xi 129 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 129
    ex  (SP),HL         ; 1:19      index xi 129 ( -- x ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else105    ; 3:10      if 
    exx                 ; 1:4       xleave 129
    inc  L              ; 1:4       xleave 129
    jp   xleave129      ;           xleave 129 
else105  EQU $          ;           = endif
endif105: 
                        ;           push_addxloop(2) 129
    exx                 ; 1:4       2 +xloop 129
    ld    E,(HL)        ; 1:7       2 +xloop 129
    inc   L             ; 1:4       2 +xloop 129
    ld    D,(HL)        ; 1:7       2 +xloop 129 DE = index
    inc  DE             ; 1:6       2 +xloop 129
    inc  DE             ; 1:6       2 +xloop 129 DE = index+2
    ld    A, E          ; 1:4       2 +xloop 129    
    sub  low 12         ; 2:7       2 +xloop 129 lo index+2-stop
    rra                 ; 1:4       2 +xloop 129
    add   A, A          ; 1:4       2 +xloop 129 and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +xloop 129
    ld    A, D          ; 1:4       2 +xloop 129
    sbc   A, high 12    ; 2:7       2 +xloop 129 lo index+2-stop
    jr    z, xleave129  ; 2:7/12    2 +xloop 129
    ld  (HL),D          ; 1:7       2 +xloop 129
    dec   L             ; 1:4       2 +xloop 129
    ld  (HL),E          ; 1:7       2 +xloop 129
    exx                 ; 1:4       2 +xloop 129
    jp    p, xdo129     ; 3:10      2 +xloop 129 ( -- ) R:( stop index -- stop index+ )
xleave129:              ;           2 +xloop 129
    inc  HL             ; 1:6       2 +xloop 129
    exx                 ; 1:4       2 +xloop 129
xexit129 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                

    exx                 ; 1:4       xdo(550,3) 130
    dec  HL             ; 1:6       xdo(550,3) 130
    ld  (HL),high 3     ; 2:10      xdo(550,3) 130
    dec   L             ; 1:4       xdo(550,3) 130
    ld  (HL),low 3      ; 2:10      xdo(550,3) 130
    exx                 ; 1:4       xdo(550,3) 130 R:( -- 3 )
xdo130:                 ;           xdo(550,3) 130 
    exx                 ; 1:4       index xi 130
    ld    E,(HL)        ; 1:7       index xi 130
    inc   L             ; 1:4       index xi 130
    ld    D,(HL)        ; 1:7       index xi 130
    push DE             ; 1:11      index xi 130
    dec   L             ; 1:4       index xi 130
    exx                 ; 1:4       index xi 130 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 130
    ex  (SP),HL         ; 1:19      index xi 130 ( -- x ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else106    ; 3:10      if 
    exx                 ; 1:4       xleave 130
    inc  L              ; 1:4       xleave 130
    jp   xleave130      ;           xleave 130 
else106  EQU $          ;           = endif
endif106: 
                        ;           push_addxloop(2) 130
    exx                 ; 1:4       2 +xloop 130
    ld    E,(HL)        ; 1:7       2 +xloop 130
    inc   L             ; 1:4       2 +xloop 130
    ld    D,(HL)        ; 1:7       2 +xloop 130 DE = index
    inc  DE             ; 1:6       2 +xloop 130
    inc  DE             ; 1:6       2 +xloop 130 DE = index+2
    ld    A, E          ; 1:4       2 +xloop 130    
    sub  low 550        ; 2:7       2 +xloop 130 lo index+2-stop
    rra                 ; 1:4       2 +xloop 130
    add   A, A          ; 1:4       2 +xloop 130 and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +xloop 130
    ld    A, D          ; 1:4       2 +xloop 130
    sbc   A, high 550   ; 2:7       2 +xloop 130 lo index+2-stop
    jr    z, xleave130  ; 2:7/12    2 +xloop 130
    ld  (HL),D          ; 1:7       2 +xloop 130
    dec   L             ; 1:4       2 +xloop 130
    ld  (HL),E          ; 1:7       2 +xloop 130
    exx                 ; 1:4       2 +xloop 130
    jp    p, xdo130     ; 3:10      2 +xloop 130 ( -- ) R:( stop index -- stop index+ )
xleave130:              ;           2 +xloop 130
    inc  HL             ; 1:6       2 +xloop 130
    exx                 ; 1:4       2 +xloop 130
xexit130 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(12)
    ex   DE, HL         ; 1:4       push(12)
    ld   HL, 12         ; 3:10      push(12)    
    push HL             ; 1:11      for 131 index
    exx                 ; 1:4       for 131
    pop  DE             ; 1:10      for 131 stop
    dec  HL             ; 1:6       for 131
    ld  (HL),D          ; 1:7       for 131
    dec  L              ; 1:4       for 131
    ld  (HL),E          ; 1:7       for 131 stop
    exx                 ; 1:4       for 131
    ex   DE, HL         ; 1:4       for 131
    pop  DE             ; 1:10      for 131 ( index -- ) R: ( -- index )
for131:                 ;           for 131         
    exx                 ; 1:4       index 131 i    
    ld    E,(HL)        ; 1:7       index 131 i
    inc   L             ; 1:4       index 131 i
    ld    D,(HL)        ; 1:7       index 131 i
    push DE             ; 1:11      index 131 i
    dec   L             ; 1:4       index 131 i
    exx                 ; 1:4       index 131 i
    ex   DE, HL         ; 1:4       index 131 i
    ex  (SP),HL         ; 1:19      index 131 i 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else107    ; 3:10      if 
    exx                 ; 1:4       for leave 131
    inc  L              ; 1:4       for leave 131
    jp   next131       ;           for leave 131 
else107  EQU $          ;           = endif
endif107:          
    exx                 ; 1:4       next 131
    ld    E,(HL)        ; 1:7       next 131
    inc   L             ; 1:4       next 131
    ld    D,(HL)        ; 1:7       next 131 DE = index   
    ld    A, E          ; 1:4       next 131
    or    D             ; 1:4       next 131
    jr    z, next131    ; 2:7/12    next 131 exit
    dec  DE             ; 1:6       next 131 index--
    ld  (HL),D          ; 1:7       next 131
    dec   L             ; 1:4       next 131
    ld  (HL),E          ; 1:7       next 131
    exx                 ; 1:4       next 131
    jp   for131         ; 3:10      next 131
next131:                ;           next 131
    inc  HL             ; 1:6       next 131
    exx                 ; 1:4       next 131    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(12)
    ex   DE, HL         ; 1:4       push(12)
    ld   HL, 12         ; 3:10      push(12)   
sfor132:                ;           sfor 132 ( index -- index )        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else108    ; 3:10      if 
    jp   snext132       ; 3:10      sfor leave 132 
else108  EQU $          ;           = endif
endif108:         
    ld   A, H           ; 1:4       snext 132
    or   L              ; 1:4       snext 132
    dec  HL             ; 1:6       snext 132 index--
    jp  nz, sfor132     ; 3:10      snext 132
snext132:               ;           snext 132
    ex   DE, HL         ; 1:4       sfor unloop 132
    pop  DE             ; 1:10      sfor unloop 132    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(1,0)
    ld   DE, 1          ; 3:10      push2(1,0)
    push HL             ; 1:11      push2(1,0)
    ld   HL, 0          ; 3:10      push2(1,0) 
    push HL             ; 1:11      do 133 index
    push DE             ; 1:11      do 133 stop
    exx                 ; 1:4       do 133
    pop  DE             ; 1:10      do 133 stop
    dec  HL             ; 1:6       do 133
    ld  (HL),D          ; 1:7       do 133
    dec  L              ; 1:4       do 133
    ld  (HL),E          ; 1:7       do 133 stop
    pop  DE             ; 1:10      do 133 index
    dec  HL             ; 1:6       do 133
    ld  (HL),D          ; 1:7       do 133
    dec  L              ; 1:4       do 133
    ld  (HL),E          ; 1:7       do 133 index
    exx                 ; 1:4       do 133
    pop  HL             ; 1:10      do 133
    pop  DE             ; 1:10      do 133 ( stop index -- ) R: ( -- stop index )
do133: 
    ld    A, 'a'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       loop 133
    ld    E,(HL)        ; 1:7       loop 133
    inc   L             ; 1:4       loop 133
    ld    D,(HL)        ; 1:7       loop 133 DE = index   
    inc  HL             ; 1:6       loop 133
    inc  DE             ; 1:6       loop 133 index++
    ld    A,(HL)        ; 1:4       loop 133
    xor   E             ; 1:4       loop 133 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 133
    ld    A, D          ; 1:4       loop 133
    inc   L             ; 1:4       loop 133
    xor (HL)            ; 1:7       loop 133 hi index - stop
    jr    z, leave133   ; 2:7/12    loop 133 exit    
    dec   L             ; 1:4       loop 133
    dec  HL             ; 1:6       loop 133
    ld  (HL), D         ; 1:7       loop 133
    dec   L             ; 1:4       loop 133
    ld  (HL), E         ; 1:7       loop 133
    exx                 ; 1:4       loop 133
    jp   do133          ; 3:10      loop 133
leave133:
    inc  HL             ; 1:6       loop 133
    exx                 ; 1:4       loop 133
exit133 EQU $ 
    
    push DE             ; 1:11      push2(255,254)
    ld   DE, 255        ; 3:10      push2(255,254)
    push HL             ; 1:11      push2(255,254)
    ld   HL, 254        ; 3:10      push2(255,254) 
    push HL             ; 1:11      do 134 index
    push DE             ; 1:11      do 134 stop
    exx                 ; 1:4       do 134
    pop  DE             ; 1:10      do 134 stop
    dec  HL             ; 1:6       do 134
    ld  (HL),D          ; 1:7       do 134
    dec  L              ; 1:4       do 134
    ld  (HL),E          ; 1:7       do 134 stop
    pop  DE             ; 1:10      do 134 index
    dec  HL             ; 1:6       do 134
    ld  (HL),D          ; 1:7       do 134
    dec  L              ; 1:4       do 134
    ld  (HL),E          ; 1:7       do 134 index
    exx                 ; 1:4       do 134
    pop  HL             ; 1:10      do 134
    pop  DE             ; 1:10      do 134 ( stop index -- ) R: ( -- stop index )
do134: 
    ld    A, 'b'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       loop 134
    ld    E,(HL)        ; 1:7       loop 134
    inc   L             ; 1:4       loop 134
    ld    D,(HL)        ; 1:7       loop 134 DE = index   
    inc  HL             ; 1:6       loop 134
    inc  DE             ; 1:6       loop 134 index++
    ld    A,(HL)        ; 1:4       loop 134
    xor   E             ; 1:4       loop 134 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 134
    ld    A, D          ; 1:4       loop 134
    inc   L             ; 1:4       loop 134
    xor (HL)            ; 1:7       loop 134 hi index - stop
    jr    z, leave134   ; 2:7/12    loop 134 exit    
    dec   L             ; 1:4       loop 134
    dec  HL             ; 1:6       loop 134
    ld  (HL), D         ; 1:7       loop 134
    dec   L             ; 1:4       loop 134
    ld  (HL), E         ; 1:7       loop 134
    exx                 ; 1:4       loop 134
    jp   do134          ; 3:10      loop 134
leave134:
    inc  HL             ; 1:6       loop 134
    exx                 ; 1:4       loop 134
exit134 EQU $ 
    

    exx                 ; 1:4       xdo(1,0) 135
    dec  HL             ; 1:6       xdo(1,0) 135
    ld  (HL),high 0     ; 2:10      xdo(1,0) 135
    dec   L             ; 1:4       xdo(1,0) 135
    ld  (HL),low 0      ; 2:10      xdo(1,0) 135
    exx                 ; 1:4       xdo(1,0) 135 R:( -- 0 )
xdo135:                 ;           xdo(1,0) 135      
    ld    A, 'c'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xloop(1,0) 135
    ld    E,(HL)        ; 1:7       xloop(1,0) 135
    inc   L             ; 1:4       xloop(1,0) 135
    ld    D,(HL)        ; 1:7       xloop(1,0) 135
    inc  DE             ; 1:6       xloop(1,0) 135 index++
    ld    A, low 1      ; 2:7       xloop(1,0) 135
    xor   E             ; 1:4       xloop(1,0) 135
    jr   nz, $+7        ; 2:7/12    xloop(1,0) 135
    ld    A, high 1     ; 2:7       xloop(1,0) 135
    xor   D             ; 1:4       xloop(1,0) 135
    jr    z, xleave135  ; 2:7/12    xloop(1,0) 135 exit
    ld  (HL), D         ; 1:7       xloop(1,0) 135
    dec   L             ; 1:4       xloop(1,0) 135
    ld  (HL), E         ; 1:6       xloop(1,0) 135
    exx                 ; 1:4       xloop(1,0) 135
    jp   xdo135         ; 3:10      xloop(1,0) 135
xleave135:              ;           xloop(1,0) 135
    inc  HL             ; 1:6       xloop(1,0) 135
    exx                 ; 1:4       xloop(1,0) 135 R:( index -- )
xexit135 EQU $ 
    

    exx                 ; 1:4       xdo(255,254) 136
    dec  HL             ; 1:6       xdo(255,254) 136
    ld  (HL),high 254   ; 2:10      xdo(255,254) 136
    dec   L             ; 1:4       xdo(255,254) 136
    ld  (HL),low 254    ; 2:10      xdo(255,254) 136
    exx                 ; 1:4       xdo(255,254) 136 R:( -- 254 )
xdo136:                 ;           xdo(255,254) 136  
    ld    A, 'd'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xloop(255,254) 136
    ld    E,(HL)        ; 1:7       xloop(255,254) 136
    inc   L             ; 1:4       xloop(255,254) 136
    ld    D,(HL)        ; 1:7       xloop(255,254) 136
    inc  DE             ; 1:6       xloop(255,254) 136 index++
    ld    A, low 255    ; 2:7       xloop(255,254) 136
    xor   E             ; 1:4       xloop(255,254) 136
    jr   nz, $+7        ; 2:7/12    xloop(255,254) 136
    ld    A, high 255   ; 2:7       xloop(255,254) 136
    xor   D             ; 1:4       xloop(255,254) 136
    jr    z, xleave136  ; 2:7/12    xloop(255,254) 136 exit
    ld  (HL), D         ; 1:7       xloop(255,254) 136
    dec   L             ; 1:4       xloop(255,254) 136
    ld  (HL), E         ; 1:6       xloop(255,254) 136
    exx                 ; 1:4       xloop(255,254) 136
    jp   xdo136         ; 3:10      xloop(255,254) 136
xleave136:              ;           xloop(255,254) 136
    inc  HL             ; 1:6       xloop(255,254) 136
    exx                 ; 1:4       xloop(255,254) 136 R:( index -- )
xexit136 EQU $ 
    

    exx                 ; 1:4       xdo(256,255) 137
    dec  HL             ; 1:6       xdo(256,255) 137
    ld  (HL),high 255   ; 2:10      xdo(256,255) 137
    dec   L             ; 1:4       xdo(256,255) 137
    ld  (HL),low 255    ; 2:10      xdo(256,255) 137
    exx                 ; 1:4       xdo(256,255) 137 R:( -- 255 )
xdo137:                 ;           xdo(256,255) 137  
    ld    A, 'e'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xloop(256,255) 137
    ld    E,(HL)        ; 1:7       xloop(256,255) 137
    inc   L             ; 1:4       xloop(256,255) 137
    ld    D,(HL)        ; 1:7       xloop(256,255) 137
    inc  DE             ; 1:6       xloop(256,255) 137 index++
    ld    A, low 256    ; 2:7       xloop(256,255) 137
    xor   E             ; 1:4       xloop(256,255) 137
    jr   nz, $+7        ; 2:7/12    xloop(256,255) 137
    ld    A, high 256   ; 2:7       xloop(256,255) 137
    xor   D             ; 1:4       xloop(256,255) 137
    jr    z, xleave137  ; 2:7/12    xloop(256,255) 137 exit
    ld  (HL), D         ; 1:7       xloop(256,255) 137
    dec   L             ; 1:4       xloop(256,255) 137
    ld  (HL), E         ; 1:6       xloop(256,255) 137
    exx                 ; 1:4       xloop(256,255) 137
    jp   xdo137         ; 3:10      xloop(256,255) 137
xleave137:              ;           xloop(256,255) 137
    inc  HL             ; 1:6       xloop(256,255) 137
    exx                 ; 1:4       xloop(256,255) 137 R:( index -- )
xexit137 EQU $ 
    

    exx                 ; 1:4       xdo(257,256) 138
    dec  HL             ; 1:6       xdo(257,256) 138
    ld  (HL),high 256   ; 2:10      xdo(257,256) 138
    dec   L             ; 1:4       xdo(257,256) 138
    ld  (HL),low 256    ; 2:10      xdo(257,256) 138
    exx                 ; 1:4       xdo(257,256) 138 R:( -- 256 )
xdo138:                 ;           xdo(257,256) 138  
    ld    A, 'f'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       xloop(257,256) 138
    ld    E,(HL)        ; 1:7       xloop(257,256) 138
    inc   L             ; 1:4       xloop(257,256) 138
    ld    D,(HL)        ; 1:7       xloop(257,256) 138
    inc  DE             ; 1:6       xloop(257,256) 138 index++
    ld    A, low 257    ; 2:7       xloop(257,256) 138
    xor   E             ; 1:4       xloop(257,256) 138
    jr   nz, $+7        ; 2:7/12    xloop(257,256) 138
    ld    A, high 257   ; 2:7       xloop(257,256) 138
    xor   D             ; 1:4       xloop(257,256) 138
    jr    z, xleave138  ; 2:7/12    xloop(257,256) 138 exit
    ld  (HL), D         ; 1:7       xloop(257,256) 138
    dec   L             ; 1:4       xloop(257,256) 138
    ld  (HL), E         ; 1:6       xloop(257,256) 138
    exx                 ; 1:4       xloop(257,256) 138
    jp   xdo138         ; 3:10      xloop(257,256) 138
xleave138:              ;           xloop(257,256) 138
    inc  HL             ; 1:6       xloop(257,256) 138
    exx                 ; 1:4       xloop(257,256) 138 R:( index -- )
xexit138 EQU $
    
    push DE             ; 1:11      push2(1,0)
    ld   DE, 1          ; 3:10      push2(1,0)
    push HL             ; 1:11      push2(1,0)
    ld   HL, 0          ; 3:10      push2(1,0)     

sdo139:                 ;           sdo 139 ( stop index -- stop index ) 
    ld    A, 'g'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    inc  HL             ; 1:6       sloop 139 index++
    ld    A, E          ; 1:4       sloop 139
    xor   L             ; 1:4       sloop 139 lo index - stop
    jp   nz, sdo139     ; 3:10      sloop 139
    ld    A, D          ; 1:4       sloop 139
    xor   H             ; 1:4       sloop 139 hi index - stop
    jp   nz, sdo139     ; 3:10      sloop 139
sleave139:              ;           sloop 139
    pop  HL             ; 1:10      unsloop 139 index out
    pop  DE             ; 1:10      unsloop 139 stop  out
 
    
    push DE             ; 1:11      push2(255,254)
    ld   DE, 255        ; 3:10      push2(255,254)
    push HL             ; 1:11      push2(255,254)
    ld   HL, 254        ; 3:10      push2(255,254) 

sdo140:                 ;           sdo 140 ( stop index -- stop index ) 
    ld    A, 'h'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    inc  HL             ; 1:6       sloop 140 index++
    ld    A, E          ; 1:4       sloop 140
    xor   L             ; 1:4       sloop 140 lo index - stop
    jp   nz, sdo140     ; 3:10      sloop 140
    ld    A, D          ; 1:4       sloop 140
    xor   H             ; 1:4       sloop 140 hi index - stop
    jp   nz, sdo140     ; 3:10      sloop 140
sleave140:              ;           sloop 140
    pop  HL             ; 1:10      unsloop 140 index out
    pop  DE             ; 1:10      unsloop 140 stop  out
 
    
    push DE             ; 1:11      push2(256,255)
    ld   DE, 256        ; 3:10      push2(256,255)
    push HL             ; 1:11      push2(256,255)
    ld   HL, 255        ; 3:10      push2(256,255) 

sdo141:                 ;           sdo 141 ( stop index -- stop index ) 
    ld    A, 'i'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    inc  HL             ; 1:6       sloop 141 index++
    ld    A, E          ; 1:4       sloop 141
    xor   L             ; 1:4       sloop 141 lo index - stop
    jp   nz, sdo141     ; 3:10      sloop 141
    ld    A, D          ; 1:4       sloop 141
    xor   H             ; 1:4       sloop 141 hi index - stop
    jp   nz, sdo141     ; 3:10      sloop 141
sleave141:              ;           sloop 141
    pop  HL             ; 1:10      unsloop 141 index out
    pop  DE             ; 1:10      unsloop 141 stop  out
 
    
    push DE             ; 1:11      push2(257,256)
    ld   DE, 257        ; 3:10      push2(257,256)
    push HL             ; 1:11      push2(257,256)
    ld   HL, 256        ; 3:10      push2(257,256) 

sdo142:                 ;           sdo 142 ( stop index -- stop index ) 
    ld    A, 'j'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    inc  HL             ; 1:6       sloop 142 index++
    ld    A, E          ; 1:4       sloop 142
    xor   L             ; 1:4       sloop 142 lo index - stop
    jp   nz, sdo142     ; 3:10      sloop 142
    ld    A, D          ; 1:4       sloop 142
    xor   H             ; 1:4       sloop 142 hi index - stop
    jp   nz, sdo142     ; 3:10      sloop 142
sleave142:              ;           sloop 142
    pop  HL             ; 1:10      unsloop 142 index out
    pop  DE             ; 1:10      unsloop 142 stop  out

    

    exx                 ; 1:4       xdo(60000,30000) 143
    dec  HL             ; 1:6       xdo(60000,30000) 143
    ld  (HL),high 30000 ; 2:10      xdo(60000,30000) 143
    dec   L             ; 1:4       xdo(60000,30000) 143
    ld  (HL),low 30000  ; 2:10      xdo(60000,30000) 143
    exx                 ; 1:4       xdo(60000,30000) 143 R:( -- 30000 )
xdo143:                 ;           xdo(60000,30000) 143 
    ld    A, 'k'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       push_addxloop(40000) 143
    ld    E,(HL)        ; 1:7       push_addxloop(40000) 143
    inc   L             ; 1:4       push_addxloop(40000) 143
    ld    D,(HL)        ; 1:7       push_addxloop(40000) 143 DE = index
    push HL             ; 1:11      push_addxloop(40000) 143
    ld   HL, -60000     ; 3:10      push_addxloop(40000) 143 HL = -stop = -(60000)
    add  HL, DE         ; 1:11      push_addxloop(40000) 143 index-stop
    ld   BC, 40000      ; 3:10      push_addxloop(40000) 143 BC = step
    add  HL, BC         ; 1:11      push_addxloop(40000) 143 index-stop+step
    jr    c, xleave143-1; 2:7/12    push_addxloop(40000) 143 +step
    ex   DE, HL         ; 1:4       push_addxloop(40000) 143
    add  HL, BC         ; 1:11      push_addxloop(40000) 143 index+step
    ex   DE, HL         ; 1:4       push_addxloop(40000) 143    
    pop  HL             ; 1:10      push_addxloop(40000) 143
    ld  (HL),D          ; 1:7       push_addxloop(40000) 143
    dec   L             ; 1:4       push_addxloop(40000) 143
    ld  (HL),E          ; 1:7       push_addxloop(40000) 143
    exx                 ; 1:4       push_addxloop(40000) 143    
    jp   xdo143         ; 3:10      push_addxloop(40000) 143 ( -- ) R:( index -- index+40000 )
    pop  HL             ; 1:10      push_addxloop(40000) 143
xleave143:              ;           push_addxloop(40000) 143    
    inc  HL             ; 1:6       push_addxloop(40000) 143    
    exx                 ; 1:4       push_addxloop(40000) 143 ( -- ) R:( index -- )
xexit143 EQU $
    

    exx                 ; 1:4       xdo(60000,30000) 144
    dec  HL             ; 1:6       xdo(60000,30000) 144
    ld  (HL),high 30000 ; 2:10      xdo(60000,30000) 144
    dec   L             ; 1:4       xdo(60000,30000) 144
    ld  (HL),low 30000  ; 2:10      xdo(60000,30000) 144
    exx                 ; 1:4       xdo(60000,30000) 144 R:( -- 30000 )
xdo144:                 ;           xdo(60000,30000) 144 
    ld    A, 'l'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    exx                 ; 1:4       push_addxloop(31000) 144
    ld    E,(HL)        ; 1:7       push_addxloop(31000) 144
    inc   L             ; 1:4       push_addxloop(31000) 144
    ld    D,(HL)        ; 1:7       push_addxloop(31000) 144 DE = index
    push HL             ; 1:11      push_addxloop(31000) 144
    ld   HL, -60000     ; 3:10      push_addxloop(31000) 144 HL = -stop = -(60000)
    add  HL, DE         ; 1:11      push_addxloop(31000) 144 index-stop
    ld   BC, 31000      ; 3:10      push_addxloop(31000) 144 BC = step
    add  HL, BC         ; 1:11      push_addxloop(31000) 144 index-stop+step
    jr    c, xleave144-1; 2:7/12    push_addxloop(31000) 144 +step
    ex   DE, HL         ; 1:4       push_addxloop(31000) 144
    add  HL, BC         ; 1:11      push_addxloop(31000) 144 index+step
    ex   DE, HL         ; 1:4       push_addxloop(31000) 144    
    pop  HL             ; 1:10      push_addxloop(31000) 144
    ld  (HL),D          ; 1:7       push_addxloop(31000) 144
    dec   L             ; 1:4       push_addxloop(31000) 144
    ld  (HL),E          ; 1:7       push_addxloop(31000) 144
    exx                 ; 1:4       push_addxloop(31000) 144    
    jp   xdo144         ; 3:10      push_addxloop(31000) 144 ( -- ) R:( index -- index+31000 )
    pop  HL             ; 1:10      push_addxloop(31000) 144
xleave144:              ;           push_addxloop(31000) 144    
    inc  HL             ; 1:6       push_addxloop(31000) 144    
    exx                 ; 1:4       push_addxloop(31000) 144 ( -- ) R:( index -- )
xexit144 EQU $

    
    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
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
stack_test:             ;           
    
    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
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
string105:
db 0xD, "Data stack OK!", 0xD
size105 EQU $ - string105
string104:
db 0xD, "RAS:"
size104 EQU $ - string104
string103:
db "Once:"
size103 EQU $ - string103
string102:
db 0xD, "Leave >= 7", 0xD
size102 EQU $ - string102
string101:
db "Exit:"
size101 EQU $ - string101


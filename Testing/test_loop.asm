; vvvv
; ^^^^
    ORG 32768
    
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10      Init Return address stack
    exx                 ; 1:4
    ld  hl, stack_test
    push hl

    
    push DE             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   HL, 0          ; 3:10      push2(4,0)  
    ld  (idx101), HL    ; 3:16      do 101 save index
    dec  DE             ; 1:6       do 101 stop-1
    ld    A, E          ; 1:4       do 101 
    ld  (stp_lo101), A  ; 3:13      do 101 lo stop
    ld    A, D          ; 1:4       do 101 
    ld  (stp_hi101), A  ; 3:13      do 101 hi stop
    pop  HL             ; 1:10      do 101
    pop  DE             ; 1:10      do 101 ( -- ) R: ( -- )
do101:                  ;           do 101  
    push DE             ; 1:11      index i 101
    ex   DE, HL         ; 1:4       index i 101
    ld   HL, (idx101)   ; 3:16      index i 101 idx always points to a 16-bit index 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0)  
    ld  (idx102), HL    ; 3:16      ?do 102 save index
    or    A             ; 1:4       ?do 102
    sbc  HL, DE         ; 2:15      ?do 102
    dec  DE             ; 1:6       ?do 102 stop-1
    ld    A, E          ; 1:4       ?do 102 
    ld  (stp_lo102), A  ; 3:13      ?do 102 lo stop
    ld    A, D          ; 1:4       ?do 102 
    ld  (stp_hi102), A  ; 3:13      ?do 102 hi stop
    pop  HL             ; 1:10      ?do 102
    pop  DE             ; 1:10      ?do 102
    jp    z, exit102    ; 3:10      ?do 102 ( -- ) R: ( -- )
do102:                  ;           ?do 102  
    push DE             ; 1:11      index j 102
    ex   DE, HL         ; 1:4       index j 102
    ld   HL, (idx101)   ; 3:16      index j 102 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push DE             ; 1:11      index i 102
    ex   DE, HL         ; 1:4       index i 102
    ld   HL, (idx102)   ; 3:16      index i 102 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
idx102 EQU $+1          ;           loop 102
    ld   BC, 0x0000     ; 3:10      loop 102 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 102
stp_lo102 EQU $+1       ;           loop 102
    xor  0x00           ; 2:7       loop 102 lo index - stop - 1
    ld    A, B          ; 1:4       loop 102
    inc  BC             ; 1:6       loop 102 index++
    ld  (idx102),BC     ; 4:20      loop 102 save index
    jp   nz, do102      ; 3:10      loop 102    
stp_hi102 EQU $+1       ;           loop 102
    xor  0x00           ; 2:7       loop 102 hi index - stop - 1
    jp   nz, do102      ; 3:10      loop 102
leave102:               ;           loop 102
exit102:                ;           loop 102 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A  
idx101 EQU $+1          ;           loop 101
    ld   BC, 0x0000     ; 3:10      loop 101 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 101
stp_lo101 EQU $+1       ;           loop 101
    xor  0x00           ; 2:7       loop 101 lo index - stop - 1
    ld    A, B          ; 1:4       loop 101
    inc  BC             ; 1:6       loop 101 index++
    ld  (idx101),BC     ; 4:20      loop 101 save index
    jp   nz, do101      ; 3:10      loop 101    
stp_hi101 EQU $+1       ;           loop 101
    xor  0x00           ; 2:7       loop 101 hi index - stop - 1
    jp   nz, do101      ; 3:10      loop 101
leave101:               ;           loop 101
exit101:                ;           loop 101 
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
sdo104:                 ;           ?sdo 104 ( stop index -- stop index ) 
     
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
      

    ld   BC, 0          ; 3:10      xdo(4,0) 105
    ld  (idx105),BC     ; 4:20      xdo(4,0) 105
xdo105:                 ;           xdo(4,0) 105      
    push DE             ; 1:11      index i 105
    ex   DE, HL         ; 1:4       index i 105
    ld   HL, (idx105)   ; 3:16      index i 105 idx always points to a 16-bit index 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 

    push HL             ; 1:10      ?sdo 106
    or    A             ; 1:4       ?sdo 106
    sbc  HL, DE         ; 2:15      ?sdo 106
    pop  HL             ; 1:10      ?sdo 106
    jp    z, sleave106  ; 3:10      ?sdo 106   
sdo106:                 ;           ?sdo 106 ( stop index -- stop index )  
    push DE             ; 1:11      index j 106
    ex   DE, HL         ; 1:4       index j 106
    ld   HL, (idx105)   ; 3:16      index j 106 idx always points to a 16-bit index 
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
idx105 EQU $+1          ;           xloop 105 0 <= index < stop < 256
    ld    A, 0          ; 2:7       xloop 105
    nop                 ; 1:4       xloop 105 idx always points to a 16-bit index
    inc   A             ; 1:4       xloop 105 index++
    ld  (idx105),A      ; 3:13      xloop 105
    sub  low 4          ; 2:7       xloop 105
    jp    c, xdo105     ; 3:10      xloop 105 index-stop
xleave105:              ;           xloop 105
xexit105:               ;           xloop 105 
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
    ld    B, H          ; 1:4       for 108
    ld    C, L          ; 1:4       for 108
    ex   DE, HL         ; 1:4       for 108
    pop  DE             ; 1:10      for 108 index
for108:                 ;           for 108
    ld  (idx108),BC     ; 4:20      next 108 save index 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .  
    push DE             ; 1:11      index i 108
    ex   DE, HL         ; 1:4       index i 108
    ld   HL, (idx108)   ; 3:16      index i 108 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
idx108 EQU $+1          ;           next 108
    ld   BC, 0x0000     ; 3:10      next 108 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 108
    or    C             ; 1:4       next 108
    dec  BC             ; 1:6       next 108 index--, zero flag unaffected
    jp   nz, for108     ; 3:10      next 108
next108:                ;           next 108 
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
    ld  (idx109), HL    ; 3:16      do 109 save index
    dec  DE             ; 1:6       do 109 stop-1
    ld    A, E          ; 1:4       do 109 
    ld  (stp_lo109), A  ; 3:13      do 109 lo stop
    ld    A, D          ; 1:4       do 109 
    ld  (stp_hi109), A  ; 3:13      do 109 hi stop
    pop  HL             ; 1:10      do 109
    pop  DE             ; 1:10      do 109 ( -- ) R: ( -- )
do109:                  ;           do 109  
    push DE             ; 1:11      index i 109
    ex   DE, HL         ; 1:4       index i 109
    ld   HL, (idx109)   ; 3:16      index i 109 idx always points to a 16-bit index                
sfor110:                ;           sfor 110 ( index -- index )  
    push DE             ; 1:11      index j 110
    ex   DE, HL         ; 1:4       index j 110
    ld   HL, (idx109)   ; 3:16      index j 110 idx always points to a 16-bit index 
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
idx109 EQU $+1          ;           loop 109
    ld   BC, 0x0000     ; 3:10      loop 109 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 109
stp_lo109 EQU $+1       ;           loop 109
    xor  0x00           ; 2:7       loop 109 lo index - stop - 1
    ld    A, B          ; 1:4       loop 109
    inc  BC             ; 1:6       loop 109 index++
    ld  (idx109),BC     ; 4:20      loop 109 save index
    jp   nz, do109      ; 3:10      loop 109    
stp_hi109 EQU $+1       ;           loop 109
    xor  0x00           ; 2:7       loop 109 hi index - stop - 1
    jp   nz, do109      ; 3:10      loop 109
leave109:               ;           loop 109
exit109:                ;           loop 109 
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
    ld    B, H          ; 1:4       for 112
    ld    C, L          ; 1:4       for 112
    ex   DE, HL         ; 1:4       for 112
    pop  DE             ; 1:10      for 112 index
for112:                 ;           for 112
    ld  (idx112),BC     ; 4:20      next 112 save index     
    push DE             ; 1:11      index i 112
    ex   DE, HL         ; 1:4       index i 112
    ld   HL, (idx112)   ; 3:16      index i 112 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .       
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A           
idx112 EQU $+1          ;           next 112
    ld   BC, 0x0000     ; 3:10      next 112 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 112
    or    C             ; 1:4       next 112
    dec  BC             ; 1:6       next 112 index--, zero flag unaffected
    jp   nz, for112     ; 3:10      next 112
next112:                ;           next 112 
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
    ld  (idx113), HL    ; 3:16      do 113 save index
    dec  DE             ; 1:6       do 113 stop-1
    ld    A, E          ; 1:4       do 113 
    ld  (stp_lo113), A  ; 3:13      do 113 lo stop
    ld    A, D          ; 1:4       do 113 
    ld  (stp_hi113), A  ; 3:13      do 113 hi stop
    pop  HL             ; 1:10      do 113
    pop  DE             ; 1:10      do 113 ( -- ) R: ( -- )
do113:                  ;           do 113              
    ld    A, 'a'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   leave113       ;           leave 113          
idx113 EQU $+1          ;           loop 113
    ld   BC, 0x0000     ; 3:10      loop 113 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 113
stp_lo113 EQU $+1       ;           loop 113
    xor  0x00           ; 2:7       loop 113 lo index - stop - 1
    ld    A, B          ; 1:4       loop 113
    inc  BC             ; 1:6       loop 113 index++
    ld  (idx113),BC     ; 4:20      loop 113 save index
    jp   nz, do113      ; 3:10      loop 113    
stp_hi113 EQU $+1       ;           loop 113
    xor  0x00           ; 2:7       loop 113 hi index - stop - 1
    jp   nz, do113      ; 3:10      loop 113
leave113:               ;           loop 113
exit113:                ;           loop 113 
    
    push DE             ; 1:11      push2(0,1)
    ld   DE, 0          ; 3:10      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1)      
    ld  (idx114), HL    ; 3:16      do 114 save index
    dec  DE             ; 1:6       do 114 stop-1
    ld    A, E          ; 1:4       do 114 
    ld  (stp_lo114), A  ; 3:13      do 114 lo stop
    ld    A, D          ; 1:4       do 114 
    ld  (stp_hi114), A  ; 3:13      do 114 hi stop
    pop  HL             ; 1:10      do 114
    pop  DE             ; 1:10      do 114 ( -- ) R: ( -- )
do114:                  ;           do 114              
    ld    A, 'b'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   leave114       ;           leave 114          
idx114 EQU $+1          ;           loop 114
    ld   BC, 0x0000     ; 3:10      loop 114 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 114
stp_lo114 EQU $+1       ;           loop 114
    xor  0x00           ; 2:7       loop 114 lo index - stop - 1
    ld    A, B          ; 1:4       loop 114
    inc  BC             ; 1:6       loop 114 index++
    ld  (idx114),BC     ; 4:20      loop 114 save index
    jp   nz, do114      ; 3:10      loop 114    
stp_hi114 EQU $+1       ;           loop 114
    xor  0x00           ; 2:7       loop 114 hi index - stop - 1
    jp   nz, do114      ; 3:10      loop 114
leave114:               ;           loop 114
exit114:                ;           loop 114 
                   

    ld   BC, 0          ; 3:10      xdo(0,0) 115
    ld  (idx115),BC     ; 4:20      xdo(0,0) 115
xdo115:                 ;           xdo(0,0) 115         
    ld    A, 'c'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   xleave115      ;           xleave 115         
idx115 EQU $+1          ;           xloop 115
    ld   BC, 0x0000     ; 3:10      xloop 115 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 115 index++
    ld  (idx115),BC     ; 4:20      xloop 115 save index
    ld    A, C          ; 1:4       xloop 115
    xor  low 0          ; 2:7       xloop 115
    jp   nz, xdo115     ; 3:10      xloop 115
    ld    A, B          ; 1:4       xloop 115
    xor  high 0         ; 2:7       xloop 115
    jp   nz, xdo115     ; 3:10      xloop 115
xleave115:              ;           xloop 115
xexit115:               ;           xloop 115 
                   

    ld   BC, 254        ; 3:10      xdo(254,254) 116
    ld  (idx116),BC     ; 4:20      xdo(254,254) 116
xdo116:                 ;           xdo(254,254) 116     
    ld    A, 'd'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   xleave116      ;           xleave 116         
idx116 EQU $+1          ;           xloop 116
    ld   BC, 0x0000     ; 3:10      xloop 116 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 116 index++
    ld  (idx116),BC     ; 4:20      xloop 116 save index
    ld    A, C          ; 1:4       xloop 116
    xor  low 254        ; 2:7       xloop 116
    jp   nz, xdo116     ; 3:10      xloop 116
    ld    A, B          ; 1:4       xloop 116
    xor  high 254       ; 2:7       xloop 116
    jp   nz, xdo116     ; 3:10      xloop 116
xleave116:              ;           xloop 116
xexit116:               ;           xloop 116 
                   

    ld   BC, 255        ; 3:10      xdo(255,255) 117
    ld  (idx117),BC     ; 4:20      xdo(255,255) 117
xdo117:                 ;           xdo(255,255) 117     
    ld    A, 'e'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   xleave117      ;           xleave 117         
idx117 EQU $+1          ;           xloop 117
    ld   BC, 0x0000     ; 3:10      xloop 117 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 117 index++
    ld  (idx117),BC     ; 4:20      xloop 117 save index
    ld    A, C          ; 1:4       xloop 117
    xor  low 255        ; 2:7       xloop 117
    jp   nz, xdo117     ; 3:10      xloop 117
    ld    A, B          ; 1:4       xloop 117
    xor  high 255       ; 2:7       xloop 117
    jp   nz, xdo117     ; 3:10      xloop 117
xleave117:              ;           xloop 117
xexit117:               ;           xloop 117 
                   

    ld   BC, 256        ; 3:10      xdo(256,256) 118
    ld  (idx118),BC     ; 4:20      xdo(256,256) 118
xdo118:                 ;           xdo(256,256) 118     
    ld    A, 'f'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   xleave118      ;           xleave 118         
idx118 EQU $+1          ;           xloop 118
    ld   BC, 0x0000     ; 3:10      xloop 118 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 118 index++
    ld  (idx118),BC     ; 4:20      xloop 118 save index
    ld    A, C          ; 1:4       xloop 118
    xor  low 256        ; 2:7       xloop 118
    jp   nz, xdo118     ; 3:10      xloop 118
    ld    A, B          ; 1:4       xloop 118
    xor  high 256       ; 2:7       xloop 118
    jp   nz, xdo118     ; 3:10      xloop 118
xleave118:              ;           xloop 118
xexit118:               ;           xloop 118
    
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

                   

    ld   BC, 60000      ; 3:10      xdo(60000,60000) 123
    ld  (idx123),BC     ; 4:20      xdo(60000,60000) 123
xdo123:                 ;           xdo(60000,60000) 123 
    ld    A, 'k'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   xleave123      ;           xleave 123 
    push HL             ; 1:11      5000 +xloop 123
idx123 EQU $+1          ;           5000 +xloop 123
    ld   HL, 0x0000     ; 3:10      5000 +xloop 123
    ld   BC, 5000       ; 3:10      5000 +xloop 123 BC = step
    add  HL, BC         ; 1:11      5000 +xloop 123 HL = index+step
    ld  (idx123), HL    ; 3:16      5000 +xloop 123 save index
    ld    A, low 59999  ; 2:7       5000 +xloop 123
    sub   L             ; 1:4       5000 +xloop 123
    ld    L, A          ; 1:4       5000 +xloop 123
    ld    A, high 59999 ; 2:7       5000 +xloop 123
    sbc   A, H          ; 1:4       5000 +xloop 123
    ld    H, A          ; 1:4       5000 +xloop 123 HL = stop-(index+step)
    add  HL, BC         ; 1:11      5000 +xloop 123 HL = stop-index
    pop  HL             ; 1:10      5000 +xloop 123
    jp   nc, xdo123     ; 3:10      5000 +xloop 123 positive step
xleave123:              ;           5000 +xloop 123
xexit123:               ;           5000 +xloop 123
                   

    ld   BC, 60000      ; 3:10      xdo(60000,60000) 124
    ld  (idx124),BC     ; 4:20      xdo(60000,60000) 124
xdo124:                 ;           xdo(60000,60000) 124 
    ld    A, 'l'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    jp   xleave124      ;           xleave 124 
    push HL             ; 1:11      3100 +xloop 124
idx124 EQU $+1          ;           3100 +xloop 124
    ld   HL, 0x0000     ; 3:10      3100 +xloop 124
    ld   BC, 3100       ; 3:10      3100 +xloop 124 BC = step
    add  HL, BC         ; 1:11      3100 +xloop 124 HL = index+step
    ld  (idx124), HL    ; 3:16      3100 +xloop 124 save index
    ld    A, low 59999  ; 2:7       3100 +xloop 124
    sub   L             ; 1:4       3100 +xloop 124
    ld    L, A          ; 1:4       3100 +xloop 124
    ld    A, high 59999 ; 2:7       3100 +xloop 124
    sbc   A, H          ; 1:4       3100 +xloop 124
    ld    H, A          ; 1:4       3100 +xloop 124 HL = stop-(index+step)
    add  HL, BC         ; 1:11      3100 +xloop 124 HL = stop-index
    pop  HL             ; 1:10      3100 +xloop 124
    jp   nc, xdo124     ; 3:10      3100 +xloop 124 positive step
xleave124:              ;           3100 +xloop 124
xexit124:               ;           3100 +xloop 124

    
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(12,3)
    ld   DE, 12         ; 3:10      push2(12,3)
    push HL             ; 1:11      push2(12,3)
    ld   HL, 3          ; 3:10      push2(12,3)  
    ld  (idx125), HL    ; 3:16      do 125 save index
    dec  DE             ; 1:6       do 125 stop-1
    ld    A, E          ; 1:4       do 125 
    ld  (stp_lo125), A  ; 3:13      do 125 lo stop
    ld    A, D          ; 1:4       do 125 
    ld  (stp_hi125), A  ; 3:13      do 125 hi stop
    pop  HL             ; 1:10      do 125
    pop  DE             ; 1:10      do 125 ( -- ) R: ( -- )
do125:                  ;           do 125         
    push DE             ; 1:11      index i 125
    ex   DE, HL         ; 1:4       index i 125
    ld   HL, (idx125)   ; 3:16      index i 125 idx always points to a 16-bit index 
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
    jp   leave125       ;           leave 125 
else101  EQU $          ;           = endif
endif101:          
idx125 EQU $+1          ;           loop 125
    ld   BC, 0x0000     ; 3:10      loop 125 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 125
stp_lo125 EQU $+1       ;           loop 125
    xor  0x00           ; 2:7       loop 125 lo index - stop - 1
    ld    A, B          ; 1:4       loop 125
    inc  BC             ; 1:6       loop 125 index++
    ld  (idx125),BC     ; 4:20      loop 125 save index
    jp   nz, do125      ; 3:10      loop 125    
stp_hi125 EQU $+1       ;           loop 125
    xor  0x00           ; 2:7       loop 125 hi index - stop - 1
    jp   nz, do125      ; 3:10      loop 125
leave125:               ;           loop 125
exit125:                ;           loop 125    
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
                

    ld   BC, 3          ; 3:10      xdo(12,3) 127
    ld  (idx127),BC     ; 4:20      xdo(12,3) 127
xdo127:                 ;           xdo(12,3) 127   
    push DE             ; 1:11      index i 127
    ex   DE, HL         ; 1:4       index i 127
    ld   HL, (idx127)   ; 3:16      index i 127 idx always points to a 16-bit index 
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
    jp   xleave127      ;           xleave 127 
else103  EQU $          ;           = endif
endif103:         
idx127 EQU $+1          ;           xloop 127 0 <= index < stop < 256
    ld    A, 0          ; 2:7       xloop 127
    nop                 ; 1:4       xloop 127 idx always points to a 16-bit index
    inc   A             ; 1:4       xloop 127 index++
    ld  (idx127),A      ; 3:13      xloop 127
    sub  low 12         ; 2:7       xloop 127
    jp    c, xdo127     ; 3:10      xloop 127 index-stop
xleave127:              ;           xloop 127
xexit127:               ;           xloop 127    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                

    ld   BC, 3          ; 3:10      xdo(550,3) 128
    ld  (idx128),BC     ; 4:20      xdo(550,3) 128
xdo128:                 ;           xdo(550,3) 128  
    push DE             ; 1:11      index i 128
    ex   DE, HL         ; 1:4       index i 128
    ld   HL, (idx128)   ; 3:16      index i 128 idx always points to a 16-bit index 
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
    jp   xleave128      ;           xleave 128 
else104  EQU $          ;           = endif
endif104:         
idx128 EQU $+1          ;           xloop 128 index < stop && same sign
    ld   BC, 0x0000     ; 3:10      xloop 128 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 128 index++
    ld  (idx128),BC     ; 4:20      xloop 128 save index
    ld    A, C          ; 1:4       xloop 128
    sub  low 550        ; 2:7       xloop 128 index - stop
    ld    A, B          ; 1:4       xloop 128
    sbc   A, high 550   ; 2:7       xloop 128 index - stop
    jp    c, xdo128     ; 3:10      xloop 128
xleave128:              ;           xloop 128
xexit128:               ;           xloop 128    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                

    ld   BC, 3          ; 3:10      xdo(12,3) 129
    ld  (idx129),BC     ; 4:20      xdo(12,3) 129
xdo129:                 ;           xdo(12,3) 129   
    push DE             ; 1:11      index i 129
    ex   DE, HL         ; 1:4       index i 129
    ld   HL, (idx129)   ; 3:16      index i 129 idx always points to a 16-bit index 
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
    jp   xleave129      ;           xleave 129 
else105  EQU $          ;           = endif
endif105: 
                        ;           push_addxloop(2) 129
idx129 EQU $+1          ;           2 +xloop 129
    ld   BC, 0x0000     ; 3:10      2 +xloop 129 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 129 index++
    inc  BC             ; 1:6       2 +xloop 129 index++
    ld  (idx129),BC     ; 4:20      2 +xloop 129 save index
    ld    A, C          ; 1:4       2 +xloop 129
    sub  low 12         ; 2:7       2 +xloop 129
    rra                 ; 1:4       2 +xloop 129
    add   A, A          ; 1:4       2 +xloop 129 and 0xFE with save carry
    jp   nz, xdo129     ; 3:10      2 +xloop 129
    ld    A, B          ; 1:4       2 +xloop 129
    sbc   A, high 12    ; 2:7       2 +xloop 129
    jp   nz, xdo129     ; 3:10      2 +xloop 129
xleave129:              ;           2 +xloop 129
xexit129:               ;           2 +xloop 129 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                

    ld   BC, 3          ; 3:10      xdo(550,3) 130
    ld  (idx130),BC     ; 4:20      xdo(550,3) 130
xdo130:                 ;           xdo(550,3) 130  
    push DE             ; 1:11      index i 130
    ex   DE, HL         ; 1:4       index i 130
    ld   HL, (idx130)   ; 3:16      index i 130 idx always points to a 16-bit index 
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
    jp   xleave130      ;           xleave 130 
else106  EQU $          ;           = endif
endif106: 
                        ;           push_addxloop(2) 130
idx130 EQU $+1          ;           2 +xloop 130
    ld   BC, 0x0000     ; 3:10      2 +xloop 130 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 130 index++
    inc  BC             ; 1:6       2 +xloop 130 index++
    ld  (idx130),BC     ; 4:20      2 +xloop 130 save index
    ld    A, C          ; 1:4       2 +xloop 130
    sub  low 550        ; 2:7       2 +xloop 130
    rra                 ; 1:4       2 +xloop 130
    add   A, A          ; 1:4       2 +xloop 130 and 0xFE with save carry
    jp   nz, xdo130     ; 3:10      2 +xloop 130
    ld    A, B          ; 1:4       2 +xloop 130
    sbc   A, high 550   ; 2:7       2 +xloop 130
    jp   nz, xdo130     ; 3:10      2 +xloop 130
xleave130:              ;           2 +xloop 130
xexit130:               ;           2 +xloop 130 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(12)
    ex   DE, HL         ; 1:4       push(12)
    ld   HL, 12         ; 3:10      push(12)    
    ld    B, H          ; 1:4       for 131
    ld    C, L          ; 1:4       for 131
    ex   DE, HL         ; 1:4       for 131
    pop  DE             ; 1:10      for 131 index
for131:                 ;           for 131
    ld  (idx131),BC     ; 4:20      next 131 save index         
    push DE             ; 1:11      index i 131
    ex   DE, HL         ; 1:4       index i 131
    ld   HL, (idx131)   ; 3:16      index i 131 idx always points to a 16-bit index 
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
    jp   next131        ;           for leave 131 
else107  EQU $          ;           = endif
endif107:          
idx131 EQU $+1          ;           next 131
    ld   BC, 0x0000     ; 3:10      next 131 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 131
    or    C             ; 1:4       next 131
    dec  BC             ; 1:6       next 131 index--, zero flag unaffected
    jp   nz, for131     ; 3:10      next 131
next131:                ;           next 131    
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
    ld  (idx133), HL    ; 3:16      do 133 save index
    dec  DE             ; 1:6       do 133 stop-1
    ld    A, E          ; 1:4       do 133 
    ld  (stp_lo133), A  ; 3:13      do 133 lo stop
    ld    A, D          ; 1:4       do 133 
    ld  (stp_hi133), A  ; 3:13      do 133 hi stop
    pop  HL             ; 1:10      do 133
    pop  DE             ; 1:10      do 133 ( -- ) R: ( -- )
do133:                  ;           do 133 
    ld    A, 'a'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx133 EQU $+1          ;           loop 133
    ld   BC, 0x0000     ; 3:10      loop 133 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 133
stp_lo133 EQU $+1       ;           loop 133
    xor  0x00           ; 2:7       loop 133 lo index - stop - 1
    ld    A, B          ; 1:4       loop 133
    inc  BC             ; 1:6       loop 133 index++
    ld  (idx133),BC     ; 4:20      loop 133 save index
    jp   nz, do133      ; 3:10      loop 133    
stp_hi133 EQU $+1       ;           loop 133
    xor  0x00           ; 2:7       loop 133 hi index - stop - 1
    jp   nz, do133      ; 3:10      loop 133
leave133:               ;           loop 133
exit133:                ;           loop 133 
    
    push DE             ; 1:11      push2(255,254)
    ld   DE, 255        ; 3:10      push2(255,254)
    push HL             ; 1:11      push2(255,254)
    ld   HL, 254        ; 3:10      push2(255,254) 
    ld  (idx134), HL    ; 3:16      do 134 save index
    dec  DE             ; 1:6       do 134 stop-1
    ld    A, E          ; 1:4       do 134 
    ld  (stp_lo134), A  ; 3:13      do 134 lo stop
    ld    A, D          ; 1:4       do 134 
    ld  (stp_hi134), A  ; 3:13      do 134 hi stop
    pop  HL             ; 1:10      do 134
    pop  DE             ; 1:10      do 134 ( -- ) R: ( -- )
do134:                  ;           do 134 
    ld    A, 'b'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx134 EQU $+1          ;           loop 134
    ld   BC, 0x0000     ; 3:10      loop 134 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 134
stp_lo134 EQU $+1       ;           loop 134
    xor  0x00           ; 2:7       loop 134 lo index - stop - 1
    ld    A, B          ; 1:4       loop 134
    inc  BC             ; 1:6       loop 134 index++
    ld  (idx134),BC     ; 4:20      loop 134 save index
    jp   nz, do134      ; 3:10      loop 134    
stp_hi134 EQU $+1       ;           loop 134
    xor  0x00           ; 2:7       loop 134 hi index - stop - 1
    jp   nz, do134      ; 3:10      loop 134
leave134:               ;           loop 134
exit134:                ;           loop 134 
    

    ld   BC, 0          ; 3:10      xdo(1,0) 135
    ld  (idx135),BC     ; 4:20      xdo(1,0) 135
xdo135:                 ;           xdo(1,0) 135      
    ld    A, 'c'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx135 EQU $+1          ;           xloop 135 0 <= index < stop < 256
    ld    A, 0          ; 2:7       xloop 135
    nop                 ; 1:4       xloop 135 idx always points to a 16-bit index
    inc   A             ; 1:4       xloop 135 index++
    ld  (idx135),A      ; 3:13      xloop 135
    sub  low 1          ; 2:7       xloop 135
    jp    c, xdo135     ; 3:10      xloop 135 index-stop
xleave135:              ;           xloop 135
xexit135:               ;           xloop 135 
    

    ld   BC, 254        ; 3:10      xdo(255,254) 136
    ld  (idx136),BC     ; 4:20      xdo(255,254) 136
xdo136:                 ;           xdo(255,254) 136  
    ld    A, 'd'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx136 EQU $+1          ;           xloop 136 0 <= index < stop < 256
    ld    A, 0          ; 2:7       xloop 136
    nop                 ; 1:4       xloop 136 idx always points to a 16-bit index
    inc   A             ; 1:4       xloop 136 index++
    ld  (idx136),A      ; 3:13      xloop 136
    sub  low 255        ; 2:7       xloop 136
    jp    c, xdo136     ; 3:10      xloop 136 index-stop
xleave136:              ;           xloop 136
xexit136:               ;           xloop 136 
    

    ld   BC, 255        ; 3:10      xdo(256,255) 137
    ld  (idx137),BC     ; 4:20      xdo(256,255) 137
xdo137:                 ;           xdo(256,255) 137  
    ld    A, 'e'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx137 EQU $+1          ;           xloop 137 index < stop && same sign
    ld   BC, 0x0000     ; 3:10      xloop 137 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 137 index++
    ld  (idx137),BC     ; 4:20      xloop 137 save index
    ld    A, C          ; 1:4       xloop 137
    sub  low 256        ; 2:7       xloop 137 index - stop
    ld    A, B          ; 1:4       xloop 137
    sbc   A, high 256   ; 2:7       xloop 137 index - stop
    jp    c, xdo137     ; 3:10      xloop 137
xleave137:              ;           xloop 137
xexit137:               ;           xloop 137 
    

    ld   BC, 256        ; 3:10      xdo(257,256) 138
    ld  (idx138),BC     ; 4:20      xdo(257,256) 138
xdo138:                 ;           xdo(257,256) 138  
    ld    A, 'f'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
idx138 EQU $+1          ;           xloop 138 hi index == hi stop && index < stop
    ld   BC, 0x0000     ; 3:10      xloop 138 idx always points to a 16-bit index
    ld    A, C          ; 1:4       xloop 138
    inc   A             ; 1:4       xloop 138 index++
    ld  (idx138),A      ; 3:13      xloop 138 save index
    sub  low 257        ; 2:7       xloop 138 index - stop
    jp    c, xdo138     ; 3:10      xloop 138
xleave138:              ;           xloop 138
xexit138:               ;           xloop 138
    
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

    

    ld   BC, 30000      ; 3:10      xdo(60000,30000) 143
    ld  (idx143),BC     ; 4:20      xdo(60000,30000) 143
xdo143:                 ;           xdo(60000,30000) 143 
    ld    A, 'k'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    push HL             ; 1:11      40000 +xloop 143
idx143 EQU $+1          ;           40000 +xloop 143
    ld   HL, 0x0000     ; 3:10      40000 +xloop 143
    ld   BC, 40000      ; 3:10      40000 +xloop 143 BC = step
    add  HL, BC         ; 1:11      40000 +xloop 143 HL = index+step
    ld  (idx143), HL    ; 3:16      40000 +xloop 143 save index
    ld    A, low 59999  ; 2:7       40000 +xloop 143
    sub   L             ; 1:4       40000 +xloop 143
    ld    L, A          ; 1:4       40000 +xloop 143
    ld    A, high 59999 ; 2:7       40000 +xloop 143
    sbc   A, H          ; 1:4       40000 +xloop 143
    ld    H, A          ; 1:4       40000 +xloop 143 HL = stop-(index+step)
    add  HL, BC         ; 1:11      40000 +xloop 143 HL = stop-index
    pop  HL             ; 1:10      40000 +xloop 143
    jp   nc, xdo143     ; 3:10      40000 +xloop 143 positive step
xleave143:              ;           40000 +xloop 143
xexit143:               ;           40000 +xloop 143
    

    ld   BC, 30000      ; 3:10      xdo(60000,30000) 144
    ld  (idx144),BC     ; 4:20      xdo(60000,30000) 144
xdo144:                 ;           xdo(60000,30000) 144 
    ld    A, 'l'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    push HL             ; 1:11      31000 +xloop 144
idx144 EQU $+1          ;           31000 +xloop 144
    ld   HL, 0x0000     ; 3:10      31000 +xloop 144
    ld   BC, 31000      ; 3:10      31000 +xloop 144 BC = step
    add  HL, BC         ; 1:11      31000 +xloop 144 HL = index+step
    ld  (idx144), HL    ; 3:16      31000 +xloop 144 save index
    ld    A, low 59999  ; 2:7       31000 +xloop 144
    sub   L             ; 1:4       31000 +xloop 144
    ld    L, A          ; 1:4       31000 +xloop 144
    ld    A, high 59999 ; 2:7       31000 +xloop 144
    sbc   A, H          ; 1:4       31000 +xloop 144
    ld    H, A          ; 1:4       31000 +xloop 144 HL = stop-(index+step)
    add  HL, BC         ; 1:11      31000 +xloop 144 HL = stop-index
    pop  HL             ; 1:10      31000 +xloop 144
    jp   nc, xdo144     ; 3:10      31000 +xloop 144 positive step
xleave144:              ;           31000 +xloop 144
xexit144:               ;           31000 +xloop 144

    
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
    

;   ---  the beginning of a data stack function  ---
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


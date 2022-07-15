    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init

    
    push DE             ; 1:11      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    ld    H, D          ; 1:4       push2(4,0)
    ld    L, D          ; 1:4       push2(4,0)  
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
    call PRT_S16        ; 3:17      .   ( s -- )  
    push DE             ; 1:11      index i 102
    ex   DE, HL         ; 1:4       index i 102
    ld   HL, (idx102)   ; 3:16      index i 102 idx always points to a 16-bit index 
    ld    A, '/'        ; 2:7       '/' emit  push_emit('/')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit  push_emit('/')   putchar(reg A) with ZX 48K ROM 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
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
    push HL             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    ld    H, D          ; 1:4       push2(4,0)
    ld    L, D          ; 1:4       push2(4,0) 

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
    
                       ;[ 6:44]     2 pick
    pop  BC             ; 1:10      2 pick
    push BC             ; 1:11      2 pick
    push DE             ; 1:11      2 pick
    ex   DE, HL         ; 1:4       2 pick
    ld    H, B          ; 1:4       2 pick
    ld    L, C          ; 1:4       2 pick ( c b a -- c b a c ) 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, '/'        ; 2:7       '/' emit  push_emit('/')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit  push_emit('/')   putchar(reg A) with ZX 48K ROM 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
xdo105save:             ;           xdo(4,0) 105
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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, '/'        ; 2:7       '/' emit  push_emit('/')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit  push_emit('/')   putchar(reg A) with ZX 48K ROM 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
  
                        ;[12:45]    xloop 105   variant +1.B: 0 <= index < stop <= 256, run 4x
idx105 EQU $+1          ;           xloop 105   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 105   0.. +1 ..(4), real_stop:0x0004
    nop                 ; 1:4       xloop 105   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       xloop 105   index++
    ld  (idx105),A      ; 3:13      xloop 105
    xor  0x04           ; 2:7       xloop 105   lo(real_stop)
    jp   nz, xdo105     ; 3:10      xloop 105   index-stop
xleave105:              ;           xloop 105
xexit105:               ;           xloop 105 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push2(3,0)
    push HL             ; 1:11      push2(3,0)
    ld   DE, 3          ; 3:10      push2(3,0)
    ld    H, D          ; 1:4       push2(3,0)
    ld    L, D          ; 1:4       push2(3,0) 

sdo107:                 ;           sdo 107 ( stop index -- stop index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )                 
    ld    B, H          ; 1:4       for 108
    ld    C, L          ; 1:4       for 108
    ex   DE, HL         ; 1:4       for 108
    pop  DE             ; 1:10      for 108 index
for108:                 ;           for 108
    ld  (idx108),BC     ; 4:20      for 108 save index 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRT_S16        ; 3:17      .   ( s -- )  
    push DE             ; 1:11      index i 108
    ex   DE, HL         ; 1:4       index i 108
    ld   HL, (idx108)   ; 3:16      index i 108 idx always points to a 16-bit index 
    ld    A, '/'        ; 2:7       '/' emit  push_emit('/')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit  push_emit('/')   putchar(reg A) with ZX 48K ROM 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM  
idx108 EQU $+1          ;           next 108
    ld   BC, 0x0000     ; 3:10      next 108 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 108
    or    C             ; 1:4       next 108
    dec  BC             ; 1:6       next 108 index--, zero flag unaffected
    jp   nz, for108     ; 3:10      next 108
next108:                ;           next 108  
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
    push HL             ; 1:11      push2(3,0)
    ld   DE, 3          ; 3:10      push2(3,0)
    ld    H, D          ; 1:4       push2(3,0)
    ld    L, D          ; 1:4       push2(3,0)  
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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, '/'        ; 2:7       '/' emit  push_emit('/')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit  push_emit('/')   putchar(reg A) with ZX 48K ROM 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    ld   A, H           ; 1:4       snext 110
    or   L              ; 1:4       snext 110
    dec  HL             ; 1:6       snext 110 index--
    jp  nz, sfor110     ; 3:10      snext 110
snext110:               ;           snext 110
    ex   DE, HL         ; 1:4       sfor unloop 110
    pop  DE             ; 1:10      sfor unloop 110   
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
    call PRT_S16        ; 3:17      .   ( s -- )       
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM          
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
    ld  (idx112),BC     ; 4:20      for 112 save index     
    push DE             ; 1:11      index i 112
    ex   DE, HL         ; 1:4       index i 112
    ld   HL, (idx112)   ; 3:16      index i 112 idx always points to a 16-bit index 
    call PRT_S16        ; 3:17      .   ( s -- )       
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM           
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
begin101:               ;           begin 101 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, H          ; 1:4       dup_while 101
    or    L             ; 1:4       dup_while 101
    jp    z, break101   ; 3:10      dup_while 101 
    dec  HL             ; 1:6       1- 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A ;--> " 5, 4, 3, 2, 1, 0"
    
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
begin102:               ;           begin 102 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      dup 4
    push HL             ; 1:11      dup 4
    ex   DE, HL         ; 1:4       dup 4
    ld   HL, 4          ; 3:10      dup 4 
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
    ld    A, H          ; 1:4       while 102
    or    L             ; 1:4       while 102
    ex   DE, HL         ; 1:4       while 102
    pop  DE             ; 1:10      while 102
    jp    z, break102   ; 3:10      while 102 
    inc  HL             ; 1:6       1+ 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   begin102       ; 3:10      repeat 102
break102:               ;           repeat 102 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A ;--> " 0, 1, 2, 3, 4"
    
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
begin103:               ;           begin 103 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      dup 4
    push HL             ; 1:11      dup 4
    ex   DE, HL         ; 1:4       dup 4
    ld   HL, 4          ; 3:10      dup 4 
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
    ld    A, H          ; 1:4       while 103
    or    L             ; 1:4       while 103
    ex   DE, HL         ; 1:4       while 103
    pop  DE             ; 1:10      while 103
    jp    z, break103   ; 3:10      while 103 
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+ 
    ld    A, ','        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   begin103       ; 3:10      repeat 103
break103:               ;           repeat 103 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A ;--> " 0, 2, 4"

    
    push DE             ; 1:11      print     "Exit:"
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0)      
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
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1)
    ld    D, H          ; 1:4       push2(0,1)
    ld    E, H          ; 1:4       push2(0,1)      
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
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
xdo115save:             ;           xdo(0,0) 115
    ld  (idx115),BC     ; 4:20      xdo(0,0) 115
xdo115:                 ;           xdo(0,0) 115         
    ld    A, 'c'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   xleave115      ;           xleave 115         
                        ;[9:54/34]  xloop 115   variant +1.G: stop == 0, run 65536x
idx115 EQU $+1          ;           xloop 115   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 115   0.. +1 ..(0), real_stop:0x0000
    inc  BC             ; 1:6       xloop 115   index++
    ld    A, B          ; 1:4       xloop 115
    or    C             ; 1:4       xloop 115
    jp   nz, xdo115save ; 3:10      xloop 115
xleave115:              ;           xloop 115
xexit115:               ;           xloop 115 
                   
    ld   BC, 254        ; 3:10      xdo(254,254) 116
xdo116save:             ;           xdo(254,254) 116
    ld  (idx116),BC     ; 4:20      xdo(254,254) 116
xdo116:                 ;           xdo(254,254) 116     
    ld    A, 'd'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   xleave116      ;           xleave 116         
                        ;[16:57/58] xloop 116   variant +1.default: step one, run 65536x
idx116 EQU $+1          ;           xloop 116   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 116   254.. +1 ..(254), real_stop:0x00FE
    inc  BC             ; 1:6       xloop 116   index++
    ld    A, B          ; 1:4       xloop 116
    xor  0x00           ; 2:7       xloop 116   hi(real_stop) first (255<=255)
    jp   nz, xdo116save ; 3:10      xloop 116   255x false positive
    ld    A, C          ; 1:4       xloop 116
    xor  0xFE           ; 2:7       xloop 116   lo(real_stop)
    jp   nz, xdo116save ; 3:10      xloop 116   255x false positive if he was first
xleave116:              ;           xloop 116
xexit116:               ;           xloop 116 
                   
    ld   BC, 255        ; 3:10      xdo(255,255) 117
xdo117save:             ;           xdo(255,255) 117
    ld  (idx117),BC     ; 4:20      xdo(255,255) 117
xdo117:                 ;           xdo(255,255) 117     
    ld    A, 'e'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   xleave117      ;           xleave 117         
                        ;[16:57/58] xloop 117   variant +1.default: step one, run 65536x
idx117 EQU $+1          ;           xloop 117   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 117   255.. +1 ..(255), real_stop:0x00FF
    inc  BC             ; 1:6       xloop 117   index++
    ld    A, B          ; 1:4       xloop 117
    xor  0x00           ; 2:7       xloop 117   hi(real_stop) first (255<=255)
    jp   nz, xdo117save ; 3:10      xloop 117   255x false positive
    ld    A, C          ; 1:4       xloop 117
    xor  0xFF           ; 2:7       xloop 117   lo(real_stop)
    jp   nz, xdo117save ; 3:10      xloop 117   255x false positive if he was first
xleave117:              ;           xloop 117
xexit117:               ;           xloop 117 
                   
    ld   BC, 256        ; 3:10      xdo(256,256) 118
xdo118save:             ;           xdo(256,256) 118
    ld  (idx118),BC     ; 4:20      xdo(256,256) 118
xdo118:                 ;           xdo(256,256) 118     
    ld    A, 'f'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   xleave118      ;           xleave 118         
                        ;[16:57/58] xloop 118   variant +1.default: step one, run 65536x
idx118 EQU $+1          ;           xloop 118   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 118   256.. +1 ..(256), real_stop:0x0100
    inc  BC             ; 1:6       xloop 118   index++
    ld    A, B          ; 1:4       xloop 118
    xor  0x01           ; 2:7       xloop 118   hi(real_stop) first (255<=255)
    jp   nz, xdo118save ; 3:10      xloop 118   255x false positive
    ld    A, C          ; 1:4       xloop 118
    xor  0x00           ; 2:7       xloop 118   lo(real_stop)
    jp   nz, xdo118save ; 3:10      xloop 118   255x false positive if he was first
xleave118:              ;           xloop 118
xexit118:               ;           xloop 118
    
    push DE             ; 1:11      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0)
    ld    D, H          ; 1:4       push2(0,0)
    ld    E, L          ; 1:4       push2(0,0)     

sdo119:                 ;           sdo 119 ( stop index -- stop index )              
    ld    A, 'g'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
    push HL             ; 1:11      push2(254,254)
    ld   HL, 254        ; 3:10      push2(254,254)
    ld    D, H          ; 1:4       push2(254,254)
    ld    E, L          ; 1:4       push2(254,254) 

sdo120:                 ;           sdo 120 ( stop index -- stop index )              
    ld    A, 'h'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
    push HL             ; 1:11      push2(255,255)
    ld   HL, 255        ; 3:10      push2(255,255)
    ld    D, H          ; 1:4       push2(255,255)
    ld    E, L          ; 1:4       push2(255,255) 

sdo121:                 ;           sdo 121 ( stop index -- stop index )              
    ld    A, 'i'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
    push HL             ; 1:11      push2(256,256)
    ld   HL, 256        ; 3:10      push2(256,256)
    ld    D, H          ; 1:4       push2(256,256)
    ld    E, L          ; 1:4       push2(256,256) 

sdo122:                 ;           sdo 122 ( stop index -- stop index )              
    ld    A, 'j'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
xdo123save:             ;           xdo(60000,60000) 123
    ld  (idx123),BC     ; 4:20      xdo(60000,60000) 123
xdo123:                 ;           xdo(60000,60000) 123 
    ld    A, 'k'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   xleave123      ;           xleave 123 
                        ;[16:77/57] 5000 +xloop 123   variant +X.J: positive step 256+ and hi(real_stop) exclusivity, run 14x
idx123 EQU $+1          ;           5000 +xloop 123   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      5000 +xloop 123   60000.. +5000 ..(60000), real_stop:0xFBD0
    ld    A, C          ; 1:4       5000 +xloop 123
    add   A, low 5000   ; 2:7       5000 +xloop 123
    ld    C, A          ; 1:4       5000 +xloop 123
    ld    A, B          ; 1:4       5000 +xloop 123
    adc   A, high 5000  ; 2:7       5000 +xloop 123
    ld    B, A          ; 1:4       5000 +xloop 123
    xor  0xFB           ; 2:7       5000 +xloop 123   hi(real_stop)
    jp   nz, xdo123save ; 3:10      5000 +xloop 123
xleave123:              ;           5000 +xloop 123
xexit123:               ;           5000 +xloop 123
                   
    ld   BC, 60000      ; 3:10      xdo(60000,60000) 124
xdo124save:             ;           xdo(60000,60000) 124
    ld  (idx124),BC     ; 4:20      xdo(60000,60000) 124
xdo124:                 ;           xdo(60000,60000) 124 
    ld    A, 'l'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    jp   xleave124      ;           xleave 124 
                        ;[16:77/57] 3100 +xloop 124   variant +X.J: positive step 256+ and hi(real_stop) exclusivity, run 22x
idx124 EQU $+1          ;           3100 +xloop 124   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      3100 +xloop 124   60000.. +3100 ..(60000), real_stop:0xF4C8
    ld    A, C          ; 1:4       3100 +xloop 124
    add   A, low 3100   ; 2:7       3100 +xloop 124
    ld    C, A          ; 1:4       3100 +xloop 124
    ld    A, B          ; 1:4       3100 +xloop 124
    adc   A, high 3100  ; 2:7       3100 +xloop 124
    ld    B, A          ; 1:4       3100 +xloop 124
    xor  0xF4           ; 2:7       3100 +xloop 124   hi(real_stop)
    jp   nz, xdo124save ; 3:10      3100 +xloop 124
xleave124:              ;           3100 +xloop 124
xexit124:               ;           3100 +xloop 124

    
    push DE             ; 1:11      print     0xD, "Leave >= 7", 0xD
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
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
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
xdo127save:             ;           xdo(12,3) 127
    ld  (idx127),BC     ; 4:20      xdo(12,3) 127
xdo127:                 ;           xdo(12,3) 127   
    push DE             ; 1:11      index i 127
    ex   DE, HL         ; 1:4       index i 127
    ld   HL, (idx127)   ; 3:16      index i 127 idx always points to a 16-bit index 
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else103    ; 3:10      if 
    jp   xleave127      ;           xleave 127 
else103  EQU $          ;           = endif
endif103:         
                        ;[12:45]    xloop 127   variant +1.B: 0 <= index < stop <= 256, run 9x
idx127 EQU $+1          ;           xloop 127   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 127   3.. +1 ..(12), real_stop:0x000C
    nop                 ; 1:4       xloop 127   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       xloop 127   index++
    ld  (idx127),A      ; 3:13      xloop 127
    xor  0x0C           ; 2:7       xloop 127   lo(real_stop)
    jp   nz, xdo127     ; 3:10      xloop 127   index-stop
xleave127:              ;           xloop 127
xexit127:               ;           xloop 127    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                
    ld   BC, 3          ; 3:10      xdo(550,3) 128
xdo128save:             ;           xdo(550,3) 128
    ld  (idx128),BC     ; 4:20      xdo(550,3) 128
xdo128:                 ;           xdo(550,3) 128  
    push DE             ; 1:11      index i 128
    ex   DE, HL         ; 1:4       index i 128
    ld   HL, (idx128)   ; 3:16      index i 128 idx always points to a 16-bit index 
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else104    ; 3:10      if 
    jp   xleave128      ;           xleave 128 
else104  EQU $          ;           = endif
endif104:         
                        ;[16:57/58] xloop 128   variant +1.default: step one, run 547x
idx128 EQU $+1          ;           xloop 128   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 128   3.. +1 ..(550), real_stop:0x0226
    inc  BC             ; 1:6       xloop 128   index++
    ld    A, C          ; 1:4       xloop 128
    xor  0x26           ; 2:7       xloop 128   lo(real_stop) first (38>2)
    jp   nz, xdo128save ; 3:10      xloop 128   2x false positive
    ld    A, B          ; 1:4       xloop 128
    xor  0x02           ; 2:7       xloop 128   hi(real_stop)
    jp   nz, xdo128save ; 3:10      xloop 128   38x false positive if he was first
xleave128:              ;           xloop 128
xexit128:               ;           xloop 128    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                
    ld   BC, 3          ; 3:10      xdo(12,3) 129
xdo129save:             ;           xdo(12,3) 129
    ld  (idx129),BC     ; 4:20      xdo(12,3) 129
xdo129:                 ;           xdo(12,3) 129   
    push DE             ; 1:11      index i 129
    ex   DE, HL         ; 1:4       index i 129
    ld   HL, (idx129)   ; 3:16      index i 129 idx always points to a 16-bit index 
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else105    ; 3:10      if 
    jp   xleave129      ;           xleave 129 
else105  EQU $          ;           = endif
endif105: 
                        ;[11:61/41] 2 +xloop 129   variant +2.C: step 2 with lo(real_stop) exclusivity, run 5x
idx129 EQU $+1          ;           2 +xloop 129   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 129   3.. +2 ..(12), real_stop:0x000D
    inc  BC             ; 1:6       2 +xloop 129   index++
    inc   C             ; 1:4       2 +xloop 129   index++
    ld    A, C          ; 1:4       2 +xloop 129
    xor  0x0D           ; 2:7       2 +xloop 129   lo(real_stop)
    jp   nz, xdo129save ; 3:10      2 +xloop 129
xleave129:              ;           2 +xloop 129
xexit129:               ;           2 +xloop 129 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                
    ld   BC, 3          ; 3:10      xdo(550,3) 130
xdo130save:             ;           xdo(550,3) 130
    ld  (idx130),BC     ; 4:20      xdo(550,3) 130
xdo130:                 ;           xdo(550,3) 130  
    push DE             ; 1:11      index i 130
    ex   DE, HL         ; 1:4       index i 130
    ld   HL, (idx130)   ; 3:16      index i 130 idx always points to a 16-bit index 
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    jp    z, else106    ; 3:10      if 
    jp   xleave130      ;           xleave 130 
else106  EQU $          ;           = endif
endif106: 
                        ;[17:61/62] 2 +xloop 130   variant +2.defaultB: positive step 2, run 274x
idx130 EQU $+1          ;           2 +xloop 130   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 130   3.. +2 ..(550), real_stop:0x0227
    inc  BC             ; 1:6       2 +xloop 130   index++
    inc   C             ; 1:4       2 +xloop 130   index++
    ld    A, C          ; 1:4       2 +xloop 130
    xor  0x27           ; 2:7       2 +xloop 130   lo(real_stop) first (19>2)
    jp   nz, xdo130save ; 3:10      2 +xloop 130   2x false positive
    ld    A, B          ; 1:4       2 +xloop 130
    xor  0x02           ; 2:7       2 +xloop 130   hi(real_stop)
    jp   nz, xdo130save ; 3:10      2 +xloop 130   19x false positive if he was first
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
    ld  (idx131),BC     ; 4:20      for 131 save index         
    push DE             ; 1:11      index i 131
    ex   DE, HL         ; 1:4       index i 131
    ld   HL, (idx131)   ; 3:16      index i 131 idx always points to a 16-bit index 
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1 
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
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
    
    
    push DE             ; 1:11      print     "Once:"
    ld   BC, size103    ; 3:10      print     Length of string103
    ld   DE, string103  ; 3:10      print     Address of string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(1,0)
    push HL             ; 1:11      push2(1,0)
    ld   DE, 1          ; 3:10      push2(1,0)
    ld    H, D          ; 1:4       push2(1,0)
    ld    L, D          ; 1:4       push2(1,0) 
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
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
xdo135save:             ;           xdo(1,0) 135
    ld  (idx135),BC     ; 4:20      xdo(1,0) 135
xdo135:                 ;           xdo(1,0) 135      
    ld    A, 'c'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
idx135 EQU xdo135save-2 ;           xloop 135   variant +1.null: positive step and no repeat
xleave135:              ;           xloop 135
xexit135:               ;           xloop 135 
    
    ld   BC, 254        ; 3:10      xdo(255,254) 136
xdo136save:             ;           xdo(255,254) 136
    ld  (idx136),BC     ; 4:20      xdo(255,254) 136
xdo136:                 ;           xdo(255,254) 136  
    ld    A, 'd'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
idx136 EQU xdo136save-2 ;           xloop 136   variant +1.null: positive step and no repeat
xleave136:              ;           xloop 136
xexit136:               ;           xloop 136 
    
    ld   BC, 255        ; 3:10      xdo(256,255) 137
xdo137save:             ;           xdo(256,255) 137
    ld  (idx137),BC     ; 4:20      xdo(256,255) 137
xdo137:                 ;           xdo(256,255) 137  
    ld    A, 'e'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
idx137 EQU xdo137save-2 ;           xloop 137   variant +1.null: positive step and no repeat
xleave137:              ;           xloop 137
xexit137:               ;           xloop 137 
    
    ld   BC, 256        ; 3:10      xdo(257,256) 138
xdo138save:             ;           xdo(257,256) 138
    ld  (idx138),BC     ; 4:20      xdo(257,256) 138
xdo138:                 ;           xdo(257,256) 138  
    ld    A, 'f'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
idx138 EQU xdo138save-2 ;           xloop 138   variant +1.null: positive step and no repeat
xleave138:              ;           xloop 138
xexit138:               ;           xloop 138
    
    push DE             ; 1:11      push2(1,0)
    push HL             ; 1:11      push2(1,0)
    ld   DE, 1          ; 3:10      push2(1,0)
    ld    H, D          ; 1:4       push2(1,0)
    ld    L, D          ; 1:4       push2(1,0)     

sdo139:                 ;           sdo 139 ( stop index -- stop index ) 
    ld    A, 'g'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
    push HL             ; 1:11      push2(257,256)
    ld   HL, 256        ; 3:10      push2(257,256)
    ld    D, H          ; 1:4       push2(257,256)
    ld    E, H          ; 1:4       push2(257,256) 

sdo142:                 ;           sdo 142 ( stop index -- stop index ) 
    ld    A, 'j'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
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
xdo143save:             ;           xdo(60000,30000) 143
    ld  (idx143),BC     ; 4:20      xdo(60000,30000) 143
xdo143:                 ;           xdo(60000,30000) 143 
    ld    A, 'k'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
idx143 EQU xdo143save-2 ;           40000 +xloop 143   variant +X.null: positive step and no repeat
xleave143:              ;           40000 +xloop 143
xexit143:               ;           40000 +xloop 143
    
    ld   BC, 30000      ; 3:10      xdo(60000,30000) 144
xdo144save:             ;           xdo(60000,30000) 144
    ld  (idx144),BC     ; 4:20      xdo(60000,30000) 144
xdo144:                 ;           xdo(60000,30000) 144 
    ld    A, 'l'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
idx144 EQU xdo144save-2 ;           31000 +xloop 144   variant +X.null: positive step and no repeat
xleave144:              ;           31000 +xloop 144
xexit144:               ;           31000 +xloop 144

    
    push DE             ; 1:11      print     0xD, "Data stack:"
    ld   BC, size104    ; 3:10      print     Length of string104
    ld   DE, string104  ; 3:10      print     Address of string104
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    srl   H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth 
    call PRT_S16        ; 3:17      .   ( s -- )    
    
    push DE             ; 1:11      print     0xD, "RAS:"
    ld   BC, size105    ; 3:10      print     Length of string105
    ld   DE, string105  ; 3:10      print     Address of string105
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ex   DE, HL         ; 1:4       __ras   ( -- return_address_stack )
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    pop  HL             ; 1:10      __ras 
    call PRT_U16        ; 3:17      u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====

;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_S16:             ;           prt_sp_s16
    ld    A, ' '        ; 2:7       prt_sp_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_sp_s16   putchar(reg A) with ZX 48K ROM
    ; fall to prt_s16
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_S16:                ;           prt_s16
    ld    A, H          ; 1:4       prt_s16
    add   A, A          ; 1:4       prt_s16
    jr   nc, PRT_U16    ; 2:7/12    prt_s16
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_s16   putchar(reg A) with ZX 48K ROM
    xor   A             ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    L, A          ; 1:4       prt_s16   neg
    sbc   A, H          ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    H, A          ; 1:4       prt_s16   neg
    ; fall to prt_u16
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_U16:                ;           prt_u16
    xor   A             ; 1:4       prt_u16   HL=103 & A=0 => 103, HL = 103 & A='0' => 00103
    ld   BC, -10000     ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld   BC, -1000      ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld   BC, -100       ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld    C, -10        ; 2:7       prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld    A, L          ; 1:4       prt_u16
    pop  HL             ; 1:10      prt_u16   load ret
    ex  (SP),HL         ; 1:19      prt_u16
    ex   DE, HL         ; 1:4       prt_u16
    jr   BIN16_DEC_CHAR ; 2:12      prt_u16
;------------------------------------------------------------------------------
; Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
    inc   A             ; 1:4       bin16_dec
BIN16_DEC:              ;           bin16_dec
    add  HL, BC         ; 1:11      bin16_dec
    jr    c, $-2        ; 2:7/12    bin16_dec
    sbc  HL, BC         ; 2:15      bin16_dec
    or    A             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
BIN16_DEC_CHAR:         ;           bin16_dec
    or   '0'            ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
STRING_SECTION:
string105:
db 0xD, "RAS:"
size105 EQU $ - string105
string104:
db 0xD, "Data stack:"
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

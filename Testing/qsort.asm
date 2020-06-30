ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    ld  hl, stack_test
    push hl

;#  PUSH2(orig,test) PUSH(2*10) CMOVE
;#  PUSH2(test,10) CALL(print)
    
    push DE             ; 1:11      push2(test,10)
    ld   DE, test       ; 3:10      push2(test,10)
    push HL             ; 1:11      push2(test,10)
    ld   HL, 10         ; 3:10      push2(test,10) 
    call generate       ; 3:17      call ( -- ret ) R:( -- )
;#  PUSH2(test,10) CALL(print)
    
    push DE             ; 1:11      push2(test,10)
    ld   DE, test       ; 3:10      push2(test,10)
    push HL             ; 1:11      push2(test,10)
    ld   HL, 10         ; 3:10      push2(test,10) 
    call sort           ; 3:17      call ( -- ret ) R:( -- )
    
    push DE             ; 1:11      push2(test,10)
    ld   DE, test       ; 3:10      push2(test,10)
    push HL             ; 1:11      push2(test,10)
    ld   HL, 10         ; 3:10      push2(test,10) 
    call print          ; 3:17      call ( -- ret ) R:( -- )
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
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
generate:               ;           (addr len -- )
    pop  BC             ; 1:10      : ret
    ld  (generate_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    add  HL, HL         ; 1:11      2* 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) ; ( addr+len addr )
    
    ld  (idx101), HL    ; 3:16      do 101 index
    ld    A, E          ; 1:4       do 101 
    ld  (stp_lo101), A  ; 3:13      do 101 lo stop
    ld    A, D          ; 1:4       do 101 
    ld  (stp_hi101), A  ; 3:13      do 101 hi stop
    pop  HL             ; 1:10      do 101
    pop  DE             ; 1:10      do 101 ( -- ) R: ( -- )
do101:                  ;           do 101 
        
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd
        
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      index i 101
    ex   DE, HL         ; 1:4       index i 101
    ld   HL, (idx101)   ; 3:16      index i 101 idx always points to a 16-bit index 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store
    
                        ;           push_addloop(2) 101
idx101 EQU $+1          ;           2 +loop 101
    ld   BC, 0x0000     ; 3:10      2 +loop 101 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +loop 101 index++
    inc  BC             ; 1:6       2 +loop 101 index++
    ld  (idx101),BC     ; 4:20      2 +loop 101 save index
    ld    A, C          ; 1:4       2 +loop 101
stp_lo101 EQU $+1       ;           2 +loop 101
    sub  0x00           ; 2:7       2 +loop 101 lo index - stop
    rra                 ; 1:4       2 +loop 101
    add   A, A          ; 1:4       2 +loop 101 and 0xFE with save carry
    jp   nz, do101      ; 3:10      2 +loop 101
    ld    A, B          ; 1:4       2 +loop 101
stp_hi101 EQU $+1       ;           2 +loop 101
    sbc   A, 0x00       ; 2:7       2 +loop 101 hi index - stop
    jp   nz, do101      ; 3:10      2 +loop 101
xleave101:              ;           2 +loop 101
xexit101:               ;           2 +loop 101
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

generate_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
    

;   ---  the beginning of a non-recursive function  ---
print:                  ;           (addr len -- )
    pop  BC             ; 1:10      : ret
    ld  (print_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    add  HL, HL         ; 1:11      2* 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) ; ( addr+len addr )
    
    ld  (idx102), HL    ; 3:16      do 102 index
    ld    A, E          ; 1:4       do 102 
    ld  (stp_lo102), A  ; 3:13      do 102 lo stop
    ld    A, D          ; 1:4       do 102 
    ld  (stp_hi102), A  ; 3:13      do 102 hi stop
    pop  HL             ; 1:10      do 102
    pop  DE             ; 1:10      do 102 ( -- ) R: ( -- )
do102:                  ;           do 102 
        
    push DE             ; 1:11      index i 102
    ex   DE, HL         ; 1:4       index i 102
    ld   HL, (idx102)   ; 3:16      index i 102 idx always points to a 16-bit index 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    call PRINT_S16      ; 3:17      .
    
                        ;           push_addloop(2) 102
idx102 EQU $+1          ;           2 +loop 102
    ld   BC, 0x0000     ; 3:10      2 +loop 102 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +loop 102 index++
    inc  BC             ; 1:6       2 +loop 102 index++
    ld  (idx102),BC     ; 4:20      2 +loop 102 save index
    ld    A, C          ; 1:4       2 +loop 102
stp_lo102 EQU $+1       ;           2 +loop 102
    sub  0x00           ; 2:7       2 +loop 102 lo index - stop
    rra                 ; 1:4       2 +loop 102
    add   A, A          ; 1:4       2 +loop 102 and 0xFE with save carry
    jp   nz, do102      ; 3:10      2 +loop 102
    ld    A, B          ; 1:4       2 +loop 102
stp_hi102 EQU $+1       ;           2 +loop 102
    sbc   A, 0x00       ; 2:7       2 +loop 102 hi index - stop
    jp   nz, do102      ; 3:10      2 +loop 102
xleave102:              ;           2 +loop 102
xexit102:               ;           2 +loop 102
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

print_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
mid:                    ;           
    pop  BC             ; 1:10      : ret
    ld  (mid_end+1),BC  ; 4:20      : ( ret -- ) R:( -- ) ;( l r -- mid )
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      - 
    sra   H             ; 2:8       2/   with sign
    rr    L             ; 2:8       2/ 
    push DE             ; 1:11      push(-2)
    ex   DE, HL         ; 1:4       push(-2)
    ld   HL, -2         ; 3:10      push(-2) 
    ld    A, E          ; 1:4       and
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 

mid_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
 

;   ---  the beginning of a non-recursive function  ---
exch_slow:              ;           ( addr1 addr2 -- )
    pop  BC             ; 1:10      : ret
    ld  (exch_slow_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    ex  (SP), HL        ; 1:19      to_r
    ex   DE, HL         ; 1:4       to_r
    exx                 ; 1:4       to_r
    pop  DE             ; 1:10      to_r
    dec  HL             ; 1:6       to_r
    ld  (HL),D          ; 1:7       to_r
    dec   L             ; 1:4       to_r
    ld  (HL),E          ; 1:7       to_r
    exx                 ; 1:4       to_r 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store     
    exx                 ; 1:4       r_from
    ld    E,(HL)        ; 1:7       r_from
    inc   L             ; 1:4       r_from
    ld    D,(HL)        ; 1:7       r_from
    inc  HL             ; 1:6       r_from
    push DE             ; 1:11      r_from
    exx                 ; 1:4       r_from
    ex   DE, HL         ; 1:4       r_from
    ex  (SP), HL        ; 1:19      r_from 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store 

exch_slow_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
exch:                   ;           ( addr1 addr2 -- )
    pop  BC             ; 1:10      : ret
    ld  (exch_end+1),BC ; 4:20      : ( ret -- ) R:( -- ) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch        ;( read values)
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ex   DE, HL         ; 1:4       rot
    ex  (SP),HL         ; 1:19      rot ( c b a -- b a c ) 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store    ;( exchange values)

exch_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a non-recursive function  ---
partition:              ;           ( l r -- l r r2 l2 )
    pop  BC             ; 1:10      : ret
    ld  (partition_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    call mid            ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    ex  (SP), HL        ; 1:19      to_r
    ex   DE, HL         ; 1:4       to_r
    exx                 ; 1:4       to_r
    pop  DE             ; 1:10      to_r
    dec  HL             ; 1:6       to_r
    ld  (HL),D          ; 1:7       to_r
    dec   L             ; 1:4       to_r
    ld  (HL),E          ; 1:7       to_r
    exx                 ; 1:4       to_r ;( r: pivot )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
begin101:
        
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
begin102: 
            
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch      
    exx                 ; 1:4       r_fetch
    ld    E,(HL)        ; 1:7       r_fetch
    inc   L             ; 1:4       r_fetch
    ld    D,(HL)        ; 1:7       r_fetch
    dec   L             ; 1:6       r_fetch
    push DE             ; 1:11      r_fetch
    exx                 ; 1:4       r_fetch
    ex   DE, HL         ; 1:4       r_fetch
    ex  (SP), HL        ; 1:19      r_fetch 
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
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+ 
        
    jp   begin102       ; 3:10      repeat 102
break102:               ;           repeat 102
        
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
begin103: 
                
    exx                 ; 1:4       r_fetch
    ld    E,(HL)        ; 1:7       r_fetch
    inc   L             ; 1:4       r_fetch
    ld    D,(HL)        ; 1:7       r_fetch
    dec   L             ; 1:6       r_fetch
    push DE             ; 1:11      r_fetch
    exx                 ; 1:4       r_fetch
    ex   DE, HL         ; 1:4       r_fetch
    ex  (SP), HL        ; 1:19      r_fetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
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
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2- 
        
    jp   begin103       ; 3:10      repeat 103
break103:               ;           repeat 103
        
    ld    A, H          ; 1:4       2dup <= if
    xor   D             ; 1:4       2dup <= if
    ld    C, A          ; 1:4       2dup <= if
    ld    A, L          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sub   E             ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    ld    A, H          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    sbc   A, D          ; 1:4       2dup <= if    (DE<=HL) --> (HL-DE>=0) --> not carry if true
    rra                 ; 1:4       2dup <= if
    xor   C             ; 1:4       2dup <= if
    jp    m, else101    ; 3:10      2dup <= if 
            
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    call exch           ; 3:17      call ( -- ret ) R:( -- ) 
    ex  (SP), HL        ; 1:19      to_r
    ex   DE, HL         ; 1:4       to_r
    exx                 ; 1:4       to_r
    pop  DE             ; 1:10      to_r
    dec  HL             ; 1:6       to_r
    ld  (HL),D          ; 1:7       to_r
    dec   L             ; 1:4       to_r
    ld  (HL),E          ; 1:7       to_r
    exx                 ; 1:4       to_r 
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+     
    exx                 ; 1:4       r_from
    ld    E,(HL)        ; 1:7       r_from
    inc   L             ; 1:4       r_from
    ld    D,(HL)        ; 1:7       r_from
    inc  HL             ; 1:6       r_from
    push DE             ; 1:11      r_from
    exx                 ; 1:4       r_from
    ex   DE, HL         ; 1:4       r_from
    ex  (SP), HL        ; 1:19      r_from 
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2- 
        
else101  EQU $          ;           = endif
endif101:
    
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
    ld    A, H          ; 1:4       until 101
    or    L             ; 1:4       until 101
    ex   DE, HL         ; 1:4       until 101
    pop  DE             ; 1:10      until 101
    jp    z, begin101   ; 3:10      until 101
break101:               ;           until 101  
        
    exx                 ; 1:4       r_from
    ld    E,(HL)        ; 1:7       r_from
    inc   L             ; 1:4       r_from
    ld    D,(HL)        ; 1:7       r_from
    inc  HL             ; 1:6       r_from
    push DE             ; 1:11      r_from
    exx                 ; 1:4       r_from
    ex   DE, HL         ; 1:4       r_from
    ex  (SP), HL        ; 1:19      r_from 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 

partition_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
 

;   ---  the beginning of a recursive function  ---
qsort:                  ;           ( l r -- )
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  (HL),D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  (HL),E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon R:( -- ret )
    
    call partition      ; 3:17      call ( -- ret ) R:( -- ) 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ex   DE, HL         ; 1:4       rot
    ex  (SP),HL         ; 1:19      rot ( c b a -- b a c )
  ; 2over 2over - + < if 2swap then
    
    ld    A, H          ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    ld    C, A          ; 1:4       2dup < if
    ld    A, E          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    rra                 ; 1:4       2dup < if
    xor   C             ; 1:4       2dup < if
    jp    p, else102    ; 3:10      2dup < if 
    call qsort          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall    
    exx                 ; 1:4       rcall R:( ret -- ) 
    jp   endif102       ; 3:10      else
else102: 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
endif102:
    
    ld    A, H          ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    ld    C, A          ; 1:4       2dup < if
    ld    A, E          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    rra                 ; 1:4       2dup < if
    xor   C             ; 1:4       2dup < if
    jp    p, else103    ; 3:10      2dup < if 
    call qsort          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall    
    exx                 ; 1:4       rcall R:( ret -- ) 
    jp   endif103       ; 3:10      else
else103: 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
endif103: 

qsort_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,(HL)        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,(HL)        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  (HL)            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
 

;   ---  the beginning of a non-recursive function  ---
sort:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (sort_end+1),BC ; 4:20      : ( ret -- ) R:( -- ),( array len -- ))
    
    ld    A, H          ; 1:4       dup 2 < if
    add   A, A          ; 1:4       dup 2 < if
    jr    c, $+11       ; 2:7/12    dup 2 < if    positive constant
    ld    A, L          ; 1:4       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    sub   low 2         ; 2:7       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    ld    A, H          ; 1:4       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    sbc   A, high 2     ; 2:7       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    jp   nc, else104    ; 3:10      dup 2 < if 
        
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    jp   sort_end       ; 3:10      exit 
    
else104  EQU $          ;           = endif
endif104:
    
    dec  HL             ; 1:6       1- 
    add  HL, HL         ; 1:11      2* 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    call qsort          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall    
    exx                 ; 1:4       rcall R:( ret -- ) 

sort_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a data stack function  ---
stack_test:             ;           
    
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
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
; ( -- rand )
; 16-bit pseudorandom generator
; Out: HL = 0..65535
Rnd:
SEED EQU $+1
    ld   HL, 0x0001     ; 3:10      seed must not be 0
    ld    A, H          ; 1:4
    rra                 ; 1:4
    ld    A, L          ; 1:4
    rra                 ; 1:4
    xor   H             ; 1:4
    ld    H, A          ; 1:4       xs ^= xs << 7;
    rra                 ; 1:4
    xor   L             ; 1:4
    ld    L, A          ; 1:4       xs ^= xs >> 9;
    xor   H             ; 1:4
    ld    H, A          ; 1:4       xs ^= xs << 8;
    ld  (SEED), HL      ; 3:16

Rnd_8a EQU $+1
    ld    A, 0x01       ; 2:7
    rrca                ; 1:4       multiply by 32
    rrca                ; 1:4
    rrca                ; 1:4
    xor  0x1F           ; 2:7
Rnd_8b EQU $+1
    add   A, 0x01       ; 2:7
    sbc   A, 0xFF       ; 1:4       carry
    ld  (Rnd_8a), A     ; 3:13
    ld  (Rnd_8b), A     ; 3:13
    
    xor   H             ; 1:4
    ld    H, A          ; 1:4
    ld    A, R          ; 2:9
    xor   L             ; 1:4
    ld    L, A          ; 1:4
    ret                 ; 1:10
VARIABLE_SECTION:

STRING_SECTION:
string102:
db 0xD, "Data stack OK!", 0xD
size102 EQU $ - string102
string101:
db "RAS:"
size101 EQU $ - string101


test:
dw 700 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5

orig:
dw 7 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5

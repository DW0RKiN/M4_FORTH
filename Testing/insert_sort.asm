
    ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    ld  hl, stack_test
    push hl

    
    push DE             ; 1:11      push2(orig,test)
    ld   DE, orig       ; 3:10      push2(orig,test)
    push HL             ; 1:11      push2(orig,test)
    ld   HL, test       ; 3:10      push2(orig,test) 
    push DE             ; 1:11      push(2*10)
    ex   DE, HL         ; 1:4       push(2*10)
    ld   HL, 2*10       ; 3:10      push(2*10) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove
    
    push DE             ; 1:11      push2(test,10)
    ld   DE, test       ; 3:10      push2(test,10)
    push HL             ; 1:11      push2(test,10)
    ld   HL, 10         ; 3:10      push2(test,10) 
    call print          ; 3:17      call ( -- ret ) R:( -- )
    
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
print:                  ;           (addr len -- )
    pop  BC             ; 1:10      : ret
    ld  (print_end+1),BC; 4:20      : ( ret -- ) R:( -- )
  
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) ; addr len 1
  
    ld  (idx101), HL    ; 3:16      do 101 index
    ld    A, E          ; 1:4       do 101 
    ld  (stp_lo101), A  ; 3:13      do 101 lo stop
    ld    A, D          ; 1:4       do 101 
    ld  (stp_hi101), A  ; 3:13      do 101 hi stop
    pop  HL             ; 1:10      do 101
    pop  DE             ; 1:10      do 101 ( -- ) R: ( -- )
do101:                  ;           do 101 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      index i 101
    ex   DE, HL         ; 1:4       index i 101
    ld   HL, (idx101)   ; 3:16      index i 101 idx always points to a 16-bit index 
    add  HL, HL         ; 1:11      2* 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    call PRINT_U16      ; 3:17      .
  
idx101 EQU $+1          ;           loop 101
    ld   BC, 0x0000     ; 3:10      loop 101 idx always points to a 16-bit index
    inc  BC             ; 1:6       loop 101 index++
    ld  (idx101),BC     ; 4:20      loop 101 save index
    ld    A, C          ; 1:4       loop 101
stp_lo101 EQU $+1       ;           loop 101
    sub  0x00           ; 2:7       loop 101 lo index - stop
    ld    A, B          ; 1:4       loop 101
stp_hi101 EQU $+1       ;           loop 101
    sbc   A, 0x00       ; 2:7       loop 101 hi index - stop
    jp    c, do101      ; 3:10      loop 101
leave101:               ;           loop 101
exit101:                ;           loop 101 
  
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

print_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
insert:                 ;           ( start end -- start )
    pop  BC             ; 1:10      : ret
    ld  (insert_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
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
    exx                 ; 1:4       to_r ;( r: v ) v = a[i]
    
begin101:
        
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
    pop  DE             ; 1:10      <			; j>0
    
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101
            
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
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2- 
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
    pop  DE             ; 1:10      <		; a[j-1] > v
    
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101
        
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-			; j--
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+ 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store		; a[j] = a[j-1]
    
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101 
    ;
endifTHEN_STACK:
        
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

insert_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------		; a[j] = v
 

;   ---  the beginning of a non-recursive function  ---
sort:                   ;           ( array len -- )
    pop  BC             ; 1:10      : ret
    ld  (sort_end+1),BC ; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ld  (idx102), HL    ; 3:16      do 102 index
    ld    A, E          ; 1:4       do 102 
    ld  (stp_lo102), A  ; 3:13      do 102 lo stop
    ld    A, D          ; 1:4       do 102 
    ld  (stp_hi102), A  ; 3:13      do 102 hi stop
    pop  HL             ; 1:10      do 102
    pop  DE             ; 1:10      do 102 ( -- ) R: ( -- )
do102:                  ;           do 102 
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      index i 102
    ex   DE, HL         ; 1:4       index i 102
    ld   HL, (idx102)   ; 3:16      index i 102 idx always points to a 16-bit index 
    add  HL, HL         ; 1:11      2* 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    call insert         ; 3:17      call ( -- ret ) R:( -- ) 
    
idx102 EQU $+1          ;           loop 102
    ld   BC, 0x0000     ; 3:10      loop 102 idx always points to a 16-bit index
    inc  BC             ; 1:6       loop 102 index++
    ld  (idx102),BC     ; 4:20      loop 102 save index
    ld    A, C          ; 1:4       loop 102
stp_lo102 EQU $+1       ;           loop 102
    sub  0x00           ; 2:7       loop 102 lo index - stop
    ld    A, B          ; 1:4       loop 102
stp_hi102 EQU $+1       ;           loop 102
    sbc   A, 0x00       ; 2:7       loop 102 hi index - stop
    jp    c, do102      ; 3:10      loop 102
leave102:               ;           loop 102
exit102:                ;           loop 102 
    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 

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
string102:
db 0xD, "Data stack OK!", 0xD
size102 EQU $ - string102
string101:
db "RAS:"
size101 EQU $ - string101


test:
dw 7 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5

orig:
dw 7 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5

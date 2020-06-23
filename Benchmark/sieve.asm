ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx

    call do_prime       ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====

_size                EQU 8190


_size_add1           EQU 8191



;   ---  b e g i n  ---
do_prime:               ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )

    push DE             ; 1:11      flags 8191 1 fill
    push HL             ; 1:11      flags 8191 1 fill
    ld   HL, flags      ; 3:10      flags 8191 1 fill HL = from
    ld   DE, flags+1    ; 3:10      flags 8191 1 fill DE = to
    ld   BC, 8191-1     ; 3:10      flags 8191 1 fill
    ld  (HL),1          ; 2:10      flags 8191 1 fill
    ldir                ; 2:u*21/16 flags 8191 1 fill
    pop  HL             ; 1:10      flags 8191 1 fill
    pop  DE             ; 1:10      flags 8191 1 fill

    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push DE             ; 1:11      push2(8190,0)
    ld   DE, 8190       ; 3:10      push2(8190,0)
    push HL             ; 1:11      push2(8190,0)
    ld   HL, 0          ; 3:10      push2(8190,0) 
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
    
    push DE             ; 1:11      push(flags)
    ex   DE, HL         ; 1:4       push(flags)
    ld   HL, flags      ; 3:10      push(flags) 
    exx                 ; 1:4       index 101 i    
    ld    E,(HL)        ; 1:7       index 101 i
    inc   L             ; 1:4       index 101 i
    ld    D,(HL)        ; 1:7       index 101 i
    push DE             ; 1:11      index 101 i
    dec   L             ; 1:4       index 101 i
    exx                 ; 1:4       index 101 i
    ex   DE, HL         ; 1:4       index 101 i
    ex  (SP),HL         ; 1:19      index 101 i 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch
    
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if 
    exx                 ; 1:4       index 101 i    
    ld    E,(HL)        ; 1:7       index 101 i
    inc   L             ; 1:4       index 101 i
    ld    D,(HL)        ; 1:7       index 101 i
    push DE             ; 1:11      index 101 i
    dec   L             ; 1:4       index 101 i
    exx                 ; 1:4       index 101 i
    ex   DE, HL         ; 1:4       index 101 i
    ex  (SP),HL         ; 1:19      index 101 i 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    inc  HL             ; 1:6       3 +
    inc  HL             ; 1:6       3 +
    inc  HL             ; 1:6       3 + 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    exx                 ; 1:4       index 101 i    
    ld    E,(HL)        ; 1:7       index 101 i
    inc   L             ; 1:4       index 101 i
    ld    D,(HL)        ; 1:7       index 101 i
    push DE             ; 1:11      index 101 i
    dec   L             ; 1:4       index 101 i
    exx                 ; 1:4       index 101 i
    ex   DE, HL         ; 1:4       index 101 i
    ex  (SP),HL         ; 1:19      index 101 i 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
        
begin101: 
        
    push DE             ; 1:11      dup 8191
    push HL             ; 1:11      dup 8191
    ex   DE, HL         ; 1:4       dup 8191
    ld   HL, 8191       ; 3:10      dup 8191 
    ld    A, H          ; 1:4       < while 101
    xor   D             ; 1:4       < while 101
    ld    C, A          ; 1:4       < while 101
    ld    A, E          ; 1:4       < while 101    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       < while 101    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       < while 101    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       < while 101    (DE<HL) --> (DE-HL<0) --> carry if true
    rra                 ; 1:4       < while 101
    xor   C             ; 1:4       < while 101
    pop  HL             ; 1:10      < while 101
    pop  DE             ; 1:10      < while 101
    jp    p, break101   ; 3:10      < while 101 
            
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ; warning The condition (flags) cannot be evaluated
    ld   BC, flags      ; 3:10      flags +
    add  HL, BC         ; 1:11      flags + 
    ld  (HL),E          ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
        
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
        
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    inc  HL             ; 1:6       1+
    
else101  EQU $          ;           = endif
endif101:

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

    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

do_prime_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
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
string101:
db " PRIMES"
size101 EQU $ - string101



flags:

ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10
    exx                 ; 1:4

    call do_prime       ; 3:17      call ( -- ret ) R:( -- )

Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====

_size                EQU 8190


_size_add1           EQU 8191



;   ---  the beginning of a non-recursive function  ---
do_prime:               ;           
    pop  BC             ; 1:10      : ret
    ld  (do_prime_end+1),BC; 4:20      : ( ret -- ) R:( -- )

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
    ld  (idx101), HL    ; 3:16      do 101 save index
    dec  DE             ; 1:6       do 101 stop-1
    ld    A, E          ; 1:4       do 101 
    ld  (stp_lo101), A  ; 3:13      do 101 lo stop
    ld    A, D          ; 1:4       do 101 
    ld  (stp_hi101), A  ; 3:13      do 101 hi stop
    pop  HL             ; 1:10      do 101
    pop  DE             ; 1:10      do 101 ( -- ) R: ( -- )
do101:                  ;           do 101 
    
    push DE             ; 1:11      push(flags)
    ex   DE, HL         ; 1:4       push(flags)
    ld   HL, flags      ; 3:10      push(flags) 
    push DE             ; 1:11      index i 101
    ex   DE, HL         ; 1:4       index i 101
    ld   HL, (idx101)   ; 3:16      index i 101 idx always points to a 16-bit index 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch
    
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if 
    push DE             ; 1:11      index i 101
    ex   DE, HL         ; 1:4       index i 101
    ld   HL, (idx101)   ; 3:16      index i 101 idx always points to a 16-bit index 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    inc  HL             ; 1:6       1+ 
    add  HL, HL         ; 1:11      dup + 
    inc  HL             ; 1:6       1+ 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    add  HL, DE         ; 1:11      over +
        
begin101: 
        
    ld    A, L          ; 1:4       dup 8191 u< while 101    HL<8191 --> HL-8191<0 --> carry if true
    sub   low 8191      ; 2:7       dup 8191 u< while 101    HL<8191 --> HL-8191<0 --> carry if true
    ld    A, H          ; 1:4       dup 8191 u< while 101    HL<8191 --> HL-8191<0 --> carry if true
    sbc   A, high 8191  ; 2:7       dup 8191 u< while 101    HL<8191 --> HL-8191<0 --> carry if true
    jp   nc, break101   ; 3:10      dup 8191 u< while 101
            
    push DE             ; 1:11      0 over
    push HL             ; 1:11      0 over
    ld   DE, 0          ; 3:10      0 over ( a -- a 0 a ) 
    ; warning The condition >>>flags<<< cannot be evaluated
    ld   BC, flags      ; 3:10      flags +
    add  HL, BC         ; 1:11      flags + 
    ld  (HL),E          ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore 
    add  HL, DE         ; 1:11      over + 
        
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
        
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    inc  HL             ; 1:6       1+
    
else101  EQU $          ;           = endif
endif101:

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

    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

do_prime_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



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
string101:
db " PRIMES"
size101 EQU $ - string101



flags:

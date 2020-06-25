    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000
    exx
    
    call fib2s_bench    ; 3:17      scall
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
    
;   ---  b e g i n  ---
fib2s:                  ;           ( n1 -- n2 )
        
    push DE             ; 1:11      push2(0,1)
    ld   DE, 0          ; 3:10      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1) 
    ex   DE, HL         ; 1:4       rot
    ex  (SP), HL        ; 1:19      rot ( c b a -- b a c ) 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push HL             ; 1:11      ?do 101 index
    or    A             ; 1:4       ?do 101
    sbc  HL, DE         ; 2:15      ?do 101
    jr   nz, $+8        ; 2:7/12    ?do 101
    pop  HL             ; 1:10      ?do 101
    pop  HL             ; 1:10      ?do 101
    pop  DE             ; 1:10      ?do 101
    jp   exit101        ; 3:10      ?do 101   
    push DE             ; 1:11      ?do 101 stop
    exx                 ; 1:4       ?do 101
    pop  DE             ; 1:10      ?do 101 stop
    dec  HL             ; 1:6       ?do 101
    ld  (HL),D          ; 1:7       ?do 101
    dec  L              ; 1:4       ?do 101
    ld  (HL),E          ; 1:7       ?do 101 stop
    pop  DE             ; 1:10      ?do 101 index
    dec  HL             ; 1:6       ?do 101
    ld  (HL),D          ; 1:7       ?do 101
    dec  L              ; 1:4       ?do 101
    ld  (HL),E          ; 1:7       ?do 101 index
    exx                 ; 1:4       ?do 101
    pop  HL             ; 1:10      ?do 101
    pop  DE             ; 1:10      ?do 101 ( stop index -- ) R: ( -- stop index )
do101: 
            
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
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
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
fib2s_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----
    
;   ---  b e g i n  ---
fib2s_bench:            ;           ( -- )
        

    exx                 ; 1:4       xdo(1,0) 102
    dec  HL             ; 1:6       xdo(1,0) 102
    ld  (HL),high 0     ; 2:10      xdo(1,0) 102
    dec   L             ; 1:4       xdo(1,0) 102
    ld  (HL),low 0      ; 2:10      xdo(1,0) 102
    exx                 ; 1:4       xdo(1,0) 102 R:( -- 0 )
xdo102:                 ;           xdo(1,0) 102 
            

    exx                 ; 1:4       xdo(20,0) 103
    dec  HL             ; 1:6       xdo(20,0) 103
    ld  (HL),high 0     ; 2:10      xdo(20,0) 103
    dec   L             ; 1:4       xdo(20,0) 103
    ld  (HL),low 0      ; 2:10      xdo(20,0) 103
    exx                 ; 1:4       xdo(20,0) 103 R:( -- 0 )
xdo103:                 ;           xdo(20,0) 103 
    exx                 ; 1:4       index xi 103
    ld    E,(HL)        ; 1:7       index xi 103
    inc   L             ; 1:4       index xi 103
    ld    D,(HL)        ; 1:7       index xi 103
    push DE             ; 1:11      index xi 103
    dec   L             ; 1:4       index xi 103
    exx                 ; 1:4       index xi 103 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 103
    ex  (SP),HL         ; 1:19      index xi 103 ( -- x ) 
    call fib2s          ; 3:17      scall 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       xloop(20,0) 103
    ld    E,(HL)        ; 1:7       xloop(20,0) 103
    inc   L             ; 1:4       xloop(20,0) 103
    ld    D,(HL)        ; 1:7       xloop(20,0) 103
    inc  DE             ; 1:6       xloop(20,0) 103 index++
    ld    A, low 20     ; 2:7       xloop(20,0) 103
    xor   E             ; 1:4       xloop(20,0) 103
    jr   nz, $+7        ; 2:7/12    xloop(20,0) 103
    ld    A, high 20    ; 2:7       xloop(20,0) 103
    xor   D             ; 1:4       xloop(20,0) 103
    jr    z, xleave103  ; 2:7/12    xloop(20,0) 103 exit
    ld  (HL), D         ; 1:7       xloop(20,0) 103
    dec   L             ; 1:4       xloop(20,0) 103
    ld  (HL), E         ; 1:6       xloop(20,0) 103
    exx                 ; 1:4       xloop(20,0) 103
    jp   xdo103         ; 3:10      xloop(20,0) 103
xleave103:              ;           xloop(20,0) 103
    inc  HL             ; 1:6       xloop(20,0) 103
    exx                 ; 1:4       xloop(20,0) 103 R:( index -- )
xexit103 EQU $
        
    exx                 ; 1:4       xloop(1,0) 102
    ld    E,(HL)        ; 1:7       xloop(1,0) 102
    inc   L             ; 1:4       xloop(1,0) 102
    ld    D,(HL)        ; 1:7       xloop(1,0) 102
    inc  DE             ; 1:6       xloop(1,0) 102 index++
    ld    A, low 1      ; 2:7       xloop(1,0) 102
    xor   E             ; 1:4       xloop(1,0) 102
    jr   nz, $+7        ; 2:7/12    xloop(1,0) 102
    ld    A, high 1     ; 2:7       xloop(1,0) 102
    xor   D             ; 1:4       xloop(1,0) 102
    jr    z, xleave102  ; 2:7/12    xloop(1,0) 102 exit
    ld  (HL), D         ; 1:7       xloop(1,0) 102
    dec   L             ; 1:4       xloop(1,0) 102
    ld  (HL), E         ; 1:6       xloop(1,0) 102
    exx                 ; 1:4       xloop(1,0) 102
    jp   xdo102         ; 3:10      xloop(1,0) 102
xleave102:              ;           xloop(1,0) 102
    inc  HL             ; 1:6       xloop(1,0) 102
    exx                 ; 1:4       xloop(1,0) 102 R:( index -- )
xexit102 EQU $
    
fib2s_bench_end:
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


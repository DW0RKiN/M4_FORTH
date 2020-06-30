    ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    ld  hl, stack_test
    push hl

    
begin101: 
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call READKEY        ; 3:17      key 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(0xD)
    ex   DE, HL         ; 1:4       push(0xD)
    ld   HL, 0xD        ; 3:10      push(0xD) 
    ld    A, E          ; 1:4       xor
    xor   L             ; 1:4       xor
    ld    L, A          ; 1:4       xor
    ld    A, D          ; 1:4       xor
    xor   H             ; 1:4       xor
    ld    H, A          ; 1:4       xor
    pop  DE             ; 1:10      xor 
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, L          ; 1:4       emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      emit    with 48K ROM in, this will print char in A
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    call PRINT_U16      ; 3:17      . 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(BUFFER,10)
    ld   DE, BUFFER     ; 3:10      push2(BUFFER,10)
    push HL             ; 1:11      push2(BUFFER,10)
    ld   HL, 10         ; 3:10      push2(BUFFER,10) 
    call READSTRING     ; 3:17      accept 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    push DE             ; 1:11      push(BUFFER)
    ex   DE, HL         ; 1:4       push(BUFFER)
    ld   HL, BUFFER     ; 3:10      push(BUFFER) 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    push DE             ; 1:11      push(BUFFER)
    ex   DE, HL         ; 1:4       push(BUFFER)
    ld   HL, BUFFER     ; 3:10      push(BUFFER) 
    ld  (idx101), HL    ; 3:16      do 101 index
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
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    push DE             ; 1:11      push(0xFF)
    ex   DE, HL         ; 1:4       push(0xFF)
    ld   HL, 0xFF       ; 3:10      push(0xFF) 
    ld    A, E          ; 1:4       and
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and 
    ld    A, L          ; 1:4       emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      emit    with 48K ROM in, this will print char in A
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
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
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
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
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
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
; Read key from keyboard
; In: 
; Out: push stack, TOP = HL = key
READKEY:
    ex   DE, HL         ; 1:4       readkey
    ex  (SP),HL         ; 1:19      readkey
    push HL             ; 1:11      readkey
    ld   BC, 0x5C08     ; 3:10      readkey ZX Spectrum LAST K system variable
    xor   A             ; 1:4       readkey
    ld    H, A          ; 1:4       readkey
    ld  (BC),A          ; 1:7       readkey
    ld    A,(BC)        ; 1:7       readkey read new value of LAST K
    cp    H             ; 1:4       readkey is it still zero?
    jr    z, $-2        ; 2:7/12    readkey
    ld    L, A          ; 1:4       readkey
    ret                 ; 1:10      readkey
; Read string from keyboard
; In: DE = addr, HL = length 
; Out: 2x pop stack, TOP = HL = loaded
READSTRING:
    ld    B, D          ; 1:4       readstring
    ld    C, E          ; 1:4       readstring BC = addr
    ex   DE, HL         ; 1:4       readstring 
READSTRING2:
    xor   A             ; 1:4       readstring
    ld    (0x5C08),A    ; 3:13      readstring ZX Spectrum LAST K system variable
    
    ld    A,(0x5C08)    ; 3:13      readstring read new value of LAST K
    or    A             ; 1:4       readstring is it still zero?
    jr    z, $-4        ; 2:7/12    readstring

    cp  0x0D            ; 2:7       readstring enter?
    jr    z, READSTRING3; 2:7/12    readstring
    ld  (HL),A          ; 1:7       readstring
    inc  HL             ; 1:6       readstring
    dec  DE             ; 1:6       readstring
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A    
    ld    A, D          ; 1:4       readstring
    or    E             ; 1:4       readstring
    jr   nz, READSTRING2; 2:7/12    readstring
READSTRING3:
    or    A             ; 1:4       readstring
    sbc  HL, BC         ; 2:15      readstring
    
    pop  BC             ; 1:10      readstring ret
    pop  DE             ; 1:10      readstring
    push BC             ; 1:11      readstring ret
    ret                 ; 1:10      readstring
VARIABLE_SECTION:

STRING_SECTION:
string104:
db 0xD, "Data stack OK!", 0xD
size104 EQU $ - string104
string103:
db "RAS:"
size103 EQU $ - string103
string102:
db 0xD,"10 char string: "
size102 EQU $ - string102
string101:
db "Press any key: "
size101 EQU $ - string101


BUFFER:
DS 10

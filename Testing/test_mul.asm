


ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10      Init Return address stack
    exx                 ; 1:4

    push DE             ; 1:11      push(65535)
    ex   DE, HL         ; 1:4       push(65535)
    ld   HL, 65535      ; 3:10      push(65535) 
sfor101:                ;           sfor 101 ( index -- index ) 


    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )

                        ;[11:107]   83 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_0011)
    ld    B, H          ; 1:4       83 *
    ld    C, L          ; 1:4       83 *   1       1x = base 
    add  HL, HL         ; 1:11      83 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      83 *   1  *2 = 4x
    add  HL, BC         ; 1:11      83 *      +1 = 5x 
    add  HL, HL         ; 1:11      83 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      83 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      83 *   1  *2 = 40x
    add  HL, BC         ; 1:11      83 *      +1 = 41x 
    add  HL, HL         ; 1:11      83 *   1  *2 = 82x
    add  HL, BC         ; 1:11      83 *      +1 = 83x  

    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )

    push DE             ; 1:11      push(83)
    ex   DE, HL         ; 1:4       push(83)
    ld   HL, 83         ; 3:10      push(83)

    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *

    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else101    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else101    ; 3:10      2dup = if 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    jp   endif101       ; 3:10      else
else101: 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
endif101:


    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )

                        ;[12:97]    293 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0010_0101)
    ld    B, H          ; 1:4       293 *
    ld    C, L          ; 1:4       293 *   1       1x = base 
    ld    A, L          ; 1:4       293 *       L = 1x 
    add  HL, HL         ; 1:11      293 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      293 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      293 *   1  *2 = 8x
    add  HL, BC         ; 1:11      293 *      +1 = 9x 
    add  HL, HL         ; 1:11      293 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      293 *   1  *2 = 36x
    add  HL, BC         ; 1:11      293 *      +1 = 37x 
    add   A, H          ; 1:4       293 *
    ld    H, A          ; 1:4       293 *     [293x] = 37x + 256*1x 

    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )

    push DE             ; 1:11      push(293)
    ex   DE, HL         ; 1:4       push(293)
    ld   HL, 293        ; 3:10      push(293)

    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *

    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else102    ; 3:10      2dup = if 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    jp   endif102       ; 3:10      else
else102: 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
endif102:


    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )

                        ;[13:108]   1069 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0010_1101)
    ld    B, H          ; 1:4       1069 *
    ld    C, L          ; 1:4       1069 *   1       1x = base 
    add  HL, HL         ; 1:11      1069 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1069 *   1  *2 = 4x
    ld    A, L          ; 1:4       1069 *      +L = 4x
    add  HL, BC         ; 1:11      1069 *      +1 = 5x 
    add  HL, HL         ; 1:11      1069 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1069 *      +1 = 11x 
    add  HL, HL         ; 1:11      1069 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1069 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1069 *      +1 = 45x 
    add   A, H          ; 1:4       1069 *
    ld    H, A          ; 1:4       1069 *     [1069x] = 45x + 256*4x 

    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )

    push DE             ; 1:11      push(1069)
    ex   DE, HL         ; 1:4       push(1069)
    ld   HL, 1069       ; 3:10      push(1069)

    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *

    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else103    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else103    ; 3:10      2dup = if 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    jp   endif103       ; 3:10      else
else103: 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
endif103:


    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )

                        ;[14:105]   3877 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_1111_0010_0101)
    ld    B, H          ; 1:4       3877 *
    ld    C, L          ; 1:4       3877 *   1       1x = base 
    add  HL, HL         ; 1:11      3877 *   0  *2 = 2x 
    ld    A, L          ; 1:4       3877 *       L = 2x 
    add  HL, HL         ; 1:11      3877 *   0  *2 = 4x 
    add   A, L          ; 1:4       3877 *      +L = 6x 
    add  HL, HL         ; 1:11      3877 *   1  *2 = 8x
    add  HL, BC         ; 1:11      3877 *      +1 = 9x 
    add   A, L          ; 1:4       3877 *      +L = 15x 
    add  HL, HL         ; 1:11      3877 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      3877 *   1  *2 = 36x
    add  HL, BC         ; 1:11      3877 *      +1 = 37x 
    add   A, H          ; 1:4       3877 *
    ld    H, A          ; 1:4       3877 *     [3877x] = 37x + 256*15x 

    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )

    push DE             ; 1:11      push(3877)
    ex   DE, HL         ; 1:4       push(3877)
    ld   HL, 3877       ; 3:10      push(3877)

    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *

    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else104    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else104    ; 3:10      2dup = if 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    jp   endif104       ; 3:10      else
else104: 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
endif104:


    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )

                        ;[15:130]   13933 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_0110_1101)
    ld    B, H          ; 1:4       13933 *
    ld    C, L          ; 1:4       13933 *   1       1x = base 
    add  HL, HL         ; 1:11      13933 *   1  *2 = 2x
    add  HL, BC         ; 1:11      13933 *      +1 = 3x 
    add  HL, HL         ; 1:11      13933 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      13933 *   1  *2 = 12x
    add  HL, BC         ; 1:11      13933 *      +1 = 13x 
    add  HL, HL         ; 1:11      13933 *   1  *2 = 26x
    add  HL, BC         ; 1:11      13933 *      +1 = 27x 
    add  HL, HL         ; 1:11      13933 *   0  *2 = 54x 
    ld    A, L          ; 1:4       13933 *       L = 54x 
    add  HL, HL         ; 1:11      13933 *   1  *2 = 108x
    add  HL, BC         ; 1:11      13933 *      +1 = 109x 
    add   A, H          ; 1:4       13933 *
    ld    H, A          ; 1:4       13933 *     [13933x] = 109x + 256*54x 

    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )

    push DE             ; 1:11      push(13933)
    ex   DE, HL         ; 1:4       push(13933)
    ld   HL, 13933      ; 3:10      push(13933)

    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *

    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else105    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else105    ; 3:10      2dup = if 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    jp   endif105       ; 3:10      else
else105: 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size110    ; 3:10      print Length of string to print
    ld   DE, string110  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
endif105:


    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )

                        ;[22:144]   50207 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_1100_0100_0001_1111)
    ld    B, H          ; 1:4       50207 *
    ld    C, L          ; 1:4       50207 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      50207 *   1  *2 = 2x
    add  HL, BC         ; 1:11      50207 *      +1 = 3x 
    add  HL, HL         ; 1:11      50207 *   1  *2 = 6x
    add  HL, BC         ; 1:11      50207 *      +1 = 7x 
    add  HL, HL         ; 1:11      50207 *   1  *2 = 14x
    add  HL, BC         ; 1:11      50207 *      +1 = 15x 
    add  HL, HL         ; 1:11      50207 *   1  *2 = 30x
    add  HL, BC         ; 1:11      50207 *      +1 = 31x  
    ld    A, C          ; 1:4       50207 *   1       1x 
    add   A, A          ; 1:4       50207 *   1  *2 = 2x
    add   A, C          ; 1:4       50207 *      +1 = 3x 
    add   A, A          ; 1:4       50207 *   0  *2 = 6x 
    add   A, A          ; 1:4       50207 *   0  *2 = 12x 
    add   A, A          ; 1:4       50207 *   0  *2 = 24x 
    add   A, A          ; 1:4       50207 *   1  *2 = 48x
    add   A, C          ; 1:4       50207 *      +1 = 49x 
    add   A, A          ; 1:4       50207 *   0  *2 = 98x 
    add   A, A          ; 1:4       50207 *   0  *2 = 196x 
    add   A, H          ; 1:4       50207 *
    ld    H, A          ; 1:4       50207 *     [50207x] = 256 * 196x + 31x 

    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b )

    push DE             ; 1:11      push(50207)
    ex   DE, HL         ; 1:4       push(50207)
    ld   HL, 50207      ; 3:10      push(50207)

    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *

    ld    A, E          ; 1:4       2dup = if
    sub   L             ; 1:4       2dup = if
    jp   nz, else106    ; 3:10      2dup = if
    ld    A, D          ; 1:4       2dup = if
    sub   H             ; 1:4       2dup = if
    jp   nz, else106    ; 3:10      2dup = if 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 
    jp   endif106       ; 3:10      else
else106: 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size111    ; 3:10      print Length of string to print
    ld   DE, string111  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size112    ; 3:10      print Length of string to print
    ld   DE, string112  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
endif106:



    ld   A, H           ; 1:4       snext 101
    or   L              ; 1:4       snext 101
    dec  HL             ; 1:6       snext 101 index--
    jp  nz, sfor101     ; 3:10      snext 101
snext101:               ;           snext 101
    ex   DE, HL         ; 1:4       sfor unloop 101
    pop  DE             ; 1:10      sfor unloop 101

Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====



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
; Input: HL,DE
; Output: HL=HL*DE ((un)signed)
; It does not matter whether it is signed or unsigned multiplication.
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[36:???-627] test8 version   
    xor   A             ; 1:4
    ld    C, E          ; 1:4

    srl   H             ; 2:8       divide H by 2
    jr   nc, $+3        ; 2:7/12        
MULTIPLY1:
    add   A, C          ; 1:4       A += C(originalE)

    sla   C             ; 2:8       C(originalE) *= 2
    srl   H             ; 2:8       H /= 2
    jr    c, MULTIPLY1  ; 2:7/12
    jp   nz, MULTIPLY1+1; 3:10      H = ?

    ld    C, L          ; 1:4
    ld    L, H          ; 1:4       L = 0
    ld    H, A          ; 1:4       HL *= E

    srl   C             ; 2:8       divide C(originalL) by 2
    jr   nc, $+3        ; 2:7/12    
MULTIPLY2:
    add  HL, DE         ; 1:11
    
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2    

    srl   C             ; 2:8       divide C(originalL) by 2
    jr    c, MULTIPLY2  ; 2:7/12
    jp   nz, MULTIPLY2+1; 3:10      C = ?

    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY
VARIABLE_SECTION:

STRING_SECTION:
string112:
db "=50207*"
size112 EQU $ - string112
string111:
db "!="
size111 EQU $ - string111
string110:
db "=13933*"
size110 EQU $ - string110
string109:
db "!="
size109 EQU $ - string109
string108:
db "=3877*"
size108 EQU $ - string108
string107:
db "!="
size107 EQU $ - string107
string106:
db "=1069*"
size106 EQU $ - string106
string105:
db "!="
size105 EQU $ - string105
string104:
db "=293*"
size104 EQU $ - string104
string103:
db "!="
size103 EQU $ - string103
string102:
db "=83*"
size102 EQU $ - string102
string101:
db "!="
size101 EQU $ - string101


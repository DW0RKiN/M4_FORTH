


ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init

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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
    call PRINT_STRING_Z ; 3:17      print_z 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101 == string103
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104
    call PRINT_STRING_Z ; 3:17      print_z 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101 == string105
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106
    call PRINT_STRING_Z ; 3:17      print_z 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101 == string107
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108
    call PRINT_STRING_Z ; 3:17      print_z 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101 == string109
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110
    call PRINT_STRING_Z ; 3:17      print_z 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101 == string111
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112
    call PRINT_STRING_Z ; 3:17      print_z 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
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

Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====


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
    and  0xF0           ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
;==============================================================================
; Input: HL,DE
; Output: HL=HL*DE ((un)signed)
; It does not matter whether it is signed or unsigned multiplication.
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[148:cca 359-428] fast version

                        ;           HL = HL*DE = HL*E + 256*D*L
    ld    B, H          ; 1:4
    ld    C, L          ; 1:4       HL = BC = base 1x

    ld    A, E          ; 1:4       DE check bits
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E7; 2:7/12
    jr    z, MULTIPLY_D ; 2:7/12    <-------------+
    add   A, A          ; 1:4                     |
    jr    c, MULTIPLY_E6; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E5; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E4; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E3; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E2; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E1; 2:7/12                  |
    add   A, A          ; 1:4                     |
    jr    c, MULTIPLY_E0; 2:7/12    always carry -+
                        ;
MULTIPLY_D:             ;           A == E == 0
    ld    H, A          ; 1:4
    ld    L, A          ; 1:4       HL = 0

    sla   D             ; 2:8       check D 1000_0000 bit
    jr    c, MULTIPLY_D7; 2:7/12
    ret   z             ; 1:5/11
    sla   D             ; 2:8       check D 0100_0000 bit
    jr    c, MULTIPLY_D6; 2:7/12
    sla   D             ; 2:8       check D 0010_0000 bit
    jr    c, MULTIPLY_D5; 2:7/12
    sla   D             ; 2:8       check D 0001_0000 bit
    jr    c, MULTIPLY_D4; 2:7/12
    sla   D             ; 2:8       check D 0000_1000 bit
    jr    c, MULTIPLY_D3; 2:7/12
    sla   D             ; 2:8       check D 0000_0100 bit
    jr    c, MULTIPLY_D2; 2:7/12
    sla   D             ; 2:8       check D 0000_0010 bit
    jr    c, MULTIPLY_D1; 2:7/12
                        ;           D == 1
    ld    H, C          ; 1:4       HL = 256*HL
    ret                 ; 1:10

MULTIPLY_E7:            ;           HL 1x --> 128x
    add  HL, HL         ; 1:11

    add   A, A          ; 1:4       check E 0100_0000 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E6:            ;           HL 1x --> 64x
    add  HL, HL         ; 1:11

    add   A, A          ; 1:4       check E 0010_0000 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E5:            ;           HL 1x --> 32x
    add  HL, HL         ; 1:11

    add   A, A          ; 1:4       check E 0001_0000 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E4:            ;           HL 1x --> 16x
    add  HL, HL         ; 1:11

    add   A, A          ; 1:4       check E 0000_1000 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E3:            ;           HL 1x --> 8x
    add  HL, HL         ; 1:11

    add   A, A          ; 1:4       check E 0000_0100 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E2:            ;           HL 1x --> 4x
    add  HL, HL         ; 1:11

    add   A, A          ; 1:4       check E 0000_0010 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E1:            ;           HL 1x --> 2x
    add  HL, HL         ; 1:11

    add   A, A          ; 1:4       check E 0000_0001 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E0:            ;           A = 0

    sla   D             ; 2:8       check D 1000_0000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D7:
    add   A, C          ; 1:4
    ret   z             ; 1:5/11    (D == 0 || C == 0) --> zero flag --> HL = HL*E

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0100_0000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D6:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0010_0000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D5:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0001_0000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D4:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0000_1000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D3:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0000_0100 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D2:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0000_0010 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D1:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0000_0001 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D0:
    add   A, C          ; 1:4

    add   A, H          ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY
;==============================================================================
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst  0x10           ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z

STRING_SECTION:
string112:
db "=50207*", 0x00
size112 EQU $ - string112
string110:
db "=13933*", 0x00
size110 EQU $ - string110
string108:
db "=3877*", 0x00
size108 EQU $ - string108
string106:
db "=1069*", 0x00
size106 EQU $ - string106
string104:
db "=293*", 0x00
size104 EQU $ - string104
string102:
db "=83*", 0x00
size102 EQU $ - string102
string101:
db "!=", 0x00
size101 EQU $ - string101

    ORG 0x8000








    
      
           
       
          
          
                ; next odd number
         
             
        
    
     



        



;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    call _bench         ; 3:17      scall
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
_decomp:                ;           ( n -- )
    pop  BC             ; 1:10      : ret
    ld  (_decomp_end+1),BC; 4:20      : ( ret -- )
    push DE             ; 1:11      2
    ex   DE, HL         ; 1:4       2
    ld   HL, 2          ; 3:10      2
begin101:               ;           begin(101)
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
                        ;[9:46]     u>= while(101)   ( x2 x1 -- )
    ld    A, E          ; 1:4       u>= while(101)   DE>=HL --> DE-HL>=0 --> false if carry
    sub   L             ; 1:4       u>= while(101)   DE>=HL --> DE-HL>=0 --> false if carry
    ld    A, D          ; 1:4       u>= while(101)   DE>=HL --> DE-HL>=0 --> false if carry
    sbc   A, H          ; 1:4       u>= while(101)   DE>=HL --> DE-HL>=0 --> false if carry
    pop  HL             ; 1:10      u>= while(101)
    pop  DE             ; 1:10      u>= while(101)
    jp    c, break101   ; 3:10      u>= while(101)
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    call UDIVIDE        ; 3:17      u/mod
    ld    A, D          ; 1:4       swap if
    or    E             ; 1:4       swap if
    pop  DE             ; 1:10      swap if
    jp    z, else101    ; 3:10      swap if
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    set   0, L          ; 2:8       1 or
    jp   endif101       ; 3:10      else
else101:                ;           else
    pop  AF             ; 1:10      nrot nip   ( c b a -- a b )
    ex   DE, HL         ; 1:4       nrot nip
endif101:               ;           then
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
    pop  HL             ; 1:10      2drop   ( b a -- )
    pop  DE             ; 1:10      2drop
_decomp_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a data stack function  ---
_bench:                 ;           ( -- )
    push DE             ; 1:11      10000
    ex   DE, HL         ; 1:4       10000
    ld   HL, 10000      ; 3:10      10000
for101:                 ;           for_101(s) ( index -- index )
                        ;           i_101(s)   ( -- i )
    push DE             ; 1:11      i_101(s)   ( a -- a a )
    ld    D, H          ; 1:4       i_101(s)
    ld    E, L          ; 1:4       i_101(s)
    call _decomp        ; 3:17      call ( -- )
    ld    A, H          ; 1:4       next_101(s)
    or    L             ; 1:4       next_101(s)
    dec  HL             ; 1:6       next_101(s)   index--
    jp  nz, for101      ; 3:10      next_101(s)
leave101:               ;           next_101(s)
    ex   DE, HL         ; 1:4       unloop_101(s)   ( i -- )
    pop  DE             ; 1:10      unloop_101(s)
_bench_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;#==============================================================================
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
;#==============================================================================
; Divide 16-bit unsigned values (with 16-bit result)
; In: DE / HL
; Out: HL = DE / HL, DE = DE % HL
UDIVIDE:
                        ;           old_fast version
    ex   DE, HL         ; 1:4       HL/DE
    ld    A, D          ; 1:4
    or    A             ; 1:4
    jp   nz, UDIVIDE_16 ; 3:10      HL/0E

    sla   H             ; 2:8       AHL = 0HL
    jr    c, UDIVIDE1   ; 2:7/12
    jr    z, UDIVIDE_8H ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE2   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE3   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE4   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE5   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE6   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE7   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE8   ; 2:7/12
UDIVIDE_8H:
    sla   L             ; 2:8
    jr    c, UDIVIDE9   ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE10  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE11  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE12  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE13  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE14  ; 2:7/12
    sla   L             ; 2:8
    jp    c, UDIVIDE15  ; 3:10
    sla   L             ; 2:8
    jp    c, UDIVIDE16  ; 3:10

    ld    E, D          ; 1:4
    ret                 ; 1:10

;1
UDIVIDE1:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;2
    sla   H             ; 2:8
UDIVIDE2:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;3
    sla   H             ; 2:8
UDIVIDE3:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;4
    sla   H             ; 2:8
UDIVIDE4:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;5
    sla   H             ; 2:8
UDIVIDE5:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;6
    sla   H             ; 2:8
UDIVIDE6:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;7
    sla   H             ; 2:8
UDIVIDE7:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;8
    sla   H             ; 2:8
UDIVIDE8:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4

;9
    sla   L             ; 2:8
UDIVIDE9:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;10
    sla   L             ; 2:8
UDIVIDE10:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;11
    sla   L             ; 2:8
UDIVIDE11:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;12
    sla   L             ; 2:8
UDIVIDE12:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;13
    sla   L             ; 2:8
UDIVIDE13:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;14
    sla   L             ; 2:8
UDIVIDE14:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;15
    sla   L             ; 2:8
UDIVIDE15:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;16
    sla   L             ; 2:8
UDIVIDE16:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4

    ld    E, A          ; 1:4       DE = DE % HL
    ret                 ; 1:10

UDIVIDE_16:             ;           DE >= 256
    ld    A, L          ; 1:4
    ld    L, H          ; 1:4
    ld    H, 0x00       ; 2:7       00HL --> 0HLA

;1 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;2 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;3 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;4 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;5 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;6 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;7 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;8 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

    rla                 ; 1:4
    cpl                 ; 1:4
    ex   DE, HL         ; 1:4
    ld    H, 0x00       ; 2:7
    ld    L, A          ; 1:4
    ret                 ; 1:10
ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10      Init Return address stack
    exx                 ; 1:4

    call _bench         ; 3:17      scall

Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====





;   ---  the beginning of a non-recursive function  ---
_decomp:                ;           ( n -- )
    pop  BC             ; 1:10      : ret
    ld  (_decomp_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2)
    
begin101:  
        
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    
    ld    A, E          ; 1:4       u>= while 101    DE>=HL --> DE-HL>=0 --> not carry if true
    sub   L             ; 1:4       u>= while 101    DE>=HL --> DE-HL>=0 --> not carry if true
    ld    A, D          ; 1:4       u>= while 101    DE>=HL --> DE-HL>=0 --> not carry if true
    sbc   A, H          ; 1:4       u>= while 101    DE>=HL --> DE-HL>=0 --> not carry if true
    pop  HL             ; 1:10      u>= while 101
    pop  DE             ; 1:10      u>= while 101
    jp    c, break101   ; 3:10      u>= while 101  
        
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    call UDIVIDE        ; 3:17      u/mod 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
        
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if 
            
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    inc  HL             ; 1:6       1+ 
    set   0, L          ; 2:8       1 or ; next odd number
        
    jp   endif101       ; 3:10      else
else101: 
            
    ex  (SP), HL        ; 1:19      nrot
    ex   DE, HL         ; 1:4       nrot ( c b a -- a c b ) 
    pop  DE             ; 1:10      nip ( b a -- a )
        
endif101:
    
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
    
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- ) 

_decomp_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a data stack function  ---
_bench:                 ;           ( -- )
    
    push DE             ; 1:11      push(10000)
    ex   DE, HL         ; 1:4       push(10000)
    ld   HL, 10000      ; 3:10      push(10000) 
sfor101:                ;           sfor 101 ( index -- index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call _decomp        ; 3:17      call ( -- ret ) R:( -- ) 
    ld   A, H           ; 1:4       snext 101
    or   L              ; 1:4       snext 101
    dec  HL             ; 1:6       snext 101 index--
    jp  nz, sfor101     ; 3:10      snext 101
snext101:               ;           snext 101
    ex   DE, HL         ; 1:4       sfor unloop 101
    pop  DE             ; 1:10      sfor unloop 101

_bench_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------



; Input: HL,DE
; Output: HL=HL*DE ((un)signed)
; It does not matter whether it is signed or unsigned multiplication.
; Pollutes: AF, B, DE
MULTIPLY:
    ld    A, H          ; 1:4       fast version
    sub   D             ; 1:4
    jr    c, $+3        ; 2:7/12
    ex   DE, HL         ; 1:4       H=>D faster 7+4<12
    
    ld    A, H          ; 1:4
    ld    C, L          ; 1:4
    ld   HL, 0x0000     ; 3:10
    
    add   A, A          ; 1:4
    jr    c, MULTIPLY1  ; 2:7/12
    jr    z, MULTIPLY_LO; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY2  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY3  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY4  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY5  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY6  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY7  ; 2:7/12    
    jp   MULTIPLY8      ; 3:10
MULTIPLY_LO:
    ld    A, C          ; 1:4
    add   A, A          ; 1:4
    jr    c, MULTIPLY9  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY10 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY11 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY12 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY13 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY14 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY15 ; 2:7/12
    add   A, A          ; 1:4
    ret  nc             ; 1:5/11
    ex   DE, HL         ; 1:4
    ret                 ; 1:10

MULTIPLY1:
    ld    H, D          ; 1:4
    ld    L, E          ; 1:4
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY2:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY3:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY4:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY5:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY6:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY7:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY8:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    ld    A, C          ; 1:4
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY9:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY10:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY11:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY12:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY13:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY14:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY15:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret                 ; 1:10

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
VARIABLE_SECTION:

STRING_SECTION:


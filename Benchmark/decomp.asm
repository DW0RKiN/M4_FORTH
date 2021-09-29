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
            
    pop  AF             ; 1:10      nrot nip
    ex   DE, HL         ; 1:4       nrot nip ( c b a -- a b )
        
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
; HL = HL*DE = H0*E + L*DE
; Pollutes: AF, C, DE
MULTIPLY:
                        ;[36:471-627] # default version can be changed with "define({TYPMUL},{name})", name=fast,small,test,test2,...   
    xor   A             ; 1:4
    ld    C, E          ; 1:4

    srl   H             ; 2:8       H /= 2
    jr   nc, $+3        ; 2:7/12        
MULTIPLY1:              ;           H0*0E
    add   A, C          ; 1:4       A += C(original E)

    sla   C             ; 2:8       C(original E) *= 2
    srl   H             ; 2:8       H /= 2
    jr    c, MULTIPLY1  ; 2:7/12
    jp   nz, MULTIPLY1+1; 3:10      H = ?

    ld    C, L          ; 1:4
    ld    L, H          ; 1:4       L = 0
    ld    H, A          ; 1:4       HL *= E

    srl   C             ; 2:8       C(original L) /= 2
    jr   nc, $+3        ; 2:7/12    
MULTIPLY2:              ;           0L*DE
    add  HL, DE         ; 1:11
    
    sla   E             ; 2:8
    rl    D             ; 2:8       DE *= 2    

    srl   C             ; 2:8       C(original L) /= 2
    jr    c, MULTIPLY2  ; 2:7/12
    jp   nz, MULTIPLY2+1; 3:10      C(original L) = ?

    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY
; Divide 16-bit unsigned values (with 16-bit result)
; In: DE / HL
; Out: HL = DE / HL, DE = DE % HL
UDIVIDE:
                        ;[37:cca 900] # default version can be changed with "define({TYPDIV},{name})", name=old_fast,old,fast,small,synthesis
                        ; /3 --> cca 1551, /5 --> cca 1466, 7/ --> cca 1414, /15 --> cca 1290, /17 --> cca 1262, /31 --> cca 1172, /51 --> cca 1098, /63 --> cca 1058, /85 --> cca 1014, /255 --> cca 834
    ld    A, H          ; 1:4
    or    L             ; 1:4       HL = DE / HL
    ret   z             ; 1:5/11    HL = DE / 0?
    
    ld   BC, 0x0000     ; 3:10
if 0
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    ld    A, H          ; 1:4       
    sub   D             ; 1:4
    jp    c, UDIVIDE_LE ; 3:10
    jp   nz, UDIVIDE_GT ; 3:10
    ld    A, E          ; 1:4
    sub   L             ; 1:4
else
    ld    A, D          ; 1:4
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4
endif
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE

UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0x0000 = result
UDIVIDE_LOOP:
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    ccf                 ; 1:4       inverts carry flag
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--
    
    ex   DE, HL         ; 1:4    
    ld    L, A          ; 1:4
    ld    H, C          ; 1:4
    ret                 ; 1:10
VARIABLE_SECTION:

STRING_SECTION:


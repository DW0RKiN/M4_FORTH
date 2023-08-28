      ifdef __ORG
    org __ORG
  else
    org 24576
  endif








    
      
           
      
          
         
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
; HL = HL*DE = H0*E + L*DE
; Pollutes: AF, C, DE
MULTIPLY:
                        ;[36:471-627] ;# default version can be changed with "define({TYPMUL},{name})", name=fast,small,test,test2,...
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
;#==============================================================================
; Divide 16-bit unsigned values (with 16-bit result)
; In: DE / HL
; Out: HL = DE / HL, DE = DE % HL
UDIVIDE:
                        ;[51:cca 900] ;# default version can be changed with "define({TYPDIV},{name})", name=old_fast,old,fast,small,synthesis
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
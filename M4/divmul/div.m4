dnl ## multiplication
define({___},{})dnl
dnl
dnl
dnl
; Divide 16-bit signed values (with 16-bit result)
; In: DE / HL
; Out: HL = DE / HL, DE = DE % abs(HL)
DIVIDE:
    ld    A, H          ; 1:4
    xor   D             ; 1:4
    push AF             ; 1:11      div output sign
    
    ld    A, D          ; 1:4
    add   A, A          ; 1:4
    push AF             ; 1:11      mod output sign    
    jr   nc, $+8        ; 2:7/12    
    xor   A             ; 1:4
    sub   E             ; 1:4
    ld    E, A          ; 1:4
    sbc   A, D          ; 1:4
    sub   E             ; 1:4
    ld    D, A          ; 1:4

    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, $+8        ; 2:7/12
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4

    call UDIVIDE        ; 3:17
    
    pop  AF             ; 1:10      mod output sign    
    jr   nc, $+8        ; 2:7/12
    xor   A             ; 1:4
    sub   E             ; 1:4
    ld    E, A          ; 1:4
    sbc   A, D          ; 1:4
    sub   E             ; 1:4
    ld    D, A          ; 1:4
    
    pop  AF             ; 1:10      div output sign
    ret  p              ; 1:5/11
    
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10}){}dnl
dnl
dnl
dnl

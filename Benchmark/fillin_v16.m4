include(`../M4/FIRST.M4')dnl
ORG 32768
INIT(60000)
define({FILLIN},{
    push HL             ; 1:11      fillin   save TOS
    ld   HL, 0x4000     ; 3:10      fillin
    ld    A, 0x5B       ; 2:7       fillin 
    ld   BC, 0x00FF     ; 3:10      fillin 
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   1x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   2x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   3x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:6       fillin   4x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   5x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   6x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   7x
    ld  (HL),C          ; 1:7       fillin
    inc  HL             ; 1:6       fillin   8x
    cp    H             ; 1:4       fillin
    jp   nz, $-17       ; 3:10      fillin
    pop  HL             ; 1:10      fillin   load TOS})dnl
FILLIN
STOP   

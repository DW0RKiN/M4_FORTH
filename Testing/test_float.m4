; vvvvv
include(`../M4/FIRST.M4')dnl
; ^^^^^
;# log10(2^n) = y
;# 10^y = 2^n
;# log10(2^n)=n*log10(2)
;# 10^(n*log10(2)) = 2^n
;# m*2^n = m*10^(n*log10(2)) = m*10^(int+mod) = m * 10^int * 10^mod = m * 10^mod * Eint = 1 .. 1.9 10^mod * Eint = 1.0 .. 19.99 Eint

ORG 0x8000
    INIT(60000)
    ld  hl, stack_test
    push hl

    PUSH2(FP1,49)
    SFOR
        SWAP
        PUSH(FP2)
        FDIV
        SWAP
    SNEXT
    FDOT CR
    PUSH2(FP1, FP2)
    FADD FDOT CR
    PUSH2(FP1, FP2)
    FSUB FDOT CR
    
    PUSH2(   0,    0) S2F FDOT PUTCHAR(' ') S2F DUP FDOT F2S DOT CR
    PUSH2(  -3,    3) S2F FDOT PUTCHAR(' ') S2F DUP FDOT F2S DOT CR
    PUSH2( -503, 503) S2F FDOT PUTCHAR(' ') S2F DUP FDOT F2S DOT CR
    PUSH2( -512, 512) S2F FDOT PUTCHAR(' ') S2F DUP FDOT F2S DOT CR

    PUSH( 0x7FFF ) SFOR DUP S2F PUSH(20224) NE IF DUP UDOT LEAVE THEN SNEXT
    CR

    PUSH(FP0) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FP0_1) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FP0_5) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FP0_8) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FP1) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FP1_5) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FM0_1) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FM0_5) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FM0_8) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FM1) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR
    PUSH(FM1_5) DUP FDOT PRINT_Z({": sin -> "}) FSIN FDOT CR

    
    PUSH(5)   S2F FSQRT DUP FDOT PRINT_Z({": exp -> "}) FEXP FDOT CR
    PUSH(5)   S2F FSQRT DUP FDOT PRINT_Z({":  ln -> "}) FLN  FDOT CR
    PUSH2(5,3) S2F DUP FDOT PRINT_Z({" % "}) SWAP S2F FSQRT DUP FDOT PRINT_Z({":  a%b -> "}) FMOD  FDOT CR
    
    PUSH(3) SCALL(test) DROP
    PUSH(5) SCALL(test) DROP
    PUSH(7) SCALL(test) DROP
    PUSH(8) SCALL(test) DROP
    PUSH(15) SCALL(test) DROP
    
    XDO( 65535, 0 ) XI DUP_UDOT PUTCHAR(':') U2F DUP DUP FDOT F2S DOT DUP FNEGATE F2S DOT FSQRT F2S DOT CR PUSH_ADDXLOOP(777)
    
    PUSH( 32736 ) DUP_UDOT PUTCHAR(':') U2F         DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 32737 ) DUP_UDOT PUTCHAR(':') U2F         DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 0x7FFF) DUP_UDOT PUTCHAR(':') U2F         DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 0x8000) DUP_UDOT PUTCHAR(':') U2F         DUP FDOT DUP UDOT F2S DOT CR
    
    PUSH( 32736 ) DUP_UDOT PUTCHAR(':') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 32737 ) DUP_UDOT PUTCHAR(':') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 0x7FFF) DUP_UDOT PUTCHAR(':') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 0x8000) DUP_UDOT PUTCHAR(':') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR

    PUSH( 0x8000) S2F DUP FDOT F2U UDOT CR
    

    
    PRINT_Z({"RAS:"})
    exx
    push HL
    exx
    pop  HL
    DUP_UDOT    
    ret
    
SCOLON(test)
    S2F FSQRT DUP FDOT FFRAC PUTCHAR(':') DUP FDOT F2S DUP DOT CR
SSEMICOLON

    
SCOLON(stack_test)
    PRINT_Z({0xD, "Data stack OK!", 0xD})
    STOP
SSEMICOLON

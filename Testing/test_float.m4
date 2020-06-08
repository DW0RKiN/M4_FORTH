; vvvvv
include(`./FIRST.M4')dnl
; ^^^^^
;# log10(2^n) = y
;# 10^y = 2^n
;# log10(2^n)=n*log10(2)
;# 10^(n*log10(2)) = 2^n
;# m*2^n = m*10^(n*log10(2)) = m*10^(int+mod) = m * 10^int * 10^mod = m * 10^mod * Eint = 1 .. 1.9 10^mod * Eint = 1.0 .. 19.99 Eint

ORG 0x8000
    ld  hl, stack_test
    push hl
    INIT(60000)
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
    
    PUSH( 32735 ) DUP UDOT PUTCHAR(' ') U2F         DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 32736 ) DUP UDOT PUTCHAR(' ') U2F         DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 32737 ) DUP UDOT PUTCHAR(' ') U2F         DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 0x7FFF) DUP UDOT PUTCHAR(' ') U2F         DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 0x8000) DUP UDOT PUTCHAR(' ') U2F         DUP FDOT DUP UDOT F2S DOT CR
    
    PUSH( 32735 ) DUP UDOT PUTCHAR(' ') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 32736 ) DUP UDOT PUTCHAR(' ') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 32737 ) DUP UDOT PUTCHAR(' ') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 0x7FFF) DUP UDOT PUTCHAR(' ') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR
    PUSH( 0x8000) DUP UDOT PUTCHAR(' ') U2F FNEGATE DUP FDOT DUP UDOT F2S DOT CR

    PUSH( 0x8000) S2F DUP FDOT F2U UDOT CR
    
    PRINT({"RAS:"})
    exx
    push HL
    exx
    pop  HL
    DUP_UDOT    
    STOP
SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})    
SSEMICOLON
include({./LAST.M4})

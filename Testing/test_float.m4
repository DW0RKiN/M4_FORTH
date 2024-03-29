include(`../M4/FIRST.M4')dnl
;# log10(2^n) = y
;# 10^y = 2^n
;# log10(2^n)=n*log10(2)
;# 10^(n*log10(2)) = 2^n
;# m*2^n = m*10^(n*log10(2)) = m*10^(int+mod) = m * 10^int * 10^mod = m * 10^mod * Eint = 1 .. 1.9 10^mod * Eint = 1.0 .. 19.99 Eint

ORG 0x8000
    INIT(60000)

    PUSH2(FP1,49)
    SFOR
        PRINT_Z({"1.0/2**"}) PUSH(50) OVER SUB UDOT PUTCHAR('=')
        SWAP
        PUSH(FP2)
        FDIV
        DUP FDOT CR
        SWAP
    SNEXT
    DROP
    CR
    
    PRINT_Z({"1.0+2.0="}) PUSH2(FP1, FP2) FADD FDOT CR
    PRINT_Z({"1.0-2.0="}) PUSH2(FP1, FP2) FSUB FDOT CR
    CR
    
    PUSH(0) CALL(test_s2f_f2s)
    PUSH(3) CALL(test_s2f_f2s)
    PUSH(-3) CALL(test_s2f_f2s)
    PUSH(-503) CALL(test_s2f_f2s)
    PUSH(503) CALL(test_s2f_f2s)
    PUSH(-512) CALL(test_s2f_f2s)
    PUSH(512) CALL(test_s2f_f2s)
    CR
    
    PUSH(512) SFOR
        DUP S2F F2S OVER NE_IF DUP CALL(test_s2f_f2s) THEN
    SNEXT
    CR

    PUSH(FP1_5) DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FP1)   DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FP0_8) DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FP0_5) DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FP0_1) DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FP0)   DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FM0_1) DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FM0_5) DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FM0_8) DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FM1)   DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    PUSH(FM1_5) DUP PRINT_Z({"sin("}) FDOT FSIN PRINT_Z({")="}) FDOT CR
    CR
    

    PUSH(0)   CALL(test_sqrt)
    PUSH(1)   CALL(test_sqrt)
    PUSH(4)   CALL(test_sqrt)
    PUSH(50)  CALL(test_sqrt)
    PUSH(123) CALL(test_sqrt)

    
    PUSH(5) S2F PRINT_Z({"sqrt("}) DUP FDOT PRINT_Z({")="}) FSQRT FDOT CR
    PUSH(5) S2F FSQRT DUP
    PRINT_Z({" exp("}) DUP FDOT PRINT_Z({")="}) FEXP FDOT CR
    PRINT_Z({"  ln("}) DUP FDOT PRINT_Z({")="}) FLN  FDOT CR
    PUSH(3) S2F DUP FDOT PRINT_Z({" % "}) PUSH(5) S2F FSQRT DUP FDOT PUTCHAR('=') FMOD FDOT CR
    
    PUSH(3) SCALL(test) DROP
    PUSH(5) SCALL(test) DROP
    PUSH(7) SCALL(test) DROP
    PUSH(8) SCALL(test) DROP
    PUSH(15) SCALL(test) DROP
    
    PUSH( 65535, 0 ) DO I DUP_UDOT PUTCHAR(':') U2F DUP DUP FDOT F2S SPACE_DOT DUP FNEGATE F2S SPACE_DOT FSQRT F2S SPACE_DOT CR PUSH(777) ADDLOOP
    
    PUSH( 32736 ) DUP_UDOT PUTCHAR(':') U2F         DUP FDOT DUP_SPACE_UDOT F2S DOT CR
    PUSH( 32737 ) DUP_UDOT PUTCHAR(':') U2F         DUP FDOT DUP_SPACE_UDOT F2S DOT CR
    PUSH( 0x7FFF) DUP_UDOT PUTCHAR(':') U2F         DUP FDOT DUP_SPACE_UDOT F2S DOT CR
    PUSH( 0x8000) DUP_UDOT PUTCHAR(':') U2F         DUP FDOT DUP_SPACE_UDOT F2S DOT CR
    
    PUSH( 32736 ) DUP_UDOT PUTCHAR(':') U2F FNEGATE DUP FDOT DUP_SPACE_UDOT F2S DOT CR
    PUSH( 32737 ) DUP_UDOT PUTCHAR(':') U2F FNEGATE DUP FDOT DUP_SPACE_UDOT F2S DOT CR
    PUSH( 0x7FFF) DUP_UDOT PUTCHAR(':') U2F FNEGATE DUP FDOT DUP_SPACE_UDOT F2S DOT CR
    PUSH( 0x8000) DUP_UDOT PUTCHAR(':') U2F FNEGATE DUP FDOT DUP_SPACE_UDOT F2S DOT CR

    PUSH( 0x8000) S2F DUP FDOT F2U SPACE_UDOT CR

    PRINT_Z({"Data stack:"}) DEPTH UDOT
    PRINT_Z({0x0D, "RAS:"}) RAS UDOT CR
    STOP
    
COLON(test_s2f_f2s)
    DUP_DOT PUTCHAR('=') DUP S2F DUP FDOT PUTCHAR('=') F2S DUP_DOT NE_IF PRINT_Z({" false", 0x0D}) ELSE PRINT_Z({" ok", 0x0D}) THEN
SEMICOLON

COLON(test_sqrt)
    DUP DUP MUL PRINT_Z({"sqrt("}) DUP_UDOT S2F FSQRT PRINT_Z({")="}) DUP FDOT F2S NE_IF PRINT_Z({" false", 0x0D}) ELSE PRINT_Z({" ok", 0x0D}) THEN
SEMICOLON
    
SCOLON(test)
    S2F FSQRT DUP FDOT FFRAC PUTCHAR(':') DUP FDOT F2S DUP SPACE_DOT CR
SSEMICOLON

    

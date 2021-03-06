; vvvv
include(`../M4/FIRST.M4')dnl
; ^^^^
    ORG 32768
    
    INIT(60000)
    ld  hl, stack_test
    push hl

    PUSH2(4, 0)  DO  I PUSH(0)  QUESTIONDO  J DOT  I DOT  LOOP PUTCHAR({','})  LOOP CR
    PUSH2(4, 0) SDO SI PUSH(0) QUESTIONSDO SJ DOT SI DOT SLOOP PUTCHAR({','}) SLOOP CR
      XDO(4, 0)      I PUSH(0) QUESTIONSDO  J DOT SI DOT SLOOP PUTCHAR({','}) XLOOP CR
    PUSH2(3, 0) SDO SI                 FOR SI DOT  I DOT  NEXT PUTCHAR({','}) SLOOP CR
    PUSH2(3, 0)  DO  I                SFOR  J DOT SI DOT SNEXT PUTCHAR({','})  LOOP CR

    PUSH(5)          SFOR    SI DOT       PUTCHAR({','})          SNEXT CR
    PUSH(5)           FOR     I DOT       PUTCHAR({','})           NEXT CR
    PUSH(5) BEGIN DUP_DOT DUP_WHILE _1SUB PUTCHAR({','}) REPEAT DROP CR ;--> " 5, 4, 3, 2, 1, 0"
    PUSH(0) BEGIN DUP_DOT DUP_PUSH(4) LT WHILE _1ADD PUTCHAR({','}) REPEAT DROP CR ;--> " 0, 1, 2, 3, 4"
    PUSH(0) BEGIN DUP_DOT DUP_PUSH(4) LT WHILE _2ADD PUTCHAR({','}) REPEAT DROP CR ;--> " 0, 2, 4"

    PRINT("Exit:")
    PUSH2(0,0)      DO              PUTCHAR('a') LEAVE          LOOP 
    PUSH2(0,1)      DO              PUTCHAR('b') LEAVE          LOOP 
                   XDO(0,0)         PUTCHAR('c') LEAVE         XLOOP 
                   XDO(254,254)     PUTCHAR('d') LEAVE         XLOOP 
                   XDO(255,255)     PUTCHAR('e') LEAVE         XLOOP 
                   XDO(256,256)     PUTCHAR('f') LEAVE         XLOOP
    PUSH2(0,0)     SDO              PUTCHAR('g') LEAVE         SLOOP 
    PUSH2(254,254) SDO              PUTCHAR('h') LEAVE         SLOOP 
    PUSH2(255,255) SDO              PUTCHAR('i') LEAVE         SLOOP 
    PUSH2(256,256) SDO              PUTCHAR('j') LEAVE         SLOOP
                   XDO(60000,60000) PUTCHAR('k') LEAVE PUSH_ADDXLOOP(5000)
                   XDO(60000,60000) PUTCHAR('l') LEAVE PUSH_ADDXLOOP(3100)

    PRINT({0xD, "Leave >= 7", 0xD})
    PUSH2(12,3)  DO         I DUP_DOT PUSH(7) GE IF LEAVE THEN          LOOP    CR
    PUSH2(12,3) SDO        SI DUP_DOT PUSH(7) GE IF LEAVE THEN         SLOOP    CR
                XDO(12,3)   I DUP_DOT PUSH(7) GE IF LEAVE THEN         XLOOP    CR
                XDO(550,3)  I DUP_DOT PUSH(7) GE IF LEAVE THEN         XLOOP    CR
                XDO(12,3)   I DUP_DOT PUSH(7) GE IF LEAVE THEN PUSH_ADDXLOOP(2) CR
                XDO(550,3)  I DUP_DOT PUSH(7) GE IF LEAVE THEN PUSH_ADDXLOOP(2) CR
    PUSH(12)    FOR         I DUP_DOT PUSH(7) LE IF LEAVE THEN          NEXT    CR
    PUSH(12)   SFOR        SI DUP_DOT PUSH(7) LE IF LEAVE THEN         SNEXT    CR
    
    PRINT("Once:")
    PUSH2(1,0) DO PUTCHAR('a') LOOP 
    PUSH2(255,254) DO PUTCHAR('b') LOOP 
    XDO(1,0)      PUTCHAR('c') XLOOP 
    XDO(255,254)  PUTCHAR('d') XLOOP 
    XDO(256,255)  PUTCHAR('e') XLOOP 
    XDO(257,256)  PUTCHAR('f') XLOOP
    PUSH2(1,0)     SDO PUTCHAR('g') SLOOP 
    PUSH2(255,254) SDO PUTCHAR('h') SLOOP 
    PUSH2(256,255) SDO PUTCHAR('i') SLOOP 
    PUSH2(257,256) SDO PUTCHAR('j') SLOOP
    XDO(60000,30000) PUTCHAR('k') PUSH_ADDXLOOP(40000)
    XDO(60000,30000) PUTCHAR('l') PUSH_ADDXLOOP(31000)

    PRINT({0xD, "RAS:"})
    exx
    push HL
    exx
    pop HL
    DUP_UDOT
    ret
    
SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})    
    STOP
SSEMICOLON

include({../M4/LAST.M4})dnl

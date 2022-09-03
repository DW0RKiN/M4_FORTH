include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)

    PUSH2(4,0) DO        I PUSH(0) QUESTIONDO    J DOT I PUSH_EMIT('/') DOT PUTCHAR({','}) LOOP LOOP CR
    PUSH2(4,0) DO(S)     I PUSH(0) QUESTIONDO(S) J DOT I PUSH_EMIT('/') DOT PUTCHAR({','}) LOOP LOOP CR
               DO(,4,0)  I PUSH(0) QUESTIONDO(S) J DOT I PUSH_EMIT('/') DOT PUTCHAR({','}) LOOP LOOP CR
    PUSH2(3,0) DO(S)     I                FOR    J DOT I PUSH_EMIT('/') DOT PUTCHAR({','}) NEXT LOOP CR
    PUSH2(3,0) DO        I                FOR    J DOT I PUSH_EMIT('/') DOT PUTCHAR({','}) NEXT LOOP CR

    PUSH(5)           FOR(S)  I DOT       PUTCHAR({','})           NEXT CR
    PUSH(5)           FOR     I DOT       PUTCHAR({','})           NEXT CR
    PUSH(5) BEGIN DUP_DOT DUP_WHILE _1SUB PUTCHAR({','}) REPEAT DROP CR ;--> " 5, 4, 3, 2, 1, 0"
    PUSH(0) BEGIN DUP_DOT DUP_PUSH(4) LT WHILE _1ADD PUTCHAR({','}) REPEAT DROP CR ;--> " 0, 1, 2, 3, 4"
    PUSH(0) BEGIN DUP_DOT DUP_PUSH(4) LT WHILE _2ADD PUTCHAR({','}) REPEAT DROP CR ;--> " 0, 2, 4"

    PRINT("Exit:")
    PUSH2(0,0)     DO               PUTCHAR('a') LEAVE               LOOP 
    PUSH2(0,1)     DO               PUTCHAR('b') LEAVE               LOOP 
                   DO(,0,0)         PUTCHAR('c') LEAVE               LOOP 
                   DO(,254,254)     PUTCHAR('d') LEAVE               LOOP 
                   DO(,255,255)     PUTCHAR('e') LEAVE               LOOP 
                   DO(,256,256)     PUTCHAR('f') LEAVE               LOOP
    PUSH2(0,0)     DO(S)            PUTCHAR('g') LEAVE               LOOP 
    PUSH2(254,254) DO(S)            PUTCHAR('h') LEAVE               LOOP 
    PUSH2(255,255) DO(S)            PUTCHAR('i') LEAVE               LOOP 
    PUSH2(256,256) DO(S)            PUTCHAR('j') LEAVE               LOOP
                   DO(,60000,60000) PUTCHAR('k') LEAVE PUSH(5000) ADDLOOP
                   DO(,60000,60000) PUTCHAR('l') LEAVE PUSH(3100) ADDLOOP

    PRINT({0xD, "Leave >= 7", 0xD})
    PUSH2(12,3) DO         I DUP_SPACE_DOT PUSH(7) GE IF LEAVE THEN            LOOP CR
    PUSH2(12,3) DO(S)      I DUP_SPACE_DOT PUSH(7) GE IF LEAVE THEN            LOOP CR
                DO(,12,3)  I DUP_SPACE_DOT PUSH(7) GE IF LEAVE THEN            LOOP CR
                DO(,550,3) I DUP_SPACE_DOT PUSH(7) GE IF LEAVE THEN            LOOP CR
                DO(,12,3)  I DUP_SPACE_DOT PUSH(7) GE IF LEAVE THEN PUSH(2) ADDLOOP CR
                DO(,550,3) I DUP_SPACE_DOT PUSH(7) GE IF LEAVE THEN PUSH(2) ADDLOOP CR
    PUSH(12)   FOR         I DUP_SPACE_DOT PUSH(7) LE IF LEAVE THEN            NEXT CR
    PUSH(12)   FOR(S)      I DUP_SPACE_DOT PUSH(7) LE IF LEAVE THEN            NEXT CR
    
    PRINT("Once:")
    PUSH2(1,0)     DO               PUTCHAR('a') LOOP 
    PUSH2(255,254) DO               PUTCHAR('b') LOOP 
                   DO(,1,0)         PUTCHAR('c') LOOP 
                   DO(,255,254)     PUTCHAR('d') LOOP 
                   DO(,256,255)     PUTCHAR('e') LOOP 
                   DO(,257,256)     PUTCHAR('f') LOOP
    PUSH2(1,0)     DO(S)            PUTCHAR('g') LOOP 
    PUSH2(255,254) DO(S)            PUTCHAR('h') LOOP 
    PUSH2(256,255) DO(S)            PUTCHAR('i') LOOP 
    PUSH2(257,256) DO(S)            PUTCHAR('j') LOOP
                   DO(,60000,30000) PUTCHAR('k') PUSH(40000) ADDLOOP
                   DO(,60000,30000) PUTCHAR('l') PUSH(31000) ADDLOOP

    PRINT({0xD, "Data stack:"}) DEPTH DOT    
    PRINT({0xD, "RAS:"}) RAS UDOT CR
    STOP

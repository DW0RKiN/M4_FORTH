include(`../M4/FIRST.M4')dnl
dnl
    ORG 0x8000
    INIT(60000)
    ld  hl, stack_test
    push hl

    BEGIN PRINT({"Press any key: "}) KEY DUP PUSH(0xD) XOR WHILE DUP EMIT PUTCHAR('=') UDOT CR REPEAT DROP
    PRINT({0xD,"10 char string: "})
    PUSH2(BUFFER,10) ACCEPT CR
    PUSH(BUFFER) ADD PUSH(BUFFER) DO I FETCH PUSH(0xFF) AND EMIT LOOP CR
    
    PRINT({"RAS:"})
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

BUFFER:
DS 10

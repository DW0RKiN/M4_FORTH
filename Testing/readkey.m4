include(`FIRST.M4')dnl
dnl
    ORG 0x8000
    ld  hl, stack_test
    push hl
    INIT(60000)
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
    STOP
    
SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})    
SSEMICOLON

include({LAST.M4})dnl

BUFFER:
DS 10

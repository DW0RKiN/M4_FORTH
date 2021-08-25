; vvvvv
include(`../M4/FIRST.M4')dnl
; ^^^^^
ORG 0x8000
    INIT(60000)
    ld  hl, stack_test
    push hl

    PUSH2( 5,-5) CALL(dtest)
    PUSH2( 5, 5) CALL(dtest)
    PUSH2(-5,-5) CALL(dtest)
    PUSH2(-5, 5) CALL(dtest)

    PUSH( 3) CALL(ptestp3)
    PUSH(-3) CALL(ptestp3)
    PUSH( 3) CALL(ptestm3)
    PUSH(-3) CALL(ptestm3)

    PRINT({"RAS:"})
    exx
    push HL
    exx
    pop HL
    DUP_UDOT
    ret
    
COLON(dtest)
     BEGIN _2DUP EQ WHILE PRINT( {"=" }) BREAK AGAIN
     BEGIN _2DUP_EQ_WHILE PRINT( {"=" }) BREAK AGAIN
     BEGIN _2DUP EQ_WHILE PRINT( {"=,"}) BREAK AGAIN
     BEGIN _2DUP NE WHILE PRINT({"<>" }) BREAK AGAIN
     BEGIN _2DUP_NE_WHILE PRINT({"<>" }) BREAK AGAIN
     BEGIN _2DUP NE_WHILE PRINT({"<>,"}) BREAK AGAIN
     BEGIN _2DUP LT WHILE PRINT( {"<" }) BREAK AGAIN
     BEGIN _2DUP_LT_WHILE PRINT( {"<" }) BREAK AGAIN
     BEGIN _2DUP LT_WHILE PRINT( {"<,"}) BREAK AGAIN
     BEGIN _2DUP LE WHILE PRINT({"<=" }) BREAK AGAIN
     BEGIN _2DUP_LE_WHILE PRINT({"<=" }) BREAK AGAIN
     BEGIN _2DUP LE_WHILE PRINT({"<=,"}) BREAK AGAIN
     BEGIN _2DUP GT WHILE PRINT( {">" }) BREAK AGAIN
     BEGIN _2DUP_GT_WHILE PRINT( {">" }) BREAK AGAIN
     BEGIN _2DUP GT_WHILE PRINT( {">,"}) BREAK AGAIN
     BEGIN _2DUP GE WHILE PRINT({">=" }) BREAK AGAIN
     BEGIN _2DUP_GE_WHILE PRINT({">=" }) BREAK AGAIN
     BEGIN _2DUP GE_WHILE PRINT({">=,"}) BREAK AGAIN
    OVER DOT DUP DOT CR  
    BEGIN _2DUP UEQ WHILE PRINT( {"=" }) BREAK AGAIN
    BEGIN _2DUP_UEQ_WHILE PRINT( {"=" }) BREAK AGAIN
    BEGIN _2DUP UEQ_WHILE PRINT( {"=,"}) BREAK AGAIN
    BEGIN _2DUP UNE WHILE PRINT({"<>" }) BREAK AGAIN
    BEGIN _2DUP_UNE_WHILE PRINT({"<>" }) BREAK AGAIN
    BEGIN _2DUP UNE_WHILE PRINT({"<>,"}) BREAK AGAIN
    BEGIN _2DUP ULT WHILE PRINT( {"<" }) BREAK AGAIN
    BEGIN _2DUP_ULT_WHILE PRINT( {"<" }) BREAK AGAIN
    BEGIN _2DUP ULT_WHILE PRINT( {"<,"}) BREAK AGAIN
    BEGIN _2DUP ULE WHILE PRINT({"<=" }) BREAK AGAIN
    BEGIN _2DUP_ULE_WHILE PRINT({"<=" }) BREAK AGAIN
    BEGIN _2DUP ULE_WHILE PRINT({"<=,"}) BREAK AGAIN
    BEGIN _2DUP UGT WHILE PRINT( {">" }) BREAK AGAIN
    BEGIN _2DUP_UGT_WHILE PRINT( {">" }) BREAK AGAIN
    BEGIN _2DUP UGT_WHILE PRINT( {">,"}) BREAK AGAIN
    BEGIN _2DUP UGE WHILE PRINT({">=" }) BREAK AGAIN
    BEGIN _2DUP_UGE_WHILE PRINT({">=" }) BREAK AGAIN
    BEGIN _2DUP UGE_WHILE PRINT({">=,"}) BREAK AGAIN
    SWAP UDOT UDOT CR
SEMICOLON

COLON(ptestp3)
    BEGIN DUP_PUSH_EQ_WHILE(3) PRINT( {"=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_NE_WHILE(3) PRINT({"<>,"}) BREAK AGAIN
    BEGIN DUP_PUSH_LT_WHILE(3) PRINT( {"<,"}) BREAK AGAIN
    BEGIN DUP_PUSH_LE_WHILE(3) PRINT({"<=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_GT_WHILE(3) PRINT( {">,"}) BREAK AGAIN
    BEGIN DUP_PUSH_GE_WHILE(3) PRINT({">=,"}) BREAK AGAIN
    DUP DOT PUSH(3) DOT CR 
    BEGIN DUP_PUSH_UEQ_WHILE(3) PRINT( {"=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UNE_WHILE(3) PRINT({"<>,"}) BREAK AGAIN
    BEGIN DUP_PUSH_ULT_WHILE(3) PRINT( {"<,"}) BREAK AGAIN
    BEGIN DUP_PUSH_ULE_WHILE(3) PRINT({"<=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UGT_WHILE(3) PRINT( {">,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UGE_WHILE(3) PRINT({">=,"}) BREAK AGAIN
    UDOT PUSH(3) UDOT CR
SEMICOLON


COLON(ptestm3)
    BEGIN DUP_PUSH_EQ_WHILE(-3) PRINT( {"=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_NE_WHILE(-3) PRINT({"<>,"}) BREAK AGAIN
    BEGIN DUP_PUSH_LT_WHILE(-3) PRINT( {"<,"}) BREAK AGAIN
    BEGIN DUP_PUSH_LE_WHILE(-3) PRINT({"<=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_GT_WHILE(-3) PRINT( {">,"}) BREAK AGAIN
    BEGIN DUP_PUSH_GE_WHILE(-3) PRINT({">=,"}) BREAK AGAIN
    DUP DOT PUSH(-3) DOT CR 
    BEGIN DUP_PUSH_UEQ_WHILE(-3) PRINT( {"=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UNE_WHILE(-3) PRINT({"<>,"}) BREAK AGAIN
    BEGIN DUP_PUSH_ULT_WHILE(-3) PRINT( {"<,"}) BREAK AGAIN
    BEGIN DUP_PUSH_ULE_WHILE(-3) PRINT({"<=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UGT_WHILE(-3) PRINT( {">,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UGE_WHILE(-3) PRINT({">=,"}) BREAK AGAIN
    UDOT PUSH(-3) UDOT CR
SEMICOLON


SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})
    STOP
SSEMICOLON

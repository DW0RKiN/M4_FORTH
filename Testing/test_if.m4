; vvvvv
include(`FIRST.M4')dnl
; ^^^^^
ORG 0x8000
    ld  hl, stack_test
    push hl
    INIT(60000)
    PUSH2( 5,-5) CALL(test)
    PUSH2( 5, 5) CALL(test)
    PUSH2(-5,-5) CALL(test)
    PUSH2(-5, 5) CALL(test)
    PRINT({"RAS:"})
    exx
    push HL
    exx
    pop HL
    DUP_UDOT
    STOP

COLON(test)
    OVER DOT DUP DOT CR 
     _2DUP EQ IF PRINT( {"=,"}) THEN
     _2DUP_EQ_IF PRINT( {"=,"}) THEN
     _2DUP NE IF PRINT({"<>,"}) THEN
     _2DUP_NE_IF PRINT({"<>,"}) THEN
     _2DUP LT IF PRINT( {"<,"}) THEN
     _2DUP_LT_IF PRINT( {"<,"}) THEN
     _2DUP LE IF PRINT({"<=,"}) THEN
     _2DUP_LE_IF PRINT({"<=,"}) THEN
     _2DUP GT IF PRINT( {">,"}) THEN
     _2DUP_GT_IF PRINT( {">,"}) THEN
     _2DUP GE IF PRINT({">=,"}) THEN
     _2DUP_GE_IF PRINT({">=,"}) THEN    
    CR
    OVER UDOT DUP UDOT CR 
    _2DUP UEQ IF PRINT( {"=,"}) THEN
    _2DUP_UEQ_IF PRINT( {"=,"}) THEN
    _2DUP UNE IF PRINT({"<>,"}) THEN
    _2DUP_UNE_IF PRINT({"<>,"}) THEN
    _2DUP ULT IF PRINT( {"<,"}) THEN
    _2DUP_ULT_IF PRINT( {"<,"}) THEN
    _2DUP ULE IF PRINT({"<=,"}) THEN
    _2DUP_ULE_IF PRINT({"<=,"}) THEN
    _2DUP UGT IF PRINT( {">,"}) THEN
    _2DUP_UGT_IF PRINT( {">,"}) THEN
    _2DUP UGE IF PRINT({">=,"}) THEN
    _2DUP_UGE_IF PRINT({">=,"}) THEN    
    CR
    _2DROP
SEMICOLON
    
SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})    
SSEMICOLON

include({LAST.M4})

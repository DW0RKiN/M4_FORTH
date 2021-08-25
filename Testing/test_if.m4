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
     _2DUP EQ IF PRINT( {"=" }) THEN
     _2DUP_EQ_IF PRINT( {"=" }) THEN
     _2DUP EQ_IF PRINT( {"=,"}) THEN
     _2DUP NE IF PRINT({"<>" }) THEN
     _2DUP_NE_IF PRINT({"<>" }) THEN
     _2DUP NE_IF PRINT({"<>,"}) THEN
     _2DUP LT IF PRINT( {"<" }) THEN
     _2DUP_LT_IF PRINT( {"<" }) THEN
     _2DUP LT_IF PRINT( {"<,"}) THEN
     _2DUP LE IF PRINT({"<=" }) THEN
     _2DUP_LE_IF PRINT({"<=" }) THEN
     _2DUP LE_IF PRINT({"<=,"}) THEN
     _2DUP GT IF PRINT( {">" }) THEN
     _2DUP_GT_IF PRINT( {">" }) THEN
     _2DUP GT_IF PRINT( {">,"}) THEN
     _2DUP GE IF PRINT({">=" }) THEN
     _2DUP_GE_IF PRINT({">=" }) THEN
     _2DUP GE_IF PRINT({">=,"}) THEN
    OVER DOT DUP DOT CR  
    _2DUP UEQ IF PRINT( {"=" }) THEN
    _2DUP_UEQ_IF PRINT( {"=" }) THEN
    _2DUP UEQ_IF PRINT( {"=,"}) THEN
    _2DUP UNE IF PRINT({"<>" }) THEN
    _2DUP_UNE_IF PRINT({"<>" }) THEN
    _2DUP UNE_IF PRINT({"<>,"}) THEN
    _2DUP ULT IF PRINT( {"<" }) THEN
    _2DUP_ULT_IF PRINT( {"<" }) THEN
    _2DUP ULT_IF PRINT( {"<,"}) THEN
    _2DUP ULE IF PRINT({"<=" }) THEN
    _2DUP_ULE_IF PRINT({"<=" }) THEN
    _2DUP ULE_IF PRINT({"<=,"}) THEN
    _2DUP UGT IF PRINT( {">" }) THEN
    _2DUP_UGT_IF PRINT( {">" }) THEN
    _2DUP UGT_IF PRINT( {">,"}) THEN
    _2DUP UGE IF PRINT({">=" }) THEN
    _2DUP_UGE_IF PRINT({">=" }) THEN
    _2DUP UGE_IF PRINT({">=,"}) THEN
    SWAP UDOT UDOT CR
SEMICOLON

COLON(ptestp3)
    DUP_PUSH_EQ_IF(3) PRINT( {"=,"}) THEN
    DUP_PUSH_NE_IF(3) PRINT({"<>,"}) THEN
    DUP_PUSH_LT_IF(3) PRINT( {"<,"}) THEN
    DUP_PUSH_LE_IF(3) PRINT({"<=,"}) THEN
    DUP_PUSH_GT_IF(3) PRINT( {">,"}) THEN
    DUP_PUSH_GE_IF(3) PRINT({">=,"}) THEN
    DUP DOT PUSH(3) DOT CR 
    DUP_PUSH_UEQ_IF(3) PRINT( {"=,"}) THEN
    DUP_PUSH_UNE_IF(3) PRINT({"<>,"}) THEN
    DUP_PUSH_ULT_IF(3) PRINT( {"<,"}) THEN
    DUP_PUSH_ULE_IF(3) PRINT({"<=,"}) THEN
    DUP_PUSH_UGT_IF(3) PRINT( {">,"}) THEN
    DUP_PUSH_UGE_IF(3) PRINT({">=,"}) THEN
    UDOT PUSH(3) UDOT CR
SEMICOLON


COLON(ptestm3)
    DUP_PUSH_EQ_IF(-3) PRINT( {"=,"}) THEN
    DUP_PUSH_NE_IF(-3) PRINT({"<>,"}) THEN
    DUP_PUSH_LT_IF(-3) PRINT( {"<,"}) THEN
    DUP_PUSH_LE_IF(-3) PRINT({"<=,"}) THEN
    DUP_PUSH_GT_IF(-3) PRINT( {">,"}) THEN
    DUP_PUSH_GE_IF(-3) PRINT({">=,"}) THEN
    DUP DOT PUSH(-3) DOT CR 
    DUP_PUSH_UEQ_IF(-3) PRINT( {"=,"}) THEN
    DUP_PUSH_UNE_IF(-3) PRINT({"<>,"}) THEN
    DUP_PUSH_ULT_IF(-3) PRINT( {"<,"}) THEN
    DUP_PUSH_ULE_IF(-3) PRINT({"<=,"}) THEN
    DUP_PUSH_UGT_IF(-3) PRINT( {">,"}) THEN
    DUP_PUSH_UGE_IF(-3) PRINT({">=,"}) THEN
    UDOT PUSH(-3) UDOT CR
SEMICOLON


SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})
    STOP
SSEMICOLON

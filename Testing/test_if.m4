; vvvvv
include(`../M4/FIRST.M4')dnl
; ^^^^^
ORG 0x8000
    INIT(60000)

    PRINT_I({"( x2 x1 -- ) and ( u2 u1 -- ):",0x0D})
    PUSH2( 5,-5) CALL(x_x_test)
    PUSH2( 5, 5) CALL(x_x_test)
    PUSH2(-5,-5) CALL(x_x_test)
    PUSH2(-5, 5) CALL(x_x_test)
    PRINT_I({"( d2 d1 -- ) and ( ud2 ud1 -- ):",0x0D})
    PUSHDOT( 5) PUSHDOT(-5) CALL(d_d_test)
    PUSHDOT( 5) PUSHDOT( 5) CALL(d_d_test)
    PUSHDOT(-5) PUSHDOT(-5) CALL(d_d_test)
    PUSHDOT(-5) PUSHDOT( 5) CALL(d_d_test)
    
    PUSH( 3) CALL(x_p3_test)
    PUSH(-3) CALL(x_p3_test)
    PUSH( 3) CALL(x_m3_test)
    PUSH(-3) CALL(x_m3_test)

    PRINT_Z({0xD, "Data stack:"}) DEPTH DOT
    PRINT_Z({0x0D, "RAS:"}) __RAS UDOT CR
    STOP
    
COLON(x_x_test)
    ; signed
     _2DUP EQ IF PRINT_Z( {"=" }) THEN
     _2DUP_EQ_IF PRINT_Z( {"=" }) THEN
     _2DUP EQ_IF PRINT_Z( {"=,"}) THEN
     _2DUP NE IF PRINT_Z({"<>" }) THEN
     _2DUP_NE_IF PRINT_Z({"<>" }) THEN
     _2DUP NE_IF PRINT_Z({"<>,"}) THEN
     _2DUP LT IF PRINT_Z( {"<" }) THEN
     _2DUP_LT_IF PRINT_Z( {"<" }) THEN
     _2DUP LT_IF PRINT_Z( {"<,"}) THEN
     _2DUP LE IF PRINT_Z({"<=" }) THEN
     _2DUP_LE_IF PRINT_Z({"<=" }) THEN
     _2DUP LE_IF PRINT_Z({"<=,"}) THEN
     _2DUP GT IF PRINT_Z( {">" }) THEN
     _2DUP_GT_IF PRINT_Z( {">" }) THEN
     _2DUP GT_IF PRINT_Z( {">,"}) THEN
     _2DUP GE IF PRINT_Z({">=" }) THEN
     _2DUP_GE_IF PRINT_Z({">=" }) THEN
     _2DUP GE_IF PRINT_Z({">=,"}) THEN
    OVER DOT DUP SPACE_DOT CR  
    ; unsigned
    _2DUP UEQ IF PRINT_Z( {"=" }) THEN
    _2DUP_UEQ_IF PRINT_Z( {"=" }) THEN
    _2DUP UEQ_IF PRINT_Z( {"=,"}) THEN
    _2DUP UNE IF PRINT_Z({"<>" }) THEN
    _2DUP_UNE_IF PRINT_Z({"<>" }) THEN
    _2DUP UNE_IF PRINT_Z({"<>,"}) THEN
    _2DUP ULT IF PRINT_Z( {"<" }) THEN
    _2DUP_ULT_IF PRINT_Z( {"<" }) THEN
    _2DUP ULT_IF PRINT_Z( {"<,"}) THEN
    _2DUP ULE IF PRINT_Z({"<=" }) THEN
    _2DUP_ULE_IF PRINT_Z({"<=" }) THEN
    _2DUP ULE_IF PRINT_Z({"<=,"}) THEN
    _2DUP UGT IF PRINT_Z( {">" }) THEN
    _2DUP_UGT_IF PRINT_Z( {">" }) THEN
    _2DUP UGT_IF PRINT_Z( {">,"}) THEN
    _2DUP UGE IF PRINT_Z({">=" }) THEN
    _2DUP_UGE_IF PRINT_Z({">=" }) THEN
    _2DUP UGE_IF PRINT_Z({">=,"}) THEN
    SWAP UDOT SPACE_UDOT CR
SEMICOLON

COLON(d_d_test)
    ; signed
     _4DUP DEQ IF PRINT_Z( {"=" }) THEN
     _4DUP_DEQ_IF PRINT_Z( {"=" }) THEN
     _4DUP DEQ_IF PRINT_Z( {"=,"}) THEN
     _4DUP DNE IF PRINT_Z({"<>" }) THEN
     _4DUP_DNE_IF PRINT_Z({"<>" }) THEN
     _4DUP DNE_IF PRINT_Z({"<>,"}) THEN
     _4DUP DLT IF PRINT_Z( {"<" }) THEN
     _4DUP_DLT_IF PRINT_Z( {"<" }) THEN
     _4DUP DLT_IF PRINT_Z( {"<,"}) THEN
     _4DUP DLE IF PRINT_Z({"<=" }) THEN
     _4DUP_DLE_IF PRINT_Z({"<=" }) THEN
     _4DUP DLE_IF PRINT_Z({"<=,"}) THEN
     _4DUP DGT IF PRINT_Z( {">" }) THEN
     _4DUP_DGT_IF PRINT_Z( {">" }) THEN
     _4DUP DGT_IF PRINT_Z( {">,"}) THEN
     _4DUP DGE IF PRINT_Z({">=" }) THEN
     _4DUP_DGE_IF PRINT_Z({">=" }) THEN
     _4DUP DGE_IF PRINT_Z({">=,"}) THEN
    _2OVER DDOT _2DUP SPACE_DDOT CR
    ; unsigned
    _4DUP DUEQ IF PRINT_Z( {"=" }) THEN
    _4DUP_DUEQ_IF PRINT_Z( {"=" }) THEN
    _4DUP DUEQ_IF PRINT_Z( {"=,"}) THEN
    _4DUP DUNE IF PRINT_Z({"<>" }) THEN
    _4DUP_DUNE_IF PRINT_Z({"<>" }) THEN
    _4DUP DUNE_IF PRINT_Z({"<>,"}) THEN
    _4DUP DULT IF PRINT_Z( {"<" }) THEN
    _4DUP_DULT_IF PRINT_Z( {"<" }) THEN
    _4DUP DULT_IF PRINT_Z( {"<,"}) THEN
    _4DUP DULE IF PRINT_Z({"<=" }) THEN
    _4DUP_DULE_IF PRINT_Z({"<=" }) THEN
    _4DUP DULE_IF PRINT_Z({"<=,"}) THEN
    _4DUP DUGT IF PRINT_Z( {">" }) THEN
    _4DUP_DUGT_IF PRINT_Z( {">" }) THEN
    _4DUP DUGT_IF PRINT_Z( {">,"}) THEN
    _4DUP DUGE IF PRINT_Z({">=" }) THEN
    _4DUP_DUGE_IF PRINT_Z({">=" }) THEN
    _4DUP DUGE_IF PRINT_Z({">=,"}) THEN
    _2SWAP UDDOT SPACE_UDDOT CR
SEMICOLON


COLON(x_p3_test)
    DUP_PUSH_EQ_IF(3) PRINT_Z( {"=,"}) THEN
    DUP_PUSH_NE_IF(3) PRINT_Z({"<>,"}) THEN
    DUP_PUSH_LT_IF(3) PRINT_Z( {"<,"}) THEN
    DUP_PUSH_LE_IF(3) PRINT_Z({"<=,"}) THEN
    DUP_PUSH_GT_IF(3) PRINT_Z( {">,"}) THEN
    DUP_PUSH_GE_IF(3) PRINT_Z({">=,"}) THEN
    DUP DOT PUSH(3) SPACE_DOT CR 
    DUP_PUSH_UEQ_IF(3) PRINT_Z( {"=,"}) THEN
    DUP_PUSH_UNE_IF(3) PRINT_Z({"<>,"}) THEN
    DUP_PUSH_ULT_IF(3) PRINT_Z( {"<,"}) THEN
    DUP_PUSH_ULE_IF(3) PRINT_Z({"<=,"}) THEN
    DUP_PUSH_UGT_IF(3) PRINT_Z( {">,"}) THEN
    DUP_PUSH_UGE_IF(3) PRINT_Z({">=,"}) THEN
    UDOT PUSH(3) SPACE_UDOT CR
SEMICOLON


COLON(x_m3_test)
    DUP_PUSH_EQ_IF(-3) PRINT_Z( {"=,"}) THEN
    DUP_PUSH_NE_IF(-3) PRINT_Z({"<>,"}) THEN
    DUP_PUSH_LT_IF(-3) PRINT_Z( {"<,"}) THEN
    DUP_PUSH_LE_IF(-3) PRINT_Z({"<=,"}) THEN
    DUP_PUSH_GT_IF(-3) PRINT_Z( {">,"}) THEN
    DUP_PUSH_GE_IF(-3) PRINT_Z({">=,"}) THEN
    DUP DOT PUSH(-3) SPACE_DOT CR 
    DUP_PUSH_UEQ_IF(-3) PRINT_Z( {"=,"}) THEN
    DUP_PUSH_UNE_IF(-3) PRINT_Z({"<>,"}) THEN
    DUP_PUSH_ULT_IF(-3) PRINT_Z( {"<,"}) THEN
    DUP_PUSH_ULE_IF(-3) PRINT_Z({"<=,"}) THEN
    DUP_PUSH_UGT_IF(-3) PRINT_Z( {">,"}) THEN
    DUP_PUSH_UGE_IF(-3) PRINT_Z({">=,"}) THEN
    UDOT PUSH(-3) SPACE_UDOT CR
SEMICOLON

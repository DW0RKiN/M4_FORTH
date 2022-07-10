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

    PRINT_I({"Depth:"})
    DEPTH DOT CR
    STOP
        
COLON(x_x_test)
    ; signed
     BEGIN _2DUP EQ WHILE PRINT_I( {"=" }) BREAK AGAIN
     BEGIN _2DUP_EQ_WHILE PRINT_I( {"=" }) BREAK AGAIN
     BEGIN _2DUP EQ_WHILE PRINT_I( {"=,"}) BREAK AGAIN
     BEGIN _2DUP NE WHILE PRINT_I({"<>" }) BREAK AGAIN
     BEGIN _2DUP_NE_WHILE PRINT_I({"<>" }) BREAK AGAIN
     BEGIN _2DUP NE_WHILE PRINT_I({"<>,"}) BREAK AGAIN
     BEGIN _2DUP LT WHILE PRINT_I( {"<" }) BREAK AGAIN
     BEGIN _2DUP_LT_WHILE PRINT_I( {"<" }) BREAK AGAIN
     BEGIN _2DUP LT_WHILE PRINT_I( {"<,"}) BREAK AGAIN
     BEGIN _2DUP LE WHILE PRINT_I({"<=" }) BREAK AGAIN
     BEGIN _2DUP_LE_WHILE PRINT_I({"<=" }) BREAK AGAIN
     BEGIN _2DUP LE_WHILE PRINT_I({"<=,"}) BREAK AGAIN
     BEGIN _2DUP GT WHILE PRINT_I( {">" }) BREAK AGAIN
     BEGIN _2DUP_GT_WHILE PRINT_I( {">" }) BREAK AGAIN
     BEGIN _2DUP GT_WHILE PRINT_I( {">,"}) BREAK AGAIN
     BEGIN _2DUP GE WHILE PRINT_I({">=" }) BREAK AGAIN
     BEGIN _2DUP_GE_WHILE PRINT_I({">=" }) BREAK AGAIN
     BEGIN _2DUP GE_WHILE PRINT_I({">=,"}) BREAK AGAIN
    OVER DOT DUP DOT CR  
    ; unsigned
    BEGIN _2DUP UEQ WHILE PRINT_I( {"=" }) BREAK AGAIN
    BEGIN _2DUP_UEQ_WHILE PRINT_I( {"=" }) BREAK AGAIN
    BEGIN _2DUP UEQ_WHILE PRINT_I( {"=,"}) BREAK AGAIN
    BEGIN _2DUP UNE WHILE PRINT_I({"<>" }) BREAK AGAIN
    BEGIN _2DUP_UNE_WHILE PRINT_I({"<>" }) BREAK AGAIN
    BEGIN _2DUP UNE_WHILE PRINT_I({"<>,"}) BREAK AGAIN
    BEGIN _2DUP ULT WHILE PRINT_I( {"<" }) BREAK AGAIN
    BEGIN _2DUP_ULT_WHILE PRINT_I( {"<" }) BREAK AGAIN
    BEGIN _2DUP ULT_WHILE PRINT_I( {"<,"}) BREAK AGAIN
    BEGIN _2DUP ULE WHILE PRINT_I({"<=" }) BREAK AGAIN
    BEGIN _2DUP_ULE_WHILE PRINT_I({"<=" }) BREAK AGAIN
    BEGIN _2DUP ULE_WHILE PRINT_I({"<=,"}) BREAK AGAIN
    BEGIN _2DUP UGT WHILE PRINT_I( {">" }) BREAK AGAIN
    BEGIN _2DUP_UGT_WHILE PRINT_I( {">" }) BREAK AGAIN
    BEGIN _2DUP UGT_WHILE PRINT_I( {">,"}) BREAK AGAIN
    BEGIN _2DUP UGE WHILE PRINT_I({">=" }) BREAK AGAIN
    BEGIN _2DUP_UGE_WHILE PRINT_I({">=" }) BREAK AGAIN
    BEGIN _2DUP UGE_WHILE PRINT_I({">=,"}) BREAK AGAIN
    SWAP UDOT UDOT CR
SEMICOLON


COLON(d_d_test)
    ; signed
     BEGIN _4DUP DEQ WHILE PRINT_I( {"=" }) BREAK AGAIN
     BEGIN _4DUP_DEQ_WHILE PRINT_I( {"=" }) BREAK AGAIN
     BEGIN _4DUP DEQ_WHILE PRINT_I( {"=,"}) BREAK AGAIN
     BEGIN _4DUP DNE WHILE PRINT_I({"<>" }) BREAK AGAIN
     BEGIN _4DUP_DNE_WHILE PRINT_I({"<>" }) BREAK AGAIN
     BEGIN _4DUP DNE_WHILE PRINT_I({"<>,"}) BREAK AGAIN
     BEGIN _4DUP DLT WHILE PRINT_I( {"<" }) BREAK AGAIN
     BEGIN _4DUP_DLT_WHILE PRINT_I( {"<" }) BREAK AGAIN
     BEGIN _4DUP DLT_WHILE PRINT_I( {"<,"}) BREAK AGAIN
     BEGIN _4DUP DLE WHILE PRINT_I({"<=" }) BREAK AGAIN
     BEGIN _4DUP_DLE_WHILE PRINT_I({"<=" }) BREAK AGAIN
     BEGIN _4DUP DLE_WHILE PRINT_I({"<=,"}) BREAK AGAIN
     BEGIN _4DUP DGT WHILE PRINT_I( {">" }) BREAK AGAIN
     BEGIN _4DUP_DGT_WHILE PRINT_I( {">" }) BREAK AGAIN
     BEGIN _4DUP DGT_WHILE PRINT_I( {">,"}) BREAK AGAIN
     BEGIN _4DUP DGE WHILE PRINT_I({">=" }) BREAK AGAIN
     BEGIN _4DUP_DGE_WHILE PRINT_I({">=" }) BREAK AGAIN
     BEGIN _4DUP DGE_WHILE PRINT_I({">=,"}) BREAK AGAIN
    _2OVER DDOT _2DUP DDOT CR  
    ; unsigned
    BEGIN _4DUP DUEQ WHILE PRINT_I( {"=" }) BREAK AGAIN
    BEGIN _4DUP_DUEQ_WHILE PRINT_I( {"=" }) BREAK AGAIN
    BEGIN _4DUP DUEQ_WHILE PRINT_I( {"=,"}) BREAK AGAIN
    BEGIN _4DUP DUNE WHILE PRINT_I({"<>" }) BREAK AGAIN
    BEGIN _4DUP_DUNE_WHILE PRINT_I({"<>" }) BREAK AGAIN
    BEGIN _4DUP DUNE_WHILE PRINT_I({"<>,"}) BREAK AGAIN
    BEGIN _4DUP DULT WHILE PRINT_I( {"<" }) BREAK AGAIN
    BEGIN _4DUP_DULT_WHILE PRINT_I( {"<" }) BREAK AGAIN
    BEGIN _4DUP DULT_WHILE PRINT_I( {"<,"}) BREAK AGAIN
    BEGIN _4DUP DULE WHILE PRINT_I({"<=" }) BREAK AGAIN
    BEGIN _4DUP_DULE_WHILE PRINT_I({"<=" }) BREAK AGAIN
    BEGIN _4DUP DULE_WHILE PRINT_I({"<=,"}) BREAK AGAIN
    BEGIN _4DUP DUGT WHILE PRINT_I( {">" }) BREAK AGAIN
    BEGIN _4DUP_DUGT_WHILE PRINT_I( {">" }) BREAK AGAIN
    BEGIN _4DUP DUGT_WHILE PRINT_I( {">,"}) BREAK AGAIN
    BEGIN _4DUP DUGE WHILE PRINT_I({">=" }) BREAK AGAIN
    BEGIN _4DUP_DUGE_WHILE PRINT_I({">=" }) BREAK AGAIN
    BEGIN _4DUP DUGE_WHILE PRINT_I({">=,"}) BREAK AGAIN
    _2SWAP UDDOT UDDOT CR
SEMICOLON



COLON(x_p3_test)
    ; signed
    BEGIN DUP_PUSH_EQ_WHILE(3) PRINT_I( {"=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_NE_WHILE(3) PRINT_I({"<>,"}) BREAK AGAIN
    BEGIN DUP_PUSH_LT_WHILE(3) PRINT_I( {"<,"}) BREAK AGAIN
    BEGIN DUP_PUSH_LE_WHILE(3) PRINT_I({"<=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_GT_WHILE(3) PRINT_I( {">,"}) BREAK AGAIN
    BEGIN DUP_PUSH_GE_WHILE(3) PRINT_I({">=,"}) BREAK AGAIN
    DUP DOT PUSH(3) DOT CR
    ; unsigned
    BEGIN DUP_PUSH_UEQ_WHILE(3) PRINT_I( {"=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UNE_WHILE(3) PRINT_I({"<>,"}) BREAK AGAIN
    BEGIN DUP_PUSH_ULT_WHILE(3) PRINT_I( {"<,"}) BREAK AGAIN
    BEGIN DUP_PUSH_ULE_WHILE(3) PRINT_I({"<=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UGT_WHILE(3) PRINT_I( {">,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UGE_WHILE(3) PRINT_I({">=,"}) BREAK AGAIN
    UDOT PUSH(3) UDOT CR
SEMICOLON


COLON(x_m3_test)
    ; signed
    BEGIN DUP_PUSH_EQ_WHILE(-3) PRINT_I( {"=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_NE_WHILE(-3) PRINT_I({"<>,"}) BREAK AGAIN
    BEGIN DUP_PUSH_LT_WHILE(-3) PRINT_I( {"<,"}) BREAK AGAIN
    BEGIN DUP_PUSH_LE_WHILE(-3) PRINT_I({"<=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_GT_WHILE(-3) PRINT_I( {">,"}) BREAK AGAIN
    BEGIN DUP_PUSH_GE_WHILE(-3) PRINT_I({">=,"}) BREAK AGAIN
    DUP DOT PUSH(-3) DOT CR
    ; unsigned
    BEGIN DUP_PUSH_UEQ_WHILE(-3) PRINT_I( {"=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UNE_WHILE(-3) PRINT_I({"<>,"}) BREAK AGAIN
    BEGIN DUP_PUSH_ULT_WHILE(-3) PRINT_I( {"<,"}) BREAK AGAIN
    BEGIN DUP_PUSH_ULE_WHILE(-3) PRINT_I({"<=,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UGT_WHILE(-3) PRINT_I( {">,"}) BREAK AGAIN
    BEGIN DUP_PUSH_UGE_WHILE(-3) PRINT_I({">=,"}) BREAK AGAIN
    UDOT PUSH(-3) UDOT CR
SEMICOLON

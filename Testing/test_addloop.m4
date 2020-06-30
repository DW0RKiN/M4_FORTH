; vvv
include(`../M4/FIRST.M4')dnl 
; ^^^
ORG 0x8000
INIT(60000)
VARIABLE(_stop)
VARIABLE(_krok) 
PUSH2(-1,1) CALL(_down1)
PUSH2(-1,1) CALL(_down2)
PUSH2(-1,1) CALL(_down3)
PUSH2(-1,1) CALL(_up1)
PUSH2(-1,1) CALL(_up2)
PUSH2(-1,1) CALL(_up3)
PUSH2(-1,1) CALL(_smycka)
PUSH2(-1,1) CALL(_otaznik)
CR
PUSH2(0,0) CALL(_down1)
PUSH2(0,0) CALL(_down2)
PUSH2(0,0) CALL(_down3)
PUSH2(0,0) CALL(_up1)
PUSH2(0,0) CALL(_up2)
PUSH2(0,0) CALL(_up3)
PUSH2(0,0) CALL(_smycka)
PUSH2(0,0) CALL(_otaznik)
CR
PUSH2(1,-1) CALL(_down1)
PUSH2(1,-1) CALL(_down2)
PUSH2(1,-1) CALL(_down3)
PUSH2(1,-1) CALL(_up1)
PUSH2(1,-1) CALL(_up2)
PUSH2(1,-1) CALL(_up3)
PUSH2(1,-1) CALL(_smycka)
PUSH2(1,-1) CALL(_otaznik)
CR
PUSH2( 4, 4) CALL(_down1)
PUSH2( 4, 4) CALL(_down2)
PUSH2( 1, 4) CALL(_down1)
PUSH2( 1, 4) CALL(_down2)
PUSH2( 4, 1) CALL(_down1)
PUSH2( 4, 1) CALL(_down2)
PUSH2( 2,-1) CALL(_down1)
PUSH2( 2,-1) CALL(_down2)
PUSH2(-1, 2) CALL(_down1)
PUSH2(-1, 2) CALL(_down2)
CR
PUSH2( 4, 4) CALL(_up1)
PUSH2( 4, 4) CALL(_up2)
PUSH2( 1, 4) CALL(_up1)
PUSH2( 1, 4) CALL(_up2)
PUSH2( 4, 1) CALL(_up1)
PUSH2( 4, 1) CALL(_up2)
PUSH2( 2,-1) CALL(_up1)
PUSH2( 2,-1) CALL(_up2)
PUSH2(-1, 2) CALL(_up1)
PUSH2(-1, 2) CALL(_up2)
CR
PUSH( 4) PUSH2( 1,0) CALL(_3loop)
PUSH( 0) PUSH2( 0,0) CALL(_3loop)
PUSH( 1) PUSH2( 4,0) CALL(_3loop)
PUSH( 2) PUSH2(-1,0) CALL(_3loop)
PUSH(-1) PUSH2( 2,0) CALL(_3loop)
CR
PUSH(-20) PUSH2(10,-10) CALL(_3loop)
PUSH(-20) PUSH2(11,-10) CALL(_3loop)
PUSH(-20) PUSH2(9,-10) CALL(_3loop)
CR
PUSH(4) PUSH2(1,0) CALL(_3sloop)
PUSH(0) PUSH2(0,0) CALL(_3sloop)
PUSH(1) PUSH2(4,0) CALL(_3sloop)
PUSH(2) PUSH2(-1,0) CALL(_3sloop)
PUSH(-1) PUSH2(2,0) CALL(_3sloop)
CR
PUSH(-20) PUSH2(10,-10) CALL(_3sloop)
PUSH(-20) PUSH2(11,-10) CALL(_3sloop)
PUSH(-20) PUSH2(9,-10) CALL(_3sloop)
CR
PRINT({"-1  1 -1 x:"}) XDO(-1, 1) I DOT PUSH_ADDXLOOP(-1) CR
PRINT({"-1  1 -2 x:"}) XDO(-1, 1) I DOT PUSH_ADDXLOOP(-2) CR
PRINT({"-1  1 -4 x:"}) XDO(-1, 1) I DOT PUSH_ADDXLOOP(-4) CR

PRINT({" 0  0 -1 x:"}) XDO( 0, 0) I DOT PUSH_ADDXLOOP(-1) CR
PRINT({" 0  0 -2 x:"}) XDO( 0, 0) I DOT PUSH_ADDXLOOP(-2) CR
PRINT({" 0  0 -4 x:"}) XDO( 0, 0) I DOT PUSH_ADDXLOOP(-4) CR

PRINT({" 2 -1  1 x:"}) XDO( 2,-1) I DOT PUSH_ADDXLOOP(1) CR
PRINT({" 2 -1  2 x:"}) XDO( 2,-1) I DOT PUSH_ADDXLOOP(2) CR
PRINT({" 2 -1  4 x:"}) XDO( 2,-1) I DOT PUSH_ADDXLOOP(4) CR
CR
PRINT({"-1  1  1 x:"}) PUSH2_STORE(5,_stop) XDO(-1,1) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(1) CR
PRINT({"-1  1  2 x:"}) PUSH2_STORE(5,_stop) XDO(-1,1) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(2) CR
PRINT({"-1  1  4 x:"}) PUSH2_STORE(5,_stop) XDO(-1,1) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(4) CR

PRINT({" 0  0  1 x:"}) PUSH2_STORE(5,_stop) XDO(0, 0) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(1) CR
PRINT({" 0  0  2 x:"}) PUSH2_STORE(5,_stop) XDO(0, 0) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(2) CR
PRINT({" 0  0  4 x:"}) PUSH2_STORE(5,_stop) XDO(0, 0) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(4) CR

PRINT({" 2 -1 -1 x:"}) PUSH2_STORE(5,_stop) XDO(2,-1) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(-1) CR
PRINT({" 2 -1 -2 x:"}) PUSH2_STORE(5,_stop) XDO(2,-1) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(-2) CR
PRINT({" 2 -1 -4 x:"}) PUSH2_STORE(5,_stop) XDO(2,-1) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN PUSH_ADDXLOOP(-4) CR
CR
PRINT({"-1 -1 ?x:"}) QUESTIONXDO(-1,-1) I DOT XLOOP CR
PRINT({" 1  1 ?x:"}) QUESTIONXDO( 1, 1) I DOT XLOOP CR
CR
PRINT({" 2 -1 x:"}) XDO( 2,-1) I DOT XLOOP CR
PRINT({"-1 -5 x:"}) XDO(-1,-5) I DOT XLOOP CR
CR
PRINT({"-1  1 x:"}) PUSH2_STORE(5,_stop) XDO(-1, 1) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN XLOOP CR
PRINT({" 0  0 x:"}) PUSH2_STORE(5,_stop) XDO( 0, 0) I DOT PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop) _0EQ_IF PRINT({".."})LEAVE THEN XLOOP CR
STOP

COLON(_down1)
    _2DUP _2DUP _2DUP
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d-1 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(-1) ADDLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d-1 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDLOOP(-1) CR 

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s-1 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(-1) ADDSLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s-1 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDSLOOP(-1) CR 
SEMICOLON

COLON(_up1) 
    _2DUP _2DUP _2DUP
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d 1 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(1) ADDLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d 1 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDLOOP(1) CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s 1 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(1) ADDSLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s 1 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDSLOOP(1) CR 
SEMICOLON

COLON(_down2)
    _2DUP _2DUP _2DUP

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d-2 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(-2) ADDLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d-2 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDLOOP(-2) CR 

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s-2 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(-2) ADDSLOOP CR 

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s-2 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDSLOOP(-2) CR 
SEMICOLON

COLON(_up2)
    _2DUP _2DUP _2DUP
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d 2 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(2) ADDLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d 2 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDLOOP(2) CR 

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s 2 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(2) ADDSLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s 2 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDSLOOP(2) CR 

SEMICOLON

COLON(_down3)
    _2DUP _2DUP _2DUP

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d-3 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(-3) ADDLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d-3 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDLOOP(-3) CR 

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s-3 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(-3) ADDSLOOP CR 

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s-3 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDSLOOP(-3) CR 
SEMICOLON

COLON(_up3)
    _2DUP _2DUP _2DUP
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d 3 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(3) ADDLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d 3 +l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDLOOP(3) CR 

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s 3 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH(3) ADDSLOOP CR 
    
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s 3 +l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    PUSH_ADDSLOOP(3) CR 

SEMICOLON

COLON(_smycka)
    _2DUP

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" d    l:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    LOOP CR

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({" s    l:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    SLOOP CR
SEMICOLON

COLON(_otaznik)
    _2DUP

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({"?d    l:"})
    QUESTIONDO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    LOOP CR

    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PRINT({"?s    l:"})
    QUESTIONSDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
    SLOOP CR
SEMICOLON




COLON(_3loop) 
    PUSH_STORE(_krok)
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PUSH_FETCH(_krok) DOT PRINT({"d:"})
    DO I DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
        PUSH_FETCH(_krok)
    ADDLOOP 
    CR 
SEMICOLON


COLON(_3sloop) 
    PUSH_STORE(_krok)
    PUSH2_STORE(5,_stop) 
    OVER DOT DUP_DOT PUSH_FETCH(_krok) DOT PRINT({"s:"})
    SDO SI DOT 
        PUSH_FETCH(_stop) _1SUB DUP PUSH_STORE(_stop)
        _0EQ_IF PRINT({".."})LEAVE THEN 
        PUSH_FETCH(_krok)
    ADDSLOOP 
    CR 
SEMICOLON

include({../M4/LAST.M4})dnl

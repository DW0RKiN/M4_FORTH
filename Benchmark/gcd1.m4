include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    CALL(gcd1_bench)
    STOP   
    COLON(gcd1,( a b -- gcd ))                                                                
        OVER_IF                                                                         
            BEGIN                                                                         
            DUP_WHILE                                                                   
                _2DUP_UGT_IF SWAP THEN OVER_SUB                                               
            REPEAT DROP 
        ELSE                                                               
            DUP_IF NIP ELSE _2DROP_PUSH(1) THEN                                                   
        THEN 
    SEMICOLON 
    COLON(gcd1_bench,( -- ))
        XDO(100,0)
            XDO(100,0) XJ XI CALL(gcd1) DROP XLOOP
        XLOOP
    SEMICOLON
include({../M4/LAST.M4})dnl

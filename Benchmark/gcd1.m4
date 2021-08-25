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
;#        PUSH2(100,0) SDO XJ OVER CALL(gcd1) DROP SLOOP
            XDO(100,0) XJ XI CALL(gcd1) DROP XLOOP
        XLOOP
    SEMICOLON

include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    CALL(gcd2_bench)
    STOP   
        
COLON(gcd2,( a b -- gcd ))
      _2DUP_D0EQ_IF _2DROP_PUSH(1) EXIT THEN                                          
         DUP_0EQ_IF   DROP         EXIT THEN                                          
    SWAP DUP_0EQ_IF   DROP         EXIT THEN                                          
    BEGIN 
    _2DUP_NE_WHILE  
        _2DUP_LT_IF 
            OVER SUB                                                          
        ELSE 
            SWAP OVER SUB SWAP                                              
        THEN                                                               
    REPEAT 
    NIP
SEMICOLON          

COLON(gcd2_bench,( -- ))
    XDO(100,0)
        XDO(100,0) XJ XI CALL(gcd2) DROP XLOOP
    XLOOP
SEMICOLON
include({../M4/LAST.M4})dnl

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
            OVER_SUB                                                          
        ELSE 
            SWAP OVER_SUB  ; swap                                              
        THEN                                                               
    REPEAT 
    NIP
SEMICOLON          

COLON(gcd2_bench,( -- ))
    PUSH(100) PUSH(0) DO
        PUSH(100) PUSH(0) DO 
            J I CALL(gcd2) DROP 
        LOOP
    LOOP
SEMICOLON

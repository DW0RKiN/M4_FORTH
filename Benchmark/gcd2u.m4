include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    CALL(gcd2_bench)
    STOP   
        
COLON(gcd2,( a b -- gcd ))
       _2DUP D0EQ IF _2DROP PUSH(1) EXIT THEN                                          
         DUP _0EQ IF   DROP         EXIT THEN                                          
    SWAP DUP _0EQ IF   DROP         EXIT THEN                                          
    BEGIN 
    _2DUP NE WHILE  
        _2DUP ULT IF 
            OVER SUB                                                          
        ELSE 
            SWAP OVER SUB  ; swap                                              
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

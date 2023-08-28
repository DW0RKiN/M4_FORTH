include(`../M4/FIRST.M4')dnl
  ifdef __ORG
    org __ORG
  else
    org 24576
  endif
    INIT(60000)
    CALL(gcd1_bench)
    STOP   

    COLON(gcd1,( a b -- gcd ))                                                                
        OVER IF                                                                         
            BEGIN                                                                         
            DUP WHILE                                                                   
                _2DUP UGT IF SWAP THEN OVER_SUB                                               
            REPEAT DROP 
        ELSE                                                               
            DUP IF NIP ELSE _2DROP PUSH(1) THEN                                                   
        THEN 
    SEMICOLON

    COLON(gcd1_bench,( -- ))
        PUSH(100,0) DO
            PUSH(100,0) DO 
                J I CALL(gcd1) DROP 
            LOOP
        LOOP
    SEMICOLON

include(`./FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    CALL(bench)
    STOP   

    COLON(gcd1,( a b -- gcd ))                                                                
    OVER IF                                                                         
            BEGIN                                                                         
            DUP_WHILE                                                                   
                _2DUP UGT IF SWAP THEN OVER SUB                                               
            REPEAT DROP 
        ELSE                                                               
            DUP IF NIP ELSE _2DROP_PUSH(1) THEN                                                   
        THEN 
    SEMICOLON
    
    COLON(gcd2,( a b -- gcd ))
      _2DUP_D0EQ_IF _2DROP_PUSH(1) EXIT THEN                                          
         DUP_0EQ_IF   DROP         EXIT THEN                                          
    SWAP DUP_0EQ_IF   DROP         EXIT THEN                                          
        BEGIN _2DUP SUB                                                                    
        WHILE _2DUP LT IF OVER SUB                                                          
                       ELSE SWAP OVER SUB SWAP                                              
                       THEN                                                               
        REPEAT NIP
    SEMICOLON

    COLON(bench,( -- ))
        XDO(10,0)
            XI DOT PUTCHAR(':')
            XDO(10,0) XJ XI DUP_DOT CALL(gcd1) DOT XLOOP
            CR
        XLOOP
    SEMICOLON
include({./LAST.M4})dnl

include(`./FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    CALL(bench)
    STOP   

    COLON(gcd1,( a b -- gcd ))                                                                
    OVER IF                                                                         
            BEGIN                                                                         
            DUP_WHILE                                                                   
                DUP2 UGT IF SWAP THEN OVER SUB                                               
            REPEAT DROP 
        ELSE                                                               
            DUP IF NIP ELSE DROP DROP_PUSH(1) THEN                                                   
        THEN 
    SEMICOLON
    
    COLON(gcd2,( a b -- gcd ))                                                              
        DCP0     IFZ DROP DROP_PUSH(1) EXIT THEN                                          
        CP0      IFZ DROP              EXIT THEN                                          
        SWAP CP0 IFZ DROP              EXIT THEN                                          
        BEGIN  DUP2 SUB                                                                    
        WHILE  DUP2 LT  IF OVER SUB                                                          
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

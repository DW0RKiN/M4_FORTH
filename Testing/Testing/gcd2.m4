include(`./FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    CALL(gcd2_bench)
    STOP   
        
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

    COLON(gcd2_bench,( -- ))
        XDO(100,0)
            XDO(100,0) XJ XI CALL(gcd2) DROP XLOOP
        XLOOP
    SEMICOLON
include({./LAST.M4})dnl

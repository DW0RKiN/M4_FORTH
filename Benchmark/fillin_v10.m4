include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    SCALL(Fillin)
    STOP   
    SCOLON(Fillin,( -- ))
        PUSH(0x4000) 
        BEGIN
        BEGIN
            PUSH_OVER_CSTORE_1ADD(255)
        DUP_PUSH_LO_EQ_UNTIL(0x5B00)
        DUP_PUSH_HI_EQ_UNTIL(0x5B00)
        DROP
    SSEMICOLON

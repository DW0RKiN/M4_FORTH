include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    SCALL(Fillin)
    STOP   
    SCOLON(Fillin,( -- ))
        PUSH(0x4000)
        BEGIN
            PUSH_OVER_CSTORE_1ADD(255)
            define({_TYP_SINGLE},{L_first}) DUP_PUSH_EQ_UNTIL(0x5B00)
        DROP
    SSEMICOLON

include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    SCALL(Fillin)
    STOP   
    SCOLON(Fillin,( -- ))
        PUSH2(65535,0x4000) BEGIN _2DUP_STORE_2ADD DUP_PUSH_EQ_UNTIL(0x5B00) _2DROP
    SSEMICOLON

include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    SCALL(Fillin)
    STOP   
    SCOLON(Fillin,( -- ))
         PUSH2(65535,0) XDO(23296,16384) DROP_XI _2DUP_STORE XLOOP _2DROP
    SSEMICOLON

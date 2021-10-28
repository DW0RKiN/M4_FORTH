include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    SCALL(Fillin)
    STOP   
    SCOLON(Fillin,( -- ))
        XDO(23296,16384) PUSH(65535) XI STORE PUSH_ADDXLOOP(2)
    SSEMICOLON

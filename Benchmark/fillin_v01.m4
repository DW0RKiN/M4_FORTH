include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)
    SCALL(Fillin)
    STOP   
    SCOLON(Fillin,( -- ))
        PUSH2(23296,16384) DO PUSH(255) I CSTORE LOOP
    SSEMICOLON

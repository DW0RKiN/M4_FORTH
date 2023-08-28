include(`../M4/FIRST.M4')dnl
  ifdef __ORG
    org __ORG
  else
    org 24576
  endif
    INIT(60000)
    SCALL(Fillin)
    STOP   
    SCOLON(Fillin,( -- ))
        PUSH2(23296,16384) DO PUSH(255) I STORE LOOP
    SSEMICOLON

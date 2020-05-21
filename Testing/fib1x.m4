include(`./FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    CALL(fib1_bench)
    STOP   
    SCOLON(fib1x,( a -- b ))
        DUP_PUSH(2) LT IF DROP_PUSH(1) SEXIT THEN
        DUP  ONE_SUB SCALL(fib1x) 
        SWAP TWO_SUB SCALL(fib1x) ADD
    SSEMICOLON
    COLON(fib1_bench,( -- ))
        XDO(1000,0)
            XDO(20,0) XI SCALL(fib1x) DROP XLOOP
        XLOOP
    SEMICOLON
include({./LAST.M4})dnl

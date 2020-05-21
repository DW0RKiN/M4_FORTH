include(`./FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    CALL(fib1_bench)
    STOP   
    XCOLON(fib1,( a -- b ))
        DUP PUSH(2) LT IF DROP_PUSH(1) EXIT THEN
        DUP  ONE_SUB XCALL(fib1) 
        SWAP TWO_SUB XCALL(fib1) ADD
    XSEMICOLON
    COLON(fib1_bench,( -- ))
        XDO(1000,0)
            XDO(20,0) XI XCALL(fib1) DROP XLOOP
        XLOOP
    SEMICOLON
include({./LAST.M4})dnl

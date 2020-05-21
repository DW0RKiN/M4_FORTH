include(`./FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    CALL(fib1_bench)
    STOP   
    COLON(fib1,( a -- b ))
        DUP PUSH(2) LT IF DROP_PUSH(1) EXIT THEN
        DUP  ONE_SUB CALL(fib1) 
        SWAP TWO_SUB CALL(fib1) ADD
    SEMICOLON
    COLON(fib1_bench,( -- ))
        XDO(1000,0)
            XDO(20,0) XI CALL(fib1) DROP XLOOP
        XLOOP
    SEMICOLON
include({./LAST.M4})dnl

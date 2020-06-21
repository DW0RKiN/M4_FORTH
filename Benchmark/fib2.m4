include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    CALL(fib2_bench)
    STOP   
    COLON(fib2,( n1 -- n2 ))
        PUSH2(0, 1) ROT PUSH(0) QUESTIONDO 
            OVER ADD SWAP LOOP 
        DROP
    SEMICOLON
    COLON(fib2_bench,( -- ))
        XDO(1000,0) 
            XDO(20,0) XI CALL(fib2) DROP XLOOP
        XLOOP
    SEMICOLON
include({../M4/LAST.M4})dnl

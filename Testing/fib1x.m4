include(`./FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib1_bench)
    STOP   
    SCOLON(fib1x,( a -- b ))
        DUP_PUSH_LT_IF(2) DROP_PUSH(1) SEXIT THEN
        DUP  ONE_SUB SCALL(fib1x) 
        SWAP TWO_SUB SCALL(fib1x) ADD
    SSEMICOLON
    SCOLON(fib1_bench,( -- ))
        PUSH2(1000,0) SDO
            PUSH2(20,0) SDO SI SCALL(fib1x) DROP SLOOP
        SLOOP
    SSEMICOLON
include({./LAST.M4})dnl

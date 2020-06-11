include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib1_bench)
    STOP   
    COLON(fib1,( a -- b ))
        DUP_PUSH_LT_IF(2) DROP_PUSH(1) EXIT THEN
        DUP  _1SUB CALL(fib1) 
        SWAP _2SUB CALL(fib1) ADD
    SEMICOLON
    SCOLON(fib1_bench,( -- ))
        PUSH(999) SFOR
            PUSH(19) SFOR SI CALL(fib1) DROP SNEXT
        SNEXT
    SSEMICOLON
include({../M4/LAST.M4})dnl

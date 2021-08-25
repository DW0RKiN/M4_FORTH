include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib1_bench)
    STOP   
    RCOLON(fib1,( a -- b ))
        DUP_PUSH_LT_IF(2) DROP_PUSH(1) REXIT THEN
        DUP  _1SUB RCALL(fib1) 
        SWAP _2SUB RCALL(fib1) ADD
    RSEMICOLON
    SCOLON(fib1_bench,( -- ))
        PUSH(999) SFOR
            PUSH(19) SFOR SI RCALL(fib1) DROP SNEXT
        SNEXT
    SSEMICOLON

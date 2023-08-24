include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib1_bench)
    STOP   
    RCOLON(fib1,( a -- b ))
        DUP PUSH(2) LT IF 
            DROP PUSH(1) REXIT 
        THEN
        DUP  _1SUB RCALL(fib1) 
        SWAP _2SUB RCALL(fib1) ADD
    RSEMICOLON
    SCOLON(fib1_bench,( -- ))
        PUSH(999) SFOR
            PUSH(19) SFOR I RCALL(fib1) DROP SNEXT
        SNEXT
    SSEMICOLON

include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib1s_bench)
    STOP   
    SCOLON(fib1s,( a -- b ))
        DUP PUSH(2) LT IF 
            DROP PUSH(1) SEXIT 
        THEN
        DUP  _1SUB SCALL(fib1s) 
        SWAP _2SUB SCALL(fib1s) ADD
    SSEMICOLON
    SCOLON(fib1s_bench,( -- ))
        PUSH(999) SFOR
            PUSH(19) SFOR I SCALL(fib1s) DROP SNEXT
        SNEXT
    SSEMICOLON

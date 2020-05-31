include(`./FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib1_bench)
    STOP   
    SCOLON(fib1x,( a -- b ))
        DUP_PUSH_LT_IF(2) DROP_PUSH(1) SEXIT THEN
        DUP  _1SUB SCALL(fib1x) 
        SWAP _2SUB SCALL(fib1x) ADD
    SSEMICOLON
    SCOLON(fib1_bench,( -- ))
        PUSH(999) SFOR
            PUSH2(20,0) SDO SI SCALL(fib1x) DROP SLOOP
        SNEXT
    SSEMICOLON
include({./LAST.M4})dnl

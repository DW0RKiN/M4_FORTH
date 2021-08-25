include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib2s_bench)
    STOP   
    SCOLON(fib2s,( n1 -- n2 ))
        DUP_0EQ_IF SEXIT THEN
        PUSH2(0, 1) ROT _1SUB 
        FOR 
            OVER_ADD SWAP
        NEXT
        DROP
    SSEMICOLON
    SCOLON(fib2s_bench,( -- ))
        XDO(1000,0) 
            XDO(20,0) XI SCALL(fib2s) DROP XLOOP
        XLOOP
    SSEMICOLON


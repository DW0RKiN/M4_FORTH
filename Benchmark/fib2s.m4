include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib2s_bench)
    STOP   
    SCOLON(fib2s,( n1 -- n2 ))
        PUSH2(0, 1) ROT PUSH(0) QUESTIONDO 
            OVER ADD SWAP LOOP 
        DROP
    SSEMICOLON
    SCOLON(fib2s_bench,( -- ))
        XDO(1000,0) 
            XDO(20,0) XI SCALL(fib2s) DROP XLOOP
        XLOOP
    SSEMICOLON
include({../M4/LAST.M4})dnl

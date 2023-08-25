include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(35000)
    SCALL(fib2s_bench)
    STOP   
    SCOLON(fib2s,( n1 -- n2 ))
        DUP _0EQ IF SEXIT THEN
        PUSH(0) PUSH(1) ROT _1SUB 
        FOR 
            OVER ADD SWAP
        NEXT
        DROP
    SSEMICOLON
    SCOLON(fib2s_bench,( -- ))
        PUSH(1000) PUSH(0) DO 
            PUSH2(20) PUSH(0) DO I SCALL(fib2s) DROP LOOP
        LOOP
    SSEMICOLON

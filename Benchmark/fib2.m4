include(`../M4/FIRST.M4')dnl
  ifdef __ORG
    org __ORG
  else
    org 24576
  endif
    INIT(35000)
    CALL(fib2_bench)
    STOP   
    COLON(fib2,( n1 -- n2 ))
        PUSH(0) PUSH(1) ROT PUSH(0) QUESTIONDO 
            OVER ADD SWAP LOOP 
        DROP
    SEMICOLON
    COLON(fib2_bench,( -- ))
        PUSH(1000) PUSH(0) DO 
            PUSH(20) PUSH(0) DO I CALL(fib2) DROP LOOP
        LOOP
    SEMICOLON

DIM m as Uinteger
DIM n as Uinteger
DIM i as Uinteger
DIM a as Uinteger
DIM b as Uinteger
DIM c as Uinteger


GOSUB fib2_bench
END
    
fib2:
    LET a=0
    LET b=1
    FOR i = 1 TO n 
        LET c = b
        LET b = a
        LET a = a + c
    NEXT i
RETURN

fib2_bench:
FOR m = 0 to 999
    FOR n = 0 to 19 
        GOSUB fib2
    NEXT n
NEXT m
RETURN

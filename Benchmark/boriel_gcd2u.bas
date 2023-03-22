DIM m as Uinteger
DIM n as Uinteger
DIM a as Uinteger
DIM b as Uinteger

GOSUB gcd2_bench
END
    
gcd2:
    LET a=m
    LET b=n
    
    IF (a bOR b )=0 THEN 
        LET a=1
        RETURN
    END IF
    IF a=0 THEN 
        LET a=b
        RETURN
    END IF
    IF b=0 THEN 
        RETURN
    END IF
    
    WHILE a <> b
        IF (a>b) THEN
            LET a = a - b
        ELSE
            LET b = b - a
        END IF
    END WHILE
RETURN

gcd2_bench:
FOR m = 0 to 99
    FOR n = 0 to 99 
        GOSUB gcd2
    NEXT n
NEXT m
RETURN

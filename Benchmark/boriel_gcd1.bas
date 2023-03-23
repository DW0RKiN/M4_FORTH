DIM i as integer
DIM j as integer
DIM a as integer
DIM b as integer
DIM c as integer

GOSUB gcd1_bench
END
    
gcd1:
    LET a=i
    LET b=j
    
    IF a THEN     
        WHILE b
            IF (a>b) THEN
                LET c = a
                LET a = b
                LET b = c
            END IF
            let b = b - a
        END WHILE
    ELSE
        LET a = 1
        IF b THEN LET a = b
    END IF
RETURN

gcd1_bench:
FOR i = 0 to 99
    FOR j = 0 to 99 
        GOSUB gcd1
    NEXT j
NEXT i
RETURN

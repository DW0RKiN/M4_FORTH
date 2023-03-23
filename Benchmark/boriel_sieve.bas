REM /*******************************/
REM /* Number of        Array Size */
REM /* Primes Found      (Bytes)   */
REM /*     1899;             8191  */
REM /*     2261;            10000  */
REM /*     4202;            20000  */
REM /*     7836;            40000  */
REM /*    14683;            80000  */
REM /*    27607;           160000  */
REM /*    52073;           320000  */
REM /*    98609;           640000  */
REM /*   187133;          1280000  */
REM /*   356243;          2560000  */
REM /*   679460;          5120000  */
REM /*  1299068;         10240000  */
REM /*  2488465;         20480000  */
REM /*        0;         40960000  */
REM /*        0;         81920000  */
REM /*        0;        163840000  */

REM #define MAX_MEM 10240

REM /**************************************/
REM /*  Sieve of Erathosthenes Program    */
REM /**************************************/

DIM Size as Uinteger = 8191 
DIM SIEVE(0 to 8191) as Byte

GOSUB Erathos
END


Erathos:
    
    DIM i,j,prime,count as Uinteger 
    
    LET count = 0
       
REM    FOR i=0 TO Size
REM        LET SIEVE(i) = 0
REM    NEXT i

    FOR i=0 TO Size
        IF SIEVE(i) = 0 THEN
            LET count = count + 1
            LET prime = i + i + 3

            FOR j = i + prime TO Size STEP prime
                SIEVE(j) = 1
            NEXT j
        END IF
    NEXT i

    
    PRINT count;" PRIMES"
RETURN

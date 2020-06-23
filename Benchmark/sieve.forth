8190 constant size
8191 constant size_add1

variable flags  
0 flags ! size allot

: do-prime
flags size_add1 1 fill
0 size 0 do 
    flags I + C@
    if I dup + 3 + dup I +
        begin 
        dup size_add1 < while 
            0 over flags + C! over + 
        repeat
        drop drop 1+
    then
loop
. ." PRIMES" ;


do-prime

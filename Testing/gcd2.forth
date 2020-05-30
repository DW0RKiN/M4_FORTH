: gcd2 ( a b -- gcd )                                                              
   2DUP        D0= IF  2DROP 1 EXIT   THEN                                          
   DUP          0= IF   DROP   EXIT   THEN                                          
   SWAP DUP     0= IF   DROP   EXIT   THEN                                          
   BEGIN  2DUP -                                                                    
   WHILE  2DUP < IF OVER -                                                          
                 ELSE SWAP OVER - SWAP                                              
                 THEN                                                               
   REPEAT NIP ;          

: gcd2-bench 100 0 DO 
      100 0 DO j i gcd2 drop loop
      loop ;

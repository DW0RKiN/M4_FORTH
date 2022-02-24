10  REM ZX Spectrum Basic - Levenshtein distance
20  INPUT "first word:",n$
30  INPUT "second word:",m$
35  POKE 23672,0: POKE 23673,0: POKE 23674,0
40  LET n=LEN n$:LET m=LEN m$:DIM d(m+1,n+1)
50  FOR i=1 TO m:LET d(i+1,1)=i:NEXT i
60  FOR j=1 TO n:LET d(1,j+1)=j:NEXT j
70  FOR j=1 TO n
80    FOR i=1 TO m
90       LET r=d(i,j)-(n$(j)=m$(i)):REM substitution
100      IF r>d(i,j+1) THEN LET r=r-1:REM insertion
110      LET d(i+1,j+1)=r+(r<=d(i+1,j)):REM deletion
120   NEXT i
130 NEXT j
135 PAUSE 1: LET s=PEEK 23672+256*PEEK 23673+65536*PEEK 23674
140 PRINT "The Levenshtein distance between """;n$;""", """;m$;""" is ";d(m+1,n+1);"."
145 LET s=s/50: LET m=INT (INT s/60): LET h=INT (m/60):PRINT "Time: ";h;"h ";m-60*h;"min ";INT ((s-60*m)*100)/100;"s"

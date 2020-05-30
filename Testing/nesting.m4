include(`./FIRST.M4')dnl 
ORG 0x8000
INIT(60000)
PRINT({"enter 1million or 32million", 0xD})
CALL(_1million)
STOP

;( Forth nesting (NEXT) Benchmark     cas20101204 )
COLON(bottom) SEMICOLON    
COLON(_1st)  CALL(bottom) CALL(bottom) SEMICOLON  COLON(_2nd)  CALL(_1st)  CALL(_1st)  SEMICOLON   COLON(_3rd)  CALL(_2nd)  CALL(_2nd)  SEMICOLON
COLON(_4th)  CALL(_3rd)   CALL(_3rd)   SEMICOLON  COLON(_5th)  CALL(_4th)  CALL(_4th)  SEMICOLON   COLON(_6th)  CALL(_5th)  CALL(_5th)  SEMICOLON
COLON(_7th)  CALL(_6th)   CALL(_6th)   SEMICOLON  COLON(_8th)  CALL(_7th)  CALL(_7th)  SEMICOLON   COLON(_9th)  CALL(_8th)  CALL(_8th)  SEMICOLON
COLON(_10th) CALL(_9th)   CALL(_9th)   SEMICOLON  COLON(_11th) CALL(_10th) CALL(_10th) SEMICOLON   COLON(_12th) CALL(_11th) CALL(_11th) SEMICOLON
COLON(_13th) CALL(_12th)  CALL(_12th)  SEMICOLON  COLON(_14th) CALL(_13th) CALL(_13th) SEMICOLON   COLON(_15th) CALL(_14th) CALL(_14th) SEMICOLON
COLON(_16th) CALL(_15th)  CALL(_15th)  SEMICOLON  COLON(_17th) CALL(_16th) CALL(_16th) SEMICOLON   COLON(_18th) CALL(_17th) CALL(_17th) SEMICOLON
COLON(_19th) CALL(_18th)  CALL(_18th)  SEMICOLON  COLON(_20th) CALL(_19th) CALL(_19th) SEMICOLON   COLON(_21th) CALL(_20th) CALL(_20th) SEMICOLON
COLON(_22th) CALL(_21th)  CALL(_21th)  SEMICOLON  COLON(_23th) CALL(_22th) CALL(_22th) SEMICOLON   COLON(_24th) CALL(_23th) CALL(_23th) SEMICOLON
COLON(_25th) CALL(_24th)  CALL(_24th)  SEMICOLON            

COLON(_32million)  PRINT({"32 million nest/unnest operations", 0xD}) CALL(_25th) SEMICOLON
COLON(_1million)   PRINT({" 1 million nest/unnest operations", 0xD}) CALL(_20th) SEMICOLON

include({./LAST.M4})dnl

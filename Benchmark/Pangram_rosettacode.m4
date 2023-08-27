include(`../M4/FIRST.M4')dnl 
ORG 0x8000
INIT(60000)
STRING({"The five boxing wizards jump quickly."})
PUSH_FOR(9999)
    _2DUP
    CALL(_pangram_)
    DROP
NEXT
CALL(_pangram_) SPACE DOT CR  ;# -1
STOP
COLON(_pangram_,( addr len -- ? )) 
  PUSHDOT(0) _2SWAP OVER_ADD SWAP DO
    I CFETCH PUSH(32) OR PUSH('a') SUB
    DUP PUSH(0) PUSH(26) WITHIN IF
      PUSHDOT(1) ROT DLSHIFT DOR
    ELSE DROP THEN
  LOOP
  PUSHDOT(0x3FFFFFF) DEQ SEMICOLON

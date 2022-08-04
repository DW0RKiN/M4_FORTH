include(`../M4/FIRST.M4')dnl 
ORG 0x8000
INIT(60000)
STRING({"The five boxing wizards jump quickly."})
PUSH_FOR(9999)
    _2DUP
    CALL(_pangram_)
    DROP
NEXT
CALL(_pangram_) SPACE_DOT CR  ;# -1
STOP
COLON(_pangram_,( addr len -- ? )) 
  PUSHDOT_2SWAP(0) OVER_ADD SWAP DO
    I CFETCH PUSH_OR(32) PUSH_SUB('a')
    DUP_PUSH2_WITHIN_IF(0,26)
      PUSHDOT(1) ROT_DLSHIFT DOR
    ELSE DROP THEN
  LOOP
  PUSHDOT_DEQ(0x3FFFFFF) SEMICOLON

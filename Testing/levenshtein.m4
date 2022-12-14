;vvvv
include(`../M4/FIRST.M4')dnl
;^^^^
ORG 0x8000

    INIT(60000)
    CONSTANT(max_len,25)
    CVARIABLE(len_1)
    CVARIABLE(len_2)
    CREATE(word_1) PUSH_ALLOT(max_len)
    CREATE(word_2) PUSH_ALLOT(max_len)
    CREATE(table)
    
    PRINT({"The Levenshtein distance between ", 0x22})
    PUSH2(word_1, max_len)
    ACCEPT_Z
    
    ;# self-modifying code
    DUP PUSH(label_03) CSTORE
    _1ADD
    DUP PUSH(label_01) CSTORE DUP PUSH(label_02) CSTORE DUP PUSH(len_1) CSTORE    
    ;# ( word_1_len )
    
    ;# 0 1 2 3 4 5 ... set first row
    DUP
    PUSH(table) ADD
    SWAP _1ADD SWAP
    ;#PUSH2(max_word_1_len+1,table+max_word_1_len+1)
    BEGIN
        _2DUP CSTORE
        _1SUB 
        SWAP _1SUB SWAP 
    OVER _0EQ UNTIL

    _1ADD
    SWAP
    _1ADD
    
    PRINT({0x22, " and ", 0x22})
    PUSH2(word_2, max_len)
    ACCEPT_Z
    
    _1ADD
    DUP_PUSH_CSTORE(len_2)
    
    PRINT({0x22, " is "})
        
    ;# ( table 1 word_2_len )
    
    ;# 0 set first column
    ;# 1
    ;# 2
    ;# 3
    BEGIN
        NROT SWAP
        _2DUP CSTORE
        PUSH(len_1) CFETCH ADD
        SWAP _1ADD SWAP
        NROT SWAP
        _1SUB
    DUP _0EQ UNTIL
    DROP _2DROP
    
    ;#SCALL(view_table)
    ;#CR
    
    ;# 0x8061 breakpoint
    ARRAY_SET(table)
    PUSH(word_2)    
;# ( P_word_2 )
    BEGIN
;#        SCALL(view_table)
        PUSH(word_1)
;# ( P_word_2 P_word_1 )
        BEGIN
;# 0x8091
    ;# substitution 
        ;# LET r=d(j,i)-(n$(j)=m$(i)):REM substitution
            OVER_CFETCH_OVER_CFETCH_CEQ
            ;# ( P_word_2  P_word_1 flag(char_1==char_2) )
            ARRAY_CFETCH_ADD(0)
            ;# ( P_word_2  P_word_1 R=[index+0]+flag )
            
    ;# insertion 
        ;# IF r>d(j+1,i) THEN LET r=r-1:REM insertion
            DUP_ARRAY_CFETCH_UGT(0, label_01)
            ;# ( P_word_2  P_word_1 R flag(R (U)> [index+max_word_1_len]) )
            ADD
            ;# ( P_word_2  P_word_1 R+flag )
            ARRAY_INC
            ;# index++
            
    ;# deletion 
        ;# LET d(j+1,i+1)=r+(r<=d(j,i+1)):REM deletion
            DUP_ARRAY_CFETCH_ULE(0) 
            ;# ( P_word_2  P_word_1 R flag(R (U)<= [index]) )
            SUB
            ;# ( P_word_2  P_word_1 R-flag )
            ARRAY_CSTORE(0, label_02)
            ;# [index+max_word_1_len] = R
            
            _1ADD
            ;# ( P_word_1  P_word_2++ )
        DUP CFETCH _0EQ UNTIL
        
        ARRAY_INC

        DROP
        _1ADD
        ;# ( P_word_1++ )        
    DUP_CFETCH_0EQ_UNTIL
    
    DROP
    ARRAY_CFETCH(0, label_03)
    _1SUB
    
    ;#SCALL(view_table)
    ;#CR

    UDOTZXROM
    PRINT({".", 0x0D})
    
    STOP
    
SCOLON(view_table)
    PUSH_CFETCH_PUSH(len_2,table)
    BEGIN
        CR
        PUSH(len_1) CFETCH
        BEGIN
            OVER CFETCH
            UDOTZXROM
            SWAP _1ADD SWAP 
            _1SUB
        DUP _0EQ UNTIL
        DROP
        SWAP _1SUB SWAP 
    OVER _0EQ UNTIL
    _2DROP
SSEMICOLON
    
    
SCOLON(clear_table)
    PUSH_CFETCH_PUSH(len_2,table)
    BEGIN
        PUSH(len_1) CFETCH
        BEGIN
            OVER PUSH(0) SWAP CSTORE
            SWAP _1ADD SWAP
            _1SUB
        DUP _0EQ UNTIL
        DROP
        SWAP _1SUB SWAP 
    OVER _0EQ UNTIL
    _2DROP
SSEMICOLON

;vvvv
include(`../M4/FIRST.M4')dnl
;^^^^
ORG 0x8000

    INIT(60000)
    PRINT({"The Levenshtein distance between ", 0x22})
    PUSH2(word_1, word_1_len)
    ACCEPT_Z
    CVARIABLE(len_1)
    
    ;# self-modifying code
    DUP_PUSH_CSTORE(label_03)
    _1ADD
    DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE(label_01,label_02,len_1)    
    ;# ( word_1_len )
    
    ;# 0 1 2 3 4 5 ... set first row
    DUP
    PUSH_ADD(table)
    SWAP_1ADD_SWAP
    ;#PUSH2(max_word_1_len+1,table+max_word_1_len+1)
    BEGIN
        _2DUP_CSTORE
        _1SUB 
        SWAP_1SUB_SWAP 
    OVER_INVERT_UNTIL

    _1ADD
    SWAP
    _1ADD
    
    PRINT({0x22, " and ", 0x22})
    PUSH2(word_2, word_2_len)
    ACCEPT_Z
    
    _1ADD
    CVARIABLE(len_2)
    DUP_PUSH_CSTORE(len_2)
    
    PRINT({0x22, " is"})
        
    ;# ( table 1 word_2_len )
    
    ;# 0 set first column
    ;# 1
    ;# 2
    ;# 3
    BEGIN
        NROT_SWAP
        _2DUP_CSTORE
        PUSH_CFETCH(len_1)
        ADD
        SWAP_1ADD_SWAP
        NROT_SWAP
        _1SUB
    DUP_INVERT_UNTIL
    DROP_2DROP
    
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
            OVER_CFETCH_OVER_CFETCH
            ;# ( P_word_2  P_word_1 char_1 char_2 )
            CEQ
            ;# ( P_word_2  P_word_1 flag)
            ARRAY_CFETCH_ADD(0)
            ;# ( P_word_2  P_word_1 R=[index+0]+flag )
            
    ;# insertion 
        ;# IF r>d(j+1,i) THEN LET r=r-1:REM insertion
            DUP_ARRAY_CFETCH(0, label_01)
            ;# ( P_word_2  P_word_1 R R [index+max_word_1_len] )
            UGT ADD
            ;# ( P_word_2  P_word_1 R+flag )
            ARRAY_INC
            ;# index++
            
    ;# deletion 
        ;# LET d(j+1,i+1)=r+(r<=d(j,i+1)):REM deletion
            DUP_ARRAY_CFETCH(0) 
            ;# ( P_word_2  P_word_1 R R [index] )
            ULE 
            ;# ( P_word_2  P_word_1 R flag )
            SUB
            ;# ( P_word_2  P_word_1 R-flag )
            ARRAY_CSTORE(0, label_02)
            ;# [index+max_word_1_len] = R
            
            _1ADD
            ;# ( P_word_1  P_word_2++ )
        DUP_CFETCH_INVERT_UNTIL
        
        ARRAY_INC

        DROP
        _1ADD
        ;# ( P_word_1++ )        
    DUP_CFETCH_INVERT_UNTIL
    
    DROP
    ARRAY_CFETCH(0, label_03)
    _1SUB
    
    ;#SCALL(view_table)
    ;#CR

    DOT
    PRINT({".", 0x0D})
    
    STOP
    
SCOLON(view_table)
    PUSH_CFETCH(len_2)
    PUSH(table)
    BEGIN
        CR
        PUSH_CFETCH(len_1)
        BEGIN
            OVER CFETCH
            DOT
            SWAP_1ADD_SWAP 
            _1SUB
        DUP_INVERT_UNTIL
        DROP
        SWAP_1SUB_SWAP 
    OVER_INVERT_UNTIL
    _2DROP
SSEMICOLON
    
    
SCOLON(clear_table)
    PUSH_CFETCH(len_2)
    PUSH(table)
    BEGIN
        PUSH_CFETCH(len_1)
        BEGIN
            SWAP
            DUP_PUSH_SWAP_CSTORE(0)
            _1ADD
            SWAP
            _1SUB
        DUP_INVERT_UNTIL
        DROP
        SWAP_1SUB_SWAP 
    OVER_INVERT_UNTIL
    _2DROP
SSEMICOLON
    
    
    
include({../M4/LAST.M4})dnl

word_1:
db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
word_1_len EQU $-word_1
row_size EQU $-word_1
word_2:
db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
word_2_len EQU $-word_2
table:

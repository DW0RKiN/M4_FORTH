;vvvv
include(`../M4/FIRST.M4')dnl
;^^^^
ORG 0x8000

    INIT(60000)
    PRINT({"The Levenshtein distance between ", 0x22})
    PUSH2(first_word, first_word_len-1)
    ACCEPT
    CVARIABLE(f_len)
    
    PUSH_OVER_PUSH_ADD_CSTORE(0,first_word)

    ;# self-modifying code
    DUP_PUSH_CSTORE(label_03)
    _1ADD
    DUP_PUSH_CSTORE_DUP_PUSH_CSTORE(label_01,label_02)    
    DUP_PUSH_CSTORE(f_len)
    ;# ( first_word_len )
    
    ;# 0 1 2 3 4 5 ... set first row
    DUP
    PUSH_ADD(table)
    SWAP_1ADD_SWAP
    ;#PUSH2(max_first_word_len+1,table+max_first_word_len+1)
    BEGIN
        _2DUP_CSTORE
        _1SUB 
        SWAP_1SUB_SWAP 
    OVER_INVERT_UNTIL

    _1ADD
    SWAP
    _1ADD
    
    PRINT({0x22, " and ", 0x22})
    PUSH2(second_word, second_word_len-1)
    ACCEPT
    
    PUSH_OVER_PUSH_ADD_CSTORE(0,second_word)
    
    _1ADD
    CVARIABLE(s_len)
    DUP_PUSH_CSTORE(s_len)
    
    PRINT({0x22, " is"})
        
    ;# ( table 1 second_word_len )
    
    ;# 0 set first column
    ;# 1
    ;# 2
    ;# 3
    BEGIN
        NROT_SWAP
        _2DUP_CSTORE
        PUSH_CFETCH(f_len)
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
    PUSH(second_word)    
;# ( P_second_word )
    BEGIN
;#        SCALL(view_table)
        PUSH(first_word)
;# ( P_second_word P_first_word )
        BEGIN
;# 0x8091
    ;# substitution 
        ;# LET r=d(j,i)-(n$(j)=m$(i)):REM substitution
            OVER_CFETCH_OVER_CFETCH
            ;# ( P_second_word  P_first_word first_char second_char )
            CEQ
            ;# ( P_second_word  P_first_word flag)
            ARRAY_CFETCH_ADD(0)
            ;# ( P_second_word  P_first_word R=[index+0]+flag )
            
    ;# insertion 
        ;# IF r>d(j+1,i) THEN LET r=r-1:REM insertion
            DUP_ARRAY_CFETCH(0, label_01)
            ;# ( P_second_word  P_first_word R R [index+max_first_word_len] )
            UGT ADD
            ;# ( P_second_word  P_first_word R+flag )
            ARRAY_INC
            ;# index++
            
    ;# deletion 
        ;# LET d(j+1,i+1)=r+(r<=d(j,i+1)):REM deletion
            DUP_ARRAY_CFETCH(0) 
            ;# ( P_second_word  P_first_word R R [index] )
            ULE 
            ;# ( P_second_word  P_first_word R flag )
            SUB
            ;# ( P_second_word  P_first_word R-flag )
            ARRAY_CSTORE(0, label_02)
            ;# [index+max_first_word_len] = R
            
            _1ADD
            ;# ( P_first_word  P_second_word++ )
        DUP_CFETCH_INVERT_UNTIL
        
        ARRAY_INC

        DROP
        _1ADD
        ;# ( P_first_word++ )        
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
    PUSH_CFETCH(s_len)
    PUSH(table)
    BEGIN
        CR
        PUSH_CFETCH(f_len)
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
    PUSH_CFETCH(s_len)
    PUSH(table)
    BEGIN
        PUSH_CFETCH(f_len)
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

first_word:
db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
first_word_len EQU $-first_word
row_size EQU $-first_word
second_word:
db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
second_word_len EQU $-second_word
table:

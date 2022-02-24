;vvvv
;^^^^
ORG 0x8000

    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    
    push DE             ; 1:11      print     "The Levenshtein distance between ", 0x22
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(first_word,first_word_len-1)
    ld   DE, first_word ; 3:10      push2(first_word,first_word_len-1)
    push HL             ; 1:11      push2(first_word,first_word_len-1)
    ld   HL, first_word_len-1; 3:10      push2(first_word,first_word_len-1)
    
    call READSTRING     ; 3:17      accept
    
    
    
    ld    A, low first_word; 2:7       0 over first_word add C! push_over_push_add_cstore(0,first_word)   ( addr -- )
    add   A, L          ; 1:4       0 over first_word add C! push_over_push_add_cstore(0,first_word)
    ld    C, A          ; 1:4       0 over first_word add C! push_over_push_add_cstore(0,first_word)
    ld    A, high first_word; 2:7       0 over first_word add C! push_over_push_add_cstore(0,first_word)
    adc   A, H          ; 1:4       0 over first_word add C! push_over_push_add_cstore(0,first_word)
    ld    B, A          ; 1:4       0 over first_word add C! push_over_push_add_cstore(0,first_word)
    xor   A             ; 1:4       0 over first_word add C! push_over_push_add_cstore(0,first_word)
    ld  (BC),A          ; 1:7       0 over first_word add C! push_over_push_add_cstore(0,first_word)

    ;# self-modifying code
    
    ld    A, L          ; 1:4       dup label_03 C! dup push(label_03) cstore
    ld   (label_03), A  ; 3:13      dup label_03 C! dup push(label_03) cstore
    
    inc  HL             ; 1:6       1+
    
    ld    A, L          ; 1:4       dup label_01 C! dup label_02 C! dup push(label_01) cstore dup push(label_02) cstore
    ld   (label_01), A  ; 3:13      dup label_01 C! dup label_02 C! dup push(label_01) cstore dup push(label_02) cstore
    ld   (label_02), A  ; 3:13      dup label_01 C! dup label_02 C! dup push(label_01) cstore dup push(label_02) cstore    
    
    ld    A, L          ; 1:4       dup f_len C! dup push(f_len) cstore
    ld   (f_len), A     ; 3:13      dup f_len C! dup push(f_len) cstore
    ;# ( first_word_len )
    
    ;# 0 1 2 3 4 5 ... set first row
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
    
    ; warning The condition >>>table<<< cannot be evaluated
    ld   BC, table      ; 3:10      table +
    add  HL, BC         ; 1:11      table +
    
    inc  DE             ; 1:6       swap 1+ swap
    ;#PUSH2(max_first_word_len+1,table+max_first_word_len+1)
    
begin101:               ;           begin 101
        
                        ;[1:7]      2dup c! _2dup_cstore   ( char addr -- char addr )
    ld  (HL),E          ; 1:7       2dup c! _2dup_cstore
        
    dec  HL             ; 1:6       1- 
        
    dec  DE             ; 1:6       swap 1- swap 
    
    ld    A, D          ; 1:4       over invert until 101   ( flag x -- flag x )
    or    E             ; 1:4       over invert until 101
    jp   nz, begin101   ; 3:10      over invert until 101
break101:               ;           over invert until 101

    
    inc  HL             ; 1:6       1+
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b )
    
    inc  HL             ; 1:6       1+
    
    
    push DE             ; 1:11      print     0x22, " and ", 0x22
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(second_word,second_word_len-1)
    ld   DE, second_word; 3:10      push2(second_word,second_word_len-1)
    push HL             ; 1:11      push2(second_word,second_word_len-1)
    ld   HL, second_word_len-1; 3:10      push2(second_word,second_word_len-1)
    
    call READSTRING     ; 3:17      accept
    
    
    ld    A, low second_word; 2:7       0 over second_word add C! push_over_push_add_cstore(0,second_word)   ( addr -- )
    add   A, L          ; 1:4       0 over second_word add C! push_over_push_add_cstore(0,second_word)
    ld    C, A          ; 1:4       0 over second_word add C! push_over_push_add_cstore(0,second_word)
    ld    A, high second_word; 2:7       0 over second_word add C! push_over_push_add_cstore(0,second_word)
    adc   A, H          ; 1:4       0 over second_word add C! push_over_push_add_cstore(0,second_word)
    ld    B, A          ; 1:4       0 over second_word add C! push_over_push_add_cstore(0,second_word)
    xor   A             ; 1:4       0 over second_word add C! push_over_push_add_cstore(0,second_word)
    ld  (BC),A          ; 1:7       0 over second_word add C! push_over_push_add_cstore(0,second_word)
    
    
    inc  HL             ; 1:6       1+
    
    
    ld    A, L          ; 1:4       dup s_len C! dup push(s_len) cstore
    ld   (s_len), A     ; 3:13      dup s_len C! dup push(s_len) cstore
    
    
    push DE             ; 1:11      print     0x22, " is"
    ld   BC, size103    ; 3:10      print     Length of string103
    ld   DE, string103  ; 3:10      print     Address of string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
        
    ;# ( table 1 second_word_len )
    
    ;# 0 set first column
    ;# 1
    ;# 2
    ;# 3
    
begin102:               ;           begin 102
        
    ex  (SP),HL         ; 1:19      nrot_swap ( c b a -- a b c )
        
                        ;[1:7]      2dup c! _2dup_cstore   ( char addr -- char addr )
    ld  (HL),E          ; 1:7       2dup c! _2dup_cstore
        
    push DE             ; 1:11      f_len @ push(f_len) cfetch
    ex   DE, HL         ; 1:4       f_len @ push(f_len) cfetch
    ld   HL,(f_len)     ; 3:16      f_len @ push(f_len) cfetch
    ld    H, 0x00       ; 2:7       f_len @ push(f_len) cfetch
        
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
        
    inc  DE             ; 1:6       swap 1+ swap
        
    ex  (SP),HL         ; 1:19      nrot_swap ( c b a -- a b c )
        
    dec  HL             ; 1:6       1-
    
    ld    A, H          ; 1:4       dup invert until 102   ( flag -- flag )
    or    L             ; 1:4       dup invert until 102
    jp   nz, begin102   ; 3:10      dup invert until 102
break102:               ;           dup invert until 102
    
    pop  HL             ; 1:10      drop 2drop ( c b a -- )
    pop  HL             ; 1:10      drop 2drop
    pop  DE             ; 1:10      drop 2drop
    
    ;#SCALL(view_table)
    ;#CR
    
    ;# 0x8061 breakpoint
    
    ld   IX, table      ; 4:14      array_set   ( -- )
    
    push DE             ; 1:11      push(second_word)
    ex   DE, HL         ; 1:4       push(second_word)
    ld   HL, second_word; 3:10      push(second_word)    
;# ( P_second_word )
    
begin103:               ;           begin 103
;#        SCALL(view_table)
        
    push DE             ; 1:11      push(first_word)
    ex   DE, HL         ; 1:4       push(first_word)
    ld   HL, first_word ; 3:10      push(first_word)
;# ( P_second_word P_first_word )
        
begin104:               ;           begin 104
;# 0x8091
    ;# substitution 
        ;# LET r=d(j,i)-(n$(j)=m$(i)):REM substitution
            
                        ;[8:51]     over @C over @C over_cfetch_over_cfetch ( addr2 addr1 -- addr2 addr1 char2 char1 )
    push DE             ; 1:11      over @C over @C over_cfetch_over_cfetch
    push HL             ; 1:11      over @C over @C over_cfetch_over_cfetch
    ld    L, (HL)       ; 1:7       over @C over @C over_cfetch_over_cfetch
    ld    H, 0x00       ; 2:7       over @C over @C over_cfetch_over_cfetch
    ld    A, (DE)       ; 1:7       over @C over @C over_cfetch_over_cfetch
    ld    E, A          ; 1:4       over @C over @C over_cfetch_over_cfetch
    ld    D, H          ; 1:4       over @C over @C over_cfetch_over_cfetch
            ;# ( P_second_word  P_first_word first_char second_char )
            
                        ;[7:40]     C=   ( c1 c2 -- flag )
    ld    A, L          ; 1:4       C=
    xor   E             ; 1:4       C=   ignores higher bytes
    sub  0x01           ; 2:7       C=
    sbc  HL, HL         ; 2:15      C=
    pop  DE             ; 1:10      C=
            ;# ( P_second_word  P_first_word flag)
            
    ld    B, 0x00       ; 2:7       array_cfetch_add
    ld    C,(IX+(0))    ; 3:19      array_cfetch_add
    add  HL, BC         ; 1:11      array_cfetch_add    TOS += char_array[0]
            ;# ( P_second_word  P_first_word R=[index+0]+flag )
            
    ;# insertion 
        ;# IF r>d(j+1,i) THEN LET r=r-1:REM insertion
            
    push DE             ; 1:11      dup_array_cfetch    ( a -- a char_array[0] )
    push HL             ; 1:11      dup_array_cfetch
    ld    D, 0x00       ; 2:7       dup_array_cfetch
label_01  EQU $+2
    ld    E,(IX+(0))    ; 3:19      dup_array_cfetch
    ex   DE, HL         ; 1:4       dup_array_cfetch
            ;# ( P_second_word  P_first_word R R [index+max_first_word_len] )
            
    or    A             ; 1:4       (u) >
    sbc  HL, DE         ; 2:15      (u) >
    sbc  HL, HL         ; 2:15      (u) >
    pop  DE             ; 1:10      (u) > 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
            ;# ( P_second_word  P_first_word R+flag )
            
    inc  IX             ; 2:10      array_inc   ( -- )
            ;# index++
            
    ;# deletion 
        ;# LET d(j+1,i+1)=r+(r<=d(j,i+1)):REM deletion
            
    push DE             ; 1:11      dup_array_cfetch    ( a -- a char_array[0] )
    push HL             ; 1:11      dup_array_cfetch
    ld    D, 0x00       ; 2:7       dup_array_cfetch
    ld    E,(IX+(0))    ; 3:19      dup_array_cfetch
    ex   DE, HL         ; 1:4       dup_array_cfetch 
            ;# ( P_second_word  P_first_word R R [index] )
            
    scf                 ; 1:4       (u) <=
    ex   DE, HL         ; 1:4       (u) <=
    sbc  HL, DE         ; 2:15      (u) <=
    sbc  HL, HL         ; 2:15      (u) <=
    pop  DE             ; 1:10      (u) <= 
            ;# ( P_second_word  P_first_word R flag )
            
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -
            ;# ( P_second_word  P_first_word R-flag )
            
    ex   DE, HL         ; 1:4       array_cstore(0)   ( char -- )
label_02  EQU $+2
    ld  (IX+(0)), E     ; 3:19      array_cstore(0)   char_array[0] = char
    pop  DE             ; 1:10      array_cstore(0)
            ;# [index+max_first_word_len] = R
            
            
    inc  HL             ; 1:6       1+
            ;# ( P_first_word  P_second_word++ )
        
    ld    A,(HL)        ; 1:7       dup C@ invert until 104   ( addr -- addr )
    or    A             ; 1:4       dup C@ invert until 104
    jp   nz, begin104   ; 3:10      dup C@ invert until 104
break104:               ;           dup C@ invert until 104
        
        
    inc  IX             ; 2:10      array_inc   ( -- )

        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
        
    inc  HL             ; 1:6       1+
        ;# ( P_first_word++ )        
    
    ld    A,(HL)        ; 1:7       dup C@ invert until 103   ( addr -- addr )
    or    A             ; 1:4       dup C@ invert until 103
    jp   nz, begin103   ; 3:10      dup C@ invert until 103
break103:               ;           dup C@ invert until 103
    
    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    push DE             ; 1:11      array_cfetch    ( -- char_array[0] )
    ld    D, 0x00       ; 2:7       array_cfetch
label_03  EQU $+2
    ld    E,(IX+(0))    ; 3:19      array_cfetch
    ex   DE, HL         ; 1:4       array_cfetch
    
    dec  HL             ; 1:6       1-
    
    ;#SCALL(view_table)
    ;#CR

    
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      print     ".", 0x0D
    ld   BC, size104    ; 3:10      print     Length of string104
    ld   DE, string104  ; 3:10      print     Address of string104
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
    

;   ---  the beginning of a data stack function  ---
view_table:             ;           
    
    push DE             ; 1:11      s_len @ push(s_len) cfetch
    ex   DE, HL         ; 1:4       s_len @ push(s_len) cfetch
    ld   HL,(s_len)     ; 3:16      s_len @ push(s_len) cfetch
    ld    H, 0x00       ; 2:7       s_len @ push(s_len) cfetch
    
    push DE             ; 1:11      push(table)
    ex   DE, HL         ; 1:4       push(table)
    ld   HL, table      ; 3:10      push(table)
    
begin105:               ;           begin 105
        
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
        
    push DE             ; 1:11      f_len @ push(f_len) cfetch
    ex   DE, HL         ; 1:4       f_len @ push(f_len) cfetch
    ld   HL,(f_len)     ; 3:16      f_len @ push(f_len) cfetch
    ld    H, 0x00       ; 2:7       f_len @ push(f_len) cfetch
        
begin106:               ;           begin 106
            
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch
            
    call PRINT_S16      ; 3:17      .
            
    inc  DE             ; 1:6       swap 1+ swap 
            
    dec  HL             ; 1:6       1-
        
    ld    A, H          ; 1:4       dup invert until 106   ( flag -- flag )
    or    L             ; 1:4       dup invert until 106
    jp   nz, begin106   ; 3:10      dup invert until 106
break106:               ;           dup invert until 106
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
        
    dec  DE             ; 1:6       swap 1- swap 
    
    ld    A, D          ; 1:4       over invert until 105   ( flag x -- flag x )
    or    E             ; 1:4       over invert until 105
    jp   nz, begin105   ; 3:10      over invert until 105
break105:               ;           over invert until 105
    
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )

view_table_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
    
    

;   ---  the beginning of a data stack function  ---
clear_table:            ;           
    
    push DE             ; 1:11      s_len @ push(s_len) cfetch
    ex   DE, HL         ; 1:4       s_len @ push(s_len) cfetch
    ld   HL,(s_len)     ; 3:16      s_len @ push(s_len) cfetch
    ld    H, 0x00       ; 2:7       s_len @ push(s_len) cfetch
    
    push DE             ; 1:11      push(table)
    ex   DE, HL         ; 1:4       push(table)
    ld   HL, table      ; 3:10      push(table)
    
begin107:               ;           begin 107
        
    push DE             ; 1:11      f_len @ push(f_len) cfetch
    ex   DE, HL         ; 1:4       f_len @ push(f_len) cfetch
    ld   HL,(f_len)     ; 3:16      f_len @ push(f_len) cfetch
    ld    H, 0x00       ; 2:7       f_len @ push(f_len) cfetch
        
begin108:               ;           begin 108
            
    ex   DE, HL         ; 1:4       swap ( b a -- a b )
            
                        ;[2:10]     dup 0 swap c! dup_push_swap_cstore(0)   ( addr -- addr )
    ld  (HL),low 0      ; 2:10      dup 0 swap c! dup_push_swap_cstore(0)
            
    inc  HL             ; 1:6       1+
            
    ex   DE, HL         ; 1:4       swap ( b a -- a b )
            
    dec  HL             ; 1:6       1-
        
    ld    A, H          ; 1:4       dup invert until 108   ( flag -- flag )
    or    L             ; 1:4       dup invert until 108
    jp   nz, begin108   ; 3:10      dup invert until 108
break108:               ;           dup invert until 108
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
        
    dec  DE             ; 1:6       swap 1- swap 
    
    ld    A, D          ; 1:4       over invert until 107   ( flag x -- flag x )
    or    E             ; 1:4       over invert until 107
    jp   nz, begin107   ; 3:10      over invert until 107
break107:               ;           over invert until 107
    
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )

clear_table_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
    
    
    

;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_S16:              ;           print_s16
    ld    A, H          ; 1:4       print_s16
    add   A, A          ; 1:4       print_s16
    jr   nc, PRINT_U16  ; 2:7/12    print_s16
    xor   A             ; 1:4       print_s16   neg
    sub   L             ; 1:4       print_s16   neg
    ld    L, A          ; 1:4       print_s16   neg
    sbc   A, H          ; 1:4       print_s16   neg
    sub   L             ; 1:4       print_s16   neg
    ld    H, A          ; 1:4       print_s16   neg
    ld    A, ' '        ; 2:7       print_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_s16   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '-'        ; 2:7       print_s16   putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      print_s16   ld   BC, **
    ; fall to print_u16
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_U16:              ;           print_u16
    ld    A, ' '        ; 2:7       print_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_u16   putchar with ZX 48K ROM in, this will print char in A
    ; fall to print_u16_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_U16_ONLY:         ;           print_u16_only
    xor   A             ; 1:4       print_u16_only   A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10      print_u16_only
    call BIN16_DEC+2    ; 3:17      print_u16_only
    ld   BC, -1000      ; 3:10      print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld   BC, -100       ; 3:10      print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld    C, -10        ; 2:7       print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld    A, L          ; 1:4       print_u16_only
    pop  BC             ; 1:10      print_u16_only   load ret
    ex   DE, HL         ; 1:4       print_u16_only
    pop  DE             ; 1:10      print_u16_only
    push BC             ; 1:10      print_u16_only   save ret
    jr   BIN16_DEC_CHAR ; 2:12      print_u16_only
;------------------------------------------------------------------------------
; Input: A = 0..9 or '0'..'9' = 0x30..0x39 = 48..57, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
BIN16_DEC:              ;           bin16_dec
    and  0xF0           ; 2:7       bin16_dec   reset A to 0 or '0'
    add  HL, BC         ; 1:11      bin16_dec
    inc   A             ; 1:4       bin16_dec
    jr    c, $-2        ; 2:7/12    bin16_dec
    sbc  HL, BC         ; 2:15      bin16_dec
    dec   A             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
BIN16_DEC_CHAR:         ;           bin16_dec
    or   '0'            ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10      bin16_dec
;==============================================================================
; Read string from keyboard
; In: DE = addr, HL = length
; Out: 2x pop stack, TOP = HL = loaded
READSTRING:
    ld    B, D          ; 1:4       readstring
    ld    C, E          ; 1:4       readstring BC = addr
    ex   DE, HL         ; 1:4       readstring
READSTRING2:
    xor   A             ; 1:4       readstring
    ld    (0x5C08),A    ; 3:13      readstring ZX Spectrum LAST K system variable

    ld    A,(0x5C08)    ; 3:13      readstring read new value of LAST K
    or    A             ; 1:4       readstring is it still zero?
    jr    z, $-4        ; 2:7/12    readstring

    cp  0x0D            ; 2:7       readstring enter?
    jr    z, READSTRING3; 2:7/12    readstring
    ld  (HL),A          ; 1:7       readstring
    inc  HL             ; 1:6       readstring
    dec  DE             ; 1:6       readstring
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ld    A, D          ; 1:4       readstring
    or    E             ; 1:4       readstring
    jr   nz, READSTRING2; 2:7/12    readstring
READSTRING3:
    or    A             ; 1:4       readstring
    sbc  HL, BC         ; 2:15      readstring

    pop  BC             ; 1:10      readstring ret
    pop  DE             ; 1:10      readstring
    push BC             ; 1:11      readstring ret
    ret                 ; 1:10      readstring
VARIABLE_SECTION:

f_len: db 0x00
s_len: db 0x00

STRING_SECTION:
string104:
db ".", 0x0D
size104 EQU $ - string104
string103:
db 0x22, " is"
size103 EQU $ - string103
string102:
db 0x22, " and ", 0x22
size102 EQU $ - string102
string101:
db "The Levenshtein distance between ", 0x22
size101 EQU $ - string101

first_word:
db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
first_word_len EQU $-first_word
row_size EQU $-first_word
second_word:
db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
second_word_len EQU $-second_word
table:

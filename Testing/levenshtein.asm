;vvvv
;^^^^
ORG 0x8000

    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    
max_len              EQU 25
    
    
     
     
    
    
    
    push DE             ; 1:11      print     "The Levenshtein distance between ", 0x22
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(word_1,25)
    ld   DE, word_1     ; 3:10      push2(word_1,25)
    push HL             ; 1:11      push2(word_1,25)
    ld   HL, 25         ; 3:10      push2(word_1,25)
    
    call READSTRING     ; 3:17      accept_z
    
    ;# self-modifying code
    
    ld    A, L          ; 1:4       dup label_03 C! dup push(label_03) cstore
    ld   (label_03), A  ; 3:13      dup label_03 C! dup push(label_03) cstore
    
    inc  HL             ; 1:6       1+
    
    ld    A, L          ; 1:4       dup label_01 C! dup label_02 C! dup len_1 C!   dup push(label_01) cstore dup push(label_02) cstore dup push(len_1) cstore
    ld   (label_01), A  ; 3:13      dup label_01 C! dup label_02 C! dup len_1 C!   dup push(label_01) cstore dup push(label_02) cstore dup push(len_1) cstore
    ld   (label_02), A  ; 3:13      dup label_01 C! dup label_02 C! dup len_1 C!   dup push(label_01) cstore dup push(label_02) cstore dup push(len_1) cstore
    ld   (len_1), A     ; 3:13      dup label_01 C! dup label_02 C! dup len_1 C!   dup push(label_01) cstore dup push(label_02) cstore dup push(len_1) cstore    
    ;# ( word_1_len )
    
    ;# 0 1 2 3 4 5 ... set first row
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
    
    ; warning The condition >>>table<<< cannot be evaluated
    ld   BC, table      ; 3:10      table +
    add  HL, BC         ; 1:11      table +
    
    inc  DE             ; 1:6       swap 1+ swap
    ;#PUSH2(max_word_1_len+1,table+max_word_1_len+1)
    
begin101:               ;           begin 101
        
                        ;[1:7]      2dup c!  _2dup_cstore   ( char addr -- char addr )
    ld  (HL),E          ; 1:7       2dup c!  _2dup_cstore
        
    dec  HL             ; 1:6       1- 
        
    dec  DE             ; 1:6       swap 1- swap 
    
    ld    A, D          ; 1:4       over 0= until 101   ( x1 x2 -- x1 x2 )
    or    E             ; 1:4       over 0= until 101
    jp   nz, begin101   ; 3:10      over 0= until 101
break101:               ;           over 0= until 101

    
    inc  HL             ; 1:6       1+
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b )
    
    inc  HL             ; 1:6       1+
    
    
    push DE             ; 1:11      print     0x22, " and ", 0x22
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push2(word_2,25)
    ld   DE, word_2     ; 3:10      push2(word_2,25)
    push HL             ; 1:11      push2(word_2,25)
    ld   HL, 25         ; 3:10      push2(word_2,25)
    
    call READSTRING     ; 3:17      accept_z
    
    
    inc  HL             ; 1:6       1+
    
    ld    A, L          ; 1:4       dup len_2 C! dup push(len_2) cstore
    ld   (len_2), A     ; 3:13      dup len_2 C! dup push(len_2) cstore
    
    
    push DE             ; 1:11      print     0x22, " is "
    ld   BC, size103    ; 3:10      print     Length of string103
    ld   DE, string103  ; 3:10      print     Address of string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
        
    ;# ( table 1 word_2_len )
    
    ;# 0 set first column
    ;# 1
    ;# 2
    ;# 3
    
begin102:               ;           begin 102
        
    ex  (SP),HL         ; 1:19      nrot_swap ( c b a -- a b c )
        
                        ;[1:7]      2dup c!  _2dup_cstore   ( char addr -- char addr )
    ld  (HL),E          ; 1:7       2dup c!  _2dup_cstore
        
    ld    A,(len_1)     ; 3:13      len_1 @ +  push_cfetch_add(len_1)   ( x -- x+(len_1) )
    add   A, L          ; 1:4       len_1 @ +  push_cfetch_add(len_1)
    ld    L, A          ; 1:4       len_1 @ +  push_cfetch_add(len_1)
    adc   A, H          ; 1:4       len_1 @ +  push_cfetch_add(len_1)
    sub   L             ; 1:4       len_1 @ +  push_cfetch_add(len_1)
    ld    H, A          ; 1:4       len_1 @ +  push_cfetch_add(len_1)
        
    inc  DE             ; 1:6       swap 1+ swap
        
    ex  (SP),HL         ; 1:19      nrot_swap ( c b a -- a b c )
        
    dec  HL             ; 1:6       1-
    
    ld    A, H          ; 1:4       dup 0= until 102   ( x -- x )
    or    L             ; 1:4       dup 0= until 102
    jp   nz, begin102   ; 3:10      dup 0= until 102
break102:               ;           dup 0= until 102
    
    pop  HL             ; 1:10      drop 2drop ( c b a -- )
    pop  HL             ; 1:10      drop 2drop
    pop  DE             ; 1:10      drop 2drop
    
    ;#SCALL(view_table)
    ;#CR
    
    ;# 0x8061 breakpoint
    
    ld   IX, table      ; 4:14      array_set   ( -- )
    
    push DE             ; 1:11      push(word_2)
    ex   DE, HL         ; 1:4       push(word_2)
    ld   HL, word_2     ; 3:10      push(word_2)    
;# ( P_word_2 )
    
begin103:               ;           begin 103
;#        SCALL(view_table)
        
    push DE             ; 1:11      push(word_1)
    ex   DE, HL         ; 1:4       push(word_1)
    ld   HL, word_1     ; 3:10      push(word_1)
;# ( P_word_2 P_word_1 )
        
begin104:               ;           begin 104
;# 0x8091
    ;# substitution 
        ;# LET r=d(j,i)-(n$(j)=m$(i)):REM substitution
            
                        ;[8:51]     over @C over @C C= over_cfetch_over_cfetch_ceq ( addr2 addr1 -- addr2 addr1 flag(char2==char1) )
    push DE             ; 1:11      over @C over @C C= over_cfetch_over_cfetch_ceq
    ex   DE, HL         ; 1:4       over @C over @C C= over_cfetch_over_cfetch_ceq
    ld    A, (DE)       ; 1:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    xor (HL)            ; 1:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    sub  0x01           ; 2:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    sbc  HL, HL         ; 2:15      over @C over @C C= over_cfetch_over_cfetch_ceq
            ;# ( P_word_2  P_word_1 flag(char_1==char_2) )
            
    ld    B, 0x00       ; 2:7       array_cfetch_add
    ld    C,(IX+(0))    ; 3:19      array_cfetch_add
    add  HL, BC         ; 1:11      array_cfetch_add    TOS += char_array[0]
            ;# ( P_word_2  P_word_1 R=[index+0]+flag )
            
    ;# insertion 
        ;# IF r>d(j+1,i) THEN LET r=r-1:REM insertion
            
    push DE             ; 1:11      dup_array_cfetch_ugt    ( char1 -- char1 flag(char1 (U)> char_array[0]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_ugt
label_01  EQU $+2
    ld    A,(IX+(0))    ; 3:19      dup_array_cfetch_ugt
    sub   E             ; 1:4       dup_array_cfetch_ugt
    sbc  HL, HL         ; 2:15      dup_array_cfetch_ugt
            ;# ( P_word_2  P_word_1 R flag(R (U)> [index+max_word_1_len]) )
            
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
            ;# ( P_word_2  P_word_1 R+flag )
            
    inc  IX             ; 2:10      array_inc   ( -- )
            ;# index++
            
    ;# deletion 
        ;# LET d(j+1,i+1)=r+(r<=d(j,i+1)):REM deletion
            
    push DE             ; 1:11      dup_array_cfetch_ule    ( char1 -- char1 flag(char1 (U)<= char_array[0]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_ule
    scf                 ; 1:4       dup_array_cfetch_ule
    ld    A, E          ; 1:4       dup_array_cfetch_ule
    sbc   A,(IX+(0))    ; 3:19      dup_array_cfetch_ule
    sbc  HL, HL         ; 2:15      dup_array_cfetch_ule 
            ;# ( P_word_2  P_word_1 R flag(R (U)<= [index]) )
            
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -
            ;# ( P_word_2  P_word_1 R-flag )
            
    ex   DE, HL         ; 1:4       array_cstore(0)   ( char -- )
label_02  EQU $+2
    ld  (IX+(0)), E     ; 3:19      array_cstore(0)   char_array[0] = char
    pop  DE             ; 1:10      array_cstore(0)
            ;# [index+max_word_1_len] = R
            
            
    inc  HL             ; 1:6       1+
            ;# ( P_word_1  P_word_2++ )
        
    ld    A,(HL)        ; 1:7       dup C@ 0= until 104   ( addr -- addr )
    or    A             ; 1:4       dup C@ 0= until 104
    jp   nz, begin104   ; 3:10      dup C@ 0= until 104
break104:               ;           dup C@ 0= until 104
        
        
    inc  IX             ; 2:10      array_inc   ( -- )

        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
        
    inc  HL             ; 1:6       1+
        ;# ( P_word_1++ )        
    
    ld    A,(HL)        ; 1:7       dup C@ 0= until 103   ( addr -- addr )
    or    A             ; 1:4       dup C@ 0= until 103
    jp   nz, begin103   ; 3:10      dup C@ 0= until 103
break103:               ;           dup C@ 0= until 103
    
    
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

    
    call ZXPRT_U16      ; 3:17      u.zxrom   ( u -- )
    
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
    
    push DE             ; 1:11      len_2 @ table  push_cfetch_push(len_2,table)
    push HL             ; 1:11      len_2 @ table  push_cfetch_push(len_2,table)
    ld    A,(len_2)     ; 3:13      len_2 @ table  push_cfetch_push(len_2,table)
    ld    D, 0x00       ; 2:7       len_2 @ table  push_cfetch_push(len_2,table)
    ld    E, A          ; 1:4       len_2 @ table  push_cfetch_push(len_2,table)
    ld   HL, table      ; 3:10      len_2 @ table  push_cfetch_push(len_2,table)
    
begin105:               ;           begin 105
        
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
        
    push DE             ; 1:11      len_1 @  push_cfetch(len_1)
    ex   DE, HL         ; 1:4       len_1 @  push_cfetch(len_1)
    ld   HL,(len_1)     ; 3:16      len_1 @  push_cfetch(len_1)
    ld    H, 0x00       ; 2:7       len_1 @  push_cfetch(len_1)
        
begin106:               ;           begin 106
            
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch
            
    call ZXPRT_U16      ; 3:17      u.zxrom   ( u -- )
            
    inc  DE             ; 1:6       swap 1+ swap 
            
    dec  HL             ; 1:6       1-
        
    ld    A, H          ; 1:4       dup 0= until 106   ( x -- x )
    or    L             ; 1:4       dup 0= until 106
    jp   nz, begin106   ; 3:10      dup 0= until 106
break106:               ;           dup 0= until 106
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
        
    dec  DE             ; 1:6       swap 1- swap 
    
    ld    A, D          ; 1:4       over 0= until 105   ( x1 x2 -- x1 x2 )
    or    E             ; 1:4       over 0= until 105
    jp   nz, begin105   ; 3:10      over 0= until 105
break105:               ;           over 0= until 105
    
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )

view_table_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
    
    

;   ---  the beginning of a data stack function  ---
clear_table:            ;           
    
    push DE             ; 1:11      len_2 @ table  push_cfetch_push(len_2,table)
    push HL             ; 1:11      len_2 @ table  push_cfetch_push(len_2,table)
    ld    A,(len_2)     ; 3:13      len_2 @ table  push_cfetch_push(len_2,table)
    ld    D, 0x00       ; 2:7       len_2 @ table  push_cfetch_push(len_2,table)
    ld    E, A          ; 1:4       len_2 @ table  push_cfetch_push(len_2,table)
    ld   HL, table      ; 3:10      len_2 @ table  push_cfetch_push(len_2,table)
    
begin107:               ;           begin 107
        
    push DE             ; 1:11      len_1 @  push_cfetch(len_1)
    ex   DE, HL         ; 1:4       len_1 @  push_cfetch(len_1)
    ld   HL,(len_1)     ; 3:16      len_1 @  push_cfetch(len_1)
    ld    H, 0x00       ; 2:7       len_1 @  push_cfetch(len_1)
        
begin108:               ;           begin 108
            
                        ;[2:11]     over 0 swap c!  over_push_swap_cstore(0)   ( addr x -- addr x )
    xor   A             ; 1:4       over 0 swap c!  over_push_swap_cstore(0)
    ld  (DE),A          ; 1:7       over 0 swap c!  over_push_swap_cstore(0)
            
    inc  DE             ; 1:6       swap 1+ swap
            
    dec  HL             ; 1:6       1-
        
    ld    A, H          ; 1:4       dup 0= until 108   ( x -- x )
    or    L             ; 1:4       dup 0= until 108
    jp   nz, begin108   ; 3:10      dup 0= until 108
break108:               ;           dup 0= until 108
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
        
    dec  DE             ; 1:6       swap 1- swap 
    
    ld    A, D          ; 1:4       over 0= until 107   ( x1 x2 -- x1 x2 )
    or    E             ; 1:4       over 0= until 107
    jp   nz, begin107   ; 3:10      over 0= until 107
break107:               ;           over 0= until 107
    
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )

clear_table_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------

;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
ZXPRT_U16:              ;           zxprt_u16   ( u -- )
    push DE             ; 1:11      zxprt_u16
    ld    B, H          ; 1:4       zxprt_u16
    ld    C, L          ; 1:4       zxprt_u16
    call 0x2D2B         ; 3:17      zxprt_u16   call ZX ROM stack BC routine
    call 0x2DE3         ; 3:17      zxprt_u16   call ZX ROM print a floating-point number routine

    pop  HL             ; 1:10      zxprt_u16
    pop  BC             ; 1:10      zxprt_u16   load ret
    pop  DE             ; 1:10      zxprt_u16
    push BC             ; 1:11      zxprt_u16   save ret
    ret                 ; 1:10      zxprt_u16
;==============================================================================
; Read string from keyboard
; In: DE = addr_string, HL = max_length
; Out: pop stack, TOP = HL = loaded
READSTRING:
    dec  HL             ; 1:6       readstring_z
    ld   BC, 0x0000     ; 3:10      readstring   loaded
    call CLEARBUFF      ; 3:17      readstring
READSTRING2:
    ld    A,(0x5C08)    ; 3:13      readstring   read new value of LAST K
    or    A             ; 1:4       readstring   is it still zero?
    jr    z, READSTRING2; 2:7/12    readstring

    call CLEARBUFF      ; 3:17      readstring
    ld  (DE),A          ; 1:7       readstring   save char

    cp  0x0C            ; 2:7       readstring   delete?
    jr   nz, READSTRING3; 2:7/12    readstring
    ld    A, B          ; 1:4       readstring
    or    C             ; 1:4       readstring
    jr    z, READSTRING2; 2:7/12    readstring   empty string?
    dec  DE             ; 1:6       readstring   addr--
    dec  BC             ; 1:6       readstring   loaded--
    inc  HL             ; 1:6       readstring   space++
    ld    A, 0x08       ; 2:7       readstring
    rst   0x10          ; 1:11      readstring   putchar(reg A) with ZX 48K ROM
    ld    A, 0x20       ; 2:7       readstring
    rst   0x10          ; 1:11      readstring   putchar(reg A) with ZX 48K ROM
    ld    A, 0x08       ; 2:7       readstring
    rst   0x10          ; 1:11      readstring   putchar(reg A) with ZX 48K ROM
    jr   READSTRING2    ; 2:12      readstring
READSTRING3:

    cp  0x0D            ; 2:7       readstring   enter?
    jr    z, READSTRING4; 2:7/12    readstring

    rst   0x10          ; 1:11      readstring   putchar(reg A) with ZX 48K ROM
    inc  DE             ; 1:6       readstring   addr++
    inc  BC             ; 1:6       readstring   loaded++
    dec  HL             ; 1:6       readstring   space--
    ld    A, H          ; 1:4       readstring
    or    L             ; 1:4       readstring
    jr   nz, READSTRING2; 2:7/12    readstring

READSTRING4:            ;           readstring   A = 0, flag: z, nc
    xor   A             ; 1:7       readstring_z
    ld  (DE),A          ; 1:7       readstring_z  set zero char
    pop  HL             ; 1:10      readstring   ret
    pop  DE             ; 1:10      readstring
    push HL             ; 1:11      readstring   ret
    ld    H, B          ; 1:4       readstring
    ld    L, C          ; 1:4       readstring
    ret                 ; 1:10      readstring
;==============================================================================
; Clear key buffer
; In:
; Out: (LAST_K) = 0
CLEARBUFF:
    push HL             ; 1:11      clearbuff
    ld   HL, 0x5C08     ; 3:10      clearbuff   ZX Spectrum LAST K system variable
    ld  (HL),0x00       ; 2:10      clearbuff
    pop  HL             ; 1:10      clearbuff
    ret                 ; 1:10      clearbuff
STRING_SECTION:
string104:
db ".", 0x0D
size104 EQU $ - string104
string103:
db 0x22, " is "
size103 EQU $ - string103
string102:
db 0x22, " and ", 0x22
size102 EQU $ - string102
string101:
db "The Levenshtein distance between ", 0x22
size101 EQU $ - string101

VARIABLE_SECTION:

len_1: db 0x00
len_2: db 0x00
word_1:
DS 25
word_2:
DS 25
table:

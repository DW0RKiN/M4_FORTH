;vvvv
;^^^^
    ORG 0x8000
ZX_AT           equ 0x16     ; zx_constant   Y,X


    

    
    
    
    
    
word_1               EQU __create_word_1 
    
word_2               EQU __create_word_2 
    
table                EQU __create_table
    
    
    
    
    
    ;# self-modifying code
      
    
                
    ;# ( word_1_len )
    
    ;# 0 1 2 3 4 5 ... set first row
    
     
      
    ;#PUSH2(max_word_1_len+1,table+max_word_1_len+1)
    
         
         
           
      

    
    
    
    
    
    
    
    
    
    
    
    
        
    ;# ( table 1 word_2_len )
    
    ;# 0 set first column
    ;# 1
    ;# 2
    ;# 3
    
         
         
          
          
         
        
      
     
    
    ;#SCALL(view_table)
    ;#CR
    
    ;# 0x8061 breakpoint
    
        
;# ( P_word_2 )
    
;#        SCALL(view_table)
        
;# ( P_word_2 P_word_1 )
        
;# 0x8091
    ;# substitution 
        ;# LET r=d(j,i)-(n$(j)=m$(i)):REM substitution
            
            ;# ( P_word_2  P_word_1 flag(char_1==char_2) )
            
            ;# ( P_word_2  P_word_1 R=[index+0]+flag )
            
    ;# insertion 
        ;# IF r>d(j+1,i) THEN LET r=r-1:REM insertion
            
            ;# ( P_word_2  P_word_1 R flag(R (U)> [index+max_word_1_len]) )
            
            ;# ( P_word_2  P_word_1 R+flag )
            
            ;# index++
            
    ;# deletion 
        ;# LET d(j+1,i+1)=r+(r<=d(j,i+1)):REM deletion
             
            ;# ( P_word_2  P_word_1 R flag(R (U)<= [index]) )
            
            ;# ( P_word_2  P_word_1 R-flag )
            
            ;# [index+max_word_1_len] = R
            
            
            ;# ( P_word_1  P_word_2++ )
           
        
        

        
        
        ;# ( P_word_1++ )        
    
    
    
    
    
    
    ;#SCALL(view_table)
    ;#CR

    
    
    
    
    

    
    
        
         
        
             
            
               
            
          
        
           
      
    

    
    

    
    
         
        
               
              
            
          
        
           
      
    


;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
  if 0
    ld   HL, 0x0000     ; 3:10      init
    ld (self_cursor),HL ; 3:16      init
  else
    ld   HL, 0x1821     ; 3:10      init
    ld   DE,(0x5C88)    ; 4:20      init
    or    A             ; 1:4       init
    sbc  HL, DE         ; 2:15      init
    ld    A, L          ; 1:4       init   x
    add   A, A          ; 1:4       init   2*x
    inc   A             ; 1:4       init   2*2+1
    add   A, A          ; 1:4       init   4*x+2
    add   A, A          ; 1:4       init   8*x+4
     ld   L, 0xFF       ; 2:7       init
    inc   L             ; 1:4       init
    sub 0x05            ; 2:7       init
    jr   nc, $-3        ; 2:7/12    init
    ld (self_cursor),HL ; 3:16      init
  endif
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
max_len              EQU 25
    ld   BC, string101  ; 3:10      print_i   Address of string101 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[8:42]     word_1 25   ( -- word_1 25 )
    push DE             ; 1:11      word_1 25
    push HL             ; 1:11      word_1 25
    ld   DE, word_1     ; 3:10      word_1 25
    ld   HL, 0x0019     ; 3:10      word_1 25
    call READSTRING     ; 3:17      accept_z
    ld    A, L          ; 1:4       dup label_03 c!   ( x -- x )
    ld   (label_03), A  ; 3:13      dup label_03 c!
    inc  HL             ; 1:6       1+
    ld    A, L          ; 1:4       dup label_01 c! dup label_02 c! dup len_1 c!   ( x -- x )   A = lo8(x)
    ld   (label_01), A  ; 3:13      dup label_01 c! dup label_02 c! dup len_1 c!
    ld   (label_02), A  ; 3:13      dup label_01 c! dup label_02 c! dup len_1 c!
    ld   (len_1), A     ; 3:13      dup label_01 c! dup label_02 c! dup len_1 c!
    ; warning The condition >>>table<<< cannot be evaluated
    push DE             ; 1:11      dup table +   ( x -- x x+table )
    ex   DE, HL         ; 1:4       dup table +
    ld   HL, table      ; 3:10      dup table +
    add  HL, DE         ; 1:11      dup table +
    inc  DE             ; 1:6       swap 1+ swap
begin101:               ;           begin 101
                        ;[1:7]      2dup c!   ( char addr -- char addr )  (addr)=lo8(x)
    ld  (HL),E          ; 1:7       2dup c!
    dec  HL             ; 1:6       1-   ( x -- x-1 )
    dec  DE             ; 1:6       swap 1- swap
    ld    A, D          ; 1:4       over 0= until 101   ( x2 x1 -- x2 x1 )
    or    E             ; 1:4       over 0= until 101
    jp   nz, begin101   ; 3:10      over 0= until 101
break101:               ;           over 0= until 101
    inc  HL             ; 1:6       1+
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    inc  HL             ; 1:6       1+
    ld   BC, string102  ; 3:10      print_i   Address of string102 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[8:42]     word_2 25   ( -- word_2 25 )
    push DE             ; 1:11      word_2 25
    push HL             ; 1:11      word_2 25
    ld   DE, word_2     ; 3:10      word_2 25
    ld   HL, 0x0019     ; 3:10      word_2 25
    call READSTRING     ; 3:17      accept_z
    inc  HL             ; 1:6       1+
    ld    A, L          ; 1:4       dup len_2 c!   ( x -- x )
    ld   (len_2), A     ; 3:13      dup len_2 c!
    ld   BC, string103  ; 3:10      print_i   Address of string103 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
begin102:               ;           begin 102
    ex  (SP),HL         ; 1:19      nrot swap   ( c b a -- a b c )
                        ;[1:7]      2dup c!   ( char addr -- char addr )  (addr)=lo8(x)
    ld  (HL),E          ; 1:7       2dup c!
                        ;[7:35]     len_1 c@ +  ( x -- x+(len_1) )  # default version can be changed with "define({_TYP_SINGLE},{fast})"
    ld    A,(len_1)     ; 3:13      len_1 c@ +
    ld    C, A          ; 1:4       len_1 c@ +
    ld    B, 0x00       ; 2:7       len_1 c@ +
    add  HL, BC         ; 1:11      len_1 c@ +
    inc  DE             ; 1:6       swap 1+ swap
    ex  (SP),HL         ; 1:19      nrot swap   ( c b a -- a b c )
    dec  HL             ; 1:6       1-   ( x -- x-1 )
    ld    A, H          ; 1:4       dup 0= until 102   ( x -- x )
    or    L             ; 1:4       dup 0= until 102
    jp   nz, begin102   ; 3:10      dup 0= until 102
break102:               ;           dup 0= until 102
    pop  HL             ; 1:10      drop 2drop   ( c b a -- )
    pop  HL             ; 1:10      drop 2drop
    pop  DE             ; 1:10      drop 2drop
    ld   IX, table      ; 4:14      array_set   ( -- )
    push DE             ; 1:11      word_2
    ex   DE, HL         ; 1:4       word_2
    ld   HL, word_2     ; 3:10      word_2
begin103:               ;           begin 103
    push DE             ; 1:11      word_1
    ex   DE, HL         ; 1:4       word_1
    ld   HL, word_1     ; 3:10      word_1
begin104:               ;           begin 104
                        ;[8:51]     over @C over @C C= over_cfetch_over_cfetch_ceq ( addr2 addr1 -- addr2 addr1 flag(char2==char1) )
    push DE             ; 1:11      over @C over @C C= over_cfetch_over_cfetch_ceq
    ex   DE, HL         ; 1:4       over @C over @C C= over_cfetch_over_cfetch_ceq
    ld    A, (DE)       ; 1:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    xor (HL)            ; 1:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    sub  0x01           ; 2:7       over @C over @C C= over_cfetch_over_cfetch_ceq
    sbc  HL, HL         ; 2:15      over @C over @C C= over_cfetch_over_cfetch_ceq
    ld    B, 0x00       ; 2:7       array_cfetch_add
    ld    C,(IX+(0))    ; 3:19      array_cfetch_add
    add  HL, BC         ; 1:11      array_cfetch_add    TOS += char_array[0]
    push DE             ; 1:11      dup_array_cfetch_ugt    ( char1 -- char1 flag(char1 (U)> char_array[0]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_ugt
label_01  EQU $+2
    ld    A,(IX+(0))    ; 3:19      dup_array_cfetch_ugt
    sub   E             ; 1:4       dup_array_cfetch_ugt
    sbc  HL, HL         ; 2:15      dup_array_cfetch_ugt
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    inc  IX             ; 2:10      array_inc   ( -- )
    push DE             ; 1:11      dup_array_cfetch_ule    ( char1 -- char1 flag(char1 (U)<= char_array[0]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_ule
    scf                 ; 1:4       dup_array_cfetch_ule
    ld    A, E          ; 1:4       dup_array_cfetch_ule
    sbc   A,(IX+(0))    ; 3:19      dup_array_cfetch_ule
    sbc  HL, HL         ; 2:15      dup_array_cfetch_ule
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -
    ex   DE, HL         ; 1:4       array_cstore(0)   ( char -- )
label_02  EQU $+2
    ld  (IX+(0)), E     ; 3:19      array_cstore(0)   char_array[0] = char
    pop  DE             ; 1:10      array_cstore(0)
    inc  HL             ; 1:6       1+
    ld    A,(HL)        ; 1:7       dup C@ 0= until 104   ( addr -- addr )
    or    A             ; 1:4       dup C@ 0= until 104
    jp   nz, begin104   ; 3:10      dup C@ 0= until 104
break104:               ;           dup C@ 0= until 104
    inc  IX             ; 2:10      array_inc   ( -- )
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    ld    A,(HL)        ; 1:7       dup C@ 0= until 103   ( addr -- addr )
    or    A             ; 1:4       dup C@ 0= until 103
    jp   nz, begin103   ; 3:10      dup C@ 0= until 103
break103:               ;           dup C@ 0= until 103
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    push DE             ; 1:11      array_cfetch    ( -- char_array[0] )
    ld    D, 0x00       ; 2:7       array_cfetch
label_03  EQU $+2
    ld    E,(IX+(0))    ; 3:19      array_cfetch
    ex   DE, HL         ; 1:4       array_cfetch
    dec  HL             ; 1:6       1-   ( x -- x-1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
  if 0
    ld    A, 0x16       ; 2:7       stop   at y x
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
    ld A,(self_cursor+1); 3:13      stop
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
    xor   A             ; 1:4       stop
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
  else
    ld   HL,(self_cursor); 3:16
    ld    A, 0x16       ; 2:7       stop   at y x
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
    ld    A, H          ; 1:4       stop
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
    ld    A, L          ; 1:4       stop
    add   A, A          ; 1:4       stop   2x
    add   A, A          ; 1:4       stop   4x
    add   A, L          ; 1:4       stop   5x
    add   A, 0x07       ; 1:4       stop
    rrca                ; 1:4       stop
    rrca                ; 1:4       stop
    rrca                ; 1:4       stop
    and   0x1F          ; 2:7       stop
    rst   0x10          ; 1:11      stop   putchar(reg A) with ZX 48K ROM
  endif
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a data stack function  ---
view_table:             ;           
    push DE             ; 1:11      len_2 c@ table
    push HL             ; 1:11      len_2 c@ table
    ld    A,(len_2)     ; 3:13      len_2 c@ table
    ld    D, 0x00       ; 2:7       len_2 c@ table
    ld    E, A          ; 1:4       len_2 c@ table
    ld   HL, table      ; 3:10      len_2 c@ table
begin105:               ;           begin 105
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    call  draw_char     ; 3:17      cr
    push DE             ; 1:11      len_1 c@
    ex   DE, HL         ; 1:4       len_1 c@
    ld   HL,(len_1)     ; 3:16      len_1 c@
    ld    H, 0x00       ; 2:7       len_1 c@
begin106:               ;           begin 106
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    ld    L,(HL)        ; 1:7       c@   ( addr -- char )
    ld    H, 0x00       ; 2:7       c@
    call ZXPRT_U16      ; 3:17      u.zxrom   ( u -- )
    inc  DE             ; 1:6       swap 1+ swap
    dec  HL             ; 1:6       1-   ( x -- x-1 )
    ld    A, H          ; 1:4       dup 0= until 106   ( x -- x )
    or    L             ; 1:4       dup 0= until 106
    jp   nz, begin106   ; 3:10      dup 0= until 106
break106:               ;           dup 0= until 106
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    dec  DE             ; 1:6       swap 1- swap
    ld    A, D          ; 1:4       over 0= until 105   ( x2 x1 -- x2 x1 )
    or    E             ; 1:4       over 0= until 105
    jp   nz, begin105   ; 3:10      over 0= until 105
break105:               ;           over 0= until 105
    pop  HL             ; 1:10      2drop   ( b a -- )
    pop  DE             ; 1:10      2drop
view_table_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
clear_table:            ;           
    push DE             ; 1:11      len_2 c@ table
    push HL             ; 1:11      len_2 c@ table
    ld    A,(len_2)     ; 3:13      len_2 c@ table
    ld    D, 0x00       ; 2:7       len_2 c@ table
    ld    E, A          ; 1:4       len_2 c@ table
    ld   HL, table      ; 3:10      len_2 c@ table
begin107:               ;           begin 107
    push DE             ; 1:11      len_1 c@
    ex   DE, HL         ; 1:4       len_1 c@
    ld   HL,(len_1)     ; 3:16      len_1 c@
    ld    H, 0x00       ; 2:7       len_1 c@
begin108:               ;           begin 108
                        ;[2:11]     over 0 swap c!   ( addr x1 -- addr x1 )  store 0 to addr
    xor   A             ; 1:4       over 0 swap c!   lo
    ld  (DE),A          ; 1:7       over 0 swap c!
    inc  DE             ; 1:6       swap 1+ swap
    dec  HL             ; 1:6       1-   ( x -- x-1 )
    ld    A, H          ; 1:4       dup 0= until 108   ( x -- x )
    or    L             ; 1:4       dup 0= until 108
    jp   nz, begin108   ; 3:10      dup 0= until 108
break108:               ;           dup 0= until 108
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    dec  DE             ; 1:6       swap 1- swap
    ld    A, D          ; 1:4       over 0= until 107   ( x2 x1 -- x2 x1 )
    or    E             ; 1:4       over 0= until 107
    jp   nz, begin107   ; 3:10      over 0= until 107
break107:               ;           over 0= until 107
    pop  HL             ; 1:10      2drop   ( b a -- )
    pop  DE             ; 1:10      2drop
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
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_U16:                ;           prt_u16
    xor   A             ; 1:4       prt_u16   HL=103 & A=0 => 103, HL = 103 & A='0' => 00103
    ld   BC, -10000     ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld   BC, -1000      ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld   BC, -100       ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld    C, -10        ; 2:7       prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld    A, L          ; 1:4       prt_u16
    pop  HL             ; 1:10      prt_u16   load ret
    ex  (SP),HL         ; 1:19      prt_u16
    ex   DE, HL         ; 1:4       prt_u16
    jr   BIN16_DEC_CHAR ; 2:12      prt_u16
;------------------------------------------------------------------------------
; Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
    inc   A             ; 1:4       bin16_dec
BIN16_DEC:              ;           bin16_dec
    add  HL, BC         ; 1:11      bin16_dec
    jr    c, $-2        ; 2:7/12    bin16_dec
    sbc  HL, BC         ; 2:15      bin16_dec
    or    A             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
BIN16_DEC_CHAR:         ;           bin16_dec
    or   '0'            ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    call  draw_char     ; 3:17      bin16_dec  
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
;==============================================================================
; Read string from keyboard
;  In: DE = addr_string, HL = max_length
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
    call  draw_char     ; 3:17      readstring   
    ld    A, 0x20       ; 2:7       readstring
    call  draw_char     ; 3:17      readstring   
    ld    A, 0x08       ; 2:7       readstring
    call  draw_char     ; 3:17      readstring   
    jr   READSTRING2    ; 2:12      readstring
READSTRING3:
    cp  0x0D            ; 2:7       readstring   enter?
    jr    z, READSTRING4; 2:7/12    readstring
    call  draw_char     ; 3:17      readstring   
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
;------------------------------------------------------------------------------
; Print string ending with inverted most significant bit
; In: BC = addr string_imsb
; Out: BC = addr last_char + 1
    call  draw_char     ; 3:17      print_string_i
PRINT_STRING_I:         ;           print_string_i
    ld    A,(BC)        ; 1:7       print_string_i
    inc  BC             ; 1:6       print_string_i
    or    A             ; 1:4       print_string_i
    jp    p, $-6        ; 3:10      print_string_i
    and  0x7f           ; 2:7       print_string_i
    call  draw_char     ; 3:17      print_string_i
    ret                 ; 1:10      print_string_i
;==============================================================================
; Print text with 5x8 font
; entry point is draw_char

MAX_X           equ 51       ; x = 0..50
MAX_Y           equ 24       ; y = 0..23

set_ink:
    exx                     ; 1:4
    ld   BC,(self_attr)     ; 4:20    load origin attr

    xor   C                 ; 1:4
    and 0x07                ; 2:7  
    xor   C                 ; 1:4

    jr   clean_spec_exx     ; 2:12
    
set_paper:
    exx                     ; 1:4
    ld   BC,(self_attr)     ; 4:20    load origin attr

    add   A, A              ; 1:4     2x
    add   A, A              ; 1:4     4x
    add   A, A              ; 1:4     8x
    xor   C                 ; 1:4
    and 0x38                ; 2:7
    xor   C                 ; 1:4

    jr   clean_spec_exx     ; 2:12
    
set_flash:

    rra                     ; 1:4     carry = flash
    ld    A,(self_attr)     ; 3:13    load origin attr
    adc   A, A              ; 1:4
    rrca                    ; 1:4

    jr   clean_spec_save_A  ; 2:12
    
set_bright:

    exx                     ; 1:4
    ld   BC,(self_attr)     ; 4:20    load origin attr
    
    rrca                    ; 1:4
    rrca                    ; 1:4
    xor   C                 ; 1:4
    and 0x40                ; 2:7
    xor   C                 ; 1:4    
    
    jr   clean_spec_exx     ; 2:12
    
set_inverse:
    
    exx                     ; 1:4
    ld   BC,(self_attr)     ; 4:20

    ld    A, C              ; 1:4     inverse
    and  0x38               ; 2:7     A = 00pp p000
    add   A, A              ; 1:4
    add   A, A              ; 1:4     A = ppp0 0000
    xor   C                 ; 1:4
    and  0xF8               ; 2:7
    xor   C                 ; 1:4     A = ppp0 0iii
    rlca                    ; 1:4
    rlca                    ; 1:4
    rlca                    ; 1:4     A = 00ii ippp
    xor   C                 ; 1:4
    and  0x3F               ; 2:7
    xor   C                 ; 1:4     A = fbii ippp

clean_spec_exx:
    exx                     ; 1:4
clean_spec_save_A:
    ld  (self_attr),A       ; 3:13    save new attr
clean_spec:
    xor   A                 ; 1:4
clean_set_A:
    ld  (jump_from-1),A     ; 3:13

    ret                     ; 1:10
    

set_over:    
    
    jr   clean_spec         ; 2:12

set_at:

    ld  (self_cursor+1), A  ; 3:13    save new Y
    ld    A, $+4-jump_from  ; 2:7
    jr   clean_set_A        ; 2:12


; set_at_y:    
    
    ld  (self_cursor), A    ; 3:13    save new X
    jr   clean_spec         ; 2:12


    jr   set_ink            ; 2:12
    jr   set_paper          ; 2:12
    jr   set_flash          ; 2:12
    jr   set_bright         ; 2:12
    jr   set_inverse        ; 2:12
    jr   set_over           ; 2:12
    jr   set_at             ; 2:12
;    jr   set_tab            ; 2:12

set_tab:

    exx                     ; 1:4
    ld   BC,(self_cursor)   ; 4:20    load origin cursor

    sub  MAX_X              ; 2:7
    jr   nc,$-2             ; 2:7/12
    add   A, MAX_X          ; 2:7     (new x) mod MAX_X
    cp    C                 ; 1:4
    ld    C, A              ; 1:4
    jr   nc, $+3            ; 2:7/12  new x >= (old x+1)
    inc   B                 ; 1:4
    
    ld  (self_cursor),BC    ; 4:20    save new cursor
    exx                     ; 1:4

    jr   clean_spec         ; 2:12


;------------------------------------------------------------------------------
;  Input: A = char
; Output: DE = next char
; Poluttes: AF, AF', DE', BC'
draw_char:
    jr   jump_from          ; 2:7/12    self-modifying
jump_from:

    cp  0x20                ; 2:7
    jr   nc, print_char     ; 2:7/12

    sub  0x08               ; 2:7       left
    ret   c                 ; 1:10
    jr   nz, check_eol      ; 2:7/12

    push HL                 ; 1:11
    ld   HL,(self_cursor)   ; 3:16
    ld    A, L              ; 1:4
    dec  HL                 ; 1:6
    or    A                 ; 1:4
    jp   nz, next_exit      ; 3:10
    ld    L, MAX_X-1        ; 2:7
    jp   next_exit          ; 3:10

check_eol:
    sub  0x05               ; 2:7       eol
    ret   c                 ; 1:10
    jr   nz, draw_spec      ; 2:7/12

    push HL                 ; 1:11
    ld   HL,(self_cursor)   ; 3:16
    jp   next_line          ; 3:10

draw_spec:

    sub  0x03               ; 2:7       ZX_INK-ZX_EOL
    ret   c                 ; 1:5/11    0x00..0x0F
    add   A, 0xF9           ; 2:7       ZX_INK-ZX_TAB
    ret   c                 ; 1:5/11    0x18..0x1F
    
    add   A,A               ; 1:4       2x
    sub   jump_from-set_tab ; 2:7
    ld  (jump_from-1),A     ; 3:13
    ret                     ; 1:10
    
print_char:
    push HL                 ; 1:11    uschovat HL na zásobník
    push DE                 ; 1:11    uschovat DE na zásobník
    push BC                 ; 1:11    uschovat BC na zásobník    
    
    exx                     ; 1:4
    push HL                 ; 1:11    uschovat HL na zásobník

    ld    BC, FONT_ADR      ; 3:10    adresa, od níž začínají masky znaků

    add   A, A              ; 1:4
    ld    L, A              ; 1:4     2x
    ld    H, 0x00           ; 1:4     C je nenulové
    add  HL, HL             ; 1:11    4x
    add  HL, BC             ; 1:11    přičíst bázovou adresu masek znaků    
    exx                     ; 1:4

;# YX -> ATTR

self_cursor     equ     $+1
    ld   DE, 0x0000         ; 3:10
    ld    A, E              ; 1:4     X
    add   A, A              ; 1:4     2*X
    add   A, A              ; 1:4     4*X
    add   A, E              ; 1:4     5*X
    ld    B, A              ; 1:4     save 5*X
    
    xor   D                 ; 1:4
    and 0xF8                ; 2:7
    xor   D                 ; 1:4
    rrca                    ; 1:4
    rrca                    ; 1:4
    rrca                    ; 1:4
    ld    L, A              ; 1:4

    ld    A, D              ; 1:4   
    or  0xC7                ; 2:7     110y y111, reset carry
    rra                     ; 1:4     0110 yy11, set carry
    rrca                    ; 1:4     1011 0yy1, set carry
    ccf                     ; 1:4     reset carry
    rra                     ; 1:4     0101 10yy
    ld    H, A              ; 1:4

self_attr       equ $+1
    ld  (HL),0x38           ; 2:10    uložení atributu znaku

    ld    A, D              ; 1:4
    and 0x18                ; 2:7
    or  0x40                ; 2:7
    ld    H, A              ; 1:4
    
    ld    A, B              ; 1:4     load 5*X
    and 0x07                ; 2:7
    cpl                     ; 1:4
    add   A, 0x09           ; 2:7         
    ld    B, A              ; 2:7     pocitadlo pro pocatecni posun vlevo masky znaku
    exx                     ; 1:4
    ld    C, A              ; 1:4
    exx                     ; 1:4
    ex   DE, HL             ; 1:4
    ld   HL, 0x00F0         ; 3:10
    add  HL, HL             ; 1:11    pocatecni posun masky
    djnz  $-1               ; 2:8/13        
    ex   DE, HL             ; 1:4

    ld    C, 4              ; 2:7        
loop_c:
    exx                     ; 1:4
    ld    A,(HL)            ; 1:7
    inc  HL                 ; 1:6
    ld    B, C              ; 1:4
    rlca                    ; 1:4
    djnz  $-1               ; 2:8/13
    ld    B, A              ; 1:4
    exx                     ; 1:4
    ld    B, 2              ; 2:7        
loop_b:
    xor (HL)                ; 1:7
    and   D                 ; 1:4
    xor (HL)                ; 1:7
    ld  (HL),A              ; 1:4     ulozeni jednoho bajtu z masky

    exx                     ; 1:4
    ld    A, B              ; 1:4     načtení druhe poloviny "bajtu" z masky
    exx                     ; 1:4

    inc   L                 ; 1:4
    xor (HL)                ; 1:7
    and   E                 ; 1:4
    xor (HL)                ; 1:7
    ld  (HL),A              ; 1:4     ulozeni jednoho bajtu z masky
    dec   L                 ; 1:4
    inc   H                 ; 1:4

    exx                     ; 1:4
    ld    A, B              ; 1:4     načtení jednoho bajtu z masky
    rlca                    ; 1:4
    rlca                    ; 1:4
    rlca                    ; 1:4
    rlca                    ; 1:4
    ld    B, A              ; 1:4
    exx                     ; 1:4

;     halt
    
    djnz loop_b             ; 2:8/13
    
    dec   C                 ; 2:7        
    jr   nz, loop_c         ; 2/7/12
    
    exx                     ; 1:4
    pop  HL                 ; 1:10    obnovit obsah HL ze zásobníku
    exx                     ; 1:4

    pop  BC                 ; 1:10    obnovit obsah BC ze zásobníku
    pop  DE                 ; 1:10    obnovit obsah DE ze zásobníku    
;   fall to next cursor    


    ld   HL,(self_cursor)   ; 3:16
; Input: HL = YX
; Output: HL = cursor = next cursor
next_cursor:
    inc   L                 ; 1:4     0..50 +1 = 00..51
    ld    A, -MAX_X         ; 2:7
    add   A, L              ; 1:4
    jr   nz, next_exit      ; 2:7/12
; Input: HL = YX
; Output: H = Y+1, X=0
next_line:
    ld    L, 0x00           ; 2:7     X=0
    inc   H                 ; 1:4
    ld    A, -MAX_Y         ; 2:7
    add   A, H              ; 1:4
    jr   nz, $+3            ; 2:7/12
    ld    H, A              ; 1:4     Y=0
next_exit:
    ld  (self_cursor),HL    ; 3:16
    pop  HL                 ; 1:10    obnovit obsah HL ze zásobníku
    ret                     ; 1:10

FONT_ADR    equ     FONT_5x8-32*4
FONT_5x8:
    db %00000000,%00000000,%00000000,%00000000 ; 0x20 space
    db %00000010,%00100010,%00100000,%00100000 ; 0x21 !
    db %00000101,%01010000,%00000000,%00000000 ; 0x22 "
    db %00000000,%01011111,%01011111,%01010000 ; 0x23 #
    db %00000010,%01110110,%00110111,%00100000 ; 0x24 $
    db %00001100,%11010010,%01001011,%00110000 ; 0x25 %
    db %00000000,%11101010,%01011010,%11010000 ; 0x26 &
    db %00000011,%00010010,%00000000,%00000000 ; 0x27 '    
    db %00000010,%01000100,%01000100,%00100000 ; 0x28 (
    db %00000100,%00100010,%00100010,%01000000 ; 0x29 )
    
    db %00000000,%00001010,%01001010,%00000000 ; 0x2A *
    db %00000000,%00000100,%11100100,%00000000 ; 0x2B +
    db %00000000,%00000000,%00000010,%00100100 ; 0x2C ,
    db %00000000,%00000000,%11100000,%00000000 ; 0x2D -
    db %00000000,%00000000,%00000000,%01000000 ; 0x2E .
    db %00000000,%00010010,%01001000,%00000000 ; 0x2F /
    
    db %00000110,%10011011,%11011001,%01100000 ; 0x30 0
    db %00000010,%01100010,%00100010,%01110000 ; 0x31 1
    db %00000110,%10010001,%01101000,%11110000 ; 0x32 2
    db %00000110,%10010010,%00011001,%01100000 ; 0x33 3
    db %00000010,%01101010,%11110010,%00100000 ; 0x34 4
    db %00001111,%10001110,%00011001,%01100000 ; 0x35 5
    db %00000110,%10001110,%10011001,%01100000 ; 0x36 6
    db %00001111,%00010010,%01000100,%01000000 ; 0x37 7
    db %00000110,%10010110,%10011001,%01100000 ; 0x38 8
    db %00000110,%10011001,%01110001,%01100000 ; 0x39 9
    db %00000000,%00000010,%00000010,%00000000 ; 0x3A :
    db %00000000,%00000010,%00000010,%01000000 ; 0x3B ;
    db %00000000,%00010010,%01000010,%00010000 ; 0x3C <
    db %00000000,%00000111,%00000111,%00000000 ; 0x3D =
    db %00000000,%01000010,%00010010,%01000000 ; 0x3E >
    db %00001110,%00010010,%01000000,%01000000 ; 0x3F ?
    
    db %00000000,%01101111,%10111000,%01100000 ; 0x40 @
    db %00000110,%10011001,%11111001,%10010000 ; 0x41 A
    db %00001110,%10011110,%10011001,%11100000 ; 0x42 B
    db %00000110,%10011000,%10001001,%01100000 ; 0x43 C
    db %00001110,%10011001,%10011001,%11100000 ; 0x44 D
    db %00001111,%10001110,%10001000,%11110000 ; 0x45 E
    db %00001111,%10001110,%10001000,%10000000 ; 0x46 F
    db %00000110,%10011000,%10111001,%01110000 ; 0x47 G
    db %00001001,%10011111,%10011001,%10010000 ; 0x48 H
    db %00000111,%00100010,%00100010,%01110000 ; 0x49 I
    db %00000111,%00010001,%00011001,%01100000 ; 0x4A J
    db %00001001,%10101100,%10101001,%10010000 ; 0x4B K
    db %00001000,%10001000,%10001000,%11110000 ; 0x4C L
    db %00001001,%11111001,%10011001,%10010000 ; 0x4D M
    db %00001001,%11011011,%10011001,%10010000 ; 0x4E N
    db %00000110,%10011001,%10011001,%01100000 ; 0x4F O
    
    db %00001110,%10011001,%11101000,%10000000 ; 0x50 P
    db %00000110,%10011001,%10011010,%01010000 ; 0x51 Q
    db %00001110,%10011001,%11101001,%10010000 ; 0x52 R
    db %00000111,%10000110,%00010001,%11100000 ; 0x53 S
    db %00001111,%00100010,%00100010,%00100000 ; 0x54 T
    db %00001001,%10011001,%10011001,%01100000 ; 0x55 U
    db %00001001,%10011001,%10010101,%00100000 ; 0x56 V
    db %00001001,%10011001,%10011111,%10010000 ; 0x57 W
    db %00001001,%10010110,%10011001,%10010000 ; 0x58 X
    db %00001001,%10010101,%00100010,%00100000 ; 0x59 Y
    db %00001111,%00010010,%01001000,%11110000 ; 0x5A Z
    db %00000111,%01000100,%01000100,%01110000 ; 0x5B [
    db %00000000,%10000100,%00100001,%00000000 ; 0x5C \
    db %00001110,%00100010,%00100010,%11100000 ; 0x5D ]
    db %00000010,%01010000,%00000000,%00000000 ; 0x5E ^
    db %00000000,%00000000,%00000000,%11110000 ; 0x5F _
    
    db %00000011,%01001110,%01000100,%11110000 ; 0x60 ` GBP
    db %00000000,%01100001,%01111001,%01110000 ; 0x61 a
    db %00001000,%11101001,%10011001,%11100000 ; 0x62 b
    db %00000000,%01101001,%10001001,%01100000 ; 0x63 c
    db %00000001,%01111001,%10011001,%01110000 ; 0x64 d
    db %00000000,%01101001,%11111000,%01110000 ; 0x65 e
    db %00110100,%11100100,%01000100,%01000000 ; 0x66 f
    db %00000000,%01111001,%10010111,%00010110 ; 0x67 g
    db %00001000,%11101001,%10011001,%10010000 ; 0x68 h
    db %00100000,%01100010,%00100010,%01110000 ; 0x69 i
    db %00010000,%00110001,%00010001,%10010110 ; 0x6A j
    db %00001000,%10011010,%11001010,%10010000 ; 0x6B k
    db %00001100,%01000100,%01000100,%11100000 ; 0x6C l
    db %00000000,%11001011,%10111011,%10010000 ; 0x6D m
    db %00000000,%10101101,%10011001,%10010000 ; 0x6E n
    db %00000000,%01101001,%10011001,%01100000 ; 0x6F o
   
    db %00000000,%11101001,%10011001,%11101000 ; 0x70 p
    db %00000000,%01111001,%10011001,%01110001 ; 0x71 q
    db %00000000,%10101101,%10001000,%10000000 ; 0x72 r
    db %00000000,%01111000,%01100001,%11100000 ; 0x73 s
    db %00000100,%11100100,%01000100,%00110000 ; 0x74 t
    db %00000000,%10011001,%10011001,%01100000 ; 0x75 u
    db %00000000,%10011001,%10010101,%00100000 ; 0x76 v
    db %00000000,%10011001,%10011111,%10010000 ; 0x77 w
    db %00000000,%10011001,%01101001,%10010000 ; 0x78 x
    db %00000000,%10011001,%10010111,%00010110 ; 0x79 y
    db %00000000,%11110010,%01001000,%11110000 ; 0x7A z
    db %00010010,%00100100,%00100010,%00010000 ; 0x7B 
    db %01000100,%01000100,%01000100,%01000000 ; 0x7C |
    db %10000100,%01000010,%01000100,%10000000 ; 0x7D 
    db %00000101,%10100000,%00000000,%00000000 ; 0x7E ~
    db %00000110,%10011011,%10111001,%01100000 ; 0x7F (c)

STRING_SECTION:
string104:
    db ".", 0x0D + 0x80
size104              EQU $ - string104
string103:
    db 0x22, " is"," " + 0x80
size103              EQU $ - string103
string102:
    db 0x22, " and ", 0x22 + 0x80
size102              EQU $ - string102
string101:
    db "The Levenshtein distance between ", 0x22 + 0x80
size101              EQU $ - string101


VARIABLE_SECTION:

len_1:                  ;           cvariable len_1 
    db 0x00             ;           cvariable len_1 
len_2:                  ;           cvariable len_2 
    db 0x00             ;           cvariable len_2 
__create_word_1:        ;
ds 25
__create_word_2:        ;
ds 25
__create_table:         ;

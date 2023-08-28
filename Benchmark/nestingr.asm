      ifdef __ORG
    org __ORG
  else
    org 24576
  endif





;# ( Forth nesting (NEXT) Benchmark     cas20101204 )
     
                      
                          
                          
                   
                 
                 
                 
                 
                 

    
     

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    push DE             ; 1:11      print     "enter 1million or 32million", 0xD
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    call _1million      ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a recursive function  ---
bottom:                 ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
bottom_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_1st:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call bottom         ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call bottom         ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_1st_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_2nd:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _1st           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _1st           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_2nd_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_3rd:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _2nd           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _2nd           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_3rd_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_4th:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _3rd           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _3rd           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_4th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_5th:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _4th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _4th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_5th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_6th:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _5th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _5th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_6th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_7th:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _6th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _6th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_7th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_8th:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _7th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _7th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_8th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_9th:                   ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _8th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _8th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_9th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_10th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _9th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _9th           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_10th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_11th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _10th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _10th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_11th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_12th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _11th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _11th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_12th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_13th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _12th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _12th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_13th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_14th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _13th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _13th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_14th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_15th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _14th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _14th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_15th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_16th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _15th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _15th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_16th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_17th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _16th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _16th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_17th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_18th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _17th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _17th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_18th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_19th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _18th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _18th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_19th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_20th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _19th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _19th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_20th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_21th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _20th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _20th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_21th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_22th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _21th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _21th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_22th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_23th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _22th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _22th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_23th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_24th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _23th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _23th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_24th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_25th:                  ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    call _24th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    call _24th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_25th_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_32million:             ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    push DE             ; 1:11      print     "32 million nest/unnest operations", 0xD
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    call _25th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_32million_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a recursive function  ---
_1million:              ;           
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
    push DE             ; 1:11      print     " 1 million nest/unnest operations", 0xD
    ld   BC, size103    ; 3:10      print     Length of string103
    ld   DE, string103  ; 3:10      print     Address of string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    call _20th          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
_1million_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------

STRING_SECTION:
string103:
    db " 1 million nest/unnest operations", 0xD
size103              EQU $ - string103
string102:
    db "32 million nest/unnest operations", 0xD
size102              EQU $ - string102
string101:
    db "enter 1million or 32million", 0xD
size101              EQU $ - string101

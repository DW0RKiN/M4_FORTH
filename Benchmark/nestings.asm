    ORG 0x8000





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
    call _1million      ; 3:17      scall
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a data stack function  ---
bottom:                 ;           
bottom_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_1st:                   ;           
    call bottom         ; 3:17      scall
    call bottom         ; 3:17      scall
_1st_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_2nd:                   ;           
    call _1st           ; 3:17      scall
    call _1st           ; 3:17      scall
_2nd_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_3rd:                   ;           
    call _2nd           ; 3:17      scall
    call _2nd           ; 3:17      scall
_3rd_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_4th:                   ;           
    call _3rd           ; 3:17      scall
    call _3rd           ; 3:17      scall
_4th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_5th:                   ;           
    call _4th           ; 3:17      scall
    call _4th           ; 3:17      scall
_5th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_6th:                   ;           
    call _5th           ; 3:17      scall
    call _5th           ; 3:17      scall
_6th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_7th:                   ;           
    call _6th           ; 3:17      scall
    call _6th           ; 3:17      scall
_7th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_8th:                   ;           
    call _7th           ; 3:17      scall
    call _7th           ; 3:17      scall
_8th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_9th:                   ;           
    call _8th           ; 3:17      scall
    call _8th           ; 3:17      scall
_9th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_10th:                  ;           
    call _9th           ; 3:17      scall
    call _9th           ; 3:17      scall
_10th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_11th:                  ;           
    call _10th          ; 3:17      scall
    call _10th          ; 3:17      scall
_11th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_12th:                  ;           
    call _11th          ; 3:17      scall
    call _11th          ; 3:17      scall
_12th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_13th:                  ;           
    call _12th          ; 3:17      scall
    call _12th          ; 3:17      scall
_13th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_14th:                  ;           
    call _13th          ; 3:17      scall
    call _13th          ; 3:17      scall
_14th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_15th:                  ;           
    call _14th          ; 3:17      scall
    call _14th          ; 3:17      scall
_15th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_16th:                  ;           
    call _15th          ; 3:17      scall
    call _15th          ; 3:17      scall
_16th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_17th:                  ;           
    call _16th          ; 3:17      scall
    call _16th          ; 3:17      scall
_17th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_18th:                  ;           
    call _17th          ; 3:17      scall
    call _17th          ; 3:17      scall
_18th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_19th:                  ;           
    call _18th          ; 3:17      scall
    call _18th          ; 3:17      scall
_19th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_20th:                  ;           
    call _19th          ; 3:17      scall
    call _19th          ; 3:17      scall
_20th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_21th:                  ;           
    call _20th          ; 3:17      scall
    call _20th          ; 3:17      scall
_21th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_22th:                  ;           
    call _21th          ; 3:17      scall
    call _21th          ; 3:17      scall
_22th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_23th:                  ;           
    call _22th          ; 3:17      scall
    call _22th          ; 3:17      scall
_23th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_24th:                  ;           
    call _23th          ; 3:17      scall
    call _23th          ; 3:17      scall
_24th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_25th:                  ;           
    call _24th          ; 3:17      scall
    call _24th          ; 3:17      scall
_25th_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_32million:             ;           
    push DE             ; 1:11      print     "32 million nest/unnest operations", 0xD
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    call _25th          ; 3:17      scall
_32million_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_1million:              ;           
    push DE             ; 1:11      print     " 1 million nest/unnest operations", 0xD
    ld   BC, size103    ; 3:10      print     Length of string103
    ld   DE, string103  ; 3:10      print     Address of string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    call _20th          ; 3:17      scall
_1million_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------

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

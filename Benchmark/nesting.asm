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
    call _1million      ; 3:17      call ( -- )
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
bottom:                 ;           
    pop  BC             ; 1:10      : ret
    ld  (bottom_end+1),BC; 4:20      : ( ret -- )
bottom_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_1st:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_1st_end+1),BC ; 4:20      : ( ret -- )
    call bottom         ; 3:17      call ( -- )
    call bottom         ; 3:17      call ( -- )
_1st_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_2nd:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_2nd_end+1),BC ; 4:20      : ( ret -- )
    call _1st           ; 3:17      call ( -- )
    call _1st           ; 3:17      call ( -- )
_2nd_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_3rd:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_3rd_end+1),BC ; 4:20      : ( ret -- )
    call _2nd           ; 3:17      call ( -- )
    call _2nd           ; 3:17      call ( -- )
_3rd_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_4th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_4th_end+1),BC ; 4:20      : ( ret -- )
    call _3rd           ; 3:17      call ( -- )
    call _3rd           ; 3:17      call ( -- )
_4th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_5th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_5th_end+1),BC ; 4:20      : ( ret -- )
    call _4th           ; 3:17      call ( -- )
    call _4th           ; 3:17      call ( -- )
_5th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_6th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_6th_end+1),BC ; 4:20      : ( ret -- )
    call _5th           ; 3:17      call ( -- )
    call _5th           ; 3:17      call ( -- )
_6th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_7th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_7th_end+1),BC ; 4:20      : ( ret -- )
    call _6th           ; 3:17      call ( -- )
    call _6th           ; 3:17      call ( -- )
_7th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_8th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_8th_end+1),BC ; 4:20      : ( ret -- )
    call _7th           ; 3:17      call ( -- )
    call _7th           ; 3:17      call ( -- )
_8th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_9th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_9th_end+1),BC ; 4:20      : ( ret -- )
    call _8th           ; 3:17      call ( -- )
    call _8th           ; 3:17      call ( -- )
_9th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_10th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_10th_end+1),BC; 4:20      : ( ret -- )
    call _9th           ; 3:17      call ( -- )
    call _9th           ; 3:17      call ( -- )
_10th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_11th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_11th_end+1),BC; 4:20      : ( ret -- )
    call _10th          ; 3:17      call ( -- )
    call _10th          ; 3:17      call ( -- )
_11th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_12th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_12th_end+1),BC; 4:20      : ( ret -- )
    call _11th          ; 3:17      call ( -- )
    call _11th          ; 3:17      call ( -- )
_12th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_13th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_13th_end+1),BC; 4:20      : ( ret -- )
    call _12th          ; 3:17      call ( -- )
    call _12th          ; 3:17      call ( -- )
_13th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_14th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_14th_end+1),BC; 4:20      : ( ret -- )
    call _13th          ; 3:17      call ( -- )
    call _13th          ; 3:17      call ( -- )
_14th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_15th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_15th_end+1),BC; 4:20      : ( ret -- )
    call _14th          ; 3:17      call ( -- )
    call _14th          ; 3:17      call ( -- )
_15th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_16th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_16th_end+1),BC; 4:20      : ( ret -- )
    call _15th          ; 3:17      call ( -- )
    call _15th          ; 3:17      call ( -- )
_16th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_17th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_17th_end+1),BC; 4:20      : ( ret -- )
    call _16th          ; 3:17      call ( -- )
    call _16th          ; 3:17      call ( -- )
_17th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_18th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_18th_end+1),BC; 4:20      : ( ret -- )
    call _17th          ; 3:17      call ( -- )
    call _17th          ; 3:17      call ( -- )
_18th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_19th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_19th_end+1),BC; 4:20      : ( ret -- )
    call _18th          ; 3:17      call ( -- )
    call _18th          ; 3:17      call ( -- )
_19th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_20th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_20th_end+1),BC; 4:20      : ( ret -- )
    call _19th          ; 3:17      call ( -- )
    call _19th          ; 3:17      call ( -- )
_20th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_21th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_21th_end+1),BC; 4:20      : ( ret -- )
    call _20th          ; 3:17      call ( -- )
    call _20th          ; 3:17      call ( -- )
_21th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_22th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_22th_end+1),BC; 4:20      : ( ret -- )
    call _21th          ; 3:17      call ( -- )
    call _21th          ; 3:17      call ( -- )
_22th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_23th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_23th_end+1),BC; 4:20      : ( ret -- )
    call _22th          ; 3:17      call ( -- )
    call _22th          ; 3:17      call ( -- )
_23th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_24th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_24th_end+1),BC; 4:20      : ( ret -- )
    call _23th          ; 3:17      call ( -- )
    call _23th          ; 3:17      call ( -- )
_24th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_25th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_25th_end+1),BC; 4:20      : ( ret -- )
    call _24th          ; 3:17      call ( -- )
    call _24th          ; 3:17      call ( -- )
_25th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_32million:             ;           
    pop  BC             ; 1:10      : ret
    ld  (_32million_end+1),BC; 4:20      : ( ret -- )
    push DE             ; 1:11      print     "32 million nest/unnest operations", 0xD
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    call _25th          ; 3:17      call ( -- )
_32million_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
_1million:              ;           
    pop  BC             ; 1:10      : ret
    ld  (_1million_end+1),BC; 4:20      : ( ret -- )
    push DE             ; 1:11      print     " 1 million nest/unnest operations", 0xD
    ld   BC, size103    ; 3:10      print     Length of string103
    ld   DE, string103  ; 3:10      print     Address of string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    call _20th          ; 3:17      call ( -- )
_1million_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

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

ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10
    exx                 ; 1:4

    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print

    call _1million      ; 3:17      call ( -- ret ) R:( -- )

Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====

;# ( Forth nesting (NEXT) Benchmark     cas20101204 )

;   ---  the beginning of a non-recursive function  ---
bottom:                 ;           
    pop  BC             ; 1:10      : ret
    ld  (bottom_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
bottom_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------    

;   ---  the beginning of a non-recursive function  ---
_1st:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_1st_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call bottom         ; 3:17      call ( -- ret ) R:( -- ) 
    call bottom         ; 3:17      call ( -- ret ) R:( -- ) 
_1st_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  
;   ---  the beginning of a non-recursive function  ---
_2nd:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_2nd_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call _1st           ; 3:17      call ( -- ret ) R:( -- )  
    call _1st           ; 3:17      call ( -- ret ) R:( -- )  
_2nd_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------   
;   ---  the beginning of a non-recursive function  ---
_3rd:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_3rd_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call _2nd           ; 3:17      call ( -- ret ) R:( -- )  
    call _2nd           ; 3:17      call ( -- ret ) R:( -- )  
_3rd_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_4th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_4th_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call _3rd           ; 3:17      call ( -- ret ) R:( -- )   
    call _3rd           ; 3:17      call ( -- ret ) R:( -- )   
_4th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  
;   ---  the beginning of a non-recursive function  ---
_5th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_5th_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call _4th           ; 3:17      call ( -- ret ) R:( -- )  
    call _4th           ; 3:17      call ( -- ret ) R:( -- )  
_5th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------   
;   ---  the beginning of a non-recursive function  ---
_6th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_6th_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call _5th           ; 3:17      call ( -- ret ) R:( -- )  
    call _5th           ; 3:17      call ( -- ret ) R:( -- )  
_6th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_7th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_7th_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call _6th           ; 3:17      call ( -- ret ) R:( -- )   
    call _6th           ; 3:17      call ( -- ret ) R:( -- )   
_7th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  
;   ---  the beginning of a non-recursive function  ---
_8th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_8th_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call _7th           ; 3:17      call ( -- ret ) R:( -- )  
    call _7th           ; 3:17      call ( -- ret ) R:( -- )  
_8th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------   
;   ---  the beginning of a non-recursive function  ---
_9th:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_9th_end+1),BC ; 4:20      : ( ret -- ) R:( -- )  
    call _8th           ; 3:17      call ( -- ret ) R:( -- )  
    call _8th           ; 3:17      call ( -- ret ) R:( -- )  
_9th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_10th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_10th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _9th           ; 3:17      call ( -- ret ) R:( -- )   
    call _9th           ; 3:17      call ( -- ret ) R:( -- )   
_10th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  
;   ---  the beginning of a non-recursive function  ---
_11th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_11th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _10th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _10th          ; 3:17      call ( -- ret ) R:( -- ) 
_11th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------   
;   ---  the beginning of a non-recursive function  ---
_12th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_12th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _11th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _11th          ; 3:17      call ( -- ret ) R:( -- ) 
_12th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_13th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_13th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _12th          ; 3:17      call ( -- ret ) R:( -- )  
    call _12th          ; 3:17      call ( -- ret ) R:( -- )  
_13th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  
;   ---  the beginning of a non-recursive function  ---
_14th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_14th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _13th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _13th          ; 3:17      call ( -- ret ) R:( -- ) 
_14th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------   
;   ---  the beginning of a non-recursive function  ---
_15th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_15th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _14th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _14th          ; 3:17      call ( -- ret ) R:( -- ) 
_15th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_16th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_16th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _15th          ; 3:17      call ( -- ret ) R:( -- )  
    call _15th          ; 3:17      call ( -- ret ) R:( -- )  
_16th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  
;   ---  the beginning of a non-recursive function  ---
_17th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_17th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _16th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _16th          ; 3:17      call ( -- ret ) R:( -- ) 
_17th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------   
;   ---  the beginning of a non-recursive function  ---
_18th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_18th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _17th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _17th          ; 3:17      call ( -- ret ) R:( -- ) 
_18th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_19th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_19th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _18th          ; 3:17      call ( -- ret ) R:( -- )  
    call _18th          ; 3:17      call ( -- ret ) R:( -- )  
_19th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  
;   ---  the beginning of a non-recursive function  ---
_20th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_20th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _19th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _19th          ; 3:17      call ( -- ret ) R:( -- ) 
_20th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------   
;   ---  the beginning of a non-recursive function  ---
_21th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_21th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _20th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _20th          ; 3:17      call ( -- ret ) R:( -- ) 
_21th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_22th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_22th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _21th          ; 3:17      call ( -- ret ) R:( -- )  
    call _21th          ; 3:17      call ( -- ret ) R:( -- )  
_22th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  
;   ---  the beginning of a non-recursive function  ---
_23th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_23th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _22th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _22th          ; 3:17      call ( -- ret ) R:( -- ) 
_23th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------   
;   ---  the beginning of a non-recursive function  ---
_24th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_24th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _23th          ; 3:17      call ( -- ret ) R:( -- ) 
    call _23th          ; 3:17      call ( -- ret ) R:( -- ) 
_24th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_25th:                  ;           
    pop  BC             ; 1:10      : ret
    ld  (_25th_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    call _24th          ; 3:17      call ( -- ret ) R:( -- )  
    call _24th          ; 3:17      call ( -- ret ) R:( -- )  
_25th_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------            


;   ---  the beginning of a non-recursive function  ---
_32million:             ;           
    pop  BC             ; 1:10      : ret
    ld  (_32million_end+1),BC; 4:20      : ( ret -- ) R:( -- )  
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call _25th          ; 3:17      call ( -- ret ) R:( -- ) 
_32million_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;   ---  the beginning of a non-recursive function  ---
_1million:              ;           
    pop  BC             ; 1:10      : ret
    ld  (_1million_end+1),BC; 4:20      : ( ret -- ) R:( -- )   
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    call _20th          ; 3:17      call ( -- ret ) R:( -- ) 
_1million_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



VARIABLE_SECTION:

STRING_SECTION:
string103:
db " 1 million nest/unnest operations", 0xD
size103 EQU $ - string103
string102:
db "32 million nest/unnest operations", 0xD
size102 EQU $ - string102
string101:
db "enter 1million or 32million", 0xD
size101 EQU $ - string101


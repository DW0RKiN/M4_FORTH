ORG 0x8000

;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx

    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print


    call _1million      ; 3:17      scall

    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====

;( Forth nesting (NEXT) Benchmark     cas20101204 )

;   ---  b e g i n  ---
bottom:                 ;            
bottom_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----    

;   ---  b e g i n  ---
_1st:                   ;            
    call bottom         ; 3:17      scall 
    call bottom         ; 3:17      scall 
_1st_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_2nd:                   ;            
    call _1st           ; 3:17      scall 
    call _1st           ; 3:17      scall 
_2nd_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_3rd:                   ;            
    call _2nd           ; 3:17      scall 
    call _2nd           ; 3:17      scall 
_3rd_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_4th:                   ;            
    call _3rd           ; 3:17      scall 
    call _3rd           ; 3:17      scall 
_4th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_5th:                   ;            
    call _4th           ; 3:17      scall 
    call _4th           ; 3:17      scall 
_5th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_6th:                   ;            
    call _5th           ; 3:17      scall 
    call _5th           ; 3:17      scall 
_6th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_7th:                   ;            
    call _6th           ; 3:17      scall 
    call _6th           ; 3:17      scall 
_7th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_8th:                   ;            
    call _7th           ; 3:17      scall 
    call _7th           ; 3:17      scall 
_8th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_9th:                   ;            
    call _8th           ; 3:17      scall 
    call _8th           ; 3:17      scall 
_9th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_10th:                  ;            
    call _9th           ; 3:17      scall 
    call _9th           ; 3:17      scall 
_10th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_11th:                  ;            
    call _10th          ; 3:17      scall 
    call _10th          ; 3:17      scall 
_11th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_12th:                  ;            
    call _11th          ; 3:17      scall 
    call _11th          ; 3:17      scall 
_12th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_13th:                  ;            
    call _12th          ; 3:17      scall 
    call _12th          ; 3:17      scall 
_13th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_14th:                  ;            
    call _13th          ; 3:17      scall 
    call _13th          ; 3:17      scall 
_14th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_15th:                  ;            
    call _14th          ; 3:17      scall 
    call _14th          ; 3:17      scall 
_15th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_16th:                  ;            
    call _15th          ; 3:17      scall 
    call _15th          ; 3:17      scall 
_16th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_17th:                  ;            
    call _16th          ; 3:17      scall 
    call _16th          ; 3:17      scall 
_17th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_18th:                  ;            
    call _17th          ; 3:17      scall 
    call _17th          ; 3:17      scall 
_18th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_19th:                  ;            
    call _18th          ; 3:17      scall 
    call _18th          ; 3:17      scall 
_19th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_20th:                  ;            
    call _19th          ; 3:17      scall 
    call _19th          ; 3:17      scall 
_20th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_21th:                  ;            
    call _20th          ; 3:17      scall 
    call _20th          ; 3:17      scall 
_21th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_22th:                  ;            
    call _21th          ; 3:17      scall 
    call _21th          ; 3:17      scall 
_22th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_23th:                  ;            
    call _22th          ; 3:17      scall 
    call _22th          ; 3:17      scall 
_23th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_24th:                  ;            
    call _23th          ; 3:17      scall 
    call _23th          ; 3:17      scall 
_24th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_25th:                  ;            
    call _24th          ; 3:17      scall 
    call _24th          ; 3:17      scall 
_25th_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----            


;   ---  b e g i n  ---
_32million:             ;             
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    call _25th          ; 3:17      scall 
_32million_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

;   ---  b e g i n  ---
_1million:              ;              
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    call _20th          ; 3:17      scall 
_1million_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----



VARIABLE_SECTION:

STRING_SECTION:
string103:
db " 1 million nest/unnest operations",0xD
size103 EQU $ - string103
string102:
db "32 million nest/unnest operations",0xD
size102 EQU $ - string102
string101:
db "enter 1million or 32million", 0xD
size101 EQU $ - string101


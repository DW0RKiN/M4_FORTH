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


    call _1million      ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call

    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====

;( Forth nesting (NEXT) Benchmark     cas20101204 )

;   ---  b e g i n  ---
bottom:                 ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
bottom_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----    

;   ---  b e g i n  ---
_1st:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call bottom         ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call bottom         ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_1st_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_2nd:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call _1st           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _1st           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_2nd_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_3rd:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call _2nd           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _2nd           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_3rd_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_4th:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call _3rd           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call   
    call _3rd           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call   
_4th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_5th:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call _4th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _4th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_5th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_6th:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call _5th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _5th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_6th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_7th:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call _6th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call   
    call _6th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call   
_7th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_8th:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call _7th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _7th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_8th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_9th:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    call _8th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _8th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_9th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_10th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _9th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call   
    call _9th           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call   
_10th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_11th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _10th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _10th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_11th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_12th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _11th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _11th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_12th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_13th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _12th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _12th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_13th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_14th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _13th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _13th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_14th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_15th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _14th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _14th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_15th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_16th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _15th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _15th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_16th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_17th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _16th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _16th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_17th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_18th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _17th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _17th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_18th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_19th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _18th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _18th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_19th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_20th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _19th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _19th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_20th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_21th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _20th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _20th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_21th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_22th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _21th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _21th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_22th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----  
;   ---  b e g i n  ---
_23th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _22th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _22th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_23th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----   
;   ---  b e g i n  ---
_24th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _23th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    call _23th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_24th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_25th:                  ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : 
    call _24th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
    call _24th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call  
_25th_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----            


;   ---  b e g i n  ---
_32million:             ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :  
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    call _25th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_32million_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

;   ---  b e g i n  ---
_1million:              ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :   
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
 
    call _20th          ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
_1million_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
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



    ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    
    

    
    push DE             ; 1:11      push2(orig,test)
    ld   DE, orig       ; 3:10      push2(orig,test)
    push HL             ; 1:11      push2(orig,test)
    ld   HL, test       ; 3:10      push2(orig,test) 
    push DE             ; 1:11      push(2*10)
    ex   DE, HL         ; 1:4       push(2*10)
    ld   HL, 2*10       ; 3:10      push(2*10) 
    ld    A, H          ; 1:4       cmove   ( from_addr to_addr u -- )
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from_addr
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove
    
    push DE             ; 1:11      push2(test,10)
    ld   DE, test       ; 3:10      push2(test,10)
    push HL             ; 1:11      push2(test,10)
    ld   HL, 10         ; 3:10      push2(test,10) 
    call print          ; 3:17      call ( -- )
    
    push DE             ; 1:11      push2(test,10)
    ld   DE, test       ; 3:10      push2(test,10)
    push HL             ; 1:11      push2(test,10)
    ld   HL, 10         ; 3:10      push2(test,10) 
    call sort           ; 3:17      call ( -- )
    
    push DE             ; 1:11      push2(test,10)
    ld   DE, test       ; 3:10      push2(test,10)
    push HL             ; 1:11      push2(test,10)
    ld   HL, 10         ; 3:10      push2(test,10) 
    call print          ; 3:17      call ( -- )
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
       
    
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    srl   H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth 
    call PRT_U16        ; 3:17      u.   ( u -- ) 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z
    
    ex   DE, HL         ; 1:4       __ras   ( -- return_address_stack )
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    pop  HL             ; 1:10      __ras
    
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
    call PRINT_STRING_Z ; 3:17      print_z 
    call PRT_U16        ; 3:17      u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
    

;   ---  the beginning of a non-recursive function  ---
print:                  ;           (addr len -- )
    pop  BC             ; 1:10      : ret
    ld  (print_end+1),BC; 4:20      : ( ret -- )
  
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) ; addr len 1
  
    ld  (idx101), HL    ; 3:16      do 101 save index
    dec  DE             ; 1:6       do 101 stop-1
    ld    A, E          ; 1:4       do 101
    ld  (stp_lo101), A  ; 3:13      do 101 lo stop
    ld    A, D          ; 1:4       do 101
    ld  (stp_hi101), A  ; 3:13      do 101 hi stop
    pop  HL             ; 1:10      do 101
    pop  DE             ; 1:10      do 101 ( -- ) R: ( -- )
do101:                  ;           do 101 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      index i 101
    ex   DE, HL         ; 1:4       index i 101
    ld   HL, (idx101)   ; 3:16      index i 101 idx always points to a 16-bit index 
    add  HL, HL         ; 1:11      2* 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
  
idx101 EQU $+1          ;           loop 101
    ld   BC, 0x0000     ; 3:10      loop 101 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 101
stp_lo101 EQU $+1       ;           loop 101
    xor  0x00           ; 2:7       loop 101 lo index - stop - 1
    ld    A, B          ; 1:4       loop 101
    inc  BC             ; 1:6       loop 101 index++
    ld  (idx101),BC     ; 4:20      loop 101 save index
    jp   nz, do101      ; 3:10      loop 101
stp_hi101 EQU $+1       ;           loop 101
    xor  0x00           ; 2:7       loop 101 hi index - stop - 1
    jp   nz, do101      ; 3:10      loop 101
leave101:               ;           loop 101
exit101:                ;           loop 101 
  
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

print_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
insert:                 ;           ( start end -- start )
    pop  BC             ; 1:10      : ret
    ld  (insert_end+1),BC; 4:20      : ( ret -- )
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
                        ;[9:65]     to_r   ( c b a -- c b ) ( R: -- a )
    ex  (SP), HL        ; 1:19      to_r   a . b c
    ex   DE, HL         ; 1:4       to_r   a . c b
    exx                 ; 1:4       to_r
    pop  DE             ; 1:10      to_r
    dec  HL             ; 1:6       to_r
    ld  (HL),D          ; 1:7       to_r
    dec   L             ; 1:4       to_r
    ld  (HL),E          ; 1:7       to_r
    exx                 ; 1:4       to_r ;( r: v ) v = a[i]
    
begin101:               ;           begin 101
        
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup  ( b a -- b a b a ) 
                       ;[12:54]     <   ( x2 x1 -- flag x2<x1 )
    ld    A, E          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       <   carry --> sign
    xor   H             ; 1:4       <
    xor   D             ; 1:4       <
    add   A, A          ; 1:4       <   sign --> carry
    sbc   A, A          ; 1:4       <   0x00 or 0xff
    ld    H, A          ; 1:4       <
    ld    L, A          ; 1:4       <
    pop  DE             ; 1:10      <			; j>0
    
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101
        
                        ;[9:64]     r_fetch ( b a -- b a i ) ( R: i -- i )
    exx                 ; 1:4       r_fetch
    ld    E,(HL)        ; 1:7       r_fetch
    inc   L             ; 1:4       r_fetch
    ld    D,(HL)        ; 1:7       r_fetch
    dec   L             ; 1:4       r_fetch
    push DE             ; 1:11      r_fetch
    exx                 ; 1:4       r_fetch
    ex   DE, HL         ; 1:4       r_fetch
    ex  (SP), HL        ; 1:19      r_fetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2- 
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
                       ;[12:54]     <   ( x2 x1 -- flag x2<x1 )
    ld    A, E          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       <   carry --> sign
    xor   H             ; 1:4       <
    xor   D             ; 1:4       <
    add   A, A          ; 1:4       <   sign --> carry
    sbc   A, A          ; 1:4       <   0x00 or 0xff
    ld    H, A          ; 1:4       <
    ld    L, A          ; 1:4       <
    pop  DE             ; 1:10      <		; a[j-1] > v
    
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101
        
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-			; j--
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+ 
                        ;[5:40]     ! store   ( x addr -- )
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store		; a[j] = a[j-1]
    
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
    
                        ;[9:66]     r_from ( b a -- b a i ) ( R: i -- )
    exx                 ; 1:4       r_from
    ld    E,(HL)        ; 1:7       r_from
    inc   L             ; 1:4       r_from
    ld    D,(HL)        ; 1:7       r_from
    inc  HL             ; 1:6       r_from
    push DE             ; 1:11      r_from
    exx                 ; 1:4       r_from i . b a
    ex   DE, HL         ; 1:4       r_from i . a b
    ex  (SP), HL        ; 1:19      r_from b . a i 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
                        ;[5:40]     ! store   ( x addr -- )
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store 

insert_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------		; a[j] = v
 

;   ---  the beginning of a non-recursive function  ---
sort:                   ;           ( array len -- )
    pop  BC             ; 1:10      : ret
    ld  (sort_end+1),BC ; 4:20      : ( ret -- )
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ld  (idx102), HL    ; 3:16      do 102 save index
    dec  DE             ; 1:6       do 102 stop-1
    ld    A, E          ; 1:4       do 102
    ld  (stp_lo102), A  ; 3:13      do 102 lo stop
    ld    A, D          ; 1:4       do 102
    ld  (stp_hi102), A  ; 3:13      do 102 hi stop
    pop  HL             ; 1:10      do 102
    pop  DE             ; 1:10      do 102 ( -- ) R: ( -- )
do102:                  ;           do 102 
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      index i 102
    ex   DE, HL         ; 1:4       index i 102
    ld   HL, (idx102)   ; 3:16      index i 102 idx always points to a 16-bit index 
    add  HL, HL         ; 1:11      2* 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    call insert         ; 3:17      call ( -- ) 
    
idx102 EQU $+1          ;           loop 102
    ld   BC, 0x0000     ; 3:10      loop 102 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 102
stp_lo102 EQU $+1       ;           loop 102
    xor  0x00           ; 2:7       loop 102 lo index - stop - 1
    ld    A, B          ; 1:4       loop 102
    inc  BC             ; 1:6       loop 102 index++
    ld  (idx102),BC     ; 4:20      loop 102 save index
    jp   nz, do102      ; 3:10      loop 102
stp_hi102 EQU $+1       ;           loop 102
    xor  0x00           ; 2:7       loop 102 hi index - stop - 1
    jp   nz, do102      ; 3:10      loop 102
leave102:               ;           loop 102
exit102:                ;           loop 102 
    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 

sort_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

;# I need to have label test and orig at the end.

;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_U16:             ;           prt_sp_u16
    ld    A, ' '        ; 2:7       prt_sp_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_sp_u16   putchar with ZX 48K ROM in, this will print char in A
    ; fall to prt_u16
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
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
;==============================================================================
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst  0x10           ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z

STRING_SECTION:
string102:
db "RAS:", 0x00
size102 EQU $ - string102
string101:
db " values in data stack.", 0xD, 0x00
size101 EQU $ - string101

VARIABLE_SECTION:

test:
DS 20

orig:
dw 7 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5


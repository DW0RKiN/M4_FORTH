
    ORG 0x8000
    
    
test                 EQU __create_test
    

      
     
     
     
    
       
      
    
      
    
    

   ; addr len 1
   
         
   
   



       ;( r: v ) v = a[i]
    
         			; j>0
    
            		; a[j-1] > v
    
        			; j--
            		; a[j] = a[j-1]
    
       
		; a[j] = v
 

      
             
     
     


;# I need to have label test and orig at the end.

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    push DE             ; 1:11      orig test 2*10 cmove   ( orig test 2*10 -- )
    push HL             ; 1:11      orig test 2*10 cmove
    ld   HL, orig       ; 3:10      orig test 2*10 cmove   from_addr
    ld   DE, test       ; 3:10      orig test 2*10 cmove   to_addr
    ld   BC, 0x0014     ; 3:10      orig test 2*10 cmove   u_times
    ldir                ; 2:u*21/16 orig test 2*10 cmove
    pop  HL             ; 1:10      orig test 2*10 cmove
    pop  DE             ; 1:10      orig test 2*10 cmove
                        ;[8:42]     test 10   ( -- test 10 )
    push DE             ; 1:11      test 10
    push HL             ; 1:11      test 10
    ld   DE, test       ; 3:10      test 10
    ld   HL, 0x000A     ; 3:10      test 10
    call print          ; 3:17      call ( -- )
                        ;[8:42]     test 10   ( -- test 10 )
    push DE             ; 1:11      test 10
    push HL             ; 1:11      test 10
    ld   DE, test       ; 3:10      test 10
    ld   HL, 0x000A     ; 3:10      test 10
    call sort           ; 3:17      call ( -- )
                        ;[8:42]     test 10   ( -- test 10 )
    push DE             ; 1:11      test 10
    push HL             ; 1:11      test 10
    ld   DE, test       ; 3:10      test 10
    ld   HL, 0x000A     ; 3:10      test 10
    call print          ; 3:17      call ( -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
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
    ex   DE, HL         ; 1:4       ras   ( -- return_address_stack )
    exx                 ; 1:4       ras
    push HL             ; 1:11      ras
    exx                 ; 1:4       ras
    ex  (SP),HL         ; 1:19      ras
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
    call PRINT_STRING_Z ; 3:17      print_z
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
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
    ld    A, L          ; 1:4       0 do_101(m)   ( stop 0 -- )
    ld  (stp_lo101), A  ; 3:13      0 do_101(m)   lo stop
    ld    A, H          ; 1:4       0 do_101(m)
    ld  (stp_hi101), A  ; 3:13      0 do_101(m)   hi stop
    ld   HL, 0          ; 3:10      0 do_101(m)
    ld  (idx101), HL    ; 3:16      0 do_101(m)   index
    ex   DE, HL         ; 1:4       0 do_101(m)
    pop  DE             ; 1:10      0 do_101(m)
do101:                  ;           0 do_101(m)
    push DE             ; 1:11      dup i_101(m)   ( x -- x x i )
    push HL             ; 1:11      dup i_101(m)
    ex   DE, HL         ; 1:4       dup i_101(m)
    ld   HL, (idx101)   ; 3:16      dup i_101(m)   idx always points to a 16-bit index
    add  HL, HL         ; 1:11      2*
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ld    A, (HL)       ; 1:7       @   ( addr -- x )
    inc  HL             ; 1:6       @
    ld    H, (HL)       ; 1:7       @
    ld    L, A          ; 1:4       @
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
idx101 EQU $+1          ;[20:78/57] loop_101(m)
    ld   BC, 0x0000     ; 3:10      loop_101(m)   idx always points to a 16-bit index
    inc  BC             ; 1:6       loop_101(m)   index++
    ld  (idx101), BC    ; 4:20      loop_101(m)   save index
    ld    A, C          ; 1:4       loop_101(m)   lo new index
stp_lo101 EQU $+1       ;           loop_101(m)
    xor  0x00           ; 2:7       loop_101(m)   lo stop
    jp   nz, do101      ; 3:10      loop_101(m)
    ld    A, B          ; 1:4       loop_101(m)   hi new index
stp_hi101 EQU $+1       ;           loop_101(m)
    xor  0x00           ; 2:7       loop_101(m)   hi stop
    jp   nz, do101      ; 3:10      loop_101(m)
leave101:               ;           loop_101(m)
exit101:                ;           loop_101(m)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
print_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
insert:                 ;           ( start end -- start )
    pop  BC             ; 1:10      : ret
    ld  (insert_end+1),BC; 4:20      : ( ret -- )
                        ;[6:41]     dup @ dup_fetch ( addr -- addr x )
    push DE             ; 1:11      dup @ dup_fetch
    ld    E, (HL)       ; 1:7       dup @ dup_fetch
    inc  HL             ; 1:6       dup @ dup_fetch
    ld    D, (HL)       ; 1:7       dup @ dup_fetch
    dec  HL             ; 1:6       dup @ dup_fetch
    ex   DE, HL         ; 1:4       dup @ dup_fetch
                        ;[9:65]     to_r   ( c b a -- c b ) ( R: -- a )
    ex  (SP), HL        ; 1:19      to_r   a . b c
    ex   DE, HL         ; 1:4       to_r   a . c b
    exx                 ; 1:4       to_r
    pop  DE             ; 1:10      to_r
    dec  HL             ; 1:6       to_r
    ld  (HL),D          ; 1:7       to_r
    dec   L             ; 1:4       to_r
    ld  (HL),E          ; 1:7       to_r
    exx                 ; 1:4       to_r
begin101:               ;           begin 101
    ld    A, E          ; 1:4       2dup < while 101    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       2dup < while 101    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       2dup < while 101    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       2dup < while 101    DE<HL --> DE-HL<0 --> no carry if false
    rra                 ; 1:4       2dup < while 101
    xor   D             ; 1:4       2dup < while 101
    xor   H             ; 1:4       2dup < while 101
    jp    p, break101   ; 3:10      2dup < while 101
                        ;[9:64]     r@   ( -- i ) ( R: i -- i )
    exx                 ; 1:4       r@
    ld    E,(HL)        ; 1:7       r@
    inc   L             ; 1:4       r@
    ld    D,(HL)        ; 1:7       r@
    dec   L             ; 1:4       r@
    push DE             ; 1:11      r@
    exx                 ; 1:4       r@
    ex   DE, HL         ; 1:4       r@
    ex  (SP), HL        ; 1:19      r@
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-
    ld    A, (HL)       ; 1:7       @   ( addr -- x )
    inc  HL             ; 1:6       @
    ld    H, (HL)       ; 1:7       @
    ld    L, A          ; 1:4       @
    ld    A, E          ; 1:4       < while 101    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       < while 101    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       < while 101    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       < while 101    DE<HL --> DE-HL<0 --> no carry if false
    rra                 ; 1:4       < while 101
    xor   D             ; 1:4       < while 101
    xor   H             ; 1:4       < while 101
    pop  HL             ; 1:10      < while 101
    pop  DE             ; 1:10      < while 101
    jp    p, break101   ; 3:10      < while 101
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-
                        ;[6:41]     dup @ dup_fetch ( addr -- addr x )
    push DE             ; 1:11      dup @ dup_fetch
    ld    E, (HL)       ; 1:7       dup @ dup_fetch
    inc  HL             ; 1:6       dup @ dup_fetch
    ld    D, (HL)       ; 1:7       dup @ dup_fetch
    dec  HL             ; 1:6       dup @ dup_fetch
    ex   DE, HL         ; 1:4       dup @ dup_fetch
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+
                        ;[5:40]     !   ( x addr -- )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !
    pop  DE             ; 1:10      !
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
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
                        ;[5:40]     !   ( x addr -- )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !
    pop  DE             ; 1:10      !
insert_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
sort:                   ;           ( array len -- )
    pop  BC             ; 1:10      : ret
    ld  (sort_end+1),BC ; 4:20      : ( ret -- )
    ld    A, L          ; 1:4       1 do_102(m)   ( stop 1 -- )
    ld  (stp_lo102), A  ; 3:13      1 do_102(m)   lo stop
    ld    A, H          ; 1:4       1 do_102(m)
    ld  (stp_hi102), A  ; 3:13      1 do_102(m)   hi stop
    ld   HL, 1          ; 3:10      1 do_102(m)
    ld  (idx102), HL    ; 3:16      1 do_102(m)   index
    ex   DE, HL         ; 1:4       1 do_102(m)
    pop  DE             ; 1:10      1 do_102(m)
do102:                  ;           1 do_102(m)
    push DE             ; 1:11      dup i_102(m)   ( x -- x x i )
    push HL             ; 1:11      dup i_102(m)
    ex   DE, HL         ; 1:4       dup i_102(m)
    ld   HL, (idx102)   ; 3:16      dup i_102(m)   idx always points to a 16-bit index
    add  HL, HL         ; 1:11      2*
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    call insert         ; 3:17      call ( -- )
idx102 EQU $+1          ;[20:78/57] loop_102(m)
    ld   BC, 0x0000     ; 3:10      loop_102(m)   idx always points to a 16-bit index
    inc  BC             ; 1:6       loop_102(m)   index++
    ld  (idx102), BC    ; 4:20      loop_102(m)   save index
    ld    A, C          ; 1:4       loop_102(m)   lo new index
stp_lo102 EQU $+1       ;           loop_102(m)
    xor  0x00           ; 2:7       loop_102(m)   lo stop
    jp   nz, do102      ; 3:10      loop_102(m)
    ld    A, B          ; 1:4       loop_102(m)   hi new index
stp_hi102 EQU $+1       ;           loop_102(m)
    xor  0x00           ; 2:7       loop_102(m)   hi stop
    jp   nz, do102      ; 3:10      loop_102(m)
leave102:               ;           loop_102(m)
exit102:                ;           loop_102(m)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
sort_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_U16:             ;           prt_sp_u16
    ld    A, ' '        ; 2:7       prt_sp_u16   putchar Pollutes: AF, AF', DE', BC'
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
;------------------------------------------------------------------------------
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero + 1
    rst  0x10           ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    inc  BC             ; 1:6       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z

STRING_SECTION:
string102:
    db "RAS:", 0x00
  size102   EQU  $ - string102
string101:
    db " values in data stack.", 0xD, 0x00
  size101   EQU  $ - string101


VARIABLE_SECTION:

__create_test:          ;
ds 20

orig:
dw 7 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5


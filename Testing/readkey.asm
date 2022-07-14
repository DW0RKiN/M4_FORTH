   ORG 0x8000
   
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
   

   
    call CLEARBUFF      ; 3:17      clearkey
   
begin101:               ;           begin 101 
      
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z 
      
    call READKEY        ; 3:17      key 
      
                      ;[7:25/25,25] dup 0x0D <> while 101   ( x1 -- x1 )   0x0D <> HL
    ld    A, 0x0D       ; 2:7       dup 0x0D <> while 101
    xor   L             ; 1:4       dup 0x0D <> while 101   x[1] = 0x0D
    or    H             ; 1:4       dup 0x0D <> while 101   x[2] = 0
    jp    z, break101   ; 3:10      dup 0x0D <> while 101 
         
    ld    A, L          ; 1:4       dup emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      dup emit    with 48K ROM in, this will print char in A 
    ld    A, '='        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with ZX 48K ROM 
    call PRT_U16        ; 3:17      u.   ( u -- ) 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
   
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101 
   
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
   
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
    call PRINT_STRING_Z ; 3:17      print_z
   
    push DE             ; 1:11      push2(buffer,10)
    ld   DE, buffer     ; 3:10      push2(buffer,10)
    push HL             ; 1:11      push2(buffer,10)
    ld   HL, 10         ; 3:10      push2(buffer,10) 
    call READSTRING     ; 3:17      accept
   
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
   
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
   
    ; warning The condition >>>buffer<<< cannot be evaluated
    ld   BC, buffer     ; 3:10      buffer +
    add  HL, BC         ; 1:11      buffer + 
    push DE             ; 1:11      push(buffer)
    ex   DE, HL         ; 1:4       push(buffer)
    ld   HL, buffer     ; 3:10      push(buffer)
   
begin102:               ;           begin 102
      
    ld    A, L          ; 1:4       2dup u> while 102    DE>HL --> 0>HL-DE --> no carry if false
    sub   E             ; 1:4       2dup u> while 102    DE>HL --> 0>HL-DE --> no carry if false
    ld    A, H          ; 1:4       2dup u> while 102    DE>HL --> 0>HL-DE --> no carry if false
    sbc   A, D          ; 1:4       2dup u> while 102    DE>HL --> 0>HL-DE --> no carry if false
    jp   nc, break102   ; 3:10      2dup u> while 102
         
    ld    A,(HL)        ; 1:7       dup @ emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      dup @ emit    with 48K ROM in, this will print char in A
         
    inc  HL             ; 1:6       1+
   
    jp   begin102       ; 3:10      again 102
break102:               ;           again 102
   
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )
   
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
   
    push DE             ; 1:11      buffer swap
    ld   DE, buffer     ; 3:10      buffer swap ( a -- buffer a ) 
    call PRINT_TYPE     ; 3:17      type   ( addr n -- )
    
   
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string103
    call PRINT_STRING_Z ; 3:17      print_z 
    ex   DE, HL         ; 1:4       __ras   ( -- return_address_stack )
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    pop  HL             ; 1:10      __ras 
    call PRT_U16        ; 3:17      u.   ( u -- )
   
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104
    call PRINT_STRING_Z ; 3:17      print_z 
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
   
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
   
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====

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
; Read string from keyboard
; In: DE = addr_string, HL = max_length
; Out: pop stack, TOP = HL = loaded
READSTRING:
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
    pop  HL             ; 1:10      readstring   ret
    pop  DE             ; 1:10      readstring
    push HL             ; 1:11      readstring   ret
    ld    H, B          ; 1:4       readstring
    ld    L, C          ; 1:4       readstring
    ret                 ; 1:10      readstring
;==============================================================================
; Read key from keyboard
; In:
; Out: push stack, TOP = HL = key
READKEY:
    ex   DE, HL         ; 1:4       readkey   ( ret . old _DE old_HL -- old_DE ret . old_HL key )
    ex  (SP),HL         ; 1:19      readkey
    push HL             ; 1:11      readkey

    ld    A,(0x5C08)    ; 3:13      readkey   read new value of LAST K
    or    A             ; 1:4       readkey   is it still zero?
    jr    z, $-4        ; 2:7/12    readkey
    ld    L, A          ; 1:4       readkey
    ld    H, 0x00       ; 2:7       readkey
;   ...fall down to clearbuff
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
;==============================================================================
; ( addr n -- )
; print n chars from addr
;  Input: HL, DE
; Output: Print decimal number in HL
; Pollutes: AF, BC, DE
PRINT_TYPE:             ;[10:76]    print_string
    ld    B, H          ; 1:4       print_string
    ld    C, L          ; 1:4       print_string   BC = length of string to print
    call 0x203C         ; 3:17      print_string   Use ZX 48K ROM
    pop  AF             ; 1:10      print_string   load ret
    pop  HL             ; 1:10      print_string
    pop  DE             ; 1:10      print_string
    push AF             ; 1:11      print_string   save ret
    ret                 ; 1:10      print_string
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
string104:
db 0x0D, "Data stack: ", 0x00
size104 EQU $ - string104
string103:
db 0x0D, "RAS: ", 0x00
size103 EQU $ - string103
string102:
db 0x0D,"10 char string: ", 0x00
size102 EQU $ - string102
string101:
db "Press any key: ", 0x00
size101 EQU $ - string101

VARIABLE_SECTION:

buffer: DS 10

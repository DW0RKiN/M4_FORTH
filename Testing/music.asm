;vvvv
    ;^^^^
    
    
    
; max unpacked file data is USE_PLAY

__LIMITED_TIMES_LOOP_MUSIC equ 1

  ifndef __BUFFER
__BUFFER equ 0xC000
  endif

  ifdef __ORG
    org __ORG
  else
    org 24576
  endif



text_y equ (24+10-1)/2
text_x equ (51-24)/2
         
    
    
ZX_EOL               EQU 0x0D     ; zx_constant   end of line

ZX_INK               EQU 0x10     ; zx_constant   colour
ZX_PAPER             EQU 0x11     ; zx_constant   colour
ZX_FLASH             EQU 0x12     ; zx_constant   0 or 1
ZX_BRIGHT            EQU 0x13     ; zx_constant   0 or 1
ZX_INVERSE           EQU 0x14     ; zx_constant   0 or 1
ZX_OVER              EQU 0x15     ; zx_constant   0 or 1
ZX_AT                EQU 0x16     ; zx_constant   Y,X
ZX_TAB               EQU 0x17     ; zx_constant   # spaces

ZX_BLACK             EQU %000     ; zx_constant
ZX_BLUE              EQU %001     ; zx_constant
ZX_RED               EQU %010     ; zx_constant
ZX_MAGENTA           EQU %011     ; zx_constant
ZX_GREEN             EQU %100     ; zx_constant
ZX_CYAN              EQU %101     ; zx_constant
ZX_YELLOW            EQU %110     ; zx_constant
ZX_WHITE             EQU %111     ; zx_constant

    
     
     

    
        
        
        
        
        
        
        
        
        
        
        
        

          
         
        
         
    
          
     
        
        
 
    
          
     
        
        
 
    
          
     
        
        
 
    
          
     
        
        
 
    
          
     
        
        
 
    
          
     
        
        
 
    
          
     
        
        
 
    
          
     
        
        
 
    
          
     
        
        
 
    
             
    

    
      
    

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld  HL, PRINT_OUT   ; 3:10      init
    ld (CURCHL),HL      ; 3:16      init
    ld  HL, putchar     ; 3:10      init
    ld (PRINT_OUT),HL   ; 3:10      init
  if 0
    ld   HL, 0x0000     ; 3:10      init
    ld  (putchar_yx),HL ; 3:16      init
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
    ld    L, 0xFF       ; 2:7       init
    inc   L             ; 1:4       init
    sub 0x05            ; 2:7       init
    jr   nc, $-3        ; 2:7/12    init
    ld  (putchar_yx),HL ; 3:16      init
  endif
    ld   HL, 0x6D60     ; 3:10      init   Return address stack = 28000
    exx                 ; 1:4       init
                       ;[14:12049]  0x5800 3*256 ZX_BLUE   fill(addr,u,char)   variant >0: fill(num,3*256 (max 256),?)
    ld   BC, 0x5800     ; 3:10      0x5800 3*256 ZX_BLUE   addr
    ld    A, ZX_BLUE    ; 2:7       0x5800 3*256 ZX_BLUE   char
    ld  (BC),A          ; 1:7       0x5800 3*256 ZX_BLUE
    inc  BC             ; 1:6       0x5800 3*256 ZX_BLUE   0x58FF=0x5800+0+3*85
    ld  (BC),A          ; 1:7       0x5800 3*256 ZX_BLUE
    inc  BC             ; 1:6       0x5800 3*256 ZX_BLUE   0x59FF=0x5800+1+3*170
    ld  (BC),A          ; 1:7       0x5800 3*256 ZX_BLUE
    inc   C             ; 1:4       0x5800 3*256 ZX_BLUE
    jp   nz, $-6        ; 3:10      0x5800 3*256 ZX_BLUE
    ld    A, ZX_BLACK   ; 2:7       ZX_BLACK zx_border   ( -- )
    out (254),A         ; 2:11      ZX_BLACK zx_border   0=blk,1=blu,2=red,3=mag,4=grn,5=cyn,6=yel,7=wht
begin101:               ;           begin(101)
    ld   BC, string101  ; 3:10      print_i   Address of string101 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string102  ; 3:10      print_i   Address of string102 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string103  ; 3:10      print_i   Address of string103 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string105  ; 3:10      print_i   Address of string105 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string108  ; 3:10      print_i   Address of string108 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string111  ; 3:10      print_i   Address of string111 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld    A, 0xEF       ; 2:7       0xEF01 testkey if   ( -- )  if press "0"
    in    A,(0xFE)      ; 2:11      0xEF01 testkey if
    rrca                ; 1:4       0xEF01 testkey if
    jp    c, else101    ; 3:10      0xEF01 testkey if
    ld   BC, string102  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string102
    call PRINT_STRING_I ; 3:17      print_i
    jp   break101       ; 3:10      break(101)
    jp   endif101       ; 3:10      else
else101:                ;           else
    ld    A, 0xF7       ; 2:7       0xF701 testkey if   ( -- )  if press "1"
    in    A,(0xFE)      ; 2:11      0xF701 testkey if
    rrca                ; 1:4       0xF701 testkey if
    jp    c, else102    ; 3:10      0xF701 testkey if
    ld   BC, string103  ; 3:10      print_i   Address of string114 ending with inverted most significant bit == string103
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay    packed size: 289
    push HL             ; 1:11      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay
    ld   HL, __file_octode; 3:10      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay
    jp   endif102       ; 3:10      else
else102:                ;           else
    ld    A, 0xF7       ; 2:7       0xF702 testkey if   ( -- )  if press "2"
    in    A,(0xFE)      ; 2:11      0xF702 testkey if
    and  0x02           ; 2:7       0xF702 testkey if
    jp   nz, else103    ; 3:10      0xF702 testkey if
    ld   BC, string104  ; 3:10      print_i   Address of string115 ending with inverted most significant bit == string104
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay    packed size: 335
    push HL             ; 1:11      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay
    ld   HL, __file_octode2k15; 3:10      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay    ZX0 version can be changed by defining USE_LZM or USE_LZ_
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay
    jp   endif103       ; 3:10      else
else103:                ;           else
    ld    A, 0xF7       ; 2:7       0xF704 testkey if   ( -- )  if press "3"
    in    A,(0xFE)      ; 2:11      0xF704 testkey if
    and  0x04           ; 2:7       0xF704 testkey if
    jp   nz, else104    ; 3:10      0xF704 testkey if
    ld   BC, string105  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string105
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay    packed size: 1256
    push HL             ; 1:11      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay
    ld   HL, __file_octode2k16; 3:10      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay    ZX0 version can be changed by defining USE_LZM or USE_LZ_
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay
    jp   endif104       ; 3:10      else
else104:                ;           else
    ld    A, 0xF7       ; 2:7       0xF708 testkey if   ( -- )  if press "4"
    in    A,(0xFE)      ; 2:11      0xF708 testkey if
    and  0x08           ; 2:7       0xF708 testkey if
    jp   nz, else105    ; 3:10      0xF708 testkey if
    ld   BC, string106  ; 3:10      print_i   Address of string117 ending with inverted most significant bit == string106
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay    packed size: 1212
    push HL             ; 1:11      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay
    ld   HL, __file_alf2_zalza; 3:10      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay    ZX0 version can be changed by defining USE_LZM or USE_LZ_
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay
    jp   endif105       ; 3:10      else
else105:                ;           else
    ld    A, 0xF7       ; 2:7       0xF710 testkey if   ( -- )  if press "5"
    in    A,(0xFE)      ; 2:11      0xF710 testkey if
    and  0x10           ; 2:7       0xF710 testkey if
    jp   nz, else106    ; 3:10      0xF710 testkey if
    ld   BC, string107  ; 3:10      print_i   Address of string118 ending with inverted most significant bit == string107
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay    packed size: 1760
    push HL             ; 1:11      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay
    ld   HL, __file_pd_dawn; 3:10      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay    ZX0 version can be changed by defining USE_LZM or USE_LZ_
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay
    jp   endif106       ; 3:10      else
else106:                ;           else
    ld    A, 0xEF       ; 2:7       0xEF10 testkey if   ( -- )  if press "6"
    in    A,(0xFE)      ; 2:11      0xEF10 testkey if
    and  0x10           ; 2:7       0xEF10 testkey if
    jp   nz, else107    ; 3:10      0xEF10 testkey if
    ld   BC, string108  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay    packed size: 3874
    push HL             ; 1:11      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay
    ld   HL, __file_algar_thegermansroom; 3:10      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay    ZX0 version can be changed by defining USE_LZM or USE_LZ_
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay
    jp   endif107       ; 3:10      else
else107:                ;           else
    ld    A, 0xEF       ; 2:7       0xEF08 testkey if   ( -- )  if press "7"
    in    A,(0xFE)      ; 2:11      0xEF08 testkey if
    and  0x08           ; 2:7       0xEF08 testkey if
    jp   nz, else108    ; 3:10      0xEF08 testkey if
    ld   BC, string109  ; 3:10      print_i   Address of string120 ending with inverted most significant bit == string109
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay    packed size: 2018
    push HL             ; 1:11      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay
    ld   HL, __file_bacon_sandwich; 3:10      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay    ZX0 version can be changed by defining USE_LZM or USE_LZ_
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay
    jp   endif108       ; 3:10      else
else108:                ;           else
    ld    A, 0xEF       ; 2:7       0xEF04 testkey if   ( -- )  if press "8"
    in    A,(0xFE)      ; 2:11      0xEF04 testkey if
    and  0x04           ; 2:7       0xEF04 testkey if
    jp   nz, else109    ; 3:10      0xEF04 testkey if
    ld   BC, string110  ; 3:10      print_i   Address of string121 ending with inverted most significant bit == string110
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay    packed size: 1948
    push HL             ; 1:11      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay
    ld   HL, __file_cja_h_what_is_love; 3:10      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay    ZX0 version can be changed by defining USE_LZM or USE_LZ_
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay
    jp   endif109       ; 3:10      else
else109:                ;           else
    ld    A, 0xEF       ; 2:7       0xEF02 testkey if   ( -- )  if press "9"
    in    A,(0xFE)      ; 2:11      0xEF02 testkey if
    and  0x02           ; 2:7       0xEF02 testkey if
    jp   nz, else110    ; 3:10      0xEF02 testkey if
    ld   BC, string111  ; 3:10      print_i   Address of string122 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
                        ;           variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay
    push DE             ; 1:11      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay    packed size: 2003
    push HL             ; 1:11      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay
    ld   HL, __file__first_last_; 3:10      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay    from
    ld   DE, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay    to
    call ZX0_DEPACK     ; 3:17      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay    ZX0 version can be changed by defining USE_LZM or USE_LZ_
    ld   HL, __BUFFER   ; 3:10      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay    HL = addr data
    call PLAY_OCTODE    ; 3:17      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay
    pop  HL             ; 1:10      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay
    pop  DE             ; 1:10      variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay
    jp   endif110       ; 3:10      else
else110:                ;           else
endif110:               ;           then
endif109:               ;           then
endif108:               ;           then
endif107:               ;           then
endif106:               ;           then
endif105:               ;           then
endif104:               ;           then
endif103:               ;           then
endif102:               ;           then
endif101:               ;           then
    jp   begin101       ; 3:10      again(101)
break101:               ;           again(101)
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    rr    H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth
    ld   BC, string123  ; 3:10      print_i   Address of string123 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_S16:                ;           prt_s16
    ld    A, H          ; 1:4       prt_s16
    add   A, A          ; 1:4       prt_s16
    jr   nc, PRT_U16    ; 2:7/12    prt_s16
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      prt_s16   putchar(reg A) with ZX 48K ROM
    xor   A             ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    L, A          ; 1:4       prt_s16   neg
    sbc   A, H          ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    H, A          ; 1:4       prt_s16   neg
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
    rst   0x10          ; 1:11      bin16_dec   putchar(reg A) with ZX 48K ROM
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
;# ----------------------------------------------------------------------------
;# ZX0 decoder by Einar Saukas & Urusergi
;# "Standard" version (68 bytes only)
;# ----------------------------------------------------------------------------
;# Parameters:
;#   HL: source address (compressed data)
;#   DE: destination address (decompressing)
;# ----------------------------------------------------------------------------

ZX0_DEPACK:             ;           zx0_depack
    ld   BC, 0xFFFF     ; 3:10      zx0_depack      preserve default offset 1
    push BC             ; 1:11      zx0_depack
    inc  BC             ; 1:6       zx0_depack
    ld    A, 0x80       ; 2:7       zx0_depack
ZX0_LIT:                ;           zx0_depack      literals
    call ZX0_ELIAS      ; 3:17      zx0_depack      obtain length
    ldir                ; 2:16/21   zx0_depack      copy literals
    add   A, A          ; 1:4       zx0_depack      copy from last offset or new offset?
    jr    c, ZX0_NEW_OFF; 2:7/12    zx0_depack
    call ZX0_ELIAS      ; 3:17      zx0_depack      obtain length
ZX0_COPY:               ;           zx0_depack
    ex  (SP),HL         ; 1:19      zx0_depack      preserve source, restore offset
    push HL             ; 1:11      zx0_depack      preserve offset
    add  HL, DE         ; 1:11      zx0_depack      calculate destination - offset
    ldir                ; 2:16/21   zx0_depack      copy from offset
    pop  HL             ; 1:10      zx0_depack      restore offset
    ex  (SP),HL         ; 1:19      zx0_depack      preserve offset, restore source
    add   A, A          ; 1:4       zx0_depack      copy from literals or new offset?
    jr   nc, ZX0_LIT    ; 2:7/12    zx0_depack
ZX0_NEW_OFF:            ;           zx0_depack      new offset
    pop   BC            ; 1:10      zx0_depack      discard last offset
    ld     C, 0xFE      ; 2:7       zx0_depack      prepare negative offset
    call  ZX0E_LOOP     ; 3:17      zx0_depack      obtain offset MSB
    inc    C            ; 1:4       zx0_depack
    ret    z            ; 1:5/11    zx0_depack      check end marker
    ld     B, C         ; 1:4       zx0_depack
    ld     C,(HL)       ; 1:7       zx0_depack      obtain offset LSB
    inc   HL            ; 1:6       zx0_depack
    rr     B            ; 2:8       zx0_depack      last offset bit becomes first length bit
    rr     C            ; 2:8       zx0_depack
    push  BC            ; 1:11      zx0_depack      preserve new offset
    ld    BC, 0x0001    ; 3:10      zx0_depack      obtain length
    call  nc, ZX0E_BT   ; 3:10/17   zx0_depack
    inc   BC            ; 1:6       zx0_depack
    jr    ZX0_COPY      ; 2:12      zx0_depack

ZX0_ELIAS:              ;           zx0_depack      elias
    inc    C            ; 1:4       zx0_depack      interlaced Elias gamma coding
ZX0E_LOOP:              ;           zx0_depack
    add    A, A         ; 1:4       zx0_depack
    jr    nz, ZX0E_SKIP ; 2:7/12    zx0_depack
    ld     A,(HL)       ; 1:7       zx0_depack      load another group of 8 bits
    inc   HL            ; 1:6       zx0_depack
    rla                 ; 1:4       zx0_depack
ZX0E_SKIP:              ;           zx0_depack
    ret    c            ; 1:5/11    zx0_depack
ZX0E_BT:                ;           zx0_depack      backtrack
    add    A, A         ; 1:4       zx0_depack
    rl     C            ; 2:8       zx0_depack
    rl     B            ; 2:8       zx0_depack
    jr    ZX0E_LOOP     ; 2:12      zx0_depack
; -----------------------------------------------------------------------------
;------------------------------------------------------------------------------
; Print string ending with inverted most significant bit
; In: BC = addr string_imsb
; Out: BC = addr last_char + 1
    rst   0x10          ; 1:11      print_string_i   putchar(reg A) with ZX 48K ROM
PRINT_STRING_I:         ;           print_string_i
    ld    A,(BC)        ; 1:7       print_string_i
    inc  BC             ; 1:6       print_string_i
    or    A             ; 1:4       print_string_i
    jp    p, $-4        ; 3:10      print_string_i
    and  0x7f           ; 2:7       print_string_i
    rst   0x10          ; 1:11      print_string_i   putchar(reg A) with ZX 48K ROM
    ret                 ; 1:10      print_string_i
;==============================================================================
; Print text with 5x8 font
; entry point is "putchar"

MAX_X           equ 51       ; x = 0..50
MAX_Y           equ 24       ; y = 0..23
CURCHL          equ 0x5C51
PRINT_OUT       equ 0x5CBB

set_ink:                ;           putchar   0x10
    ld   HL, self_attr  ; 3:10      putchar
    xor (HL)            ; 1:7       putchar
    and 0x07            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr  set_attr        ; 2:12      putchar

set_paper:              ;           putchar   0x11
    ld   HL, self_attr  ; 3:10      putchar
    add   A, A          ; 1:4       putchar   2x
    add   A, A          ; 1:4       putchar   4x
    add   A, A          ; 1:4       putchar   8x
    xor (HL)            ; 1:7       putchar
    and 0x38            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr  set_attr        ; 2:12      putchar

set_flash:              ;           putchar   0x12
    rra                 ; 1:4       putchar   carry = flash
    ld   HL, self_attr  ; 3:10      putchar
    ld    A,(HL)        ; 1:7       putchar
    adc   A, A          ; 1:4       putchar
    rrca                ; 1:4       putchar
    jr  set_attr        ; 2:12      putchar

set_bright:             ;           putchar   0x13
    ld   HL, self_attr  ; 3:10      putchar
    rrca                ; 1:4       putchar
    rrca                ; 1:4       putchar
    xor (HL)            ; 1:7       putchar
    and 0x40            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr   set_attr       ; 2:12      putchar

set_inverse:            ;           putchar   0x14
    ld   HL, self_attr  ; 3:10      putchar
    ld    A,(HL)        ; 1:7       putchar
    and  0x38           ; 2:7       putchar   A = 00pp p000
    add   A, A          ; 1:4       putchar
    add   A, A          ; 1:4       putchar   A = ppp0 0000
    xor (HL)            ; 1:7       putchar
    and  0xF8           ; 2:7       putchar
    xor (HL)            ; 1:7       putchar   A = ppp0 0iii
    rlca                ; 1:4       putchar
    rlca                ; 1:4       putchar
    rlca                ; 1:4       putchar   A = 00ii ippp
    xor (HL)            ; 1:7       putchar
    and  0x3F           ; 2:7       putchar
    xor (HL)            ; 1:7       putchar   A = fbii ippp

set_attr:               ;           putchar
    ld  (HL),A          ; 1:7       putchar   save new attr
clean_set_0:            ;           putchar
    xor   A             ; 1:4       putchar
clean_set_A:            ;           putchar
    ld  (self_jmp),A    ; 3:13      putchar
    pop  HL             ; 1:10      putchar
    ret                 ; 1:10      putchar

set_over:               ;           putchar   0x15
    jr   clean_set_0    ; 2:12      putchar

set_at:                 ;           putchar   0x16
    ld  (putchar_y),A   ; 3:13      putchar   save new Y
    neg                 ; 2:8       putchar
    add   A, 0x18       ; 2:7       putchar
    ld  (0x5C89),A      ; 3:13      putchar
    ld   A,$+4-jump_from; 2:7       putchar
    jr   clean_set_A    ; 2:12      putchar

set_at_x:               ;           putchar
    ld  (putchar_yx),A  ; 3:13      putchar   save new X
    jr   clean_set_0    ; 2:12      putchar

  if 0
    jr   print_comma    ; 2:12      putchar   0x06
    jr   print_edit     ; 2:12      putchar   0x07
    jr   cursor_left    ; 2:12      putchar   0x08
    jr   cursor_right   ; 2:12      putchar   0x09
    jr   cursor_down    ; 2:12      putchar   0x0A
    jr   cursor_up      ; 2:12      putchar   0x0B
    jr   delete         ; 2:12      putchar   0x0C
    jr   enter          ; 2:12      putchar   0x0D
    jr   not_used       ; 2:12      putchar   0x0E
    jr   not_used       ; 2:12      putchar   0x0F
  endif

tab_spec:               ;           putchar
    jr   set_ink        ; 2:12      putchar   0x10
    jr   set_paper      ; 2:12      putchar   0x11
    jr   set_flash      ; 2:12      putchar   0x12
    jr   set_bright     ; 2:12      putchar   0x13
    jr   set_inverse    ; 2:12      putchar   0x14
    jr   set_over       ; 2:12      putchar   0x15
    jr   set_at         ; 2:12      putchar   0x16
;   jr   set_tab        ; 2:12      putchar   0x17

set_tab:                ;           putchar
    ld   HL,(putchar_yx); 3:16      putchar   load origin cursor
    sub  MAX_X          ; 2:7       putchar
    jr   nc,$-2         ; 2:7/12    putchar
    add   A, MAX_X      ; 2:7       putchar   (new x) mod MAX_X
    cp    L             ; 1:4       putchar
    call  c, next_line  ; 3:10/17   putchar   new x < (old x+1)
set_tab_A               ;           putchar
    ld    L, A          ; 1:4       putchar
    ld  (putchar_yx),HL ; 3:16      putchar   save new cursor
    jr   clean_set_0    ; 2:12      putchar

cursor_left:            ;           putchar   0x08
    ld   HL,(putchar_yx); 3:16      putchar
    inc   L             ; 1:4       putchar
    dec   L             ; 1:4       putchar
    dec  HL             ; 1:6       putchar
    jr   nz, $+4        ; 2:7/12    putchar
    ld    L, MAX_X-1    ; 2:7       putchar
    jr   enter_exit     ; 2:12      putchar

print_comma:            ;           putchar   0x06
    ld   HL,(putchar_yx); 3:16      putchar   H = next Y, L = next X
    ld    A, 17         ; 2:7       putchar
    cp    L             ; 1:4       putchar
    jr   nc, set_tab_A  ; 2:12      putchar
    add   A, A          ; 1:4       putchar
    cp    L             ; 1:4       putchar
    jr   nc, set_tab_A  ; 2:12      putchar
    xor   A             ; 1:4       putchar

enter:                  ;           putchar   0x0D
    call  z, next_line  ; 3:10/17   putchar
enter_exit:             ;           putchar
    ld  (putchar_yx),HL ; 3:16      putchar   save new cursor
    pop  HL             ; 1:10      putchar   load HL
    ret                 ; 3:10


print_edit:             ;           putchar   0x07
cursor_right:           ;           putchar   0x09
cursor_down:            ;           putchar   0x0A
cursor_up:              ;           putchar   0x0B
delete:                 ;           putchar   0x0C
not_used:               ;           putchar   0x0E, 0x0F

print_question          ;           putchar   0x00..0x05 + 0x0E..0x0F + 0x18..0x1F
    ld    A, '?'        ; 2:7       putchar
    jr   print_char_HL  ; 2:7/12    putchar

;------------------------------------------------------------------------------
;  Input: A = char
; Poluttes: AF, AF', DE', BC'
putchar:
    push HL                 ; 1:11
self_jmp    equ $+1
    jr   jump_from          ; 2:7/12    self-modifying
jump_from:
    cp   0xA5               ; 2:7       token 
    jr   nc, print_token    ; 2:7/12

    cp   0x20               ; 2:7
    jr   nc, print_char_HL  ; 2:7/12

    cp   0x06               ; 2:7       comma
    jr    z, print_comma    ; 2:7/12
    cp   0x08               ; 2:7       cursor_left
    jr    z, cursor_left    ; 2:7/12
    cp   0x09               ; 2:7       cursor_right
    jp    z, next_cursor    ; 3:10
    cp   0x0D               ; 2:7       enter
    jr    z, enter          ; 2:7/12

    sub  0x10               ; 2:7       set_ink
    jr    c, print_question ; 2:7/12

    cp   0x08               ; 2:7       >print_tab
    jr   nc, print_question ; 2:7/12

draw_spec:
    add   A,A               ; 1:4       2x
    sub  jump_from-tab_spec ; 2:7
    ld  (self_jmp),A        ; 3:13
draw_spec_exit:             ;
    pop  HL                 ; 1:10
    ret                     ; 1:10

print_token:
    ex   DE, HL             ; 1:4
    ld   DE, 0x0095	        ; 3:10      The base address of the token table
    sub  0xA5               ; 2:7
    push AF                 ; 1:11      Save the code on the stack. (Range +00 to +5A,  to COPY).

; Input
;   A   Message table entry number
;   DE  Message table start address
; Output
;   DE  Address of the first character of message number A
;   F   Carry flag: suppress (set) or allow (reset) a leading space
    call 0x0C41             ; 3:17      THE 'TABLE SEARCH' SUBROUTINE
    ex   DE, HL             ; 1:4

    ld    A,' '             ; 2:7       A 'space' will be printed before the message/token if required (bit 0 of FLAGS reset).
    bit   0,(IY+0x01)       ;
    call  z, print_char     ; 3:17

; The characters of the message/token are printed in turn.

token_loop:
    ld    A,(HL)            ; 1:7       Collect a code.
    and  0x7F               ; 2:7       Cancel any 'inverted bit'.
    call print_char         ; 3:17      Print the character.
    ld    A,(HL)            ; 1:7       Collect the code again.
    inc  HL                 ; 1:6       Advance the pointer.
    add   A, A              ; 1:4       The 'inverted bit' goes to the carry flag and signals the end of the message/token; otherwise jump back.
    jr   nc, token_loop     ; 2:7/12

; Now consider whether a 'trailing space' is required.

    pop  HL                 ; 1:10      For messages, H holds +00; for tokens, H holds +00 to +5A.
    cp   0x48               ; 2:7       Jump forward if the last character was a '$'
    jr    z, $+6            ; 2:7/12
    cp   0x82               ; 2:7       Return if the last character was any other before 'A'.
    jr    c, draw_spec_exit ; 2:7/12
    ld    A, H              ; 1:4       Examine the value in H and return if it indicates a message, , INKEY$ or PI.
    cp   0x03               ; 2:7
    ld    A, ' '            ; 2:7       All other cases will require a 'trailing space'.
    ret   c                 ; 1:5/11
    pop  HL                 ; 1:10
print_char:
    push HL                 ; 1:11    uschovat HL na zásobník
print_char_HL:

    exx                     ; 1:4
    push DE                 ; 1:11    uschovat DE na zásobník
    push BC                 ; 1:11    uschovat BC na zásobník

    push HL                 ; 1:11    uschovat HL na zásobník

    ld    BC, FONT_ADR      ; 3:10    adresa, od níž začínají masky znaků

    add   A, A              ; 1:4
    ld    L, A              ; 1:4     2x
    ld    H, 0x00           ; 1:4     C je nenulové
    add  HL, HL             ; 1:11    4x
    add  HL, BC             ; 1:11    přičíst bázovou adresu masek znaků
    exx                     ; 1:4

;# YX -> ATTR

putchar_yx     equ     $+1
putchar_y      equ     $+2

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

    ld    C, 4          ; 2:7       putchar   draw
putchar_c:              ;           putchar   draw
    exx                 ; 1:4       putchar   draw
    ld    A,(HL)        ; 1:7       putchar   draw
    inc  HL             ; 1:6       putchar   draw
    ld    B, C          ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    djnz  $-1           ; 2:8/13    putchar   draw
    ld    B, A          ; 1:4       putchar   draw
    exx                 ; 1:4       putchar   draw
    ld    B, 2          ; 2:7       putchar   draw
putchar_b:              ;           putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    and   D             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    ld  (HL),A          ; 1:4       putchar   draw   ulozeni jednoho bajtu z masky

    exx                 ; 1:4       putchar   draw
    ld    A, B          ; 1:4       putchar   draw   načtení druhe poloviny "bajtu" z masky
    exx                 ; 1:4       putchar   draw

    inc   L             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    and   E             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    ld  (HL),A          ; 1:4       putchar   draw   ulozeni jednoho bajtu z masky
    dec   L             ; 1:4       putchar   draw
    inc   H             ; 1:4       putchar   draw

    exx                 ; 1:4       putchar   draw
    ld    A, B          ; 1:4       putchar   draw   načtení jednoho bajtu z masky
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    ld    B, A          ; 1:4       putchar   draw
    exx                 ; 1:4       putchar   draw

;     halt

    djnz putchar_b      ; 2:8/13    putchar   draw

    dec   C             ; 2:7       putchar   draw
    jr   nz, putchar_c  ; 2/7/12    putchar   draw


    pop  HL             ; 1:10      putchar   obnovit obsah HL ze zásobníku

    pop  BC             ; 1:10      putchar   obnovit obsah BC ze zásobníku
    pop  DE             ; 1:10      putchar   obnovit obsah DE ze zásobníku
    exx                 ; 1:4       putchar
;   fall to next cursor

; Output: [putchar_yx] = cursor right
next_cursor:            ;
    ld   HL,(putchar_yx); 3:16
; Input: HL = YX
next_cursor_HL:         ;
    inc   L             ; 1:4     0..50
    ld    A, L          ; 1:4
    sub  MAX_X          ; 2:7     -51
    call nc, next_line  ; 3:10/17
next_exit:
    ld  (putchar_yx),HL ; 3:16
exit_hl:                ;
    pop  HL             ; 1:10    obnovit obsah HL ze zásobníku
    ret                 ; 1:10

; Input:
; Output: H = Y+1/Y+0+scroll, L=0
next_line:
    push AF             ; 1:11      putchar
    ld   HL, 0x5C88     ; 3:10      putchar
    ld  (HL), 0x01      ; 2:10      putchar
    ld    A, 0x09       ; 2:7       putchar   cursor_right
    push HL             ; 1:11      putchar
    call 0x09F4         ; 3:17      putchar   rst 0x10 --> call 0x09F4
    ld   HL, putchar    ; 3:10      putchar
    ld  (PRINT_OUT),HL  ; 3:10      putchar
    pop  HL             ; 1:10      putchar
    ld    A, 0x18       ; 2:7       putchar
    inc   L             ; 1:4       putchar
    sub (HL)            ; 1:7       putchar
    ld    H, A          ; 1:7       putchar
    ld    L, 0x00       ; 2:7       putchar
    pop  AF             ; 1:10      putchar
    ret                 ; 1:10      putchar
;# ============================================================================
;# Input: HL = data address
;# Pollutes: AF, HL, DE
PLAY_OCTODE:            ;[:]        play_octode
    ld    E,(HL)        ; 1:7       play_octode
    inc  HL             ; 1:6       play_octode
    ld    D,(HL)        ; 1:7       play_octode     DE = addr loop
    inc  HL             ; 1:6       play_octode     HL = addr data
    ld  (seqpntr),HL    ; 3:16      play_octode     set addr song start
    ld  (nameloop),DE   ; 4:20      play_octode     set addr song loop
    xor   A             ; 1:4       play_octode
    in    A,(0xFE)      ; 2:11      play_octode     read kbd
    or  0xE0            ; 2:7       play_octode
    inc   A             ; 1:4       play_octode
    jr   nz, $-6        ; 2:7/12    play_octode     wait until no presss
    exx                 ; 1:4       play_octode
    push HL             ; 1:11      play_octode
    push IX             ; 2:15      play_octode
    push IY             ; 2:15      play_octode
    call OCTODE2K16_ROUTINE; 3:17      play_octode
    pop  IY             ; 2:14      play_octode
    pop  IX             ; 2:14      play_octode
    pop  HL             ; 1:10      play_octode
    exx                 ; 1:4       play_octode
    ret                 ; 1:10      play_octode
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
string123:
    db 0x0D, "Depth:"," " + 0x80
size123              EQU $ - string123
string122   EQU  string111
size122     EQU    size111
string121   EQU  string110
size121     EQU    size110
string120   EQU  string109
size120     EQU    size109
string119   EQU  string108
size119     EQU    size108
string118   EQU  string107
size118     EQU    size107
string117   EQU  string106
size117     EQU    size106
string116   EQU  string105
size116     EQU    size105
string115   EQU  string104
size115     EQU    size104
string114   EQU  string103
size114     EQU    size103
string113   EQU  string102
size113     EQU    size102
string112:
    db ZX_INK, ZX_RED + 0x80
size112              EQU $ - string112
string111:
    db ZX_AT,text_y-9,text_x," 9: _first_last_"," " + 0x80
size111              EQU $ - string111
string110:
    db ZX_AT,text_y-8,text_x," 8: cja_h_what_is_love"," " + 0x80
size110              EQU $ - string110
string109:
    db ZX_AT,text_y-7,text_x," 7: bacon_sandwich"," " + 0x80
size109              EQU $ - string109
string108:
    db ZX_AT,text_y-6,text_x," 6: algar_thegermansroom"," " + 0x80
size108              EQU $ - string108
string107:
    db ZX_AT,text_y-5,text_x," 5: pd_dawn"," " + 0x80
size107              EQU $ - string107
string106:
    db ZX_AT,text_y-4,text_x," 4: alf2_zalza"," " + 0x80
size106              EQU $ - string106
string105:
    db ZX_AT,text_y-3,text_x," 3: octode2k16 test"," " + 0x80
size105              EQU $ - string105
string104:
    db ZX_AT,text_y-2,text_x," 2: octode2k15 test"," " + 0x80
size104              EQU $ - string104
string103:
    db ZX_AT,text_y-1,text_x," 1: octode     test"," " + 0x80
size103              EQU $ - string103
string102:
    db ZX_AT,text_y-0,text_x," 0: exit"," " + 0x80
size102              EQU $ - string102
string101:
    db ZX_INK, ZX_BLUE, ZX_PAPER, ZX_BLACK + 0x80
size101              EQU $ - string101


VARIABLE_SECTION:

__file_octode:          ;           variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay
    incbin ../Compression/Output/octode.zx0
                        ;289:0      variablebinfile(../Compression/Output/,octode,.zx0) unpack bufferplay
__file_octode2k15:      ;           variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay
    incbin ../Compression/Output/octode2k15.zx0
                        ;335:0      variablebinfile(../Compression/Output/,octode2k15,.zx0) unpack bufferplay
__file_octode2k16:      ;           variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay
    incbin ../Compression/Output/octode2k16.zx0
                        ;1256:0     variablebinfile(../Compression/Output/,octode2k16,.zx0) unpack bufferplay
__file_alf2_zalza:      ;           variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay
    incbin ../Compression/Output/alf2_zalza.zx0
                        ;1212:0     variablebinfile(../Compression/Output/,alf2_zalza,.zx0) unpack bufferplay
__file_pd_dawn:         ;           variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay
    incbin ../Compression/Output/pd_dawn.zx0
                        ;1760:0     variablebinfile(../Compression/Output/,pd_dawn,.zx0) unpack bufferplay
__file_algar_thegermansroom:;       variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay
    incbin ../Compression/Output/algar_thegermansroom.zx0
                        ;3874:0     variablebinfile(../Compression/Output/,algar_thegermansroom,.zx0) unpack bufferplay
__file_bacon_sandwich:  ;           variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay
    incbin ../Compression/Output/bacon_sandwich.zx0
                        ;2018:0     variablebinfile(../Compression/Output/,bacon_sandwich,.zx0) unpack bufferplay
__file_cja_h_what_is_love:;         variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay
    incbin ../Compression/Output/cja_h_what_is_love.zx0
                        ;1948:0     variablebinfile(../Compression/Output/,cja_h_what_is_love,.zx0) unpack bufferplay
__file__first_last_:    ;           variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay
    incbin ../Compression/Output/_first_last_.zx0
                        ;2003:0     variablebinfile(../Compression/Output/,_first_last_,.zx0) unpack bufferplay

;# ============================================================================
;# Octode 2k16 play routine
include ../M4/../octode2k16/octode2k16.asm

;# ============================================================================
  if ($>__BUFFER)
    .error Buffer overwrites previous data!
  endif
    ORG __BUFFER
BUFFERPLAY:
BUFFERPLAY_END       equ   BUFFERPLAY+14581
  if (BUFFERPLAY_END<BUFFERPLAY)
    if (BUFFERPLAY_END>=0x8000)
        .error Buffer overflow 64k! over 32768..65535 bytes
    endif
    if (BUFFERPLAY_END>=0x4000)
        .error Buffer overflow 64k! over 16384..32767 bytes
    endif
    if (BUFFERPLAY_END>=0x2000)
        .error Buffer overflow 64k! over 8192..16383 bytes
    endif
    if (BUFFERPLAY_END>=0x1000)
        .error Buffer overflow 64k! over 4096..8191 bytes
    endif
    if (BUFFERPLAY_END>=0x0800)
        .error Buffer overflow 64k! over 2048..4095 bytes
    endif
    if (BUFFERPLAY_END>=0x0400)
        .error Buffer overflow 64k! over 1024..2047 bytes
    endif
    if (BUFFERPLAY_END>=0x0200)
        .error Buffer overflow 64k! over 512..1023 bytes
    endif
    if (BUFFERPLAY_END>=0x0100)
        .error Buffer overflow 64k! over 256..511 bytes
    endif
    .error Buffer overflow 64k! over 0..255 bytes
  endif
  if (BUFFERPLAY_END>0xFF00)
    .warning Buffer BUFFERPLAY rewrite 0xFF00+ address!
  endif

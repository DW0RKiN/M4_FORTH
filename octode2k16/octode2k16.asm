;******************************************************************
;* octode 2k16                                                    *
;* 8ch beeper engine by utz 05'2016                               *
;* www.irrlichtproject.de                                         *
;******************************************************************

;         SP - set to start of current buffer/ptn row
;(addBuffer) - add cntr 1-3
;         DE - add cntr 4
;         HL - accu 1-3, jump val
;        HL' - add cntr 5
;        DE' - add cntr 6
;     BC/BC' - base counters
;        IX  - add cntr 7
;        IY  - add cntr 8
;         A  - vol.add
;       A',I - timer

NMOS EQU 1
CMOS EQU 2

OUT_C_B     equ 0x41ed  ; out (C),B    ; 2:12
OUT_C_0x00  equ 0x71ed  ; out (C),0x00 ; 2:12

  if 1
; Z80=NMOS              ; values for NMOS Z80
PCTRL       equ 0x10fe
PCTRL_B     equ 0x10
  else
; Z80=CMOS              ; values for CMOS Z80
PCTRL       equ 0x00fe
PCTRL_B     equ 0x00
  endif

; Input:
; (seqpntr)  = address music data (name_xm_start)
; (nameloop) = address music loop (name_xm_loop)

;   dw name_xm_loop

; name_xm_start:
;   dw name_xm_ptn0
;   dw name_xm_ptn1
; name_xm_loop:
;   dw name_xm_ptn2
;   ...
;
; name_xm_ptn0:
;   dw 0x480
;   dw 0x0020
;   dw name_xm_row0
;
;   dw 0x480
;   dw 0x0040
;   dw name_xm_row1
;   ...
; name_xm_ptn1:
;   ...

;	dw 0x480
;	dw 0x0080
;	dw name_xm_row2

; row buffers
; name_xm_rows equ name_xm + 0x5ba
; name_xm_row0 equ name_xm_rows + 0x0
;   dw 0x0
;   dw 0x17f9
;   dw 0x4c2
;   dw 0x0
;   dw 0x0
;   dw 0x1307
;   dw 0x1307
;   dw 0x2000

; name_xm_row1 equ name_xm_rows + 0x10
;   ...

OCTODE2K16_ROUTINE:
  if (OCTODE2K16_ROUTINE<0x1000)
    .warning The routine OCTODE2K16_ROUTINE address < 0x1000! You are probably over 64kb. Must be 0x8000+.
  endif
  if (OCTODE2K16_ROUTINE<0x2000)
    .warning The routine OCTODE2K16_ROUTINE address < 0x2000! You are probably over 64kb. Must be 0x8000+.
  endif
  if (OCTODE2K16_ROUTINE<0x3000)
    .warning The routine OCTODE2K16_ROUTINE address < 0x3000! You are probably over 64kb. Must be 0x8000+.
  endif
  if (OCTODE2K16_ROUTINE<0x4000)
    .warning The routine OCTODE2K16_ROUTINE address < 0x4000! You are probably over 64kb. Must be 0x8000+.
  endif
  if (OCTODE2K16_ROUTINE<0x5000)
    .warning The routine OCTODE2K16_ROUTINE address < 0x5000! Must be 0x8000+.
  endif
  if (OCTODE2K16_ROUTINE<0x6000)
    .warning The routine OCTODE2K16_ROUTINE address < 0x6000! Must be 0x8000+.
  endif
  if (OCTODE2K16_ROUTINE<0x7000)
    .warning The routine OCTODE2K16_ROUTINE address < 0x7000! Must be 0x8000+.
  endif
  if (OCTODE2K16_ROUTINE<0x8000)
    .warning The routine OCTODE2K16_ROUTINE address < 0x8000! Must be 0x8000+.
  endif
    ei                  ; 1:4       detect kempston
    halt                ; 1:4
    in    A,(0x1F)      ; 2:11
    inc   A             ; 1:4
    jr   nz, _skip      ; 2:7/12
    ld (maskKempston),A ; 3:13
_skip:                  ;
    di                  ; 1:4
    ld  (oldSP),SP      ; 4:20

;******************************************************************
rdseq:
;   iiii dd, ss         ; b:tt      ...
seqpntr equ $+1
    ld   SP, 0x0000     ; 3:10      ...
;     xor   A             ; 1:4       ...
    pop  HL             ; 1:10      pattern pointer to HL
;     or    H             ; 1:4
    inc   H             ; 1:4
    dec   H             ; 1:4
    ld  (seqpntr),SP    ; 4:20      ...
    jr   nz, rdptn0     ; 2:7/12    ...
  ifdef __NO_LOOP_MUSIC
    jp   exit           ; 3:10      ...
  endif
  ifdef __LIMITED_TIMES_LOOP_MUSIC
    dec   L             ; 1:4
    push HL             ; 1:11
    pop  HL             ; 1:10
    jr    z, exit       ; 2:7/12    ...
  endif
nameloop equ $+1
    ld   SP, 0x0000     ; 3:10      get loop point
    jr   rdseq+3        ; 2:12

;******************************************************************
updateTimer0:
;   iiii dd, ss         ; b:tt      ...
    nop                 ; 1:4       ...
    dw OUT_C_0x00       ; 2:12      switch sound off
updateTimer:
    ld    A, I          ; 2:9
    dec   A             ; 1:4
    jp    z, readNextRow; 3:10      ...
    ld    I, A          ; 2:9
    xor   A             ; 1:4
    ex   AF, AF'        ; 1:4
    jp  (HL)            ; 1:4
    ;. . . . . . . . . ;[11:44]     TODO: adjust timings!
                
updateTimerX:
    ld    A, I          ; 2:9
    dec   A             ; 1:4
    jp    z, readNextRow; 3:10      ...
    ld    I, A          ; 2:9
    xor   A             ; 1:4
    ex   AF, AF'        ; 1:4
    ld    A,(HL)        ; 1:7       timing
    ;----------------- ;[11:47]
    dw OUT_C_0x00       ; 2:12      switch sound off
    xor   A             ; 1:4
    nop                 ; 1:4       
    jp  (HL)            ; 1:4
                
addBuffer:
    dw   0x0000         ; 2:0       ch1 accu
    dw   0x0000         ; 2:0       ch2 accu
    dw   0x0000         ; 2:0       ch3 accu

;******************************************************************
exit:
;   iiii dd, ss         ; b:tt      ...
oldSP equ $+1
    ld   SP, 0x0000     ; 3:10      ...
    ei                  ; 1:4
    ret                 ; 1:10
;******************************************************************

rdptn0:
    ld  (patpntr),HL    ; 3:16      ...
;   iiii dd, ss         ; b:tt      ...
readNextRow:
    in    A,(0x1f)      ; 2:11      read joystick
maskKempston equ $+1
    and  0x1F           ; 2:7
    ld    C, A          ; 1:4
    in    A,(0xFE)      ; 2:11      read kbd
    cpl                 ; 1:4
    or    C             ; 1:4
    and  0x1F           ; 2:7
    jp   nz, exit       ; 3:10      ...

    ld   DE, 0x0000     ; 3:10      clear add counters 1-4
    ld   SP, addBuffer+6; 3:10      ...
    push DE             ; 3:10
    push DE             ; 3:10
    push DE             ; 3:10

patpntr equ $+1         ;           fetch pointer to pattern data
    ld   SP, 0x0000     ; 3:10      ...

    pop  AF             ; 1:10      ...
    jr    z, rdseq      ; 2:7/12    ...
    
    ld    I, A          ; 2:9       timer
    
    jr    c, drumNoise  ; 2:7/12    ...
    jp   pe, drumKick   ; 3:10      ...
    jp    m, drumSnare  ; 3:10      ...
;   iiii dd, ss         ; b:tt      ...
drumRet:
        
    pop  HL             ; 1:10      fetch row buffer addr
    
    ld (patpntr),sp
    
    ld sp,hl        ;row buffer addr -> SP
    
    xor   A             ; 1:4       timer lo
    exx                 ; 1:4
    ld    H, A          ; 1:4       clear add counters 5-8
    ld    L, A          ; 1:4       ...
    ld    D, A          ; 1:4       ...
    ld    E, A          ; 1:4       ...
    ld   ix, 0x0000     ; 4:14      ...
    ld   iy, 0x0000     ; 4:14      ...
    exx                 ; 1:4
    
    ex   AF, AF'        ; 1:4       ...
    xor   A             ; 1:4       ...
    ld   BC, PCTRL      ; 3:10      0x10fe
    jp  core0           ; 3:10      ...

;   iiii dd, ss         ; b:tt      ...
drumNoise:    
    ld   HL, 0x35D1     ; 3:10      ...
drumX:
    ex   DE, HL         ; 1:4       DE = 0, so now HL = 0
    pop  BC             ; 1:10      duty in C, B = 0

;   iiii dd, ss         ; b:tt      ...
_dlp:
    add  HL, DE         ; 1:11      ...
    ld    A, H          ; 1:4       ...
    cp    C             ; 1:4
    sbc   A, A          ; 1:4
    and  0x10           ; 2:7
    out (0xfe),A        ; 2:11
    rlc   H             ; 2:8
    djnz _dlp           ; 2:13/8 - 62*256 = 15872
    
    ld    D, B          ; 1:4       reset DE
    ld    E, B          ; 1:4
    ld    A, 0xD6       ; 2:7       adjust row length
    ex   AF, AF'        ; 1:4
    jp   drumRet        ; 3:10
                        ;[15933/15943] ~ 41,5 sound loop iterations
;   iiii dd, ss         ; b:tt      ...
drumKick:
    ld   HL, 0x0001     ; 3:10      ...
    jr   drumX          ; 2:12      ...
;   iiii dd, ss         ; b:tt      ...
drumSnare:
    ld   HL, 0x0005     ; 3:10
    jr   drumX          ; 2:12      ...

;*********************************************************************************************
if (low($))!=0
    org 256*(1+(high($)))
endif
;   iiii dd, ss         ; b:tt      ...
core0:                  ;           volume 0, 0t
basec equ high($)
    ;----------------- ;[  :0]
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu
    rl    H             ; 2:8       rotate bit 7 into volume accu
    rla                 ; 1:4       ...
    
    ld  HL,(addBuffer+2); 3:16      as above, for ch2
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ld  HL,(addBuffer+4); 3:16      as above for ch3
    
    ld    C, 0xFE       ; 2:7       ...
    ds 3                ; 3:12
    
    ret   c             ; 1:5       timing, branch never taken
    ld    B, PCTRL_B    ; 2:7       B = 0x10
    ;----------------- ;[36:192]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

;   iiii dd, ss         ; b:tt      ...
    ex   DE, HL         ; 1:4       DE is ch4 accu
    pop  BC             ; 1:10      add base freq as usual
    add  HL, BC         ; 1:11
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    exx                 ; 1:4       ...

    pop  BC             ; 1:10      get base freq ch5
    add  HL, BC         ; 1:11      HL' is ch5 accu
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
        
    ld    R, A          ; 1:9       timing
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;----------------- ;[30:168]

    dw OUT_C_0x00       ; 2:12      switch sound off

    adc   A, 0x00       ; 2:7       ...
    ret   c             ; 1:5/11    timing
    ;----------------- ;[35:192]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ex   DE, HL         ; 1:4       ... 
    
    pop  BC             ; 1:10
    add  IX, BC         ; 2:15      IX is accu ch7
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ret   c             ; 1:5/11    timing
    
    pop  BC             ; 1:10    
    add  IY, BC         ; 2:15      IY is accu ch8    
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    
    exx                 ; 1:4       ...
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;----------------- ;[32:168]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    ex   AF, AF'        ; 1:4
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    ;----------------- ;[37:192]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    
;   iiii dd, ss         ; b:tt      ...
    adc   A, 0x00       ; 2:7       ...

    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex  (SP),HL         ; 1:19      timing
    ex  (SP),HL         ; 1:19      timing
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    dec   A             ; 1:4
    jp    z,updateTimer ; 3:10      and update if necessary
    ret   z             ; 1:5/11    timing
    ex   AF, AF'        ; 1:4
    
    ex  (SP),HL         ; 1:19      timing
    ex  (SP),HL         ; 1:19      timing
    ;----------------- ;[25:168]

    dw OUT_C_0x00       ; 2:12      switch sound off
        
    ds 2                ; 2:8       timing
    jp  (HL)            ; 1:4       jump to next frame
    ;----------------- ;[30:192]
                      ;[138:768]

;*********************************************************************************************
    org 256*(1+(high($)))
;   iiii dd, ss         ; b:tt      ...
core1:                  ;           vol 1 - 24t
    ;+++++++++++++++++ ;[  :0]
    dw OUT_C_B          ; 2:12      switch sound on
    ex   AF, AF'        ; 1:4       update timer
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    ;-----------------  ;[5:24]
    
    dw OUT_C_0x00       ; 2:12      switch sound off

    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu
    rl    H             ; 2:8       rotate bit 7 into volume accu
    rla                 ; 1:4       ...
    
    ld  HL,(addBuffer+2); 3:16      as above, for ch2
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ret   c             ; 1:5       timing, branch never taken
    ds 2                ; 2:8       timing
    
    ld   BC, PCTRL      ; 3:10      BC = 0x10fe
    ;+++++++++++++++++ ;[36:192]
    
    dw OUT_C_B          ; 2:12      sound on
    ex   AF, AF'        ; 1:4       update timer again (for better speed control)
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    ;-----------------  ;[5:24]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    ld  HL,(addBuffer+4); 3:16      as above for ch3
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    ex   DE, HL         ; 1:4       DE is ch4 accu
    pop  BC             ; 1:10      add base freq as usual
    add  HL, BC         ; 1:11
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ret   c             ; 1:5       timing, branch never taken
    
    exx                 ; 1:4       ...
    pop  BC             ; 1:10      get base freq ch5
    add  HL, BC         ; 1:11      HL' is ch5 accu
    
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[35:192]
    
    dw OUT_C_B          ; 2:12      ...
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    ;-----------------  ;[5:24]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    adc   A, 0x00       ; 2:7       ...
    
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ex   DE, HL         ; 1:4       ... 
    pop  BC             ; 1:10
    add  IX, BC         ; 2:15      IX is accu ch7
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    pop  BC             ; 1:10
    add  IY, BC         ; 2:15      IY is accu ch8
    
    exx                 ; 1:4       ...
    ld   BC, PCTRL      ; 3:10      0x10fe
    ld   BC, PCTRL      ; 3:10      timing
    nop                 ; 1:4       
    ;+++++++++++++++++ ;[38:192]
    
    dw OUT_C_B          ; 2:12      ...
    ds 3                ; 3:12      timing
    ;-----------------  ;[5:24]

    dw OUT_C_0x00       ; 2:12      switch sound off
    
    exx                 ; 1:4       ...
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    exx                 ; 1:4       ...
    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    
    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    
    ld    A,(HL)        ; 2:7       timing
    ld    A,(HL)        ; 2:7       timing
    ld    A,(HL)        ; 2:7       timing
    nop                 ; 1:4       timing
    
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    jp    z, updateTimer; 3:10      and update if necessary
    ex   AF, AF'        ; 1:4
    
    ds 8                ; 8:32      timing (to match updateTimer length)
    
    jp  (HL)            ; 1:4       jump to next frame
    ;. . . . . . . . . ;[46:192]
                      ;[155:768]
    
;*********************************************************************************************
    org 256*(1+(high($)))
;   iiii dd, ss         ; b:tt      ...
core2:                  ;           vol 2 - 48t
    ;+++++++++++++++++ ;[  :0]
    dw OUT_C_B          ; 2:12      switch sound on
    ex   AF, AF'        ; 1:4       update timer
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    ds 2                ; 2:8       timing
    ;----------------- ;[10:48]
    
    dw OUT_C_0x00       ; 2:12      switch sound off

    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu
    rl    H             ; 2:8       rotate bit 7 into volume accu
    rla                 ; 1:4       ...
    
    ld  HL,(addBuffer+2); 3:16      as above, for ch2
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ret   c             ; 1:5       timing, branch never taken
    
    ld   BC, PCTRL      ; 3:10      BC = 0x10fe
    ;+++++++++++++++++ ;[36:192]
    
    dw OUT_C_B          ; 2:12      sound on
    ex   AF, AF'        ; 1:4       update timer again (for better speed control)
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    ld  HL,(addBuffer+4); 3:16      as above for ch3
    ds 2                ; 2:8       timing
    ;----------------- ;[10:48]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    ex   DE, HL         ; 1:4       DE is ch4 accu
    pop  BC             ; 1:10      add base freq as usual
    add  HL, BC         ; 1:11
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    nop                 ; 1:4       timing    
    exx                 ; 1:4       ...
    pop  BC             ; 1:10      get base freq ch5
    exx                 ; 1:4       ...
    
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[37:192]
    
    dw OUT_C_B          ; 2:12      ...
    exx                 ; 1:4       ...
    add  HL, BC         ; 1:11      HL' is ch5 accu
    ld    B, H          ; 1:4       ...
    ld    R, A          ; 1:9       timing
    nop                 ; 1:4       
    exx                 ; 1:4       ...
    ;-----------------  ;[8:48]

    dw OUT_C_0x00       ; 2:12      switch sound off
    
    exx                 ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ex   DE, HL         ; 1:4       ... 
    pop  BC             ; 1:10
    add  IX, BC         ; 2:15      IX is accu ch7
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    
    exx                 ; 1:4       ...
    ld   BC, PCTRL      ; 3:10      0x10fe
    ld   BC, PCTRL      ; 3:10      timing
    ;+++++++++++++++++ ;[38:192]
    
    dw OUT_C_B          ; 2:12      ...
    exx                 ; 1:4       ...
    
    adc   A, 0x00       ; 2:7       ...
    ld    B,(HL)        ; 1:7       timing
    nop                 ; 1:4       
    pop  BC             ; 1:10
    
    exx                 ; 1:4       ...
    ;-----------------  ;[9:48]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    exx                 ; 1:4       ...
        
    add  IY, BC         ; 2:15      IY is accu ch8
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    exx                 ; 1:4       ...
    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    
    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    jp    z,updateTimer ; 3:10      and update if necessary
    ex   AF, AF'        ; 1:4
    
    ld    A,(HL)        ; 2:7       timing
    ld    A,(HL)        ; 2:7       timing
    xor   A             ; 1:4
    
    jp  (HL)            ; 1:4       jump to next frame
    ;. . . . . . . . . ;[42:192]
                      ;[153:768]
   
;*********************************************************************************************
    org 256*(1+(high($)))
;   iiii dd, ss         ; b:tt      ...
core3:                  ;           vol 3 - 72t
    ;+++++++++++++++++ ;[  :0]
    dw OUT_C_B          ; 2:12      switch sound on

    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu
    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[  :72]
    dw OUT_C_0x00       ; 2:12      switch sound off

    rl    H             ; 2:8       rotate bit 7 into volume accu
    rla                 ; 1:4       ...
    
    ld  HL,(addBuffer+2); 3:16      as above, for ch2
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ex   AF, AF'        ; 1:4       update timer
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    inc  BC             ; 1:6       timing 
    
    ld   BC, PCTRL      ; 3:10      BC = 0x10fe
    ;+++++++++++++++++ ;[  :192]
    
    dw OUT_C_B          ; 2:12      sound on

    ld  HL,(addBuffer+4); 3:16      as above for ch3
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    
    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[  :72]

    dw OUT_C_0x00       ; 2:12      switch sound off
    
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    ex   DE, HL         ; 1:4       DE is ch4 accu
    pop  BC             ; 1:10      add base freq as usual
    add  HL, BC         ; 1:11
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    exx                 ; 1:4       ...
    pop  BC             ; 1:10      get base freq ch5
    add  HL, BC         ; 1:11      HL' is ch5 accu
    exx                 ; 1:4       ...
    
    inc  BC             ; 1:6       timing
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[  :192]
    
    dw OUT_C_B          ; 2:12      ...
    exx                 ; 1:4       ...
    
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    nop                 ; 1:4       
    
    exx                 ; 1:4       ...
    ;----------------- ;[  :72]
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    exx                 ; 1:4       ...
    
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ex   DE, HL         ; 1:4       ... 
    pop  BC             ; 1:10      get base freq ch7
    add  IX, BC         ; 2:15      IX is accu ch7
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    pop  BC             ; 1:10      get base freq ch8
    
    exx                 ; 1:4       ...
    ld    B,(HL)        ; 1:7       timing
    inc  BC             ; 1:6       timing
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[  :192]
    
    dw OUT_C_B          ; 2:12      ...
    exx                 ; 1:4       ...
    
    add  IY, BC         ; 2:15      IY is accu ch8
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    nop                 ; 1:4       
    
    exx                 ; 1:4       ...
    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    ;----------------- ;[  :72]
    
    dw OUT_C_0x00       ; 2:12      switch sound off

    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    
    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    
    ld    A,(HL)        ; 2:7       timing
    ld    A,(HL)        ; 2:7       timing
    
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    dec   A             ; 1:4
    jp    z,updateTimer ; 3:10      and update if necessary
    ex   AF, AF'        ; 1:4
    
    ds 8                ; 8:32      timing (to match updateTimer length)
    
    jp  (HL)            ; 1:4       jump to next frame
    ;. . . . . . . . . ;[  :192]
    
    
;*********************************************************************************************
    org 256*(1+(high($)))
;   iiii dd, ss         ; b:tt      ...
core4:                  ;           vol 4 - 96t
    ;+++++++++++++++++ ;[  :0]
    dw OUT_C_B          ; 2:12      switch sound on

    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu

    rl    H             ; 2:8       rotate bit 7 into volume accu
    ld  HL,(addBuffer+2); 3:16      as above, for ch2

    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[  :96]
    
    dw OUT_C_0x00       ; 2:12      switch sound off

    rla                 ; 1:4       ...
        
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ex   AF, AF'        ; 1:4       update timer
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    inc  BC             ; 1:6       timing 
    
    ld   BC, PCTRL      ; 3:10      BC = 0x10fe
    ;+++++++++++++++++ ;[  :192]
    
    dw OUT_C_B          ; 2:12      sound on

    ld  HL,(addBuffer+4); 3:16      as above for ch3
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ret   c             ; 1:5/11    timing

    ex   DE, HL         ; 1:4       DE is ch4 accu
    
    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[  :96]

    dw OUT_C_0x00       ; 2:12      switch sound off
        
    pop  BC             ; 1:10      add base freq as usual
    add  HL, BC         ; 1:11
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    exx                 ; 1:4       ...
    pop  BC             ; 1:10      get base freq ch5
    
    exx                 ; 1:4       ...    
    inc  BC             ; 1:6       timing
    inc  BC             ; 1:6       timing
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[  :192]
    
    dw OUT_C_B          ; 2:12      ...
    exx                 ; 1:4       ...
    
    add  HL, BC         ; 1:11      HL' is ch5 accu
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    ld    R, A          ; 1:9       ...
    
    exx                 ; 1:4       ...
    ;----------------- ;[  :96]

    dw OUT_C_0x00       ; 2:12      switch sound off
    exx                 ; 1:4       ...
    
    adc   A, 0x00       ; 2:7       ...
    
    ex   DE, HL         ; 1:4       ... 
    pop  BC             ; 1:10
    add  IX, BC         ; 2:15      IX is accu ch7
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    nop                 ; 1:4       
    
    pop  BC             ; 1:10
    
    exx                 ; 1:4       ...
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[  :192]
    
    dw OUT_C_B          ; 2:12      ...
    exx                 ; 1:4       ...
    
    adc   A, 0x00       ; 2:7       ...
    
    add  IY, BC         ; 2:15      IY is accu ch8
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    exx                 ; 1:4       ...
    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    nop                 ; 1:4       
    ;----------------- ;[  :96]

    dw OUT_C_0x00       ; 2:12      switch sound off

    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    
    ld    A,(HL)        ; 2:7       timing
    
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    dec   A             ; 1:4
    jp    z, updateTimer; 3:10      and update if necessary
    ex   AF, AF'        ; 1:4
    
    ds 8                ; 8:32      timing (to match updateTimer length)
    
    jp  (HL)            ; 1:4       jump to next frame
    ;. . . . . . . . . ;[  :192]
    
;*********************************************************************************************
    org 256*(1+(high($)))
;   iiii dd, ss         ; b:tt      ...
core5:                  ;           vol 5 - 120t
    ;+++++++++++++++++ ;[  :0]
    dw OUT_C_B          ; 2:12      switch sound on

    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu
    rl    H             ; 2:8       rotate bit 7 into volume accu
    rla                 ; 1:4       ...
    
    ld  HL,(addBuffer+2); 3:16      as above, for ch2

    ds 5                ; 5:20      timing

    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[  :120]

    dw OUT_C_0x00       ; 2:12      switch sound off

    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    
    ld    R, A          ; 1:9       timing
    nop                 ; 1:4       
    
    ld   BC, PCTRL      ; 3:10      BC = 0x10fe
    ;+++++++++++++++++ ;[  :192]

    dw OUT_C_B          ; 2:12      switch sound on

    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ld  HL,(addBuffer+4); 3:16      as above for ch3
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    ex   DE, HL         ; 1:4       DE is ch4 accu
    
    ld    B,(HL)        ; 1:7       timing
    ld    B,(HL)        ; 1:7       timing
    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[  :120]

    dw OUT_C_0x00       ; 2:12      switch sound off
        
    pop  BC             ; 1:10      add base freq as usual
    add  HL, BC         ; 1:11
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    inc  BC             ; 1:6       timing
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[  :192]

    dw OUT_C_B          ; 2:12      switch sound on
    exx                 ; 1:4       ...
        
    pop  BC             ; 1:10      get base freq ch5
    add  HL, BC         ; 1:11      HL' is ch5 accu
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    inc  BC             ; 1:6       timing
    pop  BC             ; 1:10
    exx                 ; 1:4       ...
    ;----------------- ;[  :120]

    dw OUT_C_0x00       ; 2:12      switch sound off
    exx                 ; 1:4       ...
    
    ex   DE, HL         ; 1:4       ... 
    
    add  IX, BC         ; 2:15      IX is accu ch7
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    pop  BC             ; 1:10
    
    exx                 ; 1:4       ...
    ;+++++++++++++++++ ;[  :192]

    dw OUT_C_B          ; 2:12      switch sound on
    exx                 ; 1:4       ...
        
    add  IY, BC         ; 2:15      IY is accu ch8
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    exx                 ; 1:4       ...

    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    dec   A             ; 1:4
    dec   A             ; 1:4
    nop                 ; 1:4       
    ;----------------- ;[  :120]    
    
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    ld   BC, PCTRL      ; 3:10      not necessary, just for timing
        
    jp    z, updateTimer; 3:10      and update if necessary
    ex   AF, AF'        ; 1:4
    
    ds 8                ; 8:32      timing (to match updateTimer length)
    
    jp  (HL)            ; 1:4       jump to next frame
    ;. . . . . . . . . ;[  :192]
        

;*********************************************************************************************
    org 256*(1+(high($)))
;   iiii dd, ss         ; b:tt      ...
core6:                  ;           vol 6 - 144t
    ;+++++++++++++++++ ;[  :0]
    dw OUT_C_B          ; 2:12      switch sound on

    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu
    rl    H             ; 2:8       rotate bit 7 into volume accu
    rla                 ; 1:4       ...
    
    ld  HL,(addBuffer+2); 3:16      as above, for ch2
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    
    ld    C,(HL)        ; 1:7       timing
    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[  :144] 

    dw OUT_C_0x00       ; 2:12      switch sound off
    
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ld    B,(HL)        ; 1:7       timing
    nop                 ; 1:4               
    ld   BC, PCTRL      ; 3:10      BC = 0x10fe
    ;+++++++++++++++++ ;[  :192]

    dw OUT_C_B          ; 2:12      switch sound on
    
    ld  HL,(addBuffer+4); 3:16      as above for ch3
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    ex   DE, HL         ; 1:4       DE is ch4 accu
    pop  BC             ; 1:10      add base freq as usual
    add  HL, BC         ; 1:11
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ld    R, A          ; 1:9       timing
    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[  :144]

    dw OUT_C_0x00       ; 2:12      switch sound off
        
    
    ld    B,(HL)        ; 1:7       timing    
    ld    B,(HL)        ; 1:7       timing
    ds 3                ; 3:12      timing

    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[  :192]

    dw OUT_C_B          ; 2:12      switch sound on
    exx                 ; 1:4       ...
        
    pop  BC             ; 1:10      get base freq ch5
    add  HL, BC         ; 1:11      HL' is ch5 accu
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ex   DE, HL         ; 1:4       ... 
    
    pop  BC             ; 1:10
    add  IX, BC         ; 2:15      IX is accu ch7
    
    ld    B,(HL)        ; 1:7       timing
    nop                 ; 1:4       
    
    exx                 ; 1:4       ...
    ;----------------- ;[  :144]

    dw OUT_C_0x00       ; 2:12      switch sound off
    exx                 ; 1:4       ...
    
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ret   c             ; 1:5/11    timing
    
    exx                 ; 1:4       ...
    ;+++++++++++++++++ ;[  :192]

    dw OUT_C_B          ; 2:12      switch sound on
    exx                 ; 1:4       ...
    
    pop  BC             ; 1:10    
    add  IY, BC         ; 2:15      IY is accu ch8
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    exx                 ; 1:4       ...
    
    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    dec   A             ; 1:4
    dec   A             ; 1:4
    nop                 ; 1:4       
    jp    z,updateTimer0; 3:10      and update if necessary
    ex   AF, AF'        ; 1:4
    ;----------------- ;[  :144]

    dw OUT_C_0x00       ; 2:12      switch sound off
        
    ds 8                ; 8:32      timing (to match updateTimer length)
    
    jp  (HL)            ; 1:4       jump to next frame
    ;. . . . . . . . . ;[  :192]


;*********************************************************************************************
    org 256*(1+(high($)))
;   iiii dd, ss         ; b:tt      ...
core7:                  ;           vol 7 - 168t
    ;+++++++++++++++++ ;[  :0]
    dw OUT_C_B          ; 2:12      switch sound on

    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu
    rl    H             ; 2:8       rotate bit 7 into volume accu
    rla                 ; 1:4       ...
    
    ld  HL,(addBuffer+2); 3:16      as above, for ch2
    pop  BC             ; 1:10      get ch2 base freq
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    ld  HL,(addBuffer+4); 3:16      as above for ch3
    
    ld    C, 0xFE       ; 2:7       ...
    ;----------------- ;[30:168]
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    ret   c             ; 1:5       timing, branch never taken
    ld    B, PCTRL_B    ; 2:7       B = 0x10
    ;+++++++++++++++++ ;[35:192]
    
    dw OUT_C_B          ; 2:12      switch sound on
    
    pop  BC             ; 1:10      get ch3 base freq
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    ex   DE, HL         ; 1:4       DE is ch4 accu
    pop  BC             ; 1:10      get ch4 base freq
    add  HL, BC         ; 1:11      add base freq as usual
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    exx                 ; 1:4       ...

    pop  BC             ; 1:10      get base freq ch5
    add  HL, BC         ; 1:11      HL' is ch5 accu
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
        
    ld    R, A          ; 1:9       timing
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;----------------- ;[32:168]
    dw OUT_C_0x00       ; 2:12      switch sound off

    adc   A, 0x00       ; 2:7       ...
    ret   c             ; 1:5/11    timing
    ;-+-+-+-+-+-+-+-+- ;[35:192]
    
    dw OUT_C_B          ; 2:12      switch sound on/off
    
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10      get base freq ch6
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ex   DE, HL         ; 1:4       ... 
    
    pop  BC             ; 1:10
    add  IX, BC         ; 2:15      IX is accu ch7
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ret   c             ; 1:5/11    timing
    
    pop  BC             ; 1:10    
    add  IY, BC         ; 2:15      IY is accu ch8    
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    
    exx                 ; 1:4       ...
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;----------------- ;[32:168]
    dw OUT_C_0x00       ; 2:12      switch sound off
    
    ex   AF, AF'        ; 1:4
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    ;-+-+-+-+-+-+-+-+- ;[37:192]
    
    dw OUT_C_B          ; 2:12      switch sound on/off
    
    adc   A, 0x00       ; 2:7       ...

    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex  (SP),HL         ; 1:19      timing
    ex  (SP),HL         ; 1:19      timing
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    dec   A             ; 1:4
    jp    z,updateTimerX; 3:10      and update if necessary
    
    ret   z             ; 1:5/11    timing
    ex   AF, AF'        ; 1:4
    ex  (SP),HL         ; 1:19      timing
    ex  (SP),HL         ; 1:19      timing
    ;----------------- ;[25:168]
    dw OUT_C_0x00       ; 2:12      switch sound off
        
    ds 2                ; 2:8       timing
    jp  (HL)            ; 1:4       jump to next frame
    ;. . . . . . . . . ;[30:192]

        
;*********************************************************************************************
    org 256*(1+(high($)))
;   iiii dd, ss         ; b:tt      ...
core8:                  ;           vol 8 - 192t
    ;+++++++++++++++++ ;[  :0]
    dw OUT_C_B          ; 2:12      switch sound on

    ld   HL,(addBuffer) ; 3:16      get ch1 accu
    pop  BC             ; 1:10      get ch1 base freq
    add  HL, BC         ; 1:11      add them up
    ld (addBuffer),HL   ; 3:16      store ch1 accu
    rl    H             ; 2:8       rotate bit 7 into volume accu
    rla                 ; 1:4       ...
    
    ld  HL,(addBuffer+2); 3:16      as above, for ch2
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+2),HL; 3:16      store ch2 accu
    rl    H             ; 2:8       rotate bit 7 into volume accu
    adc   A, 0x00       ; 2:7       ...
    
    ld  HL,(addBuffer+4); 3:16      as above for ch3
    
    ld    C, 0xFE       ; 2:7       ...
    ds 3                ; 3:12      timing    
    ret   c             ; 1:5       timing, branch never taken
    
    ld    B, PCTRL_B    ; 2:7       B = 0x10
    ;+++++++++++++++++ ;[36:192]
    
    dw OUT_C_B          ; 2:12      switch sound on
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld  (addBuffer+4),HL; 3:16      store ch3 accu
    rl    H             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...

    ex   DE, HL         ; 1:4       DE is ch4 accu
    pop  BC             ; 1:10      add base freq as usual
    add  HL, BC         ; 1:11
    ex   DE, HL         ; 1:4       ... 
    ld    B, D          ; 1:4       get bit 7 of ch4 accu without modifying the accu itself
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    
    exx                 ; 1:4       ...

    pop  BC             ; 1:10      get base freq ch5
    add  HL, BC         ; 1:11      HL' is ch5 accu
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
        
    ld    R, A          ; 1:9       timing
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[30:168]
    dw OUT_C_B          ; 2:12      switch sound on

    adc   A, 0x00       ; 2:7       ...
    ret   c             ; 1:5/11    timing
    ;+++++++++++++++++ ;[35:192]
    
    dw OUT_C_B          ; 2:12      switch sound on
    
    ex   DE, HL         ; 1:4       DE' is accu ch6
    pop  BC             ; 1:10
    add  HL, BC         ; 1:11
    ld    B, H          ; 1:4       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ex   DE, HL         ; 1:4       ...
    
    pop  BC             ; 1:10
    add  IX, BC         ; 2:15      IX is accu ch7
    ld    B, IXH        ; 2:8       ...
    rl    B             ; 2:8       ...
    adc   A, 0x00       ; 2:7       ...
    ret   c             ; 1:5/11    timing
    
    pop  BC             ; 1:10    
    add  IY, BC         ; 2:15      IY is accu ch8    
    ld    B, IYH        ; 2:8       ...
    rl    B             ; 2:8       ...
    
    exx                 ; 1:4       ...
    ld   BC, PCTRL      ; 3:10      0x10fe
    ;+++++++++++++++++ ;[32:168]
    dw OUT_C_B          ; 2:12      switch sound on
    
    ex   AF, AF'        ; 1:4
    dec   A             ; 1:4
    ex   AF, AF'        ; 1:4
    ;+++++++++++++++++ ;[37:192]
    dw OUT_C_B          ; 2:12      switch sound on
    
    adc   A, 0x00       ; 2:7       ...

    ld   HL,-16         ; 3:10      point SP to beginning of pattern row again
    add  HL, SP         ; 1:11      ...
    ld   SP, HL         ; 1:6       ...
    add   A, basec      ; 2:7       calculate which core to use for next frame
    ld    H, A          ; 1:4       and put the value in HL
    xor   A             ; 1:4       also reset volume accu
    ld    L, A          ; 1:4       ...
    
    ex  (SP),HL         ; 1:19      timing
    ex  (SP),HL         ; 1:19      timing
    
    ex   AF, AF'        ; 1:4       check if timer has expired
    dec   A             ; 1:4
    jp    z,updateTimer ; 3:10      and update if necessary
    ret   z             ; 1:5/11    timing
    ex   AF, AF'        ; 1:4
    
    ex  (SP),HL         ; 1:19      timing
    ex  (SP),HL         ; 1:19      timing
    ;+++++++++++++++++ ;[25:168]
    dw OUT_C_B          ; 2:12      switch sound on
        
    ds 2                ; 2:8       timing
    jp  (HL)            ; 1:4       jump to next frame
    ;. . . . . . . . . ;[30:192]

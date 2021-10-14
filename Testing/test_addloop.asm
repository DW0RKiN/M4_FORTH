; vvv
; ^^^
ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10      Init Return address stack
    exx                 ; 1:4

 

    push DE             ; 1:11      push2(-2,2)
    ld   DE, -2         ; 3:10      push2(-2,2)
    push HL             ; 1:11      push2(-2,2)
    ld   HL, 2          ; 3:10      push2(-2,2) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-2,2)
    ld   DE, -2         ; 3:10      push2(-2,2)
    push HL             ; 1:11      push2(-2,2)
    ld   HL, 2          ; 3:10      push2(-2,2) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-2,2)
    ld   DE, -2         ; 3:10      push2(-2,2)
    push HL             ; 1:11      push2(-2,2)
    ld   HL, 2          ; 3:10      push2(-2,2) 
    call _down3         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-2,2)
    ld   DE, -2         ; 3:10      push2(-2,2)
    push HL             ; 1:11      push2(-2,2)
    ld   HL, 2          ; 3:10      push2(-2,2) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-2,2)
    ld   DE, -2         ; 3:10      push2(-2,2)
    push HL             ; 1:11      push2(-2,2)
    ld   HL, 2          ; 3:10      push2(-2,2) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-2,2)
    ld   DE, -2         ; 3:10      push2(-2,2)
    push HL             ; 1:11      push2(-2,2)
    ld   HL, 2          ; 3:10      push2(-2,2) 
    call _up3           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-2,2)
    ld   DE, -2         ; 3:10      push2(-2,2)
    push HL             ; 1:11      push2(-2,2)
    ld   HL, 2          ; 3:10      push2(-2,2) 
    call _smycka        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-2,2)
    ld   DE, -2         ; 3:10      push2(-2,2)
    push HL             ; 1:11      push2(-2,2)
    ld   HL, 2          ; 3:10      push2(-2,2) 
    call _otaznik       ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _down3         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _up3           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _smycka        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _otaznik       ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push2(2,-2)
    ld   DE, 2          ; 3:10      push2(2,-2)
    push HL             ; 1:11      push2(2,-2)
    ld   HL, -2         ; 3:10      push2(2,-2) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-2)
    ld   DE, 2          ; 3:10      push2(2,-2)
    push HL             ; 1:11      push2(2,-2)
    ld   HL, -2         ; 3:10      push2(2,-2) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-2)
    ld   DE, 2          ; 3:10      push2(2,-2)
    push HL             ; 1:11      push2(2,-2)
    ld   HL, -2         ; 3:10      push2(2,-2) 
    call _down3         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-2)
    ld   DE, 2          ; 3:10      push2(2,-2)
    push HL             ; 1:11      push2(2,-2)
    ld   HL, -2         ; 3:10      push2(2,-2) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-2)
    ld   DE, 2          ; 3:10      push2(2,-2)
    push HL             ; 1:11      push2(2,-2)
    ld   HL, -2         ; 3:10      push2(2,-2) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-2)
    ld   DE, 2          ; 3:10      push2(2,-2)
    push HL             ; 1:11      push2(2,-2)
    ld   HL, -2         ; 3:10      push2(2,-2) 
    call _up3           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-2)
    ld   DE, 2          ; 3:10      push2(2,-2)
    push HL             ; 1:11      push2(2,-2)
    ld   HL, -2         ; 3:10      push2(2,-2) 
    call _smycka        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-2)
    ld   DE, 2          ; 3:10      push2(2,-2)
    push HL             ; 1:11      push2(2,-2)
    ld   HL, -2         ; 3:10      push2(2,-2) 
    call _otaznik       ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,4)
    ld   DE, 1          ; 3:10      push2(1,4)
    push HL             ; 1:11      push2(1,4)
    ld   HL, 4          ; 3:10      push2(1,4) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,4)
    ld   DE, 1          ; 3:10      push2(1,4)
    push HL             ; 1:11      push2(1,4)
    ld   HL, 4          ; 3:10      push2(1,4) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(4,1)
    ld   DE, 4          ; 3:10      push2(4,1)
    push HL             ; 1:11      push2(4,1)
    ld   HL, 1          ; 3:10      push2(4,1) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(4,1)
    ld   DE, 4          ; 3:10      push2(4,1)
    push HL             ; 1:11      push2(4,1)
    ld   HL, 1          ; 3:10      push2(4,1) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-1)
    ld   DE, 2          ; 3:10      push2(2,-1)
    push HL             ; 1:11      push2(2,-1)
    ld   HL, -1         ; 3:10      push2(2,-1) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-1)
    ld   DE, 2          ; 3:10      push2(2,-1)
    push HL             ; 1:11      push2(2,-1)
    ld   HL, -1         ; 3:10      push2(2,-1) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,2)
    ld   DE, -1         ; 3:10      push2(-1,2)
    push HL             ; 1:11      push2(-1,2)
    ld   HL, 2          ; 3:10      push2(-1,2) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,2)
    ld   DE, -1         ; 3:10      push2(-1,2)
    push HL             ; 1:11      push2(-1,2)
    ld   HL, 2          ; 3:10      push2(-1,2) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,4)
    ld   DE, 1          ; 3:10      push2(1,4)
    push HL             ; 1:11      push2(1,4)
    ld   HL, 4          ; 3:10      push2(1,4) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,4)
    ld   DE, 1          ; 3:10      push2(1,4)
    push HL             ; 1:11      push2(1,4)
    ld   HL, 4          ; 3:10      push2(1,4) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(4,1)
    ld   DE, 4          ; 3:10      push2(4,1)
    push HL             ; 1:11      push2(4,1)
    ld   HL, 1          ; 3:10      push2(4,1) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(4,1)
    ld   DE, 4          ; 3:10      push2(4,1)
    push HL             ; 1:11      push2(4,1)
    ld   HL, 1          ; 3:10      push2(4,1) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-1)
    ld   DE, 2          ; 3:10      push2(2,-1)
    push HL             ; 1:11      push2(2,-1)
    ld   HL, -1         ; 3:10      push2(2,-1) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(2,-1)
    ld   DE, 2          ; 3:10      push2(2,-1)
    push HL             ; 1:11      push2(2,-1)
    ld   HL, -1         ; 3:10      push2(2,-1) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,2)
    ld   DE, -1         ; 3:10      push2(-1,2)
    push HL             ; 1:11      push2(-1,2)
    ld   HL, 2          ; 3:10      push2(-1,2) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,2)
    ld   DE, -1         ; 3:10      push2(-1,2)
    push HL             ; 1:11      push2(-1,2)
    ld   HL, 2          ; 3:10      push2(-1,2) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push(4)
    ex   DE, HL         ; 1:4       push(4)
    ld   HL, 4          ; 3:10      push(4) 
    push DE             ; 1:11      push2(1,0)
    ld   DE, 1          ; 3:10      push2(1,0)
    push HL             ; 1:11      push2(1,0)
    ld   HL, 0          ; 3:10      push2(1,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(4)
    ex   DE, HL         ; 1:4       push(4)
    ld   HL, 4          ; 3:10      push(4) 
    push DE             ; 1:11      push2(1,0)
    ld   DE, 1          ; 3:10      push2(1,0)
    push HL             ; 1:11      push2(1,0)
    ld   HL, 0          ; 3:10      push2(1,0) 
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    push DE             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   HL, 0          ; 3:10      push2(4,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    push DE             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   HL, 0          ; 3:10      push2(4,0) 
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    push DE             ; 1:11      push2(-1,0)
    ld   DE, -1         ; 3:10      push2(-1,0)
    push HL             ; 1:11      push2(-1,0)
    ld   HL, 0          ; 3:10      push2(-1,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    push DE             ; 1:11      push2(-1,0)
    ld   DE, -1         ; 3:10      push2(-1,0)
    push HL             ; 1:11      push2(-1,0)
    ld   HL, 0          ; 3:10      push2(-1,0) 
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    push DE             ; 1:11      push2(2,0)
    ld   DE, 2          ; 3:10      push2(2,0)
    push HL             ; 1:11      push2(2,0)
    ld   HL, 0          ; 3:10      push2(2,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    push DE             ; 1:11      push2(2,0)
    ld   DE, 2          ; 3:10      push2(2,0)
    push HL             ; 1:11      push2(2,0)
    ld   HL, 0          ; 3:10      push2(2,0) 
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(10,-10)
    ld   DE, 10         ; 3:10      push2(10,-10)
    push HL             ; 1:11      push2(10,-10)
    ld   HL, -10        ; 3:10      push2(10,-10) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(10,-10)
    ld   DE, 10         ; 3:10      push2(10,-10)
    push HL             ; 1:11      push2(10,-10)
    ld   HL, -10        ; 3:10      push2(10,-10) 
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(11,-10)
    ld   DE, 11         ; 3:10      push2(11,-10)
    push HL             ; 1:11      push2(11,-10)
    ld   HL, -10        ; 3:10      push2(11,-10) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(11,-10)
    ld   DE, 11         ; 3:10      push2(11,-10)
    push HL             ; 1:11      push2(11,-10)
    ld   HL, -10        ; 3:10      push2(11,-10) 
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(9,-10)
    ld   DE, 9          ; 3:10      push2(9,-10)
    push HL             ; 1:11      push2(9,-10)
    ld   HL, -10        ; 3:10      push2(9,-10) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(9,-10)
    ld   DE, 9          ; 3:10      push2(9,-10)
    push HL             ; 1:11      push2(9,-10)
    ld   HL, -10        ; 3:10      push2(9,-10) 
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, 1          ; 3:10      xdo(-1,1) 101
    ld  (idx101),BC     ; 4:20      xdo(-1,1) 101
xdo101:                 ;           xdo(-1,1) 101  
    push DE             ; 1:11      index i 101
    ex   DE, HL         ; 1:4       index i 101
    ld   HL, (idx101)   ; 3:16      index i 101 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(-1) 101
idx101 EQU $+1          ;           -1 +xloop 101
    ld   BC, 0x0000     ; 3:10      -1 +xloop 101 idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop 101
    xor  low -1         ; 2:7       -1 +xloop 101
    ld    A, B          ; 1:4       -1 +xloop 101
    dec  BC             ; 1:6       -1 +xloop 101 index--
    ld  (idx101),BC     ; 4:20      -1 +xloop 101 save index
    jp   nz, xdo101     ; 3:10      -1 +xloop 101
    xor  high -1        ; 2:7       -1 +xloop 101
    jp   nz, xdo101     ; 3:10      -1 +xloop 101
xleave101:              ;           -1 +xloop 101
xexit101:               ;           xloop 101 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101 == string102
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       -1 1 rxdo 102
    dec  HL             ; 1:6       -1 1 rxdo 102
    ld  (HL),high 1     ; 2:10      -1 1 rxdo 102
    dec   L             ; 1:4       -1 1 rxdo 102
    ld  (HL),low 1      ; 2:10      -1 1 rxdo 102
    exx                 ; 1:4       -1 1 rxdo 102 R:( -- 1 )
do102:                  ;           -1 1 rxdo 102 
    exx                 ; 1:4       index ri 102    
    ld    E,(HL)        ; 1:7       index ri 102
    inc   L             ; 1:4       index ri 102
    ld    D,(HL)        ; 1:7       index ri 102
    push DE             ; 1:11      index ri 102
    dec   L             ; 1:4       index ri 102
    exx                 ; 1:4       index ri 102
    ex   DE, HL         ; 1:4       index ri 102
    ex  (SP),HL         ; 1:19      index ri 102 
    call PRINT_S16      ; 3:17      . 
                        ;           -1 +rxloop 102
    exx                 ; 1:4       -1 +rxloop 102
    ld    E,(HL)        ; 1:7       -1 +rxloop 102
    inc   L             ; 1:4       -1 +rxloop 102
    ld    D,(HL)        ; 1:7       -1 +rxloop 102
    ld    A, low -1     ; 2:7       -1 +rxloop 102
    xor   E             ; 1:4       -1 +rxloop 102
    jr   nz, $+7        ; 2:7/12    -1 +rxloop 102
    ld    A, high -1    ; 2:7       -1 +rxloop 102
    xor   D             ; 1:4       -1 +rxloop 102
    jr    z, leave102   ; 2:7/12    -1 +rxloop 102 exit
    dec  DE             ; 1:6       -1 +rxloop 102 index--
    ld  (HL), D         ; 1:7       -1 +rxloop 102
    dec   L             ; 1:4       -1 +rxloop 102
    ld  (HL), E         ; 1:6       -1 +rxloop 102
    exx                 ; 1:4       -1 +rxloop 102
    jp   do102          ; 3:10      -1 +rxloop 102
leave102:               ;           -1 +rxloop 102
    inc  HL             ; 1:6       -1 +rxloop 102
    exx                 ; 1:4       -1 +rxloop 102 R:( index -- )
exit102:                ;           -1 +rxloop 102 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string103
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, 1          ; 3:10      xdo(-1,1) 103
    ld  (idx103),BC     ; 4:20      xdo(-1,1) 103
xdo103:                 ;           xdo(-1,1) 103  
    push DE             ; 1:11      index i 103
    ex   DE, HL         ; 1:4       index i 103
    ld   HL, (idx103)   ; 3:16      index i 103 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      -2 +xloop 103
idx103 EQU $+1          ;           -2 +xloop 103
    ld   HL, 0x0000     ; 3:10      -2 +xloop 103
    ld   BC, -2         ; 3:10      -2 +xloop 103 BC = step
    add  HL, BC         ; 1:11      -2 +xloop 103 HL = index+step
    ld  (idx103), HL    ; 3:16      -2 +xloop 103 save index
    ld    A, low -2     ; 2:7       -2 +xloop 103
    sub   L             ; 1:4       -2 +xloop 103
    ld    L, A          ; 1:4       -2 +xloop 103
    ld    A, high -2    ; 2:7       -2 +xloop 103
    sbc   A, H          ; 1:4       -2 +xloop 103
    ld    H, A          ; 1:4       -2 +xloop 103 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -2 +xloop 103 HL = stop-index
    pop  HL             ; 1:10      -2 +xloop 103
    jp    c, xdo103     ; 3:10      -2 +xloop 103 negative step
xleave103:              ;           -2 +xloop 103
xexit103:               ;           -2 +xloop 103 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string103 == string104
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       -1 1 rxdo 104
    dec  HL             ; 1:6       -1 1 rxdo 104
    ld  (HL),high 1     ; 2:10      -1 1 rxdo 104
    dec   L             ; 1:4       -1 1 rxdo 104
    ld  (HL),low 1      ; 2:10      -1 1 rxdo 104
    exx                 ; 1:4       -1 1 rxdo 104 R:( -- 1 )
do104:                  ;           -1 1 rxdo 104 
    exx                 ; 1:4       index ri 104    
    ld    E,(HL)        ; 1:7       index ri 104
    inc   L             ; 1:4       index ri 104
    ld    D,(HL)        ; 1:7       index ri 104
    push DE             ; 1:11      index ri 104
    dec   L             ; 1:4       index ri 104
    exx                 ; 1:4       index ri 104
    ex   DE, HL         ; 1:4       index ri 104
    ex  (SP),HL         ; 1:19      index ri 104 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       -2 +rxloop 104
    ld    E,(HL)        ; 1:7       -2 +rxloop 104
    inc   L             ; 1:4       -2 +rxloop 104
    ld    D,(HL)        ; 1:7       -2 +rxloop 104 DE = index
    push HL             ; 1:11      -2 +rxloop 104
    ld   HL, 1          ; 3:10      -2 +rxloop 104 HL = -stop = -( -1 )
    add  HL, DE         ; 1:11      -2 +rxloop 104 index-stop
    ld   BC, -2         ; 3:10      -2 +rxloop 104 BC = step
    add  HL, BC         ; 1:11      -2 +rxloop 104 index-stop+step
    jr   nc, leave104-1 ; 2:7/12    -2 +rxloop 104 -step
    ex   DE, HL         ; 1:4       -2 +rxloop 104
    add  HL, BC         ; 1:11      -2 +rxloop 104 index+step
    ex   DE, HL         ; 1:4       -2 +rxloop 104    
    pop  HL             ; 1:10      -2 +rxloop 104
    ld  (HL),D          ; 1:7       -2 +rxloop 104
    dec   L             ; 1:4       -2 +rxloop 104
    ld  (HL),E          ; 1:7       -2 +rxloop 104
    exx                 ; 1:4       -2 +rxloop 104    
    jp   do104          ; 3:10      -2 +rxloop 104 ( -- ) R:( index -- index+-2 )
    pop  HL             ; 1:10      -2 +rxloop 104
leave104:               ;           -2 +rxloop 104    
    inc  HL             ; 1:6       -2 +rxloop 104    
    exx                 ; 1:4       -2 +rxloop 104 ( -- ) R:( index -- )
exit104:                ;           -2 +rxloop 104 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, 1          ; 3:10      xdo(-1,1) 105
    ld  (idx105),BC     ; 4:20      xdo(-1,1) 105
xdo105:                 ;           xdo(-1,1) 105  
    push DE             ; 1:11      index i 105
    ex   DE, HL         ; 1:4       index i 105
    ld   HL, (idx105)   ; 3:16      index i 105 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      -4 +xloop 105
idx105 EQU $+1          ;           -4 +xloop 105
    ld   HL, 0x0000     ; 3:10      -4 +xloop 105
    ld   BC, -4         ; 3:10      -4 +xloop 105 BC = step
    add  HL, BC         ; 1:11      -4 +xloop 105 HL = index+step
    ld  (idx105), HL    ; 3:16      -4 +xloop 105 save index
    ld    A, low -2     ; 2:7       -4 +xloop 105
    sub   L             ; 1:4       -4 +xloop 105
    ld    L, A          ; 1:4       -4 +xloop 105
    ld    A, high -2    ; 2:7       -4 +xloop 105
    sbc   A, H          ; 1:4       -4 +xloop 105
    ld    H, A          ; 1:4       -4 +xloop 105 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -4 +xloop 105 HL = stop-index
    pop  HL             ; 1:10      -4 +xloop 105
    jp    c, xdo105     ; 3:10      -4 +xloop 105 negative step
xleave105:              ;           -4 +xloop 105
xexit105:               ;           -4 +xloop 105 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105 == string106
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       -1 1 rxdo 106
    dec  HL             ; 1:6       -1 1 rxdo 106
    ld  (HL),high 1     ; 2:10      -1 1 rxdo 106
    dec   L             ; 1:4       -1 1 rxdo 106
    ld  (HL),low 1      ; 2:10      -1 1 rxdo 106
    exx                 ; 1:4       -1 1 rxdo 106 R:( -- 1 )
do106:                  ;           -1 1 rxdo 106 
    exx                 ; 1:4       index ri 106    
    ld    E,(HL)        ; 1:7       index ri 106
    inc   L             ; 1:4       index ri 106
    ld    D,(HL)        ; 1:7       index ri 106
    push DE             ; 1:11      index ri 106
    dec   L             ; 1:4       index ri 106
    exx                 ; 1:4       index ri 106
    ex   DE, HL         ; 1:4       index ri 106
    ex  (SP),HL         ; 1:19      index ri 106 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       -4 +rxloop 106
    ld    E,(HL)        ; 1:7       -4 +rxloop 106
    inc   L             ; 1:4       -4 +rxloop 106
    ld    D,(HL)        ; 1:7       -4 +rxloop 106 DE = index
    push HL             ; 1:11      -4 +rxloop 106
    ld   HL, 1          ; 3:10      -4 +rxloop 106 HL = -stop = -( -1 )
    add  HL, DE         ; 1:11      -4 +rxloop 106 index-stop
    ld   BC, -4         ; 3:10      -4 +rxloop 106 BC = step
    add  HL, BC         ; 1:11      -4 +rxloop 106 index-stop+step
    jr   nc, leave106-1 ; 2:7/12    -4 +rxloop 106 -step
    ex   DE, HL         ; 1:4       -4 +rxloop 106
    add  HL, BC         ; 1:11      -4 +rxloop 106 index+step
    ex   DE, HL         ; 1:4       -4 +rxloop 106    
    pop  HL             ; 1:10      -4 +rxloop 106
    ld  (HL),D          ; 1:7       -4 +rxloop 106
    dec   L             ; 1:4       -4 +rxloop 106
    ld  (HL),E          ; 1:7       -4 +rxloop 106
    exx                 ; 1:4       -4 +rxloop 106    
    jp   do106          ; 3:10      -4 +rxloop 106 ( -- ) R:( index -- index+-4 )
    pop  HL             ; 1:10      -4 +rxloop 106
leave106:               ;           -4 +rxloop 106    
    inc  HL             ; 1:6       -4 +rxloop 106    
    exx                 ; 1:4       -4 +rxloop 106 ( -- ) R:( index -- )
exit106:                ;           -4 +rxloop 106 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, 0          ; 3:10      xdo(0,0) 107
    ld  (idx107),BC     ; 4:20      xdo(0,0) 107
xdo107:                 ;           xdo(0,0) 107 
    push DE             ; 1:11      index i 107
    ex   DE, HL         ; 1:4       index i 107
    ld   HL, (idx107)   ; 3:16      index i 107 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(-1) 107
idx107 EQU $+1          ;           -1 +xloop 107
    ld   BC, 0x0000     ; 3:10      -1 +xloop 107 idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop 107
    xor  low 0          ; 2:7       -1 +xloop 107
    ld    A, B          ; 1:4       -1 +xloop 107
    dec  BC             ; 1:6       -1 +xloop 107 index--
    ld  (idx107),BC     ; 4:20      -1 +xloop 107 save index
    jp   nz, xdo107     ; 3:10      -1 +xloop 107
    xor  high 0         ; 2:7       -1 +xloop 107
    jp   nz, xdo107     ; 3:10      -1 +xloop 107
xleave107:              ;           -1 +xloop 107
xexit107:               ;           xloop 107 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string107  ; 3:10      print_z   Address of null-terminated string107 == string108
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       0 0 rxdo 108
    dec  HL             ; 1:6       0 0 rxdo 108
    ld  (HL),high 0     ; 2:10      0 0 rxdo 108
    dec   L             ; 1:4       0 0 rxdo 108
    ld  (HL),low 0      ; 2:10      0 0 rxdo 108
    exx                 ; 1:4       0 0 rxdo 108 R:( -- 0 )
do108:                  ;           0 0 rxdo 108 
    exx                 ; 1:4       index ri 108    
    ld    E,(HL)        ; 1:7       index ri 108
    inc   L             ; 1:4       index ri 108
    ld    D,(HL)        ; 1:7       index ri 108
    push DE             ; 1:11      index ri 108
    dec   L             ; 1:4       index ri 108
    exx                 ; 1:4       index ri 108
    ex   DE, HL         ; 1:4       index ri 108
    ex  (SP),HL         ; 1:19      index ri 108 
    call PRINT_S16      ; 3:17      . 
                        ;           -1 +rxloop 108
    exx                 ; 1:4       -1 +rxloop 108
    ld    E,(HL)        ; 1:7       -1 +rxloop 108
    inc   L             ; 1:4       -1 +rxloop 108
    ld    D,(HL)        ; 1:7       -1 +rxloop 108
    ld    A, low 0      ; 2:7       -1 +rxloop 108
    xor   E             ; 1:4       -1 +rxloop 108
    jr   nz, $+7        ; 2:7/12    -1 +rxloop 108
    ld    A, high 0     ; 2:7       -1 +rxloop 108
    xor   D             ; 1:4       -1 +rxloop 108
    jr    z, leave108   ; 2:7/12    -1 +rxloop 108 exit
    dec  DE             ; 1:6       -1 +rxloop 108 index--
    ld  (HL), D         ; 1:7       -1 +rxloop 108
    dec   L             ; 1:4       -1 +rxloop 108
    ld  (HL), E         ; 1:6       -1 +rxloop 108
    exx                 ; 1:4       -1 +rxloop 108
    jp   do108          ; 3:10      -1 +rxloop 108
leave108:               ;           -1 +rxloop 108
    inc  HL             ; 1:6       -1 +rxloop 108
    exx                 ; 1:4       -1 +rxloop 108 R:( index -- )
exit108:                ;           -1 +rxloop 108 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, 0          ; 3:10      xdo(0,0) 109
    ld  (idx109),BC     ; 4:20      xdo(0,0) 109
xdo109:                 ;           xdo(0,0) 109  
    push DE             ; 1:11      index i 109
    ex   DE, HL         ; 1:4       index i 109
    ld   HL, (idx109)   ; 3:16      index i 109 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      -2 +xloop 109
idx109 EQU $+1          ;           -2 +xloop 109
    ld   HL, 0x0000     ; 3:10      -2 +xloop 109
    ld   BC, -2         ; 3:10      -2 +xloop 109 BC = step
    add  HL, BC         ; 1:11      -2 +xloop 109 HL = index+step
    ld  (idx109), HL    ; 3:16      -2 +xloop 109 save index
    ld    A, low -1     ; 2:7       -2 +xloop 109
    sub   L             ; 1:4       -2 +xloop 109
    ld    L, A          ; 1:4       -2 +xloop 109
    ld    A, high -1    ; 2:7       -2 +xloop 109
    sbc   A, H          ; 1:4       -2 +xloop 109
    ld    H, A          ; 1:4       -2 +xloop 109 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -2 +xloop 109 HL = stop-index
    pop  HL             ; 1:10      -2 +xloop 109
    jp    c, xdo109     ; 3:10      -2 +xloop 109 negative step
xleave109:              ;           -2 +xloop 109
xexit109:               ;           -2 +xloop 109 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109 == string110
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       0 0 rxdo 110
    dec  HL             ; 1:6       0 0 rxdo 110
    ld  (HL),high 0     ; 2:10      0 0 rxdo 110
    dec   L             ; 1:4       0 0 rxdo 110
    ld  (HL),low 0      ; 2:10      0 0 rxdo 110
    exx                 ; 1:4       0 0 rxdo 110 R:( -- 0 )
do110:                  ;           0 0 rxdo 110 
    exx                 ; 1:4       index ri 110    
    ld    E,(HL)        ; 1:7       index ri 110
    inc   L             ; 1:4       index ri 110
    ld    D,(HL)        ; 1:7       index ri 110
    push DE             ; 1:11      index ri 110
    dec   L             ; 1:4       index ri 110
    exx                 ; 1:4       index ri 110
    ex   DE, HL         ; 1:4       index ri 110
    ex  (SP),HL         ; 1:19      index ri 110 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       -2 +rxloop 110
    ld    E,(HL)        ; 1:7       -2 +rxloop 110
    inc   L             ; 1:4       -2 +rxloop 110
    ld    D,(HL)        ; 1:7       -2 +rxloop 110 DE = index
    push HL             ; 1:11      -2 +rxloop 110
    ld   HL, 0          ; 3:10      -2 +rxloop 110 HL = -stop = -( 0 )
    add  HL, DE         ; 1:11      -2 +rxloop 110 index-stop
    ld   BC, -2         ; 3:10      -2 +rxloop 110 BC = step
    add  HL, BC         ; 1:11      -2 +rxloop 110 index-stop+step
    jr   nc, leave110-1 ; 2:7/12    -2 +rxloop 110 -step
    ex   DE, HL         ; 1:4       -2 +rxloop 110
    add  HL, BC         ; 1:11      -2 +rxloop 110 index+step
    ex   DE, HL         ; 1:4       -2 +rxloop 110    
    pop  HL             ; 1:10      -2 +rxloop 110
    ld  (HL),D          ; 1:7       -2 +rxloop 110
    dec   L             ; 1:4       -2 +rxloop 110
    ld  (HL),E          ; 1:7       -2 +rxloop 110
    exx                 ; 1:4       -2 +rxloop 110    
    jp   do110          ; 3:10      -2 +rxloop 110 ( -- ) R:( index -- index+-2 )
    pop  HL             ; 1:10      -2 +rxloop 110
leave110:               ;           -2 +rxloop 110    
    inc  HL             ; 1:6       -2 +rxloop 110    
    exx                 ; 1:4       -2 +rxloop 110 ( -- ) R:( index -- )
exit110:                ;           -2 +rxloop 110 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, 0          ; 3:10      xdo(0,0) 111
    ld  (idx111),BC     ; 4:20      xdo(0,0) 111
xdo111:                 ;           xdo(0,0) 111  
    push DE             ; 1:11      index i 111
    ex   DE, HL         ; 1:4       index i 111
    ld   HL, (idx111)   ; 3:16      index i 111 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      -4 +xloop 111
idx111 EQU $+1          ;           -4 +xloop 111
    ld   HL, 0x0000     ; 3:10      -4 +xloop 111
    ld   BC, -4         ; 3:10      -4 +xloop 111 BC = step
    add  HL, BC         ; 1:11      -4 +xloop 111 HL = index+step
    ld  (idx111), HL    ; 3:16      -4 +xloop 111 save index
    ld    A, low -1     ; 2:7       -4 +xloop 111
    sub   L             ; 1:4       -4 +xloop 111
    ld    L, A          ; 1:4       -4 +xloop 111
    ld    A, high -1    ; 2:7       -4 +xloop 111
    sbc   A, H          ; 1:4       -4 +xloop 111
    ld    H, A          ; 1:4       -4 +xloop 111 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -4 +xloop 111 HL = stop-index
    pop  HL             ; 1:10      -4 +xloop 111
    jp    c, xdo111     ; 3:10      -4 +xloop 111 negative step
xleave111:              ;           -4 +xloop 111
xexit111:               ;           -4 +xloop 111 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111 == string112
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       0 0 rxdo 112
    dec  HL             ; 1:6       0 0 rxdo 112
    ld  (HL),high 0     ; 2:10      0 0 rxdo 112
    dec   L             ; 1:4       0 0 rxdo 112
    ld  (HL),low 0      ; 2:10      0 0 rxdo 112
    exx                 ; 1:4       0 0 rxdo 112 R:( -- 0 )
do112:                  ;           0 0 rxdo 112 
    exx                 ; 1:4       index ri 112    
    ld    E,(HL)        ; 1:7       index ri 112
    inc   L             ; 1:4       index ri 112
    ld    D,(HL)        ; 1:7       index ri 112
    push DE             ; 1:11      index ri 112
    dec   L             ; 1:4       index ri 112
    exx                 ; 1:4       index ri 112
    ex   DE, HL         ; 1:4       index ri 112
    ex  (SP),HL         ; 1:19      index ri 112 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       -4 +rxloop 112
    ld    E,(HL)        ; 1:7       -4 +rxloop 112
    inc   L             ; 1:4       -4 +rxloop 112
    ld    D,(HL)        ; 1:7       -4 +rxloop 112 DE = index
    push HL             ; 1:11      -4 +rxloop 112
    ld   HL, 0          ; 3:10      -4 +rxloop 112 HL = -stop = -( 0 )
    add  HL, DE         ; 1:11      -4 +rxloop 112 index-stop
    ld   BC, -4         ; 3:10      -4 +rxloop 112 BC = step
    add  HL, BC         ; 1:11      -4 +rxloop 112 index-stop+step
    jr   nc, leave112-1 ; 2:7/12    -4 +rxloop 112 -step
    ex   DE, HL         ; 1:4       -4 +rxloop 112
    add  HL, BC         ; 1:11      -4 +rxloop 112 index+step
    ex   DE, HL         ; 1:4       -4 +rxloop 112    
    pop  HL             ; 1:10      -4 +rxloop 112
    ld  (HL),D          ; 1:7       -4 +rxloop 112
    dec   L             ; 1:4       -4 +rxloop 112
    ld  (HL),E          ; 1:7       -4 +rxloop 112
    exx                 ; 1:4       -4 +rxloop 112    
    jp   do112          ; 3:10      -4 +rxloop 112 ( -- ) R:( index -- index+-4 )
    pop  HL             ; 1:10      -4 +rxloop 112
leave112:               ;           -4 +rxloop 112    
    inc  HL             ; 1:6       -4 +rxloop 112    
    exx                 ; 1:4       -4 +rxloop 112 ( -- ) R:( index -- )
exit112:                ;           -4 +rxloop 112 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, -1         ; 3:10      xdo(2,-1) 113
    ld  (idx113),BC     ; 4:20      xdo(2,-1) 113
xdo113:                 ;           xdo(2,-1) 113 
    push DE             ; 1:11      index i 113
    ex   DE, HL         ; 1:4       index i 113
    ld   HL, (idx113)   ; 3:16      index i 113 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(1) 113
idx113 EQU $+1          ;[20:~71]   xloop 113 -1..2
    ld   BC, 0x0000     ; 3:10      xloop 113 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 113 index++
    ld  (idx113),BC     ; 4:20      xloop 113 save index
    ld    A, C          ; 1:4       xloop 113
    xor  low 2          ; 2:7       xloop 113
    jp   nz, xdo113     ; 3:10      xloop 113
    ld    A, B          ; 1:4       xloop 113
    xor  high 2         ; 2:7       xloop 113
    jp   nz, xdo113     ; 3:10      xloop 113
xleave113:              ;           xloop 113
xexit113:               ;           xloop 113 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113 == string114
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       2 -1 rxdo 114
    dec  HL             ; 1:6       2 -1 rxdo 114
    ld  (HL),high -1    ; 2:10      2 -1 rxdo 114
    dec   L             ; 1:4       2 -1 rxdo 114
    ld  (HL),low -1     ; 2:10      2 -1 rxdo 114
    exx                 ; 1:4       2 -1 rxdo 114 R:( -- -1 )
do114:                  ;           2 -1 rxdo 114 
    exx                 ; 1:4       index ri 114    
    ld    E,(HL)        ; 1:7       index ri 114
    inc   L             ; 1:4       index ri 114
    ld    D,(HL)        ; 1:7       index ri 114
    push DE             ; 1:11      index ri 114
    dec   L             ; 1:4       index ri 114
    exx                 ; 1:4       index ri 114
    ex   DE, HL         ; 1:4       index ri 114
    ex  (SP),HL         ; 1:19      index ri 114 
    call PRINT_S16      ; 3:17      . 
                        ;           1 +rxloop 114
    exx                 ; 1:4       rxloop 114
    ld    E,(HL)        ; 1:7       rxloop 114
    inc   L             ; 1:4       rxloop 114
    ld    D,(HL)        ; 1:7       rxloop 114
    inc  DE             ; 1:6       rxloop 114 index++
    ld    A, low 2      ; 2:7       rxloop 114
    xor   E             ; 1:4       rxloop 114
    jr   nz, $+7        ; 2:7/12    rxloop 114
    ld    A, high 2     ; 2:7       rxloop 114
    xor   D             ; 1:4       rxloop 114
    jr    z, leave114   ; 2:7/12    rxloop 114 exit
    ld  (HL), D         ; 1:7       rxloop 114
    dec   L             ; 1:4       rxloop 114
    ld  (HL), E         ; 1:6       rxloop 114
    exx                 ; 1:4       rxloop 114
    jp   do114          ; 3:10      rxloop 114
leave114:               ;           rxloop 114
    inc  HL             ; 1:6       rxloop 114
    exx                 ; 1:4       rxloop 114 R:( index -- )
exit114:                ; 1:4       rxloop 114 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, -1         ; 3:10      xdo(2,-1) 115
    ld  (idx115),BC     ; 4:20      xdo(2,-1) 115
xdo115:                 ;           xdo(2,-1) 115  
    push DE             ; 1:11      index i 115
    ex   DE, HL         ; 1:4       index i 115
    ld   HL, (idx115)   ; 3:16      index i 115 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(2) 115
idx115 EQU $+1          ;           2 +xloop 115
    ld   BC, 0x0000     ; 3:10      2 +xloop 115 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 115 index++
    inc  BC             ; 1:6       2 +xloop 115 index++
    ld  (idx115),BC     ; 4:20      2 +xloop 115 save index
    ld    A, C          ; 1:4       2 +xloop 115
    sub  low 2          ; 2:7       2 +xloop 115
    rra                 ; 1:4       2 +xloop 115
    add   A, A          ; 1:4       2 +xloop 115 and 0xFE with save carry
    jp   nz, xdo115     ; 3:10      2 +xloop 115
    ld    A, B          ; 1:4       2 +xloop 115
    sbc   A, high 2     ; 2:7       2 +xloop 115
    jp   nz, xdo115     ; 3:10      2 +xloop 115
xleave115:              ;           2 +xloop 115
xexit115:               ;           2 +xloop 115 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string116
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       2 -1 rxdo 116
    dec  HL             ; 1:6       2 -1 rxdo 116
    ld  (HL),high -1    ; 2:10      2 -1 rxdo 116
    dec   L             ; 1:4       2 -1 rxdo 116
    ld  (HL),low -1     ; 2:10      2 -1 rxdo 116
    exx                 ; 1:4       2 -1 rxdo 116 R:( -- -1 )
do116:                  ;           2 -1 rxdo 116 
    exx                 ; 1:4       index ri 116    
    ld    E,(HL)        ; 1:7       index ri 116
    inc   L             ; 1:4       index ri 116
    ld    D,(HL)        ; 1:7       index ri 116
    push DE             ; 1:11      index ri 116
    dec   L             ; 1:4       index ri 116
    exx                 ; 1:4       index ri 116
    ex   DE, HL         ; 1:4       index ri 116
    ex  (SP),HL         ; 1:19      index ri 116 
    call PRINT_S16      ; 3:17      . 
                        ;           2 +rxloop 116
    exx                 ; 1:4       2 +rxloop 116
    ld    E,(HL)        ; 1:7       2 +rxloop 116
    inc   L             ; 1:4       2 +rxloop 116
    ld    D,(HL)        ; 1:7       2 +rxloop 116 DE = index
    inc  DE             ; 1:6       2 +rxloop 116
    inc  DE             ; 1:6       2 +rxloop 116 DE = index+2
    ld    A, E          ; 1:4       2 +rxloop 116    
    sub  low 2          ; 2:7       2 +rxloop 116 lo index+2-stop
    rra                 ; 1:4       2 +rxloop 116
    add   A, A          ; 1:4       2 +rxloop 116 and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +rxloop 116
    ld    A, D          ; 1:4       2 +rxloop 116
    sbc   A, high 2     ; 2:7       2 +rxloop 116 lo index+2-stop
    jr    z, leave116   ; 2:7/12    2 +rxloop 116
    ld  (HL),D          ; 1:7       2 +rxloop 116
    dec   L             ; 1:4       2 +rxloop 116
    ld  (HL),E          ; 1:7       2 +rxloop 116
    exx                 ; 1:4       2 +rxloop 116
    jp    p, do116      ; 3:10      2 +rxloop 116 ( -- ) R:( stop index -- stop index+ )
leave116:               ;           2 +rxloop 116
    inc  HL             ; 1:6       2 +rxloop 116
    exx                 ; 1:4       2 +rxloop 116
exit116:                ;           2 +rxloop 116 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, -1         ; 3:10      xdo(2,-1) 117
    ld  (idx117),BC     ; 4:20      xdo(2,-1) 117
xdo117:                 ;           xdo(2,-1) 117  
    push DE             ; 1:11      index i 117
    ex   DE, HL         ; 1:4       index i 117
    ld   HL, (idx117)   ; 3:16      index i 117 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      4 +xloop 117
idx117 EQU $+1          ;           4 +xloop 117
    ld   HL, 0x0000     ; 3:10      4 +xloop 117
    ld   BC, 4          ; 3:10      4 +xloop 117 BC = step
    add  HL, BC         ; 1:11      4 +xloop 117 HL = index+step
    ld  (idx117), HL    ; 3:16      4 +xloop 117 save index
    ld    A, low 1      ; 2:7       4 +xloop 117
    sub   L             ; 1:4       4 +xloop 117
    ld    L, A          ; 1:4       4 +xloop 117
    ld    A, high 1     ; 2:7       4 +xloop 117
    sbc   A, H          ; 1:4       4 +xloop 117
    ld    H, A          ; 1:4       4 +xloop 117 HL = stop-(index+step)
    add  HL, BC         ; 1:11      4 +xloop 117 HL = stop-index
    pop  HL             ; 1:10      4 +xloop 117
    jp   nc, xdo117     ; 3:10      4 +xloop 117 positive step
xleave117:              ;           4 +xloop 117
xexit117:               ;           4 +xloop 117 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string117  ; 3:10      print_z   Address of null-terminated string117 == string118
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       2 -1 rxdo 118
    dec  HL             ; 1:6       2 -1 rxdo 118
    ld  (HL),high -1    ; 2:10      2 -1 rxdo 118
    dec   L             ; 1:4       2 -1 rxdo 118
    ld  (HL),low -1     ; 2:10      2 -1 rxdo 118
    exx                 ; 1:4       2 -1 rxdo 118 R:( -- -1 )
do118:                  ;           2 -1 rxdo 118 
    exx                 ; 1:4       index ri 118    
    ld    E,(HL)        ; 1:7       index ri 118
    inc   L             ; 1:4       index ri 118
    ld    D,(HL)        ; 1:7       index ri 118
    push DE             ; 1:11      index ri 118
    dec   L             ; 1:4       index ri 118
    exx                 ; 1:4       index ri 118
    ex   DE, HL         ; 1:4       index ri 118
    ex  (SP),HL         ; 1:19      index ri 118 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       4 +rxloop 118
    ld    E,(HL)        ; 1:7       4 +rxloop 118
    inc   L             ; 1:4       4 +rxloop 118
    ld    D,(HL)        ; 1:7       4 +rxloop 118 DE = index
    push HL             ; 1:11      4 +rxloop 118
    ld   HL, -2         ; 3:10      4 +rxloop 118 HL = -stop = -( 2 )
    add  HL, DE         ; 1:11      4 +rxloop 118 index-stop
    ld   BC, 4          ; 3:10      4 +rxloop 118 BC = step
    add  HL, BC         ; 1:11      4 +rxloop 118 index-stop+step
    jr    c, leave118-1 ; 2:7/12    4 +rxloop 118 +step
    ex   DE, HL         ; 1:4       4 +rxloop 118
    add  HL, BC         ; 1:11      4 +rxloop 118 index+step
    ex   DE, HL         ; 1:4       4 +rxloop 118    
    pop  HL             ; 1:10      4 +rxloop 118
    ld  (HL),D          ; 1:7       4 +rxloop 118
    dec   L             ; 1:4       4 +rxloop 118
    ld  (HL),E          ; 1:7       4 +rxloop 118
    exx                 ; 1:4       4 +rxloop 118    
    jp   do118          ; 3:10      4 +rxloop 118 ( -- ) R:( index -- index+4 )
    pop  HL             ; 1:10      4 +rxloop 118
leave118:               ;           4 +rxloop 118    
    inc  HL             ; 1:6       4 +rxloop 118    
    exx                 ; 1:4       4 +rxloop 118 ( -- ) R:( index -- )
exit118:                ;           4 +rxloop 118 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, 1          ; 3:10      xdo(-1,1) 119
    ld  (idx119),BC     ; 4:20      xdo(-1,1) 119
xdo119:                 ;           xdo(-1,1) 119 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else101    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave119      ;           xleave 119 
else101  EQU $          ;           = endif
endif101:  
    push DE             ; 1:11      index i 119
    ex   DE, HL         ; 1:4       index i 119
    ld   HL, (idx119)   ; 3:16      index i 119 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(1) 119
idx119 EQU $+1          ;[20:~71]   xloop 119 1..-1
    ld   BC, 0x0000     ; 3:10      xloop 119 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 119 index++
    ld  (idx119),BC     ; 4:20      xloop 119 save index
    ld    A, C          ; 1:4       xloop 119
    xor  low -1         ; 2:7       xloop 119
    jp   nz, xdo119     ; 3:10      xloop 119
    ld    A, B          ; 1:4       xloop 119
    xor  high -1        ; 2:7       xloop 119
    jp   nz, xdo119     ; 3:10      xloop 119
xleave119:              ;           xloop 119
xexit119:               ;           xloop 119 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string119  ; 3:10      print_z   Address of null-terminated string119 == string121
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       -1 1 rxdo 120
    dec  HL             ; 1:6       -1 1 rxdo 120
    ld  (HL),high 1     ; 2:10      -1 1 rxdo 120
    dec   L             ; 1:4       -1 1 rxdo 120
    ld  (HL),low 1      ; 2:10      -1 1 rxdo 120
    exx                 ; 1:4       -1 1 rxdo 120 R:( -- 1 )
do120:                  ;           -1 1 rxdo 120 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else102    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string122
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 120
    inc  L              ; 1:4       rxleave 120
    jp  leave120        ;           rxleave 120 
else102  EQU $          ;           = endif
endif102: 
    exx                 ; 1:4       index ri 120    
    ld    E,(HL)        ; 1:7       index ri 120
    inc   L             ; 1:4       index ri 120
    ld    D,(HL)        ; 1:7       index ri 120
    push DE             ; 1:11      index ri 120
    dec   L             ; 1:4       index ri 120
    exx                 ; 1:4       index ri 120
    ex   DE, HL         ; 1:4       index ri 120
    ex  (SP),HL         ; 1:19      index ri 120 
    call PRINT_S16      ; 3:17      . 
                        ;           1 +rxloop 120
    exx                 ; 1:4       rxloop 120
    ld    E,(HL)        ; 1:7       rxloop 120
    inc   L             ; 1:4       rxloop 120
    ld    D,(HL)        ; 1:7       rxloop 120
    inc  DE             ; 1:6       rxloop 120 index++
    ld    A, low -1     ; 2:7       rxloop 120
    xor   E             ; 1:4       rxloop 120
    jr   nz, $+7        ; 2:7/12    rxloop 120
    ld    A, high -1    ; 2:7       rxloop 120
    xor   D             ; 1:4       rxloop 120
    jr    z, leave120   ; 2:7/12    rxloop 120 exit
    ld  (HL), D         ; 1:7       rxloop 120
    dec   L             ; 1:4       rxloop 120
    ld  (HL), E         ; 1:6       rxloop 120
    exx                 ; 1:4       rxloop 120
    jp   do120          ; 3:10      rxloop 120
leave120:               ;           rxloop 120
    inc  HL             ; 1:6       rxloop 120
    exx                 ; 1:4       rxloop 120 R:( index -- )
exit120:                ; 1:4       rxloop 120 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string123  ; 3:10      print_z   Address of null-terminated string123
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, 1          ; 3:10      xdo(-1,1) 121
    ld  (idx121),BC     ; 4:20      xdo(-1,1) 121
xdo121:                 ;           xdo(-1,1) 121 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else103    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string124
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave121      ;           xleave 121 
else103  EQU $          ;           = endif
endif103:  
    push DE             ; 1:11      index i 121
    ex   DE, HL         ; 1:4       index i 121
    ld   HL, (idx121)   ; 3:16      index i 121 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(2) 121
idx121 EQU $+1          ;           2 +xloop 121
    ld   BC, 0x0000     ; 3:10      2 +xloop 121 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 121 index++
    inc  BC             ; 1:6       2 +xloop 121 index++
    ld  (idx121),BC     ; 4:20      2 +xloop 121 save index
    ld    A, C          ; 1:4       2 +xloop 121
    sub  low -1         ; 2:7       2 +xloop 121
    rra                 ; 1:4       2 +xloop 121
    add   A, A          ; 1:4       2 +xloop 121 and 0xFE with save carry
    jp   nz, xdo121     ; 3:10      2 +xloop 121
    ld    A, B          ; 1:4       2 +xloop 121
    sbc   A, high -1    ; 2:7       2 +xloop 121
    jp   nz, xdo121     ; 3:10      2 +xloop 121
xleave121:              ;           2 +xloop 121
xexit121:               ;           2 +xloop 121 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string123  ; 3:10      print_z   Address of null-terminated string123 == string125
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       -1 1 rxdo 122
    dec  HL             ; 1:6       -1 1 rxdo 122
    ld  (HL),high 1     ; 2:10      -1 1 rxdo 122
    dec   L             ; 1:4       -1 1 rxdo 122
    ld  (HL),low 1      ; 2:10      -1 1 rxdo 122
    exx                 ; 1:4       -1 1 rxdo 122 R:( -- 1 )
do122:                  ;           -1 1 rxdo 122 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else104    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string126
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 122
    inc  L              ; 1:4       rxleave 122
    jp  leave122        ;           rxleave 122 
else104  EQU $          ;           = endif
endif104: 
    exx                 ; 1:4       index ri 122    
    ld    E,(HL)        ; 1:7       index ri 122
    inc   L             ; 1:4       index ri 122
    ld    D,(HL)        ; 1:7       index ri 122
    push DE             ; 1:11      index ri 122
    dec   L             ; 1:4       index ri 122
    exx                 ; 1:4       index ri 122
    ex   DE, HL         ; 1:4       index ri 122
    ex  (SP),HL         ; 1:19      index ri 122 
    call PRINT_S16      ; 3:17      . 
                        ;           2 +rxloop 122
    exx                 ; 1:4       2 +rxloop 122
    ld    E,(HL)        ; 1:7       2 +rxloop 122
    inc   L             ; 1:4       2 +rxloop 122
    ld    D,(HL)        ; 1:7       2 +rxloop 122 DE = index
    inc  DE             ; 1:6       2 +rxloop 122
    inc  DE             ; 1:6       2 +rxloop 122 DE = index+2
    ld    A, E          ; 1:4       2 +rxloop 122    
    sub  low -1         ; 2:7       2 +rxloop 122 lo index+2-stop
    rra                 ; 1:4       2 +rxloop 122
    add   A, A          ; 1:4       2 +rxloop 122 and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +rxloop 122
    ld    A, D          ; 1:4       2 +rxloop 122
    sbc   A, high -1    ; 2:7       2 +rxloop 122 lo index+2-stop
    jr    z, leave122   ; 2:7/12    2 +rxloop 122
    ld  (HL),D          ; 1:7       2 +rxloop 122
    dec   L             ; 1:4       2 +rxloop 122
    ld  (HL),E          ; 1:7       2 +rxloop 122
    exx                 ; 1:4       2 +rxloop 122
    jp    p, do122      ; 3:10      2 +rxloop 122 ( -- ) R:( stop index -- stop index+ )
leave122:               ;           2 +rxloop 122
    inc  HL             ; 1:6       2 +rxloop 122
    exx                 ; 1:4       2 +rxloop 122
exit122:                ;           2 +rxloop 122 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string127  ; 3:10      print_z   Address of null-terminated string127
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, 1          ; 3:10      xdo(-1,1) 123
    ld  (idx123),BC     ; 4:20      xdo(-1,1) 123
xdo123:                 ;           xdo(-1,1) 123 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else105    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string128
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave123      ;           xleave 123 
else105  EQU $          ;           = endif
endif105:  
    push DE             ; 1:11      index i 123
    ex   DE, HL         ; 1:4       index i 123
    ld   HL, (idx123)   ; 3:16      index i 123 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      4 +xloop 123
idx123 EQU $+1          ;           4 +xloop 123
    ld   HL, 0x0000     ; 3:10      4 +xloop 123
    ld   BC, 4          ; 3:10      4 +xloop 123 BC = step
    add  HL, BC         ; 1:11      4 +xloop 123 HL = index+step
    ld  (idx123), HL    ; 3:16      4 +xloop 123 save index
    ld    A, low -2     ; 2:7       4 +xloop 123
    sub   L             ; 1:4       4 +xloop 123
    ld    L, A          ; 1:4       4 +xloop 123
    ld    A, high -2    ; 2:7       4 +xloop 123
    sbc   A, H          ; 1:4       4 +xloop 123
    ld    H, A          ; 1:4       4 +xloop 123 HL = stop-(index+step)
    add  HL, BC         ; 1:11      4 +xloop 123 HL = stop-index
    pop  HL             ; 1:10      4 +xloop 123
    jp   nc, xdo123     ; 3:10      4 +xloop 123 positive step
xleave123:              ;           4 +xloop 123
xexit123:               ;           4 +xloop 123 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string127  ; 3:10      print_z   Address of null-terminated string127 == string129
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       -1 1 rxdo 124
    dec  HL             ; 1:6       -1 1 rxdo 124
    ld  (HL),high 1     ; 2:10      -1 1 rxdo 124
    dec   L             ; 1:4       -1 1 rxdo 124
    ld  (HL),low 1      ; 2:10      -1 1 rxdo 124
    exx                 ; 1:4       -1 1 rxdo 124 R:( -- 1 )
do124:                  ;           -1 1 rxdo 124 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else106    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string130
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 124
    inc  L              ; 1:4       rxleave 124
    jp  leave124        ;           rxleave 124 
else106  EQU $          ;           = endif
endif106: 
    exx                 ; 1:4       index ri 124    
    ld    E,(HL)        ; 1:7       index ri 124
    inc   L             ; 1:4       index ri 124
    ld    D,(HL)        ; 1:7       index ri 124
    push DE             ; 1:11      index ri 124
    dec   L             ; 1:4       index ri 124
    exx                 ; 1:4       index ri 124
    ex   DE, HL         ; 1:4       index ri 124
    ex  (SP),HL         ; 1:19      index ri 124 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       4 +rxloop 124
    ld    E,(HL)        ; 1:7       4 +rxloop 124
    inc   L             ; 1:4       4 +rxloop 124
    ld    D,(HL)        ; 1:7       4 +rxloop 124 DE = index
    push HL             ; 1:11      4 +rxloop 124
    ld   HL, 1          ; 3:10      4 +rxloop 124 HL = -stop = -( -1 )
    add  HL, DE         ; 1:11      4 +rxloop 124 index-stop
    ld   BC, 4          ; 3:10      4 +rxloop 124 BC = step
    add  HL, BC         ; 1:11      4 +rxloop 124 index-stop+step
    jr    c, leave124-1 ; 2:7/12    4 +rxloop 124 +step
    ex   DE, HL         ; 1:4       4 +rxloop 124
    add  HL, BC         ; 1:11      4 +rxloop 124 index+step
    ex   DE, HL         ; 1:4       4 +rxloop 124    
    pop  HL             ; 1:10      4 +rxloop 124
    ld  (HL),D          ; 1:7       4 +rxloop 124
    dec   L             ; 1:4       4 +rxloop 124
    ld  (HL),E          ; 1:7       4 +rxloop 124
    exx                 ; 1:4       4 +rxloop 124    
    jp   do124          ; 3:10      4 +rxloop 124 ( -- ) R:( index -- index+4 )
    pop  HL             ; 1:10      4 +rxloop 124
leave124:               ;           4 +rxloop 124    
    inc  HL             ; 1:6       4 +rxloop 124    
    exx                 ; 1:4       4 +rxloop 124 ( -- ) R:( index -- )
exit124:                ;           4 +rxloop 124 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string131  ; 3:10      print_z   Address of null-terminated string131
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, 0          ; 3:10      xdo(0,0) 125
    ld  (idx125),BC     ; 4:20      xdo(0,0) 125
xdo125:                 ;           xdo(0,0) 125 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else107    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string132
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave125      ;           xleave 125 
else107  EQU $          ;           = endif
endif107:  
    push DE             ; 1:11      index i 125
    ex   DE, HL         ; 1:4       index i 125
    ld   HL, (idx125)   ; 3:16      index i 125 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(1) 125
idx125 EQU $+1          ;[20:~71]   xloop 125 0..0
    ld   BC, 0x0000     ; 3:10      xloop 125 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 125 index++
    ld  (idx125),BC     ; 4:20      xloop 125 save index
    ld    A, C          ; 1:4       xloop 125
    xor  low 0          ; 2:7       xloop 125
    jp   nz, xdo125     ; 3:10      xloop 125
    ld    A, B          ; 1:4       xloop 125
    xor  high 0         ; 2:7       xloop 125
    jp   nz, xdo125     ; 3:10      xloop 125
xleave125:              ;           xloop 125
xexit125:               ;           xloop 125 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string131  ; 3:10      print_z   Address of null-terminated string131 == string133
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       0 0 rxdo 126
    dec  HL             ; 1:6       0 0 rxdo 126
    ld  (HL),high 0     ; 2:10      0 0 rxdo 126
    dec   L             ; 1:4       0 0 rxdo 126
    ld  (HL),low 0      ; 2:10      0 0 rxdo 126
    exx                 ; 1:4       0 0 rxdo 126 R:( -- 0 )
do126:                  ;           0 0 rxdo 126 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else108    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string134
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 126
    inc  L              ; 1:4       rxleave 126
    jp  leave126        ;           rxleave 126 
else108  EQU $          ;           = endif
endif108: 
    exx                 ; 1:4       index ri 126    
    ld    E,(HL)        ; 1:7       index ri 126
    inc   L             ; 1:4       index ri 126
    ld    D,(HL)        ; 1:7       index ri 126
    push DE             ; 1:11      index ri 126
    dec   L             ; 1:4       index ri 126
    exx                 ; 1:4       index ri 126
    ex   DE, HL         ; 1:4       index ri 126
    ex  (SP),HL         ; 1:19      index ri 126 
    call PRINT_S16      ; 3:17      . 
                        ;           1 +rxloop 126
    exx                 ; 1:4       rxloop 126
    ld    E,(HL)        ; 1:7       rxloop 126
    inc   L             ; 1:4       rxloop 126
    ld    D,(HL)        ; 1:7       rxloop 126
    inc  DE             ; 1:6       rxloop 126 index++
    ld    A, low 0      ; 2:7       rxloop 126
    xor   E             ; 1:4       rxloop 126
    jr   nz, $+7        ; 2:7/12    rxloop 126
    ld    A, high 0     ; 2:7       rxloop 126
    xor   D             ; 1:4       rxloop 126
    jr    z, leave126   ; 2:7/12    rxloop 126 exit
    ld  (HL), D         ; 1:7       rxloop 126
    dec   L             ; 1:4       rxloop 126
    ld  (HL), E         ; 1:6       rxloop 126
    exx                 ; 1:4       rxloop 126
    jp   do126          ; 3:10      rxloop 126
leave126:               ;           rxloop 126
    inc  HL             ; 1:6       rxloop 126
    exx                 ; 1:4       rxloop 126 R:( index -- )
exit126:                ; 1:4       rxloop 126 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string135  ; 3:10      print_z   Address of null-terminated string135
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, 0          ; 3:10      xdo(0,0) 127
    ld  (idx127),BC     ; 4:20      xdo(0,0) 127
xdo127:                 ;           xdo(0,0) 127 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else109    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string136
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave127      ;           xleave 127 
else109  EQU $          ;           = endif
endif109:  
    push DE             ; 1:11      index i 127
    ex   DE, HL         ; 1:4       index i 127
    ld   HL, (idx127)   ; 3:16      index i 127 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(2) 127
idx127 EQU $+1          ;           2 +xloop 127
    ld   BC, 0x0000     ; 3:10      2 +xloop 127 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 127 index++
    inc  BC             ; 1:6       2 +xloop 127 index++
    ld  (idx127),BC     ; 4:20      2 +xloop 127 save index
    ld    A, C          ; 1:4       2 +xloop 127
    sub  low 0          ; 2:7       2 +xloop 127
    rra                 ; 1:4       2 +xloop 127
    add   A, A          ; 1:4       2 +xloop 127 and 0xFE with save carry
    jp   nz, xdo127     ; 3:10      2 +xloop 127
    ld    A, B          ; 1:4       2 +xloop 127
    sbc   A, high 0     ; 2:7       2 +xloop 127
    jp   nz, xdo127     ; 3:10      2 +xloop 127
xleave127:              ;           2 +xloop 127
xexit127:               ;           2 +xloop 127 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string135  ; 3:10      print_z   Address of null-terminated string135 == string137
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       0 0 rxdo 128
    dec  HL             ; 1:6       0 0 rxdo 128
    ld  (HL),high 0     ; 2:10      0 0 rxdo 128
    dec   L             ; 1:4       0 0 rxdo 128
    ld  (HL),low 0      ; 2:10      0 0 rxdo 128
    exx                 ; 1:4       0 0 rxdo 128 R:( -- 0 )
do128:                  ;           0 0 rxdo 128 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else110    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string138
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 128
    inc  L              ; 1:4       rxleave 128
    jp  leave128        ;           rxleave 128 
else110  EQU $          ;           = endif
endif110: 
    exx                 ; 1:4       index ri 128    
    ld    E,(HL)        ; 1:7       index ri 128
    inc   L             ; 1:4       index ri 128
    ld    D,(HL)        ; 1:7       index ri 128
    push DE             ; 1:11      index ri 128
    dec   L             ; 1:4       index ri 128
    exx                 ; 1:4       index ri 128
    ex   DE, HL         ; 1:4       index ri 128
    ex  (SP),HL         ; 1:19      index ri 128 
    call PRINT_S16      ; 3:17      . 
                        ;           2 +rxloop 128
    exx                 ; 1:4       2 +rxloop 128
    ld    E,(HL)        ; 1:7       2 +rxloop 128
    inc   L             ; 1:4       2 +rxloop 128
    ld    D,(HL)        ; 1:7       2 +rxloop 128 DE = index
    inc  DE             ; 1:6       2 +rxloop 128
    inc  DE             ; 1:6       2 +rxloop 128 DE = index+2
    ld    A, E          ; 1:4       2 +rxloop 128    
    sub  low 0          ; 2:7       2 +rxloop 128 lo index+2-stop
    rra                 ; 1:4       2 +rxloop 128
    add   A, A          ; 1:4       2 +rxloop 128 and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +rxloop 128
    ld    A, D          ; 1:4       2 +rxloop 128
    sbc   A, high 0     ; 2:7       2 +rxloop 128 lo index+2-stop
    jr    z, leave128   ; 2:7/12    2 +rxloop 128
    ld  (HL),D          ; 1:7       2 +rxloop 128
    dec   L             ; 1:4       2 +rxloop 128
    ld  (HL),E          ; 1:7       2 +rxloop 128
    exx                 ; 1:4       2 +rxloop 128
    jp    p, do128      ; 3:10      2 +rxloop 128 ( -- ) R:( stop index -- stop index+ )
leave128:               ;           2 +rxloop 128
    inc  HL             ; 1:6       2 +rxloop 128
    exx                 ; 1:4       2 +rxloop 128
exit128:                ;           2 +rxloop 128 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string139  ; 3:10      print_z   Address of null-terminated string139
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, 0          ; 3:10      xdo(0,0) 129
    ld  (idx129),BC     ; 4:20      xdo(0,0) 129
xdo129:                 ;           xdo(0,0) 129 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else111    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string140
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave129      ;           xleave 129 
else111  EQU $          ;           = endif
endif111:  
    push DE             ; 1:11      index i 129
    ex   DE, HL         ; 1:4       index i 129
    ld   HL, (idx129)   ; 3:16      index i 129 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      4 +xloop 129
idx129 EQU $+1          ;           4 +xloop 129
    ld   HL, 0x0000     ; 3:10      4 +xloop 129
    ld   BC, 4          ; 3:10      4 +xloop 129 BC = step
    add  HL, BC         ; 1:11      4 +xloop 129 HL = index+step
    ld  (idx129), HL    ; 3:16      4 +xloop 129 save index
    ld    A, low -1     ; 2:7       4 +xloop 129
    sub   L             ; 1:4       4 +xloop 129
    ld    L, A          ; 1:4       4 +xloop 129
    ld    A, high -1    ; 2:7       4 +xloop 129
    sbc   A, H          ; 1:4       4 +xloop 129
    ld    H, A          ; 1:4       4 +xloop 129 HL = stop-(index+step)
    add  HL, BC         ; 1:11      4 +xloop 129 HL = stop-index
    pop  HL             ; 1:10      4 +xloop 129
    jp   nc, xdo129     ; 3:10      4 +xloop 129 positive step
xleave129:              ;           4 +xloop 129
xexit129:               ;           4 +xloop 129 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string139  ; 3:10      print_z   Address of null-terminated string139 == string141
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       0 0 rxdo 130
    dec  HL             ; 1:6       0 0 rxdo 130
    ld  (HL),high 0     ; 2:10      0 0 rxdo 130
    dec   L             ; 1:4       0 0 rxdo 130
    ld  (HL),low 0      ; 2:10      0 0 rxdo 130
    exx                 ; 1:4       0 0 rxdo 130 R:( -- 0 )
do130:                  ;           0 0 rxdo 130 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else112    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string142
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 130
    inc  L              ; 1:4       rxleave 130
    jp  leave130        ;           rxleave 130 
else112  EQU $          ;           = endif
endif112: 
    exx                 ; 1:4       index ri 130    
    ld    E,(HL)        ; 1:7       index ri 130
    inc   L             ; 1:4       index ri 130
    ld    D,(HL)        ; 1:7       index ri 130
    push DE             ; 1:11      index ri 130
    dec   L             ; 1:4       index ri 130
    exx                 ; 1:4       index ri 130
    ex   DE, HL         ; 1:4       index ri 130
    ex  (SP),HL         ; 1:19      index ri 130 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       4 +rxloop 130
    ld    E,(HL)        ; 1:7       4 +rxloop 130
    inc   L             ; 1:4       4 +rxloop 130
    ld    D,(HL)        ; 1:7       4 +rxloop 130 DE = index
    push HL             ; 1:11      4 +rxloop 130
    ld   HL, 0          ; 3:10      4 +rxloop 130 HL = -stop = -( 0 )
    add  HL, DE         ; 1:11      4 +rxloop 130 index-stop
    ld   BC, 4          ; 3:10      4 +rxloop 130 BC = step
    add  HL, BC         ; 1:11      4 +rxloop 130 index-stop+step
    jr    c, leave130-1 ; 2:7/12    4 +rxloop 130 +step
    ex   DE, HL         ; 1:4       4 +rxloop 130
    add  HL, BC         ; 1:11      4 +rxloop 130 index+step
    ex   DE, HL         ; 1:4       4 +rxloop 130    
    pop  HL             ; 1:10      4 +rxloop 130
    ld  (HL),D          ; 1:7       4 +rxloop 130
    dec   L             ; 1:4       4 +rxloop 130
    ld  (HL),E          ; 1:7       4 +rxloop 130
    exx                 ; 1:4       4 +rxloop 130    
    jp   do130          ; 3:10      4 +rxloop 130 ( -- ) R:( index -- index+4 )
    pop  HL             ; 1:10      4 +rxloop 130
leave130:               ;           4 +rxloop 130    
    inc  HL             ; 1:6       4 +rxloop 130    
    exx                 ; 1:4       4 +rxloop 130 ( -- ) R:( index -- )
exit130:                ;           4 +rxloop 130 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string143  ; 3:10      print_z   Address of null-terminated string143
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, -1         ; 3:10      xdo(2,-1) 131
    ld  (idx131),BC     ; 4:20      xdo(2,-1) 131
xdo131:                 ;           xdo(2,-1) 131 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else113    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string144
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave131      ;           xleave 131 
else113  EQU $          ;           = endif
endif113:  
    push DE             ; 1:11      index i 131
    ex   DE, HL         ; 1:4       index i 131
    ld   HL, (idx131)   ; 3:16      index i 131 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
                        ;           push_addxloop(-1) 131
idx131 EQU $+1          ;           -1 +xloop 131
    ld   BC, 0x0000     ; 3:10      -1 +xloop 131 idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop 131
    xor  low 2          ; 2:7       -1 +xloop 131
    ld    A, B          ; 1:4       -1 +xloop 131
    dec  BC             ; 1:6       -1 +xloop 131 index--
    ld  (idx131),BC     ; 4:20      -1 +xloop 131 save index
    jp   nz, xdo131     ; 3:10      -1 +xloop 131
    xor  high 2         ; 2:7       -1 +xloop 131
    jp   nz, xdo131     ; 3:10      -1 +xloop 131
xleave131:              ;           -1 +xloop 131
xexit131:               ;           xloop 131 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string143  ; 3:10      print_z   Address of null-terminated string143 == string145
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       2 -1 rxdo 132
    dec  HL             ; 1:6       2 -1 rxdo 132
    ld  (HL),high -1    ; 2:10      2 -1 rxdo 132
    dec   L             ; 1:4       2 -1 rxdo 132
    ld  (HL),low -1     ; 2:10      2 -1 rxdo 132
    exx                 ; 1:4       2 -1 rxdo 132 R:( -- -1 )
do132:                  ;           2 -1 rxdo 132 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else114    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string146
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 132
    inc  L              ; 1:4       rxleave 132
    jp  leave132        ;           rxleave 132 
else114  EQU $          ;           = endif
endif114: 
    exx                 ; 1:4       index ri 132    
    ld    E,(HL)        ; 1:7       index ri 132
    inc   L             ; 1:4       index ri 132
    ld    D,(HL)        ; 1:7       index ri 132
    push DE             ; 1:11      index ri 132
    dec   L             ; 1:4       index ri 132
    exx                 ; 1:4       index ri 132
    ex   DE, HL         ; 1:4       index ri 132
    ex  (SP),HL         ; 1:19      index ri 132 
    call PRINT_S16      ; 3:17      . 
                        ;           -1 +rxloop 132
    exx                 ; 1:4       -1 +rxloop 132
    ld    E,(HL)        ; 1:7       -1 +rxloop 132
    inc   L             ; 1:4       -1 +rxloop 132
    ld    D,(HL)        ; 1:7       -1 +rxloop 132
    ld    A, low 2      ; 2:7       -1 +rxloop 132
    xor   E             ; 1:4       -1 +rxloop 132
    jr   nz, $+7        ; 2:7/12    -1 +rxloop 132
    ld    A, high 2     ; 2:7       -1 +rxloop 132
    xor   D             ; 1:4       -1 +rxloop 132
    jr    z, leave132   ; 2:7/12    -1 +rxloop 132 exit
    dec  DE             ; 1:6       -1 +rxloop 132 index--
    ld  (HL), D         ; 1:7       -1 +rxloop 132
    dec   L             ; 1:4       -1 +rxloop 132
    ld  (HL), E         ; 1:6       -1 +rxloop 132
    exx                 ; 1:4       -1 +rxloop 132
    jp   do132          ; 3:10      -1 +rxloop 132
leave132:               ;           -1 +rxloop 132
    inc  HL             ; 1:6       -1 +rxloop 132
    exx                 ; 1:4       -1 +rxloop 132 R:( index -- )
exit132:                ;           -1 +rxloop 132 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string147  ; 3:10      print_z   Address of null-terminated string147
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, -1         ; 3:10      xdo(2,-1) 133
    ld  (idx133),BC     ; 4:20      xdo(2,-1) 133
xdo133:                 ;           xdo(2,-1) 133 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else115    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string148
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave133      ;           xleave 133 
else115  EQU $          ;           = endif
endif115:  
    push DE             ; 1:11      index i 133
    ex   DE, HL         ; 1:4       index i 133
    ld   HL, (idx133)   ; 3:16      index i 133 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      -2 +xloop 133
idx133 EQU $+1          ;           -2 +xloop 133
    ld   HL, 0x0000     ; 3:10      -2 +xloop 133
    ld   BC, -2         ; 3:10      -2 +xloop 133 BC = step
    add  HL, BC         ; 1:11      -2 +xloop 133 HL = index+step
    ld  (idx133), HL    ; 3:16      -2 +xloop 133 save index
    ld    A, low 1      ; 2:7       -2 +xloop 133
    sub   L             ; 1:4       -2 +xloop 133
    ld    L, A          ; 1:4       -2 +xloop 133
    ld    A, high 1     ; 2:7       -2 +xloop 133
    sbc   A, H          ; 1:4       -2 +xloop 133
    ld    H, A          ; 1:4       -2 +xloop 133 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -2 +xloop 133 HL = stop-index
    pop  HL             ; 1:10      -2 +xloop 133
    jp    c, xdo133     ; 3:10      -2 +xloop 133 negative step
xleave133:              ;           -2 +xloop 133
xexit133:               ;           -2 +xloop 133 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string147  ; 3:10      print_z   Address of null-terminated string147 == string149
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       2 -1 rxdo 134
    dec  HL             ; 1:6       2 -1 rxdo 134
    ld  (HL),high -1    ; 2:10      2 -1 rxdo 134
    dec   L             ; 1:4       2 -1 rxdo 134
    ld  (HL),low -1     ; 2:10      2 -1 rxdo 134
    exx                 ; 1:4       2 -1 rxdo 134 R:( -- -1 )
do134:                  ;           2 -1 rxdo 134 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else116    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string150
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 134
    inc  L              ; 1:4       rxleave 134
    jp  leave134        ;           rxleave 134 
else116  EQU $          ;           = endif
endif116: 
    exx                 ; 1:4       index ri 134    
    ld    E,(HL)        ; 1:7       index ri 134
    inc   L             ; 1:4       index ri 134
    ld    D,(HL)        ; 1:7       index ri 134
    push DE             ; 1:11      index ri 134
    dec   L             ; 1:4       index ri 134
    exx                 ; 1:4       index ri 134
    ex   DE, HL         ; 1:4       index ri 134
    ex  (SP),HL         ; 1:19      index ri 134 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       -2 +rxloop 134
    ld    E,(HL)        ; 1:7       -2 +rxloop 134
    inc   L             ; 1:4       -2 +rxloop 134
    ld    D,(HL)        ; 1:7       -2 +rxloop 134 DE = index
    push HL             ; 1:11      -2 +rxloop 134
    ld   HL, -2         ; 3:10      -2 +rxloop 134 HL = -stop = -( 2 )
    add  HL, DE         ; 1:11      -2 +rxloop 134 index-stop
    ld   BC, -2         ; 3:10      -2 +rxloop 134 BC = step
    add  HL, BC         ; 1:11      -2 +rxloop 134 index-stop+step
    jr   nc, leave134-1 ; 2:7/12    -2 +rxloop 134 -step
    ex   DE, HL         ; 1:4       -2 +rxloop 134
    add  HL, BC         ; 1:11      -2 +rxloop 134 index+step
    ex   DE, HL         ; 1:4       -2 +rxloop 134    
    pop  HL             ; 1:10      -2 +rxloop 134
    ld  (HL),D          ; 1:7       -2 +rxloop 134
    dec   L             ; 1:4       -2 +rxloop 134
    ld  (HL),E          ; 1:7       -2 +rxloop 134
    exx                 ; 1:4       -2 +rxloop 134    
    jp   do134          ; 3:10      -2 +rxloop 134 ( -- ) R:( index -- index+-2 )
    pop  HL             ; 1:10      -2 +rxloop 134
leave134:               ;           -2 +rxloop 134    
    inc  HL             ; 1:6       -2 +rxloop 134    
    exx                 ; 1:4       -2 +rxloop 134 ( -- ) R:( index -- )
exit134:                ;           -2 +rxloop 134 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string151  ; 3:10      print_z   Address of null-terminated string151
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop)  

    ld   BC, -1         ; 3:10      xdo(2,-1) 135
    ld  (idx135),BC     ; 4:20      xdo(2,-1) 135
xdo135:                 ;           xdo(2,-1) 135 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else117    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string152
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave135      ;           xleave 135 
else117  EQU $          ;           = endif
endif117:  
    push DE             ; 1:11      index i 135
    ex   DE, HL         ; 1:4       index i 135
    ld   HL, (idx135)   ; 3:16      index i 135 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
    push HL             ; 1:11      -4 +xloop 135
idx135 EQU $+1          ;           -4 +xloop 135
    ld   HL, 0x0000     ; 3:10      -4 +xloop 135
    ld   BC, -4         ; 3:10      -4 +xloop 135 BC = step
    add  HL, BC         ; 1:11      -4 +xloop 135 HL = index+step
    ld  (idx135), HL    ; 3:16      -4 +xloop 135 save index
    ld    A, low 1      ; 2:7       -4 +xloop 135
    sub   L             ; 1:4       -4 +xloop 135
    ld    L, A          ; 1:4       -4 +xloop 135
    ld    A, high 1     ; 2:7       -4 +xloop 135
    sbc   A, H          ; 1:4       -4 +xloop 135
    ld    H, A          ; 1:4       -4 +xloop 135 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -4 +xloop 135 HL = stop-index
    pop  HL             ; 1:10      -4 +xloop 135
    jp    c, xdo135     ; 3:10      -4 +xloop 135 negative step
xleave135:              ;           -4 +xloop 135
xexit135:               ;           -4 +xloop 135 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string151  ; 3:10      print_z   Address of null-terminated string151 == string153
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 

    exx                 ; 1:4       2 -1 rxdo 136
    dec  HL             ; 1:6       2 -1 rxdo 136
    ld  (HL),high -1    ; 2:10      2 -1 rxdo 136
    dec   L             ; 1:4       2 -1 rxdo 136
    ld  (HL),low -1     ; 2:10      2 -1 rxdo 136
    exx                 ; 1:4       2 -1 rxdo 136 R:( -- -1 )
do136:                  ;           2 -1 rxdo 136 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else118    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string154
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 136
    inc  L              ; 1:4       rxleave 136
    jp  leave136        ;           rxleave 136 
else118  EQU $          ;           = endif
endif118: 
    exx                 ; 1:4       index ri 136    
    ld    E,(HL)        ; 1:7       index ri 136
    inc   L             ; 1:4       index ri 136
    ld    D,(HL)        ; 1:7       index ri 136
    push DE             ; 1:11      index ri 136
    dec   L             ; 1:4       index ri 136
    exx                 ; 1:4       index ri 136
    ex   DE, HL         ; 1:4       index ri 136
    ex  (SP),HL         ; 1:19      index ri 136 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       -4 +rxloop 136
    ld    E,(HL)        ; 1:7       -4 +rxloop 136
    inc   L             ; 1:4       -4 +rxloop 136
    ld    D,(HL)        ; 1:7       -4 +rxloop 136 DE = index
    push HL             ; 1:11      -4 +rxloop 136
    ld   HL, -2         ; 3:10      -4 +rxloop 136 HL = -stop = -( 2 )
    add  HL, DE         ; 1:11      -4 +rxloop 136 index-stop
    ld   BC, -4         ; 3:10      -4 +rxloop 136 BC = step
    add  HL, BC         ; 1:11      -4 +rxloop 136 index-stop+step
    jr   nc, leave136-1 ; 2:7/12    -4 +rxloop 136 -step
    ex   DE, HL         ; 1:4       -4 +rxloop 136
    add  HL, BC         ; 1:11      -4 +rxloop 136 index+step
    ex   DE, HL         ; 1:4       -4 +rxloop 136    
    pop  HL             ; 1:10      -4 +rxloop 136
    ld  (HL),D          ; 1:7       -4 +rxloop 136
    dec   L             ; 1:4       -4 +rxloop 136
    ld  (HL),E          ; 1:7       -4 +rxloop 136
    exx                 ; 1:4       -4 +rxloop 136    
    jp   do136          ; 3:10      -4 +rxloop 136 ( -- ) R:( index -- index+-4 )
    pop  HL             ; 1:10      -4 +rxloop 136
leave136:               ;           -4 +rxloop 136    
    inc  HL             ; 1:6       -4 +rxloop 136    
    exx                 ; 1:4       -4 +rxloop 136 ( -- ) R:( index -- )
exit136:                ;           -4 +rxloop 136 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string155  ; 3:10      print_z   Address of null-terminated string155
    call PRINT_STRING_Z ; 3:17      print_z  

    jp   xexit137       ; 3:10      ?xdo(-1,-1) 137
xdo137:                 ;           ?xdo(-1,-1) 137  
    push DE             ; 1:11      index i 137
    ex   DE, HL         ; 1:4       index i 137
    ld   HL, (idx137)   ; 3:16      index i 137 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
idx137 EQU $+1          ;[20:~71]   xloop 137 -1..-1
    ld   BC, 0x0000     ; 3:10      xloop 137 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 137 index++
    ld  (idx137),BC     ; 4:20      xloop 137 save index
    ld    A, C          ; 1:4       xloop 137
    xor  low -1         ; 2:7       xloop 137
    jp   nz, xdo137     ; 3:10      xloop 137
    ld    A, B          ; 1:4       xloop 137
    xor  high -1        ; 2:7       xloop 137
    jp   nz, xdo137     ; 3:10      xloop 137
xleave137:              ;           xloop 137
xexit137:               ;           xloop 137 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string155  ; 3:10      print_z   Address of null-terminated string155 == string156
    call PRINT_STRING_Z ; 3:17      print_z 

    jp   exit138       ; 3:10      -1 -1 ?rxdo 138
do138:                  ;           -1 -1 ?rxdo 138 
    exx                 ; 1:4       index ri 138    
    ld    E,(HL)        ; 1:7       index ri 138
    inc   L             ; 1:4       index ri 138
    ld    D,(HL)        ; 1:7       index ri 138
    push DE             ; 1:11      index ri 138
    dec   L             ; 1:4       index ri 138
    exx                 ; 1:4       index ri 138
    ex   DE, HL         ; 1:4       index ri 138
    ex  (SP),HL         ; 1:19      index ri 138 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       rxloop 138
    ld    E,(HL)        ; 1:7       rxloop 138
    inc   L             ; 1:4       rxloop 138
    ld    D,(HL)        ; 1:7       rxloop 138
    inc  DE             ; 1:6       rxloop 138 index++
    ld    A, low -1     ; 2:7       rxloop 138
    xor   E             ; 1:4       rxloop 138
    jr   nz, $+7        ; 2:7/12    rxloop 138
    ld    A, high -1    ; 2:7       rxloop 138
    xor   D             ; 1:4       rxloop 138
    jr    z, leave138   ; 2:7/12    rxloop 138 exit
    ld  (HL), D         ; 1:7       rxloop 138
    dec   L             ; 1:4       rxloop 138
    ld  (HL), E         ; 1:6       rxloop 138
    exx                 ; 1:4       rxloop 138
    jp   do138          ; 3:10      rxloop 138
leave138:               ;           rxloop 138
    inc  HL             ; 1:6       rxloop 138
    exx                 ; 1:4       rxloop 138 R:( index -- )
exit138:                ; 1:4       rxloop 138 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string157  ; 3:10      print_z   Address of null-terminated string157
    call PRINT_STRING_Z ; 3:17      print_z  

    jp   xexit139       ; 3:10      ?xdo(1,1) 139
xdo139:                 ;           ?xdo(1,1) 139  
    push DE             ; 1:11      index i 139
    ex   DE, HL         ; 1:4       index i 139
    ld   HL, (idx139)   ; 3:16      index i 139 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
idx139 EQU $+1          ;[20:~71]   xloop 139 1..1
    ld   BC, 0x0000     ; 3:10      xloop 139 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 139 index++
    ld  (idx139),BC     ; 4:20      xloop 139 save index
    ld    A, C          ; 1:4       xloop 139
    xor  low 1          ; 2:7       xloop 139
    jp   nz, xdo139     ; 3:10      xloop 139
    ld    A, B          ; 1:4       xloop 139
    xor  high 1         ; 2:7       xloop 139
    jp   nz, xdo139     ; 3:10      xloop 139
xleave139:              ;           xloop 139
xexit139:               ;           xloop 139 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string157  ; 3:10      print_z   Address of null-terminated string157 == string158
    call PRINT_STRING_Z ; 3:17      print_z 

    jp   exit140       ; 3:10      1 1 ?rxdo 140
do140:                  ;           1 1 ?rxdo 140 
    exx                 ; 1:4       index ri 140    
    ld    E,(HL)        ; 1:7       index ri 140
    inc   L             ; 1:4       index ri 140
    ld    D,(HL)        ; 1:7       index ri 140
    push DE             ; 1:11      index ri 140
    dec   L             ; 1:4       index ri 140
    exx                 ; 1:4       index ri 140
    ex   DE, HL         ; 1:4       index ri 140
    ex  (SP),HL         ; 1:19      index ri 140 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       rxloop 140
    ld    E,(HL)        ; 1:7       rxloop 140
    inc   L             ; 1:4       rxloop 140
    ld    D,(HL)        ; 1:7       rxloop 140
    inc  DE             ; 1:6       rxloop 140 index++
    ld    A, low 1      ; 2:7       rxloop 140
    xor   E             ; 1:4       rxloop 140
    jr   nz, $+7        ; 2:7/12    rxloop 140
    ld    A, high 1     ; 2:7       rxloop 140
    xor   D             ; 1:4       rxloop 140
    jr    z, leave140   ; 2:7/12    rxloop 140 exit
    ld  (HL), D         ; 1:7       rxloop 140
    dec   L             ; 1:4       rxloop 140
    ld  (HL), E         ; 1:6       rxloop 140
    exx                 ; 1:4       rxloop 140
    jp   do140          ; 3:10      rxloop 140
leave140:               ;           rxloop 140
    inc  HL             ; 1:6       rxloop 140
    exx                 ; 1:4       rxloop 140 R:( index -- )
exit140:                ; 1:4       rxloop 140 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string159  ; 3:10      print_z   Address of null-terminated string159
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, -1         ; 3:10      xdo(2,-1) 141
    ld  (idx141),BC     ; 4:20      xdo(2,-1) 141
xdo141:                 ;           xdo(2,-1) 141  
    push DE             ; 1:11      index i 141
    ex   DE, HL         ; 1:4       index i 141
    ld   HL, (idx141)   ; 3:16      index i 141 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
idx141 EQU $+1          ;[20:~71]   xloop 141 -1..2
    ld   BC, 0x0000     ; 3:10      xloop 141 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 141 index++
    ld  (idx141),BC     ; 4:20      xloop 141 save index
    ld    A, C          ; 1:4       xloop 141
    xor  low 2          ; 2:7       xloop 141
    jp   nz, xdo141     ; 3:10      xloop 141
    ld    A, B          ; 1:4       xloop 141
    xor  high 2         ; 2:7       xloop 141
    jp   nz, xdo141     ; 3:10      xloop 141
xleave141:              ;           xloop 141
xexit141:               ;           xloop 141 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string159  ; 3:10      print_z   Address of null-terminated string159 == string160
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       2 -1 rxdo 142
    dec  HL             ; 1:6       2 -1 rxdo 142
    ld  (HL),high -1    ; 2:10      2 -1 rxdo 142
    dec   L             ; 1:4       2 -1 rxdo 142
    ld  (HL),low -1     ; 2:10      2 -1 rxdo 142
    exx                 ; 1:4       2 -1 rxdo 142 R:( -- -1 )
do142:                  ;           2 -1 rxdo 142 
    exx                 ; 1:4       index ri 142    
    ld    E,(HL)        ; 1:7       index ri 142
    inc   L             ; 1:4       index ri 142
    ld    D,(HL)        ; 1:7       index ri 142
    push DE             ; 1:11      index ri 142
    dec   L             ; 1:4       index ri 142
    exx                 ; 1:4       index ri 142
    ex   DE, HL         ; 1:4       index ri 142
    ex  (SP),HL         ; 1:19      index ri 142 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       rxloop 142
    ld    E,(HL)        ; 1:7       rxloop 142
    inc   L             ; 1:4       rxloop 142
    ld    D,(HL)        ; 1:7       rxloop 142
    inc  DE             ; 1:6       rxloop 142 index++
    ld    A, low 2      ; 2:7       rxloop 142
    xor   E             ; 1:4       rxloop 142
    jr   nz, $+7        ; 2:7/12    rxloop 142
    ld    A, high 2     ; 2:7       rxloop 142
    xor   D             ; 1:4       rxloop 142
    jr    z, leave142   ; 2:7/12    rxloop 142 exit
    ld  (HL), D         ; 1:7       rxloop 142
    dec   L             ; 1:4       rxloop 142
    ld  (HL), E         ; 1:6       rxloop 142
    exx                 ; 1:4       rxloop 142
    jp   do142          ; 3:10      rxloop 142
leave142:               ;           rxloop 142
    inc  HL             ; 1:6       rxloop 142
    exx                 ; 1:4       rxloop 142 R:( index -- )
exit142:                ; 1:4       rxloop 142 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string161  ; 3:10      print_z   Address of null-terminated string161
    call PRINT_STRING_Z ; 3:17      print_z  

    ld   BC, -5         ; 3:10      xdo(-1,-5) 143
    ld  (idx143),BC     ; 4:20      xdo(-1,-5) 143
xdo143:                 ;           xdo(-1,-5) 143  
    push DE             ; 1:11      index i 143
    ex   DE, HL         ; 1:4       index i 143
    ld   HL, (idx143)   ; 3:16      index i 143 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .  
idx143 EQU $+1          ;           xloop 143 hi index == hi stop && index < stop
    ld   BC, 0x0000     ; 3:10      xloop 143 idx always points to a 16-bit index
    ld    A, C          ; 1:4       xloop 143
    inc   A             ; 1:4       xloop 143 index++
    ld  (idx143),A      ; 3:13      xloop 143 save index
    sub  low -1         ; 2:7       xloop 143 index - stop
    jp    c, xdo143     ; 3:10      xloop 143
xleave143:              ;           xloop 143
xexit143:               ;           xloop 143 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string161  ; 3:10      print_z   Address of null-terminated string161 == string162
    call PRINT_STRING_Z ; 3:17      print_z 

    exx                 ; 1:4       -1 -5 rxdo 144
    dec  HL             ; 1:6       -1 -5 rxdo 144
    ld  (HL),high -5    ; 2:10      -1 -5 rxdo 144
    dec   L             ; 1:4       -1 -5 rxdo 144
    ld  (HL),low -5     ; 2:10      -1 -5 rxdo 144
    exx                 ; 1:4       -1 -5 rxdo 144 R:( -- -5 )
do144:                  ;           -1 -5 rxdo 144 
    exx                 ; 1:4       index ri 144    
    ld    E,(HL)        ; 1:7       index ri 144
    inc   L             ; 1:4       index ri 144
    ld    D,(HL)        ; 1:7       index ri 144
    push DE             ; 1:11      index ri 144
    dec   L             ; 1:4       index ri 144
    exx                 ; 1:4       index ri 144
    ex   DE, HL         ; 1:4       index ri 144
    ex  (SP),HL         ; 1:19      index ri 144 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       rxloop 144
    ld    E,(HL)        ; 1:7       rxloop 144
    inc   L             ; 1:4       rxloop 144
    ld    D,(HL)        ; 1:7       rxloop 144
    inc  DE             ; 1:6       rxloop 144 index++
    ld    A, low -1     ; 2:7       rxloop 144
    xor   E             ; 1:4       rxloop 144
    jr   nz, $+7        ; 2:7/12    rxloop 144
    ld    A, high -1    ; 2:7       rxloop 144
    xor   D             ; 1:4       rxloop 144
    jr    z, leave144   ; 2:7/12    rxloop 144 exit
    ld  (HL), D         ; 1:7       rxloop 144
    dec   L             ; 1:4       rxloop 144
    ld  (HL), E         ; 1:6       rxloop 144
    exx                 ; 1:4       rxloop 144
    jp   do144          ; 3:10      rxloop 144
leave144:               ;           rxloop 144
    inc  HL             ; 1:6       rxloop 144
    exx                 ; 1:4       rxloop 144 R:( index -- )
exit144:                ; 1:4       rxloop 144 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string163  ; 3:10      print_z   Address of null-terminated string163
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop)  

    ld   BC, 1          ; 3:10      xdo(-1,1) 145
    ld  (idx145),BC     ; 4:20      xdo(-1,1) 145
xdo145:                 ;           xdo(-1,1) 145  
    push DE             ; 1:11      index i 145
    ex   DE, HL         ; 1:4       index i 145
    ld   HL, (idx145)   ; 3:16      index i 145 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else119    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string164
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave145      ;           xleave 145 
else119  EQU $          ;           = endif
endif119:  
idx145 EQU $+1          ;[20:~71]   xloop 145 1..-1
    ld   BC, 0x0000     ; 3:10      xloop 145 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 145 index++
    ld  (idx145),BC     ; 4:20      xloop 145 save index
    ld    A, C          ; 1:4       xloop 145
    xor  low -1         ; 2:7       xloop 145
    jp   nz, xdo145     ; 3:10      xloop 145
    ld    A, B          ; 1:4       xloop 145
    xor  high -1        ; 2:7       xloop 145
    jp   nz, xdo145     ; 3:10      xloop 145
xleave145:              ;           xloop 145
xexit145:               ;           xloop 145 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string163  ; 3:10      print_z   Address of null-terminated string163 == string165
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       -1 1 rxdo 146
    dec  HL             ; 1:6       -1 1 rxdo 146
    ld  (HL),high 1     ; 2:10      -1 1 rxdo 146
    dec   L             ; 1:4       -1 1 rxdo 146
    ld  (HL),low 1      ; 2:10      -1 1 rxdo 146
    exx                 ; 1:4       -1 1 rxdo 146 R:( -- 1 )
do146:                  ;           -1 1 rxdo 146 
    exx                 ; 1:4       index ri 146    
    ld    E,(HL)        ; 1:7       index ri 146
    inc   L             ; 1:4       index ri 146
    ld    D,(HL)        ; 1:7       index ri 146
    push DE             ; 1:11      index ri 146
    dec   L             ; 1:4       index ri 146
    exx                 ; 1:4       index ri 146
    ex   DE, HL         ; 1:4       index ri 146
    ex  (SP),HL         ; 1:19      index ri 146 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else120    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string166
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 146
    inc  L              ; 1:4       rxleave 146
    jp  leave146        ;           rxleave 146 
else120  EQU $          ;           = endif
endif120: 
    exx                 ; 1:4       rxloop 146
    ld    E,(HL)        ; 1:7       rxloop 146
    inc   L             ; 1:4       rxloop 146
    ld    D,(HL)        ; 1:7       rxloop 146
    inc  DE             ; 1:6       rxloop 146 index++
    ld    A, low -1     ; 2:7       rxloop 146
    xor   E             ; 1:4       rxloop 146
    jr   nz, $+7        ; 2:7/12    rxloop 146
    ld    A, high -1    ; 2:7       rxloop 146
    xor   D             ; 1:4       rxloop 146
    jr    z, leave146   ; 2:7/12    rxloop 146 exit
    ld  (HL), D         ; 1:7       rxloop 146
    dec   L             ; 1:4       rxloop 146
    ld  (HL), E         ; 1:6       rxloop 146
    exx                 ; 1:4       rxloop 146
    jp   do146          ; 3:10      rxloop 146
leave146:               ;           rxloop 146
    inc  HL             ; 1:6       rxloop 146
    exx                 ; 1:4       rxloop 146 R:( index -- )
exit146:                ; 1:4       rxloop 146 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string167  ; 3:10      print_z   Address of null-terminated string167
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop)  

    ld   BC, 0          ; 3:10      xdo(0,0) 147
    ld  (idx147),BC     ; 4:20      xdo(0,0) 147
xdo147:                 ;           xdo(0,0) 147  
    push DE             ; 1:11      index i 147
    ex   DE, HL         ; 1:4       index i 147
    ld   HL, (idx147)   ; 3:16      index i 147 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else121    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string168
    call PRINT_STRING_Z ; 3:17      print_z
    jp   xleave147      ;           xleave 147 
else121  EQU $          ;           = endif
endif121:  
idx147 EQU $+1          ;[20:~71]   xloop 147 0..0
    ld   BC, 0x0000     ; 3:10      xloop 147 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 147 index++
    ld  (idx147),BC     ; 4:20      xloop 147 save index
    ld    A, C          ; 1:4       xloop 147
    xor  low 0          ; 2:7       xloop 147
    jp   nz, xdo147     ; 3:10      xloop 147
    ld    A, B          ; 1:4       xloop 147
    xor  high 0         ; 2:7       xloop 147
    jp   nz, xdo147     ; 3:10      xloop 147
xleave147:              ;           xloop 147
xexit147:               ;           xloop 147 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld   BC, string167  ; 3:10      print_z   Address of null-terminated string167 == string169
    call PRINT_STRING_Z ; 3:17      print_z 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       0 0 rxdo 148
    dec  HL             ; 1:6       0 0 rxdo 148
    ld  (HL),high 0     ; 2:10      0 0 rxdo 148
    dec   L             ; 1:4       0 0 rxdo 148
    ld  (HL),low 0      ; 2:10      0 0 rxdo 148
    exx                 ; 1:4       0 0 rxdo 148 R:( -- 0 )
do148:                  ;           0 0 rxdo 148 
    exx                 ; 1:4       index ri 148    
    ld    E,(HL)        ; 1:7       index ri 148
    inc   L             ; 1:4       index ri 148
    ld    D,(HL)        ; 1:7       index ri 148
    push DE             ; 1:11      index ri 148
    dec   L             ; 1:4       index ri 148
    exx                 ; 1:4       index ri 148
    ex   DE, HL         ; 1:4       index ri 148
    ex  (SP),HL         ; 1:19      index ri 148 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else122    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string170
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rxleave 148
    inc  L              ; 1:4       rxleave 148
    jp  leave148        ;           rxleave 148 
else122  EQU $          ;           = endif
endif122: 
    exx                 ; 1:4       rxloop 148
    ld    E,(HL)        ; 1:7       rxloop 148
    inc   L             ; 1:4       rxloop 148
    ld    D,(HL)        ; 1:7       rxloop 148
    inc  DE             ; 1:6       rxloop 148 index++
    ld    A, low 0      ; 2:7       rxloop 148
    xor   E             ; 1:4       rxloop 148
    jr   nz, $+7        ; 2:7/12    rxloop 148
    ld    A, high 0     ; 2:7       rxloop 148
    xor   D             ; 1:4       rxloop 148
    jr    z, leave148   ; 2:7/12    rxloop 148 exit
    ld  (HL), D         ; 1:7       rxloop 148
    dec   L             ; 1:4       rxloop 148
    ld  (HL), E         ; 1:6       rxloop 148
    exx                 ; 1:4       rxloop 148
    jp   do148          ; 3:10      rxloop 148
leave148:               ;           rxloop 148
    inc  HL             ; 1:6       rxloop 148
    exx                 ; 1:4       rxloop 148 R:( index -- )
exit148:                ; 1:4       rxloop 148 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====


;   ---  the beginning of a non-recursive function  ---
_down1:                 ;           
    pop  BC             ; 1:10      : ret
    ld  (_down1_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string171  ; 3:10      print_z   Address of null-terminated string171
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 149 index
    push DE             ; 1:11      rdo 149 stop
    exx                 ; 1:4       rdo 149
    pop  DE             ; 1:10      rdo 149 stop
    dec  HL             ; 1:6       rdo 149
    ld  (HL),D          ; 1:7       rdo 149
    dec  L              ; 1:4       rdo 149
    ld  (HL),E          ; 1:7       rdo 149 stop
    pop  DE             ; 1:10      rdo 149 index
    dec  HL             ; 1:6       rdo 149
    ld  (HL),D          ; 1:7       rdo 149
    dec  L              ; 1:4       rdo 149
    ld  (HL),E          ; 1:7       rdo 149 index
    exx                 ; 1:4       rdo 149
    pop  HL             ; 1:10      rdo 149
    pop  DE             ; 1:10      rdo 149 ( stop index -- ) R: ( -- stop index )
do149:                  ;           rdo 149 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else123    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string172
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 149
    inc  L              ; 1:4       rleave 149
    inc  HL             ; 1:6       rleave 149
    inc  L              ; 1:4       rleave 149
    jp   leave149       ;           rleave 149 
else123  EQU $          ;           = endif
endif123: 
        
    exx                 ; 1:4       index ri 149    
    ld    E,(HL)        ; 1:7       index ri 149
    inc   L             ; 1:4       index ri 149
    ld    D,(HL)        ; 1:7       index ri 149
    push DE             ; 1:11      index ri 149
    dec   L             ; 1:4       index ri 149
    exx                 ; 1:4       index ri 149
    ex   DE, HL         ; 1:4       index ri 149
    ex  (SP),HL         ; 1:19      index ri 149 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    ex  (SP),HL         ; 1:19      +rloop 149
    ex   DE, HL         ; 1:4       +rloop 149
    exx                 ; 1:4       +rloop 149
    ld    E,(HL)        ; 1:7       +rloop 149
    inc   L             ; 1:4       +rloop 149
    ld    D,(HL)        ; 1:7       +rloop 149 DE = index
    inc  HL             ; 1:6       +rloop 149
    ld    C,(HL)        ; 1:7       +rloop 149
    inc   L             ; 1:4       +rloop 149
    ld    B,(HL)        ; 1:7       +rloop 149 BC = stop
    ex  (SP),HL         ; 1:19      +rloop 149 HL = step
    ex   DE, HL         ; 1:4       +rloop 149
    xor   A             ; 1:4       +rloop 149
    sbc  HL, BC         ; 2:15      +rloop 149 HL = index-stop
    ld    A, H          ; 1:4       +rloop 149
    add  HL, DE         ; 1:11      +rloop 149 HL = index-stop+step
    xor   H             ; 1:4       +rloop 149
    add  HL, BC         ; 1:11      +rloop 149 HL = index+step
    ex   DE, HL         ; 1:4       +rloop 149
    pop  HL             ; 1:10      +rloop 149
    jp    m, leave149   ; 3:10      +rloop 149
    dec   L             ; 1:4       +rloop 149    
    dec  HL             ; 1:6       +rloop 149
    ld  (HL),D          ; 1:7       +rloop 149    
    dec   L             ; 1:4       +rloop 149
    ld  (HL),E          ; 1:7       +rloop 149
    exx                 ; 1:4       +rloop 149
    jp    p, do149      ; 3:10      +rloop 149 ( step -- ) R:( stop index -- stop index+step )
leave149:               ;           +rloop 149
    inc  HL             ; 1:6       +rloop 149
    exx                 ; 1:4       +rloop 149 ( step -- ) R:( stop index -- )
exit149:                ;           +rloop 149
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string173  ; 3:10      print_z   Address of null-terminated string173
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 150 index
    push DE             ; 1:11      rdo 150 stop
    exx                 ; 1:4       rdo 150
    pop  DE             ; 1:10      rdo 150 stop
    dec  HL             ; 1:6       rdo 150
    ld  (HL),D          ; 1:7       rdo 150
    dec  L              ; 1:4       rdo 150
    ld  (HL),E          ; 1:7       rdo 150 stop
    pop  DE             ; 1:10      rdo 150 index
    dec  HL             ; 1:6       rdo 150
    ld  (HL),D          ; 1:7       rdo 150
    dec  L              ; 1:4       rdo 150
    ld  (HL),E          ; 1:7       rdo 150 index
    exx                 ; 1:4       rdo 150
    pop  HL             ; 1:10      rdo 150
    pop  DE             ; 1:10      rdo 150 ( stop index -- ) R: ( -- stop index )
do150:                  ;           rdo 150 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else124    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string174
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 150
    inc  L              ; 1:4       rleave 150
    inc  HL             ; 1:6       rleave 150
    inc  L              ; 1:4       rleave 150
    jp   leave150       ;           rleave 150 
else124  EQU $          ;           = endif
endif124: 
        
    exx                 ; 1:4       index ri 150    
    ld    E,(HL)        ; 1:7       index ri 150
    inc   L             ; 1:4       index ri 150
    ld    D,(HL)        ; 1:7       index ri 150
    push DE             ; 1:11      index ri 150
    dec   L             ; 1:4       index ri 150
    exx                 ; 1:4       index ri 150
    ex   DE, HL         ; 1:4       index ri 150
    ex  (SP),HL         ; 1:19      index ri 150 
    call PRINT_S16      ; 3:17      .
    
                        ;           -1 +rloop 150
    exx                 ; 1:4       -1 +rloop 150
    ld    E,(HL)        ; 1:7       -1 +rloop 150
    inc   L             ; 1:4       -1 +rloop 150
    ld    D,(HL)        ; 1:7       -1 +rloop 150 DE = index   
    inc  HL             ; 1:6       -1 +rloop 150
    ld    A,(HL)        ; 1:7       -1 +rloop 150
    xor   E             ; 1:4       -1 +rloop 150 lo index - stop
    jr   nz, $+8        ; 2:7/12    -1 +rloop 150
    inc   L             ; 1:4       -1 +rloop 150
    ld    A,(HL)        ; 1:7       -1 +rloop 150
    xor   D             ; 1:4       -1 +rloop 150 hi index - stop
    jr    z, leave150   ; 2:7/12    -1 +rloop 150 exit    
    dec   L             ; 1:4       -1 +rloop 150
    dec  HL             ; 1:6       -1 +rloop 150
    dec  DE             ; 1:6       -1 +rloop 150 index--
    ld  (HL), D         ; 1:7       -1 +rloop 150
    dec   L             ; 1:4       -1 +rloop 150
    ld  (HL), E         ; 1:7       -1 +rloop 150
    exx                 ; 1:4       -1 +rloop 150
    jp   do150          ; 3:10      -1 +rloop 150
leave150:               ;           -1 +rloop 150
    inc  HL             ; 1:6       -1 +rloop 150
    exx                 ; 1:4       -1 +rloop 150
exit150 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string175  ; 3:10      print_z   Address of null-terminated string175
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx151), HL    ; 3:16      do 151 save index
    dec  DE             ; 1:6       do 151 stop-1
    ld    A, E          ; 1:4       do 151 
    ld  (stp_lo151), A  ; 3:13      do 151 lo stop
    ld    A, D          ; 1:4       do 151 
    ld  (stp_hi151), A  ; 3:13      do 151 hi stop
    pop  HL             ; 1:10      do 151
    pop  DE             ; 1:10      do 151 ( -- ) R: ( -- )
do151:                  ;           do 151
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else125    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string176
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave151       ;           leave 151 
else125  EQU $          ;           = endif
endif125: 
        
    push DE             ; 1:11      index i 151
    ex   DE, HL         ; 1:4       index i 151
    ld   HL, (idx151)   ; 3:16      index i 151 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    ld    B, H          ; 1:4       +loop 151
    ld    C, L          ; 1:4       +loop 151 BC = step
idx151 EQU $+1          ;           +loop 151
    ld   HL, 0x0000     ; 3:10      +loop 151
    add  HL, BC         ; 1:11      +loop 151 HL = index+step
    ld  (idx151), HL    ; 3:16      +loop 151 save index
stp_lo151 EQU $+1       ;           +loop 151
    ld    A, 0x00       ; 2:7       +loop 151 lo stop
    sub   L             ; 1:4       +loop 151
    ld    L, A          ; 1:4       +loop 151
stp_hi151 EQU $+1       ;           +loop 151
    ld    A, 0x00       ; 2:7       +loop 151 hi stop
    sbc   A, H          ; 1:4       +loop 151
    ld    H, A          ; 1:4       +loop 151 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 151 HL = stop-index
    xor   H             ; 1:4       +loop 151
    ex   DE, HL         ; 1:4       +loop 151
    pop  DE             ; 1:10      +loop 151
    jp    p, do151      ; 3:10      +loop 151
leave151:               ;           +loop 151
exit151:                ;           +loop 151 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string177  ; 3:10      print_z   Address of null-terminated string177
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx152), HL    ; 3:16      do 152 save index
    dec  DE             ; 1:6       do 152 stop-1
    ld    A, E          ; 1:4       do 152 
    ld  (stp_lo152), A  ; 3:13      do 152 lo stop
    ld    A, D          ; 1:4       do 152 
    ld  (stp_hi152), A  ; 3:13      do 152 hi stop
    pop  HL             ; 1:10      do 152
    pop  DE             ; 1:10      do 152 ( -- ) R: ( -- )
do152:                  ;           do 152 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else126    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string178
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave152       ;           leave 152 
else126  EQU $          ;           = endif
endif126: 
        
    push DE             ; 1:11      index i 152
    ex   DE, HL         ; 1:4       index i 152
    ld   HL, (idx152)   ; 3:16      index i 152 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
                        ;           push_addloop(-1) 152
idx152 EQU $+1          ;           -1 +loop 152
    ld   BC, 0x0000     ; 3:10      -1 +loop 152 idx always points to a 16-bit index
    dec  BC             ; 1:6       -1 +loop 152 index--
    ld  (idx152),BC     ; 4:20      -1 +loop 152 save index
    ld    A, C          ; 1:4       -1 +loop 152
stp_lo152 EQU $+1       ;           -1 +loop 152
    xor  0x00           ; 2:7       -1 +loop 152 lo index - stop - 1
    jp   nz, do152      ; 3:10      -1 +loop 152
    ld    A, B          ; 1:4       -1 +loop 152
stp_hi152 EQU $+1       ;           -1 +loop 152
    xor  0x00           ; 2:7       -1 +loop 152 hi index - stop - 1
    jp   nz, do152      ; 3:10      -1 +loop 152
leave152:               ;           -1 +loop 152
exit152:                ;           -1 +loop 152 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string179  ; 3:10      print_z   Address of null-terminated string179
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo153:                 ;           sdo 153 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else127    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string180
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave153      ; 3:10      sleave 153 
else127  EQU $          ;           = endif
endif127: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    pop  BC             ; 1:10      +sloop 153 BC = stop
    ex   DE, HL         ; 1:4       +sloop 153
    or    A             ; 1:4       +sloop 153
    sbc  HL, BC         ; 2:15      +sloop 153 HL = index-stop
    ld    A, H          ; 1:4       +sloop 153
    add  HL, DE         ; 1:11      +sloop 153 HL = index-stop+step
    xor   H             ; 1:4       +sloop 153 sign flag!
    add  HL, BC         ; 1:11      +sloop 153 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 153
    ld    E, C          ; 1:4       +sloop 153
    jp    p, sdo153     ; 3:10      +sloop 153
sleave153:              ;           +sloop 153
    pop  HL             ; 1:10      unsloop 153 index out
    pop  DE             ; 1:10      unsloop 153 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string181  ; 3:10      print_z   Address of null-terminated string181
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo154:                 ;           sdo 154 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else128    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string182
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave154      ; 3:10      sleave 154 
else128  EQU $          ;           = endif
endif128: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
                        ;           push_addsloop(-1) 154
    ld    A, L          ; 1:4       -1 +sloop 154
    xor   E             ; 1:4       -1 +sloop 154 lo index - stop
    ld    A, H          ; 1:4       -1 +sloop 154
    dec  HL             ; 1:6       -1 +sloop 154 index--
    jp   nz, sdo154     ; 3:10      -1 +sloop 154
    xor   D             ; 1:4       -1 +sloop 154 hi index - stop
    jp   nz, sdo154     ; 3:10      -1 +sloop 154
sleave154:              ;           -1 +sloop 154
    pop  HL             ; 1:10      unsloop 154 index out
    pop  DE             ; 1:10      unsloop 154 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_down1_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
_up1:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_up1_end+1),BC ; 4:20      : ( ret -- ) R:( -- ) 
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string183  ; 3:10      print_z   Address of null-terminated string183
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 155 index
    push DE             ; 1:11      rdo 155 stop
    exx                 ; 1:4       rdo 155
    pop  DE             ; 1:10      rdo 155 stop
    dec  HL             ; 1:6       rdo 155
    ld  (HL),D          ; 1:7       rdo 155
    dec  L              ; 1:4       rdo 155
    ld  (HL),E          ; 1:7       rdo 155 stop
    pop  DE             ; 1:10      rdo 155 index
    dec  HL             ; 1:6       rdo 155
    ld  (HL),D          ; 1:7       rdo 155
    dec  L              ; 1:4       rdo 155
    ld  (HL),E          ; 1:7       rdo 155 index
    exx                 ; 1:4       rdo 155
    pop  HL             ; 1:10      rdo 155
    pop  DE             ; 1:10      rdo 155 ( stop index -- ) R: ( -- stop index )
do155:                  ;           rdo 155 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else129    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string184
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 155
    inc  L              ; 1:4       rleave 155
    inc  HL             ; 1:6       rleave 155
    inc  L              ; 1:4       rleave 155
    jp   leave155       ;           rleave 155 
else129  EQU $          ;           = endif
endif129: 
        
    exx                 ; 1:4       index ri 155    
    ld    E,(HL)        ; 1:7       index ri 155
    inc   L             ; 1:4       index ri 155
    ld    D,(HL)        ; 1:7       index ri 155
    push DE             ; 1:11      index ri 155
    dec   L             ; 1:4       index ri 155
    exx                 ; 1:4       index ri 155
    ex   DE, HL         ; 1:4       index ri 155
    ex  (SP),HL         ; 1:19      index ri 155 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ex  (SP),HL         ; 1:19      +rloop 155
    ex   DE, HL         ; 1:4       +rloop 155
    exx                 ; 1:4       +rloop 155
    ld    E,(HL)        ; 1:7       +rloop 155
    inc   L             ; 1:4       +rloop 155
    ld    D,(HL)        ; 1:7       +rloop 155 DE = index
    inc  HL             ; 1:6       +rloop 155
    ld    C,(HL)        ; 1:7       +rloop 155
    inc   L             ; 1:4       +rloop 155
    ld    B,(HL)        ; 1:7       +rloop 155 BC = stop
    ex  (SP),HL         ; 1:19      +rloop 155 HL = step
    ex   DE, HL         ; 1:4       +rloop 155
    xor   A             ; 1:4       +rloop 155
    sbc  HL, BC         ; 2:15      +rloop 155 HL = index-stop
    ld    A, H          ; 1:4       +rloop 155
    add  HL, DE         ; 1:11      +rloop 155 HL = index-stop+step
    xor   H             ; 1:4       +rloop 155
    add  HL, BC         ; 1:11      +rloop 155 HL = index+step
    ex   DE, HL         ; 1:4       +rloop 155
    pop  HL             ; 1:10      +rloop 155
    jp    m, leave155   ; 3:10      +rloop 155
    dec   L             ; 1:4       +rloop 155    
    dec  HL             ; 1:6       +rloop 155
    ld  (HL),D          ; 1:7       +rloop 155    
    dec   L             ; 1:4       +rloop 155
    ld  (HL),E          ; 1:7       +rloop 155
    exx                 ; 1:4       +rloop 155
    jp    p, do155      ; 3:10      +rloop 155 ( step -- ) R:( stop index -- stop index+step )
leave155:               ;           +rloop 155
    inc  HL             ; 1:6       +rloop 155
    exx                 ; 1:4       +rloop 155 ( step -- ) R:( stop index -- )
exit155:                ;           +rloop 155
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string185  ; 3:10      print_z   Address of null-terminated string185
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 156 index
    push DE             ; 1:11      rdo 156 stop
    exx                 ; 1:4       rdo 156
    pop  DE             ; 1:10      rdo 156 stop
    dec  HL             ; 1:6       rdo 156
    ld  (HL),D          ; 1:7       rdo 156
    dec  L              ; 1:4       rdo 156
    ld  (HL),E          ; 1:7       rdo 156 stop
    pop  DE             ; 1:10      rdo 156 index
    dec  HL             ; 1:6       rdo 156
    ld  (HL),D          ; 1:7       rdo 156
    dec  L              ; 1:4       rdo 156
    ld  (HL),E          ; 1:7       rdo 156 index
    exx                 ; 1:4       rdo 156
    pop  HL             ; 1:10      rdo 156
    pop  DE             ; 1:10      rdo 156 ( stop index -- ) R: ( -- stop index )
do156:                  ;           rdo 156  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else130    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string186
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 156
    inc  L              ; 1:4       rleave 156
    inc  HL             ; 1:6       rleave 156
    inc  L              ; 1:4       rleave 156
    jp   leave156       ;           rleave 156 
else130  EQU $          ;           = endif
endif130: 
        
    exx                 ; 1:4       index ri 156    
    ld    E,(HL)        ; 1:7       index ri 156
    inc   L             ; 1:4       index ri 156
    ld    D,(HL)        ; 1:7       index ri 156
    push DE             ; 1:11      index ri 156
    dec   L             ; 1:4       index ri 156
    exx                 ; 1:4       index ri 156
    ex   DE, HL         ; 1:4       index ri 156
    ex  (SP),HL         ; 1:19      index ri 156 
    call PRINT_S16      ; 3:17      .
    
                        ;           1 +rloop 156
    exx                 ; 1:4       rloop 156
    ld    E,(HL)        ; 1:7       rloop 156
    inc   L             ; 1:4       rloop 156
    ld    D,(HL)        ; 1:7       rloop 156 DE = index   
    inc  HL             ; 1:6       rloop 156
    inc  DE             ; 1:6       rloop 156 index++
    ld    A,(HL)        ; 1:4       rloop 156
    xor   E             ; 1:4       rloop 156 lo index - stop
    jr   nz, $+8        ; 2:7/12    rloop 156
    ld    A, D          ; 1:4       rloop 156
    inc   L             ; 1:4       rloop 156
    xor (HL)            ; 1:7       rloop 156 hi index - stop
    jr    z, leave156   ; 2:7/12    rloop 156 exit    
    dec   L             ; 1:4       rloop 156
    dec  HL             ; 1:6       rloop 156
    ld  (HL), D         ; 1:7       rloop 156
    dec   L             ; 1:4       rloop 156
    ld  (HL), E         ; 1:7       rloop 156
    exx                 ; 1:4       rloop 156
    jp   do156          ; 3:10      rloop 156
leave156:               ;           rloop 156
    inc  HL             ; 1:6       rloop 156
    exx                 ; 1:4       rloop 156
exit156:                ;           rloop 156 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string183  ; 3:10      print_z   Address of null-terminated string183 == string187
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx157), HL    ; 3:16      do 157 save index
    dec  DE             ; 1:6       do 157 stop-1
    ld    A, E          ; 1:4       do 157 
    ld  (stp_lo157), A  ; 3:13      do 157 lo stop
    ld    A, D          ; 1:4       do 157 
    ld  (stp_hi157), A  ; 3:13      do 157 hi stop
    pop  HL             ; 1:10      do 157
    pop  DE             ; 1:10      do 157 ( -- ) R: ( -- )
do157:                  ;           do 157 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else131    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string188
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave157       ;           leave 157 
else131  EQU $          ;           = endif
endif131: 
        
    push DE             ; 1:11      index i 157
    ex   DE, HL         ; 1:4       index i 157
    ld   HL, (idx157)   ; 3:16      index i 157 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ld    B, H          ; 1:4       +loop 157
    ld    C, L          ; 1:4       +loop 157 BC = step
idx157 EQU $+1          ;           +loop 157
    ld   HL, 0x0000     ; 3:10      +loop 157
    add  HL, BC         ; 1:11      +loop 157 HL = index+step
    ld  (idx157), HL    ; 3:16      +loop 157 save index
stp_lo157 EQU $+1       ;           +loop 157
    ld    A, 0x00       ; 2:7       +loop 157 lo stop
    sub   L             ; 1:4       +loop 157
    ld    L, A          ; 1:4       +loop 157
stp_hi157 EQU $+1       ;           +loop 157
    ld    A, 0x00       ; 2:7       +loop 157 hi stop
    sbc   A, H          ; 1:4       +loop 157
    ld    H, A          ; 1:4       +loop 157 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 157 HL = stop-index
    xor   H             ; 1:4       +loop 157
    ex   DE, HL         ; 1:4       +loop 157
    pop  DE             ; 1:10      +loop 157
    jp    p, do157      ; 3:10      +loop 157
leave157:               ;           +loop 157
exit157:                ;           +loop 157 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string185  ; 3:10      print_z   Address of null-terminated string185 == string189
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx158), HL    ; 3:16      do 158 save index
    dec  DE             ; 1:6       do 158 stop-1
    ld    A, E          ; 1:4       do 158 
    ld  (stp_lo158), A  ; 3:13      do 158 lo stop
    ld    A, D          ; 1:4       do 158 
    ld  (stp_hi158), A  ; 3:13      do 158 hi stop
    pop  HL             ; 1:10      do 158
    pop  DE             ; 1:10      do 158 ( -- ) R: ( -- )
do158:                  ;           do 158 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else132    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string190
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave158       ;           leave 158 
else132  EQU $          ;           = endif
endif132: 
        
    push DE             ; 1:11      index i 158
    ex   DE, HL         ; 1:4       index i 158
    ld   HL, (idx158)   ; 3:16      index i 158 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
                        ;           push_addloop(1) 158
idx158 EQU $+1          ;           loop 158
    ld   BC, 0x0000     ; 3:10      loop 158 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 158
stp_lo158 EQU $+1       ;           loop 158
    xor  0x00           ; 2:7       loop 158 lo index - stop - 1
    ld    A, B          ; 1:4       loop 158
    inc  BC             ; 1:6       loop 158 index++
    ld  (idx158),BC     ; 4:20      loop 158 save index
    jp   nz, do158      ; 3:10      loop 158    
stp_hi158 EQU $+1       ;           loop 158
    xor  0x00           ; 2:7       loop 158 hi index - stop - 1
    jp   nz, do158      ; 3:10      loop 158
leave158:               ;           loop 158
exit158:                ;           loop 158 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string191  ; 3:10      print_z   Address of null-terminated string191
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo159:                 ;           sdo 159 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else133    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string192
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave159      ; 3:10      sleave 159 
else133  EQU $          ;           = endif
endif133: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    pop  BC             ; 1:10      +sloop 159 BC = stop
    ex   DE, HL         ; 1:4       +sloop 159
    or    A             ; 1:4       +sloop 159
    sbc  HL, BC         ; 2:15      +sloop 159 HL = index-stop
    ld    A, H          ; 1:4       +sloop 159
    add  HL, DE         ; 1:11      +sloop 159 HL = index-stop+step
    xor   H             ; 1:4       +sloop 159 sign flag!
    add  HL, BC         ; 1:11      +sloop 159 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 159
    ld    E, C          ; 1:4       +sloop 159
    jp    p, sdo159     ; 3:10      +sloop 159
sleave159:              ;           +sloop 159
    pop  HL             ; 1:10      unsloop 159 index out
    pop  DE             ; 1:10      unsloop 159 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string193  ; 3:10      print_z   Address of null-terminated string193
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo160:                 ;           sdo 160 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else134    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string194
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave160      ; 3:10      sleave 160 
else134  EQU $          ;           = endif
endif134: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
                        ;           push_addsloop(1) 160
    inc  HL             ; 1:6       sloop 160 index++
    ld    A, E          ; 1:4       sloop 160
    xor   L             ; 1:4       sloop 160 lo index - stop
    jp   nz, sdo160     ; 3:10      sloop 160
    ld    A, D          ; 1:4       sloop 160
    xor   H             ; 1:4       sloop 160 hi index - stop
    jp   nz, sdo160     ; 3:10      sloop 160
sleave160:              ;           sloop 160
    pop  HL             ; 1:10      unsloop 160 index out
    pop  DE             ; 1:10      unsloop 160 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_up1_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
_down2:                 ;           
    pop  BC             ; 1:10      : ret
    ld  (_down2_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string195  ; 3:10      print_z   Address of null-terminated string195
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 161 index
    push DE             ; 1:11      rdo 161 stop
    exx                 ; 1:4       rdo 161
    pop  DE             ; 1:10      rdo 161 stop
    dec  HL             ; 1:6       rdo 161
    ld  (HL),D          ; 1:7       rdo 161
    dec  L              ; 1:4       rdo 161
    ld  (HL),E          ; 1:7       rdo 161 stop
    pop  DE             ; 1:10      rdo 161 index
    dec  HL             ; 1:6       rdo 161
    ld  (HL),D          ; 1:7       rdo 161
    dec  L              ; 1:4       rdo 161
    ld  (HL),E          ; 1:7       rdo 161 index
    exx                 ; 1:4       rdo 161
    pop  HL             ; 1:10      rdo 161
    pop  DE             ; 1:10      rdo 161 ( stop index -- ) R: ( -- stop index )
do161:                  ;           rdo 161  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else135    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string196
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 161
    inc  L              ; 1:4       rleave 161
    inc  HL             ; 1:6       rleave 161
    inc  L              ; 1:4       rleave 161
    jp   leave161       ;           rleave 161 
else135  EQU $          ;           = endif
endif135: 
        
    exx                 ; 1:4       index ri 161    
    ld    E,(HL)        ; 1:7       index ri 161
    inc   L             ; 1:4       index ri 161
    ld    D,(HL)        ; 1:7       index ri 161
    push DE             ; 1:11      index ri 161
    dec   L             ; 1:4       index ri 161
    exx                 ; 1:4       index ri 161
    ex   DE, HL         ; 1:4       index ri 161
    ex  (SP),HL         ; 1:19      index ri 161 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(-2)
    ex   DE, HL         ; 1:4       push(-2)
    ld   HL, -2         ; 3:10      push(-2) 
    ex  (SP),HL         ; 1:19      +rloop 161
    ex   DE, HL         ; 1:4       +rloop 161
    exx                 ; 1:4       +rloop 161
    ld    E,(HL)        ; 1:7       +rloop 161
    inc   L             ; 1:4       +rloop 161
    ld    D,(HL)        ; 1:7       +rloop 161 DE = index
    inc  HL             ; 1:6       +rloop 161
    ld    C,(HL)        ; 1:7       +rloop 161
    inc   L             ; 1:4       +rloop 161
    ld    B,(HL)        ; 1:7       +rloop 161 BC = stop
    ex  (SP),HL         ; 1:19      +rloop 161 HL = step
    ex   DE, HL         ; 1:4       +rloop 161
    xor   A             ; 1:4       +rloop 161
    sbc  HL, BC         ; 2:15      +rloop 161 HL = index-stop
    ld    A, H          ; 1:4       +rloop 161
    add  HL, DE         ; 1:11      +rloop 161 HL = index-stop+step
    xor   H             ; 1:4       +rloop 161
    add  HL, BC         ; 1:11      +rloop 161 HL = index+step
    ex   DE, HL         ; 1:4       +rloop 161
    pop  HL             ; 1:10      +rloop 161
    jp    m, leave161   ; 3:10      +rloop 161
    dec   L             ; 1:4       +rloop 161    
    dec  HL             ; 1:6       +rloop 161
    ld  (HL),D          ; 1:7       +rloop 161    
    dec   L             ; 1:4       +rloop 161
    ld  (HL),E          ; 1:7       +rloop 161
    exx                 ; 1:4       +rloop 161
    jp    p, do161      ; 3:10      +rloop 161 ( step -- ) R:( stop index -- stop index+step )
leave161:               ;           +rloop 161
    inc  HL             ; 1:6       +rloop 161
    exx                 ; 1:4       +rloop 161 ( step -- ) R:( stop index -- )
exit161:                ;           +rloop 161
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string197  ; 3:10      print_z   Address of null-terminated string197
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 162 index
    push DE             ; 1:11      rdo 162 stop
    exx                 ; 1:4       rdo 162
    pop  DE             ; 1:10      rdo 162 stop
    dec  HL             ; 1:6       rdo 162
    ld  (HL),D          ; 1:7       rdo 162
    dec  L              ; 1:4       rdo 162
    ld  (HL),E          ; 1:7       rdo 162 stop
    pop  DE             ; 1:10      rdo 162 index
    dec  HL             ; 1:6       rdo 162
    ld  (HL),D          ; 1:7       rdo 162
    dec  L              ; 1:4       rdo 162
    ld  (HL),E          ; 1:7       rdo 162 index
    exx                 ; 1:4       rdo 162
    pop  HL             ; 1:10      rdo 162
    pop  DE             ; 1:10      rdo 162 ( stop index -- ) R: ( -- stop index )
do162:                  ;           rdo 162  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else136    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string198
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 162
    inc  L              ; 1:4       rleave 162
    inc  HL             ; 1:6       rleave 162
    inc  L              ; 1:4       rleave 162
    jp   leave162       ;           rleave 162 
else136  EQU $          ;           = endif
endif136: 
        
    exx                 ; 1:4       index ri 162    
    ld    E,(HL)        ; 1:7       index ri 162
    inc   L             ; 1:4       index ri 162
    ld    D,(HL)        ; 1:7       index ri 162
    push DE             ; 1:11      index ri 162
    dec   L             ; 1:4       index ri 162
    exx                 ; 1:4       index ri 162
    ex   DE, HL         ; 1:4       index ri 162
    ex  (SP),HL         ; 1:19      index ri 162 
    call PRINT_S16      ; 3:17      .
    
    exx                 ; 1:4       -2 +rloop 162
    ld   BC, -2         ; 3:10      -2 +rloop 162 BC = step
    ld    E,(HL)        ; 1:7       -2 +rloop 162
    ld    A, E          ; 1:4       -2 +rloop 162
    add   A, C          ; 1:4       -2 +rloop 162
    ld  (HL),A          ; 1:7       -2 +rloop 162
    inc   L             ; 1:4       -2 +rloop 162
    ld    D,(HL)        ; 1:7       -2 +rloop 162 DE = index
    ld    A, D          ; 1:4       -2 +rloop 162
    adc   A, B          ; 1:4       -2 +rloop 162
    ld  (HL),A          ; 1:7       -2 +rloop 162
    inc  HL             ; 1:6       -2 +rloop 162
    ld    A, E          ; 1:4       -2 +rloop 162    
    sub (HL)            ; 1:7       -2 +rloop 162
    ld    E, A          ; 1:4       -2 +rloop 162    
    inc   L             ; 1:4       -2 +rloop 162
    ld    A, D          ; 1:4       -2 +rloop 162    
    sbc   A,(HL)        ; 1:7       -2 +rloop 162
    ld    D, A          ; 1:4       -2 +rloop 162 DE = index-stop
    ld    A, E          ; 1:4       -2 +rloop 162    
    add   A, C          ; 1:4       -2 +rloop 162
    ld    A, D          ; 1:4       -2 +rloop 162    
    adc   A, B          ; 1:4       -2 +rloop 162
    xor   D             ; 1:4       -2 +rloop 162
    jp    m, $+10       ; 3:10      -2 +rloop 162
    dec   L             ; 1:4       -2 +rloop 162    
    dec  HL             ; 1:6       -2 +rloop 162
    dec   L             ; 1:4       -2 +rloop 162
    exx                 ; 1:4       -2 +rloop 162
    jp    p, do162      ; 3:10      -2 +rloop 162 ( -- ) R:( stop index -- stop index+-2 )
leave162:               ;           -2 +rloop 162
    inc  HL             ; 1:6       -2 +rloop 162
    exx                 ; 1:4       -2 +rloop 162 ( -- ) R:( stop index -- )
exit162:                ;           -2 +rloop 162 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string195  ; 3:10      print_z   Address of null-terminated string195 == string199
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx163), HL    ; 3:16      do 163 save index
    dec  DE             ; 1:6       do 163 stop-1
    ld    A, E          ; 1:4       do 163 
    ld  (stp_lo163), A  ; 3:13      do 163 lo stop
    ld    A, D          ; 1:4       do 163 
    ld  (stp_hi163), A  ; 3:13      do 163 hi stop
    pop  HL             ; 1:10      do 163
    pop  DE             ; 1:10      do 163 ( -- ) R: ( -- )
do163:                  ;           do 163 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else137    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string200
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave163       ;           leave 163 
else137  EQU $          ;           = endif
endif137: 
        
    push DE             ; 1:11      index i 163
    ex   DE, HL         ; 1:4       index i 163
    ld   HL, (idx163)   ; 3:16      index i 163 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      push(-2)
    ex   DE, HL         ; 1:4       push(-2)
    ld   HL, -2         ; 3:10      push(-2) 
    ld    B, H          ; 1:4       +loop 163
    ld    C, L          ; 1:4       +loop 163 BC = step
idx163 EQU $+1          ;           +loop 163
    ld   HL, 0x0000     ; 3:10      +loop 163
    add  HL, BC         ; 1:11      +loop 163 HL = index+step
    ld  (idx163), HL    ; 3:16      +loop 163 save index
stp_lo163 EQU $+1       ;           +loop 163
    ld    A, 0x00       ; 2:7       +loop 163 lo stop
    sub   L             ; 1:4       +loop 163
    ld    L, A          ; 1:4       +loop 163
stp_hi163 EQU $+1       ;           +loop 163
    ld    A, 0x00       ; 2:7       +loop 163 hi stop
    sbc   A, H          ; 1:4       +loop 163
    ld    H, A          ; 1:4       +loop 163 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 163 HL = stop-index
    xor   H             ; 1:4       +loop 163
    ex   DE, HL         ; 1:4       +loop 163
    pop  DE             ; 1:10      +loop 163
    jp    p, do163      ; 3:10      +loop 163
leave163:               ;           +loop 163
exit163:                ;           +loop 163 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string197  ; 3:10      print_z   Address of null-terminated string197 == string201
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx164), HL    ; 3:16      do 164 save index
    dec  DE             ; 1:6       do 164 stop-1
    ld    A, E          ; 1:4       do 164 
    ld  (stp_lo164), A  ; 3:13      do 164 lo stop
    ld    A, D          ; 1:4       do 164 
    ld  (stp_hi164), A  ; 3:13      do 164 hi stop
    pop  HL             ; 1:10      do 164
    pop  DE             ; 1:10      do 164 ( -- ) R: ( -- )
do164:                  ;           do 164 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else138    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string202
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave164       ;           leave 164 
else138  EQU $          ;           = endif
endif138: 
        
    push DE             ; 1:11      index i 164
    ex   DE, HL         ; 1:4       index i 164
    ld   HL, (idx164)   ; 3:16      index i 164 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push HL             ; 1:11      -2 +loop 164
idx164 EQU $+1          ;           -2 +loop 164
    ld   HL, 0x0000     ; 3:10      -2 +loop 164
    ld   BC, -2         ; 3:10      -2 +loop 164 BC = step
    add  HL, BC         ; 1:11      -2 +loop 164 HL = index+step
    ld  (idx164), HL    ; 3:16      -2 +loop 164 save index
stp_lo164 EQU $+1       ;           -2 +loop 164
    ld    A, 0x00       ; 2:7       -2 +loop 164 lo stop
    sub   L             ; 1:4       -2 +loop 164
    ld    L, A          ; 1:4       -2 +loop 164
stp_hi164 EQU $+1       ;           -2 +loop 164
    ld    A, 0x00       ; 2:7       -2 +loop 164 hi stop
    sbc   A, H          ; 1:4       -2 +loop 164
    ld    H, A          ; 1:4       -2 +loop 164 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -2 +loop 164 HL = stop-index
    xor   H             ; 1:4       -2 +loop 164
    pop  HL             ; 1:10      -2 +loop 164
    jp    p, do164      ; 3:10      -2 +loop 164 negative step
leave164:               ;           -2 +loop 164
exit164:                ;           -2 +loop 164 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string203  ; 3:10      print_z   Address of null-terminated string203
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo165:                 ;           sdo 165 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else139    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string204
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave165      ; 3:10      sleave 165 
else139  EQU $          ;           = endif
endif139: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(-2)
    ex   DE, HL         ; 1:4       push(-2)
    ld   HL, -2         ; 3:10      push(-2) 
    pop  BC             ; 1:10      +sloop 165 BC = stop
    ex   DE, HL         ; 1:4       +sloop 165
    or    A             ; 1:4       +sloop 165
    sbc  HL, BC         ; 2:15      +sloop 165 HL = index-stop
    ld    A, H          ; 1:4       +sloop 165
    add  HL, DE         ; 1:11      +sloop 165 HL = index-stop+step
    xor   H             ; 1:4       +sloop 165 sign flag!
    add  HL, BC         ; 1:11      +sloop 165 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 165
    ld    E, C          ; 1:4       +sloop 165
    jp    p, sdo165     ; 3:10      +sloop 165
sleave165:              ;           +sloop 165
    pop  HL             ; 1:10      unsloop 165 index out
    pop  DE             ; 1:10      unsloop 165 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string205  ; 3:10      print_z   Address of null-terminated string205
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo166:                 ;           sdo 166 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else140    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string206
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave166      ; 3:10      sleave 166 
else140  EQU $          ;           = endif
endif140: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    ld   BC, -2         ; 3:10      push_addsloop(-2) 166 BC = step
    or    A             ; 1:4       push_addsloop(-2) 166
    sbc  HL, DE         ; 2:15      push_addsloop(-2) 166 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(-2) 166
    add  HL, BC         ; 1:11      push_addsloop(-2) 166 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(-2) 166 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(-2) 166 HL = index+step, sign flag unaffected
    jp    p, sdo166     ; 3:10      push_addsloop(-2) 166
sleave166:              ;           push_addsloop(-2) 166
    pop  HL             ; 1:10      unsloop 166 index out
    pop  DE             ; 1:10      unsloop 166 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_down2_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
_up2:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_up2_end+1),BC ; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string207  ; 3:10      print_z   Address of null-terminated string207
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 167 index
    push DE             ; 1:11      rdo 167 stop
    exx                 ; 1:4       rdo 167
    pop  DE             ; 1:10      rdo 167 stop
    dec  HL             ; 1:6       rdo 167
    ld  (HL),D          ; 1:7       rdo 167
    dec  L              ; 1:4       rdo 167
    ld  (HL),E          ; 1:7       rdo 167 stop
    pop  DE             ; 1:10      rdo 167 index
    dec  HL             ; 1:6       rdo 167
    ld  (HL),D          ; 1:7       rdo 167
    dec  L              ; 1:4       rdo 167
    ld  (HL),E          ; 1:7       rdo 167 index
    exx                 ; 1:4       rdo 167
    pop  HL             ; 1:10      rdo 167
    pop  DE             ; 1:10      rdo 167 ( stop index -- ) R: ( -- stop index )
do167:                  ;           rdo 167  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else141    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string208
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 167
    inc  L              ; 1:4       rleave 167
    inc  HL             ; 1:6       rleave 167
    inc  L              ; 1:4       rleave 167
    jp   leave167       ;           rleave 167 
else141  EQU $          ;           = endif
endif141: 
        
    exx                 ; 1:4       index ri 167    
    ld    E,(HL)        ; 1:7       index ri 167
    inc   L             ; 1:4       index ri 167
    ld    D,(HL)        ; 1:7       index ri 167
    push DE             ; 1:11      index ri 167
    dec   L             ; 1:4       index ri 167
    exx                 ; 1:4       index ri 167
    ex   DE, HL         ; 1:4       index ri 167
    ex  (SP),HL         ; 1:19      index ri 167 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    ex  (SP),HL         ; 1:19      +rloop 167
    ex   DE, HL         ; 1:4       +rloop 167
    exx                 ; 1:4       +rloop 167
    ld    E,(HL)        ; 1:7       +rloop 167
    inc   L             ; 1:4       +rloop 167
    ld    D,(HL)        ; 1:7       +rloop 167 DE = index
    inc  HL             ; 1:6       +rloop 167
    ld    C,(HL)        ; 1:7       +rloop 167
    inc   L             ; 1:4       +rloop 167
    ld    B,(HL)        ; 1:7       +rloop 167 BC = stop
    ex  (SP),HL         ; 1:19      +rloop 167 HL = step
    ex   DE, HL         ; 1:4       +rloop 167
    xor   A             ; 1:4       +rloop 167
    sbc  HL, BC         ; 2:15      +rloop 167 HL = index-stop
    ld    A, H          ; 1:4       +rloop 167
    add  HL, DE         ; 1:11      +rloop 167 HL = index-stop+step
    xor   H             ; 1:4       +rloop 167
    add  HL, BC         ; 1:11      +rloop 167 HL = index+step
    ex   DE, HL         ; 1:4       +rloop 167
    pop  HL             ; 1:10      +rloop 167
    jp    m, leave167   ; 3:10      +rloop 167
    dec   L             ; 1:4       +rloop 167    
    dec  HL             ; 1:6       +rloop 167
    ld  (HL),D          ; 1:7       +rloop 167    
    dec   L             ; 1:4       +rloop 167
    ld  (HL),E          ; 1:7       +rloop 167
    exx                 ; 1:4       +rloop 167
    jp    p, do167      ; 3:10      +rloop 167 ( step -- ) R:( stop index -- stop index+step )
leave167:               ;           +rloop 167
    inc  HL             ; 1:6       +rloop 167
    exx                 ; 1:4       +rloop 167 ( step -- ) R:( stop index -- )
exit167:                ;           +rloop 167
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string209  ; 3:10      print_z   Address of null-terminated string209
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 168 index
    push DE             ; 1:11      rdo 168 stop
    exx                 ; 1:4       rdo 168
    pop  DE             ; 1:10      rdo 168 stop
    dec  HL             ; 1:6       rdo 168
    ld  (HL),D          ; 1:7       rdo 168
    dec  L              ; 1:4       rdo 168
    ld  (HL),E          ; 1:7       rdo 168 stop
    pop  DE             ; 1:10      rdo 168 index
    dec  HL             ; 1:6       rdo 168
    ld  (HL),D          ; 1:7       rdo 168
    dec  L              ; 1:4       rdo 168
    ld  (HL),E          ; 1:7       rdo 168 index
    exx                 ; 1:4       rdo 168
    pop  HL             ; 1:10      rdo 168
    pop  DE             ; 1:10      rdo 168 ( stop index -- ) R: ( -- stop index )
do168:                  ;           rdo 168  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else142    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string210
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 168
    inc  L              ; 1:4       rleave 168
    inc  HL             ; 1:6       rleave 168
    inc  L              ; 1:4       rleave 168
    jp   leave168       ;           rleave 168 
else142  EQU $          ;           = endif
endif142: 
        
    exx                 ; 1:4       index ri 168    
    ld    E,(HL)        ; 1:7       index ri 168
    inc   L             ; 1:4       index ri 168
    ld    D,(HL)        ; 1:7       index ri 168
    push DE             ; 1:11      index ri 168
    dec   L             ; 1:4       index ri 168
    exx                 ; 1:4       index ri 168
    ex   DE, HL         ; 1:4       index ri 168
    ex  (SP),HL         ; 1:19      index ri 168 
    call PRINT_S16      ; 3:17      .
    
                        ;           2 +rloop 168
    exx                 ; 1:4       2 +rloop 168
    ld    E,(HL)        ; 1:7       2 +rloop 168
    inc   L             ; 1:4       2 +rloop 168
    ld    D,(HL)        ; 1:7       2 +rloop 168 DE = index
    inc  DE             ; 1:6       2 +rloop 168
    inc  DE             ; 1:6       2 +rloop 168 DE = index+2
    inc  HL             ; 1:6       2 +rloop 168
    ld    A, E          ; 1:4       2 +rloop 168    
    sub (HL)            ; 1:7       2 +rloop 168 lo index+2-stop
    rra                 ; 1:4       2 +rloop 168
    add   A, A          ; 1:4       2 +rloop 168 and 0xFE with save carry
    jr   nz, $+8        ; 2:7/12    2 +rloop 168
    ld    A, D          ; 1:4       2 +rloop 168
    inc   L             ; 1:4       2 +rloop 168
    sbc   A,(HL)        ; 1:7       2 +rloop 168 hi index+2-stop
    jr    z, leave168   ; 2:7/12    2 +rloop 168
    dec   L             ; 1:4       2 +rloop 168   
    dec  HL             ; 1:6       2 +rloop 168
    ld  (HL),D          ; 1:7       2 +rloop 168
    dec   L             ; 1:4       2 +rloop 168
    ld  (HL),E          ; 1:7       2 +rloop 168
    exx                 ; 1:4       2 +rloop 168
    jp    p, do168      ; 3:10      2 +rloop 168 ( -- ) R:( stop index -- stop index+ )
leave168:               ;           2 +rloop 168
    inc  HL             ; 1:6       2 +rloop 168
    exx                 ; 1:4       2 +rloop 168
exit168:                ;           2 +rloop 168 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string207  ; 3:10      print_z   Address of null-terminated string207 == string211
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx169), HL    ; 3:16      do 169 save index
    dec  DE             ; 1:6       do 169 stop-1
    ld    A, E          ; 1:4       do 169 
    ld  (stp_lo169), A  ; 3:13      do 169 lo stop
    ld    A, D          ; 1:4       do 169 
    ld  (stp_hi169), A  ; 3:13      do 169 hi stop
    pop  HL             ; 1:10      do 169
    pop  DE             ; 1:10      do 169 ( -- ) R: ( -- )
do169:                  ;           do 169 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else143    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string212
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave169       ;           leave 169 
else143  EQU $          ;           = endif
endif143: 
        
    push DE             ; 1:11      index i 169
    ex   DE, HL         ; 1:4       index i 169
    ld   HL, (idx169)   ; 3:16      index i 169 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    ld    B, H          ; 1:4       +loop 169
    ld    C, L          ; 1:4       +loop 169 BC = step
idx169 EQU $+1          ;           +loop 169
    ld   HL, 0x0000     ; 3:10      +loop 169
    add  HL, BC         ; 1:11      +loop 169 HL = index+step
    ld  (idx169), HL    ; 3:16      +loop 169 save index
stp_lo169 EQU $+1       ;           +loop 169
    ld    A, 0x00       ; 2:7       +loop 169 lo stop
    sub   L             ; 1:4       +loop 169
    ld    L, A          ; 1:4       +loop 169
stp_hi169 EQU $+1       ;           +loop 169
    ld    A, 0x00       ; 2:7       +loop 169 hi stop
    sbc   A, H          ; 1:4       +loop 169
    ld    H, A          ; 1:4       +loop 169 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 169 HL = stop-index
    xor   H             ; 1:4       +loop 169
    ex   DE, HL         ; 1:4       +loop 169
    pop  DE             ; 1:10      +loop 169
    jp    p, do169      ; 3:10      +loop 169
leave169:               ;           +loop 169
exit169:                ;           +loop 169 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string209  ; 3:10      print_z   Address of null-terminated string209 == string213
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx170), HL    ; 3:16      do 170 save index
    dec  DE             ; 1:6       do 170 stop-1
    ld    A, E          ; 1:4       do 170 
    ld  (stp_lo170), A  ; 3:13      do 170 lo stop
    ld    A, D          ; 1:4       do 170 
    ld  (stp_hi170), A  ; 3:13      do 170 hi stop
    pop  HL             ; 1:10      do 170
    pop  DE             ; 1:10      do 170 ( -- ) R: ( -- )
do170:                  ;           do 170 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else144    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string214
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave170       ;           leave 170 
else144  EQU $          ;           = endif
endif144: 
        
    push DE             ; 1:11      index i 170
    ex   DE, HL         ; 1:4       index i 170
    ld   HL, (idx170)   ; 3:16      index i 170 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
                        ;           push_addloop(2) 170
idx170 EQU $+1          ;           2 +loop 170
    ld   BC, 0x0000     ; 3:10      2 +loop 170 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +loop 170 index++
    ld    A, C          ; 1:4       2 +loop 170
stp_lo170 EQU $+1       ;           2 +loop 170
    sub  0x00           ; 2:7       2 +loop 170 lo index - stop
    rra                 ; 1:4       2 +loop 170
    add   A, A          ; 1:4       2 +loop 170 and 0xFE with save carry
    ld    A, B          ; 1:4       2 +loop 170
    inc  BC             ; 1:6       2 +loop 170 index++
    ld  (idx170),BC     ; 4:20      2 +loop 170 save index
    jp   nz, do170      ; 3:10      2 +loop 170
stp_hi170 EQU $+1       ;           2 +loop 170
    sbc   A, 0x00       ; 2:7       2 +loop 170 hi index - stop
    jp   nz, do170      ; 3:10      2 +loop 170
leave170:               ;           2 +loop 170
exit170:                ;           2 +loop 170 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string215  ; 3:10      print_z   Address of null-terminated string215
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo171:                 ;           sdo 171 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else145    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string216
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave171      ; 3:10      sleave 171 
else145  EQU $          ;           = endif
endif145: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    pop  BC             ; 1:10      +sloop 171 BC = stop
    ex   DE, HL         ; 1:4       +sloop 171
    or    A             ; 1:4       +sloop 171
    sbc  HL, BC         ; 2:15      +sloop 171 HL = index-stop
    ld    A, H          ; 1:4       +sloop 171
    add  HL, DE         ; 1:11      +sloop 171 HL = index-stop+step
    xor   H             ; 1:4       +sloop 171 sign flag!
    add  HL, BC         ; 1:11      +sloop 171 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 171
    ld    E, C          ; 1:4       +sloop 171
    jp    p, sdo171     ; 3:10      +sloop 171
sleave171:              ;           +sloop 171
    pop  HL             ; 1:10      unsloop 171 index out
    pop  DE             ; 1:10      unsloop 171 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string217  ; 3:10      print_z   Address of null-terminated string217
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo172:                 ;           sdo 172 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else146    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string218
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave172      ; 3:10      sleave 172 
else146  EQU $          ;           = endif
endif146: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
                        ;           push_addsloop(2) 172
    inc  HL             ; 1:6       2 +sloop 172
    inc  HL             ; 1:6       2 +sloop 172 HL = index+2
    ld    A, L          ; 1:4       2 +sloop 172
    sub   E             ; 1:4       2 +sloop 172
    rra                 ; 1:4       2 +sloop 172
    add   A, A          ; 1:4       2 +sloop 172
    jp   nz, sdo172     ; 3:10      2 +sloop 172
    ld    A, H          ; 1:4       2 +sloop 172
    sbc   A, D          ; 1:4       2 +sloop 172
    jp   nz, sdo172     ; 3:10      2 +sloop 172
sleave172:              ;           2 +sloop 172
    pop  HL             ; 1:10      unsloop 172 index out
    pop  DE             ; 1:10      unsloop 172 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 


_up2_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
_down3:                 ;           
    pop  BC             ; 1:10      : ret
    ld  (_down3_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string219  ; 3:10      print_z   Address of null-terminated string219
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 173 index
    push DE             ; 1:11      rdo 173 stop
    exx                 ; 1:4       rdo 173
    pop  DE             ; 1:10      rdo 173 stop
    dec  HL             ; 1:6       rdo 173
    ld  (HL),D          ; 1:7       rdo 173
    dec  L              ; 1:4       rdo 173
    ld  (HL),E          ; 1:7       rdo 173 stop
    pop  DE             ; 1:10      rdo 173 index
    dec  HL             ; 1:6       rdo 173
    ld  (HL),D          ; 1:7       rdo 173
    dec  L              ; 1:4       rdo 173
    ld  (HL),E          ; 1:7       rdo 173 index
    exx                 ; 1:4       rdo 173
    pop  HL             ; 1:10      rdo 173
    pop  DE             ; 1:10      rdo 173 ( stop index -- ) R: ( -- stop index )
do173:                  ;           rdo 173  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else147    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string220
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 173
    inc  L              ; 1:4       rleave 173
    inc  HL             ; 1:6       rleave 173
    inc  L              ; 1:4       rleave 173
    jp   leave173       ;           rleave 173 
else147  EQU $          ;           = endif
endif147: 
        
    exx                 ; 1:4       index ri 173    
    ld    E,(HL)        ; 1:7       index ri 173
    inc   L             ; 1:4       index ri 173
    ld    D,(HL)        ; 1:7       index ri 173
    push DE             ; 1:11      index ri 173
    dec   L             ; 1:4       index ri 173
    exx                 ; 1:4       index ri 173
    ex   DE, HL         ; 1:4       index ri 173
    ex  (SP),HL         ; 1:19      index ri 173 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    ex  (SP),HL         ; 1:19      +rloop 173
    ex   DE, HL         ; 1:4       +rloop 173
    exx                 ; 1:4       +rloop 173
    ld    E,(HL)        ; 1:7       +rloop 173
    inc   L             ; 1:4       +rloop 173
    ld    D,(HL)        ; 1:7       +rloop 173 DE = index
    inc  HL             ; 1:6       +rloop 173
    ld    C,(HL)        ; 1:7       +rloop 173
    inc   L             ; 1:4       +rloop 173
    ld    B,(HL)        ; 1:7       +rloop 173 BC = stop
    ex  (SP),HL         ; 1:19      +rloop 173 HL = step
    ex   DE, HL         ; 1:4       +rloop 173
    xor   A             ; 1:4       +rloop 173
    sbc  HL, BC         ; 2:15      +rloop 173 HL = index-stop
    ld    A, H          ; 1:4       +rloop 173
    add  HL, DE         ; 1:11      +rloop 173 HL = index-stop+step
    xor   H             ; 1:4       +rloop 173
    add  HL, BC         ; 1:11      +rloop 173 HL = index+step
    ex   DE, HL         ; 1:4       +rloop 173
    pop  HL             ; 1:10      +rloop 173
    jp    m, leave173   ; 3:10      +rloop 173
    dec   L             ; 1:4       +rloop 173    
    dec  HL             ; 1:6       +rloop 173
    ld  (HL),D          ; 1:7       +rloop 173    
    dec   L             ; 1:4       +rloop 173
    ld  (HL),E          ; 1:7       +rloop 173
    exx                 ; 1:4       +rloop 173
    jp    p, do173      ; 3:10      +rloop 173 ( step -- ) R:( stop index -- stop index+step )
leave173:               ;           +rloop 173
    inc  HL             ; 1:6       +rloop 173
    exx                 ; 1:4       +rloop 173 ( step -- ) R:( stop index -- )
exit173:                ;           +rloop 173
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string221  ; 3:10      print_z   Address of null-terminated string221
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 174 index
    push DE             ; 1:11      rdo 174 stop
    exx                 ; 1:4       rdo 174
    pop  DE             ; 1:10      rdo 174 stop
    dec  HL             ; 1:6       rdo 174
    ld  (HL),D          ; 1:7       rdo 174
    dec  L              ; 1:4       rdo 174
    ld  (HL),E          ; 1:7       rdo 174 stop
    pop  DE             ; 1:10      rdo 174 index
    dec  HL             ; 1:6       rdo 174
    ld  (HL),D          ; 1:7       rdo 174
    dec  L              ; 1:4       rdo 174
    ld  (HL),E          ; 1:7       rdo 174 index
    exx                 ; 1:4       rdo 174
    pop  HL             ; 1:10      rdo 174
    pop  DE             ; 1:10      rdo 174 ( stop index -- ) R: ( -- stop index )
do174:                  ;           rdo 174  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else148    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string222
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 174
    inc  L              ; 1:4       rleave 174
    inc  HL             ; 1:6       rleave 174
    inc  L              ; 1:4       rleave 174
    jp   leave174       ;           rleave 174 
else148  EQU $          ;           = endif
endif148: 
        
    exx                 ; 1:4       index ri 174    
    ld    E,(HL)        ; 1:7       index ri 174
    inc   L             ; 1:4       index ri 174
    ld    D,(HL)        ; 1:7       index ri 174
    push DE             ; 1:11      index ri 174
    dec   L             ; 1:4       index ri 174
    exx                 ; 1:4       index ri 174
    ex   DE, HL         ; 1:4       index ri 174
    ex  (SP),HL         ; 1:19      index ri 174 
    call PRINT_S16      ; 3:17      .
    
    exx                 ; 1:4       -3 +rloop 174
    ld   BC, -3         ; 3:10      -3 +rloop 174 BC = step
    ld    E,(HL)        ; 1:7       -3 +rloop 174
    ld    A, E          ; 1:4       -3 +rloop 174
    add   A, C          ; 1:4       -3 +rloop 174
    ld  (HL),A          ; 1:7       -3 +rloop 174
    inc   L             ; 1:4       -3 +rloop 174
    ld    D,(HL)        ; 1:7       -3 +rloop 174 DE = index
    ld    A, D          ; 1:4       -3 +rloop 174
    adc   A, B          ; 1:4       -3 +rloop 174
    ld  (HL),A          ; 1:7       -3 +rloop 174
    inc  HL             ; 1:6       -3 +rloop 174
    ld    A, E          ; 1:4       -3 +rloop 174    
    sub (HL)            ; 1:7       -3 +rloop 174
    ld    E, A          ; 1:4       -3 +rloop 174    
    inc   L             ; 1:4       -3 +rloop 174
    ld    A, D          ; 1:4       -3 +rloop 174    
    sbc   A,(HL)        ; 1:7       -3 +rloop 174
    ld    D, A          ; 1:4       -3 +rloop 174 DE = index-stop
    ld    A, E          ; 1:4       -3 +rloop 174    
    add   A, C          ; 1:4       -3 +rloop 174
    ld    A, D          ; 1:4       -3 +rloop 174    
    adc   A, B          ; 1:4       -3 +rloop 174
    xor   D             ; 1:4       -3 +rloop 174
    jp    m, $+10       ; 3:10      -3 +rloop 174
    dec   L             ; 1:4       -3 +rloop 174    
    dec  HL             ; 1:6       -3 +rloop 174
    dec   L             ; 1:4       -3 +rloop 174
    exx                 ; 1:4       -3 +rloop 174
    jp    p, do174      ; 3:10      -3 +rloop 174 ( -- ) R:( stop index -- stop index+-3 )
leave174:               ;           -3 +rloop 174
    inc  HL             ; 1:6       -3 +rloop 174
    exx                 ; 1:4       -3 +rloop 174 ( -- ) R:( stop index -- )
exit174:                ;           -3 +rloop 174 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string219  ; 3:10      print_z   Address of null-terminated string219 == string223
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx175), HL    ; 3:16      do 175 save index
    dec  DE             ; 1:6       do 175 stop-1
    ld    A, E          ; 1:4       do 175 
    ld  (stp_lo175), A  ; 3:13      do 175 lo stop
    ld    A, D          ; 1:4       do 175 
    ld  (stp_hi175), A  ; 3:13      do 175 hi stop
    pop  HL             ; 1:10      do 175
    pop  DE             ; 1:10      do 175 ( -- ) R: ( -- )
do175:                  ;           do 175 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else149    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string224
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave175       ;           leave 175 
else149  EQU $          ;           = endif
endif149: 
        
    push DE             ; 1:11      index i 175
    ex   DE, HL         ; 1:4       index i 175
    ld   HL, (idx175)   ; 3:16      index i 175 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    ld    B, H          ; 1:4       +loop 175
    ld    C, L          ; 1:4       +loop 175 BC = step
idx175 EQU $+1          ;           +loop 175
    ld   HL, 0x0000     ; 3:10      +loop 175
    add  HL, BC         ; 1:11      +loop 175 HL = index+step
    ld  (idx175), HL    ; 3:16      +loop 175 save index
stp_lo175 EQU $+1       ;           +loop 175
    ld    A, 0x00       ; 2:7       +loop 175 lo stop
    sub   L             ; 1:4       +loop 175
    ld    L, A          ; 1:4       +loop 175
stp_hi175 EQU $+1       ;           +loop 175
    ld    A, 0x00       ; 2:7       +loop 175 hi stop
    sbc   A, H          ; 1:4       +loop 175
    ld    H, A          ; 1:4       +loop 175 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 175 HL = stop-index
    xor   H             ; 1:4       +loop 175
    ex   DE, HL         ; 1:4       +loop 175
    pop  DE             ; 1:10      +loop 175
    jp    p, do175      ; 3:10      +loop 175
leave175:               ;           +loop 175
exit175:                ;           +loop 175 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string221  ; 3:10      print_z   Address of null-terminated string221 == string225
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx176), HL    ; 3:16      do 176 save index
    dec  DE             ; 1:6       do 176 stop-1
    ld    A, E          ; 1:4       do 176 
    ld  (stp_lo176), A  ; 3:13      do 176 lo stop
    ld    A, D          ; 1:4       do 176 
    ld  (stp_hi176), A  ; 3:13      do 176 hi stop
    pop  HL             ; 1:10      do 176
    pop  DE             ; 1:10      do 176 ( -- ) R: ( -- )
do176:                  ;           do 176 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else150    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string226
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave176       ;           leave 176 
else150  EQU $          ;           = endif
endif150: 
        
    push DE             ; 1:11      index i 176
    ex   DE, HL         ; 1:4       index i 176
    ld   HL, (idx176)   ; 3:16      index i 176 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push HL             ; 1:11      -3 +loop 176
idx176 EQU $+1          ;           -3 +loop 176
    ld   HL, 0x0000     ; 3:10      -3 +loop 176
    ld   BC, -3         ; 3:10      -3 +loop 176 BC = step
    add  HL, BC         ; 1:11      -3 +loop 176 HL = index+step
    ld  (idx176), HL    ; 3:16      -3 +loop 176 save index
stp_lo176 EQU $+1       ;           -3 +loop 176
    ld    A, 0x00       ; 2:7       -3 +loop 176 lo stop
    sub   L             ; 1:4       -3 +loop 176
    ld    L, A          ; 1:4       -3 +loop 176
stp_hi176 EQU $+1       ;           -3 +loop 176
    ld    A, 0x00       ; 2:7       -3 +loop 176 hi stop
    sbc   A, H          ; 1:4       -3 +loop 176
    ld    H, A          ; 1:4       -3 +loop 176 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -3 +loop 176 HL = stop-index
    xor   H             ; 1:4       -3 +loop 176
    pop  HL             ; 1:10      -3 +loop 176
    jp    p, do176      ; 3:10      -3 +loop 176 negative step
leave176:               ;           -3 +loop 176
exit176:                ;           -3 +loop 176 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string227  ; 3:10      print_z   Address of null-terminated string227
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo177:                 ;           sdo 177 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else151    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string228
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave177      ; 3:10      sleave 177 
else151  EQU $          ;           = endif
endif151: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    pop  BC             ; 1:10      +sloop 177 BC = stop
    ex   DE, HL         ; 1:4       +sloop 177
    or    A             ; 1:4       +sloop 177
    sbc  HL, BC         ; 2:15      +sloop 177 HL = index-stop
    ld    A, H          ; 1:4       +sloop 177
    add  HL, DE         ; 1:11      +sloop 177 HL = index-stop+step
    xor   H             ; 1:4       +sloop 177 sign flag!
    add  HL, BC         ; 1:11      +sloop 177 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 177
    ld    E, C          ; 1:4       +sloop 177
    jp    p, sdo177     ; 3:10      +sloop 177
sleave177:              ;           +sloop 177
    pop  HL             ; 1:10      unsloop 177 index out
    pop  DE             ; 1:10      unsloop 177 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string229  ; 3:10      print_z   Address of null-terminated string229
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo178:                 ;           sdo 178 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else152    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string230
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave178      ; 3:10      sleave 178 
else152  EQU $          ;           = endif
endif152: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    ld   BC, -3         ; 3:10      push_addsloop(-3) 178 BC = step
    or    A             ; 1:4       push_addsloop(-3) 178
    sbc  HL, DE         ; 2:15      push_addsloop(-3) 178 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(-3) 178
    add  HL, BC         ; 1:11      push_addsloop(-3) 178 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(-3) 178 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(-3) 178 HL = index+step, sign flag unaffected
    jp    p, sdo178     ; 3:10      push_addsloop(-3) 178
sleave178:              ;           push_addsloop(-3) 178
    pop  HL             ; 1:10      unsloop 178 index out
    pop  DE             ; 1:10      unsloop 178 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_down3_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
_up3:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (_up3_end+1),BC ; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string231  ; 3:10      print_z   Address of null-terminated string231
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 179 index
    push DE             ; 1:11      rdo 179 stop
    exx                 ; 1:4       rdo 179
    pop  DE             ; 1:10      rdo 179 stop
    dec  HL             ; 1:6       rdo 179
    ld  (HL),D          ; 1:7       rdo 179
    dec  L              ; 1:4       rdo 179
    ld  (HL),E          ; 1:7       rdo 179 stop
    pop  DE             ; 1:10      rdo 179 index
    dec  HL             ; 1:6       rdo 179
    ld  (HL),D          ; 1:7       rdo 179
    dec  L              ; 1:4       rdo 179
    ld  (HL),E          ; 1:7       rdo 179 index
    exx                 ; 1:4       rdo 179
    pop  HL             ; 1:10      rdo 179
    pop  DE             ; 1:10      rdo 179 ( stop index -- ) R: ( -- stop index )
do179:                  ;           rdo 179  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else153    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string232
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 179
    inc  L              ; 1:4       rleave 179
    inc  HL             ; 1:6       rleave 179
    inc  L              ; 1:4       rleave 179
    jp   leave179       ;           rleave 179 
else153  EQU $          ;           = endif
endif153: 
        
    exx                 ; 1:4       index ri 179    
    ld    E,(HL)        ; 1:7       index ri 179
    inc   L             ; 1:4       index ri 179
    ld    D,(HL)        ; 1:7       index ri 179
    push DE             ; 1:11      index ri 179
    dec   L             ; 1:4       index ri 179
    exx                 ; 1:4       index ri 179
    ex   DE, HL         ; 1:4       index ri 179
    ex  (SP),HL         ; 1:19      index ri 179 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    ex  (SP),HL         ; 1:19      +rloop 179
    ex   DE, HL         ; 1:4       +rloop 179
    exx                 ; 1:4       +rloop 179
    ld    E,(HL)        ; 1:7       +rloop 179
    inc   L             ; 1:4       +rloop 179
    ld    D,(HL)        ; 1:7       +rloop 179 DE = index
    inc  HL             ; 1:6       +rloop 179
    ld    C,(HL)        ; 1:7       +rloop 179
    inc   L             ; 1:4       +rloop 179
    ld    B,(HL)        ; 1:7       +rloop 179 BC = stop
    ex  (SP),HL         ; 1:19      +rloop 179 HL = step
    ex   DE, HL         ; 1:4       +rloop 179
    xor   A             ; 1:4       +rloop 179
    sbc  HL, BC         ; 2:15      +rloop 179 HL = index-stop
    ld    A, H          ; 1:4       +rloop 179
    add  HL, DE         ; 1:11      +rloop 179 HL = index-stop+step
    xor   H             ; 1:4       +rloop 179
    add  HL, BC         ; 1:11      +rloop 179 HL = index+step
    ex   DE, HL         ; 1:4       +rloop 179
    pop  HL             ; 1:10      +rloop 179
    jp    m, leave179   ; 3:10      +rloop 179
    dec   L             ; 1:4       +rloop 179    
    dec  HL             ; 1:6       +rloop 179
    ld  (HL),D          ; 1:7       +rloop 179    
    dec   L             ; 1:4       +rloop 179
    ld  (HL),E          ; 1:7       +rloop 179
    exx                 ; 1:4       +rloop 179
    jp    p, do179      ; 3:10      +rloop 179 ( step -- ) R:( stop index -- stop index+step )
leave179:               ;           +rloop 179
    inc  HL             ; 1:6       +rloop 179
    exx                 ; 1:4       +rloop 179 ( step -- ) R:( stop index -- )
exit179:                ;           +rloop 179
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string233  ; 3:10      print_z   Address of null-terminated string233
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 180 index
    push DE             ; 1:11      rdo 180 stop
    exx                 ; 1:4       rdo 180
    pop  DE             ; 1:10      rdo 180 stop
    dec  HL             ; 1:6       rdo 180
    ld  (HL),D          ; 1:7       rdo 180
    dec  L              ; 1:4       rdo 180
    ld  (HL),E          ; 1:7       rdo 180 stop
    pop  DE             ; 1:10      rdo 180 index
    dec  HL             ; 1:6       rdo 180
    ld  (HL),D          ; 1:7       rdo 180
    dec  L              ; 1:4       rdo 180
    ld  (HL),E          ; 1:7       rdo 180 index
    exx                 ; 1:4       rdo 180
    pop  HL             ; 1:10      rdo 180
    pop  DE             ; 1:10      rdo 180 ( stop index -- ) R: ( -- stop index )
do180:                  ;           rdo 180  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else154    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string234
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 180
    inc  L              ; 1:4       rleave 180
    inc  HL             ; 1:6       rleave 180
    inc  L              ; 1:4       rleave 180
    jp   leave180       ;           rleave 180 
else154  EQU $          ;           = endif
endif154: 
        
    exx                 ; 1:4       index ri 180    
    ld    E,(HL)        ; 1:7       index ri 180
    inc   L             ; 1:4       index ri 180
    ld    D,(HL)        ; 1:7       index ri 180
    push DE             ; 1:11      index ri 180
    dec   L             ; 1:4       index ri 180
    exx                 ; 1:4       index ri 180
    ex   DE, HL         ; 1:4       index ri 180
    ex  (SP),HL         ; 1:19      index ri 180 
    call PRINT_S16      ; 3:17      .
    
    exx                 ; 1:4       3 +rloop 180
    ld   BC, 3          ; 3:10      3 +rloop 180 BC = step
    ld    E,(HL)        ; 1:7       3 +rloop 180
    ld    A, E          ; 1:4       3 +rloop 180
    add   A, C          ; 1:4       3 +rloop 180
    ld  (HL),A          ; 1:7       3 +rloop 180
    inc   L             ; 1:4       3 +rloop 180
    ld    D,(HL)        ; 1:7       3 +rloop 180 DE = index
    ld    A, D          ; 1:4       3 +rloop 180
    adc   A, B          ; 1:4       3 +rloop 180
    ld  (HL),A          ; 1:7       3 +rloop 180
    inc  HL             ; 1:6       3 +rloop 180
    ld    A, E          ; 1:4       3 +rloop 180    
    sub (HL)            ; 1:7       3 +rloop 180
    ld    E, A          ; 1:4       3 +rloop 180    
    inc   L             ; 1:4       3 +rloop 180
    ld    A, D          ; 1:4       3 +rloop 180    
    sbc   A,(HL)        ; 1:7       3 +rloop 180
    ld    D, A          ; 1:4       3 +rloop 180 DE = index-stop
    ld    A, E          ; 1:4       3 +rloop 180    
    add   A, C          ; 1:4       3 +rloop 180
    ld    A, D          ; 1:4       3 +rloop 180    
    adc   A, B          ; 1:4       3 +rloop 180
    xor   D             ; 1:4       3 +rloop 180
    jp    m, $+10       ; 3:10      3 +rloop 180
    dec   L             ; 1:4       3 +rloop 180    
    dec  HL             ; 1:6       3 +rloop 180
    dec   L             ; 1:4       3 +rloop 180
    exx                 ; 1:4       3 +rloop 180
    jp    p, do180      ; 3:10      3 +rloop 180 ( -- ) R:( stop index -- stop index+3 )
leave180:               ;           3 +rloop 180
    inc  HL             ; 1:6       3 +rloop 180
    exx                 ; 1:4       3 +rloop 180 ( -- ) R:( stop index -- )
exit180:                ;           3 +rloop 180 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string231  ; 3:10      print_z   Address of null-terminated string231 == string235
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx181), HL    ; 3:16      do 181 save index
    dec  DE             ; 1:6       do 181 stop-1
    ld    A, E          ; 1:4       do 181 
    ld  (stp_lo181), A  ; 3:13      do 181 lo stop
    ld    A, D          ; 1:4       do 181 
    ld  (stp_hi181), A  ; 3:13      do 181 hi stop
    pop  HL             ; 1:10      do 181
    pop  DE             ; 1:10      do 181 ( -- ) R: ( -- )
do181:                  ;           do 181 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else155    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string236
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave181       ;           leave 181 
else155  EQU $          ;           = endif
endif155: 
        
    push DE             ; 1:11      index i 181
    ex   DE, HL         ; 1:4       index i 181
    ld   HL, (idx181)   ; 3:16      index i 181 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    ld    B, H          ; 1:4       +loop 181
    ld    C, L          ; 1:4       +loop 181 BC = step
idx181 EQU $+1          ;           +loop 181
    ld   HL, 0x0000     ; 3:10      +loop 181
    add  HL, BC         ; 1:11      +loop 181 HL = index+step
    ld  (idx181), HL    ; 3:16      +loop 181 save index
stp_lo181 EQU $+1       ;           +loop 181
    ld    A, 0x00       ; 2:7       +loop 181 lo stop
    sub   L             ; 1:4       +loop 181
    ld    L, A          ; 1:4       +loop 181
stp_hi181 EQU $+1       ;           +loop 181
    ld    A, 0x00       ; 2:7       +loop 181 hi stop
    sbc   A, H          ; 1:4       +loop 181
    ld    H, A          ; 1:4       +loop 181 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 181 HL = stop-index
    xor   H             ; 1:4       +loop 181
    ex   DE, HL         ; 1:4       +loop 181
    pop  DE             ; 1:10      +loop 181
    jp    p, do181      ; 3:10      +loop 181
leave181:               ;           +loop 181
exit181:                ;           +loop 181 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string233  ; 3:10      print_z   Address of null-terminated string233 == string237
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx182), HL    ; 3:16      do 182 save index
    dec  DE             ; 1:6       do 182 stop-1
    ld    A, E          ; 1:4       do 182 
    ld  (stp_lo182), A  ; 3:13      do 182 lo stop
    ld    A, D          ; 1:4       do 182 
    ld  (stp_hi182), A  ; 3:13      do 182 hi stop
    pop  HL             ; 1:10      do 182
    pop  DE             ; 1:10      do 182 ( -- ) R: ( -- )
do182:                  ;           do 182 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else156    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string238
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave182       ;           leave 182 
else156  EQU $          ;           = endif
endif156: 
        
    push DE             ; 1:11      index i 182
    ex   DE, HL         ; 1:4       index i 182
    ld   HL, (idx182)   ; 3:16      index i 182 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    
    push HL             ; 1:11      3 +loop 182
idx182 EQU $+1          ;           3 +loop 182
    ld   HL, 0x0000     ; 3:10      3 +loop 182
    ld   BC, 3          ; 3:10      3 +loop 182 BC = step
    add  HL, BC         ; 1:11      3 +loop 182 HL = index+step
    ld  (idx182), HL    ; 3:16      3 +loop 182 save index
stp_lo182 EQU $+1       ;           3 +loop 182
    ld    A, 0x00       ; 2:7       3 +loop 182 lo stop
    sub   L             ; 1:4       3 +loop 182
    ld    L, A          ; 1:4       3 +loop 182
stp_hi182 EQU $+1       ;           3 +loop 182
    ld    A, 0x00       ; 2:7       3 +loop 182 hi stop
    sbc   A, H          ; 1:4       3 +loop 182
    ld    H, A          ; 1:4       3 +loop 182 HL = stop-(index+step)
    add  HL, BC         ; 1:11      3 +loop 182 HL = stop-index
    xor   H             ; 1:4       3 +loop 182
    pop  HL             ; 1:10      3 +loop 182
    jp    p, do182      ; 3:10      3 +loop 182 negative step
leave182:               ;           3 +loop 182
exit182:                ;           3 +loop 182 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string239  ; 3:10      print_z   Address of null-terminated string239
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo183:                 ;           sdo 183 ( stop index -- stop index ) 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else157    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string240
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave183      ; 3:10      sleave 183 
else157  EQU $          ;           = endif
endif157: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    pop  BC             ; 1:10      +sloop 183 BC = stop
    ex   DE, HL         ; 1:4       +sloop 183
    or    A             ; 1:4       +sloop 183
    sbc  HL, BC         ; 2:15      +sloop 183 HL = index-stop
    ld    A, H          ; 1:4       +sloop 183
    add  HL, DE         ; 1:11      +sloop 183 HL = index-stop+step
    xor   H             ; 1:4       +sloop 183 sign flag!
    add  HL, BC         ; 1:11      +sloop 183 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 183
    ld    E, C          ; 1:4       +sloop 183
    jp    p, sdo183     ; 3:10      +sloop 183
sleave183:              ;           +sloop 183
    pop  HL             ; 1:10      unsloop 183 index out
    pop  DE             ; 1:10      unsloop 183 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string241  ; 3:10      print_z   Address of null-terminated string241
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo184:                 ;           sdo 184 ( stop index -- stop index )  
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else158    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string242
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave184      ; 3:10      sleave 184 
else158  EQU $          ;           = endif
endif158: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
    
    ld   BC, 3          ; 3:10      push_addsloop(3) 184 BC = step
    or    A             ; 1:4       push_addsloop(3) 184
    sbc  HL, DE         ; 2:15      push_addsloop(3) 184 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(3) 184
    add  HL, BC         ; 1:11      push_addsloop(3) 184 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(3) 184 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(3) 184 HL = index+step, sign flag unaffected
    jp    p, sdo184     ; 3:10      push_addsloop(3) 184
sleave184:              ;           push_addsloop(3) 184
    pop  HL             ; 1:10      unsloop 184 index out
    pop  DE             ; 1:10      unsloop 184 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 


_up3_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
_smycka:                ;           
    pop  BC             ; 1:10      : ret
    ld  (_smycka_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string243  ; 3:10      print_z   Address of null-terminated string243
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      rdo 185 index
    push DE             ; 1:11      rdo 185 stop
    exx                 ; 1:4       rdo 185
    pop  DE             ; 1:10      rdo 185 stop
    dec  HL             ; 1:6       rdo 185
    ld  (HL),D          ; 1:7       rdo 185
    dec  L              ; 1:4       rdo 185
    ld  (HL),E          ; 1:7       rdo 185 stop
    pop  DE             ; 1:10      rdo 185 index
    dec  HL             ; 1:6       rdo 185
    ld  (HL),D          ; 1:7       rdo 185
    dec  L              ; 1:4       rdo 185
    ld  (HL),E          ; 1:7       rdo 185 index
    exx                 ; 1:4       rdo 185
    pop  HL             ; 1:10      rdo 185
    pop  DE             ; 1:10      rdo 185 ( stop index -- ) R: ( -- stop index )
do185:                  ;           rdo 185 
    exx                 ; 1:4       index ri 185    
    ld    E,(HL)        ; 1:7       index ri 185
    inc   L             ; 1:4       index ri 185
    ld    D,(HL)        ; 1:7       index ri 185
    push DE             ; 1:11      index ri 185
    dec   L             ; 1:4       index ri 185
    exx                 ; 1:4       index ri 185
    ex   DE, HL         ; 1:4       index ri 185
    ex  (SP),HL         ; 1:19      index ri 185 
    call PRINT_S16      ; 3:17      . 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else159    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string244
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 185
    inc  L              ; 1:4       rleave 185
    inc  HL             ; 1:6       rleave 185
    inc  L              ; 1:4       rleave 185
    jp   leave185       ;           rleave 185 
else159  EQU $          ;           = endif
endif159: 
    
    exx                 ; 1:4       rloop 185
    ld    E,(HL)        ; 1:7       rloop 185
    inc   L             ; 1:4       rloop 185
    ld    D,(HL)        ; 1:7       rloop 185 DE = index   
    inc  HL             ; 1:6       rloop 185
    inc  DE             ; 1:6       rloop 185 index++
    ld    A,(HL)        ; 1:4       rloop 185
    xor   E             ; 1:4       rloop 185 lo index - stop
    jr   nz, $+8        ; 2:7/12    rloop 185
    ld    A, D          ; 1:4       rloop 185
    inc   L             ; 1:4       rloop 185
    xor (HL)            ; 1:7       rloop 185 hi index - stop
    jr    z, leave185   ; 2:7/12    rloop 185 exit    
    dec   L             ; 1:4       rloop 185
    dec  HL             ; 1:6       rloop 185
    ld  (HL), D         ; 1:7       rloop 185
    dec   L             ; 1:4       rloop 185
    ld  (HL), E         ; 1:7       rloop 185
    exx                 ; 1:4       rloop 185
    jp   do185          ; 3:10      rloop 185
leave185:               ;           rloop 185
    inc  HL             ; 1:6       rloop 185
    exx                 ; 1:4       rloop 185
exit185:                ;           rloop 185 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string245  ; 3:10      print_z   Address of null-terminated string245
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx186), HL    ; 3:16      do 186 save index
    dec  DE             ; 1:6       do 186 stop-1
    ld    A, E          ; 1:4       do 186 
    ld  (stp_lo186), A  ; 3:13      do 186 lo stop
    ld    A, D          ; 1:4       do 186 
    ld  (stp_hi186), A  ; 3:13      do 186 hi stop
    pop  HL             ; 1:10      do 186
    pop  DE             ; 1:10      do 186 ( -- ) R: ( -- )
do186:                  ;           do 186 
    push DE             ; 1:11      index i 186
    ex   DE, HL         ; 1:4       index i 186
    ld   HL, (idx186)   ; 3:16      index i 186 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else160    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string246
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave186       ;           leave 186 
else160  EQU $          ;           = endif
endif160: 
    
idx186 EQU $+1          ;           loop 186
    ld   BC, 0x0000     ; 3:10      loop 186 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 186
stp_lo186 EQU $+1       ;           loop 186
    xor  0x00           ; 2:7       loop 186 lo index - stop - 1
    ld    A, B          ; 1:4       loop 186
    inc  BC             ; 1:6       loop 186 index++
    ld  (idx186),BC     ; 4:20      loop 186 save index
    jp   nz, do186      ; 3:10      loop 186    
stp_hi186 EQU $+1       ;           loop 186
    xor  0x00           ; 2:7       loop 186 hi index - stop - 1
    jp   nz, do186      ; 3:10      loop 186
leave186:               ;           loop 186
exit186:                ;           loop 186 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string247  ; 3:10      print_z   Address of null-terminated string247
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo187:                 ;           sdo 187 ( stop index -- stop index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else161    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string248
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave187      ; 3:10      sleave 187 
else161  EQU $          ;           = endif
endif161: 
    
    inc  HL             ; 1:6       sloop 187 index++
    ld    A, E          ; 1:4       sloop 187
    xor   L             ; 1:4       sloop 187 lo index - stop
    jp   nz, sdo187     ; 3:10      sloop 187
    ld    A, D          ; 1:4       sloop 187
    xor   H             ; 1:4       sloop 187 hi index - stop
    jp   nz, sdo187     ; 3:10      sloop 187
sleave187:              ;           sloop 187
    pop  HL             ; 1:10      unsloop 187 index out
    pop  DE             ; 1:10      unsloop 187 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

_smycka_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
_otaznik:               ;           
    pop  BC             ; 1:10      : ret
    ld  (_otaznik_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b )

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string249  ; 3:10      print_z   Address of null-terminated string249
    call PRINT_STRING_Z ; 3:17      print_z
    
    push HL             ; 1:11      ?rdo 188 index
    or    A             ; 1:4       ?rdo 188
    sbc  HL, DE         ; 2:15      ?rdo 188
    jr   nz, $+8        ; 2:7/12    ?rdo 188
    pop  HL             ; 1:10      ?rdo 188
    pop  HL             ; 1:10      ?rdo 188
    pop  DE             ; 1:10      ?rdo 188
    jp   exit188        ; 3:10      ?rdo 188   
    push DE             ; 1:11      ?rdo 188 stop
    exx                 ; 1:4       ?rdo 188
    pop  DE             ; 1:10      ?rdo 188 stop
    dec  HL             ; 1:6       ?rdo 188
    ld  (HL),D          ; 1:7       ?rdo 188
    dec  L              ; 1:4       ?rdo 188
    ld  (HL),E          ; 1:7       ?rdo 188 stop
    pop  DE             ; 1:10      ?rdo 188 index
    dec  HL             ; 1:6       ?rdo 188
    ld  (HL),D          ; 1:7       ?rdo 188
    dec  L              ; 1:4       ?rdo 188
    ld  (HL),E          ; 1:7       ?rdo 188 index
    exx                 ; 1:4       ?rdo 188
    pop  HL             ; 1:10      ?rdo 188
    pop  DE             ; 1:10      ?rdo 188 ( stop index -- ) R: ( -- stop index )
do188:                  ;           ?rdo 188 
    exx                 ; 1:4       index ri 188    
    ld    E,(HL)        ; 1:7       index ri 188
    inc   L             ; 1:4       index ri 188
    ld    D,(HL)        ; 1:7       index ri 188
    push DE             ; 1:11      index ri 188
    dec   L             ; 1:4       index ri 188
    exx                 ; 1:4       index ri 188
    ex   DE, HL         ; 1:4       index ri 188
    ex  (SP),HL         ; 1:19      index ri 188 
    call PRINT_S16      ; 3:17      . 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else162    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string250
    call PRINT_STRING_Z ; 3:17      print_z
    exx                 ; 1:4       rleave 188
    inc  L              ; 1:4       rleave 188
    inc  HL             ; 1:6       rleave 188
    inc  L              ; 1:4       rleave 188
    jp   leave188       ;           rleave 188 
else162  EQU $          ;           = endif
endif162: 
    
    exx                 ; 1:4       rloop 188
    ld    E,(HL)        ; 1:7       rloop 188
    inc   L             ; 1:4       rloop 188
    ld    D,(HL)        ; 1:7       rloop 188 DE = index   
    inc  HL             ; 1:6       rloop 188
    inc  DE             ; 1:6       rloop 188 index++
    ld    A,(HL)        ; 1:4       rloop 188
    xor   E             ; 1:4       rloop 188 lo index - stop
    jr   nz, $+8        ; 2:7/12    rloop 188
    ld    A, D          ; 1:4       rloop 188
    inc   L             ; 1:4       rloop 188
    xor (HL)            ; 1:7       rloop 188 hi index - stop
    jr    z, leave188   ; 2:7/12    rloop 188 exit    
    dec   L             ; 1:4       rloop 188
    dec  HL             ; 1:6       rloop 188
    ld  (HL), D         ; 1:7       rloop 188
    dec   L             ; 1:4       rloop 188
    ld  (HL), E         ; 1:7       rloop 188
    exx                 ; 1:4       rloop 188
    jp   do188          ; 3:10      rloop 188
leave188:               ;           rloop 188
    inc  HL             ; 1:6       rloop 188
    exx                 ; 1:4       rloop 188
exit188:                ;           rloop 188 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string251  ; 3:10      print_z   Address of null-terminated string251
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx189), HL    ; 3:16      ?do 189 save index
    or    A             ; 1:4       ?do 189
    sbc  HL, DE         ; 2:15      ?do 189
    dec  DE             ; 1:6       ?do 189 stop-1
    ld    A, E          ; 1:4       ?do 189 
    ld  (stp_lo189), A  ; 3:13      ?do 189 lo stop
    ld    A, D          ; 1:4       ?do 189 
    ld  (stp_hi189), A  ; 3:13      ?do 189 hi stop
    pop  HL             ; 1:10      ?do 189
    pop  DE             ; 1:10      ?do 189
    jp    z, exit189    ; 3:10      ?do 189 ( -- ) R: ( -- )
do189:                  ;           ?do 189 
    push DE             ; 1:11      index i 189
    ex   DE, HL         ; 1:4       index i 189
    ld   HL, (idx189)   ; 3:16      index i 189 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else163    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string252
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave189       ;           leave 189 
else163  EQU $          ;           = endif
endif163: 
    
idx189 EQU $+1          ;           loop 189
    ld   BC, 0x0000     ; 3:10      loop 189 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 189
stp_lo189 EQU $+1       ;           loop 189
    xor  0x00           ; 2:7       loop 189 lo index - stop - 1
    ld    A, B          ; 1:4       loop 189
    inc  BC             ; 1:6       loop 189 index++
    ld  (idx189),BC     ; 4:20      loop 189 save index
    jp   nz, do189      ; 3:10      loop 189    
stp_hi189 EQU $+1       ;           loop 189
    xor  0x00           ; 2:7       loop 189 hi index - stop - 1
    jp   nz, do189      ; 3:10      loop 189
leave189:               ;           loop 189
exit189:                ;           loop 189 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    ld   BC, string253  ; 3:10      print_z   Address of null-terminated string253
    call PRINT_STRING_Z ; 3:17      print_z
    

    push HL             ; 1:10      ?sdo 190
    or    A             ; 1:4       ?sdo 190
    sbc  HL, DE         ; 2:15      ?sdo 190
    pop  HL             ; 1:10      ?sdo 190
    jp    z, sleave190  ; 3:10      ?sdo 190   
sdo190:                 ;           ?sdo 190 ( stop index -- stop index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      . 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else164    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string254
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave190      ; 3:10      sleave 190 
else164  EQU $          ;           = endif
endif164: 
    
    inc  HL             ; 1:6       sloop 190 index++
    ld    A, E          ; 1:4       sloop 190
    xor   L             ; 1:4       sloop 190 lo index - stop
    jp   nz, sdo190     ; 3:10      sloop 190
    ld    A, D          ; 1:4       sloop 190
    xor   H             ; 1:4       sloop 190 hi index - stop
    jp   nz, sdo190     ; 3:10      sloop 190
sleave190:              ;           sloop 190
    pop  HL             ; 1:10      unsloop 190 index out
    pop  DE             ; 1:10      unsloop 190 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

_otaznik_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------





;   ---  the beginning of a non-recursive function  ---
_3loop:                 ;           
    pop  BC             ; 1:10      : ret
    ld  (_3loop_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    
    ld   (_krok), HL    ; 3:16      _krok ! push(_krok) store
    ex   DE, HL         ; 1:4       _krok ! push(_krok) store
    pop  DE             ; 1:10      _krok ! push(_krok) store
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      _krok @ push(_krok) fetch
    ex   DE, HL         ; 1:4       _krok @ push(_krok) fetch
    ld   HL,(_krok)     ; 3:16      _krok @ push(_krok) fetch 
    call PRINT_S16      ; 3:17      . 
    ld   BC, string255  ; 3:10      print_z   Address of null-terminated string255
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld  (idx191), HL    ; 3:16      do 191 save index
    dec  DE             ; 1:6       do 191 stop-1
    ld    A, E          ; 1:4       do 191 
    ld  (stp_lo191), A  ; 3:13      do 191 lo stop
    ld    A, D          ; 1:4       do 191 
    ld  (stp_hi191), A  ; 3:13      do 191 hi stop
    pop  HL             ; 1:10      do 191
    pop  DE             ; 1:10      do 191 ( -- ) R: ( -- )
do191:                  ;           do 191 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else165    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string256
    call PRINT_STRING_Z ; 3:17      print_z
    jp   leave191       ;           leave 191 
else165  EQU $          ;           = endif
endif165: 
        
    push DE             ; 1:11      index i 191
    ex   DE, HL         ; 1:4       index i 191
    ld   HL, (idx191)   ; 3:16      index i 191 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      .
        
    push DE             ; 1:11      _krok @ push(_krok) fetch
    ex   DE, HL         ; 1:4       _krok @ push(_krok) fetch
    ld   HL,(_krok)     ; 3:16      _krok @ push(_krok) fetch
    
    ld    B, H          ; 1:4       +loop 191
    ld    C, L          ; 1:4       +loop 191 BC = step
idx191 EQU $+1          ;           +loop 191
    ld   HL, 0x0000     ; 3:10      +loop 191
    add  HL, BC         ; 1:11      +loop 191 HL = index+step
    ld  (idx191), HL    ; 3:16      +loop 191 save index
stp_lo191 EQU $+1       ;           +loop 191
    ld    A, 0x00       ; 2:7       +loop 191 lo stop
    sub   L             ; 1:4       +loop 191
    ld    L, A          ; 1:4       +loop 191
stp_hi191 EQU $+1       ;           +loop 191
    ld    A, 0x00       ; 2:7       +loop 191 hi stop
    sbc   A, H          ; 1:4       +loop 191
    ld    H, A          ; 1:4       +loop 191 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 191 HL = stop-index
    xor   H             ; 1:4       +loop 191
    ex   DE, HL         ; 1:4       +loop 191
    pop  DE             ; 1:10      +loop 191
    jp    p, do191      ; 3:10      +loop 191
leave191:               ;           +loop 191
exit191:                ;           +loop 191 
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_3loop_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------



;   ---  the beginning of a non-recursive function  ---
_3sloop:                ;           
    pop  BC             ; 1:10      : ret
    ld  (_3sloop_end+1),BC; 4:20      : ( ret -- ) R:( -- ) 
    
    ld   (_krok), HL    ; 3:16      _krok ! push(_krok) store
    ex   DE, HL         ; 1:4       _krok ! push(_krok) store
    pop  DE             ; 1:10      _krok ! push(_krok) store
    
    ld   BC, 6          ; 3:10      push2_store(6,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(6,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      _krok @ push(_krok) fetch
    ex   DE, HL         ; 1:4       _krok @ push(_krok) fetch
    ld   HL,(_krok)     ; 3:16      _krok @ push(_krok) fetch 
    call PRINT_S16      ; 3:17      . 
    ld   BC, string257  ; 3:10      print_z   Address of null-terminated string257
    call PRINT_STRING_Z ; 3:17      print_z
    

sdo192:                 ;           sdo 192 ( stop index -- stop index ) 
        
    push DE             ; 1:11      _stop @ push(_stop) fetch
    ex   DE, HL         ; 1:4       _stop @ push(_stop) fetch
    ld   HL,(_stop)     ; 3:16      _stop @ push(_stop) fetch 
    dec  HL             ; 1:6       1- 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   (_stop), HL    ; 3:16      _stop ! push(_stop) store
    ex   DE, HL         ; 1:4       _stop ! push(_stop) store
    pop  DE             ; 1:10      _stop ! push(_stop) store
        
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else166    ; 3:10      0= if 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120 == string258
    call PRINT_STRING_Z ; 3:17      print_z
    jp   sleave192      ; 3:10      sleave 192 
else166  EQU $          ;           = endif
endif166: 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call PRINT_S16      ; 3:17      .
        
    push DE             ; 1:11      _krok @ push(_krok) fetch
    ex   DE, HL         ; 1:4       _krok @ push(_krok) fetch
    ld   HL,(_krok)     ; 3:16      _krok @ push(_krok) fetch
    
    pop  BC             ; 1:10      +sloop 192 BC = stop
    ex   DE, HL         ; 1:4       +sloop 192
    or    A             ; 1:4       +sloop 192
    sbc  HL, BC         ; 2:15      +sloop 192 HL = index-stop
    ld    A, H          ; 1:4       +sloop 192
    add  HL, DE         ; 1:11      +sloop 192 HL = index-stop+step
    xor   H             ; 1:4       +sloop 192 sign flag!
    add  HL, BC         ; 1:11      +sloop 192 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 192
    ld    E, C          ; 1:4       +sloop 192
    jp    p, sdo192     ; 3:10      +sloop 192
sleave192:              ;           +sloop 192
    pop  HL             ; 1:10      unsloop 192 index out
    pop  DE             ; 1:10      unsloop 192 stop  out
 
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_3sloop_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_S16:
    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, PRINT_U16  ; 2:7/12

    xor   A             ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    L, A          ; 1:4       neg
    sbc   A, H          ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    H, A          ; 1:4       neg
    
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      ld   BC, **

    ; fall to print_u16
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, AF', BC, DE, HL = DE, DE = (SP)
PRINT_U16:
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A

; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_U16_ONLY:
    call BIN2DEC        ; 3:17
    pop  BC             ; 1:10      ret
    ex   DE, HL         ; 1:4
    pop  DE             ; 1:10
    push BC             ; 1:10      ret
    ret                 ; 1:10

; Input: HL = number
; Output: print number
; Pollutes: AF, HL, BC
BIN2DEC:
    xor   A             ; 1:4       A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10
    call BIN2DEC_CHAR+2 ; 3:17
    ld   BC, -1000      ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld   BC, -100       ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld    C, -10        ; 2:7
    call BIN2DEC_CHAR   ; 3:17
    ld    A, L          ; 1:4
    add   A,'0'         ; 2:7
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10

BIN2DEC_CHAR:
    and  0xF0           ; 2:7       '0'..'9' => '0', unchanged 0

    add  HL, BC         ; 1:11
    inc   A             ; 1:4
    jr    c, $-2        ; 2:7/12
    sbc  HL, BC         ; 2:15
    dec   A             ; 1:4
    ret   z             ; 1:5/11

    or   '0'            ; 2:7       0 => '0', unchanged '0'..'9'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst   0x10          ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z
VARIABLE_SECTION:

_stop: dw 0x0000
_krok: dw 0x0000

STRING_SECTION:
string257:
db "s:", 0x00
size257 EQU $ - string257
string255:
db "d:", 0x00
size255 EQU $ - string255
string253:
db "?s    l:", 0x00
size253 EQU $ - string253
string251:
db "?d    l:", 0x00
size251 EQU $ - string251
string249:
db "?r    l:", 0x00
size249 EQU $ - string249
string247:
db " s    l:", 0x00
size247 EQU $ - string247
string245:
db " d    l:", 0x00
size245 EQU $ - string245
string243:
db " r    l:", 0x00
size243 EQU $ - string243
string241:
db " s 3_+l:", 0x00
size241 EQU $ - string241
string239:
db " s 3 +l:", 0x00
size239 EQU $ - string239
string233:
db " d 3_+l:", 0x00
size233 EQU $ - string233
string231:
db " d 3 +l:", 0x00
size231 EQU $ - string231
string229:
db " s-3_+l:", 0x00
size229 EQU $ - string229
string227:
db " s-3 +l:", 0x00
size227 EQU $ - string227
string221:
db " d-3_+l:", 0x00
size221 EQU $ - string221
string219:
db " d-3 +l:", 0x00
size219 EQU $ - string219
string217:
db " s 2_+l:", 0x00
size217 EQU $ - string217
string215:
db " s 2 +l:", 0x00
size215 EQU $ - string215
string209:
db " d 2_+l:", 0x00
size209 EQU $ - string209
string207:
db " d 2 +l:", 0x00
size207 EQU $ - string207
string205:
db " s-2_+l:", 0x00
size205 EQU $ - string205
string203:
db " s-2 +l:", 0x00
size203 EQU $ - string203
string197:
db " d-2_+l:", 0x00
size197 EQU $ - string197
string195:
db " d-2 +l:", 0x00
size195 EQU $ - string195
string193:
db " s 1_+l:", 0x00
size193 EQU $ - string193
string191:
db " s 1 +l:", 0x00
size191 EQU $ - string191
string185:
db " d 1_+l:", 0x00
size185 EQU $ - string185
string183:
db " d 1 +l:", 0x00
size183 EQU $ - string183
string181:
db " s-1_+l:", 0x00
size181 EQU $ - string181
string179:
db " s-1 +l:", 0x00
size179 EQU $ - string179
string177:
db " d-1_+l:", 0x00
size177 EQU $ - string177
string175:
db " d-1 +l:", 0x00
size175 EQU $ - string175
string173:
db " r-1_+l:", 0x00
size173 EQU $ - string173
string171:
db " r-1 +l:", 0x00
size171 EQU $ - string171
string167:
db " 0  0 x:", 0x00
size167 EQU $ - string167
string163:
db "-1  1 x:", 0x00
size163 EQU $ - string163
string161:
db "-1 -5 x:", 0x00
size161 EQU $ - string161
string159:
db " 2 -1 x:", 0x00
size159 EQU $ - string159
string157:
db " 1  1 ?x:", 0x00
size157 EQU $ - string157
string155:
db "-1 -1 ?x:", 0x00
size155 EQU $ - string155
string151:
db " 2 -2 -4 x:", 0x00
size151 EQU $ - string151
string147:
db " 2 -2 -2 x:", 0x00
size147 EQU $ - string147
string143:
db " 2 -2 -1 x:", 0x00
size143 EQU $ - string143
string139:
db " 0  0  4 x:", 0x00
size139 EQU $ - string139
string135:
db " 0  0  2 x:", 0x00
size135 EQU $ - string135
string131:
db " 0  0  1 x:", 0x00
size131 EQU $ - string131
string127:
db "-2  2  4 x:", 0x00
size127 EQU $ - string127
string123:
db "-2  2  2 x:", 0x00
size123 EQU $ - string123
string120:
db "..", 0x00
size120 EQU $ - string120
string119:
db "-2  2  1 x:", 0x00
size119 EQU $ - string119
string117:
db " 2 -2  4 x:", 0x00
size117 EQU $ - string117
string115:
db " 2 -2  2 x:", 0x00
size115 EQU $ - string115
string113:
db " 2 -2  1 x:", 0x00
size113 EQU $ - string113
string111:
db " 0  0 -4 x:", 0x00
size111 EQU $ - string111
string109:
db " 0  0 -2 x:", 0x00
size109 EQU $ - string109
string107:
db " 0  0 -1 x:", 0x00
size107 EQU $ - string107
string105:
db "-2  2 -4 x:", 0x00
size105 EQU $ - string105
string103:
db "-2  2 -2 x:", 0x00
size103 EQU $ - string103
string101:
db "-2  2 -1 x:", 0x00
size101 EQU $ - string101

; vvv
; ^^^
ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx

 

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _down3         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _up3           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _smycka        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
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

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _down1         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _down2         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _down3         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _up1           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _up2           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _up3           ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _smycka        ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
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

    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    push DE             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   HL, 0          ; 3:10      push2(4,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    push DE             ; 1:11      push2(-1,0)
    ld   DE, -1         ; 3:10      push2(-1,0)
    push HL             ; 1:11      push2(-1,0)
    ld   HL, 0          ; 3:10      push2(-1,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    push DE             ; 1:11      push2(2,0)
    ld   DE, 2          ; 3:10      push2(2,0)
    push HL             ; 1:11      push2(2,0)
    ld   HL, 0          ; 3:10      push2(2,0) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

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
    push DE             ; 1:11      push2(11,-10)
    ld   DE, 11         ; 3:10      push2(11,-10)
    push HL             ; 1:11      push2(11,-10)
    ld   HL, -10        ; 3:10      push2(11,-10) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(9,-10)
    ld   DE, 9          ; 3:10      push2(9,-10)
    push HL             ; 1:11      push2(9,-10)
    ld   HL, -10        ; 3:10      push2(9,-10) 
    call _3loop         ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

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
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

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
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

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
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

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
    call _3sloop        ; 3:17      call ( -- ret ) R:( -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

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

    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, 1          ; 3:10      xdo(-1,1) 102
    ld  (idx102),BC     ; 4:20      xdo(-1,1) 102
xdo102:                 ;           xdo(-1,1) 102 
    push DE             ; 1:11      index i 102
    ex   DE, HL         ; 1:4       index i 102
    ld   HL, (idx102)   ; 3:16      index i 102 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      -2 +xloop 102
idx102 EQU $+1          ;           -2 +xloop 102
    ld   HL, 0x0000     ; 3:10      -2 +xloop 102
    ld   BC, -2         ; 3:10      -2 +xloop 102 BC = step
    add  HL, BC         ; 1:11      -2 +xloop 102 HL = index+step
    ld  (idx102), HL    ; 3:16      -2 +xloop 102 save index
    ld    A, low -2     ; 2:7       -2 +xloop 102
    sub   L             ; 1:4       -2 +xloop 102
    ld    L, A          ; 1:4       -2 +xloop 102
    ld    A, high -2    ; 2:7       -2 +xloop 102
    sbc   A, H          ; 1:4       -2 +xloop 102
    ld    H, A          ; 1:4       -2 +xloop 102 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -2 +xloop 102 HL = stop-index
    pop  HL             ; 1:10      -2 +xloop 102
    jp    c, xdo102     ; 3:10      -2 +xloop 102 negative step
xleave102:              ;           -2 +xloop 102
xexit102:               ;           -2 +xloop 102 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, 1          ; 3:10      xdo(-1,1) 103
    ld  (idx103),BC     ; 4:20      xdo(-1,1) 103
xdo103:                 ;           xdo(-1,1) 103 
    push DE             ; 1:11      index i 103
    ex   DE, HL         ; 1:4       index i 103
    ld   HL, (idx103)   ; 3:16      index i 103 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      -4 +xloop 103
idx103 EQU $+1          ;           -4 +xloop 103
    ld   HL, 0x0000     ; 3:10      -4 +xloop 103
    ld   BC, -4         ; 3:10      -4 +xloop 103 BC = step
    add  HL, BC         ; 1:11      -4 +xloop 103 HL = index+step
    ld  (idx103), HL    ; 3:16      -4 +xloop 103 save index
    ld    A, low -2     ; 2:7       -4 +xloop 103
    sub   L             ; 1:4       -4 +xloop 103
    ld    L, A          ; 1:4       -4 +xloop 103
    ld    A, high -2    ; 2:7       -4 +xloop 103
    sbc   A, H          ; 1:4       -4 +xloop 103
    ld    H, A          ; 1:4       -4 +xloop 103 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -4 +xloop 103 HL = stop-index
    pop  HL             ; 1:10      -4 +xloop 103
    jp    c, xdo103     ; 3:10      -4 +xloop 103 negative step
xleave103:              ;           -4 +xloop 103
xexit103:               ;           -4 +xloop 103 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, 0          ; 3:10      xdo(0,0) 104
    ld  (idx104),BC     ; 4:20      xdo(0,0) 104
xdo104:                 ;           xdo(0,0) 104 
    push DE             ; 1:11      index i 104
    ex   DE, HL         ; 1:4       index i 104
    ld   HL, (idx104)   ; 3:16      index i 104 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
                        ;           push_addxloop(-1) 104
idx104 EQU $+1          ;           -1 +xloop 104
    ld   BC, 0x0000     ; 3:10      -1 +xloop 104 idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop 104
    xor  low 0          ; 2:7       -1 +xloop 104
    ld    A, B          ; 1:4       -1 +xloop 104
    dec  BC             ; 1:6       -1 +xloop 104 index--
    ld  (idx104),BC     ; 4:20      -1 +xloop 104 save index
    jp   nz, xdo104     ; 3:10      -1 +xloop 104
    xor  high 0         ; 2:7       -1 +xloop 104
    jp   nz, xdo104     ; 3:10      -1 +xloop 104
xleave104:              ;           -1 +xloop 104
xexit104:               ;           xloop 104 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, 0          ; 3:10      xdo(0,0) 105
    ld  (idx105),BC     ; 4:20      xdo(0,0) 105
xdo105:                 ;           xdo(0,0) 105 
    push DE             ; 1:11      index i 105
    ex   DE, HL         ; 1:4       index i 105
    ld   HL, (idx105)   ; 3:16      index i 105 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      -2 +xloop 105
idx105 EQU $+1          ;           -2 +xloop 105
    ld   HL, 0x0000     ; 3:10      -2 +xloop 105
    ld   BC, -2         ; 3:10      -2 +xloop 105 BC = step
    add  HL, BC         ; 1:11      -2 +xloop 105 HL = index+step
    ld  (idx105), HL    ; 3:16      -2 +xloop 105 save index
    ld    A, low -1     ; 2:7       -2 +xloop 105
    sub   L             ; 1:4       -2 +xloop 105
    ld    L, A          ; 1:4       -2 +xloop 105
    ld    A, high -1    ; 2:7       -2 +xloop 105
    sbc   A, H          ; 1:4       -2 +xloop 105
    ld    H, A          ; 1:4       -2 +xloop 105 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -2 +xloop 105 HL = stop-index
    pop  HL             ; 1:10      -2 +xloop 105
    jp    c, xdo105     ; 3:10      -2 +xloop 105 negative step
xleave105:              ;           -2 +xloop 105
xexit105:               ;           -2 +xloop 105 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, 0          ; 3:10      xdo(0,0) 106
    ld  (idx106),BC     ; 4:20      xdo(0,0) 106
xdo106:                 ;           xdo(0,0) 106 
    push DE             ; 1:11      index i 106
    ex   DE, HL         ; 1:4       index i 106
    ld   HL, (idx106)   ; 3:16      index i 106 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      -4 +xloop 106
idx106 EQU $+1          ;           -4 +xloop 106
    ld   HL, 0x0000     ; 3:10      -4 +xloop 106
    ld   BC, -4         ; 3:10      -4 +xloop 106 BC = step
    add  HL, BC         ; 1:11      -4 +xloop 106 HL = index+step
    ld  (idx106), HL    ; 3:16      -4 +xloop 106 save index
    ld    A, low -1     ; 2:7       -4 +xloop 106
    sub   L             ; 1:4       -4 +xloop 106
    ld    L, A          ; 1:4       -4 +xloop 106
    ld    A, high -1    ; 2:7       -4 +xloop 106
    sbc   A, H          ; 1:4       -4 +xloop 106
    ld    H, A          ; 1:4       -4 +xloop 106 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -4 +xloop 106 HL = stop-index
    pop  HL             ; 1:10      -4 +xloop 106
    jp    c, xdo106     ; 3:10      -4 +xloop 106 negative step
xleave106:              ;           -4 +xloop 106
xexit106:               ;           -4 +xloop 106 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      print
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, -1         ; 3:10      xdo(2,-1) 107
    ld  (idx107),BC     ; 4:20      xdo(2,-1) 107
xdo107:                 ;           xdo(2,-1) 107 
    push DE             ; 1:11      index i 107
    ex   DE, HL         ; 1:4       index i 107
    ld   HL, (idx107)   ; 3:16      index i 107 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
                        ;           push_addxloop(1) 107
idx107 EQU $+1          ;           xloop 107
    ld   BC, 0x0000     ; 3:10      xloop 107 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 107 index++
    ld  (idx107),BC     ; 4:20      xloop 107 save index
    ld    A, C          ; 1:4       xloop 107
    xor  low 2          ; 2:7       xloop 107
    jp   nz, xdo107     ; 3:10      xloop 107
    ld    A, B          ; 1:4       xloop 107
    xor  high 2         ; 2:7       xloop 107
    jp   nz, xdo107     ; 3:10      xloop 107
xleave107:              ;           xloop 107
xexit107:               ;           xloop 107 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, -1         ; 3:10      xdo(2,-1) 108
    ld  (idx108),BC     ; 4:20      xdo(2,-1) 108
xdo108:                 ;           xdo(2,-1) 108 
    push DE             ; 1:11      index i 108
    ex   DE, HL         ; 1:4       index i 108
    ld   HL, (idx108)   ; 3:16      index i 108 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
                        ;           push_addxloop(2) 108
idx108 EQU $+1          ;           2 +xloop 108
    ld   BC, 0x0000     ; 3:10      2 +xloop 108 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 108 index++
    inc  BC             ; 1:6       2 +xloop 108 index++
    ld  (idx108),BC     ; 4:20      2 +xloop 108 save index
    ld    A, C          ; 1:4       2 +xloop 108
    sub  low 2          ; 2:7       2 +xloop 108
    rra                 ; 1:4       2 +xloop 108
    add   A, A          ; 1:4       2 +xloop 108 and 0xFE with save carry
    jp   nz, xdo108     ; 3:10      2 +xloop 108
    ld    A, B          ; 1:4       2 +xloop 108
    sbc   A, high 2     ; 2:7       2 +xloop 108
    jp   nz, xdo108     ; 3:10      2 +xloop 108
xleave108:              ;           2 +xloop 108
xexit108:               ;           2 +xloop 108 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, -1         ; 3:10      xdo(2,-1) 109
    ld  (idx109),BC     ; 4:20      xdo(2,-1) 109
xdo109:                 ;           xdo(2,-1) 109 
    push DE             ; 1:11      index i 109
    ex   DE, HL         ; 1:4       index i 109
    ld   HL, (idx109)   ; 3:16      index i 109 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      4 +xloop 109
idx109 EQU $+1          ;           4 +xloop 109
    ld   HL, 0x0000     ; 3:10      4 +xloop 109
    ld   BC, 4          ; 3:10      4 +xloop 109 BC = step
    add  HL, BC         ; 1:11      4 +xloop 109 HL = index+step
    ld  (idx109), HL    ; 3:16      4 +xloop 109 save index
    ld    A, low 1      ; 2:7       4 +xloop 109
    sub   L             ; 1:4       4 +xloop 109
    ld    L, A          ; 1:4       4 +xloop 109
    ld    A, high 1     ; 2:7       4 +xloop 109
    sbc   A, H          ; 1:4       4 +xloop 109
    ld    H, A          ; 1:4       4 +xloop 109 HL = stop-(index+step)
    add  HL, BC         ; 1:11      4 +xloop 109 HL = stop-index
    pop  HL             ; 1:10      4 +xloop 109
    jp   nc, xdo109     ; 3:10      4 +xloop 109 positive step
xleave109:              ;           4 +xloop 109
xexit109:               ;           4 +xloop 109 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size110    ; 3:10      print Length of string to print
    ld   DE, string110  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, 1          ; 3:10      xdo(-1,1) 110
    ld  (idx110),BC     ; 4:20      xdo(-1,1) 110
xdo110:                 ;           xdo(-1,1) 110 
    push DE             ; 1:11      index i 110
    ex   DE, HL         ; 1:4       index i 110
    ld   HL, (idx110)   ; 3:16      index i 110 idx always points to a 16-bit index 
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
    jp   nz, else101    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size111    ; 3:10      print Length of string to print
    ld   DE, string111  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave110      ;           xleave 110 
else101  EQU $          ;           = endif
endif101: 
                        ;           push_addxloop(1) 110
idx110 EQU $+1          ;           xloop 110
    ld   BC, 0x0000     ; 3:10      xloop 110 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 110 index++
    ld  (idx110),BC     ; 4:20      xloop 110 save index
    ld    A, C          ; 1:4       xloop 110
    xor  low -1         ; 2:7       xloop 110
    jp   nz, xdo110     ; 3:10      xloop 110
    ld    A, B          ; 1:4       xloop 110
    xor  high -1        ; 2:7       xloop 110
    jp   nz, xdo110     ; 3:10      xloop 110
xleave110:              ;           xloop 110
xexit110:               ;           xloop 110 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size112    ; 3:10      print Length of string to print
    ld   DE, string112  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, 1          ; 3:10      xdo(-1,1) 111
    ld  (idx111),BC     ; 4:20      xdo(-1,1) 111
xdo111:                 ;           xdo(-1,1) 111 
    push DE             ; 1:11      index i 111
    ex   DE, HL         ; 1:4       index i 111
    ld   HL, (idx111)   ; 3:16      index i 111 idx always points to a 16-bit index 
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
    jp   nz, else102    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size113    ; 3:10      print Length of string to print
    ld   DE, string113  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave111      ;           xleave 111 
else102  EQU $          ;           = endif
endif102: 
                        ;           push_addxloop(2) 111
idx111 EQU $+1          ;           2 +xloop 111
    ld   BC, 0x0000     ; 3:10      2 +xloop 111 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 111 index++
    inc  BC             ; 1:6       2 +xloop 111 index++
    ld  (idx111),BC     ; 4:20      2 +xloop 111 save index
    ld    A, C          ; 1:4       2 +xloop 111
    sub  low -1         ; 2:7       2 +xloop 111
    rra                 ; 1:4       2 +xloop 111
    add   A, A          ; 1:4       2 +xloop 111 and 0xFE with save carry
    jp   nz, xdo111     ; 3:10      2 +xloop 111
    ld    A, B          ; 1:4       2 +xloop 111
    sbc   A, high -1    ; 2:7       2 +xloop 111
    jp   nz, xdo111     ; 3:10      2 +xloop 111
xleave111:              ;           2 +xloop 111
xexit111:               ;           2 +xloop 111 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size114    ; 3:10      print Length of string to print
    ld   DE, string114  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, 1          ; 3:10      xdo(-1,1) 112
    ld  (idx112),BC     ; 4:20      xdo(-1,1) 112
xdo112:                 ;           xdo(-1,1) 112 
    push DE             ; 1:11      index i 112
    ex   DE, HL         ; 1:4       index i 112
    ld   HL, (idx112)   ; 3:16      index i 112 idx always points to a 16-bit index 
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
    jp   nz, else103    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size115    ; 3:10      print Length of string to print
    ld   DE, string115  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave112      ;           xleave 112 
else103  EQU $          ;           = endif
endif103: 
    push HL             ; 1:11      4 +xloop 112
idx112 EQU $+1          ;           4 +xloop 112
    ld   HL, 0x0000     ; 3:10      4 +xloop 112
    ld   BC, 4          ; 3:10      4 +xloop 112 BC = step
    add  HL, BC         ; 1:11      4 +xloop 112 HL = index+step
    ld  (idx112), HL    ; 3:16      4 +xloop 112 save index
    ld    A, low -2     ; 2:7       4 +xloop 112
    sub   L             ; 1:4       4 +xloop 112
    ld    L, A          ; 1:4       4 +xloop 112
    ld    A, high -2    ; 2:7       4 +xloop 112
    sbc   A, H          ; 1:4       4 +xloop 112
    ld    H, A          ; 1:4       4 +xloop 112 HL = stop-(index+step)
    add  HL, BC         ; 1:11      4 +xloop 112 HL = stop-index
    pop  HL             ; 1:10      4 +xloop 112
    jp   nc, xdo112     ; 3:10      4 +xloop 112 positive step
xleave112:              ;           4 +xloop 112
xexit112:               ;           4 +xloop 112 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      print
    ld   BC, size116    ; 3:10      print Length of string to print
    ld   DE, string116  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, 0          ; 3:10      xdo(0,0) 113
    ld  (idx113),BC     ; 4:20      xdo(0,0) 113
xdo113:                 ;           xdo(0,0) 113 
    push DE             ; 1:11      index i 113
    ex   DE, HL         ; 1:4       index i 113
    ld   HL, (idx113)   ; 3:16      index i 113 idx always points to a 16-bit index 
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
    jp   nz, else104    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size117    ; 3:10      print Length of string to print
    ld   DE, string117  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave113      ;           xleave 113 
else104  EQU $          ;           = endif
endif104: 
                        ;           push_addxloop(1) 113
idx113 EQU $+1          ;           xloop 113
    ld   BC, 0x0000     ; 3:10      xloop 113 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 113 index++
    ld  (idx113),BC     ; 4:20      xloop 113 save index
    ld    A, C          ; 1:4       xloop 113
    xor  low 0          ; 2:7       xloop 113
    jp   nz, xdo113     ; 3:10      xloop 113
    ld    A, B          ; 1:4       xloop 113
    xor  high 0         ; 2:7       xloop 113
    jp   nz, xdo113     ; 3:10      xloop 113
xleave113:              ;           xloop 113
xexit113:               ;           xloop 113 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size118    ; 3:10      print Length of string to print
    ld   DE, string118  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, 0          ; 3:10      xdo(0,0) 114
    ld  (idx114),BC     ; 4:20      xdo(0,0) 114
xdo114:                 ;           xdo(0,0) 114 
    push DE             ; 1:11      index i 114
    ex   DE, HL         ; 1:4       index i 114
    ld   HL, (idx114)   ; 3:16      index i 114 idx always points to a 16-bit index 
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
    jp   nz, else105    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size119    ; 3:10      print Length of string to print
    ld   DE, string119  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave114      ;           xleave 114 
else105  EQU $          ;           = endif
endif105: 
                        ;           push_addxloop(2) 114
idx114 EQU $+1          ;           2 +xloop 114
    ld   BC, 0x0000     ; 3:10      2 +xloop 114 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop 114 index++
    inc  BC             ; 1:6       2 +xloop 114 index++
    ld  (idx114),BC     ; 4:20      2 +xloop 114 save index
    ld    A, C          ; 1:4       2 +xloop 114
    sub  low 0          ; 2:7       2 +xloop 114
    rra                 ; 1:4       2 +xloop 114
    add   A, A          ; 1:4       2 +xloop 114 and 0xFE with save carry
    jp   nz, xdo114     ; 3:10      2 +xloop 114
    ld    A, B          ; 1:4       2 +xloop 114
    sbc   A, high 0     ; 2:7       2 +xloop 114
    jp   nz, xdo114     ; 3:10      2 +xloop 114
xleave114:              ;           2 +xloop 114
xexit114:               ;           2 +xloop 114 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size120    ; 3:10      print Length of string to print
    ld   DE, string120  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, 0          ; 3:10      xdo(0,0) 115
    ld  (idx115),BC     ; 4:20      xdo(0,0) 115
xdo115:                 ;           xdo(0,0) 115 
    push DE             ; 1:11      index i 115
    ex   DE, HL         ; 1:4       index i 115
    ld   HL, (idx115)   ; 3:16      index i 115 idx always points to a 16-bit index 
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
    jp   nz, else106    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size121    ; 3:10      print Length of string to print
    ld   DE, string121  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave115      ;           xleave 115 
else106  EQU $          ;           = endif
endif106: 
    push HL             ; 1:11      4 +xloop 115
idx115 EQU $+1          ;           4 +xloop 115
    ld   HL, 0x0000     ; 3:10      4 +xloop 115
    ld   BC, 4          ; 3:10      4 +xloop 115 BC = step
    add  HL, BC         ; 1:11      4 +xloop 115 HL = index+step
    ld  (idx115), HL    ; 3:16      4 +xloop 115 save index
    ld    A, low -1     ; 2:7       4 +xloop 115
    sub   L             ; 1:4       4 +xloop 115
    ld    L, A          ; 1:4       4 +xloop 115
    ld    A, high -1    ; 2:7       4 +xloop 115
    sbc   A, H          ; 1:4       4 +xloop 115
    ld    H, A          ; 1:4       4 +xloop 115 HL = stop-(index+step)
    add  HL, BC         ; 1:11      4 +xloop 115 HL = stop-index
    pop  HL             ; 1:10      4 +xloop 115
    jp   nc, xdo115     ; 3:10      4 +xloop 115 positive step
xleave115:              ;           4 +xloop 115
xexit115:               ;           4 +xloop 115 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      print
    ld   BC, size122    ; 3:10      print Length of string to print
    ld   DE, string122  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, -1         ; 3:10      xdo(2,-1) 116
    ld  (idx116),BC     ; 4:20      xdo(2,-1) 116
xdo116:                 ;           xdo(2,-1) 116 
    push DE             ; 1:11      index i 116
    ex   DE, HL         ; 1:4       index i 116
    ld   HL, (idx116)   ; 3:16      index i 116 idx always points to a 16-bit index 
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
    jp   nz, else107    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size123    ; 3:10      print Length of string to print
    ld   DE, string123  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave116      ;           xleave 116 
else107  EQU $          ;           = endif
endif107: 
                        ;           push_addxloop(-1) 116
idx116 EQU $+1          ;           -1 +xloop 116
    ld   BC, 0x0000     ; 3:10      -1 +xloop 116 idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop 116
    xor  low 2          ; 2:7       -1 +xloop 116
    ld    A, B          ; 1:4       -1 +xloop 116
    dec  BC             ; 1:6       -1 +xloop 116 index--
    ld  (idx116),BC     ; 4:20      -1 +xloop 116 save index
    jp   nz, xdo116     ; 3:10      -1 +xloop 116
    xor  high 2         ; 2:7       -1 +xloop 116
    jp   nz, xdo116     ; 3:10      -1 +xloop 116
xleave116:              ;           -1 +xloop 116
xexit116:               ;           xloop 116 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size124    ; 3:10      print Length of string to print
    ld   DE, string124  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, -1         ; 3:10      xdo(2,-1) 117
    ld  (idx117),BC     ; 4:20      xdo(2,-1) 117
xdo117:                 ;           xdo(2,-1) 117 
    push DE             ; 1:11      index i 117
    ex   DE, HL         ; 1:4       index i 117
    ld   HL, (idx117)   ; 3:16      index i 117 idx always points to a 16-bit index 
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
    jp   nz, else108    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size125    ; 3:10      print Length of string to print
    ld   DE, string125  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave117      ;           xleave 117 
else108  EQU $          ;           = endif
endif108: 
    push HL             ; 1:11      -2 +xloop 117
idx117 EQU $+1          ;           -2 +xloop 117
    ld   HL, 0x0000     ; 3:10      -2 +xloop 117
    ld   BC, -2         ; 3:10      -2 +xloop 117 BC = step
    add  HL, BC         ; 1:11      -2 +xloop 117 HL = index+step
    ld  (idx117), HL    ; 3:16      -2 +xloop 117 save index
    ld    A, low 1      ; 2:7       -2 +xloop 117
    sub   L             ; 1:4       -2 +xloop 117
    ld    L, A          ; 1:4       -2 +xloop 117
    ld    A, high 1     ; 2:7       -2 +xloop 117
    sbc   A, H          ; 1:4       -2 +xloop 117
    ld    H, A          ; 1:4       -2 +xloop 117 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -2 +xloop 117 HL = stop-index
    pop  HL             ; 1:10      -2 +xloop 117
    jp    c, xdo117     ; 3:10      -2 +xloop 117 negative step
xleave117:              ;           -2 +xloop 117
xexit117:               ;           -2 +xloop 117 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size126    ; 3:10      print Length of string to print
    ld   DE, string126  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, -1         ; 3:10      xdo(2,-1) 118
    ld  (idx118),BC     ; 4:20      xdo(2,-1) 118
xdo118:                 ;           xdo(2,-1) 118 
    push DE             ; 1:11      index i 118
    ex   DE, HL         ; 1:4       index i 118
    ld   HL, (idx118)   ; 3:16      index i 118 idx always points to a 16-bit index 
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
    jp   nz, else109    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size127    ; 3:10      print Length of string to print
    ld   DE, string127  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave118      ;           xleave 118 
else109  EQU $          ;           = endif
endif109: 
    push HL             ; 1:11      -4 +xloop 118
idx118 EQU $+1          ;           -4 +xloop 118
    ld   HL, 0x0000     ; 3:10      -4 +xloop 118
    ld   BC, -4         ; 3:10      -4 +xloop 118 BC = step
    add  HL, BC         ; 1:11      -4 +xloop 118 HL = index+step
    ld  (idx118), HL    ; 3:16      -4 +xloop 118 save index
    ld    A, low 1      ; 2:7       -4 +xloop 118
    sub   L             ; 1:4       -4 +xloop 118
    ld    L, A          ; 1:4       -4 +xloop 118
    ld    A, high 1     ; 2:7       -4 +xloop 118
    sbc   A, H          ; 1:4       -4 +xloop 118
    ld    H, A          ; 1:4       -4 +xloop 118 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -4 +xloop 118 HL = stop-index
    pop  HL             ; 1:10      -4 +xloop 118
    jp    c, xdo118     ; 3:10      -4 +xloop 118 negative step
xleave118:              ;           -4 +xloop 118
xexit118:               ;           -4 +xloop 118 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size128    ; 3:10      print Length of string to print
    ld   DE, string128  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    jp   xexit119       ; 3:10      ?xdo(-1,-1) 119
xdo119:                 ;           ?xdo(-1,-1) 119 
    push DE             ; 1:11      index i 119
    ex   DE, HL         ; 1:4       index i 119
    ld   HL, (idx119)   ; 3:16      index i 119 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
idx119 EQU $+1          ;           xloop 119
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

    push DE             ; 1:11      print
    ld   BC, size129    ; 3:10      print Length of string to print
    ld   DE, string129  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    jp   xexit120       ; 3:10      ?xdo(1,1) 120
xdo120:                 ;           ?xdo(1,1) 120 
    push DE             ; 1:11      index i 120
    ex   DE, HL         ; 1:4       index i 120
    ld   HL, (idx120)   ; 3:16      index i 120 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
idx120 EQU $+1          ;           xloop 120
    ld   BC, 0x0000     ; 3:10      xloop 120 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 120 index++
    ld  (idx120),BC     ; 4:20      xloop 120 save index
    ld    A, C          ; 1:4       xloop 120
    xor  low 1          ; 2:7       xloop 120
    jp   nz, xdo120     ; 3:10      xloop 120
    ld    A, B          ; 1:4       xloop 120
    xor  high 1         ; 2:7       xloop 120
    jp   nz, xdo120     ; 3:10      xloop 120
xleave120:              ;           xloop 120
xexit120:               ;           xloop 120 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size130    ; 3:10      print Length of string to print
    ld   DE, string130  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, -1         ; 3:10      xdo(2,-1) 121
    ld  (idx121),BC     ; 4:20      xdo(2,-1) 121
xdo121:                 ;           xdo(2,-1) 121 
    push DE             ; 1:11      index i 121
    ex   DE, HL         ; 1:4       index i 121
    ld   HL, (idx121)   ; 3:16      index i 121 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
idx121 EQU $+1          ;           xloop 121
    ld   BC, 0x0000     ; 3:10      xloop 121 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 121 index++
    ld  (idx121),BC     ; 4:20      xloop 121 save index
    ld    A, C          ; 1:4       xloop 121
    xor  low 2          ; 2:7       xloop 121
    jp   nz, xdo121     ; 3:10      xloop 121
    ld    A, B          ; 1:4       xloop 121
    xor  high 2         ; 2:7       xloop 121
    jp   nz, xdo121     ; 3:10      xloop 121
xleave121:              ;           xloop 121
xexit121:               ;           xloop 121 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size131    ; 3:10      print Length of string to print
    ld   DE, string131  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    ld   BC, -5         ; 3:10      xdo(-1,-5) 122
    ld  (idx122),BC     ; 4:20      xdo(-1,-5) 122
xdo122:                 ;           xdo(-1,-5) 122 
    push DE             ; 1:11      index i 122
    ex   DE, HL         ; 1:4       index i 122
    ld   HL, (idx122)   ; 3:16      index i 122 idx always points to a 16-bit index 
    call PRINT_S16      ; 3:17      . 
idx122 EQU $+1          ;           xloop 122 hi index == hi stop && index < stop
    ld   BC, 0x0000     ; 3:10      xloop 122 idx always points to a 16-bit index
    ld    A, C          ; 1:4       xloop 122
    inc   A             ; 1:4       xloop 122 index++
    ld  (idx122),A      ; 3:13      xloop 122 save index
    sub  low -1         ; 2:7       xloop 122 index - stop
    jp    c, xdo122     ; 3:10      xloop 122
xleave122:              ;           xloop 122
xexit122:               ;           xloop 122 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size132    ; 3:10      print Length of string to print
    ld   DE, string132  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, 1          ; 3:10      xdo(-1,1) 123
    ld  (idx123),BC     ; 4:20      xdo(-1,1) 123
xdo123:                 ;           xdo(-1,1) 123 
    push DE             ; 1:11      index i 123
    ex   DE, HL         ; 1:4       index i 123
    ld   HL, (idx123)   ; 3:16      index i 123 idx always points to a 16-bit index 
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
    jp   nz, else110    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size133    ; 3:10      print Length of string to print
    ld   DE, string133  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave123      ;           xleave 123 
else110  EQU $          ;           = endif
endif110: 
idx123 EQU $+1          ;           xloop 123
    ld   BC, 0x0000     ; 3:10      xloop 123 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 123 index++
    ld  (idx123),BC     ; 4:20      xloop 123 save index
    ld    A, C          ; 1:4       xloop 123
    xor  low -1         ; 2:7       xloop 123
    jp   nz, xdo123     ; 3:10      xloop 123
    ld    A, B          ; 1:4       xloop 123
    xor  high -1        ; 2:7       xloop 123
    jp   nz, xdo123     ; 3:10      xloop 123
xleave123:              ;           xloop 123
xexit123:               ;           xloop 123 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size134    ; 3:10      print Length of string to print
    ld   DE, string134  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    ld   BC, 0          ; 3:10      xdo(0,0) 124
    ld  (idx124),BC     ; 4:20      xdo(0,0) 124
xdo124:                 ;           xdo(0,0) 124 
    push DE             ; 1:11      index i 124
    ex   DE, HL         ; 1:4       index i 124
    ld   HL, (idx124)   ; 3:16      index i 124 idx always points to a 16-bit index 
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
    jp   nz, else111    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size135    ; 3:10      print Length of string to print
    ld   DE, string135  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   xleave124      ;           xleave 124 
else111  EQU $          ;           = endif
endif111: 
idx124 EQU $+1          ;           xloop 124
    ld   BC, 0x0000     ; 3:10      xloop 124 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 124 index++
    ld  (idx124),BC     ; 4:20      xloop 124 save index
    ld    A, C          ; 1:4       xloop 124
    xor  low 0          ; 2:7       xloop 124
    jp   nz, xdo124     ; 3:10      xloop 124
    ld    A, B          ; 1:4       xloop 124
    xor  high 0         ; 2:7       xloop 124
    jp   nz, xdo124     ; 3:10      xloop 124
xleave124:              ;           xloop 124
xexit124:               ;           xloop 124 
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
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size136    ; 3:10      print Length of string to print
    ld   DE, string136  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx125), HL    ; 3:16      do 125 index
    dec  DE             ; 1:6       do 125 stop-1
    ld    A, E          ; 1:4       do 125 
    ld  (stp_lo125), A  ; 3:13      do 125 lo stop
    ld    A, D          ; 1:4       do 125 
    ld  (stp_hi125), A  ; 3:13      do 125 hi stop
    pop  HL             ; 1:10      do 125
    pop  DE             ; 1:10      do 125 ( -- ) R: ( -- )
do125:                  ;           do 125 
    push DE             ; 1:11      index i 125
    ex   DE, HL         ; 1:4       index i 125
    ld   HL, (idx125)   ; 3:16      index i 125 idx always points to a 16-bit index 
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
    jp   nz, else112    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size137    ; 3:10      print Length of string to print
    ld   DE, string137  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave125       ;           leave 125 
else112  EQU $          ;           = endif
endif112: 
    
    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    ld    B, H          ; 1:4       +loop 125
    ld    C, L          ; 1:4       +loop 125 BC = step
idx125 EQU $+1          ;           +loop 125
    ld   HL, 0x0000     ; 3:10      +loop 125
    add  HL, BC         ; 1:11      +loop 125 HL = index+step
    ld  (idx125), HL    ; 3:16      +loop 125 save index
stp_lo125 EQU $+1       ;           +loop 125
    ld    A, 0x00       ; 2:7       +loop 125 lo stop
    sub   L             ; 1:4       +loop 125
    ld    L, A          ; 1:4       +loop 125
stp_hi125 EQU $+1       ;           +loop 125
    ld    A, 0x00       ; 2:7       +loop 125 hi stop
    sbc   A, H          ; 1:4       +loop 125
    ld    H, A          ; 1:4       +loop 125 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 125 HL = stop-index
    xor   H             ; 1:4       +loop 125
    ex   DE, HL         ; 1:4       +loop 125
    pop  DE             ; 1:10      +loop 125
    jp    p, do125      ; 3:10      +loop 125
leave125:               ;           +loop 125
exit125:                ;           +loop 125 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size138    ; 3:10      print Length of string to print
    ld   DE, string138  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx126), HL    ; 3:16      do 126 index
    dec  DE             ; 1:6       do 126 stop-1
    ld    A, E          ; 1:4       do 126 
    ld  (stp_lo126), A  ; 3:13      do 126 lo stop
    ld    A, D          ; 1:4       do 126 
    ld  (stp_hi126), A  ; 3:13      do 126 hi stop
    pop  HL             ; 1:10      do 126
    pop  DE             ; 1:10      do 126 ( -- ) R: ( -- )
do126:                  ;           do 126 
    push DE             ; 1:11      index i 126
    ex   DE, HL         ; 1:4       index i 126
    ld   HL, (idx126)   ; 3:16      index i 126 idx always points to a 16-bit index 
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
    jp   nz, else113    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size139    ; 3:10      print Length of string to print
    ld   DE, string139  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave126       ;           leave 126 
else113  EQU $          ;           = endif
endif113: 
    
                        ;           push_addloop(-1) 126
idx126 EQU $+1          ;           -1 +loop 126
    ld   BC, 0x0000     ; 3:10      -1 +loop 126 idx always points to a 16-bit index
    dec  BC             ; 1:6       -1 +loop 126 index--
    ld  (idx126),BC     ; 4:20      -1 +loop 126 save index
    ld    A, C          ; 1:4       -1 +loop 126
stp_lo126 EQU $+1       ;           -1 +loop 126
    xor  0x00           ; 2:7       -1 +loop 126 lo index - stop - 1
    jp   nz, do126      ; 3:10      -1 +loop 126
    ld    A, B          ; 1:4       -1 +loop 126
stp_hi126 EQU $+1       ;           -1 +loop 126
    xor  0x00           ; 2:7       -1 +loop 126 hi index - stop - 1
    jp   nz, do126      ; 3:10      -1 +loop 126
leave126:               ;           -1 +loop 126
exit126:                ;           -1 +loop 126 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size140    ; 3:10      print Length of string to print
    ld   DE, string140  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo127:                 ;           sdo 127 ( stop index -- stop index ) 
    
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
    jp   nz, else114    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size141    ; 3:10      print Length of string to print
    ld   DE, string141  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave127      ; 3:10      sleave 127 
else114  EQU $          ;           = endif
endif114: 
    
    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    pop  BC             ; 1:10      +sloop 127 BC = stop
    ex   DE, HL         ; 1:4       +sloop 127
    or    A             ; 1:4       +sloop 127
    sbc  HL, BC         ; 2:15      +sloop 127 HL = index-stop
    ld    A, H          ; 1:4       +sloop 127
    add  HL, DE         ; 1:11      +sloop 127 HL = index-stop+step
    xor   H             ; 1:4       +sloop 127 sign flag!
    add  HL, BC         ; 1:11      +sloop 127 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 127
    ld    E, C          ; 1:4       +sloop 127
    jp    p, sdo127     ; 3:10      +sloop 127
sleave127:              ;           +sloop 127
    pop  HL             ; 1:10      unsloop 127 index out
    pop  DE             ; 1:10      unsloop 127 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size142    ; 3:10      print Length of string to print
    ld   DE, string142  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo128:                 ;           sdo 128 ( stop index -- stop index ) 
    
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
    jp   nz, else115    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size143    ; 3:10      print Length of string to print
    ld   DE, string143  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave128      ; 3:10      sleave 128 
else115  EQU $          ;           = endif
endif115: 
    
                        ;           push_addsloop(-1) 128
    ld    A, L          ; 1:4       -1 +sloop 128
    xor   E             ; 1:4       -1 +sloop 128 lo index - stop
    ld    A, H          ; 1:4       -1 +sloop 128
    dec  HL             ; 1:6       -1 +sloop 128 index--
    jp   nz, sdo128     ; 3:10      -1 +sloop 128
    xor   D             ; 1:4       -1 +sloop 128 hi index - stop
    jp   nz, sdo128     ; 3:10      -1 +sloop 128
sleave128:              ;           -1 +sloop 128
    pop  HL             ; 1:10      unsloop 128 index out
    pop  DE             ; 1:10      unsloop 128 stop  out
 
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
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size144    ; 3:10      print Length of string to print
    ld   DE, string144  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx129), HL    ; 3:16      do 129 index
    dec  DE             ; 1:6       do 129 stop-1
    ld    A, E          ; 1:4       do 129 
    ld  (stp_lo129), A  ; 3:13      do 129 lo stop
    ld    A, D          ; 1:4       do 129 
    ld  (stp_hi129), A  ; 3:13      do 129 hi stop
    pop  HL             ; 1:10      do 129
    pop  DE             ; 1:10      do 129 ( -- ) R: ( -- )
do129:                  ;           do 129 
    push DE             ; 1:11      index i 129
    ex   DE, HL         ; 1:4       index i 129
    ld   HL, (idx129)   ; 3:16      index i 129 idx always points to a 16-bit index 
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
    jp   nz, else116    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size145    ; 3:10      print Length of string to print
    ld   DE, string145  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave129       ;           leave 129 
else116  EQU $          ;           = endif
endif116: 
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ld    B, H          ; 1:4       +loop 129
    ld    C, L          ; 1:4       +loop 129 BC = step
idx129 EQU $+1          ;           +loop 129
    ld   HL, 0x0000     ; 3:10      +loop 129
    add  HL, BC         ; 1:11      +loop 129 HL = index+step
    ld  (idx129), HL    ; 3:16      +loop 129 save index
stp_lo129 EQU $+1       ;           +loop 129
    ld    A, 0x00       ; 2:7       +loop 129 lo stop
    sub   L             ; 1:4       +loop 129
    ld    L, A          ; 1:4       +loop 129
stp_hi129 EQU $+1       ;           +loop 129
    ld    A, 0x00       ; 2:7       +loop 129 hi stop
    sbc   A, H          ; 1:4       +loop 129
    ld    H, A          ; 1:4       +loop 129 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 129 HL = stop-index
    xor   H             ; 1:4       +loop 129
    ex   DE, HL         ; 1:4       +loop 129
    pop  DE             ; 1:10      +loop 129
    jp    p, do129      ; 3:10      +loop 129
leave129:               ;           +loop 129
exit129:                ;           +loop 129 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size146    ; 3:10      print Length of string to print
    ld   DE, string146  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx130), HL    ; 3:16      do 130 index
    dec  DE             ; 1:6       do 130 stop-1
    ld    A, E          ; 1:4       do 130 
    ld  (stp_lo130), A  ; 3:13      do 130 lo stop
    ld    A, D          ; 1:4       do 130 
    ld  (stp_hi130), A  ; 3:13      do 130 hi stop
    pop  HL             ; 1:10      do 130
    pop  DE             ; 1:10      do 130 ( -- ) R: ( -- )
do130:                  ;           do 130 
    push DE             ; 1:11      index i 130
    ex   DE, HL         ; 1:4       index i 130
    ld   HL, (idx130)   ; 3:16      index i 130 idx always points to a 16-bit index 
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
    jp   nz, else117    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size147    ; 3:10      print Length of string to print
    ld   DE, string147  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave130       ;           leave 130 
else117  EQU $          ;           = endif
endif117: 
    
                        ;           push_addloop(1) 130
idx130 EQU $+1          ;           loop 130
    ld   BC, 0x0000     ; 3:10      loop 130 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 130
stp_lo130 EQU $+1       ;           loop 130
    xor  0x00           ; 2:7       loop 130 lo index - stop - 1
    ld    A, B          ; 1:4       loop 130
    inc  BC             ; 1:6       loop 130 index++
    ld  (idx130),BC     ; 4:20      loop 130 save index
    jp   nz, do130      ; 3:10      loop 130    
stp_hi130 EQU $+1       ;           loop 130
    xor  0x00           ; 2:7       loop 130 hi index - stop - 1
    jp   nz, do130      ; 3:10      loop 130
leave130:               ;           loop 130
exit130:                ;           loop 130 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size148    ; 3:10      print Length of string to print
    ld   DE, string148  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo131:                 ;           sdo 131 ( stop index -- stop index ) 
    
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
    jp   nz, else118    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size149    ; 3:10      print Length of string to print
    ld   DE, string149  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave131      ; 3:10      sleave 131 
else118  EQU $          ;           = endif
endif118: 
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    pop  BC             ; 1:10      +sloop 131 BC = stop
    ex   DE, HL         ; 1:4       +sloop 131
    or    A             ; 1:4       +sloop 131
    sbc  HL, BC         ; 2:15      +sloop 131 HL = index-stop
    ld    A, H          ; 1:4       +sloop 131
    add  HL, DE         ; 1:11      +sloop 131 HL = index-stop+step
    xor   H             ; 1:4       +sloop 131 sign flag!
    add  HL, BC         ; 1:11      +sloop 131 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 131
    ld    E, C          ; 1:4       +sloop 131
    jp    p, sdo131     ; 3:10      +sloop 131
sleave131:              ;           +sloop 131
    pop  HL             ; 1:10      unsloop 131 index out
    pop  DE             ; 1:10      unsloop 131 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size150    ; 3:10      print Length of string to print
    ld   DE, string150  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo132:                 ;           sdo 132 ( stop index -- stop index ) 
    
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
    jp   nz, else119    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size151    ; 3:10      print Length of string to print
    ld   DE, string151  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave132      ; 3:10      sleave 132 
else119  EQU $          ;           = endif
endif119: 
    
                        ;           push_addsloop(1) 132
    inc  HL             ; 1:6       sloop 132 index++
    ld    A, E          ; 1:4       sloop 132
    xor   L             ; 1:4       sloop 132 lo index - stop
    jp   nz, sdo132     ; 3:10      sloop 132
    ld    A, D          ; 1:4       sloop 132
    xor   H             ; 1:4       sloop 132 hi index - stop
    jp   nz, sdo132     ; 3:10      sloop 132
sleave132:              ;           sloop 132
    pop  HL             ; 1:10      unsloop 132 index out
    pop  DE             ; 1:10      unsloop 132 stop  out
 
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

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size152    ; 3:10      print Length of string to print
    ld   DE, string152  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx133), HL    ; 3:16      do 133 index
    dec  DE             ; 1:6       do 133 stop-1
    ld    A, E          ; 1:4       do 133 
    ld  (stp_lo133), A  ; 3:13      do 133 lo stop
    ld    A, D          ; 1:4       do 133 
    ld  (stp_hi133), A  ; 3:13      do 133 hi stop
    pop  HL             ; 1:10      do 133
    pop  DE             ; 1:10      do 133 ( -- ) R: ( -- )
do133:                  ;           do 133 
    push DE             ; 1:11      index i 133
    ex   DE, HL         ; 1:4       index i 133
    ld   HL, (idx133)   ; 3:16      index i 133 idx always points to a 16-bit index 
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
    push DE             ; 1:11      print
    ld   BC, size153    ; 3:10      print Length of string to print
    ld   DE, string153  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave133       ;           leave 133 
else120  EQU $          ;           = endif
endif120: 
    
    push DE             ; 1:11      push(-2)
    ex   DE, HL         ; 1:4       push(-2)
    ld   HL, -2         ; 3:10      push(-2) 
    ld    B, H          ; 1:4       +loop 133
    ld    C, L          ; 1:4       +loop 133 BC = step
idx133 EQU $+1          ;           +loop 133
    ld   HL, 0x0000     ; 3:10      +loop 133
    add  HL, BC         ; 1:11      +loop 133 HL = index+step
    ld  (idx133), HL    ; 3:16      +loop 133 save index
stp_lo133 EQU $+1       ;           +loop 133
    ld    A, 0x00       ; 2:7       +loop 133 lo stop
    sub   L             ; 1:4       +loop 133
    ld    L, A          ; 1:4       +loop 133
stp_hi133 EQU $+1       ;           +loop 133
    ld    A, 0x00       ; 2:7       +loop 133 hi stop
    sbc   A, H          ; 1:4       +loop 133
    ld    H, A          ; 1:4       +loop 133 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 133 HL = stop-index
    xor   H             ; 1:4       +loop 133
    ex   DE, HL         ; 1:4       +loop 133
    pop  DE             ; 1:10      +loop 133
    jp    p, do133      ; 3:10      +loop 133
leave133:               ;           +loop 133
exit133:                ;           +loop 133 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size154    ; 3:10      print Length of string to print
    ld   DE, string154  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx134), HL    ; 3:16      do 134 index
    dec  DE             ; 1:6       do 134 stop-1
    ld    A, E          ; 1:4       do 134 
    ld  (stp_lo134), A  ; 3:13      do 134 lo stop
    ld    A, D          ; 1:4       do 134 
    ld  (stp_hi134), A  ; 3:13      do 134 hi stop
    pop  HL             ; 1:10      do 134
    pop  DE             ; 1:10      do 134 ( -- ) R: ( -- )
do134:                  ;           do 134 
    push DE             ; 1:11      index i 134
    ex   DE, HL         ; 1:4       index i 134
    ld   HL, (idx134)   ; 3:16      index i 134 idx always points to a 16-bit index 
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
    push DE             ; 1:11      print
    ld   BC, size155    ; 3:10      print Length of string to print
    ld   DE, string155  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave134       ;           leave 134 
else121  EQU $          ;           = endif
endif121: 
    
    push HL             ; 1:11      -2 +loop 134
idx134 EQU $+1          ;           -2 +loop 134
    ld   HL, 0x0000     ; 3:10      -2 +loop 134
    ld   BC, -2         ; 3:10      -2 +loop 134 BC = step
    add  HL, BC         ; 1:11      -2 +loop 134 HL = index+step
    ld  (idx134), HL    ; 3:16      -2 +loop 134 save index
stp_lo134 EQU $+1       ;           -2 +loop 134
    ld    A, 0x00       ; 2:7       -2 +loop 134 lo stop
    sub   L             ; 1:4       -2 +loop 134
    ld    L, A          ; 1:4       -2 +loop 134
stp_hi134 EQU $+1       ;           -2 +loop 134
    ld    A, 0x00       ; 2:7       -2 +loop 134 hi stop
    sbc   A, H          ; 1:4       -2 +loop 134
    ld    H, A          ; 1:4       -2 +loop 134 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -2 +loop 134 HL = stop-index
    xor   H             ; 1:4       -2 +loop 134
    pop  HL             ; 1:10      -2 +loop 134
    jp    p, do134      ; 3:10      -2 +loop 134 negative step
leave134:               ;           -2 +loop 134
exit134:                ;           -2 +loop 134 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size156    ; 3:10      print Length of string to print
    ld   DE, string156  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo135:                 ;           sdo 135 ( stop index -- stop index ) 
    
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
    jp   nz, else122    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size157    ; 3:10      print Length of string to print
    ld   DE, string157  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave135      ; 3:10      sleave 135 
else122  EQU $          ;           = endif
endif122: 
    
    push DE             ; 1:11      push(-2)
    ex   DE, HL         ; 1:4       push(-2)
    ld   HL, -2         ; 3:10      push(-2) 
    pop  BC             ; 1:10      +sloop 135 BC = stop
    ex   DE, HL         ; 1:4       +sloop 135
    or    A             ; 1:4       +sloop 135
    sbc  HL, BC         ; 2:15      +sloop 135 HL = index-stop
    ld    A, H          ; 1:4       +sloop 135
    add  HL, DE         ; 1:11      +sloop 135 HL = index-stop+step
    xor   H             ; 1:4       +sloop 135 sign flag!
    add  HL, BC         ; 1:11      +sloop 135 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 135
    ld    E, C          ; 1:4       +sloop 135
    jp    p, sdo135     ; 3:10      +sloop 135
sleave135:              ;           +sloop 135
    pop  HL             ; 1:10      unsloop 135 index out
    pop  DE             ; 1:10      unsloop 135 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size158    ; 3:10      print Length of string to print
    ld   DE, string158  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo136:                 ;           sdo 136 ( stop index -- stop index ) 
    
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
    jp   nz, else123    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size159    ; 3:10      print Length of string to print
    ld   DE, string159  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave136      ; 3:10      sleave 136 
else123  EQU $          ;           = endif
endif123: 
    
    ld   BC, -2         ; 3:10      push_addsloop(-2) 136 BC = step
    or    A             ; 1:4       push_addsloop(-2) 136
    sbc  HL, DE         ; 2:15      push_addsloop(-2) 136 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(-2) 136
    add  HL, BC         ; 1:11      push_addsloop(-2) 136 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(-2) 136 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(-2) 136 HL = index+step, sign flag unaffected
    jp    p, sdo136     ; 3:10      push_addsloop(-2) 136
sleave136:              ;           push_addsloop(-2) 136
    pop  HL             ; 1:10      unsloop 136 index out
    pop  DE             ; 1:10      unsloop 136 stop  out
 
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
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size160    ; 3:10      print Length of string to print
    ld   DE, string160  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx137), HL    ; 3:16      do 137 index
    dec  DE             ; 1:6       do 137 stop-1
    ld    A, E          ; 1:4       do 137 
    ld  (stp_lo137), A  ; 3:13      do 137 lo stop
    ld    A, D          ; 1:4       do 137 
    ld  (stp_hi137), A  ; 3:13      do 137 hi stop
    pop  HL             ; 1:10      do 137
    pop  DE             ; 1:10      do 137 ( -- ) R: ( -- )
do137:                  ;           do 137 
    push DE             ; 1:11      index i 137
    ex   DE, HL         ; 1:4       index i 137
    ld   HL, (idx137)   ; 3:16      index i 137 idx always points to a 16-bit index 
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
    jp   nz, else124    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size161    ; 3:10      print Length of string to print
    ld   DE, string161  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave137       ;           leave 137 
else124  EQU $          ;           = endif
endif124: 
    
    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    ld    B, H          ; 1:4       +loop 137
    ld    C, L          ; 1:4       +loop 137 BC = step
idx137 EQU $+1          ;           +loop 137
    ld   HL, 0x0000     ; 3:10      +loop 137
    add  HL, BC         ; 1:11      +loop 137 HL = index+step
    ld  (idx137), HL    ; 3:16      +loop 137 save index
stp_lo137 EQU $+1       ;           +loop 137
    ld    A, 0x00       ; 2:7       +loop 137 lo stop
    sub   L             ; 1:4       +loop 137
    ld    L, A          ; 1:4       +loop 137
stp_hi137 EQU $+1       ;           +loop 137
    ld    A, 0x00       ; 2:7       +loop 137 hi stop
    sbc   A, H          ; 1:4       +loop 137
    ld    H, A          ; 1:4       +loop 137 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 137 HL = stop-index
    xor   H             ; 1:4       +loop 137
    ex   DE, HL         ; 1:4       +loop 137
    pop  DE             ; 1:10      +loop 137
    jp    p, do137      ; 3:10      +loop 137
leave137:               ;           +loop 137
exit137:                ;           +loop 137 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size162    ; 3:10      print Length of string to print
    ld   DE, string162  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx138), HL    ; 3:16      do 138 index
    dec  DE             ; 1:6       do 138 stop-1
    ld    A, E          ; 1:4       do 138 
    ld  (stp_lo138), A  ; 3:13      do 138 lo stop
    ld    A, D          ; 1:4       do 138 
    ld  (stp_hi138), A  ; 3:13      do 138 hi stop
    pop  HL             ; 1:10      do 138
    pop  DE             ; 1:10      do 138 ( -- ) R: ( -- )
do138:                  ;           do 138 
    push DE             ; 1:11      index i 138
    ex   DE, HL         ; 1:4       index i 138
    ld   HL, (idx138)   ; 3:16      index i 138 idx always points to a 16-bit index 
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
    jp   nz, else125    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size163    ; 3:10      print Length of string to print
    ld   DE, string163  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave138       ;           leave 138 
else125  EQU $          ;           = endif
endif125: 
    
                        ;           push_addloop(2) 138
idx138 EQU $+1          ;           2 +loop 138
    ld   BC, 0x0000     ; 3:10      2 +loop 138 idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +loop 138 index++
    ld    A, C          ; 1:4       2 +loop 138
stp_lo138 EQU $+1       ;           2 +loop 138
    sub  0x00           ; 2:7       2 +loop 138 lo index - stop
    rra                 ; 1:4       2 +loop 138
    add   A, A          ; 1:4       2 +loop 138 and 0xFE with save carry
    ld    A, B          ; 1:4       2 +loop 138
    inc  BC             ; 1:6       2 +loop 138 index++
    ld  (idx138),BC     ; 4:20      2 +loop 138 save index
    jp   nz, do138      ; 3:10      2 +loop 138
stp_hi138 EQU $+1       ;           2 +loop 138
    sbc   A, 0x00       ; 2:7       2 +loop 138 hi index - stop
    jp   nz, do138      ; 3:10      2 +loop 138
leave138:               ;           2 +loop 138
exit138:                ;           2 +loop 138 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size164    ; 3:10      print Length of string to print
    ld   DE, string164  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo139:                 ;           sdo 139 ( stop index -- stop index ) 
    
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
    jp   nz, else126    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size165    ; 3:10      print Length of string to print
    ld   DE, string165  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave139      ; 3:10      sleave 139 
else126  EQU $          ;           = endif
endif126: 
    
    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    pop  BC             ; 1:10      +sloop 139 BC = stop
    ex   DE, HL         ; 1:4       +sloop 139
    or    A             ; 1:4       +sloop 139
    sbc  HL, BC         ; 2:15      +sloop 139 HL = index-stop
    ld    A, H          ; 1:4       +sloop 139
    add  HL, DE         ; 1:11      +sloop 139 HL = index-stop+step
    xor   H             ; 1:4       +sloop 139 sign flag!
    add  HL, BC         ; 1:11      +sloop 139 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 139
    ld    E, C          ; 1:4       +sloop 139
    jp    p, sdo139     ; 3:10      +sloop 139
sleave139:              ;           +sloop 139
    pop  HL             ; 1:10      unsloop 139 index out
    pop  DE             ; 1:10      unsloop 139 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size166    ; 3:10      print Length of string to print
    ld   DE, string166  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo140:                 ;           sdo 140 ( stop index -- stop index ) 
    
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
    jp   nz, else127    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size167    ; 3:10      print Length of string to print
    ld   DE, string167  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave140      ; 3:10      sleave 140 
else127  EQU $          ;           = endif
endif127: 
    
                        ;           push_addsloop(2) 140
    inc  HL             ; 1:6       2 +sloop 140
    inc  HL             ; 1:6       2 +sloop 140 HL = index+2
    ld    A, L          ; 1:4       2 +sloop 140
    sub   E             ; 1:4       2 +sloop 140
    rra                 ; 1:4       2 +sloop 140
    add   A, A          ; 1:4       2 +sloop 140
    jp   nz, sdo140     ; 3:10      2 +sloop 140
    ld    A, H          ; 1:4       2 +sloop 140
    sbc   A, D          ; 1:4       2 +sloop 140
    jp   nz, sdo140     ; 3:10      2 +sloop 140
sleave140:              ;           2 +sloop 140
    pop  HL             ; 1:10      unsloop 140 index out
    pop  DE             ; 1:10      unsloop 140 stop  out
 
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

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size168    ; 3:10      print Length of string to print
    ld   DE, string168  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx141), HL    ; 3:16      do 141 index
    dec  DE             ; 1:6       do 141 stop-1
    ld    A, E          ; 1:4       do 141 
    ld  (stp_lo141), A  ; 3:13      do 141 lo stop
    ld    A, D          ; 1:4       do 141 
    ld  (stp_hi141), A  ; 3:13      do 141 hi stop
    pop  HL             ; 1:10      do 141
    pop  DE             ; 1:10      do 141 ( -- ) R: ( -- )
do141:                  ;           do 141 
    push DE             ; 1:11      index i 141
    ex   DE, HL         ; 1:4       index i 141
    ld   HL, (idx141)   ; 3:16      index i 141 idx always points to a 16-bit index 
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
    jp   nz, else128    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size169    ; 3:10      print Length of string to print
    ld   DE, string169  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave141       ;           leave 141 
else128  EQU $          ;           = endif
endif128: 
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    ld    B, H          ; 1:4       +loop 141
    ld    C, L          ; 1:4       +loop 141 BC = step
idx141 EQU $+1          ;           +loop 141
    ld   HL, 0x0000     ; 3:10      +loop 141
    add  HL, BC         ; 1:11      +loop 141 HL = index+step
    ld  (idx141), HL    ; 3:16      +loop 141 save index
stp_lo141 EQU $+1       ;           +loop 141
    ld    A, 0x00       ; 2:7       +loop 141 lo stop
    sub   L             ; 1:4       +loop 141
    ld    L, A          ; 1:4       +loop 141
stp_hi141 EQU $+1       ;           +loop 141
    ld    A, 0x00       ; 2:7       +loop 141 hi stop
    sbc   A, H          ; 1:4       +loop 141
    ld    H, A          ; 1:4       +loop 141 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 141 HL = stop-index
    xor   H             ; 1:4       +loop 141
    ex   DE, HL         ; 1:4       +loop 141
    pop  DE             ; 1:10      +loop 141
    jp    p, do141      ; 3:10      +loop 141
leave141:               ;           +loop 141
exit141:                ;           +loop 141 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size170    ; 3:10      print Length of string to print
    ld   DE, string170  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx142), HL    ; 3:16      do 142 index
    dec  DE             ; 1:6       do 142 stop-1
    ld    A, E          ; 1:4       do 142 
    ld  (stp_lo142), A  ; 3:13      do 142 lo stop
    ld    A, D          ; 1:4       do 142 
    ld  (stp_hi142), A  ; 3:13      do 142 hi stop
    pop  HL             ; 1:10      do 142
    pop  DE             ; 1:10      do 142 ( -- ) R: ( -- )
do142:                  ;           do 142 
    push DE             ; 1:11      index i 142
    ex   DE, HL         ; 1:4       index i 142
    ld   HL, (idx142)   ; 3:16      index i 142 idx always points to a 16-bit index 
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
    jp   nz, else129    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size171    ; 3:10      print Length of string to print
    ld   DE, string171  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave142       ;           leave 142 
else129  EQU $          ;           = endif
endif129: 
    
    push HL             ; 1:11      -3 +loop 142
idx142 EQU $+1          ;           -3 +loop 142
    ld   HL, 0x0000     ; 3:10      -3 +loop 142
    ld   BC, -3         ; 3:10      -3 +loop 142 BC = step
    add  HL, BC         ; 1:11      -3 +loop 142 HL = index+step
    ld  (idx142), HL    ; 3:16      -3 +loop 142 save index
stp_lo142 EQU $+1       ;           -3 +loop 142
    ld    A, 0x00       ; 2:7       -3 +loop 142 lo stop
    sub   L             ; 1:4       -3 +loop 142
    ld    L, A          ; 1:4       -3 +loop 142
stp_hi142 EQU $+1       ;           -3 +loop 142
    ld    A, 0x00       ; 2:7       -3 +loop 142 hi stop
    sbc   A, H          ; 1:4       -3 +loop 142
    ld    H, A          ; 1:4       -3 +loop 142 HL = stop-(index+step)
    add  HL, BC         ; 1:11      -3 +loop 142 HL = stop-index
    xor   H             ; 1:4       -3 +loop 142
    pop  HL             ; 1:10      -3 +loop 142
    jp    p, do142      ; 3:10      -3 +loop 142 negative step
leave142:               ;           -3 +loop 142
exit142:                ;           -3 +loop 142 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size172    ; 3:10      print Length of string to print
    ld   DE, string172  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo143:                 ;           sdo 143 ( stop index -- stop index ) 
    
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
    jp   nz, else130    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size173    ; 3:10      print Length of string to print
    ld   DE, string173  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave143      ; 3:10      sleave 143 
else130  EQU $          ;           = endif
endif130: 
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    pop  BC             ; 1:10      +sloop 143 BC = stop
    ex   DE, HL         ; 1:4       +sloop 143
    or    A             ; 1:4       +sloop 143
    sbc  HL, BC         ; 2:15      +sloop 143 HL = index-stop
    ld    A, H          ; 1:4       +sloop 143
    add  HL, DE         ; 1:11      +sloop 143 HL = index-stop+step
    xor   H             ; 1:4       +sloop 143 sign flag!
    add  HL, BC         ; 1:11      +sloop 143 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 143
    ld    E, C          ; 1:4       +sloop 143
    jp    p, sdo143     ; 3:10      +sloop 143
sleave143:              ;           +sloop 143
    pop  HL             ; 1:10      unsloop 143 index out
    pop  DE             ; 1:10      unsloop 143 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size174    ; 3:10      print Length of string to print
    ld   DE, string174  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo144:                 ;           sdo 144 ( stop index -- stop index ) 
    
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
    jp   nz, else131    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size175    ; 3:10      print Length of string to print
    ld   DE, string175  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave144      ; 3:10      sleave 144 
else131  EQU $          ;           = endif
endif131: 
    
    ld   BC, -3         ; 3:10      push_addsloop(-3) 144 BC = step
    or    A             ; 1:4       push_addsloop(-3) 144
    sbc  HL, DE         ; 2:15      push_addsloop(-3) 144 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(-3) 144
    add  HL, BC         ; 1:11      push_addsloop(-3) 144 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(-3) 144 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(-3) 144 HL = index+step, sign flag unaffected
    jp    p, sdo144     ; 3:10      push_addsloop(-3) 144
sleave144:              ;           push_addsloop(-3) 144
    pop  HL             ; 1:10      unsloop 144 index out
    pop  DE             ; 1:10      unsloop 144 stop  out
 
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
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size176    ; 3:10      print Length of string to print
    ld   DE, string176  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx145), HL    ; 3:16      do 145 index
    dec  DE             ; 1:6       do 145 stop-1
    ld    A, E          ; 1:4       do 145 
    ld  (stp_lo145), A  ; 3:13      do 145 lo stop
    ld    A, D          ; 1:4       do 145 
    ld  (stp_hi145), A  ; 3:13      do 145 hi stop
    pop  HL             ; 1:10      do 145
    pop  DE             ; 1:10      do 145 ( -- ) R: ( -- )
do145:                  ;           do 145 
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
    jp   nz, else132    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size177    ; 3:10      print Length of string to print
    ld   DE, string177  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave145       ;           leave 145 
else132  EQU $          ;           = endif
endif132: 
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    ld    B, H          ; 1:4       +loop 145
    ld    C, L          ; 1:4       +loop 145 BC = step
idx145 EQU $+1          ;           +loop 145
    ld   HL, 0x0000     ; 3:10      +loop 145
    add  HL, BC         ; 1:11      +loop 145 HL = index+step
    ld  (idx145), HL    ; 3:16      +loop 145 save index
stp_lo145 EQU $+1       ;           +loop 145
    ld    A, 0x00       ; 2:7       +loop 145 lo stop
    sub   L             ; 1:4       +loop 145
    ld    L, A          ; 1:4       +loop 145
stp_hi145 EQU $+1       ;           +loop 145
    ld    A, 0x00       ; 2:7       +loop 145 hi stop
    sbc   A, H          ; 1:4       +loop 145
    ld    H, A          ; 1:4       +loop 145 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 145 HL = stop-index
    xor   H             ; 1:4       +loop 145
    ex   DE, HL         ; 1:4       +loop 145
    pop  DE             ; 1:10      +loop 145
    jp    p, do145      ; 3:10      +loop 145
leave145:               ;           +loop 145
exit145:                ;           +loop 145 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size178    ; 3:10      print Length of string to print
    ld   DE, string178  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx146), HL    ; 3:16      do 146 index
    dec  DE             ; 1:6       do 146 stop-1
    ld    A, E          ; 1:4       do 146 
    ld  (stp_lo146), A  ; 3:13      do 146 lo stop
    ld    A, D          ; 1:4       do 146 
    ld  (stp_hi146), A  ; 3:13      do 146 hi stop
    pop  HL             ; 1:10      do 146
    pop  DE             ; 1:10      do 146 ( -- ) R: ( -- )
do146:                  ;           do 146 
    push DE             ; 1:11      index i 146
    ex   DE, HL         ; 1:4       index i 146
    ld   HL, (idx146)   ; 3:16      index i 146 idx always points to a 16-bit index 
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
    jp   nz, else133    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size179    ; 3:10      print Length of string to print
    ld   DE, string179  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave146       ;           leave 146 
else133  EQU $          ;           = endif
endif133: 
    
    push HL             ; 1:11      3 +loop 146
idx146 EQU $+1          ;           3 +loop 146
    ld   HL, 0x0000     ; 3:10      3 +loop 146
    ld   BC, 3          ; 3:10      3 +loop 146 BC = step
    add  HL, BC         ; 1:11      3 +loop 146 HL = index+step
    ld  (idx146), HL    ; 3:16      3 +loop 146 save index
stp_lo146 EQU $+1       ;           3 +loop 146
    ld    A, 0x00       ; 2:7       3 +loop 146 lo stop
    sub   L             ; 1:4       3 +loop 146
    ld    L, A          ; 1:4       3 +loop 146
stp_hi146 EQU $+1       ;           3 +loop 146
    ld    A, 0x00       ; 2:7       3 +loop 146 hi stop
    sbc   A, H          ; 1:4       3 +loop 146
    ld    H, A          ; 1:4       3 +loop 146 HL = stop-(index+step)
    add  HL, BC         ; 1:11      3 +loop 146 HL = stop-index
    xor   H             ; 1:4       3 +loop 146
    pop  HL             ; 1:10      3 +loop 146
    jp    p, do146      ; 3:10      3 +loop 146 negative step
leave146:               ;           3 +loop 146
exit146:                ;           3 +loop 146 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size180    ; 3:10      print Length of string to print
    ld   DE, string180  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo147:                 ;           sdo 147 ( stop index -- stop index ) 
    
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
    jp   nz, else134    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size181    ; 3:10      print Length of string to print
    ld   DE, string181  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave147      ; 3:10      sleave 147 
else134  EQU $          ;           = endif
endif134: 
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    pop  BC             ; 1:10      +sloop 147 BC = stop
    ex   DE, HL         ; 1:4       +sloop 147
    or    A             ; 1:4       +sloop 147
    sbc  HL, BC         ; 2:15      +sloop 147 HL = index-stop
    ld    A, H          ; 1:4       +sloop 147
    add  HL, DE         ; 1:11      +sloop 147 HL = index-stop+step
    xor   H             ; 1:4       +sloop 147 sign flag!
    add  HL, BC         ; 1:11      +sloop 147 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 147
    ld    E, C          ; 1:4       +sloop 147
    jp    p, sdo147     ; 3:10      +sloop 147
sleave147:              ;           +sloop 147
    pop  HL             ; 1:10      unsloop 147 index out
    pop  DE             ; 1:10      unsloop 147 stop  out
 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 
    
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size182    ; 3:10      print Length of string to print
    ld   DE, string182  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo148:                 ;           sdo 148 ( stop index -- stop index ) 
    
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
    jp   nz, else135    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size183    ; 3:10      print Length of string to print
    ld   DE, string183  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave148      ; 3:10      sleave 148 
else135  EQU $          ;           = endif
endif135: 
    
    ld   BC, 3          ; 3:10      push_addsloop(3) 148 BC = step
    or    A             ; 1:4       push_addsloop(3) 148
    sbc  HL, DE         ; 2:15      push_addsloop(3) 148 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(3) 148
    add  HL, BC         ; 1:11      push_addsloop(3) 148 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(3) 148 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(3) 148 HL = index+step, sign flag unaffected
    jp    p, sdo148     ; 3:10      push_addsloop(3) 148
sleave148:              ;           push_addsloop(3) 148
    pop  HL             ; 1:10      unsloop 148 index out
    pop  DE             ; 1:10      unsloop 148 stop  out
 
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

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size184    ; 3:10      print Length of string to print
    ld   DE, string184  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx149), HL    ; 3:16      do 149 index
    dec  DE             ; 1:6       do 149 stop-1
    ld    A, E          ; 1:4       do 149 
    ld  (stp_lo149), A  ; 3:13      do 149 lo stop
    ld    A, D          ; 1:4       do 149 
    ld  (stp_hi149), A  ; 3:13      do 149 hi stop
    pop  HL             ; 1:10      do 149
    pop  DE             ; 1:10      do 149 ( -- ) R: ( -- )
do149:                  ;           do 149 
    push DE             ; 1:11      index i 149
    ex   DE, HL         ; 1:4       index i 149
    ld   HL, (idx149)   ; 3:16      index i 149 idx always points to a 16-bit index 
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
    jp   nz, else136    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size185    ; 3:10      print Length of string to print
    ld   DE, string185  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave149       ;           leave 149 
else136  EQU $          ;           = endif
endif136: 
    
idx149 EQU $+1          ;           loop 149
    ld   BC, 0x0000     ; 3:10      loop 149 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 149
stp_lo149 EQU $+1       ;           loop 149
    xor  0x00           ; 2:7       loop 149 lo index - stop - 1
    ld    A, B          ; 1:4       loop 149
    inc  BC             ; 1:6       loop 149 index++
    ld  (idx149),BC     ; 4:20      loop 149 save index
    jp   nz, do149      ; 3:10      loop 149    
stp_hi149 EQU $+1       ;           loop 149
    xor  0x00           ; 2:7       loop 149 hi index - stop - 1
    jp   nz, do149      ; 3:10      loop 149
leave149:               ;           loop 149
exit149:                ;           loop 149 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size186    ; 3:10      print Length of string to print
    ld   DE, string186  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo150:                 ;           sdo 150 ( stop index -- stop index ) 
    
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
    jp   nz, else137    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size187    ; 3:10      print Length of string to print
    ld   DE, string187  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave150      ; 3:10      sleave 150 
else137  EQU $          ;           = endif
endif137: 
    
    inc  HL             ; 1:6       sloop 150 index++
    ld    A, E          ; 1:4       sloop 150
    xor   L             ; 1:4       sloop 150 lo index - stop
    jp   nz, sdo150     ; 3:10      sloop 150
    ld    A, D          ; 1:4       sloop 150
    xor   H             ; 1:4       sloop 150 hi index - stop
    jp   nz, sdo150     ; 3:10      sloop 150
sleave150:              ;           sloop 150
    pop  HL             ; 1:10      unsloop 150 index out
    pop  DE             ; 1:10      unsloop 150 stop  out
 
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

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size188    ; 3:10      print Length of string to print
    ld   DE, string188  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx151), HL    ; 3:16      ?do 151 index
    or    A             ; 1:4       ?do 151
    sbc  HL, DE         ; 2:15      ?do 151
    dec  DE             ; 1:6       ?do 151 stop-1
    ld    A, E          ; 1:4       ?do 151 
    ld  (stp_lo151), A  ; 3:13      ?do 151 lo stop
    ld    A, D          ; 1:4       ?do 151 
    ld  (stp_hi151), A  ; 3:13      ?do 151 hi stop
    pop  HL             ; 1:10      ?do 151
    pop  DE             ; 1:10      ?do 151
    jp    z, exit151    ; 3:10      ?do 151 ( -- ) R: ( -- )
do151:                  ;           ?do 151 
    push DE             ; 1:11      index i 151
    ex   DE, HL         ; 1:4       index i 151
    ld   HL, (idx151)   ; 3:16      index i 151 idx always points to a 16-bit index 
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
    jp   nz, else138    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size189    ; 3:10      print Length of string to print
    ld   DE, string189  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave151       ;           leave 151 
else138  EQU $          ;           = endif
endif138: 
    
idx151 EQU $+1          ;           loop 151
    ld   BC, 0x0000     ; 3:10      loop 151 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 151
stp_lo151 EQU $+1       ;           loop 151
    xor  0x00           ; 2:7       loop 151 lo index - stop - 1
    ld    A, B          ; 1:4       loop 151
    inc  BC             ; 1:6       loop 151 index++
    ld  (idx151),BC     ; 4:20      loop 151 save index
    jp   nz, do151      ; 3:10      loop 151    
stp_hi151 EQU $+1       ;           loop 151
    xor  0x00           ; 2:7       loop 151 hi index - stop - 1
    jp   nz, do151      ; 3:10      loop 151
leave151:               ;           loop 151
exit151:                ;           loop 151 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call PRINT_S16      ; 3:17      . 
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1 
    push DE             ; 1:11      print
    ld   BC, size190    ; 3:10      print Length of string to print
    ld   DE, string190  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

    push HL             ; 1:10      ?sdo 152
    or    A             ; 1:4       ?sdo 152
    sbc  HL, DE         ; 2:15      ?sdo 152
    pop  HL             ; 1:10      ?sdo 152
    jp    z, sleave152  ; 3:10      ?sdo 152   
sdo152:                 ;           sdo 152 ( stop index -- stop index ) 
    
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
    jp   nz, else139    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size191    ; 3:10      print Length of string to print
    ld   DE, string191  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave152      ; 3:10      sleave 152 
else139  EQU $          ;           = endif
endif139: 
    
    inc  HL             ; 1:6       sloop 152 index++
    ld    A, E          ; 1:4       sloop 152
    xor   L             ; 1:4       sloop 152 lo index - stop
    jp   nz, sdo152     ; 3:10      sloop 152
    ld    A, D          ; 1:4       sloop 152
    xor   H             ; 1:4       sloop 152 hi index - stop
    jp   nz, sdo152     ; 3:10      sloop 152
sleave152:              ;           sloop 152
    pop  HL             ; 1:10      unsloop 152 index out
    pop  DE             ; 1:10      unsloop 152 stop  out
 
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
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
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
    push DE             ; 1:11      print
    ld   BC, size192    ; 3:10      print Length of string to print
    ld   DE, string192  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld  (idx153), HL    ; 3:16      do 153 index
    dec  DE             ; 1:6       do 153 stop-1
    ld    A, E          ; 1:4       do 153 
    ld  (stp_lo153), A  ; 3:13      do 153 lo stop
    ld    A, D          ; 1:4       do 153 
    ld  (stp_hi153), A  ; 3:13      do 153 hi stop
    pop  HL             ; 1:10      do 153
    pop  DE             ; 1:10      do 153 ( -- ) R: ( -- )
do153:                  ;           do 153 
    push DE             ; 1:11      index i 153
    ex   DE, HL         ; 1:4       index i 153
    ld   HL, (idx153)   ; 3:16      index i 153 idx always points to a 16-bit index 
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
    jp   nz, else140    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size193    ; 3:10      print Length of string to print
    ld   DE, string193  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   leave153       ;           leave 153 
else140  EQU $          ;           = endif
endif140: 
        
    push DE             ; 1:11      _krok @ push(_krok) fetch 
    ex   DE, HL         ; 1:4       _krok @ push(_krok) fetch
    ld   HL,(_krok)     ; 3:16      _krok @ push(_krok) fetch
    
    ld    B, H          ; 1:4       +loop 153
    ld    C, L          ; 1:4       +loop 153 BC = step
idx153 EQU $+1          ;           +loop 153
    ld   HL, 0x0000     ; 3:10      +loop 153
    add  HL, BC         ; 1:11      +loop 153 HL = index+step
    ld  (idx153), HL    ; 3:16      +loop 153 save index
stp_lo153 EQU $+1       ;           +loop 153
    ld    A, 0x00       ; 2:7       +loop 153 lo stop
    sub   L             ; 1:4       +loop 153
    ld    L, A          ; 1:4       +loop 153
stp_hi153 EQU $+1       ;           +loop 153
    ld    A, 0x00       ; 2:7       +loop 153 hi stop
    sbc   A, H          ; 1:4       +loop 153
    ld    H, A          ; 1:4       +loop 153 HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop 153 HL = stop-index
    xor   H             ; 1:4       +loop 153
    ex   DE, HL         ; 1:4       +loop 153
    pop  DE             ; 1:10      +loop 153
    jp    p, do153      ; 3:10      +loop 153
leave153:               ;           +loop 153
exit153:                ;           +loop 153 
    
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
    
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 
    
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
    push DE             ; 1:11      print
    ld   BC, size194    ; 3:10      print Length of string to print
    ld   DE, string194  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

sdo154:                 ;           sdo 154 ( stop index -- stop index ) 
    
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
    jp   nz, else141    ; 3:10      0= if 
    push DE             ; 1:11      print
    ld   BC, size195    ; 3:10      print Length of string to print
    ld   DE, string195  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    jp   sleave154      ; 3:10      sleave 154 
else141  EQU $          ;           = endif
endif141: 
        
    push DE             ; 1:11      _krok @ push(_krok) fetch 
    ex   DE, HL         ; 1:4       _krok @ push(_krok) fetch
    ld   HL,(_krok)     ; 3:16      _krok @ push(_krok) fetch
    
    pop  BC             ; 1:10      +sloop 154 BC = stop
    ex   DE, HL         ; 1:4       +sloop 154
    or    A             ; 1:4       +sloop 154
    sbc  HL, BC         ; 2:15      +sloop 154 HL = index-stop
    ld    A, H          ; 1:4       +sloop 154
    add  HL, DE         ; 1:11      +sloop 154 HL = index-stop+step
    xor   H             ; 1:4       +sloop 154 sign flag!
    add  HL, BC         ; 1:11      +sloop 154 HL = index+step, sign flag unaffected
    ld    D, B          ; 1:4       +sloop 154
    ld    E, C          ; 1:4       +sloop 154
    jp    p, sdo154     ; 3:10      +sloop 154
sleave154:              ;           +sloop 154
    pop  HL             ; 1:10      unsloop 154 index out
    pop  DE             ; 1:10      unsloop 154 stop  out
 
    
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


VARIABLE_SECTION:

_stop: dw 0x0000
_krok: dw 0x0000
STRING_SECTION:
string195:
db ".."
size195 EQU $ - string195
string194:
db "s:"
size194 EQU $ - string194
string193:
db ".."
size193 EQU $ - string193
string192:
db "d:"
size192 EQU $ - string192
string191:
db ".."
size191 EQU $ - string191
string190:
db "?s    l:"
size190 EQU $ - string190
string189:
db ".."
size189 EQU $ - string189
string188:
db "?d    l:"
size188 EQU $ - string188
string187:
db ".."
size187 EQU $ - string187
string186:
db " s    l:"
size186 EQU $ - string186
string185:
db ".."
size185 EQU $ - string185
string184:
db " d    l:"
size184 EQU $ - string184
string183:
db ".."
size183 EQU $ - string183
string182:
db " s 3 +l:"
size182 EQU $ - string182
string181:
db ".."
size181 EQU $ - string181
string180:
db " s 3 +l:"
size180 EQU $ - string180
string179:
db ".."
size179 EQU $ - string179
string178:
db " d 3 +l:"
size178 EQU $ - string178
string177:
db ".."
size177 EQU $ - string177
string176:
db " d 3 +l:"
size176 EQU $ - string176
string175:
db ".."
size175 EQU $ - string175
string174:
db " s-3 +l:"
size174 EQU $ - string174
string173:
db ".."
size173 EQU $ - string173
string172:
db " s-3 +l:"
size172 EQU $ - string172
string171:
db ".."
size171 EQU $ - string171
string170:
db " d-3 +l:"
size170 EQU $ - string170
string169:
db ".."
size169 EQU $ - string169
string168:
db " d-3 +l:"
size168 EQU $ - string168
string167:
db ".."
size167 EQU $ - string167
string166:
db " s 2 +l:"
size166 EQU $ - string166
string165:
db ".."
size165 EQU $ - string165
string164:
db " s 2 +l:"
size164 EQU $ - string164
string163:
db ".."
size163 EQU $ - string163
string162:
db " d 2 +l:"
size162 EQU $ - string162
string161:
db ".."
size161 EQU $ - string161
string160:
db " d 2 +l:"
size160 EQU $ - string160
string159:
db ".."
size159 EQU $ - string159
string158:
db " s-2 +l:"
size158 EQU $ - string158
string157:
db ".."
size157 EQU $ - string157
string156:
db " s-2 +l:"
size156 EQU $ - string156
string155:
db ".."
size155 EQU $ - string155
string154:
db " d-2 +l:"
size154 EQU $ - string154
string153:
db ".."
size153 EQU $ - string153
string152:
db " d-2 +l:"
size152 EQU $ - string152
string151:
db ".."
size151 EQU $ - string151
string150:
db " s 1 +l:"
size150 EQU $ - string150
string149:
db ".."
size149 EQU $ - string149
string148:
db " s 1 +l:"
size148 EQU $ - string148
string147:
db ".."
size147 EQU $ - string147
string146:
db " d 1 +l:"
size146 EQU $ - string146
string145:
db ".."
size145 EQU $ - string145
string144:
db " d 1 +l:"
size144 EQU $ - string144
string143:
db ".."
size143 EQU $ - string143
string142:
db " s-1 +l:"
size142 EQU $ - string142
string141:
db ".."
size141 EQU $ - string141
string140:
db " s-1 +l:"
size140 EQU $ - string140
string139:
db ".."
size139 EQU $ - string139
string138:
db " d-1 +l:"
size138 EQU $ - string138
string137:
db ".."
size137 EQU $ - string137
string136:
db " d-1 +l:"
size136 EQU $ - string136
string135:
db ".."
size135 EQU $ - string135
string134:
db " 0  0 x:"
size134 EQU $ - string134
string133:
db ".."
size133 EQU $ - string133
string132:
db "-1  1 x:"
size132 EQU $ - string132
string131:
db "-1 -5 x:"
size131 EQU $ - string131
string130:
db " 2 -1 x:"
size130 EQU $ - string130
string129:
db " 1  1 ?x:"
size129 EQU $ - string129
string128:
db "-1 -1 ?x:"
size128 EQU $ - string128
string127:
db ".."
size127 EQU $ - string127
string126:
db " 2 -1 -4 x:"
size126 EQU $ - string126
string125:
db ".."
size125 EQU $ - string125
string124:
db " 2 -1 -2 x:"
size124 EQU $ - string124
string123:
db ".."
size123 EQU $ - string123
string122:
db " 2 -1 -1 x:"
size122 EQU $ - string122
string121:
db ".."
size121 EQU $ - string121
string120:
db " 0  0  4 x:"
size120 EQU $ - string120
string119:
db ".."
size119 EQU $ - string119
string118:
db " 0  0  2 x:"
size118 EQU $ - string118
string117:
db ".."
size117 EQU $ - string117
string116:
db " 0  0  1 x:"
size116 EQU $ - string116
string115:
db ".."
size115 EQU $ - string115
string114:
db "-1  1  4 x:"
size114 EQU $ - string114
string113:
db ".."
size113 EQU $ - string113
string112:
db "-1  1  2 x:"
size112 EQU $ - string112
string111:
db ".."
size111 EQU $ - string111
string110:
db "-1  1  1 x:"
size110 EQU $ - string110
string109:
db " 2 -1  4 x:"
size109 EQU $ - string109
string108:
db " 2 -1  2 x:"
size108 EQU $ - string108
string107:
db " 2 -1  1 x:"
size107 EQU $ - string107
string106:
db " 0  0 -4 x:"
size106 EQU $ - string106
string105:
db " 0  0 -2 x:"
size105 EQU $ - string105
string104:
db " 0  0 -1 x:"
size104 EQU $ - string104
string103:
db "-1  1 -4 x:"
size103 EQU $ - string103
string102:
db "-1  1 -2 x:"
size102 EQU $ - string102
string101:
db "-1  1 -1 x:"
size101 EQU $ - string101


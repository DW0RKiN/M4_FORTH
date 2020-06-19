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
    call _down1         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _down2         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _down3         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _up1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _up2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _up3           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _smycka        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,1)
    ld   DE, -1         ; 3:10      push2(-1,1)
    push HL             ; 1:11      push2(-1,1)
    ld   HL, 1          ; 3:10      push2(-1,1) 
    call _otaznik       ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _down1         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _down2         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _down3         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _up1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _up2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _up3           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _smycka        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _otaznik       ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _down1         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _down2         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _down3         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _up1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _up2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _up3           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _smycka        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,-1)
    ld   DE, 1          ; 3:10      push2(1,-1)
    push HL             ; 1:11      push2(1,-1)
    ld   HL, -1         ; 3:10      push2(1,-1) 
    call _otaznik       ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call _down1         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call _down2         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,4)
    ld   DE, 1          ; 3:10      push2(1,4)
    push HL             ; 1:11      push2(1,4)
    ld   HL, 4          ; 3:10      push2(1,4) 
    call _down1         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,4)
    ld   DE, 1          ; 3:10      push2(1,4)
    push HL             ; 1:11      push2(1,4)
    ld   HL, 4          ; 3:10      push2(1,4) 
    call _down2         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(4,1)
    ld   DE, 4          ; 3:10      push2(4,1)
    push HL             ; 1:11      push2(4,1)
    ld   HL, 1          ; 3:10      push2(4,1) 
    call _down1         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(4,1)
    ld   DE, 4          ; 3:10      push2(4,1)
    push HL             ; 1:11      push2(4,1)
    ld   HL, 1          ; 3:10      push2(4,1) 
    call _down2         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(2,-1)
    ld   DE, 2          ; 3:10      push2(2,-1)
    push HL             ; 1:11      push2(2,-1)
    ld   HL, -1         ; 3:10      push2(2,-1) 
    call _down1         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(2,-1)
    ld   DE, 2          ; 3:10      push2(2,-1)
    push HL             ; 1:11      push2(2,-1)
    ld   HL, -1         ; 3:10      push2(2,-1) 
    call _down2         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,2)
    ld   DE, -1         ; 3:10      push2(-1,2)
    push HL             ; 1:11      push2(-1,2)
    ld   HL, 2          ; 3:10      push2(-1,2) 
    call _down1         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,2)
    ld   DE, -1         ; 3:10      push2(-1,2)
    push HL             ; 1:11      push2(-1,2)
    ld   HL, 2          ; 3:10      push2(-1,2) 
    call _down2         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call _up1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call _up2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,4)
    ld   DE, 1          ; 3:10      push2(1,4)
    push HL             ; 1:11      push2(1,4)
    ld   HL, 4          ; 3:10      push2(1,4) 
    call _up1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(1,4)
    ld   DE, 1          ; 3:10      push2(1,4)
    push HL             ; 1:11      push2(1,4)
    ld   HL, 4          ; 3:10      push2(1,4) 
    call _up2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(4,1)
    ld   DE, 4          ; 3:10      push2(4,1)
    push HL             ; 1:11      push2(4,1)
    ld   HL, 1          ; 3:10      push2(4,1) 
    call _up1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(4,1)
    ld   DE, 4          ; 3:10      push2(4,1)
    push HL             ; 1:11      push2(4,1)
    ld   HL, 1          ; 3:10      push2(4,1) 
    call _up2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(2,-1)
    ld   DE, 2          ; 3:10      push2(2,-1)
    push HL             ; 1:11      push2(2,-1)
    ld   HL, -1         ; 3:10      push2(2,-1) 
    call _up1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(2,-1)
    ld   DE, 2          ; 3:10      push2(2,-1)
    push HL             ; 1:11      push2(2,-1)
    ld   HL, -1         ; 3:10      push2(2,-1) 
    call _up2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,2)
    ld   DE, -1         ; 3:10      push2(-1,2)
    push HL             ; 1:11      push2(-1,2)
    ld   HL, 2          ; 3:10      push2(-1,2) 
    call _up1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push2(-1,2)
    ld   DE, -1         ; 3:10      push2(-1,2)
    push HL             ; 1:11      push2(-1,2)
    ld   HL, 2          ; 3:10      push2(-1,2) 
    call _up2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push(4)
    ex   DE, HL         ; 1:4       push(4)
    ld   HL, 4          ; 3:10      push(4) 
    push DE             ; 1:11      push2(1,0)
    ld   DE, 1          ; 3:10      push2(1,0)
    push HL             ; 1:11      push2(1,0)
    ld   HL, 0          ; 3:10      push2(1,0) 
    call _3loop         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _3loop         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    push DE             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   HL, 0          ; 3:10      push2(4,0) 
    call _3loop         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    push DE             ; 1:11      push2(-1,0)
    ld   DE, -1         ; 3:10      push2(-1,0)
    push HL             ; 1:11      push2(-1,0)
    ld   HL, 0          ; 3:10      push2(-1,0) 
    call _3loop         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    push DE             ; 1:11      push2(2,0)
    ld   DE, 2          ; 3:10      push2(2,0)
    push HL             ; 1:11      push2(2,0)
    ld   HL, 0          ; 3:10      push2(2,0) 
    call _3loop         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(10,-10)
    ld   DE, 10         ; 3:10      push2(10,-10)
    push HL             ; 1:11      push2(10,-10)
    ld   HL, -10        ; 3:10      push2(10,-10) 
    call _3loop         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(11,-10)
    ld   DE, 11         ; 3:10      push2(11,-10)
    push HL             ; 1:11      push2(11,-10)
    ld   HL, -10        ; 3:10      push2(11,-10) 
    call _3loop         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(9,-10)
    ld   DE, 9          ; 3:10      push2(9,-10)
    push HL             ; 1:11      push2(9,-10)
    ld   HL, -10        ; 3:10      push2(9,-10) 
    call _3loop         ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push(4)
    ex   DE, HL         ; 1:4       push(4)
    ld   HL, 4          ; 3:10      push(4) 
    push DE             ; 1:11      push2(1,0)
    ld   DE, 1          ; 3:10      push2(1,0)
    push HL             ; 1:11      push2(1,0)
    ld   HL, 0          ; 3:10      push2(1,0) 
    call _3sloop        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push DE             ; 1:11      push2(0,0)
    ld   DE, 0          ; 3:10      push2(0,0)
    push HL             ; 1:11      push2(0,0)
    ld   HL, 0          ; 3:10      push2(0,0) 
    call _3sloop        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    push DE             ; 1:11      push2(4,0)
    ld   DE, 4          ; 3:10      push2(4,0)
    push HL             ; 1:11      push2(4,0)
    ld   HL, 0          ; 3:10      push2(4,0) 
    call _3sloop        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    push DE             ; 1:11      push2(-1,0)
    ld   DE, -1         ; 3:10      push2(-1,0)
    push HL             ; 1:11      push2(-1,0)
    ld   HL, 0          ; 3:10      push2(-1,0) 
    call _3sloop        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    push DE             ; 1:11      push2(2,0)
    ld   DE, 2          ; 3:10      push2(2,0)
    push HL             ; 1:11      push2(2,0)
    ld   HL, 0          ; 3:10      push2(2,0) 
    call _3sloop        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(10,-10)
    ld   DE, 10         ; 3:10      push2(10,-10)
    push HL             ; 1:11      push2(10,-10)
    ld   HL, -10        ; 3:10      push2(10,-10) 
    call _3sloop        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(11,-10)
    ld   DE, 11         ; 3:10      push2(11,-10)
    push HL             ; 1:11      push2(11,-10)
    ld   HL, -10        ; 3:10      push2(11,-10) 
    call _3sloop        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    push DE             ; 1:11      push(-20)
    ex   DE, HL         ; 1:4       push(-20)
    ld   HL, -20        ; 3:10      push(-20) 
    push DE             ; 1:11      push2(9,-10)
    ld   DE, 9          ; 3:10      push2(9,-10)
    push HL             ; 1:11      push2(9,-10)
    ld   HL, -10        ; 3:10      push2(9,-10) 
    call _3sloop        ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(-1,1) 101
    dec  HL             ; 1:6       xdo(-1,1) 101
    ld  (HL),high 1     ; 2:10      xdo(-1,1) 101
    dec   L             ; 1:4       xdo(-1,1) 101
    ld  (HL),low 1      ; 2:10      xdo(-1,1) 101
    exx                 ; 1:4       xdo(-1,1) 101 R:( -- 1 )
xdo101:                 ;           xdo(-1,1) 101 
    exx                 ; 1:4       index xi 101
    ld    E,(HL)        ; 1:7       index xi 101
    inc   L             ; 1:4       index xi 101
    ld    D,(HL)        ; 1:7       index xi 101
    push DE             ; 1:11      index xi 101
    dec   L             ; 1:4       index xi 101
    exx                 ; 1:4       index xi 101 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 101
    ex  (SP),HL         ; 1:19      index xi 101 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       push_addxloop(-1) 101
    ld    E,(HL)        ; 1:7       push_addxloop(-1) 101
    inc   L             ; 1:4       push_addxloop(-1) 101
    ld    D,(HL)        ; 1:7       push_addxloop(-1) 101 DE = index
    push HL             ; 1:11      push_addxloop(-1) 101
    ld   HL, --1        ; 3:10      push_addxloop(-1) 101 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-1) 101 index-stop
    ld   BC, -1         ; 3:10      push_addxloop(-1) 101 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-1) 101 index-stop+step
    jr   nc, xleave101-1; 2:7/12    push_addxloop(-1) 101 -step
    ex   DE, HL         ; 1:4       push_addxloop(-1) 101
    add  HL, BC         ; 1:11      push_addxloop(-1) 101 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-1) 101    
    pop  HL             ; 1:10      push_addxloop(-1) 101
    ld  (HL),D          ; 1:7       push_addxloop(-1) 101
    dec   L             ; 1:4       push_addxloop(-1) 101
    ld  (HL),E          ; 1:7       push_addxloop(-1) 101
    exx                 ; 1:4       push_addxloop(-1) 101    
    jp   xdo101         ; 3:10      push_addxloop(-1) 101 ( -- ) R:( index -- index+-1 )
    pop  HL             ; 1:10      push_addxloop(-1) 101
xleave101:              ;           push_addxloop(-1) 101    
    inc  HL             ; 1:6       push_addxloop(-1) 101    
    exx                 ; 1:4       push_addxloop(-1) 101 ( -- ) R:( index -- )
xexit101 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(-1,1) 102
    dec  HL             ; 1:6       xdo(-1,1) 102
    ld  (HL),high 1     ; 2:10      xdo(-1,1) 102
    dec   L             ; 1:4       xdo(-1,1) 102
    ld  (HL),low 1      ; 2:10      xdo(-1,1) 102
    exx                 ; 1:4       xdo(-1,1) 102 R:( -- 1 )
xdo102:                 ;           xdo(-1,1) 102 
    exx                 ; 1:4       index xi 102
    ld    E,(HL)        ; 1:7       index xi 102
    inc   L             ; 1:4       index xi 102
    ld    D,(HL)        ; 1:7       index xi 102
    push DE             ; 1:11      index xi 102
    dec   L             ; 1:4       index xi 102
    exx                 ; 1:4       index xi 102 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 102
    ex  (SP),HL         ; 1:19      index xi 102 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       push_addxloop(-2) 102
    ld    E,(HL)        ; 1:7       push_addxloop(-2) 102
    inc   L             ; 1:4       push_addxloop(-2) 102
    ld    D,(HL)        ; 1:7       push_addxloop(-2) 102 DE = index
    push HL             ; 1:11      push_addxloop(-2) 102
    ld   HL, --1        ; 3:10      push_addxloop(-2) 102 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-2) 102 index-stop
    ld   BC, -2         ; 3:10      push_addxloop(-2) 102 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-2) 102 index-stop+step
    jr   nc, xleave102-1; 2:7/12    push_addxloop(-2) 102 -step
    ex   DE, HL         ; 1:4       push_addxloop(-2) 102
    add  HL, BC         ; 1:11      push_addxloop(-2) 102 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-2) 102    
    pop  HL             ; 1:10      push_addxloop(-2) 102
    ld  (HL),D          ; 1:7       push_addxloop(-2) 102
    dec   L             ; 1:4       push_addxloop(-2) 102
    ld  (HL),E          ; 1:7       push_addxloop(-2) 102
    exx                 ; 1:4       push_addxloop(-2) 102    
    jp   xdo102         ; 3:10      push_addxloop(-2) 102 ( -- ) R:( index -- index+-2 )
    pop  HL             ; 1:10      push_addxloop(-2) 102
xleave102:              ;           push_addxloop(-2) 102    
    inc  HL             ; 1:6       push_addxloop(-2) 102    
    exx                 ; 1:4       push_addxloop(-2) 102 ( -- ) R:( index -- )
xexit102 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(-1,1) 103
    dec  HL             ; 1:6       xdo(-1,1) 103
    ld  (HL),high 1     ; 2:10      xdo(-1,1) 103
    dec   L             ; 1:4       xdo(-1,1) 103
    ld  (HL),low 1      ; 2:10      xdo(-1,1) 103
    exx                 ; 1:4       xdo(-1,1) 103 R:( -- 1 )
xdo103:                 ;           xdo(-1,1) 103 
    exx                 ; 1:4       index xi 103
    ld    E,(HL)        ; 1:7       index xi 103
    inc   L             ; 1:4       index xi 103
    ld    D,(HL)        ; 1:7       index xi 103
    push DE             ; 1:11      index xi 103
    dec   L             ; 1:4       index xi 103
    exx                 ; 1:4       index xi 103 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 103
    ex  (SP),HL         ; 1:19      index xi 103 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       push_addxloop(-4) 103
    ld    E,(HL)        ; 1:7       push_addxloop(-4) 103
    inc   L             ; 1:4       push_addxloop(-4) 103
    ld    D,(HL)        ; 1:7       push_addxloop(-4) 103 DE = index
    push HL             ; 1:11      push_addxloop(-4) 103
    ld   HL, --1        ; 3:10      push_addxloop(-4) 103 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-4) 103 index-stop
    ld   BC, -4         ; 3:10      push_addxloop(-4) 103 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-4) 103 index-stop+step
    jr   nc, xleave103-1; 2:7/12    push_addxloop(-4) 103 -step
    ex   DE, HL         ; 1:4       push_addxloop(-4) 103
    add  HL, BC         ; 1:11      push_addxloop(-4) 103 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-4) 103    
    pop  HL             ; 1:10      push_addxloop(-4) 103
    ld  (HL),D          ; 1:7       push_addxloop(-4) 103
    dec   L             ; 1:4       push_addxloop(-4) 103
    ld  (HL),E          ; 1:7       push_addxloop(-4) 103
    exx                 ; 1:4       push_addxloop(-4) 103    
    jp   xdo103         ; 3:10      push_addxloop(-4) 103 ( -- ) R:( index -- index+-4 )
    pop  HL             ; 1:10      push_addxloop(-4) 103
xleave103:              ;           push_addxloop(-4) 103    
    inc  HL             ; 1:6       push_addxloop(-4) 103    
    exx                 ; 1:4       push_addxloop(-4) 103 ( -- ) R:( index -- )
xexit103 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(0,0) 104
    dec  HL             ; 1:6       xdo(0,0) 104
    ld  (HL),high 0     ; 2:10      xdo(0,0) 104
    dec   L             ; 1:4       xdo(0,0) 104
    ld  (HL),low 0      ; 2:10      xdo(0,0) 104
    exx                 ; 1:4       xdo(0,0) 104 R:( -- 0 )
xdo104:                 ;           xdo(0,0) 104 
    exx                 ; 1:4       index xi 104
    ld    E,(HL)        ; 1:7       index xi 104
    inc   L             ; 1:4       index xi 104
    ld    D,(HL)        ; 1:7       index xi 104
    push DE             ; 1:11      index xi 104
    dec   L             ; 1:4       index xi 104
    exx                 ; 1:4       index xi 104 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 104
    ex  (SP),HL         ; 1:19      index xi 104 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       push_addxloop(-1) 104
    ld    E,(HL)        ; 1:7       push_addxloop(-1) 104
    inc   L             ; 1:4       push_addxloop(-1) 104
    ld    D,(HL)        ; 1:7       push_addxloop(-1) 104 DE = index
    push HL             ; 1:11      push_addxloop(-1) 104
    ld   HL, -0         ; 3:10      push_addxloop(-1) 104 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-1) 104 index-stop
    ld   BC, -1         ; 3:10      push_addxloop(-1) 104 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-1) 104 index-stop+step
    jr   nc, xleave104-1; 2:7/12    push_addxloop(-1) 104 -step
    ex   DE, HL         ; 1:4       push_addxloop(-1) 104
    add  HL, BC         ; 1:11      push_addxloop(-1) 104 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-1) 104    
    pop  HL             ; 1:10      push_addxloop(-1) 104
    ld  (HL),D          ; 1:7       push_addxloop(-1) 104
    dec   L             ; 1:4       push_addxloop(-1) 104
    ld  (HL),E          ; 1:7       push_addxloop(-1) 104
    exx                 ; 1:4       push_addxloop(-1) 104    
    jp   xdo104         ; 3:10      push_addxloop(-1) 104 ( -- ) R:( index -- index+-1 )
    pop  HL             ; 1:10      push_addxloop(-1) 104
xleave104:              ;           push_addxloop(-1) 104    
    inc  HL             ; 1:6       push_addxloop(-1) 104    
    exx                 ; 1:4       push_addxloop(-1) 104 ( -- ) R:( index -- )
xexit104 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(0,0) 105
    dec  HL             ; 1:6       xdo(0,0) 105
    ld  (HL),high 0     ; 2:10      xdo(0,0) 105
    dec   L             ; 1:4       xdo(0,0) 105
    ld  (HL),low 0      ; 2:10      xdo(0,0) 105
    exx                 ; 1:4       xdo(0,0) 105 R:( -- 0 )
xdo105:                 ;           xdo(0,0) 105 
    exx                 ; 1:4       index xi 105
    ld    E,(HL)        ; 1:7       index xi 105
    inc   L             ; 1:4       index xi 105
    ld    D,(HL)        ; 1:7       index xi 105
    push DE             ; 1:11      index xi 105
    dec   L             ; 1:4       index xi 105
    exx                 ; 1:4       index xi 105 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 105
    ex  (SP),HL         ; 1:19      index xi 105 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       push_addxloop(-2) 105
    ld    E,(HL)        ; 1:7       push_addxloop(-2) 105
    inc   L             ; 1:4       push_addxloop(-2) 105
    ld    D,(HL)        ; 1:7       push_addxloop(-2) 105 DE = index
    push HL             ; 1:11      push_addxloop(-2) 105
    ld   HL, -0         ; 3:10      push_addxloop(-2) 105 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-2) 105 index-stop
    ld   BC, -2         ; 3:10      push_addxloop(-2) 105 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-2) 105 index-stop+step
    jr   nc, xleave105-1; 2:7/12    push_addxloop(-2) 105 -step
    ex   DE, HL         ; 1:4       push_addxloop(-2) 105
    add  HL, BC         ; 1:11      push_addxloop(-2) 105 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-2) 105    
    pop  HL             ; 1:10      push_addxloop(-2) 105
    ld  (HL),D          ; 1:7       push_addxloop(-2) 105
    dec   L             ; 1:4       push_addxloop(-2) 105
    ld  (HL),E          ; 1:7       push_addxloop(-2) 105
    exx                 ; 1:4       push_addxloop(-2) 105    
    jp   xdo105         ; 3:10      push_addxloop(-2) 105 ( -- ) R:( index -- index+-2 )
    pop  HL             ; 1:10      push_addxloop(-2) 105
xleave105:              ;           push_addxloop(-2) 105    
    inc  HL             ; 1:6       push_addxloop(-2) 105    
    exx                 ; 1:4       push_addxloop(-2) 105 ( -- ) R:( index -- )
xexit105 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(0,0) 106
    dec  HL             ; 1:6       xdo(0,0) 106
    ld  (HL),high 0     ; 2:10      xdo(0,0) 106
    dec   L             ; 1:4       xdo(0,0) 106
    ld  (HL),low 0      ; 2:10      xdo(0,0) 106
    exx                 ; 1:4       xdo(0,0) 106 R:( -- 0 )
xdo106:                 ;           xdo(0,0) 106 
    exx                 ; 1:4       index xi 106
    ld    E,(HL)        ; 1:7       index xi 106
    inc   L             ; 1:4       index xi 106
    ld    D,(HL)        ; 1:7       index xi 106
    push DE             ; 1:11      index xi 106
    dec   L             ; 1:4       index xi 106
    exx                 ; 1:4       index xi 106 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 106
    ex  (SP),HL         ; 1:19      index xi 106 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       push_addxloop(-4) 106
    ld    E,(HL)        ; 1:7       push_addxloop(-4) 106
    inc   L             ; 1:4       push_addxloop(-4) 106
    ld    D,(HL)        ; 1:7       push_addxloop(-4) 106 DE = index
    push HL             ; 1:11      push_addxloop(-4) 106
    ld   HL, -0         ; 3:10      push_addxloop(-4) 106 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-4) 106 index-stop
    ld   BC, -4         ; 3:10      push_addxloop(-4) 106 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-4) 106 index-stop+step
    jr   nc, xleave106-1; 2:7/12    push_addxloop(-4) 106 -step
    ex   DE, HL         ; 1:4       push_addxloop(-4) 106
    add  HL, BC         ; 1:11      push_addxloop(-4) 106 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-4) 106    
    pop  HL             ; 1:10      push_addxloop(-4) 106
    ld  (HL),D          ; 1:7       push_addxloop(-4) 106
    dec   L             ; 1:4       push_addxloop(-4) 106
    ld  (HL),E          ; 1:7       push_addxloop(-4) 106
    exx                 ; 1:4       push_addxloop(-4) 106    
    jp   xdo106         ; 3:10      push_addxloop(-4) 106 ( -- ) R:( index -- index+-4 )
    pop  HL             ; 1:10      push_addxloop(-4) 106
xleave106:              ;           push_addxloop(-4) 106    
    inc  HL             ; 1:6       push_addxloop(-4) 106    
    exx                 ; 1:4       push_addxloop(-4) 106 ( -- ) R:( index -- )
xexit106 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      print
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(2,-1) 107
    dec  HL             ; 1:6       xdo(2,-1) 107
    ld  (HL),high -1    ; 2:10      xdo(2,-1) 107
    dec   L             ; 1:4       xdo(2,-1) 107
    ld  (HL),low -1     ; 2:10      xdo(2,-1) 107
    exx                 ; 1:4       xdo(2,-1) 107 R:( -- -1 )
xdo107:                 ;           xdo(2,-1) 107 
    exx                 ; 1:4       index xi 107
    ld    E,(HL)        ; 1:7       index xi 107
    inc   L             ; 1:4       index xi 107
    ld    D,(HL)        ; 1:7       index xi 107
    push DE             ; 1:11      index xi 107
    dec   L             ; 1:4       index xi 107
    exx                 ; 1:4       index xi 107 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 107
    ex  (SP),HL         ; 1:19      index xi 107 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
                        ;           push_addxloop(1) 107
    exx                 ; 1:4       xloop(2,-1) 107
    ld    E,(HL)        ; 1:7       xloop(2,-1) 107
    inc   L             ; 1:4       xloop(2,-1) 107
    ld    D,(HL)        ; 1:7       xloop(2,-1) 107
    inc  DE             ; 1:6       xloop(2,-1) 107 index++
    ld    A, low 2      ; 2:7       xloop(2,-1) 107
    xor   E             ; 1:4       xloop(2,-1) 107
    ld    C, A          ; 1:4       xloop(2,-1) 107
    ld    A, high 2     ; 2:7       xloop(2,-1) 107
    xor   D             ; 1:4       xloop(2,-1) 107
    or    C             ; 1:4       xloop(2,-1) 107
    jr    z, xleave107  ; 2:7/12    xloop(2,-1) 107 exit
    ld  (HL), D         ; 1:7       xloop(2,-1) 107
    dec   L             ; 1:4       xloop(2,-1) 107
    ld  (HL), E         ; 1:6       xloop(2,-1) 107
    exx                 ; 1:4       xloop(2,-1) 107
    jp   xdo107         ; 3:10      xloop(2,-1) 107
xleave107:              ;           xloop(2,-1) 107
    inc  HL             ; 1:6       xloop(2,-1) 107
    exx                 ; 1:4       xloop(2,-1) 107 R:( index -- )
xexit107 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(2,-1) 108
    dec  HL             ; 1:6       xdo(2,-1) 108
    ld  (HL),high -1    ; 2:10      xdo(2,-1) 108
    dec   L             ; 1:4       xdo(2,-1) 108
    ld  (HL),low -1     ; 2:10      xdo(2,-1) 108
    exx                 ; 1:4       xdo(2,-1) 108 R:( -- -1 )
xdo108:                 ;           xdo(2,-1) 108 
    exx                 ; 1:4       index xi 108
    ld    E,(HL)        ; 1:7       index xi 108
    inc   L             ; 1:4       index xi 108
    ld    D,(HL)        ; 1:7       index xi 108
    push DE             ; 1:11      index xi 108
    dec   L             ; 1:4       index xi 108
    exx                 ; 1:4       index xi 108 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 108
    ex  (SP),HL         ; 1:19      index xi 108 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
                        ;           push_addxloop(2) 108
    exx                 ; 1:4       2 +xloop 108
    ld    E,(HL)        ; 1:7       2 +xloop 108
    inc   L             ; 1:4       2 +xloop 108
    ld    D,(HL)        ; 1:7       2 +xloop 108 DE = index
    inc  DE             ; 1:6       2 +xloop 108
    inc  DE             ; 1:6       2 +xloop 108 DE = index+2
    ld    A, E          ; 1:4       2 +xloop 108    
    sub  low 2          ; 2:7       2 +xloop 108 lo index+2-stop
    rra                 ; 1:4       2 +xloop 108
    add   A, A          ; 1:4       2 +xloop 108 and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +xloop 108
    ld    A, D          ; 1:4       2 +xloop 108
    sbc   A, high 2     ; 2:7       2 +xloop 108 lo index+2-stop
    jr    z, xleave108  ; 2:7/12    2 +xloop 108
    ld  (HL),D          ; 1:7       2 +xloop 108
    dec   L             ; 1:4       2 +xloop 108
    ld  (HL),E          ; 1:7       2 +xloop 108
    exx                 ; 1:4       2 +xloop 108
    jp    p, xdo108     ; 3:10      2 +xloop 108 ( -- ) R:( stop index -- stop index+ )
xleave108:              ;           2 +xloop 108
    inc  HL             ; 1:6       2 +xloop 108
    exx                 ; 1:4       2 +xloop 108
xexit108 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(2,-1) 109
    dec  HL             ; 1:6       xdo(2,-1) 109
    ld  (HL),high -1    ; 2:10      xdo(2,-1) 109
    dec   L             ; 1:4       xdo(2,-1) 109
    ld  (HL),low -1     ; 2:10      xdo(2,-1) 109
    exx                 ; 1:4       xdo(2,-1) 109 R:( -- -1 )
xdo109:                 ;           xdo(2,-1) 109 
    exx                 ; 1:4       index xi 109
    ld    E,(HL)        ; 1:7       index xi 109
    inc   L             ; 1:4       index xi 109
    ld    D,(HL)        ; 1:7       index xi 109
    push DE             ; 1:11      index xi 109
    dec   L             ; 1:4       index xi 109
    exx                 ; 1:4       index xi 109 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 109
    ex  (SP),HL         ; 1:19      index xi 109 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       push_addxloop(4) 109
    ld    E,(HL)        ; 1:7       push_addxloop(4) 109
    inc   L             ; 1:4       push_addxloop(4) 109
    ld    D,(HL)        ; 1:7       push_addxloop(4) 109 DE = index
    push HL             ; 1:11      push_addxloop(4) 109
    ld   HL, -2         ; 3:10      push_addxloop(4) 109 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(4) 109 index-stop
    ld   BC, 4          ; 3:10      push_addxloop(4) 109 BC = step
    add  HL, BC         ; 1:11      push_addxloop(4) 109 index-stop+step
    jr    c, xleave109-1; 2:7/12    push_addxloop(4) 109 +step
    ex   DE, HL         ; 1:4       push_addxloop(4) 109
    add  HL, BC         ; 1:11      push_addxloop(4) 109 index+step
    ex   DE, HL         ; 1:4       push_addxloop(4) 109    
    pop  HL             ; 1:10      push_addxloop(4) 109
    ld  (HL),D          ; 1:7       push_addxloop(4) 109
    dec   L             ; 1:4       push_addxloop(4) 109
    ld  (HL),E          ; 1:7       push_addxloop(4) 109
    exx                 ; 1:4       push_addxloop(4) 109    
    jp   xdo109         ; 3:10      push_addxloop(4) 109 ( -- ) R:( index -- index+4 )
    pop  HL             ; 1:10      push_addxloop(4) 109
xleave109:              ;           push_addxloop(4) 109    
    inc  HL             ; 1:6       push_addxloop(4) 109    
    exx                 ; 1:4       push_addxloop(4) 109 ( -- ) R:( index -- )
xexit109 EQU $ 
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

    exx                 ; 1:4       xdo(-1,1) 110
    dec  HL             ; 1:6       xdo(-1,1) 110
    ld  (HL),high 1     ; 2:10      xdo(-1,1) 110
    dec   L             ; 1:4       xdo(-1,1) 110
    ld  (HL),low 1      ; 2:10      xdo(-1,1) 110
    exx                 ; 1:4       xdo(-1,1) 110 R:( -- 1 )
xdo110:                 ;           xdo(-1,1) 110 
    exx                 ; 1:4       index xi 110
    ld    E,(HL)        ; 1:7       index xi 110
    inc   L             ; 1:4       index xi 110
    ld    D,(HL)        ; 1:7       index xi 110
    push DE             ; 1:11      index xi 110
    dec   L             ; 1:4       index xi 110
    exx                 ; 1:4       index xi 110 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 110
    ex  (SP),HL         ; 1:19      index xi 110 ( -- x ) 
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
    exx                 ; 1:4       xleave 110
    inc  L              ; 1:4       xleave 110
    jp   xleave110      ;           xleave 110 
else101  EQU $          ;           = endif
endif101: 
                        ;           push_addxloop(1) 110
    exx                 ; 1:4       xloop(-1,1) 110
    ld    E,(HL)        ; 1:7       xloop(-1,1) 110
    inc   L             ; 1:4       xloop(-1,1) 110
    ld    D,(HL)        ; 1:7       xloop(-1,1) 110
    inc  DE             ; 1:6       xloop(-1,1) 110 index++
    ld    A, low -1     ; 2:7       xloop(-1,1) 110
    xor   E             ; 1:4       xloop(-1,1) 110
    ld    C, A          ; 1:4       xloop(-1,1) 110
    ld    A, high -1    ; 2:7       xloop(-1,1) 110
    xor   D             ; 1:4       xloop(-1,1) 110
    or    C             ; 1:4       xloop(-1,1) 110
    jr    z, xleave110  ; 2:7/12    xloop(-1,1) 110 exit
    ld  (HL), D         ; 1:7       xloop(-1,1) 110
    dec   L             ; 1:4       xloop(-1,1) 110
    ld  (HL), E         ; 1:6       xloop(-1,1) 110
    exx                 ; 1:4       xloop(-1,1) 110
    jp   xdo110         ; 3:10      xloop(-1,1) 110
xleave110:              ;           xloop(-1,1) 110
    inc  HL             ; 1:6       xloop(-1,1) 110
    exx                 ; 1:4       xloop(-1,1) 110 R:( index -- )
xexit110 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size112    ; 3:10      print Length of string to print
    ld   DE, string112  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(-1,1) 111
    dec  HL             ; 1:6       xdo(-1,1) 111
    ld  (HL),high 1     ; 2:10      xdo(-1,1) 111
    dec   L             ; 1:4       xdo(-1,1) 111
    ld  (HL),low 1      ; 2:10      xdo(-1,1) 111
    exx                 ; 1:4       xdo(-1,1) 111 R:( -- 1 )
xdo111:                 ;           xdo(-1,1) 111 
    exx                 ; 1:4       index xi 111
    ld    E,(HL)        ; 1:7       index xi 111
    inc   L             ; 1:4       index xi 111
    ld    D,(HL)        ; 1:7       index xi 111
    push DE             ; 1:11      index xi 111
    dec   L             ; 1:4       index xi 111
    exx                 ; 1:4       index xi 111 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 111
    ex  (SP),HL         ; 1:19      index xi 111 ( -- x ) 
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
    exx                 ; 1:4       xleave 111
    inc  L              ; 1:4       xleave 111
    jp   xleave111      ;           xleave 111 
else102  EQU $          ;           = endif
endif102: 
                        ;           push_addxloop(2) 111
    exx                 ; 1:4       2 +xloop 111
    ld    E,(HL)        ; 1:7       2 +xloop 111
    inc   L             ; 1:4       2 +xloop 111
    ld    D,(HL)        ; 1:7       2 +xloop 111 DE = index
    inc  DE             ; 1:6       2 +xloop 111
    inc  DE             ; 1:6       2 +xloop 111 DE = index+2
    ld    A, E          ; 1:4       2 +xloop 111    
    sub  low -1         ; 2:7       2 +xloop 111 lo index+2-stop
    rra                 ; 1:4       2 +xloop 111
    add   A, A          ; 1:4       2 +xloop 111 and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +xloop 111
    ld    A, D          ; 1:4       2 +xloop 111
    sbc   A, high -1    ; 2:7       2 +xloop 111 lo index+2-stop
    jr    z, xleave111  ; 2:7/12    2 +xloop 111
    ld  (HL),D          ; 1:7       2 +xloop 111
    dec   L             ; 1:4       2 +xloop 111
    ld  (HL),E          ; 1:7       2 +xloop 111
    exx                 ; 1:4       2 +xloop 111
    jp    p, xdo111     ; 3:10      2 +xloop 111 ( -- ) R:( stop index -- stop index+ )
xleave111:              ;           2 +xloop 111
    inc  HL             ; 1:6       2 +xloop 111
    exx                 ; 1:4       2 +xloop 111
xexit111 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size114    ; 3:10      print Length of string to print
    ld   DE, string114  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(-1,1) 112
    dec  HL             ; 1:6       xdo(-1,1) 112
    ld  (HL),high 1     ; 2:10      xdo(-1,1) 112
    dec   L             ; 1:4       xdo(-1,1) 112
    ld  (HL),low 1      ; 2:10      xdo(-1,1) 112
    exx                 ; 1:4       xdo(-1,1) 112 R:( -- 1 )
xdo112:                 ;           xdo(-1,1) 112 
    exx                 ; 1:4       index xi 112
    ld    E,(HL)        ; 1:7       index xi 112
    inc   L             ; 1:4       index xi 112
    ld    D,(HL)        ; 1:7       index xi 112
    push DE             ; 1:11      index xi 112
    dec   L             ; 1:4       index xi 112
    exx                 ; 1:4       index xi 112 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 112
    ex  (SP),HL         ; 1:19      index xi 112 ( -- x ) 
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
    exx                 ; 1:4       xleave 112
    inc  L              ; 1:4       xleave 112
    jp   xleave112      ;           xleave 112 
else103  EQU $          ;           = endif
endif103: 
    exx                 ; 1:4       push_addxloop(4) 112
    ld    E,(HL)        ; 1:7       push_addxloop(4) 112
    inc   L             ; 1:4       push_addxloop(4) 112
    ld    D,(HL)        ; 1:7       push_addxloop(4) 112 DE = index
    push HL             ; 1:11      push_addxloop(4) 112
    ld   HL, --1        ; 3:10      push_addxloop(4) 112 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(4) 112 index-stop
    ld   BC, 4          ; 3:10      push_addxloop(4) 112 BC = step
    add  HL, BC         ; 1:11      push_addxloop(4) 112 index-stop+step
    jr    c, xleave112-1; 2:7/12    push_addxloop(4) 112 +step
    ex   DE, HL         ; 1:4       push_addxloop(4) 112
    add  HL, BC         ; 1:11      push_addxloop(4) 112 index+step
    ex   DE, HL         ; 1:4       push_addxloop(4) 112    
    pop  HL             ; 1:10      push_addxloop(4) 112
    ld  (HL),D          ; 1:7       push_addxloop(4) 112
    dec   L             ; 1:4       push_addxloop(4) 112
    ld  (HL),E          ; 1:7       push_addxloop(4) 112
    exx                 ; 1:4       push_addxloop(4) 112    
    jp   xdo112         ; 3:10      push_addxloop(4) 112 ( -- ) R:( index -- index+4 )
    pop  HL             ; 1:10      push_addxloop(4) 112
xleave112:              ;           push_addxloop(4) 112    
    inc  HL             ; 1:6       push_addxloop(4) 112    
    exx                 ; 1:4       push_addxloop(4) 112 ( -- ) R:( index -- )
xexit112 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      print
    ld   BC, size116    ; 3:10      print Length of string to print
    ld   DE, string116  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(0,0) 113
    dec  HL             ; 1:6       xdo(0,0) 113
    ld  (HL),high 0     ; 2:10      xdo(0,0) 113
    dec   L             ; 1:4       xdo(0,0) 113
    ld  (HL),low 0      ; 2:10      xdo(0,0) 113
    exx                 ; 1:4       xdo(0,0) 113 R:( -- 0 )
xdo113:                 ;           xdo(0,0) 113 
    exx                 ; 1:4       index xi 113
    ld    E,(HL)        ; 1:7       index xi 113
    inc   L             ; 1:4       index xi 113
    ld    D,(HL)        ; 1:7       index xi 113
    push DE             ; 1:11      index xi 113
    dec   L             ; 1:4       index xi 113
    exx                 ; 1:4       index xi 113 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 113
    ex  (SP),HL         ; 1:19      index xi 113 ( -- x ) 
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
    exx                 ; 1:4       xleave 113
    inc  L              ; 1:4       xleave 113
    jp   xleave113      ;           xleave 113 
else104  EQU $          ;           = endif
endif104: 
                        ;           push_addxloop(1) 113
    exx                 ; 1:4       xloop(0,0) 113
    ld    E,(HL)        ; 1:7       xloop(0,0) 113
    inc   L             ; 1:4       xloop(0,0) 113
    ld    D,(HL)        ; 1:7       xloop(0,0) 113
    inc  DE             ; 1:6       xloop(0,0) 113 index++
    ld    A, low 0      ; 2:7       xloop(0,0) 113
    xor   E             ; 1:4       xloop(0,0) 113
    ld    C, A          ; 1:4       xloop(0,0) 113
    ld    A, high 0     ; 2:7       xloop(0,0) 113
    xor   D             ; 1:4       xloop(0,0) 113
    or    C             ; 1:4       xloop(0,0) 113
    jr    z, xleave113  ; 2:7/12    xloop(0,0) 113 exit
    ld  (HL), D         ; 1:7       xloop(0,0) 113
    dec   L             ; 1:4       xloop(0,0) 113
    ld  (HL), E         ; 1:6       xloop(0,0) 113
    exx                 ; 1:4       xloop(0,0) 113
    jp   xdo113         ; 3:10      xloop(0,0) 113
xleave113:              ;           xloop(0,0) 113
    inc  HL             ; 1:6       xloop(0,0) 113
    exx                 ; 1:4       xloop(0,0) 113 R:( index -- )
xexit113 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size118    ; 3:10      print Length of string to print
    ld   DE, string118  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(0,0) 114
    dec  HL             ; 1:6       xdo(0,0) 114
    ld  (HL),high 0     ; 2:10      xdo(0,0) 114
    dec   L             ; 1:4       xdo(0,0) 114
    ld  (HL),low 0      ; 2:10      xdo(0,0) 114
    exx                 ; 1:4       xdo(0,0) 114 R:( -- 0 )
xdo114:                 ;           xdo(0,0) 114 
    exx                 ; 1:4       index xi 114
    ld    E,(HL)        ; 1:7       index xi 114
    inc   L             ; 1:4       index xi 114
    ld    D,(HL)        ; 1:7       index xi 114
    push DE             ; 1:11      index xi 114
    dec   L             ; 1:4       index xi 114
    exx                 ; 1:4       index xi 114 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 114
    ex  (SP),HL         ; 1:19      index xi 114 ( -- x ) 
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
    exx                 ; 1:4       xleave 114
    inc  L              ; 1:4       xleave 114
    jp   xleave114      ;           xleave 114 
else105  EQU $          ;           = endif
endif105: 
                        ;           push_addxloop(2) 114
    exx                 ; 1:4       2 +xloop 114
    ld    E,(HL)        ; 1:7       2 +xloop 114
    inc   L             ; 1:4       2 +xloop 114
    ld    D,(HL)        ; 1:7       2 +xloop 114 DE = index
    inc  DE             ; 1:6       2 +xloop 114
    inc  DE             ; 1:6       2 +xloop 114 DE = index+2
    ld    A, E          ; 1:4       2 +xloop 114    
    sub  low 0          ; 2:7       2 +xloop 114 lo index+2-stop
    rra                 ; 1:4       2 +xloop 114
    add   A, A          ; 1:4       2 +xloop 114 and 0xFE with save carry
    jr   nz, $+7        ; 2:7/12    2 +xloop 114
    ld    A, D          ; 1:4       2 +xloop 114
    sbc   A, high 0     ; 2:7       2 +xloop 114 lo index+2-stop
    jr    z, xleave114  ; 2:7/12    2 +xloop 114
    ld  (HL),D          ; 1:7       2 +xloop 114
    dec   L             ; 1:4       2 +xloop 114
    ld  (HL),E          ; 1:7       2 +xloop 114
    exx                 ; 1:4       2 +xloop 114
    jp    p, xdo114     ; 3:10      2 +xloop 114 ( -- ) R:( stop index -- stop index+ )
xleave114:              ;           2 +xloop 114
    inc  HL             ; 1:6       2 +xloop 114
    exx                 ; 1:4       2 +xloop 114
xexit114 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size120    ; 3:10      print Length of string to print
    ld   DE, string120  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(0,0) 115
    dec  HL             ; 1:6       xdo(0,0) 115
    ld  (HL),high 0     ; 2:10      xdo(0,0) 115
    dec   L             ; 1:4       xdo(0,0) 115
    ld  (HL),low 0      ; 2:10      xdo(0,0) 115
    exx                 ; 1:4       xdo(0,0) 115 R:( -- 0 )
xdo115:                 ;           xdo(0,0) 115 
    exx                 ; 1:4       index xi 115
    ld    E,(HL)        ; 1:7       index xi 115
    inc   L             ; 1:4       index xi 115
    ld    D,(HL)        ; 1:7       index xi 115
    push DE             ; 1:11      index xi 115
    dec   L             ; 1:4       index xi 115
    exx                 ; 1:4       index xi 115 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 115
    ex  (SP),HL         ; 1:19      index xi 115 ( -- x ) 
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
    exx                 ; 1:4       xleave 115
    inc  L              ; 1:4       xleave 115
    jp   xleave115      ;           xleave 115 
else106  EQU $          ;           = endif
endif106: 
    exx                 ; 1:4       push_addxloop(4) 115
    ld    E,(HL)        ; 1:7       push_addxloop(4) 115
    inc   L             ; 1:4       push_addxloop(4) 115
    ld    D,(HL)        ; 1:7       push_addxloop(4) 115 DE = index
    push HL             ; 1:11      push_addxloop(4) 115
    ld   HL, -0         ; 3:10      push_addxloop(4) 115 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(4) 115 index-stop
    ld   BC, 4          ; 3:10      push_addxloop(4) 115 BC = step
    add  HL, BC         ; 1:11      push_addxloop(4) 115 index-stop+step
    jr    c, xleave115-1; 2:7/12    push_addxloop(4) 115 +step
    ex   DE, HL         ; 1:4       push_addxloop(4) 115
    add  HL, BC         ; 1:11      push_addxloop(4) 115 index+step
    ex   DE, HL         ; 1:4       push_addxloop(4) 115    
    pop  HL             ; 1:10      push_addxloop(4) 115
    ld  (HL),D          ; 1:7       push_addxloop(4) 115
    dec   L             ; 1:4       push_addxloop(4) 115
    ld  (HL),E          ; 1:7       push_addxloop(4) 115
    exx                 ; 1:4       push_addxloop(4) 115    
    jp   xdo115         ; 3:10      push_addxloop(4) 115 ( -- ) R:( index -- index+4 )
    pop  HL             ; 1:10      push_addxloop(4) 115
xleave115:              ;           push_addxloop(4) 115    
    inc  HL             ; 1:6       push_addxloop(4) 115    
    exx                 ; 1:4       push_addxloop(4) 115 ( -- ) R:( index -- )
xexit115 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      print
    ld   BC, size122    ; 3:10      print Length of string to print
    ld   DE, string122  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(2,-1) 116
    dec  HL             ; 1:6       xdo(2,-1) 116
    ld  (HL),high -1    ; 2:10      xdo(2,-1) 116
    dec   L             ; 1:4       xdo(2,-1) 116
    ld  (HL),low -1     ; 2:10      xdo(2,-1) 116
    exx                 ; 1:4       xdo(2,-1) 116 R:( -- -1 )
xdo116:                 ;           xdo(2,-1) 116 
    exx                 ; 1:4       index xi 116
    ld    E,(HL)        ; 1:7       index xi 116
    inc   L             ; 1:4       index xi 116
    ld    D,(HL)        ; 1:7       index xi 116
    push DE             ; 1:11      index xi 116
    dec   L             ; 1:4       index xi 116
    exx                 ; 1:4       index xi 116 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 116
    ex  (SP),HL         ; 1:19      index xi 116 ( -- x ) 
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
    exx                 ; 1:4       xleave 116
    inc  L              ; 1:4       xleave 116
    jp   xleave116      ;           xleave 116 
else107  EQU $          ;           = endif
endif107: 
    exx                 ; 1:4       push_addxloop(-1) 116
    ld    E,(HL)        ; 1:7       push_addxloop(-1) 116
    inc   L             ; 1:4       push_addxloop(-1) 116
    ld    D,(HL)        ; 1:7       push_addxloop(-1) 116 DE = index
    push HL             ; 1:11      push_addxloop(-1) 116
    ld   HL, -2         ; 3:10      push_addxloop(-1) 116 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-1) 116 index-stop
    ld   BC, -1         ; 3:10      push_addxloop(-1) 116 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-1) 116 index-stop+step
    jr   nc, xleave116-1; 2:7/12    push_addxloop(-1) 116 -step
    ex   DE, HL         ; 1:4       push_addxloop(-1) 116
    add  HL, BC         ; 1:11      push_addxloop(-1) 116 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-1) 116    
    pop  HL             ; 1:10      push_addxloop(-1) 116
    ld  (HL),D          ; 1:7       push_addxloop(-1) 116
    dec   L             ; 1:4       push_addxloop(-1) 116
    ld  (HL),E          ; 1:7       push_addxloop(-1) 116
    exx                 ; 1:4       push_addxloop(-1) 116    
    jp   xdo116         ; 3:10      push_addxloop(-1) 116 ( -- ) R:( index -- index+-1 )
    pop  HL             ; 1:10      push_addxloop(-1) 116
xleave116:              ;           push_addxloop(-1) 116    
    inc  HL             ; 1:6       push_addxloop(-1) 116    
    exx                 ; 1:4       push_addxloop(-1) 116 ( -- ) R:( index -- )
xexit116 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size124    ; 3:10      print Length of string to print
    ld   DE, string124  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(2,-1) 117
    dec  HL             ; 1:6       xdo(2,-1) 117
    ld  (HL),high -1    ; 2:10      xdo(2,-1) 117
    dec   L             ; 1:4       xdo(2,-1) 117
    ld  (HL),low -1     ; 2:10      xdo(2,-1) 117
    exx                 ; 1:4       xdo(2,-1) 117 R:( -- -1 )
xdo117:                 ;           xdo(2,-1) 117 
    exx                 ; 1:4       index xi 117
    ld    E,(HL)        ; 1:7       index xi 117
    inc   L             ; 1:4       index xi 117
    ld    D,(HL)        ; 1:7       index xi 117
    push DE             ; 1:11      index xi 117
    dec   L             ; 1:4       index xi 117
    exx                 ; 1:4       index xi 117 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 117
    ex  (SP),HL         ; 1:19      index xi 117 ( -- x ) 
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
    exx                 ; 1:4       xleave 117
    inc  L              ; 1:4       xleave 117
    jp   xleave117      ;           xleave 117 
else108  EQU $          ;           = endif
endif108: 
    exx                 ; 1:4       push_addxloop(-2) 117
    ld    E,(HL)        ; 1:7       push_addxloop(-2) 117
    inc   L             ; 1:4       push_addxloop(-2) 117
    ld    D,(HL)        ; 1:7       push_addxloop(-2) 117 DE = index
    push HL             ; 1:11      push_addxloop(-2) 117
    ld   HL, -2         ; 3:10      push_addxloop(-2) 117 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-2) 117 index-stop
    ld   BC, -2         ; 3:10      push_addxloop(-2) 117 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-2) 117 index-stop+step
    jr   nc, xleave117-1; 2:7/12    push_addxloop(-2) 117 -step
    ex   DE, HL         ; 1:4       push_addxloop(-2) 117
    add  HL, BC         ; 1:11      push_addxloop(-2) 117 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-2) 117    
    pop  HL             ; 1:10      push_addxloop(-2) 117
    ld  (HL),D          ; 1:7       push_addxloop(-2) 117
    dec   L             ; 1:4       push_addxloop(-2) 117
    ld  (HL),E          ; 1:7       push_addxloop(-2) 117
    exx                 ; 1:4       push_addxloop(-2) 117    
    jp   xdo117         ; 3:10      push_addxloop(-2) 117 ( -- ) R:( index -- index+-2 )
    pop  HL             ; 1:10      push_addxloop(-2) 117
xleave117:              ;           push_addxloop(-2) 117    
    inc  HL             ; 1:6       push_addxloop(-2) 117    
    exx                 ; 1:4       push_addxloop(-2) 117 ( -- ) R:( index -- )
xexit117 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size126    ; 3:10      print Length of string to print
    ld   DE, string126  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(2,-1) 118
    dec  HL             ; 1:6       xdo(2,-1) 118
    ld  (HL),high -1    ; 2:10      xdo(2,-1) 118
    dec   L             ; 1:4       xdo(2,-1) 118
    ld  (HL),low -1     ; 2:10      xdo(2,-1) 118
    exx                 ; 1:4       xdo(2,-1) 118 R:( -- -1 )
xdo118:                 ;           xdo(2,-1) 118 
    exx                 ; 1:4       index xi 118
    ld    E,(HL)        ; 1:7       index xi 118
    inc   L             ; 1:4       index xi 118
    ld    D,(HL)        ; 1:7       index xi 118
    push DE             ; 1:11      index xi 118
    dec   L             ; 1:4       index xi 118
    exx                 ; 1:4       index xi 118 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 118
    ex  (SP),HL         ; 1:19      index xi 118 ( -- x ) 
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
    exx                 ; 1:4       xleave 118
    inc  L              ; 1:4       xleave 118
    jp   xleave118      ;           xleave 118 
else109  EQU $          ;           = endif
endif109: 
    exx                 ; 1:4       push_addxloop(-4) 118
    ld    E,(HL)        ; 1:7       push_addxloop(-4) 118
    inc   L             ; 1:4       push_addxloop(-4) 118
    ld    D,(HL)        ; 1:7       push_addxloop(-4) 118 DE = index
    push HL             ; 1:11      push_addxloop(-4) 118
    ld   HL, -2         ; 3:10      push_addxloop(-4) 118 HL = -stop
    add  HL, DE         ; 1:11      push_addxloop(-4) 118 index-stop
    ld   BC, -4         ; 3:10      push_addxloop(-4) 118 BC = step
    add  HL, BC         ; 1:11      push_addxloop(-4) 118 index-stop+step
    jr   nc, xleave118-1; 2:7/12    push_addxloop(-4) 118 -step
    ex   DE, HL         ; 1:4       push_addxloop(-4) 118
    add  HL, BC         ; 1:11      push_addxloop(-4) 118 index+step
    ex   DE, HL         ; 1:4       push_addxloop(-4) 118    
    pop  HL             ; 1:10      push_addxloop(-4) 118
    ld  (HL),D          ; 1:7       push_addxloop(-4) 118
    dec   L             ; 1:4       push_addxloop(-4) 118
    ld  (HL),E          ; 1:7       push_addxloop(-4) 118
    exx                 ; 1:4       push_addxloop(-4) 118    
    jp   xdo118         ; 3:10      push_addxloop(-4) 118 ( -- ) R:( index -- index+-4 )
    pop  HL             ; 1:10      push_addxloop(-4) 118
xleave118:              ;           push_addxloop(-4) 118    
    inc  HL             ; 1:6       push_addxloop(-4) 118    
    exx                 ; 1:4       push_addxloop(-4) 118 ( -- ) R:( index -- )
xexit118 EQU $ 
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
    exx                 ; 1:4       index xi 119
    ld    E,(HL)        ; 1:7       index xi 119
    inc   L             ; 1:4       index xi 119
    ld    D,(HL)        ; 1:7       index xi 119
    push DE             ; 1:11      index xi 119
    dec   L             ; 1:4       index xi 119
    exx                 ; 1:4       index xi 119 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 119
    ex  (SP),HL         ; 1:19      index xi 119 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       xloop(-1,-1) 119
    ld    E,(HL)        ; 1:7       xloop(-1,-1) 119
    inc   L             ; 1:4       xloop(-1,-1) 119
    ld    D,(HL)        ; 1:7       xloop(-1,-1) 119
    inc  DE             ; 1:6       xloop(-1,-1) 119 index++
    ld    A, low -1     ; 2:7       xloop(-1,-1) 119
    xor   E             ; 1:4       xloop(-1,-1) 119
    ld    C, A          ; 1:4       xloop(-1,-1) 119
    ld    A, high -1    ; 2:7       xloop(-1,-1) 119
    xor   D             ; 1:4       xloop(-1,-1) 119
    or    C             ; 1:4       xloop(-1,-1) 119
    jr    z, xleave119  ; 2:7/12    xloop(-1,-1) 119 exit
    ld  (HL), D         ; 1:7       xloop(-1,-1) 119
    dec   L             ; 1:4       xloop(-1,-1) 119
    ld  (HL), E         ; 1:6       xloop(-1,-1) 119
    exx                 ; 1:4       xloop(-1,-1) 119
    jp   xdo119         ; 3:10      xloop(-1,-1) 119
xleave119:              ;           xloop(-1,-1) 119
    inc  HL             ; 1:6       xloop(-1,-1) 119
    exx                 ; 1:4       xloop(-1,-1) 119 R:( index -- )
xexit119 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size129    ; 3:10      print Length of string to print
    ld   DE, string129  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    jp   xexit120       ; 3:10      ?xdo(1,1) 120
xdo120:                 ;           ?xdo(1,1) 120 
    exx                 ; 1:4       index xi 120
    ld    E,(HL)        ; 1:7       index xi 120
    inc   L             ; 1:4       index xi 120
    ld    D,(HL)        ; 1:7       index xi 120
    push DE             ; 1:11      index xi 120
    dec   L             ; 1:4       index xi 120
    exx                 ; 1:4       index xi 120 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 120
    ex  (SP),HL         ; 1:19      index xi 120 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       xloop(1,1) 120
    ld    E,(HL)        ; 1:7       xloop(1,1) 120
    inc   L             ; 1:4       xloop(1,1) 120
    ld    D,(HL)        ; 1:7       xloop(1,1) 120
    inc  DE             ; 1:6       xloop(1,1) 120 index++
    ld    A, low 1      ; 2:7       xloop(1,1) 120
    xor   E             ; 1:4       xloop(1,1) 120
    ld    C, A          ; 1:4       xloop(1,1) 120
    ld    A, high 1     ; 2:7       xloop(1,1) 120
    xor   D             ; 1:4       xloop(1,1) 120
    or    C             ; 1:4       xloop(1,1) 120
    jr    z, xleave120  ; 2:7/12    xloop(1,1) 120 exit
    ld  (HL), D         ; 1:7       xloop(1,1) 120
    dec   L             ; 1:4       xloop(1,1) 120
    ld  (HL), E         ; 1:6       xloop(1,1) 120
    exx                 ; 1:4       xloop(1,1) 120
    jp   xdo120         ; 3:10      xloop(1,1) 120
xleave120:              ;           xloop(1,1) 120
    inc  HL             ; 1:6       xloop(1,1) 120
    exx                 ; 1:4       xloop(1,1) 120 R:( index -- )
xexit120 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size130    ; 3:10      print Length of string to print
    ld   DE, string130  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(2,-1) 121
    dec  HL             ; 1:6       xdo(2,-1) 121
    ld  (HL),high -1    ; 2:10      xdo(2,-1) 121
    dec   L             ; 1:4       xdo(2,-1) 121
    ld  (HL),low -1     ; 2:10      xdo(2,-1) 121
    exx                 ; 1:4       xdo(2,-1) 121 R:( -- -1 )
xdo121:                 ;           xdo(2,-1) 121 
    exx                 ; 1:4       index xi 121
    ld    E,(HL)        ; 1:7       index xi 121
    inc   L             ; 1:4       index xi 121
    ld    D,(HL)        ; 1:7       index xi 121
    push DE             ; 1:11      index xi 121
    dec   L             ; 1:4       index xi 121
    exx                 ; 1:4       index xi 121 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 121
    ex  (SP),HL         ; 1:19      index xi 121 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       xloop(2,-1) 121
    ld    E,(HL)        ; 1:7       xloop(2,-1) 121
    inc   L             ; 1:4       xloop(2,-1) 121
    ld    D,(HL)        ; 1:7       xloop(2,-1) 121
    inc  DE             ; 1:6       xloop(2,-1) 121 index++
    ld    A, low 2      ; 2:7       xloop(2,-1) 121
    xor   E             ; 1:4       xloop(2,-1) 121
    ld    C, A          ; 1:4       xloop(2,-1) 121
    ld    A, high 2     ; 2:7       xloop(2,-1) 121
    xor   D             ; 1:4       xloop(2,-1) 121
    or    C             ; 1:4       xloop(2,-1) 121
    jr    z, xleave121  ; 2:7/12    xloop(2,-1) 121 exit
    ld  (HL), D         ; 1:7       xloop(2,-1) 121
    dec   L             ; 1:4       xloop(2,-1) 121
    ld  (HL), E         ; 1:6       xloop(2,-1) 121
    exx                 ; 1:4       xloop(2,-1) 121
    jp   xdo121         ; 3:10      xloop(2,-1) 121
xleave121:              ;           xloop(2,-1) 121
    inc  HL             ; 1:6       xloop(2,-1) 121
    exx                 ; 1:4       xloop(2,-1) 121 R:( index -- )
xexit121 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size131    ; 3:10      print Length of string to print
    ld   DE, string131  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 

    exx                 ; 1:4       xdo(-1,-5) 122
    dec  HL             ; 1:6       xdo(-1,-5) 122
    ld  (HL),high -5    ; 2:10      xdo(-1,-5) 122
    dec   L             ; 1:4       xdo(-1,-5) 122
    ld  (HL),low -5     ; 2:10      xdo(-1,-5) 122
    exx                 ; 1:4       xdo(-1,-5) 122 R:( -- -5 )
xdo122:                 ;           xdo(-1,-5) 122 
    exx                 ; 1:4       index xi 122
    ld    E,(HL)        ; 1:7       index xi 122
    inc   L             ; 1:4       index xi 122
    ld    D,(HL)        ; 1:7       index xi 122
    push DE             ; 1:11      index xi 122
    dec   L             ; 1:4       index xi 122
    exx                 ; 1:4       index xi 122 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 122
    ex  (SP),HL         ; 1:19      index xi 122 ( -- x ) 
    call PRINT_S16      ; 3:17      . 
    exx                 ; 1:4       xloop(-1,-5) 122
    ld    E,(HL)        ; 1:7       xloop(-1,-5) 122
    inc   L             ; 1:4       xloop(-1,-5) 122
    ld    D,(HL)        ; 1:7       xloop(-1,-5) 122
    inc  DE             ; 1:6       xloop(-1,-5) 122 index++
    ld    A, low -1     ; 2:7       xloop(-1,-5) 122
    xor   E             ; 1:4       xloop(-1,-5) 122
    ld    C, A          ; 1:4       xloop(-1,-5) 122
    ld    A, high -1    ; 2:7       xloop(-1,-5) 122
    xor   D             ; 1:4       xloop(-1,-5) 122
    or    C             ; 1:4       xloop(-1,-5) 122
    jr    z, xleave122  ; 2:7/12    xloop(-1,-5) 122 exit
    ld  (HL), D         ; 1:7       xloop(-1,-5) 122
    dec   L             ; 1:4       xloop(-1,-5) 122
    ld  (HL), E         ; 1:6       xloop(-1,-5) 122
    exx                 ; 1:4       xloop(-1,-5) 122
    jp   xdo122         ; 3:10      xloop(-1,-5) 122
xleave122:              ;           xloop(-1,-5) 122
    inc  HL             ; 1:6       xloop(-1,-5) 122
    exx                 ; 1:4       xloop(-1,-5) 122 R:( index -- )
xexit122 EQU $ 
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

    exx                 ; 1:4       xdo(-1,1) 123
    dec  HL             ; 1:6       xdo(-1,1) 123
    ld  (HL),high 1     ; 2:10      xdo(-1,1) 123
    dec   L             ; 1:4       xdo(-1,1) 123
    ld  (HL),low 1      ; 2:10      xdo(-1,1) 123
    exx                 ; 1:4       xdo(-1,1) 123 R:( -- 1 )
xdo123:                 ;           xdo(-1,1) 123 
    exx                 ; 1:4       index xi 123
    ld    E,(HL)        ; 1:7       index xi 123
    inc   L             ; 1:4       index xi 123
    ld    D,(HL)        ; 1:7       index xi 123
    push DE             ; 1:11      index xi 123
    dec   L             ; 1:4       index xi 123
    exx                 ; 1:4       index xi 123 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 123
    ex  (SP),HL         ; 1:19      index xi 123 ( -- x ) 
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
    exx                 ; 1:4       xleave 123
    inc  L              ; 1:4       xleave 123
    jp   xleave123      ;           xleave 123 
else110  EQU $          ;           = endif
endif110: 
    exx                 ; 1:4       xloop(-1,1) 123
    ld    E,(HL)        ; 1:7       xloop(-1,1) 123
    inc   L             ; 1:4       xloop(-1,1) 123
    ld    D,(HL)        ; 1:7       xloop(-1,1) 123
    inc  DE             ; 1:6       xloop(-1,1) 123 index++
    ld    A, low -1     ; 2:7       xloop(-1,1) 123
    xor   E             ; 1:4       xloop(-1,1) 123
    ld    C, A          ; 1:4       xloop(-1,1) 123
    ld    A, high -1    ; 2:7       xloop(-1,1) 123
    xor   D             ; 1:4       xloop(-1,1) 123
    or    C             ; 1:4       xloop(-1,1) 123
    jr    z, xleave123  ; 2:7/12    xloop(-1,1) 123 exit
    ld  (HL), D         ; 1:7       xloop(-1,1) 123
    dec   L             ; 1:4       xloop(-1,1) 123
    ld  (HL), E         ; 1:6       xloop(-1,1) 123
    exx                 ; 1:4       xloop(-1,1) 123
    jp   xdo123         ; 3:10      xloop(-1,1) 123
xleave123:              ;           xloop(-1,1) 123
    inc  HL             ; 1:6       xloop(-1,1) 123
    exx                 ; 1:4       xloop(-1,1) 123 R:( index -- )
xexit123 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

    push DE             ; 1:11      print
    ld   BC, size134    ; 3:10      print Length of string to print
    ld   DE, string134  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    ld   BC, 5          ; 3:10      push2_store(5,_stop)
    ld   (_stop), BC    ; 4:20      push2_store(5,_stop) 

    exx                 ; 1:4       xdo(0,0) 124
    dec  HL             ; 1:6       xdo(0,0) 124
    ld  (HL),high 0     ; 2:10      xdo(0,0) 124
    dec   L             ; 1:4       xdo(0,0) 124
    ld  (HL),low 0      ; 2:10      xdo(0,0) 124
    exx                 ; 1:4       xdo(0,0) 124 R:( -- 0 )
xdo124:                 ;           xdo(0,0) 124 
    exx                 ; 1:4       index xi 124
    ld    E,(HL)        ; 1:7       index xi 124
    inc   L             ; 1:4       index xi 124
    ld    D,(HL)        ; 1:7       index xi 124
    push DE             ; 1:11      index xi 124
    dec   L             ; 1:4       index xi 124
    exx                 ; 1:4       index xi 124 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 124
    ex  (SP),HL         ; 1:19      index xi 124 ( -- x ) 
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
    exx                 ; 1:4       xleave 124
    inc  L              ; 1:4       xleave 124
    jp   xleave124      ;           xleave 124 
else111  EQU $          ;           = endif
endif111: 
    exx                 ; 1:4       xloop(0,0) 124
    ld    E,(HL)        ; 1:7       xloop(0,0) 124
    inc   L             ; 1:4       xloop(0,0) 124
    ld    D,(HL)        ; 1:7       xloop(0,0) 124
    inc  DE             ; 1:6       xloop(0,0) 124 index++
    ld    A, low 0      ; 2:7       xloop(0,0) 124
    xor   E             ; 1:4       xloop(0,0) 124
    ld    C, A          ; 1:4       xloop(0,0) 124
    ld    A, high 0     ; 2:7       xloop(0,0) 124
    xor   D             ; 1:4       xloop(0,0) 124
    or    C             ; 1:4       xloop(0,0) 124
    jr    z, xleave124  ; 2:7/12    xloop(0,0) 124 exit
    ld  (HL), D         ; 1:7       xloop(0,0) 124
    dec   L             ; 1:4       xloop(0,0) 124
    ld  (HL), E         ; 1:6       xloop(0,0) 124
    exx                 ; 1:4       xloop(0,0) 124
    jp   xdo124         ; 3:10      xloop(0,0) 124
xleave124:              ;           xloop(0,0) 124
    inc  HL             ; 1:6       xloop(0,0) 124
    exx                 ; 1:4       xloop(0,0) 124 R:( index -- )
xexit124 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====


;   ---  b e g i n  ---
_down1:                 ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
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
    
    push HL             ; 1:11      do 125 index
    push DE             ; 1:11      do 125 stop
    exx                 ; 1:4       do 125
    pop  DE             ; 1:10      do 125 stop
    dec  HL             ; 1:6       do 125
    ld  (HL),D          ; 1:7       do 125
    dec  L              ; 1:4       do 125
    ld  (HL),E          ; 1:7       do 125 stop
    pop  DE             ; 1:10      do 125 index
    dec  HL             ; 1:6       do 125
    ld  (HL),D          ; 1:7       do 125
    dec  L              ; 1:4       do 125
    ld  (HL),E          ; 1:7       do 125 index
    exx                 ; 1:4       do 125
    pop  HL             ; 1:10      do 125
    pop  DE             ; 1:10      do 125 ( stop index -- ) R: ( -- stop index )
do125: 
    exx                 ; 1:4       index 125 i    
    ld    E,(HL)        ; 1:7       index 125 i
    inc   L             ; 1:4       index 125 i
    ld    D,(HL)        ; 1:7       index 125 i
    push DE             ; 1:11      index 125 i
    dec   L             ; 1:4       index 125 i
    exx                 ; 1:4       index 125 i
    ex   DE, HL         ; 1:4       index 125 i
    ex  (SP),HL         ; 1:19      index 125 i 
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
    exx                 ; 1:4       leave 125
    inc  L              ; 1:4       leave 125
    inc  HL             ; 1:6       leave 125
    inc  L              ; 1:4       leave 125
    jp   leave125       ;           leave 125 
else112  EQU $          ;           = endif
endif112: 
    
    push DE             ; 1:11      push(-1)
    ex   DE, HL         ; 1:4       push(-1)
    ld   HL, -1         ; 3:10      push(-1) 
    ex  (SP),HL         ; 1:19      +loop 125
    ex   DE, HL         ; 1:4       +loop 125
    exx                 ; 1:4       +loop 125
    ld    E,(HL)        ; 1:7       +loop 125
    inc   L             ; 1:4       +loop 125
    ld    D,(HL)        ; 1:7       +loop 125 DE = index
    inc  HL             ; 1:6       +loop 125
    ld    C,(HL)        ; 1:7       +loop 125
    inc   L             ; 1:4       +loop 125
    ld    B,(HL)        ; 1:7       +loop 125 BC = stop
    ex  (SP),HL         ; 1:19      +loop 125 HL = step
    ex   DE, HL         ; 1:4       +loop 125
    xor   A             ; 1:4       +loop 125
    sbc  HL, BC         ; 2:15      +loop 125 HL = index-stop
    ld    A, H          ; 1:4       +loop 125
    add  HL, DE         ; 1:11      +loop 125 HL = index-stop+step
    xor   H             ; 1:4       +loop 125
    add  HL, BC         ; 1:11      +loop 125 HL = index+step
    ex   DE, HL         ; 1:4       +loop 125
    pop  HL             ; 1:10      +loop 125
    jp    m, leave125   ; 3:10      +loop 125
    dec   L             ; 1:4       +loop 125    
    dec  HL             ; 1:6       +loop 125
    ld  (HL),D          ; 1:7       +loop 125    
    dec   L             ; 1:4       +loop 125
    ld  (HL),E          ; 1:7       +loop 125
    exx                 ; 1:4       +loop 125
    jp    p, do125      ; 3:10      +loop 125 ( step -- ) R:( stop index -- stop index+step )
leave125:               ;           +loop 125
    inc  HL             ; 1:6       +loop 125
    exx                 ; 1:4       +loop 125 ( step -- ) R:( stop index -- )
exit125 EQU $ 
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
    
    push HL             ; 1:11      do 126 index
    push DE             ; 1:11      do 126 stop
    exx                 ; 1:4       do 126
    pop  DE             ; 1:10      do 126 stop
    dec  HL             ; 1:6       do 126
    ld  (HL),D          ; 1:7       do 126
    dec  L              ; 1:4       do 126
    ld  (HL),E          ; 1:7       do 126 stop
    pop  DE             ; 1:10      do 126 index
    dec  HL             ; 1:6       do 126
    ld  (HL),D          ; 1:7       do 126
    dec  L              ; 1:4       do 126
    ld  (HL),E          ; 1:7       do 126 index
    exx                 ; 1:4       do 126
    pop  HL             ; 1:10      do 126
    pop  DE             ; 1:10      do 126 ( stop index -- ) R: ( -- stop index )
do126: 
    exx                 ; 1:4       index 126 i    
    ld    E,(HL)        ; 1:7       index 126 i
    inc   L             ; 1:4       index 126 i
    ld    D,(HL)        ; 1:7       index 126 i
    push DE             ; 1:11      index 126 i
    dec   L             ; 1:4       index 126 i
    exx                 ; 1:4       index 126 i
    ex   DE, HL         ; 1:4       index 126 i
    ex  (SP),HL         ; 1:19      index 126 i 
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
    exx                 ; 1:4       leave 126
    inc  L              ; 1:4       leave 126
    inc  HL             ; 1:6       leave 126
    inc  L              ; 1:4       leave 126
    jp   leave126       ;           leave 126 
else113  EQU $          ;           = endif
endif113: 
    
    exx                 ; 1:4       push_addloop(-1) 126
    ld   BC, -1         ; 3:10      push_addloop(-1) 126 BC = step
    ld    E,(HL)        ; 1:7       push_addloop(-1) 126
    ld    A, E          ; 1:4       push_addloop(-1) 126
    add   A, C          ; 1:4       push_addloop(-1) 126
    ld  (HL),A          ; 1:7       push_addloop(-1) 126
    inc   L             ; 1:4       push_addloop(-1) 126
    ld    D,(HL)        ; 1:7       push_addloop(-1) 126 DE = index
    ld    A, D          ; 1:4       push_addloop(-1) 126
    adc   A, B          ; 1:4       push_addloop(-1) 126
    ld  (HL),A          ; 1:7       push_addloop(-1) 126
    inc  HL             ; 1:6       push_addloop(-1) 126
    ld    A, E          ; 1:4       push_addloop(-1) 126    
    sub (HL)            ; 1:7       push_addloop(-1) 126
    ld    E, A          ; 1:4       push_addloop(-1) 126    
    inc   L             ; 1:4       push_addloop(-1) 126
    ld    A, D          ; 1:4       push_addloop(-1) 126    
    sbc   A,(HL)        ; 1:7       push_addloop(-1) 126
    ld    D, A          ; 1:4       push_addloop(-1) 126 DE = index-stop
    ld    A, E          ; 1:4       push_addloop(-1) 126    
    add   A, C          ; 1:4       push_addloop(-1) 126
    ld    A, D          ; 1:4       push_addloop(-1) 126    
    adc   A, B          ; 1:4       push_addloop(-1) 126
    xor   D             ; 1:4       push_addloop(-1) 126
    jp    m, $+10       ; 3:10      push_addloop(-1) 126
    dec   L             ; 1:4       push_addloop(-1) 126    
    dec  HL             ; 1:6       push_addloop(-1) 126
    dec   L             ; 1:4       push_addloop(-1) 126
    exx                 ; 1:4       push_addloop(-1) 126
    jp    p, do126      ; 3:10      push_addloop(-1) 126 ( -- ) R:( stop index -- stop index+-1 )
leave126:               ;           push_addloop(-1) 126
    inc  HL             ; 1:6       push_addloop(-1) 126
    exx                 ; 1:4       push_addloop(-1) 126 ( -- ) R:( stop index -- )
exit126 EQU $ 
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
sexit127 EQU $ 
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
    
    ld   BC, -1         ; 3:10      push_addsloop(-1) 128 BC = step
    or    A             ; 1:4       push_addsloop(-1) 128
    sbc  HL, DE         ; 2:15      push_addsloop(-1) 128 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(-1) 128
    add  HL, BC         ; 1:11      push_addsloop(-1) 128 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(-1) 128 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(-1) 128 HL = index+step, sign flag unaffected
    jp    p, sdo128     ; 3:10      push_addsloop(-1) 128
sleave128:              ;           push_addsloop(-1) 128
    pop  HL             ; 1:10      unsloop 128 index out
    pop  DE             ; 1:10      unsloop 128 stop  out
sexit128 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_down1_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


;   ---  b e g i n  ---
_up1:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret ) 
    
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
    
    push HL             ; 1:11      do 129 index
    push DE             ; 1:11      do 129 stop
    exx                 ; 1:4       do 129
    pop  DE             ; 1:10      do 129 stop
    dec  HL             ; 1:6       do 129
    ld  (HL),D          ; 1:7       do 129
    dec  L              ; 1:4       do 129
    ld  (HL),E          ; 1:7       do 129 stop
    pop  DE             ; 1:10      do 129 index
    dec  HL             ; 1:6       do 129
    ld  (HL),D          ; 1:7       do 129
    dec  L              ; 1:4       do 129
    ld  (HL),E          ; 1:7       do 129 index
    exx                 ; 1:4       do 129
    pop  HL             ; 1:10      do 129
    pop  DE             ; 1:10      do 129 ( stop index -- ) R: ( -- stop index )
do129: 
    exx                 ; 1:4       index 129 i    
    ld    E,(HL)        ; 1:7       index 129 i
    inc   L             ; 1:4       index 129 i
    ld    D,(HL)        ; 1:7       index 129 i
    push DE             ; 1:11      index 129 i
    dec   L             ; 1:4       index 129 i
    exx                 ; 1:4       index 129 i
    ex   DE, HL         ; 1:4       index 129 i
    ex  (SP),HL         ; 1:19      index 129 i 
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
    exx                 ; 1:4       leave 129
    inc  L              ; 1:4       leave 129
    inc  HL             ; 1:6       leave 129
    inc  L              ; 1:4       leave 129
    jp   leave129       ;           leave 129 
else116  EQU $          ;           = endif
endif116: 
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ex  (SP),HL         ; 1:19      +loop 129
    ex   DE, HL         ; 1:4       +loop 129
    exx                 ; 1:4       +loop 129
    ld    E,(HL)        ; 1:7       +loop 129
    inc   L             ; 1:4       +loop 129
    ld    D,(HL)        ; 1:7       +loop 129 DE = index
    inc  HL             ; 1:6       +loop 129
    ld    C,(HL)        ; 1:7       +loop 129
    inc   L             ; 1:4       +loop 129
    ld    B,(HL)        ; 1:7       +loop 129 BC = stop
    ex  (SP),HL         ; 1:19      +loop 129 HL = step
    ex   DE, HL         ; 1:4       +loop 129
    xor   A             ; 1:4       +loop 129
    sbc  HL, BC         ; 2:15      +loop 129 HL = index-stop
    ld    A, H          ; 1:4       +loop 129
    add  HL, DE         ; 1:11      +loop 129 HL = index-stop+step
    xor   H             ; 1:4       +loop 129
    add  HL, BC         ; 1:11      +loop 129 HL = index+step
    ex   DE, HL         ; 1:4       +loop 129
    pop  HL             ; 1:10      +loop 129
    jp    m, leave129   ; 3:10      +loop 129
    dec   L             ; 1:4       +loop 129    
    dec  HL             ; 1:6       +loop 129
    ld  (HL),D          ; 1:7       +loop 129    
    dec   L             ; 1:4       +loop 129
    ld  (HL),E          ; 1:7       +loop 129
    exx                 ; 1:4       +loop 129
    jp    p, do129      ; 3:10      +loop 129 ( step -- ) R:( stop index -- stop index+step )
leave129:               ;           +loop 129
    inc  HL             ; 1:6       +loop 129
    exx                 ; 1:4       +loop 129 ( step -- ) R:( stop index -- )
exit129 EQU $ 
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
    
    push HL             ; 1:11      do 130 index
    push DE             ; 1:11      do 130 stop
    exx                 ; 1:4       do 130
    pop  DE             ; 1:10      do 130 stop
    dec  HL             ; 1:6       do 130
    ld  (HL),D          ; 1:7       do 130
    dec  L              ; 1:4       do 130
    ld  (HL),E          ; 1:7       do 130 stop
    pop  DE             ; 1:10      do 130 index
    dec  HL             ; 1:6       do 130
    ld  (HL),D          ; 1:7       do 130
    dec  L              ; 1:4       do 130
    ld  (HL),E          ; 1:7       do 130 index
    exx                 ; 1:4       do 130
    pop  HL             ; 1:10      do 130
    pop  DE             ; 1:10      do 130 ( stop index -- ) R: ( -- stop index )
do130: 
    exx                 ; 1:4       index 130 i    
    ld    E,(HL)        ; 1:7       index 130 i
    inc   L             ; 1:4       index 130 i
    ld    D,(HL)        ; 1:7       index 130 i
    push DE             ; 1:11      index 130 i
    dec   L             ; 1:4       index 130 i
    exx                 ; 1:4       index 130 i
    ex   DE, HL         ; 1:4       index 130 i
    ex  (SP),HL         ; 1:19      index 130 i 
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
    exx                 ; 1:4       leave 130
    inc  L              ; 1:4       leave 130
    inc  HL             ; 1:6       leave 130
    inc  L              ; 1:4       leave 130
    jp   leave130       ;           leave 130 
else117  EQU $          ;           = endif
endif117: 
    
                        ;           push_addloop(1) 130
    exx                 ; 1:4       loop 130
    ld    E,(HL)        ; 1:7       loop 130
    inc   L             ; 1:4       loop 130
    ld    D,(HL)        ; 1:7       loop 130 DE = index   
    inc  HL             ; 1:6       loop 130
    inc  DE             ; 1:6       loop 130 index + 1
    ld    A,(HL)        ; 1:4       loop 130
    xor   E             ; 1:4       loop 130 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 130
    ld    A, D          ; 1:4       loop 130
    inc   L             ; 1:4       loop 130
    xor (HL)            ; 1:7       loop 130 hi index - stop
    jr    z, leave130   ; 2:7/12    loop 130 exit    
    dec   L             ; 1:4       loop 130
    dec  HL             ; 1:6       loop 130
    ld  (HL), D         ; 1:7       loop 130
    dec   L             ; 1:4       loop 130
    ld  (HL), E         ; 1:7       loop 130
    exx                 ; 1:4       loop 130
    jp   do130          ; 3:10      loop 130
leave130:
    inc  HL             ; 1:6       loop 130
    exx                 ; 1:4       loop 130
exit130 EQU $ 
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
sexit131 EQU $ 
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
sexit132 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_up1_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


;   ---  b e g i n  ---
_down2:                 ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
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
    
    push HL             ; 1:11      do 133 index
    push DE             ; 1:11      do 133 stop
    exx                 ; 1:4       do 133
    pop  DE             ; 1:10      do 133 stop
    dec  HL             ; 1:6       do 133
    ld  (HL),D          ; 1:7       do 133
    dec  L              ; 1:4       do 133
    ld  (HL),E          ; 1:7       do 133 stop
    pop  DE             ; 1:10      do 133 index
    dec  HL             ; 1:6       do 133
    ld  (HL),D          ; 1:7       do 133
    dec  L              ; 1:4       do 133
    ld  (HL),E          ; 1:7       do 133 index
    exx                 ; 1:4       do 133
    pop  HL             ; 1:10      do 133
    pop  DE             ; 1:10      do 133 ( stop index -- ) R: ( -- stop index )
do133: 
    exx                 ; 1:4       index 133 i    
    ld    E,(HL)        ; 1:7       index 133 i
    inc   L             ; 1:4       index 133 i
    ld    D,(HL)        ; 1:7       index 133 i
    push DE             ; 1:11      index 133 i
    dec   L             ; 1:4       index 133 i
    exx                 ; 1:4       index 133 i
    ex   DE, HL         ; 1:4       index 133 i
    ex  (SP),HL         ; 1:19      index 133 i 
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
    exx                 ; 1:4       leave 133
    inc  L              ; 1:4       leave 133
    inc  HL             ; 1:6       leave 133
    inc  L              ; 1:4       leave 133
    jp   leave133       ;           leave 133 
else120  EQU $          ;           = endif
endif120: 
    
    push DE             ; 1:11      push(-2)
    ex   DE, HL         ; 1:4       push(-2)
    ld   HL, -2         ; 3:10      push(-2) 
    ex  (SP),HL         ; 1:19      +loop 133
    ex   DE, HL         ; 1:4       +loop 133
    exx                 ; 1:4       +loop 133
    ld    E,(HL)        ; 1:7       +loop 133
    inc   L             ; 1:4       +loop 133
    ld    D,(HL)        ; 1:7       +loop 133 DE = index
    inc  HL             ; 1:6       +loop 133
    ld    C,(HL)        ; 1:7       +loop 133
    inc   L             ; 1:4       +loop 133
    ld    B,(HL)        ; 1:7       +loop 133 BC = stop
    ex  (SP),HL         ; 1:19      +loop 133 HL = step
    ex   DE, HL         ; 1:4       +loop 133
    xor   A             ; 1:4       +loop 133
    sbc  HL, BC         ; 2:15      +loop 133 HL = index-stop
    ld    A, H          ; 1:4       +loop 133
    add  HL, DE         ; 1:11      +loop 133 HL = index-stop+step
    xor   H             ; 1:4       +loop 133
    add  HL, BC         ; 1:11      +loop 133 HL = index+step
    ex   DE, HL         ; 1:4       +loop 133
    pop  HL             ; 1:10      +loop 133
    jp    m, leave133   ; 3:10      +loop 133
    dec   L             ; 1:4       +loop 133    
    dec  HL             ; 1:6       +loop 133
    ld  (HL),D          ; 1:7       +loop 133    
    dec   L             ; 1:4       +loop 133
    ld  (HL),E          ; 1:7       +loop 133
    exx                 ; 1:4       +loop 133
    jp    p, do133      ; 3:10      +loop 133 ( step -- ) R:( stop index -- stop index+step )
leave133:               ;           +loop 133
    inc  HL             ; 1:6       +loop 133
    exx                 ; 1:4       +loop 133 ( step -- ) R:( stop index -- )
exit133 EQU $ 
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
    
    push HL             ; 1:11      do 134 index
    push DE             ; 1:11      do 134 stop
    exx                 ; 1:4       do 134
    pop  DE             ; 1:10      do 134 stop
    dec  HL             ; 1:6       do 134
    ld  (HL),D          ; 1:7       do 134
    dec  L              ; 1:4       do 134
    ld  (HL),E          ; 1:7       do 134 stop
    pop  DE             ; 1:10      do 134 index
    dec  HL             ; 1:6       do 134
    ld  (HL),D          ; 1:7       do 134
    dec  L              ; 1:4       do 134
    ld  (HL),E          ; 1:7       do 134 index
    exx                 ; 1:4       do 134
    pop  HL             ; 1:10      do 134
    pop  DE             ; 1:10      do 134 ( stop index -- ) R: ( -- stop index )
do134: 
    exx                 ; 1:4       index 134 i    
    ld    E,(HL)        ; 1:7       index 134 i
    inc   L             ; 1:4       index 134 i
    ld    D,(HL)        ; 1:7       index 134 i
    push DE             ; 1:11      index 134 i
    dec   L             ; 1:4       index 134 i
    exx                 ; 1:4       index 134 i
    ex   DE, HL         ; 1:4       index 134 i
    ex  (SP),HL         ; 1:19      index 134 i 
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
    exx                 ; 1:4       leave 134
    inc  L              ; 1:4       leave 134
    inc  HL             ; 1:6       leave 134
    inc  L              ; 1:4       leave 134
    jp   leave134       ;           leave 134 
else121  EQU $          ;           = endif
endif121: 
    
    exx                 ; 1:4       push_addloop(-2) 134
    ld   BC, -2         ; 3:10      push_addloop(-2) 134 BC = step
    ld    E,(HL)        ; 1:7       push_addloop(-2) 134
    ld    A, E          ; 1:4       push_addloop(-2) 134
    add   A, C          ; 1:4       push_addloop(-2) 134
    ld  (HL),A          ; 1:7       push_addloop(-2) 134
    inc   L             ; 1:4       push_addloop(-2) 134
    ld    D,(HL)        ; 1:7       push_addloop(-2) 134 DE = index
    ld    A, D          ; 1:4       push_addloop(-2) 134
    adc   A, B          ; 1:4       push_addloop(-2) 134
    ld  (HL),A          ; 1:7       push_addloop(-2) 134
    inc  HL             ; 1:6       push_addloop(-2) 134
    ld    A, E          ; 1:4       push_addloop(-2) 134    
    sub (HL)            ; 1:7       push_addloop(-2) 134
    ld    E, A          ; 1:4       push_addloop(-2) 134    
    inc   L             ; 1:4       push_addloop(-2) 134
    ld    A, D          ; 1:4       push_addloop(-2) 134    
    sbc   A,(HL)        ; 1:7       push_addloop(-2) 134
    ld    D, A          ; 1:4       push_addloop(-2) 134 DE = index-stop
    ld    A, E          ; 1:4       push_addloop(-2) 134    
    add   A, C          ; 1:4       push_addloop(-2) 134
    ld    A, D          ; 1:4       push_addloop(-2) 134    
    adc   A, B          ; 1:4       push_addloop(-2) 134
    xor   D             ; 1:4       push_addloop(-2) 134
    jp    m, $+10       ; 3:10      push_addloop(-2) 134
    dec   L             ; 1:4       push_addloop(-2) 134    
    dec  HL             ; 1:6       push_addloop(-2) 134
    dec   L             ; 1:4       push_addloop(-2) 134
    exx                 ; 1:4       push_addloop(-2) 134
    jp    p, do134      ; 3:10      push_addloop(-2) 134 ( -- ) R:( stop index -- stop index+-2 )
leave134:               ;           push_addloop(-2) 134
    inc  HL             ; 1:6       push_addloop(-2) 134
    exx                 ; 1:4       push_addloop(-2) 134 ( -- ) R:( stop index -- )
exit134 EQU $ 
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
sexit135 EQU $ 
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
sexit136 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_down2_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


;   ---  b e g i n  ---
_up2:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
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
    
    push HL             ; 1:11      do 137 index
    push DE             ; 1:11      do 137 stop
    exx                 ; 1:4       do 137
    pop  DE             ; 1:10      do 137 stop
    dec  HL             ; 1:6       do 137
    ld  (HL),D          ; 1:7       do 137
    dec  L              ; 1:4       do 137
    ld  (HL),E          ; 1:7       do 137 stop
    pop  DE             ; 1:10      do 137 index
    dec  HL             ; 1:6       do 137
    ld  (HL),D          ; 1:7       do 137
    dec  L              ; 1:4       do 137
    ld  (HL),E          ; 1:7       do 137 index
    exx                 ; 1:4       do 137
    pop  HL             ; 1:10      do 137
    pop  DE             ; 1:10      do 137 ( stop index -- ) R: ( -- stop index )
do137: 
    exx                 ; 1:4       index 137 i    
    ld    E,(HL)        ; 1:7       index 137 i
    inc   L             ; 1:4       index 137 i
    ld    D,(HL)        ; 1:7       index 137 i
    push DE             ; 1:11      index 137 i
    dec   L             ; 1:4       index 137 i
    exx                 ; 1:4       index 137 i
    ex   DE, HL         ; 1:4       index 137 i
    ex  (SP),HL         ; 1:19      index 137 i 
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
    exx                 ; 1:4       leave 137
    inc  L              ; 1:4       leave 137
    inc  HL             ; 1:6       leave 137
    inc  L              ; 1:4       leave 137
    jp   leave137       ;           leave 137 
else124  EQU $          ;           = endif
endif124: 
    
    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    ex  (SP),HL         ; 1:19      +loop 137
    ex   DE, HL         ; 1:4       +loop 137
    exx                 ; 1:4       +loop 137
    ld    E,(HL)        ; 1:7       +loop 137
    inc   L             ; 1:4       +loop 137
    ld    D,(HL)        ; 1:7       +loop 137 DE = index
    inc  HL             ; 1:6       +loop 137
    ld    C,(HL)        ; 1:7       +loop 137
    inc   L             ; 1:4       +loop 137
    ld    B,(HL)        ; 1:7       +loop 137 BC = stop
    ex  (SP),HL         ; 1:19      +loop 137 HL = step
    ex   DE, HL         ; 1:4       +loop 137
    xor   A             ; 1:4       +loop 137
    sbc  HL, BC         ; 2:15      +loop 137 HL = index-stop
    ld    A, H          ; 1:4       +loop 137
    add  HL, DE         ; 1:11      +loop 137 HL = index-stop+step
    xor   H             ; 1:4       +loop 137
    add  HL, BC         ; 1:11      +loop 137 HL = index+step
    ex   DE, HL         ; 1:4       +loop 137
    pop  HL             ; 1:10      +loop 137
    jp    m, leave137   ; 3:10      +loop 137
    dec   L             ; 1:4       +loop 137    
    dec  HL             ; 1:6       +loop 137
    ld  (HL),D          ; 1:7       +loop 137    
    dec   L             ; 1:4       +loop 137
    ld  (HL),E          ; 1:7       +loop 137
    exx                 ; 1:4       +loop 137
    jp    p, do137      ; 3:10      +loop 137 ( step -- ) R:( stop index -- stop index+step )
leave137:               ;           +loop 137
    inc  HL             ; 1:6       +loop 137
    exx                 ; 1:4       +loop 137 ( step -- ) R:( stop index -- )
exit137 EQU $ 
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
    
    push HL             ; 1:11      do 138 index
    push DE             ; 1:11      do 138 stop
    exx                 ; 1:4       do 138
    pop  DE             ; 1:10      do 138 stop
    dec  HL             ; 1:6       do 138
    ld  (HL),D          ; 1:7       do 138
    dec  L              ; 1:4       do 138
    ld  (HL),E          ; 1:7       do 138 stop
    pop  DE             ; 1:10      do 138 index
    dec  HL             ; 1:6       do 138
    ld  (HL),D          ; 1:7       do 138
    dec  L              ; 1:4       do 138
    ld  (HL),E          ; 1:7       do 138 index
    exx                 ; 1:4       do 138
    pop  HL             ; 1:10      do 138
    pop  DE             ; 1:10      do 138 ( stop index -- ) R: ( -- stop index )
do138: 
    exx                 ; 1:4       index 138 i    
    ld    E,(HL)        ; 1:7       index 138 i
    inc   L             ; 1:4       index 138 i
    ld    D,(HL)        ; 1:7       index 138 i
    push DE             ; 1:11      index 138 i
    dec   L             ; 1:4       index 138 i
    exx                 ; 1:4       index 138 i
    ex   DE, HL         ; 1:4       index 138 i
    ex  (SP),HL         ; 1:19      index 138 i 
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
    exx                 ; 1:4       leave 138
    inc  L              ; 1:4       leave 138
    inc  HL             ; 1:6       leave 138
    inc  L              ; 1:4       leave 138
    jp   leave138       ;           leave 138 
else125  EQU $          ;           = endif
endif125: 
    
                        ;           push_addloop(2) 138
    exx                 ; 1:4       2 +loop 138
    ld    E,(HL)        ; 1:7       2 +loop 138
    inc   L             ; 1:4       2 +loop 138
    ld    D,(HL)        ; 1:7       2 +loop 138 DE = index
    inc  DE             ; 1:6       2 +loop 138
    inc  DE             ; 1:6       2 +loop 138 DE = index+2
    inc  HL             ; 1:6       2 +loop 138
    ld    A, E          ; 1:4       2 +loop 138    
    sub (HL)            ; 1:7       2 +loop 138 lo index+2-stop
    rra                 ; 1:4       2 +loop 138
    add   A, A          ; 1:4       2 +loop 138 and 0xFE with save carry
    jr   nz, $+8        ; 2:7/12    2 +loop 138
    ld    A, D          ; 1:4       2 +loop 138
    inc   L             ; 1:4       2 +loop 138
    sbc   A,(HL)        ; 1:7       2 +loop 138 hi index+2-stop
    jr    z, leave138   ; 2:7/12    2 +loop 138
    dec   L             ; 1:4       2 +loop 138   
    dec  HL             ; 1:6       2 +loop 138
    ld  (HL),D          ; 1:7       2 +loop 138
    dec   L             ; 1:4       2 +loop 138
    ld  (HL),E          ; 1:7       2 +loop 138
    exx                 ; 1:4       2 +loop 138
    jp    p, do138      ; 3:10      2 +loop 138 ( -- ) R:( stop index -- stop index+ )
leave138:
    inc  HL             ; 1:6       2 +loop 138
    exx                 ; 1:4       2 +loop 138
exit138 EQU $ 
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
sexit139 EQU $ 
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
sexit140 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 


_up2_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


;   ---  b e g i n  ---
_down3:                 ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
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
    
    push HL             ; 1:11      do 141 index
    push DE             ; 1:11      do 141 stop
    exx                 ; 1:4       do 141
    pop  DE             ; 1:10      do 141 stop
    dec  HL             ; 1:6       do 141
    ld  (HL),D          ; 1:7       do 141
    dec  L              ; 1:4       do 141
    ld  (HL),E          ; 1:7       do 141 stop
    pop  DE             ; 1:10      do 141 index
    dec  HL             ; 1:6       do 141
    ld  (HL),D          ; 1:7       do 141
    dec  L              ; 1:4       do 141
    ld  (HL),E          ; 1:7       do 141 index
    exx                 ; 1:4       do 141
    pop  HL             ; 1:10      do 141
    pop  DE             ; 1:10      do 141 ( stop index -- ) R: ( -- stop index )
do141: 
    exx                 ; 1:4       index 141 i    
    ld    E,(HL)        ; 1:7       index 141 i
    inc   L             ; 1:4       index 141 i
    ld    D,(HL)        ; 1:7       index 141 i
    push DE             ; 1:11      index 141 i
    dec   L             ; 1:4       index 141 i
    exx                 ; 1:4       index 141 i
    ex   DE, HL         ; 1:4       index 141 i
    ex  (SP),HL         ; 1:19      index 141 i 
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
    exx                 ; 1:4       leave 141
    inc  L              ; 1:4       leave 141
    inc  HL             ; 1:6       leave 141
    inc  L              ; 1:4       leave 141
    jp   leave141       ;           leave 141 
else128  EQU $          ;           = endif
endif128: 
    
    push DE             ; 1:11      push(-3)
    ex   DE, HL         ; 1:4       push(-3)
    ld   HL, -3         ; 3:10      push(-3) 
    ex  (SP),HL         ; 1:19      +loop 141
    ex   DE, HL         ; 1:4       +loop 141
    exx                 ; 1:4       +loop 141
    ld    E,(HL)        ; 1:7       +loop 141
    inc   L             ; 1:4       +loop 141
    ld    D,(HL)        ; 1:7       +loop 141 DE = index
    inc  HL             ; 1:6       +loop 141
    ld    C,(HL)        ; 1:7       +loop 141
    inc   L             ; 1:4       +loop 141
    ld    B,(HL)        ; 1:7       +loop 141 BC = stop
    ex  (SP),HL         ; 1:19      +loop 141 HL = step
    ex   DE, HL         ; 1:4       +loop 141
    xor   A             ; 1:4       +loop 141
    sbc  HL, BC         ; 2:15      +loop 141 HL = index-stop
    ld    A, H          ; 1:4       +loop 141
    add  HL, DE         ; 1:11      +loop 141 HL = index-stop+step
    xor   H             ; 1:4       +loop 141
    add  HL, BC         ; 1:11      +loop 141 HL = index+step
    ex   DE, HL         ; 1:4       +loop 141
    pop  HL             ; 1:10      +loop 141
    jp    m, leave141   ; 3:10      +loop 141
    dec   L             ; 1:4       +loop 141    
    dec  HL             ; 1:6       +loop 141
    ld  (HL),D          ; 1:7       +loop 141    
    dec   L             ; 1:4       +loop 141
    ld  (HL),E          ; 1:7       +loop 141
    exx                 ; 1:4       +loop 141
    jp    p, do141      ; 3:10      +loop 141 ( step -- ) R:( stop index -- stop index+step )
leave141:               ;           +loop 141
    inc  HL             ; 1:6       +loop 141
    exx                 ; 1:4       +loop 141 ( step -- ) R:( stop index -- )
exit141 EQU $ 
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
    
    push HL             ; 1:11      do 142 index
    push DE             ; 1:11      do 142 stop
    exx                 ; 1:4       do 142
    pop  DE             ; 1:10      do 142 stop
    dec  HL             ; 1:6       do 142
    ld  (HL),D          ; 1:7       do 142
    dec  L              ; 1:4       do 142
    ld  (HL),E          ; 1:7       do 142 stop
    pop  DE             ; 1:10      do 142 index
    dec  HL             ; 1:6       do 142
    ld  (HL),D          ; 1:7       do 142
    dec  L              ; 1:4       do 142
    ld  (HL),E          ; 1:7       do 142 index
    exx                 ; 1:4       do 142
    pop  HL             ; 1:10      do 142
    pop  DE             ; 1:10      do 142 ( stop index -- ) R: ( -- stop index )
do142: 
    exx                 ; 1:4       index 142 i    
    ld    E,(HL)        ; 1:7       index 142 i
    inc   L             ; 1:4       index 142 i
    ld    D,(HL)        ; 1:7       index 142 i
    push DE             ; 1:11      index 142 i
    dec   L             ; 1:4       index 142 i
    exx                 ; 1:4       index 142 i
    ex   DE, HL         ; 1:4       index 142 i
    ex  (SP),HL         ; 1:19      index 142 i 
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
    exx                 ; 1:4       leave 142
    inc  L              ; 1:4       leave 142
    inc  HL             ; 1:6       leave 142
    inc  L              ; 1:4       leave 142
    jp   leave142       ;           leave 142 
else129  EQU $          ;           = endif
endif129: 
    
    exx                 ; 1:4       push_addloop(-3) 142
    ld   BC, -3         ; 3:10      push_addloop(-3) 142 BC = step
    ld    E,(HL)        ; 1:7       push_addloop(-3) 142
    ld    A, E          ; 1:4       push_addloop(-3) 142
    add   A, C          ; 1:4       push_addloop(-3) 142
    ld  (HL),A          ; 1:7       push_addloop(-3) 142
    inc   L             ; 1:4       push_addloop(-3) 142
    ld    D,(HL)        ; 1:7       push_addloop(-3) 142 DE = index
    ld    A, D          ; 1:4       push_addloop(-3) 142
    adc   A, B          ; 1:4       push_addloop(-3) 142
    ld  (HL),A          ; 1:7       push_addloop(-3) 142
    inc  HL             ; 1:6       push_addloop(-3) 142
    ld    A, E          ; 1:4       push_addloop(-3) 142    
    sub (HL)            ; 1:7       push_addloop(-3) 142
    ld    E, A          ; 1:4       push_addloop(-3) 142    
    inc   L             ; 1:4       push_addloop(-3) 142
    ld    A, D          ; 1:4       push_addloop(-3) 142    
    sbc   A,(HL)        ; 1:7       push_addloop(-3) 142
    ld    D, A          ; 1:4       push_addloop(-3) 142 DE = index-stop
    ld    A, E          ; 1:4       push_addloop(-3) 142    
    add   A, C          ; 1:4       push_addloop(-3) 142
    ld    A, D          ; 1:4       push_addloop(-3) 142    
    adc   A, B          ; 1:4       push_addloop(-3) 142
    xor   D             ; 1:4       push_addloop(-3) 142
    jp    m, $+10       ; 3:10      push_addloop(-3) 142
    dec   L             ; 1:4       push_addloop(-3) 142    
    dec  HL             ; 1:6       push_addloop(-3) 142
    dec   L             ; 1:4       push_addloop(-3) 142
    exx                 ; 1:4       push_addloop(-3) 142
    jp    p, do142      ; 3:10      push_addloop(-3) 142 ( -- ) R:( stop index -- stop index+-3 )
leave142:               ;           push_addloop(-3) 142
    inc  HL             ; 1:6       push_addloop(-3) 142
    exx                 ; 1:4       push_addloop(-3) 142 ( -- ) R:( stop index -- )
exit142 EQU $ 
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
sexit143 EQU $ 
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
sexit144 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_down3_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


;   ---  b e g i n  ---
_up3:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
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
    
    push HL             ; 1:11      do 145 index
    push DE             ; 1:11      do 145 stop
    exx                 ; 1:4       do 145
    pop  DE             ; 1:10      do 145 stop
    dec  HL             ; 1:6       do 145
    ld  (HL),D          ; 1:7       do 145
    dec  L              ; 1:4       do 145
    ld  (HL),E          ; 1:7       do 145 stop
    pop  DE             ; 1:10      do 145 index
    dec  HL             ; 1:6       do 145
    ld  (HL),D          ; 1:7       do 145
    dec  L              ; 1:4       do 145
    ld  (HL),E          ; 1:7       do 145 index
    exx                 ; 1:4       do 145
    pop  HL             ; 1:10      do 145
    pop  DE             ; 1:10      do 145 ( stop index -- ) R: ( -- stop index )
do145: 
    exx                 ; 1:4       index 145 i    
    ld    E,(HL)        ; 1:7       index 145 i
    inc   L             ; 1:4       index 145 i
    ld    D,(HL)        ; 1:7       index 145 i
    push DE             ; 1:11      index 145 i
    dec   L             ; 1:4       index 145 i
    exx                 ; 1:4       index 145 i
    ex   DE, HL         ; 1:4       index 145 i
    ex  (SP),HL         ; 1:19      index 145 i 
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
    exx                 ; 1:4       leave 145
    inc  L              ; 1:4       leave 145
    inc  HL             ; 1:6       leave 145
    inc  L              ; 1:4       leave 145
    jp   leave145       ;           leave 145 
else132  EQU $          ;           = endif
endif132: 
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    ex  (SP),HL         ; 1:19      +loop 145
    ex   DE, HL         ; 1:4       +loop 145
    exx                 ; 1:4       +loop 145
    ld    E,(HL)        ; 1:7       +loop 145
    inc   L             ; 1:4       +loop 145
    ld    D,(HL)        ; 1:7       +loop 145 DE = index
    inc  HL             ; 1:6       +loop 145
    ld    C,(HL)        ; 1:7       +loop 145
    inc   L             ; 1:4       +loop 145
    ld    B,(HL)        ; 1:7       +loop 145 BC = stop
    ex  (SP),HL         ; 1:19      +loop 145 HL = step
    ex   DE, HL         ; 1:4       +loop 145
    xor   A             ; 1:4       +loop 145
    sbc  HL, BC         ; 2:15      +loop 145 HL = index-stop
    ld    A, H          ; 1:4       +loop 145
    add  HL, DE         ; 1:11      +loop 145 HL = index-stop+step
    xor   H             ; 1:4       +loop 145
    add  HL, BC         ; 1:11      +loop 145 HL = index+step
    ex   DE, HL         ; 1:4       +loop 145
    pop  HL             ; 1:10      +loop 145
    jp    m, leave145   ; 3:10      +loop 145
    dec   L             ; 1:4       +loop 145    
    dec  HL             ; 1:6       +loop 145
    ld  (HL),D          ; 1:7       +loop 145    
    dec   L             ; 1:4       +loop 145
    ld  (HL),E          ; 1:7       +loop 145
    exx                 ; 1:4       +loop 145
    jp    p, do145      ; 3:10      +loop 145 ( step -- ) R:( stop index -- stop index+step )
leave145:               ;           +loop 145
    inc  HL             ; 1:6       +loop 145
    exx                 ; 1:4       +loop 145 ( step -- ) R:( stop index -- )
exit145 EQU $ 
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
    
    push HL             ; 1:11      do 146 index
    push DE             ; 1:11      do 146 stop
    exx                 ; 1:4       do 146
    pop  DE             ; 1:10      do 146 stop
    dec  HL             ; 1:6       do 146
    ld  (HL),D          ; 1:7       do 146
    dec  L              ; 1:4       do 146
    ld  (HL),E          ; 1:7       do 146 stop
    pop  DE             ; 1:10      do 146 index
    dec  HL             ; 1:6       do 146
    ld  (HL),D          ; 1:7       do 146
    dec  L              ; 1:4       do 146
    ld  (HL),E          ; 1:7       do 146 index
    exx                 ; 1:4       do 146
    pop  HL             ; 1:10      do 146
    pop  DE             ; 1:10      do 146 ( stop index -- ) R: ( -- stop index )
do146: 
    exx                 ; 1:4       index 146 i    
    ld    E,(HL)        ; 1:7       index 146 i
    inc   L             ; 1:4       index 146 i
    ld    D,(HL)        ; 1:7       index 146 i
    push DE             ; 1:11      index 146 i
    dec   L             ; 1:4       index 146 i
    exx                 ; 1:4       index 146 i
    ex   DE, HL         ; 1:4       index 146 i
    ex  (SP),HL         ; 1:19      index 146 i 
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
    exx                 ; 1:4       leave 146
    inc  L              ; 1:4       leave 146
    inc  HL             ; 1:6       leave 146
    inc  L              ; 1:4       leave 146
    jp   leave146       ;           leave 146 
else133  EQU $          ;           = endif
endif133: 
    
    exx                 ; 1:4       push_addloop(3) 146
    ld   BC, 3          ; 3:10      push_addloop(3) 146 BC = step
    ld    E,(HL)        ; 1:7       push_addloop(3) 146
    ld    A, E          ; 1:4       push_addloop(3) 146
    add   A, C          ; 1:4       push_addloop(3) 146
    ld  (HL),A          ; 1:7       push_addloop(3) 146
    inc   L             ; 1:4       push_addloop(3) 146
    ld    D,(HL)        ; 1:7       push_addloop(3) 146 DE = index
    ld    A, D          ; 1:4       push_addloop(3) 146
    adc   A, B          ; 1:4       push_addloop(3) 146
    ld  (HL),A          ; 1:7       push_addloop(3) 146
    inc  HL             ; 1:6       push_addloop(3) 146
    ld    A, E          ; 1:4       push_addloop(3) 146    
    sub (HL)            ; 1:7       push_addloop(3) 146
    ld    E, A          ; 1:4       push_addloop(3) 146    
    inc   L             ; 1:4       push_addloop(3) 146
    ld    A, D          ; 1:4       push_addloop(3) 146    
    sbc   A,(HL)        ; 1:7       push_addloop(3) 146
    ld    D, A          ; 1:4       push_addloop(3) 146 DE = index-stop
    ld    A, E          ; 1:4       push_addloop(3) 146    
    add   A, C          ; 1:4       push_addloop(3) 146
    ld    A, D          ; 1:4       push_addloop(3) 146    
    adc   A, B          ; 1:4       push_addloop(3) 146
    xor   D             ; 1:4       push_addloop(3) 146
    jp    m, $+10       ; 3:10      push_addloop(3) 146
    dec   L             ; 1:4       push_addloop(3) 146    
    dec  HL             ; 1:6       push_addloop(3) 146
    dec   L             ; 1:4       push_addloop(3) 146
    exx                 ; 1:4       push_addloop(3) 146
    jp    p, do146      ; 3:10      push_addloop(3) 146 ( -- ) R:( stop index -- stop index+3 )
leave146:               ;           push_addloop(3) 146
    inc  HL             ; 1:6       push_addloop(3) 146
    exx                 ; 1:4       push_addloop(3) 146 ( -- ) R:( stop index -- )
exit146 EQU $ 
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
sexit147 EQU $ 
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
sexit148 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 


_up3_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


;   ---  b e g i n  ---
_smycka:                ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
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
    
    push HL             ; 1:11      do 149 index
    push DE             ; 1:11      do 149 stop
    exx                 ; 1:4       do 149
    pop  DE             ; 1:10      do 149 stop
    dec  HL             ; 1:6       do 149
    ld  (HL),D          ; 1:7       do 149
    dec  L              ; 1:4       do 149
    ld  (HL),E          ; 1:7       do 149 stop
    pop  DE             ; 1:10      do 149 index
    dec  HL             ; 1:6       do 149
    ld  (HL),D          ; 1:7       do 149
    dec  L              ; 1:4       do 149
    ld  (HL),E          ; 1:7       do 149 index
    exx                 ; 1:4       do 149
    pop  HL             ; 1:10      do 149
    pop  DE             ; 1:10      do 149 ( stop index -- ) R: ( -- stop index )
do149: 
    exx                 ; 1:4       index 149 i    
    ld    E,(HL)        ; 1:7       index 149 i
    inc   L             ; 1:4       index 149 i
    ld    D,(HL)        ; 1:7       index 149 i
    push DE             ; 1:11      index 149 i
    dec   L             ; 1:4       index 149 i
    exx                 ; 1:4       index 149 i
    ex   DE, HL         ; 1:4       index 149 i
    ex  (SP),HL         ; 1:19      index 149 i 
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
    exx                 ; 1:4       leave 149
    inc  L              ; 1:4       leave 149
    inc  HL             ; 1:6       leave 149
    inc  L              ; 1:4       leave 149
    jp   leave149       ;           leave 149 
else136  EQU $          ;           = endif
endif136: 
    
    exx                 ; 1:4       loop 149
    ld    E,(HL)        ; 1:7       loop 149
    inc   L             ; 1:4       loop 149
    ld    D,(HL)        ; 1:7       loop 149 DE = index   
    inc  HL             ; 1:6       loop 149
    inc  DE             ; 1:6       loop 149 index + 1
    ld    A,(HL)        ; 1:4       loop 149
    xor   E             ; 1:4       loop 149 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 149
    ld    A, D          ; 1:4       loop 149
    inc   L             ; 1:4       loop 149
    xor (HL)            ; 1:7       loop 149 hi index - stop
    jr    z, leave149   ; 2:7/12    loop 149 exit    
    dec   L             ; 1:4       loop 149
    dec  HL             ; 1:6       loop 149
    ld  (HL), D         ; 1:7       loop 149
    dec   L             ; 1:4       loop 149
    ld  (HL), E         ; 1:7       loop 149
    exx                 ; 1:4       loop 149
    jp   do149          ; 3:10      loop 149
leave149:
    inc  HL             ; 1:6       loop 149
    exx                 ; 1:4       loop 149
exit149 EQU $ 
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
sexit150 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

_smycka_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


;   ---  b e g i n  ---
_otaznik:               ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
    
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
    
    push HL             ; 1:11      ?do 151 index
    or    A             ; 1:4       ?do 151
    sbc  HL, DE         ; 2:15      ?do 151
    jr   nz, $+8        ; 2:7/12    ?do 151
    pop  HL             ; 1:10      ?do 151
    pop  HL             ; 1:10      ?do 151
    pop  DE             ; 1:10      ?do 151
    jp   exit151        ; 3:10      ?do 151   
    push DE             ; 1:11      ?do 151 stop
    exx                 ; 1:4       ?do 151
    pop  DE             ; 1:10      ?do 151 stop
    dec  HL             ; 1:6       ?do 151
    ld  (HL),D          ; 1:7       ?do 151
    dec  L              ; 1:4       ?do 151
    ld  (HL),E          ; 1:7       ?do 151 stop
    pop  DE             ; 1:10      ?do 151 index
    dec  HL             ; 1:6       ?do 151
    ld  (HL),D          ; 1:7       ?do 151
    dec  L              ; 1:4       ?do 151
    ld  (HL),E          ; 1:7       ?do 151 index
    exx                 ; 1:4       ?do 151
    pop  HL             ; 1:10      ?do 151
    pop  DE             ; 1:10      ?do 151 ( stop index -- ) R: ( -- stop index )
do151: 
    exx                 ; 1:4       index 151 i    
    ld    E,(HL)        ; 1:7       index 151 i
    inc   L             ; 1:4       index 151 i
    ld    D,(HL)        ; 1:7       index 151 i
    push DE             ; 1:11      index 151 i
    dec   L             ; 1:4       index 151 i
    exx                 ; 1:4       index 151 i
    ex   DE, HL         ; 1:4       index 151 i
    ex  (SP),HL         ; 1:19      index 151 i 
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
    exx                 ; 1:4       leave 151
    inc  L              ; 1:4       leave 151
    inc  HL             ; 1:6       leave 151
    inc  L              ; 1:4       leave 151
    jp   leave151       ;           leave 151 
else138  EQU $          ;           = endif
endif138: 
    
    exx                 ; 1:4       loop 151
    ld    E,(HL)        ; 1:7       loop 151
    inc   L             ; 1:4       loop 151
    ld    D,(HL)        ; 1:7       loop 151 DE = index   
    inc  HL             ; 1:6       loop 151
    inc  DE             ; 1:6       loop 151 index + 1
    ld    A,(HL)        ; 1:4       loop 151
    xor   E             ; 1:4       loop 151 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 151
    ld    A, D          ; 1:4       loop 151
    inc   L             ; 1:4       loop 151
    xor (HL)            ; 1:7       loop 151 hi index - stop
    jr    z, leave151   ; 2:7/12    loop 151 exit    
    dec   L             ; 1:4       loop 151
    dec  HL             ; 1:6       loop 151
    ld  (HL), D         ; 1:7       loop 151
    dec   L             ; 1:4       loop 151
    ld  (HL), E         ; 1:7       loop 151
    exx                 ; 1:4       loop 151
    jp   do151          ; 3:10      loop 151
leave151:
    inc  HL             ; 1:6       loop 151
    exx                 ; 1:4       loop 151
exit151 EQU $ 
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
    jp    z, sexit152   ; 3:10      ?sdo 152   
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
sexit152 EQU $ 
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

_otaznik_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----





;   ---  b e g i n  ---
_3loop:                 ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret ) 
    
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
    
    push HL             ; 1:11      do 153 index
    push DE             ; 1:11      do 153 stop
    exx                 ; 1:4       do 153
    pop  DE             ; 1:10      do 153 stop
    dec  HL             ; 1:6       do 153
    ld  (HL),D          ; 1:7       do 153
    dec  L              ; 1:4       do 153
    ld  (HL),E          ; 1:7       do 153 stop
    pop  DE             ; 1:10      do 153 index
    dec  HL             ; 1:6       do 153
    ld  (HL),D          ; 1:7       do 153
    dec  L              ; 1:4       do 153
    ld  (HL),E          ; 1:7       do 153 index
    exx                 ; 1:4       do 153
    pop  HL             ; 1:10      do 153
    pop  DE             ; 1:10      do 153 ( stop index -- ) R: ( -- stop index )
do153: 
    exx                 ; 1:4       index 153 i    
    ld    E,(HL)        ; 1:7       index 153 i
    inc   L             ; 1:4       index 153 i
    ld    D,(HL)        ; 1:7       index 153 i
    push DE             ; 1:11      index 153 i
    dec   L             ; 1:4       index 153 i
    exx                 ; 1:4       index 153 i
    ex   DE, HL         ; 1:4       index 153 i
    ex  (SP),HL         ; 1:19      index 153 i 
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
    exx                 ; 1:4       leave 153
    inc  L              ; 1:4       leave 153
    inc  HL             ; 1:6       leave 153
    inc  L              ; 1:4       leave 153
    jp   leave153       ;           leave 153 
else140  EQU $          ;           = endif
endif140: 
        
    push DE             ; 1:11      _krok @ push(_krok) fetch 
    ex   DE, HL         ; 1:4       _krok @ push(_krok) fetch
    ld   HL,(_krok)     ; 3:16      _krok @ push(_krok) fetch
    
    ex  (SP),HL         ; 1:19      +loop 153
    ex   DE, HL         ; 1:4       +loop 153
    exx                 ; 1:4       +loop 153
    ld    E,(HL)        ; 1:7       +loop 153
    inc   L             ; 1:4       +loop 153
    ld    D,(HL)        ; 1:7       +loop 153 DE = index
    inc  HL             ; 1:6       +loop 153
    ld    C,(HL)        ; 1:7       +loop 153
    inc   L             ; 1:4       +loop 153
    ld    B,(HL)        ; 1:7       +loop 153 BC = stop
    ex  (SP),HL         ; 1:19      +loop 153 HL = step
    ex   DE, HL         ; 1:4       +loop 153
    xor   A             ; 1:4       +loop 153
    sbc  HL, BC         ; 2:15      +loop 153 HL = index-stop
    ld    A, H          ; 1:4       +loop 153
    add  HL, DE         ; 1:11      +loop 153 HL = index-stop+step
    xor   H             ; 1:4       +loop 153
    add  HL, BC         ; 1:11      +loop 153 HL = index+step
    ex   DE, HL         ; 1:4       +loop 153
    pop  HL             ; 1:10      +loop 153
    jp    m, leave153   ; 3:10      +loop 153
    dec   L             ; 1:4       +loop 153    
    dec  HL             ; 1:6       +loop 153
    ld  (HL),D          ; 1:7       +loop 153    
    dec   L             ; 1:4       +loop 153
    ld  (HL),E          ; 1:7       +loop 153
    exx                 ; 1:4       +loop 153
    jp    p, do153      ; 3:10      +loop 153 ( step -- ) R:( stop index -- stop index+step )
leave153:               ;           +loop 153
    inc  HL             ; 1:6       +loop 153
    exx                 ; 1:4       +loop 153 ( step -- ) R:( stop index -- )
exit153 EQU $ 
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_3loop_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----



;   ---  b e g i n  ---
_3sloop:                ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret ) 
    
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
sexit154 EQU $ 
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A 

_3sloop_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----



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
    
    ; fall to PRINT_U16
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


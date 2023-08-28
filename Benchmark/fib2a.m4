include(`../M4/FIRST.M4')dnl
  ifdef __ORG
    org __ORG
  else
    org 24576
  endif
    INIT(35000)
    SCALL(fib2a_bench)
    STOP   

    SCOLON(fib2a_bench,( -- ))
        PUSH2(1000,0) DO 
            PUSH2(20,0) DO 
                I 
__ASM({
    push DE             ; 1:11      ( n1 -- n2 )
    ld    B, L          ; 1:4
    ld    C, H          ; 1:4       CB = counter
    ld   HL, 0x0000     ; 3:10
    ld   DE, 0x0001     ; 3:10
    inc   C             ; 1:4
    inc   B             ; 1:4
    dec   B             ; 1:4
    jr    z, $+6        ; 2:7/12    
    ex   DE, HL         ; 1:4
    add  HL, DE         ; 1:11      +
    djnz $-2            ; 2:13/8
    dec  C              ; 1:4
    jr  nz, $-5         ; 2:12/7
    pop  DE             ; 1:10})
    
                DROP
    
            LOOP
        LOOP
    SSEMICOLON

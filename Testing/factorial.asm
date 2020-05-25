ORG 0x8000

;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld   HL, 60000
    exx

    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    add  HL, HL         ; 1:11      2* 2x  
    ld    B, H          ; 1:4       3*
    ld    C, L          ; 1:4       3* save 1x
    add  HL, HL         ; 1:11      3* 2x
    add  HL, BC         ; 1:11      3* HL + save  
    add  HL, HL         ; 1:11      4* 2x
    add  HL, HL         ; 1:11      4* 4x  
    ld    B, H          ; 1:4       5*
    ld    C, L          ; 1:4       5* save 1x
    add  HL, HL         ; 1:11      5* 2x
    add  HL, HL         ; 1:11      5* 4x
    add  HL, BC         ; 1:11      5* HL + save  
    add  HL, HL         ; 1:11      6* 2x
    ld    B, H          ; 1:4       6*
    ld    C, L          ; 1:4       6* save 2x
    add  HL, HL         ; 1:11      6* 4x
    add  HL, BC         ; 1:11      6* HL + save  
    ld    B, H          ; 1:4       7*
    ld    C, L          ; 1:4       7* save 1x
    add  HL, HL         ; 1:11      7* 2x
    add  HL, HL         ; 1:11      7* 4x
    add  HL, HL         ; 1:11      7* 8x
    or    A             ; 1:4       7*
    sbc  HL, BC         ; 2:15      7* HL - save  
    add  HL, HL         ; 1:11      8* 2x
    add  HL, HL         ; 1:11      8* 4x
    add  HL, HL         ; 1:11      8* 8x  
    ld    B, H          ; 1:4       9*
    ld    C, L          ; 1:4       9* save 1x
    add  HL, HL         ; 1:11      9* 2x
    add  HL, HL         ; 1:11      9* 4x
    add  HL, HL         ; 1:11      9* 8x
    add  HL, BC         ; 1:11      9* HL + save  
    add  HL, HL         ; 1:11      10* 2x
    ld    B, H          ; 1:4       10*
    ld    C, L          ; 1:4       10* save 2x
    add  HL, HL         ; 1:11      10* 4x
    add  HL, HL         ; 1:11      10* 8x
    add  HL, BC         ; 1:11      10* HL + save 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, H          ; 1:4       11*
    ld    A, L          ; 1:4       11* save 1x
    add  HL, HL         ; 1:11      11* 2x
    add   A, L          ; 1:4       11* +
    ld    C, A          ; 1:4       11* +
    ld    A, B          ; 1:4       11* +
    adc   A, H          ; 1:4       11* +
    ld    B, A          ; 1:4       11* + save 2x
    add  HL, HL         ; 1:11      11* 4x
    add  HL, HL         ; 1:11      11* 8x
    add  HL, BC         ; 1:11      11* HL + save  
    add  HL, HL         ; 1:11      12* 2x
    add  HL, HL         ; 1:11      12* 4x
    ld    B, H          ; 1:4       12*
    ld    C, L          ; 1:4       12* save 4x
    add  HL, HL         ; 1:11      12* 8x
    add  HL, BC         ; 1:11      12* HL + save  
    ld    B, H          ; 1:4       13*
    ld    A, L          ; 1:4       13* save 1x
    add  HL, HL         ; 1:11      13* 2x
    add  HL, HL         ; 1:11      13* 4x
    add   A, L          ; 1:4       13* +
    ld    C, A          ; 1:4       13* +
    ld    A, B          ; 1:4       13* +
    adc   A, H          ; 1:4       13* +
    ld    B, A          ; 1:4       13* + save 4x
    add  HL, HL         ; 1:11      13* 8x
    add  HL, BC         ; 1:11      13* HL + save  
    add  HL, HL         ; 1:11      14* 2x
    ld    B, H          ; 1:4       14*
    ld    C, L          ; 1:4       14* save 2x
    add  HL, HL         ; 1:11      14* 4x
    add  HL, HL         ; 1:11      14* 8x
    add  HL, HL         ; 1:11      14* 16x
    or    A             ; 1:4       14*
    sbc  HL, BC         ; 2:15      14*  
    ld    B, H          ; 1:4       15*
    ld    C, L          ; 1:4       15* save 1x
    add  HL, HL         ; 1:11      15* 2x
    add  HL, HL         ; 1:11      15* 4x
    add  HL, HL         ; 1:11      15* 8x
    add  HL, HL         ; 1:11      15* 16x
    or    A             ; 1:4       15*
    sbc  HL, BC         ; 2:15      15* HL - save  
    add  HL, HL         ; 1:11      16* 2x
    add  HL, HL         ; 1:11      16* 4x
    add  HL, HL         ; 1:11      16* 8x
    add  HL, HL         ; 1:11      16* 16x  
    ld    B, H          ; 1:4       17*
    ld    C, L          ; 1:4       17* save 1x
    add  HL, HL         ; 1:11      17* 2x
    add  HL, HL         ; 1:11      17* 4x
    add  HL, HL         ; 1:11      17* 8x
    add  HL, HL         ; 1:11      17* 16x
    add  HL, BC         ; 1:11      17* HL + save  
    add  HL, HL         ; 1:11      18* 2x
    ld    B, H          ; 1:4       18*
    ld    C, L          ; 1:4       18* save 2x
    add  HL, HL         ; 1:11      18* 4x
    add  HL, HL         ; 1:11      18* 8x
    add  HL, HL         ; 1:11      18* 16x
    add  HL, BC         ; 1:11      18* HL + save  
    ld    B, H          ; 1:4       19*
    ld    A, L          ; 1:4       19* save 1x
    add  HL, HL         ; 1:11      19* 2x
    add   A, L          ; 1:4       19* +
    ld    C, A          ; 1:4       19* +
    ld    A, B          ; 1:4       19* +
    adc   A, H          ; 1:4       19* +
    ld    B, A          ; 1:4       19* + save 2x
    add  HL, HL         ; 1:11      19* 4x
    add  HL, HL         ; 1:11      19* 8x
    add  HL, HL         ; 1:11      19* 16x
    add  HL, BC         ; 1:11      19* HL + save  
    add  HL, HL         ; 1:11      20* 2x
    add  HL, HL         ; 1:11      20* 4x
    ld    B, H          ; 1:4       20*
    ld    C, L          ; 1:4       20* save 4x
    add  HL, HL         ; 1:11      20* 8x
    add  HL, HL         ; 1:11      20* 16x
    add  HL, BC         ; 1:11      20* HL + save 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, H          ; 1:4       21*
    ld    A, L          ; 1:4       21* save 1x
    add  HL, HL         ; 1:11      21* 2x
    add  HL, HL         ; 1:11      21* 4x
    add   A, L          ; 1:4       21* +
    ld    C, A          ; 1:4       21* +
    ld    A, B          ; 1:4       21* +
    adc   A, H          ; 1:4       21* +
    ld    B, A          ; 1:4       21* + save 4x
    add  HL, HL         ; 1:11      21* 8x
    add  HL, HL         ; 1:11      21* 16x
    add  HL, BC         ; 1:11      21* HL + save  
    add  HL, HL         ; 1:11      22* 2x
    ld    B, H          ; 1:4       22*
    ld    A, L          ; 1:4       22* save 2x
    add  HL, HL         ; 1:11      22* 4x
    add   A, L          ; 1:4       22* +
    ld    C, A          ; 1:4       22* +
    ld    A, B          ; 1:4       22* +
    adc   A, H          ; 1:4       22* +
    ld    B, A          ; 1:4       22* + save 4x
    add  HL, HL         ; 1:11      22* 8x
    add  HL, HL         ; 1:11      22* 16x
    add  HL, BC         ; 1:11      22* HL + save  
    ld    B, H          ; 1:4       23*
    ld    A, L          ; 1:4       23* save 1x
    add  HL, HL         ; 1:11      23* 2x
    add  HL, HL         ; 1:11      23* 4x
    add  HL, HL         ; 1:11      23* 8x
    add   A, L          ; 1:4       23* +
    ld    C, A          ; 1:4       23* +
    ld    A, B          ; 1:4       23* +
    adc   A, H          ; 1:4       23* +
    ld    B, A          ; 1:4       23* + save 8x
    add  HL, HL         ; 1:11      23* 16x
    add  HL, HL         ; 1:11      23* 32x
    or    A             ; 1:4       23*
    sbc  HL, BC         ; 2:15      23* HL - save  
    add  HL, HL         ; 1:11      24* 2x
    add  HL, HL         ; 1:11      24* 4x
    add  HL, HL         ; 1:11      24* 8x
    ld    B, H          ; 1:4       24*
    ld    C, L          ; 1:4       24* save 8x
    add  HL, HL         ; 1:11      24* 16x
    add  HL, BC         ; 1:11      24* HL + save  
    ld    B, H          ; 1:4       25*
    ld    A, L          ; 1:4       25* save 1x
    add  HL, HL         ; 1:11      25* 2x
    add  HL, HL         ; 1:11      25* 4x
    add  HL, HL         ; 1:11      25* 8x
    add   A, L          ; 1:4       25* +
    ld    C, A          ; 1:4       25* +
    ld    A, B          ; 1:4       25* +
    adc   A, H          ; 1:4       25* +
    ld    B, A          ; 1:4       25* + save 8x
    add  HL, HL         ; 1:11      25* 16x
    add  HL, BC         ; 1:11      25* HL + save  
    add  HL, HL         ; 1:11      26* 2x
    ld    B, H          ; 1:4       26*
    ld    A, L          ; 1:4       26* save 2x
    add  HL, HL         ; 1:11      26* 4x
    add  HL, HL         ; 1:11      26* 8x
    add   A, L          ; 1:4       26* +
    ld    C, A          ; 1:4       26* +
    ld    A, B          ; 1:4       26* +
    adc   A, H          ; 1:4       26* +
    ld    B, A          ; 1:4       26* + save 8x
    add  HL, HL         ; 1:11      26* 16x
    add  HL, BC         ; 1:11      26* HL + save  
    ld    B, H          ; 1:4       27*
    ld    A, L          ; 1:4       27* save 1x
    add  HL, HL         ; 1:11      27* 2x
    add  HL, HL         ; 1:11      27* 4x
    add   A, L          ; 1:4       27* +
    ld    C, A          ; 1:4       27* +
    ld    A, B          ; 1:4       27* +
    adc   A, H          ; 1:4       27* +
    ld    B, A          ; 1:4       27* + save 4x
    add  HL, HL         ; 1:11      27* 8x
    add  HL, HL         ; 1:11      27* 16x
    add  HL, HL         ; 1:11      27* 32x
    or    A             ; 1:4       27*
    sbc  HL, BC         ; 2:15      27* HL - save  
    add  HL, HL         ; 1:11      28* 2x
    add  HL, HL         ; 1:11      28* 4x
    ld    B, H          ; 1:4       28*
    ld    C, L          ; 1:4       28* save 4x
    add  HL, HL         ; 1:11      28* 8x
    add  HL, HL         ; 1:11      28* 16x
    add  HL, HL         ; 1:11      28* 32x
    or    A             ; 1:4       28*
    sbc  HL, BC         ; 2:15      28*  
    ld    B, H          ; 1:4       29*
    ld    A, L          ; 1:4       29* save 1x
    add  HL, HL         ; 1:11      29* 2x
    add   A, L          ; 1:4       29* +
    ld    C, A          ; 1:4       29* +
    ld    A, B          ; 1:4       29* +
    adc   A, H          ; 1:4       29* +
    ld    B, A          ; 1:4       29* + save 2x
    add  HL, HL         ; 1:11      29* 4x
    add  HL, HL         ; 1:11      29* 8x
    add  HL, HL         ; 1:11      29* 16x
    add  HL, HL         ; 1:11      29* 32x
    or    A             ; 1:4       29*
    sbc  HL, BC         ; 2:15      29* HL - save  
    add  HL, HL         ; 1:11      30* 2x
    ld    B, H          ; 1:4       30*
    ld    C, L          ; 1:4       30* save 2x
    add  HL, HL         ; 1:11      30* 4x
    add  HL, HL         ; 1:11      30* 8x
    add  HL, HL         ; 1:11      30* 16x
    add  HL, HL         ; 1:11      30* 32x
    or    A             ; 1:4       30*
    sbc  HL, BC         ; 2:15      30* 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, H          ; 1:4       31*
    ld    C, L          ; 1:4       31* save 1x
    add  HL, HL         ; 1:11      31* 2x
    add  HL, HL         ; 1:11      31* 4x
    add  HL, HL         ; 1:11      31* 8x
    add  HL, HL         ; 1:11      31* 16x
    add  HL, HL         ; 1:11      31* 32x
    or    A             ; 1:4       31*
    sbc  HL, BC         ; 2:15      31* HL - save  
    add  HL, HL         ; 1:11      32* 2x
    add  HL, HL         ; 1:11      32* 4x
    add  HL, HL         ; 1:11      32* 8x
    add  HL, HL         ; 1:11      32* 16x
    add  HL, HL         ; 1:11      32* 32x  
    ld    B, H          ; 1:4       33*
    ld    C, L          ; 1:4       33* save 1x
    add  HL, HL         ; 1:11      33* 2x
    add  HL, HL         ; 1:11      33* 4x
    add  HL, HL         ; 1:11      33* 8x
    add  HL, HL         ; 1:11      33* 16x
    add  HL, HL         ; 1:11      33* 32x
    add  HL, BC         ; 1:11      33* HL + save  
    add  HL, HL         ; 1:11      34* 2x
    ld    B, H          ; 1:4       34*
    ld    C, L          ; 1:4       34* save 2x
    add  HL, HL         ; 1:11      34* 4x
    add  HL, HL         ; 1:11      34* 8x
    add  HL, HL         ; 1:11      34* 16x
    add  HL, HL         ; 1:11      34* 32x
    add  HL, BC         ; 1:11      34* HL + save  
    ld    B, H          ; 1:4       35*
    ld    A, L          ; 1:4       35* save 1x
    add  HL, HL         ; 1:11      35* 2x
    add   A, L          ; 1:4       35* +
    ld    C, A          ; 1:4       35* +
    ld    A, B          ; 1:4       35* +
    adc   A, H          ; 1:4       35* +
    ld    B, A          ; 1:4       35* + save 2x
    add  HL, HL         ; 1:11      35* 4x
    add  HL, HL         ; 1:11      35* 8x
    add  HL, HL         ; 1:11      35* 16x
    add  HL, HL         ; 1:11      35* 32x
    add  HL, BC         ; 1:11      35* HL + save  
    add  HL, HL         ; 1:11      36* 2x
    add  HL, HL         ; 1:11      36* 4x
    ld    B, H          ; 1:4       36*
    ld    C, L          ; 1:4       36* save 4x
    add  HL, HL         ; 1:11      36* 8x
    add  HL, HL         ; 1:11      36* 16x
    add  HL, HL         ; 1:11      36* 32x
    add  HL, BC         ; 1:11      36* HL + save  
    ld    B, H          ; 1:4       37*
    ld    A, L          ; 1:4       37* save 1x
    add  HL, HL         ; 1:11      37* 2x
    add  HL, HL         ; 1:11      37* 4x
    add   A, L          ; 1:4       37* +
    ld    C, A          ; 1:4       37* +
    ld    A, B          ; 1:4       37* +
    adc   A, H          ; 1:4       37* +
    ld    B, A          ; 1:4       37* + save 4x
    add  HL, HL         ; 1:11      37* 8x
    add  HL, HL         ; 1:11      37* 16x
    add  HL, HL         ; 1:11      37* 32x
    add  HL, BC         ; 1:11      37* HL + save  
    add  HL, HL         ; 1:11      38* 2x
    ld    B, H          ; 1:4       38*
    ld    A, L          ; 1:4       38* save 2x
    add  HL, HL         ; 1:11      38* 4x
    add   A, L          ; 1:4       38* +
    ld    C, A          ; 1:4       38* +
    ld    A, B          ; 1:4       38* +
    adc   A, H          ; 1:4       38* +
    ld    B, A          ; 1:4       38* + save 4x
    add  HL, HL         ; 1:11      38* 8x
    add  HL, HL         ; 1:11      38* 16x
    add  HL, HL         ; 1:11      38* 32x
    add  HL, BC         ; 1:11      38* HL + save  
    ld    B, D          ; 1:4       39*
    ld    C, E          ; 1:4       39*
    ld    D, H          ; 1:4       39*
    ld    E, L          ; 1:4       39* save 1x
    add  HL, HL         ; 1:11      39* 2x
    ex   DE, HL         ; 1:4       39* +
    add  HL, DE         ; 1:11      39* + save 2x
    ex   DE, HL         ; 1:4       39* +
    add  HL, HL         ; 1:11      39* 4x
    ex   DE, HL         ; 1:4       39* +
    add  HL, DE         ; 1:11      39* + save 4x
    ex   DE, HL         ; 1:4       39* +
    add  HL, HL         ; 1:11      39* 8x
    add  HL, HL         ; 1:11      39* 16x
    add  HL, HL         ; 1:11      39* 32x
    add  HL, DE         ; 1:11      39* HL + save
    ld    D, B          ; 1:4       39*
    ld    E, C          ; 1:4       39*  
    add  HL, HL         ; 1:11      40* 2x
    add  HL, HL         ; 1:11      40* 4x
    add  HL, HL         ; 1:11      40* 8x
    ld    B, H          ; 1:4       40*
    ld    C, L          ; 1:4       40* save 8x
    add  HL, HL         ; 1:11      40* 16x
    add  HL, HL         ; 1:11      40* 32x
    add  HL, BC         ; 1:11      40* HL + save 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, H          ; 1:4       41*
    ld    A, L          ; 1:4       41* save 1x
    add  HL, HL         ; 1:11      41* 2x
    add  HL, HL         ; 1:11      41* 4x
    add  HL, HL         ; 1:11      41* 8x
    add   A, L          ; 1:4       41* +
    ld    C, A          ; 1:4       41* +
    ld    A, B          ; 1:4       41* +
    adc   A, H          ; 1:4       41* +
    ld    B, A          ; 1:4       41* + save 8x
    add  HL, HL         ; 1:11      41* 16x
    add  HL, HL         ; 1:11      41* 32x
    add  HL, BC         ; 1:11      41* HL + save  
    add  HL, HL         ; 1:11      42* 2x
    ld    B, H          ; 1:4       42*
    ld    A, L          ; 1:4       42* save 2x
    add  HL, HL         ; 1:11      42* 4x
    add  HL, HL         ; 1:11      42* 8x
    add   A, L          ; 1:4       42* +
    ld    C, A          ; 1:4       42* +
    ld    A, B          ; 1:4       42* +
    adc   A, H          ; 1:4       42* +
    ld    B, A          ; 1:4       42* + save 8x
    add  HL, HL         ; 1:11      42* 16x
    add  HL, HL         ; 1:11      42* 32x
    add  HL, BC         ; 1:11      42* HL + save  
    ld    B, D          ; 1:4       43*
    ld    C, E          ; 1:4       43*
    ld    D, H          ; 1:4       43*
    ld    E, L          ; 1:4       43* save 1x
    add  HL, HL         ; 1:11      43* 2x
    ex   DE, HL         ; 1:4       43* +
    add  HL, DE         ; 1:11      43* + save 2x
    ex   DE, HL         ; 1:4       43* +
    add  HL, HL         ; 1:11      43* 4x
    add  HL, HL         ; 1:11      43* 8x
    ex   DE, HL         ; 1:4       43* +
    add  HL, DE         ; 1:11      43* + save 8x
    ex   DE, HL         ; 1:4       43* +
    add  HL, HL         ; 1:11      43* 16x
    add  HL, HL         ; 1:11      43* 32x
    add  HL, DE         ; 1:11      43* HL + save
    ld    D, B          ; 1:4       43*
    ld    E, C          ; 1:4       43*  
    add  HL, HL         ; 1:11      44* 2x
    add  HL, HL         ; 1:11      44* 4x
    ld    B, H          ; 1:4       44*
    ld    A, L          ; 1:4       44* save 4x
    add  HL, HL         ; 1:11      44* 8x
    add   A, L          ; 1:4       44* +
    ld    C, A          ; 1:4       44* +
    ld    A, B          ; 1:4       44* +
    adc   A, H          ; 1:4       44* +
    ld    B, A          ; 1:4       44* + save 8x
    add  HL, HL         ; 1:11      44* 16x
    add  HL, HL         ; 1:11      44* 32x
    add  HL, BC         ; 1:11      44* HL + save  
    ld    B, D          ; 1:4       45*
    ld    C, E          ; 1:4       45*
    ld    D, H          ; 1:4       45*
    ld    E, L          ; 1:4       45* save 1x
    add  HL, HL         ; 1:11      45* 2x
    add  HL, HL         ; 1:11      45* 4x
    ex   DE, HL         ; 1:4       45* +
    add  HL, DE         ; 1:11      45* + save 4x
    ex   DE, HL         ; 1:4       45* +
    add  HL, HL         ; 1:11      45* 8x
    ex   DE, HL         ; 1:4       45* +
    add  HL, DE         ; 1:11      45* + save 8x
    ex   DE, HL         ; 1:4       45* +
    add  HL, HL         ; 1:11      45* 16x
    add  HL, HL         ; 1:11      45* 32x
    add  HL, DE         ; 1:11      45* HL + save
    ld    D, B          ; 1:4       45*
    ld    E, C          ; 1:4       45*  
    ld    B, D          ; 1:4       46*
    ld    C, E          ; 1:4       46*
    add  HL, HL         ; 1:11      46* 2x
    ld    D, H          ; 1:4       46*
    ld    E, L          ; 1:4       46* save 2x
    add  HL, HL         ; 1:11      46* 4x
    ex   DE, HL         ; 1:4       46* +
    add  HL, DE         ; 1:11      46* + save 4x
    ex   DE, HL         ; 1:4       46* +
    add  HL, HL         ; 1:11      46* 8x
    ex   DE, HL         ; 1:4       46* +
    add  HL, DE         ; 1:11      46* + save 8x
    ex   DE, HL         ; 1:4       46* +
    add  HL, HL         ; 1:11      46* 16x
    add  HL, HL         ; 1:11      46* 32x
    add  HL, DE         ; 1:11      46* HL + save
    ld    D, B          ; 1:4       46*
    ld    E, C          ; 1:4       46*  
    ld    B, H          ; 1:4       47*
    ld    A, L          ; 1:4       47* save 1x
    add  HL, HL         ; 1:11      47* 2x
    add  HL, HL         ; 1:11      47* 4x
    add  HL, HL         ; 1:11      47* 8x
    add  HL, HL         ; 1:11      47* 16x
    add   A, L          ; 1:4       47* +
    ld    C, A          ; 1:4       47* +
    ld    A, B          ; 1:4       47* +
    adc   A, H          ; 1:4       47* +
    ld    B, A          ; 1:4       47* + save 16x
    add  HL, HL         ; 1:11      47* 32x
    add  HL, HL         ; 1:11      47* 64x
    or    A             ; 1:4       47*
    sbc  HL, BC         ; 2:15      47* HL - save  
    add  HL, HL         ; 1:11      48* 2x
    add  HL, HL         ; 1:11      48* 4x
    add  HL, HL         ; 1:11      48* 8x
    add  HL, HL         ; 1:11      48* 16x
    ld    B, H          ; 1:4       48*
    ld    C, L          ; 1:4       48* save 16x
    add  HL, HL         ; 1:11      48* 32x
    add  HL, BC         ; 1:11      48* HL + save  
    ld    B, H          ; 1:4       49*
    ld    A, L          ; 1:4       49* save 1x
    add  HL, HL         ; 1:11      49* 2x
    add  HL, HL         ; 1:11      49* 4x
    add  HL, HL         ; 1:11      49* 8x
    add  HL, HL         ; 1:11      49* 16x
    add   A, L          ; 1:4       49* +
    ld    C, A          ; 1:4       49* +
    ld    A, B          ; 1:4       49* +
    adc   A, H          ; 1:4       49* +
    ld    B, A          ; 1:4       49* + save 16x
    add  HL, HL         ; 1:11      49* 32x
    add  HL, BC         ; 1:11      49* HL + save  
    add  HL, HL         ; 1:11      50* 2x
    ld    B, H          ; 1:4       50*
    ld    A, L          ; 1:4       50* save 2x
    add  HL, HL         ; 1:11      50* 4x
    add  HL, HL         ; 1:11      50* 8x
    add  HL, HL         ; 1:11      50* 16x
    add   A, L          ; 1:4       50* +
    ld    C, A          ; 1:4       50* +
    ld    A, B          ; 1:4       50* +
    adc   A, H          ; 1:4       50* +
    ld    B, A          ; 1:4       50* + save 16x
    add  HL, HL         ; 1:11      50* 32x
    add  HL, BC         ; 1:11      50* HL + save 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, D          ; 1:4       51*
    ld    C, E          ; 1:4       51*
    ld    D, H          ; 1:4       51*
    ld    E, L          ; 1:4       51* save 1x
    add  HL, HL         ; 1:11      51* 2x
    ex   DE, HL         ; 1:4       51* +
    add  HL, DE         ; 1:11      51* + save 2x
    ex   DE, HL         ; 1:4       51* +
    add  HL, HL         ; 1:11      51* 4x
    add  HL, HL         ; 1:11      51* 8x
    add  HL, HL         ; 1:11      51* 16x
    ex   DE, HL         ; 1:4       51* +
    add  HL, DE         ; 1:11      51* + save 16x
    ex   DE, HL         ; 1:4       51* +
    add  HL, HL         ; 1:11      51* 32x
    add  HL, DE         ; 1:11      51* HL + save
    ld    D, B          ; 1:4       51*
    ld    E, C          ; 1:4       51*  
    add  HL, HL         ; 1:11      52* 2x
    add  HL, HL         ; 1:11      52* 4x
    ld    B, H          ; 1:4       52*
    ld    A, L          ; 1:4       52* save 4x
    add  HL, HL         ; 1:11      52* 8x
    add  HL, HL         ; 1:11      52* 16x
    add   A, L          ; 1:4       52* +
    ld    C, A          ; 1:4       52* +
    ld    A, B          ; 1:4       52* +
    adc   A, H          ; 1:4       52* +
    ld    B, A          ; 1:4       52* + save 16x
    add  HL, HL         ; 1:11      52* 32x
    add  HL, BC         ; 1:11      52* HL + save  
    ld    B, D          ; 1:4       53*
    ld    C, E          ; 1:4       53*
    ld    D, H          ; 1:4       53*
    ld    E, L          ; 1:4       53* save 1x
    add  HL, HL         ; 1:11      53* 2x
    add  HL, HL         ; 1:11      53* 4x
    ex   DE, HL         ; 1:4       53* +
    add  HL, DE         ; 1:11      53* + save 4x
    ex   DE, HL         ; 1:4       53* +
    add  HL, HL         ; 1:11      53* 8x
    add  HL, HL         ; 1:11      53* 16x
    ex   DE, HL         ; 1:4       53* +
    add  HL, DE         ; 1:11      53* + save 16x
    ex   DE, HL         ; 1:4       53* +
    add  HL, HL         ; 1:11      53* 32x
    add  HL, DE         ; 1:11      53* HL + save
    ld    D, B          ; 1:4       53*
    ld    E, C          ; 1:4       53*  
    ld    B, D          ; 1:4       54*
    ld    C, E          ; 1:4       54*
    add  HL, HL         ; 1:11      54* 2x
    ld    D, H          ; 1:4       54*
    ld    E, L          ; 1:4       54* save 2x
    add  HL, HL         ; 1:11      54* 4x
    ex   DE, HL         ; 1:4       54* +
    add  HL, DE         ; 1:11      54* + save 4x
    ex   DE, HL         ; 1:4       54* +
    add  HL, HL         ; 1:11      54* 8x
    add  HL, HL         ; 1:11      54* 16x
    ex   DE, HL         ; 1:4       54* +
    add  HL, DE         ; 1:11      54* + save 16x
    ex   DE, HL         ; 1:4       54* +
    add  HL, HL         ; 1:11      54* 32x
    add  HL, DE         ; 1:11      54* HL + save
    ld    D, B          ; 1:4       54*
    ld    E, C          ; 1:4       54*  
    ld    B, H          ; 1:4       55*
    ld    A, L          ; 1:4       55* save 1x
    add  HL, HL         ; 1:11      55* 2x
    add  HL, HL         ; 1:11      55* 4x
    add  HL, HL         ; 1:11      55* 8x
    add   A, L          ; 1:4       55* +
    ld    C, A          ; 1:4       55* +
    ld    A, B          ; 1:4       55* +
    adc   A, H          ; 1:4       55* +
    ld    B, A          ; 1:4       55* + save 8x
    add  HL, HL         ; 1:11      55* 16x
    add  HL, HL         ; 1:11      55* 32x
    add  HL, HL         ; 1:11      55* 64x
    or    A             ; 1:4       55*
    sbc  HL, BC         ; 2:15      55* HL - save  
    add  HL, HL         ; 1:11      56* 2x
    add  HL, HL         ; 1:11      56* 4x
    add  HL, HL         ; 1:11      56* 8x
    ld    B, H          ; 1:4       56*
    ld    C, L          ; 1:4       56* save 8x
    add  HL, HL         ; 1:11      56* 16x
    add  HL, HL         ; 1:11      56* 32x
    add  HL, HL         ; 1:11      56* 64x
    or    A             ; 1:4       56*
    sbc  HL, BC         ; 2:15      56*  
    ld    B, D          ; 1:4       57*
    ld    C, E          ; 1:4       57*
    ld    D, H          ; 1:4       57*
    ld    E, L          ; 1:4       57* save 1x
    add  HL, HL         ; 1:11      57* 2x
    add  HL, HL         ; 1:11      57* 4x
    add  HL, HL         ; 1:11      57* 8x
    ex   DE, HL         ; 1:4       57* +
    add  HL, DE         ; 1:11      57* + save 8x
    ex   DE, HL         ; 1:4       57* +
    add  HL, HL         ; 1:11      57* 16x
    ex   DE, HL         ; 1:4       57* +
    add  HL, DE         ; 1:11      57* + save 16x
    ex   DE, HL         ; 1:4       57* +
    add  HL, HL         ; 1:11      57* 32x
    add  HL, DE         ; 1:11      57* HL + save
    ld    D, B          ; 1:4       57*
    ld    E, C          ; 1:4       57*  
    ld    B, D          ; 1:4       58*
    ld    C, E          ; 1:4       58*
    add  HL, HL         ; 1:11      58* 2x
    ld    D, H          ; 1:4       58*
    ld    E, L          ; 1:4       58* save 2x
    add  HL, HL         ; 1:11      58* 4x
    add  HL, HL         ; 1:11      58* 8x
    ex   DE, HL         ; 1:4       58* +
    add  HL, DE         ; 1:11      58* + save 8x
    ex   DE, HL         ; 1:4       58* +
    add  HL, HL         ; 1:11      58* 16x
    ex   DE, HL         ; 1:4       58* +
    add  HL, DE         ; 1:11      58* + save 16x
    ex   DE, HL         ; 1:4       58* +
    add  HL, HL         ; 1:11      58* 32x
    add  HL, DE         ; 1:11      58* HL + save
    ld    D, B          ; 1:4       58*
    ld    E, C          ; 1:4       58*  
    ld    B, H          ; 1:4       59*
    ld    A, L          ; 1:4       59* save 1x
    add  HL, HL         ; 1:11      59* 2x
    add  HL, HL         ; 1:11      59* 4x
    add   A, L          ; 1:4       59* +
    ld    C, A          ; 1:4       59* +
    ld    A, B          ; 1:4       59* +
    adc   A, H          ; 1:4       59* +
    ld    B, A          ; 1:4       59* + save 4x
    add  HL, HL         ; 1:11      59* 8x
    add  HL, HL         ; 1:11      59* 16x
    add  HL, HL         ; 1:11      59* 32x
    add  HL, HL         ; 1:11      59* 64x
    or    A             ; 1:4       59*
    sbc  HL, BC         ; 2:15      59* HL - save  
    add  HL, HL         ; 1:11      60* 2x
    add  HL, HL         ; 1:11      60* 4x
    ld    B, H          ; 1:4       60*
    ld    C, L          ; 1:4       60* save 4x
    add  HL, HL         ; 1:11      60* 8x
    add  HL, HL         ; 1:11      60* 16x
    add  HL, HL         ; 1:11      60* 32x
    add  HL, HL         ; 1:11      60* 64x
    or    A             ; 1:4       60*
    sbc  HL, BC         ; 2:15      60* 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, H          ; 1:4       61*
    ld    A, L          ; 1:4       61* save 1x
    add  HL, HL         ; 1:11      61* 2x
    add   A, L          ; 1:4       61* +
    ld    C, A          ; 1:4       61* +
    ld    A, B          ; 1:4       61* +
    adc   A, H          ; 1:4       61* +
    ld    B, A          ; 1:4       61* + save 2x
    add  HL, HL         ; 1:11      61* 4x
    add  HL, HL         ; 1:11      61* 8x
    add  HL, HL         ; 1:11      61* 16x
    add  HL, HL         ; 1:11      61* 32x
    add  HL, HL         ; 1:11      61* 64x
    or    A             ; 1:4       61*
    sbc  HL, BC         ; 2:15      61* HL - save  
    add  HL, HL         ; 1:11      62* 2x
    ld    B, H          ; 1:4       62*
    ld    C, L          ; 1:4       62* save 2x
    add  HL, HL         ; 1:11      62* 4x
    add  HL, HL         ; 1:11      62* 8x
    add  HL, HL         ; 1:11      62* 16x
    add  HL, HL         ; 1:11      62* 32x
    add  HL, HL         ; 1:11      62* 64x
    or    A             ; 1:4       62*
    sbc  HL, BC         ; 2:15      62*  
    ld    B, H          ; 1:4       63*
    ld    C, L          ; 1:4       63* save 1x
    add  HL, HL         ; 1:11      63* 2x
    add  HL, HL         ; 1:11      63* 4x
    add  HL, HL         ; 1:11      63* 8x
    add  HL, HL         ; 1:11      63* 16x
    add  HL, HL         ; 1:11      63* 32x
    add  HL, HL         ; 1:11      63* 64x
    or    A             ; 1:4       63*
    sbc  HL, BC         ; 2:15      63* HL - save  
    add  HL, HL         ; 1:11      64* 2x
    add  HL, HL         ; 1:11      64* 4x
    add  HL, HL         ; 1:11      64* 8x
    add  HL, HL         ; 1:11      64* 16x
    add  HL, HL         ; 1:11      64* 32x
    add  HL, HL         ; 1:11      64* 64x  
    ld    B, H          ; 1:4       65*
    ld    C, L          ; 1:4       65* save 1x
    add  HL, HL         ; 1:11      65* 2x
    add  HL, HL         ; 1:11      65* 4x
    add  HL, HL         ; 1:11      65* 8x
    add  HL, HL         ; 1:11      65* 16x
    add  HL, HL         ; 1:11      65* 32x
    add  HL, HL         ; 1:11      65* 64x
    add  HL, BC         ; 1:11      65* HL + save  
    add  HL, HL         ; 1:11      66* 2x
    ld    B, H          ; 1:4       66*
    ld    C, L          ; 1:4       66* save 2x
    add  HL, HL         ; 1:11      66* 4x
    add  HL, HL         ; 1:11      66* 8x
    add  HL, HL         ; 1:11      66* 16x
    add  HL, HL         ; 1:11      66* 32x
    add  HL, HL         ; 1:11      66* 64x
    add  HL, BC         ; 1:11      66* HL + save  
    ld    B, H          ; 1:4       67*
    ld    A, L          ; 1:4       67* save 1x
    add  HL, HL         ; 1:11      67* 2x
    add   A, L          ; 1:4       67* +
    ld    C, A          ; 1:4       67* +
    ld    A, B          ; 1:4       67* +
    adc   A, H          ; 1:4       67* +
    ld    B, A          ; 1:4       67* + save 2x
    add  HL, HL         ; 1:11      67* 4x
    add  HL, HL         ; 1:11      67* 8x
    add  HL, HL         ; 1:11      67* 16x
    add  HL, HL         ; 1:11      67* 32x
    add  HL, HL         ; 1:11      67* 64x
    add  HL, BC         ; 1:11      67* HL + save  
    add  HL, HL         ; 1:11      68* 2x
    add  HL, HL         ; 1:11      68* 4x
    ld    B, H          ; 1:4       68*
    ld    C, L          ; 1:4       68* save 4x
    add  HL, HL         ; 1:11      68* 8x
    add  HL, HL         ; 1:11      68* 16x
    add  HL, HL         ; 1:11      68* 32x
    add  HL, HL         ; 1:11      68* 64x
    add  HL, BC         ; 1:11      68* HL + save  
    ld    B, H          ; 1:4       69*
    ld    A, L          ; 1:4       69* save 1x
    add  HL, HL         ; 1:11      69* 2x
    add  HL, HL         ; 1:11      69* 4x
    add   A, L          ; 1:4       69* +
    ld    C, A          ; 1:4       69* +
    ld    A, B          ; 1:4       69* +
    adc   A, H          ; 1:4       69* +
    ld    B, A          ; 1:4       69* + save 4x
    add  HL, HL         ; 1:11      69* 8x
    add  HL, HL         ; 1:11      69* 16x
    add  HL, HL         ; 1:11      69* 32x
    add  HL, HL         ; 1:11      69* 64x
    add  HL, BC         ; 1:11      69* HL + save  
    add  HL, HL         ; 1:11      70* 2x
    ld    B, H          ; 1:4       70*
    ld    A, L          ; 1:4       70* save 2x
    add  HL, HL         ; 1:11      70* 4x
    add   A, L          ; 1:4       70* +
    ld    C, A          ; 1:4       70* +
    ld    A, B          ; 1:4       70* +
    adc   A, H          ; 1:4       70* +
    ld    B, A          ; 1:4       70* + save 4x
    add  HL, HL         ; 1:11      70* 8x
    add  HL, HL         ; 1:11      70* 16x
    add  HL, HL         ; 1:11      70* 32x
    add  HL, HL         ; 1:11      70* 64x
    add  HL, BC         ; 1:11      70* HL + save 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, D          ; 1:4       71*
    ld    C, E          ; 1:4       71*
    ld    D, H          ; 1:4       71*
    ld    E, L          ; 1:4       71* save 1x
    add  HL, HL         ; 1:11      71* 2x
    ex   DE, HL         ; 1:4       71* +
    add  HL, DE         ; 1:11      71* + save 2x
    ex   DE, HL         ; 1:4       71* +
    add  HL, HL         ; 1:11      71* 4x
    ex   DE, HL         ; 1:4       71* +
    add  HL, DE         ; 1:11      71* + save 4x
    ex   DE, HL         ; 1:4       71* +
    add  HL, HL         ; 1:11      71* 8x
    add  HL, HL         ; 1:11      71* 16x
    add  HL, HL         ; 1:11      71* 32x
    add  HL, HL         ; 1:11      71* 64x
    add  HL, DE         ; 1:11      71* HL + save
    ld    D, B          ; 1:4       71*
    ld    E, C          ; 1:4       71*  
    add  HL, HL         ; 1:11      72* 2x
    add  HL, HL         ; 1:11      72* 4x
    add  HL, HL         ; 1:11      72* 8x
    ld    B, H          ; 1:4       72*
    ld    C, L          ; 1:4       72* save 8x
    add  HL, HL         ; 1:11      72* 16x
    add  HL, HL         ; 1:11      72* 32x
    add  HL, HL         ; 1:11      72* 64x
    add  HL, BC         ; 1:11      72* HL + save  
    ld    B, H          ; 1:4       73*
    ld    A, L          ; 1:4       73* save 1x
    add  HL, HL         ; 1:11      73* 2x
    add  HL, HL         ; 1:11      73* 4x
    add  HL, HL         ; 1:11      73* 8x
    add   A, L          ; 1:4       73* +
    ld    C, A          ; 1:4       73* +
    ld    A, B          ; 1:4       73* +
    adc   A, H          ; 1:4       73* +
    ld    B, A          ; 1:4       73* + save 8x
    add  HL, HL         ; 1:11      73* 16x
    add  HL, HL         ; 1:11      73* 32x
    add  HL, HL         ; 1:11      73* 64x
    add  HL, BC         ; 1:11      73* HL + save  
    add  HL, HL         ; 1:11      74* 2x
    ld    B, H          ; 1:4       74*
    ld    A, L          ; 1:4       74* save 2x
    add  HL, HL         ; 1:11      74* 4x
    add  HL, HL         ; 1:11      74* 8x
    add   A, L          ; 1:4       74* +
    ld    C, A          ; 1:4       74* +
    ld    A, B          ; 1:4       74* +
    adc   A, H          ; 1:4       74* +
    ld    B, A          ; 1:4       74* + save 8x
    add  HL, HL         ; 1:11      74* 16x
    add  HL, HL         ; 1:11      74* 32x
    add  HL, HL         ; 1:11      74* 64x
    add  HL, BC         ; 1:11      74* HL + save  
    ld    B, D          ; 1:4       75*
    ld    C, E          ; 1:4       75*
    ld    D, H          ; 1:4       75*
    ld    E, L          ; 1:4       75* save 1x
    add  HL, HL         ; 1:11      75* 2x
    ex   DE, HL         ; 1:4       75* +
    add  HL, DE         ; 1:11      75* + save 2x
    ex   DE, HL         ; 1:4       75* +
    add  HL, HL         ; 1:11      75* 4x
    add  HL, HL         ; 1:11      75* 8x
    ex   DE, HL         ; 1:4       75* +
    add  HL, DE         ; 1:11      75* + save 8x
    ex   DE, HL         ; 1:4       75* +
    add  HL, HL         ; 1:11      75* 16x
    add  HL, HL         ; 1:11      75* 32x
    add  HL, HL         ; 1:11      75* 64x
    add  HL, DE         ; 1:11      75* HL + save
    ld    D, B          ; 1:4       75*
    ld    E, C          ; 1:4       75*  
    add  HL, HL         ; 1:11      76* 2x
    add  HL, HL         ; 1:11      76* 4x
    ld    B, H          ; 1:4       76*
    ld    A, L          ; 1:4       76* save 4x
    add  HL, HL         ; 1:11      76* 8x
    add   A, L          ; 1:4       76* +
    ld    C, A          ; 1:4       76* +
    ld    A, B          ; 1:4       76* +
    adc   A, H          ; 1:4       76* +
    ld    B, A          ; 1:4       76* + save 8x
    add  HL, HL         ; 1:11      76* 16x
    add  HL, HL         ; 1:11      76* 32x
    add  HL, HL         ; 1:11      76* 64x
    add  HL, BC         ; 1:11      76* HL + save  
    ld    B, D          ; 1:4       77*
    ld    C, E          ; 1:4       77*
    ld    D, H          ; 1:4       77*
    ld    E, L          ; 1:4       77* save 1x
    add  HL, HL         ; 1:11      77* 2x
    add  HL, HL         ; 1:11      77* 4x
    ex   DE, HL         ; 1:4       77* +
    add  HL, DE         ; 1:11      77* + save 4x
    ex   DE, HL         ; 1:4       77* +
    add  HL, HL         ; 1:11      77* 8x
    ex   DE, HL         ; 1:4       77* +
    add  HL, DE         ; 1:11      77* + save 8x
    ex   DE, HL         ; 1:4       77* +
    add  HL, HL         ; 1:11      77* 16x
    add  HL, HL         ; 1:11      77* 32x
    add  HL, HL         ; 1:11      77* 64x
    add  HL, DE         ; 1:11      77* HL + save
    ld    D, B          ; 1:4       77*
    ld    E, C          ; 1:4       77*  
    ld    B, D          ; 1:4       78*
    ld    C, E          ; 1:4       78*
    add  HL, HL         ; 1:11      78* 2x
    ld    D, H          ; 1:4       78*
    ld    E, L          ; 1:4       78* save 2x
    add  HL, HL         ; 1:11      78* 4x
    ex   DE, HL         ; 1:4       78* +
    add  HL, DE         ; 1:11      78* + save 4x
    ex   DE, HL         ; 1:4       78* +
    add  HL, HL         ; 1:11      78* 8x
    ex   DE, HL         ; 1:4       78* +
    add  HL, DE         ; 1:11      78* + save 8x
    ex   DE, HL         ; 1:4       78* +
    add  HL, HL         ; 1:11      78* 16x
    add  HL, HL         ; 1:11      78* 32x
    add  HL, HL         ; 1:11      78* 64x
    add  HL, DE         ; 1:11      78* HL + save
    ld    D, B          ; 1:4       78*
    ld    E, C          ; 1:4       78*  
    ld    B, D          ; 1:4       79*
    ld    C, E          ; 1:4       79*
    ld    D, H          ; 1:4       79*
    ld    E, L          ; 1:4       79* save 1x
    add  HL, HL         ; 1:11      79* 2x
    add  HL, HL         ; 1:11      79* 4x
    add  HL, HL         ; 1:11      79* 8x
    add  HL, HL         ; 1:11      79* 16x
    ex   DE, HL         ; 1:4       79* +
    add  HL, DE         ; 1:11      79* + save 16x
    ex   DE, HL         ; 1:4       79* +
    add  HL, HL         ; 1:11      79* 32x
    ex   DE, HL         ; 1:4       79* +
    add  HL, DE         ; 1:11      79* + save 32x
    ex   DE, HL         ; 1:4       79* +
    add  HL, HL         ; 1:11      79* 64x
    add  HL, HL         ; 1:11      79* 128x
    or    A             ; 1:4       79*
    sbc  HL, DE         ; 2:15      79* HL - save
    ld    D, B          ; 1:4       79*
    ld    E, C          ; 1:4       79*  
    add  HL, HL         ; 1:11      80* 2x
    add  HL, HL         ; 1:11      80* 4x
    add  HL, HL         ; 1:11      80* 8x
    add  HL, HL         ; 1:11      80* 16x
    ld    B, H          ; 1:4       80*
    ld    C, L          ; 1:4       80* save 16x
    add  HL, HL         ; 1:11      80* 32x
    add  HL, HL         ; 1:11      80* 64x
    add  HL, BC         ; 1:11      80* HL + save 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, H          ; 1:4       81*
    ld    A, L          ; 1:4       81* save 1x
    add  HL, HL         ; 1:11      81* 2x
    add  HL, HL         ; 1:11      81* 4x
    add  HL, HL         ; 1:11      81* 8x
    add  HL, HL         ; 1:11      81* 16x
    add   A, L          ; 1:4       81* +
    ld    C, A          ; 1:4       81* +
    ld    A, B          ; 1:4       81* +
    adc   A, H          ; 1:4       81* +
    ld    B, A          ; 1:4       81* + save 16x
    add  HL, HL         ; 1:11      81* 32x
    add  HL, HL         ; 1:11      81* 64x
    add  HL, BC         ; 1:11      81* HL + save  
    add  HL, HL         ; 1:11      82* 2x
    ld    B, H          ; 1:4       82*
    ld    A, L          ; 1:4       82* save 2x
    add  HL, HL         ; 1:11      82* 4x
    add  HL, HL         ; 1:11      82* 8x
    add  HL, HL         ; 1:11      82* 16x
    add   A, L          ; 1:4       82* +
    ld    C, A          ; 1:4       82* +
    ld    A, B          ; 1:4       82* +
    adc   A, H          ; 1:4       82* +
    ld    B, A          ; 1:4       82* + save 16x
    add  HL, HL         ; 1:11      82* 32x
    add  HL, HL         ; 1:11      82* 64x
    add  HL, BC         ; 1:11      82* HL + save  
    ld    B, D          ; 1:4       83*
    ld    C, E          ; 1:4       83*
    ld    D, H          ; 1:4       83*
    ld    E, L          ; 1:4       83* save 1x
    add  HL, HL         ; 1:11      83* 2x
    ex   DE, HL         ; 1:4       83* +
    add  HL, DE         ; 1:11      83* + save 2x
    ex   DE, HL         ; 1:4       83* +
    add  HL, HL         ; 1:11      83* 4x
    add  HL, HL         ; 1:11      83* 8x
    add  HL, HL         ; 1:11      83* 16x
    ex   DE, HL         ; 1:4       83* +
    add  HL, DE         ; 1:11      83* + save 16x
    ex   DE, HL         ; 1:4       83* +
    add  HL, HL         ; 1:11      83* 32x
    add  HL, HL         ; 1:11      83* 64x
    add  HL, DE         ; 1:11      83* HL + save
    ld    D, B          ; 1:4       83*
    ld    E, C          ; 1:4       83*  
    add  HL, HL         ; 1:11      84* 2x
    add  HL, HL         ; 1:11      84* 4x
    ld    B, H          ; 1:4       84*
    ld    A, L          ; 1:4       84* save 4x
    add  HL, HL         ; 1:11      84* 8x
    add  HL, HL         ; 1:11      84* 16x
    add   A, L          ; 1:4       84* +
    ld    C, A          ; 1:4       84* +
    ld    A, B          ; 1:4       84* +
    adc   A, H          ; 1:4       84* +
    ld    B, A          ; 1:4       84* + save 16x
    add  HL, HL         ; 1:11      84* 32x
    add  HL, HL         ; 1:11      84* 64x
    add  HL, BC         ; 1:11      84* HL + save  
    ld    B, D          ; 1:4       85*
    ld    C, E          ; 1:4       85*
    ld    D, H          ; 1:4       85*
    ld    E, L          ; 1:4       85* save 1x
    add  HL, HL         ; 1:11      85* 2x
    add  HL, HL         ; 1:11      85* 4x
    ex   DE, HL         ; 1:4       85* +
    add  HL, DE         ; 1:11      85* + save 4x
    ex   DE, HL         ; 1:4       85* +
    add  HL, HL         ; 1:11      85* 8x
    add  HL, HL         ; 1:11      85* 16x
    ex   DE, HL         ; 1:4       85* +
    add  HL, DE         ; 1:11      85* + save 16x
    ex   DE, HL         ; 1:4       85* +
    add  HL, HL         ; 1:11      85* 32x
    add  HL, HL         ; 1:11      85* 64x
    add  HL, DE         ; 1:11      85* HL + save
    ld    D, B          ; 1:4       85*
    ld    E, C          ; 1:4       85*  
    ld    B, D          ; 1:4       86*
    ld    C, E          ; 1:4       86*
    add  HL, HL         ; 1:11      86* 2x
    ld    D, H          ; 1:4       86*
    ld    E, L          ; 1:4       86* save 2x
    add  HL, HL         ; 1:11      86* 4x
    ex   DE, HL         ; 1:4       86* +
    add  HL, DE         ; 1:11      86* + save 4x
    ex   DE, HL         ; 1:4       86* +
    add  HL, HL         ; 1:11      86* 8x
    add  HL, HL         ; 1:11      86* 16x
    ex   DE, HL         ; 1:4       86* +
    add  HL, DE         ; 1:11      86* + save 16x
    ex   DE, HL         ; 1:4       86* +
    add  HL, HL         ; 1:11      86* 32x
    add  HL, HL         ; 1:11      86* 64x
    add  HL, DE         ; 1:11      86* HL + save
    ld    D, B          ; 1:4       86*
    ld    E, C          ; 1:4       86*  
    ld    B, D          ; 1:4       87*
    ld    C, E          ; 1:4       87*
    ld    D, H          ; 1:4       87*
    ld    E, L          ; 1:4       87* save 1x
    add  HL, HL         ; 1:11      87* 2x
    add  HL, HL         ; 1:11      87* 4x
    add  HL, HL         ; 1:11      87* 8x
    ex   DE, HL         ; 1:4       87* +
    add  HL, DE         ; 1:11      87* + save 8x
    ex   DE, HL         ; 1:4       87* +
    add  HL, HL         ; 1:11      87* 16x
    add  HL, HL         ; 1:11      87* 32x
    ex   DE, HL         ; 1:4       87* +
    add  HL, DE         ; 1:11      87* + save 32x
    ex   DE, HL         ; 1:4       87* +
    add  HL, HL         ; 1:11      87* 64x
    add  HL, HL         ; 1:11      87* 128x
    or    A             ; 1:4       87*
    sbc  HL, DE         ; 2:15      87* HL - save
    ld    D, B          ; 1:4       87*
    ld    E, C          ; 1:4       87*  
    add  HL, HL         ; 1:11      88* 2x
    add  HL, HL         ; 1:11      88* 4x
    add  HL, HL         ; 1:11      88* 8x
    ld    B, H          ; 1:4       88*
    ld    A, L          ; 1:4       88* save 8x
    add  HL, HL         ; 1:11      88* 16x
    add   A, L          ; 1:4       88* +
    ld    C, A          ; 1:4       88* +
    ld    A, B          ; 1:4       88* +
    adc   A, H          ; 1:4       88* +
    ld    B, A          ; 1:4       88* + save 16x
    add  HL, HL         ; 1:11      88* 32x
    add  HL, HL         ; 1:11      88* 64x
    add  HL, BC         ; 1:11      88* HL + save  
    ld    B, D          ; 1:4       89*
    ld    C, E          ; 1:4       89*
    ld    D, H          ; 1:4       89*
    ld    E, L          ; 1:4       89* save 1x
    add  HL, HL         ; 1:11      89* 2x
    add  HL, HL         ; 1:11      89* 4x
    add  HL, HL         ; 1:11      89* 8x
    ex   DE, HL         ; 1:4       89* +
    add  HL, DE         ; 1:11      89* + save 8x
    ex   DE, HL         ; 1:4       89* +
    add  HL, HL         ; 1:11      89* 16x
    ex   DE, HL         ; 1:4       89* +
    add  HL, DE         ; 1:11      89* + save 16x
    ex   DE, HL         ; 1:4       89* +
    add  HL, HL         ; 1:11      89* 32x
    add  HL, HL         ; 1:11      89* 64x
    add  HL, DE         ; 1:11      89* HL + save
    ld    D, B          ; 1:4       89*
    ld    E, C          ; 1:4       89*  
    ld    B, D          ; 1:4       90*
    ld    C, E          ; 1:4       90*
    add  HL, HL         ; 1:11      90* 2x
    ld    D, H          ; 1:4       90*
    ld    E, L          ; 1:4       90* save 2x
    add  HL, HL         ; 1:11      90* 4x
    add  HL, HL         ; 1:11      90* 8x
    ex   DE, HL         ; 1:4       90* +
    add  HL, DE         ; 1:11      90* + save 8x
    ex   DE, HL         ; 1:4       90* +
    add  HL, HL         ; 1:11      90* 16x
    ex   DE, HL         ; 1:4       90* +
    add  HL, DE         ; 1:11      90* + save 16x
    ex   DE, HL         ; 1:4       90* +
    add  HL, HL         ; 1:11      90* 32x
    add  HL, HL         ; 1:11      90* 64x
    add  HL, DE         ; 1:11      90* HL + save
    ld    D, B          ; 1:4       90*
    ld    E, C          ; 1:4       90* 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)  
    ld    B, D          ; 1:4       91*
    ld    C, E          ; 1:4       91*
    ld    D, H          ; 1:4       91*
    ld    E, L          ; 1:4       91* save 1x
    add  HL, HL         ; 1:11      91* 2x
    add  HL, HL         ; 1:11      91* 4x
    ex   DE, HL         ; 1:4       91* +
    add  HL, DE         ; 1:11      91* + save 4x
    ex   DE, HL         ; 1:4       91* +
    add  HL, HL         ; 1:11      91* 8x
    add  HL, HL         ; 1:11      91* 16x
    add  HL, HL         ; 1:11      91* 32x
    ex   DE, HL         ; 1:4       91* +
    add  HL, DE         ; 1:11      91* + save 32x
    ex   DE, HL         ; 1:4       91* +
    add  HL, HL         ; 1:11      91* 64x
    add  HL, HL         ; 1:11      91* 128x
    or    A             ; 1:4       91*
    sbc  HL, DE         ; 2:15      91* HL - save
    ld    D, B          ; 1:4       91*
    ld    E, C          ; 1:4       91*  
    ld    B, D          ; 1:4       92*
    ld    C, E          ; 1:4       92*
    add  HL, HL         ; 1:11      92* 2x
    add  HL, HL         ; 1:11      92* 4x
    ld    D, H          ; 1:4       92*
    ld    E, L          ; 1:4       92* save 4x
    add  HL, HL         ; 1:11      92* 8x
    ex   DE, HL         ; 1:4       92* +
    add  HL, DE         ; 1:11      92* + save 8x
    ex   DE, HL         ; 1:4       92* +
    add  HL, HL         ; 1:11      92* 16x
    ex   DE, HL         ; 1:4       92* +
    add  HL, DE         ; 1:11      92* + save 16x
    ex   DE, HL         ; 1:4       92* +
    add  HL, HL         ; 1:11      92* 32x
    add  HL, HL         ; 1:11      92* 64x
    add  HL, DE         ; 1:11      92* HL + save
    ld    D, B          ; 1:4       92*
    ld    E, C          ; 1:4       92*  
    ld    B, D          ; 1:4       93*
    ld    C, E          ; 1:4       93*
    ld    D, H          ; 1:4       93*
    ld    E, L          ; 1:4       93* save 1x
    add  HL, HL         ; 1:11      93* 2x
    ex   DE, HL         ; 1:4       93* +
    add  HL, DE         ; 1:11      93* + save 2x
    ex   DE, HL         ; 1:4       93* +
    add  HL, HL         ; 1:11      93* 4x
    add  HL, HL         ; 1:11      93* 8x
    add  HL, HL         ; 1:11      93* 16x
    add  HL, HL         ; 1:11      93* 32x
    ex   DE, HL         ; 1:4       93* +
    add  HL, DE         ; 1:11      93* + save 32x
    ex   DE, HL         ; 1:4       93* +
    add  HL, HL         ; 1:11      93* 64x
    add  HL, HL         ; 1:11      93* 128x
    or    A             ; 1:4       93*
    sbc  HL, DE         ; 2:15      93* HL - save
    ld    D, B          ; 1:4       93*
    ld    E, C          ; 1:4       93*  
    ld    B, D          ; 1:4       94*
    ld    C, E          ; 1:4       94*
    ld    D, H          ; 1:4       94*
    ld    E, L          ; 1:4       94* save 1x
    ex   DE, HL         ; 1:4       94* +
    add  HL, DE         ; 1:11      94* + save 1x
    ex   DE, HL         ; 1:4       94* +
    add  HL, HL         ; 1:11      94* 2x
    add  HL, HL         ; 1:11      94* 4x
    add  HL, HL         ; 1:11      94* 8x
    add  HL, HL         ; 1:11      94* 16x
    add  HL, HL         ; 1:11      94* 32x
    ex   DE, HL         ; 1:4       94* +
    add  HL, DE         ; 1:11      94* + save 32x
    ex   DE, HL         ; 1:4       94* +
    add  HL, HL         ; 1:11      94* 64x
    add  HL, HL         ; 1:11      94* 128x
    or    A             ; 1:4       94*
    sbc  HL, DE         ; 2:15      94* HL - save
    ld    D, B          ; 1:4       94*
    ld    E, C          ; 1:4       94*  
    ld    B, H          ; 1:4       95*
    ld    A, L          ; 1:4       95* save 1x
    add  HL, HL         ; 1:11      95* 2x
    add  HL, HL         ; 1:11      95* 4x
    add  HL, HL         ; 1:11      95* 8x
    add  HL, HL         ; 1:11      95* 16x
    add  HL, HL         ; 1:11      95* 32x
    add   A, L          ; 1:4       95* +
    ld    C, A          ; 1:4       95* +
    ld    A, B          ; 1:4       95* +
    adc   A, H          ; 1:4       95* +
    ld    B, A          ; 1:4       95* + save 32x
    add  HL, HL         ; 1:11      95* 64x
    add  HL, HL         ; 1:11      95* 128x
    or    A             ; 1:4       95*
    sbc  HL, BC         ; 2:15      95* HL - save  
    add  HL, HL         ; 1:11      96* 2x
    add  HL, HL         ; 1:11      96* 4x
    add  HL, HL         ; 1:11      96* 8x
    add  HL, HL         ; 1:11      96* 16x
    add  HL, HL         ; 1:11      96* 32x
    ld    B, H          ; 1:4       96*
    ld    C, L          ; 1:4       96* save 32x
    add  HL, HL         ; 1:11      96* 64x
    add  HL, BC         ; 1:11      96* HL + save  
    ld    B, H          ; 1:4       97*
    ld    A, L          ; 1:4       97* save 1x
    add  HL, HL         ; 1:11      97* 2x
    add  HL, HL         ; 1:11      97* 4x
    add  HL, HL         ; 1:11      97* 8x
    add  HL, HL         ; 1:11      97* 16x
    add  HL, HL         ; 1:11      97* 32x
    add   A, L          ; 1:4       97* +
    ld    C, A          ; 1:4       97* +
    ld    A, B          ; 1:4       97* +
    adc   A, H          ; 1:4       97* +
    ld    B, A          ; 1:4       97* + save 32x
    add  HL, HL         ; 1:11      97* 64x
    add  HL, BC         ; 1:11      97* HL + save  
    add  HL, HL         ; 1:11      98* 2x
    ld    B, H          ; 1:4       98*
    ld    A, L          ; 1:4       98* save 2x
    add  HL, HL         ; 1:11      98* 4x
    add  HL, HL         ; 1:11      98* 8x
    add  HL, HL         ; 1:11      98* 16x
    add  HL, HL         ; 1:11      98* 32x
    add   A, L          ; 1:4       98* +
    ld    C, A          ; 1:4       98* +
    ld    A, B          ; 1:4       98* +
    adc   A, H          ; 1:4       98* +
    ld    B, A          ; 1:4       98* + save 32x
    add  HL, HL         ; 1:11      98* 64x
    add  HL, BC         ; 1:11      98* HL + save  
    ld    B, D          ; 1:4       99*
    ld    C, E          ; 1:4       99*
    ld    D, H          ; 1:4       99*
    ld    E, L          ; 1:4       99* save 1x
    add  HL, HL         ; 1:11      99* 2x
    ex   DE, HL         ; 1:4       99* +
    add  HL, DE         ; 1:11      99* + save 2x
    ex   DE, HL         ; 1:4       99* +
    add  HL, HL         ; 1:11      99* 4x
    add  HL, HL         ; 1:11      99* 8x
    add  HL, HL         ; 1:11      99* 16x
    add  HL, HL         ; 1:11      99* 32x
    ex   DE, HL         ; 1:4       99* +
    add  HL, DE         ; 1:11      99* + save 32x
    ex   DE, HL         ; 1:4       99* +
    add  HL, HL         ; 1:11      99* 64x
    add  HL, DE         ; 1:11      99* HL + save
    ld    D, B          ; 1:4       99*
    ld    E, C          ; 1:4       99* 
    add  HL, HL         ; 1:11      100* 2x
    add  HL, HL         ; 1:11      100* 4x
    ld    B, H          ; 1:4       100*
    ld    A, L          ; 1:4       100* save 4x
    add  HL, HL         ; 1:11      100* 8x
    add  HL, HL         ; 1:11      100* 16x
    add  HL, HL         ; 1:11      100* 32x
    add   A, L          ; 1:4       100* +
    ld    C, A          ; 1:4       100* +
    ld    A, B          ; 1:4       100* +
    adc   A, H          ; 1:4       100* +
    ld    B, A          ; 1:4       100* + save 32x
    add  HL, HL         ; 1:11      100* 64x
    add  HL, BC         ; 1:11      100* HL + save 
    call PRINT_NUM      ; 3:17      . 
    push DE             ; 1:11      print
    push HL             ; 1:11      print
    ld    L, 0x1A       ; 2:7       print Upper screen
    call 0x1605         ; 3:17      print Open channel
    ld   BC, size110    ; 3:10      print Length of string to print
    ld   DE, string110  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string
    pop  HL             ; 1:10      print
    pop  DE             ; 1:10      print


    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====

; Input: A = or numbers, DE string index, HL = number, BC = 10000,1000,100,10,1
; Output: Write number to memory
; Pollutes: AF, AF', HL, B, DE
NEXTNUMBER:
    ex   AF, AF'        ; 1:4
    xor   A             ; 1:4

    inc   A             ; 1:4
    sbc  HL, BC         ; 2:15
    jr   nc, $-3        ; 2:7/12
    
    add  HL, BC         ; 1:11
    dec   A             ; 1:4
    ld    B, A          ; 1:4    
    add   A, '0'        ; 2:7       0   
    ex   AF, AF'        ; 1:4
    
    or    B             ; 1:4
    ret   z             ; 1:5/11    zatim same nuly
    
    ex   AF, AF'        ; 1:4
    ld  (DE), A         ; 1:7
    inc  DE             ; 1:6
    ex   AF, AF'        ; 1:4
    ret                 ; 1:10

; Input: HL
; Output: Print decimal number in HL
; Pollutes: AF, AF', BC, delete top stack
PRINT_NUM:
    push DE             ; 1:11

    ld   DE, STRNUM     ; 3:10

    bit   7, H          ; 2:8
    jr    z, PRINT_NUM_P; 2:7/12
    
    ld    A, '-'        ; 2:7
    ld  (DE), A         ; 1:7
    inc  DE             ; 1:6

    ld    A, L          ; 1:4
    cpl                 ; 1:4
    ld    L, A          ; 1:4
    ld    A, H          ; 1:4
    cpl                 ; 1:4
    ld    H, A          ; 1:4
    inc  HL             ; 1:6
PRINT_NUM_P:
    
    xor   A             ; 1:4
    ld   BC, 10000      ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, 1000       ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, 100        ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, 10         ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld    A, '0'        ; 2:7
    add   A, L          ; 1:4
    ld  (DE), A         ; 1:7
    
    ex   DE, HL         ; 1:4
    
    inc  HL             ; 1:6
    ld  (HL), 0x20      ; 2:10      space after
    
    ld   DE, STRNUM     ; 3:10
    sbc  HL, DE         ; 2:15
    push HL             ; 1:11
            
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    
    pop  BC             ; 1:10      Length-1 of string to print
    ld   DE, STRNUM     ; 3:10      Address of string
    call 0x2040         ; 3:17      Print our string

    pop  HL             ; 1:10      last DE
    pop  BC             ; 1:10      ret
    pop  DE             ; 1:10
    push BC             ; 1:11      ret
    ret                 ; 1:10
STRNUM:
DB      "Dw0rkin"
VARIABLE_SECTION:

STRING_SECTION:
string110:
db "= 51200 = -14336",0xd
size110 EQU $ - string110
string109:
db "= 61696 = -3840",0xd
size109 EQU $ - string109
string108:
db "= 55296 = -10240",0xd
size108 EQU $ - string108
string107:
db "= 18432 = 18432",0xd
size107 EQU $ - string107
string106:
db "= 4608 = 4608",0xd
size106 EQU $ - string106
string105:
db "= 9728 = 9728",0xd
size105 EQU $ - string105
string104:
db "= 4096 = 4096",0xd
size104 EQU $ - string104
string103:
db "= 18688 = 18688",0xd
size103 EQU $ - string103
string102:
db "= 52224 = -13312",0xd
size102 EQU $ - string102
string101:
db "= 24320 = 24320",0xd
size101 EQU $ - string101


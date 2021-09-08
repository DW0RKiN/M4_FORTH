ORG 0x6000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10      Init Return address stack
    exx                 ; 1:4


    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)       
                        ;[4:30]     3 *   Variant mk1: HL * (2^a + 2^b) = HL * (b_0011)   
    ld    B, H          ; 1:4       3 *
    ld    C, L          ; 1:4       3 *   [1x] 
    add  HL, HL         ; 1:11      3 *   2x 
    add  HL, BC         ; 1:11      3 *   [3x] = 2x + 1x     
                        ;[5:41]     5 *   Variant mk1: HL * (2^a + 2^b) = HL * (b_0101)   
    ld    B, H          ; 1:4       5 *
    ld    C, L          ; 1:4       5 *   [1x] 
    add  HL, HL         ; 1:11      5 *   2x 
    add  HL, HL         ; 1:11      5 *   4x 
    add  HL, BC         ; 1:11      5 *   [5x] = 4x + 1x     
                        ;[6:52]     7 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0111)
    ld    B, H          ; 1:4       7 *
    ld    C, L          ; 1:4       7 *   1       1x = base 
    add  HL, HL         ; 1:11      7 *   1  *2 = 2x
    add  HL, BC         ; 1:11      7 *      +1 = 3x 
    add  HL, HL         ; 1:11      7 *   1  *2 = 6x
    add  HL, BC         ; 1:11      7 *      +1 = 7x     
                        ;[6:52]     9 *   Variant mk1: HL * (2^a + 2^b) = HL * (b_1001)   
    ld    B, H          ; 1:4       9 *
    ld    C, L          ; 1:4       9 *   [1x] 
    add  HL, HL         ; 1:11      9 *   2x 
    add  HL, HL         ; 1:11      9 *   4x 
    add  HL, HL         ; 1:11      9 *   8x 
    add  HL, BC         ; 1:11      9 *   [9x] = 8x + 1x     
                        ;[7:63]     11 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011)
    ld    B, H          ; 1:4       11 *
    ld    C, L          ; 1:4       11 *   1       1x = base 
    add  HL, HL         ; 1:11      11 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      11 *   1  *2 = 4x
    add  HL, BC         ; 1:11      11 *      +1 = 5x 
    add  HL, HL         ; 1:11      11 *   1  *2 = 10x
    add  HL, BC         ; 1:11      11 *      +1 = 11x  

                        ;[7:63]     13 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101)
    ld    B, H          ; 1:4       13 *
    ld    C, L          ; 1:4       13 *   1       1x = base 
    add  HL, HL         ; 1:11      13 *   1  *2 = 2x
    add  HL, BC         ; 1:11      13 *      +1 = 3x 
    add  HL, HL         ; 1:11      13 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      13 *   1  *2 = 12x
    add  HL, BC         ; 1:11      13 *      +1 = 13x    
                        ;[8:74]     15 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1111)
    ld    B, H          ; 1:4       15 *
    ld    C, L          ; 1:4       15 *   1       1x = base 
    add  HL, HL         ; 1:11      15 *   1  *2 = 2x
    add  HL, BC         ; 1:11      15 *      +1 = 3x 
    add  HL, HL         ; 1:11      15 *   1  *2 = 6x
    add  HL, BC         ; 1:11      15 *      +1 = 7x 
    add  HL, HL         ; 1:11      15 *   1  *2 = 14x
    add  HL, BC         ; 1:11      15 *      +1 = 15x    
                        ;[7:63]     17 *   Variant mk1: HL * (2^a + 2^b) = HL * (b_0001_0001)   
    ld    B, H          ; 1:4       17 *
    ld    C, L          ; 1:4       17 *   [1x] 
    add  HL, HL         ; 1:11      17 *   2x 
    add  HL, HL         ; 1:11      17 *   4x 
    add  HL, HL         ; 1:11      17 *   8x 
    add  HL, HL         ; 1:11      17 *   16x 
    add  HL, BC         ; 1:11      17 *   [17x] = 16x + 1x    
                        ;[8:74]     19 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_0011)
    ld    B, H          ; 1:4       19 *
    ld    C, L          ; 1:4       19 *   1       1x = base 
    add  HL, HL         ; 1:11      19 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      19 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      19 *   1  *2 = 8x
    add  HL, BC         ; 1:11      19 *      +1 = 9x 
    add  HL, HL         ; 1:11      19 *   1  *2 = 18x
    add  HL, BC         ; 1:11      19 *      +1 = 19x    
                        ;[8:74]     21 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_0101)
    ld    B, H          ; 1:4       21 *
    ld    C, L          ; 1:4       21 *   1       1x = base 
    add  HL, HL         ; 1:11      21 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      21 *   1  *2 = 4x
    add  HL, BC         ; 1:11      21 *      +1 = 5x 
    add  HL, HL         ; 1:11      21 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      21 *   1  *2 = 20x
    add  HL, BC         ; 1:11      21 *      +1 = 21x    
                        ;[9:85]     23 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_0111)
    ld    B, H          ; 1:4       23 *
    ld    C, L          ; 1:4       23 *   1       1x = base 
    add  HL, HL         ; 1:11      23 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      23 *   1  *2 = 4x
    add  HL, BC         ; 1:11      23 *      +1 = 5x 
    add  HL, HL         ; 1:11      23 *   1  *2 = 10x
    add  HL, BC         ; 1:11      23 *      +1 = 11x 
    add  HL, HL         ; 1:11      23 *   1  *2 = 22x
    add  HL, BC         ; 1:11      23 *      +1 = 23x    
                        ;[8:74]     25 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001)
    ld    B, H          ; 1:4       25 *
    ld    C, L          ; 1:4       25 *   1       1x = base 
    add  HL, HL         ; 1:11      25 *   1  *2 = 2x
    add  HL, BC         ; 1:11      25 *      +1 = 3x 
    add  HL, HL         ; 1:11      25 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      25 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      25 *   1  *2 = 24x
    add  HL, BC         ; 1:11      25 *      +1 = 25x    
                        ;[9:85]     27 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1011)
    ld    B, H          ; 1:4       27 *
    ld    C, L          ; 1:4       27 *   1       1x = base 
    add  HL, HL         ; 1:11      27 *   1  *2 = 2x
    add  HL, BC         ; 1:11      27 *      +1 = 3x 
    add  HL, HL         ; 1:11      27 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      27 *   1  *2 = 12x
    add  HL, BC         ; 1:11      27 *      +1 = 13x 
    add  HL, HL         ; 1:11      27 *   1  *2 = 26x
    add  HL, BC         ; 1:11      27 *      +1 = 27x    
                        ;[9:85]     29 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1101)
    ld    B, H          ; 1:4       29 *
    ld    C, L          ; 1:4       29 *   1       1x = base 
    add  HL, HL         ; 1:11      29 *   1  *2 = 2x
    add  HL, BC         ; 1:11      29 *      +1 = 3x 
    add  HL, HL         ; 1:11      29 *   1  *2 = 6x
    add  HL, BC         ; 1:11      29 *      +1 = 7x 
    add  HL, HL         ; 1:11      29 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      29 *   1  *2 = 28x
    add  HL, BC         ; 1:11      29 *      +1 = 29x    
                        ;[10:82]    31 *   Variant mk1: HL * (2^a - 2^b) = HL * (b_0001_1111)   
    ld    B, H          ; 1:4       31 *
    ld    C, L          ; 1:4       31 *   [1x] 
    add  HL, HL         ; 1:11      31 *   2x 
    add  HL, HL         ; 1:11      31 *   4x 
    add  HL, HL         ; 1:11      31 *   8x 
    add  HL, HL         ; 1:11      31 *   16x 
    add  HL, HL         ; 1:11      31 *   32x 
    or    A             ; 1:4       31 *
    sbc  HL, BC         ; 2:15      31 *   [31x] = 32x - 1x    
                        ;[8:74]     33 *   Variant mk1: HL * (2^a + 2^b) = HL * (b_0010_0001)   
    ld    B, H          ; 1:4       33 *
    ld    C, L          ; 1:4       33 *   [1x] 
    add  HL, HL         ; 1:11      33 *   2x 
    add  HL, HL         ; 1:11      33 *   4x 
    add  HL, HL         ; 1:11      33 *   8x 
    add  HL, HL         ; 1:11      33 *   16x 
    add  HL, HL         ; 1:11      33 *   32x 
    add  HL, BC         ; 1:11      33 *   [33x] = 32x + 1x  

                        ;[9:85]     35 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0010_0011)
    ld    B, H          ; 1:4       35 *
    ld    C, L          ; 1:4       35 *   1       1x = base 
    add  HL, HL         ; 1:11      35 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      35 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      35 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      35 *   1  *2 = 16x
    add  HL, BC         ; 1:11      35 *      +1 = 17x 
    add  HL, HL         ; 1:11      35 *   1  *2 = 34x
    add  HL, BC         ; 1:11      35 *      +1 = 35x    
                        ;[9:85]     37 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0010_0101)
    ld    B, H          ; 1:4       37 *
    ld    C, L          ; 1:4       37 *   1       1x = base 
    add  HL, HL         ; 1:11      37 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      37 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      37 *   1  *2 = 8x
    add  HL, BC         ; 1:11      37 *      +1 = 9x 
    add  HL, HL         ; 1:11      37 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      37 *   1  *2 = 36x
    add  HL, BC         ; 1:11      37 *      +1 = 37x    
                        ;[10:96]    39 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0010_0111)
    ld    B, H          ; 1:4       39 *
    ld    C, L          ; 1:4       39 *   1       1x = base 
    add  HL, HL         ; 1:11      39 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      39 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      39 *   1  *2 = 8x
    add  HL, BC         ; 1:11      39 *      +1 = 9x 
    add  HL, HL         ; 1:11      39 *   1  *2 = 18x
    add  HL, BC         ; 1:11      39 *      +1 = 19x 
    add  HL, HL         ; 1:11      39 *   1  *2 = 38x
    add  HL, BC         ; 1:11      39 *      +1 = 39x    
                        ;[9:85]     41 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0010_1001)
    ld    B, H          ; 1:4       41 *
    ld    C, L          ; 1:4       41 *   1       1x = base 
    add  HL, HL         ; 1:11      41 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      41 *   1  *2 = 4x
    add  HL, BC         ; 1:11      41 *      +1 = 5x 
    add  HL, HL         ; 1:11      41 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      41 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      41 *   1  *2 = 40x
    add  HL, BC         ; 1:11      41 *      +1 = 41x    
                        ;[10:96]    43 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0010_1011)
    ld    B, H          ; 1:4       43 *
    ld    C, L          ; 1:4       43 *   1       1x = base 
    add  HL, HL         ; 1:11      43 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      43 *   1  *2 = 4x
    add  HL, BC         ; 1:11      43 *      +1 = 5x 
    add  HL, HL         ; 1:11      43 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      43 *   1  *2 = 20x
    add  HL, BC         ; 1:11      43 *      +1 = 21x 
    add  HL, HL         ; 1:11      43 *   1  *2 = 42x
    add  HL, BC         ; 1:11      43 *      +1 = 43x    
                        ;[10:96]    45 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0010_1101)
    ld    B, H          ; 1:4       45 *
    ld    C, L          ; 1:4       45 *   1       1x = base 
    add  HL, HL         ; 1:11      45 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      45 *   1  *2 = 4x
    add  HL, BC         ; 1:11      45 *      +1 = 5x 
    add  HL, HL         ; 1:11      45 *   1  *2 = 10x
    add  HL, BC         ; 1:11      45 *      +1 = 11x 
    add  HL, HL         ; 1:11      45 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      45 *   1  *2 = 44x
    add  HL, BC         ; 1:11      45 *      +1 = 45x    
                        ;[11:107]   47 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0010_1111)
    ld    B, H          ; 1:4       47 *
    ld    C, L          ; 1:4       47 *   1       1x = base 
    add  HL, HL         ; 1:11      47 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      47 *   1  *2 = 4x
    add  HL, BC         ; 1:11      47 *      +1 = 5x 
    add  HL, HL         ; 1:11      47 *   1  *2 = 10x
    add  HL, BC         ; 1:11      47 *      +1 = 11x 
    add  HL, HL         ; 1:11      47 *   1  *2 = 22x
    add  HL, BC         ; 1:11      47 *      +1 = 23x 
    add  HL, HL         ; 1:11      47 *   1  *2 = 46x
    add  HL, BC         ; 1:11      47 *      +1 = 47x    
                        ;[9:85]     49 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0011_0001)
    ld    B, H          ; 1:4       49 *
    ld    C, L          ; 1:4       49 *   1       1x = base 
    add  HL, HL         ; 1:11      49 *   1  *2 = 2x
    add  HL, BC         ; 1:11      49 *      +1 = 3x 
    add  HL, HL         ; 1:11      49 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      49 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      49 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      49 *   1  *2 = 48x
    add  HL, BC         ; 1:11      49 *      +1 = 49x    
                        ;[10:96]    51 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0011_0011)
    ld    B, H          ; 1:4       51 *
    ld    C, L          ; 1:4       51 *   1       1x = base 
    add  HL, HL         ; 1:11      51 *   1  *2 = 2x
    add  HL, BC         ; 1:11      51 *      +1 = 3x 
    add  HL, HL         ; 1:11      51 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      51 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      51 *   1  *2 = 24x
    add  HL, BC         ; 1:11      51 *      +1 = 25x 
    add  HL, HL         ; 1:11      51 *   1  *2 = 50x
    add  HL, BC         ; 1:11      51 *      +1 = 51x    
                        ;[10:96]    53 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0011_0101)
    ld    B, H          ; 1:4       53 *
    ld    C, L          ; 1:4       53 *   1       1x = base 
    add  HL, HL         ; 1:11      53 *   1  *2 = 2x
    add  HL, BC         ; 1:11      53 *      +1 = 3x 
    add  HL, HL         ; 1:11      53 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      53 *   1  *2 = 12x
    add  HL, BC         ; 1:11      53 *      +1 = 13x 
    add  HL, HL         ; 1:11      53 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      53 *   1  *2 = 52x
    add  HL, BC         ; 1:11      53 *      +1 = 53x    
                        ;[11:107]   55 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0011_0111)
    ld    B, H          ; 1:4       55 *
    ld    C, L          ; 1:4       55 *   1       1x = base 
    add  HL, HL         ; 1:11      55 *   1  *2 = 2x
    add  HL, BC         ; 1:11      55 *      +1 = 3x 
    add  HL, HL         ; 1:11      55 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      55 *   1  *2 = 12x
    add  HL, BC         ; 1:11      55 *      +1 = 13x 
    add  HL, HL         ; 1:11      55 *   1  *2 = 26x
    add  HL, BC         ; 1:11      55 *      +1 = 27x 
    add  HL, HL         ; 1:11      55 *   1  *2 = 54x
    add  HL, BC         ; 1:11      55 *      +1 = 55x  

                        ;[10:96]    57 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0011_1001)
    ld    B, H          ; 1:4       57 *
    ld    C, L          ; 1:4       57 *   1       1x = base 
    add  HL, HL         ; 1:11      57 *   1  *2 = 2x
    add  HL, BC         ; 1:11      57 *      +1 = 3x 
    add  HL, HL         ; 1:11      57 *   1  *2 = 6x
    add  HL, BC         ; 1:11      57 *      +1 = 7x 
    add  HL, HL         ; 1:11      57 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      57 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      57 *   1  *2 = 56x
    add  HL, BC         ; 1:11      57 *      +1 = 57x    
                        ;[11:107]   59 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0011_1011)
    ld    B, H          ; 1:4       59 *
    ld    C, L          ; 1:4       59 *   1       1x = base 
    add  HL, HL         ; 1:11      59 *   1  *2 = 2x
    add  HL, BC         ; 1:11      59 *      +1 = 3x 
    add  HL, HL         ; 1:11      59 *   1  *2 = 6x
    add  HL, BC         ; 1:11      59 *      +1 = 7x 
    add  HL, HL         ; 1:11      59 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      59 *   1  *2 = 28x
    add  HL, BC         ; 1:11      59 *      +1 = 29x 
    add  HL, HL         ; 1:11      59 *   1  *2 = 58x
    add  HL, BC         ; 1:11      59 *      +1 = 59x    
                        ;[11:107]   61 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0011_1101)
    ld    B, H          ; 1:4       61 *
    ld    C, L          ; 1:4       61 *   1       1x = base 
    add  HL, HL         ; 1:11      61 *   1  *2 = 2x
    add  HL, BC         ; 1:11      61 *      +1 = 3x 
    add  HL, HL         ; 1:11      61 *   1  *2 = 6x
    add  HL, BC         ; 1:11      61 *      +1 = 7x 
    add  HL, HL         ; 1:11      61 *   1  *2 = 14x
    add  HL, BC         ; 1:11      61 *      +1 = 15x 
    add  HL, HL         ; 1:11      61 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      61 *   1  *2 = 60x
    add  HL, BC         ; 1:11      61 *      +1 = 61x    
                        ;[11:93]    63 *   Variant mk1: HL * (2^a - 2^b) = HL * (b_0011_1111)   
    ld    B, H          ; 1:4       63 *
    ld    C, L          ; 1:4       63 *   [1x] 
    add  HL, HL         ; 1:11      63 *   2x 
    add  HL, HL         ; 1:11      63 *   4x 
    add  HL, HL         ; 1:11      63 *   8x 
    add  HL, HL         ; 1:11      63 *   16x 
    add  HL, HL         ; 1:11      63 *   32x 
    add  HL, HL         ; 1:11      63 *   64x 
    or    A             ; 1:4       63 *
    sbc  HL, BC         ; 2:15      63 *   [63x] = 64x - 1x    
                        ;[9:85]     65 *   Variant mk1: HL * (2^a + 2^b) = HL * (b_0100_0001)   
    ld    B, H          ; 1:4       65 *
    ld    C, L          ; 1:4       65 *   [1x] 
    add  HL, HL         ; 1:11      65 *   2x 
    add  HL, HL         ; 1:11      65 *   4x 
    add  HL, HL         ; 1:11      65 *   8x 
    add  HL, HL         ; 1:11      65 *   16x 
    add  HL, HL         ; 1:11      65 *   32x 
    add  HL, HL         ; 1:11      65 *   64x 
    add  HL, BC         ; 1:11      65 *   [65x] = 64x + 1x    
                        ;[10:96]    67 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0100_0011)
    ld    B, H          ; 1:4       67 *
    ld    C, L          ; 1:4       67 *   1       1x = base 
    add  HL, HL         ; 1:11      67 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      67 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      67 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      67 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      67 *   1  *2 = 32x
    add  HL, BC         ; 1:11      67 *      +1 = 33x 
    add  HL, HL         ; 1:11      67 *   1  *2 = 66x
    add  HL, BC         ; 1:11      67 *      +1 = 67x    
                        ;[10:96]    69 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0100_0101)
    ld    B, H          ; 1:4       69 *
    ld    C, L          ; 1:4       69 *   1       1x = base 
    add  HL, HL         ; 1:11      69 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      69 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      69 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      69 *   1  *2 = 16x
    add  HL, BC         ; 1:11      69 *      +1 = 17x 
    add  HL, HL         ; 1:11      69 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      69 *   1  *2 = 68x
    add  HL, BC         ; 1:11      69 *      +1 = 69x    
                        ;[11:107]   71 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0100_0111)
    ld    B, H          ; 1:4       71 *
    ld    C, L          ; 1:4       71 *   1       1x = base 
    add  HL, HL         ; 1:11      71 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      71 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      71 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      71 *   1  *2 = 16x
    add  HL, BC         ; 1:11      71 *      +1 = 17x 
    add  HL, HL         ; 1:11      71 *   1  *2 = 34x
    add  HL, BC         ; 1:11      71 *      +1 = 35x 
    add  HL, HL         ; 1:11      71 *   1  *2 = 70x
    add  HL, BC         ; 1:11      71 *      +1 = 71x    
                        ;[10:96]    73 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0100_1001)
    ld    B, H          ; 1:4       73 *
    ld    C, L          ; 1:4       73 *   1       1x = base 
    add  HL, HL         ; 1:11      73 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      73 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      73 *   1  *2 = 8x
    add  HL, BC         ; 1:11      73 *      +1 = 9x 
    add  HL, HL         ; 1:11      73 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      73 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      73 *   1  *2 = 72x
    add  HL, BC         ; 1:11      73 *      +1 = 73x    
                        ;[11:107]   75 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0100_1011)
    ld    B, H          ; 1:4       75 *
    ld    C, L          ; 1:4       75 *   1       1x = base 
    add  HL, HL         ; 1:11      75 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      75 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      75 *   1  *2 = 8x
    add  HL, BC         ; 1:11      75 *      +1 = 9x 
    add  HL, HL         ; 1:11      75 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      75 *   1  *2 = 36x
    add  HL, BC         ; 1:11      75 *      +1 = 37x 
    add  HL, HL         ; 1:11      75 *   1  *2 = 74x
    add  HL, BC         ; 1:11      75 *      +1 = 75x    
                        ;[11:107]   77 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0100_1101)
    ld    B, H          ; 1:4       77 *
    ld    C, L          ; 1:4       77 *   1       1x = base 
    add  HL, HL         ; 1:11      77 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      77 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      77 *   1  *2 = 8x
    add  HL, BC         ; 1:11      77 *      +1 = 9x 
    add  HL, HL         ; 1:11      77 *   1  *2 = 18x
    add  HL, BC         ; 1:11      77 *      +1 = 19x 
    add  HL, HL         ; 1:11      77 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      77 *   1  *2 = 76x
    add  HL, BC         ; 1:11      77 *      +1 = 77x  

                        ;[12:118]   79 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0100_1111)
    ld    B, H          ; 1:4       79 *
    ld    C, L          ; 1:4       79 *   1       1x = base 
    add  HL, HL         ; 1:11      79 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      79 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      79 *   1  *2 = 8x
    add  HL, BC         ; 1:11      79 *      +1 = 9x 
    add  HL, HL         ; 1:11      79 *   1  *2 = 18x
    add  HL, BC         ; 1:11      79 *      +1 = 19x 
    add  HL, HL         ; 1:11      79 *   1  *2 = 38x
    add  HL, BC         ; 1:11      79 *      +1 = 39x 
    add  HL, HL         ; 1:11      79 *   1  *2 = 78x
    add  HL, BC         ; 1:11      79 *      +1 = 79x    
                        ;[10:96]    81 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_0001)
    ld    B, H          ; 1:4       81 *
    ld    C, L          ; 1:4       81 *   1       1x = base 
    add  HL, HL         ; 1:11      81 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      81 *   1  *2 = 4x
    add  HL, BC         ; 1:11      81 *      +1 = 5x 
    add  HL, HL         ; 1:11      81 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      81 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      81 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      81 *   1  *2 = 80x
    add  HL, BC         ; 1:11      81 *      +1 = 81x    
                        ;[11:107]   83 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_0011)
    ld    B, H          ; 1:4       83 *
    ld    C, L          ; 1:4       83 *   1       1x = base 
    add  HL, HL         ; 1:11      83 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      83 *   1  *2 = 4x
    add  HL, BC         ; 1:11      83 *      +1 = 5x 
    add  HL, HL         ; 1:11      83 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      83 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      83 *   1  *2 = 40x
    add  HL, BC         ; 1:11      83 *      +1 = 41x 
    add  HL, HL         ; 1:11      83 *   1  *2 = 82x
    add  HL, BC         ; 1:11      83 *      +1 = 83x    
                        ;[11:107]   85 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_0101)
    ld    B, H          ; 1:4       85 *
    ld    C, L          ; 1:4       85 *   1       1x = base 
    add  HL, HL         ; 1:11      85 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      85 *   1  *2 = 4x
    add  HL, BC         ; 1:11      85 *      +1 = 5x 
    add  HL, HL         ; 1:11      85 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      85 *   1  *2 = 20x
    add  HL, BC         ; 1:11      85 *      +1 = 21x 
    add  HL, HL         ; 1:11      85 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      85 *   1  *2 = 84x
    add  HL, BC         ; 1:11      85 *      +1 = 85x    
                        ;[12:118]   87 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_0111)
    ld    B, H          ; 1:4       87 *
    ld    C, L          ; 1:4       87 *   1       1x = base 
    add  HL, HL         ; 1:11      87 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      87 *   1  *2 = 4x
    add  HL, BC         ; 1:11      87 *      +1 = 5x 
    add  HL, HL         ; 1:11      87 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      87 *   1  *2 = 20x
    add  HL, BC         ; 1:11      87 *      +1 = 21x 
    add  HL, HL         ; 1:11      87 *   1  *2 = 42x
    add  HL, BC         ; 1:11      87 *      +1 = 43x 
    add  HL, HL         ; 1:11      87 *   1  *2 = 86x
    add  HL, BC         ; 1:11      87 *      +1 = 87x    
                        ;[11:107]   89 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1001)
    ld    B, H          ; 1:4       89 *
    ld    C, L          ; 1:4       89 *   1       1x = base 
    add  HL, HL         ; 1:11      89 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      89 *   1  *2 = 4x
    add  HL, BC         ; 1:11      89 *      +1 = 5x 
    add  HL, HL         ; 1:11      89 *   1  *2 = 10x
    add  HL, BC         ; 1:11      89 *      +1 = 11x 
    add  HL, HL         ; 1:11      89 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      89 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      89 *   1  *2 = 88x
    add  HL, BC         ; 1:11      89 *      +1 = 89x    
                        ;[12:118]   91 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1011)
    ld    B, H          ; 1:4       91 *
    ld    C, L          ; 1:4       91 *   1       1x = base 
    add  HL, HL         ; 1:11      91 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      91 *   1  *2 = 4x
    add  HL, BC         ; 1:11      91 *      +1 = 5x 
    add  HL, HL         ; 1:11      91 *   1  *2 = 10x
    add  HL, BC         ; 1:11      91 *      +1 = 11x 
    add  HL, HL         ; 1:11      91 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      91 *   1  *2 = 44x
    add  HL, BC         ; 1:11      91 *      +1 = 45x 
    add  HL, HL         ; 1:11      91 *   1  *2 = 90x
    add  HL, BC         ; 1:11      91 *      +1 = 91x    
                        ;[12:118]   93 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1101)
    ld    B, H          ; 1:4       93 *
    ld    C, L          ; 1:4       93 *   1       1x = base 
    add  HL, HL         ; 1:11      93 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      93 *   1  *2 = 4x
    add  HL, BC         ; 1:11      93 *      +1 = 5x 
    add  HL, HL         ; 1:11      93 *   1  *2 = 10x
    add  HL, BC         ; 1:11      93 *      +1 = 11x 
    add  HL, HL         ; 1:11      93 *   1  *2 = 22x
    add  HL, BC         ; 1:11      93 *      +1 = 23x 
    add  HL, HL         ; 1:11      93 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      93 *   1  *2 = 92x
    add  HL, BC         ; 1:11      93 *      +1 = 93x    
                        ;[13:129]   95 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1111)
    ld    B, H          ; 1:4       95 *
    ld    C, L          ; 1:4       95 *   1       1x = base 
    add  HL, HL         ; 1:11      95 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      95 *   1  *2 = 4x
    add  HL, BC         ; 1:11      95 *      +1 = 5x 
    add  HL, HL         ; 1:11      95 *   1  *2 = 10x
    add  HL, BC         ; 1:11      95 *      +1 = 11x 
    add  HL, HL         ; 1:11      95 *   1  *2 = 22x
    add  HL, BC         ; 1:11      95 *      +1 = 23x 
    add  HL, HL         ; 1:11      95 *   1  *2 = 46x
    add  HL, BC         ; 1:11      95 *      +1 = 47x 
    add  HL, HL         ; 1:11      95 *   1  *2 = 94x
    add  HL, BC         ; 1:11      95 *      +1 = 95x    
                        ;[10:96]    97 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0110_0001)
    ld    B, H          ; 1:4       97 *
    ld    C, L          ; 1:4       97 *   1       1x = base 
    add  HL, HL         ; 1:11      97 *   1  *2 = 2x
    add  HL, BC         ; 1:11      97 *      +1 = 3x 
    add  HL, HL         ; 1:11      97 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      97 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      97 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      97 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      97 *   1  *2 = 96x
    add  HL, BC         ; 1:11      97 *      +1 = 97x    
                        ;[11:107]   99 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0110_0011)
    ld    B, H          ; 1:4       99 *
    ld    C, L          ; 1:4       99 *   1       1x = base 
    add  HL, HL         ; 1:11      99 *   1  *2 = 2x
    add  HL, BC         ; 1:11      99 *      +1 = 3x 
    add  HL, HL         ; 1:11      99 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      99 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      99 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      99 *   1  *2 = 48x
    add  HL, BC         ; 1:11      99 *      +1 = 49x 
    add  HL, HL         ; 1:11      99 *   1  *2 = 98x
    add  HL, BC         ; 1:11      99 *      +1 = 99x  

                        ;[11:107]   101 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0110_0101)
    ld    B, H          ; 1:4       101 *
    ld    C, L          ; 1:4       101 *   1       1x = base 
    add  HL, HL         ; 1:11      101 *   1  *2 = 2x
    add  HL, BC         ; 1:11      101 *      +1 = 3x 
    add  HL, HL         ; 1:11      101 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      101 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      101 *   1  *2 = 24x
    add  HL, BC         ; 1:11      101 *      +1 = 25x 
    add  HL, HL         ; 1:11      101 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      101 *   1  *2 = 100x
    add  HL, BC         ; 1:11      101 *      +1 = 101x   
                        ;[12:118]   103 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0110_0111)
    ld    B, H          ; 1:4       103 *
    ld    C, L          ; 1:4       103 *   1       1x = base 
    add  HL, HL         ; 1:11      103 *   1  *2 = 2x
    add  HL, BC         ; 1:11      103 *      +1 = 3x 
    add  HL, HL         ; 1:11      103 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      103 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      103 *   1  *2 = 24x
    add  HL, BC         ; 1:11      103 *      +1 = 25x 
    add  HL, HL         ; 1:11      103 *   1  *2 = 50x
    add  HL, BC         ; 1:11      103 *      +1 = 51x 
    add  HL, HL         ; 1:11      103 *   1  *2 = 102x
    add  HL, BC         ; 1:11      103 *      +1 = 103x   
                        ;[11:107]   105 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0110_1001)
    ld    B, H          ; 1:4       105 *
    ld    C, L          ; 1:4       105 *   1       1x = base 
    add  HL, HL         ; 1:11      105 *   1  *2 = 2x
    add  HL, BC         ; 1:11      105 *      +1 = 3x 
    add  HL, HL         ; 1:11      105 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      105 *   1  *2 = 12x
    add  HL, BC         ; 1:11      105 *      +1 = 13x 
    add  HL, HL         ; 1:11      105 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      105 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      105 *   1  *2 = 104x
    add  HL, BC         ; 1:11      105 *      +1 = 105x   
                        ;[12:118]   107 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0110_1011)
    ld    B, H          ; 1:4       107 *
    ld    C, L          ; 1:4       107 *   1       1x = base 
    add  HL, HL         ; 1:11      107 *   1  *2 = 2x
    add  HL, BC         ; 1:11      107 *      +1 = 3x 
    add  HL, HL         ; 1:11      107 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      107 *   1  *2 = 12x
    add  HL, BC         ; 1:11      107 *      +1 = 13x 
    add  HL, HL         ; 1:11      107 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      107 *   1  *2 = 52x
    add  HL, BC         ; 1:11      107 *      +1 = 53x 
    add  HL, HL         ; 1:11      107 *   1  *2 = 106x
    add  HL, BC         ; 1:11      107 *      +1 = 107x   
                        ;[12:118]   109 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0110_1101)
    ld    B, H          ; 1:4       109 *
    ld    C, L          ; 1:4       109 *   1       1x = base 
    add  HL, HL         ; 1:11      109 *   1  *2 = 2x
    add  HL, BC         ; 1:11      109 *      +1 = 3x 
    add  HL, HL         ; 1:11      109 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      109 *   1  *2 = 12x
    add  HL, BC         ; 1:11      109 *      +1 = 13x 
    add  HL, HL         ; 1:11      109 *   1  *2 = 26x
    add  HL, BC         ; 1:11      109 *      +1 = 27x 
    add  HL, HL         ; 1:11      109 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      109 *   1  *2 = 108x
    add  HL, BC         ; 1:11      109 *      +1 = 109x   
                        ;[13:129]   111 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0110_1111)
    ld    B, H          ; 1:4       111 *
    ld    C, L          ; 1:4       111 *   1       1x = base 
    add  HL, HL         ; 1:11      111 *   1  *2 = 2x
    add  HL, BC         ; 1:11      111 *      +1 = 3x 
    add  HL, HL         ; 1:11      111 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      111 *   1  *2 = 12x
    add  HL, BC         ; 1:11      111 *      +1 = 13x 
    add  HL, HL         ; 1:11      111 *   1  *2 = 26x
    add  HL, BC         ; 1:11      111 *      +1 = 27x 
    add  HL, HL         ; 1:11      111 *   1  *2 = 54x
    add  HL, BC         ; 1:11      111 *      +1 = 55x 
    add  HL, HL         ; 1:11      111 *   1  *2 = 110x
    add  HL, BC         ; 1:11      111 *      +1 = 111x   
                        ;[11:107]   113 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0111_0001)
    ld    B, H          ; 1:4       113 *
    ld    C, L          ; 1:4       113 *   1       1x = base 
    add  HL, HL         ; 1:11      113 *   1  *2 = 2x
    add  HL, BC         ; 1:11      113 *      +1 = 3x 
    add  HL, HL         ; 1:11      113 *   1  *2 = 6x
    add  HL, BC         ; 1:11      113 *      +1 = 7x 
    add  HL, HL         ; 1:11      113 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      113 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      113 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      113 *   1  *2 = 112x
    add  HL, BC         ; 1:11      113 *      +1 = 113x   
                        ;[12:118]   115 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0111_0011)
    ld    B, H          ; 1:4       115 *
    ld    C, L          ; 1:4       115 *   1       1x = base 
    add  HL, HL         ; 1:11      115 *   1  *2 = 2x
    add  HL, BC         ; 1:11      115 *      +1 = 3x 
    add  HL, HL         ; 1:11      115 *   1  *2 = 6x
    add  HL, BC         ; 1:11      115 *      +1 = 7x 
    add  HL, HL         ; 1:11      115 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      115 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      115 *   1  *2 = 56x
    add  HL, BC         ; 1:11      115 *      +1 = 57x 
    add  HL, HL         ; 1:11      115 *   1  *2 = 114x
    add  HL, BC         ; 1:11      115 *      +1 = 115x   
                        ;[12:118]   117 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0111_0101)
    ld    B, H          ; 1:4       117 *
    ld    C, L          ; 1:4       117 *   1       1x = base 
    add  HL, HL         ; 1:11      117 *   1  *2 = 2x
    add  HL, BC         ; 1:11      117 *      +1 = 3x 
    add  HL, HL         ; 1:11      117 *   1  *2 = 6x
    add  HL, BC         ; 1:11      117 *      +1 = 7x 
    add  HL, HL         ; 1:11      117 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      117 *   1  *2 = 28x
    add  HL, BC         ; 1:11      117 *      +1 = 29x 
    add  HL, HL         ; 1:11      117 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      117 *   1  *2 = 116x
    add  HL, BC         ; 1:11      117 *      +1 = 117x   
                        ;[13:129]   119 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0111_0111)
    ld    B, H          ; 1:4       119 *
    ld    C, L          ; 1:4       119 *   1       1x = base 
    add  HL, HL         ; 1:11      119 *   1  *2 = 2x
    add  HL, BC         ; 1:11      119 *      +1 = 3x 
    add  HL, HL         ; 1:11      119 *   1  *2 = 6x
    add  HL, BC         ; 1:11      119 *      +1 = 7x 
    add  HL, HL         ; 1:11      119 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      119 *   1  *2 = 28x
    add  HL, BC         ; 1:11      119 *      +1 = 29x 
    add  HL, HL         ; 1:11      119 *   1  *2 = 58x
    add  HL, BC         ; 1:11      119 *      +1 = 59x 
    add  HL, HL         ; 1:11      119 *   1  *2 = 118x
    add  HL, BC         ; 1:11      119 *      +1 = 119x   
                        ;[12:118]   121 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0111_1001)
    ld    B, H          ; 1:4       121 *
    ld    C, L          ; 1:4       121 *   1       1x = base 
    add  HL, HL         ; 1:11      121 *   1  *2 = 2x
    add  HL, BC         ; 1:11      121 *      +1 = 3x 
    add  HL, HL         ; 1:11      121 *   1  *2 = 6x
    add  HL, BC         ; 1:11      121 *      +1 = 7x 
    add  HL, HL         ; 1:11      121 *   1  *2 = 14x
    add  HL, BC         ; 1:11      121 *      +1 = 15x 
    add  HL, HL         ; 1:11      121 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      121 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      121 *   1  *2 = 120x
    add  HL, BC         ; 1:11      121 *      +1 = 121x  

                        ;[13:129]   123 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0111_1011)
    ld    B, H          ; 1:4       123 *
    ld    C, L          ; 1:4       123 *   1       1x = base 
    add  HL, HL         ; 1:11      123 *   1  *2 = 2x
    add  HL, BC         ; 1:11      123 *      +1 = 3x 
    add  HL, HL         ; 1:11      123 *   1  *2 = 6x
    add  HL, BC         ; 1:11      123 *      +1 = 7x 
    add  HL, HL         ; 1:11      123 *   1  *2 = 14x
    add  HL, BC         ; 1:11      123 *      +1 = 15x 
    add  HL, HL         ; 1:11      123 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      123 *   1  *2 = 60x
    add  HL, BC         ; 1:11      123 *      +1 = 61x 
    add  HL, HL         ; 1:11      123 *   1  *2 = 122x
    add  HL, BC         ; 1:11      123 *      +1 = 123x   
                        ;[13:129]   125 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0111_1101)
    ld    B, H          ; 1:4       125 *
    ld    C, L          ; 1:4       125 *   1       1x = base 
    add  HL, HL         ; 1:11      125 *   1  *2 = 2x
    add  HL, BC         ; 1:11      125 *      +1 = 3x 
    add  HL, HL         ; 1:11      125 *   1  *2 = 6x
    add  HL, BC         ; 1:11      125 *      +1 = 7x 
    add  HL, HL         ; 1:11      125 *   1  *2 = 14x
    add  HL, BC         ; 1:11      125 *      +1 = 15x 
    add  HL, HL         ; 1:11      125 *   1  *2 = 30x
    add  HL, BC         ; 1:11      125 *      +1 = 31x 
    add  HL, HL         ; 1:11      125 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      125 *   1  *2 = 124x
    add  HL, BC         ; 1:11      125 *      +1 = 125x   
                        ;[12:104]   127 *   Variant mk1: HL * (2^a - 2^b) = HL * (b_0111_1111)   
    ld    B, H          ; 1:4       127 *
    ld    C, L          ; 1:4       127 *   [1x] 
    add  HL, HL         ; 1:11      127 *   2x 
    add  HL, HL         ; 1:11      127 *   4x 
    add  HL, HL         ; 1:11      127 *   8x 
    add  HL, HL         ; 1:11      127 *   16x 
    add  HL, HL         ; 1:11      127 *   32x 
    add  HL, HL         ; 1:11      127 *   64x 
    add  HL, HL         ; 1:11      127 *   128x 
    or    A             ; 1:4       127 *
    sbc  HL, BC         ; 2:15      127 *   [127x] = 128x - 1x   
                        ;[10:96]    129 *   Variant mk1: HL * (2^a + 2^b) = HL * (b_1000_0001)   
    ld    B, H          ; 1:4       129 *
    ld    C, L          ; 1:4       129 *   [1x] 
    add  HL, HL         ; 1:11      129 *   2x 
    add  HL, HL         ; 1:11      129 *   4x 
    add  HL, HL         ; 1:11      129 *   8x 
    add  HL, HL         ; 1:11      129 *   16x 
    add  HL, HL         ; 1:11      129 *   32x 
    add  HL, HL         ; 1:11      129 *   64x 
    add  HL, HL         ; 1:11      129 *   128x 
    add  HL, BC         ; 1:11      129 *   [129x] = 128x + 1x   
                        ;[11:107]   131 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1000_0011)
    ld    B, H          ; 1:4       131 *
    ld    C, L          ; 1:4       131 *   1       1x = base 
    add  HL, HL         ; 1:11      131 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      131 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      131 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      131 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      131 *   0  *2 = 32x 
    add  HL, HL         ; 1:11      131 *   1  *2 = 64x
    add  HL, BC         ; 1:11      131 *      +1 = 65x 
    add  HL, HL         ; 1:11      131 *   1  *2 = 130x
    add  HL, BC         ; 1:11      131 *      +1 = 131x   
                        ;[11:107]   133 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1000_0101)
    ld    B, H          ; 1:4       133 *
    ld    C, L          ; 1:4       133 *   1       1x = base 
    add  HL, HL         ; 1:11      133 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      133 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      133 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      133 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      133 *   1  *2 = 32x
    add  HL, BC         ; 1:11      133 *      +1 = 33x 
    add  HL, HL         ; 1:11      133 *   0  *2 = 66x 
    add  HL, HL         ; 1:11      133 *   1  *2 = 132x
    add  HL, BC         ; 1:11      133 *      +1 = 133x   
                        ;[12:118]   135 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1000_0111)
    ld    B, H          ; 1:4       135 *
    ld    C, L          ; 1:4       135 *   1       1x = base 
    add  HL, HL         ; 1:11      135 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      135 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      135 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      135 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      135 *   1  *2 = 32x
    add  HL, BC         ; 1:11      135 *      +1 = 33x 
    add  HL, HL         ; 1:11      135 *   1  *2 = 66x
    add  HL, BC         ; 1:11      135 *      +1 = 67x 
    add  HL, HL         ; 1:11      135 *   1  *2 = 134x
    add  HL, BC         ; 1:11      135 *      +1 = 135x   
                        ;[11:107]   137 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1000_1001)
    ld    B, H          ; 1:4       137 *
    ld    C, L          ; 1:4       137 *   1       1x = base 
    add  HL, HL         ; 1:11      137 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      137 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      137 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      137 *   1  *2 = 16x
    add  HL, BC         ; 1:11      137 *      +1 = 17x 
    add  HL, HL         ; 1:11      137 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      137 *   0  *2 = 68x 
    add  HL, HL         ; 1:11      137 *   1  *2 = 136x
    add  HL, BC         ; 1:11      137 *      +1 = 137x   
                        ;[12:118]   139 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1000_1011)
    ld    B, H          ; 1:4       139 *
    ld    C, L          ; 1:4       139 *   1       1x = base 
    add  HL, HL         ; 1:11      139 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      139 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      139 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      139 *   1  *2 = 16x
    add  HL, BC         ; 1:11      139 *      +1 = 17x 
    add  HL, HL         ; 1:11      139 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      139 *   1  *2 = 68x
    add  HL, BC         ; 1:11      139 *      +1 = 69x 
    add  HL, HL         ; 1:11      139 *   1  *2 = 138x
    add  HL, BC         ; 1:11      139 *      +1 = 139x   
                        ;[12:118]   141 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1000_1101)
    ld    B, H          ; 1:4       141 *
    ld    C, L          ; 1:4       141 *   1       1x = base 
    add  HL, HL         ; 1:11      141 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      141 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      141 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      141 *   1  *2 = 16x
    add  HL, BC         ; 1:11      141 *      +1 = 17x 
    add  HL, HL         ; 1:11      141 *   1  *2 = 34x
    add  HL, BC         ; 1:11      141 *      +1 = 35x 
    add  HL, HL         ; 1:11      141 *   0  *2 = 70x 
    add  HL, HL         ; 1:11      141 *   1  *2 = 140x
    add  HL, BC         ; 1:11      141 *      +1 = 141x   
                        ;[13:129]   143 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1000_1111)
    ld    B, H          ; 1:4       143 *
    ld    C, L          ; 1:4       143 *   1       1x = base 
    add  HL, HL         ; 1:11      143 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      143 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      143 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      143 *   1  *2 = 16x
    add  HL, BC         ; 1:11      143 *      +1 = 17x 
    add  HL, HL         ; 1:11      143 *   1  *2 = 34x
    add  HL, BC         ; 1:11      143 *      +1 = 35x 
    add  HL, HL         ; 1:11      143 *   1  *2 = 70x
    add  HL, BC         ; 1:11      143 *      +1 = 71x 
    add  HL, HL         ; 1:11      143 *   1  *2 = 142x
    add  HL, BC         ; 1:11      143 *      +1 = 143x  

                        ;[11:107]   145 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1001_0001)
    ld    B, H          ; 1:4       145 *
    ld    C, L          ; 1:4       145 *   1       1x = base 
    add  HL, HL         ; 1:11      145 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      145 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      145 *   1  *2 = 8x
    add  HL, BC         ; 1:11      145 *      +1 = 9x 
    add  HL, HL         ; 1:11      145 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      145 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      145 *   0  *2 = 72x 
    add  HL, HL         ; 1:11      145 *   1  *2 = 144x
    add  HL, BC         ; 1:11      145 *      +1 = 145x   
                        ;[12:118]   147 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1001_0011)
    ld    B, H          ; 1:4       147 *
    ld    C, L          ; 1:4       147 *   1       1x = base 
    add  HL, HL         ; 1:11      147 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      147 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      147 *   1  *2 = 8x
    add  HL, BC         ; 1:11      147 *      +1 = 9x 
    add  HL, HL         ; 1:11      147 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      147 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      147 *   1  *2 = 72x
    add  HL, BC         ; 1:11      147 *      +1 = 73x 
    add  HL, HL         ; 1:11      147 *   1  *2 = 146x
    add  HL, BC         ; 1:11      147 *      +1 = 147x   
                        ;[12:118]   149 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1001_0101)
    ld    B, H          ; 1:4       149 *
    ld    C, L          ; 1:4       149 *   1       1x = base 
    add  HL, HL         ; 1:11      149 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      149 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      149 *   1  *2 = 8x
    add  HL, BC         ; 1:11      149 *      +1 = 9x 
    add  HL, HL         ; 1:11      149 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      149 *   1  *2 = 36x
    add  HL, BC         ; 1:11      149 *      +1 = 37x 
    add  HL, HL         ; 1:11      149 *   0  *2 = 74x 
    add  HL, HL         ; 1:11      149 *   1  *2 = 148x
    add  HL, BC         ; 1:11      149 *      +1 = 149x   
                        ;[13:129]   151 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1001_0111)
    ld    B, H          ; 1:4       151 *
    ld    C, L          ; 1:4       151 *   1       1x = base 
    add  HL, HL         ; 1:11      151 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      151 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      151 *   1  *2 = 8x
    add  HL, BC         ; 1:11      151 *      +1 = 9x 
    add  HL, HL         ; 1:11      151 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      151 *   1  *2 = 36x
    add  HL, BC         ; 1:11      151 *      +1 = 37x 
    add  HL, HL         ; 1:11      151 *   1  *2 = 74x
    add  HL, BC         ; 1:11      151 *      +1 = 75x 
    add  HL, HL         ; 1:11      151 *   1  *2 = 150x
    add  HL, BC         ; 1:11      151 *      +1 = 151x   
                        ;[12:118]   153 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1001_1001)
    ld    B, H          ; 1:4       153 *
    ld    C, L          ; 1:4       153 *   1       1x = base 
    add  HL, HL         ; 1:11      153 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      153 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      153 *   1  *2 = 8x
    add  HL, BC         ; 1:11      153 *      +1 = 9x 
    add  HL, HL         ; 1:11      153 *   1  *2 = 18x
    add  HL, BC         ; 1:11      153 *      +1 = 19x 
    add  HL, HL         ; 1:11      153 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      153 *   0  *2 = 76x 
    add  HL, HL         ; 1:11      153 *   1  *2 = 152x
    add  HL, BC         ; 1:11      153 *      +1 = 153x   
                        ;[13:129]   155 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1001_1011)
    ld    B, H          ; 1:4       155 *
    ld    C, L          ; 1:4       155 *   1       1x = base 
    add  HL, HL         ; 1:11      155 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      155 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      155 *   1  *2 = 8x
    add  HL, BC         ; 1:11      155 *      +1 = 9x 
    add  HL, HL         ; 1:11      155 *   1  *2 = 18x
    add  HL, BC         ; 1:11      155 *      +1 = 19x 
    add  HL, HL         ; 1:11      155 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      155 *   1  *2 = 76x
    add  HL, BC         ; 1:11      155 *      +1 = 77x 
    add  HL, HL         ; 1:11      155 *   1  *2 = 154x
    add  HL, BC         ; 1:11      155 *      +1 = 155x   
                        ;[13:129]   157 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1001_1101)
    ld    B, H          ; 1:4       157 *
    ld    C, L          ; 1:4       157 *   1       1x = base 
    add  HL, HL         ; 1:11      157 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      157 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      157 *   1  *2 = 8x
    add  HL, BC         ; 1:11      157 *      +1 = 9x 
    add  HL, HL         ; 1:11      157 *   1  *2 = 18x
    add  HL, BC         ; 1:11      157 *      +1 = 19x 
    add  HL, HL         ; 1:11      157 *   1  *2 = 38x
    add  HL, BC         ; 1:11      157 *      +1 = 39x 
    add  HL, HL         ; 1:11      157 *   0  *2 = 78x 
    add  HL, HL         ; 1:11      157 *   1  *2 = 156x
    add  HL, BC         ; 1:11      157 *      +1 = 157x   
                        ;[14:140]   159 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1001_1111)
    ld    B, H          ; 1:4       159 *
    ld    C, L          ; 1:4       159 *   1       1x = base 
    add  HL, HL         ; 1:11      159 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      159 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      159 *   1  *2 = 8x
    add  HL, BC         ; 1:11      159 *      +1 = 9x 
    add  HL, HL         ; 1:11      159 *   1  *2 = 18x
    add  HL, BC         ; 1:11      159 *      +1 = 19x 
    add  HL, HL         ; 1:11      159 *   1  *2 = 38x
    add  HL, BC         ; 1:11      159 *      +1 = 39x 
    add  HL, HL         ; 1:11      159 *   1  *2 = 78x
    add  HL, BC         ; 1:11      159 *      +1 = 79x 
    add  HL, HL         ; 1:11      159 *   1  *2 = 158x
    add  HL, BC         ; 1:11      159 *      +1 = 159x   
                        ;[11:107]   161 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1010_0001)
    ld    B, H          ; 1:4       161 *
    ld    C, L          ; 1:4       161 *   1       1x = base 
    add  HL, HL         ; 1:11      161 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      161 *   1  *2 = 4x
    add  HL, BC         ; 1:11      161 *      +1 = 5x 
    add  HL, HL         ; 1:11      161 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      161 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      161 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      161 *   0  *2 = 80x 
    add  HL, HL         ; 1:11      161 *   1  *2 = 160x
    add  HL, BC         ; 1:11      161 *      +1 = 161x   
                        ;[12:118]   163 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1010_0011)
    ld    B, H          ; 1:4       163 *
    ld    C, L          ; 1:4       163 *   1       1x = base 
    add  HL, HL         ; 1:11      163 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      163 *   1  *2 = 4x
    add  HL, BC         ; 1:11      163 *      +1 = 5x 
    add  HL, HL         ; 1:11      163 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      163 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      163 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      163 *   1  *2 = 80x
    add  HL, BC         ; 1:11      163 *      +1 = 81x 
    add  HL, HL         ; 1:11      163 *   1  *2 = 162x
    add  HL, BC         ; 1:11      163 *      +1 = 163x   
                        ;[12:118]   165 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1010_0101)
    ld    B, H          ; 1:4       165 *
    ld    C, L          ; 1:4       165 *   1       1x = base 
    add  HL, HL         ; 1:11      165 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      165 *   1  *2 = 4x
    add  HL, BC         ; 1:11      165 *      +1 = 5x 
    add  HL, HL         ; 1:11      165 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      165 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      165 *   1  *2 = 40x
    add  HL, BC         ; 1:11      165 *      +1 = 41x 
    add  HL, HL         ; 1:11      165 *   0  *2 = 82x 
    add  HL, HL         ; 1:11      165 *   1  *2 = 164x
    add  HL, BC         ; 1:11      165 *      +1 = 165x  

                        ;[13:129]   167 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1010_0111)
    ld    B, H          ; 1:4       167 *
    ld    C, L          ; 1:4       167 *   1       1x = base 
    add  HL, HL         ; 1:11      167 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      167 *   1  *2 = 4x
    add  HL, BC         ; 1:11      167 *      +1 = 5x 
    add  HL, HL         ; 1:11      167 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      167 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      167 *   1  *2 = 40x
    add  HL, BC         ; 1:11      167 *      +1 = 41x 
    add  HL, HL         ; 1:11      167 *   1  *2 = 82x
    add  HL, BC         ; 1:11      167 *      +1 = 83x 
    add  HL, HL         ; 1:11      167 *   1  *2 = 166x
    add  HL, BC         ; 1:11      167 *      +1 = 167x   
                        ;[12:118]   169 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1010_1001)
    ld    B, H          ; 1:4       169 *
    ld    C, L          ; 1:4       169 *   1       1x = base 
    add  HL, HL         ; 1:11      169 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      169 *   1  *2 = 4x
    add  HL, BC         ; 1:11      169 *      +1 = 5x 
    add  HL, HL         ; 1:11      169 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      169 *   1  *2 = 20x
    add  HL, BC         ; 1:11      169 *      +1 = 21x 
    add  HL, HL         ; 1:11      169 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      169 *   0  *2 = 84x 
    add  HL, HL         ; 1:11      169 *   1  *2 = 168x
    add  HL, BC         ; 1:11      169 *      +1 = 169x   
                        ;[13:129]   171 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1010_1011)
    ld    B, H          ; 1:4       171 *
    ld    C, L          ; 1:4       171 *   1       1x = base 
    add  HL, HL         ; 1:11      171 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      171 *   1  *2 = 4x
    add  HL, BC         ; 1:11      171 *      +1 = 5x 
    add  HL, HL         ; 1:11      171 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      171 *   1  *2 = 20x
    add  HL, BC         ; 1:11      171 *      +1 = 21x 
    add  HL, HL         ; 1:11      171 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      171 *   1  *2 = 84x
    add  HL, BC         ; 1:11      171 *      +1 = 85x 
    add  HL, HL         ; 1:11      171 *   1  *2 = 170x
    add  HL, BC         ; 1:11      171 *      +1 = 171x   
                        ;[13:129]   173 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1010_1101)
    ld    B, H          ; 1:4       173 *
    ld    C, L          ; 1:4       173 *   1       1x = base 
    add  HL, HL         ; 1:11      173 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      173 *   1  *2 = 4x
    add  HL, BC         ; 1:11      173 *      +1 = 5x 
    add  HL, HL         ; 1:11      173 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      173 *   1  *2 = 20x
    add  HL, BC         ; 1:11      173 *      +1 = 21x 
    add  HL, HL         ; 1:11      173 *   1  *2 = 42x
    add  HL, BC         ; 1:11      173 *      +1 = 43x 
    add  HL, HL         ; 1:11      173 *   0  *2 = 86x 
    add  HL, HL         ; 1:11      173 *   1  *2 = 172x
    add  HL, BC         ; 1:11      173 *      +1 = 173x   
                        ;[14:140]   175 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1010_1111)
    ld    B, H          ; 1:4       175 *
    ld    C, L          ; 1:4       175 *   1       1x = base 
    add  HL, HL         ; 1:11      175 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      175 *   1  *2 = 4x
    add  HL, BC         ; 1:11      175 *      +1 = 5x 
    add  HL, HL         ; 1:11      175 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      175 *   1  *2 = 20x
    add  HL, BC         ; 1:11      175 *      +1 = 21x 
    add  HL, HL         ; 1:11      175 *   1  *2 = 42x
    add  HL, BC         ; 1:11      175 *      +1 = 43x 
    add  HL, HL         ; 1:11      175 *   1  *2 = 86x
    add  HL, BC         ; 1:11      175 *      +1 = 87x 
    add  HL, HL         ; 1:11      175 *   1  *2 = 174x
    add  HL, BC         ; 1:11      175 *      +1 = 175x   
                        ;[12:118]   177 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011_0001)
    ld    B, H          ; 1:4       177 *
    ld    C, L          ; 1:4       177 *   1       1x = base 
    add  HL, HL         ; 1:11      177 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      177 *   1  *2 = 4x
    add  HL, BC         ; 1:11      177 *      +1 = 5x 
    add  HL, HL         ; 1:11      177 *   1  *2 = 10x
    add  HL, BC         ; 1:11      177 *      +1 = 11x 
    add  HL, HL         ; 1:11      177 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      177 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      177 *   0  *2 = 88x 
    add  HL, HL         ; 1:11      177 *   1  *2 = 176x
    add  HL, BC         ; 1:11      177 *      +1 = 177x   
                        ;[13:129]   179 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011_0011)
    ld    B, H          ; 1:4       179 *
    ld    C, L          ; 1:4       179 *   1       1x = base 
    add  HL, HL         ; 1:11      179 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      179 *   1  *2 = 4x
    add  HL, BC         ; 1:11      179 *      +1 = 5x 
    add  HL, HL         ; 1:11      179 *   1  *2 = 10x
    add  HL, BC         ; 1:11      179 *      +1 = 11x 
    add  HL, HL         ; 1:11      179 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      179 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      179 *   1  *2 = 88x
    add  HL, BC         ; 1:11      179 *      +1 = 89x 
    add  HL, HL         ; 1:11      179 *   1  *2 = 178x
    add  HL, BC         ; 1:11      179 *      +1 = 179x   
                        ;[13:129]   181 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011_0101)
    ld    B, H          ; 1:4       181 *
    ld    C, L          ; 1:4       181 *   1       1x = base 
    add  HL, HL         ; 1:11      181 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      181 *   1  *2 = 4x
    add  HL, BC         ; 1:11      181 *      +1 = 5x 
    add  HL, HL         ; 1:11      181 *   1  *2 = 10x
    add  HL, BC         ; 1:11      181 *      +1 = 11x 
    add  HL, HL         ; 1:11      181 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      181 *   1  *2 = 44x
    add  HL, BC         ; 1:11      181 *      +1 = 45x 
    add  HL, HL         ; 1:11      181 *   0  *2 = 90x 
    add  HL, HL         ; 1:11      181 *   1  *2 = 180x
    add  HL, BC         ; 1:11      181 *      +1 = 181x   
                        ;[14:140]   183 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011_0111)
    ld    B, H          ; 1:4       183 *
    ld    C, L          ; 1:4       183 *   1       1x = base 
    add  HL, HL         ; 1:11      183 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      183 *   1  *2 = 4x
    add  HL, BC         ; 1:11      183 *      +1 = 5x 
    add  HL, HL         ; 1:11      183 *   1  *2 = 10x
    add  HL, BC         ; 1:11      183 *      +1 = 11x 
    add  HL, HL         ; 1:11      183 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      183 *   1  *2 = 44x
    add  HL, BC         ; 1:11      183 *      +1 = 45x 
    add  HL, HL         ; 1:11      183 *   1  *2 = 90x
    add  HL, BC         ; 1:11      183 *      +1 = 91x 
    add  HL, HL         ; 1:11      183 *   1  *2 = 182x
    add  HL, BC         ; 1:11      183 *      +1 = 183x   
                        ;[13:129]   185 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011_1001)
    ld    B, H          ; 1:4       185 *
    ld    C, L          ; 1:4       185 *   1       1x = base 
    add  HL, HL         ; 1:11      185 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      185 *   1  *2 = 4x
    add  HL, BC         ; 1:11      185 *      +1 = 5x 
    add  HL, HL         ; 1:11      185 *   1  *2 = 10x
    add  HL, BC         ; 1:11      185 *      +1 = 11x 
    add  HL, HL         ; 1:11      185 *   1  *2 = 22x
    add  HL, BC         ; 1:11      185 *      +1 = 23x 
    add  HL, HL         ; 1:11      185 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      185 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      185 *   1  *2 = 184x
    add  HL, BC         ; 1:11      185 *      +1 = 185x   
                        ;[14:140]   187 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011_1011)
    ld    B, H          ; 1:4       187 *
    ld    C, L          ; 1:4       187 *   1       1x = base 
    add  HL, HL         ; 1:11      187 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      187 *   1  *2 = 4x
    add  HL, BC         ; 1:11      187 *      +1 = 5x 
    add  HL, HL         ; 1:11      187 *   1  *2 = 10x
    add  HL, BC         ; 1:11      187 *      +1 = 11x 
    add  HL, HL         ; 1:11      187 *   1  *2 = 22x
    add  HL, BC         ; 1:11      187 *      +1 = 23x 
    add  HL, HL         ; 1:11      187 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      187 *   1  *2 = 92x
    add  HL, BC         ; 1:11      187 *      +1 = 93x 
    add  HL, HL         ; 1:11      187 *   1  *2 = 186x
    add  HL, BC         ; 1:11      187 *      +1 = 187x  

                        ;[14:140]   189 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011_1101)
    ld    B, H          ; 1:4       189 *
    ld    C, L          ; 1:4       189 *   1       1x = base 
    add  HL, HL         ; 1:11      189 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      189 *   1  *2 = 4x
    add  HL, BC         ; 1:11      189 *      +1 = 5x 
    add  HL, HL         ; 1:11      189 *   1  *2 = 10x
    add  HL, BC         ; 1:11      189 *      +1 = 11x 
    add  HL, HL         ; 1:11      189 *   1  *2 = 22x
    add  HL, BC         ; 1:11      189 *      +1 = 23x 
    add  HL, HL         ; 1:11      189 *   1  *2 = 46x
    add  HL, BC         ; 1:11      189 *      +1 = 47x 
    add  HL, HL         ; 1:11      189 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      189 *   1  *2 = 188x
    add  HL, BC         ; 1:11      189 *      +1 = 189x   
                        ;[15:151]   191 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1011_1111)
    ld    B, H          ; 1:4       191 *
    ld    C, L          ; 1:4       191 *   1       1x = base 
    add  HL, HL         ; 1:11      191 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      191 *   1  *2 = 4x
    add  HL, BC         ; 1:11      191 *      +1 = 5x 
    add  HL, HL         ; 1:11      191 *   1  *2 = 10x
    add  HL, BC         ; 1:11      191 *      +1 = 11x 
    add  HL, HL         ; 1:11      191 *   1  *2 = 22x
    add  HL, BC         ; 1:11      191 *      +1 = 23x 
    add  HL, HL         ; 1:11      191 *   1  *2 = 46x
    add  HL, BC         ; 1:11      191 *      +1 = 47x 
    add  HL, HL         ; 1:11      191 *   1  *2 = 94x
    add  HL, BC         ; 1:11      191 *      +1 = 95x 
    add  HL, HL         ; 1:11      191 *   1  *2 = 190x
    add  HL, BC         ; 1:11      191 *      +1 = 191x   
                        ;[11:107]   193 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1100_0001)
    ld    B, H          ; 1:4       193 *
    ld    C, L          ; 1:4       193 *   1       1x = base 
    add  HL, HL         ; 1:11      193 *   1  *2 = 2x
    add  HL, BC         ; 1:11      193 *      +1 = 3x 
    add  HL, HL         ; 1:11      193 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      193 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      193 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      193 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      193 *   0  *2 = 96x 
    add  HL, HL         ; 1:11      193 *   1  *2 = 192x
    add  HL, BC         ; 1:11      193 *      +1 = 193x   
                        ;[12:118]   195 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1100_0011)
    ld    B, H          ; 1:4       195 *
    ld    C, L          ; 1:4       195 *   1       1x = base 
    add  HL, HL         ; 1:11      195 *   1  *2 = 2x
    add  HL, BC         ; 1:11      195 *      +1 = 3x 
    add  HL, HL         ; 1:11      195 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      195 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      195 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      195 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      195 *   1  *2 = 96x
    add  HL, BC         ; 1:11      195 *      +1 = 97x 
    add  HL, HL         ; 1:11      195 *   1  *2 = 194x
    add  HL, BC         ; 1:11      195 *      +1 = 195x   
                        ;[12:118]   197 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1100_0101)
    ld    B, H          ; 1:4       197 *
    ld    C, L          ; 1:4       197 *   1       1x = base 
    add  HL, HL         ; 1:11      197 *   1  *2 = 2x
    add  HL, BC         ; 1:11      197 *      +1 = 3x 
    add  HL, HL         ; 1:11      197 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      197 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      197 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      197 *   1  *2 = 48x
    add  HL, BC         ; 1:11      197 *      +1 = 49x 
    add  HL, HL         ; 1:11      197 *   0  *2 = 98x 
    add  HL, HL         ; 1:11      197 *   1  *2 = 196x
    add  HL, BC         ; 1:11      197 *      +1 = 197x   
                        ;[13:129]   199 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1100_0111)
    ld    B, H          ; 1:4       199 *
    ld    C, L          ; 1:4       199 *   1       1x = base 
    add  HL, HL         ; 1:11      199 *   1  *2 = 2x
    add  HL, BC         ; 1:11      199 *      +1 = 3x 
    add  HL, HL         ; 1:11      199 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      199 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      199 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      199 *   1  *2 = 48x
    add  HL, BC         ; 1:11      199 *      +1 = 49x 
    add  HL, HL         ; 1:11      199 *   1  *2 = 98x
    add  HL, BC         ; 1:11      199 *      +1 = 99x 
    add  HL, HL         ; 1:11      199 *   1  *2 = 198x
    add  HL, BC         ; 1:11      199 *      +1 = 199x   
                        ;[12:118]   201 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1100_1001)
    ld    B, H          ; 1:4       201 *
    ld    C, L          ; 1:4       201 *   1       1x = base 
    add  HL, HL         ; 1:11      201 *   1  *2 = 2x
    add  HL, BC         ; 1:11      201 *      +1 = 3x 
    add  HL, HL         ; 1:11      201 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      201 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      201 *   1  *2 = 24x
    add  HL, BC         ; 1:11      201 *      +1 = 25x 
    add  HL, HL         ; 1:11      201 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      201 *   0  *2 = 100x 
    add  HL, HL         ; 1:11      201 *   1  *2 = 200x
    add  HL, BC         ; 1:11      201 *      +1 = 201x   
                        ;[13:129]   203 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1100_1011)
    ld    B, H          ; 1:4       203 *
    ld    C, L          ; 1:4       203 *   1       1x = base 
    add  HL, HL         ; 1:11      203 *   1  *2 = 2x
    add  HL, BC         ; 1:11      203 *      +1 = 3x 
    add  HL, HL         ; 1:11      203 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      203 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      203 *   1  *2 = 24x
    add  HL, BC         ; 1:11      203 *      +1 = 25x 
    add  HL, HL         ; 1:11      203 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      203 *   1  *2 = 100x
    add  HL, BC         ; 1:11      203 *      +1 = 101x 
    add  HL, HL         ; 1:11      203 *   1  *2 = 202x
    add  HL, BC         ; 1:11      203 *      +1 = 203x   
                        ;[13:129]   205 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1100_1101)
    ld    B, H          ; 1:4       205 *
    ld    C, L          ; 1:4       205 *   1       1x = base 
    add  HL, HL         ; 1:11      205 *   1  *2 = 2x
    add  HL, BC         ; 1:11      205 *      +1 = 3x 
    add  HL, HL         ; 1:11      205 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      205 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      205 *   1  *2 = 24x
    add  HL, BC         ; 1:11      205 *      +1 = 25x 
    add  HL, HL         ; 1:11      205 *   1  *2 = 50x
    add  HL, BC         ; 1:11      205 *      +1 = 51x 
    add  HL, HL         ; 1:11      205 *   0  *2 = 102x 
    add  HL, HL         ; 1:11      205 *   1  *2 = 204x
    add  HL, BC         ; 1:11      205 *      +1 = 205x   
                        ;[14:140]   207 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1100_1111)
    ld    B, H          ; 1:4       207 *
    ld    C, L          ; 1:4       207 *   1       1x = base 
    add  HL, HL         ; 1:11      207 *   1  *2 = 2x
    add  HL, BC         ; 1:11      207 *      +1 = 3x 
    add  HL, HL         ; 1:11      207 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      207 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      207 *   1  *2 = 24x
    add  HL, BC         ; 1:11      207 *      +1 = 25x 
    add  HL, HL         ; 1:11      207 *   1  *2 = 50x
    add  HL, BC         ; 1:11      207 *      +1 = 51x 
    add  HL, HL         ; 1:11      207 *   1  *2 = 102x
    add  HL, BC         ; 1:11      207 *      +1 = 103x 
    add  HL, HL         ; 1:11      207 *   1  *2 = 206x
    add  HL, BC         ; 1:11      207 *      +1 = 207x   
                        ;[12:118]   209 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101_0001)
    ld    B, H          ; 1:4       209 *
    ld    C, L          ; 1:4       209 *   1       1x = base 
    add  HL, HL         ; 1:11      209 *   1  *2 = 2x
    add  HL, BC         ; 1:11      209 *      +1 = 3x 
    add  HL, HL         ; 1:11      209 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      209 *   1  *2 = 12x
    add  HL, BC         ; 1:11      209 *      +1 = 13x 
    add  HL, HL         ; 1:11      209 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      209 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      209 *   0  *2 = 104x 
    add  HL, HL         ; 1:11      209 *   1  *2 = 208x
    add  HL, BC         ; 1:11      209 *      +1 = 209x  

                        ;[13:129]   211 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101_0011)
    ld    B, H          ; 1:4       211 *
    ld    C, L          ; 1:4       211 *   1       1x = base 
    add  HL, HL         ; 1:11      211 *   1  *2 = 2x
    add  HL, BC         ; 1:11      211 *      +1 = 3x 
    add  HL, HL         ; 1:11      211 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      211 *   1  *2 = 12x
    add  HL, BC         ; 1:11      211 *      +1 = 13x 
    add  HL, HL         ; 1:11      211 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      211 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      211 *   1  *2 = 104x
    add  HL, BC         ; 1:11      211 *      +1 = 105x 
    add  HL, HL         ; 1:11      211 *   1  *2 = 210x
    add  HL, BC         ; 1:11      211 *      +1 = 211x   
                        ;[13:129]   213 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101_0101)
    ld    B, H          ; 1:4       213 *
    ld    C, L          ; 1:4       213 *   1       1x = base 
    add  HL, HL         ; 1:11      213 *   1  *2 = 2x
    add  HL, BC         ; 1:11      213 *      +1 = 3x 
    add  HL, HL         ; 1:11      213 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      213 *   1  *2 = 12x
    add  HL, BC         ; 1:11      213 *      +1 = 13x 
    add  HL, HL         ; 1:11      213 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      213 *   1  *2 = 52x
    add  HL, BC         ; 1:11      213 *      +1 = 53x 
    add  HL, HL         ; 1:11      213 *   0  *2 = 106x 
    add  HL, HL         ; 1:11      213 *   1  *2 = 212x
    add  HL, BC         ; 1:11      213 *      +1 = 213x   
                        ;[14:140]   215 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101_0111)
    ld    B, H          ; 1:4       215 *
    ld    C, L          ; 1:4       215 *   1       1x = base 
    add  HL, HL         ; 1:11      215 *   1  *2 = 2x
    add  HL, BC         ; 1:11      215 *      +1 = 3x 
    add  HL, HL         ; 1:11      215 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      215 *   1  *2 = 12x
    add  HL, BC         ; 1:11      215 *      +1 = 13x 
    add  HL, HL         ; 1:11      215 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      215 *   1  *2 = 52x
    add  HL, BC         ; 1:11      215 *      +1 = 53x 
    add  HL, HL         ; 1:11      215 *   1  *2 = 106x
    add  HL, BC         ; 1:11      215 *      +1 = 107x 
    add  HL, HL         ; 1:11      215 *   1  *2 = 214x
    add  HL, BC         ; 1:11      215 *      +1 = 215x   
                        ;[13:129]   217 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101_1001)
    ld    B, H          ; 1:4       217 *
    ld    C, L          ; 1:4       217 *   1       1x = base 
    add  HL, HL         ; 1:11      217 *   1  *2 = 2x
    add  HL, BC         ; 1:11      217 *      +1 = 3x 
    add  HL, HL         ; 1:11      217 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      217 *   1  *2 = 12x
    add  HL, BC         ; 1:11      217 *      +1 = 13x 
    add  HL, HL         ; 1:11      217 *   1  *2 = 26x
    add  HL, BC         ; 1:11      217 *      +1 = 27x 
    add  HL, HL         ; 1:11      217 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      217 *   0  *2 = 108x 
    add  HL, HL         ; 1:11      217 *   1  *2 = 216x
    add  HL, BC         ; 1:11      217 *      +1 = 217x   
                        ;[14:140]   219 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101_1011)
    ld    B, H          ; 1:4       219 *
    ld    C, L          ; 1:4       219 *   1       1x = base 
    add  HL, HL         ; 1:11      219 *   1  *2 = 2x
    add  HL, BC         ; 1:11      219 *      +1 = 3x 
    add  HL, HL         ; 1:11      219 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      219 *   1  *2 = 12x
    add  HL, BC         ; 1:11      219 *      +1 = 13x 
    add  HL, HL         ; 1:11      219 *   1  *2 = 26x
    add  HL, BC         ; 1:11      219 *      +1 = 27x 
    add  HL, HL         ; 1:11      219 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      219 *   1  *2 = 108x
    add  HL, BC         ; 1:11      219 *      +1 = 109x 
    add  HL, HL         ; 1:11      219 *   1  *2 = 218x
    add  HL, BC         ; 1:11      219 *      +1 = 219x   
                        ;[14:140]   221 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101_1101)
    ld    B, H          ; 1:4       221 *
    ld    C, L          ; 1:4       221 *   1       1x = base 
    add  HL, HL         ; 1:11      221 *   1  *2 = 2x
    add  HL, BC         ; 1:11      221 *      +1 = 3x 
    add  HL, HL         ; 1:11      221 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      221 *   1  *2 = 12x
    add  HL, BC         ; 1:11      221 *      +1 = 13x 
    add  HL, HL         ; 1:11      221 *   1  *2 = 26x
    add  HL, BC         ; 1:11      221 *      +1 = 27x 
    add  HL, HL         ; 1:11      221 *   1  *2 = 54x
    add  HL, BC         ; 1:11      221 *      +1 = 55x 
    add  HL, HL         ; 1:11      221 *   0  *2 = 110x 
    add  HL, HL         ; 1:11      221 *   1  *2 = 220x
    add  HL, BC         ; 1:11      221 *      +1 = 221x   
                        ;[15:151]   223 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1101_1111)
    ld    B, H          ; 1:4       223 *
    ld    C, L          ; 1:4       223 *   1       1x = base 
    add  HL, HL         ; 1:11      223 *   1  *2 = 2x
    add  HL, BC         ; 1:11      223 *      +1 = 3x 
    add  HL, HL         ; 1:11      223 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      223 *   1  *2 = 12x
    add  HL, BC         ; 1:11      223 *      +1 = 13x 
    add  HL, HL         ; 1:11      223 *   1  *2 = 26x
    add  HL, BC         ; 1:11      223 *      +1 = 27x 
    add  HL, HL         ; 1:11      223 *   1  *2 = 54x
    add  HL, BC         ; 1:11      223 *      +1 = 55x 
    add  HL, HL         ; 1:11      223 *   1  *2 = 110x
    add  HL, BC         ; 1:11      223 *      +1 = 111x 
    add  HL, HL         ; 1:11      223 *   1  *2 = 222x
    add  HL, BC         ; 1:11      223 *      +1 = 223x   
                        ;[12:118]   225 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1110_0001)
    ld    B, H          ; 1:4       225 *
    ld    C, L          ; 1:4       225 *   1       1x = base 
    add  HL, HL         ; 1:11      225 *   1  *2 = 2x
    add  HL, BC         ; 1:11      225 *      +1 = 3x 
    add  HL, HL         ; 1:11      225 *   1  *2 = 6x
    add  HL, BC         ; 1:11      225 *      +1 = 7x 
    add  HL, HL         ; 1:11      225 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      225 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      225 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      225 *   0  *2 = 112x 
    add  HL, HL         ; 1:11      225 *   1  *2 = 224x
    add  HL, BC         ; 1:11      225 *      +1 = 225x   
                        ;[13:129]   227 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1110_0011)
    ld    B, H          ; 1:4       227 *
    ld    C, L          ; 1:4       227 *   1       1x = base 
    add  HL, HL         ; 1:11      227 *   1  *2 = 2x
    add  HL, BC         ; 1:11      227 *      +1 = 3x 
    add  HL, HL         ; 1:11      227 *   1  *2 = 6x
    add  HL, BC         ; 1:11      227 *      +1 = 7x 
    add  HL, HL         ; 1:11      227 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      227 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      227 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      227 *   1  *2 = 112x
    add  HL, BC         ; 1:11      227 *      +1 = 113x 
    add  HL, HL         ; 1:11      227 *   1  *2 = 226x
    add  HL, BC         ; 1:11      227 *      +1 = 227x   
                        ;[13:129]   229 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1110_0101)
    ld    B, H          ; 1:4       229 *
    ld    C, L          ; 1:4       229 *   1       1x = base 
    add  HL, HL         ; 1:11      229 *   1  *2 = 2x
    add  HL, BC         ; 1:11      229 *      +1 = 3x 
    add  HL, HL         ; 1:11      229 *   1  *2 = 6x
    add  HL, BC         ; 1:11      229 *      +1 = 7x 
    add  HL, HL         ; 1:11      229 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      229 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      229 *   1  *2 = 56x
    add  HL, BC         ; 1:11      229 *      +1 = 57x 
    add  HL, HL         ; 1:11      229 *   0  *2 = 114x 
    add  HL, HL         ; 1:11      229 *   1  *2 = 228x
    add  HL, BC         ; 1:11      229 *      +1 = 229x   
                        ;[14:140]   231 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1110_0111)
    ld    B, H          ; 1:4       231 *
    ld    C, L          ; 1:4       231 *   1       1x = base 
    add  HL, HL         ; 1:11      231 *   1  *2 = 2x
    add  HL, BC         ; 1:11      231 *      +1 = 3x 
    add  HL, HL         ; 1:11      231 *   1  *2 = 6x
    add  HL, BC         ; 1:11      231 *      +1 = 7x 
    add  HL, HL         ; 1:11      231 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      231 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      231 *   1  *2 = 56x
    add  HL, BC         ; 1:11      231 *      +1 = 57x 
    add  HL, HL         ; 1:11      231 *   1  *2 = 114x
    add  HL, BC         ; 1:11      231 *      +1 = 115x 
    add  HL, HL         ; 1:11      231 *   1  *2 = 230x
    add  HL, BC         ; 1:11      231 *      +1 = 231x  

                        ;[13:129]   233 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1110_1001)
    ld    B, H          ; 1:4       233 *
    ld    C, L          ; 1:4       233 *   1       1x = base 
    add  HL, HL         ; 1:11      233 *   1  *2 = 2x
    add  HL, BC         ; 1:11      233 *      +1 = 3x 
    add  HL, HL         ; 1:11      233 *   1  *2 = 6x
    add  HL, BC         ; 1:11      233 *      +1 = 7x 
    add  HL, HL         ; 1:11      233 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      233 *   1  *2 = 28x
    add  HL, BC         ; 1:11      233 *      +1 = 29x 
    add  HL, HL         ; 1:11      233 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      233 *   0  *2 = 116x 
    add  HL, HL         ; 1:11      233 *   1  *2 = 232x
    add  HL, BC         ; 1:11      233 *      +1 = 233x   
                        ;[14:140]   235 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1110_1011)
    ld    B, H          ; 1:4       235 *
    ld    C, L          ; 1:4       235 *   1       1x = base 
    add  HL, HL         ; 1:11      235 *   1  *2 = 2x
    add  HL, BC         ; 1:11      235 *      +1 = 3x 
    add  HL, HL         ; 1:11      235 *   1  *2 = 6x
    add  HL, BC         ; 1:11      235 *      +1 = 7x 
    add  HL, HL         ; 1:11      235 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      235 *   1  *2 = 28x
    add  HL, BC         ; 1:11      235 *      +1 = 29x 
    add  HL, HL         ; 1:11      235 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      235 *   1  *2 = 116x
    add  HL, BC         ; 1:11      235 *      +1 = 117x 
    add  HL, HL         ; 1:11      235 *   1  *2 = 234x
    add  HL, BC         ; 1:11      235 *      +1 = 235x   
                        ;[14:140]   237 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1110_1101)
    ld    B, H          ; 1:4       237 *
    ld    C, L          ; 1:4       237 *   1       1x = base 
    add  HL, HL         ; 1:11      237 *   1  *2 = 2x
    add  HL, BC         ; 1:11      237 *      +1 = 3x 
    add  HL, HL         ; 1:11      237 *   1  *2 = 6x
    add  HL, BC         ; 1:11      237 *      +1 = 7x 
    add  HL, HL         ; 1:11      237 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      237 *   1  *2 = 28x
    add  HL, BC         ; 1:11      237 *      +1 = 29x 
    add  HL, HL         ; 1:11      237 *   1  *2 = 58x
    add  HL, BC         ; 1:11      237 *      +1 = 59x 
    add  HL, HL         ; 1:11      237 *   0  *2 = 118x 
    add  HL, HL         ; 1:11      237 *   1  *2 = 236x
    add  HL, BC         ; 1:11      237 *      +1 = 237x   
                        ;[15:95]    239 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0001_0000_0000 - b_0001_0001)  
    ld    A, L          ; 1:4       239 *   save --256x-- 
    ld    B, H          ; 1:4       239 *
    ld    C, L          ; 1:4       239 *   [1x] 
    add  HL, HL         ; 1:11      239 *   2x 
    add  HL, HL         ; 1:11      239 *   4x 
    add  HL, HL         ; 1:11      239 *   8x 
    add  HL, HL         ; 1:11      239 *   16x 
    add  HL, BC         ; 1:11      239 *   [17x]
    ld    B, A          ; 1:4       239 *   A0 - HL
    xor   A             ; 1:4       239 *
    sub   L             ; 1:4       239 *
    ld    L, A          ; 1:4       239 *
    ld    A, B          ; 1:4       239 *
    sbc   A, H          ; 1:4       239 *
    ld    H, A          ; 1:4       239 *   [239x] = 256x - 256x    
                        ;[13:129]   241 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1111_0001)
    ld    B, H          ; 1:4       241 *
    ld    C, L          ; 1:4       241 *   1       1x = base 
    add  HL, HL         ; 1:11      241 *   1  *2 = 2x
    add  HL, BC         ; 1:11      241 *      +1 = 3x 
    add  HL, HL         ; 1:11      241 *   1  *2 = 6x
    add  HL, BC         ; 1:11      241 *      +1 = 7x 
    add  HL, HL         ; 1:11      241 *   1  *2 = 14x
    add  HL, BC         ; 1:11      241 *      +1 = 15x 
    add  HL, HL         ; 1:11      241 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      241 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      241 *   0  *2 = 120x 
    add  HL, HL         ; 1:11      241 *   1  *2 = 240x
    add  HL, BC         ; 1:11      241 *      +1 = 241x   
                        ;[14:140]   243 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1111_0011)
    ld    B, H          ; 1:4       243 *
    ld    C, L          ; 1:4       243 *   1       1x = base 
    add  HL, HL         ; 1:11      243 *   1  *2 = 2x
    add  HL, BC         ; 1:11      243 *      +1 = 3x 
    add  HL, HL         ; 1:11      243 *   1  *2 = 6x
    add  HL, BC         ; 1:11      243 *      +1 = 7x 
    add  HL, HL         ; 1:11      243 *   1  *2 = 14x
    add  HL, BC         ; 1:11      243 *      +1 = 15x 
    add  HL, HL         ; 1:11      243 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      243 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      243 *   1  *2 = 120x
    add  HL, BC         ; 1:11      243 *      +1 = 121x 
    add  HL, HL         ; 1:11      243 *   1  *2 = 242x
    add  HL, BC         ; 1:11      243 *      +1 = 243x   
                        ;[14:140]   245 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1111_0101)
    ld    B, H          ; 1:4       245 *
    ld    C, L          ; 1:4       245 *   1       1x = base 
    add  HL, HL         ; 1:11      245 *   1  *2 = 2x
    add  HL, BC         ; 1:11      245 *      +1 = 3x 
    add  HL, HL         ; 1:11      245 *   1  *2 = 6x
    add  HL, BC         ; 1:11      245 *      +1 = 7x 
    add  HL, HL         ; 1:11      245 *   1  *2 = 14x
    add  HL, BC         ; 1:11      245 *      +1 = 15x 
    add  HL, HL         ; 1:11      245 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      245 *   1  *2 = 60x
    add  HL, BC         ; 1:11      245 *      +1 = 61x 
    add  HL, HL         ; 1:11      245 *   0  *2 = 122x 
    add  HL, HL         ; 1:11      245 *   1  *2 = 244x
    add  HL, BC         ; 1:11      245 *      +1 = 245x   
                        ;[14:84]    247 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0001_0000_0000 - b_1001)  
    ld    A, L          ; 1:4       247 *   save --256x-- 
    ld    B, H          ; 1:4       247 *
    ld    C, L          ; 1:4       247 *   [1x] 
    add  HL, HL         ; 1:11      247 *   2x 
    add  HL, HL         ; 1:11      247 *   4x 
    add  HL, HL         ; 1:11      247 *   8x 
    add  HL, BC         ; 1:11      247 *   [9x]
    ld    B, A          ; 1:4       247 *   A0 - HL
    xor   A             ; 1:4       247 *
    sub   L             ; 1:4       247 *
    ld    L, A          ; 1:4       247 *
    ld    A, B          ; 1:4       247 *
    sbc   A, H          ; 1:4       247 *
    ld    H, A          ; 1:4       247 *   [247x] = 256x - 256x    
                        ;[14:140]   249 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_1111_1001)
    ld    B, H          ; 1:4       249 *
    ld    C, L          ; 1:4       249 *   1       1x = base 
    add  HL, HL         ; 1:11      249 *   1  *2 = 2x
    add  HL, BC         ; 1:11      249 *      +1 = 3x 
    add  HL, HL         ; 1:11      249 *   1  *2 = 6x
    add  HL, BC         ; 1:11      249 *      +1 = 7x 
    add  HL, HL         ; 1:11      249 *   1  *2 = 14x
    add  HL, BC         ; 1:11      249 *      +1 = 15x 
    add  HL, HL         ; 1:11      249 *   1  *2 = 30x
    add  HL, BC         ; 1:11      249 *      +1 = 31x 
    add  HL, HL         ; 1:11      249 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      249 *   0  *2 = 124x 
    add  HL, HL         ; 1:11      249 *   1  *2 = 248x
    add  HL, BC         ; 1:11      249 *      +1 = 249x   
                        ;[13:73]    251 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0001_0000_0000 - b_0101)  
    ld    A, L          ; 1:4       251 *   save --256x-- 
    ld    B, H          ; 1:4       251 *
    ld    C, L          ; 1:4       251 *   [1x] 
    add  HL, HL         ; 1:11      251 *   2x 
    add  HL, HL         ; 1:11      251 *   4x 
    add  HL, BC         ; 1:11      251 *   [5x]
    ld    B, A          ; 1:4       251 *   A0 - HL
    xor   A             ; 1:4       251 *
    sub   L             ; 1:4       251 *
    ld    L, A          ; 1:4       251 *
    ld    A, B          ; 1:4       251 *
    sbc   A, H          ; 1:4       251 *
    ld    H, A          ; 1:4       251 *   [251x] = 256x - 256x    
                        ;[12:62]    253 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0001_0000_0000 - b_0011)  
    ld    A, L          ; 1:4       253 *   save --256x-- 
    ld    B, H          ; 1:4       253 *
    ld    C, L          ; 1:4       253 *   [1x] 
    add  HL, HL         ; 1:11      253 *   2x 
    add  HL, BC         ; 1:11      253 *   [3x]
    ld    B, A          ; 1:4       253 *   A0 - HL
    xor   A             ; 1:4       253 *
    sub   L             ; 1:4       253 *
    ld    L, A          ; 1:4       253 *
    ld    A, B          ; 1:4       253 *
    sbc   A, H          ; 1:4       253 *
    ld    H, A          ; 1:4       253 *   [253x] = 256x - 256x   

                        ;[7:35]     255 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0001_0000_0000 - b_0001)  
    ld    B, H          ; 1:4       255 *
    ld    C, L          ; 1:4       255 *   L0 - HL --> L0 - BC
    ld    H, L          ; 1:4       255 *
    xor   A             ; 1:4       255 *
    ld    L, A          ; 1:4       255 *   256x
    sbc  HL, BC         ; 2:15      255 *   [255x] = 256x - 1x    
                        ;[3:12]     257 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0001_0000_0001)  
    ld    A, L          ; 1:4       257 *   256x
    add   A, H          ; 1:4       257 *
    ld    H, A          ; 1:4       257 *   257x    
                        ;[7:42]     259 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0001_0000_0011)  
    ld    A, L          ; 1:4       259 *   256x 
    ld    B, H          ; 1:4       259 *
    ld    C, L          ; 1:4       259 *   [1x] 
    add  HL, HL         ; 1:11      259 *   2x 
    add   A, B          ; 1:4       259 *
    ld    B, A          ; 1:4       259 *   [257x] 
    add  HL, BC         ; 1:11      259 *   [259x] = 2x + 257x   
                        ;[8:53]     261 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0001_0000_0101)  
    ld    A, L          ; 1:4       261 *   256x 
    ld    B, H          ; 1:4       261 *
    ld    C, L          ; 1:4       261 *   [1x] 
    add  HL, HL         ; 1:11      261 *   2x 
    add  HL, HL         ; 1:11      261 *   4x 
    add   A, B          ; 1:4       261 *
    ld    B, A          ; 1:4       261 *   [257x] 
    add  HL, BC         ; 1:11      261 *   [261x] = 4x + 257x   
                        ;[9:64]     263 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0000_0111)
    ld    B, H          ; 1:4       263 *
    ld    C, L          ; 1:4       263 *   1       1x = base 
    ld    A, L          ; 1:4       263 *   256*L = 256x 
    add  HL, HL         ; 1:11      263 *   1  *2 = 2x
    add  HL, BC         ; 1:11      263 *      +1 = 3x 
    add  HL, HL         ; 1:11      263 *   1  *2 = 6x
    add  HL, BC         ; 1:11      263 *      +1 = 7x 
    add   A, H          ; 1:4       263 *
    ld    H, A          ; 1:4       263 *     [263x] = 7x + 256x  
                        ;[9:64]     265 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0001_0000_1001)  
    ld    A, L          ; 1:4       265 *   256x 
    ld    B, H          ; 1:4       265 *
    ld    C, L          ; 1:4       265 *   [1x] 
    add  HL, HL         ; 1:11      265 *   2x 
    add  HL, HL         ; 1:11      265 *   4x 
    add  HL, HL         ; 1:11      265 *   8x 
    add   A, B          ; 1:4       265 *
    ld    B, A          ; 1:4       265 *   [257x] 
    add  HL, BC         ; 1:11      265 *   [265x] = 8x + 257x   
                        ;[10:75]    267 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0000_1011)
    ld    B, H          ; 1:4       267 *
    ld    C, L          ; 1:4       267 *   1       1x = base 
    ld    A, L          ; 1:4       267 *   256*L = 256x 
    add  HL, HL         ; 1:11      267 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      267 *   1  *2 = 4x
    add  HL, BC         ; 1:11      267 *      +1 = 5x 
    add  HL, HL         ; 1:11      267 *   1  *2 = 10x
    add  HL, BC         ; 1:11      267 *      +1 = 11x 
    add   A, H          ; 1:4       267 *
    ld    H, A          ; 1:4       267 *     [267x] = 11x + 256x  
                        ;[10:75]    269 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0000_1101)
    ld    B, H          ; 1:4       269 *
    ld    C, L          ; 1:4       269 *   1       1x = base 
    ld    A, L          ; 1:4       269 *   256*L = 256x 
    add  HL, HL         ; 1:11      269 *   1  *2 = 2x
    add  HL, BC         ; 1:11      269 *      +1 = 3x 
    add  HL, HL         ; 1:11      269 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      269 *   1  *2 = 12x
    add  HL, BC         ; 1:11      269 *      +1 = 13x 
    add   A, H          ; 1:4       269 *
    ld    H, A          ; 1:4       269 *     [269x] = 13x + 256x  
                        ;[11:86]    271 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0000_1111)
    ld    B, H          ; 1:4       271 *
    ld    C, L          ; 1:4       271 *   1       1x = base 
    ld    A, L          ; 1:4       271 *   256*L = 256x 
    add  HL, HL         ; 1:11      271 *   1  *2 = 2x
    add  HL, BC         ; 1:11      271 *      +1 = 3x 
    add  HL, HL         ; 1:11      271 *   1  *2 = 6x
    add  HL, BC         ; 1:11      271 *      +1 = 7x 
    add  HL, HL         ; 1:11      271 *   1  *2 = 14x
    add  HL, BC         ; 1:11      271 *      +1 = 15x 
    add   A, H          ; 1:4       271 *
    ld    H, A          ; 1:4       271 *     [271x] = 15x + 256x  
                        ;[10:75]    273 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0001_0001_0001)  
    ld    A, L          ; 1:4       273 *   256x 
    ld    B, H          ; 1:4       273 *
    ld    C, L          ; 1:4       273 *   [1x] 
    add  HL, HL         ; 1:11      273 *   2x 
    add  HL, HL         ; 1:11      273 *   4x 
    add  HL, HL         ; 1:11      273 *   8x 
    add  HL, HL         ; 1:11      273 *   16x 
    add   A, B          ; 1:4       273 *
    ld    B, A          ; 1:4       273 *   [257x] 
    add  HL, BC         ; 1:11      273 *   [273x] = 16x + 257x   
                        ;[11:86]    275 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0001_0011)
    ld    B, H          ; 1:4       275 *
    ld    C, L          ; 1:4       275 *   1       1x = base 
    ld    A, L          ; 1:4       275 *   256*L = 256x 
    add  HL, HL         ; 1:11      275 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      275 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      275 *   1  *2 = 8x
    add  HL, BC         ; 1:11      275 *      +1 = 9x 
    add  HL, HL         ; 1:11      275 *   1  *2 = 18x
    add  HL, BC         ; 1:11      275 *      +1 = 19x 
    add   A, H          ; 1:4       275 *
    ld    H, A          ; 1:4       275 *     [275x] = 19x + 256x 

                        ;[11:86]    277 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0001_0101)
    ld    B, H          ; 1:4       277 *
    ld    C, L          ; 1:4       277 *   1       1x = base 
    ld    A, L          ; 1:4       277 *   256*L = 256x 
    add  HL, HL         ; 1:11      277 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      277 *   1  *2 = 4x
    add  HL, BC         ; 1:11      277 *      +1 = 5x 
    add  HL, HL         ; 1:11      277 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      277 *   1  *2 = 20x
    add  HL, BC         ; 1:11      277 *      +1 = 21x 
    add   A, H          ; 1:4       277 *
    ld    H, A          ; 1:4       277 *     [277x] = 21x + 256x  
                        ;[12:97]    279 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0001_0111)
    ld    B, H          ; 1:4       279 *
    ld    C, L          ; 1:4       279 *   1       1x = base 
    ld    A, L          ; 1:4       279 *   256*L = 256x 
    add  HL, HL         ; 1:11      279 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      279 *   1  *2 = 4x
    add  HL, BC         ; 1:11      279 *      +1 = 5x 
    add  HL, HL         ; 1:11      279 *   1  *2 = 10x
    add  HL, BC         ; 1:11      279 *      +1 = 11x 
    add  HL, HL         ; 1:11      279 *   1  *2 = 22x
    add  HL, BC         ; 1:11      279 *      +1 = 23x 
    add   A, H          ; 1:4       279 *
    ld    H, A          ; 1:4       279 *     [279x] = 23x + 256x  
                        ;[11:86]    281 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0001_1001)
    ld    B, H          ; 1:4       281 *
    ld    C, L          ; 1:4       281 *   1       1x = base 
    ld    A, L          ; 1:4       281 *   256*L = 256x 
    add  HL, HL         ; 1:11      281 *   1  *2 = 2x
    add  HL, BC         ; 1:11      281 *      +1 = 3x 
    add  HL, HL         ; 1:11      281 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      281 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      281 *   1  *2 = 24x
    add  HL, BC         ; 1:11      281 *      +1 = 25x 
    add   A, H          ; 1:4       281 *
    ld    H, A          ; 1:4       281 *     [281x] = 25x + 256x  
                        ;[12:97]    283 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0001_1011)
    ld    B, H          ; 1:4       283 *
    ld    C, L          ; 1:4       283 *   1       1x = base 
    ld    A, L          ; 1:4       283 *   256*L = 256x 
    add  HL, HL         ; 1:11      283 *   1  *2 = 2x
    add  HL, BC         ; 1:11      283 *      +1 = 3x 
    add  HL, HL         ; 1:11      283 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      283 *   1  *2 = 12x
    add  HL, BC         ; 1:11      283 *      +1 = 13x 
    add  HL, HL         ; 1:11      283 *   1  *2 = 26x
    add  HL, BC         ; 1:11      283 *      +1 = 27x 
    add   A, H          ; 1:4       283 *
    ld    H, A          ; 1:4       283 *     [283x] = 27x + 256x  
                        ;[12:97]    285 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0001_1101)
    ld    B, H          ; 1:4       285 *
    ld    C, L          ; 1:4       285 *   1       1x = base 
    ld    A, L          ; 1:4       285 *   256*L = 256x 
    add  HL, HL         ; 1:11      285 *   1  *2 = 2x
    add  HL, BC         ; 1:11      285 *      +1 = 3x 
    add  HL, HL         ; 1:11      285 *   1  *2 = 6x
    add  HL, BC         ; 1:11      285 *      +1 = 7x 
    add  HL, HL         ; 1:11      285 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      285 *   1  *2 = 28x
    add  HL, BC         ; 1:11      285 *      +1 = 29x 
    add   A, H          ; 1:4       285 *
    ld    H, A          ; 1:4       285 *     [285x] = 29x + 256x  
                        ;[13:108]   287 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0001_1111)
    ld    B, H          ; 1:4       287 *
    ld    C, L          ; 1:4       287 *   1       1x = base 
    ld    A, L          ; 1:4       287 *   256*L = 256x 
    add  HL, HL         ; 1:11      287 *   1  *2 = 2x
    add  HL, BC         ; 1:11      287 *      +1 = 3x 
    add  HL, HL         ; 1:11      287 *   1  *2 = 6x
    add  HL, BC         ; 1:11      287 *      +1 = 7x 
    add  HL, HL         ; 1:11      287 *   1  *2 = 14x
    add  HL, BC         ; 1:11      287 *      +1 = 15x 
    add  HL, HL         ; 1:11      287 *   1  *2 = 30x
    add  HL, BC         ; 1:11      287 *      +1 = 31x 
    add   A, H          ; 1:4       287 *
    ld    H, A          ; 1:4       287 *     [287x] = 31x + 256x  
                        ;[11:86]    289 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0001_0010_0001)  
    ld    A, L          ; 1:4       289 *   256x 
    ld    B, H          ; 1:4       289 *
    ld    C, L          ; 1:4       289 *   [1x] 
    add  HL, HL         ; 1:11      289 *   2x 
    add  HL, HL         ; 1:11      289 *   4x 
    add  HL, HL         ; 1:11      289 *   8x 
    add  HL, HL         ; 1:11      289 *   16x 
    add  HL, HL         ; 1:11      289 *   32x 
    add   A, B          ; 1:4       289 *
    ld    B, A          ; 1:4       289 *   [257x] 
    add  HL, BC         ; 1:11      289 *   [289x] = 32x + 257x   
                        ;[12:97]    291 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0010_0011)
    ld    B, H          ; 1:4       291 *
    ld    C, L          ; 1:4       291 *   1       1x = base 
    ld    A, L          ; 1:4       291 *   256*L = 256x 
    add  HL, HL         ; 1:11      291 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      291 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      291 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      291 *   1  *2 = 16x
    add  HL, BC         ; 1:11      291 *      +1 = 17x 
    add  HL, HL         ; 1:11      291 *   1  *2 = 34x
    add  HL, BC         ; 1:11      291 *      +1 = 35x 
    add   A, H          ; 1:4       291 *
    ld    H, A          ; 1:4       291 *     [291x] = 35x + 256x  
                        ;[12:97]    293 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0010_0101)
    ld    B, H          ; 1:4       293 *
    ld    C, L          ; 1:4       293 *   1       1x = base 
    ld    A, L          ; 1:4       293 *   256*L = 256x 
    add  HL, HL         ; 1:11      293 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      293 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      293 *   1  *2 = 8x
    add  HL, BC         ; 1:11      293 *      +1 = 9x 
    add  HL, HL         ; 1:11      293 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      293 *   1  *2 = 36x
    add  HL, BC         ; 1:11      293 *      +1 = 37x 
    add   A, H          ; 1:4       293 *
    ld    H, A          ; 1:4       293 *     [293x] = 37x + 256x  
                        ;[13:108]   295 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0010_0111)
    ld    B, H          ; 1:4       295 *
    ld    C, L          ; 1:4       295 *   1       1x = base 
    ld    A, L          ; 1:4       295 *   256*L = 256x 
    add  HL, HL         ; 1:11      295 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      295 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      295 *   1  *2 = 8x
    add  HL, BC         ; 1:11      295 *      +1 = 9x 
    add  HL, HL         ; 1:11      295 *   1  *2 = 18x
    add  HL, BC         ; 1:11      295 *      +1 = 19x 
    add  HL, HL         ; 1:11      295 *   1  *2 = 38x
    add  HL, BC         ; 1:11      295 *      +1 = 39x 
    add   A, H          ; 1:4       295 *
    ld    H, A          ; 1:4       295 *     [295x] = 39x + 256x  
                        ;[12:97]    297 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0010_1001)
    ld    B, H          ; 1:4       297 *
    ld    C, L          ; 1:4       297 *   1       1x = base 
    ld    A, L          ; 1:4       297 *   256*L = 256x 
    add  HL, HL         ; 1:11      297 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      297 *   1  *2 = 4x
    add  HL, BC         ; 1:11      297 *      +1 = 5x 
    add  HL, HL         ; 1:11      297 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      297 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      297 *   1  *2 = 40x
    add  HL, BC         ; 1:11      297 *      +1 = 41x 
    add   A, H          ; 1:4       297 *
    ld    H, A          ; 1:4       297 *     [297x] = 41x + 256x 

                        ;[13:108]   299 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0010_1011)
    ld    B, H          ; 1:4       299 *
    ld    C, L          ; 1:4       299 *   1       1x = base 
    ld    A, L          ; 1:4       299 *   256*L = 256x 
    add  HL, HL         ; 1:11      299 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      299 *   1  *2 = 4x
    add  HL, BC         ; 1:11      299 *      +1 = 5x 
    add  HL, HL         ; 1:11      299 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      299 *   1  *2 = 20x
    add  HL, BC         ; 1:11      299 *      +1 = 21x 
    add  HL, HL         ; 1:11      299 *   1  *2 = 42x
    add  HL, BC         ; 1:11      299 *      +1 = 43x 
    add   A, H          ; 1:4       299 *
    ld    H, A          ; 1:4       299 *     [299x] = 43x + 256x  
                        ;[13:108]   301 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0010_1101)
    ld    B, H          ; 1:4       301 *
    ld    C, L          ; 1:4       301 *   1       1x = base 
    ld    A, L          ; 1:4       301 *   256*L = 256x 
    add  HL, HL         ; 1:11      301 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      301 *   1  *2 = 4x
    add  HL, BC         ; 1:11      301 *      +1 = 5x 
    add  HL, HL         ; 1:11      301 *   1  *2 = 10x
    add  HL, BC         ; 1:11      301 *      +1 = 11x 
    add  HL, HL         ; 1:11      301 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      301 *   1  *2 = 44x
    add  HL, BC         ; 1:11      301 *      +1 = 45x 
    add   A, H          ; 1:4       301 *
    ld    H, A          ; 1:4       301 *     [301x] = 45x + 256x  
                        ;[14:119]   303 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0010_1111)
    ld    B, H          ; 1:4       303 *
    ld    C, L          ; 1:4       303 *   1       1x = base 
    ld    A, L          ; 1:4       303 *   256*L = 256x 
    add  HL, HL         ; 1:11      303 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      303 *   1  *2 = 4x
    add  HL, BC         ; 1:11      303 *      +1 = 5x 
    add  HL, HL         ; 1:11      303 *   1  *2 = 10x
    add  HL, BC         ; 1:11      303 *      +1 = 11x 
    add  HL, HL         ; 1:11      303 *   1  *2 = 22x
    add  HL, BC         ; 1:11      303 *      +1 = 23x 
    add  HL, HL         ; 1:11      303 *   1  *2 = 46x
    add  HL, BC         ; 1:11      303 *      +1 = 47x 
    add   A, H          ; 1:4       303 *
    ld    H, A          ; 1:4       303 *     [303x] = 47x + 256x  
                        ;[12:97]    305 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0011_0001)
    ld    B, H          ; 1:4       305 *
    ld    C, L          ; 1:4       305 *   1       1x = base 
    ld    A, L          ; 1:4       305 *   256*L = 256x 
    add  HL, HL         ; 1:11      305 *   1  *2 = 2x
    add  HL, BC         ; 1:11      305 *      +1 = 3x 
    add  HL, HL         ; 1:11      305 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      305 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      305 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      305 *   1  *2 = 48x
    add  HL, BC         ; 1:11      305 *      +1 = 49x 
    add   A, H          ; 1:4       305 *
    ld    H, A          ; 1:4       305 *     [305x] = 49x + 256x  
                        ;[13:108]   307 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0011_0011)
    ld    B, H          ; 1:4       307 *
    ld    C, L          ; 1:4       307 *   1       1x = base 
    ld    A, L          ; 1:4       307 *   256*L = 256x 
    add  HL, HL         ; 1:11      307 *   1  *2 = 2x
    add  HL, BC         ; 1:11      307 *      +1 = 3x 
    add  HL, HL         ; 1:11      307 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      307 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      307 *   1  *2 = 24x
    add  HL, BC         ; 1:11      307 *      +1 = 25x 
    add  HL, HL         ; 1:11      307 *   1  *2 = 50x
    add  HL, BC         ; 1:11      307 *      +1 = 51x 
    add   A, H          ; 1:4       307 *
    ld    H, A          ; 1:4       307 *     [307x] = 51x + 256x  
                        ;[13:108]   309 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0011_0101)
    ld    B, H          ; 1:4       309 *
    ld    C, L          ; 1:4       309 *   1       1x = base 
    ld    A, L          ; 1:4       309 *   256*L = 256x 
    add  HL, HL         ; 1:11      309 *   1  *2 = 2x
    add  HL, BC         ; 1:11      309 *      +1 = 3x 
    add  HL, HL         ; 1:11      309 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      309 *   1  *2 = 12x
    add  HL, BC         ; 1:11      309 *      +1 = 13x 
    add  HL, HL         ; 1:11      309 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      309 *   1  *2 = 52x
    add  HL, BC         ; 1:11      309 *      +1 = 53x 
    add   A, H          ; 1:4       309 *
    ld    H, A          ; 1:4       309 *     [309x] = 53x + 256x  
                        ;[14:119]   311 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0011_0111)
    ld    B, H          ; 1:4       311 *
    ld    C, L          ; 1:4       311 *   1       1x = base 
    ld    A, L          ; 1:4       311 *   256*L = 256x 
    add  HL, HL         ; 1:11      311 *   1  *2 = 2x
    add  HL, BC         ; 1:11      311 *      +1 = 3x 
    add  HL, HL         ; 1:11      311 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      311 *   1  *2 = 12x
    add  HL, BC         ; 1:11      311 *      +1 = 13x 
    add  HL, HL         ; 1:11      311 *   1  *2 = 26x
    add  HL, BC         ; 1:11      311 *      +1 = 27x 
    add  HL, HL         ; 1:11      311 *   1  *2 = 54x
    add  HL, BC         ; 1:11      311 *      +1 = 55x 
    add   A, H          ; 1:4       311 *
    ld    H, A          ; 1:4       311 *     [311x] = 55x + 256x  
                        ;[13:108]   313 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0011_1001)
    ld    B, H          ; 1:4       313 *
    ld    C, L          ; 1:4       313 *   1       1x = base 
    ld    A, L          ; 1:4       313 *   256*L = 256x 
    add  HL, HL         ; 1:11      313 *   1  *2 = 2x
    add  HL, BC         ; 1:11      313 *      +1 = 3x 
    add  HL, HL         ; 1:11      313 *   1  *2 = 6x
    add  HL, BC         ; 1:11      313 *      +1 = 7x 
    add  HL, HL         ; 1:11      313 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      313 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      313 *   1  *2 = 56x
    add  HL, BC         ; 1:11      313 *      +1 = 57x 
    add   A, H          ; 1:4       313 *
    ld    H, A          ; 1:4       313 *     [313x] = 57x + 256x  
                        ;[14:119]   315 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0011_1011)
    ld    B, H          ; 1:4       315 *
    ld    C, L          ; 1:4       315 *   1       1x = base 
    ld    A, L          ; 1:4       315 *   256*L = 256x 
    add  HL, HL         ; 1:11      315 *   1  *2 = 2x
    add  HL, BC         ; 1:11      315 *      +1 = 3x 
    add  HL, HL         ; 1:11      315 *   1  *2 = 6x
    add  HL, BC         ; 1:11      315 *      +1 = 7x 
    add  HL, HL         ; 1:11      315 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      315 *   1  *2 = 28x
    add  HL, BC         ; 1:11      315 *      +1 = 29x 
    add  HL, HL         ; 1:11      315 *   1  *2 = 58x
    add  HL, BC         ; 1:11      315 *      +1 = 59x 
    add   A, H          ; 1:4       315 *
    ld    H, A          ; 1:4       315 *     [315x] = 59x + 256x  
                        ;[14:119]   317 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0011_1101)
    ld    B, H          ; 1:4       317 *
    ld    C, L          ; 1:4       317 *   1       1x = base 
    ld    A, L          ; 1:4       317 *   256*L = 256x 
    add  HL, HL         ; 1:11      317 *   1  *2 = 2x
    add  HL, BC         ; 1:11      317 *      +1 = 3x 
    add  HL, HL         ; 1:11      317 *   1  *2 = 6x
    add  HL, BC         ; 1:11      317 *      +1 = 7x 
    add  HL, HL         ; 1:11      317 *   1  *2 = 14x
    add  HL, BC         ; 1:11      317 *      +1 = 15x 
    add  HL, HL         ; 1:11      317 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      317 *   1  *2 = 60x
    add  HL, BC         ; 1:11      317 *      +1 = 61x 
    add   A, H          ; 1:4       317 *
    ld    H, A          ; 1:4       317 *     [317x] = 61x + 256x  
                        ;[15:130]   319 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0011_1111)
    ld    B, H          ; 1:4       319 *
    ld    C, L          ; 1:4       319 *   1       1x = base 
    ld    A, L          ; 1:4       319 *   256*L = 256x 
    add  HL, HL         ; 1:11      319 *   1  *2 = 2x
    add  HL, BC         ; 1:11      319 *      +1 = 3x 
    add  HL, HL         ; 1:11      319 *   1  *2 = 6x
    add  HL, BC         ; 1:11      319 *      +1 = 7x 
    add  HL, HL         ; 1:11      319 *   1  *2 = 14x
    add  HL, BC         ; 1:11      319 *      +1 = 15x 
    add  HL, HL         ; 1:11      319 *   1  *2 = 30x
    add  HL, BC         ; 1:11      319 *      +1 = 31x 
    add  HL, HL         ; 1:11      319 *   1  *2 = 62x
    add  HL, BC         ; 1:11      319 *      +1 = 63x 
    add   A, H          ; 1:4       319 *
    ld    H, A          ; 1:4       319 *     [319x] = 63x + 256x 

                        ;[12:97]    321 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0001_0100_0001)  
    ld    A, L          ; 1:4       321 *   256x 
    ld    B, H          ; 1:4       321 *
    ld    C, L          ; 1:4       321 *   [1x] 
    add  HL, HL         ; 1:11      321 *   2x 
    add  HL, HL         ; 1:11      321 *   4x 
    add  HL, HL         ; 1:11      321 *   8x 
    add  HL, HL         ; 1:11      321 *   16x 
    add  HL, HL         ; 1:11      321 *   32x 
    add  HL, HL         ; 1:11      321 *   64x 
    add   A, B          ; 1:4       321 *
    ld    B, A          ; 1:4       321 *   [257x] 
    add  HL, BC         ; 1:11      321 *   [321x] = 64x + 257x   
                        ;[13:108]   323 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0100_0011)
    ld    B, H          ; 1:4       323 *
    ld    C, L          ; 1:4       323 *   1       1x = base 
    ld    A, L          ; 1:4       323 *   256*L = 256x 
    add  HL, HL         ; 1:11      323 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      323 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      323 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      323 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      323 *   1  *2 = 32x
    add  HL, BC         ; 1:11      323 *      +1 = 33x 
    add  HL, HL         ; 1:11      323 *   1  *2 = 66x
    add  HL, BC         ; 1:11      323 *      +1 = 67x 
    add   A, H          ; 1:4       323 *
    ld    H, A          ; 1:4       323 *     [323x] = 67x + 256x  
                        ;[13:108]   325 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0100_0101)
    ld    B, H          ; 1:4       325 *
    ld    C, L          ; 1:4       325 *   1       1x = base 
    ld    A, L          ; 1:4       325 *   256*L = 256x 
    add  HL, HL         ; 1:11      325 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      325 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      325 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      325 *   1  *2 = 16x
    add  HL, BC         ; 1:11      325 *      +1 = 17x 
    add  HL, HL         ; 1:11      325 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      325 *   1  *2 = 68x
    add  HL, BC         ; 1:11      325 *      +1 = 69x 
    add   A, H          ; 1:4       325 *
    ld    H, A          ; 1:4       325 *     [325x] = 69x + 256x  
                        ;[14:119]   327 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0100_0111)
    ld    B, H          ; 1:4       327 *
    ld    C, L          ; 1:4       327 *   1       1x = base 
    ld    A, L          ; 1:4       327 *   256*L = 256x 
    add  HL, HL         ; 1:11      327 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      327 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      327 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      327 *   1  *2 = 16x
    add  HL, BC         ; 1:11      327 *      +1 = 17x 
    add  HL, HL         ; 1:11      327 *   1  *2 = 34x
    add  HL, BC         ; 1:11      327 *      +1 = 35x 
    add  HL, HL         ; 1:11      327 *   1  *2 = 70x
    add  HL, BC         ; 1:11      327 *      +1 = 71x 
    add   A, H          ; 1:4       327 *
    ld    H, A          ; 1:4       327 *     [327x] = 71x + 256x  
                        ;[13:108]   329 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0100_1001)
    ld    B, H          ; 1:4       329 *
    ld    C, L          ; 1:4       329 *   1       1x = base 
    ld    A, L          ; 1:4       329 *   256*L = 256x 
    add  HL, HL         ; 1:11      329 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      329 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      329 *   1  *2 = 8x
    add  HL, BC         ; 1:11      329 *      +1 = 9x 
    add  HL, HL         ; 1:11      329 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      329 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      329 *   1  *2 = 72x
    add  HL, BC         ; 1:11      329 *      +1 = 73x 
    add   A, H          ; 1:4       329 *
    ld    H, A          ; 1:4       329 *     [329x] = 73x + 256x  
                        ;[14:119]   331 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0100_1011)
    ld    B, H          ; 1:4       331 *
    ld    C, L          ; 1:4       331 *   1       1x = base 
    ld    A, L          ; 1:4       331 *   256*L = 256x 
    add  HL, HL         ; 1:11      331 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      331 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      331 *   1  *2 = 8x
    add  HL, BC         ; 1:11      331 *      +1 = 9x 
    add  HL, HL         ; 1:11      331 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      331 *   1  *2 = 36x
    add  HL, BC         ; 1:11      331 *      +1 = 37x 
    add  HL, HL         ; 1:11      331 *   1  *2 = 74x
    add  HL, BC         ; 1:11      331 *      +1 = 75x 
    add   A, H          ; 1:4       331 *
    ld    H, A          ; 1:4       331 *     [331x] = 75x + 256x  
                        ;[14:119]   333 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0100_1101)
    ld    B, H          ; 1:4       333 *
    ld    C, L          ; 1:4       333 *   1       1x = base 
    ld    A, L          ; 1:4       333 *   256*L = 256x 
    add  HL, HL         ; 1:11      333 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      333 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      333 *   1  *2 = 8x
    add  HL, BC         ; 1:11      333 *      +1 = 9x 
    add  HL, HL         ; 1:11      333 *   1  *2 = 18x
    add  HL, BC         ; 1:11      333 *      +1 = 19x 
    add  HL, HL         ; 1:11      333 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      333 *   1  *2 = 76x
    add  HL, BC         ; 1:11      333 *      +1 = 77x 
    add   A, H          ; 1:4       333 *
    ld    H, A          ; 1:4       333 *     [333x] = 77x + 256x  
                        ;[15:130]   335 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0100_1111)
    ld    B, H          ; 1:4       335 *
    ld    C, L          ; 1:4       335 *   1       1x = base 
    ld    A, L          ; 1:4       335 *   256*L = 256x 
    add  HL, HL         ; 1:11      335 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      335 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      335 *   1  *2 = 8x
    add  HL, BC         ; 1:11      335 *      +1 = 9x 
    add  HL, HL         ; 1:11      335 *   1  *2 = 18x
    add  HL, BC         ; 1:11      335 *      +1 = 19x 
    add  HL, HL         ; 1:11      335 *   1  *2 = 38x
    add  HL, BC         ; 1:11      335 *      +1 = 39x 
    add  HL, HL         ; 1:11      335 *   1  *2 = 78x
    add  HL, BC         ; 1:11      335 *      +1 = 79x 
    add   A, H          ; 1:4       335 *
    ld    H, A          ; 1:4       335 *     [335x] = 79x + 256x  
                        ;[13:108]   337 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0101_0001)
    ld    B, H          ; 1:4       337 *
    ld    C, L          ; 1:4       337 *   1       1x = base 
    ld    A, L          ; 1:4       337 *   256*L = 256x 
    add  HL, HL         ; 1:11      337 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      337 *   1  *2 = 4x
    add  HL, BC         ; 1:11      337 *      +1 = 5x 
    add  HL, HL         ; 1:11      337 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      337 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      337 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      337 *   1  *2 = 80x
    add  HL, BC         ; 1:11      337 *      +1 = 81x 
    add   A, H          ; 1:4       337 *
    ld    H, A          ; 1:4       337 *     [337x] = 81x + 256x  
                        ;[14:119]   339 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0101_0011)
    ld    B, H          ; 1:4       339 *
    ld    C, L          ; 1:4       339 *   1       1x = base 
    ld    A, L          ; 1:4       339 *   256*L = 256x 
    add  HL, HL         ; 1:11      339 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      339 *   1  *2 = 4x
    add  HL, BC         ; 1:11      339 *      +1 = 5x 
    add  HL, HL         ; 1:11      339 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      339 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      339 *   1  *2 = 40x
    add  HL, BC         ; 1:11      339 *      +1 = 41x 
    add  HL, HL         ; 1:11      339 *   1  *2 = 82x
    add  HL, BC         ; 1:11      339 *      +1 = 83x 
    add   A, H          ; 1:4       339 *
    ld    H, A          ; 1:4       339 *     [339x] = 83x + 256x  
                        ;[14:119]   341 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0101_0101)
    ld    B, H          ; 1:4       341 *
    ld    C, L          ; 1:4       341 *   1       1x = base 
    ld    A, L          ; 1:4       341 *   256*L = 256x 
    add  HL, HL         ; 1:11      341 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      341 *   1  *2 = 4x
    add  HL, BC         ; 1:11      341 *      +1 = 5x 
    add  HL, HL         ; 1:11      341 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      341 *   1  *2 = 20x
    add  HL, BC         ; 1:11      341 *      +1 = 21x 
    add  HL, HL         ; 1:11      341 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      341 *   1  *2 = 84x
    add  HL, BC         ; 1:11      341 *      +1 = 85x 
    add   A, H          ; 1:4       341 *
    ld    H, A          ; 1:4       341 *     [341x] = 85x + 256x 

                        ;[15:130]   343 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0101_0111)
    ld    B, H          ; 1:4       343 *
    ld    C, L          ; 1:4       343 *   1       1x = base 
    ld    A, L          ; 1:4       343 *   256*L = 256x 
    add  HL, HL         ; 1:11      343 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      343 *   1  *2 = 4x
    add  HL, BC         ; 1:11      343 *      +1 = 5x 
    add  HL, HL         ; 1:11      343 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      343 *   1  *2 = 20x
    add  HL, BC         ; 1:11      343 *      +1 = 21x 
    add  HL, HL         ; 1:11      343 *   1  *2 = 42x
    add  HL, BC         ; 1:11      343 *      +1 = 43x 
    add  HL, HL         ; 1:11      343 *   1  *2 = 86x
    add  HL, BC         ; 1:11      343 *      +1 = 87x 
    add   A, H          ; 1:4       343 *
    ld    H, A          ; 1:4       343 *     [343x] = 87x + 256x  
                        ;[14:119]   345 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0101_1001)
    ld    B, H          ; 1:4       345 *
    ld    C, L          ; 1:4       345 *   1       1x = base 
    ld    A, L          ; 1:4       345 *   256*L = 256x 
    add  HL, HL         ; 1:11      345 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      345 *   1  *2 = 4x
    add  HL, BC         ; 1:11      345 *      +1 = 5x 
    add  HL, HL         ; 1:11      345 *   1  *2 = 10x
    add  HL, BC         ; 1:11      345 *      +1 = 11x 
    add  HL, HL         ; 1:11      345 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      345 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      345 *   1  *2 = 88x
    add  HL, BC         ; 1:11      345 *      +1 = 89x 
    add   A, H          ; 1:4       345 *
    ld    H, A          ; 1:4       345 *     [345x] = 89x + 256x  
                        ;[15:130]   347 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0101_1011)
    ld    B, H          ; 1:4       347 *
    ld    C, L          ; 1:4       347 *   1       1x = base 
    ld    A, L          ; 1:4       347 *   256*L = 256x 
    add  HL, HL         ; 1:11      347 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      347 *   1  *2 = 4x
    add  HL, BC         ; 1:11      347 *      +1 = 5x 
    add  HL, HL         ; 1:11      347 *   1  *2 = 10x
    add  HL, BC         ; 1:11      347 *      +1 = 11x 
    add  HL, HL         ; 1:11      347 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      347 *   1  *2 = 44x
    add  HL, BC         ; 1:11      347 *      +1 = 45x 
    add  HL, HL         ; 1:11      347 *   1  *2 = 90x
    add  HL, BC         ; 1:11      347 *      +1 = 91x 
    add   A, H          ; 1:4       347 *
    ld    H, A          ; 1:4       347 *     [347x] = 91x + 256x  
                        ;[15:130]   349 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0101_1101)
    ld    B, H          ; 1:4       349 *
    ld    C, L          ; 1:4       349 *   1       1x = base 
    ld    A, L          ; 1:4       349 *   256*L = 256x 
    add  HL, HL         ; 1:11      349 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      349 *   1  *2 = 4x
    add  HL, BC         ; 1:11      349 *      +1 = 5x 
    add  HL, HL         ; 1:11      349 *   1  *2 = 10x
    add  HL, BC         ; 1:11      349 *      +1 = 11x 
    add  HL, HL         ; 1:11      349 *   1  *2 = 22x
    add  HL, BC         ; 1:11      349 *      +1 = 23x 
    add  HL, HL         ; 1:11      349 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      349 *   1  *2 = 92x
    add  HL, BC         ; 1:11      349 *      +1 = 93x 
    add   A, H          ; 1:4       349 *
    ld    H, A          ; 1:4       349 *     [349x] = 93x + 256x  
                        ;[16:141]   351 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0101_1111)
    ld    B, H          ; 1:4       351 *
    ld    C, L          ; 1:4       351 *   1       1x = base 
    ld    A, L          ; 1:4       351 *   256*L = 256x 
    add  HL, HL         ; 1:11      351 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      351 *   1  *2 = 4x
    add  HL, BC         ; 1:11      351 *      +1 = 5x 
    add  HL, HL         ; 1:11      351 *   1  *2 = 10x
    add  HL, BC         ; 1:11      351 *      +1 = 11x 
    add  HL, HL         ; 1:11      351 *   1  *2 = 22x
    add  HL, BC         ; 1:11      351 *      +1 = 23x 
    add  HL, HL         ; 1:11      351 *   1  *2 = 46x
    add  HL, BC         ; 1:11      351 *      +1 = 47x 
    add  HL, HL         ; 1:11      351 *   1  *2 = 94x
    add  HL, BC         ; 1:11      351 *      +1 = 95x 
    add   A, H          ; 1:4       351 *
    ld    H, A          ; 1:4       351 *     [351x] = 95x + 256x  
                        ;[13:108]   353 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0110_0001)
    ld    B, H          ; 1:4       353 *
    ld    C, L          ; 1:4       353 *   1       1x = base 
    ld    A, L          ; 1:4       353 *   256*L = 256x 
    add  HL, HL         ; 1:11      353 *   1  *2 = 2x
    add  HL, BC         ; 1:11      353 *      +1 = 3x 
    add  HL, HL         ; 1:11      353 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      353 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      353 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      353 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      353 *   1  *2 = 96x
    add  HL, BC         ; 1:11      353 *      +1 = 97x 
    add   A, H          ; 1:4       353 *
    ld    H, A          ; 1:4       353 *     [353x] = 97x + 256x  
                        ;[14:119]   355 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0110_0011)
    ld    B, H          ; 1:4       355 *
    ld    C, L          ; 1:4       355 *   1       1x = base 
    ld    A, L          ; 1:4       355 *   256*L = 256x 
    add  HL, HL         ; 1:11      355 *   1  *2 = 2x
    add  HL, BC         ; 1:11      355 *      +1 = 3x 
    add  HL, HL         ; 1:11      355 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      355 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      355 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      355 *   1  *2 = 48x
    add  HL, BC         ; 1:11      355 *      +1 = 49x 
    add  HL, HL         ; 1:11      355 *   1  *2 = 98x
    add  HL, BC         ; 1:11      355 *      +1 = 99x 
    add   A, H          ; 1:4       355 *
    ld    H, A          ; 1:4       355 *     [355x] = 99x + 256x  
                        ;[14:119]   357 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0110_0101)
    ld    B, H          ; 1:4       357 *
    ld    C, L          ; 1:4       357 *   1       1x = base 
    ld    A, L          ; 1:4       357 *   256*L = 256x 
    add  HL, HL         ; 1:11      357 *   1  *2 = 2x
    add  HL, BC         ; 1:11      357 *      +1 = 3x 
    add  HL, HL         ; 1:11      357 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      357 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      357 *   1  *2 = 24x
    add  HL, BC         ; 1:11      357 *      +1 = 25x 
    add  HL, HL         ; 1:11      357 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      357 *   1  *2 = 100x
    add  HL, BC         ; 1:11      357 *      +1 = 101x 
    add   A, H          ; 1:4       357 *
    ld    H, A          ; 1:4       357 *     [357x] = 101x + 256x  
                        ;[15:130]   359 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0110_0111)
    ld    B, H          ; 1:4       359 *
    ld    C, L          ; 1:4       359 *   1       1x = base 
    ld    A, L          ; 1:4       359 *   256*L = 256x 
    add  HL, HL         ; 1:11      359 *   1  *2 = 2x
    add  HL, BC         ; 1:11      359 *      +1 = 3x 
    add  HL, HL         ; 1:11      359 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      359 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      359 *   1  *2 = 24x
    add  HL, BC         ; 1:11      359 *      +1 = 25x 
    add  HL, HL         ; 1:11      359 *   1  *2 = 50x
    add  HL, BC         ; 1:11      359 *      +1 = 51x 
    add  HL, HL         ; 1:11      359 *   1  *2 = 102x
    add  HL, BC         ; 1:11      359 *      +1 = 103x 
    add   A, H          ; 1:4       359 *
    ld    H, A          ; 1:4       359 *     [359x] = 103x + 256x  
                        ;[14:119]   361 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0110_1001)
    ld    B, H          ; 1:4       361 *
    ld    C, L          ; 1:4       361 *   1       1x = base 
    ld    A, L          ; 1:4       361 *   256*L = 256x 
    add  HL, HL         ; 1:11      361 *   1  *2 = 2x
    add  HL, BC         ; 1:11      361 *      +1 = 3x 
    add  HL, HL         ; 1:11      361 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      361 *   1  *2 = 12x
    add  HL, BC         ; 1:11      361 *      +1 = 13x 
    add  HL, HL         ; 1:11      361 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      361 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      361 *   1  *2 = 104x
    add  HL, BC         ; 1:11      361 *      +1 = 105x 
    add   A, H          ; 1:4       361 *
    ld    H, A          ; 1:4       361 *     [361x] = 105x + 256x  
                        ;[15:130]   363 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0110_1011)
    ld    B, H          ; 1:4       363 *
    ld    C, L          ; 1:4       363 *   1       1x = base 
    ld    A, L          ; 1:4       363 *   256*L = 256x 
    add  HL, HL         ; 1:11      363 *   1  *2 = 2x
    add  HL, BC         ; 1:11      363 *      +1 = 3x 
    add  HL, HL         ; 1:11      363 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      363 *   1  *2 = 12x
    add  HL, BC         ; 1:11      363 *      +1 = 13x 
    add  HL, HL         ; 1:11      363 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      363 *   1  *2 = 52x
    add  HL, BC         ; 1:11      363 *      +1 = 53x 
    add  HL, HL         ; 1:11      363 *   1  *2 = 106x
    add  HL, BC         ; 1:11      363 *      +1 = 107x 
    add   A, H          ; 1:4       363 *
    ld    H, A          ; 1:4       363 *     [363x] = 107x + 256x 

                        ;[15:130]   365 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0110_1101)
    ld    B, H          ; 1:4       365 *
    ld    C, L          ; 1:4       365 *   1       1x = base 
    ld    A, L          ; 1:4       365 *   256*L = 256x 
    add  HL, HL         ; 1:11      365 *   1  *2 = 2x
    add  HL, BC         ; 1:11      365 *      +1 = 3x 
    add  HL, HL         ; 1:11      365 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      365 *   1  *2 = 12x
    add  HL, BC         ; 1:11      365 *      +1 = 13x 
    add  HL, HL         ; 1:11      365 *   1  *2 = 26x
    add  HL, BC         ; 1:11      365 *      +1 = 27x 
    add  HL, HL         ; 1:11      365 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      365 *   1  *2 = 108x
    add  HL, BC         ; 1:11      365 *      +1 = 109x 
    add   A, H          ; 1:4       365 *
    ld    H, A          ; 1:4       365 *     [365x] = 109x + 256x  
                        ;[16:141]   367 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0110_1111)
    ld    B, H          ; 1:4       367 *
    ld    C, L          ; 1:4       367 *   1       1x = base 
    ld    A, L          ; 1:4       367 *   256*L = 256x 
    add  HL, HL         ; 1:11      367 *   1  *2 = 2x
    add  HL, BC         ; 1:11      367 *      +1 = 3x 
    add  HL, HL         ; 1:11      367 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      367 *   1  *2 = 12x
    add  HL, BC         ; 1:11      367 *      +1 = 13x 
    add  HL, HL         ; 1:11      367 *   1  *2 = 26x
    add  HL, BC         ; 1:11      367 *      +1 = 27x 
    add  HL, HL         ; 1:11      367 *   1  *2 = 54x
    add  HL, BC         ; 1:11      367 *      +1 = 55x 
    add  HL, HL         ; 1:11      367 *   1  *2 = 110x
    add  HL, BC         ; 1:11      367 *      +1 = 111x 
    add   A, H          ; 1:4       367 *
    ld    H, A          ; 1:4       367 *     [367x] = 111x + 256x  
                        ;[14:119]   369 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0111_0001)
    ld    B, H          ; 1:4       369 *
    ld    C, L          ; 1:4       369 *   1       1x = base 
    ld    A, L          ; 1:4       369 *   256*L = 256x 
    add  HL, HL         ; 1:11      369 *   1  *2 = 2x
    add  HL, BC         ; 1:11      369 *      +1 = 3x 
    add  HL, HL         ; 1:11      369 *   1  *2 = 6x
    add  HL, BC         ; 1:11      369 *      +1 = 7x 
    add  HL, HL         ; 1:11      369 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      369 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      369 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      369 *   1  *2 = 112x
    add  HL, BC         ; 1:11      369 *      +1 = 113x 
    add   A, H          ; 1:4       369 *
    ld    H, A          ; 1:4       369 *     [369x] = 113x + 256x  
                        ;[15:130]   371 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0111_0011)
    ld    B, H          ; 1:4       371 *
    ld    C, L          ; 1:4       371 *   1       1x = base 
    ld    A, L          ; 1:4       371 *   256*L = 256x 
    add  HL, HL         ; 1:11      371 *   1  *2 = 2x
    add  HL, BC         ; 1:11      371 *      +1 = 3x 
    add  HL, HL         ; 1:11      371 *   1  *2 = 6x
    add  HL, BC         ; 1:11      371 *      +1 = 7x 
    add  HL, HL         ; 1:11      371 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      371 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      371 *   1  *2 = 56x
    add  HL, BC         ; 1:11      371 *      +1 = 57x 
    add  HL, HL         ; 1:11      371 *   1  *2 = 114x
    add  HL, BC         ; 1:11      371 *      +1 = 115x 
    add   A, H          ; 1:4       371 *
    ld    H, A          ; 1:4       371 *     [371x] = 115x + 256x  
                        ;[15:130]   373 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0111_0101)
    ld    B, H          ; 1:4       373 *
    ld    C, L          ; 1:4       373 *   1       1x = base 
    ld    A, L          ; 1:4       373 *   256*L = 256x 
    add  HL, HL         ; 1:11      373 *   1  *2 = 2x
    add  HL, BC         ; 1:11      373 *      +1 = 3x 
    add  HL, HL         ; 1:11      373 *   1  *2 = 6x
    add  HL, BC         ; 1:11      373 *      +1 = 7x 
    add  HL, HL         ; 1:11      373 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      373 *   1  *2 = 28x
    add  HL, BC         ; 1:11      373 *      +1 = 29x 
    add  HL, HL         ; 1:11      373 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      373 *   1  *2 = 116x
    add  HL, BC         ; 1:11      373 *      +1 = 117x 
    add   A, H          ; 1:4       373 *
    ld    H, A          ; 1:4       373 *     [373x] = 117x + 256x  
                        ;[16:141]   375 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0111_0111)
    ld    B, H          ; 1:4       375 *
    ld    C, L          ; 1:4       375 *   1       1x = base 
    ld    A, L          ; 1:4       375 *   256*L = 256x 
    add  HL, HL         ; 1:11      375 *   1  *2 = 2x
    add  HL, BC         ; 1:11      375 *      +1 = 3x 
    add  HL, HL         ; 1:11      375 *   1  *2 = 6x
    add  HL, BC         ; 1:11      375 *      +1 = 7x 
    add  HL, HL         ; 1:11      375 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      375 *   1  *2 = 28x
    add  HL, BC         ; 1:11      375 *      +1 = 29x 
    add  HL, HL         ; 1:11      375 *   1  *2 = 58x
    add  HL, BC         ; 1:11      375 *      +1 = 59x 
    add  HL, HL         ; 1:11      375 *   1  *2 = 118x
    add  HL, BC         ; 1:11      375 *      +1 = 119x 
    add   A, H          ; 1:4       375 *
    ld    H, A          ; 1:4       375 *     [375x] = 119x + 256x  
                        ;[15:130]   377 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0111_1001)
    ld    B, H          ; 1:4       377 *
    ld    C, L          ; 1:4       377 *   1       1x = base 
    ld    A, L          ; 1:4       377 *   256*L = 256x 
    add  HL, HL         ; 1:11      377 *   1  *2 = 2x
    add  HL, BC         ; 1:11      377 *      +1 = 3x 
    add  HL, HL         ; 1:11      377 *   1  *2 = 6x
    add  HL, BC         ; 1:11      377 *      +1 = 7x 
    add  HL, HL         ; 1:11      377 *   1  *2 = 14x
    add  HL, BC         ; 1:11      377 *      +1 = 15x 
    add  HL, HL         ; 1:11      377 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      377 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      377 *   1  *2 = 120x
    add  HL, BC         ; 1:11      377 *      +1 = 121x 
    add   A, H          ; 1:4       377 *
    ld    H, A          ; 1:4       377 *     [377x] = 121x + 256x  
                        ;[16:141]   379 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0111_1011)
    ld    B, H          ; 1:4       379 *
    ld    C, L          ; 1:4       379 *   1       1x = base 
    ld    A, L          ; 1:4       379 *   256*L = 256x 
    add  HL, HL         ; 1:11      379 *   1  *2 = 2x
    add  HL, BC         ; 1:11      379 *      +1 = 3x 
    add  HL, HL         ; 1:11      379 *   1  *2 = 6x
    add  HL, BC         ; 1:11      379 *      +1 = 7x 
    add  HL, HL         ; 1:11      379 *   1  *2 = 14x
    add  HL, BC         ; 1:11      379 *      +1 = 15x 
    add  HL, HL         ; 1:11      379 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      379 *   1  *2 = 60x
    add  HL, BC         ; 1:11      379 *      +1 = 61x 
    add  HL, HL         ; 1:11      379 *   1  *2 = 122x
    add  HL, BC         ; 1:11      379 *      +1 = 123x 
    add   A, H          ; 1:4       379 *
    ld    H, A          ; 1:4       379 *     [379x] = 123x + 256x  
                        ;[16:141]   381 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0111_1101)
    ld    B, H          ; 1:4       381 *
    ld    C, L          ; 1:4       381 *   1       1x = base 
    ld    A, L          ; 1:4       381 *   256*L = 256x 
    add  HL, HL         ; 1:11      381 *   1  *2 = 2x
    add  HL, BC         ; 1:11      381 *      +1 = 3x 
    add  HL, HL         ; 1:11      381 *   1  *2 = 6x
    add  HL, BC         ; 1:11      381 *      +1 = 7x 
    add  HL, HL         ; 1:11      381 *   1  *2 = 14x
    add  HL, BC         ; 1:11      381 *      +1 = 15x 
    add  HL, HL         ; 1:11      381 *   1  *2 = 30x
    add  HL, BC         ; 1:11      381 *      +1 = 31x 
    add  HL, HL         ; 1:11      381 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      381 *   1  *2 = 124x
    add  HL, BC         ; 1:11      381 *      +1 = 125x 
    add   A, H          ; 1:4       381 *
    ld    H, A          ; 1:4       381 *     [381x] = 125x + 256x  
                        ;[17:152]   383 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0001_0111_1111)
    ld    B, H          ; 1:4       383 *
    ld    C, L          ; 1:4       383 *   1       1x = base 
    ld    A, L          ; 1:4       383 *   256*L = 256x 
    add  HL, HL         ; 1:11      383 *   1  *2 = 2x
    add  HL, BC         ; 1:11      383 *      +1 = 3x 
    add  HL, HL         ; 1:11      383 *   1  *2 = 6x
    add  HL, BC         ; 1:11      383 *      +1 = 7x 
    add  HL, HL         ; 1:11      383 *   1  *2 = 14x
    add  HL, BC         ; 1:11      383 *      +1 = 15x 
    add  HL, HL         ; 1:11      383 *   1  *2 = 30x
    add  HL, BC         ; 1:11      383 *      +1 = 31x 
    add  HL, HL         ; 1:11      383 *   1  *2 = 62x
    add  HL, BC         ; 1:11      383 *      +1 = 63x 
    add  HL, HL         ; 1:11      383 *   1  *2 = 126x
    add  HL, BC         ; 1:11      383 *      +1 = 127x 
    add   A, H          ; 1:4       383 *
    ld    H, A          ; 1:4       383 *     [383x] = 127x + 256x  
                        ;[12:118]   385 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1000_0001)
    ld    B, H          ; 1:4       385 *
    ld    C, L          ; 1:4       385 *   1       1x = base 
    add  HL, HL         ; 1:11      385 *   1  *2 = 2x
    add  HL, BC         ; 1:11      385 *      +1 = 3x 
    add  HL, HL         ; 1:11      385 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      385 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      385 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      385 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      385 *   0  *2 = 96x 
    add  HL, HL         ; 1:11      385 *   0  *2 = 192x 
    add  HL, HL         ; 1:11      385 *   1  *2 = 384x
    add  HL, BC         ; 1:11      385 *      +1 = 385x  

                        ;[13:129]   387 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1000_0011)
    ld    B, H          ; 1:4       387 *
    ld    C, L          ; 1:4       387 *   1       1x = base 
    add  HL, HL         ; 1:11      387 *   1  *2 = 2x
    add  HL, BC         ; 1:11      387 *      +1 = 3x 
    add  HL, HL         ; 1:11      387 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      387 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      387 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      387 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      387 *   0  *2 = 96x 
    add  HL, HL         ; 1:11      387 *   1  *2 = 192x
    add  HL, BC         ; 1:11      387 *      +1 = 193x 
    add  HL, HL         ; 1:11      387 *   1  *2 = 386x
    add  HL, BC         ; 1:11      387 *      +1 = 387x   
                        ;[13:129]   389 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1000_0101)
    ld    B, H          ; 1:4       389 *
    ld    C, L          ; 1:4       389 *   1       1x = base 
    add  HL, HL         ; 1:11      389 *   1  *2 = 2x
    add  HL, BC         ; 1:11      389 *      +1 = 3x 
    add  HL, HL         ; 1:11      389 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      389 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      389 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      389 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      389 *   1  *2 = 96x
    add  HL, BC         ; 1:11      389 *      +1 = 97x 
    add  HL, HL         ; 1:11      389 *   0  *2 = 194x 
    add  HL, HL         ; 1:11      389 *   1  *2 = 388x
    add  HL, BC         ; 1:11      389 *      +1 = 389x   
                        ;[14:140]   391 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1000_0111)
    ld    B, H          ; 1:4       391 *
    ld    C, L          ; 1:4       391 *   1       1x = base 
    add  HL, HL         ; 1:11      391 *   1  *2 = 2x
    add  HL, BC         ; 1:11      391 *      +1 = 3x 
    add  HL, HL         ; 1:11      391 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      391 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      391 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      391 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      391 *   1  *2 = 96x
    add  HL, BC         ; 1:11      391 *      +1 = 97x 
    add  HL, HL         ; 1:11      391 *   1  *2 = 194x
    add  HL, BC         ; 1:11      391 *      +1 = 195x 
    add  HL, HL         ; 1:11      391 *   1  *2 = 390x
    add  HL, BC         ; 1:11      391 *      +1 = 391x   
                        ;[13:129]   393 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1000_1001)
    ld    B, H          ; 1:4       393 *
    ld    C, L          ; 1:4       393 *   1       1x = base 
    add  HL, HL         ; 1:11      393 *   1  *2 = 2x
    add  HL, BC         ; 1:11      393 *      +1 = 3x 
    add  HL, HL         ; 1:11      393 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      393 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      393 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      393 *   1  *2 = 48x
    add  HL, BC         ; 1:11      393 *      +1 = 49x 
    add  HL, HL         ; 1:11      393 *   0  *2 = 98x 
    add  HL, HL         ; 1:11      393 *   0  *2 = 196x 
    add  HL, HL         ; 1:11      393 *   1  *2 = 392x
    add  HL, BC         ; 1:11      393 *      +1 = 393x   
                        ;[14:140]   395 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1000_1011)
    ld    B, H          ; 1:4       395 *
    ld    C, L          ; 1:4       395 *   1       1x = base 
    add  HL, HL         ; 1:11      395 *   1  *2 = 2x
    add  HL, BC         ; 1:11      395 *      +1 = 3x 
    add  HL, HL         ; 1:11      395 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      395 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      395 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      395 *   1  *2 = 48x
    add  HL, BC         ; 1:11      395 *      +1 = 49x 
    add  HL, HL         ; 1:11      395 *   0  *2 = 98x 
    add  HL, HL         ; 1:11      395 *   1  *2 = 196x
    add  HL, BC         ; 1:11      395 *      +1 = 197x 
    add  HL, HL         ; 1:11      395 *   1  *2 = 394x
    add  HL, BC         ; 1:11      395 *      +1 = 395x   
                        ;[14:140]   397 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1000_1101)
    ld    B, H          ; 1:4       397 *
    ld    C, L          ; 1:4       397 *   1       1x = base 
    add  HL, HL         ; 1:11      397 *   1  *2 = 2x
    add  HL, BC         ; 1:11      397 *      +1 = 3x 
    add  HL, HL         ; 1:11      397 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      397 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      397 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      397 *   1  *2 = 48x
    add  HL, BC         ; 1:11      397 *      +1 = 49x 
    add  HL, HL         ; 1:11      397 *   1  *2 = 98x
    add  HL, BC         ; 1:11      397 *      +1 = 99x 
    add  HL, HL         ; 1:11      397 *   0  *2 = 198x 
    add  HL, HL         ; 1:11      397 *   1  *2 = 396x
    add  HL, BC         ; 1:11      397 *      +1 = 397x   
                        ;[15:151]   399 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1000_1111)
    ld    B, H          ; 1:4       399 *
    ld    C, L          ; 1:4       399 *   1       1x = base 
    add  HL, HL         ; 1:11      399 *   1  *2 = 2x
    add  HL, BC         ; 1:11      399 *      +1 = 3x 
    add  HL, HL         ; 1:11      399 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      399 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      399 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      399 *   1  *2 = 48x
    add  HL, BC         ; 1:11      399 *      +1 = 49x 
    add  HL, HL         ; 1:11      399 *   1  *2 = 98x
    add  HL, BC         ; 1:11      399 *      +1 = 99x 
    add  HL, HL         ; 1:11      399 *   1  *2 = 198x
    add  HL, BC         ; 1:11      399 *      +1 = 199x 
    add  HL, HL         ; 1:11      399 *   1  *2 = 398x
    add  HL, BC         ; 1:11      399 *      +1 = 399x   
                        ;[13:129]   401 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001_0001)
    ld    B, H          ; 1:4       401 *
    ld    C, L          ; 1:4       401 *   1       1x = base 
    add  HL, HL         ; 1:11      401 *   1  *2 = 2x
    add  HL, BC         ; 1:11      401 *      +1 = 3x 
    add  HL, HL         ; 1:11      401 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      401 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      401 *   1  *2 = 24x
    add  HL, BC         ; 1:11      401 *      +1 = 25x 
    add  HL, HL         ; 1:11      401 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      401 *   0  *2 = 100x 
    add  HL, HL         ; 1:11      401 *   0  *2 = 200x 
    add  HL, HL         ; 1:11      401 *   1  *2 = 400x
    add  HL, BC         ; 1:11      401 *      +1 = 401x   
                        ;[14:140]   403 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001_0011)
    ld    B, H          ; 1:4       403 *
    ld    C, L          ; 1:4       403 *   1       1x = base 
    add  HL, HL         ; 1:11      403 *   1  *2 = 2x
    add  HL, BC         ; 1:11      403 *      +1 = 3x 
    add  HL, HL         ; 1:11      403 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      403 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      403 *   1  *2 = 24x
    add  HL, BC         ; 1:11      403 *      +1 = 25x 
    add  HL, HL         ; 1:11      403 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      403 *   0  *2 = 100x 
    add  HL, HL         ; 1:11      403 *   1  *2 = 200x
    add  HL, BC         ; 1:11      403 *      +1 = 201x 
    add  HL, HL         ; 1:11      403 *   1  *2 = 402x
    add  HL, BC         ; 1:11      403 *      +1 = 403x   
                        ;[14:140]   405 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001_0101)
    ld    B, H          ; 1:4       405 *
    ld    C, L          ; 1:4       405 *   1       1x = base 
    add  HL, HL         ; 1:11      405 *   1  *2 = 2x
    add  HL, BC         ; 1:11      405 *      +1 = 3x 
    add  HL, HL         ; 1:11      405 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      405 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      405 *   1  *2 = 24x
    add  HL, BC         ; 1:11      405 *      +1 = 25x 
    add  HL, HL         ; 1:11      405 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      405 *   1  *2 = 100x
    add  HL, BC         ; 1:11      405 *      +1 = 101x 
    add  HL, HL         ; 1:11      405 *   0  *2 = 202x 
    add  HL, HL         ; 1:11      405 *   1  *2 = 404x
    add  HL, BC         ; 1:11      405 *      +1 = 405x   
                        ;[15:151]   407 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001_0111)
    ld    B, H          ; 1:4       407 *
    ld    C, L          ; 1:4       407 *   1       1x = base 
    add  HL, HL         ; 1:11      407 *   1  *2 = 2x
    add  HL, BC         ; 1:11      407 *      +1 = 3x 
    add  HL, HL         ; 1:11      407 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      407 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      407 *   1  *2 = 24x
    add  HL, BC         ; 1:11      407 *      +1 = 25x 
    add  HL, HL         ; 1:11      407 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      407 *   1  *2 = 100x
    add  HL, BC         ; 1:11      407 *      +1 = 101x 
    add  HL, HL         ; 1:11      407 *   1  *2 = 202x
    add  HL, BC         ; 1:11      407 *      +1 = 203x 
    add  HL, HL         ; 1:11      407 *   1  *2 = 406x
    add  HL, BC         ; 1:11      407 *      +1 = 407x  

                        ;[14:140]   409 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001_1001)
    ld    B, H          ; 1:4       409 *
    ld    C, L          ; 1:4       409 *   1       1x = base 
    add  HL, HL         ; 1:11      409 *   1  *2 = 2x
    add  HL, BC         ; 1:11      409 *      +1 = 3x 
    add  HL, HL         ; 1:11      409 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      409 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      409 *   1  *2 = 24x
    add  HL, BC         ; 1:11      409 *      +1 = 25x 
    add  HL, HL         ; 1:11      409 *   1  *2 = 50x
    add  HL, BC         ; 1:11      409 *      +1 = 51x 
    add  HL, HL         ; 1:11      409 *   0  *2 = 102x 
    add  HL, HL         ; 1:11      409 *   0  *2 = 204x 
    add  HL, HL         ; 1:11      409 *   1  *2 = 408x
    add  HL, BC         ; 1:11      409 *      +1 = 409x   
                        ;[15:151]   411 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001_1011)
    ld    B, H          ; 1:4       411 *
    ld    C, L          ; 1:4       411 *   1       1x = base 
    add  HL, HL         ; 1:11      411 *   1  *2 = 2x
    add  HL, BC         ; 1:11      411 *      +1 = 3x 
    add  HL, HL         ; 1:11      411 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      411 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      411 *   1  *2 = 24x
    add  HL, BC         ; 1:11      411 *      +1 = 25x 
    add  HL, HL         ; 1:11      411 *   1  *2 = 50x
    add  HL, BC         ; 1:11      411 *      +1 = 51x 
    add  HL, HL         ; 1:11      411 *   0  *2 = 102x 
    add  HL, HL         ; 1:11      411 *   1  *2 = 204x
    add  HL, BC         ; 1:11      411 *      +1 = 205x 
    add  HL, HL         ; 1:11      411 *   1  *2 = 410x
    add  HL, BC         ; 1:11      411 *      +1 = 411x   
                        ;[15:151]   413 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001_1101)
    ld    B, H          ; 1:4       413 *
    ld    C, L          ; 1:4       413 *   1       1x = base 
    add  HL, HL         ; 1:11      413 *   1  *2 = 2x
    add  HL, BC         ; 1:11      413 *      +1 = 3x 
    add  HL, HL         ; 1:11      413 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      413 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      413 *   1  *2 = 24x
    add  HL, BC         ; 1:11      413 *      +1 = 25x 
    add  HL, HL         ; 1:11      413 *   1  *2 = 50x
    add  HL, BC         ; 1:11      413 *      +1 = 51x 
    add  HL, HL         ; 1:11      413 *   1  *2 = 102x
    add  HL, BC         ; 1:11      413 *      +1 = 103x 
    add  HL, HL         ; 1:11      413 *   0  *2 = 206x 
    add  HL, HL         ; 1:11      413 *   1  *2 = 412x
    add  HL, BC         ; 1:11      413 *      +1 = 413x   
                        ;[16:162]   415 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1001_1111)
    ld    B, H          ; 1:4       415 *
    ld    C, L          ; 1:4       415 *   1       1x = base 
    add  HL, HL         ; 1:11      415 *   1  *2 = 2x
    add  HL, BC         ; 1:11      415 *      +1 = 3x 
    add  HL, HL         ; 1:11      415 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      415 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      415 *   1  *2 = 24x
    add  HL, BC         ; 1:11      415 *      +1 = 25x 
    add  HL, HL         ; 1:11      415 *   1  *2 = 50x
    add  HL, BC         ; 1:11      415 *      +1 = 51x 
    add  HL, HL         ; 1:11      415 *   1  *2 = 102x
    add  HL, BC         ; 1:11      415 *      +1 = 103x 
    add  HL, HL         ; 1:11      415 *   1  *2 = 206x
    add  HL, BC         ; 1:11      415 *      +1 = 207x 
    add  HL, HL         ; 1:11      415 *   1  *2 = 414x
    add  HL, BC         ; 1:11      415 *      +1 = 415x   
                        ;[13:129]   417 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1010_0001)
    ld    B, H          ; 1:4       417 *
    ld    C, L          ; 1:4       417 *   1       1x = base 
    add  HL, HL         ; 1:11      417 *   1  *2 = 2x
    add  HL, BC         ; 1:11      417 *      +1 = 3x 
    add  HL, HL         ; 1:11      417 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      417 *   1  *2 = 12x
    add  HL, BC         ; 1:11      417 *      +1 = 13x 
    add  HL, HL         ; 1:11      417 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      417 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      417 *   0  *2 = 104x 
    add  HL, HL         ; 1:11      417 *   0  *2 = 208x 
    add  HL, HL         ; 1:11      417 *   1  *2 = 416x
    add  HL, BC         ; 1:11      417 *      +1 = 417x   
                        ;[14:140]   419 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1010_0011)
    ld    B, H          ; 1:4       419 *
    ld    C, L          ; 1:4       419 *   1       1x = base 
    add  HL, HL         ; 1:11      419 *   1  *2 = 2x
    add  HL, BC         ; 1:11      419 *      +1 = 3x 
    add  HL, HL         ; 1:11      419 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      419 *   1  *2 = 12x
    add  HL, BC         ; 1:11      419 *      +1 = 13x 
    add  HL, HL         ; 1:11      419 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      419 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      419 *   0  *2 = 104x 
    add  HL, HL         ; 1:11      419 *   1  *2 = 208x
    add  HL, BC         ; 1:11      419 *      +1 = 209x 
    add  HL, HL         ; 1:11      419 *   1  *2 = 418x
    add  HL, BC         ; 1:11      419 *      +1 = 419x   
                        ;[14:140]   421 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1010_0101)
    ld    B, H          ; 1:4       421 *
    ld    C, L          ; 1:4       421 *   1       1x = base 
    add  HL, HL         ; 1:11      421 *   1  *2 = 2x
    add  HL, BC         ; 1:11      421 *      +1 = 3x 
    add  HL, HL         ; 1:11      421 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      421 *   1  *2 = 12x
    add  HL, BC         ; 1:11      421 *      +1 = 13x 
    add  HL, HL         ; 1:11      421 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      421 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      421 *   1  *2 = 104x
    add  HL, BC         ; 1:11      421 *      +1 = 105x 
    add  HL, HL         ; 1:11      421 *   0  *2 = 210x 
    add  HL, HL         ; 1:11      421 *   1  *2 = 420x
    add  HL, BC         ; 1:11      421 *      +1 = 421x   
                        ;[15:151]   423 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1010_0111)
    ld    B, H          ; 1:4       423 *
    ld    C, L          ; 1:4       423 *   1       1x = base 
    add  HL, HL         ; 1:11      423 *   1  *2 = 2x
    add  HL, BC         ; 1:11      423 *      +1 = 3x 
    add  HL, HL         ; 1:11      423 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      423 *   1  *2 = 12x
    add  HL, BC         ; 1:11      423 *      +1 = 13x 
    add  HL, HL         ; 1:11      423 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      423 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      423 *   1  *2 = 104x
    add  HL, BC         ; 1:11      423 *      +1 = 105x 
    add  HL, HL         ; 1:11      423 *   1  *2 = 210x
    add  HL, BC         ; 1:11      423 *      +1 = 211x 
    add  HL, HL         ; 1:11      423 *   1  *2 = 422x
    add  HL, BC         ; 1:11      423 *      +1 = 423x   
                        ;[14:140]   425 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1010_1001)
    ld    B, H          ; 1:4       425 *
    ld    C, L          ; 1:4       425 *   1       1x = base 
    add  HL, HL         ; 1:11      425 *   1  *2 = 2x
    add  HL, BC         ; 1:11      425 *      +1 = 3x 
    add  HL, HL         ; 1:11      425 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      425 *   1  *2 = 12x
    add  HL, BC         ; 1:11      425 *      +1 = 13x 
    add  HL, HL         ; 1:11      425 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      425 *   1  *2 = 52x
    add  HL, BC         ; 1:11      425 *      +1 = 53x 
    add  HL, HL         ; 1:11      425 *   0  *2 = 106x 
    add  HL, HL         ; 1:11      425 *   0  *2 = 212x 
    add  HL, HL         ; 1:11      425 *   1  *2 = 424x
    add  HL, BC         ; 1:11      425 *      +1 = 425x   
                        ;[15:151]   427 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1010_1011)
    ld    B, H          ; 1:4       427 *
    ld    C, L          ; 1:4       427 *   1       1x = base 
    add  HL, HL         ; 1:11      427 *   1  *2 = 2x
    add  HL, BC         ; 1:11      427 *      +1 = 3x 
    add  HL, HL         ; 1:11      427 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      427 *   1  *2 = 12x
    add  HL, BC         ; 1:11      427 *      +1 = 13x 
    add  HL, HL         ; 1:11      427 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      427 *   1  *2 = 52x
    add  HL, BC         ; 1:11      427 *      +1 = 53x 
    add  HL, HL         ; 1:11      427 *   0  *2 = 106x 
    add  HL, HL         ; 1:11      427 *   1  *2 = 212x
    add  HL, BC         ; 1:11      427 *      +1 = 213x 
    add  HL, HL         ; 1:11      427 *   1  *2 = 426x
    add  HL, BC         ; 1:11      427 *      +1 = 427x   
                        ;[15:151]   429 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1010_1101)
    ld    B, H          ; 1:4       429 *
    ld    C, L          ; 1:4       429 *   1       1x = base 
    add  HL, HL         ; 1:11      429 *   1  *2 = 2x
    add  HL, BC         ; 1:11      429 *      +1 = 3x 
    add  HL, HL         ; 1:11      429 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      429 *   1  *2 = 12x
    add  HL, BC         ; 1:11      429 *      +1 = 13x 
    add  HL, HL         ; 1:11      429 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      429 *   1  *2 = 52x
    add  HL, BC         ; 1:11      429 *      +1 = 53x 
    add  HL, HL         ; 1:11      429 *   1  *2 = 106x
    add  HL, BC         ; 1:11      429 *      +1 = 107x 
    add  HL, HL         ; 1:11      429 *   0  *2 = 214x 
    add  HL, HL         ; 1:11      429 *   1  *2 = 428x
    add  HL, BC         ; 1:11      429 *      +1 = 429x  

                        ;[16:162]   431 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1010_1111)
    ld    B, H          ; 1:4       431 *
    ld    C, L          ; 1:4       431 *   1       1x = base 
    add  HL, HL         ; 1:11      431 *   1  *2 = 2x
    add  HL, BC         ; 1:11      431 *      +1 = 3x 
    add  HL, HL         ; 1:11      431 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      431 *   1  *2 = 12x
    add  HL, BC         ; 1:11      431 *      +1 = 13x 
    add  HL, HL         ; 1:11      431 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      431 *   1  *2 = 52x
    add  HL, BC         ; 1:11      431 *      +1 = 53x 
    add  HL, HL         ; 1:11      431 *   1  *2 = 106x
    add  HL, BC         ; 1:11      431 *      +1 = 107x 
    add  HL, HL         ; 1:11      431 *   1  *2 = 214x
    add  HL, BC         ; 1:11      431 *      +1 = 215x 
    add  HL, HL         ; 1:11      431 *   1  *2 = 430x
    add  HL, BC         ; 1:11      431 *      +1 = 431x   
                        ;[14:140]   433 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1011_0001)
    ld    B, H          ; 1:4       433 *
    ld    C, L          ; 1:4       433 *   1       1x = base 
    add  HL, HL         ; 1:11      433 *   1  *2 = 2x
    add  HL, BC         ; 1:11      433 *      +1 = 3x 
    add  HL, HL         ; 1:11      433 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      433 *   1  *2 = 12x
    add  HL, BC         ; 1:11      433 *      +1 = 13x 
    add  HL, HL         ; 1:11      433 *   1  *2 = 26x
    add  HL, BC         ; 1:11      433 *      +1 = 27x 
    add  HL, HL         ; 1:11      433 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      433 *   0  *2 = 108x 
    add  HL, HL         ; 1:11      433 *   0  *2 = 216x 
    add  HL, HL         ; 1:11      433 *   1  *2 = 432x
    add  HL, BC         ; 1:11      433 *      +1 = 433x   
                        ;[15:151]   435 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1011_0011)
    ld    B, H          ; 1:4       435 *
    ld    C, L          ; 1:4       435 *   1       1x = base 
    add  HL, HL         ; 1:11      435 *   1  *2 = 2x
    add  HL, BC         ; 1:11      435 *      +1 = 3x 
    add  HL, HL         ; 1:11      435 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      435 *   1  *2 = 12x
    add  HL, BC         ; 1:11      435 *      +1 = 13x 
    add  HL, HL         ; 1:11      435 *   1  *2 = 26x
    add  HL, BC         ; 1:11      435 *      +1 = 27x 
    add  HL, HL         ; 1:11      435 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      435 *   0  *2 = 108x 
    add  HL, HL         ; 1:11      435 *   1  *2 = 216x
    add  HL, BC         ; 1:11      435 *      +1 = 217x 
    add  HL, HL         ; 1:11      435 *   1  *2 = 434x
    add  HL, BC         ; 1:11      435 *      +1 = 435x   
                        ;[15:151]   437 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1011_0101)
    ld    B, H          ; 1:4       437 *
    ld    C, L          ; 1:4       437 *   1       1x = base 
    add  HL, HL         ; 1:11      437 *   1  *2 = 2x
    add  HL, BC         ; 1:11      437 *      +1 = 3x 
    add  HL, HL         ; 1:11      437 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      437 *   1  *2 = 12x
    add  HL, BC         ; 1:11      437 *      +1 = 13x 
    add  HL, HL         ; 1:11      437 *   1  *2 = 26x
    add  HL, BC         ; 1:11      437 *      +1 = 27x 
    add  HL, HL         ; 1:11      437 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      437 *   1  *2 = 108x
    add  HL, BC         ; 1:11      437 *      +1 = 109x 
    add  HL, HL         ; 1:11      437 *   0  *2 = 218x 
    add  HL, HL         ; 1:11      437 *   1  *2 = 436x
    add  HL, BC         ; 1:11      437 *      +1 = 437x   
                        ;[16:162]   439 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1011_0111)
    ld    B, H          ; 1:4       439 *
    ld    C, L          ; 1:4       439 *   1       1x = base 
    add  HL, HL         ; 1:11      439 *   1  *2 = 2x
    add  HL, BC         ; 1:11      439 *      +1 = 3x 
    add  HL, HL         ; 1:11      439 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      439 *   1  *2 = 12x
    add  HL, BC         ; 1:11      439 *      +1 = 13x 
    add  HL, HL         ; 1:11      439 *   1  *2 = 26x
    add  HL, BC         ; 1:11      439 *      +1 = 27x 
    add  HL, HL         ; 1:11      439 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      439 *   1  *2 = 108x
    add  HL, BC         ; 1:11      439 *      +1 = 109x 
    add  HL, HL         ; 1:11      439 *   1  *2 = 218x
    add  HL, BC         ; 1:11      439 *      +1 = 219x 
    add  HL, HL         ; 1:11      439 *   1  *2 = 438x
    add  HL, BC         ; 1:11      439 *      +1 = 439x   
                        ;[15:151]   441 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1011_1001)
    ld    B, H          ; 1:4       441 *
    ld    C, L          ; 1:4       441 *   1       1x = base 
    add  HL, HL         ; 1:11      441 *   1  *2 = 2x
    add  HL, BC         ; 1:11      441 *      +1 = 3x 
    add  HL, HL         ; 1:11      441 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      441 *   1  *2 = 12x
    add  HL, BC         ; 1:11      441 *      +1 = 13x 
    add  HL, HL         ; 1:11      441 *   1  *2 = 26x
    add  HL, BC         ; 1:11      441 *      +1 = 27x 
    add  HL, HL         ; 1:11      441 *   1  *2 = 54x
    add  HL, BC         ; 1:11      441 *      +1 = 55x 
    add  HL, HL         ; 1:11      441 *   0  *2 = 110x 
    add  HL, HL         ; 1:11      441 *   0  *2 = 220x 
    add  HL, HL         ; 1:11      441 *   1  *2 = 440x
    add  HL, BC         ; 1:11      441 *      +1 = 441x   
                        ;[16:162]   443 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1011_1011)
    ld    B, H          ; 1:4       443 *
    ld    C, L          ; 1:4       443 *   1       1x = base 
    add  HL, HL         ; 1:11      443 *   1  *2 = 2x
    add  HL, BC         ; 1:11      443 *      +1 = 3x 
    add  HL, HL         ; 1:11      443 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      443 *   1  *2 = 12x
    add  HL, BC         ; 1:11      443 *      +1 = 13x 
    add  HL, HL         ; 1:11      443 *   1  *2 = 26x
    add  HL, BC         ; 1:11      443 *      +1 = 27x 
    add  HL, HL         ; 1:11      443 *   1  *2 = 54x
    add  HL, BC         ; 1:11      443 *      +1 = 55x 
    add  HL, HL         ; 1:11      443 *   0  *2 = 110x 
    add  HL, HL         ; 1:11      443 *   1  *2 = 220x
    add  HL, BC         ; 1:11      443 *      +1 = 221x 
    add  HL, HL         ; 1:11      443 *   1  *2 = 442x
    add  HL, BC         ; 1:11      443 *      +1 = 443x   
                        ;[16:162]   445 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1011_1101)
    ld    B, H          ; 1:4       445 *
    ld    C, L          ; 1:4       445 *   1       1x = base 
    add  HL, HL         ; 1:11      445 *   1  *2 = 2x
    add  HL, BC         ; 1:11      445 *      +1 = 3x 
    add  HL, HL         ; 1:11      445 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      445 *   1  *2 = 12x
    add  HL, BC         ; 1:11      445 *      +1 = 13x 
    add  HL, HL         ; 1:11      445 *   1  *2 = 26x
    add  HL, BC         ; 1:11      445 *      +1 = 27x 
    add  HL, HL         ; 1:11      445 *   1  *2 = 54x
    add  HL, BC         ; 1:11      445 *      +1 = 55x 
    add  HL, HL         ; 1:11      445 *   1  *2 = 110x
    add  HL, BC         ; 1:11      445 *      +1 = 111x 
    add  HL, HL         ; 1:11      445 *   0  *2 = 222x 
    add  HL, HL         ; 1:11      445 *   1  *2 = 444x
    add  HL, BC         ; 1:11      445 *      +1 = 445x   
                        ;[17:117]   447 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0010_0000_0000 - b_0100_0001)  
    ld    B, H          ; 1:4       447 *
    ld    C, L          ; 1:4       447 *   [1x] 
    add  HL, HL         ; 1:11      447 *   2x 
    ld    A, L          ; 1:4       447 *   save --512x-- 
    add  HL, HL         ; 1:11      447 *   4x 
    add  HL, HL         ; 1:11      447 *   8x 
    add  HL, HL         ; 1:11      447 *   16x 
    add  HL, HL         ; 1:11      447 *   32x 
    add  HL, HL         ; 1:11      447 *   64x 
    add  HL, BC         ; 1:11      447 *   [65x]
    ld    B, A          ; 1:4       447 *   A0 - HL
    xor   A             ; 1:4       447 *
    sub   L             ; 1:4       447 *
    ld    L, A          ; 1:4       447 *
    ld    A, B          ; 1:4       447 *
    sbc   A, H          ; 1:4       447 *
    ld    H, A          ; 1:4       447 *   [447x] = 512x - 512x    
                        ;[13:129]   449 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1100_0001)
    ld    B, H          ; 1:4       449 *
    ld    C, L          ; 1:4       449 *   1       1x = base 
    add  HL, HL         ; 1:11      449 *   1  *2 = 2x
    add  HL, BC         ; 1:11      449 *      +1 = 3x 
    add  HL, HL         ; 1:11      449 *   1  *2 = 6x
    add  HL, BC         ; 1:11      449 *      +1 = 7x 
    add  HL, HL         ; 1:11      449 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      449 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      449 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      449 *   0  *2 = 112x 
    add  HL, HL         ; 1:11      449 *   0  *2 = 224x 
    add  HL, HL         ; 1:11      449 *   1  *2 = 448x
    add  HL, BC         ; 1:11      449 *      +1 = 449x   
                        ;[14:140]   451 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1100_0011)
    ld    B, H          ; 1:4       451 *
    ld    C, L          ; 1:4       451 *   1       1x = base 
    add  HL, HL         ; 1:11      451 *   1  *2 = 2x
    add  HL, BC         ; 1:11      451 *      +1 = 3x 
    add  HL, HL         ; 1:11      451 *   1  *2 = 6x
    add  HL, BC         ; 1:11      451 *      +1 = 7x 
    add  HL, HL         ; 1:11      451 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      451 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      451 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      451 *   0  *2 = 112x 
    add  HL, HL         ; 1:11      451 *   1  *2 = 224x
    add  HL, BC         ; 1:11      451 *      +1 = 225x 
    add  HL, HL         ; 1:11      451 *   1  *2 = 450x
    add  HL, BC         ; 1:11      451 *      +1 = 451x  

                        ;[14:140]   453 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1100_0101)
    ld    B, H          ; 1:4       453 *
    ld    C, L          ; 1:4       453 *   1       1x = base 
    add  HL, HL         ; 1:11      453 *   1  *2 = 2x
    add  HL, BC         ; 1:11      453 *      +1 = 3x 
    add  HL, HL         ; 1:11      453 *   1  *2 = 6x
    add  HL, BC         ; 1:11      453 *      +1 = 7x 
    add  HL, HL         ; 1:11      453 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      453 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      453 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      453 *   1  *2 = 112x
    add  HL, BC         ; 1:11      453 *      +1 = 113x 
    add  HL, HL         ; 1:11      453 *   0  *2 = 226x 
    add  HL, HL         ; 1:11      453 *   1  *2 = 452x
    add  HL, BC         ; 1:11      453 *      +1 = 453x   
                        ;[15:151]   455 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1100_0111)
    ld    B, H          ; 1:4       455 *
    ld    C, L          ; 1:4       455 *   1       1x = base 
    add  HL, HL         ; 1:11      455 *   1  *2 = 2x
    add  HL, BC         ; 1:11      455 *      +1 = 3x 
    add  HL, HL         ; 1:11      455 *   1  *2 = 6x
    add  HL, BC         ; 1:11      455 *      +1 = 7x 
    add  HL, HL         ; 1:11      455 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      455 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      455 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      455 *   1  *2 = 112x
    add  HL, BC         ; 1:11      455 *      +1 = 113x 
    add  HL, HL         ; 1:11      455 *   1  *2 = 226x
    add  HL, BC         ; 1:11      455 *      +1 = 227x 
    add  HL, HL         ; 1:11      455 *   1  *2 = 454x
    add  HL, BC         ; 1:11      455 *      +1 = 455x   
                        ;[14:140]   457 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1100_1001)
    ld    B, H          ; 1:4       457 *
    ld    C, L          ; 1:4       457 *   1       1x = base 
    add  HL, HL         ; 1:11      457 *   1  *2 = 2x
    add  HL, BC         ; 1:11      457 *      +1 = 3x 
    add  HL, HL         ; 1:11      457 *   1  *2 = 6x
    add  HL, BC         ; 1:11      457 *      +1 = 7x 
    add  HL, HL         ; 1:11      457 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      457 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      457 *   1  *2 = 56x
    add  HL, BC         ; 1:11      457 *      +1 = 57x 
    add  HL, HL         ; 1:11      457 *   0  *2 = 114x 
    add  HL, HL         ; 1:11      457 *   0  *2 = 228x 
    add  HL, HL         ; 1:11      457 *   1  *2 = 456x
    add  HL, BC         ; 1:11      457 *      +1 = 457x   
                        ;[15:151]   459 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1100_1011)
    ld    B, H          ; 1:4       459 *
    ld    C, L          ; 1:4       459 *   1       1x = base 
    add  HL, HL         ; 1:11      459 *   1  *2 = 2x
    add  HL, BC         ; 1:11      459 *      +1 = 3x 
    add  HL, HL         ; 1:11      459 *   1  *2 = 6x
    add  HL, BC         ; 1:11      459 *      +1 = 7x 
    add  HL, HL         ; 1:11      459 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      459 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      459 *   1  *2 = 56x
    add  HL, BC         ; 1:11      459 *      +1 = 57x 
    add  HL, HL         ; 1:11      459 *   0  *2 = 114x 
    add  HL, HL         ; 1:11      459 *   1  *2 = 228x
    add  HL, BC         ; 1:11      459 *      +1 = 229x 
    add  HL, HL         ; 1:11      459 *   1  *2 = 458x
    add  HL, BC         ; 1:11      459 *      +1 = 459x   
                        ;[15:151]   461 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1100_1101)
    ld    B, H          ; 1:4       461 *
    ld    C, L          ; 1:4       461 *   1       1x = base 
    add  HL, HL         ; 1:11      461 *   1  *2 = 2x
    add  HL, BC         ; 1:11      461 *      +1 = 3x 
    add  HL, HL         ; 1:11      461 *   1  *2 = 6x
    add  HL, BC         ; 1:11      461 *      +1 = 7x 
    add  HL, HL         ; 1:11      461 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      461 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      461 *   1  *2 = 56x
    add  HL, BC         ; 1:11      461 *      +1 = 57x 
    add  HL, HL         ; 1:11      461 *   1  *2 = 114x
    add  HL, BC         ; 1:11      461 *      +1 = 115x 
    add  HL, HL         ; 1:11      461 *   0  *2 = 230x 
    add  HL, HL         ; 1:11      461 *   1  *2 = 460x
    add  HL, BC         ; 1:11      461 *      +1 = 461x   
                        ;[16:162]   463 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1100_1111)
    ld    B, H          ; 1:4       463 *
    ld    C, L          ; 1:4       463 *   1       1x = base 
    add  HL, HL         ; 1:11      463 *   1  *2 = 2x
    add  HL, BC         ; 1:11      463 *      +1 = 3x 
    add  HL, HL         ; 1:11      463 *   1  *2 = 6x
    add  HL, BC         ; 1:11      463 *      +1 = 7x 
    add  HL, HL         ; 1:11      463 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      463 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      463 *   1  *2 = 56x
    add  HL, BC         ; 1:11      463 *      +1 = 57x 
    add  HL, HL         ; 1:11      463 *   1  *2 = 114x
    add  HL, BC         ; 1:11      463 *      +1 = 115x 
    add  HL, HL         ; 1:11      463 *   1  *2 = 230x
    add  HL, BC         ; 1:11      463 *      +1 = 231x 
    add  HL, HL         ; 1:11      463 *   1  *2 = 462x
    add  HL, BC         ; 1:11      463 *      +1 = 463x   
                        ;[14:140]   465 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1101_0001)
    ld    B, H          ; 1:4       465 *
    ld    C, L          ; 1:4       465 *   1       1x = base 
    add  HL, HL         ; 1:11      465 *   1  *2 = 2x
    add  HL, BC         ; 1:11      465 *      +1 = 3x 
    add  HL, HL         ; 1:11      465 *   1  *2 = 6x
    add  HL, BC         ; 1:11      465 *      +1 = 7x 
    add  HL, HL         ; 1:11      465 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      465 *   1  *2 = 28x
    add  HL, BC         ; 1:11      465 *      +1 = 29x 
    add  HL, HL         ; 1:11      465 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      465 *   0  *2 = 116x 
    add  HL, HL         ; 1:11      465 *   0  *2 = 232x 
    add  HL, HL         ; 1:11      465 *   1  *2 = 464x
    add  HL, BC         ; 1:11      465 *      +1 = 465x   
                        ;[15:151]   467 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1101_0011)
    ld    B, H          ; 1:4       467 *
    ld    C, L          ; 1:4       467 *   1       1x = base 
    add  HL, HL         ; 1:11      467 *   1  *2 = 2x
    add  HL, BC         ; 1:11      467 *      +1 = 3x 
    add  HL, HL         ; 1:11      467 *   1  *2 = 6x
    add  HL, BC         ; 1:11      467 *      +1 = 7x 
    add  HL, HL         ; 1:11      467 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      467 *   1  *2 = 28x
    add  HL, BC         ; 1:11      467 *      +1 = 29x 
    add  HL, HL         ; 1:11      467 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      467 *   0  *2 = 116x 
    add  HL, HL         ; 1:11      467 *   1  *2 = 232x
    add  HL, BC         ; 1:11      467 *      +1 = 233x 
    add  HL, HL         ; 1:11      467 *   1  *2 = 466x
    add  HL, BC         ; 1:11      467 *      +1 = 467x   
                        ;[15:151]   469 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1101_0101)
    ld    B, H          ; 1:4       469 *
    ld    C, L          ; 1:4       469 *   1       1x = base 
    add  HL, HL         ; 1:11      469 *   1  *2 = 2x
    add  HL, BC         ; 1:11      469 *      +1 = 3x 
    add  HL, HL         ; 1:11      469 *   1  *2 = 6x
    add  HL, BC         ; 1:11      469 *      +1 = 7x 
    add  HL, HL         ; 1:11      469 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      469 *   1  *2 = 28x
    add  HL, BC         ; 1:11      469 *      +1 = 29x 
    add  HL, HL         ; 1:11      469 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      469 *   1  *2 = 116x
    add  HL, BC         ; 1:11      469 *      +1 = 117x 
    add  HL, HL         ; 1:11      469 *   0  *2 = 234x 
    add  HL, HL         ; 1:11      469 *   1  *2 = 468x
    add  HL, BC         ; 1:11      469 *      +1 = 469x   
                        ;[16:162]   471 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1101_0111)
    ld    B, H          ; 1:4       471 *
    ld    C, L          ; 1:4       471 *   1       1x = base 
    add  HL, HL         ; 1:11      471 *   1  *2 = 2x
    add  HL, BC         ; 1:11      471 *      +1 = 3x 
    add  HL, HL         ; 1:11      471 *   1  *2 = 6x
    add  HL, BC         ; 1:11      471 *      +1 = 7x 
    add  HL, HL         ; 1:11      471 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      471 *   1  *2 = 28x
    add  HL, BC         ; 1:11      471 *      +1 = 29x 
    add  HL, HL         ; 1:11      471 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      471 *   1  *2 = 116x
    add  HL, BC         ; 1:11      471 *      +1 = 117x 
    add  HL, HL         ; 1:11      471 *   1  *2 = 234x
    add  HL, BC         ; 1:11      471 *      +1 = 235x 
    add  HL, HL         ; 1:11      471 *   1  *2 = 470x
    add  HL, BC         ; 1:11      471 *      +1 = 471x   
                        ;[15:151]   473 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1101_1001)
    ld    B, H          ; 1:4       473 *
    ld    C, L          ; 1:4       473 *   1       1x = base 
    add  HL, HL         ; 1:11      473 *   1  *2 = 2x
    add  HL, BC         ; 1:11      473 *      +1 = 3x 
    add  HL, HL         ; 1:11      473 *   1  *2 = 6x
    add  HL, BC         ; 1:11      473 *      +1 = 7x 
    add  HL, HL         ; 1:11      473 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      473 *   1  *2 = 28x
    add  HL, BC         ; 1:11      473 *      +1 = 29x 
    add  HL, HL         ; 1:11      473 *   1  *2 = 58x
    add  HL, BC         ; 1:11      473 *      +1 = 59x 
    add  HL, HL         ; 1:11      473 *   0  *2 = 118x 
    add  HL, HL         ; 1:11      473 *   0  *2 = 236x 
    add  HL, HL         ; 1:11      473 *   1  *2 = 472x
    add  HL, BC         ; 1:11      473 *      +1 = 473x  

                        ;[16:162]   475 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1101_1011)
    ld    B, H          ; 1:4       475 *
    ld    C, L          ; 1:4       475 *   1       1x = base 
    add  HL, HL         ; 1:11      475 *   1  *2 = 2x
    add  HL, BC         ; 1:11      475 *      +1 = 3x 
    add  HL, HL         ; 1:11      475 *   1  *2 = 6x
    add  HL, BC         ; 1:11      475 *      +1 = 7x 
    add  HL, HL         ; 1:11      475 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      475 *   1  *2 = 28x
    add  HL, BC         ; 1:11      475 *      +1 = 29x 
    add  HL, HL         ; 1:11      475 *   1  *2 = 58x
    add  HL, BC         ; 1:11      475 *      +1 = 59x 
    add  HL, HL         ; 1:11      475 *   0  *2 = 118x 
    add  HL, HL         ; 1:11      475 *   1  *2 = 236x
    add  HL, BC         ; 1:11      475 *      +1 = 237x 
    add  HL, HL         ; 1:11      475 *   1  *2 = 474x
    add  HL, BC         ; 1:11      475 *      +1 = 475x   
                        ;[16:162]   477 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1101_1101)
    ld    B, H          ; 1:4       477 *
    ld    C, L          ; 1:4       477 *   1       1x = base 
    add  HL, HL         ; 1:11      477 *   1  *2 = 2x
    add  HL, BC         ; 1:11      477 *      +1 = 3x 
    add  HL, HL         ; 1:11      477 *   1  *2 = 6x
    add  HL, BC         ; 1:11      477 *      +1 = 7x 
    add  HL, HL         ; 1:11      477 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      477 *   1  *2 = 28x
    add  HL, BC         ; 1:11      477 *      +1 = 29x 
    add  HL, HL         ; 1:11      477 *   1  *2 = 58x
    add  HL, BC         ; 1:11      477 *      +1 = 59x 
    add  HL, HL         ; 1:11      477 *   1  *2 = 118x
    add  HL, BC         ; 1:11      477 *      +1 = 119x 
    add  HL, HL         ; 1:11      477 *   0  *2 = 238x 
    add  HL, HL         ; 1:11      477 *   1  *2 = 476x
    add  HL, BC         ; 1:11      477 *      +1 = 477x   
                        ;[16:106]   479 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0010_0000_0000 - b_0010_0001)  
    ld    B, H          ; 1:4       479 *
    ld    C, L          ; 1:4       479 *   [1x] 
    add  HL, HL         ; 1:11      479 *   2x 
    ld    A, L          ; 1:4       479 *   save --512x-- 
    add  HL, HL         ; 1:11      479 *   4x 
    add  HL, HL         ; 1:11      479 *   8x 
    add  HL, HL         ; 1:11      479 *   16x 
    add  HL, HL         ; 1:11      479 *   32x 
    add  HL, BC         ; 1:11      479 *   [33x]
    ld    B, A          ; 1:4       479 *   A0 - HL
    xor   A             ; 1:4       479 *
    sub   L             ; 1:4       479 *
    ld    L, A          ; 1:4       479 *
    ld    A, B          ; 1:4       479 *
    sbc   A, H          ; 1:4       479 *
    ld    H, A          ; 1:4       479 *   [479x] = 512x - 512x    
                        ;[14:140]   481 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1110_0001)
    ld    B, H          ; 1:4       481 *
    ld    C, L          ; 1:4       481 *   1       1x = base 
    add  HL, HL         ; 1:11      481 *   1  *2 = 2x
    add  HL, BC         ; 1:11      481 *      +1 = 3x 
    add  HL, HL         ; 1:11      481 *   1  *2 = 6x
    add  HL, BC         ; 1:11      481 *      +1 = 7x 
    add  HL, HL         ; 1:11      481 *   1  *2 = 14x
    add  HL, BC         ; 1:11      481 *      +1 = 15x 
    add  HL, HL         ; 1:11      481 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      481 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      481 *   0  *2 = 120x 
    add  HL, HL         ; 1:11      481 *   0  *2 = 240x 
    add  HL, HL         ; 1:11      481 *   1  *2 = 480x
    add  HL, BC         ; 1:11      481 *      +1 = 481x   
                        ;[15:151]   483 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1110_0011)
    ld    B, H          ; 1:4       483 *
    ld    C, L          ; 1:4       483 *   1       1x = base 
    add  HL, HL         ; 1:11      483 *   1  *2 = 2x
    add  HL, BC         ; 1:11      483 *      +1 = 3x 
    add  HL, HL         ; 1:11      483 *   1  *2 = 6x
    add  HL, BC         ; 1:11      483 *      +1 = 7x 
    add  HL, HL         ; 1:11      483 *   1  *2 = 14x
    add  HL, BC         ; 1:11      483 *      +1 = 15x 
    add  HL, HL         ; 1:11      483 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      483 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      483 *   0  *2 = 120x 
    add  HL, HL         ; 1:11      483 *   1  *2 = 240x
    add  HL, BC         ; 1:11      483 *      +1 = 241x 
    add  HL, HL         ; 1:11      483 *   1  *2 = 482x
    add  HL, BC         ; 1:11      483 *      +1 = 483x   
                        ;[15:151]   485 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1110_0101)
    ld    B, H          ; 1:4       485 *
    ld    C, L          ; 1:4       485 *   1       1x = base 
    add  HL, HL         ; 1:11      485 *   1  *2 = 2x
    add  HL, BC         ; 1:11      485 *      +1 = 3x 
    add  HL, HL         ; 1:11      485 *   1  *2 = 6x
    add  HL, BC         ; 1:11      485 *      +1 = 7x 
    add  HL, HL         ; 1:11      485 *   1  *2 = 14x
    add  HL, BC         ; 1:11      485 *      +1 = 15x 
    add  HL, HL         ; 1:11      485 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      485 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      485 *   1  *2 = 120x
    add  HL, BC         ; 1:11      485 *      +1 = 121x 
    add  HL, HL         ; 1:11      485 *   0  *2 = 242x 
    add  HL, HL         ; 1:11      485 *   1  *2 = 484x
    add  HL, BC         ; 1:11      485 *      +1 = 485x   
                        ;[16:162]   487 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1110_0111)
    ld    B, H          ; 1:4       487 *
    ld    C, L          ; 1:4       487 *   1       1x = base 
    add  HL, HL         ; 1:11      487 *   1  *2 = 2x
    add  HL, BC         ; 1:11      487 *      +1 = 3x 
    add  HL, HL         ; 1:11      487 *   1  *2 = 6x
    add  HL, BC         ; 1:11      487 *      +1 = 7x 
    add  HL, HL         ; 1:11      487 *   1  *2 = 14x
    add  HL, BC         ; 1:11      487 *      +1 = 15x 
    add  HL, HL         ; 1:11      487 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      487 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      487 *   1  *2 = 120x
    add  HL, BC         ; 1:11      487 *      +1 = 121x 
    add  HL, HL         ; 1:11      487 *   1  *2 = 242x
    add  HL, BC         ; 1:11      487 *      +1 = 243x 
    add  HL, HL         ; 1:11      487 *   1  *2 = 486x
    add  HL, BC         ; 1:11      487 *      +1 = 487x   
                        ;[15:151]   489 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1110_1001)
    ld    B, H          ; 1:4       489 *
    ld    C, L          ; 1:4       489 *   1       1x = base 
    add  HL, HL         ; 1:11      489 *   1  *2 = 2x
    add  HL, BC         ; 1:11      489 *      +1 = 3x 
    add  HL, HL         ; 1:11      489 *   1  *2 = 6x
    add  HL, BC         ; 1:11      489 *      +1 = 7x 
    add  HL, HL         ; 1:11      489 *   1  *2 = 14x
    add  HL, BC         ; 1:11      489 *      +1 = 15x 
    add  HL, HL         ; 1:11      489 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      489 *   1  *2 = 60x
    add  HL, BC         ; 1:11      489 *      +1 = 61x 
    add  HL, HL         ; 1:11      489 *   0  *2 = 122x 
    add  HL, HL         ; 1:11      489 *   0  *2 = 244x 
    add  HL, HL         ; 1:11      489 *   1  *2 = 488x
    add  HL, BC         ; 1:11      489 *      +1 = 489x   
                        ;[16:162]   491 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1110_1011)
    ld    B, H          ; 1:4       491 *
    ld    C, L          ; 1:4       491 *   1       1x = base 
    add  HL, HL         ; 1:11      491 *   1  *2 = 2x
    add  HL, BC         ; 1:11      491 *      +1 = 3x 
    add  HL, HL         ; 1:11      491 *   1  *2 = 6x
    add  HL, BC         ; 1:11      491 *      +1 = 7x 
    add  HL, HL         ; 1:11      491 *   1  *2 = 14x
    add  HL, BC         ; 1:11      491 *      +1 = 15x 
    add  HL, HL         ; 1:11      491 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      491 *   1  *2 = 60x
    add  HL, BC         ; 1:11      491 *      +1 = 61x 
    add  HL, HL         ; 1:11      491 *   0  *2 = 122x 
    add  HL, HL         ; 1:11      491 *   1  *2 = 244x
    add  HL, BC         ; 1:11      491 *      +1 = 245x 
    add  HL, HL         ; 1:11      491 *   1  *2 = 490x
    add  HL, BC         ; 1:11      491 *      +1 = 491x   
                        ;[16:162]   493 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1110_1101)
    ld    B, H          ; 1:4       493 *
    ld    C, L          ; 1:4       493 *   1       1x = base 
    add  HL, HL         ; 1:11      493 *   1  *2 = 2x
    add  HL, BC         ; 1:11      493 *      +1 = 3x 
    add  HL, HL         ; 1:11      493 *   1  *2 = 6x
    add  HL, BC         ; 1:11      493 *      +1 = 7x 
    add  HL, HL         ; 1:11      493 *   1  *2 = 14x
    add  HL, BC         ; 1:11      493 *      +1 = 15x 
    add  HL, HL         ; 1:11      493 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      493 *   1  *2 = 60x
    add  HL, BC         ; 1:11      493 *      +1 = 61x 
    add  HL, HL         ; 1:11      493 *   1  *2 = 122x
    add  HL, BC         ; 1:11      493 *      +1 = 123x 
    add  HL, HL         ; 1:11      493 *   0  *2 = 246x 
    add  HL, HL         ; 1:11      493 *   1  *2 = 492x
    add  HL, BC         ; 1:11      493 *      +1 = 493x   
                        ;[15:95]    495 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0010_0000_0000 - b_0001_0001)  
    ld    B, H          ; 1:4       495 *
    ld    C, L          ; 1:4       495 *   [1x] 
    add  HL, HL         ; 1:11      495 *   2x 
    ld    A, L          ; 1:4       495 *   save --512x-- 
    add  HL, HL         ; 1:11      495 *   4x 
    add  HL, HL         ; 1:11      495 *   8x 
    add  HL, HL         ; 1:11      495 *   16x 
    add  HL, BC         ; 1:11      495 *   [17x]
    ld    B, A          ; 1:4       495 *   A0 - HL
    xor   A             ; 1:4       495 *
    sub   L             ; 1:4       495 *
    ld    L, A          ; 1:4       495 *
    ld    A, B          ; 1:4       495 *
    sbc   A, H          ; 1:4       495 *
    ld    H, A          ; 1:4       495 *   [495x] = 512x - 512x   

                        ;[15:151]   497 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1111_0001)
    ld    B, H          ; 1:4       497 *
    ld    C, L          ; 1:4       497 *   1       1x = base 
    add  HL, HL         ; 1:11      497 *   1  *2 = 2x
    add  HL, BC         ; 1:11      497 *      +1 = 3x 
    add  HL, HL         ; 1:11      497 *   1  *2 = 6x
    add  HL, BC         ; 1:11      497 *      +1 = 7x 
    add  HL, HL         ; 1:11      497 *   1  *2 = 14x
    add  HL, BC         ; 1:11      497 *      +1 = 15x 
    add  HL, HL         ; 1:11      497 *   1  *2 = 30x
    add  HL, BC         ; 1:11      497 *      +1 = 31x 
    add  HL, HL         ; 1:11      497 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      497 *   0  *2 = 124x 
    add  HL, HL         ; 1:11      497 *   0  *2 = 248x 
    add  HL, HL         ; 1:11      497 *   1  *2 = 496x
    add  HL, BC         ; 1:11      497 *      +1 = 497x   
                        ;[16:162]   499 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1111_0011)
    ld    B, H          ; 1:4       499 *
    ld    C, L          ; 1:4       499 *   1       1x = base 
    add  HL, HL         ; 1:11      499 *   1  *2 = 2x
    add  HL, BC         ; 1:11      499 *      +1 = 3x 
    add  HL, HL         ; 1:11      499 *   1  *2 = 6x
    add  HL, BC         ; 1:11      499 *      +1 = 7x 
    add  HL, HL         ; 1:11      499 *   1  *2 = 14x
    add  HL, BC         ; 1:11      499 *      +1 = 15x 
    add  HL, HL         ; 1:11      499 *   1  *2 = 30x
    add  HL, BC         ; 1:11      499 *      +1 = 31x 
    add  HL, HL         ; 1:11      499 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      499 *   0  *2 = 124x 
    add  HL, HL         ; 1:11      499 *   1  *2 = 248x
    add  HL, BC         ; 1:11      499 *      +1 = 249x 
    add  HL, HL         ; 1:11      499 *   1  *2 = 498x
    add  HL, BC         ; 1:11      499 *      +1 = 499x   
                        ;[16:162]   501 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1111_0101)
    ld    B, H          ; 1:4       501 *
    ld    C, L          ; 1:4       501 *   1       1x = base 
    add  HL, HL         ; 1:11      501 *   1  *2 = 2x
    add  HL, BC         ; 1:11      501 *      +1 = 3x 
    add  HL, HL         ; 1:11      501 *   1  *2 = 6x
    add  HL, BC         ; 1:11      501 *      +1 = 7x 
    add  HL, HL         ; 1:11      501 *   1  *2 = 14x
    add  HL, BC         ; 1:11      501 *      +1 = 15x 
    add  HL, HL         ; 1:11      501 *   1  *2 = 30x
    add  HL, BC         ; 1:11      501 *      +1 = 31x 
    add  HL, HL         ; 1:11      501 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      501 *   1  *2 = 124x
    add  HL, BC         ; 1:11      501 *      +1 = 125x 
    add  HL, HL         ; 1:11      501 *   0  *2 = 250x 
    add  HL, HL         ; 1:11      501 *   1  *2 = 500x
    add  HL, BC         ; 1:11      501 *      +1 = 501x   
                        ;[14:84]    503 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0010_0000_0000 - b_1001)  
    ld    B, H          ; 1:4       503 *
    ld    C, L          ; 1:4       503 *   [1x] 
    add  HL, HL         ; 1:11      503 *   2x 
    ld    A, L          ; 1:4       503 *   save --512x-- 
    add  HL, HL         ; 1:11      503 *   4x 
    add  HL, HL         ; 1:11      503 *   8x 
    add  HL, BC         ; 1:11      503 *   [9x]
    ld    B, A          ; 1:4       503 *   A0 - HL
    xor   A             ; 1:4       503 *
    sub   L             ; 1:4       503 *
    ld    L, A          ; 1:4       503 *
    ld    A, B          ; 1:4       503 *
    sbc   A, H          ; 1:4       503 *
    ld    H, A          ; 1:4       503 *   [503x] = 512x - 512x    
                        ;[16:162]   505 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0001_1111_1001)
    ld    B, H          ; 1:4       505 *
    ld    C, L          ; 1:4       505 *   1       1x = base 
    add  HL, HL         ; 1:11      505 *   1  *2 = 2x
    add  HL, BC         ; 1:11      505 *      +1 = 3x 
    add  HL, HL         ; 1:11      505 *   1  *2 = 6x
    add  HL, BC         ; 1:11      505 *      +1 = 7x 
    add  HL, HL         ; 1:11      505 *   1  *2 = 14x
    add  HL, BC         ; 1:11      505 *      +1 = 15x 
    add  HL, HL         ; 1:11      505 *   1  *2 = 30x
    add  HL, BC         ; 1:11      505 *      +1 = 31x 
    add  HL, HL         ; 1:11      505 *   1  *2 = 62x
    add  HL, BC         ; 1:11      505 *      +1 = 63x 
    add  HL, HL         ; 1:11      505 *   0  *2 = 126x 
    add  HL, HL         ; 1:11      505 *   0  *2 = 252x 
    add  HL, HL         ; 1:11      505 *   1  *2 = 504x
    add  HL, BC         ; 1:11      505 *      +1 = 505x   
                        ;[13:73]    507 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0010_0000_0000 - b_0101)  
    ld    B, H          ; 1:4       507 *
    ld    C, L          ; 1:4       507 *   [1x] 
    add  HL, HL         ; 1:11      507 *   2x 
    ld    A, L          ; 1:4       507 *   save --512x-- 
    add  HL, HL         ; 1:11      507 *   4x 
    add  HL, BC         ; 1:11      507 *   [5x]
    ld    B, A          ; 1:4       507 *   A0 - HL
    xor   A             ; 1:4       507 *
    sub   L             ; 1:4       507 *
    ld    L, A          ; 1:4       507 *
    ld    A, B          ; 1:4       507 *
    sbc   A, H          ; 1:4       507 *
    ld    H, A          ; 1:4       507 *   [507x] = 512x - 512x    
                        ;[12:62]    509 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0010_0000_0000 - b_0011)  
    ld    B, H          ; 1:4       509 *
    ld    C, L          ; 1:4       509 *   [1x] 
    add  HL, HL         ; 1:11      509 *   2x 
    ld    A, L          ; 1:4       509 *   L0 - (HL + BC) --> B0 - HL
    add  HL, BC         ; 1:11      509 *   [3x]
    ld    B, A          ; 1:4       509 *
    xor   A             ; 1:4       509 *
    sub   L             ; 1:4       509 *
    ld    L, A          ; 1:4       509 *
    ld    A, B          ; 1:4       509 *
    sbc   A, H          ; 1:4       509 *
    ld    H, A          ; 1:4       509 *   [509x] = 512x - 3x    
                        ;[9:49]     511 *   Variant mk1: HL * (2^a - 2^b) = HL * (b_0001_1111_1111)   
    ld    B, H          ; 1:4       511 *
    ld    C, L          ; 1:4       511 *   [1x] 
    ld    H, L          ; 1:4       511 *
    ld    L, 0x00       ; 2:7       511 *   256x 
    add  HL, HL         ; 1:11      511 *   512x 
    or    A             ; 1:4       511 *
    sbc  HL, BC         ; 2:15      511 *   [511x] = 512x - 1x   
                        ;[4:16]     513 *   Variant mk4: 256*...(((L*2^a)+L)*2^b)+... = HL * (b_0010_0000_0001)
    ld    A, L          ; 1:4       513 *   1       1x 
    add   A, A          ; 1:4       513 *   0  *2 = 2x 
    add   A, H          ; 1:4       513 *
    ld    H, A          ; 1:4       513 *     [513x] = 256 * 2x + 1x  
                        ;[7:42]     515 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0010_0000_0011)  
    ld    B, H          ; 1:4       515 *
    ld    C, L          ; 1:4       515 *   [1x] 
    add  HL, HL         ; 1:11      515 *   2x 
    ld    A, L          ; 1:4       515 *
    add   A, B          ; 1:4       515 *
    ld    B, A          ; 1:4       515 *   [513x] 
    add  HL, BC         ; 1:11      515 *   [515x] = 2x + 513x   
                        ;[8:53]     517 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0010_0000_0101)  
    ld    B, H          ; 1:4       517 *
    ld    C, L          ; 1:4       517 *   [1x] 
    add  HL, HL         ; 1:11      517 *   2x 
    ld    A, L          ; 1:4       517 *   512x 
    add  HL, HL         ; 1:11      517 *   4x 
    add   A, B          ; 1:4       517 *
    ld    B, A          ; 1:4       517 *   [513x] 
    add  HL, BC         ; 1:11      517 *   [517x] = 4x + 513x  

                        ;[9:64]     519 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0000_0111)
    ld    B, H          ; 1:4       519 *
    ld    C, L          ; 1:4       519 *   1       1x = base 
    add  HL, HL         ; 1:11      519 *   1  *2 = 2x
    ld    A, L          ; 1:4       519 *   256*L = 512x
    add  HL, BC         ; 1:11      519 *      +1 = 3x 
    add  HL, HL         ; 1:11      519 *   1  *2 = 6x
    add  HL, BC         ; 1:11      519 *      +1 = 7x 
    add   A, H          ; 1:4       519 *
    ld    H, A          ; 1:4       519 *     [519x] = 7x + 512x  
                        ;[9:64]     521 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0010_0000_1001)  
    ld    B, H          ; 1:4       521 *
    ld    C, L          ; 1:4       521 *   [1x] 
    add  HL, HL         ; 1:11      521 *   2x 
    ld    A, L          ; 1:4       521 *   512x 
    add  HL, HL         ; 1:11      521 *   4x 
    add  HL, HL         ; 1:11      521 *   8x 
    add   A, B          ; 1:4       521 *
    ld    B, A          ; 1:4       521 *   [513x] 
    add  HL, BC         ; 1:11      521 *   [521x] = 8x + 513x   
                        ;[10:75]    523 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0000_1011)
    ld    B, H          ; 1:4       523 *
    ld    C, L          ; 1:4       523 *   1       1x = base 
    add  HL, HL         ; 1:11      523 *   0  *2 = 2x 
    ld    A, L          ; 1:4       523 *   256*L = 512x 
    add  HL, HL         ; 1:11      523 *   1  *2 = 4x
    add  HL, BC         ; 1:11      523 *      +1 = 5x 
    add  HL, HL         ; 1:11      523 *   1  *2 = 10x
    add  HL, BC         ; 1:11      523 *      +1 = 11x 
    add   A, H          ; 1:4       523 *
    ld    H, A          ; 1:4       523 *     [523x] = 11x + 512x  
                        ;[10:75]    525 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0000_1101)
    ld    B, H          ; 1:4       525 *
    ld    C, L          ; 1:4       525 *   1       1x = base 
    add  HL, HL         ; 1:11      525 *   1  *2 = 2x
    ld    A, L          ; 1:4       525 *   256*L = 512x
    add  HL, BC         ; 1:11      525 *      +1 = 3x 
    add  HL, HL         ; 1:11      525 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      525 *   1  *2 = 12x
    add  HL, BC         ; 1:11      525 *      +1 = 13x 
    add   A, H          ; 1:4       525 *
    ld    H, A          ; 1:4       525 *     [525x] = 13x + 512x  
                        ;[11:86]    527 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0000_1111)
    ld    B, H          ; 1:4       527 *
    ld    C, L          ; 1:4       527 *   1       1x = base 
    add  HL, HL         ; 1:11      527 *   1  *2 = 2x
    ld    A, L          ; 1:4       527 *   256*L = 512x
    add  HL, BC         ; 1:11      527 *      +1 = 3x 
    add  HL, HL         ; 1:11      527 *   1  *2 = 6x
    add  HL, BC         ; 1:11      527 *      +1 = 7x 
    add  HL, HL         ; 1:11      527 *   1  *2 = 14x
    add  HL, BC         ; 1:11      527 *      +1 = 15x 
    add   A, H          ; 1:4       527 *
    ld    H, A          ; 1:4       527 *     [527x] = 15x + 512x  
                        ;[10:75]    529 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0010_0001_0001)  
    ld    B, H          ; 1:4       529 *
    ld    C, L          ; 1:4       529 *   [1x] 
    add  HL, HL         ; 1:11      529 *   2x 
    ld    A, L          ; 1:4       529 *   512x 
    add  HL, HL         ; 1:11      529 *   4x 
    add  HL, HL         ; 1:11      529 *   8x 
    add  HL, HL         ; 1:11      529 *   16x 
    add   A, B          ; 1:4       529 *
    ld    B, A          ; 1:4       529 *   [513x] 
    add  HL, BC         ; 1:11      529 *   [529x] = 16x + 513x   
                        ;[11:86]    531 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0001_0011)
    ld    B, H          ; 1:4       531 *
    ld    C, L          ; 1:4       531 *   1       1x = base 
    add  HL, HL         ; 1:11      531 *   0  *2 = 2x 
    ld    A, L          ; 1:4       531 *   256*L = 512x 
    add  HL, HL         ; 1:11      531 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      531 *   1  *2 = 8x
    add  HL, BC         ; 1:11      531 *      +1 = 9x 
    add  HL, HL         ; 1:11      531 *   1  *2 = 18x
    add  HL, BC         ; 1:11      531 *      +1 = 19x 
    add   A, H          ; 1:4       531 *
    ld    H, A          ; 1:4       531 *     [531x] = 19x + 512x  
                        ;[11:86]    533 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0001_0101)
    ld    B, H          ; 1:4       533 *
    ld    C, L          ; 1:4       533 *   1       1x = base 
    add  HL, HL         ; 1:11      533 *   0  *2 = 2x 
    ld    A, L          ; 1:4       533 *   256*L = 512x 
    add  HL, HL         ; 1:11      533 *   1  *2 = 4x
    add  HL, BC         ; 1:11      533 *      +1 = 5x 
    add  HL, HL         ; 1:11      533 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      533 *   1  *2 = 20x
    add  HL, BC         ; 1:11      533 *      +1 = 21x 
    add   A, H          ; 1:4       533 *
    ld    H, A          ; 1:4       533 *     [533x] = 21x + 512x  
                        ;[12:97]    535 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0001_0111)
    ld    B, H          ; 1:4       535 *
    ld    C, L          ; 1:4       535 *   1       1x = base 
    add  HL, HL         ; 1:11      535 *   0  *2 = 2x 
    ld    A, L          ; 1:4       535 *   256*L = 512x 
    add  HL, HL         ; 1:11      535 *   1  *2 = 4x
    add  HL, BC         ; 1:11      535 *      +1 = 5x 
    add  HL, HL         ; 1:11      535 *   1  *2 = 10x
    add  HL, BC         ; 1:11      535 *      +1 = 11x 
    add  HL, HL         ; 1:11      535 *   1  *2 = 22x
    add  HL, BC         ; 1:11      535 *      +1 = 23x 
    add   A, H          ; 1:4       535 *
    ld    H, A          ; 1:4       535 *     [535x] = 23x + 512x  
                        ;[11:86]    537 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0001_1001)
    ld    B, H          ; 1:4       537 *
    ld    C, L          ; 1:4       537 *   1       1x = base 
    add  HL, HL         ; 1:11      537 *   1  *2 = 2x
    ld    A, L          ; 1:4       537 *   256*L = 512x
    add  HL, BC         ; 1:11      537 *      +1 = 3x 
    add  HL, HL         ; 1:11      537 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      537 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      537 *   1  *2 = 24x
    add  HL, BC         ; 1:11      537 *      +1 = 25x 
    add   A, H          ; 1:4       537 *
    ld    H, A          ; 1:4       537 *     [537x] = 25x + 512x  
                        ;[12:97]    539 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0001_1011)
    ld    B, H          ; 1:4       539 *
    ld    C, L          ; 1:4       539 *   1       1x = base 
    add  HL, HL         ; 1:11      539 *   1  *2 = 2x
    ld    A, L          ; 1:4       539 *   256*L = 512x
    add  HL, BC         ; 1:11      539 *      +1 = 3x 
    add  HL, HL         ; 1:11      539 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      539 *   1  *2 = 12x
    add  HL, BC         ; 1:11      539 *      +1 = 13x 
    add  HL, HL         ; 1:11      539 *   1  *2 = 26x
    add  HL, BC         ; 1:11      539 *      +1 = 27x 
    add   A, H          ; 1:4       539 *
    ld    H, A          ; 1:4       539 *     [539x] = 27x + 512x 

                        ;[12:97]    541 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0001_1101)
    ld    B, H          ; 1:4       541 *
    ld    C, L          ; 1:4       541 *   1       1x = base 
    add  HL, HL         ; 1:11      541 *   1  *2 = 2x
    ld    A, L          ; 1:4       541 *   256*L = 512x
    add  HL, BC         ; 1:11      541 *      +1 = 3x 
    add  HL, HL         ; 1:11      541 *   1  *2 = 6x
    add  HL, BC         ; 1:11      541 *      +1 = 7x 
    add  HL, HL         ; 1:11      541 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      541 *   1  *2 = 28x
    add  HL, BC         ; 1:11      541 *      +1 = 29x 
    add   A, H          ; 1:4       541 *
    ld    H, A          ; 1:4       541 *     [541x] = 29x + 512x  
                        ;[13:108]   543 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0001_1111)
    ld    B, H          ; 1:4       543 *
    ld    C, L          ; 1:4       543 *   1       1x = base 
    add  HL, HL         ; 1:11      543 *   1  *2 = 2x
    ld    A, L          ; 1:4       543 *   256*L = 512x
    add  HL, BC         ; 1:11      543 *      +1 = 3x 
    add  HL, HL         ; 1:11      543 *   1  *2 = 6x
    add  HL, BC         ; 1:11      543 *      +1 = 7x 
    add  HL, HL         ; 1:11      543 *   1  *2 = 14x
    add  HL, BC         ; 1:11      543 *      +1 = 15x 
    add  HL, HL         ; 1:11      543 *   1  *2 = 30x
    add  HL, BC         ; 1:11      543 *      +1 = 31x 
    add   A, H          ; 1:4       543 *
    ld    H, A          ; 1:4       543 *     [543x] = 31x + 512x  
                        ;[11:86]    545 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0010_0010_0001)  
    ld    B, H          ; 1:4       545 *
    ld    C, L          ; 1:4       545 *   [1x] 
    add  HL, HL         ; 1:11      545 *   2x 
    ld    A, L          ; 1:4       545 *   512x 
    add  HL, HL         ; 1:11      545 *   4x 
    add  HL, HL         ; 1:11      545 *   8x 
    add  HL, HL         ; 1:11      545 *   16x 
    add  HL, HL         ; 1:11      545 *   32x 
    add   A, B          ; 1:4       545 *
    ld    B, A          ; 1:4       545 *   [513x] 
    add  HL, BC         ; 1:11      545 *   [545x] = 32x + 513x   
                        ;[12:97]    547 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0010_0011)
    ld    B, H          ; 1:4       547 *
    ld    C, L          ; 1:4       547 *   1       1x = base 
    add  HL, HL         ; 1:11      547 *   0  *2 = 2x 
    ld    A, L          ; 1:4       547 *   256*L = 512x 
    add  HL, HL         ; 1:11      547 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      547 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      547 *   1  *2 = 16x
    add  HL, BC         ; 1:11      547 *      +1 = 17x 
    add  HL, HL         ; 1:11      547 *   1  *2 = 34x
    add  HL, BC         ; 1:11      547 *      +1 = 35x 
    add   A, H          ; 1:4       547 *
    ld    H, A          ; 1:4       547 *     [547x] = 35x + 512x  
                        ;[12:97]    549 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0010_0101)
    ld    B, H          ; 1:4       549 *
    ld    C, L          ; 1:4       549 *   1       1x = base 
    add  HL, HL         ; 1:11      549 *   0  *2 = 2x 
    ld    A, L          ; 1:4       549 *   256*L = 512x 
    add  HL, HL         ; 1:11      549 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      549 *   1  *2 = 8x
    add  HL, BC         ; 1:11      549 *      +1 = 9x 
    add  HL, HL         ; 1:11      549 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      549 *   1  *2 = 36x
    add  HL, BC         ; 1:11      549 *      +1 = 37x 
    add   A, H          ; 1:4       549 *
    ld    H, A          ; 1:4       549 *     [549x] = 37x + 512x  
                        ;[13:108]   551 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0010_0111)
    ld    B, H          ; 1:4       551 *
    ld    C, L          ; 1:4       551 *   1       1x = base 
    add  HL, HL         ; 1:11      551 *   0  *2 = 2x 
    ld    A, L          ; 1:4       551 *   256*L = 512x 
    add  HL, HL         ; 1:11      551 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      551 *   1  *2 = 8x
    add  HL, BC         ; 1:11      551 *      +1 = 9x 
    add  HL, HL         ; 1:11      551 *   1  *2 = 18x
    add  HL, BC         ; 1:11      551 *      +1 = 19x 
    add  HL, HL         ; 1:11      551 *   1  *2 = 38x
    add  HL, BC         ; 1:11      551 *      +1 = 39x 
    add   A, H          ; 1:4       551 *
    ld    H, A          ; 1:4       551 *     [551x] = 39x + 512x  
                        ;[12:97]    553 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0010_1001)
    ld    B, H          ; 1:4       553 *
    ld    C, L          ; 1:4       553 *   1       1x = base 
    add  HL, HL         ; 1:11      553 *   0  *2 = 2x 
    ld    A, L          ; 1:4       553 *   256*L = 512x 
    add  HL, HL         ; 1:11      553 *   1  *2 = 4x
    add  HL, BC         ; 1:11      553 *      +1 = 5x 
    add  HL, HL         ; 1:11      553 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      553 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      553 *   1  *2 = 40x
    add  HL, BC         ; 1:11      553 *      +1 = 41x 
    add   A, H          ; 1:4       553 *
    ld    H, A          ; 1:4       553 *     [553x] = 41x + 512x  
                        ;[13:108]   555 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0010_1011)
    ld    B, H          ; 1:4       555 *
    ld    C, L          ; 1:4       555 *   1       1x = base 
    add  HL, HL         ; 1:11      555 *   0  *2 = 2x 
    ld    A, L          ; 1:4       555 *   256*L = 512x 
    add  HL, HL         ; 1:11      555 *   1  *2 = 4x
    add  HL, BC         ; 1:11      555 *      +1 = 5x 
    add  HL, HL         ; 1:11      555 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      555 *   1  *2 = 20x
    add  HL, BC         ; 1:11      555 *      +1 = 21x 
    add  HL, HL         ; 1:11      555 *   1  *2 = 42x
    add  HL, BC         ; 1:11      555 *      +1 = 43x 
    add   A, H          ; 1:4       555 *
    ld    H, A          ; 1:4       555 *     [555x] = 43x + 512x  
                        ;[13:108]   557 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0010_1101)
    ld    B, H          ; 1:4       557 *
    ld    C, L          ; 1:4       557 *   1       1x = base 
    add  HL, HL         ; 1:11      557 *   0  *2 = 2x 
    ld    A, L          ; 1:4       557 *   256*L = 512x 
    add  HL, HL         ; 1:11      557 *   1  *2 = 4x
    add  HL, BC         ; 1:11      557 *      +1 = 5x 
    add  HL, HL         ; 1:11      557 *   1  *2 = 10x
    add  HL, BC         ; 1:11      557 *      +1 = 11x 
    add  HL, HL         ; 1:11      557 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      557 *   1  *2 = 44x
    add  HL, BC         ; 1:11      557 *      +1 = 45x 
    add   A, H          ; 1:4       557 *
    ld    H, A          ; 1:4       557 *     [557x] = 45x + 512x  
                        ;[14:119]   559 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0010_1111)
    ld    B, H          ; 1:4       559 *
    ld    C, L          ; 1:4       559 *   1       1x = base 
    add  HL, HL         ; 1:11      559 *   0  *2 = 2x 
    ld    A, L          ; 1:4       559 *   256*L = 512x 
    add  HL, HL         ; 1:11      559 *   1  *2 = 4x
    add  HL, BC         ; 1:11      559 *      +1 = 5x 
    add  HL, HL         ; 1:11      559 *   1  *2 = 10x
    add  HL, BC         ; 1:11      559 *      +1 = 11x 
    add  HL, HL         ; 1:11      559 *   1  *2 = 22x
    add  HL, BC         ; 1:11      559 *      +1 = 23x 
    add  HL, HL         ; 1:11      559 *   1  *2 = 46x
    add  HL, BC         ; 1:11      559 *      +1 = 47x 
    add   A, H          ; 1:4       559 *
    ld    H, A          ; 1:4       559 *     [559x] = 47x + 512x  
                        ;[12:97]    561 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0011_0001)
    ld    B, H          ; 1:4       561 *
    ld    C, L          ; 1:4       561 *   1       1x = base 
    add  HL, HL         ; 1:11      561 *   1  *2 = 2x
    ld    A, L          ; 1:4       561 *   256*L = 512x
    add  HL, BC         ; 1:11      561 *      +1 = 3x 
    add  HL, HL         ; 1:11      561 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      561 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      561 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      561 *   1  *2 = 48x
    add  HL, BC         ; 1:11      561 *      +1 = 49x 
    add   A, H          ; 1:4       561 *
    ld    H, A          ; 1:4       561 *     [561x] = 49x + 512x 

                        ;[13:108]   563 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0011_0011)
    ld    B, H          ; 1:4       563 *
    ld    C, L          ; 1:4       563 *   1       1x = base 
    add  HL, HL         ; 1:11      563 *   1  *2 = 2x
    ld    A, L          ; 1:4       563 *   256*L = 512x
    add  HL, BC         ; 1:11      563 *      +1 = 3x 
    add  HL, HL         ; 1:11      563 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      563 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      563 *   1  *2 = 24x
    add  HL, BC         ; 1:11      563 *      +1 = 25x 
    add  HL, HL         ; 1:11      563 *   1  *2 = 50x
    add  HL, BC         ; 1:11      563 *      +1 = 51x 
    add   A, H          ; 1:4       563 *
    ld    H, A          ; 1:4       563 *     [563x] = 51x + 512x  
                        ;[13:108]   565 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0011_0101)
    ld    B, H          ; 1:4       565 *
    ld    C, L          ; 1:4       565 *   1       1x = base 
    add  HL, HL         ; 1:11      565 *   1  *2 = 2x
    ld    A, L          ; 1:4       565 *   256*L = 512x
    add  HL, BC         ; 1:11      565 *      +1 = 3x 
    add  HL, HL         ; 1:11      565 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      565 *   1  *2 = 12x
    add  HL, BC         ; 1:11      565 *      +1 = 13x 
    add  HL, HL         ; 1:11      565 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      565 *   1  *2 = 52x
    add  HL, BC         ; 1:11      565 *      +1 = 53x 
    add   A, H          ; 1:4       565 *
    ld    H, A          ; 1:4       565 *     [565x] = 53x + 512x  
                        ;[14:119]   567 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0011_0111)
    ld    B, H          ; 1:4       567 *
    ld    C, L          ; 1:4       567 *   1       1x = base 
    add  HL, HL         ; 1:11      567 *   1  *2 = 2x
    ld    A, L          ; 1:4       567 *   256*L = 512x
    add  HL, BC         ; 1:11      567 *      +1 = 3x 
    add  HL, HL         ; 1:11      567 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      567 *   1  *2 = 12x
    add  HL, BC         ; 1:11      567 *      +1 = 13x 
    add  HL, HL         ; 1:11      567 *   1  *2 = 26x
    add  HL, BC         ; 1:11      567 *      +1 = 27x 
    add  HL, HL         ; 1:11      567 *   1  *2 = 54x
    add  HL, BC         ; 1:11      567 *      +1 = 55x 
    add   A, H          ; 1:4       567 *
    ld    H, A          ; 1:4       567 *     [567x] = 55x + 512x  
                        ;[13:108]   569 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0011_1001)
    ld    B, H          ; 1:4       569 *
    ld    C, L          ; 1:4       569 *   1       1x = base 
    add  HL, HL         ; 1:11      569 *   1  *2 = 2x
    ld    A, L          ; 1:4       569 *   256*L = 512x
    add  HL, BC         ; 1:11      569 *      +1 = 3x 
    add  HL, HL         ; 1:11      569 *   1  *2 = 6x
    add  HL, BC         ; 1:11      569 *      +1 = 7x 
    add  HL, HL         ; 1:11      569 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      569 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      569 *   1  *2 = 56x
    add  HL, BC         ; 1:11      569 *      +1 = 57x 
    add   A, H          ; 1:4       569 *
    ld    H, A          ; 1:4       569 *     [569x] = 57x + 512x  
                        ;[14:119]   571 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0011_1011)
    ld    B, H          ; 1:4       571 *
    ld    C, L          ; 1:4       571 *   1       1x = base 
    add  HL, HL         ; 1:11      571 *   1  *2 = 2x
    ld    A, L          ; 1:4       571 *   256*L = 512x
    add  HL, BC         ; 1:11      571 *      +1 = 3x 
    add  HL, HL         ; 1:11      571 *   1  *2 = 6x
    add  HL, BC         ; 1:11      571 *      +1 = 7x 
    add  HL, HL         ; 1:11      571 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      571 *   1  *2 = 28x
    add  HL, BC         ; 1:11      571 *      +1 = 29x 
    add  HL, HL         ; 1:11      571 *   1  *2 = 58x
    add  HL, BC         ; 1:11      571 *      +1 = 59x 
    add   A, H          ; 1:4       571 *
    ld    H, A          ; 1:4       571 *     [571x] = 59x + 512x  
                        ;[14:119]   573 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0011_1101)
    ld    B, H          ; 1:4       573 *
    ld    C, L          ; 1:4       573 *   1       1x = base 
    add  HL, HL         ; 1:11      573 *   1  *2 = 2x
    ld    A, L          ; 1:4       573 *   256*L = 512x
    add  HL, BC         ; 1:11      573 *      +1 = 3x 
    add  HL, HL         ; 1:11      573 *   1  *2 = 6x
    add  HL, BC         ; 1:11      573 *      +1 = 7x 
    add  HL, HL         ; 1:11      573 *   1  *2 = 14x
    add  HL, BC         ; 1:11      573 *      +1 = 15x 
    add  HL, HL         ; 1:11      573 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      573 *   1  *2 = 60x
    add  HL, BC         ; 1:11      573 *      +1 = 61x 
    add   A, H          ; 1:4       573 *
    ld    H, A          ; 1:4       573 *     [573x] = 61x + 512x  
                        ;[15:130]   575 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0011_1111)
    ld    B, H          ; 1:4       575 *
    ld    C, L          ; 1:4       575 *   1       1x = base 
    add  HL, HL         ; 1:11      575 *   1  *2 = 2x
    ld    A, L          ; 1:4       575 *   256*L = 512x
    add  HL, BC         ; 1:11      575 *      +1 = 3x 
    add  HL, HL         ; 1:11      575 *   1  *2 = 6x
    add  HL, BC         ; 1:11      575 *      +1 = 7x 
    add  HL, HL         ; 1:11      575 *   1  *2 = 14x
    add  HL, BC         ; 1:11      575 *      +1 = 15x 
    add  HL, HL         ; 1:11      575 *   1  *2 = 30x
    add  HL, BC         ; 1:11      575 *      +1 = 31x 
    add  HL, HL         ; 1:11      575 *   1  *2 = 62x
    add  HL, BC         ; 1:11      575 *      +1 = 63x 
    add   A, H          ; 1:4       575 *
    ld    H, A          ; 1:4       575 *     [575x] = 63x + 512x  
                        ;[12:97]    577 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0010_0100_0001)  
    ld    B, H          ; 1:4       577 *
    ld    C, L          ; 1:4       577 *   [1x] 
    add  HL, HL         ; 1:11      577 *   2x 
    ld    A, L          ; 1:4       577 *   512x 
    add  HL, HL         ; 1:11      577 *   4x 
    add  HL, HL         ; 1:11      577 *   8x 
    add  HL, HL         ; 1:11      577 *   16x 
    add  HL, HL         ; 1:11      577 *   32x 
    add  HL, HL         ; 1:11      577 *   64x 
    add   A, B          ; 1:4       577 *
    ld    B, A          ; 1:4       577 *   [513x] 
    add  HL, BC         ; 1:11      577 *   [577x] = 64x + 513x   
                        ;[13:108]   579 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0100_0011)
    ld    B, H          ; 1:4       579 *
    ld    C, L          ; 1:4       579 *   1       1x = base 
    add  HL, HL         ; 1:11      579 *   0  *2 = 2x 
    ld    A, L          ; 1:4       579 *   256*L = 512x 
    add  HL, HL         ; 1:11      579 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      579 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      579 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      579 *   1  *2 = 32x
    add  HL, BC         ; 1:11      579 *      +1 = 33x 
    add  HL, HL         ; 1:11      579 *   1  *2 = 66x
    add  HL, BC         ; 1:11      579 *      +1 = 67x 
    add   A, H          ; 1:4       579 *
    ld    H, A          ; 1:4       579 *     [579x] = 67x + 512x  
                        ;[13:108]   581 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0100_0101)
    ld    B, H          ; 1:4       581 *
    ld    C, L          ; 1:4       581 *   1       1x = base 
    add  HL, HL         ; 1:11      581 *   0  *2 = 2x 
    ld    A, L          ; 1:4       581 *   256*L = 512x 
    add  HL, HL         ; 1:11      581 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      581 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      581 *   1  *2 = 16x
    add  HL, BC         ; 1:11      581 *      +1 = 17x 
    add  HL, HL         ; 1:11      581 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      581 *   1  *2 = 68x
    add  HL, BC         ; 1:11      581 *      +1 = 69x 
    add   A, H          ; 1:4       581 *
    ld    H, A          ; 1:4       581 *     [581x] = 69x + 512x  
                        ;[14:119]   583 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0100_0111)
    ld    B, H          ; 1:4       583 *
    ld    C, L          ; 1:4       583 *   1       1x = base 
    add  HL, HL         ; 1:11      583 *   0  *2 = 2x 
    ld    A, L          ; 1:4       583 *   256*L = 512x 
    add  HL, HL         ; 1:11      583 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      583 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      583 *   1  *2 = 16x
    add  HL, BC         ; 1:11      583 *      +1 = 17x 
    add  HL, HL         ; 1:11      583 *   1  *2 = 34x
    add  HL, BC         ; 1:11      583 *      +1 = 35x 
    add  HL, HL         ; 1:11      583 *   1  *2 = 70x
    add  HL, BC         ; 1:11      583 *      +1 = 71x 
    add   A, H          ; 1:4       583 *
    ld    H, A          ; 1:4       583 *     [583x] = 71x + 512x 

                        ;[13:108]   585 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0100_1001)
    ld    B, H          ; 1:4       585 *
    ld    C, L          ; 1:4       585 *   1       1x = base 
    add  HL, HL         ; 1:11      585 *   0  *2 = 2x 
    ld    A, L          ; 1:4       585 *   256*L = 512x 
    add  HL, HL         ; 1:11      585 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      585 *   1  *2 = 8x
    add  HL, BC         ; 1:11      585 *      +1 = 9x 
    add  HL, HL         ; 1:11      585 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      585 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      585 *   1  *2 = 72x
    add  HL, BC         ; 1:11      585 *      +1 = 73x 
    add   A, H          ; 1:4       585 *
    ld    H, A          ; 1:4       585 *     [585x] = 73x + 512x  
                        ;[14:119]   587 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0100_1011)
    ld    B, H          ; 1:4       587 *
    ld    C, L          ; 1:4       587 *   1       1x = base 
    add  HL, HL         ; 1:11      587 *   0  *2 = 2x 
    ld    A, L          ; 1:4       587 *   256*L = 512x 
    add  HL, HL         ; 1:11      587 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      587 *   1  *2 = 8x
    add  HL, BC         ; 1:11      587 *      +1 = 9x 
    add  HL, HL         ; 1:11      587 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      587 *   1  *2 = 36x
    add  HL, BC         ; 1:11      587 *      +1 = 37x 
    add  HL, HL         ; 1:11      587 *   1  *2 = 74x
    add  HL, BC         ; 1:11      587 *      +1 = 75x 
    add   A, H          ; 1:4       587 *
    ld    H, A          ; 1:4       587 *     [587x] = 75x + 512x  
                        ;[14:119]   589 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0100_1101)
    ld    B, H          ; 1:4       589 *
    ld    C, L          ; 1:4       589 *   1       1x = base 
    add  HL, HL         ; 1:11      589 *   0  *2 = 2x 
    ld    A, L          ; 1:4       589 *   256*L = 512x 
    add  HL, HL         ; 1:11      589 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      589 *   1  *2 = 8x
    add  HL, BC         ; 1:11      589 *      +1 = 9x 
    add  HL, HL         ; 1:11      589 *   1  *2 = 18x
    add  HL, BC         ; 1:11      589 *      +1 = 19x 
    add  HL, HL         ; 1:11      589 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      589 *   1  *2 = 76x
    add  HL, BC         ; 1:11      589 *      +1 = 77x 
    add   A, H          ; 1:4       589 *
    ld    H, A          ; 1:4       589 *     [589x] = 77x + 512x  
                        ;[15:130]   591 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0100_1111)
    ld    B, H          ; 1:4       591 *
    ld    C, L          ; 1:4       591 *   1       1x = base 
    add  HL, HL         ; 1:11      591 *   0  *2 = 2x 
    ld    A, L          ; 1:4       591 *   256*L = 512x 
    add  HL, HL         ; 1:11      591 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      591 *   1  *2 = 8x
    add  HL, BC         ; 1:11      591 *      +1 = 9x 
    add  HL, HL         ; 1:11      591 *   1  *2 = 18x
    add  HL, BC         ; 1:11      591 *      +1 = 19x 
    add  HL, HL         ; 1:11      591 *   1  *2 = 38x
    add  HL, BC         ; 1:11      591 *      +1 = 39x 
    add  HL, HL         ; 1:11      591 *   1  *2 = 78x
    add  HL, BC         ; 1:11      591 *      +1 = 79x 
    add   A, H          ; 1:4       591 *
    ld    H, A          ; 1:4       591 *     [591x] = 79x + 512x  
                        ;[13:108]   593 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0101_0001)
    ld    B, H          ; 1:4       593 *
    ld    C, L          ; 1:4       593 *   1       1x = base 
    add  HL, HL         ; 1:11      593 *   0  *2 = 2x 
    ld    A, L          ; 1:4       593 *   256*L = 512x 
    add  HL, HL         ; 1:11      593 *   1  *2 = 4x
    add  HL, BC         ; 1:11      593 *      +1 = 5x 
    add  HL, HL         ; 1:11      593 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      593 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      593 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      593 *   1  *2 = 80x
    add  HL, BC         ; 1:11      593 *      +1 = 81x 
    add   A, H          ; 1:4       593 *
    ld    H, A          ; 1:4       593 *     [593x] = 81x + 512x  
                        ;[14:119]   595 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0101_0011)
    ld    B, H          ; 1:4       595 *
    ld    C, L          ; 1:4       595 *   1       1x = base 
    add  HL, HL         ; 1:11      595 *   0  *2 = 2x 
    ld    A, L          ; 1:4       595 *   256*L = 512x 
    add  HL, HL         ; 1:11      595 *   1  *2 = 4x
    add  HL, BC         ; 1:11      595 *      +1 = 5x 
    add  HL, HL         ; 1:11      595 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      595 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      595 *   1  *2 = 40x
    add  HL, BC         ; 1:11      595 *      +1 = 41x 
    add  HL, HL         ; 1:11      595 *   1  *2 = 82x
    add  HL, BC         ; 1:11      595 *      +1 = 83x 
    add   A, H          ; 1:4       595 *
    ld    H, A          ; 1:4       595 *     [595x] = 83x + 512x  
                        ;[14:119]   597 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0101_0101)
    ld    B, H          ; 1:4       597 *
    ld    C, L          ; 1:4       597 *   1       1x = base 
    add  HL, HL         ; 1:11      597 *   0  *2 = 2x 
    ld    A, L          ; 1:4       597 *   256*L = 512x 
    add  HL, HL         ; 1:11      597 *   1  *2 = 4x
    add  HL, BC         ; 1:11      597 *      +1 = 5x 
    add  HL, HL         ; 1:11      597 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      597 *   1  *2 = 20x
    add  HL, BC         ; 1:11      597 *      +1 = 21x 
    add  HL, HL         ; 1:11      597 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      597 *   1  *2 = 84x
    add  HL, BC         ; 1:11      597 *      +1 = 85x 
    add   A, H          ; 1:4       597 *
    ld    H, A          ; 1:4       597 *     [597x] = 85x + 512x  
                        ;[15:130]   599 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0101_0111)
    ld    B, H          ; 1:4       599 *
    ld    C, L          ; 1:4       599 *   1       1x = base 
    add  HL, HL         ; 1:11      599 *   0  *2 = 2x 
    ld    A, L          ; 1:4       599 *   256*L = 512x 
    add  HL, HL         ; 1:11      599 *   1  *2 = 4x
    add  HL, BC         ; 1:11      599 *      +1 = 5x 
    add  HL, HL         ; 1:11      599 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      599 *   1  *2 = 20x
    add  HL, BC         ; 1:11      599 *      +1 = 21x 
    add  HL, HL         ; 1:11      599 *   1  *2 = 42x
    add  HL, BC         ; 1:11      599 *      +1 = 43x 
    add  HL, HL         ; 1:11      599 *   1  *2 = 86x
    add  HL, BC         ; 1:11      599 *      +1 = 87x 
    add   A, H          ; 1:4       599 *
    ld    H, A          ; 1:4       599 *     [599x] = 87x + 512x  
                        ;[14:119]   601 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0101_1001)
    ld    B, H          ; 1:4       601 *
    ld    C, L          ; 1:4       601 *   1       1x = base 
    add  HL, HL         ; 1:11      601 *   0  *2 = 2x 
    ld    A, L          ; 1:4       601 *   256*L = 512x 
    add  HL, HL         ; 1:11      601 *   1  *2 = 4x
    add  HL, BC         ; 1:11      601 *      +1 = 5x 
    add  HL, HL         ; 1:11      601 *   1  *2 = 10x
    add  HL, BC         ; 1:11      601 *      +1 = 11x 
    add  HL, HL         ; 1:11      601 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      601 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      601 *   1  *2 = 88x
    add  HL, BC         ; 1:11      601 *      +1 = 89x 
    add   A, H          ; 1:4       601 *
    ld    H, A          ; 1:4       601 *     [601x] = 89x + 512x  
                        ;[15:130]   603 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0101_1011)
    ld    B, H          ; 1:4       603 *
    ld    C, L          ; 1:4       603 *   1       1x = base 
    add  HL, HL         ; 1:11      603 *   0  *2 = 2x 
    ld    A, L          ; 1:4       603 *   256*L = 512x 
    add  HL, HL         ; 1:11      603 *   1  *2 = 4x
    add  HL, BC         ; 1:11      603 *      +1 = 5x 
    add  HL, HL         ; 1:11      603 *   1  *2 = 10x
    add  HL, BC         ; 1:11      603 *      +1 = 11x 
    add  HL, HL         ; 1:11      603 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      603 *   1  *2 = 44x
    add  HL, BC         ; 1:11      603 *      +1 = 45x 
    add  HL, HL         ; 1:11      603 *   1  *2 = 90x
    add  HL, BC         ; 1:11      603 *      +1 = 91x 
    add   A, H          ; 1:4       603 *
    ld    H, A          ; 1:4       603 *     [603x] = 91x + 512x  
                        ;[15:130]   605 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0101_1101)
    ld    B, H          ; 1:4       605 *
    ld    C, L          ; 1:4       605 *   1       1x = base 
    add  HL, HL         ; 1:11      605 *   0  *2 = 2x 
    ld    A, L          ; 1:4       605 *   256*L = 512x 
    add  HL, HL         ; 1:11      605 *   1  *2 = 4x
    add  HL, BC         ; 1:11      605 *      +1 = 5x 
    add  HL, HL         ; 1:11      605 *   1  *2 = 10x
    add  HL, BC         ; 1:11      605 *      +1 = 11x 
    add  HL, HL         ; 1:11      605 *   1  *2 = 22x
    add  HL, BC         ; 1:11      605 *      +1 = 23x 
    add  HL, HL         ; 1:11      605 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      605 *   1  *2 = 92x
    add  HL, BC         ; 1:11      605 *      +1 = 93x 
    add   A, H          ; 1:4       605 *
    ld    H, A          ; 1:4       605 *     [605x] = 93x + 512x 

                        ;[16:141]   607 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0101_1111)
    ld    B, H          ; 1:4       607 *
    ld    C, L          ; 1:4       607 *   1       1x = base 
    add  HL, HL         ; 1:11      607 *   0  *2 = 2x 
    ld    A, L          ; 1:4       607 *   256*L = 512x 
    add  HL, HL         ; 1:11      607 *   1  *2 = 4x
    add  HL, BC         ; 1:11      607 *      +1 = 5x 
    add  HL, HL         ; 1:11      607 *   1  *2 = 10x
    add  HL, BC         ; 1:11      607 *      +1 = 11x 
    add  HL, HL         ; 1:11      607 *   1  *2 = 22x
    add  HL, BC         ; 1:11      607 *      +1 = 23x 
    add  HL, HL         ; 1:11      607 *   1  *2 = 46x
    add  HL, BC         ; 1:11      607 *      +1 = 47x 
    add  HL, HL         ; 1:11      607 *   1  *2 = 94x
    add  HL, BC         ; 1:11      607 *      +1 = 95x 
    add   A, H          ; 1:4       607 *
    ld    H, A          ; 1:4       607 *     [607x] = 95x + 512x  
                        ;[13:108]   609 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0110_0001)
    ld    B, H          ; 1:4       609 *
    ld    C, L          ; 1:4       609 *   1       1x = base 
    add  HL, HL         ; 1:11      609 *   1  *2 = 2x
    ld    A, L          ; 1:4       609 *   256*L = 512x
    add  HL, BC         ; 1:11      609 *      +1 = 3x 
    add  HL, HL         ; 1:11      609 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      609 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      609 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      609 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      609 *   1  *2 = 96x
    add  HL, BC         ; 1:11      609 *      +1 = 97x 
    add   A, H          ; 1:4       609 *
    ld    H, A          ; 1:4       609 *     [609x] = 97x + 512x  
                        ;[14:119]   611 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0110_0011)
    ld    B, H          ; 1:4       611 *
    ld    C, L          ; 1:4       611 *   1       1x = base 
    add  HL, HL         ; 1:11      611 *   1  *2 = 2x
    ld    A, L          ; 1:4       611 *   256*L = 512x
    add  HL, BC         ; 1:11      611 *      +1 = 3x 
    add  HL, HL         ; 1:11      611 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      611 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      611 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      611 *   1  *2 = 48x
    add  HL, BC         ; 1:11      611 *      +1 = 49x 
    add  HL, HL         ; 1:11      611 *   1  *2 = 98x
    add  HL, BC         ; 1:11      611 *      +1 = 99x 
    add   A, H          ; 1:4       611 *
    ld    H, A          ; 1:4       611 *     [611x] = 99x + 512x  
                        ;[14:119]   613 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0110_0101)
    ld    B, H          ; 1:4       613 *
    ld    C, L          ; 1:4       613 *   1       1x = base 
    add  HL, HL         ; 1:11      613 *   1  *2 = 2x
    ld    A, L          ; 1:4       613 *   256*L = 512x
    add  HL, BC         ; 1:11      613 *      +1 = 3x 
    add  HL, HL         ; 1:11      613 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      613 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      613 *   1  *2 = 24x
    add  HL, BC         ; 1:11      613 *      +1 = 25x 
    add  HL, HL         ; 1:11      613 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      613 *   1  *2 = 100x
    add  HL, BC         ; 1:11      613 *      +1 = 101x 
    add   A, H          ; 1:4       613 *
    ld    H, A          ; 1:4       613 *     [613x] = 101x + 512x  
                        ;[15:130]   615 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0110_0111)
    ld    B, H          ; 1:4       615 *
    ld    C, L          ; 1:4       615 *   1       1x = base 
    add  HL, HL         ; 1:11      615 *   1  *2 = 2x
    ld    A, L          ; 1:4       615 *   256*L = 512x
    add  HL, BC         ; 1:11      615 *      +1 = 3x 
    add  HL, HL         ; 1:11      615 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      615 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      615 *   1  *2 = 24x
    add  HL, BC         ; 1:11      615 *      +1 = 25x 
    add  HL, HL         ; 1:11      615 *   1  *2 = 50x
    add  HL, BC         ; 1:11      615 *      +1 = 51x 
    add  HL, HL         ; 1:11      615 *   1  *2 = 102x
    add  HL, BC         ; 1:11      615 *      +1 = 103x 
    add   A, H          ; 1:4       615 *
    ld    H, A          ; 1:4       615 *     [615x] = 103x + 512x  
                        ;[14:119]   617 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0110_1001)
    ld    B, H          ; 1:4       617 *
    ld    C, L          ; 1:4       617 *   1       1x = base 
    add  HL, HL         ; 1:11      617 *   1  *2 = 2x
    ld    A, L          ; 1:4       617 *   256*L = 512x
    add  HL, BC         ; 1:11      617 *      +1 = 3x 
    add  HL, HL         ; 1:11      617 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      617 *   1  *2 = 12x
    add  HL, BC         ; 1:11      617 *      +1 = 13x 
    add  HL, HL         ; 1:11      617 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      617 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      617 *   1  *2 = 104x
    add  HL, BC         ; 1:11      617 *      +1 = 105x 
    add   A, H          ; 1:4       617 *
    ld    H, A          ; 1:4       617 *     [617x] = 105x + 512x  
                        ;[15:130]   619 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0110_1011)
    ld    B, H          ; 1:4       619 *
    ld    C, L          ; 1:4       619 *   1       1x = base 
    add  HL, HL         ; 1:11      619 *   1  *2 = 2x
    ld    A, L          ; 1:4       619 *   256*L = 512x
    add  HL, BC         ; 1:11      619 *      +1 = 3x 
    add  HL, HL         ; 1:11      619 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      619 *   1  *2 = 12x
    add  HL, BC         ; 1:11      619 *      +1 = 13x 
    add  HL, HL         ; 1:11      619 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      619 *   1  *2 = 52x
    add  HL, BC         ; 1:11      619 *      +1 = 53x 
    add  HL, HL         ; 1:11      619 *   1  *2 = 106x
    add  HL, BC         ; 1:11      619 *      +1 = 107x 
    add   A, H          ; 1:4       619 *
    ld    H, A          ; 1:4       619 *     [619x] = 107x + 512x  
                        ;[15:130]   621 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0110_1101)
    ld    B, H          ; 1:4       621 *
    ld    C, L          ; 1:4       621 *   1       1x = base 
    add  HL, HL         ; 1:11      621 *   1  *2 = 2x
    ld    A, L          ; 1:4       621 *   256*L = 512x
    add  HL, BC         ; 1:11      621 *      +1 = 3x 
    add  HL, HL         ; 1:11      621 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      621 *   1  *2 = 12x
    add  HL, BC         ; 1:11      621 *      +1 = 13x 
    add  HL, HL         ; 1:11      621 *   1  *2 = 26x
    add  HL, BC         ; 1:11      621 *      +1 = 27x 
    add  HL, HL         ; 1:11      621 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      621 *   1  *2 = 108x
    add  HL, BC         ; 1:11      621 *      +1 = 109x 
    add   A, H          ; 1:4       621 *
    ld    H, A          ; 1:4       621 *     [621x] = 109x + 512x  
                        ;[16:141]   623 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0110_1111)
    ld    B, H          ; 1:4       623 *
    ld    C, L          ; 1:4       623 *   1       1x = base 
    add  HL, HL         ; 1:11      623 *   1  *2 = 2x
    ld    A, L          ; 1:4       623 *   256*L = 512x
    add  HL, BC         ; 1:11      623 *      +1 = 3x 
    add  HL, HL         ; 1:11      623 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      623 *   1  *2 = 12x
    add  HL, BC         ; 1:11      623 *      +1 = 13x 
    add  HL, HL         ; 1:11      623 *   1  *2 = 26x
    add  HL, BC         ; 1:11      623 *      +1 = 27x 
    add  HL, HL         ; 1:11      623 *   1  *2 = 54x
    add  HL, BC         ; 1:11      623 *      +1 = 55x 
    add  HL, HL         ; 1:11      623 *   1  *2 = 110x
    add  HL, BC         ; 1:11      623 *      +1 = 111x 
    add   A, H          ; 1:4       623 *
    ld    H, A          ; 1:4       623 *     [623x] = 111x + 512x  
                        ;[14:119]   625 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0111_0001)
    ld    B, H          ; 1:4       625 *
    ld    C, L          ; 1:4       625 *   1       1x = base 
    add  HL, HL         ; 1:11      625 *   1  *2 = 2x
    ld    A, L          ; 1:4       625 *   256*L = 512x
    add  HL, BC         ; 1:11      625 *      +1 = 3x 
    add  HL, HL         ; 1:11      625 *   1  *2 = 6x
    add  HL, BC         ; 1:11      625 *      +1 = 7x 
    add  HL, HL         ; 1:11      625 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      625 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      625 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      625 *   1  *2 = 112x
    add  HL, BC         ; 1:11      625 *      +1 = 113x 
    add   A, H          ; 1:4       625 *
    ld    H, A          ; 1:4       625 *     [625x] = 113x + 512x  
                        ;[15:130]   627 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0111_0011)
    ld    B, H          ; 1:4       627 *
    ld    C, L          ; 1:4       627 *   1       1x = base 
    add  HL, HL         ; 1:11      627 *   1  *2 = 2x
    ld    A, L          ; 1:4       627 *   256*L = 512x
    add  HL, BC         ; 1:11      627 *      +1 = 3x 
    add  HL, HL         ; 1:11      627 *   1  *2 = 6x
    add  HL, BC         ; 1:11      627 *      +1 = 7x 
    add  HL, HL         ; 1:11      627 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      627 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      627 *   1  *2 = 56x
    add  HL, BC         ; 1:11      627 *      +1 = 57x 
    add  HL, HL         ; 1:11      627 *   1  *2 = 114x
    add  HL, BC         ; 1:11      627 *      +1 = 115x 
    add   A, H          ; 1:4       627 *
    ld    H, A          ; 1:4       627 *     [627x] = 115x + 512x 

                        ;[15:130]   629 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0111_0101)
    ld    B, H          ; 1:4       629 *
    ld    C, L          ; 1:4       629 *   1       1x = base 
    add  HL, HL         ; 1:11      629 *   1  *2 = 2x
    ld    A, L          ; 1:4       629 *   256*L = 512x
    add  HL, BC         ; 1:11      629 *      +1 = 3x 
    add  HL, HL         ; 1:11      629 *   1  *2 = 6x
    add  HL, BC         ; 1:11      629 *      +1 = 7x 
    add  HL, HL         ; 1:11      629 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      629 *   1  *2 = 28x
    add  HL, BC         ; 1:11      629 *      +1 = 29x 
    add  HL, HL         ; 1:11      629 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      629 *   1  *2 = 116x
    add  HL, BC         ; 1:11      629 *      +1 = 117x 
    add   A, H          ; 1:4       629 *
    ld    H, A          ; 1:4       629 *     [629x] = 117x + 512x  
                        ;[16:141]   631 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0111_0111)
    ld    B, H          ; 1:4       631 *
    ld    C, L          ; 1:4       631 *   1       1x = base 
    add  HL, HL         ; 1:11      631 *   1  *2 = 2x
    ld    A, L          ; 1:4       631 *   256*L = 512x
    add  HL, BC         ; 1:11      631 *      +1 = 3x 
    add  HL, HL         ; 1:11      631 *   1  *2 = 6x
    add  HL, BC         ; 1:11      631 *      +1 = 7x 
    add  HL, HL         ; 1:11      631 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      631 *   1  *2 = 28x
    add  HL, BC         ; 1:11      631 *      +1 = 29x 
    add  HL, HL         ; 1:11      631 *   1  *2 = 58x
    add  HL, BC         ; 1:11      631 *      +1 = 59x 
    add  HL, HL         ; 1:11      631 *   1  *2 = 118x
    add  HL, BC         ; 1:11      631 *      +1 = 119x 
    add   A, H          ; 1:4       631 *
    ld    H, A          ; 1:4       631 *     [631x] = 119x + 512x  
                        ;[15:130]   633 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0111_1001)
    ld    B, H          ; 1:4       633 *
    ld    C, L          ; 1:4       633 *   1       1x = base 
    add  HL, HL         ; 1:11      633 *   1  *2 = 2x
    ld    A, L          ; 1:4       633 *   256*L = 512x
    add  HL, BC         ; 1:11      633 *      +1 = 3x 
    add  HL, HL         ; 1:11      633 *   1  *2 = 6x
    add  HL, BC         ; 1:11      633 *      +1 = 7x 
    add  HL, HL         ; 1:11      633 *   1  *2 = 14x
    add  HL, BC         ; 1:11      633 *      +1 = 15x 
    add  HL, HL         ; 1:11      633 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      633 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      633 *   1  *2 = 120x
    add  HL, BC         ; 1:11      633 *      +1 = 121x 
    add   A, H          ; 1:4       633 *
    ld    H, A          ; 1:4       633 *     [633x] = 121x + 512x  
                        ;[16:141]   635 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0111_1011)
    ld    B, H          ; 1:4       635 *
    ld    C, L          ; 1:4       635 *   1       1x = base 
    add  HL, HL         ; 1:11      635 *   1  *2 = 2x
    ld    A, L          ; 1:4       635 *   256*L = 512x
    add  HL, BC         ; 1:11      635 *      +1 = 3x 
    add  HL, HL         ; 1:11      635 *   1  *2 = 6x
    add  HL, BC         ; 1:11      635 *      +1 = 7x 
    add  HL, HL         ; 1:11      635 *   1  *2 = 14x
    add  HL, BC         ; 1:11      635 *      +1 = 15x 
    add  HL, HL         ; 1:11      635 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      635 *   1  *2 = 60x
    add  HL, BC         ; 1:11      635 *      +1 = 61x 
    add  HL, HL         ; 1:11      635 *   1  *2 = 122x
    add  HL, BC         ; 1:11      635 *      +1 = 123x 
    add   A, H          ; 1:4       635 *
    ld    H, A          ; 1:4       635 *     [635x] = 123x + 512x  
                        ;[16:141]   637 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0111_1101)
    ld    B, H          ; 1:4       637 *
    ld    C, L          ; 1:4       637 *   1       1x = base 
    add  HL, HL         ; 1:11      637 *   1  *2 = 2x
    ld    A, L          ; 1:4       637 *   256*L = 512x
    add  HL, BC         ; 1:11      637 *      +1 = 3x 
    add  HL, HL         ; 1:11      637 *   1  *2 = 6x
    add  HL, BC         ; 1:11      637 *      +1 = 7x 
    add  HL, HL         ; 1:11      637 *   1  *2 = 14x
    add  HL, BC         ; 1:11      637 *      +1 = 15x 
    add  HL, HL         ; 1:11      637 *   1  *2 = 30x
    add  HL, BC         ; 1:11      637 *      +1 = 31x 
    add  HL, HL         ; 1:11      637 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      637 *   1  *2 = 124x
    add  HL, BC         ; 1:11      637 *      +1 = 125x 
    add   A, H          ; 1:4       637 *
    ld    H, A          ; 1:4       637 *     [637x] = 125x + 512x  
                        ;[17:152]   639 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_0111_1111)
    ld    B, H          ; 1:4       639 *
    ld    C, L          ; 1:4       639 *   1       1x = base 
    add  HL, HL         ; 1:11      639 *   1  *2 = 2x
    ld    A, L          ; 1:4       639 *   256*L = 512x
    add  HL, BC         ; 1:11      639 *      +1 = 3x 
    add  HL, HL         ; 1:11      639 *   1  *2 = 6x
    add  HL, BC         ; 1:11      639 *      +1 = 7x 
    add  HL, HL         ; 1:11      639 *   1  *2 = 14x
    add  HL, BC         ; 1:11      639 *      +1 = 15x 
    add  HL, HL         ; 1:11      639 *   1  *2 = 30x
    add  HL, BC         ; 1:11      639 *      +1 = 31x 
    add  HL, HL         ; 1:11      639 *   1  *2 = 62x
    add  HL, BC         ; 1:11      639 *      +1 = 63x 
    add  HL, HL         ; 1:11      639 *   1  *2 = 126x
    add  HL, BC         ; 1:11      639 *      +1 = 127x 
    add   A, H          ; 1:4       639 *
    ld    H, A          ; 1:4       639 *     [639x] = 127x + 512x  
                        ;[13:108]   641 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0010_1000_0001)  
    ld    B, H          ; 1:4       641 *
    ld    C, L          ; 1:4       641 *   [1x] 
    add  HL, HL         ; 1:11      641 *   2x 
    ld    A, L          ; 1:4       641 *   512x 
    add  HL, HL         ; 1:11      641 *   4x 
    add  HL, HL         ; 1:11      641 *   8x 
    add  HL, HL         ; 1:11      641 *   16x 
    add  HL, HL         ; 1:11      641 *   32x 
    add  HL, HL         ; 1:11      641 *   64x 
    add  HL, HL         ; 1:11      641 *   128x 
    add   A, B          ; 1:4       641 *
    ld    B, A          ; 1:4       641 *   [513x] 
    add  HL, BC         ; 1:11      641 *   [641x] = 128x + 513x   
                        ;[14:119]   643 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1000_0011)
    ld    B, H          ; 1:4       643 *
    ld    C, L          ; 1:4       643 *   1       1x = base 
    add  HL, HL         ; 1:11      643 *   0  *2 = 2x 
    ld    A, L          ; 1:4       643 *   256*L = 512x 
    add  HL, HL         ; 1:11      643 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      643 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      643 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      643 *   0  *2 = 32x 
    add  HL, HL         ; 1:11      643 *   1  *2 = 64x
    add  HL, BC         ; 1:11      643 *      +1 = 65x 
    add  HL, HL         ; 1:11      643 *   1  *2 = 130x
    add  HL, BC         ; 1:11      643 *      +1 = 131x 
    add   A, H          ; 1:4       643 *
    ld    H, A          ; 1:4       643 *     [643x] = 131x + 512x  
                        ;[14:119]   645 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1000_0101)
    ld    B, H          ; 1:4       645 *
    ld    C, L          ; 1:4       645 *   1       1x = base 
    add  HL, HL         ; 1:11      645 *   0  *2 = 2x 
    ld    A, L          ; 1:4       645 *   256*L = 512x 
    add  HL, HL         ; 1:11      645 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      645 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      645 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      645 *   1  *2 = 32x
    add  HL, BC         ; 1:11      645 *      +1 = 33x 
    add  HL, HL         ; 1:11      645 *   0  *2 = 66x 
    add  HL, HL         ; 1:11      645 *   1  *2 = 132x
    add  HL, BC         ; 1:11      645 *      +1 = 133x 
    add   A, H          ; 1:4       645 *
    ld    H, A          ; 1:4       645 *     [645x] = 133x + 512x  
                        ;[15:130]   647 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1000_0111)
    ld    B, H          ; 1:4       647 *
    ld    C, L          ; 1:4       647 *   1       1x = base 
    add  HL, HL         ; 1:11      647 *   0  *2 = 2x 
    ld    A, L          ; 1:4       647 *   256*L = 512x 
    add  HL, HL         ; 1:11      647 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      647 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      647 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      647 *   1  *2 = 32x
    add  HL, BC         ; 1:11      647 *      +1 = 33x 
    add  HL, HL         ; 1:11      647 *   1  *2 = 66x
    add  HL, BC         ; 1:11      647 *      +1 = 67x 
    add  HL, HL         ; 1:11      647 *   1  *2 = 134x
    add  HL, BC         ; 1:11      647 *      +1 = 135x 
    add   A, H          ; 1:4       647 *
    ld    H, A          ; 1:4       647 *     [647x] = 135x + 512x  
                        ;[14:119]   649 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1000_1001)
    ld    B, H          ; 1:4       649 *
    ld    C, L          ; 1:4       649 *   1       1x = base 
    add  HL, HL         ; 1:11      649 *   0  *2 = 2x 
    ld    A, L          ; 1:4       649 *   256*L = 512x 
    add  HL, HL         ; 1:11      649 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      649 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      649 *   1  *2 = 16x
    add  HL, BC         ; 1:11      649 *      +1 = 17x 
    add  HL, HL         ; 1:11      649 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      649 *   0  *2 = 68x 
    add  HL, HL         ; 1:11      649 *   1  *2 = 136x
    add  HL, BC         ; 1:11      649 *      +1 = 137x 
    add   A, H          ; 1:4       649 *
    ld    H, A          ; 1:4       649 *     [649x] = 137x + 512x 

                        ;[15:130]   651 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1000_1011)
    ld    B, H          ; 1:4       651 *
    ld    C, L          ; 1:4       651 *   1       1x = base 
    add  HL, HL         ; 1:11      651 *   0  *2 = 2x 
    ld    A, L          ; 1:4       651 *   256*L = 512x 
    add  HL, HL         ; 1:11      651 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      651 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      651 *   1  *2 = 16x
    add  HL, BC         ; 1:11      651 *      +1 = 17x 
    add  HL, HL         ; 1:11      651 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      651 *   1  *2 = 68x
    add  HL, BC         ; 1:11      651 *      +1 = 69x 
    add  HL, HL         ; 1:11      651 *   1  *2 = 138x
    add  HL, BC         ; 1:11      651 *      +1 = 139x 
    add   A, H          ; 1:4       651 *
    ld    H, A          ; 1:4       651 *     [651x] = 139x + 512x  
                        ;[15:130]   653 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1000_1101)
    ld    B, H          ; 1:4       653 *
    ld    C, L          ; 1:4       653 *   1       1x = base 
    add  HL, HL         ; 1:11      653 *   0  *2 = 2x 
    ld    A, L          ; 1:4       653 *   256*L = 512x 
    add  HL, HL         ; 1:11      653 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      653 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      653 *   1  *2 = 16x
    add  HL, BC         ; 1:11      653 *      +1 = 17x 
    add  HL, HL         ; 1:11      653 *   1  *2 = 34x
    add  HL, BC         ; 1:11      653 *      +1 = 35x 
    add  HL, HL         ; 1:11      653 *   0  *2 = 70x 
    add  HL, HL         ; 1:11      653 *   1  *2 = 140x
    add  HL, BC         ; 1:11      653 *      +1 = 141x 
    add   A, H          ; 1:4       653 *
    ld    H, A          ; 1:4       653 *     [653x] = 141x + 512x  
                        ;[16:141]   655 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1000_1111)
    ld    B, H          ; 1:4       655 *
    ld    C, L          ; 1:4       655 *   1       1x = base 
    add  HL, HL         ; 1:11      655 *   0  *2 = 2x 
    ld    A, L          ; 1:4       655 *   256*L = 512x 
    add  HL, HL         ; 1:11      655 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      655 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      655 *   1  *2 = 16x
    add  HL, BC         ; 1:11      655 *      +1 = 17x 
    add  HL, HL         ; 1:11      655 *   1  *2 = 34x
    add  HL, BC         ; 1:11      655 *      +1 = 35x 
    add  HL, HL         ; 1:11      655 *   1  *2 = 70x
    add  HL, BC         ; 1:11      655 *      +1 = 71x 
    add  HL, HL         ; 1:11      655 *   1  *2 = 142x
    add  HL, BC         ; 1:11      655 *      +1 = 143x 
    add   A, H          ; 1:4       655 *
    ld    H, A          ; 1:4       655 *     [655x] = 143x + 512x  
                        ;[14:119]   657 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1001_0001)
    ld    B, H          ; 1:4       657 *
    ld    C, L          ; 1:4       657 *   1       1x = base 
    add  HL, HL         ; 1:11      657 *   0  *2 = 2x 
    ld    A, L          ; 1:4       657 *   256*L = 512x 
    add  HL, HL         ; 1:11      657 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      657 *   1  *2 = 8x
    add  HL, BC         ; 1:11      657 *      +1 = 9x 
    add  HL, HL         ; 1:11      657 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      657 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      657 *   0  *2 = 72x 
    add  HL, HL         ; 1:11      657 *   1  *2 = 144x
    add  HL, BC         ; 1:11      657 *      +1 = 145x 
    add   A, H          ; 1:4       657 *
    ld    H, A          ; 1:4       657 *     [657x] = 145x + 512x  
                        ;[15:130]   659 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1001_0011)
    ld    B, H          ; 1:4       659 *
    ld    C, L          ; 1:4       659 *   1       1x = base 
    add  HL, HL         ; 1:11      659 *   0  *2 = 2x 
    ld    A, L          ; 1:4       659 *   256*L = 512x 
    add  HL, HL         ; 1:11      659 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      659 *   1  *2 = 8x
    add  HL, BC         ; 1:11      659 *      +1 = 9x 
    add  HL, HL         ; 1:11      659 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      659 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      659 *   1  *2 = 72x
    add  HL, BC         ; 1:11      659 *      +1 = 73x 
    add  HL, HL         ; 1:11      659 *   1  *2 = 146x
    add  HL, BC         ; 1:11      659 *      +1 = 147x 
    add   A, H          ; 1:4       659 *
    ld    H, A          ; 1:4       659 *     [659x] = 147x + 512x  
                        ;[15:130]   661 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1001_0101)
    ld    B, H          ; 1:4       661 *
    ld    C, L          ; 1:4       661 *   1       1x = base 
    add  HL, HL         ; 1:11      661 *   0  *2 = 2x 
    ld    A, L          ; 1:4       661 *   256*L = 512x 
    add  HL, HL         ; 1:11      661 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      661 *   1  *2 = 8x
    add  HL, BC         ; 1:11      661 *      +1 = 9x 
    add  HL, HL         ; 1:11      661 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      661 *   1  *2 = 36x
    add  HL, BC         ; 1:11      661 *      +1 = 37x 
    add  HL, HL         ; 1:11      661 *   0  *2 = 74x 
    add  HL, HL         ; 1:11      661 *   1  *2 = 148x
    add  HL, BC         ; 1:11      661 *      +1 = 149x 
    add   A, H          ; 1:4       661 *
    ld    H, A          ; 1:4       661 *     [661x] = 149x + 512x  
                        ;[16:141]   663 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1001_0111)
    ld    B, H          ; 1:4       663 *
    ld    C, L          ; 1:4       663 *   1       1x = base 
    add  HL, HL         ; 1:11      663 *   0  *2 = 2x 
    ld    A, L          ; 1:4       663 *   256*L = 512x 
    add  HL, HL         ; 1:11      663 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      663 *   1  *2 = 8x
    add  HL, BC         ; 1:11      663 *      +1 = 9x 
    add  HL, HL         ; 1:11      663 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      663 *   1  *2 = 36x
    add  HL, BC         ; 1:11      663 *      +1 = 37x 
    add  HL, HL         ; 1:11      663 *   1  *2 = 74x
    add  HL, BC         ; 1:11      663 *      +1 = 75x 
    add  HL, HL         ; 1:11      663 *   1  *2 = 150x
    add  HL, BC         ; 1:11      663 *      +1 = 151x 
    add   A, H          ; 1:4       663 *
    ld    H, A          ; 1:4       663 *     [663x] = 151x + 512x  
                        ;[15:130]   665 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1001_1001)
    ld    B, H          ; 1:4       665 *
    ld    C, L          ; 1:4       665 *   1       1x = base 
    add  HL, HL         ; 1:11      665 *   0  *2 = 2x 
    ld    A, L          ; 1:4       665 *   256*L = 512x 
    add  HL, HL         ; 1:11      665 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      665 *   1  *2 = 8x
    add  HL, BC         ; 1:11      665 *      +1 = 9x 
    add  HL, HL         ; 1:11      665 *   1  *2 = 18x
    add  HL, BC         ; 1:11      665 *      +1 = 19x 
    add  HL, HL         ; 1:11      665 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      665 *   0  *2 = 76x 
    add  HL, HL         ; 1:11      665 *   1  *2 = 152x
    add  HL, BC         ; 1:11      665 *      +1 = 153x 
    add   A, H          ; 1:4       665 *
    ld    H, A          ; 1:4       665 *     [665x] = 153x + 512x  
                        ;[16:141]   667 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1001_1011)
    ld    B, H          ; 1:4       667 *
    ld    C, L          ; 1:4       667 *   1       1x = base 
    add  HL, HL         ; 1:11      667 *   0  *2 = 2x 
    ld    A, L          ; 1:4       667 *   256*L = 512x 
    add  HL, HL         ; 1:11      667 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      667 *   1  *2 = 8x
    add  HL, BC         ; 1:11      667 *      +1 = 9x 
    add  HL, HL         ; 1:11      667 *   1  *2 = 18x
    add  HL, BC         ; 1:11      667 *      +1 = 19x 
    add  HL, HL         ; 1:11      667 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      667 *   1  *2 = 76x
    add  HL, BC         ; 1:11      667 *      +1 = 77x 
    add  HL, HL         ; 1:11      667 *   1  *2 = 154x
    add  HL, BC         ; 1:11      667 *      +1 = 155x 
    add   A, H          ; 1:4       667 *
    ld    H, A          ; 1:4       667 *     [667x] = 155x + 512x  
                        ;[16:141]   669 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1001_1101)
    ld    B, H          ; 1:4       669 *
    ld    C, L          ; 1:4       669 *   1       1x = base 
    add  HL, HL         ; 1:11      669 *   0  *2 = 2x 
    ld    A, L          ; 1:4       669 *   256*L = 512x 
    add  HL, HL         ; 1:11      669 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      669 *   1  *2 = 8x
    add  HL, BC         ; 1:11      669 *      +1 = 9x 
    add  HL, HL         ; 1:11      669 *   1  *2 = 18x
    add  HL, BC         ; 1:11      669 *      +1 = 19x 
    add  HL, HL         ; 1:11      669 *   1  *2 = 38x
    add  HL, BC         ; 1:11      669 *      +1 = 39x 
    add  HL, HL         ; 1:11      669 *   0  *2 = 78x 
    add  HL, HL         ; 1:11      669 *   1  *2 = 156x
    add  HL, BC         ; 1:11      669 *      +1 = 157x 
    add   A, H          ; 1:4       669 *
    ld    H, A          ; 1:4       669 *     [669x] = 157x + 512x  
                        ;[17:152]   671 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1001_1111)
    ld    B, H          ; 1:4       671 *
    ld    C, L          ; 1:4       671 *   1       1x = base 
    add  HL, HL         ; 1:11      671 *   0  *2 = 2x 
    ld    A, L          ; 1:4       671 *   256*L = 512x 
    add  HL, HL         ; 1:11      671 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      671 *   1  *2 = 8x
    add  HL, BC         ; 1:11      671 *      +1 = 9x 
    add  HL, HL         ; 1:11      671 *   1  *2 = 18x
    add  HL, BC         ; 1:11      671 *      +1 = 19x 
    add  HL, HL         ; 1:11      671 *   1  *2 = 38x
    add  HL, BC         ; 1:11      671 *      +1 = 39x 
    add  HL, HL         ; 1:11      671 *   1  *2 = 78x
    add  HL, BC         ; 1:11      671 *      +1 = 79x 
    add  HL, HL         ; 1:11      671 *   1  *2 = 158x
    add  HL, BC         ; 1:11      671 *      +1 = 159x 
    add   A, H          ; 1:4       671 *
    ld    H, A          ; 1:4       671 *     [671x] = 159x + 512x 

                        ;[14:119]   673 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1010_0001)
    ld    B, H          ; 1:4       673 *
    ld    C, L          ; 1:4       673 *   1       1x = base 
    add  HL, HL         ; 1:11      673 *   0  *2 = 2x 
    ld    A, L          ; 1:4       673 *   256*L = 512x 
    add  HL, HL         ; 1:11      673 *   1  *2 = 4x
    add  HL, BC         ; 1:11      673 *      +1 = 5x 
    add  HL, HL         ; 1:11      673 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      673 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      673 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      673 *   0  *2 = 80x 
    add  HL, HL         ; 1:11      673 *   1  *2 = 160x
    add  HL, BC         ; 1:11      673 *      +1 = 161x 
    add   A, H          ; 1:4       673 *
    ld    H, A          ; 1:4       673 *     [673x] = 161x + 512x  
                        ;[15:130]   675 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1010_0011)
    ld    B, H          ; 1:4       675 *
    ld    C, L          ; 1:4       675 *   1       1x = base 
    add  HL, HL         ; 1:11      675 *   0  *2 = 2x 
    ld    A, L          ; 1:4       675 *   256*L = 512x 
    add  HL, HL         ; 1:11      675 *   1  *2 = 4x
    add  HL, BC         ; 1:11      675 *      +1 = 5x 
    add  HL, HL         ; 1:11      675 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      675 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      675 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      675 *   1  *2 = 80x
    add  HL, BC         ; 1:11      675 *      +1 = 81x 
    add  HL, HL         ; 1:11      675 *   1  *2 = 162x
    add  HL, BC         ; 1:11      675 *      +1 = 163x 
    add   A, H          ; 1:4       675 *
    ld    H, A          ; 1:4       675 *     [675x] = 163x + 512x  
                        ;[15:130]   677 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1010_0101)
    ld    B, H          ; 1:4       677 *
    ld    C, L          ; 1:4       677 *   1       1x = base 
    add  HL, HL         ; 1:11      677 *   0  *2 = 2x 
    ld    A, L          ; 1:4       677 *   256*L = 512x 
    add  HL, HL         ; 1:11      677 *   1  *2 = 4x
    add  HL, BC         ; 1:11      677 *      +1 = 5x 
    add  HL, HL         ; 1:11      677 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      677 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      677 *   1  *2 = 40x
    add  HL, BC         ; 1:11      677 *      +1 = 41x 
    add  HL, HL         ; 1:11      677 *   0  *2 = 82x 
    add  HL, HL         ; 1:11      677 *   1  *2 = 164x
    add  HL, BC         ; 1:11      677 *      +1 = 165x 
    add   A, H          ; 1:4       677 *
    ld    H, A          ; 1:4       677 *     [677x] = 165x + 512x  
                        ;[16:141]   679 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1010_0111)
    ld    B, H          ; 1:4       679 *
    ld    C, L          ; 1:4       679 *   1       1x = base 
    add  HL, HL         ; 1:11      679 *   0  *2 = 2x 
    ld    A, L          ; 1:4       679 *   256*L = 512x 
    add  HL, HL         ; 1:11      679 *   1  *2 = 4x
    add  HL, BC         ; 1:11      679 *      +1 = 5x 
    add  HL, HL         ; 1:11      679 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      679 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      679 *   1  *2 = 40x
    add  HL, BC         ; 1:11      679 *      +1 = 41x 
    add  HL, HL         ; 1:11      679 *   1  *2 = 82x
    add  HL, BC         ; 1:11      679 *      +1 = 83x 
    add  HL, HL         ; 1:11      679 *   1  *2 = 166x
    add  HL, BC         ; 1:11      679 *      +1 = 167x 
    add   A, H          ; 1:4       679 *
    ld    H, A          ; 1:4       679 *     [679x] = 167x + 512x  
                        ;[15:130]   681 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1010_1001)
    ld    B, H          ; 1:4       681 *
    ld    C, L          ; 1:4       681 *   1       1x = base 
    add  HL, HL         ; 1:11      681 *   0  *2 = 2x 
    ld    A, L          ; 1:4       681 *   256*L = 512x 
    add  HL, HL         ; 1:11      681 *   1  *2 = 4x
    add  HL, BC         ; 1:11      681 *      +1 = 5x 
    add  HL, HL         ; 1:11      681 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      681 *   1  *2 = 20x
    add  HL, BC         ; 1:11      681 *      +1 = 21x 
    add  HL, HL         ; 1:11      681 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      681 *   0  *2 = 84x 
    add  HL, HL         ; 1:11      681 *   1  *2 = 168x
    add  HL, BC         ; 1:11      681 *      +1 = 169x 
    add   A, H          ; 1:4       681 *
    ld    H, A          ; 1:4       681 *     [681x] = 169x + 512x  
                        ;[16:141]   683 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1010_1011)
    ld    B, H          ; 1:4       683 *
    ld    C, L          ; 1:4       683 *   1       1x = base 
    add  HL, HL         ; 1:11      683 *   0  *2 = 2x 
    ld    A, L          ; 1:4       683 *   256*L = 512x 
    add  HL, HL         ; 1:11      683 *   1  *2 = 4x
    add  HL, BC         ; 1:11      683 *      +1 = 5x 
    add  HL, HL         ; 1:11      683 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      683 *   1  *2 = 20x
    add  HL, BC         ; 1:11      683 *      +1 = 21x 
    add  HL, HL         ; 1:11      683 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      683 *   1  *2 = 84x
    add  HL, BC         ; 1:11      683 *      +1 = 85x 
    add  HL, HL         ; 1:11      683 *   1  *2 = 170x
    add  HL, BC         ; 1:11      683 *      +1 = 171x 
    add   A, H          ; 1:4       683 *
    ld    H, A          ; 1:4       683 *     [683x] = 171x + 512x  
                        ;[16:141]   685 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1010_1101)
    ld    B, H          ; 1:4       685 *
    ld    C, L          ; 1:4       685 *   1       1x = base 
    add  HL, HL         ; 1:11      685 *   0  *2 = 2x 
    ld    A, L          ; 1:4       685 *   256*L = 512x 
    add  HL, HL         ; 1:11      685 *   1  *2 = 4x
    add  HL, BC         ; 1:11      685 *      +1 = 5x 
    add  HL, HL         ; 1:11      685 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      685 *   1  *2 = 20x
    add  HL, BC         ; 1:11      685 *      +1 = 21x 
    add  HL, HL         ; 1:11      685 *   1  *2 = 42x
    add  HL, BC         ; 1:11      685 *      +1 = 43x 
    add  HL, HL         ; 1:11      685 *   0  *2 = 86x 
    add  HL, HL         ; 1:11      685 *   1  *2 = 172x
    add  HL, BC         ; 1:11      685 *      +1 = 173x 
    add   A, H          ; 1:4       685 *
    ld    H, A          ; 1:4       685 *     [685x] = 173x + 512x  
                        ;[17:152]   687 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1010_1111)
    ld    B, H          ; 1:4       687 *
    ld    C, L          ; 1:4       687 *   1       1x = base 
    add  HL, HL         ; 1:11      687 *   0  *2 = 2x 
    ld    A, L          ; 1:4       687 *   256*L = 512x 
    add  HL, HL         ; 1:11      687 *   1  *2 = 4x
    add  HL, BC         ; 1:11      687 *      +1 = 5x 
    add  HL, HL         ; 1:11      687 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      687 *   1  *2 = 20x
    add  HL, BC         ; 1:11      687 *      +1 = 21x 
    add  HL, HL         ; 1:11      687 *   1  *2 = 42x
    add  HL, BC         ; 1:11      687 *      +1 = 43x 
    add  HL, HL         ; 1:11      687 *   1  *2 = 86x
    add  HL, BC         ; 1:11      687 *      +1 = 87x 
    add  HL, HL         ; 1:11      687 *   1  *2 = 174x
    add  HL, BC         ; 1:11      687 *      +1 = 175x 
    add   A, H          ; 1:4       687 *
    ld    H, A          ; 1:4       687 *     [687x] = 175x + 512x  
                        ;[15:130]   689 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1011_0001)
    ld    B, H          ; 1:4       689 *
    ld    C, L          ; 1:4       689 *   1       1x = base 
    add  HL, HL         ; 1:11      689 *   0  *2 = 2x 
    ld    A, L          ; 1:4       689 *   256*L = 512x 
    add  HL, HL         ; 1:11      689 *   1  *2 = 4x
    add  HL, BC         ; 1:11      689 *      +1 = 5x 
    add  HL, HL         ; 1:11      689 *   1  *2 = 10x
    add  HL, BC         ; 1:11      689 *      +1 = 11x 
    add  HL, HL         ; 1:11      689 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      689 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      689 *   0  *2 = 88x 
    add  HL, HL         ; 1:11      689 *   1  *2 = 176x
    add  HL, BC         ; 1:11      689 *      +1 = 177x 
    add   A, H          ; 1:4       689 *
    ld    H, A          ; 1:4       689 *     [689x] = 177x + 512x  
                        ;[16:141]   691 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1011_0011)
    ld    B, H          ; 1:4       691 *
    ld    C, L          ; 1:4       691 *   1       1x = base 
    add  HL, HL         ; 1:11      691 *   0  *2 = 2x 
    ld    A, L          ; 1:4       691 *   256*L = 512x 
    add  HL, HL         ; 1:11      691 *   1  *2 = 4x
    add  HL, BC         ; 1:11      691 *      +1 = 5x 
    add  HL, HL         ; 1:11      691 *   1  *2 = 10x
    add  HL, BC         ; 1:11      691 *      +1 = 11x 
    add  HL, HL         ; 1:11      691 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      691 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      691 *   1  *2 = 88x
    add  HL, BC         ; 1:11      691 *      +1 = 89x 
    add  HL, HL         ; 1:11      691 *   1  *2 = 178x
    add  HL, BC         ; 1:11      691 *      +1 = 179x 
    add   A, H          ; 1:4       691 *
    ld    H, A          ; 1:4       691 *     [691x] = 179x + 512x  
                        ;[16:141]   693 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1011_0101)
    ld    B, H          ; 1:4       693 *
    ld    C, L          ; 1:4       693 *   1       1x = base 
    add  HL, HL         ; 1:11      693 *   0  *2 = 2x 
    ld    A, L          ; 1:4       693 *   256*L = 512x 
    add  HL, HL         ; 1:11      693 *   1  *2 = 4x
    add  HL, BC         ; 1:11      693 *      +1 = 5x 
    add  HL, HL         ; 1:11      693 *   1  *2 = 10x
    add  HL, BC         ; 1:11      693 *      +1 = 11x 
    add  HL, HL         ; 1:11      693 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      693 *   1  *2 = 44x
    add  HL, BC         ; 1:11      693 *      +1 = 45x 
    add  HL, HL         ; 1:11      693 *   0  *2 = 90x 
    add  HL, HL         ; 1:11      693 *   1  *2 = 180x
    add  HL, BC         ; 1:11      693 *      +1 = 181x 
    add   A, H          ; 1:4       693 *
    ld    H, A          ; 1:4       693 *     [693x] = 181x + 512x 

                        ;[17:152]   695 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1011_0111)
    ld    B, H          ; 1:4       695 *
    ld    C, L          ; 1:4       695 *   1       1x = base 
    add  HL, HL         ; 1:11      695 *   0  *2 = 2x 
    ld    A, L          ; 1:4       695 *   256*L = 512x 
    add  HL, HL         ; 1:11      695 *   1  *2 = 4x
    add  HL, BC         ; 1:11      695 *      +1 = 5x 
    add  HL, HL         ; 1:11      695 *   1  *2 = 10x
    add  HL, BC         ; 1:11      695 *      +1 = 11x 
    add  HL, HL         ; 1:11      695 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      695 *   1  *2 = 44x
    add  HL, BC         ; 1:11      695 *      +1 = 45x 
    add  HL, HL         ; 1:11      695 *   1  *2 = 90x
    add  HL, BC         ; 1:11      695 *      +1 = 91x 
    add  HL, HL         ; 1:11      695 *   1  *2 = 182x
    add  HL, BC         ; 1:11      695 *      +1 = 183x 
    add   A, H          ; 1:4       695 *
    ld    H, A          ; 1:4       695 *     [695x] = 183x + 512x  
                        ;[16:141]   697 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1011_1001)
    ld    B, H          ; 1:4       697 *
    ld    C, L          ; 1:4       697 *   1       1x = base 
    add  HL, HL         ; 1:11      697 *   0  *2 = 2x 
    ld    A, L          ; 1:4       697 *   256*L = 512x 
    add  HL, HL         ; 1:11      697 *   1  *2 = 4x
    add  HL, BC         ; 1:11      697 *      +1 = 5x 
    add  HL, HL         ; 1:11      697 *   1  *2 = 10x
    add  HL, BC         ; 1:11      697 *      +1 = 11x 
    add  HL, HL         ; 1:11      697 *   1  *2 = 22x
    add  HL, BC         ; 1:11      697 *      +1 = 23x 
    add  HL, HL         ; 1:11      697 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      697 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      697 *   1  *2 = 184x
    add  HL, BC         ; 1:11      697 *      +1 = 185x 
    add   A, H          ; 1:4       697 *
    ld    H, A          ; 1:4       697 *     [697x] = 185x + 512x  
                        ;[17:152]   699 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1011_1011)
    ld    B, H          ; 1:4       699 *
    ld    C, L          ; 1:4       699 *   1       1x = base 
    add  HL, HL         ; 1:11      699 *   0  *2 = 2x 
    ld    A, L          ; 1:4       699 *   256*L = 512x 
    add  HL, HL         ; 1:11      699 *   1  *2 = 4x
    add  HL, BC         ; 1:11      699 *      +1 = 5x 
    add  HL, HL         ; 1:11      699 *   1  *2 = 10x
    add  HL, BC         ; 1:11      699 *      +1 = 11x 
    add  HL, HL         ; 1:11      699 *   1  *2 = 22x
    add  HL, BC         ; 1:11      699 *      +1 = 23x 
    add  HL, HL         ; 1:11      699 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      699 *   1  *2 = 92x
    add  HL, BC         ; 1:11      699 *      +1 = 93x 
    add  HL, HL         ; 1:11      699 *   1  *2 = 186x
    add  HL, BC         ; 1:11      699 *      +1 = 187x 
    add   A, H          ; 1:4       699 *
    ld    H, A          ; 1:4       699 *     [699x] = 187x + 512x  
                        ;[17:152]   701 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1011_1101)
    ld    B, H          ; 1:4       701 *
    ld    C, L          ; 1:4       701 *   1       1x = base 
    add  HL, HL         ; 1:11      701 *   0  *2 = 2x 
    ld    A, L          ; 1:4       701 *   256*L = 512x 
    add  HL, HL         ; 1:11      701 *   1  *2 = 4x
    add  HL, BC         ; 1:11      701 *      +1 = 5x 
    add  HL, HL         ; 1:11      701 *   1  *2 = 10x
    add  HL, BC         ; 1:11      701 *      +1 = 11x 
    add  HL, HL         ; 1:11      701 *   1  *2 = 22x
    add  HL, BC         ; 1:11      701 *      +1 = 23x 
    add  HL, HL         ; 1:11      701 *   1  *2 = 46x
    add  HL, BC         ; 1:11      701 *      +1 = 47x 
    add  HL, HL         ; 1:11      701 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      701 *   1  *2 = 188x
    add  HL, BC         ; 1:11      701 *      +1 = 189x 
    add   A, H          ; 1:4       701 *
    ld    H, A          ; 1:4       701 *     [701x] = 189x + 512x  
                        ;[18:163]   703 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1011_1111)
    ld    B, H          ; 1:4       703 *
    ld    C, L          ; 1:4       703 *   1       1x = base 
    add  HL, HL         ; 1:11      703 *   0  *2 = 2x 
    ld    A, L          ; 1:4       703 *   256*L = 512x 
    add  HL, HL         ; 1:11      703 *   1  *2 = 4x
    add  HL, BC         ; 1:11      703 *      +1 = 5x 
    add  HL, HL         ; 1:11      703 *   1  *2 = 10x
    add  HL, BC         ; 1:11      703 *      +1 = 11x 
    add  HL, HL         ; 1:11      703 *   1  *2 = 22x
    add  HL, BC         ; 1:11      703 *      +1 = 23x 
    add  HL, HL         ; 1:11      703 *   1  *2 = 46x
    add  HL, BC         ; 1:11      703 *      +1 = 47x 
    add  HL, HL         ; 1:11      703 *   1  *2 = 94x
    add  HL, BC         ; 1:11      703 *      +1 = 95x 
    add  HL, HL         ; 1:11      703 *   1  *2 = 190x
    add  HL, BC         ; 1:11      703 *      +1 = 191x 
    add   A, H          ; 1:4       703 *
    ld    H, A          ; 1:4       703 *     [703x] = 191x + 512x  
                        ;[14:119]   705 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1100_0001)
    ld    B, H          ; 1:4       705 *
    ld    C, L          ; 1:4       705 *   1       1x = base 
    add  HL, HL         ; 1:11      705 *   1  *2 = 2x
    ld    A, L          ; 1:4       705 *   256*L = 512x
    add  HL, BC         ; 1:11      705 *      +1 = 3x 
    add  HL, HL         ; 1:11      705 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      705 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      705 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      705 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      705 *   0  *2 = 96x 
    add  HL, HL         ; 1:11      705 *   1  *2 = 192x
    add  HL, BC         ; 1:11      705 *      +1 = 193x 
    add   A, H          ; 1:4       705 *
    ld    H, A          ; 1:4       705 *     [705x] = 193x + 512x  
                        ;[15:130]   707 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1100_0011)
    ld    B, H          ; 1:4       707 *
    ld    C, L          ; 1:4       707 *   1       1x = base 
    add  HL, HL         ; 1:11      707 *   1  *2 = 2x
    ld    A, L          ; 1:4       707 *   256*L = 512x
    add  HL, BC         ; 1:11      707 *      +1 = 3x 
    add  HL, HL         ; 1:11      707 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      707 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      707 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      707 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      707 *   1  *2 = 96x
    add  HL, BC         ; 1:11      707 *      +1 = 97x 
    add  HL, HL         ; 1:11      707 *   1  *2 = 194x
    add  HL, BC         ; 1:11      707 *      +1 = 195x 
    add   A, H          ; 1:4       707 *
    ld    H, A          ; 1:4       707 *     [707x] = 195x + 512x  
                        ;[15:130]   709 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1100_0101)
    ld    B, H          ; 1:4       709 *
    ld    C, L          ; 1:4       709 *   1       1x = base 
    add  HL, HL         ; 1:11      709 *   1  *2 = 2x
    ld    A, L          ; 1:4       709 *   256*L = 512x
    add  HL, BC         ; 1:11      709 *      +1 = 3x 
    add  HL, HL         ; 1:11      709 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      709 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      709 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      709 *   1  *2 = 48x
    add  HL, BC         ; 1:11      709 *      +1 = 49x 
    add  HL, HL         ; 1:11      709 *   0  *2 = 98x 
    add  HL, HL         ; 1:11      709 *   1  *2 = 196x
    add  HL, BC         ; 1:11      709 *      +1 = 197x 
    add   A, H          ; 1:4       709 *
    ld    H, A          ; 1:4       709 *     [709x] = 197x + 512x  
                        ;[16:141]   711 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1100_0111)
    ld    B, H          ; 1:4       711 *
    ld    C, L          ; 1:4       711 *   1       1x = base 
    add  HL, HL         ; 1:11      711 *   1  *2 = 2x
    ld    A, L          ; 1:4       711 *   256*L = 512x
    add  HL, BC         ; 1:11      711 *      +1 = 3x 
    add  HL, HL         ; 1:11      711 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      711 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      711 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      711 *   1  *2 = 48x
    add  HL, BC         ; 1:11      711 *      +1 = 49x 
    add  HL, HL         ; 1:11      711 *   1  *2 = 98x
    add  HL, BC         ; 1:11      711 *      +1 = 99x 
    add  HL, HL         ; 1:11      711 *   1  *2 = 198x
    add  HL, BC         ; 1:11      711 *      +1 = 199x 
    add   A, H          ; 1:4       711 *
    ld    H, A          ; 1:4       711 *     [711x] = 199x + 512x  
                        ;[15:130]   713 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1100_1001)
    ld    B, H          ; 1:4       713 *
    ld    C, L          ; 1:4       713 *   1       1x = base 
    add  HL, HL         ; 1:11      713 *   1  *2 = 2x
    ld    A, L          ; 1:4       713 *   256*L = 512x
    add  HL, BC         ; 1:11      713 *      +1 = 3x 
    add  HL, HL         ; 1:11      713 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      713 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      713 *   1  *2 = 24x
    add  HL, BC         ; 1:11      713 *      +1 = 25x 
    add  HL, HL         ; 1:11      713 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      713 *   0  *2 = 100x 
    add  HL, HL         ; 1:11      713 *   1  *2 = 200x
    add  HL, BC         ; 1:11      713 *      +1 = 201x 
    add   A, H          ; 1:4       713 *
    ld    H, A          ; 1:4       713 *     [713x] = 201x + 512x  
                        ;[16:141]   715 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1100_1011)
    ld    B, H          ; 1:4       715 *
    ld    C, L          ; 1:4       715 *   1       1x = base 
    add  HL, HL         ; 1:11      715 *   1  *2 = 2x
    ld    A, L          ; 1:4       715 *   256*L = 512x
    add  HL, BC         ; 1:11      715 *      +1 = 3x 
    add  HL, HL         ; 1:11      715 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      715 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      715 *   1  *2 = 24x
    add  HL, BC         ; 1:11      715 *      +1 = 25x 
    add  HL, HL         ; 1:11      715 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      715 *   1  *2 = 100x
    add  HL, BC         ; 1:11      715 *      +1 = 101x 
    add  HL, HL         ; 1:11      715 *   1  *2 = 202x
    add  HL, BC         ; 1:11      715 *      +1 = 203x 
    add   A, H          ; 1:4       715 *
    ld    H, A          ; 1:4       715 *     [715x] = 203x + 512x 

                        ;[16:141]   717 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1100_1101)
    ld    B, H          ; 1:4       717 *
    ld    C, L          ; 1:4       717 *   1       1x = base 
    add  HL, HL         ; 1:11      717 *   1  *2 = 2x
    ld    A, L          ; 1:4       717 *   256*L = 512x
    add  HL, BC         ; 1:11      717 *      +1 = 3x 
    add  HL, HL         ; 1:11      717 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      717 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      717 *   1  *2 = 24x
    add  HL, BC         ; 1:11      717 *      +1 = 25x 
    add  HL, HL         ; 1:11      717 *   1  *2 = 50x
    add  HL, BC         ; 1:11      717 *      +1 = 51x 
    add  HL, HL         ; 1:11      717 *   0  *2 = 102x 
    add  HL, HL         ; 1:11      717 *   1  *2 = 204x
    add  HL, BC         ; 1:11      717 *      +1 = 205x 
    add   A, H          ; 1:4       717 *
    ld    H, A          ; 1:4       717 *     [717x] = 205x + 512x  
                        ;[17:152]   719 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1100_1111)
    ld    B, H          ; 1:4       719 *
    ld    C, L          ; 1:4       719 *   1       1x = base 
    add  HL, HL         ; 1:11      719 *   1  *2 = 2x
    ld    A, L          ; 1:4       719 *   256*L = 512x
    add  HL, BC         ; 1:11      719 *      +1 = 3x 
    add  HL, HL         ; 1:11      719 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      719 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      719 *   1  *2 = 24x
    add  HL, BC         ; 1:11      719 *      +1 = 25x 
    add  HL, HL         ; 1:11      719 *   1  *2 = 50x
    add  HL, BC         ; 1:11      719 *      +1 = 51x 
    add  HL, HL         ; 1:11      719 *   1  *2 = 102x
    add  HL, BC         ; 1:11      719 *      +1 = 103x 
    add  HL, HL         ; 1:11      719 *   1  *2 = 206x
    add  HL, BC         ; 1:11      719 *      +1 = 207x 
    add   A, H          ; 1:4       719 *
    ld    H, A          ; 1:4       719 *     [719x] = 207x + 512x  
                        ;[15:130]   721 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1101_0001)
    ld    B, H          ; 1:4       721 *
    ld    C, L          ; 1:4       721 *   1       1x = base 
    add  HL, HL         ; 1:11      721 *   1  *2 = 2x
    ld    A, L          ; 1:4       721 *   256*L = 512x
    add  HL, BC         ; 1:11      721 *      +1 = 3x 
    add  HL, HL         ; 1:11      721 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      721 *   1  *2 = 12x
    add  HL, BC         ; 1:11      721 *      +1 = 13x 
    add  HL, HL         ; 1:11      721 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      721 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      721 *   0  *2 = 104x 
    add  HL, HL         ; 1:11      721 *   1  *2 = 208x
    add  HL, BC         ; 1:11      721 *      +1 = 209x 
    add   A, H          ; 1:4       721 *
    ld    H, A          ; 1:4       721 *     [721x] = 209x + 512x  
                        ;[16:141]   723 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1101_0011)
    ld    B, H          ; 1:4       723 *
    ld    C, L          ; 1:4       723 *   1       1x = base 
    add  HL, HL         ; 1:11      723 *   1  *2 = 2x
    ld    A, L          ; 1:4       723 *   256*L = 512x
    add  HL, BC         ; 1:11      723 *      +1 = 3x 
    add  HL, HL         ; 1:11      723 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      723 *   1  *2 = 12x
    add  HL, BC         ; 1:11      723 *      +1 = 13x 
    add  HL, HL         ; 1:11      723 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      723 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      723 *   1  *2 = 104x
    add  HL, BC         ; 1:11      723 *      +1 = 105x 
    add  HL, HL         ; 1:11      723 *   1  *2 = 210x
    add  HL, BC         ; 1:11      723 *      +1 = 211x 
    add   A, H          ; 1:4       723 *
    ld    H, A          ; 1:4       723 *     [723x] = 211x + 512x  
                        ;[16:141]   725 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1101_0101)
    ld    B, H          ; 1:4       725 *
    ld    C, L          ; 1:4       725 *   1       1x = base 
    add  HL, HL         ; 1:11      725 *   1  *2 = 2x
    ld    A, L          ; 1:4       725 *   256*L = 512x
    add  HL, BC         ; 1:11      725 *      +1 = 3x 
    add  HL, HL         ; 1:11      725 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      725 *   1  *2 = 12x
    add  HL, BC         ; 1:11      725 *      +1 = 13x 
    add  HL, HL         ; 1:11      725 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      725 *   1  *2 = 52x
    add  HL, BC         ; 1:11      725 *      +1 = 53x 
    add  HL, HL         ; 1:11      725 *   0  *2 = 106x 
    add  HL, HL         ; 1:11      725 *   1  *2 = 212x
    add  HL, BC         ; 1:11      725 *      +1 = 213x 
    add   A, H          ; 1:4       725 *
    ld    H, A          ; 1:4       725 *     [725x] = 213x + 512x  
                        ;[17:152]   727 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1101_0111)
    ld    B, H          ; 1:4       727 *
    ld    C, L          ; 1:4       727 *   1       1x = base 
    add  HL, HL         ; 1:11      727 *   1  *2 = 2x
    ld    A, L          ; 1:4       727 *   256*L = 512x
    add  HL, BC         ; 1:11      727 *      +1 = 3x 
    add  HL, HL         ; 1:11      727 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      727 *   1  *2 = 12x
    add  HL, BC         ; 1:11      727 *      +1 = 13x 
    add  HL, HL         ; 1:11      727 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      727 *   1  *2 = 52x
    add  HL, BC         ; 1:11      727 *      +1 = 53x 
    add  HL, HL         ; 1:11      727 *   1  *2 = 106x
    add  HL, BC         ; 1:11      727 *      +1 = 107x 
    add  HL, HL         ; 1:11      727 *   1  *2 = 214x
    add  HL, BC         ; 1:11      727 *      +1 = 215x 
    add   A, H          ; 1:4       727 *
    ld    H, A          ; 1:4       727 *     [727x] = 215x + 512x  
                        ;[16:141]   729 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1101_1001)
    ld    B, H          ; 1:4       729 *
    ld    C, L          ; 1:4       729 *   1       1x = base 
    add  HL, HL         ; 1:11      729 *   1  *2 = 2x
    ld    A, L          ; 1:4       729 *   256*L = 512x
    add  HL, BC         ; 1:11      729 *      +1 = 3x 
    add  HL, HL         ; 1:11      729 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      729 *   1  *2 = 12x
    add  HL, BC         ; 1:11      729 *      +1 = 13x 
    add  HL, HL         ; 1:11      729 *   1  *2 = 26x
    add  HL, BC         ; 1:11      729 *      +1 = 27x 
    add  HL, HL         ; 1:11      729 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      729 *   0  *2 = 108x 
    add  HL, HL         ; 1:11      729 *   1  *2 = 216x
    add  HL, BC         ; 1:11      729 *      +1 = 217x 
    add   A, H          ; 1:4       729 *
    ld    H, A          ; 1:4       729 *     [729x] = 217x + 512x  
                        ;[17:152]   731 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1101_1011)
    ld    B, H          ; 1:4       731 *
    ld    C, L          ; 1:4       731 *   1       1x = base 
    add  HL, HL         ; 1:11      731 *   1  *2 = 2x
    ld    A, L          ; 1:4       731 *   256*L = 512x
    add  HL, BC         ; 1:11      731 *      +1 = 3x 
    add  HL, HL         ; 1:11      731 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      731 *   1  *2 = 12x
    add  HL, BC         ; 1:11      731 *      +1 = 13x 
    add  HL, HL         ; 1:11      731 *   1  *2 = 26x
    add  HL, BC         ; 1:11      731 *      +1 = 27x 
    add  HL, HL         ; 1:11      731 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      731 *   1  *2 = 108x
    add  HL, BC         ; 1:11      731 *      +1 = 109x 
    add  HL, HL         ; 1:11      731 *   1  *2 = 218x
    add  HL, BC         ; 1:11      731 *      +1 = 219x 
    add   A, H          ; 1:4       731 *
    ld    H, A          ; 1:4       731 *     [731x] = 219x + 512x  
                        ;[17:152]   733 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1101_1101)
    ld    B, H          ; 1:4       733 *
    ld    C, L          ; 1:4       733 *   1       1x = base 
    add  HL, HL         ; 1:11      733 *   1  *2 = 2x
    ld    A, L          ; 1:4       733 *   256*L = 512x
    add  HL, BC         ; 1:11      733 *      +1 = 3x 
    add  HL, HL         ; 1:11      733 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      733 *   1  *2 = 12x
    add  HL, BC         ; 1:11      733 *      +1 = 13x 
    add  HL, HL         ; 1:11      733 *   1  *2 = 26x
    add  HL, BC         ; 1:11      733 *      +1 = 27x 
    add  HL, HL         ; 1:11      733 *   1  *2 = 54x
    add  HL, BC         ; 1:11      733 *      +1 = 55x 
    add  HL, HL         ; 1:11      733 *   0  *2 = 110x 
    add  HL, HL         ; 1:11      733 *   1  *2 = 220x
    add  HL, BC         ; 1:11      733 *      +1 = 221x 
    add   A, H          ; 1:4       733 *
    ld    H, A          ; 1:4       733 *     [733x] = 221x + 512x  
                        ;[18:163]   735 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1101_1111)
    ld    B, H          ; 1:4       735 *
    ld    C, L          ; 1:4       735 *   1       1x = base 
    add  HL, HL         ; 1:11      735 *   1  *2 = 2x
    ld    A, L          ; 1:4       735 *   256*L = 512x
    add  HL, BC         ; 1:11      735 *      +1 = 3x 
    add  HL, HL         ; 1:11      735 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      735 *   1  *2 = 12x
    add  HL, BC         ; 1:11      735 *      +1 = 13x 
    add  HL, HL         ; 1:11      735 *   1  *2 = 26x
    add  HL, BC         ; 1:11      735 *      +1 = 27x 
    add  HL, HL         ; 1:11      735 *   1  *2 = 54x
    add  HL, BC         ; 1:11      735 *      +1 = 55x 
    add  HL, HL         ; 1:11      735 *   1  *2 = 110x
    add  HL, BC         ; 1:11      735 *      +1 = 111x 
    add  HL, HL         ; 1:11      735 *   1  *2 = 222x
    add  HL, BC         ; 1:11      735 *      +1 = 223x 
    add   A, H          ; 1:4       735 *
    ld    H, A          ; 1:4       735 *     [735x] = 223x + 512x  
                        ;[15:130]   737 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1110_0001)
    ld    B, H          ; 1:4       737 *
    ld    C, L          ; 1:4       737 *   1       1x = base 
    add  HL, HL         ; 1:11      737 *   1  *2 = 2x
    ld    A, L          ; 1:4       737 *   256*L = 512x
    add  HL, BC         ; 1:11      737 *      +1 = 3x 
    add  HL, HL         ; 1:11      737 *   1  *2 = 6x
    add  HL, BC         ; 1:11      737 *      +1 = 7x 
    add  HL, HL         ; 1:11      737 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      737 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      737 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      737 *   0  *2 = 112x 
    add  HL, HL         ; 1:11      737 *   1  *2 = 224x
    add  HL, BC         ; 1:11      737 *      +1 = 225x 
    add   A, H          ; 1:4       737 *
    ld    H, A          ; 1:4       737 *     [737x] = 225x + 512x 

                        ;[16:141]   739 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1110_0011)
    ld    B, H          ; 1:4       739 *
    ld    C, L          ; 1:4       739 *   1       1x = base 
    add  HL, HL         ; 1:11      739 *   1  *2 = 2x
    ld    A, L          ; 1:4       739 *   256*L = 512x
    add  HL, BC         ; 1:11      739 *      +1 = 3x 
    add  HL, HL         ; 1:11      739 *   1  *2 = 6x
    add  HL, BC         ; 1:11      739 *      +1 = 7x 
    add  HL, HL         ; 1:11      739 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      739 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      739 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      739 *   1  *2 = 112x
    add  HL, BC         ; 1:11      739 *      +1 = 113x 
    add  HL, HL         ; 1:11      739 *   1  *2 = 226x
    add  HL, BC         ; 1:11      739 *      +1 = 227x 
    add   A, H          ; 1:4       739 *
    ld    H, A          ; 1:4       739 *     [739x] = 227x + 512x  
                        ;[16:141]   741 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1110_0101)
    ld    B, H          ; 1:4       741 *
    ld    C, L          ; 1:4       741 *   1       1x = base 
    add  HL, HL         ; 1:11      741 *   1  *2 = 2x
    ld    A, L          ; 1:4       741 *   256*L = 512x
    add  HL, BC         ; 1:11      741 *      +1 = 3x 
    add  HL, HL         ; 1:11      741 *   1  *2 = 6x
    add  HL, BC         ; 1:11      741 *      +1 = 7x 
    add  HL, HL         ; 1:11      741 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      741 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      741 *   1  *2 = 56x
    add  HL, BC         ; 1:11      741 *      +1 = 57x 
    add  HL, HL         ; 1:11      741 *   0  *2 = 114x 
    add  HL, HL         ; 1:11      741 *   1  *2 = 228x
    add  HL, BC         ; 1:11      741 *      +1 = 229x 
    add   A, H          ; 1:4       741 *
    ld    H, A          ; 1:4       741 *     [741x] = 229x + 512x  
                        ;[17:152]   743 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1110_0111)
    ld    B, H          ; 1:4       743 *
    ld    C, L          ; 1:4       743 *   1       1x = base 
    add  HL, HL         ; 1:11      743 *   1  *2 = 2x
    ld    A, L          ; 1:4       743 *   256*L = 512x
    add  HL, BC         ; 1:11      743 *      +1 = 3x 
    add  HL, HL         ; 1:11      743 *   1  *2 = 6x
    add  HL, BC         ; 1:11      743 *      +1 = 7x 
    add  HL, HL         ; 1:11      743 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      743 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      743 *   1  *2 = 56x
    add  HL, BC         ; 1:11      743 *      +1 = 57x 
    add  HL, HL         ; 1:11      743 *   1  *2 = 114x
    add  HL, BC         ; 1:11      743 *      +1 = 115x 
    add  HL, HL         ; 1:11      743 *   1  *2 = 230x
    add  HL, BC         ; 1:11      743 *      +1 = 231x 
    add   A, H          ; 1:4       743 *
    ld    H, A          ; 1:4       743 *     [743x] = 231x + 512x  
                        ;[16:141]   745 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1110_1001)
    ld    B, H          ; 1:4       745 *
    ld    C, L          ; 1:4       745 *   1       1x = base 
    add  HL, HL         ; 1:11      745 *   1  *2 = 2x
    ld    A, L          ; 1:4       745 *   256*L = 512x
    add  HL, BC         ; 1:11      745 *      +1 = 3x 
    add  HL, HL         ; 1:11      745 *   1  *2 = 6x
    add  HL, BC         ; 1:11      745 *      +1 = 7x 
    add  HL, HL         ; 1:11      745 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      745 *   1  *2 = 28x
    add  HL, BC         ; 1:11      745 *      +1 = 29x 
    add  HL, HL         ; 1:11      745 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      745 *   0  *2 = 116x 
    add  HL, HL         ; 1:11      745 *   1  *2 = 232x
    add  HL, BC         ; 1:11      745 *      +1 = 233x 
    add   A, H          ; 1:4       745 *
    ld    H, A          ; 1:4       745 *     [745x] = 233x + 512x  
                        ;[17:152]   747 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1110_1011)
    ld    B, H          ; 1:4       747 *
    ld    C, L          ; 1:4       747 *   1       1x = base 
    add  HL, HL         ; 1:11      747 *   1  *2 = 2x
    ld    A, L          ; 1:4       747 *   256*L = 512x
    add  HL, BC         ; 1:11      747 *      +1 = 3x 
    add  HL, HL         ; 1:11      747 *   1  *2 = 6x
    add  HL, BC         ; 1:11      747 *      +1 = 7x 
    add  HL, HL         ; 1:11      747 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      747 *   1  *2 = 28x
    add  HL, BC         ; 1:11      747 *      +1 = 29x 
    add  HL, HL         ; 1:11      747 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      747 *   1  *2 = 116x
    add  HL, BC         ; 1:11      747 *      +1 = 117x 
    add  HL, HL         ; 1:11      747 *   1  *2 = 234x
    add  HL, BC         ; 1:11      747 *      +1 = 235x 
    add   A, H          ; 1:4       747 *
    ld    H, A          ; 1:4       747 *     [747x] = 235x + 512x  
                        ;[17:152]   749 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1110_1101)
    ld    B, H          ; 1:4       749 *
    ld    C, L          ; 1:4       749 *   1       1x = base 
    add  HL, HL         ; 1:11      749 *   1  *2 = 2x
    ld    A, L          ; 1:4       749 *   256*L = 512x
    add  HL, BC         ; 1:11      749 *      +1 = 3x 
    add  HL, HL         ; 1:11      749 *   1  *2 = 6x
    add  HL, BC         ; 1:11      749 *      +1 = 7x 
    add  HL, HL         ; 1:11      749 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      749 *   1  *2 = 28x
    add  HL, BC         ; 1:11      749 *      +1 = 29x 
    add  HL, HL         ; 1:11      749 *   1  *2 = 58x
    add  HL, BC         ; 1:11      749 *      +1 = 59x 
    add  HL, HL         ; 1:11      749 *   0  *2 = 118x 
    add  HL, HL         ; 1:11      749 *   1  *2 = 236x
    add  HL, BC         ; 1:11      749 *      +1 = 237x 
    add   A, H          ; 1:4       749 *
    ld    H, A          ; 1:4       749 *     [749x] = 237x + 512x  
                        ;[18:107]   751 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_0001_0001_0001)  
    ld    A, L          ; 1:4       751 *   256x 
    ld    B, H          ; 1:4       751 *
    ld    C, L          ; 1:4       751 *   [1x] 
    add  HL, HL         ; 1:11      751 *   2x 
    add  HL, HL         ; 1:11      751 *   4x 
    add   A, B          ; 1:4       751 *
    ld    B, A          ; 1:4       751 *   [257x]
    ld    A, L          ; 1:4       751 *   save --1024x-- 
    add  HL, HL         ; 1:11      751 *   8x 
    add  HL, HL         ; 1:11      751 *   16x 
    add  HL, BC         ; 1:11      751 *   [273x]
    ld    B, A          ; 1:4       751 *   A0 - HL
    xor   A             ; 1:4       751 *
    sub   L             ; 1:4       751 *
    ld    L, A          ; 1:4       751 *
    ld    A, B          ; 1:4       751 *
    sbc   A, H          ; 1:4       751 *
    ld    H, A          ; 1:4       751 *   [751x] = 1024x - 1024x    
                        ;[16:141]   753 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1111_0001)
    ld    B, H          ; 1:4       753 *
    ld    C, L          ; 1:4       753 *   1       1x = base 
    add  HL, HL         ; 1:11      753 *   1  *2 = 2x
    ld    A, L          ; 1:4       753 *   256*L = 512x
    add  HL, BC         ; 1:11      753 *      +1 = 3x 
    add  HL, HL         ; 1:11      753 *   1  *2 = 6x
    add  HL, BC         ; 1:11      753 *      +1 = 7x 
    add  HL, HL         ; 1:11      753 *   1  *2 = 14x
    add  HL, BC         ; 1:11      753 *      +1 = 15x 
    add  HL, HL         ; 1:11      753 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      753 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      753 *   0  *2 = 120x 
    add  HL, HL         ; 1:11      753 *   1  *2 = 240x
    add  HL, BC         ; 1:11      753 *      +1 = 241x 
    add   A, H          ; 1:4       753 *
    ld    H, A          ; 1:4       753 *     [753x] = 241x + 512x  
                        ;[17:152]   755 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1111_0011)
    ld    B, H          ; 1:4       755 *
    ld    C, L          ; 1:4       755 *   1       1x = base 
    add  HL, HL         ; 1:11      755 *   1  *2 = 2x
    ld    A, L          ; 1:4       755 *   256*L = 512x
    add  HL, BC         ; 1:11      755 *      +1 = 3x 
    add  HL, HL         ; 1:11      755 *   1  *2 = 6x
    add  HL, BC         ; 1:11      755 *      +1 = 7x 
    add  HL, HL         ; 1:11      755 *   1  *2 = 14x
    add  HL, BC         ; 1:11      755 *      +1 = 15x 
    add  HL, HL         ; 1:11      755 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      755 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      755 *   1  *2 = 120x
    add  HL, BC         ; 1:11      755 *      +1 = 121x 
    add  HL, HL         ; 1:11      755 *   1  *2 = 242x
    add  HL, BC         ; 1:11      755 *      +1 = 243x 
    add   A, H          ; 1:4       755 *
    ld    H, A          ; 1:4       755 *     [755x] = 243x + 512x  
                        ;[17:152]   757 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1111_0101)
    ld    B, H          ; 1:4       757 *
    ld    C, L          ; 1:4       757 *   1       1x = base 
    add  HL, HL         ; 1:11      757 *   1  *2 = 2x
    ld    A, L          ; 1:4       757 *   256*L = 512x
    add  HL, BC         ; 1:11      757 *      +1 = 3x 
    add  HL, HL         ; 1:11      757 *   1  *2 = 6x
    add  HL, BC         ; 1:11      757 *      +1 = 7x 
    add  HL, HL         ; 1:11      757 *   1  *2 = 14x
    add  HL, BC         ; 1:11      757 *      +1 = 15x 
    add  HL, HL         ; 1:11      757 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      757 *   1  *2 = 60x
    add  HL, BC         ; 1:11      757 *      +1 = 61x 
    add  HL, HL         ; 1:11      757 *   0  *2 = 122x 
    add  HL, HL         ; 1:11      757 *   1  *2 = 244x
    add  HL, BC         ; 1:11      757 *      +1 = 245x 
    add   A, H          ; 1:4       757 *
    ld    H, A          ; 1:4       757 *     [757x] = 245x + 512x  
                        ;[17:96]    759 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_0001_0000_1001)  
    ld    A, L          ; 1:4       759 *   256x 
    ld    B, H          ; 1:4       759 *
    ld    C, L          ; 1:4       759 *   [1x] 
    add  HL, HL         ; 1:11      759 *   2x 
    add  HL, HL         ; 1:11      759 *   4x 
    add   A, B          ; 1:4       759 *
    ld    B, A          ; 1:4       759 *   [257x]
    ld    A, L          ; 1:4       759 *   save --1024x-- 
    add  HL, HL         ; 1:11      759 *   8x 
    add  HL, BC         ; 1:11      759 *   [265x]
    ld    B, A          ; 1:4       759 *   A0 - HL
    xor   A             ; 1:4       759 *
    sub   L             ; 1:4       759 *
    ld    L, A          ; 1:4       759 *
    ld    A, B          ; 1:4       759 *
    sbc   A, H          ; 1:4       759 *
    ld    H, A          ; 1:4       759 *   [759x] = 1024x - 1024x   

                        ;[17:152]   761 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1111_1001)
    ld    B, H          ; 1:4       761 *
    ld    C, L          ; 1:4       761 *   1       1x = base 
    add  HL, HL         ; 1:11      761 *   1  *2 = 2x
    ld    A, L          ; 1:4       761 *   256*L = 512x
    add  HL, BC         ; 1:11      761 *      +1 = 3x 
    add  HL, HL         ; 1:11      761 *   1  *2 = 6x
    add  HL, BC         ; 1:11      761 *      +1 = 7x 
    add  HL, HL         ; 1:11      761 *   1  *2 = 14x
    add  HL, BC         ; 1:11      761 *      +1 = 15x 
    add  HL, HL         ; 1:11      761 *   1  *2 = 30x
    add  HL, BC         ; 1:11      761 *      +1 = 31x 
    add  HL, HL         ; 1:11      761 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      761 *   0  *2 = 124x 
    add  HL, HL         ; 1:11      761 *   1  *2 = 248x
    add  HL, BC         ; 1:11      761 *      +1 = 249x 
    add   A, H          ; 1:4       761 *
    ld    H, A          ; 1:4       761 *     [761x] = 249x + 512x  
                        ;[14:79]    763 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_0001_0000_0101)  
    ld    A, L          ; 1:4       763 *   256x 
    ld    B, H          ; 1:4       763 *
    ld    C, L          ; 1:4       763 *   [1x] 
    add  HL, HL         ; 1:11      763 *   2x 
    add  HL, HL         ; 1:11      763 *   4x 
    sub   L             ; 1:4       763 *   L0 - (HL + BC + A0) = 0 - ((HL + BC) + (A0 - L0))
    add  HL, BC         ; 1:11      763 *   [5x]
    add   A, H          ; 1:4       763 *   [-763x]
    cpl                 ; 1:4       763 *
    ld    H, A          ; 1:4       763 *
    ld    A, L          ; 1:4       763 *
    cpl                 ; 1:4       763 *
    ld    L, A          ; 1:4       763 *
    inc  HL             ; 1:6       763 *   [763x] = 0-763x    
                        ;[18:163]   765 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0010_1111_1101)
    ld    B, H          ; 1:4       765 *
    ld    C, L          ; 1:4       765 *   1       1x = base 
    add  HL, HL         ; 1:11      765 *   1  *2 = 2x
    ld    A, L          ; 1:4       765 *   256*L = 512x
    add  HL, BC         ; 1:11      765 *      +1 = 3x 
    add  HL, HL         ; 1:11      765 *   1  *2 = 6x
    add  HL, BC         ; 1:11      765 *      +1 = 7x 
    add  HL, HL         ; 1:11      765 *   1  *2 = 14x
    add  HL, BC         ; 1:11      765 *      +1 = 15x 
    add  HL, HL         ; 1:11      765 *   1  *2 = 30x
    add  HL, BC         ; 1:11      765 *      +1 = 31x 
    add  HL, HL         ; 1:11      765 *   1  *2 = 62x
    add  HL, BC         ; 1:11      765 *      +1 = 63x 
    add  HL, HL         ; 1:11      765 *   0  *2 = 126x 
    add  HL, HL         ; 1:11      765 *   1  *2 = 252x
    add  HL, BC         ; 1:11      765 *      +1 = 253x 
    add   A, H          ; 1:4       765 *
    ld    H, A          ; 1:4       765 *     [765x] = 253x + 512x  
                        ;[13:72]    767 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_0001_0000_0001)  
    ld    A, L          ; 1:4       767 *   256x 
    ld    B, H          ; 1:4       767 *
    ld    C, L          ; 1:4       767 *   [1x] 
    add  HL, HL         ; 1:11      767 *   2x 
    add  HL, HL         ; 1:11      767 *   4x 
    add   A, B          ; 1:4       767 *
    ld    B, A          ; 1:4       767 *   [257x]
    ld    H, L          ; 1:4       767 *
    ld    L, 0x00       ; 2:7       767 *   1024x 
    or    A             ; 1:4       767 *
    sbc  HL, BC         ; 2:15      767 *   [767x] = 1024x - 257x   
                        ;[5:20]     769 *   Variant mk4: 256*...(((L*2^a)+L)*2^b)+... = HL * (b_0011_0000_0001)
    ld    A, L          ; 1:4       769 *   1       1x 
    add   A, A          ; 1:4       769 *   1  *2 = 2x
    add   A, L          ; 1:4       769 *      +1 = 3x 
    add   A, H          ; 1:4       769 *
    ld    H, A          ; 1:4       769 *     [769x] = 256 * 3x + 1x  
                        ;[7:42]     771 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0000_0011)
    ld    B, H          ; 1:4       771 *
    ld    C, L          ; 1:4       771 *   1       1x = base 
    add  HL, HL         ; 1:11      771 *   1  *2 = 2x
    add  HL, BC         ; 1:11      771 *      +1 = 3x 
    ld    A, L          ; 1:4       771 *   256*L = 768x 
    add   A, H          ; 1:4       771 *
    ld    H, A          ; 1:4       771 *     [771x] = 3x + 768x  
                        ;[9:57]     773 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0011_0000_0101)  
    ld    A, L          ; 1:4       773 *   256x 
    ld    B, H          ; 1:4       773 *
    ld    C, L          ; 1:4       773 *   [1x] 
    add  HL, HL         ; 1:11      773 *   2x 
    add   A, L          ; 1:4       773 *   768x 
    add  HL, HL         ; 1:11      773 *   4x 
    add   A, B          ; 1:4       773 *
    ld    B, A          ; 1:4       773 *   [769x] 
    add  HL, BC         ; 1:11      773 *   [773x] = 4x + 769x   
                        ;[9:64]     775 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0000_0111)
    ld    B, H          ; 1:4       775 *
    ld    C, L          ; 1:4       775 *   1       1x = base 
    add  HL, HL         ; 1:11      775 *   1  *2 = 2x
    add  HL, BC         ; 1:11      775 *      +1 = 3x 
    ld    A, L          ; 1:4       775 *   256*L = 768x 
    add  HL, HL         ; 1:11      775 *   1  *2 = 6x
    add  HL, BC         ; 1:11      775 *      +1 = 7x 
    add   A, H          ; 1:4       775 *
    ld    H, A          ; 1:4       775 *     [775x] = 7x + 768x  
                        ;[10:68]    777 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0011_0000_1001)  
    ld    A, L          ; 1:4       777 *   256x 
    ld    B, H          ; 1:4       777 *
    ld    C, L          ; 1:4       777 *   [1x] 
    add  HL, HL         ; 1:11      777 *   2x 
    add   A, L          ; 1:4       777 *   768x 
    add  HL, HL         ; 1:11      777 *   4x 
    add  HL, HL         ; 1:11      777 *   8x 
    add   A, B          ; 1:4       777 *
    ld    B, A          ; 1:4       777 *   [769x] 
    add  HL, BC         ; 1:11      777 *   [777x] = 8x + 769x   
                        ;[11:79]    779 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0000_1011)
    ld    B, H          ; 1:4       779 *
    ld    C, L          ; 1:4       779 *   1       1x = base 
    ld    A, L          ; 1:4       779 *   256*L = 256x 
    add  HL, HL         ; 1:11      779 *   0  *2 = 2x 
    add   A, L          ; 1:4       779 *  +256*L = 768x 
    add  HL, HL         ; 1:11      779 *   1  *2 = 4x
    add  HL, BC         ; 1:11      779 *      +1 = 5x 
    add  HL, HL         ; 1:11      779 *   1  *2 = 10x
    add  HL, BC         ; 1:11      779 *      +1 = 11x 
    add   A, H          ; 1:4       779 *
    ld    H, A          ; 1:4       779 *     [779x] = 11x + 768x  
                        ;[10:75]    781 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0000_1101)
    ld    B, H          ; 1:4       781 *
    ld    C, L          ; 1:4       781 *   1       1x = base 
    add  HL, HL         ; 1:11      781 *   1  *2 = 2x
    add  HL, BC         ; 1:11      781 *      +1 = 3x 
    ld    A, L          ; 1:4       781 *   256*L = 768x 
    add  HL, HL         ; 1:11      781 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      781 *   1  *2 = 12x
    add  HL, BC         ; 1:11      781 *      +1 = 13x 
    add   A, H          ; 1:4       781 *
    ld    H, A          ; 1:4       781 *     [781x] = 13x + 768x 

                        ;[11:86]    783 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0000_1111)
    ld    B, H          ; 1:4       783 *
    ld    C, L          ; 1:4       783 *   1       1x = base 
    add  HL, HL         ; 1:11      783 *   1  *2 = 2x
    add  HL, BC         ; 1:11      783 *      +1 = 3x 
    ld    A, L          ; 1:4       783 *   256*L = 768x 
    add  HL, HL         ; 1:11      783 *   1  *2 = 6x
    add  HL, BC         ; 1:11      783 *      +1 = 7x 
    add  HL, HL         ; 1:11      783 *   1  *2 = 14x
    add  HL, BC         ; 1:11      783 *      +1 = 15x 
    add   A, H          ; 1:4       783 *
    ld    H, A          ; 1:4       783 *     [783x] = 15x + 768x  
                        ;[11:79]    785 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0011_0001_0001)  
    ld    A, L          ; 1:4       785 *   256x 
    ld    B, H          ; 1:4       785 *
    ld    C, L          ; 1:4       785 *   [1x] 
    add  HL, HL         ; 1:11      785 *   2x 
    add   A, L          ; 1:4       785 *   768x 
    add  HL, HL         ; 1:11      785 *   4x 
    add  HL, HL         ; 1:11      785 *   8x 
    add  HL, HL         ; 1:11      785 *   16x 
    add   A, B          ; 1:4       785 *
    ld    B, A          ; 1:4       785 *   [769x] 
    add  HL, BC         ; 1:11      785 *   [785x] = 16x + 769x   
                        ;[12:90]    787 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0001_0011)
    ld    B, H          ; 1:4       787 *
    ld    C, L          ; 1:4       787 *   1       1x = base 
    ld    A, L          ; 1:4       787 *   256*L = 256x 
    add  HL, HL         ; 1:11      787 *   0  *2 = 2x 
    add   A, L          ; 1:4       787 *  +256*L = 768x 
    add  HL, HL         ; 1:11      787 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      787 *   1  *2 = 8x
    add  HL, BC         ; 1:11      787 *      +1 = 9x 
    add  HL, HL         ; 1:11      787 *   1  *2 = 18x
    add  HL, BC         ; 1:11      787 *      +1 = 19x 
    add   A, H          ; 1:4       787 *
    ld    H, A          ; 1:4       787 *     [787x] = 19x + 768x  
                        ;[12:90]    789 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0001_0101)
    ld    B, H          ; 1:4       789 *
    ld    C, L          ; 1:4       789 *   1       1x = base 
    ld    A, L          ; 1:4       789 *   256*L = 256x 
    add  HL, HL         ; 1:11      789 *   0  *2 = 2x 
    add   A, L          ; 1:4       789 *  +256*L = 768x 
    add  HL, HL         ; 1:11      789 *   1  *2 = 4x
    add  HL, BC         ; 1:11      789 *      +1 = 5x 
    add  HL, HL         ; 1:11      789 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      789 *   1  *2 = 20x
    add  HL, BC         ; 1:11      789 *      +1 = 21x 
    add   A, H          ; 1:4       789 *
    ld    H, A          ; 1:4       789 *     [789x] = 21x + 768x  
                        ;[13:101]   791 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0001_0111)
    ld    B, H          ; 1:4       791 *
    ld    C, L          ; 1:4       791 *   1       1x = base 
    ld    A, L          ; 1:4       791 *   256*L = 256x 
    add  HL, HL         ; 1:11      791 *   0  *2 = 2x 
    add   A, L          ; 1:4       791 *  +256*L = 768x 
    add  HL, HL         ; 1:11      791 *   1  *2 = 4x
    add  HL, BC         ; 1:11      791 *      +1 = 5x 
    add  HL, HL         ; 1:11      791 *   1  *2 = 10x
    add  HL, BC         ; 1:11      791 *      +1 = 11x 
    add  HL, HL         ; 1:11      791 *   1  *2 = 22x
    add  HL, BC         ; 1:11      791 *      +1 = 23x 
    add   A, H          ; 1:4       791 *
    ld    H, A          ; 1:4       791 *     [791x] = 23x + 768x  
                        ;[11:86]    793 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0001_1001)
    ld    B, H          ; 1:4       793 *
    ld    C, L          ; 1:4       793 *   1       1x = base 
    add  HL, HL         ; 1:11      793 *   1  *2 = 2x
    add  HL, BC         ; 1:11      793 *      +1 = 3x 
    ld    A, L          ; 1:4       793 *   256*L = 768x 
    add  HL, HL         ; 1:11      793 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      793 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      793 *   1  *2 = 24x
    add  HL, BC         ; 1:11      793 *      +1 = 25x 
    add   A, H          ; 1:4       793 *
    ld    H, A          ; 1:4       793 *     [793x] = 25x + 768x  
                        ;[12:97]    795 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0001_1011)
    ld    B, H          ; 1:4       795 *
    ld    C, L          ; 1:4       795 *   1       1x = base 
    add  HL, HL         ; 1:11      795 *   1  *2 = 2x
    add  HL, BC         ; 1:11      795 *      +1 = 3x 
    ld    A, L          ; 1:4       795 *   256*L = 768x 
    add  HL, HL         ; 1:11      795 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      795 *   1  *2 = 12x
    add  HL, BC         ; 1:11      795 *      +1 = 13x 
    add  HL, HL         ; 1:11      795 *   1  *2 = 26x
    add  HL, BC         ; 1:11      795 *      +1 = 27x 
    add   A, H          ; 1:4       795 *
    ld    H, A          ; 1:4       795 *     [795x] = 27x + 768x  
                        ;[12:97]    797 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0001_1101)
    ld    B, H          ; 1:4       797 *
    ld    C, L          ; 1:4       797 *   1       1x = base 
    add  HL, HL         ; 1:11      797 *   1  *2 = 2x
    add  HL, BC         ; 1:11      797 *      +1 = 3x 
    ld    A, L          ; 1:4       797 *   256*L = 768x 
    add  HL, HL         ; 1:11      797 *   1  *2 = 6x
    add  HL, BC         ; 1:11      797 *      +1 = 7x 
    add  HL, HL         ; 1:11      797 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      797 *   1  *2 = 28x
    add  HL, BC         ; 1:11      797 *      +1 = 29x 
    add   A, H          ; 1:4       797 *
    ld    H, A          ; 1:4       797 *     [797x] = 29x + 768x  
                        ;[13:108]   799 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0001_1111)
    ld    B, H          ; 1:4       799 *
    ld    C, L          ; 1:4       799 *   1       1x = base 
    add  HL, HL         ; 1:11      799 *   1  *2 = 2x
    add  HL, BC         ; 1:11      799 *      +1 = 3x 
    ld    A, L          ; 1:4       799 *   256*L = 768x 
    add  HL, HL         ; 1:11      799 *   1  *2 = 6x
    add  HL, BC         ; 1:11      799 *      +1 = 7x 
    add  HL, HL         ; 1:11      799 *   1  *2 = 14x
    add  HL, BC         ; 1:11      799 *      +1 = 15x 
    add  HL, HL         ; 1:11      799 *   1  *2 = 30x
    add  HL, BC         ; 1:11      799 *      +1 = 31x 
    add   A, H          ; 1:4       799 *
    ld    H, A          ; 1:4       799 *     [799x] = 31x + 768x  
                        ;[12:90]    801 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0011_0010_0001)  
    ld    A, L          ; 1:4       801 *   256x 
    ld    B, H          ; 1:4       801 *
    ld    C, L          ; 1:4       801 *   [1x] 
    add  HL, HL         ; 1:11      801 *   2x 
    add   A, L          ; 1:4       801 *   768x 
    add  HL, HL         ; 1:11      801 *   4x 
    add  HL, HL         ; 1:11      801 *   8x 
    add  HL, HL         ; 1:11      801 *   16x 
    add  HL, HL         ; 1:11      801 *   32x 
    add   A, B          ; 1:4       801 *
    ld    B, A          ; 1:4       801 *   [769x] 
    add  HL, BC         ; 1:11      801 *   [801x] = 32x + 769x   
                        ;[13:101]   803 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0010_0011)
    ld    B, H          ; 1:4       803 *
    ld    C, L          ; 1:4       803 *   1       1x = base 
    ld    A, L          ; 1:4       803 *   256*L = 256x 
    add  HL, HL         ; 1:11      803 *   0  *2 = 2x 
    add   A, L          ; 1:4       803 *  +256*L = 768x 
    add  HL, HL         ; 1:11      803 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      803 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      803 *   1  *2 = 16x
    add  HL, BC         ; 1:11      803 *      +1 = 17x 
    add  HL, HL         ; 1:11      803 *   1  *2 = 34x
    add  HL, BC         ; 1:11      803 *      +1 = 35x 
    add   A, H          ; 1:4       803 *
    ld    H, A          ; 1:4       803 *     [803x] = 35x + 768x 

                        ;[13:101]   805 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0010_0101)
    ld    B, H          ; 1:4       805 *
    ld    C, L          ; 1:4       805 *   1       1x = base 
    ld    A, L          ; 1:4       805 *   256*L = 256x 
    add  HL, HL         ; 1:11      805 *   0  *2 = 2x 
    add   A, L          ; 1:4       805 *  +256*L = 768x 
    add  HL, HL         ; 1:11      805 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      805 *   1  *2 = 8x
    add  HL, BC         ; 1:11      805 *      +1 = 9x 
    add  HL, HL         ; 1:11      805 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      805 *   1  *2 = 36x
    add  HL, BC         ; 1:11      805 *      +1 = 37x 
    add   A, H          ; 1:4       805 *
    ld    H, A          ; 1:4       805 *     [805x] = 37x + 768x  
                        ;[14:112]   807 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0010_0111)
    ld    B, H          ; 1:4       807 *
    ld    C, L          ; 1:4       807 *   1       1x = base 
    ld    A, L          ; 1:4       807 *   256*L = 256x 
    add  HL, HL         ; 1:11      807 *   0  *2 = 2x 
    add   A, L          ; 1:4       807 *  +256*L = 768x 
    add  HL, HL         ; 1:11      807 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      807 *   1  *2 = 8x
    add  HL, BC         ; 1:11      807 *      +1 = 9x 
    add  HL, HL         ; 1:11      807 *   1  *2 = 18x
    add  HL, BC         ; 1:11      807 *      +1 = 19x 
    add  HL, HL         ; 1:11      807 *   1  *2 = 38x
    add  HL, BC         ; 1:11      807 *      +1 = 39x 
    add   A, H          ; 1:4       807 *
    ld    H, A          ; 1:4       807 *     [807x] = 39x + 768x  
                        ;[13:101]   809 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0010_1001)
    ld    B, H          ; 1:4       809 *
    ld    C, L          ; 1:4       809 *   1       1x = base 
    ld    A, L          ; 1:4       809 *   256*L = 256x 
    add  HL, HL         ; 1:11      809 *   0  *2 = 2x 
    add   A, L          ; 1:4       809 *  +256*L = 768x 
    add  HL, HL         ; 1:11      809 *   1  *2 = 4x
    add  HL, BC         ; 1:11      809 *      +1 = 5x 
    add  HL, HL         ; 1:11      809 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      809 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      809 *   1  *2 = 40x
    add  HL, BC         ; 1:11      809 *      +1 = 41x 
    add   A, H          ; 1:4       809 *
    ld    H, A          ; 1:4       809 *     [809x] = 41x + 768x  
                        ;[14:112]   811 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0010_1011)
    ld    B, H          ; 1:4       811 *
    ld    C, L          ; 1:4       811 *   1       1x = base 
    ld    A, L          ; 1:4       811 *   256*L = 256x 
    add  HL, HL         ; 1:11      811 *   0  *2 = 2x 
    add   A, L          ; 1:4       811 *  +256*L = 768x 
    add  HL, HL         ; 1:11      811 *   1  *2 = 4x
    add  HL, BC         ; 1:11      811 *      +1 = 5x 
    add  HL, HL         ; 1:11      811 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      811 *   1  *2 = 20x
    add  HL, BC         ; 1:11      811 *      +1 = 21x 
    add  HL, HL         ; 1:11      811 *   1  *2 = 42x
    add  HL, BC         ; 1:11      811 *      +1 = 43x 
    add   A, H          ; 1:4       811 *
    ld    H, A          ; 1:4       811 *     [811x] = 43x + 768x  
                        ;[14:112]   813 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0010_1101)
    ld    B, H          ; 1:4       813 *
    ld    C, L          ; 1:4       813 *   1       1x = base 
    ld    A, L          ; 1:4       813 *   256*L = 256x 
    add  HL, HL         ; 1:11      813 *   0  *2 = 2x 
    add   A, L          ; 1:4       813 *  +256*L = 768x 
    add  HL, HL         ; 1:11      813 *   1  *2 = 4x
    add  HL, BC         ; 1:11      813 *      +1 = 5x 
    add  HL, HL         ; 1:11      813 *   1  *2 = 10x
    add  HL, BC         ; 1:11      813 *      +1 = 11x 
    add  HL, HL         ; 1:11      813 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      813 *   1  *2 = 44x
    add  HL, BC         ; 1:11      813 *      +1 = 45x 
    add   A, H          ; 1:4       813 *
    ld    H, A          ; 1:4       813 *     [813x] = 45x + 768x  
                        ;[15:123]   815 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0010_1111)
    ld    B, H          ; 1:4       815 *
    ld    C, L          ; 1:4       815 *   1       1x = base 
    ld    A, L          ; 1:4       815 *   256*L = 256x 
    add  HL, HL         ; 1:11      815 *   0  *2 = 2x 
    add   A, L          ; 1:4       815 *  +256*L = 768x 
    add  HL, HL         ; 1:11      815 *   1  *2 = 4x
    add  HL, BC         ; 1:11      815 *      +1 = 5x 
    add  HL, HL         ; 1:11      815 *   1  *2 = 10x
    add  HL, BC         ; 1:11      815 *      +1 = 11x 
    add  HL, HL         ; 1:11      815 *   1  *2 = 22x
    add  HL, BC         ; 1:11      815 *      +1 = 23x 
    add  HL, HL         ; 1:11      815 *   1  *2 = 46x
    add  HL, BC         ; 1:11      815 *      +1 = 47x 
    add   A, H          ; 1:4       815 *
    ld    H, A          ; 1:4       815 *     [815x] = 47x + 768x  
                        ;[12:97]    817 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0011_0001)
    ld    B, H          ; 1:4       817 *
    ld    C, L          ; 1:4       817 *   1       1x = base 
    add  HL, HL         ; 1:11      817 *   1  *2 = 2x
    add  HL, BC         ; 1:11      817 *      +1 = 3x 
    ld    A, L          ; 1:4       817 *   256*L = 768x 
    add  HL, HL         ; 1:11      817 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      817 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      817 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      817 *   1  *2 = 48x
    add  HL, BC         ; 1:11      817 *      +1 = 49x 
    add   A, H          ; 1:4       817 *
    ld    H, A          ; 1:4       817 *     [817x] = 49x + 768x  
                        ;[13:108]   819 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0011_0011)
    ld    B, H          ; 1:4       819 *
    ld    C, L          ; 1:4       819 *   1       1x = base 
    add  HL, HL         ; 1:11      819 *   1  *2 = 2x
    add  HL, BC         ; 1:11      819 *      +1 = 3x 
    ld    A, L          ; 1:4       819 *   256*L = 768x 
    add  HL, HL         ; 1:11      819 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      819 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      819 *   1  *2 = 24x
    add  HL, BC         ; 1:11      819 *      +1 = 25x 
    add  HL, HL         ; 1:11      819 *   1  *2 = 50x
    add  HL, BC         ; 1:11      819 *      +1 = 51x 
    add   A, H          ; 1:4       819 *
    ld    H, A          ; 1:4       819 *     [819x] = 51x + 768x  
                        ;[13:108]   821 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0011_0101)
    ld    B, H          ; 1:4       821 *
    ld    C, L          ; 1:4       821 *   1       1x = base 
    add  HL, HL         ; 1:11      821 *   1  *2 = 2x
    add  HL, BC         ; 1:11      821 *      +1 = 3x 
    ld    A, L          ; 1:4       821 *   256*L = 768x 
    add  HL, HL         ; 1:11      821 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      821 *   1  *2 = 12x
    add  HL, BC         ; 1:11      821 *      +1 = 13x 
    add  HL, HL         ; 1:11      821 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      821 *   1  *2 = 52x
    add  HL, BC         ; 1:11      821 *      +1 = 53x 
    add   A, H          ; 1:4       821 *
    ld    H, A          ; 1:4       821 *     [821x] = 53x + 768x  
                        ;[14:119]   823 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0011_0111)
    ld    B, H          ; 1:4       823 *
    ld    C, L          ; 1:4       823 *   1       1x = base 
    add  HL, HL         ; 1:11      823 *   1  *2 = 2x
    add  HL, BC         ; 1:11      823 *      +1 = 3x 
    ld    A, L          ; 1:4       823 *   256*L = 768x 
    add  HL, HL         ; 1:11      823 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      823 *   1  *2 = 12x
    add  HL, BC         ; 1:11      823 *      +1 = 13x 
    add  HL, HL         ; 1:11      823 *   1  *2 = 26x
    add  HL, BC         ; 1:11      823 *      +1 = 27x 
    add  HL, HL         ; 1:11      823 *   1  *2 = 54x
    add  HL, BC         ; 1:11      823 *      +1 = 55x 
    add   A, H          ; 1:4       823 *
    ld    H, A          ; 1:4       823 *     [823x] = 55x + 768x  
                        ;[13:108]   825 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0011_1001)
    ld    B, H          ; 1:4       825 *
    ld    C, L          ; 1:4       825 *   1       1x = base 
    add  HL, HL         ; 1:11      825 *   1  *2 = 2x
    add  HL, BC         ; 1:11      825 *      +1 = 3x 
    ld    A, L          ; 1:4       825 *   256*L = 768x 
    add  HL, HL         ; 1:11      825 *   1  *2 = 6x
    add  HL, BC         ; 1:11      825 *      +1 = 7x 
    add  HL, HL         ; 1:11      825 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      825 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      825 *   1  *2 = 56x
    add  HL, BC         ; 1:11      825 *      +1 = 57x 
    add   A, H          ; 1:4       825 *
    ld    H, A          ; 1:4       825 *     [825x] = 57x + 768x 

                        ;[14:119]   827 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0011_1011)
    ld    B, H          ; 1:4       827 *
    ld    C, L          ; 1:4       827 *   1       1x = base 
    add  HL, HL         ; 1:11      827 *   1  *2 = 2x
    add  HL, BC         ; 1:11      827 *      +1 = 3x 
    ld    A, L          ; 1:4       827 *   256*L = 768x 
    add  HL, HL         ; 1:11      827 *   1  *2 = 6x
    add  HL, BC         ; 1:11      827 *      +1 = 7x 
    add  HL, HL         ; 1:11      827 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      827 *   1  *2 = 28x
    add  HL, BC         ; 1:11      827 *      +1 = 29x 
    add  HL, HL         ; 1:11      827 *   1  *2 = 58x
    add  HL, BC         ; 1:11      827 *      +1 = 59x 
    add   A, H          ; 1:4       827 *
    ld    H, A          ; 1:4       827 *     [827x] = 59x + 768x  
                        ;[14:119]   829 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0011_1101)
    ld    B, H          ; 1:4       829 *
    ld    C, L          ; 1:4       829 *   1       1x = base 
    add  HL, HL         ; 1:11      829 *   1  *2 = 2x
    add  HL, BC         ; 1:11      829 *      +1 = 3x 
    ld    A, L          ; 1:4       829 *   256*L = 768x 
    add  HL, HL         ; 1:11      829 *   1  *2 = 6x
    add  HL, BC         ; 1:11      829 *      +1 = 7x 
    add  HL, HL         ; 1:11      829 *   1  *2 = 14x
    add  HL, BC         ; 1:11      829 *      +1 = 15x 
    add  HL, HL         ; 1:11      829 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      829 *   1  *2 = 60x
    add  HL, BC         ; 1:11      829 *      +1 = 61x 
    add   A, H          ; 1:4       829 *
    ld    H, A          ; 1:4       829 *     [829x] = 61x + 768x  
                        ;[15:130]   831 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0011_1111)
    ld    B, H          ; 1:4       831 *
    ld    C, L          ; 1:4       831 *   1       1x = base 
    add  HL, HL         ; 1:11      831 *   1  *2 = 2x
    add  HL, BC         ; 1:11      831 *      +1 = 3x 
    ld    A, L          ; 1:4       831 *   256*L = 768x 
    add  HL, HL         ; 1:11      831 *   1  *2 = 6x
    add  HL, BC         ; 1:11      831 *      +1 = 7x 
    add  HL, HL         ; 1:11      831 *   1  *2 = 14x
    add  HL, BC         ; 1:11      831 *      +1 = 15x 
    add  HL, HL         ; 1:11      831 *   1  *2 = 30x
    add  HL, BC         ; 1:11      831 *      +1 = 31x 
    add  HL, HL         ; 1:11      831 *   1  *2 = 62x
    add  HL, BC         ; 1:11      831 *      +1 = 63x 
    add   A, H          ; 1:4       831 *
    ld    H, A          ; 1:4       831 *     [831x] = 63x + 768x  
                        ;[13:101]   833 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0011_0100_0001)  
    ld    A, L          ; 1:4       833 *   256x 
    ld    B, H          ; 1:4       833 *
    ld    C, L          ; 1:4       833 *   [1x] 
    add  HL, HL         ; 1:11      833 *   2x 
    add   A, L          ; 1:4       833 *   768x 
    add  HL, HL         ; 1:11      833 *   4x 
    add  HL, HL         ; 1:11      833 *   8x 
    add  HL, HL         ; 1:11      833 *   16x 
    add  HL, HL         ; 1:11      833 *   32x 
    add  HL, HL         ; 1:11      833 *   64x 
    add   A, B          ; 1:4       833 *
    ld    B, A          ; 1:4       833 *   [769x] 
    add  HL, BC         ; 1:11      833 *   [833x] = 64x + 769x   
                        ;[14:112]   835 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0100_0011)
    ld    B, H          ; 1:4       835 *
    ld    C, L          ; 1:4       835 *   1       1x = base 
    ld    A, L          ; 1:4       835 *   256*L = 256x 
    add  HL, HL         ; 1:11      835 *   0  *2 = 2x 
    add   A, L          ; 1:4       835 *  +256*L = 768x 
    add  HL, HL         ; 1:11      835 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      835 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      835 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      835 *   1  *2 = 32x
    add  HL, BC         ; 1:11      835 *      +1 = 33x 
    add  HL, HL         ; 1:11      835 *   1  *2 = 66x
    add  HL, BC         ; 1:11      835 *      +1 = 67x 
    add   A, H          ; 1:4       835 *
    ld    H, A          ; 1:4       835 *     [835x] = 67x + 768x  
                        ;[14:112]   837 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0100_0101)
    ld    B, H          ; 1:4       837 *
    ld    C, L          ; 1:4       837 *   1       1x = base 
    ld    A, L          ; 1:4       837 *   256*L = 256x 
    add  HL, HL         ; 1:11      837 *   0  *2 = 2x 
    add   A, L          ; 1:4       837 *  +256*L = 768x 
    add  HL, HL         ; 1:11      837 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      837 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      837 *   1  *2 = 16x
    add  HL, BC         ; 1:11      837 *      +1 = 17x 
    add  HL, HL         ; 1:11      837 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      837 *   1  *2 = 68x
    add  HL, BC         ; 1:11      837 *      +1 = 69x 
    add   A, H          ; 1:4       837 *
    ld    H, A          ; 1:4       837 *     [837x] = 69x + 768x  
                        ;[15:123]   839 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0100_0111)
    ld    B, H          ; 1:4       839 *
    ld    C, L          ; 1:4       839 *   1       1x = base 
    ld    A, L          ; 1:4       839 *   256*L = 256x 
    add  HL, HL         ; 1:11      839 *   0  *2 = 2x 
    add   A, L          ; 1:4       839 *  +256*L = 768x 
    add  HL, HL         ; 1:11      839 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      839 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      839 *   1  *2 = 16x
    add  HL, BC         ; 1:11      839 *      +1 = 17x 
    add  HL, HL         ; 1:11      839 *   1  *2 = 34x
    add  HL, BC         ; 1:11      839 *      +1 = 35x 
    add  HL, HL         ; 1:11      839 *   1  *2 = 70x
    add  HL, BC         ; 1:11      839 *      +1 = 71x 
    add   A, H          ; 1:4       839 *
    ld    H, A          ; 1:4       839 *     [839x] = 71x + 768x  
                        ;[14:112]   841 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0100_1001)
    ld    B, H          ; 1:4       841 *
    ld    C, L          ; 1:4       841 *   1       1x = base 
    ld    A, L          ; 1:4       841 *   256*L = 256x 
    add  HL, HL         ; 1:11      841 *   0  *2 = 2x 
    add   A, L          ; 1:4       841 *  +256*L = 768x 
    add  HL, HL         ; 1:11      841 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      841 *   1  *2 = 8x
    add  HL, BC         ; 1:11      841 *      +1 = 9x 
    add  HL, HL         ; 1:11      841 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      841 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      841 *   1  *2 = 72x
    add  HL, BC         ; 1:11      841 *      +1 = 73x 
    add   A, H          ; 1:4       841 *
    ld    H, A          ; 1:4       841 *     [841x] = 73x + 768x  
                        ;[15:123]   843 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0100_1011)
    ld    B, H          ; 1:4       843 *
    ld    C, L          ; 1:4       843 *   1       1x = base 
    ld    A, L          ; 1:4       843 *   256*L = 256x 
    add  HL, HL         ; 1:11      843 *   0  *2 = 2x 
    add   A, L          ; 1:4       843 *  +256*L = 768x 
    add  HL, HL         ; 1:11      843 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      843 *   1  *2 = 8x
    add  HL, BC         ; 1:11      843 *      +1 = 9x 
    add  HL, HL         ; 1:11      843 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      843 *   1  *2 = 36x
    add  HL, BC         ; 1:11      843 *      +1 = 37x 
    add  HL, HL         ; 1:11      843 *   1  *2 = 74x
    add  HL, BC         ; 1:11      843 *      +1 = 75x 
    add   A, H          ; 1:4       843 *
    ld    H, A          ; 1:4       843 *     [843x] = 75x + 768x  
                        ;[15:123]   845 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0100_1101)
    ld    B, H          ; 1:4       845 *
    ld    C, L          ; 1:4       845 *   1       1x = base 
    ld    A, L          ; 1:4       845 *   256*L = 256x 
    add  HL, HL         ; 1:11      845 *   0  *2 = 2x 
    add   A, L          ; 1:4       845 *  +256*L = 768x 
    add  HL, HL         ; 1:11      845 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      845 *   1  *2 = 8x
    add  HL, BC         ; 1:11      845 *      +1 = 9x 
    add  HL, HL         ; 1:11      845 *   1  *2 = 18x
    add  HL, BC         ; 1:11      845 *      +1 = 19x 
    add  HL, HL         ; 1:11      845 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      845 *   1  *2 = 76x
    add  HL, BC         ; 1:11      845 *      +1 = 77x 
    add   A, H          ; 1:4       845 *
    ld    H, A          ; 1:4       845 *     [845x] = 77x + 768x  
                        ;[16:134]   847 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0100_1111)
    ld    B, H          ; 1:4       847 *
    ld    C, L          ; 1:4       847 *   1       1x = base 
    ld    A, L          ; 1:4       847 *   256*L = 256x 
    add  HL, HL         ; 1:11      847 *   0  *2 = 2x 
    add   A, L          ; 1:4       847 *  +256*L = 768x 
    add  HL, HL         ; 1:11      847 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      847 *   1  *2 = 8x
    add  HL, BC         ; 1:11      847 *      +1 = 9x 
    add  HL, HL         ; 1:11      847 *   1  *2 = 18x
    add  HL, BC         ; 1:11      847 *      +1 = 19x 
    add  HL, HL         ; 1:11      847 *   1  *2 = 38x
    add  HL, BC         ; 1:11      847 *      +1 = 39x 
    add  HL, HL         ; 1:11      847 *   1  *2 = 78x
    add  HL, BC         ; 1:11      847 *      +1 = 79x 
    add   A, H          ; 1:4       847 *
    ld    H, A          ; 1:4       847 *     [847x] = 79x + 768x 

                        ;[14:112]   849 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0101_0001)
    ld    B, H          ; 1:4       849 *
    ld    C, L          ; 1:4       849 *   1       1x = base 
    ld    A, L          ; 1:4       849 *   256*L = 256x 
    add  HL, HL         ; 1:11      849 *   0  *2 = 2x 
    add   A, L          ; 1:4       849 *  +256*L = 768x 
    add  HL, HL         ; 1:11      849 *   1  *2 = 4x
    add  HL, BC         ; 1:11      849 *      +1 = 5x 
    add  HL, HL         ; 1:11      849 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      849 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      849 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      849 *   1  *2 = 80x
    add  HL, BC         ; 1:11      849 *      +1 = 81x 
    add   A, H          ; 1:4       849 *
    ld    H, A          ; 1:4       849 *     [849x] = 81x + 768x  
                        ;[15:123]   851 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0101_0011)
    ld    B, H          ; 1:4       851 *
    ld    C, L          ; 1:4       851 *   1       1x = base 
    ld    A, L          ; 1:4       851 *   256*L = 256x 
    add  HL, HL         ; 1:11      851 *   0  *2 = 2x 
    add   A, L          ; 1:4       851 *  +256*L = 768x 
    add  HL, HL         ; 1:11      851 *   1  *2 = 4x
    add  HL, BC         ; 1:11      851 *      +1 = 5x 
    add  HL, HL         ; 1:11      851 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      851 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      851 *   1  *2 = 40x
    add  HL, BC         ; 1:11      851 *      +1 = 41x 
    add  HL, HL         ; 1:11      851 *   1  *2 = 82x
    add  HL, BC         ; 1:11      851 *      +1 = 83x 
    add   A, H          ; 1:4       851 *
    ld    H, A          ; 1:4       851 *     [851x] = 83x + 768x  
                        ;[15:123]   853 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0101_0101)
    ld    B, H          ; 1:4       853 *
    ld    C, L          ; 1:4       853 *   1       1x = base 
    ld    A, L          ; 1:4       853 *   256*L = 256x 
    add  HL, HL         ; 1:11      853 *   0  *2 = 2x 
    add   A, L          ; 1:4       853 *  +256*L = 768x 
    add  HL, HL         ; 1:11      853 *   1  *2 = 4x
    add  HL, BC         ; 1:11      853 *      +1 = 5x 
    add  HL, HL         ; 1:11      853 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      853 *   1  *2 = 20x
    add  HL, BC         ; 1:11      853 *      +1 = 21x 
    add  HL, HL         ; 1:11      853 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      853 *   1  *2 = 84x
    add  HL, BC         ; 1:11      853 *      +1 = 85x 
    add   A, H          ; 1:4       853 *
    ld    H, A          ; 1:4       853 *     [853x] = 85x + 768x  
                        ;[16:134]   855 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0101_0111)
    ld    B, H          ; 1:4       855 *
    ld    C, L          ; 1:4       855 *   1       1x = base 
    ld    A, L          ; 1:4       855 *   256*L = 256x 
    add  HL, HL         ; 1:11      855 *   0  *2 = 2x 
    add   A, L          ; 1:4       855 *  +256*L = 768x 
    add  HL, HL         ; 1:11      855 *   1  *2 = 4x
    add  HL, BC         ; 1:11      855 *      +1 = 5x 
    add  HL, HL         ; 1:11      855 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      855 *   1  *2 = 20x
    add  HL, BC         ; 1:11      855 *      +1 = 21x 
    add  HL, HL         ; 1:11      855 *   1  *2 = 42x
    add  HL, BC         ; 1:11      855 *      +1 = 43x 
    add  HL, HL         ; 1:11      855 *   1  *2 = 86x
    add  HL, BC         ; 1:11      855 *      +1 = 87x 
    add   A, H          ; 1:4       855 *
    ld    H, A          ; 1:4       855 *     [855x] = 87x + 768x  
                        ;[15:123]   857 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0101_1001)
    ld    B, H          ; 1:4       857 *
    ld    C, L          ; 1:4       857 *   1       1x = base 
    ld    A, L          ; 1:4       857 *   256*L = 256x 
    add  HL, HL         ; 1:11      857 *   0  *2 = 2x 
    add   A, L          ; 1:4       857 *  +256*L = 768x 
    add  HL, HL         ; 1:11      857 *   1  *2 = 4x
    add  HL, BC         ; 1:11      857 *      +1 = 5x 
    add  HL, HL         ; 1:11      857 *   1  *2 = 10x
    add  HL, BC         ; 1:11      857 *      +1 = 11x 
    add  HL, HL         ; 1:11      857 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      857 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      857 *   1  *2 = 88x
    add  HL, BC         ; 1:11      857 *      +1 = 89x 
    add   A, H          ; 1:4       857 *
    ld    H, A          ; 1:4       857 *     [857x] = 89x + 768x  
                        ;[16:134]   859 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0101_1011)
    ld    B, H          ; 1:4       859 *
    ld    C, L          ; 1:4       859 *   1       1x = base 
    ld    A, L          ; 1:4       859 *   256*L = 256x 
    add  HL, HL         ; 1:11      859 *   0  *2 = 2x 
    add   A, L          ; 1:4       859 *  +256*L = 768x 
    add  HL, HL         ; 1:11      859 *   1  *2 = 4x
    add  HL, BC         ; 1:11      859 *      +1 = 5x 
    add  HL, HL         ; 1:11      859 *   1  *2 = 10x
    add  HL, BC         ; 1:11      859 *      +1 = 11x 
    add  HL, HL         ; 1:11      859 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      859 *   1  *2 = 44x
    add  HL, BC         ; 1:11      859 *      +1 = 45x 
    add  HL, HL         ; 1:11      859 *   1  *2 = 90x
    add  HL, BC         ; 1:11      859 *      +1 = 91x 
    add   A, H          ; 1:4       859 *
    ld    H, A          ; 1:4       859 *     [859x] = 91x + 768x  
                        ;[16:134]   861 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0101_1101)
    ld    B, H          ; 1:4       861 *
    ld    C, L          ; 1:4       861 *   1       1x = base 
    ld    A, L          ; 1:4       861 *   256*L = 256x 
    add  HL, HL         ; 1:11      861 *   0  *2 = 2x 
    add   A, L          ; 1:4       861 *  +256*L = 768x 
    add  HL, HL         ; 1:11      861 *   1  *2 = 4x
    add  HL, BC         ; 1:11      861 *      +1 = 5x 
    add  HL, HL         ; 1:11      861 *   1  *2 = 10x
    add  HL, BC         ; 1:11      861 *      +1 = 11x 
    add  HL, HL         ; 1:11      861 *   1  *2 = 22x
    add  HL, BC         ; 1:11      861 *      +1 = 23x 
    add  HL, HL         ; 1:11      861 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      861 *   1  *2 = 92x
    add  HL, BC         ; 1:11      861 *      +1 = 93x 
    add   A, H          ; 1:4       861 *
    ld    H, A          ; 1:4       861 *     [861x] = 93x + 768x  
                        ;[17:145]   863 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0101_1111)
    ld    B, H          ; 1:4       863 *
    ld    C, L          ; 1:4       863 *   1       1x = base 
    ld    A, L          ; 1:4       863 *   256*L = 256x 
    add  HL, HL         ; 1:11      863 *   0  *2 = 2x 
    add   A, L          ; 1:4       863 *  +256*L = 768x 
    add  HL, HL         ; 1:11      863 *   1  *2 = 4x
    add  HL, BC         ; 1:11      863 *      +1 = 5x 
    add  HL, HL         ; 1:11      863 *   1  *2 = 10x
    add  HL, BC         ; 1:11      863 *      +1 = 11x 
    add  HL, HL         ; 1:11      863 *   1  *2 = 22x
    add  HL, BC         ; 1:11      863 *      +1 = 23x 
    add  HL, HL         ; 1:11      863 *   1  *2 = 46x
    add  HL, BC         ; 1:11      863 *      +1 = 47x 
    add  HL, HL         ; 1:11      863 *   1  *2 = 94x
    add  HL, BC         ; 1:11      863 *      +1 = 95x 
    add   A, H          ; 1:4       863 *
    ld    H, A          ; 1:4       863 *     [863x] = 95x + 768x  
                        ;[13:108]   865 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_0001)
    ld    B, H          ; 1:4       865 *
    ld    C, L          ; 1:4       865 *   1       1x = base 
    add  HL, HL         ; 1:11      865 *   1  *2 = 2x
    add  HL, BC         ; 1:11      865 *      +1 = 3x 
    ld    A, L          ; 1:4       865 *   256*L = 768x 
    add  HL, HL         ; 1:11      865 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      865 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      865 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      865 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      865 *   1  *2 = 96x
    add  HL, BC         ; 1:11      865 *      +1 = 97x 
    add   A, H          ; 1:4       865 *
    ld    H, A          ; 1:4       865 *     [865x] = 97x + 768x  
                        ;[14:119]   867 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_0011)
    ld    B, H          ; 1:4       867 *
    ld    C, L          ; 1:4       867 *   1       1x = base 
    add  HL, HL         ; 1:11      867 *   1  *2 = 2x
    add  HL, BC         ; 1:11      867 *      +1 = 3x 
    ld    A, L          ; 1:4       867 *   256*L = 768x 
    add  HL, HL         ; 1:11      867 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      867 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      867 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      867 *   1  *2 = 48x
    add  HL, BC         ; 1:11      867 *      +1 = 49x 
    add  HL, HL         ; 1:11      867 *   1  *2 = 98x
    add  HL, BC         ; 1:11      867 *      +1 = 99x 
    add   A, H          ; 1:4       867 *
    ld    H, A          ; 1:4       867 *     [867x] = 99x + 768x  
                        ;[14:119]   869 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_0101)
    ld    B, H          ; 1:4       869 *
    ld    C, L          ; 1:4       869 *   1       1x = base 
    add  HL, HL         ; 1:11      869 *   1  *2 = 2x
    add  HL, BC         ; 1:11      869 *      +1 = 3x 
    ld    A, L          ; 1:4       869 *   256*L = 768x 
    add  HL, HL         ; 1:11      869 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      869 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      869 *   1  *2 = 24x
    add  HL, BC         ; 1:11      869 *      +1 = 25x 
    add  HL, HL         ; 1:11      869 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      869 *   1  *2 = 100x
    add  HL, BC         ; 1:11      869 *      +1 = 101x 
    add   A, H          ; 1:4       869 *
    ld    H, A          ; 1:4       869 *     [869x] = 101x + 768x 

                        ;[15:130]   871 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_0111)
    ld    B, H          ; 1:4       871 *
    ld    C, L          ; 1:4       871 *   1       1x = base 
    add  HL, HL         ; 1:11      871 *   1  *2 = 2x
    add  HL, BC         ; 1:11      871 *      +1 = 3x 
    ld    A, L          ; 1:4       871 *   256*L = 768x 
    add  HL, HL         ; 1:11      871 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      871 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      871 *   1  *2 = 24x
    add  HL, BC         ; 1:11      871 *      +1 = 25x 
    add  HL, HL         ; 1:11      871 *   1  *2 = 50x
    add  HL, BC         ; 1:11      871 *      +1 = 51x 
    add  HL, HL         ; 1:11      871 *   1  *2 = 102x
    add  HL, BC         ; 1:11      871 *      +1 = 103x 
    add   A, H          ; 1:4       871 *
    ld    H, A          ; 1:4       871 *     [871x] = 103x + 768x  
                        ;[14:119]   873 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_1001)
    ld    B, H          ; 1:4       873 *
    ld    C, L          ; 1:4       873 *   1       1x = base 
    add  HL, HL         ; 1:11      873 *   1  *2 = 2x
    add  HL, BC         ; 1:11      873 *      +1 = 3x 
    ld    A, L          ; 1:4       873 *   256*L = 768x 
    add  HL, HL         ; 1:11      873 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      873 *   1  *2 = 12x
    add  HL, BC         ; 1:11      873 *      +1 = 13x 
    add  HL, HL         ; 1:11      873 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      873 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      873 *   1  *2 = 104x
    add  HL, BC         ; 1:11      873 *      +1 = 105x 
    add   A, H          ; 1:4       873 *
    ld    H, A          ; 1:4       873 *     [873x] = 105x + 768x  
                        ;[15:130]   875 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_1011)
    ld    B, H          ; 1:4       875 *
    ld    C, L          ; 1:4       875 *   1       1x = base 
    add  HL, HL         ; 1:11      875 *   1  *2 = 2x
    add  HL, BC         ; 1:11      875 *      +1 = 3x 
    ld    A, L          ; 1:4       875 *   256*L = 768x 
    add  HL, HL         ; 1:11      875 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      875 *   1  *2 = 12x
    add  HL, BC         ; 1:11      875 *      +1 = 13x 
    add  HL, HL         ; 1:11      875 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      875 *   1  *2 = 52x
    add  HL, BC         ; 1:11      875 *      +1 = 53x 
    add  HL, HL         ; 1:11      875 *   1  *2 = 106x
    add  HL, BC         ; 1:11      875 *      +1 = 107x 
    add   A, H          ; 1:4       875 *
    ld    H, A          ; 1:4       875 *     [875x] = 107x + 768x  
                        ;[15:130]   877 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_1101)
    ld    B, H          ; 1:4       877 *
    ld    C, L          ; 1:4       877 *   1       1x = base 
    add  HL, HL         ; 1:11      877 *   1  *2 = 2x
    add  HL, BC         ; 1:11      877 *      +1 = 3x 
    ld    A, L          ; 1:4       877 *   256*L = 768x 
    add  HL, HL         ; 1:11      877 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      877 *   1  *2 = 12x
    add  HL, BC         ; 1:11      877 *      +1 = 13x 
    add  HL, HL         ; 1:11      877 *   1  *2 = 26x
    add  HL, BC         ; 1:11      877 *      +1 = 27x 
    add  HL, HL         ; 1:11      877 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      877 *   1  *2 = 108x
    add  HL, BC         ; 1:11      877 *      +1 = 109x 
    add   A, H          ; 1:4       877 *
    ld    H, A          ; 1:4       877 *     [877x] = 109x + 768x  
                        ;[16:141]   879 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0110_1111)
    ld    B, H          ; 1:4       879 *
    ld    C, L          ; 1:4       879 *   1       1x = base 
    add  HL, HL         ; 1:11      879 *   1  *2 = 2x
    add  HL, BC         ; 1:11      879 *      +1 = 3x 
    ld    A, L          ; 1:4       879 *   256*L = 768x 
    add  HL, HL         ; 1:11      879 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      879 *   1  *2 = 12x
    add  HL, BC         ; 1:11      879 *      +1 = 13x 
    add  HL, HL         ; 1:11      879 *   1  *2 = 26x
    add  HL, BC         ; 1:11      879 *      +1 = 27x 
    add  HL, HL         ; 1:11      879 *   1  *2 = 54x
    add  HL, BC         ; 1:11      879 *      +1 = 55x 
    add  HL, HL         ; 1:11      879 *   1  *2 = 110x
    add  HL, BC         ; 1:11      879 *      +1 = 111x 
    add   A, H          ; 1:4       879 *
    ld    H, A          ; 1:4       879 *     [879x] = 111x + 768x  
                        ;[14:119]   881 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0111_0001)
    ld    B, H          ; 1:4       881 *
    ld    C, L          ; 1:4       881 *   1       1x = base 
    add  HL, HL         ; 1:11      881 *   1  *2 = 2x
    add  HL, BC         ; 1:11      881 *      +1 = 3x 
    ld    A, L          ; 1:4       881 *   256*L = 768x 
    add  HL, HL         ; 1:11      881 *   1  *2 = 6x
    add  HL, BC         ; 1:11      881 *      +1 = 7x 
    add  HL, HL         ; 1:11      881 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      881 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      881 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      881 *   1  *2 = 112x
    add  HL, BC         ; 1:11      881 *      +1 = 113x 
    add   A, H          ; 1:4       881 *
    ld    H, A          ; 1:4       881 *     [881x] = 113x + 768x  
                        ;[15:130]   883 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0111_0011)
    ld    B, H          ; 1:4       883 *
    ld    C, L          ; 1:4       883 *   1       1x = base 
    add  HL, HL         ; 1:11      883 *   1  *2 = 2x
    add  HL, BC         ; 1:11      883 *      +1 = 3x 
    ld    A, L          ; 1:4       883 *   256*L = 768x 
    add  HL, HL         ; 1:11      883 *   1  *2 = 6x
    add  HL, BC         ; 1:11      883 *      +1 = 7x 
    add  HL, HL         ; 1:11      883 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      883 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      883 *   1  *2 = 56x
    add  HL, BC         ; 1:11      883 *      +1 = 57x 
    add  HL, HL         ; 1:11      883 *   1  *2 = 114x
    add  HL, BC         ; 1:11      883 *      +1 = 115x 
    add   A, H          ; 1:4       883 *
    ld    H, A          ; 1:4       883 *     [883x] = 115x + 768x  
                        ;[15:130]   885 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0111_0101)
    ld    B, H          ; 1:4       885 *
    ld    C, L          ; 1:4       885 *   1       1x = base 
    add  HL, HL         ; 1:11      885 *   1  *2 = 2x
    add  HL, BC         ; 1:11      885 *      +1 = 3x 
    ld    A, L          ; 1:4       885 *   256*L = 768x 
    add  HL, HL         ; 1:11      885 *   1  *2 = 6x
    add  HL, BC         ; 1:11      885 *      +1 = 7x 
    add  HL, HL         ; 1:11      885 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      885 *   1  *2 = 28x
    add  HL, BC         ; 1:11      885 *      +1 = 29x 
    add  HL, HL         ; 1:11      885 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      885 *   1  *2 = 116x
    add  HL, BC         ; 1:11      885 *      +1 = 117x 
    add   A, H          ; 1:4       885 *
    ld    H, A          ; 1:4       885 *     [885x] = 117x + 768x  
                        ;[16:141]   887 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0111_0111)
    ld    B, H          ; 1:4       887 *
    ld    C, L          ; 1:4       887 *   1       1x = base 
    add  HL, HL         ; 1:11      887 *   1  *2 = 2x
    add  HL, BC         ; 1:11      887 *      +1 = 3x 
    ld    A, L          ; 1:4       887 *   256*L = 768x 
    add  HL, HL         ; 1:11      887 *   1  *2 = 6x
    add  HL, BC         ; 1:11      887 *      +1 = 7x 
    add  HL, HL         ; 1:11      887 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      887 *   1  *2 = 28x
    add  HL, BC         ; 1:11      887 *      +1 = 29x 
    add  HL, HL         ; 1:11      887 *   1  *2 = 58x
    add  HL, BC         ; 1:11      887 *      +1 = 59x 
    add  HL, HL         ; 1:11      887 *   1  *2 = 118x
    add  HL, BC         ; 1:11      887 *      +1 = 119x 
    add   A, H          ; 1:4       887 *
    ld    H, A          ; 1:4       887 *     [887x] = 119x + 768x  
                        ;[15:130]   889 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0111_1001)
    ld    B, H          ; 1:4       889 *
    ld    C, L          ; 1:4       889 *   1       1x = base 
    add  HL, HL         ; 1:11      889 *   1  *2 = 2x
    add  HL, BC         ; 1:11      889 *      +1 = 3x 
    ld    A, L          ; 1:4       889 *   256*L = 768x 
    add  HL, HL         ; 1:11      889 *   1  *2 = 6x
    add  HL, BC         ; 1:11      889 *      +1 = 7x 
    add  HL, HL         ; 1:11      889 *   1  *2 = 14x
    add  HL, BC         ; 1:11      889 *      +1 = 15x 
    add  HL, HL         ; 1:11      889 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      889 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      889 *   1  *2 = 120x
    add  HL, BC         ; 1:11      889 *      +1 = 121x 
    add   A, H          ; 1:4       889 *
    ld    H, A          ; 1:4       889 *     [889x] = 121x + 768x  
                        ;[16:141]   891 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0111_1011)
    ld    B, H          ; 1:4       891 *
    ld    C, L          ; 1:4       891 *   1       1x = base 
    add  HL, HL         ; 1:11      891 *   1  *2 = 2x
    add  HL, BC         ; 1:11      891 *      +1 = 3x 
    ld    A, L          ; 1:4       891 *   256*L = 768x 
    add  HL, HL         ; 1:11      891 *   1  *2 = 6x
    add  HL, BC         ; 1:11      891 *      +1 = 7x 
    add  HL, HL         ; 1:11      891 *   1  *2 = 14x
    add  HL, BC         ; 1:11      891 *      +1 = 15x 
    add  HL, HL         ; 1:11      891 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      891 *   1  *2 = 60x
    add  HL, BC         ; 1:11      891 *      +1 = 61x 
    add  HL, HL         ; 1:11      891 *   1  *2 = 122x
    add  HL, BC         ; 1:11      891 *      +1 = 123x 
    add   A, H          ; 1:4       891 *
    ld    H, A          ; 1:4       891 *     [891x] = 123x + 768x 

                        ;[16:141]   893 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0111_1101)
    ld    B, H          ; 1:4       893 *
    ld    C, L          ; 1:4       893 *   1       1x = base 
    add  HL, HL         ; 1:11      893 *   1  *2 = 2x
    add  HL, BC         ; 1:11      893 *      +1 = 3x 
    ld    A, L          ; 1:4       893 *   256*L = 768x 
    add  HL, HL         ; 1:11      893 *   1  *2 = 6x
    add  HL, BC         ; 1:11      893 *      +1 = 7x 
    add  HL, HL         ; 1:11      893 *   1  *2 = 14x
    add  HL, BC         ; 1:11      893 *      +1 = 15x 
    add  HL, HL         ; 1:11      893 *   1  *2 = 30x
    add  HL, BC         ; 1:11      893 *      +1 = 31x 
    add  HL, HL         ; 1:11      893 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      893 *   1  *2 = 124x
    add  HL, BC         ; 1:11      893 *      +1 = 125x 
    add   A, H          ; 1:4       893 *
    ld    H, A          ; 1:4       893 *     [893x] = 125x + 768x  
                        ;[17:152]   895 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_0111_1111)
    ld    B, H          ; 1:4       895 *
    ld    C, L          ; 1:4       895 *   1       1x = base 
    add  HL, HL         ; 1:11      895 *   1  *2 = 2x
    add  HL, BC         ; 1:11      895 *      +1 = 3x 
    ld    A, L          ; 1:4       895 *   256*L = 768x 
    add  HL, HL         ; 1:11      895 *   1  *2 = 6x
    add  HL, BC         ; 1:11      895 *      +1 = 7x 
    add  HL, HL         ; 1:11      895 *   1  *2 = 14x
    add  HL, BC         ; 1:11      895 *      +1 = 15x 
    add  HL, HL         ; 1:11      895 *   1  *2 = 30x
    add  HL, BC         ; 1:11      895 *      +1 = 31x 
    add  HL, HL         ; 1:11      895 *   1  *2 = 62x
    add  HL, BC         ; 1:11      895 *      +1 = 63x 
    add  HL, HL         ; 1:11      895 *   1  *2 = 126x
    add  HL, BC         ; 1:11      895 *      +1 = 127x 
    add   A, H          ; 1:4       895 *
    ld    H, A          ; 1:4       895 *     [895x] = 127x + 768x  
                        ;[14:112]   897 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0011_1000_0001)  
    ld    A, L          ; 1:4       897 *   256x 
    ld    B, H          ; 1:4       897 *
    ld    C, L          ; 1:4       897 *   [1x] 
    add  HL, HL         ; 1:11      897 *   2x 
    add   A, L          ; 1:4       897 *   768x 
    add  HL, HL         ; 1:11      897 *   4x 
    add  HL, HL         ; 1:11      897 *   8x 
    add  HL, HL         ; 1:11      897 *   16x 
    add  HL, HL         ; 1:11      897 *   32x 
    add  HL, HL         ; 1:11      897 *   64x 
    add  HL, HL         ; 1:11      897 *   128x 
    add   A, B          ; 1:4       897 *
    ld    B, A          ; 1:4       897 *   [769x] 
    add  HL, BC         ; 1:11      897 *   [897x] = 128x + 769x   
                        ;[15:123]   899 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1000_0011)
    ld    B, H          ; 1:4       899 *
    ld    C, L          ; 1:4       899 *   1       1x = base 
    ld    A, L          ; 1:4       899 *   256*L = 256x 
    add  HL, HL         ; 1:11      899 *   0  *2 = 2x 
    add   A, L          ; 1:4       899 *  +256*L = 768x 
    add  HL, HL         ; 1:11      899 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      899 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      899 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      899 *   0  *2 = 32x 
    add  HL, HL         ; 1:11      899 *   1  *2 = 64x
    add  HL, BC         ; 1:11      899 *      +1 = 65x 
    add  HL, HL         ; 1:11      899 *   1  *2 = 130x
    add  HL, BC         ; 1:11      899 *      +1 = 131x 
    add   A, H          ; 1:4       899 *
    ld    H, A          ; 1:4       899 *     [899x] = 131x + 768x  
                        ;[15:123]   901 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1000_0101)
    ld    B, H          ; 1:4       901 *
    ld    C, L          ; 1:4       901 *   1       1x = base 
    ld    A, L          ; 1:4       901 *   256*L = 256x 
    add  HL, HL         ; 1:11      901 *   0  *2 = 2x 
    add   A, L          ; 1:4       901 *  +256*L = 768x 
    add  HL, HL         ; 1:11      901 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      901 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      901 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      901 *   1  *2 = 32x
    add  HL, BC         ; 1:11      901 *      +1 = 33x 
    add  HL, HL         ; 1:11      901 *   0  *2 = 66x 
    add  HL, HL         ; 1:11      901 *   1  *2 = 132x
    add  HL, BC         ; 1:11      901 *      +1 = 133x 
    add   A, H          ; 1:4       901 *
    ld    H, A          ; 1:4       901 *     [901x] = 133x + 768x  
                        ;[16:134]   903 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1000_0111)
    ld    B, H          ; 1:4       903 *
    ld    C, L          ; 1:4       903 *   1       1x = base 
    ld    A, L          ; 1:4       903 *   256*L = 256x 
    add  HL, HL         ; 1:11      903 *   0  *2 = 2x 
    add   A, L          ; 1:4       903 *  +256*L = 768x 
    add  HL, HL         ; 1:11      903 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      903 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      903 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      903 *   1  *2 = 32x
    add  HL, BC         ; 1:11      903 *      +1 = 33x 
    add  HL, HL         ; 1:11      903 *   1  *2 = 66x
    add  HL, BC         ; 1:11      903 *      +1 = 67x 
    add  HL, HL         ; 1:11      903 *   1  *2 = 134x
    add  HL, BC         ; 1:11      903 *      +1 = 135x 
    add   A, H          ; 1:4       903 *
    ld    H, A          ; 1:4       903 *     [903x] = 135x + 768x  
                        ;[15:123]   905 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1000_1001)
    ld    B, H          ; 1:4       905 *
    ld    C, L          ; 1:4       905 *   1       1x = base 
    ld    A, L          ; 1:4       905 *   256*L = 256x 
    add  HL, HL         ; 1:11      905 *   0  *2 = 2x 
    add   A, L          ; 1:4       905 *  +256*L = 768x 
    add  HL, HL         ; 1:11      905 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      905 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      905 *   1  *2 = 16x
    add  HL, BC         ; 1:11      905 *      +1 = 17x 
    add  HL, HL         ; 1:11      905 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      905 *   0  *2 = 68x 
    add  HL, HL         ; 1:11      905 *   1  *2 = 136x
    add  HL, BC         ; 1:11      905 *      +1 = 137x 
    add   A, H          ; 1:4       905 *
    ld    H, A          ; 1:4       905 *     [905x] = 137x + 768x  
                        ;[16:134]   907 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1000_1011)
    ld    B, H          ; 1:4       907 *
    ld    C, L          ; 1:4       907 *   1       1x = base 
    ld    A, L          ; 1:4       907 *   256*L = 256x 
    add  HL, HL         ; 1:11      907 *   0  *2 = 2x 
    add   A, L          ; 1:4       907 *  +256*L = 768x 
    add  HL, HL         ; 1:11      907 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      907 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      907 *   1  *2 = 16x
    add  HL, BC         ; 1:11      907 *      +1 = 17x 
    add  HL, HL         ; 1:11      907 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      907 *   1  *2 = 68x
    add  HL, BC         ; 1:11      907 *      +1 = 69x 
    add  HL, HL         ; 1:11      907 *   1  *2 = 138x
    add  HL, BC         ; 1:11      907 *      +1 = 139x 
    add   A, H          ; 1:4       907 *
    ld    H, A          ; 1:4       907 *     [907x] = 139x + 768x  
                        ;[16:134]   909 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1000_1101)
    ld    B, H          ; 1:4       909 *
    ld    C, L          ; 1:4       909 *   1       1x = base 
    ld    A, L          ; 1:4       909 *   256*L = 256x 
    add  HL, HL         ; 1:11      909 *   0  *2 = 2x 
    add   A, L          ; 1:4       909 *  +256*L = 768x 
    add  HL, HL         ; 1:11      909 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      909 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      909 *   1  *2 = 16x
    add  HL, BC         ; 1:11      909 *      +1 = 17x 
    add  HL, HL         ; 1:11      909 *   1  *2 = 34x
    add  HL, BC         ; 1:11      909 *      +1 = 35x 
    add  HL, HL         ; 1:11      909 *   0  *2 = 70x 
    add  HL, HL         ; 1:11      909 *   1  *2 = 140x
    add  HL, BC         ; 1:11      909 *      +1 = 141x 
    add   A, H          ; 1:4       909 *
    ld    H, A          ; 1:4       909 *     [909x] = 141x + 768x  
                        ;[17:145]   911 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1000_1111)
    ld    B, H          ; 1:4       911 *
    ld    C, L          ; 1:4       911 *   1       1x = base 
    ld    A, L          ; 1:4       911 *   256*L = 256x 
    add  HL, HL         ; 1:11      911 *   0  *2 = 2x 
    add   A, L          ; 1:4       911 *  +256*L = 768x 
    add  HL, HL         ; 1:11      911 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      911 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      911 *   1  *2 = 16x
    add  HL, BC         ; 1:11      911 *      +1 = 17x 
    add  HL, HL         ; 1:11      911 *   1  *2 = 34x
    add  HL, BC         ; 1:11      911 *      +1 = 35x 
    add  HL, HL         ; 1:11      911 *   1  *2 = 70x
    add  HL, BC         ; 1:11      911 *      +1 = 71x 
    add  HL, HL         ; 1:11      911 *   1  *2 = 142x
    add  HL, BC         ; 1:11      911 *      +1 = 143x 
    add   A, H          ; 1:4       911 *
    ld    H, A          ; 1:4       911 *     [911x] = 143x + 768x  
                        ;[15:123]   913 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1001_0001)
    ld    B, H          ; 1:4       913 *
    ld    C, L          ; 1:4       913 *   1       1x = base 
    ld    A, L          ; 1:4       913 *   256*L = 256x 
    add  HL, HL         ; 1:11      913 *   0  *2 = 2x 
    add   A, L          ; 1:4       913 *  +256*L = 768x 
    add  HL, HL         ; 1:11      913 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      913 *   1  *2 = 8x
    add  HL, BC         ; 1:11      913 *      +1 = 9x 
    add  HL, HL         ; 1:11      913 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      913 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      913 *   0  *2 = 72x 
    add  HL, HL         ; 1:11      913 *   1  *2 = 144x
    add  HL, BC         ; 1:11      913 *      +1 = 145x 
    add   A, H          ; 1:4       913 *
    ld    H, A          ; 1:4       913 *     [913x] = 145x + 768x 

                        ;[16:134]   915 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1001_0011)
    ld    B, H          ; 1:4       915 *
    ld    C, L          ; 1:4       915 *   1       1x = base 
    ld    A, L          ; 1:4       915 *   256*L = 256x 
    add  HL, HL         ; 1:11      915 *   0  *2 = 2x 
    add   A, L          ; 1:4       915 *  +256*L = 768x 
    add  HL, HL         ; 1:11      915 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      915 *   1  *2 = 8x
    add  HL, BC         ; 1:11      915 *      +1 = 9x 
    add  HL, HL         ; 1:11      915 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      915 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      915 *   1  *2 = 72x
    add  HL, BC         ; 1:11      915 *      +1 = 73x 
    add  HL, HL         ; 1:11      915 *   1  *2 = 146x
    add  HL, BC         ; 1:11      915 *      +1 = 147x 
    add   A, H          ; 1:4       915 *
    ld    H, A          ; 1:4       915 *     [915x] = 147x + 768x  
                        ;[16:134]   917 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1001_0101)
    ld    B, H          ; 1:4       917 *
    ld    C, L          ; 1:4       917 *   1       1x = base 
    ld    A, L          ; 1:4       917 *   256*L = 256x 
    add  HL, HL         ; 1:11      917 *   0  *2 = 2x 
    add   A, L          ; 1:4       917 *  +256*L = 768x 
    add  HL, HL         ; 1:11      917 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      917 *   1  *2 = 8x
    add  HL, BC         ; 1:11      917 *      +1 = 9x 
    add  HL, HL         ; 1:11      917 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      917 *   1  *2 = 36x
    add  HL, BC         ; 1:11      917 *      +1 = 37x 
    add  HL, HL         ; 1:11      917 *   0  *2 = 74x 
    add  HL, HL         ; 1:11      917 *   1  *2 = 148x
    add  HL, BC         ; 1:11      917 *      +1 = 149x 
    add   A, H          ; 1:4       917 *
    ld    H, A          ; 1:4       917 *     [917x] = 149x + 768x  
                        ;[17:145]   919 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1001_0111)
    ld    B, H          ; 1:4       919 *
    ld    C, L          ; 1:4       919 *   1       1x = base 
    ld    A, L          ; 1:4       919 *   256*L = 256x 
    add  HL, HL         ; 1:11      919 *   0  *2 = 2x 
    add   A, L          ; 1:4       919 *  +256*L = 768x 
    add  HL, HL         ; 1:11      919 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      919 *   1  *2 = 8x
    add  HL, BC         ; 1:11      919 *      +1 = 9x 
    add  HL, HL         ; 1:11      919 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      919 *   1  *2 = 36x
    add  HL, BC         ; 1:11      919 *      +1 = 37x 
    add  HL, HL         ; 1:11      919 *   1  *2 = 74x
    add  HL, BC         ; 1:11      919 *      +1 = 75x 
    add  HL, HL         ; 1:11      919 *   1  *2 = 150x
    add  HL, BC         ; 1:11      919 *      +1 = 151x 
    add   A, H          ; 1:4       919 *
    ld    H, A          ; 1:4       919 *     [919x] = 151x + 768x  
                        ;[16:134]   921 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1001_1001)
    ld    B, H          ; 1:4       921 *
    ld    C, L          ; 1:4       921 *   1       1x = base 
    ld    A, L          ; 1:4       921 *   256*L = 256x 
    add  HL, HL         ; 1:11      921 *   0  *2 = 2x 
    add   A, L          ; 1:4       921 *  +256*L = 768x 
    add  HL, HL         ; 1:11      921 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      921 *   1  *2 = 8x
    add  HL, BC         ; 1:11      921 *      +1 = 9x 
    add  HL, HL         ; 1:11      921 *   1  *2 = 18x
    add  HL, BC         ; 1:11      921 *      +1 = 19x 
    add  HL, HL         ; 1:11      921 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      921 *   0  *2 = 76x 
    add  HL, HL         ; 1:11      921 *   1  *2 = 152x
    add  HL, BC         ; 1:11      921 *      +1 = 153x 
    add   A, H          ; 1:4       921 *
    ld    H, A          ; 1:4       921 *     [921x] = 153x + 768x  
                        ;[17:145]   923 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1001_1011)
    ld    B, H          ; 1:4       923 *
    ld    C, L          ; 1:4       923 *   1       1x = base 
    ld    A, L          ; 1:4       923 *   256*L = 256x 
    add  HL, HL         ; 1:11      923 *   0  *2 = 2x 
    add   A, L          ; 1:4       923 *  +256*L = 768x 
    add  HL, HL         ; 1:11      923 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      923 *   1  *2 = 8x
    add  HL, BC         ; 1:11      923 *      +1 = 9x 
    add  HL, HL         ; 1:11      923 *   1  *2 = 18x
    add  HL, BC         ; 1:11      923 *      +1 = 19x 
    add  HL, HL         ; 1:11      923 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      923 *   1  *2 = 76x
    add  HL, BC         ; 1:11      923 *      +1 = 77x 
    add  HL, HL         ; 1:11      923 *   1  *2 = 154x
    add  HL, BC         ; 1:11      923 *      +1 = 155x 
    add   A, H          ; 1:4       923 *
    ld    H, A          ; 1:4       923 *     [923x] = 155x + 768x  
                        ;[17:145]   925 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1001_1101)
    ld    B, H          ; 1:4       925 *
    ld    C, L          ; 1:4       925 *   1       1x = base 
    ld    A, L          ; 1:4       925 *   256*L = 256x 
    add  HL, HL         ; 1:11      925 *   0  *2 = 2x 
    add   A, L          ; 1:4       925 *  +256*L = 768x 
    add  HL, HL         ; 1:11      925 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      925 *   1  *2 = 8x
    add  HL, BC         ; 1:11      925 *      +1 = 9x 
    add  HL, HL         ; 1:11      925 *   1  *2 = 18x
    add  HL, BC         ; 1:11      925 *      +1 = 19x 
    add  HL, HL         ; 1:11      925 *   1  *2 = 38x
    add  HL, BC         ; 1:11      925 *      +1 = 39x 
    add  HL, HL         ; 1:11      925 *   0  *2 = 78x 
    add  HL, HL         ; 1:11      925 *   1  *2 = 156x
    add  HL, BC         ; 1:11      925 *      +1 = 157x 
    add   A, H          ; 1:4       925 *
    ld    H, A          ; 1:4       925 *     [925x] = 157x + 768x  
                        ;[18:156]   927 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1001_1111)
    ld    B, H          ; 1:4       927 *
    ld    C, L          ; 1:4       927 *   1       1x = base 
    ld    A, L          ; 1:4       927 *   256*L = 256x 
    add  HL, HL         ; 1:11      927 *   0  *2 = 2x 
    add   A, L          ; 1:4       927 *  +256*L = 768x 
    add  HL, HL         ; 1:11      927 *   0  *2 = 4x 
    add  HL, HL         ; 1:11      927 *   1  *2 = 8x
    add  HL, BC         ; 1:11      927 *      +1 = 9x 
    add  HL, HL         ; 1:11      927 *   1  *2 = 18x
    add  HL, BC         ; 1:11      927 *      +1 = 19x 
    add  HL, HL         ; 1:11      927 *   1  *2 = 38x
    add  HL, BC         ; 1:11      927 *      +1 = 39x 
    add  HL, HL         ; 1:11      927 *   1  *2 = 78x
    add  HL, BC         ; 1:11      927 *      +1 = 79x 
    add  HL, HL         ; 1:11      927 *   1  *2 = 158x
    add  HL, BC         ; 1:11      927 *      +1 = 159x 
    add   A, H          ; 1:4       927 *
    ld    H, A          ; 1:4       927 *     [927x] = 159x + 768x  
                        ;[15:123]   929 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1010_0001)
    ld    B, H          ; 1:4       929 *
    ld    C, L          ; 1:4       929 *   1       1x = base 
    ld    A, L          ; 1:4       929 *   256*L = 256x 
    add  HL, HL         ; 1:11      929 *   0  *2 = 2x 
    add   A, L          ; 1:4       929 *  +256*L = 768x 
    add  HL, HL         ; 1:11      929 *   1  *2 = 4x
    add  HL, BC         ; 1:11      929 *      +1 = 5x 
    add  HL, HL         ; 1:11      929 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      929 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      929 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      929 *   0  *2 = 80x 
    add  HL, HL         ; 1:11      929 *   1  *2 = 160x
    add  HL, BC         ; 1:11      929 *      +1 = 161x 
    add   A, H          ; 1:4       929 *
    ld    H, A          ; 1:4       929 *     [929x] = 161x + 768x  
                        ;[16:134]   931 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1010_0011)
    ld    B, H          ; 1:4       931 *
    ld    C, L          ; 1:4       931 *   1       1x = base 
    ld    A, L          ; 1:4       931 *   256*L = 256x 
    add  HL, HL         ; 1:11      931 *   0  *2 = 2x 
    add   A, L          ; 1:4       931 *  +256*L = 768x 
    add  HL, HL         ; 1:11      931 *   1  *2 = 4x
    add  HL, BC         ; 1:11      931 *      +1 = 5x 
    add  HL, HL         ; 1:11      931 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      931 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      931 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      931 *   1  *2 = 80x
    add  HL, BC         ; 1:11      931 *      +1 = 81x 
    add  HL, HL         ; 1:11      931 *   1  *2 = 162x
    add  HL, BC         ; 1:11      931 *      +1 = 163x 
    add   A, H          ; 1:4       931 *
    ld    H, A          ; 1:4       931 *     [931x] = 163x + 768x  
                        ;[16:134]   933 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1010_0101)
    ld    B, H          ; 1:4       933 *
    ld    C, L          ; 1:4       933 *   1       1x = base 
    ld    A, L          ; 1:4       933 *   256*L = 256x 
    add  HL, HL         ; 1:11      933 *   0  *2 = 2x 
    add   A, L          ; 1:4       933 *  +256*L = 768x 
    add  HL, HL         ; 1:11      933 *   1  *2 = 4x
    add  HL, BC         ; 1:11      933 *      +1 = 5x 
    add  HL, HL         ; 1:11      933 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      933 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      933 *   1  *2 = 40x
    add  HL, BC         ; 1:11      933 *      +1 = 41x 
    add  HL, HL         ; 1:11      933 *   0  *2 = 82x 
    add  HL, HL         ; 1:11      933 *   1  *2 = 164x
    add  HL, BC         ; 1:11      933 *      +1 = 165x 
    add   A, H          ; 1:4       933 *
    ld    H, A          ; 1:4       933 *     [933x] = 165x + 768x  
                        ;[17:145]   935 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1010_0111)
    ld    B, H          ; 1:4       935 *
    ld    C, L          ; 1:4       935 *   1       1x = base 
    ld    A, L          ; 1:4       935 *   256*L = 256x 
    add  HL, HL         ; 1:11      935 *   0  *2 = 2x 
    add   A, L          ; 1:4       935 *  +256*L = 768x 
    add  HL, HL         ; 1:11      935 *   1  *2 = 4x
    add  HL, BC         ; 1:11      935 *      +1 = 5x 
    add  HL, HL         ; 1:11      935 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      935 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      935 *   1  *2 = 40x
    add  HL, BC         ; 1:11      935 *      +1 = 41x 
    add  HL, HL         ; 1:11      935 *   1  *2 = 82x
    add  HL, BC         ; 1:11      935 *      +1 = 83x 
    add  HL, HL         ; 1:11      935 *   1  *2 = 166x
    add  HL, BC         ; 1:11      935 *      +1 = 167x 
    add   A, H          ; 1:4       935 *
    ld    H, A          ; 1:4       935 *     [935x] = 167x + 768x 

                        ;[16:134]   937 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1010_1001)
    ld    B, H          ; 1:4       937 *
    ld    C, L          ; 1:4       937 *   1       1x = base 
    ld    A, L          ; 1:4       937 *   256*L = 256x 
    add  HL, HL         ; 1:11      937 *   0  *2 = 2x 
    add   A, L          ; 1:4       937 *  +256*L = 768x 
    add  HL, HL         ; 1:11      937 *   1  *2 = 4x
    add  HL, BC         ; 1:11      937 *      +1 = 5x 
    add  HL, HL         ; 1:11      937 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      937 *   1  *2 = 20x
    add  HL, BC         ; 1:11      937 *      +1 = 21x 
    add  HL, HL         ; 1:11      937 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      937 *   0  *2 = 84x 
    add  HL, HL         ; 1:11      937 *   1  *2 = 168x
    add  HL, BC         ; 1:11      937 *      +1 = 169x 
    add   A, H          ; 1:4       937 *
    ld    H, A          ; 1:4       937 *     [937x] = 169x + 768x  
                        ;[17:145]   939 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1010_1011)
    ld    B, H          ; 1:4       939 *
    ld    C, L          ; 1:4       939 *   1       1x = base 
    ld    A, L          ; 1:4       939 *   256*L = 256x 
    add  HL, HL         ; 1:11      939 *   0  *2 = 2x 
    add   A, L          ; 1:4       939 *  +256*L = 768x 
    add  HL, HL         ; 1:11      939 *   1  *2 = 4x
    add  HL, BC         ; 1:11      939 *      +1 = 5x 
    add  HL, HL         ; 1:11      939 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      939 *   1  *2 = 20x
    add  HL, BC         ; 1:11      939 *      +1 = 21x 
    add  HL, HL         ; 1:11      939 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      939 *   1  *2 = 84x
    add  HL, BC         ; 1:11      939 *      +1 = 85x 
    add  HL, HL         ; 1:11      939 *   1  *2 = 170x
    add  HL, BC         ; 1:11      939 *      +1 = 171x 
    add   A, H          ; 1:4       939 *
    ld    H, A          ; 1:4       939 *     [939x] = 171x + 768x  
                        ;[17:145]   941 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1010_1101)
    ld    B, H          ; 1:4       941 *
    ld    C, L          ; 1:4       941 *   1       1x = base 
    ld    A, L          ; 1:4       941 *   256*L = 256x 
    add  HL, HL         ; 1:11      941 *   0  *2 = 2x 
    add   A, L          ; 1:4       941 *  +256*L = 768x 
    add  HL, HL         ; 1:11      941 *   1  *2 = 4x
    add  HL, BC         ; 1:11      941 *      +1 = 5x 
    add  HL, HL         ; 1:11      941 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      941 *   1  *2 = 20x
    add  HL, BC         ; 1:11      941 *      +1 = 21x 
    add  HL, HL         ; 1:11      941 *   1  *2 = 42x
    add  HL, BC         ; 1:11      941 *      +1 = 43x 
    add  HL, HL         ; 1:11      941 *   0  *2 = 86x 
    add  HL, HL         ; 1:11      941 *   1  *2 = 172x
    add  HL, BC         ; 1:11      941 *      +1 = 173x 
    add   A, H          ; 1:4       941 *
    ld    H, A          ; 1:4       941 *     [941x] = 173x + 768x  
                        ;[18:156]   943 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1010_1111)
    ld    B, H          ; 1:4       943 *
    ld    C, L          ; 1:4       943 *   1       1x = base 
    ld    A, L          ; 1:4       943 *   256*L = 256x 
    add  HL, HL         ; 1:11      943 *   0  *2 = 2x 
    add   A, L          ; 1:4       943 *  +256*L = 768x 
    add  HL, HL         ; 1:11      943 *   1  *2 = 4x
    add  HL, BC         ; 1:11      943 *      +1 = 5x 
    add  HL, HL         ; 1:11      943 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      943 *   1  *2 = 20x
    add  HL, BC         ; 1:11      943 *      +1 = 21x 
    add  HL, HL         ; 1:11      943 *   1  *2 = 42x
    add  HL, BC         ; 1:11      943 *      +1 = 43x 
    add  HL, HL         ; 1:11      943 *   1  *2 = 86x
    add  HL, BC         ; 1:11      943 *      +1 = 87x 
    add  HL, HL         ; 1:11      943 *   1  *2 = 174x
    add  HL, BC         ; 1:11      943 *      +1 = 175x 
    add   A, H          ; 1:4       943 *
    ld    H, A          ; 1:4       943 *     [943x] = 175x + 768x  
                        ;[16:134]   945 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1011_0001)
    ld    B, H          ; 1:4       945 *
    ld    C, L          ; 1:4       945 *   1       1x = base 
    ld    A, L          ; 1:4       945 *   256*L = 256x 
    add  HL, HL         ; 1:11      945 *   0  *2 = 2x 
    add   A, L          ; 1:4       945 *  +256*L = 768x 
    add  HL, HL         ; 1:11      945 *   1  *2 = 4x
    add  HL, BC         ; 1:11      945 *      +1 = 5x 
    add  HL, HL         ; 1:11      945 *   1  *2 = 10x
    add  HL, BC         ; 1:11      945 *      +1 = 11x 
    add  HL, HL         ; 1:11      945 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      945 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      945 *   0  *2 = 88x 
    add  HL, HL         ; 1:11      945 *   1  *2 = 176x
    add  HL, BC         ; 1:11      945 *      +1 = 177x 
    add   A, H          ; 1:4       945 *
    ld    H, A          ; 1:4       945 *     [945x] = 177x + 768x  
                        ;[17:145]   947 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1011_0011)
    ld    B, H          ; 1:4       947 *
    ld    C, L          ; 1:4       947 *   1       1x = base 
    ld    A, L          ; 1:4       947 *   256*L = 256x 
    add  HL, HL         ; 1:11      947 *   0  *2 = 2x 
    add   A, L          ; 1:4       947 *  +256*L = 768x 
    add  HL, HL         ; 1:11      947 *   1  *2 = 4x
    add  HL, BC         ; 1:11      947 *      +1 = 5x 
    add  HL, HL         ; 1:11      947 *   1  *2 = 10x
    add  HL, BC         ; 1:11      947 *      +1 = 11x 
    add  HL, HL         ; 1:11      947 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      947 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      947 *   1  *2 = 88x
    add  HL, BC         ; 1:11      947 *      +1 = 89x 
    add  HL, HL         ; 1:11      947 *   1  *2 = 178x
    add  HL, BC         ; 1:11      947 *      +1 = 179x 
    add   A, H          ; 1:4       947 *
    ld    H, A          ; 1:4       947 *     [947x] = 179x + 768x  
                        ;[17:145]   949 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1011_0101)
    ld    B, H          ; 1:4       949 *
    ld    C, L          ; 1:4       949 *   1       1x = base 
    ld    A, L          ; 1:4       949 *   256*L = 256x 
    add  HL, HL         ; 1:11      949 *   0  *2 = 2x 
    add   A, L          ; 1:4       949 *  +256*L = 768x 
    add  HL, HL         ; 1:11      949 *   1  *2 = 4x
    add  HL, BC         ; 1:11      949 *      +1 = 5x 
    add  HL, HL         ; 1:11      949 *   1  *2 = 10x
    add  HL, BC         ; 1:11      949 *      +1 = 11x 
    add  HL, HL         ; 1:11      949 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      949 *   1  *2 = 44x
    add  HL, BC         ; 1:11      949 *      +1 = 45x 
    add  HL, HL         ; 1:11      949 *   0  *2 = 90x 
    add  HL, HL         ; 1:11      949 *   1  *2 = 180x
    add  HL, BC         ; 1:11      949 *      +1 = 181x 
    add   A, H          ; 1:4       949 *
    ld    H, A          ; 1:4       949 *     [949x] = 181x + 768x  
                        ;[18:156]   951 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1011_0111)
    ld    B, H          ; 1:4       951 *
    ld    C, L          ; 1:4       951 *   1       1x = base 
    ld    A, L          ; 1:4       951 *   256*L = 256x 
    add  HL, HL         ; 1:11      951 *   0  *2 = 2x 
    add   A, L          ; 1:4       951 *  +256*L = 768x 
    add  HL, HL         ; 1:11      951 *   1  *2 = 4x
    add  HL, BC         ; 1:11      951 *      +1 = 5x 
    add  HL, HL         ; 1:11      951 *   1  *2 = 10x
    add  HL, BC         ; 1:11      951 *      +1 = 11x 
    add  HL, HL         ; 1:11      951 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      951 *   1  *2 = 44x
    add  HL, BC         ; 1:11      951 *      +1 = 45x 
    add  HL, HL         ; 1:11      951 *   1  *2 = 90x
    add  HL, BC         ; 1:11      951 *      +1 = 91x 
    add  HL, HL         ; 1:11      951 *   1  *2 = 182x
    add  HL, BC         ; 1:11      951 *      +1 = 183x 
    add   A, H          ; 1:4       951 *
    ld    H, A          ; 1:4       951 *     [951x] = 183x + 768x  
                        ;[17:145]   953 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1011_1001)
    ld    B, H          ; 1:4       953 *
    ld    C, L          ; 1:4       953 *   1       1x = base 
    ld    A, L          ; 1:4       953 *   256*L = 256x 
    add  HL, HL         ; 1:11      953 *   0  *2 = 2x 
    add   A, L          ; 1:4       953 *  +256*L = 768x 
    add  HL, HL         ; 1:11      953 *   1  *2 = 4x
    add  HL, BC         ; 1:11      953 *      +1 = 5x 
    add  HL, HL         ; 1:11      953 *   1  *2 = 10x
    add  HL, BC         ; 1:11      953 *      +1 = 11x 
    add  HL, HL         ; 1:11      953 *   1  *2 = 22x
    add  HL, BC         ; 1:11      953 *      +1 = 23x 
    add  HL, HL         ; 1:11      953 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      953 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      953 *   1  *2 = 184x
    add  HL, BC         ; 1:11      953 *      +1 = 185x 
    add   A, H          ; 1:4       953 *
    ld    H, A          ; 1:4       953 *     [953x] = 185x + 768x  
                        ;[18:156]   955 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1011_1011)
    ld    B, H          ; 1:4       955 *
    ld    C, L          ; 1:4       955 *   1       1x = base 
    ld    A, L          ; 1:4       955 *   256*L = 256x 
    add  HL, HL         ; 1:11      955 *   0  *2 = 2x 
    add   A, L          ; 1:4       955 *  +256*L = 768x 
    add  HL, HL         ; 1:11      955 *   1  *2 = 4x
    add  HL, BC         ; 1:11      955 *      +1 = 5x 
    add  HL, HL         ; 1:11      955 *   1  *2 = 10x
    add  HL, BC         ; 1:11      955 *      +1 = 11x 
    add  HL, HL         ; 1:11      955 *   1  *2 = 22x
    add  HL, BC         ; 1:11      955 *      +1 = 23x 
    add  HL, HL         ; 1:11      955 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      955 *   1  *2 = 92x
    add  HL, BC         ; 1:11      955 *      +1 = 93x 
    add  HL, HL         ; 1:11      955 *   1  *2 = 186x
    add  HL, BC         ; 1:11      955 *      +1 = 187x 
    add   A, H          ; 1:4       955 *
    ld    H, A          ; 1:4       955 *     [955x] = 187x + 768x  
                        ;[18:156]   957 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1011_1101)
    ld    B, H          ; 1:4       957 *
    ld    C, L          ; 1:4       957 *   1       1x = base 
    ld    A, L          ; 1:4       957 *   256*L = 256x 
    add  HL, HL         ; 1:11      957 *   0  *2 = 2x 
    add   A, L          ; 1:4       957 *  +256*L = 768x 
    add  HL, HL         ; 1:11      957 *   1  *2 = 4x
    add  HL, BC         ; 1:11      957 *      +1 = 5x 
    add  HL, HL         ; 1:11      957 *   1  *2 = 10x
    add  HL, BC         ; 1:11      957 *      +1 = 11x 
    add  HL, HL         ; 1:11      957 *   1  *2 = 22x
    add  HL, BC         ; 1:11      957 *      +1 = 23x 
    add  HL, HL         ; 1:11      957 *   1  *2 = 46x
    add  HL, BC         ; 1:11      957 *      +1 = 47x 
    add  HL, HL         ; 1:11      957 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      957 *   1  *2 = 188x
    add  HL, BC         ; 1:11      957 *      +1 = 189x 
    add   A, H          ; 1:4       957 *
    ld    H, A          ; 1:4       957 *     [957x] = 189x + 768x 

                        ;[17:117]   959 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_0100_0001)  
    ld    B, H          ; 1:4       959 *
    ld    C, L          ; 1:4       959 *   [1x] 
    add  HL, HL         ; 1:11      959 *   2x 
    add  HL, HL         ; 1:11      959 *   4x 
    ld    A, L          ; 1:4       959 *   save --1024x-- 
    add  HL, HL         ; 1:11      959 *   8x 
    add  HL, HL         ; 1:11      959 *   16x 
    add  HL, HL         ; 1:11      959 *   32x 
    add  HL, HL         ; 1:11      959 *   64x 
    add  HL, BC         ; 1:11      959 *   [65x]
    ld    B, A          ; 1:4       959 *   A0 - HL
    xor   A             ; 1:4       959 *
    sub   L             ; 1:4       959 *
    ld    L, A          ; 1:4       959 *
    ld    A, B          ; 1:4       959 *
    sbc   A, H          ; 1:4       959 *
    ld    H, A          ; 1:4       959 *   [959x] = 1024x - 1024x    
                        ;[14:119]   961 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1100_0001)
    ld    B, H          ; 1:4       961 *
    ld    C, L          ; 1:4       961 *   1       1x = base 
    add  HL, HL         ; 1:11      961 *   1  *2 = 2x
    add  HL, BC         ; 1:11      961 *      +1 = 3x 
    ld    A, L          ; 1:4       961 *   256*L = 768x 
    add  HL, HL         ; 1:11      961 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      961 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      961 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      961 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      961 *   0  *2 = 96x 
    add  HL, HL         ; 1:11      961 *   1  *2 = 192x
    add  HL, BC         ; 1:11      961 *      +1 = 193x 
    add   A, H          ; 1:4       961 *
    ld    H, A          ; 1:4       961 *     [961x] = 193x + 768x  
                        ;[15:130]   963 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1100_0011)
    ld    B, H          ; 1:4       963 *
    ld    C, L          ; 1:4       963 *   1       1x = base 
    add  HL, HL         ; 1:11      963 *   1  *2 = 2x
    add  HL, BC         ; 1:11      963 *      +1 = 3x 
    ld    A, L          ; 1:4       963 *   256*L = 768x 
    add  HL, HL         ; 1:11      963 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      963 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      963 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      963 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      963 *   1  *2 = 96x
    add  HL, BC         ; 1:11      963 *      +1 = 97x 
    add  HL, HL         ; 1:11      963 *   1  *2 = 194x
    add  HL, BC         ; 1:11      963 *      +1 = 195x 
    add   A, H          ; 1:4       963 *
    ld    H, A          ; 1:4       963 *     [963x] = 195x + 768x  
                        ;[15:130]   965 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1100_0101)
    ld    B, H          ; 1:4       965 *
    ld    C, L          ; 1:4       965 *   1       1x = base 
    add  HL, HL         ; 1:11      965 *   1  *2 = 2x
    add  HL, BC         ; 1:11      965 *      +1 = 3x 
    ld    A, L          ; 1:4       965 *   256*L = 768x 
    add  HL, HL         ; 1:11      965 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      965 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      965 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      965 *   1  *2 = 48x
    add  HL, BC         ; 1:11      965 *      +1 = 49x 
    add  HL, HL         ; 1:11      965 *   0  *2 = 98x 
    add  HL, HL         ; 1:11      965 *   1  *2 = 196x
    add  HL, BC         ; 1:11      965 *      +1 = 197x 
    add   A, H          ; 1:4       965 *
    ld    H, A          ; 1:4       965 *     [965x] = 197x + 768x  
                        ;[16:141]   967 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1100_0111)
    ld    B, H          ; 1:4       967 *
    ld    C, L          ; 1:4       967 *   1       1x = base 
    add  HL, HL         ; 1:11      967 *   1  *2 = 2x
    add  HL, BC         ; 1:11      967 *      +1 = 3x 
    ld    A, L          ; 1:4       967 *   256*L = 768x 
    add  HL, HL         ; 1:11      967 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      967 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      967 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      967 *   1  *2 = 48x
    add  HL, BC         ; 1:11      967 *      +1 = 49x 
    add  HL, HL         ; 1:11      967 *   1  *2 = 98x
    add  HL, BC         ; 1:11      967 *      +1 = 99x 
    add  HL, HL         ; 1:11      967 *   1  *2 = 198x
    add  HL, BC         ; 1:11      967 *      +1 = 199x 
    add   A, H          ; 1:4       967 *
    ld    H, A          ; 1:4       967 *     [967x] = 199x + 768x  
                        ;[15:130]   969 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1100_1001)
    ld    B, H          ; 1:4       969 *
    ld    C, L          ; 1:4       969 *   1       1x = base 
    add  HL, HL         ; 1:11      969 *   1  *2 = 2x
    add  HL, BC         ; 1:11      969 *      +1 = 3x 
    ld    A, L          ; 1:4       969 *   256*L = 768x 
    add  HL, HL         ; 1:11      969 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      969 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      969 *   1  *2 = 24x
    add  HL, BC         ; 1:11      969 *      +1 = 25x 
    add  HL, HL         ; 1:11      969 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      969 *   0  *2 = 100x 
    add  HL, HL         ; 1:11      969 *   1  *2 = 200x
    add  HL, BC         ; 1:11      969 *      +1 = 201x 
    add   A, H          ; 1:4       969 *
    ld    H, A          ; 1:4       969 *     [969x] = 201x + 768x  
                        ;[16:141]   971 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1100_1011)
    ld    B, H          ; 1:4       971 *
    ld    C, L          ; 1:4       971 *   1       1x = base 
    add  HL, HL         ; 1:11      971 *   1  *2 = 2x
    add  HL, BC         ; 1:11      971 *      +1 = 3x 
    ld    A, L          ; 1:4       971 *   256*L = 768x 
    add  HL, HL         ; 1:11      971 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      971 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      971 *   1  *2 = 24x
    add  HL, BC         ; 1:11      971 *      +1 = 25x 
    add  HL, HL         ; 1:11      971 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      971 *   1  *2 = 100x
    add  HL, BC         ; 1:11      971 *      +1 = 101x 
    add  HL, HL         ; 1:11      971 *   1  *2 = 202x
    add  HL, BC         ; 1:11      971 *      +1 = 203x 
    add   A, H          ; 1:4       971 *
    ld    H, A          ; 1:4       971 *     [971x] = 203x + 768x  
                        ;[16:141]   973 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1100_1101)
    ld    B, H          ; 1:4       973 *
    ld    C, L          ; 1:4       973 *   1       1x = base 
    add  HL, HL         ; 1:11      973 *   1  *2 = 2x
    add  HL, BC         ; 1:11      973 *      +1 = 3x 
    ld    A, L          ; 1:4       973 *   256*L = 768x 
    add  HL, HL         ; 1:11      973 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      973 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      973 *   1  *2 = 24x
    add  HL, BC         ; 1:11      973 *      +1 = 25x 
    add  HL, HL         ; 1:11      973 *   1  *2 = 50x
    add  HL, BC         ; 1:11      973 *      +1 = 51x 
    add  HL, HL         ; 1:11      973 *   0  *2 = 102x 
    add  HL, HL         ; 1:11      973 *   1  *2 = 204x
    add  HL, BC         ; 1:11      973 *      +1 = 205x 
    add   A, H          ; 1:4       973 *
    ld    H, A          ; 1:4       973 *     [973x] = 205x + 768x  
                        ;[17:152]   975 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1100_1111)
    ld    B, H          ; 1:4       975 *
    ld    C, L          ; 1:4       975 *   1       1x = base 
    add  HL, HL         ; 1:11      975 *   1  *2 = 2x
    add  HL, BC         ; 1:11      975 *      +1 = 3x 
    ld    A, L          ; 1:4       975 *   256*L = 768x 
    add  HL, HL         ; 1:11      975 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      975 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      975 *   1  *2 = 24x
    add  HL, BC         ; 1:11      975 *      +1 = 25x 
    add  HL, HL         ; 1:11      975 *   1  *2 = 50x
    add  HL, BC         ; 1:11      975 *      +1 = 51x 
    add  HL, HL         ; 1:11      975 *   1  *2 = 102x
    add  HL, BC         ; 1:11      975 *      +1 = 103x 
    add  HL, HL         ; 1:11      975 *   1  *2 = 206x
    add  HL, BC         ; 1:11      975 *      +1 = 207x 
    add   A, H          ; 1:4       975 *
    ld    H, A          ; 1:4       975 *     [975x] = 207x + 768x  
                        ;[15:130]   977 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1101_0001)
    ld    B, H          ; 1:4       977 *
    ld    C, L          ; 1:4       977 *   1       1x = base 
    add  HL, HL         ; 1:11      977 *   1  *2 = 2x
    add  HL, BC         ; 1:11      977 *      +1 = 3x 
    ld    A, L          ; 1:4       977 *   256*L = 768x 
    add  HL, HL         ; 1:11      977 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      977 *   1  *2 = 12x
    add  HL, BC         ; 1:11      977 *      +1 = 13x 
    add  HL, HL         ; 1:11      977 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      977 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      977 *   0  *2 = 104x 
    add  HL, HL         ; 1:11      977 *   1  *2 = 208x
    add  HL, BC         ; 1:11      977 *      +1 = 209x 
    add   A, H          ; 1:4       977 *
    ld    H, A          ; 1:4       977 *     [977x] = 209x + 768x  
                        ;[16:141]   979 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1101_0011)
    ld    B, H          ; 1:4       979 *
    ld    C, L          ; 1:4       979 *   1       1x = base 
    add  HL, HL         ; 1:11      979 *   1  *2 = 2x
    add  HL, BC         ; 1:11      979 *      +1 = 3x 
    ld    A, L          ; 1:4       979 *   256*L = 768x 
    add  HL, HL         ; 1:11      979 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      979 *   1  *2 = 12x
    add  HL, BC         ; 1:11      979 *      +1 = 13x 
    add  HL, HL         ; 1:11      979 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      979 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      979 *   1  *2 = 104x
    add  HL, BC         ; 1:11      979 *      +1 = 105x 
    add  HL, HL         ; 1:11      979 *   1  *2 = 210x
    add  HL, BC         ; 1:11      979 *      +1 = 211x 
    add   A, H          ; 1:4       979 *
    ld    H, A          ; 1:4       979 *     [979x] = 211x + 768x 

                        ;[16:141]   981 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1101_0101)
    ld    B, H          ; 1:4       981 *
    ld    C, L          ; 1:4       981 *   1       1x = base 
    add  HL, HL         ; 1:11      981 *   1  *2 = 2x
    add  HL, BC         ; 1:11      981 *      +1 = 3x 
    ld    A, L          ; 1:4       981 *   256*L = 768x 
    add  HL, HL         ; 1:11      981 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      981 *   1  *2 = 12x
    add  HL, BC         ; 1:11      981 *      +1 = 13x 
    add  HL, HL         ; 1:11      981 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      981 *   1  *2 = 52x
    add  HL, BC         ; 1:11      981 *      +1 = 53x 
    add  HL, HL         ; 1:11      981 *   0  *2 = 106x 
    add  HL, HL         ; 1:11      981 *   1  *2 = 212x
    add  HL, BC         ; 1:11      981 *      +1 = 213x 
    add   A, H          ; 1:4       981 *
    ld    H, A          ; 1:4       981 *     [981x] = 213x + 768x  
                        ;[17:152]   983 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1101_0111)
    ld    B, H          ; 1:4       983 *
    ld    C, L          ; 1:4       983 *   1       1x = base 
    add  HL, HL         ; 1:11      983 *   1  *2 = 2x
    add  HL, BC         ; 1:11      983 *      +1 = 3x 
    ld    A, L          ; 1:4       983 *   256*L = 768x 
    add  HL, HL         ; 1:11      983 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      983 *   1  *2 = 12x
    add  HL, BC         ; 1:11      983 *      +1 = 13x 
    add  HL, HL         ; 1:11      983 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      983 *   1  *2 = 52x
    add  HL, BC         ; 1:11      983 *      +1 = 53x 
    add  HL, HL         ; 1:11      983 *   1  *2 = 106x
    add  HL, BC         ; 1:11      983 *      +1 = 107x 
    add  HL, HL         ; 1:11      983 *   1  *2 = 214x
    add  HL, BC         ; 1:11      983 *      +1 = 215x 
    add   A, H          ; 1:4       983 *
    ld    H, A          ; 1:4       983 *     [983x] = 215x + 768x  
                        ;[16:141]   985 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1101_1001)
    ld    B, H          ; 1:4       985 *
    ld    C, L          ; 1:4       985 *   1       1x = base 
    add  HL, HL         ; 1:11      985 *   1  *2 = 2x
    add  HL, BC         ; 1:11      985 *      +1 = 3x 
    ld    A, L          ; 1:4       985 *   256*L = 768x 
    add  HL, HL         ; 1:11      985 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      985 *   1  *2 = 12x
    add  HL, BC         ; 1:11      985 *      +1 = 13x 
    add  HL, HL         ; 1:11      985 *   1  *2 = 26x
    add  HL, BC         ; 1:11      985 *      +1 = 27x 
    add  HL, HL         ; 1:11      985 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      985 *   0  *2 = 108x 
    add  HL, HL         ; 1:11      985 *   1  *2 = 216x
    add  HL, BC         ; 1:11      985 *      +1 = 217x 
    add   A, H          ; 1:4       985 *
    ld    H, A          ; 1:4       985 *     [985x] = 217x + 768x  
                        ;[17:152]   987 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1101_1011)
    ld    B, H          ; 1:4       987 *
    ld    C, L          ; 1:4       987 *   1       1x = base 
    add  HL, HL         ; 1:11      987 *   1  *2 = 2x
    add  HL, BC         ; 1:11      987 *      +1 = 3x 
    ld    A, L          ; 1:4       987 *   256*L = 768x 
    add  HL, HL         ; 1:11      987 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      987 *   1  *2 = 12x
    add  HL, BC         ; 1:11      987 *      +1 = 13x 
    add  HL, HL         ; 1:11      987 *   1  *2 = 26x
    add  HL, BC         ; 1:11      987 *      +1 = 27x 
    add  HL, HL         ; 1:11      987 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      987 *   1  *2 = 108x
    add  HL, BC         ; 1:11      987 *      +1 = 109x 
    add  HL, HL         ; 1:11      987 *   1  *2 = 218x
    add  HL, BC         ; 1:11      987 *      +1 = 219x 
    add   A, H          ; 1:4       987 *
    ld    H, A          ; 1:4       987 *     [987x] = 219x + 768x  
                        ;[17:152]   989 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1101_1101)
    ld    B, H          ; 1:4       989 *
    ld    C, L          ; 1:4       989 *   1       1x = base 
    add  HL, HL         ; 1:11      989 *   1  *2 = 2x
    add  HL, BC         ; 1:11      989 *      +1 = 3x 
    ld    A, L          ; 1:4       989 *   256*L = 768x 
    add  HL, HL         ; 1:11      989 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      989 *   1  *2 = 12x
    add  HL, BC         ; 1:11      989 *      +1 = 13x 
    add  HL, HL         ; 1:11      989 *   1  *2 = 26x
    add  HL, BC         ; 1:11      989 *      +1 = 27x 
    add  HL, HL         ; 1:11      989 *   1  *2 = 54x
    add  HL, BC         ; 1:11      989 *      +1 = 55x 
    add  HL, HL         ; 1:11      989 *   0  *2 = 110x 
    add  HL, HL         ; 1:11      989 *   1  *2 = 220x
    add  HL, BC         ; 1:11      989 *      +1 = 221x 
    add   A, H          ; 1:4       989 *
    ld    H, A          ; 1:4       989 *     [989x] = 221x + 768x  
                        ;[16:106]   991 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_0010_0001)  
    ld    B, H          ; 1:4       991 *
    ld    C, L          ; 1:4       991 *   [1x] 
    add  HL, HL         ; 1:11      991 *   2x 
    add  HL, HL         ; 1:11      991 *   4x 
    ld    A, L          ; 1:4       991 *   save --1024x-- 
    add  HL, HL         ; 1:11      991 *   8x 
    add  HL, HL         ; 1:11      991 *   16x 
    add  HL, HL         ; 1:11      991 *   32x 
    add  HL, BC         ; 1:11      991 *   [33x]
    ld    B, A          ; 1:4       991 *   A0 - HL
    xor   A             ; 1:4       991 *
    sub   L             ; 1:4       991 *
    ld    L, A          ; 1:4       991 *
    ld    A, B          ; 1:4       991 *
    sbc   A, H          ; 1:4       991 *
    ld    H, A          ; 1:4       991 *   [991x] = 1024x - 1024x    
                        ;[15:130]   993 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1110_0001)
    ld    B, H          ; 1:4       993 *
    ld    C, L          ; 1:4       993 *   1       1x = base 
    add  HL, HL         ; 1:11      993 *   1  *2 = 2x
    add  HL, BC         ; 1:11      993 *      +1 = 3x 
    ld    A, L          ; 1:4       993 *   256*L = 768x 
    add  HL, HL         ; 1:11      993 *   1  *2 = 6x
    add  HL, BC         ; 1:11      993 *      +1 = 7x 
    add  HL, HL         ; 1:11      993 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      993 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      993 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      993 *   0  *2 = 112x 
    add  HL, HL         ; 1:11      993 *   1  *2 = 224x
    add  HL, BC         ; 1:11      993 *      +1 = 225x 
    add   A, H          ; 1:4       993 *
    ld    H, A          ; 1:4       993 *     [993x] = 225x + 768x  
                        ;[16:141]   995 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1110_0011)
    ld    B, H          ; 1:4       995 *
    ld    C, L          ; 1:4       995 *   1       1x = base 
    add  HL, HL         ; 1:11      995 *   1  *2 = 2x
    add  HL, BC         ; 1:11      995 *      +1 = 3x 
    ld    A, L          ; 1:4       995 *   256*L = 768x 
    add  HL, HL         ; 1:11      995 *   1  *2 = 6x
    add  HL, BC         ; 1:11      995 *      +1 = 7x 
    add  HL, HL         ; 1:11      995 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      995 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      995 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      995 *   1  *2 = 112x
    add  HL, BC         ; 1:11      995 *      +1 = 113x 
    add  HL, HL         ; 1:11      995 *   1  *2 = 226x
    add  HL, BC         ; 1:11      995 *      +1 = 227x 
    add   A, H          ; 1:4       995 *
    ld    H, A          ; 1:4       995 *     [995x] = 227x + 768x  
                        ;[16:141]   997 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1110_0101)
    ld    B, H          ; 1:4       997 *
    ld    C, L          ; 1:4       997 *   1       1x = base 
    add  HL, HL         ; 1:11      997 *   1  *2 = 2x
    add  HL, BC         ; 1:11      997 *      +1 = 3x 
    ld    A, L          ; 1:4       997 *   256*L = 768x 
    add  HL, HL         ; 1:11      997 *   1  *2 = 6x
    add  HL, BC         ; 1:11      997 *      +1 = 7x 
    add  HL, HL         ; 1:11      997 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      997 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      997 *   1  *2 = 56x
    add  HL, BC         ; 1:11      997 *      +1 = 57x 
    add  HL, HL         ; 1:11      997 *   0  *2 = 114x 
    add  HL, HL         ; 1:11      997 *   1  *2 = 228x
    add  HL, BC         ; 1:11      997 *      +1 = 229x 
    add   A, H          ; 1:4       997 *
    ld    H, A          ; 1:4       997 *     [997x] = 229x + 768x  
                        ;[17:152]   999 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1110_0111)
    ld    B, H          ; 1:4       999 *
    ld    C, L          ; 1:4       999 *   1       1x = base 
    add  HL, HL         ; 1:11      999 *   1  *2 = 2x
    add  HL, BC         ; 1:11      999 *      +1 = 3x 
    ld    A, L          ; 1:4       999 *   256*L = 768x 
    add  HL, HL         ; 1:11      999 *   1  *2 = 6x
    add  HL, BC         ; 1:11      999 *      +1 = 7x 
    add  HL, HL         ; 1:11      999 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      999 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      999 *   1  *2 = 56x
    add  HL, BC         ; 1:11      999 *      +1 = 57x 
    add  HL, HL         ; 1:11      999 *   1  *2 = 114x
    add  HL, BC         ; 1:11      999 *      +1 = 115x 
    add  HL, HL         ; 1:11      999 *   1  *2 = 230x
    add  HL, BC         ; 1:11      999 *      +1 = 231x 
    add   A, H          ; 1:4       999 *
    ld    H, A          ; 1:4       999 *     [999x] = 231x + 768x  
                        ;[16:141]   1001 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1110_1001)
    ld    B, H          ; 1:4       1001 *
    ld    C, L          ; 1:4       1001 *   1       1x = base 
    add  HL, HL         ; 1:11      1001 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1001 *      +1 = 3x 
    ld    A, L          ; 1:4       1001 *   256*L = 768x 
    add  HL, HL         ; 1:11      1001 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1001 *      +1 = 7x 
    add  HL, HL         ; 1:11      1001 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1001 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1001 *      +1 = 29x 
    add  HL, HL         ; 1:11      1001 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1001 *   0  *2 = 116x 
    add  HL, HL         ; 1:11      1001 *   1  *2 = 232x
    add  HL, BC         ; 1:11      1001 *      +1 = 233x 
    add   A, H          ; 1:4       1001 *
    ld    H, A          ; 1:4       1001 *     [1001x] = 233x + 768x 


                        ;[17:152]   1003 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1110_1011)
    ld    B, H          ; 1:4       1003 *
    ld    C, L          ; 1:4       1003 *   1       1x = base 
    add  HL, HL         ; 1:11      1003 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1003 *      +1 = 3x 
    ld    A, L          ; 1:4       1003 *   256*L = 768x 
    add  HL, HL         ; 1:11      1003 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1003 *      +1 = 7x 
    add  HL, HL         ; 1:11      1003 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1003 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1003 *      +1 = 29x 
    add  HL, HL         ; 1:11      1003 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1003 *   1  *2 = 116x
    add  HL, BC         ; 1:11      1003 *      +1 = 117x 
    add  HL, HL         ; 1:11      1003 *   1  *2 = 234x
    add  HL, BC         ; 1:11      1003 *      +1 = 235x 
    add   A, H          ; 1:4       1003 *
    ld    H, A          ; 1:4       1003 *     [1003x] = 235x + 768x  
                        ;[17:152]   1005 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1110_1101)
    ld    B, H          ; 1:4       1005 *
    ld    C, L          ; 1:4       1005 *   1       1x = base 
    add  HL, HL         ; 1:11      1005 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1005 *      +1 = 3x 
    ld    A, L          ; 1:4       1005 *   256*L = 768x 
    add  HL, HL         ; 1:11      1005 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1005 *      +1 = 7x 
    add  HL, HL         ; 1:11      1005 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1005 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1005 *      +1 = 29x 
    add  HL, HL         ; 1:11      1005 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1005 *      +1 = 59x 
    add  HL, HL         ; 1:11      1005 *   0  *2 = 118x 
    add  HL, HL         ; 1:11      1005 *   1  *2 = 236x
    add  HL, BC         ; 1:11      1005 *      +1 = 237x 
    add   A, H          ; 1:4       1005 *
    ld    H, A          ; 1:4       1005 *     [1005x] = 237x + 768x  
                        ;[15:95]    1007 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_0001_0001)  
    ld    B, H          ; 1:4       1007 *
    ld    C, L          ; 1:4       1007 *   [1x] 
    add  HL, HL         ; 1:11      1007 *   2x 
    add  HL, HL         ; 1:11      1007 *   4x 
    ld    A, L          ; 1:4       1007 *   save --1024x-- 
    add  HL, HL         ; 1:11      1007 *   8x 
    add  HL, HL         ; 1:11      1007 *   16x 
    add  HL, BC         ; 1:11      1007 *   [17x]
    ld    B, A          ; 1:4       1007 *   A0 - HL
    xor   A             ; 1:4       1007 *
    sub   L             ; 1:4       1007 *
    ld    L, A          ; 1:4       1007 *
    ld    A, B          ; 1:4       1007 *
    sbc   A, H          ; 1:4       1007 *
    ld    H, A          ; 1:4       1007 *   [1007x] = 1024x - 1024x    
                        ;[16:141]   1009 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1111_0001)
    ld    B, H          ; 1:4       1009 *
    ld    C, L          ; 1:4       1009 *   1       1x = base 
    add  HL, HL         ; 1:11      1009 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1009 *      +1 = 3x 
    ld    A, L          ; 1:4       1009 *   256*L = 768x 
    add  HL, HL         ; 1:11      1009 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1009 *      +1 = 7x 
    add  HL, HL         ; 1:11      1009 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1009 *      +1 = 15x 
    add  HL, HL         ; 1:11      1009 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1009 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1009 *   0  *2 = 120x 
    add  HL, HL         ; 1:11      1009 *   1  *2 = 240x
    add  HL, BC         ; 1:11      1009 *      +1 = 241x 
    add   A, H          ; 1:4       1009 *
    ld    H, A          ; 1:4       1009 *     [1009x] = 241x + 768x  
                        ;[17:152]   1011 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1111_0011)
    ld    B, H          ; 1:4       1011 *
    ld    C, L          ; 1:4       1011 *   1       1x = base 
    add  HL, HL         ; 1:11      1011 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1011 *      +1 = 3x 
    ld    A, L          ; 1:4       1011 *   256*L = 768x 
    add  HL, HL         ; 1:11      1011 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1011 *      +1 = 7x 
    add  HL, HL         ; 1:11      1011 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1011 *      +1 = 15x 
    add  HL, HL         ; 1:11      1011 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1011 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1011 *   1  *2 = 120x
    add  HL, BC         ; 1:11      1011 *      +1 = 121x 
    add  HL, HL         ; 1:11      1011 *   1  *2 = 242x
    add  HL, BC         ; 1:11      1011 *      +1 = 243x 
    add   A, H          ; 1:4       1011 *
    ld    H, A          ; 1:4       1011 *     [1011x] = 243x + 768x  
                        ;[17:152]   1013 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1111_0101)
    ld    B, H          ; 1:4       1013 *
    ld    C, L          ; 1:4       1013 *   1       1x = base 
    add  HL, HL         ; 1:11      1013 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1013 *      +1 = 3x 
    ld    A, L          ; 1:4       1013 *   256*L = 768x 
    add  HL, HL         ; 1:11      1013 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1013 *      +1 = 7x 
    add  HL, HL         ; 1:11      1013 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1013 *      +1 = 15x 
    add  HL, HL         ; 1:11      1013 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1013 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1013 *      +1 = 61x 
    add  HL, HL         ; 1:11      1013 *   0  *2 = 122x 
    add  HL, HL         ; 1:11      1013 *   1  *2 = 244x
    add  HL, BC         ; 1:11      1013 *      +1 = 245x 
    add   A, H          ; 1:4       1013 *
    ld    H, A          ; 1:4       1013 *     [1013x] = 245x + 768x  
                        ;[14:84]    1015 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_1001)  
    ld    B, H          ; 1:4       1015 *
    ld    C, L          ; 1:4       1015 *   [1x] 
    add  HL, HL         ; 1:11      1015 *   2x 
    add  HL, HL         ; 1:11      1015 *   4x 
    ld    A, L          ; 1:4       1015 *   save --1024x-- 
    add  HL, HL         ; 1:11      1015 *   8x 
    add  HL, BC         ; 1:11      1015 *   [9x]
    ld    B, A          ; 1:4       1015 *   A0 - HL
    xor   A             ; 1:4       1015 *
    sub   L             ; 1:4       1015 *
    ld    L, A          ; 1:4       1015 *
    ld    A, B          ; 1:4       1015 *
    sbc   A, H          ; 1:4       1015 *
    ld    H, A          ; 1:4       1015 *   [1015x] = 1024x - 1024x    
                        ;[17:152]   1017 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0011_1111_1001)
    ld    B, H          ; 1:4       1017 *
    ld    C, L          ; 1:4       1017 *   1       1x = base 
    add  HL, HL         ; 1:11      1017 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1017 *      +1 = 3x 
    ld    A, L          ; 1:4       1017 *   256*L = 768x 
    add  HL, HL         ; 1:11      1017 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1017 *      +1 = 7x 
    add  HL, HL         ; 1:11      1017 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1017 *      +1 = 15x 
    add  HL, HL         ; 1:11      1017 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1017 *      +1 = 31x 
    add  HL, HL         ; 1:11      1017 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1017 *   0  *2 = 124x 
    add  HL, HL         ; 1:11      1017 *   1  *2 = 248x
    add  HL, BC         ; 1:11      1017 *      +1 = 249x 
    add   A, H          ; 1:4       1017 *
    ld    H, A          ; 1:4       1017 *     [1017x] = 249x + 768x  
                        ;[13:73]    1019 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_0100_0000_0000 - b_0101)  
    ld    B, H          ; 1:4       1019 *
    ld    C, L          ; 1:4       1019 *   [1x] 
    add  HL, HL         ; 1:11      1019 *   2x 
    add  HL, HL         ; 1:11      1019 *   4x 
    ld    A, L          ; 1:4       1019 *   L0 - (HL + BC) --> B0 - HL
    add  HL, BC         ; 1:11      1019 *   [5x]
    ld    B, A          ; 1:4       1019 *
    xor   A             ; 1:4       1019 *
    sub   L             ; 1:4       1019 *
    ld    L, A          ; 1:4       1019 *
    ld    A, B          ; 1:4       1019 *
    sbc   A, H          ; 1:4       1019 *
    ld    H, A          ; 1:4       1019 *   [1019x] = 1024x - 5x   

                        ;[15:80]    1021 *   Variant mk1: HL * (2^a - 2^b - 2^c) = HL * (b_0011_1111_1101)   
    ld    B, H          ; 1:4       1021 *
    ld    A, L          ; 1:4       1021 *   [1x] 
    add  HL, HL         ; 1:11      1021 *   2x 
    add   A, L          ; 1:4       1021 *
    ld    C, A          ; 1:4       1021 *
    ld    A, B          ; 1:4       1021 *
    adc   A, H          ; 1:4       1021 *
    ld    B, A          ; 1:4       1021 *   [3x] 
    ld    H, L          ; 1:4       1021 *
    ld    L, 0x00       ; 2:7       1021 *   512x 
    add  HL, HL         ; 1:11      1021 *   1024x 
    or    A             ; 1:4       1021 *
    sbc  HL, BC         ; 2:15      1021 *   [1021x] = 1024x - 3x   
                        ;[10:60]    1023 *   Variant mk1: HL * (2^a - 2^b) = HL * (b_0011_1111_1111)   
    ld    B, H          ; 1:4       1023 *
    ld    C, L          ; 1:4       1023 *   [1x] 
    ld    H, L          ; 1:4       1023 *
    ld    L, 0x00       ; 2:7       1023 *   256x 
    add  HL, HL         ; 1:11      1023 *   512x 
    add  HL, HL         ; 1:11      1023 *   1024x 
    or    A             ; 1:4       1023 *
    sbc  HL, BC         ; 2:15      1023 *   [1023x] = 1024x - 1x   
                        ;[5:20]     1025 *   Variant mk4: 256*...(((L*2^a)+L)*2^b)+... = HL * (b_0100_0000_0001)
    ld    A, L          ; 1:4       1025 *   1       1x 
    add   A, A          ; 1:4       1025 *   0  *2 = 2x 
    add   A, A          ; 1:4       1025 *   0  *2 = 4x 
    add   A, H          ; 1:4       1025 *
    ld    H, A          ; 1:4       1025 *     [1025x] = 256 * 4x + 1x  
                        ;[8:46]     1027 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0000_0011)
    ld    B, H          ; 1:4       1027 *
    ld    C, L          ; 1:4       1027 *   1       1x = base 
    ld    A, L          ; 1:4       1027 *   256*L = 256x 
    add  HL, HL         ; 1:11      1027 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1027 *      +1 = 3x 
    add   A, L          ; 1:4       1027 *  +256*L = 1024x 
    add   A, H          ; 1:4       1027 *
    ld    H, A          ; 1:4       1027 *     [1027x] = 3x + 1024x  
                        ;[8:53]     1029 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0100_0000_0101)  
    ld    B, H          ; 1:4       1029 *
    ld    C, L          ; 1:4       1029 *   [1x] 
    add  HL, HL         ; 1:11      1029 *   2x 
    add  HL, HL         ; 1:11      1029 *   4x 
    ld    A, L          ; 1:4       1029 *
    add   A, B          ; 1:4       1029 *
    ld    B, A          ; 1:4       1029 *   [1025x] 
    add  HL, BC         ; 1:11      1029 *   [1029x] = 4x + 1025x   
                        ;[10:68]    1031 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0000_0111)
    ld    B, H          ; 1:4       1031 *
    ld    C, L          ; 1:4       1031 *   1       1x = base 
    ld    A, L          ; 1:4       1031 *   256*L = 256x 
    add  HL, HL         ; 1:11      1031 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1031 *      +1 = 3x 
    add   A, L          ; 1:4       1031 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1031 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1031 *      +1 = 7x 
    add   A, H          ; 1:4       1031 *
    ld    H, A          ; 1:4       1031 *     [1031x] = 7x + 1024x  
                        ;[9:64]     1033 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0100_0000_1001)  
    ld    B, H          ; 1:4       1033 *
    ld    C, L          ; 1:4       1033 *   [1x] 
    add  HL, HL         ; 1:11      1033 *   2x 
    add  HL, HL         ; 1:11      1033 *   4x 
    ld    A, L          ; 1:4       1033 *   1024x 
    add  HL, HL         ; 1:11      1033 *   8x 
    add   A, B          ; 1:4       1033 *
    ld    B, A          ; 1:4       1033 *   [1025x] 
    add  HL, BC         ; 1:11      1033 *   [1033x] = 8x + 1025x   
                        ;[10:75]    1035 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0000_1011)
    ld    B, H          ; 1:4       1035 *
    ld    C, L          ; 1:4       1035 *   1       1x = base 
    add  HL, HL         ; 1:11      1035 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1035 *   1  *2 = 4x
    ld    A, L          ; 1:4       1035 *   256*L = 1024x
    add  HL, BC         ; 1:11      1035 *      +1 = 5x 
    add  HL, HL         ; 1:11      1035 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1035 *      +1 = 11x 
    add   A, H          ; 1:4       1035 *
    ld    H, A          ; 1:4       1035 *     [1035x] = 11x + 1024x  
                        ;[11:79]    1037 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0000_1101)
    ld    B, H          ; 1:4       1037 *
    ld    C, L          ; 1:4       1037 *   1       1x = base 
    ld    A, L          ; 1:4       1037 *   256*L = 256x 
    add  HL, HL         ; 1:11      1037 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1037 *      +1 = 3x 
    add   A, L          ; 1:4       1037 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1037 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1037 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1037 *      +1 = 13x 
    add   A, H          ; 1:4       1037 *
    ld    H, A          ; 1:4       1037 *     [1037x] = 13x + 1024x 

                        ;[12:90]    1039 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0000_1111)
    ld    B, H          ; 1:4       1039 *
    ld    C, L          ; 1:4       1039 *   1       1x = base 
    ld    A, L          ; 1:4       1039 *   256*L = 256x 
    add  HL, HL         ; 1:11      1039 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1039 *      +1 = 3x 
    add   A, L          ; 1:4       1039 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1039 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1039 *      +1 = 7x 
    add  HL, HL         ; 1:11      1039 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1039 *      +1 = 15x 
    add   A, H          ; 1:4       1039 *
    ld    H, A          ; 1:4       1039 *     [1039x] = 15x + 1024x  
                        ;[10:75]    1041 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0100_0001_0001)  
    ld    B, H          ; 1:4       1041 *
    ld    C, L          ; 1:4       1041 *   [1x] 
    add  HL, HL         ; 1:11      1041 *   2x 
    add  HL, HL         ; 1:11      1041 *   4x 
    ld    A, L          ; 1:4       1041 *   1024x 
    add  HL, HL         ; 1:11      1041 *   8x 
    add  HL, HL         ; 1:11      1041 *   16x 
    add   A, B          ; 1:4       1041 *
    ld    B, A          ; 1:4       1041 *   [1025x] 
    add  HL, BC         ; 1:11      1041 *   [1041x] = 16x + 1025x   
                        ;[11:86]    1043 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0001_0011)
    ld    B, H          ; 1:4       1043 *
    ld    C, L          ; 1:4       1043 *   1       1x = base 
    add  HL, HL         ; 1:11      1043 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1043 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1043 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1043 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1043 *      +1 = 9x 
    add  HL, HL         ; 1:11      1043 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1043 *      +1 = 19x 
    add   A, H          ; 1:4       1043 *
    ld    H, A          ; 1:4       1043 *     [1043x] = 19x + 1024x  
                        ;[11:86]    1045 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0001_0101)
    ld    B, H          ; 1:4       1045 *
    ld    C, L          ; 1:4       1045 *   1       1x = base 
    add  HL, HL         ; 1:11      1045 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1045 *   1  *2 = 4x
    ld    A, L          ; 1:4       1045 *   256*L = 1024x
    add  HL, BC         ; 1:11      1045 *      +1 = 5x 
    add  HL, HL         ; 1:11      1045 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1045 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1045 *      +1 = 21x 
    add   A, H          ; 1:4       1045 *
    ld    H, A          ; 1:4       1045 *     [1045x] = 21x + 1024x  
                        ;[12:97]    1047 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0001_0111)
    ld    B, H          ; 1:4       1047 *
    ld    C, L          ; 1:4       1047 *   1       1x = base 
    add  HL, HL         ; 1:11      1047 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1047 *   1  *2 = 4x
    ld    A, L          ; 1:4       1047 *   256*L = 1024x
    add  HL, BC         ; 1:11      1047 *      +1 = 5x 
    add  HL, HL         ; 1:11      1047 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1047 *      +1 = 11x 
    add  HL, HL         ; 1:11      1047 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1047 *      +1 = 23x 
    add   A, H          ; 1:4       1047 *
    ld    H, A          ; 1:4       1047 *     [1047x] = 23x + 1024x  
                        ;[12:90]    1049 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0001_1001)
    ld    B, H          ; 1:4       1049 *
    ld    C, L          ; 1:4       1049 *   1       1x = base 
    ld    A, L          ; 1:4       1049 *   256*L = 256x 
    add  HL, HL         ; 1:11      1049 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1049 *      +1 = 3x 
    add   A, L          ; 1:4       1049 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1049 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1049 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1049 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1049 *      +1 = 25x 
    add   A, H          ; 1:4       1049 *
    ld    H, A          ; 1:4       1049 *     [1049x] = 25x + 1024x  
                        ;[13:101]   1051 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0001_1011)
    ld    B, H          ; 1:4       1051 *
    ld    C, L          ; 1:4       1051 *   1       1x = base 
    ld    A, L          ; 1:4       1051 *   256*L = 256x 
    add  HL, HL         ; 1:11      1051 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1051 *      +1 = 3x 
    add   A, L          ; 1:4       1051 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1051 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1051 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1051 *      +1 = 13x 
    add  HL, HL         ; 1:11      1051 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1051 *      +1 = 27x 
    add   A, H          ; 1:4       1051 *
    ld    H, A          ; 1:4       1051 *     [1051x] = 27x + 1024x  
                        ;[13:101]   1053 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0001_1101)
    ld    B, H          ; 1:4       1053 *
    ld    C, L          ; 1:4       1053 *   1       1x = base 
    ld    A, L          ; 1:4       1053 *   256*L = 256x 
    add  HL, HL         ; 1:11      1053 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1053 *      +1 = 3x 
    add   A, L          ; 1:4       1053 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1053 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1053 *      +1 = 7x 
    add  HL, HL         ; 1:11      1053 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1053 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1053 *      +1 = 29x 
    add   A, H          ; 1:4       1053 *
    ld    H, A          ; 1:4       1053 *     [1053x] = 29x + 1024x  
                        ;[14:112]   1055 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0001_1111)
    ld    B, H          ; 1:4       1055 *
    ld    C, L          ; 1:4       1055 *   1       1x = base 
    ld    A, L          ; 1:4       1055 *   256*L = 256x 
    add  HL, HL         ; 1:11      1055 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1055 *      +1 = 3x 
    add   A, L          ; 1:4       1055 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1055 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1055 *      +1 = 7x 
    add  HL, HL         ; 1:11      1055 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1055 *      +1 = 15x 
    add  HL, HL         ; 1:11      1055 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1055 *      +1 = 31x 
    add   A, H          ; 1:4       1055 *
    ld    H, A          ; 1:4       1055 *     [1055x] = 31x + 1024x 

                        ;[11:86]    1057 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0100_0010_0001)  
    ld    B, H          ; 1:4       1057 *
    ld    C, L          ; 1:4       1057 *   [1x] 
    add  HL, HL         ; 1:11      1057 *   2x 
    add  HL, HL         ; 1:11      1057 *   4x 
    ld    A, L          ; 1:4       1057 *   1024x 
    add  HL, HL         ; 1:11      1057 *   8x 
    add  HL, HL         ; 1:11      1057 *   16x 
    add  HL, HL         ; 1:11      1057 *   32x 
    add   A, B          ; 1:4       1057 *
    ld    B, A          ; 1:4       1057 *   [1025x] 
    add  HL, BC         ; 1:11      1057 *   [1057x] = 32x + 1025x   
                        ;[12:97]    1059 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0010_0011)
    ld    B, H          ; 1:4       1059 *
    ld    C, L          ; 1:4       1059 *   1       1x = base 
    add  HL, HL         ; 1:11      1059 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1059 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1059 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1059 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1059 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1059 *      +1 = 17x 
    add  HL, HL         ; 1:11      1059 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1059 *      +1 = 35x 
    add   A, H          ; 1:4       1059 *
    ld    H, A          ; 1:4       1059 *     [1059x] = 35x + 1024x  
                        ;[12:97]    1061 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0010_0101)
    ld    B, H          ; 1:4       1061 *
    ld    C, L          ; 1:4       1061 *   1       1x = base 
    add  HL, HL         ; 1:11      1061 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1061 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1061 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1061 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1061 *      +1 = 9x 
    add  HL, HL         ; 1:11      1061 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1061 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1061 *      +1 = 37x 
    add   A, H          ; 1:4       1061 *
    ld    H, A          ; 1:4       1061 *     [1061x] = 37x + 1024x  
                        ;[13:108]   1063 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0010_0111)
    ld    B, H          ; 1:4       1063 *
    ld    C, L          ; 1:4       1063 *   1       1x = base 
    add  HL, HL         ; 1:11      1063 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1063 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1063 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1063 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1063 *      +1 = 9x 
    add  HL, HL         ; 1:11      1063 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1063 *      +1 = 19x 
    add  HL, HL         ; 1:11      1063 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1063 *      +1 = 39x 
    add   A, H          ; 1:4       1063 *
    ld    H, A          ; 1:4       1063 *     [1063x] = 39x + 1024x  
                        ;[12:97]    1065 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0010_1001)
    ld    B, H          ; 1:4       1065 *
    ld    C, L          ; 1:4       1065 *   1       1x = base 
    add  HL, HL         ; 1:11      1065 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1065 *   1  *2 = 4x
    ld    A, L          ; 1:4       1065 *   256*L = 1024x
    add  HL, BC         ; 1:11      1065 *      +1 = 5x 
    add  HL, HL         ; 1:11      1065 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1065 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1065 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1065 *      +1 = 41x 
    add   A, H          ; 1:4       1065 *
    ld    H, A          ; 1:4       1065 *     [1065x] = 41x + 1024x  
                        ;[13:108]   1067 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0010_1011)
    ld    B, H          ; 1:4       1067 *
    ld    C, L          ; 1:4       1067 *   1       1x = base 
    add  HL, HL         ; 1:11      1067 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1067 *   1  *2 = 4x
    ld    A, L          ; 1:4       1067 *   256*L = 1024x
    add  HL, BC         ; 1:11      1067 *      +1 = 5x 
    add  HL, HL         ; 1:11      1067 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1067 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1067 *      +1 = 21x 
    add  HL, HL         ; 1:11      1067 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1067 *      +1 = 43x 
    add   A, H          ; 1:4       1067 *
    ld    H, A          ; 1:4       1067 *     [1067x] = 43x + 1024x  
                        ;[13:108]   1069 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0010_1101)
    ld    B, H          ; 1:4       1069 *
    ld    C, L          ; 1:4       1069 *   1       1x = base 
    add  HL, HL         ; 1:11      1069 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1069 *   1  *2 = 4x
    ld    A, L          ; 1:4       1069 *   256*L = 1024x
    add  HL, BC         ; 1:11      1069 *      +1 = 5x 
    add  HL, HL         ; 1:11      1069 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1069 *      +1 = 11x 
    add  HL, HL         ; 1:11      1069 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1069 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1069 *      +1 = 45x 
    add   A, H          ; 1:4       1069 *
    ld    H, A          ; 1:4       1069 *     [1069x] = 45x + 1024x  
                        ;[14:119]   1071 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0010_1111)
    ld    B, H          ; 1:4       1071 *
    ld    C, L          ; 1:4       1071 *   1       1x = base 
    add  HL, HL         ; 1:11      1071 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1071 *   1  *2 = 4x
    ld    A, L          ; 1:4       1071 *   256*L = 1024x
    add  HL, BC         ; 1:11      1071 *      +1 = 5x 
    add  HL, HL         ; 1:11      1071 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1071 *      +1 = 11x 
    add  HL, HL         ; 1:11      1071 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1071 *      +1 = 23x 
    add  HL, HL         ; 1:11      1071 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1071 *      +1 = 47x 
    add   A, H          ; 1:4       1071 *
    ld    H, A          ; 1:4       1071 *     [1071x] = 47x + 1024x  
                        ;[13:101]   1073 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0011_0001)
    ld    B, H          ; 1:4       1073 *
    ld    C, L          ; 1:4       1073 *   1       1x = base 
    ld    A, L          ; 1:4       1073 *   256*L = 256x 
    add  HL, HL         ; 1:11      1073 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1073 *      +1 = 3x 
    add   A, L          ; 1:4       1073 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1073 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1073 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1073 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1073 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1073 *      +1 = 49x 
    add   A, H          ; 1:4       1073 *
    ld    H, A          ; 1:4       1073 *     [1073x] = 49x + 1024x 

                        ;[14:112]   1075 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0011_0011)
    ld    B, H          ; 1:4       1075 *
    ld    C, L          ; 1:4       1075 *   1       1x = base 
    ld    A, L          ; 1:4       1075 *   256*L = 256x 
    add  HL, HL         ; 1:11      1075 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1075 *      +1 = 3x 
    add   A, L          ; 1:4       1075 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1075 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1075 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1075 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1075 *      +1 = 25x 
    add  HL, HL         ; 1:11      1075 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1075 *      +1 = 51x 
    add   A, H          ; 1:4       1075 *
    ld    H, A          ; 1:4       1075 *     [1075x] = 51x + 1024x  
                        ;[14:112]   1077 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0011_0101)
    ld    B, H          ; 1:4       1077 *
    ld    C, L          ; 1:4       1077 *   1       1x = base 
    ld    A, L          ; 1:4       1077 *   256*L = 256x 
    add  HL, HL         ; 1:11      1077 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1077 *      +1 = 3x 
    add   A, L          ; 1:4       1077 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1077 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1077 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1077 *      +1 = 13x 
    add  HL, HL         ; 1:11      1077 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1077 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1077 *      +1 = 53x 
    add   A, H          ; 1:4       1077 *
    ld    H, A          ; 1:4       1077 *     [1077x] = 53x + 1024x  
                        ;[15:123]   1079 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0011_0111)
    ld    B, H          ; 1:4       1079 *
    ld    C, L          ; 1:4       1079 *   1       1x = base 
    ld    A, L          ; 1:4       1079 *   256*L = 256x 
    add  HL, HL         ; 1:11      1079 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1079 *      +1 = 3x 
    add   A, L          ; 1:4       1079 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1079 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1079 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1079 *      +1 = 13x 
    add  HL, HL         ; 1:11      1079 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1079 *      +1 = 27x 
    add  HL, HL         ; 1:11      1079 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1079 *      +1 = 55x 
    add   A, H          ; 1:4       1079 *
    ld    H, A          ; 1:4       1079 *     [1079x] = 55x + 1024x  
                        ;[14:112]   1081 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0011_1001)
    ld    B, H          ; 1:4       1081 *
    ld    C, L          ; 1:4       1081 *   1       1x = base 
    ld    A, L          ; 1:4       1081 *   256*L = 256x 
    add  HL, HL         ; 1:11      1081 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1081 *      +1 = 3x 
    add   A, L          ; 1:4       1081 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1081 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1081 *      +1 = 7x 
    add  HL, HL         ; 1:11      1081 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1081 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1081 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1081 *      +1 = 57x 
    add   A, H          ; 1:4       1081 *
    ld    H, A          ; 1:4       1081 *     [1081x] = 57x + 1024x  
                        ;[15:123]   1083 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0011_1011)
    ld    B, H          ; 1:4       1083 *
    ld    C, L          ; 1:4       1083 *   1       1x = base 
    ld    A, L          ; 1:4       1083 *   256*L = 256x 
    add  HL, HL         ; 1:11      1083 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1083 *      +1 = 3x 
    add   A, L          ; 1:4       1083 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1083 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1083 *      +1 = 7x 
    add  HL, HL         ; 1:11      1083 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1083 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1083 *      +1 = 29x 
    add  HL, HL         ; 1:11      1083 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1083 *      +1 = 59x 
    add   A, H          ; 1:4       1083 *
    ld    H, A          ; 1:4       1083 *     [1083x] = 59x + 1024x  
                        ;[15:123]   1085 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0011_1101)
    ld    B, H          ; 1:4       1085 *
    ld    C, L          ; 1:4       1085 *   1       1x = base 
    ld    A, L          ; 1:4       1085 *   256*L = 256x 
    add  HL, HL         ; 1:11      1085 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1085 *      +1 = 3x 
    add   A, L          ; 1:4       1085 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1085 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1085 *      +1 = 7x 
    add  HL, HL         ; 1:11      1085 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1085 *      +1 = 15x 
    add  HL, HL         ; 1:11      1085 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1085 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1085 *      +1 = 61x 
    add   A, H          ; 1:4       1085 *
    ld    H, A          ; 1:4       1085 *     [1085x] = 61x + 1024x  
                        ;[16:134]   1087 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0011_1111)
    ld    B, H          ; 1:4       1087 *
    ld    C, L          ; 1:4       1087 *   1       1x = base 
    ld    A, L          ; 1:4       1087 *   256*L = 256x 
    add  HL, HL         ; 1:11      1087 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1087 *      +1 = 3x 
    add   A, L          ; 1:4       1087 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1087 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1087 *      +1 = 7x 
    add  HL, HL         ; 1:11      1087 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1087 *      +1 = 15x 
    add  HL, HL         ; 1:11      1087 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1087 *      +1 = 31x 
    add  HL, HL         ; 1:11      1087 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1087 *      +1 = 63x 
    add   A, H          ; 1:4       1087 *
    ld    H, A          ; 1:4       1087 *     [1087x] = 63x + 1024x  
                        ;[12:97]    1089 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0100_0100_0001)  
    ld    B, H          ; 1:4       1089 *
    ld    C, L          ; 1:4       1089 *   [1x] 
    add  HL, HL         ; 1:11      1089 *   2x 
    add  HL, HL         ; 1:11      1089 *   4x 
    ld    A, L          ; 1:4       1089 *   1024x 
    add  HL, HL         ; 1:11      1089 *   8x 
    add  HL, HL         ; 1:11      1089 *   16x 
    add  HL, HL         ; 1:11      1089 *   32x 
    add  HL, HL         ; 1:11      1089 *   64x 
    add   A, B          ; 1:4       1089 *
    ld    B, A          ; 1:4       1089 *   [1025x] 
    add  HL, BC         ; 1:11      1089 *   [1089x] = 64x + 1025x   
                        ;[13:108]   1091 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0100_0011)
    ld    B, H          ; 1:4       1091 *
    ld    C, L          ; 1:4       1091 *   1       1x = base 
    add  HL, HL         ; 1:11      1091 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1091 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1091 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1091 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1091 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1091 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1091 *      +1 = 33x 
    add  HL, HL         ; 1:11      1091 *   1  *2 = 66x
    add  HL, BC         ; 1:11      1091 *      +1 = 67x 
    add   A, H          ; 1:4       1091 *
    ld    H, A          ; 1:4       1091 *     [1091x] = 67x + 1024x 

                        ;[13:108]   1093 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0100_0101)
    ld    B, H          ; 1:4       1093 *
    ld    C, L          ; 1:4       1093 *   1       1x = base 
    add  HL, HL         ; 1:11      1093 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1093 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1093 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1093 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1093 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1093 *      +1 = 17x 
    add  HL, HL         ; 1:11      1093 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1093 *   1  *2 = 68x
    add  HL, BC         ; 1:11      1093 *      +1 = 69x 
    add   A, H          ; 1:4       1093 *
    ld    H, A          ; 1:4       1093 *     [1093x] = 69x + 1024x  
                        ;[14:119]   1095 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0100_0111)
    ld    B, H          ; 1:4       1095 *
    ld    C, L          ; 1:4       1095 *   1       1x = base 
    add  HL, HL         ; 1:11      1095 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1095 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1095 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1095 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1095 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1095 *      +1 = 17x 
    add  HL, HL         ; 1:11      1095 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1095 *      +1 = 35x 
    add  HL, HL         ; 1:11      1095 *   1  *2 = 70x
    add  HL, BC         ; 1:11      1095 *      +1 = 71x 
    add   A, H          ; 1:4       1095 *
    ld    H, A          ; 1:4       1095 *     [1095x] = 71x + 1024x  
                        ;[13:108]   1097 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0100_1001)
    ld    B, H          ; 1:4       1097 *
    ld    C, L          ; 1:4       1097 *   1       1x = base 
    add  HL, HL         ; 1:11      1097 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1097 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1097 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1097 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1097 *      +1 = 9x 
    add  HL, HL         ; 1:11      1097 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1097 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1097 *   1  *2 = 72x
    add  HL, BC         ; 1:11      1097 *      +1 = 73x 
    add   A, H          ; 1:4       1097 *
    ld    H, A          ; 1:4       1097 *     [1097x] = 73x + 1024x  
                        ;[14:119]   1099 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0100_1011)
    ld    B, H          ; 1:4       1099 *
    ld    C, L          ; 1:4       1099 *   1       1x = base 
    add  HL, HL         ; 1:11      1099 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1099 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1099 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1099 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1099 *      +1 = 9x 
    add  HL, HL         ; 1:11      1099 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1099 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1099 *      +1 = 37x 
    add  HL, HL         ; 1:11      1099 *   1  *2 = 74x
    add  HL, BC         ; 1:11      1099 *      +1 = 75x 
    add   A, H          ; 1:4       1099 *
    ld    H, A          ; 1:4       1099 *     [1099x] = 75x + 1024x  
                        ;[14:119]   1101 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0100_1101)
    ld    B, H          ; 1:4       1101 *
    ld    C, L          ; 1:4       1101 *   1       1x = base 
    add  HL, HL         ; 1:11      1101 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1101 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1101 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1101 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1101 *      +1 = 9x 
    add  HL, HL         ; 1:11      1101 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1101 *      +1 = 19x 
    add  HL, HL         ; 1:11      1101 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1101 *   1  *2 = 76x
    add  HL, BC         ; 1:11      1101 *      +1 = 77x 
    add   A, H          ; 1:4       1101 *
    ld    H, A          ; 1:4       1101 *     [1101x] = 77x + 1024x  
                        ;[15:130]   1103 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0100_1111)
    ld    B, H          ; 1:4       1103 *
    ld    C, L          ; 1:4       1103 *   1       1x = base 
    add  HL, HL         ; 1:11      1103 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1103 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1103 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1103 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1103 *      +1 = 9x 
    add  HL, HL         ; 1:11      1103 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1103 *      +1 = 19x 
    add  HL, HL         ; 1:11      1103 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1103 *      +1 = 39x 
    add  HL, HL         ; 1:11      1103 *   1  *2 = 78x
    add  HL, BC         ; 1:11      1103 *      +1 = 79x 
    add   A, H          ; 1:4       1103 *
    ld    H, A          ; 1:4       1103 *     [1103x] = 79x + 1024x  
                        ;[13:108]   1105 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0101_0001)
    ld    B, H          ; 1:4       1105 *
    ld    C, L          ; 1:4       1105 *   1       1x = base 
    add  HL, HL         ; 1:11      1105 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1105 *   1  *2 = 4x
    ld    A, L          ; 1:4       1105 *   256*L = 1024x
    add  HL, BC         ; 1:11      1105 *      +1 = 5x 
    add  HL, HL         ; 1:11      1105 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1105 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1105 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1105 *   1  *2 = 80x
    add  HL, BC         ; 1:11      1105 *      +1 = 81x 
    add   A, H          ; 1:4       1105 *
    ld    H, A          ; 1:4       1105 *     [1105x] = 81x + 1024x  
                        ;[14:119]   1107 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0101_0011)
    ld    B, H          ; 1:4       1107 *
    ld    C, L          ; 1:4       1107 *   1       1x = base 
    add  HL, HL         ; 1:11      1107 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1107 *   1  *2 = 4x
    ld    A, L          ; 1:4       1107 *   256*L = 1024x
    add  HL, BC         ; 1:11      1107 *      +1 = 5x 
    add  HL, HL         ; 1:11      1107 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1107 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1107 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1107 *      +1 = 41x 
    add  HL, HL         ; 1:11      1107 *   1  *2 = 82x
    add  HL, BC         ; 1:11      1107 *      +1 = 83x 
    add   A, H          ; 1:4       1107 *
    ld    H, A          ; 1:4       1107 *     [1107x] = 83x + 1024x  
                        ;[14:119]   1109 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0101_0101)
    ld    B, H          ; 1:4       1109 *
    ld    C, L          ; 1:4       1109 *   1       1x = base 
    add  HL, HL         ; 1:11      1109 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1109 *   1  *2 = 4x
    ld    A, L          ; 1:4       1109 *   256*L = 1024x
    add  HL, BC         ; 1:11      1109 *      +1 = 5x 
    add  HL, HL         ; 1:11      1109 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1109 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1109 *      +1 = 21x 
    add  HL, HL         ; 1:11      1109 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1109 *   1  *2 = 84x
    add  HL, BC         ; 1:11      1109 *      +1 = 85x 
    add   A, H          ; 1:4       1109 *
    ld    H, A          ; 1:4       1109 *     [1109x] = 85x + 1024x 

                        ;[15:130]   1111 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0101_0111)
    ld    B, H          ; 1:4       1111 *
    ld    C, L          ; 1:4       1111 *   1       1x = base 
    add  HL, HL         ; 1:11      1111 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1111 *   1  *2 = 4x
    ld    A, L          ; 1:4       1111 *   256*L = 1024x
    add  HL, BC         ; 1:11      1111 *      +1 = 5x 
    add  HL, HL         ; 1:11      1111 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1111 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1111 *      +1 = 21x 
    add  HL, HL         ; 1:11      1111 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1111 *      +1 = 43x 
    add  HL, HL         ; 1:11      1111 *   1  *2 = 86x
    add  HL, BC         ; 1:11      1111 *      +1 = 87x 
    add   A, H          ; 1:4       1111 *
    ld    H, A          ; 1:4       1111 *     [1111x] = 87x + 1024x  
                        ;[14:119]   1113 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0101_1001)
    ld    B, H          ; 1:4       1113 *
    ld    C, L          ; 1:4       1113 *   1       1x = base 
    add  HL, HL         ; 1:11      1113 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1113 *   1  *2 = 4x
    ld    A, L          ; 1:4       1113 *   256*L = 1024x
    add  HL, BC         ; 1:11      1113 *      +1 = 5x 
    add  HL, HL         ; 1:11      1113 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1113 *      +1 = 11x 
    add  HL, HL         ; 1:11      1113 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1113 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1113 *   1  *2 = 88x
    add  HL, BC         ; 1:11      1113 *      +1 = 89x 
    add   A, H          ; 1:4       1113 *
    ld    H, A          ; 1:4       1113 *     [1113x] = 89x + 1024x  
                        ;[15:130]   1115 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0101_1011)
    ld    B, H          ; 1:4       1115 *
    ld    C, L          ; 1:4       1115 *   1       1x = base 
    add  HL, HL         ; 1:11      1115 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1115 *   1  *2 = 4x
    ld    A, L          ; 1:4       1115 *   256*L = 1024x
    add  HL, BC         ; 1:11      1115 *      +1 = 5x 
    add  HL, HL         ; 1:11      1115 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1115 *      +1 = 11x 
    add  HL, HL         ; 1:11      1115 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1115 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1115 *      +1 = 45x 
    add  HL, HL         ; 1:11      1115 *   1  *2 = 90x
    add  HL, BC         ; 1:11      1115 *      +1 = 91x 
    add   A, H          ; 1:4       1115 *
    ld    H, A          ; 1:4       1115 *     [1115x] = 91x + 1024x  
                        ;[15:130]   1117 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0101_1101)
    ld    B, H          ; 1:4       1117 *
    ld    C, L          ; 1:4       1117 *   1       1x = base 
    add  HL, HL         ; 1:11      1117 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1117 *   1  *2 = 4x
    ld    A, L          ; 1:4       1117 *   256*L = 1024x
    add  HL, BC         ; 1:11      1117 *      +1 = 5x 
    add  HL, HL         ; 1:11      1117 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1117 *      +1 = 11x 
    add  HL, HL         ; 1:11      1117 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1117 *      +1 = 23x 
    add  HL, HL         ; 1:11      1117 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1117 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1117 *      +1 = 93x 
    add   A, H          ; 1:4       1117 *
    ld    H, A          ; 1:4       1117 *     [1117x] = 93x + 1024x  
                        ;[16:141]   1119 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0101_1111)
    ld    B, H          ; 1:4       1119 *
    ld    C, L          ; 1:4       1119 *   1       1x = base 
    add  HL, HL         ; 1:11      1119 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1119 *   1  *2 = 4x
    ld    A, L          ; 1:4       1119 *   256*L = 1024x
    add  HL, BC         ; 1:11      1119 *      +1 = 5x 
    add  HL, HL         ; 1:11      1119 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1119 *      +1 = 11x 
    add  HL, HL         ; 1:11      1119 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1119 *      +1 = 23x 
    add  HL, HL         ; 1:11      1119 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1119 *      +1 = 47x 
    add  HL, HL         ; 1:11      1119 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1119 *      +1 = 95x 
    add   A, H          ; 1:4       1119 *
    ld    H, A          ; 1:4       1119 *     [1119x] = 95x + 1024x  
                        ;[14:112]   1121 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0110_0001)
    ld    B, H          ; 1:4       1121 *
    ld    C, L          ; 1:4       1121 *   1       1x = base 
    ld    A, L          ; 1:4       1121 *   256*L = 256x 
    add  HL, HL         ; 1:11      1121 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1121 *      +1 = 3x 
    add   A, L          ; 1:4       1121 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1121 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1121 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1121 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1121 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1121 *   1  *2 = 96x
    add  HL, BC         ; 1:11      1121 *      +1 = 97x 
    add   A, H          ; 1:4       1121 *
    ld    H, A          ; 1:4       1121 *     [1121x] = 97x + 1024x  
                        ;[15:123]   1123 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0110_0011)
    ld    B, H          ; 1:4       1123 *
    ld    C, L          ; 1:4       1123 *   1       1x = base 
    ld    A, L          ; 1:4       1123 *   256*L = 256x 
    add  HL, HL         ; 1:11      1123 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1123 *      +1 = 3x 
    add   A, L          ; 1:4       1123 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1123 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1123 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1123 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1123 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1123 *      +1 = 49x 
    add  HL, HL         ; 1:11      1123 *   1  *2 = 98x
    add  HL, BC         ; 1:11      1123 *      +1 = 99x 
    add   A, H          ; 1:4       1123 *
    ld    H, A          ; 1:4       1123 *     [1123x] = 99x + 1024x  
                        ;[15:123]   1125 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0110_0101)
    ld    B, H          ; 1:4       1125 *
    ld    C, L          ; 1:4       1125 *   1       1x = base 
    ld    A, L          ; 1:4       1125 *   256*L = 256x 
    add  HL, HL         ; 1:11      1125 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1125 *      +1 = 3x 
    add   A, L          ; 1:4       1125 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1125 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1125 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1125 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1125 *      +1 = 25x 
    add  HL, HL         ; 1:11      1125 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1125 *   1  *2 = 100x
    add  HL, BC         ; 1:11      1125 *      +1 = 101x 
    add   A, H          ; 1:4       1125 *
    ld    H, A          ; 1:4       1125 *     [1125x] = 101x + 1024x  
                        ;[16:134]   1127 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0110_0111)
    ld    B, H          ; 1:4       1127 *
    ld    C, L          ; 1:4       1127 *   1       1x = base 
    ld    A, L          ; 1:4       1127 *   256*L = 256x 
    add  HL, HL         ; 1:11      1127 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1127 *      +1 = 3x 
    add   A, L          ; 1:4       1127 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1127 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1127 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1127 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1127 *      +1 = 25x 
    add  HL, HL         ; 1:11      1127 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1127 *      +1 = 51x 
    add  HL, HL         ; 1:11      1127 *   1  *2 = 102x
    add  HL, BC         ; 1:11      1127 *      +1 = 103x 
    add   A, H          ; 1:4       1127 *
    ld    H, A          ; 1:4       1127 *     [1127x] = 103x + 1024x 

                        ;[15:123]   1129 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0110_1001)
    ld    B, H          ; 1:4       1129 *
    ld    C, L          ; 1:4       1129 *   1       1x = base 
    ld    A, L          ; 1:4       1129 *   256*L = 256x 
    add  HL, HL         ; 1:11      1129 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1129 *      +1 = 3x 
    add   A, L          ; 1:4       1129 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1129 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1129 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1129 *      +1 = 13x 
    add  HL, HL         ; 1:11      1129 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1129 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      1129 *   1  *2 = 104x
    add  HL, BC         ; 1:11      1129 *      +1 = 105x 
    add   A, H          ; 1:4       1129 *
    ld    H, A          ; 1:4       1129 *     [1129x] = 105x + 1024x  
                        ;[16:134]   1131 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0110_1011)
    ld    B, H          ; 1:4       1131 *
    ld    C, L          ; 1:4       1131 *   1       1x = base 
    ld    A, L          ; 1:4       1131 *   256*L = 256x 
    add  HL, HL         ; 1:11      1131 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1131 *      +1 = 3x 
    add   A, L          ; 1:4       1131 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1131 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1131 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1131 *      +1 = 13x 
    add  HL, HL         ; 1:11      1131 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1131 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1131 *      +1 = 53x 
    add  HL, HL         ; 1:11      1131 *   1  *2 = 106x
    add  HL, BC         ; 1:11      1131 *      +1 = 107x 
    add   A, H          ; 1:4       1131 *
    ld    H, A          ; 1:4       1131 *     [1131x] = 107x + 1024x  
                        ;[16:134]   1133 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0110_1101)
    ld    B, H          ; 1:4       1133 *
    ld    C, L          ; 1:4       1133 *   1       1x = base 
    ld    A, L          ; 1:4       1133 *   256*L = 256x 
    add  HL, HL         ; 1:11      1133 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1133 *      +1 = 3x 
    add   A, L          ; 1:4       1133 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1133 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1133 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1133 *      +1 = 13x 
    add  HL, HL         ; 1:11      1133 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1133 *      +1 = 27x 
    add  HL, HL         ; 1:11      1133 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      1133 *   1  *2 = 108x
    add  HL, BC         ; 1:11      1133 *      +1 = 109x 
    add   A, H          ; 1:4       1133 *
    ld    H, A          ; 1:4       1133 *     [1133x] = 109x + 1024x  
                        ;[17:145]   1135 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0110_1111)
    ld    B, H          ; 1:4       1135 *
    ld    C, L          ; 1:4       1135 *   1       1x = base 
    ld    A, L          ; 1:4       1135 *   256*L = 256x 
    add  HL, HL         ; 1:11      1135 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1135 *      +1 = 3x 
    add   A, L          ; 1:4       1135 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1135 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1135 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1135 *      +1 = 13x 
    add  HL, HL         ; 1:11      1135 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1135 *      +1 = 27x 
    add  HL, HL         ; 1:11      1135 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1135 *      +1 = 55x 
    add  HL, HL         ; 1:11      1135 *   1  *2 = 110x
    add  HL, BC         ; 1:11      1135 *      +1 = 111x 
    add   A, H          ; 1:4       1135 *
    ld    H, A          ; 1:4       1135 *     [1135x] = 111x + 1024x  
                        ;[15:123]   1137 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0111_0001)
    ld    B, H          ; 1:4       1137 *
    ld    C, L          ; 1:4       1137 *   1       1x = base 
    ld    A, L          ; 1:4       1137 *   256*L = 256x 
    add  HL, HL         ; 1:11      1137 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1137 *      +1 = 3x 
    add   A, L          ; 1:4       1137 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1137 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1137 *      +1 = 7x 
    add  HL, HL         ; 1:11      1137 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1137 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1137 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      1137 *   1  *2 = 112x
    add  HL, BC         ; 1:11      1137 *      +1 = 113x 
    add   A, H          ; 1:4       1137 *
    ld    H, A          ; 1:4       1137 *     [1137x] = 113x + 1024x  
                        ;[16:134]   1139 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0111_0011)
    ld    B, H          ; 1:4       1139 *
    ld    C, L          ; 1:4       1139 *   1       1x = base 
    ld    A, L          ; 1:4       1139 *   256*L = 256x 
    add  HL, HL         ; 1:11      1139 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1139 *      +1 = 3x 
    add   A, L          ; 1:4       1139 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1139 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1139 *      +1 = 7x 
    add  HL, HL         ; 1:11      1139 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1139 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1139 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1139 *      +1 = 57x 
    add  HL, HL         ; 1:11      1139 *   1  *2 = 114x
    add  HL, BC         ; 1:11      1139 *      +1 = 115x 
    add   A, H          ; 1:4       1139 *
    ld    H, A          ; 1:4       1139 *     [1139x] = 115x + 1024x  
                        ;[16:134]   1141 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0111_0101)
    ld    B, H          ; 1:4       1141 *
    ld    C, L          ; 1:4       1141 *   1       1x = base 
    ld    A, L          ; 1:4       1141 *   256*L = 256x 
    add  HL, HL         ; 1:11      1141 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1141 *      +1 = 3x 
    add   A, L          ; 1:4       1141 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1141 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1141 *      +1 = 7x 
    add  HL, HL         ; 1:11      1141 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1141 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1141 *      +1 = 29x 
    add  HL, HL         ; 1:11      1141 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1141 *   1  *2 = 116x
    add  HL, BC         ; 1:11      1141 *      +1 = 117x 
    add   A, H          ; 1:4       1141 *
    ld    H, A          ; 1:4       1141 *     [1141x] = 117x + 1024x  
                        ;[17:145]   1143 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0111_0111)
    ld    B, H          ; 1:4       1143 *
    ld    C, L          ; 1:4       1143 *   1       1x = base 
    ld    A, L          ; 1:4       1143 *   256*L = 256x 
    add  HL, HL         ; 1:11      1143 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1143 *      +1 = 3x 
    add   A, L          ; 1:4       1143 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1143 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1143 *      +1 = 7x 
    add  HL, HL         ; 1:11      1143 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1143 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1143 *      +1 = 29x 
    add  HL, HL         ; 1:11      1143 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1143 *      +1 = 59x 
    add  HL, HL         ; 1:11      1143 *   1  *2 = 118x
    add  HL, BC         ; 1:11      1143 *      +1 = 119x 
    add   A, H          ; 1:4       1143 *
    ld    H, A          ; 1:4       1143 *     [1143x] = 119x + 1024x  
                        ;[16:134]   1145 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0111_1001)
    ld    B, H          ; 1:4       1145 *
    ld    C, L          ; 1:4       1145 *   1       1x = base 
    ld    A, L          ; 1:4       1145 *   256*L = 256x 
    add  HL, HL         ; 1:11      1145 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1145 *      +1 = 3x 
    add   A, L          ; 1:4       1145 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1145 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1145 *      +1 = 7x 
    add  HL, HL         ; 1:11      1145 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1145 *      +1 = 15x 
    add  HL, HL         ; 1:11      1145 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1145 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1145 *   1  *2 = 120x
    add  HL, BC         ; 1:11      1145 *      +1 = 121x 
    add   A, H          ; 1:4       1145 *
    ld    H, A          ; 1:4       1145 *     [1145x] = 121x + 1024x 

                        ;[17:145]   1147 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0111_1011)
    ld    B, H          ; 1:4       1147 *
    ld    C, L          ; 1:4       1147 *   1       1x = base 
    ld    A, L          ; 1:4       1147 *   256*L = 256x 
    add  HL, HL         ; 1:11      1147 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1147 *      +1 = 3x 
    add   A, L          ; 1:4       1147 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1147 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1147 *      +1 = 7x 
    add  HL, HL         ; 1:11      1147 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1147 *      +1 = 15x 
    add  HL, HL         ; 1:11      1147 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1147 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1147 *      +1 = 61x 
    add  HL, HL         ; 1:11      1147 *   1  *2 = 122x
    add  HL, BC         ; 1:11      1147 *      +1 = 123x 
    add   A, H          ; 1:4       1147 *
    ld    H, A          ; 1:4       1147 *     [1147x] = 123x + 1024x  
                        ;[17:145]   1149 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0111_1101)
    ld    B, H          ; 1:4       1149 *
    ld    C, L          ; 1:4       1149 *   1       1x = base 
    ld    A, L          ; 1:4       1149 *   256*L = 256x 
    add  HL, HL         ; 1:11      1149 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1149 *      +1 = 3x 
    add   A, L          ; 1:4       1149 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1149 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1149 *      +1 = 7x 
    add  HL, HL         ; 1:11      1149 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1149 *      +1 = 15x 
    add  HL, HL         ; 1:11      1149 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1149 *      +1 = 31x 
    add  HL, HL         ; 1:11      1149 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1149 *   1  *2 = 124x
    add  HL, BC         ; 1:11      1149 *      +1 = 125x 
    add   A, H          ; 1:4       1149 *
    ld    H, A          ; 1:4       1149 *     [1149x] = 125x + 1024x  
                        ;[18:156]   1151 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_0111_1111)
    ld    B, H          ; 1:4       1151 *
    ld    C, L          ; 1:4       1151 *   1       1x = base 
    ld    A, L          ; 1:4       1151 *   256*L = 256x 
    add  HL, HL         ; 1:11      1151 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1151 *      +1 = 3x 
    add   A, L          ; 1:4       1151 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1151 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1151 *      +1 = 7x 
    add  HL, HL         ; 1:11      1151 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1151 *      +1 = 15x 
    add  HL, HL         ; 1:11      1151 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1151 *      +1 = 31x 
    add  HL, HL         ; 1:11      1151 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1151 *      +1 = 63x 
    add  HL, HL         ; 1:11      1151 *   1  *2 = 126x
    add  HL, BC         ; 1:11      1151 *      +1 = 127x 
    add   A, H          ; 1:4       1151 *
    ld    H, A          ; 1:4       1151 *     [1151x] = 127x + 1024x  
                        ;[13:108]   1153 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0100_1000_0001)  
    ld    B, H          ; 1:4       1153 *
    ld    C, L          ; 1:4       1153 *   [1x] 
    add  HL, HL         ; 1:11      1153 *   2x 
    add  HL, HL         ; 1:11      1153 *   4x 
    ld    A, L          ; 1:4       1153 *   1024x 
    add  HL, HL         ; 1:11      1153 *   8x 
    add  HL, HL         ; 1:11      1153 *   16x 
    add  HL, HL         ; 1:11      1153 *   32x 
    add  HL, HL         ; 1:11      1153 *   64x 
    add  HL, HL         ; 1:11      1153 *   128x 
    add   A, B          ; 1:4       1153 *
    ld    B, A          ; 1:4       1153 *   [1025x] 
    add  HL, BC         ; 1:11      1153 *   [1153x] = 128x + 1025x   
                        ;[14:119]   1155 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1000_0011)
    ld    B, H          ; 1:4       1155 *
    ld    C, L          ; 1:4       1155 *   1       1x = base 
    add  HL, HL         ; 1:11      1155 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1155 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1155 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1155 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1155 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1155 *   0  *2 = 32x 
    add  HL, HL         ; 1:11      1155 *   1  *2 = 64x
    add  HL, BC         ; 1:11      1155 *      +1 = 65x 
    add  HL, HL         ; 1:11      1155 *   1  *2 = 130x
    add  HL, BC         ; 1:11      1155 *      +1 = 131x 
    add   A, H          ; 1:4       1155 *
    ld    H, A          ; 1:4       1155 *     [1155x] = 131x + 1024x  
                        ;[14:119]   1157 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1000_0101)
    ld    B, H          ; 1:4       1157 *
    ld    C, L          ; 1:4       1157 *   1       1x = base 
    add  HL, HL         ; 1:11      1157 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1157 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1157 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1157 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1157 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1157 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1157 *      +1 = 33x 
    add  HL, HL         ; 1:11      1157 *   0  *2 = 66x 
    add  HL, HL         ; 1:11      1157 *   1  *2 = 132x
    add  HL, BC         ; 1:11      1157 *      +1 = 133x 
    add   A, H          ; 1:4       1157 *
    ld    H, A          ; 1:4       1157 *     [1157x] = 133x + 1024x  
                        ;[15:130]   1159 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1000_0111)
    ld    B, H          ; 1:4       1159 *
    ld    C, L          ; 1:4       1159 *   1       1x = base 
    add  HL, HL         ; 1:11      1159 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1159 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1159 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1159 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1159 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1159 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1159 *      +1 = 33x 
    add  HL, HL         ; 1:11      1159 *   1  *2 = 66x
    add  HL, BC         ; 1:11      1159 *      +1 = 67x 
    add  HL, HL         ; 1:11      1159 *   1  *2 = 134x
    add  HL, BC         ; 1:11      1159 *      +1 = 135x 
    add   A, H          ; 1:4       1159 *
    ld    H, A          ; 1:4       1159 *     [1159x] = 135x + 1024x  
                        ;[14:119]   1161 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1000_1001)
    ld    B, H          ; 1:4       1161 *
    ld    C, L          ; 1:4       1161 *   1       1x = base 
    add  HL, HL         ; 1:11      1161 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1161 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1161 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1161 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1161 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1161 *      +1 = 17x 
    add  HL, HL         ; 1:11      1161 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1161 *   0  *2 = 68x 
    add  HL, HL         ; 1:11      1161 *   1  *2 = 136x
    add  HL, BC         ; 1:11      1161 *      +1 = 137x 
    add   A, H          ; 1:4       1161 *
    ld    H, A          ; 1:4       1161 *     [1161x] = 137x + 1024x  
                        ;[15:130]   1163 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1000_1011)
    ld    B, H          ; 1:4       1163 *
    ld    C, L          ; 1:4       1163 *   1       1x = base 
    add  HL, HL         ; 1:11      1163 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1163 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1163 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1163 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1163 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1163 *      +1 = 17x 
    add  HL, HL         ; 1:11      1163 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1163 *   1  *2 = 68x
    add  HL, BC         ; 1:11      1163 *      +1 = 69x 
    add  HL, HL         ; 1:11      1163 *   1  *2 = 138x
    add  HL, BC         ; 1:11      1163 *      +1 = 139x 
    add   A, H          ; 1:4       1163 *
    ld    H, A          ; 1:4       1163 *     [1163x] = 139x + 1024x 

                        ;[15:130]   1165 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1000_1101)
    ld    B, H          ; 1:4       1165 *
    ld    C, L          ; 1:4       1165 *   1       1x = base 
    add  HL, HL         ; 1:11      1165 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1165 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1165 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1165 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1165 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1165 *      +1 = 17x 
    add  HL, HL         ; 1:11      1165 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1165 *      +1 = 35x 
    add  HL, HL         ; 1:11      1165 *   0  *2 = 70x 
    add  HL, HL         ; 1:11      1165 *   1  *2 = 140x
    add  HL, BC         ; 1:11      1165 *      +1 = 141x 
    add   A, H          ; 1:4       1165 *
    ld    H, A          ; 1:4       1165 *     [1165x] = 141x + 1024x  
                        ;[16:141]   1167 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1000_1111)
    ld    B, H          ; 1:4       1167 *
    ld    C, L          ; 1:4       1167 *   1       1x = base 
    add  HL, HL         ; 1:11      1167 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1167 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1167 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1167 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1167 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1167 *      +1 = 17x 
    add  HL, HL         ; 1:11      1167 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1167 *      +1 = 35x 
    add  HL, HL         ; 1:11      1167 *   1  *2 = 70x
    add  HL, BC         ; 1:11      1167 *      +1 = 71x 
    add  HL, HL         ; 1:11      1167 *   1  *2 = 142x
    add  HL, BC         ; 1:11      1167 *      +1 = 143x 
    add   A, H          ; 1:4       1167 *
    ld    H, A          ; 1:4       1167 *     [1167x] = 143x + 1024x  
                        ;[14:119]   1169 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1001_0001)
    ld    B, H          ; 1:4       1169 *
    ld    C, L          ; 1:4       1169 *   1       1x = base 
    add  HL, HL         ; 1:11      1169 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1169 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1169 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1169 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1169 *      +1 = 9x 
    add  HL, HL         ; 1:11      1169 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1169 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1169 *   0  *2 = 72x 
    add  HL, HL         ; 1:11      1169 *   1  *2 = 144x
    add  HL, BC         ; 1:11      1169 *      +1 = 145x 
    add   A, H          ; 1:4       1169 *
    ld    H, A          ; 1:4       1169 *     [1169x] = 145x + 1024x  
                        ;[15:130]   1171 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1001_0011)
    ld    B, H          ; 1:4       1171 *
    ld    C, L          ; 1:4       1171 *   1       1x = base 
    add  HL, HL         ; 1:11      1171 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1171 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1171 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1171 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1171 *      +1 = 9x 
    add  HL, HL         ; 1:11      1171 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1171 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1171 *   1  *2 = 72x
    add  HL, BC         ; 1:11      1171 *      +1 = 73x 
    add  HL, HL         ; 1:11      1171 *   1  *2 = 146x
    add  HL, BC         ; 1:11      1171 *      +1 = 147x 
    add   A, H          ; 1:4       1171 *
    ld    H, A          ; 1:4       1171 *     [1171x] = 147x + 1024x  
                        ;[15:130]   1173 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1001_0101)
    ld    B, H          ; 1:4       1173 *
    ld    C, L          ; 1:4       1173 *   1       1x = base 
    add  HL, HL         ; 1:11      1173 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1173 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1173 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1173 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1173 *      +1 = 9x 
    add  HL, HL         ; 1:11      1173 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1173 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1173 *      +1 = 37x 
    add  HL, HL         ; 1:11      1173 *   0  *2 = 74x 
    add  HL, HL         ; 1:11      1173 *   1  *2 = 148x
    add  HL, BC         ; 1:11      1173 *      +1 = 149x 
    add   A, H          ; 1:4       1173 *
    ld    H, A          ; 1:4       1173 *     [1173x] = 149x + 1024x  
                        ;[16:141]   1175 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1001_0111)
    ld    B, H          ; 1:4       1175 *
    ld    C, L          ; 1:4       1175 *   1       1x = base 
    add  HL, HL         ; 1:11      1175 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1175 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1175 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1175 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1175 *      +1 = 9x 
    add  HL, HL         ; 1:11      1175 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1175 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1175 *      +1 = 37x 
    add  HL, HL         ; 1:11      1175 *   1  *2 = 74x
    add  HL, BC         ; 1:11      1175 *      +1 = 75x 
    add  HL, HL         ; 1:11      1175 *   1  *2 = 150x
    add  HL, BC         ; 1:11      1175 *      +1 = 151x 
    add   A, H          ; 1:4       1175 *
    ld    H, A          ; 1:4       1175 *     [1175x] = 151x + 1024x  
                        ;[15:130]   1177 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1001_1001)
    ld    B, H          ; 1:4       1177 *
    ld    C, L          ; 1:4       1177 *   1       1x = base 
    add  HL, HL         ; 1:11      1177 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1177 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1177 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1177 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1177 *      +1 = 9x 
    add  HL, HL         ; 1:11      1177 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1177 *      +1 = 19x 
    add  HL, HL         ; 1:11      1177 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1177 *   0  *2 = 76x 
    add  HL, HL         ; 1:11      1177 *   1  *2 = 152x
    add  HL, BC         ; 1:11      1177 *      +1 = 153x 
    add   A, H          ; 1:4       1177 *
    ld    H, A          ; 1:4       1177 *     [1177x] = 153x + 1024x  
                        ;[16:141]   1179 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1001_1011)
    ld    B, H          ; 1:4       1179 *
    ld    C, L          ; 1:4       1179 *   1       1x = base 
    add  HL, HL         ; 1:11      1179 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1179 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1179 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1179 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1179 *      +1 = 9x 
    add  HL, HL         ; 1:11      1179 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1179 *      +1 = 19x 
    add  HL, HL         ; 1:11      1179 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1179 *   1  *2 = 76x
    add  HL, BC         ; 1:11      1179 *      +1 = 77x 
    add  HL, HL         ; 1:11      1179 *   1  *2 = 154x
    add  HL, BC         ; 1:11      1179 *      +1 = 155x 
    add   A, H          ; 1:4       1179 *
    ld    H, A          ; 1:4       1179 *     [1179x] = 155x + 1024x  
                        ;[16:141]   1181 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1001_1101)
    ld    B, H          ; 1:4       1181 *
    ld    C, L          ; 1:4       1181 *   1       1x = base 
    add  HL, HL         ; 1:11      1181 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1181 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1181 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1181 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1181 *      +1 = 9x 
    add  HL, HL         ; 1:11      1181 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1181 *      +1 = 19x 
    add  HL, HL         ; 1:11      1181 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1181 *      +1 = 39x 
    add  HL, HL         ; 1:11      1181 *   0  *2 = 78x 
    add  HL, HL         ; 1:11      1181 *   1  *2 = 156x
    add  HL, BC         ; 1:11      1181 *      +1 = 157x 
    add   A, H          ; 1:4       1181 *
    ld    H, A          ; 1:4       1181 *     [1181x] = 157x + 1024x 

                        ;[17:152]   1183 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1001_1111)
    ld    B, H          ; 1:4       1183 *
    ld    C, L          ; 1:4       1183 *   1       1x = base 
    add  HL, HL         ; 1:11      1183 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1183 *   0  *2 = 4x 
    ld    A, L          ; 1:4       1183 *   256*L = 1024x 
    add  HL, HL         ; 1:11      1183 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1183 *      +1 = 9x 
    add  HL, HL         ; 1:11      1183 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1183 *      +1 = 19x 
    add  HL, HL         ; 1:11      1183 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1183 *      +1 = 39x 
    add  HL, HL         ; 1:11      1183 *   1  *2 = 78x
    add  HL, BC         ; 1:11      1183 *      +1 = 79x 
    add  HL, HL         ; 1:11      1183 *   1  *2 = 158x
    add  HL, BC         ; 1:11      1183 *      +1 = 159x 
    add   A, H          ; 1:4       1183 *
    ld    H, A          ; 1:4       1183 *     [1183x] = 159x + 1024x  
                        ;[14:119]   1185 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1010_0001)
    ld    B, H          ; 1:4       1185 *
    ld    C, L          ; 1:4       1185 *   1       1x = base 
    add  HL, HL         ; 1:11      1185 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1185 *   1  *2 = 4x
    ld    A, L          ; 1:4       1185 *   256*L = 1024x
    add  HL, BC         ; 1:11      1185 *      +1 = 5x 
    add  HL, HL         ; 1:11      1185 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1185 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1185 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1185 *   0  *2 = 80x 
    add  HL, HL         ; 1:11      1185 *   1  *2 = 160x
    add  HL, BC         ; 1:11      1185 *      +1 = 161x 
    add   A, H          ; 1:4       1185 *
    ld    H, A          ; 1:4       1185 *     [1185x] = 161x + 1024x  
                        ;[15:130]   1187 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1010_0011)
    ld    B, H          ; 1:4       1187 *
    ld    C, L          ; 1:4       1187 *   1       1x = base 
    add  HL, HL         ; 1:11      1187 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1187 *   1  *2 = 4x
    ld    A, L          ; 1:4       1187 *   256*L = 1024x
    add  HL, BC         ; 1:11      1187 *      +1 = 5x 
    add  HL, HL         ; 1:11      1187 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1187 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1187 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1187 *   1  *2 = 80x
    add  HL, BC         ; 1:11      1187 *      +1 = 81x 
    add  HL, HL         ; 1:11      1187 *   1  *2 = 162x
    add  HL, BC         ; 1:11      1187 *      +1 = 163x 
    add   A, H          ; 1:4       1187 *
    ld    H, A          ; 1:4       1187 *     [1187x] = 163x + 1024x  
                        ;[15:130]   1189 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1010_0101)
    ld    B, H          ; 1:4       1189 *
    ld    C, L          ; 1:4       1189 *   1       1x = base 
    add  HL, HL         ; 1:11      1189 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1189 *   1  *2 = 4x
    ld    A, L          ; 1:4       1189 *   256*L = 1024x
    add  HL, BC         ; 1:11      1189 *      +1 = 5x 
    add  HL, HL         ; 1:11      1189 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1189 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1189 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1189 *      +1 = 41x 
    add  HL, HL         ; 1:11      1189 *   0  *2 = 82x 
    add  HL, HL         ; 1:11      1189 *   1  *2 = 164x
    add  HL, BC         ; 1:11      1189 *      +1 = 165x 
    add   A, H          ; 1:4       1189 *
    ld    H, A          ; 1:4       1189 *     [1189x] = 165x + 1024x  
                        ;[16:141]   1191 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1010_0111)
    ld    B, H          ; 1:4       1191 *
    ld    C, L          ; 1:4       1191 *   1       1x = base 
    add  HL, HL         ; 1:11      1191 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1191 *   1  *2 = 4x
    ld    A, L          ; 1:4       1191 *   256*L = 1024x
    add  HL, BC         ; 1:11      1191 *      +1 = 5x 
    add  HL, HL         ; 1:11      1191 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1191 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1191 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1191 *      +1 = 41x 
    add  HL, HL         ; 1:11      1191 *   1  *2 = 82x
    add  HL, BC         ; 1:11      1191 *      +1 = 83x 
    add  HL, HL         ; 1:11      1191 *   1  *2 = 166x
    add  HL, BC         ; 1:11      1191 *      +1 = 167x 
    add   A, H          ; 1:4       1191 *
    ld    H, A          ; 1:4       1191 *     [1191x] = 167x + 1024x  
                        ;[15:130]   1193 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1010_1001)
    ld    B, H          ; 1:4       1193 *
    ld    C, L          ; 1:4       1193 *   1       1x = base 
    add  HL, HL         ; 1:11      1193 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1193 *   1  *2 = 4x
    ld    A, L          ; 1:4       1193 *   256*L = 1024x
    add  HL, BC         ; 1:11      1193 *      +1 = 5x 
    add  HL, HL         ; 1:11      1193 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1193 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1193 *      +1 = 21x 
    add  HL, HL         ; 1:11      1193 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1193 *   0  *2 = 84x 
    add  HL, HL         ; 1:11      1193 *   1  *2 = 168x
    add  HL, BC         ; 1:11      1193 *      +1 = 169x 
    add   A, H          ; 1:4       1193 *
    ld    H, A          ; 1:4       1193 *     [1193x] = 169x + 1024x  
                        ;[16:141]   1195 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1010_1011)
    ld    B, H          ; 1:4       1195 *
    ld    C, L          ; 1:4       1195 *   1       1x = base 
    add  HL, HL         ; 1:11      1195 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1195 *   1  *2 = 4x
    ld    A, L          ; 1:4       1195 *   256*L = 1024x
    add  HL, BC         ; 1:11      1195 *      +1 = 5x 
    add  HL, HL         ; 1:11      1195 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1195 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1195 *      +1 = 21x 
    add  HL, HL         ; 1:11      1195 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1195 *   1  *2 = 84x
    add  HL, BC         ; 1:11      1195 *      +1 = 85x 
    add  HL, HL         ; 1:11      1195 *   1  *2 = 170x
    add  HL, BC         ; 1:11      1195 *      +1 = 171x 
    add   A, H          ; 1:4       1195 *
    ld    H, A          ; 1:4       1195 *     [1195x] = 171x + 1024x  
                        ;[16:141]   1197 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1010_1101)
    ld    B, H          ; 1:4       1197 *
    ld    C, L          ; 1:4       1197 *   1       1x = base 
    add  HL, HL         ; 1:11      1197 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1197 *   1  *2 = 4x
    ld    A, L          ; 1:4       1197 *   256*L = 1024x
    add  HL, BC         ; 1:11      1197 *      +1 = 5x 
    add  HL, HL         ; 1:11      1197 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1197 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1197 *      +1 = 21x 
    add  HL, HL         ; 1:11      1197 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1197 *      +1 = 43x 
    add  HL, HL         ; 1:11      1197 *   0  *2 = 86x 
    add  HL, HL         ; 1:11      1197 *   1  *2 = 172x
    add  HL, BC         ; 1:11      1197 *      +1 = 173x 
    add   A, H          ; 1:4       1197 *
    ld    H, A          ; 1:4       1197 *     [1197x] = 173x + 1024x  
                        ;[17:152]   1199 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1010_1111)
    ld    B, H          ; 1:4       1199 *
    ld    C, L          ; 1:4       1199 *   1       1x = base 
    add  HL, HL         ; 1:11      1199 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1199 *   1  *2 = 4x
    ld    A, L          ; 1:4       1199 *   256*L = 1024x
    add  HL, BC         ; 1:11      1199 *      +1 = 5x 
    add  HL, HL         ; 1:11      1199 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1199 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1199 *      +1 = 21x 
    add  HL, HL         ; 1:11      1199 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1199 *      +1 = 43x 
    add  HL, HL         ; 1:11      1199 *   1  *2 = 86x
    add  HL, BC         ; 1:11      1199 *      +1 = 87x 
    add  HL, HL         ; 1:11      1199 *   1  *2 = 174x
    add  HL, BC         ; 1:11      1199 *      +1 = 175x 
    add   A, H          ; 1:4       1199 *
    ld    H, A          ; 1:4       1199 *     [1199x] = 175x + 1024x 

                        ;[15:130]   1201 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1011_0001)
    ld    B, H          ; 1:4       1201 *
    ld    C, L          ; 1:4       1201 *   1       1x = base 
    add  HL, HL         ; 1:11      1201 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1201 *   1  *2 = 4x
    ld    A, L          ; 1:4       1201 *   256*L = 1024x
    add  HL, BC         ; 1:11      1201 *      +1 = 5x 
    add  HL, HL         ; 1:11      1201 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1201 *      +1 = 11x 
    add  HL, HL         ; 1:11      1201 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1201 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1201 *   0  *2 = 88x 
    add  HL, HL         ; 1:11      1201 *   1  *2 = 176x
    add  HL, BC         ; 1:11      1201 *      +1 = 177x 
    add   A, H          ; 1:4       1201 *
    ld    H, A          ; 1:4       1201 *     [1201x] = 177x + 1024x  
                        ;[16:141]   1203 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1011_0011)
    ld    B, H          ; 1:4       1203 *
    ld    C, L          ; 1:4       1203 *   1       1x = base 
    add  HL, HL         ; 1:11      1203 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1203 *   1  *2 = 4x
    ld    A, L          ; 1:4       1203 *   256*L = 1024x
    add  HL, BC         ; 1:11      1203 *      +1 = 5x 
    add  HL, HL         ; 1:11      1203 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1203 *      +1 = 11x 
    add  HL, HL         ; 1:11      1203 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1203 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1203 *   1  *2 = 88x
    add  HL, BC         ; 1:11      1203 *      +1 = 89x 
    add  HL, HL         ; 1:11      1203 *   1  *2 = 178x
    add  HL, BC         ; 1:11      1203 *      +1 = 179x 
    add   A, H          ; 1:4       1203 *
    ld    H, A          ; 1:4       1203 *     [1203x] = 179x + 1024x  
                        ;[16:141]   1205 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1011_0101)
    ld    B, H          ; 1:4       1205 *
    ld    C, L          ; 1:4       1205 *   1       1x = base 
    add  HL, HL         ; 1:11      1205 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1205 *   1  *2 = 4x
    ld    A, L          ; 1:4       1205 *   256*L = 1024x
    add  HL, BC         ; 1:11      1205 *      +1 = 5x 
    add  HL, HL         ; 1:11      1205 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1205 *      +1 = 11x 
    add  HL, HL         ; 1:11      1205 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1205 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1205 *      +1 = 45x 
    add  HL, HL         ; 1:11      1205 *   0  *2 = 90x 
    add  HL, HL         ; 1:11      1205 *   1  *2 = 180x
    add  HL, BC         ; 1:11      1205 *      +1 = 181x 
    add   A, H          ; 1:4       1205 *
    ld    H, A          ; 1:4       1205 *     [1205x] = 181x + 1024x  
                        ;[17:152]   1207 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1011_0111)
    ld    B, H          ; 1:4       1207 *
    ld    C, L          ; 1:4       1207 *   1       1x = base 
    add  HL, HL         ; 1:11      1207 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1207 *   1  *2 = 4x
    ld    A, L          ; 1:4       1207 *   256*L = 1024x
    add  HL, BC         ; 1:11      1207 *      +1 = 5x 
    add  HL, HL         ; 1:11      1207 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1207 *      +1 = 11x 
    add  HL, HL         ; 1:11      1207 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1207 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1207 *      +1 = 45x 
    add  HL, HL         ; 1:11      1207 *   1  *2 = 90x
    add  HL, BC         ; 1:11      1207 *      +1 = 91x 
    add  HL, HL         ; 1:11      1207 *   1  *2 = 182x
    add  HL, BC         ; 1:11      1207 *      +1 = 183x 
    add   A, H          ; 1:4       1207 *
    ld    H, A          ; 1:4       1207 *     [1207x] = 183x + 1024x  
                        ;[16:141]   1209 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1011_1001)
    ld    B, H          ; 1:4       1209 *
    ld    C, L          ; 1:4       1209 *   1       1x = base 
    add  HL, HL         ; 1:11      1209 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1209 *   1  *2 = 4x
    ld    A, L          ; 1:4       1209 *   256*L = 1024x
    add  HL, BC         ; 1:11      1209 *      +1 = 5x 
    add  HL, HL         ; 1:11      1209 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1209 *      +1 = 11x 
    add  HL, HL         ; 1:11      1209 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1209 *      +1 = 23x 
    add  HL, HL         ; 1:11      1209 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1209 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1209 *   1  *2 = 184x
    add  HL, BC         ; 1:11      1209 *      +1 = 185x 
    add   A, H          ; 1:4       1209 *
    ld    H, A          ; 1:4       1209 *     [1209x] = 185x + 1024x  
                        ;[17:152]   1211 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1011_1011)
    ld    B, H          ; 1:4       1211 *
    ld    C, L          ; 1:4       1211 *   1       1x = base 
    add  HL, HL         ; 1:11      1211 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1211 *   1  *2 = 4x
    ld    A, L          ; 1:4       1211 *   256*L = 1024x
    add  HL, BC         ; 1:11      1211 *      +1 = 5x 
    add  HL, HL         ; 1:11      1211 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1211 *      +1 = 11x 
    add  HL, HL         ; 1:11      1211 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1211 *      +1 = 23x 
    add  HL, HL         ; 1:11      1211 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1211 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1211 *      +1 = 93x 
    add  HL, HL         ; 1:11      1211 *   1  *2 = 186x
    add  HL, BC         ; 1:11      1211 *      +1 = 187x 
    add   A, H          ; 1:4       1211 *
    ld    H, A          ; 1:4       1211 *     [1211x] = 187x + 1024x  
                        ;[17:152]   1213 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1011_1101)
    ld    B, H          ; 1:4       1213 *
    ld    C, L          ; 1:4       1213 *   1       1x = base 
    add  HL, HL         ; 1:11      1213 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1213 *   1  *2 = 4x
    ld    A, L          ; 1:4       1213 *   256*L = 1024x
    add  HL, BC         ; 1:11      1213 *      +1 = 5x 
    add  HL, HL         ; 1:11      1213 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1213 *      +1 = 11x 
    add  HL, HL         ; 1:11      1213 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1213 *      +1 = 23x 
    add  HL, HL         ; 1:11      1213 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1213 *      +1 = 47x 
    add  HL, HL         ; 1:11      1213 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1213 *   1  *2 = 188x
    add  HL, BC         ; 1:11      1213 *      +1 = 189x 
    add   A, H          ; 1:4       1213 *
    ld    H, A          ; 1:4       1213 *     [1213x] = 189x + 1024x  
                        ;[18:163]   1215 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1011_1111)
    ld    B, H          ; 1:4       1215 *
    ld    C, L          ; 1:4       1215 *   1       1x = base 
    add  HL, HL         ; 1:11      1215 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1215 *   1  *2 = 4x
    ld    A, L          ; 1:4       1215 *   256*L = 1024x
    add  HL, BC         ; 1:11      1215 *      +1 = 5x 
    add  HL, HL         ; 1:11      1215 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1215 *      +1 = 11x 
    add  HL, HL         ; 1:11      1215 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1215 *      +1 = 23x 
    add  HL, HL         ; 1:11      1215 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1215 *      +1 = 47x 
    add  HL, HL         ; 1:11      1215 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1215 *      +1 = 95x 
    add  HL, HL         ; 1:11      1215 *   1  *2 = 190x
    add  HL, BC         ; 1:11      1215 *      +1 = 191x 
    add   A, H          ; 1:4       1215 *
    ld    H, A          ; 1:4       1215 *     [1215x] = 191x + 1024x  
                        ;[15:123]   1217 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1100_0001)
    ld    B, H          ; 1:4       1217 *
    ld    C, L          ; 1:4       1217 *   1       1x = base 
    ld    A, L          ; 1:4       1217 *   256*L = 256x 
    add  HL, HL         ; 1:11      1217 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1217 *      +1 = 3x 
    add   A, L          ; 1:4       1217 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1217 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1217 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1217 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1217 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1217 *   0  *2 = 96x 
    add  HL, HL         ; 1:11      1217 *   1  *2 = 192x
    add  HL, BC         ; 1:11      1217 *      +1 = 193x 
    add   A, H          ; 1:4       1217 *
    ld    H, A          ; 1:4       1217 *     [1217x] = 193x + 1024x 

                        ;[16:134]   1219 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1100_0011)
    ld    B, H          ; 1:4       1219 *
    ld    C, L          ; 1:4       1219 *   1       1x = base 
    ld    A, L          ; 1:4       1219 *   256*L = 256x 
    add  HL, HL         ; 1:11      1219 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1219 *      +1 = 3x 
    add   A, L          ; 1:4       1219 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1219 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1219 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1219 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1219 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1219 *   1  *2 = 96x
    add  HL, BC         ; 1:11      1219 *      +1 = 97x 
    add  HL, HL         ; 1:11      1219 *   1  *2 = 194x
    add  HL, BC         ; 1:11      1219 *      +1 = 195x 
    add   A, H          ; 1:4       1219 *
    ld    H, A          ; 1:4       1219 *     [1219x] = 195x + 1024x  
                        ;[16:134]   1221 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1100_0101)
    ld    B, H          ; 1:4       1221 *
    ld    C, L          ; 1:4       1221 *   1       1x = base 
    ld    A, L          ; 1:4       1221 *   256*L = 256x 
    add  HL, HL         ; 1:11      1221 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1221 *      +1 = 3x 
    add   A, L          ; 1:4       1221 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1221 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1221 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1221 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1221 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1221 *      +1 = 49x 
    add  HL, HL         ; 1:11      1221 *   0  *2 = 98x 
    add  HL, HL         ; 1:11      1221 *   1  *2 = 196x
    add  HL, BC         ; 1:11      1221 *      +1 = 197x 
    add   A, H          ; 1:4       1221 *
    ld    H, A          ; 1:4       1221 *     [1221x] = 197x + 1024x  
                        ;[17:145]   1223 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1100_0111)
    ld    B, H          ; 1:4       1223 *
    ld    C, L          ; 1:4       1223 *   1       1x = base 
    ld    A, L          ; 1:4       1223 *   256*L = 256x 
    add  HL, HL         ; 1:11      1223 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1223 *      +1 = 3x 
    add   A, L          ; 1:4       1223 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1223 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1223 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1223 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1223 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1223 *      +1 = 49x 
    add  HL, HL         ; 1:11      1223 *   1  *2 = 98x
    add  HL, BC         ; 1:11      1223 *      +1 = 99x 
    add  HL, HL         ; 1:11      1223 *   1  *2 = 198x
    add  HL, BC         ; 1:11      1223 *      +1 = 199x 
    add   A, H          ; 1:4       1223 *
    ld    H, A          ; 1:4       1223 *     [1223x] = 199x + 1024x  
                        ;[16:134]   1225 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1100_1001)
    ld    B, H          ; 1:4       1225 *
    ld    C, L          ; 1:4       1225 *   1       1x = base 
    ld    A, L          ; 1:4       1225 *   256*L = 256x 
    add  HL, HL         ; 1:11      1225 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1225 *      +1 = 3x 
    add   A, L          ; 1:4       1225 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1225 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1225 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1225 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1225 *      +1 = 25x 
    add  HL, HL         ; 1:11      1225 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1225 *   0  *2 = 100x 
    add  HL, HL         ; 1:11      1225 *   1  *2 = 200x
    add  HL, BC         ; 1:11      1225 *      +1 = 201x 
    add   A, H          ; 1:4       1225 *
    ld    H, A          ; 1:4       1225 *     [1225x] = 201x + 1024x  
                        ;[17:145]   1227 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1100_1011)
    ld    B, H          ; 1:4       1227 *
    ld    C, L          ; 1:4       1227 *   1       1x = base 
    ld    A, L          ; 1:4       1227 *   256*L = 256x 
    add  HL, HL         ; 1:11      1227 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1227 *      +1 = 3x 
    add   A, L          ; 1:4       1227 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1227 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1227 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1227 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1227 *      +1 = 25x 
    add  HL, HL         ; 1:11      1227 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1227 *   1  *2 = 100x
    add  HL, BC         ; 1:11      1227 *      +1 = 101x 
    add  HL, HL         ; 1:11      1227 *   1  *2 = 202x
    add  HL, BC         ; 1:11      1227 *      +1 = 203x 
    add   A, H          ; 1:4       1227 *
    ld    H, A          ; 1:4       1227 *     [1227x] = 203x + 1024x  
                        ;[17:145]   1229 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1100_1101)
    ld    B, H          ; 1:4       1229 *
    ld    C, L          ; 1:4       1229 *   1       1x = base 
    ld    A, L          ; 1:4       1229 *   256*L = 256x 
    add  HL, HL         ; 1:11      1229 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1229 *      +1 = 3x 
    add   A, L          ; 1:4       1229 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1229 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1229 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1229 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1229 *      +1 = 25x 
    add  HL, HL         ; 1:11      1229 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1229 *      +1 = 51x 
    add  HL, HL         ; 1:11      1229 *   0  *2 = 102x 
    add  HL, HL         ; 1:11      1229 *   1  *2 = 204x
    add  HL, BC         ; 1:11      1229 *      +1 = 205x 
    add   A, H          ; 1:4       1229 *
    ld    H, A          ; 1:4       1229 *     [1229x] = 205x + 1024x  
                        ;[18:156]   1231 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1100_1111)
    ld    B, H          ; 1:4       1231 *
    ld    C, L          ; 1:4       1231 *   1       1x = base 
    ld    A, L          ; 1:4       1231 *   256*L = 256x 
    add  HL, HL         ; 1:11      1231 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1231 *      +1 = 3x 
    add   A, L          ; 1:4       1231 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1231 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1231 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1231 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1231 *      +1 = 25x 
    add  HL, HL         ; 1:11      1231 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1231 *      +1 = 51x 
    add  HL, HL         ; 1:11      1231 *   1  *2 = 102x
    add  HL, BC         ; 1:11      1231 *      +1 = 103x 
    add  HL, HL         ; 1:11      1231 *   1  *2 = 206x
    add  HL, BC         ; 1:11      1231 *      +1 = 207x 
    add   A, H          ; 1:4       1231 *
    ld    H, A          ; 1:4       1231 *     [1231x] = 207x + 1024x  
                        ;[16:134]   1233 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1101_0001)
    ld    B, H          ; 1:4       1233 *
    ld    C, L          ; 1:4       1233 *   1       1x = base 
    ld    A, L          ; 1:4       1233 *   256*L = 256x 
    add  HL, HL         ; 1:11      1233 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1233 *      +1 = 3x 
    add   A, L          ; 1:4       1233 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1233 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1233 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1233 *      +1 = 13x 
    add  HL, HL         ; 1:11      1233 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1233 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      1233 *   0  *2 = 104x 
    add  HL, HL         ; 1:11      1233 *   1  *2 = 208x
    add  HL, BC         ; 1:11      1233 *      +1 = 209x 
    add   A, H          ; 1:4       1233 *
    ld    H, A          ; 1:4       1233 *     [1233x] = 209x + 1024x  
                        ;[17:145]   1235 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1101_0011)
    ld    B, H          ; 1:4       1235 *
    ld    C, L          ; 1:4       1235 *   1       1x = base 
    ld    A, L          ; 1:4       1235 *   256*L = 256x 
    add  HL, HL         ; 1:11      1235 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1235 *      +1 = 3x 
    add   A, L          ; 1:4       1235 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1235 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1235 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1235 *      +1 = 13x 
    add  HL, HL         ; 1:11      1235 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1235 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      1235 *   1  *2 = 104x
    add  HL, BC         ; 1:11      1235 *      +1 = 105x 
    add  HL, HL         ; 1:11      1235 *   1  *2 = 210x
    add  HL, BC         ; 1:11      1235 *      +1 = 211x 
    add   A, H          ; 1:4       1235 *
    ld    H, A          ; 1:4       1235 *     [1235x] = 211x + 1024x 

                        ;[17:145]   1237 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1101_0101)
    ld    B, H          ; 1:4       1237 *
    ld    C, L          ; 1:4       1237 *   1       1x = base 
    ld    A, L          ; 1:4       1237 *   256*L = 256x 
    add  HL, HL         ; 1:11      1237 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1237 *      +1 = 3x 
    add   A, L          ; 1:4       1237 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1237 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1237 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1237 *      +1 = 13x 
    add  HL, HL         ; 1:11      1237 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1237 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1237 *      +1 = 53x 
    add  HL, HL         ; 1:11      1237 *   0  *2 = 106x 
    add  HL, HL         ; 1:11      1237 *   1  *2 = 212x
    add  HL, BC         ; 1:11      1237 *      +1 = 213x 
    add   A, H          ; 1:4       1237 *
    ld    H, A          ; 1:4       1237 *     [1237x] = 213x + 1024x  
                        ;[18:156]   1239 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1101_0111)
    ld    B, H          ; 1:4       1239 *
    ld    C, L          ; 1:4       1239 *   1       1x = base 
    ld    A, L          ; 1:4       1239 *   256*L = 256x 
    add  HL, HL         ; 1:11      1239 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1239 *      +1 = 3x 
    add   A, L          ; 1:4       1239 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1239 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1239 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1239 *      +1 = 13x 
    add  HL, HL         ; 1:11      1239 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1239 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1239 *      +1 = 53x 
    add  HL, HL         ; 1:11      1239 *   1  *2 = 106x
    add  HL, BC         ; 1:11      1239 *      +1 = 107x 
    add  HL, HL         ; 1:11      1239 *   1  *2 = 214x
    add  HL, BC         ; 1:11      1239 *      +1 = 215x 
    add   A, H          ; 1:4       1239 *
    ld    H, A          ; 1:4       1239 *     [1239x] = 215x + 1024x  
                        ;[17:145]   1241 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1101_1001)
    ld    B, H          ; 1:4       1241 *
    ld    C, L          ; 1:4       1241 *   1       1x = base 
    ld    A, L          ; 1:4       1241 *   256*L = 256x 
    add  HL, HL         ; 1:11      1241 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1241 *      +1 = 3x 
    add   A, L          ; 1:4       1241 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1241 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1241 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1241 *      +1 = 13x 
    add  HL, HL         ; 1:11      1241 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1241 *      +1 = 27x 
    add  HL, HL         ; 1:11      1241 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      1241 *   0  *2 = 108x 
    add  HL, HL         ; 1:11      1241 *   1  *2 = 216x
    add  HL, BC         ; 1:11      1241 *      +1 = 217x 
    add   A, H          ; 1:4       1241 *
    ld    H, A          ; 1:4       1241 *     [1241x] = 217x + 1024x  
                        ;[18:156]   1243 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1101_1011)
    ld    B, H          ; 1:4       1243 *
    ld    C, L          ; 1:4       1243 *   1       1x = base 
    ld    A, L          ; 1:4       1243 *   256*L = 256x 
    add  HL, HL         ; 1:11      1243 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1243 *      +1 = 3x 
    add   A, L          ; 1:4       1243 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1243 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1243 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1243 *      +1 = 13x 
    add  HL, HL         ; 1:11      1243 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1243 *      +1 = 27x 
    add  HL, HL         ; 1:11      1243 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      1243 *   1  *2 = 108x
    add  HL, BC         ; 1:11      1243 *      +1 = 109x 
    add  HL, HL         ; 1:11      1243 *   1  *2 = 218x
    add  HL, BC         ; 1:11      1243 *      +1 = 219x 
    add   A, H          ; 1:4       1243 *
    ld    H, A          ; 1:4       1243 *     [1243x] = 219x + 1024x  
                        ;[18:156]   1245 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1101_1101)
    ld    B, H          ; 1:4       1245 *
    ld    C, L          ; 1:4       1245 *   1       1x = base 
    ld    A, L          ; 1:4       1245 *   256*L = 256x 
    add  HL, HL         ; 1:11      1245 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1245 *      +1 = 3x 
    add   A, L          ; 1:4       1245 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1245 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1245 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1245 *      +1 = 13x 
    add  HL, HL         ; 1:11      1245 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1245 *      +1 = 27x 
    add  HL, HL         ; 1:11      1245 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1245 *      +1 = 55x 
    add  HL, HL         ; 1:11      1245 *   0  *2 = 110x 
    add  HL, HL         ; 1:11      1245 *   1  *2 = 220x
    add  HL, BC         ; 1:11      1245 *      +1 = 221x 
    add   A, H          ; 1:4       1245 *
    ld    H, A          ; 1:4       1245 *     [1245x] = 221x + 1024x  
                        ;[19:167]   1247 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1101_1111)
    ld    B, H          ; 1:4       1247 *
    ld    C, L          ; 1:4       1247 *   1       1x = base 
    ld    A, L          ; 1:4       1247 *   256*L = 256x 
    add  HL, HL         ; 1:11      1247 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1247 *      +1 = 3x 
    add   A, L          ; 1:4       1247 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1247 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1247 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1247 *      +1 = 13x 
    add  HL, HL         ; 1:11      1247 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1247 *      +1 = 27x 
    add  HL, HL         ; 1:11      1247 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1247 *      +1 = 55x 
    add  HL, HL         ; 1:11      1247 *   1  *2 = 110x
    add  HL, BC         ; 1:11      1247 *      +1 = 111x 
    add  HL, HL         ; 1:11      1247 *   1  *2 = 222x
    add  HL, BC         ; 1:11      1247 *      +1 = 223x 
    add   A, H          ; 1:4       1247 *
    ld    H, A          ; 1:4       1247 *     [1247x] = 223x + 1024x  
                        ;[16:134]   1249 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1110_0001)
    ld    B, H          ; 1:4       1249 *
    ld    C, L          ; 1:4       1249 *   1       1x = base 
    ld    A, L          ; 1:4       1249 *   256*L = 256x 
    add  HL, HL         ; 1:11      1249 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1249 *      +1 = 3x 
    add   A, L          ; 1:4       1249 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1249 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1249 *      +1 = 7x 
    add  HL, HL         ; 1:11      1249 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1249 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1249 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      1249 *   0  *2 = 112x 
    add  HL, HL         ; 1:11      1249 *   1  *2 = 224x
    add  HL, BC         ; 1:11      1249 *      +1 = 225x 
    add   A, H          ; 1:4       1249 *
    ld    H, A          ; 1:4       1249 *     [1249x] = 225x + 1024x  
                        ;[17:145]   1251 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1110_0011)
    ld    B, H          ; 1:4       1251 *
    ld    C, L          ; 1:4       1251 *   1       1x = base 
    ld    A, L          ; 1:4       1251 *   256*L = 256x 
    add  HL, HL         ; 1:11      1251 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1251 *      +1 = 3x 
    add   A, L          ; 1:4       1251 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1251 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1251 *      +1 = 7x 
    add  HL, HL         ; 1:11      1251 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1251 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1251 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      1251 *   1  *2 = 112x
    add  HL, BC         ; 1:11      1251 *      +1 = 113x 
    add  HL, HL         ; 1:11      1251 *   1  *2 = 226x
    add  HL, BC         ; 1:11      1251 *      +1 = 227x 
    add   A, H          ; 1:4       1251 *
    ld    H, A          ; 1:4       1251 *     [1251x] = 227x + 1024x  
                        ;[17:145]   1253 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1110_0101)
    ld    B, H          ; 1:4       1253 *
    ld    C, L          ; 1:4       1253 *   1       1x = base 
    ld    A, L          ; 1:4       1253 *   256*L = 256x 
    add  HL, HL         ; 1:11      1253 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1253 *      +1 = 3x 
    add   A, L          ; 1:4       1253 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1253 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1253 *      +1 = 7x 
    add  HL, HL         ; 1:11      1253 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1253 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1253 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1253 *      +1 = 57x 
    add  HL, HL         ; 1:11      1253 *   0  *2 = 114x 
    add  HL, HL         ; 1:11      1253 *   1  *2 = 228x
    add  HL, BC         ; 1:11      1253 *      +1 = 229x 
    add   A, H          ; 1:4       1253 *
    ld    H, A          ; 1:4       1253 *     [1253x] = 229x + 1024x 

                        ;[18:156]   1255 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1110_0111)
    ld    B, H          ; 1:4       1255 *
    ld    C, L          ; 1:4       1255 *   1       1x = base 
    ld    A, L          ; 1:4       1255 *   256*L = 256x 
    add  HL, HL         ; 1:11      1255 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1255 *      +1 = 3x 
    add   A, L          ; 1:4       1255 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1255 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1255 *      +1 = 7x 
    add  HL, HL         ; 1:11      1255 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1255 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1255 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1255 *      +1 = 57x 
    add  HL, HL         ; 1:11      1255 *   1  *2 = 114x
    add  HL, BC         ; 1:11      1255 *      +1 = 115x 
    add  HL, HL         ; 1:11      1255 *   1  *2 = 230x
    add  HL, BC         ; 1:11      1255 *      +1 = 231x 
    add   A, H          ; 1:4       1255 *
    ld    H, A          ; 1:4       1255 *     [1255x] = 231x + 1024x  
                        ;[17:145]   1257 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1110_1001)
    ld    B, H          ; 1:4       1257 *
    ld    C, L          ; 1:4       1257 *   1       1x = base 
    ld    A, L          ; 1:4       1257 *   256*L = 256x 
    add  HL, HL         ; 1:11      1257 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1257 *      +1 = 3x 
    add   A, L          ; 1:4       1257 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1257 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1257 *      +1 = 7x 
    add  HL, HL         ; 1:11      1257 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1257 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1257 *      +1 = 29x 
    add  HL, HL         ; 1:11      1257 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1257 *   0  *2 = 116x 
    add  HL, HL         ; 1:11      1257 *   1  *2 = 232x
    add  HL, BC         ; 1:11      1257 *      +1 = 233x 
    add   A, H          ; 1:4       1257 *
    ld    H, A          ; 1:4       1257 *     [1257x] = 233x + 1024x  
                        ;[18:156]   1259 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1110_1011)
    ld    B, H          ; 1:4       1259 *
    ld    C, L          ; 1:4       1259 *   1       1x = base 
    ld    A, L          ; 1:4       1259 *   256*L = 256x 
    add  HL, HL         ; 1:11      1259 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1259 *      +1 = 3x 
    add   A, L          ; 1:4       1259 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1259 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1259 *      +1 = 7x 
    add  HL, HL         ; 1:11      1259 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1259 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1259 *      +1 = 29x 
    add  HL, HL         ; 1:11      1259 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1259 *   1  *2 = 116x
    add  HL, BC         ; 1:11      1259 *      +1 = 117x 
    add  HL, HL         ; 1:11      1259 *   1  *2 = 234x
    add  HL, BC         ; 1:11      1259 *      +1 = 235x 
    add   A, H          ; 1:4       1259 *
    ld    H, A          ; 1:4       1259 *     [1259x] = 235x + 1024x  
                        ;[18:156]   1261 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1110_1101)
    ld    B, H          ; 1:4       1261 *
    ld    C, L          ; 1:4       1261 *   1       1x = base 
    ld    A, L          ; 1:4       1261 *   256*L = 256x 
    add  HL, HL         ; 1:11      1261 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1261 *      +1 = 3x 
    add   A, L          ; 1:4       1261 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1261 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1261 *      +1 = 7x 
    add  HL, HL         ; 1:11      1261 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1261 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1261 *      +1 = 29x 
    add  HL, HL         ; 1:11      1261 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1261 *      +1 = 59x 
    add  HL, HL         ; 1:11      1261 *   0  *2 = 118x 
    add  HL, HL         ; 1:11      1261 *   1  *2 = 236x
    add  HL, BC         ; 1:11      1261 *      +1 = 237x 
    add   A, H          ; 1:4       1261 *
    ld    H, A          ; 1:4       1261 *     [1261x] = 237x + 1024x  
                        ;[19:111]   1263 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0011_0001_0001)  
    ld    A, L          ; 1:4       1263 *   256x 
    ld    B, H          ; 1:4       1263 *
    ld    C, L          ; 1:4       1263 *   [1x] 
    add  HL, HL         ; 1:11      1263 *   2x 
    add   A, L          ; 1:4       1263 *   768x 
    add  HL, HL         ; 1:11      1263 *   4x 
    add  HL, HL         ; 1:11      1263 *   8x 
    add   A, B          ; 1:4       1263 *
    ld    B, A          ; 1:4       1263 *   [769x]
    ld    A, L          ; 1:4       1263 *   save --2048x-- 
    add  HL, HL         ; 1:11      1263 *   16x 
    add  HL, BC         ; 1:11      1263 *   [785x]
    ld    B, A          ; 1:4       1263 *   A0 - HL
    xor   A             ; 1:4       1263 *
    sub   L             ; 1:4       1263 *
    ld    L, A          ; 1:4       1263 *
    ld    A, B          ; 1:4       1263 *
    sbc   A, H          ; 1:4       1263 *
    ld    H, A          ; 1:4       1263 *   [1263x] = 2048x - 2048x    
                        ;[17:145]   1265 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1111_0001)
    ld    B, H          ; 1:4       1265 *
    ld    C, L          ; 1:4       1265 *   1       1x = base 
    ld    A, L          ; 1:4       1265 *   256*L = 256x 
    add  HL, HL         ; 1:11      1265 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1265 *      +1 = 3x 
    add   A, L          ; 1:4       1265 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1265 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1265 *      +1 = 7x 
    add  HL, HL         ; 1:11      1265 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1265 *      +1 = 15x 
    add  HL, HL         ; 1:11      1265 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1265 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1265 *   0  *2 = 120x 
    add  HL, HL         ; 1:11      1265 *   1  *2 = 240x
    add  HL, BC         ; 1:11      1265 *      +1 = 241x 
    add   A, H          ; 1:4       1265 *
    ld    H, A          ; 1:4       1265 *     [1265x] = 241x + 1024x  
                        ;[18:156]   1267 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1111_0011)
    ld    B, H          ; 1:4       1267 *
    ld    C, L          ; 1:4       1267 *   1       1x = base 
    ld    A, L          ; 1:4       1267 *   256*L = 256x 
    add  HL, HL         ; 1:11      1267 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1267 *      +1 = 3x 
    add   A, L          ; 1:4       1267 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1267 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1267 *      +1 = 7x 
    add  HL, HL         ; 1:11      1267 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1267 *      +1 = 15x 
    add  HL, HL         ; 1:11      1267 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1267 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1267 *   1  *2 = 120x
    add  HL, BC         ; 1:11      1267 *      +1 = 121x 
    add  HL, HL         ; 1:11      1267 *   1  *2 = 242x
    add  HL, BC         ; 1:11      1267 *      +1 = 243x 
    add   A, H          ; 1:4       1267 *
    ld    H, A          ; 1:4       1267 *     [1267x] = 243x + 1024x  
                        ;[18:156]   1269 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1111_0101)
    ld    B, H          ; 1:4       1269 *
    ld    C, L          ; 1:4       1269 *   1       1x = base 
    ld    A, L          ; 1:4       1269 *   256*L = 256x 
    add  HL, HL         ; 1:11      1269 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1269 *      +1 = 3x 
    add   A, L          ; 1:4       1269 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1269 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1269 *      +1 = 7x 
    add  HL, HL         ; 1:11      1269 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1269 *      +1 = 15x 
    add  HL, HL         ; 1:11      1269 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1269 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1269 *      +1 = 61x 
    add  HL, HL         ; 1:11      1269 *   0  *2 = 122x 
    add  HL, HL         ; 1:11      1269 *   1  *2 = 244x
    add  HL, BC         ; 1:11      1269 *      +1 = 245x 
    add   A, H          ; 1:4       1269 *
    ld    H, A          ; 1:4       1269 *     [1269x] = 245x + 1024x  
                        ;[16:94]    1271 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0011_0000_1001)  
    ld    A, L          ; 1:4       1271 *   256x 
    ld    B, H          ; 1:4       1271 *
    ld    C, L          ; 1:4       1271 *   [1x] 
    add  HL, HL         ; 1:11      1271 *   2x 
    add   A, L          ; 1:4       1271 *   768x 
    add  HL, HL         ; 1:11      1271 *   4x 
    add  HL, HL         ; 1:11      1271 *   8x 
    sub   L             ; 1:4       1271 *   L0 - (HL + BC + A0) = 0 - ((HL + BC) + (A0 - L0))
    add  HL, BC         ; 1:11      1271 *   [9x]
    add   A, H          ; 1:4       1271 *   [-1271x]
    cpl                 ; 1:4       1271 *
    ld    H, A          ; 1:4       1271 *
    ld    A, L          ; 1:4       1271 *
    cpl                 ; 1:4       1271 *
    ld    L, A          ; 1:4       1271 *
    inc  HL             ; 1:6       1271 *   [1271x] = 0-1271x   

                        ;[18:156]   1273 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1111_1001)
    ld    B, H          ; 1:4       1273 *
    ld    C, L          ; 1:4       1273 *   1       1x = base 
    ld    A, L          ; 1:4       1273 *   256*L = 256x 
    add  HL, HL         ; 1:11      1273 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1273 *      +1 = 3x 
    add   A, L          ; 1:4       1273 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1273 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1273 *      +1 = 7x 
    add  HL, HL         ; 1:11      1273 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1273 *      +1 = 15x 
    add  HL, HL         ; 1:11      1273 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1273 *      +1 = 31x 
    add  HL, HL         ; 1:11      1273 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1273 *   0  *2 = 124x 
    add  HL, HL         ; 1:11      1273 *   1  *2 = 248x
    add  HL, BC         ; 1:11      1273 *      +1 = 249x 
    add   A, H          ; 1:4       1273 *
    ld    H, A          ; 1:4       1273 *     [1273x] = 249x + 1024x  
                        ;[19:167]   1275 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1111_1011)
    ld    B, H          ; 1:4       1275 *
    ld    C, L          ; 1:4       1275 *   1       1x = base 
    ld    A, L          ; 1:4       1275 *   256*L = 256x 
    add  HL, HL         ; 1:11      1275 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1275 *      +1 = 3x 
    add   A, L          ; 1:4       1275 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1275 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1275 *      +1 = 7x 
    add  HL, HL         ; 1:11      1275 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1275 *      +1 = 15x 
    add  HL, HL         ; 1:11      1275 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1275 *      +1 = 31x 
    add  HL, HL         ; 1:11      1275 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1275 *   1  *2 = 124x
    add  HL, BC         ; 1:11      1275 *      +1 = 125x 
    add  HL, HL         ; 1:11      1275 *   1  *2 = 250x
    add  HL, BC         ; 1:11      1275 *      +1 = 251x 
    add   A, H          ; 1:4       1275 *
    ld    H, A          ; 1:4       1275 *     [1275x] = 251x + 1024x  
                        ;[19:167]   1277 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0100_1111_1101)
    ld    B, H          ; 1:4       1277 *
    ld    C, L          ; 1:4       1277 *   1       1x = base 
    ld    A, L          ; 1:4       1277 *   256*L = 256x 
    add  HL, HL         ; 1:11      1277 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1277 *      +1 = 3x 
    add   A, L          ; 1:4       1277 *  +256*L = 1024x 
    add  HL, HL         ; 1:11      1277 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1277 *      +1 = 7x 
    add  HL, HL         ; 1:11      1277 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1277 *      +1 = 15x 
    add  HL, HL         ; 1:11      1277 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1277 *      +1 = 31x 
    add  HL, HL         ; 1:11      1277 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1277 *      +1 = 63x 
    add  HL, HL         ; 1:11      1277 *   0  *2 = 126x 
    add  HL, HL         ; 1:11      1277 *   1  *2 = 252x
    add  HL, BC         ; 1:11      1277 *      +1 = 253x 
    add   A, H          ; 1:4       1277 *
    ld    H, A          ; 1:4       1277 *     [1277x] = 253x + 1024x  
                        ;[15:87]    1279 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0011_0000_0001)  
    ld    A, L          ; 1:4       1279 *   256x 
    ld    B, H          ; 1:4       1279 *
    ld    C, L          ; 1:4       1279 *   [1x] 
    add  HL, HL         ; 1:11      1279 *   2x 
    add   A, L          ; 1:4       1279 *   768x 
    add  HL, HL         ; 1:11      1279 *   4x 
    add  HL, HL         ; 1:11      1279 *   8x 
    add   A, B          ; 1:4       1279 *
    ld    B, A          ; 1:4       1279 *   [769x]
    ld    H, L          ; 1:4       1279 *
    ld    L, 0x00       ; 2:7       1279 *   2048x 
    or    A             ; 1:4       1279 *
    sbc  HL, BC         ; 2:15      1279 *   [1279x] = 2048x - 769x   
                        ;[6:24]     1281 *   Variant mk4: 256*...(((L*2^a)+L)*2^b)+... = HL * (b_0101_0000_0001)
    ld    A, L          ; 1:4       1281 *   1       1x 
    add   A, A          ; 1:4       1281 *   0  *2 = 2x 
    add   A, A          ; 1:4       1281 *   1  *2 = 4x
    add   A, L          ; 1:4       1281 *      +1 = 5x 
    add   A, H          ; 1:4       1281 *
    ld    H, A          ; 1:4       1281 *     [1281x] = 256 * 5x + 1x  
                        ;[10:54]    1283 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0000_0011)
    ld    B, H          ; 1:4       1283 *
    ld    C, L          ; 1:4       1283 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1283 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1283 *      +1 = 3x  
    ld    A, C          ; 1:4       1283 *   1       1x 
    add   A, A          ; 1:4       1283 *   0  *2 = 2x 
    add   A, A          ; 1:4       1283 *   1  *2 = 4x
    add   A, C          ; 1:4       1283 *      +1 = 5x 
    add   A, H          ; 1:4       1283 *
    ld    H, A          ; 1:4       1283 *     [1283x] = 256 * 5x + 3x  
                        ;[8:53]     1285 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0000_0101)
    ld    B, H          ; 1:4       1285 *
    ld    C, L          ; 1:4       1285 *   1       1x = base 
    add  HL, HL         ; 1:11      1285 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1285 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1285 *      +1 = 5x 
    ld    A, L          ; 1:4       1285 *   256*L = 1280x 
    add   A, H          ; 1:4       1285 *
    ld    H, A          ; 1:4       1285 *     [1285x] = 5x + 1280x  
                        ;[12:76]    1287 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0000_0111)
    ld    B, H          ; 1:4       1287 *
    ld    C, L          ; 1:4       1287 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1287 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1287 *      +1 = 3x 
    add  HL, HL         ; 1:11      1287 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1287 *      +1 = 7x  
    ld    A, C          ; 1:4       1287 *   1       1x 
    add   A, A          ; 1:4       1287 *   0  *2 = 2x 
    add   A, A          ; 1:4       1287 *   1  *2 = 4x
    add   A, C          ; 1:4       1287 *      +1 = 5x 
    add   A, H          ; 1:4       1287 *
    ld    H, A          ; 1:4       1287 *     [1287x] = 256 * 5x + 7x  
                        ;[10:68]    1289 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0101_0000_1001)  
    ld    A, L          ; 1:4       1289 *   256x 
    ld    B, H          ; 1:4       1289 *
    ld    C, L          ; 1:4       1289 *   [1x] 
    add  HL, HL         ; 1:11      1289 *   2x 
    add  HL, HL         ; 1:11      1289 *   4x 
    add   A, L          ; 1:4       1289 *   1280x 
    add  HL, HL         ; 1:11      1289 *   8x 
    add   A, B          ; 1:4       1289 *
    ld    B, A          ; 1:4       1289 *   [1281x] 
    add  HL, BC         ; 1:11      1289 *   [1289x] = 8x + 1281x  

                        ;[10:75]    1291 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0000_1011)
    ld    B, H          ; 1:4       1291 *
    ld    C, L          ; 1:4       1291 *   1       1x = base 
    add  HL, HL         ; 1:11      1291 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1291 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1291 *      +1 = 5x 
    ld    A, L          ; 1:4       1291 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1291 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1291 *      +1 = 11x 
    add   A, H          ; 1:4       1291 *
    ld    H, A          ; 1:4       1291 *     [1291x] = 11x + 1280x  
                        ;[13:87]    1293 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0000_1101)
    ld    B, H          ; 1:4       1293 *
    ld    C, L          ; 1:4       1293 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1293 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1293 *      +1 = 3x 
    add  HL, HL         ; 1:11      1293 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1293 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1293 *      +1 = 13x  
    ld    A, C          ; 1:4       1293 *   1       1x 
    add   A, A          ; 1:4       1293 *   0  *2 = 2x 
    add   A, A          ; 1:4       1293 *   1  *2 = 4x
    add   A, C          ; 1:4       1293 *      +1 = 5x 
    add   A, H          ; 1:4       1293 *
    ld    H, A          ; 1:4       1293 *     [1293x] = 256 * 5x + 13x  
                        ;[14:98]    1295 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0000_1111)
    ld    B, H          ; 1:4       1295 *
    ld    C, L          ; 1:4       1295 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1295 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1295 *      +1 = 3x 
    add  HL, HL         ; 1:11      1295 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1295 *      +1 = 7x 
    add  HL, HL         ; 1:11      1295 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1295 *      +1 = 15x  
    ld    A, C          ; 1:4       1295 *   1       1x 
    add   A, A          ; 1:4       1295 *   0  *2 = 2x 
    add   A, A          ; 1:4       1295 *   1  *2 = 4x
    add   A, C          ; 1:4       1295 *      +1 = 5x 
    add   A, H          ; 1:4       1295 *
    ld    H, A          ; 1:4       1295 *     [1295x] = 256 * 5x + 15x  
                        ;[11:79]    1297 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0101_0001_0001)  
    ld    A, L          ; 1:4       1297 *   256x 
    ld    B, H          ; 1:4       1297 *
    ld    C, L          ; 1:4       1297 *   [1x] 
    add  HL, HL         ; 1:11      1297 *   2x 
    add  HL, HL         ; 1:11      1297 *   4x 
    add   A, L          ; 1:4       1297 *   1280x 
    add  HL, HL         ; 1:11      1297 *   8x 
    add  HL, HL         ; 1:11      1297 *   16x 
    add   A, B          ; 1:4       1297 *
    ld    B, A          ; 1:4       1297 *   [1281x] 
    add  HL, BC         ; 1:11      1297 *   [1297x] = 16x + 1281x   
                        ;[12:90]    1299 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0001_0011)
    ld    B, H          ; 1:4       1299 *
    ld    C, L          ; 1:4       1299 *   1       1x = base 
    ld    A, L          ; 1:4       1299 *   256*L = 256x 
    add  HL, HL         ; 1:11      1299 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1299 *   0  *2 = 4x 
    add   A, L          ; 1:4       1299 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1299 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1299 *      +1 = 9x 
    add  HL, HL         ; 1:11      1299 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1299 *      +1 = 19x 
    add   A, H          ; 1:4       1299 *
    ld    H, A          ; 1:4       1299 *     [1299x] = 19x + 1280x  
                        ;[11:86]    1301 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0001_0101)
    ld    B, H          ; 1:4       1301 *
    ld    C, L          ; 1:4       1301 *   1       1x = base 
    add  HL, HL         ; 1:11      1301 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1301 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1301 *      +1 = 5x 
    ld    A, L          ; 1:4       1301 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1301 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1301 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1301 *      +1 = 21x 
    add   A, H          ; 1:4       1301 *
    ld    H, A          ; 1:4       1301 *     [1301x] = 21x + 1280x  
                        ;[12:97]    1303 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0001_0111)
    ld    B, H          ; 1:4       1303 *
    ld    C, L          ; 1:4       1303 *   1       1x = base 
    add  HL, HL         ; 1:11      1303 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1303 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1303 *      +1 = 5x 
    ld    A, L          ; 1:4       1303 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1303 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1303 *      +1 = 11x 
    add  HL, HL         ; 1:11      1303 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1303 *      +1 = 23x 
    add   A, H          ; 1:4       1303 *
    ld    H, A          ; 1:4       1303 *     [1303x] = 23x + 1280x  
                        ;[14:98]    1305 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0001_1001)
    ld    B, H          ; 1:4       1305 *
    ld    C, L          ; 1:4       1305 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1305 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1305 *      +1 = 3x 
    add  HL, HL         ; 1:11      1305 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1305 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1305 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1305 *      +1 = 25x  
    ld    A, C          ; 1:4       1305 *   1       1x 
    add   A, A          ; 1:4       1305 *   0  *2 = 2x 
    add   A, A          ; 1:4       1305 *   1  *2 = 4x
    add   A, C          ; 1:4       1305 *      +1 = 5x 
    add   A, H          ; 1:4       1305 *
    ld    H, A          ; 1:4       1305 *     [1305x] = 256 * 5x + 25x  
                        ;[15:109]   1307 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0001_1011)
    ld    B, H          ; 1:4       1307 *
    ld    C, L          ; 1:4       1307 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1307 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1307 *      +1 = 3x 
    add  HL, HL         ; 1:11      1307 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1307 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1307 *      +1 = 13x 
    add  HL, HL         ; 1:11      1307 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1307 *      +1 = 27x  
    ld    A, C          ; 1:4       1307 *   1       1x 
    add   A, A          ; 1:4       1307 *   0  *2 = 2x 
    add   A, A          ; 1:4       1307 *   1  *2 = 4x
    add   A, C          ; 1:4       1307 *      +1 = 5x 
    add   A, H          ; 1:4       1307 *
    ld    H, A          ; 1:4       1307 *     [1307x] = 256 * 5x + 27x 

                        ;[15:109]   1309 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0001_1101)
    ld    B, H          ; 1:4       1309 *
    ld    C, L          ; 1:4       1309 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1309 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1309 *      +1 = 3x 
    add  HL, HL         ; 1:11      1309 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1309 *      +1 = 7x 
    add  HL, HL         ; 1:11      1309 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1309 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1309 *      +1 = 29x  
    ld    A, C          ; 1:4       1309 *   1       1x 
    add   A, A          ; 1:4       1309 *   0  *2 = 2x 
    add   A, A          ; 1:4       1309 *   1  *2 = 4x
    add   A, C          ; 1:4       1309 *      +1 = 5x 
    add   A, H          ; 1:4       1309 *
    ld    H, A          ; 1:4       1309 *     [1309x] = 256 * 5x + 29x  
                        ;[16:120]   1311 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0001_1111)
    ld    B, H          ; 1:4       1311 *
    ld    C, L          ; 1:4       1311 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1311 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1311 *      +1 = 3x 
    add  HL, HL         ; 1:11      1311 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1311 *      +1 = 7x 
    add  HL, HL         ; 1:11      1311 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1311 *      +1 = 15x 
    add  HL, HL         ; 1:11      1311 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1311 *      +1 = 31x  
    ld    A, C          ; 1:4       1311 *   1       1x 
    add   A, A          ; 1:4       1311 *   0  *2 = 2x 
    add   A, A          ; 1:4       1311 *   1  *2 = 4x
    add   A, C          ; 1:4       1311 *      +1 = 5x 
    add   A, H          ; 1:4       1311 *
    ld    H, A          ; 1:4       1311 *     [1311x] = 256 * 5x + 31x  
                        ;[12:90]    1313 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0101_0010_0001)  
    ld    A, L          ; 1:4       1313 *   256x 
    ld    B, H          ; 1:4       1313 *
    ld    C, L          ; 1:4       1313 *   [1x] 
    add  HL, HL         ; 1:11      1313 *   2x 
    add  HL, HL         ; 1:11      1313 *   4x 
    add   A, L          ; 1:4       1313 *   1280x 
    add  HL, HL         ; 1:11      1313 *   8x 
    add  HL, HL         ; 1:11      1313 *   16x 
    add  HL, HL         ; 1:11      1313 *   32x 
    add   A, B          ; 1:4       1313 *
    ld    B, A          ; 1:4       1313 *   [1281x] 
    add  HL, BC         ; 1:11      1313 *   [1313x] = 32x + 1281x   
                        ;[13:101]   1315 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0010_0011)
    ld    B, H          ; 1:4       1315 *
    ld    C, L          ; 1:4       1315 *   1       1x = base 
    ld    A, L          ; 1:4       1315 *   256*L = 256x 
    add  HL, HL         ; 1:11      1315 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1315 *   0  *2 = 4x 
    add   A, L          ; 1:4       1315 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1315 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1315 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1315 *      +1 = 17x 
    add  HL, HL         ; 1:11      1315 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1315 *      +1 = 35x 
    add   A, H          ; 1:4       1315 *
    ld    H, A          ; 1:4       1315 *     [1315x] = 35x + 1280x  
                        ;[13:101]   1317 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0010_0101)
    ld    B, H          ; 1:4       1317 *
    ld    C, L          ; 1:4       1317 *   1       1x = base 
    ld    A, L          ; 1:4       1317 *   256*L = 256x 
    add  HL, HL         ; 1:11      1317 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1317 *   0  *2 = 4x 
    add   A, L          ; 1:4       1317 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1317 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1317 *      +1 = 9x 
    add  HL, HL         ; 1:11      1317 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1317 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1317 *      +1 = 37x 
    add   A, H          ; 1:4       1317 *
    ld    H, A          ; 1:4       1317 *     [1317x] = 37x + 1280x  
                        ;[14:112]   1319 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0010_0111)
    ld    B, H          ; 1:4       1319 *
    ld    C, L          ; 1:4       1319 *   1       1x = base 
    ld    A, L          ; 1:4       1319 *   256*L = 256x 
    add  HL, HL         ; 1:11      1319 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1319 *   0  *2 = 4x 
    add   A, L          ; 1:4       1319 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1319 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1319 *      +1 = 9x 
    add  HL, HL         ; 1:11      1319 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1319 *      +1 = 19x 
    add  HL, HL         ; 1:11      1319 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1319 *      +1 = 39x 
    add   A, H          ; 1:4       1319 *
    ld    H, A          ; 1:4       1319 *     [1319x] = 39x + 1280x  
                        ;[12:97]    1321 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0010_1001)
    ld    B, H          ; 1:4       1321 *
    ld    C, L          ; 1:4       1321 *   1       1x = base 
    add  HL, HL         ; 1:11      1321 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1321 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1321 *      +1 = 5x 
    ld    A, L          ; 1:4       1321 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1321 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1321 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1321 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1321 *      +1 = 41x 
    add   A, H          ; 1:4       1321 *
    ld    H, A          ; 1:4       1321 *     [1321x] = 41x + 1280x  
                        ;[13:108]   1323 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0010_1011)
    ld    B, H          ; 1:4       1323 *
    ld    C, L          ; 1:4       1323 *   1       1x = base 
    add  HL, HL         ; 1:11      1323 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1323 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1323 *      +1 = 5x 
    ld    A, L          ; 1:4       1323 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1323 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1323 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1323 *      +1 = 21x 
    add  HL, HL         ; 1:11      1323 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1323 *      +1 = 43x 
    add   A, H          ; 1:4       1323 *
    ld    H, A          ; 1:4       1323 *     [1323x] = 43x + 1280x  
                        ;[13:108]   1325 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0010_1101)
    ld    B, H          ; 1:4       1325 *
    ld    C, L          ; 1:4       1325 *   1       1x = base 
    add  HL, HL         ; 1:11      1325 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1325 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1325 *      +1 = 5x 
    ld    A, L          ; 1:4       1325 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1325 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1325 *      +1 = 11x 
    add  HL, HL         ; 1:11      1325 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1325 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1325 *      +1 = 45x 
    add   A, H          ; 1:4       1325 *
    ld    H, A          ; 1:4       1325 *     [1325x] = 45x + 1280x 

                        ;[14:119]   1327 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0010_1111)
    ld    B, H          ; 1:4       1327 *
    ld    C, L          ; 1:4       1327 *   1       1x = base 
    add  HL, HL         ; 1:11      1327 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1327 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1327 *      +1 = 5x 
    ld    A, L          ; 1:4       1327 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1327 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1327 *      +1 = 11x 
    add  HL, HL         ; 1:11      1327 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1327 *      +1 = 23x 
    add  HL, HL         ; 1:11      1327 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1327 *      +1 = 47x 
    add   A, H          ; 1:4       1327 *
    ld    H, A          ; 1:4       1327 *     [1327x] = 47x + 1280x  
                        ;[15:109]   1329 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0011_0001)
    ld    B, H          ; 1:4       1329 *
    ld    C, L          ; 1:4       1329 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1329 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1329 *      +1 = 3x 
    add  HL, HL         ; 1:11      1329 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1329 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1329 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1329 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1329 *      +1 = 49x  
    ld    A, C          ; 1:4       1329 *   1       1x 
    add   A, A          ; 1:4       1329 *   0  *2 = 2x 
    add   A, A          ; 1:4       1329 *   1  *2 = 4x
    add   A, C          ; 1:4       1329 *      +1 = 5x 
    add   A, H          ; 1:4       1329 *
    ld    H, A          ; 1:4       1329 *     [1329x] = 256 * 5x + 49x  
                        ;[16:120]   1331 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0011_0011)
    ld    B, H          ; 1:4       1331 *
    ld    C, L          ; 1:4       1331 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1331 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1331 *      +1 = 3x 
    add  HL, HL         ; 1:11      1331 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1331 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1331 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1331 *      +1 = 25x 
    add  HL, HL         ; 1:11      1331 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1331 *      +1 = 51x  
    ld    A, C          ; 1:4       1331 *   1       1x 
    add   A, A          ; 1:4       1331 *   0  *2 = 2x 
    add   A, A          ; 1:4       1331 *   1  *2 = 4x
    add   A, C          ; 1:4       1331 *      +1 = 5x 
    add   A, H          ; 1:4       1331 *
    ld    H, A          ; 1:4       1331 *     [1331x] = 256 * 5x + 51x  
                        ;[16:120]   1333 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0011_0101)
    ld    B, H          ; 1:4       1333 *
    ld    C, L          ; 1:4       1333 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1333 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1333 *      +1 = 3x 
    add  HL, HL         ; 1:11      1333 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1333 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1333 *      +1 = 13x 
    add  HL, HL         ; 1:11      1333 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1333 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1333 *      +1 = 53x  
    ld    A, C          ; 1:4       1333 *   1       1x 
    add   A, A          ; 1:4       1333 *   0  *2 = 2x 
    add   A, A          ; 1:4       1333 *   1  *2 = 4x
    add   A, C          ; 1:4       1333 *      +1 = 5x 
    add   A, H          ; 1:4       1333 *
    ld    H, A          ; 1:4       1333 *     [1333x] = 256 * 5x + 53x  
                        ;[17:131]   1335 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0011_0111)
    ld    B, H          ; 1:4       1335 *
    ld    C, L          ; 1:4       1335 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1335 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1335 *      +1 = 3x 
    add  HL, HL         ; 1:11      1335 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1335 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1335 *      +1 = 13x 
    add  HL, HL         ; 1:11      1335 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1335 *      +1 = 27x 
    add  HL, HL         ; 1:11      1335 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1335 *      +1 = 55x  
    ld    A, C          ; 1:4       1335 *   1       1x 
    add   A, A          ; 1:4       1335 *   0  *2 = 2x 
    add   A, A          ; 1:4       1335 *   1  *2 = 4x
    add   A, C          ; 1:4       1335 *      +1 = 5x 
    add   A, H          ; 1:4       1335 *
    ld    H, A          ; 1:4       1335 *     [1335x] = 256 * 5x + 55x  
                        ;[16:120]   1337 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0011_1001)
    ld    B, H          ; 1:4       1337 *
    ld    C, L          ; 1:4       1337 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1337 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1337 *      +1 = 3x 
    add  HL, HL         ; 1:11      1337 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1337 *      +1 = 7x 
    add  HL, HL         ; 1:11      1337 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1337 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1337 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1337 *      +1 = 57x  
    ld    A, C          ; 1:4       1337 *   1       1x 
    add   A, A          ; 1:4       1337 *   0  *2 = 2x 
    add   A, A          ; 1:4       1337 *   1  *2 = 4x
    add   A, C          ; 1:4       1337 *      +1 = 5x 
    add   A, H          ; 1:4       1337 *
    ld    H, A          ; 1:4       1337 *     [1337x] = 256 * 5x + 57x  
                        ;[17:131]   1339 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0011_1011)
    ld    B, H          ; 1:4       1339 *
    ld    C, L          ; 1:4       1339 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1339 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1339 *      +1 = 3x 
    add  HL, HL         ; 1:11      1339 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1339 *      +1 = 7x 
    add  HL, HL         ; 1:11      1339 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1339 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1339 *      +1 = 29x 
    add  HL, HL         ; 1:11      1339 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1339 *      +1 = 59x  
    ld    A, C          ; 1:4       1339 *   1       1x 
    add   A, A          ; 1:4       1339 *   0  *2 = 2x 
    add   A, A          ; 1:4       1339 *   1  *2 = 4x
    add   A, C          ; 1:4       1339 *      +1 = 5x 
    add   A, H          ; 1:4       1339 *
    ld    H, A          ; 1:4       1339 *     [1339x] = 256 * 5x + 59x  
                        ;[17:131]   1341 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0011_1101)
    ld    B, H          ; 1:4       1341 *
    ld    C, L          ; 1:4       1341 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1341 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1341 *      +1 = 3x 
    add  HL, HL         ; 1:11      1341 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1341 *      +1 = 7x 
    add  HL, HL         ; 1:11      1341 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1341 *      +1 = 15x 
    add  HL, HL         ; 1:11      1341 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1341 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1341 *      +1 = 61x  
    ld    A, C          ; 1:4       1341 *   1       1x 
    add   A, A          ; 1:4       1341 *   0  *2 = 2x 
    add   A, A          ; 1:4       1341 *   1  *2 = 4x
    add   A, C          ; 1:4       1341 *      +1 = 5x 
    add   A, H          ; 1:4       1341 *
    ld    H, A          ; 1:4       1341 *     [1341x] = 256 * 5x + 61x  
                        ;[18:142]   1343 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0011_1111)
    ld    B, H          ; 1:4       1343 *
    ld    C, L          ; 1:4       1343 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1343 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1343 *      +1 = 3x 
    add  HL, HL         ; 1:11      1343 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1343 *      +1 = 7x 
    add  HL, HL         ; 1:11      1343 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1343 *      +1 = 15x 
    add  HL, HL         ; 1:11      1343 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1343 *      +1 = 31x 
    add  HL, HL         ; 1:11      1343 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1343 *      +1 = 63x  
    ld    A, C          ; 1:4       1343 *   1       1x 
    add   A, A          ; 1:4       1343 *   0  *2 = 2x 
    add   A, A          ; 1:4       1343 *   1  *2 = 4x
    add   A, C          ; 1:4       1343 *      +1 = 5x 
    add   A, H          ; 1:4       1343 *
    ld    H, A          ; 1:4       1343 *     [1343x] = 256 * 5x + 63x 

                        ;[13:101]   1345 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0101_0100_0001)  
    ld    A, L          ; 1:4       1345 *   256x 
    ld    B, H          ; 1:4       1345 *
    ld    C, L          ; 1:4       1345 *   [1x] 
    add  HL, HL         ; 1:11      1345 *   2x 
    add  HL, HL         ; 1:11      1345 *   4x 
    add   A, L          ; 1:4       1345 *   1280x 
    add  HL, HL         ; 1:11      1345 *   8x 
    add  HL, HL         ; 1:11      1345 *   16x 
    add  HL, HL         ; 1:11      1345 *   32x 
    add  HL, HL         ; 1:11      1345 *   64x 
    add   A, B          ; 1:4       1345 *
    ld    B, A          ; 1:4       1345 *   [1281x] 
    add  HL, BC         ; 1:11      1345 *   [1345x] = 64x + 1281x   
                        ;[14:112]   1347 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0100_0011)
    ld    B, H          ; 1:4       1347 *
    ld    C, L          ; 1:4       1347 *   1       1x = base 
    ld    A, L          ; 1:4       1347 *   256*L = 256x 
    add  HL, HL         ; 1:11      1347 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1347 *   0  *2 = 4x 
    add   A, L          ; 1:4       1347 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1347 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1347 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1347 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1347 *      +1 = 33x 
    add  HL, HL         ; 1:11      1347 *   1  *2 = 66x
    add  HL, BC         ; 1:11      1347 *      +1 = 67x 
    add   A, H          ; 1:4       1347 *
    ld    H, A          ; 1:4       1347 *     [1347x] = 67x + 1280x  
                        ;[14:112]   1349 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0100_0101)
    ld    B, H          ; 1:4       1349 *
    ld    C, L          ; 1:4       1349 *   1       1x = base 
    ld    A, L          ; 1:4       1349 *   256*L = 256x 
    add  HL, HL         ; 1:11      1349 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1349 *   0  *2 = 4x 
    add   A, L          ; 1:4       1349 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1349 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1349 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1349 *      +1 = 17x 
    add  HL, HL         ; 1:11      1349 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1349 *   1  *2 = 68x
    add  HL, BC         ; 1:11      1349 *      +1 = 69x 
    add   A, H          ; 1:4       1349 *
    ld    H, A          ; 1:4       1349 *     [1349x] = 69x + 1280x  
                        ;[15:123]   1351 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0100_0111)
    ld    B, H          ; 1:4       1351 *
    ld    C, L          ; 1:4       1351 *   1       1x = base 
    ld    A, L          ; 1:4       1351 *   256*L = 256x 
    add  HL, HL         ; 1:11      1351 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1351 *   0  *2 = 4x 
    add   A, L          ; 1:4       1351 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1351 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1351 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1351 *      +1 = 17x 
    add  HL, HL         ; 1:11      1351 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1351 *      +1 = 35x 
    add  HL, HL         ; 1:11      1351 *   1  *2 = 70x
    add  HL, BC         ; 1:11      1351 *      +1 = 71x 
    add   A, H          ; 1:4       1351 *
    ld    H, A          ; 1:4       1351 *     [1351x] = 71x + 1280x  
                        ;[14:112]   1353 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0100_1001)
    ld    B, H          ; 1:4       1353 *
    ld    C, L          ; 1:4       1353 *   1       1x = base 
    ld    A, L          ; 1:4       1353 *   256*L = 256x 
    add  HL, HL         ; 1:11      1353 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1353 *   0  *2 = 4x 
    add   A, L          ; 1:4       1353 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1353 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1353 *      +1 = 9x 
    add  HL, HL         ; 1:11      1353 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1353 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1353 *   1  *2 = 72x
    add  HL, BC         ; 1:11      1353 *      +1 = 73x 
    add   A, H          ; 1:4       1353 *
    ld    H, A          ; 1:4       1353 *     [1353x] = 73x + 1280x  
                        ;[15:123]   1355 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0100_1011)
    ld    B, H          ; 1:4       1355 *
    ld    C, L          ; 1:4       1355 *   1       1x = base 
    ld    A, L          ; 1:4       1355 *   256*L = 256x 
    add  HL, HL         ; 1:11      1355 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1355 *   0  *2 = 4x 
    add   A, L          ; 1:4       1355 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1355 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1355 *      +1 = 9x 
    add  HL, HL         ; 1:11      1355 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1355 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1355 *      +1 = 37x 
    add  HL, HL         ; 1:11      1355 *   1  *2 = 74x
    add  HL, BC         ; 1:11      1355 *      +1 = 75x 
    add   A, H          ; 1:4       1355 *
    ld    H, A          ; 1:4       1355 *     [1355x] = 75x + 1280x  
                        ;[15:123]   1357 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0100_1101)
    ld    B, H          ; 1:4       1357 *
    ld    C, L          ; 1:4       1357 *   1       1x = base 
    ld    A, L          ; 1:4       1357 *   256*L = 256x 
    add  HL, HL         ; 1:11      1357 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1357 *   0  *2 = 4x 
    add   A, L          ; 1:4       1357 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1357 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1357 *      +1 = 9x 
    add  HL, HL         ; 1:11      1357 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1357 *      +1 = 19x 
    add  HL, HL         ; 1:11      1357 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1357 *   1  *2 = 76x
    add  HL, BC         ; 1:11      1357 *      +1 = 77x 
    add   A, H          ; 1:4       1357 *
    ld    H, A          ; 1:4       1357 *     [1357x] = 77x + 1280x  
                        ;[16:134]   1359 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0100_1111)
    ld    B, H          ; 1:4       1359 *
    ld    C, L          ; 1:4       1359 *   1       1x = base 
    ld    A, L          ; 1:4       1359 *   256*L = 256x 
    add  HL, HL         ; 1:11      1359 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1359 *   0  *2 = 4x 
    add   A, L          ; 1:4       1359 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1359 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1359 *      +1 = 9x 
    add  HL, HL         ; 1:11      1359 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1359 *      +1 = 19x 
    add  HL, HL         ; 1:11      1359 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1359 *      +1 = 39x 
    add  HL, HL         ; 1:11      1359 *   1  *2 = 78x
    add  HL, BC         ; 1:11      1359 *      +1 = 79x 
    add   A, H          ; 1:4       1359 *
    ld    H, A          ; 1:4       1359 *     [1359x] = 79x + 1280x  
                        ;[13:108]   1361 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0101_0001)
    ld    B, H          ; 1:4       1361 *
    ld    C, L          ; 1:4       1361 *   1       1x = base 
    add  HL, HL         ; 1:11      1361 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1361 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1361 *      +1 = 5x 
    ld    A, L          ; 1:4       1361 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1361 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1361 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1361 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1361 *   1  *2 = 80x
    add  HL, BC         ; 1:11      1361 *      +1 = 81x 
    add   A, H          ; 1:4       1361 *
    ld    H, A          ; 1:4       1361 *     [1361x] = 81x + 1280x 

                        ;[14:119]   1363 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0101_0011)
    ld    B, H          ; 1:4       1363 *
    ld    C, L          ; 1:4       1363 *   1       1x = base 
    add  HL, HL         ; 1:11      1363 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1363 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1363 *      +1 = 5x 
    ld    A, L          ; 1:4       1363 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1363 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1363 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1363 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1363 *      +1 = 41x 
    add  HL, HL         ; 1:11      1363 *   1  *2 = 82x
    add  HL, BC         ; 1:11      1363 *      +1 = 83x 
    add   A, H          ; 1:4       1363 *
    ld    H, A          ; 1:4       1363 *     [1363x] = 83x + 1280x  
                        ;[14:119]   1365 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0101_0101)
    ld    B, H          ; 1:4       1365 *
    ld    C, L          ; 1:4       1365 *   1       1x = base 
    add  HL, HL         ; 1:11      1365 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1365 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1365 *      +1 = 5x 
    ld    A, L          ; 1:4       1365 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1365 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1365 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1365 *      +1 = 21x 
    add  HL, HL         ; 1:11      1365 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1365 *   1  *2 = 84x
    add  HL, BC         ; 1:11      1365 *      +1 = 85x 
    add   A, H          ; 1:4       1365 *
    ld    H, A          ; 1:4       1365 *     [1365x] = 85x + 1280x  
                        ;[15:130]   1367 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0101_0111)
    ld    B, H          ; 1:4       1367 *
    ld    C, L          ; 1:4       1367 *   1       1x = base 
    add  HL, HL         ; 1:11      1367 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1367 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1367 *      +1 = 5x 
    ld    A, L          ; 1:4       1367 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1367 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1367 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1367 *      +1 = 21x 
    add  HL, HL         ; 1:11      1367 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1367 *      +1 = 43x 
    add  HL, HL         ; 1:11      1367 *   1  *2 = 86x
    add  HL, BC         ; 1:11      1367 *      +1 = 87x 
    add   A, H          ; 1:4       1367 *
    ld    H, A          ; 1:4       1367 *     [1367x] = 87x + 1280x  
                        ;[14:119]   1369 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0101_1001)
    ld    B, H          ; 1:4       1369 *
    ld    C, L          ; 1:4       1369 *   1       1x = base 
    add  HL, HL         ; 1:11      1369 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1369 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1369 *      +1 = 5x 
    ld    A, L          ; 1:4       1369 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1369 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1369 *      +1 = 11x 
    add  HL, HL         ; 1:11      1369 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1369 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1369 *   1  *2 = 88x
    add  HL, BC         ; 1:11      1369 *      +1 = 89x 
    add   A, H          ; 1:4       1369 *
    ld    H, A          ; 1:4       1369 *     [1369x] = 89x + 1280x  
                        ;[15:130]   1371 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0101_1011)
    ld    B, H          ; 1:4       1371 *
    ld    C, L          ; 1:4       1371 *   1       1x = base 
    add  HL, HL         ; 1:11      1371 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1371 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1371 *      +1 = 5x 
    ld    A, L          ; 1:4       1371 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1371 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1371 *      +1 = 11x 
    add  HL, HL         ; 1:11      1371 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1371 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1371 *      +1 = 45x 
    add  HL, HL         ; 1:11      1371 *   1  *2 = 90x
    add  HL, BC         ; 1:11      1371 *      +1 = 91x 
    add   A, H          ; 1:4       1371 *
    ld    H, A          ; 1:4       1371 *     [1371x] = 91x + 1280x  
                        ;[15:130]   1373 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0101_1101)
    ld    B, H          ; 1:4       1373 *
    ld    C, L          ; 1:4       1373 *   1       1x = base 
    add  HL, HL         ; 1:11      1373 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1373 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1373 *      +1 = 5x 
    ld    A, L          ; 1:4       1373 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1373 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1373 *      +1 = 11x 
    add  HL, HL         ; 1:11      1373 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1373 *      +1 = 23x 
    add  HL, HL         ; 1:11      1373 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1373 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1373 *      +1 = 93x 
    add   A, H          ; 1:4       1373 *
    ld    H, A          ; 1:4       1373 *     [1373x] = 93x + 1280x  
                        ;[16:141]   1375 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_0101_1111)
    ld    B, H          ; 1:4       1375 *
    ld    C, L          ; 1:4       1375 *   1       1x = base 
    add  HL, HL         ; 1:11      1375 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1375 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1375 *      +1 = 5x 
    ld    A, L          ; 1:4       1375 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1375 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1375 *      +1 = 11x 
    add  HL, HL         ; 1:11      1375 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1375 *      +1 = 23x 
    add  HL, HL         ; 1:11      1375 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1375 *      +1 = 47x 
    add  HL, HL         ; 1:11      1375 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1375 *      +1 = 95x 
    add   A, H          ; 1:4       1375 *
    ld    H, A          ; 1:4       1375 *     [1375x] = 95x + 1280x  
                        ;[16:120]   1377 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0110_0001)
    ld    B, H          ; 1:4       1377 *
    ld    C, L          ; 1:4       1377 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1377 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1377 *      +1 = 3x 
    add  HL, HL         ; 1:11      1377 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1377 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1377 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1377 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1377 *   1  *2 = 96x
    add  HL, BC         ; 1:11      1377 *      +1 = 97x  
    ld    A, C          ; 1:4       1377 *   1       1x 
    add   A, A          ; 1:4       1377 *   0  *2 = 2x 
    add   A, A          ; 1:4       1377 *   1  *2 = 4x
    add   A, C          ; 1:4       1377 *      +1 = 5x 
    add   A, H          ; 1:4       1377 *
    ld    H, A          ; 1:4       1377 *     [1377x] = 256 * 5x + 97x  
                        ;[17:131]   1379 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0110_0011)
    ld    B, H          ; 1:4       1379 *
    ld    C, L          ; 1:4       1379 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1379 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1379 *      +1 = 3x 
    add  HL, HL         ; 1:11      1379 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1379 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1379 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1379 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1379 *      +1 = 49x 
    add  HL, HL         ; 1:11      1379 *   1  *2 = 98x
    add  HL, BC         ; 1:11      1379 *      +1 = 99x  
    ld    A, C          ; 1:4       1379 *   1       1x 
    add   A, A          ; 1:4       1379 *   0  *2 = 2x 
    add   A, A          ; 1:4       1379 *   1  *2 = 4x
    add   A, C          ; 1:4       1379 *      +1 = 5x 
    add   A, H          ; 1:4       1379 *
    ld    H, A          ; 1:4       1379 *     [1379x] = 256 * 5x + 99x 

                        ;[17:131]   1381 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0110_0101)
    ld    B, H          ; 1:4       1381 *
    ld    C, L          ; 1:4       1381 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1381 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1381 *      +1 = 3x 
    add  HL, HL         ; 1:11      1381 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1381 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1381 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1381 *      +1 = 25x 
    add  HL, HL         ; 1:11      1381 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1381 *   1  *2 = 100x
    add  HL, BC         ; 1:11      1381 *      +1 = 101x  
    ld    A, C          ; 1:4       1381 *   1       1x 
    add   A, A          ; 1:4       1381 *   0  *2 = 2x 
    add   A, A          ; 1:4       1381 *   1  *2 = 4x
    add   A, C          ; 1:4       1381 *      +1 = 5x 
    add   A, H          ; 1:4       1381 *
    ld    H, A          ; 1:4       1381 *     [1381x] = 256 * 5x + 101x  
                        ;[18:142]   1383 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0110_0111)
    ld    B, H          ; 1:4       1383 *
    ld    C, L          ; 1:4       1383 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1383 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1383 *      +1 = 3x 
    add  HL, HL         ; 1:11      1383 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1383 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1383 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1383 *      +1 = 25x 
    add  HL, HL         ; 1:11      1383 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1383 *      +1 = 51x 
    add  HL, HL         ; 1:11      1383 *   1  *2 = 102x
    add  HL, BC         ; 1:11      1383 *      +1 = 103x  
    ld    A, C          ; 1:4       1383 *   1       1x 
    add   A, A          ; 1:4       1383 *   0  *2 = 2x 
    add   A, A          ; 1:4       1383 *   1  *2 = 4x
    add   A, C          ; 1:4       1383 *      +1 = 5x 
    add   A, H          ; 1:4       1383 *
    ld    H, A          ; 1:4       1383 *     [1383x] = 256 * 5x + 103x  
                        ;[17:131]   1385 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0110_1001)
    ld    B, H          ; 1:4       1385 *
    ld    C, L          ; 1:4       1385 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1385 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1385 *      +1 = 3x 
    add  HL, HL         ; 1:11      1385 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1385 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1385 *      +1 = 13x 
    add  HL, HL         ; 1:11      1385 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1385 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      1385 *   1  *2 = 104x
    add  HL, BC         ; 1:11      1385 *      +1 = 105x  
    ld    A, C          ; 1:4       1385 *   1       1x 
    add   A, A          ; 1:4       1385 *   0  *2 = 2x 
    add   A, A          ; 1:4       1385 *   1  *2 = 4x
    add   A, C          ; 1:4       1385 *      +1 = 5x 
    add   A, H          ; 1:4       1385 *
    ld    H, A          ; 1:4       1385 *     [1385x] = 256 * 5x + 105x  
                        ;[18:142]   1387 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0110_1011)
    ld    B, H          ; 1:4       1387 *
    ld    C, L          ; 1:4       1387 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1387 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1387 *      +1 = 3x 
    add  HL, HL         ; 1:11      1387 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1387 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1387 *      +1 = 13x 
    add  HL, HL         ; 1:11      1387 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1387 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1387 *      +1 = 53x 
    add  HL, HL         ; 1:11      1387 *   1  *2 = 106x
    add  HL, BC         ; 1:11      1387 *      +1 = 107x  
    ld    A, C          ; 1:4       1387 *   1       1x 
    add   A, A          ; 1:4       1387 *   0  *2 = 2x 
    add   A, A          ; 1:4       1387 *   1  *2 = 4x
    add   A, C          ; 1:4       1387 *      +1 = 5x 
    add   A, H          ; 1:4       1387 *
    ld    H, A          ; 1:4       1387 *     [1387x] = 256 * 5x + 107x  
                        ;[18:142]   1389 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0110_1101)
    ld    B, H          ; 1:4       1389 *
    ld    C, L          ; 1:4       1389 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1389 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1389 *      +1 = 3x 
    add  HL, HL         ; 1:11      1389 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1389 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1389 *      +1 = 13x 
    add  HL, HL         ; 1:11      1389 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1389 *      +1 = 27x 
    add  HL, HL         ; 1:11      1389 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      1389 *   1  *2 = 108x
    add  HL, BC         ; 1:11      1389 *      +1 = 109x  
    ld    A, C          ; 1:4       1389 *   1       1x 
    add   A, A          ; 1:4       1389 *   0  *2 = 2x 
    add   A, A          ; 1:4       1389 *   1  *2 = 4x
    add   A, C          ; 1:4       1389 *      +1 = 5x 
    add   A, H          ; 1:4       1389 *
    ld    H, A          ; 1:4       1389 *     [1389x] = 256 * 5x + 109x  
                        ;[19:153]   1391 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0110_1111)
    ld    B, H          ; 1:4       1391 *
    ld    C, L          ; 1:4       1391 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1391 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1391 *      +1 = 3x 
    add  HL, HL         ; 1:11      1391 *   0  *2 = 6x 
    add  HL, HL         ; 1:11      1391 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1391 *      +1 = 13x 
    add  HL, HL         ; 1:11      1391 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1391 *      +1 = 27x 
    add  HL, HL         ; 1:11      1391 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1391 *      +1 = 55x 
    add  HL, HL         ; 1:11      1391 *   1  *2 = 110x
    add  HL, BC         ; 1:11      1391 *      +1 = 111x  
    ld    A, C          ; 1:4       1391 *   1       1x 
    add   A, A          ; 1:4       1391 *   0  *2 = 2x 
    add   A, A          ; 1:4       1391 *   1  *2 = 4x
    add   A, C          ; 1:4       1391 *      +1 = 5x 
    add   A, H          ; 1:4       1391 *
    ld    H, A          ; 1:4       1391 *     [1391x] = 256 * 5x + 111x  
                        ;[17:131]   1393 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0111_0001)
    ld    B, H          ; 1:4       1393 *
    ld    C, L          ; 1:4       1393 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1393 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1393 *      +1 = 3x 
    add  HL, HL         ; 1:11      1393 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1393 *      +1 = 7x 
    add  HL, HL         ; 1:11      1393 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1393 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1393 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      1393 *   1  *2 = 112x
    add  HL, BC         ; 1:11      1393 *      +1 = 113x  
    ld    A, C          ; 1:4       1393 *   1       1x 
    add   A, A          ; 1:4       1393 *   0  *2 = 2x 
    add   A, A          ; 1:4       1393 *   1  *2 = 4x
    add   A, C          ; 1:4       1393 *      +1 = 5x 
    add   A, H          ; 1:4       1393 *
    ld    H, A          ; 1:4       1393 *     [1393x] = 256 * 5x + 113x  
                        ;[18:142]   1395 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0111_0011)
    ld    B, H          ; 1:4       1395 *
    ld    C, L          ; 1:4       1395 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1395 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1395 *      +1 = 3x 
    add  HL, HL         ; 1:11      1395 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1395 *      +1 = 7x 
    add  HL, HL         ; 1:11      1395 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1395 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1395 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1395 *      +1 = 57x 
    add  HL, HL         ; 1:11      1395 *   1  *2 = 114x
    add  HL, BC         ; 1:11      1395 *      +1 = 115x  
    ld    A, C          ; 1:4       1395 *   1       1x 
    add   A, A          ; 1:4       1395 *   0  *2 = 2x 
    add   A, A          ; 1:4       1395 *   1  *2 = 4x
    add   A, C          ; 1:4       1395 *      +1 = 5x 
    add   A, H          ; 1:4       1395 *
    ld    H, A          ; 1:4       1395 *     [1395x] = 256 * 5x + 115x  
                        ;[18:142]   1397 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0111_0101)
    ld    B, H          ; 1:4       1397 *
    ld    C, L          ; 1:4       1397 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1397 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1397 *      +1 = 3x 
    add  HL, HL         ; 1:11      1397 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1397 *      +1 = 7x 
    add  HL, HL         ; 1:11      1397 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1397 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1397 *      +1 = 29x 
    add  HL, HL         ; 1:11      1397 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1397 *   1  *2 = 116x
    add  HL, BC         ; 1:11      1397 *      +1 = 117x  
    ld    A, C          ; 1:4       1397 *   1       1x 
    add   A, A          ; 1:4       1397 *   0  *2 = 2x 
    add   A, A          ; 1:4       1397 *   1  *2 = 4x
    add   A, C          ; 1:4       1397 *      +1 = 5x 
    add   A, H          ; 1:4       1397 *
    ld    H, A          ; 1:4       1397 *     [1397x] = 256 * 5x + 117x 

                        ;[19:153]   1399 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0111_0111)
    ld    B, H          ; 1:4       1399 *
    ld    C, L          ; 1:4       1399 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1399 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1399 *      +1 = 3x 
    add  HL, HL         ; 1:11      1399 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1399 *      +1 = 7x 
    add  HL, HL         ; 1:11      1399 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1399 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1399 *      +1 = 29x 
    add  HL, HL         ; 1:11      1399 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1399 *      +1 = 59x 
    add  HL, HL         ; 1:11      1399 *   1  *2 = 118x
    add  HL, BC         ; 1:11      1399 *      +1 = 119x  
    ld    A, C          ; 1:4       1399 *   1       1x 
    add   A, A          ; 1:4       1399 *   0  *2 = 2x 
    add   A, A          ; 1:4       1399 *   1  *2 = 4x
    add   A, C          ; 1:4       1399 *      +1 = 5x 
    add   A, H          ; 1:4       1399 *
    ld    H, A          ; 1:4       1399 *     [1399x] = 256 * 5x + 119x  
                        ;[18:142]   1401 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0111_1001)
    ld    B, H          ; 1:4       1401 *
    ld    C, L          ; 1:4       1401 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1401 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1401 *      +1 = 3x 
    add  HL, HL         ; 1:11      1401 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1401 *      +1 = 7x 
    add  HL, HL         ; 1:11      1401 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1401 *      +1 = 15x 
    add  HL, HL         ; 1:11      1401 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1401 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1401 *   1  *2 = 120x
    add  HL, BC         ; 1:11      1401 *      +1 = 121x  
    ld    A, C          ; 1:4       1401 *   1       1x 
    add   A, A          ; 1:4       1401 *   0  *2 = 2x 
    add   A, A          ; 1:4       1401 *   1  *2 = 4x
    add   A, C          ; 1:4       1401 *      +1 = 5x 
    add   A, H          ; 1:4       1401 *
    ld    H, A          ; 1:4       1401 *     [1401x] = 256 * 5x + 121x  
                        ;[19:153]   1403 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0111_1011)
    ld    B, H          ; 1:4       1403 *
    ld    C, L          ; 1:4       1403 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1403 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1403 *      +1 = 3x 
    add  HL, HL         ; 1:11      1403 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1403 *      +1 = 7x 
    add  HL, HL         ; 1:11      1403 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1403 *      +1 = 15x 
    add  HL, HL         ; 1:11      1403 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1403 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1403 *      +1 = 61x 
    add  HL, HL         ; 1:11      1403 *   1  *2 = 122x
    add  HL, BC         ; 1:11      1403 *      +1 = 123x  
    ld    A, C          ; 1:4       1403 *   1       1x 
    add   A, A          ; 1:4       1403 *   0  *2 = 2x 
    add   A, A          ; 1:4       1403 *   1  *2 = 4x
    add   A, C          ; 1:4       1403 *      +1 = 5x 
    add   A, H          ; 1:4       1403 *
    ld    H, A          ; 1:4       1403 *     [1403x] = 256 * 5x + 123x  
                        ;[19:153]   1405 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0111_1101)
    ld    B, H          ; 1:4       1405 *
    ld    C, L          ; 1:4       1405 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1405 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1405 *      +1 = 3x 
    add  HL, HL         ; 1:11      1405 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1405 *      +1 = 7x 
    add  HL, HL         ; 1:11      1405 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1405 *      +1 = 15x 
    add  HL, HL         ; 1:11      1405 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1405 *      +1 = 31x 
    add  HL, HL         ; 1:11      1405 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1405 *   1  *2 = 124x
    add  HL, BC         ; 1:11      1405 *      +1 = 125x  
    ld    A, C          ; 1:4       1405 *   1       1x 
    add   A, A          ; 1:4       1405 *   0  *2 = 2x 
    add   A, A          ; 1:4       1405 *   1  *2 = 4x
    add   A, C          ; 1:4       1405 *      +1 = 5x 
    add   A, H          ; 1:4       1405 *
    ld    H, A          ; 1:4       1405 *     [1405x] = 256 * 5x + 125x  
                        ;[20:164]   1407 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0101_0111_1111)
    ld    B, H          ; 1:4       1407 *
    ld    C, L          ; 1:4       1407 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1407 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1407 *      +1 = 3x 
    add  HL, HL         ; 1:11      1407 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1407 *      +1 = 7x 
    add  HL, HL         ; 1:11      1407 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1407 *      +1 = 15x 
    add  HL, HL         ; 1:11      1407 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1407 *      +1 = 31x 
    add  HL, HL         ; 1:11      1407 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1407 *      +1 = 63x 
    add  HL, HL         ; 1:11      1407 *   1  *2 = 126x
    add  HL, BC         ; 1:11      1407 *      +1 = 127x  
    ld    A, C          ; 1:4       1407 *   1       1x 
    add   A, A          ; 1:4       1407 *   0  *2 = 2x 
    add   A, A          ; 1:4       1407 *   1  *2 = 4x
    add   A, C          ; 1:4       1407 *      +1 = 5x 
    add   A, H          ; 1:4       1407 *
    ld    H, A          ; 1:4       1407 *     [1407x] = 256 * 5x + 127x  
                        ;[14:112]   1409 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0101_1000_0001)  
    ld    A, L          ; 1:4       1409 *   256x 
    ld    B, H          ; 1:4       1409 *
    ld    C, L          ; 1:4       1409 *   [1x] 
    add  HL, HL         ; 1:11      1409 *   2x 
    add  HL, HL         ; 1:11      1409 *   4x 
    add   A, L          ; 1:4       1409 *   1280x 
    add  HL, HL         ; 1:11      1409 *   8x 
    add  HL, HL         ; 1:11      1409 *   16x 
    add  HL, HL         ; 1:11      1409 *   32x 
    add  HL, HL         ; 1:11      1409 *   64x 
    add  HL, HL         ; 1:11      1409 *   128x 
    add   A, B          ; 1:4       1409 *
    ld    B, A          ; 1:4       1409 *   [1281x] 
    add  HL, BC         ; 1:11      1409 *   [1409x] = 128x + 1281x   
                        ;[15:123]   1411 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1000_0011)
    ld    B, H          ; 1:4       1411 *
    ld    C, L          ; 1:4       1411 *   1       1x = base 
    ld    A, L          ; 1:4       1411 *   256*L = 256x 
    add  HL, HL         ; 1:11      1411 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1411 *   0  *2 = 4x 
    add   A, L          ; 1:4       1411 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1411 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1411 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1411 *   0  *2 = 32x 
    add  HL, HL         ; 1:11      1411 *   1  *2 = 64x
    add  HL, BC         ; 1:11      1411 *      +1 = 65x 
    add  HL, HL         ; 1:11      1411 *   1  *2 = 130x
    add  HL, BC         ; 1:11      1411 *      +1 = 131x 
    add   A, H          ; 1:4       1411 *
    ld    H, A          ; 1:4       1411 *     [1411x] = 131x + 1280x  
                        ;[15:123]   1413 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1000_0101)
    ld    B, H          ; 1:4       1413 *
    ld    C, L          ; 1:4       1413 *   1       1x = base 
    ld    A, L          ; 1:4       1413 *   256*L = 256x 
    add  HL, HL         ; 1:11      1413 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1413 *   0  *2 = 4x 
    add   A, L          ; 1:4       1413 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1413 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1413 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1413 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1413 *      +1 = 33x 
    add  HL, HL         ; 1:11      1413 *   0  *2 = 66x 
    add  HL, HL         ; 1:11      1413 *   1  *2 = 132x
    add  HL, BC         ; 1:11      1413 *      +1 = 133x 
    add   A, H          ; 1:4       1413 *
    ld    H, A          ; 1:4       1413 *     [1413x] = 133x + 1280x  
                        ;[16:134]   1415 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1000_0111)
    ld    B, H          ; 1:4       1415 *
    ld    C, L          ; 1:4       1415 *   1       1x = base 
    ld    A, L          ; 1:4       1415 *   256*L = 256x 
    add  HL, HL         ; 1:11      1415 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1415 *   0  *2 = 4x 
    add   A, L          ; 1:4       1415 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1415 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1415 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1415 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1415 *      +1 = 33x 
    add  HL, HL         ; 1:11      1415 *   1  *2 = 66x
    add  HL, BC         ; 1:11      1415 *      +1 = 67x 
    add  HL, HL         ; 1:11      1415 *   1  *2 = 134x
    add  HL, BC         ; 1:11      1415 *      +1 = 135x 
    add   A, H          ; 1:4       1415 *
    ld    H, A          ; 1:4       1415 *     [1415x] = 135x + 1280x 

                        ;[15:123]   1417 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1000_1001)
    ld    B, H          ; 1:4       1417 *
    ld    C, L          ; 1:4       1417 *   1       1x = base 
    ld    A, L          ; 1:4       1417 *   256*L = 256x 
    add  HL, HL         ; 1:11      1417 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1417 *   0  *2 = 4x 
    add   A, L          ; 1:4       1417 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1417 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1417 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1417 *      +1 = 17x 
    add  HL, HL         ; 1:11      1417 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1417 *   0  *2 = 68x 
    add  HL, HL         ; 1:11      1417 *   1  *2 = 136x
    add  HL, BC         ; 1:11      1417 *      +1 = 137x 
    add   A, H          ; 1:4       1417 *
    ld    H, A          ; 1:4       1417 *     [1417x] = 137x + 1280x  
                        ;[16:134]   1419 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1000_1011)
    ld    B, H          ; 1:4       1419 *
    ld    C, L          ; 1:4       1419 *   1       1x = base 
    ld    A, L          ; 1:4       1419 *   256*L = 256x 
    add  HL, HL         ; 1:11      1419 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1419 *   0  *2 = 4x 
    add   A, L          ; 1:4       1419 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1419 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1419 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1419 *      +1 = 17x 
    add  HL, HL         ; 1:11      1419 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1419 *   1  *2 = 68x
    add  HL, BC         ; 1:11      1419 *      +1 = 69x 
    add  HL, HL         ; 1:11      1419 *   1  *2 = 138x
    add  HL, BC         ; 1:11      1419 *      +1 = 139x 
    add   A, H          ; 1:4       1419 *
    ld    H, A          ; 1:4       1419 *     [1419x] = 139x + 1280x  
                        ;[16:134]   1421 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1000_1101)
    ld    B, H          ; 1:4       1421 *
    ld    C, L          ; 1:4       1421 *   1       1x = base 
    ld    A, L          ; 1:4       1421 *   256*L = 256x 
    add  HL, HL         ; 1:11      1421 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1421 *   0  *2 = 4x 
    add   A, L          ; 1:4       1421 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1421 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1421 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1421 *      +1 = 17x 
    add  HL, HL         ; 1:11      1421 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1421 *      +1 = 35x 
    add  HL, HL         ; 1:11      1421 *   0  *2 = 70x 
    add  HL, HL         ; 1:11      1421 *   1  *2 = 140x
    add  HL, BC         ; 1:11      1421 *      +1 = 141x 
    add   A, H          ; 1:4       1421 *
    ld    H, A          ; 1:4       1421 *     [1421x] = 141x + 1280x  
                        ;[17:145]   1423 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1000_1111)
    ld    B, H          ; 1:4       1423 *
    ld    C, L          ; 1:4       1423 *   1       1x = base 
    ld    A, L          ; 1:4       1423 *   256*L = 256x 
    add  HL, HL         ; 1:11      1423 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1423 *   0  *2 = 4x 
    add   A, L          ; 1:4       1423 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1423 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1423 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1423 *      +1 = 17x 
    add  HL, HL         ; 1:11      1423 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1423 *      +1 = 35x 
    add  HL, HL         ; 1:11      1423 *   1  *2 = 70x
    add  HL, BC         ; 1:11      1423 *      +1 = 71x 
    add  HL, HL         ; 1:11      1423 *   1  *2 = 142x
    add  HL, BC         ; 1:11      1423 *      +1 = 143x 
    add   A, H          ; 1:4       1423 *
    ld    H, A          ; 1:4       1423 *     [1423x] = 143x + 1280x  
                        ;[15:123]   1425 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1001_0001)
    ld    B, H          ; 1:4       1425 *
    ld    C, L          ; 1:4       1425 *   1       1x = base 
    ld    A, L          ; 1:4       1425 *   256*L = 256x 
    add  HL, HL         ; 1:11      1425 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1425 *   0  *2 = 4x 
    add   A, L          ; 1:4       1425 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1425 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1425 *      +1 = 9x 
    add  HL, HL         ; 1:11      1425 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1425 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1425 *   0  *2 = 72x 
    add  HL, HL         ; 1:11      1425 *   1  *2 = 144x
    add  HL, BC         ; 1:11      1425 *      +1 = 145x 
    add   A, H          ; 1:4       1425 *
    ld    H, A          ; 1:4       1425 *     [1425x] = 145x + 1280x  
                        ;[16:134]   1427 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1001_0011)
    ld    B, H          ; 1:4       1427 *
    ld    C, L          ; 1:4       1427 *   1       1x = base 
    ld    A, L          ; 1:4       1427 *   256*L = 256x 
    add  HL, HL         ; 1:11      1427 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1427 *   0  *2 = 4x 
    add   A, L          ; 1:4       1427 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1427 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1427 *      +1 = 9x 
    add  HL, HL         ; 1:11      1427 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1427 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1427 *   1  *2 = 72x
    add  HL, BC         ; 1:11      1427 *      +1 = 73x 
    add  HL, HL         ; 1:11      1427 *   1  *2 = 146x
    add  HL, BC         ; 1:11      1427 *      +1 = 147x 
    add   A, H          ; 1:4       1427 *
    ld    H, A          ; 1:4       1427 *     [1427x] = 147x + 1280x  
                        ;[16:134]   1429 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1001_0101)
    ld    B, H          ; 1:4       1429 *
    ld    C, L          ; 1:4       1429 *   1       1x = base 
    ld    A, L          ; 1:4       1429 *   256*L = 256x 
    add  HL, HL         ; 1:11      1429 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1429 *   0  *2 = 4x 
    add   A, L          ; 1:4       1429 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1429 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1429 *      +1 = 9x 
    add  HL, HL         ; 1:11      1429 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1429 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1429 *      +1 = 37x 
    add  HL, HL         ; 1:11      1429 *   0  *2 = 74x 
    add  HL, HL         ; 1:11      1429 *   1  *2 = 148x
    add  HL, BC         ; 1:11      1429 *      +1 = 149x 
    add   A, H          ; 1:4       1429 *
    ld    H, A          ; 1:4       1429 *     [1429x] = 149x + 1280x  
                        ;[17:145]   1431 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1001_0111)
    ld    B, H          ; 1:4       1431 *
    ld    C, L          ; 1:4       1431 *   1       1x = base 
    ld    A, L          ; 1:4       1431 *   256*L = 256x 
    add  HL, HL         ; 1:11      1431 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1431 *   0  *2 = 4x 
    add   A, L          ; 1:4       1431 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1431 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1431 *      +1 = 9x 
    add  HL, HL         ; 1:11      1431 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1431 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1431 *      +1 = 37x 
    add  HL, HL         ; 1:11      1431 *   1  *2 = 74x
    add  HL, BC         ; 1:11      1431 *      +1 = 75x 
    add  HL, HL         ; 1:11      1431 *   1  *2 = 150x
    add  HL, BC         ; 1:11      1431 *      +1 = 151x 
    add   A, H          ; 1:4       1431 *
    ld    H, A          ; 1:4       1431 *     [1431x] = 151x + 1280x  
                        ;[16:134]   1433 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1001_1001)
    ld    B, H          ; 1:4       1433 *
    ld    C, L          ; 1:4       1433 *   1       1x = base 
    ld    A, L          ; 1:4       1433 *   256*L = 256x 
    add  HL, HL         ; 1:11      1433 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1433 *   0  *2 = 4x 
    add   A, L          ; 1:4       1433 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1433 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1433 *      +1 = 9x 
    add  HL, HL         ; 1:11      1433 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1433 *      +1 = 19x 
    add  HL, HL         ; 1:11      1433 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1433 *   0  *2 = 76x 
    add  HL, HL         ; 1:11      1433 *   1  *2 = 152x
    add  HL, BC         ; 1:11      1433 *      +1 = 153x 
    add   A, H          ; 1:4       1433 *
    ld    H, A          ; 1:4       1433 *     [1433x] = 153x + 1280x 

                        ;[17:145]   1435 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1001_1011)
    ld    B, H          ; 1:4       1435 *
    ld    C, L          ; 1:4       1435 *   1       1x = base 
    ld    A, L          ; 1:4       1435 *   256*L = 256x 
    add  HL, HL         ; 1:11      1435 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1435 *   0  *2 = 4x 
    add   A, L          ; 1:4       1435 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1435 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1435 *      +1 = 9x 
    add  HL, HL         ; 1:11      1435 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1435 *      +1 = 19x 
    add  HL, HL         ; 1:11      1435 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1435 *   1  *2 = 76x
    add  HL, BC         ; 1:11      1435 *      +1 = 77x 
    add  HL, HL         ; 1:11      1435 *   1  *2 = 154x
    add  HL, BC         ; 1:11      1435 *      +1 = 155x 
    add   A, H          ; 1:4       1435 *
    ld    H, A          ; 1:4       1435 *     [1435x] = 155x + 1280x  
                        ;[17:145]   1437 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1001_1101)
    ld    B, H          ; 1:4       1437 *
    ld    C, L          ; 1:4       1437 *   1       1x = base 
    ld    A, L          ; 1:4       1437 *   256*L = 256x 
    add  HL, HL         ; 1:11      1437 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1437 *   0  *2 = 4x 
    add   A, L          ; 1:4       1437 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1437 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1437 *      +1 = 9x 
    add  HL, HL         ; 1:11      1437 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1437 *      +1 = 19x 
    add  HL, HL         ; 1:11      1437 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1437 *      +1 = 39x 
    add  HL, HL         ; 1:11      1437 *   0  *2 = 78x 
    add  HL, HL         ; 1:11      1437 *   1  *2 = 156x
    add  HL, BC         ; 1:11      1437 *      +1 = 157x 
    add   A, H          ; 1:4       1437 *
    ld    H, A          ; 1:4       1437 *     [1437x] = 157x + 1280x  
                        ;[18:156]   1439 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1001_1111)
    ld    B, H          ; 1:4       1439 *
    ld    C, L          ; 1:4       1439 *   1       1x = base 
    ld    A, L          ; 1:4       1439 *   256*L = 256x 
    add  HL, HL         ; 1:11      1439 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1439 *   0  *2 = 4x 
    add   A, L          ; 1:4       1439 *  +256*L = 1280x 
    add  HL, HL         ; 1:11      1439 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1439 *      +1 = 9x 
    add  HL, HL         ; 1:11      1439 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1439 *      +1 = 19x 
    add  HL, HL         ; 1:11      1439 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1439 *      +1 = 39x 
    add  HL, HL         ; 1:11      1439 *   1  *2 = 78x
    add  HL, BC         ; 1:11      1439 *      +1 = 79x 
    add  HL, HL         ; 1:11      1439 *   1  *2 = 158x
    add  HL, BC         ; 1:11      1439 *      +1 = 159x 
    add   A, H          ; 1:4       1439 *
    ld    H, A          ; 1:4       1439 *     [1439x] = 159x + 1280x  
                        ;[14:119]   1441 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1010_0001)
    ld    B, H          ; 1:4       1441 *
    ld    C, L          ; 1:4       1441 *   1       1x = base 
    add  HL, HL         ; 1:11      1441 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1441 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1441 *      +1 = 5x 
    ld    A, L          ; 1:4       1441 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1441 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1441 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1441 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1441 *   0  *2 = 80x 
    add  HL, HL         ; 1:11      1441 *   1  *2 = 160x
    add  HL, BC         ; 1:11      1441 *      +1 = 161x 
    add   A, H          ; 1:4       1441 *
    ld    H, A          ; 1:4       1441 *     [1441x] = 161x + 1280x  
                        ;[15:130]   1443 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1010_0011)
    ld    B, H          ; 1:4       1443 *
    ld    C, L          ; 1:4       1443 *   1       1x = base 
    add  HL, HL         ; 1:11      1443 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1443 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1443 *      +1 = 5x 
    ld    A, L          ; 1:4       1443 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1443 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1443 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1443 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1443 *   1  *2 = 80x
    add  HL, BC         ; 1:11      1443 *      +1 = 81x 
    add  HL, HL         ; 1:11      1443 *   1  *2 = 162x
    add  HL, BC         ; 1:11      1443 *      +1 = 163x 
    add   A, H          ; 1:4       1443 *
    ld    H, A          ; 1:4       1443 *     [1443x] = 163x + 1280x  
                        ;[15:130]   1445 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1010_0101)
    ld    B, H          ; 1:4       1445 *
    ld    C, L          ; 1:4       1445 *   1       1x = base 
    add  HL, HL         ; 1:11      1445 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1445 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1445 *      +1 = 5x 
    ld    A, L          ; 1:4       1445 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1445 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1445 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1445 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1445 *      +1 = 41x 
    add  HL, HL         ; 1:11      1445 *   0  *2 = 82x 
    add  HL, HL         ; 1:11      1445 *   1  *2 = 164x
    add  HL, BC         ; 1:11      1445 *      +1 = 165x 
    add   A, H          ; 1:4       1445 *
    ld    H, A          ; 1:4       1445 *     [1445x] = 165x + 1280x  
                        ;[16:141]   1447 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1010_0111)
    ld    B, H          ; 1:4       1447 *
    ld    C, L          ; 1:4       1447 *   1       1x = base 
    add  HL, HL         ; 1:11      1447 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1447 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1447 *      +1 = 5x 
    ld    A, L          ; 1:4       1447 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1447 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1447 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1447 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1447 *      +1 = 41x 
    add  HL, HL         ; 1:11      1447 *   1  *2 = 82x
    add  HL, BC         ; 1:11      1447 *      +1 = 83x 
    add  HL, HL         ; 1:11      1447 *   1  *2 = 166x
    add  HL, BC         ; 1:11      1447 *      +1 = 167x 
    add   A, H          ; 1:4       1447 *
    ld    H, A          ; 1:4       1447 *     [1447x] = 167x + 1280x  
                        ;[15:130]   1449 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1010_1001)
    ld    B, H          ; 1:4       1449 *
    ld    C, L          ; 1:4       1449 *   1       1x = base 
    add  HL, HL         ; 1:11      1449 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1449 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1449 *      +1 = 5x 
    ld    A, L          ; 1:4       1449 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1449 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1449 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1449 *      +1 = 21x 
    add  HL, HL         ; 1:11      1449 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1449 *   0  *2 = 84x 
    add  HL, HL         ; 1:11      1449 *   1  *2 = 168x
    add  HL, BC         ; 1:11      1449 *      +1 = 169x 
    add   A, H          ; 1:4       1449 *
    ld    H, A          ; 1:4       1449 *     [1449x] = 169x + 1280x  
                        ;[16:141]   1451 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1010_1011)
    ld    B, H          ; 1:4       1451 *
    ld    C, L          ; 1:4       1451 *   1       1x = base 
    add  HL, HL         ; 1:11      1451 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1451 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1451 *      +1 = 5x 
    ld    A, L          ; 1:4       1451 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1451 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1451 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1451 *      +1 = 21x 
    add  HL, HL         ; 1:11      1451 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1451 *   1  *2 = 84x
    add  HL, BC         ; 1:11      1451 *      +1 = 85x 
    add  HL, HL         ; 1:11      1451 *   1  *2 = 170x
    add  HL, BC         ; 1:11      1451 *      +1 = 171x 
    add   A, H          ; 1:4       1451 *
    ld    H, A          ; 1:4       1451 *     [1451x] = 171x + 1280x 

                        ;[16:141]   1453 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1010_1101)
    ld    B, H          ; 1:4       1453 *
    ld    C, L          ; 1:4       1453 *   1       1x = base 
    add  HL, HL         ; 1:11      1453 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1453 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1453 *      +1 = 5x 
    ld    A, L          ; 1:4       1453 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1453 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1453 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1453 *      +1 = 21x 
    add  HL, HL         ; 1:11      1453 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1453 *      +1 = 43x 
    add  HL, HL         ; 1:11      1453 *   0  *2 = 86x 
    add  HL, HL         ; 1:11      1453 *   1  *2 = 172x
    add  HL, BC         ; 1:11      1453 *      +1 = 173x 
    add   A, H          ; 1:4       1453 *
    ld    H, A          ; 1:4       1453 *     [1453x] = 173x + 1280x  
                        ;[17:152]   1455 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1010_1111)
    ld    B, H          ; 1:4       1455 *
    ld    C, L          ; 1:4       1455 *   1       1x = base 
    add  HL, HL         ; 1:11      1455 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1455 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1455 *      +1 = 5x 
    ld    A, L          ; 1:4       1455 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1455 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1455 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1455 *      +1 = 21x 
    add  HL, HL         ; 1:11      1455 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1455 *      +1 = 43x 
    add  HL, HL         ; 1:11      1455 *   1  *2 = 86x
    add  HL, BC         ; 1:11      1455 *      +1 = 87x 
    add  HL, HL         ; 1:11      1455 *   1  *2 = 174x
    add  HL, BC         ; 1:11      1455 *      +1 = 175x 
    add   A, H          ; 1:4       1455 *
    ld    H, A          ; 1:4       1455 *     [1455x] = 175x + 1280x  
                        ;[15:130]   1457 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1011_0001)
    ld    B, H          ; 1:4       1457 *
    ld    C, L          ; 1:4       1457 *   1       1x = base 
    add  HL, HL         ; 1:11      1457 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1457 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1457 *      +1 = 5x 
    ld    A, L          ; 1:4       1457 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1457 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1457 *      +1 = 11x 
    add  HL, HL         ; 1:11      1457 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1457 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1457 *   0  *2 = 88x 
    add  HL, HL         ; 1:11      1457 *   1  *2 = 176x
    add  HL, BC         ; 1:11      1457 *      +1 = 177x 
    add   A, H          ; 1:4       1457 *
    ld    H, A          ; 1:4       1457 *     [1457x] = 177x + 1280x  
                        ;[16:141]   1459 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1011_0011)
    ld    B, H          ; 1:4       1459 *
    ld    C, L          ; 1:4       1459 *   1       1x = base 
    add  HL, HL         ; 1:11      1459 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1459 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1459 *      +1 = 5x 
    ld    A, L          ; 1:4       1459 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1459 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1459 *      +1 = 11x 
    add  HL, HL         ; 1:11      1459 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1459 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1459 *   1  *2 = 88x
    add  HL, BC         ; 1:11      1459 *      +1 = 89x 
    add  HL, HL         ; 1:11      1459 *   1  *2 = 178x
    add  HL, BC         ; 1:11      1459 *      +1 = 179x 
    add   A, H          ; 1:4       1459 *
    ld    H, A          ; 1:4       1459 *     [1459x] = 179x + 1280x  
                        ;[16:141]   1461 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1011_0101)
    ld    B, H          ; 1:4       1461 *
    ld    C, L          ; 1:4       1461 *   1       1x = base 
    add  HL, HL         ; 1:11      1461 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1461 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1461 *      +1 = 5x 
    ld    A, L          ; 1:4       1461 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1461 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1461 *      +1 = 11x 
    add  HL, HL         ; 1:11      1461 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1461 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1461 *      +1 = 45x 
    add  HL, HL         ; 1:11      1461 *   0  *2 = 90x 
    add  HL, HL         ; 1:11      1461 *   1  *2 = 180x
    add  HL, BC         ; 1:11      1461 *      +1 = 181x 
    add   A, H          ; 1:4       1461 *
    ld    H, A          ; 1:4       1461 *     [1461x] = 181x + 1280x  
                        ;[17:152]   1463 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1011_0111)
    ld    B, H          ; 1:4       1463 *
    ld    C, L          ; 1:4       1463 *   1       1x = base 
    add  HL, HL         ; 1:11      1463 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1463 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1463 *      +1 = 5x 
    ld    A, L          ; 1:4       1463 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1463 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1463 *      +1 = 11x 
    add  HL, HL         ; 1:11      1463 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1463 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1463 *      +1 = 45x 
    add  HL, HL         ; 1:11      1463 *   1  *2 = 90x
    add  HL, BC         ; 1:11      1463 *      +1 = 91x 
    add  HL, HL         ; 1:11      1463 *   1  *2 = 182x
    add  HL, BC         ; 1:11      1463 *      +1 = 183x 
    add   A, H          ; 1:4       1463 *
    ld    H, A          ; 1:4       1463 *     [1463x] = 183x + 1280x  
                        ;[16:141]   1465 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1011_1001)
    ld    B, H          ; 1:4       1465 *
    ld    C, L          ; 1:4       1465 *   1       1x = base 
    add  HL, HL         ; 1:11      1465 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1465 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1465 *      +1 = 5x 
    ld    A, L          ; 1:4       1465 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1465 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1465 *      +1 = 11x 
    add  HL, HL         ; 1:11      1465 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1465 *      +1 = 23x 
    add  HL, HL         ; 1:11      1465 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1465 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1465 *   1  *2 = 184x
    add  HL, BC         ; 1:11      1465 *      +1 = 185x 
    add   A, H          ; 1:4       1465 *
    ld    H, A          ; 1:4       1465 *     [1465x] = 185x + 1280x  
                        ;[17:152]   1467 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1011_1011)
    ld    B, H          ; 1:4       1467 *
    ld    C, L          ; 1:4       1467 *   1       1x = base 
    add  HL, HL         ; 1:11      1467 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1467 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1467 *      +1 = 5x 
    ld    A, L          ; 1:4       1467 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1467 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1467 *      +1 = 11x 
    add  HL, HL         ; 1:11      1467 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1467 *      +1 = 23x 
    add  HL, HL         ; 1:11      1467 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1467 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1467 *      +1 = 93x 
    add  HL, HL         ; 1:11      1467 *   1  *2 = 186x
    add  HL, BC         ; 1:11      1467 *      +1 = 187x 
    add   A, H          ; 1:4       1467 *
    ld    H, A          ; 1:4       1467 *     [1467x] = 187x + 1280x  
                        ;[17:152]   1469 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1011_1101)
    ld    B, H          ; 1:4       1469 *
    ld    C, L          ; 1:4       1469 *   1       1x = base 
    add  HL, HL         ; 1:11      1469 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1469 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1469 *      +1 = 5x 
    ld    A, L          ; 1:4       1469 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1469 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1469 *      +1 = 11x 
    add  HL, HL         ; 1:11      1469 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1469 *      +1 = 23x 
    add  HL, HL         ; 1:11      1469 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1469 *      +1 = 47x 
    add  HL, HL         ; 1:11      1469 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1469 *   1  *2 = 188x
    add  HL, BC         ; 1:11      1469 *      +1 = 189x 
    add   A, H          ; 1:4       1469 *
    ld    H, A          ; 1:4       1469 *     [1469x] = 189x + 1280x 

                        ;[18:163]   1471 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0101_1011_1111)
    ld    B, H          ; 1:4       1471 *
    ld    C, L          ; 1:4       1471 *   1       1x = base 
    add  HL, HL         ; 1:11      1471 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1471 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1471 *      +1 = 5x 
    ld    A, L          ; 1:4       1471 *   256*L = 1280x 
    add  HL, HL         ; 1:11      1471 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1471 *      +1 = 11x 
    add  HL, HL         ; 1:11      1471 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1471 *      +1 = 23x 
    add  HL, HL         ; 1:11      1471 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1471 *      +1 = 47x 
    add  HL, HL         ; 1:11      1471 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1471 *      +1 = 95x 
    add  HL, HL         ; 1:11      1471 *   1  *2 = 190x
    add  HL, BC         ; 1:11      1471 *      +1 = 191x 
    add   A, H          ; 1:4       1471 *
    ld    H, A          ; 1:4       1471 *     [1471x] = 191x + 1280x  
                        ;[16:162]   1473 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1100_0001)
    ld    B, H          ; 1:4       1473 *
    ld    C, L          ; 1:4       1473 *   1       1x = base 
    add  HL, HL         ; 1:11      1473 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1473 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1473 *      +1 = 5x 
    add  HL, HL         ; 1:11      1473 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1473 *      +1 = 11x 
    add  HL, HL         ; 1:11      1473 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1473 *      +1 = 23x 
    add  HL, HL         ; 1:11      1473 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1473 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1473 *   0  *2 = 184x 
    add  HL, HL         ; 1:11      1473 *   0  *2 = 368x 
    add  HL, HL         ; 1:11      1473 *   0  *2 = 736x 
    add  HL, HL         ; 1:11      1473 *   1  *2 = 1472x
    add  HL, BC         ; 1:11      1473 *      +1 = 1473x   
                        ;[17:173]   1475 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1100_0011)
    ld    B, H          ; 1:4       1475 *
    ld    C, L          ; 1:4       1475 *   1       1x = base 
    add  HL, HL         ; 1:11      1475 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1475 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1475 *      +1 = 5x 
    add  HL, HL         ; 1:11      1475 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1475 *      +1 = 11x 
    add  HL, HL         ; 1:11      1475 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1475 *      +1 = 23x 
    add  HL, HL         ; 1:11      1475 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1475 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1475 *   0  *2 = 184x 
    add  HL, HL         ; 1:11      1475 *   0  *2 = 368x 
    add  HL, HL         ; 1:11      1475 *   1  *2 = 736x
    add  HL, BC         ; 1:11      1475 *      +1 = 737x 
    add  HL, HL         ; 1:11      1475 *   1  *2 = 1474x
    add  HL, BC         ; 1:11      1475 *      +1 = 1475x   
                        ;[17:173]   1477 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1100_0101)
    ld    B, H          ; 1:4       1477 *
    ld    C, L          ; 1:4       1477 *   1       1x = base 
    add  HL, HL         ; 1:11      1477 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1477 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1477 *      +1 = 5x 
    add  HL, HL         ; 1:11      1477 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1477 *      +1 = 11x 
    add  HL, HL         ; 1:11      1477 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1477 *      +1 = 23x 
    add  HL, HL         ; 1:11      1477 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1477 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1477 *   0  *2 = 184x 
    add  HL, HL         ; 1:11      1477 *   1  *2 = 368x
    add  HL, BC         ; 1:11      1477 *      +1 = 369x 
    add  HL, HL         ; 1:11      1477 *   0  *2 = 738x 
    add  HL, HL         ; 1:11      1477 *   1  *2 = 1476x
    add  HL, BC         ; 1:11      1477 *      +1 = 1477x   
                        ;[18:184]   1479 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1100_0111)
    ld    B, H          ; 1:4       1479 *
    ld    C, L          ; 1:4       1479 *   1       1x = base 
    add  HL, HL         ; 1:11      1479 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1479 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1479 *      +1 = 5x 
    add  HL, HL         ; 1:11      1479 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1479 *      +1 = 11x 
    add  HL, HL         ; 1:11      1479 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1479 *      +1 = 23x 
    add  HL, HL         ; 1:11      1479 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1479 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1479 *   0  *2 = 184x 
    add  HL, HL         ; 1:11      1479 *   1  *2 = 368x
    add  HL, BC         ; 1:11      1479 *      +1 = 369x 
    add  HL, HL         ; 1:11      1479 *   1  *2 = 738x
    add  HL, BC         ; 1:11      1479 *      +1 = 739x 
    add  HL, HL         ; 1:11      1479 *   1  *2 = 1478x
    add  HL, BC         ; 1:11      1479 *      +1 = 1479x   
                        ;[17:173]   1481 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1100_1001)
    ld    B, H          ; 1:4       1481 *
    ld    C, L          ; 1:4       1481 *   1       1x = base 
    add  HL, HL         ; 1:11      1481 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1481 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1481 *      +1 = 5x 
    add  HL, HL         ; 1:11      1481 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1481 *      +1 = 11x 
    add  HL, HL         ; 1:11      1481 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1481 *      +1 = 23x 
    add  HL, HL         ; 1:11      1481 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1481 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1481 *   1  *2 = 184x
    add  HL, BC         ; 1:11      1481 *      +1 = 185x 
    add  HL, HL         ; 1:11      1481 *   0  *2 = 370x 
    add  HL, HL         ; 1:11      1481 *   0  *2 = 740x 
    add  HL, HL         ; 1:11      1481 *   1  *2 = 1480x
    add  HL, BC         ; 1:11      1481 *      +1 = 1481x   
                        ;[18:184]   1483 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1100_1011)
    ld    B, H          ; 1:4       1483 *
    ld    C, L          ; 1:4       1483 *   1       1x = base 
    add  HL, HL         ; 1:11      1483 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1483 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1483 *      +1 = 5x 
    add  HL, HL         ; 1:11      1483 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1483 *      +1 = 11x 
    add  HL, HL         ; 1:11      1483 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1483 *      +1 = 23x 
    add  HL, HL         ; 1:11      1483 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1483 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1483 *   1  *2 = 184x
    add  HL, BC         ; 1:11      1483 *      +1 = 185x 
    add  HL, HL         ; 1:11      1483 *   0  *2 = 370x 
    add  HL, HL         ; 1:11      1483 *   1  *2 = 740x
    add  HL, BC         ; 1:11      1483 *      +1 = 741x 
    add  HL, HL         ; 1:11      1483 *   1  *2 = 1482x
    add  HL, BC         ; 1:11      1483 *      +1 = 1483x   
                        ;[18:184]   1485 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1100_1101)
    ld    B, H          ; 1:4       1485 *
    ld    C, L          ; 1:4       1485 *   1       1x = base 
    add  HL, HL         ; 1:11      1485 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1485 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1485 *      +1 = 5x 
    add  HL, HL         ; 1:11      1485 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1485 *      +1 = 11x 
    add  HL, HL         ; 1:11      1485 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1485 *      +1 = 23x 
    add  HL, HL         ; 1:11      1485 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1485 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1485 *   1  *2 = 184x
    add  HL, BC         ; 1:11      1485 *      +1 = 185x 
    add  HL, HL         ; 1:11      1485 *   1  *2 = 370x
    add  HL, BC         ; 1:11      1485 *      +1 = 371x 
    add  HL, HL         ; 1:11      1485 *   0  *2 = 742x 
    add  HL, HL         ; 1:11      1485 *   1  *2 = 1484x
    add  HL, BC         ; 1:11      1485 *      +1 = 1485x   
                        ;[19:195]   1487 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1100_1111)
    ld    B, H          ; 1:4       1487 *
    ld    C, L          ; 1:4       1487 *   1       1x = base 
    add  HL, HL         ; 1:11      1487 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1487 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1487 *      +1 = 5x 
    add  HL, HL         ; 1:11      1487 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1487 *      +1 = 11x 
    add  HL, HL         ; 1:11      1487 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1487 *      +1 = 23x 
    add  HL, HL         ; 1:11      1487 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1487 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1487 *   1  *2 = 184x
    add  HL, BC         ; 1:11      1487 *      +1 = 185x 
    add  HL, HL         ; 1:11      1487 *   1  *2 = 370x
    add  HL, BC         ; 1:11      1487 *      +1 = 371x 
    add  HL, HL         ; 1:11      1487 *   1  *2 = 742x
    add  HL, BC         ; 1:11      1487 *      +1 = 743x 
    add  HL, HL         ; 1:11      1487 *   1  *2 = 1486x
    add  HL, BC         ; 1:11      1487 *      +1 = 1487x  

                        ;[17:173]   1489 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1101_0001)
    ld    B, H          ; 1:4       1489 *
    ld    C, L          ; 1:4       1489 *   1       1x = base 
    add  HL, HL         ; 1:11      1489 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1489 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1489 *      +1 = 5x 
    add  HL, HL         ; 1:11      1489 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1489 *      +1 = 11x 
    add  HL, HL         ; 1:11      1489 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1489 *      +1 = 23x 
    add  HL, HL         ; 1:11      1489 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1489 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1489 *      +1 = 93x 
    add  HL, HL         ; 1:11      1489 *   0  *2 = 186x 
    add  HL, HL         ; 1:11      1489 *   0  *2 = 372x 
    add  HL, HL         ; 1:11      1489 *   0  *2 = 744x 
    add  HL, HL         ; 1:11      1489 *   1  *2 = 1488x
    add  HL, BC         ; 1:11      1489 *      +1 = 1489x   
                        ;[18:184]   1491 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1101_0011)
    ld    B, H          ; 1:4       1491 *
    ld    C, L          ; 1:4       1491 *   1       1x = base 
    add  HL, HL         ; 1:11      1491 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1491 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1491 *      +1 = 5x 
    add  HL, HL         ; 1:11      1491 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1491 *      +1 = 11x 
    add  HL, HL         ; 1:11      1491 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1491 *      +1 = 23x 
    add  HL, HL         ; 1:11      1491 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1491 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1491 *      +1 = 93x 
    add  HL, HL         ; 1:11      1491 *   0  *2 = 186x 
    add  HL, HL         ; 1:11      1491 *   0  *2 = 372x 
    add  HL, HL         ; 1:11      1491 *   1  *2 = 744x
    add  HL, BC         ; 1:11      1491 *      +1 = 745x 
    add  HL, HL         ; 1:11      1491 *   1  *2 = 1490x
    add  HL, BC         ; 1:11      1491 *      +1 = 1491x   
                        ;[18:184]   1493 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1101_0101)
    ld    B, H          ; 1:4       1493 *
    ld    C, L          ; 1:4       1493 *   1       1x = base 
    add  HL, HL         ; 1:11      1493 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1493 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1493 *      +1 = 5x 
    add  HL, HL         ; 1:11      1493 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1493 *      +1 = 11x 
    add  HL, HL         ; 1:11      1493 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1493 *      +1 = 23x 
    add  HL, HL         ; 1:11      1493 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1493 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1493 *      +1 = 93x 
    add  HL, HL         ; 1:11      1493 *   0  *2 = 186x 
    add  HL, HL         ; 1:11      1493 *   1  *2 = 372x
    add  HL, BC         ; 1:11      1493 *      +1 = 373x 
    add  HL, HL         ; 1:11      1493 *   0  *2 = 746x 
    add  HL, HL         ; 1:11      1493 *   1  *2 = 1492x
    add  HL, BC         ; 1:11      1493 *      +1 = 1493x   
                        ;[19:195]   1495 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1101_0111)
    ld    B, H          ; 1:4       1495 *
    ld    C, L          ; 1:4       1495 *   1       1x = base 
    add  HL, HL         ; 1:11      1495 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1495 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1495 *      +1 = 5x 
    add  HL, HL         ; 1:11      1495 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1495 *      +1 = 11x 
    add  HL, HL         ; 1:11      1495 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1495 *      +1 = 23x 
    add  HL, HL         ; 1:11      1495 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1495 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1495 *      +1 = 93x 
    add  HL, HL         ; 1:11      1495 *   0  *2 = 186x 
    add  HL, HL         ; 1:11      1495 *   1  *2 = 372x
    add  HL, BC         ; 1:11      1495 *      +1 = 373x 
    add  HL, HL         ; 1:11      1495 *   1  *2 = 746x
    add  HL, BC         ; 1:11      1495 *      +1 = 747x 
    add  HL, HL         ; 1:11      1495 *   1  *2 = 1494x
    add  HL, BC         ; 1:11      1495 *      +1 = 1495x   
                        ;[18:184]   1497 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1101_1001)
    ld    B, H          ; 1:4       1497 *
    ld    C, L          ; 1:4       1497 *   1       1x = base 
    add  HL, HL         ; 1:11      1497 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1497 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1497 *      +1 = 5x 
    add  HL, HL         ; 1:11      1497 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1497 *      +1 = 11x 
    add  HL, HL         ; 1:11      1497 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1497 *      +1 = 23x 
    add  HL, HL         ; 1:11      1497 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1497 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1497 *      +1 = 93x 
    add  HL, HL         ; 1:11      1497 *   1  *2 = 186x
    add  HL, BC         ; 1:11      1497 *      +1 = 187x 
    add  HL, HL         ; 1:11      1497 *   0  *2 = 374x 
    add  HL, HL         ; 1:11      1497 *   0  *2 = 748x 
    add  HL, HL         ; 1:11      1497 *   1  *2 = 1496x
    add  HL, BC         ; 1:11      1497 *      +1 = 1497x   
                        ;[19:195]   1499 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1101_1011)
    ld    B, H          ; 1:4       1499 *
    ld    C, L          ; 1:4       1499 *   1       1x = base 
    add  HL, HL         ; 1:11      1499 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1499 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1499 *      +1 = 5x 
    add  HL, HL         ; 1:11      1499 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1499 *      +1 = 11x 
    add  HL, HL         ; 1:11      1499 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1499 *      +1 = 23x 
    add  HL, HL         ; 1:11      1499 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1499 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1499 *      +1 = 93x 
    add  HL, HL         ; 1:11      1499 *   1  *2 = 186x
    add  HL, BC         ; 1:11      1499 *      +1 = 187x 
    add  HL, HL         ; 1:11      1499 *   0  *2 = 374x 
    add  HL, HL         ; 1:11      1499 *   1  *2 = 748x
    add  HL, BC         ; 1:11      1499 *      +1 = 749x 
    add  HL, HL         ; 1:11      1499 *   1  *2 = 1498x
    add  HL, BC         ; 1:11      1499 *      +1 = 1499x   
                        ;[19:195]   1501 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1101_1101)
    ld    B, H          ; 1:4       1501 *
    ld    C, L          ; 1:4       1501 *   1       1x = base 
    add  HL, HL         ; 1:11      1501 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1501 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1501 *      +1 = 5x 
    add  HL, HL         ; 1:11      1501 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1501 *      +1 = 11x 
    add  HL, HL         ; 1:11      1501 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1501 *      +1 = 23x 
    add  HL, HL         ; 1:11      1501 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1501 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1501 *      +1 = 93x 
    add  HL, HL         ; 1:11      1501 *   1  *2 = 186x
    add  HL, BC         ; 1:11      1501 *      +1 = 187x 
    add  HL, HL         ; 1:11      1501 *   1  *2 = 374x
    add  HL, BC         ; 1:11      1501 *      +1 = 375x 
    add  HL, HL         ; 1:11      1501 *   0  *2 = 750x 
    add  HL, HL         ; 1:11      1501 *   1  *2 = 1500x
    add  HL, BC         ; 1:11      1501 *      +1 = 1501x   
                        ;[19:118]   1503 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0010_0010_0001)  
    ld    B, H          ; 1:4       1503 *
    ld    C, L          ; 1:4       1503 *   [1x] 
    add  HL, HL         ; 1:11      1503 *   2x 
    ld    A, L          ; 1:4       1503 *   512x 
    add  HL, HL         ; 1:11      1503 *   4x 
    add  HL, HL         ; 1:11      1503 *   8x 
    add   A, B          ; 1:4       1503 *
    ld    B, A          ; 1:4       1503 *   [513x]
    ld    A, L          ; 1:4       1503 *   save --2048x-- 
    add  HL, HL         ; 1:11      1503 *   16x 
    add  HL, HL         ; 1:11      1503 *   32x 
    add  HL, BC         ; 1:11      1503 *   [545x]
    ld    B, A          ; 1:4       1503 *   A0 - HL
    xor   A             ; 1:4       1503 *
    sub   L             ; 1:4       1503 *
    ld    L, A          ; 1:4       1503 *
    ld    A, B          ; 1:4       1503 *
    sbc   A, H          ; 1:4       1503 *
    ld    H, A          ; 1:4       1503 *   [1503x] = 2048x - 2048x    
                        ;[17:173]   1505 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1110_0001)
    ld    B, H          ; 1:4       1505 *
    ld    C, L          ; 1:4       1505 *   1       1x = base 
    add  HL, HL         ; 1:11      1505 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1505 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1505 *      +1 = 5x 
    add  HL, HL         ; 1:11      1505 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1505 *      +1 = 11x 
    add  HL, HL         ; 1:11      1505 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1505 *      +1 = 23x 
    add  HL, HL         ; 1:11      1505 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1505 *      +1 = 47x 
    add  HL, HL         ; 1:11      1505 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1505 *   0  *2 = 188x 
    add  HL, HL         ; 1:11      1505 *   0  *2 = 376x 
    add  HL, HL         ; 1:11      1505 *   0  *2 = 752x 
    add  HL, HL         ; 1:11      1505 *   1  *2 = 1504x
    add  HL, BC         ; 1:11      1505 *      +1 = 1505x  

                        ;[18:184]   1507 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1110_0011)
    ld    B, H          ; 1:4       1507 *
    ld    C, L          ; 1:4       1507 *   1       1x = base 
    add  HL, HL         ; 1:11      1507 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1507 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1507 *      +1 = 5x 
    add  HL, HL         ; 1:11      1507 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1507 *      +1 = 11x 
    add  HL, HL         ; 1:11      1507 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1507 *      +1 = 23x 
    add  HL, HL         ; 1:11      1507 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1507 *      +1 = 47x 
    add  HL, HL         ; 1:11      1507 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1507 *   0  *2 = 188x 
    add  HL, HL         ; 1:11      1507 *   0  *2 = 376x 
    add  HL, HL         ; 1:11      1507 *   1  *2 = 752x
    add  HL, BC         ; 1:11      1507 *      +1 = 753x 
    add  HL, HL         ; 1:11      1507 *   1  *2 = 1506x
    add  HL, BC         ; 1:11      1507 *      +1 = 1507x   
                        ;[18:184]   1509 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1110_0101)
    ld    B, H          ; 1:4       1509 *
    ld    C, L          ; 1:4       1509 *   1       1x = base 
    add  HL, HL         ; 1:11      1509 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1509 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1509 *      +1 = 5x 
    add  HL, HL         ; 1:11      1509 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1509 *      +1 = 11x 
    add  HL, HL         ; 1:11      1509 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1509 *      +1 = 23x 
    add  HL, HL         ; 1:11      1509 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1509 *      +1 = 47x 
    add  HL, HL         ; 1:11      1509 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1509 *   0  *2 = 188x 
    add  HL, HL         ; 1:11      1509 *   1  *2 = 376x
    add  HL, BC         ; 1:11      1509 *      +1 = 377x 
    add  HL, HL         ; 1:11      1509 *   0  *2 = 754x 
    add  HL, HL         ; 1:11      1509 *   1  *2 = 1508x
    add  HL, BC         ; 1:11      1509 *      +1 = 1509x   
                        ;[19:195]   1511 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1110_0111)
    ld    B, H          ; 1:4       1511 *
    ld    C, L          ; 1:4       1511 *   1       1x = base 
    add  HL, HL         ; 1:11      1511 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1511 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1511 *      +1 = 5x 
    add  HL, HL         ; 1:11      1511 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1511 *      +1 = 11x 
    add  HL, HL         ; 1:11      1511 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1511 *      +1 = 23x 
    add  HL, HL         ; 1:11      1511 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1511 *      +1 = 47x 
    add  HL, HL         ; 1:11      1511 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1511 *   0  *2 = 188x 
    add  HL, HL         ; 1:11      1511 *   1  *2 = 376x
    add  HL, BC         ; 1:11      1511 *      +1 = 377x 
    add  HL, HL         ; 1:11      1511 *   1  *2 = 754x
    add  HL, BC         ; 1:11      1511 *      +1 = 755x 
    add  HL, HL         ; 1:11      1511 *   1  *2 = 1510x
    add  HL, BC         ; 1:11      1511 *      +1 = 1511x   
                        ;[18:184]   1513 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1110_1001)
    ld    B, H          ; 1:4       1513 *
    ld    C, L          ; 1:4       1513 *   1       1x = base 
    add  HL, HL         ; 1:11      1513 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1513 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1513 *      +1 = 5x 
    add  HL, HL         ; 1:11      1513 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1513 *      +1 = 11x 
    add  HL, HL         ; 1:11      1513 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1513 *      +1 = 23x 
    add  HL, HL         ; 1:11      1513 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1513 *      +1 = 47x 
    add  HL, HL         ; 1:11      1513 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1513 *   1  *2 = 188x
    add  HL, BC         ; 1:11      1513 *      +1 = 189x 
    add  HL, HL         ; 1:11      1513 *   0  *2 = 378x 
    add  HL, HL         ; 1:11      1513 *   0  *2 = 756x 
    add  HL, HL         ; 1:11      1513 *   1  *2 = 1512x
    add  HL, BC         ; 1:11      1513 *      +1 = 1513x   
                        ;[19:195]   1515 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1110_1011)
    ld    B, H          ; 1:4       1515 *
    ld    C, L          ; 1:4       1515 *   1       1x = base 
    add  HL, HL         ; 1:11      1515 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1515 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1515 *      +1 = 5x 
    add  HL, HL         ; 1:11      1515 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1515 *      +1 = 11x 
    add  HL, HL         ; 1:11      1515 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1515 *      +1 = 23x 
    add  HL, HL         ; 1:11      1515 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1515 *      +1 = 47x 
    add  HL, HL         ; 1:11      1515 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1515 *   1  *2 = 188x
    add  HL, BC         ; 1:11      1515 *      +1 = 189x 
    add  HL, HL         ; 1:11      1515 *   0  *2 = 378x 
    add  HL, HL         ; 1:11      1515 *   1  *2 = 756x
    add  HL, BC         ; 1:11      1515 *      +1 = 757x 
    add  HL, HL         ; 1:11      1515 *   1  *2 = 1514x
    add  HL, BC         ; 1:11      1515 *      +1 = 1515x   
                        ;[19:195]   1517 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1110_1101)
    ld    B, H          ; 1:4       1517 *
    ld    C, L          ; 1:4       1517 *   1       1x = base 
    add  HL, HL         ; 1:11      1517 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1517 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1517 *      +1 = 5x 
    add  HL, HL         ; 1:11      1517 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1517 *      +1 = 11x 
    add  HL, HL         ; 1:11      1517 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1517 *      +1 = 23x 
    add  HL, HL         ; 1:11      1517 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1517 *      +1 = 47x 
    add  HL, HL         ; 1:11      1517 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1517 *   1  *2 = 188x
    add  HL, BC         ; 1:11      1517 *      +1 = 189x 
    add  HL, HL         ; 1:11      1517 *   1  *2 = 378x
    add  HL, BC         ; 1:11      1517 *      +1 = 379x 
    add  HL, HL         ; 1:11      1517 *   0  *2 = 758x 
    add  HL, HL         ; 1:11      1517 *   1  *2 = 1516x
    add  HL, BC         ; 1:11      1517 *      +1 = 1517x   
                        ;[18:107]   1519 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0010_0001_0001)  
    ld    B, H          ; 1:4       1519 *
    ld    C, L          ; 1:4       1519 *   [1x] 
    add  HL, HL         ; 1:11      1519 *   2x 
    ld    A, L          ; 1:4       1519 *   512x 
    add  HL, HL         ; 1:11      1519 *   4x 
    add  HL, HL         ; 1:11      1519 *   8x 
    add   A, B          ; 1:4       1519 *
    ld    B, A          ; 1:4       1519 *   [513x]
    ld    A, L          ; 1:4       1519 *   save --2048x-- 
    add  HL, HL         ; 1:11      1519 *   16x 
    add  HL, BC         ; 1:11      1519 *   [529x]
    ld    B, A          ; 1:4       1519 *   A0 - HL
    xor   A             ; 1:4       1519 *
    sub   L             ; 1:4       1519 *
    ld    L, A          ; 1:4       1519 *
    ld    A, B          ; 1:4       1519 *
    sbc   A, H          ; 1:4       1519 *
    ld    H, A          ; 1:4       1519 *   [1519x] = 2048x - 2048x    
                        ;[18:184]   1521 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1111_0001)
    ld    B, H          ; 1:4       1521 *
    ld    C, L          ; 1:4       1521 *   1       1x = base 
    add  HL, HL         ; 1:11      1521 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1521 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1521 *      +1 = 5x 
    add  HL, HL         ; 1:11      1521 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1521 *      +1 = 11x 
    add  HL, HL         ; 1:11      1521 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1521 *      +1 = 23x 
    add  HL, HL         ; 1:11      1521 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1521 *      +1 = 47x 
    add  HL, HL         ; 1:11      1521 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1521 *      +1 = 95x 
    add  HL, HL         ; 1:11      1521 *   0  *2 = 190x 
    add  HL, HL         ; 1:11      1521 *   0  *2 = 380x 
    add  HL, HL         ; 1:11      1521 *   0  *2 = 760x 
    add  HL, HL         ; 1:11      1521 *   1  *2 = 1520x
    add  HL, BC         ; 1:11      1521 *      +1 = 1521x   
                        ;[19:195]   1523 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1111_0011)
    ld    B, H          ; 1:4       1523 *
    ld    C, L          ; 1:4       1523 *   1       1x = base 
    add  HL, HL         ; 1:11      1523 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1523 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1523 *      +1 = 5x 
    add  HL, HL         ; 1:11      1523 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1523 *      +1 = 11x 
    add  HL, HL         ; 1:11      1523 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1523 *      +1 = 23x 
    add  HL, HL         ; 1:11      1523 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1523 *      +1 = 47x 
    add  HL, HL         ; 1:11      1523 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1523 *      +1 = 95x 
    add  HL, HL         ; 1:11      1523 *   0  *2 = 190x 
    add  HL, HL         ; 1:11      1523 *   0  *2 = 380x 
    add  HL, HL         ; 1:11      1523 *   1  *2 = 760x
    add  HL, BC         ; 1:11      1523 *      +1 = 761x 
    add  HL, HL         ; 1:11      1523 *   1  *2 = 1522x
    add  HL, BC         ; 1:11      1523 *      +1 = 1523x  

                        ;[19:195]   1525 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1111_0101)
    ld    B, H          ; 1:4       1525 *
    ld    C, L          ; 1:4       1525 *   1       1x = base 
    add  HL, HL         ; 1:11      1525 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1525 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1525 *      +1 = 5x 
    add  HL, HL         ; 1:11      1525 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1525 *      +1 = 11x 
    add  HL, HL         ; 1:11      1525 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1525 *      +1 = 23x 
    add  HL, HL         ; 1:11      1525 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1525 *      +1 = 47x 
    add  HL, HL         ; 1:11      1525 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1525 *      +1 = 95x 
    add  HL, HL         ; 1:11      1525 *   0  *2 = 190x 
    add  HL, HL         ; 1:11      1525 *   1  *2 = 380x
    add  HL, BC         ; 1:11      1525 *      +1 = 381x 
    add  HL, HL         ; 1:11      1525 *   0  *2 = 762x 
    add  HL, HL         ; 1:11      1525 *   1  *2 = 1524x
    add  HL, BC         ; 1:11      1525 *      +1 = 1525x   
                        ;[15:90]    1527 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0010_0000_1001)  
    ld    B, H          ; 1:4       1527 *
    ld    C, L          ; 1:4       1527 *   [1x] 
    add  HL, HL         ; 1:11      1527 *   2x 
    ld    A, L          ; 1:4       1527 *   512x 
    add  HL, HL         ; 1:11      1527 *   4x 
    add  HL, HL         ; 1:11      1527 *   8x 
    sub   L             ; 1:4       1527 *   L0 - (HL + BC + A0) = 0 - ((HL + BC) + (A0 - L0))
    add  HL, BC         ; 1:11      1527 *   [9x]
    add   A, H          ; 1:4       1527 *   [-1527x]
    cpl                 ; 1:4       1527 *
    ld    H, A          ; 1:4       1527 *
    ld    A, L          ; 1:4       1527 *
    cpl                 ; 1:4       1527 *
    ld    L, A          ; 1:4       1527 *
    inc  HL             ; 1:6       1527 *   [1527x] = 0-1527x    
                        ;[19:195]   1529 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1111_1001)
    ld    B, H          ; 1:4       1529 *
    ld    C, L          ; 1:4       1529 *   1       1x = base 
    add  HL, HL         ; 1:11      1529 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1529 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1529 *      +1 = 5x 
    add  HL, HL         ; 1:11      1529 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1529 *      +1 = 11x 
    add  HL, HL         ; 1:11      1529 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1529 *      +1 = 23x 
    add  HL, HL         ; 1:11      1529 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1529 *      +1 = 47x 
    add  HL, HL         ; 1:11      1529 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1529 *      +1 = 95x 
    add  HL, HL         ; 1:11      1529 *   1  *2 = 190x
    add  HL, BC         ; 1:11      1529 *      +1 = 191x 
    add  HL, HL         ; 1:11      1529 *   0  *2 = 382x 
    add  HL, HL         ; 1:11      1529 *   0  *2 = 764x 
    add  HL, HL         ; 1:11      1529 *   1  *2 = 1528x
    add  HL, BC         ; 1:11      1529 *      +1 = 1529x   
                        ;[20:206]   1531 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1111_1011)
    ld    B, H          ; 1:4       1531 *
    ld    C, L          ; 1:4       1531 *   1       1x = base 
    add  HL, HL         ; 1:11      1531 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1531 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1531 *      +1 = 5x 
    add  HL, HL         ; 1:11      1531 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1531 *      +1 = 11x 
    add  HL, HL         ; 1:11      1531 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1531 *      +1 = 23x 
    add  HL, HL         ; 1:11      1531 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1531 *      +1 = 47x 
    add  HL, HL         ; 1:11      1531 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1531 *      +1 = 95x 
    add  HL, HL         ; 1:11      1531 *   1  *2 = 190x
    add  HL, BC         ; 1:11      1531 *      +1 = 191x 
    add  HL, HL         ; 1:11      1531 *   0  *2 = 382x 
    add  HL, HL         ; 1:11      1531 *   1  *2 = 764x
    add  HL, BC         ; 1:11      1531 *      +1 = 765x 
    add  HL, HL         ; 1:11      1531 *   1  *2 = 1530x
    add  HL, BC         ; 1:11      1531 *      +1 = 1531x   
                        ;[20:206]   1533 *   Variant mk4: ...(((HL*2^a)+HL)*2^b)+... = HL * (b_0101_1111_1101)
    ld    B, H          ; 1:4       1533 *
    ld    C, L          ; 1:4       1533 *   1       1x = base 
    add  HL, HL         ; 1:11      1533 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1533 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1533 *      +1 = 5x 
    add  HL, HL         ; 1:11      1533 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1533 *      +1 = 11x 
    add  HL, HL         ; 1:11      1533 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1533 *      +1 = 23x 
    add  HL, HL         ; 1:11      1533 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1533 *      +1 = 47x 
    add  HL, HL         ; 1:11      1533 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1533 *      +1 = 95x 
    add  HL, HL         ; 1:11      1533 *   1  *2 = 190x
    add  HL, BC         ; 1:11      1533 *      +1 = 191x 
    add  HL, HL         ; 1:11      1533 *   1  *2 = 382x
    add  HL, BC         ; 1:11      1533 *      +1 = 383x 
    add  HL, HL         ; 1:11      1533 *   0  *2 = 766x 
    add  HL, HL         ; 1:11      1533 *   1  *2 = 1532x
    add  HL, BC         ; 1:11      1533 *      +1 = 1533x   
                        ;[14:83]    1535 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0010_0000_0001)  
    ld    B, H          ; 1:4       1535 *
    ld    C, L          ; 1:4       1535 *   [1x] 
    add  HL, HL         ; 1:11      1535 *   2x 
    ld    A, L          ; 1:4       1535 *   512x 
    add  HL, HL         ; 1:11      1535 *   4x 
    add  HL, HL         ; 1:11      1535 *   8x 
    add   A, B          ; 1:4       1535 *
    ld    B, A          ; 1:4       1535 *   [513x]
    ld    H, L          ; 1:4       1535 *
    ld    L, 0x00       ; 2:7       1535 *   2048x 
    or    A             ; 1:4       1535 *
    sbc  HL, BC         ; 2:15      1535 *   [1535x] = 2048x - 513x   
                        ;[6:24]     1537 *   Variant mk4: 256*...(((L*2^a)+L)*2^b)+... = HL * (b_0110_0000_0001)
    ld    A, L          ; 1:4       1537 *   1       1x 
    add   A, A          ; 1:4       1537 *   1  *2 = 2x
    add   A, L          ; 1:4       1537 *      +1 = 3x 
    add   A, A          ; 1:4       1537 *   0  *2 = 6x 
    add   A, H          ; 1:4       1537 *
    ld    H, A          ; 1:4       1537 *     [1537x] = 256 * 6x + 1x  
                        ;[10:54]    1539 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0110_0000_0011)
    ld    B, H          ; 1:4       1539 *
    ld    C, L          ; 1:4       1539 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1539 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1539 *      +1 = 3x  
    ld    A, C          ; 1:4       1539 *   1       1x 
    add   A, A          ; 1:4       1539 *   1  *2 = 2x
    add   A, C          ; 1:4       1539 *      +1 = 3x 
    add   A, A          ; 1:4       1539 *   0  *2 = 6x 
    add   A, H          ; 1:4       1539 *
    ld    H, A          ; 1:4       1539 *     [1539x] = 256 * 6x + 3x  
                        ;[9:57]     1541 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0110_0000_0101)  
    ld    B, H          ; 1:4       1541 *
    ld    C, L          ; 1:4       1541 *   [1x] 
    add  HL, HL         ; 1:11      1541 *   2x 
    ld    A, L          ; 1:4       1541 *   512x 
    add  HL, HL         ; 1:11      1541 *   4x 
    add   A, L          ; 1:4       1541 *   1536x
    add   A, B          ; 1:4       1541 *
    ld    B, A          ; 1:4       1541 *   [1537x] 
    add  HL, BC         ; 1:11      1541 *   [1541x] = 4x + 1537x  

                        ;[9:64]     1543 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0000_0111)
    ld    B, H          ; 1:4       1543 *
    ld    C, L          ; 1:4       1543 *   1       1x = base 
    add  HL, HL         ; 1:11      1543 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1543 *      +1 = 3x 
    add  HL, HL         ; 1:11      1543 *   1  *2 = 6x
    ld    A, L          ; 1:4       1543 *   256*L = 1536x
    add  HL, BC         ; 1:11      1543 *      +1 = 7x 
    add   A, H          ; 1:4       1543 *
    ld    H, A          ; 1:4       1543 *     [1543x] = 7x + 1536x  
                        ;[10:68]    1545 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0110_0000_1001)  
    ld    B, H          ; 1:4       1545 *
    ld    C, L          ; 1:4       1545 *   [1x] 
    add  HL, HL         ; 1:11      1545 *   2x 
    ld    A, L          ; 1:4       1545 *   512x 
    add  HL, HL         ; 1:11      1545 *   4x 
    add   A, L          ; 1:4       1545 *   1536x 
    add  HL, HL         ; 1:11      1545 *   8x 
    add   A, B          ; 1:4       1545 *
    ld    B, A          ; 1:4       1545 *   [1537x] 
    add  HL, BC         ; 1:11      1545 *   [1545x] = 8x + 1537x   
                        ;[11:79]    1547 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0000_1011)
    ld    B, H          ; 1:4       1547 *
    ld    C, L          ; 1:4       1547 *   1       1x = base 
    ld    A, L          ; 1:4       1547 *   256*L = 256x 
    add  HL, HL         ; 1:11      1547 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1547 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1547 *      +1 = 5x 
    add   A, L          ; 1:4       1547 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1547 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1547 *      +1 = 11x 
    add   A, H          ; 1:4       1547 *
    ld    H, A          ; 1:4       1547 *     [1547x] = 11x + 1536x  
                        ;[10:75]    1549 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0000_1101)
    ld    B, H          ; 1:4       1549 *
    ld    C, L          ; 1:4       1549 *   1       1x = base 
    add  HL, HL         ; 1:11      1549 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1549 *      +1 = 3x 
    add  HL, HL         ; 1:11      1549 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1549 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1549 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1549 *      +1 = 13x 
    add   A, H          ; 1:4       1549 *
    ld    H, A          ; 1:4       1549 *     [1549x] = 13x + 1536x  
                        ;[11:86]    1551 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0000_1111)
    ld    B, H          ; 1:4       1551 *
    ld    C, L          ; 1:4       1551 *   1       1x = base 
    add  HL, HL         ; 1:11      1551 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1551 *      +1 = 3x 
    add  HL, HL         ; 1:11      1551 *   1  *2 = 6x
    ld    A, L          ; 1:4       1551 *   256*L = 1536x
    add  HL, BC         ; 1:11      1551 *      +1 = 7x 
    add  HL, HL         ; 1:11      1551 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1551 *      +1 = 15x 
    add   A, H          ; 1:4       1551 *
    ld    H, A          ; 1:4       1551 *     [1551x] = 15x + 1536x  
                        ;[11:79]    1553 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0110_0001_0001)  
    ld    B, H          ; 1:4       1553 *
    ld    C, L          ; 1:4       1553 *   [1x] 
    add  HL, HL         ; 1:11      1553 *   2x 
    ld    A, L          ; 1:4       1553 *   512x 
    add  HL, HL         ; 1:11      1553 *   4x 
    add   A, L          ; 1:4       1553 *   1536x 
    add  HL, HL         ; 1:11      1553 *   8x 
    add  HL, HL         ; 1:11      1553 *   16x 
    add   A, B          ; 1:4       1553 *
    ld    B, A          ; 1:4       1553 *   [1537x] 
    add  HL, BC         ; 1:11      1553 *   [1553x] = 16x + 1537x   
                        ;[12:90]    1555 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0001_0011)
    ld    B, H          ; 1:4       1555 *
    ld    C, L          ; 1:4       1555 *   1       1x = base 
    add  HL, HL         ; 1:11      1555 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1555 *   256*L = 512x 
    add  HL, HL         ; 1:11      1555 *   0  *2 = 4x 
    add   A, L          ; 1:4       1555 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1555 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1555 *      +1 = 9x 
    add  HL, HL         ; 1:11      1555 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1555 *      +1 = 19x 
    add   A, H          ; 1:4       1555 *
    ld    H, A          ; 1:4       1555 *     [1555x] = 19x + 1536x  
                        ;[12:90]    1557 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0001_0101)
    ld    B, H          ; 1:4       1557 *
    ld    C, L          ; 1:4       1557 *   1       1x = base 
    ld    A, L          ; 1:4       1557 *   256*L = 256x 
    add  HL, HL         ; 1:11      1557 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1557 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1557 *      +1 = 5x 
    add   A, L          ; 1:4       1557 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1557 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1557 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1557 *      +1 = 21x 
    add   A, H          ; 1:4       1557 *
    ld    H, A          ; 1:4       1557 *     [1557x] = 21x + 1536x  
                        ;[13:101]   1559 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0001_0111)
    ld    B, H          ; 1:4       1559 *
    ld    C, L          ; 1:4       1559 *   1       1x = base 
    ld    A, L          ; 1:4       1559 *   256*L = 256x 
    add  HL, HL         ; 1:11      1559 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1559 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1559 *      +1 = 5x 
    add   A, L          ; 1:4       1559 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1559 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1559 *      +1 = 11x 
    add  HL, HL         ; 1:11      1559 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1559 *      +1 = 23x 
    add   A, H          ; 1:4       1559 *
    ld    H, A          ; 1:4       1559 *     [1559x] = 23x + 1536x 

                        ;[11:86]    1561 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0001_1001)
    ld    B, H          ; 1:4       1561 *
    ld    C, L          ; 1:4       1561 *   1       1x = base 
    add  HL, HL         ; 1:11      1561 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1561 *      +1 = 3x 
    add  HL, HL         ; 1:11      1561 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1561 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1561 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1561 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1561 *      +1 = 25x 
    add   A, H          ; 1:4       1561 *
    ld    H, A          ; 1:4       1561 *     [1561x] = 25x + 1536x  
                        ;[12:97]    1563 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0001_1011)
    ld    B, H          ; 1:4       1563 *
    ld    C, L          ; 1:4       1563 *   1       1x = base 
    add  HL, HL         ; 1:11      1563 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1563 *      +1 = 3x 
    add  HL, HL         ; 1:11      1563 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1563 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1563 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1563 *      +1 = 13x 
    add  HL, HL         ; 1:11      1563 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1563 *      +1 = 27x 
    add   A, H          ; 1:4       1563 *
    ld    H, A          ; 1:4       1563 *     [1563x] = 27x + 1536x  
                        ;[12:97]    1565 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0001_1101)
    ld    B, H          ; 1:4       1565 *
    ld    C, L          ; 1:4       1565 *   1       1x = base 
    add  HL, HL         ; 1:11      1565 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1565 *      +1 = 3x 
    add  HL, HL         ; 1:11      1565 *   1  *2 = 6x
    ld    A, L          ; 1:4       1565 *   256*L = 1536x
    add  HL, BC         ; 1:11      1565 *      +1 = 7x 
    add  HL, HL         ; 1:11      1565 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1565 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1565 *      +1 = 29x 
    add   A, H          ; 1:4       1565 *
    ld    H, A          ; 1:4       1565 *     [1565x] = 29x + 1536x  
                        ;[13:108]   1567 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0001_1111)
    ld    B, H          ; 1:4       1567 *
    ld    C, L          ; 1:4       1567 *   1       1x = base 
    add  HL, HL         ; 1:11      1567 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1567 *      +1 = 3x 
    add  HL, HL         ; 1:11      1567 *   1  *2 = 6x
    ld    A, L          ; 1:4       1567 *   256*L = 1536x
    add  HL, BC         ; 1:11      1567 *      +1 = 7x 
    add  HL, HL         ; 1:11      1567 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1567 *      +1 = 15x 
    add  HL, HL         ; 1:11      1567 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1567 *      +1 = 31x 
    add   A, H          ; 1:4       1567 *
    ld    H, A          ; 1:4       1567 *     [1567x] = 31x + 1536x  
                        ;[12:90]    1569 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0110_0010_0001)  
    ld    B, H          ; 1:4       1569 *
    ld    C, L          ; 1:4       1569 *   [1x] 
    add  HL, HL         ; 1:11      1569 *   2x 
    ld    A, L          ; 1:4       1569 *   512x 
    add  HL, HL         ; 1:11      1569 *   4x 
    add   A, L          ; 1:4       1569 *   1536x 
    add  HL, HL         ; 1:11      1569 *   8x 
    add  HL, HL         ; 1:11      1569 *   16x 
    add  HL, HL         ; 1:11      1569 *   32x 
    add   A, B          ; 1:4       1569 *
    ld    B, A          ; 1:4       1569 *   [1537x] 
    add  HL, BC         ; 1:11      1569 *   [1569x] = 32x + 1537x   
                        ;[13:101]   1571 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0010_0011)
    ld    B, H          ; 1:4       1571 *
    ld    C, L          ; 1:4       1571 *   1       1x = base 
    add  HL, HL         ; 1:11      1571 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1571 *   256*L = 512x 
    add  HL, HL         ; 1:11      1571 *   0  *2 = 4x 
    add   A, L          ; 1:4       1571 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1571 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1571 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1571 *      +1 = 17x 
    add  HL, HL         ; 1:11      1571 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1571 *      +1 = 35x 
    add   A, H          ; 1:4       1571 *
    ld    H, A          ; 1:4       1571 *     [1571x] = 35x + 1536x  
                        ;[13:101]   1573 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0010_0101)
    ld    B, H          ; 1:4       1573 *
    ld    C, L          ; 1:4       1573 *   1       1x = base 
    add  HL, HL         ; 1:11      1573 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1573 *   256*L = 512x 
    add  HL, HL         ; 1:11      1573 *   0  *2 = 4x 
    add   A, L          ; 1:4       1573 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1573 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1573 *      +1 = 9x 
    add  HL, HL         ; 1:11      1573 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1573 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1573 *      +1 = 37x 
    add   A, H          ; 1:4       1573 *
    ld    H, A          ; 1:4       1573 *     [1573x] = 37x + 1536x  
                        ;[14:112]   1575 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0010_0111)
    ld    B, H          ; 1:4       1575 *
    ld    C, L          ; 1:4       1575 *   1       1x = base 
    add  HL, HL         ; 1:11      1575 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1575 *   256*L = 512x 
    add  HL, HL         ; 1:11      1575 *   0  *2 = 4x 
    add   A, L          ; 1:4       1575 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1575 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1575 *      +1 = 9x 
    add  HL, HL         ; 1:11      1575 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1575 *      +1 = 19x 
    add  HL, HL         ; 1:11      1575 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1575 *      +1 = 39x 
    add   A, H          ; 1:4       1575 *
    ld    H, A          ; 1:4       1575 *     [1575x] = 39x + 1536x  
                        ;[13:101]   1577 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0010_1001)
    ld    B, H          ; 1:4       1577 *
    ld    C, L          ; 1:4       1577 *   1       1x = base 
    ld    A, L          ; 1:4       1577 *   256*L = 256x 
    add  HL, HL         ; 1:11      1577 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1577 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1577 *      +1 = 5x 
    add   A, L          ; 1:4       1577 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1577 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1577 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1577 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1577 *      +1 = 41x 
    add   A, H          ; 1:4       1577 *
    ld    H, A          ; 1:4       1577 *     [1577x] = 41x + 1536x 

                        ;[14:112]   1579 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0010_1011)
    ld    B, H          ; 1:4       1579 *
    ld    C, L          ; 1:4       1579 *   1       1x = base 
    ld    A, L          ; 1:4       1579 *   256*L = 256x 
    add  HL, HL         ; 1:11      1579 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1579 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1579 *      +1 = 5x 
    add   A, L          ; 1:4       1579 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1579 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1579 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1579 *      +1 = 21x 
    add  HL, HL         ; 1:11      1579 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1579 *      +1 = 43x 
    add   A, H          ; 1:4       1579 *
    ld    H, A          ; 1:4       1579 *     [1579x] = 43x + 1536x  
                        ;[14:112]   1581 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0010_1101)
    ld    B, H          ; 1:4       1581 *
    ld    C, L          ; 1:4       1581 *   1       1x = base 
    ld    A, L          ; 1:4       1581 *   256*L = 256x 
    add  HL, HL         ; 1:11      1581 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1581 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1581 *      +1 = 5x 
    add   A, L          ; 1:4       1581 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1581 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1581 *      +1 = 11x 
    add  HL, HL         ; 1:11      1581 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1581 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1581 *      +1 = 45x 
    add   A, H          ; 1:4       1581 *
    ld    H, A          ; 1:4       1581 *     [1581x] = 45x + 1536x  
                        ;[15:123]   1583 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0010_1111)
    ld    B, H          ; 1:4       1583 *
    ld    C, L          ; 1:4       1583 *   1       1x = base 
    ld    A, L          ; 1:4       1583 *   256*L = 256x 
    add  HL, HL         ; 1:11      1583 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1583 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1583 *      +1 = 5x 
    add   A, L          ; 1:4       1583 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1583 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1583 *      +1 = 11x 
    add  HL, HL         ; 1:11      1583 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1583 *      +1 = 23x 
    add  HL, HL         ; 1:11      1583 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1583 *      +1 = 47x 
    add   A, H          ; 1:4       1583 *
    ld    H, A          ; 1:4       1583 *     [1583x] = 47x + 1536x  
                        ;[12:97]    1585 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0011_0001)
    ld    B, H          ; 1:4       1585 *
    ld    C, L          ; 1:4       1585 *   1       1x = base 
    add  HL, HL         ; 1:11      1585 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1585 *      +1 = 3x 
    add  HL, HL         ; 1:11      1585 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1585 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1585 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1585 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1585 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1585 *      +1 = 49x 
    add   A, H          ; 1:4       1585 *
    ld    H, A          ; 1:4       1585 *     [1585x] = 49x + 1536x  
                        ;[13:108]   1587 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0011_0011)
    ld    B, H          ; 1:4       1587 *
    ld    C, L          ; 1:4       1587 *   1       1x = base 
    add  HL, HL         ; 1:11      1587 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1587 *      +1 = 3x 
    add  HL, HL         ; 1:11      1587 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1587 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1587 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1587 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1587 *      +1 = 25x 
    add  HL, HL         ; 1:11      1587 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1587 *      +1 = 51x 
    add   A, H          ; 1:4       1587 *
    ld    H, A          ; 1:4       1587 *     [1587x] = 51x + 1536x  
                        ;[13:108]   1589 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0011_0101)
    ld    B, H          ; 1:4       1589 *
    ld    C, L          ; 1:4       1589 *   1       1x = base 
    add  HL, HL         ; 1:11      1589 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1589 *      +1 = 3x 
    add  HL, HL         ; 1:11      1589 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1589 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1589 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1589 *      +1 = 13x 
    add  HL, HL         ; 1:11      1589 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1589 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1589 *      +1 = 53x 
    add   A, H          ; 1:4       1589 *
    ld    H, A          ; 1:4       1589 *     [1589x] = 53x + 1536x  
                        ;[14:119]   1591 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0011_0111)
    ld    B, H          ; 1:4       1591 *
    ld    C, L          ; 1:4       1591 *   1       1x = base 
    add  HL, HL         ; 1:11      1591 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1591 *      +1 = 3x 
    add  HL, HL         ; 1:11      1591 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1591 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1591 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1591 *      +1 = 13x 
    add  HL, HL         ; 1:11      1591 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1591 *      +1 = 27x 
    add  HL, HL         ; 1:11      1591 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1591 *      +1 = 55x 
    add   A, H          ; 1:4       1591 *
    ld    H, A          ; 1:4       1591 *     [1591x] = 55x + 1536x  
                        ;[13:108]   1593 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0011_1001)
    ld    B, H          ; 1:4       1593 *
    ld    C, L          ; 1:4       1593 *   1       1x = base 
    add  HL, HL         ; 1:11      1593 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1593 *      +1 = 3x 
    add  HL, HL         ; 1:11      1593 *   1  *2 = 6x
    ld    A, L          ; 1:4       1593 *   256*L = 1536x
    add  HL, BC         ; 1:11      1593 *      +1 = 7x 
    add  HL, HL         ; 1:11      1593 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1593 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1593 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1593 *      +1 = 57x 
    add   A, H          ; 1:4       1593 *
    ld    H, A          ; 1:4       1593 *     [1593x] = 57x + 1536x  
                        ;[14:119]   1595 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0011_1011)
    ld    B, H          ; 1:4       1595 *
    ld    C, L          ; 1:4       1595 *   1       1x = base 
    add  HL, HL         ; 1:11      1595 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1595 *      +1 = 3x 
    add  HL, HL         ; 1:11      1595 *   1  *2 = 6x
    ld    A, L          ; 1:4       1595 *   256*L = 1536x
    add  HL, BC         ; 1:11      1595 *      +1 = 7x 
    add  HL, HL         ; 1:11      1595 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1595 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1595 *      +1 = 29x 
    add  HL, HL         ; 1:11      1595 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1595 *      +1 = 59x 
    add   A, H          ; 1:4       1595 *
    ld    H, A          ; 1:4       1595 *     [1595x] = 59x + 1536x 

                        ;[14:119]   1597 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0011_1101)
    ld    B, H          ; 1:4       1597 *
    ld    C, L          ; 1:4       1597 *   1       1x = base 
    add  HL, HL         ; 1:11      1597 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1597 *      +1 = 3x 
    add  HL, HL         ; 1:11      1597 *   1  *2 = 6x
    ld    A, L          ; 1:4       1597 *   256*L = 1536x
    add  HL, BC         ; 1:11      1597 *      +1 = 7x 
    add  HL, HL         ; 1:11      1597 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1597 *      +1 = 15x 
    add  HL, HL         ; 1:11      1597 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1597 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1597 *      +1 = 61x 
    add   A, H          ; 1:4       1597 *
    ld    H, A          ; 1:4       1597 *     [1597x] = 61x + 1536x  
                        ;[15:130]   1599 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0011_1111)
    ld    B, H          ; 1:4       1599 *
    ld    C, L          ; 1:4       1599 *   1       1x = base 
    add  HL, HL         ; 1:11      1599 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1599 *      +1 = 3x 
    add  HL, HL         ; 1:11      1599 *   1  *2 = 6x
    ld    A, L          ; 1:4       1599 *   256*L = 1536x
    add  HL, BC         ; 1:11      1599 *      +1 = 7x 
    add  HL, HL         ; 1:11      1599 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1599 *      +1 = 15x 
    add  HL, HL         ; 1:11      1599 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1599 *      +1 = 31x 
    add  HL, HL         ; 1:11      1599 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1599 *      +1 = 63x 
    add   A, H          ; 1:4       1599 *
    ld    H, A          ; 1:4       1599 *     [1599x] = 63x + 1536x  
                        ;[13:101]   1601 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0110_0100_0001)  
    ld    B, H          ; 1:4       1601 *
    ld    C, L          ; 1:4       1601 *   [1x] 
    add  HL, HL         ; 1:11      1601 *   2x 
    ld    A, L          ; 1:4       1601 *   512x 
    add  HL, HL         ; 1:11      1601 *   4x 
    add   A, L          ; 1:4       1601 *   1536x 
    add  HL, HL         ; 1:11      1601 *   8x 
    add  HL, HL         ; 1:11      1601 *   16x 
    add  HL, HL         ; 1:11      1601 *   32x 
    add  HL, HL         ; 1:11      1601 *   64x 
    add   A, B          ; 1:4       1601 *
    ld    B, A          ; 1:4       1601 *   [1537x] 
    add  HL, BC         ; 1:11      1601 *   [1601x] = 64x + 1537x   
                        ;[14:112]   1603 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0100_0011)
    ld    B, H          ; 1:4       1603 *
    ld    C, L          ; 1:4       1603 *   1       1x = base 
    add  HL, HL         ; 1:11      1603 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1603 *   256*L = 512x 
    add  HL, HL         ; 1:11      1603 *   0  *2 = 4x 
    add   A, L          ; 1:4       1603 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1603 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1603 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1603 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1603 *      +1 = 33x 
    add  HL, HL         ; 1:11      1603 *   1  *2 = 66x
    add  HL, BC         ; 1:11      1603 *      +1 = 67x 
    add   A, H          ; 1:4       1603 *
    ld    H, A          ; 1:4       1603 *     [1603x] = 67x + 1536x  
                        ;[14:112]   1605 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0100_0101)
    ld    B, H          ; 1:4       1605 *
    ld    C, L          ; 1:4       1605 *   1       1x = base 
    add  HL, HL         ; 1:11      1605 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1605 *   256*L = 512x 
    add  HL, HL         ; 1:11      1605 *   0  *2 = 4x 
    add   A, L          ; 1:4       1605 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1605 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1605 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1605 *      +1 = 17x 
    add  HL, HL         ; 1:11      1605 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1605 *   1  *2 = 68x
    add  HL, BC         ; 1:11      1605 *      +1 = 69x 
    add   A, H          ; 1:4       1605 *
    ld    H, A          ; 1:4       1605 *     [1605x] = 69x + 1536x  
                        ;[15:123]   1607 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0100_0111)
    ld    B, H          ; 1:4       1607 *
    ld    C, L          ; 1:4       1607 *   1       1x = base 
    add  HL, HL         ; 1:11      1607 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1607 *   256*L = 512x 
    add  HL, HL         ; 1:11      1607 *   0  *2 = 4x 
    add   A, L          ; 1:4       1607 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1607 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1607 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1607 *      +1 = 17x 
    add  HL, HL         ; 1:11      1607 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1607 *      +1 = 35x 
    add  HL, HL         ; 1:11      1607 *   1  *2 = 70x
    add  HL, BC         ; 1:11      1607 *      +1 = 71x 
    add   A, H          ; 1:4       1607 *
    ld    H, A          ; 1:4       1607 *     [1607x] = 71x + 1536x  
                        ;[14:112]   1609 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0100_1001)
    ld    B, H          ; 1:4       1609 *
    ld    C, L          ; 1:4       1609 *   1       1x = base 
    add  HL, HL         ; 1:11      1609 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1609 *   256*L = 512x 
    add  HL, HL         ; 1:11      1609 *   0  *2 = 4x 
    add   A, L          ; 1:4       1609 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1609 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1609 *      +1 = 9x 
    add  HL, HL         ; 1:11      1609 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1609 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1609 *   1  *2 = 72x
    add  HL, BC         ; 1:11      1609 *      +1 = 73x 
    add   A, H          ; 1:4       1609 *
    ld    H, A          ; 1:4       1609 *     [1609x] = 73x + 1536x  
                        ;[15:123]   1611 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0100_1011)
    ld    B, H          ; 1:4       1611 *
    ld    C, L          ; 1:4       1611 *   1       1x = base 
    add  HL, HL         ; 1:11      1611 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1611 *   256*L = 512x 
    add  HL, HL         ; 1:11      1611 *   0  *2 = 4x 
    add   A, L          ; 1:4       1611 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1611 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1611 *      +1 = 9x 
    add  HL, HL         ; 1:11      1611 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1611 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1611 *      +1 = 37x 
    add  HL, HL         ; 1:11      1611 *   1  *2 = 74x
    add  HL, BC         ; 1:11      1611 *      +1 = 75x 
    add   A, H          ; 1:4       1611 *
    ld    H, A          ; 1:4       1611 *     [1611x] = 75x + 1536x  
                        ;[15:123]   1613 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0100_1101)
    ld    B, H          ; 1:4       1613 *
    ld    C, L          ; 1:4       1613 *   1       1x = base 
    add  HL, HL         ; 1:11      1613 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1613 *   256*L = 512x 
    add  HL, HL         ; 1:11      1613 *   0  *2 = 4x 
    add   A, L          ; 1:4       1613 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1613 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1613 *      +1 = 9x 
    add  HL, HL         ; 1:11      1613 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1613 *      +1 = 19x 
    add  HL, HL         ; 1:11      1613 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1613 *   1  *2 = 76x
    add  HL, BC         ; 1:11      1613 *      +1 = 77x 
    add   A, H          ; 1:4       1613 *
    ld    H, A          ; 1:4       1613 *     [1613x] = 77x + 1536x 

                        ;[16:134]   1615 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0100_1111)
    ld    B, H          ; 1:4       1615 *
    ld    C, L          ; 1:4       1615 *   1       1x = base 
    add  HL, HL         ; 1:11      1615 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1615 *   256*L = 512x 
    add  HL, HL         ; 1:11      1615 *   0  *2 = 4x 
    add   A, L          ; 1:4       1615 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1615 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1615 *      +1 = 9x 
    add  HL, HL         ; 1:11      1615 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1615 *      +1 = 19x 
    add  HL, HL         ; 1:11      1615 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1615 *      +1 = 39x 
    add  HL, HL         ; 1:11      1615 *   1  *2 = 78x
    add  HL, BC         ; 1:11      1615 *      +1 = 79x 
    add   A, H          ; 1:4       1615 *
    ld    H, A          ; 1:4       1615 *     [1615x] = 79x + 1536x  
                        ;[14:112]   1617 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0101_0001)
    ld    B, H          ; 1:4       1617 *
    ld    C, L          ; 1:4       1617 *   1       1x = base 
    ld    A, L          ; 1:4       1617 *   256*L = 256x 
    add  HL, HL         ; 1:11      1617 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1617 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1617 *      +1 = 5x 
    add   A, L          ; 1:4       1617 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1617 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1617 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1617 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1617 *   1  *2 = 80x
    add  HL, BC         ; 1:11      1617 *      +1 = 81x 
    add   A, H          ; 1:4       1617 *
    ld    H, A          ; 1:4       1617 *     [1617x] = 81x + 1536x  
                        ;[15:123]   1619 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0101_0011)
    ld    B, H          ; 1:4       1619 *
    ld    C, L          ; 1:4       1619 *   1       1x = base 
    ld    A, L          ; 1:4       1619 *   256*L = 256x 
    add  HL, HL         ; 1:11      1619 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1619 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1619 *      +1 = 5x 
    add   A, L          ; 1:4       1619 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1619 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1619 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1619 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1619 *      +1 = 41x 
    add  HL, HL         ; 1:11      1619 *   1  *2 = 82x
    add  HL, BC         ; 1:11      1619 *      +1 = 83x 
    add   A, H          ; 1:4       1619 *
    ld    H, A          ; 1:4       1619 *     [1619x] = 83x + 1536x  
                        ;[15:123]   1621 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0101_0101)
    ld    B, H          ; 1:4       1621 *
    ld    C, L          ; 1:4       1621 *   1       1x = base 
    ld    A, L          ; 1:4       1621 *   256*L = 256x 
    add  HL, HL         ; 1:11      1621 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1621 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1621 *      +1 = 5x 
    add   A, L          ; 1:4       1621 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1621 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1621 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1621 *      +1 = 21x 
    add  HL, HL         ; 1:11      1621 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1621 *   1  *2 = 84x
    add  HL, BC         ; 1:11      1621 *      +1 = 85x 
    add   A, H          ; 1:4       1621 *
    ld    H, A          ; 1:4       1621 *     [1621x] = 85x + 1536x  
                        ;[16:134]   1623 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0101_0111)
    ld    B, H          ; 1:4       1623 *
    ld    C, L          ; 1:4       1623 *   1       1x = base 
    ld    A, L          ; 1:4       1623 *   256*L = 256x 
    add  HL, HL         ; 1:11      1623 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1623 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1623 *      +1 = 5x 
    add   A, L          ; 1:4       1623 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1623 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1623 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1623 *      +1 = 21x 
    add  HL, HL         ; 1:11      1623 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1623 *      +1 = 43x 
    add  HL, HL         ; 1:11      1623 *   1  *2 = 86x
    add  HL, BC         ; 1:11      1623 *      +1 = 87x 
    add   A, H          ; 1:4       1623 *
    ld    H, A          ; 1:4       1623 *     [1623x] = 87x + 1536x  
                        ;[15:123]   1625 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0101_1001)
    ld    B, H          ; 1:4       1625 *
    ld    C, L          ; 1:4       1625 *   1       1x = base 
    ld    A, L          ; 1:4       1625 *   256*L = 256x 
    add  HL, HL         ; 1:11      1625 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1625 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1625 *      +1 = 5x 
    add   A, L          ; 1:4       1625 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1625 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1625 *      +1 = 11x 
    add  HL, HL         ; 1:11      1625 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1625 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1625 *   1  *2 = 88x
    add  HL, BC         ; 1:11      1625 *      +1 = 89x 
    add   A, H          ; 1:4       1625 *
    ld    H, A          ; 1:4       1625 *     [1625x] = 89x + 1536x  
                        ;[16:134]   1627 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0101_1011)
    ld    B, H          ; 1:4       1627 *
    ld    C, L          ; 1:4       1627 *   1       1x = base 
    ld    A, L          ; 1:4       1627 *   256*L = 256x 
    add  HL, HL         ; 1:11      1627 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1627 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1627 *      +1 = 5x 
    add   A, L          ; 1:4       1627 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1627 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1627 *      +1 = 11x 
    add  HL, HL         ; 1:11      1627 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1627 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1627 *      +1 = 45x 
    add  HL, HL         ; 1:11      1627 *   1  *2 = 90x
    add  HL, BC         ; 1:11      1627 *      +1 = 91x 
    add   A, H          ; 1:4       1627 *
    ld    H, A          ; 1:4       1627 *     [1627x] = 91x + 1536x  
                        ;[16:134]   1629 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0101_1101)
    ld    B, H          ; 1:4       1629 *
    ld    C, L          ; 1:4       1629 *   1       1x = base 
    ld    A, L          ; 1:4       1629 *   256*L = 256x 
    add  HL, HL         ; 1:11      1629 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1629 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1629 *      +1 = 5x 
    add   A, L          ; 1:4       1629 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1629 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1629 *      +1 = 11x 
    add  HL, HL         ; 1:11      1629 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1629 *      +1 = 23x 
    add  HL, HL         ; 1:11      1629 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1629 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1629 *      +1 = 93x 
    add   A, H          ; 1:4       1629 *
    ld    H, A          ; 1:4       1629 *     [1629x] = 93x + 1536x  
                        ;[17:145]   1631 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0101_1111)
    ld    B, H          ; 1:4       1631 *
    ld    C, L          ; 1:4       1631 *   1       1x = base 
    ld    A, L          ; 1:4       1631 *   256*L = 256x 
    add  HL, HL         ; 1:11      1631 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1631 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1631 *      +1 = 5x 
    add   A, L          ; 1:4       1631 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1631 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1631 *      +1 = 11x 
    add  HL, HL         ; 1:11      1631 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1631 *      +1 = 23x 
    add  HL, HL         ; 1:11      1631 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1631 *      +1 = 47x 
    add  HL, HL         ; 1:11      1631 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1631 *      +1 = 95x 
    add   A, H          ; 1:4       1631 *
    ld    H, A          ; 1:4       1631 *     [1631x] = 95x + 1536x 

                        ;[13:108]   1633 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0110_0001)
    ld    B, H          ; 1:4       1633 *
    ld    C, L          ; 1:4       1633 *   1       1x = base 
    add  HL, HL         ; 1:11      1633 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1633 *      +1 = 3x 
    add  HL, HL         ; 1:11      1633 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1633 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1633 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1633 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1633 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1633 *   1  *2 = 96x
    add  HL, BC         ; 1:11      1633 *      +1 = 97x 
    add   A, H          ; 1:4       1633 *
    ld    H, A          ; 1:4       1633 *     [1633x] = 97x + 1536x  
                        ;[14:119]   1635 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0110_0011)
    ld    B, H          ; 1:4       1635 *
    ld    C, L          ; 1:4       1635 *   1       1x = base 
    add  HL, HL         ; 1:11      1635 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1635 *      +1 = 3x 
    add  HL, HL         ; 1:11      1635 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1635 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1635 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1635 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1635 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1635 *      +1 = 49x 
    add  HL, HL         ; 1:11      1635 *   1  *2 = 98x
    add  HL, BC         ; 1:11      1635 *      +1 = 99x 
    add   A, H          ; 1:4       1635 *
    ld    H, A          ; 1:4       1635 *     [1635x] = 99x + 1536x  
                        ;[14:119]   1637 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0110_0101)
    ld    B, H          ; 1:4       1637 *
    ld    C, L          ; 1:4       1637 *   1       1x = base 
    add  HL, HL         ; 1:11      1637 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1637 *      +1 = 3x 
    add  HL, HL         ; 1:11      1637 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1637 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1637 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1637 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1637 *      +1 = 25x 
    add  HL, HL         ; 1:11      1637 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1637 *   1  *2 = 100x
    add  HL, BC         ; 1:11      1637 *      +1 = 101x 
    add   A, H          ; 1:4       1637 *
    ld    H, A          ; 1:4       1637 *     [1637x] = 101x + 1536x  
                        ;[15:130]   1639 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0110_0111)
    ld    B, H          ; 1:4       1639 *
    ld    C, L          ; 1:4       1639 *   1       1x = base 
    add  HL, HL         ; 1:11      1639 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1639 *      +1 = 3x 
    add  HL, HL         ; 1:11      1639 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1639 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1639 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1639 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1639 *      +1 = 25x 
    add  HL, HL         ; 1:11      1639 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1639 *      +1 = 51x 
    add  HL, HL         ; 1:11      1639 *   1  *2 = 102x
    add  HL, BC         ; 1:11      1639 *      +1 = 103x 
    add   A, H          ; 1:4       1639 *
    ld    H, A          ; 1:4       1639 *     [1639x] = 103x + 1536x  
                        ;[14:119]   1641 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0110_1001)
    ld    B, H          ; 1:4       1641 *
    ld    C, L          ; 1:4       1641 *   1       1x = base 
    add  HL, HL         ; 1:11      1641 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1641 *      +1 = 3x 
    add  HL, HL         ; 1:11      1641 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1641 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1641 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1641 *      +1 = 13x 
    add  HL, HL         ; 1:11      1641 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1641 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      1641 *   1  *2 = 104x
    add  HL, BC         ; 1:11      1641 *      +1 = 105x 
    add   A, H          ; 1:4       1641 *
    ld    H, A          ; 1:4       1641 *     [1641x] = 105x + 1536x  
                        ;[15:130]   1643 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0110_1011)
    ld    B, H          ; 1:4       1643 *
    ld    C, L          ; 1:4       1643 *   1       1x = base 
    add  HL, HL         ; 1:11      1643 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1643 *      +1 = 3x 
    add  HL, HL         ; 1:11      1643 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1643 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1643 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1643 *      +1 = 13x 
    add  HL, HL         ; 1:11      1643 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1643 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1643 *      +1 = 53x 
    add  HL, HL         ; 1:11      1643 *   1  *2 = 106x
    add  HL, BC         ; 1:11      1643 *      +1 = 107x 
    add   A, H          ; 1:4       1643 *
    ld    H, A          ; 1:4       1643 *     [1643x] = 107x + 1536x  
                        ;[15:130]   1645 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0110_1101)
    ld    B, H          ; 1:4       1645 *
    ld    C, L          ; 1:4       1645 *   1       1x = base 
    add  HL, HL         ; 1:11      1645 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1645 *      +1 = 3x 
    add  HL, HL         ; 1:11      1645 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1645 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1645 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1645 *      +1 = 13x 
    add  HL, HL         ; 1:11      1645 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1645 *      +1 = 27x 
    add  HL, HL         ; 1:11      1645 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      1645 *   1  *2 = 108x
    add  HL, BC         ; 1:11      1645 *      +1 = 109x 
    add   A, H          ; 1:4       1645 *
    ld    H, A          ; 1:4       1645 *     [1645x] = 109x + 1536x  
                        ;[16:141]   1647 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0110_1111)
    ld    B, H          ; 1:4       1647 *
    ld    C, L          ; 1:4       1647 *   1       1x = base 
    add  HL, HL         ; 1:11      1647 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1647 *      +1 = 3x 
    add  HL, HL         ; 1:11      1647 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1647 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1647 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1647 *      +1 = 13x 
    add  HL, HL         ; 1:11      1647 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1647 *      +1 = 27x 
    add  HL, HL         ; 1:11      1647 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1647 *      +1 = 55x 
    add  HL, HL         ; 1:11      1647 *   1  *2 = 110x
    add  HL, BC         ; 1:11      1647 *      +1 = 111x 
    add   A, H          ; 1:4       1647 *
    ld    H, A          ; 1:4       1647 *     [1647x] = 111x + 1536x  
                        ;[14:119]   1649 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0111_0001)
    ld    B, H          ; 1:4       1649 *
    ld    C, L          ; 1:4       1649 *   1       1x = base 
    add  HL, HL         ; 1:11      1649 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1649 *      +1 = 3x 
    add  HL, HL         ; 1:11      1649 *   1  *2 = 6x
    ld    A, L          ; 1:4       1649 *   256*L = 1536x
    add  HL, BC         ; 1:11      1649 *      +1 = 7x 
    add  HL, HL         ; 1:11      1649 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1649 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1649 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      1649 *   1  *2 = 112x
    add  HL, BC         ; 1:11      1649 *      +1 = 113x 
    add   A, H          ; 1:4       1649 *
    ld    H, A          ; 1:4       1649 *     [1649x] = 113x + 1536x 

                        ;[15:130]   1651 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0111_0011)
    ld    B, H          ; 1:4       1651 *
    ld    C, L          ; 1:4       1651 *   1       1x = base 
    add  HL, HL         ; 1:11      1651 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1651 *      +1 = 3x 
    add  HL, HL         ; 1:11      1651 *   1  *2 = 6x
    ld    A, L          ; 1:4       1651 *   256*L = 1536x
    add  HL, BC         ; 1:11      1651 *      +1 = 7x 
    add  HL, HL         ; 1:11      1651 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1651 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1651 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1651 *      +1 = 57x 
    add  HL, HL         ; 1:11      1651 *   1  *2 = 114x
    add  HL, BC         ; 1:11      1651 *      +1 = 115x 
    add   A, H          ; 1:4       1651 *
    ld    H, A          ; 1:4       1651 *     [1651x] = 115x + 1536x  
                        ;[15:130]   1653 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0111_0101)
    ld    B, H          ; 1:4       1653 *
    ld    C, L          ; 1:4       1653 *   1       1x = base 
    add  HL, HL         ; 1:11      1653 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1653 *      +1 = 3x 
    add  HL, HL         ; 1:11      1653 *   1  *2 = 6x
    ld    A, L          ; 1:4       1653 *   256*L = 1536x
    add  HL, BC         ; 1:11      1653 *      +1 = 7x 
    add  HL, HL         ; 1:11      1653 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1653 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1653 *      +1 = 29x 
    add  HL, HL         ; 1:11      1653 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1653 *   1  *2 = 116x
    add  HL, BC         ; 1:11      1653 *      +1 = 117x 
    add   A, H          ; 1:4       1653 *
    ld    H, A          ; 1:4       1653 *     [1653x] = 117x + 1536x  
                        ;[16:141]   1655 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0111_0111)
    ld    B, H          ; 1:4       1655 *
    ld    C, L          ; 1:4       1655 *   1       1x = base 
    add  HL, HL         ; 1:11      1655 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1655 *      +1 = 3x 
    add  HL, HL         ; 1:11      1655 *   1  *2 = 6x
    ld    A, L          ; 1:4       1655 *   256*L = 1536x
    add  HL, BC         ; 1:11      1655 *      +1 = 7x 
    add  HL, HL         ; 1:11      1655 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1655 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1655 *      +1 = 29x 
    add  HL, HL         ; 1:11      1655 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1655 *      +1 = 59x 
    add  HL, HL         ; 1:11      1655 *   1  *2 = 118x
    add  HL, BC         ; 1:11      1655 *      +1 = 119x 
    add   A, H          ; 1:4       1655 *
    ld    H, A          ; 1:4       1655 *     [1655x] = 119x + 1536x  
                        ;[15:130]   1657 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0111_1001)
    ld    B, H          ; 1:4       1657 *
    ld    C, L          ; 1:4       1657 *   1       1x = base 
    add  HL, HL         ; 1:11      1657 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1657 *      +1 = 3x 
    add  HL, HL         ; 1:11      1657 *   1  *2 = 6x
    ld    A, L          ; 1:4       1657 *   256*L = 1536x
    add  HL, BC         ; 1:11      1657 *      +1 = 7x 
    add  HL, HL         ; 1:11      1657 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1657 *      +1 = 15x 
    add  HL, HL         ; 1:11      1657 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1657 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1657 *   1  *2 = 120x
    add  HL, BC         ; 1:11      1657 *      +1 = 121x 
    add   A, H          ; 1:4       1657 *
    ld    H, A          ; 1:4       1657 *     [1657x] = 121x + 1536x  
                        ;[16:141]   1659 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0111_1011)
    ld    B, H          ; 1:4       1659 *
    ld    C, L          ; 1:4       1659 *   1       1x = base 
    add  HL, HL         ; 1:11      1659 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1659 *      +1 = 3x 
    add  HL, HL         ; 1:11      1659 *   1  *2 = 6x
    ld    A, L          ; 1:4       1659 *   256*L = 1536x
    add  HL, BC         ; 1:11      1659 *      +1 = 7x 
    add  HL, HL         ; 1:11      1659 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1659 *      +1 = 15x 
    add  HL, HL         ; 1:11      1659 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1659 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1659 *      +1 = 61x 
    add  HL, HL         ; 1:11      1659 *   1  *2 = 122x
    add  HL, BC         ; 1:11      1659 *      +1 = 123x 
    add   A, H          ; 1:4       1659 *
    ld    H, A          ; 1:4       1659 *     [1659x] = 123x + 1536x  
                        ;[16:141]   1661 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0111_1101)
    ld    B, H          ; 1:4       1661 *
    ld    C, L          ; 1:4       1661 *   1       1x = base 
    add  HL, HL         ; 1:11      1661 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1661 *      +1 = 3x 
    add  HL, HL         ; 1:11      1661 *   1  *2 = 6x
    ld    A, L          ; 1:4       1661 *   256*L = 1536x
    add  HL, BC         ; 1:11      1661 *      +1 = 7x 
    add  HL, HL         ; 1:11      1661 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1661 *      +1 = 15x 
    add  HL, HL         ; 1:11      1661 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1661 *      +1 = 31x 
    add  HL, HL         ; 1:11      1661 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1661 *   1  *2 = 124x
    add  HL, BC         ; 1:11      1661 *      +1 = 125x 
    add   A, H          ; 1:4       1661 *
    ld    H, A          ; 1:4       1661 *     [1661x] = 125x + 1536x  
                        ;[17:152]   1663 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_0111_1111)
    ld    B, H          ; 1:4       1663 *
    ld    C, L          ; 1:4       1663 *   1       1x = base 
    add  HL, HL         ; 1:11      1663 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1663 *      +1 = 3x 
    add  HL, HL         ; 1:11      1663 *   1  *2 = 6x
    ld    A, L          ; 1:4       1663 *   256*L = 1536x
    add  HL, BC         ; 1:11      1663 *      +1 = 7x 
    add  HL, HL         ; 1:11      1663 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1663 *      +1 = 15x 
    add  HL, HL         ; 1:11      1663 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1663 *      +1 = 31x 
    add  HL, HL         ; 1:11      1663 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1663 *      +1 = 63x 
    add  HL, HL         ; 1:11      1663 *   1  *2 = 126x
    add  HL, BC         ; 1:11      1663 *      +1 = 127x 
    add   A, H          ; 1:4       1663 *
    ld    H, A          ; 1:4       1663 *     [1663x] = 127x + 1536x  
                        ;[14:112]   1665 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0110_1000_0001)  
    ld    B, H          ; 1:4       1665 *
    ld    C, L          ; 1:4       1665 *   [1x] 
    add  HL, HL         ; 1:11      1665 *   2x 
    ld    A, L          ; 1:4       1665 *   512x 
    add  HL, HL         ; 1:11      1665 *   4x 
    add   A, L          ; 1:4       1665 *   1536x 
    add  HL, HL         ; 1:11      1665 *   8x 
    add  HL, HL         ; 1:11      1665 *   16x 
    add  HL, HL         ; 1:11      1665 *   32x 
    add  HL, HL         ; 1:11      1665 *   64x 
    add  HL, HL         ; 1:11      1665 *   128x 
    add   A, B          ; 1:4       1665 *
    ld    B, A          ; 1:4       1665 *   [1537x] 
    add  HL, BC         ; 1:11      1665 *   [1665x] = 128x + 1537x   
                        ;[15:123]   1667 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1000_0011)
    ld    B, H          ; 1:4       1667 *
    ld    C, L          ; 1:4       1667 *   1       1x = base 
    add  HL, HL         ; 1:11      1667 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1667 *   256*L = 512x 
    add  HL, HL         ; 1:11      1667 *   0  *2 = 4x 
    add   A, L          ; 1:4       1667 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1667 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1667 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1667 *   0  *2 = 32x 
    add  HL, HL         ; 1:11      1667 *   1  *2 = 64x
    add  HL, BC         ; 1:11      1667 *      +1 = 65x 
    add  HL, HL         ; 1:11      1667 *   1  *2 = 130x
    add  HL, BC         ; 1:11      1667 *      +1 = 131x 
    add   A, H          ; 1:4       1667 *
    ld    H, A          ; 1:4       1667 *     [1667x] = 131x + 1536x 

                        ;[15:123]   1669 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1000_0101)
    ld    B, H          ; 1:4       1669 *
    ld    C, L          ; 1:4       1669 *   1       1x = base 
    add  HL, HL         ; 1:11      1669 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1669 *   256*L = 512x 
    add  HL, HL         ; 1:11      1669 *   0  *2 = 4x 
    add   A, L          ; 1:4       1669 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1669 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1669 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1669 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1669 *      +1 = 33x 
    add  HL, HL         ; 1:11      1669 *   0  *2 = 66x 
    add  HL, HL         ; 1:11      1669 *   1  *2 = 132x
    add  HL, BC         ; 1:11      1669 *      +1 = 133x 
    add   A, H          ; 1:4       1669 *
    ld    H, A          ; 1:4       1669 *     [1669x] = 133x + 1536x  
                        ;[16:134]   1671 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1000_0111)
    ld    B, H          ; 1:4       1671 *
    ld    C, L          ; 1:4       1671 *   1       1x = base 
    add  HL, HL         ; 1:11      1671 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1671 *   256*L = 512x 
    add  HL, HL         ; 1:11      1671 *   0  *2 = 4x 
    add   A, L          ; 1:4       1671 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1671 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1671 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1671 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1671 *      +1 = 33x 
    add  HL, HL         ; 1:11      1671 *   1  *2 = 66x
    add  HL, BC         ; 1:11      1671 *      +1 = 67x 
    add  HL, HL         ; 1:11      1671 *   1  *2 = 134x
    add  HL, BC         ; 1:11      1671 *      +1 = 135x 
    add   A, H          ; 1:4       1671 *
    ld    H, A          ; 1:4       1671 *     [1671x] = 135x + 1536x  
                        ;[15:123]   1673 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1000_1001)
    ld    B, H          ; 1:4       1673 *
    ld    C, L          ; 1:4       1673 *   1       1x = base 
    add  HL, HL         ; 1:11      1673 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1673 *   256*L = 512x 
    add  HL, HL         ; 1:11      1673 *   0  *2 = 4x 
    add   A, L          ; 1:4       1673 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1673 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1673 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1673 *      +1 = 17x 
    add  HL, HL         ; 1:11      1673 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1673 *   0  *2 = 68x 
    add  HL, HL         ; 1:11      1673 *   1  *2 = 136x
    add  HL, BC         ; 1:11      1673 *      +1 = 137x 
    add   A, H          ; 1:4       1673 *
    ld    H, A          ; 1:4       1673 *     [1673x] = 137x + 1536x  
                        ;[16:134]   1675 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1000_1011)
    ld    B, H          ; 1:4       1675 *
    ld    C, L          ; 1:4       1675 *   1       1x = base 
    add  HL, HL         ; 1:11      1675 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1675 *   256*L = 512x 
    add  HL, HL         ; 1:11      1675 *   0  *2 = 4x 
    add   A, L          ; 1:4       1675 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1675 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1675 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1675 *      +1 = 17x 
    add  HL, HL         ; 1:11      1675 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1675 *   1  *2 = 68x
    add  HL, BC         ; 1:11      1675 *      +1 = 69x 
    add  HL, HL         ; 1:11      1675 *   1  *2 = 138x
    add  HL, BC         ; 1:11      1675 *      +1 = 139x 
    add   A, H          ; 1:4       1675 *
    ld    H, A          ; 1:4       1675 *     [1675x] = 139x + 1536x  
                        ;[16:134]   1677 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1000_1101)
    ld    B, H          ; 1:4       1677 *
    ld    C, L          ; 1:4       1677 *   1       1x = base 
    add  HL, HL         ; 1:11      1677 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1677 *   256*L = 512x 
    add  HL, HL         ; 1:11      1677 *   0  *2 = 4x 
    add   A, L          ; 1:4       1677 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1677 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1677 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1677 *      +1 = 17x 
    add  HL, HL         ; 1:11      1677 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1677 *      +1 = 35x 
    add  HL, HL         ; 1:11      1677 *   0  *2 = 70x 
    add  HL, HL         ; 1:11      1677 *   1  *2 = 140x
    add  HL, BC         ; 1:11      1677 *      +1 = 141x 
    add   A, H          ; 1:4       1677 *
    ld    H, A          ; 1:4       1677 *     [1677x] = 141x + 1536x  
                        ;[17:145]   1679 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1000_1111)
    ld    B, H          ; 1:4       1679 *
    ld    C, L          ; 1:4       1679 *   1       1x = base 
    add  HL, HL         ; 1:11      1679 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1679 *   256*L = 512x 
    add  HL, HL         ; 1:11      1679 *   0  *2 = 4x 
    add   A, L          ; 1:4       1679 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1679 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1679 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1679 *      +1 = 17x 
    add  HL, HL         ; 1:11      1679 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1679 *      +1 = 35x 
    add  HL, HL         ; 1:11      1679 *   1  *2 = 70x
    add  HL, BC         ; 1:11      1679 *      +1 = 71x 
    add  HL, HL         ; 1:11      1679 *   1  *2 = 142x
    add  HL, BC         ; 1:11      1679 *      +1 = 143x 
    add   A, H          ; 1:4       1679 *
    ld    H, A          ; 1:4       1679 *     [1679x] = 143x + 1536x  
                        ;[15:123]   1681 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1001_0001)
    ld    B, H          ; 1:4       1681 *
    ld    C, L          ; 1:4       1681 *   1       1x = base 
    add  HL, HL         ; 1:11      1681 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1681 *   256*L = 512x 
    add  HL, HL         ; 1:11      1681 *   0  *2 = 4x 
    add   A, L          ; 1:4       1681 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1681 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1681 *      +1 = 9x 
    add  HL, HL         ; 1:11      1681 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1681 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1681 *   0  *2 = 72x 
    add  HL, HL         ; 1:11      1681 *   1  *2 = 144x
    add  HL, BC         ; 1:11      1681 *      +1 = 145x 
    add   A, H          ; 1:4       1681 *
    ld    H, A          ; 1:4       1681 *     [1681x] = 145x + 1536x  
                        ;[16:134]   1683 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1001_0011)
    ld    B, H          ; 1:4       1683 *
    ld    C, L          ; 1:4       1683 *   1       1x = base 
    add  HL, HL         ; 1:11      1683 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1683 *   256*L = 512x 
    add  HL, HL         ; 1:11      1683 *   0  *2 = 4x 
    add   A, L          ; 1:4       1683 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1683 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1683 *      +1 = 9x 
    add  HL, HL         ; 1:11      1683 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1683 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1683 *   1  *2 = 72x
    add  HL, BC         ; 1:11      1683 *      +1 = 73x 
    add  HL, HL         ; 1:11      1683 *   1  *2 = 146x
    add  HL, BC         ; 1:11      1683 *      +1 = 147x 
    add   A, H          ; 1:4       1683 *
    ld    H, A          ; 1:4       1683 *     [1683x] = 147x + 1536x  
                        ;[16:134]   1685 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1001_0101)
    ld    B, H          ; 1:4       1685 *
    ld    C, L          ; 1:4       1685 *   1       1x = base 
    add  HL, HL         ; 1:11      1685 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1685 *   256*L = 512x 
    add  HL, HL         ; 1:11      1685 *   0  *2 = 4x 
    add   A, L          ; 1:4       1685 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1685 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1685 *      +1 = 9x 
    add  HL, HL         ; 1:11      1685 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1685 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1685 *      +1 = 37x 
    add  HL, HL         ; 1:11      1685 *   0  *2 = 74x 
    add  HL, HL         ; 1:11      1685 *   1  *2 = 148x
    add  HL, BC         ; 1:11      1685 *      +1 = 149x 
    add   A, H          ; 1:4       1685 *
    ld    H, A          ; 1:4       1685 *     [1685x] = 149x + 1536x 

                        ;[17:145]   1687 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1001_0111)
    ld    B, H          ; 1:4       1687 *
    ld    C, L          ; 1:4       1687 *   1       1x = base 
    add  HL, HL         ; 1:11      1687 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1687 *   256*L = 512x 
    add  HL, HL         ; 1:11      1687 *   0  *2 = 4x 
    add   A, L          ; 1:4       1687 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1687 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1687 *      +1 = 9x 
    add  HL, HL         ; 1:11      1687 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1687 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1687 *      +1 = 37x 
    add  HL, HL         ; 1:11      1687 *   1  *2 = 74x
    add  HL, BC         ; 1:11      1687 *      +1 = 75x 
    add  HL, HL         ; 1:11      1687 *   1  *2 = 150x
    add  HL, BC         ; 1:11      1687 *      +1 = 151x 
    add   A, H          ; 1:4       1687 *
    ld    H, A          ; 1:4       1687 *     [1687x] = 151x + 1536x  
                        ;[16:134]   1689 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1001_1001)
    ld    B, H          ; 1:4       1689 *
    ld    C, L          ; 1:4       1689 *   1       1x = base 
    add  HL, HL         ; 1:11      1689 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1689 *   256*L = 512x 
    add  HL, HL         ; 1:11      1689 *   0  *2 = 4x 
    add   A, L          ; 1:4       1689 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1689 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1689 *      +1 = 9x 
    add  HL, HL         ; 1:11      1689 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1689 *      +1 = 19x 
    add  HL, HL         ; 1:11      1689 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1689 *   0  *2 = 76x 
    add  HL, HL         ; 1:11      1689 *   1  *2 = 152x
    add  HL, BC         ; 1:11      1689 *      +1 = 153x 
    add   A, H          ; 1:4       1689 *
    ld    H, A          ; 1:4       1689 *     [1689x] = 153x + 1536x  
                        ;[17:145]   1691 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1001_1011)
    ld    B, H          ; 1:4       1691 *
    ld    C, L          ; 1:4       1691 *   1       1x = base 
    add  HL, HL         ; 1:11      1691 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1691 *   256*L = 512x 
    add  HL, HL         ; 1:11      1691 *   0  *2 = 4x 
    add   A, L          ; 1:4       1691 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1691 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1691 *      +1 = 9x 
    add  HL, HL         ; 1:11      1691 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1691 *      +1 = 19x 
    add  HL, HL         ; 1:11      1691 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1691 *   1  *2 = 76x
    add  HL, BC         ; 1:11      1691 *      +1 = 77x 
    add  HL, HL         ; 1:11      1691 *   1  *2 = 154x
    add  HL, BC         ; 1:11      1691 *      +1 = 155x 
    add   A, H          ; 1:4       1691 *
    ld    H, A          ; 1:4       1691 *     [1691x] = 155x + 1536x  
                        ;[17:145]   1693 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1001_1101)
    ld    B, H          ; 1:4       1693 *
    ld    C, L          ; 1:4       1693 *   1       1x = base 
    add  HL, HL         ; 1:11      1693 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1693 *   256*L = 512x 
    add  HL, HL         ; 1:11      1693 *   0  *2 = 4x 
    add   A, L          ; 1:4       1693 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1693 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1693 *      +1 = 9x 
    add  HL, HL         ; 1:11      1693 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1693 *      +1 = 19x 
    add  HL, HL         ; 1:11      1693 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1693 *      +1 = 39x 
    add  HL, HL         ; 1:11      1693 *   0  *2 = 78x 
    add  HL, HL         ; 1:11      1693 *   1  *2 = 156x
    add  HL, BC         ; 1:11      1693 *      +1 = 157x 
    add   A, H          ; 1:4       1693 *
    ld    H, A          ; 1:4       1693 *     [1693x] = 157x + 1536x  
                        ;[18:156]   1695 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1001_1111)
    ld    B, H          ; 1:4       1695 *
    ld    C, L          ; 1:4       1695 *   1       1x = base 
    add  HL, HL         ; 1:11      1695 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1695 *   256*L = 512x 
    add  HL, HL         ; 1:11      1695 *   0  *2 = 4x 
    add   A, L          ; 1:4       1695 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1695 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1695 *      +1 = 9x 
    add  HL, HL         ; 1:11      1695 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1695 *      +1 = 19x 
    add  HL, HL         ; 1:11      1695 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1695 *      +1 = 39x 
    add  HL, HL         ; 1:11      1695 *   1  *2 = 78x
    add  HL, BC         ; 1:11      1695 *      +1 = 79x 
    add  HL, HL         ; 1:11      1695 *   1  *2 = 158x
    add  HL, BC         ; 1:11      1695 *      +1 = 159x 
    add   A, H          ; 1:4       1695 *
    ld    H, A          ; 1:4       1695 *     [1695x] = 159x + 1536x  
                        ;[15:123]   1697 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1010_0001)
    ld    B, H          ; 1:4       1697 *
    ld    C, L          ; 1:4       1697 *   1       1x = base 
    ld    A, L          ; 1:4       1697 *   256*L = 256x 
    add  HL, HL         ; 1:11      1697 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1697 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1697 *      +1 = 5x 
    add   A, L          ; 1:4       1697 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1697 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1697 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1697 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1697 *   0  *2 = 80x 
    add  HL, HL         ; 1:11      1697 *   1  *2 = 160x
    add  HL, BC         ; 1:11      1697 *      +1 = 161x 
    add   A, H          ; 1:4       1697 *
    ld    H, A          ; 1:4       1697 *     [1697x] = 161x + 1536x  
                        ;[16:134]   1699 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1010_0011)
    ld    B, H          ; 1:4       1699 *
    ld    C, L          ; 1:4       1699 *   1       1x = base 
    ld    A, L          ; 1:4       1699 *   256*L = 256x 
    add  HL, HL         ; 1:11      1699 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1699 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1699 *      +1 = 5x 
    add   A, L          ; 1:4       1699 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1699 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1699 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1699 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1699 *   1  *2 = 80x
    add  HL, BC         ; 1:11      1699 *      +1 = 81x 
    add  HL, HL         ; 1:11      1699 *   1  *2 = 162x
    add  HL, BC         ; 1:11      1699 *      +1 = 163x 
    add   A, H          ; 1:4       1699 *
    ld    H, A          ; 1:4       1699 *     [1699x] = 163x + 1536x  
                        ;[16:134]   1701 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1010_0101)
    ld    B, H          ; 1:4       1701 *
    ld    C, L          ; 1:4       1701 *   1       1x = base 
    ld    A, L          ; 1:4       1701 *   256*L = 256x 
    add  HL, HL         ; 1:11      1701 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1701 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1701 *      +1 = 5x 
    add   A, L          ; 1:4       1701 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1701 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1701 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1701 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1701 *      +1 = 41x 
    add  HL, HL         ; 1:11      1701 *   0  *2 = 82x 
    add  HL, HL         ; 1:11      1701 *   1  *2 = 164x
    add  HL, BC         ; 1:11      1701 *      +1 = 165x 
    add   A, H          ; 1:4       1701 *
    ld    H, A          ; 1:4       1701 *     [1701x] = 165x + 1536x  
                        ;[17:145]   1703 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1010_0111)
    ld    B, H          ; 1:4       1703 *
    ld    C, L          ; 1:4       1703 *   1       1x = base 
    ld    A, L          ; 1:4       1703 *   256*L = 256x 
    add  HL, HL         ; 1:11      1703 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1703 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1703 *      +1 = 5x 
    add   A, L          ; 1:4       1703 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1703 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1703 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1703 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1703 *      +1 = 41x 
    add  HL, HL         ; 1:11      1703 *   1  *2 = 82x
    add  HL, BC         ; 1:11      1703 *      +1 = 83x 
    add  HL, HL         ; 1:11      1703 *   1  *2 = 166x
    add  HL, BC         ; 1:11      1703 *      +1 = 167x 
    add   A, H          ; 1:4       1703 *
    ld    H, A          ; 1:4       1703 *     [1703x] = 167x + 1536x 

                        ;[16:134]   1705 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1010_1001)
    ld    B, H          ; 1:4       1705 *
    ld    C, L          ; 1:4       1705 *   1       1x = base 
    ld    A, L          ; 1:4       1705 *   256*L = 256x 
    add  HL, HL         ; 1:11      1705 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1705 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1705 *      +1 = 5x 
    add   A, L          ; 1:4       1705 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1705 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1705 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1705 *      +1 = 21x 
    add  HL, HL         ; 1:11      1705 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1705 *   0  *2 = 84x 
    add  HL, HL         ; 1:11      1705 *   1  *2 = 168x
    add  HL, BC         ; 1:11      1705 *      +1 = 169x 
    add   A, H          ; 1:4       1705 *
    ld    H, A          ; 1:4       1705 *     [1705x] = 169x + 1536x  
                        ;[17:145]   1707 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1010_1011)
    ld    B, H          ; 1:4       1707 *
    ld    C, L          ; 1:4       1707 *   1       1x = base 
    ld    A, L          ; 1:4       1707 *   256*L = 256x 
    add  HL, HL         ; 1:11      1707 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1707 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1707 *      +1 = 5x 
    add   A, L          ; 1:4       1707 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1707 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1707 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1707 *      +1 = 21x 
    add  HL, HL         ; 1:11      1707 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1707 *   1  *2 = 84x
    add  HL, BC         ; 1:11      1707 *      +1 = 85x 
    add  HL, HL         ; 1:11      1707 *   1  *2 = 170x
    add  HL, BC         ; 1:11      1707 *      +1 = 171x 
    add   A, H          ; 1:4       1707 *
    ld    H, A          ; 1:4       1707 *     [1707x] = 171x + 1536x  
                        ;[17:145]   1709 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1010_1101)
    ld    B, H          ; 1:4       1709 *
    ld    C, L          ; 1:4       1709 *   1       1x = base 
    ld    A, L          ; 1:4       1709 *   256*L = 256x 
    add  HL, HL         ; 1:11      1709 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1709 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1709 *      +1 = 5x 
    add   A, L          ; 1:4       1709 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1709 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1709 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1709 *      +1 = 21x 
    add  HL, HL         ; 1:11      1709 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1709 *      +1 = 43x 
    add  HL, HL         ; 1:11      1709 *   0  *2 = 86x 
    add  HL, HL         ; 1:11      1709 *   1  *2 = 172x
    add  HL, BC         ; 1:11      1709 *      +1 = 173x 
    add   A, H          ; 1:4       1709 *
    ld    H, A          ; 1:4       1709 *     [1709x] = 173x + 1536x  
                        ;[18:156]   1711 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1010_1111)
    ld    B, H          ; 1:4       1711 *
    ld    C, L          ; 1:4       1711 *   1       1x = base 
    ld    A, L          ; 1:4       1711 *   256*L = 256x 
    add  HL, HL         ; 1:11      1711 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1711 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1711 *      +1 = 5x 
    add   A, L          ; 1:4       1711 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1711 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1711 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1711 *      +1 = 21x 
    add  HL, HL         ; 1:11      1711 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1711 *      +1 = 43x 
    add  HL, HL         ; 1:11      1711 *   1  *2 = 86x
    add  HL, BC         ; 1:11      1711 *      +1 = 87x 
    add  HL, HL         ; 1:11      1711 *   1  *2 = 174x
    add  HL, BC         ; 1:11      1711 *      +1 = 175x 
    add   A, H          ; 1:4       1711 *
    ld    H, A          ; 1:4       1711 *     [1711x] = 175x + 1536x  
                        ;[16:134]   1713 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1011_0001)
    ld    B, H          ; 1:4       1713 *
    ld    C, L          ; 1:4       1713 *   1       1x = base 
    ld    A, L          ; 1:4       1713 *   256*L = 256x 
    add  HL, HL         ; 1:11      1713 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1713 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1713 *      +1 = 5x 
    add   A, L          ; 1:4       1713 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1713 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1713 *      +1 = 11x 
    add  HL, HL         ; 1:11      1713 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1713 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1713 *   0  *2 = 88x 
    add  HL, HL         ; 1:11      1713 *   1  *2 = 176x
    add  HL, BC         ; 1:11      1713 *      +1 = 177x 
    add   A, H          ; 1:4       1713 *
    ld    H, A          ; 1:4       1713 *     [1713x] = 177x + 1536x  
                        ;[17:145]   1715 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1011_0011)
    ld    B, H          ; 1:4       1715 *
    ld    C, L          ; 1:4       1715 *   1       1x = base 
    ld    A, L          ; 1:4       1715 *   256*L = 256x 
    add  HL, HL         ; 1:11      1715 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1715 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1715 *      +1 = 5x 
    add   A, L          ; 1:4       1715 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1715 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1715 *      +1 = 11x 
    add  HL, HL         ; 1:11      1715 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1715 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1715 *   1  *2 = 88x
    add  HL, BC         ; 1:11      1715 *      +1 = 89x 
    add  HL, HL         ; 1:11      1715 *   1  *2 = 178x
    add  HL, BC         ; 1:11      1715 *      +1 = 179x 
    add   A, H          ; 1:4       1715 *
    ld    H, A          ; 1:4       1715 *     [1715x] = 179x + 1536x  
                        ;[17:145]   1717 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1011_0101)
    ld    B, H          ; 1:4       1717 *
    ld    C, L          ; 1:4       1717 *   1       1x = base 
    ld    A, L          ; 1:4       1717 *   256*L = 256x 
    add  HL, HL         ; 1:11      1717 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1717 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1717 *      +1 = 5x 
    add   A, L          ; 1:4       1717 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1717 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1717 *      +1 = 11x 
    add  HL, HL         ; 1:11      1717 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1717 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1717 *      +1 = 45x 
    add  HL, HL         ; 1:11      1717 *   0  *2 = 90x 
    add  HL, HL         ; 1:11      1717 *   1  *2 = 180x
    add  HL, BC         ; 1:11      1717 *      +1 = 181x 
    add   A, H          ; 1:4       1717 *
    ld    H, A          ; 1:4       1717 *     [1717x] = 181x + 1536x  
                        ;[18:156]   1719 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1011_0111)
    ld    B, H          ; 1:4       1719 *
    ld    C, L          ; 1:4       1719 *   1       1x = base 
    ld    A, L          ; 1:4       1719 *   256*L = 256x 
    add  HL, HL         ; 1:11      1719 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1719 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1719 *      +1 = 5x 
    add   A, L          ; 1:4       1719 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1719 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1719 *      +1 = 11x 
    add  HL, HL         ; 1:11      1719 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1719 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1719 *      +1 = 45x 
    add  HL, HL         ; 1:11      1719 *   1  *2 = 90x
    add  HL, BC         ; 1:11      1719 *      +1 = 91x 
    add  HL, HL         ; 1:11      1719 *   1  *2 = 182x
    add  HL, BC         ; 1:11      1719 *      +1 = 183x 
    add   A, H          ; 1:4       1719 *
    ld    H, A          ; 1:4       1719 *     [1719x] = 183x + 1536x  
                        ;[17:145]   1721 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1011_1001)
    ld    B, H          ; 1:4       1721 *
    ld    C, L          ; 1:4       1721 *   1       1x = base 
    ld    A, L          ; 1:4       1721 *   256*L = 256x 
    add  HL, HL         ; 1:11      1721 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1721 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1721 *      +1 = 5x 
    add   A, L          ; 1:4       1721 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1721 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1721 *      +1 = 11x 
    add  HL, HL         ; 1:11      1721 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1721 *      +1 = 23x 
    add  HL, HL         ; 1:11      1721 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1721 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1721 *   1  *2 = 184x
    add  HL, BC         ; 1:11      1721 *      +1 = 185x 
    add   A, H          ; 1:4       1721 *
    ld    H, A          ; 1:4       1721 *     [1721x] = 185x + 1536x 

                        ;[18:156]   1723 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1011_1011)
    ld    B, H          ; 1:4       1723 *
    ld    C, L          ; 1:4       1723 *   1       1x = base 
    ld    A, L          ; 1:4       1723 *   256*L = 256x 
    add  HL, HL         ; 1:11      1723 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1723 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1723 *      +1 = 5x 
    add   A, L          ; 1:4       1723 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1723 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1723 *      +1 = 11x 
    add  HL, HL         ; 1:11      1723 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1723 *      +1 = 23x 
    add  HL, HL         ; 1:11      1723 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1723 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1723 *      +1 = 93x 
    add  HL, HL         ; 1:11      1723 *   1  *2 = 186x
    add  HL, BC         ; 1:11      1723 *      +1 = 187x 
    add   A, H          ; 1:4       1723 *
    ld    H, A          ; 1:4       1723 *     [1723x] = 187x + 1536x  
                        ;[18:156]   1725 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1011_1101)
    ld    B, H          ; 1:4       1725 *
    ld    C, L          ; 1:4       1725 *   1       1x = base 
    ld    A, L          ; 1:4       1725 *   256*L = 256x 
    add  HL, HL         ; 1:11      1725 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1725 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1725 *      +1 = 5x 
    add   A, L          ; 1:4       1725 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1725 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1725 *      +1 = 11x 
    add  HL, HL         ; 1:11      1725 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1725 *      +1 = 23x 
    add  HL, HL         ; 1:11      1725 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1725 *      +1 = 47x 
    add  HL, HL         ; 1:11      1725 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1725 *   1  *2 = 188x
    add  HL, BC         ; 1:11      1725 *      +1 = 189x 
    add   A, H          ; 1:4       1725 *
    ld    H, A          ; 1:4       1725 *     [1725x] = 189x + 1536x  
                        ;[19:167]   1727 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1011_1111)
    ld    B, H          ; 1:4       1727 *
    ld    C, L          ; 1:4       1727 *   1       1x = base 
    ld    A, L          ; 1:4       1727 *   256*L = 256x 
    add  HL, HL         ; 1:11      1727 *   0  *2 = 2x 
    add  HL, HL         ; 1:11      1727 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1727 *      +1 = 5x 
    add   A, L          ; 1:4       1727 *  +256*L = 1536x 
    add  HL, HL         ; 1:11      1727 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1727 *      +1 = 11x 
    add  HL, HL         ; 1:11      1727 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1727 *      +1 = 23x 
    add  HL, HL         ; 1:11      1727 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1727 *      +1 = 47x 
    add  HL, HL         ; 1:11      1727 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1727 *      +1 = 95x 
    add  HL, HL         ; 1:11      1727 *   1  *2 = 190x
    add  HL, BC         ; 1:11      1727 *      +1 = 191x 
    add   A, H          ; 1:4       1727 *
    ld    H, A          ; 1:4       1727 *     [1727x] = 191x + 1536x  
                        ;[14:119]   1729 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1100_0001)
    ld    B, H          ; 1:4       1729 *
    ld    C, L          ; 1:4       1729 *   1       1x = base 
    add  HL, HL         ; 1:11      1729 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1729 *      +1 = 3x 
    add  HL, HL         ; 1:11      1729 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1729 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1729 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1729 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1729 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1729 *   0  *2 = 96x 
    add  HL, HL         ; 1:11      1729 *   1  *2 = 192x
    add  HL, BC         ; 1:11      1729 *      +1 = 193x 
    add   A, H          ; 1:4       1729 *
    ld    H, A          ; 1:4       1729 *     [1729x] = 193x + 1536x  
                        ;[15:130]   1731 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1100_0011)
    ld    B, H          ; 1:4       1731 *
    ld    C, L          ; 1:4       1731 *   1       1x = base 
    add  HL, HL         ; 1:11      1731 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1731 *      +1 = 3x 
    add  HL, HL         ; 1:11      1731 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1731 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1731 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1731 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1731 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1731 *   1  *2 = 96x
    add  HL, BC         ; 1:11      1731 *      +1 = 97x 
    add  HL, HL         ; 1:11      1731 *   1  *2 = 194x
    add  HL, BC         ; 1:11      1731 *      +1 = 195x 
    add   A, H          ; 1:4       1731 *
    ld    H, A          ; 1:4       1731 *     [1731x] = 195x + 1536x  
                        ;[15:130]   1733 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1100_0101)
    ld    B, H          ; 1:4       1733 *
    ld    C, L          ; 1:4       1733 *   1       1x = base 
    add  HL, HL         ; 1:11      1733 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1733 *      +1 = 3x 
    add  HL, HL         ; 1:11      1733 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1733 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1733 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1733 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1733 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1733 *      +1 = 49x 
    add  HL, HL         ; 1:11      1733 *   0  *2 = 98x 
    add  HL, HL         ; 1:11      1733 *   1  *2 = 196x
    add  HL, BC         ; 1:11      1733 *      +1 = 197x 
    add   A, H          ; 1:4       1733 *
    ld    H, A          ; 1:4       1733 *     [1733x] = 197x + 1536x  
                        ;[16:141]   1735 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1100_0111)
    ld    B, H          ; 1:4       1735 *
    ld    C, L          ; 1:4       1735 *   1       1x = base 
    add  HL, HL         ; 1:11      1735 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1735 *      +1 = 3x 
    add  HL, HL         ; 1:11      1735 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1735 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1735 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1735 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1735 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1735 *      +1 = 49x 
    add  HL, HL         ; 1:11      1735 *   1  *2 = 98x
    add  HL, BC         ; 1:11      1735 *      +1 = 99x 
    add  HL, HL         ; 1:11      1735 *   1  *2 = 198x
    add  HL, BC         ; 1:11      1735 *      +1 = 199x 
    add   A, H          ; 1:4       1735 *
    ld    H, A          ; 1:4       1735 *     [1735x] = 199x + 1536x  
                        ;[15:130]   1737 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1100_1001)
    ld    B, H          ; 1:4       1737 *
    ld    C, L          ; 1:4       1737 *   1       1x = base 
    add  HL, HL         ; 1:11      1737 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1737 *      +1 = 3x 
    add  HL, HL         ; 1:11      1737 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1737 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1737 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1737 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1737 *      +1 = 25x 
    add  HL, HL         ; 1:11      1737 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1737 *   0  *2 = 100x 
    add  HL, HL         ; 1:11      1737 *   1  *2 = 200x
    add  HL, BC         ; 1:11      1737 *      +1 = 201x 
    add   A, H          ; 1:4       1737 *
    ld    H, A          ; 1:4       1737 *     [1737x] = 201x + 1536x  
                        ;[16:141]   1739 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1100_1011)
    ld    B, H          ; 1:4       1739 *
    ld    C, L          ; 1:4       1739 *   1       1x = base 
    add  HL, HL         ; 1:11      1739 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1739 *      +1 = 3x 
    add  HL, HL         ; 1:11      1739 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1739 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1739 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1739 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1739 *      +1 = 25x 
    add  HL, HL         ; 1:11      1739 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1739 *   1  *2 = 100x
    add  HL, BC         ; 1:11      1739 *      +1 = 101x 
    add  HL, HL         ; 1:11      1739 *   1  *2 = 202x
    add  HL, BC         ; 1:11      1739 *      +1 = 203x 
    add   A, H          ; 1:4       1739 *
    ld    H, A          ; 1:4       1739 *     [1739x] = 203x + 1536x 

                        ;[16:141]   1741 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1100_1101)
    ld    B, H          ; 1:4       1741 *
    ld    C, L          ; 1:4       1741 *   1       1x = base 
    add  HL, HL         ; 1:11      1741 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1741 *      +1 = 3x 
    add  HL, HL         ; 1:11      1741 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1741 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1741 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1741 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1741 *      +1 = 25x 
    add  HL, HL         ; 1:11      1741 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1741 *      +1 = 51x 
    add  HL, HL         ; 1:11      1741 *   0  *2 = 102x 
    add  HL, HL         ; 1:11      1741 *   1  *2 = 204x
    add  HL, BC         ; 1:11      1741 *      +1 = 205x 
    add   A, H          ; 1:4       1741 *
    ld    H, A          ; 1:4       1741 *     [1741x] = 205x + 1536x  
                        ;[17:152]   1743 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1100_1111)
    ld    B, H          ; 1:4       1743 *
    ld    C, L          ; 1:4       1743 *   1       1x = base 
    add  HL, HL         ; 1:11      1743 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1743 *      +1 = 3x 
    add  HL, HL         ; 1:11      1743 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1743 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1743 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1743 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1743 *      +1 = 25x 
    add  HL, HL         ; 1:11      1743 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1743 *      +1 = 51x 
    add  HL, HL         ; 1:11      1743 *   1  *2 = 102x
    add  HL, BC         ; 1:11      1743 *      +1 = 103x 
    add  HL, HL         ; 1:11      1743 *   1  *2 = 206x
    add  HL, BC         ; 1:11      1743 *      +1 = 207x 
    add   A, H          ; 1:4       1743 *
    ld    H, A          ; 1:4       1743 *     [1743x] = 207x + 1536x  
                        ;[15:130]   1745 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1101_0001)
    ld    B, H          ; 1:4       1745 *
    ld    C, L          ; 1:4       1745 *   1       1x = base 
    add  HL, HL         ; 1:11      1745 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1745 *      +1 = 3x 
    add  HL, HL         ; 1:11      1745 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1745 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1745 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1745 *      +1 = 13x 
    add  HL, HL         ; 1:11      1745 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1745 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      1745 *   0  *2 = 104x 
    add  HL, HL         ; 1:11      1745 *   1  *2 = 208x
    add  HL, BC         ; 1:11      1745 *      +1 = 209x 
    add   A, H          ; 1:4       1745 *
    ld    H, A          ; 1:4       1745 *     [1745x] = 209x + 1536x  
                        ;[16:141]   1747 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1101_0011)
    ld    B, H          ; 1:4       1747 *
    ld    C, L          ; 1:4       1747 *   1       1x = base 
    add  HL, HL         ; 1:11      1747 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1747 *      +1 = 3x 
    add  HL, HL         ; 1:11      1747 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1747 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1747 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1747 *      +1 = 13x 
    add  HL, HL         ; 1:11      1747 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1747 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      1747 *   1  *2 = 104x
    add  HL, BC         ; 1:11      1747 *      +1 = 105x 
    add  HL, HL         ; 1:11      1747 *   1  *2 = 210x
    add  HL, BC         ; 1:11      1747 *      +1 = 211x 
    add   A, H          ; 1:4       1747 *
    ld    H, A          ; 1:4       1747 *     [1747x] = 211x + 1536x  
                        ;[16:141]   1749 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1101_0101)
    ld    B, H          ; 1:4       1749 *
    ld    C, L          ; 1:4       1749 *   1       1x = base 
    add  HL, HL         ; 1:11      1749 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1749 *      +1 = 3x 
    add  HL, HL         ; 1:11      1749 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1749 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1749 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1749 *      +1 = 13x 
    add  HL, HL         ; 1:11      1749 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1749 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1749 *      +1 = 53x 
    add  HL, HL         ; 1:11      1749 *   0  *2 = 106x 
    add  HL, HL         ; 1:11      1749 *   1  *2 = 212x
    add  HL, BC         ; 1:11      1749 *      +1 = 213x 
    add   A, H          ; 1:4       1749 *
    ld    H, A          ; 1:4       1749 *     [1749x] = 213x + 1536x  
                        ;[17:152]   1751 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1101_0111)
    ld    B, H          ; 1:4       1751 *
    ld    C, L          ; 1:4       1751 *   1       1x = base 
    add  HL, HL         ; 1:11      1751 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1751 *      +1 = 3x 
    add  HL, HL         ; 1:11      1751 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1751 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1751 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1751 *      +1 = 13x 
    add  HL, HL         ; 1:11      1751 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1751 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1751 *      +1 = 53x 
    add  HL, HL         ; 1:11      1751 *   1  *2 = 106x
    add  HL, BC         ; 1:11      1751 *      +1 = 107x 
    add  HL, HL         ; 1:11      1751 *   1  *2 = 214x
    add  HL, BC         ; 1:11      1751 *      +1 = 215x 
    add   A, H          ; 1:4       1751 *
    ld    H, A          ; 1:4       1751 *     [1751x] = 215x + 1536x  
                        ;[16:141]   1753 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1101_1001)
    ld    B, H          ; 1:4       1753 *
    ld    C, L          ; 1:4       1753 *   1       1x = base 
    add  HL, HL         ; 1:11      1753 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1753 *      +1 = 3x 
    add  HL, HL         ; 1:11      1753 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1753 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1753 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1753 *      +1 = 13x 
    add  HL, HL         ; 1:11      1753 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1753 *      +1 = 27x 
    add  HL, HL         ; 1:11      1753 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      1753 *   0  *2 = 108x 
    add  HL, HL         ; 1:11      1753 *   1  *2 = 216x
    add  HL, BC         ; 1:11      1753 *      +1 = 217x 
    add   A, H          ; 1:4       1753 *
    ld    H, A          ; 1:4       1753 *     [1753x] = 217x + 1536x  
                        ;[17:152]   1755 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1101_1011)
    ld    B, H          ; 1:4       1755 *
    ld    C, L          ; 1:4       1755 *   1       1x = base 
    add  HL, HL         ; 1:11      1755 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1755 *      +1 = 3x 
    add  HL, HL         ; 1:11      1755 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1755 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1755 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1755 *      +1 = 13x 
    add  HL, HL         ; 1:11      1755 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1755 *      +1 = 27x 
    add  HL, HL         ; 1:11      1755 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      1755 *   1  *2 = 108x
    add  HL, BC         ; 1:11      1755 *      +1 = 109x 
    add  HL, HL         ; 1:11      1755 *   1  *2 = 218x
    add  HL, BC         ; 1:11      1755 *      +1 = 219x 
    add   A, H          ; 1:4       1755 *
    ld    H, A          ; 1:4       1755 *     [1755x] = 219x + 1536x  
                        ;[17:152]   1757 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1101_1101)
    ld    B, H          ; 1:4       1757 *
    ld    C, L          ; 1:4       1757 *   1       1x = base 
    add  HL, HL         ; 1:11      1757 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1757 *      +1 = 3x 
    add  HL, HL         ; 1:11      1757 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1757 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1757 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1757 *      +1 = 13x 
    add  HL, HL         ; 1:11      1757 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1757 *      +1 = 27x 
    add  HL, HL         ; 1:11      1757 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1757 *      +1 = 55x 
    add  HL, HL         ; 1:11      1757 *   0  *2 = 110x 
    add  HL, HL         ; 1:11      1757 *   1  *2 = 220x
    add  HL, BC         ; 1:11      1757 *      +1 = 221x 
    add   A, H          ; 1:4       1757 *
    ld    H, A          ; 1:4       1757 *     [1757x] = 221x + 1536x 

                        ;[18:163]   1759 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1101_1111)
    ld    B, H          ; 1:4       1759 *
    ld    C, L          ; 1:4       1759 *   1       1x = base 
    add  HL, HL         ; 1:11      1759 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1759 *      +1 = 3x 
    add  HL, HL         ; 1:11      1759 *   0  *2 = 6x 
    ld    A, L          ; 1:4       1759 *   256*L = 1536x 
    add  HL, HL         ; 1:11      1759 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1759 *      +1 = 13x 
    add  HL, HL         ; 1:11      1759 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1759 *      +1 = 27x 
    add  HL, HL         ; 1:11      1759 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1759 *      +1 = 55x 
    add  HL, HL         ; 1:11      1759 *   1  *2 = 110x
    add  HL, BC         ; 1:11      1759 *      +1 = 111x 
    add  HL, HL         ; 1:11      1759 *   1  *2 = 222x
    add  HL, BC         ; 1:11      1759 *      +1 = 223x 
    add   A, H          ; 1:4       1759 *
    ld    H, A          ; 1:4       1759 *     [1759x] = 223x + 1536x  
                        ;[15:130]   1761 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1110_0001)
    ld    B, H          ; 1:4       1761 *
    ld    C, L          ; 1:4       1761 *   1       1x = base 
    add  HL, HL         ; 1:11      1761 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1761 *      +1 = 3x 
    add  HL, HL         ; 1:11      1761 *   1  *2 = 6x
    ld    A, L          ; 1:4       1761 *   256*L = 1536x
    add  HL, BC         ; 1:11      1761 *      +1 = 7x 
    add  HL, HL         ; 1:11      1761 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1761 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1761 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      1761 *   0  *2 = 112x 
    add  HL, HL         ; 1:11      1761 *   1  *2 = 224x
    add  HL, BC         ; 1:11      1761 *      +1 = 225x 
    add   A, H          ; 1:4       1761 *
    ld    H, A          ; 1:4       1761 *     [1761x] = 225x + 1536x  
                        ;[16:141]   1763 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1110_0011)
    ld    B, H          ; 1:4       1763 *
    ld    C, L          ; 1:4       1763 *   1       1x = base 
    add  HL, HL         ; 1:11      1763 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1763 *      +1 = 3x 
    add  HL, HL         ; 1:11      1763 *   1  *2 = 6x
    ld    A, L          ; 1:4       1763 *   256*L = 1536x
    add  HL, BC         ; 1:11      1763 *      +1 = 7x 
    add  HL, HL         ; 1:11      1763 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1763 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1763 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      1763 *   1  *2 = 112x
    add  HL, BC         ; 1:11      1763 *      +1 = 113x 
    add  HL, HL         ; 1:11      1763 *   1  *2 = 226x
    add  HL, BC         ; 1:11      1763 *      +1 = 227x 
    add   A, H          ; 1:4       1763 *
    ld    H, A          ; 1:4       1763 *     [1763x] = 227x + 1536x  
                        ;[16:141]   1765 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1110_0101)
    ld    B, H          ; 1:4       1765 *
    ld    C, L          ; 1:4       1765 *   1       1x = base 
    add  HL, HL         ; 1:11      1765 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1765 *      +1 = 3x 
    add  HL, HL         ; 1:11      1765 *   1  *2 = 6x
    ld    A, L          ; 1:4       1765 *   256*L = 1536x
    add  HL, BC         ; 1:11      1765 *      +1 = 7x 
    add  HL, HL         ; 1:11      1765 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1765 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1765 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1765 *      +1 = 57x 
    add  HL, HL         ; 1:11      1765 *   0  *2 = 114x 
    add  HL, HL         ; 1:11      1765 *   1  *2 = 228x
    add  HL, BC         ; 1:11      1765 *      +1 = 229x 
    add   A, H          ; 1:4       1765 *
    ld    H, A          ; 1:4       1765 *     [1765x] = 229x + 1536x  
                        ;[17:152]   1767 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1110_0111)
    ld    B, H          ; 1:4       1767 *
    ld    C, L          ; 1:4       1767 *   1       1x = base 
    add  HL, HL         ; 1:11      1767 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1767 *      +1 = 3x 
    add  HL, HL         ; 1:11      1767 *   1  *2 = 6x
    ld    A, L          ; 1:4       1767 *   256*L = 1536x
    add  HL, BC         ; 1:11      1767 *      +1 = 7x 
    add  HL, HL         ; 1:11      1767 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1767 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1767 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1767 *      +1 = 57x 
    add  HL, HL         ; 1:11      1767 *   1  *2 = 114x
    add  HL, BC         ; 1:11      1767 *      +1 = 115x 
    add  HL, HL         ; 1:11      1767 *   1  *2 = 230x
    add  HL, BC         ; 1:11      1767 *      +1 = 231x 
    add   A, H          ; 1:4       1767 *
    ld    H, A          ; 1:4       1767 *     [1767x] = 231x + 1536x  
                        ;[16:141]   1769 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1110_1001)
    ld    B, H          ; 1:4       1769 *
    ld    C, L          ; 1:4       1769 *   1       1x = base 
    add  HL, HL         ; 1:11      1769 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1769 *      +1 = 3x 
    add  HL, HL         ; 1:11      1769 *   1  *2 = 6x
    ld    A, L          ; 1:4       1769 *   256*L = 1536x
    add  HL, BC         ; 1:11      1769 *      +1 = 7x 
    add  HL, HL         ; 1:11      1769 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1769 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1769 *      +1 = 29x 
    add  HL, HL         ; 1:11      1769 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1769 *   0  *2 = 116x 
    add  HL, HL         ; 1:11      1769 *   1  *2 = 232x
    add  HL, BC         ; 1:11      1769 *      +1 = 233x 
    add   A, H          ; 1:4       1769 *
    ld    H, A          ; 1:4       1769 *     [1769x] = 233x + 1536x  
                        ;[17:152]   1771 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1110_1011)
    ld    B, H          ; 1:4       1771 *
    ld    C, L          ; 1:4       1771 *   1       1x = base 
    add  HL, HL         ; 1:11      1771 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1771 *      +1 = 3x 
    add  HL, HL         ; 1:11      1771 *   1  *2 = 6x
    ld    A, L          ; 1:4       1771 *   256*L = 1536x
    add  HL, BC         ; 1:11      1771 *      +1 = 7x 
    add  HL, HL         ; 1:11      1771 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1771 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1771 *      +1 = 29x 
    add  HL, HL         ; 1:11      1771 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1771 *   1  *2 = 116x
    add  HL, BC         ; 1:11      1771 *      +1 = 117x 
    add  HL, HL         ; 1:11      1771 *   1  *2 = 234x
    add  HL, BC         ; 1:11      1771 *      +1 = 235x 
    add   A, H          ; 1:4       1771 *
    ld    H, A          ; 1:4       1771 *     [1771x] = 235x + 1536x  
                        ;[17:152]   1773 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1110_1101)
    ld    B, H          ; 1:4       1773 *
    ld    C, L          ; 1:4       1773 *   1       1x = base 
    add  HL, HL         ; 1:11      1773 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1773 *      +1 = 3x 
    add  HL, HL         ; 1:11      1773 *   1  *2 = 6x
    ld    A, L          ; 1:4       1773 *   256*L = 1536x
    add  HL, BC         ; 1:11      1773 *      +1 = 7x 
    add  HL, HL         ; 1:11      1773 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1773 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1773 *      +1 = 29x 
    add  HL, HL         ; 1:11      1773 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1773 *      +1 = 59x 
    add  HL, HL         ; 1:11      1773 *   0  *2 = 118x 
    add  HL, HL         ; 1:11      1773 *   1  *2 = 236x
    add  HL, BC         ; 1:11      1773 *      +1 = 237x 
    add   A, H          ; 1:4       1773 *
    ld    H, A          ; 1:4       1773 *     [1773x] = 237x + 1536x  
                        ;[18:107]   1775 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0001_0001_0001)  
    ld    A, L          ; 1:4       1775 *   256x 
    ld    B, H          ; 1:4       1775 *
    ld    C, L          ; 1:4       1775 *   [1x] 
    add  HL, HL         ; 1:11      1775 *   2x 
    add  HL, HL         ; 1:11      1775 *   4x 
    add  HL, HL         ; 1:11      1775 *   8x 
    add   A, B          ; 1:4       1775 *
    ld    B, A          ; 1:4       1775 *   [257x]
    ld    A, L          ; 1:4       1775 *   save --2048x-- 
    add  HL, HL         ; 1:11      1775 *   16x 
    add  HL, BC         ; 1:11      1775 *   [273x]
    ld    B, A          ; 1:4       1775 *   A0 - HL
    xor   A             ; 1:4       1775 *
    sub   L             ; 1:4       1775 *
    ld    L, A          ; 1:4       1775 *
    ld    A, B          ; 1:4       1775 *
    sbc   A, H          ; 1:4       1775 *
    ld    H, A          ; 1:4       1775 *   [1775x] = 2048x - 2048x   

                        ;[16:141]   1777 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1111_0001)
    ld    B, H          ; 1:4       1777 *
    ld    C, L          ; 1:4       1777 *   1       1x = base 
    add  HL, HL         ; 1:11      1777 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1777 *      +1 = 3x 
    add  HL, HL         ; 1:11      1777 *   1  *2 = 6x
    ld    A, L          ; 1:4       1777 *   256*L = 1536x
    add  HL, BC         ; 1:11      1777 *      +1 = 7x 
    add  HL, HL         ; 1:11      1777 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1777 *      +1 = 15x 
    add  HL, HL         ; 1:11      1777 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1777 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1777 *   0  *2 = 120x 
    add  HL, HL         ; 1:11      1777 *   1  *2 = 240x
    add  HL, BC         ; 1:11      1777 *      +1 = 241x 
    add   A, H          ; 1:4       1777 *
    ld    H, A          ; 1:4       1777 *     [1777x] = 241x + 1536x  
                        ;[17:152]   1779 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1111_0011)
    ld    B, H          ; 1:4       1779 *
    ld    C, L          ; 1:4       1779 *   1       1x = base 
    add  HL, HL         ; 1:11      1779 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1779 *      +1 = 3x 
    add  HL, HL         ; 1:11      1779 *   1  *2 = 6x
    ld    A, L          ; 1:4       1779 *   256*L = 1536x
    add  HL, BC         ; 1:11      1779 *      +1 = 7x 
    add  HL, HL         ; 1:11      1779 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1779 *      +1 = 15x 
    add  HL, HL         ; 1:11      1779 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1779 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1779 *   1  *2 = 120x
    add  HL, BC         ; 1:11      1779 *      +1 = 121x 
    add  HL, HL         ; 1:11      1779 *   1  *2 = 242x
    add  HL, BC         ; 1:11      1779 *      +1 = 243x 
    add   A, H          ; 1:4       1779 *
    ld    H, A          ; 1:4       1779 *     [1779x] = 243x + 1536x  
                        ;[17:152]   1781 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1111_0101)
    ld    B, H          ; 1:4       1781 *
    ld    C, L          ; 1:4       1781 *   1       1x = base 
    add  HL, HL         ; 1:11      1781 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1781 *      +1 = 3x 
    add  HL, HL         ; 1:11      1781 *   1  *2 = 6x
    ld    A, L          ; 1:4       1781 *   256*L = 1536x
    add  HL, BC         ; 1:11      1781 *      +1 = 7x 
    add  HL, HL         ; 1:11      1781 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1781 *      +1 = 15x 
    add  HL, HL         ; 1:11      1781 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1781 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1781 *      +1 = 61x 
    add  HL, HL         ; 1:11      1781 *   0  *2 = 122x 
    add  HL, HL         ; 1:11      1781 *   1  *2 = 244x
    add  HL, BC         ; 1:11      1781 *      +1 = 245x 
    add   A, H          ; 1:4       1781 *
    ld    H, A          ; 1:4       1781 *     [1781x] = 245x + 1536x  
                        ;[15:90]    1783 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0001_0000_1001)  
    ld    A, L          ; 1:4       1783 *   256x 
    ld    B, H          ; 1:4       1783 *
    ld    C, L          ; 1:4       1783 *   [1x] 
    add  HL, HL         ; 1:11      1783 *   2x 
    add  HL, HL         ; 1:11      1783 *   4x 
    add  HL, HL         ; 1:11      1783 *   8x 
    sub   L             ; 1:4       1783 *   L0 - (HL + BC + A0) = 0 - ((HL + BC) + (A0 - L0))
    add  HL, BC         ; 1:11      1783 *   [9x]
    add   A, H          ; 1:4       1783 *   [-1783x]
    cpl                 ; 1:4       1783 *
    ld    H, A          ; 1:4       1783 *
    ld    A, L          ; 1:4       1783 *
    cpl                 ; 1:4       1783 *
    ld    L, A          ; 1:4       1783 *
    inc  HL             ; 1:6       1783 *   [1783x] = 0-1783x    
                        ;[17:152]   1785 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1111_1001)
    ld    B, H          ; 1:4       1785 *
    ld    C, L          ; 1:4       1785 *   1       1x = base 
    add  HL, HL         ; 1:11      1785 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1785 *      +1 = 3x 
    add  HL, HL         ; 1:11      1785 *   1  *2 = 6x
    ld    A, L          ; 1:4       1785 *   256*L = 1536x
    add  HL, BC         ; 1:11      1785 *      +1 = 7x 
    add  HL, HL         ; 1:11      1785 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1785 *      +1 = 15x 
    add  HL, HL         ; 1:11      1785 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1785 *      +1 = 31x 
    add  HL, HL         ; 1:11      1785 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1785 *   0  *2 = 124x 
    add  HL, HL         ; 1:11      1785 *   1  *2 = 248x
    add  HL, BC         ; 1:11      1785 *      +1 = 249x 
    add   A, H          ; 1:4       1785 *
    ld    H, A          ; 1:4       1785 *     [1785x] = 249x + 1536x  
                        ;[18:163]   1787 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1111_1011)
    ld    B, H          ; 1:4       1787 *
    ld    C, L          ; 1:4       1787 *   1       1x = base 
    add  HL, HL         ; 1:11      1787 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1787 *      +1 = 3x 
    add  HL, HL         ; 1:11      1787 *   1  *2 = 6x
    ld    A, L          ; 1:4       1787 *   256*L = 1536x
    add  HL, BC         ; 1:11      1787 *      +1 = 7x 
    add  HL, HL         ; 1:11      1787 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1787 *      +1 = 15x 
    add  HL, HL         ; 1:11      1787 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1787 *      +1 = 31x 
    add  HL, HL         ; 1:11      1787 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1787 *   1  *2 = 124x
    add  HL, BC         ; 1:11      1787 *      +1 = 125x 
    add  HL, HL         ; 1:11      1787 *   1  *2 = 250x
    add  HL, BC         ; 1:11      1787 *      +1 = 251x 
    add   A, H          ; 1:4       1787 *
    ld    H, A          ; 1:4       1787 *     [1787x] = 251x + 1536x  
                        ;[18:163]   1789 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0110_1111_1101)
    ld    B, H          ; 1:4       1789 *
    ld    C, L          ; 1:4       1789 *   1       1x = base 
    add  HL, HL         ; 1:11      1789 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1789 *      +1 = 3x 
    add  HL, HL         ; 1:11      1789 *   1  *2 = 6x
    ld    A, L          ; 1:4       1789 *   256*L = 1536x
    add  HL, BC         ; 1:11      1789 *      +1 = 7x 
    add  HL, HL         ; 1:11      1789 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1789 *      +1 = 15x 
    add  HL, HL         ; 1:11      1789 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1789 *      +1 = 31x 
    add  HL, HL         ; 1:11      1789 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1789 *      +1 = 63x 
    add  HL, HL         ; 1:11      1789 *   0  *2 = 126x 
    add  HL, HL         ; 1:11      1789 *   1  *2 = 252x
    add  HL, BC         ; 1:11      1789 *      +1 = 253x 
    add   A, H          ; 1:4       1789 *
    ld    H, A          ; 1:4       1789 *     [1789x] = 253x + 1536x  
                        ;[14:83]    1791 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0001_0000_0001)  
    ld    A, L          ; 1:4       1791 *   256x 
    ld    B, H          ; 1:4       1791 *
    ld    C, L          ; 1:4       1791 *   [1x] 
    add  HL, HL         ; 1:11      1791 *   2x 
    add  HL, HL         ; 1:11      1791 *   4x 
    add  HL, HL         ; 1:11      1791 *   8x 
    add   A, B          ; 1:4       1791 *
    ld    B, A          ; 1:4       1791 *   [257x]
    ld    H, L          ; 1:4       1791 *
    ld    L, 0x00       ; 2:7       1791 *   2048x 
    or    A             ; 1:4       1791 *
    sbc  HL, BC         ; 2:15      1791 *   [1791x] = 2048x - 257x   
                        ;[7:28]     1793 *   Variant mk4: 256*...(((L*2^a)+L)*2^b)+... = HL * (b_0111_0000_0001)
    ld    A, L          ; 1:4       1793 *   1       1x 
    add   A, A          ; 1:4       1793 *   1  *2 = 2x
    add   A, L          ; 1:4       1793 *      +1 = 3x 
    add   A, A          ; 1:4       1793 *   1  *2 = 6x
    add   A, L          ; 1:4       1793 *      +1 = 7x 
    add   A, H          ; 1:4       1793 *
    ld    H, A          ; 1:4       1793 *     [1793x] = 256 * 7x + 1x 

                        ;[11:58]    1795 *   Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+... = HL * (b_0111_0000_0011)
    ld    B, H          ; 1:4       1795 *
    ld    C, L          ; 1:4       1795 *   1       1x & 256x = base 
    add  HL, HL         ; 1:11      1795 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1795 *      +1 = 3x  
    ld    A, C          ; 1:4       1795 *   1       1x 
    add   A, A          ; 1:4       1795 *   1  *2 = 2x
    add   A, C          ; 1:4       1795 *      +1 = 3x 
    add   A, A          ; 1:4       1795 *   1  *2 = 6x
    add   A, C          ; 1:4       1795 *      +1 = 7x 
    add   A, H          ; 1:4       1795 *
    ld    H, A          ; 1:4       1795 *     [1795x] = 256 * 7x + 3x  
                        ;[9:57]     1797 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0000_0101)
    ld    B, H          ; 1:4       1797 *
    ld    C, L          ; 1:4       1797 *   1       1x = base 
    add  HL, HL         ; 1:11      1797 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1797 *   256*L = 512x 
    add  HL, HL         ; 1:11      1797 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1797 *      +1 = 5x 
    add   A, L          ; 1:4       1797 *  +256*L = 1792x 
    add   A, H          ; 1:4       1797 *
    ld    H, A          ; 1:4       1797 *     [1797x] = 5x + 1792x  
                        ;[9:64]     1799 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0000_0111)
    ld    B, H          ; 1:4       1799 *
    ld    C, L          ; 1:4       1799 *   1       1x = base 
    add  HL, HL         ; 1:11      1799 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1799 *      +1 = 3x 
    add  HL, HL         ; 1:11      1799 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1799 *      +1 = 7x 
    ld    A, L          ; 1:4       1799 *   256*L = 1792x 
    add   A, H          ; 1:4       1799 *
    ld    H, A          ; 1:4       1799 *     [1799x] = 7x + 1792x  
                        ;[11:72]    1801 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0111_0000_1001)  
    ld    A, L          ; 1:4       1801 *   256x 
    ld    B, H          ; 1:4       1801 *
    ld    C, L          ; 1:4       1801 *   [1x] 
    add  HL, HL         ; 1:11      1801 *   2x 
    add   A, L          ; 1:4       1801 *   768x 
    add  HL, HL         ; 1:11      1801 *   4x 
    add   A, L          ; 1:4       1801 *   1792x 
    add  HL, HL         ; 1:11      1801 *   8x 
    add   A, B          ; 1:4       1801 *
    ld    B, A          ; 1:4       1801 *   [1793x] 
    add  HL, BC         ; 1:11      1801 *   [1801x] = 8x + 1793x   
                        ;[11:79]    1803 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0000_1011)
    ld    B, H          ; 1:4       1803 *
    ld    C, L          ; 1:4       1803 *   1       1x = base 
    add  HL, HL         ; 1:11      1803 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1803 *   256*L = 512x 
    add  HL, HL         ; 1:11      1803 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1803 *      +1 = 5x 
    add   A, L          ; 1:4       1803 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1803 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1803 *      +1 = 11x 
    add   A, H          ; 1:4       1803 *
    ld    H, A          ; 1:4       1803 *     [1803x] = 11x + 1792x  
                        ;[11:79]    1805 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0000_1101)
    ld    B, H          ; 1:4       1805 *
    ld    C, L          ; 1:4       1805 *   1       1x = base 
    ld    A, L          ; 1:4       1805 *   256*L = 256x 
    add  HL, HL         ; 1:11      1805 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1805 *      +1 = 3x 
    add  HL, HL         ; 1:11      1805 *   0  *2 = 6x 
    add   A, L          ; 1:4       1805 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1805 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1805 *      +1 = 13x 
    add   A, H          ; 1:4       1805 *
    ld    H, A          ; 1:4       1805 *     [1805x] = 13x + 1792x  
                        ;[11:86]    1807 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0000_1111)
    ld    B, H          ; 1:4       1807 *
    ld    C, L          ; 1:4       1807 *   1       1x = base 
    add  HL, HL         ; 1:11      1807 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1807 *      +1 = 3x 
    add  HL, HL         ; 1:11      1807 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1807 *      +1 = 7x 
    ld    A, L          ; 1:4       1807 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1807 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1807 *      +1 = 15x 
    add   A, H          ; 1:4       1807 *
    ld    H, A          ; 1:4       1807 *     [1807x] = 15x + 1792x  
                        ;[12:83]    1809 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0111_0001_0001)  
    ld    A, L          ; 1:4       1809 *   256x 
    ld    B, H          ; 1:4       1809 *
    ld    C, L          ; 1:4       1809 *   [1x] 
    add  HL, HL         ; 1:11      1809 *   2x 
    add   A, L          ; 1:4       1809 *   768x 
    add  HL, HL         ; 1:11      1809 *   4x 
    add   A, L          ; 1:4       1809 *   1792x 
    add  HL, HL         ; 1:11      1809 *   8x 
    add  HL, HL         ; 1:11      1809 *   16x 
    add   A, B          ; 1:4       1809 *
    ld    B, A          ; 1:4       1809 *   [1793x] 
    add  HL, BC         ; 1:11      1809 *   [1809x] = 16x + 1793x   
                        ;[13:94]    1811 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0001_0011)
    ld    B, H          ; 1:4       1811 *
    ld    C, L          ; 1:4       1811 *   1       1x = base 
    ld    A, L          ; 1:4       1811 *   256*L = 256x 
    add  HL, HL         ; 1:11      1811 *   0  *2 = 2x 
    add   A, L          ; 1:4       1811 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1811 *   0  *2 = 4x 
    add   A, L          ; 1:4       1811 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1811 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1811 *      +1 = 9x 
    add  HL, HL         ; 1:11      1811 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1811 *      +1 = 19x 
    add   A, H          ; 1:4       1811 *
    ld    H, A          ; 1:4       1811 *     [1811x] = 19x + 1792x 

                        ;[12:90]    1813 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0001_0101)
    ld    B, H          ; 1:4       1813 *
    ld    C, L          ; 1:4       1813 *   1       1x = base 
    add  HL, HL         ; 1:11      1813 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1813 *   256*L = 512x 
    add  HL, HL         ; 1:11      1813 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1813 *      +1 = 5x 
    add   A, L          ; 1:4       1813 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1813 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1813 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1813 *      +1 = 21x 
    add   A, H          ; 1:4       1813 *
    ld    H, A          ; 1:4       1813 *     [1813x] = 21x + 1792x  
                        ;[13:101]   1815 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0001_0111)
    ld    B, H          ; 1:4       1815 *
    ld    C, L          ; 1:4       1815 *   1       1x = base 
    add  HL, HL         ; 1:11      1815 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1815 *   256*L = 512x 
    add  HL, HL         ; 1:11      1815 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1815 *      +1 = 5x 
    add   A, L          ; 1:4       1815 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1815 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1815 *      +1 = 11x 
    add  HL, HL         ; 1:11      1815 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1815 *      +1 = 23x 
    add   A, H          ; 1:4       1815 *
    ld    H, A          ; 1:4       1815 *     [1815x] = 23x + 1792x  
                        ;[12:90]    1817 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0001_1001)
    ld    B, H          ; 1:4       1817 *
    ld    C, L          ; 1:4       1817 *   1       1x = base 
    ld    A, L          ; 1:4       1817 *   256*L = 256x 
    add  HL, HL         ; 1:11      1817 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1817 *      +1 = 3x 
    add  HL, HL         ; 1:11      1817 *   0  *2 = 6x 
    add   A, L          ; 1:4       1817 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1817 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1817 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1817 *      +1 = 25x 
    add   A, H          ; 1:4       1817 *
    ld    H, A          ; 1:4       1817 *     [1817x] = 25x + 1792x  
                        ;[13:101]   1819 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0001_1011)
    ld    B, H          ; 1:4       1819 *
    ld    C, L          ; 1:4       1819 *   1       1x = base 
    ld    A, L          ; 1:4       1819 *   256*L = 256x 
    add  HL, HL         ; 1:11      1819 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1819 *      +1 = 3x 
    add  HL, HL         ; 1:11      1819 *   0  *2 = 6x 
    add   A, L          ; 1:4       1819 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1819 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1819 *      +1 = 13x 
    add  HL, HL         ; 1:11      1819 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1819 *      +1 = 27x 
    add   A, H          ; 1:4       1819 *
    ld    H, A          ; 1:4       1819 *     [1819x] = 27x + 1792x  
                        ;[12:97]    1821 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0001_1101)
    ld    B, H          ; 1:4       1821 *
    ld    C, L          ; 1:4       1821 *   1       1x = base 
    add  HL, HL         ; 1:11      1821 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1821 *      +1 = 3x 
    add  HL, HL         ; 1:11      1821 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1821 *      +1 = 7x 
    ld    A, L          ; 1:4       1821 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1821 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1821 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1821 *      +1 = 29x 
    add   A, H          ; 1:4       1821 *
    ld    H, A          ; 1:4       1821 *     [1821x] = 29x + 1792x  
                        ;[13:108]   1823 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0001_1111)
    ld    B, H          ; 1:4       1823 *
    ld    C, L          ; 1:4       1823 *   1       1x = base 
    add  HL, HL         ; 1:11      1823 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1823 *      +1 = 3x 
    add  HL, HL         ; 1:11      1823 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1823 *      +1 = 7x 
    ld    A, L          ; 1:4       1823 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1823 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1823 *      +1 = 15x 
    add  HL, HL         ; 1:11      1823 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1823 *      +1 = 31x 
    add   A, H          ; 1:4       1823 *
    ld    H, A          ; 1:4       1823 *     [1823x] = 31x + 1792x  
                        ;[13:94]    1825 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0111_0010_0001)  
    ld    A, L          ; 1:4       1825 *   256x 
    ld    B, H          ; 1:4       1825 *
    ld    C, L          ; 1:4       1825 *   [1x] 
    add  HL, HL         ; 1:11      1825 *   2x 
    add   A, L          ; 1:4       1825 *   768x 
    add  HL, HL         ; 1:11      1825 *   4x 
    add   A, L          ; 1:4       1825 *   1792x 
    add  HL, HL         ; 1:11      1825 *   8x 
    add  HL, HL         ; 1:11      1825 *   16x 
    add  HL, HL         ; 1:11      1825 *   32x 
    add   A, B          ; 1:4       1825 *
    ld    B, A          ; 1:4       1825 *   [1793x] 
    add  HL, BC         ; 1:11      1825 *   [1825x] = 32x + 1793x   
                        ;[14:105]   1827 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0010_0011)
    ld    B, H          ; 1:4       1827 *
    ld    C, L          ; 1:4       1827 *   1       1x = base 
    ld    A, L          ; 1:4       1827 *   256*L = 256x 
    add  HL, HL         ; 1:11      1827 *   0  *2 = 2x 
    add   A, L          ; 1:4       1827 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1827 *   0  *2 = 4x 
    add   A, L          ; 1:4       1827 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1827 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1827 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1827 *      +1 = 17x 
    add  HL, HL         ; 1:11      1827 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1827 *      +1 = 35x 
    add   A, H          ; 1:4       1827 *
    ld    H, A          ; 1:4       1827 *     [1827x] = 35x + 1792x  
                        ;[14:105]   1829 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0010_0101)
    ld    B, H          ; 1:4       1829 *
    ld    C, L          ; 1:4       1829 *   1       1x = base 
    ld    A, L          ; 1:4       1829 *   256*L = 256x 
    add  HL, HL         ; 1:11      1829 *   0  *2 = 2x 
    add   A, L          ; 1:4       1829 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1829 *   0  *2 = 4x 
    add   A, L          ; 1:4       1829 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1829 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1829 *      +1 = 9x 
    add  HL, HL         ; 1:11      1829 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1829 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1829 *      +1 = 37x 
    add   A, H          ; 1:4       1829 *
    ld    H, A          ; 1:4       1829 *     [1829x] = 37x + 1792x 

                        ;[15:116]   1831 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0010_0111)
    ld    B, H          ; 1:4       1831 *
    ld    C, L          ; 1:4       1831 *   1       1x = base 
    ld    A, L          ; 1:4       1831 *   256*L = 256x 
    add  HL, HL         ; 1:11      1831 *   0  *2 = 2x 
    add   A, L          ; 1:4       1831 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1831 *   0  *2 = 4x 
    add   A, L          ; 1:4       1831 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1831 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1831 *      +1 = 9x 
    add  HL, HL         ; 1:11      1831 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1831 *      +1 = 19x 
    add  HL, HL         ; 1:11      1831 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1831 *      +1 = 39x 
    add   A, H          ; 1:4       1831 *
    ld    H, A          ; 1:4       1831 *     [1831x] = 39x + 1792x  
                        ;[13:101]   1833 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0010_1001)
    ld    B, H          ; 1:4       1833 *
    ld    C, L          ; 1:4       1833 *   1       1x = base 
    add  HL, HL         ; 1:11      1833 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1833 *   256*L = 512x 
    add  HL, HL         ; 1:11      1833 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1833 *      +1 = 5x 
    add   A, L          ; 1:4       1833 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1833 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1833 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1833 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1833 *      +1 = 41x 
    add   A, H          ; 1:4       1833 *
    ld    H, A          ; 1:4       1833 *     [1833x] = 41x + 1792x  
                        ;[14:112]   1835 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0010_1011)
    ld    B, H          ; 1:4       1835 *
    ld    C, L          ; 1:4       1835 *   1       1x = base 
    add  HL, HL         ; 1:11      1835 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1835 *   256*L = 512x 
    add  HL, HL         ; 1:11      1835 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1835 *      +1 = 5x 
    add   A, L          ; 1:4       1835 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1835 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1835 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1835 *      +1 = 21x 
    add  HL, HL         ; 1:11      1835 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1835 *      +1 = 43x 
    add   A, H          ; 1:4       1835 *
    ld    H, A          ; 1:4       1835 *     [1835x] = 43x + 1792x  
                        ;[14:112]   1837 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0010_1101)
    ld    B, H          ; 1:4       1837 *
    ld    C, L          ; 1:4       1837 *   1       1x = base 
    add  HL, HL         ; 1:11      1837 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1837 *   256*L = 512x 
    add  HL, HL         ; 1:11      1837 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1837 *      +1 = 5x 
    add   A, L          ; 1:4       1837 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1837 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1837 *      +1 = 11x 
    add  HL, HL         ; 1:11      1837 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1837 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1837 *      +1 = 45x 
    add   A, H          ; 1:4       1837 *
    ld    H, A          ; 1:4       1837 *     [1837x] = 45x + 1792x  
                        ;[15:123]   1839 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0010_1111)
    ld    B, H          ; 1:4       1839 *
    ld    C, L          ; 1:4       1839 *   1       1x = base 
    add  HL, HL         ; 1:11      1839 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1839 *   256*L = 512x 
    add  HL, HL         ; 1:11      1839 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1839 *      +1 = 5x 
    add   A, L          ; 1:4       1839 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1839 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1839 *      +1 = 11x 
    add  HL, HL         ; 1:11      1839 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1839 *      +1 = 23x 
    add  HL, HL         ; 1:11      1839 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1839 *      +1 = 47x 
    add   A, H          ; 1:4       1839 *
    ld    H, A          ; 1:4       1839 *     [1839x] = 47x + 1792x  
                        ;[13:101]   1841 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0011_0001)
    ld    B, H          ; 1:4       1841 *
    ld    C, L          ; 1:4       1841 *   1       1x = base 
    ld    A, L          ; 1:4       1841 *   256*L = 256x 
    add  HL, HL         ; 1:11      1841 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1841 *      +1 = 3x 
    add  HL, HL         ; 1:11      1841 *   0  *2 = 6x 
    add   A, L          ; 1:4       1841 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1841 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1841 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1841 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1841 *      +1 = 49x 
    add   A, H          ; 1:4       1841 *
    ld    H, A          ; 1:4       1841 *     [1841x] = 49x + 1792x  
                        ;[14:112]   1843 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0011_0011)
    ld    B, H          ; 1:4       1843 *
    ld    C, L          ; 1:4       1843 *   1       1x = base 
    ld    A, L          ; 1:4       1843 *   256*L = 256x 
    add  HL, HL         ; 1:11      1843 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1843 *      +1 = 3x 
    add  HL, HL         ; 1:11      1843 *   0  *2 = 6x 
    add   A, L          ; 1:4       1843 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1843 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1843 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1843 *      +1 = 25x 
    add  HL, HL         ; 1:11      1843 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1843 *      +1 = 51x 
    add   A, H          ; 1:4       1843 *
    ld    H, A          ; 1:4       1843 *     [1843x] = 51x + 1792x  
                        ;[14:112]   1845 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0011_0101)
    ld    B, H          ; 1:4       1845 *
    ld    C, L          ; 1:4       1845 *   1       1x = base 
    ld    A, L          ; 1:4       1845 *   256*L = 256x 
    add  HL, HL         ; 1:11      1845 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1845 *      +1 = 3x 
    add  HL, HL         ; 1:11      1845 *   0  *2 = 6x 
    add   A, L          ; 1:4       1845 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1845 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1845 *      +1 = 13x 
    add  HL, HL         ; 1:11      1845 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1845 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1845 *      +1 = 53x 
    add   A, H          ; 1:4       1845 *
    ld    H, A          ; 1:4       1845 *     [1845x] = 53x + 1792x  
                        ;[15:123]   1847 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0011_0111)
    ld    B, H          ; 1:4       1847 *
    ld    C, L          ; 1:4       1847 *   1       1x = base 
    ld    A, L          ; 1:4       1847 *   256*L = 256x 
    add  HL, HL         ; 1:11      1847 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1847 *      +1 = 3x 
    add  HL, HL         ; 1:11      1847 *   0  *2 = 6x 
    add   A, L          ; 1:4       1847 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1847 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1847 *      +1 = 13x 
    add  HL, HL         ; 1:11      1847 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1847 *      +1 = 27x 
    add  HL, HL         ; 1:11      1847 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1847 *      +1 = 55x 
    add   A, H          ; 1:4       1847 *
    ld    H, A          ; 1:4       1847 *     [1847x] = 55x + 1792x 

                        ;[13:108]   1849 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0011_1001)
    ld    B, H          ; 1:4       1849 *
    ld    C, L          ; 1:4       1849 *   1       1x = base 
    add  HL, HL         ; 1:11      1849 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1849 *      +1 = 3x 
    add  HL, HL         ; 1:11      1849 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1849 *      +1 = 7x 
    ld    A, L          ; 1:4       1849 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1849 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1849 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1849 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1849 *      +1 = 57x 
    add   A, H          ; 1:4       1849 *
    ld    H, A          ; 1:4       1849 *     [1849x] = 57x + 1792x  
                        ;[14:119]   1851 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0011_1011)
    ld    B, H          ; 1:4       1851 *
    ld    C, L          ; 1:4       1851 *   1       1x = base 
    add  HL, HL         ; 1:11      1851 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1851 *      +1 = 3x 
    add  HL, HL         ; 1:11      1851 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1851 *      +1 = 7x 
    ld    A, L          ; 1:4       1851 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1851 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1851 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1851 *      +1 = 29x 
    add  HL, HL         ; 1:11      1851 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1851 *      +1 = 59x 
    add   A, H          ; 1:4       1851 *
    ld    H, A          ; 1:4       1851 *     [1851x] = 59x + 1792x  
                        ;[14:119]   1853 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0011_1101)
    ld    B, H          ; 1:4       1853 *
    ld    C, L          ; 1:4       1853 *   1       1x = base 
    add  HL, HL         ; 1:11      1853 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1853 *      +1 = 3x 
    add  HL, HL         ; 1:11      1853 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1853 *      +1 = 7x 
    ld    A, L          ; 1:4       1853 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1853 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1853 *      +1 = 15x 
    add  HL, HL         ; 1:11      1853 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1853 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1853 *      +1 = 61x 
    add   A, H          ; 1:4       1853 *
    ld    H, A          ; 1:4       1853 *     [1853x] = 61x + 1792x  
                        ;[15:130]   1855 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0011_1111)
    ld    B, H          ; 1:4       1855 *
    ld    C, L          ; 1:4       1855 *   1       1x = base 
    add  HL, HL         ; 1:11      1855 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1855 *      +1 = 3x 
    add  HL, HL         ; 1:11      1855 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1855 *      +1 = 7x 
    ld    A, L          ; 1:4       1855 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1855 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1855 *      +1 = 15x 
    add  HL, HL         ; 1:11      1855 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1855 *      +1 = 31x 
    add  HL, HL         ; 1:11      1855 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1855 *      +1 = 63x 
    add   A, H          ; 1:4       1855 *
    ld    H, A          ; 1:4       1855 *     [1855x] = 63x + 1792x  
                        ;[14:105]   1857 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0111_0100_0001)  
    ld    A, L          ; 1:4       1857 *   256x 
    ld    B, H          ; 1:4       1857 *
    ld    C, L          ; 1:4       1857 *   [1x] 
    add  HL, HL         ; 1:11      1857 *   2x 
    add   A, L          ; 1:4       1857 *   768x 
    add  HL, HL         ; 1:11      1857 *   4x 
    add   A, L          ; 1:4       1857 *   1792x 
    add  HL, HL         ; 1:11      1857 *   8x 
    add  HL, HL         ; 1:11      1857 *   16x 
    add  HL, HL         ; 1:11      1857 *   32x 
    add  HL, HL         ; 1:11      1857 *   64x 
    add   A, B          ; 1:4       1857 *
    ld    B, A          ; 1:4       1857 *   [1793x] 
    add  HL, BC         ; 1:11      1857 *   [1857x] = 64x + 1793x   
                        ;[15:116]   1859 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0100_0011)
    ld    B, H          ; 1:4       1859 *
    ld    C, L          ; 1:4       1859 *   1       1x = base 
    ld    A, L          ; 1:4       1859 *   256*L = 256x 
    add  HL, HL         ; 1:11      1859 *   0  *2 = 2x 
    add   A, L          ; 1:4       1859 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1859 *   0  *2 = 4x 
    add   A, L          ; 1:4       1859 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1859 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1859 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1859 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1859 *      +1 = 33x 
    add  HL, HL         ; 1:11      1859 *   1  *2 = 66x
    add  HL, BC         ; 1:11      1859 *      +1 = 67x 
    add   A, H          ; 1:4       1859 *
    ld    H, A          ; 1:4       1859 *     [1859x] = 67x + 1792x  
                        ;[15:116]   1861 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0100_0101)
    ld    B, H          ; 1:4       1861 *
    ld    C, L          ; 1:4       1861 *   1       1x = base 
    ld    A, L          ; 1:4       1861 *   256*L = 256x 
    add  HL, HL         ; 1:11      1861 *   0  *2 = 2x 
    add   A, L          ; 1:4       1861 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1861 *   0  *2 = 4x 
    add   A, L          ; 1:4       1861 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1861 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1861 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1861 *      +1 = 17x 
    add  HL, HL         ; 1:11      1861 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1861 *   1  *2 = 68x
    add  HL, BC         ; 1:11      1861 *      +1 = 69x 
    add   A, H          ; 1:4       1861 *
    ld    H, A          ; 1:4       1861 *     [1861x] = 69x + 1792x  
                        ;[16:127]   1863 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0100_0111)
    ld    B, H          ; 1:4       1863 *
    ld    C, L          ; 1:4       1863 *   1       1x = base 
    ld    A, L          ; 1:4       1863 *   256*L = 256x 
    add  HL, HL         ; 1:11      1863 *   0  *2 = 2x 
    add   A, L          ; 1:4       1863 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1863 *   0  *2 = 4x 
    add   A, L          ; 1:4       1863 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1863 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1863 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1863 *      +1 = 17x 
    add  HL, HL         ; 1:11      1863 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1863 *      +1 = 35x 
    add  HL, HL         ; 1:11      1863 *   1  *2 = 70x
    add  HL, BC         ; 1:11      1863 *      +1 = 71x 
    add   A, H          ; 1:4       1863 *
    ld    H, A          ; 1:4       1863 *     [1863x] = 71x + 1792x  
                        ;[15:116]   1865 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0100_1001)
    ld    B, H          ; 1:4       1865 *
    ld    C, L          ; 1:4       1865 *   1       1x = base 
    ld    A, L          ; 1:4       1865 *   256*L = 256x 
    add  HL, HL         ; 1:11      1865 *   0  *2 = 2x 
    add   A, L          ; 1:4       1865 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1865 *   0  *2 = 4x 
    add   A, L          ; 1:4       1865 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1865 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1865 *      +1 = 9x 
    add  HL, HL         ; 1:11      1865 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1865 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1865 *   1  *2 = 72x
    add  HL, BC         ; 1:11      1865 *      +1 = 73x 
    add   A, H          ; 1:4       1865 *
    ld    H, A          ; 1:4       1865 *     [1865x] = 73x + 1792x 

                        ;[16:127]   1867 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0100_1011)
    ld    B, H          ; 1:4       1867 *
    ld    C, L          ; 1:4       1867 *   1       1x = base 
    ld    A, L          ; 1:4       1867 *   256*L = 256x 
    add  HL, HL         ; 1:11      1867 *   0  *2 = 2x 
    add   A, L          ; 1:4       1867 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1867 *   0  *2 = 4x 
    add   A, L          ; 1:4       1867 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1867 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1867 *      +1 = 9x 
    add  HL, HL         ; 1:11      1867 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1867 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1867 *      +1 = 37x 
    add  HL, HL         ; 1:11      1867 *   1  *2 = 74x
    add  HL, BC         ; 1:11      1867 *      +1 = 75x 
    add   A, H          ; 1:4       1867 *
    ld    H, A          ; 1:4       1867 *     [1867x] = 75x + 1792x  
                        ;[16:127]   1869 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0100_1101)
    ld    B, H          ; 1:4       1869 *
    ld    C, L          ; 1:4       1869 *   1       1x = base 
    ld    A, L          ; 1:4       1869 *   256*L = 256x 
    add  HL, HL         ; 1:11      1869 *   0  *2 = 2x 
    add   A, L          ; 1:4       1869 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1869 *   0  *2 = 4x 
    add   A, L          ; 1:4       1869 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1869 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1869 *      +1 = 9x 
    add  HL, HL         ; 1:11      1869 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1869 *      +1 = 19x 
    add  HL, HL         ; 1:11      1869 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1869 *   1  *2 = 76x
    add  HL, BC         ; 1:11      1869 *      +1 = 77x 
    add   A, H          ; 1:4       1869 *
    ld    H, A          ; 1:4       1869 *     [1869x] = 77x + 1792x  
                        ;[17:138]   1871 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0100_1111)
    ld    B, H          ; 1:4       1871 *
    ld    C, L          ; 1:4       1871 *   1       1x = base 
    ld    A, L          ; 1:4       1871 *   256*L = 256x 
    add  HL, HL         ; 1:11      1871 *   0  *2 = 2x 
    add   A, L          ; 1:4       1871 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1871 *   0  *2 = 4x 
    add   A, L          ; 1:4       1871 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1871 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1871 *      +1 = 9x 
    add  HL, HL         ; 1:11      1871 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1871 *      +1 = 19x 
    add  HL, HL         ; 1:11      1871 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1871 *      +1 = 39x 
    add  HL, HL         ; 1:11      1871 *   1  *2 = 78x
    add  HL, BC         ; 1:11      1871 *      +1 = 79x 
    add   A, H          ; 1:4       1871 *
    ld    H, A          ; 1:4       1871 *     [1871x] = 79x + 1792x  
                        ;[14:112]   1873 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0101_0001)
    ld    B, H          ; 1:4       1873 *
    ld    C, L          ; 1:4       1873 *   1       1x = base 
    add  HL, HL         ; 1:11      1873 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1873 *   256*L = 512x 
    add  HL, HL         ; 1:11      1873 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1873 *      +1 = 5x 
    add   A, L          ; 1:4       1873 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1873 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1873 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1873 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1873 *   1  *2 = 80x
    add  HL, BC         ; 1:11      1873 *      +1 = 81x 
    add   A, H          ; 1:4       1873 *
    ld    H, A          ; 1:4       1873 *     [1873x] = 81x + 1792x  
                        ;[15:123]   1875 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0101_0011)
    ld    B, H          ; 1:4       1875 *
    ld    C, L          ; 1:4       1875 *   1       1x = base 
    add  HL, HL         ; 1:11      1875 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1875 *   256*L = 512x 
    add  HL, HL         ; 1:11      1875 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1875 *      +1 = 5x 
    add   A, L          ; 1:4       1875 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1875 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1875 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1875 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1875 *      +1 = 41x 
    add  HL, HL         ; 1:11      1875 *   1  *2 = 82x
    add  HL, BC         ; 1:11      1875 *      +1 = 83x 
    add   A, H          ; 1:4       1875 *
    ld    H, A          ; 1:4       1875 *     [1875x] = 83x + 1792x  
                        ;[15:123]   1877 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0101_0101)
    ld    B, H          ; 1:4       1877 *
    ld    C, L          ; 1:4       1877 *   1       1x = base 
    add  HL, HL         ; 1:11      1877 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1877 *   256*L = 512x 
    add  HL, HL         ; 1:11      1877 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1877 *      +1 = 5x 
    add   A, L          ; 1:4       1877 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1877 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1877 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1877 *      +1 = 21x 
    add  HL, HL         ; 1:11      1877 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1877 *   1  *2 = 84x
    add  HL, BC         ; 1:11      1877 *      +1 = 85x 
    add   A, H          ; 1:4       1877 *
    ld    H, A          ; 1:4       1877 *     [1877x] = 85x + 1792x  
                        ;[16:134]   1879 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0101_0111)
    ld    B, H          ; 1:4       1879 *
    ld    C, L          ; 1:4       1879 *   1       1x = base 
    add  HL, HL         ; 1:11      1879 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1879 *   256*L = 512x 
    add  HL, HL         ; 1:11      1879 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1879 *      +1 = 5x 
    add   A, L          ; 1:4       1879 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1879 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1879 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1879 *      +1 = 21x 
    add  HL, HL         ; 1:11      1879 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1879 *      +1 = 43x 
    add  HL, HL         ; 1:11      1879 *   1  *2 = 86x
    add  HL, BC         ; 1:11      1879 *      +1 = 87x 
    add   A, H          ; 1:4       1879 *
    ld    H, A          ; 1:4       1879 *     [1879x] = 87x + 1792x  
                        ;[15:123]   1881 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0101_1001)
    ld    B, H          ; 1:4       1881 *
    ld    C, L          ; 1:4       1881 *   1       1x = base 
    add  HL, HL         ; 1:11      1881 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1881 *   256*L = 512x 
    add  HL, HL         ; 1:11      1881 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1881 *      +1 = 5x 
    add   A, L          ; 1:4       1881 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1881 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1881 *      +1 = 11x 
    add  HL, HL         ; 1:11      1881 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1881 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1881 *   1  *2 = 88x
    add  HL, BC         ; 1:11      1881 *      +1 = 89x 
    add   A, H          ; 1:4       1881 *
    ld    H, A          ; 1:4       1881 *     [1881x] = 89x + 1792x  
                        ;[16:134]   1883 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0101_1011)
    ld    B, H          ; 1:4       1883 *
    ld    C, L          ; 1:4       1883 *   1       1x = base 
    add  HL, HL         ; 1:11      1883 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1883 *   256*L = 512x 
    add  HL, HL         ; 1:11      1883 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1883 *      +1 = 5x 
    add   A, L          ; 1:4       1883 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1883 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1883 *      +1 = 11x 
    add  HL, HL         ; 1:11      1883 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1883 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1883 *      +1 = 45x 
    add  HL, HL         ; 1:11      1883 *   1  *2 = 90x
    add  HL, BC         ; 1:11      1883 *      +1 = 91x 
    add   A, H          ; 1:4       1883 *
    ld    H, A          ; 1:4       1883 *     [1883x] = 91x + 1792x 

                        ;[16:134]   1885 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0101_1101)
    ld    B, H          ; 1:4       1885 *
    ld    C, L          ; 1:4       1885 *   1       1x = base 
    add  HL, HL         ; 1:11      1885 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1885 *   256*L = 512x 
    add  HL, HL         ; 1:11      1885 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1885 *      +1 = 5x 
    add   A, L          ; 1:4       1885 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1885 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1885 *      +1 = 11x 
    add  HL, HL         ; 1:11      1885 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1885 *      +1 = 23x 
    add  HL, HL         ; 1:11      1885 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1885 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1885 *      +1 = 93x 
    add   A, H          ; 1:4       1885 *
    ld    H, A          ; 1:4       1885 *     [1885x] = 93x + 1792x  
                        ;[17:145]   1887 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0101_1111)
    ld    B, H          ; 1:4       1887 *
    ld    C, L          ; 1:4       1887 *   1       1x = base 
    add  HL, HL         ; 1:11      1887 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1887 *   256*L = 512x 
    add  HL, HL         ; 1:11      1887 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1887 *      +1 = 5x 
    add   A, L          ; 1:4       1887 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1887 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1887 *      +1 = 11x 
    add  HL, HL         ; 1:11      1887 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1887 *      +1 = 23x 
    add  HL, HL         ; 1:11      1887 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1887 *      +1 = 47x 
    add  HL, HL         ; 1:11      1887 *   1  *2 = 94x
    add  HL, BC         ; 1:11      1887 *      +1 = 95x 
    add   A, H          ; 1:4       1887 *
    ld    H, A          ; 1:4       1887 *     [1887x] = 95x + 1792x  
                        ;[14:112]   1889 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0110_0001)
    ld    B, H          ; 1:4       1889 *
    ld    C, L          ; 1:4       1889 *   1       1x = base 
    ld    A, L          ; 1:4       1889 *   256*L = 256x 
    add  HL, HL         ; 1:11      1889 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1889 *      +1 = 3x 
    add  HL, HL         ; 1:11      1889 *   0  *2 = 6x 
    add   A, L          ; 1:4       1889 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1889 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1889 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1889 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1889 *   1  *2 = 96x
    add  HL, BC         ; 1:11      1889 *      +1 = 97x 
    add   A, H          ; 1:4       1889 *
    ld    H, A          ; 1:4       1889 *     [1889x] = 97x + 1792x  
                        ;[15:123]   1891 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0110_0011)
    ld    B, H          ; 1:4       1891 *
    ld    C, L          ; 1:4       1891 *   1       1x = base 
    ld    A, L          ; 1:4       1891 *   256*L = 256x 
    add  HL, HL         ; 1:11      1891 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1891 *      +1 = 3x 
    add  HL, HL         ; 1:11      1891 *   0  *2 = 6x 
    add   A, L          ; 1:4       1891 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1891 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1891 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1891 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1891 *      +1 = 49x 
    add  HL, HL         ; 1:11      1891 *   1  *2 = 98x
    add  HL, BC         ; 1:11      1891 *      +1 = 99x 
    add   A, H          ; 1:4       1891 *
    ld    H, A          ; 1:4       1891 *     [1891x] = 99x + 1792x  
                        ;[15:123]   1893 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0110_0101)
    ld    B, H          ; 1:4       1893 *
    ld    C, L          ; 1:4       1893 *   1       1x = base 
    ld    A, L          ; 1:4       1893 *   256*L = 256x 
    add  HL, HL         ; 1:11      1893 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1893 *      +1 = 3x 
    add  HL, HL         ; 1:11      1893 *   0  *2 = 6x 
    add   A, L          ; 1:4       1893 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1893 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1893 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1893 *      +1 = 25x 
    add  HL, HL         ; 1:11      1893 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1893 *   1  *2 = 100x
    add  HL, BC         ; 1:11      1893 *      +1 = 101x 
    add   A, H          ; 1:4       1893 *
    ld    H, A          ; 1:4       1893 *     [1893x] = 101x + 1792x  
                        ;[16:134]   1895 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0110_0111)
    ld    B, H          ; 1:4       1895 *
    ld    C, L          ; 1:4       1895 *   1       1x = base 
    ld    A, L          ; 1:4       1895 *   256*L = 256x 
    add  HL, HL         ; 1:11      1895 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1895 *      +1 = 3x 
    add  HL, HL         ; 1:11      1895 *   0  *2 = 6x 
    add   A, L          ; 1:4       1895 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1895 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1895 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1895 *      +1 = 25x 
    add  HL, HL         ; 1:11      1895 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1895 *      +1 = 51x 
    add  HL, HL         ; 1:11      1895 *   1  *2 = 102x
    add  HL, BC         ; 1:11      1895 *      +1 = 103x 
    add   A, H          ; 1:4       1895 *
    ld    H, A          ; 1:4       1895 *     [1895x] = 103x + 1792x  
                        ;[15:123]   1897 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0110_1001)
    ld    B, H          ; 1:4       1897 *
    ld    C, L          ; 1:4       1897 *   1       1x = base 
    ld    A, L          ; 1:4       1897 *   256*L = 256x 
    add  HL, HL         ; 1:11      1897 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1897 *      +1 = 3x 
    add  HL, HL         ; 1:11      1897 *   0  *2 = 6x 
    add   A, L          ; 1:4       1897 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1897 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1897 *      +1 = 13x 
    add  HL, HL         ; 1:11      1897 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1897 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      1897 *   1  *2 = 104x
    add  HL, BC         ; 1:11      1897 *      +1 = 105x 
    add   A, H          ; 1:4       1897 *
    ld    H, A          ; 1:4       1897 *     [1897x] = 105x + 1792x  
                        ;[16:134]   1899 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0110_1011)
    ld    B, H          ; 1:4       1899 *
    ld    C, L          ; 1:4       1899 *   1       1x = base 
    ld    A, L          ; 1:4       1899 *   256*L = 256x 
    add  HL, HL         ; 1:11      1899 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1899 *      +1 = 3x 
    add  HL, HL         ; 1:11      1899 *   0  *2 = 6x 
    add   A, L          ; 1:4       1899 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1899 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1899 *      +1 = 13x 
    add  HL, HL         ; 1:11      1899 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      1899 *   1  *2 = 52x
    add  HL, BC         ; 1:11      1899 *      +1 = 53x 
    add  HL, HL         ; 1:11      1899 *   1  *2 = 106x
    add  HL, BC         ; 1:11      1899 *      +1 = 107x 
    add   A, H          ; 1:4       1899 *
    ld    H, A          ; 1:4       1899 *     [1899x] = 107x + 1792x  
                        ;[16:134]   1901 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0110_1101)
    ld    B, H          ; 1:4       1901 *
    ld    C, L          ; 1:4       1901 *   1       1x = base 
    ld    A, L          ; 1:4       1901 *   256*L = 256x 
    add  HL, HL         ; 1:11      1901 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1901 *      +1 = 3x 
    add  HL, HL         ; 1:11      1901 *   0  *2 = 6x 
    add   A, L          ; 1:4       1901 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1901 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1901 *      +1 = 13x 
    add  HL, HL         ; 1:11      1901 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1901 *      +1 = 27x 
    add  HL, HL         ; 1:11      1901 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      1901 *   1  *2 = 108x
    add  HL, BC         ; 1:11      1901 *      +1 = 109x 
    add   A, H          ; 1:4       1901 *
    ld    H, A          ; 1:4       1901 *     [1901x] = 109x + 1792x 

                        ;[17:145]   1903 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0110_1111)
    ld    B, H          ; 1:4       1903 *
    ld    C, L          ; 1:4       1903 *   1       1x = base 
    ld    A, L          ; 1:4       1903 *   256*L = 256x 
    add  HL, HL         ; 1:11      1903 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1903 *      +1 = 3x 
    add  HL, HL         ; 1:11      1903 *   0  *2 = 6x 
    add   A, L          ; 1:4       1903 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1903 *   1  *2 = 12x
    add  HL, BC         ; 1:11      1903 *      +1 = 13x 
    add  HL, HL         ; 1:11      1903 *   1  *2 = 26x
    add  HL, BC         ; 1:11      1903 *      +1 = 27x 
    add  HL, HL         ; 1:11      1903 *   1  *2 = 54x
    add  HL, BC         ; 1:11      1903 *      +1 = 55x 
    add  HL, HL         ; 1:11      1903 *   1  *2 = 110x
    add  HL, BC         ; 1:11      1903 *      +1 = 111x 
    add   A, H          ; 1:4       1903 *
    ld    H, A          ; 1:4       1903 *     [1903x] = 111x + 1792x  
                        ;[14:119]   1905 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0111_0001)
    ld    B, H          ; 1:4       1905 *
    ld    C, L          ; 1:4       1905 *   1       1x = base 
    add  HL, HL         ; 1:11      1905 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1905 *      +1 = 3x 
    add  HL, HL         ; 1:11      1905 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1905 *      +1 = 7x 
    ld    A, L          ; 1:4       1905 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1905 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1905 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1905 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      1905 *   1  *2 = 112x
    add  HL, BC         ; 1:11      1905 *      +1 = 113x 
    add   A, H          ; 1:4       1905 *
    ld    H, A          ; 1:4       1905 *     [1905x] = 113x + 1792x  
                        ;[15:130]   1907 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0111_0011)
    ld    B, H          ; 1:4       1907 *
    ld    C, L          ; 1:4       1907 *   1       1x = base 
    add  HL, HL         ; 1:11      1907 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1907 *      +1 = 3x 
    add  HL, HL         ; 1:11      1907 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1907 *      +1 = 7x 
    ld    A, L          ; 1:4       1907 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1907 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1907 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      1907 *   1  *2 = 56x
    add  HL, BC         ; 1:11      1907 *      +1 = 57x 
    add  HL, HL         ; 1:11      1907 *   1  *2 = 114x
    add  HL, BC         ; 1:11      1907 *      +1 = 115x 
    add   A, H          ; 1:4       1907 *
    ld    H, A          ; 1:4       1907 *     [1907x] = 115x + 1792x  
                        ;[15:130]   1909 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0111_0101)
    ld    B, H          ; 1:4       1909 *
    ld    C, L          ; 1:4       1909 *   1       1x = base 
    add  HL, HL         ; 1:11      1909 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1909 *      +1 = 3x 
    add  HL, HL         ; 1:11      1909 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1909 *      +1 = 7x 
    ld    A, L          ; 1:4       1909 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1909 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1909 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1909 *      +1 = 29x 
    add  HL, HL         ; 1:11      1909 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      1909 *   1  *2 = 116x
    add  HL, BC         ; 1:11      1909 *      +1 = 117x 
    add   A, H          ; 1:4       1909 *
    ld    H, A          ; 1:4       1909 *     [1909x] = 117x + 1792x  
                        ;[16:141]   1911 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0111_0111)
    ld    B, H          ; 1:4       1911 *
    ld    C, L          ; 1:4       1911 *   1       1x = base 
    add  HL, HL         ; 1:11      1911 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1911 *      +1 = 3x 
    add  HL, HL         ; 1:11      1911 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1911 *      +1 = 7x 
    ld    A, L          ; 1:4       1911 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1911 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      1911 *   1  *2 = 28x
    add  HL, BC         ; 1:11      1911 *      +1 = 29x 
    add  HL, HL         ; 1:11      1911 *   1  *2 = 58x
    add  HL, BC         ; 1:11      1911 *      +1 = 59x 
    add  HL, HL         ; 1:11      1911 *   1  *2 = 118x
    add  HL, BC         ; 1:11      1911 *      +1 = 119x 
    add   A, H          ; 1:4       1911 *
    ld    H, A          ; 1:4       1911 *     [1911x] = 119x + 1792x  
                        ;[15:130]   1913 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0111_1001)
    ld    B, H          ; 1:4       1913 *
    ld    C, L          ; 1:4       1913 *   1       1x = base 
    add  HL, HL         ; 1:11      1913 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1913 *      +1 = 3x 
    add  HL, HL         ; 1:11      1913 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1913 *      +1 = 7x 
    ld    A, L          ; 1:4       1913 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1913 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1913 *      +1 = 15x 
    add  HL, HL         ; 1:11      1913 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1913 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      1913 *   1  *2 = 120x
    add  HL, BC         ; 1:11      1913 *      +1 = 121x 
    add   A, H          ; 1:4       1913 *
    ld    H, A          ; 1:4       1913 *     [1913x] = 121x + 1792x  
                        ;[16:141]   1915 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0111_1011)
    ld    B, H          ; 1:4       1915 *
    ld    C, L          ; 1:4       1915 *   1       1x = base 
    add  HL, HL         ; 1:11      1915 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1915 *      +1 = 3x 
    add  HL, HL         ; 1:11      1915 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1915 *      +1 = 7x 
    ld    A, L          ; 1:4       1915 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1915 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1915 *      +1 = 15x 
    add  HL, HL         ; 1:11      1915 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      1915 *   1  *2 = 60x
    add  HL, BC         ; 1:11      1915 *      +1 = 61x 
    add  HL, HL         ; 1:11      1915 *   1  *2 = 122x
    add  HL, BC         ; 1:11      1915 *      +1 = 123x 
    add   A, H          ; 1:4       1915 *
    ld    H, A          ; 1:4       1915 *     [1915x] = 123x + 1792x  
                        ;[16:141]   1917 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0111_1101)
    ld    B, H          ; 1:4       1917 *
    ld    C, L          ; 1:4       1917 *   1       1x = base 
    add  HL, HL         ; 1:11      1917 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1917 *      +1 = 3x 
    add  HL, HL         ; 1:11      1917 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1917 *      +1 = 7x 
    ld    A, L          ; 1:4       1917 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1917 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1917 *      +1 = 15x 
    add  HL, HL         ; 1:11      1917 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1917 *      +1 = 31x 
    add  HL, HL         ; 1:11      1917 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      1917 *   1  *2 = 124x
    add  HL, BC         ; 1:11      1917 *      +1 = 125x 
    add   A, H          ; 1:4       1917 *
    ld    H, A          ; 1:4       1917 *     [1917x] = 125x + 1792x  
                        ;[17:152]   1919 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_0111_1111)
    ld    B, H          ; 1:4       1919 *
    ld    C, L          ; 1:4       1919 *   1       1x = base 
    add  HL, HL         ; 1:11      1919 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1919 *      +1 = 3x 
    add  HL, HL         ; 1:11      1919 *   1  *2 = 6x
    add  HL, BC         ; 1:11      1919 *      +1 = 7x 
    ld    A, L          ; 1:4       1919 *   256*L = 1792x 
    add  HL, HL         ; 1:11      1919 *   1  *2 = 14x
    add  HL, BC         ; 1:11      1919 *      +1 = 15x 
    add  HL, HL         ; 1:11      1919 *   1  *2 = 30x
    add  HL, BC         ; 1:11      1919 *      +1 = 31x 
    add  HL, HL         ; 1:11      1919 *   1  *2 = 62x
    add  HL, BC         ; 1:11      1919 *      +1 = 63x 
    add  HL, HL         ; 1:11      1919 *   1  *2 = 126x
    add  HL, BC         ; 1:11      1919 *      +1 = 127x 
    add   A, H          ; 1:4       1919 *
    ld    H, A          ; 1:4       1919 *     [1919x] = 127x + 1792x 

                        ;[15:116]   1921 *   Variant mk3: HL * (256*a^2 + b^2 + ...) = HL * (b_0111_1000_0001)  
    ld    A, L          ; 1:4       1921 *   256x 
    ld    B, H          ; 1:4       1921 *
    ld    C, L          ; 1:4       1921 *   [1x] 
    add  HL, HL         ; 1:11      1921 *   2x 
    add   A, L          ; 1:4       1921 *   768x 
    add  HL, HL         ; 1:11      1921 *   4x 
    add   A, L          ; 1:4       1921 *   1792x 
    add  HL, HL         ; 1:11      1921 *   8x 
    add  HL, HL         ; 1:11      1921 *   16x 
    add  HL, HL         ; 1:11      1921 *   32x 
    add  HL, HL         ; 1:11      1921 *   64x 
    add  HL, HL         ; 1:11      1921 *   128x 
    add   A, B          ; 1:4       1921 *
    ld    B, A          ; 1:4       1921 *   [1793x] 
    add  HL, BC         ; 1:11      1921 *   [1921x] = 128x + 1793x   
                        ;[16:127]   1923 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1000_0011)
    ld    B, H          ; 1:4       1923 *
    ld    C, L          ; 1:4       1923 *   1       1x = base 
    ld    A, L          ; 1:4       1923 *   256*L = 256x 
    add  HL, HL         ; 1:11      1923 *   0  *2 = 2x 
    add   A, L          ; 1:4       1923 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1923 *   0  *2 = 4x 
    add   A, L          ; 1:4       1923 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1923 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1923 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1923 *   0  *2 = 32x 
    add  HL, HL         ; 1:11      1923 *   1  *2 = 64x
    add  HL, BC         ; 1:11      1923 *      +1 = 65x 
    add  HL, HL         ; 1:11      1923 *   1  *2 = 130x
    add  HL, BC         ; 1:11      1923 *      +1 = 131x 
    add   A, H          ; 1:4       1923 *
    ld    H, A          ; 1:4       1923 *     [1923x] = 131x + 1792x  
                        ;[16:127]   1925 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1000_0101)
    ld    B, H          ; 1:4       1925 *
    ld    C, L          ; 1:4       1925 *   1       1x = base 
    ld    A, L          ; 1:4       1925 *   256*L = 256x 
    add  HL, HL         ; 1:11      1925 *   0  *2 = 2x 
    add   A, L          ; 1:4       1925 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1925 *   0  *2 = 4x 
    add   A, L          ; 1:4       1925 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1925 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1925 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1925 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1925 *      +1 = 33x 
    add  HL, HL         ; 1:11      1925 *   0  *2 = 66x 
    add  HL, HL         ; 1:11      1925 *   1  *2 = 132x
    add  HL, BC         ; 1:11      1925 *      +1 = 133x 
    add   A, H          ; 1:4       1925 *
    ld    H, A          ; 1:4       1925 *     [1925x] = 133x + 1792x  
                        ;[17:138]   1927 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1000_0111)
    ld    B, H          ; 1:4       1927 *
    ld    C, L          ; 1:4       1927 *   1       1x = base 
    ld    A, L          ; 1:4       1927 *   256*L = 256x 
    add  HL, HL         ; 1:11      1927 *   0  *2 = 2x 
    add   A, L          ; 1:4       1927 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1927 *   0  *2 = 4x 
    add   A, L          ; 1:4       1927 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1927 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1927 *   0  *2 = 16x 
    add  HL, HL         ; 1:11      1927 *   1  *2 = 32x
    add  HL, BC         ; 1:11      1927 *      +1 = 33x 
    add  HL, HL         ; 1:11      1927 *   1  *2 = 66x
    add  HL, BC         ; 1:11      1927 *      +1 = 67x 
    add  HL, HL         ; 1:11      1927 *   1  *2 = 134x
    add  HL, BC         ; 1:11      1927 *      +1 = 135x 
    add   A, H          ; 1:4       1927 *
    ld    H, A          ; 1:4       1927 *     [1927x] = 135x + 1792x  
                        ;[16:127]   1929 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1000_1001)
    ld    B, H          ; 1:4       1929 *
    ld    C, L          ; 1:4       1929 *   1       1x = base 
    ld    A, L          ; 1:4       1929 *   256*L = 256x 
    add  HL, HL         ; 1:11      1929 *   0  *2 = 2x 
    add   A, L          ; 1:4       1929 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1929 *   0  *2 = 4x 
    add   A, L          ; 1:4       1929 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1929 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1929 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1929 *      +1 = 17x 
    add  HL, HL         ; 1:11      1929 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1929 *   0  *2 = 68x 
    add  HL, HL         ; 1:11      1929 *   1  *2 = 136x
    add  HL, BC         ; 1:11      1929 *      +1 = 137x 
    add   A, H          ; 1:4       1929 *
    ld    H, A          ; 1:4       1929 *     [1929x] = 137x + 1792x  
                        ;[17:138]   1931 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1000_1011)
    ld    B, H          ; 1:4       1931 *
    ld    C, L          ; 1:4       1931 *   1       1x = base 
    ld    A, L          ; 1:4       1931 *   256*L = 256x 
    add  HL, HL         ; 1:11      1931 *   0  *2 = 2x 
    add   A, L          ; 1:4       1931 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1931 *   0  *2 = 4x 
    add   A, L          ; 1:4       1931 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1931 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1931 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1931 *      +1 = 17x 
    add  HL, HL         ; 1:11      1931 *   0  *2 = 34x 
    add  HL, HL         ; 1:11      1931 *   1  *2 = 68x
    add  HL, BC         ; 1:11      1931 *      +1 = 69x 
    add  HL, HL         ; 1:11      1931 *   1  *2 = 138x
    add  HL, BC         ; 1:11      1931 *      +1 = 139x 
    add   A, H          ; 1:4       1931 *
    ld    H, A          ; 1:4       1931 *     [1931x] = 139x + 1792x  
                        ;[17:138]   1933 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1000_1101)
    ld    B, H          ; 1:4       1933 *
    ld    C, L          ; 1:4       1933 *   1       1x = base 
    ld    A, L          ; 1:4       1933 *   256*L = 256x 
    add  HL, HL         ; 1:11      1933 *   0  *2 = 2x 
    add   A, L          ; 1:4       1933 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1933 *   0  *2 = 4x 
    add   A, L          ; 1:4       1933 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1933 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1933 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1933 *      +1 = 17x 
    add  HL, HL         ; 1:11      1933 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1933 *      +1 = 35x 
    add  HL, HL         ; 1:11      1933 *   0  *2 = 70x 
    add  HL, HL         ; 1:11      1933 *   1  *2 = 140x
    add  HL, BC         ; 1:11      1933 *      +1 = 141x 
    add   A, H          ; 1:4       1933 *
    ld    H, A          ; 1:4       1933 *     [1933x] = 141x + 1792x  
                        ;[18:149]   1935 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1000_1111)
    ld    B, H          ; 1:4       1935 *
    ld    C, L          ; 1:4       1935 *   1       1x = base 
    ld    A, L          ; 1:4       1935 *   256*L = 256x 
    add  HL, HL         ; 1:11      1935 *   0  *2 = 2x 
    add   A, L          ; 1:4       1935 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1935 *   0  *2 = 4x 
    add   A, L          ; 1:4       1935 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1935 *   0  *2 = 8x 
    add  HL, HL         ; 1:11      1935 *   1  *2 = 16x
    add  HL, BC         ; 1:11      1935 *      +1 = 17x 
    add  HL, HL         ; 1:11      1935 *   1  *2 = 34x
    add  HL, BC         ; 1:11      1935 *      +1 = 35x 
    add  HL, HL         ; 1:11      1935 *   1  *2 = 70x
    add  HL, BC         ; 1:11      1935 *      +1 = 71x 
    add  HL, HL         ; 1:11      1935 *   1  *2 = 142x
    add  HL, BC         ; 1:11      1935 *      +1 = 143x 
    add   A, H          ; 1:4       1935 *
    ld    H, A          ; 1:4       1935 *     [1935x] = 143x + 1792x  
                        ;[16:127]   1937 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1001_0001)
    ld    B, H          ; 1:4       1937 *
    ld    C, L          ; 1:4       1937 *   1       1x = base 
    ld    A, L          ; 1:4       1937 *   256*L = 256x 
    add  HL, HL         ; 1:11      1937 *   0  *2 = 2x 
    add   A, L          ; 1:4       1937 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1937 *   0  *2 = 4x 
    add   A, L          ; 1:4       1937 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1937 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1937 *      +1 = 9x 
    add  HL, HL         ; 1:11      1937 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1937 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1937 *   0  *2 = 72x 
    add  HL, HL         ; 1:11      1937 *   1  *2 = 144x
    add  HL, BC         ; 1:11      1937 *      +1 = 145x 
    add   A, H          ; 1:4       1937 *
    ld    H, A          ; 1:4       1937 *     [1937x] = 145x + 1792x 

                        ;[17:138]   1939 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1001_0011)
    ld    B, H          ; 1:4       1939 *
    ld    C, L          ; 1:4       1939 *   1       1x = base 
    ld    A, L          ; 1:4       1939 *   256*L = 256x 
    add  HL, HL         ; 1:11      1939 *   0  *2 = 2x 
    add   A, L          ; 1:4       1939 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1939 *   0  *2 = 4x 
    add   A, L          ; 1:4       1939 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1939 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1939 *      +1 = 9x 
    add  HL, HL         ; 1:11      1939 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1939 *   0  *2 = 36x 
    add  HL, HL         ; 1:11      1939 *   1  *2 = 72x
    add  HL, BC         ; 1:11      1939 *      +1 = 73x 
    add  HL, HL         ; 1:11      1939 *   1  *2 = 146x
    add  HL, BC         ; 1:11      1939 *      +1 = 147x 
    add   A, H          ; 1:4       1939 *
    ld    H, A          ; 1:4       1939 *     [1939x] = 147x + 1792x  
                        ;[17:138]   1941 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1001_0101)
    ld    B, H          ; 1:4       1941 *
    ld    C, L          ; 1:4       1941 *   1       1x = base 
    ld    A, L          ; 1:4       1941 *   256*L = 256x 
    add  HL, HL         ; 1:11      1941 *   0  *2 = 2x 
    add   A, L          ; 1:4       1941 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1941 *   0  *2 = 4x 
    add   A, L          ; 1:4       1941 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1941 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1941 *      +1 = 9x 
    add  HL, HL         ; 1:11      1941 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1941 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1941 *      +1 = 37x 
    add  HL, HL         ; 1:11      1941 *   0  *2 = 74x 
    add  HL, HL         ; 1:11      1941 *   1  *2 = 148x
    add  HL, BC         ; 1:11      1941 *      +1 = 149x 
    add   A, H          ; 1:4       1941 *
    ld    H, A          ; 1:4       1941 *     [1941x] = 149x + 1792x  
                        ;[18:149]   1943 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1001_0111)
    ld    B, H          ; 1:4       1943 *
    ld    C, L          ; 1:4       1943 *   1       1x = base 
    ld    A, L          ; 1:4       1943 *   256*L = 256x 
    add  HL, HL         ; 1:11      1943 *   0  *2 = 2x 
    add   A, L          ; 1:4       1943 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1943 *   0  *2 = 4x 
    add   A, L          ; 1:4       1943 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1943 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1943 *      +1 = 9x 
    add  HL, HL         ; 1:11      1943 *   0  *2 = 18x 
    add  HL, HL         ; 1:11      1943 *   1  *2 = 36x
    add  HL, BC         ; 1:11      1943 *      +1 = 37x 
    add  HL, HL         ; 1:11      1943 *   1  *2 = 74x
    add  HL, BC         ; 1:11      1943 *      +1 = 75x 
    add  HL, HL         ; 1:11      1943 *   1  *2 = 150x
    add  HL, BC         ; 1:11      1943 *      +1 = 151x 
    add   A, H          ; 1:4       1943 *
    ld    H, A          ; 1:4       1943 *     [1943x] = 151x + 1792x  
                        ;[17:138]   1945 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1001_1001)
    ld    B, H          ; 1:4       1945 *
    ld    C, L          ; 1:4       1945 *   1       1x = base 
    ld    A, L          ; 1:4       1945 *   256*L = 256x 
    add  HL, HL         ; 1:11      1945 *   0  *2 = 2x 
    add   A, L          ; 1:4       1945 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1945 *   0  *2 = 4x 
    add   A, L          ; 1:4       1945 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1945 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1945 *      +1 = 9x 
    add  HL, HL         ; 1:11      1945 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1945 *      +1 = 19x 
    add  HL, HL         ; 1:11      1945 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1945 *   0  *2 = 76x 
    add  HL, HL         ; 1:11      1945 *   1  *2 = 152x
    add  HL, BC         ; 1:11      1945 *      +1 = 153x 
    add   A, H          ; 1:4       1945 *
    ld    H, A          ; 1:4       1945 *     [1945x] = 153x + 1792x  
                        ;[18:149]   1947 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1001_1011)
    ld    B, H          ; 1:4       1947 *
    ld    C, L          ; 1:4       1947 *   1       1x = base 
    ld    A, L          ; 1:4       1947 *   256*L = 256x 
    add  HL, HL         ; 1:11      1947 *   0  *2 = 2x 
    add   A, L          ; 1:4       1947 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1947 *   0  *2 = 4x 
    add   A, L          ; 1:4       1947 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1947 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1947 *      +1 = 9x 
    add  HL, HL         ; 1:11      1947 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1947 *      +1 = 19x 
    add  HL, HL         ; 1:11      1947 *   0  *2 = 38x 
    add  HL, HL         ; 1:11      1947 *   1  *2 = 76x
    add  HL, BC         ; 1:11      1947 *      +1 = 77x 
    add  HL, HL         ; 1:11      1947 *   1  *2 = 154x
    add  HL, BC         ; 1:11      1947 *      +1 = 155x 
    add   A, H          ; 1:4       1947 *
    ld    H, A          ; 1:4       1947 *     [1947x] = 155x + 1792x  
                        ;[18:149]   1949 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1001_1101)
    ld    B, H          ; 1:4       1949 *
    ld    C, L          ; 1:4       1949 *   1       1x = base 
    ld    A, L          ; 1:4       1949 *   256*L = 256x 
    add  HL, HL         ; 1:11      1949 *   0  *2 = 2x 
    add   A, L          ; 1:4       1949 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1949 *   0  *2 = 4x 
    add   A, L          ; 1:4       1949 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1949 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1949 *      +1 = 9x 
    add  HL, HL         ; 1:11      1949 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1949 *      +1 = 19x 
    add  HL, HL         ; 1:11      1949 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1949 *      +1 = 39x 
    add  HL, HL         ; 1:11      1949 *   0  *2 = 78x 
    add  HL, HL         ; 1:11      1949 *   1  *2 = 156x
    add  HL, BC         ; 1:11      1949 *      +1 = 157x 
    add   A, H          ; 1:4       1949 *
    ld    H, A          ; 1:4       1949 *     [1949x] = 157x + 1792x  
                        ;[19:160]   1951 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1001_1111)
    ld    B, H          ; 1:4       1951 *
    ld    C, L          ; 1:4       1951 *   1       1x = base 
    ld    A, L          ; 1:4       1951 *   256*L = 256x 
    add  HL, HL         ; 1:11      1951 *   0  *2 = 2x 
    add   A, L          ; 1:4       1951 *  +256*L = 768x 
    add  HL, HL         ; 1:11      1951 *   0  *2 = 4x 
    add   A, L          ; 1:4       1951 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1951 *   1  *2 = 8x
    add  HL, BC         ; 1:11      1951 *      +1 = 9x 
    add  HL, HL         ; 1:11      1951 *   1  *2 = 18x
    add  HL, BC         ; 1:11      1951 *      +1 = 19x 
    add  HL, HL         ; 1:11      1951 *   1  *2 = 38x
    add  HL, BC         ; 1:11      1951 *      +1 = 39x 
    add  HL, HL         ; 1:11      1951 *   1  *2 = 78x
    add  HL, BC         ; 1:11      1951 *      +1 = 79x 
    add  HL, HL         ; 1:11      1951 *   1  *2 = 158x
    add  HL, BC         ; 1:11      1951 *      +1 = 159x 
    add   A, H          ; 1:4       1951 *
    ld    H, A          ; 1:4       1951 *     [1951x] = 159x + 1792x  
                        ;[15:123]   1953 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1010_0001)
    ld    B, H          ; 1:4       1953 *
    ld    C, L          ; 1:4       1953 *   1       1x = base 
    add  HL, HL         ; 1:11      1953 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1953 *   256*L = 512x 
    add  HL, HL         ; 1:11      1953 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1953 *      +1 = 5x 
    add   A, L          ; 1:4       1953 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1953 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1953 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1953 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1953 *   0  *2 = 80x 
    add  HL, HL         ; 1:11      1953 *   1  *2 = 160x
    add  HL, BC         ; 1:11      1953 *      +1 = 161x 
    add   A, H          ; 1:4       1953 *
    ld    H, A          ; 1:4       1953 *     [1953x] = 161x + 1792x  
                        ;[16:134]   1955 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1010_0011)
    ld    B, H          ; 1:4       1955 *
    ld    C, L          ; 1:4       1955 *   1       1x = base 
    add  HL, HL         ; 1:11      1955 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1955 *   256*L = 512x 
    add  HL, HL         ; 1:11      1955 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1955 *      +1 = 5x 
    add   A, L          ; 1:4       1955 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1955 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1955 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1955 *   0  *2 = 40x 
    add  HL, HL         ; 1:11      1955 *   1  *2 = 80x
    add  HL, BC         ; 1:11      1955 *      +1 = 81x 
    add  HL, HL         ; 1:11      1955 *   1  *2 = 162x
    add  HL, BC         ; 1:11      1955 *      +1 = 163x 
    add   A, H          ; 1:4       1955 *
    ld    H, A          ; 1:4       1955 *     [1955x] = 163x + 1792x 

                        ;[16:134]   1957 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1010_0101)
    ld    B, H          ; 1:4       1957 *
    ld    C, L          ; 1:4       1957 *   1       1x = base 
    add  HL, HL         ; 1:11      1957 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1957 *   256*L = 512x 
    add  HL, HL         ; 1:11      1957 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1957 *      +1 = 5x 
    add   A, L          ; 1:4       1957 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1957 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1957 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1957 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1957 *      +1 = 41x 
    add  HL, HL         ; 1:11      1957 *   0  *2 = 82x 
    add  HL, HL         ; 1:11      1957 *   1  *2 = 164x
    add  HL, BC         ; 1:11      1957 *      +1 = 165x 
    add   A, H          ; 1:4       1957 *
    ld    H, A          ; 1:4       1957 *     [1957x] = 165x + 1792x  
                        ;[17:145]   1959 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1010_0111)
    ld    B, H          ; 1:4       1959 *
    ld    C, L          ; 1:4       1959 *   1       1x = base 
    add  HL, HL         ; 1:11      1959 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1959 *   256*L = 512x 
    add  HL, HL         ; 1:11      1959 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1959 *      +1 = 5x 
    add   A, L          ; 1:4       1959 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1959 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1959 *   0  *2 = 20x 
    add  HL, HL         ; 1:11      1959 *   1  *2 = 40x
    add  HL, BC         ; 1:11      1959 *      +1 = 41x 
    add  HL, HL         ; 1:11      1959 *   1  *2 = 82x
    add  HL, BC         ; 1:11      1959 *      +1 = 83x 
    add  HL, HL         ; 1:11      1959 *   1  *2 = 166x
    add  HL, BC         ; 1:11      1959 *      +1 = 167x 
    add   A, H          ; 1:4       1959 *
    ld    H, A          ; 1:4       1959 *     [1959x] = 167x + 1792x  
                        ;[16:134]   1961 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1010_1001)
    ld    B, H          ; 1:4       1961 *
    ld    C, L          ; 1:4       1961 *   1       1x = base 
    add  HL, HL         ; 1:11      1961 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1961 *   256*L = 512x 
    add  HL, HL         ; 1:11      1961 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1961 *      +1 = 5x 
    add   A, L          ; 1:4       1961 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1961 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1961 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1961 *      +1 = 21x 
    add  HL, HL         ; 1:11      1961 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1961 *   0  *2 = 84x 
    add  HL, HL         ; 1:11      1961 *   1  *2 = 168x
    add  HL, BC         ; 1:11      1961 *      +1 = 169x 
    add   A, H          ; 1:4       1961 *
    ld    H, A          ; 1:4       1961 *     [1961x] = 169x + 1792x  
                        ;[17:145]   1963 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1010_1011)
    ld    B, H          ; 1:4       1963 *
    ld    C, L          ; 1:4       1963 *   1       1x = base 
    add  HL, HL         ; 1:11      1963 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1963 *   256*L = 512x 
    add  HL, HL         ; 1:11      1963 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1963 *      +1 = 5x 
    add   A, L          ; 1:4       1963 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1963 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1963 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1963 *      +1 = 21x 
    add  HL, HL         ; 1:11      1963 *   0  *2 = 42x 
    add  HL, HL         ; 1:11      1963 *   1  *2 = 84x
    add  HL, BC         ; 1:11      1963 *      +1 = 85x 
    add  HL, HL         ; 1:11      1963 *   1  *2 = 170x
    add  HL, BC         ; 1:11      1963 *      +1 = 171x 
    add   A, H          ; 1:4       1963 *
    ld    H, A          ; 1:4       1963 *     [1963x] = 171x + 1792x  
                        ;[17:145]   1965 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1010_1101)
    ld    B, H          ; 1:4       1965 *
    ld    C, L          ; 1:4       1965 *   1       1x = base 
    add  HL, HL         ; 1:11      1965 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1965 *   256*L = 512x 
    add  HL, HL         ; 1:11      1965 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1965 *      +1 = 5x 
    add   A, L          ; 1:4       1965 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1965 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1965 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1965 *      +1 = 21x 
    add  HL, HL         ; 1:11      1965 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1965 *      +1 = 43x 
    add  HL, HL         ; 1:11      1965 *   0  *2 = 86x 
    add  HL, HL         ; 1:11      1965 *   1  *2 = 172x
    add  HL, BC         ; 1:11      1965 *      +1 = 173x 
    add   A, H          ; 1:4       1965 *
    ld    H, A          ; 1:4       1965 *     [1965x] = 173x + 1792x  
                        ;[18:156]   1967 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1010_1111)
    ld    B, H          ; 1:4       1967 *
    ld    C, L          ; 1:4       1967 *   1       1x = base 
    add  HL, HL         ; 1:11      1967 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1967 *   256*L = 512x 
    add  HL, HL         ; 1:11      1967 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1967 *      +1 = 5x 
    add   A, L          ; 1:4       1967 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1967 *   0  *2 = 10x 
    add  HL, HL         ; 1:11      1967 *   1  *2 = 20x
    add  HL, BC         ; 1:11      1967 *      +1 = 21x 
    add  HL, HL         ; 1:11      1967 *   1  *2 = 42x
    add  HL, BC         ; 1:11      1967 *      +1 = 43x 
    add  HL, HL         ; 1:11      1967 *   1  *2 = 86x
    add  HL, BC         ; 1:11      1967 *      +1 = 87x 
    add  HL, HL         ; 1:11      1967 *   1  *2 = 174x
    add  HL, BC         ; 1:11      1967 *      +1 = 175x 
    add   A, H          ; 1:4       1967 *
    ld    H, A          ; 1:4       1967 *     [1967x] = 175x + 1792x  
                        ;[16:134]   1969 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1011_0001)
    ld    B, H          ; 1:4       1969 *
    ld    C, L          ; 1:4       1969 *   1       1x = base 
    add  HL, HL         ; 1:11      1969 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1969 *   256*L = 512x 
    add  HL, HL         ; 1:11      1969 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1969 *      +1 = 5x 
    add   A, L          ; 1:4       1969 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1969 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1969 *      +1 = 11x 
    add  HL, HL         ; 1:11      1969 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1969 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1969 *   0  *2 = 88x 
    add  HL, HL         ; 1:11      1969 *   1  *2 = 176x
    add  HL, BC         ; 1:11      1969 *      +1 = 177x 
    add   A, H          ; 1:4       1969 *
    ld    H, A          ; 1:4       1969 *     [1969x] = 177x + 1792x  
                        ;[17:145]   1971 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1011_0011)
    ld    B, H          ; 1:4       1971 *
    ld    C, L          ; 1:4       1971 *   1       1x = base 
    add  HL, HL         ; 1:11      1971 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1971 *   256*L = 512x 
    add  HL, HL         ; 1:11      1971 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1971 *      +1 = 5x 
    add   A, L          ; 1:4       1971 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1971 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1971 *      +1 = 11x 
    add  HL, HL         ; 1:11      1971 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1971 *   0  *2 = 44x 
    add  HL, HL         ; 1:11      1971 *   1  *2 = 88x
    add  HL, BC         ; 1:11      1971 *      +1 = 89x 
    add  HL, HL         ; 1:11      1971 *   1  *2 = 178x
    add  HL, BC         ; 1:11      1971 *      +1 = 179x 
    add   A, H          ; 1:4       1971 *
    ld    H, A          ; 1:4       1971 *     [1971x] = 179x + 1792x  
                        ;[17:145]   1973 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1011_0101)
    ld    B, H          ; 1:4       1973 *
    ld    C, L          ; 1:4       1973 *   1       1x = base 
    add  HL, HL         ; 1:11      1973 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1973 *   256*L = 512x 
    add  HL, HL         ; 1:11      1973 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1973 *      +1 = 5x 
    add   A, L          ; 1:4       1973 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1973 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1973 *      +1 = 11x 
    add  HL, HL         ; 1:11      1973 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1973 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1973 *      +1 = 45x 
    add  HL, HL         ; 1:11      1973 *   0  *2 = 90x 
    add  HL, HL         ; 1:11      1973 *   1  *2 = 180x
    add  HL, BC         ; 1:11      1973 *      +1 = 181x 
    add   A, H          ; 1:4       1973 *
    ld    H, A          ; 1:4       1973 *     [1973x] = 181x + 1792x 

                        ;[18:156]   1975 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1011_0111)
    ld    B, H          ; 1:4       1975 *
    ld    C, L          ; 1:4       1975 *   1       1x = base 
    add  HL, HL         ; 1:11      1975 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1975 *   256*L = 512x 
    add  HL, HL         ; 1:11      1975 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1975 *      +1 = 5x 
    add   A, L          ; 1:4       1975 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1975 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1975 *      +1 = 11x 
    add  HL, HL         ; 1:11      1975 *   0  *2 = 22x 
    add  HL, HL         ; 1:11      1975 *   1  *2 = 44x
    add  HL, BC         ; 1:11      1975 *      +1 = 45x 
    add  HL, HL         ; 1:11      1975 *   1  *2 = 90x
    add  HL, BC         ; 1:11      1975 *      +1 = 91x 
    add  HL, HL         ; 1:11      1975 *   1  *2 = 182x
    add  HL, BC         ; 1:11      1975 *      +1 = 183x 
    add   A, H          ; 1:4       1975 *
    ld    H, A          ; 1:4       1975 *     [1975x] = 183x + 1792x  
                        ;[17:145]   1977 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1011_1001)
    ld    B, H          ; 1:4       1977 *
    ld    C, L          ; 1:4       1977 *   1       1x = base 
    add  HL, HL         ; 1:11      1977 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1977 *   256*L = 512x 
    add  HL, HL         ; 1:11      1977 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1977 *      +1 = 5x 
    add   A, L          ; 1:4       1977 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1977 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1977 *      +1 = 11x 
    add  HL, HL         ; 1:11      1977 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1977 *      +1 = 23x 
    add  HL, HL         ; 1:11      1977 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1977 *   0  *2 = 92x 
    add  HL, HL         ; 1:11      1977 *   1  *2 = 184x
    add  HL, BC         ; 1:11      1977 *      +1 = 185x 
    add   A, H          ; 1:4       1977 *
    ld    H, A          ; 1:4       1977 *     [1977x] = 185x + 1792x  
                        ;[18:156]   1979 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1011_1011)
    ld    B, H          ; 1:4       1979 *
    ld    C, L          ; 1:4       1979 *   1       1x = base 
    add  HL, HL         ; 1:11      1979 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1979 *   256*L = 512x 
    add  HL, HL         ; 1:11      1979 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1979 *      +1 = 5x 
    add   A, L          ; 1:4       1979 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1979 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1979 *      +1 = 11x 
    add  HL, HL         ; 1:11      1979 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1979 *      +1 = 23x 
    add  HL, HL         ; 1:11      1979 *   0  *2 = 46x 
    add  HL, HL         ; 1:11      1979 *   1  *2 = 92x
    add  HL, BC         ; 1:11      1979 *      +1 = 93x 
    add  HL, HL         ; 1:11      1979 *   1  *2 = 186x
    add  HL, BC         ; 1:11      1979 *      +1 = 187x 
    add   A, H          ; 1:4       1979 *
    ld    H, A          ; 1:4       1979 *     [1979x] = 187x + 1792x  
                        ;[18:156]   1981 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1011_1101)
    ld    B, H          ; 1:4       1981 *
    ld    C, L          ; 1:4       1981 *   1       1x = base 
    add  HL, HL         ; 1:11      1981 *   0  *2 = 2x 
    ld    A, L          ; 1:4       1981 *   256*L = 512x 
    add  HL, HL         ; 1:11      1981 *   1  *2 = 4x
    add  HL, BC         ; 1:11      1981 *      +1 = 5x 
    add   A, L          ; 1:4       1981 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1981 *   1  *2 = 10x
    add  HL, BC         ; 1:11      1981 *      +1 = 11x 
    add  HL, HL         ; 1:11      1981 *   1  *2 = 22x
    add  HL, BC         ; 1:11      1981 *      +1 = 23x 
    add  HL, HL         ; 1:11      1981 *   1  *2 = 46x
    add  HL, BC         ; 1:11      1981 *      +1 = 47x 
    add  HL, HL         ; 1:11      1981 *   0  *2 = 94x 
    add  HL, HL         ; 1:11      1981 *   1  *2 = 188x
    add  HL, BC         ; 1:11      1981 *      +1 = 189x 
    add   A, H          ; 1:4       1981 *
    ld    H, A          ; 1:4       1981 *     [1981x] = 189x + 1792x  
                        ;[17:117]   1983 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0100_0001)  
    ld    B, H          ; 1:4       1983 *
    ld    C, L          ; 1:4       1983 *   [1x] 
    add  HL, HL         ; 1:11      1983 *   2x 
    add  HL, HL         ; 1:11      1983 *   4x 
    add  HL, HL         ; 1:11      1983 *   8x 
    ld    A, L          ; 1:4       1983 *   save --2048x-- 
    add  HL, HL         ; 1:11      1983 *   16x 
    add  HL, HL         ; 1:11      1983 *   32x 
    add  HL, HL         ; 1:11      1983 *   64x 
    add  HL, BC         ; 1:11      1983 *   [65x]
    ld    B, A          ; 1:4       1983 *   A0 - HL
    xor   A             ; 1:4       1983 *
    sub   L             ; 1:4       1983 *
    ld    L, A          ; 1:4       1983 *
    ld    A, B          ; 1:4       1983 *
    sbc   A, H          ; 1:4       1983 *
    ld    H, A          ; 1:4       1983 *   [1983x] = 2048x - 2048x    
                        ;[15:123]   1985 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1100_0001)
    ld    B, H          ; 1:4       1985 *
    ld    C, L          ; 1:4       1985 *   1       1x = base 
    ld    A, L          ; 1:4       1985 *   256*L = 256x 
    add  HL, HL         ; 1:11      1985 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1985 *      +1 = 3x 
    add  HL, HL         ; 1:11      1985 *   0  *2 = 6x 
    add   A, L          ; 1:4       1985 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1985 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1985 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1985 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1985 *   0  *2 = 96x 
    add  HL, HL         ; 1:11      1985 *   1  *2 = 192x
    add  HL, BC         ; 1:11      1985 *      +1 = 193x 
    add   A, H          ; 1:4       1985 *
    ld    H, A          ; 1:4       1985 *     [1985x] = 193x + 1792x  
                        ;[16:134]   1987 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1100_0011)
    ld    B, H          ; 1:4       1987 *
    ld    C, L          ; 1:4       1987 *   1       1x = base 
    ld    A, L          ; 1:4       1987 *   256*L = 256x 
    add  HL, HL         ; 1:11      1987 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1987 *      +1 = 3x 
    add  HL, HL         ; 1:11      1987 *   0  *2 = 6x 
    add   A, L          ; 1:4       1987 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1987 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1987 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1987 *   0  *2 = 48x 
    add  HL, HL         ; 1:11      1987 *   1  *2 = 96x
    add  HL, BC         ; 1:11      1987 *      +1 = 97x 
    add  HL, HL         ; 1:11      1987 *   1  *2 = 194x
    add  HL, BC         ; 1:11      1987 *      +1 = 195x 
    add   A, H          ; 1:4       1987 *
    ld    H, A          ; 1:4       1987 *     [1987x] = 195x + 1792x  
                        ;[16:134]   1989 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1100_0101)
    ld    B, H          ; 1:4       1989 *
    ld    C, L          ; 1:4       1989 *   1       1x = base 
    ld    A, L          ; 1:4       1989 *   256*L = 256x 
    add  HL, HL         ; 1:11      1989 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1989 *      +1 = 3x 
    add  HL, HL         ; 1:11      1989 *   0  *2 = 6x 
    add   A, L          ; 1:4       1989 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1989 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1989 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1989 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1989 *      +1 = 49x 
    add  HL, HL         ; 1:11      1989 *   0  *2 = 98x 
    add  HL, HL         ; 1:11      1989 *   1  *2 = 196x
    add  HL, BC         ; 1:11      1989 *      +1 = 197x 
    add   A, H          ; 1:4       1989 *
    ld    H, A          ; 1:4       1989 *     [1989x] = 197x + 1792x  
                        ;[17:145]   1991 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1100_0111)
    ld    B, H          ; 1:4       1991 *
    ld    C, L          ; 1:4       1991 *   1       1x = base 
    ld    A, L          ; 1:4       1991 *   256*L = 256x 
    add  HL, HL         ; 1:11      1991 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1991 *      +1 = 3x 
    add  HL, HL         ; 1:11      1991 *   0  *2 = 6x 
    add   A, L          ; 1:4       1991 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1991 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1991 *   0  *2 = 24x 
    add  HL, HL         ; 1:11      1991 *   1  *2 = 48x
    add  HL, BC         ; 1:11      1991 *      +1 = 49x 
    add  HL, HL         ; 1:11      1991 *   1  *2 = 98x
    add  HL, BC         ; 1:11      1991 *      +1 = 99x 
    add  HL, HL         ; 1:11      1991 *   1  *2 = 198x
    add  HL, BC         ; 1:11      1991 *      +1 = 199x 
    add   A, H          ; 1:4       1991 *
    ld    H, A          ; 1:4       1991 *     [1991x] = 199x + 1792x 

                        ;[16:134]   1993 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1100_1001)
    ld    B, H          ; 1:4       1993 *
    ld    C, L          ; 1:4       1993 *   1       1x = base 
    ld    A, L          ; 1:4       1993 *   256*L = 256x 
    add  HL, HL         ; 1:11      1993 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1993 *      +1 = 3x 
    add  HL, HL         ; 1:11      1993 *   0  *2 = 6x 
    add   A, L          ; 1:4       1993 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1993 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1993 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1993 *      +1 = 25x 
    add  HL, HL         ; 1:11      1993 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1993 *   0  *2 = 100x 
    add  HL, HL         ; 1:11      1993 *   1  *2 = 200x
    add  HL, BC         ; 1:11      1993 *      +1 = 201x 
    add   A, H          ; 1:4       1993 *
    ld    H, A          ; 1:4       1993 *     [1993x] = 201x + 1792x  
                        ;[17:145]   1995 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1100_1011)
    ld    B, H          ; 1:4       1995 *
    ld    C, L          ; 1:4       1995 *   1       1x = base 
    ld    A, L          ; 1:4       1995 *   256*L = 256x 
    add  HL, HL         ; 1:11      1995 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1995 *      +1 = 3x 
    add  HL, HL         ; 1:11      1995 *   0  *2 = 6x 
    add   A, L          ; 1:4       1995 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1995 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1995 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1995 *      +1 = 25x 
    add  HL, HL         ; 1:11      1995 *   0  *2 = 50x 
    add  HL, HL         ; 1:11      1995 *   1  *2 = 100x
    add  HL, BC         ; 1:11      1995 *      +1 = 101x 
    add  HL, HL         ; 1:11      1995 *   1  *2 = 202x
    add  HL, BC         ; 1:11      1995 *      +1 = 203x 
    add   A, H          ; 1:4       1995 *
    ld    H, A          ; 1:4       1995 *     [1995x] = 203x + 1792x  
                        ;[17:145]   1997 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1100_1101)
    ld    B, H          ; 1:4       1997 *
    ld    C, L          ; 1:4       1997 *   1       1x = base 
    ld    A, L          ; 1:4       1997 *   256*L = 256x 
    add  HL, HL         ; 1:11      1997 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1997 *      +1 = 3x 
    add  HL, HL         ; 1:11      1997 *   0  *2 = 6x 
    add   A, L          ; 1:4       1997 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1997 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1997 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1997 *      +1 = 25x 
    add  HL, HL         ; 1:11      1997 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1997 *      +1 = 51x 
    add  HL, HL         ; 1:11      1997 *   0  *2 = 102x 
    add  HL, HL         ; 1:11      1997 *   1  *2 = 204x
    add  HL, BC         ; 1:11      1997 *      +1 = 205x 
    add   A, H          ; 1:4       1997 *
    ld    H, A          ; 1:4       1997 *     [1997x] = 205x + 1792x  
                        ;[18:156]   1999 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1100_1111)
    ld    B, H          ; 1:4       1999 *
    ld    C, L          ; 1:4       1999 *   1       1x = base 
    ld    A, L          ; 1:4       1999 *   256*L = 256x 
    add  HL, HL         ; 1:11      1999 *   1  *2 = 2x
    add  HL, BC         ; 1:11      1999 *      +1 = 3x 
    add  HL, HL         ; 1:11      1999 *   0  *2 = 6x 
    add   A, L          ; 1:4       1999 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      1999 *   0  *2 = 12x 
    add  HL, HL         ; 1:11      1999 *   1  *2 = 24x
    add  HL, BC         ; 1:11      1999 *      +1 = 25x 
    add  HL, HL         ; 1:11      1999 *   1  *2 = 50x
    add  HL, BC         ; 1:11      1999 *      +1 = 51x 
    add  HL, HL         ; 1:11      1999 *   1  *2 = 102x
    add  HL, BC         ; 1:11      1999 *      +1 = 103x 
    add  HL, HL         ; 1:11      1999 *   1  *2 = 206x
    add  HL, BC         ; 1:11      1999 *      +1 = 207x 
    add   A, H          ; 1:4       1999 *
    ld    H, A          ; 1:4       1999 *     [1999x] = 207x + 1792x  
                        ;[16:134]   2001 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1101_0001)
    ld    B, H          ; 1:4       2001 *
    ld    C, L          ; 1:4       2001 *   1       1x = base 
    ld    A, L          ; 1:4       2001 *   256*L = 256x 
    add  HL, HL         ; 1:11      2001 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2001 *      +1 = 3x 
    add  HL, HL         ; 1:11      2001 *   0  *2 = 6x 
    add   A, L          ; 1:4       2001 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      2001 *   1  *2 = 12x
    add  HL, BC         ; 1:11      2001 *      +1 = 13x 
    add  HL, HL         ; 1:11      2001 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      2001 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      2001 *   0  *2 = 104x 
    add  HL, HL         ; 1:11      2001 *   1  *2 = 208x
    add  HL, BC         ; 1:11      2001 *      +1 = 209x 
    add   A, H          ; 1:4       2001 *
    ld    H, A          ; 1:4       2001 *     [2001x] = 209x + 1792x  
                        ;[17:145]   2003 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1101_0011)
    ld    B, H          ; 1:4       2003 *
    ld    C, L          ; 1:4       2003 *   1       1x = base 
    ld    A, L          ; 1:4       2003 *   256*L = 256x 
    add  HL, HL         ; 1:11      2003 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2003 *      +1 = 3x 
    add  HL, HL         ; 1:11      2003 *   0  *2 = 6x 
    add   A, L          ; 1:4       2003 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      2003 *   1  *2 = 12x
    add  HL, BC         ; 1:11      2003 *      +1 = 13x 
    add  HL, HL         ; 1:11      2003 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      2003 *   0  *2 = 52x 
    add  HL, HL         ; 1:11      2003 *   1  *2 = 104x
    add  HL, BC         ; 1:11      2003 *      +1 = 105x 
    add  HL, HL         ; 1:11      2003 *   1  *2 = 210x
    add  HL, BC         ; 1:11      2003 *      +1 = 211x 
    add   A, H          ; 1:4       2003 *
    ld    H, A          ; 1:4       2003 *     [2003x] = 211x + 1792x  
                        ;[17:145]   2005 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1101_0101)
    ld    B, H          ; 1:4       2005 *
    ld    C, L          ; 1:4       2005 *   1       1x = base 
    ld    A, L          ; 1:4       2005 *   256*L = 256x 
    add  HL, HL         ; 1:11      2005 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2005 *      +1 = 3x 
    add  HL, HL         ; 1:11      2005 *   0  *2 = 6x 
    add   A, L          ; 1:4       2005 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      2005 *   1  *2 = 12x
    add  HL, BC         ; 1:11      2005 *      +1 = 13x 
    add  HL, HL         ; 1:11      2005 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      2005 *   1  *2 = 52x
    add  HL, BC         ; 1:11      2005 *      +1 = 53x 
    add  HL, HL         ; 1:11      2005 *   0  *2 = 106x 
    add  HL, HL         ; 1:11      2005 *   1  *2 = 212x
    add  HL, BC         ; 1:11      2005 *      +1 = 213x 
    add   A, H          ; 1:4       2005 *
    ld    H, A          ; 1:4       2005 *     [2005x] = 213x + 1792x  
                        ;[18:156]   2007 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1101_0111)
    ld    B, H          ; 1:4       2007 *
    ld    C, L          ; 1:4       2007 *   1       1x = base 
    ld    A, L          ; 1:4       2007 *   256*L = 256x 
    add  HL, HL         ; 1:11      2007 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2007 *      +1 = 3x 
    add  HL, HL         ; 1:11      2007 *   0  *2 = 6x 
    add   A, L          ; 1:4       2007 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      2007 *   1  *2 = 12x
    add  HL, BC         ; 1:11      2007 *      +1 = 13x 
    add  HL, HL         ; 1:11      2007 *   0  *2 = 26x 
    add  HL, HL         ; 1:11      2007 *   1  *2 = 52x
    add  HL, BC         ; 1:11      2007 *      +1 = 53x 
    add  HL, HL         ; 1:11      2007 *   1  *2 = 106x
    add  HL, BC         ; 1:11      2007 *      +1 = 107x 
    add  HL, HL         ; 1:11      2007 *   1  *2 = 214x
    add  HL, BC         ; 1:11      2007 *      +1 = 215x 
    add   A, H          ; 1:4       2007 *
    ld    H, A          ; 1:4       2007 *     [2007x] = 215x + 1792x  
                        ;[17:145]   2009 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1101_1001)
    ld    B, H          ; 1:4       2009 *
    ld    C, L          ; 1:4       2009 *   1       1x = base 
    ld    A, L          ; 1:4       2009 *   256*L = 256x 
    add  HL, HL         ; 1:11      2009 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2009 *      +1 = 3x 
    add  HL, HL         ; 1:11      2009 *   0  *2 = 6x 
    add   A, L          ; 1:4       2009 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      2009 *   1  *2 = 12x
    add  HL, BC         ; 1:11      2009 *      +1 = 13x 
    add  HL, HL         ; 1:11      2009 *   1  *2 = 26x
    add  HL, BC         ; 1:11      2009 *      +1 = 27x 
    add  HL, HL         ; 1:11      2009 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      2009 *   0  *2 = 108x 
    add  HL, HL         ; 1:11      2009 *   1  *2 = 216x
    add  HL, BC         ; 1:11      2009 *      +1 = 217x 
    add   A, H          ; 1:4       2009 *
    ld    H, A          ; 1:4       2009 *     [2009x] = 217x + 1792x 

                        ;[18:156]   2011 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1101_1011)
    ld    B, H          ; 1:4       2011 *
    ld    C, L          ; 1:4       2011 *   1       1x = base 
    ld    A, L          ; 1:4       2011 *   256*L = 256x 
    add  HL, HL         ; 1:11      2011 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2011 *      +1 = 3x 
    add  HL, HL         ; 1:11      2011 *   0  *2 = 6x 
    add   A, L          ; 1:4       2011 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      2011 *   1  *2 = 12x
    add  HL, BC         ; 1:11      2011 *      +1 = 13x 
    add  HL, HL         ; 1:11      2011 *   1  *2 = 26x
    add  HL, BC         ; 1:11      2011 *      +1 = 27x 
    add  HL, HL         ; 1:11      2011 *   0  *2 = 54x 
    add  HL, HL         ; 1:11      2011 *   1  *2 = 108x
    add  HL, BC         ; 1:11      2011 *      +1 = 109x 
    add  HL, HL         ; 1:11      2011 *   1  *2 = 218x
    add  HL, BC         ; 1:11      2011 *      +1 = 219x 
    add   A, H          ; 1:4       2011 *
    ld    H, A          ; 1:4       2011 *     [2011x] = 219x + 1792x  
                        ;[18:156]   2013 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1101_1101)
    ld    B, H          ; 1:4       2013 *
    ld    C, L          ; 1:4       2013 *   1       1x = base 
    ld    A, L          ; 1:4       2013 *   256*L = 256x 
    add  HL, HL         ; 1:11      2013 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2013 *      +1 = 3x 
    add  HL, HL         ; 1:11      2013 *   0  *2 = 6x 
    add   A, L          ; 1:4       2013 *  +256*L = 1792x 
    add  HL, HL         ; 1:11      2013 *   1  *2 = 12x
    add  HL, BC         ; 1:11      2013 *      +1 = 13x 
    add  HL, HL         ; 1:11      2013 *   1  *2 = 26x
    add  HL, BC         ; 1:11      2013 *      +1 = 27x 
    add  HL, HL         ; 1:11      2013 *   1  *2 = 54x
    add  HL, BC         ; 1:11      2013 *      +1 = 55x 
    add  HL, HL         ; 1:11      2013 *   0  *2 = 110x 
    add  HL, HL         ; 1:11      2013 *   1  *2 = 220x
    add  HL, BC         ; 1:11      2013 *      +1 = 221x 
    add   A, H          ; 1:4       2013 *
    ld    H, A          ; 1:4       2013 *     [2013x] = 221x + 1792x  
                        ;[16:106]   2015 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0010_0001)  
    ld    B, H          ; 1:4       2015 *
    ld    C, L          ; 1:4       2015 *   [1x] 
    add  HL, HL         ; 1:11      2015 *   2x 
    add  HL, HL         ; 1:11      2015 *   4x 
    add  HL, HL         ; 1:11      2015 *   8x 
    ld    A, L          ; 1:4       2015 *   save --2048x-- 
    add  HL, HL         ; 1:11      2015 *   16x 
    add  HL, HL         ; 1:11      2015 *   32x 
    add  HL, BC         ; 1:11      2015 *   [33x]
    ld    B, A          ; 1:4       2015 *   A0 - HL
    xor   A             ; 1:4       2015 *
    sub   L             ; 1:4       2015 *
    ld    L, A          ; 1:4       2015 *
    ld    A, B          ; 1:4       2015 *
    sbc   A, H          ; 1:4       2015 *
    ld    H, A          ; 1:4       2015 *   [2015x] = 2048x - 2048x    
                        ;[15:130]   2017 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1110_0001)
    ld    B, H          ; 1:4       2017 *
    ld    C, L          ; 1:4       2017 *   1       1x = base 
    add  HL, HL         ; 1:11      2017 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2017 *      +1 = 3x 
    add  HL, HL         ; 1:11      2017 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2017 *      +1 = 7x 
    ld    A, L          ; 1:4       2017 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2017 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      2017 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      2017 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      2017 *   0  *2 = 112x 
    add  HL, HL         ; 1:11      2017 *   1  *2 = 224x
    add  HL, BC         ; 1:11      2017 *      +1 = 225x 
    add   A, H          ; 1:4       2017 *
    ld    H, A          ; 1:4       2017 *     [2017x] = 225x + 1792x  
                        ;[16:141]   2019 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1110_0011)
    ld    B, H          ; 1:4       2019 *
    ld    C, L          ; 1:4       2019 *   1       1x = base 
    add  HL, HL         ; 1:11      2019 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2019 *      +1 = 3x 
    add  HL, HL         ; 1:11      2019 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2019 *      +1 = 7x 
    ld    A, L          ; 1:4       2019 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2019 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      2019 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      2019 *   0  *2 = 56x 
    add  HL, HL         ; 1:11      2019 *   1  *2 = 112x
    add  HL, BC         ; 1:11      2019 *      +1 = 113x 
    add  HL, HL         ; 1:11      2019 *   1  *2 = 226x
    add  HL, BC         ; 1:11      2019 *      +1 = 227x 
    add   A, H          ; 1:4       2019 *
    ld    H, A          ; 1:4       2019 *     [2019x] = 227x + 1792x  
                        ;[16:141]   2021 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1110_0101)
    ld    B, H          ; 1:4       2021 *
    ld    C, L          ; 1:4       2021 *   1       1x = base 
    add  HL, HL         ; 1:11      2021 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2021 *      +1 = 3x 
    add  HL, HL         ; 1:11      2021 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2021 *      +1 = 7x 
    ld    A, L          ; 1:4       2021 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2021 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      2021 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      2021 *   1  *2 = 56x
    add  HL, BC         ; 1:11      2021 *      +1 = 57x 
    add  HL, HL         ; 1:11      2021 *   0  *2 = 114x 
    add  HL, HL         ; 1:11      2021 *   1  *2 = 228x
    add  HL, BC         ; 1:11      2021 *      +1 = 229x 
    add   A, H          ; 1:4       2021 *
    ld    H, A          ; 1:4       2021 *     [2021x] = 229x + 1792x  
                        ;[17:152]   2023 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1110_0111)
    ld    B, H          ; 1:4       2023 *
    ld    C, L          ; 1:4       2023 *   1       1x = base 
    add  HL, HL         ; 1:11      2023 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2023 *      +1 = 3x 
    add  HL, HL         ; 1:11      2023 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2023 *      +1 = 7x 
    ld    A, L          ; 1:4       2023 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2023 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      2023 *   0  *2 = 28x 
    add  HL, HL         ; 1:11      2023 *   1  *2 = 56x
    add  HL, BC         ; 1:11      2023 *      +1 = 57x 
    add  HL, HL         ; 1:11      2023 *   1  *2 = 114x
    add  HL, BC         ; 1:11      2023 *      +1 = 115x 
    add  HL, HL         ; 1:11      2023 *   1  *2 = 230x
    add  HL, BC         ; 1:11      2023 *      +1 = 231x 
    add   A, H          ; 1:4       2023 *
    ld    H, A          ; 1:4       2023 *     [2023x] = 231x + 1792x  
                        ;[16:141]   2025 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1110_1001)
    ld    B, H          ; 1:4       2025 *
    ld    C, L          ; 1:4       2025 *   1       1x = base 
    add  HL, HL         ; 1:11      2025 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2025 *      +1 = 3x 
    add  HL, HL         ; 1:11      2025 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2025 *      +1 = 7x 
    ld    A, L          ; 1:4       2025 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2025 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      2025 *   1  *2 = 28x
    add  HL, BC         ; 1:11      2025 *      +1 = 29x 
    add  HL, HL         ; 1:11      2025 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      2025 *   0  *2 = 116x 
    add  HL, HL         ; 1:11      2025 *   1  *2 = 232x
    add  HL, BC         ; 1:11      2025 *      +1 = 233x 
    add   A, H          ; 1:4       2025 *
    ld    H, A          ; 1:4       2025 *     [2025x] = 233x + 1792x  
                        ;[17:152]   2027 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1110_1011)
    ld    B, H          ; 1:4       2027 *
    ld    C, L          ; 1:4       2027 *   1       1x = base 
    add  HL, HL         ; 1:11      2027 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2027 *      +1 = 3x 
    add  HL, HL         ; 1:11      2027 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2027 *      +1 = 7x 
    ld    A, L          ; 1:4       2027 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2027 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      2027 *   1  *2 = 28x
    add  HL, BC         ; 1:11      2027 *      +1 = 29x 
    add  HL, HL         ; 1:11      2027 *   0  *2 = 58x 
    add  HL, HL         ; 1:11      2027 *   1  *2 = 116x
    add  HL, BC         ; 1:11      2027 *      +1 = 117x 
    add  HL, HL         ; 1:11      2027 *   1  *2 = 234x
    add  HL, BC         ; 1:11      2027 *      +1 = 235x 
    add   A, H          ; 1:4       2027 *
    ld    H, A          ; 1:4       2027 *     [2027x] = 235x + 1792x 

                        ;[17:152]   2029 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1110_1101)
    ld    B, H          ; 1:4       2029 *
    ld    C, L          ; 1:4       2029 *   1       1x = base 
    add  HL, HL         ; 1:11      2029 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2029 *      +1 = 3x 
    add  HL, HL         ; 1:11      2029 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2029 *      +1 = 7x 
    ld    A, L          ; 1:4       2029 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2029 *   0  *2 = 14x 
    add  HL, HL         ; 1:11      2029 *   1  *2 = 28x
    add  HL, BC         ; 1:11      2029 *      +1 = 29x 
    add  HL, HL         ; 1:11      2029 *   1  *2 = 58x
    add  HL, BC         ; 1:11      2029 *      +1 = 59x 
    add  HL, HL         ; 1:11      2029 *   0  *2 = 118x 
    add  HL, HL         ; 1:11      2029 *   1  *2 = 236x
    add  HL, BC         ; 1:11      2029 *      +1 = 237x 
    add   A, H          ; 1:4       2029 *
    ld    H, A          ; 1:4       2029 *     [2029x] = 237x + 1792x  
                        ;[15:95]    2031 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_0001_0001)  
    ld    B, H          ; 1:4       2031 *
    ld    C, L          ; 1:4       2031 *   [1x] 
    add  HL, HL         ; 1:11      2031 *   2x 
    add  HL, HL         ; 1:11      2031 *   4x 
    add  HL, HL         ; 1:11      2031 *   8x 
    ld    A, L          ; 1:4       2031 *   save --2048x-- 
    add  HL, HL         ; 1:11      2031 *   16x 
    add  HL, BC         ; 1:11      2031 *   [17x]
    ld    B, A          ; 1:4       2031 *   A0 - HL
    xor   A             ; 1:4       2031 *
    sub   L             ; 1:4       2031 *
    ld    L, A          ; 1:4       2031 *
    ld    A, B          ; 1:4       2031 *
    sbc   A, H          ; 1:4       2031 *
    ld    H, A          ; 1:4       2031 *   [2031x] = 2048x - 2048x    
                        ;[16:141]   2033 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1111_0001)
    ld    B, H          ; 1:4       2033 *
    ld    C, L          ; 1:4       2033 *   1       1x = base 
    add  HL, HL         ; 1:11      2033 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2033 *      +1 = 3x 
    add  HL, HL         ; 1:11      2033 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2033 *      +1 = 7x 
    ld    A, L          ; 1:4       2033 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2033 *   1  *2 = 14x
    add  HL, BC         ; 1:11      2033 *      +1 = 15x 
    add  HL, HL         ; 1:11      2033 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      2033 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      2033 *   0  *2 = 120x 
    add  HL, HL         ; 1:11      2033 *   1  *2 = 240x
    add  HL, BC         ; 1:11      2033 *      +1 = 241x 
    add   A, H          ; 1:4       2033 *
    ld    H, A          ; 1:4       2033 *     [2033x] = 241x + 1792x  
                        ;[17:152]   2035 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1111_0011)
    ld    B, H          ; 1:4       2035 *
    ld    C, L          ; 1:4       2035 *   1       1x = base 
    add  HL, HL         ; 1:11      2035 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2035 *      +1 = 3x 
    add  HL, HL         ; 1:11      2035 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2035 *      +1 = 7x 
    ld    A, L          ; 1:4       2035 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2035 *   1  *2 = 14x
    add  HL, BC         ; 1:11      2035 *      +1 = 15x 
    add  HL, HL         ; 1:11      2035 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      2035 *   0  *2 = 60x 
    add  HL, HL         ; 1:11      2035 *   1  *2 = 120x
    add  HL, BC         ; 1:11      2035 *      +1 = 121x 
    add  HL, HL         ; 1:11      2035 *   1  *2 = 242x
    add  HL, BC         ; 1:11      2035 *      +1 = 243x 
    add   A, H          ; 1:4       2035 *
    ld    H, A          ; 1:4       2035 *     [2035x] = 243x + 1792x  
                        ;[17:152]   2037 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1111_0101)
    ld    B, H          ; 1:4       2037 *
    ld    C, L          ; 1:4       2037 *   1       1x = base 
    add  HL, HL         ; 1:11      2037 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2037 *      +1 = 3x 
    add  HL, HL         ; 1:11      2037 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2037 *      +1 = 7x 
    ld    A, L          ; 1:4       2037 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2037 *   1  *2 = 14x
    add  HL, BC         ; 1:11      2037 *      +1 = 15x 
    add  HL, HL         ; 1:11      2037 *   0  *2 = 30x 
    add  HL, HL         ; 1:11      2037 *   1  *2 = 60x
    add  HL, BC         ; 1:11      2037 *      +1 = 61x 
    add  HL, HL         ; 1:11      2037 *   0  *2 = 122x 
    add  HL, HL         ; 1:11      2037 *   1  *2 = 244x
    add  HL, BC         ; 1:11      2037 *      +1 = 245x 
    add   A, H          ; 1:4       2037 *
    ld    H, A          ; 1:4       2037 *     [2037x] = 245x + 1792x  
                        ;[14:84]    2039 *   Variant mk3: HL * (256*a^2 - b^2 - ...) = HL * (b_1000_0000_0000 - b_1001)  
    ld    B, H          ; 1:4       2039 *
    ld    C, L          ; 1:4       2039 *   [1x] 
    add  HL, HL         ; 1:11      2039 *   2x 
    add  HL, HL         ; 1:11      2039 *   4x 
    add  HL, HL         ; 1:11      2039 *   8x 
    ld    A, L          ; 1:4       2039 *   L0 - (HL + BC) --> B0 - HL
    add  HL, BC         ; 1:11      2039 *   [9x]
    ld    B, A          ; 1:4       2039 *
    xor   A             ; 1:4       2039 *
    sub   L             ; 1:4       2039 *
    ld    L, A          ; 1:4       2039 *
    ld    A, B          ; 1:4       2039 *
    sbc   A, H          ; 1:4       2039 *
    ld    H, A          ; 1:4       2039 *   [2039x] = 2048x - 9x    
                        ;[17:152]   2041 *   Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+... = HL * (b_0111_1111_1001)
    ld    B, H          ; 1:4       2041 *
    ld    C, L          ; 1:4       2041 *   1       1x = base 
    add  HL, HL         ; 1:11      2041 *   1  *2 = 2x
    add  HL, BC         ; 1:11      2041 *      +1 = 3x 
    add  HL, HL         ; 1:11      2041 *   1  *2 = 6x
    add  HL, BC         ; 1:11      2041 *      +1 = 7x 
    ld    A, L          ; 1:4       2041 *   256*L = 1792x 
    add  HL, HL         ; 1:11      2041 *   1  *2 = 14x
    add  HL, BC         ; 1:11      2041 *      +1 = 15x 
    add  HL, HL         ; 1:11      2041 *   1  *2 = 30x
    add  HL, BC         ; 1:11      2041 *      +1 = 31x 
    add  HL, HL         ; 1:11      2041 *   0  *2 = 62x 
    add  HL, HL         ; 1:11      2041 *   0  *2 = 124x 
    add  HL, HL         ; 1:11      2041 *   1  *2 = 248x
    add  HL, BC         ; 1:11      2041 *      +1 = 249x 
    add   A, H          ; 1:4       2041 *
    ld    H, A          ; 1:4       2041 *     [2041x] = 249x + 1792x  
                        ;[16:91]    2043 *   Variant mk1: HL * (2^a - 2^b - 2^c) = HL * (b_0111_1111_1011)   
    ld    B, H          ; 1:4       2043 *
    ld    A, L          ; 1:4       2043 *   [1x] 
    add  HL, HL         ; 1:11      2043 *   2x 
    add  HL, HL         ; 1:11      2043 *   4x 
    add   A, L          ; 1:4       2043 *
    ld    C, A          ; 1:4       2043 *
    ld    A, B          ; 1:4       2043 *
    adc   A, H          ; 1:4       2043 *
    ld    B, A          ; 1:4       2043 *   [5x] 
    ld    H, L          ; 1:4       2043 *
    ld    L, 0x00       ; 2:7       2043 *   1024x 
    add  HL, HL         ; 1:11      2043 *   2048x 
    or    A             ; 1:4       2043 *
    sbc  HL, BC         ; 2:15      2043 *   [2043x] = 2048x - 5x   
                        ;[16:91]    2045 *   Variant mk1: HL * (2^a - 2^b - 2^c) = HL * (b_0111_1111_1101)   
    ld    B, H          ; 1:4       2045 *
    ld    A, L          ; 1:4       2045 *   [1x] 
    add  HL, HL         ; 1:11      2045 *   2x 
    add   A, L          ; 1:4       2045 *
    ld    C, A          ; 1:4       2045 *
    ld    A, B          ; 1:4       2045 *
    adc   A, H          ; 1:4       2045 *
    ld    B, A          ; 1:4       2045 *   [3x] 
    ld    H, L          ; 1:4       2045 *
    ld    L, 0x00       ; 2:7       2045 *   512x 
    add  HL, HL         ; 1:11      2045 *   1024x 
    add  HL, HL         ; 1:11      2045 *   2048x 
    or    A             ; 1:4       2045 *
    sbc  HL, BC         ; 2:15      2045 *   [2045x] = 2048x - 3x  

                        ;[11:71]    2047 *   Variant mk1: HL * (2^a - 2^b) = HL * (b_0111_1111_1111)   
    ld    B, H          ; 1:4       2047 *
    ld    C, L          ; 1:4       2047 *   [1x] 
    ld    H, L          ; 1:4       2047 *
    ld    L, 0x00       ; 2:7       2047 *   256x 
    add  HL, HL         ; 1:11      2047 *   512x 
    add  HL, HL         ; 1:11      2047 *   1024x 
    add  HL, HL         ; 1:11      2047 *   2048x 
    or    A             ; 1:4       2047 *
    sbc  HL, BC         ; 2:15      2047 *   [2047x] = 2048x - 1x   
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print


Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  ===== 


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

STRING_SECTION:
string101:
db " = -14335", 0xD
size101 EQU $ - string101


## Game section

### Snake

https://github.com/DW0RKiN/M4_FORTH/blob/master/Game/snake.m4
![Snake Game screenshot](https://github.com/DW0RKiN/M4_FORTH/blob/master/Game/snake.png)

Eat the food at the coordinate point, but don't eat yourself!

    q   up
    a   down
    o   left
    p   right

### Conway's Game of Life

https://github.com/DW0RKiN/M4_FORTH/blob/master/Game/life.m4
![Conway's Game of Life screenshot](https://github.com/DW0RKiN/M4_FORTH/blob/master/Game/life.png)

Rules:
- Any live cell with two or three live neighbours survives. 
- Any dead cell with three live neighbours becomes a live cell.
- All other live cells die in the next generation. Similarly, all other dead cells stay dead.

Endless playing area. One edge follows the other edge.
So I had to take care of this when underlining the left edge:
    dup 1- 0x1F and swap 0xFFE0 and +
or if applicable at the overflow of the right edge:
    dup 1+ 0x1F and swap 0xFFE0 and +
Where the verbal description of this piece of code is: make a copy of a 16-bit address, add or subtract one, leave only the lower 5 bits, swap with the original, reset the lower 5 bits and add the numbers.

And because the whole program is an M4 macro, I could immediately create the words LEFT and RIGHT in the program and use them. It looks clear and it's much more powerful and shorter, because I only work with an 8-bit value.

; dup 1- 0x1F and swap 0xFFE0 and +
define({LEFT},{
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left})dnl

; dup 1+ 0x1F and swap 0xFFE0 and +
define({RIGHT},{
    ld    A, L          ; 1:4       right
    inc   A             ; 1:4       right
    xor   L             ; 1:4       right
    and  0x1F           ; 2:7       right
    xor   L             ; 1:4       right
    ld    L, A          ; 1:4       right})dnl
    
So the part that counts living neighbors looks like this:

    SCOLON(sum_neighbors,( addr -- sum ))
        ; [-1]
        DUP  LEFT
        ; [+1]
        SWAP RIGHT
        ; [+33]
        DUP PUSH(_w) ADD
        DUP_PUSH_GE_IF(_stop)
            PUSH(-_w*_h) ADD
        THEN
        ; [+32]
        DUP  LEFT
        ; [+31]
        DUP  LEFT
        ; [-33]
        DUP PUSH(-2*_w) ADD
        DUP_PUSH_LT_IF(_screen)
            PUSH(_w*_h) ADD
        THEN
        ; [-32]
        DUP  RIGHT
        ; [-31]
        DUP  RIGHT

        FETCH 
        SWAP FETCH ADD
        SWAP FETCH ADD
        SWAP FETCH ADD
        SWAP FETCH ADD
        SWAP FETCH ADD
        SWAP FETCH ADD
        SWAP FETCH ADD
    SSEMICOLON

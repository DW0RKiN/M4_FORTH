;# Forth program from https://skilldrick.github.io/easyforth/
;# by Nick Morgan

    ORG 0x8000
    
    
    

















snake_x_head         EQU __create_snake_x_head



















     
                 
          
    

     
                
          
    



    



    



      
    
             
                 
    
      



       



      



     
         
              
        
    
    
    
    



     



     



     



     



     
           
               
         
         
        


; Move each segment of the snake forward by one

      
               
               
    



      
       
      



      
         
       


          

          

        

         


        
          
       
      
      



     
    
      


; get random x or y position within playable area

       



       
    



     



        
        

     
        
        
    


 ;( -- flag )
    ; get current x/y position
       

    

    ; leave boolean flag on stack
    



       
              
    

       
       
    



         


; x = 20*x ms

    
    
    


 ;( -- )
    
        
        
         
        
        
        
        
        
    
    


   

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    call start          ; 3:17      scall
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
left                 EQU 0
up                   EQU 1
right                EQU 2
down                 EQU 3
width                EQU 32
height               EQU 24
white                EQU 0x3F
red                  EQU 0x24
black                EQU 0
graphics             EQU 0x5800
last_key             EQU 0x5C08
snake_y_head         EQU snake_x_head+2*500

;( x y -- )
; C = color
put_color:
    ld    A, L          ; 1:4
    add   A, A          ; 1:4       2x 24->48
    add   A, A          ; 1:4       4x 48->96
    add   A, A          ; 1:4       8x 96->192
    ld    L, A          ; 1:4
    add  HL, HL         ; 1:11      16x 192->384
    add  HL, HL         ; 1:11      32x 384->768
    add  HL, DE         ; 1:11
    ld   DE, 0x5800   ; 3:10
    add  HL, DE         ; 1:11
    ld   (HL), C        ; 1:7
    ret                 ; 1:10

;( x y -- color )
get_color:
    ld    A, L          ; 1:4
    add   A, A          ; 1:4       2x 24->48
    add   A, A          ; 1:4       4x 48->96
    add   A, A          ; 1:4       8x 96->192
    ld    L, A          ; 1:4
    add  HL, HL         ; 1:11      16x 192->384
    add  HL, HL         ; 1:11      32x 384->768
    add  HL, DE         ; 1:11
    ld   DE, 0x5800   ; 3:10
    add  HL, DE         ; 1:11
    ld   L, (HL)        ; 1:7
    ld   H, 0x00        ; 2:7
    ret                 ; 1:10
;   ---  the beginning of a non-recursive function  ---
draw_white:             ;           ( x y -- )
    pop  BC             ; 1:10      : ret
    ld  (draw_white_end+1),BC; 4:20      : ( ret -- )

    ld    C, 0x3F      ; 2:7
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10
draw_white_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
draw_black:             ;           ( x y -- )
    pop  BC             ; 1:10      : ret
    ld  (draw_black_end+1),BC; 4:20      : ( ret -- )

    ld    C, 0      ; 2:7
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10
draw_black_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
draw:                   ;           ( color x y -- )
    pop  BC             ; 1:10      : ret
    ld  (draw_end+1),BC ; 4:20      : ( ret -- )

    pop   BC            ; 1:10
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10
draw_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a data stack function  ---
draw_walls:             ;           
    push DE             ; 1:11      32-1
    ex   DE, HL         ; 1:4       32-1
    ld   HL, 32-1       ; 3:10      32-1
for101:                 ;           for_101(s) ( index -- index )
    push DE             ; 1:11      i_101 0
    push HL             ; 1:11      i_101 0
    ex   DE, HL         ; 1:4       i_101 0
    ld   HL, 0          ; 3:10      i_101 0
    call draw_black     ; 3:17      call ( -- )
    push DE             ; 1:11      i_101 24-1
    push HL             ; 1:11      i_101 24-1
    ex   DE, HL         ; 1:4       i_101 24-1
    ld   HL, 24-1       ; 3:10      i_101 24-1
    call draw_black     ; 3:17      call ( -- )
    ld    A, H          ; 1:4       next_101(s)
    or    L             ; 1:4       next_101(s)
    dec  HL             ; 1:6       next_101(s)   index--
    jp  nz, for101      ; 3:10      next_101(s)
leave101:               ;           next_101(s)
    ex   DE, HL         ; 1:4       unloop_101(s)   ( i -- )
    pop  DE             ; 1:10      unloop_101(s)
    push DE             ; 1:11      24-1
    ex   DE, HL         ; 1:4       24-1
    ld   HL, 24-1       ; 3:10      24-1
for102:                 ;           for_102(s) ( index -- index )
    push DE             ; 1:11      0 over   ( a -- a 0 a )
    push HL             ; 1:11      0 over
    ld   DE, 0          ; 3:10      0 over
    call draw_black     ; 3:17      call ( -- )
    push DE             ; 1:11      32-1 over   ( a -- a 32-1 a )
    push HL             ; 1:11      32-1 over
    ld   DE, 32-1       ; 3:10      32-1 over
    call draw_black     ; 3:17      call ( -- )
    ld    A, H          ; 1:4       next_102(s)
    or    L             ; 1:4       next_102(s)
    dec  HL             ; 1:6       next_102(s)   index--
    jp  nz, for102      ; 3:10      next_102(s)
leave102:               ;           next_102(s)
    ex   DE, HL         ; 1:4       unloop_102(s)   ( i -- )
    pop  DE             ; 1:10      unloop_102(s)
draw_walls_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a non-recursive function  ---
snake_x:                ;           ( offset -- address )
    pop  BC             ; 1:10      : ret
    ld  (snake_x_end+1),BC; 4:20      : ( ret -- )
    add  HL, HL         ; 1:11      2*
    ; warning M4 does not know the numerical value of >>>snake_x_head<<<
    ld   BC, snake_x_head; 3:10      snake_x_head +
    add  HL, BC         ; 1:11      snake_x_head +
snake_x_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
snake_y:                ;           ( offset -- address )
    pop  BC             ; 1:10      : ret
    ld  (snake_y_end+1),BC; 4:20      : ( ret -- )
    add  HL, HL         ; 1:11      2*
    ; warning M4 does not know the numerical value of >>>snake_x_head+2*500<<<
    ld   BC, snake_x_head+2*500; 3:10      snake_x_head+2*500 +
    add  HL, BC         ; 1:11      snake_x_head+2*500 +
snake_y_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a data stack function  ---
initialize_snake:       ;           
                        ;[7:30]     4 length !  push2_store(4,length)   ( -- )  val=4, addr=length
    ld   BC, 4          ; 3:10      4 length !  push2_store(4,length)
    ld   (length), BC   ; 4:20      4 length !  push2_store(4,length)
    ld   BC, 0          ; 3:10      do_103(xm)
do103save:              ;           do_103(xm)
    ld  (idx103),BC     ; 4:20      do_103(xm)
do103:                  ;           do_103(xm)
    push DE             ; 1:11      12 i_103   ( -- 12 i )
    push HL             ; 1:11      12 i_103
    ld   DE, 12         ; 3:10      12 i_103
    ld   HL, (idx103)   ; 3:16      12 i_103   idx always points to a 16-bit index
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -
    push DE             ; 1:11      i_103(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_103(m)
    ld   HL, (idx103)   ; 3:16      i_103(m)   idx always points to a 16-bit index
    call snake_x        ; 3:17      call ( -- )
                        ;[5:40]     !   ( x addr -- )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !
    pop  DE             ; 1:10      !
    push DE             ; 1:11      12 i_103   ( -- 12 i )
    push HL             ; 1:11      12 i_103
    ld   DE, 12         ; 3:10      12 i_103
    ld   HL, (idx103)   ; 3:16      12 i_103   idx always points to a 16-bit index
    call snake_y        ; 3:17      call ( -- )
                        ;[5:40]     !   ( x addr -- )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !
    pop  DE             ; 1:10      !
                        ;[12:45]    loop_103   variant +1.B: 0 <= index < stop <= 256, run 5x
idx103 EQU $+1          ;           loop_103   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_103   0.. +1 ..(4+1), real_stop:0x0005
    nop                 ; 1:4       loop_103   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_103   index++
    ld  (idx103),A      ; 3:13      loop_103
    xor  0x05           ; 2:7       loop_103   lo(real_stop)
    jp   nz, do103      ; 3:10      loop_103   index-stop
leave103:               ;           loop_103
exit103:                ;           loop_103
                        ;[7:30]     2 direction !  push2_store(2,direction)   ( -- )  val=2, addr=direction
    ld   BC, 2          ; 3:10      2 direction !  push2_store(2,direction)
    ld   (direction), BC; 4:20      2 direction !  push2_store(2,direction)
initialize_snake_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a non-recursive function  ---
set_apple_position:     ;           ( y x -- )
    pop  BC             ; 1:10      : ret
    ld  (set_apple_position_end+1),BC; 4:20      : ( ret -- )
                        ;[5:30]     apple_x !  push_store(apple_x)   ( x -- )  addr=apple_x
    ld   (apple_x), HL  ; 3:16      apple_x !  push_store(apple_x)
    ex   DE, HL         ; 1:4       apple_x !  push_store(apple_x)
    pop  DE             ; 1:10      apple_x !  push_store(apple_x)
                        ;[5:30]     apple_y !  push_store(apple_y)   ( x -- )  addr=apple_y
    ld   (apple_y), HL  ; 3:16      apple_y !  push_store(apple_y)
    ex   DE, HL         ; 1:4       apple_y !  push_store(apple_y)
    pop  DE             ; 1:10      apple_y !  push_store(apple_y)
set_apple_position_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a data stack function  ---
initialize_apple:       ;           
                        ;[7:40]     4 4   ( -- 4 4 )
    push DE             ; 1:11      4 4
    push HL             ; 1:11      4 4
    ld   DE, 0x0004     ; 3:10      4 4
    ld    L, E          ; 1:4       4 4   L = E = 0x04
    ld    H, D          ; 1:4       4 4   H = D = 0x00
    call set_apple_position; 3:17      call ( -- )
initialize_apple_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
initialize:             ;           
    ld   BC, 32-1    ; 3:10      32-1 for_104   ( -- )
for104:                 ;           32-1 for_104
    ld  (idx104),BC     ; 4:20      32-1 for_104   save index
    ld   BC, 24-1   ; 3:10      24-1 for_105   ( -- )
for105:                 ;           24-1 for_105
    ld  (idx105),BC     ; 4:20      24-1 for_105   save index
    push DE             ; 1:11      j_104(m)   ( -- j )
    ex   DE, HL         ; 1:4       j_104(m)
    ld   HL, (idx104)   ; 3:16      j_104(m)   idx always points to a 16-bit index
    push DE             ; 1:11      i_105(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_105(m)
    ld   HL, (idx105)   ; 3:16      i_105(m)   idx always points to a 16-bit index
    call draw_white     ; 3:17      call ( -- )
idx105 EQU $+1          ;           next_105
    ld   BC, 0x0000     ; 3:10      next_105   idx always points to a 16-bit index
    ld    A, B          ; 1:4       next_105
    or    C             ; 1:4       next_105
    dec  BC             ; 1:6       next_105   index--, zero flag unaffected
    jp   nz, for105     ; 3:10      next_105
leave105:               ;           next_105
idx104 EQU $+1          ;           next_104
    ld   BC, 0x0000     ; 3:10      next_104   idx always points to a 16-bit index
    ld    A, B          ; 1:4       next_104
    or    C             ; 1:4       next_104
    dec  BC             ; 1:6       next_104   index--, zero flag unaffected
    jp   nz, for104     ; 3:10      next_104
leave104:               ;           next_104
    call draw_walls     ; 3:17      scall
    call initialize_snake; 3:17      scall
    call initialize_apple; 3:17      scall
initialize_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
move_up:                ;           
    ld   BC, (snake_x_head+2*500); 4:20      push2_addstore(-1,snake_x_head+2*500)
    dec  BC             ; 1:6       push2_addstore(-1,snake_x_head+2*500)
    ld   (snake_x_head+2*500), BC; 4:20      push2_addstore(-1,snake_x_head+2*500)
move_up_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
move_left:              ;           
    ld   BC, (snake_x_head); 4:20      push2_addstore(-1,snake_x_head)
    dec  BC             ; 1:6       push2_addstore(-1,snake_x_head)
    ld   (snake_x_head), BC; 4:20      push2_addstore(-1,snake_x_head)
move_left_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
move_down:              ;           
    ld   BC, (snake_x_head+2*500); 4:20      push2_addstore(1,snake_x_head+2*500)
    inc  BC             ; 1:6       push2_addstore(1,snake_x_head+2*500)
    ld   (snake_x_head+2*500), BC; 4:20      push2_addstore(1,snake_x_head+2*500)
move_down_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
move_right:             ;           
    ld   BC, (snake_x_head); 4:20      push2_addstore(1,snake_x_head)
    inc  BC             ; 1:6       push2_addstore(1,snake_x_head)
    ld   (snake_x_head), BC; 4:20      push2_addstore(1,snake_x_head)
move_right_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
move_snake_head:        ;           
    push DE             ; 1:11      direction @ push(direction) fetch
    ex   DE, HL         ; 1:4       direction @ push(direction) fetch
    ld   HL,(direction) ; 3:16      direction @ push(direction) fetch
                      ;[5:18/18,18]  dup 0 = if   ( x1 -- x1 )   0 == HL
    ld    A, H          ; 1:4       dup 0 = if   x[1] = 0
    or    L             ; 1:4       dup 0 = if   x[2] = 0
    jp   nz, else101    ; 3:10      dup 0 = if
    call move_left      ; 3:17      scall
    jp   endif101       ; 3:10      else
else101:
                      ;[6:22/22,22]  dup 1 = if   ( x1 -- x1 )   1 == HL
    ld    A, L          ; 1:4       dup 1 = if
    dec   A             ; 1:4       dup 1 = if   x[1] = 1
    or    H             ; 1:4       dup 1 = if   x[2] = 0
    jp   nz, else102    ; 3:10      dup 1 = if
    call move_up        ; 3:17      scall
    jp   endif102       ; 3:10      else
else102:
                      ;[7:25/25,25]  dup 2 = if   ( x1 -- x1 )   2 == HL
    ld    A, 0x02       ; 2:7       dup 2 = if
    xor   L             ; 1:4       dup 2 = if   x[1] = 0x02
    or    H             ; 1:4       dup 2 = if   x[2] = 0
    jp   nz, else103    ; 3:10      dup 2 = if
    call move_right     ; 3:17      scall
    jp   endif103       ; 3:10      else
else103:
                      ;[7:25/25,25]  dup 3 = if   ( x1 -- x1 )   3 == HL
    ld    A, 0x03       ; 2:7       dup 3 = if
    xor   L             ; 1:4       dup 3 = if   x[1] = 0x03
    or    H             ; 1:4       dup 3 = if   x[2] = 0
    jp   nz, else104    ; 3:10      dup 3 = if
    call move_down      ; 3:17      scall
else104  EQU $          ;           = endif
endif104:
endif103:
endif102:
endif101:
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
move_snake_head_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
move_snake_tail:        ;           
    push DE             ; 1:11      length @ push(length) fetch
    ex   DE, HL         ; 1:4       length @ push(length) fetch
    ld   HL,(length)    ; 3:16      length @ push(length) fetch
for106:                 ;           for_106(s) ( index -- index )
    push DE             ; 1:11      i_106 dup   ( a -- a a a )
    push HL             ; 1:11      i_106 dup
    ld    D, H          ; 1:4       i_106 dup
    ld    E, L          ; 1:4       i_106 dup
    call snake_x        ; 3:17      call ( -- )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    inc  HL             ; 1:6       1+
    call snake_x        ; 3:17      call ( -- )
                        ;[5:40]     !   ( x addr -- )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !
    pop  DE             ; 1:10      !
    push DE             ; 1:11      i_106 dup   ( a -- a a a )
    push HL             ; 1:11      i_106 dup
    ld    D, H          ; 1:4       i_106 dup
    ld    E, L          ; 1:4       i_106 dup
    call snake_y        ; 3:17      call ( -- )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    inc  HL             ; 1:6       1+
    call snake_y        ; 3:17      call ( -- )
                        ;[5:40]     !   ( x addr -- )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !
    pop  DE             ; 1:10      !
    ld    A, H          ; 1:4       next_106(s)
    or    L             ; 1:4       next_106(s)
    dec  HL             ; 1:6       next_106(s)   index--
    jp  nz, for106      ; 3:10      next_106(s)
leave106:               ;           next_106(s)
    ex   DE, HL         ; 1:4       unloop_106(s)   ( i -- )
    pop  DE             ; 1:10      unloop_106(s)
move_snake_tail_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a non-recursive function  ---
is_horizontal:          ;           ( -- flag )
    pop  BC             ; 1:10      : ret
    ld  (is_horizontal_end+1),BC; 4:20      : ( ret -- )
    push DE             ; 1:11      direction @ push(direction) fetch
    ex   DE, HL         ; 1:4       direction @ push(direction) fetch
    ld   HL,(direction) ; 3:16      direction @ push(direction) fetch
                      ;[8:45/45,45]  dup 0 =   ( x -- x f )   0x0000 == HL
    ld    A, H          ; 1:4       dup 0 =   x[1] = 0
    or    L             ; 1:4       dup 0 =   x[2] = 0
    sub 0x01            ; 2:7       dup 0 =
    ex   DE, HL         ; 1:4       dup 0 =
    push HL             ; 1:11      dup 0 =
    sbc  HL, HL         ; 2:15      dup 0 =   set flag x==0
    ex   DE, HL         ; 1:4        swap   ( b a -- a b )
                        ;[8:37]     2 =
    ld    A, 0x02       ; 2:7       2 =   lo(2)
    xor   L             ; 1:4       2 =
    or    H             ; 1:4       2 =
    sub  0x01           ; 2:7       2 =
    sbc  HL, HL         ; 2:15      2 =
    ld    A, E          ; 1:4       or   ( x2 x1 -- x )  x = x2 | x1
    or    L             ; 1:4       or
    ld    L, A          ; 1:4       or
    ld    A, D          ; 1:4       or
    or    H             ; 1:4       or
    ld    H, A          ; 1:4       or
    pop  DE             ; 1:10      or
is_horizontal_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
is_vertical:            ;           ( -- flag )
    pop  BC             ; 1:10      : ret
    ld  (is_vertical_end+1),BC; 4:20      : ( ret -- )
    push DE             ; 1:11      direction @ push(direction) fetch
    ex   DE, HL         ; 1:4       direction @ push(direction) fetch
    ld   HL,(direction) ; 3:16      direction @ push(direction) fetch
                      ;[9:49/49,49]  dup 1 =   ( x -- x f )   0x0001 == HL
    ld    A, L          ; 1:4       dup 1 =
    dec   A             ; 1:4       dup 1 =   x[1] = 1
    or    H             ; 1:4       dup 1 =   x[2] = 0
    sub 0x01            ; 2:7       dup 1 =
    ex   DE, HL         ; 1:4       dup 1 =
    push HL             ; 1:11      dup 1 =
    sbc  HL, HL         ; 2:15      dup 1 =   set flag x==1
    ex   DE, HL         ; 1:4        swap   ( b a -- a b )
                        ;[8:37]     3 =
    ld    A, 0x03       ; 2:7       3 =   lo(3)
    xor   L             ; 1:4       3 =
    or    H             ; 1:4       3 =
    sub  0x01           ; 2:7       3 =
    sbc  HL, HL         ; 2:15      3 =
    ld    A, E          ; 1:4       or   ( x2 x1 -- x )  x = x2 | x1
    or    L             ; 1:4       or
    ld    L, A          ; 1:4       or
    ld    A, D          ; 1:4       or
    or    H             ; 1:4       or
    ld    H, A          ; 1:4       or
    pop  DE             ; 1:10      or
is_vertical_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a data stack function  ---
turn_up:                ;           
    call is_horizontal  ; 3:17      call ( -- )
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else105    ; 3:10      if
                        ;[7:30]     1 direction !  push2_store(1,direction)   ( -- )  val=1, addr=direction
    ld   BC, 1          ; 3:10      1 direction !  push2_store(1,direction)
    ld   (direction), BC; 4:20      1 direction !  push2_store(1,direction)
else105  EQU $          ;           = endif
endif105:
turn_up_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
turn_left:              ;           
    call is_vertical    ; 3:17      call ( -- )
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else106    ; 3:10      if
                        ;[7:30]     0 direction !  push2_store(0,direction)   ( -- )  val=0, addr=direction
    ld   BC, 0          ; 3:10      0 direction !  push2_store(0,direction)
    ld   (direction), BC; 4:20      0 direction !  push2_store(0,direction)
else106  EQU $          ;           = endif
endif106:
turn_left_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
turn_down:              ;           
    call is_horizontal  ; 3:17      call ( -- )
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else107    ; 3:10      if
                        ;[7:30]     3 direction !  push2_store(3,direction)   ( -- )  val=3, addr=direction
    ld   BC, 3          ; 3:10      3 direction !  push2_store(3,direction)
    ld   (direction), BC; 4:20      3 direction !  push2_store(3,direction)
else107  EQU $          ;           = endif
endif107:
turn_down_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
turn_right:             ;           
    call is_vertical    ; 3:17      call ( -- )
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else108    ; 3:10      if
                        ;[7:30]     2 direction !  push2_store(2,direction)   ( -- )  val=2, addr=direction
    ld   BC, 2          ; 3:10      2 direction !  push2_store(2,direction)
    ld   (direction), BC; 4:20      2 direction !  push2_store(2,direction)
else108  EQU $          ;           = endif
endif108:
turn_right_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a non-recursive function  ---
change_direction:       ;           ( key -- )
    pop  BC             ; 1:10      : ret
    ld  (change_direction_end+1),BC; 4:20      : ( ret -- )

  .warning __EQ_MAKE_BEST_CODE('o',3,10,else109,0): M4 does not know the "'o'" value and therefore cannot optimize the code.
                     ;[12:42/21,42]  dup 'o' = if   ( x1 -- x1 )   'o' == HL
    ld    A, low 'o'    ; 2:7       dup 'o' = if
    xor   L             ; 1:4       dup 'o' = if
    jp   nz, else109    ; 3:10      dup 'o' = if
    ld    A, high 'o'   ; 2:7       dup 'o' = if
    xor   H             ; 1:4       dup 'o' = if
    jp   nz, else109    ; 3:10      dup 'o' = if
    call turn_left      ; 3:17      scall
    jp   endif109       ; 3:10      else
else109:

  .warning __EQ_MAKE_BEST_CODE('q',3,10,else110,0): M4 does not know the "'q'" value and therefore cannot optimize the code.
                     ;[12:42/21,42]  dup 'q' = if   ( x1 -- x1 )   'q' == HL
    ld    A, low 'q'    ; 2:7       dup 'q' = if
    xor   L             ; 1:4       dup 'q' = if
    jp   nz, else110    ; 3:10      dup 'q' = if
    ld    A, high 'q'   ; 2:7       dup 'q' = if
    xor   H             ; 1:4       dup 'q' = if
    jp   nz, else110    ; 3:10      dup 'q' = if
    call turn_up        ; 3:17      scall
    jp   endif110       ; 3:10      else
else110:

  .warning __EQ_MAKE_BEST_CODE('p',3,10,else111,0): M4 does not know the "'p'" value and therefore cannot optimize the code.
                     ;[12:42/21,42]  dup 'p' = if   ( x1 -- x1 )   'p' == HL
    ld    A, low 'p'    ; 2:7       dup 'p' = if
    xor   L             ; 1:4       dup 'p' = if
    jp   nz, else111    ; 3:10      dup 'p' = if
    ld    A, high 'p'   ; 2:7       dup 'p' = if
    xor   H             ; 1:4       dup 'p' = if
    jp   nz, else111    ; 3:10      dup 'p' = if
    call turn_right     ; 3:17      scall
    jp   endif111       ; 3:10      else
else111:

  .warning __EQ_MAKE_BEST_CODE('a',3,10,else112,0): M4 does not know the "'a'" value and therefore cannot optimize the code.
                     ;[12:42/21,42]  dup 'a' = if   ( x1 -- x1 )   'a' == HL
    ld    A, low 'a'    ; 2:7       dup 'a' = if
    xor   L             ; 1:4       dup 'a' = if
    jp   nz, else112    ; 3:10      dup 'a' = if
    ld    A, high 'a'   ; 2:7       dup 'a' = if
    xor   H             ; 1:4       dup 'a' = if
    jp   nz, else112    ; 3:10      dup 'a' = if
    call turn_down      ; 3:17      scall
else112  EQU $          ;           = endif
endif112:
endif111:
endif110:
endif109:
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
change_direction_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a data stack function  ---
check_input:            ;           
    push DE             ; 1:11      0x5C08 @  push_cfetch(0x5C08)
    ex   DE, HL         ; 1:4       0x5C08 @  push_cfetch(0x5C08)
    ld   HL,(0x5C08)    ; 3:16      0x5C08 @  push_cfetch(0x5C08)
    ld    H, 0x00       ; 2:7       0x5C08 @  push_cfetch(0x5C08)
    call change_direction; 3:17      call ( -- )
    xor   A             ; 1:4       0 0x5C08 c!   lo(0) = 0x00
    ld   (0x5C08), A    ; 3:13      0 0x5C08 c!
check_input_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
random_position:        ;           ( n -- 2..n-3 )
    ld   BC, 0xFFFC     ; 3:10      4 -   ( x -- x-0x0004 )
    add  HL, BC         ; 1:11      4 -
    call Random         ; 3:17      random
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+
random_position_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
move_apple:             ;           
    push DE             ; 1:11      24
    ex   DE, HL         ; 1:4       24
    ld   HL, 24         ; 3:10      24
    call random_position; 3:17      scall
    push DE             ; 1:11      32
    ex   DE, HL         ; 1:4       32
    ld   HL, 32         ; 3:10      32
    call random_position; 3:17      scall
    call set_apple_position; 3:17      call ( -- )
move_apple_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
grow_snake:             ;           
    ld   BC, (length)   ; 4:20      push2_addstore(1,length)
    inc  BC             ; 1:6       push2_addstore(1,length)
    ld   (length), BC   ; 4:20      push2_addstore(1,length)
grow_snake_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
check_apple:            ;           
    push DE             ; 1:11      snake_x_head @ push(snake_x_head) fetch
    ex   DE, HL         ; 1:4       snake_x_head @ push(snake_x_head) fetch
    ld   HL,(snake_x_head); 3:16      snake_x_head @ push(snake_x_head) fetch
    push DE             ; 1:11      apple_x @ push(apple_x) fetch
    ex   DE, HL         ; 1:4       apple_x @ push(apple_x) fetch
    ld   HL,(apple_x)   ; 3:16      apple_x @ push(apple_x) fetch
                        ;[9:48/49]  =
    xor   A             ; 1:4       =   A = 0x00
    sbc  HL, DE         ; 2:15      =
    jr   nz, $+3        ; 2:7/12    =
    dec   A             ; 1:4       =   A = 0xFF
    ld    L, A          ; 1:4       =
    ld    H, A          ; 1:4       =   HL= flag
    pop  DE             ; 1:10      =
    push DE             ; 1:11      snake_x_head+2*500 @ push(snake_x_head+2*500) fetch
    ex   DE, HL         ; 1:4       snake_x_head+2*500 @ push(snake_x_head+2*500) fetch
    ld   HL,(snake_x_head+2*500); 3:16      snake_x_head+2*500 @ push(snake_x_head+2*500) fetch
    push DE             ; 1:11      apple_y @ push(apple_y) fetch
    ex   DE, HL         ; 1:4       apple_y @ push(apple_y) fetch
    ld   HL,(apple_y)   ; 3:16      apple_y @ push(apple_y) fetch
                        ;[9:48/49]  =
    xor   A             ; 1:4       =   A = 0x00
    sbc  HL, DE         ; 2:15      =
    jr   nz, $+3        ; 2:7/12    =
    dec   A             ; 1:4       =   A = 0xFF
    ld    L, A          ; 1:4       =
    ld    H, A          ; 1:4       =   HL= flag
    pop  DE             ; 1:10      =
    ld    A, E          ; 1:4       and   ( x2 x1 -- x )  x = x2 & x1
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else113    ; 3:10      if
    call move_apple     ; 3:17      scall
    call grow_snake     ; 3:17      scall
else113  EQU $          ;           = endif
endif113:
check_apple_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a non-recursive function  ---
check_collision:        ;           
    pop  BC             ; 1:10      : ret
    ld  (check_collision_end+1),BC; 4:20      : ( ret -- )
    push DE             ; 1:11      snake_x_head @ push(snake_x_head) fetch
    ex   DE, HL         ; 1:4       snake_x_head @ push(snake_x_head) fetch
    ld   HL,(snake_x_head); 3:16      snake_x_head @ push(snake_x_head) fetch
    push DE             ; 1:11      snake_x_head+2*500 @ push(snake_x_head+2*500) fetch
    ex   DE, HL         ; 1:4       snake_x_head+2*500 @ push(snake_x_head+2*500) fetch
    ld   HL,(snake_x_head+2*500); 3:16      snake_x_head+2*500 @ push(snake_x_head+2*500) fetch

    ; get color at current position
    call get_color      ; 3:17
    pop  DE             ; 1:10
                        ;[5:29]     0=
    ld    A, H          ; 1:4       0=
    dec  HL             ; 1:6       0=
    sub   H             ; 1:4       0=
    sbc  HL, HL         ; 2:15      0=
check_collision_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a data stack function  ---
draw_snake:             ;           
    push DE             ; 1:11      length @ push(length) fetch
    ex   DE, HL         ; 1:4       length @ push(length) fetch
    ld   HL,(length)    ; 3:16      length @ push(length) fetch
    ld    A, L          ; 1:4       0 do_107(m)   ( stop 0 -- )
    ld  (stp_lo107), A  ; 3:13      0 do_107(m)   lo stop
    ld    A, H          ; 1:4       0 do_107(m)
    ld  (stp_hi107), A  ; 3:13      0 do_107(m)   hi stop
    ld   HL, 0          ; 3:10      0 do_107(m)
    ld  (idx107), HL    ; 3:16      0 do_107(m)   index
    ex   DE, HL         ; 1:4       0 do_107(m)
    pop  DE             ; 1:10      0 do_107(m)
do107:                  ;           0 do_107(m)
    push DE             ; 1:11      i_107(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_107(m)
    ld   HL, (idx107)   ; 3:16      i_107(m)   idx always points to a 16-bit index
    call snake_x        ; 3:17      call ( -- )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    push DE             ; 1:11      i_107(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_107(m)
    ld   HL, (idx107)   ; 3:16      i_107(m)   idx always points to a 16-bit index
    call snake_y        ; 3:17      call ( -- )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    call draw_black     ; 3:17      call ( -- )
idx107 EQU $+1          ;[20:78/57] loop_107(m)
    ld   BC, 0x0000     ; 3:10      loop_107(m)   idx always points to a 16-bit index
    inc  BC             ; 1:6       loop_107(m)   index++
    ld  (idx107), BC    ; 4:20      loop_107(m)   save index
    ld    A, C          ; 1:4       loop_107(m)   lo new index
stp_lo107 EQU $+1       ;           loop_107(m)
    xor  0x00           ; 2:7       loop_107(m)   lo stop
    jp   nz, do107      ; 3:10      loop_107(m)
    ld    A, B          ; 1:4       loop_107(m)   hi new index
stp_hi107 EQU $+1       ;           loop_107(m)
    xor  0x00           ; 2:7       loop_107(m)   hi stop
    jp   nz, do107      ; 3:10      loop_107(m)
leave107:               ;           loop_107(m)
exit107:                ;           loop_107(m)
    push DE             ; 1:11      length @ push(length) fetch
    ex   DE, HL         ; 1:4       length @ push(length) fetch
    ld   HL,(length)    ; 3:16      length @ push(length) fetch
    call snake_x        ; 3:17      call ( -- )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    push DE             ; 1:11      length @ push(length) fetch
    ex   DE, HL         ; 1:4       length @ push(length) fetch
    ld   HL,(length)    ; 3:16      length @ push(length) fetch
    call snake_y        ; 3:17      call ( -- )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    call draw_white     ; 3:17      call ( -- )
draw_snake_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
draw_apple:             ;           
    push DE             ; 1:11      0x24 apple_x @
    push HL             ; 1:11      0x24 apple_x @
    ld   DE,0x24        ; 3:10      0x24 apple_x @
    ld   HL,(apple_x)   ; 3:16      0x24 apple_x @
    push DE             ; 1:11      apple_y @ push(apple_y) fetch
    ex   DE, HL         ; 1:4       apple_y @ push(apple_y) fetch
    ld   HL,(apple_y)   ; 3:16      apple_y @ push(apple_y) fetch
    call draw           ; 3:17      call ( -- )
draw_apple_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a non-recursive function  ---
sleep:                  ;           ( x -- )
    pop  BC             ; 1:10      : ret
    ld  (sleep_end+1),BC; 4:20      : ( ret -- )
for108:                 ;           for_108(s) ( index -- index )

        halt
    ld    A, H          ; 1:4       next_108(s)
    or    L             ; 1:4       next_108(s)
    dec  HL             ; 1:6       next_108(s)   index--
    jp  nz, for108      ; 3:10      next_108(s)
leave108:               ;           next_108(s)
    ex   DE, HL         ; 1:4       unloop_108(s)   ( i -- )
    pop  DE             ; 1:10      unloop_108(s)
sleep_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a data stack function  ---
game_loop:              ;           
begin101:               ;           begin 101
    call draw_snake     ; 3:17      scall
    call draw_apple     ; 3:17      scall
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
    call sleep          ; 3:17      call ( -- )
    call check_input    ; 3:17      scall
    call move_snake_tail; 3:17      scall
    call move_snake_head; 3:17      scall
    call check_apple    ; 3:17      scall
    call check_collision; 3:17      call ( -- )
    ld    A, H          ; 1:4       until 101   ( flag -- )
    or    L             ; 1:4       until 101
    ex   DE, HL         ; 1:4       until 101
    pop  DE             ; 1:10      until 101
    jp    z, begin101   ; 3:10      until 101
break101:               ;           until 101
    push DE             ; 1:11      print     "Game Over", 0xD
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
game_loop_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
start:                  ;           
    call initialize     ; 3:17      scall
    call game_loop      ; 3:17      scall
start_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;==============================================================================
; ( max -- rand )
; 16-bit pseudorandom generator
; HL = random < max, or HL = 0
Random:                 ;[41:]      Random
    ld    A, H          ; 1:4       Random
    or    A             ; 1:4       Random
    jr    z, Random_0L  ; 2:7/11    Random
    ld    C, 0xFF       ; 2:7       Random
    xor   A             ; 1:4       Random
    adc   A, A          ; 1:4       Random
    cp    H             ; 1:4       Random
    jr    c, $-2        ; 2:7/11    Random
    ld    B, A          ; 1:4       Random   BC = mask = 0x??FF
    jr   Random_Begin   ; 2:12      Random
Random_0L:              ;           Random
    ld    B, A          ; 1:4       Random
    or    L             ; 1:4       Random
    ret   z             ; 1:5/11    Random
    xor   A             ; 1:4       Random
    adc   A, A          ; 1:4       Random
    cp    L             ; 1:4       Random
    jr    c, $-2        ; 2:7/11    Random
    ld    C, A          ; 1:4       Random   BC = mask = 0x00??
;------------------------------------------------------------------------------
; In: BC = mask, HL = max
; Out: HL = 0..max-1
Random_Begin:           ;           Random
    push  DE            ; 1:11      Random
    ex    DE, HL        ; 1:4       Random   DE = max
Random_Next:            ;           Random
    call Rnd            ; 3:17      Random
    ld    A, C          ; 1:4       Random
    and   L             ; 1:4       Random
    ld    L, A          ; 1:4       Random
    ld    A, B          ; 1:4       Random
    and   H             ; 1:4       Random
    ld    H, A          ; 1:4       Random
    sbc  HL, DE         ; 2:15      Random
    jr   nc, Random_Next; 2:7/11    Random
    add  HL, DE         ; 1:11      Random
    pop  DE             ; 1:10      Random
    ret                 ; 1:10      Random
;==============================================================================
; ( -- rand )
; 16-bit pseudorandom generator
; Out: HL = 0..65535
; Pollutes: AF, AF', HL
Rnd:                    ;[44:182]   rnd
SEED_8BIT EQU $+1
    ld    L, 0x01       ; 2:7       rnd   seed must not be 0
    ld    A, L          ; 1:4       rnd
    rrca                ; 1:4       rnd
    rrca                ; 1:4       rnd
    rrca                ; 1:4       rnd
    xor  0x1F           ; 2:7       rnd   A = 32*L
    add   A, L          ; 2:7       rnd   A = 33*L
    sbc   A, 0xFF       ; 2:7       rnd   carry
    ld  (SEED_8BIT), A  ; 3:13      rnd   save new 8bit number
    ex   AF, AF'        ; 1:4       rnd
SEED EQU $+1
    ld   HL, 0x0001     ; 3:10      rnd   seed must not be 0
    ld    A, H          ; 1:4       rnd
    rra                 ; 1:4       rnd   hi.0 bit to carry
    ld    A, L          ; 1:4       rnd
    rra                 ; 1:4       rnd
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd   hi(xs) ^= hi(xs << 7);
    ld    A, L          ; 1:4       rnd
    rra                 ; 1:4       rnd   lo.0 bit to carry
    ld    A, H          ; 1:4       rnd
    rra                 ; 1:4       rnd
    xor   L             ; 1:4       rnd
    ld    L, A          ; 1:4       rnd   lo(xs) ^= lo(xs << 7) + (xs >> 9);
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd   xs ^= xs << 8;
    ld  (SEED), HL      ; 3:16      rnd   save new 16bit number
    ex   AF, AF'        ; 1:4       rnd
    xor   L             ; 1:4       rnd
    ld    L, A          ; 1:4       rnd
    ld    A, R          ; 2:9       rnd
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd
    ret                 ; 1:10      rnd

STRING_SECTION:
string101:
    db "Game Over", 0xD
  size101   EQU  $ - string101


VARIABLE_SECTION:

apple_x:
    dw 0x0000
apple_y:
    dw 0x0000
direction:
    dw 0x0000
length:
    dw 0x0000
__create_snake_x_head:

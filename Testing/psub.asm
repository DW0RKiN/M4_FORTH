    ORG 0x8000




BYTES_SIZE           EQU 10





A_lo_var             EQU __create_A_lo_var

  
   
  

A_hi_var             EQU __create_A_hi_var

  
   



B_lo_var             EQU __create_B_lo_var

  
   
  

B_hi_var             EQU __create_B_hi_var

  
   



C_lo_var             EQU __create_C_lo_var

  
   
  

C_hi_var             EQU __create_C_hi_var

  
   



D_lo_var             EQU __create_D_lo_var

  
   
  

D_hi_var             EQU __create_D_hi_var

  
   



E_lo_var             EQU __create_E_lo_var

  
   
  

E_hi_var             EQU __create_E_hi_var

  
   



F_lo_var             EQU __create_F_lo_var

  
   
  

F_hi_var             EQU __create_F_hi_var

  
   
  


G_lo_var             EQU __create_G_lo_var

  
   
  

G_hi_var             EQU __create_G_hi_var

  
   



H_lo_var             EQU __create_H_lo_var

  
   
  

H_hi_var             EQU __create_H_hi_var

  
   



I_lo_var             EQU __create_I_lo_var

  
   
  

I_hi_var             EQU __create_I_hi_var

  
   



J_lo_var             EQU __create_J_lo_var

  
   
  

J_hi_var             EQU __create_J_hi_var

  
   
  


K_lo_var             EQU __create_K_lo_var

  
   
  

K_hi_var             EQU __create_K_hi_var

  
   



L_lo_var             EQU __create_L_lo_var

  
   
  

L_hi_var             EQU __create_L_hi_var

  
   
   


M_lo_var             EQU __create_M_lo_var

  
   
  

M_hi_var             EQU __create_M_hi_var

  
   



N_lo_var             EQU __create_N_lo_var

  
   
  

N_hi_var             EQU __create_N_hi_var

  
   
  


O_lo_var             EQU __create_O_lo_var

  
   
  

O_hi_var             EQU __create_O_hi_var

  
   



P_lo_var             EQU __create_P_lo_var

  
   
  

P_hi_var             EQU __create_P_hi_var

  
   



Q_lo_var             EQU __create_Q_lo_var

  
   
  

Q_hi_var             EQU __create_Q_hi_var

  
   



R_lo_var             EQU __create_R_lo_var

  
   



S_lo_var             EQU __create_S_lo_var

  
   



T_lo_var             EQU __create_T_lo_var

  
   



T_hi_var             EQU __create_T_hi_var

  
   



T_16_var             EQU __create_T_16_var

  
   



Z_8_var              EQU __create_Z_8_var

  
   



Z_16_var             EQU __create_Z_16_var

  
   



Def_var              EQU __create_Def_var

  
   

   





      
       
      


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
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
                        ;           no_segment(10)
                        ;           no_segment(10)
; dw x..-1..1 ; A
                        ;           no_segment(10)
    push HL             ; 1:11      0x3305 , 0x3304 , ... 0x3301 ,   version: A.lo <lo..-1..1>
    ld   HL, __create_A_lo_var; 3:10      0x3305 , 0x3304 , ... 0x3301 ,
    ld   BC, 0x0533     ; 3:10      0x3305 , 0x3304 , ... 0x3301 ,
    ld  (HL),B          ; 1:7       0x3305 , 0x3304 , ... 0x3301 ,
    inc  HL             ; 1:6       0x3305 , 0x3304 , ... 0x3301 ,
    ld  (HL),C          ; 1:7       0x3305 , 0x3304 , ... 0x3301 ,
    inc  HL             ; 1:6       0x3305 , 0x3304 , ... 0x3301 ,
    djnz $-4            ; 2:8/13    0x3305 , 0x3304 , ... 0x3301 ,
    pop  HL             ; 1:10      0x3305 , 0x3304 , ... 0x3301 ,
                        ;[14:231]   0x3305 , 0x3304 , ... 0x3301 ,
                        ;           no_segment(10)
                        ;[8:42]     A_lo_con A_lo_var   ( -- A_lo_con A_lo_var )
    push DE             ; 1:11      A_lo_con A_lo_var
    push HL             ; 1:11      A_lo_con A_lo_var
    ld   DE, A_lo_con   ; 3:10      A_lo_con A_lo_var
    ld   HL, A_lo_var   ; 3:10      A_lo_con A_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0533 , 0x0433 , ... 0x0133 ,   version: A.hi <hi..-1..1>
    ld   HL, __create_A_hi_var; 3:10      0x0533 , 0x0433 , ... 0x0133 ,
    ld   BC, 0x0533     ; 3:10      0x0533 , 0x0433 , ... 0x0133 ,
    ld  (HL),C          ; 1:7       0x0533 , 0x0433 , ... 0x0133 ,
    inc  HL             ; 1:6       0x0533 , 0x0433 , ... 0x0133 ,
    ld  (HL),B          ; 1:7       0x0533 , 0x0433 , ... 0x0133 ,
    inc  HL             ; 1:6       0x0533 , 0x0433 , ... 0x0133 ,
    djnz $-4            ; 2:8/13    0x0533 , 0x0433 , ... 0x0133 ,
    pop  HL             ; 1:10      0x0533 , 0x0433 , ... 0x0133 ,
                        ;[14:231]   0x0533 , 0x0433 , ... 0x0133 ,
                        ;           no_segment(10)
                        ;[8:42]     A_hi_con A_hi_var   ( -- A_hi_con A_hi_var )
    push DE             ; 1:11      A_hi_con A_hi_var
    push HL             ; 1:11      A_hi_con A_hi_var
    ld   DE, A_hi_con   ; 3:10      A_hi_con A_hi_var
    ld   HL, A_hi_var   ; 3:10      A_hi_con A_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 1..+1..x ; B
                        ;           no_segment(10)
    push HL             ; 1:11      0x3301 , 0x3302 , ... 0x3305 ,   version: B.lo <1..+1..lo>
    ld   HL, __create_B_lo_var+9; 3:10      0x3301 , 0x3302 , ... 0x3305 ,
    ld   BC, 0x0533     ; 3:10      0x3301 , 0x3302 , ... 0x3305 ,
    ld  (HL),C          ; 1:7       0x3301 , 0x3302 , ... 0x3305 ,
    dec  HL             ; 1:6       0x3301 , 0x3302 , ... 0x3305 ,
    ld  (HL),B          ; 1:7       0x3301 , 0x3302 , ... 0x3305 ,
    dec  HL             ; 1:6       0x3301 , 0x3302 , ... 0x3305 ,
    djnz $-4            ; 2:8/13    0x3301 , 0x3302 , ... 0x3305 ,
    pop  HL             ; 1:10      0x3301 , 0x3302 , ... 0x3305 ,
                        ;[14:231]   0x3301 , 0x3302 , ... 0x3305 ,
                        ;           no_segment(10)
                        ;[8:42]     B_lo_con B_lo_var   ( -- B_lo_con B_lo_var )
    push DE             ; 1:11      B_lo_con B_lo_var
    push HL             ; 1:11      B_lo_con B_lo_var
    ld   DE, B_lo_con   ; 3:10      B_lo_con B_lo_var
    ld   HL, B_lo_var   ; 3:10      B_lo_con B_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0133 , 0x0233 , ... 0x0533 ,   version: B.hi <1..+1..hi>
    ld   HL, __create_B_hi_var+9; 3:10      0x0133 , 0x0233 , ... 0x0533 ,
    ld   BC, 0x0533     ; 3:10      0x0133 , 0x0233 , ... 0x0533 ,
    ld  (HL),B          ; 1:7       0x0133 , 0x0233 , ... 0x0533 ,
    dec  HL             ; 1:6       0x0133 , 0x0233 , ... 0x0533 ,
    ld  (HL),C          ; 1:7       0x0133 , 0x0233 , ... 0x0533 ,
    dec  HL             ; 1:6       0x0133 , 0x0233 , ... 0x0533 ,
    djnz $-4            ; 2:8/13    0x0133 , 0x0233 , ... 0x0533 ,
    pop  HL             ; 1:10      0x0133 , 0x0233 , ... 0x0533 ,
                        ;[14:231]   0x0133 , 0x0233 , ... 0x0533 ,
                        ;           no_segment(10)
                        ;[8:42]     B_hi_con B_hi_var   ( -- B_hi_con B_hi_var )
    push DE             ; 1:11      B_hi_con B_hi_var
    push HL             ; 1:11      B_hi_con B_hi_var
    ld   DE, B_hi_con   ; 3:10      B_hi_con B_hi_var
    ld   HL, B_hi_var   ; 3:10      B_hi_con B_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x..-2..2 ; C
                        ;           no_segment(10)
    push HL             ; 1:11      0x330A , 0x3308 , ... 0x3302 ,   version: C.lo <lo..-2..2>
    ld   HL, __create_C_lo_var; 3:10      0x330A , 0x3308 , ... 0x3302 ,
    ld   BC, 0x0A33     ; 3:10      0x330A , 0x3308 , ... 0x3302 ,
    ld  (HL),B          ; 1:7       0x330A , 0x3308 , ... 0x3302 ,
    inc  HL             ; 1:6       0x330A , 0x3308 , ... 0x3302 ,
    ld  (HL),C          ; 1:7       0x330A , 0x3308 , ... 0x3302 ,
    inc  HL             ; 1:6       0x330A , 0x3308 , ... 0x3302 ,
    dec   B             ; 1:4       0x330A , 0x3308 , ... 0x3302 ,
    djnz $-5            ; 2:8/13    0x330A , 0x3308 , ... 0x3302 ,
    pop  HL             ; 1:10      0x330A , 0x3308 , ... 0x3302 ,
                        ;[15:251]   0x330A , 0x3308 , ... 0x3302 ,
                        ;           no_segment(10)
                        ;[8:42]     C_lo_con C_lo_var   ( -- C_lo_con C_lo_var )
    push DE             ; 1:11      C_lo_con C_lo_var
    push HL             ; 1:11      C_lo_con C_lo_var
    ld   DE, C_lo_con   ; 3:10      C_lo_con C_lo_var
    ld   HL, C_lo_var   ; 3:10      C_lo_con C_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0A33 , 0x0833 , ... 0x0233 ,   version: C.hi <hi..-2..2>
    ld   HL, __create_C_hi_var; 3:10      0x0A33 , 0x0833 , ... 0x0233 ,
    ld   BC, 0x0A33     ; 3:10      0x0A33 , 0x0833 , ... 0x0233 ,
    ld  (HL),C          ; 1:7       0x0A33 , 0x0833 , ... 0x0233 ,
    inc  HL             ; 1:6       0x0A33 , 0x0833 , ... 0x0233 ,
    ld  (HL),B          ; 1:7       0x0A33 , 0x0833 , ... 0x0233 ,
    inc  HL             ; 1:6       0x0A33 , 0x0833 , ... 0x0233 ,
    dec   B             ; 1:4       0x0A33 , 0x0833 , ... 0x0233 ,
    djnz $-5            ; 2:8/13    0x0A33 , 0x0833 , ... 0x0233 ,
    pop  HL             ; 1:10      0x0A33 , 0x0833 , ... 0x0233 ,
                        ;[15:251]   0x0A33 , 0x0833 , ... 0x0233 ,
                        ;           no_segment(10)
                        ;[8:42]     C_hi_con C_hi_var   ( -- C_hi_con C_hi_var )
    push DE             ; 1:11      C_hi_con C_hi_var
    push HL             ; 1:11      C_hi_con C_hi_var
    ld   DE, C_hi_con   ; 3:10      C_hi_con C_hi_var
    ld   HL, C_hi_var   ; 3:10      C_hi_con C_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 2..+2..x ; D
                        ;           no_segment(10)
    push HL             ; 1:11      0x3302 , 0x3304 , ... 0x330A ,   version: D.lo <2..+2..lo>
    ld   HL, __create_D_lo_var+9; 3:10      0x3302 , 0x3304 , ... 0x330A ,
    ld   BC, 0x0A33     ; 3:10      0x3302 , 0x3304 , ... 0x330A ,
    ld  (HL),C          ; 1:7       0x3302 , 0x3304 , ... 0x330A ,
    dec  HL             ; 1:6       0x3302 , 0x3304 , ... 0x330A ,
    ld  (HL),B          ; 1:7       0x3302 , 0x3304 , ... 0x330A ,
    dec  HL             ; 1:6       0x3302 , 0x3304 , ... 0x330A ,
    dec   B             ; 1:4       0x3302 , 0x3304 , ... 0x330A ,
    djnz $-5            ; 2:8/13    0x3302 , 0x3304 , ... 0x330A ,
    pop  HL             ; 1:10      0x3302 , 0x3304 , ... 0x330A ,
                        ;[15:251]   0x3302 , 0x3304 , ... 0x330A ,
                        ;           no_segment(10)
                        ;[8:42]     D_lo_con D_lo_var   ( -- D_lo_con D_lo_var )
    push DE             ; 1:11      D_lo_con D_lo_var
    push HL             ; 1:11      D_lo_con D_lo_var
    ld   DE, D_lo_con   ; 3:10      D_lo_con D_lo_var
    ld   HL, D_lo_var   ; 3:10      D_lo_con D_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0233 , 0x0433 , ... 0x0A33 ,   version: D.hi <2..+2..hi>
    ld   HL, __create_D_hi_var+9; 3:10      0x0233 , 0x0433 , ... 0x0A33 ,
    ld   BC, 0x0A33     ; 3:10      0x0233 , 0x0433 , ... 0x0A33 ,
    ld  (HL),B          ; 1:7       0x0233 , 0x0433 , ... 0x0A33 ,
    dec  HL             ; 1:6       0x0233 , 0x0433 , ... 0x0A33 ,
    ld  (HL),C          ; 1:7       0x0233 , 0x0433 , ... 0x0A33 ,
    dec  HL             ; 1:6       0x0233 , 0x0433 , ... 0x0A33 ,
    dec   B             ; 1:4       0x0233 , 0x0433 , ... 0x0A33 ,
    djnz $-5            ; 2:8/13    0x0233 , 0x0433 , ... 0x0A33 ,
    pop  HL             ; 1:10      0x0233 , 0x0433 , ... 0x0A33 ,
                        ;[15:251]   0x0233 , 0x0433 , ... 0x0A33 ,
                        ;           no_segment(10)
                        ;[8:42]     D_hi_con D_hi_var   ( -- D_hi_con D_hi_var )
    push DE             ; 1:11      D_hi_con D_hi_var
    push HL             ; 1:11      D_hi_con D_hi_var
    ld   DE, D_hi_con   ; 3:10      D_hi_con D_hi_var
    ld   HL, D_hi_var   ; 3:10      D_hi_con D_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x..-2..1 ; E
                        ;           no_segment(10)
    push HL             ; 1:11      0x3309 , 0x3307 , ... 0x3301 ,   version: E.lo <lo..-2..1>
    ld   HL, __create_E_lo_var; 3:10      0x3309 , 0x3307 , ... 0x3301 ,
    ld   BC, 0x0A33     ; 3:10      0x3309 , 0x3307 , ... 0x3301 ,
    dec   B             ; 1:4       0x3309 , 0x3307 , ... 0x3301 ,
    ld  (HL),B          ; 1:7       0x3309 , 0x3307 , ... 0x3301 ,
    inc  HL             ; 1:6       0x3309 , 0x3307 , ... 0x3301 ,
    ld  (HL),C          ; 1:7       0x3309 , 0x3307 , ... 0x3301 ,
    inc  HL             ; 1:6       0x3309 , 0x3307 , ... 0x3301 ,
    djnz $-5            ; 2:8/13    0x3309 , 0x3307 , ... 0x3301 ,
    pop  HL             ; 1:10      0x3309 , 0x3307 , ... 0x3301 ,
                        ;[15:251]   0x3309 , 0x3307 , ... 0x3301 ,
                        ;           no_segment(10)
                        ;[8:42]     E_lo_con E_lo_var   ( -- E_lo_con E_lo_var )
    push DE             ; 1:11      E_lo_con E_lo_var
    push HL             ; 1:11      E_lo_con E_lo_var
    ld   DE, E_lo_con   ; 3:10      E_lo_con E_lo_var
    ld   HL, E_lo_var   ; 3:10      E_lo_con E_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0933 , 0x0733 , ... 0x0133 ,   version: E.hi <hi..-2..1>
    ld   HL, __create_E_hi_var; 3:10      0x0933 , 0x0733 , ... 0x0133 ,
    ld   BC, 0x0A33     ; 3:10      0x0933 , 0x0733 , ... 0x0133 ,
    dec   B             ; 1:4       0x0933 , 0x0733 , ... 0x0133 ,
    ld  (HL),C          ; 1:7       0x0933 , 0x0733 , ... 0x0133 ,
    inc  HL             ; 1:6       0x0933 , 0x0733 , ... 0x0133 ,
    ld  (HL),B          ; 1:7       0x0933 , 0x0733 , ... 0x0133 ,
    inc  HL             ; 1:6       0x0933 , 0x0733 , ... 0x0133 ,
    djnz $-5            ; 2:8/13    0x0933 , 0x0733 , ... 0x0133 ,
    pop  HL             ; 1:10      0x0933 , 0x0733 , ... 0x0133 ,
                        ;[15:251]   0x0933 , 0x0733 , ... 0x0133 ,
                        ;           no_segment(10)
                        ;[8:42]     E_hi_con E_hi_var   ( -- E_hi_con E_hi_var )
    push DE             ; 1:11      E_hi_con E_hi_var
    push HL             ; 1:11      E_hi_con E_hi_var
    ld   DE, E_hi_con   ; 3:10      E_hi_con E_hi_var
    ld   HL, E_hi_var   ; 3:10      E_hi_con E_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 1..+2..x ; F
                        ;           no_segment(10)
    push HL             ; 1:11      0x3301 , 0x3303 , ... 0x3309 ,   version: F.lo <1..+2..lo>
    ld   HL, __create_F_lo_var+9; 3:10      0x3301 , 0x3303 , ... 0x3309 ,
    ld   BC, 0x0A33     ; 3:10      0x3301 , 0x3303 , ... 0x3309 ,
    dec   B             ; 1:4       0x3301 , 0x3303 , ... 0x3309 ,
    ld  (HL),C          ; 1:7       0x3301 , 0x3303 , ... 0x3309 ,
    dec  HL             ; 1:6       0x3301 , 0x3303 , ... 0x3309 ,
    ld  (HL),B          ; 1:7       0x3301 , 0x3303 , ... 0x3309 ,
    dec  HL             ; 1:6       0x3301 , 0x3303 , ... 0x3309 ,
    djnz $-5            ; 2:8/13    0x3301 , 0x3303 , ... 0x3309 ,
    pop  HL             ; 1:10      0x3301 , 0x3303 , ... 0x3309 ,
                        ;[15:251]   0x3301 , 0x3303 , ... 0x3309 ,
                        ;           no_segment(10)
                        ;[8:42]     F_lo_con F_lo_var   ( -- F_lo_con F_lo_var )
    push DE             ; 1:11      F_lo_con F_lo_var
    push HL             ; 1:11      F_lo_con F_lo_var
    ld   DE, F_lo_con   ; 3:10      F_lo_con F_lo_var
    ld   HL, F_lo_var   ; 3:10      F_lo_con F_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0133 , 0x0333 , ... 0x0933 ,   version: F.hi <1..+2..hi>
    ld   HL, __create_F_hi_var+9; 3:10      0x0133 , 0x0333 , ... 0x0933 ,
    ld   BC, 0x0A33     ; 3:10      0x0133 , 0x0333 , ... 0x0933 ,
    dec   B             ; 1:4       0x0133 , 0x0333 , ... 0x0933 ,
    ld  (HL),B          ; 1:7       0x0133 , 0x0333 , ... 0x0933 ,
    dec  HL             ; 1:6       0x0133 , 0x0333 , ... 0x0933 ,
    ld  (HL),C          ; 1:7       0x0133 , 0x0333 , ... 0x0933 ,
    dec  HL             ; 1:6       0x0133 , 0x0333 , ... 0x0933 ,
    djnz $-5            ; 2:8/13    0x0133 , 0x0333 , ... 0x0933 ,
    pop  HL             ; 1:10      0x0133 , 0x0333 , ... 0x0933 ,
                        ;[15:251]   0x0133 , 0x0333 , ... 0x0933 ,
                        ;           no_segment(10)
                        ;[8:42]     F_hi_con F_hi_var   ( -- F_hi_con F_hi_var )
    push DE             ; 1:11      F_hi_con F_hi_var
    push HL             ; 1:11      F_hi_con F_hi_var
    ld   DE, F_hi_con   ; 3:10      F_hi_con F_hi_var
    ld   HL, F_hi_var   ; 3:10      F_hi_con F_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x..-1..0 ; G
                        ;           no_segment(10)
    push HL             ; 1:11      0x3304 , 0x3303 , ... 0x3300 ,   version: G.lo <lo..-1..0>
    ld   HL, __create_G_lo_var; 3:10      0x3304 , 0x3303 , ... 0x3300 ,
    ld   BC, 0x3305     ; 3:10      0x3304 , 0x3303 , ... 0x3300 ,
    dec   C             ; 1:4       0x3304 , 0x3303 , ... 0x3300 ,
    ld  (HL),C          ; 1:7       0x3304 , 0x3303 , ... 0x3300 ,
    inc  HL             ; 1:6       0x3304 , 0x3303 , ... 0x3300 ,
    ld  (HL),B          ; 1:7       0x3304 , 0x3303 , ... 0x3300 ,
    inc  HL             ; 1:6       0x3304 , 0x3303 , ... 0x3300 ,
    jp   nz, $-5        ; 3:10      0x3304 , 0x3303 , ... 0x3300 ,
    pop  HL             ; 1:10      0x3304 , 0x3303 , ... 0x3300 ,
                        ;[16:241]   0x3304 , 0x3303 , ... 0x3300 ,
                        ;           no_segment(10)
                        ;[8:42]     G_lo_con G_lo_var   ( -- G_lo_con G_lo_var )
    push DE             ; 1:11      G_lo_con G_lo_var
    push HL             ; 1:11      G_lo_con G_lo_var
    ld   DE, G_lo_con   ; 3:10      G_lo_con G_lo_var
    ld   HL, G_lo_var   ; 3:10      G_lo_con G_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0433 , 0x0333 , ... 0x0033 ,   version: G.hi <hi..-1..0>
    ld   HL, __create_G_hi_var; 3:10      0x0433 , 0x0333 , ... 0x0033 ,
    ld   BC, 0x0533     ; 3:10      0x0433 , 0x0333 , ... 0x0033 ,
    dec   B             ; 1:4       0x0433 , 0x0333 , ... 0x0033 ,
    ld  (HL),C          ; 1:7       0x0433 , 0x0333 , ... 0x0033 ,
    inc  HL             ; 1:6       0x0433 , 0x0333 , ... 0x0033 ,
    ld  (HL),B          ; 1:7       0x0433 , 0x0333 , ... 0x0033 ,
    inc  HL             ; 1:6       0x0433 , 0x0333 , ... 0x0033 ,
    jp   nz, $-5        ; 3:10      0x0433 , 0x0333 , ... 0x0033 ,
    pop  HL             ; 1:10      0x0433 , 0x0333 , ... 0x0033 ,
                        ;[16:241]   0x0433 , 0x0333 , ... 0x0033 ,
                        ;           no_segment(10)
                        ;[8:42]     G_hi_con G_hi_var   ( -- G_hi_con G_hi_var )
    push DE             ; 1:11      G_hi_con G_hi_var
    push HL             ; 1:11      G_hi_con G_hi_var
    ld   DE, G_hi_con   ; 3:10      G_hi_con G_hi_var
    ld   HL, G_hi_var   ; 3:10      G_hi_con G_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 0..-1..x ; H
                        ;           no_segment(10)
    push HL             ; 1:11      0x3300 , 0x33FF , ... 0x33FC ,   version: H.lo <0..-1..lo>
    ld   HL, __create_H_lo_var+9; 3:10      0x3300 , 0x33FF , ... 0x33FC ,
    ld   BC, 0x33FB     ; 3:10      0x3300 , 0x33FF , ... 0x33FC ,
    inc   C             ; 1:4       0x3300 , 0x33FF , ... 0x33FC ,
    ld  (HL),B          ; 1:7       0x3300 , 0x33FF , ... 0x33FC ,
    dec  HL             ; 1:6       0x3300 , 0x33FF , ... 0x33FC ,
    ld  (HL),C          ; 1:7       0x3300 , 0x33FF , ... 0x33FC ,
    dec  HL             ; 1:6       0x3300 , 0x33FF , ... 0x33FC ,
    jp   nz, $-5        ; 3:10      0x3300 , 0x33FF , ... 0x33FC ,
    pop  HL             ; 1:10      0x3300 , 0x33FF , ... 0x33FC ,
                        ;[16:241]   0x3300 , 0x33FF , ... 0x33FC ,
                        ;           no_segment(10)
                        ;[8:42]     H_lo_con H_lo_var   ( -- H_lo_con H_lo_var )
    push DE             ; 1:11      H_lo_con H_lo_var
    push HL             ; 1:11      H_lo_con H_lo_var
    ld   DE, H_lo_con   ; 3:10      H_lo_con H_lo_var
    ld   HL, H_lo_var   ; 3:10      H_lo_con H_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0033 , 0xFF33 , ... 0xFC33 ,   version: H.hi <0..-1..hi>
    ld   HL, __create_H_hi_var+9; 3:10      0x0033 , 0xFF33 , ... 0xFC33 ,
    ld   BC, 0xFB33     ; 3:10      0x0033 , 0xFF33 , ... 0xFC33 ,
    inc   B             ; 1:4       0x0033 , 0xFF33 , ... 0xFC33 ,
    ld  (HL),B          ; 1:7       0x0033 , 0xFF33 , ... 0xFC33 ,
    dec  HL             ; 1:6       0x0033 , 0xFF33 , ... 0xFC33 ,
    ld  (HL),C          ; 1:7       0x0033 , 0xFF33 , ... 0xFC33 ,
    dec  HL             ; 1:6       0x0033 , 0xFF33 , ... 0xFC33 ,
    jp   nz, $-5        ; 3:10      0x0033 , 0xFF33 , ... 0xFC33 ,
    pop  HL             ; 1:10      0x0033 , 0xFF33 , ... 0xFC33 ,
                        ;[16:241]   0x0033 , 0xFF33 , ... 0xFC33 ,
                        ;           no_segment(10)
                        ;[8:42]     H_hi_con H_hi_var   ( -- H_hi_con H_hi_var )
    push DE             ; 1:11      H_hi_con H_hi_var
    push HL             ; 1:11      H_hi_con H_hi_var
    ld   DE, H_hi_con   ; 3:10      H_hi_con H_hi_var
    ld   HL, H_hi_var   ; 3:10      H_hi_con H_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x..+1..0 ; I
                        ;           no_segment(10)
    push HL             ; 1:11      0x33FC , 0x33FD , ... 0x3300 ,   version: I.lo <lo..+1..0>
    ld   HL, __create_I_lo_var; 3:10      0x33FC , 0x33FD , ... 0x3300 ,
    ld   BC, 0x33FB     ; 3:10      0x33FC , 0x33FD , ... 0x3300 ,
    inc   C             ; 1:4       0x33FC , 0x33FD , ... 0x3300 ,
    ld  (HL),C          ; 1:7       0x33FC , 0x33FD , ... 0x3300 ,
    inc  HL             ; 1:6       0x33FC , 0x33FD , ... 0x3300 ,
    ld  (HL),B          ; 1:7       0x33FC , 0x33FD , ... 0x3300 ,
    inc  HL             ; 1:6       0x33FC , 0x33FD , ... 0x3300 ,
    jp   nz, $-5        ; 3:10      0x33FC , 0x33FD , ... 0x3300 ,
    pop  HL             ; 1:10      0x33FC , 0x33FD , ... 0x3300 ,
                        ;[16:241]   0x33FC , 0x33FD , ... 0x3300 ,
                        ;           no_segment(10)
                        ;[8:42]     I_lo_con I_lo_var   ( -- I_lo_con I_lo_var )
    push DE             ; 1:11      I_lo_con I_lo_var
    push HL             ; 1:11      I_lo_con I_lo_var
    ld   DE, I_lo_con   ; 3:10      I_lo_con I_lo_var
    ld   HL, I_lo_var   ; 3:10      I_lo_con I_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0xFC33 , 0xFD33 , ... 0x0033 ,   version: I.hi <hi..+1..0>
    ld   HL, __create_I_hi_var; 3:10      0xFC33 , 0xFD33 , ... 0x0033 ,
    ld   BC, 0xFB33     ; 3:10      0xFC33 , 0xFD33 , ... 0x0033 ,
    inc   B             ; 1:4       0xFC33 , 0xFD33 , ... 0x0033 ,
    ld  (HL),C          ; 1:7       0xFC33 , 0xFD33 , ... 0x0033 ,
    inc  HL             ; 1:6       0xFC33 , 0xFD33 , ... 0x0033 ,
    ld  (HL),B          ; 1:7       0xFC33 , 0xFD33 , ... 0x0033 ,
    inc  HL             ; 1:6       0xFC33 , 0xFD33 , ... 0x0033 ,
    jp   nz, $-5        ; 3:10      0xFC33 , 0xFD33 , ... 0x0033 ,
    pop  HL             ; 1:10      0xFC33 , 0xFD33 , ... 0x0033 ,
                        ;[16:241]   0xFC33 , 0xFD33 , ... 0x0033 ,
                        ;           no_segment(10)
                        ;[8:42]     I_hi_con I_hi_var   ( -- I_hi_con I_hi_var )
    push DE             ; 1:11      I_hi_con I_hi_var
    push HL             ; 1:11      I_hi_con I_hi_var
    ld   DE, I_hi_con   ; 3:10      I_hi_con I_hi_var
    ld   HL, I_hi_var   ; 3:10      I_hi_con I_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 0..+1..x ; J
                        ;           no_segment(10)
    push HL             ; 1:11      0x3300 , 0x3301 , ... 0x3304 ,   version: J.lo <0..+1..lo>
    ld   HL, __create_J_lo_var+9; 3:10      0x3300 , 0x3301 , ... 0x3304 ,
    ld   BC, 0x3305     ; 3:10      0x3300 , 0x3301 , ... 0x3304 ,
    dec   C             ; 1:4       0x3300 , 0x3301 , ... 0x3304 ,
    ld  (HL),B          ; 1:7       0x3300 , 0x3301 , ... 0x3304 ,
    dec  HL             ; 1:6       0x3300 , 0x3301 , ... 0x3304 ,
    ld  (HL),C          ; 1:7       0x3300 , 0x3301 , ... 0x3304 ,
    dec  HL             ; 1:6       0x3300 , 0x3301 , ... 0x3304 ,
    jp   nz, $-5        ; 3:10      0x3300 , 0x3301 , ... 0x3304 ,
    pop  HL             ; 1:10      0x3300 , 0x3301 , ... 0x3304 ,
                        ;[16:241]   0x3300 , 0x3301 , ... 0x3304 ,
                        ;           no_segment(10)
                        ;[8:42]     J_lo_con J_lo_var   ( -- J_lo_con J_lo_var )
    push DE             ; 1:11      J_lo_con J_lo_var
    push HL             ; 1:11      J_lo_con J_lo_var
    ld   DE, J_lo_con   ; 3:10      J_lo_con J_lo_var
    ld   HL, J_lo_var   ; 3:10      J_lo_con J_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0033 , 0x0133 , ... 0x0433 ,   version: J.hi <0..+1..hi>
    ld   HL, __create_J_hi_var+9; 3:10      0x0033 , 0x0133 , ... 0x0433 ,
    ld   BC, 0x0533     ; 3:10      0x0033 , 0x0133 , ... 0x0433 ,
    dec   B             ; 1:4       0x0033 , 0x0133 , ... 0x0433 ,
    ld  (HL),B          ; 1:7       0x0033 , 0x0133 , ... 0x0433 ,
    dec  HL             ; 1:6       0x0033 , 0x0133 , ... 0x0433 ,
    ld  (HL),C          ; 1:7       0x0033 , 0x0133 , ... 0x0433 ,
    dec  HL             ; 1:6       0x0033 , 0x0133 , ... 0x0433 ,
    jp   nz, $-5        ; 3:10      0x0033 , 0x0133 , ... 0x0433 ,
    pop  HL             ; 1:10      0x0033 , 0x0133 , ... 0x0433 ,
                        ;[16:241]   0x0033 , 0x0133 , ... 0x0433 ,
                        ;           no_segment(10)
                        ;[8:42]     J_hi_con J_hi_var   ( -- J_hi_con J_hi_var )
    push DE             ; 1:11      J_hi_con J_hi_var
    push HL             ; 1:11      J_hi_con J_hi_var
    ld   DE, J_hi_con   ; 3:10      J_hi_con J_hi_var
    ld   HL, J_hi_var   ; 3:10      J_hi_con J_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x..-1..x ; K
                        ;           no_segment(10)
    push HL             ; 1:11      0x330A , 0x3309 , ... 0x3306 ,   version: K.lo <lo..-1..lo>
    ld   HL, __create_K_lo_var; 3:10      0x330A , 0x3309 , ... 0x3306 ,
    ld   BC, 0x050A     ; 3:10      0x330A , 0x3309 , ... 0x3306 ,
    ld  (HL),C          ; 1:7       0x330A , 0x3309 , ... 0x3306 ,
    inc  HL             ; 1:6       0x330A , 0x3309 , ... 0x3306 ,
    ld  (HL),0x33       ; 2:10      0x330A , 0x3309 , ... 0x3306 ,
    inc  HL             ; 1:6       0x330A , 0x3309 , ... 0x3306 ,
    dec   C             ; 1:4       0x330A , 0x3309 , ... 0x3306 ,
    djnz $-6            ; 2:8/13    0x330A , 0x3309 , ... 0x3306 ,
    pop  HL             ; 1:10      0x330A , 0x3309 , ... 0x3306 ,
                        ;[16:266]   0x330A , 0x3309 , ... 0x3306 ,
                        ;           no_segment(10)
                        ;[8:42]     K_lo_con K_lo_var   ( -- K_lo_con K_lo_var )
    push DE             ; 1:11      K_lo_con K_lo_var
    push HL             ; 1:11      K_lo_con K_lo_var
    ld   DE, K_lo_con   ; 3:10      K_lo_con K_lo_var
    ld   HL, K_lo_var   ; 3:10      K_lo_con K_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0A33 , 0x0933 , ... 0x0633 ,   version: K.hi <hi..-1..hi>
    ld   HL, __create_K_hi_var; 3:10      0x0A33 , 0x0933 , ... 0x0633 ,
    ld   BC, 0x050A     ; 3:10      0x0A33 , 0x0933 , ... 0x0633 ,
    ld  (HL),0x33       ; 2:10      0x0A33 , 0x0933 , ... 0x0633 ,
    inc  HL             ; 1:6       0x0A33 , 0x0933 , ... 0x0633 ,
    ld  (HL),C          ; 1:7       0x0A33 , 0x0933 , ... 0x0633 ,
    inc  HL             ; 1:6       0x0A33 , 0x0933 , ... 0x0633 ,
    dec   C             ; 1:4       0x0A33 , 0x0933 , ... 0x0633 ,
    djnz $-6            ; 2:8/13    0x0A33 , 0x0933 , ... 0x0633 ,
    pop  HL             ; 1:10      0x0A33 , 0x0933 , ... 0x0633 ,
                        ;[16:266]   0x0A33 , 0x0933 , ... 0x0633 ,
                        ;           no_segment(10)
                        ;[8:42]     K_hi_con K_hi_var   ( -- K_hi_con K_hi_var )
    push DE             ; 1:11      K_hi_con K_hi_var
    push HL             ; 1:11      K_hi_con K_hi_var
    ld   DE, K_hi_con   ; 3:10      K_hi_con K_hi_var
    ld   HL, K_hi_var   ; 3:10      K_hi_con K_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x..+1..x ; L
                        ;           no_segment(10)
    push HL             ; 1:11      0x3306 , 0x3307 , ... 0x330A ,   version: L.lo <lo..+1..lo>
    ld   HL, __create_L_lo_var; 3:10      0x3306 , 0x3307 , ... 0x330A ,
    ld   BC, 0x0506     ; 3:10      0x3306 , 0x3307 , ... 0x330A ,
    ld  (HL),C          ; 1:7       0x3306 , 0x3307 , ... 0x330A ,
    inc  HL             ; 1:6       0x3306 , 0x3307 , ... 0x330A ,
    ld  (HL),0x33       ; 2:10      0x3306 , 0x3307 , ... 0x330A ,
    inc  HL             ; 1:6       0x3306 , 0x3307 , ... 0x330A ,
    inc   C             ; 1:4       0x3306 , 0x3307 , ... 0x330A ,
    djnz $-6            ; 2:8/13    0x3306 , 0x3307 , ... 0x330A ,
    pop  HL             ; 1:10      0x3306 , 0x3307 , ... 0x330A ,
                        ;[16:266]   0x3306 , 0x3307 , ... 0x330A ,
                        ;           no_segment(10)
                        ;[8:42]     L_lo_con L_lo_var   ( -- L_lo_con L_lo_var )
    push DE             ; 1:11      L_lo_con L_lo_var
    push HL             ; 1:11      L_lo_con L_lo_var
    ld   DE, L_lo_con   ; 3:10      L_lo_con L_lo_var
    ld   HL, L_lo_var   ; 3:10      L_lo_con L_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0633 , 0x0733 , ... 0x0A33 ,   version: L.hi <hi..+1..hi>
    ld   HL, __create_L_hi_var; 3:10      0x0633 , 0x0733 , ... 0x0A33 ,
    ld   BC, 0x0506     ; 3:10      0x0633 , 0x0733 , ... 0x0A33 ,
    ld  (HL),0x33       ; 2:10      0x0633 , 0x0733 , ... 0x0A33 ,
    inc  HL             ; 1:6       0x0633 , 0x0733 , ... 0x0A33 ,
    ld  (HL),C          ; 1:7       0x0633 , 0x0733 , ... 0x0A33 ,
    inc  HL             ; 1:6       0x0633 , 0x0733 , ... 0x0A33 ,
    inc   C             ; 1:4       0x0633 , 0x0733 , ... 0x0A33 ,
    djnz $-6            ; 2:8/13    0x0633 , 0x0733 , ... 0x0A33 ,
    pop  HL             ; 1:10      0x0633 , 0x0733 , ... 0x0A33 ,
                        ;[16:266]   0x0633 , 0x0733 , ... 0x0A33 ,
                        ;           no_segment(10)
                        ;[8:42]     L_hi_con L_hi_var   ( -- L_hi_con L_hi_var )
    push DE             ; 1:11      L_hi_con L_hi_var
    push HL             ; 1:11      L_hi_con L_hi_var
    ld   DE, L_hi_con   ; 3:10      L_hi_con L_hi_var
    ld   HL, L_hi_var   ; 3:10      L_hi_con L_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw n*x..+-x..0 ; M
                        ;           no_segment(10)
    push HL             ; 1:11      0x330C , 0x3309 , ... 0x3300 ,   version: M.lo <lo..+-x..0>
    ld   HL, __create_M_lo_var; 3:10      0x330C , 0x3309 , ... 0x3300 ,
    ld    A, 0x0F       ; 2:7       0x330C , 0x3309 , ... 0x3300 ,
    ld   BC, 0x33FD     ; 3:10      0x330C , 0x3309 , ... 0x3300 ,
    add   A, C          ; 1:4       0x330C , 0x3309 , ... 0x3300 ,
    ld  (HL),A          ; 1:7       0x330C , 0x3309 , ... 0x3300 ,
    inc  HL             ; 1:6       0x330C , 0x3309 , ... 0x3300 ,
    ld  (HL),B          ; 1:7       0x330C , 0x3309 , ... 0x3300 ,
    inc  HL             ; 1:6       0x330C , 0x3309 , ... 0x3300 ,
    jr   nz, $-5        ; 2:7/12    0x330C , 0x3309 , ... 0x3300 ,
    pop  HL             ; 1:10      0x330C , 0x3309 , ... 0x3300 ,
                        ;[17:253]   0x330C , 0x3309 , ... 0x3300 ,
                        ;           no_segment(10)
                        ;[8:42]     M_lo_con M_lo_var   ( -- M_lo_con M_lo_var )
    push DE             ; 1:11      M_lo_con M_lo_var
    push HL             ; 1:11      M_lo_con M_lo_var
    ld   DE, M_lo_con   ; 3:10      M_lo_con M_lo_var
    ld   HL, M_lo_var   ; 3:10      M_lo_con M_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0C33 , 0x0933 , ... 0x0033 ,   version: M.hi <hi..+-x..0>
    ld   HL, __create_M_hi_var; 3:10      0x0C33 , 0x0933 , ... 0x0033 ,
    ld    A, 0x0F       ; 2:7       0x0C33 , 0x0933 , ... 0x0033 ,
    ld   BC, 0xFD33     ; 3:10      0x0C33 , 0x0933 , ... 0x0033 ,
    add   A, B          ; 1:4       0x0C33 , 0x0933 , ... 0x0033 ,
    ld  (HL),C          ; 1:7       0x0C33 , 0x0933 , ... 0x0033 ,
    inc  HL             ; 1:6       0x0C33 , 0x0933 , ... 0x0033 ,
    ld  (HL),A          ; 1:7       0x0C33 , 0x0933 , ... 0x0033 ,
    inc  HL             ; 1:6       0x0C33 , 0x0933 , ... 0x0033 ,
    jr   nz, $-5        ; 2:7/12    0x0C33 , 0x0933 , ... 0x0033 ,
    pop  HL             ; 1:10      0x0C33 , 0x0933 , ... 0x0033 ,
                        ;[17:253]   0x0C33 , 0x0933 , ... 0x0033 ,
                        ;           no_segment(10)
                        ;[8:42]     M_hi_con M_hi_var   ( -- M_hi_con M_hi_var )
    push DE             ; 1:11      M_hi_con M_hi_var
    push HL             ; 1:11      M_hi_con M_hi_var
    ld   DE, M_hi_con   ; 3:10      M_hi_con M_hi_var
    ld   HL, M_hi_var   ; 3:10      M_hi_con M_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 0..+-x..n*x ; N
                        ;           no_segment(10)
    push HL             ; 1:11      0x3300 , 0x3303 , ... 0x330C ,   version: N.lo <0..+-x..lo>
    ld   HL, __create_N_lo_var+9; 3:10      0x3300 , 0x3303 , ... 0x330C ,
    ld    A, 0x0F       ; 2:7       0x3300 , 0x3303 , ... 0x330C ,
    ld   BC, 0x33FD     ; 3:10      0x3300 , 0x3303 , ... 0x330C ,
    add   A, C          ; 1:4       0x3300 , 0x3303 , ... 0x330C ,
    ld  (HL),B          ; 1:7       0x3300 , 0x3303 , ... 0x330C ,
    dec  HL             ; 1:6       0x3300 , 0x3303 , ... 0x330C ,
    ld  (HL),A          ; 1:7       0x3300 , 0x3303 , ... 0x330C ,
    dec  HL             ; 1:6       0x3300 , 0x3303 , ... 0x330C ,
    jr   nz, $-5        ; 2:7/12    0x3300 , 0x3303 , ... 0x330C ,
    pop  HL             ; 1:10      0x3300 , 0x3303 , ... 0x330C ,
                        ;[17:253]   0x3300 , 0x3303 , ... 0x330C ,
                        ;           no_segment(10)
                        ;[8:42]     N_lo_con N_lo_var   ( -- N_lo_con N_lo_var )
    push DE             ; 1:11      N_lo_con N_lo_var
    push HL             ; 1:11      N_lo_con N_lo_var
    ld   DE, N_lo_con   ; 3:10      N_lo_con N_lo_var
    ld   HL, N_lo_var   ; 3:10      N_lo_con N_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0033 , 0x0333 , ... 0x0C33 ,   version: N.hi <0..+-x..hi>
    ld   HL, __create_N_hi_var+9; 3:10      0x0033 , 0x0333 , ... 0x0C33 ,
    ld    A, 0x0F       ; 2:7       0x0033 , 0x0333 , ... 0x0C33 ,
    ld   BC, 0xFD33     ; 3:10      0x0033 , 0x0333 , ... 0x0C33 ,
    add   A, B          ; 1:4       0x0033 , 0x0333 , ... 0x0C33 ,
    ld  (HL),A          ; 1:7       0x0033 , 0x0333 , ... 0x0C33 ,
    dec  HL             ; 1:6       0x0033 , 0x0333 , ... 0x0C33 ,
    ld  (HL),C          ; 1:7       0x0033 , 0x0333 , ... 0x0C33 ,
    dec  HL             ; 1:6       0x0033 , 0x0333 , ... 0x0C33 ,
    jr   nz, $-5        ; 2:7/12    0x0033 , 0x0333 , ... 0x0C33 ,
    pop  HL             ; 1:10      0x0033 , 0x0333 , ... 0x0C33 ,
                        ;[17:253]   0x0033 , 0x0333 , ... 0x0C33 ,
                        ;           no_segment(10)
                        ;[8:42]     N_hi_con N_hi_var   ( -- N_hi_con N_hi_var )
    push DE             ; 1:11      N_hi_con N_hi_var
    push HL             ; 1:11      N_hi_con N_hi_var
    ld   DE, N_hi_con   ; 3:10      N_hi_con N_hi_var
    ld   HL, N_hi_var   ; 3:10      N_hi_con N_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw n*x..+-x..x ; O
                        ;           no_segment(10)
    push HL             ; 1:11      0x330F , 0x330C , ... 0x3303 ,   version: O.lo <lo..+-x..x>
    ld   HL, __create_O_lo_var; 3:10      0x330F , 0x330C , ... 0x3303 ,
    ld    A, 0x0F       ; 2:7       0x330F , 0x330C , ... 0x3303 ,
    ld   BC, 0x33FD     ; 3:10      0x330F , 0x330C , ... 0x3303 ,
    ld  (HL),A          ; 1:7       0x330F , 0x330C , ... 0x3303 ,
    inc  HL             ; 1:6       0x330F , 0x330C , ... 0x3303 ,
    ld  (HL),B          ; 1:7       0x330F , 0x330C , ... 0x3303 ,
    inc  HL             ; 1:6       0x330F , 0x330C , ... 0x3303 ,
    add   A, C          ; 1:4       0x330F , 0x330C , ... 0x3303 ,
    jr   nz, $-5        ; 2:7/12    0x330F , 0x330C , ... 0x3303 ,
    pop  HL             ; 1:10      0x330F , 0x330C , ... 0x3303 ,
                        ;[17:253]   0x330F , 0x330C , ... 0x3303 ,
                        ;           no_segment(10)
                        ;[8:42]     O_lo_con O_lo_var   ( -- O_lo_con O_lo_var )
    push DE             ; 1:11      O_lo_con O_lo_var
    push HL             ; 1:11      O_lo_con O_lo_var
    ld   DE, O_lo_con   ; 3:10      O_lo_con O_lo_var
    ld   HL, O_lo_var   ; 3:10      O_lo_con O_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0F33 , 0x0C33 , ... 0x0333 ,   version: O.hi <hi..+-x..x>
    ld   HL, __create_O_hi_var; 3:10      0x0F33 , 0x0C33 , ... 0x0333 ,
    ld    A, 0x0F       ; 2:7       0x0F33 , 0x0C33 , ... 0x0333 ,
    ld   BC, 0xFD33     ; 3:10      0x0F33 , 0x0C33 , ... 0x0333 ,
    ld  (HL),C          ; 1:7       0x0F33 , 0x0C33 , ... 0x0333 ,
    inc  HL             ; 1:6       0x0F33 , 0x0C33 , ... 0x0333 ,
    ld  (HL),A          ; 1:7       0x0F33 , 0x0C33 , ... 0x0333 ,
    inc  HL             ; 1:6       0x0F33 , 0x0C33 , ... 0x0333 ,
    add   A, B          ; 1:4       0x0F33 , 0x0C33 , ... 0x0333 ,
    jr   nz, $-5        ; 2:7/12    0x0F33 , 0x0C33 , ... 0x0333 ,
    pop  HL             ; 1:10      0x0F33 , 0x0C33 , ... 0x0333 ,
                        ;[17:253]   0x0F33 , 0x0C33 , ... 0x0333 ,
                        ;           no_segment(10)
                        ;[8:42]     O_hi_con O_hi_var   ( -- O_hi_con O_hi_var )
    push DE             ; 1:11      O_hi_con O_hi_var
    push HL             ; 1:11      O_hi_con O_hi_var
    ld   DE, O_hi_con   ; 3:10      O_hi_con O_hi_var
    ld   HL, O_hi_var   ; 3:10      O_hi_con O_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x..+-x..n*x ; P
                        ;           no_segment(10)
    push HL             ; 1:11      0x3303 , 0x3306 , ... 0x330F ,   version: P.lo <x..+-x..lo>
    ld   HL, __create_P_lo_var+9; 3:10      0x3303 , 0x3306 , ... 0x330F ,
    ld    A, 0x0F       ; 2:7       0x3303 , 0x3306 , ... 0x330F ,
    ld   BC, 0x33FD     ; 3:10      0x3303 , 0x3306 , ... 0x330F ,
    ld  (HL),B          ; 1:7       0x3303 , 0x3306 , ... 0x330F ,
    dec  HL             ; 1:6       0x3303 , 0x3306 , ... 0x330F ,
    ld  (HL),A          ; 1:7       0x3303 , 0x3306 , ... 0x330F ,
    dec  HL             ; 1:6       0x3303 , 0x3306 , ... 0x330F ,
    add   A, C          ; 1:4       0x3303 , 0x3306 , ... 0x330F ,
    jr   nz, $-5        ; 2:7/12    0x3303 , 0x3306 , ... 0x330F ,
    pop  HL             ; 1:10      0x3303 , 0x3306 , ... 0x330F ,
                        ;[17:253]   0x3303 , 0x3306 , ... 0x330F ,
                        ;           no_segment(10)
                        ;[8:42]     P_lo_con P_lo_var   ( -- P_lo_con P_lo_var )
    push DE             ; 1:11      P_lo_con P_lo_var
    push HL             ; 1:11      P_lo_con P_lo_var
    ld   DE, P_lo_con   ; 3:10      P_lo_con P_lo_var
    ld   HL, P_lo_var   ; 3:10      P_lo_con P_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0333 , 0x0633 , ... 0x0F33 ,   version: P.hi <x..+-x..hi>
    ld   HL, __create_P_hi_var+9; 3:10      0x0333 , 0x0633 , ... 0x0F33 ,
    ld    A, 0x0F       ; 2:7       0x0333 , 0x0633 , ... 0x0F33 ,
    ld   BC, 0xFD33     ; 3:10      0x0333 , 0x0633 , ... 0x0F33 ,
    ld  (HL),A          ; 1:7       0x0333 , 0x0633 , ... 0x0F33 ,
    dec  HL             ; 1:6       0x0333 , 0x0633 , ... 0x0F33 ,
    ld  (HL),C          ; 1:7       0x0333 , 0x0633 , ... 0x0F33 ,
    dec  HL             ; 1:6       0x0333 , 0x0633 , ... 0x0F33 ,
    add   A, B          ; 1:4       0x0333 , 0x0633 , ... 0x0F33 ,
    jr   nz, $-5        ; 2:7/12    0x0333 , 0x0633 , ... 0x0F33 ,
    pop  HL             ; 1:10      0x0333 , 0x0633 , ... 0x0F33 ,
                        ;[17:253]   0x0333 , 0x0633 , ... 0x0F33 ,
                        ;           no_segment(10)
                        ;[8:42]     P_hi_con P_hi_var   ( -- P_hi_con P_hi_var )
    push DE             ; 1:11      P_hi_con P_hi_var
    push HL             ; 1:11      P_hi_con P_hi_var
    ld   DE, P_hi_con   ; 3:10      P_hi_con P_hi_var
    ld   HL, P_hi_var   ; 3:10      P_hi_con P_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw m*x..+-x..n*x ; Q
                        ;           no_segment(10)
    push HL             ; 1:11      0x3306 , 0x3309 , ... 0x3312 ,   version: Q.lo <lo..+-x..lo>
    ld   HL, __create_Q_lo_var; 3:10      0x3306 , 0x3309 , ... 0x3312 ,
    ld    A, 0x06       ; 2:7       0x3306 , 0x3309 , ... 0x3312 ,
    ld   BC, 0x0503     ; 3:10      0x3306 , 0x3309 , ... 0x3312 ,
    ld  (HL),A          ; 1:7       0x3306 , 0x3309 , ... 0x3312 ,
    inc  HL             ; 1:6       0x3306 , 0x3309 , ... 0x3312 ,
    ld  (HL),0x33       ; 2:10      0x3306 , 0x3309 , ... 0x3312 ,
    inc  HL             ; 1:6       0x3306 , 0x3309 , ... 0x3312 ,
    add   A, C          ; 1:4       0x3306 , 0x3309 , ... 0x3312 ,
    djnz $-6            ; 2:8/13    0x3306 , 0x3309 , ... 0x3312 ,
    pop  HL             ; 1:10      0x3306 , 0x3309 , ... 0x3312 ,
                        ;[18:273]   0x3306 , 0x3309 , ... 0x3312 ,
                        ;           no_segment(10)
                        ;[8:42]     Q_lo_con Q_lo_var   ( -- Q_lo_con Q_lo_var )
    push DE             ; 1:11      Q_lo_con Q_lo_var
    push HL             ; 1:11      Q_lo_con Q_lo_var
    ld   DE, Q_lo_con   ; 3:10      Q_lo_con Q_lo_var
    ld   HL, Q_lo_var   ; 3:10      Q_lo_con Q_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
                        ;           no_segment(10)
    push HL             ; 1:11      0x0633 , 0x0933 , ... 0x1233 ,   version: Q.hi <hi..+-x..hi>
    ld   HL, __create_Q_hi_var; 3:10      0x0633 , 0x0933 , ... 0x1233 ,
    ld    A, 0x06       ; 2:7       0x0633 , 0x0933 , ... 0x1233 ,
    ld   BC, 0x0503     ; 3:10      0x0633 , 0x0933 , ... 0x1233 ,
    ld  (HL),0x33       ; 2:10      0x0633 , 0x0933 , ... 0x1233 ,
    inc  HL             ; 1:6       0x0633 , 0x0933 , ... 0x1233 ,
    ld  (HL),A          ; 1:7       0x0633 , 0x0933 , ... 0x1233 ,
    inc  HL             ; 1:6       0x0633 , 0x0933 , ... 0x1233 ,
    add   A, C          ; 1:4       0x0633 , 0x0933 , ... 0x1233 ,
    djnz $-6            ; 2:8/13    0x0633 , 0x0933 , ... 0x1233 ,
    pop  HL             ; 1:10      0x0633 , 0x0933 , ... 0x1233 ,
                        ;[18:273]   0x0633 , 0x0933 , ... 0x1233 ,
                        ;           no_segment(10)
                        ;[8:42]     Q_hi_con Q_hi_var   ( -- Q_hi_con Q_hi_var )
    push DE             ; 1:11      Q_hi_con Q_hi_var
    push HL             ; 1:11      Q_hi_con Q_hi_var
    ld   DE, Q_hi_con   ; 3:10      Q_hi_con Q_hi_var
    ld   HL, Q_hi_var   ; 3:10      Q_hi_con Q_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw X..-1..x hi(x)<>hi(X); R
                        ;           no_segment(10)
    push HL             ; 1:11      0x33FE , 0x33FF , ... 0x3402 ,   version: R n<=256 <x..+1..X> hi(x)<>hi(X)
    ld   HL, __create_R_lo_var; 3:10      0x33FE , 0x33FF , ... 0x3402 ,
    ld   BC, 0x33FE     ; 3:10      0x33FE , 0x33FF , ... 0x3402 ,
    ld    A, 0x05       ; 2:7       0x33FE , 0x33FF , ... 0x3402 ,
    ld  (HL),C          ; 1:7       0x33FE , 0x33FF , ... 0x3402 ,
    inc  HL             ; 1:6       0x33FE , 0x33FF , ... 0x3402 ,
    ld  (HL),B          ; 1:7       0x33FE , 0x33FF , ... 0x3402 ,
    inc  HL             ; 1:6       0x33FE , 0x33FF , ... 0x3402 ,
    inc  BC             ; 1:6       0x33FE , 0x33FF , ... 0x3402 ,
    dec   A             ; 1:4       0x33FE , 0x33FF , ... 0x3402 ,
    jr   nz, $-6        ; 2:7/12    0x33FE , 0x33FF , ... 0x3402 ,
    pop  HL             ; 1:10      0x33FE , 0x33FF , ... 0x3402 ,
                        ;[18:283]   0x33FE , 0x33FF , ... 0x3402 ,
                        ;           no_segment(10)
                        ;[8:42]     R_lo_con R_lo_var   ( -- R_lo_con R_lo_var )
    push DE             ; 1:11      R_lo_con R_lo_var
    push HL             ; 1:11      R_lo_con R_lo_var
    ld   DE, R_lo_con   ; 3:10      R_lo_con R_lo_var
    ld   HL, R_lo_var   ; 3:10      R_lo_con R_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x..+1..X hi(x)<>hi(X); S
                        ;           no_segment(10)
    push HL             ; 1:11      0x3402 , 0x3401 , ... 0x33FE ,   version: S n<=256 <X..-1..x> hi(x)<>hi(X)
    ld   HL, __create_S_lo_var; 3:10      0x3402 , 0x3401 , ... 0x33FE ,
    ld   BC, 0x3402     ; 3:10      0x3402 , 0x3401 , ... 0x33FE ,
    ld    A, 0x05       ; 2:7       0x3402 , 0x3401 , ... 0x33FE ,
    ld  (HL),C          ; 1:7       0x3402 , 0x3401 , ... 0x33FE ,
    inc  HL             ; 1:6       0x3402 , 0x3401 , ... 0x33FE ,
    ld  (HL),B          ; 1:7       0x3402 , 0x3401 , ... 0x33FE ,
    inc  HL             ; 1:6       0x3402 , 0x3401 , ... 0x33FE ,
    dec  BC             ; 1:6       0x3402 , 0x3401 , ... 0x33FE ,
    dec   A             ; 1:4       0x3402 , 0x3401 , ... 0x33FE ,
    jr   nz, $-6        ; 2:7/12    0x3402 , 0x3401 , ... 0x33FE ,
    pop  HL             ; 1:10      0x3402 , 0x3401 , ... 0x33FE ,
                        ;[18:283]   0x3402 , 0x3401 , ... 0x33FE ,
                        ;           no_segment(10)
                        ;[8:42]     S_lo_con S_lo_var   ( -- S_lo_con S_lo_var )
    push DE             ; 1:11      S_lo_con S_lo_var
    push HL             ; 1:11      S_lo_con S_lo_var
    ld   DE, S_lo_con   ; 3:10      S_lo_con S_lo_var
    ld   HL, S_lo_var   ; 3:10      S_lo_con S_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 2*lo; T
                        ;           no_segment(10)
    push HL             ; 1:11      0x3360 , 0x33C0 , ... 0x3300 ,   version: T 2*lo
    ld   HL, __create_T_lo_var; 3:10      0x3360 , 0x33C0 , ... 0x3300 ,
    ld   BC, 0x0533     ; 3:10      0x3360 , 0x33C0 , ... 0x3300 ,
    ld    A, 0x60       ; 2:7       0x3360 , 0x33C0 , ... 0x3300 ,
    ld  (HL),A          ; 1:7       0x3360 , 0x33C0 , ... 0x3300 ,
    inc  HL             ; 1:6       0x3360 , 0x33C0 , ... 0x3300 ,
    ld  (HL),C          ; 1:7       0x3360 , 0x33C0 , ... 0x3300 ,
    inc  HL             ; 1:6       0x3360 , 0x33C0 , ... 0x3300 ,
    add   A, A          ; 1:4       0x3360 , 0x33C0 , ... 0x3300 ,
    djnz $-5            ; 2:8/13    0x3360 , 0x33C0 , ... 0x3300 ,
    pop  HL             ; 1:10      0x3360 , 0x33C0 , ... 0x3300 ,
                        ;[17:258]   0x3360 , 0x33C0 , ... 0x3300 ,
                        ;           no_segment(10)
                        ;[8:42]     T_lo_con T_lo_var   ( -- T_lo_con T_lo_var )
    push DE             ; 1:11      T_lo_con T_lo_var
    push HL             ; 1:11      T_lo_con T_lo_var
    ld   DE, T_lo_con   ; 3:10      T_lo_con T_lo_var
    ld   HL, T_lo_var   ; 3:10      T_lo_con T_lo_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 2*hi; T
                        ;           no_segment(10)
    push HL             ; 1:11      0x0233 , 0x0433 , ... 0x2033 ,   version: T 2*hi
    ld   HL, __create_T_hi_var; 3:10      0x0233 , 0x0433 , ... 0x2033 ,
    ld   BC, 0x0533     ; 3:10      0x0233 , 0x0433 , ... 0x2033 ,
    ld    A, 0x02       ; 2:7       0x0233 , 0x0433 , ... 0x2033 ,
    ld  (HL),C          ; 1:7       0x0233 , 0x0433 , ... 0x2033 ,
    inc  HL             ; 1:6       0x0233 , 0x0433 , ... 0x2033 ,
    ld  (HL),A          ; 1:7       0x0233 , 0x0433 , ... 0x2033 ,
    inc  HL             ; 1:6       0x0233 , 0x0433 , ... 0x2033 ,
    add   A, A          ; 1:4       0x0233 , 0x0433 , ... 0x2033 ,
    djnz $-5            ; 2:8/13    0x0233 , 0x0433 , ... 0x2033 ,
    pop  HL             ; 1:10      0x0233 , 0x0433 , ... 0x2033 ,
                        ;[17:258]   0x0233 , 0x0433 , ... 0x2033 ,
                        ;           no_segment(10)
                        ;[8:42]     T_hi_con T_hi_var   ( -- T_hi_con T_hi_var )
    push DE             ; 1:11      T_hi_con T_hi_var
    push HL             ; 1:11      T_hi_con T_hi_var
    ld   DE, T_hi_con   ; 3:10      T_hi_con T_hi_var
    ld   HL, T_hi_var   ; 3:10      T_hi_con T_hi_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw 2*x; T
                        ;           no_segment(10)
    push HL             ; 1:11      0x0283 , 0x0506 , ... 0x2830 ,   version: T 2*16-bit
    ld   HL, __create_T_16_var; 3:10      0x0283 , 0x0506 , ... 0x2830 ,
    ld   BC, 0x0502     ; 3:10      0x0283 , 0x0506 , ... 0x2830 ,
    ld    A, 0x83       ; 2:7       0x0283 , 0x0506 , ... 0x2830 ,
    ld  (HL),A          ; 1:7       0x0283 , 0x0506 , ... 0x2830 ,
    inc  HL             ; 1:6       0x0283 , 0x0506 , ... 0x2830 ,
    ld  (HL),C          ; 1:7       0x0283 , 0x0506 , ... 0x2830 ,
    inc  HL             ; 1:6       0x0283 , 0x0506 , ... 0x2830 ,
    add   A, A          ; 1:4       0x0283 , 0x0506 , ... 0x2830 ,
    rl    C             ; 2:8       0x0283 , 0x0506 , ... 0x2830 ,
    djnz $-7            ; 2:8/13    0x0283 , 0x0506 , ... 0x2830 ,
    pop  HL             ; 1:10      0x0283 , 0x0506 , ... 0x2830 ,
                        ;[19:298]   0x0283 , 0x0506 , ... 0x2830 ,
                        ;           no_segment(10)
                        ;[8:42]     T_16_con T_16_var   ( -- T_16_con T_16_var )
    push DE             ; 1:11      T_16_con T_16_var
    push HL             ; 1:11      T_16_con T_16_var
    ld   DE, T_16_con   ; 3:10      T_16_con T_16_var
    ld   HL, T_16_var   ; 3:10      T_16_con T_16_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw +0 16-bit; hi==lo
                        ;           no_segment(10)
    push HL             ; 1:11      0x3333 , 0x3333 , ... 0x3333 ,   +0 n<=256 hi==lo
    ld   HL, __create_Z_8_var; 3:10      0x3333 , 0x3333 , ... 0x3333 ,
    ld   BC, 0x0533     ; 3:10      0x3333 , 0x3333 , ... 0x3333 ,
    ld  (HL),C          ; 1:7       0x3333 , 0x3333 , ... 0x3333 ,
    inc  HL             ; 1:6       0x3333 , 0x3333 , ... 0x3333 ,
    ld  (HL),C          ; 1:7       0x3333 , 0x3333 , ... 0x3333 ,
    inc  HL             ; 1:6       0x3333 , 0x3333 , ... 0x3333 ,
    djnz $-4            ; 2:8/13    0x3333 , 0x3333 , ... 0x3333 ,
    pop  HL             ; 1:10      0x3333 , 0x3333 , ... 0x3333 ,
                        ;[14:231]   0x3333 , 0x3333 , ... 0x3333 ,
                        ;           no_segment(10)
                        ;[8:42]     Z_8_con Z_8_var   ( -- Z_8_con Z_8_var )
    push DE             ; 1:11      Z_8_con Z_8_var
    push HL             ; 1:11      Z_8_con Z_8_var
    ld   DE, Z_8_con    ; 3:10      Z_8_con Z_8_var
    ld   HL, Z_8_var    ; 3:10      Z_8_con Z_8_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw +0 16-bit; 
                        ;           no_segment(10)
    push HL             ; 1:11      0x3344 , 0x3344 , ... 0x3344 ,   default version
    ld   HL, 0x3344     ; 3:10      0x3344 ,
    ld  (__create_Z_16_var),HL; 3:16      0x3344 ,
    ld  (__create_Z_16_var+2),HL; 3:16      0x3344 ,
    ld  (__create_Z_16_var+4),HL; 3:16      0x3344 ,
    ld  (__create_Z_16_var+6),HL; 3:16      0x3344 ,
    ld  (__create_Z_16_var+8),HL; 3:16      0x3344 ,
    pop  HL             ; 1:10      0x3344 , 0x3344 , ... 0x3344 ,
                        ;[20:111]   0x3344 , 0x3344 , ... 0x3344 ,
                        ;           no_segment(10)
                        ;[8:42]     Z_16_con Z_16_var   ( -- Z_16_con Z_16_var )
    push DE             ; 1:11      Z_16_con Z_16_var
    push HL             ; 1:11      Z_16_con Z_16_var
    ld   DE, Z_16_con   ; 3:10      Z_16_con Z_16_var
    ld   HL, Z_16_var   ; 3:10      Z_16_con Z_16_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
; dw x, y, z ; Def
                        ;           no_segment(10)
    push HL             ; 1:11      0x99AA , 0x7788 , ... 0x1122 ,   default version
    ld   HL, 0x1122     ; 3:10      0x1122 ,
    ld  (__create_Def_var+8),HL; 3:16      0x1122 ,
    ld   HL, 0x3344     ; 3:10      0x3344 ,
    ld  (__create_Def_var+6),HL; 3:16      0x3344 ,
    ld   HL, 0x5566     ; 3:10      0x5566 ,
    ld  (__create_Def_var+4),HL; 3:16      0x5566 ,
    ld   HL, 0x7788     ; 3:10      0x7788 ,
    ld  (__create_Def_var+2),HL; 3:16      0x7788 ,
    ld   HL, 0x99AA     ; 3:10      0x99AA ,
    ld  (__create_Def_var),HL; 3:16      0x99AA ,
    pop  HL             ; 1:10      0x99AA , 0x7788 , ... 0x1122 ,
                        ;[32:151]   0x99AA , 0x7788 , ... 0x1122 ,
                        ;           no_segment(10)
                        ;[8:42]     Def_con Def_var   ( -- Def_con Def_var )
    push DE             ; 1:11      Def_con Def_var
    push HL             ; 1:11      Def_con Def_var
    ld   DE, Def_con    ; 3:10      Def_con Def_var
    ld   HL, Def_var    ; 3:10      Def_con Def_var
    call Odecti         ; 3:17      call ( p_constant p_variable -- )
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    srl   H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
Odecti:                 ;           ( pconstant pvalue -- )
    pop  BC             ; 1:10      : ret
    ld  (Odecti_end+1),BC; 4:20      : ( ret -- )
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    B, 0x0A       ; 2:7       hex pu.   ( p -- p )  with align 10
    ld    A, B          ; 1:4       hex pu.
    add   A, L          ; 1:4       hex pu.
    ld    L, A          ; 1:4       hex pu.
    dec   L             ; 1:4       hex pu.
    ld    A,(HL)        ; 1:7       hex pu.
    call PRT_HEX_A      ; 3:17      hex pu.
    djnz $-5            ; 2:8/13    hex pu.
    ld    A, '-'        ; 2:7       '-' emit   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      '-' emit   putchar(reg A) with ZX 48K ROM
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    B, 0x0A       ; 2:7       hex pu.   ( p -- p )  with align 10
    ld    A, B          ; 1:4       hex pu.
    add   A, L          ; 1:4       hex pu.
    ld    L, A          ; 1:4       hex pu.
    dec   L             ; 1:4       hex pu.
    ld    A,(HL)        ; 1:7       hex pu.
    call PRT_HEX_A      ; 3:17      hex pu.
    djnz $-5            ; 2:8/13    hex pu.
    ld    A, '='        ; 2:7       '=' emit   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      '=' emit   putchar(reg A) with ZX 48K ROM
    ld    A,(DE)        ; 1:7       p80-   ( p80_2 p80_1 -- p80_2 p80_1 )  [p80_1] = [p80_2] - [p80_1] with align 10
    sub (HL)            ; 1:7       p80-
    ld  (HL),A          ; 1:7       p80-
    ld    C, L          ; 1:4       p80-
    push DE             ; 1:11      p80-
    ld    B, 0x09       ; 2:7       p80-
    inc   L             ; 1:4       p80-
    inc   E             ; 1:4       p80-
    ld    A,(DE)        ; 1:7       p80-
    sbc   A,(HL)        ; 1:7       p80-
    ld  (HL),A          ; 1:7       p80-
    djnz $-5            ; 2:8/13    p80-
    ld    L, C          ; 1:4       p80-
    pop  DE             ; 1:10      p80-
    ld    A, 0x0A       ; 2:7       dec pu.   ( p_num -- p_num ) p_10=_10 && p_temp=_tmp_print
    push DE             ; 1:11      dec pu.
    ex   DE, HL         ; 1:4       dec pu.
    ld   HL, _tmp_print ; 3:10      dec pu.
    ld   BC, _10        ; 3:10      dec pu.
    call PRT_PU         ; 3:17      dec pu.
    ex   DE, HL         ; 1:4       dec pu.
    pop  DE             ; 1:10      dec pu.   [p_num]==first number
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    pop  HL             ; 1:10      2drop   ( b a -- )
    pop  DE             ; 1:10      2drop
Odecti_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;------------------------------------------------------------------------------
;    Input: A
;   Output: 00 .. FF
; Pollutes: A
PRT_HEX_A:              ;           prt_hex_a
    push AF             ; 1:11      prt_hex_a
    rra                 ; 1:4       prt_hex_a
    rra                 ; 1:4       prt_hex_a
    rra                 ; 1:4       prt_hex_a
    rra                 ; 1:4       prt_hex_a
    call PRT_HEX_NIBBLE ; 3:17      prt_hex_a
    pop  AF             ; 1:10      prt_hex_a
    ; fall to prt_hex_nibble
;------------------------------------------------------------------------------
;    Input: A = number, DE = adr
;   Output: (A & $0F) => '0'..'9','A'..'F'
; Pollutes: AF, AF',BC',DE'
PRT_HEX_NIBBLE:         ;           prt_hex_nibble
    or      $F0         ; 2:7       prt_hex_nibble   reset H flag
    daa                 ; 1:4       prt_hex_nibble   $F0..$F9 + $60 => $50..$59; $FA..$FF + $66 => $60..$65
    add   A, $A0        ; 2:7       prt_hex_nibble   $F0..$F9, $100..$105
    adc   A, $40        ; 2:7       prt_hex_nibble   $30..$39, $41..$46   = '0'..'9', 'A'..'F'
    rst   0x10          ; 1:11      prt_hex_nibble   putchar(reg A) with ZX 48K ROM
    ret                 ; 1:10
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
;------------------------------------------------------------------------------
; Input: A = bytes, [BC] = 10, [DE] = number, [HL] = tmp_result
; Output: Print unsigned decimal (if [BC]=10) number in [DE]
; Pollutes: AF', BC', DE', [DE] = first number, [HL] = 0

PRT_PU:                 ;           prt_pu
    exx                 ; 1:4       prt_pu
    ld    E, A          ; 1:4       prt_pu   E' = sizeof(number) in bytes
    exx                 ; 1:4       prt_pu
    or    A             ; 1:4       prt_pu
    ex   DE, HL         ; 1:4       prt_pu
    jr   PRT_PU_ENTR    ; 2:12      prt_pu
PRT_PU_LOOP:            ;           prt_pu
    ex   DE, HL         ; 1:4       prt_pu
    exx                 ; 1:4       prt_pu
    ld    A, E          ; 1:4       prt_pu   E' = sizeof(number) in bytes
    exx                 ; 1:4       prt_pu
    call  c, P256UDM    ; 3:17      prt_pu

    ld    A,(DE)        ; 1:7       prt_pu   DE = number mod [BC]
    scf                 ; 1:4       prt_pu
PRT_PU_ENTR:            ;           prt_pu
    push AF             ; 1:11      prt_pu   print number if carry or end_mark

    push HL             ; 1:11      prt_pu

    scf                 ; 1:4       prt_pu
    ld    A,(BC)        ; 1:7       prt_pu

    exx                 ; 1:4       prt_pu
    ld    B, E          ; 1:4       prt_pu

    exx                 ; 1:4       prt_pu
    sbc   A,(HL)        ; 1:7       prt_pu   10-x-1=9-x
    inc   L             ; 1:4       prt_pu
    jr    c, $+7        ; 2:7/12    prt_pu
    xor   A             ; 1:4       prt_pu
    exx                 ; 1:4       prt_pu
    djnz $-7            ; 2:8/13    prt_pu
    exx                 ; 1:4       prt_pu

    pop  HL             ; 1:10      prt_pu

    jr    c, PRT_PU_LOOP; 2:7/12    prt_pu

    ld    A,(HL)        ; 1:7       prt_pu

    ex   DE, HL         ; 1:4       prt_pu
    call PRT_HEX_NIBBLE ; 3:17      prt_pu
    pop  AF             ; 1:10      prt_pu
    jr    c, $-5        ; 2:7/12    prt_pu
    ret                 ; 1:10      prt_pu

;==============================================================================

; Divide 8..256-bit unsigned value from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
P256UDM:                ;           p256udm
    push BC             ; 1:11      p256udm
    ld    C, A          ; 1:4       p256udm   C = x bytes

    xor   A             ; 1:4       p256udm
    exx                 ; 1:4       p256udm
    ld    B, A          ; 1:4       p256udm   B' = shift_counter = 0
    exx                 ; 1:4       p256udm

    ld    B, C          ; 1:4       p256udm
    ld  (HL),A          ; 1:7       p256udm
    inc   L             ; 1:4       p256udm   px_res = 0
    djnz $-2            ; 2:8/13    p256udm
    ex   AF, AF'        ; 1:4       p256udm
    ld    A, L          ; 1:4       p256udm
    sub   C             ; 1:4       p256udm
    ld    L, A          ; 1:4       p256udm   return to original value

    ex  (SP),HL         ; 1:19      p256udm

    ld    A, L          ; 1:4       p256udm   A' = original value L
    ex   AF, AF'        ; 1:4       p256udm

    ld    B, C          ; 1:4       p256udm
    or  (HL)            ; 1:7       p256udm
    inc   L             ; 1:4       p256udm
    djnz $-2            ; 2:8/13    p256udm   px_3 == 0?

    or    A             ; 1:4       p256udm
    jr    z, P256UDM_E  ; 2:7/12    p256udm   exit with div 0

    ex   AF, AF'        ; 1:4       p256udm
    ld    L, A          ; 1:4       p256udm   return to original value
    ex   AF, AF'        ; 1:4       p256udm
    ld    B, C          ; 1:4       p256udm
    exx                 ; 1:4       p256udm
    inc   B             ; 1:4       p256udm   shift_counter++
    exx                 ; 1:4       p256udm

    rl  (HL)            ; 2:15      p256udm
    inc   L             ; 1:4       p256udm
    djnz $-3            ; 2:8/13    p256udm   px_3 *= 2

    jr   nc, $-12       ; 2:7/12    p256udm   px_3 overflow?

P256UDM_L:              ;           p256udm
    ld    B, C          ; 1:4       p256udm   L = orig L + $1
    dec   L             ; 1:4       p256udm
    rr  (HL)            ; 2:15      p256udm
    djnz $-3            ; 2:8/13    p256udm   px_3 >>= 1

    ex  (SP),HL         ; 1:19      p256udm
    ld    A, L          ; 1:4       p256udm
    ld    B, C          ; 1:4       p256udm
    rl  (HL)            ; 2:15      p256udm
    inc   L             ; 1:4       p256udm
    djnz $-3            ; 2:8/13    p256udm   result *= 2
    ld    L, A          ; 1:4       p256udm   return to original value
    ex  (SP),HL         ; 1:19      p256udm

    push  DE            ; 1:11      p256udm
    ld    B, C          ; 1:4       p256udm
    ld    A,(DE)        ; 1:7       p256udm
    sbc   A,(HL)        ; 1:7       p256udm
    inc   L             ; 1:4       p256udm
    inc   E             ; 1:4       p256udm
    djnz $-4            ; 2:8/13    p256udm   (px_mod < px_3)?
    pop  DE             ; 1:10      p256udm

    jr    c, P256UDM_N  ; 2:7/12    p256udm

    ex  (SP),HL         ; 1:19      p256udm
    inc (HL)            ; 1:11      p256udm   result += 1
    ex  (SP),HL         ; 1:19      p256udm

    push DE             ; 1:11      p256udm
    ex   AF, AF'        ; 1:4       p256udm
    ld    L, A          ; 1:4       p256udm   return to original value
    ex   AF, AF'        ; 1:4       p256udm
    ld    B, C          ; 1:4       p256udm
    ld    A,(DE)        ; 1:7       p256udm
    sbc   A,(HL)        ; 1:7       p256udm
    ld  (DE),A          ; 1:7       p256udm
    inc   L             ; 1:4       p256udm
    inc   E             ; 1:4       p256udm
    djnz $-5            ; 2:8/13    p256udm   px_mod -= px_3
    pop  DE             ; 1:10      p256udm
P256UDM_N:              ;           p256udm
    or    A             ; 1:4       p256udm
    exx                 ; 1:4       p256udm
    dec   B             ; 1:4       p256udm
    exx                 ; 1:4       p256udm
    jr   nz, P256UDM_L  ; 2:7/12    p256udm

P256UDM_E:              ;           p256udm
    ex   AF, AF'        ; 1:4       p256udm
    ld    L, A          ; 1:4       p256udm   return to original value
    ex  (SP),HL         ; 1:19      p256udm
    pop  BC             ; 1:10      p256udm
    ret                 ; 1:10      p256udm
;------------------------------------------------------------------------------
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero + 1
    rst   0x10          ; 1:11      print_string_z   putchar(reg A) with ZX 48K ROM
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    inc  BC             ; 1:6       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z
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
string101:
    db "Depth: ", 0x00
size101              EQU $ - string101


VARIABLE_SECTION:

; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
_10:                    ; = 10
    dw 0x000a
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
_tmp_print:             ; = 0
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_A_lo_var:      ;
    dw 0x3305           ;           0x3305 comma
    dw 0x3304           ;           0x3304 comma
    dw 0x3303           ;           0x3303 comma
    dw 0x3302           ;           0x3302 comma
    dw 0x3301           ;           0x3301 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
A_lo_con:               ; = 0x33013302330333043305
    dw 0x3305
    dw 0x3304
    dw 0x3303
    dw 0x3302
    dw 0x3301
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_A_hi_var:      ;
    dw 0x0533           ;           0x0533 comma
    dw 0x0433           ;           0x0433 comma
    dw 0x0333           ;           0x0333 comma
    dw 0x0233           ;           0x0233 comma
    dw 0x0133           ;           0x0133 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
A_hi_con:               ; = 0x01330233033304330533
    dw 0x0533
    dw 0x0433
    dw 0x0333
    dw 0x0233
    dw 0x0133
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_B_lo_var:      ;
    dw 0x3301           ;           0x3301 comma
    dw 0x3302           ;           0x3302 comma
    dw 0x3303           ;           0x3303 comma
    dw 0x3304           ;           0x3304 comma
    dw 0x3305           ;           0x3305 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
B_lo_con:               ; = 0x33053304330333023301
    dw 0x3301
    dw 0x3302
    dw 0x3303
    dw 0x3304
    dw 0x3305
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_B_hi_var:      ;
    dw 0x0133           ;           0x0133 comma
    dw 0x0233           ;           0x0233 comma
    dw 0x0333           ;           0x0333 comma
    dw 0x0433           ;           0x0433 comma
    dw 0x0533           ;           0x0533 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
B_hi_con:               ; = 0x05330433033302330133
    dw 0x0133
    dw 0x0233
    dw 0x0333
    dw 0x0433
    dw 0x0533
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_C_lo_var:      ;
    dw 0x330A           ;           0x330A comma
    dw 0x3308           ;           0x3308 comma
    dw 0x3306           ;           0x3306 comma
    dw 0x3304           ;           0x3304 comma
    dw 0x3302           ;           0x3302 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
C_lo_con:               ; = 0x3302330433063308330A
    dw 0x330A
    dw 0x3308
    dw 0x3306
    dw 0x3304
    dw 0x3302
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_C_hi_var:      ;
    dw 0x0A33           ;           0x0A33 comma
    dw 0x0833           ;           0x0833 comma
    dw 0x0633           ;           0x0633 comma
    dw 0x0433           ;           0x0433 comma
    dw 0x0233           ;           0x0233 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
C_hi_con:               ; = 0x02330433063308330A33
    dw 0x0A33
    dw 0x0833
    dw 0x0633
    dw 0x0433
    dw 0x0233
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_D_lo_var:      ;
    dw 0x3302           ;           0x3302 comma
    dw 0x3304           ;           0x3304 comma
    dw 0x3306           ;           0x3306 comma
    dw 0x3308           ;           0x3308 comma
    dw 0x330A           ;           0x330A comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
D_lo_con:               ; = 0x330A3308330633043302
    dw 0x3302
    dw 0x3304
    dw 0x3306
    dw 0x3308
    dw 0x330A
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_D_hi_var:      ;
    dw 0x0233           ;           0x0233 comma
    dw 0x0433           ;           0x0433 comma
    dw 0x0633           ;           0x0633 comma
    dw 0x0833           ;           0x0833 comma
    dw 0x0A33           ;           0x0A33 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
D_hi_con:               ; = 0x0A330833063304330233
    dw 0x0233
    dw 0x0433
    dw 0x0633
    dw 0x0833
    dw 0x0A33
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_E_lo_var:      ;
    dw 0x3309           ;           0x3309 comma
    dw 0x3307           ;           0x3307 comma
    dw 0x3305           ;           0x3305 comma
    dw 0x3303           ;           0x3303 comma
    dw 0x3301           ;           0x3301 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
E_lo_con:               ; = 0x33013303330533073309
    dw 0x3309
    dw 0x3307
    dw 0x3305
    dw 0x3303
    dw 0x3301
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_E_hi_var:      ;
    dw 0x0933           ;           0x0933 comma
    dw 0x0733           ;           0x0733 comma
    dw 0x0533           ;           0x0533 comma
    dw 0x0333           ;           0x0333 comma
    dw 0x0133           ;           0x0133 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
E_hi_con:               ; = 0x01330333053307330933
    dw 0x0933
    dw 0x0733
    dw 0x0533
    dw 0x0333
    dw 0x0133
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_F_lo_var:      ;
    dw 0x3301           ;           0x3301 comma
    dw 0x3303           ;           0x3303 comma
    dw 0x3305           ;           0x3305 comma
    dw 0x3307           ;           0x3307 comma
    dw 0x3309           ;           0x3309 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
F_lo_con:               ; = 0x33093307330533033301
    dw 0x3301
    dw 0x3303
    dw 0x3305
    dw 0x3307
    dw 0x3309
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_F_hi_var:      ;
    dw 0x0133           ;           0x0133 comma
    dw 0x0333           ;           0x0333 comma
    dw 0x0533           ;           0x0533 comma
    dw 0x0733           ;           0x0733 comma
    dw 0x0933           ;           0x0933 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
F_hi_con:               ; = 0x09330733053303330133
    dw 0x0133
    dw 0x0333
    dw 0x0533
    dw 0x0733
    dw 0x0933
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_G_lo_var:      ;
    dw 0x3304           ;           0x3304 comma
    dw 0x3303           ;           0x3303 comma
    dw 0x3302           ;           0x3302 comma
    dw 0x3301           ;           0x3301 comma
    dw 0x3300           ;           0x3300 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
G_lo_con:               ; = 0x33003301330233033304
    dw 0x3304
    dw 0x3303
    dw 0x3302
    dw 0x3301
    dw 0x3300
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_G_hi_var:      ;
    dw 0x0433           ;           0x0433 comma
    dw 0x0333           ;           0x0333 comma
    dw 0x0233           ;           0x0233 comma
    dw 0x0133           ;           0x0133 comma
    dw 0x0033           ;           0x0033 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
G_hi_con:               ; = 0x00330133023303330433
    dw 0x0433
    dw 0x0333
    dw 0x0233
    dw 0x0133
    dw 0x0033
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_H_lo_var:      ;
    dw 0x3300           ;           0x3300 comma
    dw 0x33FF           ;           0x33FF comma
    dw 0x33FE           ;           0x33FE comma
    dw 0x33FD           ;           0x33FD comma
    dw 0x33FC           ;           0x33FC comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
H_lo_con:               ; = 0x33FC33FD33FE33FF3300
    dw 0x3300
    dw 0x33FF
    dw 0x33FE
    dw 0x33FD
    dw 0x33FC
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_H_hi_var:      ;
    dw 0x0033           ;           0x0033 comma
    dw 0xFF33           ;           0xFF33 comma
    dw 0xFE33           ;           0xFE33 comma
    dw 0xFD33           ;           0xFD33 comma
    dw 0xFC33           ;           0xFC33 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
H_hi_con:               ; = 0xFC33FD33FE33FF330033
    dw 0x0033
    dw 0xFF33
    dw 0xFE33
    dw 0xFD33
    dw 0xFC33
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_I_lo_var:      ;
    dw 0x33FC           ;           0x33FC comma
    dw 0x33FD           ;           0x33FD comma
    dw 0x33FE           ;           0x33FE comma
    dw 0x33FF           ;           0x33FF comma
    dw 0x3300           ;           0x3300 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
I_lo_con:               ; = 0x330033FF33FE33FD33FC
    dw 0x33FC
    dw 0x33FD
    dw 0x33FE
    dw 0x33FF
    dw 0x3300
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_I_hi_var:      ;
    dw 0xFC33           ;           0xFC33 comma
    dw 0xFD33           ;           0xFD33 comma
    dw 0xFE33           ;           0xFE33 comma
    dw 0xFF33           ;           0xFF33 comma
    dw 0x0033           ;           0x0033 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
I_hi_con:               ; = 0x0033FF33FE33FD33FC33
    dw 0xFC33
    dw 0xFD33
    dw 0xFE33
    dw 0xFF33
    dw 0x0033
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_J_lo_var:      ;
    dw 0x3300           ;           0x3300 comma
    dw 0x3301           ;           0x3301 comma
    dw 0x3302           ;           0x3302 comma
    dw 0x3303           ;           0x3303 comma
    dw 0x3304           ;           0x3304 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
J_lo_con:               ; = 0x33043303330233013300
    dw 0x3300
    dw 0x3301
    dw 0x3302
    dw 0x3303
    dw 0x3304
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_J_hi_var:      ;
    dw 0x0033           ;           0x0033 comma
    dw 0x0133           ;           0x0133 comma
    dw 0x0233           ;           0x0233 comma
    dw 0x0333           ;           0x0333 comma
    dw 0x0433           ;           0x0433 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
J_hi_con:               ; = 0x04330333023301330033
    dw 0x0033
    dw 0x0133
    dw 0x0233
    dw 0x0333
    dw 0x0433
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_K_lo_var:      ;
    dw 0x330A           ;           0x330A comma
    dw 0x3309           ;           0x3309 comma
    dw 0x3308           ;           0x3308 comma
    dw 0x3307           ;           0x3307 comma
    dw 0x3306           ;           0x3306 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
K_lo_con:               ; = 0x3306330733083309330A
    dw 0x330A
    dw 0x3309
    dw 0x3308
    dw 0x3307
    dw 0x3306
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_K_hi_var:      ;
    dw 0x0A33           ;           0x0A33 comma
    dw 0x0933           ;           0x0933 comma
    dw 0x0833           ;           0x0833 comma
    dw 0x0733           ;           0x0733 comma
    dw 0x0633           ;           0x0633 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
K_hi_con:               ; = 0x06330733083309330A33
    dw 0x0A33
    dw 0x0933
    dw 0x0833
    dw 0x0733
    dw 0x0633
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_L_lo_var:      ;
    dw 0x3306           ;           0x3306 comma
    dw 0x3307           ;           0x3307 comma
    dw 0x3308           ;           0x3308 comma
    dw 0x3309           ;           0x3309 comma
    dw 0x330A           ;           0x330A comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
L_lo_con:               ; = 0x330A3309330833073306
    dw 0x3306
    dw 0x3307
    dw 0x3308
    dw 0x3309
    dw 0x330A
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_L_hi_var:      ;
    dw 0x0633           ;           0x0633 comma
    dw 0x0733           ;           0x0733 comma
    dw 0x0833           ;           0x0833 comma
    dw 0x0933           ;           0x0933 comma
    dw 0x0A33           ;           0x0A33 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
L_hi_con:               ; = 0x0A330933083307330633
    dw 0x0633
    dw 0x0733
    dw 0x0833
    dw 0x0933
    dw 0x0A33
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_M_lo_var:      ;
    dw 0x330C           ;           0x330C comma
    dw 0x3309           ;           0x3309 comma
    dw 0x3306           ;           0x3306 comma
    dw 0x3303           ;           0x3303 comma
    dw 0x3300           ;           0x3300 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
M_lo_con:               ; = 0x3300330333063309330C
    dw 0x330C
    dw 0x3309
    dw 0x3306
    dw 0x3303
    dw 0x3300
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_M_hi_var:      ;
    dw 0x0C33           ;           0x0C33 comma
    dw 0x0933           ;           0x0933 comma
    dw 0x0633           ;           0x0633 comma
    dw 0x0333           ;           0x0333 comma
    dw 0x0033           ;           0x0033 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
M_hi_con:               ; = 0x00330333063309330C33
    dw 0x0C33
    dw 0x0933
    dw 0x0633
    dw 0x0333
    dw 0x0033
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_N_lo_var:      ;
    dw 0x3300           ;           0x3300 comma
    dw 0x3303           ;           0x3303 comma
    dw 0x3306           ;           0x3306 comma
    dw 0x3309           ;           0x3309 comma
    dw 0x330C           ;           0x330C comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
N_lo_con:               ; = 0x330C3309330633033300
    dw 0x3300
    dw 0x3303
    dw 0x3306
    dw 0x3309
    dw 0x330C
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_N_hi_var:      ;
    dw 0x0033           ;           0x0033 comma
    dw 0x0333           ;           0x0333 comma
    dw 0x0633           ;           0x0633 comma
    dw 0x0933           ;           0x0933 comma
    dw 0x0C33           ;           0x0C33 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
N_hi_con:               ; = 0x0C330933063303330033
    dw 0x0033
    dw 0x0333
    dw 0x0633
    dw 0x0933
    dw 0x0C33
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_O_lo_var:      ;
    dw 0x330F           ;           0x330F comma
    dw 0x330C           ;           0x330C comma
    dw 0x3309           ;           0x3309 comma
    dw 0x3306           ;           0x3306 comma
    dw 0x3303           ;           0x3303 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
O_lo_con:               ; = 0x330333063309330C330F
    dw 0x330F
    dw 0x330C
    dw 0x3309
    dw 0x3306
    dw 0x3303
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_O_hi_var:      ;
    dw 0x0F33           ;           0x0F33 comma
    dw 0x0C33           ;           0x0C33 comma
    dw 0x0933           ;           0x0933 comma
    dw 0x0633           ;           0x0633 comma
    dw 0x0333           ;           0x0333 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
O_hi_con:               ; = 0x0333063309330C330F33
    dw 0x0F33
    dw 0x0C33
    dw 0x0933
    dw 0x0633
    dw 0x0333
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_P_lo_var:      ;
    dw 0x3303           ;           0x3303 comma
    dw 0x3306           ;           0x3306 comma
    dw 0x3309           ;           0x3309 comma
    dw 0x330C           ;           0x330C comma
    dw 0x330F           ;           0x330F comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
P_lo_con:               ; = 0x330F330C330933063303
    dw 0x3303
    dw 0x3306
    dw 0x3309
    dw 0x330C
    dw 0x330F
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_P_hi_var:      ;
    dw 0x0333           ;           0x0333 comma
    dw 0x0633           ;           0x0633 comma
    dw 0x0933           ;           0x0933 comma
    dw 0x0C33           ;           0x0C33 comma
    dw 0x0F33           ;           0x0F33 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
P_hi_con:               ; = 0x0F330C33093306330333
    dw 0x0333
    dw 0x0633
    dw 0x0933
    dw 0x0C33
    dw 0x0F33
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_Q_lo_var:      ;
    dw 0x3306           ;           0x3306 comma
    dw 0x3309           ;           0x3309 comma
    dw 0x330C           ;           0x330C comma
    dw 0x330F           ;           0x330F comma
    dw 0x3312           ;           0x3312 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
Q_lo_con:               ; = 0x3312330F330C33093306
    dw 0x3306
    dw 0x3309
    dw 0x330C
    dw 0x330F
    dw 0x3312
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_Q_hi_var:      ;
    dw 0x0633           ;           0x0633 comma
    dw 0x0933           ;           0x0933 comma
    dw 0x0C33           ;           0x0C33 comma
    dw 0x0F33           ;           0x0F33 comma
    dw 0x1233           ;           0x1233 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
Q_hi_con:               ; = 0x12330F330C3309330633
    dw 0x0633
    dw 0x0933
    dw 0x0C33
    dw 0x0F33
    dw 0x1233
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_R_lo_var:      ;
    dw 0x33FE           ;           0x33FE comma
    dw 0x33FF           ;           0x33FF comma
    dw 0x3400           ;           0x3400 comma
    dw 0x3401           ;           0x3401 comma
    dw 0x3402           ;           0x3402 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
R_lo_con:               ; = 0x34023401340033FF33FE
    dw 0x33FE
    dw 0x33FF
    dw 0x3400
    dw 0x3401
    dw 0x3402
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_S_lo_var:      ;
    dw 0x3402           ;           0x3402 comma
    dw 0x3401           ;           0x3401 comma
    dw 0x3400           ;           0x3400 comma
    dw 0x33FF           ;           0x33FF comma
    dw 0x33FE           ;           0x33FE comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
S_lo_con:               ; = 0x33FE33FF340034013402
    dw 0x3402
    dw 0x3401
    dw 0x3400
    dw 0x33FF
    dw 0x33FE
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_T_lo_var:      ;
    dw 0x3360           ;           0x3360 comma
    dw 0x33C0           ;           0x33C0 comma
    dw 0x3380           ;           0x3380 comma
    dw 0x3300           ;           0x3300 comma
    dw 0x3300           ;           0x3300 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
T_lo_con:               ; = 0x33003300338033C03360
    dw 0x3360
    dw 0x33C0
    dw 0x3380
    dw 0x3300
    dw 0x3300
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_T_hi_var:      ;
    dw 0x0233           ;           0x0233 comma
    dw 0x0433           ;           0x0433 comma
    dw 0x0833           ;           0x0833 comma
    dw 0x1033           ;           0x1033 comma
    dw 0x2033           ;           0x2033 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
T_hi_con:               ; = 0x20331033083304330233
    dw 0x0233
    dw 0x0433
    dw 0x0833
    dw 0x1033
    dw 0x2033
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_T_16_var:      ;
    dw 0x0283           ;           0x0283 comma
    dw 0x0506           ;           0x0506 comma
    dw 0x0A0C           ;           0x0A0C comma
    dw 0x1418           ;           0x1418 comma
    dw 0x2830           ;           0x2830 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
T_16_con:               ; = 0x283014180A0C05060283
    dw 0x0283
    dw 0x0506
    dw 0x0A0C
    dw 0x1418
    dw 0x2830
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_Z_8_var:       ;
    dw 0x3333           ;           0x3333 comma
    dw 0x3333           ;           0x3333 comma
    dw 0x3333           ;           0x3333 comma
    dw 0x3333           ;           0x3333 comma
    dw 0x3333           ;           0x3333 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
Z_8_con:                ; = 0x33333333333333333333
    dw 0x3333
    dw 0x3333
    dw 0x3333
    dw 0x3333
    dw 0x3333
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_Z_16_var:      ;
    dw 0x3344           ;           0x3344 comma
    dw 0x3344           ;           0x3344 comma
    dw 0x3344           ;           0x3344 comma
    dw 0x3344           ;           0x3344 comma
    dw 0x3344           ;           0x3344 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
Z_16_con:               ; = 0x33443344334433443344
    dw 0x3344
    dw 0x3344
    dw 0x3344
    dw 0x3344
    dw 0x3344
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create_Def_var:       ;
    dw 0x99AA           ;           0x99AA comma
    dw 0x7788           ;           0x7788 comma
    dw 0x5566           ;           0x5566 comma
    dw 0x3344           ;           0x3344 comma
    dw 0x1122           ;           0x1122 comma
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 10 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
Def_con:                ; = 0x112233445566778899AA
    dw 0x99AA
    dw 0x7788
    dw 0x5566
    dw 0x3344
    dw 0x1122

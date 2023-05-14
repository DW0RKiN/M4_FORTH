include(`../M4/FIRST.M4')dnl
ORG 0x8000
INIT(60000)
define({USE_FONT_5x8})


CONSTANT(BYTES_SIZE,10)
PCONSTANT(BYTES_SIZE,10,_10)
PCONSTANT(BYTES_SIZE,0, _tmp_print)

__ASM({; dw x..-1..1 ; A})
PPUSH_VALUE(BYTES_SIZE,0x33013302330333043305,A_lo_var)
  PCONSTANT(BYTES_SIZE,0x33013302330333043305,A_lo_con)
  PUSH(A_lo_con,A_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x01330233033304330533,A_hi_var)
  PCONSTANT(BYTES_SIZE,0x01330233033304330533,A_hi_con)
  PUSH(A_hi_con,A_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw 1..+1..x ; B})
PPUSH_VALUE(BYTES_SIZE,0x33053304330333023301,B_lo_var)
  PCONSTANT(BYTES_SIZE,0x33053304330333023301,B_lo_con)
  PUSH(B_lo_con,B_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x05330433033302330133,B_hi_var)
  PCONSTANT(BYTES_SIZE,0x05330433033302330133,B_hi_con)
  PUSH(B_hi_con,B_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw x..-2..2 ; C})
PPUSH_VALUE(BYTES_SIZE,0x3302330433063308330A,C_lo_var)
  PCONSTANT(BYTES_SIZE,0x3302330433063308330A,C_lo_con)
  PUSH(C_lo_con,C_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x02330433063308330A33,C_hi_var)
  PCONSTANT(BYTES_SIZE,0x02330433063308330A33,C_hi_con)
  PUSH(C_hi_con,C_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw 2..+2..x ; D})
PPUSH_VALUE(BYTES_SIZE,0x330A3308330633043302,D_lo_var)
  PCONSTANT(BYTES_SIZE,0x330A3308330633043302,D_lo_con)
  PUSH(D_lo_con,D_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x0A330833063304330233,D_hi_var)
  PCONSTANT(BYTES_SIZE,0x0A330833063304330233,D_hi_con)
  PUSH(D_hi_con,D_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw x..-2..1 ; E})
PPUSH_VALUE(BYTES_SIZE,0x33013303330533073309,E_lo_var)
  PCONSTANT(BYTES_SIZE,0x33013303330533073309,E_lo_con)
  PUSH(E_lo_con,E_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x01330333053307330933,E_hi_var)
  PCONSTANT(BYTES_SIZE,0x01330333053307330933,E_hi_con)
  PUSH(E_hi_con,E_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw 1..+2..x ; F})
PPUSH_VALUE(BYTES_SIZE,0x33093307330533033301,F_lo_var)
  PCONSTANT(BYTES_SIZE,0x33093307330533033301,F_lo_con)
  PUSH(F_lo_con,F_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x09330733053303330133,F_hi_var)
  PCONSTANT(BYTES_SIZE,0x09330733053303330133,F_hi_con)
  PUSH(F_hi_con,F_hi_var) CALL(Odecti,( p_constant p_variable -- ))
  
__ASM({; dw x..-1..0 ; G})
PPUSH_VALUE(BYTES_SIZE,0x33003301330233033304,G_lo_var)
  PCONSTANT(BYTES_SIZE,0x33003301330233033304,G_lo_con)
  PUSH(G_lo_con,G_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x00330133023303330433,G_hi_var)
  PCONSTANT(BYTES_SIZE,0x00330133023303330433,G_hi_con)
  PUSH(G_hi_con,G_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw 0..-1..x ; H})
PPUSH_VALUE(BYTES_SIZE,0x33FC33FD33FE33FF3300,H_lo_var)
  PCONSTANT(BYTES_SIZE,0x33FC33FD33FE33FF3300,H_lo_con)
  PUSH(H_lo_con,H_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0xFC33FD33FE33FF330033,H_hi_var)
  PCONSTANT(BYTES_SIZE,0xFC33FD33FE33FF330033,H_hi_con)
  PUSH(H_hi_con,H_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw x..+1..0 ; I})
PPUSH_VALUE(BYTES_SIZE,0x330033FF33FE33FD33FC,I_lo_var)
  PCONSTANT(BYTES_SIZE,0x330033FF33FE33FD33FC,I_lo_con)
  PUSH(I_lo_con,I_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x0033FF33FE33FD33FC33,I_hi_var)
  PCONSTANT(BYTES_SIZE,0x0033FF33FE33FD33FC33,I_hi_con)
  PUSH(I_hi_con,I_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw 0..+1..x ; J})
PPUSH_VALUE(BYTES_SIZE,0x33043303330233013300,J_lo_var)
  PCONSTANT(BYTES_SIZE,0x33043303330233013300,J_lo_con)
  PUSH(J_lo_con,J_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x04330333023301330033,J_hi_var)
  PCONSTANT(BYTES_SIZE,0x04330333023301330033,J_hi_con)
  PUSH(J_hi_con,J_hi_var) CALL(Odecti,( p_constant p_variable -- ))
  
__ASM({; dw x..-1..x ; K})
PPUSH_VALUE(BYTES_SIZE,0x3306330733083309330A,K_lo_var)
  PCONSTANT(BYTES_SIZE,0x3306330733083309330A,K_lo_con)
  PUSH(K_lo_con,K_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x06330733083309330A33,K_hi_var)
  PCONSTANT(BYTES_SIZE,0x06330733083309330A33,K_hi_con)
  PUSH(K_hi_con,K_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw x..+1..x ; L})
PPUSH_VALUE(BYTES_SIZE,0x330A3309330833073306,L_lo_var)
  PCONSTANT(BYTES_SIZE,0x330A3309330833073306,L_lo_con)
  PUSH(L_lo_con,L_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x0A330933083307330633,L_hi_var)
  PCONSTANT(BYTES_SIZE,0x0A330933083307330633,L_hi_con)
  PUSH(L_hi_con,L_hi_var) CALL(Odecti,( p_constant p_variable -- ))
   
__ASM({; dw n*x..+-x..0 ; M})
PPUSH_VALUE(BYTES_SIZE,0x3300330333063309330C,M_lo_var)
  PCONSTANT(BYTES_SIZE,0x3300330333063309330C,M_lo_con)
  PUSH(M_lo_con,M_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x00330333063309330C33,M_hi_var)
  PCONSTANT(BYTES_SIZE,0x00330333063309330C33,M_hi_con)
  PUSH(M_hi_con,M_hi_var) CALL(Odecti,( p_constant p_variable -- ))

__ASM({; dw 0..+-x..n*x ; N})
PPUSH_VALUE(BYTES_SIZE,0x330C3309330633033300,N_lo_var)
  PCONSTANT(BYTES_SIZE,0x330C3309330633033300,N_lo_con)
  PUSH(N_lo_con,N_lo_var) CALL(Odecti,( p_constant p_variable -- ))
  
PPUSH_VALUE(BYTES_SIZE,0x0C330933063303330033,N_hi_var)
  PCONSTANT(BYTES_SIZE,0x0C330933063303330033,N_hi_con)
  PUSH(N_hi_con,N_hi_var) CALL(Odecti,( p_constant p_variable -- ))
  
  
  

PRINT_Z({"Depth: "}) DEPTH UDOT CR

STOP


COLON(Odecti,( pconstant pvalue -- ))
   SWAP HEX_PUDOT(BYTES_SIZE) PUSH('-') EMIT
   SWAP HEX_PUDOT(BYTES_SIZE) PUSH('=') EMIT 
   PSUB(BYTES_SIZE) DEC_PUDOT(BYTES_SIZE,_10,_tmp_print) CR _2DROP
SEMICOLON

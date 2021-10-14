define({__},{})dnl
dnl ( -- )
dnl Save shadow reg.
define(INIT,{
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, ifelse($1,{},{60000
    .warning "Missing value for return address stack. The init() macro has no parameter!"},{format({%-11s},$1); 3:10      Init Return address stack}){}dnl
__{}ifelse(eval(($1+0) & 1),{1},{
    .error "Return address stack must be at an odd address!"})
    exx                 ; 1:4})dnl
dnl
dnl ( -- )
dnl Load shadow reg.
define(STOP,{
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====})dnl
dnl
dnl
dnl
dnl ( ? ? ? -- )
dnl Fix back stack and register. Return to Basic.
define({BYE},{
    jp   Stop           ; 3:10      bye})dnl
dnl
dnl
define({CONSTANT},{ifelse($#,{2},{
format({%-20s},$1) EQU $2
define({$1},{$2})},{
.error constant: No parameter or redundant parameter!})})dnl
dnl
dnl
define({ALL_VARIABLE},{})dnl
dnl
dnl
define({CVARIABLE},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}ifelse($1,{},{.error cvariable: Missing parameter with variable name!}dnl
__{},$#,{1},{$1: db 0x00{}}dnl
__{},{$1: db $2{}})dnl
})})dnl
dnl
dnl
define({DVARIABLE},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}ifelse($1,{},{.error dvariable: Missing parameter with variable name!}dnl
__{},$#,{1},{$1:
__{}  dw 0x0000
__{}  dw 0x0000{}}dnl
__{},{$1: 
__{}  dw eval(($2) & 0x0ffff)
__{}  dw eval(($2) / 0x10000)})dnl
})})dnl
dnl
dnl
define({VARIABLE},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}ifelse($1,{},{.error variable: Missing parameter with variable name!}dnl
__{},$#,{1},{$1: dw 0x0000{}}dnl
__{},{$1: dw $2{}})dnl
})})dnl
dnl
dnl
dnl ## Memory access
dnl
dnl C@
dnl ( addr -- char )
dnl fetch 8-bit char from addr
define({CFETCH},{
    ld    L, (HL)       ; 1:7       C@ cfetch
    ld    H, 0x00       ; 2:7       C@ cfetch})dnl
dnl
dnl
dnl @
dnl ( addr -- x )
dnl fetch 16-bit number from addr
define({FETCH},{
    ld    A, (HL)       ; 1:7       @ fetch
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch})dnl
dnl
dnl
dnl 2@
dnl ( addr -- hi lo )
dnl fetch 32-bit number from addr
define({_2FETCH},{
                        ;[10:65]    2@ _2fetch
    push DE             ; 1:11      2@ _2fetch
    ld    E, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    D, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    A, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    H, (HL)       ; 1:7       2@ _2fetch
    ld    L, A          ; 1:4       2@ _2fetch
    ex   DE, HL         ; 1:4       2@ _2fetch ( adr -- lo hi )})dnl
dnl
dnl
dnl addr C@
dnl ( -- x )
dnl push_cfetch(addr), load 8-bit char from addr
define({PUSH_CFETCH},{
    push DE             ; 1:11      $1 @ push($1) cfetch
    ex   DE, HL         ; 1:4       $1 @ push($1) cfetch
    ld   HL,format({%-12s},($1)); 3:16      $1 @ push($1) cfetch
    ld    H, 0x00       ; 2:7       $1 @ push($1) cfetch})dnl
dnl
dnl
dnl addr @
dnl ( -- x )
dnl push_fetch(addr), load 16-bit number from addr
define({PUSH_FETCH},{
    push DE             ; 1:11      $1 @ push($1) fetch
    ex   DE, HL         ; 1:4       $1 @ push($1) fetch
    ld   HL,format({%-12s},($1)); 3:16      $1 @ push($1) fetch})dnl
dnl
dnl
dnl addr 2@
dnl ( -- hi lo )
dnl push_2fetch(addr), load 32-bit number from addr
define({PUSH_2FETCH},{
    push DE             ; 1:11      $1 2@ push_2fetch($1)
    push HL             ; 1:11      $1 2@ push_2fetch($1){}ifelse(eval(($1)),{},{
    ld   DE,format({%-12s},{(2+$1)}); 4:20      $1 2! push_2fetch($1) hi},{
    ld   DE,format({%-12s},(eval($1+2))); 4:20      $1 2@ push_2fetch($1) hi})
    ld   HL,format({%-12s},($1)); 3:16      $1 2@ push_2fetch($1) lo})dnl
dnl
dnl
dnl C!
dnl ( char addr -- )
dnl store 8-bit char at addr
define({CSTORE},{
    ld  (HL),E          ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore})dnl
dnl
dnl
dnl !
dnl ( x addr -- )
dnl store 16-bit number at addr
define({STORE},{
                        ;[5:40]     ! store
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store})dnl
dnl
dnl
dnl 2!
dnl ( hi lo addr -- )
dnl store 32-bit number at addr
define({_2STORE},{
    ld  (HL),E          ; 1:7       2! _2store
    inc  HL             ; 1:6       2! _2store
    ld  (HL),D          ; 1:7       2! _2store
    inc  HL             ; 1:6       2! _2store
    pop  DE             ; 1:10      2! _2store
    ld  (HL),E          ; 1:7       2! _2store
    inc  HL             ; 1:6       2! _2store
    ld  (HL),D          ; 1:7       2! _2store
    pop  HL             ; 1:10      2! _2store
    pop  DE             ; 1:10      2! _2store})dnl
dnl
dnl
dnl addr C!
dnl ( char -- )
dnl store(addr) store 8-bit char at addr
define({PUSH_CSTORE},{
    ld    A, L          ; 1:4       $1 C! push($1) cstore
    ld   format({%-15s},($1){,} A); 3:13      $1 C! push($1) cstore
    ex   DE, HL         ; 1:4       $1 C! push($1) cstore
    pop  DE             ; 1:10      $1 C! push($1) cstore})dnl
dnl
dnl
dnl addr !
dnl ( x -- )
dnl store(addr) store 16-bit number at addr
define({PUSH_STORE},{
    ld   format({%-15s},($1){,} HL); 3:16      $1 ! push($1) store
    ex   DE, HL         ; 1:4       $1 ! push($1) store
    pop  DE             ; 1:10      $1 ! push($1) store})dnl
dnl
dnl
dnl addr 2!
dnl ( hi lo -- )
dnl store(addr) store 32-bit number at addr
define({PUSH_2STORE},{
    ld   format({%-15s},($1){,} HL); 3:16      $1 2! push_2store($1) lo{}ifelse(eval(($1)),{},{
    ld   format({%-15s},{(2+$1), DE}); 4:20      $1 2! push_2store($1) hi},{
    ld   (format({%-14s},eval(($1)+2){),} DE); 4:20      $1 2! push_2store($1) hi})
    pop  HL             ; 1:10      $1 2! push_2store($1)
    pop  DE             ; 1:10      $1 2! push_2store($1)})dnl
dnl
dnl
dnl char addr C!
dnl ( -- )
dnl store(addr) store 8-bit number at addr
define({PUSH2_CSTORE},{
    ld    A, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:13},{2:7 })      push2_cstore($1,$2)
    ld   format({%-15s},($2){,} A); 3:13      push2_cstore($1,$2)})dnl
dnl
dnl
dnl x addr !
dnl ( -- )
dnl store(addr) store 16-bit number at addr
define({PUSH2_STORE},{
    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      push2_store($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_store($1,$2)})dnl
dnl
dnl
dnl lo addr 2!
dnl ( hi -- )
dnl store(addr) store 32-bit number at addr
define({PUSH2_2STORE},{{}ifelse(eval(($1)),{},{
    ld   format({%-15s},{(2+$2), HL}); 3:16      $1 $2 2! push2_2store($1,$2) hi},{
    ld   (format({%-14s},eval(($2)+2){),} HL); 3:16      $1 $2 2! push2_2store($1,$2) hi})
    ld   HL, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:16},{3:10})      $1 $2 2! push2_2store($1,$2)
    ld   (format({%-14s},{$2), HL}); 3:16      $1 $2 2! push2_2store($1,$2) lo
    pop  HL             ; 1:10      $1 $2 2! push2_2store($1,$2)})dnl
dnl
dnl
dnl +!
dnl ( num addr -- )
dnl Adds num to the 16-bit number stored at addr.
define({ADDSTORE},{
    ld    A, E          ; 1:4       +! addstore
    add   A,(HL)        ; 1:7       +! addstore
    ld  (HL),A          ; 1:7       +! addstore
    inc  HL             ; 1:6       +! addstore
    ld    A, D          ; 1:4       +! addstore
    adc   A,(HL)        ; 1:7       +! addstore
    ld  (HL),A          ; 1:7       +! addstore
    pop  HL             ; 1:10      +! addstore
    pop  DE             ; 1:10      +! addstore})dnl
dnl
dnl
dnl num addr +!
dnl ( -- )
dnl Adds num to the 16-bit number stored at addr.
define({PUSH2_ADDSTORE},{
    push HL             ; 1:11      push2_addstore($1,$2)
    ld   BC, format({%-11s},$1); ifelse(index({$1},{(}),{0},{4:20},{3:10})      push2_addstore($1,$2)
    ld   HL, format({%-11s},{($2)}); 3:16      push2_addstore($1,$2)
    add  HL, BC         ; 1:11      push2_addstore($1,$2)
    ld   format({%-15s},($2){,} HL); 3:16      push2_addstore($1,$2)
    pop  HL             ; 1:10      push2_addstore($1,$2)})dnl
dnl
dnl
dnl cmove
dnl ( from to u -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVE},{
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove})dnl
dnl
dnl
dnl u cmove
dnl ( from to -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({PUSH_CMOVE},{ifelse(eval($1),{0},{},{
    ld   BC, format({%-11s},$1); 3:10      $1 cmove BC = u
    ex   DE, HL         ; 1:4       $1 cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 $1 cmove
    pop  HL             ; 1:10      $1 cmove
    pop  DE             ; 1:10      $1 cmove})})dnl
dnl
dnl
dnl cmove>
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVEGT},{
    ld    A, H          ; 1:4       cmove>
    or    L             ; 1:4       cmove>
    ld    B, H          ; 1:4       cmove>
    ld    C, L          ; 1:4       cmove> BC = u
    pop  HL             ; 1:10      cmove> HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove>
    lddr                ; 2:u*21/16 cmove>
    pop  HL             ; 1:10      cmove>
    pop  DE             ; 1:10      cmove>})dnl
dnl
dnl
dnl move
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVE},{
    or    A             ; 1:4       move
    adc  HL, HL         ; 1:11      move
    ld    B, H          ; 1:4       move
    ld    C, L          ; 1:4       move BC = 2*u
    pop  HL             ; 1:10      move HL = from = addr1
    jr    z, $+4        ; 2:7/12    move
    ldir                ; 2:u*42/32 move
    pop  HL             ; 1:10      move
    pop  DE             ; 1:10      move})dnl
dnl
dnl
dnl move>
dnl ( addr1 addr2 u -- )
dnl If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVEGT},{
    or    A             ; 1:4       move>
    adc  HL, HL         ; 1:11      move>
    ld    B, H          ; 1:4       move>
    ld    C, L          ; 1:4       move> BC = 2*u
    pop  HL             ; 1:10      move> HL = from = addr1
    jr    z, $+4        ; 2:7/12    move>
    lddr                ; 2:u*42/32 move>
    pop  HL             ; 1:10      move>
    pop  DE             ; 1:10      move>})dnl
dnl
dnl
dnl
dnl addr u char fill
dnl ( addr u char -- )
dnl If u is greater than zero, fill the contents of u consecutive characters at addr.
define({FILL},{ifelse({fast},{fast},{
__{}    ld    A, D          ; 1:4       fill
__{}    or    E             ; 1:4       fill
__{}    ld    A, L          ; 1:4       fill
__{}    pop  HL             ; 1:10      fill HL = from
__{}    jr    z, $+15       ; 2:7/12    fill
__{}    ld  (HL),A          ; 1:7       fill
__{}    dec  DE             ; 1:6       fill
__{}    ld    A, D          ; 1:4       fill
__{}    or    E             ; 1:4       fill
__{}    jr    z, $+9        ; 2:7/12    fill
__{}    ld    C, E          ; 1:4       fill
__{}    ld    B, D          ; 1:4       fill
__{}    ld    E, L          ; 1:4       fill
__{}    ld    D, H          ; 1:4       fill
__{}    inc  DE             ; 1:6       fill DE = to
__{}    ldir                ; 2:u*21/16 fill
__{}    pop  HL             ; 1:10      fill
__{}    pop  DE             ; 1:10      fill},
__{}{
__{}    ld    A, L          ; 1:4       fill A  = char
__{}    pop  HL             ; 1:10      fill HL = addr
__{}    ld    B, E          ; 1:4       fill
__{}    inc   D             ; 1:4       fill
__{}    inc   E             ; 1:4       fill
__{}    dec   E             ; 1:4       fill
__{}    jr    z, $+6        ; 2:7/12    fill
__{}    ld  (HL),A          ; 1:7       fill
__{}    inc  HL             ; 1:6       fill
__{}    djnz $-2            ; 2:13/8    fill
__{}    dec   D             ; 1:4       fill
__{}    jr   nz, $-5        ; 2:7/12    fill
__{}    pop  HL             ; 1:10      fill
__{}    pop  DE             ; 1:10      fill})})dnl
dnl
dnl
dnl
dnl addr u char fill
dnl ( addr u -- )
dnl If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH_FILL},{ifelse({fast},{fast},{
__{}    ld    A, H          ; 1:4       $1 fill
__{}    or    L             ; 1:4       $1 fill
__{}    jr    z, $+16       ; 2:7/12    $1 fill
__{}    ld    C, L          ; 1:4       $1 fill
__{}    ld    B, H          ; 1:4       $1 fill
__{}    ld    L, E          ; 1:4       $1 fill
__{}    ld    H, D          ; 1:4       $1 fill HL = from
__{}    ld  (HL),format({%-11s},$1); 2:10      $1 fill
__{}    dec  BC             ; 1:6       $1 fill
__{}    ld    A, B          ; 1:4       $1 fill
__{}    or    C             ; 1:4       $1 fill
__{}    jr    z, $+5        ; 2:7/12    $1 fill
__{}    inc  DE             ; 1:6       $1 fill DE = to
__{}    ldir                ; 2:u*21/16 $1 fill
__{}    pop  HL             ; 1:10      $1 fill
__{}    pop  DE             ; 1:10      $1 fill},
__{}{
__{}    ld    A, format({%-11s},$1); 2:7       $1 fill
__{}    ld    B, L          ; 1:4       $1 fill
__{}    inc   H             ; 1:4       $1 fill
__{}    inc   L             ; 1:4       $1 fill
__{}    dec   L             ; 1:4       $1 fill
__{}    jr    z, $+6        ; 2:7/12    $1 fill
__{}    ld  (DE),A          ; 1:7       $1 fill
__{}    inc  DE             ; 1:6       $1 fill
__{}    djnz $-2            ; 2:13/8    $1 fill
__{}    dec   H             ; 1:4       $1 fill
__{}    jr   nz, $-5        ; 2:7/12    $1 fill
__{}    pop  HL             ; 1:10      $1 fill
__{}    pop  DE             ; 1:10      $1 fill})})dnl
dnl
dnl
dnl
dnl addr u char fill
dnl ( addr -- )
dnl If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH2_FILL},{ifelse(eval($1),{0},{
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}eval($1),{1},{
__{}    ld  (HL),format({%-11s},$2); 2:10      $1 $2 fill
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}{
__{}    ld  (HL),format({%-11s},$2); 2:10      $1 $2 fill
__{}    ld   BC, format({%-11s},eval($1)-1); 3:10      $1 $2 fill
__{}    push DE             ; 1:11      $1 $2 fill
__{}    ld    D, H          ; 1:4       $1 $2 fill
__{}    ld    E, L          ; 1:4       $1 $2 fill
__{}    inc  DE             ; 1:6       $1 $2 fill DE = to
__{}    ldir                ; 2:u*21/16 $1 $2 fill
__{}    pop  HL             ; 1:10      $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill})})dnl
dnl
dnl
dnl
dnl addr u char fill
dnl ( -- )
dnl If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH3_FILL},{ifelse(eval($2),{0},{
__{}                                  ;           $1 $2 $3 fill},
__{}eval($2),{1},{
__{}    ld    A, format({%-11s},$1); ifelse(index({$1},{(}),{0},{3:13},{2:7 })      $1 $2 $3 fill
__{}    ld   format({%-15s},($2){,} A); 3:13      $1 $2 $3 fill},
__{}{
__{}    push DE             ; 1:11      $1 $2 $3 fill
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill HL = from
__{}    ld   DE, format({%-11s},$1+1); 3:10      $1 $2 $3 fill DE = to
__{}    ld   BC, format({%-11s},$2-1); 3:10      $1 $2 $3 fill
__{}    ld  (HL),format({%-11s},$3); 2:10      $1 $2 $3 fill
__{}    ldir                ; 2:u*21/16 $1 $2 $3 fill
__{}    pop  HL             ; 1:10      $1 $2 $3 fill
__{}    pop  DE             ; 1:10      $1 $2 $3 fill})})dnl
dnl
dnl
dnl
dnl ( -- random )
define({RND},{ifdef({USE_Rnd},,define({USE_Rnd},{}))
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd})dnl
dnl
dnl
dnl ( max -- random )
define({RANDOM},{ifdef({USE_Random},,define({USE_Random},{}))
    call Random         ; 3:17      random})dnl
dnl
dnl
dnl
dnl ( yx -- addr )
define({PUTPIXEL},{ifdef({USE_PIXEL},,define({USE_PIXEL},{}))
    call PIXEL          ; 3:17      pixel})dnl
dnl
dnl
dnl
dnl ( yx_from yx_to -- )
define({LINE},{ifdef({USE_LINE},,define({USE_LINE},{}))
    call line          ; 3:17       line
    pop  HL            ; 1:10       line
    pop  DE            ; 1:10       line})dnl
dnl
dnl
dnl

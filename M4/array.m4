dnl ## Array
dnl
dnl
dnl
define({ARRAY_SET},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_SET},{array_set},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_SET},{dnl
__{}define({__INFO},{array_set}){}dnl

    ld   IX, __FORM({%-11s},$1); 4:14      array_set   ( -- )}){}dnl
dnl
dnl
define({ARRAY_INC},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_INC},{array_inc},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_INC},{dnl
__{}define({__INFO},{array_inc}){}dnl

    inc  IX             ; 2:10      array_inc   ( -- )}){}dnl
dnl
dnl
define({ARRAY_DEC},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_DEC},{array_dec},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_DEC},{dnl
__{}define({__INFO},{array_dec}){}dnl

    dec  IX             ; 2:10      array_dec   ( -- )}){}dnl
dnl
dnl
define({ARRAY_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_ADD},{array_add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_ADD},{dnl
__{}define({__INFO},{array_add}){}dnl

    ex   DE, HL         ; 1:4       array_add($1)   ( x -- )
    add  IX, DE         ; 2:15      array_add($1)
    pop  DE             ; 1:11      array_add($1)}){}dnl
dnl
dnl
define({PUSH_ARRAY_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ARRAY_ADD},{$1 array add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ARRAY_ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__HAS_PTR($1),1,{
    ld   BC,format({%-12s},$1); 4:20      __INFO   ( -- )
    add  IX, BC         ; 2:15      __INFO},
__{}{
    ld   BC, __FORM({%-11s},$1); 3:10      __INFO   ( -- )
    add  IX, BC         ; 2:15      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
define({ARRAY_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_FETCH},{array_fetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_FETCH},{dnl
__{}define({__INFO},{array_fetch}){}dnl

                        ;[8:53]     array_fetch    ( -- (word) array[$1] )
    push DE             ; 1:11      array_fetch
    ld    D,format({%-12s},[IX+$1+1]); 3:19      array_fetch
    ld    E,format({%-12s},[IX+$1]); 3:19      array_fetch
    ex   DE, HL         ; 1:4       array_fetch}){}dnl
dnl
dnl
define({DUP_ARRAY_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_FETCH},{dup_array_fetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_FETCH},{dnl
__{}define({__INFO},{dup_array_fetch}){}dnl

                        ;[9:64]     dup_array_fetch    ( x1 -- x1 x1 (word) array[$1] )
    push DE             ; 1:11      dup_array_fetch
    push HL             ; 1:11      dup_array_fetch
    ld    D,format({%-12s},[IX+$1+1]); 3:19      dup_array_fetch
    ld    E,format({%-12s},[IX+$1]); 3:19      dup_array_fetch
    ex   DE, HL         ; 1:4       dup_array_fetch}){}dnl
dnl
dnl
define({ARRAY_FETCH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_FETCH_ADD},{array_fetch_add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_FETCH_ADD},{dnl
__{}define({__INFO},{array_fetch_add}){}dnl

                        ;[7:49]     array_fetch_add
    ld    B,format({%-12s},[IX+$1+1]); 3:19      array_fetch_add
    ld    C,format({%-12s},[IX+$1]); 3:19      array_fetch_add
    add  HL, BC         ; 1:11      array_fetch_add    {TOS} += (word) array[eval($1)]}){}dnl
dnl
dnl                     ;[11:52]
dnl ld    B, IXh        ; 2:8
dnl ld    C, IXl        ; 2:8
dnl ld    A,[BC]        ; 1:7
dnl add   A, L          ; 1:4
dnl ld    L, A          ; 1:4
dnl inc  BC             ; 1:6
dnl ld    A,[BC]        ; 1:7
dnl adc   A, H          ; 1:4
dnl ld    H, A          ; 1:4
dnl
dnl                     ;[8:75]
dnl push IX             ; 2:15
dnl ex  [SP],HL         ; 1:19
dnl ld    C,[HL]        ; 1:7
dnl inc  HL             ; 1:6
dnl ld    B,[HL]        ; 1:7
dnl pop  HL             ; 1:10
dnl add  HL, BC         ; 1:11
dnl
dnl
dnl
dnl ( x -- )
define({ARRAY_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_STORE},{array_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_STORE},{dnl
__{}define({__INFO},{array_store}){}dnl

                        ;[8:52]     array_store($1)   ( x -- )
    ex   DE, HL         ; 1:4       array_store($1)
    ld  format({%-16s},[IX+$1+1]{,} D); 3:19      array_store($1)
    ld  format({%-16s},[IX+$1]{,} E); 3:19      array_store($1)   array[eval($1)] = word
    pop  DE             ; 1:10      array_store($1)}){}dnl
dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 8bit Arithmetic
dnl ---------------------------------------------------------------------------
dnl
dnl   The Z80 only supports a constant index for reading from the array:
dnl
dnl      ld A,(IX+constant)
dnl
dnl   It goes to load the value lying for example on the next row, because the size of the table is constant at the time of compilation.
dnl   But if the size of the table depends on the input, then we need:
dnl
dnl      ld A,(IX+variable)
dnl
dnl   Where variable is a constant after getting the size of the table from the input.
dnl   That's why I added another optional parameter for the word to enter the address name where variable is stored.
dnl   So it goes to refer to it and change its value at runtime.
dnl
dnl
define({ARRAY_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_CFETCH},{array_cfetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_CFETCH},{dnl
__{}define({__INFO},{array_cfetch}){}dnl

    push DE             ; 1:11      array_cfetch    ( -- char_array[$1] )
    ld    D, 0x00       ; 2:7       array_cfetch
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    E,format({%-12s},[IX+$1]); 3:19      array_cfetch
    ex   DE, HL         ; 1:4       array_cfetch}){}dnl
dnl
dnl
dnl push DE             ; 1:11
dnl ex   DE, HL         ; 1:4
dnl ld   HL,[adr]       ; 3:16
dnl ld    L,[HL]        ; 1:7
dnl ld    H, 0x00       ; 2:7
dnl
dnl
define({ARRAY_LO_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_LO_FETCH},{array_lo_fetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_LO_FETCH},{dnl
__{}define({__INFO},{array_lo_fetch}){}dnl

    push DE             ; 1:11      array_lo_fetch    ( -- char_array[$1] )
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    E,format({%-12s},[IX+$1]); 3:19      array_lo_fetch
    ex   DE, HL         ; 1:4       array_lo_fetch}){}dnl
dnl
dnl
define({ARRAY_HI_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_HI_FETCH},{array_hi_fetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_HI_FETCH},{dnl
__{}define({__INFO},{array_hi_fetch}){}dnl

    push DE             ; 1:11      array_hi_fetch    ( -- char_array[$1] )
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    D,format({%-12s},[IX+$1]); 3:19      array_hi_fetch
    ex   DE, HL         ; 1:4       array_hi_fetch}){}dnl
dnl
dnl
define({DUP_ARRAY_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_CFETCH},{dup_array_cfetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_CFETCH},{dnl
__{}define({__INFO},{dup_array_cfetch}){}dnl

    push DE             ; 1:11      dup_array_cfetch    ( a -- a a char_array[$1] )
    push HL             ; 1:11      dup_array_cfetch
    ld    D, 0x00       ; 2:7       dup_array_cfetch
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    E,format({%-12s},[IX+$1]); 3:19      dup_array_cfetch
    ex   DE, HL         ; 1:4       dup_array_cfetch}){}dnl
dnl
dnl
define({DUP_ARRAY_CFETCH_EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_CFETCH_EQ},{dup_array_cfetch_eq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_CFETCH_EQ},{dnl
__{}define({__INFO},{dup_array_cfetch_eq}){}dnl

    push DE             ; 1:11      dup_array_cfetch_eq    ( char1 -- char1 flag(char1 == char_array[$1]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_eq
    ld    A, E          ; 1:4       dup_array_cfetch_eq
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    xor  format({%-15s},[IX+$1]); 3:19      dup_array_cfetch_eq
    sub  0x01           ; 2:7       dup_array_cfetch_eq
    sbc  HL, HL         ; 2:15      dup_array_cfetch_eq}){}dnl
dnl
dnl
define({DUP_ARRAY_CFETCH_NE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_CFETCH_NE},{dup_array_cfetch_ne},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_CFETCH_NE},{dnl
__{}define({__INFO},{dup_array_cfetch_ne}){}dnl

    push DE             ; 1:11      dup_array_cfetch_ne    ( char1 -- char1 flag(char1 <> char_array[$1]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_ne
    ld    A, E          ; 1:4       dup_array_cfetch_ne
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    xor  format({%-15s},[IX+$1]); 3:19      dup_array_cfetch_ne
    add   A, 0xFF       ; 2:7       dup_array_cfetch_ne
    sbc  HL, HL         ; 2:15      dup_array_cfetch_ne}){}dnl
dnl
dnl
define({DUP_ARRAY_CFETCH_ULT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_CFETCH_ULT},{dup_array_cfetch_ult},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_CFETCH_ULT},{dnl
__{}define({__INFO},{dup_array_cfetch_ult}){}dnl

    push DE             ; 1:11      dup_array_cfetch_ult    ( char1 -- char1 flag(char1 (U)< char_array[$1]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_ult
    ld    A, E          ; 1:4       dup_array_cfetch_ult
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    sub  format({%-15s},[IX+$1]); 3:19      dup_array_cfetch_ult
    sbc  HL, HL         ; 2:15      dup_array_cfetch_ult}){}dnl
dnl
dnl
define({DUP_ARRAY_CFETCH_ULE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_CFETCH_ULE},{dup_array_cfetch_ule},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_CFETCH_ULE},{dnl
__{}define({__INFO},{dup_array_cfetch_ule}){}dnl

    push DE             ; 1:11      dup_array_cfetch_ule    ( char1 -- char1 flag(char1 (U)<= char_array[$1]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_ule
    scf                 ; 1:4       dup_array_cfetch_ule
    ld    A, E          ; 1:4       dup_array_cfetch_ule
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    sbc   A,format({%-12s},[IX+$1]); 3:19      dup_array_cfetch_ule
    sbc  HL, HL         ; 2:15      dup_array_cfetch_ule}){}dnl
dnl
dnl
define({DUP_ARRAY_CFETCH_UGT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_CFETCH_UGT},{dup_array_cfetch_ugt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_CFETCH_UGT},{dnl
__{}define({__INFO},{dup_array_cfetch_ugt}){}dnl

    push DE             ; 1:11      dup_array_cfetch_ugt    ( char1 -- char1 flag(char1 (U)> char_array[$1]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_ugt
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    A,format({%-12s},[IX+$1]); 3:19      dup_array_cfetch_ugt
    sub   E             ; 1:4       dup_array_cfetch_ugt
    sbc  HL, HL         ; 2:15      dup_array_cfetch_ugt}){}dnl
dnl
dnl
define({DUP_ARRAY_CFETCH_UGE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_CFETCH_UGE},{dup_array_cfetch_uge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_CFETCH_UGE},{dnl
__{}define({__INFO},{dup_array_cfetch_uge}){}dnl

    push DE             ; 1:11      dup_array_cfetch_uge    ( char1 -- char1 flag(char1 (U)>= char_array[$1]) )
    ex   DE, HL         ; 1:4       dup_array_cfetch_uge
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    A,format({%-12s},[IX+$1]); 3:19      dup_array_cfetch_uge
    scf                 ; 1:4       dup_array_cfetch_uge
    sbc   A, E          ; 1:4       dup_array_cfetch_uge
    sbc  HL, HL         ; 2:15      dup_array_cfetch_uge}){}dnl
dnl
dnl
define({DUP_ARRAY_LO_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_LO_FETCH},{dup_array_lo_fetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_LO_FETCH},{dnl
__{}define({__INFO},{dup_array_lo_fetch}){}dnl

    push DE             ; 1:11      dup_array_lo_fetch    ( a -- a char_array[$1] )
    push HL             ; 1:11      dup_array_lo_fetch
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    E,format({%-12s},[IX+$1]); 3:19      dup_array_lo_fetch
    ex   DE, HL         ; 1:4       dup_array_lo_fetch}){}dnl
dnl
dnl
define({DUP_ARRAY_HI_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ARRAY_HI_FETCH},{dup_array_hi_fetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ARRAY_HI_FETCH},{dnl
__{}define({__INFO},{dup_array_hi_fetch}){}dnl

    push DE             ; 1:11      dup_array_hi_fetch    ( a -- a char_array[$1] )
    push HL             ; 1:11      dup_array_hi_fetch
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    D,format({%-12s},[IX+$1]); 3:19      dup_array_hi_fetch
    ex   DE, HL         ; 1:4       dup_array_hi_fetch}){}dnl
dnl
dnl
define({ARRAY_CFETCH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_CFETCH_ADD},{array_cfetch_add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_CFETCH_ADD},{dnl
__{}define({__INFO},{array_cfetch_add}){}dnl

    ld    B, 0x00       ; 2:7       array_cfetch_add
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    C,format({%-12s},[IX+$1]); 3:19      array_cfetch_add
    add  HL, BC         ; 1:11      array_cfetch_add    {TOS} += char_array[eval($1)]}){}dnl
dnl
dnl
define({ARRAY_LO_FETCH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_LO_FETCH_ADD},{array_lo_fetch_add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_LO_FETCH_ADD},{dnl
__{}define({__INFO},{array_lo_fetch_add}){}dnl

__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    A,format({%-12s},[IX+$1]); 3:19      array_lo_fetch_add
    add   A, L          ; 1:4       array_lo_fetch_add
    ld    L, A          ; 1:4       array_lo_fetch_add    {lo(TOS)} += char_array[eval($1)]}){}dnl
dnl
dnl
define({ARRAY_HI_FETCH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_HI_FETCH_ADD},{array_hi_fetch_add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_HI_FETCH_ADD},{dnl
__{}define({__INFO},{array_hi_fetch_add}){}dnl

__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld    A,format({%-12s},[IX+$1]); 3:19      array_hi_fetch_add
    add   A, H          ; 1:4       array_hi_fetch_add
    ld    H, A          ; 1:4       array_hi_fetch_add    {hi(TOS)} += char_array[eval($1)]}){}dnl
dnl
dnl
define({ARRAY_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_CSTORE},{array_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_CSTORE},{dnl
__{}define({__INFO},{array_cstore}){}dnl

    ex   DE, HL         ; 1:4       array_cstore($1)   ( char -- )
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld  format({%-16s},[IX+$1]{,} E); 3:19      array_cstore($1)   char_array[eval($1)] = char
    pop  DE             ; 1:10      array_cstore($1)}){}dnl
dnl
dnl
define({ARRAY_LO_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_LO_STORE},{array_lo_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_LO_STORE},{dnl
__{}define({__INFO},{array_lo_store}){}dnl

    ex   DE, HL         ; 1:4       array_lo_store($1)   ( char -- )
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld  format({%-16s},[IX+$1]{,} E); 3:19      array_lo_store($1)   char_array[eval($1)] = lo({TOS})
    pop  DE             ; 1:10      array_lo_store($1)}){}dnl
dnl
dnl
define({ARRAY_HI_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ARRAY_HI_STORE},{array_hi_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ARRAY_HI_STORE},{dnl
__{}define({__INFO},{array_hi_store}){}dnl

    ex   DE, HL         ; 1:4       array_hi_store($1)   ( char -- )
__{}ifelse($2,{},{},{$2  EQU $+2
})dnl
    ld  format({%-16s},[IX+$1]{,} E); 3:19      array_hi_store($1)   char_array[eval($1)] = hi({TOS})
    pop  DE             ; 1:10      array_hi_store($1)}){}dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 16bit & 32bit mix Arithmetic
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 32bit Arithmetic
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl
dnl

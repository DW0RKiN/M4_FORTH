;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module Pangram
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _PRINT_INT
	.globl _pangram
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;Pangram.c:3: int pangram(const char * str)
;	---------------------------------
; Function pangram
; ---------------------------------
_pangram::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-12
	add	hl, sp
	ld	sp, hl
;Pangram.c:5: str--;
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	dec	hl
	ld	4 (ix), l
	ld	5 (ix), h
;Pangram.c:7: unsigned long int alphabet = 0;
	xor	a, a
	ld	-4 (ix), a
	ld	-3 (ix), a
	ld	-2 (ix), a
	ld	-1 (ix), a
;Pangram.c:9: while (c = *++str) {
	ld	a, 4 (ix)
	ld	-7 (ix), a
	ld	a, 5 (ix)
	ld	-6 (ix), a
00103$:
	inc	-7 (ix)
	jr	NZ,00124$
	inc	-6 (ix)
00124$:
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	a, (hl)
	ld	-5 (ix), a
	ld	-8 (ix), a
	ld	a, -5 (ix)
	or	a, a
	jr	Z,00105$
;Pangram.c:10: c |= 32; // uppercase
	ld	c, -8 (ix)
	set	5, c
	ld	a, c
;Pangram.c:11: c -= 'a';
	add	a, #0x9f
;Pangram.c:12: if ( c<26 ) alphabet |= (long unsigned int) 1 << c;      
	ld	-8 (ix), a
	sub	a, #0x1a
	jr	NC,00103$
	ld	b, -8 (ix)
	ld	-12 (ix), #0x01
	ld	-11 (ix), #0x00
	ld	-10 (ix), #0x00
	ld	-9 (ix), #0x00
	inc	b
	jr	00126$
00125$:
	sla	-12 (ix)
	rl	-11 (ix)
	rl	-10 (ix)
	rl	-9 (ix)
00126$:
	djnz	00125$
	ld	a, -4 (ix)
	or	a, -12 (ix)
	ld	-4 (ix), a
	ld	a, -3 (ix)
	or	a, -11 (ix)
	ld	-3 (ix), a
	ld	a, -2 (ix)
	or	a, -10 (ix)
	ld	-2 (ix), a
	ld	a, -1 (ix)
	or	a, -9 (ix)
	ld	-1 (ix), a
	jr	00103$
00105$:
;Pangram.c:15: return alphabet==0x3FFFFFF;
	ld	a, -4 (ix)
	inc	a
	jr	NZ,00127$
	ld	a, -3 (ix)
	inc	a
	jr	NZ,00127$
	ld	a, -2 (ix)
	inc	a
	jr	NZ,00127$
	ld	a, -1 (ix)
	sub	a, #0x03
	jr	NZ, 00127$
	ld	a, #0x01
	.db	#0x20
00127$:
	xor	a, a
00128$:
	ld	l, a
	ld	h, #0x00
;Pangram.c:16: }
	ld	sp, ix
	pop	ix
	ret
;Pangram.c:18: void PRINT_INT(int num) __naked
;	---------------------------------
; Function PRINT_INT
; ---------------------------------
_PRINT_INT::
;Pangram.c:71: __endasm;
	pop	af ; 1:10 ret
	pop	hl ; 1:10 num
	push	hl ; 1:11 num
	push	af ; 1:10 ret
;==============================================================================
;	Input: HL
;	Output: Print signed decimal number in HL
;	Pollutes: AF, BC, HL <- DE, DE <- (SP)
	ld	a, h ; 1:4 prt_s16
	add	a, a ; 1:4 prt_s16
	jr	nc, 00001$ ; 2:7/12 prt_s16
	ld	a, #0x2D ; 2:7 prt_s16 putchar Pollutes: AF, DE', BC'
	rst	0x10 ; 1:11 prt_s16 putchar('-') with ZX 48K ROM
	xor	a, a ; 1:4 prt_s16 neg
	sub	a, l ; 1:4 prt_s16 neg
	ld	l, a ; 1:4 prt_s16 neg
	sbc	a, h ; 1:4 prt_s16 neg
	sub	a, l ; 1:4 prt_s16 neg
	ld	h, a ; 1:4 prt_s16 neg
;------------------------------------------------------------------------------
;	Input: HL
;	Output: Print unsigned decimal number in HL
;	Pollutes: AF, BC, HL <- DE, DE <- (SP)
	00001$:
	xor	a, a ; 1:4 prt_u16 HL=103 & A=0 => 103, HL = 103 & A='0' => 00103
	ld	bc, #0xD8F0 ; 3:10 prt_u16 -10000
	call	00002$ ; 3:17 prt_u16
	ld	bc, #0xFC18 ; 3:10 prt_u16 -1000
	call	00002$ ; 3:17 prt_u16
	ld	bc, #0xFF9C ; 3:10 prt_u16 -100
	call	00002$ ; 3:17 prt_u16
	ld	c, #0xF6 ; 2:7 prt_u16 -10
	call	00002$ ; 3:17 prt_u16
	ld	c, b ; 1:4 prt_u16
;------------------------------------------------------------------------------
;	Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
;	Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
;	Pollutes: AF, HL
	00002$:
	inc	a ; 1:4 bin16_dec
	add	hl, bc ; 1:11 bin16_dec
	jr	c, 00002$ ; 2:7/12 bin16_dec
	sbc	hl, bc ; 2:15 bin16_dec
	dec	a ; 1:4 bin16_dec
	ret	z ; 1:5/11 bin16_dec does not print leading zeros
	00003$:
	or	a, #0x30 ; 2:7 bin16_dec 1..9 --> '1'..'9', unchanged '0'..'9'
	rst	0x10 ; 1:11 bin16_dec putchar with ZX 48K ROM in, this will print char in A
	ld	a, #0x30 ; 2:7 bin16_dec reset A to '0'
	ret	; 1:10 bin16_dec
;Pangram.c:72: }
;Pangram.c:74: int main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;Pangram.c:76: char *str = "The five boxing wizards jump quickly.";
	ld	bc, #___str_0+0
;Pangram.c:78: for (i = 10000; i > 0; i--) 
	ld	de, #0x2710
00102$:
;Pangram.c:79: pangram(str);
	push	bc
	push	de
	push	bc
	call	_pangram
	pop	af
	pop	de
	pop	bc
;Pangram.c:78: for (i = 10000; i > 0; i--) 
	ex	de,hl
	dec	hl
	ld	e, l
	ld	a,h
	ld	d,a
	or	a, l
	jr	NZ,00102$
;Pangram.c:81: PRINT_INT(pangram(str));
	push	bc
	call	_pangram
	ex	(sp),hl
	call	_PRINT_INT
	pop	af
;Pangram.c:82: return 0;
	ld	hl, #0x0000
;Pangram.c:83: }
	ret
___str_0:
	.ascii "The five boxing wizards jump quickly."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)

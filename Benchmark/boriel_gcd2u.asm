	org 32768
.core.__START_PROGRAM:
	di
	push ix
	push iy
	exx
	push hl
	exx
	ld hl, 0
	add hl, sp
	ld (.core.__CALL_BACK__), hl
	ei
	jp .core.__MAIN_PROGRAM__
.core.__CALL_BACK__:
	DEFW 0
.core.ZXBASIC_USER_DATA:
	; Defines USER DATA Length in bytes
.core.ZXBASIC_USER_DATA_LEN EQU .core.ZXBASIC_USER_DATA_END - .core.ZXBASIC_USER_DATA
	.core.__LABEL__.ZXBASIC_USER_DATA_LEN EQU .core.ZXBASIC_USER_DATA_LEN
	.core.__LABEL__.ZXBASIC_USER_DATA EQU .core.ZXBASIC_USER_DATA
_m:
	DEFB 00, 00
_n:
	DEFB 00, 00
_a:
	DEFB 00, 00
_b:
	DEFB 00, 00
.core.ZXBASIC_USER_DATA_END:
.core.__MAIN_PROGRAM__:
	call .LABEL._gcd2_bench
	ld hl, 0
	ld b, h
	ld c, l
.core.__END_PROGRAM:
	di
	ld hl, (.core.__CALL_BACK__)
	ld sp, hl
	exx
	pop hl
	pop iy
	pop ix
	exx
	ei
	ret
.LABEL._gcd2:
	ld hl, (_m)
	ld (_a), hl
	ld hl, (_n)
	ld (_b), hl
	ld de, (_b)
	ld hl, (_a)
	call .core.__BOR16
	ld de, 0
	call .core.__EQ16
	or a
	jp z, .LABEL.__LABEL1
	ld hl, 1
	ld (_a), hl
	ret
.LABEL.__LABEL1:
	ld de, 0
	ld hl, (_a)
	call .core.__EQ16
	or a
	jp z, .LABEL.__LABEL3
	ld hl, (_b)
	ld (_a), hl
	ret
.LABEL.__LABEL3:
	ld de, 0
	ld hl, (_b)
	call .core.__EQ16
	or a
	jp z, .LABEL.__LABEL6
	ret
.LABEL.__LABEL6:
	ld de, (_b)
	ld hl, (_a)
	or a
	sbc hl, de
	ld a, h
	or l
	jp z, .LABEL.__LABEL7
	ld hl, (_b)
	ld de, (_a)
	or a
	sbc hl, de
	jp nc, .LABEL.__LABEL8
	ld hl, (_a)
	ld de, (_b)
	or a
	sbc hl, de
	ld (_a), hl
	jp .LABEL.__LABEL9
.LABEL.__LABEL8:
	ld hl, (_b)
	ld de, (_a)
	or a
	sbc hl, de
	ld (_b), hl
.LABEL.__LABEL9:
	jp .LABEL.__LABEL6
.LABEL.__LABEL7:
	ret
.LABEL._gcd2_bench:
	ld hl, 0
	ld (_m), hl
	jp .LABEL.__LABEL10
.LABEL.__LABEL13:
	ld hl, 0
	ld (_n), hl
	jp .LABEL.__LABEL15
.LABEL.__LABEL18:
	call .LABEL._gcd2
	ld hl, (_n)
	inc hl
	ld (_n), hl
.LABEL.__LABEL15:
	ld hl, 99
	ld de, (_n)
	or a
	sbc hl, de
	jp nc, .LABEL.__LABEL18
	ld hl, (_m)
	inc hl
	ld (_m), hl
.LABEL.__LABEL10:
	ld hl, 99
	ld de, (_m)
	or a
	sbc hl, de
	jp nc, .LABEL.__LABEL13
	ret
	;; --- end of user code ---
; vim:ts=4:et:
	; FASTCALL bitwise or 16 version.
	; result in HL
; __FASTCALL__ version (operands: A, H)
	; Performs 16bit or 16bit and returns the boolean
; Input: HL, DE
; Output: HL <- HL OR DE


.core.__BOR16:
	    ld a, h
	    or d
	    ld h, a

	    ld a, l
	    or e
	    ld l, a

	    ret


.core.__EQ16:	; Test if 16bit values HL == DE
    ; Returns result in A: 0 = False, FF = True
	    xor a	; Reset carry flag
	    sbc hl, de
	    ret nz
	    inc a
	    ret

	END

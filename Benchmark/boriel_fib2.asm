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
_i:
	DEFB 00, 00
_a:
	DEFB 00, 00
_b:
	DEFB 00, 00
_c:
	DEFB 00, 00
.core.ZXBASIC_USER_DATA_END:
.core.__MAIN_PROGRAM__:
	call .LABEL._fib2_bench
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
.LABEL._fib2:
	ld hl, 0
	ld (_a), hl
	ld hl, 1
	ld (_b), hl
	ld hl, 1
	ld (_i), hl
	jp .LABEL.__LABEL0
.LABEL.__LABEL3:
	ld hl, (_b)
	ld (_c), hl
	ld hl, (_a)
	ld (_b), hl
	ld de, (_a)
	ld hl, (_c)
	add hl, de
	ld (_a), hl
	ld hl, (_i)
	inc hl
	ld (_i), hl
.LABEL.__LABEL0:
	ld hl, (_n)
	ld de, (_i)
	or a
	sbc hl, de
	jp nc, .LABEL.__LABEL3
	ret
.LABEL._fib2_bench:
	ld hl, 0
	ld (_m), hl
	jp .LABEL.__LABEL5
.LABEL.__LABEL8:
	ld hl, 0
	ld (_n), hl
	jp .LABEL.__LABEL10
.LABEL.__LABEL13:
	call .LABEL._fib2
	ld hl, (_n)
	inc hl
	ld (_n), hl
.LABEL.__LABEL10:
	ld hl, 19
	ld de, (_n)
	or a
	sbc hl, de
	jp nc, .LABEL.__LABEL13
	ld hl, (_m)
	inc hl
	ld (_m), hl
.LABEL.__LABEL5:
	ld hl, 999
	ld de, (_m)
	or a
	sbc hl, de
	jp nc, .LABEL.__LABEL8
	ret
	;; --- end of user code ---

	END

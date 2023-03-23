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
_i:
	DEFB 00, 00
_j:
	DEFB 00, 00
_a:
	DEFB 00, 00
_b:
	DEFB 00, 00
_c:
	DEFB 00, 00
.core.ZXBASIC_USER_DATA_END:
.core.__MAIN_PROGRAM__:
	call .LABEL._gcd1_bench
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
.LABEL._gcd1:
	ld hl, (_i)
	ld (_a), hl
	ld hl, (_j)
	ld (_b), hl
	ld hl, (_a)
	ld a, h
	or l
	jp z, .LABEL.__LABEL0
.LABEL.__LABEL2:
	ld hl, (_b)
	ld a, h
	or l
	jp z, .LABEL.__LABEL3
	ld hl, (_b)
	ld de, (_a)
	call .core.__LTI16
	or a
	jp z, .LABEL.__LABEL5
	ld hl, (_a)
	ld (_c), hl
	ld hl, (_b)
	ld (_a), hl
	ld hl, (_c)
	ld (_b), hl
.LABEL.__LABEL5:
	ld hl, (_b)
	ld de, (_a)
	or a
	sbc hl, de
	ld (_b), hl
	jp .LABEL.__LABEL2
.LABEL.__LABEL3:
	jp .LABEL.__LABEL1
.LABEL.__LABEL0:
	ld hl, 1
	ld (_a), hl
	ld hl, (_b)
	ld a, h
	or l
	jp z, .LABEL.__LABEL1
	ld hl, (_b)
	ld (_a), hl
.LABEL.__LABEL1:
	ret
.LABEL._gcd1_bench:
	ld hl, 0
	ld (_i), hl
	jp .LABEL.__LABEL8
.LABEL.__LABEL11:
	ld hl, 0
	ld (_j), hl
	jp .LABEL.__LABEL13
.LABEL.__LABEL16:
	call .LABEL._gcd1
	ld hl, (_j)
	inc hl
	ld (_j), hl
.LABEL.__LABEL13:
	ld hl, 99
	ld de, (_j)
	call .core.__LTI16
	or a
	jp z, .LABEL.__LABEL16
	ld hl, (_i)
	inc hl
	ld (_i), hl
.LABEL.__LABEL8:
	ld hl, 99
	ld de, (_i)
	call .core.__LTI16
	or a
	jp z, .LABEL.__LABEL11
	ret
	;; --- end of user code ---

  if 0
__LEI8: ; Signed <= comparison for 8bit int
	    ; A <= H (registers)
	    PROC
	    LOCAL checkParity
	    sub h
	    jr nz, __LTI
	    inc a
	    ret

__LTI8:  ; Test 8 bit values A < H
	    sub h

__LTI:   ; Generic signed comparison
	    jp po, checkParity
	    xor 0x80
checkParity:
	    ld a, 0     ; False
	    ret p
	    inc a       ; True
	    ret
	    ENDP
  endif

.core.__LTI16: ; Test 8 bit values HL < DE
    ; Returns result in A: 0 = False, !0 = True
	    PROC
	    LOCAL checkParity
	    or a
	    sbc hl, de
	    jp po, checkParity
	    ld a, h
	    xor 0x80
checkParity:
	    ld a, 0     ; False
	    ret p
	    inc a       ; True
	    ret
	    ENDP

	END

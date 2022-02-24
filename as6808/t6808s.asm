	.title	AS6808 Sequential Test

	;	This is the AS6805 Sequential Test file
	;	t6805s.asm updated to include the 68HC08
	;	instructions.

	.area	DIRECT

	.setdp	0,DIRECT

	bit0	=	0
	bit1	=	1
	bit2	=	2
	bit3	=	3
	bit4	=	4
	bit5	=	5
	bit6	=	6
	bit7	=	7

	ext = 0x0123
	ix2 = 0xABCD
	ix1 = 0x00EF

begin:	.byte	0
loca:	.byte	0
locb:	.byte	0
locc:	.byte	0
locd:	.byte	0
loce:	.byte	0


	.area	AS6808A

1$:	jsr	18$		; CD __ __
	jmp	18$		; CC __ __
	sub	18$		; C0 __ __

	jsr	19$		; CD 00 00
	jmp	20$		; CC 00 03
	sub	21$		; C0 00 06


	.page

	. = 1$+256

2$:	brset	#bit0,*loca, .	; 00 01 FD
	brclr	#bit0,*loca,2$	; 01 01 FA
	brset	#bit1,*loca,2$	; 02 01 F7
	brclr	#bit1,*loca,2$	; 03 01 F4
	brset	#bit2,*loca,2$	; 04 01 F1
	brclr	#bit2,*loca,2$	; 05 01 EE
	brset	#bit3,*loca,2$	; 06 01 EB
	brclr	#bit3,*loca,2$	; 07 01 E8
	brset	#bit4,*loca,2$	; 08 01 E5
	brclr	#bit4,*loca,2$	; 09 01 E2
	brset	#bit5,*loca,2$	; 0A 01 DF
	brclr	#bit5,*loca,2$	; 0B 01 DC
	brset	#bit6,*loca,2$	; 0C 01 D9
	brclr	#bit6,*loca,2$	; 0D 01 D6
	brset	#bit7,*loca,2$	; 0E 01 D3
	brclr	#bit7,*loca,2$	; 0F 01 D0

	bset	#bit0,*locb	; 10 02
	bclr	#bit0,*locb	; 11 02
	bset	#bit1,*locb	; 12 02
	bclr	#bit1,*locb	; 13 02
	bset	#bit2,*locb	; 14 02
	bclr	#bit2,*locb	; 15 02
	bset	#bit3,*locb	; 16 02
	bclr	#bit3,*locb	; 17 02
	bset	#bit4,*locb	; 18 02
	bclr	#bit4,*locb	; 19 02
	bset	#bit5,*locb	; 1A 02
	bclr	#bit5,*locb	; 1B 02
	bset	#bit6,*locb	; 1C 02
	bclr	#bit6,*locb	; 1D 02
	bset	#bit7,*locb	; 1E 02
	bclr	#bit7,*locb	; 1F 02

3$:	bra	3$		; 20 FE
	brn	3$		; 21 FC
	bhi	3$		; 22 FA
	bls	3$		; 23 F8
	bcc	3$		; 24 F6
	bcs	3$		; 25 F4
	bne	3$		; 26 F2
	beq	3$		; 27 F0
	bhcc	3$		; 28 EE
	bhcs	3$		; 29 EC
	bpl	3$		; 2A EA
	bmi	3$		; 2B E8
	bmc	3$		; 2C E6
	bms	3$		; 2D E4
	bil	3$		; 2E E2
	bih	3$		; 2F E0


	.page

	neg	*locc		; 30 03
4$:	cbeq	*locc,4$	; 31 03 FD	HC08
				; 32
	com	*locc		; 33 03
	lsr	*locc		; 34 03
	sthx	*locc		; 35 03		HC08
	ror	*locc		; 36 03
	asr	*locc		; 37 03
	lsl	*locc		; 38 03
	rol	*locc		; 39 03
	dec	*locc		; 3A 03
5$:	dbnz	*locc,5$	; 3B 03 FD	HC08
	inc	*locc		; 3C 03
	tst	*locc		; 3D 03
				; 3E
	clr	*locc		; 3F 03

	nega			; 40
6$:	cbeqa	#0x21,6$	; 41 21 FD	HC08
	mul			; 42		HC08
	coma			; 43
	lsra			; 44
	ldhx	#0x21		; 45 00 21	HC08
	rora			; 46
	asra			; 47
	lsla			; 48
	rola			; 49
	deca			; 4A
7$:	dbnza	7$		; 4B FE		HC08
	inca			; 4C
	tsta			; 4D
	mov	*loca,*locb	; 4E 01 02	HC08
	clra			; 4F

	negx			; 50
8$:	cbeqx	#0x21,8$	; 51 21 FD	HC08
	div			; 52		HC08
	comx			; 53
	lsrx			; 54
	ldhx	*loca		; 55 01		HC08
	rorx			; 56
	asrx			; 57
	lslx			; 58
	rolx			; 59
	decx			; 5A
9$:	dbnzx	9$		; 5B FE		HC08
	incx			; 5C
	tstx			; 5D
	mov	*loca,x+	; 5E 01		HC08
	clrx			; 5F


	.page

	neg	locd,x		; 60 04
10$:	cbeq	4,x+,10$	; 61 04 FD	HC08
	nsa			; 62		HC08
	com	locd,x		; 63 04
	lsr	locd,x		; 64 04
	cphx	#0x21		; 65 00 21	HC08
	ror	locd,x		; 66 04
	asr	locd,x		; 67 04
	lsl	locd,x		; 68 04
	rol	locd,x		; 69 04
	dec	locd,x		; 6A 04
11$:	dbnz	locd,x,11$	; 6B 04 FD	HC08
	inc	locd,x		; 6C 04
	tst	locd,x		; 6D 04
	mov	#0x21,*loca	; 6E 21 01	HC08
	clr	locd,x		; 6F 04

	neg	locd,s		; 9E 60 04	HC08
12$:	cbeq	locd,s,12$	; 9E 61 04 FC	HC08
				; 9E 62		HC08
	com	locd,s		; 9E 63 04	HC08
	lsr	locd,s		; 9E 64 04	HC08
				; 9E 65		HC08
	ror	locd,s		; 9E 66 04	HC08
	asr	locd,s		; 9E 67 04	HC08
	lsl	locd,s		; 9E 68 04	HC08
	rol	locd,s		; 9E 69 04	HC08
	dec	locd,s		; 9E 6A 04	HC08
13$:	dbnz	locd,s,13$	; 9E 6B 04 FD	HC08
	inc	locd,s		; 9E 6C 04	HC08
	tst	locd,s		; 9E 6D 04	HC08
				; 9E 6E		HC08
	clr	locd,s		; 9E 6F 04	HC08

	neg	,x		; 70
14$:	cbeq	,x+,14$		; 71 FE		HC08
	daa			; 72
	com	,x		; 73
	lsr	,x		; 74
	cphx	*loca		; 75 01		HC08
	ror	,x		; 76
	asr	,x		; 77
	lsl	,x		; 78
	rol	,x		; 79
	dec	,x		; 7A
15$:	dbnz	,x,15$		; 7B FE		HC08
	inc	,x		; 7C
	tst	,x		; 7D
	mov	,x+,*loca	; 7E 01		HC08
	clr	,x		; 7F


	.page

	rti			; 80
	rts			; 81
				; 82
	swi			; 83
	tap			; 84		HC08
	tpa			; 85		HC08
	pula			; 86		HC08
	psha			; 87		HC08
	pulx			; 88		HC08
	pshx			; 89		HC08
	pulh			; 8A		HC08
	pshh			; 8B		HC08
	clrh			; 8C		HC08
				; 8D 
	stop			; 8E
	wait			; 8F

16$:	bge	16$		; 90 FE		HC08
	blt	16$		; 91 FC		HC08
	bgt	16$		; 92 FA		HC08
	ble	16$		; 93 F8		HC08
	txs			; 94		HC08
	tsx			; 95		HC08
				; 96
	tax			; 97
	clc			; 98
	sec			; 99
	cli			; 9A
	sei			; 9B
	rsp			; 9C
	nop			; 9D 
				; 9E
	txa			; 9F

				
	.page

	sub	#0x21		; A0 21
	cmp	#0x21		; A1 21
	sbc	#0x21		; A2 21
	cpx	#0x21		; A3 21
	and	#0x21		; A4 21
	bit	#0x21		; A5 21
	lda	#0x21		; A6 21
	ais	#0x21		; A7 21		HC08
	eor	#0x21		; A8 21
	adc	#0x21		; A9 21
	ora	#0x21		; AA 21
	add	#0x21		; AB 21
				; AC
17$:	bsr	17$		; AD FE
	ldx	#0x21		; AE 21
	aix	#0x21		; AF 21		HC08

	sub	*loce		; B0 05
	cmp	*loce		; B1 05
	sbc	*loce		; B2 05
	cpx	*loce		; B3 05
	and	*loce		; B4 05
	bit	*loce		; B5 05
	lda	*loce		; B6 05
	sta	*loce		; B7 05
	eor	*loce		; B8 05
	adc	*loce		; B9 05
	ora	*loce		; BA 05
	add	*loce		; BB 05
	jmp	*loce		; BC 05
	jsr	*loce		; BD 05
	ldx	*loce		; BE 05
	stx	*loce		; BF 05

	sub	ext		; C0 01 23
	cmp	ext		; C1 01 23
	sbc	ext		; C2 01 23
	cpx	ext		; C3 01 23
	and	ext		; C4 01 23
	bit	ext		; C5 01 23
	lda	ext		; C6 01 23
	sta	ext		; C7 01 23
	eor	ext		; C8 01 23
	adc	ext		; C9 01 23
	ora	ext		; CA 01 23
	add	ext		; CB 01 23
	jmp	ext		; CC 01 23
	jsr	ext		; CD 01 23
	ldx	ext		; CE 01 23
	stx	ext		; CF 01 23


	.page

	sub	ix2,x		; D0 AB CD
	cmp	ix2,x		; D1 AB CD
	sbc	ix2,x		; D2 AB CD
	cpx	ix2,x		; D3 AB CD
	and	ix2,x		; D4 AB CD
	bit	ix2,x		; D5 AB CD
	lda	ix2,x		; D6 AB CD
	sta	ix2,x		; D7 AB CD
	eor	ix2,x		; D8 AB CD
	adc	ix2,x		; D9 AB CD
	ora	ix2,x		; DA AB CD
	add	ix2,x		; DB AB CD
	jmp	ix2,x		; DC AB CD
	jsr	ix2,x		; DD AB CD
	ldx	ix2,x		; DE AB CD
	stx	ix2,x		; DF AB CD

	sub	ix2,s		; 9E D0 AB CD	HC08
	cmp	ix2,s		; 9E D1 AB CD	HC08
	sbc	ix2,s		; 9E D2 AB CD	HC08
	cpx	ix2,s		; 9E D3 AB CD	HC08
	and	ix2,s		; 9E D4 AB CD	HC08
	bit	ix2,s		; 9E D5 AB CD	HC08
	lda	ix2,s		; 9E D6 AB CD	HC08
	sta	ix2,s		; 9E D7 AB CD	HC08
	eor	ix2,s		; 9E D8 AB CD	HC08
	adc	ix2,s		; 9E D9 AB CD	HC08
	ora	ix2,s		; 9E DA AB CD	HC08
	add	ix2,s		; 9E DB AB CD	HC08
				; 9E DC
				; 9E DD
	ldx	ix2,s		; 9E DE AB CD	HC08
	stx	ix2,s		; 9E DF AB CD	HC08

	sub	ix1,x		; E0 EF
	cmp	ix1,x		; E1 EF
	sbc	ix1,x		; E2 EF
	cpx	ix1,x		; E3 EF
	and	ix1,x		; E4 EF
	bit	ix1,x		; E5 EF
	lda	ix1,x		; E6 EF
	sta	ix1,x		; E7 EF
	eor	ix1,x		; E8 EF
	adc	ix1,x		; E9 EF
	ora	ix1,x		; EA EF
	add	ix1,x		; EB EF
	jmp	ix1,x		; EC EF
	jsr	ix1,x		; ED EF
	ldx	ix1,x		; EE EF
	stx	ix1,x		; EF EF

	sub	ix1,s		; 9E E0 EF	HC08
	cmp	ix1,s		; 9E E1 EF	HC08
	sbc	ix1,s		; 9E E2 EF	HC08
	cpx	ix1,s		; 9E E3 EF	HC08
	and	ix1,s		; 9E E4 EF	HC08
	bit	ix1,s		; 9E E5 EF	HC08
	lda	ix1,s		; 9E E6 EF	HC08
	sta	ix1,s		; 9E E7 EF	HC08
	eor	ix1,s		; 9E E8 EF	HC08
	adc	ix1,s		; 9E E9 EF	HC08
	ora	ix1,s		; 9E EA EF	HC08
	add	ix1,s		; 9E EB EF	HC08
				; 9E EC
				; 9E ED
	ldx	ix1,s		; 9E EE EF	HC08
	stx	ix1,s		; 9E EF EF	HC08

	sub	,x		; F0
	cmp	,x		; F1
	sbc	,x		; F2
	cpx	,x		; F3
	and	,x		; F4
	bit	,x		; F5
	lda	,x		; F6
	sta	,x		; F7
	eor	,x		; F8
	adc	,x		; F9
	ora	,x		; FA
	add	,x		; FB
	jmp	,x		; FC
	jsr	,x		; FD
	ldx	,x		; FE
	stx	,x		; FF


	.page

18$:	jsr	*begin		; BD __
	jmp	*begin		; BC __
	sub	*begin		; B0 __

	.area	AS6808B

19$:	jsr	1$		; CD __ __
20$:	jmp	1$		; CC __ __
21$:	sub	1$		; C0 __ __


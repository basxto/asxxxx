	.title	Test of GB assembler

	offset	=	0x55		;arbitrary constants
	n	=	0x20
	nn	=	0x0584

	a8	=	0x56
	a16	=	0x3412
	d8	=	0x20
	d16	=	0x0584

	; Sequential Assembled Code
	; From - https://gbdev.io/gb-opcodes/optables/

	nop			; 00
	ld	bc,#d16		; 01 84 05
	ld	(bc),a		; 02
	inc	bc		; 03
	inc	b		; 04
	dec	b		; 05
	ld	b,#d8		; 06 20
	rlca			; 07
	ld	(a16),sp	; 08 12 34
	add	hl,bc		; 09
	ld	a,(bc)		; 0A
	dec	bc		; 0B
	inc	c		; 0C
	dec	c		; 0D
	ld	c,#d8		; 0E 20
	rrca			; 0F

	stop			; 10 00
	ld	de,#d16		; 11 84 05
	ld	(de),a		; 12
	inc	de		; 13
	inc	d		; 14
	dec	d		; 15
	ld	d,#d8		; 16 20
	rla			; 17
	jr	.		; 18 FE
	add	hl,de		; 19
	ld	a,(de)		; 1A
	dec	de		; 1B
	inc	e		; 1C
	dec	e		; 1D
	ld	e,#d8		; 1E 20
	rra			; 1F

	jr	nz,.		; 20 FE
	ld	hl,#d16		; 21 84 05
	ld	(hl+),a		; 22
	inc	hl		; 23
	inc	h		; 24
	dec	h		; 25
	ld	h,#d8		; 26 20
	daa			; 27
	jr	z,.		; 28 FE
	add	hl,hl		; 29
	ld	a,(hl+)		; 2A
	dec	hl		; 2B
	inc	l		; 2C
	dec	l		; 2D
	ld	l,#d8		; 2E 20
	cpl			; 2F

	jr	nc,.		; 30 FE
	ld	sp,#d16		; 31 84 05
	ld	(hl-),a		; 32
	inc	sp		; 33
	inc	(hl)		; 34
	dec	(hl)		; 35
	ld	(hl),#d8	; 36 20
	scf			; 37
	jr	c,.		; 38 FE
	add	hl,sp		; 39
	ld	a,(hl-)		; 3A
	dec	sp		; 3B
	inc	a		; 3C
	dec	a		; 3D
	ld	a,#d8		; 3E 20
	ccf			; 3F

	ld	b,b		; 40
	ld	b,c		; 41
	ld	b,d		; 42
	ld	b,e		; 43
	ld	b,h		; 44
	ld	b,l		; 45
	ld	b,(hl)		; 46
	ld	b,a		; 47

	ld	c,b		; 48
	ld	c,c		; 49
	ld	c,d		; 4A
	ld	c,e		; 4B
	ld	c,h		; 4C
	ld	c,l		; 4D
	ld	c,(hl)		; 4E
	ld	c,a		; 4F

	ld	d,b		; 50
	ld	d,c		; 51
	ld	d,d		; 52
	ld	d,e		; 53
	ld	d,h		; 54
	ld	d,l		; 55
	ld	d,(hl)		; 56
	ld	d,a		; 57

	ld	e,b		; 58
	ld	e,c		; 59
	ld	e,d		; 5A
	ld	e,e		; 5B
	ld	e,h		; 5C
	ld	e,l		; 5D
	ld	e,(hl)		; 5E
	ld	e,a		; 5F

	ld	h,b		; 60
	ld	h,c		; 61
	ld	h,d		; 62
	ld	h,e		; 63
	ld	h,h		; 64
	ld	h,l		; 65
	ld	h,(hl)		; 66
	ld	h,a		; 67

	ld	l,b		; 68
	ld	l,c		; 69
	ld	l,d		; 6A
	ld	l,e		; 6B
	ld	l,h		; 6C
	ld	l,l		; 6D
	ld	l,(hl)		; 6E
	ld	l,a		; 6F

	ld	(hl),b		; 70
	ld	(hl),c		; 71
	ld	(hl),d		; 72
	ld	(hl),e		; 73
	ld	(hl),h		; 74
	ld	(hl),l		; 75
	halt			; 76
	ld	(hl),a		; 77

	ld	a,b		; 78
	ld	a,c		; 79
	ld	a,d		; 7A
	ld	a,e		; 7B
	ld	a,h		; 7C
	ld	a,l		; 7D
	ld	a,(hl)		; 7E
	ld	a,a		; 7F

	add	a,b		; 80
	add	a,c		; 81
	add	a,d		; 82
	add	a,e		; 83
	add	a,h		; 84
	add	a,l		; 85
	add	a,(hl)		; 86
	add	a,a		; 87

	adc	a,b		; 88
	adc	a,c		; 89
	adc	a,d		; 8A
	adc	a,e		; 8B
	adc	a,h		; 8C
	adc	a,l		; 8D
	adc	a,(hl)		; 8E
	adc	a,a		; 8F

	sub	a,b		; 90
	sub	a,c		; 91
	sub	a,d		; 92
	sub	a,e		; 93
	sub	a,h		; 94
	sub	a,l		; 95
	sub	a,(hl)		; 96
	sub	a,a		; 97

	sbc	a,b		; 98
	sbc	a,c		; 99
	sbc	a,d		; 9A
	sbc	a,e		; 9B
	sbc	a,h		; 9C
	sbc	a,l		; 9D
	sbc	a,(hl)		; 9E
	sbc	a,a		; 9F

	and	a,b		; A0
	and	a,c		; A1
	and	a,d		; A2
	and	a,e		; A3
	and	a,h		; A4
	and	a,l		; A5
	and	a,(hl)		; A6
	and	a,a		; A7

	xor	a,b		; A8
	xor	a,c		; A9
	xor	a,d		; AA
	xor	a,e		; AB
	xor	a,h		; AC
	xor	a,l		; AD
	xor	a,(hl)		; AE
	xor	a,a		; AF

	or	a,b		; B0
	or	a,c		; B1
	or	a,d		; B2
	or	a,e		; B3
	or	a,h		; B4
	or	a,l		; B5
	or	a,(hl)		; B6
	or	a,a		; B7

	cp	a,b		; B8
	cp	a,c		; B9
	cp	a,d		; BA
	cp	a,e		; BB
	cp	a,h		; BC
	cp	a,l		; BD
	cp	a,(hl)		; BE
	cp	a,a		; BF

	ret	nz		; C0
	pop	bc		; C1
	jp	nz,a16		; C2 12 34
	jp	a16		; C3 12 34
	call	nz,a16		; C4 12 34
	push	bc		; C5
	add	a,#d8		; C6 20
	rst	0x00		; C7
	ret	z		; C8
	ret			; C9
	jp	z,a16		; CA 12 34
	; CB Is The Page Prefix	; CB
	call	z,a16		; CC 12 34
	call	a16		; CD 12 34
	adc	a,#d8		; CE 20
	rst	0x08		; CF

	ret	nc		; D0
	pop	de		; D1
	jp	nc,a16		; D2 12 34
	; ---			; D3
	call	nc,a16		; D4 12 34
	push	de		; D5
	sub	a,#d8		; D6 20
	rst	0x10		; D7
	ret	c		; D8
	reti			; D9
	jp	c,a16		; DA 12 34
	; ---			; DB
	call	c,a16		; DC 12 34
	; ---			; DD
	sbc	a,#d8		; DE 20
	rst	0x18		; DF

	ldh	(a8),a		; E0 56
	pop	hl		; E1
	ld	(c),a		; E2
	; ---			; E3
	; ---			; E4
	push	hl		; E5
	and	a,#d8		; E6 20
	rst	0x20		; E7
	add	sp,#d8		; E8 20
	jp	(hl)		; E9
	ld	(a16),a		; EA 12 34
	; ---			; EB
	; ---			; EC
	; ---			; ED
	xor	a,#d8		; EE 20
	rst	0x28		; EF

	ldh	a,(a8)		; F0 56
	pop	af		; F1
	ld	a,(c)		; F2
	di			; F3
	; ---			; F4
	push	af		; F5
	or	a,#d8		; F6 20
	rst	0x30		; F7
	ld	hl,sp+d8	; F8 20
	ld	sp,hl		; F9
	ld	a,(a16)		; FA 12 34
	ei			; FB
	; ---			; FC
	; ---			; FD
	cp	a,#d8		; FE 20
	rst	0x38		; FF

	; 0xCB Page Instructions

	rlc	b		; CB 00
	rlc	c		; CB 01
	rlc	d		; CB 02
	rlc	e		; CB 03
	rlc	h		; CB 04
	rlc	l		; CB 05
	rlc	(hl)		; CB 06
	rlc	a		; CB 07

	rrc	b		; CB 08
	rrc	c		; CB 09
	rrc	d		; CB 0A
	rrc	e		; CB 0B
	rrc	h		; CB 0C
	rrc	l		; CB 0D
	rrc	(hl)		; CB 0E
	rrc	a		; CB 0F

	rl	b		; CB 10
	rl	c		; CB 11
	rl	d		; CB 12
	rl	e		; CB 13
	rl	h		; CB 14
	rl	l		; CB 15
	rl	(hl)		; CB 16
	rl	a		; CB 17

	rr	b		; CB 18
	rr	c		; CB 19
	rr	d		; CB 1A
	rr	e		; CB 1B
	rr	h		; CB 1C
	rr	l		; CB 1D
	rr	(hl)		; CB 1E
	rr	a		; CB 1F

	sla	b		; CB 20
	sla	c		; CB 21
	sla	d		; CB 22
	sla	e		; CB 23
	sla	h		; CB 24
	sla	l		; CB 25
	sla	(hl)		; CB 26
	sla	a		; CB 27

	sra	b		; CB 28
	sra	c		; CB 29
	sra	d		; CB 2A
	sra	e		; CB 2B
	sra	h		; CB 2C
	sra	l		; CB 2D
	sra	(hl)		; CB 2E
	sra	a		; CB 2F

	swap	b		; CB 30
	swap	c		; CB 31
	swap	d		; CB 32
	swap	e		; CB 33
	swap	h		; CB 34
	swap	l		; CB 35
	swap	(hl)		; CB 36
	swap	a		; CB 37

	srl	b		; CB 38
	srl	c		; CB 39
	srl	d		; CB 3A
	srl	e		; CB 3B
	srl	h		; CB 3C
	srl	l		; CB 3D
	srl	(hl)		; CB 3E
	srl	a		; CB 3F

	bit	0,b		; CB 40
	bit	0,c		; CB 41
	bit	0,d		; CB 42
	bit	0,e		; CB 43
	bit	0,h		; CB 44
	bit	0,l		; CB 45
	bit	0,(hl)		; CB 46
	bit	0,a		; CB 47

	bit	1,b		; CB 48
	bit	1,c		; CB 49
	bit	1,d		; CB 4A
	bit	1,e		; CB 4B
	bit	1,h		; CB 4C
	bit	1,l		; CB 4D
	bit	1,(hl)		; CB 4E
	bit	1,a		; CB 4F

	bit	2,b		; CB 50
	bit	2,c		; CB 51
	bit	2,d		; CB 52
	bit	2,e		; CB 53
	bit	2,h		; CB 54
	bit	2,l		; CB 55
	bit	2,(hl)		; CB 56
	bit	2,a		; CB 57

	bit	3,b		; CB 58
	bit	3,c		; CB 59
	bit	3,d		; CB 5A
	bit	3,e		; CB 5B
	bit	3,h		; CB 5C
	bit	3,l		; CB 5D
	bit	3,(hl)		; CB 5E
	bit	3,a		; CB 5F

	bit	4,b		; CB 60
	bit	4,c		; CB 61
	bit	4,d		; CB 62
	bit	4,e		; CB 63
	bit	4,h		; CB 64
	bit	4,l		; CB 65
	bit	4,(hl)		; CB 66
	bit	4,a		; CB 67

	bit	5,b		; CB 68
	bit	5,c		; CB 69
	bit	5,d		; CB 6A
	bit	5,e		; CB 6B
	bit	5,h		; CB 6C
	bit	5,l		; CB 6D
	bit	5,(hl)		; CB 6E
	bit	5,a		; CB 6F

	bit	6,b		; CB 70
	bit	6,c		; CB 71
	bit	6,d		; CB 72
	bit	6,e		; CB 73
	bit	6,h		; CB 74
	bit	6,l		; CB 75
	bit	6,(hl)		; CB 76
	bit	6,a		; CB 77

	bit	7,b		; CB 78
	bit	7,c		; CB 79
	bit	7,d		; CB 7A
	bit	7,e		; CB 7B
	bit	7,h		; CB 7C
	bit	7,l		; CB 7D
	bit	7,(hl)		; CB 7E
	bit	7,a		; CB 7F

	res	0,b		; CB 80
	res	0,c		; CB 81
	res	0,d		; CB 82
	res	0,e		; CB 83
	res	0,h		; CB 84
	res	0,l		; CB 85
	res	0,(hl)		; CB 86
	res	0,a		; CB 87

	res	1,b		; CB 88
	res	1,c		; CB 89
	res	1,d		; CB 8A
	res	1,e		; CB 8B
	res	1,h		; CB 8C
	res	1,l		; CB 8D
	res	1,(hl)		; CB 8E
	res	1,a		; CB 8F

	res	2,b		; CB 90
	res	2,c		; CB 91
	res	2,d		; CB 92
	res	2,e		; CB 93
	res	2,h		; CB 94
	res	2,l		; CB 95
	res	2,(hl)		; CB 96
	res	2,a		; CB 97

	res	3,b		; CB 98
	res	3,c		; CB 99
	res	3,d		; CB 9A
	res	3,e		; CB 9B
	res	3,h		; CB 9C
	res	3,l		; CB 9D
	res	3,(hl)		; CB 9E
	res	3,a		; CB 9F

	res	4,b		; CB A0
	res	4,c		; CB A1
	res	4,d		; CB A2
	res	4,e		; CB A3
	res	4,h		; CB A4
	res	4,l		; CB A5
	res	4,(hl)		; CB A6
	res	4,a		; CB A7

	res	5,b		; CB A8
	res	5,c		; CB A9
	res	5,d		; CB AA
	res	5,e		; CB AB
	res	5,h		; CB AC
	res	5,l		; CB AD
	res	5,(hl)		; CB AE
	res	5,a		; CB AF

	res	6,b		; CB B0
	res	6,c		; CB B1
	res	6,d		; CB B2
	res	6,e		; CB B3
	res	6,h		; CB B4
	res	6,l		; CB B5
	res	6,(hl)		; CB B6
	res	6,a		; CB B7

	res	7,b		; CB B8
	res	7,c		; CB B9
	res	7,d		; CB BA
	res	7,e		; CB BB
	res	7,h		; CB BC
	res	7,l		; CB BD
	res	7,(hl)		; CB BE
	res	7,a		; CB BF

	set	0,b		; CB C0
	set	0,c		; CB C1
	set	0,d		; CB C2
	set	0,e		; CB C3
	set	0,h		; CB C4
	set	0,l		; CB C5
	set	0,(hl)		; CB C6
	set	0,a		; CB C7

	set	1,b		; CB C8
	set	1,c		; CB C9
	set	1,d		; CB CA
	set	1,e		; CB CB
	set	1,h		; CB CC
	set	1,l		; CB CD
	set	1,(hl)		; CB CE
	set	1,a		; CB CF

	set	2,b		; CB D0
	set	2,c		; CB D1
	set	2,d		; CB D2
	set	2,e		; CB D3
	set	2,h		; CB D4
	set	2,l		; CB D5
	set	2,(hl)		; CB D6
	set	2,a		; CB D7

	set	3,b		; CB D8
	set	3,c		; CB D9
	set	3,d		; CB DA
	set	3,e		; CB DB
	set	3,h		; CB DC
	set	3,l		; CB DD
	set	3,(hl)		; CB DE
	set	3,a		; CB DF

	set	4,b		; CB E0
	set	4,c		; CB E1
	set	4,d		; CB E2
	set	4,e		; CB E3
	set	4,h		; CB E4
	set	4,l		; CB E5
	set	4,(hl)		; CB E6
	set	4,a		; CB E7

	set	5,b		; CB E8
	set	5,c		; CB E9
	set	5,d		; CB EA
	set	5,e		; CB EB
	set	5,h		; CB EC
	set	5,l		; CB ED
	set	5,(hl)		; CB EE
	set	5,a		; CB EF

	set	6,b		; CB F0
	set	6,c		; CB F1
	set	6,d		; CB F2
	set	6,e		; CB F3
	set	6,h		; CB F4
	set	6,l		; CB F5
	set	6,(hl)		; CB F6
	set	6,a		; CB F7

	set	7,b		; CB F8
	set	7,c		; CB F9
	set	7,d		; CB FA
	set	7,e		; CB FB
	set	7,h		; CB FC
	set	7,l		; CB FD
	set	7,(hl)		; CB FE
	set	7,a		; CB FF

	; notes:
	;	Leading 'a' operand is optional.

	ld	(bc)		; 0A

	ld	(de)		; 1A

	ld	(hl+)		; 2A

	ld	(hl-)		; 3A
	ld	#d8		; 3E 20
	ld	b		; 78
	ld	c		; 79
	ld	d		; 7A
	ld	e		; 7B
	ld	h		; 7C
	ld	l		; 7D
	ld	(hl)		; 7E
	ld	a		; 7F

	add	b		; 80
	add	c		; 81
	add	d		; 82
	add	e		; 83
	add	h		; 84
	add	l		; 85
	add	(hl)		; 86
	add	a		; 87

	adc	b		; 88
	adc	c		; 89
	adc	d		; 8A
	adc	e		; 8B
	adc	h		; 8C
	adc	l		; 8D
	adc	(hl)		; 8E
	adc	a		; 8F

	sub	b		; 90
	sub	c		; 91
	sub	d		; 92
	sub	e		; 93
	sub	h		; 94
	sub	l		; 95
	sub	(hl)		; 96
	sub	a		; 97

	sbc	b		; 98
	sbc	c		; 99
	sbc	d		; 9A
	sbc	e		; 9B
	sbc	h		; 9C
	sbc	l		; 9D
	sbc	(hl)		; 9E
	sbc	a		; 9F

	and	b		; A0
	and	c		; A1
	and	d		; A2
	and	e		; A3
	and	h		; A4
	and	l		; A5
	and	(hl)		; A6
	and	a		; A7

	xor	b		; A8
	xor	c		; A9
	xor	d		; AA
	xor	e		; AB
	xor	h		; AC
	xor	l		; AD
	xor	(hl)		; AE
	xor	a		; AF

	or	b		; B0
	or	c		; B1
	or	d		; B2
	or	e		; B3
	or	h		; B4
	or	l		; B5
	or	(hl)		; B6
	or	a		; B7

	cp	b		; B8
	cp	c		; B9
	cp	d		; BA
	cp	e		; BB
	cp	h		; BC
	cp	l		; BD
	cp	(hl)		; BE
	cp	a		; BF

	add	#d8		; C6 20
	adc	#d8		; CE 20

	sub	#d8		; D6 20
	sbc	#d8		; DE 20

	and	#d8		; E6 20
	xor	#d8		; EE 20

	ld	(c)		; F2
	or	#d8		; F6 20
	ld	(a16)		; FA 12 34
	cp	#d8		; FE 20

	; notes:
	;	Leading 'a' operand is optional.
	;	If offset is ommitted 0 is assumed.

	;***********************************************************
	; add with carry to 'a'
	adc	a,(hl)			;8E
	adc	a,a			;8F
	adc	a,b			;88
	adc	a,c			;89
	adc	a,d			;8A
	adc	a,e			;8B
	adc	a,h			;8C
	adc	a,l			;8D
	adc	a,#n			;CE 20
	;***********************************************************
	adc	(hl)			;8E
	adc	a			;8F
	adc	b			;88
	adc	c			;89
	adc	d			;8A
	adc	e			;8B
	adc	h			;8C
	adc	l			;8D
	adc	#n			;CE 20
	;***********************************************************
	; add operand to 'a'
	add	a,(hl)			;86
	add	a,a			;87
	add	a,b			;80
	add	a,c			;81
	add	a,d			;82
	add	a,e			;83
	add	a,h			;84
	add	a,l			;85
	add	a,#n			;C6 20
	;***********************************************************
	; add register pair to 'hl'
	add	hl,bc			;09
	add	hl,de			;19
	add	hl,hl			;29
	add	hl,sp			;39
	;***********************************************************
	; Add to stack pointer
	add	sp,#n			;E8 20
	;***********************************************************
	; logical 'and' operand with 'a'
	and	a,(hl)			;A6
	and	a,a			;A7
	and	a,b			;A0
	and	a,c			;A1
	and	a,d			;A2
	and	a,e			;A3
	and	a,h			;A4
	and	a,l			;A5
	and	a,#n			;E6 20
	;***********************************************************
	; test bit of location or register
	bit	0,(hl)			;CB 46
	bit	0,a			;CB 47
	bit	0,b			;CB 40
	bit	0,c			;CB 41
	bit	0,d			;CB 42
	bit	0,e			;CB 43
	bit	0,h			;CB 44
	bit	0,l			;CB 45
	bit	1,(hl)			;CB 4E
	bit	1,a			;CB 4F
	bit	1,b			;CB 48
	bit	1,c			;CB 49
	bit	1,d			;CB 4A
	bit	1,e			;CB 4B
	bit	1,h			;CB 4C
	bit	1,l			;CB 4D
	bit	2,(hl)			;CB 56
	bit	2,a			;CB 57
	bit	2,b			;CB 50
	bit	2,c			;CB 51
	bit	2,d			;CB 52
	bit	2,e			;CB 53
	bit	2,h			;CB 54
	bit	2,l			;CB 55
	bit	3,(hl)			;CB 5E
	bit	3,a			;CB 5F
	bit	3,b			;CB 58
	bit	3,c			;CB 59
	bit	3,d			;CB 5A
	bit	3,e			;CB 5B
	bit	3,h			;CB 5C
	bit	3,l			;CB 5D
	bit	4,(hl)			;CB 66
	bit	4,a			;CB 67
	bit	4,b			;CB 60
	bit	4,c			;CB 61
	bit	4,d			;CB 62
	bit	4,e			;CB 63
	bit	4,h			;CB 64
	bit	4,l			;CB 65
	bit	5,(hl)			;CB 6E
	bit	5,a			;CB 6F
	bit	5,b			;CB 68
	bit	5,c			;CB 69
	bit	5,d			;CB 6A
	bit	5,e			;CB 6B
	bit	5,h			;CB 6C
	bit	5,l			;CB 6D
	bit	6,(hl)			;CB 76
	bit	6,a			;CB 77
	bit	6,b			;CB 70
	bit	6,c			;CB 71
	bit	6,d			;CB 72
	bit	6,e			;CB 73
	bit	6,h			;CB 74
	bit	6,l			;CB 75
	bit	7,(hl)			;CB 7E
	bit	7,a			;CB 7F
	bit	7,b			;CB 78
	bit	7,c			;CB 79
	bit	7,d			;CB 7A
	bit	7,e			;CB 7B
	bit	7,h			;CB 7C
	bit	7,l			;CB 7D
	;***********************************************************
	; call subroutine at nn if condition is true
	call	C,nn			;DC 84 05
	call	NC,nn			;D4 84 05
	call	NZ,nn			;C4 84 05
	call	Z,nn			;CC 84 05
	;***********************************************************
	; unconditional call to subroutine at nn
	call	nn			;CD 84 05
	;***********************************************************
	; complement carry flag
	ccf				;3F
	;***********************************************************
	; compare operand with 'a'
	cp	a,(hl)			;BE
	cp	a,a			;BF
	cp	a,b			;B8
	cp	a,c			;B9
	cp	a,d			;BA
	cp	a,e			;BB
	cp	a,h			;BC
	cp	a,l			;BD
	cp	a,#n			;FE 20
	;***********************************************************
	; 1's complement of 'a'
	cpl				;2F
	;***********************************************************
	; decimal adjust 'a'
	daa				;27
	;***********************************************************
	; decrement operand
	dec	(hl)			;35
	dec	a			;3D
	dec	b			;05
	dec	bc			;0B
	dec	c			;0D
	dec	d			;15
	dec	de			;1B
	dec	e			;1D
	dec	h			;25
	dec	hl			;2B
	dec	l			;2D
	dec	sp			;3B
	;***********************************************************
	; disable interrupts
	di				;F3
	;***********************************************************
	; enable interrupts
	ei				;FB
	;***********************************************************
	; halt (wait for interrupt or reset)
	halt				;76
	;***********************************************************
	; load 'a' with input from device n or c
	in	a,(n)			;F0 20
	in	a,(c)			;F2
	; alternates
	ldh	a,(n)			;F0 20
	ldh	a,(c)			;F2
	ld	a,(c)			;F2
	;***********************************************************
	; increment operand
	inc	(hl)			;34
	inc	a			;3C
	inc	b			;04
	inc	bc			;03
	inc	c			;0C
	inc	d			;14
	inc	de			;13
	inc	e			;1C
	inc	h			;24
	inc	hl			;23
	inc	l			;2C
	inc	sp			;33
	;***********************************************************
	; unconditional jump to location nn
	jp	nn			;C3 84 05
	jp	(hl)			;E9
	;***********************************************************
	; jump to location if condition is true
	jp	C,nn			;DA 84 05
	jp	NC,nn			;D2 84 05
	jp	NZ,nn			;C2 84 05
	jp	Z,nn			;CA 84 05
	;***********************************************************
	; unconditional jump relative to PC+e
	jr	jr1+0x10		;18 10
	;***********************************************************
	; jump relative to PC+e if condition is true
jr1:	jr	C,jr2+0x10		;38 10
jr2:	jr	NC,jr3+0x10		;30 10
jr3:	jr	NZ,jr4+0x10		;20 10
jr4:	jr	Z,jr5+0x10		;28 10
jr5:
	;***********************************************************
	; load source to destination
	ld	a,(hl)			;7E
	ld	a,a			;7F
	ld	a,b			;78
	ld	a,c			;79
	ld	a,d			;7A
	ld	a,e			;7B
	ld	a,h			;7C
	ld	a,l			;7D
	ld	a,#n			;3E 20
	ld	b,(hl)			;46
	ld	b,a			;47
	ld	b,b			;40
	ld	b,c			;41
	ld	b,d			;42
	ld	b,e			;43
	ld	b,h			;44
	ld	b,l			;45
	ld	b,#n			;06 20
	ld	c,(hl)			;4E
	ld	c,a			;4F
	ld	c,b			;48
	ld	c,c			;49
	ld	c,d			;4A
	ld	c,e			;4B
	ld	c,h			;4C
	ld	c,l			;4D
	ld	c,#n			;0E 20
	ld	d,(hl)			;56
	ld	d,a			;57
	ld	d,b			;50
	ld	d,c			;51
	ld	d,d			;52
	ld	d,e			;53
	ld	d,h			;54
	ld	d,l			;55
	ld	d,#n			;16 20
	ld	e,(hl)			;5E
	ld	e,a			;5F
	ld	e,b			;58
	ld	e,c			;59
	ld	e,d			;5A
	ld	e,e			;5B
	ld	e,h			;5C
	ld	e,l			;5D
	ld	e,#n			;1E 20
	ld	h,(hl)			;66
	ld	h,a			;67
	ld	h,b			;60
	ld	h,c			;61
	ld	h,d			;62
	ld	h,e			;63
	ld	h,h			;64
	ld	h,l			;65
	ld	h,#n			;26 20
	ld	l,(hl)			;6E
	ld	l,a			;6F
	ld	l,b			;68
	ld	l,c			;69
	ld	l,d			;6A
	ld	l,e			;6B
	ld	l,h			;6C
	ld	l,l			;6D
	ld	l,#n			;2E 20
	;***********************************************************
	ld	(bc),a			;02
	ld	(de),a			;12
	ld	a,(bc)			;0A
	ld	a,(de)			;1A
	;***********************************************************
	ld	(hl),a			;77
	ld	(hl),b			;70
	ld	(hl),c			;71
	ld	(hl),d			;72
	ld	(hl),e			;73
	ld	(hl),h			;74
	ld	(hl),l			;75
	ld	(hl),#n			;36 20
	;***********************************************************
	ld	(nn),a			;EA 84 05
	ld	(nn),sp			;08 84 05
	;***********************************************************
	ld	a,(nn)			;FA 84 05
	;***********************************************************
	ld	bc,#nn			;01 84 05
	ld	de,#nn			;11 84 05
	ld	hl,#nn			;21 84 05
	ld	sp,#nn			;31 84 05
	; alternates
	ldhl	#nn			;21 84 05
	;***********************************************************
	ld	sp,hl			;F9
	ld	hl,sp			;F8 00
	ld	hl,sp+offset		;F8 55
	; alternates
	ldhl	sp			;F8 00
	ldhl	sp+offset		;F8 55
	;***********************************************************
	; load via (hl) then decrement hl
	ld	a,(hld)			;3A
	ld	(hld),a			;32
	; alternates
	ldd	a,(hl)			;3A
	ldd	(hl),a			;32
	;***********************************************************
	; load via (hl) then increment hl
	ld	a,(hli)			;2A
	ld	(hli),a			;22
	; alternates
	ldi	a,(hl)			;2A
	ldi	(hl),a			;22
	;***********************************************************
	; load 'a' with input from device c
	ld	a,(c)			;F2
	; alternates
	ldh	a,(c)			;F2
	in	a,(c)			;F2
	;***********************************************************
	; load output port (c) with 'a'
	ld	(c),a			;E2
	; alternates
	ldh	(c),a			;E2
	out	(c),a			;E2
	;***********************************************************
	; no operation
	nop				;00
	;***********************************************************
	; logical 'or' operand with 'a'
	or	a,(hl)			;B6
	or	a,a			;B7
	or	a,b			;B0
	or	a,c			;B1
	or	a,d			;B2
	or	a,e			;B3
	or	a,h			;B4
	or	a,l			;B5
	or	a,#n			;F6 20
	;***********************************************************
	; load output port (c) or (n) with 'a'
	out	(c),a			;E2
	out	(n),a			;E0 20
	; alternates
	ldh	(c),a			;E2
	ld	(c),a			;E2
	ldh	(n),a			;E0 20
	;***********************************************************
	; load destination with top of stack
	pop	af			;F1
	pop	bc			;C1
	pop	de			;D1
	pop	hl			;E1
	;***********************************************************
	; put source on stack
	push	af			;F5
	push	bc			;C5
	push	de			;D5
	push	hl			;E5
	;***********************************************************
	; reset bit of location or register
	res	0,(hl)			;CB 86
	res	0,a			;CB 87
	res	0,b			;CB 80
	res	0,c			;CB 81
	res	0,d			;CB 82
	res	0,e			;CB 83
	res	0,h			;CB 84
	res	0,l			;CB 85
	res	1,(hl)			;CB 8E
	res	1,a			;CB 8F
	res	1,b			;CB 88
	res	1,c			;CB 89
	res	1,d			;CB 8A
	res	1,e			;CB 8B
	res	1,h			;CB 8C
	res	1,l			;CB 8D
	res	2,(hl)			;CB 96
	res	2,a			;CB 97
	res	2,b			;CB 90
	res	2,c			;CB 91
	res	2,d			;CB 92
	res	2,e			;CB 93
	res	2,h			;CB 94
	res	2,l			;CB 95
	res	3,(hl)			;CB 9E
	res	3,a			;CB 9F
	res	3,b			;CB 98
	res	3,c			;CB 99
	res	3,d			;CB 9A
	res	3,e			;CB 9B
	res	3,h			;CB 9C
	res	3,l			;CB 9D
	res	4,(hl)			;CB A6
	res	4,a			;CB A7
	res	4,b			;CB A0
	res	4,c			;CB A1
	res	4,d			;CB A2
	res	4,e			;CB A3
	res	4,h			;CB A4
	res	4,l			;CB A5
	res	5,(hl)			;CB AE
	res	5,a			;CB AF
	res	5,b			;CB A8
	res	5,c			;CB A9
	res	5,d			;CB AA
	res	5,e			;CB AB
	res	5,h			;CB AC
	res	5,l			;CB AD
	res	6,(hl)			;CB B6
	res	6,a			;CB B7
	res	6,b			;CB B0
	res	6,c			;CB B1
	res	6,d			;CB B2
	res	6,e			;CB B3
	res	6,h			;CB B4
	res	6,l			;CB B5
	res	7,(hl)			;CB BE
	res	7,a			;CB BF
	res	7,b			;CB B8
	res	7,c			;CB B9
	res	7,d			;CB BA
	res	7,e			;CB BB
	res	7,h			;CB BC
	res	7,l			;CB BD
	;***********************************************************
	; return from subroutine
	ret				;C9
	;***********************************************************
	; return from subroutine if condition is true
	ret	C			;D8
	ret	NC			;D0
	ret	NZ			;C0
	ret	Z			;C8
	;***********************************************************
	; return from interrupt
	reti				;D9
	;***********************************************************
	; rotate left through carry
	rl	a,(hl)			;CB 16
	rl	a,a			;CB 17
	rl	a,b			;CB 10
	rl	a,c			;CB 11
	rl	a,d			;CB 12
	rl	a,e			;CB 13
	rl	a,h			;CB 14
	rl	a,l			;CB 15
	;***********************************************************
	; rotate left 'a' with carry
	rla				;17
	;***********************************************************
	; rotate left circular
	rlc	a,(hl)			;CB 06
	rlc	a,a			;CB 07
	rlc	a,b			;CB 00
	rlc	a,c			;CB 01
	rlc	a,d			;CB 02
	rlc	a,e			;CB 03
	rlc	a,h			;CB 04
	rlc	a,l			;CB 05
	;***********************************************************
	; rotate left 'a' circular
	rlca				;07
	;***********************************************************
	; rotate right through carry
	rr	a,(hl)			;CB 1E
	rr	a,a			;CB 1F
	rr	a,b			;CB 18
	rr	a,c			;CB 19
	rr	a,d			;CB 1A
	rr	a,e			;CB 1B
	rr	a,h			;CB 1C
	rr	a,l			;CB 1D
	;***********************************************************
	; rotate 'a' right with carry
	rra				;1F
	;***********************************************************
	; rotate right circular
	rrc	a,(hl)			;CB 0E
	rrc	a,a			;CB 0F
	rrc	a,b			;CB 08
	rrc	a,c			;CB 09
	rrc	a,d			;CB 0A
	rrc	a,e			;CB 0B
	rrc	a,h			;CB 0C
	rrc	a,l			;CB 0D
	;***********************************************************
	; rotate 'a' right circular
	rrca				;0F
	;***********************************************************
	; restart location
	rst	0x00			;C7
	rst	0x08			;CF
	rst	0x10			;D7
	rst	0x18			;DF
	rst	0x20			;E7
	rst	0x28			;EF
	rst	0x30			;F7
	rst	0x38			;FF
	;***********************************************************
	; subtract with carry to 'a'
	sbc	a,(hl)			;9E
	sbc	a,a			;9F
	sbc	a,b			;98
	sbc	a,c			;99
	sbc	a,d			;9A
	sbc	a,e			;9B
	sbc	a,h			;9C
	sbc	a,l			;9D
	sbc	a,#n			;DE 20
	;***********************************************************
	; set carry flag (C=1)
	scf				;37
	;***********************************************************
	; set bit of location or register
	set	0,(hl)			;CB C6
	set	0,a			;CB C7
	set	0,b			;CB C0
	set	0,c			;CB C1
	set	0,d			;CB C2
	set	0,e			;CB C3
	set	0,h			;CB C4
	set	0,l			;CB C5
	set	1,(hl)			;CB CE
	set	1,a			;CB CF
	set	1,b			;CB C8
	set	1,c			;CB C9
	set	1,d			;CB CA
	set	1,e			;CB CB
	set	1,h			;CB CC
	set	1,l			;CB CD
	set	2,(hl)			;CB D6
	set	2,a			;CB D7
	set	2,b			;CB D0
	set	2,c			;CB D1
	set	2,d			;CB D2
	set	2,e			;CB D3
	set	2,h			;CB D4
	set	2,l			;CB D5
	set	3,(hl)			;CB DE
	set	3,a			;CB DF
	set	3,b			;CB D8
	set	3,c			;CB D9
	set	3,d			;CB DA
	set	3,e			;CB DB
	set	3,h			;CB DC
	set	3,l			;CB DD
	set	4,(hl)			;CB E6
	set	4,a			;CB E7
	set	4,b			;CB E0
	set	4,c			;CB E1
	set	4,d			;CB E2
	set	4,e			;CB E3
	set	4,h			;CB E4
	set	4,l			;CB E5
	set	5,(hl)			;CB EE
	set	5,a			;CB EF
	set	5,b			;CB E8
	set	5,c			;CB E9
	set	5,d			;CB EA
	set	5,e			;CB EB
	set	5,h			;CB EC
	set	5,l			;CB ED
	set	6,(hl)			;CB F6
	set	6,a			;CB F7
	set	6,b			;CB F0
	set	6,c			;CB F1
	set	6,d			;CB F2
	set	6,e			;CB F3
	set	6,h			;CB F4
	set	6,l			;CB F5
	set	7,(hl)			;CB FE
	set	7,a			;CB FF
	set	7,b			;CB F8
	set	7,c			;CB F9
	set	7,d			;CB FA
	set	7,e			;CB FB
	set	7,h			;CB FC
	set	7,l			;CB FD
	;***********************************************************
	; shift operand left arithmetic
	sla	a,(hl)			;CB 26
	sla	a,a			;CB 27
	sla	a,b			;CB 20
	sla	a,c			;CB 21
	sla	a,d			;CB 22
	sla	a,e			;CB 23
	sla	a,h			;CB 24
	sla	a,l			;CB 25
	;***********************************************************
	; shift operand right arithmetic
	sra	a,(hl)			;CB 2E
	sra	a,a			;CB 2F
	sra	a,b			;CB 28
	sra	a,c			;CB 29
	sra	a,d			;CB 2A
	sra	a,e			;CB 2B
	sra	a,h			;CB 2C
	sra	a,l			;CB 2D
	;***********************************************************
	; shift operand right logical
	srl	a,(hl)			;CB 3E
	srl	a,a			;CB 3F
	srl	a,b			;CB 38
	srl	a,c			;CB 39
	srl	a,d			;CB 3A
	srl	a,e			;CB 3B
	srl	a,h			;CB 3C
	srl	a,l			;CB 3D
	;***********************************************************
	; Go to sleep; everything stops. How do you get out?
	stop				;10 00
	;***********************************************************
	; subtract operand from 'a'
	sub	a,(hl)			;96
	sub	a,a			;97
	sub	a,b			;90
	sub	a,c			;91
	sub	a,d			;92
	sub	a,e			;93
	sub	a,h			;94
	sub	a,l			;95
	sub	a,#n			;D6 20
	;***********************************************************
	; swap nybbles
	swap	(hl)			;CB 36
	swap	a			;CB 37
	swap	b			;CB 30
	swap	c			;CB 31
	swap	d			;CB 32
	swap	e			;CB 33
	swap	h			;CB 34
	swap	l			;CB 35
	;***********************************************************
	; logical 'xor' operand with 'a'
	xor	a,(hl)			;AE
	xor	a,a			;AF
	xor	a,b			;A8
	xor	a,c			;A9
	xor	a,d			;AA
	xor	a,e			;AB
	xor	a,h			;AC
	xor	a,l			;AD
	xor	a,#n			;EE 20
	;***********************************************************
	; pseudo-op to help build characters
	.tile " .+*0123"		;55 33
	.tile " .+*0123 .+*0123"	;55 33 55 33



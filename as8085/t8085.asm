	.title	Test of 8085/8080 Assembler
	.sbttl	All 8085/8080 instructions

	aci	#1		;ce 01

	adc	b		;88
	adc	m		;8e

	add	c		;81
	add	m		;86

	adi	#2		;c6 02

	ana	d		;a2
	ana	m		;a6

	ani	#3		;e6 03

	call	next1		;cd 27 00

	cc	next1		;dc 27 00

	cm	next1		;fc 27 00

	cnc	next1		;d4 27 00

	cnz	next1		;c4 27 00

	cp	next1		;f4 27 00

	cpe	next1		;ec 27 00

	cpo	next1		;e4 27 00

	cz	next1		;cc 27 00

next1:

	cma			;2f

	cmc			;3f

	cmp	e		;bb
	cmp	m		;be

	cpi	#4		;fe 04

	daa			;27

	dad	b		;09

	dcr	a		;3d
	dcr	m		;35

	dcx	b		;0b

	di			;f3

	ei			;fb

	hlt			;76

	in	#5		;db 05

	inr	a		;3c
	inr	m		;34

	inx	h		;23

	jc	jmpadr		;da 55 00

	jm	jmpadr		;fa 55 00

	jmp	jmpadr		;c3 55 00

	jnc	jmpadr		;d2 55 00

	jnz	jmpadr		;c2 55 00

	jp	jmpadr		;f2 55 00

	jpe	jmpadr		;ea 55 00

	jpo	jmpadr		;e2 55 00

	jz	jmpadr		;ca 55 00

jmpadr:	.word	jmpadr

	lda	jmpadr		;3a 55 00

	ldax	b		;0a

	lhld	jmpadr		;2a 55 00

	lxi	sp,#0xeeee	;31 ee ee

	mov	c,d		;4a
	mov	c,m		;4e
	mov	m,c		;71

	mvi	c,#0xff		;0e ff
	mvi	m,#0h2c		;36 2c

	nop			;00

	ora	b		;b0
	ora	m		;b6

	ori	#4		;f6 04

	out	#5		;d3 05

	pchl			;e9

	pop	h		;e1

	push	b		;c5

	ral			;17

	rar			;1f

	ret			;c9

	rim			;20

	rc			;d8
	rlc			;07
	rm			;f8
	rnc			;d0
	rnz			;c0
	rp			;f0
	rpe			;e8
	rpo			;e0
	rz			;c8

	rrc			;0f

	rst	#3		;df

	sbb	c		;99
	sbb	m		;9e

	sbi	#5		;de 05

	shld	jmpadr		;22 55 00

	sim			;30

	sphl			;f9

	sta	jmpadr+1	;32 56 00

	stax	b		;02

	stc			;37

	sub	l		;95
	sub	m		;96

	sui	#0x22		;d6 22

	xchg			;eb

	xra	b		;a8
	xra	m		;ae

	xri	#0o377		;ee ff

	xthl			;e3


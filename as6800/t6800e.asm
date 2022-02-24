	.title	6800 Assembler Error Check

	.area	DIRECT

dirval:	.blkb	0

	.area	AS6800

	.setdp	DIRECT

	dir	=	0x0100
	offset	=	0x0101

1$:	sta a	#32		;error
	stab	#33		;error

	lda a	offset,x	;error
	ldaa	*dir		;error

	sts	#2211		;error
	stx	#1122		;error

	sub	#20		;error

	jmp	*dir		;error
	jmp	#2211		;error
	jsr	#1122		;error

	lda a	*255		;OK
	lda a	*256		;error
	lda a	*-1		;error
	lda a	*-256		;error

	lda a	*dirval		;OK
	lda a	dirval		;OK
	lda a	*dirval+0x100	;error
	lda a	*1$		;error


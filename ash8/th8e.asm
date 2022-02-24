	.title	H8 Assembler Error Check

	.area	DIRECT

dirval:	.blkb	0d256

	.area	ASH8

	.setdp	0,DIRECT

	dir	=	0x0100
	offset	=	0x0101

1$:	add	r0H,#32		;a

	mov	r0L,r4L
	mov	r0L,r4		;a
	mov	r0,r4L		;a

	mov	r0,r4
	mov.b	r0,r4		;a
	mov.w	r0L,r4L		;a

	mov	*dir,r0H	;a
	mov	r0H,*dir	;a

	mov	#2211,r0H	;a
	mov	r0H,#1122	;a

	jmp	@@dir		;a
	jmp	#2211		;a

	mov	*255,r0H	;
	mov	*256,r0H	;a
	mov	*-1,r0H		;a
	mov	*-256,r0H	;a

	mov	*dirval,r0H	;
	mov	dirval,r0H	;
	mov  *dirval+0x100,r0H	;   / *L error at link time
	mov	*1$,r0H		;   / *L error at link time

	.setdp	1,DIRECT	;b  / *L error at link time
	.setdp	0x100,DIRECT	;b  / *L error at link time
				;all subsequent direct page accesses
				;will give errors at link time


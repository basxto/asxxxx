	.sbttl	Assembler Link Tests

	.module	th8l

	; This file and TCONST.ASM should be assembled and linked.
	;
	; ASH8 -XGOL TH8L
	; ASH8 -XGOL TCONST
	;
	; ASLINK -C
	; -XMS
	; TH8L
	; TCONST
	; -E
	;
	; The following tests verify the correct processing of
	; external references for the direct page and branches.
	;
	; *L signifies an error will be reported at link time.

	; branch test must be first

	.area	TEST	(ABS,OVR)

	.blkb	0x7E		;bra1:
	bra	bra1		;     40 00  [40 80]
	.blkb	0x80		;bra2:
	bra	bra2		;  *L 40 00  [40 7F]
	bra	bra3		;     40 00  [40 7F]
	.blkb	0x7E
	.blkb	0x00		;bra3:
	bra	bra4		;  *L 40 00  [40 [80]
	.blkb	0x80
	.blkb	0x00		;bra4:

	.blkb	0x7E		;bra5:
	bra	bra5		;     40 00  [40 80]
	.blkb	0x80		;bra6:
	bra	bra6		;  *L 40 00  [40 7F]
	bra	bra7		;     40 00  [40 7F]
	.blkb	0x7E
	.blkb	0x00		;bra7:
	bra	bra8		;  *L 40 00  [40 80]
	.blkb	0x80
	.blkb	0x00		;bra8:

	; direct page test

	.area	DIRECT	(ABS,OVR)
	.setdp	0,DIRECT

	mov	*minus1,r0H	;*L 20 00  [96 FF]
	mov	*zero,r0H	;   20 00  [96 00]
	mov	*two55,r0H	;   20 00  [96 FF]
	mov	*two56,r0H	;*L 20 00  [96 00]

	mov	*lminus1,r0H	;*L 20 00  [96 FF]
	mov	*lzero,r0H	;   20 00  [96 00]
	mov	*ltwo55,r0H	;   20 00  [96 FF]
	mov	*ltwo56,r0H	;*L 20 00  [96 00]

	; direct page boundary / length checking

	.area	A

	.blkb	1

	.area	PAGE0	(PAG)	;*L Linker -- page definition boundary error

	.setdp	boundary,PAGE0	;*L Linker -- page boundary error

	.blkb	0x101		;*L Linker -- page length error


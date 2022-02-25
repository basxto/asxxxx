	.title	Machine Independent Assembler Test
	.module Asmtst

	;  The file 'asmt4blo.asm' must be assembled with
	; a LO/HI assembler (in file ___ext.c, hilo = 0).
	;
	;  The file 'asmt4bhi.asm' must be assembled with
	; a HI/LO assembler (in file ___ext.c, hilo = 1).
	;
	;	asmt:
	;		4	4-byte PC addressing
	;		b	1 byte data addressing
	;		lo	LO/HI assembler
	;		hi	HI/LO assembler
	;
	; All .areas must be of type DSEG.
	
	.sbttl	Memory Allocation Directives

	.area	_DATA		        ; Data Area

	.radix	O			; set default to octal
	.32bit				; 32-bit addressing

					; binary constants
	.byte	0b11000000		; C0
	.byte	0B1110			; 0E
	.byte	$%11000000		; C0

					; octal constants
	.byte	24			; 14
	.byte	024			; 14
	.byte	0q024			; 14
	.byte	0Q024			; 14
	.byte	0o024			; 14
	.byte	0O024			; 14
	.byte	$&24			; 14
	
					; decimal constant
	.byte	0d024			; 18
	.byte	0D024			; 18
	.byte	$#24			; 18

					; hexidecimal constants
	.byte	0h024			; 24
	.byte	0H024			; 24
	.byte	0x024			; 24
	.byte	0X024			; 24
	.byte	$$24			; 24

	.db	0			; 00
	.dw	0			; 00 00

	.radix	D			; set default to decimal

	.byte	1,2,3			; 01 02 03
	.byte	4,5,6			; 04 05 06
	.byte	7,8,9			; 07 08 09
	.word	1,2,3			; 00 01 00 02 00 03
	.word	4,5,6			; 00 04 00 05 00 06
	.word	7,8,9			; 00 07 00 08 00 09

	.blkb	16
	.ds	16

	.blkw	16
	.ds	16*2

word:	.word	.+2			;s00r92
	.word	.-2			;s00r90
	.word	2+.			;s00r96
	.word	.-(word+2)		; 00 04

byte4:	.4byte	.+3			;S00R00s00r9B
	.4byte	.-3			;S00R00s00r99
	.4byte	3+.			;S00R00s00rA3
	.4byte	.-(byte4+2)		; 00 00 00 0A

	.sbttl	Boundary Directives

	.even
	.byte	0			; 00
	.even
	.byte	1			; 01
	.even
	.odd
	.byte	2			; 02
	.odd
	.byte	3			; 03
	.odd
	.even
	.word	4			; 00 04
	.odd
	.word	5			; 00 05
	.even
	.word	6			; 00 06


	.sbttl	String Directives

	.ascii	"abcde"			; 61 62 63 64 65
	.asciz	"abcde"			; 61 62 63 64 65 00
	.ascis	"abcde"			; 61 62 63 64 E5

	
	.sbttl	Expression Evaluation

	n0x00	=	0x00
	n0x01	=	0x01
	n0x10	=	0x10
	n0xff	=	0xff
	n0xeeff =	0xeeff

	n =	< n0xeeff		; 0xff		low byte
	.byte	>n,<n			; 00 FF
	n =	> n0xeeff		; 0xee		high byte
	.byte	>n,<n			; 00 EE


	n =	'A			; 0x41		single character
	.byte	>n,<n			; 00 41
	n =	"AB			; 0x4241	double character
	.byte	>n,<n			; 41 42
	n =	n0x01			; 0x01		assignment
	.byte	>n,<n			; 00 01
	n =	n + n0x01		; 0x02		addition
	.byte	>n,<n			; 00 02
	n =	n - n0x01		; 0x01		subtraction
	.byte	>n,<n			; 00 01
	n =	n * 0x05		; 0x05		multiplication
	.byte	>n,<n			; 00 05
	n =	n / 0x02		; 0x02		division
	.byte	>n,<n			; 00 02
	n =	n0x10 % 0x05		; 0x01		modulus
	.byte	>n,<n			; 00 01
	n =	n0x10 | n0x01		; 0x11		or
	.byte	>n,<n			; 00 11
	n =	n0xff & n0x01		; 0x01		and
	.byte	>n,<n			; 00 01
	n =	n0x01 << 4		; 0x10		left shift
	.byte	>n,<n			; 00 10
	n =	n0x10 >> 4		; 0x01		right shift
	.byte	>n,<n			; 00 01
	n =	n0xff ^ n0x10		; 0xef		xor
	.byte	>n,<n			; 00 EF
	n =	n ^ n0x10		; 0xff		xor
	.byte	>n,<n			; 00 FF
	n =	~n0x10			; 0xffef	1's complement
	.byte	>n,<n			; FF EF
	n =	-n0x10			; 0xfff0	2's complement
	.byte	>n,<n			; FF F0



	n =	n0xeeff & 0xff		; 0xff		low byte
	.byte	>n,<n			; 00 FF
	n =	(n0xeeff & 0xff00)/0x100; 0xee		high byte
	.byte	>n,<n			; 00 EE


	n =	n0xeeff % 0x100 	; 0xff		low byte
	.byte	>n,<n			; 00 FF
	n =	n0xeeff / 0x100 	; 0xee		high byte
	.byte	>n,<n			; 00 EE


	n =	3*(2 + 4*(6))		; 0x4e		expression evaluation
	.byte	>n,<n			; 00 4E
	n =	2*(0x20 + <~n0x10)	; 0x21e
	.byte	>n,<n			; 02 1E


	.sbttl	arithmatic tests
	;
	; The following series of tests verify that
	; the arithmetic is 32-Bit and unsigned.


	.sbttl	Addition

	n =	 1 +  1			; 0x00000001 + 0x00000001 ; 0x00000002
	.byte	>n,<n			; 00 02
	n =	-1 +  1			; 0xFFFFFFFF + 0x00000001 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-1 + -1			; 0xFFFFFFFF + 0xFFFFFFFF ; 0xFFFFFFFE
	.byte	>n,<n			; FF FE

	n =	 32768 +  32768		; 0x00008000 + 0x00008000 ; 0x00010000
	.byte	>n,<n			; 00 00
	n =	-32768 +  32768		; 0xFFFF8000 + 0x00008000 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-32768 + -32768		; 0xFFFF8000 + 0xFFFF8000 ; 0xFFFF0000
	.byte	>n,<n			; 00 00

	n =	 65535 +  1		; 0x0000FFFF + 0x00000001 ; 0x00010000
	.byte	>n,<n			; 00 00
	n =	 65535 + -1		; 0x0000FFFF + 0xFFFFFFFF ; 0x0000FFFE
	.byte	>n,<n			; FF FE


	.sbttl	Subtraction

	n =	 1 -  1			; 0x00000001 - 0x00000001 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-1 -  1			; 0xFFFFFFFF - 0x00000001 ; 0xFFFFFFFE
	.byte	>n,<n			; FF FE
	n =	-1 - -1			; 0xFFFFFFFF - 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00

	n =	 32768 -  32768		; 0x00008000 - 0xFFFF8000 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-32768 -  32768		; 0xFFFF8000 - 0x00008000 ; 0xFFFF0000
	.byte	>n,<n			; 00 00
	n =	-32768 - -32768		; 0xFFFF8000 - 0xFFFF8000 ; 0x00000000
	.byte	>n,<n			; 00 00

	n =	 65535 -  1		; 0x0000FFFF - 0x00000001 ; 0x0000FFFE
	.byte	>n,<n			; FF FE
	n =	 65535 - -1		; 0x0000FFFF - 0xFFFFFFFF ; 0x00010000
	.byte	>n,<n			; 00 00


	.sbttl	Multiplication

	n =	 1 *  1			; 0x00000001 * 0x00000001 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	 1 * -1			; 0x00000001 * 0xFFFFFFFF ; 0xFFFFFFFF
	.byte	>n,<n			; FF FF
	n =	-1 * -1			; 0xFFFFFFFF * 0xFFFFFFFF ; 0x00000001
	.byte	>n,<n			; 00 01

	n =	 256 *  256		; 0x00000100 * 0x00000100 ; 0x00010000
	.byte	>n,<n			; 00 00
	n =	 256 * -256		; 0x00000100 * 0xFFFFFF00 ; 0xFFFF0000
	.byte	>n,<n			; 00 00
	n =	-256 * -256		; 0xFFFFFF00 * 0xFFFFFF00 ; 0x00010000
	.byte	>n,<n			; 00 00


	.sbttl	Division

	n =	 1 /  1			; 0x00000001 / 0x00000001 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	10 /  2			; 0x0000000A / 0x00000002 ; 0x00000005
	.byte	>n,<n			; 00 05
	n =	512 / 4			; 0x00000200 / 0x00000004 ; 0x00000080
	.byte	>n,<n			; 00 80
	n =	32768 / 2		; 0x00008000 / 0x00000002 ; 0x00004000
	.byte	>n,<n			; 40 00
	n =	65535 / 2		; 0x0000FFFF / 0x00000002 ; 0x00007FFF
	.byte	>n,<n			; 7F FF

	n = 	 1 / -1			; 0x00000001 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	 32767 / -1		; 0x00007FFF / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	 32768 / -1		; 0x00008000 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	 65534 / -1		; 0x0000FFFE / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	 65535 / -1		; 0x0000FFFF / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-1 / -1			; 0xFFFFFFFF / 0xFFFFFFFF ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-2 / -1			; 0xFFFFFFFE / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-32768 / -1		; 0xFFFF8000 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-32769 / -1		; 0xFFFF7FFF / OxFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-65535 / -1		; 0xFFFF0001 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-65536 / -1		; 0xFFFF0000 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00

	n =	-256 /   -1		; 0xFFFFFF00 / 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-256 / -255		; 0xFFFFFF00 / 0xFFFFFF01 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-256 / -256		; 0xFFFFFF00 / 0xFFFFFF00 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 / -257		; 0xFFFFFF00 / 0xFFFFFEFF ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 / -32767		; 0xFFFFFF00 / 0xFFFF8001 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 / -32768		; 0xFFFFFF00 / 0xFFFF8000 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 /  32768		; 0xFFFFFF00 / 0x00008000 ; 0x0001FFFF
	.byte	>n,<n			; FF FF
	n =	-256 /  65280		; 0xFFFFFF00 / 0x0000FF00 ; 0x00010101
	.byte	>n,<n			; 01 01
	n =	-256 /  65281		; 0xFFFFFF00 / 0x0000FF01 ; 0x000100FF
	.byte	>n,<n			; 00 FF
	n =	-256 /  65535		; 0xFFFFFF00 / 0x0000FFFF ; 0x00010000
	.byte	>n,<n			; 00 00


	.sbttl	Modulus

	n =	 1 %  1			; 0x00000001 % 0x00000001 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	10 %  2			; 0x0000000A % 0x00000002 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	512 % 4			; 0x00000200 % 0x00000004 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	32768 % 2		; 0x00008000 % 0x00000002 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	65535 % 2		; 0x0000FFFF % 0x00000002 ; 0x00000001
	.byte	>n,<n			; 00 01

	n = 	 1 % -1			; 0x00000001 % 0xFFFFFFFF ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	 32767 % -1		; 0x00007FFF % 0xFFFFFFFF ; 0x00007FFF
	.byte	>n,<n			; 7F FF
	n =	 32768 % -1		; 0x00008000 % 0xFFFFFFFF ; 0x00008000
	.byte	>n,<n			; 80 00
	n =	 65534 % -1		; 0x0000FFFE % 0xFFFFFFFF ; 0x0000FFFE
	.byte	>n,<n			; FF FE
	n =	 65535 % -1		; 0x0000FFFF % 0xFFFFFFFF ; 0x0000FFFF
	.byte	>n,<n			; FF FF
	n =	-1 % -1			; 0xFFFFFFFF % 0xFFFFFFFF ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-2 % -1			; 0xFFFFFFFE % 0xFFFFFFFF ; 0xFFFFFFFE
	.byte	>n,<n			; FF FE
	n =	-32768 % -1		; 0xFFFF8000 % 0xFFFFFFFF ; 0xFFFF8000
	.byte	>n,<n			; 80 00
	n =	-32769 % -1		; 0xFFFF7FFF % 0xFFFFFFFF ; 0xFFFF7FFF
	.byte	>n,<n			; 7F FF
	n =	-65535 % -1		; 0xFFFF0001 % 0xFFFFFFFF ; 0xFFFF0001
	.byte	>n,<n			; 00 01
	n =	-65536 % -1		; 0xFFFF0000 % 0xFFFFFFFF ; 0xFFFF0000
	.byte	>n,<n			; 00 00

	n =	-256 %   -1		; 0xFFFFFF00 % 0xFFFFFFFF ; 0XFFFFFF00
	.byte	>n,<n			; FF 00
	n =	-256 % -255		; 0xFFFFFF00 % 0xFFFFFF01 ; 0xFFFFFF00
	.byte	>n,<n			; FF 00
	n =	-256 % -256		; 0xFFFFFF00 % 0xFFFFFF00 ; 0X00000000
	.byte	>n,<n			; 00 00
	n =	-256 % -257		; 0xFFFFFF00 % 0XFFFFFF01 ; 0x00000001
	.byte	>n,<n			; 00 01
	n =	-256 % -32767		; 0xFFFFFF00 % 0xFFFF8001 ; 0x00007EFF
	.byte	>n,<n			; 7E FF
	n =	-256 % -32768		; 0xFFFFFF00 % 0xFFFF8000 ; 0x00007F00
	.byte	>n,<n			; 7F 00
	n =	-256 %  32768		; 0xFFFFFF00 % 0x00008000 ; 0x00007F00
	.byte	>n,<n			; 7F 00
	n =	-256 %  65280		; 0xFFFFFF00 % 0x0000FF00 ; 0x00000000
	.byte	>n,<n			; 00 00
	n =	-256 %  65281		; 0xFFFFFF00 % 0x0000FF01 ; 0x0000FD01
	.byte	>n,<n			; FD 01
	n =	-256 %  65535		; 0xFFFFFF00 % 0x0000FFFF ; 0x0000FF00
	.byte	>n,<n			; FF 00


	.sbttl	IF, ELSE, and ENDIF

	n = 0
	m = 0

	.if	0
		n = 1
		.if	0
		m = 1
		.else
		m = 2
		.endif
	.else
		n = 2
	.endif

					; n = 2, m = 0
	.byte	n,m			; 02 00

	;*******************************************************

	n = 0
	m = 0

	.if	1
		n = 1
		.if	0
		m = 1
		.else
		m = 2
		.endif
	.else
		n = 2
	.endif

					; n = 1, m = 2
	.byte	n,m			; 01 02


	n = 0
	m = 0

	.if	0
		n = 1
		.if	1
		m = 1
		.else
		m = 2
		.endif
	.else
		n = 2
	.endif

					; n = 2, m = 0
	.byte	n,m			; 02 00

	;*******************************************************

	n = 0
	m = 0

	.if	1
		n = 1
		.if	1
		m = 1
		.else
		m = 2
		.endif
	.else
		n = 2
	.endif

					; n = 1, m = 1
	.byte	n,m			; 01 01


	n = 0
	m = 0

	.if	0
		n = 1
	.else
		.if	0
		m = 1
		.else
		m = 2
		.endif
		n = 2
	.endif

					; n = 2, m = 2
	.byte	n,m			; 02 02

	;*******************************************************

	n = 0
	m = 0

	.if	1
		n = 1
	.else
		.if	0
		m = 1
		.else
		m = 2
		.endif
		n = 2
	.endif

					; n = 1, m = 0
	.byte	n,m			; 01 00


	n = 0
	m = 0

	.if	0
		n = 1
	.else
		.if	1
		m = 1
		.else
		m = 2
		.endif
		n = 2
	.endif

					; n = 2, m = 1
	.byte	n,m			; 02 01

	;*******************************************************

	n = 0
	m = 0

	.if	1
		n = 1
	.else
		.if	1
		m = 1
		.else
		m = 2
		.endif
		n = 2
	.endif

					; n = 1, m = 0
	.byte	n,m			; 01 00


	.sbttl	Local Symbols

lclsym0:
					; forward references
	.word	0$,1$			;s01rB2s01rB4
	.word	2$,3$			;s01rB6s01rB8
	.word	4$,5$			;s01rBAs01rBC
	.word	6$,7$			;s01rBEs01rC0
	.word	8$,9$			;s01rC2s01rC4

0$:	.word	9$			;s01rC4
1$:	.word	8$			;s01rC2
2$:	.word	7$			;s01rC0
3$:	.word	6$			;s01rBE
4$:	.word	5$			;s01rBC
5$:	.word	4$			;s01rBA
6$:	.word	3$			;s01rB8
7$:	.word	2$			;s01rB6
8$:	.word	1$			;s01rB4
9$:	.word	0$			;s01rB2
10$:

					; backward references
	.word	0$,1$			;s01rB2s01rB4
	.word	2$,3$			;s01rB6s01rB8
	.word	4$,5$			;s01rBAs01rBC
	.word	6$,7$			;s01rBEs01rC0
	.word	8$,9$			;s01rC2s01rC4

lclsym1:
					; forward references
	.word	0$,1$			;s01rEEs01rF0
	.word	2$,3$			;s01rF2s01rF4
	.word	4$,5$			;s01rF6s01rF8
	.word	6$,7$			;s01rFAs01rFC
	.word	8$,9$			;s01rFEs02r00

0$:	.word	9$			;s02r00
1$:	.word	8$			;s01rFE
2$:	.word	7$			;s01rFC
3$:	.word	6$			;s01rFA
4$:	.word	5$			;s01rF8
5$:	.word	4$			;s01rF6
6$:	.word	3$			;s01rF4
7$:	.word	2$			;s01rF2
8$:	.word	1$			;s01rF0
9$:	.word	0$			;s01rEE
10$:

					; backward references
	.word	0$,1$			;s01rEEs01rF0
	.word	2$,3$			;s01rF2s01rF4
	.word	4$,5$			;s01rF6s01rF8
	.word	6$,7$			;s01rFAs01rFC
	.word	8$,9$			;s01rFEs02r00


	.sbttl	Offset calculations

	ofsbyte	=	(10$-0$)	; 0x0014
	ofsword	=	ofsbyte/2	; 0x000A

					; 1$ + 0x001E
	.word	1$+ofsbyte+ofsword	;s02r0E

	.sbttl	Lower/Upper Byte Selections

	.globl	extern

					; low byte
	.byte	< (extern + 0x0001)	;r01

					; low byte
	.byte	< (extern + 0x0200)	;r00

					; high byte 
	.byte	> (extern + 0x0003)	;s00

					; high byte
	.byte	> (extern + 0x0400)	;s04

	.msb	0			; select byte 0
	.byte	> (extern + 0x76543210)	;r10

	.msb	1			; select byte 1
	.byte	> (extern + 0x76543210)	;s32

	.msb	2			; select byte 2
	.byte	> (extern + 0x76543210)	;R54

	.msb	3			;select byte 3
	.byte	> (extern + 0x76543210)	;S76

	.msb	1			; reset to byte 1


	.sbttl	Area Definitions

	.globl	code0
	.globl	cnstnt1,cnstnt2

	cnstnt0 == 0xabcd		; global equate

code0:	.word	a0			;s00r00
	.word	cnstnt0			; AB CD

	; Bank selected as _DSEG
	; Overlay and Data Segment
	.area	AreaA (OVR,DSEG,BANK=_DSEG)

	cnstnt1 = 0x1234

a0:	.word	0x00ff			; 00 FF

	; Bank selected as _DSEG
	; Overlay and Data Segment
	.area	AreaB (ABS,OVR,DSEG,BANK=_DSEG)

	cnstnt2 = 0x5678

	.word	a1			;s00r00

	.area	AreaA

	.=.+0x0020
	.word	a2			;s00r00

	.area	AreaB
	.org	0x40

	.word	a0,a1,a2		;s00r00s00r00s00r00
	.word	AreaB,OVR		;s00r00s00r00

abcdabcd::				; global symbol


	.sbttl	Assembler Output File asmt4b_.sym

.if 0

 Listing of Symbol Table

       assembled by:
                asxxxx -gloxff asmt4b_.asm

Symbol Table

    .__.ABS.       =    00000000 G   |     AreaB               ******** GX
    OVR                 ******** GX  |   2 a0                  00000000 GR
    a1                  ******** GX  |     a2                  ******** GX
  3 abcdabcd            0000004A GR  |   1 byte4               00000098 GR
    cnstnt0        =    0000ABCD G   |     cnstnt1        =    00001234 G
    cnstnt2        =    00005678 G   |   1 code0               00000220 GR
    extern              ******** GX  |   1 lclsym0             0000019E GR
  1 lclsym1             000001DA GR  |     m              =    00000000 G
    n              =    00000001 G   |     n0x00          =    00000000 G
    n0x01          =    00000001 G   |     n0x10          =    00000010 G
    n0xeeff        =    0000EEFF G   |     n0xff          =    000000FF G
    ofsbyte        =    00000014 G   |     ofsword        =    0000000A G
  1 word                00000090 GR

Area Table

[_CSEG]
   0 _CODE            size        0   flags C081
[_DSEG]
   1 _DATA            size      224   flags C0C0
   2 AreaA            size       24   flags C4C4
   3 AreaB            size       4A   flags CCCC

.endif



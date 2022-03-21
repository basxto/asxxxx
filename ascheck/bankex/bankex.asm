; bankex.asm

	;*****-----*****-----*****-----*****-----*****-----*****-----*****
	;*
	;*			Bank Usage Example
	;*
	;*   1)	Create two banks each containing multiple
	;*	areas of varying size and content.
	;*
	;*   2)	Each area will be built in this file and then
	;*	rearranged at link time.
	;*
	;*****-----*****-----*****-----*****-----*****-----*****-----*****
	;*
	;*	The Area and Banking Information
	;*	can be specified in multiple ways.
	;*
	;*   1)	Place the area/bank definition in this file.
	;*   2)	As an include file at the beginning of the assembly file.
	;*   3) As a seperate file assembled and linked with this file.
	;*
	;*	The format is identical for all of the methods:
	;*
	;*	Parameters -	set base address,
	;*			do not specify a maximum size, and
	;*			do not output to an alternate file
	;*
	;*			(if the base address is not specified here
	;*			it can be specified as an option at link time)
	;*
	;*		.bank	Bank_1	(base=0x1000)
	;*
	;*		.bank	Bank_2	(base=0x2000)
	;*
	;*	Parameters -	set the code type
	;*			in this example the sections are
	;*			relocatable, concatenated, and
	;*			associated with a specific bank
	;*
	;*		.area	A1	(rel,con,bank=Bank_1)
	;*		.area	A2	(rel,con,bank=Bank_1)
	;*		.area	A3	(rel,con,bank=Bank_1)
	;*
	;*		.area	B1	(rel,con,bank=Bank_2)
	;*		.area	B2	(rel,con,bank=Bank_2)
	;*		.area	B3	(rel,con,bank=Bank_2)
	;*
	;*	NOTE:	Within a single file, area parameters
	;*		need to be specified in the first definition.
	;*		Subsequent area directives must be blank or
	;*		have the same parameters.
	;*
	;*	NOTE:	The areas are loaded in the order given to the linker:
	;*		In this example the order is A1, A2, and A3 in Bank_1
	;*		and B1, B2, and B3 in Bank_2.
	;*
	;*****-----*****-----*****-----*****-----*****-----*****-----*****
	;*
	;*  Local Definition Of Banks and Areas -
	;*

	.bank	Bank_1	(base=0x1000)
	.bank	Bank_2	(base=0x2000)

	;*  Areas Will Concatenated In This Order

	.area	A1	(rel,con,bank=Bank_1)
	.area	A2	(rel,con,bank=Bank_1)
	.area	A3	(rel,con,bank=Bank_1)

	.area	B1	(rel,con,bank=Bank_2)
	.area	B2	(rel,con,bank=Bank_2)
	.area	B3	(rel,con,bank=Bank_2)


	; Areas To Assemble

	.area	A3

a3:	.blkb	0x20		; allocate 0x20 bytes
end_a3:

	;*****

	.area	B2

b2:	.blkb	0x200		; allocate 0x200 bytes
end_b2:

	;*****

	.area	A2

a2:	.blkb	0x40		; allocate 0x40 bytes
end_a2:

	;*****

	.area	B1

b1:	.word	a1
	.word	end_a1
	.word	a2
	.word	end_a2
	.word	a3
	.word	end_a3
	.word	b1
	.word	end_b1
	.word	b2
	.word	end_b2
	.word	b3
	.word	end_b3

	bw = . - b1
	. = . + (0x0100 - bw)	; start at an offset of 0x100
	.blkb	0x10		; allocate 0x10 bytes
end_b1:

	;*****

	.area	B3

b3:	.blkb	0x80		; allocate 0x80 bytes
end_b3:

	;*****

	.area	A1

a1:	.word	a1
	.word	end_a1
	.word	a2
	.word	end_a2
	.word	a3
	.word	end_a3
	.word	b1
	.word	end_b1
	.word	b2
	.word	end_b2
	.word	b3
	.word	end_b3

	.blkb	0x180		; allocate 0x180 bytes
end_a1:


	.end

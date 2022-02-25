;  TPIC17CX.ASM - Test file for ASPIC assembler
;
;  Assemble:
;	aspic -gloaxff tpic17cx
;

	.include	"tpic17cx.def"


	.area	DATA

	fcode =		1
	wcode =		0

	num0 =		0
	num7 =		7
	num1 =		1

	.area	CODE

	addr_00	=	. + 0x00
	addr_1FFF =	. + 0x1fff

	nop			; 00 00

	return			; 00 02
	retfie			; 00 05

	sleep			; 00 03
	clrwdt			; 00 04

	movwf	0x00		; 01 00
	movwf	0xFF		; 01 FF
	movwf	extreg		;n01*00

	movwf	*0x00		; 01 00
	movwf	*0xFF		; 01 FF
	movwf	*extreg		;n01*00

	subwfb	0x00,w		; 02 00
	subwfb	0xFF,w		; 02 FF
	subwfb	extreg,w	;n02*00

	subwfb	0x00,f		; 03 00
	subwfb	0xFF,f		; 03 FF
	subwfb	extreg,f	;n03*00

	subwfb	*0x00,w		; 02 00
	subwfb	*0xFF,w		; 02 FF
	subwfb	*extreg,w	;n02*00

	subwfb	*0x00,f		; 03 00
	subwfb	*0xFF,f		; 03 FF
	subwfb	*extreg,f	;n03*00

	subwfb	0x00,0		; 02 00
	subwfb	*0x00,0		; 02 00
	subwfb	extreg,0	;n02*00
	subwfb	*extreg,0	;n02*00
	subwfb	0x00,#0		; 02 00
	subwfb	*0x00,#0	; 02 00
	subwfb	extreg,#0	;n02*00
	subwfb	*extreg,#0	;n02*00
	subwfb	0x00,wcode	; 02 00
	subwfb	*0x00,wcode	; 02 00
	subwfb	extreg,wcode	;n02*00
	subwfb	*extreg,wcode	;n02*00
	subwfb	0x00,#wcode	; 02 00
	subwfb	*0x00,#wcode	; 02 00
	subwfb	extreg,#wcode	;n02*00
	subwfb	*extreg,#wcode	;n02*00

	subwfb	0x00,1		; 03 00
	subwfb	*0x00,1		; 03 00
	subwfb	extreg,1	;n03*00
	subwfb	*extreg,1	;n03*00
	subwfb	0x00,#1		; 03 00
	subwfb	*0x00,#1	; 03 00
	subwfb	extreg,#1	;n03*00
	subwfb	*extreg,#1	;n03*00
	subwfb	0x00,fcode	; 03 00
	subwfb	*0x00,fcode	; 03 00
	subwfb	extreg,fcode	;n03*00
	subwfb	*extreg,fcode	;n03*00
	subwfb	0x00,#fcode	; 03 00
	subwfb	*0x00,#fcode	; 03 00
	subwfb	extreg,#fcode	;n03*00
	subwfb	*extreg,#fcode	;n03*00

	subwf	0x00,w		; 04 00
	subwf	0xFF,w		; 04 FF
	subwf	extreg,w	;n04*00

	subwf	0x00,f		; 05 00
	subwf	0xFF,f		; 05 FF
	subwf	extreg,f	;n05*00

	subwf	*0x00,w		; 04 00
	subwf	*0xFF,w		; 04 FF
	subwf	*extreg,w	;n04*00

	subwf	*0x00,f		; 05 00
	subwf	*0xFF,f		; 05 FF
	subwf	*extreg,f	;n05*00

	subwf	0x00,0		; 04 00
	subwf	*0x00,0		; 04 00
	subwf	extreg,0	;n04*00
	subwf	*extreg,0	;n04*00
	subwf	0x00,#0		; 04 00
	subwf	*0x00,#0	; 04 00
	subwf	extreg,#0	;n04*00
	subwf	*extreg,#0	;n04*00
	subwf	0x00,wcode	; 04 00
	subwf	*0x00,wcode	; 04 00
	subwf	extreg,wcode	;n04*00
	subwf	*extreg,wcode	;n04*00
	subwf	0x00,#wcode	; 04 00
	subwf	*0x00,#wcode	; 04 00
	subwf	extreg,#wcode	;n04*00
	subwf	*extreg,#wcode	;n04*00

	subwf	0x00,1		; 05 00
	subwf	*0x00,1		; 05 00
	subwf	extreg,1	;n05*00
	subwf	*extreg,1	;n05*00
	subwf	0x00,#1		; 05 00
	subwf	*0x00,#1	; 05 00
	subwf	extreg,#1	;n05*00
	subwf	*extreg,#1	;n05*00
	subwf	0x00,fcode	; 05 00
	subwf	*0x00,fcode	; 05 00
	subwf	extreg,fcode	;n05*00
	subwf	*extreg,fcode	;n05*00
	subwf	0x00,#fcode	; 05 00
	subwf	*0x00,#fcode	; 05 00
	subwf	extreg,#fcode	;n05*00
	subwf	*extreg,#fcode	;n05*00

	decf	0x00,w		; 06 00
	decf	0xFF,w		; 06 FF
	decf	extreg,w	;n06*00

	decf	0x00,f		; 07 00
	decf	0xFF,f		; 07 FF
	decf	extreg,f	;n07*00

	decf	*0x00,w		; 06 00
	decf	*0xFF,w		; 06 FF
	decf	*extreg,w	;n06*00

	decf	*0x00,f		; 07 00
	decf	*0xFF,f		; 07 FF
	decf	*extreg,f	;n07*00

	decf	0x00,0		; 06 00
	decf	*0x00,0		; 06 00
	decf	extreg,0	;n06*00
	decf	*extreg,0	;n06*00
	decf	0x00,#0		; 06 00
	decf	*0x00,#0	; 06 00
	decf	extreg,#0	;n06*00
	decf	*extreg,#0	;n06*00
	decf	0x00,wcode	; 06 00
	decf	*0x00,wcode	; 06 00
	decf	extreg,wcode	;n06*00
	decf	*extreg,wcode	;n06*00
	decf	0x00,#wcode	; 06 00
	decf	*0x00,#wcode	; 06 00
	decf	extreg,#wcode	;n06*00
	decf	*extreg,#wcode	;n06*00

	decf	0x00,1		; 07 00
	decf	*0x00,1		; 07 00
	decf	extreg,1	;n07*00
	decf	*extreg,1	;n07*00
	decf	0x00,#1		; 07 00
	decf	*0x00,#1	; 07 00
	decf	extreg,#1	;n07*00
	decf	*extreg,#1	;n07*00
	decf	0x00,fcode	; 07 00
	decf	*0x00,fcode	; 07 00
	decf	extreg,fcode	;n07*00
	decf	*extreg,fcode	;n07*00
	decf	0x00,#fcode	; 07 00
	decf	*0x00,#fcode	; 07 00
	decf	extreg,#fcode	;n07*00
	decf	*extreg,#fcode	;n07*00

	iorwf	0x00,w		; 08 00
	iorwf	0xFF,w		; 08 FF
	iorwf	extreg,w	;n08*00

	iorwf	0x00,f		; 09 00
	iorwf	0xFF,f		; 09 FF
	iorwf	extreg,f	;n09*00

	iorwf	*0x00,w		; 08 00
	iorwf	*0xFF,w		; 08 FF
	iorwf	*extreg,w	;n08*00

	iorwf	*0x00,f		; 09 00
	iorwf	*0xFF,f		; 09 FF
	iorwf	*extreg,f	;n09*00

	iorwf	0x00,0		; 08 00
	iorwf	*0x00,0		; 08 00
	iorwf	extreg,0	;n08*00
	iorwf	*extreg,0	;n08*00
	iorwf	0x00,#0		; 08 00
	iorwf	*0x00,#0	; 08 00
	iorwf	extreg,#0	;n08*00
	iorwf	*extreg,#0	;n08*00
	iorwf	0x00,wcode	; 08 00
	iorwf	*0x00,wcode	; 08 00
	iorwf	extreg,wcode	;n08*00
	iorwf	*extreg,wcode	;n08*00
	iorwf	0x00,#wcode	; 08 00
	iorwf	*0x00,#wcode	; 08 00
	iorwf	extreg,#wcode	;n08*00
	iorwf	*extreg,#wcode	;n08*00

	iorwf	0x00,1		; 09 00
	iorwf	*0x00,1		; 09 00
	iorwf	extreg,1	;n09*00
	iorwf	*extreg,1	;n09*00
	iorwf	0x00,#1		; 09 00
	iorwf	*0x00,#1	; 09 00
	iorwf	extreg,#1	;n09*00
	iorwf	*extreg,#1	;n09*00
	iorwf	0x00,fcode	; 09 00
	iorwf	*0x00,fcode	; 09 00
	iorwf	extreg,fcode	;n09*00
	iorwf	*extreg,fcode	;n09*00
	iorwf	0x00,#fcode	; 09 00
	iorwf	*0x00,#fcode	; 09 00
	iorwf	extreg,#fcode	;n09*00
	iorwf	*extreg,#fcode	;n09*00

	andwf	0x00,w		; 0A 00
	andwf	0xFF,w		; 0A FF
	andwf	extreg,w	;n0A*00

	andwf	0x00,f		; 0B 00
	andwf	0xFF,f		; 0B FF
	andwf	extreg,f	;n0B*00

	andwf	*0x00,w		; 0A 00
	andwf	*0xFF,w		; 0A FF
	andwf	*extreg,w	;n0A*00

	andwf	*0x00,f		; 0B 00
	andwf	*0xFF,f		; 0B FF
	andwf	*extreg,f	;n0B*00

	andwf	0x00,0		; 0A 00
	andwf	*0x00,0		; 0A 00
	andwf	extreg,0	;n0A*00
	andwf	*extreg,0	;n0A*00
	andwf	0x00,#0		; 0A 00
	andwf	*0x00,#0	; 0A 00
	andwf	extreg,#0	;n0A*00
	andwf	*extreg,#0	;n0A*00
	andwf	0x00,wcode	; 0A 00
	andwf	*0x00,wcode	; 0A 00
	andwf	extreg,wcode	;n0A*00
	andwf	*extreg,wcode	;n0A*00
	andwf	0x00,#wcode	; 0A 00
	andwf	*0x00,#wcode	; 0A 00
	andwf	extreg,#wcode	;n0A*00
	andwf	*extreg,#wcode	;n0A*00

	andwf	0x00,1		; 0B 00
	andwf	*0x00,1		; 0B 00
	andwf	extreg,1	;n0B*00
	andwf	*extreg,1	;n0B*00
	andwf	0x00,#1		; 0B 00
	andwf	*0x00,#1	; 0B 00
	andwf	extreg,#1	;n0B*00
	andwf	*extreg,#1	;n0B*00
	andwf	0x00,fcode	; 0B 00
	andwf	*0x00,fcode	; 0B 00
	andwf	extreg,fcode	;n0B*00
	andwf	*extreg,fcode	;n0B*00
	andwf	0x00,#fcode	; 0B 00
	andwf	*0x00,#fcode	; 0B 00
	andwf	extreg,#fcode	;n0B*00
	andwf	*extreg,#fcode	;n0B*00

	xorwf	0x00,w		; 0C 00
	xorwf	0xFF,w		; 0C FF
	xorwf	extreg,w	;n0C*00

	xorwf	0x00,f		; 0D 00
	xorwf	0xFF,f		; 0D FF
	xorwf	extreg,f	;n0D*00

	xorwf	*0x00,w		; 0C 00
	xorwf	*0xFF,w		; 0C FF
	xorwf	*extreg,w	;n0C*00

	xorwf	*0x00,f		; 0D 00
	xorwf	*0xFF,f		; 0D FF
	xorwf	*extreg,f	;n0D*00

	xorwf	0x00,0		; 0C 00
	xorwf	*0x00,0		; 0C 00
	xorwf	extreg,0	;n0C*00
	xorwf	*extreg,0	;n0C*00
	xorwf	0x00,#0		; 0C 00
	xorwf	*0x00,#0	; 0C 00
	xorwf	extreg,#0	;n0C*00
	xorwf	*extreg,#0	;n0C*00
	xorwf	0x00,wcode	; 0C 00
	xorwf	*0x00,wcode	; 0C 00
	xorwf	extreg,wcode	;n0C*00
	xorwf	*extreg,wcode	;n0C*00
	xorwf	0x00,#wcode	; 0C 00
	xorwf	*0x00,#wcode	; 0C 00
	xorwf	extreg,#wcode	;n0C*00
	xorwf	*extreg,#wcode	;n0C*00

	xorwf	0x00,1		; 0D 00
	xorwf	*0x00,1		; 0D 00
	xorwf	extreg,1	;n0D*00
	xorwf	*extreg,1	;n0D*00
	xorwf	0x00,#1		; 0D 00
	xorwf	*0x00,#1	; 0D 00
	xorwf	extreg,#1	;n0D*00
	xorwf	*extreg,#1	;n0D*00
	xorwf	0x00,fcode	; 0D 00
	xorwf	*0x00,fcode	; 0D 00
	xorwf	extreg,fcode	;n0D*00
	xorwf	*extreg,fcode	;n0D*00
	xorwf	0x00,#fcode	; 0D 00
	xorwf	*0x00,#fcode	; 0D 00
	xorwf	extreg,#fcode	;n0D*00
	xorwf	*extreg,#fcode	;n0D*00

	addwf	0x00,w		; 0E 00
	addwf	0xFF,w		; 0E FF
	addwf	extreg,w	;n0E*00

	addwf	0x00,f		; 0F 00
	addwf	0xFF,f		; 0F FF
	addwf	extreg,f	;n0F*00

	addwf	*0x00,w		; 0E 00
	addwf	*0xFF,w		; 0E FF
	addwf	*extreg,w	;n0E*00

	addwf	*0x00,f		; 0F 00
	addwf	*0xFF,f		; 0F FF
 	addwf	*extreg,f	;n0F*00

	addwf	0x00,0		; 0E 00
	addwf	*0x00,0		; 0E 00
	addwf	extreg,0	;n0E*00
	addwf	*extreg,0	;n0E*00
	addwf	0x00,#0		; 0E 00
	addwf	*0x00,#0	; 0E 00
	addwf	extreg,#0	;n0E*00
	addwf	*extreg,#0	;n0E*00
	addwf	0x00,wcode	; 0E 00
	addwf	*0x00,wcode	; 0E 00
	addwf	extreg,wcode	;n0E*00
	addwf	*extreg,wcode	;n0E*00
	addwf	0x00,#wcode	; 0E 00
	addwf	*0x00,#wcode	; 0E 00
	addwf	extreg,#wcode	;n0E*00
	addwf	*extreg,#wcode	;n0E*00

	addwf	0x00,1		; 0F 00
	addwf	*0x00,1		; 0F 00
	addwf	extreg,1	;n0F*00
	addwf	*extreg,1	;n0F*00
	addwf	0x00,#1		; 0F 00
	addwf	*0x00,#1	; 0F 00
	addwf	extreg,#1	;n0F*00
	addwf	*extreg,#1	;n0F*00
	addwf	0x00,fcode	; 0F 00
	addwf	*0x00,fcode	; 0F 00
	addwf	extreg,fcode	;n0F*00
	addwf	*extreg,fcode	;n0F*00
	addwf	0x00,#fcode	; 0F 00
	addwf	*0x00,#fcode	; 0F 00
	addwf	extreg,#fcode	;n0F*00
	addwf	*extreg,#fcode	;n0F*00

	addwfc	0x00,w		; 10 00
	addwfc	0xFF,w		; 10 FF
	addwfc	extreg,w	;n10*00

	addwfc	0x00,f		; 11 00
	addwfc	0xFF,f		; 11 FF
	addwfc	extreg,f	;n11*00

	addwfc	*0x00,w		; 10 00
	addwfc	*0xFF,w		; 10 FF
	addwfc	*extreg,w	;n10*00

	addwfc	*0x00,f		; 11 00
	addwfc	*0xFF,f		; 11 FF
 	addwfc	*extreg,f	;n11*00

	addwfc	0x00,0		; 10 00
	addwfc	*0x00,0		; 10 00
	addwfc	extreg,0	;n10*00
	addwfc	*extreg,0	;n10*00
	addwfc	0x00,#0		; 10 00
	addwfc	*0x00,#0	; 10 00
	addwfc	extreg,#0	;n10*00
	addwfc	*extreg,#0	;n10*00
	addwfc	0x00,wcode	; 10 00
	addwfc	*0x00,wcode	; 10 00
	addwfc	extreg,wcode	;n10*00
	addwfc	*extreg,wcode	;n10*00
	addwfc	0x00,#wcode	; 10 00
	addwfc	*0x00,#wcode	; 10 00
	addwfc	extreg,#wcode	;n10*00
	addwfc	*extreg,#wcode	;n10*00

	addwfc	0x00,1		; 11 00
	addwfc	*0x00,1		; 11 00
	addwfc	extreg,1	;n11*00
	addwfc	*extreg,1	;n11*00
	addwfc	0x00,#1		; 11 00
	addwfc	*0x00,#1	; 11 00
	addwfc	extreg,#1	;n11*00
	addwfc	*extreg,#1	;n11*00
	addwfc	0x00,fcode	; 11 00
	addwfc	*0x00,fcode	; 11 00
	addwfc	extreg,fcode	;n11*00
	addwfc	*extreg,fcode	;n11*00
	addwfc	0x00,#fcode	; 11 00
	addwfc	*0x00,#fcode	; 11 00
	addwfc	extreg,#fcode	;n11*00
	addwfc	*extreg,#fcode	;n11*00

	comf	0x00,w		; 12 00
	comf	0xFF,w		; 12 FF
	comf	extreg,w	;n12*00

	comf	0x00,f		; 13 00
	comf	0xFF,f		; 13 FF
 	comf	extreg,f	;n13*00

	comf	*0x00,w		; 12 00
	comf	*0xFF,w		; 12 FF
	comf	*extreg,w	;n12*00

	comf	*0x00,f		; 13 00
	comf	*0xFF,f		; 13 FF
 	comf	*extreg,f	;n13*00

	comf	0x00,0		; 12 00
	comf	*0x00,0		; 12 00
	comf	extreg,0	;n12*00
	comf	*extreg,0	;n12*00
	comf	0x00,#0		; 12 00
	comf	*0x00,#0	; 12 00
	comf	extreg,#0	;n12*00
	comf	*extreg,#0	;n12*00
	comf	0x00,wcode	; 12 00
	comf	*0x00,wcode	; 12 00
	comf	extreg,wcode	;n12*00
	comf	*extreg,wcode	;n12*00
	comf	0x00,#wcode	; 12 00
	comf	*0x00,#wcode	; 12 00
	comf	extreg,#wcode	;n12*00
	comf	*extreg,#wcode	;n12*00

	comf	0x00,1		; 13 00
	comf	*0x00,1		; 13 00
	comf	extreg,1	;n13*00
	comf	*extreg,1	;n13*00
	comf	0x00,#1		; 13 00
	comf	*0x00,#1	; 13 00
	comf	extreg,#1	;n13*00
	comf	*extreg,#1	;n13*00
	comf	0x00,fcode	; 13 00
	comf	*0x00,fcode	; 13 00
	comf	extreg,fcode	;n13*00
	comf	*extreg,fcode	;n13*00
	comf	0x00,#fcode	; 13 00
	comf	*0x00,#fcode	; 13 00
	comf	extreg,#fcode	;n13*00
	comf	*extreg,#fcode	;n13*00

	incf	0x00,w		; 14 00
	incf	0xFF,w		; 14 FF
	incf	extreg,w	;n14*00

	incf	0x00,f		; 15 00
	incf	0xFF,f		; 15 FF
	incf	extreg,f	;n15*00

	incf	*0x00,w		; 14 00
	incf	*0xFF,w		; 14 FF
	incf	*extreg,w	;n14*00

	incf	*0x00,f		; 15 00
	incf	*0xFF,f		; 15 FF
	incf	*extreg,f	;n15*00

	incf	0x00,0		; 14 00
	incf	*0x00,0		; 14 00
	incf	extreg,0	;n14*00
	incf	*extreg,0	;n14*00
	incf	0x00,#0		; 14 00
	incf	*0x00,#0	; 14 00
	incf	extreg,#0	;n14*00
	incf	*extreg,#0	;n14*00
	incf	0x00,wcode	; 14 00
	incf	*0x00,wcode	; 14 00
	incf	extreg,wcode	;n14*00
	incf	*extreg,wcode	;n14*00
	incf	0x00,#wcode	; 14 00
	incf	*0x00,#wcode	; 14 00
	incf	extreg,#wcode	;n14*00
	incf	*extreg,#wcode	;n14*00

	incf	0x00,1		; 15 00
	incf	*0x00,1		; 15 00
	incf	extreg,1	;n15*00
	incf	*extreg,1	;n15*00
	incf	0x00,#1		; 15 00
	incf	*0x00,#1	; 15 00
	incf	extreg,#1	;n15*00
	incf	*extreg,#1	;n15*00
	incf	0x00,fcode	; 15 00
	incf	*0x00,fcode	; 15 00
	incf	extreg,fcode	;n15*00
	incf	*extreg,fcode	;n15*00
	incf	0x00,#fcode	; 15 00
	incf	*0x00,#fcode	; 15 00
	incf	extreg,#fcode	;n15*00
	incf	*extreg,#fcode	;n15*00

	decfsz	0x00,w		; 16 00
	decfsz	0xFF,w		; 16 FF
	decfsz	extreg,w	;n16*00

	decfsz	0x00,f		; 17 00
	decfsz	0xFF,f		; 17 FF
	decfsz	extreg,f	;n17*00

	decfsz	*0x00,w		; 16 00
	decfsz	*0xFF,w		; 16 FF
	decfsz	*extreg,w	;n16*00

	decfsz	*0x00,f		; 17 00
	decfsz	*0xFF,f		; 17 FF
 	decfsz	*extreg,f	;n17*00

	decfsz	0x00,0		; 16 00
	decfsz	*0x00,0		; 16 00
	decfsz	extreg,0	;n16*00
	decfsz	*extreg,0	;n16*00
	decfsz	0x00,#0		; 16 00
	decfsz	*0x00,#0	; 16 00
	decfsz	extreg,#0	;n16*00
	decfsz	*extreg,#0	;n16*00
	decfsz	0x00,wcode	; 16 00
	decfsz	*0x00,wcode	; 16 00
	decfsz	extreg,wcode	;n16*00
	decfsz	*extreg,wcode	;n16*00
	decfsz	0x00,#wcode	; 16 00
	decfsz	*0x00,#wcode	; 16 00
	decfsz	extreg,#wcode	;n16*00
	decfsz	*extreg,#wcode	;n16*00

	decfsz	0x00,1		; 17 00
	decfsz	*0x00,1		; 17 00
	decfsz	extreg,1	;n17*00
	decfsz	*extreg,1	;n17*00
	decfsz	0x00,#1		; 17 00
	decfsz	*0x00,#1	; 17 00
	decfsz	extreg,#1	;n17*00
	decfsz	*extreg,#1	;n17*00
	decfsz	0x00,fcode	; 17 00
	decfsz	*0x00,fcode	; 17 00
	decfsz	extreg,fcode	;n17*00
	decfsz	*extreg,fcode	;n17*00
	decfsz	0x00,#fcode	; 17 00
	decfsz	*0x00,#fcode	; 17 00
	decfsz	extreg,#fcode	;n17*00
	decfsz	*extreg,#fcode	;n17*00

	rrcf	0x00,w		; 18 00
	rrcf	0xFF,w		; 18 FF
	rrcf	extreg,w	;n18*00

	rrcf	0x00,f		; 19 00
	rrcf	0xFF,f		; 19 FF
	rrcf	extreg,f	;n19*00

	rrcf	*0x00,w		; 18 00
	rrcf	*0xFF,w		; 18 FF
	rrcf	*extreg,w	;n18*00

	rrcf	*0x00,f		; 19 00
	rrcf	*0xFF,f		; 19 FF
 	rrcf	*extreg,f	;n19*00

	rrcf	0x00,0		; 18 00
	rrcf	*0x00,0		; 18 00
	rrcf	extreg,0	;n18*00
	rrcf	*extreg,0	;n18*00
	rrcf	0x00,#0		; 18 00
	rrcf	*0x00,#0	; 18 00
	rrcf	extreg,#0	;n18*00
	rrcf	*extreg,#0	;n18*00
	rrcf	0x00,wcode	; 18 00
	rrcf	*0x00,wcode	; 18 00
	rrcf	extreg,wcode	;n18*00
	rrcf	*extreg,wcode	;n18*00
	rrcf	0x00,#wcode	; 18 00
	rrcf	*0x00,#wcode	; 18 00
	rrcf	extreg,#wcode	;n18*00
	rrcf	*extreg,#wcode	;n18*00

	rrcf	0x00,1		; 19 00
	rrcf	*0x00,1		; 19 00
	rrcf	extreg,1	;n19*00
	rrcf	*extreg,1	;n19*00
	rrcf	0x00,#1		; 19 00
	rrcf	*0x00,#1	; 19 00
	rrcf	extreg,#1	;n19*00
	rrcf	*extreg,#1	;n19*00
	rrcf	0x00,fcode	; 19 00
	rrcf	*0x00,fcode	; 19 00
	rrcf	extreg,fcode	;n19*00
	rrcf	*extreg,fcode	;n19*00
	rrcf	0x00,#fcode	; 19 00
	rrcf	*0x00,#fcode	; 19 00
	rrcf	extreg,#fcode	;n19*00
	rrcf	*extreg,#fcode	;n19*00

	rlcf	0x00,w		; 1A 00
	rlcf	0xFF,w		; 1A FF
	rlcf	extreg,w	;n1A*00

	rlcf	0x00,f		; 1B 00
	rlcf	0xFF,f		; 1B FF
	rlcf	extreg,f	;n1B*00

	rlcf	*0x00,w		; 1A 00
	rlcf	*0xFF,w		; 1A FF
	rlcf	*extreg,w	;n1A*00

	rlcf	*0x00,f		; 1B 00
	rlcf	*0xFF,f		; 1B FF
	rlcf	*extreg,f	;n1B*00

	rlcf	0x00,0		; 1A 00
	rlcf	*0x00,0		; 1A 00
	rlcf	extreg,0	;n1A*00
	rlcf	*extreg,0	;n1A*00
	rlcf	0x00,#0		; 1A 00
	rlcf	*0x00,#0	; 1A 00
	rlcf	extreg,#0	;n1A*00
	rlcf	*extreg,#0	;n1A*00
	rlcf	0x00,wcode	; 1A 00
	rlcf	*0x00,wcode	; 1A 00
	rlcf	extreg,wcode	;n1A*00
	rlcf	*extreg,wcode	;n1A*00
	rlcf	0x00,#wcode	; 1A 00
	rlcf	*0x00,#wcode	; 1A 00
	rlcf	extreg,#wcode	;n1A*00
	rlcf	*extreg,#wcode	;n1A*00

	rlcf	0x00,1		; 1B 00
	rlcf	*0x00,1		; 1B 00
	rlcf	extreg,1	;n1B*00
	rlcf	*extreg,1	;n1B*00
	rlcf	0x00,#1		; 1B 00
	rlcf	*0x00,#1	; 1B 00
	rlcf	extreg,#1	;n1B*00
	rlcf	*extreg,#1	;n1B*00
	rlcf	0x00,fcode	; 1B 00
	rlcf	*0x00,fcode	; 1B 00
	rlcf	extreg,fcode	;n1B*00
	rlcf	*extreg,fcode	;n1B*00
	rlcf	0x00,#fcode	; 1B 00
	rlcf	*0x00,#fcode	; 1B 00
	rlcf	extreg,#fcode	;n1B*00
	rlcf	*extreg,#fcode	;n1B*00

	swapf	0x00,w		; 1C 00
	swapf	0xFF,w		; 1C FF
	swapf	extreg,w	;n1C*00

	swapf	0x00,f		; 1D 00
	swapf	0xFF,f		; 1D FF
	swapf	extreg,f	;n1D*00

	swapf	*0x00,w		; 1C 00
	swapf	*0xFF,w		; 1C FF
	swapf	*extreg,w	;n1C*00

	swapf	*0x00,f		; 1D 00
	swapf	*0xFF,f		; 1D FF
	swapf	*extreg,f	;n1D*00

	swapf	0x00,0		; 1C 00
	swapf	*0x00,0		; 1C 00
	swapf	extreg,0	;n1C*00
	swapf	*extreg,0	;n1C*00
	swapf	0x00,#0		; 1C 00
	swapf	*0x00,#0	; 1C 00
	swapf	extreg,#0	;n1C*00
	swapf	*extreg,#0	;n1C*00
	swapf	0x00,wcode	; 1C 00
	swapf	*0x00,wcode	; 1C 00
	swapf	extreg,wcode	;n1C*00
	swapf	*extreg,wcode	;n1C*00
	swapf	0x00,#wcode	; 1C 00
	swapf	*0x00,#wcode	; 1C 00
	swapf	extreg,#wcode	;n1C*00
	swapf	*extreg,#wcode	;n1C*00

	swapf	0x00,1		; 1D 00
	swapf	*0x00,1		; 1D 00
	swapf	extreg,1	;n1D*00
	swapf	*extreg,1	;n1D*00
	swapf	0x00,#1		; 1D 00
	swapf	*0x00,#1	; 1D 00
	swapf	extreg,#1	;n1D*00
	swapf	*extreg,#1	;n1D*00
	swapf	0x00,fcode	; 1D 00
	swapf	*0x00,fcode	; 1D 00
	swapf	extreg,fcode	;n1D*00
	swapf	*extreg,fcode	;n1D*00
	swapf	0x00,#fcode	; 1D 00
	swapf	*0x00,#fcode	; 1D 00
	swapf	extreg,#fcode	;n1D*00
	swapf	*extreg,#fcode	;n1D*00

	incfsz	0x00,w		; 1E 00
	incfsz	0xFF,w		; 1E FF
	incfsz	extreg,w	;n1E*00

	incfsz	0x00,f		; 1F 00
	incfsz	0xFF,f		; 1F FF
	incfsz	extreg,f	;n1F*00

	incfsz	*0x00,w		; 1E 00
	incfsz	*0xFF,w		; 1E FF
	incfsz	*extreg,w	;n1E*00

	incfsz	*0x00,f		; 1F 00
	incfsz	*0xFF,f		; 1F FF
	incfsz	*extreg,f	;n1F*00

	incfsz	0x00,0		; 1E 00
	incfsz	*0x00,0		; 1E 00
	incfsz	extreg,0	;n1E*00
	incfsz	*extreg,0	;n1E*00
	incfsz	0x00,#0		; 1E 00
	incfsz	*0x00,#0	; 1E 00
	incfsz	extreg,#0	;n1E*00
	incfsz	*extreg,#0	;n1E*00
	incfsz	0x00,wcode	; 1E 00
	incfsz	*0x00,wcode	; 1E 00
	incfsz	extreg,wcode	;n1E*00
	incfsz	*extreg,wcode	;n1E*00
	incfsz	0x00,#wcode	; 1E 00
	incfsz	*0x00,#wcode	; 1E 00
	incfsz	extreg,#wcode	;n1E*00
	incfsz	*extreg,#wcode	;n1E*00

	incfsz	0x00,1		; 1F 00
	incfsz	*0x00,1		; 1F 00
	incfsz	extreg,1	;n1F*00
	incfsz	*extreg,1	;n1F*00
	incfsz	0x00,#1		; 1F 00
	incfsz	*0x00,#1	; 1F 00
	incfsz	extreg,#1	;n1F*00
	incfsz	*extreg,#1	;n1F*00
	incfsz	0x00,fcode	; 1F 00
	incfsz	*0x00,fcode	; 1F 00
	incfsz	extreg,fcode	;n1F*00
	incfsz	*extreg,fcode	;n1F*00
	incfsz	0x00,#fcode	; 1F 00
	incfsz	*0x00,#fcode	; 1F 00
	incfsz	extreg,#fcode	;n1F*00
	incfsz	*extreg,#fcode	;n1F*00

	rrncf	0x00,w		; 20 00
	rrncf	0xFF,w		; 20 FF
	rrncf	extreg,w	;n20*00

	rrncf	0x00,f		; 21 00
	rrncf	0xFF,f		; 21 FF
	rrncf	extreg,f	;n21*00

	rrncf	*0x00,w		; 20 00
	rrncf	*0xFF,w		; 20 FF
	rrncf	*extreg,w	;n20*00

	rrncf	*0x00,f		; 21 00
	rrncf	*0xFF,f		; 21 FF
 	rrncf	*extreg,f	;n21*00

	rrncf	0x00,0		; 20 00
	rrncf	*0x00,0		; 20 00
	rrncf	extreg,0	;n20*00
	rrncf	*extreg,0	;n20*00
	rrncf	0x00,#0		; 20 00
	rrncf	*0x00,#0	; 20 00
	rrncf	extreg,#0	;n20*00
	rrncf	*extreg,#0	;n20*00
	rrncf	0x00,wcode	; 20 00
	rrncf	*0x00,wcode	; 20 00
	rrncf	extreg,wcode	;n20*00
	rrncf	*extreg,wcode	;n20*00
	rrncf	0x00,#wcode	; 20 00
	rrncf	*0x00,#wcode	; 20 00
	rrncf	extreg,#wcode	;n20*00
	rrncf	*extreg,#wcode	;n20*00

	rrncf	0x00,1		; 21 00
	rrncf	*0x00,1		; 21 00
	rrncf	extreg,1	;n21*00
	rrncf	*extreg,1	;n21*00
	rrncf	0x00,#1		; 21 00
	rrncf	*0x00,#1	; 21 00
	rrncf	extreg,#1	;n21*00
	rrncf	*extreg,#1	;n21*00
	rrncf	0x00,fcode	; 21 00
	rrncf	*0x00,fcode	; 21 00
	rrncf	extreg,fcode	;n21*00
	rrncf	*extreg,fcode	;n21*00
	rrncf	0x00,#fcode	; 21 00
	rrncf	*0x00,#fcode	; 21 00
	rrncf	extreg,#fcode	;n21*00
	rrncf	*extreg,#fcode	;n21*00

	rlncf	0x00,w		; 22 00
	rlncf	0xFF,w		; 22 FF
	rlncf	extreg,w	;n22*00

	rlncf	0x00,f		; 23 00
	rlncf	0xFF,f		; 23 FF
	rlncf	extreg,f	;n23*00
	rlncf	*0x00,w		; 22 00

	rlncf	*0xFF,w		; 22 FF
	rlncf	*extreg,w	;n22*00
	rlncf	*0x00,f		; 23 00

	rlncf	*0xFF,f		; 23 FF
	rlncf	*extreg,f	;n23*00
	rlncf	0x00,0		; 22 00

	rlncf	*0x00,0		; 22 00
	rlncf	extreg,0	;n22*00
	rlncf	*extreg,0	;n22*00
	rlncf	0x00,#0		; 22 00
	rlncf	*0x00,#0	; 22 00
	rlncf	extreg,#0	;n22*00
	rlncf	*extreg,#0	;n22*00
	rlncf	0x00,wcode	; 22 00
	rlncf	*0x00,wcode	; 22 00
	rlncf	extreg,wcode	;n22*00
	rlncf	*extreg,wcode	;n22*00
	rlncf	0x00,#wcode	; 22 00
	rlncf	*0x00,#wcode	; 22 00
	rlncf	extreg,#wcode	;n22*00
	rlncf	*extreg,#wcode	;n22*00

	rlncf	0x00,1		; 23 00
	rlncf	*0x00,1		; 23 00
	rlncf	extreg,1	;n23*00
	rlncf	*extreg,1	;n23*00
	rlncf	0x00,#1		; 23 00
	rlncf	*0x00,#1	; 23 00
	rlncf	extreg,#1	;n23*00
	rlncf	*extreg,#1	;n23*00
	rlncf	0x00,fcode	; 23 00
	rlncf	*0x00,fcode	; 23 00
	rlncf	extreg,fcode	;n23*00
	rlncf	*extreg,fcode	;n23*00
	rlncf	0x00,#fcode	; 23 00
	rlncf	*0x00,#fcode	; 23 00
	rlncf	extreg,#fcode	;n23*00
	rlncf	*extreg,#fcode	;n23*00

	infsnz	0x00,w		; 24 00
	infsnz	0xFF,w		; 24 FF
	infsnz	extreg,w	;n24*00

	infsnz	0x00,f		; 25 00
	infsnz	0xFF,f		; 25 FF
	infsnz	extreg,f	;n25*00

	infsnz	*0x00,w		; 24 00
	infsnz	*0xFF,w		; 24 FF
	infsnz	*extreg,w	;n24*00

	infsnz	*0x00,f		; 25 00
	infsnz	*0xFF,f		; 25 FF
	infsnz	*extreg,f	;n25*00

	infsnz	0x00,0		; 24 00
	infsnz	*0x00,0		; 24 00
	infsnz	extreg,0	;n24*00
	infsnz	*extreg,0	;n24*00
	infsnz	0x00,#0		; 24 00
	infsnz	*0x00,#0	; 24 00
	infsnz	extreg,#0	;n24*00
	infsnz	*extreg,#0	;n24*00
	infsnz	0x00,wcode	; 24 00
	infsnz	*0x00,wcode	; 24 00
	infsnz	extreg,wcode	;n24*00
	infsnz	*extreg,wcode	;n24*00
	infsnz	0x00,#wcode	; 24 00
	infsnz	*0x00,#wcode	; 24 00
	infsnz	extreg,#wcode	;n24*00
	infsnz	*extreg,#wcode	;n24*00

	infsnz	0x00,1		; 25 00
	infsnz	*0x00,1		; 25 00
	infsnz	extreg,1	;n25*00
	infsnz	*extreg,1	;n25*00
	infsnz	0x00,#1		; 25 00
	infsnz	*0x00,#1	; 25 00
	infsnz	extreg,#1	;n25*00
	infsnz	*extreg,#1	;n25*00
	infsnz	0x00,fcode	; 25 00
	infsnz	*0x00,fcode	; 25 00
	infsnz	extreg,fcode	;n25*00
	infsnz	*extreg,fcode	;n25*00
	infsnz	0x00,#fcode	; 25 00
	infsnz	*0x00,#fcode	; 25 00
	infsnz	extreg,#fcode	;n25*00
	infsnz	*extreg,#fcode	;n25*00

	dcfsnz	0x00,w		; 26 00
	dcfsnz	0xFF,w		; 26 FF
	dcfsnz	extreg,w	;n26*00

	dcfsnz	0x00,f		; 27 00
	dcfsnz	0xFF,f		; 27 FF
	dcfsnz	extreg,f	;n27*00

	dcfsnz	*0x00,w		; 26 00
	dcfsnz	*0xFF,w		; 26 FF
	dcfsnz	*extreg,w	;n26*00

	dcfsnz	*0x00,f		; 27 00
	dcfsnz	*0xFF,f		; 27 FF
 	dcfsnz	*extreg,f	;n27*00

	dcfsnz	0x00,0		; 26 00
	dcfsnz	*0x00,0		; 26 00
	dcfsnz	extreg,0	;n26*00
	dcfsnz	*extreg,0	;n26*00
	dcfsnz	0x00,#0		; 26 00
	dcfsnz	*0x00,#0	; 26 00
	dcfsnz	extreg,#0	;n26*00
	dcfsnz	*extreg,#0	;n26*00
	dcfsnz	0x00,wcode	; 26 00
	dcfsnz	*0x00,wcode	; 26 00
	dcfsnz	extreg,wcode	;n26*00
	dcfsnz	*extreg,wcode	;n26*00
	dcfsnz	0x00,#wcode	; 26 00
	dcfsnz	*0x00,#wcode	; 26 00
	dcfsnz	extreg,#wcode	;n26*00
	dcfsnz	*extreg,#wcode	;n26*00

	dcfsnz	0x00,1		; 27 00
	dcfsnz	*0x00,1		; 27 00
	dcfsnz	extreg,1	;n27*00
	dcfsnz	*extreg,1	;n27*00
	dcfsnz	0x00,#1		; 27 00
	dcfsnz	*0x00,#1	; 27 00
	dcfsnz	extreg,#1	;n27*00
	dcfsnz	*extreg,#1	;n27*00
	dcfsnz	0x00,fcode	; 27 00
	dcfsnz	*0x00,fcode	; 27 00
	dcfsnz	extreg,fcode	;n27*00
	dcfsnz	*extreg,fcode	;n27*00
	dcfsnz	0x00,#fcode	; 27 00
	dcfsnz	*0x00,#fcode	; 27 00
	dcfsnz	extreg,#fcode	;n27*00
	dcfsnz	*extreg,#fcode	;n27*00

	clrf	0x00,w		; 28 00
	clrf	0xFF,w		; 28 FF
	clrf	extreg,w	;n28*00

	clrf	*0x00,w		; 28 00
	clrf	*0xFF,w		; 28 FF
	clrf	*extreg,w	;n28*00
	
	clrf	0x00,f		; 29 00
	clrf	0xFF,f		; 29 FF
	clrf	extreg,f	;n29*00

	clrf	*0x00,f		; 29 00
	clrf	*0xFF,f		; 29 FF
	clrf	*extreg,f	;n29*00

	clrf	0x00,0		; 28 00
	clrf	*0x00,0		; 28 00
	clrf	extreg,0	;n28*00
	clrf	*extreg,0	;n28*00
	clrf	0x00,#0		; 28 00
	clrf	*0x00,#0	; 28 00
	clrf	extreg,#0	;n28*00
	clrf	*extreg,#0	;n28*00
	clrf	0x00,wcode	; 28 00
	clrf	*0x00,wcode	; 28 00
	clrf	extreg,wcode	;n28*00
	clrf	*extreg,wcode	;n28*00
	clrf	0x00,#wcode	; 28 00
	clrf	*0x00,#wcode	; 28 00
	clrf	extreg,#wcode	;n28*00
	clrf	*extreg,#wcode	;n28*00

	clrf	0x00,1		; 29 00
	clrf	*0x00,1		; 29 00
	clrf	extreg,1	;n29*00
	clrf	*extreg,1	;n29*00
	clrf	0x00,#1		; 29 00
	clrf	*0x00,#1	; 29 00
	clrf	extreg,#1	;n29*00
	clrf	*extreg,#1	;n29*00
	clrf	0x00,fcode	; 29 00
	clrf	*0x00,fcode	; 29 00
	clrf	extreg,fcode	;n29*00
	clrf	*extreg,fcode	;n29*00
	clrf	0x00,#fcode	; 29 00
	clrf	*0x00,#fcode	; 29 00
	clrf	extreg,#fcode	;n29*00
	clrf	*extreg,#fcode	;n29*00

	setf	0x00,w		; 2A 00
	setf	0xFF,w		; 2A FF
	setf	extreg,w	;n2A*00

	setf	*0x00,w		; 2A 00
	setf	*0xFF,w		; 2A FF
	setf	*extreg,w	;n2A*00

	setf	0x00,f		; 2B 00
	setf	0xFF,f		; 2B FF
	setf	extreg,f	;n2B*00

	setf	*0x00,f		; 2B 00
	setf	*0xFF,f		; 2B FF
	setf	*extreg,f	;n2B*00

	setf	0x00,0		; 2A 00
	setf	*0x00,0		; 2A 00
	setf	extreg,0	;n2A*00
	setf	*extreg,0	;n2A*00
	setf	0x00,#0		; 2A 00
	setf	*0x00,#0	; 2A 00
	setf	extreg,#0	;n2A*00
	setf	*extreg,#0	;n2A*00
	setf	0x00,wcode	; 2A 00
	setf	*0x00,wcode	; 2A 00
	setf	extreg,wcode	;n2A*00
	setf	*extreg,wcode	;n2A*00
	setf	0x00,#wcode	; 2A 00
	setf	*0x00,#wcode	; 2A 00
	setf	extreg,#wcode	;n2A*00
	setf	*extreg,#wcode	;n2A*00

	setf	0x00,1		; 2B 00
	setf	*0x00,1		; 2B 00
	setf	extreg,1	;n2B*00
	setf	*extreg,1	;n2B*00
	setf	0x00,#1		; 2B 00
	setf	*0x00,#1	; 2B 00
	setf	extreg,#1	;n2B*00
	setf	*extreg,#1	;n2B*00
	setf	0x00,fcode	; 2B 00
	setf	*0x00,fcode	; 2B 00
	setf	extreg,fcode	;n2B*00
	setf	*extreg,fcode	;n2B*00
	setf	0x00,#fcode	; 2B 00
	setf	*0x00,#fcode	; 2B 00
	setf	extreg,#fcode	;n2B*00
	setf	*extreg,#fcode	;n2B*00

	negw	0x00,w		; 2C 00
	negw	0xFF,w		; 2C FF
	negw	extreg,w	;n2C*00

	negw	*0x00,w		; 2C 00
	negw	*0xFF,w		; 2C FF
	negw	*extreg,w	;n2C*00

	negw	0x00,f		; 2D 00
	negw	0xFF,f		; 2D FF
	negw	extreg,f	;n2D*00

	negw	*0x00,f		; 2D 00
	negw	*0xFF,f		; 2D FF
	negw	*extreg,f	;n2D*00

	negw	0x00,0		; 2C 00
	negw	*0x00,0		; 2C 00
	negw	extreg,0	;n2C*00
	negw	*extreg,0	;n2C*00
	negw	0x00,#0		; 2C 00
	negw	*0x00,#0	; 2C 00
	negw	extreg,#0	;n2C*00
	negw	*extreg,#0	;n2C*00
	negw	0x00,wcode	; 2C 00
	negw	*0x00,wcode	; 2C 00
	negw	extreg,wcode	;n2C*00
	negw	*extreg,wcode	;n2C*00
	negw	0x00,#wcode	; 2C 00
	negw	*0x00,#wcode	; 2C 00
	negw	extreg,#wcode	;n2C*00
	negw	*extreg,#wcode	;n2C*00

	negw	0x00,1		; 2D 00
	negw	*0x00,1		; 2D 00
	negw	extreg,1	;n2D*00
	negw	*extreg,1	;n2D*00
	negw	0x00,#1		; 2D 00
	negw	*0x00,#1	; 2D 00
	negw	extreg,#1	;n2D*00
	negw	*extreg,#1	;n2D*00
	negw	0x00,fcode	; 2D 00
	negw	*0x00,fcode	; 2D 00
	negw	extreg,fcode	;n2D*00
	negw	*extreg,fcode	;n2D*00
	negw	0x00,#fcode	; 2D 00
	negw	*0x00,#fcode	; 2D 00
	negw	extreg,#fcode	;n2D*00
	negw	*extreg,#fcode	;n2D*00

	daw	0x00,w		; 2E 00
	daw	0xFF,w		; 2E FF
	daw	extreg,w	;n2E*00

	daw	*0x00,w		; 2E 00
	daw	*0xFF,w		; 2E FF
	daw	*extreg,w	;n2E*00

	daw	0x00,f		; 2F 00
	daw	0xFF,f		; 2F FF
	daw	extreg,f	;n2F*00

	daw	*0x00,f		; 2F 00
	daw	*0xFF,f		; 2F FF
	daw	*extreg,f	;n2F*00

	daw	0x00,0		; 2E 00
	daw	*0x00,0		; 2E 00
	daw	extreg,0	;n2E*00
	daw	*extreg,0	;n2E*00
	daw	0x00,#0		; 2E 00
	daw	*0x00,#0	; 2E 00
	daw	extreg,#0	;n2E*00
	daw	*extreg,#0	;n2E*00
	daw	0x00,wcode	; 2E 00
	daw	*0x00,wcode	; 2E 00
	daw	extreg,wcode	;n2E*00
	daw	*extreg,wcode	;n2E*00
	daw	0x00,#wcode	; 2E 00
	daw	*0x00,#wcode	; 2E 00
	daw	extreg,#wcode	;n2E*00
	daw	*extreg,#wcode	;n2E*00

	daw	0x00,1		; 2F 00
	daw	*0x00,1		; 2F 00
	daw	extreg,1	;n2F*00
	daw	*extreg,1	;n2F*00
	daw	0x00,#1		; 2F 00
	daw	*0x00,#1	; 2F 00
	daw	extreg,#1	;n2F*00
	daw	*extreg,#1	;n2F*00
	daw	0x00,fcode	; 2F 00
	daw	*0x00,fcode	; 2F 00
	daw	extreg,fcode	;n2F*00
	daw	*extreg,fcode	;n2F*00
	daw	0x00,#fcode	; 2F 00
	daw	*0x00,#fcode	; 2F 00
	daw	extreg,#fcode	;n2F*00
	daw	*extreg,#fcode	;n2F*00

	cpfslt	0x00		; 30 00
	cpfslt	0xFF		; 30 FF
	cpfslt	extreg		;n30*00

	cpfslt	*0x00		; 30 00
	cpfslt	*0xFF		; 30 FF
	cpfslt	*extreg		;n30*00

	cpfseq	0x00		; 31 00
	cpfseq	0xFF		; 31 FF
	cpfseq	extreg		;n31*00

	cpfseq	*0x00		; 31 00
	cpfseq	*0xFF		; 31 FF
	cpfseq	*extreg		;n31*00

	cpfsgt	0x00		; 32 00
	cpfsgt	0xFF		; 32 FF
	cpfsgt	extreg		;n32*00

	cpfsgt	*0x00		; 32 00
	cpfsgt	*0xFF		; 32 FF
	cpfsgt	*extreg		;n32*00

	tstfsz	0x00		; 33 00
	tstfsz	0xFF		; 33 FF
	tstfsz	extreg		;n33*00

	tstfsz	*0x00		; 33 00
	tstfsz	*0xFF		; 33 FF
	tstfsz	*extreg		;n33*00

	mulwf	0x00		; 34 00
	mulwf	0xFF		; 34 FF
	mulwf	extreg		;n34*00

	mulwf	*0x00		; 34 00
	mulwf	*0xFF		; 34 FF
	mulwf	*extreg		;n34*00

	btg	0x00,0		; 38 00
	btg	0xFF,0		; 38 FF
	btg	extreg,0	;n38*00

	btg	0x00,7		; 3F 00
	btg	0xFF,7		; 3F FF
	btg	extreg,7	;n3F*00

	btg	*0x00,0		; 38 00
	btg	*0xFF,0		; 38 FF
	btg	*extreg,0	;n38*00

	btg	*0x00,7		; 3F 00
	btg	*0xFF,7		; 3F FF
	btg	*extreg,7	;n3F*00

	btg	0x00,num0	; 38 00
	btg	*0x00,num0	; 38 00
	btg	extreg,num0	;n38*00
	btg	*extreg,num0	;n38*00
	btg	0x00,#num0	; 38 00
	btg	*0x00,#num0	; 38 00
	btg	extreg,#num0	;n38*00
	btg	*extreg,#num0	;n38*00

	btg	0x00,num7	; 3F 00
	btg	*0x00,num7	; 3F 00
	btg	extreg,num7	;n3F*00
	btg	*extreg,num7	;n3F*00
	btg	0x00,#num7	; 3F 00
	btg	*0x00,#num7	; 3F 00
	btg	extreg,#num7	;n3F*00
	btg	*extreg,#num7	;n3F*00

	movpf	0x00,0x00	; 40 00
	movpf	0x1F,*0x00	; 5F 00
	movpf	0x00,0xFF	; 40 FF
	movpf	0x1F,*0xFF	; 5F FF
	movpf	0x00,extreg	;n40*00
	movpf	0x1F,*extreg	;n5F*00

	movpf	*0x00,0x00	; 40 00
	movpf	*0x1F,*0x00	; 5F 00
	movpf	*0x00,0xFF	; 40 FF
	movpf	*0x1F,*0xFF	; 5F FF
	movpf	*0x00,extreg	;n40*00
	movpf	*0x1F,*extreg	;n5F*00

	movfp	0x00,0x00	; 60 00
	movfp	*0x00,0x1F	; 7F 00
	movfp	0xFF,0x00	; 60 FF
	movfp	*0xFF,0x1F	; 7F FF
	movfp	extreg,0x00	;n60*00
	movfp	*extreg,0x1F	;n7F*00

	movfp	0x00,*0x00	; 60 00
	movfp	*0x00,*0x1F	; 7F 00
	movfp	0xFF,*0x00	; 60 FF
	movfp	*0xFF,*0x1F	; 7F FF
	movfp	extreg,*0x00	;n60*00
	movfp	*extreg,*0x1F	;n7F*00

	bsf	0x00,0		; 80 00
	bsf	0xFF,0		; 80 FF
	bsf	extreg,0	;n80*00

	bsf	0x00,7		; 87 00
	bsf	0xFF,7		; 87 FF
	bsf	extreg,7	;n87*00

	bsf	*0x00,0		; 80 00
	bsf	*0xFF,0		; 80 FF
	bsf	*extreg,0	;n80*00

	bsf	*0x00,7		; 87 00
	bsf	*0xFF,7		; 87 FF
 	bsf	*extreg,7	;n87*00

	bsf	0x00,num0	; 80 00
	bsf	*0x00,num0	; 80 00
	bsf	extreg,num0	;n80*00
	bsf	*extreg,num0	;n80*00
	bsf	0x00,#num0	; 80 00
	bsf	*0x00,#num0	; 80 00
	bsf	extreg,#num0	;n80*00
	bsf	*extreg,#num0	;n80*00

	bsf	0x00,num7	; 87 00
	bsf	*0x00,num7	; 87 00
	bsf	extreg,num7	;n87*00
	bsf	*extreg,num7	;n87*00
	bsf	0x00,#num7	; 87 00
	bsf	*0x00,#num7	; 87 00
	bsf	extreg,#num7	;n87*00
	bsf	*extreg,#num7	;n87*00

	bcf	0x00,0		; 88 00
	bcf	0xFF,0		; 88 FF
	bcf	extreg,0	;n88*00

	bcf	0x00,7		; 8F 00
	bcf	0xFF,7		; 8F FF
	bcf	extreg,7	;n8F*00

	bcf	*0x00,0		; 88 00
	bcf	*0xFF,0		; 88 FF
	bcf	*extreg,0	;n88*00

	bcf	*0x00,7		; 8F 00
	bcf	*0xFF,7		; 8F FF
	bcf	*extreg,7	;n8F*00

	bcf	0x00,num0	; 88 00
	bcf	*0x00,num0	; 88 00
	bcf	extreg,num0	;n88*00
	bcf	*extreg,num0	;n88*00
	bcf	0x00,#num0	; 88 00
	bcf	*0x00,#num0	; 88 00
	bcf	extreg,#num0	;n88*00
	bcf	*extreg,#num0	;n88*00

	bcf	0x00,num7	; 8F 00
	bcf	*0x00,num7	; 8F 00
	bcf	extreg,num7	;n8F*00
	bcf	*extreg,num7	;n8F*00
	bcf	0x00,#num7	; 8F 00
	bcf	*0x00,#num7	; 8F 00
	bcf	extreg,#num7	;n8F*00
	bcf	*extreg,#num7	;n8F*00

	btfss	0x00,0		; 90 00
	btfss	0xFF,0		; 90 FF
	btfss	extreg,0	;n90*00

	btfss	0x00,7		; 97 00
	btfss	0xFF,7		; 97 FF
	btfss	extreg,7	;n97*00

	btfss	*0x00,0		; 90 00
	btfss	*0xFF,0		; 90 FF
	btfss	*extreg,0	;n90*00

	btfss	*0x00,7		; 97 00
	btfss	*0xFF,7		; 97 FF
	btfss	*extreg,7	;n97*00

	btfss	0x00,num0	; 90 00
	btfss	*0x00,num0	; 90 00
	btfss	extreg,num0	;n90*00
	btfss	*extreg,num0	;n90*00
	btfss	0x00,#num0	; 90 00
	btfss	*0x00,#num0	; 90 00
	btfss	extreg,#num0	;n90*00
	btfss	*extreg,#num0	;n90*00

	btfss	0x00,num7	; 97 00
	btfss	*0x00,num7	; 97 00
	btfss	extreg,num7	;n97*00
	btfss	*extreg,num7	;n97*00
	btfss	0x00,#num7	; 97 00
	btfss	*0x00,#num7	; 97 00
	btfss	extreg,#num7	;n97*00
	btfss	*extreg,#num7	;n97*00

	btfsc	0x00,0		; 98 00
	btfsc	0xFF,0		; 98 FF
	btfsc	extreg,0	;n98*00

	btfsc	0x00,7		; 9F 00
	btfsc	0xFF,7		; 9F FF
	btfsc	extreg,7	;n9F*00

	btfsc	*0x00,0		; 98 00
	btfsc	*0xFF,0		; 98 FF
	btfsc	*extreg,0	;n98*00

	btfsc	*0x00,7		; 9F 00
	btfsc	*0xFF,7		; 9F FF
	btfsc	*extreg,7	;n9F*00

	btfsc	0x00,num0	; 98 00
	btfsc	*0x00,num0	; 98 00
	btfsc	extreg,num0	;n98*00
	btfsc	*extreg,num0	;n98*00
	btfsc	0x00,#num0	; 98 00
	btfsc	*0x00,#num0	; 98 00
	btfsc	extreg,#num0	;n98*00
	btfsc	*extreg,#num0	;n98*00

	btfsc	0x00,num7	; 9F 00
	btfsc	*0x00,num7	; 9F 00
	btfsc	extreg,num7	;n9F*00
	btfsc	*extreg,num7	;n9F*00
	btfsc	0x00,#num7	; 9F 00
	btfsc	*0x00,#num7	; 9F 00
	btfsc	extreg,#num7	;n9F*00
	btfsc	*extreg,#num7	;n9F*00

	tlrd	0,0x00		; A0 00
	tlrd	0,0xFF		; A0 FF
	tlrd	0,extreg	;nA0*00

	tlrd	1,0x00		; A2 00
	tlrd	1,0xFF		; A2 FF
	tlrd	1,extreg	;nA2*00

	tlrd	0,*0x00		; A0 00
	tlrd	0,*0xFF		; A0 FF
	tlrd	0,*extreg	;nA0*00

	tlrd	1,*0x00		; A2 00
	tlrd	1,*0xFF		; A2 FF
	tlrd	1,*extreg	;nA2*00

	tlrd	num0,0x00	; A0 00
	tlrd	num0,*0xFF	; A0 FF
	tlrd	num0,extreg	;nA0*00
	tlrd	num0,*extreg	;nA0*00
	tlrd	#num0,0x00	; A0 00
	tlrd	#num0,*0xFF	; A0 FF
	tlrd	#num0,extreg	;nA0*00
	tlrd	#num0,*extreg	;nA0*00

	tlrd	num1,0x00	; A2 00
	tlrd	num1,*0xFF	; A2 FF
	tlrd	num1,extreg	;nA2*00
	tlrd	num1,*extreg	;nA2*00
	tlrd	#num1,0x00	; A2 00
	tlrd	#num1,*0xFF	; A2 FF
	tlrd	#num1,extreg	;nA2*00
	tlrd	#num1,*extreg	;nA2*00

	tlwt	0,0x00		; A4 00
	tlwt	0,0xFF		; A4 FF
	tlwt	0,extreg	;nA4*00

	tlwt	1,0x00		; A6 00
	tlwt	1,0xFF		; A6 FF
	tlwt	1,extreg	;nA6*00

	tlwt	0,*0x00		; A4 00
	tlwt	0,*0xFF		; A4 FF
	tlwt	0,*extreg	;nA4*00

	tlwt	1,*0x00		; A6 00
	tlwt	1,*0xFF		; A6 FF
	tlwt	1,*extreg	;nA6*00

	tlwt	num0,0x00	; A4 00
	tlwt	num0,*0xFF	; A4 FF
	tlwt	num0,extreg	;nA4*00
	tlwt	num0,*extreg	;nA4*00
	tlwt	#num0,0x00	; A4 00
	tlwt	#num0,*0xFF	; A4 FF
	tlwt	#num0,extreg	;nA4*00
	tlwt	#num0,*extreg	;nA4*00

	tlwt	num1,0x00	; A6 00
	tlwt	num1,*0xFF	; A6 FF
	tlwt	num1,extreg	;nA6*00
	tlwt	num1,*extreg	;nA6*00
	tlwt	#num1,0x00	; A6 00
	tlwt	#num1,*0xFF	; A6 FF
	tlwt	#num1,extreg	;nA6*00
	tlwt	#num1,*extreg	;nA6*00

	tablrd	0,0,0x00	; A8 00
	tablrd	0,0,0xFF	; A8 FF
	tablrd	0,0,extreg	;nA8*00

	tablrd	0,1,0x00	; A9 00
	tablrd	0,1,0xFF	; A9 FF
	tablrd	0,1,extreg	;nA9*00

	tablrd	1,0,0x00	; AA 00
	tablrd	1,0,0xFF	; AA FF
	tablrd	1,0,extreg	;nAA*00

	tablrd	1,1,0x00	; AB 00
	tablrd	1,1,0xFF	; AB FF
	tablrd	1,1,extreg	;nAB*00

	tablrd	0,0,*0x00	; A8 00
	tablrd	0,0,*0xFF	; A8 FF
	tablrd	0,0,*extreg	;nA8*00

	tablrd	0,1,*0x00	; A9 00
	tablrd	0,1,*0xFF	; A9 FF
	tablrd	0,1,*extreg	;nA9*00

	tablrd	1,0,*0x00	; AA 00
	tablrd	1,0,*0xFF	; AA FF
	tablrd	1,0,*extreg	;nAA*00

	tablrd	1,1,*0x00	; AB 00
	tablrd	1,1,*0xFF	; AB FF
	tablrd	1,1,*extreg	;nAB*00

	tablrd	num0,num0,0x00		; A8 00
	tablrd	num0,num0,*0xFF		; A8 FF
	tablrd	num0,num0,extreg	;nA8*00
	tablrd	num0,num0,*extreg	;nA8*00

	tablrd	#num0,num0,0x00		; A8 00
	tablrd	#num0,num0,*0xFF	; A8 FF
	tablrd	#num0,num0,extreg	;nA8*00
	tablrd	#num0,num0,*extreg	;nA8*00

	tablrd	num1,num0,0x00		; AA 00
	tablrd	num1,num0,*0xFF		; AA FF
	tablrd	num1,num0,extreg	;nAA*00
	tablrd	num1,num0,*extreg	;nAA*00

	tablrd	#num1,num0,0x00		; AA 00
	tablrd	#num1,num0,*0xFF	; AA FF
	tablrd	#num1,num0,extreg	;nAA*00
	tablrd	#num1,num0,*extreg	;nAA*00

	tablrd	num0,#num0,0x00		; A8 00
	tablrd	num0,#num0,*0xFF	; A8 FF
	tablrd	num0,#num0,extreg	;nA8*00
	tablrd	num0,#num0,*extreg	;nA8*00

	tablrd	#num0,#num0,0x00	; A8 00
	tablrd	#num0,#num0,*0xFF	; A8 FF
	tablrd	#num0,#num0,extreg	;nA8*00
	tablrd	#num0,#num0,*extreg	;nA8*00

	tablrd	num1,#num0,0x00		; AA 00
	tablrd	num1,#num0,*0xFF	; AA FF
	tablrd	num1,#num0,extreg	;nAA*00
	tablrd	num1,#num0,*extreg	;nAA*00

	tablrd	#num1,#num0,0x00	; AA 00
	tablrd	#num1,#num0,*0xFF	; AA FF
	tablrd	#num1,#num0,extreg	;nAA*00
	tablrd	#num1,#num0,*extreg	;nAA*00

	tablrd	num0,num1,0x00		; A9 00
	tablrd	num0,num1,*0xFF		; A9 FF
	tablrd	num0,num1,extreg	;nA9*00
	tablrd	num0,num1,*extreg	;nA9*00

	tablrd	#num0,num1,0x00		; A9 00
	tablrd	#num0,num1,*0xFF	; A9 FF
	tablrd	#num0,num1,extreg	;nA9*00
	tablrd	#num0,num1,*extreg	;nA9*00

	tablrd	num1,num1,0x00		; AB 00
	tablrd	num1,num1,*0xFF		; AB FF
	tablrd	num1,num1,extreg	;nAB*00
	tablrd	num1,num1,*extreg	;nAB*00

	tablrd	#num1,num1,0x00		; AB 00
	tablrd	#num1,num1,*0xFF	; AB FF
	tablrd	#num1,num1,extreg	;nAB*00
	tablrd	#num1,num1,*extreg	;nAB*00

	tablrd	num0,#num1,0x00		; A9 00
	tablrd	num0,#num1,*0xFF	; A9 FF
	tablrd	num0,#num1,extreg	;nA9*00
	tablrd	num0,#num1,*extreg	;nA9*00

	tablrd	#num0,#num1,0x00	; A9 00
	tablrd	#num0,#num1,*0xFF	; A9 FF
	tablrd	#num0,#num1,extreg	;nA9*00
	tablrd	#num0,#num1,*extreg	;nA9*00

	tablrd	num1,#num1,0x00		; AB 00
	tablrd	num1,#num1,*0xFF	; AB FF
	tablrd	num1,#num1,extreg	;nAB*00
	tablrd	num1,#num1,*extreg	;nAB*00

	tablrd	#num1,#num1,0x00	; AB 00
	tablrd	#num1,#num1,*0xFF	; AB FF
	tablrd	#num1,#num1,extreg	;nAB*00
	tablrd	#num1,#num1,*extreg	;nAB*00

	tablwt	0,0,0x00	; AC 00
	tablwt	0,0,0xFF	; AC FF
	tablwt	0,0,extreg	;nAC*00

	tablwt	0,1,0x00	; AD 00
	tablwt	0,1,0xFF	; AD FF
	tablwt	0,1,extreg	;nAD*00

	tablwt	1,0,0x00	; AE 00
	tablwt	1,0,0xFF	; AE FF
	tablwt	1,0,extreg	;nAE*00

	tablwt	1,1,0x00	; AF 00
	tablwt	1,1,0xFF	; AF FF
	tablwt	1,1,extreg	;nAF*00

	tablwt	0,0,*0x00	; AC 00
	tablwt	0,0,*0xFF	; AC FF
	tablwt	0,0,*extreg	;nAC*00

	tablwt	0,1,*0x00	; AD 00
	tablwt	0,1,*0xFF	; AD FF
	tablwt	0,1,*extreg	;nAD*00

	tablwt	1,0,*0x00	; AE 00
	tablwt	1,0,*0xFF	; AE FF
	tablwt	1,0,*extreg	;nAE*00

	tablwt	1,1,*0x00	; AF 00
	tablwt	1,1,*0xFF	; AF FF
	tablwt	1,1,*extreg	;nAF*00

	tablwt	num0,num0,0x00		; AC 00
	tablwt	num0,num0,*0xFF		; AC FF
	tablwt	num0,num0,extreg	;nAC*00
	tablwt	num0,num0,*extreg	;nAC*00

	tablwt	#num0,num0,0x00		; AC 00
	tablwt	#num0,num0,*0xFF	; AC FF
	tablwt	#num0,num0,extreg	;nAC*00
	tablwt	#num0,num0,*extreg	;nAC*00

	tablwt	num1,num0,0x00		; AE 00
	tablwt	num1,num0,*0xFF		; AE FF
	tablwt	num1,num0,extreg	;nAE*00
	tablwt	num1,num0,*extreg	;nAE*00

	tablwt	#num1,num0,0x00		; AE 00
	tablwt	#num1,num0,*0xFF	; AE FF
	tablwt	#num1,num0,extreg	;nAE*00
	tablwt	#num1,num0,*extreg	;nAE*00

	tablwt	num0,#num0,0x00		; AC 00
	tablwt	num0,#num0,*0xFF	; AC FF
	tablwt	num0,#num0,extreg	;nAC*00
	tablwt	num0,#num0,*extreg	;nAC*00

	tablwt	#num0,#num0,0x00	; AC 00
	tablwt	#num0,#num0,*0xFF	; AC FF
	tablwt	#num0,#num0,extreg	;nAC*00
	tablwt	#num0,#num0,*extreg	;nAC*00

	tablwt	num1,#num0,0x00		; AE 00
	tablwt	num1,#num0,*0xFF	; AE FF
	tablwt	num1,#num0,extreg	;nAE*00
	tablwt	num1,#num0,*extreg	;nAE*00

	tablwt	#num1,#num0,0x00	; AE 00
	tablwt	#num1,#num0,*0xFF	; AE FF
	tablwt	#num1,#num0,extreg	;nAE*00
	tablwt	#num1,#num0,*extreg	;nAE*00

	tablwt	num0,num1,0x00		; AD 00
	tablwt	num0,num1,*0xFF		; AD FF
	tablwt	num0,num1,extreg	;nAD*00
	tablwt	num0,num1,*extreg	;nAD*00

	tablwt	#num0,num1,0x00		; AD 00
	tablwt	#num0,num1,*0xFF	; AD FF
	tablwt	#num0,num1,extreg	;nAD*00
	tablwt	#num0,num1,*extreg	;nAD*00

	tablwt	num1,num1,0x00		; AF 00
	tablwt	num1,num1,*0xFF		; AF FF
	tablwt	num1,num1,extreg	;nAF*00
	tablwt	num1,num1,*extreg	;nAF*00

	tablwt	#num1,num1,0x00		; AF 00
	tablwt	#num1,num1,*0xFF	; AF FF
	tablwt	#num1,num1,extreg	;nAF*00
	tablwt	#num1,num1,*extreg	;nAF*00

	tablwt	num0,#num1,0x00		; AD 00
	tablwt	num0,#num1,*0xFF	; AD FF
	tablwt	num0,#num1,extreg	;nAD*00
	tablwt	num0,#num1,*extreg	;nAD*00

	tablwt	#num0,#num1,0x00	; AD 00
	tablwt	#num0,#num1,*0xFF	; AD FF
	tablwt	#num0,#num1,extreg	;nAD*00
	tablwt	#num0,#num1,*extreg	;nAD*00

	tablwt	num1,#num1,0x00		; AF 00
	tablwt	num1,#num1,*0xFF	; AF FF
	tablwt	num1,#num1,extreg	;nAF*00
	tablwt	num1,#num1,*extreg	;nAF*00

	tablwt	#num1,#num1,0x00	; AF 00
	tablwt	#num1,#num1,*0xFF	; AF FF
	tablwt	#num1,#num1,extreg	;nAF*00
	tablwt	#num1,#num1,*extreg	;nAF*00

	movlw	0x00		; B0 00
	movlw	0xFF		; B0 FF
	movlw	extvalu		;sB0r00

	movlw	#0x00		; B0 00
	movlw	#0xFF		; B0 FF
	movlw	#extvalu	;sB0r00

	addlw	0x00		; B1 00
	addlw	0xFF		; B1 FF
	addlw	extvalu		;sB1r00

	addlw	#0x00		; B1 00
	addlw	#0xFF		; B1 FF
	addlw	#extvalu	;sB1r00

	sublw	0x00		; B2 00
	sublw	0xFF		; B2 FF
	sublw	extvalu		;sB2r00

	sublw	#0x00		; B2 00
	sublw	#0xFF		; B2 FF
	sublw	#extvalu	;sB2r00

	iorlw	0x00		; B3 00
	iorlw	0xFF		; B3 FF
	iorlw	extvalu		;sB3r00

	iorlw	#0x00		; B3 00
	iorlw	#0xFF		; B3 FF
	iorlw	#extvalu	;sB3r00

	xorlw	0x00		; B4 00
	xorlw	0xFF		; B4 FF
	xorlw	extvalu		;sB4r00

	xorlw	#0x00		; B4 00
	xorlw	#0xFF		; B4 FF
	xorlw	#extvalu	;sB4r00

	andlw	0x00		; B5 00
	andlw	0xFF		; B5 FF
	andlw	extvalu		;sB5r00

	andlw	#0x00		; B5 00
	andlw	#0xFF		; B5 FF
	andlw	#extvalu	;sB5r00

	retlw	0x00		; B6 00
	retlw	0xFF		; B6 FF
	retlw	extvalu		;sB6r00

	retlw	#0x00		; B6 00
	retlw	#0xFF		; B6 FF
	retlw	#extvalu	;sB6r00

	lcall	0x00		; B7 00
	lcall	0x1FFF		; B7 FF

	lcall	addr_00		;sB7r00
	lcall	addr_1FFF	;sB7rFF

	lcall	extaddr		;sB7r00

	movlb	0x00		; B8 00
	movlb	0x0F		; B8 0F
	movlb	extvalu		;sB8r00

	movlb	#0x00		; B8 00
	movlb	#0x0F		; B8 0F
	movlb	#extvalu	;sB8r00

	movlr	0x00		; BA 00
	movlr	0x0F		; BA F0
	movlr	extvalu		;sBAr00

	movlr	#0x00		; BA 00
	movlr	#0x0F		; BA F0
	movlr	#extvalu	;sBAr00

	mullw	0x00		; BC 00
	mullw	0xFF		; BC FF
	mullw	extvalu		;sBCr00

	mullw	#0x00		; BC 00
	mullw	#0xFF		; BC FF
	mullw	#extvalu	;sBCr00

	goto	0x00		; C0 00
	goto	0x1FFF		; DF FF

	goto	addr_00		;sC0r00
	goto	addr_1FFF	;sDFrFF

	goto	extaddr		;sC0r00

	call	0x00		; E0 00
	call	0x1FFF		; FF FF

	call	addr_00		;sE0r00
	call	addr_1FFF	;sFFrFF

	call	extaddr		;sE0r00



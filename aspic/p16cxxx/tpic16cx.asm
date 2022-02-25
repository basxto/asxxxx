;  TPIC16CX.ASM - Test file for ASPIC assembler
;
;  Assemble:
;	aspic -gloaxff tpic16cxxx
;

	.include	"tpic16cx.def"


	.area	DATA

	triscode =	6

	fcode =		1
	wcode =		0

	num0 =		0
	num7 =		7

	.area	CODE

	addr_00	=	. + 0x00
	addr_7FF =	. + 0x7ff

	nop			; 00 00

	return			; 00 08
	retfie			; 00 09

	sleep			; 00 63
	clrwdt			; 00 64

	tris	6		; 00 66
	tris	#6		; 00 66
	tris	triscode	; 00 66
	tris	#triscode	; 00 66

	movwf	0x00		; 00 80
	movwf	0x7F		; 00 FF
	movwf	extreg		;n00*80

	movwf	*0x00		; 00 80
	movwf	*0x7F		; 00 FF
	movwf	*extreg		;n00*80

	clrw			; 01 00

	clrf	0x00		; 01 80
	clrf	0x7F		; 01 FF
	clrf	extreg		;n01*80

	clrf	*0x00		; 01 80
	clrf	*0x7F		; 01 FF
	clrf	*extreg		;n01*80

	subwf	0x00,w		; 02 00
	subwf	0x7F,w		; 02 7F
	subwf	extreg,w	;n02*00

	subwf	*0x00,w		; 02 00
	subwf	*0x7F,w		; 02 7F
	subwf	*extreg,w	;n02*00

	subwf	0x00,f		; 02 80
	subwf	0x7F,f		; 02 FF
	subwf	extreg,f	;n02*80

	subwf	*0x00,f		; 02 80
	subwf	*0x7F,f		; 02 FF
	subwf	*extreg,f	;n02*80

	subwf	0x00,0		; 02 00
	subwf	*0x00,0		; 02 00
	subwf	extreg,0	;n02*00
	subwf	*extreg,0	;n02*00
	subwf	0x00,#0		; 02 00
	subwf	*0x00,#0	; 02 00
	subwf	extreg,#0	;n02*00
	subwf	*extreg,#0	;n02*00
	subwf	0x00,wcode	; 02 00
	subwf	*0x00,wcode	; 02 00
	subwf	extreg,wcode	;n02*00
	subwf	*extreg,wcode	;n02*00
	subwf	0x00,#wcode	; 02 00
	subwf	*0x00,#wcode	; 02 00
	subwf	extreg,#wcode	;n02*00
	subwf	*extreg,#wcode	;n02*00

	subwf	0x00,1		; 02 80
	subwf	*0x00,1		; 02 80
	subwf	extreg,1	;n02*80
	subwf	*extreg,1	;n02*80
	subwf	0x00,#1		; 02 80
	subwf	*0x00,#1	; 02 80
	subwf	extreg,#1	;n02*80
	subwf	*extreg,#1	;n02*80
	subwf	0x00,fcode	; 02 80
	subwf	*0x00,fcode	; 02 80
	subwf	extreg,fcode	;n02*80
	subwf	*extreg,fcode	;n02*80
	subwf	0x00,#fcode	; 02 80
	subwf	*0x00,#fcode	; 02 80
	subwf	extreg,#fcode	;n02*80
	subwf	*extreg,#fcode	;n02*80

	decf	0x00,w		; 03 00
	decf	0x7F,w		; 03 7F
	decf	extreg,w	;n03*00

	decf	0x00,f		; 03 80
	decf	0x7F,f		; 03 FF
	decf	extreg,f	;n03*80

	decf	*0x00,w		; 03 00
	decf	*0x7F,w		; 03 7F
	decf	*extreg,w	;n03*00

	decf	*0x00,f		; 03 80
	decf	*0x7F,f		; 03 FF
	decf	*extreg,f	;n03*80

	decf	0x00,0		; 03 00
	decf	*0x00,0		; 03 00
	decf	extreg,0	;n03*00
	decf	*extreg,0	;n03*00
	decf	0x00,#0		; 03 00
	decf	*0x00,#0	; 03 00
	decf	extreg,#0	;n03*00
	decf	*extreg,#0	;n03*00
	decf	0x00,wcode	; 03 00
	decf	*0x00,wcode	; 03 00
	decf	extreg,wcode	;n03*00
	decf	*extreg,wcode	;n03*00
	decf	0x00,#wcode	; 03 00
	decf	*0x00,#wcode	; 03 00
	decf	extreg,#wcode	;n03*00
	decf	*extreg,#wcode	;n03*00

	decf	0x00,1		; 03 80
	decf	*0x00,1		; 03 80
	decf	extreg,1	;n03*80
	decf	*extreg,1	;n03*80
	decf	0x00,#1		; 03 80
	decf	*0x00,#1	; 03 80
	decf	extreg,#1	;n03*80
	decf	*extreg,#1	;n03*80
	decf	0x00,fcode	; 03 80
	decf	*0x00,fcode	; 03 80
	decf	extreg,fcode	;n03*80
	decf	*extreg,fcode	;n03*80
	decf	0x00,#fcode	; 03 80
	decf	*0x00,#fcode	; 03 80
	decf	extreg,#fcode	;n03*80
	decf	*extreg,#fcode	;n03*80

	iorwf	0x00,w		; 04 00
	iorwf	0x7F,w		; 04 7F
	iorwf	extreg,w	;n04*00

	iorwf	0x00,f		; 04 80
	iorwf	0x7F,f		; 04 FF
	iorwf	extreg,f	;n04*80

	iorwf	*0x00,w		; 04 00
	iorwf	*0x7F,w		; 04 7F
	iorwf	*extreg,w	;n04*00

	iorwf	*0x00,f		; 04 80
	iorwf	*0x7F,f		; 04 FF
	iorwf	*extreg,f	;n04*80

	iorwf	0x00,0		; 04 00
	iorwf	*0x00,0		; 04 00
	iorwf	extreg,0	;n04*00
	iorwf	*extreg,0	;n04*00
	iorwf	0x00,#0		; 04 00
	iorwf	*0x00,#0	; 04 00
	iorwf	extreg,#0	;n04*00
	iorwf	*extreg,#0	;n04*00
	iorwf	0x00,wcode	; 04 00
	iorwf	*0x00,wcode	; 04 00
	iorwf	extreg,wcode	;n04*00
	iorwf	*extreg,wcode	;n04*00
	iorwf	0x00,#wcode	; 04 00
	iorwf	*0x00,#wcode	; 04 00
	iorwf	extreg,#wcode	;n04*00
	iorwf	*extreg,#wcode	;n04*00

	iorwf	0x00,1		; 04 80
	iorwf	*0x00,1		; 04 80
	iorwf	extreg,1	;n04*80
	iorwf	*extreg,1	;n04*80
	iorwf	0x00,#1		; 04 80
	iorwf	*0x00,#1	; 04 80
	iorwf	extreg,#1	;n04*80
	iorwf	*extreg,#1	;n04*80
	iorwf	0x00,fcode	; 04 80
	iorwf	*0x00,fcode	; 04 80
	iorwf	extreg,fcode	;n04*80
	iorwf	*extreg,fcode	;n04*80
	iorwf	0x00,#fcode	; 04 80
	iorwf	*0x00,#fcode	; 04 80
	iorwf	extreg,#fcode	;n04*80
	iorwf	*extreg,#fcode	;n04*80

	andwf	0x00,w		; 05 00
	andwf	0x7F,w		; 05 7F
	andwf	extreg,w	;n05*00

	andwf	0x00,f		; 05 80
	andwf	0x7F,f		; 05 FF
	andwf	extreg,f	;n05*80

	andwf	*0x00,w		; 05 00
	andwf	*0x7F,w		; 05 7F
	andwf	*extreg,w	;n05*00

	andwf	*0x00,f		; 05 80
	andwf	*0x7F,f		; 05 FF
	andwf	*extreg,f	;n05*80

	andwf	0x00,0		; 05 00
	andwf	*0x00,0		; 05 00
	andwf	extreg,0	;n05*00
	andwf	*extreg,0	;n05*00
	andwf	0x00,#0		; 05 00
	andwf	*0x00,#0	; 05 00
	andwf	extreg,#0	;n05*00
	andwf	*extreg,#0	;n05*00
	andwf	0x00,wcode	; 05 00
	andwf	*0x00,wcode	; 05 00
	andwf	extreg,wcode	;n05*00
	andwf	*extreg,wcode	;n05*00
	andwf	0x00,#wcode	; 05 00
	andwf	*0x00,#wcode	; 05 00
	andwf	extreg,#wcode	;n05*00
	andwf	*extreg,#wcode	;n05*00

	andwf	0x00,1		; 05 80
	andwf	*0x00,1		; 05 80
	andwf	extreg,1	;n05*80
	andwf	*extreg,1	;n05*80
	andwf	0x00,#1		; 05 80
	andwf	*0x00,#1	; 05 80
	andwf	extreg,#1	;n05*80
	andwf	*extreg,#1	;n05*80
	andwf	0x00,fcode	; 05 80
	andwf	*0x00,fcode	; 05 80
	andwf	extreg,fcode	;n05*80
	andwf	*extreg,fcode	;n05*80
	andwf	0x00,#fcode	; 05 80
	andwf	*0x00,#fcode	; 05 80
	andwf	extreg,#fcode	;n05*80
	andwf	*extreg,#fcode	;n05*80

	xorwf	0x00,w		; 06 00
	xorwf	0x7F,w		; 06 7F
	xorwf	extreg,w	;n06*00

	xorwf	0x00,f		; 06 80
	xorwf	0x7F,f		; 06 FF
	xorwf	extreg,f	;n06*80

	xorwf	*0x00,w		; 06 00
	xorwf	*0x7F,w		; 06 7F
	xorwf	*extreg,w	;n06*00

	xorwf	*0x00,f		; 06 80
	xorwf	*0x7F,f		; 06 FF
	xorwf	*extreg,f	;n06*80

	xorwf	0x00,0		; 06 00
	xorwf	*0x00,0		; 06 00
	xorwf	extreg,0	;n06*00
	xorwf	*extreg,0	;n06*00
	xorwf	0x00,#0		; 06 00
	xorwf	*0x00,#0	; 06 00
	xorwf	extreg,#0	;n06*00
	xorwf	*extreg,#0	;n06*00
	xorwf	0x00,wcode	; 06 00
	xorwf	*0x00,wcode	; 06 00
	xorwf	extreg,wcode	;n06*00
	xorwf	*extreg,wcode	;n06*00
	xorwf	0x00,#wcode	; 06 00
	xorwf	*0x00,#wcode	; 06 00
	xorwf	extreg,#wcode	;n06*00
	xorwf	*extreg,#wcode	;n06*00

	xorwf	0x00,1		; 06 80
	xorwf	*0x00,1		; 06 80
	xorwf	extreg,1	;n06*80
	xorwf	*extreg,1	;n06*80
	xorwf	0x00,#1		; 06 80
	xorwf	*0x00,#1	; 06 80
	xorwf	extreg,#1	;n06*80
	xorwf	*extreg,#1	;n06*80
	xorwf	0x00,fcode	; 06 80
	xorwf	*0x00,fcode	; 06 80
	xorwf	extreg,fcode	;n06*80
	xorwf	*extreg,fcode	;n06*80
	xorwf	0x00,#fcode	; 06 80
	xorwf	*0x00,#fcode	; 06 80
	xorwf	extreg,#fcode	;n06*80
	xorwf	*extreg,#fcode	;n06*80

	addwf	0x00,w		; 07 00
	addwf	0x7F,w		; 07 7F
	addwf	extreg,w	;n07*00

	addwf	0x00,f		; 07 80
	addwf	0x7F,f		; 07 FF
	addwf	extreg,f	;n07*80

	addwf	*0x00,w		; 07 00
	addwf	*0x7F,w		; 07 7F
	addwf	*extreg,w	;n07*00

	addwf	*0x00,f		; 07 80
	addwf	*0x7F,f		; 07 FF
 	addwf	*extreg,f	;n07*80

	addwf	0x00,0		; 07 00
	addwf	*0x00,0		; 07 00
	addwf	extreg,0	;n07*00
	addwf	*extreg,0	;n07*00
	addwf	0x00,#0		; 07 00
	addwf	*0x00,#0	; 07 00
	addwf	extreg,#0	;n07*00
	addwf	*extreg,#0	;n07*00
	addwf	0x00,wcode	; 07 00
	addwf	*0x00,wcode	; 07 00
	addwf	extreg,wcode	;n07*00
	addwf	*extreg,wcode	;n07*00
	addwf	0x00,#wcode	; 07 00
	addwf	*0x00,#wcode	; 07 00
	addwf	extreg,#wcode	;n07*00
	addwf	*extreg,#wcode	;n07*00

	addwf	0x00,1		; 07 80
	addwf	*0x00,1		; 07 80
	addwf	extreg,1	;n07*80
	addwf	*extreg,1	;n07*80
	addwf	0x00,#1		; 07 80
	addwf	*0x00,#1	; 07 80
	addwf	extreg,#1	;n07*80
	addwf	*extreg,#1	;n07*80
	addwf	0x00,fcode	; 07 80
	addwf	*0x00,fcode	; 07 80
	addwf	extreg,fcode	;n07*80
	addwf	*extreg,fcode	;n07*80
	addwf	0x00,#fcode	; 07 80
	addwf	*0x00,#fcode	; 07 80
	addwf	extreg,#fcode	;n07*80
	addwf	*extreg,#fcode	;n07*80

	movf	0x00,w		; 08 00
	movf	0x7F,w		; 08 7F
	movf	extreg,w	;n08*00

	movf	0x00,f		; 08 80
	movf	0x7F,f		; 08 FF
	movf	extreg,f	;n08*80

	movf	*0x00,w		; 08 00
	movf	*0x7F,w		; 08 7F
	movf	*extreg,w	;n08*00

	movf	*0x00,f		; 08 80
	movf	*0x7F,f		; 08 FF
	movf	*extreg,f	;n08*80

	movf	0x00,0		; 08 00
	movf	*0x00,0		; 08 00
	movf	extreg,0	;n08*00
	movf	*extreg,0	;n08*00
	movf	0x00,#0		; 08 00
	movf	*0x00,#0	; 08 00
	movf	extreg,#0	;n08*00
	movf	*extreg,#0	;n08*00
	movf	0x00,wcode	; 08 00
	movf	*0x00,wcode	; 08 00
	movf	extreg,wcode	;n08*00
	movf	*extreg,wcode	;n08*00
	movf	0x00,#wcode	; 08 00
	movf	*0x00,#wcode	; 08 00
	movf	extreg,#wcode	;n08*00
	movf	*extreg,#wcode	;n08*00

	movf	0x00,1		; 08 80
	movf	*0x00,1		; 08 80
	movf	extreg,1	;n08*80
	movf	*extreg,1	;n08*80
	movf	0x00,#1		; 08 80
	movf	*0x00,#1	; 08 80
	movf	extreg,#1	;n08*80
	movf	*extreg,#1	;n08*80
	movf	0x00,fcode	; 08 80
	movf	*0x00,fcode	; 08 80
	movf	extreg,fcode	;n08*80
	movf	*extreg,fcode	;n08*80
	movf	0x00,#fcode	; 08 80
	movf	*0x00,#fcode	; 08 80
	movf	extreg,#fcode	;n08*80
	movf	*extreg,#fcode	;n08*80

	comf	0x00,w		; 09 00
	comf	0x7F,w		; 09 7F
	comf	extreg,w	;n09*00

	comf	0x00,f		; 09 80
	comf	0x7F,f		; 09 FF
 	comf	extreg,f	;n09*80

	comf	*0x00,w		; 09 00
	comf	*0x7F,w		; 09 7F
	comf	*extreg,w	;n09*00

	comf	*0x00,f		; 09 80
	comf	*0x7F,f		; 09 FF
 	comf	*extreg,f	;n09*80

	comf	0x00,0		; 09 00
	comf	*0x00,0		; 09 00
	comf	extreg,0	;n09*00
	comf	*extreg,0	;n09*00
	comf	0x00,#0		; 09 00
	comf	*0x00,#0	; 09 00
	comf	extreg,#0	;n09*00
	comf	*extreg,#0	;n09*00
	comf	0x00,wcode	; 09 00
	comf	*0x00,wcode	; 09 00
	comf	extreg,wcode	;n09*00
	comf	*extreg,wcode	;n09*00
	comf	0x00,#wcode	; 09 00
	comf	*0x00,#wcode	; 09 00
	comf	extreg,#wcode	;n09*00
	comf	*extreg,#wcode	;n09*00

	comf	0x00,1		; 09 80
	comf	*0x00,1		; 09 80
	comf	extreg,1	;n09*80
	comf	*extreg,1	;n09*80
	comf	0x00,#1		; 09 80
	comf	*0x00,#1	; 09 80
	comf	extreg,#1	;n09*80
	comf	*extreg,#1	;n09*80
	comf	0x00,fcode	; 09 80
	comf	*0x00,fcode	; 09 80
	comf	extreg,fcode	;n09*80
	comf	*extreg,fcode	;n09*80
	comf	0x00,#fcode	; 09 80
	comf	*0x00,#fcode	; 09 80
	comf	extreg,#fcode	;n09*80
	comf	*extreg,#fcode	;n09*80

	incf	0x00,w		; 0A 00
	incf	0x7F,w		; 0A 7F
	incf	extreg,w	;n0A*00

	incf	0x00,f		; 0A 80
	incf	0x7F,f		; 0A FF
	incf	extreg,f	;n0A*80

	incf	*0x00,w		; 0A 00
	incf	*0x7F,w		; 0A 7F
	incf	*extreg,w	;n0A*00

	incf	*0x00,f		; 0A 80
	incf	*0x7F,f		; 0A FF
	incf	*extreg,f	;n0A*80

	incf	0x00,0		; 0A 00
	incf	*0x00,0		; 0A 00
	incf	extreg,0	;n0A*00
	incf	*extreg,0	;n0A*00
	incf	0x00,#0		; 0A 00
	incf	*0x00,#0	; 0A 00
	incf	extreg,#0	;n0A*00
	incf	*extreg,#0	;n0A*00
	incf	0x00,wcode	; 0A 00
	incf	*0x00,wcode	; 0A 00
	incf	extreg,wcode	;n0A*00
	incf	*extreg,wcode	;n0A*00
	incf	0x00,#wcode	; 0A 00
	incf	*0x00,#wcode	; 0A 00
	incf	extreg,#wcode	;n0A*00
	incf	*extreg,#wcode	;n0A*00

	incf	0x00,1		; 0A 80
	incf	*0x00,1		; 0A 80
	incf	extreg,1	;n0A*80
	incf	*extreg,1	;n0A*80
	incf	0x00,#1		; 0A 80
	incf	*0x00,#1	; 0A 80
	incf	extreg,#1	;n0A*80
	incf	*extreg,#1	;n0A*80
	incf	0x00,fcode	; 0A 80
	incf	*0x00,fcode	; 0A 80
	incf	extreg,fcode	;n0A*80
	incf	*extreg,fcode	;n0A*80
	incf	0x00,#fcode	; 0A 80
	incf	*0x00,#fcode	; 0A 80
	incf	extreg,#fcode	;n0A*80
	incf	*extreg,#fcode	;n0A*80

	decfsz	0x00,w		; 0B 00
	decfsz	0x7F,w		; 0B 7F
	decfsz	extreg,w	;n0B*00

	decfsz	0x00,f		; 0B 80
	decfsz	0x7F,f		; 0B FF
	decfsz	extreg,f	;n0B*80

	decfsz	*0x00,w		; 0B 00
	decfsz	*0x7F,w		; 0B 7F
	decfsz	*extreg,w	;n0B*00

	decfsz	*0x00,f		; 0B 80
	decfsz	*0x7F,f		; 0B FF
 	decfsz	*extreg,f	;n0B*80

	decfsz	0x00,0		; 0B 00
	decfsz	*0x00,0		; 0B 00
	decfsz	extreg,0	;n0B*00
	decfsz	*extreg,0	;n0B*00
	decfsz	0x00,#0		; 0B 00
	decfsz	*0x00,#0	; 0B 00
	decfsz	extreg,#0	;n0B*00
	decfsz	*extreg,#0	;n0B*00
	decfsz	0x00,wcode	; 0B 00
	decfsz	*0x00,wcode	; 0B 00
	decfsz	extreg,wcode	;n0B*00
	decfsz	*extreg,wcode	;n0B*00
	decfsz	0x00,#wcode	; 0B 00
	decfsz	*0x00,#wcode	; 0B 00
	decfsz	extreg,#wcode	;n0B*00
	decfsz	*extreg,#wcode	;n0B*00

	decfsz	0x00,1		; 0B 80
	decfsz	*0x00,1		; 0B 80
	decfsz	extreg,1	;n0B*80
	decfsz	*extreg,1	;n0B*80
	decfsz	0x00,#1		; 0B 80
	decfsz	*0x00,#1	; 0B 80
	decfsz	extreg,#1	;n0B*80
	decfsz	*extreg,#1	;n0B*80
	decfsz	0x00,fcode	; 0B 80
	decfsz	*0x00,fcode	; 0B 80
	decfsz	extreg,fcode	;n0B*80
	decfsz	*extreg,fcode	;n0B*80
	decfsz	0x00,#fcode	; 0B 80
	decfsz	*0x00,#fcode	; 0B 80
	decfsz	extreg,#fcode	;n0B*80
	decfsz	*extreg,#fcode	;n0B*80

	rrf	0x00,w		; 0C 00
	rrf	0x7F,w		; 0C 7F
	rrf	extreg,w	;n0C*00

	rrf	0x00,f		; 0C 80
	rrf	0x7F,f		; 0C FF
	rrf	extreg,f	;n0C*80

	rrf	*0x00,w		; 0C 00
	rrf	*0x7F,w		; 0C 7F
	rrf	*extreg,w	;n0C*00

	rrf	*0x00,f		; 0C 80
	rrf	*0x7F,f		; 0C FF
 	rrf	*extreg,f	;n0C*80

	rrf	0x00,0		; 0C 00
	rrf	*0x00,0		; 0C 00
	rrf	extreg,0	;n0C*00
	rrf	*extreg,0	;n0C*00
	rrf	0x00,#0		; 0C 00
	rrf	*0x00,#0	; 0C 00
	rrf	extreg,#0	;n0C*00
	rrf	*extreg,#0	;n0C*00
	rrf	0x00,wcode	; 0C 00
	rrf	*0x00,wcode	; 0C 00
	rrf	extreg,wcode	;n0C*00
	rrf	*extreg,wcode	;n0C*00
	rrf	0x00,#wcode	; 0C 00
	rrf	*0x00,#wcode	; 0C 00
	rrf	extreg,#wcode	;n0C*00
	rrf	*extreg,#wcode	;n0C*00

	rrf	0x00,1		; 0C 80
	rrf	*0x00,1		; 0C 80
	rrf	extreg,1	;n0C*80
	rrf	*extreg,1	;n0C*80
	rrf	0x00,#1		; 0C 80
	rrf	*0x00,#1	; 0C 80
	rrf	extreg,#1	;n0C*80
	rrf	*extreg,#1	;n0C*80
	rrf	0x00,fcode	; 0C 80
	rrf	*0x00,fcode	; 0C 80
	rrf	extreg,fcode	;n0C*80
	rrf	*extreg,fcode	;n0C*80
	rrf	0x00,#fcode	; 0C 80
	rrf	*0x00,#fcode	; 0C 80
	rrf	extreg,#fcode	;n0C*80
	rrf	*extreg,#fcode	;n0C*80

	rlf	0x00,w		; 0D 00
	rlf	0x7F,w		; 0D 7F
	rlf	extreg,w	;n0D*00

	rlf	0x00,f		; 0D 80
	rlf	0x7F,f		; 0D FF
	rlf	extreg,f	;n0D*80

	rlf	*0x00,w		; 0D 00
	rlf	*0x7F,w		; 0D 7F
	rlf	*extreg,w	;n0D*00

	rlf	*0x00,f		; 0D 80
	rlf	*0x7F,f		; 0D FF
	rlf	*extreg,f	;n0D*80

	rlf	0x00,0		; 0D 00
	rlf	*0x00,0		; 0D 00
	rlf	extreg,0	;n0D*00
	rlf	*extreg,0	;n0D*00
	rlf	0x00,#0		; 0D 00
	rlf	*0x00,#0	; 0D 00
	rlf	extreg,#0	;n0D*00
	rlf	*extreg,#0	;n0D*00
	rlf	0x00,wcode	; 0D 00
	rlf	*0x00,wcode	; 0D 00
	rlf	extreg,wcode	;n0D*00
	rlf	*extreg,wcode	;n0D*00
	rlf	0x00,#wcode	; 0D 00
	rlf	*0x00,#wcode	; 0D 00
	rlf	extreg,#wcode	;n0D*00
	rlf	*extreg,#wcode	;n0D*00

	rlf	0x00,1		; 0D 80
	rlf	*0x00,1		; 0D 80
	rlf	extreg,1	;n0D*80
	rlf	*extreg,1	;n0D*80
	rlf	0x00,#1		; 0D 80
	rlf	*0x00,#1	; 0D 80
	rlf	extreg,#1	;n0D*80
	rlf	*extreg,#1	;n0D*80
	rlf	0x00,fcode	; 0D 80
	rlf	*0x00,fcode	; 0D 80
	rlf	extreg,fcode	;n0D*80
	rlf	*extreg,fcode	;n0D*80
	rlf	0x00,#fcode	; 0D 80
	rlf	*0x00,#fcode	; 0D 80
	rlf	extreg,#fcode	;n0D*80
	rlf	*extreg,#fcode	;n0D*80

	swapf	0x00,w		; 0E 00
	swapf	0x7F,w		; 0E 7F
	swapf	extreg,w	;n0E*00

	swapf	0x00,f		; 0E 80
	swapf	0x7F,f		; 0E FF
	swapf	extreg,f	;n0E*80

	swapf	*0x00,w		; 0E 00
	swapf	*0x7F,w		; 0E 7F
	swapf	*extreg,w	;n0E*00

	swapf	*0x00,f		; 0E 80
	swapf	*0x7F,f		; 0E FF
	swapf	*extreg,f	;n0E*80

	swapf	0x00,0		; 0E 00
	swapf	*0x00,0		; 0E 00
	swapf	extreg,0	;n0E*00
	swapf	*extreg,0	;n0E*00
	swapf	0x00,#0		; 0E 00
	swapf	*0x00,#0	; 0E 00
	swapf	extreg,#0	;n0E*00
	swapf	*extreg,#0	;n0E*00
	swapf	0x00,wcode	; 0E 00
	swapf	*0x00,wcode	; 0E 00
	swapf	extreg,wcode	;n0E*00
	swapf	*extreg,wcode	;n0E*00
	swapf	0x00,#wcode	; 0E 00
	swapf	*0x00,#wcode	; 0E 00
	swapf	extreg,#wcode	;n0E*00
	swapf	*extreg,#wcode	;n0E*00

	swapf	0x00,1		; 0E 80
	swapf	*0x00,1		; 0E 80
	swapf	extreg,1	;n0E*80
	swapf	*extreg,1	;n0E*80
	swapf	0x00,#1		; 0E 80
	swapf	*0x00,#1	; 0E 80
	swapf	extreg,#1	;n0E*80
	swapf	*extreg,#1	;n0E*80
	swapf	0x00,fcode	; 0E 80
	swapf	*0x00,fcode	; 0E 80
	swapf	extreg,fcode	;n0E*80
	swapf	*extreg,fcode	;n0E*80
	swapf	0x00,#fcode	; 0E 80
	swapf	*0x00,#fcode	; 0E 80
	swapf	extreg,#fcode	;n0E*80
	swapf	*extreg,#fcode	;n0E*80

	incfsz	0x00,w		; 0F 00
	incfsz	0x7F,w		; 0F 7F
	incfsz	extreg,w	;n0F*00

	incfsz	0x00,f		; 0F 80
	incfsz	0x7F,f		; 0F FF
	incfsz	extreg,f	;n0F*80

	incfsz	*0x00,w		; 0F 00
	incfsz	*0x7F,w		; 0F 7F
	incfsz	*extreg,w	;n0F*00

	incfsz	*0x00,f		; 0F 80
	incfsz	*0x7F,f		; 0F FF
	incfsz	*extreg,f	;n0F*80

	incfsz	0x00,0		; 0F 00
	incfsz	*0x00,0		; 0F 00
	incfsz	extreg,0	;n0F*00
	incfsz	*extreg,0	;n0F*00
	incfsz	0x00,#0		; 0F 00
	incfsz	*0x00,#0	; 0F 00
	incfsz	extreg,#0	;n0F*00
	incfsz	*extreg,#0	;n0F*00
	incfsz	0x00,wcode	; 0F 00
	incfsz	*0x00,wcode	; 0F 00
	incfsz	extreg,wcode	;n0F*00
	incfsz	*extreg,wcode	;n0F*00
	incfsz	0x00,#wcode	; 0F 00
	incfsz	*0x00,#wcode	; 0F 00
	incfsz	extreg,#wcode	;n0F*00
	incfsz	*extreg,#wcode	;n0F*00

	incfsz	0x00,1		; 0F 80
	incfsz	*0x00,1		; 0F 80
	incfsz	extreg,1	;n0F*80
	incfsz	*extreg,1	;n0F*80
	incfsz	0x00,#1		; 0F 80
	incfsz	*0x00,#1	; 0F 80
	incfsz	extreg,#1	;n0F*80
	incfsz	*extreg,#1	;n0F*80
	incfsz	0x00,fcode	; 0F 80
	incfsz	*0x00,fcode	; 0F 80
	incfsz	extreg,fcode	;n0F*80
	incfsz	*extreg,fcode	;n0F*80
	incfsz	0x00,#fcode	; 0F 80
	incfsz	*0x00,#fcode	; 0F 80
	incfsz	extreg,#fcode	;n0F*80
	incfsz	*extreg,#fcode	;n0F*80

	bcf	0x00,0		; 10 00
	bcf	0x7F,0		; 10 7F
	bcf	extreg,0	;n10*00

	bcf	0x00,7		; 13 80
	bcf	0x7F,7		; 13 FF
	bcf	extreg,7	;n13*80

	bcf	*0x00,0		; 10 00
	bcf	*0x7F,0		; 10 7F
	bcf	*extreg,0	;n10*00

	bcf	*0x00,7		; 13 80
	bcf	*0x7F,7		; 13 FF
	bcf	*extreg,7	;n13*80

	bcf	0x00,num0	; 10 00
	bcf	*0x00,num0	; 10 00
	bcf	extreg,num0	;n10*00
	bcf	*extreg,num0	;n10*00
	bcf	0x00,#num0	; 10 00
	bcf	*0x00,#num0	; 10 00
	bcf	extreg,#num0	;n10*00
	bcf	*extreg,#num0	;n10*00
	bcf	0x00,num7	; 13 80
	bcf	*0x00,num7	; 13 80
	bcf	extreg,num7	;n13*80
	bcf	*extreg,num7	;n13*80
	bcf	0x00,#num7	; 13 80
	bcf	*0x00,#num7	; 13 80
	bcf	extreg,#num7	;n13*80
	bcf	*extreg,#num7	;n13*80

	bsf	0x00,0		; 14 00
	bsf	0x7F,0		; 14 7F
	bsf	extreg,0	;n14*00

	bsf	0x00,7		; 17 80
	bsf	0x7F,7		; 17 FF
	bsf	extreg,7	;n17*80

	bsf	*0x00,0		; 14 00
	bsf	*0x7F,0		; 14 7F
	bsf	*extreg,0	;n14*00

	bsf	*0x00,7		; 17 80
	bsf	*0x7F,7		; 17 FF
 	bsf	*extreg,7	;n17*80

	bsf	0x00,num0	; 14 00
	bsf	*0x00,num0	; 14 00
	bsf	extreg,num0	;n14*00
	bsf	*extreg,num0	;n14*00
	bsf	0x00,#num0	; 14 00
	bsf	*0x00,#num0	; 14 00
	bsf	extreg,#num0	;n14*00
	bsf	*extreg,#num0	;n14*00
	bsf	0x00,num7	; 17 80
	bsf	*0x00,num7	; 17 80
	bsf	extreg,num7	;n17*80
	bsf	*extreg,num7	;n17*80
	bsf	0x00,#num7	; 17 80
	bsf	*0x00,#num7	; 17 80
	bsf	extreg,#num7	;n17*80
	bsf	*extreg,#num7	;n17*80

	btfsc	0x00,0		; 18 00
	btfsc	0x7F,0		; 18 7F
	btfsc	extreg,0	;n18*00

	btfsc	0x00,7		; 1B 80
	btfsc	0x7F,7		; 1B FF
	btfsc	extreg,7	;n1B*80

	btfsc	*0x00,0		; 18 00
	btfsc	*0x7F,0		; 18 7F
	btfsc	*extreg,0	;n18*00

	btfsc	*0x00,7		; 1B 80
	btfsc	*0x7F,7		; 1B FF
	btfsc	*extreg,7	;n1B*80

	btfsc	0x00,num0	; 18 00
	btfsc	*0x00,num0	; 18 00
	btfsc	extreg,num0	;n18*00
	btfsc	*extreg,num0	;n18*00
	btfsc	0x00,#num0	; 18 00
	btfsc	*0x00,#num0	; 18 00
	btfsc	extreg,#num0	;n18*00
	btfsc	*extreg,#num0	;n18*00
	btfsc	0x00,num7	; 1B 80
	btfsc	*0x00,num7	; 1B 80
	btfsc	extreg,num7	;n1B*80
	btfsc	*extreg,num7	;n1B*80
	btfsc	0x00,#num7	; 1B 80
	btfsc	*0x00,#num7	; 1B 80
	btfsc	extreg,#num7	;n1B*80
	btfsc	*extreg,#num7	;n1B*80

	btfss	0x00,0		; 1C 00
	btfss	0x7F,0		; 1C 7F
	btfss	extreg,0	;n1C*00

	btfss	0x00,7		; 1F 80
	btfss	0x7F,7		; 1F FF
	btfss	extreg,7	;n1F*80

	btfss	*0x00,0		; 1C 00
	btfss	*0x7F,0		; 1C 7F
	btfss	*extreg,0	;n1C*00

	btfss	*0x00,7		; 1F 80
	btfss	*0x7F,7		; 1F FF
	btfss	*extreg,7	;n1F*80

	btfss	0x00,num0	; 1C 00
	btfss	*0x00,num0	; 1C 00
	btfss	extreg,num0	;n1C*00
	btfss	*extreg,num0	;n1C*00
	btfss	0x00,#num0	; 1C 00
	btfss	*0x00,#num0	; 1C 00
	btfss	extreg,#num0	;n1C*00
	btfss	*extreg,#num0	;n1C*00
	btfss	0x00,num7	; 1F 80
	btfss	*0x00,num7	; 1F 80
	btfss	extreg,num7	;n1F*80
	btfss	*extreg,num7	;n1F*80
	btfss	0x00,#num7	; 1F 80
	btfss	*0x00,#num7	; 1F 80
	btfss	extreg,#num7	;n1F*80
	btfss	*extreg,#num7	;n1F*80

	retlw	0x00		; 34 00
	retlw	0xFF		; 34 FF
	retlw	extvalu		;s34r00

	retlw	#0x00		; 34 00
	retlw	#0xFF		; 34 FF
	retlw	#extvalu	;s34r00

	call	0x00		; 20 00
	call	0x7FF		; 27 FF

	call	addr_00		;s20r00
	call	addr_7FF	;s27rFF

	call	extaddr		;s20r00

	goto	0x00		; 28 00
	goto	0x7FF		; 2F FF

	goto	addr_00		;s28r00
	goto	addr_7FF	;s2FrFF

	goto	extaddr		;s28r00

	movlw	0x00		; 30 00
	movlw	0xFF		; 30 FF
	movlw	extvalu		;s30r00

	movlw	#0x00		; 30 00
	movlw	#0xFF		; 30 FF
	movlw	#extvalu	;s30r00

	iorlw	0x00		; 38 00
	iorlw	0xFF		; 38 FF
	iorlw	extvalu		;s38r00

	iorlw	#0x00		; 38 00
	iorlw	#0xFF		; 38 FF
	iorlw	#extvalu	;s38r00

	andlw	0x00		; 39 00
	andlw	0xFF		; 39 FF
	andlw	extvalu		;s39r00

	andlw	#0x00		; 39 00
	andlw	#0xFF		; 39 FF
	andlw	#extvalu	;s39r00

	xorlw	0x00		; 3A 00
	xorlw	0xFF		; 3A FF
	xorlw	extvalu		;s3Ar00

	xorlw	#0x00		; 3A 00
	xorlw	#0xFF		; 3A FF
	xorlw	#extvalu	;s3Ar00

	sublw	0x00		; 3C 00
	sublw	0xFF		; 3C FF
	sublw	extvalu		;s3Cr00

	sublw	#0x00		; 3C 00
	sublw	#0xFF		; 3C FF
	sublw	#extvalu	;s3Cr00

	addlw	0x00		; 3E 00
	addlw	0xFF		; 3E FF
	addlw	extvalu		;s3Er00

	addlw	#0x00		; 3E 00
	addlw	#0xFF		; 3E FF
	addlw	#extvalu	;s3Er00



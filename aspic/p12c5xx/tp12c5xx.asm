	.title	TP12C5XX.ASM - Test file for ASPIC assembler
;
;  Assemble:
;	aspic -gloaxff tpic12c5xx
;

	.include	"tp12c5xx.def"


	.area	DATA

	triscode =	6

	fcode =		1
	wcode =		0

	num0 =		0
	num7 =		7

	.area	CODE

	addr_00	=	. + 0x00
	addr_FF =	. + 0xff
	addr_1FF =	. + 0x1ff


	nop			; 00 00

	option			; 00 02
	sleep			; 00 03
	clrwdt			; 00 04

	tris	6		; 00 06
	tris	#6		; 00 06
	tris	triscode	; 00 06
	tris	#triscode	; 00 06

	movwf	0x00		; 00 20
	movwf	0x1F		; 00 3F
	movwf	extreg		;n00*20

	movwf	*0x00		; 00 20
	movwf	*0x1F		; 00 3F
	movwf	*extreg		;n00*20

	clrw			; 00 40

	clrf	0x00		; 00 60
	clrf	0x1F		; 00 7F
	clrf	extreg		;n00*60

	clrf	*0x00		; 00 60
	clrf	*0x1F		; 00 7F
	clrf	*extreg		;n00*60

	subwf	0x00,w		; 00 80
	subwf	0x1F,w		; 00 9F
	subwf	extreg,w	;n00*80

	subwf	*0x00,w		; 00 80
	subwf	*0x1F,w		; 00 9F
	subwf	*extreg,w	;n00*80

	subwf	0x00,f		; 00 A0
	subwf	0x1F,f		; 00 BF
	subwf	extreg,f	;n00*A0

	subwf	*0x00,f		; 00 A0
	subwf	*0x1F,f		; 00 BF
	subwf	*extreg,f	;n00*A0

	subwf	0x00,0		; 00 80
	subwf	*0x00,0		; 00 80
	subwf	extreg,0	;n00*80
	subwf	*extreg,0	;n00*80
	subwf	0x00,#0		; 00 80
	subwf	*0x00,#0	; 00 80
	subwf	extreg,#0	;n00*80
	subwf	*extreg,#0	;n00*80
	subwf	0x00,wcode	; 00 80
	subwf	*0x00,wcode	; 00 80
	subwf	extreg,wcode	;n00*80
	subwf	*extreg,wcode	;n00*80
	subwf	0x00,#wcode	; 00 80
	subwf	*0x00,#wcode	; 00 80
	subwf	extreg,#wcode	;n00*80
	subwf	*extreg,#wcode	;n00*80

	subwf	0x00,1		; 00 A0
	subwf	*0x00,1		; 00 A0
	subwf	extreg,1	;n00*A0
	subwf	*extreg,1	;n00*A0
	subwf	0x00,#1		; 00 A0
	subwf	*0x00,#1	; 00 A0
	subwf	extreg,#1	;n00*A0
	subwf	*extreg,#1	;n00*A0
	subwf	0x00,fcode	; 00 A0
	subwf	*0x00,fcode	; 00 A0
	subwf	extreg,fcode	;n00*A0
	subwf	*extreg,fcode	;n00*A0
	subwf	0x00,#fcode	; 00 A0
	subwf	*0x00,#fcode	; 00 A0
	subwf	extreg,#fcode	;n00*A0
	subwf	*extreg,#fcode	;n00*A0

	decf	0x00,w		; 00 C0
	decf	0x1F,w		; 00 DF
	decf	extreg,w	;n00*C0

	decf	0x00,f		; 00 E0
	decf	0x1F,f		; 00 FF
	decf	extreg,f	;n00*E0

	decf	*0x00,w		; 00 C0
	decf	*0x1F,w		; 00 DF
	decf	*extreg,w	;n00*C0

	decf	*0x00,f		; 00 E0
	decf	*0x1F,f		; 00 FF
	decf	*extreg,f	;n00*E0

	decf	0x00,0		; 00 C0
	decf	*0x00,0		; 00 C0
	decf	extreg,0	;n00*C0
	decf	*extreg,0	;n00*C0
	decf	0x00,#0		; 00 C0
	decf	*0x00,#0	; 00 C0
	decf	extreg,#0	;n00*C0
	decf	*extreg,#0	;n00*C0
	decf	0x00,wcode	; 00 C0
	decf	*0x00,wcode	; 00 C0
	decf	extreg,wcode	;n00*C0
	decf	*extreg,wcode	;n00*C0
	decf	0x00,#wcode	; 00 C0
	decf	*0x00,#wcode	; 00 C0
	decf	extreg,#wcode	;n00*C0
	decf	*extreg,#wcode	;n00*C0

	decf	0x00,1		; 00 E0
	decf	*0x00,1		; 00 E0
	decf	extreg,1	;n00*E0
	decf	*extreg,1	;n00*E0
	decf	0x00,#1		; 00 E0
	decf	*0x00,#1	; 00 E0
	decf	extreg,#1	;n00*E0
	decf	*extreg,#1	;n00*E0
	decf	0x00,fcode	; 00 E0
	decf	*0x00,fcode	; 00 E0
	decf	extreg,fcode	;n00*E0
	decf	*extreg,fcode	;n00*E0
	decf	0x00,#fcode	; 00 E0
	decf	*0x00,#fcode	; 00 E0
	decf	extreg,#fcode	;n00*E0
	decf	*extreg,#fcode	;n00*E0

	iorwf	0x00,w		; 01 00
	iorwf	0x1F,w		; 01 1F
	iorwf	extreg,w	;n01*00

	iorwf	0x00,f		; 01 20
	iorwf	0x1F,f		; 01 3F
	iorwf	extreg,f	;n01*20

	iorwf	*0x00,w		; 01 00
	iorwf	*0x1F,w		; 01 1F
	iorwf	*extreg,w	;n01*00

	iorwf	*0x00,f		; 01 20
	iorwf	*0x1F,f		; 01 3F
	iorwf	*extreg,f	;n01*20

	iorwf	0x00,0		; 01 00
	iorwf	*0x00,0		; 01 00
	iorwf	extreg,0	;n01*00
	iorwf	*extreg,0	;n01*00
	iorwf	0x00,#0		; 01 00
	iorwf	*0x00,#0	; 01 00
	iorwf	extreg,#0	;n01*00
	iorwf	*extreg,#0	;n01*00
	iorwf	0x00,wcode	; 01 00
	iorwf	*0x00,wcode	; 01 00
	iorwf	extreg,wcode	;n01*00
	iorwf	*extreg,wcode	;n01*00
	iorwf	0x00,#wcode	; 01 00
	iorwf	*0x00,#wcode	; 01 00
	iorwf	extreg,#wcode	;n01*00
	iorwf	*extreg,#wcode	;n01*00

	iorwf	0x00,1		; 01 20
	iorwf	*0x00,1		; 01 20
	iorwf	extreg,1	;n01*20
	iorwf	*extreg,1	;n01*20
	iorwf	0x00,#1		; 01 20
	iorwf	*0x00,#1	; 01 20
	iorwf	extreg,#1	;n01*20
	iorwf	*extreg,#1	;n01*20
	iorwf	0x00,fcode	; 01 20
	iorwf	*0x00,fcode	; 01 20
	iorwf	extreg,fcode	;n01*20
	iorwf	*extreg,fcode	;n01*20
	iorwf	0x00,#fcode	; 01 20
	iorwf	*0x00,#fcode	; 01 20
	iorwf	extreg,#fcode	;n01*20
	iorwf	*extreg,#fcode	;n01*20

	andwf	0x00,w		; 01 40
	andwf	0x1F,w		; 01 5F
	andwf	extreg,w	;n01*40

	andwf	0x00,f		; 01 60
	andwf	0x1F,f		; 01 7F
	andwf	extreg,f	;n01*60

	andwf	*0x00,w		; 01 40
	andwf	*0x1F,w		; 01 5F
	andwf	*extreg,w	;n01*40

	andwf	*0x00,f		; 01 60
	andwf	*0x1F,f		; 01 7F
	andwf	*extreg,f	;n01*60

	andwf	0x00,0		; 01 40
	andwf	*0x00,0		; 01 40
	andwf	extreg,0	;n01*40
	andwf	*extreg,0	;n01*40
	andwf	0x00,#0		; 01 40
	andwf	*0x00,#0	; 01 40
	andwf	extreg,#0	;n01*40
	andwf	*extreg,#0	;n01*40
	andwf	0x00,wcode	; 01 40
	andwf	*0x00,wcode	; 01 40
	andwf	extreg,wcode	;n01*40
	andwf	*extreg,wcode	;n01*40
	andwf	0x00,#wcode	; 01 40
	andwf	*0x00,#wcode	; 01 40
	andwf	extreg,#wcode	;n01*40
	andwf	*extreg,#wcode	;n01*40

	andwf	0x00,1		; 01 60
	andwf	*0x00,1		; 01 60
	andwf	extreg,1	;n01*60
	andwf	*extreg,1	;n01*60
	andwf	0x00,#1		; 01 60
	andwf	*0x00,#1	; 01 60
	andwf	extreg,#1	;n01*60
	andwf	*extreg,#1	;n01*60
	andwf	0x00,fcode	; 01 60
	andwf	*0x00,fcode	; 01 60
	andwf	extreg,fcode	;n01*60
	andwf	*extreg,fcode	;n01*60
	andwf	0x00,#fcode	; 01 60
	andwf	*0x00,#fcode	; 01 60
	andwf	extreg,#fcode	;n01*60
	andwf	*extreg,#fcode	;n01*60

	xorwf	0x00,w		; 01 80
	xorwf	0x1F,w		; 01 9F
	xorwf	extreg,w	;n01*80

	xorwf	0x00,f		; 01 A0
	xorwf	0x1F,f		; 01 BF
	xorwf	extreg,f	;n01*A0

	xorwf	*0x00,w		; 01 80
	xorwf	*0x1F,w		; 01 9F
	xorwf	*extreg,w	;n01*80

	xorwf	*0x00,f		; 01 A0
	xorwf	*0x1F,f		; 01 BF
	xorwf	*extreg,f	;n01*A0

	xorwf	0x00,0		; 01 80
	xorwf	*0x00,0		; 01 80
	xorwf	extreg,0	;n01*80
	xorwf	*extreg,0	;n01*80
	xorwf	0x00,#0		; 01 80
	xorwf	*0x00,#0	; 01 80
	xorwf	extreg,#0	;n01*80
	xorwf	*extreg,#0	;n01*80
	xorwf	0x00,wcode	; 01 80
	xorwf	*0x00,wcode	; 01 80
	xorwf	extreg,wcode	;n01*80
	xorwf	*extreg,wcode	;n01*80
	xorwf	0x00,#wcode	; 01 80
	xorwf	*0x00,#wcode	; 01 80
	xorwf	extreg,#wcode	;n01*80
	xorwf	*extreg,#wcode	;n01*80

	xorwf	0x00,1		; 01 A0
	xorwf	*0x00,1		; 01 A0
	xorwf	extreg,1	;n01*A0
	xorwf	*extreg,1	;n01*A0
	xorwf	0x00,#1		; 01 A0
	xorwf	*0x00,#1	; 01 A0
	xorwf	extreg,#1	;n01*A0
	xorwf	*extreg,#1	;n01*A0
	xorwf	0x00,fcode	; 01 A0
	xorwf	*0x00,fcode	; 01 A0
	xorwf	extreg,fcode	;n01*A0
	xorwf	*extreg,fcode	;n01*A0
	xorwf	0x00,#fcode	; 01 A0
	xorwf	*0x00,#fcode	; 01 A0
	xorwf	extreg,#fcode	;n01*A0
	xorwf	*extreg,#fcode	;n01*A0

	addwf	0x00,w		; 01 C0
	addwf	0x1F,w		; 01 DF
	addwf	extreg,w	;n01*C0

	addwf	0x00,f		; 01 E0
	addwf	0x1F,f		; 01 FF
	addwf	extreg,f	;n01*E0

	addwf	*0x00,w		; 01 C0
	addwf	*0x1F,w		; 01 DF
	addwf	*extreg,w	;n01*C0

	addwf	*0x00,f		; 01 E0
	addwf	*0x1F,f		; 01 FF
 	addwf	*extreg,f	;n01*E0

	addwf	0x00,0		; 01 C0
	addwf	*0x00,0		; 01 C0
	addwf	extreg,0	;n01*C0
	addwf	*extreg,0	;n01*C0
	addwf	0x00,#0		; 01 C0
	addwf	*0x00,#0	; 01 C0
	addwf	extreg,#0	;n01*C0
	addwf	*extreg,#0	;n01*C0
	addwf	0x00,wcode	; 01 C0
	addwf	*0x00,wcode	; 01 C0
	addwf	extreg,wcode	;n01*C0
	addwf	*extreg,wcode	;n01*C0
	addwf	0x00,#wcode	; 01 C0
	addwf	*0x00,#wcode	; 01 C0
	addwf	extreg,#wcode	;n01*C0
	addwf	*extreg,#wcode	;n01*C0

	addwf	0x00,1		; 01 E0
	addwf	*0x00,1		; 01 E0
	addwf	extreg,1	;n01*E0
	addwf	*extreg,1	;n01*E0
	addwf	0x00,#1		; 01 E0
	addwf	*0x00,#1	; 01 E0
	addwf	extreg,#1	;n01*E0
	addwf	*extreg,#1	;n01*E0
	addwf	0x00,fcode	; 01 E0
	addwf	*0x00,fcode	; 01 E0
	addwf	extreg,fcode	;n01*E0
	addwf	*extreg,fcode	;n01*E0
	addwf	0x00,#fcode	; 01 E0
	addwf	*0x00,#fcode	; 01 E0
	addwf	extreg,#fcode	;n01*E0
	addwf	*extreg,#fcode	;n01*E0

	movf	0x00,w		; 02 00
	movf	0x1F,w		; 02 1F
	movf	extreg,w	;n02*00

	movf	0x00,f		; 02 20
	movf	0x1F,f		; 02 3F
	movf	extreg,f	;n02*20

	movf	*0x00,w		; 02 00
	movf	*0x1F,w		; 02 1F
	movf	*extreg,w	;n02*00

	movf	*0x00,f		; 02 20
	movf	*0x1F,f		; 02 3F
	movf	*extreg,f	;n02*20

	movf	0x00,0		; 02 00
	movf	*0x00,0		; 02 00
	movf	extreg,0	;n02*00
	movf	*extreg,0	;n02*00
	movf	0x00,#0		; 02 00
	movf	*0x00,#0	; 02 00
	movf	extreg,#0	;n02*00
	movf	*extreg,#0	;n02*00
	movf	0x00,wcode	; 02 00
	movf	*0x00,wcode	; 02 00
	movf	extreg,wcode	;n02*00
	movf	*extreg,wcode	;n02*00
	movf	0x00,#wcode	; 02 00
	movf	*0x00,#wcode	; 02 00
	movf	extreg,#wcode	;n02*00
	movf	*extreg,#wcode	;n02*00

	movf	0x00,1		; 02 20
	movf	*0x00,1		; 02 20
	movf	extreg,1	;n02*20
	movf	*extreg,1	;n02*20
	movf	0x00,#1		; 02 20
	movf	*0x00,#1	; 02 20
	movf	extreg,#1	;n02*20
	movf	*extreg,#1	;n02*20
	movf	0x00,fcode	; 02 20
	movf	*0x00,fcode	; 02 20
	movf	extreg,fcode	;n02*20
	movf	*extreg,fcode	;n02*20
	movf	0x00,#fcode	; 02 20
	movf	*0x00,#fcode	; 02 20
	movf	extreg,#fcode	;n02*20
	movf	*extreg,#fcode	;n02*20

	comf	0x00,w		; 02 40
	comf	0x1F,w		; 02 5F
	comf	extreg,w	;n02*40

	comf	0x00,f		; 02 60
	comf	0x1F,f		; 02 7F
 	comf	extreg,f	;n02*60

	comf	*0x00,w		; 02 40
	comf	*0x1F,w		; 02 5F
	comf	*extreg,w	;n02*40

	comf	*0x00,f		; 02 60
	comf	*0x1F,f		; 02 7F
 	comf	*extreg,f	;n02*60

	comf	0x00,0		; 02 40
	comf	*0x00,0		; 02 40
	comf	extreg,0	;n02*40
	comf	*extreg,0	;n02*40
	comf	0x00,#0		; 02 40
	comf	*0x00,#0	; 02 40
	comf	extreg,#0	;n02*40
	comf	*extreg,#0	;n02*40
	comf	0x00,wcode	; 02 40
	comf	*0x00,wcode	; 02 40
	comf	extreg,wcode	;n02*40
	comf	*extreg,wcode	;n02*40
	comf	0x00,#wcode	; 02 40
	comf	*0x00,#wcode	; 02 40
	comf	extreg,#wcode	;n02*40
	comf	*extreg,#wcode	;n02*40

	comf	0x00,1		; 02 60
	comf	*0x00,1		; 02 60
	comf	extreg,1	;n02*60
	comf	*extreg,1	;n02*60
	comf	0x00,#1		; 02 60
	comf	*0x00,#1	; 02 60
	comf	extreg,#1	;n02*60
	comf	*extreg,#1	;n02*60
	comf	0x00,fcode	; 02 60
	comf	*0x00,fcode	; 02 60
	comf	extreg,fcode	;n02*60
	comf	*extreg,fcode	;n02*60
	comf	0x00,#fcode	; 02 60
	comf	*0x00,#fcode	; 02 60
	comf	extreg,#fcode	;n02*60
	comf	*extreg,#fcode	;n02*60

	incf	0x00,w		; 02 80
	incf	0x1F,w		; 02 9F
	incf	extreg,w	;n02*80

	incf	0x00,f		; 02 A0
	incf	0x1F,f		; 02 BF
	incf	extreg,f	;n02*A0

	incf	*0x00,w		; 02 80
	incf	*0x1F,w		; 02 9F
	incf	*extreg,w	;n02*80

	incf	*0x00,f		; 02 A0
	incf	*0x1F,f		; 02 BF
	incf	*extreg,f	;n02*A0

	incf	0x00,0		; 02 80
	incf	*0x00,0		; 02 80
	incf	extreg,0	;n02*80
	incf	*extreg,0	;n02*80
	incf	0x00,#0		; 02 80
	incf	*0x00,#0	; 02 80
	incf	extreg,#0	;n02*80
	incf	*extreg,#0	;n02*80
	incf	0x00,wcode	; 02 80
	incf	*0x00,wcode	; 02 80
	incf	extreg,wcode	;n02*80
	incf	*extreg,wcode	;n02*80
	incf	0x00,#wcode	; 02 80
	incf	*0x00,#wcode	; 02 80
	incf	extreg,#wcode	;n02*80
	incf	*extreg,#wcode	;n02*80

	incf	0x00,1		; 02 A0
	incf	*0x00,1		; 02 A0
	incf	extreg,1	;n02*A0
	incf	*extreg,1	;n02*A0
	incf	0x00,#1		; 02 A0
	incf	*0x00,#1	; 02 A0
	incf	extreg,#1	;n02*A0
	incf	*extreg,#1	;n02*A0
	incf	0x00,fcode	; 02 A0
	incf	*0x00,fcode	; 02 A0
	incf	extreg,fcode	;n02*A0
	incf	*extreg,fcode	;n02*A0
	incf	0x00,#fcode	; 02 A0
	incf	*0x00,#fcode	; 02 A0
	incf	extreg,#fcode	;n02*A0
	incf	*extreg,#fcode	;n02*A0

	decfsz	0x00,w		; 02 C0
	decfsz	0x1F,w		; 02 DF
	decfsz	extreg,w	;n02*C0

	decfsz	0x00,f		; 02 E0
	decfsz	0x1F,f		; 02 FF
	decfsz	extreg,f	;n02*E0

	decfsz	*0x00,w		; 02 C0
	decfsz	*0x1F,w		; 02 DF
	decfsz	*extreg,w	;n02*C0

	decfsz	*0x00,f		; 02 E0
	decfsz	*0x1F,f		; 02 FF
 	decfsz	*extreg,f	;n02*E0

	decfsz	0x00,0		; 02 C0
	decfsz	*0x00,0		; 02 C0
	decfsz	extreg,0	;n02*C0
	decfsz	*extreg,0	;n02*C0
	decfsz	0x00,#0		; 02 C0
	decfsz	*0x00,#0	; 02 C0
	decfsz	extreg,#0	;n02*C0
	decfsz	*extreg,#0	;n02*C0
	decfsz	0x00,wcode	; 02 C0
	decfsz	*0x00,wcode	; 02 C0
	decfsz	extreg,wcode	;n02*C0
	decfsz	*extreg,wcode	;n02*C0
	decfsz	0x00,#wcode	; 02 C0
	decfsz	*0x00,#wcode	; 02 C0
	decfsz	extreg,#wcode	;n02*C0
	decfsz	*extreg,#wcode	;n02*C0

	decfsz	0x00,1		; 02 E0
	decfsz	*0x00,1		; 02 E0
	decfsz	extreg,1	;n02*E0
	decfsz	*extreg,1	;n02*E0
	decfsz	0x00,#1		; 02 E0
	decfsz	*0x00,#1	; 02 E0
	decfsz	extreg,#1	;n02*E0
	decfsz	*extreg,#1	;n02*E0
	decfsz	0x00,fcode	; 02 E0
	decfsz	*0x00,fcode	; 02 E0
	decfsz	extreg,fcode	;n02*E0
	decfsz	*extreg,fcode	;n02*E0
	decfsz	0x00,#fcode	; 02 E0
	decfsz	*0x00,#fcode	; 02 E0
	decfsz	extreg,#fcode	;n02*E0
	decfsz	*extreg,#fcode	;n02*E0

	rrf	0x00,w		; 03 00
	rrf	0x1F,w		; 03 1F
	rrf	extreg,w	;n03*00

	rrf	0x00,f		; 03 20
	rrf	0x1F,f		; 03 3F
	rrf	extreg,f	;n03*20

	rrf	*0x00,w		; 03 00
	rrf	*0x1F,w		; 03 1F
	rrf	*extreg,w	;n03*00

	rrf	*0x00,f		; 03 20
	rrf	*0x1F,f		; 03 3F
 	rrf	*extreg,f	;n03*20

	rrf	0x00,0		; 03 00
	rrf	*0x00,0		; 03 00
	rrf	extreg,0	;n03*00
	rrf	*extreg,0	;n03*00
	rrf	0x00,#0		; 03 00
	rrf	*0x00,#0	; 03 00
	rrf	extreg,#0	;n03*00
	rrf	*extreg,#0	;n03*00
	rrf	0x00,wcode	; 03 00
	rrf	*0x00,wcode	; 03 00
	rrf	extreg,wcode	;n03*00
	rrf	*extreg,wcode	;n03*00
	rrf	0x00,#wcode	; 03 00
	rrf	*0x00,#wcode	; 03 00
	rrf	extreg,#wcode	;n03*00
	rrf	*extreg,#wcode	;n03*00

	rrf	0x00,1		; 03 20
	rrf	*0x00,1		; 03 20
	rrf	extreg,1	;n03*20
	rrf	*extreg,1	;n03*20
	rrf	0x00,#1		; 03 20
	rrf	*0x00,#1	; 03 20
	rrf	extreg,#1	;n03*20
	rrf	*extreg,#1	;n03*20
	rrf	0x00,fcode	; 03 20
	rrf	*0x00,fcode	; 03 20
	rrf	extreg,fcode	;n03*20
	rrf	*extreg,fcode	;n03*20
	rrf	0x00,#fcode	; 03 20
	rrf	*0x00,#fcode	; 03 20
	rrf	extreg,#fcode	;n03*20
	rrf	*extreg,#fcode	;n03*20

	rlf	0x00,w		; 03 40
	rlf	0x1F,w		; 03 5F
	rlf	extreg,w	;n03*40

	rlf	0x00,f		; 03 60
	rlf	0x1F,f		; 03 7F
	rlf	extreg,f	;n03*60

	rlf	*0x00,w		; 03 40
	rlf	*0x1F,w		; 03 5F
	rlf	*extreg,w	;n03*40

	rlf	*0x00,f		; 03 60
	rlf	*0x1F,f		; 03 7F
	rlf	*extreg,f	;n03*60

	rlf	0x00,0		; 03 40
	rlf	*0x00,0		; 03 40
	rlf	extreg,0	;n03*40
	rlf	*extreg,0	;n03*40
	rlf	0x00,#0		; 03 40
	rlf	*0x00,#0	; 03 40
	rlf	extreg,#0	;n03*40
	rlf	*extreg,#0	;n03*40
	rlf	0x00,wcode	; 03 40
	rlf	*0x00,wcode	; 03 40
	rlf	extreg,wcode	;n03*40
	rlf	*extreg,wcode	;n03*40
	rlf	0x00,#wcode	; 03 40
	rlf	*0x00,#wcode	; 03 40
	rlf	extreg,#wcode	;n03*40
	rlf	*extreg,#wcode	;n03*40

	rlf	0x00,1		; 03 60
	rlf	*0x00,1		; 03 60
	rlf	extreg,1	;n03*60
	rlf	*extreg,1	;n03*60
	rlf	0x00,#1		; 03 60
	rlf	*0x00,#1	; 03 60
	rlf	extreg,#1	;n03*60
	rlf	*extreg,#1	;n03*60
	rlf	0x00,fcode	; 03 60
	rlf	*0x00,fcode	; 03 60
	rlf	extreg,fcode	;n03*60
	rlf	*extreg,fcode	;n03*60
	rlf	0x00,#fcode	; 03 60
	rlf	*0x00,#fcode	; 03 60
	rlf	extreg,#fcode	;n03*60
	rlf	*extreg,#fcode	;n03*60

	swapf	0x00,w		; 03 80
	swapf	0x1F,w		; 03 9F
	swapf	extreg,w	;n03*80

	swapf	0x00,f		; 03 A0
	swapf	0x1F,f		; 03 BF
	swapf	extreg,f	;n03*A0

	swapf	*0x00,w		; 03 80
	swapf	*0x1F,w		; 03 9F
	swapf	*extreg,w	;n03*80


	swapf	*0x00,f		; 03 A0
	swapf	*0x1F,f		; 03 BF
	swapf	*extreg,f	;n03*A0

	swapf	0x00,0		; 03 80
	swapf	*0x00,0		; 03 80
	swapf	extreg,0	;n03*80
	swapf	*extreg,0	;n03*80
	swapf	0x00,#0		; 03 80
	swapf	*0x00,#0	; 03 80
	swapf	extreg,#0	;n03*80
	swapf	*extreg,#0	;n03*80
	swapf	0x00,wcode	; 03 80
	swapf	*0x00,wcode	; 03 80
	swapf	extreg,wcode	;n03*80
	swapf	*extreg,wcode	;n03*80
	swapf	0x00,#wcode	; 03 80
	swapf	*0x00,#wcode	; 03 80
	swapf	extreg,#wcode	;n03*80
	swapf	*extreg,#wcode	;n03*80

	swapf	0x00,1		; 03 A0
	swapf	*0x00,1		; 03 A0
	swapf	extreg,1	;n03*A0
	swapf	*extreg,1	;n03*A0
	swapf	0x00,#1		; 03 A0
	swapf	*0x00,#1	; 03 A0
	swapf	extreg,#1	;n03*A0
	swapf	*extreg,#1	;n03*A0
	swapf	0x00,fcode	; 03 A0
	swapf	*0x00,fcode	; 03 A0
	swapf	extreg,fcode	;n03*A0
	swapf	*extreg,fcode	;n03*A0
	swapf	0x00,#fcode	; 03 A0
	swapf	*0x00,#fcode	; 03 A0
	swapf	extreg,#fcode	;n03*A0
	swapf	*extreg,#fcode	;n03*A0

	incfsz	0x00,w		; 03 C0
	incfsz	0x1F,w		; 03 DF
	incfsz	extreg,w	;n03*C0

	incfsz	0x00,f		; 03 E0
	incfsz	0x1F,f		; 03 FF
	incfsz	extreg,f	;n03*E0

	incfsz	*0x00,w		; 03 C0
	incfsz	*0x1F,w		; 03 DF
	incfsz	*extreg,w	;n03*C0

	incfsz	*0x00,f		; 03 E0
	incfsz	*0x1F,f		; 03 FF
	incfsz	*extreg,f	;n03*E0

	incfsz	0x00,0		; 03 C0
	incfsz	*0x00,0		; 03 C0
	incfsz	extreg,0	;n03*C0
	incfsz	*extreg,0	;n03*C0
	incfsz	0x00,#0		; 03 C0
	incfsz	*0x00,#0	; 03 C0
	incfsz	extreg,#0	;n03*C0
	incfsz	*extreg,#0	;n03*C0
	incfsz	0x00,wcode	; 03 C0
	incfsz	*0x00,wcode	; 03 C0
	incfsz	extreg,wcode	;n03*C0
	incfsz	*extreg,wcode	;n03*C0
	incfsz	0x00,#wcode	; 03 C0
	incfsz	*0x00,#wcode	; 03 C0
	incfsz	extreg,#wcode	;n03*C0
	incfsz	*extreg,#wcode	;n03*C0

	incfsz	0x00,1		; 03 E0
	incfsz	*0x00,1		; 03 E0
	incfsz	extreg,1	;n03*E0
	incfsz	*extreg,1	;n03*E0
	incfsz	0x00,#1		; 03 E0
	incfsz	*0x00,#1	; 03 E0
	incfsz	extreg,#1	;n03*E0
	incfsz	*extreg,#1	;n03*E0
	incfsz	0x00,fcode	; 03 E0
	incfsz	*0x00,fcode	; 03 E0
	incfsz	extreg,fcode	;n03*E0
	incfsz	*extreg,fcode	;n03*E0
	incfsz	0x00,#fcode	; 03 E0
	incfsz	*0x00,#fcode	; 03 E0
	incfsz	extreg,#fcode	;n03*E0
	incfsz	*extreg,#fcode	;n03*E0

	bcf	0x00,0		; 04 00
	bcf	0x1F,0		; 04 1F
	bcf	extreg,0	;n04*00

	bcf	0x00,7		; 04 E0
	bcf	0x1F,7		; 04 FF
	bcf	extreg,7	;n04*E0

	bcf	*0x00,0		; 04 00
	bcf	*0x1F,0		; 04 1F
	bcf	*extreg,0	;n04*00

	bcf	*0x00,7		; 04 E0
	bcf	*0x1F,7		; 04 FF
	bcf	*extreg,7	;n04*E0

	bcf	0x00,num0	; 04 00
	bcf	*0x00,num0	; 04 00
	bcf	extreg,num0	;n04*00
	bcf	*extreg,num0	;n04*00
	bcf	0x00,#num0	; 04 00
	bcf	*0x00,#num0	; 04 00
	bcf	extreg,#num0	;n04*00
	bcf	*extreg,#num0	;n04*00
	bcf	0x00,num7	; 04 E0
	bcf	*0x00,num7	; 04 E0
	bcf	extreg,num7	;n04*E0
	bcf	*extreg,num7	;n04*E0
	bcf	0x00,#num7	; 04 E0
	bcf	*0x00,#num7	; 04 E0
	bcf	extreg,#num7	;n04*E0
	bcf	*extreg,#num7	;n04*E0

	bsf	0x00,0		; 05 00
	bsf	0x1F,0		; 05 1F
	bsf	extreg,0	;n05*00

	bsf	0x00,7		; 05 E0
	bsf	0x1F,7		; 05 FF
	bsf	extreg,7	;n05*E0

	bsf	*0x00,0		; 05 00
	bsf	*0x1F,0		; 05 1F
	bsf	*extreg,0	;n05*00

	bsf	*0x00,7		; 05 E0
	bsf	*0x1F,7		; 05 FF
 	bsf	*extreg,7	;n05*E0

	bsf	0x00,num0	; 05 00
	bsf	*0x00,num0	; 05 00
	bsf	extreg,num0	;n05*00
	bsf	*extreg,num0	;n05*00
	bsf	0x00,#num0	; 05 00
	bsf	*0x00,#num0	; 05 00
	bsf	extreg,#num0	;n05*00
	bsf	*extreg,#num0	;n05*00
	bsf	0x00,num7	; 05 E0
	bsf	*0x00,num7	; 05 E0
	bsf	extreg,num7	;n05*E0
	bsf	*extreg,num7	;n05*E0
	bsf	0x00,#num7	; 05 E0
	bsf	*0x00,#num7	; 05 E0
	bsf	extreg,#num7	;n05*E0
	bsf	*extreg,#num7	;n05*E0

	btfsc	0x00,0		; 06 00
	btfsc	0x1F,0		; 06 1F
	btfsc	extreg,0	;n06*00

	btfsc	0x00,7		; 06 E0
	btfsc	0x1F,7		; 06 FF
	btfsc	extreg,7	;n06*E0

	btfsc	*0x00,0		; 06 00
	btfsc	*0x1F,0		; 06 1F
	btfsc	*extreg,0	;n06*00

	btfsc	*0x00,7		; 06 E0
	btfsc	*0x1F,7		; 06 FF
	btfsc	*extreg,7	;n06*E0

	btfsc	0x00,num0	; 06 00
	btfsc	*0x00,num0	; 06 00
	btfsc	extreg,num0	;n06*00
	btfsc	*extreg,num0	;n06*00
	btfsc	0x00,#num0	; 06 00
	btfsc	*0x00,#num0	; 06 00
	btfsc	extreg,#num0	;n06*00
	btfsc	*extreg,#num0	;n06*00
	btfsc	0x00,num7	; 06 E0
	btfsc	*0x00,num7	; 06 E0
	btfsc	extreg,num7	;n06*E0
	btfsc	*extreg,num7	;n06*E0
	btfsc	0x00,#num7	; 06 E0
	btfsc	*0x00,#num7	; 06 E0
	btfsc	extreg,#num7	;n06*E0
	btfsc	*extreg,#num7	;n06*E0

	btfss	0x00,0		; 07 00
	btfss	0x1F,0		; 07 1F
	btfss	extreg,0	;n07*00

	btfss	0x00,7		; 07 E0
	btfss	0x1F,7		; 07 FF
	btfss	extreg,7	;n07*E0

	btfss	*0x00,0		; 07 00
	btfss	*0x1F,0		; 07 1F
	btfss	*extreg,0	;n07*00

	btfss	*0x00,7		; 07 E0
	btfss	*0x1F,7		; 07 FF
	btfss	*extreg,7	;n07*E0

	btfss	0x00,num0	; 07 00
	btfss	*0x00,num0	; 07 00
	btfss	extreg,num0	;n07*00
	btfss	*extreg,num0	;n07*00
	btfss	0x00,#num0	; 07 00
	btfss	*0x00,#num0	; 07 00
	btfss	extreg,#num0	;n07*00
	btfss	*extreg,#num0	;n07*00
	btfss	0x00,num7	; 07 E0
	btfss	*0x00,num7	; 07 E0
	btfss	extreg,num7	;n07*E0
	btfss	*extreg,num7	;n07*E0
	btfss	0x00,#num7	; 07 E0
	btfss	*0x00,#num7	; 07 E0
	btfss	extreg,#num7	;n07*E0
	btfss	*extreg,#num7	;n07*E0

	retlw	0x00		; 08 00
	retlw	0xFF		; 08 FF
	retlw	extvalu		;s08r00

	retlw	#0x00		; 08 00
	retlw	#0xFF		; 08 FF
	retlw	#extvalu	;s08r00

	call	0x00		; 09 00
	call	0xFF		; 09 FF

	call	addr_00		;s09r00
	call	addr_FF		;s09rFF

	call	extaddr		;s09r00

	goto	0x00		; 0A 00
	goto	0x1FF		; 0B FF

	goto	addr_00		;s0Ar00
	goto	addr_1FF	;s0BrFF

	goto	extaddr		;s0Ar00

	movlw	0x00		; 0C 00
	movlw	0xFF		; 0C FF
	movlw	extvalu		;s0Cr00

	movlw	#0x00		; 0C 00
	movlw	#0xFF		; 0C FF
	movlw	#extvalu	;s0Cr00

	iorlw	0x00		; 0D 00
	iorlw	0xFF		; 0D FF
	iorlw	extvalu		;s0Dr00

	iorlw	#0x00		; 0D 00
	iorlw	#0xFF		; 0D FF
	iorlw	#extvalu	;s0Dr00

	andlw	0x00		; 0E 00
	andlw	0xFF		; 0E FF
	andlw	extvalu		;s0Er00

	andlw	#0x00		; 0E 00
	andlw	#0xFF		; 0E FF
	andlw	#extvalu	;s0Er00

	xorlw	0x00		; 0F 00
	xorlw	0xFF		; 0F FF
	xorlw	extvalu		;s0Fr00

	xorlw	#0x00		; 0F 00
	xorlw	#0xFF		; 0F FF
	xorlw	#extvalu	;s0Fr00



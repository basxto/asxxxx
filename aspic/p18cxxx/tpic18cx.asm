;  TPIC18CX.ASM - Test file for ASPIC assembler
;
;  Assemble:
;	aspic -gloaxff tpic18cx
;

 	.include	"tpic18cx.def"


	.area	DATA

	fcode =		1
	wcode =		0

	num0 =		0
	num7 =		7

	num1 =		1

	.area	CODE

	addr_00	=	. + 0x00
	addr_0FFFFF =	. + 0x0fffff

	nop			; 00 00

	sleep			; 00 03
	clrwdt			; 00 04

	push			; 00 05
	pop			; 00 06

	daw			; 00 07

	tblrd			; 00 08
	tblrd*			; 00 08
	tblrd*+			; 00 09
	tblrd*-			; 00 0A
	tblrd+*			; 00 0B

	tblwt			; 00 0C
	tblwt*			; 00 0C
	tblwt*+			; 00 0D
	tblwt*-			; 00 0E
	tblwt+*			; 00 0F

	retfie			; 00 10
	return			; 00 12

	;
	; First of Type S_F Instructions
	; Comprehensive Testing
	;
	; Constant Addressing ==>> 'Data Memory Map' Addressing
	;	Absolute addresses 0x00-0x7F and 0xF80-0xFFF are always
	;	'access bank' mapped when the 'a' parameter is blank.
	;	Additional bank address	checking is performed by the linker.
	;
	movlb	0x0F		; 01 0F
.setdmm	0x0F*0x100,DATA
	mulwf	0x00		; 02 00
	mulwf	0x7F		; 02 7F

	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA
	mulwf	0x00		; 02 00
	mulwf	0x7F		; 02 7F
	mulwf	0x80		;n03*80
	mulwf	0xFF		;n03*FF

	movlb	0x01		; 01 01
.setdmm	0x01*0x100,DATA
	mulwf	0x100		;n03*00
	mulwf	0x17F		;n03*7F
	mulwf	0x180		;n03*80
	mulwf	0x1FF		;n03*FF

	movlb	0x02		; 01 02
.setdmm	0x02*0x100,DATA
	mulwf	0x200		;n03*00
	mulwf	0x27F		;n03*7F
	mulwf	0x280		;n03*80
	mulwf	0x2FF		;n03*FF

	movlb	0x03		; 01 03
.setdmm	0x03*0x100,DATA
	mulwf	0x300		;n03*00
	mulwf	0x37F		;n03*7F
	mulwf	0x380		;n03*80
	mulwf	0x3FF		;n03*FF

	movlb	0x04		; 01 04
.setdmm	0x04*0x100,DATA
	mulwf	0x400		;n03*00
	mulwf	0x47F		;n03*7F
	mulwf	0x480		;n03*80
	mulwf	0x4FF		;n03*FF

	movlb	0x05		; 01 05
.setdmm	0x05*0x100,DATA
	mulwf	0x500		;n03*00
	mulwf	0x57F		;n03*7F
	mulwf	0x580		;n03*80
	mulwf	0x5FF		;n03*FF

	movlb	0x06		; 01 06
.setdmm	0x06*0x100,DATA
	mulwf	0x600		;n03*00
	mulwf	0x67F		;n03*7F
	mulwf	0x680		;n03*80
	mulwf	0x6FF		;n03*FF

	movlb	0x07		; 01 07
.setdmm	0x07*0x100,DATA
	mulwf	0x700		;n03*00
	mulwf	0x77F		;n03*7F
	mulwf	0x780		;n03*80
	mulwf	0x7FF		;n03*FF

	movlb	0x08		; 01 08
.setdmm	0x08*0x100,DATA
	mulwf	0x800		;n03*00
	mulwf	0x87F		;n03*7F
	mulwf	0x880		;n03*80
	mulwf	0x8FF		;n03*FF

	movlb	0x09		; 01 09
.setdmm	0x09*0x100,DATA
	mulwf	0x900		;n03*00
	mulwf	0x97F		;n03*7F
	mulwf	0x980		;n03*80
	mulwf	0x9FF		;n03*FF

	movlb	0x0A		; 01 0A
.setdmm	0x0A*0x100,DATA
	mulwf	0xA00		;n03*00
	mulwf	0xA7F		;n03*7F
	mulwf	0xA80		;n03*80
	mulwf	0xAFF		;n03*FF

	movlb	0x0B		; 01 0B
.setdmm	0x0B*0x100,DATA
	mulwf	0xB00		;n03*00
	mulwf	0xB7F		;n03*7F
	mulwf	0xB80		;n03*80
	mulwf	0xBFF		;n03*FF

	movlb	0x0C		; 01 0C
.setdmm	0x0C*0x100,DATA
	mulwf	0xC00		;n03*00
	mulwf	0xC7F		;n03*7F
	mulwf	0xC80		;n03*80
	mulwf	0xCFF		;n03*FF

	movlb	0x0D		; 01 0D
.setdmm	0x0D*0x100,DATA
	mulwf	0xD00		;n03*00
	mulwf	0xD7F		;n03*7F
	mulwf	0xD80		;n03*80
	mulwf	0xDFF		;n03*FF

	movlb	0x0E		; 01 0E
.setdmm	0x0E*0x100,DATA
	mulwf	0xE00		;n03*00
	mulwf	0xE7F		;n03*7F
	mulwf	0xE80		;n03*80
	mulwf	0xEFF		;n03*FF

	movlb	0x0F		; 01 0F
.setdmm	0x0F*0x100,DATA
	mulwf	0xF00		;n03*00
	mulwf	0xF7F		;n03*7F
	mulwf	0xF80		; 02 80
	mulwf	0xFFF		; 02 FF

	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA
	mulwf	0xF80		; 02 80
	mulwf	0xFFF		; 02 FF

	;
	; 'Data Memory Map' Addressing.
	;	Absolute addresses 0x00-0x7F and 0xF80-0xFFF are always
	;	'access bank' mapped when the 'a' parameter is blank.
	;	Additional bank address	checking is performed by the linker.
	;
	movlb	0x0F		; 01 0F
.setdmm	0x0F*0x100,DATA
	mulwf	*0x00		; 02 00
	mulwf	*0x7F		; 02 7F

	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA
	mulwf	*0x00		; 02 00
	mulwf	*0x7F		; 02 7F
	mulwf	*0x80		;n03*80
	mulwf	*0xFF		;n03*FF

	movlb	0x01		; 01 01
.setdmm	0x01*0x100,DATA
	mulwf	*0x100		;n03*00
	mulwf	*0x17F		;n03*7F
	mulwf	*0x180		;n03*80
	mulwf	*0x1FF		;n03*FF

	movlb	0x02		; 01 02
.setdmm	0x02*0x100,DATA
	mulwf	*0x200		;n03*00
	mulwf	*0x27F		;n03*7F
	mulwf	*0x280		;n03*80
	mulwf	*0x2FF		;n03*FF

	movlb	0x03		; 01 03
.setdmm	0x03*0x100,DATA
	mulwf	*0x300		;n03*00
	mulwf	*0x37F		;n03*7F
	mulwf	*0x380		;n03*80
	mulwf	*0x3FF		;n03*FF

	movlb	0x04		; 01 04
.setdmm	0x04*0x100,DATA
	mulwf	*0x400		;n03*00
	mulwf	*0x47F		;n03*7F
	mulwf	*0x480		;n03*80
	mulwf	*0x4FF		;n03*FF

	movlb	0x05		; 01 05
.setdmm	0x05*0x100,DATA
	mulwf	*0x500		;n03*00
	mulwf	*0x57F		;n03*7F
	mulwf	*0x580		;n03*80
	mulwf	*0x5FF		;n03*FF

	movlb	0x06		; 01 06
.setdmm	0x06*0x100,DATA
	mulwf	*0x600		;n03*00
	mulwf	*0x67F		;n03*7F
	mulwf	*0x680		;n03*80
	mulwf	*0x6FF		;n03*FF

	movlb	0x07		; 01 07
.setdmm	0x07*0x100,DATA
	mulwf	*0x700		;n03*00
	mulwf	*0x77F		;n03*7F
	mulwf	*0x780		;n03*80
	mulwf	*0x7FF		;n03*FF

	movlb	0x08		; 01 08
.setdmm	0x08*0x100,DATA
	mulwf	*0x800		;n03*00
	mulwf	*0x87F		;n03*7F
	mulwf	*0x880		;n03*80
	mulwf	*0x8FF		;n03*FF

	movlb	0x09		; 01 09
.setdmm	0x09*0x100,DATA
	mulwf	*0x900		;n03*00
	mulwf	*0x97F		;n03*7F
	mulwf	*0x980		;n03*80
	mulwf	*0x9FF		;n03*FF

	movlb	0x0A		; 01 0A
.setdmm	0x0A*0x100,DATA
	mulwf	*0xA00		;n03*00
	mulwf	*0xA7F		;n03*7F
	mulwf	*0xA80		;n03*80
	mulwf	*0xAFF		;n03*FF

	movlb	0x0B		; 01 0B
.setdmm	0x0B*0x100,DATA
	mulwf	*0xB00		;n03*00
	mulwf	*0xB7F		;n03*7F
	mulwf	*0xB80		;n03*80
	mulwf	*0xBFF		;n03*FF

	movlb	0x0C		; 01 0C
.setdmm	0x0C*0x100,DATA
	mulwf	*0xC00		;n03*00
	mulwf	*0xC7F		;n03*7F
	mulwf	*0xC80		;n03*80
	mulwf	*0xCFF		;n03*FF

	movlb	0x0D		; 01 0D
.setdmm	0x0D*0x100,DATA
	mulwf	*0xD00		;n03*00
	mulwf	*0xD7F		;n03*7F
	mulwf	*0xD80		;n03*80
	mulwf	*0xDFF		;n03*FF

	movlb	0x0E		; 01 0E
.setdmm	0x0E*0x100,DATA
	mulwf	*0xE00		;n03*00
	mulwf	*0xE7F		;n03*7F
	mulwf	*0xE80		;n03*80
	mulwf	*0xEFF		;n03*FF

	movlb	0x0F		; 01 0F
.setdmm	0x0F*0x100,DATA
	mulwf	*0xF00		;n03*00
	mulwf	*0xF7F		;n03*7F
	mulwf	*0xF80		; 02 80
	mulwf	*0xFFF		; 02 FF

	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA
	mulwf	*0xF80		; 02 80
	mulwf	*0xFFF		; 02 FF

	; Constant Addressing ==>> 'Data Memory Map' Addressing
	;	Absolute addresses 0x00-0x7F and 0xF80-0xFFF are
	;	not automatically 'access bank' mapped when the
	;	'a' parameter is specified.  An absolute address
	;	of 0x080-0xF7F with an 'a' parameter of value '0'
	;	will report an 'a' error.  Additional address
	;	checking is performed by the linker.
	;
	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA
	mulwf	0x00,1		;n03*00
	mulwf	0x7F,1		;n03*7F

	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA
	mulwf	0x00,1		;n03*00
	mulwf	0x7F,1		;n03*7F
	mulwf	0x80,1		;n03*80
	mulwf	0xFF,1		;n03*FF

	movlb	0x01		; 01 01
.setdmm	0x01*0x100,DATA
	mulwf	0x100,1		;n03*00
	mulwf	0x17F,1		;n03*7F
	mulwf	0x180,1		;n03*80
	mulwf	0x1FF,1		;n03*FF

	movlb	0x02		; 01 02
.setdmm	0x02*0x100,DATA
	mulwf	0x200,1		;n03*00
	mulwf	0x27F,1		;n03*7F
	mulwf	0x280,1		;n03*80
	mulwf	0x2FF,1		;n03*FF

	movlb	0x03		; 01 03
.setdmm	0x03*0x100,DATA
	mulwf	0x300,1		;n03*00
	mulwf	0x37F,1		;n03*7F
	mulwf	0x380,1		;n03*80
	mulwf	0x3FF,1		;n03*FF

	movlb	0x04		; 01 04
.setdmm	0x04*0x100,DATA
	mulwf	0x400,1		;n03*00
	mulwf	0x47F,1		;n03*7F
	mulwf	0x480,1		;n03*80
	mulwf	0x4FF,1		;n03*FF

	movlb	0x05		; 01 05
.setdmm	0x05*0x100,DATA
	mulwf	0x500,1		;n03*00
	mulwf	0x57F,1		;n03*7F
	mulwf	0x580,1		;n03*80
	mulwf	0x5FF,1		;n03*FF

	movlb	0x06		; 01 06
.setdmm	0x06*0x100,DATA
	mulwf	0x600,1		;n03*00
	mulwf	0x67F,1		;n03*7F
	mulwf	0x680,1		;n03*80
	mulwf	0x6FF,1		;n03*FF

	movlb	0x07		; 01 07
.setdmm	0x07*0x100,DATA
	mulwf	0x700,1		;n03*00
	mulwf	0x77F,1		;n03*7F
	mulwf	0x780,1		;n03*80
	mulwf	0x7FF,1		;n03*FF

	movlb	0x08		; 01 08
.setdmm	0x08*0x100,DATA
	mulwf	0x800,1		;n03*00
	mulwf	0x87F,1		;n03*7F
	mulwf	0x880,1		;n03*80
	mulwf	0x8FF,1		;n03*FF

	movlb	0x09		; 01 09
.setdmm	0x09*0x100,DATA
	mulwf	0x900,1		;n03*00
	mulwf	0x97F,1		;n03*7F
	mulwf	0x980,1		;n03*80
	mulwf	0x9FF,1		;n03*FF

	movlb	0x0A		; 01 0A
.setdmm	0x0A*0x100,DATA
	mulwf	0xA00,1		;n03*00
	mulwf	0xA7F,1		;n03*7F
	mulwf	0xA80,1		;n03*80
	mulwf	0xAFF,1		;n03*FF

	movlb	0x0B		; 01 0B
.setdmm	0x0B*0x100,DATA
	mulwf	0xB00,1		;n03*00
	mulwf	0xB7F,1		;n03*7F
	mulwf	0xB80,1		;n03*80
	mulwf	0xBFF,1		;n03*FF

	movlb	0x0C		; 01 0C
.setdmm	0x0C*0x100,DATA
	mulwf	0xC00,1		;n03*00
	mulwf	0xC7F,1		;n03*7F
	mulwf	0xC80,1		;n03*80
	mulwf	0xCFF,1		;n03*FF

	movlb	0x0D		; 01 0D
.setdmm	0x0D*0x100,DATA
	mulwf	0xD00,1		;n03*00
	mulwf	0xD7F,1		;n03*7F
	mulwf	0xD80,1		;n03*80
	mulwf	0xDFF,1		;n03*FF

	movlb	0x0E		; 01 0E
.setdmm	0x0E*0x100,DATA
	mulwf	0xE00,1		;n03*00
	mulwf	0xE7F,1		;n03*7F
	mulwf	0xE80,1		;n03*80
	mulwf	0xEFF,1		;n03*FF

	movlb	0x0F		; 01 0F
.setdmm	0x0F*0x100,DATA
	mulwf	0xF00,1		;n03*00
	mulwf	0xF7F,1		;n03*7F
	mulwf	0xF80,1		;n03*80
	mulwf	0xFFF,1		;n03*FF

	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA

	;
	; 'Data Memory Map' Addressing.
	;	Absolute addresses 0x00-0x7F and 0xF80-0xFFF are
	;	not automatically 'access bank' mapped when the
	;	'a' parameter is specified.  An absolute address
	;	of 0x080-0xF7F with an 'a' parameter of value '0'
	;	will report an 'a' error.  Additional bank address
	;	checking is performed by the linker.
	;
	;
	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA
	mulwf	*0x00,1		;n03*00
	mulwf	*0x7F,1		;n03*7F

	mulwf	*0x00,1		;n03*00
	mulwf	*0x7F,1		;n03*7F
	mulwf	*0x80,1		;n03*80
	mulwf	*0xFF,1		;n03*FF

	movlb	0x01		; 01 01
.setdmm	0x01*0x100,DATA
	mulwf	*0x100,1	;n03*00
	mulwf	*0x17F,1	;n03*7F
	mulwf	*0x180,1	;n03*80
	mulwf	*0x1FF,1	;n03*FF

	movlb	0x02		; 01 02
.setdmm	0x02*0x100,DATA
	mulwf	*0x200,1	;n03*00
	mulwf	*0x27F,1	;n03*7F
	mulwf	*0x280,1	;n03*80
	mulwf	*0x2FF,1	;n03*FF

	movlb	0x03		; 01 03
.setdmm	0x03*0x100,DATA
	mulwf	*0x300,1	;n03*00
	mulwf	*0x37F,1	;n03*7F
	mulwf	*0x380,1	;n03*80
	mulwf	*0x3FF,1	;n03*FF

	movlb	0x04		; 01 04
.setdmm	0x04*0x100,DATA
	mulwf	*0x400,1	;n03*00
	mulwf	*0x47F,1	;n03*7F
	mulwf	*0x480,1	;n03*80
	mulwf	*0x4FF,1	;n03*FF

	movlb	0x05		; 01 05
.setdmm	0x05*0x100,DATA
	mulwf	*0x500,1	;n03*00
	mulwf	*0x57F,1	;n03*7F
	mulwf	*0x580,1	;n03*80
	mulwf	*0x5FF,1	;n03*FF

	movlb	0x06		; 01 06
.setdmm	0x06*0x100,DATA
	mulwf	*0x600,1	;n03*00
	mulwf	*0x67F,1	;n03*7F
	mulwf	*0x680,1	;n03*80
	mulwf	*0x6FF,1	;n03*FF

	movlb	0x07		; 01 07
.setdmm	0x07*0x100,DATA
	mulwf	*0x700,1	;n03*00
	mulwf	*0x77F,1	;n03*7F
	mulwf	*0x780,1	;n03*80
	mulwf	*0x7FF,1	;n03*FF

	movlb	0x08		; 01 08
.setdmm	0x08*0x100,DATA
	mulwf	*0x800,1	;n03*00
	mulwf	*0x87F,1	;n03*7F
	mulwf	*0x880,1	;n03*80
	mulwf	*0x8FF,1	;n03*FF

	movlb	0x09		; 01 09
.setdmm	0x09*0x100,DATA
	mulwf	*0x900,1	;n03*00
	mulwf	*0x97F,1	;n03*7F
	mulwf	*0x980,1	;n03*80
	mulwf	*0x9FF,1	;n03*FF

	movlb	0x0A		; 01 0A
.setdmm	0x0A*0x100,DATA
	mulwf	*0xA00,1	;n03*00
	mulwf	*0xA7F,1	;n03*7F
	mulwf	*0xA80,1	;n03*80
	mulwf	*0xAFF,1	;n03*FF

	movlb	0x0B		; 01 0B
.setdmm	0x0B*0x100,DATA
	mulwf	*0xB00,1	;n03*00
	mulwf	*0xB7F,1	;n03*7F
	mulwf	*0xB80,1	;n03*80
	mulwf	*0xBFF,1	;n03*FF

	movlb	0x0C		; 01 0C
.setdmm	0x0C*0x100,DATA
	mulwf	*0xC00,1	;n03*00
	mulwf	*0xC7F,1	;n03*7F
	mulwf	*0xC80,1	;n03*80
	mulwf	*0xCFF,1	;n03*FF

	movlb	0x0D		; 01 0D
.setdmm	0x0D*0x100,DATA
	mulwf	*0xD00,1	;n03*00
	mulwf	*0xD7F,1	;n03*7F
	mulwf	*0xD80,1	;n03*80
	mulwf	*0xDFF,1	;n03*FF

	movlb	0x0E		; 01 0E
.setdmm	0x0E*0x100,DATA
	mulwf	*0xE00,1	;n03*00
	mulwf	*0xE7F,1	;n03*7F
	mulwf	*0xE80,1	;n03*80
	mulwf	*0xEFF,1	;n03*FF

	movlb	0x0F		; 01 0F
.setdmm	0x0F*0x100,DATA
	mulwf	*0xF00,1	;n03*00
	mulwf	*0xF7F,1	;n03*7F
	mulwf	*0xF80,1	;n03*80
	mulwf	*0xFFF,1	;n03*FF

	mulwf	*0xF80,1	;n03*80
	mulwf	*0xFFF,1	;n03*FF

	movlb	0x00		; 01 00
.setdmm	0x00*0x100,DATA
	
	;
	; External Addressing ==>> 'Data Memory Map' Addressing
	;
	mulwf	extaddr		;n03*00
	mulwf	*extaddr	;n03*00

	mulwf	extaddr,0	;s02r00
	mulwf	*extaddr,0	;s02r00

	mulwf	extaddr,1	;n03*00
	mulwf	*extaddr,1	;n03*00

	movwf	0x00		; 6E 00
	movwf	0x7F		; 6E 7F
	movwf	0x80		;n6F*80
	movwf	0xF80		; 6E 80
	movwf	0xFFF		; 6E FF
	movwf	extaddr		;n6F*00

	movwf	*0x00		; 6E 00
	movwf	*0x7F		; 6E 7F
	movwf	*0x80		;n6F*80
.setdmm	0xF00,DATA
	movwf	*0xF7F		;n6F*7F
.setdmm	0x000,DATA
	movwf	*0xF80		; 6E 80
	movwf	*0xFFF		; 6E FF
	movwf	*extaddr	;n6F*00

	subwfb	0x00,w		; 58 00
	subwfb	0xFF,w		;n59*FF
	subwfb	0xFFF,w		; 58 FF
	subwfb	extaddr,w	;n59*00

	subwfb	0x00,f		; 5A 00
	subwfb	0xFFF,f		; 5A FF
	subwfb	0xFF,f		;n5B*FF
	subwfb	extaddr,f	;n5B*00

	subwfb	*0x00,w		; 58 00
	subwfb	*0xFFF,w	; 58 FF
	subwfb	*0xFF,w		;n59*FF
	subwfb	*extaddr,w	;n59*00

	subwfb	*0x00,f		; 5A 00
	subwfb	*0xFFF,f	; 5A FF
	subwfb	*0xFF,f		;n5B*FF
	subwfb	*extaddr,f	;n5B*00

	subwfb	0x00,0		; 58 00
	subwfb	*0x00,0		; 58 00
	subwfb	extaddr,0	;n59*00
	subwfb	*extaddr,0	;n59*00
	subwfb	0x00,#0		; 58 00
	subwfb	*0x00,#0	; 58 00
	subwfb	extaddr,#0	;n59*00
	subwfb	*extaddr,#0	;n59*00
	subwfb	0x00,wcode	; 58 00
	subwfb	*0x00,wcode	; 58 00
	subwfb	extaddr,wcode	;n59*00
	subwfb	*extaddr,wcode	;n59*00
	subwfb	0x00,#wcode	; 58 00
	subwfb	*0x00,#wcode	; 58 00
	subwfb	extaddr,#wcode	;n59*00
	subwfb	*extaddr,#wcode	;n59*00

	subwfb	0x00,1		; 5A 00
	subwfb	*0x00,1		; 5A 00
	subwfb	extaddr,1	;n5B*00
	subwfb	*extaddr,1	;n5B*00
	subwfb	0x00,#1		; 5A 00
	subwfb	*0x00,#1	; 5A 00
	subwfb	extaddr,#1	;n5B*00
	subwfb	*extaddr,#1	;n5B*00
	subwfb	0x00,fcode	; 5A 00
	subwfb	*0x00,fcode	; 5A 00
	subwfb	extaddr,fcode	;n5B*00
	subwfb	*extaddr,fcode	;n5B*00
	subwfb	0x00,#fcode	; 5A 00
	subwfb	*0x00,#fcode	; 5A 00
	subwfb	extaddr,#fcode	;n5B*00
	subwfb	*extaddr,#fcode	;n5B*00

	subwf	0x00,w		; 5C 00
	subwf	0xFF,w		;n5D*FF
	subwf	extaddr,w	;n5D*00

	subwf	0x00,f		; 5E 00
	subwf	0xFF,f		;n5F*FF
	subwf	extaddr,f	;n5F*00

	subwf	*0x00,w		; 5C 00
	subwf	*0xFF,w		;n5D*FF
	subwf	*extaddr,w	;n5D*00

	subwf	*0x00,f		; 5E 00
	subwf	*0xFF,f		;n5F*FF
	subwf	*extaddr,f	;n5F*00

	subwf	0x00,0		; 5C 00
	subwf	*0x00,0		; 5C 00
	subwf	extaddr,0	;n5D*00
	subwf	*extaddr,0	;n5D*00
	subwf	0x00,#0		; 5C 00
	subwf	*0x00,#0	; 5C 00
	subwf	extaddr,#0	;n5D*00
	subwf	*extaddr,#0	;n5D*00
	subwf	0x00,wcode	; 5C 00
	subwf	*0x00,wcode	; 5C 00
	subwf	extaddr,wcode	;n5D*00
	subwf	*extaddr,wcode	;n5D*00
	subwf	0x00,#wcode	; 5C 00
	subwf	*0x00,#wcode	; 5C 00
	subwf	extaddr,#wcode	;n5D*00
	subwf	*extaddr,#wcode	;n5D*00

	subwf	0x00,1		; 5E 00
	subwf	*0x00,1		; 5E 00
	subwf	extaddr,1	;n5F*00
	subwf	*extaddr,1	;n5F*00
	subwf	0x00,#1		; 5E 00
	subwf	*0x00,#1	; 5E 00
	subwf	extaddr,#1	;n5F*00
	subwf	*extaddr,#1	;n5F*00
	subwf	0x00,fcode	; 5E 00
	subwf	*0x00,fcode	; 5E 00
	subwf	extaddr,fcode	;n5F*00
	subwf	*extaddr,fcode	;n5F*00
	subwf	0x00,#fcode	; 5E 00
	subwf	*0x00,#fcode	; 5E 00
	subwf	extaddr,#fcode	;n5F*00
	subwf	*extaddr,#fcode	;n5F*00

	decf	0x00,w		; 04 00
	decf	0xFF,w		;n05*FF
	decf	extaddr,w	;n05*00

	decf	0x00,f		; 06 00
	decf	0xFF,f		;n07*FF
	decf	extaddr,f	;n07*00

	decf	*0x00,w		; 04 00
	decf	*0xFF,w		;n05*FF
	decf	*extaddr,w	;n05*00

	decf	*0x00,f		; 06 00
	decf	*0xFF,f		;n07*FF
	decf	*extaddr,f	;n07*00

	decf	0x00,0		; 04 00
	decf	*0x00,0		; 04 00
	decf	extaddr,0	;n05*00
	decf	*extaddr,0	;n05*00
	decf	0x00,#0		; 04 00
	decf	*0x00,#0	; 04 00
	decf	extaddr,#0	;n05*00
	decf	*extaddr,#0	;n05*00
	decf	0x00,wcode	; 04 00
	decf	*0x00,wcode	; 04 00
	decf	extaddr,wcode	;n05*00
	decf	*extaddr,wcode	;n05*00
	decf	0x00,#wcode	; 04 00
	decf	*0x00,#wcode	; 04 00
	decf	extaddr,#wcode	;n05*00
	decf	*extaddr,#wcode	;n05*00

	decf	0x00,1		; 06 00
	decf	*0x00,1		; 06 00
	decf	extaddr,1	;n07*00
	decf	*extaddr,1	;n07*00
	decf	0x00,#1		; 06 00
	decf	*0x00,#1	; 06 00
	decf	extaddr,#1	;n07*00
	decf	*extaddr,#1	;n07*00
	decf	0x00,fcode	; 06 00
	decf	*0x00,fcode	; 06 00
	decf	extaddr,fcode	;n07*00
	decf	*extaddr,fcode	;n07*00
	decf	0x00,#fcode	; 06 00
	decf	*0x00,#fcode	; 06 00
	decf	extaddr,#fcode	;n07*00
	decf	*extaddr,#fcode	;n07*00

	iorwf	0x00,w		; 10 00
	iorwf	0xFF,w		;n11*FF
	iorwf	extaddr,w	;n11*00

	iorwf	0x00,f		; 12 00
	iorwf	0xFF,f		;n13*FF
	iorwf	extaddr,f	;n13*00

	iorwf	*0x00,w		; 10 00
	iorwf	*0xFF,w		;n11*FF
	iorwf	*extaddr,w	;n11*00

	iorwf	*0x00,f		; 12 00
	iorwf	*0xFF,f		;n13*FF
	iorwf	*extaddr,f	;n13*00

	iorwf	0x00,0		; 10 00
	iorwf	*0x00,0		; 10 00
	iorwf	extaddr,0	;n11*00
	iorwf	*extaddr,0	;n11*00
	iorwf	0x00,#0		; 10 00
	iorwf	*0x00,#0	; 10 00
	iorwf	extaddr,#0	;n11*00
	iorwf	*extaddr,#0	;n11*00
	iorwf	0x00,wcode	; 10 00
	iorwf	*0x00,wcode	; 10 00
	iorwf	extaddr,wcode	;n11*00
	iorwf	*extaddr,wcode	;n11*00
	iorwf	0x00,#wcode	; 10 00
	iorwf	*0x00,#wcode	; 10 00
	iorwf	extaddr,#wcode	;n11*00
	iorwf	*extaddr,#wcode	;n11*00

	iorwf	0x00,1		; 12 00
	iorwf	*0x00,1		; 12 00
	iorwf	extaddr,1	;n13*00
	iorwf	*extaddr,1	;n13*00
	iorwf	0x00,#1		; 12 00
	iorwf	*0x00,#1	; 12 00
	iorwf	extaddr,#1	;n13*00
	iorwf	*extaddr,#1	;n13*00
	iorwf	0x00,fcode	; 12 00
	iorwf	*0x00,fcode	; 12 00
	iorwf	extaddr,fcode	;n13*00
	iorwf	*extaddr,fcode	;n13*00
	iorwf	0x00,#fcode	; 12 00
	iorwf	*0x00,#fcode	; 12 00
	iorwf	extaddr,#fcode	;n13*00
	iorwf	*extaddr,#fcode	;n13*00

	andwf	0x00,w		; 14 00
	andwf	0xFF,w		;n15*FF
	andwf	extaddr,w	;n15*00

	andwf	0x00,f		; 16 00
	andwf	0xFF,f		;n17*FF
	andwf	extaddr,f	;n17*00

	andwf	*0x00,w		; 14 00
	andwf	*0xFF,w		;n15*FF
	andwf	*extaddr,w	;n15*00

	andwf	*0x00,f		; 16 00
	andwf	*0xFF,f		;n17*FF
	andwf	*extaddr,f	;n17*00

	andwf	0x00,0		; 14 00
	andwf	*0x00,0		; 14 00
	andwf	extaddr,0	;n15*00
	andwf	*extaddr,0	;n15*00
	andwf	0x00,#0		; 14 00
	andwf	*0x00,#0	; 14 00
	andwf	extaddr,#0	;n15*00
	andwf	*extaddr,#0	;n15*00
	andwf	0x00,wcode	; 14 00
	andwf	*0x00,wcode	; 14 00
	andwf	extaddr,wcode	;n15*00
	andwf	*extaddr,wcode	;n15*00
	andwf	0x00,#wcode	; 14 00
	andwf	*0x00,#wcode	; 14 00
	andwf	extaddr,#wcode	;n15*00
	andwf	*extaddr,#wcode	;n15*00

	andwf	0x00,1		; 16 00
	andwf	*0x00,1		; 16 00
	andwf	extaddr,1	;n17*00
	andwf	*extaddr,1	;n17*00
	andwf	0x00,#1		; 16 00
	andwf	*0x00,#1	; 16 00
	andwf	extaddr,#1	;n17*00
	andwf	*extaddr,#1	;n17*00
	andwf	0x00,fcode	; 16 00
	andwf	*0x00,fcode	; 16 00
	andwf	extaddr,fcode	;n17*00
	andwf	*extaddr,fcode	;n17*00
	andwf	0x00,#fcode	; 16 00
	andwf	*0x00,#fcode	; 16 00
	andwf	extaddr,#fcode	;n17*00
	andwf	*extaddr,#fcode	;n17*00

	xorwf	0x00,w		; 18 00
	xorwf	0xFF,w		;n19*FF
	xorwf	extaddr,w	;n19*00

	xorwf	0x00,f		; 1A 00
	xorwf	0xFF,f		;n1B*FF
	xorwf	extaddr,f	;n1B*00

	xorwf	*0x00,w		; 18 00
	xorwf	*0xFF,w		;n19*FF
	xorwf	*extaddr,w	;n19*00

	xorwf	*0x00,f		; 1A 00
	xorwf	*0xFF,f		;n1B*FF
	xorwf	*extaddr,f	;n1B*00

	xorwf	0x00,0		; 18 00
	xorwf	*0x00,0		; 18 00
	xorwf	extaddr,0	;n19*00
	xorwf	*extaddr,0	;n19*00
	xorwf	0x00,#0		; 18 00
	xorwf	*0x00,#0	; 18 00
	xorwf	extaddr,#0	;n19*00
	xorwf	*extaddr,#0	;n19*00
	xorwf	0x00,wcode	; 18 00
	xorwf	*0x00,wcode	; 18 00
	xorwf	extaddr,wcode	;n19*00
	xorwf	*extaddr,wcode	;n19*00
	xorwf	0x00,#wcode	; 18 00
	xorwf	*0x00,#wcode	; 18 00
	xorwf	extaddr,#wcode	;n19*00
	xorwf	*extaddr,#wcode	;n19*00

	xorwf	0x00,1		; 1A 00
	xorwf	*0x00,1		; 1A 00
	xorwf	extaddr,1	;n1B*00
	xorwf	*extaddr,1	;n1B*00
	xorwf	0x00,#1		; 1A 00
	xorwf	*0x00,#1	; 1A 00
	xorwf	extaddr,#1	;n1B*00
	xorwf	*extaddr,#1	;n1B*00
	xorwf	0x00,fcode	; 1A 00
	xorwf	*0x00,fcode	; 1A 00
	xorwf	extaddr,fcode	;n1B*00
	xorwf	*extaddr,fcode	;n1B*00
	xorwf	0x00,#fcode	; 1A 00
	xorwf	*0x00,#fcode	; 1A 00
	xorwf	extaddr,#fcode	;n1B*00
	xorwf	*extaddr,#fcode	;n1B*00

	addwf	0x00,w		; 24 00
	addwf	0xFF,w		;n25*FF
	addwf	extaddr,w	;n25*00

	addwf	0x00,f		; 26 00
	addwf	0xFF,f		;n27*FF
	addwf	extaddr,f	;n27*00

	addwf	*0x00,w		; 24 00
	addwf	*0xFF,w		;n25*FF
	addwf	*extaddr,w	;n25*00

	addwf	*0x00,f		; 26 00
	addwf	*0xFF,f		;n27*FF
 	addwf	*extaddr,f	;n27*00

	addwf	0x00,0		; 24 00
	addwf	*0x00,0		; 24 00
	addwf	extaddr,0	;n25*00
	addwf	*extaddr,0	;n25*00
	addwf	0x00,#0		; 24 00
	addwf	*0x00,#0	; 24 00
	addwf	extaddr,#0	;n25*00
	addwf	*extaddr,#0	;n25*00
	addwf	0x00,wcode	; 24 00
	addwf	*0x00,wcode	; 24 00
	addwf	extaddr,wcode	;n25*00
	addwf	*extaddr,wcode	;n25*00
	addwf	0x00,#wcode	; 24 00
	addwf	*0x00,#wcode	; 24 00
	addwf	extaddr,#wcode	;n25*00
	addwf	*extaddr,#wcode	;n25*00

	addwf	0x00,1		; 26 00
	addwf	*0x00,1		; 26 00
	addwf	extaddr,1	;n27*00
	addwf	*extaddr,1	;n27*00
	addwf	0x00,#1		; 26 00
	addwf	*0x00,#1	; 26 00
	addwf	extaddr,#1	;n27*00
	addwf	*extaddr,#1	;n27*00
	addwf	0x00,fcode	; 26 00
	addwf	*0x00,fcode	; 26 00
	addwf	extaddr,fcode	;n27*00
	addwf	*extaddr,fcode	;n27*00
	addwf	0x00,#fcode	; 26 00
	addwf	*0x00,#fcode	; 26 00
	addwf	extaddr,#fcode	;n27*00
	addwf	*extaddr,#fcode	;n27*00

	addwfc	0x00,w		; 20 00
	addwfc	0xFF,w		;n21*FF
	addwfc	extaddr,w	;n21*00

	addwfc	0x00,f		; 22 00
	addwfc	0xFF,f		;n23*FF
	addwfc	extaddr,f	;n23*00

	addwfc	*0x00,w		; 20 00
	addwfc	*0xFF,w		;n21*FF
	addwfc	*extaddr,w	;n21*00

	addwfc	*0x00,f		; 22 00
	addwfc	*0xFF,f		;n23*FF
 	addwfc	*extaddr,f	;n23*00

	addwfc	0x00,0		; 20 00
	addwfc	*0x00,0		; 20 00
	addwfc	extaddr,0	;n21*00
	addwfc	*extaddr,0	;n21*00
	addwfc	0x00,#0		; 20 00
	addwfc	*0x00,#0	; 20 00
	addwfc	extaddr,#0	;n21*00
	addwfc	*extaddr,#0	;n21*00
	addwfc	0x00,wcode	; 20 00
	addwfc	*0x00,wcode	; 20 00
	addwfc	extaddr,wcode	;n21*00
	addwfc	*extaddr,wcode	;n21*00
	addwfc	0x00,#wcode	; 20 00
	addwfc	*0x00,#wcode	; 20 00
	addwfc	extaddr,#wcode	;n21*00
	addwfc	*extaddr,#wcode	;n21*00

	addwfc	0x00,1		; 22 00
	addwfc	*0x00,1		; 22 00
	addwfc	extaddr,1	;n23*00
	addwfc	*extaddr,1	;n23*00
	addwfc	0x00,#1		; 22 00
	addwfc	*0x00,#1	; 22 00
	addwfc	extaddr,#1	;n23*00
	addwfc	*extaddr,#1	;n23*00
	addwfc	0x00,fcode	; 22 00
	addwfc	*0x00,fcode	; 22 00
	addwfc	extaddr,fcode	;n23*00
	addwfc	*extaddr,fcode	;n23*00
	addwfc	0x00,#fcode	; 22 00
	addwfc	*0x00,#fcode	; 22 00
	addwfc	extaddr,#fcode	;n23*00
	addwfc	*extaddr,#fcode	;n23*00

	comf	0x00,w		; 1C 00
	comf	0xFF,w		;n1D*FF
	comf	extaddr,w	;n1D*00

	comf	0x00,f		; 1E 00
	comf	0xFF,f		;n1F*FF
 	comf	extaddr,f	;n1F*00

	comf	*0x00,w		; 1C 00
	comf	*0xFF,w		;n1D*FF
	comf	*extaddr,w	;n1D*00

	comf	*0x00,f		; 1E 00
	comf	*0xFF,f		;n1F*FF
 	comf	*extaddr,f	;n1F*00

	comf	0x00,0		; 1C 00
	comf	*0x00,0		; 1C 00
	comf	extaddr,0	;n1D*00
	comf	*extaddr,0	;n1D*00
	comf	0x00,#0		; 1C 00
	comf	*0x00,#0	; 1C 00
	comf	extaddr,#0	;n1D*00
	comf	*extaddr,#0	;n1D*00
	comf	0x00,wcode	; 1C 00
	comf	*0x00,wcode	; 1C 00
	comf	extaddr,wcode	;n1D*00
	comf	*extaddr,wcode	;n1D*00
	comf	0x00,#wcode	; 1C 00
	comf	*0x00,#wcode	; 1C 00
	comf	extaddr,#wcode	;n1D*00
	comf	*extaddr,#wcode	;n1D*00

	comf	0x00,1		; 1E 00
	comf	*0x00,1		; 1E 00
	comf	extaddr,1	;n1F*00
	comf	*extaddr,1	;n1F*00
	comf	0x00,#1		; 1E 00
	comf	*0x00,#1	; 1E 00
	comf	extaddr,#1	;n1F*00
	comf	*extaddr,#1	;n1F*00
	comf	0x00,fcode	; 1E 00
	comf	*0x00,fcode	; 1E 00
	comf	extaddr,fcode	;n1F*00
	comf	*extaddr,fcode	;n1F*00
	comf	0x00,#fcode	; 1E 00
	comf	*0x00,#fcode	; 1E 00
	comf	extaddr,#fcode	;n1F*00
	comf	*extaddr,#fcode	;n1F*00

	incf	0x00,w		; 28 00
	incf	0xFF,w		;n29*FF
	incf	extaddr,w	;n29*00

	incf	0x00,f		; 2A 00
	incf	0xFF,f		;n2B*FF
	incf	extaddr,f	;n2B*00

	incf	*0x00,w		; 28 00
	incf	*0xFF,w		;n29*FF
	incf	*extaddr,w	;n29*00

	incf	*0x00,f		; 2A 00
	incf	*0xFF,f		;n2B*FF
	incf	*extaddr,f	;n2B*00

	incf	0x00,0		; 28 00
	incf	*0x00,0		; 28 00
	incf	extaddr,0	;n29*00
	incf	*extaddr,0	;n29*00
	incf	0x00,#0		; 28 00
	incf	*0x00,#0	; 28 00
	incf	extaddr,#0	;n29*00
	incf	*extaddr,#0	;n29*00
	incf	0x00,wcode	; 28 00
	incf	*0x00,wcode	; 28 00
	incf	extaddr,wcode	;n29*00
	incf	*extaddr,wcode	;n29*00
	incf	0x00,#wcode	; 28 00
	incf	*0x00,#wcode	; 28 00
	incf	extaddr,#wcode	;n29*00
	incf	*extaddr,#wcode	;n29*00

	incf	0x00,1		; 2A 00
	incf	*0x00,1		; 2A 00
	incf	extaddr,1	;n2B*00
	incf	*extaddr,1	;n2B*00
	incf	0x00,#1		; 2A 00
	incf	*0x00,#1	; 2A 00
	incf	extaddr,#1	;n2B*00
	incf	*extaddr,#1	;n2B*00
	incf	0x00,fcode	; 2A 00
	incf	*0x00,fcode	; 2A 00
	incf	extaddr,fcode	;n2B*00
	incf	*extaddr,fcode	;n2B*00
	incf	0x00,#fcode	; 2A 00
	incf	*0x00,#fcode	; 2A 00
	incf	extaddr,#fcode	;n2B*00
	incf	*extaddr,#fcode	;n2B*00

	decfsz	0x00,w		; 2C 00
	decfsz	0xFF,w		;n2D*FF
	decfsz	extaddr,w	;n2D*00

	decfsz	0x00,f		; 2E 00
	decfsz	0xFF,f		;n2F*FF
	decfsz	extaddr,f	;n2F*00

	decfsz	*0x00,w		; 2C 00
	decfsz	*0xFF,w		;n2D*FF
	decfsz	*extaddr,w	;n2D*00

	decfsz	*0x00,f		; 2E 00
	decfsz	*0xFF,f		;n2F*FF
 	decfsz	*extaddr,f	;n2F*00

	decfsz	0x00,0		; 2C 00
	decfsz	*0x00,0		; 2C 00
	decfsz	extaddr,0	;n2D*00
	decfsz	*extaddr,0	;n2D*00
	decfsz	0x00,#0		; 2C 00
	decfsz	*0x00,#0	; 2C 00
	decfsz	extaddr,#0	;n2D*00
	decfsz	*extaddr,#0	;n2D*00
	decfsz	0x00,wcode	; 2C 00
	decfsz	*0x00,wcode	; 2C 00
	decfsz	extaddr,wcode	;n2D*00
	decfsz	*extaddr,wcode	;n2D*00
	decfsz	0x00,#wcode	; 2C 00
	decfsz	*0x00,#wcode	; 2C 00
	decfsz	extaddr,#wcode	;n2D*00
	decfsz	*extaddr,#wcode	;n2D*00

	decfsz	0x00,1		; 2E 00
	decfsz	*0x00,1		; 2E 00
	decfsz	extaddr,1	;n2F*00
	decfsz	*extaddr,1	;n2F*00
	decfsz	0x00,#1		; 2E 00
	decfsz	*0x00,#1	; 2E 00
	decfsz	extaddr,#1	;n2F*00
	decfsz	*extaddr,#1	;n2F*00
	decfsz	0x00,fcode	; 2E 00
	decfsz	*0x00,fcode	; 2E 00
	decfsz	extaddr,fcode	;n2F*00
	decfsz	*extaddr,fcode	;n2F*00
	decfsz	0x00,#fcode	; 2E 00
	decfsz	*0x00,#fcode	; 2E 00
	decfsz	extaddr,#fcode	;n2F*00
	decfsz	*extaddr,#fcode	;n2F*00

	rrcf	0x00,w		; 30 00
	rrcf	0xFF,w		;n31*FF
	rrcf	extaddr,w	;n31*00

	rrcf	0x00,f		; 32 00
	rrcf	0xFF,f		;n33*FF
	rrcf	extaddr,f	;n33*00

	rrcf	*0x00,w		; 30 00
	rrcf	*0xFF,w		;n31*FF
	rrcf	*extaddr,w	;n31*00

	rrcf	*0x00,f		; 32 00
	rrcf	*0xFF,f		;n33*FF
 	rrcf	*extaddr,f	;n33*00

	rrcf	0x00,0		; 30 00
	rrcf	*0x00,0		; 30 00
	rrcf	extaddr,0	;n31*00
	rrcf	*extaddr,0	;n31*00
	rrcf	0x00,#0		; 30 00
	rrcf	*0x00,#0	; 30 00
	rrcf	extaddr,#0	;n31*00
	rrcf	*extaddr,#0	;n31*00
	rrcf	0x00,wcode	; 30 00
	rrcf	*0x00,wcode	; 30 00
	rrcf	extaddr,wcode	;n31*00
	rrcf	*extaddr,wcode	;n31*00
	rrcf	0x00,#wcode	; 30 00
	rrcf	*0x00,#wcode	; 30 00
	rrcf	extaddr,#wcode	;n31*00
	rrcf	*extaddr,#wcode	;n31*00

	rrcf	0x00,1		; 32 00
	rrcf	*0x00,1		; 32 00
	rrcf	extaddr,1	;n33*00
	rrcf	*extaddr,1	;n33*00
	rrcf	0x00,#1		; 32 00
	rrcf	*0x00,#1	; 32 00
	rrcf	extaddr,#1	;n33*00
	rrcf	*extaddr,#1	;n33*00
	rrcf	0x00,fcode	; 32 00
	rrcf	*0x00,fcode	; 32 00
	rrcf	extaddr,fcode	;n33*00
	rrcf	*extaddr,fcode	;n33*00
	rrcf	0x00,#fcode	; 32 00
	rrcf	*0x00,#fcode	; 32 00
	rrcf	extaddr,#fcode	;n33*00
	rrcf	*extaddr,#fcode	;n33*00

	rlcf	0x00,w		; 34 00
	rlcf	0xFF,w		;n35*FF
	rlcf	extaddr,w	;n35*00

	rlcf	0x00,f		; 36 00
	rlcf	0xFF,f		;n37*FF
	rlcf	extaddr,f	;n37*00

	rlcf	*0x00,w		; 34 00
	rlcf	*0xFF,w		;n35*FF
	rlcf	*extaddr,w	;n35*00

	rlcf	*0x00,f		; 36 00
	rlcf	*0xFF,f		;n37*FF
	rlcf	*extaddr,f	;n37*00

	rlcf	0x00,0		; 34 00
	rlcf	*0x00,0		; 34 00
	rlcf	extaddr,0	;n35*00
	rlcf	*extaddr,0	;n35*00
	rlcf	0x00,#0		; 34 00
	rlcf	*0x00,#0	; 34 00
	rlcf	extaddr,#0	;n35*00
	rlcf	*extaddr,#0	;n35*00
	rlcf	0x00,wcode	; 34 00
	rlcf	*0x00,wcode	; 34 00
	rlcf	extaddr,wcode	;n35*00
	rlcf	*extaddr,wcode	;n35*00
	rlcf	0x00,#wcode	; 34 00
	rlcf	*0x00,#wcode	; 34 00
	rlcf	extaddr,#wcode	;n35*00
	rlcf	*extaddr,#wcode	;n35*00

	rlcf	0x00,1		; 36 00
	rlcf	*0x00,1		; 36 00
	rlcf	extaddr,1	;n37*00
	rlcf	*extaddr,1	;n37*00
	rlcf	0x00,#1		; 36 00
	rlcf	*0x00,#1	; 36 00
	rlcf	extaddr,#1	;n37*00
	rlcf	*extaddr,#1	;n37*00
	rlcf	0x00,fcode	; 36 00
	rlcf	*0x00,fcode	; 36 00
	rlcf	extaddr,fcode	;n37*00
	rlcf	*extaddr,fcode	;n37*00
	rlcf	0x00,#fcode	; 36 00
	rlcf	*0x00,#fcode	; 36 00
	rlcf	extaddr,#fcode	;n37*00
	rlcf	*extaddr,#fcode	;n37*00

	swapf	0x00,w		; 38 00
	swapf	0xFF,w		;n39*FF
	swapf	extaddr,w	;n39*00

	swapf	0x00,f		; 3A 00
	swapf	0xFF,f		;n3B*FF
	swapf	extaddr,f	;n3B*00

	swapf	*0x00,w		; 38 00
	swapf	*0xFF,w		;n39*FF
	swapf	*extaddr,w	;n39*00


	swapf	*0x00,f		; 3A 00
	swapf	*0xFF,f		;n3B*FF
	swapf	*extaddr,f	;n3B*00

	swapf	0x00,0		; 38 00
	swapf	*0x00,0		; 38 00
	swapf	extaddr,0	;n39*00
	swapf	*extaddr,0	;n39*00
	swapf	0x00,#0		; 38 00
	swapf	*0x00,#0	; 38 00
	swapf	extaddr,#0	;n39*00
	swapf	*extaddr,#0	;n39*00
	swapf	0x00,wcode	; 38 00
	swapf	*0x00,wcode	; 38 00
	swapf	extaddr,wcode	;n39*00
	swapf	*extaddr,wcode	;n39*00
	swapf	0x00,#wcode	; 38 00
	swapf	*0x00,#wcode	; 38 00
	swapf	extaddr,#wcode	;n39*00
	swapf	*extaddr,#wcode	;n39*00

	swapf	0x00,1		; 3A 00
	swapf	*0x00,1		; 3A 00
	swapf	extaddr,1	;n3B*00
	swapf	*extaddr,1	;n3B*00
	swapf	0x00,#1		; 3A 00
	swapf	*0x00,#1	; 3A 00
	swapf	extaddr,#1	;n3B*00
	swapf	*extaddr,#1	;n3B*00
	swapf	0x00,fcode	; 3A 00
	swapf	*0x00,fcode	; 3A 00
	swapf	extaddr,fcode	;n3B*00
	swapf	*extaddr,fcode	;n3B*00
	swapf	0x00,#fcode	; 3A 00
	swapf	*0x00,#fcode	; 3A 00
	swapf	extaddr,#fcode	;n3B*00
	swapf	*extaddr,#fcode	;n3B*00

	incfsz	0x00,w		; 3C 00
	incfsz	0xFF,w		;n3D*FF
	incfsz	extaddr,w	;n3D*00

	incfsz	0x00,f		; 3E 00
	incfsz	0xFF,f		;n3F*FF
	incfsz	extaddr,f	;n3F*00

	incfsz	*0x00,w		; 3C 00
	incfsz	*0xFF,w		;n3D*FF
	incfsz	*extaddr,w	;n3D*00

	incfsz	*0x00,f		; 3E 00
	incfsz	*0xFF,f		;n3F*FF
	incfsz	*extaddr,f	;n3F*00

	incfsz	0x00,0		; 3C 00
	incfsz	*0x00,0		; 3C 00
	incfsz	extaddr,0	;n3D*00
	incfsz	*extaddr,0	;n3D*00
	incfsz	0x00,#0		; 3C 00
	incfsz	*0x00,#0	; 3C 00
	incfsz	extaddr,#0	;n3D*00
	incfsz	*extaddr,#0	;n3D*00
	incfsz	0x00,wcode	; 3C 00
	incfsz	*0x00,wcode	; 3C 00
	incfsz	extaddr,wcode	;n3D*00
	incfsz	*extaddr,wcode	;n3D*00
	incfsz	0x00,#wcode	; 3C 00
	incfsz	*0x00,#wcode	; 3C 00
	incfsz	extaddr,#wcode	;n3D*00
	incfsz	*extaddr,#wcode	;n3D*00

	incfsz	0x00,1		; 3E 00
	incfsz	*0x00,1		; 3E 00
	incfsz	extaddr,1	;n3F*00
	incfsz	*extaddr,1	;n3F*00
	incfsz	0x00,#1		; 3E 00
	incfsz	*0x00,#1	; 3E 00
	incfsz	extaddr,#1	;n3F*00
	incfsz	*extaddr,#1	;n3F*00
	incfsz	0x00,fcode	; 3E 00
	incfsz	*0x00,fcode	; 3E 00
	incfsz	extaddr,fcode	;n3F*00
	incfsz	*extaddr,fcode	;n3F*00
	incfsz	0x00,#fcode	; 3E 00
	incfsz	*0x00,#fcode	; 3E 00
	incfsz	extaddr,#fcode	;n3F*00
	incfsz	*extaddr,#fcode	;n3F*00

	rrncf	0x00,w		; 40 00
	rrncf	0xFF,w		;n41*FF
	rrncf	extaddr,w	;n41*00

	rrncf	0x00,f		; 42 00
	rrncf	0xFF,f		;n43*FF
	rrncf	extaddr,f	;n43*00

	rrncf	*0x00,w		; 40 00
	rrncf	*0xFF,w		;n41*FF
	rrncf	*extaddr,w	;n41*00

	rrncf	*0x00,f		; 42 00
	rrncf	*0xFF,f		;n43*FF
 	rrncf	*extaddr,f	;n43*00

	rrncf	0x00,0		; 40 00
	rrncf	*0x00,0		; 40 00
	rrncf	extaddr,0	;n41*00
	rrncf	*extaddr,0	;n41*00
	rrncf	0x00,#0		; 40 00
	rrncf	*0x00,#0	; 40 00
	rrncf	extaddr,#0	;n41*00
	rrncf	*extaddr,#0	;n41*00
	rrncf	0x00,wcode	; 40 00
	rrncf	*0x00,wcode	; 40 00
	rrncf	extaddr,wcode	;n41*00
	rrncf	*extaddr,wcode	;n41*00
	rrncf	0x00,#wcode	; 40 00
	rrncf	*0x00,#wcode	; 40 00
	rrncf	extaddr,#wcode	;n41*00
	rrncf	*extaddr,#wcode	;n41*00

	rrncf	0x00,1		; 42 00
	rrncf	*0x00,1		; 42 00
	rrncf	extaddr,1	;n43*00
	rrncf	*extaddr,1	;n43*00
	rrncf	0x00,#1		; 42 00
	rrncf	*0x00,#1	; 42 00
	rrncf	extaddr,#1	;n43*00
	rrncf	*extaddr,#1	;n43*00
	rrncf	0x00,fcode	; 42 00
	rrncf	*0x00,fcode	; 42 00
	rrncf	extaddr,fcode	;n43*00
	rrncf	*extaddr,fcode	;n43*00
	rrncf	0x00,#fcode	; 42 00
	rrncf	*0x00,#fcode	; 42 00
	rrncf	extaddr,#fcode	;n43*00
	rrncf	*extaddr,#fcode	;n43*00

	rlncf	0x00,w		; 44 00
	rlncf	0xFF,w		;n45*FF
	rlncf	extaddr,w	;n45*00

	rlncf	0x00,f		; 46 00
	rlncf	0xFF,f		;n47*FF
	rlncf	extaddr,f	;n47*00

	rlncf	*0x00,w		; 44 00
	rlncf	*0xFF,w		;n45*FF
	rlncf	*extaddr,w	;n45*00

	rlncf	*0x00,f		; 46 00
	rlncf	*0xFF,f		;n47*FF
	rlncf	*extaddr,f	;n47*00

	rlncf	0x00,0		; 44 00
	rlncf	*0x00,0		; 44 00
	rlncf	extaddr,0	;n45*00
	rlncf	*extaddr,0	;n45*00
	rlncf	0x00,#0		; 44 00
	rlncf	*0x00,#0	; 44 00
	rlncf	extaddr,#0	;n45*00
	rlncf	*extaddr,#0	;n45*00
	rlncf	0x00,wcode	; 44 00
	rlncf	*0x00,wcode	; 44 00
	rlncf	extaddr,wcode	;n45*00
	rlncf	*extaddr,wcode	;n45*00
	rlncf	0x00,#wcode	; 44 00
	rlncf	*0x00,#wcode	; 44 00
	rlncf	extaddr,#wcode	;n45*00
	rlncf	*extaddr,#wcode	;n45*00

	rlncf	0x00,1		; 46 00
	rlncf	*0x00,1		; 46 00
	rlncf	extaddr,1	;n47*00
	rlncf	*extaddr,1	;n47*00
	rlncf	0x00,#1		; 46 00
	rlncf	*0x00,#1	; 46 00
	rlncf	extaddr,#1	;n47*00
	rlncf	*extaddr,#1	;n47*00
	rlncf	0x00,fcode	; 46 00
	rlncf	*0x00,fcode	; 46 00
	rlncf	extaddr,fcode	;n47*00
	rlncf	*extaddr,fcode	;n47*00
	rlncf	0x00,#fcode	; 46 00
	rlncf	*0x00,#fcode	; 46 00
	rlncf	extaddr,#fcode	;n47*00
	rlncf	*extaddr,#fcode	;n47*00

	infsnz	0x00,w		; 48 00
	infsnz	0xFF,w		;n49*FF
	infsnz	extaddr,w	;n49*00

	infsnz	0x00,f		; 4A 00
	infsnz	0xFF,f		;n4B*FF
	infsnz	extaddr,f	;n4B*00

	infsnz	*0x00,w		; 48 00
	infsnz	*0xFF,w		;n49*FF
	infsnz	*extaddr,w	;n49*00

	infsnz	*0x00,f		; 4A 00
	infsnz	*0xFF,f		;n4B*FF
	infsnz	*extaddr,f	;n4B*00

	infsnz	0x00,0		; 48 00
	infsnz	*0x00,0		; 48 00
	infsnz	extaddr,0	;n49*00
	infsnz	*extaddr,0	;n49*00
	infsnz	0x00,#0		; 48 00
	infsnz	*0x00,#0	; 48 00
	infsnz	extaddr,#0	;n49*00
	infsnz	*extaddr,#0	;n49*00
	infsnz	0x00,wcode	; 48 00
	infsnz	*0x00,wcode	; 48 00
	infsnz	extaddr,wcode	;n49*00
	infsnz	*extaddr,wcode	;n49*00
	infsnz	0x00,#wcode	; 48 00
	infsnz	*0x00,#wcode	; 48 00
	infsnz	extaddr,#wcode	;n49*00
	infsnz	*extaddr,#wcode	;n49*00

	infsnz	0x00,1		; 4A 00
	infsnz	*0x00,1		; 4A 00
	infsnz	extaddr,1	;n4B*00
	infsnz	*extaddr,1	;n4B*00
	infsnz	0x00,#1		; 4A 00
	infsnz	*0x00,#1	; 4A 00
	infsnz	extaddr,#1	;n4B*00
	infsnz	*extaddr,#1	;n4B*00
	infsnz	0x00,fcode	; 4A 00
	infsnz	*0x00,fcode	; 4A 00
	infsnz	extaddr,fcode	;n4B*00
	infsnz	*extaddr,fcode	;n4B*00
	infsnz	0x00,#fcode	; 4A 00
	infsnz	*0x00,#fcode	; 4A 00
	infsnz	extaddr,#fcode	;n4B*00
	infsnz	*extaddr,#fcode	;n4B*00

	dcfsnz	0x00,w		; 4C 00
	dcfsnz	0xFF,w		;n4D*FF
	dcfsnz	extaddr,w	;n4D*00

	dcfsnz	0x00,f		; 4E 00
	dcfsnz	0xFF,f		;n4F*FF
	dcfsnz	extaddr,f	;n4F*00

	dcfsnz	*0x00,w		; 4C 00
	dcfsnz	*0xFF,w		;n4D*FF
	dcfsnz	*extaddr,w	;n4D*00

	dcfsnz	*0x00,f		; 4E 00
	dcfsnz	*0xFF,f		;n4F*FF
 	dcfsnz	*extaddr,f	;n4F*00

	dcfsnz	0x00,0		; 4C 00
	dcfsnz	*0x00,0		; 4C 00
	dcfsnz	extaddr,0	;n4D*00
	dcfsnz	*extaddr,0	;n4D*00
	dcfsnz	0x00,#0		; 4C 00
	dcfsnz	*0x00,#0	; 4C 00
	dcfsnz	extaddr,#0	;n4D*00
	dcfsnz	*extaddr,#0	;n4D*00
	dcfsnz	0x00,wcode	; 4C 00
	dcfsnz	*0x00,wcode	; 4C 00
	dcfsnz	extaddr,wcode	;n4D*00
	dcfsnz	*extaddr,wcode	;n4D*00
	dcfsnz	0x00,#wcode	; 4C 00
	dcfsnz	*0x00,#wcode	; 4C 00
	dcfsnz	extaddr,#wcode	;n4D*00
	dcfsnz	*extaddr,#wcode	;n4D*00

	dcfsnz	0x00,1		; 4E 00
	dcfsnz	*0x00,1		; 4E 00
	dcfsnz	extaddr,1	;n4F*00
	dcfsnz	*extaddr,1	;n4F*00
	dcfsnz	0x00,#1		; 4E 00
	dcfsnz	*0x00,#1	; 4E 00
	dcfsnz	extaddr,#1	;n4F*00
	dcfsnz	*extaddr,#1	;n4F*00
	dcfsnz	0x00,fcode	; 4E 00
	dcfsnz	*0x00,fcode	; 4E 00
	dcfsnz	extaddr,fcode	;n4F*00
	dcfsnz	*extaddr,fcode	;n4F*00
	dcfsnz	0x00,#fcode	; 4E 00
	dcfsnz	*0x00,#fcode	; 4E 00
	dcfsnz	extaddr,#fcode	;n4F*00
	dcfsnz	*extaddr,#fcode	;n4F*00

	clrf	0x00		; 6A 00
	clrf	0xFF		;n6B*FF
	clrf	extaddr		;n6B*00

	clrf	*0x00		; 6A 00
	clrf	*0xFF		;n6B*FF
	clrf	*extaddr	;n6B*00

	clrf	0x00,0		; 6A 00
	clrf	*0x00,0		; 6A 00
	clrf	extaddr,0	;s6Ar00
	clrf	*extaddr,0	;s6Ar00

	setf	0x00		; 68 00
	setf	0xFF		;n69*FF
	setf	extaddr		;n69*00

	setf	*0x00		; 68 00
	setf	*0xFF		;n69*FF
	setf	*extaddr	;n69*00

	setf	0x00		; 68 00
	setf	*0x00		; 68 00
	setf	extaddr		;n69*00
	setf	*extaddr	;n69*00

	negf	0x00		; 6C 00
	negf	0xFF		;n6D*FF
	negf	extaddr		;n6D*00

	negf	*0x00		; 6C 00
	negf	*0xFF		;n6D*FF
	negf	*extaddr	;n6D*00

	negf	0x00		; 6C 00
	negf	*0x00		; 6C 00
	negf	extaddr		;n6D*00
	negf	*extaddr	;n6D*00

	cpfslt	0x00		; 60 00
	cpfslt	0xFF		;n61*FF
	cpfslt	extaddr		;n61*00

	cpfslt	*0x00		; 60 00
	cpfslt	*0xFF		;n61*FF
	cpfslt	*extaddr	;n61*00

	cpfseq	0x00		; 62 00
	cpfseq	0xFF		;n63*FF
	cpfseq	extaddr		;n63*00

	cpfseq	*0x00		; 62 00
	cpfseq	*0xFF		;n63*FF
	cpfseq	*extaddr	;n63*00

	cpfsgt	0x00		; 64 00
	cpfsgt	0xFF		;n65*FF
	cpfsgt	extaddr		;n65*00

	cpfsgt	*0x00		; 64 00
	cpfsgt	*0xFF		;n65*FF
	cpfsgt	*extaddr	;n65*00

	tstfsz	0x00		; 66 00
	tstfsz	0xFF		;n67*FF
	tstfsz	extaddr		;n67*00

	tstfsz	*0x00		; 66 00
	tstfsz	*0xFF		;n67*FF
	tstfsz	*extaddr	;n67*00


	btg	0x00,0		; 70 00
	btg	0xFF,0		;n71*FF
	btg	extaddr,0	;n71*00

	btg	0x00,7		; 7E 00
	btg	0xFF,7		;n7F*FF
	btg	extaddr,7	;n7F*00

	btg	*0x00,0		; 70 00
	btg	*0xFF,0		;n71*FF
	btg	*extaddr,0	;n71*00

	btg	*0x00,7		; 7E 00
	btg	*0xFF,7		;n7F*FF
	btg	*extaddr,7	;n7F*00

	btg	0x00,num0	; 70 00
	btg	*0x00,num0	; 70 00
	btg	extaddr,num0	;n71*00
	btg	*extaddr,num0	;n71*00
	btg	0x00,#num0	; 70 00
	btg	*0x00,#num0	; 70 00
	btg	extaddr,#num0	;n71*00
	btg	*extaddr,#num0	;n71*00
	btg	0x00,num7	; 7E 00
	btg	*0x00,num7	; 7E 00
	btg	extaddr,num7	;n7F*00
	btg	*extaddr,num7	;n7F*00
	btg	0x00,#num7	; 7E 00
	btg	*0x00,#num7	; 7E 00
	btg	extaddr,#num7	;n7F*00
	btg	*extaddr,#num7	;n7F*00

	movff	0x00,0x00	; C0 00 F0 00
	movff	0x0FFF,0x00	; CF FF F0 00
	movff	0x00,0x0FFF	; C0 00 FF FF
	movff	0x0FFF,0x0FFF	; CF FF FF FF

	movff	0x00,*0x00	; C0 00 F0 00
	movff	0x0FFF,*0x00	; CF FF F0 00
	movff	0x00,*0x0FFF	; C0 00 FF FF
	movff	0x0FFF,*0x0FFF	; CF FF FF FF

	movff	*0x00,0x00	; C0 00 F0 00
	movff	*0x0FFF,*0x00	; CF FF F0 00
	movff	*0x00,0x0FFF	; C0 00 FF FF
	movff	*0x0FFF,*0x0FFF	; CF FF FF FF

	movff	*0x00,*0x00	; C0 00 F0 00
	movff	*0x0FFF,*0x00	; CF FF F0 00
	movff	*0x00,*0x0FFF	; C0 00 FF FF
	movff	*0x0FFF,*0x0FFF	; CF FF FF FF

	movff	0x00,extaddr	; C0 00vF0u00
	movff	0x0FFF,*extaddr	; CF FFvF0u00
	movff	extaddr,0x00	;vC0u00 F0 00
	movff	*extaddr,0x0FFF	;vC0u00 FF FF

	movff  extaddr,extaddr	;vC0u00vF0u00
	movff *extaddr,*extaddr	;vC0u00vF0u00

	bsf	0x00,0		; 80 00
	bsf	0xFF,0		;n81*FF
	bsf	extaddr,0	;n81*00

	bsf	0x00,7		; 8E 00
	bsf	0xFF,7		;n8F*FF
	bsf	extaddr,7	;n8F*00

	bsf	*0x00,0		; 80 00
	bsf	*0xFF,0		;n81*FF
	bsf	*extaddr,0	;n81*00

	bsf	*0x00,7		; 8E 00
	bsf	*0xFF,7		;n8F*FF
 	bsf	*extaddr,7	;n8F*00

	bsf	0x00,num0	; 80 00
	bsf	*0x00,num0	; 80 00
	bsf	extaddr,num0	;n81*00
	bsf	*extaddr,num0	;n81*00
	bsf	0x00,#num0	; 80 00
	bsf	*0x00,#num0	; 80 00
	bsf	extaddr,#num0	;n81*00
	bsf	*extaddr,#num0	;n81*00
	bsf	0x00,num7	; 8E 00
	bsf	*0x00,num7	; 8E 00
	bsf	extaddr,num7	;n8F*00
	bsf	*extaddr,num7	;n8F*00
	bsf	0x00,#num7	; 8E 00
	bsf	*0x00,#num7	; 8E 00
	bsf	extaddr,#num7	;n8F*00
	bsf	*extaddr,#num7	;n8F*00

	bcf	0x00,0		; 90 00
	bcf	0xFF,0		;n91*FF
	bcf	extaddr,0	;n91*00

	bcf	0x00,7		; 9E 00
	bcf	0xFF,7		;n9F*FF
	bcf	extaddr,7	;n9F*00

	bcf	*0x00,0		; 90 00
	bcf	*0xFF,0		;n91*FF
	bcf	*extaddr,0	;n91*00

	bcf	*0x00,7		; 9E 00
	bcf	*0xFF,7		;n9F*FF
	bcf	*extaddr,7	;n9F*00

	bcf	0x00,num0	; 90 00
	bcf	*0x00,num0	; 90 00
	bcf	extaddr,num0	;n91*00
	bcf	*extaddr,num0	;n91*00
	bcf	0x00,#num0	; 90 00
	bcf	*0x00,#num0	; 90 00
	bcf	extaddr,#num0	;n91*00
	bcf	*extaddr,#num0	;n91*00
	bcf	0x00,num7	; 9E 00
	bcf	*0x00,num7	; 9E 00
	bcf	extaddr,num7	;n9F*00
	bcf	*extaddr,num7	;n9F*00
	bcf	0x00,#num7	; 9E 00
	bcf	*0x00,#num7	; 9E 00
	bcf	extaddr,#num7	;n9F*00
	bcf	*extaddr,#num7	;n9F*00

	btfss	0x00,0		; A0 00
	btfss	0xFF,0		;nA1*FF
	btfss	extaddr,0	;nA1*00

	btfss	0x00,7		; AE 00
	btfss	0xFF,7		;nAF*FF
	btfss	extaddr,7	;nAF*00

	btfss	*0x00,0		; A0 00
	btfss	*0xFF,0		;nA1*FF
	btfss	*extaddr,0	;nA1*00

	btfss	*0x00,7		; AE 00
	btfss	*0xFF,7		;nAF*FF
	btfss	*extaddr,7	;nAF*00

	btfss	0x00,num0	; A0 00
	btfss	*0x00,num0	; A0 00
	btfss	extaddr,num0	;nA1*00
	btfss	*extaddr,num0	;nA1*00
	btfss	0x00,#num0	; A0 00
	btfss	*0x00,#num0	; A0 00
	btfss	extaddr,#num0	;nA1*00
	btfss	*extaddr,#num0	;nA1*00
	btfss	0x00,num7	; AE 00
	btfss	*0x00,num7	; AE 00
	btfss	extaddr,num7	;nAF*00
	btfss	*extaddr,num7	;nAF*00
	btfss	0x00,#num7	; AE 00
	btfss	*0x00,#num7	; AE 00
	btfss	extaddr,#num7	;nAF*00
	btfss	*extaddr,#num7	;nAF*00

	btfsc	0x00,0		; B0 00
	btfsc	0xFF,0		;nB1*FF
	btfsc	extaddr,0	;nB1*00

	btfsc	0x00,7		; BE 00
	btfsc	0xFF,7		;nBF*FF
	btfsc	extaddr,7	;nBF*00

	btfsc	*0x00,0		; B0 00
	btfsc	*0xFF,0		;nB1*FF
	btfsc	*extaddr,0	;nB1*00

	btfsc	*0x00,7		; BE 00
	btfsc	*0xFF,7		;nBF*FF
	btfsc	*extaddr,7	;nBF*00

	btfsc	0x00,num0	; B0 00
	btfsc	*0x00,num0	; B0 00
	btfsc	extaddr,num0	;nB1*00
	btfsc	*extaddr,num0	;nB1*00
	btfsc	0x00,#num0	; B0 00
	btfsc	*0x00,#num0	; B0 00
	btfsc	extaddr,#num0	;nB1*00
	btfsc	*extaddr,#num0	;nB1*00
	btfsc	0x00,num7	; BE 00
	btfsc	*0x00,num7	; BE 00
	btfsc	extaddr,num7	;nBF*00
	btfsc	*extaddr,num7	;nBF*00
	btfsc	0x00,#num7	; BE 00
	btfsc	*0x00,#num7	; BE 00
	btfsc	extaddr,#num7	;nBF*00
	btfsc	*extaddr,#num7	;nBF*00

	movlw	0x00		; 0E 00
	movlw	0xFF		; 0E FF
	movlw	extaddr		;s0Er00

	movlw	#0x00		; 0E 00
	movlw	#0xFF		; 0E FF
	movlw	#extaddr	;s0Er00

	addlw	0x00		; 0F 00
	addlw	0xFF		; 0F FF
	addlw	extaddr		;s0Fr00

	addlw	#0x00		; 0F 00
	addlw	#0xFF		; 0F FF
	addlw	#extaddr	;s0Fr00

	sublw	0x00		; 08 00
	sublw	0xFF		; 08 FF
	sublw	extaddr		;s08r00

	sublw	#0x00		; 08 00
	sublw	#0xFF		; 08 FF
	sublw	#extaddr	;s08r00

	iorlw	0x00		; 09 00
	iorlw	0xFF		; 09 FF
	iorlw	extaddr		;s09r00

	iorlw	#0x00		; 09 00
	iorlw	#0xFF		; 09 FF
	iorlw	#extaddr	;s09r00

	xorlw	0x00		; 0A 00
	xorlw	0xFF		; 0A FF
	xorlw	extaddr		;s0Ar00

	xorlw	#0x00		; 0A 00
	xorlw	#0xFF		; 0A FF
	xorlw	#extaddr	;s0Ar00

	andlw	0x00		; 0B 00
	andlw	0xFF		; 0B FF
	andlw	extaddr		;s0Br00

	andlw	#0x00		; 0B 00
	andlw	#0xFF		; 0B FF
	andlw	#extaddr	;s0Br00

	retlw	0x00		; 0C 00
	retlw	0xFF		; 0C FF
	retlw	extaddr		;s0Cr00

	retlw	#0x00		; 0C 00
	retlw	#0xFF		; 0C FF
	retlw	#extaddr	;s0Cr00

	movlb	0x00		; 01 00
	movlb	0x0F		; 01 0F
	movlb	extaddr		;s01r00

	movlb	#0x00		; 01 00
	movlb	#0x0F		; 01 0F
	movlb	#extaddr	;s01r00

	mullw	0x00		; 0D 00
	mullw	0xFF		; 0D FF
	mullw	extaddr		;s0Dr00

	mullw	#0x00		; 0D 00
	mullw	#0xFF		; 0D FF
	mullw	#extaddr	;s0Dr00

	goto	0x000000	; EF 00 F0 00
	goto	0x00000F	; EF 0F F0 00
	goto	0x0000FF	; EF FF F0 00
	goto	0x000FFF	; EF FF F0 0F
	goto	0x00FFFF	; EF FF F0 FF
	goto	0x0FFFFF	; EF FF FF FF

	goto	addr_00		;SEFR00sF0r00
	goto	addr_0FFFFF	;SEFRFFsFFrFF
	goto	extaddr		;SEFR00sF0r00

	call	0x000000	; EC 00 F0 00
	call	0x00000F	; EC 0F F0 00
	call	0x0000FF	; EC FF F0 00
	call	0x000FFF	; EC FF F0 0F
	call	0x00FFFF	; EC FF F0 FF
	call	0x0FFFFF	; EC FF FF FF

	call	addr_00		;SECR00sF0r00
	call	addr_0FFFFF	;SECRFFsFFrFF
	call	extaddr		;SECR00sF0r00


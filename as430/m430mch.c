/* m430mch.c */

/*
 * (C) Copyright 2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include <string.h>
#include "asxxxx.h"
#include "m430.h"

/*
 * Process a machine op.
 */
VOID
machine(mp)
struct mne *mp;
{
	register int op;
	int rf;
	struct expr e1, e2;
	int t1, t2, v1, v2;

	clrexpr(&e1);
	clrexpr(&e2);

	/*
	 * Instructions on a Word Boundary
	 */
	if (dot.s_addr & 0x0001) {
		outall();
		err('b');
		dot.s_addr += 1;
	}

	op = mp->m_valu;
	switch (rf = mp->m_type) {

	case S_DOP:
	case S_BRA:
		t1 = addr(&e1);
		v1 = (aindx & 0x000F) << 8;
		t2 = 0;
		v2 = 0;
		switch (rf) {
		case S_DOP:
		    /*
		     * Special Constant Processing
		     */
		    if ((t1 == S_IMM) && is_abs(&e1)) {
			switch (e1.e_addr) {
			case (a_uint)  4:	t1 = S_REG;	op += 0x0020;	v1 = 2 << 8;	break;
			case (a_uint)  8:	t1 = S_REG;	op += 0x0030;	v1 = 2 << 8;	break;
			case (a_uint)  0:	t1 = S_REG;	op += 0x0000;	v1 = 3 << 8;	break;
			case (a_uint)  1:	t1 = S_REG;	op += 0x0010;	v1 = 3 << 8;	break;
			case (a_uint)  2:	t1 = S_REG;	op += 0x0020;	v1 = 3 << 8;	break;
			case (a_uint) ~0:	t1 = S_REG;	op += 0x0030;	v1 = 3 << 8;	break;
			default:								break;
			}
		    }
		    comma();			t2 = addr(&e2);		v2 = (aindx & 0x000F);	break;
		case S_BRA:			t2 = S_REG;		v2 = 0;			break;
		default:									break;
		}

		/*
		 * Opcode Processing
		 */
		/* DOPSRC */
		switch(t1) {
		case S_REG:	op += 0x0000 + v1;	break;	/*	Rn	As=0		*/
		case S_RIDX:	op += 0x0010 + v1;	break;	/*	X(Rn)	As=1		*/
		case S_SYM:	op += 0x0010;		break;	/*	addr	As=1, Sreg=PC	*/
		case S_ABS:	op += 0x0210;		break;	/*	&Addr	As=1, Sreg=SR	*/
		case S_RIN:	op += 0x0020 + v1;	break;	/*	@Rn	As=2		*/
		case S_RIN2:	op += 0x0030 + v1;	break;	/*	@Rn+	As=3		*/
		case S_IMM:	op += 0x0030;		break;	/*	#N	As=3, Sreg=PC	*/
		default:	aerr();			break;
		}

		/* DOPDST */
		switch(t2) {
		case S_REG:	op += 0x0000 + v2;	break;	/*	Rn	Ad=0		*/
		case S_RIDX:	op += 0x0080 + v2;	break;	/*	X(Rn)	Ad=1		*/
		case S_SYM:	op += 0x0080;		break;	/*	addr	Ad=1, Sreg=PC	*/
		case S_IMM:					/*	#N	==>> &Addr	*/
		case S_ABS:	op += 0x0082;		break;	/*	&Addr	Ad=1, Sreg=SR	*/
		case S_RIN:	op += 0x0080 + v2;	break;	/*	@Rn	Ad=1		*/
		case S_RIN2:	op += 0x0080 + v2;	break;	/*	@Rn+	Ad=1		*/
		default:	aerr();			break;
		}

		outaw(op);
		/*
		 * Source Processing
		 */
		switch(t1) {
		case S_REG:				break;	/*	Rn	As=0		*/
		case S_RIDX:	outrw(&e1, 0);		break;	/*	X(Rn)	As=1		*/
		case S_SYM:	if (mchpcr(&e1)) {
					e1.e_addr -= dot.s_addr;
					outaw(e1.e_addr);
				} else {
					outrw(&e1, R_PCR0);
				}
							break;	/*	addr	As=1, Sreg=PC	*/
		case S_ABS:	outrw(&e1, 0);		break;	/*	&Addr	As=1, Sreg=SR	*/
		case S_RIN:				break;	/*	@Rn	As=2		*/
		case S_RIN2:				break;	/*	@Rn+	As=3		*/
		case S_IMM:	outrw(&e1, 0);		break;	/*	#N	As=3, Sreg=PC	*/
		default:	aerr();			break;
		}
		/*
		 * Destination Processing
		 */
		switch(t2) {
		case S_REG:				break;	/*	Rn	Ad=0		*/
		case S_RIDX:	outrw(&e2, 0);		break;	/*	X(Rn)	Ad=1		*/
		case S_SYM:	if (mchpcr(&e2)) {
					e2.e_addr -= dot.s_addr;
					outaw(e2.e_addr);
				} else {
					outrw(&e2, R_PCR0);
				}
							break;	/*	addr	Ad=1, Sreg=PC	*/
		case S_IMM:	aerr();				/*	#N	==>> &Addr	*/
		case S_ABS:	outrw(&e2, 0);		break;	/*	&Addr	Ad=1, Sreg=SR	*/
		case S_RIN:	outaw(0);		break;	/*	@Rn	Ad=1		*/
		case S_RIN2:				        /*	@Rn+	Ad=1		*/
				if (rf == S_RLX) {
					if (op & 0x0040) {
						outaw(~0);	/*	RLX.b	@Rn+,-1(Rn)	*/
					} else {
						outaw(~1);	/*	RLX.w	@Rn+,-2(Rn)	*/
					}
				} else {
					outaw(0);
					if ((op & 0x0040) && (v2 != 0)) {
						outaw(0x5310 + v2);	/*	add	#1,Rn		*/
					} else {
						outaw(0x5320 + v2);	/*	add	#2,Rn		*/
					}
				}
							break;
		default:	aerr();			break;
		}
		break;

	case S_SOP:
		t1 = addr(&e1);
		v1 = aindx & 0x000F;

		/*
		 * Opcode Processing
		 */
		/* SRCDST */
		switch(t1) {
		case S_REG:	op += 0x0000 + v1;	break;	/*	Rn	As=0		*/
		case S_RIDX:	op += 0x0010 + v1;	break;	/*	X(Rn)	As=1		*/
		case S_SYM:	op += 0x0010;		break;	/*	addr	As=1, Sreg=PC	*/
		case S_IMM:					/*	#N	==>> &Addr	*/
		case S_ABS:	op += 0x0210;		break;	/*	&Addr	As=1, Sreg=SR	*/
		case S_RIN:	op += 0x0020 + v1;	break;	/*	@Rn	As=2		*/
		case S_RIN2:	op += 0x0030 + v1;	break;	/*	@Rn+	As=3		*/
		default:	aerr();			break;
		}

		outaw(op);
		/*
		 * Source/Destination Processing
		 */
		switch(t1) {
		case S_REG:				break;	/*	Rn	As=0		*/
		case S_RIDX:	outrw(&e1, 0);		break;	/*	X(Rn)	As=1		*/
		case S_SYM:	if (mchpcr(&e1)) {
					e1.e_addr -= dot.s_addr;
					outaw(e1.e_addr);
				} else {
					outrw(&e1, R_PCR0);
				}
							break;	/*	addr	As=1, Sreg=PC	*/
		case S_IMM:	aerr();				/*	#N	==>> &Addr	*/
		case S_ABS:	outrw(&e1, 0);		break;	/*	&Addr	As=1, Sreg=SR	*/
		case S_RIN:				break;	/*	@Rn	As=2		*/
		case S_RIN2:				break;	/*	@Rn+	As=3		*/
		default:	aerr();			break;
		}
		break;

	case S_PSH:
		t1 = addr(&e1);
		v1 = aindx & 0x000F;

		/*
		 * Special Constant Processing
		 */
		if ((t1 == S_IMM) && is_abs(&e1)) {
			switch (e1.e_addr) {
			case (a_uint)  4:	t1 = S_REG;	op += 0x0020;	v1 = 2;		break;
			case (a_uint)  8:	t1 = S_REG;	op += 0x0030;	v1 = 2;		break;
			case (a_uint)  0:	t1 = S_REG;	op += 0x0000;	v1 = 3;		break;
			case (a_uint)  1:	t1 = S_REG;	op += 0x0010;	v1 = 3;		break;
			case (a_uint)  2:	t1 = S_REG;	op += 0x0020;	v1 = 3;		break;
			case (a_uint) ~0:	t1 = S_REG;	op += 0x0030;	v1 = 3;		break;
			default:								break;
			}
		}

		/*
		 * Opcode Processing
		 */
		/* SRC */
		switch(t1) {
		case S_REG:	op += 0x0000 + v1;	break;	/*	Rn	As=0		*/
		case S_RIDX:	op += 0x0010 + v1;	break;	/*	X(Rn)	As=1		*/
		case S_SYM:	op += 0x0010;		break;	/*	addr	As=1, Sreg=PC	*/
		case S_ABS:	op += 0x0210;		break;	/*	&Addr	As=1, Sreg=SR	*/
		case S_RIN:	op += 0x0020 + v1;	break;	/*	@Rn	As=2		*/
		case S_RIN2:	op += 0x0030 + v1;	break;	/*	@Rn+	As=3		*/
		case S_IMM:	op += 0x0030;		break;	/*	#N	As=3, Sreg=PC	*/
		default:	aerr();			break;
		}

		outaw(op);
		/*
		 * Source Processing
		 */
		switch(t1) {
		case S_REG:				break;	/*	Rn	As=0		*/
		case S_RIDX:	outrw(&e1, 0);		break;	/*	X(Rn)	As=1		*/
		case S_SYM:	if (mchpcr(&e1)) {
					e1.e_addr -= dot.s_addr;
					outaw(e1.e_addr);
				} else {
					outrw(&e1, R_PCR0);
				}
							break;	/*	addr	As=1, Sreg=PC	*/
		case S_ABS:	outrw(&e1, 0);		break;	/*	&Addr	As=1, Sreg=SR	*/
		case S_RIN:				break;	/*	@Rn	As=2		*/
		case S_RIN2:				break;	/*	@Rn+	As=3		*/
		case S_IMM:	outrw(&e1, 0);		break;	/*	#N	As=3, Sreg=PC	*/
		default:	aerr();			break;
		}
		break;

	case S_DST:
		t1 = addr(&e1);
		v1 = (aindx & 0x000F);

		/*
		 * Opcode Processing
		 */
		/* DSTDST */
		switch(t1) {
		case S_REG:	op += 0x0000 + v1;	break;	/*	Rn	Ad=0		*/
		case S_RIDX:	op += 0x0080 + v1;	break;	/*	X(Rn)	Ad=1		*/
		case S_SYM:	op += 0x0080;		break;	/*	addr	Ad=1, Sreg=PC	*/
		case S_IMM:					/*	#N	==>> &Addr	*/
		case S_ABS:	op += 0x0082;		break;	/*	&Addr	Ad=1, Sreg=SR	*/
		case S_RIN:	op += 0x0080 + v1;	break;	/*	@Rn	Ad=1		*/
		case S_RIN2:	op += 0x0080 + v1;	break;	/*	@Rn+	Ad=1		*/
		default:	aerr();			break;
		}

		outaw(op);
		/*
		 * Destination Processing
		 */
		switch(t1) {
		case S_REG:				break;	/*	Rn	Ad=0		*/
		case S_RIDX:	outrw(&e1, 0);		break;	/*	X(Rn)	Ad=1		*/
		case S_SYM:	if (mchpcr(&e1)) {
					e1.e_addr -= dot.s_addr;
					outaw(e1.e_addr);
				} else {
					outrw(&e1, R_PCR0);
				}
							break;	/*	addr	Ad=1, Sreg=PC	*/
		case S_IMM:	aerr();				/*	#N	==>> &Addr	*/
		case S_ABS:	outrw(&e1, 0);		break;	/*	&Addr	Ad=1, Sreg=SR	*/
		case S_RIN:	outaw(0);		break;	/*	@Rn	Ad=1		*/
		case S_RIN2:	outaw(0);		        /*	@Rn+	Ad=1		*/
				if ((op & 0x0040) && (v1 != 0)) {
					outaw(0x5310 + v1);		/*	add	#1,Rn		*/
				} else {
					outaw(0x5320 + v1);	;	/*	add	#2,Rn		*/
				}
							break;
		default:	aerr();			break;
		}
		break;

	case S_RLX:
		t1 = addr(&e1);
		v1 = (aindx & 0x000F) << 8;

		/*
		 * Duplicate Argument
		 */
		e2.e_mode = e1.e_mode;
		e2.e_flag = e1.e_flag;
		e2.e_addr = e1.e_addr;
		e2.e_base.e_sp = e1.e_base.e_sp;
		e2.e_rlcf = e1.e_rlcf;

		t2 = t1;
		v2 = (aindx & 0x000F);

		/*
		 * Opcode Processing
		 */
		/* DOPSRC */
		switch(t1) {
		case S_REG:	op += 0x0000 + v1;	break;	/*	Rn	As=0		*/
		case S_RIDX:	op += 0x0010 + v1;	break;	/*	X(Rn)	As=1		*/
		case S_SYM:	op += 0x0010;		break;	/*	addr	As=1, Sreg=PC	*/
		case S_IMM:					/*	#N	==>> &Addr	*/
		case S_ABS:	op += 0x0210;		break;	/*	&Addr	As=1, Sreg=SR	*/
		case S_RIN:	op += 0x0020 + v1;	break;	/*	@Rn	As=2		*/
		case S_RIN2:	op += 0x0030 + v1;	break;	/*	@Rn+	As=3		*/
		default:	aerr();			break;
		}

		/* DOPDST */
		switch(t2) {
		case S_REG:	op += 0x0000 + v2;	break;	/*	Rn	Ad=0		*/
		case S_RIDX:	op += 0x0080 + v2;	break;	/*	X(Rn)	Ad=1		*/
		case S_SYM:	op += 0x0080;		break;	/*	addr	Ad=1, Sreg=PC	*/
		case S_IMM:					/*	#N	==>> &Addr	*/
		case S_ABS:	op += 0x0082;		break;	/*	&Addr	Ad=1, Sreg=SR	*/
		case S_RIN:	op += 0x0080 + v2;	break;	/*	@Rn	Ad=1		*/
		case S_RIN2:	op += 0x0080 + v2;	break;	/*	@Rn+	Ad=1		*/
		default:	aerr();			break;
		}

		outaw(op);
		/*
		 * Source Processing
		 */
		switch(t1) {
		case S_REG:				break;	/*	Rn	As=0		*/
		case S_RIDX:	outrw(&e1, 0);		break;	/*	X(Rn)	As=1		*/
		case S_SYM:	if (mchpcr(&e1)) {
					e1.e_addr -= dot.s_addr;
					outaw(e1.e_addr);
				} else {
					outrw(&e1, R_PCR0);
				}
							break;	/*	addr	As=1, Sreg=PC	*/
		case S_IMM:					/*	#N	==>> &Addr	*/
		case S_ABS:	outrw(&e1, 0);		break;	/*	&Addr	As=1, Sreg=SR	*/
		case S_RIN:				break;	/*	@Rn	As=2		*/
		case S_RIN2:				break;	/*	@Rn+	As=3		*/
		default:	aerr();			break;
		}
		/*
		 * Destination Processing
		 */
		switch(t2) {
		case S_REG:				break;	/*	Rn	Ad=0		*/
		case S_RIDX:	outrw(&e2, 0);		break;	/*	X(Rn)	Ad=1		*/
		case S_SYM:	if (mchpcr(&e2)) {
					e2.e_addr -= dot.s_addr;
					outaw(e2.e_addr);
				} else {
					outrw(&e2, R_PCR0);
				}
							break;	/*	addr	Ad=1, Sreg=PC	*/
		case S_IMM:	aerr();				/*	#N	==>> &Addr	*/
		case S_ABS:	outrw(&e2, 0);		break;	/*	&Addr	Ad=1, Sreg=SR	*/
		case S_RIN:	outaw(0);		break;	/*	@Rn	Ad=1		*/
		case S_RIN2:				        /*	@Rn+	Ad=1		*/
				if (rf == S_RLX) {
					if (op & 0x0040) {
						outaw(~0);	/*	RLX.b	@Rn+,-1(Rn)	*/
					} else {
						outaw(~1);	/*	RLX.w	@Rn+,-2(Rn)	*/
					}
				} else {
					outaw(0);
					if ((op & 0x0040) && (v2 != 0)) {
						outaw(0x5310 + v2);	/*	add	#1,Rn		*/
					} else {
						outaw(0x5320 + v2);	/*	add	#2,Rn		*/
					}
				}
							break;
		default:	aerr();			break;
		}
		break;

	case S_INH:
		outaw(op);
		break;

	case S_JXX:
		expr(&e1, 0);
		if (mchpcr(&e1)) {
			v1 = e1.e_addr - dot.s_addr - 2;
			v1 >>= 1;
			if ((v1 < -512) || (v1 > 511))
				aerr();
			outaw(op + (v1 & 0x03FF));
		} else {
			outrwm(&e1, R_PCR | R_JXX, op);
		}
		if (e1.e_mode != S_USER)
			rerr();
		break;

	default:
		err('o');
	}
}

/*
 * Branch/Jump PCR Mode Check
 */
int
mchpcr(esp)
register struct expr *esp;
{
	if (esp->e_base.e_ap == dot.s_area) {
		return(1);
	}
	if (esp->e_flag==0 && esp->e_base.e_ap==NULL) {
		/*
		 * Absolute Destination
		 *
		 * Use the global symbol '.__.ABS.'
		 * of value zero and force the assembler
		 * to use this absolute constant as the
		 * base value for the relocation.
		 */
		esp->e_flag = 1;
		esp->e_base.e_sp = &sym[1];
	}
	return(0);
}

/*
 * The next character must be a
 * comma.
 */
int
comma()
{
	if (getnb() != ',')
		qerr();
	return(1);
}

/*
 * Machine specific initialization.
 * Set up the bit table.
 * Process any setup code.
 */
VOID
minit()
{
}



/* m74mch.c */

/*
 * (C) Copyright 2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*
 * Contributions by
 *
 * Uwe Steller
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "m740.h"

/*
 * Process a machine op.
 */
VOID
machine(mp)
struct mne *mp;
	{
	register int op, t1, t2;
	struct expr e1,e2,e3;
	struct area *espa;
	char id[NCPS];
	int c;

	clrexpr(&e1);
	clrexpr(&e2);
	clrexpr(&e3);
	op = mp->m_valu;
	switch (mp->m_type) {

	case S_SDP:
		espa = NULL;
		if (more()) {
			expr(&e1, 0);
			if (e1.e_flag == 0 && e1.e_base.e_ap == NULL) {
				if (e1.e_addr) {
					err('b');
				}
			}
			if ((c = getnb()) == ',') {
				getid(id, -1);
				espa = alookup(id);
				if (espa == NULL) {
					err('u');
				}
			} else {
				unget(c);
			}
		}
		if (espa) {
			outdp(espa, &e1, 0);
		} else {
			outdp(dot.s_area, &e1, 0);
		}
		lmode = SLIST;
		break;

	case S_INH:
		outab(op);
		break;

	case S_BRA:
		expr(&e1, 0);
		outab(op);
		genbad(&e1);
		break;

	case S_JSR:
		t1 = addr(&e1);
		switch (t1) {
		case S_IND:
		case S_ZIND:
			outab(0x02);
			outrb(&e1, R_PAG0);
			break;
		case S_ZP:
		case S_ABS:
			outab(op);
			outrw(&e1, R_NORM);
			break;
		case S_SPEC:
			outab(0x22);
			outrb(&e1, 0);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_JMP:
		t1 = addr(&e1);
		switch (t1) {
		case S_IND:
			outab(op + 0x20);
			outrw(&e1, R_NORM);
			break;
		case S_ZIND:
			outab(0xB2);
			outrb(&e1, R_PAG0);
			break;
		case S_ZP:
		case S_ABS:
			outab(op);
			outrw(&e1, R_NORM);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_DOP:
		t1 = addr(&e1);
		switch (t1) {
		case S_IMMED:
			outab(op + 0x09);
			outrb(&e1, R_NORM);
			if (op == 0x80)
				aerr();
			break;
		case S_ZP:
			outab(op + 0x05);
			outrb(&e1, R_PAG0);
			break;
		case S_ZPX:
			outab(op + 0x15);
			outrb(&e1, R_PAG0);
			break;
		case S_ABS:
			outab(op + 0x0D);
			outrw(&e1, R_NORM);
			break;
		case S_ABSX:
			outab(op + 0x1D);
			outrw(&e1, R_NORM);
			break;
		case S_ZPY:
		case S_ABSY:
			outab(op + 0x19);
			outrw(&e1, R_NORM);
			break;
		case S_INDX:
			outab(op + 0x01);
			outrb(&e1, R_PAG0);
			if ((!e1.e_flag)
			    && (e1.e_base.e_ap==NULL)
				&& (e1.e_addr & ~0xFF))
				    err('d');
			break;
		case S_INDY:
			outab(op + 0x11);
			outrb(&e1, R_PAG0);
			if ((!e1.e_flag)
			    && (e1.e_base.e_ap==NULL)
				&& (e1.e_addr & ~0xFF))
				    err('d');
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_SOP:
		t1 = addr(&e1);
		switch (t1) {
		case S_ACC:
			if (op == 0xC0) {
				outab(0x1A);
			} else
			if (op == 0xE0) {
				outab(0x3A);
			} else {
				outab(op + 0x0A);
			}
			break;
		case S_ZP:
			outab(op + 0x06);
			outrb(&e1, R_PAG0);
			break;
		case S_ZPX:
			outab(op + 0x16);
			outrb(&e1, R_PAG0);
			break;
		case S_ABS:
			outab(op + 0x0E);
			outrw(&e1, R_NORM);
			break;
		case S_ABSX:
			outab(op + 0x1E);
			outrw(&e1, R_NORM);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_BIT:
		t1 = addr(&e1);
		switch (t1) {
		case S_ZP:
			outab(op + 0x04);
			outrb(&e1, R_PAG0);
			break;
		case S_ABS:
			outab(op + 0x0C);
			outrw(&e1, R_NORM);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_CP:
		t1 = addr(&e1);
		switch (t1) {
		case S_IMMED:
			outab(op);
			outrb(&e1, R_NORM);
			break;
		case S_ZP:
			outab(op + 0x04);
			outrb(&e1, R_PAG0);
			break;
		case S_ABS:
			outab(op+0x0C);
			outrw(&e1, R_NORM);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_LDX:
		t1 = addr(&e1);
		switch (t1) {
		case S_IMMED:
			outab(op + 0x02);
			outrb(&e1, R_NORM);
			break;
		case S_ZP:
			outab(op + 0x06);
			outrb(&e1, R_PAG0);
			break;
		case S_ZPY:
			outab(op + 0x16);
			outrb(&e1, R_PAG0);
			break;
		case S_ABS:
			outab(op + 0x0E);
			outrw(&e1, R_NORM);
			break;
		case S_ABSY:
			outab(op + 0x1E);
			outrw(&e1, R_NORM);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_STX:
		t1 = addr(&e1);
		switch (t1) {
		case S_ZP:
			outab(op + 0x06);
			outrb(&e1, R_PAG0);
			break;
		case S_ZPY:
		case S_ABSY:
			outab(op + 0x16);
			outrb(&e1, R_PAG0);
			break;
		case S_ABS:
			outab(op + 0x0E);
			outrw(&e1, R_NORM);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_LDY:
		t1 = addr(&e1);
		switch (t1) {
		case S_IMMED:
			outab(op);
			outrb(&e1, R_NORM);
			break;
		case S_ZP:
			outab(op + 0x04);
			outrb(&e1, R_PAG0);
			break;
		case S_ZPX:
			outab(op + 0x14);
			outrb(&e1, R_PAG0);
			break;
		case S_ABS:
			outab(op + 0x0C);
			outrw(&e1, R_NORM);
			break;
		case S_ABSX:
			outab(op + 0x1C);
			outrw(&e1, R_NORM);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_STY:
		t1 = addr(&e1);
		switch (t1) {
		case S_ZP:
			outab(op + 0x04);
			outrb(&e1, R_PAG0);
			break;
		case S_ZPX:
		case S_ABSX:
			outab(op + 0x14);
			outrb(&e1, R_PAG0);
			break;
		case S_ABS:
			outab(op + 0x0C);
			outrw(&e1, R_NORM);
			break;
		default:
			aerr();
			break;
		}
		break;

	case S_BB:
		t1 = addr(&e1);
		switch (t1) {
		case S_NBITA:
			comma();
			expr(&e3, 0);
			outrbm(&e1, R_3BIT | R_USGN, op);
			genbad(&e3);
			break;

		case S_NBIT:
			comma();
			if ((c = getnb()) != '*') {
				unget(c);
			}
			expr(&e2, 0);
			comma();
			expr(&e3, 0);
			outrbm(&e1, R_3BIT | R_USGN, op + 0x04);
			outrb(&e2, R_PAG0);
			genbad(&e3);
			break;

		default:
			aerr();
			break;
		}
		break;

	case S_LDM:
		t1 = addr(&e1);
		if (t1 != S_IMMED) {
			aerr();
		}
		comma();
		t2 = addr(&e2);
		if (t2 != S_ZP && t2 != S_ABS) {
			aerr();
		}
		/* create LDM instr */
		outab(op);
		outrb(&e1, R_USGN);
		outrb(&e2, R_PAG0);
		break;

	case S_ZERO:
		t1 = addr(&e1);
		if (t1 != S_ZP && t1 != S_ABS) {
			aerr();
		}
		outab(op);
		outrb(&e1, R_PAG0);
		break;

	case S_ZEROX:
		t1 = addr(&e1);
		if (t1 != S_ZPX && t1 != S_ABSX) {
			aerr();
		}
		outab(op);
		outrb(&e1, R_PAG0);
		break;

	case S_BITE:
		t1 = addr(&e1);
		switch (t1) {
		case S_NBITA:
			outrbm(&e1, R_3BIT | R_USGN, op);
			break;
		case S_NBIT:
			comma();
			t2 = addr(&e2);
			if (t2 != S_ZP && t2 != S_ABS) {
				aerr();
			}
			outrbm(&e1, R_3BIT | R_USGN, op + 0x04);
			outrb(&e2, R_PAG0);
			break;
		default:
			aerr();
		}
		break;


	default:
		err('o');
		break;
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
VOID
comma()
{
	if (getnb() != ',')
		qerr();
}

/*
 * Machine dependent initialization
 */
VOID
minit()
{
}


/*
 * Create address for S_BRA type instruction
 */
VOID
genbad(esp)
struct expr *esp;
{
	int v1;

	if (mchpcr(esp)) {
		v1 = esp->e_addr - dot.s_addr - 1;
		if ((v1 < -128) || (v1 > 127))
			aerr();
		outab(v1);
	} else {
		outrb(esp, R_PCR);
	}
	if (esp->e_mode != S_USER)
		rerr();
}

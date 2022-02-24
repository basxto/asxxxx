/* m11mch.c */

/*
 * (C) Copyright 1989
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include "asm.h"
#include "6811.h"

struct	sdp	sdp[] = {
	NULL
};

/*
 * Process a machine op.
 */
VOID
machine(mp)
struct mne *mp;
{
	register op, t1, t2;
	struct expr e1, e2, e3;
	struct area *espa;
	char id[NCPS];
	int reg, cpg, type, v1;

	reg = 0;
	cpg = 0;
	op = mp->m_valu;
	type = mp->m_type;
	switch (type) {

	case S_SDP:
		espa = NULL;
		if (more()) {
			getid(id, -1);
			espa = alookup(id);
			if ( espa == NULL) {
				err('u');
			}
		}
		if (espa) {
			sdp->s_area = espa;
		} else {
			sdp->s_area = dot->s_area;
		}
		lmode = SLIST;
		break;

	case S_INH2:
		outab(PAGE2);

	case S_INH:
		outab(op);
		break;

	case S_PUL:
		v1 = admode(abdxy);
		if (v1 == S_A) {
			outab(op);
			break;
		}
		if (v1 == S_B) {
			outab(op+1);
			break;
		}
		if (v1 == S_X) {
			outab(op+6);
			break;
		}
		if (v1 == S_Y) {
			outab(PAGE2);
			outab(op+6);
			break;
		}
		aerr();
		break;

	case S_BRA:
		expr(&e1, 0);
		v1 = e1.e_addr - dot->s_addr - 2;
		if ((v1 < -128) || (v1 > 127))
			aerr();
		if (e1.e_base.e_ap != dot->s_area)
			rerr();
		outab(op);
		outab(v1);
		break;

	case S_TYP1:
		t1 = addr(&e1);
		if (t1 == S_A) {
			outab(op|A);
			break;
		}
		if (t1 == S_B) {
			outab(op|B);
			break;
		}
		if (t1 == S_D) {
			if (op == 0x44) {
				outab(0x04);
				break;
			}
			if (op == 0x48) {
				outab(0x05);
				break;
			}
			aerr();
			break;
		}
		if (t1 == S_INDX || t1 == S_INDY) {
			if (t1 == S_INDY)
				outab(PAGE2);
			outab(op|X);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_DIR || t1 == S_EXT) {
			outab(op|0x30);
			outrw(&e1, 0);
			break;
		}
		aerr();
		break;

	case S_TYP2:
		if (!(reg = admode(abdxy)))
			aerr();

	case S_TYP3:
		if (!reg) {
			reg = op & 0x40;
		} else
		if (reg == S_A) {
			reg = 0x00;
		} else
		if (reg == S_B) {
			reg = 0x40;
		} else
		if (reg == S_D) {
			if (op == 0x80) {
				op = 0x83;
			} else
			if (op == 0x8B) {
				op = 0xC3;
			} else {
				aerr();
			}
			reg = 0x00;
		} else {
			aerr();
			reg = 0x00;
		}
		t1 = addr(&e1);
		if (t1 == S_IMMED) {
			if ((op|0x40) == 0xC7)
				aerr();
			if (op == 0x83 || op == 0xC3) {
				outab(op|reg);
				outrw(&e1, 0);
			} else {
				outab(op|reg);
				outrb(&e1, 0);
			}
			break;
		}
		if (t1 == S_DIR) {
			outab(op|reg|0x10);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_INDX || t1 == S_INDY) {
			if (t1 == S_INDY)
				outab(PAGE2);
			outab(op|reg|0x20);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_EXT) {
			outab(op|reg|0x30);
			outrw(&e1, 0);
			break;
		}
		aerr();
		break;

	case S_TYP4:
		t1 = addr(&e1);
		if (t1 == S_IMMED) {
			if (op&0x0D == 0x0D)
				aerr();
			outab(op);
			outrw(&e1, 0);
			break;
		}
		if (t1 == S_DIR) {
			outab(op|0x10);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_INDX || t1 == S_INDY) {
			if (t1 == S_INDY)
				outab(PAGE2);
			outab(op|0x20);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_EXT) {
			outab(op|0x30);
			outrw(&e1, 0);
			break;
		}
		aerr();
		break;

	case S_TYP5:
		t1 = addr(&e1);
		if (t1 == S_INDX || t1 == S_INDY) {
			if (t1 == S_INDY)
				outab(PAGE2);
			outab(op);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_EXT) {
			outab(op|0x10);
			outrw(&e1, 0);
			break;
		}
		aerr();
		break;

	case S_PG3:
		cpg += (PAGE3-PAGE2);

	case S_PG2:
		cpg += PAGE2;

	case S_TYP6:
		t1 = addr(&e1);
		if (t1 == S_IMMED) {
			if (op == 0xCF)
				aerr();
			if (cpg)
				outab(cpg);
			outab(op);
			outrw(&e1, 0);
			break;
		}
		if (t1 == S_DIR) {
			if (cpg)
				outab(cpg);
			outab(op|0x10);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_INDX) {
			if (cpg)
				outab(PAGE3);
			outab(op|0x20);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_INDY) {
			if (cpg == PAGE2) {
				outab(PAGE2);
			} else {
				outab(PAGE4);
			}
			outab(op|0x20);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_EXT) {
			if (cpg)
				outab(cpg);
			outab(op|0x30);
			outrw(&e1, 0);
			break;
		}
		aerr();
		break;

	case S_BTB:
	case S_STCLR:
		v1 = 0;
		t1 = addr(&e1);
		if (t1 == S_DIR) {
			;
		} else
		if (t1 == S_INDX || t1 == S_INDY) {
			if (type == S_BTB) {
				op += 0x0C;
			} else {
				op += 0x08;
			}
		} else {
			aerr();
		}
		comma();
		t2 = addr(&e2);
		if (t2 != S_IMMED)
			aerr();
		if (type == S_BTB) {
			comma();
			expr(&e3, 0);
			v1 = e3.e_addr - dot->s_addr - 4;
			if (t1 == S_INDY)
				--v1;
			if ((v1 < -128) || (v1 > 127))
				aerr();
			if (e3.e_base.e_ap != dot->s_area)
				rerr();
		}
		if (t1 == S_INDY)
			outab(PAGE2);
		outab(op);
		outrb(&e1, 0);
		outrb(&e2, 0);
		if (type == S_BTB)
			outab(v1);
		break;

	default:
		err('o');
	}
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
	sdp->s_area = dot->s_area;
}

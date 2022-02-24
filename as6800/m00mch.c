/* m00mch.c */

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
#include "6800.h"

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
	register op, t1;
	struct expr e1;
	struct area *espa;
	char id[NCPS];
	int v1, reg;

	reg = 0;
	op = mp->m_valu;
	switch (mp->m_type) {

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

	case S_INH:
		outab(op);
		break;

	case S_PUL:
		v1 = admode(abx);
		if (v1 == S_A) {
			outab(op);
			break;
		}
		if (v1 == S_B) {
			outab(op+1);
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
		if (t1 == S_DIR || t1 == S_EXT) {
			outab(op|0x30);
			outrw(&e1, 0);
			break;
		}
		if (t1 == S_INDX) {
			outab(op|X);
			outrb(&e1, 0);
			break;
		}
		aerr();
		break;

	case S_TYP2:
		if (!(reg = admode(abx)))
			aerr();

	case S_TYP3:
		if (!reg) {
			reg = op & 0x40;
		} else if (reg == S_A) {
			reg = 0x00;
		} else if (reg == S_B) {
			reg = 0x40;
		} else {
			aerr();
			reg = 0x00;
		}
		t1 = addr(&e1);
		if (t1 == S_IMMED) {
			if ((op|0x40) == 0xC7)
				aerr();
			outab(op|reg);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_EXT) {
			outab(op|reg|0x30);
			outrw(&e1, 0);
			break;
		}
		if (t1 == S_DIR) {
			outab(op|reg|0x10);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_INDX) {
			outab(op|reg|0x20);
			outrb(&e1, 0);
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
		if (t1 == S_EXT) {
			outab(op|0x30);
			outrw(&e1, 0);
			break;
		}
		if (t1 == S_DIR) {
			outab(op|0x10);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_INDX) {
			outab(op|0x20);
			outrb(&e1, 0);
			break;
		}
		aerr();
		break;

	case S_TYP5:
		t1 = addr(&e1);
		if (t1 == S_DIR || t1 == S_EXT) {
			outab(op|0x10);
			outrw(&e1, 0);
			break;
		}
		if (t1 == S_INDX) {
			outab(op);
			outrb(&e1, 0);
			break;
		}
		aerr();
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

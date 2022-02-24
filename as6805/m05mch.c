/* m05mch.c */

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
#include "6805.h"

#define	NB	256

int	*bp;
int	bm;
int	bb[NB];

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
	register op, t1, t2, type;
	struct expr e1, e2, e3;
	addr_t espv;
	struct area *espa;
	char id[NCPS];
	int flag, v1;

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

	case S_INH:
		outab(op);
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
		espv = e1.e_addr;
		espa = e1.e_base.e_ap;
		if (t1 == S_A) {
			outab(op+0x10);
			break;
		}
		if (t1 == S_X) {
			outab(op+0x20);
			break;
		}
		if (t1 == S_DIR) {
			outab(op);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_IX) {
			outab(op+0x40);
			break;
		}
		if (t1 == S_DIRX) {
			outab(op+0x30);
			outrb(&e1, 0);
			break;
		}
		aerr();
		break;

	case S_TYP2:
		t1 = addr(&e1);
		espv = e1.e_addr;
		espa = e1.e_base.e_ap;
		if (t1 == S_IMMED) {
			if ((op == 0xA7) ||
			    (op == 0xAC) ||
			    (op == 0xAF))
				aerr();
			outab(op);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_DIR) {
			outab(op+0x10);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_EXT) {
			outab(op+0x20);
			outrw(&e1, 0);
			break;
		}
		if (t1 == S_IX) {
			outab(op+0x50);
			break;
		}
		if (t1 == S_DIRX) {
			outab(op+0x40);
			outrb(&e1, 0);
			break;
		}
		if (t1 == S_INDX) {
			if (pass == 0) {
				dot->s_addr += 3;
			} else
			if (e1.e_flag ||
			   (espa && espa != dot->s_area)) {
				outab(op+0x30);
				outrw(&e1, 0);
			} else
			if (pass == 1) {
				if (e1.e_addr >= dot->s_addr)
					e1.e_addr -= fuzz;
				flag = 0;
				if (espv & ~0xFF)
					++flag;
				if (setbit(flag)) {
					dot->s_addr += 3;
				} else {
					dot->s_addr += 2;
				}
			} else {
				if (getbit()) {
					outab(op+0x30);
					outrw(&e1, 0);
				} else {
					outab(op+0x40);
					outrb(&e1, 0);
				}
			}
			break;
		}
		aerr();
		break;

	case S_TYP3:
	case S_TYP4:
		t1 = addr(&e1);
		espv = e1.e_addr;
		if (t1 != S_IMMED)
			aerr();
		if (espv & ~0x07)
			aerr();
		e1.e_addr = op + 2*(espv&0x07);
		comma();
		t2 = addr(&e2);
		if (t2 != S_DIR)
			aerr();
		espa = e2.e_base.e_ap;
		if (espa && espa != sdp->s_area)
			rerr();
		if (type == S_TYP4) {
			expr(&e3, 0);
			v1 = e3.e_addr - dot->s_addr - 3;
			if ((v1 < -128) || (v1 > 127))
				aerr();
			if (e3.e_base.e_ap != dot->s_area)
				rerr();
		}
		outrb(&e1, 0);
		outrb(&e2, 0);
		if (type == S_TYP4)
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
 * Machine specific initialization.
 * Set up the bit table.
 * Reset direct page.
 */
VOID
minit()
{
	bp = bb;
	bm = 1;
	sdp->s_area = dot->s_area;
}

/*
 * Store `b' in the next slot of the bit table.
 * If no room, force the longer form of the offset.
 */
int
setbit(b)
{
	if (bp >= &bb[NB])
		return(1);
	if (b)
		*bp |= bm;
	bm <<= 1;
	if (bm == 0) {
		bm = 1;
		++bp;
	}
	return(b);
}

/*
 * Get the next bit from the bit table.
 * If none left, return a `1'.
 * This will force the longer form of the offset.
 */
int
getbit()
{
	register f;

	if (bp >= &bb[NB])
		return (1);
	f = *bp & bm;
	bm <<= 1;
	if (bm == 0) {
		bm = 1;
		++bp;
	}
	return (f);
}

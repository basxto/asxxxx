/* m09mch.c */

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
#include "6809.h"

#define	NB	256

int	*bp;
int	bm;
int	bb[NB];

struct	sdp	sdp[] = {
	0,	NULL
};

/*
 * Process a machine op.
 */
VOID
machine(mp)
struct mne *mp;
{
	register op, rf, cpg, c;
	struct expr e1;
	int t1, v1, v2;
	struct area *amp;
	char id[NCPS];
	cpg = 0;
	op = mp->m_valu;
	switch (rf = mp->m_type) {

	case S_INH2:
		cpg += 0x01;

	case S_INH1:
		cpg += 0x10;

	case S_INH:
		if (cpg)
			outab(cpg);
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

	case S_LBRA:
		cpg += 0x10;

	case S_LBSR:
		expr(&e1, 0);
		if (cpg)
			outab(cpg);
		outab(op);
		if (e1.e_base.e_ap != dot->s_area) {
			outrw(&e1, 1);
		} else {
			v1 = e1.e_addr - dot->s_addr - 2;
			outaw(v1);
		}
		if (e1.e_mode != S_USER)
			aerr();
		break;

	case S_PULS:
		v1 = 0;
		do {
			if ((t1 = admode(stks)) == 0 || v1 & t1)
				aerr();
			v1 |= t1;
		} while (more() && comma());
		outab(op);
		outab(v1);
		break;

	case S_PULU:
		v1 = 0;
		do {
			if ((t1 = admode(stku)) == 0 || v1 & t1)
				aerr();
			v1 |= t1;
		} while (more() && comma());
		outab(op);
		outab(v1);
		break;

	case S_EXG:
		v1 = admode(regs);
		comma();
		v2 = admode(regs);
		if ((v1 & 0x08) != (v2 & 0x08))
			aerr();
		outab(op);
		outab((v1<<4)|v2);
		break;

	case S_ACC:
		t1 = addr(&e1);
		if (t1 == S_IMMED)
			e1.e_mode = S_IMB;
		genout(cpg, op, rf, &e1);
		break;

	case S_STR1:
		cpg += 0x10;

	case S_SOP:
	case S_STR:
		t1 = addr(&e1);
		if (t1 == S_IMMED)
			e1.e_mode = S_IMER;
		genout(cpg, op, rf, &e1);
		break;

	case S_LR2:
		cpg += 0x01;

	case S_LR1:
		cpg += 0x10;

	case S_LR:
		t1 = addr(&e1);
		if (t1 == S_IMMED)
			e1.e_mode = S_IMW;
		genout(cpg, op, rf, &e1);
		break;

	case S_LEA:
		t1 = addr(&e1);
		if (index) {
			genout(cpg, op, rf, &e1);
			break;
		}
		aerr();
		break;

	case S_CC:
		t1 = addr(&e1);
		if (t1 == S_IMMED) {
			e1.e_mode = S_IMB;
			genout(cpg, op, rf, &e1);
			break;
		}
		aerr();
		break;

	case S_6800:
		m68out(op);
		break;		

	case S_SDP:
		expr(&e1, 0);
		amp = NULL;
		if ((c = getnb()) == ',') {
			getid(id, -1);
			amp = alookup(id);
			if ( amp == NULL) {
				err('u');
			}
		} else {
			unget(c);
		}
		if (amp) {
			sdp->s_area = amp;
		} else {
			sdp->s_area = dot->s_area;
		}
		sdp->s_addr = e1.e_addr & ~0xFF;
		lmode = SLIST;
		break;

	default:
		err('o');
	}
}

/*
 * General Output Routine
 */
VOID
genout(cpg, op, rf, esp)
register int cpg, op, rf;
register struct expr *esp;
{
	int espv;
	struct area *espa;
	int disp, flag;

	espv = esp->e_addr;
	espa = esp->e_base.e_ap;
	switch (esp->e_mode) {

	case S_IMB:
		if (cpg)
			outab(cpg);
		outab(op);
		outrb(esp, 0);
		break;

	case S_IMW:
		if (cpg)
			outab(cpg);
		outab(op);
		outrw(esp, 0);
		break;

	case S_DIR:
		if (cpg)
			outab(cpg);
		if (rf == S_SOP) {
			outab(op&0x0F);
		} else {
			outab(op|0x10);
		}
		if (espa && espa != sdp->s_area)
			rerr();
		espv = espv - sdp->s_addr;
		if (espv & ~0xFF)
			aerr();
		outab(espv);
		break;

	case S_EXT:
		if (cpg)
			outab(cpg);
		if (index) {
			outab(op|0x20);
			outab(index|0x0F);
			outrw(esp, 0);
			break;
		}
		outab(op|0x30);
		outrw(esp, 0);
		break;

	case S_IND:
		if (cpg)
			outab(cpg);
		outab(op|0x20);
		outab(index);
		break;

	case S_PC:
		if (espa) {
			aerr();
			break;
		}
		if (cpg)
			outab(cpg);
		outab(op|0x20);
		if (pass == 0) {
			dot->s_addr += 3;
		} else
		if (pass == 1) {
			if (esp->e_addr >= dot->s_addr)
				esp->e_addr -= fuzz;
			dot->s_addr += 2;
			disp = esp->e_addr;
			flag = 0;
			if (disp<-128 || disp>127)
				++flag;
			if (setbit(flag))
				++dot->s_addr;
		} else {
			if (getbit()) {
				outab(index|0x01);
				outaw(espv);
			} else {
				outab(index);
				outab(espv);
			}
		}
		break;

	case S_PCR:
		if (cpg)
			outab(cpg);
		outab(op|0x20);
		if (pass == 0) {
			dot->s_addr += 3;
		} else
		if (espa && espa != dot->s_area) {
			outab(index|0x01);
			outrw(esp, 1);
		} else
		if (pass == 1) {
			if (esp->e_addr >= dot->s_addr)
				esp->e_addr -= fuzz;
			dot->s_addr += 2;
			disp = esp->e_addr - dot->s_addr;
			flag = 0;
			if (disp<-128 || disp>127)
				++flag;
			if (setbit(flag))
				++dot->s_addr;
		} else {
			if (getbit()) {
				outab(index|0x01);
				disp = espv - dot->s_addr - 2;
				outaw(disp);
			} else {
				outab(index);
				disp = espv - dot->s_addr - 1;
				outab(disp);
			}
		}
		break;

	case S_OFST:
		if (cpg)
			outab(cpg);
		outab(op|0x20);
		if (pass == 0) {
			dot->s_addr += 3;
		} else
		if (espa) {
			outab(index|0x09);
			outrw(esp, 0);
		} else
		if (pass == 1) {
			if (esp->e_addr >= dot->s_addr)
				esp->e_addr -= fuzz;
			dot->s_addr += 1;
			flag = 0;
			if (espv <- 128 || espv > 127)
				++flag;
			if (setbit(flag)) {
				dot->s_addr += 2;
			} else {
				flag = index & 0x10;
				if (espv <- 16 || espv > 15)
					++flag;
				if (setbit(flag))
					++dot->s_addr;
			}
		} else {
			if (getbit()) {
				outab(index|0x09);
				outaw(espv);
			} else {
				if (getbit()) {
					outab(index|0x08);
					outab(espv);
				} else {
					outab((index & 0x60) | (espv & 0x1F));
				}
			}
		}
		break;

	case S_IMER:
	default:
		aerr();
	}
}

/*
 * mc6800 compatibility output routine
 */
VOID
m68out(i)
int i;
{
	register char *ptr;
	register int j;
	ptr = (char *) &mc6800[i].opcode;
	for (j=0; j<4 ; j++) {
		if (i = *ptr++) {
			outab(i);
		} else {
			break;
		}
	}
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
	sdp->s_addr = 0;
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

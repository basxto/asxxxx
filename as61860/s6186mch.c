/* s6186mch.c */

/*
 * (C) Copyright 2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 *
 * Ported for SC61860 by Edgar Puehringer
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "s61860.h"

/*
 * Process machine ops.
 */
VOID
machine(mp)
struct mne *mp;
{
	register unsigned op;
	struct expr e1, e2;
       	int t1;

	clrexpr(&e1);
	clrexpr(&e2);
	op = mp->m_valu;
	switch (mp->m_type) {

	case S_INH:
		outab(op);
		break;

	case S_CAL:
		t1 = addr(&e1);
		if (t1 != S_EXT) {
			aerr();
		}
		/*
		 *	CAL	label
		 */
		if (is_abs(&e1)) {
			if (e1.e_addr & ~0x1FFF) {
				aerr();
			}
			outaw((op << 8) | (e1.e_addr & 0x1FFF));
		} else {
			outrwm(&e1, R_PAG0 | R_13BIT, op << 8);
		}
		break;

	case S_ADI:
		t1 = addr(&e1);
		if ((t1 != S_IMM) && (t1 != S_EXT)) {
			aerr();
		}
		/*
		 *	ADI	#0x03
		 *	ADI	 0x03
		 */
		outab(op);
		outrb(&e1, 0);
		break;

	case S_LP:
		/*
		 *	LP	register
		 */
		t1 = addr(&e1);
		if (t1 != S_EXT) {
			aerr();
		}
		if (is_abs(&e1)) {
			if (e1.e_addr & ~0x3F) {
				aerr();
			}
			outab(op | (e1.e_addr & 0x3F));
		} else {
			outrbm(&e1, R_PAG0 | R_6BIT, op);
		}
		break;

	case S_JMP:
		t1 = addr(&e1);
		if (t1 != S_EXT) {
			aerr();
		}
		/*
		 *	JMP	label
		 */
		outab(op);
		outrw(&e1, 0);
		break;

	case S_JRP:
		t1 = addr(&e1);
		if (t1 != S_EXT) {
			aerr();
		}
		if (is_abs(&e1)) {
			/*
			 *	JRP	pbra-(.+1)
			 *	IX
			 *	IY
			 * pbra:
			 *
			 **** OR ***
			 *
			 *	JRP	3
			 *	IX
			 *	IY
			 * pbra:
			 */
			;
		} else
		if (mchpcr(&e1)) {
			/*
			 *	JRP	pbra
			 *		...
			 * pbra:
			 */
			e1.e_addr = e1.e_addr - (dot.s_addr + 1);
		} else {
			/*
			 *	LOOP	external
			 */
			abscheck(&e1);
		}
		outab(op);
		if (e1.e_addr & ~0xFF) {
			aerr();
		}
		outab(e1.e_addr & 0xFF);
		break;

	case S_JRM:
		t1 = addr(&e1);
		if (t1 != S_EXT) {
			aerr();
		}
		if (is_abs(&e1)) {
			/*
			 * mbra:
			 *	IX
			 *	IY
			 *	JRM	(.+1)-mbra
			 *
			 **** OR ***
			 *
			 * mbra:
			 *	IX
			 *	IY
			 *	JRM	3
			 */
			;
		} else
		if (mchpcr(&e1)) {
			/*
			 * mbra:
			 *		...
			 *	JRM	mbram
			 */
			e1.e_addr = (dot.s_addr + 1) - e1.e_addr;
		} else {
			/*
			 *	LOOP	external
			 */
			abscheck(&e1);
		}
		outab(op);
		if (e1.e_addr & ~0xFF) {
			aerr();
		}
		outab(e1.e_addr & 0xFF);
		break;

	case S_PTC:
		expr(&e1, 0);
		comma();
		expr(&e2, 0);
		outab(op);
		outrb(&e1, 0);
		outrw(&e2, 0);
		break;

	case S_CASE:
		expr(&e1, 0);
		comma();
		expr(&e2, 0);
		outrb(&e1, 0);
		outrw(&e2, 0);
		break;

        case S_DEFA:
		expr(&e1, 0);
		outrw(&e1, 0);
		break;

	default:
		err('o');
	}
}

/*
 * Is the next character a comma ?
 */
int
comma()
{
	if (getnb() != ',')
		qerr();
	return(1);
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
 * Dummy machine specific init.
 */
VOID
minit()
{
}

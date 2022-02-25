/* 1802mch.c */

/*
 * (C) Copyright 2002-2003
 * All Rights Reserved
 *
 * Shujen Chen
 * 605 Balmoral Circle
 * Naperville, IL 60540
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "1802.h"

/*
 * Process machine ops.
 */
VOID
machine(mp)
struct mne *mp;
{
	register unsigned op, v, rd;
	struct expr e;

	clrexpr(&e);
	op = mp->m_valu;
	switch (mp->m_type) {

	case S_INH:
		outab(op);
		break;

	case S_LBR:
		expr(&e, 0);
		outab(op);
		outrw(&e, 0);
		break;

	case S_NIB:
		rd = reg();
		if (rd > R15)
			aerr();
		if (op == 0 && rd == 0) /* no "LDN R0" */
			aerr();
		outab(op | rd);
		break;

	case S_BR:
		expr(&e, 0);
		mchbr(&e);
		outrwm(&e, R_PAGX1 | R_BR, op << 8);
		break;

	case S_IMM:
		expr(&e, 0);
		if (is_abs(&e)) {
			v = e.e_addr & ~0xFF;
			if ( ((v & ~0xFF) != 0) && ((v & ~0x7F) != ~0x7F) )
				aerr();
		}
		outab(op);
		outrb(&e, 0);
		break;

	case S_INP:
	case S_OUT:
		expr(&e, 0);
		if (is_abs(&e)) {
			if ((e.e_addr & ~0x07) || (e.e_addr == 0)) {
				e.e_addr = 1;
				aerr();
			}
			outab(op | (e.e_addr & 0x07));
		} else {
			outrbm(&e, R_PAG0 | R_IO, op);
		}
		break;

	default:
		err('o');
	}
}

/*
 * Read a register name.
 */
int
reg()
{
	register struct mne *mp;
	char id[NCPS];

	getid(id, -1);
	if ((mp = mlookup(id)) == NULL || mp->m_type != S_REG) {
		aerr();
		return (0);
	}
	return (mp->m_valu);
}

/*
 * Branch Mode Check
 */
int
mchbr(esp)
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

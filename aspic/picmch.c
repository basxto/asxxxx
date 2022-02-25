/* picmch.c */

/*
 * (C) Copyright 2001-2003
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
#include "pic.h"

static char buff[NINPUT];
static char pic_cpu[80];
static int  pic_type;
static a_uint pic_fsr;
static struct badram *br;

/*
 * Process machine ops.
 */
VOID
machine(mp)
struct mne *mp;
{
	int c, d, op;
	char *cp, *p;
	char id[NINPUT];
	char picmne[NINPUT];
	struct CpuDef *cd;
	struct CpuFix *cf;
	struct badram *brp;
	struct sym *sp;
	struct expr e1;
	struct expr e2;

	op = mp->m_valu;
	switch (mp->m_type) {

	case S_BITS:
		exprmasks(mp->m_valu);
		lmode = SLIST;
		break;

	case X_PMAXR:		/*	.maxram		valu	*/
		lmode = SLIST;
		clrexpr(&e1);
		expr(&e1, 0);
		if (pass == 1) {
			brp = (struct badram *) new (sizeof(struct badram));
			if (br == NULL) {
				brp->b_badram = NULL;
			} else {
				brp->b_badram = br;
			}
			br = brp;
			br->b_lo = e1.e_addr;
			br->b_hi = ~0;
			if (is_abs(&e1) == 0) {
				err('e');
			}
		}
		if (more()) {
			err('e');
			while (getnb()) ;
		}
		break;

	case X_PBADR:		/*	.badram		valu [,	lovalu:hivalu]	*/
		lmode = SLIST;
		do {
			clrexpr(&e1);
			expr(&e1, 0);
			if (pass == 1) {
				brp = (struct badram *) new (sizeof(struct badram));
				if (br == NULL) {
					brp->b_badram = NULL;
				} else {
					brp->b_badram = br;
				}
				br = brp;
				br->b_lo = e1.e_addr;
				br->b_hi = e1.e_addr;
				if (is_abs(&e1) == 0) {
					err('e');
				}
			}
			if ((c = getnb()) == ':') {
				clrexpr(&e2);
				expr(&e2, 0);
				if (pass == 1) {
					br->b_hi = e2.e_addr;
					if (is_abs(&e2) == 0) {
						err('e');
					}
				}
			} else {
				unget(c);
			}
		} while (getnb() == ',');
		break;

	case X_PTYPE:
		/*
		 * Append CPU Type to PIC_CPU
		 */
		if (more()) {
			cp = p = id;
			d = getnb();
			while ((c = get()) != d) {
				if (p < &id[sizeof(id)-1]) {
					*p++ = c;
				} else {
					break;
				}
			}
			*p = 0;
		} else {
			cp = "PIC_Not_Selected";
		}
		strcpy(pic_cpu, cp);

		sprintf(id, "__%s", pic_cpu + 1);
		sp = lookup(id);
		if (sp->s_type != S_NEW && (sp->s_flag & S_ASG) == 0) {
			err('m');
		}
		sp->s_type = S_USER;
		sp->s_addr = 1;
		sp->s_flag |= S_ASG;

		sprintf(buff, "%s,  %s", PIC_CPU, pic_cpu);
		cpu = buff;
		lmode = SLIST;
		break;

	case X_PBITS:
		pic_type = op;
		cd = picDef;
		while (cd->id) {
			mp = mlookup(cd->id);
			if (mp) {
				mp->m_valu = cd->opcode[op];
			} else
			if (pass == 0) {
				printf("?ASPIC-Internal-Error-<picpst.c: mne[]/picDef[]>\n");
			}
			cd++;
		}
		/*
		 * Load Cpu Addressing
		 */
		switch(op) {
		default:
		case X_NOPIC:
		case X_12BIT:
		case X_14BIT:
		case X_16BIT:		exprmasks(2);	break;
		case X_20BIT:		exprmasks(4);	break;
		}
		/*
		 * Load Known Cpu Fixes
		 */
		cf = picFix;
		while (cf->picid) {
			if (symeq(pic_cpu, cf->picid,  1)) {
				mp = mlookup(cf->picmne);
				if (mp) {
					mp->m_valu = cf->opcode;
				} else
				if (pass == 0) {
					printf("?ASPIC-Internal-Error-<picpst.c: mne[]/picFix[]>\n");
				}
			}
			cf++;
		}
		lmode = SLIST;
		break;

	case X_PFIX:
		/*
		 * Get the CPU type
		 */
		if (!more()) {
			qerr();
		}
		p = id;
		d = getnb();
		while ((c = get()) != d) {
			if (p < &id[sizeof(id)-1]) {
				*p++ = c;
			} else {
				break;
			}
		}
		*p = 0;
		/*
		 * Get the mnemonic
		 */
		comma();
		if (!more()) {
			qerr();
		}
		p = picmne;
		d = getnb();
		while ((c = get()) != d) {
			if (p < &picmne[sizeof(picmne)-1]) {
				*p++ = c;
			} else {
				break;
			}
		}
		*p = 0;
		/*
		 * Get the new opcode value
		 */
		comma();
		if (!more()) {
			qerr();
		}
		op = absexpr();
		/*
		 * Change Opcode Value
		 */
		if (symeq(pic_cpu, id,  1)) {
			mp = mlookup(picmne);
			if (mp) {
				mp->m_valu = op;
			} else {
				err('u');
			}
		} else {
			err('u');
		}
		lmode = SLIST;
		break;

	default:
		/*
		 * Process According to CPU Type
		 */
		switch(pic_type) {
		case X_NOPIC:					break;
		case X_12BIT:		pic12bit(mp);		break;
		case X_14BIT:		pic14bit(mp);		break;
		case X_16BIT:		pic16bit(mp);		break;
		case X_20BIT:		pic20bit(mp);		break;
		default:					break;
		}
		break;
	}
}


/*
 * PIC12BIT CPU Type
 */
VOID
pic12bit(mp)
struct mne *mp;
{
	int c, op;
	int t1, t2;
	int r_mode;
	struct expr e1, e2;
	char id[NINPUT];
	struct area *espa;

	clrexpr(&e1);
	clrexpr(&e2);

	op = mp->m_valu;
	if (op == ~0) {			/* Undefined Instructions */
		err('o');
		op = 0;
	}
	switch (mp->m_type) {
	case S_SDMM:
		espa = NULL;
		if (more()) {
			expr(&e1, 0);
			abscheck(&e1);
			e1.e_addr *= 0x20;
			if ((c = getnb()) == ',') {
				getid(id, -1);
				espa = alookup(id);
				if (espa == NULL) {
					err('u');
				}
			} else {
				unget(c);
			}
			pic_fsr = e1.e_addr;
		} else {
			pic_fsr = ~0;
		}
		if (espa) {
			outdp(espa, &e1, 0);
		} else {
			outdp(dot.s_area, &e1, 0);
		}
		lmode = SLIST;
		break;

	case S_FW:			/* inst f,d */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* d */
		if (t2 == S_WREG) {
			e2.e_addr = 0;
		} else
		if (t2 == S_FREG) {
			e2.e_addr = 1;
		} else {
			abscheck(&e2);
			if (e2.e_addr & ~0x01) {
				aerr();
				e2.e_addr &= 0x01;
			}
			if (t2 == S_DIR) {
				aerr();
			}
		}
		if (is_abs(&e1)) {
			mch12fsr(&e1);
			r_mode = R_5BIT;
		} else {
			r_mode = R_PAGN | R_5BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 5));
		break;

	case S_CLRF:			/* clrf */
	case S_F:			/* inst f */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		if (is_abs(&e1)) {
			mch12fsr(&e1);
			r_mode = R_5BIT;
		} else {
			r_mode = R_PAGN | R_5BIT;
		}
		outrwm(&e1, r_mode, op);
		break;

	case S_FBIT:			/* inst f,b */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* b */
		if ((t2 != S_IMMED) && (t2 != S_EXT)) {
			aerr();
		}
		abscheck(&e2);
		if (e2.e_addr & ~0x07) {
			aerr();
			e2.e_addr &= 0x07;
		}
		if (is_abs(&e1)) {
			mch12fsr(&e1);
			r_mode = R_5BIT;
		} else {
			r_mode = R_PAGN | R_5BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 5));
		break;

	case S_LIT:			/* inst k */
		t1 = addr(&e1);		/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		outrwm(&e1, R_8BIT, op);
		break;

	case S_CALL:			/* inst k */
		t1 = addr(&e1);		/* k */
		if (t1 != S_EXT) {
			aerr();
		}
		outrwm(&e1, R_8BIT, op);
		break;

	case S_GOTO:			/* inst k */
		t1 = addr(&e1);		/* k */
		if (t1 != S_EXT) {
			aerr();
		}
		outrwm(&e1, R_9BIT, op);
		break;

	case S_CLRW:			/* clrw */
	case S_INH:			/* inst */
		outaw(op);
		break;

	case S_TRIS:			/* inst [k] */
		t1 = addr(&e1);		/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		abscheck(&e1);
		if (e1.e_addr != 6) {
			aerr();
			e1.e_addr = 6;
		}
		outaw(op + e1.e_addr);
		break;

	default:
		err('o');
		break;
	}
}

/*
 * File Select Register Map
 */
VOID
mch12fsr(esp)
register struct expr *esp;
{
	if (pic_fsr != ~0) {
		if ((esp->e_addr & ~0x1F) != pic_fsr) {
			aerr();
		}
	}
}


/*
 * PIC14BIT CPU Type
 */
VOID
pic14bit(mp)
struct mne *mp;
{
	int c, op;
	int t1, t2;
	int r_mode;
	struct expr e1, e2;
	char id[NINPUT];
	struct area *espa;

	clrexpr(&e1);
	clrexpr(&e2);

	op = mp->m_valu;
	if (op == ~0) {			/* Undefined Instructions */
		err('o');
		op = 0;
	}
	switch (mp->m_type) {
	case S_SDMM:
		espa = NULL;
		if (more()) {
			expr(&e1, 0);
			if (e1.e_flag == 0 && e1.e_base.e_ap == NULL) {
				if (e1.e_addr & 0x7F) {
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

	case S_FW:			/* inst f,d */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* d */
		if (t2 == S_WREG) {
			e2.e_addr = 0;
		} else
		if (t2 == S_FREG) {
			e2.e_addr = 1;
		} else {
			abscheck(&e2);
			if (e2.e_addr & ~0x01) {
				aerr();
				e2.e_addr &= 0x01;
			}
			if (t2 == S_DIR) {
				aerr();
			}
		}
		if (is_abs(&e1)) {
			r_mode = R_MBRO | R_7BIT;
		} else {
			r_mode = R_PAG0 | R_7BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 7));
		break;

	case S_CLRF:			/* clrf */
	case S_F:			/* inst f */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		if (is_abs(&e1)) {
			r_mode = R_MBRO | R_7BIT;
		} else {
			r_mode = R_PAG0 | R_7BIT;
		}
		outrwm(&e1, r_mode, op);
		break;

	case S_FBIT:			/* inst f,b */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* b */
		if ((t2 != S_IMMED) && (t2 != S_EXT)) {
			aerr();
		}
		abscheck(&e2);
		if (e2.e_addr & ~0x07) {
			aerr();
			e2.e_addr &= 0x07;
		}
		if (is_abs(&e1)) {
			r_mode = R_MBRO | R_7BIT;
		} else {
			r_mode = R_PAG0 | R_7BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 7));
		break;

	case S_LIT:			/* inst k */
		t1 = addr(&e1);		/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		outrwm(&e1, R_8BIT, op);
		break;

	case S_CALL:			/* inst k */
	case S_GOTO:			/* inst k */
		t1 = addr(&e1);		/* k */
		if (t1 != S_EXT) {
			aerr();
		}
		outrwm(&e1, R_11BIT, op);
		break;

	case S_RET:			/* return, retfie */
	case S_CLRW:			/* clrw */
	case S_INH:			/* inst */
		outaw(op);
		break;

	case S_TRIS:			/* inst [k] */
		t1 = addr(&e1);	/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		abscheck(&e1);
		if ((e1.e_addr < 5) || (e1.e_addr > 7)) {
			aerr();
		}
		outaw(op + (e1.e_addr & 0x07));
		break;

	default:
		err('o');
		break;
	}
}


/*
 * PIC16BIT CPU Type
 */
VOID
pic16bit(mp)
struct mne *mp;
{
	int c, op;
	int t1, t2, t3;
	int r_mode;
	struct expr e1, e2, e3;
	char id[NINPUT];
	struct area *espa;

	clrexpr(&e1);
	clrexpr(&e2);
	clrexpr(&e3);

	op = mp->m_valu;
	if (op == ~0) {			/* Undefined Instructions */
		err('o');
		op = 0;
	}
	switch (mp->m_type) {
	case S_SDMM:
		espa = NULL;
		if (more()) {
			expr(&e1, 0);
			if (e1.e_flag == 0 && e1.e_base.e_ap == NULL) {
				if (e1.e_addr & 0xFF) {
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

	case S_DAW:			/* daw  f,s */
	case S_CLRF:			/* clrf f,s */
	case S_SETF:			/* setf f,s */
	case S_FW:			/* inst f,d */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* d/s */
		if (t2 == S_WREG) {
			e2.e_addr = 0;
		} else
		if (t2 == S_FREG) {
			e2.e_addr = 1;
		} else {
			abscheck(&e2);
			if (e2.e_addr & ~0x01) {
				aerr();
				e2.e_addr &= 0x01;
			}
			if (t2 == S_DIR) {
				aerr();
			}
		}
		if (is_abs(&e1)) {
			r_mode = R_MBRO | R_8BIT;
		} else {
			r_mode = R_PAG0 | R_8BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 8));
		break;

	case S_F:			/* inst f */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		if (is_abs(&e1)) {
			r_mode = R_MBRO | R_8BIT;
		} else {
			r_mode = R_PAG0 | R_8BIT;
		}
		outrwm(&e1, r_mode, op);
		break;

	case S_FBIT:			/* inst f,b */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* b */
		if ((t2 != S_IMMED) && (t2 != S_EXT)) {
			aerr();
		}
		abscheck(&e2);
		if (e2.e_addr & ~0x07) {
			aerr();
			e2.e_addr &= 0x07;
		}
		if (is_abs(&e1)) {
			r_mode = R_MBRO | R_8BIT;
		} else {
			r_mode = R_PAG0 | R_8BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 8));
		break;

	case S_LIT:			/* inst k */
		t1 = addr(&e1);		/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		outrwm(&e1, R_8BIT, op);
		break;

	case S_CALL:			/* inst k */
	case S_GOTO:			/* inst k */
		t1 = addr(&e1);		/* k */
		if (t1 != S_EXT) {
			aerr();
		}
		outrwm(&e1, R_13BIT, op);
		break;

	case S_LCALL:			/* inst k */
		t1 = addr(&e1);		/* k */
		if (t1 != S_EXT) {
			aerr();
		}
		outrwm(&e1, R_8BIT, op);
		break;

	case S_MOVLB:			/* movlb k */
		t1 = addr(&e1);		/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		outrwm(&e1, R_4BTB, op);
		break;

	case S_MOVLR:			/* movlr k */
		t1 = addr(&e1);		/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		outrwm(&e1, R_4BTR, op);
		break;

	case S_MOVFP:			/* movfp f,p */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* p */
		if ((t2 != S_DIR) && (t2 != S_EXT)) {
			aerr();
		}
		abscheck(&e2);
		if (e2.e_addr & ~0x1F) {
			aerr();
			e2.e_addr &= 0x1F;
		}
		if (is_abs(&e1)) {
			r_mode = R_MBRO | R_8BIT;
		} else {
			r_mode = R_PAG0 | R_8BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 8));
		break;

	case S_MOVPF:			/* movpf p,f */
		t2 = addr(&e2);		/* p */
		if ((t2 != S_DIR) && (t2 != S_EXT)) {
			aerr();
		}
		abscheck(&e2);
		if (e2.e_addr & ~0x1F) {
			aerr();
			e2.e_addr &= 0x1F;
		}
		comma();
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		if (is_abs(&e1)) {
			r_mode = R_MBRO | R_8BIT;
		} else {
			r_mode = R_PAG0 | R_8BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 8));
		break;

	case S_TF:			/* inst t,f */
		t1 = addr(&e1);		/* t */
		abscheck(&e1);
		if (e1.e_addr & ~0x01) {
			aerr();
			e1.e_addr &= 0x01;
		}
		comma();
		t2 = addr(&e2);		/* f */
		if ((t2 != S_DIR) && (t2 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e2)) {
			aerr();
		}
		if (is_abs(&e2)) {
			r_mode = R_MBRO | R_8BIT;
		} else {
			r_mode = R_PAG0 | R_8BIT;
		}
		outrwm(&e2, r_mode, op + (e1.e_addr << 9));
		break;

	case S_TIF:			/* inst t,i,f */
		t1 = addr(&e1);		/* t */
		abscheck(&e1);
		if (e1.e_addr & ~0x01) {
			aerr();
			e1.e_addr &= 0x01;
		}
		comma();
		t2 = addr(&e2);		/* i */
		abscheck(&e2);
		if (e2.e_addr & ~0x01) {
			aerr();
			e2.e_addr &= 0x01;
		}
		comma();
		t3 = addr(&e3);		/* f */
		if ((t3 != S_DIR) && (t3 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e3)) {
			aerr();
		}
		if (is_abs(&e3)) {
			r_mode = R_MBRO | R_8BIT;
		} else {
			r_mode = R_PAG0 | R_8BIT;
		}
		outrwm(&e3, r_mode, op + (e1.e_addr << 9) + (e2.e_addr << 8));
		break;


	case S_RET:			/* return, retfie */
	case S_INH:			/* inst */
		outaw(op);
		break;

	default:
		err('o');
		break;
	}
}


/*
 * PIC20BIT CPU Type
 */
VOID
pic20bit(mp)
struct mne *mp;
{
	int c, op;
	int v1;
	int t1, t2;
	int r_mode;
	struct expr e1, e2, e3;
	char id[NINPUT];
	struct area *espa;

	clrexpr(&e1);
	clrexpr(&e2);
	clrexpr(&e3);

	op = mp->m_valu;
	if (op == ~0) {			/* Undefined Instructions */
		err('o');
		op = 0;
	}
	switch (mp->m_type) {
	case S_SDMM:
		espa = NULL;
		if (more()) {
			expr(&e1, 0);
			if (e1.e_flag == 0 && e1.e_base.e_ap == NULL) {
				if (e1.e_addr & 0xFF) {
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

	case S_FW:			/* inst f,d(,a) */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* d */
		if (t2 == S_WREG) {
			e2.e_addr = 0;
		} else
		if (t2 == S_FREG) {
			e2.e_addr = 1;
		} else {
			abscheck(&e2);
			if (e2.e_addr & ~0x01) {
				aerr();
				e2.e_addr &= 0x01;
			}
			if (t2 == S_DIR) {
				aerr();
			}
		}
		if (more()) {
			comma();
			expr(&e3, 0);	/* a */
			abscheck(&e3);
			if (e3.e_addr & ~0x01) {
				aerr();
				e3.e_addr &= 0x01;
			}
			if (is_abs(&e1)) {
				/*
				 * With Force Access Bank
				 * if e1.e_addr is not in the range
				 * 0x00-0x7F or 0xF80-0xFFF
				 * report an error.
				 */
				if (e3.e_addr == 0) {
					if (((e1.e_addr & ~0x7F) != 0x000) &&
					    ((e1.e_addr & ~0x7F) != 0xF80)) {
						aerr();
					}
				}
			}
		} else {
			if (is_abs(&e1)) {
				/*
				 * If e_addr is in the range
				 * 0x00-0x7F or 0xF80-0xFFF
				 * then a = 0.  Force Access Bank.
				 */
				if (((e1.e_addr & ~0x7F) == 0x000) ||
				    ((e1.e_addr & ~0x7F) == 0xF80)) {
					e3.e_addr = 0;
				/*
				 * Else use Bank Select Register (BSR).
				 */
				} else {
					e3.e_addr = 1;
				}
			} else {
				e3.e_addr = 1;
			}
		}
		/*
		 * Bank Select Register Mode
		 */
		if (e3.e_addr) {
			r_mode = R_PAGN | R_8BIT;
			mchdpm(&e1);
		/*
		 * Force Access Bank Mode
		 */
		} else {
			r_mode = R_8BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 9) + (e3.e_addr << 8));
		break;

	case S_CLRF:			/* clrf f(,a) */
	case S_SETF:			/* setf f(,a) */
	case S_F:			/* inst f(,a) */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		if (more()) {
			comma();
			expr(&e2, 0);	/* a */
			abscheck(&e2);
			if (e2.e_addr & ~0x01) {
				aerr();
				e2.e_addr &= 0x01;
			}
			if (is_abs(&e1)) {
				/*
				 * With Force Access Bank
				 * if e1.e_addr is not in the range
				 * 0x00-0x7F or 0xF80-0xFFF
				 * report an error.
				 */
				if (e2.e_addr == 0) {
					if (((e1.e_addr & ~0x7F) != 0x000) &&
					    ((e1.e_addr & ~0x7F) != 0xF80)) {
						aerr();
					}
				}
			}
		} else {
			if (is_abs(&e1)) {
				/*
				 * If e_addr is in the range
				 * 0x00-0x7F or 0xF80-0xFFF
				 * then a = 0.  Force Access Bank.
				 */
				if (((e1.e_addr & ~0x7F) == 0x000) ||
				    ((e1.e_addr & ~0x7F) == 0xF80)) {
					e2.e_addr = 0;
				/*
				 * Else use Bank Select Register (BSR).
				 */
				} else {
					e2.e_addr = 1;
				}
			} else {
				e2.e_addr = 1;
			}
		}
		/*
		 * Bank Select Register Mode
		 */
		if (e2.e_addr) {
			r_mode = R_PAGN | R_8BIT;
			mchdpm(&e1);
		/*
		 * Force Access Bank Mode
		 */
		} else {
			r_mode = R_8BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 8));
		break;

	case S_FBIT:			/* inst f,b(,a) */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* b */
		if ((t2 != S_IMMED) && (t2 != S_EXT)) {
			aerr();
		}
		abscheck(&e2);
		if (e2.e_addr & ~0x07) {
			aerr();
			e2.e_addr &= 0x07;
		}
		if (more()) {
			comma();
			expr(&e3, 0);	/* a */
			abscheck(&e3);
			if (e3.e_addr & ~0x01) {
				aerr();
				e3.e_addr &= 0x01;
			}
			if (is_abs(&e1)) {
				/*
				 * With Force Access Bank
				 * if e1.e_addr is not in the range
				 * 0x00-0x7F or 0xF80-0xFFF
				 * report an error.
				 */
				if (e3.e_addr == 0) {
					if (((e1.e_addr & ~0x7F) != 0x000) &&
					    ((e1.e_addr & ~0x7F) != 0xF80)) {
						aerr();
					}
				}
			}
		} else {
			if (is_abs(&e1)) {
				/*
				 * If e_addr is in the range
				 * 0x00-0x7F or 0xF80-0xFFF
				 * then a = 0.  Force Access Bank.
				 */
				if (((e1.e_addr & ~0x7F) == 0x000) ||
				    ((e1.e_addr & ~0x7F) == 0xF80)) {
					e3.e_addr = 0;
				/*
				 * Else use Bank Select Register (BSR).
				 */
				} else {
					e3.e_addr = 1;
				}
			} else {
				e3.e_addr = 1;
			}
		}
		/*
		 * Bank Select Register Mode
		 */
		if (e3.e_addr) {
			r_mode = R_PAGN | R_8BIT;
			mchdpm(&e1);
		/*
		 * Force Access Bank Mode
		 */
		} else {
			r_mode = R_8BIT;
		}
		outrwm(&e1, r_mode, op + (e2.e_addr << 9) + (e3.e_addr << 8));
		break;

	case S_LIT:			/* inst k */
		t1 = addr(&e1);		/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		outrwm(&e1, R_8BIT, op);
		break;

	case S_CALL:			/* call k */
		t1 = addr(&e1);		/* k */
		if (t1 != S_EXT) {
			aerr();
		}
		if (more()) {
			comma();
			expr(&e2, 0);	/* s */
			abscheck(&e2);
			if (e2.e_addr & ~0x01) {
				aerr();
				e2.e_addr &= 0x01;
			}
		} else {
			e2.e_addr = 0;
		}
		outr4bm(&e1, R_20BIT, ((op + (e2.e_addr << 8)) << 16) + 0xF000);
		break;

	case S_GOTO:			/* goto k */
		t1 = addr(&e1);		/* k */
		if (t1 != S_EXT) {
			aerr();
		}
		outr4bm(&e1, R_20BIT, ((op << 16) + 0xF000));
		break;

	case S_BRA:			/* bra */
		/* Relative branch */
		expr(&e1, 0);
		if (mchpcr(&e1)) {
			v1 = e1.e_addr - dot.s_addr - 1;
			if ((v1 < -1024) || (v1 > 1023))
				aerr();
			outaw(op + (v1 & 0x3FF));
		} else {
			outrwm(&e1, R_PCR | R_11BIT, op);
		}
		if (e1.e_mode != S_USER) {
			rerr();
		}
		break;

	case S_CBRA:			/* Conditional branches */
		/* Relative branch */
		expr(&e1, 0);
		if (mchpcr(&e1)) {
			v1 = e1.e_addr - dot.s_addr - 1;
			if ((v1 < -128) || (v1 > 127))
				aerr();
			outaw(op + (v1 & 0xFF));
		} else {
			outrwm(&e1, R_PCR | R_8BIT, op);
		}
		if (e1.e_mode != S_USER) {
			rerr();
		}
		break;

	case S_MOVLB:			/* movlb k */
		t1 = addr(&e1);		/* k */
		if ((t1 != S_IMMED) && (t1 != S_EXT)) {
			aerr();
		}
		outrwm(&e1, R_8BIT, op);
		break;

	case S_LFSR:			/* lfsr f,k */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		abscheck(&e1);
		if ((e1.e_addr & ~0x03) || (e1.e_addr == 3)) {
			aerr();
			e1.e_addr = 0x00;
		}
		comma();
		t2 = addr(&e2);		/* k */
		if (t2 != S_EXT) {
			aerr();
		}
		r_mode = is_abs(&e2) ? R_MBRO | R_LFSR : R_PAG0 | R_LFSR;
		outr4bm(&e2, r_mode, ((op + (e1.e_addr << 4)) << 16) | 0xF000);
		break;

	case S_MOVFF:			/* movff f,f */
		t1 = addr(&e1);		/* f */
		if ((t1 != S_DIR) && (t1 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e1)) {
			aerr();
		}
		comma();
		t2 = addr(&e2);		/* f */
		if ((t2 != S_DIR) && (t2 != S_EXT)) {
			aerr();
		}
		if (mchramchk(&e2)) {
			aerr();
		}
		outrwm(&e1, R_12BIT | R_MBRO, op);
		outrwm(&e2, R_12BIT | R_MBRO, 0xF000);
		break;

	case S_TBL:			/* tblrd/tblwt '*','*+','*-','+*'  */
		if ((c=get()) == '*') {
			if ((c = get()) == '+') {
				op += 1;
			} else
			if (c == '-') {
				op += 2;
			} else
			if ((c != ' ') && (c != '\t') && (c != ';')) {
				unget(c);
				unget('*');
			}
		} else
		if (c == '+') {
			if ((c = get()) == '*') {
				op += 3;
			} else {
				unget(c);
				unget('+');
			}
		} else {
			unget(c);
		}
		outaw(op);
		break;


	case S_RET:			/* return, retfie */
		if (more()) {
			expr(&e1, 0);   /* s */
			abscheck(&e1);
			if (e1.e_addr & ~0x01) {
				aerr();
				e1.e_addr &= 0x01;
			}
		} else {
			e1.e_addr = 0;
		}
		outaw(op + e1.e_addr);
		break;;

	case S_DAW:			/* daw */
	case S_INH:			/* inst */
		outaw(op);
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
 * Direct Page Map
 */
VOID
mchdpm(esp)
register struct expr *esp;
{
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
}

/*
 * Machine Ram Check
 */
int
mchramchk(esp)
register struct expr *esp;
{
	struct badram *brp;

	if (is_abs(esp)) {
		brp = br;
		while (brp != NULL) {
			if ((brp->b_lo <= esp->e_addr) &&
			    (esp->e_addr <= brp->b_hi)) {
				return(1);
			}
			brp = brp->b_badram;
		}
	}
	return(0);
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
 * Machine specific initialization
 */

VOID
minit()
{
	exprmasks(2);
	if (pass == 0) {
		br = NULL;
	}
	pic_type = 0;
	pic_fsr = ~0;
}


/* ds8adr.c */

/*
 * Modified from i51adr.c
 * Bill McKinnon
 * w_mckinnon@conknet.com
 *
 * (C) Copyright 1998-2001
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 *
 *	This Assember Ported by
 *	John L. Hartman	(JLH)
 *	jhartman@compuserve.com
 *
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "ds8.h"


struct adsym reg51[] = {	/* R0 thru R7 registers */
    {	"R0",	R0	},
    {	"R1",	R1	},
    {	"R2",	R2	},
    {	"R3",	R3	},
    {	"R4",	R4	},
    {	"R5",	R5	},
    {	"R6",	R6	},
    {	"R7",	R7	},
    {	"A",	A	},
    {	"DPTR", DPTR	},
    {	"PC",	PC	},
    {	"C",	C	},
    {	"AB",	AB	},
    {	"",	0x00	}
};

/*  Classify argument as to address mode */
int
addr(esp)
register struct expr *esp;
{
	register int c;
	register unsigned rd;

	if ((c = getnb()) == '#') {
		/*  Immediate mode */
		expr(esp, 0);
		esp->e_mode = S_IMMED;
	} 
	else if (c == '@') {
		/* choices are @R0, @R1, @DPTR, @A+PC, @A+DPTR */
		switch (reg()) {
		case R0:
			esp->e_mode = S_AT_R;
			esp->e_addr = R0;
			break;
		case R1:
			esp->e_mode = S_AT_R;
			esp->e_addr = R1;
			break;
		case DPTR:
			esp->e_mode = S_AT_DP;
			esp->e_addr = DPTR;
			break;
		case A:
			if (getnb() == '+') {
				rd = reg();
				if (rd == PC) {
					esp->e_mode = S_AT_APC;
					esp->e_addr = 0;
				} else if (rd == DPTR) {
					esp->e_mode = S_AT_ADP;
					esp->e_addr = 0;
				} else {
					aerr();
				}
			} else
				aerr();
			break;
		}

		esp->e_flag = 0;
		esp->e_base.e_ap = NULL;
	} 
	else if (c == '*') {
		if ((c = getnb()) == '/') {
			/* Force inverted bit */
			expr(esp, 0);
			esp->e_mode = S_NOT_BIT;
		} else {
			unget(c);
			/* Force direct page */
			expr(esp, 0);
			esp->e_mode = S_DIR;
		}
		if (esp->e_addr & ~0xFF)
			err('d');
	} 
	else if (c == '/') {
		/* Force inverted bit  */
		expr(esp, 0);
		esp->e_mode = S_NOT_BIT;
		if (esp->e_addr & ~0xFF)
			err('d');
	} 
	else {
		unget(c);

		/* try for register: A, AB, R0-R7, DPTR, PC, Cy */
		if ((esp->e_addr = admode(reg51)) != -1) {
			switch (esp->e_addr) {
			case A:
				esp->e_mode = S_A;
				break;
			case AB:
				esp->e_mode = S_RAB;
				break;
			case DPTR:
				esp->e_mode = S_DPTR;
				break;
			case PC:
				esp->e_mode = S_PC;
				break;
			case C:
				esp->e_mode = S_C;
				break;
			default:
				/* R0-R7 */
				esp->e_mode = S_REG;
			}
		} else {
			/* Must be an expression */
			expr(esp, 0);
			if ((!esp->e_flag)
				&& (esp->e_base.e_ap==NULL)
				&& !(esp->e_addr & ~0xFF)) {
				esp->e_mode = S_DIR;
			} else {
				esp->e_mode = S_EXT;
			}
		}
	}
	return (esp->e_mode);
}
	
/*
 * Enter admode() to search a specific addressing mode table
 * for a match. Return the addressing value on a match or
 * -1 for no match.
 */
int
admode(sp)
register struct adsym *sp;
{
	register char *ptr;
	register int i;
	unget(getnb());
	i = 0;
	while ( *(ptr = &sp[i].a_str[0]) ) {
		if (srch(ptr)) {
			return(sp[i].a_val);
		}
		i++;
	}
	return(-1);
}

/*
 *	srch --- does string match ?
 */
int
srch(str)
register char *str;
{
	register char *ptr;
	ptr = ip;

	while (*ptr && *str) {
		if(ccase[*ptr & 0x007F] != ccase[*str & 0x007F])
			break;
		ptr++;
		str++;
	}
	if (ccase[*ptr & 0x007F] == ccase[*str & 0x007F]) {
		ip = ptr;
		return(1);
	}

	if (!*str)
		if (any(*ptr," \t\n,];")) {
			ip = ptr;
			return(1);
		}
	return(0);
}

/*
 *	any --- does str contain c?
 */
int
any(c,str)
int c;
char *str;
{
	while (*str)
		if(*str++ == c)
			return(1);
	return(0);
}

/*
 * Read a register name.  Return register value, -1 if no register found
 */
int
reg()
{
	register struct mne *mp;
	char id[NCPS];

	getid(id, -1);
	if ((mp = mlookup(id))==NULL) {
		aerr();
		return (-1);
	}
	switch (mp->m_type) {
	case S_A:
	case S_AB:
	case S_DPTR:
	case S_PC:
	case S_REG:
		return (mp->m_valu);

	default:
		return (-1);
	}
}

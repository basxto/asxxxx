/* m74adr.c */

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

int
addr(esp)
register struct expr *esp;
{
	register int c, d;
	register char *p;

	/*
	 * Immediate Mode
	 */
	if ((c = getnb()) == '#') {
		expr(esp, 0);
		esp->e_mode = S_IMMED;

	/*
	 * Special Page Mode
	 */
	} else if (c == '\\') {
		expr(esp, 0);
		esp->e_mode = S_SPEC;

	/*
	 * Explicit Direct Page Mode
	 */
	} else if (c == '*') {
		expr(esp, 0);
		esp->e_mode = S_ZP;
		if ((!esp->e_flag)
		    && (esp->e_base.e_ap==NULL)
			&& (esp->e_addr & ~0xFF))
			    err('d');
		
		/*
		 * Direct Page Mode with Indexing
		 */
		if (more()) {
			comma();
			switch(admode(axy)) {
			case S_X:
				esp->e_mode = S_ZPX;
				break;
			case S_Y:
				esp->e_mode = S_ZPY;
				break;
			default:
				aerr();
			}
		}

	/*
	 * Indirect Modes
	 */
	} else if (c == '[') {
		if ((d = getnb()) != '*') {
			unget(d);
		}
		expr(esp, 0);
		if ((c = getnb()) == ']') {
			if (more()) {
				comma();
				if (admode(axy) != S_Y)
					qerr();
				esp->e_mode = S_INDY;
			} else if (d == '*' || zpage(esp)) {
				esp->e_mode = S_ZIND;
			} else {
				esp->e_mode = S_IND;
			}
		} else {
			unget(c);
			comma();
			if (admode(axy) != S_X)
				qerr();
			esp->e_mode = S_INDX;
			if (getnb() != ']')
				qerr();
		}

	/*
	 * Find modes not explicitly defined by #, *, \, or [.
	 */
	} else {
		unget(c);
		switch(admode(axy)) {
		case S_A:
			esp->e_mode = S_ACC;
			break;
		case S_X:
		case S_Y:
			aerr();
			break;
		default:
			if (more()) {
				expr(esp, 0);
				if (more()) {
					p = ip;
					comma();
					esp->e_mode = 0;
					switch(admode(axy)) {
					/*
					 * nn,X
					 */
					case S_X:
						/*
						 * Assume * was forgotten
						 */
						if (zpage(esp)) {
							esp->e_mode = S_ZPX;
						} else {
							esp->e_mode = S_ABSX;
						}
						break;
					/*
					 * nn,Y
					 */
					case S_Y:
						/*
						 * Assume * was forgotten
						 */
						if (zpage(esp)) {
							esp->e_mode = S_ZPY;
						} else {
							esp->e_mode = S_ABSY;
						}
						break;
					/*
					 * nn,A
					 */
					case S_A:
						esp->e_mode = S_NBITA;
						break;

					default:
						ip = p;
						esp->e_mode = S_NBIT;
						break;
					}
				} else {
					/*
					 * nn
					 */
					if (zpage(esp)) {
						esp->e_mode = S_ZP;
					} else {
						esp->e_mode = S_ABS;
					}
				}
			} else {
				qerr();
			}
		}
	}
	return (esp->e_mode);
}

/*
 * Enter admode() to search a specific addressing mode table
 * for a match. Return the addressing value on a match or
 * zero for no match.
 */
int
admode(sp)
register struct adsym *sp;
{
	register char *ptr;
	register int i;
	register char *ips;

	ips = ip;
	unget(getnb());

	i = 0;
	while ( *(ptr = &sp[i].a_str[0]) ) {
		if (srch(ptr)) {
			return(sp[i].a_val);
		}
		i++;
	}
	ip = ips;
	return(0);
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

struct adsym	axy[] = {		/* a, x, or y registers*/
	{	"a",	S_A	},
	{	"x",	S_X	},
	{	"y",	S_Y	},
	{	"",	0x00	}
};

/*
 *	zpage --- check for direct page address equivalent
 */
int zpage(esp)
register struct expr *esp;
{
	return((!esp->e_flag) && (esp->e_base.e_ap==NULL) && !(esp->e_addr & ~0xFF));
}

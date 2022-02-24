/* r65adr.c */

/*
 * (C) Copyright 1995
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*
 * With Contributions from
 *
 * Marko Makela
 * Sillitie 10 A
 * 01480 Vantaa
 * Finland
 * Internet: Marko.Makela@Helsinki.Fi
 * EARN/BitNet: msmakela@finuh
 */

#include <stdio.h>
#include <setjmp.h>
#include "asm.h"
#include "r6500.h"

int
addr(esp)
register struct expr *esp;
{
	register c;

	if ((c = getnb()) == '#') {
		expr(esp, 0);
		esp->e_mode = S_IMMED;
	} else if (c == '*') {
		expr(esp, 0);
		esp->e_mode = S_DIR;
		if ((!esp->e_flag)
		    && (esp->e_base.e_ap==NULL)
			&& (esp->e_addr & ~0xFF))
			    err('d');
		if (more()) {
			comma();
			switch(admode(axy)) {
			case S_X:
				esp->e_mode = S_DINDX;
				break;
			case S_Y:
				esp->e_mode = S_DINDY;
				break;
			default:
				aerr();
			}
		}
	} else if (c == '[') {
		if ((c = getnb()) != '*') {
			unget(c);
		}
		expr(esp, 0);
		if ((c = getnb()) == ']') {
			if (more()) {
				comma();
				if (admode(axy) != S_Y)
					qerr();
				esp->e_mode = S_IPSTY;
			} else {
				esp->e_mode = S_IND;
			}
		} else {
			unget(c);
			comma();
			if (admode(axy) != S_X)
				qerr();
			esp->e_mode = S_IPREX;
			if (getnb() != ']')
				qerr();
		}
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
			if (!more()) {
			    esp->e_mode = S_ACC;
			} else {
			    expr(esp, 0);
			    if (more()) {
				comma();
				switch(admode(axy)) {
				case S_X:
					if ((!esp->e_flag)
					    && (esp->e_base.e_ap==NULL)
						&& !(esp->e_addr & ~0xFF)) {
						esp->e_mode = S_DINDX;
					} else {
						esp->e_mode = S_INDX;
					}
					break;
				case S_Y:
					if ((!esp->e_flag)
					    && (esp->e_base.e_ap==NULL)
						&& !(esp->e_addr & ~0xFF)) {
						esp->e_mode = S_DINDY;
					} else {
						esp->e_mode = S_INDY;
					}
					break;
				default:
					aerr();
					break;
				}
			    } else {
				if ((!esp->e_flag)
					&& (esp->e_base.e_ap==NULL)
					&& !(esp->e_addr & ~0xFF)) {
					esp->e_mode = S_DIR;
				} else {
					esp->e_mode = S_EXT;
				}
			    }
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
	unget(getnb());
	i = 0;
	while ( *(ptr = (char *) &sp[i]) ) {
		if (srch(ptr)) {
			return(sp[i].a_val);
		}
		i++;
	}
	return(0);
}

/*
 *      srch --- does string match ?
 */
int
srch(str)
register char *str;
{
	register char *ptr;
	ptr = ip;

#if	CASE_SENSITIVE
	while (*ptr && *str) {
		if(*ptr != *str)
			break;
		ptr++;
		str++;
	}
	if (*ptr == *str) {
		ip = ptr;
		return(1);
	}
#else
	while (*ptr && *str) {
		if(ccase[*ptr] != ccase[*str])
			break;
		ptr++;
		str++;
	}
	if (ccase[*ptr] == ccase[*str]) {
		ip = ptr;
		return(1);
	}
#endif

	if (!*str)
		if (any(*ptr," \t\n,];")) {
			ip = ptr;
			return(1);
		}
	return(0);
}

/*
 *      any --- does str contain c?
 */
int
any(c,str)
char    c, *str;
{
	while (*str)
		if(*str++ == c)
			return(1);
	return(0);
}

struct adsym	axy[] = {	/* a, x, or y registers */
	"a",	S_A,
	"x",    S_X,
	"y",    S_Y,
	"",	0x00
};

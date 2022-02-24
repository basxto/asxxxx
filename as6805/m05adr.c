/* m05adr.c */

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

int
addr(esp)
register struct expr *esp;
{
	register c;
	register struct area *espa;

	if ((c = getnb()) == '#') {
		expr(esp, 0);
		esp->e_mode = S_IMMED;
	} else if (c == ',') {
		if ((c = admode(ax)) != S_X)
			aerr();
		esp->e_mode = S_IX;
		esp->e_flag = 0;
		esp->e_addr = 0;
		esp->e_base.e_ap = NULL;
	} else if (c == '*') {
		expr(esp, 0);
		esp->e_mode = S_DIR;
		espa = esp->e_base.e_ap;
		if (esp->e_addr & ~0xFF)
			aerr();
		if (espa && espa != sdp->s_area)
			rerr();
		if (more()) {
			comma();
			if (admode(ax) == S_X)
				esp->e_mode = S_DIRX;
		}
	} else {
		unget(c);
		if (esp->e_mode = admode(ax)) {
			;
		} else {
			expr(esp, 0);
			if (more()) {
				comma();
				espa = esp->e_base.e_ap;
				if (esp->e_flag ||
				    esp->e_addr & ~0xFF ||
				   (espa && espa != sdp->s_area)) {
					esp->e_mode = S_INDX;
				} else {
					esp->e_mode = S_DIRX;
				}
				if (admode(ax) != S_X)
					aerr();
			} else {
				if ( !esp->e_base.e_ap &&
				    !(esp->e_addr & ~0xFF)) {
					esp->e_mode = S_DIR;
				} else {
					esp->e_mode = S_EXT;
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
	while ( *(ptr = (char *) &sp[i].a_str) ) {
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

struct adsym	ax[] = {	/* a or x registers */
	"a",	S_A,
	"x",	S_X,
	"",	0x00
};

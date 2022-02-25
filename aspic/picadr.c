/* picadr.c */

/*
 * (C) Copyright 2001-2006
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include "asxxxx.h"
#include "pic.h"


struct adsym regfw[] = {	/* f and w */
    {	"f",	S_FREG	},
    {	"w",	S_WREG	},
    {	"",	0x00	}
};

/*  Classify argument as to address mode */
int
addr(esp)
struct expr *esp;
{
	int c;

	if ((c = getnb()) == '#') {
		/*  Immediate mode */
		expr(esp, 0);
		esp->e_mode = S_IMMED;
	} else
	if (c == '*') {
		/* Force direct page */
		expr(esp, 0);
		esp->e_mode = S_DIR;
	} else {
		unget(c);
		/* try for register: f or w */
		if ((c = admode(regfw)) != -1) {
			esp->e_mode = c;
		} else {
			/* Must be an expression */
			expr(esp, 0);
			esp->e_mode = S_EXT;
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
struct adsym *sp;
{
	char *ptr;
	int i;
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
char *str;
{
	char *ptr;
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



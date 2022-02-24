/* aslex.c */

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

VOID
getid(id, c)
register c;
char *id;
{
	register char *p;

	if (c < 0) {
		c = getnb();
		if (ctype[c] != LETTER)
			qerr();
	}
	p = id;
	do {
		if (p < &id[NCPS])
			*p++ = c;
	} while (ctype[c=get()] == LETTER || ctype[c] == DIGIT);
	unget(c);
	while (p < &id[NCPS])
		*p++ = 0;
}

char
getnb()
{
	register c;

	while ((c=get()) == ' ' || c == '\t')
		;
	return (c);
}

char
get()
{
	register c;

	if (c = *ip)
		++ip;
	return (c);
}

VOID
unget(c)
{
	if (c)
		--ip;
}

char
getmap(d)
{
	register c, n, v;

	if ((c=get()) == '\0')
		qerr();
	if (c == d)
		return (-1);
	if (c == '\\') {
		c = get();
		switch (c) {

		case 'b':
			c = '\b';
			break;

		case 'f':
			c = '\f';
			break;

		case 'n':
			c = '\n';
			break;

		case 'r':
			c = '\r';
			break;

		case 't':
			c = '\t';
			break;

		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
			n = 0;
			v = 0;
			while (++n<=3 && c>='0' && c<='7') {
				v = (v<<3) + c - '0';
				c = get();
			}
			unget(c);
			c = v;
			break;
		}
	}
	return (c);
}

int
getline()
{
loop:	if (incfil >= 0) {
		if (fgets(ib, sizeof ib, ifp[incfil]) == NULL) {
			fclose(ifp[incfil--]);
			lop = NLPP;
			goto loop;
		}
		ib[strlen(ib) - 1] = 0;
		return(1);
	}
	if (fgets(ib, sizeof ib, sfp[cfile]) == NULL) {
		if (++cfile <= inpfil)
			goto loop;
		return (0);
	}
	ib[strlen(ib) - 1] = 0;
	return (1);
}

int
more()
{
	register c;

	c = getnb();
	unget(c);
	return( (c == '\0' || c == ';') ? 0 : 1 );
}

char
endline()
{
	register c;

	c = getnb();
	return( (c == '\0' || c == ';') ? 0 : c );
}

/* s6186adr.c */

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


/*  Classify argument as to address mode */
int
addr(esp)
register struct expr *esp;
{
	register int c;

	if ((c = getnb()) == '#') {
		/*  Immediate mode */
		expr(esp, 0);
		esp->e_mode = S_IMM;
	} else {
		unget(c);
		/* Must be an expression */
		expr(esp, 0);
		esp->e_mode = S_EXT;
	}
	return (esp->e_mode);
}
	


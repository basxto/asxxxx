/* lkrloc.c */

/*
 * (C) Copyright 1989
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include "aslink.h"


/*
 * Process relocation operations
 * and call designated output routine
 */
VOID
reloc(c)
char c;
{
	if (oflag == 0)
		return;

	switch(c) {

	case 'T':
		relt();
		break;

	case 'R':
		relr();
		break;

	case 'E':
		rele();
		break;

	default:
		fprintf(stderr, "Undefined Relocation Operation\n");
		break;

	}
}


/*
 * Relocation 'T' processing.
 */
VOID
relt()
{
	rtcnt = 0;
	while (more()) {
		if (rtcnt < NTXT) {
			rtval[rtcnt++] = eval();
		}
	}
}

/*
 * Relocation 'R' processing
 */
VOID
relr()
{
	register pc, relv, index;
	int mode, rtp;
	struct areax **a;
	struct sym **s;

	if (eval() != (R_WORD | R_AREA) || eval())
		fprintf(stderr, "R input error\n");

	/*
	 * Get area and symbol lists
	 */
	a = (struct areax **) hp->a_list;
	s = (struct sym **) hp->s_list;

	/*
	 * Get area pointer
	 */
	index = evword();
	if (index >= hp->h_narea) {
		fprintf(stderr, "R area error\n");
		return;
	}

	/*
	 * Relocate address
	 */
	pc = add_w(a[index]->a_addr, 0);

	/*
	 * Do remaining relocations
	 */
	while (more()) {
		mode = eval();
		rtp = eval();
		index = evword();

		/*
		 * R_SYM or R_AREA references
		 */
		if (mode & R_SYM) {
			if (index >= hp->h_nglob) {
				fprintf(stderr, "R symbol error\n");
				return;
			}
			relv = symval(s[index]);
		} else {
			if (index >= hp->h_narea) {
				fprintf(stderr, "R area error\n");
				return;
			}
			relv = a[index]->a_addr;
		}

		/*
		 * R_PCR or R_NORM addressing
		 */
		if (mode & R_PCR) {
			if (mode & R_BYTE) {
				relv -= (pc + (rtp-2) + 1);
			} else {
				relv -= (pc + (rtp-2) + 2);
			}
		}

		/*
		 * R_BYTE or R_WORD operation
		 */
		if (mode & R_BYTE) {
			add_b(relv, rtp);
		} else {
			add_w(relv, rtp);
		}
	}
	if (oflag == 1) {
		ihx(1);
	} else
	if (oflag == 2) {
		s19(1);
	}
}

/*
 * EOF processing
 */
VOID
rele()
{
	if (oflag == 1) {
		ihx(0);
	} else
	if (oflag == 2) {
		s19(0);
	}
}

/*
 * Evaluate word
 */
int
evword()
{
	register v;

	if (hilo) {
		v = (eval() << 8);
		v += eval();
	} else {
		v = eval();
		v += (eval() << 8);
	}
	return(v);
}

/*
 * Add byte values
 */
int
add_b(v, i)
register v, i;
{
	rtval[i] += v;
	return(rtval[i] &= 0xff);
}

/*
 * Add word values
 */
int
add_w(v, i)
register v, i;
{
	register j;

	if (hilo) {
		j = v + (rtval[i] << 8) + (rtval[i+1] & 0xff);
		rtval[i] = (j >> 8) & 0xff;
		rtval[i+1] = j & 0xff;
	} else {
		j = v + (rtval[i] & 0xff) + (rtval[i+1] << 8);
		rtval[i] = j & 0xff;
		rtval[i+1] = (j >> 8) & 0xff;
	}
	return(j);
}


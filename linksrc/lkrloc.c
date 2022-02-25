/* lkrloc.c */

/*
 * (C) Copyright 1989-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 *
 *   With enhancements from:
 *
 *	John L. Hartman	(JLH)
 *	jhartman@compuserve.com
 *
 *	Bill McKinnon (BM)
 *	w_mckinnon@conknet.com
 */

#include <stdio.h>
#include <string.h>

#ifdef WIN32
#include <stdlib.h>
#else
#include <alloc.h>
#endif

#include "aslink.h"

/*)Module	lkrloc.c
 *
 *	The module lkrloc.c contains the functions which
 *	perform the relocation calculations.
 *
 *	lkrloc.c contains the following functions:
 *		a_uint	adb_1b()
 *		a_uint	adb_2b()
 *		a_uint	adb_3b()
 *		a_uint	adb_4b()
 *		a_uint	adb_xb()
 *		a_uint	adw_xb()
 *		a_uint	evword()
 *		VOID	prntval()
 *		VOID	reloc()
 *
 *	lkrloc.c the local variable errmsg[].
 *
 */

/*)Function	VOID	reloc(c)
 *
 *		int c			process code
 *
 *	The function reloc() calls the proper version
 *	of the linker code.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		ASxxxx_VERSION		ASxxxx REL file version
 *
 *	called functions:
 *		VOID	reloc3()	lkrloc3.c
 *		VOID	reloc4()	lkrloc4.c
 *
 *	side effects:
 *		Refer to the called relocation functions.
 *
 */

VOID
reloc(c)
int c;
{
	switch(ASxxxx_VERSION) {
	case 3:
		reloc3(c);
		break;

	case 4:
		reloc4(c);
		break;

	default:
		fprintf(stderr, "Internal Version Error");
		lkexit(ER_FATAL);
		break;
	}
}


/*)Function	a_uint 	evword()
 *
 *	The function evword() combines two byte values
 *	into a single word value.
 *
 *	local variable:
 *		a_uint	v		temporary evaluation variable
 *
 *	global variables:
 *		hilo			byte ordering parameter
 *
 *	called functions:
 *		int	eval()		lkeval.c
 *
 *	side effects:
 *		Relocation text line is scanned to combine
 *		two byte values into a single word value.
 *
 */

a_uint
evword()
{
	register a_uint v;

	if (hilo) {
		v =  (eval() << 8);
		v +=  eval();
	} else {
		v =   eval();
		v += (eval() << 8);
	}
	return(v);
}

/*)Function	a_uint 	adb_1b(v, i)
 *
 *		int	v		value to add to byte
 *		int	i		rtval[] index
 *
 *	The function adb_1b() adds the value of v to
 *	the single byte value contained in rtval[i].
 *	The new value of rtval[i] is returned.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		none
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The byte value of rtval[] is changed.
 *
 */

a_uint
adb_1b(v, i)
register a_uint v;
register int i;
{
	return(rtval[i] += v);
}

/*)Function	a_uint 	adb_2b(v, i)
 *
 *		int	v		value to add to word
 *		int	i		rtval[] index
 *
 *	The function adb_2b() adds the value of v to the
 *	2 byte value contained in rtval[i] and rtval[i+1].
 *	The new value of rtval[i] / rtval[i+1] is returned.
 *
 *	local variable:
 *		a_uint	j		temporary evaluation variable
 *
 *	global variables:
 *		hilo			byte ordering parameter
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The 2 byte value of rtval[] is changed.
 *
 */

a_uint
adb_2b(v, i)
register a_uint v;
register int i;
{
	register a_uint j;

	if (hilo) {
		j = v + (rtval[i] << 8) +
			(rtval[i+1] & 0xff);
		rtval[i] = (j >> 8) & 0xff;
		rtval[i+1] = j & 0xff;
	} else {
		j = v + (rtval[i] & 0xff) +
			(rtval[i+1] << 8);
		rtval[i] = j & 0xff;
		rtval[i+1] = (j >> 8) & 0xff;
	}
	return(j);
}

/*)Function	a_uint 	adb_3b(v, i)
 *
 *		int	v		value to add to word
 *		int	i		rtval[] index
 *
 *	The function adb_3b() adds the value of v to the
 *	three byte value contained in rtval[i], rtval[i+1], and rtval[i+2].
 *	The new value of rtval[i] / rtval[i+1] / rtval[i+2] is returned.
 *
 *	local variable:
 *		a_uint	j		temporary evaluation variable
 *
 *	global variables:
 *		hilo			byte ordering parameter
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The 3 byte value of rtval[] is changed.
 *
 */

a_uint
adb_3b(v, i)
register a_uint v;
register int i;
{
	register a_uint j;

	if (hilo) {
		j = v + (((rtval[i] << 16) & 0xff0000) +
			 ((rtval[i+1] << 8 ) & 0xff00) +
			 ((rtval[i+2]) & 0xff));
		rtval[i] = (j >> 16) & 0xff;
		rtval[i+1] = (j >> 8) & 0xff;
		rtval[i+2] = j & 0xff;
	} else {
		j = v + (((rtval[i+2] << 16) & 0xff0000) +
			 ((rtval[i+1] << 8 ) & 0xff00) +
			 ((rtval[i]) & 0xff));
		rtval[i] = j & 0xff;
		rtval[i+1] = (j >> 8) & 0xff;
		rtval[i+2] = (j >> 16) & 0xff;
    }
    return(j);
}

/*)Function	a_uint 	adb_4b(v, i)
 *
 *		int	v		value to add to word
 *		int	i		rtval[] index
 *
 *	The function adb_4b() adds the value of v to the
 *	four byte value contained in rtval[i], ..., rtval[i+3].
 *	The new value of rtval[i], ...,  rtval[i+3] is returned.
 *
 *	local variable:
 *		a_uint	j		temporary evaluation variable
 *
 *	global variables:
 *		hilo			byte ordering parameter
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The 4 byte value of rtval[] is changed.
 *
 */

a_uint
adb_4b(v, i)
register a_uint v;
register int i;
{
	register a_uint j;

	if (hilo) {
		j = v + (((rtval[i] << 24) & 0xff000000) +
			 ((rtval[i+1] << 16) & 0xff0000) +
			 ((rtval[i+2] << 8 ) & 0xff00) +
			 ((rtval[i+3]) & 0xff));
		rtval[i] = (j >> 24) & 0xff;
		rtval[i+1] = (j >> 16) & 0xff;
		rtval[i+2] = (j >> 8) & 0xff;
		rtval[i+3] = j & 0xff;
	} else {
		j = v + (((rtval[i+3] << 24) & 0xff000000) +
			 ((rtval[i+2] << 16) & 0xff0000) +
			 ((rtval[i+1] << 8 ) & 0xff00) +
			 ((rtval[i]) & 0xff));
		rtval[i] = j & 0xff;
		rtval[i+1] = (j >> 8) & 0xff;
		rtval[i+2] = (j >> 16) & 0xff;
		rtval[i+3] = (j >> 24) & 0xff;
    }
    return(j);
}

/*)Function	a_uint 	adb_xb(v, i)
 *
 *		int	v		value to add to x-bytes
 *		int	i		rtval[] index
 *
 *	The function adx_x() adds the value of v to
 *	the value contained in rtval[i] for x-bytes.
 *	The new value of rtval[i] for x-bytes is returned.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	a_bytes		T Line Address Bytes
 *
 *	called functions:
 *		a_uint	adb_1b()	lkrloc.c
 *		a_uint	adb_2b()	lkrloc.c
 *		a_uint	adb_3b()	lkrloc.c
 *		a_uint	adb_4b()	lkrloc.c
 *
 *	side effects:
 *		The x-byte value of rtval[] is changed.
 *
 */

a_uint
adb_xb(v, i)
register a_uint v;
register int i;
{
	a_uint j;

	switch(a_bytes){
	case 1:
		j = adb_1b(v, i);
		return(j & 0x80 ? j | ~0x7F : j & 0x7F);
	case 2:
		j = adb_2b(v, i);
		return(j & 0x8000 ? j | ~0x7FFF : j & 0x7FFF);
	case 3:
		j = adb_3b(v, i);
		return(j & 0x800000 ? j | ~0x7FFFFF : j & 0x7FFFFF);
	case 4:
		j = adb_4b(v, i);
		return(j & 0x80000000 ? j | ~0x7FFFFFFF : j & 0x7FFFFFFF);
	default:
		return(0);
	}
	return(0);
}

/*)Function	a_uint 	adw_xb(x, v, i)
 *
 *		int	x		number of bytes to allow
 *		int	v		value to add to byte
 *		int	i		rtval[] index
 *
 *	The function adw_xb() adds the value of v to the
 *	value contained in rtval[i] through rtval[i + a_bytes - 1].
 *	The new value of rtval[i] .... is returned.
 *	The rtflg[] is cleared for bytes of higher order than x.
 *
 *	local variable:
 *		a_uint	j		temporary evaluation variable
 *
 *	global variables:
 *		int	a_bytes		T line byte count
 *		int	hilo		byte ordering parameter
 *		int	rtflg[]		output byte flags
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The value of rtval[] is changed.
 *		The rtflg[] values corresponding to all bytes
 *		of higher order than x are cleared to reflect
 *		the fact that x bytes are selected.
 *
 */

a_uint
adw_xb(x, v, i)
int x;
a_uint v;
int i;
{
	register a_uint j;
	register int n;

	j = adb_xb(v, i);
	/*
	 * X LS Bytes
	 */
	i += (hilo ? 0 : x);
	for (n=0; n<(a_bytes-x); n++,i++) {
		rtflg[i] = 0;
	}
	return (j);
}

/*)Function	VOID	prntval(fptr, v)
 *
 *		FILE	*fptr		output file handle
 *		a_uint	v		value to output
 *
 *	The function prntval() outputs the value v, in the
 *	currently selected radix, to the device specified
 *	by fptr.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	xflag		current radix
 *
 *	called functions:
 *		int	fprintf()	c_library
 *
 *	side effects:
 *		none
 *
 */

VOID
prntval(fptr, v)
FILE *fptr;
a_uint v;
{
	register char *frmt;

	switch(xflag) {
	default:
	case 0:
		switch(a_bytes) {
		default:
		case 2: frmt = "       %04X\n"; break;
		case 3: frmt = "     %06X\n"; break;
		case 4: frmt = "   %08X\n"; break;
		}
		break;
	case 1:
		switch(a_bytes) {
		default:
		case 2: frmt = "     %06o\n"; break;
		case 3: frmt = "   %08o\n"; break;
		case 4: frmt = "%011o\n"; break;
		}
		break;
	case 2:
		switch(a_bytes) {
		default:
		case 2: frmt = "      %05u\n"; break;
		case 3: frmt = "   %08u\n"; break;
		case 4: frmt = " %010u\n"; break;
		}
		break;
	}
	fprintf(fptr, frmt, v & a_mask);
}



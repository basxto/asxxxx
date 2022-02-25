/* lkrloc4.c */

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

/*)Module	lkrloc4.c
 *
 *	The module lkrloc4.c contains the functions which
 *	perform the version 4 relocation calculations.
 *
 *	lkrloc.c contains the following functions:
 *		a_uint	adb_byte()
 *		VOID	erpdmp4()
 *		VOID	errdmp4()
 *		a_uint	gtb_1b()
 *		a_uint	gtb_2b()
 *		a_uint	gtb_3b()
 *		a_uint	gtb_4b()
 *		a_uint	gtb_xb()
 *		VOID	lkmerge()
 *		a_uint	ptb_1b()
 *		a_uint	ptb_2b()
 *		a_uint	ptb_3b()
 *		a_uint	ptb_4b()
 *		a_uint	ptb_xb()
 *		VOID	rele4()
 *		VOID	relerr4()
 *		VOID	relerp4()
 *		VOID	reloc4()
 *		VOID	relp4()
 *		VOID	relr4()
 *		VOID	relt4()
 *
 *	lkrloc4.c the local variable errmsg4[].
 *
 */

/*)Function	VOID	reloc4(c)
 *
 *		int c			process code
 *
 *	The function reloc4() calls a particular relocation
 *	function determined by the process code.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	lkerr		error flag
 *
 *	called functions:
 *		int	fprintf()	c_library
 *		VOID	rele4()		lkrloc4.c
 *		VOID	relp4()		lkrloc4.c
 *		VOID	relr4()		lkrloc4.c
 *		VOId	relt4()		lkrloc4.c
 *
 *	side effects:
 *		Refer to the called relocation functions.
 *
 */

VOID
reloc4(c)
int c;
{
	switch(c) {

	case 'T':
		relt4();
		break;

	case 'R':
		relr4();
		break;

	case 'P':
		relp4();
		break;

	case 'E':
		rele4();
		break;

	default:
		fprintf(stderr, "Undefined Relocation Operation\n");
		lkerr++;
		break;

	}
}


/*)Function	VOID	relt4()
 *
 *	The function relt4() evaluates a T line read by
 *	the linker. Each byte value read is saved in the
 *	rtval[] array, rtflg[] is set, and the number of
 *	evaluations is maintained in rtcnt.
 *
 *		T Line
 *
 *		T xx xx nn nn nn nn nn ...
 *
 *
 *		In:	"T n0 n1 n2 n3 ... nn"
 *
 *		Out:	  0    1    2    ..  rtcnt
 *			+----+----+----+----+----+
 *		  rtval | n0 | n1 | n2 | .. | nn |
 *			+----+----+----+----+----+
 *		  rtflag|  1 |  1 |  1 |  1 |  1 |
 *			+----+----+----+----+----+
 *
 * 	The  T  line contains the assembled code output by the assem-
 *	bler with xx xx being the offset address from the  current  area
 *	base address and nn being the assembled instructions and data in
 *	byte format.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	rtcnt		number of values evaluated
 *		int	rtflg[]		array of evaluation flags
 *		int	rtval[]		array of evaluation values
 *
 *	called functions:
 *		int	eval()		lkeval.c
 *		int	more()		lklex.c
 *
 *	side effects:
 *		Linker input T line evaluated.
 *
 */

VOID
relt4()
{
	rtcnt = 0;
	while (more()) {
		if (rtcnt < NTXT) {
			rtval[rtcnt] = eval();
			rtflg[rtcnt] = 1;
			rterr[rtcnt] = 0;
			rtcnt++;
		}
	}
}

/*)Function	VOID	relr4()
 *
 *	The function relr4() evaluates a R line read by
 *	the linker.  The R line data is combined with the
 *	previous T line data to perform the relocation of
 *	code and data bytes.  The S19 / IHX output and
 *	translation of the LST files to RST files may be
 *	performed.
 *
 *		R Line
 *
 *		R 0 0 nn nn n1 n2 xx xx ...
 *
 * 	The R line provides the relocation information to the linker.
 *	The nn nn value is the current area index, i.e.  which area  the
 *	current  values  were  assembled.  Relocation information is en-
 *	coded in groups of 4 bytes:  
 *
 *	1.  n1 is the relocation mode and object format 
 *	 	1.  bits <1:0> specify the number of bytes to output) 
 *	 	2.  bit 2 signed(0x00)/unsigned(0x04) byte data 
 *		3.  bit 3 normal(0x00)/MSB(0x08) of value (2nd byte)
 *	 	4.  bit 4 normal(0x00)/page '0'(0x10) reference 
 *	 	5.  bit 5 normal(0x00)/page 'nnn'(0x20) reference
 *			PAGX mode if both bits are set
 *	 	6.  bit 6 normal(0x00)/PC relative(0x40) relocation 
 *	 	7.  bit 7 relocatable area(0x00)/symbol(0x80) 
 *
 *	2.  n2 is a byte index and merge mode index
 *		1.  bits <3:0> are a byte index into the corresponding
 *			(i.e.  preceeding) T line data (i.e.  a pointer to
 *			the data to be updated  by  the  relocation).
 *		2.  bits <7:4> are an index into a selected merge mode.
 *			Currently mode 0 simply specifies to use standard
 *			byte addressing modes and merging is ignored.
 *
 *	3.  xx xx  is the area/symbol index for the area/symbol be-
 *	 	ing referenced.  the corresponding area/symbol is found
 *		in the header area/symbol lists.  
 *
 *
 *	The groups of 4 bytes are repeated for each item requiring relo-
 *	cation in the preceeding T line.  
 *
 *
 *	local variable:
 *		areax	**a		pointer to array of area pointers
 *		int	aindex		area index
 *		int	argb		argument byte count
 *		int	argm		argument byte mode
 *		char	*errmsg4[]	array of pointers to error strings
 *		int	error		error code
 *		int	m_page	        merge mode page mask
 *		int	mode		relocation mode
 *		int	m		signed value mask
 *		int	n		unsigned value mask
 *		adrr_t	paga		paging base area address
 *		a_uint	pags		paging symbol address
 *		a_uint	pagx		extended paging address
 *		int	pcrv		pcr mode value
 *		a_uint	reli		relocation initial value
 *		a_uint	relv		relocation final value
 *		int	rindex		symbol / area index
 *		a_uint	rtbase		base code address
 *		a_uint	rtofst		rtval[] index offset
 *		a_uint	rtpofst		rtval[] index offset (initial)
 *		int	rtp		index into T data
 *		int	rxm	        merge mode index
 *		sym	**s		pointer to array of symbol pointers
 *		int	v		temporary
 *
 *	global variables:
 *		int	a_bytes		T Line Address Bytes
 *		area	*ap	        pointer to the area structure
 *		head	*hp		pointer to the head structure
 *		int	lkerr		error flag
 *		int	oflag		output type flag
 *		FILE	*ofp	        object output file handle
 *		a_uint	pc		relocated base address
 *		int	pcb	        bytes per instruction word
 *		rerr	rerr		linker error structure
 *		bank	*rtabnk	        current bank structure
 *		int	rtaflg		current bank structure flags
 *		struct	sdp		paging structure
 *		FILE	*stderr		standard error device
 *		int	uflag		relocation listing flag
 *
 *	called functions:
 *		a_uint	adb_1b()	lkrloc.c
 *		a_uint	adb_2b()	lkrloc.c
 *		a_uint	adb_xb()	lkrloc.c
 *		a_uint	adb_byte()	lkrloc4.c
 *		a_uint	evword()	lkrloc.c
 *		int	eval()		lkeval.c
 *		int	fprintf()	c_library
 *		VOID	lkout()		lkout.c
 *		VOID	lkulist		lklist.c
 *		int	more()		lklex.c
 *		VOID	relerr4()	lkrloc4.c
 *		int	symval()	lksym.c
 *
 *	side effects:
 *		The R and T lines are combined to produce
 *		relocated code and data.  Output Sxx / Ixx
 *		and relocated listing files may be produced.
 *
 */

VOID
relr4()
{
	register a_uint reli, relv;
	register int mode;
	a_uint rtbase, rtofst, rtpofst, paga, pags, pagx, m, m_page;
	int aindex, argb, argm, rindex, rtp, rxm, error, v, pcrv, n;
	struct areax **a;
	struct sym **s;

	/*
	 * Get area and symbol lists
	 */
	a = hp->a_list;
	s = hp->s_list;

	/*
	 * Verify Area Mode
	 */
	if (eval() != R4_AREA || eval()) {
		fprintf(stderr, "R input error\n");
		lkerr++;
		return;
	}

	/*
	 * Get area pointer
	 */
	aindex = evword();
	if (aindex >= hp->h_narea) {
		fprintf(stderr, "R area error\n");
		lkerr++;
		return;
	}

	/*
	 * Select Output File
	 */
	if (oflag) {
		ap = a[aindex]->a_bap;
		if (ofp != NULL) {
			rtabnk->b_rtaflg = rtaflg;
			if (ofp != ap->a_ofp) {
				lkflush();
			}
		}
		ofp = ap->a_ofp;
		rtabnk = ap->a_bp;
		rtaflg = rtabnk->b_rtaflg;
	}

	/*
	 * Base values:
	 *	rtbase is the base address from the T line
	 *	rtofst is the number of T line data bytes
	 *		discarded during processing
	 *	
	 */
	rtbase = adb_xb(0, 0);
	rtofst = a_bytes;

	/*
	 * Relocate address
	 */
	pc  = adb_xb(a[aindex]->a_addr, 0);

	/*
	 * Number of 'bytes' per PC address
	 */
	pcb = 1 + (A4_WLMSK & a[aindex]->a_bap->a_flag);

	/*
	 * Do remaining relocations
	 */
	while (more()) {
		error = 0;
		relv = 0;
		rtpofst = rtofst;
		mode = eval();
		rtp = eval();
		rindex = evword();

		/*
		 * Argument Mode
		 */
		argm = (mode & R4_BYTES);
		/*
		 * Bytes in Argument
		 */
		argb = 1 + argm;

		/*
		 * Merge Mode Value
		 */
		rxm = (rtp >> 4) & 0x0F;
		/*
		 * Index to Data
		 */
		rtp &= 0x0F;

		/*
		 * R4_SYM or R4_AREA references
		 */
		if (mode & R4_SYM) {
			if (rindex >= hp->h_nsym) {
				fprintf(stderr, "R symbol error\n");
				lkerr++;
				return;
			}
			reli = symval(s[rindex]);
		} else {
			if (rindex >= hp->h_narea) {
				fprintf(stderr, "R area error\n");
				lkerr++;
				return;
			}
			reli = a[rindex]->a_addr;
		}

		/*
		 * Standard Modes
		 */
		if (rxm == 0) {
			/*
			 * PAGE addressing and
			 * PCR  addressing
			 */
			paga = 0;
			pags = 0;

			pcrv  = rtp - rtofst;

			switch(mode & (R4_PCR | R4_PBITS)) {
			/*
			 * Default PCR mode assumes the PC Value
			 * used for relocation follows the opcode
			 * and offset argument.
			 */
			case R4_PCR:
			case R4_PCRN:
				pcrv  = (pcrv + argb) / pcb;
				reli -= (pc + pcrv);
				break;
			/*
			 * Specific PCR mode offsets for the
			 * PC value from the offset location.
			 */
			case R4_PCR4:
			case R4_PCR4N:	pcrv += 1;
			case R4_PCR3:
			case R4_PCR3N:	pcrv += 1;
			case R4_PCR2:
			case R4_PCR2N:	pcrv += 1;
			case R4_PCR1:
			case R4_PCR1N:	pcrv += 1;
			case R4_PCR0:
			case R4_PCR0N:
				pcrv /=  pcb;
				reli -= (pc + pcrv);
				break;
			case R4_PAG0:
			case R4_PAGN:
				paga  = sdp.s_area->a_addr;
				pags  = sdp.s_addr;
				reli -= paga + pags;
				break;
			case R4_PAGX0:
			case R4_PAGX1:
			case R4_PAGX2:
			case R4_PAGX3:
			default:
				break;
			}

			/*
			 * R4_BYTE, R4_WORD, R4_3BYTE, and R4_4BYTE operations
			 */
			if ((mode & (R4_MSB | R4_PAGX | R4_PCR)) == R4_MSB) {
				relv = adb_byte(argm, reli, rtp);
				/*
				 * R4_MSB uses only 1 byte of data
				 * from a_bytes of data in the T line.
				 */
				rtofst += (a_bytes - 1);
			} else {
				relv = adw_xb(argb, reli, rtp);
				/*
				 * Normal modes use argb bytes of data
				 * from a_bytes of data in the T line.
				 */
				rtofst += (a_bytes - argb);
			}

			/*
			 * Mask Value Selection
			 */
			switch(argb) {
			default:
			case 1:	m = ~0x7F;		n = ~0xFF;		break;	/* 1 byte  */
			case 2:	m = ~0x7FFF;		n = ~0xFFFF;		break;	/* 2 bytes */
			case 3:	m = ~0x7FFFFF;		n = ~0xFFFFFF;		break;	/* 3 bytes */
			case 4:	m = ~0x7FFFFFFF;	n = ~0xFFFFFFFF;	break;	/* 4 bytes */
			}

			/*
			 * Signed Value Checking
			 */
			if (((mode & (R4_SGND | R4_USGN | R4_PAGX | R4_PCR)) == R4_SGND) &&
			   ((relv & m) != m) && ((relv & m) != 0))
				error = 1;

			/*
			 * Unsigned Value Checking
			 */
			if (((mode & (R4_SGND | R4_USGN | R4_PAGX | R4_PCR)) == R4_USGN) &&
			   ((relv & n) != 0))
				error = 2;

			/*
			 * PCR  Relocation Error Checking
			 */
			switch(mode & (R4_PCR | R4_PBITS)) {
			case R4_PCR4:
			case R4_PCR3:
			case R4_PCR2:
			case R4_PCR1:
			case R4_PCR0:
			case R4_PCR:
				v = relv;
				switch(argm) {
				default:
				case R4_1BYTE:
					if ((v < ~0x7F) || (v > 0x7F))
						error = 3;
					break;
				case R4_2BYTE:
					if ((v < ~0x7FFF) || (v > 0x7FFF))
						error = 4;
					break;
				case R4_3BYTE:
					if ((v < ~0x7FFFFF) || (v > 0x7FFFFF))
						error = 5;
					break;
				case R4_4BYTE:
					if ((v < ~0x7FFFFFFF) || (v > 0x7FFFFFFF))
						error = 6;
					break;
				}
				break;
			case R4_PAG0:
				if (relv & ~0xFF || paga || pags)
					error = 7;
				break;
			case R4_PAGN:
				if (relv & ~0xFF)
					error = 8;
				break;
			case R4_PAGX0:	/* Paged from pc + 0 */
			case R4_PAGX1:	/* Paged from pc + 1 */
			case R4_PAGX2:	/* Paged from pc + 2 */
			case R4_PAGX3:	/* Paged from pc + 3 */
				m_page = ~hp->m_list[rxm]->m_page;
				pcrv = pc + ((rtp - rtofst) / pcb);
				switch(mode & (R4_PCR | R4_PBITS)) {
				case R4_PAGX3:	pcrv += 1;	/* Paged from pc + 3 */
				case R4_PAGX2:	pcrv += 1;	/* Paged from pc + 2 */
				case R4_PAGX1:	pcrv += 1;	/* Paged from pc + 1 */
				case R4_PAGX0:			/* Paged from pc + 0 */
				default:
					break;
				}
				pagx = pcrv & m_page;
				/*
				 * Paging Error if:
				 *     Destination Page != Current Page
				 */
				if ((relv & m_page) != pagx)
					error = 9;
				break;
			default:
				break;
			}
		/*
		 * Merge Mode Processing
		 */
		} else {
			/*
			 * PAGE addressing and
			 * PCR  addressing
			 */
			paga = 0;
			pags = 0;

			pcrv  = rtp - rtofst;

			switch(mode & (R4_PCR | R4_PBITS)) {
			/*
			 * Default PCR mode assumes the PC Value
			 * used for relocation follows the opcode
			 * and offset argument.
			 */
			case R4_PCR:
			case R4_PCRN:
				pcrv  = (pcrv + argb) / pcb;
				reli -= (pc + pcrv);
				break;
			/*
			 * Specific PCR mode offsets for the
			 * PC value from the offset location.
			 */
			case R4_PCR4:
			case R4_PCR4N:	pcrv += 1;
			case R4_PCR3:
			case R4_PCR3N:	pcrv += 1;
			case R4_PCR2:
			case R4_PCR2N:	pcrv += 1;
			case R4_PCR1:
			case R4_PCR1N:	pcrv += 1;
			case R4_PCR0:
			case R4_PCR0N:
				pcrv /=  pcb;
				reli -= (pc + pcrv);
				break;
			case R4_PAG0:
			case R4_PAGN:
				paga  = sdp.s_area->a_addr;
				pags  = sdp.s_addr;
				reli -= paga + pags;
				break;
			case R4_PAGX0:
			case R4_PAGX1:
			case R4_PAGX2:
			case R4_PAGX3:
			default:
				break;
			}

			/*
			 * R4_BYTE, R4_WORD, R4_3BYTE, and R4_4BYTE operations
			 */
			if ((mode & (R4_MSB | R4_PAGX | R4_PCR)) == R4_MSB) {
				relv = adb_byte(argm, reli, rtp);
			} else {
				relv = adw_xb(argb, reli, rtp);
			}

			/*
			 * The Merge Mode inserts a_bytes into
			 * the T line data which is discarded.
			 */
			for (v=0; v<a_bytes; v++) {
				rtflg[rtp + v] = 0;
			}
			rtofst += a_bytes;
			/*
			 * Fixup the index to the next data.
			 */
			rtp += a_bytes;
			rtpofst += a_bytes;

			v = gtb_xb(rtp);
			v = lkmerge(relv, rxm, v);
			ptb_xb(0 , rtp);
			adw_xb(argb, v, rtp);

			m_page = ~(hp->m_list[rxm]->m_page >> 1);

			/*
			 * Signed Merge Bit Range Checking
			 */
			if (((mode & (R4_SGND | R4_USGN | R4_PAGX | R4_PCR)) == R4_SGND) &&
			   ((relv & m_page) != m_page) && ((relv & m_page) != 0))
				error = 10;

			m_page = ~hp->m_list[rxm]->m_page;

			/*
			 * Unsigned Merge Bit Range Checking
			 * Overflow Merge Bit Range Checking
			 */
			if (((mode & (R4_SGND | R4_USGN | R4_PAGX | R4_PCR)) == R4_USGN) &&
			   (relv & m_page))
				error = 11;

			/*
			 * PCR  Relocation Error Checking
			 */
			switch(mode & (R4_PCR | R4_PBITS)) {
			case R4_PCR4:
			case R4_PCR3:
			case R4_PCR2:
			case R4_PCR1:
			case R4_PCR0:
			case R4_PCR:
				v = relv;
				pcrv = ~m_page >> 1;
				if ((v < ~pcrv) || (v > pcrv)) {
					error = 2 + argm;
				}
				break;
			case R4_PAG0:
				if (relv & m_page || paga || pags)
					error = 7;
				break;
			case R4_PAGN:
				if (relv & m_page)
					error = 8;
				break;
			case R4_PAGX3:	/* Paged from pc + 3 */
			case R4_PAGX0:	/* Paged from pc + 0 */
			case R4_PAGX1:	/* Paged from pc + 1 */
			case R4_PAGX2:	/* Paged from pc + 2 */
				pcrv = pc + (pcrv / pcb);
				switch(mode & (R4_PCR | R4_PBITS)) {
				case R4_PAGX3:	pcrv += 1;	/* Paged from pc + 3 */
				case R4_PAGX2:	pcrv += 1;	/* Paged from pc + 2 */
				case R4_PAGX1:	pcrv += 1;	/* Paged from pc + 1 */
				case R4_PAGX0:			/* Paged from pc + 0 */
				default:
					break;
				}
				pagx = pcrv & m_page;
				/*
				 * Paging Error if:
				 *     Destination Page != Current Page
				 */
				if ((relv & m_page) != pagx)
					error = 9;
				break;
			default:
				break;
			}
		}

		/*
		 * Error Processing
		 */
		if (error) {
			rerr.aindex = aindex;
			rerr.mode = mode;
			rerr.rtbase = rtbase + ((rtp - rtpofst) / pcb);
			rerr.rindex = rindex;
			rerr.rval = relv - reli;
			relerr4(errmsg4[error]);

			for (v=rtp; v<rtp+a_bytes-1; v++) {
				if (rtflg[v]) {
					rterr[v] = error;
					break;
				}
			}
		}
	}
	if (uflag != 0) {
		lkulist(1);
	}
	if (oflag != 0) {
		lkout(1);
	}
}

char *errmsg4[] = {
/* 0 */	"LKRLOC Error List",
/* 1 */	"Signed value error",
/* 2 */	"Unsigned value error",
/* 3 */	"Byte PCR relocation error",
/* 4 */	"Word PCR relocation error",
/* 5 */	"3-Byte PCR relocation error",
/* 6 */	"4-Byte PCR relocation error",
/* 7 */	"Page0 relocation error",
/* 8 */	"PageN relocation error",
/* 9 */	"PageX relocation error",
/*10 */	"Signed Merge Bit Range error",
/*11 */	"Unsigned/Overflow Merge Bit Range error",
/*12 */	"Undefined Extended Mode error"
};


/*)Function	VOID	relp4()
 *
 *	The function relp4() evaluates a P line read by
 *	the linker.  The P line data is combined with the
 *	previous T line data to set the base page address
 *	and test the paging boundary and length.
 *
 *		P Line
 *
 *		P 0 0 nn nn n1 n2 xx xx
 *
 * 	The  P  line provides the paging information to the linker as
 *	specified by a .setdp directive.  The format of  the  relocation
 *	information is identical to that of the R line.  The correspond-
 *	ing T line has the following information:
 *		T xx xx aa aa bb bb
 *
 * 	Where  aa aa is the area reference number which specifies the
 *	selected page area and bb bb is the base address  of  the  page.
 *	bb bb will require relocation processing if the 'n1 n2 xx xx' is
 *	specified in the P line.  The linker will verify that  the  base
 *	address is on a 256 byte boundary and that the page length of an
 *	area defined with the PAG type is not larger than 256 bytes.
 *
 *	local variable:
 *		areax	**a		pointer to array of area pointers
 *		int	aindex		area index
 *		int	mode		relocation mode
 *		a_uint	relv		relocation value
 *		int	rindex		symbol / area index
 *		int	rtp		index into T data
 *		sym	**s		pointer to array of symbol pointers
 *
 *	global variables:
 *		head	*hp		pointer to the head structure
 *		int	lkerr		error flag
 *		sdp	sdp		base page structure
 *		FILE	*stderr		standard error device
 *
 *	called functions:
 *		a_uint	adb_2b()	lkrloc.c
 *		a_uint	evword()	lkrloc.c
 *		int	eval()		lkeval.c
 *		int	fprintf()	c_library
 *		int	more()		lklex.c
 *		int	symval()	lksym.c
 *
 *	side effects:
 *		The P and T lines are combined to set
 *		the base page address and report any
 *		paging errors.
 *
 */

VOID
relp4()
{
	register int aindex, rindex;
	int mode, rtp;
	a_uint relv;
	struct areax **a;
	struct sym **s;

	/*
	 * Get area and symbol lists
	 */
	a = hp->a_list;
	s = hp->s_list;

	/*
	 * Verify Area Mode
	 */
	if ((eval() != R4_AREA) || eval()) {
		fprintf(stderr, "P input error\n");
		lkerr++;
	}

	/*
	 * Get area pointer
	 */
	aindex = evword();
	if (aindex >= hp->h_narea) {
		fprintf(stderr, "P area error\n");
		lkerr++;
		return;
	}

	/*
	 * Do remaining relocations
	 */
	while (more()) {
		mode = eval();
		rtp = eval();
		rindex = evword();

		/*
		 * R4_SYM or R4_AREA references
		 */
		if (mode & R4_SYM) {
			if (rindex >= hp->h_nsym) {
				fprintf(stderr, "P symbol error\n");
				lkerr++;
				return;
			}
			relv = symval(s[rindex]);
		} else {
			if (rindex >= hp->h_narea) {
				fprintf(stderr, "P area error\n");
				lkerr++;
				return;
			}
			relv = a[rindex]->a_addr;
		}
		adb_xb(relv, rtp);
	}

	/*
	 * Paged values
	 */
	aindex = adb_xb(0,a_bytes);
	if (aindex >= hp->h_narea) {
		fprintf(stderr, "P area error\n");
		lkerr++;
		return;
	}
	sdp.s_areax = a[aindex];
	sdp.s_area = sdp.s_areax->a_bap;
	sdp.s_addr = adb_xb(0,a_bytes*2);
	if (sdp.s_area->a_addr & 0xFF || sdp.s_addr & 0xFF)
		relerp4("Page Definition Boundary Error");
}

/*)Function	VOID	rele4()
 *
 *	The function rele4() closes all open output files
 *	at the end of the linking process.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	oflag		output type flag
 *		int	uflag		relocation listing flag
 *
 *	called functions:
 *		VOID	lkfclose()	lkbank.c
 *		VOID	lkflush()	lkout.c
 *		VOID	lkulist()	lklist.c
 *
 *	side effects:
 *		All open output files are closed.
 *
 */

VOID
rele4()
{
	if (uflag != 0) {
		lkulist(0);
	}
	if (oflag != 0) {
		lkflush();
		lkfclose();
	}
}

/*)Function	VOID	relerr4(str)
 *
 *		char	*str		error string
 *
 *	The function relerr4() outputs the error string to
 *	stderr and to the map file (if it is open).
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		FILE	*mfp		handle for the map file
 *
 *	called functions:
 *		VOID	errdmp4()	lkrloc4.c
 *
 *	side effects:
 *		Error message inserted into map file.
 *
 */

VOID
relerr4(str)
char *str;
{
	errdmp4(stderr, str);
	if (mfp)
		errdmp4(mfp, str);
}

/*)Function	VOID	errdmp4(fptr, str)
 *
 *		FILE	*fptr		output file handle
 *		char	*str		error string
 *
 *	The function errdmp4() outputs the error string str
 *	to the device specified by fptr.  Additional information
 *	is output about the definition and referencing of
 *	the symbol / area error.
 *
 *	local variable:
 *		int	mode		error mode
 *		int	aindex		area index
 *		int	lkerr		error flag
 *		int	rindex		error index
 *		sym	**s		pointer to array of symbol pointers
 *		areax	**a		pointer to array of area pointers
 *		areax	*raxp		error area extension pointer
 *
 *	global variables:
 *		sdp	sdp		base page structure
 *
 *	called functions:
 *		int	fprintf()	c_library
 *		VOID	prntval()	lkrloc.c
 *
 *	side effects:
 *		Error reported.
 *
 */

VOID
errdmp4(fptr, str)
FILE *fptr;
char *str;
{
	int mode, aindex, rindex;
	struct sym **s;
	struct areax **a;
	struct areax *raxp;

	a = hp->a_list;
	s = hp->s_list;

	mode = rerr.mode;
	aindex = rerr.aindex;
	rindex = rerr.rindex;

	/*
	 * Print Error
	 */
	fprintf(fptr, "\n?ASlink-Warning-%s", str);
	lkerr++;

	/*
	 * Print symbol if symbol based
	 */
	if (mode & R4_SYM) {
		fprintf(fptr, " for symbol  %s\n",
			&s[rindex]->s_id[0]);
	} else {
		fprintf(fptr, "\n");
	}

	/*
	 * Print Ref Info
	 */
/*         11111111112222222222333333333344444444445555555555666666666677777*/
/*12345678901234567890123456789012345678901234567890123456789012345678901234*/
/*        |                 |                 |                 |           */
	fprintf(fptr,
"         file              module            area                   offset\n");
	fprintf(fptr,
"  Refby  %-14.14s    %-14.14s    %-14.14s    ",
			hp->h_lfile->f_idp,
			&hp->m_id[0],
			&a[aindex]->a_bap->a_id[0]);
	prntval(fptr, rerr.rtbase);

	/*
	 * Print Def Info
	 */
	if (mode & R4_SYM) {
		raxp = s[rindex]->s_axp;
	} else {
		raxp = a[rindex];
	}
/*         11111111112222222222333333333344444444445555555555666666666677777*/
/*12345678901234567890123456789012345678901234567890123456789012345678901234*/
/*        |                 |                 |                 |           */
	fprintf(fptr,
"  Defin  %-14.14s    %-14.14s    %-14.14s    ",
			raxp->a_bhp->h_lfile->f_idp,
			&raxp->a_bhp->m_id[0],
			&raxp->a_bap->a_id[0]);
	if (mode & R4_SYM) {
		prntval(fptr, s[rindex]->s_addr);
	} else {
		prntval(fptr, rerr.rval);
	}
}

/*)Function	VOID	relerp4(str)
 *
 *		char	*str		error string
 *
 *	The function relerp4() outputs the paging error string to
 *	stderr and to the map file (if it is open).
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		FILE	*mfp		handle for the map file
 *
 *	called functions:
 *		VOID	erpdmp4()	lkrloc4.c
 *
 *	side effects:
 *		Error message inserted into map file.
 *
 */

VOID
relerp4(str)
char *str;
{
	erpdmp4(stderr, str);
	if (mfp)
		erpdmp4(mfp, str);
}

/*)Function	VOID	erpdmp4(fptr, str)
 *
 *		FILE	*fptr		output file handle
 *		char	*str		error string
 *
 *	The function erpdmp4() outputs the error string str
 *	to the device specified by fptr.
 *
 *	local variable:
 *		head	*thp		pointer to head structure
 *
 *	global variables:
 *		int	lkerr		error flag
 *		sdp	sdp		base page structure
 *
 *	called functions:
 *		int	fprintf()	c_library
 *		VOID	prntval()	lkrloc.c
 *
 *	side effects:
 *		Error reported.
 *
 */

VOID
erpdmp4(fptr, str)
FILE *fptr;
char *str;
{
	register struct head *thp;

	thp = sdp.s_areax->a_bhp;

	/*
	 * Print Error
	 */
	fprintf(fptr, "\n?ASlink-Warning-%s\n", str);
	lkerr++;

	/*
	 * Print PgDef Info
	 */
/*         111111111122222222223333333333444444444455555555556666666666777*/
/*123456789012345678901234567890123456789012345678901234567890123456789012*/
	fprintf(fptr,
"         file              module            pgarea               pgoffset\n");
	fprintf(fptr,
"  PgDef  %-14.14s    %-14.14s    %-14.14s    ",
			thp->h_lfile->f_idp,
			&thp->m_id[0],
			&sdp.s_area->a_id[0]);
	prntval(fptr, sdp.s_area->a_addr + sdp.s_addr);
}

/*)Function	VOID	lkmerge(esp, r, v)
 *
 *		expr *	esp		pointer to expr structure
 *		int	r		relocation mode
 *		int	v		data to merge into
 *
 *	The function outrxbm() merges the data in the expr structure esp
 *	and the variable v using the merge specification coded in r.
 *
 *	local variables:
 *		struct	vsd *sdp	pointer to a merge specification structure
 *		char *	vp		pointer to the merge specification string
 *		int	i		loop counter
 *		int	j		temporary
 *		int	m		bit shuffled value
 *
 *	global variables:
 *		struct	vsd  *vsd[]	array of pointers to merge specification structures
 *		sym	dot		defined as sym[0]
 *		FILE	*stderr		error console
 *
 *	functions called:
 *		int	fprintf()	c_library
 *		VOID	asexit()	asmain.c
 *
 *	side effects:
 *		none
 */
int lkmerge(esp, r, v)
int esp;
int r;
int v;
{
	struct mode *mp;
	char *vp;
	int i, j, m;

	if ((mp = hp->m_list[r]) == NULL) {
		fprintf(stderr, "undefined G mode\n");
		lkexit(ER_FATAL);
	}

	if (mp->m_flag) {
		m  = 0;
		vp = mp->m_def;
		for (i=0; i<32; i++) {
			if ((j = (int) *vp++) & 0x80) {
				m |= (esp & (1 << i)) ? (1 << (j & 0x1F)) : 0;
			}
		}
	} else {
		m = esp;
	}
	return((v & ~mp->m_mask) | (m & mp->m_mask));
}

/*)Function	a_uint 	adb_byte(p, v, i)
 *
 *		int	p		byte select
 *		int	v		value to add to byte
 *		int	i		rtval[] index
 *
 *	The function adb_byte() adds the value of v to the
 *	value contained in rtval[i] through rtval[i + a_bytes - 1].
 *	The p'th byte of the new value of rtval[i] ... is returned.
 *	The rtflg[] flags are cleared for all rtval[i] ... except
 *	for the selected byte.
 *
 *	local variable:
 *		a_uint	j		temporary evaluation variable
 *		int	m		selected byte index
 *		int	n		loop counter
 *
 *	global variables:
 *		int	a_bytes		T line byte count
 *		int	hilo		byte ordering parameter
 *		int	rtflg[]		output byte flags
 *
 *	called functions:
 *		a_uint	adb_xb()	lkrloc.c
 *
 *	side effects:
 *		The value of rtval[] is changed.
 *		The rtflg[] values corresponding to all bytes
 *		except the selected byte of the value are cleared
 *		to reflect a single byte is selected.
 *
 */

a_uint
adb_byte(p, v, i)
int 	p;
a_uint	v;
int	i;
{
	register a_uint j;
	register int m, n;

	j = adb_xb(v, i);
	/*
	 * Select byte of data
	 */
	m = (hilo ? a_bytes-1-p : p);
	for (n=0; n<a_bytes; n++) {
		if(n != m) rtflg[i+n] = 0;
	}
	return (j >> (8 * p));
}

/*)Function	a_uint 	gtb_1b(i)
 *
 *		int	i		rtval[] index
 *
 *	The function gtb_1b() returns the single
 *	byte value contained in rtval[i].
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		a_uint	rtval[]		relocation data
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		none
 *
 */

a_uint
gtb_1b(i)
register int i;
{
	return(rtval[i]);
}

/*)Function	a_uint 	ptb_1b(v, i)
 *
 *		int	v		value to put
 *		int	i		rtval[] index
 *
 *	The function ptb_1b() places the byte value
 *	of v into a single byte in rtval[i].
 *	The new value of rtval[i] is returned.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		a_uint	rtval[]		relocation data
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The byte value of rtval[] is changed.
 *
 */

a_uint
ptb_1b(v, i)
register a_uint v;
register int i;
{
	return(rtval[i] = v & 0xFF);
}

/*)Function	a_uint 	gtb_2b(i)
 *
 *		int	i		rtval[] index
 *
 *	The function gtb_1b() returns the value of
 *	2 bytes contained in rtval[i].
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	hilo		byte ordering parameter
 *		a_uint	rtval[]		relocation data
 *		a_uint	v		evaluation temporary
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		none
 *
 */

a_uint
gtb_2b(i)
register int i;
{
	register a_uint v;

	if (hilo) {
		v = (rtval[i] << 8) +
		    (rtval[i+1] & 0xff);
	} else {
		v = (rtval[i] & 0xff) +
		    (rtval[i+1] << 8);
	}
	return(v);
}

/*)Function	a_uint 	ptb_2b(v, i)
 *
 *		int	v		value to put
 *		int	i		rtval[] index
 *
 *	The function ptb_1b() places the value
 *	of v into 2 bytes of rtval[i].
 *	The new value of rtval[i] is returned.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	hilo		byte ordering parameter
 *		a_uint	rtval[]		relocation data
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The value of rtval[] is changed.
 *
 */

a_uint
ptb_2b(v, i)
register a_uint v;
register int i;
{
	if (hilo) {
		rtval[i] = (v >> 8) & 0xff;
		rtval[i+1] = v & 0xff;
	} else {
		rtval[i] = v & 0xff;
		rtval[i+1] = (v >> 8) & 0xff;
	}
	return(v);
}

/*)Function	a_uint 	gtb_3b(i)
 *
 *		int	i		rtval[] index
 *
 *	The function gtb_1b() returns the value of
 *	3 bytes contained in rtval[i].
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	hilo		byte ordering parameter
 *		a_uint	rtval[]		relocation data
 *		a_uint	v		evaluation temporary
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		none
 *
 */

a_uint
gtb_3b(i)
register int i;
{
	register a_uint v;

	if (hilo) {
		v = (((rtval[i] << 16) & 0xff0000) +
		     ((rtval[i+1] << 8 ) & 0xff00) +
		     ((rtval[i+2]) & 0xff));
	} else {
		v = (((rtval[i+2] << 16) & 0xff0000) +
		     ((rtval[i+1] << 8 ) & 0xff00) +
		     ((rtval[i]) & 0xff));
	}
	return(v);
}

/*)Function	a_uint 	ptb_3b(v, i)
 *
 *		int	v		value to put
 *		int	i		rtval[] index
 *
 *	The function ptb_1b() places the value
 *	of v into 3 bytes of rtval[i].
 *	The new value of rtval[i] is returned.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	hilo		byte ordering parameter
 *		a_uint	rtval[]		relocation data
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The value of rtval[] is changed.
 *
 */

a_uint
ptb_3b(v, i)
register a_uint v;
register int i;
{
	if (hilo) {
		rtval[i] = (v >> 16) & 0xff;
		rtval[i+1] = (v >> 8) & 0xff;
		rtval[i+2] = v & 0xff;
	} else {
		rtval[i] = v & 0xff;
		rtval[i+1] = (v >> 8) & 0xff;
		rtval[i+2] = (v >> 16) & 0xff;
	}
	return(v);
}

/*)Function	a_uint 	gtb_4b(i)
 *
 *		int	i		rtval[] index
 *
 *	The function gtb_1b() returns the value of
 *	4 bytes contained in rtval[i].
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	hilo		byte ordering parameter
 *		a_uint	rtval[]		relocation data
 *		a_uint	v		evaluation temporary
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		none
 *
 */

a_uint
gtb_4b(i)
register int i;
{
	register a_uint v;

	if (hilo) {
		v = (((rtval[i] << 24) & 0xff000000) +
		     ((rtval[i+1] << 16) & 0xff0000) +
		     ((rtval[i+2] << 8 ) & 0xff00) +
		     ((rtval[i+3]) & 0xff));
	} else {
		v = (((rtval[i+3] << 24) & 0xff000000) +
		     ((rtval[i+2] << 16) & 0xff0000) +
		     ((rtval[i+1] << 8 ) & 0xff00) +
		     ((rtval[i]) & 0xff));
	}
	return(v);
}

/*)Function	a_uint 	ptb_4b(v, i)
 *
 *		int	v		value to put
 *		int	i		rtval[] index
 *
 *	The function ptb_1b() places the value
 *	of v into 4 bytes of rtval[i].
 *	The new value of rtval[i] is returned.
 *
 *	local variable:
 *		none
 *
 *	global variables:
 *		int	hilo		byte ordering parameter
 *		a_uint	rtval[]		relocation data
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		The value of rtval[] is changed.
 *
 */

a_uint
ptb_4b(v, i)
register a_uint v;
register int i;
{
	if (hilo) {
		rtval[i] = (v >> 24) & 0xff;
		rtval[i+1] = (v >> 16) & 0xff;
		rtval[i+2] = (v >> 8) & 0xff;
		rtval[i+3] = v & 0xff;
	} else {
		rtval[i] = v & 0xff;
		rtval[i+1] = (v >> 8) & 0xff;
		rtval[i+2] = (v >> 16) & 0xff;
		rtval[i+3] = (v >> 24) & 0xff;
	}
	return(v);
}

/*)Function	a_uint 	gtb_xb(i)
 *
 *		int	i		rtval[] index
 *
 *	The function gtb_xb() returns the value of v
 *	contained in rtval[i] for x-bytes.
 *
 *	local variable:
 *		a_uint	v		evaluation temporary
 *
 *	global variables:
 *		int	a_bytes		T Line Address Bytes
 *
 *	called functions:
 *		a_uint	gtb_1b()	lkrloc4.c
 *		a_uint	gtb_2b()	lkrloc4.c
 *		a_uint	gtb_3b()	lkrloc4.c
 *		a_uint	gtb_4b()	lkrloc4.c
 *
 *	side effects:
 *		none
 *
 */

a_uint
gtb_xb(i)
register int i;
{
	a_uint v;

	switch(a_bytes){
	case 1:
		v = gtb_1b(i);
		return(v & 0x80 ? v | ~0x7F : v & 0x7F);
	case 2:
		v = gtb_2b(i);
		return(v & 0x8000 ? v | ~0x7FFF : v & 0x7FFF);
	case 3:
		v = gtb_3b(i);
		return(v & 0x800000 ? v | ~0x7FFFFF : v & 0x7FFFFF);
	case 4:
		v = gtb_4b(i);
		return(v & 0x80000000 ? v | ~0x7FFFFFFF : v & 0x7FFFFFFF);
	default:
		return(0);
	}
	return(0);
}

/*)Function	a_uint 	ptb_xb(v, i)
 *
 *		int	v		value to add to x-bytes
 *		int	i		rtval[] index
 *
 *	The function ptb_xb() places the value of v
 *	in rtval[i] for x-bytes.
 *	The new value of rtval[i] for x-bytes is returned.
 *
 *	local variable:
 *		a_uint	j		evaluation temporary
 *
 *	global variables:
 *		int	a_bytes		T Line Address Bytes
 *
 *	called functions:
 *		a_uint	ptb_1b()	lkrloc4.c
 *		a_uint	ptb_2b()	lkrloc4.c
 *		a_uint	ptb_3b()	lkrloc4.c
 *		a_uint	ptb_4b()	lkrloc4.c
 *
 *	side effects:
 *		The x-byte value of rtval[] is changed.
 *
 */

a_uint
ptb_xb(v, i)
register a_uint v;
register int i;
{
	a_uint j;

	switch(a_bytes){
	case 1:
		j = ptb_1b(v, i);
		return(j & 0x80 ? j | ~0x7F : j & 0x7F);
	case 2:
		j = ptb_2b(v, i);
		return(j & 0x8000 ? j | ~0x7FFF : j & 0x7FFF);
	case 3:
		j = ptb_3b(v, i);
		return(j & 0x800000 ? j | ~0x7FFFFF : j & 0x7FFFFF);
	case 4:
		j = ptb_4b(v, i);
		return(j & 0x80000000 ? j | ~0x7FFFFFFF : j & 0x7FFFFFFF);
	default:
		return(0);
	}
	return(0);
}


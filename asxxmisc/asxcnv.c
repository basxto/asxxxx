/* asxcnv.c */

/*
 * (C) Copyright 1989-1999
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */


#include <stdio.h>
#include <string.h>
#include <setjmp.h>
#include <alloc.h>
#include "asxxxx.h"


static int inpfil;		/* Input File Counter	*/
static int xflag;		/* Radix Flag		*/
static int aserr;		/* Error Counter	*/

static FILE *nfp;		/* Input File Handle	*/
static FILE *dfp;		/* Output File Handle	*/

static char scline[256];	/* Input text line	*/


/*
 *	array of character types, one per
 *	ASCII character
 */
char	ctype[128] = {
/*NUL*/	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,
/*BS*/	ILL,	SPACE,	ILL,	ILL,	SPACE,	ILL,	ILL,	ILL,
/*DLE*/	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,
/*CAN*/	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,	ILL,
/*SPC*/	SPACE,	ETC,	ETC,	ETC,	LETTER,	BINOP,	BINOP,	ETC,
/*(*/	ETC,	ETC,	BINOP,	BINOP,	ETC,	BINOP,	LETTER,	BINOP,
/*0*/	DGT2,	DGT2,	DGT8,	DGT8,	DGT8,	DGT8,	DGT8,	DGT8,
/*8*/	DGT10,	DGT10,	ETC,	ETC,	BINOP,	ETC,	BINOP,	ETC,
/*@*/	ETC,	LTR16,	LTR16,	LTR16,	LTR16,	LTR16,	LTR16,	LETTER,
/*H*/	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,
/*P*/	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,
/*X*/	LETTER,	LETTER,	LETTER,	ETC,	ETC,	ETC,	BINOP,	LETTER,
/*`*/	ETC,	LTR16,	LTR16,	LTR16,	LTR16,	LTR16,	LTR16,	LETTER,
/*h*/	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,
/*p*/	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,	LETTER,
/*x*/	LETTER,	LETTER,	LETTER,	ETC,	BINOP,	ETC,	ETC,	ETC
};

/*
 *	an array of characters which
 *	perform the case translation function
 */
char	ccase[128] = {
/*NUL*/	'\000',	'\001',	'\002',	'\003',	'\004',	'\005',	'\006',	'\007',
/*BS*/	'\010',	'\011',	'\012',	'\013',	'\014',	'\015',	'\016',	'\017',
/*DLE*/	'\020',	'\021',	'\022',	'\023',	'\024',	'\025',	'\026',	'\027',
/*CAN*/	'\030',	'\031',	'\032',	'\033',	'\034',	'\035',	'\036',	'\037',
/*SPC*/	'\040',	'\041',	'\042',	'\043',	'\044',	'\045',	'\046',	'\047',
/*(*/	'\050',	'\051',	'\052',	'\053',	'\054',	'\055',	'\056',	'\057',
/*0*/	'\060',	'\061',	'\062',	'\063',	'\064',	'\065',	'\066',	'\067',
/*8*/	'\070',	'\071',	'\072',	'\073',	'\074',	'\075',	'\076',	'\077',
/*@*/	'\100',	'\141',	'\142',	'\143',	'\144',	'\145',	'\146',	'\147',
/*H*/	'\150',	'\151',	'\152',	'\153',	'\154',	'\155',	'\156',	'\157',
/*P*/	'\160',	'\161',	'\162',	'\163',	'\164',	'\165',	'\166',	'\167',
/*X*/	'\170',	'\171',	'\172',	'\133',	'\134',	'\135',	'\136',	'\137',
/*`*/	'\140',	'\141',	'\142',	'\143',	'\144',	'\145',	'\146',	'\147',
/*h*/	'\150',	'\151',	'\152',	'\153',	'\154',	'\155',	'\156',	'\157',
/*p*/	'\160',	'\161',	'\162',	'\163',	'\164',	'\165',	'\166',	'\167',
/*x*/	'\170',	'\171',	'\172',	'\173',	'\174',	'\175',	'\176',	'\177'
};


/*)Function	int	main(argc, argv)
 *
 *		int	argc		argument count
 *		char *	argv		array of pointers to argument strings
 *
 * Convert a listing file to a test file by:
 *	(1)	stripping the listing headers
 *	(2)	removing the program counter, data bytes, and
 *		line numbers
 *	(3)	appending the data bytes to the source line
 *		as a comment.
 *	(4)	remove any symbol table or area table
 */

int
main(argc, argv)
int argc;
char *argv[];
{
	register char *p, *q, *r, *s;
	int c, i, j, l, m, n, pos, rdx;

	/*
	 * Set Defaults
	 */
	xflag = 0;
	inpfil = 0;
	aserr = 0;

	fprintf(stdout, "\n");

	for (i=1; i<argc; ++i) {
		p = argv[i];
		if (*p == '-') {
			++p;
			while ((c = *p++) != 0)
				switch(c) {

				case 'x':
				case 'X':
					xflag = 0;
					break;

				case 'q':
				case 'Q':
					xflag = 1;
					break;

				case 'd':
				case 'D':
					xflag = 2;
					break;

				default:
					usage(ER_FATAL);
				}
		} else {
			if (++inpfil > 1) {
				fprintf(stderr, "\r\nToo many files.\r\n");
				asexit(ER_FATAL);
			}
			nfp = fopen(p, "r");
			if (nfp == NULL) {
				printf("\r\nFile %s not found\r\n", p);
				asexit(ER_FATAL);
			}
			dfp = fopen("a.out", "w");
			if (dfp == NULL) {
				printf("\r\nFile a.out not opened\r\n");
				asexit(ER_FATAL);
			}
		}
	}
	if (inpfil == 0)
		usage(ER_WARNING);

	printf("\r\nASxxxx Assembler Listing Converter %s\r\n\r\n", VERSION);

	/*
	 * Convert listing file to a source file
	 * with assembled data appended as comments.
	 */
loop:
	while (fgets(scline, sizeof(scline), nfp)) {
		scline[strlen(scline)-1] = '\0';
		p = scline;

/*
 * A typical listing line with program counter
 * and data bytes for HEX, OCTAL, and DECIMAL.
 *
          11111111112222222222333333333344444444445555555555666666666677777777
012345678901234567890123456789012345678901234567890123456789012345678901234567
   xxxx xx xx xx xx xx xx Line# 	mne	arg
   xxxxxx xxx xxx xxx xxx Line# 	mne	arg
    xxxxx xxx xxx xxx xxx Line# 	mne	arg
*/
		if (xflag == 0) {
			rdx = RAD16;
			p += 3;	/* Starting position of program counter */
			n = 4;	/* Number of digits in program ccounter */
			l = 2;	/* Number of digits in byte data */
			m = 6;	/* Number of bytes per line */
		} else
		if (xflag == 1) {
			rdx = RAD8;
			p += 3;
			n = 6;
			l = 3;
			m = 4;
		} else
		if (xflag == 2) {
			rdx = RAD10;
			p += 4;
			n = 5;
			l = 3;
			m = 4;
		} else {
			goto loop;
		}

		/*
		 * Verify this line has program counter
		 * digits or spaces.  If not then this
		 * line was generated by the assembler.
		 * Strip the line.
		 */
		for (i=0; i<n; i++,p++) {
			if ((ctype[*p & 0x007F] & rdx) != rdx &&
			     ctype[*p & 0x007F] != SPACE) {
				goto loop;
			}
		}

		/*
		 * Verify there is only data or spaces
		 * in the data locations.  If the listing
		 * file contains the symbol table then some
		 * assembler lines may still get through.
		 */
		r = p+1;
		for (i=0; i<m; i++,r++) {
			for (j=0; j<l; j++,r++) {
				if ((ctype[*r & 0x007F] & rdx) != rdx &&
				     ctype[*r & 0x007F] != SPACE) {
					goto loop;
				}
			}
		}

		/*
		 * Verify there is data in the line.
		 * If not then just copy to output.
		 */
		r = p+1;
		for (j=0; j<l; j++,r++) {
			if ((ctype[*r & 0x007F] & rdx) != rdx) {
				linout(scline);
				goto loop;
			}
		}

		/*
		 * Scan for the last data digit.
		 */
		s = q = scline;
		for (i=0; *s && i<25; i++) {
			if ((ctype[*s++ & 0x007F] & rdx) == rdx)
				q = s;
		}

		if (strlen(scline) <= 31) {
			/*
			 * Line must be data continuation
			 */
			linout(scline);
		} else {
			/*
			 * Real source line
			 */
			s = scline+32;
			/*
			 * Remove any comment in line
			 */
			r = strchr(s, ';');
			if (r != NULL) {
				*r = '\0';
				while( --r >= s && *r == SPACE) {
					*r = '\0';
				}
			}
			/*
			 * Find line length
			 */
			pos = 0;
			while (*s) {
				if (*s == '\t') {
					pos += 8;
					pos = 8 * (pos/8);
				} else {
					pos += 1;
				}
				s++;
			}
			/*
			 * Extend line to at least 40 characters
			 * before appending data.
			 */
			while (pos < 40) {
				strcat(scline,"\t");
				pos += 8;
				pos = 8 * (pos/8);
			}

			/*
			 * Append assembler generated data to
			 * source line.
			 */
			strcat(scline,";");
			strncat(scline,p,q-p);
			linout(scline);
		}
	}
	asexit(aserr ? ER_ERROR : ER_NONE);
	return(0);
}

/*)Function	VOID	asexit(i)
 *
 *			int	i	exit code
 *
 *	The function asexit() explicitly closes all open
 *	files and then terminates the program.
 *
 *	local variables:
 *		none
 *
 *	global variables:
 *		FILE *	nfp		scan file
 *
 *	functions called:
 *		int	fclose()	c-library
 *		VOID	exit()		c-library
 *
 *	side effects:
 *		All files closed. Program terminates.
 */

VOID
asexit(i)
int i;
{
	if (nfp != NULL) fclose(nfp);
	if (dfp != NULL) fclose(dfp);

	exit(i);
}

/*)Function	VOID	lineout(str)
 *
 *		char *	str		pointer to string
 *
 *	The function lineout() outputs to a.out the string str
 *	if the line is longer than 32 characters.
 *	I.E. the line is from the original assembled file.
 *
 *	local variables:
 *		none
 *
 *	global variables:
 *		FILE *	dfp		output file handle
 *
 *	functions called:
 *		int	fprintf()	c_library
 *
 *	side effects:
 *		string is copied to a.out
 */

VOID
linout(str)
char * str;
{
	if (strlen(str) >= 32) {
		fprintf(dfp, "%s\n", str+32);
	}
}

char *usetxt[] = {
	"Usage: [-dqx] file",
	"  d    decimal listing",
	"  q    octal   listing",
	"  x    hex     listing (default)",
	"",
	NULL
};

/*)Function	VOID	usage(n)
 *
 *		int	n		exit code
 *
 *	The function usage() outputs to the stderr device the
 *	program name and version and a list of valid assembler options.
 *
 *	local variables:
 *		char **	dp		pointer to an array of
 *					text string pointers.
 *
 *	global variables:
 *		char *	usetxt[]	array of string pointers
 *
 *	functions called:
 *		VOID	asexit()	asmain.c
 *		int	fprintf()	c_library
 *
 *	side effects:
 *		program is terminated
 */

VOID
usage(n)
int n;
{
	register char   **dp;

	fprintf(stderr,
		"\nASxxxx Assembler Listing Converter %s\n\n", VERSION);
	for (dp = usetxt; *dp; dp++)
		fprintf(stderr, "%s\n", *dp);
	asexit(n);
}


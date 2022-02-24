/* asxscn.c */

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
#include "asxxxx.h"


static int inpfil;		/* Input File Counter	*/
static int xflag;		/* Radix Flag		*/
static int aserr;		/* Error Counter	*/

static FILE *sfp[MAXFIL];	/* Input File Handle	*/

static char scfile[80];		/* Input File Name	*/

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


extern	VOID	asexit();
extern	VOID	usage();


/*)Function	int	main(argc, argv)
 *
 *		int	argc		argument count
 *		char *	argv		array of pointers to argument strings
 */

int
main(argc, argv)
int argc;
char *argv[];
{
	register char *p, *q;
	register int c, i, n;

	/*
	 * Set Defaults
	 */
	xflag = 0;
	inpfil = 0;
	aserr = 0;

	printf("\n");

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
				fprintf(stderr, "too many input files\n");
				asexit(ER_FATAL);
			}
			sfp[0] = fopen(p, "r");
			if (sfp[0] != NULL) {
				strcpy(scfile, p);
			} else {
				fprintf(stderr, "\r\nFile %s not found\r\n", p);
				asexit(ER_FATAL);
			}
		}
	}
	if (inpfil == 0)
		usage(ER_WARNING);

	printf("\r\nASxxxx Assembler Listing Scanner %s\r\n\r\n", VERSION);

	/*
	 * Scan file to find assembler errors
	 */
loop:
	while (fgets(scline, sizeof(scline), sfp[0])) {
		scline[strlen(scline)-1] = '\0';
		p = scline;
		for (i=0; i<3; i++) {
			if (*p++ != ' ')
				goto loop;
		}

		if (xflag == 0) { n = 4; } else
		if (xflag == 1) { n = 6; } else
		if (xflag == 2) { n = 5; } else
		{ goto loop; }

		for (i=0; i<n; i++) {
			if ((ctype[*p++ & 0x007F] & RAD16) != RAD16)
				goto loop;
		}

		if ((ctype[*(p+1) & 0x007F] & RAD16) != RAD16)
			goto loop;
		if ((ctype[*(p+2) & 0x007F] & RAD16) != RAD16)
			goto loop;

		if (*p == ' ')
			p++;

		/*
		 * Scan until ';' is found
		 */
		q = p;
		while (*q && (*q != ';')) {
			q++;
		}
		if (*q++ != ';')
			goto loop;
		if (*q == '\0')
			goto loop;
		if (*q == ' ')
			q++;

		/*
		 * Compare Strings
		 */
		n = strlen(q);
		for (i=0; i<n; i++) {
			if (ccase[*p++ & 0x007F] != ccase[*q++ & 0x007F]) {
				printf("%s\r\n", scline);
				aserr += 1;
				goto loop;
			}
		}
	}
	printf("%d code error(s) found in file %s\r\n", aserr, scfile);
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
 *		FILE *	sfp		scan file
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
	if (sfp[0] != NULL) fclose(sfp[0]);

	exit(i);
}

char *usetxt[] = {
	"Usage: [-dqx] file",
	"  d    decimal listing",
	"  q    octal   listing",
	"  x    hex     listing (default)",
	"",
	0
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

	fprintf(stderr, "\nASxxxx Assembler Listing Scanner %s\n\n", VERSION);
	for (dp = usetxt; *dp; dp++)
		fprintf(stderr, "%s\n", *dp);
	asexit(n);
}


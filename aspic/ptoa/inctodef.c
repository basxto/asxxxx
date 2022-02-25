/* IncToDef.c */

/*
 * (C) Copyright 2002-2006
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include <string.h>

#ifdef WIN32
#include <stdlib.h>
#else
#include <alloc.h>
#endif

#include "ptoa.h"

/*)Module	pictoasx.c
 *
 *	The module pictoasx.c includes the command argument parser,
 *	the three pass sequencer, and the machine independent
 *	assembler parsing code.
 *
 *	pictoasx.c contains the following functions:
 *		FILE *	afile()
 *		VOID	afilex()
 *		VOID	asexit()
 *		char	endline()
 *		int	fndidx()
 *		int	get()
 *		VOID	getid()
 *		int	getline()
 *		int	getnb()
 *		int	main()
 *		int	more()
 *		int	changekey()
 *		VOID	scanline()
 *		VOID	unget()
 *		VOID	usage()
 *
 *	pictoasx.c contains the array char *usetxt[] which
 *	references the usage text strings printed by usage().
 */

/*)Function	int	main(argc, argv)
 *
 *		int	argc		argument count
 *		char *	argv		array of pointers to argument strings
 *
 *	The function main() is the entry point to the assembler.
 *	The purpose of main() is to (1) parse the command line
 *	arguments for options and source file specifications and
 *	(2) to process the source files through the 3 pass assembler.
 *	Before each assembler pass various variables are initialized
 *	and source files are rewound to their beginning.  During each
 *	assembler pass each assembler-source text line is processed.
 *	After each assembler pass the assembler information is flushed
 *	to any opened output files and the if-else-endif processing
 *	is checked for proper termination.
 *
 *	The function main() is also responsible for opening all
 *	output files (REL, LST, and SYM), sequencing the global (-g)
 *	and all-global (-a) variable definitions, and dumping the
 *	REL file header information.
 *
 *	local variables:
 *		char *	p		pointer to argument string
 *		int	c		character from argument string
 *		int	i		argument loop counter
 *		area *	ap		pointer to area structure
 *
 *	global variables:
 *		int	aflag		-a, make all symbols global flag
 *		char	afn[]		afile() constructed filespec
 *		int	afp		afile constructed path length
 *		area *	areap		pointer to an area structure
 *		int	aserr		assembler error counter
 *		int	cb[]		array of assembler output values
 *		int	cbt[]		array of assembler relocation types
 *					describing the data in cb[]
 *		int	cfile		current file handle index
 *					of input assembly files
 *		int *	cp		pointer to assembler output array cb[]
 *		int *	cpt		pointer to assembler relocation type
 *					output array cbt[]
 *		char	eb[]		array of generated error codes
 *		char *	ep		pointer into error list array eb[]
 *		int	fflag		-f(f), relocations flagged flag
 *		int	flevel		IF-ELSE-ENDIF flag will be non
 *					zero for false conditional case
 *		int	nlevel		LIST-NLIST flag will be non
 *				 	zero for nolist
 *		a_uint	fuzz		tracks pass to pass changes in the
 *					address of symbols caused by
 *					variable length instruction formats
 *		int	gflag		-g, make undefined symbols global flag
 *		char	ib[]		assembler-source text line
 *		int	inpfil		count of assembler
 *					input files specified
 *		int	ifcnd[]		array of IF statement condition
 *					values (0 = FALSE) indexed by tlevel
 *		int	iflvl[]		array of IF-ELSE-ENDIF flevel
 *					values indexed by tlevel
 *		int	incfil		current file handle index
 *					for include files
 *		char *	ip		pointer into the assembler-source
 *					text line in ib[]
 *		jmp_buf	jump_env	compiler dependent structure
 *					used by setjmp() and longjmp()
 *		int	lflag		-l, generate listing flag
 *		int	line		current assembler source
 *					line number
 *		int	lop		current line number on page
 *		int	oflag		-o, generate relocatable output flag
 *		int	page		current page number
 *		int	pflag		enable listing pagination
 *		int	pass		assembler pass number
 *		int	radix		current number conversion radix:
 *					2 (binary), 8 (octal), 10 (decimal),
 *					16 (hexadecimal)
 *		int	sflag		-s, generate symbol table flag
 *		char	srcfn[][]	array of source file names
 *		int	srcfp[]		array of source file path lengths
 *		int	srcline[]	current source file line
 *		char	stb[]		Subtitle string buffer
 *		sym *	symp		pointer to a symbol structure
 *		int	tlevel		current conditional level
 *		int	uflag		-u, disable .list/.nlist processing
 *		int	wflag		-w, enable wide listing format
 *		int	xflag		-x, listing radix flag
 *		int	zflag		-z, enable symbol case sensitivity
 *		FILE *	lfp		list output file handle
 *		FILE *	ofp		relocation output file handle
 *		FILE *	tfp		symbol table output file handle
 *		FILE *	sfp[]		array of assembler-source file handles
 *
 *	called functions:
 *		FILE *	afile()		asmain.c
 *		VOID	allglob()	assym.c
 *		VOID	asexit()	asmain.c
 *		VOID	diag()		assubr.c
 *		VOID	err()		assubr.c
 *		int	fprintf()	c-library
 *		int	getline()	aslex.c
 *		VOID	list()		aslist.c
 *		VOID	lstsym()	aslist.c
 *		VOID	minit()		___mch.c
 *		VOID	newdot()	asmain.c
 *		VOID	outbuf()	asout.c
 *		VOID	outchk()	asout.c
 *		VOID	outgsd()	asout.c
 *		int	rewind()	c-library
 *		int	setjmp()	c-library
 *		VOID	symglob()	assym.c
 *		VOID	syminit()	assym.c
 *		VOID	usage()		asmain.c
 *
 *	side effects:
 *		Completion of main() completes the assembly process.
 *		REL, LST, and/or SYM files may be generated.
 */

int
main(argc, argv)
int argc;
char *argv[];
{
	register char *p;
	register int c, i;

	fprintf(stdout, "\n");
	for (i=1; i<argc; ++i) {
		p = argv[i];
		if (*p == '-') {
			if (ifp != NULL)
				usage(ER_FATAL);
			++p;
			while ((c = *p++) != 0)
				switch(c) {

				case 'z':
				case 'Z':
					++zflag;
					break;

				default:
					usage(ER_FATAL);
				}
		} else {
			ifp = afile(p, "", 0);
			if (ifp != NULL) {
				ofp = afile(p, "def", 1);
			}
		}
	}
	if (ifp == NULL)
		usage(ER_WARNING);
	while (getline()) {
		fprintf(ofp, "%s\n", ib);
	}
	asexit(ER_NONE);
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
 *		FILE *	ifp		input file handle
 *		FILE *	ofp		output file handle
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
	if (ifp != NULL) fclose(ifp);
	if (ofp != NULL) fclose(ofp);
	exit(i);
}

/*)Function	FILE *	afile(fn, ft, wf)
 *
 *		char *	fn		file specification string
 *		char *	ft		file type string
 *		int	wf		read(0)/write(1) flag
 *
 *	The function afile() opens a file for reading or writing.
 *
 *	afile() returns a file handle for the opened file or aborts
 *	the assembler on an open error.
 *
 *	local variables:
 *		FILE *	fp		file handle for opened file
 *
 *	global variables:
 *		char	afn[]		afile() constructed filespec
 *		int	afp		afile() constructed path length
 *		char	afntmp[]	afilex() constructed filespec
 *		int	afptmp		afilex() constructed path length
 *
 *	functions called:
 *		VOID	afilex()	pictoasx.c
 *		int	fndidx()	pictoasx.c
 *		FILE *	fopen()		c_library
 *		int	fprintf()	c_library
 *		char *	strcpy()	c_library
 *
 *	side effects:
 *		File is opened for read or write.
 */

FILE *
afile(fn, ft, wf)
char *fn;
char *ft;
int wf;
{
	FILE *fp;

	afilex(fn, ft);

	if ((fp = fopen(afntmp, wf?"w":"r")) == NULL) {
	    fprintf(stderr, "%s: cannot %s.\n", afntmp, wf?"create":"open");
	    asexit(ER_FATAL);
	}

	strcpy(afn, afntmp);
	afp = afptmp;

	return (fp);
}

/*)Function	VOID	afilex(fn, ft)
 *
 *		char *	fn		file specification string
 *		char *	ft		file type string
 *
 *	The function afilex() processes the file specification string:
 *		(1)	If the file type specification string ft
 *			is not NULL then a file specification is
 *			constructed with the file path\name in fn
 *			and the extension in ft.
 *		(2)	If the file type specification string ft
 *			is NULL then the file specification is
 *			constructed from fn.  If fn does not have
 *			a file type then the default source file
 *			type dsft is appended to the file specification.
 *
 *	afilex() aborts the assembler on a file specification length error.
 *
 *	local variables:
 *		int	c		character value
 *		char *	p1		pointer into filespec string afntmp
 *		char *	p2		pointer into filespec string fn
 *		char *	p3		pointer to filetype string ft
 *
 *	global variables:
 *		char	afntmp[]	afilex() constructed filespec
 *		int	afptmp		afilex() constructed path length
 *		char	dsft[]		default assembler file type string
 *
 *	functions called:
 *		VOID	asexit()	asmain.c
 *		int	fndidx()	asmain.c
 *		int	fprintf()	c_library
 *		char *	strcpy()	c_library
 *
 *	side effects:
 *		File specification string may be modified.
 */

VOID
afilex(fn, ft)
char *fn;
char *ft;
{
	register char *p1, *p2, *p3;
	register int c;

	if (strlen(fn) > (FILSPC-5)) {
		fprintf(stderr, "File Specification %s is too long.", fn);
		asexit(ER_FATAL);
	}

	/*
	 * Save the File Name Index
	 */
	strcpy(afntmp, fn);
	afptmp = fndidx(afntmp);
	p1 = &afntmp[afptmp];
	p2 = &fn[afptmp];

	/*
	 * Skip to File Extension Seperator
	 */
	while (((c = *p2++) != 0) && (c != FSEPX)) {
		p1++;
	}
	*p1++ = FSEPX;

	/*
	 * Copy File Extension
	 */
	 p3 = ft;
	 if (*p3 == 0) {
		if (c == FSEPX) {
			p3 = p2;
		} else {
			p3 = "inc";
		}
	}
	while ((c = *p3++) != 0) {
		if (p1 < &afntmp[FILSPC-1])
			*p1++ = c;
	}
	*p1++ = 0;
}

/*)Function	int	fndidx(str)
 *
 *		char *	str		file specification string
 *
 *	The function fndidx() scans the file specification string
 *	to find the index to the file name.  If the file
 *	specification contains a 'path' then the index will
 *	be non zero.
 *
 *	fndidx() returns the index value.
 *
 *	local variables:
 *		char *	p1		temporary pointer
 *		char *	p2		temporary pointer
 *
 *	global variables:
 *		none
 *
 *	functions called:
 *		char *	strrchr()	c_library
 *
 *	side effects:
 *		none
 */

int
fndidx(str)
char *str;
{
	register char *p1, *p2;

	/*
	 * Skip Path Delimiters
	 */
	p1 = str;
	if ((p2 = strrchr(p1,  ':')) != NULL) { p1 = p2 + 1; }
	if ((p2 = strrchr(p1,  '/')) != NULL) { p1 = p2 + 1; }
	if ((p2 = strrchr(p1, '\\')) != NULL) { p1 = p2 + 1; }

	return(p1 - str);
}

/*)Function	int	getid(id,c)
 *
 *		char *	id		a pointer to a string of
 *					maximum length NCPS-1
 *		int	c		mode flag
 *					>=0	this is first character to
 *						copy to the string buffer
 *					<0	skip white space, first
 *						character must be a LETTER
 *
 *	The function getid() scans the current assembler-source text line
 *	from the current position copying the next LETTER | DIGIT string
 *	into the external string buffer id[].  The string ends when a non
 *	LETTER or DIGIT character is found. The maximum number of characters
 *	copied is NCPS-1.  If the input string is larger than NCPS-1
 *	characters then the string is truncated.  The string is always
 *	NULL terminated.  If the mode argument (c) is >=0 then (c) is
 *	the first character copied to the string buffer, if (c) is <0
 *	then intervening white space (SPACES and TABS) are skipped and
 *	the first character found must be a LETTER else a 'q' error
 *	terminates the parse of this assembler-source text line.
 *
 *	local variables:
 *		char *	p		pointer to external string buffer
 *		int	c		current character value
 *
 *	global variables:
 *		char	ctype[]		a character array which defines the
 *					type of character being processed.
 *					This index is the character
 *					being processed.
 *
 *	called functions:
 *		int	get()		aslex.c
 *		int	getnb()		aslex.c
 *		VOID	getsub()	aslex.c
 *		VOID	unget()		aslex.c
 *
 *	side effects:
 *		Use of getnb(), get(), and unget() updates the
 *		global pointer ip, the position in the current
 *		assembler-source text line.
 */

VOID
getid(id, c)
register int c;
char *id;
{
	register char *p;

	if (c < 0) {
		c = getnb();
		if ((ctype[c] & LETTER) == 0)
			asexit(ER_FATAL);
	}
	p = id;
	do {
		if (p < &id[NCPS-1])
			*p++ = c;
	} while (ctype[c=get()] & (LETTER|DIGIT));
	unget(c);
	*p++ = 0;
}

/*)Function	int	getnb()
 *
 *	The function getnb() scans the current assembler-source
 *	text line returning the first character not a SPACE or TAB.
 *
 *	local variables:
 *		int	c		current character from
 *					assembler-source text line
 *
 *	global variables:
 *		none
 *
 *	called functions:
 *		int	get()		aslex.c
 *
 *	side effects:
 *		use of get() updates the global pointer ip, the position
 *		in the current assembler-source text line
 */

int
getnb()
{
	register int c;

	while ((c=get()) == ' ' || c == '\t')
		;
	return (c);
}

/*)Function	int	get()
 *
 *	The function get() returns the next character in the
 *	assembler-source text line, at the end of the line a
 *	NULL character is returned.
 *
 *	local variables:
 *		int	c		current character from
 *					assembler-source text line
 *
 *	global variables:
 *		char *	ip		pointer into the current
 *					assembler-source text line
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		updates ip to the next character position in the
 *		assembler-source text line.  If ip is at the end of the
 *		line, ip is not updated.
 */

int
get()
{
	register int c;

	if ((c = *ip) != 0)
		++ip;
	return (c & 0x007F);
}

/*)Function	VOID	unget(c)
 *
 *		int	c		value of last character read from
 *					assembler-source text line
 *
 *	If (c) is not a NULL character then the global pointer ip
 *	is updated to point to the preceeding character in the
 *	assembler-source text line.
 *
 *	NOTE:	This function does not push the character (c)
 *		back into the assembler-source text line, only
 *		the pointer ip is changed.
 *
 *	local variables:
 *		int	c		last character read from
 *					assembler-source text line
 *
 *	global variables:
 *		char *	ip		position into the current
 *					assembler-source text line
 *
 *	called functions:
 *		none
 *
 *	side effects:
 *		ip decremented by 1 character position
 */

VOID
unget(c)
int c;
{
	if (c)
		if (ip != ib)
			--ip;
}

/*)Function	int	getline()
 *
 *	The function getline() reads a line of assembler-source text
 *	from an assembly source text file or an include file.
 *	Lines of text are processed from assembler-source files until
 *	all files have been read.  If an include file is opened then
 *	lines of text are read from the include file (or nested
 *	include file) until the end of the include file is found.
 *	The input text line is transferred into the global string
 *	ib[] and converted to a NULL terminated string.  The string
 *	is then copied into the global string ib[] which is used
 *	for internal processing by the assembler.  The function
 *	scanline() is called to process any .define substitutions
 *	in the assembler-source text line.  The function
 *	getline() returns a (1) after succesfully reading a line
 *	or a (0) if all files have been read.
 *
 *	local variables:
 *		none
 *
 *	global variables:
 *		char	afn[]		afile() constructed filespec
 *		int	afp		afile constructed path length
 *		char	ib[]		string buffer containing
 *					assembler-source text line
 *		char	iline[]		string buffer containing
 *					assembler-source text line
 *		char	ifp[]		array of file handles for
 *					include files
 *		int	incfil		index for ifp[] specifies
 *					active include file
 *		int	incline[]	array of include file
 *					line numbers
 *		char	incfn[][]	array of include file names
 *		int	incfp[]		array of include file path lengths
 *		char	sfp[]		array of file handles for
 *					assembler source files
 *		int	cfile		index for sfp[] specifies
 *					active source file
 *		int	srcline[]	array of source file
 *					line numbers
 *		char	srcfn[][]	array of source file names
 *		int	srcfp[]		array of source file path lengths
 *		int	inpfil		maximum input file index
 *
 *	called functions:
 *		VOID	chopcrlf()	aslex.c
 *		int	fclose()	c-library
 *		char *	fgets()		c-library
 *		int	scanline()	aslex.c
 *		char *	strcpy()	c-library
 *
 *	side effects:
 *		include file will be closed at detection of end of file.
 *		the next sequential source file may be selected.
 *		the global file indexes incfil or cfile may be changed.
 *		The current file specification afn[] and the path
 *		length afp may be changed.
 *		The respective source line or include line counter
 *		will be updated.
 */

int
getline()
{
	if (fgets(ib, NINPUT, ifp) == NULL) {
		return (0);
	}
	chopcrlf(ib);
	scanline();
	return (1);
}


/*)Function	int	scanline()
 *
 *	The function scanline() scans the assembler-source text line
 *	for a valid substitutable string.  The only valid targets
 *	for substitution strings are strings beginning with a
 *	LETTER and containing any combination of DIGITS and LETTERS.
 *	If a valid target is found then the function changekey() is
 *	called to search the ".define" substitution list.
 *
 *	If the mnemonic ".define" is found then the function exits.
 *
 *	local variables:
 *		int	c		temporary character value
 *		char	id[]		a string of maximum length NINPUT
 *
 *	global variables:
 *		char	ctype[]		a character array which defines the
 *					type of character being processed.
 *					The index is the character
 *					being processed.
 *		int	flevel		IF-ELSE-ENDIF level
 *		char	ib[]		assembler-source text line
 *		char *	ip		pointer into the assembler-source text line
 *
 *	called functions:
 *		int	endline()	aslex.c
 *		int	getid()		aslex.c
 *		int	unget()		aslex.c
 *		int	changekey()	aslex.c
 *		int	symeq()		assym.c
 *
 *	side effects:
 *		The assembler-source text line may be updated
 *		and a substitution made for the string id[].
 */

VOID
scanline()
{
	int c;
	char id[NINPUT];

	ip = ib;
	while ((c = get()) != 0) {
		if (c == ';') break;
		if (ctype[c] & DIGIT) {
			while (ctype[c] & (LETTER|DIGIT)) c = get();
			unget(c);
		} else
		if (ctype[c] & LETTER) {
			getid(id, c);
			changekey(id);
		}
	}

	changestr();
	cnvhex();
}


/*)Function	int	changekey(id)
 *
 *		char *	id		a pointer to a string of
 *					maximum length NINPUT
 *
 *	The function changekey() scans the .define substitution list
 *	for a match to the string id[].  If a substitution is required
 *	then the current assembler-source text line is listed before
 *	the substitution is made.  After the substitution is made to the
 *	assembler-source text line the current character position, ip,
 *	is set to the beginning of the substitution string.  The
 *	function changekey() returns a non-zero value if a substitutuion
 *	is made else zero is returned.
 *
 *	local variables:
 *		char *	p		pointer to beginning of id
 *		char	str[]		temporary string
 *		struct def *dp		pointer to .define definitions
 *
 *	global variables:
 *		char	ib[]		assembler-source text line
 *		char *	ip		pointer into the assembler-source text line
 *		int	zflag		case sensitivity flag
 *
 *	called functions:
 *		char *	strcat()	c_library
 *		char *	strcpy()	c_library
 *		int	strlen()	c_library
 *		int	symeq()		assym.c
 *
 *	side effects:
 *		The assembler-source text line may be updated
 *		and a substitution made for the string id[].
 */

int
changekey(id)
char *id;
{
	register char *p;
	int c;
	char str[NINPUT];
	struct def *dp;

	/*
	 * Check for substitution
	 */
	dp = &defk[0];
	while (dp->d_id != NULL) {
		if (symeq(id, dp->d_id, zflag)) {
			p = ip - strlen(id);
			strcpy(str, ip);
			strcpy(p, dp->d_define);
			strcat(ib, str);
			ip = p + strlen(dp->d_define);
			/*
			 * Special Processing for __badram
			 */
			if (symeq("__badram", dp->d_id, 0)) {
				p = ip;
				while (((c = get()) != 0) && (c != ';')) {
					if (c == '-') {
						*(ip-1) = ':';
					}
				}
				ip = p;
			}
			return(1);
		}
		dp++;
	}
	return(0);
}


/*)Function	int	changestr(id)
 *
 *		char *	id		a pointer to a string of
 *					maximum length NINPUT
 *
 *	The function changestr() scans the .define substitution list
 *	for a match to the string id[].  If a substitution is required
 *	then the current assembler-source text line is listed before
 *	the substitution is made.  After the substitution is made to the
 *	assembler-source text line the current character position, ip,
 *	is set to the beginning of the substitution string.  The
 *	function changestr() returns a non-zero value if a substitutuion
 	is made else zero is returned.
 *
 *	local variables:
 *		char *	p		pointer to beginning of id
 *		char	str[]		temporary string
 *		struct def *dp		pointer to .define definitions
 *
 *	global variables:
 *		char	ib[]		assembler-source text line
 *		char *	ip		pointer into the assembler-source text line
 *		int	zflag		case sensitivity flag
 *
 *	called functions:
 *		char *	strcat()	c_library
 *		char *	strcpy()	c_library
 *		int	strlen()	c_library
 *		int	symeqn()	pictoasx.c
 *
 *	side effects:
 *		The assembler-source text line may be updated
 *		and a substitution made for the string id[].
 */

VOID
changestr()
{
	char str[NINPUT];
	char *id;
	int i,len,len_id;
	struct def *dp;

	len = strlen(ib);

	dp = &defs[0];
	while (dp->d_id != NULL) {
		id = dp->d_id;
		len_id = strlen(id);
		for (i=0; i<len-len_id; i++) {
			if (ib[i] == ';') break;
			if (symeqn(&ib[i],id,zflag,len_id)) {
				/* save tail of string */
				strcpy(str, &ib[i+len_id]);
				/* replacement string */
				strcpy(&ib[i], dp->d_define);
				/* place end of string */
				strcat(ib, str);
			}
		}
		dp++;
	}
}


/*)Function	VOID	cnvhex()
 *
 *	The function changestr() scans the .define substitution list
 *	for a match to the string id[].  If a substitution is required
 *	then the current assembler-source text line is listed before
 *	the substitution is made.  After the substitution is made to the
 *	assembler-source text line the current character position, ip,
 *	is set to the beginning of the substitution string.  The
 *	function changestr() returns a non-zero value if a substitutuion
 	is made else zero is returned.
 *
 *	local variables:
 *		char *	p		pointer to beginning of id
 *		char	str[]		temporary string
 *		struct def *dp		pointer to .define definitions
 *
 *	global variables:
 *		char	ib[]		assembler-source text line
 *
 *	called functions:
 *		char *	strcat()	c_library
 *		char *	strcpy()	c_library
 *		int	strlen()	c_library
 *		int	symeqn()	pictoasx.c
 *
 *	side effects:
 *		The assembler-source text line may be updated.
 */

VOID
cnvhex()
{
	char str[NINPUT];
	int i,j,len;

	len = strlen(ib);

	for (i=0; i<len-2; i++) {
		if (symeqn(&ib[i],"H\'",1,2)) {
			/* H'23456789' */
			for (j=2; j<11; j++) {
				if (ib[i+j] == '\'') {
					/* remove ' */
					strcpy(&ib[i+j], &ib[i+j+1]);
					/* save tail of string */
					strcpy(str, &ib[i+2]);
					/* replacement string */
					strcpy(&ib[i], "0x");
					/* place end of string */
					strcat(ib, str);
					break;
				}
			}
		}
	}
}


/*)Function	int	symeq(p1, p2, flag)
 *
 *		int	flag		case sensitive flag
 *		char *	p1		name string
 *		char *	p2		name string
 *
 *	The function symeq() compares the two name strings for a match.
 *	The return value is 1 for a match and 0 for no match.
 *
 *		flag == 0	case sensitive compare
 *		flag != 0	case insensitive compare
 *
 *	local variables:
 *		int	n		loop counter
 *
 *	global variables:
 *		char	ccase[]		an array of characters which
 *					perform the case translation function
 *
 *	functions called:
 *		none
 *
 *	side effects:
 *		none
 *
 */

int
symeq(p1, p2, flag)
register char *p1, *p2;
int flag;
{
	register int n;

	n = strlen(p1) + 1;
	if(flag) {
		/*
		 * Case Sensitive Compare
		 */
		do {
			if (*p1++ != *p2++)
				return (0);
		} while (--n);
	} else {
		/*
		 * Case Insensitive Compare
		 */
		do {
			if (ccase[*p1++ & 0x007F] != ccase[*p2++ & 0x007F])
				return (0);
		} while (--n);
	}
	return (1);
}


/*)Function	int	symeqn(p1, p2, flag, n)
 *
 *		int	flag		case sensitive flag
 *		int	n		number of characters to match
 *		char *	p1		name string
 *		char *	p2		name string
 *
 *	The function symeqn() compares the two name strings for a match.
 *	The return value is 1 for a match and 0 for no match.
 *
 *		flag == 0	case sensitive compare
 *		flag != 0	case insensitive compare
 *
 *	local variables:
 *		none
 *
 *	global variables:
 *		char	ccase[]		an array of characters which
 *					perform the case translation function
 *
 *	functions called:
 *		none
 *
 *	side effects:
 *		none
 *
 */

int
symeqn(p1, p2, flag, n)
register char *p1, *p2;
int flag, n;
{
	if(flag) {
		/*
		 * Case Sensitive Compare
		 */
		do {
			if (*p1++ != *p2++)
				return (0);
		} while (--n);
	} else {
		/*
		 * Case Insensitive Compare
		 */
		do {
			if (ccase[*p1++ & 0x007F] != ccase[*p2++ & 0x007F])
				return (0);
		} while (--n);
	}
	return (1);
}


/*)Function	VOID	chopcrlf(str)
 *
 *		char	*str		string to chop
 *
 *	The function chop_crlf() removes trailing
 *	LF, CR, LF/CR, or CR/LF from str.
 *
 *	local variables:
 *		char *	p		temporary string pointer
 *
 *	global variables:
 *		none
 *
 *	functions called:
 *		none
 *
 *	side effects:
 *		Trailing CR and LF characters removed.
 */

VOID
chopcrlf(str)
char *str;
{
	register char *p;

	if ((p = strchr(str, '\r')) != NULL) *p = 0;
	if ((p = strchr(str, '\n')) != NULL) *p = 0;
}


/*)Function	VOID	usage(n)
 *
 *		int	n		exit code
 *
 *	The function usage() outputs to the stderr device the
 *	assembler name and version and a list of valid assembler options.
 *
 *	local variables:
 *		char **	dp		pointer to an array of
 *					text string pointers.
 *
 *	global variables:
 *		char	cpu[]		assembler type string
 *		char *	usetxt[]	array of string pointers
 *
 *	functions called:
 *		VOID	asexit()	asmain.c
 *		int	fprintf()	c_library
 *
 *	side effects:
 *		program is terminated
 */

char *usetxt[] = {
	"Usage: [-options] file",
	"  z    Enable case sensitivity for KeyWords",
	"",
	NULL
};

VOID
usage(n)
int n;
{
	register char   **dp;

	fprintf(stderr, "\nPIC IncToDef Conversion Utility  %s\n\n", VERSION);
	for (dp = usetxt; *dp; dp++)
		fprintf(stderr, "%s\n", *dp);
	asexit(n);
}


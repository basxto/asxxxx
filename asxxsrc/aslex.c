/* aslex.c */

/*
 * (C) Copyright 1989-2006
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 *
 */

#include "asxxxx.h"

/*)Module	aslex.c
 *
 *	The module aslex.c includes the general lexical
 *	analysis routines for the assembler.
 *
 *	aslex.c contains the following functions:
 *		VOID	chopcrlf()
 *		char	endline()
 *		int	get()
 *		VOID	getid()
 *		int	getline()
 *		int	getmap()
 *		int	getnb()
 *		VOID	getst()
 *		int	more()
 *		int	replace()
 *		VOID	scanline()
 *		VOID	unget()
 *
 *	aslex.c contains no local/static variables
 */

/*)Function	VOID	getid(id,c)
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
int c;
char *id;
{
	char *p;

	if (c < 0) {
		c = getnb();
		if ((ctype[c] & LETTER) == 0)
			qerr();
	}
	p = id;
	do {
		if (p < &id[NCPS-1])
			*p++ = c;
	} while (ctype[c=get()] & (LETTER|DIGIT));
	unget(c);
	*p++ = 0;
}

/*)Function	VOID	getst(id,c)
 *
 *		char *	id		a pointer to a string of
 *					maximum length NCPS-1
 *		int	c		mode flag
 *					>=0	this is first character to
 *						copy to the string buffer
 *					<0	skip white space, first
 *						character must be a LETTER
 *
 *	The function getst() scans the current assembler-source text line
 *	from the current position copying the next character string into
 *	the external string buffer (id).  The string ends when a SPACE or
 *	ILL character is found. The maximum number of characters copied is
 *	NCPS-1.  If the input string is larger than NCPS-1 characters then
 *	the string is truncated.  The string is always NULL terminated.
 *	If the mode argument (c) is >=0 then (c) is the first character
 *	copied to the string buffer, if (c) is <0 then intervening white
 *	space (SPACES and TABS) are skipped and the first character found
 *	must be a LETTER else a 'q' error terminates the parse of this
 *	assembler-source text line.
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
 *		VOID	unget()		aslex.c
 *
 *	side effects:
 *		use of getnb(), get(), and unget() updates the
 *		global pointer ip, the position in the current
 *		assembler-source text line.
 */

VOID
getst(id, c)
int c;
char *id;
{
	char *p;

	if (c < 0) {
		c = getnb();
		if ((ctype[c] & LETTER) == 0)
			qerr();
	}
	p = id;
	do {
		if (p < &id[NCPS-1])
			*p++ = c;
	} while (ctype[c=get()] & ~(SPACE|ILL) & 0xFF);
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
	int c;

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
	int c;

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

/*)Function	int	getmap(d)
 *
 *		int	d		value to compare with the
 *					assembler-source text line character
 *
 *	The function getmap() converts the 'C' style characters \b, \f,
 *	\n, \r, and \t to their equivalent ascii values and also
 *	converts 'C' style octal constants '\123' to their equivalent
 *	numeric values.  If the first character is equivalent to (d) then
 *	a (-1) is returned, if the end of the line is detected then
 *	a 'q' error terminates the parse for this line, or if the first
 *	character is not a \ then the character value is returned.
 *
 *	local variables:
 *		int	c		value of character from the
 *					assembler-source text line
 *		int	n		looping counter
 *		int	v		current value of numeric conversion
 *
 *	global variables:
 *		none
 *
 *	called functions:
 *		int	get()		aslex.c
 *
 *	side effects:
 *		use of get() updates the global pointer ip the position
 *		in the current assembler-source text line
 */

int
getmap(d)
int d;
{
	int c, n, v;

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

		default:
			unget(c);
			c = '\\';
			break;
		}
	}
	return (c);
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
 *	is then copied into the global string ic[] which is used
 *	for internal processing by the assembler.  The function
 *	scanline() is called to process any .define substitutions
 *	in the assembler-source text line.  The function
 *	getline() returns a (2) if a string substitution / recursion
 *	error occurs within scanline(), returns a (1) after succesfully
 *	reading a line,	or a (0) if all files have been read.
 *
 *	local variables:
 *		none
 *
 *	global variables:
 *		char	afn[]		afile() constructed filespec
 *		int	afp		afile constructed path length
 *		char	ib[]		string buffer containing
 *					assembler-source text line for processing
 *		char	ic[]		string buffer containing
 *					assembler-source text line for listing
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

loop:	if (incfil >= 0) {
		if (fgets(ib, NINPUT, ifp[incfil]) == NULL) {
			fclose(ifp[incfil]);
			ifp[incfil--] = NULL;
			if (incfil >= 0) {
				strcpy(afn, incfn[incfil]);
				afp = incfp[incfil];
			} else {
				strcpy(afn, srcfn[cfile]);
				afp = srcfp[cfile];
			}
			lop = NLPP;
			goto loop;
		} else {
			++incline[incfil];
		}
	} else {
		if (fgets(ib, NINPUT, sfp[cfile]) == NULL) {
			if (++cfile <= inpfil) {
				strcpy(afn, srcfn[cfile]);
				afp = srcfp[cfile];
				srcline[cfile] = 0;
				goto loop;
			}
			return (0);
		} else {
			++srcline[cfile];
		}
	}
	chopcrlf(ib);
	strcpy(ic, ib);
	return (scanline() ? 2 : 1);
}


/*)Function	int	scanline()
 *
 *	The function scanline() scans the assembler-source text line
 *	for a valid substitutable string.  The only valid targets
 *	for substitution strings are strings beginning with a
 *	LETTER and containing any combination of DIGITS and LETTERS.
 *	If a valid target is found then the function replace() is
 *	called to search the ".define" substitution list.  If there
 *	is some string substitution error (or error caused by a
 *	runaway recursion in replace) then scanline() returns a
 *	value of 1 else 0 is returned.
 *
 *	If the mnemonic ".define" or ".undefine" is found then the function exits.
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
 *		int	replace()	aslex.c
 *		int	symeq()		assym.c
 *
 *	side effects:
 *		The assembler-source text line may be updated
 *		and a substitution made for the string id[].
 */

int
scanline()
{
	int c;
	char id[NINPUT];

	if (flevel)
		return(0);

	ip = ib;
	while ((c = endline()) != 0) {
		if (ctype[c] & DIGIT) {
			while (ctype[c] & (LETTER|DIGIT)) c = get();
			unget(c);
		} else
		if (ctype[c] & LETTER) {
			getid(id, c);
			if (symeq(id, ".define", 1)) {
				return(0);
			}
			if (symeq(id, ".undefine", 1)) {
				return(0);
			}
			if (replace(id)) {
				return(1);
			}
		}
	}
	return(0);
}


/*)Function	int	replace(id)
 *
 *		char *	id		a pointer to a string of
 *					maximum length NINPUT
 *
 *	The function replace() scans the .define substitution list
 *	for a match to the string id[].  After the substitution is made
 *	to the assembler-source text line the current character position,
 *	ip, is set to the beginning of the substitution string.  The
 *	function replace() returns a non-zero value if a substitutuion
 *	error is made else zero is returned.
 *
 *	If the -bb option was specified and a listing file is open then
 *	the current assembler-source text line is listed before the
 *	substitution is made.  
 *
 *	local variables:
 *		char *	p		pointer to beginning of id
 *		char	str[]		temporary string
 *		char *	frmt		temporary listing format specifier
 *		struct def *dp		pointer to .define definitions
 *
 *	global variables:
 *		int	a_bytes		T line addressing size
 *		int	bflag		list source before substitution flag
 *		int	cfile		current input file number
 *		char	ctype[]		a character array which defines the
 *					type of character being processed.
 *					The index is the character
 *					being processed.
 *		char	ib[]		assembler-source text line
 *		int	incfil		include file number
 *		int	inclin[]	include file line number
 *		char *	ip		pointer into the assembler-source text line
 *		FILE *	lfp		list output file handle
 *		int	line		current assembler source line number
 *		int	lmode		listing mode
 *		int	nlevel		LIST-NLIST flag will be non
 *				 	zero for nolist
 *		int	pass		assembler pass number
 *		int	pflag		paging flag
 *		int	srcline[]	source file line number
 *		int	uflag		-u, disable .list/.nlist processing
 *		int	zflag		case sensitivity flag
 *
 *	called functions:
 *		int	fprintf()	c_library
 *		VOID	slew()		aslist.c
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
replace(id)
char *id;
{
	char *p;
	char str[NINPUT*2];
	char *frmt;
	struct def *dp;

	/*
	 * Check for .define substitution
	 */
	dp = defp;
	while (dp) {
		if (dp->d_dflag && symeq(id, dp->d_id, zflag)) {
			if ((pass == 2) && (bflag == 2)) {
				if (lfp == NULL || lmode == NLIST || (nlevel && (uflag == 0))) {
					;
				} else {
					/*
					 * Get Correct Line Number
					 */
					if (incfil >= 0) {
						line = incline[incfil];
						if (line == 0) {
							if (incfil > 0) {
								line = incline[incfil-1];
							} else {
								line = srcline[cfile];
							}
						}
					} else {
						line = srcline[cfile];
					}

					/*
					 * Move to next line.
					 */
					slew(lfp, pflag);

					/*
					 * Source listing only option.
					 */
					switch(a_bytes) {
					default:
					case 2: frmt = "  %24s%5u %s\n"; break;
					case 3:
					case 4: frmt = "  %32s%5u %s\n"; break;
					}
					fprintf(lfp, frmt, "", line, ib);
				}
			}
			/*
			 * Verify string space is available
			 */
			if ((strlen(ib) - strlen(id) + strlen(dp->d_define)) > (NINPUT*2 - 1)) {
				return(1);
			}
			/*
			 * Beginning of Substitutable string
			 */
			p  = ip - strlen(id);
			/*
			 * Make a copy of the string from the end of the
			 * substitutable string to the end of the line.
			 */
			strcpy(str, ip);
			/*
			 * Replace the substitutable string
			 * with the new string and append
			 * the tail of the original string.
			 */
			*p = 0;
			strcat(ib, dp->d_define);
			strcat(ib, str);
			ip = p;
			return(0);
		}
		dp = dp->d_dp;
	}
	return(0);
}


/*)Function	int	more()
 *
 *	The function more() scans the assembler-source text line
 *	skipping white space (SPACES and TABS) and returns a (0)
 *	if the end of the line or a comment delimeter (;) is found,
 *	or a (1) if their are additional characters in the line.
 *
 *	local variables:
 *		int	c		next character from the
 *					assembler-source text line
 *
 *	global variables:
 *		none
 *
 *	called functions:
 *		int	getnb()		aslex.c
 *		VOID	unget()		aslex.c
 *
 *	side effects:
 *		use of getnb() and unget() updates the global pointer ip
 *		the position in the current assembler-source text line
 */

int
more()
{
	int c;

	c = getnb();
	unget(c);
	return( (c == '\0' || c == ';') ? 0 : 1 );
}

/*)Function	char	endline()
 *
 *	The function endline() scans the assembler-source text line
 *	skipping white space (SPACES and TABS) and returns the next
 *	character or a (0) if the end of the line is found or a
 *	comment delimiter (;) is found.
 *
 *	local variables:
 *		int	c		next character from the
 *					assembler-source text line
 *
 *	global variables:
 *		none
 *
 *	called functions:
 *		int	getnb()		aslex.c
 *
 *	side effects:
 *		use of getnb() updates the global pointer ip the
 *		position in the current assembler-source text line
 */

char
endline()
{
	int c;

	c = getnb();
	return( (c == '\0' || c == ';') ? 0 : c );
}

/*)Function	VOID	chopcrlf(str)
 *
 *		char	*str		string to chop
 *
 *	The function chopcrlf() removes
 *	LF, CR, LF/CR, or CR/LF from str.
 *
 *	local variables:
 *		char *	p		temporary string pointer
 *		char	c		temporary character
 *
 *	global variables:
 *		none
 *
 *	functions called:
 *		none
 *
 *	side effects:
 *		All CR and LF characters removed.
 */

VOID
chopcrlf(str)
char *str;
{
	char *p;
	char c;

	p = str;
	do {
		c = *p++ = *str++;
		if ((c == '\r') || (c == '\n')) {
			p--;
		}
	} while (c != 0);
}


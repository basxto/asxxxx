/* lkout.c */

/*
 * (C) Copyright 1989-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 *
 *   With enhancements by
 *
 * 	G. Osborn
 *	gary@s-4.com.  
 */

#include <stdio.h>
#include <string.h>

#ifdef WIN32
#include <stdlib.h>
#else
#include <alloc.h>
#endif

#include "aslink.h"

/*)Module	lkout.c
 *
 *	The module lkout.c contains the dispatch
 *	function to create the relocated object
 *	code output in the required format.
 *
 *	lkout.c contains the following functions:
 *		VOID	lkout()
 *		VOID	lkflush()
 *		VOID	ixx()
 *		VOID	iflush()
 *		VOID	sxx()
 *		VOID	sflush()
 *
 *	lkout.c contains no local variables.
 */

/*)Function	lkout(i)
 *
 *		int	i		1 - process data
 *					0 - end of data
 *
 *	The function lkout() dispatches to the
 *	required output format routine.
 *
 *	local variables:
 *		none
 *
 *	global variables:
 *		int	oflag		output type flag
 *		int	obj_flag	Output enabled flag
 *
 *	functions called:
 *		VOID	ixx()		lkout.c
 *		VOID	sxx()		lkout.c
 *
 *	side effects:
 *		The REL data is output in the required format.
 */

VOID
lkout(i)
int i;
{
	int j;

	if (i && obj_flag) { return; }
	if (ofp == NULL)   { return; }

	/*
	 * Create the Byte Output Address
	 */
	for (j=1; j<pcb; j++) {
		adb_xb(pc, 0);
	}

	/*
	 * Intel Formats
	 */
	if (oflag == 1) {
		ixx(i);
	} else
	/*
	 * Motorola Formats
	 */
	if (oflag == 2) {
		sxx(i);
	}
}


/*)Function	lkflush()
 *
 *	The function lkflush() dispatches
 *	to the required data flushing routine.
 *
 *	local variables:
 *		none
 *
 *	global variables:
 *		int	oflag		output type flag
 *		FILE *	ofp		output file handle
 *
 *	functions called:
 *		VOID	iflush()	lkout.c
 *		VOID	sflush()	lkout.c
 *
 *	side effects:
 *		Any remaining REL data is flushed
 *		to the output file.
 */

VOID
lkflush()
{
	if (ofp == NULL)   { return; }

	/*
	 * Intel Formats
	 */
 	if (oflag == 1) {
		iflush();
	} else
	/*
	 * Motorola Formats
	 */
	if (oflag == 2) {
		sflush();
	}
}


/*Intel Format
 *      Record Mark Field    -  This  field  signifies  the  start  of a
 *                              record, and consists of an  ascii  colon
 *                              (:).
 *
 *      Record Length Field  -  This   field   consists   of  two  ascii
 *                              characters which indicate the number  of
 *                              data   bytes   in   this   record.   The
 *                              characters are the result of  converting
 *                              the  number  of  bytes  in binary to two
 *                              ascii characters, high digit first.   An
 *                              End  of  File  record contains two ascii
 *                              zeros in this field.
 *
 *      Load Address Field   -  This  field  consists  of the four ascii
 *                              characters which result from  converting
 *                              the  the  binary value of the address in
 *                              which to begin loading this record.  The
 *                              order is as follows:
 *
 *                                  High digit of high byte of address.
 *                                  Low digit of high byte of address.
 *                                  High digit of low byte of address.
 *                                  Low digit of low byte of address.
 *
 *                              In an End of File record this field con-
 *                              sists of four ascii zeros, in a start
 *				address record this is the program entry
 *				address (low), or in a segment record
 *				this is the high order address.
 *
 *      Record Type Field    -  This  field  identifies the record type,
 *                              which is either 0 for data records,  1
 *                              for an End of File record, 3 for a
 *				start address, or 4 for a
 *				segment record.  It consists
 *                              of two ascii characters, with  the  high
 *                              digit of the record type first, followed
 *                              by the low digit of the record type.
 *
 *      Data Field           -  This  field consists of the actual data,
 *                              converted to two ascii characters,  high
 *                              digit first.  There are no data bytes in
 *                              the End of File record.
 *
 *      Checksum Field       -  The  checksum  field is the 8 bit binary
 *                              sum of the record length field, the load
 *                              address  field,  the  record type field,
 *                              and the data field.  This  sum  is  then
 *                              negated  (2's  complement) and converted
 *                              to  two  ascii  characters,  high  digit
 *                              first.
 */

/*)Function	ixx(i)
 *
 *		int	i		1 - process data
 *					0 - end of data
 *
 *	The function ixx() loads the output buffer with
 *	the relocated data.
 *
 *	local variables:
 *		a_uint	chksum		byte checksum
 *		a_uint	lo_addr		address within segment
 *		a_uint	hi_addr		segment number
 *		int	i		loop counter
 *		a_uint	j		temporary
 *		int	k		loop counter
 *		struct sym *sp		symbol pointer
 *		a_uint	symadr		symbol address
 *
 *	global variables:
 *		int	a_bytes		T Line Address Bytes
 *		int	hilo		byte order
 *		FILE *	ofp		output file handle
 *		int	rtaflg		first output flag
 *		int	rtcnt		count of data words
 *		int	rtflg[]		output the data flag
 *		a_uint	rtval[]		relocated data
 *		char	rtbuf[]		output buffer
 *		a_uint	rtadr0		address temporary
 *		a_uint	rtadr1		address temporary
 *		a_uint	rtadr2		address temporary
 *
 *	functions called:
 *		int	fprintf()	c_library
 *		VOID	iflush()	lkout.c
 *
 *	side effects:
 *		The data is placed into the output buffer.
 */

/*
 * The number of Data Field bytes is:
 *
 *	1	Record Mark Field
 *	2	Record Length Field
 *	4	Load Address Field
 *	2	Record Type Field
 *	2	Checksum Field
 *
 *	Plus 32 data bytes (64 characters)
 */

#define	MAXBYTES	32

VOID
ixx(i)
int i;
{
	int k;
	struct sym *sp;
	a_uint j, lo_addr, hi_addr, symadr, chksum;


	if (i) {
		if (hilo == 0) {
			switch(a_bytes){
			default:
			case 2:
				j = rtval[0];
				rtval[0] = rtval[1];
				rtval[1] = j;
				break;
			case 3:
				j = rtval[0];
				rtval[0] = rtval[2];
				rtval[2] = j;
				break;
			case 4:
				j = rtval[0];
				rtval[0] = rtval[3];
				rtval[3] = j;
				j = rtval[2];
				rtval[2] = rtval[1];
				rtval[1] = j;
				break;
			}
		}
		for (i=0,rtadr2=0; i<a_bytes; i++) {
			rtadr2 = rtadr2 << 8 | rtval[i];
		}
		if ((rtadr2 != rtadr1) || rtaflg) {
			/*
			 * data bytes not contiguous between records
			 */
			iflush();
			rtadr0 = rtadr1 = rtadr2;
			rtaflg = 0;
		}
		for (k=a_bytes; k<rtcnt; k++) {
			if (rtflg[k]) {
				rtbuf[rtadr1++ - rtadr0] = rtval[k];
				if (rtadr1 - rtadr0 == MAXBYTES) {
					iflush();
				}
			}
		}
	} else {
		sp = lkpsym(".__.END.", 0);
		if (sp) {
			symadr = symval(sp);
			lo_addr = symadr & 0xffff;
			if (a_bytes > 2) {
				hi_addr = (symadr >> 16) & 0xffff;
				chksum =  0x00;
				chksum += hi_addr;
				chksum += hi_addr >> 8;
				chksum += 0x04;
				fprintf(ofp, ":00%04X04%02X\n", hi_addr, (~chksum + 1) & 0x00ff);
			}
			chksum =  0x00;
			chksum += lo_addr;
			chksum += lo_addr >> 8;
			chksum += 0x03;
			fprintf(ofp, ":00%04X03%02X\n", lo_addr, (~chksum + 1) & 0x00ff);
		}

		fprintf(ofp, ":00000001FF\n");
	}
}


/*)Function	iflush()
 *
 *	The function iflush() outputs the relocated data
 *	in the standard Intel format.
 *
 *	local variables:
 *		a_uint	chksum		byte checksum
 *		a_uint	lo_addr		address within segment
 *		a_uint	hi_addr		segment number
 *		int	i		loop counter
 *		int	max		number of data bytes
 *		int	reclen		record length
 *
 *	global variables:
 *		int	a_bytes		T Line Address Bytes
 *		FILE *	ofp		output file handle
 *		int	rtaflg		first output flag
 *		char	rtbuf[]		output buffer
 *		a_uint	rtadr0		address temporary
 *		a_uint	rtadr1		address temporary
 *
 *	functions called:
 *		int	fprintf()	c_library
 *
 *	side effects:
 *		The data is output to the file defined by ofp.
 */

/*
 * This function derived from the work
 * of G. Osborn, gary@s-4.com.
 * The new version concatenates the assembler
 * output records when they represent contiguous
 * memory segments to produces NMAX character
 * Intel Hex output lines whenever possible, resulting
 * in a substantial reduction in file size.
 * More importantly, the download time
 * to the target system is much improved.
 */

VOID
iflush()
{
	int i, max, reclen;
	a_uint chksum, lo_addr, hi_addr;

	max = rtadr1 - rtadr0;
	if (max) {

		/*
		 * Only the ":" and the checksum itself are excluded
		 * from the checksum.  The record length includes
		 * only the data bytes.
		 */
		lo_addr = rtadr0 & 0xffff;
		reclen = max;
		chksum = reclen;
		chksum += lo_addr;
		chksum += lo_addr >> 8;
		fprintf(ofp, ":%02X%04X00", reclen, lo_addr);
		for (i=0; i<max; i++) {
			chksum += rtbuf[i];
			fprintf(ofp, "%02X", rtbuf[i] & 0x00ff);
		}
		/*
		 * 2's complement
		 */
		fprintf(ofp, "%02X\n", (~chksum + 1) & 0x00ff);
		rtadr0 = rtadr1;
	}

	if (a_bytes > 2) {
		hi_addr = (rtadr2 >> 16) & 0xffff;
		if ((hi_addr != (rtadr1 >> 16)) || rtaflg) {
			chksum =  0x00;
			chksum += hi_addr;
			chksum += hi_addr >> 8;
			chksum += 0x04;
			fprintf(ofp, ":00%04X04%02X\n", hi_addr, (~chksum + 1) & 0x00ff);
		}
	}
}


/*)S19/S28/S37 Formats
 *      Record Type Field    -  This  field  signifies  the  start  of a
 *                              record and  identifies  the  the  record
 *                              type as follows:  
 *
 *             2-Byte Address:      Ascii S1 - Data Record 
 *                                  Ascii S9 - End of File Record 
 *             3-Byte Address:      Ascii S2 - Data Record 
 *                                  Ascii S8 - End of File Record 
 *             4-Byte Address:      Ascii S3 - Data Record 
 *                                  Ascii S7 - End of File Record 
 *
 *      Record Length Field  -  This  field  specifies the record length
 *                              which includes the  address,  data,  and
 *                              checksum   fields.   The  8  bit  record
 *                              length value is converted to  two  ascii
 *                              characters, high digit first.  
 *
 *      Load Address Field   -  This  field  consists  of the 4/6/8 ascii
 *                              characters which result from  converting
 *                              the  the  binary value of the address in
 *                              which to begin loading this record.  The
 *                              order is as follows:  
 *
 *           S37:                   High digit of fourth byte of address. 
 *                                  Low digit of fourth byte of address.  
 *           S28/S37:               High digit of third byte of address. 
 *                                  Low digit of third byte of address.  
 *           S19/S28/S37:           High digit of high byte of address. 
 *                                  Low digit of high byte of address.  
 *                                  High digit of low byte of address.  
 *                                  Low digit of low byte of address.  
 *
 *                              In an End of File record this field con-
 *                              sists of either 4/6/8 ascii zeros or  the
 *                              program  entry  address.
 *
 *      Data Field           -  This  field consists of the actual data,
 *                              converted to two ascii characters,  high
 *                              digit first.  There are no data bytes in
 *                              the End of File record.  
 *
 *      Checksum Field       -  The  checksum  field is the 8 bit binary
 *                              sum of the record length field, the load
 *                              address field, and the data field.  This
 *                              sum is then  complemented  (1's  comple-
 *                              ment)   and   converted   to  two  ascii
 *                              characters, high digit first.  
 */

/*)Function	sxx(i)
 *
 *		int	i		1 - process data
 *					0 - end of data
 *
 *	The function s19() loads the output buffer with
 *	the relocated data.
 *
 *	local variables:
 *		a_uint	addr		address temporary
 *		a_uint	chksum		byte checksum
 *		char *	frmt		format string pointer
 *		int	i		loop counter
 *		a_uint	j		temporary
 *		int	k		loop counter
 *		int	max		number of data bytes
 *		int	reclen		record length
 *		struct sym *sp		symbol pointer
 *		a_uint	symadr		symbol address
 *
 *	global variables:
 *		int	a_bytes		T Line Address Bytes
 *		int	hilo		byte order
 *		FILE *	ofp		output file handle
 *		int	rtcnt		count of data words
 *		int	rtflg[]		output the data flag
 *		a_uint	rtval[]		relocated data
 *		char	rtbuf[]		output buffer
 *		a_uint	rtadr0		address temporary
 *		a_uint	rtadr1		address temporary
 *		a_uint	rtadr2		address temporary
 *
 *	functions called:
 *		int	fprintf()	c_library
 *		VOID	sflush()	lkout.c
 *
 *	side effects:
 *		The data is placed into the output buffer.
 */

/*
 * Number of Data Field bytes is:
 *
 *	2	Record Type Field
 *	2	Record Length Field
 *	4/6/8	Load Address Field
 *	2	Checksum Field
 *
 *	Plus 32 data bytes (64 characters)
 */

#define	MAXBYTES	32

VOID
sxx(i)
int i;
{
	register struct sym *sp;
	register char *frmt;
	int k, reclen;
	a_uint	j, addr, symadr, chksum;

	if (i) {
		if (hilo == 0) {
			switch(a_bytes){
			default:
			case 2:
				j = rtval[0];
				rtval[0] = rtval[1];
				rtval[1] = j;
				break;
			case 3:
				j = rtval[0];
				rtval[0] = rtval[2];
				rtval[2] = j;
				break;
			case 4:
				j = rtval[0];
				rtval[0] = rtval[3];
				rtval[3] = j;
				j = rtval[2];
				rtval[2] = rtval[1];
				rtval[1] = j;
				break;
			}
		}
		for (i=0,rtadr2=0; i<a_bytes; i++) {
			rtadr2 = rtadr2 << 8 | rtval[i];
		}

		if (rtadr2 != rtadr1) {
			/*
			 * data bytes not contiguous between records
			 */
			sflush();
			rtadr0 = rtadr1 = rtadr2;
		}
		for (k=a_bytes; k<rtcnt; k++) {
			if (rtflg[k]) {
				rtbuf[rtadr1++ - rtadr0] = rtval[k];
				if (rtadr1 - rtadr0 == MAXBYTES) {
					sflush();
				}
			}
		}
	} else {
		/*
		 * Only the "S_" and the checksum itself are excluded
		 * from the checksum.  The record length does not
		 * include "S_" and the pair count.  It does
		 * include the address bytes, the data bytes,
		 * and the checksum.
		 */
		reclen = 1 + a_bytes;
		chksum = reclen;
		sp = lkpsym(".__.END.", 0);
		if (sp) {
			symadr = symval(sp);
			for (i=0,addr=symadr; i<a_bytes; i++,addr>>=8) {
				chksum += addr;
			}
		} else {
			symadr = 0;
		}
		switch(a_bytes) {
		default:
		case 2: frmt = "S9%02X%04X"; addr = symadr & 0x0000ffff; break;
		case 3: frmt = "S8%02X%06X"; addr = symadr & 0x00ffffff; break;
		case 4: frmt = "S7%02X%08X"; addr = symadr & 0xffffffff; break;
		}
		fprintf(ofp, frmt, reclen, addr);
		/*
		 * 1's complement
		 */
		fprintf(ofp, "%02X\n", (~chksum) & 0x00ff);
	}
}


/*)Function	sflush()
 *
 *	The function sflush() outputs the relocated data
 *	in the standard Motorola format.
 *
 *	local variables:
 *		a_uint	addr		address temporary
 *		a_uint	chksum		byte checksum
 *		char *	frmt		format string pointer
 *		int	i		loop counter
 *		int	max		number of data bytes
 *		int	reclen		record length
 *
 *	global variables:
 *		int	a_bytes		T Line Address Bytes
 *		FILE *	ofp		output file handle
 *		char	rtbuf[]		output buffer
 *		a_uint	rtadr0		address temporary
 *		a_uint	rtadr1		address temporary
 *
 *	functions called:
 *		int	fprintf()	c_library
 *
 *	side effects:
 *		The data is output to the file defined by ofp.
 */

/*
 * Written by G. Osborn, gary@s-4.com, 6-17-98.
 * The new version concatenates the assembler
 * output records when they represent contiguous
 * memory segments to produces NMAX character
 * S_ output lines whenever possible, resulting
 * in a substantial reduction in file size.
 * More importantly, the download time
 * to the target system is much improved.
 */

VOID
sflush()
{
	char *frmt;
	int i, max, reclen;
	a_uint	addr, chksum;

	max = rtadr1 - rtadr0;
	if (max == 0) {
		return;
	}

	/*
	 * Only the "S_" and the checksum itself are excluded
	 * from the checksum.  The record length does not
	 * include "S_" and the pair count.  It does
	 * include the address bytes, the data bytes,
	 * and the checksum.
	 */
	reclen = max + 1 + a_bytes;
	chksum = reclen;
	for (i=0,addr=rtadr0; i<a_bytes; i++,addr>>=8) {
		chksum += addr;
	}
	switch(a_bytes) {
	default:
	case 2: frmt = "S1%02X%04X"; addr = rtadr0 & 0x0000ffff; break;
	case 3: frmt = "S2%02X%06X"; addr = rtadr0 & 0x00ffffff; break;
	case 4: frmt = "S3%02X%08X"; addr = rtadr0 & 0xffffffff; break;
	}
	fprintf(ofp, frmt, reclen, addr);
	for (i=0; i<max; i++) {
		chksum += rtbuf[i];
		fprintf(ofp, "%02X", rtbuf[i] & 0x00ff);
	}
	/*
	 * 1's complement
	 */
	fprintf(ofp, "%02X\n", (~chksum) & 0x00ff);
	rtadr0 = rtadr1;
}



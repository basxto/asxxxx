/* lkihx.c */

/*
 * (C) Copyright 1989-1998
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 *
 *   With enhancements by
 * 	G. Osborn
 *	gary@s-4.com.  
 *
 */

#include <stdio.h>
#include <string.h>
#include <alloc.h>
#include "aslink.h"

/*)Module	lkihx.c
 *
 *	The module lkihx.c contains the function to
 *	output the relocated object code in the
 *	Intel Hex format.
 *
 *	lkihx.c contains the following functions:
 *		VOID	ihx()
 *		VOID	iflush()
 *
 *	lkihx.c contains no local variables.
 */

/*Intel Hex Format
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
 *                              sists of either four ascii zeros or  the
 *                              program  entry  address.   Currently the
 *                              entry address option is not supported.  
 *
 *      Record Type Field    -  This  field  identifies the record type,
 *                              which is either 0 for data records or  1
 *                              for  an End of File record.  It consists
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

/*)Function	ihx(i)
 *
 *		int	i		0 - process data
 *					1 - end of data
 *
 *	The function ihx() loads the output buffer with
 *	the relocated data.
 *
 *	local variables:
 *		addr_t	j		temporary
 *
 *	global variables:
 *		int	hilo		byte order
 *		FILE *	ofp		output file handle
 *		int	rtcnt		count of data words
 *		int	rtflg[]		output the data flag
 *		addr_t	rtval[]		relocated data
 *		char	rtbuf[]		output buffer
 *		addr_t	rtadr0		address temporary
 *		addr_t	rtadr1		address temporary
 *		addr_t	rtadr2		address temporary
 *
 *	functions called:
 *		int	fprintf()	c_library
 *		VOID	iflush()	lkihx.c
 *
 *	side effects:
 *		The data is placed into the output buffer.
 */

/*
 * The maximum number of Data Field bytes is NMAX less:
 *	1	Record Mark Field
 *	2	Record Length Field
 *	4	Load Address Field
 *	2	Record Type Field
 *	2	Checksum Field
 *
 *	Divided by 2 (2 characters per byte)
 */

#define	MAXBYTES	((NMAX - 11)/2)

VOID
ihx(i)
int i;
{
	register addr_t j;

	if (i) {
		if (hilo == 0) {
			j = rtval[0];
			rtval[0] = rtval[1];
			rtval[1] = j;
		}
		rtadr2 = rtval[0] << 8 | rtval[1];
		if (rtadr2 != rtadr1) {
			/*
			 * data bytes not contiguous between records
			 */
			iflush();
			rtadr0 = rtadr1 = rtadr2;
		}
		for (j=2; j<rtcnt; j++) {
			if (rtflg[j]) {
				rtbuf[rtadr1++ - rtadr0] = rtval[j];
				if (rtadr1 - rtadr0 == MAXBYTES) {
					iflush();
				}
			}
		}
	} else {
		iflush();
		fprintf(ofp, ":00000001FF\n");
	}
}

/*)Function	iflush()
 *
 *	The function iflush() outputs the relocated data
 *	in the standard Intel Hex format.
 *
 *	local variables:
 *		addr_t	chksum		byte checksum
 *		int	i		loop counter
 *		int	max		number of data bytes
 *		int	reclen		record length
 *
 *	global variables:
 *		FILE *	ofp		output file handle
 *		char	rtbuf[]		output buffer
 *		addr_t	rtadr0		address temporary
 *		addr_t	rtadr1		address temporary
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
	addr_t	chksum;
	register int i,max,reclen;

	max = rtadr1 - rtadr0;
	if (max == 0) {
		return;
	}

	/*
	 * Only the ":" and the checksum itself are excluded
	 * from the checksum.  The record length includes
	 * only the data bytes.
	 */
	reclen = max;
	chksum = reclen;
	chksum += rtadr0;
	chksum += rtadr0 >> 8;
	fprintf(ofp, ":%02X%04X00", reclen, rtadr0);
	for (i=0; i<max; i++) {
		chksum += rtbuf[i];
		fprintf(ofp, "%02X", rtbuf[i] & 0x00ff);
	}
	/*
	 * 2's complement
	 */
	fprintf(ofp, "%02X\n", (-chksum) & 0x00ff);
	rtadr0 = rtadr1;
}

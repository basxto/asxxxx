/* lks19.c */

/*
 * (C) Copyright 1989-1999
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

/*)Module	lks19.c
 *
 *	The module lks19.c contains the functions to
 *	output the relocated object code in the
 *	Motorola S19 format.
 *
 *	lks19.c contains the following functions:
 *		VOID	s19()
 *		VOID	sflush()
 *
 *	lks19.c contains no local variables.
 */

/*)S19 Format
 *      Record Type Field    -  This  field  signifies  the  start  of a
 *                              record and  identifies  the  the  record
 *                              type as follows:  
 *
 *                                  Ascii S1 - Data Record 
 *                                  Ascii S9 - End of File Record 
 *
 *      Record Length Field  -  This  field  specifies the record length
 *                              which includes the  address,  data,  and
 *                              checksum   fields.   The  8  bit  record
 *                              length value is converted to  two  ascii
 *                              characters, high digit first.  
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

/*)Function	s19(i)
 *
 *		int	i		0 - process data
 *					1 - end of data
 *
 *	The function s19() loads the output buffer with
 *	the relocated data.
 *
 *	local variables:
 *		addr_t	j		temporary
 *
 *	global variables:
 *		int	hilo		byte order
 *		int	obj_flag	linked file/library object output flag
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
 *		VOID	sflush()	lks19.c
 *
 *	side effects:
 *		The data is placed into the output buffer.
 */

/*
 * Number of Data Field bytes is:
 *
 *	2	Record Type Field
 *	2	Record Length Field
 *	4	Load Address Field
 *	2	Checksum Field
 *
 *	Plus 32 data bytes (64 characters)
 */

#define	MAXBYTES	32

VOID
s19(i)
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
			sflush();
			rtadr0 = rtadr1 = rtadr2;
		}
		if (obj_flag == 0) {
			for (j=2; j<rtcnt; j++) {
				if (rtflg[j]) {
					rtbuf[rtadr1++ - rtadr0] = rtval[j];
					if (rtadr1 - rtadr0 == MAXBYTES) {
						sflush();
					}
				}
			}
		}
	} else {
		sflush();
		fprintf(ofp, "S9030000FC\n");
	}
}

/*)Function	sflush()
 *
 *	The function sflush() outputs the relocated data
 *	in the standard Motorola S19 format.
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
 * Written by G. Osborn, gary@s-4.com, 6-17-98.
 * The new version concatenates the assembler
 * output records when they represent contiguous
 * memory segments to produces NMAX character
 * S-19 output lines whenever possible, resulting
 * in a substantial reduction in file size.
 * More importantly, the download time
 * to the target system is much improved.
 */

VOID
sflush()
{
	addr_t	chksum;
	register int i,max,reclen;

	max = rtadr1 - rtadr0;
	if (max == 0) {
		return;
	}

	/*
	 * Only the "S1" and the checksum itself are excluded
	 * from the checksum.  The record length does not
	 * include "S1" and the pair count.  It does
	 * include the two address bytes, the data bytes,
	 * and the checksum.
	 */
	reclen = max + 3;
	chksum = reclen;
	chksum += rtadr0;
	chksum += rtadr0 >> 8;
	fprintf(ofp, "S1%02X%04X", reclen, rtadr0);
	for (i=0; i<max; i++) {
		chksum += rtbuf[i];
		fprintf(ofp, "%02X", rtbuf[i] & 0x00ff);
	}
	/*
	 * 1's complement
	 */
	fprintf(ofp, "%02X\n", (-chksum-1) & 0x00ff);
	rtadr0 = rtadr1;
}

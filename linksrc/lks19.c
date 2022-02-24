/* lks19.c */

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

VOID
s19(i)
{
	register chksum;

	if (i) {
		if (hilo == 0) {
			chksum = rtval[0];
			rtval[0] = rtval[1];
			rtval[1] = chksum;
		}
		chksum = rtcnt+1;
		fprintf(ofp, "S1%02X", chksum);
		for (i = 0; i < rtcnt ; ++i) {
			fprintf(ofp, "%02X", rtval[i]);
			chksum += rtval[i];
		}
		fprintf(ofp, "%02X\n", (-chksum-1) & 0xff);
	} else {
		fprintf(ofp, "S9030000FC\n");
	}
}

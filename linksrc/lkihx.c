/* lkihx.c */

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
ihx(i)
{
	register chksum;

	if (i) {
		if (hilo == 0) {
			chksum = rtval[0];
			rtval[0] = rtval[1];
			rtval[1] = chksum;
		}
		chksum = rtcnt-2;
		fprintf(ofp, ":%02X", chksum);
		for (i = 0; i < rtcnt ; ++i) {
			fprintf(ofp, "%02X", rtval[i]);
			chksum += rtval[i];
			if (i == 1) {
				fprintf(ofp, "00");
			}
		}
		fprintf(ofp, "%02X\n", (-chksum) & 0xff);
	} else {
		fprintf(ofp, ":00000001FF\n");
	}
}

/* ds8ext.c */

/*
 * Modified from i51ext.c
 * Bill McKinnon
 * w_mckinnon at conknet dot com
 *
 * (C) Copyright 1998-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 *
 *   This Assember Ported by
 *	jhartman at compuserve dot com
 *	noice at noicedebugger dot com
 *
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "ds8.h"

char	*cpu	= "Dallas Semiconductor [User Defined]";
int	hilo	= 1;
char	*dsft	= "asm";

/* m430ext.c */

/*
 * (C) Copyright 2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include <string.h>
#include "asxxxx.h"

char	*cpu	= "Texas Instruments MSP430";
int	hilo	= 0;
char	*dsft	= "asm";

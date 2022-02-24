/* m09ext.c */

/*
 * (C) Copyright 1989
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include "asm.h"

char	*cpu	= "Motorola 6809";
char	*dsft	= "asm";
int	hilo	= 1;

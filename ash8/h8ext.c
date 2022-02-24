/* h8ext.c */

/*
 * (C) Copyright 1994-1995
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include "asm.h"

char	*cpu	= "Hitachi H8/3xx";
char	*dsft	= "ASM";
int	hilo	= 1;

/* ez80ext.c */

/*
 * (C) Copyright 1989-2004
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "ez80.h"

char	*cpu	= "Zilog eZ80";
int	hilo	= 0;
char	*dsft	= "asm";

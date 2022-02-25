/* z80ext.c */

/*
 * (C) Copyright 1989-2002
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "gb.h"

char	*cpu	= "Gameboy";
int	hilo	= 0;
char	*dsft	= "asm";

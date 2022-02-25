/* rabext.c */

/*
 * (C) Copyright 1989-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 * 
 * ported to the Rabbit2000 by
 * Ulrich Raich and Razaq Ijoduola
 * PS Division
 * CERN
 * CH-1211 Geneva-23
 * email: Ulrich.Raich@cern.ch
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "rab.h"

char	*cpu	= "Rabbit 2000";
int	hilo	= 0;
char	*dsft	= "asm";

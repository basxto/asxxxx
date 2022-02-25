/* avrext.c */

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
#include "asxxxx.h"
#include "avr.h"

char	*cpu	= "Atmel AVR 8-Bit RISC";
int	hilo	= 0;
char	*dsft	= "asm";

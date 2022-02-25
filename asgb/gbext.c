/* gbext.c */

/*
 * (C) Copyright 1989-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/* Gameboy mods by Roger Ivie (ivie at cc dot usu dot edu); see gb.h for more info 
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "gb.h"

char	*cpu	= "Gameboy";
int	hilo	= 0;
char	*dsft	= "asm";

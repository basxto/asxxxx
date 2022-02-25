/* s6186ext.c */

/*
 * (C) Copyright 1989-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 *
 * Ported for SC61860 by Edgar Puehringer
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "s61860.h"

char	*cpu	= "Sharp SC61860";
int	hilo	= 1;
char	*dsft	= "asm";

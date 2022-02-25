/* m74ext.c */

/*
 * (C) Copyright 2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*
 * Contributions by
 *
 * Uwe Steller
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "m740.h"

char *cpu  = "Mitsubishi 740 family";
int hilo   = 0;
char *dsft = "asm";

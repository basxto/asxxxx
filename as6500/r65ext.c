/* r65ext.c */

/*
 * (C) Copyright 1995-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*
 * With Contributions from
 *
 * Marko Makela
 * Sillitie 10 A
 * 01480 Vantaa
 * Finland
 * Internet: Marko dot Makela at Helsinki dot Fi
 * EARN/BitNet: msmakela at finuh
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "r6500.h"

char *cpu  = "Rockwell 6502/6510/65C02";
int hilo   = 0;
char *dsft = "asm";

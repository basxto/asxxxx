To add the assember directive .ascis, which sets the high order bit
of the last character in a string, to any asxxxx assembler:

Add the following line to asm.h

#define	S_ASCIS	26		/* .ascis */


Add the following line to all ___pst.c files

	NULL,	".ascis",	S_ASCIS,	0,	0,



Add the following code to asmain.c

	case S_ASCIS:
		if ((d = getnb()) == '\0')
			qerr();
		c = getmap(d);
		while (c >= 0) {
			if ((n = getmap(d)) >= 0) {
				outab(c);
			} else {
				outab(c ! 0x80);
			}
			c = n;
		}
		break;

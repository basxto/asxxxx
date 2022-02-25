/* i85pst.c */

/*
 * (C) Copyright 1989-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

#include <stdio.h>
#include <setjmp.h>
#include "asxxxx.h"
#include "i8085.h"

/*
 * Coding Banks
 */
struct	bank	bank[2] = {
    /*	The '_CODE' area/bank has a NULL default file suffix.	*/
    {	NULL,		"_CSEG",	NULL,		0,	0,	0,	0,	0	},
    {	&bank[0],	"_DSEG",	"_DS",		1,	0,	0,	0,	B_FSFX	}
};

/*
 * Coding Areas
 */
struct	area	area[2] = {
    {	NULL,		&bank[0],	"_CODE",	0,	0,	0,	A_1BYTE|A_BNK|A_CSEG	},
    {	&area[0],	&bank[1],	"_DATA",	1,	0,	0,	A_1BYTE|A_BNK|A_DSEG	}
};

/*
 * Basic Relocation Mode Definition
 *
 *	#define		R_NORM	0000		No Bit Positioning
 */
char	mode0[32] = {	/* R_NORM */
	'\200',	'\201',	'\202',	'\203',	'\204',	'\205',	'\206',	'\207',
	'\210',	'\211',	'\212',	'\213',	'\214',	'\215',	'\216',	'\217',
	'\220',	'\221',	'\222',	'\223',	'\224',	'\225',	'\226',	'\227',
	'\230',	'\231',	'\232',	'\233',	'\234',	'\235',	'\236',	'\237'
};

/*
 * Additional Relocation Mode Definitions
 */

/* None Required */

/*
 *     *m_def is a pointer to the bit relocation definition.
 *	m_flag indicates that bit position swapping is required.
 *	m_mask contains the active bit positions for the output.
 *	m_mbro contains the active bit positions for the input.
 *
 *	struct	vsd
 *	{
 *		char *	m_def;		Bit Relocation Definition
 *		int	m_flag;		Bit Swapping Flag
 *		int	m_mask;		Bit Mask
 *		int	m_mbro;		Bit Range Overflow Mask
 *	};
 */
struct	mode	mode[1] = {
    {	&mode0[0],	0,	0x0000FFFF,	0x0000FFFF	}
};

/*
 * Array of Pointers to VSD Structures
 */
struct	mode	*modep[16] = {
	&mode[0],	NULL,		NULL,		NULL,
	NULL,		NULL,		NULL,		NULL,
	NULL,		NULL,		NULL,		NULL,
	NULL,		NULL,		NULL,		NULL
};

/*
 * Mnemonic Structure
 */
struct	mne	mne[] = {

	/* machine */

	/* system */

    {	NULL,	"CSEG",		S_ATYP,		0,	A_CSEG|A_1BYTE	},
    {	NULL,	"DSEG",		S_ATYP,		0,	A_DSEG|A_1BYTE	},

	/* system */

    {	NULL,	"BANK",		S_ATYP,		0,	A_BNK	},
    {	NULL,	"CON",		S_ATYP,		0,	A_CON	},
    {	NULL,	"OVR",		S_ATYP,		0,	A_OVR	},
    {	NULL,	"REL",		S_ATYP,		0,	A_REL	},
    {	NULL,	"ABS",		S_ATYP,		0,	A_ABS	},
    {	NULL,	"NOPAG",	S_ATYP,		0,	A_NOPAG	},
    {	NULL,	"PAG",		S_ATYP,		0,	A_PAG	},

    {	NULL,	"BASE",		S_BTYP,		0,	B_BASE	},
    {	NULL,	"SIZE",		S_BTYP,		0,	B_SIZE	},
    {	NULL,	"FSFX",		S_BTYP,		0,	B_FSFX	},
    {	NULL,	"MAP",		S_BTYP,		0,	B_MAP	},

    {	NULL,	".page",	S_PAGE,		0,	0	},
    {	NULL,	".title",	S_HEADER,	0,	O_TITLE	},
    {	NULL,	".sbttl",	S_HEADER,	0,	O_SBTTL	},
    {	NULL,	".module",	S_MODUL,	0,	0	},
    {	NULL,	".include",	S_INCL,		0,	0	},
    {	NULL,	".area",	S_AREA,		0,	0	},
    {	NULL,	".bank",	S_BANK,		0,	0	},
    {	NULL,	".org",		S_ORG,		0,	0	},
    {	NULL,	".radix",	S_RADIX,	0,	0	},
    {	NULL,	".globl",	S_GLOBL,	0,	0	},
    {	NULL,	".local",	S_LOCAL,	0,	0	},
    {	NULL,	".if",		S_CONDITIONAL,	0,	O_IF	},
    {	NULL,	".else",	S_CONDITIONAL,	0,	O_ELSE	},
    {	NULL,	".endif",	S_CONDITIONAL,	0,	O_ENDIF	},
    {	NULL,	".ifdef",	S_CONDITIONAL,	0,	O_IFDEF	},
    {	NULL,	".ifndef",	S_CONDITIONAL,	0,	O_IFNDEF},
    {	NULL,	".list",	S_LISTING,	0,	O_LIST	},
    {	NULL,	".nlist",	S_LISTING,	0,	O_NLIST	},
    {	NULL,	".equ",		S_EQU,		0,	O_EQU	},
    {	NULL,	".gblequ",	S_EQU,		0,	O_GBLEQU},
    {	NULL,	".lclequ",	S_EQU,		0,	O_LCLEQU},
    {	NULL,	".byte",	S_DATA,		0,	O_1BYTE	},
    {	NULL,	".db",		S_DATA,		0,	O_1BYTE	},
    {	NULL,	".fcb",		S_DATA,		0,	O_1BYTE	},
    {	NULL,	".word",	S_DATA,		0,	O_2BYTE	},
    {	NULL,	".dw",		S_DATA,		0,	O_2BYTE	},
    {	NULL,	".fdb",		S_DATA,		0,	O_2BYTE	},
/*    {	NULL,	".3byte",	S_DATA,		0,	O_3BYTE	},	*/
/*    {	NULL,	".triple",	S_DATA,		0,	O_3BYTE	},	*/
/*    {	NULL,	".4byte",	S_DATA,		0,	O_4BYTE	},	*/
/*    {	NULL,	".quad",	S_DATA,		0,	O_4BYTE	},	*/
    {	NULL,	".blkb",	S_BLK,		0,	O_1BYTE	},
    {	NULL,	".ds",		S_BLK,		0,	O_1BYTE	},
    {	NULL,	".rmb",		S_BLK,		0,	O_1BYTE	},
    {	NULL,	".rs",		S_BLK,		0,	O_1BYTE	},
    {	NULL,	".blkw",	S_BLK,		0,	O_2BYTE	},
/*    {	NULL,	".blk3",	S_BLK,		0,	O_3BYTE	},	*/
/*    {	NULL,	".blk4",	S_BLK,		0,	O_4BYTE	},	*/
    {	NULL,	".ascii",	S_ASCIX,	0,	O_ASCII	},
    {	NULL,	".ascis",	S_ASCIX,	0,	O_ASCIS	},
    {	NULL,	".asciz",	S_ASCIX,	0,	O_ASCIZ	},
    {	NULL,	".str",		S_ASCIX,	0,	O_ASCII	},
    {	NULL,	".strs",	S_ASCIX,	0,	O_ASCIS	},
    {	NULL,	".strz",	S_ASCIX,	0,	O_ASCIZ	},
    {	NULL,	".fcc",		S_ASCIX,	0,	O_ASCII	},
    {	NULL,	".define",	S_DEFINE,	0,	O_DEF	},
    {	NULL,	".undefine",	S_DEFINE,	0,	O_UNDEF	},
    {	NULL,	".even",	S_BOUNDARY,	0,	O_EVEN	},
    {	NULL,	".odd",		S_BOUNDARY,	0,	O_ODD	},
    {	NULL,	".msg"	,	S_MSG,		0,	0	},
    {	NULL,	".assume",	S_ERROR,	0,	O_ASSUME},
    {	NULL,	".error",	S_ERROR,	0,	O_ERROR	},
/*    {	NULL,	".msb",		S_MSB,		0,	0	},	*/
/*    {	NULL,	".8bit",	S_BITS,		0,	O_1BYTE	},	*/
/*    {	NULL,	".16bit",	S_BITS,		0,	O_2BYTE	},	*/
/*    {	NULL,	".24bit",	S_BITS,		0,	O_3BYTE	},	*/
/*    {	NULL,	".32bit",	S_BITS,		0,	O_4BYTE	},	*/
    {	NULL,	".end",		S_END,		0,	0	},

	/* 8080/8085 */

    {	NULL,	"b",		S_REG,		0,	B	},
    {	NULL,	"c",		S_REG,		0,	C	},
    {	NULL,	"bc",		S_REG,		0,	B	},
    {	NULL,	"d",		S_REG,		0,	D	},
    {	NULL,	"e",		S_REG,		0,	E	},
    {	NULL,	"de",		S_REG,		0,	D	},
    {	NULL,	"h",		S_REG,		0,	H	},
    {	NULL,	"l",		S_REG,		0,	L	},
    {	NULL,	"hl",		S_REG,		0,	H	},
    {	NULL,	"m",		S_REG,		0,	M	},
    {	NULL,	"psw",		S_REG,		0,	PSW	},
    {	NULL,	"a",		S_REG,		0,	A	},
    {	NULL,	"af",		S_REG,		0,	PSW	},
    {	NULL,	"sp",		S_REG,		0,	SP	},

    {	NULL,	"xthl",		S_INH,		0,	0343	},
    {	NULL,	"sphl",		S_INH,		0,	0371	},
    {	NULL,	"pchl",		S_INH,		0,	0351	},
    {	NULL,	"xchg",		S_INH,		0,	0353	},
    {	NULL,	"ret",		S_INH,		0,	0311	},
    {	NULL,	"rc",		S_INH,		0,	0330	},
    {	NULL,	"rnc",		S_INH,		0,	0320	},
    {	NULL,	"rz",		S_INH,		0,	0310	},
    {	NULL,	"rnz",		S_INH,		0,	0300	},
    {	NULL,	"rp",		S_INH,		0,	0360	},
    {	NULL,	"rm",		S_INH,		0,	0370	},
    {	NULL,	"rpe",		S_INH,		0,	0350	},
    {	NULL,	"rpo",		S_INH,		0,	0340	},
    {	NULL,	"rim",		S_INH,		0,	0040	},
    {	NULL,	"rlc",		S_INH,		0,	0007	},
    {	NULL,	"rrc",		S_INH,		0,	0017	},
    {	NULL,	"ral",		S_INH,		0,	0027	},
    {	NULL,	"rar",		S_INH,		0,	0037	},
    {	NULL,	"cma",		S_INH,		0,	0057	},
    {	NULL,	"stc",		S_INH,		0,	0067	},
    {	NULL,	"cmc",		S_INH,		0,	0077	},
    {	NULL,	"daa",		S_INH,		0,	0047	},
    {	NULL,	"ei",		S_INH,		0,	0373	},
    {	NULL,	"di",		S_INH,		0,	0363	},
    {	NULL,	"nop",		S_INH,		0,	0000	},
    {	NULL,	"hlt",		S_INH,		0,	0166	},
    {	NULL,	"sim",		S_INH,		0,	0060	},

    {	NULL,	"rst",		S_RST,		0,	0307	},

    {	NULL,	"in",		S_ADI,		0,	0333	},
    {	NULL,	"out",		S_ADI,		0,	0323	},
    {	NULL,	"adi",		S_ADI,		0,	0306	},
    {	NULL,	"aci",		S_ADI,		0,	0316	},
    {	NULL,	"sui",		S_ADI,		0,	0326	},
    {	NULL,	"sbi",		S_ADI,		0,	0336	},
    {	NULL,	"ani",		S_ADI,		0,	0346	},
    {	NULL,	"xri",		S_ADI,		0,	0356	},
    {	NULL,	"ori",		S_ADI,		0,	0366	},
    {	NULL,	"cpi",		S_ADI,		0,	0376	},

    {	NULL,	"add",		S_ADD,		0,	0200	},
    {	NULL,	"adc",		S_ADD,		0,	0210	},
    {	NULL,	"sub",		S_ADD,		0,	0220	},
    {	NULL,	"sbb",		S_ADD,		0,	0230	},
    {	NULL,	"ana",		S_ADD,		0,	0240	},
    {	NULL,	"xra",		S_ADD,		0,	0250	},
    {	NULL,	"ora",		S_ADD,		0,	0260	},
    {	NULL,	"cmp",		S_ADD,		0,	0270	},

    {	NULL,	"sta",		S_JMP,		0,	0062	},
    {	NULL,	"lda",		S_JMP,		0,	0072	},
    {	NULL,	"shld",		S_JMP,		0,	0042	},
    {	NULL,	"lhld",		S_JMP,		0,	0052	},
    {	NULL,	"jmp",		S_JMP,		0,	0303	},
    {	NULL,	"jc",		S_JMP,		0,	0332	},
    {	NULL,	"jnc",		S_JMP,		0,	0322	},
    {	NULL,	"jz",		S_JMP,		0,	0312	},
    {	NULL,	"jnz",		S_JMP,		0,	0302	},
    {	NULL,	"jp",		S_JMP,		0,	0362	},
    {	NULL,	"jm",		S_JMP,		0,	0372	},
    {	NULL,	"jpe",		S_JMP,		0,	0352	},
    {	NULL,	"jpo",		S_JMP,		0,	0342	},
    {	NULL,	"call",		S_JMP,		0,	0315	},
    {	NULL,	"cc",		S_JMP,		0,	0334	},
    {	NULL,	"cnc",		S_JMP,		0,	0324	},
    {	NULL,	"cz",		S_JMP,		0,	0314	},
    {	NULL,	"cnz",		S_JMP,		0,	0304	},
    {	NULL,	"cp",		S_JMP,		0,	0364	},
    {	NULL,	"cm",		S_JMP,		0,	0374	},
    {	NULL,	"cpe",		S_JMP,		0,	0354	},
    {	NULL,	"cpo",		S_JMP,		0,	0344	},

    {	NULL,	"inr",		S_INR,		0,	0004	},
    {	NULL,	"dcr",		S_INR,		0,	0005	},

    {	NULL,	"lxi",		S_LXI,		0,	0001	},

    {	NULL,	"ldax",		S_LDAX,		0,	0012	},
    {	NULL,	"stax",		S_LDAX,		0,	0002	},

    {	NULL,	"inx",		S_INX,		0,	0003	},
    {	NULL,	"dcx",		S_INX,		0,	0013	},
    {	NULL,	"dad",		S_INX,		0,	0011	},

    {	NULL,	"push",		S_PUSH,		0,	0305	},
    {	NULL,	"pop",		S_PUSH,		0,	0301	},

    {	NULL,	"mov",		S_MOV,		0,	0100	},

    {	NULL,	"mvi",		S_MVI,		S_EOL,	0006	}
};

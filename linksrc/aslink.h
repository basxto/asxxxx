/* aslink.h */

/*
 * (C) Copyright 1989
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*)BUILD
	$(PROGRAM) =	ASLINK
	$(INCLUDE) =	ASLINK.H
	$(FILES) = {
		LKMAIN.C
		LKLEX.C
		LKAREA.C
		LKHEAD.C
		LKSYM.C
		LKEVAL.C
		LKDATA.C
		LKLIST.C
		LKRLOC.C
		LKS19.C
		LKIHX.C
	}
	$(STACK) = 2000
*/

/* DECUS C void definition */

#ifdef	decus
#define	VOID	char
#else
#define	VOID	void
#endif

/*
 * Case Sensitivity Flag
 */
#define	CASE_SENSITIVE	1

/*
 * This file defines the format of the
 * relocatable binary file.
 */

#define	NCPS	8		/* characters per symbol */
#define	NDATA	16		/* actual data */
#define	NINPUT	128		/* Input buffer size */
#define	NHASH	64		/* Buckets in hash table */
#define	HMASK	077		/* Hash mask */
#define	NLPP	60		/* Lines per page */
#define	NTXT	16		/* T values */
#define	FILSPC	16		/* File spec length */

/*
 * Relocation types.
 */
#define  R_WORD	0	/* 16 bit */
#define	 R_BYTE 01

#define	 R_AREA	0	/* Base type */
#define  R_SYM	02

#define	 R_NORM	0	/* PC adjust */
#define	 R_PCR	04

/*
 * Global symbol types.
 */
#define	S_REF	1		/* referenced */
#define	S_DEF	2		/* defined */

/*
 * Area types
 */
#define	A_CON	000		/* concatenate */
#define	A_OVR	004		/* overlay */
#define	A_REL	000		/* relocatable */
#define	A_ABS	010		/* absolute */

/*
 * File types
 */
#define	F_STD	1		/* stdin */
#define	F_LNK	2		/* File.lnk */
#define	F_REL	3		/* File.rel */

typedef unsigned addr_t;

struct	head
{
	struct	head   *h_hp;	/* Header link */
	struct	lfile  *h_lfile;/* Associated file */
	int	h_narea;	/* # of areas */
	VOID	**a_list;	/* Area list */
	int	h_nglob;	/* # of global symbols */
	VOID	**s_list;	/* Globle symbol list */
	char	m_id[NCPS];	/* Module name */
};

struct	area
{
	struct	area	*a_ap;	/* Area link */
	struct	areax	*a_axp;	/* Area extension link */
	addr_t	a_addr;		/* Beginning address of area */
	addr_t	a_size;		/* Total size of the area */
	char	a_type;		/* Area subtype */
	char	a_flag;		/* Flag byte */
	char	a_id[NCPS];	/* Name */
};

struct	areax
{
	struct	areax	*a_axp;	/* Area extension link */
	addr_t	a_addr;		/* Beginning address of section */
	addr_t	a_size;		/* Size of the area in section */
};

struct	sym
{
	struct	sym	*s_sp;	/* Symbol link */
	struct	areax	*s_axp;	/* Symbol area link */
	char	s_type;		/* Symbol subtype */
	char	s_flag;		/* Flag byte */
	addr_t	s_addr;		/* Address */
	char	s_id[NCPS];	/* Name */
};

struct	lfile
{
	struct	lfile	*f_flp;	/* lfile link */
	int	f_type;		/* File type */
	char	*f_idp;		/* Pointer to file spec */
};

struct	base
{
	struct	base  *b_base;	/* Base link */
	char	      *b_strp;	/* String pointer */
};

struct	globl
{
	struct	globl *g_globl;	/* Global link */
	char	      *g_strp;	/* String pointer */
};

#define	LETTER	0
#define	DIGIT	1
#define	BINOP	2
#define ETC	3
#define	ILL	4
#define	SPACE	5

/* Variable definitions */

extern		char	*_abs_;
extern		char	*dext;
extern		char	*ip;
extern		char	ib[NINPUT];
extern		char	ctype[];

#if	CASE_SENSITIVE
#else
extern		char	ccase[];
#endif

extern	struct	lfile	*startp;
extern	struct	lfile	*linkp;
extern	struct	lfile	*lfp;
extern	struct	lfile	*filep;
extern	struct	lfile	*cfp;
extern	struct	head	*headp;
extern	struct	head	*hp;
extern	struct	area	*areap;
extern	struct	area	*ap;
extern	struct	areax	*axp;
extern	struct	sym	*symhash[NHASH];
extern	struct	base	*basep;
extern	struct	base	*bsp;
extern	struct	globl	*globlp;
extern	struct	globl	*gsp;

extern		FILE	*sfp;
extern		FILE	*ofp;
extern		FILE	*mfp;
extern		int	inpfil;
extern		int	cfile;
extern		int	oflag;
extern		int	sflag;
extern		int	mflag;
extern		int	xflag;
extern		int	pflag;
extern		int	radix;
extern		int	hilo;
extern		int	pass;
extern		int	line;
extern		int	page;
extern		int	lop;
extern		int	rtcnt;
extern		int	rtval[];

/* C Library function definitions */
/* for reference only
extern	VOID *		calloc();
extern	VOID		exit();
extern	int		fclose();
extern	char *		fgets();
extern	FILE *		fopen();
extern	int		fprintf();
extern	VOID		free();
extern	VOID *		malloc();
extern	char		putc();
extern	char *		strcpy();
extern	int		strlen();
extern	char *		strncpy();
*/

/* Program function definitions */

/* lkmain.c */
extern	FILE *		afile();
extern	VOID		bassav();
extern	VOID		gblsav();
extern	VOID		link();
extern	VOID		main();
extern	VOID		map();
extern	int		parse();
extern	VOID		setbas();
extern	VOID		setgbl();
extern	VOID		usage();

/* lklex.c */
extern	char		endline();
extern	char		get();
extern	VOID		getfid();
extern	VOID		getid();
extern	int		getline();
extern	char		getmap();
extern	char		getnb();
extern	int		more();
extern	VOID		skip();
extern	VOID		unget();

/* lkarea.c */
extern	VOID		lkparea();
extern	VOID		lnkarea();
extern	VOID		lnksect();
extern	VOID		newarea();

/* lkhead.c */
extern	VOID		module();
extern	VOID		newhead();

/* lksym.c */
extern	int		hash();
extern	struct	sym *	lkpsym();
extern	VOID *		new();
extern	struct	sym *	newsym();
extern	VOID		symdef();
extern	int		symeq();
extern	VOID		syminit();
extern	VOID		symmod();
extern	int		symval();

/* lkeval.c */
extern	int		digit();
extern	int		eval();
extern	int		expr();
extern	int		oprio();
extern	int		term();

/* lklist.c */
extern	VOID		lstarea();
extern	VOID		newpag();
extern	VOID		slew();

/* lkrloc.c */
extern	int		add_b();
extern	int		add_w();
extern	int		evword();
extern	VOID		rele();
extern	VOID		reloc();
extern	VOID		relr();
extern	VOID		relt();

/* lks19.c */
extern	VOID		s19();

/* lkihx.c */
extern	VOID		ihx();

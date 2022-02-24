/* h8.h */

/*
 * (C) Copyright 1994-1995
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*)BUILD
	$(PROGRAM) =	ASH8
	$(INCLUDE) = {
		ASM.H
		H8.H
	}
	$(FILES) = {
		H8EXT.C
		H8MCH.C
		H8ADR.C
		H8PST.C
		ASMAIN.C
		ASLEX.C
		ASSYM.C
		ASSUBR.C
		ASEXPR.C
		ASDATA.C
		ASLIST.C
		ASOUT.C
	}
	$(STACK) = 2000
*/

/*
 * Addressing types
 */
#define	S_BREG		30
#define	S_WREG		31
#define	S_CREG		32
#define	S_IMMB		33
#define	S_IMMW		34
#define	S_INDR		35
#define	S_INDI		36
#define	S_INDD		37
#define	S_INDO		38
#define	S_INDM		39
#define	S_EXT		40
#define S_DIR		41

/*
 * Direct Page (first 256 bytes)
 */
#define	S_SDP		49

/*
 * H8 Instruction types
 */
#define	S_OP		50
#define	S_OPS		51
#define	S_OPX		52
#define	S_ADD		53
#define	S_CMP		54
#define	S_MOV		55
#define	S_SUB		56
#define	S_SOP		57
#define	S_CCR		58
#define	S_INH		59
#define	S_MLDV		60
#define	S_ROSH		61
#define	S_PP		62
#define	S_MVFPE		63
#define	S_MVTPE		64
#define	S_EEPMOV	65
#define	S_JXX		66
#define	S_BIT1		67
#define	S_BIT2		68
#define	S_BRA		69

/*
 * Variables
 */
extern int index;

struct	sdp
{
	addr_t	s_addr;
	struct	area *	s_area;
};

struct adsym
{
	char	a_str[4];	/* addressing string */
	int	a_val;		/* addressing mode value */
};

extern struct adsym bytereg[];
extern struct adsym wordreg[];
extern struct adsym autoinc[];
extern struct adsym autodec[];
extern struct adsym ccr_reg[];


	/* machine dependent functions */

	/* h8adr.c */
extern	int		addr();
extern	int		addr1();
extern	int		amode();
extern	int		any();
extern	int		srch();

	/* h8mch.c */
extern	VOID		machin();
extern	VOID		normbyte();
extern	VOID		pag0byte();
extern	int		abstype();
extern	VOID		minit();
extern	int		setbit();
extern	int		getbit();
extern	int		comma();

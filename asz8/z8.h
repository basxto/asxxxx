/* z8.h */

/*
 * (C) Copyright 2005-2006
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*)BUILD
	$(PROGRAM) =	ASZ8
	$(INCLUDE) = {
		ASXXXX.H
		Z8.H
	}
	$(FILES) = {
		Z8EXT.C
		Z8MCH.C
		Z8ADR.C
		Z8PST.C
		ASMAIN.C
		ASDBG.C
		ASLEX.C
		ASSYM.C
		ASSUBR.C
		ASEXPR.C
		ASDATA.C
		ASLIST.C
		ASOUT.C
	}
	$(STACK) = 3000
*/

/*
 * Indirect Addressing delimeters
 */
#define	LFIND	'('
#define RTIND	')'

/*
 * Offset Indexing modes
 */
#define	S_INDR	0x20
#define	S_INDM	0xF0
/*
 *	S_INDR0		0x20	==>>	32
 *	S_INDR1		0x21
 *	...
 *	S_INDR14	0x2E
 *	S_INDR15	0x2F	==>>	47
 */

/*
 * Symbol types
 */
#define	S_IMMED	50
#define	S_R	51
#define	S_RR	52

#define	S_IR	53
#define	S_IRR	54
#define	S_INDX	55

/*
 * Instruction types
 */
#define	S_SOP	60
#define	S_DOP	61
#define	S_INC	62
#define	S_INCW	63
#define	S_DECW	64
#define	S_LD	65
#define	S_LDCE	66
#define	S_LDCEI	67
#define	S_DJNZ	68
#define	S_JR	69
#define	S_JP	70
#define	S_CALL	71
#define	S_SRP	72
#define	S_INH	73

struct adsym
{
	char	a_str[8];	/* addressing string */
	int	a_val;		/* addressing mode value */
};

extern	struct	adsym	R[];
extern	struct	adsym	RR[];
extern	struct	adsym	CND[];

	/* machine dependent functions */

#ifdef	OTHERSYSTEM
	
	/* z8adr.c */
extern	int		addr(struct expr *esp);
extern	int		admode(struct adsym *sp);
extern	int		srch(char *str);

	/* z8mch.c */
extern	int		comma(void);
extern	VOID		machine(struct mne *mp);
extern	int		mchpcr(struct expr *esp);
extern	VOID		minit(void);

#else

	/* z8adr.c */
extern	int		addr();
extern	int		admode();
extern	int		srch();

	/* z8mch.c */
extern	int		comma();
extern	VOID		machine();
extern	int		mchpcr();
extern	VOID		minit();

#endif


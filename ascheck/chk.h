/* chk.h */

/*
 * (C) Copyright 2001-2006
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*)BUILD
	$(PROGRAM) =	ASCHECK
	$(INCLUDE) = {
		ASXXXX.H
		CHK.H
	}
	$(FILES) = {
		CHKEXT.C
		CHKMCH.C
		CHKADR.C
		CHKPST.C
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

struct adsym
{
	char	a_str[2];	/* addressing string */
	int	a_val;		/* addressing mode value */
};

/*
 * Registers
 */

/*
 * Addressing types
 */

/*
 * Instruction types
 */
#define	S_OPCODE	40

/*
 * Set Direct Pointer
 */
#define	S_SDP		80

/*
 * Machine Type
 */
#define	S_CPU		81

/*
 * Processor Types (S_CPU)
 */
#define	X_NOCPU		0



	/* machine dependent functions */

#ifdef	OTHERSYSTEM

	/* chkadr.c */
extern	struct	adsym	reg[];
extern	int		addr(struct expr *esp);
extern	int		admode(struct adsym *sp);
extern	int		any(int c, char *str);
extern	int		srch(char *str);

	/* chkmch.c */
extern	VOID		machine(struct mne *mp);
extern	int		mchpcr(struct expr *esp);
extern	VOID		minit(void);
extern	int		comma(void);

#else

	/* chkadr.c */
extern	struct	adsym	reg[];
extern	int		addr();
extern	int		admode();
extern	int		any();
extern	int		srch();

	/* chkmch.c */
extern	VOID		machine();
extern	int		mchpcr();
extern	VOID		minit();
extern	int		comma();

#endif


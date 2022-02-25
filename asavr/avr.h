/* avr.h */

/*
 * (C) Copyright 2001-2003
 * All Rights Reserved
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*)BUILD
	$(PROGRAM) =	ASAVR
	$(INCLUDE) = {
		ASXXXX.H
		AVR.H
	}
	$(FILES) = {
		AVREXT.C
		AVRMCH.C
		AVRADR.C
		AVRPST.C
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
 * Symbol types.
 */
#define	S_INH	50		/* One word inherent */
#define	S_IBYTE	51		/* ANDI ... */
#define	S_CBR	52		/* CBR */
#define	S_IWORD	53		/* ANDIW ... */
#define	S_SNGL	54		/* ASR ... */
#define	S_SAME	55		/* LSL ... */
#define	S_DUBL	56		/* ADC ... */
#define	S_SER	57		/* SER */
#define	S_SREG	58		/* BCLR ... */
#define	S_TFLG	59		/* BLD ... */
#define	S_BRA	60		/* BRCC ... */
#define	S_SBRA	61		/* BRBC ... */
#define S_SKIP	62		/* SBRC ... */
#define S_JMP	63		/* CALL ... */
#define S_RJMP	64		/* RCALL ... */
#define S_IOR	65		/* CBI ... */
#define S_IN	66		/* IN */
#define S_OUT	67		/* OUT */
#define S_LD	68		/* LD */
#define S_ILD	69		/* LDD */
#define S_ST	70		/* ST */
#define S_IST	71		/* STD */
#define S_LDS	72		/* LDS */
#define S_STS	73		/* STS */
#define	S_MOVW	74		/* MOVW */
#define	S_MUL	75		/* MUL */
#define	S_MULS	76		/* MULS */
#define	S_FMUL	77		/* FMUL ... */
#define	S_LPM	78		/* LPM */
#define	S_ELPM	79		/* ELPM */
#define	S_4K	80		/* .4k_avr */

#define	X_PTYPE	90		/* Processor Type */

/*
 * Addressing modes
 */
#define	S_REG	30		/* Register R0-R31 */
#define S_IMMED 31		/* immediate */
#define S_DIR   32		/* direct */
#define S_EXT	33		/* extended */
#define S_IND	34		/* Indexed */


/*
 * Address Symbol Structure
 */
struct adsym
{
	char	a_str[4];	/* addressing string */
	int	a_val;		/* addressing mode value */
};

/* pre-defined symbol structure: name, value, processor type */
struct PreDef
{
   char *id;		/* ARB */
   int  value;
   int	ptype;
};
extern struct PreDef preDef[];

/*
 * Merge Modes
 */

#define	M_IBYTE		0x0100		/* S_IBYTE */
#define	M_IWORD		0x0200		/* S_IWORD */
#define	M_BRA		0x0300		/* S_BRA   */
#define	M_JMP		0x0400		/* S_LJMP  */
#define	M_IOP		0x0500		/* S_IN    */ /* S_OUT */
#define	M_IOR		0x0600		/* S_IOR   */
#define	M_ILDST		0x0700		/* S_ILD   */ /* S_IST */
#define	M_RJMP		0x0800		/* S_RJMP  */

/*
 * Assembler Types
 */
#define AT90Sxxxx	(0x00000001)
#define AT90S1200	(0x00000002)
#define AT90S2313	(0x00000004)
#define AT90S2323	(0x00000008)
#define	AT90S2343	(0x00000010)
#define AT90S2333	(0x00000020)
#define	AT90S4433	(0x00000040)
#define AT90S4414	(0x00000080)
#define AT90S4434	(0x00000100)
#define AT90S8515	(0x00000200)
#define	AT90C8534	(0x00000400)
#define	AT90S8535	(0x00000800)
#define	ATmega103	(0x00001000)
#define ATmega603	(0x00002000)
#define	ATmega161	(0x00004000)
#define	ATmega163	(0x00008000)
#define	ATtiny10	(0x00010000)
#define	ATtiny11	(0x00020000)
#define	ATtiny12	(0x00040000)
#define	ATtiny15	(0x00080000)
#define	ATtiny22	(0x00100000)
#define	ATtiny28	(0x00200000)

#define	SFR_BITS	(0x80000000)


	/* machine dependent functions */

#define	ATMEL_CPU	"ATMEL Corporation"

	/* machine dependent functions */

extern	int	aindx;

#ifdef	OTHERSYSTEM
	
	/* avradr.c */
extern	struct	adsym	regAVR[];
extern	struct	adsym	xyz[];
extern	int		addr(struct expr *esp);
extern	int		addr1(struct expr *esp);
extern	int		admode(struct adsym *sp);
extern	int		any(int c, char *str);
extern	int		srch(char *str);

	/* avrmch.c */
extern	int		comma(void);
extern	VOID		machine(struct mne *mp);
extern	int		mchpcr(struct expr *esp);
extern	VOID		minit(void);

#else

	/* avradr.c */
extern	struct	adsym	regAVR[];
extern	struct	adsym	xyz[];
extern	int		addr();
extern	int		addr1();)
extern	int		admode();
extern	int		any();
extern	int		srch();

	/* avrmch.c */
extern	int		comma();
extern	VOID		machine();
extern	int		mchpcr();
extern	VOID		minit();

#endif


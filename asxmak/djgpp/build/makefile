####################################################################
#  Makefile
#		DJGPP Version
#		=============
#
#   7 October 2003		Created for DJGPP gcc 2.8.1 / make /
#
####################################################################

.PHONY:	all clean

all:	as430.sv as740.sv as1802.sv as6500.sv	\
	as6800.sv as6801.sv as6804.sv as6805.sv	\
	as6808.sv as6809.sv as6811.sv as6812.sv	\
	as6816.sv as61860			\
	as8051.sv as8085.sv			\
	asz80.sv asgb.sv asrab.sv		\
	as8xcxxx.sv ash8.sv			\
	asavr.sv aspic.sv			\
	ascheck.sv				\
	aslink.sv				\
	asxcnv.sv asxscn.sv

clean:
	rm -f *.new *.sv
	rm -f *.o


as430:		as430.sv
as740:		as740.sv
as1802:		as1802.sv
as6500:		as6500.sv
as6800:		as6800.sv
as6801:		as6801.sv
as6804:		as6804.sv
as6805:		as6805.sv
as6808:		as6808.sv
as6809:		as6809.sv
as6811:		as6811.sv
as6812:		as6812.sv
as6816:		as6816.sv
as61860:	as61860.sv
as8051:		as8051.sv
as8085:		as8085.sv
asz80:		asz80.sv
asgb:		asgb.sv
asrab:		asrab.sv
as8xcxxx:	as8xcxxx.sv
ash8:		ash8.sv
asavr:		asavr.sv
aspic:		aspic.sv

ascheck:	ascheck.sv
aslink:		aslink.sv

asxcnv:		asxcnv.sv
asxscn:		asxscn.sv


CC=		gcc
CCOPT=		-O3
CCFLAGS=	-Wall -funsigned-char $(CCOPT)

LD=		gcc
LDFLAGS=	-Wall

#  Set ASXBAS relative to this make file.

ASXBAS=		../../../

SRCASX=		$(ASXBAS)asxxsrc/
SRCLNK=		$(ASXBAS)linksrc/
SRCMISC=	$(ASXBAS)asxxmisc/
DSTEXE=		$(ASXBAS)asxmak/djgpp/exe/

SRC430=		$(ASXBAS)as430/
SRC740=		$(ASXBAS)as740/
SRC1802=	$(ASXBAS)as1802/
SRC6500=	$(ASXBAS)as6500/
SRC6800=	$(ASXBAS)as6800/
SRC6801=	$(ASXBAS)as6801/
SRC6804=	$(ASXBAS)as6804/
SRC6805=	$(ASXBAS)as6805/
SRC6808=	$(ASXBAS)as6808/
SRC6809=	$(ASXBAS)as6809/
SRC6811=	$(ASXBAS)as6811/
SRC6812=	$(ASXBAS)as6812/
SRC6816=	$(ASXBAS)as6816/
SRC61860=	$(ASXBAS)as61860/
SRC8051=	$(ASXBAS)as8051/
SRC8085=	$(ASXBAS)as8085/
SRCZ80=		$(ASXBAS)asz80/
SRCGB=		$(ASXBAS)asgb/
SRCRAB=		$(ASXBAS)asrab/
SRC8xcxxx=	$(ASXBAS)as8xcxxx/
SRCH8=		$(ASXBAS)ash8/
SRCAVR=		$(ASXBAS)asavr/
SRCPIC=		$(ASXBAS)aspic/
SRCCHECK=	$(ASXBAS)ascheck/

VPATH =		$(SRCASX);	$(SRCLNK);	$(SRCMISC);	\
		$(SRC430);	$(SRC740);	$(SRC1802);	\
		$(SRC6500);					\
		$(SRC6800);	$(SRC6801);	$(SRC6804);	\
		$(SRC6805);	$(SRC6808);	$(SRC6809);	\
		$(SRC6811);	$(SRC6812);	$(SRC6816);	\
		$(SRC61860);	$(SRC8051);	$(SRC8085);	\
		$(SRCZ80);	$(SRCGB);	$(SRCRAB);	\
		$(SRC8xcxxx);	$(SRCH8);			\
		$(SRCAVR);	$(SRCPIC);			\
		$(SRCCHECK);

.SUFFIXES:	.c .o .new .sv

%.o: %.c
	$(CC) $(CCFLAGS) -I$(SRCMISC) -I$(SRCASX) -I$(SRCLNK) -c $< -o $(@F)

%.sv: %.new
	strip $<
	cp $< $@
	mv *.exe $(DSTEXE)


ASXX =		asmain.o asdata.o aslex.o asexpr.o	\
		assym.o assubr.o asdbg.o aslist.o	\
		asout.o

asmain.o :	$(SRCASX)asmain.c  $(SRCASX)asxxxx.h
asdata.o :	$(SRCASX)asdata.c  $(SRCASX)asxxxx.h
aslex.o :	$(SRCASX)aslex.c   $(SRCASX)asxxxx.h
asexpr.o :	$(SRCASX)asexpr.c  $(SRCASX)asxxxx.h
assym.o :	$(SRCASX)assym.c   $(SRCASX)asxxxx.h
assubr.o :	$(SRCASX)assubr.c  $(SRCASX)asxxxx.h
asdbg.o :	$(SRCASX)asdbg.c   $(SRCASX)asxxxx.h
aslist.o :	$(SRCASX)aslist.c  $(SRCASX)asxxxx.h
asout.o :	$(SRCASX)asout.c   $(SRCASX)asxxxx.h


####################################################################
# AS430
####################################################################

AS430 =		m430ext.o m430pst.o m430mch.o m430adr.o

m430ext.o :	$(SRC430)m430ext.c $(SRC430)m430.h $(SRCASX)asxxxx.h
m430pst.o :	$(SRC430)m430pst.c $(SRC430)m430.h $(SRCASX)asxxxx.h
m430mch.o :	$(SRC430)m430mch.c $(SRC430)m430.h $(SRCASX)asxxxx.h
m430adr.o :	$(SRC430)m430adr.c $(SRC430)m430.h $(SRCASX)asxxxx.h

as430.new:	$(ASXX) $(AS430)
	$(LD) $(LDFLAGS) $(ASXX) $(AS430) -o as430.new


####################################################################
# AS740
####################################################################

AS740 =		m74ext.o m74pst.o m74mch.o m74adr.o

m74ext.o :	$(SRC740)m74ext.c $(SRC740)m740.h $(SRCASX)asxxxx.h
m74pst.o :	$(SRC740)m74pst.c $(SRC740)m740.h $(SRCASX)asxxxx.h
m74mch.o :	$(SRC740)m74mch.c $(SRC740)m740.h $(SRCASX)asxxxx.h
m74adr.o :	$(SRC740)m74adr.c $(SRC740)m740.h $(SRCASX)asxxxx.h

as740.new:	$(ASXX) $(AS740)
	$(LD) $(LDFLAGS) $(ASXX) $(AS740) -o as740.new


####################################################################
# AS1802
####################################################################

AS1802 =	1802ext.o 1802pst.o 1802mch.o

1802ext.o :	$(SRC1802)1802ext.c $(SRC1802)1802.h $(SRCASX)asxxxx.h
1802pst.o :	$(SRC1802)1802pst.c $(SRC1802)1802.h $(SRCASX)asxxxx.h
1802mch.o :	$(SRC1802)1802mch.c $(SRC1802)1802.h $(SRCASX)asxxxx.h

as1802.new:	$(ASXX) $(AS1802)
	$(LD) $(LDFLAGS) $(ASXX) $(AS1802) -o as1802.new


####################################################################
# AS6500
####################################################################

AS6500 =	r65ext.o r65pst.o r65mch.o r65adr.o

r65ext.o :	$(SRC6500)r65ext.c $(SRC6500)r6500.h $(SRCASX)asxxxx.h
r65pst.o :	$(SRC6500)r65pst.c $(SRC6500)r6500.h $(SRCASX)asxxxx.h
r65mch.o :	$(SRC6500)r65mch.c $(SRC6500)r6500.h $(SRCASX)asxxxx.h
r65adr.o :	$(SRC6500)r65adr.c $(SRC6500)r6500.h $(SRCASX)asxxxx.h

as6500.new:	$(ASXX) $(AS6500)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6500) -o as6500.new


####################################################################
# AS6800
####################################################################

AS6800 =	m00ext.o m00pst.o m00mch.o m00adr.o 

m00ext.o :	$(SRC6800)m00ext.c $(SRC6800)m6800.h $(SRCASX)asxxxx.h
m00pst.o :	$(SRC6800)m00pst.c $(SRC6800)m6800.h $(SRCASX)asxxxx.h
m00mch.o :	$(SRC6800)m00mch.c $(SRC6800)m6800.h $(SRCASX)asxxxx.h
m00adr.o :	$(SRC6800)m00adr.c $(SRC6800)m6800.h $(SRCASX)asxxxx.h

as6800.new:	$(ASXX) $(AS6800)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6800) -o as6800.new


####################################################################
# AS6801
####################################################################

AS6801 =	m01ext.o m01pst.o m01mch.o m01adr.o

m01ext.o :	$(SRC6801)m01ext.c $(SRC6801)m6801.h $(SRCASX)asxxxx.h
m01pst.o :	$(SRC6801)m01pst.c $(SRC6801)m6801.h $(SRCASX)asxxxx.h
m01mch.o :	$(SRC6801)m01mch.c $(SRC6801)m6801.h $(SRCASX)asxxxx.h
m01adr.o :	$(SRC6801)m01adr.c $(SRC6801)m6801.h $(SRCASX)asxxxx.h

as6801.new:	$(ASXX) $(AS6801)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6801) -o as6801.new


####################################################################
# AS6804
####################################################################

AS6804 =	m04ext.o m04pst.o m04mch.o m04adr.o

m04ext.o :	$(SRC6804)m04ext.c $(SRC6804)m6804.h $(SRCASX)asxxxx.h
m04pst.o :	$(SRC6804)m04pst.c $(SRC6804)m6804.h $(SRCASX)asxxxx.h
m04mch.o :	$(SRC6804)m04mch.c $(SRC6804)m6804.h $(SRCASX)asxxxx.h
m04adr.o :	$(SRC6804)m04adr.c $(SRC6804)m6804.h $(SRCASX)asxxxx.h

as6804.new:	$(ASXX) $(AS6804)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6804) -o as6804.new


####################################################################
# AS6805
####################################################################

AS6805 =	m05ext.o m05pst.o m05mch.o m05adr.o

m05ext.o :	$(SRC6805)m05ext.c $(SRC6805)m6805.h $(SRCASX)asxxxx.h
m05pst.o :	$(SRC6805)m05pst.c $(SRC6805)m6805.h $(SRCASX)asxxxx.h
m05mch.o :	$(SRC6805)m05mch.c $(SRC6805)m6805.h $(SRCASX)asxxxx.h
m05adr.o :	$(SRC6805)m05adr.c $(SRC6805)m6805.h $(SRCASX)asxxxx.h

as6805.new:	$(ASXX) $(AS6805)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6805) -o as6805.new


####################################################################
# AS6808
####################################################################

AS6808 =	m08ext.o m08pst.o m08mch.o m08adr.o

m08ext.o :	$(SRC6808)m08ext.c $(SRC6808)m6808.h $(SRCASX)asxxxx.h
m08pst.o :	$(SRC6808)m08pst.c $(SRC6808)m6808.h $(SRCASX)asxxxx.h
m08mch.o :	$(SRC6808)m08mch.c $(SRC6808)m6808.h $(SRCASX)asxxxx.h
m08adr.o :	$(SRC6808)m08adr.c $(SRC6808)m6808.h $(SRCASX)asxxxx.h

as6808.new:	$(ASXX) $(AS6808)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6808) -o as6808.new


####################################################################
# AS6809
####################################################################

AS6809 =	m09ext.o m09pst.o m09mch.o m09adr.o

m09ext.o :	$(SRC6809)m09ext.c $(SRC6809)m6809.h $(SRCASX)asxxxx.h
m09pst.o :	$(SRC6809)m09pst.c $(SRC6809)m6809.h $(SRCASX)asxxxx.h
m09mch.o :	$(SRC6809)m09mch.c $(SRC6809)m6809.h $(SRCASX)asxxxx.h
m09adr.o :	$(SRC6809)m09adr.c $(SRC6809)m6809.h $(SRCASX)asxxxx.h

as6809.new:	$(ASXX) $(AS6809)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6809) -o as6809.new


####################################################################
# AS6811
####################################################################

AS6811 =	m11ext.o m11pst.o m11mch.o m11adr.o

m11ext.o :	$(SRC6811)m11ext.c $(SRC6811)m6811.h $(SRCASX)asxxxx.h
m11pst.o :	$(SRC6811)m11pst.c $(SRC6811)m6811.h $(SRCASX)asxxxx.h
m11mch.o :	$(SRC6811)m11mch.c $(SRC6811)m6811.h $(SRCASX)asxxxx.h
m11adr.o :	$(SRC6811)m11adr.c $(SRC6811)m6811.h $(SRCASX)asxxxx.h

as6811.new:	$(ASXX) $(AS6811)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6811) -o as6811.new


####################################################################
# AS6812
####################################################################

AS6812 =	m12ext.o m12pst.o m12mch.o m12adr.o

m12ext.o :	$(SRC6812)m12ext.c $(SRC6812)m6812.h $(SRCASX)asxxxx.h
m12pst.o :	$(SRC6812)m12pst.c $(SRC6812)m6812.h $(SRCASX)asxxxx.h
m12mch.o :	$(SRC6812)m12mch.c $(SRC6812)m6812.h $(SRCASX)asxxxx.h
m12adr.o :	$(SRC6812)m12adr.c $(SRC6812)m6812.h $(SRCASX)asxxxx.h

as6812.new:	$(ASXX) $(AS6812)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6812) -o as6812.new


####################################################################
# AS6816
####################################################################

AS6816 =	m16ext.o m16pst.o m16mch.o m16adr.o

m16ext.o :	$(SRC6816)m16ext.c $(SRC6816)m6816.h $(SRCASX)asxxxx.h
m16pst.o :	$(SRC6816)m16pst.c $(SRC6816)m6816.h $(SRCASX)asxxxx.h
m16mch.o :	$(SRC6816)m16mch.c $(SRC6816)m6816.h $(SRCASX)asxxxx.h
m16adr.o :	$(SRC6816)m16adr.c $(SRC6816)m6816.h $(SRCASX)asxxxx.h

as6816.new:	$(ASXX) $(AS6816)
	$(LD) $(LDFLAGS) $(ASXX) $(AS6816) -o as6816.new


####################################################################
# AS61860
####################################################################

AS61860 =	s6186ext.o s6186pst.o s6186mch.o s6186adr.o

s6186ext.o :	$(SRC61860)s6186ext.c $(SRC61860)s61860.h $(SRCASX)asxxxx.h
s6186pst.o :	$(SRC61860)s6186pst.c $(SRC61860)s61860.h $(SRCASX)asxxxx.h
s6186mch.o :	$(SRC61860)s6186mch.c $(SRC61860)s61860.h $(SRCASX)asxxxx.h
s6186adr.o :	$(SRC61860)s6186adr.c $(SRC61860)s61860.h $(SRCASX)asxxxx.h

as61860.new:	$(ASXX) $(AS61860)
	$(LD) $(LDFLAGS) $(ASXX) $(AS61860) -o as61860.new


####################################################################
# AS8051
####################################################################

AS8051 =	i51ext.o i51pst.o i51mch.o i51adr.o

i51ext.o :	$(SRC8051)i51ext.c $(SRC8051)i8051.h $(SRCASX)asxxxx.h
i51pst.o :	$(SRC8051)i51pst.c $(SRC8051)i8051.h $(SRCASX)asxxxx.h
i51mch.o :	$(SRC8051)i51mch.c $(SRC8051)i8051.h $(SRCASX)asxxxx.h
i51adr.o :	$(SRC8051)i51adr.c $(SRC8051)i8051.h $(SRCASX)asxxxx.h

as8051.new:	$(ASXX) $(AS8051)
	$(LD) $(LDFLAGS) $(ASXX) $(AS8051) -o as8051.new


####################################################################
# AS8085
####################################################################

AS8085 =	i85ext.o i85pst.o i85mch.o

i85ext.o :	$(SRC8085)i85ext.c $(SRC8085)i8085.h $(SRCASX)asxxxx.h
i85pst.o :	$(SRC8085)i85pst.c $(SRC8085)i8085.h $(SRCASX)asxxxx.h
i85mch.o :	$(SRC8085)i85mch.c $(SRC8085)i8085.h $(SRCASX)asxxxx.h

as8085.new:	$(ASXX) $(AS8085)
	$(LD) $(LDFLAGS) $(ASXX) $(AS8085) -o as8085.new


####################################################################
# ASZ80
####################################################################

ASZ80 =		z80ext.o z80pst.o z80mch.o z80adr.o

z80ext.o :	$(SRCZ80)z80ext.c $(SRCZ80)z80.h $(SRCASX)asxxxx.h
z80pst.o :	$(SRCZ80)z80pst.c $(SRCZ80)z80.h $(SRCASX)asxxxx.h
z80mch.o :	$(SRCZ80)z80mch.c $(SRCZ80)z80.h $(SRCASX)asxxxx.h
z80adr.o :	$(SRCZ80)z80adr.c $(SRCZ80)z80.h $(SRCASX)asxxxx.h

asz80.new:	$(ASXX) $(ASZ80)
	$(LD) $(LDFLAGS) $(ASXX) $(ASZ80) -o asz80.new


####################################################################
# ASGB
####################################################################

ASGB =		gbext.o gbpst.o gbmch.o gbadr.o

gbext.o :	$(SRCGB)gbext.c $(SRCGB)gb.h $(SRCASX)asxxxx.h
gbpst.o :	$(SRCGB)gbpst.c $(SRCGB)gb.h $(SRCASX)asxxxx.h
gbmch.o :	$(SRCGB)gbmch.c $(SRCGB)gb.h $(SRCASX)asxxxx.h
gbadr.o :	$(SRCGB)gbadr.c $(SRCGB)gb.h $(SRCASX)asxxxx.h

asgb.new:	$(ASXX) $(ASGB)
	$(LD) $(LDFLAGS) $(ASXX) $(ASGB) -o asgb.new


####################################################################
# ASRAB
####################################################################

ASRAB =		rabext.o rabpst.o rabmch.o rabadr.o

rabext.o :	$(SRCRAB)rabext.c $(SRCRAB)rab.h $(SRCASX)asxxxx.h
rabpst.o :	$(SRCRAB)rabpst.c $(SRCRAB)rab.h $(SRCASX)asxxxx.h
rabmch.o :	$(SRCRAB)rabmch.c $(SRCRAB)rab.h $(SRCASX)asxxxx.h
rabadr.o :	$(SRCRAB)rabadr.c $(SRCRAB)rab.h $(SRCASX)asxxxx.h

asrab.new:	$(ASXX) $(ASRAB)
	$(LD) $(LDFLAGS) $(ASXX) $(ASRAB) -o asrab.new


####################################################################
# AS8xcxxx
####################################################################

AS8xcxxx =	ds8ext.o ds8pst.o ds8mch.o ds8adr.o

ds8ext.o :	$(SRC8xcxxx)ds8ext.c $(SRC8xcxxx)ds8.h $(SRCASX)asxxxx.h
ds8pst.o :	$(SRC8xcxxx)ds8pst.c $(SRC8xcxxx)ds8.h $(SRCASX)asxxxx.h
ds8mch.o :	$(SRC8xcxxx)ds8mch.c $(SRC8xcxxx)ds8.h $(SRCASX)asxxxx.h
ds8adr.o :	$(SRC8xcxxx)ds8adr.c $(SRC8xcxxx)ds8.h $(SRCASX)asxxxx.h

as8xcxxx.new:	$(ASXX) $(AS8xcxxx)
	$(LD) $(LDFLAGS) $(ASXX) $(AS8xcxxx) -o as8xcxxx.new


####################################################################
# ASH8
####################################################################

ASH8 =		h8ext.o h8pst.o h8mch.o h8adr.o

h8ext.o :	$(SRCH8)h8ext.c $(SRCH8)h8.h $(SRCASX)asxxxx.h
h8pst.o :	$(SRCH8)h8pst.c $(SRCH8)h8.h $(SRCASX)asxxxx.h
h8mch.o :	$(SRCH8)h8mch.c $(SRCH8)h8.h $(SRCASX)asxxxx.h
h8adr.o :	$(SRCH8)h8adr.c $(SRCH8)h8.h $(SRCASX)asxxxx.h

ash8.new:	$(ASXX) $(ASH8)
	$(LD) $(LDFLAGS) $(ASXX) $(ASH8) -o ash8.new


####################################################################
# ASAVR
####################################################################

ASAVR =		avrext.o avrpst.o avrmch.o avradr.o

avrext.o :	$(SRCAVR)avrext.c $(SRCAVR)avr.h $(SRCASX)asxxxx.h
avrpst.o :	$(SRCAVR)avrpst.c $(SRCAVR)avr.h $(SRCASX)asxxxx.h
avrmch.o :	$(SRCAVR)avrmch.c $(SRCAVR)avr.h $(SRCASX)asxxxx.h
avradr.o :	$(SRCAVR)avradr.c $(SRCAVR)avr.h $(SRCASX)asxxxx.h

asavr.new:	$(ASXX) $(ASAVR)
	$(LD) $(LDFLAGS) $(ASXX) $(ASAVR) -o asavr.new


####################################################################
# ASPIC
####################################################################

ASPIC =	picext.o picpst.o picmch.o picadr.o

picext.o :	$(SRCPIC)picext.c $(SRCPIC)pic.h $(SRCASX)asxxxx.h
picpst.o :	$(SRCPIC)picpst.c $(SRCPIC)pic.h $(SRCASX)asxxxx.h
picmch.o :	$(SRCPIC)picmch.c $(SRCPIC)pic.h $(SRCASX)asxxxx.h
picadr.o :	$(SRCPIC)picadr.c $(SRCPIC)pic.h $(SRCASX)asxxxx.h

aspic.new:	$(ASXX) $(ASPIC)
	$(LD) $(LDFLAGS) $(ASXX) $(ASPIC) -o aspic.new


####################################################################
# ASCHECK
####################################################################

ASCHECK =		chkext.o chkpst.o chkmch.o chkadr.o

chkext.o :	$(SRCCHECK)chkext.c $(SRCCHECK)chk.h $(SRCASX)asxxxx.h
chkpst.o :	$(SRCCHECK)chkpst.c $(SRCCHECK)chk.h $(SRCASX)asxxxx.h
chkmch.o :	$(SRCCHECK)chkmch.c $(SRCCHECK)chk.h $(SRCASX)asxxxx.h
chkadr.o :	$(SRCCHECK)chkadr.c $(SRCCHECK)chk.h $(SRCASX)asxxxx.h

ascheck.new:	$(ASXX) $(ASCHECK)
	$(LD) $(LDFLAGS) $(ASXX) $(ASCHECK) -o ascheck.new


####################################################################
# ASLINK
####################################################################

ASLINK =	lkmain.o lkhead.o lkarea.o lklex.o	\
		lksym.o lkeval.o lkdata.o lklibr.o	\
		lklist.o lknoice.o lksdcdb.o lkrloc.o	\
		lkrloc3.o lkrloc4.o lkout.o lkbank.o

lkmain.o :	$(SRCLNK)lkmain.c  $(SRCLNK)aslink.h
lkhead.o :	$(SRCLNK)lkhead.c  $(SRCLNK)aslink.h
lkarea.o :	$(SRCLNK)lkarea.c  $(SRCLNK)aslink.h
lkbank.o :	$(SRCLNK)lkbank.c  $(SRCLNK)aslink.h
lklex.o :	$(SRCLNK)lklex.c   $(SRCLNK)aslink.h
lksym.o :	$(SRCLNK)lksym.c   $(SRCLNK)aslink.h
lkeval.o :	$(SRCLNK)lkeval.c  $(SRCLNK)aslink.h
lkdata.o :	$(SRCLNK)lkdata.c  $(SRCLNK)aslink.h
lklibr.o :	$(SRCLNK)lklibr.c  $(SRCLNK)aslink.h
lklist.o :	$(SRCLNK)lklist.c  $(SRCLNK)aslink.h
lknoice.o :	$(SRCLNK)lknoice.c $(SRCLNK)aslink.h
lksdcdb.o :	$(SRCLNK)lksdcdb.c $(SRCLNK)aslink.h
lkrloc.o :	$(SRCLNK)lkrloc.c  $(SRCLNK)aslink.h
lkrloc3.o :	$(SRCLNK)lkrloc3.c $(SRCLNK)aslink.h
lkrloc4.o :	$(SRCLNK)lkrloc4.c $(SRCLNK)aslink.h
lkout.o :	$(SRCLNK)lkout.c   $(SRCLNK)aslink.h

aslink.new:	$(ASLINK)
	$(LD) $(LDFLAGS) $(ASLINK) -o aslink.new


####################################################################
# ASXCNV
####################################################################

ASXCNV =	asxxconv.o

asxxconv.o :	$(SRCMISC)asxxconv.c $(SRCASX)asxxxx.h

asxcnv.new:	$(ASXCNV)
	$(LD) $(LDFLAGS) $(ASXCNV) -o asxcnv.new


####################################################################
# ASXSCN
####################################################################

ASXSCN =	asxxscan.o

asxxscan.o :	$(SRCMISC)asxxscan.c $(SRCASX)asxxxx.h

asxscn.new:	$(ASXSCN)
	$(LD) $(LDFLAGS) $(ASXSCN) -o asxscn.new


### end #########################################################

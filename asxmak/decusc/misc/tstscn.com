set log file=tstscn.log
!
ru as6500
-glaxff asmtl.asm
ru asxscn
asmtl.lst
!
ru as6800
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6801
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6804
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6805
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6808
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6809
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6811
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6812
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6816
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as8085
-glaxff asmtl.asm
ru asxscn
asmtl.lst
!
ru as8051
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru asz80
-glaxff asmtl.asm
ru asxscn
asmtl.lst
!
ru ash8
-glaxff asmth.asm
ru asxscn
asmth.lst
!
ru as6500
-glaxff t6500.asm
ru asxscn
t6500.lst
!
ru as6500
-glaxff t6500s.asm
ru asxscn
t6500s.lst
!
ru as6800
-glaxff t6800.asm
ru asxscn
t6800.lst
ru as6800
-glaxff t6800s.asm
ru asxscn
t6800s.lst
!
ru as6801
-glaxff t6801.asm
ru asxscn
t6801.lst
ru as6801
-glaxff t6801s.asm
ru asxscn
t6801s.lst
!
ru as6804
-glaxff t6804s.asm
ru asxscn
t6804s.lst
!
ru as6805
-glaxff t6805s.asm
ru asxscn
t6805s.lst
!
ru as6808
-glaxff t6808s.asm
ru asxscn
t6808s.lst
!
ru as6809
-glaxff t6809.asm
ru asxscn
t6809.lst
!
ru as6811
-glaxff t6811.asm
ru asxscn
t6811.lst
ru as6811
-glaxff t6811s.asm
ru asxscn
t6811s.lst
!
ru as6812
-glaxff t6812.asm
ru asxscn
t6812.lst
ru as6812
-glaxff t6812a.asm
ru asxscn
t6812a.lst
ru as6812
-glaxff t6812b.asm
ru asxscn
t6812b.lst
!
ru as6816
-glaxff t6816.asm
ru asxscn
t6816.lst
!
ru as8085
-glaxff t8085.asm
ru asxscn
t8085.lst
!
ru as8051
-glaxff t8051.asm
ru asxscn
t8051.lst
!
ru asz80
-glaxff tz80.asm
ru asxscn
tz80.lst
!
ru ash8
-glaxff th8.asm
ru asxscn
th8.lst
!
set log closed

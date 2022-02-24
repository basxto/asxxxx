! Disk 4 Copy
!
create vm:disk4.dsk/allocate:988
mount ld3: vm:disk4.dsk
init ld3:/seg:6
assign dk: inp:
assign ld3: oup:
!
! ASxxxx and ASlink Executables
!
copy inp:as6500.sav oup:
copy inp:as6800.sav oup:
copy inp:as6801.sav oup:
copy inp:as6804.sav oup:
copy inp:as6805.sav oup:
copy inp:as6808.sav oup:
copy inp:as6809.sav oup:
copy inp:as6811.sav oup:
copy inp:as6812.sav oup:
copy inp:as6816.sav oup:
copy inp:as8051.sav oup:
copy inp:as8085.sav oup:
copy inp:ash8.sav oup:
copy inp:asz80.sav oup:
copy inp:aslink.sav oup:
!
dir/out:disk4.dir oup:

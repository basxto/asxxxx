! Disk 2 Copy
!
create vm:disk2.dsk/allocate:988
mount ld3: vm:disk2.dsk
init ld3:/seg:6
assign dk: inp:
assign ld3: oup:
!
! M6812
!
copy inp:m6812.h oup:
copy inp:m12*.c oup:
copy inp:as6812.(bld,cmp,lnk) oup:
copy inp:t6812*.* oup:
!
! I8051
!
copy inp:i8051.h oup:
copy inp:i51*.c oup:
copy inp:as8051.(bld,cmp,lnk) oup:
copy inp:t8051*.* oup:
!
! Z80
!
copy inp:z80.h oup:
copy inp:z80*.c oup:
copy inp:asz80.(bld,cmp,lnk) oup:
copy tz80*.* oup:
!
! H8/3xx
!
copy inp:h8.h oup:
copy inp:h8*.c oup:
copy ash8.(bld,cmp,lnk) oup:
copy th8*.* oup:
!
dir/out:disk2.dir oup:

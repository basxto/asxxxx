! Disk 3 Copy
!
create vm:disk3.dsk/allocate:988
mount ld3: vm:disk3.dsk
init ld3:/seg:6
assign dk: inp:
assign ld3: oup:
!
! ASxxxx
!
copy inp:asxxxx.h oup:
copy inp:alloc.h oup:
copy inp:string.h oup:
copy inp:as*.c oup:
copy inp:xxxpst.c oup:
copy inp:asmth.asm oup:
copy inp:asmtl.asm oup:
copy inp:tconst.asm oup:
copy inp:itst*.asm oup:
copy inp:incld*.asm oup:
copy inp:asxxxx.(bld,cmp,lnk) oup:
!
! ASlink
!
copy inp:aslink.h oup:
copy inp:lk*.c oup:
copy inp:aslink.(bld,cmp,lnk) oup:
!
! ASXscn
!
copy inp:asxscn.c oup:
copy inp:asxscn.(bld,com) oup:
!
! ASXcnv
!
copy inp:asxcnv.c oup:
copy inp:asxcnv.(bld,com) oup:
!
copy inp:bldall.com oup:
!
dir/out:disk3.dir oup:

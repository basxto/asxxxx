! Disk 1 Copy
!
create vm:disk1.dsk/allocate:988
mount ld3: vm:disk1.dsk
init ld3:/seg:6
assign dk: inp:
assign ld3: oup:
!
! I8085
!
copy inp:i8085.h oup:
copy inp:i85*.c oup:
copy inp:as8085.(bld,cmp,lnk) oup:
copy inp:t8085*.* oup:
!
! R6500
!
copy inp:r6500.h oup:
copy inp:r65*.c oup:
copy inp:as6500.(bld,cmp,lnk) oup:
copy inp:t6500*.* oup:
!
! M6800
!
copy inp:m6800.h oup:
copy inp:m00*.c oup:
copy inp:as6800.(bld,cmp,lnk) oup:
copy inp:t6800*.* oup:
!
! M6801
!
copy inp:m6801.h oup:
copy inp:m01*.c oup:
copy inp:as6801.(bld,cmp,lnk) oup:
copy inp:t6801*.* oup:
!
! M6804
!
copy inp:m6804.h oup:
copy inp:m04*.c oup:
copy inp:as6804.(bld,cmp,lnk) oup:
copy inp:t6804*.* oup:
!
! M6805
!
copy inp:m6805.h oup:
copy inp:m05*.c oup:
copy inp:as6805.(bld,cmp,lnk) oup:
copy inp:t6805*.* oup:
!
! M6808
!
copy inp:m6808.h oup:
copy inp:m08*.c oup:
copy inp:as6808.(bld,cmp,lnk) oup:
copy inp:t6808*.* oup:
!
! M6809
!
copy inp:m6809.h oup:
copy inp:m09*.c oup:
copy inp:as6809.(bld,cmp,lnk) oup:
copy inp:t6809*.* oup:
!
! M6811
!
copy inp:m6811.h oup:
copy inp:m11*.c oup:
copy inp:as6811.(bld,cmp,lnk) oup:
copy inp:t6811*.* oup:
!
! M6816
!
copy inp:m6816.h oup:
copy inp:m16*.c oup:
copy inp:as6816.(bld,cmp,lnk) oup:
copy inp:t6816*.* oup:
copy inp:pc6816.* oup:
!
dir/out:disk1.dir oup:

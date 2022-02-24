! Disk 6 Copy
!
create vm:disk6.dsk/allocate:988
mount ld3: vm:disk6.dsk
init ld3:/seg:6
assign dk: inp:
assign ld3: oup:
!
! ASMLNK Documentation
!
copy inp:readme.txt oup:
!
copy inp:asmlnk.doc oup:
copy inp:abstra.doc oup:
!
! Utility Files
!
copy inp:asxscn.sav oup:
copy inp:asxcnv.sav oup:
!
copy inp:asxxxx.siz oup:
copy inp:tstscn.com oup:
!
! Disk Copy Files
!
copy inp:disk1.cpy oup:
copy inp:disk2.cpy oup:
copy inp:disk3.cpy oup:
copy inp:disk4.cpy oup:
copy inp:disk5.cpy oup:
copy inp:disk6.cpy oup:
copy inp:asvxpx.cpy oup:
!
! Disk Directories
!
set error none
copy inp:disk1.dir oup:
copy inp:disk2.dir oup:
copy inp:disk3.dir oup:
copy inp:disk4.dir oup:
copy inp:disk5.dir oup:
copy inp:disk6.dir oup:
!
dir/out:disk6.dir oup:
del/noq oup:disk*.dir
!
copy inp:disk1.dir oup:
copy inp:disk2.dir oup:
copy inp:disk3.dir oup:
copy inp:disk4.dir oup:
copy inp:disk5.dir oup:
copy inp:disk6.dir oup:
!
dir/out:disk6.dir oup:
del/noq oup:disk*.dir
!
copy inp:disk1.dir oup:
copy inp:disk2.dir oup:
copy inp:disk3.dir oup:
copy inp:disk4.dir oup:
copy inp:disk5.dir oup:
copy inp:disk6.dir oup:
!
dir/out:disk6.dir oup:

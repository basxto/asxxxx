! Disk 5 Copy
!
create vm:disk5.dsk/allocate:988
mount ld3: vm:disk5.dsk
init ld3:/seg:6
assign dy1: inp:
assign ld3: oup:
!
! Sample .asm Files
!
copy inp:*.asm	oup:
!
dir/out:disk5.dir oup:

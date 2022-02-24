! ASVxPx Copy
!
create ^1:^2.dsk/allocate:5000
mount ld3: ^1:^2.dsk
init ld3:
assign ld3: oup:
!
! DISK1 ...
!
mount ld2: ^1:disk1.dsk
assign ld2: inp:
copy ld2: ld3:
!
! DISK2 ...
!
mount ld2: ^1:disk2.dsk
assign ld2: inp:
copy ld2: ld3:
!
! DISK3 ...
!
mount ld2: ^1:disk3.dsk
assign ld2: inp:
copy ld2: ld3:
!
! DISK4 ...
!
mount ld2: ^1:disk4.dsk
assign ld2: inp:
copy ld2: ld3:
!
! DISK5 ...
!
mount ld2: ^1:disk5.dsk
assign ld2: inp:
copy ld2: ld3:
!
! DISK6 ...
!
mount ld2: ^1:disk6.dsk
assign ld2: inp:
copy ld2: ld3:
!
dir/out:^2.dir oup:

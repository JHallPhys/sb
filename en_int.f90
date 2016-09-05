program energy_interval

implicit none 

! program takes an upper bound and discretises the interval
! the output is a file containing the interval

real :: en,delta_en,max_en,nstep

integer :: i 

open(file='interval.out',unit=20,status='replace')
open(file='tve.dat',unit=21,status='replace')
open(file='p_in.dat',unit=29,status='replace')
open(file='pd.dat',unit=35,status='replace')
! split interval into 100 points say

max_en = 2.15
en = 0.0
nstep = 100.0
delta_en = real(max_en-en)/nstep

! write interval to file 

do i = 1,int(nstep)+1
   
  write(20,'(f19.16)') en

  en = en + delta_en

end do 

close(20)
close(21)
close(29)
end program 


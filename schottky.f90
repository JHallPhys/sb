program SB

use constants
use rk 

implicit none 

real(kind=dp) :: Ref_coeff,Trans_coeff,K,En,x,x_i,x_f,h,re,im 

complex(kind=dp) :: psi_1,psi_2,A_t,A_r
complex(kind=dp),dimension(2) :: wfn 

integer :: i,n,ierr

!Print*, '~~~~~~~~~~~~~ Starting Program ~~~~~~~~~~~~~~~'

!--------------------------------------------
!    integration scheme parameters
!--------------------------------------------

! read steps and inital and final points from file 

open(file='input.dat',unit=20,status='old',action='read',iostat=ierr) 

if (ierr.ne.0) stop 'error opening scheme input file in main'

read(20,*) x_i,x_f
read(20,*) n



! integraion step size: h 

h = (x_f - x_i)/real(n)

!--------------------------------------------
!      Calculate inital conditions
!--------------------------------------------

! calculatted from b.c after transmission from barrier

read(20,*) En

k = sqrt(2.0_dp*En)

!print*, k

wfn(1) = exp(cmplx(0.0_dp,k,kind=dp)*x_f)
wfn(2) = cmplx(0.0_dp,k,kind=dp)*wfn(1) 

close (20)

!--------------------------------------------
!            Start main loop 
!--------------------------------------------

! output file to contain wfn components 

open(file='output.dat',unit=21,status='replace')

! integrate from right to left using RK scheme

call read_en
call read_well

x = x_f

do i = 1,n

  write(21,*) x,real(wfn(1)),aimag(wfn(1)),real(wfn(2)),aimag(wfn(2))
  
  call RK4(x,h,wfn)
  
  x = x - h
  
end do 

close(21)

!--------------------------------------------
!  Transmission and Reflection coefficents
!--------------------------------------------

! get value of psi(0)

open(file='output.dat',unit=21,status='old',action='read')

read(21,*) x,re,im

loop1 : do 

  if (abs(x).ge.(2*h)) then
    read(21,*) x,re,im
  else 
    exit loop1 
  end if 

end do loop1

psi_1 = cmplx(re,im,kind=dp) 

close (21)


! same for psi_2

open(file='output.dat',unit=21,status='old',action='read')

read(21,*) x,re,im

loop2 : do 

  if (abs(x).ge.((0.5_dp*pi)/k)) then
    read(21,*) x,re,im
  else 
    exit loop2 
  end if 

end do loop2

psi_2 = cmplx(re,im,kind=dp)

close(21)

! Calculate reflection coefficent 

A_t = (psi_1 - cmplx(0.0_dp,1.0_dp,kind=dp)*psi_2)*0.5_dp
A_r = (psi_1 + cmplx(0.0_dp,1.0_dp,kind=dp)*psi_2)*0.5_dp

ref_coeff = abs(A_r)**2/abs(A_t)**2
Trans_coeff = 1.0_dp - ref_coeff

!Print*, '~~~~~~~~~~~~~ All Done :)  ~~~~~~~~~~~~~~~'
!Print*, ' Wavefunction output in output.dat file. '
!print*, 'Energy :',En
!print*, 'Transmission :',Trans_coeff

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!! Uncomment w. RT_Coeff script !!!!!!!!!!!!!!!!!!!
!------------------------------------------------------
print*, pd_applied,Trans_coeff
!-----------------------------------------------------

! Energy vs Transmission 

!print*, en,trans_coeff

end program 

   

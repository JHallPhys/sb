! program to determine the parameters of the potential well
! values entered in SI form then converted to Atomic units

program sb_param 

use constants 

implicit none 

real(kind=dp) :: width,Nd,eps,eps_h,v_b0,v_bn,phi_b0,v,v_t,t_unit
integer :: ierr,g,i
open(file='param_in.dat',unit=20,status='replace',iostat=ierr)
if (ierr.ne.0) stop 'error opening file input.dat in param.init'

!-----------------------------------------
!         initally use Au-Si
!-----------------------------------------

! Values entered in SI units shown 

! permitivity

! the static permitivity is repersented by eps here

eps = 12.5
eps_h = 11.0

! doping concentration (cm^-3)

!Nd = Nd/5.5563E18 ! doping
Nd = 4.5563E18

! Barrier height (eV)
 
phi_b0 = 6*27.21

! built in potential at  zero bias (eV)

v_b0 = 6*27.21

! differecnce between fermi-level and conduction band edge (Ev)

v_bn = phi_b0 - v_b0


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!            Applied PD 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
open(file='interval2.out',unit=39,status='old',action='read')
open(file='dis.dat',unit=38,status='old',action='read')

read(38,*) g

do i = 1,g
  read(39,*) v
end do 

close (39)
close(38)


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!v = 0.1
!-------------------------------------------------
! conversion to Atomic units (hbar=m=q=k_c=K_b=1)
!_-----------------------------------------------

Nd = Nd/5.5563E18
!Nd = 1.0_dp

phi_b0 = phi_b0/27.21 !barrier height

v_b0 = v_b0/27.21 ! built in voltage
!print*, v_b0
v_bn = v_bn/27.21 ! difference between con band and fermi  

!v = v/27.21 ! applied voltage 

v_t = 3.18E-6  ! thermal voltage 
v_t = v_t*0



width  = sqrt(2.0*eps*(v_b0-v)/Nd)

!print*, width 
!print*,'V_bn: ', phi_b0 - (Nd*(width**2))/(4.0_dp*eps)

!print*, 'E_00 :', (0.5_dp*sqrt(Nd/eps))/27.21

! write parameters to file 

write(20,'(1x,f5.2,1x,a2,1x,a6)'), eps,'::','static' 
write(20,'(1x,f5.2,1x,a2,1x,a4)') eps_h,'::','high'  
write(20,'(es23.16,1x,a2,1x,a16)') width,'::',' depletion_width'
write(20,'(es23.16,1x,a2,1x,a14)') Nd,'::','Doping density:'
write(20,'(es23.16,1x,a2,1x,a14)') phi_b0,'::','Barrier height:'
write(20,*) v

close(20)

! Create input file 

open(file='input.dat',unit=21,status='replace',iostat=ierr)

if (ierr.ne.0) stop 'Problem creating input file in param.int'

write(21,*) 0,40+width
write(21,*) int(1000_dp*(40+width))
write(21,*) 0.10 ! generic energy that will be overwritten in T(E) script
!print*, 'h:',(40+width)/real(int(1000_dp*(40+width)))
close (21)

end program 


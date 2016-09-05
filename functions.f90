module fns

use constants 
implicit none 

real(kind=dp),save :: E,static,high,width,Nd,phi_b,pd_applied

contains 

! Read energy from file input.dat

subroutine read_en

implicit none 

integer :: j

open(file='input.dat',unit=25,status='old',action='read')

do j =1,3

  read(25,*) E
  
  
end do 
  !print*, E
close(25)

end subroutine read_en 


! Read parameters of the potential well 

subroutine read_well

implicit none 

open(file='param_in.dat',unit=26,status='old',action='read')

read(26,*) static
read(26,*) high 
read(26,*) width 
read(26,*) Nd
read(26,*) phi_b
read(26,*) pd_applied
close(26)

end subroutine read_well 


! coupled first order DE's for the RK scheme 

function f(x,w)

implicit none

real(kind=dp), intent(in)                  :: x
complex(kind=dp), dimension(2), intent(in) :: w
complex(kind=dp), dimension(2)             :: f


f(1) = w(2)
f(2) = 2.0_dp*(V(x)-E)*w(1)
    
end function f
  

! Potential function 
! parameters are contained within the param_in.dat file 


function v(x)

real(kind=dp) :: v
real(kind=dp),intent(in) :: x

! locar vars 

real(kind=dp) :: v_field,v_ifl,x_p,x_0



x_0 = 7
!print*, x_0
!stop


if (x.lt.x_0) then 

  v=0

else if ( (x.ge.x_0).and.(x.le.(x_0+width)) ) then

  ! redefine co-ordinate to fit integral forms used  below

  x_p = x - x_0

! SZE

!v_field = (Nd*(width*x_p - 0.5_dp*x_p**2))/((-2.0_dp)*static)

! normal

v_field = (Nd*(width-x_p)**2)/(2.0_dp*static)

  v_ifl = -1.0_dp/(16.0_dp*high*pi*x_p)

  v =  v_field + v_ifl
  
  !print*, x_p,v_field

  ! account for the singularity about x'=0
  
  if (abs(v).gt.abs(phi_b+pd_applied)) then 

    v = 0

  end if

else 

  v = 0.0

end if

!print*, x,v_field+v_ifl,(phi_b + pd_applied ) + v_field,(phi_b + pd_applied ) + v_ifl

end function 


end module

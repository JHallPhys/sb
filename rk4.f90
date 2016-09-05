module rk

use constants
use fns

implicit none 

contains 
 
! fourth order Runge-Kutta

subroutine RK4(x,h,w)

real(kind=dp),intent(in)   :: x,h
complex(kind=dp), dimension(2) :: w,k1,k2,k3,k4
    
   

  k1 = h*f(x,w)
  k2 = h*f(x-(h/2),w-(k1/2))
  k3 = h*f(x-(h/2),w-(k2/2))       
  k4 = h*f(x-h,w-k3)

  w  = w - (k1+2*k2+2*k3+k4)/6
 
end subroutine 

end module 





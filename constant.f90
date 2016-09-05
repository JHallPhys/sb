module constants

implicit none 

integer,parameter :: dp = selected_real_kind(15,300)
real(kind=dp), parameter :: pi        = 3.141592653589793238462643_dp
real(kind=dp),parameter :: a_0 = 5.292E-10
real(kind=dp),parameter :: q_e = 1.602176462E-19
real(kind=dp),parameter :: m_e = 9.10938188E-31
real(kind=dp),parameter :: h_bar = 1.0545771596E-34

end module 

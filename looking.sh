#!/bin/bash 



gfortran constant.f90 param_init.f90 -o param_init.exe 

./param_init.exe

gfortran constant.f90 functions.f90 rk4.f90 schottky.f90 -o schottky.exe

#echo 
#echo 'starting run ...'
#echo
#echo 'time of run will be shown below w/ energy(left) and transmission coeff (right)'
#echo

#time ./schottky.exe

./schottky.exe >> tst.dat

#xmgrace -block tst.dat -bxy 1:2 -bxy 1:3 -bxy 1:4
#head -1 tst.dat
xmgrace tst.dat

rm tst.dat
#echo 
#echo 'showing wavefunction component plot'
#echo 
#sleep 1 

#xmgrace -block output.dat -bxy 1:2 -bxy 1:3 -bxy 1:4 -bxy 1:5 


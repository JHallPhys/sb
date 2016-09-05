#!/bin/bash 


clear

gfortran pd_int.f90 -o pd_int.exe
./pd_int.exe

i=1
sumit=0

while [ $i -lt 202 ] 

do


gfortran constant.f90 param_init.f90 -o param_init.exe
echo $i > dis.dat

./param_init.exe


gfortran constant.f90 functions.f90 rk4.f90 schottky.f90 -o schottky.exe
./schottky.exe >> pd.dat


v=$(echo "scale=3; $i/202" | bc)
v2=$(echo "scale=3; $v*100" | bc)

echo -ne " $v2 % Complete \r"

let i=i+1

done

#xmgrace pd.dat &

rm dis.dat

#!/bin/bash 


clear

echo 'Begin Schottky Simulation...'

gfortran constant.f90 param_init.f90 -o param_init.exe
./param_init.exe

echo
#sleep 1 
echo 'parameters updated'
#sleep 1
#echo 
#echo 'delaying half-life 3'
sleep 1
echo
echo 'starting run'
echo 

gfortran constant.f90 functions.f90 rk4.f90 schottky.f90 -o schottky.exe
gfortran en_int.f90 -o en_int.exe
./en_int.exe

i=1
sumit=0

while [ $i -lt 102 ] 

do

j=$(sed -n "$i"p interval.out) 

sed -i '$ d' input.dat ; sed -i '$ a '"$j"'' input.dat

./schottky.exe >> tve.dat


v=$(echo "scale=3; $i/102" | bc)
v2=$(echo "scale=3; $v*100" | bc)

echo -ne " $v2 % Complete \r"

let i=i+1

done
echo '100 % complete'
#echo
echo 
echo ' ~~~~~~~ FIN ~~~~~~~'
echo
#sleep 1 
#echo 'loading T(E) Graph'
#sleep 1 
#echo

#xmgrace tve.dat &

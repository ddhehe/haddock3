#!/bin/csh
#
cat /dev/null >t1
cat /dev/null >t2
cat /dev/null >t3
cat /dev/null >t4
cat /dev/null >t5
cat /dev/null >t6
cat /dev/null >t7
cat /dev/null >t8
cat /dev/null >t9
cat /dev/null >t10
foreach i ($argv)
  echo $i |awk '{printf "%s ",$1}' >>t1
  head -n50 $i | grep energies | sed s/\,/\ /g | awk '{printf "%f %f\n",$8,$9}' >>t1
  head -n50 $i | grep Desol | sed s/\,/\ /g | awk '{print $4}' >>t2
  head -n50 $i | grep Symm | sed s/\,/\ /g | awk '{print $4}' >>t3
  head -n50 $i | grep "water - chain1" | awk '{print $6}' >>t4
  head -n50 $i | grep "water - chain2" | awk '{print $6}' >>t5
  head -n50 $i | grep "water - water" | awk '{print $6}' >>t6
  head -n50 $i | grep "water - chain1" | awk '{print $7}' >>t7
  head -n50 $i | grep "water - chain2" | awk '{print $7}' >>t8
  head -n50 $i | grep "water - water"  | awk '{print $7}' >>t9
  head -n50 $i | grep energies | sed s/\,/\ /g | awk '{print $10}' >>t10
end

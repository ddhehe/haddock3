#!/bin/csh
#
setenv WDIR /data/capri/Capri47/Target160-scoring/ana_scripts
cat <<_Eod_ >statistics
#===============================================================
# target41 run2
#===============================================================
#
_Eod_
if (-e clusters_best4.scores) then
  cat clusters_best4.scores >>statistics
  set statfile=clusters_best4.scores
else if (-e  clusters_best2.scores) then
  cat clusters_best2.scores >>statistics  
  set statfile=clusters_best2.scores
else if (-e  clusters_best1.scores) then
  cat clusters_best1.scores >>statistics  
  set statfile=clusters_best1.scores
endif

mkdir molscript
foreach i (target41*_1.pdb)
  \cp $i `echo molscript/$i |sed -e 's/_1//'`
end

cd molscript
foreach i (*.pdb)
  delete_h.csh $i
  \rm $i.tmp
  profit <<_Eod_
    refe $WDIR/target41_refe.pdb
    zone A*
    atom CA
    mobi $i
    fit
    write $i
    quit
_Eod_
  cat <<_Eod1_>$i:r.molin
! MolScript v2.1 input file
! generated by MolAuto v1.1.1

plot

  window 100;
  background white;
_Eod1_
  echo 'read mol "'$i'";' >>$i:r.molin
  cat <<_Eod2_>>$i:r.molin

  transform atom *
    by centre position atom *
    by rotation x -90.0000
    by rotation z -90.0000;

_Eod2_

  set isel=`echo $i |sed -e 's/target41_run2_//' -e 's/\.pdb//'`
  set energies1=`grep $isel" " ../$statfile |awk '{print "Haddock="$5"+-"$6" BSA="$7"+-"$8" Edesol="$9"+-"$10" Dfire="$15"+-"$16}'`
  set energies2=`grep $isel" " ../$statfile |awk '{print "fc-elec="$11"+-"$12" fc-desol="$13"+-"$14" probe="$17"+-"$18" combined="$21"+-"$22}'`
  echo  'label -30.0 -45.0 0.0 "'$i'";'>>$i:r.molin
  echo  'label -5.0  -49.0 0.0 "'$energies1'";'>>$i:r.molin
  echo  'label -4.0  -53 0.0 "'$energies2'";'>>$i:r.molin

  cat <<_Eod3_>>$i:r.molin

  set colourparts on, residuecolour amino-acids rainbow;

  turn from A1 to A8;
  strand from A8 to A12;
  turn from A12 to A23;
  helix from A23 to A28;
  turn from A28 to A31;
  strand from A31 to A33;
  turn from A33 to A35;
  helix from A35 to A42;
  turn from A42 to A43;
  strand from A43 to A48;
  turn from A48 to A49;
  helix from A49 to A80;
  turn from A80 to A100;
  strand from A100 to A103;
  turn from A103 to A106;
  helix from A106 to A110;
  turn from A110 to A115;
  helix from A115 to A118;
  turn from A118 to A119;
  strand from A119 to A122;
  turn from A122 to A123;
  helix from A123 to A132;
  turn from A132 to B6;
  helix from B6 to B9;
  turn from B9 to B11;
  helix from B11 to B24;
  turn from B24 to B31;
  helix from B31 to B43;
  turn from B43 to B46;
  helix from B46 to B54;
  turn from B54 to B63;
  helix from B63 to B79;
  turn from B79 to B86;

end_plot

_Eod3_
  molscript <$i:r.molin>$i:r.ps
end
cd ..

foreach i (target41_run2_*.pdb)
  mkdir $i:r
  cd $i:r
  dimplot ../$i A B
  cd ..
end

foreach i (target41_run2_*_1.pdb)
  if (-e $i:r/ligplot.sum) then
    set rootfile=`echo $i |sed s/_1\.pdb//` 
    cat $rootfile'_'[1-5]/ligplot.sum |sort -n -k3 -k7> $rootfile.ligplot 
  endif
end

foreach i ( *.ligplot )
  echo '===========================' >dum
  echo $i >>dum
  echo '===========================' >>dum
  cat $i >>dum
  \mv dum $i
end

exit:

#!/bin/bash -x

#********************************************************************
Keta(){
  printf "%0$1d" $2
}

dig2(){
  printf "%02d" $1
}
#*******************************************************************

#Plot thermal graph
dt=0.05 #[/STEP]
soundv=346.5 #[m/s]
length=0.1 #[m]

xnum=\(\$1*${length}*${dt}/${soundv}\)


temp_inf=298.15
temp_0=273.15

ynum=\(\$2*${temp_inf}-${temp_0}\)

file1="formom_z00001"
file2="formom_z00001-0035"
file3="formom_z00001-035"

title1="Dc = 0    (OFF)"
title2="Dc = 0.035(0.25U)"
title3="Dc = 0.35 (1.00U)"

outfile="thermal_comp"
gnuplot <<EEE

set terminal postscript enhanced color "Times-Roman,12" size 12cm, 9cm

#set y2tics
set xlabel "Time [s]"
set ylabel "{/Times-Italic Temperature} [{/Times-Italic degC}]"
#set y2label "{/Times-Italic Nondimensional q}"

set output "${outfile}.eps"

# for gnuplot 5.0
set style line 1 pt 7 ps 0.7 dt 1     lw 2 lc rgb "black"
set style line 2 pt 7 ps 0.7 dt 1     lw 2 lc rgb "red"
set style line 3 pt 7 ps 0.7 dt 1     lw 2 lc rgb "royalblue"
set style line 4 pt 7 ps 0.7 dt 1     lw 2 lc rgb "forest-green"
set style line 5 pt 7 ps 0.7 dt (5,3) lw 2 lc rgb "red"
set style line 6 pt 7 ps 0.7 dt (5,3) lw 2 lc rgb "royalblue"
set style line 7 pt 7 ps 0.7 dt (5,3) lw 2 lc rgb "forest-green"

set grid
set xrange[0:60]
set yrange[89:95]
#set y2range[0:18]
#set y2tics 3

set key bottom left

p "${file1}" u ${xnum}:${ynum} w l ls 2 title '${title1}', \
  "${file2}" u ${xnum}:${ynum} w l ls 3 title '${title2}', \
  "${file3}" u ${xnum}:${ynum} w l ls 4 title '${title3}'
EEE

mogrify -density 288 -format png "${outfile}.eps"
mogrify -rotate 90 "${outfile}.png"

echo "generate ${outfile}.png"

rm *.eps
chmod 777 *png


#
#
#prefix="cx_z"
#
#$num=1.0
#xnum=\(\${num}*0.0005*5/340\)
#
#echo ${xnum}
#
#for iz in `seq 12 6 93`;
#do
#
#    iz1=$iz
#    iz2=$(($iz + 3))
#    file1="${prefix}${iz1}"
#    file2="${prefix}${iz2}"
#
#    echo "$file1 $file2"
#
#    xnum=\(\$1*0.0005*5/340\)
#    ynum=\(\$2*0.5*0.41**2*1.4*101.3*25*\(-1.0\)\)
#
#    cnt1=$(((93-$iz1)/3+1))
#    cnt2=$(((93-$iz2)/3+1))
#
#    brakenum=$((cnt1/2))
#    brakenum=`dig2 $brakenum`
#
##    title1="Center side (iz=${iz1})"
##    title2="Wall side   (iz=${iz2})"
#
#    title1="Center side (No. $brakenum)"
#    title2="Wall side   (No. $brakenum)"
#
##    outfile="drag_hist_z${iz1}_z${iz2}"
#    outfile="drag_hist_no$brakenum"
#
#    echo "$cnt1 $cnt2 $brakenum"
#
#gnuplot <<EEE
#
#set terminal postscript enhanced color "Times-Roman,12" size 12cm, 9cm
#
#set xlabel "Time [s]"
#set ylabel "{/Times-Italic F} [{/Times-Italic kN}]"
#
#set output "${outfile}.eps"
#
## for gnuplot 5.0
#set style line 1 pt 7 ps 0.7 dt 1     lw 2 lc rgb "black"
#set style line 2 pt 7 ps 0.7 dt (5,1) lw 2 lc rgb "royalblue"
#set style line 3 pt 7 ps 0.7 dt (5,1) lw 2 lc rgb "forest-green"
#set style line 4 pt 7 ps 0.7 dt 1     lw 2 lc rgb "red"
#
#set grid
#set xrange[15:23]
#set yrange[0:25]
#
#p "${file1}" u ${xnum}:${ynum} w l ls 4 title '${title1}', "${file2}" u ${xnum}:${ynum} w l ls 2 title '${title2}'
#
#EEE
#
#mogrify -density 288 -format png "${outfile}.eps"
#mogrify -rotate 90 "${outfile}.png"
#
#echo "generate ${outfile}.png"
#
#done
#
#rm *.eps
#chmod 777 *png
##-------------------------
#
#
#

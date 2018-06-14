#!/bin/bash

#********************************************************************
Keta(){
  printf "%0$1d" $2
}

dig2(){
  printf "%02d" $1
}
#*******************************************************************

prefix="cx_z"

#ka # initialize
#ka rm -rf cx*
#ka ln -fs ../01_setup_data/work/formom/${prefix}* ./

#==========================================================================
### CD => Drag convert factor detail
# Drag = 0.5 * rho * V^2 * S * CD
#      = 0.5 * M^2 * gamma * P * L^2 * CD (V=Mc, c^2=gamma*R*T, rho*R*T=P)

# 0.41  : M (Mach number)
# 1.4   : gamma
# 101.3 : P (1atm = 101.3kPa)
# 5.0   : L (Grid scale, 1 grid-length = 5.0m)
#==========================================================================


#-------------------------
for iz in `seq 12 6 93`;
do

    iz1=$iz
    iz2=$(($iz + 3))
    file1="${prefix}${iz1}"
    file2="${prefix}${iz2}"

    echo "$file1 $file2"

    xnum=\(\$1*0.0005*5/340\)
    ynum=\(\$2*0.5*0.41**2*1.4*101.3*25*\(-1.0\)\)

    cnt1=$(((93-$iz1)/3+1))
    cnt2=$(((93-$iz2)/3+1))

    brakenum=$((cnt1/2))
    brakenum=`dig2 $brakenum`

#    title1="Center side (iz=${iz1})"
#    title2="Wall side   (iz=${iz2})"

    title1="Center side (No. $brakenum)"
    title2="Wall side   (No. $brakenum)"

#    outfile="drag_hist_z${iz1}_z${iz2}"
    outfile="drag_hist_no$brakenum"

    echo "$cnt1 $cnt2 $brakenum"

gnuplot <<EEE

set terminal postscript enhanced color "Times-Roman,12" size 12cm, 9cm

set xlabel "Time [s]"
set ylabel "{/Times-Italic F} [{/Times-Italic kN}]"

set output "${outfile}.eps"

# for gnuplot 5.0
set style line 1 pt 7 ps 0.7 dt 1     lw 2 lc rgb "black"
set style line 2 pt 7 ps 0.7 dt (5,1) lw 2 lc rgb "royalblue"
set style line 3 pt 7 ps 0.7 dt (5,1) lw 2 lc rgb "forest-green"
set style line 4 pt 7 ps 0.7 dt 1     lw 2 lc rgb "red"

set grid
set xrange[15:23]
set yrange[0:25]

p "${file1}" u ${xnum}:${ynum} w l ls 4 title '${title1}', "${file2}" u ${xnum}:${ynum} w l ls 2 title '${title2}'

EEE

mogrify -density 288 -format png "${outfile}.eps"
mogrify -rotate 90 "${outfile}.png"

echo "generate ${outfile}.png"

done

rm *.eps
chmod 777 *png
#-------------------------

##-------------------------
#
#for infile in $( ls . | grep ^${prefix} );
#do
#
#    echo "read ${infile}"
#    iz=${infile:4}
#
#    title="brake drag history (iz=${iz})"
#    outfile="drag_hist_z${iz}"
#
#    xnum=\(\$1*0.0005*5/340\)
#    ynum=\(\$2*0.5*0.41**2*1.4*101.3*25*\(-1.0\)\)
#  
#    ### input file detail
#    # R1 : step
#    # R2 : Total drag
#    # R3 : front surface drag
#    # R4 : rear surface drag
#
#    # if [ $(( $((${iz}-${zst})) % ${zint} )) = 0 ];then
#    # 	# right brake
#    # 	ynum=\(\$2*0.5*0.41**2*1.4*101.3*25*\(-1.0\)\)
#    # else
#    # 	# left brake
#    # 	ynum=\(\$2*0.5*0.41**2*1.4*101.3*25*\(-1.0\)\)
#  
#    # Convert non-dimentional data to dimentional one
#  
#    # if [ "$pos" = "both" ];then
#    # 	#    lsnum=1
#    # 	ynum=\(\(\$3+\$7\)*0.5*0.5*0.41**2*1.4*101.3*25*\(-1.0\)\)
#    # elif [ "$pos" = "r" ];then
#    # 	#    lsnum=2
#    # 	ynum=\(\$3*0.5*0.41**2*1.4*101.3*25*\(-1.0\)\)
#    # else
#    # 	#    lsnum=3
#    # 	ynum=\(\$7*0.5*0.41**2*1.4*101.3*25*\(-1.0\)\)
#    # fi
#
#gnuplot <<EEE
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
##plot "${infile}" u 1:${ynum} w l ls 4 title '${title}'
#plot "${file1}" u ${xnum}:${ynum} w l ls 4 title '${title1}',\
#     "${file2}" u ${xnum}:${ynum} w l ls 4 title '${title2}'
#
#EEE
#  
##/usr/bin/convert -density 300x300 ${outfile}.eps ${outfile}.png
#mogrify -density 288 -format png "${outfile}.eps"
#mogrify -rotate 90 "${outfile}.png"
#
#echo "generate ${outfile}.png"
#
#done
#
#rm *.eps
#chmod 777 *png

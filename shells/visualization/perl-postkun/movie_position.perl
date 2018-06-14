#please input jkl,istart,iend
$outfile="position_movie.hist";

$jmax_all=1283;

$jst_all=40;
$jls_all=-40;

$car_num=4;
$car_stup=1;
$car_stlow=5;

$brake_num=14;
$brake_stzone=12;
$brake_zoneadd=2;

$zone_all=9;


if ($jls_all < 0){
    $jls_all = $jls_all + $jmax_all
}

open (OUT, "> $outfile");    
print(OUT " \n");
print(OUT "ReadGrid grid.post -U -Z -3D -O -r8\n");
print(OUT "CreateWindow -fix \n");
print(OUT "configurewindow 1 10 90 1880 80 \n");
print(OUT "background 1 white \n");
$ist=1;
$ied=$car_num;
$iadd=1;
for($i=$ist;$i<$ied+1;$i=$i+$iadd){
    $icarup  = $car_stup  + $i - 1;
    $icarlow = $car_stlow + $i - 1;
    print(OUT "GridSurface L=1 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col gray -Z $icarup \n");
    print(OUT "GridSurface L=1 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col gray -Z $icarlow \n");
}
$ist=1;
$ied=$brake_num;
$iadd=1;
for($i=$ist;$i<$ied+1;$i=$i+$iadd){
    $ibrake  = $brake_stzone  + ($i - 1) * $brake_zoneadd;
    print(OUT "GridSurface L=1 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col red -Z $ibrake \n");
}
print(OUT "SetLight On 0 0 1 \n");
print(OUT "FullView 1 39.8125 0.251147 0.821145 0 -1 0 0 0 1 80.1736 -2 0 0 0.25 \n");
$ist=$jst_all;
$ied=$jls_all;
$iadd=1;
for($i=$ist;$i<$ied+1;$i=$i+$iadd){
    $jnum = $i;
    $jnum_0pad = sprintf("%04d",$jnum);
    print(OUT "Grid J=$jnum -Int 1 1 1 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col red -Z $zone_all \n");
    print(OUT "%import -window 'postkun 1' pos-$jnum_0pad.png \n");
    print(OUT "dp \n");
}


    


#for($i=$ist;$i<$ied+1;$i=$i+200){
#    $j=$i;
#    $k=$i/200-2000;
#    print(OUT "currenttime $j \n");
#    print(OUT "TransGrid -reset \n");
#    print(OUT "Background 1 black \n");
#    print(OUT "FullView 1 0.327294 0.0191544 0.0789737 -0.337483 -0.732827 0.590822 0.161968 0.573078 0.803336 0.9 -2 0 0 0.25 \n");
#    print(OUT "RangeMode Auto \n");
#    print(OUT "SetLight On 0.000000 0.000000 1.000000 \n");
#    print(OUT "SetZoom 1 0.900000 \n");
#    print(OUT "GridSurface L=1 -J 45 307 -K 1 Kmax -L 1 Lmax -col 150 150 150 \n");
#    print(OUT "Iso 44 \n");
#    print(OUT "IsoSurface 10 -J 100 320 -K 1 Kmax -L 1 Lmax \n");
#    print(OUT "Function 19 \n");
#    print(OUT "ContourRange -10.000000 10.000000 \n");
#    print(OUT "ColorMode 9 \n");
#    print(OUT "Grid J=151 -Int 1 1 1 -J 1 Jmax -K 1 Kmax -L 1 10 -col red \n");
#    print(OUT "Grid J=148 -Int 1 1 1 -J 1 Jmax -K 1 Kmax -L 1 10 -col blue \n");
#    print(OUT "Grid J=154 -Int 1 1 1 -J 1 Jmax -K 1 Kmax -L 1 10 -col blue \n");
#    print(OUT "SaveSet \n");
#    print(OUT "ContourSurface K=0 -J 1 Jmax -K 1 Kmax -L 1 Lmax \n");
#    print(OUT "Function u \n");
#    print(OUT "ContourRange 0.000000 0.300000 \n");
#    print(OUT "TransGrid 0 0.2 0 \n");
#    print(OUT "ContourSurface L=2 -J 1 Jmax -K 1 Kmax -L 1 Lmax \n");
#    print(OUT ":L=3 -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z 0 \n");
#    $kk = sprintf("%03d",$k);
#    print(OUT "%import -window \"postkun 1\" qwithu/$kk.png\n");
#    print(OUT "dp * \n");
#    print(OUT "delset * \n");
#    print(OUT "SetLight Off \n");
#    print(OUT "Function 3 \n");
#    print(OUT "ContourRange 0.900000 1.000000 \n");
#    print(OUT "ContourLevel 40 \n");
#    print(OUT "ContourFilledSurface K=50 -J 1 Jmax -K 1 Kmax -L 1 Lmax \n");
#    print(OUT "ViewDirection 1 -Y \n");
#    print(OUT "Contour K=50 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col black \n");
#    print(OUT "FullView 1 0.487983 0 0.032934 -0 -1 -0 0 0 1 1.02919 -2 0 0 0.25 \n");
#    print(OUT "%import -window \"postkun 1\" cp/$kk.png\n");
#    print(OUT "dp * \n");
#    print(OUT "delset * \n");
#    print(OUT "ViewDirection 1 -Y \n");
#    print(OUT "RangeMode ByHand \n");
#    print(OUT "GridSurface K=50 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col black \n");
#    print(OUT "FullView 1 0.13579 0 0.0682619 -0 -1 -0 0 0 1 0.23094 -2 0 0 0.25 \n");
#    print(OUT "Background 1 gray \n");
#    print(OUT "vfn 1\n");
#    print(OUT "NearSurfaceStreamline K=51 10 60 3 130 140 5 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col grey \n");
#    print(OUT "NearSurfaceStreamline K=51 10 30 3 150 220 2 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col grey \n");
#    print(OUT "vfn 1\n");
#    print(OUT "Function 15 \n");
#    print(OUT "ContourRange -0.000010 0.300000 \n");
#    print(OUT "Contour K=50 -J 1 Jmax -K 1 Kmax -L 1 Lmax \n");
#    print(OUT "Grid J=151 -Int 1 1 1 -J 1 Jmax -K 1 Kmax -L 1 20 \n");
#    print(OUT "ColorMode 9 \n");
#    print(OUT "%import -window \"postkun 1\" shear/$kk.png\n");
#    print(OUT "dp * \n");
#    print(OUT "delset * \n");
#
#}
close(3)

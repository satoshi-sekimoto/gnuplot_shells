#please input jkl,istart,iend
$outfile="getallmovie.hist";

$jst_1=1;
$jst_2=318;
$jst_3=639;
$jst_4=960;

$jmax_all=1283;
$jmax_1=325;
$jmax_2=329;
$jmax_3=329;
$jmax_4=324;


$jst_all=40;
$jls_all=1243;

$iflag=1;

open (OUT, "> $outfile");    
print(OUT " \n");
print(OUT "ReadGrid grid.post -U -Z -3D -O -r8\n");
print(OUT "ReadFlow flow.post -U -Z -3D -PUD -O -r4 \n");
print(OUT "CreateWindow -fix \n");
print(OUT "configurewindow 1 780 100 1120 720 \n");
print(OUT "background 1 white \n");
#TEST write
print(OUT "fn 37 \n");
print(OUT "vfn 1 \n");
print(OUT " \n");
print(OUT "vd 1 -x \n");
print(OUT "ContourFilledSurface J=1 -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z 2 \n");
print(OUT "Vector -Int 1 2 10 -J 1 1 -K 1 Kmax -L 1 20 -col black -Z 2 \n");
print(OUT "Vector -Int 1 2 4 -J 1 1 -K 1 Kmax -L 21 24 -col black -Z 2 \n");
print(OUT "Vector -Int 1 2 1 -J 1 1 -K 1 Kmax -L 25 Lmax -col black -Z 2 \n");
print(OUT "ContourFilledSurface J=1 -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z 6 \n");
print(OUT "Vector -Int 1 3 3 -J 1 1 -K 1 Kmax -L 1 Lmax -col black -Z 6 \n");
print(OUT "ContourFilledSurface J=318 -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z 9 \n");
print(OUT "Vector -Int 1 2 1 -J 318 318 -K 1 Kmax -L 1 Lmax -col black -Z 9 \n");
print(OUT "ContourFilledSurface J=318 -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z 10 \n");
print(OUT "Vector -Int 1 2 1 -J 318 318 -K 1 Kmax -L 1 Lmax -col black -Z 10 \n"); 
print(OUT "ArrowAttribute 0.40000 1.0000 \n");
print(OUT "VectorScale 3.500000 \n");
print(OUT "FullView 1 15.4106 -0.553317 0.710405 1 0 0 0 0 1 2.61373 -2 0 0 0.25 \n");
print(OUT "VectorProjection On \n");
print(OUT "ContourRange 0.0 0.7 \n");
print(OUT "dp * \n");

$ist=$jst_all;
$ied=$jls_all;
$iadd=1;

for($i=$ist;$i<$ied+1;$i=$i+$iadd){
    $j_all=$i;
    if ($j_all < $jst_2){
	$bodyup_zone=1;
	$bodylow_zone=5;
	$j_body=$j_all
    }
    elsif($j_all < $jst_3 and $j_all >= $jst_2){
	$bodyup_zone=2;
	$bodylow_zone=6;
	$j_body=$j_all - $jst_2 + 1;
    }
    elsif($j_all < $jst_4 and $j_all >= $jst_3){
	$bodyup_zone=3;
	$bodylow_zone=7;
	$j_body=$j_all - $jst_3 + 1;
    }
    else{
	$bodyup_zone=4;
	$bodylow_zone=8;
	$j_body=$j_all - $jst_4 + 1;
    }
    print(OUT "ContourFilledSurface J=$j_body -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z $bodyup_zone \n");
    print(OUT "Vector -Int 1 2 10 -J $j_body $j_body -K 1 Kmax -L 1 20 -col black -Z $bodyup_zone \n");
    print(OUT "Vector -Int 1 2 4 -J $j_body $j_body -K 1 Kmax -L 21 24 -col black -Z $bodyup_zone \n");
    print(OUT "Vector -Int 1 2 1 -J $j_body $j_body -K 1 Kmax -L 25 Lmax -col black -Z $bodyup_zone \n");
    print(OUT "ContourFilledSurface J=$j_body -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z $bodylow_zone \n");
    print(OUT "Vector -Int 1 3 3 -J $j_body $j_body -K 1 Kmax -L 1 Lmax -col black -Z $bodylow_zone \n");
    
    print(OUT "ContourFilledSurface J=$j_all -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z 9 \n");
    print(OUT "Vector -Int 1 2 1 -J $j_all $j_all -K 1 Kmax -L 1 Lmax -col black -Z 9 \n");
    if($iflag == 1){
	print(OUT "ContourFilledSurface J=$j_all -J 1 Jmax -K 1 Kmax -L 1 Lmax -Z 10 \n");
	print(OUT "Vector -Int 1 2 1 -J $j_all $j_all -K 1 Kmax -L 1 Lmax -col black -Z 10 \n");
    }
    $j_allmod=$j_all % 70;
    if($j_allmod <= 1 and $j_all > 209 and $j_all < 1189){
	$ibrake=(int($j_all/70) - 3) * 2 + 12;
	print(OUT "GridSurface L=1 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col red -Z $ibrake \n");
	$ibrake=$ibrake+1;
	print(OUT "GridSurface L=1 -J 1 Jmax -K 1 Kmax -L 1 Lmax -col red -Z $ibrake \n");
    }
    $j_all0pad = sprintf("%04d",$j_all);
    print(OUT "%import -window \"postkun 1\" visualinj_$j_all0pad.png\n");
    print(OUT "dp * \n");

}
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

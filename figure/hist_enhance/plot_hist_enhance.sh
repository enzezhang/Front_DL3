#!/bin/bash

rm gmt.* 

#bash /home/zez/data1/Landsat8/Helheim/script/result_plot.sh /home/zez/data1/Landsat8/Helheim/grd_non_stretch/20150411_232013_crop_landsat_Helheim.grd /home/zez/data1/test20/in_polygon_gmt_Helheim_test_Apr2/20150411_232013_crop_landsat_Helheim.gmt 20150411 /home/zez/data1/Landsat8/Helheim/figure/test_Apr2/20150411_232013_crop_landsat_Helheim.ps
#bash result_plot_landsat.sh 20150612_hh_GEE_sentinel_GRD_IW_helheim.tif 20150612 20150612_hh_GEE_sentinel_GRD_IW_helheim.ps
#bash result_plot_landsat.sh 20150612_hh_GEE_sentinel_GRD_IW_helheim_stretch.tif 20150612 20150612_hh_GEE_sentinel_GRD_IW_helheim_stretch.ps
path=/Users/EnzeZhang/data/calving_front_deep_learning/figure/hist_enhance
imagename=$path/20151020_232013_crop_landsat_Helheim.tif

date=20151020
PS=$path/hist_enhance_Jun16_4.ps
gmt gmtset MAP_FRAME_TYPE plain
gmt gmtset FONT_ANNOT_PRIMARY = +14p,Helvetica,black
gmt gmtset FORMAT_GEO_OUT = ddd:mm:ssF	
gmt gmtset MAP_VECTOR_SHAPE=1.4

R=-38.28/-38.07/66.32/66.41
J=M8.3



gmt psbasemap -J$J -R$R -K -V -P -Ba0 -X2i> $PS
pwd
#echo "gmt grd2cpt $imagename -R$R -Cgray -Z > sar1.cpt"
#rm sar1.cpt
#gmt makecpt -Cgray -T0/500/50 > sar1.cpt
# gmt grd2cpt $imagename -R$R -Cgray > sar1.cpt

gmt grdimage $imagename -R$R -J$J -Clandsat_ori.cpt -K -O -Q >>$PS

# gmt psxy -R$R -J$J -A -W2p,red $calving_line -K -O >>$PS
gmt gmtset FONT_ANNOT_PRIMARY = +10p,Helvetica,black
gmt psbasemap -J$J -R$R -Lg-38.23/66.388+c-38.175+w4k+u+f -F+gwhite -O -K -V -P >> $PS

echo $date


echo -38.23 66.378 $date |gmt pstext -J$J -R$R -O -F+f14p,0,black -K -Wwhite -Gwhite -C10%/10% -TO >>$PS
echo -38.23 66.402 Helheim |gmt pstext -J$J -R$R -O -F+f14p,0,black -K -Wwhite -Gwhite -C10%/10% -TO >>$PS
echo -38.23 66.395 Landsat-8|gmt pstext -J$J -R$R -O -F+f14p,0,black -Wwhite -Gwhite -C10%/10% -TO -K >>$PS
echo -38.09 66.402 \(a\) |gmt pstext -J$J -R$R -O -F+f14p,0,black -Wwhite -Gwhite -C10%/10% -TO -K >>$PS

gmt psxy -J$J -R$R -O -K -W2p,blue >> $PS <<EOF

-38.22 66.325
-38.11 66.325
-38.11 66.36
-38.22 66.36
-38.22 66.325
EOF

gmt psbasemap -J$J -R$R -O -V -P -Bxa -Bya -BWSen -K >> $PS



imagename=$path/20151020_232013_crop_landsat_Helheim_stretch.tif
calving_line=$path/20151020_232013_crop_landsat_Helheim_stretch.gmt
R=-38.22/-38.11/66.325/66.36
J=M5.5
gmt psbasemap -J$J -R$R -K -O -V -P -Ba0 -X3.35i  >> $PS

gmt grdimage $imagename -R$R -J$J -Ctest_histeq_4.cpt -O -K -Q >>$PS

echo -38.12 66.355 \(c\) |gmt pstext -J$J -R$R -O -F+f14p,0,black -Wwhite -Gwhite -C10%/10% -TO -K >>$PS

gmt psxy -R$R -J$J -A -W2p,red $calving_line -K -O >>$PS

imagename=$path/20151020_232013_crop_landsat_Helheim.tif
calving_line=$path/20151020_232013_crop_landsat_Helheim.gmt

gmt psbasemap -J$J -R$R -K -O -V -P -Ba0 -Y1.77i  >> $PS

gmt grdimage $imagename -R$R -J$J -Clandsat_ori.cpt -O -K -Q >>$PS

echo -38.12 66.355 \(b\) |gmt pstext -J$J -R$R -O -F+f14p,0,black -Wwhite -Gwhite -C10%/10% -TO -K >>$PS

gmt psxy -R$R -J$J -A -W2p,red $calving_line -O >>$PS


gmt psconvert -E400 -Tg -A $PS









gmt psconvert -E300 -A -Tg $PS
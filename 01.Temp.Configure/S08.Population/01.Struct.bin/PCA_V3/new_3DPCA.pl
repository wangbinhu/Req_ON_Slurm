#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use Getopt::Long;
#explanation:this program is edited to 
#edit by HeWeiMing;   Sat Feb 27 10:10:13 CST 2010
#Version 1.0    hewm@genomics.org.cn 
my ($output,$help,$chromosome,$input);

GetOptions(
    "input:s"=>\$input,
    "output:s"=>\$output,
    "help"=>\$help,
);

sub  usage
{
    print STDERR <<USAGE;
     Version:1.0    2009-10-22       hewm\@genomics.org.cn
        Options
         -input  <s> : PCA out [1_2.eigenvector.xls]
         -output <s> : OutPut file , addcn file
         -help       : show this help

USAGE
}

#############swimming in the sky and flying in the sea #########
if(!defined($input) ||  !defined($output)  || defined($help)  )
{
  usage ;
  exit(1) ;
}
#############Befor  Start  , open the files ####################
 

 my @ColArry ; 
 $ColArry[0]="Blue";
 $ColArry[1]="Green";
 $ColArry[2]="Red";
 $ColArry[3]="black";
 $ColArry[4]="Magenta";
 $ColArry[5]="greenyellow";
# $ColArry[5]="lightgodenrodyellow";
 $ColArry[6]="Purple";
 $ColArry[7]="Brown";
 $ColArry[8]="Orange";
 $ColArry[9]="Cyan";
 $ColArry[10]="Grey";
 $ColArry[11]="LightSkyBlue";
 $ColArry[12]="Gold";
 $ColArry[13]="IndianRed2";
 $ColArry[14]="DeepSkyBlue2";
 $ColArry[15]="Chartreuse2";
 $ColArry[16]="Orchid";
 $ColArry[17]="DimGrey";
 $ColArry[18]="SlateGrey";
 $ColArry[19]="LightSlateGray";
 $ColArry[20]="Gold1";
 $ColArry[21]="SaddleBrown";
 $ColArry[22]="MidnightBlue";
 $ColArry[23]="NavyBlue";
 $ColArry[24]="YellowGreen";
 $ColArry[25]="CornflowerBlue";
 $ColArry[26]="MediumBlue";
 $ColArry[27]="DarkOrange3";
 $ColArry[28]="RoyalBlue";
 $ColArry[29]="DeepPink";
 $ColArry[30]="DeepSkyBlue1";
 $ColArry[31]="MediumTurquoise";
 $ColArry[32]="Turquoise";
 $ColArry[33]="SpringGreen3";
 $ColArry[34]="CadetBlue";
 $ColArry[35]="DodgerBlue";
 $ColArry[36]="MediumAquamarine";
 $ColArry[37]="Aquamarine";
 $ColArry[38]="DarkGreen";
 $ColArry[39]="DarkOliveGreen";
 $ColArry[40]="DarkSeaGreen";
 $ColArry[41]="SeaGreen";
 $ColArry[42]="MediumSeaGreen";
 $ColArry[43]="LightSeaGreen";
 $ColArry[44]="PaleGreen";
 $ColArry[45]="SpringGreen";
 $ColArry[46]="LawnGreen";
 $ColArry[47]="Chartreuse";
 $ColArry[48]="MedSpringGreen";
 $ColArry[49]="GreenYellow";
 $ColArry[50]="LimeGreen";
 $ColArry[51]="OrangeRed2";
 $ColArry[52]="DeepSkyBlue";
 $ColArry[53]="Magenta3";
 $ColArry[54]="SteelBlue";
 $ColArry[55]="LightSteelBlue";
 $ColArry[56]="LightBlue";
 $ColArry[57]="PowderBlue";
 $ColArry[58]="PaleTurquoise";
 $ColArry[59]="DarkTurquoise";
 $ColArry[60]="ForestGreen";
 $ColArry[61]="OliveDrab";
 $ColArry[62]="DarkKhaki";
 $ColArry[63]="PaleGoldenrod";
 $ColArry[64]="LtGoldenrodYello";
 $ColArry[65]="Pink";
 $ColArry[66]="LightYellow";
 $ColArry[67]="LightGoldenrod";
 $ColArry[68]="goldenrod";
 $ColArry[69]="DarkGoldenrod";
 $ColArry[70]="RosyBrown";
 $ColArry[71]="IndianRed";
 $ColArry[72]="Sienna";
 $ColArry[73]="Peru";
 $ColArry[74]="DarkSlateGray";
 $ColArry[75]="Burlywood";
 $ColArry[76]="SkyBlue";
 $ColArry[77]="Beige";
 $ColArry[78]="Wheat";
 $ColArry[79]="SandyBrown";
 $ColArry[80]="Tan";
 $ColArry[81]="Chocolate";
 $ColArry[82]="Firebrick";
 $ColArry[83]="DarkSalmon";
 $ColArry[84]="Salmon";
 $ColArry[85]="LightSalmon";
 $ColArry[86]="Coral";
 $ColArry[87]="LightCoral";
 $ColArry[88]="Tomato";
 $ColArry[89]="OrangeRed";
 $ColArry[90]="HotPink";
 $ColArry[91]="LightPink";
 $ColArry[92]="PaleVioletRed";
 $ColArry[93]="Maroon";
 $ColArry[94]="MediumVioletRed";
 $ColArry[95]="VioletRed";
 $ColArry[96]="Violet";
 $ColArry[97]="Plum";
 $ColArry[98]="DarkSlateBlue";
 $ColArry[99]="SlateBlue";
 $ColArry[100]="MediumSlateBlue";
 $ColArry[101]="LightSlateBlue";
 $ColArry[102]="MediumOrchid";
 $ColArry[103]="DarkOrchid";
 $ColArry[104]="DarkViolet";
 $ColArry[105]="BlueViolet";
 $ColArry[106]="MediumPurple";
 $ColArry[107]="Thistle";
 $ColArry[108]="Snow1";
 $ColArry[109]="Snow2";
 $ColArry[110]="Snow3";
 $ColArry[111]="Snow4";
 $ColArry[112]="Seashell1";
 $ColArry[113]="Seashell2";
 $ColArry[114]="Seashell3";
 $ColArry[115]="Seashell4";
 $ColArry[116]="AntiqueWhite1";
 $ColArry[117]="AntiqueWhite2";
 $ColArry[118]="AntiqueWhite3";
 $ColArry[119]="AntiqueWhite4";
 $ColArry[120]="Bisque1";
 $ColArry[121]="Bisque2";
 $ColArry[122]="Bisque3";
 $ColArry[123]="Bisque4";
 $ColArry[124]="PeachPuff1";
 $ColArry[125]="PeachPuff2";
 $ColArry[126]="PeachPuff3";
 $ColArry[127]="PeachPuff4";
 $ColArry[128]="NavajoWhite1";
 $ColArry[129]="NavajoWhite2";
 $ColArry[130]="NavajoWhite3";
 $ColArry[131]="NavajoWhite4";
 $ColArry[132]="LemonChiffon1";
 $ColArry[133]="LemonChiffon2";
 $ColArry[134]="LemonChiffon3";
 $ColArry[135]="LemonChiffon4";
 $ColArry[136]="Cornsilk1";
 $ColArry[137]="Cornsilk2";
 $ColArry[138]="Cornsilk3";
 $ColArry[139]="Cornsilk4";
 $ColArry[140]="Ivory1";
 $ColArry[141]="Ivory2";
 $ColArry[142]="Ivory3";
 $ColArry[143]="Ivory4";
 $ColArry[144]="Honeydew1";
 $ColArry[145]="Honeydew2";
 $ColArry[146]="Honeydew3";
 $ColArry[147]="Honeydew4";
 $ColArry[148]="LavenderBlush1";
 $ColArry[149]="LavenderBlush2";
 $ColArry[150]="LavenderBlush3";
 $ColArry[151]="LightGray";
 $ColArry[152]="LavenderBlush4";
 $ColArry[153]="MistyRose1";
 $ColArry[154]="MistyRose2";
 $ColArry[155]="MistyRose3";
 $ColArry[156]="MistyRose4";
 $ColArry[157]="Azure1";
 $ColArry[158]="Azure2";
 $ColArry[159]="Azure3";
 $ColArry[160]="Azure4";
 $ColArry[161]="SlateBlue1";
 $ColArry[162]="SlateBlue2";
 $ColArry[163]="SlateBlue3";
 $ColArry[164]="SlateBlue4";
 $ColArry[165]="RoyalBlue1";
 $ColArry[166]="RoyalBlue2";
 $ColArry[167]="RoyalBlue3";
 $ColArry[168]="RoyalBlue4";
 $ColArry[169]="Blue1";
 $ColArry[170]="Blue2";
 $ColArry[171]="Blue3";
 $ColArry[172]="Blue4";
 $ColArry[173]="DodgerBlue1";
 $ColArry[174]="DodgerBlue2";
 $ColArry[175]="DodgerBlue3";
 $ColArry[176]="DodgerBlue4";
 $ColArry[177]="SteelBlue1";
 $ColArry[178]="SteelBlue2";
 $ColArry[179]="SteelBlue3";
 $ColArry[180]="SteelBlue4";
 $ColArry[181]="DeepSkyBlue3";
 $ColArry[182]="DeepSkyBlue4";
 $ColArry[183]="SkyBlue1";
 $ColArry[184]="SkyBlue2";
 $ColArry[185]="SkyBlue3";
 $ColArry[186]="SkyBlue4";
 $ColArry[187]="LightSkyBlue1";
 $ColArry[188]="LightSkyBlue2";
 $ColArry[189]="LightSkyBlue3";
 $ColArry[190]="LightSkyBlue4";
 $ColArry[191]="SlateGray1";
 $ColArry[192]="SlateGray2";
 $ColArry[193]="SlateGray3";
 $ColArry[194]="SlateGray4";
 $ColArry[195]="LightSteelBlue1";
 $ColArry[196]="LightSteelBlue2";
 $ColArry[197]="LightSteelBlue3";
 $ColArry[198]="LightSteelBlue4";
 $ColArry[199]="LightBlue1";
 $ColArry[200]="Aquamarine1";
 $ColArry[201]="LightBlue2";
 $ColArry[202]="LightBlue3";
 $ColArry[203]="LightBlue4";
 $ColArry[204]="LightCyan1";
 $ColArry[205]="LightCyan2";
 $ColArry[206]="LightCyan3";
 $ColArry[207]="LightCyan4";
 $ColArry[208]="PaleTurquoise1";
 $ColArry[209]="PaleTurquoise2";
 $ColArry[210]="PaleTurquoise3";
 $ColArry[211]="PaleTurquoise4";
 $ColArry[212]="CadetBlue1";
 $ColArry[213]="CadetBlue2";
 $ColArry[214]="CadetBlue3";
 $ColArry[215]="CadetBlue4";
 $ColArry[216]="Turquoise1";
 $ColArry[217]="Turquoise2";
 $ColArry[218]="Turquoise3";
 $ColArry[219]="Turquoise4";
 $ColArry[220]="Cyan1";
 $ColArry[221]="Cyan2";
 $ColArry[222]="Cyan3";
 $ColArry[223]="Cyan4";
 $ColArry[224]="DarkSlateGray1";
 $ColArry[225]="DarkSlateGray2";
 $ColArry[226]="DarkSlateGray3";
 $ColArry[227]="DarkSlateGray4";
 $ColArry[228]="Aquamarine2";
 $ColArry[229]="Aquamarine3";
 $ColArry[230]="Aquamarine4";
 $ColArry[231]="DarkSeaGreen1";
 $ColArry[232]="DarkSeaGreen2";
 $ColArry[233]="DarkSeaGreen3";
 $ColArry[234]="DarkSeaGreen4";
 $ColArry[235]="SeaGreen1";
 $ColArry[236]="SeaGreen2";
 $ColArry[237]="SeaGreen3";
 $ColArry[238]="SeaGreen4";
 $ColArry[239]="PaleGreen1";
 $ColArry[240]="PaleGreen2";
 $ColArry[241]="PaleGreen3";
 $ColArry[242]="PaleGreen4";
 $ColArry[243]="SpringGreen1";
 $ColArry[244]="SpringGreen2";
 $ColArry[245]="SpringGreen4";
 $ColArry[246]="Green1";
 $ColArry[247]="Green2";
 $ColArry[248]="Green3";
 $ColArry[249]="Green4";
 $ColArry[250]="Chartreuse1";
 $ColArry[251]="Chartreuse3";
 $ColArry[252]="Chartreuse4";
 $ColArry[253]="OliveDrab1";
 $ColArry[254]="OliveDrab2";
 $ColArry[255]="OliveDrab3";
 $ColArry[256]="OliveDrab4";
 $ColArry[257]="DarkOliveGreen1";
 $ColArry[258]="DarkOliveGreen2";
 $ColArry[259]="DarkOliveGreen3";
 $ColArry[260]="DarkOliveGreen4";
 $ColArry[261]="Khaki1";
 $ColArry[262]="Khaki2";
 $ColArry[263]="Khaki3";
 $ColArry[264]="Khaki4";
 $ColArry[265]="LightGoldenrod1";
 $ColArry[266]="LightGoldenrod2";
 $ColArry[267]="LightGoldenrod3";
 $ColArry[268]="LightGoldenrod4";
 $ColArry[269]="LightYellow1";
 $ColArry[270]="LightYellow2";
 $ColArry[271]="LightYellow3";
 $ColArry[272]="LightYellow4";
 $ColArry[273]="Yellow1";
 $ColArry[274]="Yellow2";
 $ColArry[275]="Yellow3";
 $ColArry[276]="Yellow4";
 $ColArry[277]="Gold2";
 $ColArry[278]="Gold3";
 $ColArry[279]="Gold4";
 $ColArry[280]="Goldenrod1";
 $ColArry[281]="Goldenrod2";
 $ColArry[282]="Goldenrod3";
 $ColArry[283]="Goldenrod4";
 $ColArry[284]="DarkGoldenrod1";
 $ColArry[285]="DarkGoldenrod2";
 $ColArry[286]="DarkGoldenrod3";
 $ColArry[287]="DarkGoldenrod4";
 $ColArry[288]="RosyBrown1";
 $ColArry[289]="RosyBrown2";
 $ColArry[290]="RosyBrown3";
 $ColArry[291]="RosyBrown4";
 $ColArry[292]="IndianRed1";
 $ColArry[293]="IndianRed2";
 $ColArry[294]="IndianRed3";
 $ColArry[295]="IndianRed4";
 $ColArry[296]="Sienna1";
 $ColArry[297]="Sienna2";
 $ColArry[298]="Sienna3";
 $ColArry[299]="Sienna4";
 $ColArry[300]="Burlywood1";
 $ColArry[301]="Burlywood2";
 $ColArry[302]="Burlywood3";
 $ColArry[303]="Burlywood4";
 $ColArry[304]="Wheat1";
 $ColArry[305]="Wheat2";
 $ColArry[306]="Wheat3";
 $ColArry[307]="Wheat4";
 $ColArry[308]="Tan1";
 $ColArry[309]="Tan2";
 $ColArry[310]="Tan3";
 $ColArry[311]="Tan4";
 $ColArry[312]="Chocolate1";
 $ColArry[313]="Chocolate2";
 $ColArry[314]="Chocolate3";
 $ColArry[315]="Chocolate4";
 $ColArry[316]="Firebrick1";
 $ColArry[317]="Firebrick2";
 $ColArry[318]="Firebrick3";
 $ColArry[319]="Firebrick4";
 $ColArry[320]="Brown1";
 $ColArry[321]="Brown2";
 $ColArry[322]="Brown3";
 $ColArry[323]="Brown4";
 $ColArry[324]="Salmon1";
 $ColArry[325]="Salmon2";
 $ColArry[326]="Salmon3";
 $ColArry[327]="Salmon4";
 $ColArry[328]="LightSalmon1";
 $ColArry[329]="LightSalmon2";
 $ColArry[330]="LightSalmon3";
 $ColArry[331]="LightSalmon4";
 $ColArry[332]="Orange1";
 $ColArry[333]="Orange2";
 $ColArry[334]="Orange3";
 $ColArry[335]="Orange4";
 $ColArry[336]="DarkOrange1";
 $ColArry[337]="DarkOrange2";
 $ColArry[338]="DarkOrange4";
 $ColArry[339]="Coral1";
 $ColArry[340]="Coral2";
 $ColArry[341]="Coral3";
 $ColArry[342]="Coral4";
 $ColArry[343]="Tomato1";
 $ColArry[344]="Tomato2";
 $ColArry[345]="Tomato3";
 $ColArry[346]="Tomato4";
 $ColArry[347]="OrangeRed1";
 $ColArry[348]="OrangeRed3";
 $ColArry[349]="OrangeRed4";
 $ColArry[350]="Red1";
 $ColArry[351]="Red2";
 $ColArry[352]="Red3";
 $ColArry[353]="Red4";
 $ColArry[354]="DeepPink1";
 $ColArry[355]="DeepPink2";
 $ColArry[356]="DeepPink3";
 $ColArry[357]="DeepPink4";
 $ColArry[358]="HotPink1";
 $ColArry[359]="HotPink2";
 $ColArry[360]="HotPink3";
 $ColArry[361]="HotPink4";
 $ColArry[362]="Pink1";
 $ColArry[363]="Pink2";
 $ColArry[364]="Pink3";
 $ColArry[365]="Pink4";
 $ColArry[366]="LightPink1";
 $ColArry[367]="LightPink2";
 $ColArry[368]="LightPink3";
 $ColArry[369]="LightPink4";
 $ColArry[370]="PaleVioletRed1";
 $ColArry[371]="PaleVioletRed2";
 $ColArry[372]="PaleVioletRed3";
 $ColArry[373]="PaleVioletRed4";
 $ColArry[374]="Maroon1";
 $ColArry[375]="Maroon2";
 $ColArry[376]="Maroon3";
 $ColArry[377]="Maroon4";
 $ColArry[378]="VioletRed1";
 $ColArry[379]="VioletRed2";
 $ColArry[380]="VioletRed3";
 $ColArry[381]="VioletRed4";
 $ColArry[382]="Magenta1";
 $ColArry[383]="Magenta2";
 $ColArry[384]="Magenta4";
 $ColArry[385]="Orchid1";
 $ColArry[386]="Orchid2";
 $ColArry[387]="Orchid3";
 $ColArry[388]="Orchid4";
 $ColArry[389]="Plum1";
 $ColArry[390]="Plum2";
 $ColArry[391]="Plum3";
 $ColArry[392]="Plum4";
 $ColArry[393]="MediumOrchid1";
 $ColArry[394]="MediumOrchid2";
 $ColArry[395]="MediumOrchid3";
 $ColArry[396]="MediumOrchid4";
 $ColArry[397]="DarkOrchid1";
 $ColArry[398]="DarkOrchid2";
 $ColArry[399]="DarkOrchid3";
 $ColArry[400]="DarkOrchid4";
 $ColArry[401]="Purple1";
 $ColArry[402]="Purple2";
 $ColArry[403]="Purple3";
 $ColArry[404]="Purple4";
 $ColArry[405]="MediumPurple1";
 $ColArry[406]="MediumPurple2";
 $ColArry[407]="MediumPurple3";
 $ColArry[408]="MediumPurple4";
 $ColArry[409]="Thistle1";
 $ColArry[410]="Thistle2";
 $ColArry[411]="Thistle3";
 $ColArry[412]="Thistle4";
 $ColArry[413]="grey11";
 $ColArry[414]="grey21";
 $ColArry[415]="grey31";
 $ColArry[416]="grey41";
 $ColArry[417]="grey51";
 $ColArry[418]="grey61";
 $ColArry[419]="grey71";
 $ColArry[420]="gray81";
 $ColArry[421]="gray91";
 $ColArry[422]="DarkGrey";
 $ColArry[423]="DarkBlue";
 $ColArry[424]="DarkCyan";
 $ColArry[425]="DarkMagenta";
 $ColArry[426]="DarkRed";
 $ColArry[427]="LightGreen";
 $ColArry[428]="Snow";
 $ColArry[429]="GhostWhite";
 $ColArry[430]="WhiteSmoke";
 $ColArry[431]="Gainsboro";
 $ColArry[432]="FloralWhite";
 $ColArry[433]="DarkOrange";
 $ColArry[434]="OldLace";
 $ColArry[435]="Linen";
 $ColArry[436]="AntiqueWhite";
 $ColArry[437]="PapayaWhip";
 $ColArry[438]="BlanchedAlmond";
 $ColArry[439]="Bisque";
 $ColArry[440]="PeachPuff";
 $ColArry[441]="NavajoWhite";
 $ColArry[442]="Moccasin";
 $ColArry[443]="Cornsilk";
 $ColArry[444]="Ivory";
 $ColArry[445]="Seashell";
 $ColArry[446]="LemonChiffon";
 $ColArry[447]="Honeydew";
 $ColArry[448]="MintCream";
 $ColArry[449]="Azure";
 $ColArry[450]="AliceBlue";
 $ColArry[451]="lavender";
 $ColArry[452]="LavenderBlush";
 $ColArry[453]="LightCyan";
 $ColArry[454]="MistyRose";



# if(!defined($input) ||  !defined($output)  || defined($help)  )
open (IN,"<$input") || die "input  file can't open $! " ;
my %hash_sample=();
my %sample=();
my $aa_coumt=0;
   
    while(<IN>)
    {
        chomp ;
        my @inf=split ;
        $aa_coumt++;
        $sample{$aa_coumt}=$inf[0] ;
        $hash_sample{$inf[0]}++; 
    }
close IN ;

        $aa_coumt=0;
     my $samplelist=();
     my $collist=();
     my $lyt=();
    
    foreach my $k ( sort {$hash_sample{$b}<=>$hash_sample{$a} } keys %hash_sample )
    {
        $hash_sample{$k}=$ColArry[$aa_coumt];
        $samplelist.="\"$k\"\," ;
        $collist.="\"$ColArry[$aa_coumt]\"\," ;
        $lyt.="1 ,";
        #print "$k\t$ColArry[$aa_coumt]\n" ;
        $aa_coumt++;
    }

    my $final_col=();

    foreach my $k  ( sort {$a<=>$b} keys %sample )
    {
        my $col= $hash_sample{$sample{$k}} ;
           $final_col.="\"$col\"\," ;
    }
  chop $final_col ;
  chop $lyt ;
  chop $samplelist ;
  chop $collist ;
# legend("topleft",c("2008 year","2009 year"),col=c("blue","red"),cex=1,lty=c(1,1)) ;

#print  $final_col,"\n";

open (OA,">$output.R") || die "output file can't open $!" ;

sub  Print{
    print  OA<<USAGE
        library(scatterplot3d) ;
        read.table("$input")->loads ;        
        color <- c($final_col) ;

        pdf("$output\_123.pdf");
        s3d <- scatterplot3d(x=loads[,2],y=loads[,3],z=loads[,4],type="h",xlab="PCA1",ylab="PCA2",zlab="PCA3",angle=48,scale.y=2, box=FALSE ,main="3DPCA",col.axis="SteelBlue4" , col.grid="LavenderBlush2" ,color ) ;
        legend("topleft",c($samplelist),col=c($collist),lty=c($lyt),bty="n",cex=1);
        dev.off();

 pdf("$output\_124.pdf");
        s3d <- scatterplot3d(x=loads[,2],y=loads[,3],z=loads[,5],type="h",xlab="PCA1",ylab="PCA2",zlab="PCA4",angle=48,scale.y=2, box=FALSE ,main="3DPCA",col.axis="SteelBlue4" , col.grid="LavenderBlush2" ,color ) ;
        legend("topleft",c($samplelist),col=c($collist),lty=c($lyt),bty="n",cex=1);
        dev.off();

pdf("$output\_134.pdf");
        s3d <- scatterplot3d(x=loads[,2],y=loads[,4],z=loads[,5],type="h",xlab="PCA1",ylab="PCA3",zlab="PCA4",angle=48,scale.y=2, box=FALSE ,main="3DPCA",col.axis="SteelBlue4" , col.grid="LavenderBlush2" ,color ) ;
        legend("topleft",c($samplelist),col=c($collist),lty=c($lyt),bty="n",cex=1);
        dev.off();
pdf("$output\_234.pdf");
        s3d <- scatterplot3d(x=loads[,3],y=loads[,4],z=loads[,5],type="h",xlab="PCA2",ylab="PCA3",zlab="PCA4",angle=48,scale.y=2, box=FALSE ,main="3DPCA",col.axis="SteelBlue4" , col.grid="LavenderBlush2" ,color ) ;
        legend("topleft",c($samplelist),col=c($collist),lty=c($lyt),bty="n",cex=1);
        dev.off();
        quit();
USAGE
        }
        
   Print();
   close  OA ;
   my $R_bin="/opt/blc/genome/bin/R" ;
      $R_bin="/public2/BGI/Software/Rscript/R-3.6.3/bin/R" unless (-e $R_bin );
      $R_bin="/share/raid1/genome/bin/R" unless (-e $R_bin );
      $R_bin="/opt/blc/genome/biosoft/R/bin/R" unless (-e $R_bin );

      system ("$R_bin  CMD BATCH $output.R  ");
      my @ccc=split /\// ,$output ;
      my $outDir=join("/",@ccc[0..$#ccc-1]);
      system ("rm -f  $outDir/.R* ") ; 
      system ("rm -f  $output.R  ") ; 
      print "love hewm\@genomics.org.cn\t3DPCA\tdone\n" ;


#############swimming in the sky and flying in the sea #########








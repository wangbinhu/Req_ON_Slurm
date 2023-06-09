#!/usr/bin/perl -w
use strict;
use FindBin qw($Bin);

#explanation:this program is edited to 
#edit by hewm;   Thu Nov  3 13:47:17 CST 2016
#Version 1.0    hewm@genomics.org.cn 

die "Version 1.0\t2016-11-03;\nUsage: $0 <VCF.list><individual.txt><MaxK>\n" unless (@ARGV ==2 ||  @ARGV ==3);

#############Befor  Start  , open the files ####################
my $MaxK=12;
if (defined ($ARGV[2]) )
{
	$MaxK=$ARGV[2] ;
}

my $MaxRep=1;


my $PWD=`pwd`; chomp $PWD;

if  (!($ARGV[0]=~/^\//)) {$ARGV[0]="$PWD/$ARGV[0]";}
if  (!($ARGV[1]=~/^\//)) {$ARGV[1]="$PWD/$ARGV[1]";}



################ Do what you want to do #######################
my $OUT=`pwd`;
chomp $OUT;
my $OUTDir="$OUT/Admix";
my $OUTDirCal="$OUTDir/Pre";
my $OUTDirLog="$OUTDir/Log";
my $OUTDirFig="$OUTDir/Fig";
my $OUTDirshell="$OUTDir/shell";
system (" mkdir -p $OUTDir  $OUTDirFig $OUTDirCal   $OUTDirshell     $OUTDirLog ");

chdir $OUTDirshell ;
system ( "perl  $Bin/osh.pl   01 01 s1_pre   perl   $Bin/PreVCFAdmix.pl     -InList   $ARGV[0]    -OutPut   $OUTDirCal/SNP.vcf ^   $Bin/plink/plink2       --vcf   $OUTDirCal/SNP.vcf  -out      $OUTDirCal/plink   --allow-extra-chr    --make-bed   " );

srand(time|$$);
foreach my $kk  (2..$MaxK)
{
	foreach my $tt (1..$MaxRep)
	{
		my $rand=int(rand(1000000));
		system ( "perl  $Bin/osh.pl   01 01 s2_$kk\_$tt   $Bin/admixture/admixture   --cv=10  -s  $rand    $OUTDirCal/plink.bed   $kk  \\\>  $OUTDirLog/Log$kk\_$tt ");
	}
}

system ("  perl  $Bin/osh.pl   01 01 s3_Stat   grep   CV   $OUTDirLog/Log\\\*   \\\>   $OUTDirFig/CV.data   ^   perl    $Bin/GetResult.pl   $OUTDirFig/CV.data   $OUTDirshell   $ARGV[1]   $OUTDirFig/Result  ^   rm -rf   $OUTDirCal/\\\*  ");


chdir $OUT ;


######################swimming in the sky and flying in the sea ###########################

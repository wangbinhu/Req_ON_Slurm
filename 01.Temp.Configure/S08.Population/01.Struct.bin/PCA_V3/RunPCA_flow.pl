#!/usr/bin/perl -w
use strict;
use FindBin qw($Bin);

#explanation:this program is edited to 
#edit by hewm;   Thu Nov  3 13:47:17 CST 2016
#Version 1.0    hewm@genomics.org.cn 

die "Version 1.0\t2016-11-03;\nUsage: $0 <VCF.list><individual.txt>\n" unless (@ARGV ==2);

#############Befor  Start  , open the files ####################

my $OUT=`pwd`; chomp $OUT;
if  (!($ARGV[0]=~/^\//)) {$ARGV[0]="$OUT/$ARGV[0]";}
if  (!($ARGV[1]=~/^\//)) {$ARGV[1]="$OUT/$ARGV[1]";}


open (IB,"$ARGV[1]") || die "input file can't open $!";

my %hash=();

while(<IB>)
{
	chomp ;
	my @inf=split ;
	$hash{$inf[-1]}++;
}
close IB;

my $Population=();

foreach my $k ( sort keys %hash)
{
	$Population.=$k.":";
}
$/=":" ; chomp $Population ;  $/="\n" ;



################ Do what you want to do #######################
my $OUTDir="$OUT/PCA3";
my $OUTDirCal="$OUTDir/Cal";
my $OUTDirFig="$OUTDir/Fig";
my $OUTDirshell="$OUTDir/shell";
system (" mkdir -p $OUTDir  $OUTDirFig $OUTDirCal   $OUTDirshell ");


chdir $OUTDirshell ;
system ( "perl  $Bin/osh.pl   01 01 s1_Cal   perl   $Bin/PreVCFPCA.pl    -InList   $ARGV[0]    -OutPut   $OUTDirCal/SNP.vcf ^   $Bin/plink/plink2       --vcf   $OUTDirCal/SNP.vcf  -out      $OUTDirCal/plink   --allow-extra-chr       --make-bed     ^   $Bin/gcta/gcta64   --bfile  $OUTDirCal/plink   --make-grm    --out   $OUTDirFig/01.PCA   ^  $Bin/gcta/gcta64   --grm     $OUTDirFig/01.PCA     --pca 4       --out   $OUTDirFig/02.PCA.Result     ^  perl  $Bin/DealResult.pl     $OUTDirFig/02.PCA.Result.eigenvec  $ARGV[1]    $OUTDirFig/Data  ^     perl   $Bin/ploteig.pl  -i    $OUTDirFig/Data    -c   1:2  -o $OUTDirFig/PCA1_2.out  -p  $Population  -x   -s  $OUTDirFig/PCA1_2     -y   outside    -b 3   ^   perl   $Bin/ploteig.pl  -i    $OUTDirFig/Data    -c   1:3  -o $OUTDirFig/PCA1_3.out  -p  $Population  -x   -s  $OUTDirFig/PCA1_3     -y   outside    -b 3   ^   perl   $Bin/ploteig.pl  -i    $OUTDirFig/Data    -c   2:3  -o $OUTDirFig/PCA2_3.out  -p  $Population  -x   -s  $OUTDirFig/PCA2_3     -y   outside    -b 3   ^  perl $Bin/new_3DPCA.pl    -input   $OUTDirFig/Data   -output  $OUTDirFig/PCA3D    ^  rm -rf  $OUTDirCal/\\\*  " );

chdir $OUT ;


######################swimming in the sky and flying in the sea ###########################

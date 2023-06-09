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

my $MaxK=7;

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
my $OUTDir="$OUT/Frappe2";
my $OUTDirCal="$OUTDir/Pre";
my $OUTDirFra="$OUTDir/Cal";
my $OUTDirFig="$OUTDir/Fig";
my $OUTDirshell="$OUTDir/shell";
system (" mkdir -p $OUTDir  $OUTDirFig $OUTDirCal   $OUTDirshell $OUTDirFra ");


chdir $OUTDirshell ;
system ( "perl  $Bin/osh.pl   01 01 s1_Pre   perl   $Bin/PreVCFFrappe.pl    -InList   $ARGV[0]    -OutPut   $OUTDirCal/SNP   \\\>  $OUTDirFra/SNP.log "  ) ;


foreach my $kk  (2..$MaxK)
{
	system ( "perl  $Bin/osh.pl   01 01 s2_$kk  ^  cd $OUTDirFra   ^ ln -sf    $OUTDirCal/SNP.ped  $OUTDirFra/plink_$kk.ped  ^  perl  $Bin/ReadLog2.pl  $OUTDirFra/SNP.log   $OUTDirFra/$kk.txt  $kk  $OUTDirFra/plink_$kk.ped   ^    $Bin/frappe_linux64 $OUTDirFra/$kk.txt   ");
}


system( " perl  $Bin/osh.pl   01  01  s3_Stat ls $OUTDirFra/plink_\\\*_result.txt \\\>  $OUTDirFra/out.list  ^   perl $Bin/structure_arrange.pl   $ARGV[1]    $OUTDirFra/out.list   $OUTDirFig/result.final ^  perl  $Bin/sortSampleArry.pl   $OUTDirFig/result.final   3   \\\>  $OUTDirFig/result.final.sort   ^  rm   $OUTDirFra/out.list  ^  rm -rf $OUTDirCal/\\\*  ");




chdir $OUT ;


######################swimming in the sky and flying in the sea ###########################

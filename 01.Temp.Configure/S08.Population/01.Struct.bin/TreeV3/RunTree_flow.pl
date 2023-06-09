#!/usr/bin/perl -w
use strict;
use FindBin qw($Bin);

#explanation:this program is edited to 
#edit by hewm;   Thu Nov  3 13:47:17 CST 2016
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2016-11-03;\nUsage: $0 <VCF.list>\n" unless (@ARGV ==1);

#############Befor  Start  , open the files ####################

open (IA,"$ARGV[0]") || die "input file can't open $!";

#open (OA,">$ARGV[1]") || die "output file can't open $!" ;

################ Do what you want to do #######################
my $OUT=`pwd`;
chomp $OUT;
my $OUTDir="$OUT/TreeV3";
my $OUTDirChr="$OUTDir/chr";
my $OUTDirshell="$OUTDir/shell";

system (" mkdir -p $OUTDir  $OUTDirChr   $OUTDirshell ");

# system  ( "cp $ARGV[1]  $OUTDir/individual.txt  ");


while(<IA>)
{ 
	chomp ; 
	my @inf=split /\//;
	my @DD=split /\./,$inf[-1];

	chdir $OUTDirshell ;
	system ("perl  $Bin/osh.pl   01 01 s1_$DD[0] $Bin/VCF2Dis/bin/VCF2Dis   -InPut    $_  -OutPut   $OUTDirChr/$DD[0]  -KeepMF   " );
}
close IA;

system ("perl  $Bin/osh.pl   01 01 s2 ls  $OUTDirChr/\\\*.Diff \\\>   $OUTDirChr/Diff.list  ^    ls  $OUTDirChr/\\\*.Use \\\>   $OUTDirChr/Use.list  ^  perl   $Bin/GetALLChrDiff_step2.pl    $OUTDirChr/Diff.list   $OUTDirChr/Use.list    $OUTDir/individual.datamatrix   ^  $Bin/fneighbor       -datafile       $OUTDir/individual.datamatrix   -outfile        $OUTDir/tree.out1.txt   -matrixtype     s   -treetype       n       -outtreefile    $OUTDir/tree.out2.tre        ") ;

#close OA ;
chdir $OUT ;


######################swimming in the sky and flying in the sea ###########################

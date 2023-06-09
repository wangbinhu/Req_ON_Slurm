#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to 
#edit by hewm;   Wed Apr  1 13:46:54 CST 2020
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2020-04-01;\nUsage: $0 <PCA.eigenvec><individual.txt><Out>\n" unless (@ARGV ==3);

#############Befor  Start  , open the files ####################

my $WC_A=`wc  -l $ARGV[0]`; chomp $WC_A;
my $WC_B=`wc  -l $ARGV[1]`; chomp $WC_B;
my @AA=split /\s+/,$WC_A;
my @BB=split /\s+/,$WC_B;

if ($AA[0] !=$BB[0])
{
	print "sample Number diff  $AA[0]  with  $BB[0] \n";
}

open (IA,"$ARGV[0]") || die "input file can't open $!";
open (IB,"$ARGV[1]") || die "input file can't open $!";
open (OA,">$ARGV[2]") || die "output file can't open $!" ;

################ Do what you want to do #######################

	while(<IA>) 
	{ 
		chomp ; 
		my @infA=split ;
		$_=<IB>; chomp ;
		my @infB=split ;
		print OA $infB[-1],"\t$infA[-4]\t$infA[-3]\t$infA[-2]\t$infA[-1]\t$infB[-1]\n";
	}
close IA;
close IB;
close OA ;

######################swimming in the sky and flying in the sea ###########################

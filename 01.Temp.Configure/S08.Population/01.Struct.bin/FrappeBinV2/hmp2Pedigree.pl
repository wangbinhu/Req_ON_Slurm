#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to 
#edit by hewm;   Fri Jan  3 11:25:43 CST 2020
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2020-01-03;\nUsage: $0 <InPut><Out.map><out.ped>\n" unless (@ARGV ==3);

#############Befor  Start  , open the files ####################

open (IA,"$ARGV[0]") || die "input file can't open $!";
open (OA,">$ARGV[1]") || die "output file can't open $!" ;
open (OB,">$ARGV[2]") || die "output file can't open $!" ;


################ Do what you want to do #######################
$_=<IA>;  chomp ;
my @head=split ;
my @ped=();
my $Count=0;

my %base2Num=();
$base2Num{'A'}=1;
$base2Num{'C'}=2;
$base2Num{'G'}=3;
$base2Num{'T'}=4;
$base2Num{'-'}=0;
$base2Num{'N'}=0;


while(<IA>) 
{
	chomp ;
	my @inf=split ;
	my $ccc=($inf[1]=~s/\//\//g)+0;
	next if ($ccc>1);
	my @rrrr=split /\./,$inf[0];
	print OA  "1\t$rrrr[-1]\t0\t$inf[3]\n";

	for( my $key=11 ; $key<=$#inf; $key++ )
	{
		my @UU=split //,$inf[$key];
		$ped[$key][$Count]=$base2Num{$UU[0]}." ".$base2Num{$UU[1]};
	}

	$Count++;
}

$Count--;

foreach my $k (11..$#head)
{
	my $key=$k-10;
	print  OB  "$key\t$key\t0\t0\t0\t0";
	for (my $TT=0 ; $TT<=$Count ;$TT++ )
	{
		print OB "\t$ped[$k][$TT]";
	}
	print OB "\n";
}

close IA;
close OA ;
close OB ;

######################swimming in the sky and flying in the sea ###########################

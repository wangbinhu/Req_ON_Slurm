#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to 
#edit by hewm;   Tue Feb 18 11:19:29 HKT 2014
#Version 1.0    hewm@genomics.org.cn 
use SVG;

die  "Version 1.0\t2014-02-18;\nUsage: $0 <Frappe_result.final><Col.cofi>\n" unless (@ARGV ==1 || @ARGV ==2);
#############Befor  Start  , open the files ####################

open (IA,"$ARGV[0]") || die "input file can't open $!";

#open (OA,">$ARGV[1]") || die "output file can't open $!" ;

my %hash=() ;

if  ( defined  $ARGV[1])
{
	open (IB,"$ARGV[1]") || die "input file can't open $!";
	while(<IB>) 
	{ 
		chomp ; 
		my @inf=split ;
		$hash{$inf[0]}=$inf[1];
	}
	close IB;
}

my $AA=`wc  -l  $ARGV[0] ` ;
my @CC=split /\s+/,$AA ;

################ Do what you want to do #######################

my ($u, $d, $l, $r) = (120, 100, 150, 100);
my $bin= 10 ;
my $width= $l+$bin*$CC[0]+$r;
my $height=2*$bin+$u+$d;
my $svg = SVG->new('width',$width,'height',$height);
#34     K=2     K_E_34  0.514986        0.485014        K=3     K_E_34  0.0278249       0.410605        0.56157 K=

my $Count=0;

	while(<IA>)
	{
		chomp ;
		my @inf=split ;
		my @cc=split /\_/,$inf[2];
		my $X1=$l+$Count*$bin;
		my $Y1=$u ;
		my $Cou=$hash{$cc[0]};
    	   $svg->rect('x',$X1,'y',$Y1,'width',$bin,'height',$bin,'fill',$Cou);
		    $Count++;
		#        $svg->rect('x',$yx,'y',$ylog-$rectH,'width',$rectH+$rectH/2,'height',$rectH,'fill',$c);
		#
	}
close IA;

#close OA ;
print $svg->xmlify();

######################swimming in the sky and flying in the sea ###########################

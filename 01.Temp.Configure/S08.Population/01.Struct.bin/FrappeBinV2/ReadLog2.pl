#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to 
#edit by HeWeiMing;   Fri Feb 11 19:21:31 CST 2011
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2011-02-11;\nUsage: $0 <log><Out><K><txt>\n" unless (@ARGV ==4);

#############Befor  Start  , open the files ####################

open (IA,"$ARGV[0]") || die "input file can't open $!";
open (OA,">$ARGV[1]") || die "output file can't open $!" ;

################ Do what you want to do #######################
my $sites= 0 ;
my $SampleNumber=0;
while(<IA>) 
{ 
    chomp ; 
    if (/Total SNP Number is (\d+)/ )	
    {
        $sites = $1;
    }
	elsif (/Total Samples Number is (\d+)/)
	{
		$SampleNumber = $1;
	}
}
close IA;

print OA "MaxIter\t=\t10000\nK\t=\t$ARGV[2]\nM\t=\t$sites\nI\t=\t$SampleNumber\nNout\t=\t10\nstep\t=\t1\n";
print OA "GenotypeFile\t=\t\"$ARGV[3]\"\n";
print OA "IndividualFile\t=\t\"NONE\"\n";
close OA ;

######################swimming in the sky and flying in the sea ###########################

#!/usr/bin/perl -w
use strict;

#Version 1.0    hewm@genomics.org.cn
#used for frappe flow	hewm@genomics.org.cn
#first, read all the SNPs files which contain reference genotype and delimited by tab, but the genotype of samples
#was delimited by space. Then make changes.
#example
#chr2    573     C T T T T C T C T - T T T - T C - T - - - - - - C T T T T T Y Y C T T - C - C - -
die"Version 1.0\t2009-09-14;\nUsage: $0 <addref.list><Sample_Num><out>\n" unless (@ARGV ==2);
open (LIST, "<$ARGV[0]") or die "$!\n";
open (OUT, ">$ARGV[1]") or die "$!\n";
my %iupac = (
    "M" => "AC",
    "R" => "AG",
    "W" => "AT",
    "Y" => "CT",
    "S" => "CG",
    "K" => "GT",
    "-" => "--",
    "A" => "AA",
    "T" => "TT",
    "G" => "GG",
    "C" => "CC",
    "N" => "NN",
);

while (<LIST>){
    chomp;
    my $file = $_;
    open (IN,$file) || die $!;
	<IN>;
    while (<IN>) {
        chomp;
		<IN>; <IN>; <IN>;<IN>;<IN>;
		<IN>; <IN>; <IN>;<IN>;<IN>;
        my @temp = split(/\s+/);
        my @trans = map {$iupac{$_}} @temp;
        my $line=join("\t",@trans[2..$#trans]);
        print OUT "$temp[0]\t$temp[1]\t$line\n";
    }
    close IN;
}
close LIST;
close OUT;

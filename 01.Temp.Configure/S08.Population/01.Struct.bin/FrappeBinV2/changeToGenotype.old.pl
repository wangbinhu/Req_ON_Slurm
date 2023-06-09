#!/usr/bin/perl -w
#used for frappe flow	hewm@genomics.org.cn
#first, read all the SNPs files which contain reference genotype and delimited by tab, but the genotype of samples
#was delimited by space. Then make changes.

#example
#chr2    573     C T T T T C T C T - T T T - T C - T - - - - - - C T T T T T Y Y C T T - C - C - -
#chr2    575     C T C C C - C C C T - C C - Y C - C - - - T - T C Y - C C C C C C C C - C - C - -
#chr2    592     A G R R R - G A A G R G A G G A - G - - G G - G A G G A R G A A A A A - A - A G G
die "perl $0 <SNPs file list> <individual numbers> <out put>\n" unless (@ARGV==3);

use strict;

open (LIST, $ARGV[0]) or die "$!\n";
open (OT, ">$ARGV[2]") or die "$!\n";
while (<LIST>){
	chomp;
	my $file = $_;
	open (IN,$file) || die $!;
	while (<IN>) {
		chomp;
		my @temp = split(/\s+/);
		my $ref = iupac2dinucleotide($temp[2]);
		my $line = "$temp[0]\t$temp[1]\t$ref\t";
		my @genotype = ();
		foreach my $i(1 .. $ARGV[1]) {
			if($temp[$i+2] =~/-/) {
				$genotype[$i-1] = "--";
			} else {
				$genotype[$i-1] = iupac2dinucleotide($temp[$i+2]);
			}
		}
		print OT $line, join("\t",@genotype),"\n";
	}
	close IN;
}
close LIST;
close OT;

sub iupac2dinucleotide {
	my $iupac = shift;
	my $result = $iupac . $iupac;
	if ($iupac =~/M/) {
		$result = "AC";
	} elsif ($iupac =~/K/) {
		$result = "GT";
	} elsif ($iupac =~/Y/) {
		$result = "CT";
	} elsif ($iupac =~/R/) {
		$result = "AG";
	} elsif ($iupac =~/W/) {
		$result = "AT";
	} elsif ($iupac =~/S/) {
		$result = "CG";
	}
	return($result);
}

#!/usr/bin/perl -w
#====================================================================#
#	Modified for frappe flow, which does not take the relationship between samples into consideration.
#	Modified Date: 2009-08-12
#====================================================================#

die "$0:  <chrAll.genotype> <output Dir> <out map file> <number of samples>  > ped.out\n" unless (@ARGV == 4);

open (IN, $ARGV[0]) or die "$!\n";
open (MP, ">$ARGV[2]") or die "$!\n";

my @ind = (); #store the genotype of each individual, two dim array
my $snpNum = 0;
my $dir = $ARGV[1];
my @file = ();
my $pid = 1;
foreach my $i(1..$ARGV[3]) {
	$file[$i] = "$dir/sample$i.ped";
	my $fh = "PD$i";
	open $fh, ">$file[$i]" or die "$!\n";
	my $head = "$pid\t$pid\t0\t0\t0\t0\t";
	print $fh $head;
	$pid ++;
}

my $order = 0;
while (<IN>) {
	chomp;
	my %hash = ();
	my @temp = split(/\t/);
	foreach my $i(2 .. $#temp) {
		next if($temp[$i]=~/--/);
		next if($temp[$i]=~/NN/);
		my @s = split(//,$temp[$i]);
		if(!exists $hash{$s[0]}) {
			$hash{$s[0]}=1;
		} else {
			$hash{$s[0]}++;
		}
		if(!exists $hash{$s[1]}) {
			$hash{$s[1]}=1;
		} else {
			$hash{$s[1]}++;
		}
	}
	my $N = scalar (keys %hash);
	next if($N != 2); # discard the SNP sites that having more than two alleles
	my $map = "1\t$order\t0\t$temp[1]";
	print MP $map,"\n";
	$order++;
	my ($t, $OT);
	foreach my $i(1 .. $ARGV[3]) {
		$OT = "PD$i";
		if( ($temp[$i+2]=~/--/) || ($temp[$i+2]=~/NN/) ) {
			print $OT "0 0\t";
			next;
		} # end if
		my @s = split(//,$temp[$i+2]);
		my $geno = join(" ",@s);
		$geno =~tr/ACGT/1234/;
		print $OT "$geno\t";
	} #end foreach
}
close IN;
close MP;
foreach my $i(1 .. $ARGV[3]) {
	my $fh = "PD$i";
	close $fh;
	open $fh,"$dir/sample$i.ped";
	while(<$fh>) {
		chomp;
		print $_,"\n";
	}
	close $fh;
    unlink "$dir/sample$i.ped" ;
}

 unlink  $ARGV[0] ;

###################### swimming in the sky and flying in the sea ####################

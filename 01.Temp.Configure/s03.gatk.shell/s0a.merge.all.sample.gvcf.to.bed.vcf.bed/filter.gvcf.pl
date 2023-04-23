#!/usr/bin/perl -w
use strict;
use v5.10;


open IN, "gzip -dc $ARGV[0] |";
open OU, ">$ARGV[1]";

my %hash;
while (<IN>) {
    chomp;
    if ( $_ =~ /^#/) {say OU "$_"; next};
    my ($CHROM, $POS, $REF, $ALT) = (split /\s+/, $_, 7)[0, 1, 3, 4];

	next if(exists $hash{$CHROM}{$POS});
	$hash{$CHROM}{$POS}=1;

    my $REF_N = scalar (split /,/, $REF);
    my $ALT_N = scalar (split /,/, $ALT);


    if ( ($REF_N == 1) &&  ($ALT_N >= 2)){
        say OU "$_";

    }
}

close IN;
close OU;

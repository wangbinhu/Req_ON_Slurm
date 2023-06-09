use strict;
use v5.10;

say "User manual: perl keep.chrom.pl SNP.ID.vcf SNP.ID.CHROM.v2.vcf 24 ";

if ($ARGV[0]=~/.gz$/){
    open IN, "gzip -dc $ARGV[0] |";
}
else {
    open IN, "$ARGV[0]";
}

open OU, ">$ARGV[1]", or die "cannot open file $! \n" ;
while (<IN>){
    chomp;
    if ($_=~/^#/){say OU $_;next} 
    my $CHROM = (split /\s+|:/, $_)[0];

    if ($CHROM <= $ARGV[2]) {
        say OU $_;
    }
}
close IN;
close OU;

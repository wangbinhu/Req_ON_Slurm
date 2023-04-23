use strict;
use v5.10;

open IN, "gzip -dc $ARGV[0] |";
open OU, ">$ARGV[1]", or die "cannot open file $! \n" ;

say OU "CHROM\tPOS\tAF\tPIC";
while (<IN>){
      chomp;
      next if ($_=~/#/);
      my ($CHROM, $POS, $ALT, $INFO) = (split /\s+/, $_, 9)[0, 1, 4, 7];
      next if ($ALT=~/,/);
      my ($AC, $AN) = (split /;|=/, $INFO, 7)[1, 5];
      next if ($AN == 0);
      my $AF = $AC/$AN;
      my $PIC_p = (1 - ( $AF**2 + (1-$AF)**2 ));
      my $PIC = sprintf "%.4f", $PIC_p;
      say OU "$CHROM\t$POS\t$AF\t$PIC";
}
close IN;
close OU;

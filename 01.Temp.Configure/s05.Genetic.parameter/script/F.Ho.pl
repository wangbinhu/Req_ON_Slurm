use strict;
use v5.10;

open IN, "$ARGV[0]", or die "cannot open file $! \n" ;
open OU, ">$ARGV[1]", or die "cannot open file $! \n" ;

say OU "INDV\tO_HOM\tN_SITES\tF\tHo";
while (<IN>){
      chomp;
      next if ($_=~/INDV/);
      my ($INDV, $O_HOM, $N_SITES, $F) = (split/\s+/)[0, 1, 3, 4];
      my $Ho = 1-($O_HOM)/($N_SITES);

      say OU "$INDV\t$O_HOM\t$N_SITES\t$F\t$Ho";
} 
close IN;
close OU;

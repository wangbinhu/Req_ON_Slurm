use strict;
use v5.10;

open IN, "$ARGV[0]", or die "cannot open file $! \n" ;
open OU, ">$ARGV[1]", or die "cannot open file $! \n" ;

say OU "Breed\tAF_ave\tPIC_ave";

my $AF_sum=0;
my $PIC_sum=0;
my $counts=0;

while (<IN>){
      chomp;
      next if ($_=~/CHROM/);
      my ($CHROM, $POS, $AF, $PIC) = (split /\s+/, $_, 9)[0, 1, 2, 3];
      $AF_sum += $AF;
      $PIC_sum += $PIC;
      $counts+=1;
} 
      my $AF_ave = $AF_sum/$counts;
      my $PIC_ave = $PIC_sum/$counts;
      my $AF_ave=sprintf "%.4f",$AF_ave;
      my $PIC_ave=sprintf "%.4f",$PIC_ave;
      say "$ARGV[1]\t$AF_ave\t$PIC_ave";	      
      say OU "$ARGV[1]\t$AF_ave\t$PIC_ave";

close IN;
close OU;

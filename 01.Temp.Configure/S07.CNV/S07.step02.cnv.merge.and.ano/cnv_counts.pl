use strict;
use v5.10;

open IN, "gzip -dc $ARGV[0] |";
my $Sample = (split(/\./,$ARGV[0],2))[0];
open OU, ">$Sample.stat";

my $DEL_num = 0;
my $DUP_num = 0;


while (<IN>){
      chomp;
      if ($_=~/#/) {next};
      my $CNVTYPE=(split(/=|;/,$_,6))[3];
      say "$CNVTYPE";
      if ($CNVTYPE eq "DEL") {
        $DEL_num+=1;
      }
      if ($CNVTYPE eq "DUP") {
        $DUP_num+=1;
      }

}
my $ALL_CNV = $DEL_num + $DUP_num;
my $DEL_num_P =   sprintf ("%.2f%%", $DEL_num/$ALL_CNV*100);
my $DUP_num_P =   sprintf ("%.2f%%", $DUP_num/$ALL_CNV*100);


say OU "Sample\tALL_CNV\tDEL\tDUP";
say OU "$Sample\t$ALL_CNV\t$DEL_num($DEL_num_P)\t$DUP_num($DUP_num_P)";
close IN;
close OU;


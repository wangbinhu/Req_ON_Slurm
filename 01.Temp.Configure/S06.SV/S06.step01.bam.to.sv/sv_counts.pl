use strict;
use v5.10;

open IN, "gzip -dc $ARGV[0] |";
my $Sample = (split(/\./,$ARGV[0],2))[0];
open OU, ">$Sample.stat";

my $DEL_num = 0;
my $DUP_num = 0;
my $INS_num = 0;
my $INV_num = 0;
my $BND_num = 0;

while (<IN>){
      chomp;
      if ($_=~/#/) {next};
      my $SVTYPE=(split(/=|;/,$_,6))[2];
    #   say "$SVTYPE";
      if ($SVTYPE eq "DEL") {
        $DEL_num+=1;
      }
      if ($SVTYPE eq "DUP") {
        $DUP_num+=1;
      }
      if ($SVTYPE eq "INS") {
        $INS_num+=1;
      }
      if ($SVTYPE eq "INV") {
        $INV_num+=1;
      }      
      if ($SVTYPE eq "BND") {
        $BND_num+=1;
      }
}
my $ALL_SV = $DEL_num + $DUP_num + $INS_num + $INV_num + $BND_num;
my $DEL_num_P =   sprintf ("%.2f%%", $DEL_num/$ALL_SV*100);
my $DUP_num_P =   sprintf ("%.2f%%", $DUP_num/$ALL_SV*100);
my $INS_num_P =   sprintf ("%.2f%%", $INS_num/$ALL_SV*100);
my $INV_num_P =   sprintf ("%.2f%%", $INV_num/$ALL_SV*100);
my $BND_num_P =   sprintf ("%.2f%%", $BND_num/$ALL_SV*100);

say OU "Sample\tALL_SV\tDEL\tDUP\tINS\tINV\tBND";
say OU "$Sample\t$ALL_SV\t$DEL_num($DEL_num_P)\t$DUP_num($DUP_num_P)\t$INS_num($INS_num_P)\t$INV_num($INV_num_P)\t$BND_num($BND_num_P)";
close IN;
close OU;

#/public/home/bgiadmin/Software/10.User-defined/WBH/miniconda3/bin/perl -w
use strict;
use v5.10;


die  "Version 1.0\t2010-09-27;\nUsage: $0 <ID.list><plink.out.list><Out>\n"unless(@ARGV ==3);


    my %Pvalue=();

        open (Flist , "$ARGV[1]") || die "$!" ;
        open (List ,  "$ARGV[0]") || die "$!";
        open (OUT ,    ">$ARGV[2]") || die "$!";

    my %Sample=();
        while(<List>)
        {
            chomp ;
            my @inf=split ;
            $Sample{$inf[0]}=$inf[1];   
            # say "$inf[0] ===> $inf[1]"  Y9 ===> AnHui_Y9

        }
    close  List ;

    while ( (my $key , my $value) = each %Sample){
        print "$key: $value"
    }


    while ($_=<Flist>)
    {
         chomp ;
         my $file=$_ ;
         open (Fi ,"$file") || die "$!" ;
         my $K=$1 if ($file =~/plink_(\S+)_result.txt/);
         while ($_=<Fi>)
         {
             chomp ;
             my @inf=split /\:/ ;
             my $ID=(split(/\s+|A|B/,$inf[0]))[0];
            say "$ID";
            say "$Sample{$ID}";
             my @temp=split(/\s+/,$inf[-1]);
             my $line=join("\t",@temp[0..$#temp]);
             my $KP="K=$K\t$Sample{$ID}$line\t";
             $Pvalue{$ID}.=$KP;
         }
        close Fi ;
    }
    close Flist ;

   foreach  my $k (sort {$a<=>$b} keys %Pvalue)
    {
        print OUT $k,"\t$Pvalue{$k}\n";
    }
close OUT ;

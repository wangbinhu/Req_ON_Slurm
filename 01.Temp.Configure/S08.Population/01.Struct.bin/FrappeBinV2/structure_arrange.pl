#!/usr/bin/perl-w
use strict;
#explanation:this program is edited to
#edit by HeWeiMing;   Mon Sep 27 16:52:22 CST 2010
#Version 1.0    hewm@genomics.org.cn

die  "Version 1.0\t2010-09-27;\nUsage: $0 <ID.list><plink.out.list><Out>\n"unless(@ARGV ==3);

#############Befor  Start  , open the files ####################
my %Pvalue=();

    my $filelist= $ARGV[1] ;
    open (Flist , "$filelist") || die "$!" ;
    open (List , "$ARGV[0]") || die "$!";
    open (OUT , ">$ARGV[2]") || die "$!";

    my %Sample=();
    while(<List>)
    {
        chomp ;
        my @inf=split ;
        $Sample{$inf[0]}=$inf[1];
    }
close  List ;


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
             my $ID=(split(/\s+/,$inf[0]))[0];
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

######################swimming in the sky and flying in the sea ###########################

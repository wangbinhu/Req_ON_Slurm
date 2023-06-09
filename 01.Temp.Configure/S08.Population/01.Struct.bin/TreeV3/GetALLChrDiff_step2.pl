#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to 
#edit by hewm;   Thu Nov  3 12:55:46 CST 2016
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2016-11-03;\nUsage: $0 <Diff.list><Use.list><Out.mat>\n" unless (@ARGV ==3);

#############Befor  Start  , open the files ####################

open (OA,">$ARGV[2]") || die "output file can't open $!";

################ Do what you want to do #######################

my $filelist= $ARGV[0] ;
my %Diff_Total=();
my %SampleName=();

    open (Flist , "<$filelist") || die "$!" ;
    while ($_=<Flist>)
    {
        chomp ;
        my $file=$_ ;
        open (Fi ,"$file") || die "$!" ;
		<Fi>;
		my $Flag=1;
        while ($_=<Fi>)
        {
            chomp ;
            my @inf=split ;
			foreach my $j (1..$#inf)
			{
				$Diff_Total{$Flag}{$j}+=$inf[$j];
			}
			if (!exists $SampleName{$Flag})
			{
				 $SampleName{$Flag}=$inf[0];
			}
			else
			{
				if  ($inf[0] ne $SampleName{$Flag} )
				{
					print "some thing wrong in sample $inf[0] with  $SampleName{$Flag} \n";
				}
			}
			$Flag++;
        }
        close Fi;
    }
    close Flist ;


$filelist= $ARGV[1] ;
my %Use_Total=();
    open (FFF , "<$filelist") || die "$!" ;
    while ($_=<FFF>)
    {
        chomp ;
        my $file=$_ ;
        open (Fi ,"$file") || die "$!" ;
		my $Flag=1;
		<Fi>;
        while ($_=<Fi>)
        {
            chomp ;
            my @inf=split ;
			foreach my $j (1..$#inf)
			{
				$Use_Total{$Flag}{$j}+=$inf[$j];
			}
			if (!exists $SampleName{$Flag})
			{
				 $SampleName{$Flag}=$inf[0];
			}
			else
			{
				if  ($inf[0] ne $SampleName{$Flag})
				{
					print "same thing wrong in sample $inf[0] with  $SampleName{$Flag} \n";
				}
			}
			$Flag++;
        }
        close Fi;
    }
    close FFF ;


######################swimming in the sky and flying in the sea ###########################

my @BB=keys %SampleName;
my $sample_num= $#BB+1 ;

printf OA "%5s\n",$sample_num;
foreach my $k (1..$sample_num)
{
	printf OA "%-12s",$SampleName{$k};
	foreach my $ke (1..$sample_num) 
	{
		if($ke eq $k){printf OA "\t%-12f", 0;next;}
		my $dsum=$Diff_Total{$k}{$ke}; 
		my $lsum=$Use_Total{$k}{$ke};
		my $p_between= 0 ;
		( $p_between=$dsum*1.0/$lsum ) if  ($lsum!=0);
		printf OA "\t%-12f", "$p_between";
	}


	printf OA "\n";
}

close OA ;

######################swimming in the sky and flying in the sea ###########################


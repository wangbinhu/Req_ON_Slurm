#!/usr/bin/perl -w
use FindBin qw($Bin) ;
use strict;
# edit by heweiming  2009-10-14
die "perl $0 <snpfilelist> <number of samples> <change genotype outfile> <outdir> <map outfile> <max K> <control><list>\n" unless (@ARGV==7 ||  @ARGV==8 );

my $snpfilelist = shift;
my $numer_of_samples = shift;
my $change_genotype_out = shift;
my $outputdir = shift;
my $mapoutfile = shift ;     $outputdir =~ s/\/$//g;
my $maxK = shift;
my $control = shift;
my $sample_list=();
if(@ARGV==1 &&  $control == 3 )  { $sample_list= shift;}

my $plink = "$outputdir/plink-1.07-x86_64";
my $frappe = "$outputdir/frappe_linux";
my $printfirst='#!/bin/sh'."\n".'#$ -S /bin/sh'."\n";
my $printStar="echo Start Time : \ndate\n";
my $printEnd="echo End Time : \ndate\n";
my $printthr="#Version1.0\thewm\@genomics.org.cn\n";
my $binDir=$Bin;
my $oshbin=" perl  /home/heweiming/bin/Temple/osh.pl " ;

if ($control == 1 )
{
    system ("$oshbin  1 1   $outputdir/frappe  perl $binDir/Genotype2Pedigree.pl  $snpfilelist $mapoutfile    $outputdir/all.ped  ^  cd $plink  ^  $plink/plink\t--ped $outputdir/all.ped --recode12 --geno 0.5 --map  $mapoutfile " ) ;

    mkdir $plink if (! -e $plink);
    mkdir $frappe if (! -e $frappe);	
    `cp $binDir/plink $plink/`;
	`cp $binDir/frappe_linux64 $frappe/`; 
    
    system( "qsub -cwd -l vf=2G  -S  /bin/sh  -q bc.q -P paptest  $outputdir/frappe.sh");
    print "step1 is OK ! please check the shell\n$outputdir/frappe.sh\n" ;
}

elsif ($control == 2)
{
	chdir $frappe || die $!;
	foreach my $i(2 .. $maxK)
    {
		`ln -s $plink/plink.ped $plink/plink_$i\.ped` if (! -e "$plink/plink_$i\.ped");
	}
    
	my $sites= 0;
	open (A,"$plink/plink.log") || die $!;
    while(<A>)
    {
		chomp;
		if (/After frequency and genotyping pruning, there are (\d+) SNPs/)
        {
			$sites = $1;
		}
	}
	close A;
    
	foreach my $j(2..$maxK)
    {
		open (O,">$frappe/$j\.txt") || die $!;
		print O "MaxIter=  10000\nK      = $j\nM       =$sites\nI      =  $numer_of_samples\nNout   =  10\nstep   =  1\n";
		print O "GenotypeFile  =\"$plink/plink_$j\.ped\"\n";
		print O "IndividualFile = \"NONE\"\n";
		close O;    
   system (" $oshbin  $j $j $frappe/frappe$j  $frappe/frappe_linux64  $frappe/$j\.txt  ");
   system("qsub -cwd -l vf=2G -S  /bin/sh  $frappe/frappe$j\.sh");
	}
    print "step2 is OK ! please check the shell\n$frappe\n" ;
}

elsif($control == 3)
{
    system("ls  $plink/plink_*_result.txt > $plink/out.list");
    system("$oshbin  1 1 $outputdir/stat_result  perl  $binDir/structure_arrange.pl  $sample_list  $plink/out.list $plink/result.final");
    system ("sh $outputdir/stat_result.sh ");
    print "step3 is OK ! \n" ;
}

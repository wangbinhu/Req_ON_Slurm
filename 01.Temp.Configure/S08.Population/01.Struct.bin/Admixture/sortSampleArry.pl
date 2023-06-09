#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to 
#edit by hewm;   Sun Jan 26 13:57:31 HKT 2014
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2014-01-26;\nUsage: $0 <InPut><K><OUT>\n" unless (@ARGV ==3);

#############Befor  Start  , open the files ####################

open (IA,"$ARGV[0]") || die "input file can't open $!";
open (OA,">$ARGV[2]") || die "output file can't open $!" ;

################ Do what you want to do #######################

my %sort=();
my %line=();
my %name=();
my %Value=();

#32      K=2     K_ICCV00305     0.481803        0.518197        K=3     K_ICCV00305     0.336018        0.453026

my $sample=0;
while(<IA>)
{
	chomp ;
	next if ($_ eq "" );
	my @inf=split ;
	$line{$inf[2]}=$_;
	$name{$inf[2]}=$inf[0];
	my $stat=0;
	foreach my $kk (0..$#inf)
	{
		if ($inf[$kk] eq "K=$ARGV[1]" )
		{
			$stat=$kk ;
		}
	}
	$stat+=2;
	my $end=$stat+$ARGV[1]-1;
	my $count=1;
	foreach my $k2 ($stat..$end)
	{
		$Value{$inf[2]}{$count}=$inf[$k2];
		$count++;
	}
	$sample++;
}
close IA;

my $Flag=1;
my %Rsort=();

#  0.99  sort name
foreach my $kk (1..$ARGV[1])
{
	foreach my $k1 ( sort keys %name)
	{
		next if (exists  $sort{$k1} );
		if ($Value{$k1}{$kk} > 0.99 )
		{
			$sort{$k1}=$Flag;
			$Rsort{$Flag}=$k1;
			$Flag++;
		}
	}
	
	my %tt=();
	foreach my $k1 ( sort keys %name)
	{
		next if (exists  $sort{$k1} );
		if ($Value{$k1}{$kk} > 0.5 )
		{
			$tt{$k1}=$Value{$k1}{$kk};
		}
	}

	foreach my  $cc ( sort {$tt{$b}<=>$tt{$a}} sort keys  %tt)
	{
		$sort{$cc}=$Flag ;
		$Rsort{$Flag}=$cc; 
		$Flag++;
	}

}


my %tt=();
foreach my $dd (sort  keys  %line)
{
	next if (exists  $sort{$dd} );
	$tt{$dd}=$Value{$dd}{1};
}

foreach my  $cc ( sort {$tt{$b}<=>$tt{$a}} sort keys  %tt )
{
	$sort{$cc}=$Flag ;
	$Rsort{$Flag}=$cc; 
	$Flag++;
}

# 0.5-0.99  sort value
$Flag--;

foreach my $kk  (1..$Flag)
{
	my  $dd=$Rsort{$kk};

	if (!exists $line{$dd} )
	{
		print "bad\t$dd\n";
		exit (1);
	}
	else
	{
		print OA $line{$dd},"\n";
	}
}

close OA ;

######################swimming in the sky and flying in the sea ###########################

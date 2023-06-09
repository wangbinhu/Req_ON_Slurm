#!/usr/bin/perl-w
use strict;
use Math::BigInt;
#explanation:this program is edited to 
#edit by HeWeiMing;

die  "Version 1.0 2009-7-6;\nUsage: $0<chr.add_ref><OUT>\n" unless (@ARGV == 2);

	if  ($ARGV[0]=~s/\.gz$/\.gz/g )
	{
		open  SNP,  "gzip -cd $ARGV[0] | "  || die "$!" ;
	}
	else
	{
		open  SNP,  "$ARGV[0]"  || die "$!" ;
	}
	open  OUT1,  ">$ARGV[1].Diff"  || die "$!" ; 
	open  OUT2,  ">$ARGV[1].Use"  || die "$!" ; 

	my $sampleNum=0;
	my %hash_Use=();
	my %hash_SNP=();

	while(<SNP>)
	{
		chomp ;
		next if ($_=~s/#/#/);
		my @inf=split /\t/ ;
		$inf[2]=uc($inf[2]);
		my @base=split /\s+/,$inf[2];
		shift @base;
		if ($sampleNum<$#base)
		{
			$sampleNum=$#base ;
		}
		for(my $i=0 ;$i<$sampleNum ; $i++)
		{
			if ($base[$i] eq "-"  ||  $base[$i] eq "N"  ) {next;}
			for(my $j=$i+1; $j<=$sampleNum ; $j++)
			{
				if($base[$j] eq "-"  || $base[$j] eq "N" ) {next;}
				$hash_Use{$i}{$j}++;
				if($base[$i] eq $base[$j] )  {next;}
				elsif($base[$i] eq "M" ||$base[$i] eq  "K"|| $base[$i] eq  "Y" || $base[$i] eq "R"|| $base[$i] eq "W"||$base[$i] eq  "S" || $base[$j] eq "M" ||$base[$j] eq "K"|| $base[$j] eq "Y"|| $base[$j] eq "R" || $base[$j] eq "W"||$base[$j] eq  "S" )
				{
					$hash_SNP{$i}{$j}+=0.5;
				}
				else
				{
					$hash_SNP{$i}{$j}+=1;
				}
			}
		}
	}
	close SNP  ;


	foreach my $i (0..$sampleNum)
	{
		my $SNPA=0 ;
		my $UseA=0;
		if (exists   $hash_SNP{$i}{0} )
		{
			$SNPA=$hash_SNP{$i}{0};   
		}
		elsif (exists   $hash_SNP{0}{$i})
		{
			$SNPA=$hash_SNP{0}{$i};
		}

		if   (exists   $hash_Use{$i}{0})
		{
			$UseA=$hash_Use{$i}{0};  
		}
		elsif   (exists   $hash_Use{0}{$i})
		{
			$UseA=$hash_Use{0}{$i};
		}


		print OUT1 $SNPA;
		print OUT2 $UseA;

		foreach my $j (1..$sampleNum)
		{

			my  $SNP=0 ;
			my $Use=0;
			if (exists   $hash_SNP{$i}{$j} )
			{
				$SNP=$hash_SNP{$i}{$j};   
			}
			elsif (exists   $hash_SNP{$j}{$i})
			{
				$SNP=$hash_SNP{$j}{$i};
			}

			if   (exists   $hash_Use{$i}{$j})
			{
				$Use=$hash_Use{$i}{$j};  
			}
			elsif   (exists   $hash_Use{$j}{$i})
			{
				$Use=$hash_Use{$j}{$i};
			}

			print OUT1 "\t$SNP";
			print OUT2 "\t$Use";
		}
		print OUT1 "\n";
		print OUT2 "\n";
	}



	close OUT1 ;
	close OUT2 ;



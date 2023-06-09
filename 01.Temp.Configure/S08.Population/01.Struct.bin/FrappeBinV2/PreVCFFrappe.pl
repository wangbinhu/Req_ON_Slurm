#!/usr/bin/perl -w
#use strict;
use Getopt::Long;
use FindBin qw($Bin);
use Data::Dumper;
#explanation:this program is edited to 
#Version 1.0    hewm@genomics.cn 

my $OutPut;
my $InFile;
my $InList;
my $help;
my $ChrXName="";

sub  usage
{
	print STDERR <<USAGE;

		 perl  $0  -InList  VCF.list -OutPut OutFix
			   hewm\@genomics.cn      2020-04-01

		Options

		 -InFile       <s> : InPut One VCF File
		 -InList       <s> : InPut VCF File List
		 -OutPut       <s> : OutPut Prefix xx.ped+xx.map

		 -ChrXName     <s> : Filter the Sex chromosome

		 -help             : Show this help

USAGE
}


GetOptions(
	"InFile:s"=>\$InFile,
	"InList:s"=>\$InList,
	"OutPut:s"=>\$OutPut,
	"ChrXName:s"=>\$ChrXName,
	"help"=>\$help,
);


#############swimming in the sky and flying in the sea #########

if (  defined($help)  )
{
	usage();
	exit(1) ;
}

if(  !defined($OutPut)  )
{
	usage ;
	exit(1) ;
}

if ( (!defined($InFile))     &&  (!defined($InList)) )
{
	usage ;
	exit(1) ;
}


my %hash=();
my $Flag=0;
my $head="NA";
open (OA,">$OutPut.map") || die "output file can't open $!" ;
open (OB,">$OutPut.ped") || die "output file can't open $!" ;
my @fileTmp = ();
my $SNPNumer=0;

################ Do what you want to do #######################
if  (defined($InFile))
{

	if  ($InFile =~s/\.gz$/\.gz/)
	{
		open IA,"gzip -cd  $InFile | "  || die "input file can't open $!" ;
	}
	else
	{
		open IA,"$InFile"  || die "input file can't open $!" ;
	}


	while(<IA>) 
	{ 
		chomp ; 
		next if  ($_=~s/##/##/);
		my @inf=split ;
		if ($inf[0] ne  "#CHROM")
		{
			print "Can't Find the  [#CHROM] at the Header, No VCF Format IN, exit\n";
			exit (1);
		}		
		#		print OA $_,"\n";
		$head=$_;
		last;		
	}

	my @ArrHead=split /\s+/,$head;
	foreach my $i(9..$#ArrHead)
	{
		$fileTmp[$i] = "$OutPut.$ArrHead[$i].ped";
		my $fh = "PD$i";
		open $fh, ">$fileTmp[$i]" or die "$!\n";
		print $fh  "$ArrHead[$i] $ArrHead[$i] 0 0 0 -9";
	}

	while(<IA>) 
	{ 
		chomp ; 
		my @inf=split ;
		next if  (length($inf[4])>1) ;
		next if  (length($inf[3])>1) ;
		next if ($inf[0] eq $ChrXName);
		if (exists $hash{$inf[0]})
		{
			$inf[0]=$hash{$inf[0]};
		}
		else
		{
			$Flag++;
			$hash{$inf[0]}=$Flag;
			$inf[0]=$Flag;
		}
		if ($inf[2] eq ".")
		{
			$inf[2]="$inf[0]\_$inf[1]";
		}
		print OA $inf[0],"\t$inf[2]\t0\t$inf[1]\n";
		$SNPNumer++;
		foreach my $i(9..$#ArrHead)
		{
			my $fh = "PD$i";
			my @BB=split /\:/,$inf[$i];
			my @CC=split //,$BB[0];
			if  ($CC[0] eq  ".")
			{
				print $fh  " 0 0";
			}
			else
			{
				$CC[0]++;
				$CC[3]++;
				print $fh  " $CC[0] $CC[3]";
			}
		}
		#		$_=join("\t",@inf);			print OA $_,"\n";
	}
	close IA;


}




if  (defined($InList))
{

	if  ($InList =~s/\.gz$/\.gz/)
	{
		open IR,"gzip -cd  $InList | "  || die "input file can't open $!" ;
	}
	else
	{
		open IR,"$InList"  || die "input file can't open $!" ;
	}


	while(<IR>)
	{
		chomp ;
		$InFile=$_;


		if  ($InFile =~s/\.gz$/\.gz/)
		{
			open IE,"gzip -cd  $InFile | "  || die "input file can't open $!" ;
		}
		else
		{
			open IE,"$InFile"  || die "input file can't open $!" ;
		}

		while(<IE>) 
		{ 
			chomp ; 
			next if  ($_=~s/##/##/);
			my @inf=split ;
			if ($inf[0] ne  "#CHROM")
			{
				print "Can't Find the  [#CHROM] at the Header, No VCF Format IN, exit\n";
				exit (1);
			}		
			if ($head eq "NA")
			{
				#	print OA $_,"\n";
				$head=$_;
				my @ArrHead=split /\s+/,$head;
				foreach my $i(9..$#ArrHead)
				{
					$fileTmp[$i] = "$OutPut.$ArrHead[$i].ped";
					my $fh = "PD$i";
					open $fh, ">$fileTmp[$i]" or die "$!\n";
					print $fh  "$ArrHead[$i] $ArrHead[$i] 0 0 0 -9";
				}
			}
			else
			{
				if  ($_ ne 	$head )
				{
					print "Head at $InFile  Diff from before\n$head\nexit;\n";
					exit ;
				}
			}
			last;		
		}

		my @ArrHead=split /\s+/,$head;

		while(<IE>) 
		{ 
			chomp ; 
			my @inf=split ;
			next if  (length($inf[4])>1) ;
			next if  (length($inf[3])>1) ;
			next if ($inf[0] eq $ChrXName);
			if (exists $hash{$inf[0]})
			{
				$inf[0]=$hash{$inf[0]};
			}
			else
			{
				$Flag++;
				$hash{$inf[0]}=$Flag;
				$inf[0]=$Flag;
			}		
			if ($inf[2] eq ".")
			{
				$inf[2]="$inf[0]\_$inf[1]";
			}

			print OA $inf[0],"\t$inf[2]\t0\t$inf[1]\n";
			$SNPNumer++;
			foreach my $i(9..$#ArrHead)
			{
				my $fh = "PD$i";
				my @BB=split /\:/,$inf[$i];
				my @CC=split //,$BB[0];
				if  ($CC[0] eq  ".")
				{
					print $fh  " 0 0";
				}
				else
				{
					$CC[0]++;
					$CC[3]++;
					print $fh  "\ $CC[0] $CC[3]";
				}
			}

			#			$_=join("\t",@inf);			print OA $_,"\n";
		}

		close IE;
	}
	close IR;
}


close OA ;

my @ArrHead=split /\s+/,$head;
foreach my $i(9..$#ArrHead)	
{
	my $fh = "PD$i";
	close $fh;
	open IBC ,"$fileTmp[$i]";
	while(<IBC>)
	{
		chomp;
		print OB $_,"\n";
	}
	close IBC;
	unlink $fileTmp[$i] ;
}
close OB ;

print "Total SNP Number is $SNPNumer\n";
my $SamplesNumber=$#ArrHead-8;
print "Total Samples Number is $SamplesNumber\n";


######################swimming in the sky and flying in the sea ###########################
######################swimming in the sky and flying in the sea ###########################

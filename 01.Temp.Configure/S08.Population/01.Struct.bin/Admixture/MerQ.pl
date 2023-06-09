#!/usr/bin/perl -w
use strict;
use FileHandle;   # open multi_file
#explanation:this program is edited to 
#edit by hewm;   Thu Apr  2 17:02:53 CST 2020
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2020-04-02;\nUsage: $0 <individual.txt><In.list><Out>\n" unless (@ARGV ==3);

#############Befor  Start  , open the files ####################

open (IA,"$ARGV[0]") || die "input file can't open $!";
open (OA,">$ARGV[2]") || die "output file can't open $!" ;

################ Do what you want to do #######################


######################swimming in the sky and flying in the sea ###########################
my $filelist= $ARGV[1]  ;
my %fh=();
my $file_cout=0 ;
my %QQhash=();
open (Flist , "<$filelist") || die "$!" ;
while(<Flist>)
{
	chomp ;
	$file_cout ++  ;
	$fh{$file_cout}=FileHandle->new($_);
	my @BBB=split /\//,$_;
	my @CCC=split/\./,$BBB[-1];
	$QQhash{$file_cout}=$CCC[1];
}
close Flist ;


while(<IA>)
{
	chomp ; 
	my @inf=split ;
	print OA $inf[0];
	for(my $i=1 ;  $i<=$file_cout;  $i++)
	{
		my $a=$fh{$i}->getline();
		chomp $a ;
		my @bbbb=split /\s+/,$a;
		$a=join("\t",@bbbb);
		print OA "\tK=$QQhash{$i}\t$inf[-3]\t$a";
	}
	print OA "\n";
}

close IA;



foreach my $k (keys  %fh )
{
	$fh{$k}->close();
}



close OA ;


use strict;
use Getopt::Long;
use File::Basename;
use PerlIO::gzip;

my $vcf_in=shift;
my $vcf_out1=shift;
my $vcf_out2=shift;
my $depth=shift;
my $misscutoff=shift;
my $bgzip=shift;
my $tabix=shift;

open my $OUT,">$vcf_out1" or die $!;
open my $STAT,">$vcf_out2.stat" or die $!;
open my $VI,"zcat $vcf_in|" or die $!;
my $site=0;
while (<$VI>) {
	chomp;
	my @a=split/\s+/,$_,10;
	if($_ =~/^#/){
		print $OUT "$_\n";
		next;
	}
	my $chr=$a[0];
	my $pos=$a[1];
	my $ref=$a[3];
	my $alt=$a[4];
	my $qual=$a[5];
	next if($alt eq ".");
	if($alt=~/\*/){next};
	my @feats=split/\;/,$a[7];
	my @nts=split/\s+/,$a[9];
	my %featval;
	foreach my $feat(@feats){
		my @str=split/\=/,$feat;
		$featval{$str[0]}=$str[1];
	}
	my @alt=split/\,/,$ref.",".$alt;
	my $flag=0;
	foreach my $altnt(@alt){
		if(length($altnt)>1){
			$flag=1;
		}
	}
	next if($flag==1);
	#print "$_\n";
	if($qual>30 and $featval{MQ}>20 and $featval{DP}>$depth and $featval{FS}<20  and  $featval{QD}>2  ){
		my $miss=0;
		my %base;
		my $sum=0;
		foreach my $gts(@nts){
			$gts=(split/\:/,$gts)[0];
			if($gts=~/\./){
				$miss++;
			}else{
				my @gts=split/\//,$gts;
				$base{$gts[0]}++;
				$base{$gts[1]}++;
				$sum+=2;
			}
		}
		my $samnum=scalar(@nts);
		my $rate=$miss/$samnum;
		my @base=sort {$base{$a}<=>$base{$b}} keys %base;
		my $basenum=scalar(@base);
		my $maf=$base{$base[0]}/$sum;
#		print "$chr\t$pos\t$ref\t$alt\t$qual\tMQ:$featval{MQ}\tDP:$featval{DP}\tFS:$featval{FS}\tQD:$featval{QD}\t$rate\t$basenum\t$base{$base[0]}\t$base{$base[1]}\t$maf\n";
		if($rate<$misscutoff and $basenum eq 2 and $maf>0.05){
			print $OUT "$_\n";
			print $STAT "$chr\t$pos\t$ref\t$alt\t$qual\tMQ:$featval{MQ}\tDP:$featval{DP}\tFS:$featval{FS}\tQD:$featval{QD}\t$rate\t$basenum\t$base{$base[0]}\t$base{$base[1]}\t$maf\n";
		}
	}

}
close $VI;
close $OUT;
close $STAT;
system("$bgzip  -c $vcf_out1 >$vcf_out2");
system("$tabix  $vcf_out2");
system("rm $vcf_out1");


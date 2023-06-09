#!/usr/bin/perl -w
use strict;
use FindBin qw($Bin);
#explanation:this program is edited to 
#edit by hewm;   Thu Apr  2 16:15:15 CST 2020
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2020-04-02;\nUsage: $0 <InPut><InDir><individual.txt><Out>\n" unless (@ARGV ==4);

#############Befor  Start  , open the files ####################

open (IA,"$ARGV[0]") || die "input file can't open $!";

open (OA,">$ARGV[3].BestK") || die "output file can't open $!" ;
open (OB,">$ARGV[3].r") || die "output file can't open $!" ;

my $Rscript="/hwfssz4/BC_PUB/Software/03.Soft_ALL/R-3.5.1/bin/Rscript";
################ Do what you want to do #######################

$_=<IA> ; chomp ;
my @inf=split ;

print  OA  "#K\tCVError\n";
my $MinV =$inf[-1] ;
my $BestK=(split(/\=/,$inf[-2]))[-1];
   $BestK=(split(/\)/,$BestK))[0];
   
print OA $BestK,"\t$MinV\n";

	while(<IA>) 
	{ 
		chomp ; 
		my @infH=split ;
		my $TTT=(split(/\=/,$infH[-2]))[-1];
   		   $TTT=(split(/\)/,$TTT))[0];
		print OA $TTT,"\t$infH[-1]\n";
		if  ($infH[-1]   <   $MinV )
		{
			 $MinV=$infH[-1];
			 $BestK=$TTT;
		}
		
	}

close IA;
close OA ;

print  OB <<EEE;
read.table("$ARGV[3].BestK")->data;
pdf("$ARGV[3].CV.pdf")
plot(data[,1],data[,2],type="l",xlab="K Value",ylab="CV error",bty="n");
dev.off();

EEE

close OB ;

print "BestK: $BestK\t$MinV\n";
system(" $Rscript  $ARGV[3].r ;  rm -rf  $ARGV[3].r ");
system (" cp  $ARGV[1]/plink.$BestK.Q    $ARGV[3].BestK$BestK.Q  ") ;

open (OC,">$ARGV[3].r") || die "output file can't open $!" ;
print  OC <<EEE;
tbl = read.table("$ARGV[3].BestK$BestK.Q");
pdf("$ARGV[3].BestK$BestK.pdf",h=4,w=12)
barplot(t(as.matrix(tbl)),col= rainbow(7),xlab="Individual", ylab="Ancestry",border = NA,space = 0);
dev.off()
EEE

close OC  ;
system(" $Rscript  $ARGV[3].r ;  rm -rf  $ARGV[3].r ");

system ("ls    $ARGV[1]/plink.\*.Q    >  $ARGV[3].list ");
system ("perl  $Bin/MerQ.pl     $ARGV[2]   $ARGV[3].list     $ARGV[3].temp ");
system ("perl   $Bin/sortSampleArry.pl      $ARGV[3].temp $BestK   $ARGV[3].sort ");
system ("echo perl   $Bin/sortSampleArry.pl      $ARGV[3].temp $BestK   $ARGV[3].sort ");
system ("rm -rf    $ARGV[3].temp    $ARGV[3].list  ");



######################swimming in the sky and flying in the sea ###########################

#!/usr/bin/perl -w
use strict;
use FindBin qw($Bin);
#explanation:this program is edited to 
#edit by HeWeiMing;   Wed Jan 12 09:53:58 CST 2010
#Version 1.0    hewm@genomics.org.cn 

die "Version 1.0\t2010-01-12;\nUsage: $0 <In(add_ref.list)><individual.txt><OutDir>\n"unless (@ARGV==2 || @ARGV ==3 );

sub usage ()
{
    print "Usage: $0 In(add_ref) individual.txt OutDir \n" ;
    exit (1) ;
}

##############Befor  Start  , open the files ####################

my $BirDir=$Bin ; 
#my $changeToGenotype="perl $BirDir/Genotype2Pedigree.pl " ;
my $changeToGenotype="perl $BirDir/changeToGenotype.pl " ;

my $newFormat="perl $BirDir/newFormat.pl" ;
my $ReadLog2txt="perl $BirDir/ReadLog2txt.pl" ;
my $plink="$BirDir/plink " ;
my $frappe_linux64="$BirDir/frappe_linux64";
my $structure_arrange="perl $BirDir/structure_arrange.pl" ;
my $osh="perl $BirDir/osh.pl " ;
my $nsh="perl $BirDir/nsh.pl " ;

my $PWD=`pwd` ;  chomp  $PWD ;
$ARGV[2]||=$PWD ;
my $temp=(split(/\//,$ARGV[2]))[-1];
if  ($temp ne "Frappe" && $temp ne "frappe"   && $temp ne "FRAPPE" )
{
    $ARGV[2]="$ARGV[2]/Frappe" ;
}

my $shell="$ARGV[2]/shell" ;
my $plinkDir="$ARGV[2]/plink" ;
my $frappe="$ARGV[2]/frappe" ;
my $data="$ARGV[2]/data" ;


mkdir $ARGV[2] unless (-e $ARGV[2]) ;
mkdir $shell unless (-e $shell);
mkdir $plinkDir unless (-e $plinkDir);
mkdir $frappe unless (-e $frappe);
mkdir $data unless (-e $data);
usage ()  unless (-e $ARGV[1] );
usage ()  unless (-e $ARGV[0] );


my $Sample_number=` wc -l  $ARGV[1]  | cut  -f 1 -d " " ` ;
my @tdemp=split //,$ARGV[0] ;
if ($tdemp[0] ne "/")
{
    $ARGV[0]=$PWD."/$ARGV[0]";
}
@tdemp=();
@tdemp=split //,$ARGV[1] ;
if ($tdemp[0] ne "/")
{
    $ARGV[1]=$PWD."/$ARGV[1]";
}


chomp $Sample_number ;    
chdir $shell ;
################ Do what you want to do #########################

system (" $osh  01  01 F_step1   $changeToGenotype   $ARGV[0]   $data/genotype.out ^ $newFormat    $data/genotype.out   $data     $data/map.out  $Sample_number  \\\>  $data/all.ped  ^  cd $plinkDir  ^ cp  $plink  $plinkDir  ^ $plinkDir/plink   --ped  $data/all.ped  --recode12 --geno 0.5 --map   $data/map.out  --noweb  ^ rm  -f  $plinkDir/plink  ^ rm  -f $data/genotype.out  "); 

system("qsub  -cwd -l vf=1.688G -S  /bin/sh  -q bc.q -P BUBicwT F_step1.sh ") ;

system (" $nsh  2  7   F_step2K  1.688G  cd $frappe ^ ln -sf  $plinkDir/plink.ped $frappe/plink_#.ped   ^  $ReadLog2txt   $plinkDir/plink.log  $frappe/#.txt  \\\#  $Sample_number    $frappe/plink_#.ped   ^  $frappe_linux64  $frappe/#.txt  " );

system("$osh  01  01 F_step3   ls   $frappe/plink_\\\*_result.txt \\\>  $frappe/out.list  ^   $structure_arrange  $ARGV[1]    $frappe/out.list   $ARGV[2]/result.final  ")


#

#####################swimming in the sky and flying in the sea ###########################

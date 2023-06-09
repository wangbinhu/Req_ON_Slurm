#!/usr/bin/perl-w
use strict;
#explanation:this program is edited to new the 00-12 shell
#edit by HeWeiMing;   Version1.0    2009-8-6
my $cout_ARVG=@ARGV;

my $theuser=`whoami` ; chomp $theuser ;
   $theuser="hewm" if ($theuser eq "heweiming");
###########################  show  the help   ##############################

sub usage{
    print STDERR <<USAGE;
Version:1.0
2009-8-6            hewm\@genomics.org.cn

            Usage:  nsh <Star(01)>  <End(12)>   <prefix>    <1G>    <..chr#..>  <..^..>
            where:  new the shell script (from start to end ) 

            Options:
                Start  <n> : The first shell script
                End    <n> : The last shell script
                Prefix <c> : The file name of the shell script  
                1G     <n> : To qsub every shell script need how much  memory
                 #     <c> : For every shell script ,Chang the # to the number of the it
                 ^         : In every shell script ,See the ^ as the end of this line 
                -h         : show this help message

            Example :
                nsh 01 20  Gm 0.3G msort -k n9  soap/Gm# \\\>  SoapBychrSort/Gm#  ^  soapsnp
                -i SoapBychrSort/Gm#   -d  Gm#.fa  -o Gm#.cns  -M Gm#.mat  -L 76   
USAGE
}

for(my $ii=0 ; $ii<$cout_ARVG;  $ii++)
{
    if ( $ARGV[$ii]  eq "-h" ||  $ARGV[$ii]  eq "-help"  || $ARGV[$ii]  eq "help"  ) 
    {
        usage ;
        exit  ;
    }
}
if( $cout_ARVG<1 ) { die "Usage: nsh <Star_01><End_12><prefix><1G><..chr#..><..^..>\n";exit ; }
my @temp=split//,$ARGV[3] ;
if($temp[-1] ne "G" &&  $temp[-1] ne "g")
{
    print "\tmiss the Options of memory for the qsub \n";
    exit ;
}



########################  before the start . Do some small  ##############################
die "Usage: nsh <Star_01><End_12><prefix><1G><..chr#..><..^..>\n" unless ($cout_ARVG > 5);

my $Stat=$ARGV[0] ; my $End=$ARGV[1] ;
@temp=split//,$ARGV[0] ;
my $Zero=$temp[0];
my $firsti_cut=$#temp+1;
@temp=();
@temp=split//,$ARGV[1];  my $cut_leng=$#temp+1;   my $end_cut=0-$cut_leng;
if ($Zero  == 0 )
{
    my $aab= "0" x $cut_leng;
    $End="1".$aab.$ARGV[1];
    $cut_leng=$cut_leng*2-$firsti_cut;
    $aab= "0" x $cut_leng;
    $Stat="1".$aab.$ARGV[0];
}

@temp=();

if( $Stat > $End )
{
    print "check the Start and the End!\n, maybe $ARGV[1] befor the $ARGV[0]\n";
}



my $headfirst="#!/bin/sh\n";
my $sedhead="#\$ -S /bin/sh\n"; 
my $printStar="echo Start Time : \ndate\n";
my $printEnd="echo End Time : \ndate\n";
my $qsub_shell=$ARGV[2]."_"."qsub\.sh" ;

my $date=`date`;
my %chang=();
$chang{Aug}="08";  $chang{Jan}="01"; $chang{Feb}="02"; $chang{Mar}="03";
$chang{Apr}="04";  $chang{May}="05"; $chang{Jun}="06"; $chang{Jul}="07";
$chang{Sep}="09";  $chang{Oct}="10"; $chang{Nov}="11"; $chang{Dec}="12";
$chang{"8月"}="08";   $chang{"1月"}="01";  $chang{"2月"}="02"; $chang{"3月"}="03";
$chang{"4月"}="04";   $chang{"5月"}="05";  $chang{"6月"}="06"; $chang{"7月"}="07";
$chang{"9月"}="09";   $chang{"10月"}="10"; $chang{"11月"}="11"; $chang{"12月"}="12";
$chang{"08月"}="08";  $chang{"01月"}="01"; $chang{"02月"}="02"; $chang{"03月"}="03";
$chang{"04月"}="04";  $chang{"05月"}="05"; $chang{"06月"}="06"; $chang{"07月"}="07";
$chang{"09月"}="09";

my @time=split /\s+/ ,$date;
$time[1]=$chang{$time[1]};
my $time=join("-",@time[-1,1,2]);
my $printthr="#Version1.0\t$theuser\@genomics.org.cn\t$time\n";


open QSUB,">$qsub_shell" || die " $! ";

##################  Do what you want to do ###########

for(my $ii=$Stat ; $ii<=$End; $ii++)
{
    my $turn=(substr $ii,$end_cut,$cut_leng); 
    my $new_shell=$ARGV[2].$turn."\.sh"; 

    my $printPerl="";
    my $jj=4;

    for( $jj=4; $jj<$cout_ARVG; $jj++)
    {
        my $temp=$ARGV[$jj];
        $temp =~s/\#/$turn/g;
        if($temp eq "^") { $printPerl .="\n"; next ;}
        $printPerl .=$temp."\t";
    }

    $printPerl.="\n";

    open  SH ,">$new_shell"  || die "$!"  ;
    print SH   $headfirst,$sedhead, $printthr,$printStar , $printPerl, $printEnd;             
    close SH; 

    print QSUB "qsub -S /bin/sh -cwd -l vf=$ARGV[3] $new_shell\n";

}        


if ($End==24)
{
	system ("sed  -i 's/23/X/g' $ARGV[2]23\.sh  ");
    system ("sed  -i 's/24/Y/g' $ARGV[2]24\.sh  ");
}

close QSUB;
print "\t\t\tOK\n";
###### swimming in the sky and flying in the sea ########

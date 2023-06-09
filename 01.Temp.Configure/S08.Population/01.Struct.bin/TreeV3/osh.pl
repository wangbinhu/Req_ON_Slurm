#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to new the 00-12 shell
#edit by heweiming;   Version1.0    2009-8-6
my $cout_ARVG=@ARGV;

my $theuser=`whoami` ; chomp $theuser ;
$theuser="hewm" if ($theuser eq "a");
$theuser="hewm" if ($theuser eq "heweiming");
############# show the help message ####################
sub usage{
    print STDERR <<USAGE; 
Version:1.0
2009-8-6            hewm\@genomics.org.cn

            Usage:  nsh <Star(01)>  <End(12)>   <prefix>    <..chr#..>  <..^..>
            where:  new one shell script to run the program(chr#) from start to end 

            Options:
               Start  <n> : The fisrt  program
               End    <n> : The last program
               Prefix <c> : The shell script name
               chr#   <c> : For the shell script ,Chang the # to the number of the it
                ^         : In the shell script ,See the ^ as the end of this line
               -h         : show this help message

             Example :
              osh 01 20  Gm  sort -k9 -n soap/Gm# \\\>  SoapBychrSort/Gm#  ^  soapsnp
              -i SoapBychrSort/Gm#   -d  Gm#.fa  -o Gm#.cns  -M Gm#.mat  -L 76
USAGE
}

for(my $ii=0 ; $ii<$cout_ARVG;  $ii++)
{
    if ( $ARGV[$ii]  eq "-h" ||  $ARGV[$ii]  eq "-help"  || $ARGV[$ii]  eq "help"  )
    {
        usage ; exit ;
    }
}

die "Usage: osh <Star_01><End_12><prefix><..chr#..><..^..>\n" unless ($cout_ARVG > 4);

##############################################################
my $Stat=$ARGV[0] ; my $End=$ARGV[1];
my @temp=split//,$ARGV[0];
my $Zero=$temp[0]; 
my $firsti_cut=$#temp+1;
@temp=();
@temp=split//,$ARGV[1];  my $cut_leng=$#temp+1;   my $end_cut=0-$cut_leng;

if (($Zero  == 0 && $Stat!=0 &&  length($Stat)==length($End) )  ||  ( $Zero == 0 && int($Stat)==0 && length($Stat)>1 && length($Stat) == length($End) ) )
{
    my $aab= "0" x $cut_leng;
    $End="1".$aab.$ARGV[1];
    $cut_leng=$cut_leng*2-$firsti_cut;
    $aab= "0" x $cut_leng;
    $Stat="1".$aab.$ARGV[0];
    }
elsif ( $Zero  == 0  &&  length ($Stat) >  length($End) )
{
     print "Warning $Stat length longer than  $End length\n" ;
     if ( int($Stat)> int($End) )
     {
         print "check the Start and the End!\n maybe $ARGV[1] befor the $ARGV[0]\n";
     }
      my $aab="0" x (length ($Stat) -  length($End));
      $Stat="1".$ARGV[0];
      $End="1".$aab.$End;
}
if( $Stat > $End )
{
    print "check the Start and the End!\n maybe $ARGV[1] befor the $ARGV[0]\n";
    exit(1);
}
################################################################
my $headfirst="#!/bin/sh\n";
my $sedhead="#\$ -S /bin/sh\n";
my $printStar="echo Start Time : \ndate\n";
my $printEnd="echo End Time : \ndate\n";
#my $printStar="echo Start Time : \ndate '+\%F\t\%H:\%M:\%S'\n";
#my $printEnd="echo End Time : \ndate '+\%F\t\%H:\%M:\%S'\n";

#echo start at time `date +%F'  '%H:%M`


my $time=`date +%F`; chomp $time ;

my $printthr="#Version1.0\t$theuser\@genomics.org.cn\t$time\n";

################################################################

my $sh_shell=$ARGV[2]."\.sh" ;

open SH,">$sh_shell" || die " $! ";

print SH $headfirst,  $sedhead , $printthr, $printStar;

#################### Do  what you want to do ##################
if ($End==24)
{
    for(my $ii=$Stat ; $ii<=22; $ii++)
    {
        my $turn=(substr $ii,$end_cut,$cut_leng); 

        my $printPerl="";
        my $jj=3;

        for( $jj=3; $jj<$cout_ARVG; $jj++)
        {
            my $temp=$ARGV[$jj];
            $temp =~s/\#/$turn/g;
            if($temp eq "^") { $printPerl .="\n"; next ;}
            $printPerl .=$temp."\t";
        }

        $printPerl.="\n";
        print SH  $printPerl ;
    }
    my $printPerl="";
    for(my  $jj=3; $jj<$cout_ARVG; $jj++)
    {
        my $temp=$ARGV[$jj];
        $temp =~s/\#/X/g;
        if($temp eq "^") { $printPerl .="\n"; next ;}
        $printPerl .=$temp."\t";
    }
    $printPerl.="\n";
    print SH  $printPerl ;
    $printPerl="";
    for( my $jj=3; $jj<$cout_ARVG; $jj++)
    {
        my $temp=$ARGV[$jj];
        $temp =~s/\#/Y/g;
        if($temp eq "^") { $printPerl .="\n"; next ;}
        $printPerl .=$temp."\t";
    }
    $printPerl.="\n";
    print SH  $printPerl ;
    $printPerl="";
}  
else
{
    for(my $ii=$Stat ; $ii<=$End; $ii++)
    {
        my $turn=(substr $ii,$end_cut,$cut_leng); 

        my $printPerl="";
        my $jj=3;

        for( $jj=3; $jj<$cout_ARVG; $jj++)
        {
            my $temp=$ARGV[$jj];
            $temp =~s/\#/$turn/g;
            if($temp eq "^") { $printPerl .="\n"; next ;}
            $printPerl .=$temp."\t";
        }

        $printPerl.="\n";

        print SH  $printPerl ;

    }    
}

print SH $printEnd;
close SH;
print "\t\t$sh_shell had done!\n" ;
system ("chmod 775   $sh_shell  ");
########swimming in the sky and flying in the sea ############

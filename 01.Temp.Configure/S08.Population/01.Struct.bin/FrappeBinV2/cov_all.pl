#!/usr/bin/perl-w
use strict;
#explanation:this program is edited to 
#edit by HeWeiMing;   Tue Oct 13 16:28:40 CST 2009
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2009-10-13;\nUsage: $0 <InPut_1><InPut_2><OutDir>\n" unless (@ARGV ==1);

#############Befor  Start  , open the files ####################

open IA,"$ARGV[0]"  || die "input file can't open $!" ;

#open OA,">$ARGV[2]" || die "output file can't open $!" ;

################ Do what you want to do #######################

	while(<IA>) 
	{ 
        my $s=$_ ;
     next if ($s =~ /-/);
        print $_ ;
        #chomp ; 
        #my @inf=split ;
		
		
		
	}


close IA;
#close OA ;

######################swimming in the sky and flying in the sea ###########################
#		my %iupac = ("M", "ac", "K", "gt", "Y", "ct", "R", "ag", "W", "at", "S", "cg","A","aa","T","tt","C","cc","G","gg","-","--");
#		foreach my $ke (keys %iupac)
#		{
#		$inf=~s/$ke/$iupac{$ke}/g;
#		}
#						$a1[3]=0+($inf=~s/g/G/g);	
#                    ($aSed)=(sort{$a<=>$b} @a1)[2];
#foreach my $k (sort {($a <=> $b )or( $hash{$a} <=> $hash{$b}) }keys %hash)
#	{
#	print B	$k,"\t", $hash{$k},"\n";
#	}
#close B;
#		my $line=join("\t", @inf[0..$#inf]);
#
#my $file=`ls /share/*/*.maf`;
#my @arry=split/\n/, $file;
#
#my $leng_file=@arry;
#for (my $ii=0;$ii<$leng_file;$ii++)
#{
#             print $arry[$ii],"\n";
#        open     A,"$arry[$ii]"  || die "$!" ;
#}
#
#######################swiming in the sky and flying in the sea #############################

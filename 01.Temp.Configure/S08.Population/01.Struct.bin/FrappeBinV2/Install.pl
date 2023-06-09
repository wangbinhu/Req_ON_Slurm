#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to 
#edit by HeWeiMing;   Tue Jan 11 12:03:21 CST 2011
#Version 1.0    hewm@genomics.org.cn 

#   To run the bin ; pls perl Install.pl  first at the first used 
my $PWD=`pwd` ; chomp $PWD; 
$PWD=~s/\//\\\//g ;
print "Start To Install\n" ;
system ("cp    backup/stepAll.sh  backup/Run_Frappe_shell.sh  ./ ") ;
system ("sed  -i 's/PPPWWWDDD/$PWD/g'  stepAll.sh  Run_Frappe_shell.sh ");
system ("chmod 775   stepAll.sh  Run_Frappe_shell.sh   ") ;
print "stepAll.sh & Run_Frappe_shell.sh Is OK \n" ;
print "Install Finished \n" ;

#####################swimming in the sky and flying in the sea ###########################

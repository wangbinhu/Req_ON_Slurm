#!/usr/bin/perl -w
use strict;
use v5.10;

open IN, "gzip -dc $ARGV[0] |";
open OU, ">$ARGV[1]";

while (<IN>) {
			chomp;
            if ($_=~/^#/) {say OU "$_";}
            if ($_=~/FIRSTOK/) {
                say OU "$_";
            }
			
}
close IN;
close OU;


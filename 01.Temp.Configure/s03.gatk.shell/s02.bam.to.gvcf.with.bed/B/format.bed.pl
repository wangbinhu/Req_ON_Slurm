#!/usr/bin/perl -w
use strict;
use v5.10;

open IN, "<$ARGV[0]";
my $zone_len = 0;
my $zone_num = 1;

`mkdir -p bed.zone`;
open OU, ">./bed.zone/A$zone_num.bed";

while (<IN>) {
        next if /HD/;
        chomp;
        my ($scaffold, $len) = (split(/\s+|:/, $_, 6))[2, 4];
        $zone_len += $len;
        if ($zone_len <= 500000000) {
                say OU "$scaffold\t0\t$len";
        }else{
                $zone_num += 1;
                $zone_len = 0;
                $zone_len += $len;
                open OU, ">./bed.zone/A$zone_num.bed";
                say OU "$scaffold\t0\t$len";
        }
}
close IN;
close OU;

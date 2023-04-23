#!/usr/bin/perl -w
use strict;
use v5.10;

open IN, "<$ARGV[0]";
my $bed_len = 0;
my $zone_num = 1;
my $zone_bin = 50000000;

`mkdir -p bed.zone`;
open OU, ">./bed.zone/A$zone_num.bed";

while (<IN>) {
        next if /HD/;
        chomp;
        my ($scaffold, $scaffold_len) = (split(/\s+|:/, $_, 6))[2, 4];
        my $count = int($scaffold_len/$zone_bin);    # 区间个数
        foreach my $index (0..$count) {
                my $start=$zone_bin*$index+1;
                my $end=$zone_bin*$index + $zone_bin;
                if ($end > $scaffold_len) {
                         $end=$scaffold_len;
                }
                say OU "$scaffold\t$start\t$end";
                $bed_len+=($end-$start+1); 

                if ($bed_len >= $zone_bin){   # 判断区间长度是否溢出
                        close OU;
                        $bed_len = 0;
                        $zone_num++;
                        open OU, ">./bed.zone/A$zone_num.bed";
                }
        }
}
close OU;

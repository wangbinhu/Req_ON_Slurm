#!/usr/bin/perl -w
use strict;

die "perl $0 <sample_list.ll> <plink_K_result.txt>\n" unless @ARGV==2;
my $samplelist_file = shift;
my $frappe_file = shift;

open (A_,$frappe_file) || die $!; # frappe result
my %result;
while(<A_>){
	chomp;
	my ($index,$value) = split(/:/);
	my $id = (split(/\s+/,$index))[0];
	$result{$id} = $value;
}
close A_;

open (B_,$samplelist_file) || die $!; # sample list
while(<B_>){
	chomp;
	my ($label,$index) = split(/\s+/);
	print $label;
	my @words = split(/\s+/,$result{$index});
	for(my $i=1;$i<=$#words;$i++){
		print "\t",$words[$i];
	}
	print "\n";
}
close B_;

#!/usr/bin/perl
use strict;
use warnings;
#edit by heweiming 2009-10-23
die"Version 1.0\t2009-09-14;\nUsage: $0 <addref.list><map.out><ped.out>\n" unless (@ARGV==3);


open (List, "$ARGV[0]")  || die "Can't open input file:$!\n";
open (OT1, ">$ARGV[1]") || die "Can't open output file1: $!\n"; ## The .map file;
open (OT2, ">$ARGV[2]") || die "Can't open output file2: $!\n"; ## The .ped file;

my %iupac = (
             "A" => "a a",
			 "C" => "c c",
			 "G" => "g g",
			 "T" => "t t",
             "M" => "a c", 
             "K" => "g t",   
			 "Y" => "c t",
			 "R" => "a g", 
			 "W" => "a t", 
			 "S" => "c g",
			 "-" => "n n",
			 "N" => "n n",
);

my @rows=(); ##Store each lines;
my $j = 0;


while($_=<List>)
{
    chomp ; 
    my $file=$_ ;
    open (IN ,"$file") || die "$!" ;
    while ($_=<IN>) { #begin with the second line;
        chomp;
    	my @temp_array = split /\s+/;
    	my $chr        = shift @temp_array ;
    	my $pos        = shift @temp_array ;
#	my @str_array  = split /\s+/, $temp_array[2];
	my $str        = join "\t", @temp_array ;
	foreach  (keys %iupac)
    {
	$str =~ s/$_/$iupac{$_}/g;
	}

    my %array = ('A' => 0, 'C' => 0, 'T' => 0, 'G' => 0,);
    $array{'A'} += $str =~ s/a/A/g;
	$array{'C'} += $str =~ s/c/C/g;
	$array{'T'} += $str =~ s/t/T/g;
	$array{'G'} += $str =~ s/g/G/g;
                   $str =~ s/n/N/g;
	my @keys;
	my @count;
	
    foreach  (sort { $array{$b} <=> $array{$a} } keys %array) 
    {
		push @keys, $_;
		push @count, $array{$_};
	}


    next if ($count[2] != 0); ##there are three alleles;
	next if ($count[1] == 0); ##This is not SNP.  
	

	$str =~ s/A/1/g;
	$str =~ s/C/2/g;
	$str =~ s/G/3/g;
	$str =~ s/T/4/g;
	$str =~ s/-/0/g;
	$str =~ s/N/0/g;

        my @t    = split(/\s+/ , $str); 
        # print @t ,"\t" ; 
        shift  @t;
        shift  @t;
		my $num  = @t;
        #print @t ,"\t" ; exit ;
        print OT1 "1\t$j\t0\t$pos\n"; # Marker ID and its position;

	if ($j == 0)
    { ## The first qualified line;
        for (my $i = 0; $i < $num ; $i+=2)
        {
	        my $k = $i/2;
	        my $id=$k+1;
            $rows[$k] = "$id\t$id\t0\t0\t0\t0"."\t$t[$i] $t[$i+1]";
        } 
        #exit (1);
    }
    else
    {
        for (my $i = 0; $i < $num ; $i+=2) 
        {
            my $k = $i/2;
            $rows[$k]="$rows[$k]\t$t[$i] $t[$i+1]";
        }
#        exit (1);
    }
        $j++;
}
close IN ;
}
close List ;

    foreach (@rows)
    {
    print OT2 "$_\n";
    }
close IN;
close OT1;
close OT2;

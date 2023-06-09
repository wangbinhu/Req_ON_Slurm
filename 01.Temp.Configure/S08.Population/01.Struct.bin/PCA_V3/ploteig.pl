#!/usr/bin/perl  -w 

### ploteig -i eigfile -p pops -c a:b [-t title] [-s stem] [-o outfile] [-x] [-k]  [-y] [-z sep]
use Getopt::Std ;
use File::Basename ;
#edit by HeWeiMing;   Thu Jan  6 20:43:45 CST 2010
##Version 1.0    hewm@genomics.org.cn
## pops : separated  -x = make postscript and pdf  -z use another separator
##  -k keep intermediate files
## NEW if pops is a file names are read one per line

getopts('i:o:p:c:s:d:z:t:b:y:xk',\%opts) ;
$postscmode = $opts{"x"} ;
$opts{"y"} ||= "outside" ;
$oldkeystyle =  $opts{"y"} ;
$kflag = $opts{"k"} ;
$keepflag = 1 if ($kflag) ;
$keepflag = 1 unless ($postscmode) ;

$zsep = ":" ;
if (defined $opts{"z"}) {
 $zsep = $opts{"z"} ;
 $zsep = "\+" if ($zsep eq "+") ;
}

$title = "" ;
if (defined $opts{"t"}) {
 $title = $opts{"t"} ;
}
if (defined $opts{"i"}) {
 $infile = $opts{"i"} ;
}
else {
 usage() ;
 exit 0 ;
}
open (FF, $infile) || die "can't open $infile\n" ;
@L = (<FF>) ;
chomp @L ;
$nf = 0 ;
foreach $line (@L) { 
 next if ($line =~ /\#/) ;
 @Z = split " ", $line ;
 $x = @Z ;
 $nf = $x if ($nf < $x) ;
}
close FF;
printf "## number of fields: %d\n", $nf ;
$popcol = $nf-1 ;


if (defined $opts{"p"}) {
 $pops = $opts{"p"} ;
}
else {
 die "p parameter compulsory\n" ;
}

$popsname = setpops ($pops) ;
print "$popsname\nLove you hewm\@genomics.org.cn\n" ;

$c1 = 1; $c2 =2 ;
if (defined $opts{"c"}) {
 $cols = $opts{"c"} ;
 ($c1, $c2) = split ":", $cols ;
 die "bad c param: $cols\n" unless (defined $cols) ;
}

$stem = "$infile.$c1:$c2" ;
if (defined $opts{"s"}) {
 $stem = $opts{"s"} ;
}
$gnfile = "$stem.$popsname.xtxt" ;
 
if (defined $opts{"o"}) {
 $gnfile = $opts{"o"} ;
}
 $opts{"p"}||=3 ;
my $border=$opts{"b"} ;

@T = () ; ## trash 
open (GG, ">$gnfile") || die "can't open $gnfile\n" ;
print GG "## " unless ($postscmode) ;
print GG "set terminal postscript color\n" ;
print GG "set xtics nomirror\nset ytics nomirror\n" ;
#print GG "unset x2tics\nunset y2tics\n";
print GG "set border $border\n" ;
print GG "set title  \"$title\" \n" ; 
print GG "set key $oldkeystyle\n" ; 
print GG "set xlabel  \"Principal component $c1\" \n" ; 
print GG "set ylabel  \"Principal component $c2\" \n" ; 
#print GG "set xlabel  \"eigenvector $c1\" \n" ; 
#print GG "set ylabel  \"eigenvector $c2\" \n" ; 
print GG "plot " ;
$np = @P ;
$lastpop = $P[$np-1] ;
$d1 = $c1+1 ;
$d2 = $c2+1 ;
foreach $pop (@P)  { 
 $dfile = "$stem:$pop" ;
 push @T, $dfile ;
 print GG " \"$dfile\" using $d1:$d2 title \"$pop\" " ;
 print GG ", \\\n" unless ($pop eq $lastpop) ;
 open (YY, ">$dfile") || die "can't open $dfile\n" ;
 foreach $line (@L) {
  next if ($line =~ /\#/) ;
  @Z = split " ", $line ;
  next unless (defined $Z[$popcol]) ;
  next unless ($Z[$popcol] eq $pop) ;
  print YY "$line\n" ;
 }
 close YY ;
}
print GG "\n" ;
print GG "## "  if ($postscmode) ;
print GG "pause 9999\n"  ;
close GG ;

if ($postscmode) { 
$psfile = "$stem.ps" ;

 if ($gnfile =~ /xtxt/) { 
  $psfile = $gnfile ;
  $psfile  =~ s/xtxt/ps/ ;
 }

#my $bingnuplot="/share/project005/xuxun/heweiming/bin/gnuplot/bin/gnuplot";
#my $bingnuplot="/usr/bin/gnuplot";

 my  $bingnuplot="/usr/local/bin/gnuplot" ;
     $bingnuplot="/usr/bin/gnuplot" unless (-e $bingnuplot);
     $bingnuplot="/opt/blc/genome/biosoft/gnuplot-4.4.0/bin/gnuplot" unless (-e $bingnuplot);


##  $bingnuplot="/usr/bin/gnuplot" 
my $pdffile=$psfile; 
$pdffile =~s/ps/pdf/ ;
system ( "$bingnuplot < $gnfile > $psfile" ) ;
#system "perl fixgreen  $psfile" ;
system "ps2pdf  $psfile  $pdffile  " ;
}

unlink (@T) unless $keepflag ;

sub usage { 
 
print "ploteig -i eigfile -p pops -c a:b [-t title] [-s stem] [-o outfile] [-x] [-k]\n" ;  
print "-i eigfile     input file first col indiv-id last col population\n" ;
print "## as output by smartpca in outputvecs \n" ;
print "-c a:b         a, b columns to plot.  1:2 would be common and leading 2 eigenvectors\n" ;
print "-p pops        Populations to plot.  : delimited.   eg  -p Bantu:San:French\n" ;
print "## pops can also be a filename.  List populations 1 per line\n" ;
print "[-s stem]      stem will start various output files\n"  ;
print "[-o ofile]     ofile will be gnuplot control file.  Should have xtxt suffix\n"; 
print "[-x]           make ps and pdf files\n" ; 
print "[-k]           keep various intermediate files although  -x set\n" ;
print "## necessary if .xtxt file is to be hand edited\n" ;
print "[-y mode]     put key at top right  default(in) [outside]box [outside]\n" ;
print "[-b num]           how to plot the border (1,2,4,8,3,31 ) [3] \n" ;
print "[-t]           title (legend)\n" ;

print "The xtxt file is a gnuplot file and can be easily hand edited.  Intermediate files
needed if you want to make your own plot\n" ;

}
sub setpops {      
 my ($pops) = @_  ; 
 local (@a, $d, $b, $e) ; 

 if (-e $pops) {  
  open (FF1, $pops) || die "can't open $pops\n" ;
  @P = () ;
  foreach $line (<FF1>) { 
  ($a) = split " ", $line ;
  next unless (defined $a) ;
  next if ($a =~ /\#/) ;
  push  @P, $a ;
  }
  $out = join ":", @P ; 
  print "## pops: $out\n" ;
  ($b, $d , $e) = fileparse($pops) ;
  return $b ;
 }
 @P = split $zsep, $pops ;
 return $pops ;
}

################swimming in the sky and flying in the sea #######################

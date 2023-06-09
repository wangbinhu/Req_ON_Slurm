#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2010-09-29
BinDir=/zfssz5/BC_PS/heweiming/02.AD-hewmBin/02.PopBin/Population/TreeV3
#BinDir=$(cd "$(dirname "$0")"; pwd)
OUTDir=`pwd`
usage()
{
    echo "usage:sh $0 	p-Distance.mat	OUTDir"
}

pDis="33";

if [ $# -eq 2 ]
then
    pDis=$1
    OutDir=$2
elif [ $# -eq 1 ]
then
    pDis=$1
fi

if [ -s $pDis  ]; then
    :
else
    usage
    exit 1
fi


echo Start Time :
date
$BinDir/fneighbor	-datafile	$pDis	-outfile	$OUTDir/tree.out1.txt	-matrixtype	s	-treetype	n	-outtreefile	$OUTDir/tree.out2.tre
echo End Time :
date

###############  swimming in the sky and flying in the sea ###########

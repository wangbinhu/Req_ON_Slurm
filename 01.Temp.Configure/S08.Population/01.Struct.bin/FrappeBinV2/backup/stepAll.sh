#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2010-09-28
usage()
{
    echo "usage: $0 step[1..3] add_ref.list individual.txt  OUTDir"
    echo "usage: $0 1 "
}
OUTDir=`pwd`
Input=`pwd`/add_ref.list
Individual=`pwd`/individual.txt

SampleNum=50
step=1
BinDir=PPPWWWDDD

if [ $# -eq 4  ]
then    
    step=$1
    Input=$2
    Individual=$3
    OUTDir=$4
elif [ $# -eq 3 ]
then
    step=$1
    Input=$2
    Individual=$3
elif [ $# -eq 2 ]
then
    step=$1
    Input=$2
elif [ $# -eq 1 ]
then
    step=$1
else
    usage
    exit 1
fi

if [ -s $Input  ]; then
    :
else
    usage
    exit 1
fi

if [ -s $Individual  ]; then
    SampleNum=`wc -l  $Individual  |  awk ' { print $1 } '  | tr -d "\n" `
else
    usage
    exit 1
fi

echo Start Time : 
date
if [ $step -ne 3 ]
then
    perl  $BinDir/frappe.flow.pl	$Input   $SampleNum	$OUTDir/genotype.out	$OUTDir	$OUTDir/map.out	7	$step 
elif [[ $step -eq 3 ]] && [[ -s $Individual ]]
then
    perl  $BinDir/frappe.flow.pl	$Input   $SampleNum	$OUTDir/genotype.out	$OUTDir	$OUTDir/map.out	7	3   $Individual
else
    usage
    exit 1
fi
echo End Time : 
date

#############swimming in the sky and flying in the sea ############

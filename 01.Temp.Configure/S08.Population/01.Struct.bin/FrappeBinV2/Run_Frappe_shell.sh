#! /bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2010-09-29

usage()
{
    echo "usage: $0 individual.txt  add_ref.list    OutDir "
}

Add_Ref=`pwd`/add_ref.list
individual=`pwd`/individual.txt
OutDir=`pwd`
BinDir=/zfssz5/BC_PS/heweiming/02.AD-hewmBin/02.PopBin/Population/FrappeBin

if [ $# -eq 3 ] 
then
    Add_Ref=$2
    individual=$1
    OutDir=$3
elif [ $# -eq 2 ]
then
    Add_Ref=$2
    individual=$1
fi

if [ -s $individual  ]; then
    :
else
    usage
    exit 1
fi


if [ -s $Add_Ref  ]; then
    :
else
    usage
    exit 1
fi


if [ -s $OutDir  ]; then
    :
else
    usage
    exit 1
fi

echo Start Time : 
date
perl	$BinDir/Frappe_Flow.pl   $Add_Ref  $individual $OutDir
echo End Time : 
date

################ swimming in the sky  and flying in the sea #########

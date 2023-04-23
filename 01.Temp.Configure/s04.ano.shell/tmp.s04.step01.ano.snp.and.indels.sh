# ------------------------------------------------------------------------------------------------------------------------------ tmp.s04.step01.ano.snp.and.indels.sh:

# Input:
Raw_Vcf_Path=`realpath $S03_Step03_OU_PATH`

# Command:
find $Raw_Vcf_Path | grep Final.final_snp.vcf.gz$ > $S04_Step01_OU_PATH/snp.vcf.list
find $Raw_Vcf_Path | grep Final.final_indel.vcf.gz$ > $S04_Step01_OU_PATH/indel.vcf.list

$Python    $Python_Script    $S04_Step01_OU_PATH/snp.vcf.list      $REF    $REF_GFF    SNP       $S04_Step01_OU_PATH
$Python    $Python_Script    $S04_Step01_OU_PATH/indel.vcf.list    $REF    $REF_GFF    Indel     $S04_Step01_OU_PATH

date

/usr/bin/bash    $S04_Step01_OU_PATH/SNP/09.shell/*.step1.sh && \
/usr/bin/bash    $S04_Step01_OU_PATH/SNP/09.shell/step2.sh && \

/usr/bin/bash    $S04_Step01_OU_PATH/Indel/09.shell/Final.final_indel.step1.sh && \
/usr/bin/bash    $S04_Step01_OU_PATH/Indel/09.shell/step2.sh

echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
# ------------------------------------------------------------------------------------------------------------------------------ tmp.s04.step01.ano.snp.and.indels.sh

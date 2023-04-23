# ------------------------------------------------------------------------------------------------------------------------------tmp.s06.step01.bam.to.sv.sh 

mkdir    -p     $S06_Step01_OU_PATH/01.sample/${sample}/

$delly call -g $REF   $S06_Step01_IN_PATH/${sample}/${sample}.rmdup.sort.bam   -o   $S06_Step01_OU_PATH/01.sample/${sample}/${sample}.sv.bcf
$bcftools view $S06_Step01_OU_PATH/01.sample/${sample}/${sample}.sv.bcf  > $S06_Step01_OU_PATH/01.sample/${sample}/${sample}.sv.vcf

$bgzip    $S06_Step01_OU_PATH/01.sample/${sample}/${sample}.sv.vcf
$bcftools  index  $S06_Step01_OU_PATH/01.sample/${sample}/${sample}.sv.vcf.gz


cd    $S06_Step01_OU_PATH/01.sample/${sample}
$perl    $sv_counts    ${sample}.sv.vcf.gz
$md5sum    ${sample}.sv.vcf.gz   >  ${sample}.sv.vcf.gz.md5

echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";


# ------------------------------------------------------------------------------------------------------------------------------tmp.s06.step01.bam.to.sv.sh

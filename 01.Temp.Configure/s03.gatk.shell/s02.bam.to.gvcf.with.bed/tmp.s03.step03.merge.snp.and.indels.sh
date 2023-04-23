# ------------------------------ tmp.s03.step03.merge.snp.and.indels.sh

#  merge  snp.and.indels.sh
cd    $S03_Step03_OU_PATH    # fix

# merge snp:
snp_var=$(for i in `ls -d A*`; do echo -e "I=./$i/$i.final_snp.vcf.gz    \c"; done)
echo    $snp_var
$JAVA   -jar    $picard    MergeVcfs     $snp_var     O=Final.final_snp.vcf.gz
$vcf    Final.final_snp.vcf.gz
$md5sum   Final.final_snp.vcf.gz   >>  vcf.md5;

# merge indel:
indel_var=$(for i in `ls -d A*`; do echo -e "I=./$i/$i.final_indel.vcf.gz    \c"; done)
echo    $indel_var
$JAVA    -jar    $picard    MergeVcfs    $indel_var   O=Final.final_indel.vcf.gz
$vcf    Final.final_indel.vcf.gz
$md5sum   Final.final_indel.vcf.gz   >>  vcf.md5;


# date：
echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
# ------------------------------ tmp.s03.step03.merge.snp.and.indels.sh


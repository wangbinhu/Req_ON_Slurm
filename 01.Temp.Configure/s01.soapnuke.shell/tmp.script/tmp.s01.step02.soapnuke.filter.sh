# ------------------------------ tmp.s01.step02.soapnuke.fliter.sh
fq1=$S01_Step02_IN_PATH/${sample}.R1.fq.gz
fq2=$S01_Step02_IN_PATH/${sample}.R2.fq.gz

$SOAPnuke filter -l 12 -q 0.5 -n 0.1  -f AAGTCGGAGGCCAAGCGGTCTTAGGAAGACAA -r AAGTCGGATCGTAGCCATGTCGTTCTGTGAGCCAAGGAGTTG  -1 $fq1 -2 $fq2 -C ${sample}.clean.R1.fq.gz -D ${sample}.clean.R2.fq.gz  -o $S01_Step02_OU_PATH/${sample} -T 8

cd $S01_Step02_OU_PATH/${sample}
md5sum ${sample}.clean.R1.fq.gz  >>  $S01_Step02_OU_PATH/${sample}/${sample}.md5
md5sum ${sample}.clean.R2.fq.gz  >>  $S01_Step02_OU_PATH/${sample}/${sample}.md5

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
# ------------------------------ tmp.s01.step02.soapnuke.fliter.sh

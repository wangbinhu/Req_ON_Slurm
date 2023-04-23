echo -e "Start Time:    \c";date;  START_TIME=$SECONDS;

source /home/wangbinhu/01.Piepe.Line/01.raw.data.filter.and.summary/main.sh

fq1=$Step02_IN_PATH/${sample}.R1.fq.gz
fq2=$Step02_IN_PATH/${sample}.R2.fq.gz

source /ifswh1/BC_PUB/biosoft/BC_NQ/01.Soft/03.Soft_ALL/environment.sh&&/hwfswh2/BC_PUB/Software/03.Soft_ALL/SOAPnuke-2.1.0/SOAPnuke filter -l 20 -q 0.3 -n 0.01  -f AAGTCGGAGGCCAAGCGGTCTTAGGAAGACAA -r AAGTCGGATCGTAGCCATGTCGTTCTGTGAGCCAAGGAGTTG  -1 $fq1 -2 $fq2 -C ${sample}.clean.R1.fq.gz -D ${sample}.clean.R2.fq.gz  -o $Step02_OUT_PATH/${sample} -T 2

md5sum $Step02_OUT_PATH/${sample}/${sample}.clean.R1.fq.gz  >>  $Step02_OUT_PATH/${sample}/${sample}.md5.txt
md5sum $Step02_OUT_PATH/${sample}/${sample}.clean.R2.fq.gz  >>  $Step02_OUT_PATH/${sample}/${sample}.md5.txt

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";


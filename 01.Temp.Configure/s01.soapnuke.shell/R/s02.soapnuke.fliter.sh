# ------------------------------ sh.config
Main_WK_DIR=/ifswh1/BC_COM_P4/F21FTSSCKF9402/SUSnrzjR     # fix
Step02_IN_PATH=/ifswh1/BC_COM_P4/F21FTSSCKF9402/SUSnrzjR/01.raw.data    # fix
Step02_OUT_PATH=/ifswh1/BC_COM_P4/F21FTSSCKF9402/SUSnrzjR/02.process/01.clean.data.l12.q0.5.n0.1   # fix
# ------------------------------ sh.config
# ------------------------------ tmp.s02.soapnuke.fliter.sh
echo -e "Start Time:    \c";date;  START_TIME=$SECONDS;

fq1=$Step02_IN_PATH/${sample}.R1.fq.gz
fq2=$Step02_IN_PATH/${sample}.R2.fq.gz

source /ifswh1/BC_PUB/biosoft/BC_NQ/01.Soft/03.Soft_ALL/environment.sh&&/hwfswh2/BC_PUB/Software/03.Soft_ALL/SOAPnuke-2.1.0/SOAPnuke filter -l 12 -q 0.5 -n 0.1  -f AAGTCGGAGGCCAAGCGGTCTTAGGAAGACAA -r AAGTCGGATCGTAGCCATGTCGTTCTGTGAGCCAAGGAGTTG  -1 $fq1 -2 $fq2 -C ${sample}.clean.R1.fq.gz -D ${sample}.clean.R2.fq.gz  -o $Step02_OUT_PATH/${sample} -T 2

md5sum $Step02_OUT_PATH/${sample}/${sample}.clean.R1.fq.gz  >>  $Step02_OUT_PATH/${sample}/${sample}.md5.txt
md5sum $Step02_OUT_PATH/${sample}/${sample}.clean.R2.fq.gz  >>  $Step02_OUT_PATH/${sample}/${sample}.md5.txt

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
# ------------------------------ tmp.s02.soapnuke.fliter.sh


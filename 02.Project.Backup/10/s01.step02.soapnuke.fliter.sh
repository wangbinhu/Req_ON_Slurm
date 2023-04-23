# ------------------------------ sh.config
echo -e "Start Time: \c";  date;  START_TIME=$SECONDS;

Main_WK_DIR=/hwfssz4/BC_COM_P5/F21FTSSCKF9402/PELxszaR/10.F21FTSSCKF9402_MICexlqR     # fix
REF=$Main_WK_DIR/00.Ref/Ref.fa       # fix
# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:
S01_Step02_IN_PATH=$Main_WK_DIR/01.Filter/01.raw.data
S01_Step02_OU_PATH=$Main_WK_DIR/01.Filter/02.process/01.clean.data.l12.q0.5.n0.1
# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:



# ------------------------------ sh.config
# ------------------------------ tmp.s01.step02.soapnuke.fliter.sh
echo -e "Start Time:    \c";date;  START_TIME=$SECONDS;

fq1=$S01_Step02_IN_PATH/${sample}.R1.fq.gz
fq2=$S01_Step02_IN_PATH/${sample}.R2.fq.gz

source /ifswh1/BC_PUB/biosoft/BC_NQ/01.Soft/03.Soft_ALL/environment.sh&&/hwfswh2/BC_PUB/Software/03.Soft_ALL/SOAPnuke-2.1.0/SOAPnuke filter -l 12 -q 0.5 -n 0.1  -f AAGTCGGAGGCCAAGCGGTCTTAGGAAGACAA -r AAGTCGGATCGTAGCCATGTCGTTCTGTGAGCCAAGGAGTTG  -1 $fq1 -2 $fq2 -C ${sample}.clean.R1.fq.gz -D ${sample}.clean.R2.fq.gz  -o $S01_Step02_OU_PATH/${sample} -T 2

md5sum $S01_Step02_OU_PATH/${sample}/${sample}.clean.R1.fq.gz  >>  $S01_Step02_OU_PATH/${sample}/${sample}.md5.txt
md5sum $S01_Step02_OU_PATH/${sample}/${sample}.clean.R2.fq.gz  >>  $S01_Step02_OU_PATH/${sample}/${sample}.md5.txt

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
# ------------------------------ tmp.s01.step02.soapnuke.fliter.sh

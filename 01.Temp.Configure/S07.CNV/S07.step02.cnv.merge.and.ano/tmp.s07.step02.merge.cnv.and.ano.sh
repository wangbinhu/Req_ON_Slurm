# ------------------------------------------------------------------------------------------------------------------------------tmp.s07.step01.bam.to.cnv.sh 

cd    $S07_Step02_IN_PATH
cnv_var=$(for i in `ls -d *`; do echo -e "$S07_Step02_IN_PATH/$i/$i.cnv.vcf.gz    \c"; done)
$bcftools    merge    $cnv_var    -o    $S07_Step02_OU_PATH/CNV.merge.vcf
$bgzip    $S07_Step02_OU_PATH/CNV.merge.vcf


$iTools  Gfftools AnoVar  -Var  $S07_Step02_OU_PATH/CNV.merge.vcf.gz  -Gff  $REF_GFF  -OutPut  $S07_Step02_OU_PATH/CNV.merge.vcf.v1.ano.gz


perl    $AnoChangFormat    $S07_Step02_OU_PATH/CNV.merge.vcf.v1.ano.gz    $S07_Step02_OU_PATH/CNV.merge.vcf.v2.ano


perl    $Add_VCF_AnoVV    $S07_Step02_OU_PATH/CNV.merge.vcf.v2.ano    $S07_Step02_OU_PATH/CNV.merge.vcf.gz    $S07_Step02_OU_PATH/FinaCNV.vcf

echo $S07_Step02_OU_PATH/FinaCNV.vcf > $S07_Step02_OU_PATH/CNV.merge.vcf.gz.list

perl    $AnoStat    $S07_Step02_OU_PATH/CNV.merge.vcf.gz.list    >    $S07_Step02_OU_PATH/CNV.anno.stat 


# 统计CNV变异结果：

echo -e "Sample\tALL_CNV\tDEL\tDUP" > $S07_Step02_OU_PATH/CNV.stat

for sample in `ls -d */ `
do
dir=${sample:0:-1}
echo "$dir"
cd $dir
cat  $dir.stat |grep -v Sample >> $S07_Step02_OU_PATH/CNV.stat
cd ..
done


echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

# ------------------------------------------------------------------------------------------------------------------------------tmp.s07.step01.bam.to.cnv.sh 

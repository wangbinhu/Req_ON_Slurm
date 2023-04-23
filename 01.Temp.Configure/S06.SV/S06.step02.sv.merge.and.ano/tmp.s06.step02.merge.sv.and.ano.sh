# ------------------------------------------------------------------------------------------------------------------------------tmp.s06.step02.merge.sv.and.ano.sh 

cd    $S06_Step02_IN_PATH
sv_var=$(for i in `ls -d *`; do echo -e "$S06_Step02_IN_PATH/$i/$i.sv.vcf.gz    \c"; done)
$bcftools    merge    $sv_var    -o    $S06_Step02_OU_PATH/SV.merge.vcf
$bgzip   -c    $S06_Step02_OU_PATH/SV.merge.vcf > $S06_Step02_OU_PATH/SV.merge.vcf.gz

cd    $S06_Step02_OU_PATH
$iTools Gfftools AnoVar    -Var    $S06_Step02_OU_PATH/SV.merge.vcf.gz   -Gff   $REF_GFF   -OutPut   $S06_Step02_OU_PATH/SV.merge.vcf.v1.ano.gz

$perl    $AnoChangFormat    $S06_Step02_OU_PATH/SV.merge.vcf.v1.ano.gz    $S06_Step02_OU_PATH/SV.merge.vcf.v2.ano


$perl    $Add_VCF_AnoVV    $S06_Step02_OU_PATH/SV.merge.vcf.v2.ano    $S06_Step02_OU_PATH/SV.merge.vcf.gz    $S06_Step02_OU_PATH/FinaSV.vcf

echo $S06_Step02_OU_PATH/FinaSV.vcf > $S06_Step02_OU_PATH/SV.merge.vcf.gz.list

$perl   $Add_VCF_AnoVV   $S06_Step02_OU_PATH/SV.merge.vcf.gz.list   >   $S06_Step02_OU_PATH/SV.anno.stat 

# 统计SV变异结果：

echo -e "Sample\tALL_SV\tDEL\tDUP\tINS\tINV\tBND" > $S06_Step02_OU_PATH/SV.stat

cd   $S06_Step02_IN_PATH
for sample in `ls -d */ `
do
dir=${sample:0:-1}
echo "$dir"
cd $dir
cat  $dir.stat |grep -v Sample >> $S06_Step02_OU_PATH/SV.stat
cd ..
done

echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

# ------------------------------------------------------------------------------------------------------------------------------tmp.s06.step02.merge.sv.and.ano.sh 

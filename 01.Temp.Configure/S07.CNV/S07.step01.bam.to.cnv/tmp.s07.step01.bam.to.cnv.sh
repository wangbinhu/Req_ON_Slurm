# ------------------------------------------------------------------------------------------------------------------------------tmp.s07.step01.bam.to.cnv.sh

mkdir -p   $S07_Step01_OU_PATH/01.sample/${sample};

var_chrom=$(cat $REF_DC |grep -v HD |awk -F ':' '{print $2}' |awk -F'\t' '{print $1}' |xargs)

# step01:  从bam文件中提取比对上的reads信息
$cnvnator    -root    $S07_Step01_OU_PATH/01.sample/${sample}/file.root    -tree    $S07_Step01_IN_PATH/${sample}/${sample}.rmdup.sort.bam     -chrom    $var_chrom

# step02:  生成read depth分布图
$cnvnator    -root    $S07_Step01_OU_PATH/01.sample/${sample}/file.root    -his    1000    -d     genome/  -chrom    $var_chrom
# step03:  计算统计结果
$cnvnator    -root    $S07_Step01_OU_PATH/01.sample/${sample}/file.root    -stat   1000     -chrom    $var_chrom
# step04:  RD信号分割
$cnvnator    -root    $S07_Step01_OU_PATH/01.sample/${sample}/file.root    -partition    1000    -chrom    $var_chrom
# step05:  拷贝数变异检测
$cnvnator    -root    $S07_Step01_OU_PATH/01.sample/${sample}/file.root    -call         1000    -chrom    $var_chrom > $S07_Step01_OU_PATH/01.sample/${sample}/${sample}.cnv.call.txt
# step06:  转化为vcf，如果是conda安装，没有这个脚本，需要从GitHub上下载

cd  $S07_Step01_OU_PATH/01.sample/${sample}
$perl    $cnvnator2VCF  -prefix ${sample}    ${sample}.cnv.call.txt    genome    >    $S07_Step01_OU_PATH/01.sample/${sample}/${sample}.cnv.vcf
$bgzip    -f    $S07_Step01_OU_PATH/01.sample/${sample}/${sample}.cnv.vcf
$bcftools    index    -f   $S07_Step01_OU_PATH/01.sample/${sample}/${sample}.cnv.vcf.gz

$perl    $cnv_counts    ${sample}.cnv.vcf.gz
$md5sum    ${sample}.cnv.vcf.gz   >  ${sample}.cnv.vcf.gz.md5

echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

# ------------------------------------------------------------------------------------------------------------------------------tmp.s07.step01.bam.to.cnv.sh

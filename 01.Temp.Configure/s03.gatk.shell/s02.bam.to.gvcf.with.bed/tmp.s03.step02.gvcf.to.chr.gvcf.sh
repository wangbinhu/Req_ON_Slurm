# ------------------------------ tmp.s03.step02.gvcf.to.chr.gvcf.sh

mkdir    -p    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}
mkdir    -p    $S03_Step02_OU_PATH/Tmp/${sample}


cd     $S03_Step02_IN_PATH/01.sample
gvcf_var=$(for i in `ls -d *`; do echo -e "--variant    $S03_Step02_IN_PATH/01.sample/$i/$i.${sample}.gvcf.gz    \c"; done)
# echo    $gvcf_var
cd $S03_Step02_OU_PATH

# merge all sample gvcf to chr vcf:
$TIME    $JAVA    -XX:-UseGCOverheadLimit    -XX:ParallelGCThreads=8    -Xmx32G     -Djava.io.tmpdir=$S03_Step02_OU_PATH/Tmp/${sample}/    -jar    $GATK4    CombineGVCFs    -R    $REF    $gvcf_var    -O     $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.gvcf.gz

# filter gvcf:

$perl     $filter_gvcf    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.gvcf.gz    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.filtered.gvcf;
$bgzip    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.filtered.gvcf;
$tabix    -f     -p     vcf    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.filtered.gvcf.gz;

## gvcf    to    vcf
$TIME    $JAVA    -XX:-UseGCOverheadLimit    -XX:ParallelGCThreads=8    -Xmx32G     -Djava.io.tmpdir=$S03_Step02_OU_PATH/Tmp/${sample}/    -jar    $GATK4    GenotypeGVCFs    -R    $REF    --include-non-variant-sites    true    -V     $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.filtered.gvcf.gz    -O    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.vcf.gz

## filter    snps:
$TIME    $JAVA    -XX:-UseGCOverheadLimit    -XX:ParallelGCThreads=8    -Xmx32G     -Djava.io.tmpdir=$S03_Step02_OU_PATH/Tmp/${sample}/    -jar    $GATK4    SelectVariants    -R    $REF    -V    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.vcf.gz    --select-type-to-include    SNP    -O    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.snp.vcf.gz

$TIME    $JAVA    -XX:-UseGCOverheadLimit    -XX:ParallelGCThreads=8    -Xmx32G     -Djava.io.tmpdir=$S03_Step02_OU_PATH/Tmp/${sample}/    -jar    $GATK4    VariantFiltration    -R    $REF    -V    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.snp.vcf.gz    -O    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.filt_snp.vcf.gz    --filter-name    "FIRSTOK"    --filter-expression    "QD>=2.0     &&   QUAL>=30.0    &&    FS<=60.0    &&    MQ>=40.0    &&    MQRankSum>=-12.5    &&    ReadPosRankSum>=-8.0"


$TIME    perl    $filter_flag_ok    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.filt_snp.vcf.gz    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.final_snp.vcf
$bgzip   -f     $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.final_snp.vcf;
$tabix   -f    -p    vcf   $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.final_snp.vcf.gz;


# # filter    indels:
$TIME    $JAVA    -XX:-UseGCOverheadLimit    -XX:ParallelGCThreads=8    -Xmx32G     -Djava.io.tmpdir=$S03_Step02_OU_PATH/Tmp/${sample}/    -jar    $GATK4    SelectVariants    -R    $REF    -V    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.vcf.gz    --select-type-to-include    INDEL    -O    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.indel.vcf.gz

$TIME    $JAVA    -XX:-UseGCOverheadLimit    -XX:ParallelGCThreads=8    -Xmx32G     -Djava.io.tmpdir=$S03_Step02_OU_PATH/Tmp/${sample}/    -jar    $GATK4    VariantFiltration    -R    $REF    -V    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.indel.vcf.gz    -O    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.filt_indel.vcf.gz    --filter-name    "FIRSTOK"    --filter-expression    "QD>=2.0     &&   QUAL>=30.0    &&    FS<=200.0    &&    ReadPosRankSum>=-20.0"


$perl    $filter_flag_ok    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.filt_indel.vcf.gz    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.final_indel.vcf
$bgzip   -f    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.final_indel.vcf;
$tabix   -f   -p    vcf    $S03_Step02_OU_PATH/01.all.bed.chr/${sample}/${sample}.final_indel.vcf.gz;


# date：
echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
# ------------------------------ tmp.s03.step02.gvcf.to.chr.gvcf.sh


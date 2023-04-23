# ---------------------------------------------------------------------------------- 00.Pre.Population:


ln -s $S03_Step03_OU_PATH/Final.final_snp.vcf.gz .
ln -s $S03_Step03_OU_PATH/Final.final_snp.vcf.gz.tbi .
cd    $S08_Step00_OU_PATH/

#  =============================================  fixed regoin:
$vcftools    --gzvcf  Final.final_snp.vcf.gz    --max-missing   0.9     --maf 0.05    --min-meanDP  23   --recode --recode-INFO-all    --out  vcftools.misss01.maf005.minDP3
$bcftools    view  -m2 -M2     vcftools.misss01.maf005.minDP3.recode.vcf    -Oz    -o    vcftools.misss01.maf005.minDP3.bi-allele.vcf.gz;
#  =============================================  fixed regoin

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
# ---------------------------------------------------------------------------------- 00.Pre.Population


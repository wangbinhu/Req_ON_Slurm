
in_vcf=$S08_Step00_OU_PATH/vcftools.misss01.maf005.minDP3.bi-allele.vcf.gz

#  =============================================  fixed regoin:
perl     $PreVCFAdmix  -InFile    $in_vcf    -OutPut     SNP.ID.vcf
# perl    $keep_chrom    SNP.ID.vcf    SNP.ID.CHROM.v2.vcf    24
$plink2  --vcf   SNP.ID.vcf   --dog       --make-bed     -out    plink                               
#  =============================================  fixed regoin

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";


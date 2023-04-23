cd    $S08_Step02_OU_PATH    
ln -s $S08_Step00_OU_PATH/vcftools.misss01.maf005.minDP3.bi-allele.vcf.gz         SNP.vcf.gz
ln -s $S08_Step00_OU_PATH/vcftools.misss01.maf005.minDP3.bi-allele.vcf.gz.csi     SNP.vcf.gz.csi
#  =============================================  fixed regoin:
#Step    1:    calculate    p-distance    using    VCF2dis
$VCF2Dis       -InPut      SNP.vcf.gz    -OutPut    01.p_dis.mat
#Step    2:    construct    phylogenetic    tree    by    the    neighbor-joining    method    using    phylipnew
$fneighbor    -datafile    01.p_dis.mat    -outfile    02.tree.out    -matrixtype    s    -treetype    n    -outtreefile    03.tree.out.tre
#  =============================================  fixed regoin

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

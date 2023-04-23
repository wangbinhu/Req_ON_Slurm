cd    $S08_Step04_OU_PATH/
ln -s $S08_Step00_OU_PATH/vcftools.misss01.maf005.minDP3.bi-allele.chr.vcf.gz          SNP.vcf.gz                              # fix
ln -s $S08_Step00_OU_PATH/vcftools.misss01.maf005.minDP3.bi-allele.chr.vcf.gz.csi      SNP.vcf.gz.csi                          # fix

# touch groups var list:
# Group_List=(G1 G2 G3);
str=''
for i in ${Group_List[@]};do str=$str:$i; done
new_str=` echo  $str|sed 's/^://g' `
# echo $new_str


# 修改vcf染色体编号方式为0-1，并为文件添加ID
$perl     $PreVCFPCA  -InFile    SNP.vcf.gz   -OutPut     SNP.ID.vcf
$plink_19    --vcf    SNP.ID.vcf   --make-bed   --dog   --out     SNP.ID.CHROM                                                 # fix: --chr-set
$gcta64    --make-grm    --bfile  SNP.ID.CHROM       --autosome-num 24    --out  SNP.ID.CHROM.gcta                             # fix: --autosome-num
$gcta64     --grm     SNP.ID.CHROM.gcta    --pca    20    --out     SNP.ID.CHROM.gcta
cat     $Main_Script_DIR/00.Bin.Cofigure.Start/lib.name.group.table  | grep -v ^lib | awk '{print $2 $3}' >  $S08_Step04_OU_PATH/id.group.table 
$perl $PCA_V3/DealResult.pl     SNP.ID.CHROM.gcta.eigenvec     id.group.table     Data                                         # fix id.group.table
$perl $PCA_V3/ploteig.pl -i     Data -c 1:2 -o     PCA1_2.out -p $new_str -x -s     PCA1_2 -y outside -b 3        # fix -p
$perl $PCA_V3/ploteig.pl -i     Data -c 1:3 -o     PCA1_3.out -p $new_str -x -s     PCA1_3 -y outside -b 3        # fix -p
$perl $PCA_V3/ploteig.pl -i     Data -c 2:3 -o     PCA2_3.out -p $new_str -x -s     PCA2_3 -y outside -b 3        # fix -p

# # id.group.table:
# Y52B    AnHui
# Y53B    AnHui
# Y55B    JiangXi
# Y56A    JiangXi

#  =============================================  modify regoin


#  =============================================  fixed regoin:
$perl $PCA_V3/new_3DPCA.pl    -input    Data    -output     PCA3D
#  =============================================  fixed regoin


echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

cd    $S08_Step01_OU_PATH
ln -s $S08_Step00_OU_PATH/vcftools.misss01.maf005.minDP3.bi-allele.chr.vcf.gz .
ln -s $S08_Step00_OU_PATH/vcftools.misss01.maf005.minDP3.bi-allele.chr.vcf.gz.csi .
cp    $Main_Script_DIR/lib.name.group.table    .

#  =============================================  fixed regoin:
$python $split_to_list_py

for Breed in ${Group_List[@]}
do

    $bcftools     view      -S    $Breed.list    vcftools.misss01.maf005.minDP3.bi-allele.chr.vcf.gz    -O z    -o     $Breed.vcf.gz
    $bcftools     index     -t    $Breed.vcf.gz
    $PopLDdecay   -InVCF    $Breed.vcf.gz    -OutStat    $Breed.Lddecay
    perl    $Plot_OnePop    -inFile     $Breed.Lddecay.stat.gz -output    ./$Breed
done
cp     $Main_Script_DIR/01.Temp.Configure/S08.Population/S08.Step01.LD.Decay/S08.Step01.Plot.LD.Decay.r    ./
#  =============================================  fixed regoin


echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

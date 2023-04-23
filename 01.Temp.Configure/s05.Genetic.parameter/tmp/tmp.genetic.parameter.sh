# -----------------------------------  tmp.genetic.parameter.sh
End_SNP=$S03_Step03_OU_PATH/Final.final_snp.vcf.gz

# 00.group:

# touch group.list:
cd    $S05_Step01_OU_PATH/00.Group/;
echo "Now 00.Group:";

# ln file：
ln    -s    $End_SNP     $S05_Step01_OU_PATH/00.Group/.

# END_SNP_filter:
$bcftools    view  -m2 -M2     $End_SNP    -Oz    -o    $S05_Step01_OU_PATH/00.Group/END.pre_filter.vcf.gz;
$vcftools    --gzvcf    $S05_Step01_OU_PATH/00.Group/END.pre_filter.vcf.gz    --min-meanDP  2    --recode --recode-INFO-all    --max-missing 0.6    --stdout | $bcftools view -Oz -o $S05_Step01_OU_PATH/00.Group/END.vcf.gz;
$bcftools    index    $S05_Step01_OU_PATH/00.Group/END.vcf.gz;

$Python    $S05_Step01_OU_PATH/00.Group/split.to.list.py    group.index.table;
# split total vcf to group vcf
for Breed in ${Group_List[@]};
do
$bcftools    view    -S    $Breed.list  -m2 -M2    $S05_Step01_OU_PATH/00.Group/END.vcf.gz    -Oz    -o    $S05_Step01_OU_PATH/00.Group/$Breed.pre_filter.vcf.gz;
$vcftools    --gzvcf    $S05_Step01_OU_PATH/00.Group/$Breed.pre_filter.vcf.gz    --min-meanDP  2    --recode --recode-INFO-all    --max-missing 0.6    --out    $S05_Step01_OU_PATH/00.Group/$Breed;  #--max-missing 0.4    --maf 0.05
mv    $S05_Step01_OU_PATH/00.Group/$Breed.recode.vcf    $S05_Step01_OU_PATH/00.Group/$Breed.vcf;
$bgzip    $S05_Step01_OU_PATH/00.Group/$Breed.vcf;
$bcftools    index    $S05_Step01_OU_PATH/00.Group/$Breed.vcf.gz;
done

# 01.PI
cd $S05_Step01_OU_PATH/01.PI;
echo "Now 01.PI:";

for Breed in ${Group_List[@]};
do
$vcftools    --gzvcf    $S05_Step01_OU_PATH/00.Group/$Breed.vcf.gz    --window-pi    10000    --out    $S05_Step01_OU_PATH/01.PI/$Breed.window-pi
done
$Python      $S05_Step01_OU_PATH/01.PI/compute.pi.py    >    pi.result


# 02.FST
cd $S05_Step01_OU_PATH/02.FST;
echo "Now 02.FST:"

Group_List_len=${#Group_List[@]};
for ((i=0;i<=(Group_List_len-1);i++))
do
    for((j=i+1;j<=(Group_List_len-1);j++))
    do
    $vcftools --gzvcf   $S05_Step01_OU_PATH/00.Group/END.vcf.gz --fst-window-size 10000 --weir-fst-pop $S05_Step01_OU_PATH/00.Group/${Group_List[$i]}.list --weir-fst-pop $S05_Step01_OU_PATH/00.Group/${Group_List[$j]}.list  --out $S05_Step01_OU_PATH/02.FST/${Group_List[$i]}.VS.${Group_List[$j]}.fst;
    done
done
$Python $S05_Step01_OU_PATH/02.FST/compute.fst.py > fst.result;


# 03.MAF.PIC
cd $S05_Step01_OU_PATH/03.MAF.PIC;
echo "Now 03.MAF.PIC:"

for Breed in ${Group_List[@]};
do
perl    $S05_Step01_OU_PATH/03.MAF.PIC/pic.s01.pl    $S05_Step01_OU_PATH/00.Group/$Breed.vcf.gz    $Breed.pic;
done
$Python     $S05_Step01_OU_PATH/03.MAF.PIC/compute.pic.py  >  pic.result;


# -------------------------------------------------------------

# 04.F.Ho
cd     $S05_Step01_OU_PATH/04.F.Ho;
echo "Now 04.F.Ho:"

for Breed in ${Group_List[@]}
do
$vcftools    --gzvcf    $S05_Step01_OU_PATH/00.Group/$Breed.vcf.gz   --het    --out    $Breed.het
perl    $S05_Step01_OU_PATH/04.F.Ho/F.Ho.pl   $Breed.het.het    $Breed.het.F.Ho;
done
$Python  $S05_Step01_OU_PATH/04.F.Ho/Compute.F.Ho.py

# Summary:
cd $S05_Step01_OU_PATH;
echo "Now  Summary:"

cp $S05_Step01_OU_PATH/02.FST/fst.result  .;
$Python  $S05_Step01_OU_PATH/Summary.py;

echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
# -----------------------------------  tmp.genetic.parameter.sh

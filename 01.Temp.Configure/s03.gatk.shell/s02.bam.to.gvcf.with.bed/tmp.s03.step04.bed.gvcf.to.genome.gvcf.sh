# ------------------------------------------------------------------------------------------------------------------------------tmp.s03.step04.bed.gvcf.to.genome.gvcf.sh 

# MkDIR:
mkdir    -p    $S03_Step04_OU_PATH/01.sample;

cd    $S03_Step04_IN_PATH/01.sample/${sample}
zcat  *.A01.* | head -n 100000 |grep "^#" > $S03_Step04_OU_PATH/01.sample/${sample}.gvcf
for i in `ls -1 *.gvcf.gz`;do zcat $i |grep -v "^#" >> $S03_Step04_OU_PATH/01.sample/${sample}.gvcf ;done

$bgzip    $S03_Step04_OU_PATH/01.sample/${sample}.gvcf
cd        $S03_Step04_OU_PATH/01.sample
$md5sum   ${sample}.gvcf.gz  >> $S03_Step04_OU_PATH/01.sample/${sample}.gvcf.gz.md5

# date：
echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

# ------------------------------------------------------------------------------------------------------------------------------tmp.s03.step04.bed.gvcf.to.genome.gvcf.sh 

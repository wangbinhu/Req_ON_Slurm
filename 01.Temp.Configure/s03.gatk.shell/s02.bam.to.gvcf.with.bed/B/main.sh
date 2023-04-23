# main.sh
source /hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline/gatk.shell/s02.bam.to.gvcf.with.bed/sh.config
# base environment:
mkdir    -p    $WK_DIR
mkdir    -p    $WK_DIR/01.bam.to.gvcf.with.bed;             # bam 文件到 单染色体  单个个体  gvcf;
mkdir    -p    $WK_DIR/02.gvcf.to.cgvcf;           # 单染色体  单个个体  gvcf   到 单染色体 所有个体gvcf；
mkdir    -p    $WK_DIR/03.cgvcf.to.snp.indel;      # 单染色体 所有个体gvcf 到 snp and indel;

# Step 01: 01.bam.to.gvcf.with.bed
mkdir    -p    $WK_DIR/01.bam.to.gvcf.with.bed/l01.log;
cat    $Script_DIR/sh.config    $Script_DIR/tmp.bam.to.gvcf.sh    > $WK_DIR/01.bam.to.gvcf.with.bed/bam.to.gvcf.sh;
cat    $Script_DIR/py.config    $Script_DIR/tmp.bam.to.gvcf.py    > $WK_DIR/01.bam.to.gvcf.with.bed/bam.to.gvcf.py;
cd    $WK_DIR/01.bam.to.gvcf.with.bed;
perl   $Script_DIR/format.bed.pl    $REF_DC;    # fix

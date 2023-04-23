# --------------------------------  main.sh

source    /hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline/sh.config
Main_Script_DIR=/hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline

# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:
# S01.step00: touch dir
mkdir -p $Main_WK_DIR/01.Filter/01.raw.data
mkdir -p $Main_WK_DIR/01.Filter/02.process/01.clean.data.l12.q0.5.n0.1
mkdir -p $Main_WK_DIR/01.Filter/02.process/l01.log

# S01.step01: touch in and cat script
cat    $Main_Script_DIR/py.config     $Main_Script_DIR/soapnuke.shell/tmp.script/tmp.s01.step01.ln.cat.py      >      $Main_Script_DIR/s01.step01.ln.cat.py
python3    $Main_Script_DIR/s01.step01.ln.cat.py >  $Main_Script_DIR/s01.step01.ln.cat.sh
cp    $Main_Script_DIR/s01.step01.ln.cat.sh  $Main_WK_DIR/01.Filter/01.raw.data/;

# S01.step02: soapnuke filter script
cat     $Main_Script_DIR/sh.config    $Main_Script_DIR/soapnuke.shell/tmp.script/tmp.s01.step02.soapnuke.filter.sh   >    $Main_Script_DIR/s01.step02.soapnuke.filter.sh
cp      $Main_Script_DIR/s01.step02.soapnuke.filter.sh     $Main_WK_DIR/01.Filter/02.process/;
cat     $Main_Script_DIR/py.config    $Main_Script_DIR/soapnuke.shell/tmp.script/tmp.s01.step02.soapnuke.filter.py    >    $Main_Script_DIR/s01.step02.soapnuke.filter.py
cp      $Main_Script_DIR/s01.step02.soapnuke.filter.py     $Main_WK_DIR/01.Filter/02.process/;
# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:


# ------------------------------------------------------------------------------------------------------------------------------ S02 clean to bam:
# S02.step00: touch dir
mkdir    -p    $Main_WK_DIR/02.bwa/01.sample;
mkdir    -p    $Main_WK_DIR/02.bwa/l01.log;

# S02.step01: touch script
cat    $Main_Script_DIR/sh.config    $Main_Script_DIR/bwa.shell/tmp.s02.step01.clean.to.dup.bam.sh    >    $Main_WK_DIR/02.bwa/s02.step01.clean.to.dup.bam.sh;
cat    $Main_Script_DIR/py.config    $Main_Script_DIR/bwa.shell/tmp.s02.step01.clean.to.dup.bam.py    >    $Main_WK_DIR/02.bwa/s02.step01.clean.to.dup.bam.py;
# ------------------------------------------------------------------------------------------------------------------------------ S02 clean to bam


# ------------------------------------------------------------------------------------------------------------------------------ S03 bam to gvcf:
mkdir    -p    $S03_Step01_OU_PATH
mkdir    -p    $S03_Step01_OU_PATH/bed.zone
mkdir    -p    $S03_Step01_OU_PATH/01.sample
mkdir    -p    $S03_Step01_OU_PATH/l01.log

# S03.step01:  bam to gvcf:
cat    $Main_Script_DIR/sh.config    $Main_Script_DIR/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.clean.to.dup.bam.sh    >    $S03_Step01_OU_PATH/s03.step01.clean.to.dup.bam.sh ;
cat    $Main_Script_DIR/py.config    $Main_Script_DIR/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.clean.to.dup.bam.py    >    $S03_Step01_OU_PATH/s03.step01.clean.to.dup.bam.py ;

cd     $S03_Step01_OU_PATH;
perl   $Main_Script_DIR/gatk.shell/s02.bam.to.gvcf.with.bed/format.bed.pl    $REF_DC;
cd     $S03_Step01_OU_PATH/bed.zone;
bash   $Main_Script_DIR/gatk.shell/s02.bam.to.gvcf.with.bed/format.bed.sh;

# S03.step02: bam to bed gvcf.snp.indel
mkdir  -p   $S03_Step02_OU_PATH/l01.log
cat    $Main_Script_DIR/sh.config    $Main_Script_DIR/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step02.gvcf.to.chr.gvcf.sh    >    $S03_Step02_OU_PATH/s03.step02.gvcf.to.chr.gvcf.sh ;
cat    $Main_Script_DIR/py.config    $Main_Script_DIR/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step02.clean.to.dup.bam.py    >    $S03_Step02_OU_PATH/s03.step02.gvcf.to.chr.gvcf.py ;

# S03.step03: merge snp and indels:
mkdir -p $S03_Step03_OU_PATH
cat    $Main_Script_DIR/sh.config    $Main_Script_DIR/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step03.merge.snp.and.indels.sh    >    $S03_Step03_OU_PATH/s03.step03.merge.snp.and.indels.sh ;


# ------------------------------------------------------------------------------------------------------------------------------ S03 bam to gvcf



# --------------------------------  main.sh

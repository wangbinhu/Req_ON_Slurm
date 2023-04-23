# --------------------------------  main.sh

source    /hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline/00.Bin.Cofigure.Start/sh.config
# Main_WK_DIR=/hwfssz4/BC_COM_P5/F21FTSSCKF9402/PELxszaR/52.F22KTSSCKF5710_SUSfjuvR.S30
Main_Script_DIR=/hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline


# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:
# S01.step00: touch dir
mkdir -p $Main_WK_DIR/01.Filter/01.raw.data
mkdir -p $Main_WK_DIR/01.Filter/02.process/01.clean.data.l12.q0.5.n0.1
mkdir -p $Main_WK_DIR/01.Filter/02.process/l01.log

# S01.step01: touch in and cat script
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config     $Main_Script_DIR/01.Temp.Configure/soapnuke.shell/tmp.script/tmp.s01.step01.ln.cat.py      >      $Main_WK_DIR/01.Filter/01.raw.data/s01.step01.ln.cat.py
python3    $Main_WK_DIR/01.Filter/01.raw.data/s01.step01.ln.cat.py >  $Main_WK_DIR/01.Filter/01.raw.data/s01.step01.ln.cat.sh;

# S01.step02: soapnuke filter script
cat     $Main_Script_DIR/00.Bin.Cofigure.Start/sh.config    $Main_Script_DIR/01.Temp.Configure/soapnuke.shell/tmp.script/tmp.s01.step02.soapnuke.filter.sh    >    $Main_WK_DIR/01.Filter/02.process/s01.step02.soapnuke.filter.sh
cat     $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/soapnuke.shell/tmp.script/tmp.s01.step02.soapnuke.filter.py    >    $Main_WK_DIR/01.Filter/02.process/s01.step02.soapnuke.filter.py
# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:



# ------------------------------------------------------------------------------------------------------------------------------ S02 clean to bam:
# S02.step00: touch dir
mkdir    -p    $Main_WK_DIR/02.bwa/01.sample;
mkdir    -p    $Main_WK_DIR/02.bwa/l01.log;

# S02.step01: touch script
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/sh.config    $Main_Script_DIR/01.Temp.Configure/bwa.shell/tmp.s02.step01.clean.to.dup.bam.sh    >    $Main_WK_DIR/02.bwa/s02.step01.clean.to.dup.bam.sh;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/bwa.shell/tmp.s02.step01.clean.to.dup.bam.py    >    $Main_WK_DIR/02.bwa/s02.step01.clean.to.dup.bam.py;
# ------------------------------------------------------------------------------------------------------------------------------ S02 clean to bam



# ------------------------------------------------------------------------------------------------------------------------------ S03 bam to gvcf:
mkdir    -p    $S03_Step01_OU_PATH
mkdir    -p    $S03_Step01_OU_PATH/bed.zone
mkdir    -p    $S03_Step01_OU_PATH/01.sample
mkdir    -p    $S03_Step01_OU_PATH/l01.log

# S03.step01:  bam.to.gvcf:
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/sh.config    $Main_Script_DIR/01.Temp.Configure/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.bam.to.gvcf.sh    >    $S03_Step01_OU_PATH/s03.step01.bam.to.gvcf.sh ;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.bam.to.gvcf.py    >    $S03_Step01_OU_PATH/s03.step01.bam.to.gvcf.py ;
# bam.to.gvcf.add:
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.bam.to.gvcf.apy    >    $S03_Step01_OU_PATH/s03.step01.bam.to.gvcf.apy ;


cd     $S03_Step01_OU_PATH;
perl   $Main_Script_DIR/01.Temp.Configure/gatk.shell/s02.bam.to.gvcf.with.bed/format.bed.pl    $REF_DC;
cd     $S03_Step01_OU_PATH/bed.zone;
bash   $Main_Script_DIR/01.Temp.Configure/gatk.shell/s02.bam.to.gvcf.with.bed/format.bed.sh;

# S03.step02: bam to bed gvcf.snp.indel
mkdir  -p   $S03_Step02_OU_PATH/l01.log
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/sh.config    $Main_Script_DIR/01.Temp.Configure/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step02.gvcf.to.chr.gvcf.sh    >    $S03_Step02_OU_PATH/s03.step02.gvcf.to.chr.gvcf.sh ;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step02.gvcf.to.chr.gvcf.py    >    $S03_Step02_OU_PATH/s03.step02.gvcf.to.chr.gvcf.py ;

# S03.step03: merge snp and indels:
mkdir -p $S03_Step03_OU_PATH
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/sh.config    $Main_Script_DIR/01.Temp.Configure/gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step03.merge.snp.and.indels.sh    >    $S03_Step03_OU_PATH/s03.step03.merge.snp.and.indels.sh ;
# ------------------------------------------------------------------------------------------------------------------------------ S03 bam to gvcf



# ------------------------------------------------------------------------------------------------------------------------------ S04 Ano snp and indels:
# S04 Ano snp and indels:
mkdir -p $S04_Step01_OU_PATH
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/sh.config    $Main_Script_DIR/01.Temp.Configure/s04.ano.shell/tmp.s04.step01.ano.snp.and.indels.sh    >    $S04_Step01_OU_PATH/s04.step01.ano.snp.and.indels.sh ;

# ------------------------------------------------------------------------------------------------------------------------------ S04 Ano snp and indels



# ------------------------------------------------------------------------------------------------------------------------------ S05 Genetic.parameter:
# touch dir:
mkdir -p $S05_Step01_OU_PATH/00.Group
mkdir -p $S05_Step01_OU_PATH/01.PI
mkdir -p $S05_Step01_OU_PATH/02.FST
mkdir -p $S05_Step01_OU_PATH/03.MAF.PIC
mkdir -p $S05_Step01_OU_PATH/04.F.Ho

cat    $Main_Script_DIR/00.Bin.Cofigure.Start/sh.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.genetic.parameter.sh    >    $S05_Step01_OU_PATH/genetic.parameter.sh;
# 00.Group:
cp     $Main_Script_DIR/00.Bin.Cofigure.Start/group.index.table    $S05_Step01_OU_PATH/00.Group/;
cp     $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/script/split.to.list.py    $S05_Step01_OU_PATH/00.Group/;

# 01.PI:
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.compute.pi.py     >    $S05_Step01_OU_PATH/01.PI/compute.pi.py;

# 02.FST:
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.compute.fst.py     >    $S05_Step01_OU_PATH/02.FST/compute.fst.py;

# 03.MAF.PIC:
cp     $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/script/pic.s01.pl    $S05_Step01_OU_PATH/03.MAF.PIC/pic.s01.pl;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.compute.pic.py     >    $S05_Step01_OU_PATH/03.MAF.PIC/compute.pic.py;

# 04.F.Ho:
cp     $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/script/F.Ho.pl    $S05_Step01_OU_PATH/04.F.Ho/F.Ho.pl;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.Compute.F.Ho.py     >    $S05_Step01_OU_PATH/04.F.Ho/Compute.F.Ho.py;

# Summay:
cp     $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/script/Summary.py     $S05_Step01_OU_PATH/Summary.py;
# ------------------------------------------------------------------------------------------------------------------------------ S05 Genetic.parameter


# --------------------------------  main.sh

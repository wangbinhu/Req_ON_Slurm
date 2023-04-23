# Reseq pipeline for Slurm systems
# Time： 2022-11-02 09:04
# Address: hefei JY


# --------------------------------  main.sh
echo -e "Start Time: \c";  date;  START_TIME=$SECONDS;

Main_Script_DIR=/public/home/bgiadmin/Software/10.User-defined/WBH/02.reseq.pipeline

source    /public/home/bgiadmin/Software/10.User-defined/WBH/02.reseq.pipeline/00.Bin.Cofigure.Start/sh.confi

# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:

# vcftools
export LD_PRELOAD=/public/software/compiler/gcc/gcc-9.3.0/lib64/libstdc++.so.6:$LD_PRELOAD
export PATH=/public/home/bgiadmin/Software/08.ReqTools/vcftools/bin:$PATH

# python：
export PATH=/public/home/bgiadmin/Software/Python/Python-3.8.5/bin:$PATH
export LD_LIBRARY_PATH=/public/home/bgiadmin/Software/Python/Python-3.8.5/lib:$LD_LIBRARY_PATH



# S01.step00: touch dir
mkdir -p $Main_WK_DIR/01.Filter/01.raw.data
mkdir -p $Main_WK_DIR/01.Filter/02.process/01.clean.data.l12.q0.5.n0.1
mkdir -p $Main_WK_DIR/01.Filter/02.process/l01.log

cat    $Main_Script_DIR/00.Bin.Cofigure.Start/sh.confi    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.g    >    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/py.confi    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.g    >    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config

# S01.step01: touch in and cat script
cat        $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config     $Main_Script_DIR/01.Temp.Configure/s01.soapnuke.shell/tmp.script/tmp.s01.step01.ln.cat.py      >    $Main_WK_DIR/01.Filter/01.raw.data/s01.step01.ln.cat.py
/public/home/bgiadmin/Software/Python/Python-3.8.5/bin/python3.8    $Main_WK_DIR/01.Filter/01.raw.data/s01.step01.ln.cat.py >  $Main_WK_DIR/01.Filter/01.raw.data/s01.step01.ln.cat.sh;

# S01.step02: soapnuke filter script
cat     $Main_Script_DIR/01.Temp.Configure/s01.soapnuke.shell/tmp.s01.step02.soapnuke.filter.header     $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/s01.soapnuke.shell/tmp.script/tmp.s01.step02.soapnuke.filter.sh    >    $Main_WK_DIR/01.Filter/02.process/s01.step02.soapnuke.filter.sh
cat     $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s01.soapnuke.shell/tmp.script/tmp.s01.step02.soapnuke.filter.py>    $Main_WK_DIR/01.Filter/02.process/s01.step02.soapnuke.filter.py
# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:


# ------------------------------------------------------------------------------------------------------------------------------ S02 clean to bam:
# S02.step00: touch dir
mkdir    -p    $Main_WK_DIR/02.bwa/01.sample;
mkdir    -p    $Main_WK_DIR/02.bwa/l01.log;

# S02.step01: touch script
cat    $Main_Script_DIR/01.Temp.Configure/s02.bwa.shell/tmp.s02.step01.clean.to.dup.bam.header   $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/s02.bwa.shell/tmp.s02.step01.clean.to.rmdup.bam.sh    >    $Main_WK_DIR/02.bwa/s02.step01.clean.to.rmdup.bam.sh;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s02.bwa.shell/tmp.s02.step01.clean.to.rmdup.bam.py      >    $Main_WK_DIR/02.bwa/s02.step01.clean.to.rmdup.bam.py;

# ------------------------------------------------------------------------------------------------------------------------------ S02 clean to bam

source /public/home/bgiadmin/Software/10.User-defined/WBH/02.reseq.pipeline/00.Bin.Cofigure.Start/.config/sh.config 

sed  -i '1i\echo -e "Start Time: \\c";  date;  START_TIME=$SECONDS;' /public/home/bgiadmin/Software/10.User-defined/WBH/02.reseq.pipeline/00.Bin.Cofigure.Start/.config/sh.config
sed -i '1s/^/\n\n/' /public/home/bgiadmin/Software/10.User-defined/WBH/02.reseq.pipeline/00.Bin.Cofigure.Start/.config/sh.config

# ------------------------------------------------------------------------------------------------------------------------------ S03 bam to gvcf:
mkdir    -p    $S03_Step01_OU_PATH
mkdir    -p    $S03_Step01_OU_PATH/bed.zone
mkdir    -p    $S03_Step01_OU_PATH/01.sample
mkdir    -p    $S03_Step01_OU_PATH/l01.log

# S03.step01:  bam.to.gvcf:
cat    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.bam.to.gvcf.header   $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.bam.to.gvcf.sh    >    $S03_Step01_OU_PATH/s03.step01.bam.to.gvcf.sh ;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.bam.to.gvcf.py    >    $S03_Step01_OU_PATH/s03.step01.bam.to.gvcf.py ;
# bam.to.gvcf.add:
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step01.bam.to.gvcf.apy    >    $S03_Step01_OU_PATH/s03.step01.bam.to.gvcf.apy ;


cd     $S03_Step01_OU_PATH;
perl   $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/format.bed.pl    $REF_DC;
cd     $S03_Step01_OU_PATH/bed.zone;
bash   $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/format.bed.sh;

# S03.step02: bam to bed gvcf.snp.indel
mkdir  -p   $S03_Step02_OU_PATH/l01.log
cat    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step02.gvcf.to.chr.gvcf.header    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step02.gvcf.to.chr.gvcf.sh    >    $S03_Step02_OU_PATH/s03.step02.gvcf.to.chr.gvcf.sh ;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step02.gvcf.to.chr.gvcf.py    >    $S03_Step02_OU_PATH/s03.step02.gvcf.to.chr.gvcf.py ;

# S03.step03: merge snp and indels:
mkdir -p $S03_Step03_OU_PATH
cat    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step03.merge.snp.and.indels.header   $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step03.merge.snp.and.indels.sh    >    $S03_Step03_OU_PATH/s03.step03.merge.snp.and.indels.sh ;

# S03.step04: bed.gvcf.to.genome.gvcf:   2022-09-21 15:36
mkdir  -p   $S03_Step04_OU_PATH/l01.log
cat    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step03.bed.gvcf.to.genome.gvcf.header    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step04.bed.gvcf.to.genome.gvcf.sh    >    $S03_Step04_OU_PATH/s03.step04.bed.gvcf.to.genome.gvcf.sh ;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s03.gatk.shell/s02.bam.to.gvcf.with.bed/tmp.s03.step04.bed.gvcf.to.genome.gvcf.py    >    $S03_Step04_OU_PATH/s03.step04.bed.gvcf.to.genome.gvcf.py ;
# ------------------------------------------------------------------------------------------------------------------------------ S03 bam to gvcf



# ------------------------------------------------------------------------------------------------------------------------------ S04 Ano snp and indels:
# S04 Ano snp and indels:
mkdir -p $S04_Step01_OU_PATH
cat    $Main_Script_DIR/01.Temp.Configure/s04.ano.shell/tmp.s04.step01.ano.snp.and.indels.header   $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/s04.ano.shell/tmp.s04.step01.ano.snp.and.indels.sh    >    $S04_Step01_OU_PATH/s04.step01.ano.snp.and.indels.sh ;

# ------------------------------------------------------------------------------------------------------------------------------ S04 Ano snp and indels



# ------------------------------------------------------------------------------------------------------------------------------ S05 Genetic.parameter:
# touch dir:
mkdir -p $S05_Step01_OU_PATH/00.Group
mkdir -p $S05_Step01_OU_PATH/01.PI
mkdir -p $S05_Step01_OU_PATH/02.FST
mkdir -p $S05_Step01_OU_PATH/03.MAF.PIC
mkdir -p $S05_Step01_OU_PATH/04.F.Ho

cat    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.genetic.parameter.header    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.genetic.parameter.sh    >    $S05_Step01_OU_PATH/genetic.parameter.sh;
# 00.Group:
cp     $Main_Script_DIR/00.Bin.Cofigure.Start/lib.name.group.table    $S05_Step01_OU_PATH/00.Group/;
cp     $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/script/split.to.list.py    $S05_Step01_OU_PATH/00.Group/;

# 01.PI:
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.compute.pi.py     >    $S05_Step01_OU_PATH/01.PI/compute.pi.py;

# 02.FST:
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.compute.fst.py     >    $S05_Step01_OU_PATH/02.FST/compute.fst.py;

# 03.MAF.PIC:
cp     $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/script/pic.s01.pl    $S05_Step01_OU_PATH/03.MAF.PIC/pic.s01.pl;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.compute.pic.py     >    $S05_Step01_OU_PATH/03.MAF.PIC/compute.pic.py;

# 04.F.Ho:
cp     $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/script/F.Ho.pl    $S05_Step01_OU_PATH/04.F.Ho/F.Ho.pl;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/tmp/tmp.Compute.F.Ho.py     >    $S05_Step01_OU_PATH/04.F.Ho/Compute.F.Ho.py;

# Summay:
cp     $Main_Script_DIR/01.Temp.Configure/s05.Genetic.parameter/script/Summary.py     $S05_Step01_OU_PATH/Summary.py;
# ------------------------------------------------------------------------------------------------------------------------------ S05 Genetic.parameter


# ------------------------------------------------------------------------------------------------------------------------------ S06 SV and ano:

## s06.step01.bam.to.sv:
mkdir -p  $S06_Step01_OU_PATH
mkdir -p  $S06_Step01_OU_PATH/l01.log
mkdir -p  $S06_Step02_OU_PATH

cat    $Main_Script_DIR/01.Temp.Configure/S06.SV/S06.step01.bam.to.sv/tmp.s06.step01.bam.to.sv.header    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/S06.SV/S06.step01.bam.to.sv/tmp.s06.step01.bam.to.sv.sh     >    $S06_Step01_OU_PATH/s06.step01.bam.to.sv.sh ;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/S06.SV/S06.step01.bam.to.sv/tmp.s06.step01.bam.to.sv.py     >    $S06_Step01_OU_PATH/s06.step01.bam.to.sv.py ;

## s06.step02.merge.sv.and.ano:
cat    $Main_Script_DIR/01.Temp.Configure/S06.SV/S06.step02.sv.merge.and.ano/tmp.s06.step02.merge.sv.and.ano.header    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/S06.SV/S06.step02.sv.merge.and.ano/tmp.s06.step02.merge.sv.and.ano.sh     >    $S06_Step02_OU_PATH/s06.step02.merge.sv.and.ano.sh ;

# ------------------------------------------------------------------------------------------------------------------------------ S06 SV and ano


# ------------------------------------------------------------------------------------------------------------------------------ S07 CNV and ano:

## s06.step01.bam.to.cnv:
mkdir -p  $S07_Step01_OU_PATH
mkdir -p  $S07_Step01_OU_PATH/l01.log
mkdir -p  $S07_Step02_OU_PATH

cat    $Main_Script_DIR/01.Temp.Configure/S07.CNV/S07.step01.bam.to.cnv/tmp.s07.step01.bam.to.cnv.header    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/S07.CNV/S07.step01.bam.to.cnv/tmp.s07.step01.bam.to.cnv.sh     >    $S07_Step01_OU_PATH/s07.step01.bam.to.cnv.sh ;
cat    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/py.config    $Main_Script_DIR/01.Temp.Configure/S07.CNV/S07.step01.bam.to.cnv/tmp.s07.step01.bam.to.cnv.py     >$S07_Step01_OU_PATH/s07.step01.bam.to.cnv.py ;

## s06.step02.merge.cnv.and.ano:
cat    $Main_Script_DIR/01.Temp.Configure/S07.CNV/S07.step02.cnv.merge.and.ano/tmp.s07.step02.merge.cnv.and.ano.header    $Main_Script_DIR/00.Bin.Cofigure.Start/.config/sh.config    $Main_Script_DIR/01.Temp.Configure/S07.CNV/S07.step02.cnv.merge.and.ano/tmp.s07.step02.merge.cnv.and.ano.sh     >    $S07_Step02_OU_PATH/s07.step02.merge.cnv.and.ano.sh ;

# ------------------------------------------------------------------------------------------------------------------------------ S07 CNV and ano

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

# --------------------------------  main.sh

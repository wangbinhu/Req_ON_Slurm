# -*- coding: utf-8 -*-
import os
import sys


def prepare(VCFlist, ref, gff, vartype, outdir):
    readstream = open(VCFlist, 'r')
    vcf_list = readstream.readlines()
    readstream.close()
    iTools = '/public/home/bgiadmin/Software/08.ReqTools/iTools_Code/iTools'
    #Bin = '/public/home/bgiadmin/Software/10.User-defined/WBH/DNA_Reseq_One//07.RunGATK/'
    Bin = '/public/home/bgiadmin/Software/10.User-defined/WBH/DNA_Reseq_One/07.RunGATK/'
    # Bin2 = '/public/home/bgiadmin/Software/10.User-defined/WBH/DNA_Reseq_One//09.StatTable/'
    Bin2 = '/public/home/bgiadmin/Software/10.User-defined/WBH/DNA_Reseq_One/09.StatTable/'
    os.system('mkdir -p {outdir}/{vartype}/00.Anno {outdir}/{vartype}/01.Vcf  {outdir}/{vartype}/02.Genotype  {outdir}/{vartype}/03.Dis {outdir}/{vartype}/04.AnoStat {outdir}/{vartype}/09.shell'.format(outdir=outdir, vartype=vartype))
    if vartype == 'SNP':
        for vcf in vcf_list:
            vcf = vcf.rstrip('\n')
            name = os.path.basename(vcf).replace('filter3.', '').replace('.vcf', '')  #filter2.LG10.snp.vcf.gz --> LG10.snp
            outsh1 = '{outdir}/{vartype}/09.shell/{name}.step1.sh'.format(outdir=outdir, vartype=vartype, name=name)

            with open(outsh1,'w') as outf1:
                content = '''echo Start Time :
date
{iTools} Gfftools AnoVar -Var {vcf} -Gff {gff} -OutPut {outdir}/{vartype}/00.Anno/{name}.v1.anno.gz
perl {Bin}/AnoChangFormat.pl {outdir}/{vartype}/00.Anno/{name}.v1.anno.gz {outdir}/{vartype}/00.Anno/{name}.v2.anno
perl {Bin}/Add_VCF_AnoVV.pl {outdir}/{vartype}/00.Anno/{name}.v2.anno  {vcf}  {outdir}/{vartype}/01.Vcf/{name}.vcf
{iTools}  Formtools VCF2Genotype -InPut  {outdir}/{vartype}/01.Vcf/{name}.vcf -OutPut {outdir}/{vartype}/02.Genotype/{name}.gotmp.gz   -WithHeader
perl {Bin}/Add_Genotype_AnoVV.pl {outdir}/{vartype}/00.Anno/{name}.v2.anno {outdir}/{vartype}/02.Genotype/{name}.gotmp.gz {outdir}/{vartype}/02.Genotype/{name}.genotype
#rm  {outdir}/{vartype}/02.Genotype/{name}.gotmp.gz
perl  {Bin}/SNP_Dis.pl -bin 100000 -InSNP  {outdir}/{vartype}/02.Genotype/{name}.genotype -OutPut {outdir}/{vartype}/03.Dis/{name}
date
'''.format(iTools=iTools, vcf=vcf, gff=gff, Bin=Bin, outdir=outdir, vartype=vartype, name=name)
                outf1.write(content)
        outsh2 = '{outdir}/{vartype}/09.shell/step2.sh'.format(outdir=outdir, vartype=vartype)
        with open(outsh2,'w') as outf2:
            content = '''echo Start Time :
date
ls   {outdir}/{vartype}/02.Genotype/*.genotype  > {outdir}/{vartype}/04.AnoStat/genotype.list
perl {Bin2}/SNPStat.pl {outdir}/{vartype}/04.AnoStat/genotype.list {outdir}/{vartype}/04.AnoStat/01.allsnp
perl {Bin2}/CountBinBum.pl -InList {outdir}/{vartype}/04.AnoStat/genotype.list -OutPut {outdir}/{vartype}/04.AnoStat/04.SNP.dis
perl {Bin2}/plotBinMap_hewm.pl  -InPut {outdir}/{vartype}/04.AnoStat/04.SNP.dis -OutPut {outdir}/{vartype}/04.AnoStat/04.SNP.svg -Main SNP_Dis
cat  {outdir}/{vartype}/02.Genotype/*.genotype  |cut -f 1-3  > {outdir}/{vartype}/04.AnoStat/03.allCDS
{iTools} Gfftools  VarType -Format add_ref -Ref {ref} -Gff {gff} -SNP {outdir}/{vartype}/04.AnoStat/03.allCDS -OutDir {outdir}/{vartype}/04.AnoStat   > {outdir}/{vartype}/04.AnoStat/03.allCDS.stat
{iTools} Gfftools  AnoVar -Var {outdir}/{vartype}/04.AnoStat/03.allCDS -Gff {gff} -OutPut {outdir}/{vartype}/04.AnoStat/02.allsnp.anno.gz
#rm  {outdir}/{vartype}/04.AnoStat/03.allCDS.cds.gz
mkdir  {outdir}/{vartype}/04.AnoStat/05.LargeEff
perl  {Bin2}/large-effectSNPs.pl {outdir}/{vartype}/04.AnoStat/02.allsnp.anno.gz  {outdir}/{vartype}/04.AnoStat/03.allCDS.info.gz {outdir}/{vartype}/04.AnoStat/03.allCDS {outdir}/{vartype}/04.AnoStat/05.LargeEff/01.allsnp
#rm -rf {outdir}/{vartype}/04.AnoStat/03.allCDS
perl  {Bin2}/GetName_sys.pl {outdir}/{vartype}/04.AnoStat/01.allsnp.SNP.stat  {outdir}/{vartype}/04.AnoStat/03.allCDS.stat  > {outdir}/{vartype}/04.AnoStat/03.allCDS.statA
mv  {outdir}/{vartype}/04.AnoStat/03.allCDS.statA {outdir}/{vartype}/04.AnoStat/03.allCDS.stat
echo End Time :
date
'''.format(iTools=iTools, ref=ref, gff=gff, Bin2=Bin2, outdir=outdir, vartype=vartype)
            outf2.write(content)
    elif vartype == 'Indel':
        for vcf in vcf_list:
            vcf = vcf.rstrip('\n')
            name = os.path.basename(vcf).replace('filter.', '').replace('.vcf.gz', '')   #filter.LG10.indel.vcf.gz --> LG10.indel
            outsh1 = '{outdir}/{vartype}/09.shell/{name}.step1.sh'.format(outdir=outdir, vartype=vartype, name=name)
            with open(outsh1,'w')  as outf1:
                content = '''date
{iTools} Gfftools AnoVar -Var {vcf} -Gff {gff} -OutPut {outdir}/{vartype}/00.Anno/{name}.v1.anno.gz
perl {Bin}/AnoChangFormat.pl {outdir}/{vartype}/00.Anno/{name}.v1.anno.gz {outdir}/{vartype}/00.Anno/{name}.v2.anno
perl {Bin}/Add_VCF_AnoVV.pl {outdir}/{vartype}/00.Anno/{name}.v2.anno {vcf} {outdir}/{vartype}/01.Vcf/{name}.vcf
perl {Bin}/SNP_Dis.pl -bin 100000 -InSNP {outdir}/{vartype}/01.Vcf/{name}.vcf -OutPut {outdir}/{vartype}/03.Dis/{name}
date
'''.format(iTools=iTools, vcf=vcf, gff=gff, Bin=Bin, outdir=outdir, vartype=vartype, name=name)
                outf1.write(content)
        outsh2 = '{outdir}/{vartype}/09.shell/step2.sh'.format(outdir=outdir, vartype=vartype)
        with open(outsh2, 'w') as outf2:
            content = '''date
ls {outdir}/{vartype}/01.Vcf/*vcf  >  {outdir}/{vartype}/04.AnoStat/indel.vcf.list
perl  {Bin2}/02.Indel/02.Stat.pl  {outdir}/{vartype}/04.AnoStat/indel.vcf.list > {outdir}/{vartype}/04.AnoStat/01.indel.stat
perl {Bin2}/02.Indel/03.AnoStat.pl {outdir}/{vartype}/04.AnoStat/indel.vcf.list > {outdir}/{vartype}/04.AnoStat/02.indel.anno.stat
perl {Bin2}/02.Indel/04.StatDepth.pl {outdir}/{vartype}/04.AnoStat/indel.vcf.list {outdir}/{vartype}/04.AnoStat/03.indelDis
perl {Bin2}/CountBinBum.pl  -InList {outdir}/{vartype}/04.AnoStat/indel.vcf.list  -OutPut {outdir}/{vartype}/04.AnoStat/04.indel.dis
perl {Bin2}/plotBinMap_hewm.pl -InPut {outdir}/{vartype}/04.AnoStat/04.indel.dis -OutPut  {outdir}/{vartype}/04.AnoStat/04.indel.svg  InDel_Dis
date
'''.format(iTools=iTools, gff=gff, Bin2=Bin2, outdir=outdir, vartype=vartype)
            outf2.write(content)
    print('shell finished')


list1, reffa, refgff, vartag, wp = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5]


#prepare('snp.vcf.list','/zfssz4/BC_COM_P3/F19FTSCCKF0358/PEAajoR/01.ref/pear.revise.merge.fa','/zfssz4/BC_COM_P3/F19FTSCCKF0358/PEAajoR/01.ref/pear.revise.merge.gff','SNP','/zfssz4/BC_COM_P3/F19FTSCCKF0358/PEAajoR/03.population/05.anno/')
prepare(list1, reffa, refgff, vartag, wp)


# /zfssz5/BC_PS/heweiming/02.AD-hewmBin/03.NewShellFL/03.VarGATK/Run_add_Ano.pl


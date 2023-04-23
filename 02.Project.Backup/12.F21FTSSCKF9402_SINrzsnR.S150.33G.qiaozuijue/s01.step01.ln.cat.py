# ------------------------------ py.config

Main_WK_DIR='/hwfssz4/BC_COM_P5/F21FTSSCKF9402/PELxszaR/12.F21FTSSCKF9402_SINrzsnR.S150.33G.qiaozuijue'
Main_Script_DIR= '/hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline'

list_sample=["CZQ10A", "CZQ11A", "CZQ12A", "CZQ13A", "CZQ14A", "CZQ15A", "CZQ16A", "CZQ17A", "CZQ18A", "CZQ19A", "CZQ1A", "CZQ20A", "CZQ21A", "CZQ22A", "CZQ23A", "CZQ24A", "CZQ25A", "CZQ26A", "CZQ27A", "CZQ28A", "CZQ29A", "CZQ2A", "CZQ30A", "CZQ31A", "CZQ32A", "CZQ33A", "CZQ34A", "CZQ35A", "CZQ36A", "CZQ37A", "CZQ38A", "CZQ39A", "CZQ3A", "CZQ40A", "CZQ41A", "CZQ42A", "CZQ43A", "CZQ44A", "CZQ45A", "CZQ46A", "CZQ47A", "CZQ48A", "CZQ49A", "CZQ4A", "CZQ50A", "CZQ5A", "CZQ6A", "CZQ7A", "CZQ8A", "CZQ9A", "HN10A", "HN11A", "HN12A", "HN13A", "HN14A", "HN15A", "HN16A", "HN17A", "HN18A", "HN19A", "HN1A", "HN20A", "HN21A", "HN22A", "HN23A", "HN24A", "HN25A", "HN26A", "HN27A", "HN28A", "HN29A", "HN2A", "HN30A", "HN31A", "HN32A", "HN33A", "HN34A", "HN35A", "HN36A", "HN37A", "HN38A", "HN39A", "HN3A", "HN40A", "HN41A", "HN42A", "HN43A", "HN44A", "HN45A", "HN46A", "HN47A", "HN48A", "HN49A", "HN4A", "HN50A", "HN5A", "HN6A", "HN7A", "HN8A", "HN9A", "TLQ10A", "TLQ11A", "TLQ12A", "TLQ13A", "TLQ14A", "TLQ15A", "TLQ16A", "TLQ17A", "TLQ18A", "TLQ19A", "TLQ1A", "TLQ20A", "TLQ2A", "TLQ3A", "TLQ4A", "TLQ5A", "TLQ6A", "TLQ7A", "TLQ8A", "TLQ9A", "YS10A", "YS11A", "YS12A", "YS13A", "YS14A", "YS15A", "YS16A", "YS17A", "YS18A", "YS19A", "YS1A", "YS20A", "YS21A", "YS22A", "YS23A", "YS24A", "YS25A", "YS26A", "YS27A", "YS28A", "YS29A", "YS2A", "YS30A", "YS3A", "YS4A", "YS5A", "YS6A", "YS7A", "YS8A", "YS9A"]   # fix



# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:
S01_Step02_Job_Name = 'F12'

# s01.step01:
s01_step01_CAT_WK_DIR = Main_WK_DIR + '/01.Filter/01.raw.data'        # fix: raw data path

# s01.step02:
S01_Step02_Filter_Log_DIR = Main_WK_DIR + '/01.Filter/02.process/l01.log'    # fix
s01_Step02_Tmp_Shell= Main_WK_DIR + '/01.Filter/02.process/s01.step02.soapnuke.filter.sh'   # fix: raw data path

# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:


# ------------------------------------------------------------------------------------------------------------------------------ S02  clean  to  bam:
S02_Step01_OU_PATH= Main_WK_DIR + '/02.bwa'                         # fix
S02_Step01_Job_Name = 'B12'
# ------------------------------------------------------------------------------------------------------------------------------ S02  clean  to  bam


# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf:
S03_Step01_OU_PATH= Main_WK_DIR + '/03.gatk/01.bam.to.gvcf.with.bed'                         # fix
S03_Step01_Job_Name = 'G12.1'
# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf


# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf:
S03_Step02_OU_PATH= Main_WK_DIR + '/03.gatk/02.gvcf.to.bed.gvcf'                         # fix
S03_Step01_Job_Name = 'G12.2'
# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf


# ------------------------------ py.config

# ------------------------------ tmp.s01.step01.ln.cat.py
import re
import pandas as pd
from pandas.core.frame import DataFrame
import os
import sys
import subprocess


os.getcwd()
os.chdir(Main_Script_DIR)
os.getcwd()
os.listdir()
df1=pd.read_table('lib.name.txt',header=0,index_col=None)
df1
df2=pd.read_table('fq.gz.list',header=None)
df2
ls_fq = df2[0].tolist()
ls_fq
ls_name = list(set(df1['name'].tolist()))
ls_name.sort()
len(ls_name)

print("date")
for name_tmp in ls_name:
    df_tmp = df1[df1['name'] == name_tmp]
    # print(name_tmp)
    # print(df_tmp)
    lib_id = "".join(df_tmp['lib'].tolist())
    # print(lib_id)
    lib_id_ls = list(filter(lambda x: lib_id in x, ls_fq))
    # print(lib_id_ls)
    lib_id_ls_fq1 = list(filter(lambda x: '_1.fq.gz' in x, lib_id_ls))
    lib_id_ls_fq1.sort()
    lib_id_ls_fq1_str = " ".join(lib_id_ls_fq1)
    lib_id_ls_fq2 = list(filter(lambda x: '_2.fq.gz' in x, lib_id_ls))
    lib_id_ls_fq2.sort()
    lib_id_ls_fq2_str = " ".join(lib_id_ls_fq2)
    fq1_gz = name_tmp + ".R1.fq.gz"
    fq2_gz = name_tmp + ".R2.fq.gz"
    if len(lib_id_ls) == 2:
        print("ln -s {} {}/{}".format(lib_id_ls_fq1_str, s01_step01_CAT_WK_DIR, fq1_gz))
        print("ln -s {} {}/{}".format(lib_id_ls_fq2_str, s01_step01_CAT_WK_DIR, fq2_gz))
    if len(lib_id_ls) >= 4:
        print("cat  {} > {}/{}".format(lib_id_ls_fq1_str, s01_step01_CAT_WK_DIR, fq1_gz))
        print("cat  {} > {}/{}".format(lib_id_ls_fq2_str, s01_step01_CAT_WK_DIR, fq2_gz))
print("touch step01.ln.cat.sh.finished!")
print("date")
# ------------------------------ tmp.s01.step01.ln.cat.py

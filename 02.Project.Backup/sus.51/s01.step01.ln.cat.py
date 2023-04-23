# ------------------------------ py.config

Main_WK_DIR='/hwfssz4/BC_COM_P5/F21FTSSCKF9402/PELxszaR/51.F21FTSSCKF9402_SUSnrzjR.S32'
Main_Script_DIR= '/hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline'

list_sample=["TC1_1", "TC1_10", "TC1_11", "TC1_12", "TC1_13", "TC1_14", "TC1_15", "TC1_16", "TC1_17", "TC1_18", "TC1_2", "TC1_3", "TC1_4", "TC1_5", "TC1_6", "TC1_7", "TC1_8", "TC1_9", "TC2_1", "TC2_10", "TC2_11", "TC2_12", "TC2_13", "TC2_14", "TC2_2", "TC2_3", "TC2_4", "TC2_5", "TC2_6", "TC2_7", "TC2_8", "TC2_9"]   # fix



# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:
S01_Step02_Job_Name = 'F51'

# s01.step01:
s01_step01_CAT_WK_DIR = Main_WK_DIR + '/01.Filter/01.raw.data'        # fix: raw data path

# s01.step02:
S01_Step02_Filter_Log_DIR = Main_WK_DIR + '/01.Filter/02.process/l01.log'    # fix
s01_Step02_Tmp_Shell= Main_WK_DIR + '/01.Filter/02.process/s01.step02.soapnuke.filter.sh'   # fix: raw data path

# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:


# ------------------------------------------------------------------------------------------------------------------------------ S02  clean  to  bam:
S02_Step01_OU_PATH= Main_WK_DIR + '/02.bwa'                         # fix
S02_Step01_Job_Name = 'B51'
# ------------------------------------------------------------------------------------------------------------------------------ S02  clean  to  bam


# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf:
S03_Step01_OU_PATH= Main_WK_DIR + '/03.gatk/01.bam.to.gvcf.with.bed'                         # fix
S03_Step01_Job_Name = 'G51.1'
# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf


# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf:
S03_Step02_OU_PATH= Main_WK_DIR + '/03.gatk/02.gvcf.to.bed.gvcf'                         # fix
S03_Step01_Job_Name = 'G51.2'
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

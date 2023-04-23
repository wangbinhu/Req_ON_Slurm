# ------------------------------ py.config
# step 00
Job_Name = "SUSnrzjR"    # fix
Step02_Fliter_Log_DIR = '/ifswh1/BC_COM_P4/F21FTSSCKF9402/SUSnrzjR/02.process/l01.log'    # fix
Main_Sample_List = ["TC1_1", "TC1_2", "TC1_3", "TC1_4", "TC1_5", "TC1_6", "TC1_7", "TC1_8", "TC1_9", "TC1_10", "TC1_11", "TC1_12", "TC1_13", "TC1_14", "TC1_15", "TC1_16", "TC1_17", "TC1_18", "TC2_1", "TC2_2", "TC2_3", "TC2_4", "TC2_5", "TC2_6", "TC2_7", "TC2_8", "TC2_9", "TC2_10", "TC2_11", "TC2_12", "TC2_13", "TC2_14"]    # fix

# step 01
Step01_CAT_WK_DIR = '/ifswh1/BC_COM_P4/F21FTSSCKF9402/SUSnrzjR/01.raw.data'        # fix: raw data path

# step 02
Step02_Tmp_Shell= '/ifswh1/BC_COM_P4/F21FTSSCKF9402/SUSnrzjR/02.process/s02.soapnuke.fliter.sh'
# ------------------------------ py.config

# ------------------------------ tmp.s01.step01.ln.cat.py
import re
import pandas as pd
from pandas.core.frame import DataFrame
import os
import sys
import subprocess


os.getcwd()
os.chdir("/home/wangbinhu/01.Piepe.Line/01.raw.data.filter.and.summary")
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
        print("ln -s {} {}/{}".format(lib_id_ls_fq1_str, Step01_CAT_WK_DIR, fq1_gz))
        print("ln -s {} {}/{}".format(lib_id_ls_fq2_str, Step01_CAT_WK_DIR, fq2_gz))
    if len(lib_id_ls) >= 4:
        print("cat  {} > {}/{}".format(lib_id_ls_fq1_str, Step01_CAT_WK_DIR, fq1_gz))
        print("cat  {} > {}/{}".format(lib_id_ls_fq2_str, Step01_CAT_WK_DIR, fq2_gz))
print("touch step01.ln.cat.sh.finished!")
print("date")
# ------------------------------ tmp.s01.step01.ln.cat.py

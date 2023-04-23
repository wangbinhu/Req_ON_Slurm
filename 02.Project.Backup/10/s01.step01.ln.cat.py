# ------------------------------ py.config

Main_WK_DIR='/hwfssz4/BC_COM_P5/F21FTSSCKF9402/PELxszaR/10.F21FTSSCKF9402_MICexlqR'
Main_Script_DIR= '/hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline'

list_sample=["A001", "A002", "A003", "A004", "A005", "A006", "A007", "A008", "A009", "A010", "A011", "A012", "A013", "A014", "A015", "A016", "A017", "A018", "A019", "A020", "A021", "A022", "A023", "A024", "A025", "A026", "A027", "A028", "A029", "A030", "A031", "A032", "A033", "A034", "A035", "A036", "A037", "A038", "A039", "A040", "A041", "A042", "A043", "A044", "A045", "A046", "A047", "A048", "A049", "A050", "A051", "A052", "A053", "A054", "A055", "A056", "A057", "A058", "A059", "A060", "A061", "A062", "A063", "A064", "A065", "A066", "A067", "A068", "A069", "A070", "A071", "A072", "A073", "A074", "A075", "A076", "A077", "A078", "A079", "A080", "A081", "A082", "A083", "A084", "A085", "A086", "A087", "A088", "A089", "A090", "A091", "A092", "A093", "A094", "A095", "A096", "A097", "A098", "A099", "A100", "B001", "B002", "B003", "B004", "B005", "B006", "B007", "B008", "B009", "B010", "B011", "B012", "B013", "B014", "B015", "B016", "B017", "B018", "B019", "B020", "B021", "B022", "B023", "B024", "B025", "B026", "B027", "B028", "B029", "B030", "B031", "B032", "B033", "B034", "B035", "B036", "B037", "B038", "B039", "B040", "B041", "B042", "B043", "B044", "B045", "B046", "B047", "B048", "B049", "B050", "B051", "B052", "B053", "B054", "B055", "B056", "B057", "B058", "B059", "B060", "B061", "B062", "B063", "B064", "B065", "B066", "B067", "B068", "B069", "B070", "B071", "B072", "B073", "B074", "B075", "B076", "B077", "B078", "B079", "B080", "B081", "B082", "B083", "B084", "B085", "B086", "B087", "B088", "B089", "B090", "B091", "B092", "B093", "B094", "B095", "B096", "B097", "B098", "B099", "B100"]   # fix



# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:
S01_Step02_Job_Name = 'F10'

# s01.step01:
s01_step01_CAT_WK_DIR = Main_WK_DIR + '/01.Filter/01.raw.data'        # fix: raw data path

# s01.step02:
S01_Step02_Filter_Log_DIR = Main_WK_DIR + '/01.Filter/02.process/l01.log'    # fix
s01_Step02_Tmp_Shell= Main_WK_DIR + '/01.Filter/02.process/s01.step02.soapnuke.filter.sh'   # fix: raw data path

# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:


# ------------------------------------------------------------------------------------------------------------------------------ S02  clean  to  bam:
S02_Step01_OU_PATH= Main_WK_DIR + '/02.bwa'                         # fix
S02_Step01_Job_Name = 'B10'
# ------------------------------------------------------------------------------------------------------------------------------ S02  clean  to  bam


# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf:
S03_Step01_OU_PATH= Main_WK_DIR + '/03.gatk/01.bam.to.gvcf.with.bed'                         # fix
S03_Step01_Job_Name = 'G10.1'
# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf


# ------------------------------------------------------------------------------------------------------------------------------ S03  bam  to  gvcf:
S03_Step02_OU_PATH= Main_WK_DIR + '/03.gatk/02.gvcf.to.bed.gvcf'                         # fix
S03_Step01_Job_Name = 'G10.2'
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

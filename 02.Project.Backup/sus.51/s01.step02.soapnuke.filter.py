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
# ------------------------------ tmp.s02.soapnuke.fliter.py
# step02.soapnuke.fliter.py
import csv
import subprocess
import time
import sys
import os

print("Total {} samples, will submit {} jobs".format( len(list_sample), len(list_sample) ))
os.chdir(S01_Step02_Filter_Log_DIR)
i=1
for sample in list_sample:
        # 替换文件变量：
        fi = open(s01_Step02_Tmp_Shell,encoding = "utf-8")
        fo = open("t.soapnuke.fliter.sh","w",encoding = "utf-8")
        string = fi.read()
        string1 = string.replace('${sample}', sample)
        fo.write(string1)
        fi.close()
        fo.close()

        qsub_cmd = "qsub -cwd -S /bin/sh -q bc.q,bc_fcn.q -P SOYhvfR -l vf=1G,p=2 -binding linear:2 -N {0}.{1} -wd {2} t.soapnuke.fliter.sh".format(S01_Step02_Job_Name, sample, S01_Step02_Filter_Log_DIR)   #-N指定作业名；-wd指定log文件存放目录；-v sample传输如样品名变量；
        exit_status = subprocess.call(qsub_cmd, shell=True)
        if exit_status == 1:
            print('Job "{}" failed to submit'.format(qsub_cmd))
        else:
            print("The {}st task submit success!".format(i))
            i+=1
os.remove('t.soapnuke.fliter.sh')
print("Done submitting jobs!")
# ------------------------------ tmp.s02.soapnuke.fliter.py

# ------------------------------ py.config

Main_WK_DIR='/hwfssz4/BC_COM_P5/F21FTSSCKF9402/PELxszaR/52.F22KTSSCKF5710_SUSfjuvR.S30'
Main_Script_DIR= '/hwfssz4/BC_PUB/Software/07.User-defined/03.Animal_Plant/wbh/02.reseq.pipeline'

list_sample=["DA_1", "DA_2", "DA_3", "DA_4", "DA_5", "DA_6", "DA_7", "DA_8", "DA_9", "DA_10", "DA_11", "DA_12", "DA_13", "DA_14", "DA_15", "DA_16", "DA_17", "DA_18", "DA_19", "DA_20", "DA_21", "DA_22", "DA_23", "DA_24", "DA_25", "DA_26", "DA_27", "DA_28", "DA_29", "DA_30"]   # fix



# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:
S01_Step02_Job_Name = 'F52'

# s01.step01:
s01_step01_CAT_WK_DIR = Main_WK_DIR + '/01.Filter/01.raw.data'        # fix: raw data path

# s01.step02:
S01_Step02_Filter_Log_DIR = Main_WK_DIR + '/01.Filter/02.process/l01.log'    # fix
s01_Step02_Tmp_Shell= Main_WK_DIR + '/01.Filter/02.process/s01.step02.soapnuke.filter.sh'   # fix: raw data path

# ------------------------------------------------------------------------------------------------------------------------------ S01  filter clean  data:


# ------------------------------------------------------------------------------------------------------------------------------ S02  clean  to  bam:
S02_Step01_OU_PATH= Main_WK_DIR + '/02.bwa'                         # fix
S02_Step01_Job_Name = 'B52'
# ------------------------------------------------------------------------------------------------------------------------------ S02  clean  to  bam


# ------------------------------------------------------------------------------------------------------------------------------ S03.step01.bam.to.gvcf:
S03_Step01_OU_PATH= Main_WK_DIR + '/03.gatk/01.bam.to.gvcf.with.bed'                         # fix
S03_Step01_Job_Name = 'G52_1'
# ------------------------------------------------------------------------------------------------------------------------------ S03.step01.bam.to.gvcf


# ------------------------------------------------------------------------------------------------------------------------------ S03.step02.gvcf.to.bed.gvcf:
S03_Step02_OU_PATH= Main_WK_DIR + '/03.gatk/02.gvcf.to.bed.gvcf'                         # fix
S03_Step02_Job_Name = 'G52_2'
# ------------------------------------------------------------------------------------------------------------------------------ S03.step02.gvcf.to.bed.gvcf


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

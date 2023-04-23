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

# ------------------------------ tmp.s02.soapnuke.fliter.py
# step02.soapnuke.fliter.py
import csv
import subprocess
import time
import sys
import os

print("Total {} samples, will submit {} jobs".format( len(Main_Sample_List), len(Main_Sample_List) ))
os.chdir(Step02_Fliter_Log_DIR)
i=1
for sample in Main_Sample_List:
        # 替换文件变量：
        fi = open(Step02_Tmp_Shell,encoding = "utf-8")
        fo = open("t.soapnuke.fliter.sh","w",encoding = "utf-8")
        string = fi.read()
        string1 = string.replace('${sample}', sample)
        fo.write(string1)
        fi.close()
        fo.close()

        qsub_cmd = "qsub -cwd -S /bin/sh -q bc.q,bc_com_t1.q -P SOYhvfR -l vf=1G,p=2 -binding linear:2 -N {0}.{1} -wd {2} t.soapnuke.fliter.sh".format(Job_Name, sample, Step02_Fliter_Log_DIR)   #-N指定作业名；-wd指定log文件存放目录；-v sample传输如样品名变量；
        exit_status = subprocess.call(qsub_cmd, shell=True)
        if exit_status == 1:
            print('Job "{}" failed to submit'.format(qsub_cmd))
        else:
            print("The {}st task submit success!".format(i))
            i+=1
os.remove('t.soapnuke.fliter.sh')
print("Done submitting jobs!")
# ------------------------------ tmp.s02.soapnuke.fliter.py

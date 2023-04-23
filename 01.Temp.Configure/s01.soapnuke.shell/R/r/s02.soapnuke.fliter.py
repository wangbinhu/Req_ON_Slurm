# step02.soapnuke.fliter.py
import csv
import subprocess
import time
import sys
import os
sys.path.append("/home/wangbinhu/01.Piepe.Line/01.raw.data.filter.and.summary")
import config as config

print("Total {} samples, will submit {} jobs".format( len(config.Main_Sample_List), len(config.Main_Sample_List) ))
os.chdir(config.Step02_Fliter_Log_DIR)
i=1
for sample in config.Main_Sample_List:
        # 替换文件变量：
        fi = open(config.Step02_Tmp_Shell,encoding = "utf-8")
        fo = open("t.soapnuke.fliter.sh","w",encoding = "utf-8")
        string = fi.read()
        string1 = string.replace('${sample}', sample)
        fo.write(string1)
        fi.close()
        fo.close()

        qsub_cmd = "qsub -cwd -S /bin/sh -q bc.q,bc_com_t1.q -P SOYhvfR -l vf=1G,p=2 -binding linear:2 -N {0}.{1} -wd {2} t.soapnuke.fliter.sh".format(config.Job_Name, sample, config.Step02_Fliter_Log_DIR)   #-N指定作业名；-wd指定log文件存放目录；-v sample传输如样品名变量；
        exit_status = subprocess.call(qsub_cmd, shell=True)
        if exit_status == 1:
            print('Job "{}" failed to submit'.format(qsub_cmd))
        else:
            print("The {}st task submit success!".format(i+1))
            i+=1
os.remove('t.soapnuke.fliter.sh')
print("Done submitting jobs!")

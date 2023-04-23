# ------------------------------ tmp.s06.step01.bam.to.sv.py

import csv
import subprocess
import time
import sys
import os

Shell_File = S06_Step01_OU_PATH + '/s06.step01.bam.to.sv.sh'     # fix

print("Total {} samples, will submit {} jobs".format(  len(list_sample) , len(list_sample) ))
os.chdir(S06_Step01_OU_PATH)                                                   # fix
i=1
for sample in list_sample:
    # 替换文件变量：
    fi = open(Shell_File,encoding = "utf-8")
    fo = open("t.s06.step01.bam.to.sv.sh","w",encoding = "utf-8")
    string = fi.read()
    string1 = string.replace('${sample}', sample).replace('$S06_Step01_Job_Name', S06_Step01_Job_Name)
    fo.write(string1)
    fi.close()
    fo.close()

    # 提交任务：
    qsub_cmd = 'sbatch t.s06.step01.bam.to.sv.sh'
    exit_status = subprocess.call(qsub_cmd, shell=True)
    if exit_status == 1:
        print('Job "{}" failed to submit'.format(qsub_cmd))
    else:
        print("The {}st task submit success!".format(i))
        i+=1;
# os.remove('t.s06.step01.bam.to.sv.sh')
print("Done submitting jobs!")

# ------------------------------ tmp.s06.step01.bam.to.sv.py


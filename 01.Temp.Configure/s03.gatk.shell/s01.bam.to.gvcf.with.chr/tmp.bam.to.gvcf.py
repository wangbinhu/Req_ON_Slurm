# tmp.bam.to.gvcf.py
import csv
import subprocess
import time
import sys
import os
print("Total {} samples, and {} Chr, will submit {} jobs".format( len(list_sample), len(list_chr), len(list_sample)*len(list_chr)))
os.chdir(Work_Dir)
i=1
for sample in list_sample:
    for chr in list_chr:
        # 替换文件变量：
        fi = open(Shell_File,encoding = "utf-8")
        fo = open("t.bam.to.gvcf.sh","w",encoding = "utf-8")
        string = fi.read()
        string1 = string.replace('${sample}', sample).replace('$CHR_NUM', chr)
        fo.write(string1)
        fi.close()
        fo.close()

        qsub_cmd = "qsub -cwd -S /bin/sh -q bc.q,bc_fcn.q -P SOYhvfR -l vf=4G,p=1 -binding linear:1 -N {0}.{1}.{2} -wd {3} t.bam.to.gvcf.sh".format(Job_name, sample, chr, Log_Dir)   # fix: -N GF02.A.{0}.{1}
        exit_status = subprocess.call(qsub_cmd, shell=True)
        if exit_status == 1:
            print('Job "{}" failed to submit'.format(qsub_cmd))
        else:
            print("The {}st task submit success!".format(i+1))
            i+=1
os.remove('t.bam.to.gvcf.sh')
print("Done submitting jobs!")

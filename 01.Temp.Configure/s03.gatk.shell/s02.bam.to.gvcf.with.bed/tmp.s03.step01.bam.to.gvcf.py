# ------------------------------ tmp.s03.step01.bam.to.gvcf.py

import csv
import subprocess
import time
import sys
import os

Shell_File = S03_Step01_OU_PATH + '/s03.step01.bam.to.gvcf.sh'

# touch list_chr:
filePath = S03_Step01_OU_PATH + "/bed.zone/"
bed_list = os.listdir(filePath)
list_chr = []
for i in bed_list:
    list_chr.append(i.strip('.bed'))
list_chr.sort()

print("Total {} samples, and {} Chr, will submit {} jobs".format( len(list_sample), len(list_chr), len(list_sample)*len(list_chr)))


os.chdir(S03_Step01_OU_PATH)
i=1
qw_limits=39000
for sample in list_sample:
    for chr in list_chr:
        # 替换文件变量：
        fi = open(Shell_File,encoding = "utf-8")
        fo = open("t.s03.step01.bam.to.gvcf.sh","w",encoding = "utf-8")
        string = fi.read()
        string1 = string.replace('${sample}', sample).replace('$CHR_NUM', chr).replace('$S03_Step01_Job_Name', S03_Step01_Job_Name)
        fo.write(string1)
        fi.close()
        fo.close()

        ## 检测服务器当前任务数量
        out_bytes = subprocess.check_output('squeue -u bgi_wangbinhu | grep "bgi_wang" |wc -l', shell=True)
        out_text = out_bytes.decode('utf-8')
        qw = int(out_text.strip())

        ## 提交任务
        while qw > qw_limits :
            time.sleep(30)
            print("Total tasks number is {}, qw task number is bigger than {}, {} will  execute the {}st task 180s later...".format( len(list_sample)*len(list_chr), qw_limits, sample, i+1))
            ## 检测服务器当前任务数量
            out_bytes = subprocess.check_output('squeue -u bgi_wangbinhu | grep "bgi_wang" |wc -l', shell=True)
            out_text = out_bytes.decode('utf-8')
            qw = int(out_text.strip())

        qsub_cmd = "sbatch {}".format('t.s03.step01.bam.to.gvcf.sh')
        exit_status = subprocess.call(qsub_cmd, shell=True)
        if exit_status == 1:
            print('Job "{}" failed to submit'.format(qsub_cmd))
        else:
            print("The {}st task submit success!".format(i))
            i+=1;
# os.remove('t.s03.step01.bam.to.gvcf.sh')
print("Done submitting jobs!")

# ------------------------------ tmp.s03.step01.bam.to.gvcf.py

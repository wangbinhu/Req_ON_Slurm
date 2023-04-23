# --------------------- tmp.compute.pic.py

import re
import pandas as pd
import os

import sys
import os
import subprocess

ls=os.popen("ls *.pic").read().strip().split('\n')
print("Population\tMinor.Allele.Frequency(MAF)\tPolymorphism.Information.Content(PIC)")
for file in ls:
    df1=pd.read_table(file,header=0)
    # df1.replace('\s+','',regex=True,inplace=True)
    df1

    mean_AF = df1['AF'].mean()
    std_AF = df1['AF'].std()

    mean_PIC = df1['PIC'].mean()
    std_PIC = df1['PIC'].std()
    print("{}\t{:>10.2e}±{:<10.2e}\t{:>10.2e}±{:<10.2e}".format(file.strip('.pic'), mean_AF, std_AF, mean_PIC, std_PIC))

        
# --------------------- tmp.compute.pic.py



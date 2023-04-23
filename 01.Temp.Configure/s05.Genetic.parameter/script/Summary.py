# --------------------- Summary.py

import pandas as pd
import os
from functools import reduce

os.chdir("./")
os.listdir()


df1=pd.read_table('./01.PI/pi.result',header=0)
df2=pd.read_table('./03.MAF.PIC/pic.result',header=0)
df3=pd.read_table('./04.F.Ho/F.Ho.result',header=0)

df4=[df1, df2, df3]
df_merge = reduce(lambda left,right: pd.merge(left,right,on=['Population']), df4)

        
order = ["Population", "Sample.Number", "SNP.Number", "SNP.Density(SNP/Kb)", "Nucleotide.Diversity(π)", "Inbreeding.Coefficient(F)", "Polymorphism.Information.Content(PIC)",  "Observed.Heterozygosity(Ho)", "Minor.Allele.Frequency(MAF)"]
df_merge = df_merge[order]


df_merge
df_merge.to_csv('Summary.result', sep='\t', encoding='utf_8_sig', index=False)

# --------------------- Summary.py

# --------------------- tmp.compute.fst.py

import re
import pandas as pd
from pandas.core.frame import DataFrame
import os
import sys
import subprocess
print("Population-1\tPopulation-2\tFst")
ls=os.popen("ls *.fst").read().strip().split('\n')
for file in ls:
        df1=pd.read_table(file,header=0)
        df1
        mean_df = df1['MEAN_FST'].mean()
        print("{}\t{}\t{:<10.3f}".format(file.strip('.windowed.weir.fst').split('.VS.')[0], file.strip('.windowed.weir.fst').split('.VS.')[1], mean_df))
        
# --------------------- tmp.compute.fst.py


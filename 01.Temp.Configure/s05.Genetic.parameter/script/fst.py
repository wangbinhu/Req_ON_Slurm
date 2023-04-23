import re
import pandas as pd
from pandas.core.frame import DataFrame
import os
import sys
import subprocess

ls=os.popen("ls *.fst").read().strip().split('\n')
for file in ls:
        df1=pd.read_table(file,header=0)
        df1
        mean_df = df1['MEAN_FST'].mean()
        print("{}\t{:<10.2e}".format(file.strip('.windowed.weir.fst'),mean_df))


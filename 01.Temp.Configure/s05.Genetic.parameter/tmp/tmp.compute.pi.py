# --------------------- tmp.compute.pi.py

import pandas as pd

print("Population\tNucleotide.Diversity(π)")
for i in Group_list:
    file = './' + i + '.window-pi.windowed.pi'
    df1=pd.read_table(file,header=0)
    mean_df = df1['PI'].mean()
    std_df = df1['PI'].std()
    print("{}\t{:>10.2e}±{:<10.2e}".format(i,mean_df,std_df))
    
# --------------------- tmp.compute.pi.py

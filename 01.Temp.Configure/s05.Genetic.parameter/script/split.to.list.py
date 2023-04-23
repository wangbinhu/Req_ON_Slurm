import pandas as pd
import os

os.getcwd()
os.chdir("./")
os.getcwd()
os.listdir()


df1=pd.read_table('lib.name.group.table',header=0)
df1
l1= df1['group'].values.tolist()
len(l1)
l2 = list(set(l1))
len(l2)
l2

for group in l2:
    print(group)
    df2 = df1[df1['group']==group]
    print(df2)
    df3 = df2.iloc[:,1]
    print(df3)
    file_name = group + '.list'
    df3.to_csv(file_name,  sep=' ', header=False, index=False)


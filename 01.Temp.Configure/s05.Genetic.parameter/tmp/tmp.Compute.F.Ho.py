import pandas as pd
import os

os.chdir("./")
os.listdir()

Population=[]
Sample_Number = []
SNP_Number = []
SNP_Density = []
Inbreeding_Coefficinet = []
Observed_Heterozygosity = []


for i in Group_list:
    group = i
    # Population
    Population.append(group)
    file_name = group + '.het.F.Ho'
    df2=pd.read_table(file_name,header=0)
    # Sample_Number
    Sample_Number.append(df2.shape[0])
    # SNP_Number
    SNP_Number_T = round(df2['N_SITES'].mean());
    SNP_Number.append(SNP_Number_T)
        # SNP_Density
    SNP_Density_T = round(SNP_Number_T/Genome_Size_KB, 2);
    SNP_Density.append(SNP_Density_T)
    # Inbreeding_Coefficinet
    Inbreeding_Coefficinet_mean = df2['F'].mean()
    Inbreeding_Coefficinet_std = df2['F'].std()
    Inbreeding_Coefficinet.append("{:>10.2e}±{:<10.2e}".format(Inbreeding_Coefficinet_mean,Inbreeding_Coefficinet_std).strip())
    # Observed_Heterozygosity
    Observed_Heterozygosity_mean = df2['Ho'].mean()
    Observed_Heterozygosity_std = df2['Ho'].std()
    Observed_Heterozygosity.append("{:>10.2e}±{:<10.2e}".format(Observed_Heterozygosity_mean,Observed_Heterozygosity_std).strip())
# print(Observed_Heterozygosity)
dict={"Population":Population,
   "Sample.Number":Sample_Number,
   "SNP.Number":SNP_Number,
   "SNP.Density(SNP/Kb)":SNP_Density,
   "Inbreeding.Coefficient(F)":Inbreeding_Coefficinet,
   "Observed.Heterozygosity(Ho)":Observed_Heterozygosity,
   }

df_end = pd.DataFrame(dict)
df_end
df_end.to_csv('F.Ho.result', sep='\t', encoding='utf_8_sig', index=False)

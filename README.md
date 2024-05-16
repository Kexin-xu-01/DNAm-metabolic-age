# DNAm-metabolic-age
This repository contains supporting materials (data/codes) for the manuscript "Assessing metabolic ageing via DNA methylation surrogate markers in two British and Irish cohorts".
Users can build the DNAm-metabolic clock to estimate biological age of people from DNA methylation (DNAm) and metabolites in blood.

## Introduction
Omics, or large-scale measurements of biological molecules, have been used to assess “biological age”, the age of our body that varies with our lifestyles. Ageing clocks have been developed from omics such as metabolomics and DNA methylation to identify individuals with “accelerated ageing” (higher biological age than chronological age). While metabolites are subject to short-term variation, DNAm captures longer-term exposures. If we can use DNAm as metabolite surrogates (“DNAm-metabolites”), we might predict metabolic age in a more stable and reproducible way. 

Within the UK AIRWAVE cohort, an occupational health study of the UK police forces (N = 820), DNAm-metabolites were built by individually regressing 594 blood-based metabolites on DNAm. Ageing clocks were built as a linear combination of 177 DNAm-metabolites (DNAm-metabolic clock) or 193 metabolites (metabolic clock) using penalised linear regression. The DNAm-metabolic clock was independently validated in an ageing Irish cohort, TILDA (N = 488). 

An accelerated DNAm-metabolic age was associated with mortality risk factors like male sex, heavy drinking, anxiety, depression, and trauma. When tested in TILDA, the DNAm-metabolic clock was associated with disability and walking speed.

DNAm-metabolite surrogates may facilitate metabolic studies using only DNAm data. The presented DNAm-metabolic clock provided a novel approach to assess metabolic ageing and may allow early identification of metabolic-related chronic diseases for personalised medicine.

The code allows users to apply the DNAm-metabolic clock to cohorts with only DNAm data.

# File Description
**Build_DNAm_metabolic_clock.R**: This R script is used to build DNAm-metabolic clock, using CpG_to_DNAm_metabolite.csv, DNAm_metabolite_to_clock.csv, and the user's own R matrix containing DNA methylation M values (row: sample; column: CpG name). The output of this script is a list containing the DNAm-metabolic age and the DNAm-metabolite values for each sample.

**CpG_to_DNAm_metabolite.csv**: This CSV file is used to build 177 DNAm-metabolites. It contains the linear regression coefficients (including intercepts) to build 177 DNAm-metabolites from CpGs. 

**DNAm_metabolite_to_clock.csv**: This CSV file is used to predict the DNAm-metabolic age. The first column contains the linear regression coefficients (including intercepts) to build the DNAm-metabolic clock from 177 DNAm-metabolites. The second and third columns contain the standard deviation and mean derived from the Airwave dataset, to scale the DNAm-metabolites before using them to build the clock. 

# User Instruction
1. Users first need to check whether they have all the CpGs needed to build the DNAm-metabolites. You can do this by checking the column names of **CpG_to_DNAm_metabolite.csv**. If you try to run the script without having all the CpGs ready, an error message will appear indicating that you don't have all the CpGs.
   
2. Users need to convert CpG values from beta values to M values using the formula: *M value = log2(beta value / (1 - beta value))*.
   
3. Users need to impute any missing CpG values in some samples. I recommend using the knn.impute function. If you try to run the script having some NA CpGs values, an error message will appear indicating that some CpG values are missing in some samples.
   
4. Users need to import their CpG M value matrix into the R environment (row: sample IDs; column: CpGs).
   
5. Users import tidyverse library.
   
6. Users run **Build_DNAm_metabolic_clock.R** in the same environment with the CpG matrix.
   
7. Users get a list called **Age_and_DNAm_metabolites** as the output.

   Users can access the DNAm-metabolic age using **Age_and_DNAm_metabolites$DNAm_metabolic_age**, which returns a vector containing DNAm-metabolic age of each sample.

   Users can access the DNAm-metabolites using **Age_and_DNAm_metabolites$DNAm_metabolite**, which returns a matrix containing values of 177 DNAm-metabolites for each sample (row: sample ID; column: DNAm-metabolite name).

Please direct any enquires to Ms Kexin Xu at kexin.xu@bnc.ox.ac.uk or open a Github issue. 

Date: 16 May 2024
   



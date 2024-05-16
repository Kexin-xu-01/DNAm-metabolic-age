# DNAm-metabolic-age
This repository contains supporting materials (data/codes) for the manuscript "Assessing metabolic ageing via DNA methylation surrogate markers in two British and Irish cohorts".
Users can build the DNAm-metabolic clock to estimate biological age of people from DNA methylation (DNAm) and metabolites in blood.

## Introduction
Omics, or large-scale measurements of biological molecules, have been used to assess “biological age”, the age of our body that varies with our lifestyles. Ageing clocks have been developed from omics such as metabolomics and DNA methylation to identify individuals with “accelerated ageing” (higher biological age than chronological age). While metabolites are subject to short-term variation, DNAm captures longer-term exposures. If we can use DNAm as metabolite surrogates (“DNAm-metabolites”), we might predict metabolic age in a more stable and reproducible way. 

Within the UK AIRWAVE cohort, an occupational health study of the UK police forces (N = 820), DNAm-metabolites were built by individually regressing 594 blood-based metabolites on DNAm. Ageing clocks were built as a linear combination of 177 DNAm-metabolites (DNAm-metabolic clock) or 193 metabolites (metabolic clock) using penalised linear regression. The DNAm-metabolic clock was independently validated in an ageing Irish cohort, TILDA (N = 488). 

An accelerated DNAm-metabolic age was associated with mortality risk factors like male sex, heavy drinking, anxiety, depression, and trauma. When tested in TILDA, the DNAm-metabolic clock was associated with disability and walking speed.

DNAm-metabolite surrogates may facilitate metabolic studies using only DNAm data. The presented DNAm-metabolic clock provided a novel approach to assess metabolic ageing and may allow early identification of metabolic-related chronic diseases for personalised medicine.

The code allows users to apply the DNAm-metabolic clock to cohorts with only DNAm data.



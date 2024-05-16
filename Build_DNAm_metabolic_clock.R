# build DNAm-metabolic clock from csv containing the coefficients to build 177 DNAm-metabolites from CpG and build clock from DNAm-metabolites
Build_DNAm_metabolic_clock <- function(CpG_matrix, CpG_to_DNAm_metabolite_csv, DNAm_metabolite_to_clock_csv){
  
  # Before you run this script, make sure you have loaded your own CpG_matrix in your R environment
  
  # input:
  # 1. CpG_matrix: This should be the M value of CpG, as a matrix with CpG in columns and samples in rows. Format: CpG as columns and samples as rows. Ways to get M values:
  # CpG beta value -> impute.knn (from 'impute' package) -> M value = log2(beta value / (1 - beta value)) -> CpG M value 
  # The script will print a message if some CpGs are missing. You need to confirm that any missing values is NA, rather than 0, for the script to detect missingness. 
  # 2. CpG_to_DNAm_metabolite_csv: a csv supplied by the author, containing the linear regression coefficients (including intercepts) to build DNAm-metabolites (CpG surrogate markers for metabolite) using a linear combination of CpGs 
  # 3. DNAm_metabolite_to_clock_csv: a csv supplied by the author, with 3 columns. The first column contains the linear regression coefficients (including intercepts) to build the DNAm-metabolic clock from DNAm-metabolites. 
  # The second and third columns contain the standard deviation and mean derived from the Airwave dataset, to scale the DNAm-metabolites before using them to build the clock. 
  
  # output:
  # 1. list(Age_DNAmm, DNAmm): a list containing the following objects
  # a) Age_DNAmm: a named vector of numbers, representing the DNAm-metabolic age for each sample (length: sample number)
  # b) DNAmm: values of 177 DNAm-metabolites for each sample (samples x DNAm-metabolites)
  
  # libraries required to run this function: tidyverse 
  
  # read CSV containing coefficients to build DNAm-metabolites and DNAm-metabolic clock
  CpG_to_DNAm_metabolite <- read_csv(CpG_to_DNAm_metabolite_csv, show_col_types = FALSE)
  DNAm_metabolite_to_clock <- read_csv(DNAm_metabolite_to_clock_csv, show_col_types = FALSE) %>% as.matrix() # later we perform matrix multiplication so it needs to be matrix 
  
  # check if all CpGs needed are present in the provided DNA methylation matrix and with no missing values in some samples 
  if (any(!names(CpG_to_DNAm_metabolite)[-1] %in% colnames(CpG_matrix))){
    print("Not all CpGs needed to build the DNAm-metabolic clock are present in the CpG_matrix")}
  
  else{
    if (any(is.na(CpG_matrix))){
      print("All CpGs needed to build the DNAm-metabolic clock are present in the CpG_matrix, but some samples contain missing values. Suggest to KNN impute these CpGs using e.g. knn.impute")
    }
    
    else{
      # filter DNA methylation data to only keep CpGs that is used to build DNAm-metabolic clock
      DNAm <- CpG_matrix[ , names(CpG_to_DNAm_metabolite)[-1]] 
      
      # matrix multiplication to get the patient x DNAm-metabolite df 
      DNAm_metabolite <- DNAm %*% t(CpG_to_DNAm_metabolite[ ,-1])
      
      # add the intercept for each metabolite (DNAm-metabolite not scaled yet) dim: number of people x 177 DNAm-metabolites
      DNAm_metabolite <- apply(DNAm_metabolite,1,function(x) {x + CpG_to_DNAm_metabolite[ ,1] %>% t()}) %>% t()
      
      # scaling
      DNAm_metabolite_scaled <- apply(DNAm_metabolite,1,function(x) {(x + DNAm_metabolite_to_clock[2:dim(DNAm_metabolite_to_clock)[1], 2]) / DNAm_metabolite_to_clock[2:dim(DNAm_metabolite_to_clock)[1], 3]}) %>% t()  # plus mean, divded by SD
      
      # Calculate DNAm-metabolic age using the generated DNAm-metabolites & caret coefficient (plus intercept for clock at the end)
      DNAm_metabolic_age <- (DNAm_metabolite_scaled %*% DNAm_metabolite_to_clock[-1, 1] + DNAm_metabolite_to_clock[1, 1])[, 1]
      
      Age_and_DNAm_metabolites <- list(DNAm_metabolic_age, DNAm_metabolite)
      names(Age_and_DNAm_metabolites) <- c('DNAm_metabolic_age', 'DNAm_metabolite')
      return(Age_and_DNAm_metabolites)
    }
  }
}

# Example of how to run 
# Age_and_DNAm_metabolites <- Build_DNAm_metabolic_clock(DNAm_M, "CpG_to_DNAm_metabolite.csv", "DNAm_metabolite_to_clock.csv")

# extract the vector for the predicted DNAm-metabolic age: 
# Age_and_DNAm_metabolites$DNAm_metabolic_age

# extract 177 DNAm-metabolite values for each participants
# Age_and_DNAm_metabolites$DNAm_metabolite

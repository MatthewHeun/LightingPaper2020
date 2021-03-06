# Loading data by executing spd_metric_calcs.R script
source("Data/spd_metric_calcs.R")

# This script creates a table with the mean exergy efficiency
# for each combination of lamp and weighting function used in the analysis.

# Filtering spd_metrics data frame to extract etas data.
results_etasX <- spd_metrics %>%
  dplyr::select(lamp_name, wf_name, wrpX_div_ec_100) %>%
  dplyr::filter(lamp_name %in% lamp_list & wf_name %in% wf_list)

# Re-arranges results_etas into the correct orientation

results_etasX_fin <- as.data.frame.matrix(xtabs(wrpX_div_ec_100~wf_name+lamp_name, results_etasX))

# Re-arranges the columns into the correct order

results_etasX_fin <- results_etasX_fin[, c(3,2,1,4)]

# Re-arranges the rows into the correct order

results_etasX_fin <- results_etasX_fin[c(1,4,2,3),]

# Replace lamp_list lamp_name with lamp code (INC, HPS, CFL, LED)

colnames(results_etasX_fin) <- names(lamp_list) 

# Replace wf_list wf_name with actual wf name ()

rownames(results_etasX_fin) <- c("Unweighted ($\\eta_{X,uw}$)", # Here the user will have to manually change the row names based on the weighting functions used.
                                 "Vis. spectrum ($\\eta_{X,vis}$)", 
                                 "Photopic lum. ($\\eta_{X,pl}$)", 
                                 "Universal lum. ($\\eta_{X,univ}$)")



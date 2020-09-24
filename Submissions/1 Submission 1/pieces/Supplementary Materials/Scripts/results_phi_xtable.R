# Loading data by executing spd_metric_calcs.R script
source("Data/spd_metric_calcs.R")

# This script creates a table with the mean exergy-to-energy factor
# for each combination of lamp and weighting function used in the analysis.

# Filtering spd_metrics data frame to extract phi data.
results_phi <- spd_metrics %>%
  dplyr::select(lamp_name, wf_name, phi_agg) %>%
  dplyr::filter(lamp_name %in% lamp_list & wf_name %in% wf_list)

# Re-arranges results_etas into the correct orientation
results_phi_fin <- as.data.frame.matrix(xtabs(phi_agg~wf_name+lamp_name, results_phi))

# Re-arranges the columns into the correct order
results_phi_fin <- results_phi_fin[, c(3,2,1,4)]

# Re-arranges the rows into the correct order
results_phi_fin <- results_phi_fin[c(1,4,2,3), ]

# Replace lamp_list lamp_name with lamp code (e.g. INC, HPS, CFL, LED)
colnames(results_phi_fin) <- names(lamp_list)

# Replace wf_list wf_name with actual wf name
rownames(results_phi_fin) <- c("Unweighted ($\\phi_{L,uw}$)", # Here the user will have to manually change the row names based on the weighting functions used.
                               "Vis. spectrum ($\\phi_{L,vis}$)", 
                               "Photopic lum. ($\\phi_{L,pl}$)", 
                               "Universal lum. ($\\phi_{L,univ}$)")


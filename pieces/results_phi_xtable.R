# Loading data by executing spd_metric_calcs.R script
source("Data/spd_metric_calcs.R")

# Creates a list of lamps for reporting of results based on the original data loaded in the .rnw file.
lamp_list_for_results <-  paste("lamp_", lamp_list, sep = "")

# Creates a list of weighting functions for reporting of results based on the original data loaded in the .rnw file.
wf_list_for_results <- paste("wf_", wf_list, sep = "")

# Filtering spd_metrics data frame to extract phi data.
results_phi <- spd_metrics %>%
  dplyr::select(lamp_name, wf_name, phi_agg) %>%
  dplyr::filter(lamp_name %in% lamp_list_for_results & wf_name %in% wf_list_for_results)

# Uses xtable function to generate table

results_phi_table <- xtable::xtable(results_phi)

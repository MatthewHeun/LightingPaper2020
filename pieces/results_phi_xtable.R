# Loading data by executing spd_metric_calcs.R script
source("Data/spd_metric_calcs.R")

# Creates a list of lamps for reporting of results
lamp_list_for_phi <- c("lamp_inc_globe_a19_40w", "lamp_hps_phil", "lamp_cfl_es_tw_9", "lamp_led_phil_a19")

# Creates a list of weighting functions for reporting of results
wf_list_for_phi <- c("wf_nw", "wf_v", "wf_p2", "wf_u")

# Filtering spd_metrics data frame to extract phi data.
results_phi <- spd_metrics %>%
  dplyr::select(lamp_name, wf_name, phi_agg) %>%
  dplyr::filter(lamp_name %in% lamp_list_for_etas & wf_name %in% wf_list_for_etas)

# Uses xtable function to generate table

results_phi-table <- xtable::xtable(results_phi)

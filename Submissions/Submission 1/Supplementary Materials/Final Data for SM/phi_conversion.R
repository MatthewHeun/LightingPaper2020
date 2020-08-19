source("Data/spd_metric_calcs.R")

# This script creates data frames for the exergy-to-energy factor for each lamps,
# the mean for each lamp type, and the mean across all lamps.

# Creates a DF with phi_agg values from spd_metrics for the photopic luminosity function
p2_phi_df <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_p2") %>%
  dplyr::select(lamp_name, lamp_type, phi_agg)


# Creates a DF by lamp_type
phi_p2_mean_by_lamp_type <- p2_phi_df %>% 
  dplyr::filter(lamp_type %in% c("INC", "HAL", "HPS", "MH", "CFL", "LED")) %>% 
  dplyr::group_by(lamp_type) %>% 
  dplyr::summarise(
    count = dplyr::n(),
    mean_phi_p2 = mean(phi_agg),
    sd_phi_p2 = sd(phi_agg), 
    .groups = "drop"
  )

# Creates a DF with the overall stats
overall_phi <- p2_phi_df %>%
  dplyr::summarise(phi_count = dplyr::n(),
                   phi_mean = mean(phi_agg),
                   phi_sd = sd(phi_agg)
                   )


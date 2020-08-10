source("Data/spd_metric_calcs.R")

# Creates a DF with phi_agg values from spd_metrics for the photopic luminosity function

p2_phi_df <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_p2") %>%
  dplyr::select(lamp_name, lamp_type, phi_agg) %>%
  dplyr::mutate(phi_p2_mean = mean(phi_agg)) %>%
  dplyr::mutate(phi_p2_sd = sd(phi_agg))

phi_p2_mean_by_lamp_type <- p2_phi_df %>% 
  dplyr::filter(lamp_type %in% c("INC", "HAL", "HPS", "MH", "CFL", "LED")) %>% 
  dplyr::group_by(lamp_type) %>% 
  dplyr::summarise(
    count = dplyr::n(),
    mean_phi_p2 = mean(phi_agg),
    sd_phi_p2 = sd(phi_agg), 
    .groups = "drop"
  )


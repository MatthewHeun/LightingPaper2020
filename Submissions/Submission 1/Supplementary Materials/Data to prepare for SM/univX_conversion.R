source("Data/spd_metric_calcs.R")

univ_etaX_df <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_u") %>%
  dplyr::select(lamp_name, wrpX_div_ec)

p2_etaX_df <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_p2") %>%
  dplyr::select(lamp_name, wrpX_div_ec)

lamptype_info <- lamp_info %>%
  dplyr::select(lamp_name, `Lamp type`)

# Put all major calculations in a single piped sequence for clarity.
etaX_ratios <- lamptype_info %>% 
  dplyr::full_join(p2_etaX_df, by = "lamp_name") %>% 
  dplyr::full_join(univ_etaX_df, by = "lamp_name") %>% 
  magrittr::set_colnames(c("lamp_name", "lamp_type","eta_Xp2","eta_Xu")) %>% 
  dplyr::mutate(
    conv_etaX_univ = eta_Xu / eta_Xp2
  ) %>% 
  dplyr::filter(!is.na(eta_Xu))

# Now calculate stats in separate data frames using summarise.
# These data frames can be more-easily converted to a printable table via xtable.
overall_stats_X <- etaX_ratios %>%
  dplyr::summarise(
    count = dplyr::n(),
    mean_conv = mean(conv_etaX_univ),
    sd_conv = sd(conv_etaX_univ), 
    .groups = "drop"
  )

lamp_type_stats_X <- etaX_ratios %>% 
  dplyr::group_by(lamp_type) %>% 
  dplyr::summarise(
    count = dplyr::n(),
    mean_conv = mean(conv_etaX_univ),
    sd_conv = sd(conv_etaX_univ), 
    .groups = "drop"
  )

lamps_in_paper_stats_X <- etaX_ratios %>% 
  dplyr::filter(lamp_type %in% c("INC", "HAL", "HPS", "MH", "CFL", "LED")) %>% 
  dplyr::group_by(lamp_type) %>% 
  dplyr::summarise(
    count = dplyr::n(),
    mean_conv = mean(conv_etaX_univ),
    sd_conv = sd(conv_etaX_univ), 
    .groups = "drop"
  )


  
  

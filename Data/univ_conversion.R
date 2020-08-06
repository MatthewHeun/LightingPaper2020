source("Data/spd_metric_calcs.R")

# Eta photopic to universal conversion factor 

# univ_eta_df <- spd_metrics %>%
#   dplyr::filter(wf_name == "wf_u") %>%
#     dplyr::select(lamp_name, wrp_div_ec)
# 
# p2_eta_df <- spd_metrics %>%
#   dplyr::filter(wf_name == "wf_p2") %>%
#   dplyr::select(lamp_name, wrp_div_ec)
# 
# lamptype_info <- lamp_info %>%
#   dplyr::select(lamp_name, `Lamp type`)
# 
# conversion_eta_df <- dplyr::full_join(lamptype_info, p2_eta_df, by = "lamp_name")
# 
# conversion_eta_df <- dplyr::full_join(conversion_eta_df, univ_eta_df, by = "lamp_name")
# 
# colnames(conversion_eta_df) <- c("lamp_name", "lamp_type","eta_p2","eta_u")
# 
# conversion_eta_df <- conversion_eta_df %>%
#   dplyr::mutate(conv_eta_univ = eta_u / eta_p2)
# 
# conversion_eta_df <- conversion_eta_df %>%
#   dplyr::filter(!is.na(eta_u)) %>%
#   dplyr::mutate(
#     mean_conv = mean(conv_eta_univ),
#     sd_conv = sd(conv_eta_univ)
#   )
# 
# conversion_eta_df <- conversion_eta_df %>%
#   dplyr::group_by(lamp_type) %>%
#   dplyr::filter(!is.na(eta_u)) %>%
#   dplyr::mutate(
#     mean_lamp_conv = mean(conv_eta_univ),
#     sd_lamp_conv = sd(conv_eta_univ)
#   )

# .groups = "drop"


# Zeke:
# Here is an alternative (more concise) way to do these calculations.
# ---MKH


univ_eta_df <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_u") %>%
  dplyr::select(lamp_name, wrp_div_ec)

p2_eta_df <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_p2") %>%
  dplyr::select(lamp_name, wrp_div_ec)

lamptype_info <- lamp_info %>%
  dplyr::select(lamp_name, `Lamp type`)

# Put all major calculations in a single piped sequence for clarity.
eta_ratios <- lamptype_info %>% 
  dplyr::full_join(p2_eta_df, by = "lamp_name") %>% 
  dplyr::full_join(univ_eta_df, by = "lamp_name") %>% 
  magrittr::set_colnames(c("lamp_name", "lamp_type","eta_p2","eta_u")) %>% 
  dplyr::mutate(
    conv_eta_univ = eta_u / eta_p2
  ) %>% 
  dplyr::filter(!is.na(eta_u))

# Now calculate stats in separate data frames using summarise.
# These data frames can be more-easily converted to a printable table via xtable.
overall_stats <- eta_ratios %>%
  dplyr::summarise(
    count = dplyr::n(),
    mean_conv = mean(conv_eta_univ),
    sd_conv = sd(conv_eta_univ), 
    .groups = "drop"
  )

lamp_type_stats <- eta_ratios %>% 
  dplyr::group_by(lamp_type) %>% 
  dplyr::summarise(
    count = dplyr::n(),
    mean_conv = mean(conv_eta_univ),
    sd_conv = sd(conv_eta_univ), 
    .groups = "drop"
  )

lamps_in_paper_stats <- eta_ratios %>% 
  dplyr::filter(lamp_type %in% c("INC", "HPS", "CFL", "LED")) %>% 
  dplyr::group_by(lamp_type) %>% 
  dplyr::summarise(
    count = dplyr::n(),
    mean_conv = mean(conv_eta_univ),
    sd_conv = sd(conv_eta_univ), 
    .groups = "drop"
  )


  
  

source("Data/spd_metric_calcs.R")

# Eta photopic to universal conversion factor 

univ_eta_df <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_u") %>%
    dplyr::select(lamp_name, wrp_div_ec)

p2_eta_df <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_p2") %>%
  dplyr::select(lamp_name, wrp_div_ec)

conversion_eta_df <- dplyr::full_join(univ_eta_df, p2_eta_df, by = "lamp_name")

colnames(conversion_eta_df) <- c("lamp_name", "eta_u","eta_p2")

conversion_eta_df <- conversion_eta_df %>%
  dplyr::mutate(conv_eta_univ = eta_u / eta_p2)

lamptype_info <- lamp_info %>%
  dplyr::select(lamp_name, `Lamp type`)

conversion_eta_df <- dplyr::full_join(conversion_eta_df, lamptype_info, by = "lamp_name")

conversion_eta_df <- conversion_eta_df %>%
  dplyr::filter(!is.na(eta_u)) %>%
  dplyr::mutate(
    mean_conv = mean(conv_eta_univ),
    sd_conv = sd(conv_eta_univ)
  )

conversion_eta_df <- conversion_eta_df %>%
  dplyr::group_by(`Lamp type`) %>%
  dplyr::filter(!is.na(eta_u)) %>%
  dplyr::mutate(
    mean_lamp_conv = mean(conv_eta_univ),
    sd_lamp_conv = sd(conv_eta_univ)
  )

# .groups = "drop"
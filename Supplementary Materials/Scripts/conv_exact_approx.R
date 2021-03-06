source("Data/univX_conversion.R")
source("Data/univ_conversion.R")

# This script constructs a DF which contains information for the
# three methods of assessing final-to-useful exergy efficiency (results_cea).
# Then creates a table containing this information (results_cea_table).
# The three methods being the following:
# 1) The conventional method which reports the luminous efficiency = eta_p2
# 2) The exact method which reports eta_X,u = eta_u * phi_u
# 3) The approximate method which reports eta_X,U,approx = eta_p2 * phi_all * gamma_u_u (the conversion factor)

# Creates the intial DF containing the conventional method, 
# with data taken from spd_metrics as opposed to lamp_info 
results_conventional <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_p2" & lamp_name %in% lamp_list) %>%
  dplyr::select(lamp_name, lamp_type, wrp_div_ec_100) %>%
  magrittr::set_colnames(c("lamp_name","lamp_type", "eta_p2"))

# Creates a DF containing data for the exact method eta_X,u
results_exact <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_u" & lamp_name %in% lamp_list) %>%
  dplyr::select(lamp_name, wrpX_div_ec_100) %>%
  magrittr::set_colnames(c("lamp_name", "eta_Xu"))

# Creates a DF containing data for the approximate method
results_approximate <- spd_metrics %>%
  dplyr::filter(wf_name == "wf_p2" & lamp_name %in% lamp_list) %>%
  dplyr::select(lamp_name, wrp_div_ec_100, phi_all) %>%
  magrittr::set_colnames(c("lamp_name", "eta_p2", "phi_all")) %>%
  dplyr::mutate("gamma_E_u" = overall_stats$mean_conv) %>%
  dplyr::mutate("eta_X_u_approx" = eta_p2 * phi_all * gamma_E_u)

# Creates the combined DF
results_cea <- results_conventional %>%
  dplyr::full_join(results_exact, by = "lamp_name") %>%
  dplyr::full_join(
    results_approximate %>% dplyr::select(lamp_name, eta_X_u_approx),
    by = "lamp_name")

# Removes the lamp_name 
results_cea$lamp_name <- NULL

# Identifies column names 
info_cea_colnames <- results_cea$lamp_type

# Transposes the combined DF
results_cea_table <- as.data.frame(t(results_cea[,-1]))

# Sets column names 
colnames(results_cea_table) <- info_cea_colnames

# Re-orders columns
results_cea_table <- results_cea_table[,c("INC","HAL","CFL","LED")]

# Set rownames
results_cea_table <- magrittr::set_rownames(results_cea_table, 
                                            c("Conventional method ($\\eta_{E,pl}$)", 
                                              "Exact method ($\\eta_{X,univ}$)", 
                                              "Approximate method (Equation~\\ref{eq:approximate_unknown_tech})"))




# This script calculates the radiant power for each lamp output and the weighted radiant power for each pair (lamp, weighting function)
# doing the integral by wavelength

# Loading data by executing AllData.R script
source("Data/AllData.R")


# Calculating the integral of radiant power for each lamp
integration_radiant_power <- weighted_responses_df %>%
  dplyr::select("Wavelength [nm]", lamp_name, wf_name, actual_radiant_power, actual_exergy) %>%
  dplyr::filter(!is.na(actual_radiant_power)) %>%
  dplyr::distinct(dplyr::across(c(lamp_name, "Wavelength [nm]")), .keep_all = TRUE) %>%
  dplyr::group_by(lamp_name) %>%
  dplyr::summarise(
    integrated_rp = MESS::auc(x = `Wavelength [nm]`, y = actual_radiant_power),
    integrated_rp_X = MESS::auc(x = `Wavelength [nm]`, y = actual_exergy),
    rp_X_div_rp = integrated_rp_X / integrated_rp
  )


# Calculating the integral of weighted radiant power for each couple (lamp, weighting function)
integration_weighted_radiant_power <- weighted_responses_df %>%
  dplyr::select("Wavelength [nm]", lamp_name, wf_name, actual_radiant_power, actual_weighted_radiant_power, actual_weighted_exergy, actual_exergy) %>%
  dplyr::filter(!is.na(actual_weighted_radiant_power)) %>%
  dplyr::group_by(lamp_name, wf_name) %>%
  dplyr::summarise(
    integrated_wrp = MESS::auc(x = `Wavelength [nm]`, y = actual_weighted_radiant_power),
    integrated_rp = MESS::auc(x = `Wavelength [nm]`, y = actual_radiant_power),
    integrated_rp_X = MESS::auc( x = `Wavelength [nm]`, y = actual_exergy),
    integrated_wrp_X = MESS::auc(x = `Wavelength [nm]`, y = actual_weighted_exergy),
    wrp_X_div_wrp = integrated_wrp_X / integrated_wrp,
    wrp_div_rp = integrated_wrp / integrated_rp,
    rp_X_div_rp = integrated_rp_X / integrated_rp
  )


# Adds the electricity consumption of each lamp to a new data frame entitled "spd_metrics".
spd_metrics <- dplyr::full_join(
  integration_weighted_radiant_power, 
  lamp_info %>% dplyr::select(lamp_name, `Electricity Consumption [W]`), by = "lamp_name"
) %>%
    
# Calculates the quotient of the weighted radiant power and electricity consumption - valuable energy efficiency
dplyr::mutate(
  wrp_div_ec = integrated_wrp / `Electricity Consumption [W]`
) %>%

# Calculates the product of wrp_div_ec and 100, yielding the % final to useful efficiency
dplyr::mutate(
  wrp_div_ec_100 = wrp_div_ec*100
) %>%
    
# Calculates the quotient of the weighted radiant power and radiant power
dplyr::mutate(
  wrp_div_rp = integrated_wrp / integrated_rp
) %>%

# Calculates the product of wrp_div_rp and 100
dplyr::mutate(
  wrp_div_rp_100 = wrp_div_rp*100
) %>%

# Calculates the aggregate exergy to energy factor
dplyr::mutate(
  phi_agg = integrated_wrp_X / integrated_wrp
)



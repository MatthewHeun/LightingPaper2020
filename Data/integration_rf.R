
# This script calculates the radiant flux for each lamp output and the weighted radiant flux for each pair (lamp, weighting function)
# doing the integral by wavelength

# Loading data by executing AllData.R script
source("Data/AllData.R")


# Calculating the integral of radiant flux for each lamp
integration_radiant_flux <- weighted_responses_df %>%
  dplyr::select("Wavelength [nm]", lamp_name, wf_name, actual_radiant_flux) %>%
  dplyr::filter(!is.na(actual_radiant_flux)) %>%
  dplyr::distinct(dplyr::across(c(lamp_name, "Wavelength [nm]")), .keep_all = TRUE) %>%
  dplyr::group_by(lamp_name) %>%
  dplyr::summarise(
    integrated_rf = MESS::auc(x = `Wavelength [nm]`, y = actual_radiant_flux)
  )


# Calculating the integral of weighted radiant flux for each couple (lamp, weighting function)
integration_weighted_radiant_flux <- weighted_responses_df %>%
  dplyr::select("Wavelength [nm]", lamp_name, wf_name, actual_radiant_flux, actual_weighted_radiant_flux) %>%
  dplyr::filter(!is.na(actual_weighted_radiant_flux)) %>%
  dplyr::group_by(lamp_name, wf_name) %>%
  dplyr::summarise(
    integrated_wrf = MESS::auc(x = `Wavelength [nm]`, y = actual_weighted_radiant_flux),
    integrated_rf = MESS::auc(x = `Wavelength [nm]`, y = actual_radiant_flux)
  )



weighted_responses_df %>% dplyr::filter(lamp_name == "lamp_cfl_es_tw",
                                        is.na(actual_weighted_radiant_flux),
                                        !is.na(actual_radiant_flux)) %>%
  print()

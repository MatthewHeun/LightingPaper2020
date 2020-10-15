# AllData script

# This script pulls data from the master_lighting_data.xlsx spreadsheet and builds a massive data frame
# containing weighting functions, lamps, and weighted emission spectra.
# Weighting function tabs are prefixed with "wf_".
# Lamp tabs are prefixed with "lamp_".
library(magrittr)

# Here we establish the lamp_list and wf_list.
# The user should alter this list with the lamps and weighting functions 
# they wish to assess from the master_lighting_data.xlsx spreadsheet lamp_name column.
wf_list <- c(Unweighted = "wf_nw", Visible = "wf_v",
             Photopic = "wf_p2", Universal = "wf_u")
lamp_list <- c(INC = "lamp_inc_syl_a19_2476k", HAL = "lamp_hal_syl_par38", 
               CFL = "lamp_cfl_es_tw_15", LED = "lamp_led_es_br30")


# Main code
weighted_power <- function(weighting_function, lamp) {
  # Get name of lamp
  wf_name <- weighting_function[["wf_name"]] %>%
    unique()
  if (length(wf_name) != 1) {
    stop(paste("Got more than 1 weighting function:", wf_name))
  }
  
  # Interpolate weighting function at each lamp wavelength
  interpolated_wf <- stats::approx(x = weighting_function[["Wavelength [nm]"]], 
                                   y = weighting_function[["normalized_response"]], 
                                   xout = lamp[["Wavelength [nm]"]]) %>%
    data.frame() %>%
    dplyr::mutate(
      wf_name = wf_name
    ) %>%
    magrittr::set_colnames(colnames(weighting_function))
  
  # Multiply lamp's received radiative power by interpolated weighting function at each wavelength
  dplyr::full_join(lamp, interpolated_wf, by = "Wavelength [nm]") %>%
    dplyr::mutate(
      received_weighted_radiant_power = received_radiative_power * normalized_response
    )
}

# Get names of all tabs in a list
master_lighting_data_path <- file.path("Data", "master_lighting_data.xlsx") # Here the user should replace "Data" with their own specific file path
tabs <- readxl::excel_sheets(path = master_lighting_data_path)

# Get the weighting functions list
wf_tabs <- tabs[startsWith(tabs, prefix = "wf_")]

# Get lamps list
lamp_tabs <- tabs[startsWith(tabs, prefix = "lamp_")]

# Pull data from each tab and combine data frames
wf_data <- lapply(wf_tabs, FUN = function(tab_name){
  DF <- readxl::read_excel(master_lighting_data_path, sheet = tab_name)
  cnames <- colnames(DF)
  cnames[[2]] <- "response"
  DF <- DF %>%
    magrittr::set_colnames(cnames)
  DF %>%
    dplyr::mutate(
      normalized_response = response / max(response), 
      response = NULL, 
      wf_name = tab_name
    )
})

lamp_data <- lapply(lamp_tabs, FUN = function(tab_name){
  DF <- readxl::read_excel(master_lighting_data_path, sheet = tab_name)
  cnames <- colnames(DF)
  cnames[[2]] <- "received_radiative_power"
  DF <- DF %>%
    magrittr::set_colnames(cnames)
  DF %>%
    dplyr::mutate(
      lamp_name = tab_name
    )
  DF %>%
    dplyr::mutate(
      normalised_rrp = received_radiative_power / max(received_radiative_power),
      lamp_name = tab_name
    )
}) %>% 
  magrittr::set_names(lamp_tabs)

weighted_responses_list <- list()

for (l in lamp_data) {
  # Apply all weighting functions
  for (wf in wf_data) {
    res <- weighted_power(weighting_function = wf, lamp = l)
    weighted_responses_list <- rlist::list.append(weighted_responses_list, res)
  }
}

 
received_weighted_responses_df <- dplyr::bind_rows(weighted_responses_list) %>%
  dplyr::mutate(
   normalized_response = tidyr::replace_na(normalized_response, 0),
   received_weighted_radiant_power = received_radiative_power * normalized_response
  )
 
# Checking whether there are still NAs in weighted radiant power
# received_weighted_responses_df %>% dplyr::filter(is.na(received_weighted_radiant_power)) %>% print()


# This data frame represents the integrals calculated from the received data, 
# which we know is wrong. 
# But we use this calculation as the starting point for fixing the responses.
# Extract wrong luminous power from relative intensities

# This picks up the standard photopic luminosity function
received_luminous_power <- received_weighted_responses_df %>%
  dplyr::filter(wf_name == "wf_p2", !is.na(normalized_response)) %>%
  dplyr::group_by(lamp_name) %>%
  dplyr::summarise(
   #sum = sum(weighted_radiant_power*683), 
    wrong_luminous_power = MESS::auc(x = `Wavelength [nm]`, y = received_weighted_radiant_power) * 683, .groups = "drop"
  )

# Read in lamp information
lamp_info <- readxl::read_excel(master_lighting_data_path, sheet = "data_lamp") %>%
  dplyr::mutate(
    luminous_power = `Luminous efficacy [lm/W]` * `Electricity consumption [W]`
  )

# Combines the lamp information from manufacturer (lamp_info)
# with luminous efficacies calculated from SPD (received_luminous_power)
comp_power_df <- dplyr::full_join(lamp_info, received_luminous_power, by = "lamp_name") %>%

# Calculates the scaling factor 
  dplyr::mutate(
    scaling_factor = luminous_power / wrong_luminous_power
)


# Calculating photon temperature and phi values per wavelength

# Sets the photon effective temperature constant
pet_const = 5.33016e-3

# Sets T_0, the temperature of the body receiving the radiative energy transfer, 
# in this case the temperature of the human body
T_0 = 310

# Creates a data frame, including calculation of phi_L_lambda, the wavelength specific exergy-energy ratio
energy_to_exergy_df <- tibble::tibble(
  `Wavelength [nm]` = seq(from = 200, to = 1000, by = 0.5),
  `Wavelength [m]` = `Wavelength [nm]` * 1e-9,
  T_lambda = pet_const / `Wavelength [m]`,
  phi_L_lambda = 1 - (4/3)*(T_0/T_lambda) + (1/3)*(T_0/T_lambda)^4
)



# Join comp_power_df to received_weighted_responses DF,
# Add a column for the actual radiant power,
# the actual weighted radiant power
# the actual exergy, and
# the actual weighted exergy
weighted_responses_df <- dplyr::full_join(
  received_weighted_responses_df, 
  comp_power_df %>% dplyr::select(lamp_name, scaling_factor), by = "lamp_name"
) %>%
  dplyr::mutate(
    actual_radiant_power = received_radiative_power * scaling_factor,
    actual_weighted_radiant_power = actual_radiant_power * normalized_response
  ) %>%
  dplyr::left_join(energy_to_exergy_df %>% dplyr::select(c(`Wavelength [nm]`, phi_L_lambda)),
                   by = "Wavelength [nm]") %>%
  dplyr::mutate(
    actual_weighted_exergy = actual_weighted_radiant_power * phi_L_lambda,
    actual_exergy = actual_radiant_power * phi_L_lambda
  ) %>%
# Creates normalised data to be plotted
  dplyr::mutate(
    normalised_awrp = normalised_rrp * normalized_response,
    normalised_awe = normalised_awrp * phi_L_lambda
  )







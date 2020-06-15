# AllData script

# This script pulls data from the master_lighting_data.xlsx spreadsheet and builds a massive data frame
# containing weighting functions, lamps, and weighted emission spectra.
# Weighting function tabs are prefixed with "wf_".
# Lamp tabs are prefixed with "lamp_".


# Main code
weighted_flux <- function(weighting_function, lamp) {
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
  
  # Multiply lamp's received radiative flux by interpolated weighting function at each wavelength
  dplyr::full_join(lamp, interpolated_wf, by = "Wavelength [nm]") %>%
    dplyr::mutate(
      received_weighted_radiant_flux = received_radiative_flux * normalized_response
    )
}

# Get names of all tabs in a list
master_lighting_data_path <- file.path("Data", "master_lighting_data.xlsx")
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
  cnames[[2]] <- "received_radiative_flux"
  DF <- DF %>%
    magrittr::set_colnames(cnames)
  DF %>%
    dplyr::mutate(
      lamp_name = tab_name
    )
})

weighted_responses_list <- list()

for (l in lamp_data) {
  # Apply all weighting functions
  for (wf in wf_data) {
    res <- weighted_flux(weighting_function = wf, lamp = l)
    weighted_responses_list <- rlist::list.append(weighted_responses_list, res)
  }
}

 
received_weighted_responses_df <- dplyr::bind_rows(weighted_responses_list) %>%
  dplyr::mutate(
   normalized_response = tidyr::replace_na(normalized_response, 0),
   received_weighted_radiant_flux = received_radiative_flux * normalized_response
  )
 
#Checking whether there are still NAs in weighted radiant flux
#received_weighted_responses_df %>% dplyr::filter(is.na(received_weighted_radiant_flux)) %>% print()


# This data frame represents the integrals calculated from the received data, 
# which we know is wrong. 
# But we use this calculation as the starting point for fixing the responses.
# Extract wrong luminous fluxes from relative intensities

# This picks up the standard photopic luminosity function
received_luminous_flux <- received_weighted_responses_df %>%
  dplyr::filter(wf_name == "wf_p2", !is.na(normalized_response)) %>%
  dplyr::group_by(lamp_name) %>%
  dplyr::summarise(
   #sum = sum(weighted_radiant_flux*683), 
    wrong_luminous_flux = MESS::auc(x = `Wavelength [nm]`, y = received_weighted_radiant_flux) * 683, .groups = "drop"
  )

# Read in lamp information
lamp_info <- readxl::read_excel(master_lighting_data_path, sheet = "data_lamp") %>%
  dplyr::mutate(
    luminous_flux = `Luminous Efficacy [lm/W]` * `Electricity Consumption [W]`
  )

# Combines the lamp information from manufacturer (lamp_info)
# with luminous efficacies calculated from SPD (received_luminous_flux)
comp_flux_df <- dplyr::full_join(lamp_info, received_luminous_flux, by = "lamp_name") %>%

# Calculates the scaling factor 
  dplyr::mutate(
    scaling_factor = luminous_flux / wrong_luminous_flux
)

# Join comp_flux_df to received_weighted_responses DF,
# Add a column for the actual radiant flux and
# add a column for the actual weighted radiant flux
weighted_responses_df <- dplyr::full_join(
  received_weighted_responses_df, 
  comp_flux_df %>% dplyr::select(lamp_name, scaling_factor), by = "lamp_name"
) %>%
  dplyr::mutate(
    actual_radiant_flux = received_radiative_flux * scaling_factor,
    actual_weighted_radiant_flux = actual_radiant_flux * normalized_response
  )


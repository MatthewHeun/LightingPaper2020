# AllData script

# This script pulls data from the master_lighting_data.xlsx spreadsheet and builds a massive data frame
# containing weighting functions, lamps, and weighted emission spectra.
# Weighting function tabs are prefixed with "wf_".
# Lamp tabs are prefixed with "lamp_".

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

  # Multiply lamp's radiative flux by interpolated weighting function at each wavelength
  dplyr::full_join(lamp, interpolated_wf, by = "Wavelength [nm]") %>% 
    dplyr::mutate(
      weighted_radiant_flux = radiative_flux * normalized_response
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
  cnames[[2]] <- "radiative_flux"
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

weighted_responses_df <- dplyr::bind_rows(weighted_responses_list)







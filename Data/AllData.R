# AllData script

# This script pulls data from the master_lighting_data.xlsx spreadsheet and builds a massive data frame
# containing weighting functions and lamps.
# Weighting function tabs are prefixed with "wf_".
# Lamp tabs are prefixed with "lamp_".


# Get names of all tabs in a list
master_lighting_data_path <- file.path("Data", "master_lighting_data.xlsx")
tabs <- readxl::excel_sheets(path = master_lighting_data_path)

# Get the weighting functions list
wf_tabs <- tabs[startsWith(tabs, prefix = "wf_")]

# Get lamps list
lamp_tabs <- tabs[startsWith(tabs, prefix = "lamp_")]

# Pull data from each tab
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
}) %>%
  dplyr::bind_rows()


lamp_data <- lapply(lamp_tabs, FUN = function(tab_name){
  DF <- readxl::read_excel(master_lighting_data_path, sheet = tab_name)
  cnames <- colnames(DF)
  cnames[[2]] <- "radiative_flux"
  DF <- DF %>%
    magrittr::set_colnames(cnames)
  DF %>%
    dplyr::mutate(
      wf_name = tab_name
    )
}) %>%
  dplyr::bind_rows()

# Combine in one big data frame






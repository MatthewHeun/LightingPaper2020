
# Creates a file path for the lighting efficacy data
lighting_efficacy_data_path <- file.path("Data", "Lighting_Efficacy_Data.xlsx")

# Creates a list of all the tabs in in the Lighting_Efficacy_Data workbook
all_tabs <- readxl::excel_sheets(path = lighting_efficacy_data_path)

# Creates a list of the tabs which contain lighting efficacy data
le_tabs <- all_tabs[startsWith(all_tabs, prefix = "le_")]

# Pulls the data from each lighting efficacy tab

le_data <- lapply(le_tabs, FUN = function(tab_name){
  DF <- readxl::read_excel(lighting_efficacy_data_path, sheet = tab_name)})

# Combines the data into a single data frame
le_df <- dplyr::bind_rows(le_data) 

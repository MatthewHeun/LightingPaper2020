# This script formats the lamp info data into a table for rnw file.
source("Data/AllData.R")

# Filters and selects the lamps in lamp_info. 
results_lamp_info <- lamp_info %>%
  dplyr::filter(lamp_name %in% lamp_list) %>%
  dplyr::select(lamp_name, `Lamp type`, Description, Year, 
                `Luminous efficacy [lm/W]`, 
                `Electricity consumption [W]`,
                `Lumen output [lm]`,
                `Luminous efficiency [%]`)

# Removes lamp info column after ordering
results_lamp_info <- results_lamp_info[,-1]

# Sets luminous efficiency column to 2dp
results_lamp_info[,"Luminous efficiency [%]"] = round(results_lamp_info[,"Luminous efficiency [%]"],2)

# Identifies transposed column names 
info_colnames <- results_lamp_info$`Lamp type`

# Re-arranges into the correct orientation
results_lamp_info_fin <- as.data.frame(t(results_lamp_info[,-1]))
colnames(results_lamp_info_fin) <- info_colnames

# Re-orders columns
# results_lamp_info_fin <- results_lamp_info_fin[c(1,2,3,4),]
# This code creates a table in which the lamp columns are in the same order
# as are called within the lamp_list in the AllData.R script. 
# Uncomment the above code to change if required.





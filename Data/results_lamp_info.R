# This script formats the lamp info data into a table for rnw file.
source("Data/AllData.R")
# Creates a list of lamps for reporting of results based on the original data loaded in the .rnw file.
# These lamps differ to the lamp data used for the analysis, 
# some of which are rescaled, and so have different codes and lamp info data.
lamp_list_for_info <-  c("lamp_inc_syl_a21",
                            "lamp_hps_phil",
                            "lamp_cfl_es_tw_15",
                            "lamp_led_es_br30")

# Filters and selects the lamps in lamp_info. 
results_lamp_info <- lamp_info %>%
  dplyr::filter(lamp_name %in% lamp_list_for_info) %>%
  dplyr::select(lamp_name, `Lamp type`, Description, Year, 
                `Luminous efficacy [lm/W]`, 
                `Electricity consumption [W]`, 
                `Luminous efficiency [%]`)

# Re-arranges the rows into the correct order
results_lamp_info <- results_lamp_info[c(1,4,2,3),]

# Removes lamp info column after ordering
results_lamp_info <- results_lamp_info[,-1]

# Sets luminous efficiency column to 2dp
results_lamp_info[,"Luminous efficiency [%]"] = round(results_lamp_info[,"Luminous efficiency [%]"],2)

# Identifies transposed column names 
info_colnames <- results_lamp_info$`Lamp type`

# Re-arranges into the correct orientation
results_lamp_info_fin <- as.data.frame(t(results_lamp_info[,-1]))
colnames(results_lamp_info_fin) <- info_colnames






# This function reads the SEA lighting efficiency data in pre-prepared in panel data format.
library(readxl)
sea_le_df <- SEA_lighting_efficiency <- read_excel("Data/SEA_lighting_efficiency.xlsx", 
                                      sheet = "SEA_le_panel")